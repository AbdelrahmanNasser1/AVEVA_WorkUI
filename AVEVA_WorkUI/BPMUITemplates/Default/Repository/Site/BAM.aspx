<%@ Page Language="C#" MasterPageFile="~/BPMUITemplates/Default/Repository/Site/HTML5MasterPage.master" AutoEventWireup="true" EnableEventValidation="false" Inherits="Skelta.Repository.Web.CodeBehind.BAM" Title="BAM Control" %>

<%--<%@ Register Assembly="Skelta.BAM" Namespace="Skelta.BAM.UserControls" TagPrefix="bcl"  %>--%>
<asp:Content ID="Content3" ContentPlaceHolderID="MenuTitle" runat="server"> 
    <script src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(bellyBarPath)%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(cssPath) %>CommonUXControls/StyleSheet/se.ui.min.css" /> 
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
    <div>		       
       <%=GR.GetString("ec_menu_analysis") %>				
    </div>
</asp:Content>


<asp:Content ID="Content1" ContentPlaceHolderID="Cont" runat="Server">
<%if(!_RunInBackwardCompatibleMode){ %>

    <script type="text/javascript">
        // Create expanding titles for Legends with className 'EditorPartTitle'
        function CreateExpandingTitles() {
            var elements = document.getElementsByTagName("LEGEND");
            var i = 0;
            for (i = 0; i < elements.length; i++) {
                if (elements[i].className && elements[i].className == "EditorPartTitle")
                    elements[i].onclick = new Function("toggle(this);");
                elements[i].style.backgroundImage = "url(images/Webparts/plus.gif)";
            }
            if (i > 0 && elements != 'undefined')
                elements[--i].style.backgroundImage = "url(images/Webparts/minus.gif)";
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
                    titleElement.style.backgroundImage = "url(images/Webparts/plus.gif)";
                } else {
                    firstChild.style.display = "table-row";
                    titleElement.style.backgroundImage = "url(images/Webparts/minus.gif)";
                }
            }
            else {
                if (firstChild.style.display == "block") {
                    firstChild.style.display = "none";
                    titleElement.style.backgroundImage = "url(images/Webparts/plus.gif)";
                } else {
                    firstChild.style.display = "block";
                    titleElement.style.backgroundImage = "url(images/Webparts/minus.gif)";
                }
            }
        }

        function PositionEditor() {
            try {
                
                var winHeight = screen.availHeight;
                var winWidth = screen.availWidth;
                var divWidth = winWidth * 50 / 100;
                var divHeight = winHeight * 60 / 100;
                var divLeft = (winWidth - divWidth) / 2;
                var divTop = (winHeight - divHeight) / 2;
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
                    
                    div.style.left = divLeft +"px";
                    div.style.top = divTop;
                }
            }
            catch (e)
            { }
        }

        function SetBamContainerHeight()
        {
            if (navigator.appName == "Microsoft Internet Explorer")
            {                
                document.getElementById("BamContainer").style.height = "96%";
            }
            else
            {                
                document.getElementById("BamContainer").style.height = "99%";
            }

        }
    </script>


    <div class="ContainerWebPartZone" style="width:100%; height:98%;margin: 0px auto;vertical-align:top;" id="BamContainer">
                <asp:WebPartManager ID="WebPartManagerBAM" Personalization-InitialScope="Shared" runat="server">
                </asp:WebPartManager>
                <asp:WebPartZone ID="WebPartZoneBAM" HeaderText="Web Part Zone" HeaderStyle-Height="0" BorderWidth="0"
                    Width="99%" Height="98%" runat="server" ShowTitleIcons="true" BorderColor="#CCCCCC"
                    Font-Names="Verdana" LayoutOrientation="Vertical" CssClass="WebPartZone" >
                    <PartChromeStyle CssClass="PartChromeStyle" />
                    <MenuLabelHoverStyle CssClass="MenuLabelHoverStyle" />
                    <EmptyZoneTextStyle Font-Size="0.8em" />
                    <MenuLabelStyle CssClass="MenuLabelStyle" />
                    <MenuVerbHoverStyle CssClass="MenuVerbHoverStyle" BorderWidth="1px" />
                    <HeaderStyle Font-Size="0.0em" HorizontalAlign="Center" ForeColor="White" />
                    <MenuVerbStyle ForeColor="Gray" Font-Size="10" />
                    <TitleBarVerbStyle CssClass="TitleBarVerbStyle" Font-Underline="false" />
                    <MenuPopupStyle BackColor="White" BorderColor="LightGray" BorderWidth="1px" Font-Names="Verdana" />
                    <PartTitleStyle Font-Size="0.7em" ForeColor="#003399" />
                    <DeleteVerb Visible="false" />
                </asp:WebPartZone>    
    </div>
    <div id="divEditor" style="overflow: auto; background-color: Transparent;vertical-align: bottom; position: absolute; height:95%;top: 10px;" >        
        <asp:EditorZone ID="EditorZoneControl" runat="server" CssClass="editZoneHeaderText"
            HeaderCloseVerb-ImageUrl="images\buttons\window-close.png">
            <PartTitleStyle CssClass="EditorPartTitle"  />
            <PartChromeStyle CssClass="EditorPartChromeStyle"  />
            <ZoneTemplate>
                <asp:PropertyGridEditorPart ID="EditorZoneControlPropertyGrid" CssClass="EditorPartHidden" runat="server" />
                <asp:AppearanceEditorPart ID="EditorZoneControlAppearance" runat="server" />
                <asp:BehaviorEditorPart ID="EditorZoneControlBehavior" Visible="false" runat="server" CssClass="EditorPartHidden" />
                <asp:LayoutEditorPart ID="EditorZoneControlLayout" Visible="false" runat="server" CssClass="description" />                
            </ZoneTemplate>
            <PartStyle CssClass="editZonePartStyle" />
            <LabelStyle CssClass="description" />
            <VerbStyle CssClass="inputbutton" />
            <ErrorStyle CssClass="errormsg" />
            <EmptyZoneTextStyle CssClass="help" />
            <EditUIStyle CssClass="description" />
            <HeaderStyle CssClass="header" />
            <HeaderVerbStyle CssClass="note"   />
            <InstructionTextStyle CssClass="warningmsg" />               
            <FooterStyle  CssClass="footer" /> 
            
                   
        </asp:EditorZone>
    </div>
    <input type="hidden" runat="server" id="hdncollapseMode" /> 
    <script  type="text/javascript">
        SetBamContainerHeight();
        PositionEditor();
        function getWebPartZoneHeight(controlId) {
            try {
                
                var controlNode = document.getElementById(controlId);
                if (!(controlNode == null || controlNode == 'undefined')) {
                    var node = controlNode.parentNode;
                    var nodeClass = node.className;
                    while (nodeClass != 'ContainerWebPartZone' && (!(node == null || node == 'undefined'))) {
                        node = node.parentNode; nodeClass = node.className;
                    }
                    if (!(node == null || node == 'undefined')) {
                        controlNode.style.height = (node.clientHeight - 58) + 'px'; controlNode.style.width = (node.clientWidth - 20) + 'px';
                    }
                }
            }
            catch (e) { }
        }

    </script>
    <%}else{ %>
        <table id="table1" border="0" style="width:100%">
        <tr>
            <td style="width:100%;height:100%;vertical-align:top;">
                <asp:Panel ID="PanelBAM" runat="server" Height="100%">
                </asp:Panel>
            </td>
        </tr>
    </table>
        <script  type="text/javascript">
            check();
            function check() {
                var chk = GetBrowserversion();
                if (chk == 3 || chk == 2) {
                    document.getElementById("table1").style.height = document.body.clientHeight - 58;
                }
                else {
                    document.getElementById("table1").style.height = document.body.clientHeight - 61;
                }
            }

            function GetBrowserversion() {
                var app = navigator.userAgent;
                if (app.indexOf("MSIE 7") > -1) {
                    return 3;
                }
                else if (app.indexOf("Firefox/1.5") > -1) {
                    return 2;
                }
                else {
                    return 1;
                }
            }
          
    </script>

    <%} %>

    <script>

        try {
            document.getElementById("tblMain").style.display = "none";
        }
        catch (ex) {

        }

    </script>
</asp:Content>
