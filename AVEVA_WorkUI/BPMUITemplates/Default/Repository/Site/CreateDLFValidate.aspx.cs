using System;
using System.Data;
using System.Web.Helpers;
using RepositorySecurityCommonFunctions = Skelta.Repository.Security.CommonFunctions;
using AntiXssEncoder = Microsoft.Security.Application.Encoder;

public partial class BPMUITemplates_Default_Repository_Site_CreateDLFValidate : System.Web.UI.Page
{
    Workflow.NET.SkeltaResourceSetManager resManager = new Workflow.NET.SkeltaResourceSetManager();
    string _applicationName;
    string _listName;
    protected string ValidationType = "";
    protected string themePath = "";
    
    protected void Page_Load(object sender, EventArgs e)
    {
        RepositorySecurityCommonFunctions.ValidateRequestFullQueryString(Request.QueryString);

        if (IsPostBack)
        {
            if (RepositorySecurityCommonFunctions.IsControlValuesValid(Page.Controls) == false)
            {
                throw new Skelta.Repository.Security.XssSecurityException();
            }
        }

        string templateRootDir =  "../../";//Workflow.NET.Config.GetTemplateDirectoryFromWebConfig();
        WGrdMthdPrv.RuntimeLicenseKey = Workflow.NET.CommonFunctions.GetWebgridRuntimeLicenseKey;
        WGrdMthdPrv.ScriptDirectory = templateRootDir + Workflow.NET.CommonFunctions.WebGridScriptDirectory;
        WGrdMthdPrv.SharedScriptDirectory = templateRootDir + Workflow.NET.CommonFunctions.WebGridSharedScriptDirectory;
        WGrdMthdPrv.LayoutSettings.ImageSettings.Folder = templateRootDir + Workflow.NET.CommonFunctions.WebGridLayoutImageSettingsFolder;
        WGrdMthdPrv.LayoutSettings.TextSettings.LocalizationFolder = templateRootDir + Workflow.NET.CommonFunctions.WebGridLayoutTextSettingsLocalizationFolder;
        WGrdMthdPrv.WebDesktopScriptDirectory = templateRootDir + Workflow.NET.CommonFunctions.WebGridWebDesktopScriptDirectory;
        themePath = Workflow.NET.TemplateExpressionBuilder.GetUrl("").ToString();      
        _applicationName = Request["ApplicationName"];
        _listName = Request["ListName"];
        if (string.IsNullOrEmpty(_applicationName) || string.IsNullOrEmpty(_listName))
            return;
        ValidationType = AntiXssEncoder.HtmlEncode(Request["ValidationType"]);
        if(ValidationType=="OnListSave")
            ValidateFormOnListEditSave();
        else if (ValidationType=="OnFormSave")
            ValidateFormOnFormSave();
    }

    private void ValidateFormOnListEditSave()
    {
        DataTable dt = new DataTable("Test");
        dt.Columns.Add(new DataColumn("Error", typeof(string)));
        dt.Columns.Add(new DataColumn("Description", typeof(string)));
        DataRow dr;
        Skelta.Forms.Web.Common.ValidateListForm validateLstFrm = new Skelta.Forms.Web.Common.ValidateListForm(_applicationName, _listName);
        validateLstFrm.Validate();
        if (validateLstFrm.ValidationErrors.Count > 0)
        {
            lblError.Text ="This list may not work properly as corresponding form generated for the list is not valid. Following are the Errors identified. Edit form from 'Manage Forms' list and correct it. Alternatively you can regenerate the form from 'Manage List'.";
            for (int i = 0; i < validateLstFrm.ValidationErrors.Count; i++)
            {
                Skelta.Forms.Web.Common.ListFormErrorDetails lstFrmErrDtl = validateLstFrm.ValidationErrors[i];
                string Error = "";
                string ErrorDesc = "";
                switch (lstFrmErrDtl.ErrorType)
                {
                    case 0:
                        Error = "Form Not Valid.";
                        break;
                    case 1:
                        Error = resManager.GlobalResourceSet.GetString("FormXmlNodeBoundToProperty") + " not matching. <br>";
                        Error += "(Control: " + lstFrmErrDtl.ParentFormName + "." + lstFrmErrDtl.ControlName + " )";
                        break;
                    case 2:
                        Error = "Not null fields not set mandatory. <br>";
                        Error += "(Control: " + lstFrmErrDtl.ParentFormName + "." + lstFrmErrDtl.ControlName + " )";
                        break;
                    case 3:
                        Error = "Not null field control not found. <br>";
                        Error += "(Table: " + lstFrmErrDtl.ParentFormName + ", Field:" + lstFrmErrDtl.ControlName + " )";
                        break;
                    case 4:
                        Error = "";
                        break;
                }

                ErrorDesc = lstFrmErrDtl.ErrorMessage + "<br>";
                //ErrorDesc += resManager.GlobalResourceSet.GetString("FormXmlNodeBoundToProperty") + ":" + lstFrmErrDtl.MappedXMLNode;
                dr = dt.NewRow();
                dr[0] = Error;
                dr[1] = ErrorDesc;
                dt.Rows.Add(dr);
            }
        }
        else
        {
            dr = dt.NewRow();
            dr[0] = "";
            dr[1] = "List Form is valid";
            dt.Rows.Add(dr);
            ClientScript.RegisterStartupScript(Type.GetType("System.String"), "closethis2", "<script>this.closeWindow();</script>");
        }

        WGrdMthdPrv.DataSource = dt;
        WGrdMthdPrv.RetrieveStructure();
        WGrdMthdPrv.RootTable.Columns[0].AllowMultiLine = true;
        WGrdMthdPrv.RootTable.Columns[1].AllowMultiLine = true;
        //WGrdMthdPrv.RootTable.RowHeaders = ISNet.WebUI.WebGrid.RowHeaders.No;
        WGrdMthdPrv.RootTable.Columns[0].Width = 200;
        WGrdMthdPrv.RootTable.Columns[1].Width = 470;//Unit.Parse((WGrdMthdPrv.Width.Value - 160).ToString());
    }

