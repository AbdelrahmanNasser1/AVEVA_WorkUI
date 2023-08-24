using System;
using System.Data;
using System.Text;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections;
using Skelta.FarmManager;
using Workflow.NET;
using Workflow.NET.Web.Designer;
using System.Collections.Generic;
using Skelta.Core;
using Skelta.HWS;
using System.Xml;
using Skelta.Repository.Security;

namespace Skelta.Repository.CodeBehind.Codebehind.Site
{

    //------------------------------------------------------------------------------
    // Copyright (C) 2010 Invensys Systems Inc.  All rights reserved.
    // 
    // THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY
    // KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
    // IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
    // PARTICULAR PURPOSE.
    //------------------------------------------------------------------------------

    public partial class ConfigureExceptions : System.Web.UI.Page
    {

        protected String actionname = "";
        protected String propertyname = "";
        protected String valueString = "";
        protected String filename = "";
        public static string AdminUrl = "";
        public static string UserUrl = "";
        public static string _ApplicationName = "";
        public string _WorkflowName = "";
        public string _FileName = "";
        public string _TemplateName = "";
        public string _DesignerInstanceId = "";
        public string _Culture = "";
        public string _UserIdString = "";
        public int _ActionNameMaxLength = 0;
        protected ProcessDesignerAdapter pda;
        protected ProcessDesignerAdapter designerAdapter;
        protected ProcessDesigner _designerControl;
        protected ProcessDesigner ProcessDesignerControl;
        protected Property selProperty = null;
        string strSelectTemplateFile = "";
        string strValidationMessage = "";
        string strClearMessage = "";
        protected string cssPath = "";
        protected string helpUrl = "";
        protected string helpText = "";
        protected string bellyBarPath;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                idPopupValueAdmin.Value = "";
                idPopupValueUsers.Value = "";
            }
            if (Skelta.Repository.Security.CommonFunctions.IsControlValuesValid(Page.Controls) == false)
            {
                throw new XssSecurityException();
            }
            cssPath = Convert.ToString(Workflow.NET.TemplateExpressionBuilder.GetUrl(""));
            bellyBarPath = Workflow.NET.CommonFunctions.GetJSReferencePath();
            actionname = this.Context.Request["actionname"];
            propertyname = this.Context.Request["selpropertyname"];
            filename = this.Context.Request["wfmemoFilename"];

            _ApplicationName = this.Context.Request["ApplicationName"];
            _WorkflowName = this.Context.Request["WorkflowName"];
            _FileName = this.Context.Request["FileName"];
            _TemplateName = this.Context.Request["TemplateName"];
            _DesignerInstanceId = this.Context.Request["SkDii"];
            _Culture = this.Context.Request["cul"];
            System.Threading.Thread.CurrentThread.CurrentUICulture = new System.Globalization.CultureInfo(_Culture);
            // VerifySecuredValue(context.Request["pdsuri"]);
            _UserIdString = this.Context.Request["_skuserid"];
            _ActionNameMaxLength = Convert.ToInt32(this.Context.Request["_actionnamemaxlength"]);


            string s = "ApplicationName=" + HttpUtility.UrlEncode(_ApplicationName) + "&WorkflowName=" + HttpUtility.UrlEncode(_WorkflowName) + "&FileName=" + HttpUtility.UrlEncode(filename) + "&TemplateName=" + HttpUtility.UrlEncode(_TemplateName) + "&Cul=" + HttpUtility.UrlEncode(System.Threading.Thread.CurrentThread.CurrentUICulture.Name) + "&pdsuri=" + HttpUtility.UrlEncode(GetSecuredValue()) + "&SkDii=" + HttpUtility.UrlEncode(_DesignerInstanceId);
            s += Workflow.NET.CommonFunctions.GetReponseUrlParameters();

            AdminUrl = "ExceptionWorkflowMemo.aspx" + "?ActionName=" + Workflow.NET.CommonFunctions.HandleSplCharactersForLocalization(System.Web.HttpUtility.UrlEncode(actionname)) + "&selPropertyName=" + Workflow.NET.CommonFunctions.HandleSplCharactersForLocalization(System.Web.HttpUtility.UrlEncode(propertyname)) + "&wfmemoFilename=" + Workflow.NET.CommonFunctions.HandleSplCharactersForLocalization(System.Web.HttpUtility.UrlEncode(filename)) + "&" + s;

