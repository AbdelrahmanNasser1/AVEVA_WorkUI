using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using AntiXssEncoder = Microsoft.Security.Application.Encoder;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using Skelta.Forms.Core.Controls;
using Skelta.Forms.Core.Controls.DesignTime;
using Skelta.Forms.Core;
using Skelta.Forms.Core.Interfaces;
using Telerik.Web.UI;
using Skelta.Forms.Web.Designer;
using Workflow.NET;
using Workflow.NET.Interfaces;
using Workflow.NET.PropertyTypes;
using Skelta.InvokeForm;
using Workflow.NET.Web.Designer;
using Workflow.NET.Web.Designer.PropertyPages;
using Workflow.NET.Web.Designer.Interfaces;
using Workflow.NET.Storage;
using Skelta.FarmManager;
using Skelta.Repository;
using Microsoft.Security.Application;

public partial class FormInfo : System.Web.UI.Page
{
        
    Skelta.Repository.Web.Lookup.ListLookup FormListLookUp = new Skelta.Repository.Web.Lookup.ListLookup();
    Skelta.Repository.Web.Lookup.VersionLookup FormVersionLookUp;
    
    protected ProcessDesigner ProcessDesignerControl;
    
    protected string _actionname = "";
    protected string _propertyname = "";
    protected string PropertyDisplayName = "";
    protected Workflow.NET.Property selProperty = null;
    protected string ApplicationName = "";
    protected string WorkflowName = "";
    protected string _JScriptPath = "";
    protected string _Helpimagetags = "";
    protected string _fileName = "";
    protected string ErrMsg = "";
    protected string strFormName = "";
    protected string strFormVersion = "";
    protected string strFormInvalid = "";
    protected string strSubmit = "";
    protected string strClose = "";
    private string FormDetails = "";
    protected string SelectedFormName = "";
    protected string SelectedVersion = "";
    protected string strAssociatedFormName = "";
    protected string strHelpTooltip = "";
    protected string strFormDescription = string.Empty;
    protected string strAssocFormDescription = string.Empty;
    protected string strFormNamDescription = string.Empty;
    protected string strVersDescription = string.Empty;
    protected string cssPath = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        Object TEBObject = Workflow.NET.TemplateExpressionBuilder.GetUrl("");
        cssPath = TEBObject.ToString();
        ProcessDesignerAdapter pda = new ProcessDesignerAdapter();
        pda.LoadControlInstance(false);
        ProcessDesignerControl = pda.ProcessDesignerControl;
        ProcessDesignerControl.InitializeValues();
        ApplicationName = ProcessDesignerControl.ApplicationName;
        WorkflowName = ProcessDesignerControl.WorkflowName;
                

