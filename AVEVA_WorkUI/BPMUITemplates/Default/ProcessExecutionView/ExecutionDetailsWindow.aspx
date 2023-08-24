<%@ Page Language="C#" AutoEventWireup="true" Debug="false" Inherits="Workflow.NET.CodeBehind.ProcessExecutionView.ExecutionDetailsWindow" Theme="" StylesheetTheme=""%>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ Import Namespace="Skelta.Repository.Security" %>
<script runat=server>
    Workflow.NET.Web.Report.WorkflowExecutionReport _BaseControl;
    string PageTitle = "";
    protected string cssPath;
    
    BAMSecurity bamsecurity;
    string strUserId;
    bool SecurityFlag;
    string[] execuitonwindow;
    bool Inclusion;
    bool canViewExceptions = false;
    bool canViewFormsTab= false;
    string actionType = string.Empty;
    override protected void OnLoad(EventArgs e)
    {
        base.OnLoad(e);
        System.Threading.Thread.CurrentThread.CurrentUICulture = new System.Globalization.CultureInfo(Request["cul"]);
        _BaseControl = new Workflow.NET.Web.Report.WorkflowExecutionReport(Request["suri"]);
        actionType = ((Workflow.NET.Report.Action)_BaseControl.WorkflowExecutionDetails.Actions[Request["edid"]]).ActionType;
        object relativePath=Workflow.NET.TemplateExpressionBuilder.GetUrl("");
        cssPath = relativePath.ToString();               
              
        
        RadTab stepdetails = RadTabStrip1.FindTabByValue("step");
        RadTab variables = RadTabStrip1.FindTabByValue("variable");
        RadTab contents = RadTabStrip1.FindTabByValue("contents");
        RadTab content = RadTabStrip1.FindTabByValue("content");
        canViewExceptions = CanShowExceptionTab();
        canViewFormsTab = CanShowFormTab();
              
        RadTab viewExceptions = RadTabStrip1.FindTabByValue("exceptions");
        if (canViewExceptions)
            viewExceptions.Visible = true;
        else
            viewExceptions.Visible = false;
            
        RadTab submittedformsTab = RadTabStrip1.FindTabByValue("submittedforms");
        submittedformsTab.Visible = false;
        
        stepdetails.Text = _BaseControl.GlobalResourceSet.GetString("ExecutionDetailsWindow_StepDetails").Trim();
        variables.Text = _BaseControl.GlobalResourceSet.GetString("ExectuionDetailsWindow_Variables").Trim();
        contents.Text = _BaseControl.GlobalResourceSet.GetString("ExecutionDetailsWindow_Contents").Trim();
        content.Text = _BaseControl.GlobalResourceSet.GetString("ExecutionDetailsWindow_Content").Trim();
        viewExceptions.Text = _BaseControl.GlobalResourceSet.GetString("ecm_list_cm_viewExceptions").Trim();
        submittedformsTab.Text = _BaseControl.GlobalResourceSet.GetString("ExecutionDetailsWindow_SubmittedFormDetails").Trim();
        
        Skelta.FarmManager.Repository repository = new Skelta.FarmManager.Repository(_BaseControl.Application);
        SecurityFlag = Convert.ToBoolean(repository.Properties["enablesecurity"]);
        if(SecurityFlag)//securityflag true start
        {
            if(!string.IsNullOrEmpty(_BaseControl.WorkflowExecutionDetails.UserIdWithProvider))
                strUserId = _BaseControl.WorkflowExecutionDetails.UserIdWithProvider;
            else
                strUserId = _BaseControl.UserIdWithProvider;
            if(string.IsNullOrEmpty(strUserId)) //struserid null
            {
               Workflow.NET.Log logger = new Workflow.NET.Log();
               logger.LogInformation("Could Not Retrive User information in Proces Execution View,Hence Security Can not be applied");
               logger.Close();
            }
            else //struserid not null
            {
               bamsecurity = new BAMSecurity(_BaseControl.Application, strUserId, _BaseControl.WorkflowExecutionDetails.WorkflowName.ToString());  
               execuitonwindow = bamsecurity.ExecutionWindow;
               Inclusion = bamsecurity.IsForInclusion;   
               if(Inclusion)
               {
                    stepdetails.Visible=false;
                    variables.Visible=false;
                    contents.Visible=false;
                    content.Visible=false;
                    submittedformsTab.Visible = false;
               }
               else
               {
                    stepdetails.Visible=true;
                    variables.Visible=true;
                    contents.Visible=true;
                    content.Visible=true;
                    if (canViewFormsTab)
                         submittedformsTab.Visible = true;

               }
               bamsecurity=null;
               if(execuitonwindow!=null)//executionwindow not null
               {
                    
                    for(int i=0;i< execuitonwindow.Length;i++)
                    {
                        if(execuitonwindow[i]!="")
                        {
                            if(Inclusion)
                            {
                                if(execuitonwindow[i]== "Step Details") 
                                    stepdetails.Visible=true;
                                else if(execuitonwindow[i]== "Variables") 
                                    variables.Visible=true;
                                else if(execuitonwindow[i]=="Contents")
                                    contents.Visible=true;
                                else if(execuitonwindow[i]== "Content")
                                    content.Visible=true;
                                else if(execuitonwindow[i]== "Form")
                                {
                                    if (canViewFormsTab)
                                        submittedformsTab.Visible = true;
                                }
                            }
                            else
                            {
                                if(execuitonwindow[i]== "Step Details") 
                                    stepdetails.Visible=false;
                                else if(execuitonwindow[i]== "Variables") 
                                    variables.Visible=false;
                                else if(execuitonwindow[i]== "Contents")
                                    contents.Visible=false;
                                else if(execuitonwindow[i]== "Content")
                                    content.Visible=false;
                                else if(execuitonwindow[i]== "Form")
                                    submittedformsTab.Visible=false;
                            }
                        }//execuitonwindow[i] not null end
                    }//for loop end
               }
               else //executionwindow null
               {
                    if(Inclusion)
                    {
                        stepdetails.Visible=false;
                        variables.Visible=false;
                        contents.Visible=false;
                        content.Visible=false;
                        submittedformsTab.Visible = false;                       
                        
                    }
                    else
                    {
                        stepdetails.Visible=true;
                        variables.Visible=true;
                        contents.Visible=true;
                        content.Visible=true;
                        if (canViewFormsTab)
                            submittedformsTab.Visible = true;
                    }
               
               } //executionwindow null end
               
            }//struserid not null end
             
        }//securityflag true end
        else //SecurityFlag flase start
        {
            stepdetails.Visible=true;
            variables.Visible=true;
            contents.Visible=true;
            content.Visible=true;
            if (canViewFormsTab)
                submittedformsTab.Visible = true;

            
        }//SecurityFlag flase start
        
       
        
        if(stepdetails.Visible==false && variables.Visible==false && contents.Visible==false &&  content.Visible==false && submittedformsTab.Visible==false)
           RadTabStrip1.Visible=false;
        
        if(stepdetails.Visible==false)
           RadTabStrip1.Tabs.Remove(stepdetails);
        if(variables.Visible==false)
           RadTabStrip1.Tabs.Remove(variables); 
        if(contents.Visible==false)
           RadTabStrip1.Tabs.Remove(contents);
        if(content.Visible==false)
           RadTabStrip1.Tabs.Remove(content);
        if(submittedformsTab.Visible==false)
           RadTabStrip1.Tabs.Remove(submittedformsTab);
           
        if(_BaseControl.OnlyAnalystsView)
        {
            if(RadTabStrip1.Tabs.Contains(variables))
                RadTabStrip1.Tabs.Remove(variables);
            if(RadTabStrip1.Tabs.Contains(contents))
                RadTabStrip1.Tabs.Remove(contents);
            if(RadTabStrip1.Tabs.Contains(content))
                RadTabStrip1.Tabs.Remove(content);
            if(RadTabStrip1.Tabs.Contains(viewExceptions))
                RadTabStrip1.Tabs.Remove(viewExceptions);
            if(RadTabStrip1.Tabs.Contains(submittedformsTab))
                RadTabStrip1.Tabs.Remove(submittedformsTab);
        }
        
        if(stepdetails.Visible==true)
            Page.ClientScript.RegisterStartupScript(GetType(), "", "ShowDetails();", true); 
        else if(variables.Visible==true)
            Page.ClientScript.RegisterStartupScript(GetType(), "", "ShowVariables('variables');", true); 
        else if(contents.Visible==true)
            Page.ClientScript.RegisterStartupScript(GetType(), "", "ShowVariables('contents');", true);
        else if(content.Visible==true)
            Page.ClientScript.RegisterStartupScript(GetType(), "", "ShowVariables('content');", true);
        else if(submittedformsTab.Visible==true)
            Page.ClientScript.RegisterStartupScript(GetType(), "", "ShowFormDetails('"+actionType+"');", true);
       
        PageTitle = _BaseControl.GlobalResourceSet.GetString("Details for Step") + " " + ((Workflow.NET.Report.Action)_BaseControl.WorkflowExecutionDetails.Actions[Request["edid"]]).Name + " - " + _BaseControl.WorkflowExecutionDetails.WorkflowName;
      
    }

    bool CanShowExceptionTab()
    {
        if (_BaseControl.WorkflowExecutionDetails.InternalStatus.Equals("FE", StringComparison.OrdinalIgnoreCase))
        {
            string edid = Request["edid"];
            int executionDetailsId;
            if (Int32.TryParse(edid, out executionDetailsId))
            {
                Skelta.Core.PersistedExceptionCollection exceptionColl = new Skelta.Core.PersistedExceptionCollection(new Skelta.Core.ApplicationObject(_BaseControl.Application),_BaseControl.WorkflowExecutionDetails.ExecutionId,executionDetailsId);
                if (exceptionColl.GetRecords().Tables[0].Rows.Count > 0)
                    return true;
                else
                    return false;
            }
            else
                return false;
            
        }
        else
            return false;
    }
    bool CanShowFormTab()
    {
    
        if(actionType=="Start" )
        {
            string edid = Request["edid"];
            int executionDetailsId;
            System.Collections.Generic.Dictionary<string,object> variables;
            System.Collections.Generic.Dictionary<string,string> contents;
            string content;
            bool sfFormDataAvailable = false;
            bool wfInitiatedByForm = false;
            if (Int32.TryParse(edid, out executionDetailsId))
            {
            _BaseControl.WorkflowExecutionDetails.LoadVariablesAndContents(executionDetailsId,out variables,out contents,out content);
            foreach(string varName in variables.Keys)
            {
                if(varName== "SKEventData")
                {
                    if(variables[varName] != null)
                    {
                        Skelta.Events.SKEventData eventData = new Skelta.Events.SKEventData();
                        eventData = eventData.Deserialize(variables[varName].ToString());
                        if((eventData.EventType == "OnInitiateForm" || eventData.EventType == "OnTestRun") && (eventData.EventProvider == "Form" || eventData.EventProvider == "Mobile"))
                        {
                            wfInitiatedByForm = true;
                            //foreach(Skelta.Events.SKEventData.Property eventProperty in eventData.EventProperties)
                              //  Response.Write(eventProperty.Key +" = "+ eventProperty.Value);
                        }
                    }
                }
                if(varName== "SFFormData")
                {
                    if(variables[varName]!=null)
                        if(!string.IsNullOrEmpty(variables[varName].ToString()))
                             sfFormDataAvailable = true;
                }
            }
            
            if(sfFormDataAvailable && wfInitiatedByForm)
                return true;
            }
        }
        else if(actionType=="Invoke Form" )
             return true;
        
        return false;
        
    }
    private void Load()
    {
       
        RadTabStrip1.FindTabByValue("variable").Text = _BaseControl.GlobalResourceSet.GetString("ExectuionDetailsWindow_Variables");
        RadTabStrip1.FindTabByValue("contents").Text = _BaseControl.GlobalResourceSet.GetString("ExecutionDetailsWindow_Contents");
        RadTabStrip1.FindTabByValue("content").Text = _BaseControl.GlobalResourceSet.GetString("ExecutionDetailsWindow_Content");
        RadTabStrip1.FindTabByValue("step").Text = _BaseControl.GlobalResourceSet.GetString("ExecutionDetailsWindow_StepDetails");
        RadTabStrip1.FindTabByValue("submittedforms").Text = _BaseControl.GlobalResourceSet.GetString("ExecutionDetailsWindow_SubmittedFormDetails");
        
        if (_BaseControl.OnlyAnalystsView)
        {
            RadTab variabletab = RadTabStrip1.FindTabByValue("variable");
            RadTabStrip1.Tabs.Remove(variabletab);
            RadTab contenttab = RadTabStrip1.FindTabByValue("content");
            RadTabStrip1.Tabs.Remove(contenttab);
            RadTab contentstab = RadTabStrip1.FindTabByValue("contents");
            RadTabStrip1.Tabs.Remove(contentstab);
            RadTab viewExceptions = RadTabStrip1.FindTabByValue("exceptions");
            RadTabStrip1.Tabs.Remove(viewExceptions);
            RadTab formstab = RadTabStrip1.FindTabByValue("submittedforms");
            RadTabStrip1.Tabs.Remove(formstab);
        }

        PageTitle = _BaseControl.GlobalResourceSet.GetString("Details for Step") + " " + ((Workflow.NET.Report.Action)_BaseControl.WorkflowExecutionDetails.Actions[Request["edid"]]).Name + " - " + _BaseControl.WorkflowExecutionDetails.WorkflowName;
    }
    

