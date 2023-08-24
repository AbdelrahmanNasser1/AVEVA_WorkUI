using System;
using System.Globalization;
//using System.Data;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Workflow.NET;
using Workflow.NET.Web.Designer;
using System.Data;
using System.Data.SqlClient;

public partial class _Default : System.Web.UI.Page
{   protected ProcessDesigner ProcessDesignerControl;
    protected ProcessDesignerAdapter pda;
   // protected ProcessDesigner PD;
    protected  String actionname = "";
    protected  String propertyname = "";
    protected  String valueString = "";
    protected  String filename = "";
    protected  String _applicationName = "";
    protected  String _workflowName = "";
    protected  String _fileName = "";
    protected  Property selProperty = null;
    Workflow.NET.Action selAction = null;
    protected  String JScriptPath = "";
    protected  String helpimagetags = "";
    protected String radTxt = String.Empty;

    protected String act = "";
    protected String prop = "";
    protected String Update = "";
    protected String Close = "";
    protected String sWorkflow = "";
    protected String errresults = "";
    protected string PageTitle = "";
    protected string themePath = string.Empty;
    protected Workflow.NET.SkeltaResourceSetManager resource = new SkeltaResourceSetManager();
    protected void Page_Load(object sender, EventArgs e)    
    {
        themePath = Workflow.NET.TemplateExpressionBuilder.GetUrl("").ToString();
        if (!Page.IsPostBack)
        {
            string classID = "WorkflowScript"+Guid.NewGuid().ToString("N");
            errresults = "";
            actionname = Skelta.Repository.Security.CommonFunctions.SanitizeValue(this.Context.Request["actionname"].ToString());
            propertyname = Skelta.Repository.Security.CommonFunctions.SanitizeValue(this.Context.Request["propertyname"].ToString());
            
            pda = new ProcessDesignerAdapter();
            pda.LoadControlInstance(false);
            ProcessDesignerControl = pda.ProcessDesignerControl;
                     
            
            act = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString(actionname);
            prop = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Code");
            Update = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Update");
            Close = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Close");
            sWorkflow = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Workflow.NET");
            PageTitle = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Skelta BPM.NET 2007") + "-" + actionname + "-" + ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString(propertyname);
            btnUPDATE.Text = Update;
            selAction = ProcessDesignerControl.ProcessDefinition.Actions[actionname];
            string language = ((Workflow.NET.PropertyTypes.PropertyChoice)((Property)selAction.Properties["Language"]).PropertyHandler).Value;
            string tempLanguage = "";
           
            string displaystr = resource.GlobalResourceSet.GetString("Please select the scripting Language", true);
            if (string.IsNullOrEmpty(language))
            {
                //Response.Write("<script language='javascript'>alert('"+displaystr+"');window.close();</script>");
                Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "alertmsg", "<script> se.ui.messageDialog.showError(\"" + Microsoft.Security.Application.Encoder.JavaScriptEncode(ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString(propertyname), false) + "\",\"" + displaystr + "\",function (){ window.close(); }); </script>");
                return;
            }
            Diagram processdefination = ProcessDesignerControl.ProcessDefinition;
            selProperty = selAction.Properties[propertyname];

            Property pActionDefinition = ((ActionBase)ProcessDesignerControl.ActionsDefinition.Actions[selAction.ActionType]).Properties[selProperty.Name] as Property;
            string winParams = "height = " + pActionDefinition.HelpTemplateWinHeight + ", width = " + pActionDefinition.HelpTemplateWinWidth + ",scrollbars=yes,resizable=yes";
            string propertyhelp = " title=\"" + pActionDefinition.HelpString + "\" onclick=\"javascript:OpenHelpWin('" + ProcessDesignerControl.GetHelpPageUrl() + pActionDefinition.HelpTemplate + "','" + winParams + "')\"";
            JScriptPath = ProcessDesignerControl.GetJscriptUrl("javascript\\PropertyPages.js");
            helpimagetags = propertyhelp;
            Workflow.NET.PropertyTypes.PropertyMemo pr = (Workflow.NET.PropertyTypes.PropertyMemo)selProperty.PropertyHandler;
            string GetCode = pr.Value;

            if (pr.ValueHTML == "" || pr.ValueHTML == null)
            {
                valueString = GetCode;
                
                valueString = valueString.Replace("<%#ActionName%>", classID);
                
                //valueString = valueString.Replace("<%#ActionName%>", actionname);
                valueString = this.Context.Server.HtmlEncode(valueString);
                for (int i = 0; i < valueString.Length; i++)
                {
                    valueString = valueString.Replace("&lt;br&gt;", "<br>");
                    valueString = valueString.Replace("\r\n", "<br>");
                    valueString = valueString.Replace("\n", "<br>");
                    valueString = valueString.Replace("\t", "&nbsp");
                }

                RadEditor1.Html = valueString;
            }
            if (pr.ValueHTML == "flag")
            {
                valueString = GetCode;
               // valueString = valueString.Replace("<%#ActionName%>", actionname);
                valueString = valueString.Replace("<%#ActionName%>", classID);
                for (int i = 0; i < valueString.Length; i++)
                {
                    valueString = valueString.Replace("\r\n", "<br>");
                    valueString = valueString.Replace("\n", "<br>");
                    valueString = valueString.Replace("\t", "&nbsp");
                }
                RadEditor1.Html = this.Context.Server.HtmlDecode(valueString);
            }
            else
            {
                valueString = pr.ValueHTML;
                //valueString = valueString.Replace("<%#ActionName%>", actionname);
                valueString = valueString.Replace("<%#ActionName%>", classID);
                RadEditor1.Html = valueString;
            }
           // RadEditor1.EnableTab = true;
           // RadEditor1.EnableHtmlIndentation = true;
            RadEditor1.Language = this.Context.Request["lang"];
           
        }
        else
        {
            propertyname = Skelta.Repository.Security.CommonFunctions.SanitizeValue(Request["hidpropertyname"].ToString());
           
            actionname = Request["hidactionname"];           
            
            pda = new ProcessDesignerAdapter();
            pda.LoadControlInstance(false);
            ProcessDesignerControl = pda.ProcessDesignerControl;

            _applicationName = Request["_skappname"];
            _workflowName = Request["_skworkflowname"];
            _fileName = Request["_skfilename"];

            act = Request["hidact"];
            prop = Request["hidprop"];
            Update = Request["hidUpdate"];
            Close = Request["hidClose"];
            sWorkflow = Request["hidWorkflow"];

            btnUPDATE.Text = Update;

            ProcessDesignerControl.ApplicationName = _applicationName;
            ProcessDesignerControl.WorkflowName = _workflowName;
            ProcessDesignerControl.FileName = _fileName;
            selAction = ProcessDesignerControl.ProcessDefinition.Actions[actionname];
            selProperty = selAction.Properties[propertyname];
            
        }
      
        
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        for (int i = 0; i < RadEditor1.Text.Length; i++)
        {
            radTxt = RadEditor1.Text;
        }
        string language = ((Workflow.NET.PropertyTypes.PropertyChoice)((Property)selAction.Properties["Language"]).PropertyHandler).Value;
        if (string.IsNullOrEmpty(language))
        {
            Response.Write("<script language='javascript'>alert('Please select the scripting Language');window.close();</script>");
            return;
        }

