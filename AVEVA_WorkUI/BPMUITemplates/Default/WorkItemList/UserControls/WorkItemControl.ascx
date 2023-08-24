<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.HWS.WorkListChannel.Web.UserControls.WorkItemControlClass" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<link rel="stylesheet" type="text/css" href="<%=_WorkItemControl.GetCommonRelativeUrl("StyleSheet/Global.css")%>" />


<script src="<%=_WorkItemControl.GetJscriptUrl("/javascripts/WorkItemControlJs.js")%>" type="text/javascript"></script>
<script src="<%=_TemplateDirectory%>Common/JavaScripts/jquery.min.js"></script>
<script src="<%=_TemplateDirectory%>Common/JavaScripts/AutoLogoff.js"></script>
<script src="<%=_TemplateDirectory%>CommonUXControls/scripts/window/se.ui.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=_WorkItemControl.GetThemeRelativeUrl("CommonUXControls/StyleSheet/se.ui.min.css")%>">
<link rel="stylesheet" type="text/css" href="<%=_WorkItemControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTSplitter/Splitter.AWTSplitter.css")%>">
<link rel="stylesheet" type="text/css" href="<%=_WorkItemControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTToolBar/ToolBar.AWTToolBar.css")%>">
<link rel="stylesheet" type="text/css" href="<%=_WorkItemControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css")%>">
<link rel="stylesheet" type="text/css" href="<%=_WorkItemControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTWindow/Window.css")%>">