</script>
<html>
<head runat="server">
    <title><%=PageTitle%></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    
    <script>
        window.onresize=Resize;
        
        function Resize()
        {
        
            var w=document.body.clientWidth;
            var h=document.body.clientHeight;
            var tabheight=35;
            var frame = document.getElementById('frame1');
            frame.style.position="absolute";
            frame.style.left=0;
            frame.style.top=0;
            frame.style.width = w;
            frame.style.height = h-tabheight;
            
            
                
            var tabstrip = document.getElementById('tabstrip1');
            tabstrip.style.position="absolute";
            tabstrip.style.left = 0;
            //tabstrip.style.top = 50;
            tabstrip.style.top= 35;
            //tabstrip.style.width = w;
            //tabstrip.style.height = h;
            
        }
        
        function ProcessTabClick(sender, eventArgs)
        {
            var tab = eventArgs.get_tab();
            var tabValue = tab.get_value();
            
            if (tabValue=="step" ) ShowDetails();
            if( tabValue=="variable") ShowVariables("variables");
            if( tabValue=="contents") ShowVariables("contents");
            if( tabValue=="content") ShowVariables("content");
            if( tabValue=="exceptions") ShowExceptions();
            if( tabValue=="submittedforms") ShowFormDetails();
        }
        
        function ShowDetails()
        {
            var l=window.location.toString();
             l=l.replace("executiondetailswindow.aspx","executiondetails.aspx"); 
             document.getElementById('framecontent').src = l;
        }
    
        function ShowVariables(displayMode)
        {
            var l=window.location.toString();
             l=l.replace("executiondetailswindow.aspx","ShowVariablesAndContents.aspx"); 
             l+="&dm="+displayMode;
             document.getElementById('framecontent').src = l;
        
        }
        
    
        
    </script>
