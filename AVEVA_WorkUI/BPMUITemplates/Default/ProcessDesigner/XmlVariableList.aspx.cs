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
using System.Web.UI.WebControls;
using AntiXssEncoder = Microsoft.Security.Application.Encoder;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml;
using System.Xml.Schema;
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
using Workflow.NET.Web.Designer;
using Workflow.NET.Web.Designer.PropertyPages;
using Workflow.NET.Web.Designer.Interfaces;
using Workflow.NET.Storage;
using Skelta.FarmManager;
using Skelta.Repository;
 

public partial class XmlVariableList : System.Web.UI.Page
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
    protected TextBox txt;
    protected bool IsListXml = false;
    protected string strFormName = "";
    protected string strFormVersion = "";
    protected string strListMsg = "";
    protected string strList = "";
    protected string strXml = "";
    protected string strListName = "";
    protected string strXmlName = "";
    protected string strXmlDesc = "";
    protected string strSubmit = "";
    protected string strClose = "";
    protected string strFormInvalid = "";
    protected string strXmlInvalid = "";
    protected string strListInvalid = "";
    protected string strXmlExists = "";
    protected string cssPath = string.Empty;
    protected void Page_Init(object sender, EventArgs e)
    {
        ProcessDesignerAdapter pda = new ProcessDesignerAdapter();
        pda.LoadControlInstance(false);
        ProcessDesignerControl = pda.ProcessDesignerControl;
        ProcessDesignerControl.InitializeValues();
        listExplorer1.ApplicationName = ProcessDesignerControl.ApplicationName;
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        Object TEBObject = Workflow.NET.TemplateExpressionBuilder.GetUrl("");
        cssPath = TEBObject.ToString();        
        btnUpdate.Attributes.Add("onclick", "javascript:return ValidateXmlName();");
        ProcessDesignerAdapter pda = new ProcessDesignerAdapter();
        pda.LoadControlInstance(false);
        ProcessDesignerControl = pda.ProcessDesignerControl;
        ProcessDesignerControl.InitializeValues();
        ApplicationName = ProcessDesignerControl.ApplicationName;
        WorkflowName = ProcessDesignerControl.WorkflowName;
        
        if (radList.SelectedValue == "yes")
        {
            IsListXml = true;
        }

        if (!IsListXml)
        {
            PopulateFormName();
            PopulateFormVersion(true);
        }

        if (!Page.IsPostBack)
        {
            _actionname = AntiXssEncoder.HtmlEncode(this.Context.Request["selActionName"]);
            _propertyname = AntiXssEncoder.HtmlEncode(this.Context.Request["selPropertyName"]);
            //_fileName = this.Context.Request["FormName"];
            ApplicationName = ProcessDesignerControl.ApplicationName;
            WorkflowName = ProcessDesignerControl.WorkflowName;
           // _fileName = ProcessDesignerControl.FileName;
            ProcessDesignerControl.InitializeValues();
            ProcessDesignerControl.ProcessDefinition.PreProcessDiagaram();
            Workflow.NET.Action selAction = ProcessDesignerControl.ProcessDefinition.Actions[_actionname];
            selProperty = selAction.Properties[_propertyname];
            _JScriptPath = ProcessDesignerControl.GetJscriptUrl("javascript\\PropertyPages.js");
            string winParams = "height=550,width=560,scrollbars=yes,resizable=yes";
            string propertyhelp = " title=\"" + selProperty.HelpString + "\" onclick=\"javascript:OpenHelpWin('" + ProcessDesignerControl.GetHelpPageUrl() + "InvokeForm-OutputInstanceXMLVariable.html" + "','" + winParams + "')\"";
            _Helpimagetags = propertyhelp;

            

        }
        else
        {
            _actionname = AntiXssEncoder.HtmlEncode(Request["hidactionname"]);
            _propertyname = AntiXssEncoder.HtmlEncode(Request["hidpropertyname"]);
            ApplicationName = AntiXssEncoder.HtmlEncode(Request["hid_applicationName"]);
            WorkflowName = AntiXssEncoder.HtmlEncode(Request["hid_workflowName"]);
           // _fileName = Request["hid_fileName"];
            
            ProcessDesignerControl.ApplicationName = ApplicationName;
            ProcessDesignerControl.WorkflowName = WorkflowName;
            ProcessDesignerControl.FileName = _fileName;

            //ProcessDesignerControl.InitializeValues();
            //ProcessDesignerControl.ProcessDefinition.PreProcessDiagaram();
            Workflow.NET.Action selAction = ProcessDesignerControl.ProcessDefinition.Actions[_actionname];
            selProperty = selAction.Properties[_propertyname];
         
        }
        
        PropertyDisplayName = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Output XmlVariable");
        strFormName = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Invoke_FormName");
        strFormVersion = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Invoke_FormVersion");
        strListMsg = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Invoke_ListXmlMsg");
        strList = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Invoke_List");
        strXml = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Invoke_Xml");
        strListName = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Invoke_ListName");
        strXmlName = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Invoke_XmlName");
        strXmlDesc = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Invoke_XmlDesc");
        strSubmit = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Invoke_Submit");
        strClose = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Invoke_Close");

        strFormInvalid = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Invoke_FormError");
        strXmlInvalid = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Invoke_ErrXmlName");
        strListInvalid = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Invoke_ErrList");
        strXmlExists = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Invoke_ErrXmlExists");

        btnUpdate.Text = strSubmit;
        if(!Page.IsPostBack)
            PopulateListType();
    }
    private void PopulateListType()
    {
        radList.Items.Clear();
        radList.Items.Add(new ListItem(strList, "yes"));
        radList.Items.Add(new ListItem(strXml, "no"));
        radList.Items[1].Selected = true;
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
        FormVersionLookUp.IsLatestVisible = true;
        FormVersionLookUp.DropDownHeight = 80;
        
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

        try
        {
            
            if (ErrMsg == "")
            {
                if (txtXmlName.Text.Trim() == "")
                    ErrMsg = strXmlInvalid;//"Please Enter Output XmlVariable Name.";
                else
                {
                    Workflow.NET.Action startAction = ProcessDesignerControl.ProcessDefinition.Actions["Start"];
                    Workflow.NET.Property xmlVariablesProperty = startAction.Properties["XmlVariables"];
                    XmlVariableCollection xmlVaribleCollection = ((Workflow.NET.PropertyTypes.PropertyXmlVariable)(xmlVariablesProperty.PropertyHandler)).XmlVariableCollection;

                    Workflow.NET.Designer designer = new Workflow.NET.Designer(ApplicationName, WorkflowName);
                    Workflow.NET.XmlVariable XVariable = null;
                    if (IsListXml)
                    {
                        
                        if (listExplorer1.Value == Guid.Empty)
                            throw new Exception(strListInvalid);
                        XVariable = designer.GetListXmlVariable(listExplorer1.Value, txtXmlName.Text, txtXmlDescription.Text);
                    }
                    else
                    {
                        string definitionXml = GetFormDefinitionXml(new Guid(FormListLookUp.Value.ToString()));
                        XVariable = designer.GetFormXmlVariable(definitionXml, Workflow.NET.Designer.FormType.BaseForm, txtXmlName.Text, txtXmlDescription.Text, "variables");
                    }
                    xmlVaribleCollection.Add(XVariable.Name, XVariable);
                    selProperty.Value = txtXmlName.Text;
                    ProcessDesignerControl.WriteFile();
                    
                    Response.Write("<script language='javascript'> window.opener.top._skProcessDesigner.RefreshProperties();window.setTimeout('window.close()',100); </script>");
                }
            }
        }
        catch (Exception exp)
        {
            if (exp.Message.ToLowerInvariant() == "an item with the same key has already been added.")
            {
                ErrMsg = strXmlExists;//"XmlVariable already exists, please choose another name.";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "ShowBellyBarMessage", "<script>DisplayMessage();</script>");
               
            }
            else
            {
                ErrMsg = exp.Message;
                ClientScript.RegisterClientScriptBlock(this.GetType(), "ShowBellyBarMessage", "<script>DisplayMessage();</script>");
            }
        }
    }
    private string GetFormDefinitionXml(Guid formId)
    {
        string definitionXml = "";
        string errormsg = strFormInvalid;//"Please select valid Form Name.";
        try
        {
            Skelta.Repository.List.ListDefinition _List = new Skelta.Repository.List.ListDefinition(new Skelta.Core.ApplicationObject(ApplicationName), "Forms List");
            Skelta.Repository.List.ListItem item = new Skelta.Repository.List.ListItem(_List, formId);

            ListTableForm _Form = ((ListTableForm)item.ListForm.Records[0].FindControlByID("_sys_fmdef_new"));
            if (_Form.Records.Count == 0)
            {
                _Form.AppendRow();
            }

            definitionXml = ((ListTextDataItem)_Form.Records[0].FindControlByID("_sys_def_xml")).Value.ToString();
        }
        catch {
            ErrMsg = errormsg;
            throw new Exception(errormsg);
        }
        //catch { ErrMsg = errormsg; }
    
        return definitionXml;

    }

    protected void radList_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        if (radList.SelectedValue == "no")
        {
            IsListXml = false;
            PopulateFormName();
            PopulateFormVersion(true);
        }
        else if (radList.SelectedValue == "yes")
            IsListXml = true;
    }
 }
 