<script runat="server">
    HtmlSelect zoombox;
    protected  Telerik.Web.UI.RadToolBar toolbar;
    override protected void OnInit(EventArgs e)
    {        
        base.OnInit(e);
        LoadToolBar();        
       
    }

    private bool _CanViewControl = true;
    private bool _CanSetAlternateActor = true;
    private bool _CanSetPreferencess = true;
    private bool _CanViewResourceCalendar = true;

    void ApplySecurity()
    {    
        // Ayyub :: Check for Backward compatibility
        if (string.IsNullOrEmpty(_WorkItemControl.ApplicationName) | string.IsNullOrEmpty(_WorkItemControl.UserIdString))
        {
            Workflow.NET.Log logger = new Workflow.NET.Log();
            logger.LogInformation("Application or UserIdString may be null: Security cannot be applied");
            logger.Close();
            return;
        }
        // Ayyub :: Security application
        Skelta.Repository.Security.SecurityManager sm = new Skelta.Repository.Security.SecurityManager(_WorkItemControl.UserIdString, _WorkItemControl.ApplicationName);
        System.Collections.Generic.SortedDictionary<string, string> dicWorkItem = sm.GetRightsFor_WorkItem();

        string value;
        if (dicWorkItem.ContainsKey("cansetalternateactor"))
        {
            value = dicWorkItem["cansetalternateactor"];
            if (value.ToLowerInvariant().Equals("false"))
                _CanSetAlternateActor = false;
        }
        if (dicWorkItem.ContainsKey("cansetpreferencess"))
        {
            value = dicWorkItem["cansetpreferencess"];
            if (value.ToLowerInvariant().Equals("false"))
                _CanSetPreferencess = false;
        }
        if (dicWorkItem.ContainsKey("canviewqueue"))
        {
            value = dicWorkItem["canviewqueue"];
            if (value.ToLowerInvariant().Equals("false"))
                _WorkItemControl.ShowQueues = false;
        }
        if (dicWorkItem.ContainsKey("canviewresourcecalendar"))
        {
            value = dicWorkItem["canviewresourcecalendar"];
            if (value.ToLowerInvariant().Equals("false"))
                _CanViewResourceCalendar = false;
        }
        if (dicWorkItem.ContainsKey("canviewworkitemcontrol"))
        {
            value = dicWorkItem["canviewworkitemcontrol"];
            if (value.ToLowerInvariant().Equals("false"))
            {
                //Page.ClientScript.RegisterStartupScript(GetType(), "NoPermission", "alert('You do not have right to view the WorkitemList control.');", true);
                Page.ClientScript.RegisterStartupScript(GetType(), "NoPermission", "alert("+_WorkItemControl.GlobalResourceSet.GetString("You do not have right to view the WorkitemList control.")+");", true);                
                _WorkItemControl.CanViewControl = false;
                _CanViewControl = false;
            }
        }
    }
    private void LoadToolBar()
    {
        
        string applicationName = _WorkItemControl.ApplicationName;
       
        toolbar = new Telerik.Web.UI.RadToolBar();
        toolbar.Skin = "AWTToolBar";
        toolbar.EnableEmbeddedSkins = false;
        toolbar.EnableViewState = false; 
        toolbarplaceholder.Controls.Add(toolbar);

        // Ayyub :: Check for Global Security Application Flag
        if (Skelta.Repository.Security.SecurityManager.GetSecurityFlag(applicationName))
            ApplySecurity();

        if (!_CanViewControl)
            return;                              
        
        Skelta.Core.ApplicationObject application=new Skelta.Core.ApplicationObject(applicationName);
        object userid=_WorkItemControl.UserId;
    
        //For Showing Get Next Queue Button and DropDown
        
       Skelta.HWS.Actor Actor = new Skelta.HWS.Actor(application,userid);
       Dictionary<Guid, string> QueueCollection = Actor.GetNextItemEnabledQueuesWithAccessRights();
                
        if(QueueCollection.Count>0)
        {
        
            placeholderforqueuetd.Visible=true;
            zoombox = new HtmlSelect();
            zoombox.ID = "rptzoom";
            zoombox.Attributes["class"] = "inputselect";

           

            foreach (KeyValuePair<Guid, string> qc in QueueCollection.OrderBy(key => key.Value))
            {
                zoombox.Items.Add(new ListItem(qc.Value, qc.Key.ToString()));
            }
           

            zoombox.Style.Add(HtmlTextWriterStyle.MarginLeft, "3px");            
            placeholderforGetNextQueue.Controls.Add(zoombox);
            
            Telerik.Web.UI.RadToolBarButton nextbutton = new Telerik.Web.UI.RadToolBarButton();
            HtmlButton button_GetNewQueueItem = new HtmlButton();                        
            button_GetNewQueueItem.InnerText = _WorkItemControl.GlobalResourceSet.GetString("Next Item");
            button_GetNewQueueItem.ID = "tbnextbutton";
            button_GetNewQueueItem.Attributes.Add("onclick", "javascript:var selectedQueue=document.getElementById('" + zoombox.ClientID + "').value;CallGetNextItem('" + applicationName + "',selectedQueue,'" + Actor.Id + "');");
            button_GetNewQueueItem.Attributes.Add("onMouseOver", "this.className='Wilinputbuttonhover'");
            button_GetNewQueueItem.Attributes.Add("onMouseOut", "this.className='inputbutton'");
            button_GetNewQueueItem.Attributes["class"] = "inputbutton";            
            nextbutton.Controls.Add(button_GetNewQueueItem);            
            toolbar.Items.Add(nextbutton);                   
               
        }
        else
        {
            placeholderforqueuetd.Visible=false;
        }
     
        Telerik.Web.UI.RadToolBarButton SeparatorImage = new Telerik.Web.UI.RadToolBarButton();
        Image img = new Image();
        img.Width = Unit.Pixel(25);         
        img.ImageUrl = "../toolbar/Graphics/img/spacer.gif";

        SeparatorImage.Controls.Add(img);  
        toolbar.Items.Add(SeparatorImage);


        if (_WorkItemControl.ShowQueues == true)
        {

            //Skelta.HWS.Queue.QueueCollection getQueueforActor = Actor.GetQueues();           

            Telerik.Web.UI.RadToolBarButton radTempQueueButton = new Telerik.Web.UI.RadToolBarButton();
            HtmlImage showQueueButton = new HtmlImage();            
            showQueueButton.ID = "tbshowqueuebutton";
            showQueueButton.Src = _WorkItemControl.GetThemeRelativeUrl("workitemlist/Toolbar/Graphics/Img/show-queue.png");
            showQueueButton.Attributes.Add("onclick", "javascript:CallQueue('" + applicationName + "','" + Actor.Id + "');");
            showQueueButton.Attributes.Add("title",_WorkItemControl.GlobalResourceSet.GetString("Show queue"));
            showQueueButton.Alt = _WorkItemControl.GlobalResourceSet.GetString("Show queue");           
            
            radTempQueueButton.Controls.Add(showQueueButton);

            toolbar.Items.Add(radTempQueueButton);
            
         
        }

        Telerik.Web.UI.RadToolBarButton SeparatorImage1 = new Telerik.Web.UI.RadToolBarButton();
        Image img1 = new Image();
        img1.Width = Unit.Pixel(25);
        img1.ImageUrl = "../toolbar/Graphics/img/spacer.gif";

        SeparatorImage1.Controls.Add(img1);
        toolbar.Items.Add(SeparatorImage1);

       
        // Security
        if (_CanSetAlternateActor)
        {          

            Telerik.Web.UI.RadToolBarButton radTempAlternateActorButton = new Telerik.Web.UI.RadToolBarButton();
            HtmlImage showAlternateActorButton = new HtmlImage();
            showAlternateActorButton.ID = "tbshowAlternateActorButton";
            showAlternateActorButton.Src = _WorkItemControl.GetThemeRelativeUrl("workitemlist/Toolbar/Graphics/Img/alternate-actor.png");
            showAlternateActorButton.Attributes.Add("onclick", "javascript:CallAlternateActor('" + applicationName + "','" + Actor.Id + "');");
            showAlternateActorButton.Alt = _WorkItemControl.GlobalResourceSet.GetString("Show alternate actor");
            showAlternateActorButton.Attributes.Add("title",_WorkItemControl.GlobalResourceSet.GetString("Show alternate actor"));
            radTempAlternateActorButton.Controls.Add(showAlternateActorButton);

            toolbar.Items.Add(radTempAlternateActorButton);
            
        }

               

        Telerik.Web.UI.RadToolBarButton SeparatorImage2 = new Telerik.Web.UI.RadToolBarButton();
        Image img2 = new Image();
        img2.Width = Unit.Pixel(25);
        img2.ImageUrl = "../toolbar/Graphics/img/spacer.gif";

        SeparatorImage2.Controls.Add(img2);
        toolbar.Items.Add(SeparatorImage2);

        // Security
        if (_CanViewResourceCalendar)
        {
            

            Telerik.Web.UI.RadToolBarButton radTempCalendarButton = new Telerik.Web.UI.RadToolBarButton();
            HtmlImage showCalendarButton = new HtmlImage();
            showCalendarButton.ID = "tbshowCalendarButton";
            showCalendarButton.Src = _WorkItemControl.GetThemeRelativeUrl("workitemlist/Toolbar/Graphics/Img/resource-calendar.png");
            showCalendarButton.Attributes.Add("onclick", "javascript:CallCalendar('" + applicationName + "','" + Actor.Id + "');");
            showCalendarButton.Alt = _WorkItemControl.GlobalResourceSet.GetString("Show resource calendar");
            showCalendarButton.Attributes.Add("title",_WorkItemControl.GlobalResourceSet.GetString("Show resource calendar"));
            radTempCalendarButton.Controls.Add(showCalendarButton);
            
            toolbar.Items.Add(radTempCalendarButton);
            
        }
        
        

        Telerik.Web.UI.RadToolBarButton SeparatorImage3 = new Telerik.Web.UI.RadToolBarButton();
        Image img3 = new Image();
        img3.Width = Unit.Pixel(25);
        img3.ImageUrl = "../toolbar/Graphics/img/spacer.gif";

        SeparatorImage3.Controls.Add(img3);
        toolbar.Items.Add(SeparatorImage3);

        // Security
        if (_CanSetPreferencess)
        {
           

            Telerik.Web.UI.RadToolBarButton radTempChannelpreferences = new Telerik.Web.UI.RadToolBarButton();
            HtmlImage showChannelpreferences = new HtmlImage();
            showChannelpreferences.ID = "tbSetPreferences";
            showChannelpreferences.Src = _WorkItemControl.GetThemeRelativeUrl("workitemlist/Toolbar/Graphics/Img/set-preferences.png");
            showChannelpreferences.Attributes.Add("onclick", "javascript:CallPreferences('" + applicationName + "','" + Actor.Id + "');");
            showChannelpreferences.Alt = _WorkItemControl.GlobalResourceSet.GetString("Set preferences");
            showChannelpreferences.Attributes.Add("title",_WorkItemControl.GlobalResourceSet.GetString("Set preferences"));
            radTempChannelpreferences.Controls.Add(showChannelpreferences);

            toolbar.Items.Add(radTempChannelpreferences);
            
            
            
        }
        
        Telerik.Web.UI.RadToolBarButton SeparatorImage4 = new Telerik.Web.UI.RadToolBarButton();
        Image img4 = new Image();
        img4.Width = Unit.Pixel(25);
        img4.ImageUrl = "../toolbar/Graphics/img/spacer.gif";
        SeparatorImage4.Controls.Add(img4);
        toolbar.Items.Add(SeparatorImage4); 
        
    }

   

