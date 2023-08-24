<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Package.CodeBehind.GeneratePackageTemplate" %>

<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>
<!DOCTYPE html>
<html style="height: 100%">
<head runat="server">
    <title><%= resourceManager.GlobalResourceSet.GetString("pkg_gen_title")%></title>
    <script type="text/javascript" src="../Common/JavaScripts/jquery.min.js"></script>
    <script type="text/javascript" src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <script type="text/javascript" src="../Common/JavaScripts/AutoLogoff.js"></script>
    <script type="text/javascript" src="../Common/JavaScripts/spin.min.js"></script>
    <script type="text/javascript" src="../NextGenForms/js/knockout.min.js"></script>
    <script type="text/javascript" src="../NextGenForms/js/xml2json.min.js"></script>
    <script type="text/javascript" src="../NextGenForms/app/Skelta.min.js"></script>
    <script type="text/javascript" src="../NextGenForms/js/kendo.all.min.js"></script>
    <link rel="stylesheet" href="../NextGenForms/css/SkeltaForms.min.css" />

    <style type="text/css">
        .hideElement {
            display: none;
        }
    </style>

</head>
<script type="text/javascript">
    skelta.serverUrl = "../NextGenForms/";     
    function closeBellyWindow()
    {        
        var oWindow = GetRadWindow();        
        if (oWindow !=null && oWindow.IsClosed() == false) {
            window.parent.onclientCalled = false;
            window.parent.OnClientClose(oWindow);
            setTimeout(function () {
                oWindow.close();
                oWindow.hide();
            }, 0);
            window.parent.onclientCalled = null;
        }
    }

    function HidePadColumn(gridId)
    {
        var grid = ISGetObject(gridId);
        grid.HidePadColumn = true;
        setTimeout(function () { grid.Refresh(); }, 600);
    }

    var closewindowGlobal = "0";
    function GetRadWindow()
    {
        var oWindow = null;
        if (window.frameElement != null)
            oWindow = window.frameElement.radWindow;
        return oWindow;
    }

    function closeWindow()
    {        
        var oWindow = GetRadWindow();
        setTimeout(function () {
            oWindow.close();
            oWindow.hide();
        }, 0);        
        closewindowGlobal = "1";
    }

    function ChangeWindowSize()
    {
        var oWindow = GetRadWindow();        
        if (oWindow.isClosed() == false) {
            oWindow.setSize(820, 600);
            oWindow.center();
        }
    }

    function ChangeMissingFilesWindowSize()
    {
        var oWindow = GetRadWindow();        
        if (oWindow.isClosed() == false) {
            oWindow.setSize(820, 600);
            oWindow.center();
        }
    }

    function resizeWindow()
    {
        var oWindow = GetRadWindow();
        if (oWindow.isClosed() == false) {
            oWindow.setSize(820, 600);
            oWindow.center();
        }
    }

    function DisableDefaultContextMenuItems(gridId, rowType, rowEl, rowMenu)
    {
        if (rowType != "Record")
        {

            if (rowType == "FilterRow")
            {
                rowMenu.Items.GetNamedItem("mnuHelp").Hide();
            }

            return true;
        }
        var i;
        var grid = wgGetGridById(gridId);
        if (rowType == "Record")
        {
            // hide the default context menu
            for (i = 0; i <= 43; i++)
            {
                //rowMenu.Items[i].visible = false;
                rowMenu.Items[i].Hide();

            }

        }
    }

    function OpenGenerateWindow(path)
    {        
        var oBrowserWnd = GetRadWindow().BrowserWindow;
        var oWindow = oBrowserWnd.radopen(path, "NewWindow");
        oWindow.setActive(true);
        oWindow.set_modal(true);
        oWindow.center();
    }

    // Initialize locales for message dialog
    se.ui.messageDialog.setGlobalOptions({
        localization: { // All localization related default can be set
            closeButtonCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
            okButtonCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
            cancelButtonCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
            showDetailsCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
            hideDetailsCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
        }
    });

    function showMessageAndClose(messageType, message)
    {        
        var pageTitle = '<%=resourceManager.GlobalResourceSet.GetString("pkg_gen_title") %>',
            self = window;
        var oWindow = GetRadWindow();
        switch (messageType)
        {
            case "Error":
                se.ui.messageDialog.showError(pageTitle, message, closeHandlerFn);
                if (oWindow != null)
                {
                    setTimeout(function () {
                        oWindow.close();
                    }, 0);
                }
                break;
            case "Message":
                se.ui.messageDialog.showAlert(pageTitle, message, closeHandlerFn);
                if (oWindow != null)
                {
                    setTimeout(function () {
                        oWindow.close();
                    }, 0);
                }
                break;
            case "Others":
                if (oWindow != null)
                {
                    oWindow.setSize(820, 600);                    
                    oWindow.show();
                    oWindow.center();
                }
                break;
            default:
                // Only if it is a radWindow, show it
                if (oWindow != null)
                {
                    oWindow.setSize(820, 600);                    
                    oWindow.show();
                    oWindow.center();
                }
                break;
        }
    }

    function closeHandlerFn()
    {
        self.closeBellyWindow(false);
    }

    function ShowProgress()
    {       
        var spinnerObj = new Spinner().spin();
        spinnerObj.el.style.top = "50%";
        spinnerObj.el.style.left = "50%";
        $("#skloader")[0].appendChild(spinnerObj.el);
        $('#skloader').attr("data-skloader", "1");
    }

    showMessageAndClose('<%=this.BellyBarMessageObj.DialogType.ToString() %>', '<%=this.BellyBarMessageObj.Message %>');

