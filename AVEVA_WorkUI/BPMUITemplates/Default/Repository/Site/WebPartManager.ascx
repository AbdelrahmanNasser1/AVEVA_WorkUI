<%@ Control Language="C#" AutoEventWireup="true"  Inherits="Skelta.Repository.Web.CodeBehind.ECWebPartManager" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<link href="<%=ThemeURL%>Common/StyleSheet/Global.css" rel="stylesheet" />
<script src="../../Common/JavaScripts/jquery.min.js"></script>
<script src="../../Common/JavaScripts/AutoLogoff.js"></script>


<style type="text/css" >
    .line-separator{
height:56px;
border-right:1px solid #bbbbbb;
}
</style>
<script language="javascript" type="text/javascript">

    function getWebPartZoneHeight(controlId) {
        try {
           // debugger;
            var controlNode = document.getElementById(controlId);
            if (!(controlNode == null || controlNode == 'undefined')) {
                var node = controlNode.parentNode;
                var nodeClass = node.className;
                while (nodeClass != 'ContainerWebPartZone' && (!(node == null || node == 'undefined'))) {
                    node = node.parentNode; nodeClass = node.className;
                }
                if (!(node == null || node == 'undefined')) {
                    var wpnodetitle = getWebPartTitle(node);
                    var padding = 19;
                    if (wpnodetitle != undefined) {
                        padding = 20;
                    }
                    controlNode.style.height = (node.clientHeight + padding) + 'px';//19 
                    controlNode.style.width = (node.clientWidth - 19) + 'px';
                }
            }
            //alert(controlId + '-----------hi----------' + controlNode.style.height);
        }
        catch (e)
        { }
    }

    function getWebPartTitle(wpnode) {
        try {
            if (navigator.appName == 'Netscape') {
//                for (var i = 0; i < wpnode.childNodes.length; i++) {
//                    if (wpnode.childNodes[i] != null || wpnode.childNodes[i] != 'undefined') {
//                        if (wpnode.childNodes[i].className == "WebPartZone") {
//                            if (wpnode.title != '' && wpnode != undefined)
//                                return wpnode.title;
//                        }
//                    }
//                }
            }
            else {
                while (wpnode != null) {
                    wpnode = wpnode.firstChild;
                    if (wpnode.title != '')
                        return wpnode.title;
                }
            }
        }
        catch (e) {
        }
    }
        function CollapseDiv() {
            var divWebPartSettings = document.getElementById("<%=divWebPartSettings.ClientID%>");
            var divCollapse = document.getElementById("<%=divCollapse.ClientID%>");
            var divExpand = document.getElementById("<%=divExpand.ClientID%>");
            var hdncollapseMode = document.getElementById("<%=hdncollapseMode.ClientID%>");
            divCollapse.style.display = 'none';
            if (navigator.appName == 'Netscape') {
                divExpand.style.display = 'table-row';
                divWebPartSettings.style.display = 'table-row';
            } else {
                divExpand.style.display = 'block';
                divWebPartSettings.style.display = 'block';
            }
            hdncollapseMode.value = 'expand';
        }
        function ExpandDiv() {
            var divWebPartSettings = document.getElementById("<%=divWebPartSettings.ClientID%>");
            var divCollapse = document.getElementById("<%=divCollapse.ClientID%>");
            var divExpand = document.getElementById("<%=divExpand.ClientID%>");
            var hdncollapseMode = document.getElementById("<%=hdncollapseMode.ClientID%>");
            if (navigator.appName == 'Netscape') {
                divCollapse.style.display = 'table-row';
            } else {
                divCollapse.style.display = 'block';
            }
            divExpand.style.display = 'none';
            divWebPartSettings.style.display = 'none';
            hdncollapseMode.value = 'collapse';
        }

        function Confirm() {
            //var confirmmsg = confirm("Do you really want to reset the user scope? This will reset the control to shared view and the personalization done by the user will be lost.");

            se.ui.messageDialog.showConfirmation('<%=_ResourceManager.GlobalResourceSet.GetString("ec_menu_webpartdashboard")%>', '<%=_ResourceManager.GlobalResourceSet.GetString("promttoresetuserscope")%>', function (userResponse)
            {
                if (userResponse)
                {
                    document.getElementById("<%=hiddenButtonReset.ClientID%>").click();
                }
            });
        }

        function PositionEditor() {
            try
            {
                var winHeight = screen.availHeight;
                var winWidth = screen.availWidth;
                var divWidth = winWidth * 50 / 100;
                var divHeight = winHeight * 60 / 100;
                var divLeft = (winWidth - divWidth) / 2;
                var divTop = (winHeight - divHeight ) / 2;
                var div = document.getElementById('divEditor');
                if (!(div == null || div == 'undefined')) {
                    var editor = document.getElementById('<%=EditorZoneControl.ClientID %>');
                    // It should set the width and height only if editor is available
                    if (!(editor == null || editor == 'undefined')) {
                        div.style.height = divHeight;
                        div.style.width = divWidth;
                        editor.style.width = divWidth - 20;
                        editor.style.height = divHeight - 60;
                    }
                    div.style.left = divLeft;
                    div.style.top = divTop;
                }
            }
            catch(e)
            {}
        }         
