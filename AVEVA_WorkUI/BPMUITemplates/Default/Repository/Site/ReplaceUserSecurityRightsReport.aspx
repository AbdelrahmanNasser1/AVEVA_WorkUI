<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.ReplaceUser.BPMUITemplates_Default_Repository_Site_ReplaceUserSecurityRightsReport" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Replace User Reports</title>
    <style>
        html, body
        {
            height:100%;
            overflow-y:hidden;
        }

    </style>
</head>
<body>
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
     <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=bellyBarCss %>CommonUXControls/StyleSheet/se.ui.min.css" />  
    <link href="<%=bellyBarCss%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css" rel="stylesheet" type="text/css" />
    <link href="<%=bellyBarCss%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css" rel="stylesheet" type="text/css" />
    <script>
        // Initialize locales for message dialog
        se.ui.messageDialog.setGlobalOptions({
            localization: { // All localization related default can be set
                closeButtonCaption: "<%=skrm.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                okButtonCaption: "<%=skrm.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                cancelButtonCaption: "<%=skrm.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                showDetailsCaption: "<%=skrm.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                hideDetailsCaption: "<%=skrm.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
            }
        });
    </script>
    <form id="form1" runat="server" style="height:100%;"> 
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server" />
        <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
        <link href="<%=themePath%>/Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" /> 
        <table style="height:35%;width:98%;margin:0px auto;border-collapse:collapse;border-spacing:0px;">
            <tr>
                <td style="width:100%;" colspan="2">
                    <img src="<%=themePath%>Repository/Site/Images/MenuIcons/icon-replace-user.gif" style="vertical-align: baseline" />
                    <span class="subtitle">
                        <%=securityDescription %>
                    </span>
                    <br />
                    <span class="description">
                        <%=securityDescriptionText %>
                    </span>
                </td>
            </tr>
            <tr>
                <td style="text-align:center;width:100%" colspan="2">
                    <asp:Label CssClass="errormsg" ID="lblErrorMsg" runat="server" Visible="false"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="width:100%;text-align:center;" colspan="2">
                    <table style="margin:0px auto;width:100%;">
                        <tr>
                            <td style="text-align:left;width:50%;">
                                <span class="descriptionbold">
                                    <%=displayUserToBeReplaced%></span><span id="spUserToBeReplaced" class="description"
                                        runat="server"></span>&nbsp;
                            </td>
                            <td style="text-align:left;width:50%;">
                                <span class="descriptionbold">
                                    <%=displayAlternateUser%></span> <span id="spAlternateUserName" runat="server" class="description">
                                    </span>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="text-align:center;width:100%;" colspan="2">
                    <table style="margin:0px auto;width:100%;">
                        <tr>
                            <td style="text-align:left;" colspan="2">
                                <asp:Panel ID="chkListPanel" runat="server" Visible="true">
                                    <span id="spSelectList" runat="server" class="description"></span>
                                    <telerik:RadComboBox ID="RadComboBoxToShowListNames" AutoPostBack="true" runat="server" Skin="AWTCombobox" Height="200" 
                                        RenderMode="Classic" EnableEmbeddedSkins="false" HighlightTemplatedItems="true" Text="Select" >                                      
                                    </telerik:RadComboBox>
                                </asp:Panel>
                            </td>
                        </tr>
                    </table>
                    </td>
            </tr>
        </table>
        <table style="height:40%;table-layout: fixed;margin:0px auto;border-spacing:1px;border-collapse:separate;width:98%">
            <tr>
                <td id="tdWebgridId" runat="server" style="width:100%;vertical-align:top;" colspan="2" >
                    <ISWebGrid:WebGrid ID="WebGrid1" runat="server" Height="100%" Width="100%" HorizontalAlign="NotSet"
                        AllowAutoDataCaching="false" ViewStateStorage="None" DataCacheStorage="PageCache"
                        OnInitializeDataSource="WebGrid1_InitializeDataSource" OnInitializeLayout="WebGrid1_InitializeLayout"
                        OnPrepareDataBinding="WebGrid1_PrepareDataBinding" DisableFileSystemChecking="true"
                        OnInitializeRow="WebGrid1_InitializeRow" EnableWebResources="never">
                        <LayoutSettings AlwaysShowHelpButton="false" PagingMode="VirtualLoad" VirtualLoadMode="LargeData"
                            VirtualPageSize="20" CellClickAction="RowSelect" UseRelativePositioning="true"
                            AllowFilter="Yes" FilterBarVisible="false" PersistRowChecker="True" AlternatingColors="False"
                            GridLineStyle="Solid" GridLineColor="#afafaf" CellPaddingDefault="2" RowHeightDefault="20px"
                            GridLines="None" AutoFitColumns="true" AllowAddNew="No" AllowColumnMove="Yes" RowHeaders="No">
                            <HeaderStyle Wrap="false" Overflow="hidden" OverflowX="hidden" OverflowY="hidden"
                                CssClass="GridHeaderStyle" CustomRules="border-bottom: #73A1E4 1px solid"></HeaderStyle>
                            <FocusCellStyle BorderWidth="1px" BorderStyle="Solid" BorderColor="0, 45, 150"></FocusCellStyle>
                            <StatusBarCommandStyle>
                                <Active BaseStyle="Over" BackColor="RoyalBlue">
                                </Active>
                                <Over BorderStyle="Solid" BorderWidth="1px" BorderColor="#002D96" BackColor="#FBE9B8">
                                </Over>
                                <Normal>
                                    <Padding Top="1px" Left="1px" Bottom="1px" Right="1px"></Padding>
                                </Normal>
                            </StatusBarCommandStyle>
                            <GroupRowInfoStyle CssClass="GridGroupRowInfoStyle" BackgroundImage="Images/grid-title-bg1.png">
                            </GroupRowInfoStyle>
                            <%--<GroupByBox>
                                <LabelStyle CssClass="LeftMenuLabelStyle"></LabelStyle>                               
                            </GroupByBox>--%>
                            <EditTextboxStyle CssClass="LeftMenuEditStyle">
                            </EditTextboxStyle>
                            <FrameStyle GradientType="Vertical" CssClass="GridFrameStyle">
                            </FrameStyle>
                            <SelectedRowStyle CssClass="GridSelectedRowStyle"></SelectedRowStyle>
                            <AlternatingRowStyle CssClass="GridAlternatingRowStyle" OverflowX="hidden" OverflowY="hidden"
                                CustomRules="text-overflow: ellipsis; overflow-x: hidden"></AlternatingRowStyle>
                            <StatusBarStyle CssClass="GridStatusBarStyle" ForeColor="#15428B">
                                <Padding Top="2px" Left="2px" Bottom="2px" Right="2px"></Padding>
                            </StatusBarStyle>
                            <RowStyle CssClass="GridRowStyle" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden">
                            </RowStyle>
                            <NewRowStyle ForeColor="DarkGray" CssClass="GridNewRowStyle">
                            </NewRowStyle>
                            <EditFocusCellStyle BackColor="#E9CD82">
                            </EditFocusCellStyle>
                            <ClientSideEvents OnRowContextMenu="DisableContextMenu" />
                            <TextSettings Language="UseCulture">
                            </TextSettings>
                            <LostFocusRowStyle CssClass="GridLostFocusRowStyle">
                            </LostFocusRowStyle>
                        </LayoutSettings>
                        <RootTable GridLineStyle="NotSet" TableHeaderVisible="false" Caption="Open Items">
                            <TableHeaderStyle GradientType="Vertical" CssClass="GridTableHeaderStyle" ForeColor="#15428B"
                                BackgroundImage="Images/top-bg-green.png">
                                <Padding Bottom="4px" Left="4px" Top="4px" Right="4px"></Padding>
                            </TableHeaderStyle>
                        </RootTable>
                    </ISWebGrid:WebGrid>                    
                </td>
            </tr>
        </table>
        <table style="height:8%;margin:0px auto;width:100%;">
            <tr>
                <td style="text-align:right;vertical-align:bottom;width:100%;padding-right:5px;" colspan="2">
                    <asp:Button ID="btnReplace" OnClientClick="javascript:CheckSelected();return false;" runat="server"
                        CssClass="inputbutton" Width="20%" />
                    <asp:Button ID="Button1" runat="server" style="display:none;"/>
                </td>
            </tr>
            
        </table>   
        <input id ="hdnReplaceLoggedInConfirm" type="hidden" value="<%=skrm.GlobalResourceSet.GetString("sk_replaceuser_confirm_replaceloggedinuser")%>" />
        <input ID="hdnAlertConfirmation" type="hidden"  value="<%=skrm.GlobalResourceSet.GetString("sk_replaceuser_alertconfirmation")%>"/>
    
    </form>
