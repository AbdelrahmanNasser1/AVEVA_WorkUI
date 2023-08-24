<%@ Assembly Name="Workflow.NET.Web.Designer.NET2" %>
<%@ Import Namespace="Workflow.NET.Web.Designer" %>

<%@ Page Language="c#" Inherits="Workflow.NET.Template.PageScript" CodeFile="PDPage.cs" Theme="" StylesheetTheme="" %>

<%@ Register TagPrefix="cc1" Namespace="Workflow.NET.Web.Designer" Assembly="Workflow.NET.Web.Designer.NET2" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<script runat="server">

    Workflow.NET.SkeltaResourceSet GR=null;    
    override protected void OnLoad(EventArgs e)
    {    
        base.OnLoad(e);
        GR = ProcessDesignerControl.GlobalResourceSet;
        pd_toolbox.TemplateName = ProcessDesignerControl.TemplateName;
        string fileSuffix = "";
        if (!Workflow.NET.Config.IsLegacyApplication(ProcessDesignerControl.ApplicationName))
            fileSuffix = "v2";
        string menuxmlfile = Request.MapPath(ProcessDesignerControl.GetTemplateRelativeUrl("")) + (ProcessDesignerControl.CanWriteInStaging ? "menu\\menu" + fileSuffix + ".xml" : "menu\\menureadonly" + fileSuffix + ".xml");
        RadMenu1.LoadXml(Workflow.NET.CommonFunctions.GetLocalizedFileString(menuxmlfile));

        // Ayyub :: Check for Global Security Application Flag
        if (string.IsNullOrEmpty(ProcessDesignerControl.ApplicationName) | string.IsNullOrEmpty(ProcessDesignerControl.UserIdString))
        {
            Workflow.NET.Log logger = new Workflow.NET.Log();
            logger.LogInformation("Application or UserIdString may be null: Security cannot be applied");
            logger.Close();
        }
        else
        {
            Skelta.FarmManager.Repository repository = new Skelta.FarmManager.Repository(ProcessDesignerControl.ApplicationName);

            bool SecurityFlag = Convert.ToBoolean(repository.Properties["enablesecurity"]);
            if (SecurityFlag)
                ApplySecurityForMenu();
        }
        LoadToolBar();
        if (ProcessDesignerControl.CanWriteInStaging)
        {
            if (!ProcessDesignerControl.CanWriteInProduction)
            {
                RemoveMenuItem("deploy");
                RemoveMenuItem("mnuPublish");
            }
            if (!ProcessDesignerControl.CanImportProcessDefinition)
            {
                RemoveMenuItem("mnuImpFrmVisio");
                RemoveMenuItem("import");
            }
           
        }
        if (!ProcessDesignerControl.CanExportProcessDefinition)
        {
            RemoveMenuItem("mnuExport");
        }
        
        if(ProcessDesignerControl.IsQuickflow)
        {            
            RemoveMenuItem("mnuImpFrmVisio");
            RemoveMenuItem("Settings");
        }
        bool isCloudPlatform = ProcessDesignerControl.PlatformType == Skelta.FarmManager.Platform.Azure;
        if(isCloudPlatform)
        {            
            RemoveMenuItem("mnuImpFrmVisio");            
        }
    }

    private void RemoveMenuItem(string itemid)
    {
        Telerik.Web.UI.RadMenuItem mnuItem = RadMenu1.FindItemByValue(itemid);
        // Check whether due to the application of Secrurity the item is available or not
        if(mnuItem != null)
            mnuItem.Owner.Items.Remove(mnuItem);
    }

    private void ApplySecurityForMenu()
    {
        SetMenus();

        for (int i = 0; i < RadMenu1.Items.Count; i++)
        {
            bool hasAnyChildItemIncluded = false;
            if (_IsForInclusion)
            {
                if (_MenuList.Contains(RadMenu1.Items[i].Value))
                {
                    if (RadMenu1.Items[i].Items.Count > 0)
                    {
                        for (int j = 0; j < RadMenu1.Items[i].Items.Count; j++)
                        {
                            if (!_MenuList.Contains(RadMenu1.Items[i].Items[j].Value))
                            {
                                RadMenu1.Items[i].Items.Remove(RadMenu1.Items[i].Items[j]);
                                // When an item gets removed, its count will also get reduced that's why I'm decreasing counters value
                                j--;
                            }
                            //else
                            //    hasAnyChildItemIncluded = true;
                        }
                    }                   
                }
                else
                {
                    RadMenu1.Items.Remove(RadMenu1.Items[i]);
                    // When an item gets removed, its count will also get reduced that's why I'm decreasing counters value
                    i--;
                }

            }
            else
            {
                if (_MenuList.Contains(RadMenu1.Items[i].Value))
                {
                    hasAnyChildItemIncluded = false;
                    for (int j = 0; j < RadMenu1.Items[i].Items.Count; j++)
                    {

                        if (_MenuList.Contains(RadMenu1.Items[i].Items[j].Value))
                        {
                            RadMenu1.Items[i].Items.Remove(RadMenu1.Items[i].Items[j]);
                            // When an item gets removed, its count will also get reduced that's why I'm decreasing counters value
                            j--;
                        } // If it is not a seperator then it should update hasAnyChildItemIncluded to true
                        else if(!RadMenu1.Items[i].Items[j].Value.Equals("mnuSepa1"))
                            hasAnyChildItemIncluded = true;
                    }
                    if (!hasAnyChildItemIncluded)
                    {
                        RadMenu1.Items.Remove(RadMenu1.Items[i]);
                        // When an item gets removed, its count will also get reduced that's why I'm decreasing counters value
                        i--;
                    }
                }
            }

        }
        
    }


    ArrayList _MenuList = new ArrayList();
    bool _IsForInclusion;
    private void SetMenus()
    {
        string securityRightValue = GetSecurityValueForActions();
        if (string.IsNullOrEmpty(securityRightValue))
            return;
        string[] inclusion = securityRightValue.Split(new char[] { '^' });
        if (inclusion[0].Equals("in"))
            _IsForInclusion = true;
        string[] rights = inclusion[1].Split(new char[] { '@' });

        string[] menus = rights[3].Split(new char[] { ',' });
        _MenuList.AddRange(menus);
        
    }

    private string GetSecurityValueForActions()
    {
        try
        {
            Skelta.Repository.List.ListDefinition lstDef = new Skelta.Repository.List.ListDefinition(new Skelta.Core.ApplicationObject(ProcessDesignerControl.ApplicationName), "Workflow");
            Skelta.Repository.List.ListDataHandler ldh = new Skelta.Repository.List.ListDataHandler(ProcessDesignerControl.ApplicationName, "Workflow");
            Guid listItemId = ldh.GetListItemId(ProcessDesignerControl.WorkflowName);
            Skelta.Repository.Security.SecurityManager sm = new Skelta.Repository.Security.SecurityManager(lstDef, ProcessDesignerControl.UserIdString);
            Guid effectiveId = sm.GetEffectiveSecurityGroupId(Skelta.Repository.EntityType.ListItem, listItemId);
            string rightsCode = "ProcessDesignerRights";
            string value = sm.GetValueForRightCode(rightsCode, effectiveId, Skelta.Repository.EntityType.ListItem, listItemId);
            return value;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    HtmlInputText SearchHtmlText;
    private void LoadToolBar()
    {

        Telerik.Web.UI.RadToolBarButton button_undo = new Telerik.Web.UI.RadToolBarButton();
        button_undo.CommandName = "undo";        
        button_undo.ImageUrl = ProcessDesignerControl.GetThemeRelativeUrl("ProcessDesigner/Toolbar/Images/undo.png");
        button_undo.ToolTip = GR.GetString("Undo");
        button_undo.ID = "tbUndo";        
        button_undo.Enabled = false;
        button_undo.Attributes.Add("onclick", "javascript:click_handlerNew('undo');");//firefox 3.0 is not recognizing attachEvent method
        
        Telerik.Web.UI.RadToolBarButton button_redo = new Telerik.Web.UI.RadToolBarButton();
        button_redo.CommandName = "redo";
        button_redo.ImageUrl = ProcessDesignerControl.GetThemeRelativeUrl("ProcessDesigner/Toolbar/Images/redo.png");        
        button_redo.ToolTip = GR.GetString("Redo");
        button_redo.ID = "tbRedo";
        button_redo.Enabled = false;
        button_redo.Attributes.Add("onclick", "javascript:click_handlerNew('redo');");

        Telerik.Web.UI.RadToolBarButton button_properties = new Telerik.Web.UI.RadToolBarButton();
        button_properties.CommandName = "properties";
        button_properties.ImageUrl = ProcessDesignerControl.GetThemeRelativeUrl("ProcessDesigner/Toolbar/Images/properties.png");        
        button_properties.ToolTip = GR.GetString("Properties");
        button_properties.ID = "tbProperties";
        button_properties.Attributes.Add("onclick", "javascript:click_handlerNew('properties');");

        Telerik.Web.UI.RadToolBarButton button_cut = new Telerik.Web.UI.RadToolBarButton();
        button_cut.CommandName = "cut";
        button_cut.ImageUrl = ProcessDesignerControl.GetThemeRelativeUrl("ProcessDesigner/Toolbar/Images/delete.png");        
        button_cut.ToolTip = GR.GetString("Delete");
        button_cut.ID = "tbCut";
        button_cut.Attributes.Add("onclick", "javascript:click_handlerNew('cut');");

        Telerik.Web.UI.RadToolBarButton button_copy = new Telerik.Web.UI.RadToolBarButton();
        button_copy.CommandName = "copy";
        button_copy.ImageUrl = ProcessDesignerControl.GetThemeRelativeUrl("ProcessDesigner/Toolbar/Images/copy.png");        
        button_copy.ToolTip = GR.GetString("Copy");
        button_copy.ID = "tbCopy";
        button_copy.Attributes.Add("onclick", "javascript:click_handlerNew('copy');");

        Telerik.Web.UI.RadToolBarButton button_paste = new Telerik.Web.UI.RadToolBarButton();
        button_paste.CommandName = "paste";
        button_paste.ImageUrl = ProcessDesignerControl.GetThemeRelativeUrl("ProcessDesigner/Toolbar/Images/paste.png");        
        button_paste.ToolTip = GR.GetString("Paste");
        button_paste.ID = "tbPaste";
        button_paste.Attributes.Add("onclick", "javascript:click_handlerNew('paste');");

        Telerik.Web.UI.RadToolBarButton button_edit = new Telerik.Web.UI.RadToolBarButton();
        button_edit.CommandName = "edittext";
        button_edit.ImageUrl = ProcessDesignerControl.GetThemeRelativeUrl("ProcessDesigner/Toolbar/Images/edit-text.png");        
        button_edit.ToolTip = GR.GetString("Edit Text");
        button_edit.ID = "tbEdit";
        button_edit.Attributes.Add("onclick", "javascript:click_handlerNew('edittext');");

        Telerik.Web.UI.RadToolBarButton button_fullscreen = new Telerik.Web.UI.RadToolBarButton();
        button_fullscreen.ID = "tbFullScreen";
        button_fullscreen.Text = string.Empty;
        button_fullscreen.CheckOnClick = true;
        button_fullscreen.AllowSelfUnCheck = true;
        button_fullscreen.Checked = false;
        button_fullscreen.ImageUrl = ProcessDesignerControl.GetThemeRelativeUrl("ProcessDesigner/Toolbar/Images/fullscreen.png");         
        button_fullscreen.ToolTip = GR.GetString("Full Screen");
        button_fullscreen.Attributes.Add("onclick", "javascript:click_handlerNew('fullscreen');");

        Telerik.Web.UI.RadToolBarButton button_snptogrid = new Telerik.Web.UI.RadToolBarButton();
        button_snptogrid.ID = "tbSnapToGrid";
        button_snptogrid.Text = string.Empty;
        button_snptogrid.CheckOnClick = true;
        button_snptogrid.AllowSelfUnCheck = true;
        button_snptogrid.Checked = false;
        button_snptogrid.ImageUrl = ProcessDesignerControl.GetThemeRelativeUrl("ProcessDesigner/Toolbar/Images/snap-to-grid.png");         
        button_snptogrid.ToolTip = GR.GetString("Align to grid");
        button_snptogrid.Attributes.Add("onclick", "javascript:click_handlerNew('snaptogrid');"); 
    
        Telerik.Web.UI.RadToolBarButton button_toolbox = new Telerik.Web.UI.RadToolBarButton();
        button_toolbox.CommandName = "toolbox";
        button_toolbox.ImageUrl = ProcessDesignerControl.GetThemeRelativeUrl("ProcessDesigner/Toolbar/Images/toolbox.png");        
        button_toolbox.ToolTip = GR.GetString("Activities Toolbox");
        button_toolbox.ID = "tbToolBox";
        button_toolbox.Attributes.Add("onclick", "javascript:click_handlerNew('toolbox');");           

        Telerik.Web.UI.RadToolBarButton button_showgrid = new Telerik.Web.UI.RadToolBarButton();
        button_showgrid.Text = string.Empty;
        button_showgrid.CheckOnClick = true;
        button_showgrid.AllowSelfUnCheck = true;
        button_showgrid.Checked = false;
        button_showgrid.ImageUrl = ProcessDesignerControl.GetThemeRelativeUrl("ProcessDesigner/Toolbar/Images/show-grid.png");
        button_showgrid.ToolTip = GR.GetString("Toggle grid display");
        button_showgrid.ID = "tbShowGrid";        
        button_showgrid.Attributes.Add("onclick", "javascript:click_handlerNew('showgrid');");

        Telerik.Web.UI.RadToolBarButton separator1 = new Telerik.Web.UI.RadToolBarButton();
        separator1.IsSeparator = true;

        Telerik.Web.UI.RadToolBarButton separator2 = new Telerik.Web.UI.RadToolBarButton();
        separator2.IsSeparator = true;

        Telerik.Web.UI.RadToolBarButton separator3 = new Telerik.Web.UI.RadToolBarButton();
        separator3.IsSeparator = true;

        Telerik.Web.UI.RadToolBarButton separator4 = new Telerik.Web.UI.RadToolBarButton();
        separator4.IsSeparator = true;

        Telerik.Web.UI.RadToolBarButton separator5 = new Telerik.Web.UI.RadToolBarButton();
        separator5.IsSeparator = true;


        Telerik.Web.UI.RadToolBarButton SearchTemplateButton = new Telerik.Web.UI.RadToolBarButton();       
        HtmlInputText stext = new HtmlInputText();
        stext.ID = "txtSearch";
        stext.Attributes["class"] = "sktoolbartext";
        stext.Style.Value = "width:120px;height:18px;";
        stext.Style.Add(HtmlTextWriterStyle.MarginLeft, "3px");
        SearchHtmlText = stext;
        SearchTemplateButton.Controls.Add(SearchHtmlText);

        Telerik.Web.UI.RadToolBarButton search = new Telerik.Web.UI.RadToolBarButton();
        search.CommandName = "Search";    
        search.ImageUrl = ProcessDesignerControl.GetThemeRelativeUrl("ProcessDesigner/Toolbar/Images/search.png");    
        search.ToolTip = GR.GetString("Search");
        search.ID = "tbSearch";
        search.Attributes.Add("onclick", "javascript:click_handlerNew('Search');");

        Telerik.Web.UI.RadToolBarButton navmap= new Telerik.Web.UI.RadToolBarButton();
        navmap.CommandName = "NavigationMap";
        navmap.ImageUrl = ProcessDesignerControl.GetThemeRelativeUrl("ProcessDesigner/Toolbar/Images/map-navigation.png");
        navmap.ToolTip = GR.GetString("Zoomed process image for navigation");
        navmap.ID = "tbNavigateMap";
        navmap.Attributes.Add("onclick", "javascript:click_handlerNew('NavigationMap');");

        Telerik.Web.UI.RadToolBarButton newlink = new Telerik.Web.UI.RadToolBarButton();
        newlink.CommandName = "newlink";
        newlink.ImageUrl = ProcessDesignerControl.GetThemeRelativeUrl("ProcessDesigner/Toolbar/Images/linking.png");        
        newlink.ToolTip = GR.GetString("Create a new link between two activities");
        newlink.ID = "tbNewLink";
        newlink.Attributes.Add("onclick", "javascript:click_handlerNew('newlink');");
                   
        Telerik.Web.UI.RadToolBarButton button_help = new Telerik.Web.UI.RadToolBarButton();
        button_help.CommandName = "help";
        button_help.ImageUrl = ProcessDesignerControl.GetThemeRelativeUrl("ProcessDesigner/Toolbar/Images/help.png");        
        button_help.ToolTip = GR.GetString("Help");
        button_help.ID = "tbHelp";
        button_help.Attributes.Add("onclick", "javascript:click_handlerNew('help');");
       
        if (ProcessDesignerControl.CanWriteInStaging)
        {
             if ((_IsForInclusion & _MenuList.Contains("mnuUndo")) | ((!_IsForInclusion) & (!_MenuList.Contains("mnuUndo"))))
            {
                toolbar.Items.Add(button_undo);
            }
            if ((_IsForInclusion & _MenuList.Contains("mnuRedo")) | ((!_IsForInclusion) & (!_MenuList.Contains("mnuRedo"))))
            {
                toolbar.Items.Add(button_redo);
            }
            

            if ((_IsForInclusion & _MenuList.Contains("mnuCutDelete")) | ((!_IsForInclusion) & (!_MenuList.Contains("mnuCutDelete"))))
            {
                toolbar.Items.Add(button_cut);
            }
            if ((_IsForInclusion & _MenuList.Contains("mnuCopy")) | ((!_IsForInclusion) & (!_MenuList.Contains("mnuCopy"))))
            {
                toolbar.Items.Add(button_copy);
            }
            if ((_IsForInclusion & _MenuList.Contains("mnuPaste")) | ((!_IsForInclusion) & (!_MenuList.Contains("mnuPaste"))))
            {
                toolbar.Items.Add(button_paste);
            }       
            toolbar.Items.Add(separator1);
            toolbar.Items.Add(button_toolbox);
            toolbar.Items.Add(button_properties);
            toolbar.Items.Add(button_edit);
            toolbar.Items.Add(button_showgrid);
            toolbar.Items.Add(separator2);            
            toolbar.Items.Add(SearchTemplateButton);
            toolbar.Items.Add(search);
            toolbar.Items.Add(navmap);
            toolbar.Items.Add(separator3);
            toolbar.Items.Add(newlink);
            toolbar.Items.Add(separator5);
            toolbar.Items.Add(button_help);        
         }
        else
        {
           
            toolbar.Items.Add(button_showgrid);
            toolbar.Items.Add(separator2);
            toolbar.Items.Add(SearchTemplateButton);
            toolbar.Items.Add(search);
            toolbar.Items.Add(navmap);
            toolbar.Items.Add(separator5);            
            toolbar.Items.Add(separator4);
            if ((_IsForInclusion & _MenuList.Contains("mnuHelp")) | ((!_IsForInclusion) & (!_MenuList.Contains("mnuHelp"))))
            {
                toolbar.Items.Add(button_help);
            }

        }

       
        
    }

</script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <title></title>
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
    <meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
    <link rel="stylesheet" type="text/css" href="<%:ProcessDesignerControl.GetThemeRelativeUrl("ProcessDesigner/stylesheet/pd.css")%>">
    <link rel="stylesheet" type="text/css" href="<%:ProcessDesignerControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTMenu/Menu.AWTMenu.css")%>">
    <link rel="stylesheet" type="text/css" href="<%:ProcessDesignerControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTMenu/Menu.css")%>">
    <link rel="stylesheet" type="text/css" href="<%:ProcessDesignerControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTToolBar/ToolBar.AWTToolBar.css")%>">
      
    <script>
		    var TemplateRoot = "<%=ProcessDesignerControl.TemplateDirectory%>";
		    var TemplatePD =  TemplateRoot+"ProcessDesigner/";
			var ImagesLocation="<%:ProcessDesignerControl.GetThemeRelativeUrl("ProcessDesigner/graphics/")%>";
			var PDControlID = "<%=ProcessDesignerControl.ID%>";
			//var _skRadWindow = "false";
			var _skWorkflowName = "<%=ProcessDesignerControl.WorkflowName%>";
			var _skApplicationName = "<%=ProcessDesignerControl.ApplicationName%>";
			var _skFileName = "<%=ProcessDesignerControl.FileName%>";		
			var _skUICulture = "<%=System.Threading.Thread.CurrentThread.CurrentUICulture.Name%>";
			var SnapToGrid = true;
			var ReadOnlyView = <%=(!ProcessDesignerControl.CanWriteInStaging).ToString().ToLower() %>;			
    </script>

    <script src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ProcessDesignerControl.GetJscriptUrl("javascript/DiagramCommon.js"))%>"></script>
    <script src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ProcessDesignerControl.GetJscriptUrl("javascript/DiagramTop.js"))%>"></script>

    <script>
        var MenuButtonClicked=true;
              
       /*This method will set the Menu toggle  button value to true or false*/
        function executecheck(item, state)
        {
            if(item.Value=="mnuTglFlScrn")
            {
                SetToolBarToggleButton("fullscreen",state);
            }           
        }

         var Diagram;
         function ProcessOnLoad()
         {
            Diagram = GetDiagramObject();        
         }
     
    </script>