</head>
<body onload="Resize();" style="border-style: none;overflow:-moz-scrollbars-none;overflow:hidden;" >
    <form id="form1" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
        <link rel="stylesheet" type="text/css" href="<%=_BaseControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTTabStrip/TabStrip.AWTTabStrip.css")%>">
    
    <%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <table height="100%" width="100%">
        <tr>
            <td width="100%" height="90%"> 
                 <div id='frame1'>
                <iframe  id='framecontent' style="width: 100%; height: 100%; border-style: none;" src="blank.htm"></iframe>

                </div>
            </td>
        </tr>
         <tr>
            <td width="100%" height="10%">
                <div id='tabstrip1' style="width: 100%;background-color:white;">
                 <telerik:RadTabStrip ID="RadTabStrip1" EnableEmbeddedSkins="false" SelectedIndex="0"  runat="server" Width="100%"   Skin="AWTTabStrip" RenderMode="Classic" Orientation="HorizontalBottom" 	OnClientTabSelected="ProcessTabClick" >
                    <Tabs>
                        <telerik:RadTab runat="server" Text="Step Details" Value="step">
                        </telerik:RadTab>
                        <telerik:RadTab runat="server" Text="Variables" Value="variable">
                        </telerik:RadTab>
                        <telerik:RadTab runat="server" Text="Contents" Value="contents">
                        </telerik:RadTab>
                        <telerik:RadTab runat="server" Text="Content" Value="content">
                        </telerik:RadTab>
                         <telerik:RadTab runat="server" Text="Content" Value="exceptions">
                        </telerik:RadTab>
                        <telerik:RadTab runat="server" Text="Form" Value="submittedforms">
                        </telerik:RadTab>
                    </Tabs>
        </telerik:RadTabStrip>
        </div>
             </td>
        </tr>
    </table>
    </form>