            string p = "ApplicationName=" + HttpUtility.UrlEncode(_ApplicationName) + "&WorkflowName=" + HttpUtility.UrlEncode(_WorkflowName) + "&FileName=" + HttpUtility.UrlEncode(filename) + "&TemplateName=" + HttpUtility.UrlEncode(_TemplateName) + "&Cul=" + HttpUtility.UrlEncode(System.Threading.Thread.CurrentThread.CurrentUICulture.Name) + "&pdsuri=" + HttpUtility.UrlEncode(GetSecuredValue()) + "&SkDii=" + HttpUtility.UrlEncode(_DesignerInstanceId) + "&Template=" + "User";
            p += Workflow.NET.CommonFunctions.GetReponseUrlParameters();

            UserUrl = "ExceptionWorkflowMemo.aspx" + "?ActionName=" + Workflow.NET.CommonFunctions.HandleSplCharactersForLocalization(System.Web.HttpUtility.UrlEncode(actionname)) + "&selPropertyName=" + Workflow.NET.CommonFunctions.HandleSplCharactersForLocalization(System.Web.HttpUtility.UrlEncode(propertyname)) + "&wfmemoFilename=" + Workflow.NET.CommonFunctions.HandleSplCharactersForLocalization(System.Web.HttpUtility.UrlEncode(filename)) + "&" + p;


            pda = new ProcessDesignerAdapter();
            pda.LoadControlInstance(false);
            ProcessDesignerControl = pda.ProcessDesignerControl;
            ProcessDesignerControl.FileName = filename;
            ProcessDesignerControl.InitializeValues();
            ProcessDesignerControl.ProcessDefinition.PreProcessDiagaram();


            strSelectTemplateFile = ProcessDesignerControl.GlobalResourceSet.GetString("ConfigExceptionTemplateFile");
            strValidationMessage = ProcessDesignerControl.GlobalResourceSet.GetString("ConfigExceptionValidationMessage");
            strClearMessage = ProcessDesignerControl.GlobalResourceSet.GetString("ConfigExceptionClearMsg");

            helpUrl = ProcessDesignerControl.GetHelpPageUrl();
            helpText = ProcessDesignerControl.GlobalResourceSet.GetString("Help");

            if (!IsPostBack)
            {
                //Building template files
                BuildTemplateFilenames();
            }
            Workflow.NET.Action selAction = ProcessDesignerControl.ProcessDefinition.Actions[actionname];
            selProperty = selAction.Properties[propertyname];

            Workflow.NET.PropertyTypes.PropertyExceptionTemplates pr = (Workflow.NET.PropertyTypes.PropertyExceptionTemplates)selProperty.PropertyHandler;
            string strUserTemplateValue = pr.ValueHTML;

