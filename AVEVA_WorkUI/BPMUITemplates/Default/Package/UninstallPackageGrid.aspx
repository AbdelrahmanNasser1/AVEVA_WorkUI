<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Package.CodeBehind.UninstallPackage" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ Register TagPrefix="cc2" Namespace="Workflow.NET.Ajax" Assembly="Workflow.NET.NET2" %>
<!DOCTYPE html>
<HTML style="height:100%">
<head id="HEAD1" runat="server">
    <title><%= resourceManager.GlobalResourceSet.GetString("pkg_uninstall_header")%></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <style type="text/css">
        .buttonMarging {
            margin-right: 5px;
        }

        tbody > tr[type="Record"] > td[type="Cell"]:first-of-type {
            padding-left: 10px !important;
        }
    </style>
</head>
 <script type="text/javascript">
     var closewindowGlobal = "0";
     function GetRadWindow() {
         var oWindow = null;
         if (window.frameElement != null)
             oWindow = window.frameElement.radWindow;
         return oWindow;
     }

     function HidePadColumn(gridId) {

         var grid = ISGetObject(gridId);
         grid.HidePadColumn = true;
     }

     function closeWindow(msg)
     {
         if (msg)
         {
             var pageTitle = "<%= resourceManager.GlobalResourceSet.GetString("pkg_uninstall_header")%>";
             se.ui.messageDialog.showAlert(pageTitle, msg);
         }
         else
         {
             CallServerSideMethod(null, 'Delete', "DeleteTableTest", CallbackSaveQuery, 'delete', '');
         }

         closewindowGlobal = "1";
         var oWindow = GetRadWindow();
         oWindow.hide();
         oWindow.close();
     }

     function ChangeWindowSize() {
         var oWindow = GetRadWindow();
         //oWindow.setSize(820, 380);
     }

     function resizeWindow() {
         var w = screen.availWidth;   //getMaxWidth();    
         var h = screen.availHeight; //getMaxHeight();
         var oWindow = GetRadWindow();
         w = w * .9;
         h = h * .8;

         if (window.parent.location.search != null && window.parent.location.search == '?FromArchestrA=true') {
             resizeTreeViewForIE();
         }
         else {
             oWindow.setSize(w, h); //width,height
         }

         oWindow.center();

         // if page is getting closed then we should not maximize else it will not close the window
         if (closewindowGlobal == "1") {
         }
         else {
             oWindow.maximize();
         }

         AutoRefesh();
     }

     function resizeTreeViewForIE() {
         var browserType = navigator.userAgent;
         if ((browserType.indexOf("Firefox") > -1 || browserType.toLowerCase().indexOf('chrome') > -1) == false) {
             var height = screen.availHeight * .45;
             var treeDiv = document.getElementById('WebGridDiv');
             treeDiv.style.height = height + "px";
             treeDiv.style.overflow = "hidden";
         }
     }

     function ValidatePackage() {
         var clickTimes = document.getElementById('hiddenInstall').value;
         if (clickTimes === "1") {
             return false;
         }

         document.getElementById('hiddenInstall').value = document.getElementById('hiddenInstall').value + 1;
         document.getElementById("hidRunType").value = "uninstall";
         document.getElementById("mode").value = "uninstall";
         return true;
     }

     function OpenWindow(path) {
         // Opening inside the browser window as the browser's child window
         var oBrowserWnd = GetRadWindow().BrowserWindow;
         var oWindow = oBrowserWnd.radopen(path, "RadWindow1");
         oWindow.set_modal(true);
         var w, h;
         var winHeight = 500;
         var winWidth = 800;

         if (document.all || document.layers) {
             w = screen.availWidth;   //getMaxWidth();    
             h = screen.availHeight; //getMaxHeight();    
         }

         var winLeft = (w - winWidth) / 2;
         var winTop = (h - winHeight) / 2;
         oWindow.setSize(winWidth, winHeight);
         oWindow.moveTo(winLeft, winTop);
     }

     function ResizeMessageColumn(gridId) {
         var gridPreValidate = ISGetObject(gridId);
         try {
             if (navigator.userAgent.indexOf("MSIE") > -1) {
               //  gridPreValidate.GetRootTable().Columns[3].ResizeBestFit();
                 gridPreValidate.GetRootTable().Columns[5].ResizeBestFit();
             }
         }
         catch (e) {
         }
     }
     function installButtonEnableDisable(disable) {
         var installButton = document.getElementById('btnOk');
         installButton.disabled = disable;
     }

     function ShowMessageType(type) {
         document.getElementById("hidMsgType").value = type;
         window.document.forms[0].submit();
     }
 </script>