</body>
</html>

<script type="text/javascript" language="javascript">
        function ShowFormDetails()
        {
             var l=window.location.toString();
             l=l.replace("executiondetailswindow.aspx","ShowFormDetails.aspx"); 
             document.getElementById('framecontent').src = l;
        }
        function ShowExceptions()
        {
            //debugger;
            var executionDetailsid = '<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(Request["edid"], false)%>';
            var executionId = "<%=_BaseControl.ExecutionId %>";
            var actionType = "<%=((Workflow.NET.Report.Action)_BaseControl.WorkflowExecutionDetails.Actions[Request["edid"]]).ActionType%>";
            var application = "<%=_BaseControl.Application%>";
            var wf = "<%=_BaseControl.WorkflowExecutionDetails.WorkflowName%>";
            var path = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_BaseControl.TemplateDirectory, false)%>";
            // If it is a start action then show the report specific to that instance else show the details report of the action
            var frameObj = document.getElementById('framecontent');
//            frameObj.style.height="250px";
//            frameObj.style.width="550px";
            var queryStr = "?h=170&w=85&wf="+escape(wf);
            if(actionType == "Start")
            {
                 queryStr += "&application="+escape(application)+"&executionId="+executionId+"&eview=true";
                 path += "Repository/Site/ShowExceptionReports.aspx"+queryStr;
                 frameObj.src = path;
            }
            else
            {
                queryStr += "&application="+escape(application)+"&edid="+executionDetailsid+"&edetview=true&executionId="+executionId;
                 path += "Repository/Site/ShowExceptionReports.aspx"+queryStr;
                 frameObj.src = path;
            }
        }

</script>
