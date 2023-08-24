<%@ Page Language="C#" MasterPageFile="~/BPMUITemplates/Default/Repository/Site/HTML5MasterPage.master" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.Queue" Title="Untitled Page" EnableEventValidation="false" %>



<asp:Content ID="Content3" ContentPlaceHolderID="MenuTitle" runat="server"> 
    <div>		
       <%=GR.GetString("ec_menu_queue_management") %>					
    </div>
</asp:Content>


<asp:Content ID="Content1" ContentPlaceHolderID="Cont" Runat="Server">
   
<%if(!_RunInBackwardCompatibleMode){ %>

    <script type="text/javascript">

    
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
                    var editor = document.getElementById('<%=EditorZoneQueue.ClientID %>');
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
    </script>

    <div class="ContainerWebPartZone" style="width:100%; height:100%;margin: 0px auto;  overflow-x:hidden; overflow-y: hidden;" id="QueueContainer">

  
                <asp:WebPartManager ID="WebPartManagerQueue" Personalization-InitialScope="Shared" runat="server">
                </asp:WebPartManager>
                <asp:WebPartZone ID="WebPartZoneQueue" HeaderText="Web Part Zone" HeaderStyle-Height="0.2em" 
                    runat="server" ShowTitleIcons="true" BorderColor="#CCCCCC" Font-Names="Verdana" BorderWidth="0"
                    LayoutOrientation="Vertical" CssClass="WebPartZone" Height="100%">
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
     <div id="divEditor" style="overflow: auto; background-color: Transparent;vertical-align: middle; position: absolute; height:95%;top: 0px;" >        
                <asp:EditorZone ID="EditorZoneQueue" runat="server" CssClass="editZoneHeaderText" HeaderCloseVerb-ImageUrl="images\buttons\window-close.png">
                    <PartTitleStyle CssClass="EditorPartTitle" />
                    <PartChromeStyle CssClass="EditorPartChromeStyle" />
                    <ZoneTemplate>
                        <asp:PropertyGridEditorPart ID="EditorZoneQueuePropertyGrid" runat="server" CssClass="description" />
                        <asp:AppearanceEditorPart ID="EditorZoneQueueAppearance" runat="server" CssClass="description" />
                        <asp:BehaviorEditorPart ID="EditorZoneQueueBehavior" Visible="false" runat="server" CssClass="description" />
                        <asp:LayoutEditorPart ID="EditorZoneQueueLayout" Visible="false" runat="server" CssClass="description" />
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
    <script  type="text/javascript">

            var editor = document.getElementById('<%=EditorZoneQueue.ClientID %>');
            // It should set the width and height only if editor is available
            if (!(editor == null || editor == 'undefined'))
            {
                document.getElementById('<%=WebPartZoneQueue.ClientID %>').style.width = document.body.clientWidth * 80 / 100;
            }
            else
            {
                document.getElementById('<%=WebPartZoneQueue.ClientID %>').style.width = document.body.clientWidth * 99 / 100;
            }
           
        PositionEditor();
        function getWebPartZoneHeight(controlId)
        {
            try {
                var controlNode = document.getElementById(controlId);
                if (!(controlNode == null || controlNode == 'undefined')) {
                    var node = controlNode.parentNode;
                    var nodeClass = node.className;
                    while (nodeClass != 'ContainerWebPartZone' && (!(node == null || node == 'undefined'))) {
                        node = node.parentNode; nodeClass = node.className;
                    }
                    if (!(node == null || node == 'undefined')) {
                        controlNode.style.height = (node.clientHeight - 48) + 'px'; controlNode.style.width = (node.clientWidth - 20) + 'px';
                    }
                }
            }
            catch (e) { }
        }

    </script>
<%}else{ %>
    <div  style="width: 100%; height:100%;background-image:url(images/left-new-bg.jpg)">
                <asp:Panel BackColor="transparent" ID="PanelQueue" runat="server" Height="100%" Width="100%">
                </asp:Panel>
            </div>
    <%} %>

     <script>

         try {
             document.getElementById("tblMain").style.display = "none";

         }
         catch (ex) {

         }

    </script>
</asp:Content>

