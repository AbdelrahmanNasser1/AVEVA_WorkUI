<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Package.CodeBehind.AddToPackageTemplate" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html>
<html style="height:100%">
<head id="pageHead" runat="server">
    <title>
        <%:this.pageTitle %>
    </title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>      
    <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <style type="text/css">
        .RadTabStrip_NGFTabstrip ul {
            padding-top: 0px !important;
            /*width: calc(100% - 10px) !important;*/
            border-bottom:none !important;
        }

        .rootGroup {
            border: none !important;
        }

        .buttonMarging {
            margin-left: 10px;
            margin-right: 0px;
        }

        .PackageSettingFrameCSS {
            height: calc(98% - 56px);
            width: 97%;
            margin-left: 10px;
            border: 1px solid #d1d1d1;
            /*border-left: 1px solid #d1d1d1;
            border-right: 1px solid #d1d1d1;*/

            padding-left: 12px;
            /*padding-right: 1px;*/
            padding-top: 10px;
        }

        .SettingFrameOverflow {
            overflow:auto;
        }
        .rightSettingsForm {
            height: calc(100% - 15px)
        }
    </style>
</head>
    <telerik:RadCodeBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript">
        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow)
                oWindow = window.radWindow;
            else if (window.frameElement != null)
                oWindow = window.frameElement.radWindow;
            return oWindow;
        }

        function closeBellyWindow() {
            var oWindow = GetRadWindow();
            try {
                window.parent.onclientCalled = false;
                window.parent.OnClientClose(oWindow);
                oWindow.close();
                window.parent.onclientCalled = null;
            }
            catch (e) {
            }
        }

        // Initialize locales for message dialog
        se.ui.messageDialog.setGlobalOptions({
            localization: { // All localization related default can be set
                closeButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                okButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                cancelButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                showDetailsCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                hideDetailsCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
            }
        });

        function showPackageTemplateMessage(message) {
            var pageTitle = '<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(this.pageTitle, false)%>';
            se.ui.messageDialog.showAlert(pageTitle, message);
        }

        function showMessageAndClose(messageType, message) {
            var pageTitle = '<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(this.pageTitle, false)%>',
                       self = window;
            var oWindow = GetRadWindow();
            switch (messageType) {
                case "Error":
                    se.ui.messageDialog.showError(pageTitle, message, closeHandlerFn);
                    break;
                case "Message":
                    oWindow.close();
                    document.body.onload = function onload(event) { return true; };
                    se.ui.messageDialog.showAlert(pageTitle, message, closeHandlerFn);
                    break;
                case "Confirmation":
                    se.ui.messageDialog.showConfirmation(pageTitle,
                     message,
                    function (userResponse) {
                        if (userResponse) {
                            window.setTimeout(closeHandlerFn, 100);
                        }
                    });

                    break;
                default:
                    // Only if it is a radWindow, show it
                    break;
            }
        }
        
        function closeHandlerFn() {
            self.closeBellyWindow(false);
        }
        </script>
    </telerik:RadCodeBlock>
