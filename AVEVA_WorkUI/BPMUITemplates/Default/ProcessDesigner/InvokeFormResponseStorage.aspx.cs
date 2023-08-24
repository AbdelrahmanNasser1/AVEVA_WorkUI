using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using AntiXssEncoder = Microsoft.Security.Application.Encoder;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Workflow.NET.Web.Designer;
using Workflow.NET;
using Skelta.Forms.Core.Controls;

public partial class SkeltaTemplates_Default_ProcessDesigner_InvokeFormResponseStorage : System.Web.UI.Page
{
    protected ProcessDesigner ProcessDesignerControl;
    protected string _actionName = "";
    protected string _propertyName = "";
    protected string _applicationName = "";
    protected string _workflowName = "";
    protected string _fileName = "";
    protected Workflow.NET.Property _selProperty = null;
    protected string _jScriptPath = "";
    protected string _jScriptPathHelp = "";
    protected string _commonjScriptPath = "";
    protected string _xmlTreejScriptPath = "";
    protected string _helpimagetags = "";
    protected string _TemplateName = "";
    protected string _Culture = "";
    protected string _formXmlTree = "";
    protected string _formXmlErr = "";
    protected string _CtrlID = "";
    protected string _cmnDirForImages = "";
    protected string _formIdForDOM = "";
    protected string _outputXMLNameForDOM = "";
    protected string _outPutXMLVarName = "";
    protected string _outputXmlErr = "";
    Workflow.NET.Action _selectedAction;
    protected string _outPutXmlVarXmlTree = string.Empty;
    protected string _indResponseNode = string.Empty;
    protected string _allActResponseNode = string.Empty;
    protected Workflow.NET.SkeltaResourceSet _rs;
    protected string _indResponseNodeEmpty;
    protected string _appendNodeEmpty;
    protected int _indResponseNodeUpdatedSuccessfully = 0;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        _CtrlID = "FormResponse";
        
        ProcessDesignerAdapter PDA = new ProcessDesignerAdapter();
        PDA.LoadControlInstance(false);
        ProcessDesignerControl = PDA.ProcessDesignerControl;
        _applicationName = ProcessDesignerControl.ApplicationName;
        _workflowName = ProcessDesignerControl.WorkflowName;
        _fileName = ProcessDesignerControl.FileName;
        _actionName = AntiXssEncoder.HtmlEncode(this.Context.Request["ActionName"]);
        _propertyName = AntiXssEncoder.HtmlEncode(this.Context.Request["selPropertyName"]);
         _selectedAction = ProcessDesignerControl.ProcessDefinition.Actions[_actionName];
        _selProperty = _selectedAction.Properties[_propertyName];

        _rs = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet;
       
        if (_selectedAction.Properties.Contains("OutputInstanceXML"))
            if (!((Workflow.NET.Interfaces.IPropertyExpression)((Workflow.NET.Property)_selectedAction.Properties["OutputInstanceXML"]).PropertyHandler).IsExpression)
                _outPutXMLVarName = _selectedAction.Properties["OutputInstanceXML"].Value.ToString();

        object cmnDirImages = Workflow.NET.TemplateExpressionBuilder.GetUrl("Common");
        _cmnDirForImages = (cmnDirImages!=null)?cmnDirImages.ToString():"";

        
        Workflow.NET.Web.Designer.XmlDesignerHelper designHelper = new Workflow.NET.Web.Designer.XmlDesignerHelper();
        Workflow.NET.XmlVariable frmXMLVar =  GetFormTempXmlVariable(_selectedAction);

        if (frmXMLVar != null)
            _formXmlTree = designHelper.BuildXmlTree(frmXMLVar, _cmnDirForImages);
        else
            _formXmlErr = _rs.GetString("AdvancedResponseStorage_InvalidFormSchema");
                //"<span id=\"spnColRespNodeErr\" class=\"errormsg\">"+_rs.GetString("AdvancedResponseStorage_InvalidFormSchema")+"</span><br />"; //cmbResponse_Image
        
     
        Workflow.NET.XmlVariable outPutXMLVariable = GetOutPutXMLVariable();

        if (outPutXMLVariable != null)
            _outPutXmlVarXmlTree = designHelper.BuildXmlTree(outPutXMLVariable, _cmnDirForImages);
        else
        {
            _outputXmlErr = _rs.GetString("AdvancedResponseStorage_InvalidInoutXmlSchema");
            //"<span id=\"spnAllActorRespNodeErr\" class=\"errormsg\">" + _rs.GetString("AdvancedResponseStorage_InvalidInoutXmlSchema") + "</span><br />"; 
            ClientScript.RegisterClientScriptBlock(this.GetType(), "ShowBellyBarMessage", "<script>DisplayMessage();</script>");
        }
        _indResponseNodeEmpty =_rs.GetString("AdvancedResponseStorage_IndividualResp_Empty");
        _appendNodeEmpty = _rs.GetString("AdvancedResponseStorage_AppendNode_Empty");
        _commonjScriptPath = ProcessDesignerControl.GetJscriptUrl("../Common/Javascripts/jsfunctions.js");
        _jScriptPath = ProcessDesignerControl.GetJscriptUrl("Javascript/SkeltaValueSelector.js");
        _xmlTreejScriptPath = ProcessDesignerControl.GetJscriptUrl("Javascript/XmlTreeview.js");