</script>

<script type="text/javascript">

    var templatedirectory ="<%=_TemplateDirectory%>";
    strIsClassicPaging ="<%=_StrIsClassicPaging%>";

    se.ui.messageDialog.setGlobalOptions({
        localization: {
            closeButtonCaption: "<%=_WorkItemControl.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                   okButtonCaption: "<%=_WorkItemControl.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
                   cancelButtonCaption: "<%=_WorkItemControl.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                   showDetailsCaption: "<%=_WorkItemControl.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                   hideDetailsCaption: "<%=_WorkItemControl.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
               }
           });


</script>



<table style="width: 100%; height: 52px; border-spacing: 0px; border-collapse: collapse; border: 0px;">
    <tr class="InboxActionBarCss">
        <td style="width: 10%; vertical-align: middle; padding: 3px;">
            <img id="imgInbox" style="vertical-align: top;" src="<%$ ReplaceTemplateExpn:WorkItemList/images/icon-inbox.png%>" runat="server" visible="false" />
            <span class="subtitle" style="vertical-align: middle; display: none;"><%=_WorkItemControl.GlobalResourceSet.GetString("Inbox")%></span>
        </td>

        <%if (CheckGroupUI == true)
               { %>
        <td id="multiselectqueueoptions" style="display: none; float: right; vertical-align: bottom; padding-top: 8px;" class="description" runat="server">
            <img id="btnPick" src="<%=_WorkItemControl.GetThemeRelativeUrl("WorkitemList/images/Pick.png")%>" alt="<%=_StrPick%>" title="<%=_StrPick%>" style="border-width: 0" onclick="javascript:MultiSelectForQueue('Pick Queue','<%=WebGrid1.ClientID%>')" />
            <img id="Img1" style="width: 20px" src="<%=_WorkItemControl.GetThemeRelativeUrl("WorkitemList/toolbar/Graphics/img/spacer.gif")%>" />
            <img id="btnPlan" src="<%=_WorkItemControl.GetThemeRelativeUrl("WorkitemList/images/Plan-Queue.png")%>" alt="<%=_StrPlan%>" title="<%=_StrPlan%>" style="border-width: 0" onclick="javascript:MultiSelectForQueue('Plan Queue','<%=WebGrid1.ClientID%>')" />
            <img id="Img2" style="width: 20px" src="<%=_WorkItemControl.GetThemeRelativeUrl("WorkitemList/toolbar/Graphics/img/spacer.gif")%>" />
            <img id="btnAllocateQueueItem" src="<%=_WorkItemControl.GetThemeRelativeUrl("WorkitemList/images/Allocate-queue-item.png")%>" alt="<%=_StrAllocateQueue%>" title="<%=_StrAllocateQueue%>" style="border-width: 0" onclick="javascript:MultiSelectForQueue('Allocate Queue','<%=WebGrid1.ClientID%>')" />
            <img id="Img3" style="width: 20px" src="<%=_WorkItemControl.GetThemeRelativeUrl("WorkitemList/toolbar/Graphics/img/spacer.gif")%>" />
            <img id="btnRecallQueueItems" src="<%=_WorkItemControl.GetThemeRelativeUrl("WorkitemList/images/recall-allocate-queue-item.png")%>" alt="<%=_StrRecallItems %>" title="<%=_StrRecallItems %>" style="border-width: 0" onclick="javascript:MultiSelectForQueue('Recall Allocated Items','<%=WebGrid1.ClientID%>')" />
            <img id="Img4" style="width: 20px" src="<%=_WorkItemControl.GetThemeRelativeUrl("WorkitemList/toolbar/Graphics/img/spacer.gif")%>" />
            <img id="btnReassignQueueItems" src="<%=_WorkItemControl.GetThemeRelativeUrl("WorkitemList/images/Reassign-workitems.png")%>" alt="<%=_StrReassignQueueItems %>" title="<%=_StrReassignQueueItems %>" style="border-width: 0" onclick="javascript:MultiSelectForQueue('Reassign Queue Items','<%=WebGrid1.ClientID%>')" />
            <img id="Img5" style="width: 20px" src="<%=_WorkItemControl.GetThemeRelativeUrl("WorkitemList/toolbar/Graphics/img/spacer.gif")%>" />
        </td>
        <td style="text-align: left; width: 0%; display: none;" id="divGroupSelectionEnabledCheckBox">
            <input type="checkbox" id="GroupSelectionEnabledCheckBox" />
            <img id="Img6" style="width: 20px" src="<%=_WorkItemControl.GetThemeRelativeUrl("WorkitemList/toolbar/Graphics/img/spacer.gif")%>" />
        </td>

        <td style="text-align: right; vertical-align: middle; width: 5px;">
            <a onclick="javascript:EnablecheckGroupUI('<%=grdLeftMenu.ClientID%>','<%=WebGrid1.ClientID%>','<%=imgCheck1.ClientID%>','<%=imgCheck2.ClientID%>')">
                <img id="imgCheck1" style="vertical-align: top; text-align: right; padding-bottom: 3px;" src="<%$ ReplaceTemplateExpn:WorkItemList/images/Enable-multi.png%>" runat="server" />
            </a>

            <a onclick="javascript:EnablecheckGroupUI('<%=grdLeftMenu.ClientID%>','<%=WebGrid1.ClientID%>','<%=imgCheck1.ClientID%>','<%=imgCheck2.ClientID%>')">
                <img id="imgCheck2" style="visibility: hidden; display: none; vertical-align: top; text-align: right; padding-bottom: 3px;" src="<%$ ReplaceTemplateExpn:WorkItemList/images/Disable-multi.png%>" runat="server" />
            </a>
        </td>


        <td style="width: 1%">&nbsp;<img src="<%$ ReplaceTemplateExpn:WorkItemList/images/Separator.png%>" runat="server" />
        </td>

        <%
            }
           else
            {
        %>
        <td style="width: 55%; text-align: right;"></td>

        <%
          } 
        %>



        <td style="width: 5%; vertical-align: middle; padding: 3px;" id="placeholderforqueuetd" runat="server">
            <asp:PlaceHolder runat="server" ID="placeholderforGetNextQueue"></asp:PlaceHolder>
        </td>

        <td style="width: 10%; vertical-align: middle; padding-left: 3px; text-align: right;">
            <asp:PlaceHolder runat="server" ID="toolbarplaceholder"></asp:PlaceHolder>
        </td>



        <td style="text-align: right; width: 15%" class="subtitle"><%=CurrentLoggedUserName%>&nbsp;</td>      

        <telerik:RadWindowManager ID="RadWindowManagerX" VisibleOnPageLoad="false" Height="280" Width="700" Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" runat="server" BackColor="Black" Behaviors="Close, Move, Minimize, Maximize" DestroyOnClose="true" Overlay="false" RenderMode="Classic" VisibleStatusbar="false">
            <Windows>
                <telerik:RadWindow ID="PackageWindow" Height="700px" Width="400px" runat="server" Modal="true" ></telerik:RadWindow>
            </Windows>