        if (!Page.IsPostBack)
        {
            _actionname = AntiXssEncoder.HtmlEncode(this.Context.Request["selectedAction"]);
            _propertyname = AntiXssEncoder.HtmlEncode(this.Context.Request["propertyname"]);
            _fileName = AntiXssEncoder.HtmlEncode(this.Context.Request["FormName"]);

            ProcessDesignerControl.InitializeValues();
            ProcessDesignerControl.ProcessDefinition.PreProcessDiagaram();
            Workflow.NET.Action selAction = ProcessDesignerControl.ProcessDefinition.Actions[_actionname];
            selProperty = selAction.Properties[_propertyname];
            _JScriptPath = ProcessDesignerControl.GetJscriptUrl("javascript\\PropertyPages.js");
            string winParams = "height=550,width=560,scrollbars=yes,resizable=yes";
            string propertyhelp = " onclick=\"javascript:OpenHelpWin('" + ProcessDesignerControl.GetHelpPageUrl() + "InvokeForm-FormName.html" + "','" + winParams + "')\"";
            _Helpimagetags = propertyhelp;           
            
        }
        else
        {
            _actionname = AntiXssEncoder.HtmlEncode(Request["hidactionname"]);
            _propertyname = AntiXssEncoder.HtmlEncode(Request["hidpropertyname"]);
            ApplicationName = AntiXssEncoder.HtmlEncode(Request["hid_applicationName"]);
            WorkflowName = AntiXssEncoder.HtmlEncode(Request["hid_workflowName"]);
            _fileName = AntiXssEncoder.HtmlEncode(Request["hid_fileName"]);
            pda = new ProcessDesignerAdapter();
            pda.LoadControlInstance(false);

            ProcessDesignerControl = pda.ProcessDesignerControl;
            ProcessDesignerControl.ApplicationName = ApplicationName;
            ProcessDesignerControl.WorkflowName = WorkflowName;
            ProcessDesignerControl.FileName = _fileName;

            ProcessDesignerControl.InitializeValues();
            ProcessDesignerControl.ProcessDefinition.PreProcessDiagaram();
            Workflow.NET.Action selAction = ProcessDesignerControl.ProcessDefinition.Actions[_actionname];
            selProperty = selAction.Properties[_propertyname];

        }
        PropertyDisplayName = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString(_propertyname);
        strFormName = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Invoke_FormName");
        strAssociatedFormName = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Invoke_AssociatedForm");
        strFormVersion = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Invoke_FormVersion");
        strFormInvalid = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Invoke_FormError");
        strSubmit = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Invoke_Submit");
        strClose = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Invoke_Close");
        strHelpTooltip = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Help");
        strFormDescription = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Invoke_FormDetailDescr");
        strAssocFormDescription = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Invoke_FormAssocDescr");
        strFormNamDescription = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Invoke_FormNamDescr");
        strVersDescription = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Invoke_FormVerDescr");
        btnUpdate.Text = strSubmit;
        try
        {
            FormDetails = ((Skelta.InvokeForm.PropertyHandleRequest)(ProcessDesignerControl.ProcessDefinition.Actions[_actionname].Properties[_propertyname].PropertyHandler)).Value.ToString();
            if (!string.IsNullOrEmpty(FormDetails))
            {
                SelectedFormName = FormDetails.Split('?')[0].ToString();
                SelectedVersion = FormDetails.Split('?')[1].ToString();
                if (SelectedVersion == "0")
                    SelectedVersion = "";
                else
                    SelectedVersion = "(" + SelectedVersion + ")";
            }
        }
        catch { }
        PopulateFormName();
        PopulateFormVersion(true);
    }
    /// <summary>
    /// To populate Form names
    /// </summary>
    private void PopulateFormName()
    {
        WorkflowPanel.Controls.Clear();

        FormListLookUp.ID = "listlookup";
        FormListLookUp.ListName = "Forms List";
        FormListLookUp.Enabled = true;
        FormListLookUp.ApplicationName = ApplicationName;
        FormListLookUp.StatusToDisplay = Skelta.Repository.DisplayStatus.Published;
        FormListLookUp.AutoPostBack = true;
        //FormListLookUp.ItemsPerRequest = 3;
        FormListLookUp.DropDownHeight = 150;          
        FormListLookUp.LookUpSelectionChanged += new Skelta.Repository.Web.Lookup.ListLookup.LookUpSelectionChangedHandler(FormListLookUp_LookUpSelectionChanged);
        WorkflowPanel.Controls.Add(FormListLookUp);
    }
    /// <summary>
    /// Pouplate the  versions of the Form selected
    /// </summary>
    /// <param name="setListItemId"></param>
    private void PopulateFormVersion(bool setListItemId)
    {
        VersionPanel.Controls.Clear();
        FormVersionLookUp = new Skelta.Repository.Web.Lookup.VersionLookup();
        FormVersionLookUp.ID = this.ClientID + "versionlookup";
        FormVersionLookUp.ApplicationName = ApplicationName;
        FormVersionLookUp.ListName = "Forms List";
        //FormVersionLookUp.ItemsPerRequest = 3;
        FormVersionLookUp.DropDownHeight = 100;
        FormVersionLookUp.IsLatestVisible = true;
        try
        {
            if (IsPostBack && setListItemId)
                FormVersionLookUp.ListItemId = FormListLookUp.Value;

        }
        catch { }
        VersionPanel.Controls.Add(FormVersionLookUp);
    }
    void FormListLookUp_LookUpSelectionChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        PopulateFormVersion(true);
    }

    protected void Submit_Click(object sender, System.EventArgs e)
    {
        //Workflow.NET.PropertyTypes.PropertyHandleRequest pr = (Workflow.NET.PropertyTypes.PropertyHandleRequest)selProperty.PropertyHandler;
        try
        {
            //SkeltaResourceSetManager skResMgr = new SkeltaResourceSetManager();
            string guid = FormListLookUp.Value.ToString();
            if (guid == "00000000-0000-0000-0000-000000000000")
            {
                throw new Exception(strFormInvalid);
            }
            Skelta.InvokeForm.PropertyHandleRequest pr = (Skelta.InvokeForm.PropertyHandleRequest)selProperty.PropertyHandler;
            string str = FormListLookUp.Text.ToString() + '?' + FormVersionLookUp.Value + '?' + FormListLookUp.Value.ToString() + '?' + _actionname;
            //string str = "Test"+'?'+"1"+'?'+"54ADB8EF-E08B-4BDD-AB65-02DBE6C0C690";
            pr.Value = str;
            ProcessDesignerControl.WriteFile();
            Response.Write("<script language='javascript'>window.opener.top._skProcessDesigner.RefreshProperties();window.setTimeout('window.close()',100); </script>");
        }
        catch (Exception ex)
        {
            if (ex.Message.IndexOf("Thread was being aborted", StringComparison.OrdinalIgnoreCase) < 0)
            {
                ErrMsg = ex.Message;
               // Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "Error", "<script language='javascript'>alert('" + errormsg + "');</script>");
                ClientScript.RegisterClientScriptBlock(this.GetType(), "ShowBellyBarMessage", "<script>DisplayMessage();</script>");
            }
        }
    }
       
 }