</script>

<script type="text/javascript">
    // Create expanding titles for Legends with className 'EditorPartTitle'
    var plus = "url(<%=ThemeURL%>Repository/Site/images/Webparts/plus.gif)";
    var minus = "url(<%=ThemeURL%>Repository/Site/images/Webparts/minus.gif)";
        function CreateExpandingTitles() {
            var elements = document.getElementsByTagName("LEGEND");
            var i = 0;
            for (i = 0; i < elements.length; i++) {
                if (elements[i].className && elements[i].className == "EditorPartTitle")
                    elements[i].onclick = new Function("toggle(this);");
                elements[i].style.backgroundImage = plus;
            }
            if (i > 0 && elements != 'undefined')
                elements[--i].style.backgroundImage = minus;
        }


        // Call function CreateExpandingTitles on window onload
        if (window.addEventListener)
            window.addEventListener('load', CreateExpandingTitles, false);
        else if (window.attachEvent)
            window.attachEvent('onload', CreateExpandingTitles);


        function toggle(titleElement) {
            // Find nextSibling's firstChild (i.e. DIV with class 'EditorPartStyleHidden')
            // For IE this is nextSibling.childNodes[0], but due to an error in current
            // version of FireFox (1.0.4) this is nextSibling.childNodes[1]
            var firstChild = (titleElement.nextSibling.childNodes[0].id)
  ? titleElement.nextSibling.childNodes[0]
  : titleElement.nextSibling.childNodes[1];


            // Toggle image and show/hide EditorPart display
            if (navigator.appName == 'Netscape') {
                if (firstChild.style.display == "table-row") {
                    firstChild.style.display = "none";
                    titleElement.style.backgroundImage = plus;
                } else {
                    firstChild.style.display = "table-row";
                    titleElement.style.backgroundImage = minus;
                }
            }
            else {
                if (firstChild.style.display == "block") {
                    firstChild.style.display = "none";
                    titleElement.style.backgroundImage = plus;
                } else {
                    firstChild.style.display = "block";
                    titleElement.style.backgroundImage = minus;
                }
            }
        }

        function ShowPackageWindow() {
            var url = "../../Package/PackageList.aspx?mode=WEBPARTPAGE<%=_QueryStringForPackage %>"; 
            var windowparams = "height=320,width=500,resizable=yes,status=no";
            var oWindow = radopen(url, "RadWindow1");
            oWindow.set_modal(true);
            oWindow.set_title("Web Part Page Packaging");
            oWindow.setSize(590, 360);
        }
</script>
 <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=ThemeURL %>CommonUXControls/StyleSheet/se.ui.min.css" />
    <link rel="stylesheet" type="text/css" href="<%=ThemeURL%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
    <link rel="stylesheet" type="text/css" href="<%=ThemeURL%>TelerikAjax/StyleSheet/AWTWindow/Window.css">
    <script>
        // Initialize locales for message dialog
        se.ui.messageDialog.setGlobalOptions({
            localization: { // All localization related default can be set
                closeButtonCaption: "<%=_ResourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                okButtonCaption: "<%=_ResourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                cancelButtonCaption: "<%=_ResourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                showDetailsCaption: "<%=_ResourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                hideDetailsCaption: "<%=_ResourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
            }
        });
    </script>

