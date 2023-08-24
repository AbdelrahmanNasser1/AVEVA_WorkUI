<%@ Assembly Name="Workflow.NET.Web.Report.NET2" %>
<%@ Import Namespace="Workflow.NET.Web.Report" %>
<%@ Import Namespace="Workflow.NET.Report" %>
<%@ Import Namespace="Skelta.Repository.Security" %>
<%@ Import Namespace="Skelta.Entity" %>
<%@ Page Language="C#" AutoEventWireup="false" Debug="false" Inherits="Workflow.NET.CodeBehind.ProcessExecutionView.ExecutionView" Theme="" StylesheetTheme="" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<link href="<%=_BaseControl.GetThemeRelativeUrl("Common/StyleSheet/Global.css")%>" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="<%=_BaseControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTTabStrip/TabStrip.AWTTabStrip.css")%>">
<link rel="stylesheet" type="text/css" href="<%=_BaseControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTToolBar/ToolBar.AWTToolBar.css")%>">


<script runat="server">
    
    WorkflowExecutionReport _BaseControl;
    Workflow.NET.SkeltaResourceSet GR=null;    
    BAMSecurity bamsecurity;
    string strUserId;
    bool SecurityFlag;
    protected string cssPath;
    protected string bellyBarPath;
    string strView = "";
    bool canViewExceptions = false;
    string[] views;
    override protected void OnLoad(EventArgs e)
    {        
        
        object relativePath = Workflow.NET.TemplateExpressionBuilder.GetUrl("");
        cssPath = relativePath.ToString();
        bellyBarPath = Workflow.NET.CommonFunctions.GetJSReferencePath();
        
        base.OnLoad(e);
        _BaseControl = ((WorkflowExecutionReport)this.Context.Items["__Skelta_Control_Transfer_From"]);
        canViewExceptions = CanShowExceptionTab();
        
        GR = _BaseControl.GlobalResourceSet;
        
        
        RadTab eview = RadTabStrip1.FindTabByValue("tab1");
        RadTab pview = RadTabStrip1.FindTabByValue("tab2");
        RadTab aview = RadTabStrip1.FindTabByValue("tab3");
        RadTab viewExp = RadTabStrip1.FindTabByValue("tab4");
        if (canViewExceptions)
            viewExp.Visible = true;
        else
            viewExp.Visible = false;
       
        eview.Text = GR.GetString("Execution View").Trim();
        pview.Text = GR.GetString("Progress View").Trim();
        aview.Text = GR.GetString("Analysts View").Trim();

        viewExp.Text = GR.GetString("ecm_list_cm_viewExceptions");
              
        Skelta.FarmManager.Repository repository = new Skelta.FarmManager.Repository(_BaseControl.Application);
        SecurityFlag = Convert.ToBoolean(repository.Properties["enablesecurity"]);
            if (SecurityFlag)
            {
                if(!string.IsNullOrEmpty(_BaseControl.WorkflowExecutionDetails.UserIdWithProvider))
                     strUserId = _BaseControl.WorkflowExecutionDetails.UserIdWithProvider;
                else
                     strUserId = _BaseControl.UserIdWithProvider;
                     
               if (string.IsNullOrEmpty(strUserId))
                {
                    Workflow.NET.Log logger = new Workflow.NET.Log();
                    logger.LogInformation("Could Not Retrive User information in Proces Execution View,Hence Security Can not be applied");
                    logger.Close();
                }
                else
                { 
                // To avoid the URL Spoofing we need to pass the User Context because the  _BaseControl.UserIdWithProvider will be the user id of the first logged in usertaking from LCSURI
                // after confirming with Hemanth.
                Skelta.Entity.UserContext userContext=new Skelta.Entity.UserContext();
                strUserId = userContext.LoggedInUserId;
                bamsecurity = new BAMSecurity(_BaseControl.Application, strUserId, _BaseControl.WorkflowExecutionDetails.WorkflowName.ToString());
                views = bamsecurity.Views;
                bool Inclusion = bamsecurity.IsForInclusion;
                if(Inclusion)
                {
                    aview.Visible = false;
                    pview.Visible = false;
                    eview.Visible = false;
                    
                }
                else
                {
                    aview.Visible = true;
                    pview.Visible = true;
                    eview.Visible = true;
                    
                }
                bamsecurity=null;
                string strtemp = "";
                if(GR.GetString("Analysts View").Trim().IndexOf("'")>0)
                {
                    strtemp = GR.GetString("Analysts View").Trim().Replace("'", "");
                }
                else
                {
                    strtemp = GR.GetString("Analysts View").Trim();
                }
                if(views!=null)
                {
                    for (int i = 0; i < views.Length; i++)
                    {
                        if (views[i] != "")
                        {
                            if(Inclusion)
                            {
                                if(views[i]=="Analysts View") 
                                {
                                    aview.Visible = true;
                                }
                                else if (views[i] == "Progress View") 
                                {
                                    pview.Visible = true;
                                }
                                 else if(views[i] =="Execution View") 
                                {
                                    eview.Visible = true;
                                }
                            }
                            else
                            {
                                if (views[i] == "Analysts View") 
                                {
                                    aview.Visible = false;
                                }
                                 else if (views[i] == "Progress View") 
                                {
                                    pview.Visible = false;
                                }
                                 else if(views[i] == "Execution View") 
                                {
                                    eview.Visible = false;
                                }
                            
                            }
            
                        }
                    }
                                  }
                else
                {
                    if(Inclusion)
                    {
                        aview.Visible = false;
                        pview.Visible = false;
                        eview.Visible = false;
                        
                        strView="0";
                    }
                    else
                    {
                        aview.Visible = true;
                        pview.Visible = true;
                        eview.Visible = true;
                        
                    }
                }
                }
 
            }
            else
            {
                aview.Visible = true;
                pview.Visible = true;
                eview.Visible = true;
                
            }
            if(aview.Visible==false && pview.Visible==false && eview.Visible==false)
                strView="0";
        
        if(aview.Visible==false)
            RadTabStrip1.Tabs.Remove(aview);
        if(pview.Visible==false)
            RadTabStrip1.Tabs.Remove(pview);
        if(eview.Visible==false)
            RadTabStrip1.Tabs.Remove(eview);
        if (viewExp.Visible == false)
            RadTabStrip1.Tabs.Remove(viewExp);
        
        if (_BaseControl.OnlyAnalystsView)
        {
            if (RadTabStrip1.Tabs.Contains(eview))
                RadTabStrip1.Tabs.Remove(eview);

            if (RadTabStrip1.Tabs.Contains(pview))
                RadTabStrip1.Tabs.Remove(pview);
            if (viewExp != null)
            {
                if (RadTabStrip1.Tabs.Contains(viewExp))
                    RadTabStrip1.Tabs.Remove(viewExp);
            }
        }

        <%--commented for #445113--%>
        <%--int view = (int)_BaseControl.DefaultView;
        
        int index = 0;

        if (view == 1)
            index = 2;
        else if (view == 2)
            index = 1;
        
        RadTabStrip1.SelectedIndex = index; 
        if( index == 0)//aview.Visible == true
        {
            //RadTabStrip1.SelectedIndex = 0; 
           _BaseControl.DefaultView = WorkflowExecutionReportTypes.AnalystsView;
        }
        else if(index == 1)//pview.Visible == true
        {
           // RadTabStrip1.SelectedIndex = 1;
           _BaseControl.DefaultView = WorkflowExecutionReportTypes.ProgressView;
        }
        else if(index==2)//eview.Visible == true
        {
           // RadTabStrip1.SelectedIndex = 2;
           _BaseControl.DefaultView = WorkflowExecutionReportTypes.ExecutionView;
        }--%>
    if(views!=null){
        if(Array.IndexOf(views, "Analysts View") > -1){
            _BaseControl.DefaultView = WorkflowExecutionReportTypes.AnalystsView;
        }
        else if(Array.IndexOf(views, "Progress View") > -1){
            _BaseControl.DefaultView = WorkflowExecutionReportTypes.ProgressView;
        }
        else if(Array.IndexOf(views, "Execution View") > -1){
            _BaseControl.DefaultView = WorkflowExecutionReportTypes.ExecutionView;
        }
    }
            
        LoadToolBar();

       
    }

    bool CanShowExceptionTab()
    {
        if (_BaseControl.WorkflowExecutionDetails.InternalStatus.Equals("FE", StringComparison.OrdinalIgnoreCase))
        {
            Skelta.Core.PersistedExceptionCollection exceptionColl = new Skelta.Core.PersistedExceptionCollection(new Skelta.Core.ApplicationObject(_BaseControl.Application), _BaseControl.WorkflowExecutionDetails.ExecutionId);
            if (exceptionColl.GetRecords().Tables[0].Rows.Count > 0)
                return true;
            else
                return false;
        }
        else
            return false;
    }

    private void LoadToolBar()
    {         
    
        RadToolBarButton button_fullscreen = new RadToolBarButton();
        button_fullscreen.ID = "tbFullScreen";
        button_fullscreen.Text = string.Empty;
        button_fullscreen.CheckOnClick = true;
        button_fullscreen.AllowSelfUnCheck = true;
        button_fullscreen.Checked = false;
        button_fullscreen.ImageUrl = _BaseControl.GetThemeRelativeUrl("ProcessExecutionView/toolbar/Graphics/img/fullscreen.png");
        button_fullscreen.ToolTip = GR.GetString("Full Screen");
        button_fullscreen.Attributes.Add("onclick", "javascript:click_handler('fullscreen');");
        
        RadToolBarButton radZoom = new RadToolBarButton();
        radZoom.CommandName = "zoom";        
        Workflow.NET.CodeBehind.ProcessExecutionView.ExecutionView executionView = new Workflow.NET.CodeBehind.ProcessExecutionView.ExecutionView();
        executionView.InstantiateIn(radZoom);
        
        
        RadToolBarButton separator1 = new RadToolBarButton();
        separator1.IsSeparator = true;

        RadToolBarButton separator2 = new RadToolBarButton();
        separator2.IsSeparator = true;

        RadToolBarButton separator3 = new RadToolBarButton();
        separator3.IsSeparator = true;

        RadToolBarButton separator4 = new RadToolBarButton();
        separator4.IsSeparator = true;
        
        RadToolBarButton button_refresh = new RadToolBarButton();
        button_refresh.Text = string.Empty;
        button_refresh.CommandName = "refresh";
        button_refresh.ImageUrl = _BaseControl.GetThemeRelativeUrl("ProcessExecutionView/toolbar/Graphics/img/refresh.png");
        button_refresh.ID = "tbrefresh";
        button_refresh.ToolTip = GR.GetString("Refresh");
        button_refresh.Attributes.Add("onclick", "javascript:click_handler('refresh');");

        RadToolBarButton button_help = new RadToolBarButton();
        button_help.Text = string.Empty;
        button_help.CommandName = "help";
        button_help.ImageUrl = _BaseControl.GetThemeRelativeUrl("ProcessExecutionView/toolbar/Graphics/img/help.png");
        button_help.ID = "tbHelp";
        button_help.ToolTip = GR.GetString("Help");
        button_help.Attributes.Add("onclick", "javascript:click_handler('help');");
    
        RadToolBarButton button_play = new RadToolBarButton();
        button_play.Text = string.Empty;
        button_play.CommandName = "play";
        button_play.ImageUrl = _BaseControl.GetThemeRelativeUrl("ProcessExecutionView/toolbar/Graphics/img/play.png");
        button_play.ID = "tbplay";
        button_play.ToolTip = GR.GetString("Resume paused workflow");
        button_play.Attributes.Add("onclick", "javascript:click_handler('play');");

        RadToolBarButton button_stop = new RadToolBarButton();
        button_stop.Text = string.Empty;
        button_stop.CommandName = "stop";
        button_stop.ImageUrl = _BaseControl.GetThemeRelativeUrl("ProcessExecutionView/toolbar/Graphics/img/stop.png");
        button_stop.ID = "tbstop";
        button_stop.ToolTip = GR.GetString("Abort executing workflow");
        button_stop.Attributes.Add("onclick", "javascript:click_handler('stop');");
        
        RadToolBarButton button_pause = new RadToolBarButton();
        button_pause.Text = string.Empty;
        button_pause.CommandName = "pause";
        button_pause.ImageUrl = _BaseControl.GetThemeRelativeUrl("ProcessExecutionView/toolbar/Graphics/img/pause.png");
        button_pause.ID = "tbpause";
        button_pause.ToolTip = GR.GetString("Pause executing workflow");
        button_pause.Attributes.Add("onclick", "javascript:click_handler('pause');");

        RadToolBarButton button_rerror = new RadToolBarButton();
        button_rerror.Text = string.Empty;
        button_rerror.CommandName = "rerror";
        button_rerror.ImageUrl = _BaseControl.GetThemeRelativeUrl("ProcessExecutionView/toolbar/Graphics/img/resume-with-error.png");
        button_rerror.ID = "tbrerror";
        button_rerror.ToolTip = GR.GetString("Resume workflow finished with errors");
        button_rerror.Attributes.Add("onclick", "javascript:click_handler('rerror');");
          
   
        toolbar.Items.Add(button_fullscreen);
        toolbar.Items.Add(separator1);
        toolbar.Items.Add(radZoom);
        toolbar.Items.Add(separator2);
        toolbar.Items.Add(button_refresh);
        toolbar.Items.Add(separator3);
        
        _BaseControl = ((WorkflowExecutionReport)this.Context.Items["__Skelta_Control_Transfer_From"]);      
        if (_BaseControl.CanControlWorkflow != false && _BaseControl.IsQuickflow == false)
        {
            toolbar.Items.Add(button_play);
            toolbar.Items.Add(button_stop);
            toolbar.Items.Add(button_pause);
            toolbar.Items.Add(button_rerror);
            toolbar.Items.Add(separator4);
        }

        if (_BaseControl.CanControlWorkflow) //true added for testing.
        {            
         if (SecurityFlag)
         {
           if (string.IsNullOrEmpty(strUserId))
            {
                    Workflow.NET.Log logger = new Workflow.NET.Log();
                    logger.LogInformation("Could Not Retrive User information in Proces Execution View,Hence Security Can not be applied For BAM Control Actions");
                    logger.Close();
                
            }
            else
            {
                bamsecurity = new BAMSecurity(_BaseControl.Application, strUserId, _BaseControl.WorkflowExecutionDetails.WorkflowName.ToString());
                string[] Actions = bamsecurity.Actions;
                bool Inclusion = bamsecurity.IsForInclusion;
                if (Inclusion)
                {
                    button_play.Visible = false;
                    button_stop.Visible = false;
                    button_pause.Visible = false;
                    button_rerror.Visible = false;
                }
                else
                {
                    button_play.Visible = true;
                    button_stop.Visible = true;
                    button_pause.Visible = true;
                    button_rerror.Visible = true;
                } 
            if(Actions!=null)
            {
                
                for (int i = 0; i < Actions.Length; i++)
                {
                    if(Actions[i]!="")
                    {
                        if(Inclusion)
                        {
                            if(Actions[i]== "Play") 
                              button_play.Visible=true; 
                            else if(Actions[i]== "Kill") 
                                button_stop.Visible=true; 
                            else if(Actions[i]== "Pause") 
                                button_pause.Visible=true; 
                            else if(Actions[i]== "Resume") 
                                button_rerror.Visible=true; 
                        }
                        else
                        {
                            if(Actions[i]== "Play") 
                                button_play.Visible=false; 
                            else if(Actions[i]== "Kill") 
                                button_stop.Visible=false; 
                            else if(Actions[i]== "Pause") 
                                button_pause.Visible=false; 
                            else if(Actions[i]== "Resume") 
                                button_rerror.Visible=false; 
                        }
                   
                    }
                }
             }
             else
             {
                 if (Inclusion)
                 {
                     button_play.Visible = false;
                     button_stop.Visible = false;
                     button_pause.Visible = false;
                     button_rerror.Visible = false; 
                 }
                 else
                 {
                     button_play.Visible = true;
                     button_stop.Visible = true;
                     button_pause.Visible = true;
                     button_rerror.Visible = true; 
                 }
               
             }
           }
         }  
        }
        toolbar.Items.Add(button_help);
    }