            ViewState["Admin"] = "";
            ViewState["User"] = "";
            if (!Page.IsPostBack)
            {

                if (strUserTemplateValue != "")
                {
                    int nAdmin = strUserTemplateValue.IndexOf("<AdminTemplates>");
                    strUserTemplateValue = strUserTemplateValue.Insert(nAdmin + 16, "<![CDATA[");
                    int nAdminS = strUserTemplateValue.IndexOf("</AdminTemplates>");
                    strUserTemplateValue = strUserTemplateValue.Insert(nAdminS, "]]>");
                    int nPUser = strUserTemplateValue.IndexOf("<ProcessTemplates>");
                    strUserTemplateValue = strUserTemplateValue.Insert(nPUser + 18, "<![CDATA[");
                    int nPUserS = strUserTemplateValue.IndexOf("</ProcessTemplates>");
                    strUserTemplateValue = strUserTemplateValue.Insert(nPUserS, "]]>");


                    XmlDocument doc = new XmlDocument();
                    doc.LoadXml(strUserTemplateValue);

                    string strAdminUsers = Convert.ToString(doc.SelectNodes("//AdminUsers").Item(0).InnerText);
                    string strAdminTemplates = Convert.ToString(doc.SelectNodes("//AdminTemplates").Item(0).InnerText);
                    string strProcessUsers = Convert.ToString(doc.SelectNodes("//ProcessUsers").Item(0).InnerText);
                    string strProcessTemplates = Convert.ToString(doc.SelectNodes("//ProcessTemplates").Item(0).InnerText);
                    string strAdminUserOrRoleSelected = "";
                    if (doc.SelectNodes("//UserorRole").Item(0) != null)
                        strAdminUserOrRoleSelected = Convert.ToString(doc.SelectNodes("//UserorRole").Item(0).InnerText);

                    if (strAdminUserOrRoleSelected == "User")
                    {
                        radAdminUser.Checked = true;
                        radAdminRole.Checked = false;
                        txtAdminUserName.Text = GetDisplayTextForUsers(_ApplicationName, strAdminUsers);
                        hdnUserName.Value = strAdminUsers;
                    }
                    else
                    {
                        radAdminRole.Checked = true;
                        radAdminUser.Checked = false;
                        txtRoleName.Text = strAdminUsers;
                        hdnRoles.Value = strAdminUsers;
                    }

                    string strProcessUserOrRoleSelected = "";
                    if (doc.SelectNodes("//ProcessUserOrRole").Item(0) != null)
                        strProcessUserOrRoleSelected = Convert.ToString(doc.SelectNodes("//ProcessUserOrRole").Item(0).InnerText);


                    if (strProcessUserOrRoleSelected == "User")
                    {
                        radProcessUser.Checked = true;
                        radProcessRole.Checked = false;
                        txtProcessUserName.Text = GetDisplayTextForUsers(_ApplicationName, strProcessUsers);
                        hdnProcessUser.Value = strProcessUsers;
                    }
                    else
                    {
                        radProcessRole.Checked = true;
                        radProcessUser.Checked = false;
                        txtProcessUserRoleName.Text = strProcessUsers;
                        hdnProcessUserRoles.Value = strProcessUsers;
                    }


                    // if (!Page.IsPostBack)
                    // {
                    ViewState["Admin"] = strAdminUsers;
                    ViewState["User"] = strProcessUsers;


                    if (strAdminTemplates.Contains("DefaultTemplatefromHTML"))
                    {
                        string[] strArray = strAdminTemplates.Split(',');
                        //txtAdminTemplateFile.Text = strArray[1];
                        if (strArray[1].ToLowerInvariant() != "select")
                        {
                            SelectTemplateFile(strArray[1], "admin");
                            rdAdminTempDefault.Checked = true;
                        }
                        else
                        {
                            rdAdminTemplate.Checked = false;
                            rdAdminTempDefault.Checked = false;

                        }
                    }
                    else
                    {
                        rdAdminTemplate.Checked = true;
                    }
                    if (strProcessTemplates.Contains("DefaultTemplatefromHTML"))
                    {
                        string[] strArray = strProcessTemplates.Split(',');
                        if (strArray[1].ToLowerInvariant() != "select")
                        {
                            SelectTemplateFile(strArray[1], "user");
                            rdProcessTempDefault.Checked = true;
                        }
                        else
                        {
                            rdProcessTemplate.Checked = false;
                            rdProcessTempDefault.Checked = false;
                        }
                    }
                    else
                    {
                        rdProcessTemplate.Checked = true;
                    }
                }
            }


            btnOk.Value = ProcessDesignerControl.GlobalResourceSet.GetString("Ok");
            btnCancel.Value = ProcessDesignerControl.GlobalResourceSet.GetString("Cancel");
            btnClear.Value = ProcessDesignerControl.GlobalResourceSet.GetString("ConfigExceptionClear");