    private void ValidateFormOnFormSave()
    {
        DataTable dt = new DataTable("Test");
        dt.Columns.Add(new DataColumn("Error", typeof(string)));
        dt.Columns.Add(new DataColumn("Description", typeof(string)));
        DataRow dr;
        Skelta.Forms.Web.Common.ValidateListForm validateLstFrm = new Skelta.Forms.Web.Common.ValidateListForm(_applicationName, _listName);
        validateLstFrm.Validate(true);
        if (validateLstFrm.ValidationErrors.Count > 0)
        {
            lblError.Text = "List Form validation failed. Following are the Errors identified.";
            for (int i = 0; i < validateLstFrm.ValidationErrors.Count; i++)
            {
                Skelta.Forms.Web.Common.ListFormErrorDetails lstFrmErrDtl = validateLstFrm.ValidationErrors[i];
                string Error = "";
                string ErrorDesc = "";
                switch (lstFrmErrDtl.ErrorType)
                {
                    case 0:
                        Error = "Form Not Valid.";
                        break;
                    case 1:
                        Error = resManager.GlobalResourceSet.GetString("FormXmlNodeBoundToProperty") + " not matching. <br>";
                        Error += "(Control: " + lstFrmErrDtl.ParentFormName + "." + lstFrmErrDtl.ControlName + " )";
                        break;
                    case 2:
                        Error = "Not null fields not set mandatory. <br>";
                        Error += "(Control: " + lstFrmErrDtl.ParentFormName + "." + lstFrmErrDtl.ControlName + " )";
                        break;
                    case 3:
                        Error = "Not null field control not found. <br>";
                        Error += "(Form: " + lstFrmErrDtl.ParentFormName + ", Control:" + lstFrmErrDtl.ControlName + " )";
                        break;
                    case 4:
                        Error = "Invalid size set for control. <br>";
                        Error += "(Form: " + lstFrmErrDtl.ParentFormName + ", Control:" + lstFrmErrDtl.ControlName + " )";
                        break;
                    case 5:
                        Error = "Field not found in the table. <br>";
                        Error += "(Form: " + lstFrmErrDtl.ParentFormName + ", Control:" + lstFrmErrDtl.ControlName + " )";
                        break;

                }

                ErrorDesc = lstFrmErrDtl.ErrorMessage + "<br>";
                //ErrorDesc += resManager.GlobalResourceSet.GetString("FormXmlNodeBoundToProperty") + ":" + lstFrmErrDtl.MappedXMLNode;
                dr = dt.NewRow();
                dr[0] = Error;
                dr[1] = ErrorDesc;
                dt.Rows.Add(dr);
            }
        }
        else
        {
            dr = dt.NewRow();
            dr[0] = "";
            dr[1] = "List Form is valid";
            dt.Rows.Add(dr);
            ClientScript.RegisterStartupScript(Type.GetType("System.String"), "closethis2", "<script>this.closeWindow();</script>");
        }

        WGrdMthdPrv.DataSource = dt;
        WGrdMthdPrv.RetrieveStructure();
        WGrdMthdPrv.RootTable.Columns[0].AllowMultiLine = true;
        WGrdMthdPrv.RootTable.Columns[1].AllowMultiLine = true;
        //WGrdMthdPrv.RootTable.RowHeaders = ISNet.WebUI.WebGrid.RowHeaders.No;
        WGrdMthdPrv.RootTable.Columns[0].Width = 200;
        WGrdMthdPrv.RootTable.Columns[1].Width = 400;//470;//Unit.Parse((WGrdMthdPrv.Width.Value - 160).ToString());
    }

    protected void WGrdMthdPrv_InitializeDataSource(object sender, ISNet.WebUI.WebGrid.DataSourceEventArgs e)
    {
    }
}