</script>

<!DOCTYPE HTML>
<html>
<head>
    <title></title>
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
    <meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
    <style type="text/css">

    </style>
    <script>
			var ImagesLocation="<%=_BaseControl.GetThemeRelativeUrl("ProcessExecutionView/Graphics/")%>";			
			var PDControlID = "<%=_BaseControl.ID%>";
			var TemplateRoot = "<%=_BaseControl.TemplateDirectory%>";
			var TemplatePD =  TemplateRoot+"ProcessDesigner/";
			var _skApplicationName = "<%=_BaseControl.Application%>";
			var _skUICulture = "<%=System.Threading.Thread.CurrentThread.CurrentUICulture.Name%>";
			var _skLoadedReport="<%=((int)_BaseControl.DefaultView).ToString().Trim() %>";
			var _strView ="<%= strView.ToString() %>";
			var _skZoom="100";
			var _skExecutionID = <%=_BaseControl.ExecutionId %>;
			var _skCanControl = <%= _BaseControl.CanControlWorkflow.ToString().ToLower() %>;
			
			function LoadDefaultReport()
            {
                var toolBar = $find("<%= toolbar.ClientID %>");
                var item = toolBar.findButtonByCommandName("zoom");
                var rptZoomElement = $telerik.findElement(item.get_element(), ("rptzoom")); 
                rptZoomElement.onchange = changeZoom;
                ReloadReport(); 
			    SetControlButtonsState("<%=_BaseControl.WorkflowExecutionDetails.InternalStatus %>");		   			  
			}
			
			function ReloadReport()
			{
			   if(_strView!="0")
			      LoadReport(_skLoadedReport);
			}
			
			function changeZoom()
            {
                var toolBar = $find("<%= toolbar.ClientID %>");
                var item = toolBar.findButtonByCommandName("zoom");
                var rptZoomElement = $telerik.findElement(item.get_element(), ("rptzoom")); 
                _skZoom = rptZoomElement.value;			   
			    ReloadReport();
			}
			
        function isIE11()
        {
            return !!navigator.userAgent.match(/Trident.*rv[ :]*11\./);
        }
			
			function SetControlButtonsState(status)
			{
			    if( !_skCanControl ) 
			    {
			        return;
			    }
                
                var radToolbar1 = $find("<%= toolbar.ClientID %>");
                var buttonplay = radToolbar1.findButtonByCommandName("play");
                var buttonstop = radToolbar1.findButtonByCommandName("stop");
                var buttonpause = radToolbar1.findButtonByCommandName("pause");
                var buttonerror = radToolbar1.findButtonByCommandName("rerror");
                
          	    		    
			    switch(status)
			    {
			        case "EP": 
                        if (buttonplay != null && buttonplay.get_visible()==true)
			                EnableDisableButton("play",false);
                        if (buttonstop != null && buttonstop.get_visible() == true)
			                EnableDisableButton("stop",false);
                        if (buttonpause != null && buttonpause.get_visible() == true)
			                EnableDisableButton("pause",false);
                        if (buttonerror != null && buttonerror.get_visible() == true)
			                EnableDisableButton("rerror",true);
			            break;
			        case "SL":
			        case "EX": 
                        if (buttonplay != null && buttonplay.get_visible() == true)
			                EnableDisableButton("play",false);
                        if (buttonstop != null && buttonstop.get_visible() == true)
			                EnableDisableButton("stop",true);
                        if (buttonpause != null && buttonpause.get_visible() == true)
			                EnableDisableButton("pause",true);
                        if (buttonerror != null && buttonerror.get_visible() == true)
			                EnableDisableButton("rerror",false);
			                   break;
			        case "FN": 
                        if (buttonplay != null && buttonplay.get_visible() == true)
			                EnableDisableButton("play",false);
                        if (buttonstop != null && buttonstop.get_visible() == true)
			                EnableDisableButton("stop",false);
                        if (buttonpause != null && buttonpause.get_visible() == true)      
			                EnableDisableButton("pause",false);
                        if (buttonerror != null && buttonerror.get_visible() == true)
			                EnableDisableButton("rerror",false);
			                   break;
			        case "FE": 
                        if (buttonplay != null && buttonplay.get_visible() == true)
			                EnableDisableButton("play",false);
                        if (buttonstop != null && buttonstop.get_visible() == true)
			                EnableDisableButton("stop",false);
                        if (buttonpause != null && buttonpause.get_visible() == true)  
			                EnableDisableButton("pause",false);
                        if (buttonerror != null && buttonerror.get_visible() == true)
			                EnableDisableButton("rerror",true);
			                   break;
			        case "AB": 
                        if (buttonplay != null && buttonplay.get_visible() == true)
			                EnableDisableButton("play",false);
                        if (buttonstop != null && buttonstop.get_visible() == true)
			                EnableDisableButton("stop",false);
                        if (buttonpause != null && buttonpause.get_visible() == true)  
			                EnableDisableButton("pause",false);
                        if (buttonerror != null && buttonerror.get_visible() == true)
			                EnableDisableButton("rerror",false);
			                   break;
			        case "PA": 
                        if (buttonplay != null && buttonplay.get_visible() == true)
    			            EnableDisableButton("play",true);
                        if (buttonstop != null && buttonstop.get_visible() == true)
			                EnableDisableButton("stop",false);
                        if (buttonpause != null && buttonpause.get_visible() == true) 
			                EnableDisableButton("pause",false);
                        if (buttonerror != null && buttonerror.get_visible() == true)    
			                EnableDisableButton("rerror",false);
			                   break;
			    
			    }
			}
			
    </script>

    <script type="text/javascript" src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(_BaseControl.GetJscriptUrl("javascript/DiagramEVCommon.js"))%>"></script>

    <script type="text/javascript" src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(_BaseControl.GetJscriptUrl("javascript/ExecutionView.js"))%>"></script>

    <script>
        var _skTemplateDir = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_BaseControl.TemplateDirectory, false)%>";
        var MenuButtonClicked=true;
       
       /*This method will set the Menu toggle  button value to true or false*/
        function executecheck(item, state)
        {
            var itemID = "item with ID:"+item.ID + "has the following state:";
            if(item.Container.Cells && item.Container.Cells[0].firstChild)
            {
                var LeftCell = item.Container.Cells[0];
                var LeftCellContent = item.Container.Cells[0].firstChild;
                if(state)
                {
                 var ImagePath = "";
                if (item.ParentMenu.ImagesBaseDir != "")
                {
                    ImagePath = item.ParentMenu.ImagesBaseDir;
                }
                var TmpImage = "";
                if(item.CustomAttributes)
                {
                    TmpImage = item.CustomAttributes[1];
                }
                if (TmpImage != "")
                {
                    ImagePath += TmpImage;
                }
                else
                {
                    return;
                }
                item.Container.BacupChild = LeftCellContent;
                    if(LeftCellContent.nodeType == 3)
                    {
                        LeftCell.removeChild(LeftCellContent);
                        var SelectedImage = new Image();
                        SelectedImage.src = ImagePath;
                        LeftCell.appendChild(SelectedImage);
                    }
                    else if (LeftCellContent.nodeType == 1 && LeftCellContent.src)
                    {
                        LeftCellContent.src = ImagePath;
                   
                    }
                }
                else
                {
                    LeftCell.removeChild(LeftCellContent);
                    LeftCell.appendChild(item.Container.BacupChild);
                }
            }
    
        
    }

  
     
    
    </script>