            btnClear.ServerClick += new EventHandler(btnClear_ServerClick);


        }

        private string GetDisplayTextForUsers(string repositoryName, string userIDValue)
        {
            string[] userIdStringArray = userIDValue.Split(new string[] { Skelta.Core.UserLookUpSearch.SeparatorForMultipleUsers }, StringSplitOptions.None);


            StringBuilder displayText = new StringBuilder();

            foreach (string userId in userIdStringArray)
            {
                string displayTextForUser = getResourceNameByIdWithProvider(repositoryName, userId);

                if (displayText.Length > 0)
                {
                    displayText.Append(", ");
                }

                if (string.IsNullOrEmpty(displayTextForUser) == false)
                {
                    displayText.Append(displayTextForUser);
                }
                else
                {
                    displayText.Append(userId);
                }
            }

            return displayText.ToString();
        }

        private string getResourceNameByIdWithProvider(string repositoryName, string useridwithprovider)
        {
            string displayTextForUser = string.Empty;

            try
            {
                if (string.IsNullOrEmpty(useridwithprovider) == false)
                {
                    Skelta.Entity.Entity entity = Skelta.Entity.Entity.GetEntity(new Skelta.Core.ApplicationObject(repositoryName), "UserEntity");
                    string realId = useridwithprovider.Split(new string[] { Skelta.Entity.Entity.ProviderSeperatorCharacter }, StringSplitOptions.None)[1];
                    string ProviderName = useridwithprovider.Split(new string[] { Skelta.Entity.Entity.ProviderSeperatorCharacter }, StringSplitOptions.None)[0];
                    Skelta.Entity.EntityItem entityItem = entity.DataBridge.DataBridgeProviders[ProviderName].GetEntityItem(entity.DataBridge.DataBridgeProviders[ProviderName].ConvertToIdentifierType(realId));
                    if (entityItem != null)
                    {
                        displayTextForUser = Convert.ToString(entityItem.Properties.Name.Value) + " [" + entity.DataBridge.DataBridgeProviders[ProviderName].DisplayName + "]";
                    }
                }
            }
            catch (Exception ex)
            {
                // Nothing
            }

            return displayTextForUser;
        }

        void btnClear_ServerClick(object sender, EventArgs e)
        {
            Workflow.NET.PropertyTypes.PropertyExceptionTemplates pr = (Workflow.NET.PropertyTypes.PropertyExceptionTemplates)selProperty.PropertyHandler;

            pr.Value = "";
            pr.ValueHTML = "";
            ProcessDesignerControl.WriteFile();
            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "<script>se.ui.messageDialog.showAlert(\"" + ProcessDesignerControl.GlobalResourceSet.GetString("GlobalSettings_Exception") + "\",\"" + strClearMessage + "\",function(){window.setTimeout('window.opener.refreshselectedaction()',100);window.opener.parent._skProcessDesigner.RefreshProperties();window.setTimeout('window.close()',100); });</script>");
        }

        /// <summary>
        /// This is used to get the filenames from the Exceptiontemplate folder under the workflowelements folder	 
        /// </summary>
        /// <returns></returns>
        private ArrayList GetFileNames()
        {
            ArrayList ALFiles = new ArrayList();

            System.IO.DirectoryInfo dir = new System.IO.DirectoryInfo(ProcessDesignerControl.DirSourceElements + "Templates\\ExceptionTemplate");
            System.IO.FileInfo[] fi = dir.GetFiles();
            foreach (System.IO.FileInfo file in fi)
            {
                if (file.Extension == ".htm" || file.Extension == ".html")
                {
                    ALFiles.Add(file.Name);
                }
            }

            return ALFiles;
        }


        /// <summary>
        /// This is to build the Template filenames in the drop down        
        /// </summary>
        private void BuildTemplateFilenames()
        {

            ArrayList alfilenames = new ArrayList();
            alfilenames = GetFileNames();
            ddlAdminTemplateFiles.Items.Add(new ListItem(ProcessDesignerControl.GlobalResourceSet.GetString("Select Option"), "Select"));
            ddlUserTemplateFiles.Items.Add(new ListItem(ProcessDesignerControl.GlobalResourceSet.GetString("Select Option"), "Select"));

            for (int i = 0; i < alfilenames.Count; i++)
            {
                string filename = Convert.ToString(alfilenames[i]);

                ddlAdminTemplateFiles.Items.Add(new ListItem(filename, filename));
                ddlUserTemplateFiles.Items.Add(new ListItem(filename, filename));
            }


        }

        /// <summary>
        /// Selecting the Template file in the dropdown after saving
        /// </summary>
        /// <param name="selVal">Selected Template File Name</param>
        /// <param name="type">Type of the Category</param>
        private void SelectTemplateFile(string selVal, string type)
        {
            if (!string.IsNullOrEmpty(selVal) && !string.IsNullOrEmpty(type))
            {
                if (type == "admin")
                {
                    ListItem oSelectedItem = ddlAdminTemplateFiles.Items.FindByValue(selVal);
                    if (oSelectedItem != null)
                    {
                        oSelectedItem.Selected = true;
                    }
                }
                else
                {
                    ListItem oSelectedItem = ddlUserTemplateFiles.Items.FindByValue(selVal);
                    if (oSelectedItem != null)
                    {
                        oSelectedItem.Selected = true;
                    }

                }
            }

        }


        string GetSecuredValue()
        {
            Dictionary<string, string> dictSuri = new Dictionary<string, string>();
            dictSuri["s"] = _ApplicationName + _WorkflowName;
            return Workflow.NET.SecureUriParameters.GetEncryptedValue(dictSuri, true);
        }


        /// <summary>
        /// Code for Saving the Property value on click of OK Button 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>        
        protected void btnOk_Click(object sender, EventArgs e)
        {
            string strExceptionSettings = "<ExceptionSettings><AdminUsers>";
            try
            {

                if (rdAdminTempDefault.Checked && ddlAdminTemplateFiles.SelectedValue == "Select")
                {
                    imgAdmin.Visible = true;
                    imgAdmin.Alt = strSelectTemplateFile;//"Please Select the html template file name";
                    return;
                }
                else if (rdAdminTempDefault.Checked && ddlAdminTemplateFiles.SelectedValue != "Select")
                {
                    imgAdmin.Visible = false;
                }

                if (rdProcessTempDefault.Checked && ddlUserTemplateFiles.SelectedValue == "Select")
                {
                    imgUser.Visible = true;
                    imgUser.Alt = strSelectTemplateFile;//"Please Select the html template file name";
                    return;

                }
                else if (rdProcessTempDefault.Checked && ddlUserTemplateFiles.SelectedValue != "Select")
                {
                    imgUser.Visible = false;
                }

                #region Admin Users Section
                string UserForDisplay = "";


                //For Identifying User and Role Selection 
                string isAdminUserOrRoleSelected = (radAdminUser.Checked) ? "User" : "Role";
                string strAdminUsersforRole = "";

                if (isAdminUserOrRoleSelected == "User")
                {
                    if (!string.IsNullOrEmpty(hdnUserName.Value))
                    {
                        UserForDisplay = hdnUserName.Value;
                    }
                    else
                    {
                        UserForDisplay = txtAdminUserName.Text;
                    }
                }
                else if (isAdminUserOrRoleSelected == "Role")
                {

                    ArrayList lstUsers = new ArrayList();
                    if (!string.IsNullOrEmpty(hdnRoles.Value))
                    {
                        lstUsers = GetUsersInRoles(hdnRoles.Value, _ApplicationName);
                        UserForDisplay = hdnRoles.Value;
                    }
                    else
                    {
                        lstUsers = GetUsersInRoles(txtRoleName.Text, _ApplicationName);
                        UserForDisplay = txtRoleName.Text;
                    }

                    strAdminUsersforRole = Skelta.Core.UserLookUpSearch.GetUserSeparatorJoinedStringFromArray(lstUsers);

                }
                else
                {

                }



                if (rdAdminTemplate.Checked == true)
                {
                    //strExceptionSettings = strExceptionSettings + ViewState["Admin"].ToString() + UserForDisplay + "</AdminUsers><AdminTemplates>" + idPopupValueAdmin.Value + "</AdminTemplates>";
                    strExceptionSettings = strExceptionSettings + UserForDisplay + "</AdminUsers><AdminTemplates>" + idPopupValueAdmin.Value + "</AdminTemplates><UserorRole>" + isAdminUserOrRoleSelected + "</UserorRole><AdminUsersForRole>" + strAdminUsersforRole + "</AdminUsersForRole>";
                }
                else
                {
                    //strExceptionSettings = strExceptionSettings + ViewState["Admin"].ToString() + UserForDisplay + "</AdminUsers><AdminTemplates>" + "Default," + txtAdminTemplateFile.Text + "</AdminTemplates>";
                    strExceptionSettings = strExceptionSettings + UserForDisplay + "</AdminUsers><AdminTemplates>" + "DefaultTemplatefromHTML," + ddlAdminTemplateFiles.SelectedValue + "</AdminTemplates><UserorRole>" + isAdminUserOrRoleSelected + "</UserorRole><AdminUsersForRole>" + strAdminUsersforRole + "</AdminUsersForRole>";
                }

                #endregion

                #region Process Users Section
                strExceptionSettings += "<ProcessUsers>";
                string processUserForDisplay = "";


                string isProcessUserOrRoleSelected = (radProcessUser.Checked) ? "User" : "Role";
                string strProcessUsersforRole = "";
                if (isProcessUserOrRoleSelected == "User")
                {
                    if (!string.IsNullOrEmpty(hdnProcessUser.Value))
                    {
                        processUserForDisplay = hdnProcessUser.Value;
                    }
                    else
                    {
                        processUserForDisplay = txtProcessUserName.Text;
                    }
                }
                else if (isProcessUserOrRoleSelected == "Role")
                {

                    ArrayList lstProcessUsers = new ArrayList();
                    if (!string.IsNullOrEmpty(hdnProcessUserRoles.Value))
                    {
                        lstProcessUsers = GetUsersInRoles(hdnProcessUserRoles.Value, _ApplicationName);

                        processUserForDisplay = hdnProcessUserRoles.Value;
                    }
                    else
                    {
                        lstProcessUsers = GetUsersInRoles(txtProcessUserRoleName.Text, _ApplicationName);
                        processUserForDisplay = txtProcessUserRoleName.Text;
                    }

                    strProcessUsersforRole = Skelta.Core.UserLookUpSearch.GetUserSeparatorJoinedStringFromArray(lstProcessUsers);

                }
                else
                {

                }



                if (rdProcessTemplate.Checked == true)
                {
                    //strExceptionSettings += ViewState["User"].ToString() + UserForDisplay + "</ProcessUsers><ProcessTemplates>" + idPopupValueUsers.Value + "</ProcessTemplates></ExceptionSettings>";
                    strExceptionSettings += processUserForDisplay + "</ProcessUsers><ProcessTemplates>" + idPopupValueUsers.Value + "</ProcessTemplates><ProcessUserOrRole>" + isProcessUserOrRoleSelected + "</ProcessUserOrRole><ProcessUsersForRole>" + strProcessUsersforRole + "</ProcessUsersForRole></ExceptionSettings>";
                }
                else
                {
                    //strExceptionSettings += ViewState["User"].ToString() + UserForDisplay + "</ProcessUsers><ProcessTemplates>" + "DefaultTemplatefromHTML," + ddlUserTemplateFiles.SelectedValue + "</ProcessTemplates></ExceptionSettings>";
                    strExceptionSettings += processUserForDisplay + "</ProcessUsers><ProcessTemplates>" + "DefaultTemplatefromHTML," + ddlUserTemplateFiles.SelectedValue + "</ProcessTemplates><ProcessUserOrRole>" + isProcessUserOrRoleSelected + "</ProcessUserOrRole><ProcessUsersForRole>" + strProcessUsersforRole + "</ProcessUsersForRole></ExceptionSettings>";
                }
                #endregion

                if (string.IsNullOrEmpty(UserForDisplay) && string.IsNullOrEmpty(processUserForDisplay))
                {
                    Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "validmessage", "<script>se.ui.messageDialog.showError(\"" + ProcessDesignerControl.GlobalResourceSet.GetString("GlobalSettings_Exception") + "\",\"" + strValidationMessage + "\");</script>");
                    return;
                }
                else if (rdAdminTempDefault.Checked && string.IsNullOrEmpty(UserForDisplay))
                {
                    Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "validmessage", "<script>se.ui.messageDialog.showError(\"" + ProcessDesignerControl.GlobalResourceSet.GetString("GlobalSettings_Exception") + "\",\"" + strValidationMessage + "\");</script>");
                    return;
                }
                else if (rdProcessTempDefault.Checked && string.IsNullOrEmpty(processUserForDisplay))
                {
                    Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "validmessage", "<script>se.ui.messageDialog.showError(\"" + ProcessDesignerControl.GlobalResourceSet.GetString("GlobalSettings_Exception") + "\",\"" + strValidationMessage + "\");</script>");
                    return;
                }

            }
            catch (Exception ex)
            {
                throw;
            }




            Workflow.NET.PropertyTypes.PropertyExceptionTemplates pr = (Workflow.NET.PropertyTypes.PropertyExceptionTemplates)selProperty.PropertyHandler;

            pr.Value = strExceptionSettings;
            pr.ValueHTML = strExceptionSettings;

            // ((Workflow.NET.Interfaces.IPropertyExpression)(selProperty.PropertyHandler)).IsExpression = false;
            ProcessDesignerControl.WriteFile();
            Response.Write("<script language='javascript'> window.setTimeout('window.opener.refreshselectedaction()',100);window.opener.parent._skProcessDesigner.RefreshProperties();window.setTimeout('window.close()',100); </script>");

        }

        private string getResourceNameByIdWithProvider(string useridwithprovider)
        {
            //Workflow.NET.Resource resource = _ResourceHandler.Resources.GetResource(useridwithprovider);
            Skelta.Entity.Entity entity = Skelta.Entity.Entity.GetEntity(new ApplicationObject(_ApplicationName), "UserEntity");
            string realId = useridwithprovider.Split(new string[] { Skelta.Entity.Entity.ProviderSeperatorCharacter }, StringSplitOptions.None)[1];
            string ProviderName = useridwithprovider.Split(new string[] { Skelta.Entity.Entity.ProviderSeperatorCharacter }, StringSplitOptions.None)[0];
            Skelta.Entity.EntityItem entityItem = entity.DataBridge.DataBridgeProviders[ProviderName].GetEntityItem(entity.DataBridge.DataBridgeProviders[ProviderName].ConvertToIdentifierType(realId));
            if (entityItem == null)
            {
                return string.Empty;
            }
            else
                return Convert.ToString(entityItem.Properties.Name.Value);
            return string.Empty;
        }



        protected void btnCancel_Click(object sender, EventArgs e)
        {
        }

        private string GetUserEmail(string ProviderId, string strRepo)
        {
            string email = "";
            try
            {
                ApplicationObject appObject = new ApplicationObject(strRepo);
                Actor actor = new Actor(appObject, ProviderId);
                email = actor.Resource.Properties.Email.Value.ToString();

            }
            catch (Exception ex)
            {
                throw;
            }
            return email;

        }


        private ArrayList GetUsersInRoles(string roleName, string applicationName)
        {
            Dictionary<object, string> usersInRoles = new Dictionary<object, string>();
            ArrayList usersList = new ArrayList();
            string[] roles = Skelta.Core.RoleLookupSearch.GetRolesFromSeparatorJoinedString(roleName);
            for (int i = 0; i < roles.Length; i++)
            {
                if (!string.IsNullOrEmpty(roles[i]))
                {
                    AddInProviderCollection _AddInProviderCollection = new AddInProviderCollection(new ApplicationObject(applicationName));
                    ISkeltaRoleProvider _ISkeltaRoleProvider = (ISkeltaRoleProvider)_AddInProviderCollection.GetProvidersForType(true, "Role")["RoleProvider"];
                    _ISkeltaRoleProvider.ApplicationName = applicationName;
                    usersInRoles = _ISkeltaRoleProvider.GetUsersInRole(roles[i]);
                    usersList.AddRange(usersInRoles.Keys);
                }
            }
            return usersList;
        }
    }
}
