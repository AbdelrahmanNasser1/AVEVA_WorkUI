using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Skelta.Forms.Core.Controls;
using System.IO;
using Skelta.Repository;
using Skelta.Repository.List.ListInfoExtractor;
using Skelta.Repository.Web.List;
using Workflow.NET;
using System.Globalization;
using Skelta.Forms.Core.CommonObjects;

public partial class FormImport : System.Web.UI.Page
{
    string cacheKey = string.Empty;
    string listName = "Forms List";
    ListPageParameters resolver = null;
    string formMode = string.Empty;
    string versionStamp = string.Empty;
    string applicationName = string.Empty;
    string loggedInUserId = string.Empty;
    protected Workflow.NET.SkeltaResourceSetManager resManager = new Workflow.NET.SkeltaResourceSetManager();
    ISkeltaResourceSet resourceSet = new SkeltaResourceSetManager().GlobalResourceSetForNextGenForms;

    protected void Page_Load(object sender, EventArgs e)
    {
        resolver = new ListPageParameters();
        resolver.ResolveCurrentUri();
        cacheKey = resolver.ListItemId.ToString();
        versionStamp = resolver.VersionStamp;
        applicationName = resolver.ApplicationName;
        loggedInUserId = resolver.LoggedInUserId;
        btnCancel.Text = resourceSet.GetString("FormNGFBtnCancel");
    }

