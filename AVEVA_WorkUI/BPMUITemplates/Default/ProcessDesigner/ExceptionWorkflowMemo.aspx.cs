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
using Workflow.NET;
using Workflow.NET.Web.Designer;
using System.Xml;

public partial class WFMemo : System.Web.UI.Page
{
    protected ProcessDesigner ProcessDesignerControl;
    protected ProcessDesignerAdapter pda;
    protected String actionname = "";
    protected String propertyname = "";
    protected String valueString = "";
    protected String filename = "";
    protected String _applicationName = "";
    protected String _workflowName = "";
    protected String _fileName = "";
    protected Property selProperty = null;
    protected String assignedvalue = "";
    protected String assignedvariables = "";
    protected String assignedcontents = "";
    protected String assignedXmlvariables = "";
    protected String JScriptPath = "";
    protected String helpimagetags = "";
    protected String act = "";
    protected String prop = "";
    protected String Field = "";
    protected String Update = "";
    protected String Close = "";
    protected String Append = "";
    protected String sVariable = "";
    protected String sContent = "";
    protected String sXmlVariables = "";
    protected string sValue = "";
    protected String sWorkflow = "";
    protected string xmltree = "";
    protected bool Mandatory;
    protected string spScripts = "";
    protected string jsErrMsg = "";
    protected string jsErrMsg2 = "";
    public static string RadText = "";
    protected static String Templates = "";

    protected string strSelect = "";             
    protected string strReponame="";
    protected string strWorkflowname="";
    protected string strExecutionId="";
    protected string strExecutionDetailsId="";
    protected string strWorkItemId = "";
    protected string strProcessName = "";
    protected string strModuleName = "";
    protected string strErrorMessage = "";
    protected string strValidStandardPlaceHolderMessage = "";
    protected string cssPath,bellyBarPath;

    protected void Page_Load(object sender, EventArgs e)
    {
        btnUpdate.Attributes.Add("onclick", "return clientConfirm()");



        cssPath = Workflow.NET.TemplateExpressionBuilder.GetUrl("").ToString();
        bellyBarPath = Workflow.NET.CommonFunctions.GetJSReferencePath();
        if (!Page.IsPostBack)
        {
            actionname = this.Context.Request["actionname"];
            propertyname = this.Context.Request["selpropertyname"];
            _fileName = this.Context.Request["wfmemoFilename"];

            Templates = this.Context.Request["Template"];
            pda = new ProcessDesignerAdapter();
            pda.LoadControlInstance(false);

            ProcessDesignerControl = pda.ProcessDesignerControl;

            ProcessDesignerControl.FileName = _fileName;

            ProcessDesignerControl.InitializeValues();
            ProcessDesignerControl.ProcessDefinition.PreProcessDiagaram();
            GetXmlVariables();                       
            act = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString(actionname);
            Field = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Field");
            Update = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Update");
            Close = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Close");
            Append = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Append");
            sWorkflow = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Skelta BPM.NET 2007");
            btnUpdate.Text = Update;
            sVariable = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Variable");
            sValue = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Value");
            sContent = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Content");
            jsErrMsg = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Value not entered");
            jsErrMsg2 = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Please Enter");
            strValidStandardPlaceHolderMessage = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Excep_validationstdpholdermessage");

            sXmlVariables = "XmlVariables";
            Workflow.NET.Action selAction = ProcessDesignerControl.ProcessDefinition.Actions[actionname];
            selProperty = selAction.Properties[propertyname];
            if (selProperty.DisplayName != "")
                prop = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString(selProperty.DisplayName);
            else
                prop = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString(propertyname);

            Property pActionDefinition = ((ActionBase)ProcessDesignerControl.ActionsDefinition.Actions[selAction.ActionType]).Properties[selProperty.Name] as Property;
            string winParams = "height = " + pActionDefinition.HelpTemplateWinHeight + ", width = " + pActionDefinition.HelpTemplateWinWidth + ",scrollbars=yes,resizable=yes";
            string propertyhelp = " title=\"" + pActionDefinition.HelpString + "\" onclick=\"javascript:OpenHelpWin('" + ProcessDesignerControl.GetHelpPageUrl() + pActionDefinition.HelpTemplate + "','" + winParams + "')\"";
            JScriptPath = ProcessDesignerControl.GetJscriptUrl("javascript\\PropertyPages.js");
            helpimagetags = propertyhelp;

            Workflow.NET.PropertyTypes.PropertyExceptionTemplates pr = (Workflow.NET.PropertyTypes.PropertyExceptionTemplates)selProperty.PropertyHandler;            

            Mandatory = pr.Mandatory;
            valueString = pr.ValueHTML;
            if (valueString == "" || valueString == null)
            {
                valueString = pr.Value;
                // valueString = this.Context.Server.HtmlEncode(valueString);
                for (int i = 0; i < valueString.Length; i++)
                {
                    //string brk = "&lt;" + "br" + "&gt;";
                    valueString = valueString.Replace("&lt;br&gt;", "<br>");
                    valueString = valueString.Replace("\r\n", "<br>");
                    valueString = valueString.Replace("\n", "<br>");
                    valueString = valueString.Replace("\t", "&nbsp");
                }


                RadEditor1.Html = GetTemplateString(valueString);
            }
            else
            {
                RadEditor1.Html = GetTemplateString(valueString);
            }
            
            RadEditor1.Language = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.CultureName;
            //RadEditor1.EnableTab = true;
            //RadEditor1.EnableHtmlIndentation = true;
        }
        else
        {
            actionname = Request["hidactionname"];
            propertyname = Request["hidpropertyname"];
            //_applicationName = Request["hid_applicationName"];
            //_workflowName = Request["hid_workflowName"];
            _fileName = Request["hid_fileName"];
            _applicationName = Request["_skappname"];
            _workflowName = Request["_skworkflowname"];
            //_fileName = Request["_skfilename"];


            act = Request["hidact"];
            prop = Request["hidprop"];
            Append = Request["hidAppend"];
            Update = Request["hidUpdate"];
            Close = Request["hidClose"];
            Field = Request["hidField"];
            sVariable = Request["hidVariable"];
            sValue = Request["hidValue"];
            sContent = Request["hidContent"];
            sWorkflow = Request["hidWorkflow"];

            btnUpdate.Text = Update;
            pda = new ProcessDesignerAdapter();
            pda.LoadControlInstance(false);
            ProcessDesignerControl = pda.ProcessDesignerControl;

            ProcessDesignerControl.ApplicationName = _applicationName;
            ProcessDesignerControl.WorkflowName = _workflowName;
            ProcessDesignerControl.FileName = _fileName;
            //
            ProcessDesignerControl.InitializeValues();
            ProcessDesignerControl.ProcessDefinition.PreProcessDiagaram();
            //
            Workflow.NET.Action selAction = ProcessDesignerControl.ProcessDefinition.Actions[actionname];
            selProperty = selAction.Properties[propertyname];
        }


        strSelect = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Select");
        strReponame = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Standard.RepositoryName");
        strWorkflowname = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Standard.WorkflowName");
        strExecutionId = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Standard.ExecutionId");
        strExecutionDetailsId = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Standard.ExecutionDetailsId");
        strWorkItemId = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Standard.WorkitemId");
        strProcessName = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Standard.ProcessName");
        strModuleName  = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Standard.ModuleName");
        strErrorMessage = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Standard.ErrorMessage");

        


        Workflow.NET.Web.Designer.DesignInfo d = new DesignInfo();

        assignedvalue = GetValue();
        assignedvariables = d.GetVariables(ProcessDesignerControl);
        assignedcontents = d.GetContents(ProcessDesignerControl);
        assignedXmlvariables = d.GetXmlVariables(ProcessDesignerControl);

        select3.SendToOptions = assignedvalue;
        select3.VariableOptions = assignedvariables;
        select3.ContentOptions = assignedcontents;
        select3.XmlVariableOptions = assignedXmlvariables;
        xmltree = d.GetXmlTreeFromVariables(ProcessDesignerControl); ;
        if (Page.Request.Browser.Browser.ToLowerInvariant() == "firefox")
        {

        }
    }