</telerik:RadWindowManager>

    </tr>
</table>

<table id="MainWorkitemTable" class="WorkitemGridTableStyle">
    <tr style="height: 100%; width: 100%;">
        <td style="height: 100%; width: 100%; vertical-align: top;">
            <telerik:RadSplitter ID="Radsplitbar1" runat="server" Width="100%" Height="100%" ResizeWithParentPane="false"
                Skin="AWTSplitter" SplitBarsSize="5px" EnableEmbeddedSkins="false">
                <telerik:RadPane ID="Radpane1" runat="server" Width="18%" Scrolling="None">
                    <div style="vertical-align: top; height: 100%; width: 100%;" id="LeftMenuTD" runat="server">
                        <ISWebGrid:WebGrid ID="grdLeftMenu" runat="server" Width="100%" Height="100%" RenderingMode="HTML5"
                            OnInitializeDataSource="grdLeftMenu_InitializeDataSource" DataCacheStorage="PageCache" ViewStateStorage="None" AllowAutoDataCaching="false"
                            OnInitializeRow="grdLeftMenu_InitializeRow" OnInitializePostBack="grdLeftMenu_InitializePostBack" OnPrepareDataBinding="grdLeftMenu_DataBind" DisableFileSystemChecking="true" EnableWebResources="Never">
                            <LayoutSettings InProgressUIBehavior="ChangeCursorToHourGlass" RowHeightDefault="20px" RowHeaders="No" GridLines="None" AutoFitColumns="false" AutoWidth="false"
                                CellPaddingDefault="2" GridLineStyle="Solid" ColumnHeaders="No" StatusBarVisible="False" GridLineColor="236, 233, 216" AlternatingColors="false">
                                <ImageSettings CollapseImage="<%$ ReplaceTemplateExpn:WorkItemList/images/collapse-arrow.png%>" ExpandImage="<%$ ReplaceTemplateExpn:WorkItemList/images/expand-arrow.png%>"></ImageSettings>
                                <HeaderStyle CssClass="GridHeaderStyle" Wrap="False"></HeaderStyle>
                                <ClientSideEvents OnSelfRefRowExpand="GetSelfRowExpRows" OnSelfRefRowCollapse="GetSelfRowCollRows" OnInitialize="grdLeftMenu_Init" OnRowSelect="grdLeftMenu_RowSelect" OnRowContextMenu="grdLeftMenu_OnRowContextMenu" OnBeforeRequest="DoBeforeRequest" OnAfterResponseProcess="ExpandSelfRefRow"></ClientSideEvents>
                                <FrameStyle BorderWidth="0px" BorderColor="White" BorderStyle="Solid" CssClass="LeftGridFrameStyle"></FrameStyle>
                                <RowStyle CssClass="LeftGridRowStyle" Wrap="False"></RowStyle>
                                <SelectedRowStyle CssClass="LeftGridSelectedRowStyle"></SelectedRowStyle>
                                <AlternatingRowStyle CssClass="LeftGridRowStyle"></AlternatingRowStyle>
                                <LostFocusRowStyle CssClass="LeftGridSelectedRowStyle"></LostFocusRowStyle>
                                <TextSettings Language="UseCulture"></TextSettings>
                            </LayoutSettings>
                            <RootTable DataKeyField="FolderID" DataMember="WorkItemLeftMenu">
                                <TableHeaderStyle CssClass="GridTableHeaderStyle">
                                    <Padding Bottom="4px" Left="4px" Top="4px" Right="4px"></Padding>
                                </TableHeaderStyle>
                                <SelfReferencingSettings ExpandColumnMember="Name" Enabled="True" IsTreeViewSelectionMode="True" ChildDataMember="ParentFolderID"
                                    ParentDataMember="FolderID" ExpandColumnInnerTextPadding="1"></SelfReferencingSettings>
                                <FormatConditions>
                                    <ISWebGrid:WebGridFormatCondition CustomConditionText="[UnreadItems] &gt; 0" Name="fcUnread">
                                        <FormatStyle Font-Bold="false"></FormatStyle>
                                    </ISWebGrid:WebGridFormatCondition>
                                </FormatConditions>
                                <Columns>
                                    <ISWebGrid:WebGridColumn Caption="Name" ShowInSelectColumns="No" DataMember="Name" ColumnType="ImageAndText"
                                        Name="Name" Width="98%">
                                    </ISWebGrid:WebGridColumn>
                                </Columns>
                            </RootTable>
                        </ISWebGrid:WebGrid>

                    </div>

                </telerik:RadPane>


                <telerik:RadSplitBar ID="Radsplitbar2" runat="server" CollapseMode="Forward" />
                <telerik:RadPane ID="Radpane2" runat="server" Width="82%" Height="100%" Scrolling="None">

                    <div style="height: 100%; width: 100%; padding: 0px; margin: 0px;">
                        <div id="GridDetailsTD" style="vertical-align: top; width: 100%; height: 50%;" runat="server">
                            <div id="DocViewDetailsGrid" style="vertical-align: top; width: 100%; height: 100%;" runat="server">
                                <ISWebGrid:WebGrid ID="WebGrid1" runat="server" Height="100%" HorizontalAlign="NotSet" Width="100%" EnableSection508Standards="false"
                                    OnInitializeDataSource="WebGrid1_InitializeDataSource" OnPrepareDataBinding="WebGrid1_PrepareDataBinding" AllowAutoDataCaching="false" ViewStateStorage="None" DataCacheStorage="PageCache"
                                    OnInitializeRow="WebGrid1_InitializeRow" OnInitializeLayout="WebGrid1_InitializeLayout" OnInitializePostBack="WebGrid1_InitializePostBack"
                                    OnPrepareExportExecute="WebGrid1_PrepareExportExecute" DisableFileSystemChecking="true" EnableWebResources="Never" RenderingMode="HTML5">
                                    <LayoutSettings InProgressUIBehavior="ChangeCursorToHourGlass" FilterBarVisible="false" AutoFitColumnsBuffering="false"
                                        AlwaysShowHelpButton="false" RestoreRowSelection="All"
                                        PagingMode="VirtualLoad" VirtualLoadMode="Default" VirtualPageSize="10"
                                        CellClickAction="RowSelect" UseRelativePositioning="true" PersistRowChecker="True"
                                        AllowAddNew="No" AlternatingColors="false"
                                        GridLineStyle="Solid" GridLineColor="#afafaf" CellPaddingDefault="2" RowHeightDefault="20px" GridLines="Horizontal"
                                        AllowSorting="Yes" AllowGrouping="Yes" AllowFilter="Yes" AllowSelectColumns="Yes" AllowColumnMove="Yes" AutoFitColumns="true" RowHeaders="No">
                                        <HeaderStyle Wrap="false" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CssClass="GridHeaderStyle"></HeaderStyle>
                                        <FocusCellStyle CssClass="GridFocusCellStyle"></FocusCellStyle>
                                        <GroupRowInfoStyle CssClass="GridGroupRowInfoStyle"></GroupRowInfoStyle>
                                        <GroupByBox>
                                            <LabelStyle CssClass="GridLabelStyle"></LabelStyle>
                                            <Style BackColor="#ececec"></Style>
                                        </GroupByBox>
                                        <FilterRowStyle CssClass="GridEditFocusCellStyle"></FilterRowStyle>
                                        <EditTextboxStyle CssClass="GridEditTextBoxStyle"></EditTextboxStyle>
                                        <EditFocusCellStyle CssClass="GridEditFocusCellStyle"></EditFocusCellStyle>
                                        <FrameStyle GradientType="Vertical" CssClass="GridFrameStyle"></FrameStyle>
                                        <SelectedRowStyle CssClass="GridSelectedRowStyle"></SelectedRowStyle>
                                        <AlternatingRowStyle CssClass="GridAlternatingRowStyle" OverflowX="hidden" OverflowY="hidden"></AlternatingRowStyle>
                                        <StatusBarStyle CssClass="GridStatusBarStyle">
                                            <Padding Top="4px" Left="4px" Bottom="4px" Right="4px"></Padding>
                                        </StatusBarStyle>
                                        <RowStyle OverflowX="hidden" OverflowY="hidden"></RowStyle>
                                        <ClientSideEvents OnInitialize="HidePadColumn" OnBeforeRowSelect="CheckRowSelect" OnCheckBoxClick="callforqueuecheckboxclick"
                                            OnGroupExpand="GetExpandRows" OnGroupCollapse="GetCollapseRows" OnColumnGroup="EnableGroupCheckBox" OnColumnUngroup="DisableGroupCheckBox"
                                            OnRowContextMenu="WebGrid1_OnRowContextMenu" OnAfterResponseProcess="SelectDetailsRow"
                                            OnColumnSort="ChangeVariable" OnColumnChanged="ChangeVariable" />
                                        <TextSettings Language="UseCulture"></TextSettings>
                                        <LostFocusRowStyle CssClass="GridSelectedRowStyle"></LostFocusRowStyle>
                                        <ImageSettings RefreshImage="<%$ ReplaceTemplateExpn:Grid/images/refresh.png%>" MoreDataImage="<%$ ReplaceTemplateExpn:Grid/images/LoadMoreData.png%>"
                                            ExportImage="<%$ ReplaceTemplateExpn:Grid/images/Export.png%>" />
                                    </LayoutSettings>
                                    <RootTable GridLineStyle="NotSet" TableHeaderVisible="false" Caption="Open Items" GroupMode="Default">
                                        <TableHeaderStyle GradientType="Vertical" CssClass="GridTableHeaderStyle">
                                            <Padding Bottom="2px" Left="2px" Top="2px" Right="2px"></Padding>
                                        </TableHeaderStyle>
                                    </RootTable>
                                </ISWebGrid:WebGrid>
                            </div>
                            <iframe id="opengroupuiframe" style="position: absolute; display: none; border: solid 1px darkgray; z-index: 100;" src="../blank.htm"></iframe>
                        </div>
                        <div style="vertical-align: top; display: none; height: 50%;" id="divDocView">
                            <iframe id="docframe" src="<%=_TemplateDirectory%>WorkItemList/blank.htm" style="border: none; margin: 0px 0px 0px 0px; padding: 0px 0px 0px 0px; width: 100%; height: 100%;"></iframe>
                        </div>
                    </div>
                </telerik:RadPane>
            </telerik:RadSplitter>



        </td>
    </tr>