<div style="overflow: auto;">
    <table id="tblsharedScope" border="0" runat="server" cellpadding="0" cellspacing="0"
        style="width: 100%;">
        <tr>
            <td class="header">
                <table style="width: 100%;">
                    <tr style="width: 100%;">
                        <td align="left">
                            <div id="divCollapse" style="display: block; cursor: hand;" runat="server">
                                <a href="#">
                                    <img id="idCollapse" runat="server" border="0" src="<%$ ReplaceTemplateExpn:BAM/images/expand.gif%>"
                                        onclick="CollapseDiv();" alt="Expand Settings" align="absmiddle" /></a>
                                <span class="subtitle"><%=_ResourceManager.GlobalResourceSet.GetString("Webparts Settings")%></span>
                            </div>
                            <div id="divExpand" style="display: none;" runat="server">
                                <a href="#">
                                    <img id="idExpand" runat="server" border="0" src="<%$ ReplaceTemplateExpn:BAM/images/collapse.gif%>"
                                        onclick="ExpandDiv();" alt="Collapse Settings" align="absmiddle" /></a>
                                <span class="subtitle"><%=_ResourceManager.GlobalResourceSet.GetString("Webparts Settings")%></span>
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td height="33%">
                <div id="divWebPartSettings" runat="server" style="overflow: hidden; width:100%; display: none;
                    position: absolute; z-index: 1; padding: 3;">
                    <table width="100%" height="30" border="0" cellpadding="1" cellspacing="1" class="WPSettingTableBorder">
                        <tr>
                            <td valign="top" class="WebPartSettingsToolbar">
                                <table  style="width:100%;border:1px solid #999" cellspacing="2" cellpadding="2">
                                    <tr>
                                        <td align="center">
                                            <table width="100%" height="100%" border="0" cellpadding="1" cellspacing="0" class="WPSettingPartTable">
                                                <tr>
                                                    <td style="padding-left:10px;">
                                                        <table width="100%" height="100%" border="0" cellpadding="2" cellspacing="2" class="WebPartSettingsToolbar">
                                                <tr>
                                                    <td align="left" class="subtitle">
                                                        <%=_ResourceManager.GlobalResourceSet.GetString("Web Part Display Mode")%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        <asp:DropDownList ID="ddlDisplayMode" runat="server" AutoPostBack="true" EnableViewState="false" CssClass="inputselect"
                                                            OnSelectedIndexChanged="ddlDisplayMode_SelectedIndexChanged" />
                                                    </td>
                                                </tr>
                                            </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                            <div class="line-separator"></div>
                                        </td>
                                        <td rowspan="2" valign="middle" style="padding-left:1%;">
                                            <table width="100%" height="100%" border="0" cellpadding="1" cellspacing="0" class="WPSettingPartTable">
                                                <tr>
                                                    <td>
                                                        <table width="100%" height="100%" border="0" cellpadding="2" cellspacing="2" class="WebPartSettingsToolbar">
                                                            <tr>
                                                                <td>
                                                                    <asp:RadioButtonList ID="rdoScope" runat="server" CssClass="inputradio" AutoPostBack="false"
                                                                        RepeatDirection="Horizontal">
                                                                        <asp:ListItem Text="User" Value="user">User Scope</asp:ListItem>
                                                                        <asp:ListItem Text="Shared" Value="shared">Shared Scope</asp:ListItem>
                                                                    </asp:RadioButtonList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2" align="left" style="padding-bottom:10px;">
                                                                    <asp:Button ID="btnReset"  CssClass="inputsecondarybutton" OnClientClick="javascript:Confirm();return false;" 
                                                                        runat="server" Text="Reset User Scope" />
                                                                    <asp:Button ID="hiddenButtonReset"  CssClass="inputsecondarybutton"
                                                                        runat="server" Text="Reset User Scope" OnClick="btnReset_Click" style="display:none;" />
                                                                    <asp:Button ID="btnApplyScope" CssClass="inputbutton" Text="Apply Scope" runat="server" style="margin-left:10px;"
                                                                        OnClick="btnApplyScope_Click" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                            <div class="line-separator"></div>
                                        </td>
                                        <td rowspan="2" valign="middle" style="padding-left:1%;">
                                            <table width="700" height="100%" border="0" cellpadding="1" cellspacing="0" class="WPSettingPartTable">
                                                <tr>
                                                    <td>
                                                        <table width="100%" height="100%" border="0" cellpadding="2" cellspacing="2" class="WebPartSettingsToolbar">
                                                            <tr>
                                                                <td  class="subtitle" width="20%">
                                                                    <%=_ResourceManager.GlobalResourceSet.GetString("Select Web Part")%>:
                                                                </td>
                                                                <td width="30%">
                                                                    <label>
                                                                        <asp:DropDownList ID="ddlWebParts" CssClass="inputselect" DataTextField="Name" Width="170px" DataValueField="Id"
                                                                            runat="server">
                                                                        </asp:DropDownList>
                                                                    </label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="subtitle">
                                                                    <%=_ResourceManager.GlobalResourceSet.GetString("Select Zone")%>:
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlZone" CssClass="inputselect" Width="170px" runat="server">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td width="140" rowspan="2" valign="middle">
                                                                    <asp:Button ID="btnAdd" Text="Add Web Part" OnClick="btnAdd_Click"
                                                                        runat="server" CssClass="inputbutton" style="margin-bottom:5%;" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>
    <input type="hidden" runat="server" id="hdncollapseMode" />
    <table>
        <tr>
            <td>
                <asp:WebPartManager ID="WebPartManagerControl" runat="server">
                </asp:WebPartManager>
                <telerik:RadWindowManager ID="Singleton" Skin="AWTWindow" EnableEmbeddedSkins="false" runat="server" Behaviors="Close, Minimize, Maximize, Move" RenderMode="Classic">
                    <Windows>
                        <telerik:RadWindow ID="RadWindow1" Height="300px" Width="555px" runat="server" NavigateUrl="" Left="" Title="User Lookup" Top="">
                        </telerik:RadWindow>
                    </Windows>
                </telerik:RadWindowManager>
            </td>
        </tr>
    </table>
