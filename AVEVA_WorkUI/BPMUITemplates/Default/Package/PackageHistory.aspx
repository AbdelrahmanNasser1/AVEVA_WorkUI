<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Package.CodeBehind.PackageHistory" %>

<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ Register TagPrefix="cc2" Namespace="Workflow.NET.Ajax" Assembly="Workflow.NET.NET2" %>
<!DOCTYPE html>
<html style="height: 100%">

<head id="Head1" runat="server">
    <title><%=pageHeader%></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>

    <style type="text/css">
        .displayNone {
            display: none;
        }

        .buttonMarging {
            margin-right: 5px;
        }

        tbody > tr[type="Record"] > td[type="Cell"]:first-of-type {
            padding-left: 10px !important;
        }
    </style>
</head>
<script type="text/javascript">
    var title = '<%=pageHeader%>';
    function HidePadColumn(gridId)
    {
        var grid = ISGetObject(gridId);
        grid.HidePadColumn = true;
    }

    function GetRadWindow() {
        var oWindow = null; if (window.radWindow)
            oWindow = window.radWindow; else if (window.frameElement.radWindow)
            oWindow = window.frameElement.radWindow; return oWindow;
    }

    function closeBellyWindow()
    {
        var oWindow = GetRadWindow();
        window.parent.onclientCalled = false;
        window.parent.OnClientClose(oWindow);
        oWindow.close();
        window.parent.onclientCalled = null;
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
        var pageTitle = title,
            self = window;
        var oWindow = GetRadWindow();
        switch (messageType)
        {
            case "Error":
                se.ui.messageDialog.showError(pageTitle, message, closeHandlerFn);
                break;
            case "Message":
                se.ui.messageDialog.showAlert(pageTitle, message, closeHandlerFn);
                break;
            case "Confirmation":
                se.ui.messageDialog.showConfirmation(pageTitle,
                    message,
                    function (userResponse)
                    {
                        if (userResponse)
                        {
                            window.setTimeout(closeHandlerFn, 100);
                        }
                    });

                break;
            default:
                // Only if it is a radWindow, show it
                break;
        }

        function closeHandlerFn()
        {
            if (timercallback)
            {
                window.clearInterval(timercallback);
            }

            self.closeBellyWindow(false);
        }
    }

    function clearButtonJs()
    {
        var msg = '<%=resourceManager.GlobalResourceSet.GetString("pkg_clear_conf")%>';

        var btn = document.getElementById('buttonHidden');
        se.ui.messageDialog.showConfirmation(title,
            msg, function (val)
            {
                if (val)
                {
                    btn.click();
                }
            });

        return false;
    }
    function clearButtonEnableDisable(disable)
    {
        var clearButton = document.getElementById('btnClear');
        clearButton.disabled = disable;
    }
</script>
<style>
    #myProgress {
        position: relative;
        width: 200px;
        height: 26px;
        background-color: #e0e1dd;
        border-color: #e0e1dd;
        border: medium;
    }

    #myBar {
        position: relative;
        width: 0px;
        height: 26px;
        background-color: #4CAF50;
    }

    #label {
        text-align: center; /* If you want to center it */
        vertical-align: central;
        line-height: 26px; /* Set the line-height to the same as the height of the progress bar container, to center it vertically */
    }

    .not-active {
        pointer-events: none;
        cursor: default;
    }