<body id="Body" style="margin: 0; left: 0; overflow: auto; height: 100%" onload="resizeWindow();">
    <form id="Form1" method="post" runat="server" style="height: 100%">
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
            <%=System.Web.Helpers.AntiForgery.GetHtml()%>
            <link rel="stylesheet" type="text/css" href="<%=themePath%>Common/StyleSheet/Global.css" />
            <link rel="stylesheet" type="text/css" href="<%=themePath%>CommonUXControls/StyleSheet/se.ui.min.css" />
            <link rel="stylesheet" type="text/css" href="<%:themePath%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
            <link rel="stylesheet" type="text/css" href="<%:themePath%>TelerikAjax/StyleSheet/AWTWindow/Window.css">
        <input type="hidden" name="hidRunType" id="hidRunType" value="" />
        <input type="hidden" name="mode" id="mode" value="" />
        <table id="Table1" style="width: 98%; border-width: 0; margin: auto" runat="server">
            <tr>
                <td class="pagetitle" style="padding: 5px; padding-top: 12px; padding-left: 0.2%;" colspan="2">
                    <div style="height: 20px;">
                        <div style="position: absolute; float: left;">
                            <img src="<%=themePath%>/Repository/ListControl/images/icon-package-template.png" alt="" style="vertical-align: middle;" />
                        </div>
                        <div id="HeadDiv" style="position: absolute; float: left; padding-left: 2.2%;" class="pagetitle">
                            <%= resourceManager.GlobalResourceSet.GetString("pkg_preuninstall_title")%>
                        </div>
                        <div class="description" style="float: right; padding-right: 2%"><%=packageTitle%><%=packageVersion%></div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="description" style="text-align: left; padding-left: 2.5%; padding-bottom: 10px;">
                    <%=uninstallMessageDesc%>
                </td>
                <td class="description" style="text-align: left; padding-left: 2.5%; display: none;" id="tdProgress">
                    <%=packageProgressText%><img src="<%=themePath%>/Repository/Site/images/windows-preloader.gif" alt="" style="vertical-align: middle" />
                </td>
            </tr>
        </table>
        <asp:Label ID="uninstallMessage" runat="server" Text="" CssClass="successfulmsg" Style="visibility: hidden; display: none; padding-left: 4%;"></asp:Label>
        <div id="WebGridDiv" style="height: 80%; width: 95%; vertical-align: top; padding-left: 2%; margin: 0 auto;">
            <ISWebGrid:WebGrid ID="webgridPreValidate" runat="server" HorizontalAlign="NotSet"
                Width="98%" Height="100%" AllowAutoDataCaching="false" ViewStateStorage="None" DisableFileSystemChecking="true" EnableWebResources="Never">
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
                    <ClientSideEvents OnAfterResponseProcess="ResizeGrid" OnButtonClick="LogButtonClickHandler" OnRowContextMenu="DisableDefaultContextMenuItems" OnInitialize="HidePadColumn" />
                    <TextSettings Language="UseCulture"></TextSettings>
                    <HyperlinkStyle CssClass="GridHyperlinkStyle" />
                </LayoutSettings>
                <RootTable GridLineStyle="NotSet">
                </RootTable>
            </ISWebGrid:WebGrid>
        </div>
        <table id="Table2" style="width: 94%; border-width: 0; margin: auto; border-spacing: 1px;" runat="server">
            <tr>
                <td style="bottom: 20px; left: 3.1%; position: absolute;">
                    <table>
                        <tr>
                            <td>
                                <img src="<%=themePath%>Common/Images/icon-errors.png" onclick="Javascript:ShowMessageType('ERROR');" alt="" />
                            </td>
                            <td class="description" style="vertical-align: middle">
                                <a class="textlinkblacknormal" onclick="Javascript:ShowMessageType('ERROR');" href="#">
                                    <span id="errorCount" class="description" style="vertical-align: top">0</span>
                                </a>&nbsp;<a class="GridHyperlinkStyle" onclick="Javascript:ShowMessageType('ERROR');" href="#" style="vertical-align: top">
                                    <%= resourceManager.GlobalResourceSet.GetString("pkg_History_Errors")%></a>&nbsp;
                            </td>
                            <td>
                                <img src="<%=themePath%>Common/Images/icon-warning.png" onclick="Javascript:ShowMessageType('WARNING');" alt="" />
                            </td>
                            <td class="description" style="vertical-align: top"><a class="textlinkblacknormal" onclick="Javascript:ShowMessageType('WARNING');" href="#"><span id="warningCount" class="description">0</span></a>&nbsp;<a class="GridHyperlinkStyle" onclick="Javascript:ShowMessageType('WARNING');" href="#"><%= resourceManager.GlobalResourceSet.GetString("pkg_History_Warnings")%></a></td>
                            <td>
                                <img src="<%=themePath%>Common/Images/icon-information.png" onclick="Javascript:ShowMessageType('INFORMATION');" alt="" />
                            </td>
                            <td class="description" style="vertical-align: top"><a class="textlinkblacknormal" onclick="Javascript:ShowMessageType('INFORMATION');" href="#"><span id="informationCount" class="description">0</span></a>&nbsp;<a class="GridHyperlinkStyle" onclick="Javascript:ShowMessageType('INFORMATION');" href="#"><%= resourceManager.GlobalResourceSet.GetString("pkg_History_Information")%></a></td>
                            <td>
                                <img src="<%=themePath%>Common/Images/icon-all.png" onclick="Javascript:ShowMessageType('ALL');" alt="" />
                            </td>
                            <td class="description" style="vertical-align: top">
                                <a class="textlinkblacknormal" onclick="Javascript:ShowMessageType('ALL');" href="#"><span id="allCount" class="description">0</span></a>&nbsp;<a class="GridHyperlinkStyle" onclick="Javascript:ShowMessageType('ALL');" href="#"><%= resourceManager.GlobalResourceSet.GetString("RepoProviderSearch_All")%></a>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="buttonRow" runat="server" style="text-align: right">
                <td id="buttonCloseColoum" runat="server">
                    <div style="bottom: 20px; right: 20px; position: absolute;">
                        <input id="Reload" runat="server" type="button" value="Reload" onclick="javascript: ReloadGrid();" class="inputsecondarybutton buttonMarging" />
                        <input id="btnClose" runat="server" type="button" onclick="javascript: closeWindow();" class="inputsecondarybutton buttonMarging" size="100" />
                        <asp:Button ID="btnOk" runat="server" CssClass="inputbutton" />
                    </div>
                    <asp:HiddenField runat="server" ID="hiddenInstall"></asp:HiddenField>
                    <input id="hidMsgType" type="hidden" name="hidMsgType" value="<%=Microsoft.Security.Application.Encoder.HtmlEncode(messageType)%>">
                    <input id="hidWaitFlag" type="hidden" name="hidWaitFlag" runat="server" />
                </td>
            </tr>
        </table>
        <cc2:AjaxPageControl ID="ajaxPageControl1" runat="server" Style="z-index: 104; left: 440px; position: absolute; top: 88px"></cc2:AjaxPageControl>
        <telerik:RadWindowManager ID="Singleton" SSkin="AWTWindow" runat="server" EnableEmbeddedSkins="false" Behaviors="Close" RenderMode="Classic">
            <Windows>
                <telerik:RadWindow ID="RadWindow1" Height="590px" Width="360px" runat="server" Left="" Title="User Lookup" Top="" />
            </Windows>
        </telerik:RadWindowManager>
    </form>