</body>
</html>

<script type="text/javascript" language="javascript">
    //RefreshGrid();
    function CheckSelected() {
        var grid = ISGetObject("WebGrid1");
        var getTotal = grid.TotalRows;
        if (getTotal > 0) {
            var checkRows = grid.RootTable.GetCheckedRows();
            if (checkRows == '') {
                se.ui.messageDialog.showError("<%=skrm.GlobalResourceSet.GetString("sk_replaceuser_title") %>", "<%=checkEmptyMsg %>");
                return false;
            }
        }
        else {
            se.ui.messageDialog.showError("<%=skrm.GlobalResourceSet.GetString("sk_replaceuser_title") %>", "<%=noRowsAvailable %>");
            return false;
        }
        return confirmationAlert();//confirmation message
    }

    function RefreshGrid() {
        try {
            var i = GetMOZBrowserversion();
            if (i == 1) {
                var grid = ISGetObject("WebGrid1");
                grid.RefreshAll(); //do not use Refresh() as it is failing in IE7
            }
            else
                window.location.href = window.location.href;
            //window.opener.location.href = window.opener.location.href;

            //using timeout to adjust the grid height
            //window.setTimeout(ReSizeQueueGrid, 400);
            window.setTimeout(function() { grid.RefreshAll(); }, 2);
        }
        catch (e) { }

    }
    // If Mozila it should refresh the grids, to avoid Communication error
    function GetMOZBrowserversion() {        
        var app = navigator.userAgent;
        if (app.indexOf("MSIE") > -1) {
            return 1;
        }
        else if (app.indexOf("Firefox/1.5") > -1) {
            return 2;
        }
        else {
            return 3;
        }
    }

    function confirmationAlert() {
        var confirmation;
        confirmation = document.getElementById("hdnAlertConfirmation");

        if (("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(loggedInUser, false)%>").toLowerCase() == ("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(username, false)%>").toLowerCase()) {
            se.ui.messageDialog.showConfirmation("<%=skrm.GlobalResourceSet.GetString("sk_replaceuser_title") %>", document.getElementById('hdnReplaceLoggedInConfirm').value, function (userResponse)
            {
                if (userResponse)
                {
                    document.getElementById("Button1").click();
                }

            });
        }       

        se.ui.messageDialog.showConfirmation("<%=skrm.GlobalResourceSet.GetString("sk_replaceuser_title") %>", confirmation.value, function (canProceed)
        {
            if (canProceed)
            {
                document.getElementById("Button1").click();
            }

        });
    }
    SetGridHeight();
    function SetGridHeight() {
        

        if (navigator.userAgent.toLowerCase().indexOf('chrome') > 0 || navigator.userAgent.toLowerCase().indexOf('firefox') > 0) {
            var grid = ISGetObject("WebGrid1");
            grid.SetHeight("250px");
            window.setTimeout(function () { wgDoResize(true, true); }, 500);

        }
            
    }
    
</script>

