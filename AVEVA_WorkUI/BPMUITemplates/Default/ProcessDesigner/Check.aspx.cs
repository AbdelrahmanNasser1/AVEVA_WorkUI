using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Workflow.NET.Web.Designer;
using Workflow.NET;

public partial class SkeltaTemplates_Default_ProcessDesigner_Check : System.Web.UI.Page
{
    protected ProcessDesigner ProcessDesignerControl;
    protected ProcessDesignerAdapter pda;
    protected String actionname = "";
    protected String propertyname = "";
    protected String valueString = "";
    protected String filename = "";
    protected String _applicationname = "";
    protected String _workflowname = "";
    protected String _fileName = "";
    protected Property selProperty = null;
    protected String innerhtml = "";
    protected String JScriptPath = "";
    protected String helpimagetags = "";
    protected string selChannel = "";
    protected string selForm = "";
    protected string _TemplateName = "";
    protected string _Culture = "";
    protected String URL = "";
    protected String UrlForm = "";
    protected String divContent = "";

    protected void Page_Load(object sender, EventArgs e)
    {


        if (!Page.IsPostBack)
        {
            actionname = this.Context.Request["actionname"];
            propertyname = this.Context.Request["propertyname"];

            pda = new ProcessDesignerAdapter();
            pda.LoadControlInstance(false);
            ProcessDesignerControl = pda.ProcessDesignerControl;

            Workflow.NET.Action selAction = ProcessDesignerControl.ProcessDefinition.Actions[actionname];
            selProperty = selAction.Properties[propertyname];

            Property pActionDefinition = ((ActionBase)ProcessDesignerControl.ActionsDefinition.Actions[selAction.ActionType]).Properties[selProperty.Name] as Property;
            string winParams = "height = " + pActionDefinition.HelpTemplateWinHeight + ", width = " + pActionDefinition.HelpTemplateWinWidth + ",scrollbars=yes,resizable=yes";
            string propertyhelp = " title=\"" + pActionDefinition.HelpString + "\" onclick=\"javascript:OpenHelpWin('" + ProcessDesignerControl.GetHelpPageUrl() + pActionDefinition.HelpTemplate + "','" + winParams + "')\"";
            JScriptPath = ProcessDesignerControl.GetJscriptUrl("javascript\\PropertyPages.js");
            helpimagetags = propertyhelp;

            Workflow.NET.PropertyTypes.PropertyTypeChannels pr = (Workflow.NET.PropertyTypes.PropertyTypeChannels)selProperty.PropertyHandler;
            valueString = pr.Value;


        }
        else
        {

            _applicationname = Request["_skappname"];
            _workflowname = Request["_skworkflowname"];
            _fileName = Request["_skfilename"];
            _TemplateName = Request["_sktemplatename"];
            _Culture = Request["_skculture"];
            actionname = Request["hidactionname"];
            propertyname = Request["hidpropertyname"];

            pda = new ProcessDesignerAdapter();
            pda.LoadControlInstance(false);

            ProcessDesignerControl = pda.ProcessDesignerControl;
            ProcessDesignerControl.ApplicationName = _applicationname;
            ProcessDesignerControl.WorkflowName = _workflowname;
            ProcessDesignerControl.FileName = _fileName;

            ProcessDesignerControl.InitializeValues();
            ProcessDesignerControl.ProcessDefinition.PreProcessDiagaram();

            Workflow.NET.Action selAction = ProcessDesignerControl.ProcessDefinition.Actions[actionname];
            selProperty = selAction.Properties[propertyname];

            //Workflow.NET.PropertyTypes.PropertyTypeChannels pr = (Workflow.NET.PropertyTypes.PropertyTypeChannels)selProperty.PropertyHandler;
            //pr.Value = RadEditor1.Text;

            //lnkConfig.PostBackUrl = "configChannel.aspx?ActionName=" + actionname + "&propertyname=" + propertyname + "&_skfilename=" + _fileName + "&_skappname=" + _applicationname + "&_skworkflowname=" + _workflowname + "&_skculture=" + _Culture + "&_sktemplatename=" + _TemplateName + "&selChannel=" + ddlChannels1.SelectedItem.Text.ToString();
            

        }

    }
}