        if (!Page.IsPostBack)
        {
            _indResponseNode = ((Skelta.HWS.PropertyTypes.PropertyResponseStorage)_selProperty.PropertyHandler).IndividualResponseNodeXPath;
            _allActResponseNode = ((Skelta.HWS.PropertyTypes.PropertyResponseStorage)_selProperty.PropertyHandler).AllActorsResponsesNodeXPath;
            _jScriptPathHelp = ProcessDesignerControl.GetJscriptUrl("javascript\\PropertyPages.js");
            string winParams = "height=550,width=560,scrollbars=yes,resizable=yes";
            string propertyhelp = " onclick=\"javascript:OpenHelpWin('" + ProcessDesignerControl.GetHelpPageUrl() + "IndividualActorsResponseCollaborationInOutputInstanceXML.html" + "','" + winParams + "')\"";
            _helpimagetags = propertyhelp; 
        }

        else
        {
            string individualResponseNode = Request["cmbResponse_Input" + _CtrlID];
            string allActorsResponsesNode = Request["cmbAppendTo_Input" + _CtrlID];

            individualResponseNode = string.IsNullOrEmpty(individualResponseNode)?"":individualResponseNode.Trim();
            allActorsResponsesNode = string.IsNullOrEmpty(allActorsResponsesNode) ? "" : allActorsResponsesNode.Trim();

            ((Skelta.HWS.PropertyTypes.PropertyResponseStorage)_selProperty.PropertyHandler).IndividualResponseNodeXPath = individualResponseNode;
            ((Skelta.HWS.PropertyTypes.PropertyResponseStorage)_selProperty.PropertyHandler).AllActorsResponsesNodeXPath = allActorsResponsesNode;
            ProcessDesignerControl.WriteFile();

            _indResponseNodeUpdatedSuccessfully = 1;
        }
        //btnCancel.Text = _rs.GetString("AdvancedResponseStorage_BtnCancel");
        //btnCancel.Click += new EventHandler(this.btnCancel_Click);
      

    }

    private Workflow.NET.XmlVariable GetOutPutXMLVariable()
    {
        Workflow.NET.XmlVariable xVar = null;
        Workflow.NET.Action startAction = ProcessDesignerControl.ProcessDefinition.Actions["Start"];
        Workflow.NET.Property xmlVarProperty = startAction.Properties["XmlVariables"];
        Workflow.NET.XmlVariableCollection xmlVarCol = ((Workflow.NET.PropertyTypes.PropertyXmlVariable)(xmlVarProperty.PropertyHandler)).XmlVariableCollection;
        foreach (Workflow.NET.XmlVariable xmlVaraiable in xmlVarCol.Values)
        {
            if (xmlVaraiable.Name.Equals(_outPutXMLVarName))
            {
                xVar = xmlVaraiable;
                break;
            }
        }
        return xVar;
    }
     

    private Workflow.NET.XmlVariable GetFormTempXmlVariable(Workflow.NET.Action selectedAction)
    {
        Workflow.NET.XmlVariable formVar = null;
        string formDetailsPropertyName = "FormDetails";
        if (selectedAction.Properties.Contains(formDetailsPropertyName))
        {
            if (!((Workflow.NET.Interfaces.IPropertyExpression)((Workflow.NET.Property)_selectedAction.Properties[formDetailsPropertyName]).PropertyHandler).IsExpression)
            {
                string formDetails = selectedAction.Properties[formDetailsPropertyName].Value.ToString();
                if (!string.IsNullOrEmpty(formDetails))
                {
                    string name = string.Empty;
                    Guid id = Guid.Empty;
                    string version = string.Empty;
                    Skelta.InvokeForm.PropertyHandleRequest formPropertyHandler = _selectedAction.Properties[formDetailsPropertyName].PropertyHandler as Skelta.InvokeForm.PropertyHandleRequest;
                    formPropertyHandler.GetFormDetails(out id, out name, out version);                    

                    Skelta.Repository.List.ListDataHandler lDataHandler = new Skelta.Repository.List.ListDataHandler(_applicationName, "Forms List");
                    Skelta.Repository.List.ListItem lItem = null;

                    if (!string.IsNullOrEmpty(name))
                    {
                        if (!string.IsNullOrEmpty(version) && version != "0")
                            lItem = lDataHandler.GetListItem(name, version);
                        else
                            lItem = lDataHandler.GetListItem(name);
                    }
                    if (lItem == null && !id.Equals(Guid.Empty))
                    {
                        if (string.IsNullOrEmpty(version) || version == "0")
                            lItem = lDataHandler.GetListItem(id);
                        else
                            lItem = lDataHandler.GetListItem(id, version);
                    }
                    if (lItem == null)
                        throw new Exception("Not able to load the form details");
                    else
                        id = lItem.Id;

                    _formIdForDOM = id.ToString("N");


                    ListTableForm _dbDefn = ((ListTableForm)lItem.ListForm.Records[0].FindControlByID("_sys_fmdef_new"));

                    string frmDefnXml = ((ListTextDataItem)_dbDefn.Records[0].FindControlByID("_sys_def_xml")).Value;
                    Workflow.NET.Designer designer = new Workflow.NET.Designer(_applicationName, _workflowName);
                    formVar = designer.GetFormXmlVariable(frmDefnXml, Workflow.NET.Designer.FormType.BaseForm, id.ToString("N"), "Temp", "");

                }
            }
        }
        return formVar;
    }

    protected void btnCancel_Click(Object sender, EventArgs e)
    {
        
    }
     


   
}