<body style="margin: 0; left: 0; overflow:hidden; height: 100%;width:98%; padding-left:10px;padding-right:10px"   onload="ResizeWindow();">
    <form id="packageForm" runat="server" style="height:100%">
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        <telerik:RadScriptBlock ID="RadScriptBlock3" runat="server">
            <link href="<%:themeURL%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
            <link href="<%:themeURL%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
            <link rel="stylesheet" type="text/css" href="<%=themeURL%>TelerikAjax/StyleSheet/AWTTreeView/TreeView.AWTTreeView.css" />
            <link rel="stylesheet" type="text/css" href="<%=themeURL%>TelerikAjax/StyleSheet/AWTTabStrip/TabStrip.AWTTabStrip.css" />
            <link rel="stylesheet" type="text/css" href="<%=themeURL%>TelerikAjax/StyleSheet/AWTSplitter/Splitter.AWTSplitter.css" />
            <link rel="stylesheet" type="text/css" href="<%=themeURL%>TelerikAjax/StyleSheet/AWTPanelBar/PanelBar.AWTPanelBar.css" />
        </telerik:RadScriptBlock>
        <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
            <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        </telerik:RadCodeBlock>
        <table style="width:100%;height:100%;margin:auto;border-width:0;border-spacing:0px;border-collapse:collapse">
        <tr>
            <td style="height: 5px;text-align:center" colspan="2">
                <table id="pageHeaderTable" runat="server" cellpadding="2" border="0" cellspacing="2"
                    width="98%" height="100%">
                    <tr>
                        <td style="white-space:nowrap;text-align:left" >
                            <telerik:RadCodeBlock ID="RadCodeBlock2" runat ="server">
                                <img src="<%:themeURL%>/Repository/ListControl/images/icon-package-templateDark.png"
                                    style="vertical-align:middle" />
                                <span class="pagetitle" style="padding-left:1%;">
                                    <%: this.pageTitle%></span>
                            </telerik:RadCodeBlock>
                        </td>
                        <td class="description" style="text-align:right;word-break:break-all" >
                            <telerik:RadCodeBlock ID="RadCodeBlock3" runat ="server">
                                <%= resManager.GlobalResourceSet.GetString("ec_list_name_Package Template")%>: <%:packageTitle%><%:packageVersion%>
                            </telerik:RadCodeBlock>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align:left">
                            <telerik:RadCodeBlock ID="RadCodeBlock4" runat ="server">
                                <div class="description" style="padding-left:3%;">
                                <%:pageHeading%></div>
                                </telerik:RadCodeBlock>
                            <br />
                        </td>
                    </tr>
                    <tr id="noteRow" runat="server">
                        <td class="description" colspan="2" style="text-align:left">
                            <telerik:RadCodeBlock ID="RadCodeBlock5" runat ="server">
                            <img id="Img1" alt="" runat="server" src="<%$ ReplaceTemplateExpn:/Common/Images/icon-note.png%>"
                                align="absmiddle">&nbsp;<%= resManager.GlobalResourceSet.GetString("pkg_tmp_note")%><br />
                                </telerik:RadCodeBlock>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 100%">
            <td style="height: 100%">
                <telerik:RadAjaxPanel ID="mainPanel" runat="Server" Width="100%" Height="100%" Skin="AWTPanelBar" EnableEmbeddedSkins="false">
                    <div id="bodyDiv" style="height:100%">
                        <table style="width:100%;height:100%;margin:auto;border-width:0;border-spacing:0px;border-collapse:collapse">
                            <tr>
                                <td  style="height: 26px;text-align:left;padding-left:10px; width: 86%";
                                    border-style: solid;" colspan="2" class="header">
                                    <telerik:RadCodeBlock ID="RadCodeBlock6" runat ="server">
                                        <span class="subtitle"><%:selectedObject%></span>
                                    </telerik:RadCodeBlock>
                                </td>
                            </tr>
                            <tr style="height: 100%">
                                <td id="splMainTd" colspan="2" style="height: 78%; width: 100%;">
                                    <telerik:RadSplitter ID="splMain" runat="server" Width="100%" Height="100%"
                                        Skin="AWTSplitter" SplitBarsSize="3px" ResizeWithBrowserWindow="true" EnableEmbeddedSkins="false">
                                        <telerik:RadPane ID="treePane" runat="server" Width="25%" Height="100%" Scrolling="None">
                                            <table style="width: 100%; height: 100%; border: none;">
                                                <tr style="vertical-align: top; text-align: left; height: 100%">
                                                    <td style="height: 100%">
                                                        <telerik:RadPanelBar ID="radPanelbar1" Skin="AWTPanelBar" runat="server" Width="100%" Height="100%"
                                                            ExpandMode="FullExpandedItem" RenderMode="Classic" EnableEmbeddedSkins="false">
                                                            <Items>
                                                                <telerik:RadPanelItem runat="server" Height="100%" Text="" Expanded="true" Value="SkeltaObjects" BorderWidth="0" BorderStyle="None">
                                                                    <Items>
                                                                        <telerik:RadPanelItem Selected="true" Height="100%" runat="server" Value="TemplatedItem1" BorderWidth="0" BorderStyle="None">
                                                                            <ItemTemplate>
                                                                                <table style="width: 100%; height: 100%; vertical-align: top; overflow: hidden;" id="treeViewTable">
                                                                                    <tr style="vertical-align: top; height: 100%; overflow: hidden">
                                                                                        <td style="height: 100%; overflow: hidden">
                                                                                            <telerik:RadTreeView Skin="AWTTreeView" Height="100%" Width="100%" EnableEmbeddedSkins="false" ShowLineImages="false"
                                                                                                ID="packageObjectsTreeView" runat="server" OnNodeClick="PackageObjectsTreeView_NodeClick" BorderStyle="None" RenderMode="Classic"
                                                                                                AutoPostBack="true" ExpandDelay="5" OnClientContextMenuItemClicking="ContextMenuClick" OnContextMenuItemClick="PackageObjectsTreeView_ContextMenuItemClick" OnClientNodeClicking="BeforeClientClick">
                                                                                            </telerik:RadTreeView>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </ItemTemplate>
                                                                        </telerik:RadPanelItem>
                                                                    </Items>
                                                                </telerik:RadPanelItem>
                                                            </Items>
                                                        </telerik:RadPanelBar>
                                                    </td>
                                                </tr>
                                            </table>
                                        </telerik:RadPane>
                                        <telerik:RadSplitBar ID="spl" runat="server" CollapseMode="Forward" />
                                        <telerik:RadPane ID="settingPane" runat="server" Width="72%" Height="100%" Scrolling="None">
                                            <telerik:RadTabStrip ID="objectTabs" CssClass="TabRadTabstrip" runat="server" MultiPageID="objectPages"
                                                SelectedIndex="0" Skin="AWTTabStrip" EnableEmbeddedSkins="false">
                                                <Tabs>
                                                    <telerik:RadTab runat="server" ID="settingsFormTab" PageViewID="settingsFormPage" Height="30px">
                                                    </telerik:RadTab>
                                                    <telerik:RadTab ID="associatedObjectsTab" runat="server" PageViewID="associatedObjectsPage">
                                                    </telerik:RadTab>
                                                    <telerik:RadTab ID="childObjectsTab" runat="server" PageViewID="childObjectsPage">
                                                    </telerik:RadTab>
                                                    <telerik:RadTab ID="securityObjectsTab" runat="server" PageViewID="securityObjectsPage" Visible="false">
                                                    </telerik:RadTab>
                                                </Tabs>
                                            </telerik:RadTabStrip>
                                            <telerik:RadMultiPage ID="objectPages" runat="server" CssClass="" SelectedIndex="0"
                                                Height="99%" Width="100%">
                                                <telerik:RadPageView ID="settingsFormPage" runat="server">
                                                    <iframe id="settingFrame" width="99%" runat="server" frameborder="0" class="rightSettingsForm"></iframe>
                                                </telerik:RadPageView>
                                                <telerik:RadPageView ID="associatedObjectsPage" CssClass="PackageSettingFrameCSS SettingFrameOverflow" runat="server">
                                                    <table style="width: 95%">
                                                        <tr style="text-align: left">
                                                            <td>
                                                                <telerik:RadTreeView Skin="AWTTreeView" EnableEmbeddedSkins="false" ShowLineImages="false"
                                                                    ID="associatedObjectsTreeView" runat="server"
                                                                    AutoPostBack="false" ExpandDelay="10" AfterClientCheck="AfterCheck">
                                                                </telerik:RadTreeView>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </telerik:RadPageView>
                                                <telerik:RadPageView ID="childObjectsPage" CssClass="PackageSettingFrameCSS SettingFrameOverflow" runat="server">
                                                    <table style="width: 95%">
                                                        <tr style="text-align: left">
                                                            <td>
                                                                <telerik:RadTreeView Skin="AWTTreeView" EnableEmbeddedSkins="false" ShowLineImages="false"
                                                                    ID="childObjectsTreeView" runat="server"
                                                                    AutoPostBack="false" ExpandDelay="10">
                                                                </telerik:RadTreeView>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </telerik:RadPageView>
                                                <telerik:RadPageView ID="securityObjectsPage" CssClass="PackageSettingFrameCSS SettingFrameOverflow" runat="server">
                                                    <table style="width: 95%">
                                                        <tr style="text-align: left">
                                                            <td>
                                                                <telerik:RadTreeView Skin="AWTTreeView" EnableEmbeddedSkins="false" ShowLineImages="false"
                                                                    ID="securityObjectsTreeView" runat="server"
                                                                    AutoPostBack="true" ExpandDelay="10">
                                                                </telerik:RadTreeView>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </telerik:RadPageView>
                                            </telerik:RadMultiPage>
                                        </telerik:RadPane>
                                    </telerik:RadSplitter>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left" class="description">
                                    <table>
                                        <tr>
                                            <telerik:RadCodeBlock ID="RadCodeBlock7" runat="server">
                                                <td>
                                                    <img src="<%:themeURL%>Common/Images/orange.png" alt="" /></td>
                                                <td class="description"><%= resManager.GlobalResourceSet.GetString("pkg_rebuild_modified")%>&nbsp;&nbsp;</td>
                                                <td>
                                                    <img src="<%:themeURL%>Common/Images/green.png" alt="" /></td>
                                                <td class="description"><%= resManager.GlobalResourceSet.GetString("pkg_rebuild_saved")%>&nbsp;&nbsp;</td>
                                                <td>
                                                    <img src="<%:themeURL%>Common/Images/red.png" alt="" /></td>
                                                <td class="description"><%= resManager.GlobalResourceSet.GetString("pkg_artifact_deleted")%></td>
                                            </telerik:RadCodeBlock>
                                        </tr>
                                    </table>
                                </td>
                                <td style="text-align: right; height: 30px; padding-bottom: 20px; padding-top: 8px;">
                                    <asp:Button ID="btnCancel" runat="server" CssClass="inputsecondarybutton" OnClick="ButtonCancel_Click" />
                                    <asp:Button ID="btnSave" runat="server" CssClass="inputbutton buttonMarging" OnClick="ButtonSave_Click" />
                                    <asp:HiddenField runat="server" ID="hiddenTreeNodeCache"></asp:HiddenField>
                                </td>
                            </tr>
                        </table>
                    </div>
                </telerik:RadAjaxPanel>
            </td>
        </tr>
    </table>
    <telerik:RadCodeBlock ID="RadCodeBlock8" runat="server">
        <script type="text/javascript">
            function funcSaveSettings() {
                try {
                    document.getElementById('settingFrame').contentDocument.defaultView.saveSettingsForm(performCallbackOperation);
                    if (cancelButtonClientClick == true) {
                        cancelButtonClientClick = false;
                        return false;
                    }
                }
                catch (e) {
                }
            }

            var closewindowGlobal = "0";

            function CloseWindow(msg) {
                var oWindow = GetRadWindow();
                oWindow.close();
                if (msg)
                {
                    showMessageAndClose("Message", msg);
                }

                closewindowGlobal = "1";
            }

            function resizeBodyDiv() {
                try {
                    var div = document.getElementById("bodyDiv");
                    if (document.body.clientHeight > 0) {
                        div.style.height = document.body.clientHeight;
                        div.style.width = document.body.clientWidth - 3;
                        resizeTreeViewForIE();
                    }

                    ResizeForArchaestra();
                }
                catch (e) { }
            }

            function resizeTreeViewForIE() {
                var browserType = navigator.userAgent;
                if ((browserType.indexOf("Firefox") > -1 || browserType.toLowerCase().indexOf('chrome') > -1) == false) {
                    var height = screen.availHeight * .61;
                    if (window.parent.location.search != null && window.parent.location.search == '?FromArchestrA=true') {
                        height = screen.availHeight * .51;
                    }

                    var treeDiv = document.getElementById("<%= packageObjectsTreeView.ClientID%>");
                    treeDiv.style.height = height + "px";
                    treeDiv.style.overflow = "auto";
                }
            }

            function resizeTable() {
                var myTable = document.getElementById("pageHeaderTable");
                myTable.style.top = myTable.style.top + 50;
            }

            function ResizeWindow() {
                // sleep(10);

                var w = screen.availWidth;   //getMaxWidth();    
                var h = screen.availHeight; //getMaxHeight();
                var oWindow = GetRadWindow();
                w = w * .9;
                h = h * .8;

                if (window.parent.location.search != null && window.parent.location.search == '?FromArchestrA=true') {
                    ResizeForArchaestra();
                }
                else {

                    oWindow.setSize(w, h);
                }
                oWindow.center();

                /*var div = document.getElementById("bodyDiv");
                div.style.height = document.body.clientHeight;
                div.style.width = document.body.clientWidth - 3;

                //to set the radtreeview height
                var hgt = screen.availHeight-420;
                if (document.getElementById("treeViewTable") != undefined) {
                  //  alert(hgt);
                    document.getElementById("treeViewTable").style.height =   hgt +'px' ; //332
                  //  alert(document.getElementById("treeViewTable").style.height);
                }*/

                // if page is getting closed then we should not maximize else it will not close the window
                if (closewindowGlobal == "1") {
                }
                else {
                    oWindow.maximize();
                }
                resizeBodyDiv();
                //window.setTimeout(resizeBodyDiv, 100);
            }

            function Cancel() {
                var oWindow = GetRadWindow();
                oWindow.close();
            }

            function ShowException() {
                var path = "../../Package/" + '<%=errorUrl%>';
                try {
                    var oBrowserWnd = GetRadWindow().BrowserWindow;
                    var oWindow = oBrowserWnd.radopen(path, "NewWindow");
                    oWindow.setActive(true);
                    oWindow.set_modal(true);
                    oWindow.center();
                }
                catch (e)
                { }
            }

            //To make the check all and uncheck all on check of the root nodes 
            //for Security,child,associated objects treeview
            function AfterCheck(node) {
                if (!node.Checked && node.Parent != null) {
                    node.Parent.UnCheck();
                }

                var siblingCollection = (node.Parent != null) ? node.Parent.Nodes : node.TreeView.Nodes;

                var allChecked = true;
                for (var i = 0; i < siblingCollection.length; i++) {
                    if (!siblingCollection[i].Checked) {
                        allChecked = false;
                        break;
                    }
                }
                if (allChecked && node.Parent != null) {
                    node.Parent.Check();
                }

                UpdateAllChildren(node.Nodes, node.Checked);
            }

            function UpdateAllChildren(nodes, checked) {
                var i;
                for (i = 0; i < nodes.length; i++) {
                    if (checked)
                        nodes[i].Check();
                    else
                        nodes[i].UnCheck();

                    if (nodes[i].Nodes.length > 0)
                        UpdateAllChildren(nodes[i].Nodes, checked);
                }
            }

            var cancelClientClick = false;
            var cancelButtonClientClick = false;
            //To Disable the node Click for root nodes
            function BeforeClientClick(node, eventArgs) {
                var currentNode = eventArgs.get_node();
                var selectedNode = node.get_selectedNode();
                if (currentNode.get_level() == 0) {
                    eventArgs.set_cancel(true);
                }
                else if (currentNode.get_level() == 1) {
                    if (currentNode.get_value() == 'Artifacts') {
                        eventArgs.set_cancel(true);
                    }
                }
                else if (currentNode.get_level() == 2) {
                    if (!(currentNode.get_value() == "Workflow" || currentNode.get_value() == "Forms List")) {
                        eventArgs.set_cancel(true);
                    }
                }
                else if (currentNode._parent.get_level() == 0 && (currentNode._parent.get_text() == "BAM Workflow" || currentNode._parent.get_text() == "Event Associations")) {
                    eventArgs.set_cancel(true);
                }
                else {
                    if (document.getElementById('settingFrame').contentDocument.defaultView.saveSettingsForm != null) {
                        document.getElementById('settingFrame').contentDocument.defaultView.saveSettingsForm(performCallbackOperation);
                    }

                    eventArgs.set_cancel(false);
                }
            }

            function performCallbackOperation(cancelClientClickOperation)
            {
                cancelClientClick = cancelClientClickOperation;
                if (cancelClientClickOperation == true) {
                    cancelClientClick = true;
                    cancelButtonClientClick = true;
                    return false;
                }
            }

            var stopClientCallProceedWithServerClick = false;

            function ContextMenuClick(sender, eventArgs) {
                if (stopClientCallProceedWithServerClick) {
                    stopClientCallProceedWithServerClick = false;
                    return;
                }

                var node = eventArgs.get_node();
                var menuItem = eventArgs.get_menuItem();
                var menuItemText = menuItem.get_text();
                var msg = '';
                switch (menuItemText) {
                    case "<%=this.deleteText%>":
                        msg = "<%=deleteConfirmationMsg%>";
                        break;
                    case "<%=this.rebuildText%>":
                        msg = "<%=rebuildConfirmationMsg%>";
                        break;
                    case "<%=this.includeChildText%>":
                        msg = "<%=this.includeChildConfirmationMessage%>";
                        break;
                    case "<%=this.workflowCompleteRebuild%>":
                    case "<%=this.formCompleteRebuild %>":
                        msg = "<%=rebuildConfirmationMsg%>";
                        msgForm = "<%=this.formCompleteRebuildDetails%>";
                        msgWorkflow = "<%=this.workflowCompleteRebuildDetails%>";

                        if (node._parent.get_text() == "Forms List")
                        {
                            msg = msgForm;
                        }

                        if (node._parent.get_text() == "Workflow")
                        {
                            msg = msgWorkflow;
                        }

                        break;
                    case "<%=this.workflowArtifactRebuild%>":
                        msg = "<%=this.workflowArtifactRebuildDetails%>";
                        break;
                    case "<%=this.formControlRebuild %>":
                        msg = "<%=this.formControlRebuildDetails%>";
                        break;
                }

                try {
                    var pageTitle = '<%=this.pageTitle%>';
                    se.ui.messageDialog.showConfirmation(pageTitle,
                        msg, function (val) {
                            if (val) {
                                stopClientCallProceedWithServerClick = true;
                                // JavaScript runtime error: Accessing the 'caller' property of a function or arguments object is not allowed in strict mode
                                // A possible workaround would be to wrap the ajaxRequest() call in a setTimeout, however
                                window.setTimeout(function () {
                                    menuItem = eventArgs.get_menuItem();
                                    menuItem.click(); }, 0);
                            }
                            else {
                                eventArgs.set_cancel(true);
                                // To hide the menus
                                eventArgs.get_menuItem()._parent.hide()
                            }
                        });

                    eventArgs.set_cancel(true);
                }
                catch (err) {
                    if (confirm(msg)) {
                        eventArgs.set_cancel(false);
                    }
                    else {
                        eventArgs.set_cancel(true);
                    }
                }
            }

            function ResizeForArchaestra() {
                if (window.parent.location.search != null && window.parent.location.search == '?FromArchestrA=true') {
                    var winHeight = window.outerHeight;
                    var ds = window.innerHeight;
                    if (winHeight < 760 & ds < 580) {
                        document.getElementById("splMainTd").setAttribute("style", "height:345px !important");
                    }
                }
            }

            ResizeForArchaestra();
        </script>
    </telerik:RadCodeBlock>
    </form>
</body>
</html>