</table>

<iframe id="CustomLink" style="position: absolute; display: none; border: solid 1px lightgray; background-color: white;"></iframe>
<iframe id="openqueueframe" style="visibility: hidden; display: none" src="../blank.htm"></iframe>
<iframe id="opennonweb" style="visibility: hidden; display: none" src="../blank.htm"></iframe>

<div id="prepage" style="position: absolute; height: 80%; width: 100%; text-align: center; left: 0px; top: 100px; display: none; vertical-align: middle;" runat="server">
    <table style="height: 100%; width: 100%; vertical-align: middle;">
        <tr style="vertical-align: middle">
            <td style="text-align: center; vertical-align: middle">
                <div style="background: #f1f1f1; border: 0px solid black; height: 20%; width: 20%; vertical-align: middle; margin: 0px auto;">
                    <table style="height: 100%; width: 100%; vertical-align: middle">
                        <tr style="vertical-align: middle">
                            <td style="text-align: center; vertical-align: middle" class="descriptionbold">
                                <%=_GroupUIMessage%>
                            </td>
                        </tr>
                        <tr style="vertical-align: middle">
                            <td style="text-align: center; vertical-align: middle" class="descriptionbold">
                                <img src="<%=_ThemeDirectory%>WorkItemList/Images/loading2.gif" />
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>
</div>