</body>
</html>
<script type="text/javascript">
    var lastselectedrowkey = '0';
    function LogButtonClickHandler(gridId, tblName, colName, cellValue) {
        var webGrid = wgGetGridById(gridId);
        if (webGrid.GetSelectedObject() == null)
            return;

        var row = webGrid.GetSelectedObject().GetRowObject();
        var objectName = wgGetCellByName(row.GetElement(), 'ObjectName').innerText;
        var objectType = wgGetCellByName(row.GetElement(), 'ObjectType').innerText;
        var objectVersion = wgGetCellByName(row.GetElement(), 'ObjectVersion').innerText;
        // direct use of ObjectType fails in localized envt so storing ObjectType in hidden variable before localization
        var cell = wgGetCellByName(row.GetElement(), "ObjectType");
        var internalObjectType = cell.getAttribute("hiddenObjectType");
        var lastObj = webGrid.GetSelectedObject();
        if (lastObj != null) {
            lastselectedrowkey = lastObj.rowIndex;
        }

        var logPath = "<%=templateRootDir%>/Package/ViewPackage.aspx?mode=edit&type=" + encodeURIComponent(objectType) + "&name=" + encodeURIComponent(objectName) + "&version=" + objectVersion + "&<%=listParams.GetSecuredUri()%>";
        var oBrowserWnd = GetRadWindow().BrowserWindow;
        var oWindow = oBrowserWnd.radopen(logPath, "RadWindow1");
        oWindow.set_modal(true);
        oWindow.setActive(true);
        oWindow.center();
        var w = screen.availWidth;   //getMaxWidth();    
        var h = screen.availHeight; //getMaxHeight();
        w = w * .7;
        h = h * .7;
        oWindow.setSize(w, h); //width,height

        oWindow.add_beforeClose(onClientBeforeCloseViewPackage);

        function onClientBeforeCloseViewPackage(sender, args)
        {
            var returnValue = args.get_argument();

            if (returnValue !== null && returnValue !== undefined)
            {
                if (returnValue)
                {
                    var details = internalObjectType + "," + objectName + "," + objectVersion;
                    CallServerSideMethod(null, 'RerunValidation', "Validation", CallbackSaveQuery, 'validation', details);
                }
            }

            sender.remove_beforeClose(onClientBeforeCloseViewPackage);
        }
    }

    function ReloadGrid() {
        CallServerSideMethod(null, 'RerunValidation', "reload", CallbackSaveQuery, 'reload', '');
    }

    function ResizeGrid(controlId) {
        try {
            if (navigator.userAgent.indexOf("Firefox") > -1) {
                var WebGrid1 = ISGetObject(controlId);
                window.setTimeout(function () { wgDoResize(true, true); }, 100);
            }
        }
        catch (e) { }
    }

    var gridName1 = null;
    function RefreshGridTimeOutPackage() {
        var grid = ISGetObject(gridName1);
        grid.Refresh();
    }

    function RefreshPackageGrid(gridName) {
        gridName1 = gridName;
        window.setTimeout(RefreshGridTimeOutPackage, 100);
    }

    function DisableDefaultContextMenuItems(gridId, rowType, rowEl, rowMenu) {

        if (rowType != "Record") {

            if (rowType == "FilterRow") {
                rowMenu.Items.GetNamedItem("mnuHelp").Hide();
            }

            return true;
        }

        var i;
        var grid = wgGetGridById(gridId);
        if (rowType == "Record") {
            // hide the default context menu
            for (i = 0; i <= 43; i++) {
                //rowMenu.Items[i].visible = false;
                rowMenu.Items[i].Hide();
            }
        }
    }

    function setHeight() {
        try {
            var Grid2 = ISGetObject("webgridPreValidate");
            var winHeight = window.outerHeight;
            var ds = window.innerHeight;

            if (window.parent.location.search != null && window.parent.location.search == '?FromArchestrA=true' && winHeight < 760 & ds < 500) {
                Grid2.SetHeight(ds - 100 + 'px');
                document.getElementById("HeadDiv").setAttribute(
    "style", "padding-left:35px;position:absolute;");
                Grid2.Refresh();
            }
        }
        catch (e) { }
    }

    setHeight();

    function QueryToSave()
    {
        this.SimpleQuery = "";
        this.CamlQuery = "";
    }

    function AutoRefesh()
    {
        //auto refresh
        var querytosave = new QueryToSave();
        querytosave.SimpleQuery = "data";
        CallServerSideMethod(null, 'SaveQuery', "DataTableTest", CallbackSaveQuery, 'table', querytosave);
    }

    var globalMsg = 1;
    
    function CallbackSaveQuery(context, result, response) {
        var waitFlag = document.getElementById('hidWaitFlag').value;
        if (waitFlag) {
            document.getElementById('tdProgress').style.display = "block";
            document.getElementById('hidWaitFlag').value = true; //waitFlag = false;
            setTimeout(function () {
                AutoRefesh();
            }, 2000);
            return;
        }

        var paramArray = result;
        var parameters = paramArray[0].split(",");
        if (parameters[0] == "edit") {
            document.getElementById('tdProgress').style.display = "block";
            document.getElementById('errorCount').innerHTML = '0';
            document.getElementById('warningCount').innerHTML = '0';
            document.getElementById('informationCount').innerHTML = '0';
            document.getElementById('allCount').innerHTML = '0';
            window.setTimeout(AutoRefesh, 5000);
            document.getElementById('tdProgress').style.display = "none";
            var grd = wgGetGridById('webgridPreValidate');
            var selecting = grd.RootTable.ToRowObject(grd.RootTable.GetElement(WG40.BODY, WG40.HTMLTABLE).rows[lastselectedrowkey]);
            window.setTimeout(function () { selecting.Select(); }, 1000);
        }
        else if (parameters[0] == "refresh") {
            document.getElementById('tdProgress').style.display = "block";
            document.getElementById('errorCount').innerHTML = parameters[1];
            document.getElementById('warningCount').innerHTML = parameters[2];
            document.getElementById('informationCount').innerHTML = parameters[3];
            document.getElementById('allCount').innerHTML = parameters[4];
            RefreshGrid();
        }
        else {
            if (parameters[0] == "valid") {
                document.getElementById('tdProgress').style.display = "none";
                installButtonEnableDisable(false);
                document.getElementById('errorCount').innerHTML = parameters[1];
                document.getElementById('warningCount').innerHTML = parameters[2];
                document.getElementById('informationCount').innerHTML = parameters[3];
                document.getElementById('allCount').innerHTML = parameters[4];
                if (globalMsg < 3) {
                    globalMsg = globalMsg + 1;
                    RefreshGrid();
                }
                else {
                    globalMsg = 1;
                }
            }
            else {
                document.getElementById('tdProgress').style.display = "none";
                RefreshGridWithoutTimeOut();
            }
        }
    }

    function RefreshGrid()
    {
        try
        {
            var grid = ISGetObject("webgridPreValidate");
            grid.Refresh(); //do not use Refresh() as it is failing in IE7 removed RefreshAll as now we are not supporting IE7
            //using timeout to adjust the grid height
            window.setTimeout(AutoRefesh, 5000);
        }
        catch (e) { }
    }

    function RefreshGridWithoutTimeOut()
    {
        try
        {
            var grid = ISGetObject("webgridPreValidate");
            grid.Refresh();
        }
        catch (e) { }
    }
</script>