    protected void btnImport_Click(object sender, EventArgs e)
    {
        BaseForm newDefinition;
        StreamReader reader = null;
        bool isFormTypeMismatch = false;
        Log logger = new Log();

        if (!string.IsNullOrEmpty(filepath.Value))
        {
            XmlDocument xmlDoc = new XmlDocument();
            try
            {
                ListInfoExtractor listInfoExtractor = new ListInfoExtractor();
                reader = new StreamReader(this.Context.Request.Files.Get(0).InputStream);
                string importedFormDefinitionXml = reader.ReadToEnd();
                xmlDoc.PreserveWhitespace = true;
                xmlDoc.LoadXml(importedFormDefinitionXml);
                BaseForm currentForm;
                Skelta.Forms.Web.CommonFunctions.ValidateCachedForm(this.cacheKey, this.versionStamp, out currentForm, this.listName);
                string newDefinitionString = xmlDoc.InnerXml;
                newDefinition = BaseForm.LoadDefinitionXml(newDefinitionString);

                // check if form definition has unsupported attachment controls based on platform type
                if (Workflow.NET.CommonFunctions.FormDefinitionHasUnsupportedAttachment(xmlDoc))
                {
                    throw new Exception("NotSupportedAttachment");
                }

                if (currentForm.ProductVersion == newDefinition.ProductVersion)
                {
                    using (var transactionScope = Workflow.NET.CommonFunctions.GetNewTransactionScope())
                    {
                        var formTitleAndVersionDetails = Skelta.Forms2.Web.CommonFunctions.GetFormTitleAndVersionDetails(this.applicationName, this.cacheKey);

                        if (string.IsNullOrEmpty(this.versionStamp))
                        {
                            this.versionStamp = formTitleAndVersionDetails.Item2;
                        }

                        var formTitle = formTitleAndVersionDetails.Item1; // InvokeWorkflowEventAssociationUtility.GetItemTitle(listInfoExtractor, logger, new Guid(this.cacheKey), this.applicationName, this.listName);

                        if (!string.IsNullOrEmpty(newDefinitionString) && InvokeWorkflowEventAssociationUtility.IsInvokeWorkflowControlPresent(newDefinitionString))
                        {
                            newDefinitionString = InvokeWorkflowEventAssociationUtility.UpdateFormDefinitionForInvokeWorkflow(xmlDoc.InnerXml, string.Empty, formTitle, this.versionStamp);
                        }

                        this.HandlesEventAssociationEntriesForInvokeWorflow(listInfoExtractor, logger, currentForm, newDefinitionString, this.applicationName, this.loggedInUserId);

                        #region Handling NGF import from previous release to current release
                        {
                            if (newDefinition.FormMode == EFormMode.NextGenMode)
                            {
                                string importedBuildVersionString = string.IsNullOrEmpty(newDefinition.BuildVersion) ? "00000000" : newDefinition.BuildVersion;

                                if (importedBuildVersionString.Length == 7)
                                {
                                    importedBuildVersionString += "0";
                                }

                                int importedDefinitionBuildVersion = Convert.ToInt32(importedBuildVersionString, CultureInfo.InvariantCulture);

                                string buildVersionString = Skelta.Forms.Web.CommonFunctions.GetLocalDataSourceVersion(applicationName);
                                string currentBuildVersionString = (buildVersionString.Length == 7) ? buildVersionString + "0" : buildVersionString;

                                int currentBuildVersion = Convert.ToInt32(currentBuildVersionString, CultureInfo.InvariantCulture);

                                if (importedDefinitionBuildVersion < currentBuildVersion)
                                {
                                    newDefinition = Workflow.NET.FormsUtility.UpdateNextGenFormDefinition(newDefinition, buildVersionString);
                                    newDefinition.BuildVersion = buildVersionString;
                                }
                            }
                        }
                        #endregion

                        newDefinition.TopLevelForm.FormTitle = formTitle;
                        List<object> controlList = new List<object>(Skelta.Forms2.Web.CommonFunctions.GetNextGenControlsList(applicationName, new List<string>()));
                        if (Skelta.Forms2.Web.CommonFunctions.IsCustomControlExists(newDefinition, controlList))
                        {
                            string errorMessage = string.Empty;

                            if (!Skelta.Forms.Web.CommonFunctions.UpdateDefinitionToDBAndValidateCache(this.cacheKey, this.versionStamp, newDefinition, this.listName, out errorMessage))
                            {
                                msgDiv.Attributes["style"] = "color:#d81c3f;padding-left:15px;";
                                msgDiv.InnerHtml = errorMessage;

                                return;
                            }
                        }

                        transactionScope.Complete();
                    }
                }
                else
                {
                    isFormTypeMismatch = true;
                }

                if (!isFormTypeMismatch)
                {
                    btnCancel.Text = resourceSet.GetString("FormControlButtonCloseText");
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "RefreshParent", "<script> RefreshFormsDesigner();</script>");
                    var strMessage = resourceSet.GetString("FormNGFImportXMLSuccess").Replace("<@filename@>", System.Web.HttpUtility.HtmlEncode(filepath.Value));
                    msgDiv.Attributes["style"] = "color:#009530;padding-left:15px;";
                    msgDiv.InnerHtml = strMessage;
                }
                else
                {
                    var strMessage = resourceSet.GetString("FormProductVersionMismatch").Replace("<@filename@>", System.Web.HttpUtility.HtmlEncode(filepath.Value));
                    msgDiv.Attributes["style"] = "color:#d81c3f;padding-left:15px;";
                    msgDiv.InnerHtml = strMessage;
                }

                reader.Close();

            }
            catch (CustomControlNotSupportedException ex)
            {
                var strMessage = resourceSet.GetString("FormNGFImportXMLError").Replace("<@filename@>", filepath.Value);
                var strInfoMessage = resourceSet.GetString("FormNGFCustomContolNotSupportedMessage");
                logger.LogError(ex, strInfoMessage);
                msgDiv.Attributes["style"] = "color:#d81c3f;padding-left:15px;";
                msgDiv.InnerHtml = strMessage + "<br>" + strInfoMessage;
            }
            catch (CustomControlNotFoundException ex)
            {
                var strMessage = resourceSet.GetString("FormNGFImportXMLError").Replace("<@filename@>", filepath.Value);
                var strInfoMessage = resourceSet.GetString("FormNGFCustomContolInfoMessage");
                logger.LogError(ex, strInfoMessage);
                msgDiv.Attributes["style"] = "color:#d81c3f;padding-left:15px;";
                msgDiv.InnerHtml = strMessage + "<br>" + strInfoMessage;
            }
            catch (Exception ex)
            {
                var strMessage = ex.Message == "NotSupportedAttachment" ? resourceSet.GetString("FormErrorImportXMLNotSupportedAttachment") : resourceSet.GetString("FormNGFImportXMLError").Replace("<@filename@>", filepath.Value);
                logger.LogError(ex, strMessage);
                msgDiv.Attributes["style"] = "color:#d81c3f;padding-left:15px;";
                msgDiv.InnerHtml = strMessage;
            }
        }

    }

    /// <summary>
    /// deletes the event association entries for old form and makes new event association entries for new form for all the InvokeWorkflow controls
    /// </summary>
    /// <param name="listInfoExtractor">List Info Extractor</param>
    /// <param name="logger">log error details</param>
    /// <param name="oldBaseForm">old base form</param>
    /// <param name="newBaseFormDefinition">new form definition</param>
    /// <param name="application">Application Name</param>
    /// <param name="loggedInUserId">Logged in user id</param>
    private void HandlesEventAssociationEntriesForInvokeWorflow(IListInfoExtractor listInfoExtractor, ILog logger, BaseForm oldBaseForm, string newBaseFormDefinition, string application, string loggedInUserId)
    {
        if (this.listName == "Forms List")
        {
            MethodResponse response;
            var formTitle = InvokeWorkflowEventAssociationUtility.GetItemTitle(listInfoExtractor, logger, new Guid(this.cacheKey), application, this.listName);
            if (oldBaseForm != null)
            {
                response = InvokeWorkflowEventAssociationUtility.HandleOnFormDelete(listInfoExtractor, logger, application, loggedInUserId, oldBaseForm, formTitle, this.versionStamp);

                if (!response.Successful && response.ErrorCode != 2)
                {
                    msgDiv.Attributes["style"] = "color:#d81c3f;padding-left:15px;";
                    msgDiv.InnerHtml = response.ErrorMessage;
                }
            }

            response = InvokeWorkflowEventAssociationUtility.HandleFormImportAndFormSaveAs(listInfoExtractor, this.resManager.GlobalResourceSet, logger, application, loggedInUserId, newBaseFormDefinition, formTitle, this.versionStamp);
            if (!response.Successful && !string.IsNullOrEmpty(response.ErrorMessage))
            {
                msgDiv.Attributes["style"] = "color:#d81c3f;padding-left:15px;";
                msgDiv.InnerHtml = response.ErrorMessage;
            }

            logger.Close();

        }
    }
}