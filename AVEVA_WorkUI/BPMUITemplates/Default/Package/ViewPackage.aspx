<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Package.CodeBehind.ViewPackage" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE html>
<html style="height:100%">
<head id="pageHead" runat="server">
    <title>
        <%=pageTitle %></title>
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
            height: calc(100% - 30px);
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
<telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
    <script type="text/javascript">
        function GetRadWindow() {
            var oWindow = null;
            if (window.frameElement != null)
                oWindow = window.frameElement.radWindow;
            return oWindow;
        }

        function closeBellyWindow() {
            var oWindow = GetRadWindow();
            var check = false;
            try {
                window.parent.onclientCalled = false;
                window.parent.OnClientClose(oWindow);
                oWindow.close();
                window.parent.onclientCalled = null;
            } catch (e) {
                check = true;
            }

            if (check === true) {
                try {
                    window.parent.parent.onclientCalled = false;
                    window.parent.parent.OnClientClose(oWindow);
                    oWindow.close();
                    window.parent.parent.onclientCalled = null;
                } catch (e) {
                }
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

        function showMessageAndClose(messageType, message) {
            var pageTitle = '<%=resManager.GlobalResourceSet.GetString("Edit")%>' + ' ' + '<%=resManager.GlobalResourceSet.GetString("ec_menu_packagedesc")%>',
                self = window;
            var oWindow = GetRadWindow();

            // refresh the grid in parent or caller or referer window
            try {
                oWindow.BrowserWindow.RefreshPackageGrid("webgridPreValidate");
            } catch (e) {
            }

            switch (messageType) {
                case "Error":
                    se.ui.messageDialog.showError(pageTitle, message, closeHandlerFn);
                    break;
                case "Message":
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

            function closeHandlerFn() {
                self.closeBellyWindow(false);
            }
        }

        function passValueToParentWindow(message)
        {
            var pageTitle = '<%=resManager.GlobalResourceSet.GetString("Edit")%>' + ' ' + '<%=resManager.GlobalResourceSet.GetString("ec_menu_packagedesc")%>';

            document.body.onload = function onload(event) { return true; };

            se.ui.messageDialog.showAlert(pageTitle, message);
            var oWindow = GetRadWindow();
            oWindow.close('true');
        }

        AddEventHandler(window, 'resize', resizefunction);
        AddEventHandler(window, 'load', resizefunction);

        function AddEventHandler(elementObject, eventName, functionObject) {
            if (document.addEventListener)
                elementObject.addEventListener(eventName, functionObject, false);
            else
                if (document.attachEvent)
                    elementObject.attachEvent("on" + eventName, functionObject);
        }

        function resizefunction() {
            var bodydiv = document.getElementById('divbody');
            var headerdiv = document.getElementById('divheader');
            var footerdiv = document.getElementById('divfooter');
            var parentdiv = document.getElementById('divparent');
            if (parentdiv.offsetParent == document.body)
                document.body.style.height = '100%';
            try {
                var parentdivheight = parentdiv.offsetParent.offsetHeight;
                parentdiv.style.height = parentdivheight;
                bodydiv.style.height = parentdivheight - headerdiv.offsetHeight - footerdiv.offsetHeight;
            } catch (e) { }
            resizeTreeViewForIE();
        }
    </script>
</telerik:RadScriptBlock>
<body style="overflow: hidden; height: 100%; width: 100%;" onload="ResizeWindow();">
    <form id="packageForm" runat="server" style="height: 100%">
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
            <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        </telerik:RadCodeBlock>
        <telerik:RadCodeBlock ID="RadCodeBlock7" runat="server">
            <link href="<%=themeURL%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
            <link href="<%=themeURL%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
            <link rel="stylesheet" type="text/css" href="<%=themeURL%>TelerikAjax/StyleSheet/AWTTreeView/TreeView.AWTTreeView.css" />
            <link rel="stylesheet" type="text/css" href="<%=themeURL%>TelerikAjax/StyleSheet/AWTTabStrip/TabStrip.AWTTabStrip.css" />
            <link rel="stylesheet" type="text/css" href="<%=themeURL%>TelerikAjax/StyleSheet/AWTSplitter/Splitter.AWTSplitter.css" />
            <link rel="stylesheet" type="text/css" href="<%=themeURL%>TelerikAjax/StyleSheet/AWTPanelBar/PanelBar.AWTPanelBar.css" />
        </telerik:RadCodeBlock>
        <table style="width: 100%; height: 100%; margin: auto;">
            <tr>
                <td style="height: 5px; text-align: center">
                    <table id="pageHeaderTable" runat="server" cellpadding="2" border="0" cellspacing="2" width="98%" height="93%">
                        <tr>
                            <td style="white-space: nowrap; text-align: left">
                                <telerik:RadCodeBlock ID="RadCodeBlock6" runat="server">
                                    <img src="<%=themeURL%>/Repository/ListControl/images/icon-package-templateDark.png"
                                        vspace="4" hspace="4"
                                        style="vertical-align: middle" />
                                    <span class="pagetitle"><%= pageTitle%></span>
                                </telerik:RadCodeBlock>
                            </td>
                            <td class="description" style="text-align: right; word-break: break-all">
                                <telerik:RadCodeBlock ID="RadCodeBlock3" runat="server">
                                    <%= resManager.GlobalResourceSet.GetString("ec_list_name_Package Template")%>: <%=packageTitle%><%=packageVersion%>
                                </telerik:RadCodeBlock>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="text-align: left">
                                <div class="description" style="padding-left: 2.8%;">
                                    <%=pageHeading%>
                                </div>
                            </td>
                        </tr>
                        <tr id="noteRow" runat="server">
                            <td class="description" colspan="2">
                                <img id="Img1" alt="" runat="server" src="<%$ ReplaceTemplateExpn:/Common/Images/icon-note.png%>"
                                    align="absmiddle">&nbsp;<telerik:RadCodeBlock ID="RadCodeBlock4" runat="server"><%= resManager.GlobalResourceSet.GetString("pkg_tmp_note")%></telerik:RadCodeBlock>
                                <br />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="height: 100%">
                <td style="height: 100%">
                    <telerik:RadAjaxPanel ID="mainPanel" runat="Server" Width="100%" Height="100%">
                        <div id="divparent" style="height: 99%; width: 100%;">
                            <table style="width: 100%; height: 100%; margin: auto; border-width: 0; border-spacing: 0px; border-collapse: collapse">
                                <tr id="divheader" style="height: 3%" class="header">
                                    <td style="height: 26px; text-align: left; padding-left: 10px; width: 100%">
                                        <telerik:RadCodeBlock ID="RadCodeBlock5" runat="server"><span class="subtitle"><%=selectedObject%></span></telerik:RadCodeBlock>
                                    </td>
                                </tr>
                                <tr id="divBody" style="height: 94%; width: 100%">
                                    <td id="splMainTd" colspan="2" style="height: 78%; width: 100%; vertical-align: top;">
                                        <telerik:RadSplitter ID="splMain" runat="server" Width="100%" Height="100%"
                                            Skin="AWTSplitter" SplitBarsSize="3px" ResizeWithBrowserWindow="true" EnableEmbeddedSkins="false">
                                            <telerik:RadPane ID="treePane" runat="server" Width="25%" Height="100%" Scrolling="None">
                                                <table style="width: 100%; height: 100%; border: none;">
                                                    <tr style="vertical-align: top; text-align: left; height: 100%">
                                                        <td style="height: 100%">
                                                            <telerik:RadPanelBar ID="radPanelbar1" Skin="AWTPanelBar" runat="server" Width="100%" Height="100%"
                                                                ExpandMode="FullExpandedItem" RenderMode="Classic" EnableEmbeddedSkins="false">
                                                                <Items>
                                                                    <telerik:RadPanelItem runat="server" Height="100%" Text="" Expanded="true" Value="SkeltaObjects">
                                                                        <Items>
                                                                            <telerik:RadPanelItem Selected="true" Height="100%" runat="server" Value="TemplatedItem1">
                                                                                <ItemTemplate>
                                                                                    <table style="width: 100%; height: 100%; vertical-align: top; overflow: hidden; border-style: none" id="treeViewTable">
                                                                                        <tr style="vertical-align: top; height: 100%; border-style: none">
                                                                                            <td style="height: 100%; border-style: none">
                                                                                                <telerik:RadTreeView Skin="AWTTreeView" Height="100%" Width="100%" EnableEmbeddedSkins="false" ShowLineImages="false"
                                                                                                    ID="packagableObjectsTreeView" runat="server" OnNodeClick="PackagableObjectsTreeView_NodeClick" BorderStyle="None" RenderMode="Classic"
                                                                                                    AutoPostBack="true" ExpandDelay="0" OnClientNodeClicking="BeforeClientClick">
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
                                            <telerik:RadPane ID="settingPane" runat="server" Width="75%" Height="100%" Scrolling="None">
                                                <telerik:RadTabStrip ID="objectTabs" CssClass="TabRadTabstrip" runat="server" MultiPageID="objectPages"
                                                    SelectedIndex="0" Skin="AWTTabStrip" EnableEmbeddedSkins="false">
                                                    <Tabs>
                                                        <telerik:RadTab runat="server" ID="settingsFormTab" PageViewID="settingsFormPage">
                                                        </telerik:RadTab>
                                                        <telerik:RadTab ID="associatedObjectsTab" runat="server" PageViewID="associatedObjectsPage">
                                                        </telerik:RadTab>
                                                        <telerik:RadTab ID="childObjectsTab" runat="server" PageViewID="childObjectsPage">
                                                        </telerik:RadTab>
                                                        <telerik:RadTab ID="securityObjectsTab" runat="server" PageViewID="securityObjectsPage">
                                                        </telerik:RadTab>
                                                    </Tabs>
                                                </telerik:RadTabStrip>
                                                <telerik:RadMultiPage ID="objectPages" runat="server" CssClass="PageViewCss" SelectedIndex="0"
                                                    Height="95%" Width="100%">
                                                    <telerik:RadPageView ID="settingsFormPage" CssClass="PackageSettingFrameCSS" runat="server">
                                                        <iframe id="settingFrame" class="rightSettingsForm" width="99%" runat="server" frameborder="0"></iframe>
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
                                <tr id="divfooter" style="height: 3%;">
                                    <td style="text-align: right; height: 20px; padding-bottom: 0px; padding-top: 8px; padding-right: 20px">
                                        <asp:Button ID="btnCancel" runat="server" CssClass="inputsecondarybutton" OnClick="ButtonCancel_Click" />
                                        <asp:Button ID="btnSave" runat="server" CssClass="inputbutton buttonMarging" OnClick="ButtonSave_Click" OnClientClick="funcSaveSettings();" />
                                        <asp:HiddenField runat="server" ID="hiddenTreeNodeCache"></asp:HiddenField>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </telerik:RadAjaxPanel>
                </td>
            </tr>
        </table>

        <telerik:RadScriptBlock ID="RadScriptBlock2" runat="server">
            <script type="text/javascript">
                var closewindowGlobal = "0";
                var oWindow;
                function GetRadWindow() {
                    var oWindow = null;
                    if (window.frameElement != null)
                        oWindow = window.frameElement.radWindow;
                    return oWindow;
                }
                function CloseWindow(msg) {
                    closewindowGlobal = "1";
                    var oWindow = GetRadWindow();
                    try {
                        GetRadWindow().BrowserWindow.RefreshPackageGrid("webgridPreValidate");
                    }
                    catch (e) { }
                    oWindow.close();
                }

                function resizeBodyDiv() {
                    try {
                        resizeTreeViewForIE();
                        var div = document.getElementById("bodyDiv");
                        if (document.body.clientHeight > 0) {
                            div.style.height = document.body.clientHeight;
                            div.style.width = document.body.clientWidth - 3;
                        }
                    }
                    catch (e) {
                    }
                }

                function resizeTreeViewForIE() {
                    var browserType = navigator.userAgent;
                    if ((browserType.indexOf("Firefox") > -1 || browserType.toLowerCase().indexOf('chrome') > -1) == false) {
                        var height = screen.availHeight * .67;
                        if (window.parent.location.search != null && window.parent.location.search == '?FromArchestrA=true') {
                            height = screen.availHeight * .42;
                        }

                        var treeDiv = document.getElementById("<%= packagableObjectsTreeView.ClientID%>");
                        treeDiv.style.height = height - 25 + "px";
                        treeDiv.style.overflow = "auto";
                    }
                }

                function resizeTable() {
                    var myTable = document.getElementById("pageHeaderTable");
                    myTable.style.top = myTable.style.top + 50;
                }

                function ResizeWindow() {
                    var w = screen.availWidth;   //getMaxWidth();    
                    var h = screen.availHeight; //getMaxHeight();
                    var oWindow = GetRadWindow();
                    //  oWindow.Maximize();
                    w = w * 1;
                    h = h * .93;
                    if (window.parent.location.search != null && window.parent.location.search == '?FromArchestrA=true') {
                    }
                    else {

                        var pageType = "<%=fromInstallPage%>";

                    }

                    oWindow.center();
                    // if page is getting closed then we should not maximize else it will not close the window
                    if (closewindowGlobal == "1") {
                    }
                    else {
                        oWindow.maximize();
                        //oWindow.SetSize(screen.availWidth, screen.availHeight);
                    }
                    resizeBodyDiv();
                    window.setTimeout(resizeBodyDiv, 100);
                }

                function Cancel() {
                    var oWindow = GetRadWindow();
                    oWindow.close();
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

                function funcSaveSettings() {
                    try {
                        var result = document.getElementById('settingFrame').contentDocument.defaultView.saveSettingsForm(performCallbackOperation);
                       if (result === false) {
                            return false;
                        }
                        if (cancelButtonClientClick === true) {
                            cancelButtonClientClick = false;
                            return false;
                        }
                    }
                    catch (e) {
                    }
                    return true;
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

                function performCallbackOperation(cancelClientClickOperation) {
                    cancelClientClick = cancelClientClickOperation;
                 if (cancelClientClickOperation == true) {
                        cancelClientClick = true;
                        cancelButtonClientClick = true;
                        return false;
                    }
                }

                if (oWindow != null || oWindow != undefined)
                    oWindow.reload();
            </script>
        </telerik:RadScriptBlock>
    </form>
</body>
</html>