</style>
<body id="Body" style="margin: 0; left: 0; overflow: auto; height: 100%" onload="onFormLoad();">
    <form id="Form1" method="post" runat="server" style="height: 100%">
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
            <%=System.Web.Helpers.AntiForgery.GetHtml()%>
            <link href="<%=themePath%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
            <link href="<%=themePath%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
            <link rel="stylesheet" type="text/css" href="<%:themePath%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
            <link rel="stylesheet" type="text/css" href="<%:themePath%>TelerikAjax/StyleSheet/AWTWindow/Window.css">
        </telerik:RadScriptBlock>
        <div style="height: 100%">
            <table id="PageHeaderTable" style="width: 98%; border-width: 0; margin: auto;" runat="server">
                <tr>
                    <td class="pagetitle" style="padding: 5px; padding-top: 12px; padding-left: 0.2%;">
                        <div style="height: 20px;">
                            <div style="position: absolute; float: left;">
                                <img src="<%=themePath%>/Repository/ListControl/images/icon-package-history.png" alt="" style="vertical-align: middle;" />
                            </div>
                            <div id="HeadDiv" style="position: absolute; float: left; padding-left: 2.8%;" class="pagetitle"><%= pageTitle%></div>
                            <div class="description" style="float: right; padding-right: 2%"><%= resourceManager.GlobalResourceSet.GetString("ec_list_name_Package Template")%>: <%=packageTitle%><%=packageVersion%></div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="description" style="text-align: left; padding-left: 2.8%; padding-bottom: 10px;" id="tdDescription">
                        <%= resourceManager.GlobalResourceSet.GetString("pkg_hstry_desc")%></td>
                    <td class="description" style="text-align: left; vertical-align: central; padding-left: 2.8%; padding-bottom: 10px; display: none" id="tdSuccess">
                        <%= successMessage%></td>
                    <td class="description" id="tdProgress" style="padding-left: 2.8%; text-align: left; display: none"></td>
                    <td style="padding-left: 2.8%; display: none" id="tdProgressbar">
                        <table width="100%" border="0" style="vertical-align: central;">
                            <tr>
                                <td id="tdProgress1" class="description" style="vertical-align: central; width: 18%"><span id="totalCount" class="description" style="vertical-align: central; text-align: center;"><%=packageProgressText%></span></td>
                                <td style="float: left;" id="myProgress">
                                    <div id="myBar">
                                        <div style="text-align: center; width: 200px;" id="label" class="description">0%</div>
                                    </div>
                                </td>
                    </td>
                </tr>
            </table>

            </td>                   
                </tr>
             
            </table>
            <div style="height: 80%; width: 95%; vertical-align: top; padding-left: 2%; margin: 0 auto;">
                <ISWebGrid:WebGrid ID="packageHistoryLogs" TabIndex="-1" runat="server" HorizontalAlign="NotSet"
                    AllowAutoDataCaching="false" Width="100%" Height="100%" DisableFileSystemChecking="true"
                    EnableWebResources="never" OnInitializeRow="PackageHistoryLogs_InitializeRow">
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
                        <ClientSideEvents OnAfterResponseProcess="onRefreshCompleted" OnInitialize="HidePadColumn" OnRowContextMenu="DisableDefaultContextMenuItems" />
                        <TextSettings Language="UseCulture"></TextSettings>
                        <HyperlinkStyle CssClass="GridHyperlinkStyle" />
                    </LayoutSettings>
                    <RootTable GridLineStyle="NotSet">
                    </RootTable>
                </ISWebGrid:WebGrid>
            </div>
            <table id="Table1" style="border-spacing: 0px; width: 93%; border-width: 0; margin: auto">
                <tr>
                    <td>&nbsp;</td>
                </tr>

                <tr>
                    <td style="bottom: 20px; left: 3.1%; position: absolute;">
                        <table>
                            <tr>
                                <td>
                                    <img src="<%=themePath%>Common/Images/icon-errors.png" onclick="Javascript:ShowMessageType('ERROR');" alt="" /></td>
                                <td class="description" style="vertical-align: middle"><a class="textlinkblacknormal" onclick="Javascript:ShowMessageType('ERROR');" href="#"><span id="errorCount" class="description" style="vertical-align: top"><%=errorCount%></span></a>&nbsp;<a class="GridHyperlinkStyle" onclick="Javascript:ShowMessageType('ERROR');" href="#" style="vertical-align: top"><%= resourceManager.GlobalResourceSet.GetString("pkg_History_Errors")%></a>&nbsp;</td>
                                <td>
                                    <img src="<%=themePath%>Common/Images/icon-warning.png" onclick="Javascript:ShowMessageType('WARNING');" alt="" /></td>
                                <td class="description" style="vertical-align: top"><a class="textlinkblacknormal" onclick="Javascript:ShowMessageType('WARNING');" href="#"><span id="warningCount" class="description"><%=warningCount%></span></a>&nbsp;<a class="GridHyperlinkStyle" onclick="Javascript:ShowMessageType('WARNING');" href="#"><%= resourceManager.GlobalResourceSet.GetString("pkg_History_Warnings")%></a></td>
                                <td>
                                    <img src="<%=themePath%>Common/Images/icon-information.png" onclick="Javascript:ShowMessageType('INFORMATION');" alt="" /></td>
                                <td class="description" style="vertical-align: top"><a class="textlinkblacknormal" onclick="Javascript:ShowMessageType('INFORMATION');" href="#"><span id="informationCount" class="description"><%=informationCount%></span></a>&nbsp;<a class="GridHyperlinkStyle" onclick="Javascript:ShowMessageType('INFORMATION');" href="#"><%= resourceManager.GlobalResourceSet.GetString("pkg_History_Information")%></a></td>
                                <td>
                                    <img src="<%=themePath%>Common/Images/icon-all.png" onclick="Javascript:ShowMessageType('ALL');" alt="" /></td>
                                <td class="description" style="vertical-align: top"><a class="textlinkblacknormal" onclick="Javascript:ShowMessageType('ALL');" href="#"><span id="allCount" class="description"><%=allCount%></span></a>&nbsp;<a class="GridHyperlinkStyle" onclick="Javascript:ShowMessageType('ALL');" href="#"><%= resourceManager.GlobalResourceSet.GetString("RepoProviderSearch_All")%></a></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>

            <div style="bottom: 20px; right: 20px; position: absolute;">
                <input id="btnClose" runat="server" type="button" onclick="javascript: closeWindow();"
                    class="inputsecondarybutton buttonMarging" />
                <asp:Button ID="btnClear" runat="server" CssClass="inputbutton" Enabled="False" />
                <asp:Button ID="buttonHidden" runat="server" CssClass="inputbutton displayNone" OnClick="ButtonClear_Click" />

            </div>
            <input id="hidMsgType" type="hidden" name="hidMsgType" value="<%:messageType%>">
            <input id="hidWaitFlag" type="hidden" name="hidWaitFlag" runat="server" />
            <input id="hidInstallCount" type="hidden" name="hidInstallCount" value="<%:installerCount%>" />
            <cc2:AjaxPageControl ID="ajaxPageControl1" runat="server" Style="z-index: 104; left: 440px; position: absolute; top: 88px"></cc2:AjaxPageControl>
        </div>
        <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
            <script type="text/javascript">
                var closewindowGlobal = "0";
                var showMessageBox = false;
                var isActionCompleted = false;
                var timercallback;
                var artifactInstallerStarted = false;
                var installerFileStarted = false;
                var isGridRefreshCompleted = true;
                var isTimeOut = false;
                var requestType = '<%:Request["type"]%>';
                function closeWindow() {
                    if (timercallback) {
                        window.clearInterval(timercallback);
                    }

                    var oWindow = GetRadWindow();
                    oWindow.close();
                }

                function closeHandlerFn() {
                    if (timercallback) {
                        window.clearInterval(timercallback);
                    }

                    self.closeBellyWindow(false);
                }

                $(window).on("load", function () {
                    window.setTimeout(function () {
                        wgDoResize(true, true);
                    }, 100);


                    if (requestType !== "") {
                        window.setTimeout(function () {
                            autoRefesh();
                        }, 0);
                    }
                });

                function onFormLoad() {
                    var w = screen.availWidth;
                    var h = screen.availHeight;
                    var oWindow = GetRadWindow();
                    w = w * .9;
                    h = h * .8;

                    if (window.parent.location.search != null && window.parent.location.search === '?FromArchestrA=true') {

                    }
                    else {
                        oWindow.setSize(w, h);
                    }

                    oWindow.center();
                    // if page is getting closed then we should not maximize else it will not close the window
                    if (closewindowGlobal === "1") {
                    }
                    else {
                        oWindow.maximize();
                    }
                    setHeight();
                }

                function QueryToSave() {
                    this.SimpleQuery = "";
                    this.CamlQuery = "";
                    this.InstallerCount = document.getElementById('hidInstallCount').value;
                }

                function closeWindow(msg) {
                    var oWindow = GetRadWindow();
                    oWindow.close();
                    if (msg) {
                        se.ui.messageDialog.showAlert(title, msg, null);
                    }
                    closewindowGlobal = "1";
                }

                function autoRefesh() {
                    //auto refresh
                    var queryToSave = new QueryToSave();
                    queryToSave.SimpleQuery = "data";
                    CallServerSideMethod(null, 'SaveQuery', "DataTableTest", CallbackSaveQuery, 'table', queryToSave);
                }

                function CallbackSaveQuery(context, result, response) {
                    var reqType = '<%:Request["type"]%>';
                    var waitFlag = document.getElementById('hidWaitFlag').value;
                    var paramArray = result;
                    var parameters = paramArray[0].split(",");

                    if (reqType && !waitFlag && parameters[0] !== "Completed") {
                        if (timercallback) {
                            window.clearInterval(timercallback);
                        }

                        if (parameters[0] === "RefreshInstaller") {
                            timercallback = window.setInterval(function () {
                                autoRefesh();
                            }, 2000);
                            installerFileStarted = true;
                        }
                        else if (parameters[0] === "RefreshArtifact") {
                            artifactInstallerStarted = true;
                            ResetProgressInterval();
                        }

                        InitalizeProgressbar(parameters);

                        if (parameters[0] === "Completed") {
                            window.setTimeout(function () {
                                autoRefesh()
                            }, 2000);
                        }

                        return;
                    }

                    if (parameters[0] === "Completed" && parseInt(parameters[4]) === 0 && !installerFileStarted) {
                        window.setTimeout(function () {
                            autoRefesh();
                        }, 2000);

                        return;
                    }

                    if (parameters[0] === "Completed" && parseInt(parameters[4]) === 0 && !artifactInstallerStarted) {
                        InitalizeProgressbar(parameters);
                        isGridRefreshCompleted = false;
                        RefreshGrid();
                        window.setTimeout(function () {
                            autoRefesh()
                        }, 1000);
                        return;
                    }

                    if (parameters[0] === "RefreshInstaller") {
                        if (!installerFileStarted) {
                            InitalizeProgressbar(parameters);
                            ResetInstallerFileProgress();
                            installerFileStarted = true;
                        }
                        ActionInProgress(parameters);
                    }
                    else if (parameters[0] === "RefreshArtifact") {
                        if (!artifactInstallerStarted) {
                            InitalizeProgressbar(parameters);
                            ResetProgressInterval();
                            artifactInstallerStarted = true;
                        }
                        ActionInProgress(parameters);
                    }
                    else if (parameters[0] === 'RefreshRemoteInstaller') {
                        if (!remoteInstallerStarted) {
                            InitalizeProgressbar(parameters);
                            ResetInstallerFileProgress();
                            remoteInstallerStarted = true;
                        }
                        ActionInProgress(parameters);
                    }
                    else if (parameters[0] === "Completed") {
                        ProgressCompleted(parameters);
                    }
                }

                function ResetInstallerFileProgress() {
                    window.clearInterval(timercallback);
                    timercallback = window.setInterval(function () {
                        autoRefesh();
                    }, 2000);
                }

                function ResetProgressInterval() {
                    window.clearInterval(timercallback);

                    var totCount = parseInt('<%=artifactCount%>');
                    //// for making timer steady refresh for 2 seconds
                    var interval = totCount * 40;
                    if (interval > 2000) {
                        interval = 2000;
                    }

                    if (interval < 200) {
                        interval = 500;
                    }

                    timercallback = window.setInterval(function () {
                        autoRefesh();
                    }, interval);
                }

                function InitalizeProgressbar(parameters) {
                    var width = 0;
                    if (parseInt(parameters[3]) > 0 && parseInt(parameters[2]) > 0 && parseInt(parameters[3]) > parseInt(parameters[2])) {
                        width = Math.floor((parseInt(parameters[2]) / parseInt(parameters[3])) * 100);
                    }

                    var elem = document.getElementById("myBar");
                    document.getElementById('tdProgress').style.display = "block";
                    document.getElementById('tdProgressbar').style.display = "block";
                    document.getElementById('tdDescription').style.display = "none";
                    document.getElementById("label").innerHTML = width + '%';
                    document.getElementById('hidWaitFlag').value = true;
                    elem.style.width = width + '%';
                }

                function ActionInProgress(parameters) {
                    var elem = document.getElementById("myBar");
                    var msgType = document.getElementById('hidMsgType').value;
                    var width = 0;

                    if (parseInt(parameters[3]) > 0 && parseInt(parameters[3]) > parseInt(parameters[2])) {
                        width = Math.floor((parseInt(parameters[2]) / parseInt(parameters[3])) * 100);
                    }

                    if (parseInt(parameters[3]) > 0 && parseInt(parameters[2]) > 0 && parseInt(parameters[3]) === parseInt(parameters[2])) {
                        width = 100;
                    }

                    if (width > 50) {
                        document.getElementById("label").style.color = "white";
                    }

                    document.getElementById('totalCount').innerHTML = parameters[1];
                    elem.style.width = width + '%';
                    document.getElementById("label").innerHTML = width + '%';
                    document.getElementById('tdProgress').style.display = "block";
                    document.getElementById('tdDescription').style.display = "none";
                    document.getElementById('errorCount').innerHTML = parameters[4];
                    document.getElementById('warningCount').innerHTML = parameters[5];
                    document.getElementById('informationCount').innerHTML = parameters[6];
                    document.getElementById('allCount').innerHTML = parameters[7];
                    document.getElementById('Table1').setAttribute('class', 'not-active');

                    if (msgType === "" && isGridRefreshCompleted) {
                        isGridRefreshCompleted = false;
                        RefreshGrid();
                    }
                }

                function ProgressCompleted(parameters) {
                    var msgType = document.getElementById('hidMsgType').value;
                    var elem = document.getElementById("myBar");
                    window.clearInterval(timercallback);
                    isActionCompleted = true;
                    if (isGridRefreshCompleted) {
                        isGridRefreshCompleted = false;
                        RefreshGrid();
                    }

                    elem.style.width = '100%';
                    document.getElementById("label").style.color = "white";
                    document.getElementById("label").innerHTML = '100%';
                    document.getElementById('tdProgressbar').style.display = "block";
                    document.getElementById('tdProgress').style.display = "block";
                    // clearButtonEnableDisable(false);
                    document.getElementById('Table1').setAttribute('class', '');
                    msg = GetConfirmationMessage(parameters[1], parameters[2], parameters[5]);

                    if (msg != "") {
                        document.getElementById('tdDescription').style.display = "none";
                        document.getElementById('totalCount').innerHTML = "<%=successMessage%>";
                        document.getElementById('errorCount').innerHTML = parameters[1];
                        document.getElementById('warningCount').innerHTML = parameters[2];
                        document.getElementById('informationCount').innerHTML = parameters[3];
                        document.getElementById('allCount').innerHTML = parameters[4];
                        // do not show the successful message if user clicks on Error or warning link
                        if (msgType === "") {
                            document.getElementById('hidMsgType').value = "ALL";
                            showMessageBox = true;
                        }
                    }
                }

                function GetConfirmationMessage(error, warning, timeout) {
                    if (eval(timeout) > 0) {
                        isTimeOut = true;
                        return "<%=timeoutMessage%>";
                }
                else if (eval(error) > 0 || eval(warning) > 0) {
                    var partialMsg = "<%=confirmationPartialMessage%>";
                    if (partialMsg === "") {
                        var partialMsg = "<%=confirmationUninstallPartialMessage%>";
                    }

                    return partialMsg;
                }

                return "<%=confirmationMessage%>";
                }

                function onRefreshCompleted(controlId, actionName, lastRequestObject, xmlResponseObject) {
                    try {
                        if (showMessageBox && isActionCompleted) {
                            if (isTimeOut) {
                                se.ui.messageDialog.showError(title, msg, null);
                            }
                            else {
                                se.ui.messageDialog.showAlert(title, msg, null);
                            }
                            showMessageBox = false;
                        }

                        if (navigator.userAgent.indexOf("Firefox") > -1) {
                            var WebGrid1 = ISGetObject(controlId);
                            window.setTimeout(function () { wgDoResize(true, true); }, 100);
                        }

                        isGridRefreshCompleted = true;
                    }
                    catch (e) { }
                }

                function RefreshGrid() {
                    try {
                        var i = GetMOZBrowserversion();
                        if (i == 1) {
                            Window.setTimeout(function () {
                                var grid = ISGetObject("packageHistoryLogs");
                                grid.Refresh();
                            }, 0);
                            //do not use Refresh() as it is failing in IE7 removed RefreshAll as now we are not supporting IE7
                        }
                        else {
                            var grid2 = ISGetObject("packageHistoryLogs");
                            grid2.Refresh();
                        }
                    }
                    catch (e) { }
                }

                function RefreshGridAfterClear() {
                    // no need to clear alreay refresh calling from onload event
                    RefreshGrid();
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

                function DisableDefaultContextMenuItems(gridId, rowType, rowEl, rowMenu) {
                    var i;
                    var grid = wgGetGridById(gridId);
                    if (rowType === "Record") {
                        // hide the default context menu
                        for (i = 0; i <= 43; i++) {
                            rowMenu.Items[i].Hide();
                        }
                    }

                    if (rowType !== "Record") {

                        if (rowType === "FilterRow") {
                            rowMenu.Items.GetNamedItem("mnuHelp").Hide();
                        }

                        return true;
                    }
                }

                function ShowMessageType(type) {
                    document.getElementById("hidMsgType").value = type;
                    window.document.forms[0].submit();
                }


                function setHeight() {
                    try {
                        var Grid2 = ISGetObject("packageHistoryLogs");
                        var winHeight = window.innerHeight;// window.outerHeight;
                        var ds = window.innerHeight;
                        if (winHeight < 760 & ds < 700) {
                            Grid2.SetHeight(ds - 150 + 'px'); // 36
                        }

                        if (winHeight < 760 & ds < 500) {
                            Grid2.SetHeight(ds - 80 + 'px'); // 36
                        }

                        if (winHeight < 760 & ds < 590) {
                            Grid2.SetHeight(ds - 50 + 'px'); // 36
                        }

                        if (window.parent.location.search != null && window.parent.location.search === '?FromArchestrA=true' && winHeight < 760) {
                            Grid2.SetHeight(ds - 150 + 'px');
                            document.getElementById("HeadDiv").setAttribute(
                                "style", "padding-left:35px;position:absolute;");
                        }

                        if (winHeight < 760 & ds > 600) {
                            Grid2.SetHeight(ds - 170 + 'px'); //170
                        }

                    }
                    catch (e) { }
                }


            </script>
        </telerik:RadCodeBlock>
    </form>
    <telerik:RadWindowManager RenderMode="Classic" ID="MessageDetails" runat="server" Skin="AWTWindow" EnableEmbeddedSkins="false" Behaviors="Close">
        <Windows>
            <telerik:RadWindow RenderMode="Classic" ID="MessageDetailsRadWindow" runat="server" NavigateUrl="MessageDetails.aspx">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadScriptBlock ID="RadScriptBlock2" runat="server">
        <script>
            function ShowMessageDetailsRadWindow(windowpath) {
                windowpath = "..\\..\\Package\\" + windowpath;
                var oBrowserWnd = GetRadWindow().BrowserWindow;
                oWindow = oBrowserWnd.radopen(windowpath, "MessageDetailsRadWindow");
                oWindow.set_title('<%= resourceManager.GlobalResourceSet.GetString("pkg_hstry_message_details_title")%>');
                oWindow.set_modal(true);
                oWindow.setActive(true);
                oWindow.center();
                var w = screen.availWidth;
                var h = screen.availHeight;
                w = w * 1;
                h = h * .93;
                oWindow.setSize(w, h);
            }
        </script>
    </telerik:RadScriptBlock>
</body>
</html>