        object[] References = ((Workflow.NET.PropertyTypes.PropertyGrid)
                ((Property)selAction.Properties["References"]).PropertyHandler).GridValue;
        string[] results;
        if (this.Context.Request["IsQuickflow"] == "True")
        {
            var externalReferences = References != null ? new string[References.Length] : null;
            if (References != null)
            {
                int index = 0;
                foreach (var item in (object[])References)
                {
                    var assemblyItem = item as object[];
                    if (assemblyItem[1].ToString().Contains("[INSTALLDIR]Bin") == false)
                    {
                        externalReferences[index] = string.Concat(assemblyItem[1], assemblyItem[0]);
                        index++;
                    }
                }
            }

            results = ScriptCompiler.CompileScriptCodeForQuickflow(language, RadEditor1.Text, externalReferences);
        }
        else
        {
            results = ScriptCompiler.CompileScriptCode(language, RadEditor1.Text, References);
        }
        
        if (results == null || results.Length == 0)
        {
            Workflow.NET.PropertyTypes.PropertyMemo pr = (Workflow.NET.PropertyTypes.PropertyMemo)selProperty.PropertyHandler;
            pr.Value = RadEditor1.Text;
            pr.ValueHTML = RadEditor1.Html;
            ProcessDesignerControl.WriteFile();
            Response.Write("<script language='javascript'> window.setTimeout('window.opener.refreshselectedaction()',100);window.opener.parent._skProcessDesigner.RefreshProperties();window.setTimeout('window.close()',100); </script>");
        }
        else
        {            
            foreach (string str in results)
            {
                errresults += "\\n"+str;
                errresults =  errresults.Replace("'", "");
                lbl.Text = "<a href=\"Javascript:alert('" + errresults + "');\"><b style='color:red'>View Errors</b></a>";
            }
           
        }
    }
}
