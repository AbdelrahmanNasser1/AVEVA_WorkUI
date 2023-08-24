<%@ Page Language="C#" MasterPageFile="~/BPMUITemplates/Default/Repository/Site/HTML5MasterPage.master"
    AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.WorkItemList" EnableEventValidation="false" 
    Title="Untitled Page" %>


<asp:Content ID="Content3" ContentPlaceHolderID="MenuTitle" runat="server"> 
    <div>		
        <%=GR.GetString("ec_menu_Inbox")%>					
    </div>
</asp:Content>




<asp:Content ID="Content1" ContentPlaceHolderID="Cont" runat="Server">
    <%if(_RunInBackwardCompatibleMode){ %>
        <table id="table1"  runat="server" border="0" style="height: 100%;width:100%;">
        <tr>
            <td style="height:100%;width:100%;vertical-align:top">
                <asp:Panel ID="PanelWIL" runat="server" Height="100%">
                </asp:Panel>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
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
        GetBrowserversion()
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
    <%}else{ %>
    
   
    <div class="ContainerWebPartZone" style="width:100%; height:98%;margin: 0px auto;vertical-align:top;" id="WorkitemListContainer">
        <asp:WebPartManager ID="WebPartManagerWorkItem" Personalization-InitialScope="Shared" runat="server">
        </asp:WebPartManager>
        <asp:WebPartZone ID="WebPartZoneWorkItem" HeaderText="Web Part Zone" HeaderStyle-Height="0" Width="100%"
            Height="100%" runat="server" ShowTitleIcons="true" BorderColor="#CCCCCC" Font-Names="Verdana" BorderWidth="0"
            LayoutOrientation="Vertical" CssClass="WebPartZone">
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
        
     <div id="divEditor" style="overflow: auto; background-color: Transparent; position: absolute; height:95%;top: 10px;" >
        <asp:EditorZone ID="EditorZoneWorkItem" runat="server" Height="100%" CssClass="editorZone" HeaderCloseVerb-ImageUrl="images\buttons\window-close.png">
            <PartTitleStyle CssClass="EditorPartTitle" />
            <PartChromeStyle CssClass="EditorPartChromeStyle" />
            <ZoneTemplate>
                <asp:PropertyGridEditorPart ID="EditorZoneWorkItemPropertyGrid"  runat="server" Width="100%"  CssClass="description" />
                <asp:AppearanceEditorPart ID="EditorZoneWorkItemAppearance" runat="server" CssClass="description" />
                <asp:BehaviorEditorPart ID="EditorZoneWorkItemBehavior" Visible="false" runat="server" CssClass="description" />
                <asp:LayoutEditorPart ID="EditorZoneWorkItemLayout" Visible="false" runat="server" CssClass="description" />
            </ZoneTemplate>
            <PartStyle CssClass="editZonePartStyle" />
            <LabelStyle CssClass="description" />
            <VerbStyle CssClass="inputbutton" />
            <ErrorStyle CssClass="errormsg" />
            <EmptyZoneTextStyle CssClass="help" />
            <EditUIStyle CssClass="description" />
            <HeaderStyle CssClass="header" />
            <HeaderVerbStyle CssClass="note" />
            <InstructionTextStyle CssClass="warningmsg" />
            <FooterStyle CssClass="footer" />
        </asp:EditorZone>
      </div>          
    
    <input type="hidden" runat="server" id="hdncollapseMode" />
    <script type="text/javascript">
        
        if (navigator.appName == 'Netscape') {
            document.getElementById('divEditor').style.height = document.body.clientHeight * 95 / 100;
        }
    </script>
    <script type="text/javascript">
        function getWebPartZoneHeight(controlId)
        {
            try {
                
                var controlNode = document.getElementById(controlId);
                var varisPostBack = '<%= Page.IsPostBack ? "true" : "false" %>';
                
               
                if (!(controlNode == null || controlNode == 'undefined')) {
                    var node = controlNode.parentNode;
                    var nodeClass = node.className;
                    while (nodeClass != 'ContainerWebPartZone' && (!(node == null || node == 'undefined'))) {
                        node = node.parentNode; nodeClass = node.className;
                    }
                    if (!(node == null || node == 'undefined'))
                    {                       
                        if (navigator.appName == "Microsoft Internet Explorer") 
                        {
                            controlNode.style.height = (node.clientHeight - 102) + 'px';                            
                        }
                        else
                        {                            
                            if(varisPostBack == 'false')
                            { 
                              controlNode.style.height = (node.clientHeight - 72) + 'px';                                                        
                            }
                        }
                        controlNode.style.width = (node.clientWidth - 20) + 'px';
                    }
                }
            }
            catch (e) { }
        }
    </script>    
    
    

    <%} %>

    <script>

        try
        {
            if (window.parent.parent.location.href.indexOf('FromArchestrA') != -1)
            {
                document.getElementById("tblMain").style.display = "none";
            }
            else
            {
            var h = window.outerHeight;
            document.getElementById("WorkitemListContainer").style.height=h-112+'px';
            document.getElementById("tblMain").style.display = "none";
            }
        }
        catch (ex) {
        }

        function isIE11() {
            return !!navigator.userAgent.match(/Trident.*rv[ :]*11\./);
        }

        function ResizeGrid() {
            if (isIE11()) {
                window.setTimeout(function () { wgDoResize(true, true); }, 600);
                return true;
            }
        }

        ResizeGrid();

    </script>

</asp:Content>
