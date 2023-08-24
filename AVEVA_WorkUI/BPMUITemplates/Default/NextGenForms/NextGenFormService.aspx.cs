using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using Skelta.Forms.Core.Controls;
using Skelta.Forms.Web.Common;
using Skelta.Forms2.Web;
using Skelta.Forms2.Web.Common;
using Skelta.Forms2.Web.NextGenForms;
using Skelta.Repository.List.ListInfoExtractor;
using Skelta.Repository.Web.List;
using Workflow.NET;
using Skelta.Repository.List;
using System.Globalization;
using Workflow.NET.Attachment;
using Newtonsoft.Json;
using Skelta.Package.CodeBehind;
using Skelta.Core;
using Skelta.Repository.Security;
using Skelta.Forms2.Web.Interfaces;
using Skelta.Forms2.Web.Mqtt;
using Skelta.Forms.Core.Classes;

public partial class BPMUITemplates_Default_NextGenForms_NextGenFormService : System.Web.UI.Page
{
    private static ISkeltaResourceSet resourceSet;
    /// <summary>
    /// Gets or sets ResourceSet
    /// </summary>
    internal static ISkeltaResourceSet ResourceSet
    {
        get
        {
            if (resourceSet == null)
            {
                return new SkeltaResourceSetManager().GlobalResourceSetForNextGenForms;
            }
            else
            {
                return resourceSet;
            }
        }

        set
        {
            resourceSet = value;
        }
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string GetAttachedFileInfo(string securedValue, string userId)
    {
        ////var errorData = Skelta.Forms2.Web.CommonFunctions.VerifyUserId(userId);
        ////if (!string.IsNullOrEmpty(errorData))
        ////{
        ////    return errorData;
        ////}

        Dictionary<string, string> returnValue = new Dictionary<string, string>();
        AttachmentSecuredValue securedValueObj = new AttachmentSecuredValue();
        securedValueObj.ResolveCurrentValue(securedValue);
        returnValue.Add("id", securedValueObj.Identifier.ToString());
        returnValue.Add("fileName", securedValueObj.FileName);
        return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(returnValue);
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string UpdateAttachedFileStatus(string securedValue, string applicationName, string userId, string securityMode)
    {
        ////var errorData = Skelta.Forms2.Web.CommonFunctions.VerifyUserId(userId);
        ////if (!string.IsNullOrEmpty(errorData))
        ////{
        ////    return errorData;
        ////}

        var statusChanged = false;
        Dictionary<string, bool> returnValue = new Dictionary<string, bool>();
        try
        {
            statusChanged = NextGenRenderer.UpdateAttachedFileStatus(securedValue, applicationName, securityMode);

        }
        catch (Exception)
        {
        }

        returnValue.Add("statusChanged", statusChanged);
        return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(returnValue);
    }

    /// <summary>
    /// This method will generate the view and view model for the formId, version and list name
    /// </summary>
    /// <param name="applicationName">Application Name</param>
    /// <param name="userId">User Id</param>
    /// <param name="listName">List Name</param>
    /// <param name="deviceType">Device Type</param>
    /// <param name="parentfName">Parent Form Name</param>
    /// <param name="parentfVersion">Parent Form Version</param>
    /// <param name="parentItemId">Parent Item Id</param>
    /// <param name="controlid">Control ID</param>
    /// <param name="isStaging">is call from preview</param>
    /// <returns></returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string GetViewAndViewModelForPopupFormFromFormDefinition(string applicationName, string userId, string listName, string deviceType, string parentItemId, string controlid, bool isStaging, string formDefinitionString)
    {
        Dictionary<string, string> vals = new Dictionary<string, string>();

        try
        {
            BaseForm parentForm = null;
            NextGenRenderer nextGenRenderer = new NextGenRenderer();

            if (string.IsNullOrEmpty(formDefinitionString))
            {
                vals.Add("IsSuccess", "false");
            }
            else
            {
                formDefinitionString = HttpUtility.HtmlDecode(formDefinitionString);
                BaseForm popupForm = BaseForm.LoadDefinitionXml(formDefinitionString);

                if (popupForm.TopLevelForm.RenderDetails.Get("formUniqueKey") == null)
                {
                    popupForm.TopLevelForm.RenderDetails.Add("formUniqueKey", Skelta.Forms.Core.Common.GetFormUniqueKey(applicationName, parentItemId + "_" + controlid, controlid));
                }

                popupForm.InDesignMode = false;

                popupForm.DeviceType = (deviceType == "Web") ? Skelta.Forms.Core.DeviceType.Web : Skelta.Forms.Core.DeviceType.Mobile;

                popupForm.TemplateScripts.Clear();
                var view = nextGenRenderer.GetView(popupForm);
                var viewModel = nextGenRenderer.GetViewModel(popupForm);

                string viewAndViewModel = view + viewModel;
                viewAndViewModel = Skelta.Forms2.Web.CommonFunctions.ProcessLocalization(viewAndViewModel, Skelta.Forms2.Web.CommonFunctions.GetCurrentECCulture);

                Dictionary<string, string> parameterTypes = Skelta.Forms2.Web.NextGenForms.NextGenPopupFormHelper.GetLocalizedFormParameterTypes(popupForm.FormParameters);
                string formParameters = Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(new { FP = popupForm.FormParameters, FPT = parameterTypes });

                vals.Add("IsSuccess", "true");
                vals.Add("Result", viewAndViewModel);
                vals.Add("FormParameters", formParameters);
            }
        }
        catch (Exception ex)
        {
            vals.Add("IsSuccess", "false");
            Log log = new Log();
            log.LogError(ex, ResourceSet.GetString("FormNGFGetViewAndViewModelForPopupFromDefinition"));
        }

        return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(vals);
    }

    /// <summary>
    /// This method will generate the view and view model for the formId, version and list name
    /// </summary>
    /// <param name="applicationName">repository name</param>
    /// <param name="formName">name of the form</param>
    /// <param name="listName">forms list</param>
    /// <param name="userId">loggedIn userId</param>
    /// <param name="versionStamp">version stamp of the form</param>
    /// <param name="deviceType">The device from which the request has come</param>
    /// <returns>the view and view model</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetViewAndViewModelForPopupForm(string applicationName, string userId, string formName, string versionStamp, string listName, string deviceType, bool isStaging)
    {
        Dictionary<string, string> vals = new Dictionary<string, string>();

        if (!string.IsNullOrEmpty(formName) && !string.IsNullOrEmpty(versionStamp))
        {
            if (formName == StoredProcedureHelper.ProcedureDetailsPopupFormName && versionStamp == StoredProcedureHelper.ProcedureDetailsPopupFormVersion)
            {
                try
                {
                    vals.Add("IsSuccess", "true");
                    vals.Add("ItemId", formName);
                    vals.Add("Result", StoredProcedureLookupForm.GetProcedureDetailsForm(new SkeltaResourceSetManager().GlobalResourceSet, applicationName));
                    vals.Add("VersionStamp", versionStamp);
                    vals.Add("Status", ListItemVersionStatus.Published.ToString());
                }
                catch (Exception)
                {
                    vals.Add("IsSuccess", "false");
                }

                return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(vals);
            }
        }

        try
        {
            ListDataHandler listDataHandler = new ListDataHandler(applicationName, listName);
            Skelta.Repository.List.ListItem listItem = null;

            try
            {

                if (versionStamp == "0")
                {
                    listItem = listDataHandler.GetListItem(formName);
                    versionStamp = listItem.CurrentVersion.VersionStamp.ToString();
                }
                else
                {
                    listItem = listDataHandler.GetListItem(formName, versionStamp);
                }
            }
            catch (Exception ex)
            {
                vals.Add("IsSuccess", "false");

                return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(vals);
            }

            if (!Skelta.Forms.Core.Common.IsListItemTypeNextGen(listItem.ItemType))
            {
                vals.Add("IsSuccess", "false");
            }
            else
            {
                string status = listItem.Status.ToString();
                string itemId = listItem.Id.ToString();
                string viewAndViewModel = string.Empty;
                string formParameters = string.Empty;

                if (isStaging)
                {
                    NextGenRenderer nextGenRenderer = new NextGenRenderer();
                    var returnObject = Skelta.Forms2.Web.CommonFunctions.GetStagingViewAndViewModelWithFormParameters(applicationName, userId, formName, versionStamp, listName, deviceType);
                    viewAndViewModel = returnObject.Item1;
                    formParameters = returnObject.Item2;
                }
                else
                {
                    int iDebugLevel = new Config(applicationName).IntegerDebugLevel;
                    Workflow.NET.Log log = new Workflow.NET.Log();
                    DateTime definitionLastUpdatedDateTime = Skelta.Forms2.Web.CommonFunctions.GetDefinitionLastModifiedDateTime(applicationName, formName, versionStamp, listName);

                    ////Removing the millisecond
                    definitionLastUpdatedDateTime = definitionLastUpdatedDateTime.AddMilliseconds(-definitionLastUpdatedDateTime.Millisecond);
                    HttpContext.Current.Response.CacheControl = HttpCacheability.Public.ToString();

                    NextGenRenderer nextGenRenderer = new NextGenRenderer();
                    string itemKey = Skelta.Forms2.Web.CommonFunctions.GetFormCacheKey(applicationName, formName, listName);
                    string cultureKey = Skelta.Forms2.Web.CommonFunctions.GetCachedKey(applicationName, itemKey, Skelta.Forms2.Web.CommonFunctions.PublishedCulture, versionStamp);

                    DateTime ifModified = HttpContext.Current.Request.Headers["If-Modified-Since"] != null ? DateTime.Parse(HttpContext.Current.Request.Headers["If-Modified-Since"], CultureInfo.InvariantCulture) : DateTime.MinValue;
                    try
                    {
                        ////If the existing culture is not same as the current culture then take it from server cache or database based one more condition below.
                        if (ifModified < definitionLastUpdatedDateTime || NextGenRenderer.IsCultureDifferent(cultureKey) || Skelta.FarmManager.Platform.Azure == Workflow.NET.CommonFunctions.GetPlatformType())
                        {
                            HttpContext.Current.Response.AddHeader("Last-Modified", definitionLastUpdatedDateTime.ToUniversalTime().ToString("r"));
                            string getCachedViewAndViewModelPublishedInfo = string.Empty;

                            if (deviceType == "Web")
                            {
                                getCachedViewAndViewModelPublishedInfo = Skelta.Forms2.Web.CommonFunctions.GetCachedKey(applicationName, itemKey, Skelta.Forms2.Web.CommonFunctions.DefinitionViewAndViewModelPublished, versionStamp);
                            }
                            else
                            {
                                getCachedViewAndViewModelPublishedInfo = Skelta.Forms2.Web.CommonFunctions.GetCachedKey(applicationName, itemKey, Skelta.Forms2.Web.CommonFunctions.DefinitionMobileViewAndViewModelPublished, versionStamp);
                            }

                            // Add the Compression Filter to the Header if the Client Supports it.
                            SetCompressionFilterToHeader();

                            // Validate the Cache for the Form.
                            BaseForm baseForm = Skelta.Forms2.Web.CommonFunctions.ValidateCachedPublishedForm(itemKey, versionStamp, listName, applicationName);

                            if (iDebugLevel == 2)
                            {
                                log.LogInformation("Form: " + formName + ", Form Version: " + versionStamp + " view and view model is fetched from database", applicationName);
                            }

                            viewAndViewModel = (string)System.Web.HttpRuntime.Cache[getCachedViewAndViewModelPublishedInfo];
                            viewAndViewModel = Skelta.Forms2.Web.CommonFunctions.ProcessLocalization(viewAndViewModel, Skelta.Forms2.Web.CommonFunctions.GetCurrentECCulture);

                            Dictionary<string, string> parameterTypes = Skelta.Forms2.Web.NextGenForms.NextGenPopupFormHelper.GetLocalizedFormParameterTypes(baseForm.FormParameters);
                            formParameters = Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(new { FP = baseForm.FormParameters, FPT = parameterTypes });
                        }
                        else
                        {
                            log.LogInformation("ifModified: " + ifModified.ToString(CultureInfo.InvariantCulture) + ", definitionLastUpdatedDateTime: " + definitionLastUpdatedDateTime.ToString(CultureInfo.InvariantCulture), applicationName);
                            HttpContext.Current.Response.StatusCode = 304;
                            if (iDebugLevel == 2)
                            {
                                log.LogInformation("Form: " + formName + ", Form Version: " + versionStamp + " view and view model is fetched from client cache", applicationName);
                            }

                            return string.Empty;
                        }
                    }
                    catch (Exception ex)
                    {
                        log.LogError(ex, "Error at GetViewAndViewModel = " + ex.Message);
                    }
                }

                vals.Add("IsSuccess", "true");
                vals.Add("ItemId", itemId);
                vals.Add("Result", viewAndViewModel);
                vals.Add("FormParameters", formParameters);
                vals.Add("VersionStamp", versionStamp);
                vals.Add("Status", status.ToString());
            }
        }
        catch (Exception ex)
        {
            vals.Add("IsSuccess", "false");
        }

        return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(vals);
    }

    /// <summary>
    /// Adds the Compression Filter to the Response Header.
    /// </summary>
    private static void SetCompressionFilterToHeader()
    {
        string AcceptEncoding = HttpContext.Current.Request.Headers["Accept-Encoding"];

        if (!string.IsNullOrEmpty(AcceptEncoding))
        {
            if (AcceptEncoding.Contains("gzip"))
            {
                HttpContext.Current.Response.Filter = new System.IO.Compression.GZipStream(HttpContext.Current.Response.Filter, System.IO.Compression.CompressionMode.Compress);
                HttpContext.Current.Response.AddHeader("Content-Encoding", "gzip");
            }
            else if (AcceptEncoding.Contains("deflate"))
            {
                HttpContext.Current.Response.Filter = new System.IO.Compression.DeflateStream(HttpContext.Current.Response.Filter, System.IO.Compression.CompressionMode.Compress);
                HttpContext.Current.Response.AddHeader("Content-Encoding", "deflate");
            }
        }
    }

    /// <summary>
    /// This method will generate the view and view model for the formId, version and list name
    /// </summary>
    /// <param name="applicationName">repository name</param>
    /// <param name="formName">name of the form</param>
    /// <param name="listName">forms list</param>
    /// <param name="userId">loggedIn userId</param>
    /// <param name="versionStamp">version stamp of the form</param>
    /// <param name="deviceType">The device from which the request has come</param>
    /// <returns>the view and view model</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetViewAndViewModel(string applicationName, string userId, string formName, string versionStamp, string listName, string deviceType)
    {
        Dictionary<string, string> vals = new Dictionary<string, string>();
        Workflow.NET.Log log = new Workflow.NET.Log();
        vals.Add("ViewAndViewModel", "");
        vals.Add("FormParameters", "");

        try
        {
            DateTime lastdefinitionUpdatedDateTime = Skelta.Forms2.Web.CommonFunctions.GetFormLastModifiedDateTime(applicationName, formName, versionStamp) ?? DateTime.UtcNow;
            ////Removing the millisecond
            lastdefinitionUpdatedDateTime = lastdefinitionUpdatedDateTime.AddMilliseconds(-lastdefinitionUpdatedDateTime.Millisecond);
            HttpContext.Current.Response.CacheControl = HttpCacheability.Public.ToString();
            string itemKey = Skelta.Forms2.Web.CommonFunctions.GetFormCacheKey(applicationName, formName, listName);
            string cultureKey = Skelta.Forms2.Web.CommonFunctions.GetCachedKey(applicationName, itemKey, Skelta.Forms2.Web.CommonFunctions.PublishedCulture, versionStamp);
            DateTime ifModified = HttpContext.Current.Request.Headers["If-Modified-Since"] != null ? DateTime.Parse(HttpContext.Current.Request.Headers["If-Modified-Since"], CultureInfo.InvariantCulture) : DateTime.MinValue;

            ////If the existing culture is not same as the current culture then take it from server cache or database based one more condition below.
            if (ifModified < lastdefinitionUpdatedDateTime || NextGenRenderer.IsCultureDifferent(cultureKey) || Skelta.FarmManager.Platform.Azure == Workflow.NET.CommonFunctions.GetPlatformType())
            {
                HttpContext.Current.Response.AddHeader("Last-Modified", lastdefinitionUpdatedDateTime.ToUniversalTime().ToString("r"));
                string getCachedViewAndViewModelPublishedInfo = (deviceType == "Web" || string.IsNullOrEmpty(deviceType)) ? Skelta.Forms2.Web.CommonFunctions.GetCachedKey(applicationName, itemKey, Skelta.Forms2.Web.CommonFunctions.DefinitionViewAndViewModelPublished, versionStamp) : Skelta.Forms2.Web.CommonFunctions.GetCachedKey(applicationName, itemKey, Skelta.Forms2.Web.CommonFunctions.DefinitionMobileViewAndViewModelPublished, versionStamp);
                // Add the Compression Filter to the Header if the Client Supports it.
                SetCompressionFilterToHeader();
                // Validate the Cache for the Form.
                Skelta.Forms2.Web.CommonFunctions.ValidateCachedPublishedForm(itemKey, versionStamp, listName, applicationName);
                if (FormsUtility.GetFormsDebugMode())
                {
                    log.LogInformation("Form: " + formName + ", Form Version: " + versionStamp + " view and view model is fetched from database", applicationName);
                }

                string viewAndViewModel = (string)System.Web.HttpRuntime.Cache[getCachedViewAndViewModelPublishedInfo];
                viewAndViewModel = Skelta.Forms2.Web.CommonFunctions.ProcessLocalization(viewAndViewModel, Skelta.Forms2.Web.CommonFunctions.GetCurrentECCulture);
                vals["ViewAndViewModel"] = viewAndViewModel;
                vals["FormParameters"] = Skelta.Forms2.Web.CommonFunctions.GetFormParameterFromCachedForm(itemKey, versionStamp, listName);
            }
            else
            {
                log.LogInformation("ifModified: " + ifModified.ToString(CultureInfo.InvariantCulture) + ", definitionLastUpdatedDateTime: " + lastdefinitionUpdatedDateTime.ToString(CultureInfo.InvariantCulture), applicationName);
                //Explicitly set the Content-Length header so the client doesn't wait for content but keeps the connection open for other requests
                //HttpContext.Current.Response.AddHeader("Content-Length", "0");
                ////Not to do compression because no data is send
                HttpContext.Current.Response.StatusCode = 304;
                if (FormsUtility.GetFormsDebugMode())
                {
                    log.LogInformation("Form: " + formName + ", Form Version: " + versionStamp + " view and view model is fetched from client cache", applicationName);
                }
            }
        }
        catch (Exception ex)
        {
            log.LogError(ex, "Error at GetViewAndViewModel = " + ex.Message);
        }

        return Newtonsoft.Json.JsonConvert.SerializeObject(vals);
    }

    /// <summary>
    /// Get JSON string for Forms Designer Initial Data
    /// </summary>
    /// <param name="listParameterValue">lcuri url parameter string</param>
    /// <returns>JSON string</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Xml)]
    public static string GetJsonFormDesignerInitialData(string listParameterValue)
    {
        ListPageParameters listParams = new ListPageParameters();
        Log log = new Log();

        try
        {
            listParams.ResolveUriValue(listParameterValue);
        }
        catch (Exception ex)
        {
            log.LogError(ex, ResourceSet.GetString("FormsNGFListPageParamsError"));
        }

        return new NextGenDesigner().GetJsonFormsDesignerInitialData(listParams);
    }

    /// <summary>
    /// Adds the control to the specified position and returns the new control's html
    /// </summary>
    /// <param name="targetId">The target control's id where the new control needs to be added</param>
    /// <param name="controlTypeToBeAdded">The type of control to be added</param>
    /// <param name="dropType">Add mode whether insertAfter, insertBefore, or append</param>
    /// <param name="cacheKey">Form id</param>
    /// <param name="listName">List name</param>
    /// <param name="versionStamp">Version Stamp</param>
    /// <param name="columnIndex">column Index</param>
    /// <param name="applicationName">Application Name</param>
    /// <returns>Returns the Html of the new control along with the new control id details</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string AddControl(string targetId, string controlTypeToBeAdded, string dropType, string cacheKey, string listName, string versionStamp, string columnIndex, string applicationName, string userId)
    {
        ////var errorData = Skelta.Forms2.Web.CommonFunctions.VerifyUserId(userId);
        ////if (!string.IsNullOrEmpty(errorData))
        ////{
        ////    return errorData;
        ////}
        if (string.IsNullOrEmpty(controlTypeToBeAdded))
        {
            controlTypeToBeAdded = string.Empty;
        }

        if (string.IsNullOrEmpty(dropType))
        {
            dropType = string.Empty;
        }

        return NextGenDesigner.AddNewControl(targetId, controlTypeToBeAdded, dropType, cacheKey, listName, versionStamp, columnIndex, applicationName, userId);
    }

    /// <summary>
    /// Deletes the control
    /// </summary>
    /// <param name="targetId">The target control's id which needs to be deleted</param>
    /// <param name="cacheKey">Form id</param>
    /// <param name="listName">List name</param>
    /// <param name="versionStamp">Version Stamp</param>
    /// <param name="applicationName">application Name</param>
    /// <param name="userId">Logged In User</param>
    /// <returns>Returns whether the deletion was successful or not</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string DeleteControl(string targetId, string cacheKey, string listName, string versionStamp, string applicationName, string userId)
    {
        ////var errorData = Skelta.Forms2.Web.CommonFunctions.VerifyUserId(userId);
        ////if (!string.IsNullOrEmpty(errorData))
        ////{
        ////    return errorData;
        ////}

        return new NextGenDesigner().DeleteControl(targetId, cacheKey, listName, versionStamp, applicationName, userId);
    }

    /// <summary>
    /// Delete all the controls
    /// </summary>
    /// <param name="cacheKey">Form id</param>
    /// <param name="listName">List name</param>
    /// <param name="versionStamp">Version Stamp</param>
    /// <param name="applicationName">application Name</param>
    /// <param name="userId">Logged In User</param>
    /// <returns>Returns whether the deletion was successful or not</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string DeleteAllControls(string cacheKey, string listName, string versionStamp, string applicationName, string userId)
    {
        ////var errorData = Skelta.Forms2.Web.CommonFunctions.VerifyUserId(userId);
        ////if (!string.IsNullOrEmpty(errorData))
        ////{
        ////    return errorData;
        ////}

        return NextGenDesigner.DeleteAllControls(cacheKey, listName, versionStamp, applicationName, userId);
    }

    /// <summary>
    /// Function to Generate View and ViewModel for EditControl window
    /// </summary>
    /// <param name="cacheKey"> id of the cache</param>
    /// <param name="listName">name of the list</param>
    /// <param name="versionStamp">version of the form</param>
    /// <param name="containerId">control or container id</param>
    /// <param name="target">target control</param>
    /// <param name="controlType">type of the control for which properties has to be edited</param>
    /// <param name="applicationName">Application Name</param>
    /// <returns>the view and view model for the edit control page</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Xml)]
    public static string EditControl(string cacheKey, string listName, string versionStamp, string containerId, string target, string applicationName, string userId)
    {
        string editControlVaVM = string.Empty;
        NextGenRenderer nextGenRenderer = new NextGenRenderer();
        NextGenDesigner nextGenDesigner = new NextGenDesigner();

        BaseForm editControlForm = nextGenDesigner.GetClonedEditControlFormFromCache(cacheKey, listName, versionStamp, containerId, applicationName);

        editControlVaVM = nextGenRenderer.GetSPA(editControlForm);
        editControlVaVM = Skelta.Forms2.Web.CommonFunctions.ProcessLocalization(editControlVaVM, Skelta.Forms2.Web.CommonFunctions.GetCurrentECCulture);

        return editControlVaVM;
    }

    /// <summary>
    /// Function to get the filtered list of form parameters as per widget property name rules
    /// </summary>
    /// <param name="formDetails">Form Details</param>
    /// <param name="applicationName">Application Name</param>
    /// <returns>Returns the form parameters and error if any</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string GetWidgetDetailsFromFormParameters(string formDetails, string applicationName)
    {
        NextGenDesigner nextGenDesigner = new NextGenDesigner();

        return nextGenDesigner.GetWidgetDetailsFromFormParameters(formDetails, applicationName);
    }

    /// <summary>
    /// Function to the update the selected controls value in the form definition and returns the updated view of that control
    /// </summary>
    /// <param name="xmlInstance">Xml Instance of the properties</param>
    /// <param name="cacheKey">Form id</param>
    /// <param name="listName">list Name</param>
    /// <param name="version">form version</param>
    /// <param name="selectedControl">selected control</param>
    /// <param name="applicationName">application Name</param>
    /// <param name="userId">Logged In User</param>
    /// <returns>updated view of selected control</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Xml)]
    public static string UpdateFormDefinition(string xmlInstance, string cacheKey, string listName, string version, string selectedControl, string applicationName, string userId)
    {
        ////var errorData = Skelta.Forms2.Web.CommonFunctions.VerifyUserId(userId);
        ////if (!string.IsNullOrEmpty(errorData))
        ////{
        ////    return errorData;
        ////}

        return new NextGenDesigner().UpdateFormAndReturnView(xmlInstance, cacheKey, listName, version, selectedControl, applicationName, userId);
    }

    /// <summary>
    /// Function to update the form definition based on the client side action from mobile
    /// </summary>
    /// <param name="cacheKey">form id</param>
    /// <param name="listName">forms list name</param>
    /// <param name="versionStamp">from version</param>
    /// <param name="controlToBeMoved">control to be moved</param>
    /// <param name="oldIndex">from index</param>
    /// <param name="newIndex">to index</param>
    /// <param name="applicationName">application Name</param>
    /// <param name="userId">Logged in userId</param>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string SortAndUpdateControl(string cacheKey, string listName, string versionStamp, string controlToBeMoved, int oldIndex, int newIndex, string applicationName, string userId)
    {
        Dictionary<string, object> vals = new Dictionary<string, object>();
        Log log = new Log();

        try
        {
            if (!Skelta.Repository.Security.CommonFunctions.IsQueryStringValid(cacheKey) ||
                !Skelta.Repository.Security.CommonFunctions.IsQueryStringValid(listName) ||
                !Skelta.Repository.Security.CommonFunctions.IsQueryStringValid(versionStamp) ||
                !Skelta.Repository.Security.CommonFunctions.IsQueryStringValid(controlToBeMoved) ||
                !Skelta.Repository.Security.CommonFunctions.IsQueryStringValid(applicationName))
            {
                string errorMessage = "SortAndUpdateControl - " + new SkeltaResourceSetManager().GlobalResourceSet.GetString("HtmlAndScript_Error");

                vals.Add("IsSuccess", false);
                vals.Add("ErrorMessage", errorMessage);
                log.LogError(new InvalidOperationException(), errorMessage);
                return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(vals);
            }

            BaseForm formDef = null;
            int insertIndex = 0;
            if (oldIndex != newIndex)
            {
                using (var transactionScope = Workflow.NET.CommonFunctions.GetSuppressedTransactionScope())
                {
                    Skelta.Forms2.Web.CommonFunctions.ValidateCachedTempDefinitionForm(cacheKey, versionStamp, listName, applicationName);
                    formDef = System.Web.HttpRuntime.Cache[cacheKey + Skelta.Forms2.Web.CommonFunctions.StagingDefinitionCacheKey + versionStamp] as BaseForm;

                    BaseControl movControl = formDef.FindControlByID(controlToBeMoved);
                    insertIndex = newIndex - 1;
                    movControl.ParentForm.Controls.Remove(movControl);
                    formDef.Controls.Insert(insertIndex, movControl);
                    Skelta.Forms2.Web.CommonFunctions.UpdateTempDefinitionToDBAndValidateCache(cacheKey, versionStamp, formDef, listName, applicationName, userId);
                }
            }

            vals.Add("IsSuccess", true);
        }
        catch (Exception ex)
        {
            string errorMessage = resourceSet.GetString("FormNGFSortAndUpdateControlError");

            vals.Add("IsSuccess", false);
            vals.Add("ErrorMessage", errorMessage);
            log.LogError(ex, ResourceSet.GetString("FormNGFSortAndUpdateControlError"));
        }

        return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(vals);
    }

    /// <summary>
    /// Function to update the form definition based on the client side action
    /// </summary>
    /// <param name="cacheKey">cache Key</param>
    /// <param name="listName">Forms List</param>
    /// <param name="versionStamp">version of the form</param>
    /// <param name="controlToBeMoved">Control to be moved</param>
    /// <param name="insertPos">Insert Position</param>
    /// <param name="refernceControl">Reference Control</param>
    /// <param name="columnIndex">column index</param>
    /// <param name="applicationName">application Name</param>
    /// <param name="userId">Logged In userId</param>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string MoveControl(string cacheKey, string listName, string versionStamp, string controlIdToBeMoved, string insertPos, string refernceControl, string columnIndex, string applicationName, string userId)
    {
        ////var errorData = Skelta.Forms2.Web.CommonFunctions.VerifyUserId(userId);
        ////if (!string.IsNullOrEmpty(errorData))
        ////{
        ////    return errorData;
        ////}

        return NextGenDesigner.MoveControl(refernceControl, controlIdToBeMoved, insertPos, cacheKey, listName, versionStamp, columnIndex, applicationName, userId);
    }

    /// <summary>
    /// Function to update the form defintion after client side clone and paste the control
    /// </summary>
    /// <param name="cacheKey">cache Key</param>
    /// <param name="listName">Forms List</param>
    /// <param name="versionStamp">version of the form</param>
    /// <param name="controlToBeMoved">Control to be moved</param>
    /// <param name="insertPos">Insert Position</param>
    /// <param name="refernceControl">Reference Control</param>
    /// <param name="columnIndex">column index</param>
    /// <param name="applicationName">application Name</param>
    /// <param name="userId">Logged In userId</param>
    /// <returns>Returns the Html of the pasted control</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string PasteControl(string cacheKey, string listName, string versionStamp, string controlIdToBeMoved, string insertPos, string refernceControl, string columnIndex, string applicationName, string userId)
    {
        ////var errorData = Skelta.Forms2.Web.CommonFunctions.VerifyUserId(userId);
        ////if (!string.IsNullOrEmpty(errorData))
        ////{
        ////    return errorData;
        ////}

        return new NextGenDesigner().PasteControl(refernceControl, controlIdToBeMoved, insertPos, cacheKey, listName, versionStamp, columnIndex, applicationName, userId);
    }

    /// <summary>
    /// Function to update the tag name of the control
    /// </summary>
    /// <param name="cacheKey">Cache key</param>
    /// <param name="listName">List Name</param>
    /// <param name="versionStamp">Version Stamp</param>
    /// <param name="controlId">Control Id</param>
    /// <param name="tagName">tag Name</param>
    /// <param name="applicationName">application Name</param>
    /// <param name="userId">Logged In User</param>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string UpdateTagName(string cacheKey, string listName, string versionStamp, string controlId, string tagName, string applicationName, string userId)
    {
        Dictionary<string, object> vals = new Dictionary<string, object>();

        try
        {
            BaseForm formDef = null;
            using (var transactionScope = Workflow.NET.CommonFunctions.GetSuppressedTransactionScope())
            {
                Skelta.Forms2.Web.CommonFunctions.ValidateCachedTempDefinitionForm(cacheKey, versionStamp, listName, applicationName);
                formDef = System.Web.HttpRuntime.Cache[applicationName + cacheKey + Skelta.Forms2.Web.CommonFunctions.StagingDefinitionCacheKey + versionStamp] as BaseForm;

                tagName = tagName.Replace("\"", string.Empty).Replace("'", string.Empty);
                new NextGenDesigner().UpdateTagNameForControl(controlId, tagName, formDef);
                Skelta.Forms2.Web.CommonFunctions.UpdateTempDefinitionToDBAndValidateCache(cacheKey, versionStamp, formDef, listName, applicationName, userId);
            }

            vals.Add("IsSuccess", true);
        }
        catch (Exception ex)
        {
            string errorMessage = resourceSet.GetString("FormNGFErrorWhileUpdatingTagName").Replace("<@error@>", ex.Message);

            vals.Add("IsSuccess", false);
            vals.Add("ErrorMessage", errorMessage);
            Workflow.NET.Log log = new Workflow.NET.Log();
            log.LogError(ex, errorMessage);
        }

        return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(vals);
    }

    /// <summary>
    /// This method will generate the view and view model for the formId, version and listname
    /// </summary>
    /// <param name="listParameterValue">lcuri url parameter string</param>
    /// <param name="deviceType">The device from which the request has come</param>
    /// <param name="versionStamp">The version of the form getting published</param>
    /// <returns>result tells whether the publish was success or failure</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string PublishForm(string listParameterValue, string versionStamp)
    {
        ListPageParameters listParams = new ListPageParameters();
        listParams.ResolveUriValue(listParameterValue);
        ////var errorData = Skelta.Forms2.Web.CommonFunctions.VerifyUserId(listParams.LoggedInUserId);
        ////if (!string.IsNullOrEmpty(errorData))
        ////{
        ////    return errorData;
        ////}

        string errorMessage = string.Empty;
        string jsonSerializedValue = string.Empty;

        try
        {
            jsonSerializedValue = Skelta.Forms2.Web.NextGenForms.PublishForm.Publish(listParams, versionStamp);
        }
        catch (Exception ex)
        {
            errorMessage = ex.Message;
            Workflow.NET.Log log = new Workflow.NET.Log();
            log.LogError(ex, "Error while publishing form = " + ex.Message);
        }

        if (errorMessage.Length > 0)
        {
            return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(new { Message = errorMessage });
        }

        return jsonSerializedValue;
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string UpdateColumnWidths(string cacheKey, string listName, string versionStamp, string controlId, string columnWidths, string applicationName, string userId)
    {
        Dictionary<string, object> vals = new Dictionary<string, object>();

        try
        {
            ValidateColumnWidthValue(columnWidths);
            BaseForm formDef = null;
            using (var transactionScope = Workflow.NET.CommonFunctions.GetSuppressedTransactionScope())
            {
                Skelta.Forms2.Web.CommonFunctions.ValidateCachedTempDefinitionForm(cacheKey, versionStamp, listName, applicationName);
                string getCachedInfo = Skelta.Forms2.Web.CommonFunctions.GetCachedKey(applicationName, cacheKey, Skelta.Forms2.Web.CommonFunctions.StagingDefinitionCacheKey, versionStamp);
                formDef = System.Web.HttpRuntime.Cache[getCachedInfo] as BaseForm;

                (formDef.FindControlByID(controlId) as BaseForm).SetColumnWidths(columnWidths, ",");
                Skelta.Forms2.Web.CommonFunctions.UpdateTempDefinitionToDBAndValidateCache(cacheKey, versionStamp, formDef, listName, applicationName, userId);
            }

            vals.Add("IsSuccess", true);
        }
        catch (Exception ex)
        {
            string errorMessage = resourceSet.GetString("FormNGFErrorWhileUpdatingColumnWidths").Replace("<@error@>", ex.Message);

            vals.Add("IsSuccess", false);
            vals.Add("ErrorMessage", errorMessage);
            Workflow.NET.Log log = new Workflow.NET.Log();
            log.LogError(ex, errorMessage);
        }

        return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(vals);
    }

    /// <summary>
    /// Validate the column width value.
    /// </summary>
    /// <param name="columnWidths">column width</param>
    private static void ValidateColumnWidthValue(string columnWidths)
    {
        string widthSeparator = ",";

        var columnResult = columnWidths.Split(new string[] { widthSeparator }, StringSplitOptions.None);

        try
        {
            foreach (var item in columnResult)
            {
                Convert.ToDecimal(item, CultureInfo.InvariantCulture);
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string InvokeSOAMethod(string applicationName, string userId, string nameOftheAssembly, string nameSpaceWithClassName, string methodToExec, object inputParameters, string deviceType)
    {
        string soaResult = string.Empty;
        try
        {
            object result = string.Empty;
            ////TODO: User Context test case need to be taken care.
            Skelta.Forms.External.Connector soaConnector = new Skelta.Forms.External.Connector(applicationName, userId);
            System.Web.Script.Serialization.JavaScriptSerializer oSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            if (inputParameters == null)
            {
                result = soaConnector.CallMethod(nameOftheAssembly, nameSpaceWithClassName, methodToExec, null);
                if (result as DataSet != null)
                {
                    soaResult = JsonConvert.SerializeObject((result as DataSet).Tables[0], Newtonsoft.Json.Formatting.Indented);
                }
                else
                {
                    soaResult = JsonConvert.SerializeObject(result);
                }
            }
            else
            {
                string ipParam = string.Empty;
                object[] objArray = null;
                //if the first character is [ then its an array.
                //if (inputParameters.ToString()[0].Equals('['))
                if (inputParameters is object[])
                {
                    //ipParam = inputParameters.ToString().Substring(1, inputParameters.ToString().Length - 2);
                    //objArray = ipParam.Split(',');
                    var parameters = inputParameters as object[];
                    if (parameters.Length > 0)
                    {
                        for (int ctrParam = 0; ctrParam < parameters.Length; ctrParam++)
                        {
                            if (parameters[ctrParam] is Dictionary<string, object>)
                            {
                                var paramObject = parameters[ctrParam] as Dictionary<string, object>;
                                foreach (var item in paramObject.Keys)
                                {
                                    var paramValueObject = paramObject[item] as Dictionary<string, object>;
                                    var type = Type.GetType(Convert.ToString(paramValueObject["type"], CultureInfo.InvariantCulture));
                                    parameters[ctrParam] = Convert.ChangeType(paramValueObject["value"], type, CultureInfo.InvariantCulture);
                                }
                            }
                        }
                    }
                    result = soaConnector.CallMethod(nameOftheAssembly, nameSpaceWithClassName, methodToExec, parameters);
                }
                ////JSON
                //else if (inputParameters.ToString()[0].Equals('{'))
                else if ((inputParameters as Dictionary<string, object>) != null)
                {
                    //XmlDocument xmlDoc = (XmlDocument)Newtonsoft.Json.JsonConvert.DeserializeXmlNode(inputParameters.ToString());
                    //foreach (XmlNode item in xmlDoc.ChildNodes)
                    //{
                    //    ipParam += item.InnerText + ",";
                    //}
                    //ipParam = ipParam.TrimEnd(',');
                    //objArray = ipParam.Split(',');
                    objArray = ((object[])((inputParameters as Dictionary<string, object>).Values.ToList()[0]));
                    List<object> objList = new List<object>();
                    for (int eachItem = 0; eachItem < objArray.Length; eachItem++)
                    {
                        objList.Add((objArray[eachItem] as Dictionary<string, object>).Values.ToList()[eachItem]);
                    }
                    result = soaConnector.CallMethod(nameOftheAssembly, nameSpaceWithClassName, methodToExec, (object[])objList.ToArray());
                }

                //if (result.GetType() == typeof(string))
                //{
                //    Dictionary<string, string> returnValue = new Dictionary<string, string>();
                //    returnValue.Add("d", result.ToString());
                //    soaResult = JsonConvert.SerializeObject(result);
                //}
                //else
                //{
                soaResult = JsonConvert.SerializeObject(result);
                //}
            }
        }
        catch (Exception ex)
        {
            Workflow.NET.Log log = new Workflow.NET.Log();
            log.LogError(ex, "Error at InvokeSOAMethod = " + ex.Message);
        }
        return soaResult;
    }

    /// <summary>
    /// To invoke a workflow which is associated to a form.    
    /// </summary>
    /// <param name="xmlInstance">the instance xml of the form</param>
    /// <param name="applicationName">the repo name</param>
    /// <param name="userId">the user who has logged In</param>
    /// <param name="formName">name of the form</param>
    /// <param name="versionStamp">version of the form</param>
    /// <param name="listName">list name</param>
    /// <param name="fillFormTestRun">parameter for test run for fillform</param>
    /// <param name="deviceType">the device which raised the request</param>
    /// <returns>the response of the operation</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string InvokeFillForm(string xmlInstance, string applicationName, string userId, string formName, string versionStamp, string listName, string deviceType, string fillFormTestRun)
    {
        ////var errorData = Skelta.Forms2.Web.CommonFunctions.VerifyUserId(userId);
        ////if (!string.IsNullOrEmpty(errorData))
        ////{
        ////    return errorData;
        ////}

        InvokeFillForm instanceForm = new InvokeFillForm();
        return instanceForm.InvokeAssociatedWorkflow(xmlInstance, applicationName, userId, formName, versionStamp, listName, fillFormTestRun);
    }

    /// <summary>
    /// Get form instance xml of WorkItem Associated form
    /// </summary>
    /// <param name="applicationName">name of the application</param>
    /// <param name="exeDetailId">execution details id</param>
    /// <param name="wfName">workflow name</param>
    /// <param name="channelName">channel Name</param>
    /// <param name="workItemId">workItem Id</param>
    /// <param name="virActorId">virActor Id</param>
    /// <param name="formType">Invoke Form</param>
    /// <returns>The instance xml of the form associated with work item</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetInstanceXmlWorkItem(string applicationName, string exeDetailId, string workflowName, string channelName, string workItemId, string virtualActorId, string formType, string userId)
    {
        ////var errorData = Skelta.Forms2.Web.CommonFunctions.VerifyUserId(userId);
        ////if (!string.IsNullOrEmpty(errorData))
        ////{
        ////    return errorData;
        ////}
        WorkItemInvokeForm workItemInvokeForm = new WorkItemInvokeForm();
        ////HttpContext.Current.Response.Filter = new System.IO.Compression.GZipStream(HttpContext.Current.Response.Filter, System.IO.Compression.CompressionMode.Compress);
        ////HttpContext.Current.Response.AddHeader("Content-Encoding", "gzip");
        return workItemInvokeForm.GetInstanceXmlWorkItem(applicationName, exeDetailId, workflowName, channelName, workItemId, virtualActorId, formType);
    }

    /// <summary>
    /// Get form instance xml of WorkItem Associated form
    /// </summary>
    /// <param name="applicationName">name of the application</param>
    /// <param name="exeDetailId">execution details id</param>
    /// <param name="wfName">workflow name</param>
    /// <param name="channelName">channel Name</param>
    /// <param name="workItemId">workItem Id</param>
    /// <param name="virActorId">virActor Id</param>
    /// <param name="formType">Invoke Form</param>
    /// <param name="instanceVariableName">Instance Xml Variable Name</param>
    /// <param name="listItemId">list item id</param>
    /// <param name="listId">list id</param>
    /// <param name="listName">list name</param>
    /// <returns>The instance xml of the form associated with work item</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetInstanceXmlFormDocumentView(string applicationName, string exeDetailId, string workflowName, string channelName, string workItemId, string virtualActorId, string formType, string instanceVariableName, string userId, string listItemId, string listId, string listName)
    {
        ////var errorData = Skelta.Forms2.Web.CommonFunctions.VerifyUserId(userId);
        ////if (!string.IsNullOrEmpty(errorData))
        ////{
        ////    return errorData;
        ////}
        WorkItemInvokeForm workItemInvokeForm = new WorkItemInvokeForm();
        return workItemInvokeForm.GetInstanceXmlFormDocumentView(applicationName, exeDetailId, workflowName, workItemId, virtualActorId, instanceVariableName, listItemId, listName);
    }

    /// <summary>
    /// Function to Get Instance Xml of Edit Control
    /// </summary>
    /// <param name="cacheKey"> id of the cache</param>
    /// <param name="listName">name of the list</param>
    /// <param name="versionStamp">version of the form</param>
    /// <param name="containerId">form id</param>
    /// <param name="target">target control</param>
    /// <param name="applicationName">application Name</param>
    /// <returns>the view and view model for the edit control page</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string GetEditControlInstanceXml(string cacheKey, string listName, string versionStamp, string containerId, string target, string applicationName, string userId)
    {
        ////var errorData = Skelta.Forms2.Web.CommonFunctions.VerifyUserId(userId);
        ////if (!string.IsNullOrEmpty(errorData))
        ////{
        ////    return errorData;
        ////}
        return NextGenRenderer.GetEditControlInstanceXml(cacheKey, listName, versionStamp, containerId, applicationName);
    }

    /// <summary>
    /// Submit WorkItem View
    /// </summary>
    /// <param name="xmlInstance">the instance xml</param>
    /// <param name="clickedButtonText">the text of the button clicked</param>
    /// <param name="applicationName">name of the application</param>
    /// <param name="formName">name of the form</param>
    /// <param name="wfName">workflow name</param>
    /// <param name="channelName">channel Name</param>
    /// <param name="workItemId">workItem Id</param>
    /// <param name="virActorId">virActor Id</param>
    /// <param name="formType">Invoke Form</param>
    /// <param name="formVersion">form version</param>
    /// <returns>a boolean which says the submit was success or not</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string SubmitInvokeFormWorkItem(string xmlInstance, string clickedButtonText, string applicationName, string formName, string wfName, string channelName, string workItemId, string virActorId, string formType, bool isFromSaveAsDraftLink, string userId, object formsParameters, string formVersion)
    {
        ////var errorData = Skelta.Forms2.Web.CommonFunctions.VerifyUserId(userId);
        ////if (!string.IsNullOrEmpty(errorData))
        ////{
        ////    return errorData;
        ////}
        WorkItemInvokeForm workItemInvokeForm = new WorkItemInvokeForm();
        //////xmlInstance = HttpUtility.UrlDecode(xmlInstance, System.Text.Encoding.Default);
        return workItemInvokeForm.SubmitInvokeFormWorkItem(xmlInstance, clickedButtonText, applicationName, formName, wfName, channelName, workItemId, virActorId, formType, isFromSaveAsDraftLink, formsParameters, formVersion);
    }

    /// <summary>
    /// Submits Multiple Invoke Form Workitems
    /// </summary>
    /// <param name="xmlInstance">the instance xml</param>
    /// <param name="clickedButtonText">the text of the button clicked</param>
    /// <param name="applicationName">name of the application</param>
    /// <param name="formName">name of the form</param>
    /// <param name="wfName">workflow name</param>
    /// <param name="channelName">channel Name</param>
    /// <param name="workItemId">workItem Id</param>
    /// <param name="virActorId">virActor Id</param>
    /// <param name="formType">Invoke Form</param>
    /// <returns>a boolean which says the submit was success or not</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string SubmitMultiSelectInvokeFormWorkItem(string userId, string applicationName, string xmlInstance, string clickedButtonText, string formName, string formVersion, string wfName, string channelName, string virActorId, object formsParameters)
    {
        //// Verify Logged In User ID
        string loggedInUserVerificationMessage = Skelta.Forms2.Web.CommonFunctions.VerifyLoggedInUserId(userId);
        if (!string.IsNullOrEmpty(loggedInUserVerificationMessage))
        {
            return loggedInUserVerificationMessage;
        }

        WorkItemInvokeForm workItemInvokeForm = new WorkItemInvokeForm();
        return workItemInvokeForm.SubmitMultipleWorkItemInvokeForm(xmlInstance, clickedButtonText, applicationName, formName, formVersion, wfName, channelName, virActorId, formsParameters);
    }

    /// <summary>
    /// Gets the new Form Definition
    /// </summary>
    /// <param name="lcsuri">the lcsuri</param>
    /// <returns>the view and view model of the new form</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string GetNewFormDefinition(string lcsuri)
    {
        ListPageParameters listParams = new ListPageParameters();
        listParams.ResolveUriValue(lcsuri);
        ////var errorData = Skelta.Forms2.Web.CommonFunctions.VerifyUserId(listParams.LoggedInUserId);
        ////if (!string.IsNullOrEmpty(errorData))
        ////{
        ////    return errorData;
        ////}

        string viewAndViewModel = string.Empty;
        NewForm newForm = new NewForm();
        NextGenRenderer nextGenRenderer = new NextGenRenderer();
        var baseForm = newForm.NewEntryForm();
        if (baseForm != null)
        {
            if (baseForm.TopLevelForm.RenderDetails.Get("formUniqueKey") == null)
            {
                baseForm.TopLevelForm.RenderDetails.Add("formUniqueKey", Skelta.Forms.Core.Common.GetFormUniqueKey(listParams.ApplicationName, listParams.ListItemId + "_N", string.Empty));
            }

            return nextGenRenderer.GetSPA(baseForm);
        }

        return string.Empty;
    }

    /// <summary>
    /// Updates the Inwoke Workflow Settings
    /// </summary>
    /// <param name="userId">User Id</param>
    /// <param name="applicationName">Application Name</param>
    /// <param name="cacheKey">Cache Key</param>
    /// <param name="versionStamp">Version Stamp</param>
    /// <param name="workflow">Workflow Name</param>
    /// <param name="workflowVersion">Workflow Version</param>
    /// <param name="action">Action to be performed</param>
    /// <param name="schema">Selected Schema</param>
    /// <param name="gridId">Grid Id</param>
    /// <param name="xmlVar">XML Var</param>
    /// <param name="runningInstanceAction">Action to be performed for Running/Paused Workflow Instances</param>
    /// <returns>Status of the action</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string InvokeWorkflowUpdateConfig(string userId, string applicationName, string cacheKey, string versionStamp, string workflow, string workflowVersion, string action, string schema, string gridId, string xmlVar, string runningInstanceAction)
    {
        NextGenInvokeWorkflowHelper workflowConfig = new NextGenInvokeWorkflowHelper();
        return workflowConfig.UpdateInvokeWorkflowSettings(userId, applicationName, cacheKey, versionStamp, workflow, workflowVersion, action, schema, gridId, xmlVar, runningInstanceAction);
    }

    /// <summary>
    /// Gets the Invoke Workflow Overwrite Config Screen
    /// </summary>
    /// <param name="userId">userId</param>
    /// <param name="applicationName">applicationName</param>
    /// <param name="cacheKey">cacheKey</param>
    /// <param name="versionStamp">versionStamp</param>
    /// <param name="workflow">Workflow Name</param>
    /// <param name="configError">Config Error</param>
    /// <returns>Returns the view and view model of the workflow configuration form</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string GetInvokeWorkflowOverwriteConfigForm(string userId, string applicationName, string cacheKey, string versionStamp, string workflow, string configError)
    {
        NextGenInvokeWorkflowHelper workflowConfig = new NextGenInvokeWorkflowHelper();
        NextGenRenderer nextGenRenderer = new NextGenRenderer();
        var baseForm = workflowConfig.GetOverwriteFormSchema(applicationName, workflow, configError);
        if (baseForm != null)
        {
            if (baseForm.TopLevelForm.RenderDetails.Get("formUniqueKey") == null)
            {
                baseForm.TopLevelForm.RenderDetails.Add("formUniqueKey", Skelta.Forms.Core.Common.GetFormUniqueKey(applicationName, cacheKey + "_WOC", versionStamp));
            }

            return nextGenRenderer.GetSPA(baseForm);
        }

        return string.Empty;
    }

    /// <summary>
    /// Gets the Invoke Workflow XML variable Name Overwrite Config Screen
    /// </summary>
    /// <param name="userId">userId</param>
    /// <param name="applicationName">applicationName</param>
    /// <param name="cacheKey">cacheKey</param>
    /// <param name="versionStamp">versionStamp</param>
    /// <param name="workflow">Workflow Name</param>
    /// <param name="configError">Config Error</param>
    /// <returns>Returns the view and view model of the workflow configuration form</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string GetInvokeWorkflowXMLVariableConfigForm(string userId, string applicationName, string cacheKey, string versionStamp, string workflowVersion, string workflow)
    {
        NextGenRenderer nextGenRenderer = new NextGenRenderer();
        var baseForm = Skelta.Forms2.Web.CommonFunctions.GetXmlVariableConfig(applicationName, workflow, workflowVersion);
        if (baseForm != null)
        {
            if (baseForm.TopLevelForm.RenderDetails.Get("formUniqueKey") == null)
            {
                baseForm.TopLevelForm.RenderDetails.Add("formUniqueKey", Skelta.Forms.Core.Common.GetFormUniqueKey(applicationName, cacheKey + "_WOC", versionStamp));
            }

            return nextGenRenderer.GetSPA(baseForm);
        }

        return string.Empty;
    }

    /// <summary>
    /// Gets the Workflow Configuration screen definiton
    /// </summary>
    /// <param name="userId">userId</param>
    /// <param name="applicationName">applicationName</param>
    /// <param name="cacheKey">cacheKey</param>
    /// <param name="versionStamp">versionStamp</param>
    /// <returns>Returns the view and view model of the workflow configuration form</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string GetWorkflowConfigForm(string userId, string applicationName, string cacheKey, string versionStamp)
    {
        NextGenInvokeWorkflowHelper workflowConfig = new NextGenInvokeWorkflowHelper();
        NextGenRenderer nextGenRenderer = new NextGenRenderer();
        var baseForm = workflowConfig.GetNewFormSchema(applicationName);
        if (baseForm != null)
        {
            if (baseForm.TopLevelForm.RenderDetails.Get("formUniqueKey") == null)
            {
                baseForm.TopLevelForm.RenderDetails.Add("formUniqueKey", Skelta.Forms.Core.Common.GetFormUniqueKey(applicationName, cacheKey + "_WC", versionStamp));
            }

            return nextGenRenderer.GetSPA(baseForm);
        }

        return string.Empty;
    }

    /// <summary>
    /// Gets the Mqtt Form Configuration
    /// </summary>
    /// <param name="userId">userId</param>
    /// <param name="applicationName">applicationName</param>
    /// <param name="cacheKey">cacheKey</param>
    /// <param name="versionStamp">versionStamp</param>
    /// <param name="cId">Control Id</param>
    /// <param name="cName">Control Name</param>
    /// <returns>Returns the view and view model of the workflow configuration form</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string GetMqttFormConfiguration(string userId, string applicationName, string cacheKey, string versionStamp, string cId, string cName)
    {
        var mqttTopicConfigurationDataModel = new MqttTopicConfigurationDataModel(applicationName);
        return mqttTopicConfigurationDataModel.GetMqttTopicFormConfiguration(userId, cacheKey, versionStamp, cId, cName);
    }

    /// <summary>
    /// Gets the Popup Form Source Form Configuration Form
    /// </summary>
    /// <param name="userId">userId</param>
    /// <param name="applicationName">applicationName</param>
    /// <param name="cacheKey">cacheKey</param>
    /// <param name="versionStamp">versionStamp</param>
    /// <returns>Returns the view and view model of the workflow configuration form</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string GetEmbeddedFormSourceConfigForm(string userId, string applicationName, string cacheKey, string versionStamp, string formName)
    {
        NextGenEmbeddedFormHelper sourceFormConfig = new NextGenEmbeddedFormHelper();
        NextGenRenderer nextGenRenderer = new NextGenRenderer();
        var baseForm = sourceFormConfig.GetNewFormSchema(applicationName, userId, formName);
        if (baseForm != null)
        {
            if (baseForm.TopLevelForm.RenderDetails.Get("formUniqueKey") == null)
            {
                baseForm.TopLevelForm.RenderDetails.Add("formUniqueKey", Skelta.Forms.Core.Common.GetFormUniqueKey(applicationName, cacheKey + "_SF", versionStamp));
            }

            return nextGenRenderer.GetSPA(baseForm);
        }

        return string.Empty;
    }

    /// <summary>
    /// Gets the Print Form Source Configuration
    /// </summary>
    /// <param name="userId">userId</param>
    /// <param name="applicationName">applicationName</param>
    /// <param name="cacheKey">cacheKey</param>
    /// <param name="versionStamp">versionStamp</param>
    /// <returns>Returns the view and view model of the workflow configuration form</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string GetPrintConfigForm(string userId, string applicationName, string cacheKey, string versionStamp, string formName)
    {
        NextGenRenderer nextGenRenderer = new NextGenRenderer();
        BaseForm baseForm = NextGenPrintFormHelper.GetNewFormSchema(applicationName, userId, formName);
        if (baseForm != null)
        {
            if (baseForm.TopLevelForm.RenderDetails.Get("formUniqueKey") == null)
            {
                baseForm.TopLevelForm.RenderDetails.Add("formUniqueKey", Skelta.Forms.Core.Common.GetFormUniqueKey(applicationName, cacheKey + "_SF", versionStamp));
            }

            return nextGenRenderer.GetSPA(baseForm);
        }

        return string.Empty;
    }

    /// <summary>
    /// Gets the Popup Form Source Form Configuration Form
    /// </summary>
    /// <param name="userId">userId</param>
    /// <param name="applicationName">applicationName</param>
    /// <param name="cacheKey">cacheKey</param>
    /// <param name="versionStamp">versionStamp</param>
    /// <returns>Returns the view and view model of the workflow configuration form</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string GetSourceConfigForm(string userId, string applicationName, string cacheKey, string versionStamp, string formName)
    {
        NextGenPopupFormHelper sourceFormConfig = new NextGenPopupFormHelper();
        NextGenRenderer nextGenRenderer = new NextGenRenderer();
        var baseForm = sourceFormConfig.GetNewFormSchema(applicationName, userId, cacheKey, versionStamp, formName);
        if (baseForm != null)
        {
            if (baseForm.TopLevelForm.RenderDetails.Get("formUniqueKey") == null)
            {
                baseForm.TopLevelForm.RenderDetails.Add("formUniqueKey", Skelta.Forms.Core.Common.GetFormUniqueKey(applicationName, cacheKey + "_SF", versionStamp));
            }

            return nextGenRenderer.GetSPA(baseForm);
        }

        return string.Empty;
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetFormDefinitionForSourceForm(string appName, string formName, string formVersion)
    {
        try
        {
            return Skelta.Forms2.Web.CommonFunctions.GetFormDefinitionForEmbeddedFormControl(appName, formName, formVersion, false);
        }
        catch (Exception ex)
        {
            return string.Empty;
        }
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static IEnumerable<string> GetFormVersions(string appName, string formName)
    {
        return Skelta.Forms2.Web.CommonFunctions.GetFormVersions(appName, formName);
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static IEnumerable<ColoredDictionary> GetFormVersionsWithAssociation(string appName, string formName, string workflowName, string workflowVersion)
    {
        return Skelta.Forms2.Web.CommonFunctions.GetFormVersionsWithAssociation(appName, formName, workflowName);
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static IEnumerable<string> GetWorkflowVersions(string appName, string workflowName)
    {
        return NextGenInvokeWorkflowHelper.GetWorkflowVersions(appName, workflowName);
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static bool IsItemQuickflow(string appName, string workflowName)
    {
        return NextGenInvokeWorkflowHelper.IsItemQuickflow(appName, workflowName);
    }

    /// <summary>
    /// Gets the new Form Definition
    /// </summary>
    /// <param name="lcsuri">the lcsuri</param>
    /// <returns>the view and view model of the new form</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string GetNewFormSchema(string userId, string applicationName, string cacheKey, string versionStamp, string listName)
    {
        ////var errorData = Skelta.Forms2.Web.CommonFunctions.VerifyUserId(userId);
        ////if (!string.IsNullOrEmpty(errorData))
        ////{
        ////    return errorData;
        ////}
        string viewAndViewModel = string.Empty;
        FormSchema formSchema = new FormSchema();
        NextGenRenderer nextGenRenderer = new NextGenRenderer();
        var baseForm = formSchema.GetNewFormSchema(applicationName, cacheKey, versionStamp, listName);
        if (baseForm != null)
        {
            if (baseForm.TopLevelForm.RenderDetails.Get("formUniqueKey") == null)
            {
                baseForm.TopLevelForm.RenderDetails.Add("formUniqueKey", Skelta.Forms.Core.Common.GetFormUniqueKey(applicationName, cacheKey + "_FS", versionStamp));
            }

            return nextGenRenderer.GetSPA(baseForm);
        }

        return string.Empty;
    }

    /// <summary>
    /// Gets the new custom Form control Definition
    /// </summary>
    /// <param name="lcsuri">the lcsuri</param>
    /// <returns>the view and view model of the new form</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string GetNewCustomFormControlDefinition(string lcsuri)
    {
        ListPageParameters listParams = new ListPageParameters();
        listParams.ResolveUriValue(lcsuri);
        ////var errorData = Skelta.Forms2.Web.CommonFunctions.VerifyUserId(listParams.LoggedInUserId);
        ////if (!string.IsNullOrEmpty(errorData))
        ////{
        ////    return errorData;
        ////}
        string viewAndViewModel = string.Empty;
        NewCustomFormControl newCustomFormControl = new NewCustomFormControl();
        NextGenRenderer nextGenRenderer = new NextGenRenderer();
        var baseForm = newCustomFormControl.NewEntryCustomFormControl();
        if (baseForm != null)
        {
            if (baseForm.TopLevelForm.RenderDetails.Get("formUniqueKey") == null)
            {
                baseForm.TopLevelForm.RenderDetails.Add("formUniqueKey", Skelta.Forms.Core.Common.GetFormUniqueKey(listParams.ApplicationName, listParams.ListItemId + "_CC", listParams.VersionStamp));
            }
            return nextGenRenderer.GetSPA(baseForm);
        }

        return string.Empty;
    }


    /// <summary>
    ///  Gets the Form Definition
    /// </summary>
    /// <param name="lcsuri">the lcsuri</param>
    /// <returns>the view and view model of the form</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string GetFormDefinition(string lcsuri)
    {
        ListPageParameters listParams = new ListPageParameters();
        listParams.ResolveUriValue(lcsuri);
        ListDefinition listDef = ListDefinition.GetList(new Skelta.Core.ApplicationObject(listParams.ApplicationName), listParams.ListName);
        Skelta.Repository.List.ListItem formItem = new Skelta.Repository.List.ListItem(listDef, listParams.ListItemId, listParams.VersionStamp);
        formItem.LoggedInUserId = listParams.LoggedInUserId;
        BaseForm baseForm;

        string viewAndViewModel = string.Empty;
        NewForm newForm = new NewForm();
        NextGenRenderer nextGenRenderer = new NextGenRenderer();
        Workflow.NET.SkeltaResourceSetManager resourceSetManager = new Workflow.NET.SkeltaResourceSetManager();
        if (formItem.LockEnabled)
        {
            AjaxResponseObject ajaxResponseObject = new AjaxResponseObject();
            ajaxResponseObject.IsSuccess = true;
            if (formItem.IsLocked)
            {
                if (formItem.IsLockedByOther)
                {
                    ajaxResponseObject.IsSuccess = false;
                    ajaxResponseObject.ErrorMessage = resourceSetManager.GlobalResourceSetForNextGenForms.GetString("ec_ngf_item_edit_lock_msg") + " " + formItem.LockedByUser;
                    return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(ajaxResponseObject);
                }
                else
                {
                    baseForm = newForm.GetEditForm(listParams);
                }
            }
            else
            {
                baseForm = newForm.GetEditForm(listParams);
            }

        }
        else
        {
            baseForm = newForm.GetEditForm(listParams);
        }

        if (baseForm != null)
        {
            if (baseForm.TopLevelForm.RenderDetails.Get("formUniqueKey") == null)
            {
                baseForm.TopLevelForm.RenderDetails.Add("formUniqueKey", Skelta.Forms.Core.Common.GetFormUniqueKey(listParams.ApplicationName, listParams.ListItemId + "_EF", listParams.VersionStamp));
            }

            var spa = nextGenRenderer.GetSPA(baseForm);
            var instanceXml = baseForm.FormInstanceXml;
            Dictionary<string, string> vals = new Dictionary<string, string>();

            vals.Add("spa", spa);
            vals.Add("instanceXml", instanceXml);

            return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(vals);
        }

        return string.Empty;
    }

    /// <summary>
    /// Validates the E-Signature values
    /// </summary>
    /// <param name="userName">User Name</param>
    /// <param name="password">password</param>
    /// <returns>Bool value whether the values are valid</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string ValidateUserInESignature(string userName, string password, string appName, string userId)
    {
        Dictionary<string, string> vals = new Dictionary<string, string>();
        int errorCode = -1;
        bool isValidUser = false;

        try
        {
            isValidUser = Skelta.Forms2.Web.CommonFunctions.ValidateUser(userName, password, appName, userId);
        }
        catch (Exception ex)
        {
            var log = new Log();
            log.LogError(ex, "Error at Validating User In E-Signature = " + ex.Message);
        }

        vals.Add("isValid", isValidUser.ToString());

        return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(vals);
    }

    /// <summary>
    /// Inserts Report Viewer instance xml id
    /// </summary>
    /// <param name="applicationName">Application name</param>
    /// <param name="instanceXml">Instance xml</param>
    /// <param name="formId">Forms id</param>
    /// <returns>Instance xml id</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string InsertReportViewerInstanceXmlId(string applicationName, string instanceXml, Guid formId)
    {
        return AjaxHelperFunctions.InsertReportViewerInstanceXmlId(applicationName, instanceXml, formId);
    }

    /// <summary>
    /// Gets secured uri to download report
    /// </summary>
    /// <param name="applicationName">Application name</param>
    /// <returns>Donwload Report Parameters</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string GetDownloadReportParameters(string applicationName, string ssrsItemIdOrTitle)
    {
        return AjaxHelperFunctions.GetDownloadReportParameters(applicationName, ssrsItemIdOrTitle);
    }

    /// <summary>
    /// Gets the new Form Definition
    /// </summary>
    /// <returns>the view and view model of the new form</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Xml)]
    public static string GetListEditFormDefinition(string lcsuri)
    {
        try
        {
            string viewAndViewModel = string.Empty;

            NextGenRenderer nextGenRenderer = new NextGenRenderer();
            ListPageParameters listParams = new ListPageParameters();
            listParams.ResolveUriValue(lcsuri);
            ////var errorData = Skelta.Forms2.Web.CommonFunctions.VerifyUserId(listParams.LoggedInUserId);
            ////if (!string.IsNullOrEmpty(errorData))
            ////{
            ////    return errorData;
            ////}
            ListDataHandler handler = new ListDataHandler(listParams.ApplicationName, "Forms List", false);
            var formItem = handler.GetListItem(listParams.ListName);
            if (formItem.Status == ListItemVersionStatus.Published)
            {
                var listItemVersion = formItem.GetLatestPublishedVersionInformation() ?? formItem.GetLatestVersionInformation();
                string jsonViewAndViewModel = GetViewAndViewModel(listParams.ApplicationName, listParams.LoggedInUserId, listParams.ListName, listItemVersion.VersionStamp, "Forms List", "Web");
                var viewAndViewModelWithFormParam = Skelta.Forms2.Web.CommonFunctions.ParseJsonObject<Dictionary<string, string>>(jsonViewAndViewModel);
                if (viewAndViewModelWithFormParam != null)
                {
                    viewAndViewModelWithFormParam.TryGetValue("ViewAndViewModel", out viewAndViewModel);
                }
            }

            return viewAndViewModel;
        }
        catch (Exception ex)
        {
            Log log = new Log();
            log.LogError(ex, ResourceSet.GetString("FormNGFDynamicFormLoadError"));
            return "error";
        }
    }

    /// <summary>
    /// Creates a new form
    /// </summary>
    /// <param name="xmlInstance">The instance xml</param>
    /// <param name="lcsuri">the encoded uri</param>
    /// <returns>the result whether it was success or failure with details</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string SaveListItem(string pageOpenMode, string xmlInstance, string lcsuri)
    {
        try
        {
            if (!Skelta.Repository.Security.CommonFunctions.ValidateXmlInstance(xmlInstance) || !Skelta.Repository.Security.CommonFunctions.IsQueryStringValid(pageOpenMode))
            {
                AjaxResponseObject ajaxResponseObject = new AjaxResponseObject();
                var resourceSet = new SkeltaResourceSetManager().GlobalResourceSet;
                ajaxResponseObject.ErrorMessage = resourceSet.GetString("HtmlAndScript_Error");
                ajaxResponseObject.IsSuccess = false;

                return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(ajaxResponseObject);
            }

            string viewAndViewModel = string.Empty;

            NextGenRenderer nextGenRenderer = new NextGenRenderer();
            ListPageParameters listParams = new ListPageParameters();
            listParams.ResolveUriValue(lcsuri);
            ////var errorData = Skelta.Forms2.Web.CommonFunctions.VerifyUserId(listParams.LoggedInUserId);
            ////if (!string.IsNullOrEmpty(errorData))
            ////{
            ////    return errorData;
            ////}
            return AjaxHelperFunctions.SaveListItem(pageOpenMode, listParams, xmlInstance);
        }
        catch (Exception ex)
        {
            string errorMessage = ResourceSet.GetString("FormNGFDynamicFormSaveError");
            Log log = new Log();
            log.LogError(ex, errorMessage);

            AjaxResponseObject ajaxResponseObject = new AjaxResponseObject();
            ajaxResponseObject.IsSuccess = false;
            ajaxResponseObject.ErrorMessage = errorMessage;

            return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(ajaxResponseObject);
        }
    }

    /// <summary>
    /// Creates a new form
    /// </summary>
    /// <param name="xmlInstance">The instance xml</param>
    /// <param name="lcsuri">the encoded uri</param>
    /// <returns>the result whether it was success or failure with details</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string CreateNewForm(string xmlInstance, string lcsuri)
    {
        string viewAndViewModel = string.Empty;

        NextGenRenderer nextGenRenderer = new NextGenRenderer();
        ListPageParameters listParams = new ListPageParameters();
        listParams.ResolveUriValue(lcsuri);
        ////var errorData = Skelta.Forms2.Web.CommonFunctions.VerifyUserId(listParams.LoggedInUserId);
        ////if (!string.IsNullOrEmpty(errorData))
        ////{
        ////    return errorData;
        ////}
        NewForm newForm = new NewForm();
        return newForm.CreateNewForm(xmlInstance, listParams);
    }

    /// <summary>
    /// Creates a new custom control
    /// </summary>
    /// <param name="xmlInstance">The instance xml</param>
    /// <param name="lcsuri">the encoded uri</param>
    /// <returns>the result whether it was success or failure with details</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string CreateNewCustomFormControl(string xmlInstance, string lcsuri)
    {
        NextGenRenderer nextGenRenderer = new NextGenRenderer();
        ListPageParameters listParams = new ListPageParameters();
        listParams.ResolveUriValue(lcsuri);
        ////var errorData = Skelta.Forms2.Web.CommonFunctions.VerifyUserId(listParams.LoggedInUserId);
        ////if (!string.IsNullOrEmpty(errorData))
        ////{
        ////    return errorData;
        ////}
        NewCustomFormControl newCustomControl = new NewCustomFormControl();
        return newCustomControl.CreateNewFormControl(xmlInstance, listParams);
    }


    /// <summary>
    /// Update the form
    /// </summary>
    /// <param name="xmlInstance">The instance xml</param>
    /// <param name="lcsuri">the encoded uri</param>
    /// <returns>the result whether it was success or failure with details</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string UpdateForm(string xmlInstance, string lcsuri)
    {
        NextGenRenderer nextGenRenderer = new NextGenRenderer();
        ListPageParameters listParams = new ListPageParameters();
        listParams.ResolveUriValue(lcsuri);
        ////var errorData = Skelta.Forms2.Web.CommonFunctions.VerifyUserId(listParams.LoggedInUserId);
        ////if (!string.IsNullOrEmpty(errorData))
        ////{
        ////    return errorData;
        ////}
        NewForm newForm = new NewForm();
        return newForm.UpdateForm(xmlInstance, listParams);
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetPageDefaults(string themePath, string culture, string lastModifiedLocaleTime, string lcsuri, string userId, string appName)
    {
        return Skelta.Forms2.Web.CommonFunctions.PageDefaults(themePath, culture, lastModifiedLocaleTime, userId, appName);
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetCurrentContextWithSecurityCheck(string secUri, string[] rightCodes, string deviceType)
    {
        return Skelta.Forms2.Web.CommonFunctions.GetCurrentContextWithSecurityCheck(secUri, rightCodes, deviceType);
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetCurrentContextForWorkitemInbox(string secUri, string deviceType)
    {
        return Skelta.Forms2.Web.CommonFunctions.GetCurrentContextForWorkItemInbox(secUri, deviceType);
    }


    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetCurrentContextWithSecurityCheckForList(string secUri, string[] rightCodes, bool forList, string mode)
    {
        return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(Skelta.Forms2.Web.CommonSecurityLib.GetCurrentContextWithSecurityCheck(secUri, rightCodes, forList, mode));
    }

    /// <summary>
    /// Get list form validation error count
    /// </summary>
    /// <param name="applicationName">application name</param>
    /// <param name="listName">list name</param>
    /// <returns></returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetListFormValidationErrorCount(string applicationName, string listName, string userId)
    {
        ////var errorData = Skelta.Forms2.Web.CommonFunctions.VerifyUserId(userId);
        ////if (!string.IsNullOrEmpty(errorData))
        ////{
        ////    return errorData;
        ////}

        Skelta.Forms.Web.Common.ValidateListForm validateLstFrm = new Skelta.Forms.Web.Common.ValidateListForm(applicationName, listName);
        validateLstFrm.Validate(true);
        return validateLstFrm.ValidationErrors.Count.ToString();
    }

    /// <summary>
    /// Creates Control tree structure of a NextGen Form
    /// </summary>
    /// <param name="applicationName">application name</param>
    /// <param name="userId">user id</param>
    /// <param name="formName">form name</param>
    /// <param name="versionStamp">version stamp</param>
    /// <param name="listName">list name</param>
    /// <param name="deviceType">device types</param>
    /// <returns>return control tree</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetControlStructureData(string applicationName, string cacheKey, string userId, string formName, string versionStamp, string listName, string deviceType)
    {
        ////var errorData = Skelta.Forms2.Web.CommonFunctions.VerifyUserId(userId);
        ////if (!string.IsNullOrEmpty(errorData))
        ////{
        ////    return errorData;
        ////}

        return new NextGenDesigner().GetControlStructureData(applicationName, cacheKey, versionStamp, listName);
    }

    /// <summary>
    /// Gets DataBound Control Data based on lookup
    /// </summary>
    /// <param name="appName">Repository Name</param>
    /// <param name="uId">User Id</param>
    /// <param name="source">Lookup Name</param>
    /// <param name="fd">Filter Data</param>
    /// <param name="pn">page number</param>
    /// <param name="ps">page size</param>
    /// <param name="lp">Lookup Parameter</param>
    /// <returns>data from lookup</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string FilterLookupData(string appName, string uId, string source, string fd, int pn, int ps, IEnumerable<LookupParameter> lp)
    {
        return LookupDataHelper.FilterLookupData(appName, uId, source, fd, pn, ps, lp);
    }

    /// <summary>
    /// Gets DataBound Control Data
    /// </summary>
    /// <param name="appName">repository name</param>
    /// <param name="uId">logged in user</param>
    /// <param name="source">Lookup Name</param>
    /// <returns>lookup data</returns>
    /// <param name="pn">page number</param>
    /// <param name="ps">page size</param>
    /// <param name="lp">Lookup Parameter</param>
    /// <returns>data from lookup</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string GetLookupData(string appName, string uId, string source, int pn, int ps, IEnumerable<LookupParameter> lp)
    {
        return LookupDataHelper.GetLookupData(appName, uId, source, pn, ps, lp);
    }

    /// <summary>
    /// Resolves lookup value
    /// </summary>
    /// <param name="appName">repository name</param>
    /// <param name="uId">logged in user</param>
    /// <param name="source">data source Id</param>
    /// <param name="lv">selected Value</param>
    /// <param name="lp">Lookup Parameters</param>
    /// <returns>display text of the selected value</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string ResolveLookupValue(string appName, string uId, string source, string lv, IEnumerable<LookupParameter> lp)
    {
        return LookupDataHelper.ResolveLookupValue(appName, uId, source, lv, lp);
    }

    /// <summary>
    /// Gets extended information of the lookup
    /// </summary>
    /// <param name="appName">repository name</param>
    /// <param name="uId">logged in user</param>
    /// <param name="source">data source Id</param>
    /// <param name="lv">selected Value</param>
    /// <param name="lp">Lookup Parameters</param>
    /// <returns>serialized extended information</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string LookupExtendedInformation(string appName, string uId, string source, string lv, IEnumerable<LookupParameter> lp)
    {
        return LookupHelper.ExtendedInformation(appName, uId, source, lv, lp);
    }


    /// <summary>
    /// Get Full form Schema
    /// </summary>
    /// <param name="applicationName">application Name</param>
    /// <param name="cacheKey">cache key</param>
    /// <param name="versionStamp">form version</param>
    /// <param name="listName">list name</param>
    /// <param name="workflowDetails">workfow details</param>
    /// <param name="xmlVariableName">xml variable name</param>
    /// <returns>Full form schema</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetFullFormSchema(string xmlInstance, string applicationName, string cacheKey, string versionStamp, string listName, string workflowDetails, string xmlVariableName)
    {
        string fullFormSchema = string.Empty;
        fullFormSchema = FormSchema.GetFullFormSchema(xmlInstance, applicationName, cacheKey, versionStamp, listName, workflowDetails, xmlVariableName);
        return fullFormSchema;
    }

    public class TempData
    {
        public string key { get; set; }
        public string value { get; set; }
    }

    /// <summary>
    /// Gets grid data from the server
    /// </summary>
    /// <returns>Json string</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetGridInformation(string gridConfigName, string appName, string userId, string deviceType)
    {
        var resultData = string.Empty;
        var log = new Log();

        try
        {
            var gridConfigurationItem = GridHelper.GetGridConfigurationInstance(appName, gridConfigName);
            if (gridConfigurationItem != null)
            {
                DateTime gridConfigLastModifiedDateTime = gridConfigurationItem.LastReadDateTime;

                ////Removing the millisecond
                gridConfigLastModifiedDateTime = gridConfigLastModifiedDateTime.AddMilliseconds(-gridConfigLastModifiedDateTime.Millisecond);
                HttpContext.Current.Response.CacheControl = HttpCacheability.Public.ToString();
                DateTime ifModified = HttpContext.Current.Request.Headers["If-Modified-Since"] != null ? DateTime.Parse(HttpContext.Current.Request.Headers["If-Modified-Since"], CultureInfo.InvariantCulture) : DateTime.MinValue;

                if (ifModified < gridConfigLastModifiedDateTime || deviceType != "Web" || Skelta.FarmManager.Platform.Azure == Workflow.NET.CommonFunctions.GetPlatformType())
                {
                    HttpContext.Current.Response.AddHeader("Last-Modified", gridConfigLastModifiedDateTime.ToUniversalTime().ToString("r"));

                    resultData = GridHelper.GetGridInformation(gridConfigName, appName);

                    if (resultData.StartsWith("error:"))
                    {
                        return string.Empty;
                    }

                    //// Add the Compression Filter to the Header if the Client Supports it.
                    SetCompressionFilterToHeader();
                }
                else
                {
                    HttpContext.Current.Response.AddHeader("Content-Length", "0");
                    HttpContext.Current.Response.StatusCode = 304;

                    int iDebugLevel = new Config(appName).IntegerDebugLevel;
                    if (iDebugLevel >= 2)
                    {
                        log.LogInformation("Grid '" + gridConfigName + "' information is fetched from client cache.", appName);
                    }

                    return string.Empty;
                }
            }
        }
        catch (System.Exception e)
        {
            log.LogError(e, "Error while getting grid information for '" + gridConfigName + "'", appName);
        }

        return resultData;
    }

    /// <summary>
    /// Gets grid data from the server
    /// </summary>
    /// <returns>Json string</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string GetGridConfigData(string appName, string userId, string config, string source, IEnumerable<LookupParameter> parameters, bool schemaRequired, bool jsonSchemaRequired, bool extendedInfoRequired, bool getCultureSpecificValues)
    {
        try
        {
            return GridHelper.GridData(config, source, appName, userId, schemaRequired, jsonSchemaRequired, parameters, extendedInfoRequired, getCultureSpecificValues, string.Empty);
        }
        catch (Exception e)
        {
            var logger = new Log();
            logger.LogError(e, "Error while getting grid data for '" + config + "'", appName);
            logger.Close();
        }

        return string.Empty;
    }

    /// <summary>
    /// Gets utc offset from the server
    /// </summary>
    /// <returns></returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetServerUTCOffset()
    {
        var ts = DateTime.UtcNow - DateTime.Now;
        return ts.TotalMinutes.ToString();
    }

    /// <summary>
    /// Validate and save the Invoke workflow properties
    /// </summary>
    /// <param name="xmlInstance">Form insatnce xml</param>
    /// <param name="cacheKey">form key</param>
    /// <param name="listName">list name</param>
    /// <param name="version">form version</param>
    /// <param name="controlId">controls id</param>
    /// <param name="applicationName">application name</param>
    /// <param name="userId">user id</param>
    /// <returns>ajax response object string</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string ValidateInvokeWorkflowProperties(string xmlInstance, string cacheKey, string listName, string version, string selectedControl, string applicationName, string userId)
    {
        NextGenDesigner nextGenDesigner = new NextGenDesigner();
        return nextGenDesigner.ValidateAndSaveInvokeWorkflowProperties(xmlInstance, cacheKey, listName, version, selectedControl, applicationName, userId);
    }

    /// <summary>
    /// Function to execute the workflow
    /// </summary>
    /// <param name="applicationName">application name</param>
    /// <param name="userId">user id</param>
    /// <param name="workflowDetails">workflow details</param>
    /// <param name="invokeWorkflowId">invoke workflow control id</param>
    /// <param name="xmlVariableName">xml variable name</param>
    /// <param name="xmlInstance">instance xml</param>
    /// <param name="formName">form name</param>
    /// <param name="versionStamp">form version</param>
    /// <param name="containerId">container id</param>
    /// <returns>return the execution message</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Xml)]
    public static string ExecuteWorkFlow(string applicationName, string userId, string workflowDetails, string invokeWorkflowId, string xmlVariableName, string xmlInstance, string formName, string versionStamp, string executionMode, string embedContainerId, string popupContainerId, string popupParentEmbedContainerId, string schemaType, string mappingSchema)
    {
        NextGenRenderer nextGenRenderer = new NextGenRenderer();
        return nextGenRenderer.TriggerWorkflow(applicationName, userId, workflowDetails, invokeWorkflowId, xmlVariableName, xmlInstance, formName, versionStamp, executionMode, embedContainerId, popupContainerId, popupParentEmbedContainerId, schemaType, mappingSchema);
    }

    /// <summary>
    /// Gets key data from server
    /// </summary>
    /// <returns>Key for encryption</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetKeyDataFromServer()
    {
        return Skelta.Forms2.Web.AjaxCallDependencyFunctions.GetKeyDataFromServer();
    }

    /// <summary>
    /// This method will generate the view and view model for Lookup Source configuration window
    /// </summary>
    /// <param name="appName">repository name</param>
    /// <param name="uId">user id</param>
    /// <param name="ck">Cache key</param>
    /// <param name="vs">version stamp</param>
    /// /// <param name="id">Id value</param>
    /// <returns>the view and view model</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Xml)]
    public static string GetDataLookupPropertySourceForm(string appName, string uId, string ck, string vs, string id)
    {
        try
        {
            var nextGenRenderer = new NextGenRenderer();
            return nextGenRenderer.GetSPA(LookupHelper.DataLookupPropertyConfigurationForm(appName, uId, ck, vs, id));
        }
        catch (System.Exception e)
        {
            var logger = new Log();
            logger.LogError(e, "Error while loading the lookup configuration form.", appName);
            logger.Close();
            return string.Empty;
        }
    }

    /// <summary>
    /// This method will generate the view and view model for Lookup Source configuration window
    /// </summary>
    /// <param name="appName">repository name</param>
    /// <param name="uId">user id</param>
    /// <param name="ck">Cache key</param>
    /// <param name="vs">version stamp</param>
    /// <param name="id">Id</param>
    /// <param name="isSankeyChart">Is Sankey Chart</param>
    /// <returns>the view and view model</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Xml)]
    public static string GetDataLookupPropertyChartSourceForm(string appName, string uId, string ck, string vs, string id, string isSankeyChart)
    {
        try
        {
            var nextGenRenderer = new NextGenRenderer();
            return nextGenRenderer.GetSPA(LookupHelper.DataLookupPropertyChartConfigurationForm(appName, uId, ck, vs, id, isSankeyChart));
        }
        catch (System.Exception e)
        {
            var logger = new Log();
            logger.LogError(e, "Error while loading the lookup configuration form.", appName);
            logger.Close();
            return string.Empty;
        }
    }

    /// <summary>
    /// This method will generate the view and view model for Lookup Source configuration window for Hierarchical List
    /// </summary>
    /// <param name="appName">repository name</param>
    /// <param name="uId">user id</param>
    /// <param name="ck">Cache key</param>
    /// <param name="vs">version stamp</param>
    /// <returns>the view and view model</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Xml)]
    public static string GetDataLookupPropertySourceFormForHierarchicalList(string appName, string uId, string ck, string vs)
    {
        try
        {
            var nextGenRenderer = new NextGenRenderer();
            return nextGenRenderer.GetSPA(LookupHelper.DataLookupPropertyConfigurationFormForHierarchicalList(appName, uId, ck, vs));
        }
        catch (System.Exception e)
        {
            var logger = new Log();
            logger.LogError(e, "Error while loading the lookup configuration form.", appName);
            logger.Close();
            return string.Empty;
        }
    }

    /// <summary>
    /// This method will generate the view and view model for Grid Source configuration window
    /// </summary>
    /// <param name="appName">repository name</param>
    /// <param name="uId">user id</param>
    /// <param name="ck">Cache key</param>
    /// <param name="vs">version stamp</param>
    /// <param name="id">ID Value</param>
    /// <returns>the view and view model</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Xml)]
    public static string GetGridSourceForm(string appName, string uId, string ck, string vs, string id)
    {
        var nextGenRenderer = new NextGenRenderer();
        try
        {
            return nextGenRenderer.GetSPA(GridHelper.GridConfigurationForm(appName, uId, ck, vs, id));
        }
        catch (System.Exception e)
        {
            var logger = new Log();
            logger.LogError(e, "Error while loading the grid configuration form.", appName);
            logger.Close();
            return string.Empty;
        }
    }

    /// <summary>
    /// Gets Lookup Parameters for the given grid config
    /// </summary>
    /// <param name="appName">repository name</param>
    /// <param name="uId">user id</param>
    /// <param name="source">Config Name</param>
    /// <returns>Lookup Parameters</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetGridParameters(string appName, string uId, string configName)
    {
        return GridHelper.GridParameters(appName, uId, configName);
    }

    /// <summary>
    /// This method will get lookup items based on lookup provider
    /// </summary>
    /// <param name="appName">repository name</param>
    /// <param name="uId">user id</param>
    /// <param name="lp">Lookup Providers</param>
    /// <returns>the view and view model</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static IEnumerable<string> LookupNames(string appName, string uId, string lp)
    {
        return LookupHelper.LookupItems(appName, uId, lp);
    }

    /// <summary>
    /// Gets Lookup Parameters for the given lookup
    /// </summary>
    /// <param name="appName">repository name</param>
    /// <param name="uId">user id</param>
    /// <param name="source">Data source</param>
    /// <returns>Lookup Parameters</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static IEnumerable<string> LookupParameters(string appName, string uId, string source)
    {
        return LookupHelper.LookupParameters(appName, uId, source);
    }

    /// <summary>
    /// Gets information for loading Invoke form
    /// </summary>
    /// <param name="qs">workItem request</param>
    /// <param name="type">request type</param>
    /// <returns>document view, manage work item and frame height for loading the work item invoke form</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Xml)]
    public static string GetfileContent(string file)
    {
        return Skelta.Forms2.Web.CommonFunctions.GetFileContent(file);
    }

    /// <summary>
    /// Gets information for loading Invoke form
    /// </summary>
    /// <param name="qs">workItem request</param>
    /// <param name="type">request type</param>
    /// <returns>document view, manage work item and frame height for loading the work item invoke form</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Xml)]
    public static string GetFormLevelCssFileContent(string file, string applicationName, string userId)
    {
        return Skelta.Forms2.Web.CommonFunctions.GetFormLevelCssFileContent(file, applicationName, userId);
    }

    /// <summary>
    /// check if User Has Read Write Permission
    /// </summary>
    /// <param name="applicationName">repository name</param>
    /// <param name="userId">user id</param>
    /// <returns>true / false for permissions</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static bool UserHasReadWritePermission(string applicationName, string userId)
    {
        return Skelta.Forms2.Web.CommonFunctions.CheckReadWritePermission(applicationName, userId);
    }

    /// <summary>
    /// Get the Replace control 
    /// <param name="cacheKey"> id of the cache</param>
    /// <param name="listName">name of the list</param>
    /// <param name="versionStamp">version of the form</param>
    /// <param name="containerId">form id</param>
    /// <param name="target">target control</param>
    /// <param name="controlType">type of the control for which properties has to be edited</param>
    /// <param name="applicationName">Application Name</param>
    /// <returns>the view and view model for the replace control page</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Xml)]
    public static string GetNewControlSelection(string cacheKey, string listName, string versionStamp, string containerId, string target, string applicationName, string userId)
    {
        string viewAndViewModel = string.Empty;
        Skelta.Forms2.Web.NextGenForms.ReplaceControl replaceCtrl = new Skelta.Forms2.Web.NextGenForms.ReplaceControl();
        NextGenRenderer nextGenRenderer = new NextGenRenderer();
        var baseForm = replaceCtrl.GetReplaceControlDefinition(cacheKey, listName, versionStamp, containerId, target, applicationName, userId);
        if (baseForm != null)
        {
            if (baseForm.TopLevelForm.RenderDetails.Get("formUniqueKey") == null)
            {
                baseForm.TopLevelForm.RenderDetails.Add("formUniqueKey", Skelta.Forms.Core.Common.GetFormUniqueKey(applicationName, cacheKey + "_RC", versionStamp));
            }
            viewAndViewModel = nextGenRenderer.GetSPA(baseForm);
        }

        return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(new { vm = viewAndViewModel, pcc = replaceCtrl.ProblematicCustomControls });
    }

    /// <summary>
    /// Function to the replace the selected controls value in the form definition and returns the updated view of that control
    /// </summary>
    /// <param name="xmlInstance">Xml Instance of the properties</param>
    /// <param name="cacheKey">Form id</param>
    /// <param name="listName">list Name</param>
    /// <param name="version">form version</param>
    /// <param name="selectedControl">selected control</param>
    /// <param name="applicationName">application Name</param>
    /// <param name="userId">Logged In User</param>
    /// <returns>updated view of selected control</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Xml)]
    public static string ReplaceSelectedControl(string xmlInstance, string cacheKey, string listName, string version, string selectedControl, string applicationName, string userId)
    {
        return new NextGenDesigner().ReplaceControlAndReturnView(xmlInstance, cacheKey, listName, version, selectedControl, applicationName, userId);
    }

    /// <summary>
    /// Logs client side logs to Workflow Management Logger console
    /// </summary>
    /// <param name="message">Log Message</param>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static void LogMessage(Collection<Skelta.Forms2.Web.LogMessages> message)
    {
        Skelta.Forms2.Web.CommonFunctions.LogMessage(message);
    }

    /// <summary>
    /// Gets the new package runtime settings form Definition
    /// </summary>
    /// <returns>the view and view model of the new runtime settings form</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Xml)]
    public static string GetPackageRuntimeSettingsForm(string lcsuri, string formName, string formVersion)
    {
        ListPageParameters listParams = new ListPageParameters();
        listParams.ResolveUriValue(lcsuri);
        string formDefinition = FormsCommonFunctions.GetRuntimeSettingsFormDefinition(listParams.ApplicationName, formName, formVersion);
        NextGenRenderer nextGenRenderer = new NextGenRenderer();
        var viewAndViewModel = string.Empty;
        if (!string.IsNullOrEmpty(formDefinition))
        {
            var baseForm = BaseForm.LoadDefinitionXml(formDefinition);
            if (baseForm != null)
            {
                if (baseForm.TopLevelForm.RenderDetails.Get("formUniqueKey") == null)
                {
                    baseForm.TopLevelForm.RenderDetails.Add("formUniqueKey", Skelta.Forms.Core.Common.GetFormUniqueKey(listParams.ApplicationName, listParams.ListItemId.ToString(), listParams.VersionStamp));
                }

                var view = nextGenRenderer.GetView(baseForm);
                var viewModel = nextGenRenderer.GetViewModel(baseForm);
                viewAndViewModel = view + viewModel;
                viewAndViewModel = Skelta.Forms2.Web.CommonFunctions.ProcessLocalization(viewAndViewModel, Skelta.Forms2.Web.CommonFunctions.GetCurrentECCulture);
                return viewAndViewModel;
            }
        }

        return string.Empty;
    }

    /// <summary>
    /// Gets the Form Definition for editing the runtime settings form
    /// </summary>
    /// <returns>the view and view model of the runtime settings form</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Xml)]
    public static string GetEditPackageRuntimeSettingsForm(string lcsuri, string formName, string formVersion)
    {
        string viewAndViewModel = string.Empty;

        NextGenRenderer nextGenRenderer = new NextGenRenderer();
        ListPageParameters listParams = new ListPageParameters();
        listParams.ResolveUriValue(lcsuri);
        ListDataHandler handler = new ListDataHandler(listParams.ApplicationName, "Forms List", false);
        var formItem = handler.GetListItem(formName, formVersion);
        var viewNViewModel = string.Empty;
        if (formItem.Status == ListItemVersionStatus.Published)
        {
            var listItemVersion = formItem.GetLatestPublishedVersionInformation() ?? formItem.GetLatestVersionInformation();
            string jsonViewAndViewModel = GetViewAndViewModel(listParams.ApplicationName, listParams.LoggedInUserId, formName, listItemVersion.VersionStamp, "Forms List", "Web");
            var viewAndViewModelWithFormParam = Skelta.Forms2.Web.CommonFunctions.ParseJsonObject<Dictionary<string, string>>(jsonViewAndViewModel);
            if (viewAndViewModelWithFormParam != null)
            {
                viewAndViewModelWithFormParam.TryGetValue("ViewAndViewModel", out viewNViewModel);
            }
        }

        return viewNViewModel;
    }

    /// <summary>
    /// Get form instance xml of runtime settings form
    /// </summary>
    /// <param name="lcsuri">list query string parameters</param>
    /// <returns>The instance xml of the runtime settings form</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetPackageRuntimeSettingsInstanceXml(string lcsuri)
    {
        ListPageParameters listParams = new ListPageParameters();
        listParams.ResolveUriValue(lcsuri);
        return FormsCommonFunctions.GetPackageRuntimeSettingsInstanceXml(listParams);
    }


    /// <summary>
    /// Save Package Runtime Settings
    /// </summary>
    /// <param name="xmlInstance">The instance xml</param>
    /// <param name="lcsuri">the encoded uri</param>
    /// <returns>the result whether it was success or failure with details</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string SavePackageRuntimeSettings(string xmlInstance, string lcsuri, string formName, string formVersion)
    {
        string viewAndViewModel = string.Empty;
        NextGenRenderer nextGenRenderer = new NextGenRenderer();
        ListPageParameters listParams = new ListPageParameters();
        listParams.ResolveUriValue(lcsuri);
        return FormsCommonFunctions.SavePackageRuntimeSettings(listParams, xmlInstance, formName, formVersion);
    }

    /// <summary>
    /// gets view, viewmodel and instance form xml for making single page for runtime settings form for package install
    /// </summary>
    /// <param name="lcsuri">list query string parameters</param>
    /// <returns>view, viewmodel and instance form xml</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetPackageRuntimeSettingsDeploySinglePage(string lcsuri)
    {
        ListPageParameters listParams = new ListPageParameters();
        listParams.ResolveUriValue(lcsuri);
        return FormsCommonFunctions.GetPackageRuntimeSettingsDeploySinglePage(listParams);
    }

    /// <summary>
    /// Save runtime settings form
    /// </summary>
    /// <param name="lcsuri">list query string parameters</param>
    /// <param name="xmlInstance">instance xml</param>
    /// <returns>result of the save operation</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string SavePackageRuntimeSettingsDeploy(string lcsuri, string xmlInstance)
    {
        ListPageParameters listParams = new ListPageParameters();
        listParams.ResolveUriValue(lcsuri);
        return FormsCommonFunctions.SavePackageRuntimeSettingsDeploy(listParams, xmlInstance);
    }

    /// <summary>
    /// Gets Form parameters from the form link and form
    /// </summary>
    /// <param name="fl">form link</param>
    /// <param name="app">repository name</param>
    /// <param name="fn">form name</param>
    /// <param name="fv">form version</param>
    /// <returns></returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetFormLinkFormParameters(string fl, string app, string fn, string fv)
    {
        return Skelta.Forms.Web.Common.FormLinkHelper.GetFormParametersAndFormLinkParameters(fl, app, fn, fv, new ListInfoExtractor());
    }

    /// <summary>
    /// Gets Form parameters from the form
    /// </summary>
    /// <param name="f">form name</param>
    /// <param name="app">repository name</param>
    /// <returns></returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetFormParametersForFormLink(string f, string app)
    {
        return FormLinkHelper.GetSerializedFormParameters(f, app);
    }

    /// <summary>
    /// Returns the JSON string with the Kendo RichTextbox control's localization strings
    /// </summary>
    /// <returns>Returns the JSON string with localization strings</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string FetchKendoRichTextBoxLocalizationStrings()
    {
        return Skelta.Forms.Web.CommonFunctions.FetchKendoRichTextBoxLocalizationStrings();
    }

    /// <summary>
    /// Get form instance xml from InTouch
    /// </summary>
    /// <param name="applicationName">Application name</param>
    /// <param name="guidKey">Id of SKEPopupTemp table where instance xml is stored</param>
    /// <returns>Instance xml</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetInstanceXmlForInTouch(string applicationName, string guidKey)
    {
        return AjaxHelperFunctions.GetInstanceXmlForInTouch(applicationName, guidKey);
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string InitializePopupForm(
                                            string lastModifiedLocaleTime,
                                            string userId,
                                            string appName,
                                            string formName,
                                            string version,
                                            string listName)
    {
        return NextGenPopupFormHelper.InitializePopupForm(
                                            lastModifiedLocaleTime,
                                            userId,
                                            appName,
                                            formName,
                                            version,
                                            listName);

    }

    /// <summary>
    /// Gets Form parameters from the form
    /// </summary>
    /// <param name="applicationName">Application Name</param>
    /// <param name="form">Form Name</param>
    /// <param name="version">Form Version</param>
    /// <returns></returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetPopupFormParametersForDesignTime(string applicationName, string form, string version)
    {
        return JsonConvert.SerializeObject(NextGenPopupFormHelper.GetPopupFormParametersForDesignTime(applicationName, form, version));
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string PrintForm(string applicationName, string userId, string formName, string versionStamp, bool isStaging)
    {
        Dictionary<string, string> vals = new Dictionary<string, string>();
        string viewAndViewModel = string.Empty;

        try
        {
            NextGenRenderer nextGenRenderer = new NextGenRenderer();
            BaseForm printForm = null;

            string listName = "Forms List",
                itemKey = Skelta.Forms2.Web.CommonFunctions.GetFormCacheKey(applicationName, formName, listName);

            ListDataHandler listDataHandler = new ListDataHandler(applicationName, listName);
            Skelta.Repository.List.ListItem listItem = null;

            if (versionStamp == "0")
            {
                listItem = listDataHandler.GetListItem(formName);
                versionStamp = listItem.CurrentVersion.VersionStamp.ToString();
            }
            else
            {
                listItem = listDataHandler.GetListItem(formName, versionStamp);
            }

            string status = listItem.Status.ToString();
            vals.Add("Status", status);

            if (isStaging)
            {
                printForm = nextGenRenderer.GetBaseFormTempDefinition(applicationName, userId, formName, versionStamp, listName);
            }
            else
            {
                //// If the call is not from Preview and the Printable Form is in Draft state
                if (status == "Draft")
                {
                    vals.Add("IsSuccess", "false");
                    vals.Add("vAndVM", viewAndViewModel);

                    return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(vals);
                }

                string baseFormDef = Skelta.Forms2.Web.CommonFunctions.GetFormDefinitionForFormName(applicationName, formName, versionStamp);
                if (!string.IsNullOrEmpty(baseFormDef))
                {
                    printForm = BaseForm.LoadDefinitionXml(baseFormDef);
                }
            }

            if (printForm != null)
            {
                if (printForm.TopLevelForm.RenderDetails.Get("formUniqueKey") == null)
                {
                    printForm.TopLevelForm.RenderDetails.Add("formUniqueKey", Skelta.Forms.Core.Common.GetFormUniqueKey(applicationName, itemKey, versionStamp));
                }

                printForm.InPrintMode = true;
                printForm.InDesignMode = false;
                printForm.DeviceType = Skelta.Forms.Core.DeviceType.Web;

                printForm.TemplateScripts.Clear();
                var view = nextGenRenderer.GetView(printForm);
                var viewModel = nextGenRenderer.GetViewModel(printForm);

                viewAndViewModel = view + viewModel;
                viewAndViewModel = Skelta.Forms2.Web.CommonFunctions.ProcessLocalization(viewAndViewModel, Skelta.Forms2.Web.CommonFunctions.GetCurrentECCulture);

                vals.Add("itemKey", itemKey);
                vals.Add("formVersion", versionStamp);
                vals.Add("IsSuccess", "true");
            }
            else
            {
                vals.Add("IsSuccess", "false");
            }
        }
        catch (Exception ex)
        {
            Workflow.NET.Log log = new Workflow.NET.Log();
            log.LogError(ex, "Error at Print Form: " + ex.Message);
            vals.Add("IsSuccess", "false");
        }

        vals.Add("vAndVM", viewAndViewModel);

        return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(vals);
    }

    /// <summary>
    /// Gets lookup data in json format
    /// </summary>
    /// <param name="app">Repository name</param>
    /// <param name="userId">Logged in user id</param>
    /// <param name="source">lookup name</param>
    /// <param name="parameters">lookup parameters</param>
    /// <returns>json string</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetDataFromLookup(string app, string userId, string source, IEnumerable<LookupParameter> parameters)
    {
        return LookupDataHelper.GetSerializedLookupResult(app, userId, source, parameters);
    }

    /// <summary>
    /// Gets lookup data in json format
    /// </summary>
    /// <param name="app">Repository name</param>
    /// <param name="userId">Logged in user id</param>
    /// <param name="source">lookup name</param>
    /// <param name="parameters">lookup parameters</param>
    /// <returns>json string</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string GetLookupSchemaAndData(string app, string userId, string source, IEnumerable<LookupParameter> parameters, bool allColumnsRequired, bool isDataRequired = true)
    {
        return LookupDataHelper.GetLookupSchemaAndData(app, userId, source, parameters, allColumnsRequired, isDataRequired);
    }

    /// <summary>
    /// Gets lookup data in json format
    /// </summary>
    /// <param name="app">Repository name</param>
    /// <param name="userId">Logged in user id</param>
    /// <param name="source">lookup name</param>
    /// <param name="parameters">lookup parameters</param>
    /// <returns>json string</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string GetWebAPILookupSchemaAndData(string app, string userId, string source, IEnumerable<LookupParameter> parameters, bool allColumnsRequired, bool isDataRequired = true)
    {
        return LookupDataHelper.GetWebAPILookupSchemaAndData(app, userId, source, parameters, allColumnsRequired, isDataRequired);
    }

    /// <summary>
    /// Get the list structure
    /// <param name="cacheKey"> id of the cache</param>
    /// <param name="listName">name of the list</param>
    /// <param name="versionStamp">version of the form</param>
    /// <param name="formName">form name</param>
    /// <param name="applicationName">Application Name</param>
    /// <param name="userId">logged in user id</param>
    /// <returns>the view and view model for the list structure page</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Xml)]
    public static string GetListStructure(string cacheKey, string listName, string versionStamp, string formName, string applicationName, string userId)
    {
        Skelta.Forms2.Web.NextGenForms.ListStructure listStructure = new Skelta.Forms2.Web.NextGenForms.ListStructure();
        return listStructure.GetListStructure(formName, applicationName);
    }

    /// <summary>
    /// Gets the Control Selection Configuration screen definition
    /// </summary>
    /// <param name="userId">userId</param>
    /// <param name="applicationName">applicationName</param>
    /// <param name="cacheKey">cacheKey</param>
    /// <param name="versionStamp">versionStamp</param>
    /// <returns>Returns the view and view model of the workflow configuration form</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string GetControlConfigForm(string userId, string applicationName, string cacheKey, string versionStamp)
    {
        NextGenRenderer nextGenRenderer = new NextGenRenderer();
        NextGenAttachmentHelper attachmentHelper = new NextGenAttachmentHelper();
        var baseForm = attachmentHelper.GetTextControlConfigurationSchema(ResourceSet, applicationName, userId, cacheKey, versionStamp);

        if (baseForm != null)
        {
            if (baseForm.TopLevelForm.RenderDetails.Get("formUniqueKey") == null)
            {
                baseForm.TopLevelForm.RenderDetails.Add("formUniqueKey", Skelta.Forms.Core.Common.GetFormUniqueKey(applicationName, cacheKey + "_AC", versionStamp));
            }

            return nextGenRenderer.GetSPA(baseForm);
        }

        return string.Empty;
    }

    /// <summary>
    /// Gets all Roles for the User
    /// </summary>
    /// <param name="userId">LoggedIn UserId</param>
    /// <param name="app">Application Name</param>
    /// <param name="uIdForRole">UserId for whome Roles are to be fetched. If this is empty, get the roles for the loggedInUser</param>
    /// <param name="isWorkTasksPro">Is Ajax call from Work Tasks Pro</param>
    /// <returns>User Roles</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetUserRoles(string userId, string app, string uIdForRole, string isWorkTasksPro)
    {
        Dictionary<string, object> responseObj = new Dictionary<string, object>();
        Log log = new Log();
        SkeltaResourceSet resourceSet = new SkeltaResourceSetManager().GlobalResourceSetForNextGenForms;

        try
        {
            if (isWorkTasksPro == "False")
            {
                //// Verify Logged In User ID
                string loggedInUserVerificationMessage = Skelta.Forms2.Web.CommonFunctions.VerifyLoggedInUserId(userId);

                //// If Work Tasks pro then do not make the verification check because context is not present
                if (!string.IsNullOrEmpty(loggedInUserVerificationMessage))
                {
                    responseObj.Add("IsSuccess", false);
                    responseObj.Add("ErrorMessage", loggedInUserVerificationMessage);

                    log.LogError(new Exception(resourceSet.GetString("FormNGFErrorWhileGettingUserRoles").Replace("<userid>", (string.IsNullOrEmpty(uIdForRole) ? userId : uIdForRole))), resourceSet.GetString(loggedInUserVerificationMessage));

                    return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(responseObj);
                }
            }

            ApplicationObject applicationObj = new ApplicationObject(app);

            //// If uIdForRole is empty, get the role for the current loggedInUser
            if (string.IsNullOrEmpty(uIdForRole))
            {
                uIdForRole = userId;
            }

            responseObj.Add("Roles", Skelta.Repository.Security.CommonFunctions.GetRoles(applicationObj, uIdForRole));
            responseObj.Add("IsSuccess", true);

            return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(responseObj);
        }
        catch (Exception ex)
        {
            string errorMessage = resourceSet.GetString("FormNGFErrorWhileGettingUserRoles").Replace("<userid>", (string.IsNullOrEmpty(uIdForRole) ? userId : uIdForRole));

            responseObj.Add("IsSuccess", false);
            responseObj.Add("ErrorMessage", errorMessage);

            log.LogError(ex, errorMessage);

            return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(responseObj);
        }
    }

    /// <summary>
    /// Gets all Roles for the User in AAD
    /// </summary>
    /// <param name="userId">LoggedIn UserId</param>
    /// <param name="app">Application Name</param>
    /// <param name="uIdForRole">UserId for whome Roles are to be fetched. If this is empty, get the roles for the loggedInUser</param>
    /// <param name="isWorkTasksPro">Is Ajax call from Work Tasks Pro</param>
    /// <returns>User Roles</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetUserMemberOf(string userId, string app, string uIdForRole, string isWorkTasksPro)
    {
        Dictionary<string, object> responseObj = new Dictionary<string, object>();
        Log log = new Log();
        SkeltaResourceSet resourceSet = new SkeltaResourceSetManager().GlobalResourceSetForNextGenForms;

        try
        {
            if (isWorkTasksPro == "False")
            {
                //// Verify Logged In User ID
                string loggedInUserVerificationMessage = Skelta.Forms2.Web.CommonFunctions.VerifyLoggedInUserId(userId);

                //// If Work Tasks pro then do not make the verification check because context is not present
                if (!string.IsNullOrEmpty(loggedInUserVerificationMessage))
                {
                    responseObj.Add("IsSuccess", false);
                    responseObj.Add("ErrorMessage", loggedInUserVerificationMessage);

                    log.LogError(new Exception(resourceSet.GetString("FormNGFErrorWhileGettingUserRoles").Replace("<userid>", (string.IsNullOrEmpty(uIdForRole) ? userId : uIdForRole))), resourceSet.GetString(loggedInUserVerificationMessage));

                    return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(responseObj);
                }
            }

            ApplicationObject applicationObj = new ApplicationObject(app);

            //// If uIdForRole is empty, get the role for the current loggedInUser
            if (string.IsNullOrEmpty(uIdForRole))
            {
                uIdForRole = userId;
            }

            responseObj.Add("Roles", new Aveva.WorkflowManagement.AADProvider.AADUserProvider().GetMemberOf(uIdForRole));
            responseObj.Add("IsSuccess", true);

            return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(responseObj);
        }
        catch (Exception ex)
        {
            string errorMessage = resourceSet.GetString("FormNGFErrorWhileGettingUserRoles").Replace("<userid>", (string.IsNullOrEmpty(uIdForRole) ? userId : uIdForRole));

            responseObj.Add("IsSuccess", false);
            responseObj.Add("ErrorMessage", errorMessage);

            log.LogError(ex, errorMessage);

            return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(responseObj);
        }
    }

    /// <summary>
    /// Gets the Values For Right Codes
    /// </summary>
    /// <param name="userId">LoggedIn UserId</param>
    /// <param name="app">Application Name</param>
    /// <param name="rightsCollection">Rights Collection Eg. ["CanEditWorkOrder", "CanOverwritePublishedWorkflow"]</param>
    /// <param name="uIdForRole">UserId for whome Roles are to be fetched. If this is empty, get the roles for the loggedInUser</param>
    /// <param name="isWorkTasksPro">Is Ajax call from Work Tasks Pro</param>
    /// <returns></returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string GetValueForRightCode(string userId, string app, object rightsCollection, string uIdForRights, string isWorkTasksPro)
    {
        Dictionary<string, object> responseObj = new Dictionary<string, object>();
        Log log = new Log();
        SkeltaResourceSet resourceSet = new SkeltaResourceSetManager().GlobalResourceSetForNextGenForms;

        try
        {
            if (isWorkTasksPro == "False")
            {
                //// Verify Logged In User ID
                string loggedInUserVerificationMessage = Skelta.Forms2.Web.CommonFunctions.VerifyLoggedInUserId(userId);

                //// If Work Tasks pro then do not make the verification check because context is not present
                if (!string.IsNullOrEmpty(loggedInUserVerificationMessage))
                {
                    responseObj.Add("IsSuccess", false);
                    responseObj.Add("ErrorMessage", loggedInUserVerificationMessage);

                    log.LogError(new Exception(resourceSet.GetString("FormNGFErrorWhileGettingValueForRightCode").Replace("<userid>", (string.IsNullOrEmpty(uIdForRights) ? userId : uIdForRights))), resourceSet.GetString(loggedInUserVerificationMessage));

                    return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(responseObj);
                }
            }

            //// If uIdForRole is empty, get the role for the current loggedInUser
            if (string.IsNullOrEmpty(uIdForRights))
            {
                uIdForRights = userId;
            }

            SecurityManager SecurityManagerObject = new SecurityManager(uIdForRights, app);
            Dictionary<string, string> valuesForRightCodes = new Dictionary<string, string>();

            var rightsColl = rightsCollection as object[];
            if (rightsColl.Length > 0)
            {
                foreach (var right in rightsColl)
                {
                    string rightName = (right != null) ? right.ToString() : string.Empty;

                    if (!string.IsNullOrEmpty(rightName) && !valuesForRightCodes.ContainsKey(rightName))
                    {
                        string rightCodeValue = SecurityManagerObject.GetValueForRightCode(rightName, Skelta.Repository.EntityType.Repository, Guid.Empty);
                        valuesForRightCodes.Add(rightName, rightCodeValue.ToString());
                    }
                }
            }

            responseObj.Add("IsSuccess", true);
            responseObj.Add("RightCodes", valuesForRightCodes);

            return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(responseObj);
        }
        catch (Exception ex)
        {
            string errorMessage = resourceSet.GetString("FormNGFErrorWhileGettingValueForRightCode").Replace("<userid>", (string.IsNullOrEmpty(uIdForRights) ? userId : uIdForRights));

            responseObj.Add("IsSuccess", false);
            responseObj.Add("ErrorMessage", errorMessage);

            log.LogError(ex, errorMessage);

            return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(responseObj);
        }
    }

    /// <summary>
    /// Gets the Effective Security Group for the User
    /// </summary>
    /// <param name="userId">LoggedIn UserId</param>
    /// <param name="app">Application Name</param>
    /// <param name="uIdForSecurityGroup">UserId for whome Security Group is to be fetched. If this is empty, get the roles for the loggedInUser</param>
	/// <param name="isWorkTasksPro">Is Work Tasks pro</param>
    /// <returns></returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetUserSecurityGroup(string userId, string app, string uIdForSecurityGroup, string isWorkTasksPro)
    {
        Dictionary<string, object> responseObj = new Dictionary<string, object>();
        Log log = new Log();
        SkeltaResourceSet resourceSet = new SkeltaResourceSetManager().GlobalResourceSetForNextGenForms;

        try
        {
            if (isWorkTasksPro == "False")
            {
                //// Verify Logged In User ID
                string loggedInUserVerificationMessage = Skelta.Forms2.Web.CommonFunctions.VerifyLoggedInUserId(userId);

                //// If Work Tasks pro then do not make the verification check because context is not present
                if (!string.IsNullOrEmpty(loggedInUserVerificationMessage))
                {
                    responseObj.Add("IsSuccess", false);
                    responseObj.Add("ErrorMessage", loggedInUserVerificationMessage);

                    log.LogError(new Exception(resourceSet.GetString("FormNGFErrorWhileGettingSecurityGroup").Replace("<userid>", (string.IsNullOrEmpty(uIdForSecurityGroup) ? userId : uIdForSecurityGroup))), resourceSet.GetString(loggedInUserVerificationMessage));

                    return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(responseObj);
                }
            }

            //// If uIdForRole is empty, get the role for the current loggedInUser
            if (string.IsNullOrEmpty(uIdForSecurityGroup))
            {
                uIdForSecurityGroup = userId;
            }

            string effectiveSecurityGroup = Skelta.Forms2.Web.CommonFunctions.GetUserSecurityGroup(uIdForSecurityGroup, app);

            responseObj.Add("IsSuccess", true);
            responseObj.Add("SecurityGroup", effectiveSecurityGroup);

            return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(responseObj);
        }
        catch (Exception ex)
        {
            string errorMessage = resourceSet.GetString("FormNGFErrorWhileGettingSecurityGroup").Replace("<userid>", (string.IsNullOrEmpty(uIdForSecurityGroup) ? userId : uIdForSecurityGroup));

            responseObj.Add("IsSuccess", false);
            responseObj.Add("ErrorMessage", errorMessage);

            log.LogError(ex, errorMessage);

            return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(responseObj);
        }
    }

    /// <summary>
    /// Gets form type encrypted password
    /// </summary>
    /// <param name="inputText">password</param>
    /// <returns>encrypted password text</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetFormTypeEncryptPassword(string inputText)
    {
        return Skelta.Forms.Web.CommonFunctions.GetFormTypeEncryptedPassword(inputText);
    }

    /// <summary>
    /// Gets skelta list type encrypted password
    /// </summary>
    /// <param name="inputText">password</param>
    /// <returns>encrypted password text</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetSkeltaListTypeEncryptPassword(string inputText)
    {
        return Workflow.NET.CommonFunctions.GetEncryptLDAPPassword(inputText);
    }

    /// <summary>
    /// Check the Forms Design time license
    /// </summary>
    /// <returns>Forms design time license validation</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetFormsDesignTimeLicenseCheck()
    {
        return Skelta.Forms2.Web.CommonFunctions.CheckDesignTimeLicense();
    }

    /// <summary>
    /// Get Secured Uri for forms
    /// </summary>
    /// <param name="app">Respository name</param>
    /// <param name="uId">Logged in user id</param>
    /// <param name="form">Form title</param>
    /// <param name="version">Form version</param>
    /// <returns>lcsuri</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static object GetFormsUri(string app, string uId, string form, string version)
    {
        return Skelta.Forms2.Web.CommonFunctions.GetSecuredQueryStringForForms(app, uId, form, version);
    }

    /// <summary>
    /// This method will generate the view and view model for Action Item Edit Window
    /// </summary>
    /// <param name="appName">repository name</param>
    /// <param name="uId">user id</param>
    /// <param name="ck">Cache key</param>
    /// <param name="vs">version stamp</param>
    /// <param name="cId">id of the control required for script control</param>
    /// <param name="cName">name of the control required for script control</param>
    /// <returns>the view and view model</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Xml)]
    public static string GetActionItemForm(string appName, string uId, string ck, string vs, string cId, string cName)
    {
        var nextGenRenderer = new NextGenRenderer();
        var resourceManager = new SkeltaResourceSetManager().GlobalResourceSetForNextGenForms;
        try
        {
            var vvm = nextGenRenderer.GetSPA(ActionBarHelper.ActionItemPropertyForm(appName, ck, vs, resourceManager, cId, cName));
            return Skelta.Forms2.Web.CommonFunctions.ProcessLocalization(vvm, Skelta.Forms2.Web.CommonFunctions.GetCurrentECCulture);
        }
        catch (System.Exception e)
        {
            var logger = new Log();
            logger.LogError(e, resourceManager.GetString("skAction_ErrorLoadingActionItem"), appName);
            logger.Close();
            return string.Empty;
        }
    }

    /// <summary>
    /// Checks if control is used in ActionBar
    /// </summary>
    /// <param name="app">Rspository name</param>
    /// <param name="cacheKey">cache key</param>
    /// <param name="cId">control id</param>
    /// <param name="version">form version</param>
    /// <returns>true or false</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static bool CheckIfControlExist(string app, string cacheKey, string cId, string version)
    {
        return Skelta.Forms2.Web.CommonFunctions.CheckIfControlExist(app, cacheKey, cId, version);
    }

    /// <summary>
    /// Initializes Preview Form
    /// </summary>
    /// <param name="secUri">secured uri</param>
    /// <param name="rightCodes">array of right codes</param>
    /// <param name="deviceType">device type</param>
    /// <param name="lastModifiedLocaleTime">locales last modified datetime stamp</param>
    /// <returns>initial form data(appname, formNae, formVersion, itemId, etc.), page defaults, staging view and viewModel</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string InitializePreviewForm(string secUri, string[] rightCodes, string deviceType, string lastModifiedLocaleTime)
    {
        return NextGenRenderer.InitializePreviewForm(secUri, rightCodes, deviceType, lastModifiedLocaleTime);
    }

    /// <summary>
    /// Initializes Fill Form
    /// </summary>
    /// <param name="secUri">secured uri</param>
    /// <param name="rightCodes">array of right codes</param>
    /// <param name="deviceType">device type</param>
    /// <param name="lastModifiedLocaleTime">locales last modified datetime stamp</param>
    /// <param name="guidKey">Id of SKEPopupTemp table where instance xml is stored</param>
    /// <param name="formLink">Form Link</param>
    /// <param name="dashboardLink">Dashboard Link</param>
    /// <returns>initial form data(appname, formNae, formVersion, itemId, etc.), page defaults, view and viewModel</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string InitializeInstanceForm(string secUri, string[] rightCodes, string deviceType, string lastModifiedLocaleTime, string guidKey, string formLink, string[] dashboardLink)
    {
        return NextGenRenderer.InitializeInstanceForm(secUri, rightCodes, deviceType, lastModifiedLocaleTime, guidKey, formLink, dashboardLink);
    }

    /// <summary>
    /// Initializes Workitem Invoke Form
    /// </summary>
    /// <param name="secUri">secured uri</param>
    /// <param name="wisuri">Workitem secured uri</param>
    /// <param name="deviceType">device type</param>
    /// <param name="lastModifiedLocaleTime">locales last modified datetime stamp</param>
    /// <param name="type">request type</param>
    /// <returns>initial form data(appname, formNae, formVersion, itemId, etc.), page defaults, view and viewModel</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string InitializeWorkItemInvokeForm(string secUri, string wisuri, string deviceType, string lastModifiedLocaleTime, string type)
    {
        return NextGenRenderer.InitializeWorkItemInvokeForm(secUri, wisuri, deviceType, lastModifiedLocaleTime, type);
    }

    /// <summary>
    /// Initializes View Form
    /// </summary>
    /// <param name="secUri">secured uri</param>
    /// <param name="deviceType">device type</param>
    /// <param name="lastModifiedLocaleTime">locales last modified datetime stamp</param>
    /// <returns>initial form data(appname, formNae, formVersion, itemId, etc.), page defaults, view and viewModel</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string InitializeViewForm(string secUri, string deviceType, string lastModifiedLocaleTime)
    {
        return NextGenRenderer.InitializeViewForm(secUri, deviceType, lastModifiedLocaleTime);
    }

    /// <summary>
    /// Initializes Dynamic List Form
    /// </summary>
    /// <param name="secUri">lcsuri parameter</param>
    /// <param name="rightCodes">right codes that has to be checked</param>
    /// <param name="forList">forms list</param>
    /// <param name="mode">edit new or view mode</param>
    /// <param name="lastModifiedLocaleTime">locales last modified datetime stamp</param>
    /// <returns>initial form data(appname, formNae, formVersion, itemId, etc.), page defaults, view and viewModel</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string InitializeDynamicListForm(string secUri, string[] rightCodes, bool forList, string mode, string lastModifiedLocaleTime)
    {
        NextGenRenderer nextGenRenderer = new NextGenRenderer();
        return nextGenRenderer.InitializeDynamicListForm(secUri, rightCodes, forList, mode, lastModifiedLocaleTime);
    }

    /// <summary>
    /// Gets Form parameters from the form
    /// </summary>
    /// <param name="formId">form id</param>
    /// <param name="applicationName">repository name</param>
    /// <param name="pageMode">page mode</param>
    /// <param name="tabId">tab id</param>
    /// <returns></returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetFormParametersForDashboardLink(string formId, string applicationName, string pageMode, string tabId, string navigationDetailsId)
    {
        if (pageMode == "ActionEdit")
        {
            var formParameters = FormLinkHelper.GetFormParametersForTab(tabId, formId, navigationDetailsId, applicationName);
            return formParameters.Count != 0 ? JsonConvert.SerializeObject(new { FP = formParameters }) : FormLinkHelper.GetSerializedFormParametersByFormId(formId, applicationName);
        }
        else
        {
            return FormLinkHelper.GetSerializedFormParametersByFormId(formId, applicationName);
        }
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetMqttConnectionDetail(string applicationName, string connectionName)
    {
        var mqttTopicConfigurationDataModel = new MqttConnectionTopicsProvider(applicationName);
        return mqttTopicConfigurationDataModel.GetMqttConnectionTopicDetail(connectionName);
    }

    /// <summary>
    /// Get Decryted Password
    /// </summary>
    /// <param name="encryptedString">encrypted password</param>
    /// <param name="encryptionMode">encryption mode</param>
    /// <returns>returns decrypted password</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Xml)]
    public static string GetDecrytedString(string encryptedString, string encryptionMode)
    {
        return NextGenRenderer.GetDecryptedString(encryptedString, encryptionMode);
    }

    /// <summary>
    /// Get Control List For Mqtt Topic
    /// </summary>
    /// <param name="appName">application name</param>
    /// <param name="userId">user Id</param>
    /// <param name="versionStamp">version stamp</param>
    /// <param name="formItemId">form ItemId</param>
    /// <returns>returns json string</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetControlListForMqttTopic(string appName, string userId, string versionStamp, string formItemId)
    {
        try
        {
            MqttTopicConfigDataWrapper mqttTopicConfig = new MqttTopicConfigDataWrapper();
            Dictionary<string, string> controlList = mqttTopicConfig.GetValuePropertyControls(appName, userId, formItemId, versionStamp) as Dictionary<string, string>;
            return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(controlList);
        }
        catch (Exception ex)
        {
            //
            var logger = new Log();
            var resourceManager = new SkeltaResourceSetManager().GlobalResourceSetForNextGenForms;
            logger.LogError(ex, resourceManager.GetString("FormNGFGetControlListForMqttTopicError"), appName);

            return string.Empty;
        }
    }

    /// <summary>
    /// Gets client credential token
    /// </summary>
    /// <param name="appName">repository name</param>
    /// <returns>client credential access token</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetClientCredentialToken(string appName)
    {
        return Skelta.Forms2.Web.CommonFunctions.GetCustomScopeClientCredentialsAccessToken(appName);
    }

    /// <summary>
    /// Gets user access token
    /// </summary>
    /// <param name="appName">repository name</param>
    /// <returns>user access token</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetUserAccessToken(string appName)
    {
        return Workflow.NET.TokenService.TokenServiceCommonFunctions.GetUserAccessTokenFromClaims(appName);
    }
}