<input type="hidden" id="hdnWorkitemControlid" runat="server" />
<input type="hidden" id="hdnLeftGridVisibility" runat="server" />
<input type="hidden" id="hdnControlHeight" runat="server" />
<input type="hidden" id="hdnHeight" runat="server" />
<input type="hidden" id="hdnViewTypeWithoutLeftGrid" runat="server" />
<input type="hidden" id="hdnEnableQueueMultiSelectbyDefault" runat="server" />
<input type="hidden" id="hdnCheckReadingpaneFlag" runat="server" />

<input type="hidden" id="hdnRowDoubleClick" runat="server" />
<input type="hidden" id="hdnMultiSelectWindow" runat="server" />
<input type="hidden" id="hdnDetailViewwithMultiSelect" runat="server" />
<input type="hidden" id="hdnEnableMoveNext" runat="server" />
<input type="hidden" id="hdnAutoMove" runat="server" />
<input type="hidden" id="hidMoveNextCheckValue" />
<input type="hidden" id="hiddenShowDetailViewAsModal" runat="server" />
<input type="hidden" id="hiddenUniqeIDForCachKey" runat="server" />

<script type="text/javascript">

    checkreadingpaneflag = document.getElementById("<%=hdnCheckReadingpaneFlag.ClientID%>").value;
    document.getElementById("<%=hiddenUniqeIDForCachKey.ClientID%>").value = Math.random();
    if (checkreadingpaneflag == "")
        checkreadingpaneflag = "True";

    //Setting the height of DocViewTd
    try {
        if (navigator.appName == "Microsoft Internet Explorer") {
            document.getElementById("MainWorkitemTable").style.height = "95%";
            if (checkreadingpaneflag == "True") {
                document.getElementById("<%=DocViewDetailsGrid.ClientID%>").style.height = "100%";
                document.getElementById("<%=GridDetailsTD.ClientID%>").style.height = "100%";
            }
        }
        else {
            document.getElementById("MainWorkitemTable").style.height = "92%";
            if (checkreadingpaneflag != "False") {
                document.getElementById("<%=DocViewDetailsGrid.ClientID%>").style.height = "100%";
                document.getElementById("<%=GridDetailsTD.ClientID%>").style.height = "100%";

            }
        }
    }
    catch (e) {

    }

    var checkTakeOwnerShip ='<%=_CheckAutoOwnership%>';

    workListCtrlName = '<%=_WorkItemControl.ID%>';

    showDetailViewAsModal = document.getElementById("<%=hiddenShowDetailViewAsModal.ClientID%>").value;
    if (showDetailViewAsModal == "")
        showDetailViewAsModal = "False";

    checkLeftgridvisibility = document.getElementById("<%=hdnLeftGridVisibility.ClientID%>").value;    
    if (checkLeftgridvisibility == "False") {

        document.getElementById("<%=LeftMenuTD.ClientID%>").style.width = "0%";
        document.getElementById("<%=LeftMenuTD.ClientID%>").style.display = "none";

        //To restrict the grid to take full height when we set the 
        //Inboxviewonly property is set to true
        var strFullHeight = document.getElementById("<%=hdnControlHeight.ClientID%>").value;

        if (strFullHeight == "False") {
            var getctrlHeight = document.getElementById("<%=hdnHeight.ClientID%>").value;
            if (getctrlHeight == "")
                getctrlHeight = "250px";
            try {
                document.getElementById("<%=DocViewDetailsGrid.ClientID%>").style.height = getctrlHeight - 50;
                document.getElementById("<%=GridDetailsTD.ClientID%>").style.height = getctrlHeight - 50;
            }
            catch (e) {

            }
        }
        else {

            if (checkreadingpaneflag == "True") {
                var Grid1 = ISGetObject("WebGrid1");
                if (!(Grid1 == 'undefined' || Grid1 == null)) {
                    try {
                        document.getElementById("<%=DocViewDetailsGrid.ClientID%>").style.height = document.body.clientHeight * 75 / 100;
                    document.getElementById("<%=GridDetailsTD.ClientID%>").style.height = document.body.clientHeight * 75 / 100;
                    Grid1.SetHeight(document.body.clientHeight * 75 / 100);
                }
                catch (e) {

                }
            }

            if ('<%=_ISfromSharePoint%>' == "True")
                document.getElementById("<%=GridDetailsTD.ClientID%>").style.width = document.body.clientWidth * 85 / 100;
            }
        }

        //window.setTimeout(function() { try { CollapsePane(); } catch (e) { } }, 500); 


        var app = navigator.userAgent;

        if (app.indexOf("MSIE") > -1) {
            window.setTimeout('CollapsePane<%=Radsplitbar1.ClientID%>Function();', 300);
        }
        else if (app.indexOf("Firefox/1.5") > -1 || app.indexOf("Firefox/") > -1) {
            window.setTimeout('CollapsePane<%=Radsplitbar1.ClientID%>Function();', 300);
        }
        else {
            window.setTimeout('CollapsePane<%=Radsplitbar1.ClientID%>Function();', 300);
        }





    }
    viewTypeWithoutLeftGrid ="<%=_ViewTypeWithoutLeftGrid%>";
    if (typeof (document.getElementById("divGroupSelectionEnabledCheckBox")) != 'undefined') {
        if (document.getElementById("divGroupSelectionEnabledCheckBox") != null)
            document.getElementById("divGroupSelectionEnabledCheckBox").style.visibility = 'hidden';
    }

    checkEnableMultiSelectByDefaultForQueue ="<%=_StrEnableMultiSelectForQueueByDefault%>";

    //For Localization

    strSaveLayout ="<%=_SaveLayout%>";
    strDeleteLayout ="<%=_DeleteLayout%>";
    strReassignWorkitem ="<%=_ReassignWorkItem%>";
    strDelegateWorkitem ="<%=_DelegateWorkitem%>";
    strSetPriority ="<%=_SetPriority%>";
    strHigh ="<%=_High%>";
    strMedium ="<%=_Medium%>";
    strLow ="<%=_Low%>";
    strAccessErrMsg ="<%=_strAccessErrMessage%>";
    strEnterViewName ="<%=_StrEnterView%>";

    strPick ="<%=_StrPick%>";
    strPlan ="<%=_StrPlan%>";
    strAllocateQueue ="<%=_StrAllocateQueue%>";
    strRecallItem ="<%=_StrRecallItems%>";

    strSelectallwithingroup ="<%=_StrSelectallwithingroup%>";
    strUnSelectallwithingroup ="<%=_StrUnSelectallwithingroup%>";

    strNoCheckBoxSelected ="<%=_StrNoCheckBoxesSelected%>";

    strAllowRowDoubleClick ="<%=_ShowDetailsonRowDoubleClick%>";
    strMultiSelectInCenter ="<%=_ShowMultiSelectWindowInCenter%>";
    strShowDetailViewWithMultiSelect ="<%=_ShowDetailViewInMultiSelect%>";


    strEnableMoveNextPreviousWorkitem ="<%=_EnableMoveNextPreviousWorkitem%>";
    strAutoMoveNextWorkItem ="<%=_EnableAutoMoveNextWorkItem%>";

    strInvalidWorkItem ="<%=_StrInvalidWorkitem%>";

    strNoQueueView ="<%=_StrNoQueueView%>";

    //For Queue detail view

    strQueueDetailView ="<%=_StrQueueDetailView%>";
    strSelectallSameType ="<%=_StrSelectallsametype%>";
    strUnselectallSameType ="<%=_StrUnSelectallsametype%>";

    strSelectRow ="<%=_StrSelectRow%>";

    strMultiSelectTry ="<%=_StrMultiSelectTry%>";
    strMultiSelectDiffActTypes ="<%=_StrMultiSelectDiffActTypes%>";
    strMultiSelectInforInfoPath ="<%=_StrMultiSelectInforInfoPath%>";

    strMultiSelectInvFormNotSet ="<%=_StrMultiSelectInvFormNotSet%>";
    strMultiSelectInvFormDiffForms ="<%=_StrMultiSelectInvFormDiffForms%>";
    strMultiSelectEnterComments ="<%=_StrMultiSelectEnterComments%>";
    strMultiSelectTryThis ="<%=_StrMultiSelectTryThis%>";
    strTurnOnOffQueuePickMessage ="<%=_TurnOnOffQueuePickMessage%>";

    strbtnPick ="<%=checkPickRights%>";
    strbtnPlan ="<%= checkPlanRights%>";
    strbtnAllocate ="<%= checkAllocateQueueRights%>";
    strbtnRecall ="<%= checkRecallAllocateRights%>";
    strbtnReassign ="<%= checkReassignQueueRights%>";

    strInvalidActivity ="<%=_StrInvalidActivity%>";

    strMultiSelectQueue ="<%=queueTitleForBellyBar%>";
    strQueueViewTitle ="<%=queueTitleViewForBellyBar%>";
    strWorkItemTitle ="<%=workItemTitleForBellyBar%>";
    strLayoutViewNameEmpty ="<%=viewNameEmpty%>";
    strLayoutViewNameExceedLimit = "<%=viewNameExceededLimit%>";
    strThemeDirectoryPath = "<%=_ThemeDirectory%>";
    //method called to open AddtoPackage window
    function ShowPackageWindow(applicationName, actorId) {
        var url = "../../Package/PackageList.aspx?&mode=Inbox&AppName=" + applicationName + "&ActorId=" + actorId;
        var oWindow = radopen(url, null);
        //    oWindow.SetModal(true);
        //    oWindow.SetTitle("WorkItem Layout");
        //    oWindow.SetSize(590, 520);

    }

    //Function for handling multiple inbox webparts placed in the same page
    function CollapsePane<%=Radsplitbar1.ClientID%>Function()//CollapsePane()
    {
        try {            
            var splitter = $find("<%= Radsplitbar1.ClientID %>");
            var pane = splitter.getPaneById("<%= Radpane1.ClientID %>");
            

            var wi = pane.get_width();
            pane.set_width(0);

            var pane1 = splitter.getPaneById("<%=Radpane2.ClientID%>");
            var wi1 = pane1.get_width();

            var wi2 = wi1 + wi;
            pane1.set_width(wi2);
            pane.collapse();
            pane.lock();
        } catch (e) {
        }
    }
</script>