</script>
<body id="Body" style="margin: 0; left: 0; overflow: hidden; height: 100%; overflow: auto">

    <div id="skloader" class="skloader" data-skloader="0" style="height: 100%; width: 100%; position: absolute;"></div>
    <form id="Form1" method="post" runat="server" style="height: 100%">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <asp:Button ID="btnProgress" runat="server" Text="Show Progress" Style="display: none;" OnClientClick="ShowProgress(); return true;" OnClick="Progress_Click" />
        <script> 
            function click()
            {              
                setTimeout(function ()
                {
                    document.getElementById("btnProgress").click();
                }, 100);
            }

            function HideProgress()
            {
                setTimeout(function ()
                {
                    $('#skloader').attr("data-skloader", "0");
                }, 0);

            }
        </script>
        <link href="<%=themePath%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
        <link href="<%=themePath%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
        <%if (hasPackageLog) { %>
                <table id="pageHeaderTable" style="width: 94%; border-width: 0; margin: auto" runat="server">
                    <tr>
                        <td class="pagetitle" colspan="4" style="white-space: nowrap">
                            <img src="<%=themePath%>/Repository/ListControl/images/icon-package-generate.png" alt="" style="vertical-align: middle" />
                            <span class="pagetitle">
                                <%= resourceManager.GlobalResourceSet.GetString("pkg_gen_title")%>  
                            </span>
                        </td>
                        <td class="description" style="text-align: right">
                            <%=packageTitle%><%=packageVersion%>
                        </td>
                    </tr>
                    <tr>
                        <td class="description" style="padding-left: 5%;" colspan="5">
                            <%= resourceManager.GlobalResourceSet.GetString("pkg_gen_desc1")%> <%=generateDescription%>
                        </td>
                    </tr>
                </table>
        <%}%>
        <table id="ErrorDetailsViewTable" style="width: 94%; border-width: 0; border-spacing: 1px; border-collapse: separate; margin: auto; vertical-align: top" runat="server">
            <tr>
                <td style="text-align: left;" colspan="2">
                    <asp:Label ID="generateMessage" runat="server" Text="" CssClass="description"></asp:Label>

                </td>
            </tr>
        </table>
        <div id="ErrorDetailsGridContainer" runat="server" style="width: 95%; height: 70%; vertical-align: top; padding-left: 2%; margin: 0 auto;">
            <ISWebGrid:WebGrid ID="errorDetailsView" runat="server" HorizontalAlign="NotSet"
                Width="100%" Height="100%" AllowAutoDataCaching="false" ViewStateStorage="None" DisableFileSystemChecking="true" EnableWebResources="Never">
                <LayoutSettings AllowFilter="yes" FilterBarVisible="false"
                    GridLineColor="#afafaf"
                    CellPaddingDefault="2"
                    RowHeightDefault="22px"
                    RowHeaders="No"
                    GridLines="None"
                    StatusBarVisible="True"
                    NewRowLostFocusAction="AlwaysPrompt"
                    RowLostFocusAction="AlwaysPrompt"
                    PagingMode="VirtualLoad" VirtualPageSize="50"
                    PromptBeforeDelete="true"
                    AutoFitColumns="True" ShowRefreshButton="true" AllowExport="Yes" AlwaysShowHelpButton="false" AllowSorting="yes" AllowColumnSizing="Yes">
                    <HeaderStyle Wrap="false" Height="20px" Overflow="hidden" OverflowX="hidden" OverflowY="hidden"
                        CssClass="GridHeaderStyle"></HeaderStyle>
                    <FocusCellStyle CssClass="GridFocusCellStyle"></FocusCellStyle>
                    <FrameStyle CssClass="GridFrameStyle"></FrameStyle>
                    <AlternatingRowStyle CssClass="GridAlternatingRowStyle" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden" />
                    <SelectedRowStyle CssClass="GridSelectedRowStyle"></SelectedRowStyle>
                    <LostFocusRowStyle CssClass="LostFocusRowStyle"></LostFocusRowStyle>

                    <StatusBarStyle CssClass="GridStatusBarStyle">
                        <Padding Top="0px" Left="0px" Bottom="0px" Right="0px"></Padding>
                    </StatusBarStyle>
                    <StatusBarCommandStyle Active-CssClass="GridStatusBarStyle" Normal-CssClass="GridStatusBarStyle" Over-CssClass="GridStatusBarStyle">
                    </StatusBarCommandStyle>
                    <RowStyle CssClass="GridRowStyle" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden"></RowStyle>
                    <NewRowStyle CssClass="GridNewRowStyle" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden"></NewRowStyle>
                    <EditFocusCellStyle CssClass="GridEditFocusCellStyle"></EditFocusCellStyle>
                    <ClientSideEvents OnButtonClick="LogButtonClickHandler" OnRowContextMenu="DisableDefaultContextMenuItems" OnInitialize="HidePadColumn" />
                    <TextSettings Language="UseCulture"></TextSettings>
                    <HyperlinkStyle CssClass="GridHyperlinkStyle" />
                </LayoutSettings>
                <RootTable GridLineStyle="NotSet">
                </RootTable>
            </ISWebGrid:WebGrid>
        </div>
        <table id="MissingFilesDetailsViewTable" style="width: 94%; border-width: 0; margin: auto" runat="server">
            <tr>
                <td class="description" style="padding-left: 5%; padding-bottom: 10px; padding-top: 10px;">
                    <asp:Label ID="generateFilesMessage" runat="server" Text="" CssClass="successfulmsg"></asp:Label>
                </td>
            </tr>
        </table>
        <div id="MissingFilesDetailsGridContainer" runat="server" style="width: 95%; height: 70%; margin: 0 auto;">
            <ISWebGrid:WebGrid ID="filesView" runat="server" HorizontalAlign="NotSet"
                Width="100%" Height="100%" AllowAutoDataCaching="false" ViewStateStorage="None" DisableFileSystemChecking="true" EnableWebResources="Never">
                <LayoutSettings AllowFilter="yes" FilterBarVisible="false"
                    GridLineColor="#afafaf"
                    CellPaddingDefault="2"
                    RowHeightDefault="22px"
                    RowHeaders="No"
                    GridLines="None"
                    StatusBarVisible="True"
                    NewRowLostFocusAction="AlwaysPrompt"
                    RowLostFocusAction="AlwaysPrompt"
                    PagingMode="VirtualLoad" VirtualPageSize="50"
                    PromptBeforeDelete="true"
                    AutoFitColumns="True" ShowRefreshButton="true" AllowExport="Yes" AlwaysShowHelpButton="false" AllowSorting="yes" AllowColumnSizing="Yes">
                    <HeaderStyle Wrap="false" Height="20px" Overflow="hidden" OverflowX="hidden" OverflowY="hidden"
                        CssClass="GridHeaderStyle"></HeaderStyle>
                    <FocusCellStyle CssClass="GridFocusCellStyle"></FocusCellStyle>
                    <FrameStyle CssClass="GridFrameStyle"></FrameStyle>
                    <AlternatingRowStyle CssClass="GridAlternatingRowStyle" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden" />
                    <SelectedRowStyle CssClass="GridSelectedRowStyle"></SelectedRowStyle>
                    <LostFocusRowStyle CssClass="LostFocusRowStyle"></LostFocusRowStyle>

                    <StatusBarStyle CssClass="GridStatusBarStyle">
                        <Padding Top="0px" Left="0px" Bottom="0px" Right="0px"></Padding>
                    </StatusBarStyle>
                    <StatusBarCommandStyle Active-CssClass="GridStatusBarStyle" Normal-CssClass="GridStatusBarStyle" Over-CssClass="GridStatusBarStyle">
                    </StatusBarCommandStyle>
                    <RowStyle CssClass="GridRowStyle" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden"></RowStyle>
                    <NewRowStyle CssClass="GridNewRowStyle" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden"></NewRowStyle>
                    <EditFocusCellStyle CssClass="GridEditFocusCellStyle"></EditFocusCellStyle>
                    <ClientSideEvents OnButtonClick="LogButtonClickHandler" OnRowContextMenu="DisableDefaultContextMenuItems" OnInitialize="HidePadColumn" />
                    <TextSettings Language="UseCulture"></TextSettings>
                    <HyperlinkStyle CssClass="GridHyperlinkStyle" />
                </LayoutSettings>
                <RootTable GridLineStyle="NotSet">
                </RootTable>
            </ISWebGrid:WebGrid>
            <br />
        </div>
        <table id="publishMessageTable" style="border-spacing: 1px; width: 95%; margin: auto; border-width: 0">
            <tr>
                <td>
                    <br />
                </td>
            </tr>
            <tr id="buttonRow" runat="server" style="vertical-align: top">
                <td style="text-align: right; padding: 2px" id="buttonOkColoum" runat="server">
                    <input id="btnClose" runat="server" type="button" onclick="javascript: closeWindow();" class="skbtn" data-skbtn="cancel" />
                    <asp:Button ID="btnOk" runat="server" CssClass="inputbutton" OnClientClick="ShowProgress(); return true;" />
                    <input id="btnClose2" value="Close" runat="server" type="button" onclick="javascript: closeWindow();" class="inputbutton" />
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