</head>
<body onload="SkInitialize();DisableIncompatibleItems();ProcessOnLoad();Initializedd();" style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px; border-style: none;"
    scroll="no">
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(cssPath) %>CommonUXControls/StyleSheet/se.ui.min.css" />
    <script>
    // Initialize locales for message dialog
    se.ui.messageDialog.setGlobalOptions({
        localization: { // All localization related default can be set
            closeButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
            okButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
            cancelButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
            showDetailsCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
            hideDetailsCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
        }
    });

    </script>
    <form id="form1" runat="server" onsubmit="SearchText();return false;">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
        <!--<div id="TopCanvas" style="position: absolute"></div>-->
        <asp:Literal ID="MenuHeaderLiteral1" runat="server"></asp:Literal>
        <div style="position: absolute; left: 2px; top: 0px; z-index: 50000; display: block; vertical-align: top;">
            <telerik:RadMenu ID="RadMenu1" runat="server"
                OnClientItemClicked="OnMenuItemClick" CollapseAnimation-Type="None" EnableEmbeddedSkins="false" Skin="AWTMenu" RenderMode="Classic">
            </telerik:RadMenu>
        </div>

        <div id="pd_toolbar" class="pdtoolbar">
            <div class="pdtoolbarmenu">
                <table cellspacing="0" cellpadding="0" border="0">
                    <tr>
                        <td>
                            <div id="pd_toolbardetails" style="position: absolute; left: 0px; top: 0 px; visibility: hidden;">
                                <table>
                                    <tr>
                                        <%--<td class="sktoolbartitle">
                                        <%=GR.GetString("Application")%></td>--%>
                                        <td class="sktoolbartext" nowrap>
                                            <span id="skappname">
                                                <%=Workflow.NET.CommonFunctions.GetRepositoryDisplayName(ProcessDesignerControl.ApplicationName)%>
                                            </span>
                                        </td>
                                        <td>/</td>
                                        <%--<td class="sktoolbartitle">
                                        <%=GR.GetString("Workflow")%></td>--%>
                                        <td class="sktoolbartext" nowrap>
                                            <span id="skwfname">
                                                <%=ProcessDesignerControl.WorkflowName%>
                                            </span>
                                        </td>
                                        <td>/</td>
                                        <%--<td class="sktoolbartitle">
                                        <%=GR.GetString("File_Version")%></td>--%>
                                        <td class="sktoolbartext" nowrap>
                                            <span id="skfilename">
                                                <%=ProcessDesignerControl.FileName%>
                                            </span>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>

            </div>
            <div class="pdMenuProperty" style="width: 100%;">
                <telerik:RadToolBar ID="toolbar" runat="server" RenderMode="Classic" EnableEmbeddedSkins="false" Skin="AWTToolBar"></telerik:RadToolBar>
            </div>
        </div>
        <div id="toolboxanchor" class="pdtoolboxanchor" onclick="ToggleToolBox()">
            <img id="toolboxanchorimage" src="<%:ProcessDesignerControl.GetThemeRelativeUrl("ProcessDesigner/graphics/collapsable-menu-barclose.gif")%>">
        </div>
        <cc1:Toolbox ID="pd_toolbox" Style="z-index: 101; left: 8px; position: absolute; top: 104px" runat="server" Width="144px" Height="368px" BorderStyle="none" BorderWidth="0px"></cc1:Toolbox>
        <div id="pd_statusbar" class="pdstatusbar">
            <table cellspacing="0" cellpadding="0" width="100%" border="0" height="20">
                <tr>
                    <td class="pdstatustext" width="50%"><%=GR.GetString("FormCopyRightInformation")%></td>
                    <td align="right" class="pdstatustext" width="50%" id="statusbartext">Status</td>
                </tr>
            </table>
        </div>
        <div id="pd_canvas" class="pdcanvas">
            <iframe id="pd_canvas_frame" style="width: 100%; height: 100%; border-style: none"
                src="<%:ProcessDesignerControl.GetPageUrl("ProcessDesignerFrame.aspx")%>"></iframe>
        </div>

        <script>
        
            var IE = (document.all) ? true : false;		    
		    
			function OnMenuItemClick(sender,eventArgs)
			{

			    setTimeout(function () {
                    sender.close();
                });


                var itemValue = eventArgs.get_item().get_value();
	
			    switch(itemValue)
			    {
			        case "mnuUndo": Diagram.ProcessCommand("undo");
			                        break;
			        case "mnuRedo": Diagram.ProcessCommand("redo");
			                        break;
			        case "mnuTglFlScrn": SwitchToFullScreen();
			                             break;
                    case "mnuSnpToGrid": SnapToGrid=!SnapToGrid; 
                                       break;			                             
                    case "mnuShwGrid": Diagram.ToggleGrid();
                                     break;
                    case "mnuShwProWin": Diagram.ProcessCommand("properties");
                                        break;
                    case "mnuCutDelete": Diagram.DeleteSelectedObject();
                               break;
                    case "mnuCopy": Diagram.NodeCopySelectedToClipboard();
                                 break;
                    case "mnuPaste": Diagram.NodePasteFromClipboard();
                                 break;
                    case "mnuHelp": window.open('<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(ProcessDesignerControl.GetHelpPageUrl(), false)%>AbouttheProcessDesigner.html','PDHelp','width=700,height=500,scrollbars=yes,resizable=yes');
                                 break;             
                    case "bamconfiguration":        
                            if(('<%=ProcessDesignerControl.UserIdString%>' != null) && ('<%=ProcessDesignerControl.UserIdString%>' != ""))
                                <%=Skelta.BAM.Configuration.BAMConfigurationAdapter.GetWindowOpenStatement(ProcessDesignerControl.ApplicationName,ProcessDesignerControl.WorkflowName, ProcessDesignerControl.UserIdString) %>
                            else
                                <%=Skelta.BAM.Configuration.BAMConfigurationAdapter.GetWindowOpenStatement(ProcessDesignerControl.ApplicationName,ProcessDesignerControl.WorkflowName) %>
                             break;                                  
			        default: document.getElementById('pd_canvas_frame').contentWindow.OnMainMenuItemClick(eventArgs.get_item());
			                 break;
			    }
			    
			    if(eventArgs.get_item().get_value()=="mnuTglFlScrn")
            	{
            	    TbButtonTogglecheck("fullscreen","mnuTglFlScrn");
	            }

			}
			

		    
            
            function click_handlerNew(commandName)
            {
                
                 var radToolbar1 = $find("<%=toolbar.ClientID%>");
                 var button; 
                
                 switch(commandName)
                 {
                    case "undo": Diagram.ProcessCommand("undo");
                                 break;
                    case "redo": Diagram.ProcessCommand("redo");
                                 break;
                    case "fullscreen": SwitchToFullScreen();
                                       break;
                    case "snaptogrid": SnapToGrid=!SnapToGrid;
                                       break;
                    case "showgrid": Diagram.ToggleGrid();
                                     break;
                    case "properties": Diagram.ProcessCommand("properties");
                                        break;
                    case "toolbox": if( ToolBoxVisible )
                                        HideToolBox();
                                    else
                                        ShowToolBox();
                                    break;       
                   case "edittext": Diagram.ProcessCommand("edittext");
                                    break;        
                   case "Search": SearchText();
                                  break;
                   case "paste": Diagram.NodePasteFromClipboard();
                                 break;
                   case "copy": Diagram.NodeCopySelectedToClipboard();
                                 break;
                   case "cut": Diagram.DeleteSelectedObject();
                               break;
                   case "NavigationMap": var w= Diagram.OpenNewWindowPage("ProcessDesigner/navigatorwindow.aspx","","height=500,width=600,resizable=yes,scrollbars=yes");
                                         break;
                   case "newlink": document.getElementById('pd_canvas_frame').contentWindow.OpenPropertyPages("newlink");
                                 break;                                                  
                   case "help": window.open('<%:ProcessDesignerControl.GetHelpPageUrl()%>AbouttheProcessDesigner.html','PDHelp','width=700,height=500,scrollbars=yes,resizable=yes');
                             break;               
                 }
            	
	           
            }
            
            

            function EnableDisableButton(tbCmdName,mnuId,state)
            {
                //Telerik Toolbar instance

               var radToolbar1 = $find("<%= toolbar.ClientID %>");
                //Telerik Menu instance
                var radMenu1= $find("<%= RadMenu1.ClientID %>");
               //Menu button instance
                var mnuButton=radMenu1.findItemByValue(mnuId); 

              
               //Change the state of the button
                mnuButton.set_enabled(state); /// Menu Button
                if( state )
                {
                    mnuButton.enable();
                    
                }
                else
                {
                    mnuButton.disable();                    
                }
                  
                if(state)
                {
                   radToolbar1.findButtonByCommandName(tbCmdName).set_enabled(true);
                                  
                }
                else
                {
                    radToolbar1.findButtonByCommandName(tbCmdName).set_enabled(false);
                }
            }

           
           function SearchText()
           {
               var txtBox=document.getElementById('<%=SearchHtmlText.ClientID%>');
               Diagram.SearchText(txtBox.value);
               txtBox.focus();
           }
           
           
           function ChangeUndoState(state)
           {
                EnableDisableButton("undo","mnuUndo",state);
           }
           
           function ChangeRedoState(state)
           {
                EnableDisableButton("redo","mnuRedo",state);
           }

            function GetBrowserversion()
            {
	            var app=navigator.userAgent;
	            if(app.indexOf("MSIE")>-1)
	            {
		            return 1;	
	            }
	            else 
	            {
		            return 2;	
	            }
            }

        </script>

    </form>
</body>
</html>