</head>
<body onload="if (typeof SkInitialize != 'undefined') SkInitialize();Paint();LoadDefaultReport();"
    style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px;
    padding-top: 0px; border-style: none;" scroll="no">
    <link rel="stylesheet" type="text/css" href="<%=cssPath %>CommonUXControls/StyleSheet/se.ui.min.css" />
    <script>
        // Initialize locales for message dialog
        se.ui.messageDialog.setGlobalOptions({
            localization: { // All localization related default can be set
                closeButtonCaption: "<%=GR.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                okButtonCaption: "<%=GR.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                cancelButtonCaption: "<%=GR.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                showDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                hideDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
            }
        });
    </script>
   
    <form id="form1" runat="server" onsubmit="return false;">
         <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
       <asp:Literal ID="MenuHeaderLiteral1" runat="server"></asp:Literal>
        <div id="pd_toolbar" style="height:50px;" class="InboxActionBarCss">
            <div class="InboxActionBarCss">
                <table cellspacing="0" cellpadding="0" border="0">
                    <tr>
                        <td>
                            <div style="width: 100%;">
                               
                                <telerik:RadToolbar ID="toolbar" Skin="AWTToolBar" EnableEmbeddedSkins="false" runat="server">
                                </telerik:RadToolbar>
                            </div>
                        </td>
                        <td>
                            <div id="pd_toolbardetails" style="position: absolute; left: 0px; top: 0 px; visibility: hidden;">
                                <img id="sumStatusImage" src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(_BaseControl.GetThemeRelativeUrl("ProcessExecutionView/Graphics/workflow-"+_BaseControl.WorkflowExecutionDetails.InternalStatus.ToLower().Trim()+".png"))%>"
                                    width="20" height="20" title="<%=_BaseControl.WorkflowExecutionDetails.InternalStatusMessage %>" />
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <br />
        <div id="pd_canvas" class="pdcanvas">
            <iframe id="pd_canvas_frame" style="width: 100%; height: 100%; border-style: none;"
                src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(_BaseControl.GetPageUrl("blank.htm"))%>"></iframe>
        </div>
        <div id="summary" class="pdcanvas">
            <table width="100%" border="0" class="GridHeaderStyle">
                <tr>
                    <td>
                        <table class="description">
                            <tr>
                                <td class="description">
                                    <%=GR.GetString("Started On")%>
                                </td>
                                <td id="sumStartedOn" class="description">
                                    <%= _BaseControl.WorkflowExecutionDetails.StartedOn.ToString("G") %>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <table>
                            <tr>
                                <td class="description">
                                    <%=GR.GetString("Submitted By")%>
                                </td>
                                <td id="sumSubmittedBy" class="description">
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <table class="description">
                            <tr>
                                <td class="description">
                                    <%=GR.GetString("Workflow")%>
                                </td>
                                <td id="sumWorkflowName" class="description">
                                    <%= _BaseControl.WorkflowExecutionDetails.WorkflowName.ToString() %>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="description">
                            <tr>
                                <td id="sumEndedAtTitle" class="description">
                                    <%= (_BaseControl.WorkflowExecutionDetails.ExecutionEndedAt != DateTime.MinValue)?"Ended On":"Last Activity:" %>
                                </td>
                                <td id="sumEndedAt" class="description">
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <table>
                            <tr>
                                <td class="description">
                                    <%=GR.GetString("Status")%>
                                </td>
                                <td id="sumStatus" class="description">
                                    <%=_BaseControl.WorkflowExecutionDetails.StatusMessage %>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <table class="description">
                            <tr>
                                <td class="description">
                                    <%=GR.GetString("Instance Id")%>
                                </td>
                                <td id="sumInstanceId" class="description">
                                    <%= _BaseControl.WorkflowExecutionDetails.ExecutionId.ToString() %>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <table class="description">
                            <tr>
                                <td id="sumLastControlLog" class="description">
                                    <%=_BaseControl.WorkflowExecutionDetails.LastControlPerformedMessage%>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
         <div id='tabstrip1' style="height:20px;width: 100%; background-color: white;position:absolute;">

             <telerik:RadTabStrip ID="RadTabStrip1" EnableEmbeddedSkins="false" SelectedIndex="0"  runat="server" Width="100%"   Skin="AWTTabStrip" RenderMode="Classic" Orientation="HorizontalBottom"  OnClientTabSelected="ProcessTabClick">
                <Tabs>
                <telerik:RadTab ID="Tab1" runat="server" Text="Analysts View"  Value="tab3"  >
                </telerik:RadTab>
                <telerik:RadTab ID="Tab2" runat="server" Text="Progress view" Value="tab2">
                </telerik:RadTab>
                <telerik:RadTab ID="Tab3" runat="server" Text="Execution view" Value="tab1">
                </telerik:RadTab>
                 <telerik:RadTab ID="Tab4"  runat="server" Text="View exceptions" Value="tab4">
                </telerik:RadTab>
                </Tabs>
                </telerik:RadTabStrip> 
        </div>

        <script>
                function ProcessTabClick(sender, eventArgs)
                {   
                    var tab = eventArgs.get_tab();  
                    var tabValue=tab.get_value();
                   
                    if(tabValue != "tab4")
                        LoadReport(tabValue.substr(3,1));
                    else
                        OpenExceptionDetails();    
                }
        
 
                function LoadReport(name)
                {
                    _skLoadedReport = name;
                    
                    var uri="";                    
                    switch(name)
                    {
                        case "3": uri="<%=HttpUtility.UrlEncode(_BaseControl.GetSecuredUriParameter(Workflow.NET.Report.WorkflowExecutionReportTypes.AnalystsView))%>";break;
                        case "2": uri="<%=HttpUtility.UrlEncode(_BaseControl.GetSecuredUriParameter(Workflow.NET.Report.WorkflowExecutionReportTypes.ProgressView))%>";break;
                        case "1": uri="<%=HttpUtility.UrlEncode(_BaseControl.GetSecuredUriParameter(Workflow.NET.Report.WorkflowExecutionReportTypes.ExecutionView))%>";break;
                    }
                    
                        var reportFrame = document.getElementById("pd_canvas_frame");
                        reportFrame.src = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_BaseControl.GetTemplateRelativeUrl("OpenImageMap.aspx"), false)%>?suri="+uri+"&zoom="+escape(_skZoom)+"&cul="+escape(_skUICulture);
                        

                }
                
                function OpenExceptionDetails()
                {
                   
                    var executionId = _skExecutionID;
                    var application = _skApplicationName;
                    var wf = "<%=_BaseControl.WorkflowExecutionDetails.WorkflowName%>";
                    var path = _skTemplateDir;
                    var queryStr = "?application="+escape(application)+"&executionId="+executionId+"&eview=true&h=310&w=85&wf="+escape(wf);
                    path += "Repository/Site/ShowExceptionReports.aspx"+queryStr;
                    var reportFrame = document.getElementById("pd_canvas_frame");
                    reportFrame.style.paddingTop="10px";
//                    reportFrame.style.height="400px";
//                    reportFrame.style.width="700px";
//                    reportFrame.style.verticalAlign = "bottom";
                    //reportFrame.style.overflow="hidden";
                    
                    reportFrame.src = path;
                }

            var IE = (document.all) ? true : false;

		    
            function click_handler(commandName)
            {    
                 var left = (screen.width / 2) - (800 / 2);
                 var top = (screen.height / 2) - (400 / 2);

                 switch(commandName)
                 {
                    case "fullscreen": SwitchToFullScreen();
                                       break;
                    case "refresh": ReloadReport();
                                    break;
                    case "stop": window.open(window.location+"&control=stop",null,"width=10,height=10,resizable=true");
                                 break;
                    case "play": 
                                 window.open(window.location+"&control=start",null,"width=10,height=10,resizable=true");
                                 break;
                    case "pause":
                                 window.open(window.location+"&control=pause",null,"width=10,height=10,resizable=true");
                                 break;
                    case "rerror": window.open(window.location+"&control=resumewfwitherros",null,"width=10,height=10,resizable=true");
                                 break;
                     case "help": window.open("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_BaseControl.GetHelpPageUrl(), false)%>ProcessViews.html",'','height=400,width=800,resizable=yes,status=no,scrollbars=no,top=' + top + ', left=' + left);
                                 break;

                 }            	           
            }            
            

            function EnableDisableButton(tbCmdName,state)
            {
                //Telerik Toolbar instance
                var radToolbar1 = $find("<%= toolbar.ClientID %>");
                var item = radToolbar1.findButtonByCommandName(tbCmdName);
                if (item != null) {
                    item.set_enabled(state);
                }
            }
        </script>
    </form>
</body>
</html>