</div>
<div id="divEditor" style="overflow: auto; background-color: Transparent;
    text-align: left; vertical-align: top; position: absolute;
    margin-left: auto; margin-right: auto; margin: 0 auto; z-index: 11;height:75%;">
    <asp:EditorZone ID="EditorZoneControl" runat="server" CssClass="editZoneHeaderText" Height="100%"
        HeaderText="Invensys Skelta Web Part Editor" HeaderCloseVerb-ImageUrl="images\buttons\window-close.png">
        <PartTitleStyle CssClass="EditorPartTitle" />
        <PartChromeStyle CssClass="EditorPartChromeStyle" BorderStyle="None"/>
        <ZoneTemplate>
            <asp:PropertyGridEditorPart ID="EditorZoneControlPropertyGrid" CssClass="EditorPartHidden" runat="server" />
            <asp:AppearanceEditorPart ID="EditorZoneControlAppearance" runat="server"  CssClass="EditorPartHidden" />
            <asp:BehaviorEditorPart ID="EditorZoneControlBehavior" runat="server" Visible="false" CssClass="EditorPartHidden" />
            <asp:LayoutEditorPart ID="EditorZoneControlLayout" runat="server" CssClass="description" />
        </ZoneTemplate>
        <PartStyle CssClass="editZonePartStyle" />
        <LabelStyle CssClass="description" />
        <VerbStyle CssClass="inputbutton" />
        <ErrorStyle CssClass="errormsg" />
        <EmptyZoneTextStyle CssClass="help" />
        <EditUIStyle CssClass="description" />
        <HeaderStyle Font-Size="14px" CssClass="header" />
        <HeaderVerbStyle CssClass="note" />
        <InstructionTextStyle CssClass="warningmsg" />
        <FooterStyle CssClass="footer" />
    </asp:EditorZone>
</div>

<script language="javascript" type="text/javascript">
        PositionEditor();
</script>