    private string GetValue()
    {
     
        return "";
    }
    private string GetResourceProperties(string ObjectName)
    {
        string retval = "";
        string displayValue = "";

        try
        {
            displayValue = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString(ObjectName.Split('.')[0]);
            displayValue = displayValue + "." + ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString(ObjectName.Split('.')[1]);
        }
        catch { displayValue = ObjectName; }

        Workflow.NET.ResourcePropertiesCollection rpc = ProcessDesignerControl.ActionsDefinition.Resources.ResourceProperties;

        foreach (Workflow.NET.ResourceProperty rp in rpc)
        {
            retval += "<OPTION Value='" + ObjectName + (ObjectName != "" ? "." : "") + rp.PropertyName + "'>" + displayValue + (displayValue != "" ? "." : "") + rp.PropertyDisplayName + "</OPTION>";
        }

        return retval;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {

        if (Templates == null)
            Page.ClientScript.RegisterStartupScript(this.GetType(), "PassAdmin", "<script>PassingAdminValues();</script>");
        else
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "PassUser", "<script>PassingUserValues();</script>");
            Templates = "";
        }


    }

    private void GetXmlVariables()
    {
        foreach (Workflow.NET.XmlVariable c in ProcessDesignerControl.ProcessDefinition.XmlVariables.Values)
        {
            string scriptString = "<script>var var" + c.Name + "=0;</script>\n";
            this.Page.ClientScript.RegisterStartupScript(this.GetType(), "sample" + c.Name, scriptString);
        }
    }

    private string GetTemplateString(string strTemplate)
    {
        string strReturnString = "";
        try
        {
            int nAdmin = strTemplate.IndexOf("<AdminTemplates>");
            strTemplate = strTemplate.Insert(nAdmin + 16, "<![CDATA[");
            int nAdminS = strTemplate.IndexOf("</AdminTemplates>");
            strTemplate = strTemplate.Insert(nAdminS, "]]>");
            int nPUser = strTemplate.IndexOf("<ProcessTemplates>");
            strTemplate = strTemplate.Insert(nPUser + 18, "<![CDATA[");
            int nPUserS = strTemplate.IndexOf("</ProcessTemplates>");
            strTemplate = strTemplate.Insert(nPUserS, "]]>");


            XmlDocument doc = new XmlDocument();
            doc.LoadXml(strTemplate);

            string strAdminUsers = doc.SelectNodes("//AdminUsers").Item(0).InnerText.ToString();
            string strAdminTemplates = doc.SelectNodes("//AdminTemplates").Item(0).InnerText.ToString();
            string strProcessUsers = doc.SelectNodes("//ProcessUsers").Item(0).InnerText.ToString();
            string strProcessTemplates = doc.SelectNodes("//ProcessTemplates").Item(0).InnerText.ToString();
            if (Templates == null)
            {
                strReturnString = strAdminTemplates;
            }
            else
            {
                strReturnString = strProcessTemplates;
            }
            if (strReturnString.Contains("Default"))
                strReturnString = "";

        }
        catch (Exception ex)
        {

        }
        return strReturnString;

    }
}
