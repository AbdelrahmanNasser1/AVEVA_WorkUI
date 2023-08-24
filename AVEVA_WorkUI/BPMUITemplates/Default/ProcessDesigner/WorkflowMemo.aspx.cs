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
using System.Text.RegularExpressions;

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
    protected SkeltaResourceSetManager resManager = new SkeltaResourceSetManager();
    protected string themePath = string.Empty;



    protected void Page_Load(object sender, EventArgs e)
    {
        btnUpdate.Attributes.Add("onclick", "return clientConfirm()");
        themePath = Convert.ToString(Workflow.NET.TemplateExpressionBuilder.GetUrl(""));
     
        if (!Page.IsPostBack)
        {
            actionname = this.Context.Request["actionname"];
            propertyname = this.Context.Request["selpropertyname"];
            _fileName = this.Context.Request["wfmemoFilename"];
            //RadEditor1.Language = this.Context.Request["lang"];
            //_applicationName = Request.QueryString["ApplicationName"];
            //_workflowName = Request.QueryString["WorkflowName"];
            //_fileName = Request.QueryString["FileName"];

            pda = new ProcessDesignerAdapter();
            pda.LoadControlInstance(false);
            //string s = pda.GetUrlParameters(false);
            //ProcessDesignerControl = (ProcessDesigner)this.Context.Items["__Skelta_Control_Transfer_From"];
            ProcessDesignerControl = pda.ProcessDesignerControl;
            //ProcessDesignerControl.ApplicationName = _applicationName;
            //ProcessDesignerControl.WorkflowName = _workflowName;
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
            sXmlVariables = "XmlVariables";
            
            Workflow.NET.Action selAction = ProcessDesignerControl.ProcessDefinition.Actions[actionname];
            selProperty = selAction.Properties[propertyname];
            if(selProperty.DisplayName != "")
                prop = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString(selProperty.DisplayName);
            else
                prop = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString(propertyname);

            Property pActionDefinition = ((ActionBase)ProcessDesignerControl.ActionsDefinition.Actions[selAction.ActionType]).Properties[selProperty.Name] as Property;
            string winParams = "height = " + pActionDefinition.HelpTemplateWinHeight + ", width = " + pActionDefinition.HelpTemplateWinWidth + ",scrollbars=yes,resizable=yes";
            string propertyhelp = " title=\"" + pActionDefinition.HelpString + "\" onclick=\"javascript:OpenHelpWin('" + ProcessDesignerControl.GetHelpPageUrl() + pActionDefinition.HelpTemplate + "','" + winParams + "')\"";
            JScriptPath = ProcessDesignerControl.GetJscriptUrl("javascript\\PropertyPages.js");
            helpimagetags = propertyhelp;
            Workflow.NET.PropertyTypes.PropertyWorkflowMemo pr = (Workflow.NET.PropertyTypes.PropertyWorkflowMemo)selProperty.PropertyHandler;
            System.Collections.Generic.List<Workflow.NET.PropertyTypes.Plugin> Plugins = pr.Plugins;

            if (Plugins != null)
            {
                if (Plugins.Count > 0)
                {
                    Image objImage;
                    Label objInlineHelp;
                    string pluginName, pluginParameters;
                    string pluginPage = string.Empty;
                    spScripts += "<script language='javascript'>";
                    foreach (Workflow.NET.PropertyTypes.Plugin plugin in Plugins)
                    {
                        objImage = new Image();
                        pluginName = plugin.Name.Trim();
                        if (!string.IsNullOrEmpty(plugin.PageUrl))
                        {
                            pluginPage = plugin.PageUrl.Trim();
                        }
                        pluginParameters = string.Empty;
                        if (plugin.Parameters.Count > 0)
                        {
                            pluginParameters = pluginPage.IndexOf("?") > -1 ? "&" : "?";
                            pluginParameters += Workflow.NET.PropertyTypes.Plugin.GetParametersAsEncryptedString(plugin);
                        }
                        if (this.Context.Request.QueryString.HasKeys())
                        {
                            foreach (string queryKey in this.Context.Request.QueryString.Keys)
                            {
                                //if (!queryKey.Equals("pdsuri"))
                                //{
                                    pluginParameters += pluginParameters.IndexOf("?") > -1 ? "&" : "?";
                                if(queryKey.ToLowerInvariant()=="actionname")
                                    pluginParameters += queryKey + "=" + Workflow.NET.CommonFunctions.HandleSplCharactersForLocalization(System.Web.HttpUtility.UrlEncode(this.Context.Request.QueryString[queryKey]));
                                else
                                    pluginParameters += queryKey+"="+this.Context.Request.QueryString[queryKey];
                               // }
                            }
                            
                            
                        }
                        if (pluginParameters.ToLower().IndexOf("applicationname") < 0)
                        {
                            _applicationName = (_applicationName == "") ? Request["ApplicationName"] : _applicationName;
                            pluginParameters += "&ApplicationName=" + _applicationName;
                        }

                        if (!string.IsNullOrEmpty(pluginName))
                        {
                            objImage.ID = pluginName;
                            objImage.ImageUrl = GetThemePath(plugin.ImageUrl.Trim()); 
                            objImage.ToolTip = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString(plugin.Description.Trim());
                            objImage.ImageAlign = ImageAlign.AbsMiddle; 
                            if (!string.IsNullOrEmpty(pluginPage))
                            {
                                objImage.Style["cursor"] = "hand";                                                              
                                spScripts += "function " + pluginName + "x(){window.open('" + pluginPage + pluginParameters + "', '" + pluginName + "', '" + plugin.PageFeatures + "');}";
                                objImage.Attributes.Add("onclick", "javascript:" + pluginName + "x();");
                            }
                           
                            TDSharePoint.Controls.Add(objImage);
                            if (!string.IsNullOrEmpty(plugin.InlineHelp))
                            {
                                Label lblSpace = new Label();
                                lblSpace.ID = "lblSpace" + pluginName;
                                lblSpace.Text = "&nbsp;";
                                TDSharePoint.Controls.Add(lblSpace);
                                objInlineHelp = new Label();
                                objInlineHelp.ID = "lblInlineHelp" + pluginName;
                                objInlineHelp.Text = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString(plugin.InlineHelp.Trim());
                                objInlineHelp.CssClass = "note";                                                    
                                TDSharePoint.Controls.Add(objInlineHelp);
                            }
                        }
                    }
                    spScripts += "</script>";
                }
            }

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


                RadEditor1.Html = valueString;
            }
            else
            {
                RadEditor1.Html = valueString;
            }
            //RadEditor1.Language = this.Context.Request["lang"];
           // RadEditor1.Language = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.CultureName;
           // RadEditor1.EnableTab = true;
           // RadEditor1.EnableHtmlIndentation = true;
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
       
    }

    private string GetThemePath(string imagePath)
    {
        string updatedImagePath = imagePath;
        object cssPath = Workflow.NET.TemplateExpressionBuilder.GetUrl("");
        updatedImagePath = imagePath.Replace("../", cssPath.ToString());
        return updatedImagePath;
    }

    private string GetValue()
    {
        Workflow.NET.Action selAction = ProcessDesignerControl.ProcessDefinition.Actions[actionname];
        //string sValue = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Value");
        string sValue = "Value";
        if (selAction.Properties.Contains("To"))
        //if (ProcessDesignerControl.SelectedAction.Properties.Contains("To"))
        {
            return GetResourceProperties(sValue + ".SendTo");
        }
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
            retval += "<OPTION Value='" + ObjectName + (ObjectName != "" ? "." : "") + rp.PropertyName + "'>" + displayValue + (displayValue != "" ? "." : "") + ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString(rp.PropertyDisplayName) + "</OPTION>";
        }

        return retval;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        //selProperty.Value = RadEditor1.Text;
        
        Workflow.NET.PropertyTypes.PropertyWorkflowMemo pr = (Workflow.NET.PropertyTypes.PropertyWorkflowMemo)selProperty.PropertyHandler;

        //char[] endChar = { ' ', '\r', '\n', '\t' };
        
        
        // The below check is added since in some cased RadEditor1.Text was appending with junk value.Now 
        string actualValue = RadEditor1.Text;
        if (!string.IsNullOrEmpty(hdnEditor.Value))
        {
            if (!hdnEditor.Value.Equals(actualValue.Trim()))
                actualValue = hdnEditor.Value;
        }
        pr.Value = actualValue;
        //pr.Value = RadEditor1.Text.TrimStart(endChar).TrimEnd(endChar);

        pr.ValueHTML = RemoveBRTagFromStyleTag(RadEditor1.Html);
        ((Workflow.NET.Interfaces.IPropertyExpression)(selProperty.PropertyHandler)).IsExpression = false;
        ProcessDesignerControl.WriteFile();
        //Page.ClientScript.RegisterStartupScript(this.GetType(), "refreshParent", "RefreshParentAndCloseWindow()", true);
        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "refreshParent", "<script>RefreshParentAndCloseWindow();</script>");
        
        //Response.Write("<script language='javascript'>try { if(window.opener!=null) window.setTimeout('window.opener.refreshselectedaction()',100); if(window.opener.parent!=null) window.opener.parent._skProcessDesigner.RefreshProperties(); window.setTimeout('window.close()',100); } catch(err) {}</script>");

    }
    private string RemoveBRTagFromStyleTag(string radHtml)
    {
        string htmlContent = radHtml;
        string finalOutput = "";
        try
        {
            if (htmlContent != "\r\n")
            {
                string firstString = "";
                string secondString = "";
                if (htmlContent.IndexOf("&lt;style&gt;") > -1)
                {
                    firstString = htmlContent.Substring(0, htmlContent.IndexOf("&lt;style&gt;"));
                    if (htmlContent.IndexOf("&lt;/style&gt;") > -1)
                        secondString = htmlContent.Substring(htmlContent.IndexOf("&lt;/style&gt;") + 14);
                    string styleTag = htmlContent.Substring(htmlContent.IndexOf("&lt;style&gt;"), htmlContent.IndexOf("&lt;/style&gt;"));

                    string finalText = firstString + styleTag.Replace("<BR>","") + secondString;
                    
                    finalOutput = finalText;
                }
                else
                    finalOutput = htmlContent;
            }
        }
        catch (Exception exp)
        {

        }
        return finalOutput;
    }
    private string RemoveBRTagFromStyleTag_RegTest(string radHtml)
    {
        string htmlContent = radHtml;
        try
        {
            //Regex regSkeltaEmbedImage = new Regex("(&lt;style&gt;(?<matchingImageFile>.*?)&lt;/style&gt;)", RegexOptions.CultureInvariant | RegexOptions.IgnoreCase);
            //Regex regSkeltaEmbedImage = new Regex("(&lt;style&gt;([^{]*{(?'Content'[^{]*)&lt;/style&gt;)");
            Match mc = Regex.Match(htmlContent, "&lt;style&gt;[^{]*{(?'Content'[^{]*)&lt;/style&gt;");
            htmlContent = mc.Groups["Content"].Value;
            //Regex regSkeltaEmbedImage = new Regex("(style(?<matchingImageFile>.*?)style)");
            //MatchCollection imgFileCollection = regSkeltaEmbedImage.Matches(radHtml);
            
            //foreach (Match imgFile in imgFileCollection)
            //{
            //    htmlContent = imgFile.Groups["Content"].Value;
            //}

        }
        catch (Exception exp)
        {
 
        }
        return htmlContent;
    }
    private void GetXmlVariables()
    {
        foreach (Workflow.NET.XmlVariable c in ProcessDesignerControl.ProcessDefinition.XmlVariables.Values)
        {
            string scriptString = "<script>var var" + c.Name + "=0;</script>\n";
            this.Page.ClientScript.RegisterStartupScript(this.GetType(), "sample" + c.Name, scriptString);
        }
    }
}
