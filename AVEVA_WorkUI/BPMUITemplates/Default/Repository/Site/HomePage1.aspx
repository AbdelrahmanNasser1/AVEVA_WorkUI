<%@ Page Language="C#" MasterPageFile="~/BPMUITemplates/Default/Repository/Site/HTML5MasterPage.master" EnableEventValidation="false"
    AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.HomePage1" Title="Untitled Page" %>


<%@ Register Src="WebPartManager.ascx" TagName="ECWebPartManager"
    TagPrefix="uc1" %>

<asp:Content ID="Content3" ContentPlaceHolderID="MenuTitle" runat="server"> 
    <div>		
         <%=resourceManager.GlobalResourceSet.GetString("ec_menu_webpartdashboard") %>							
    </div>
</asp:Content>


<asp:Content ID="Content1" ContentPlaceHolderID="Cont" runat="Server">
    <div style="width: 100%; height: 100%; position: absolute;">
        <uc1:ECWebPartManager ID="ECWebPartManager1" runat="server" />
        <div style="height: 50%;width:100%; position: relative; overflow: auto;border:1px solid #cccccc;">
            <div id="divHeader" class="ContainerWebPartZone" style="height: 75%; width: 100%;">
                <asp:WebPartZone ID="WebPartZoneHeader" HeaderText="Web Part Zone Header" Width="100%"
                    Height="90%" runat="server" ShowTitleIcons="true" CssClass="WebPartZone"
                    LayoutOrientation="Vertical">
                    <PartChromeStyle CssClass="PartChromeStyle" />
                    <MenuLabelHoverStyle CssClass="MenuLabelHoverStyle" />
                    <EmptyZoneTextStyle Font-Size="0.8em" />
                    <MenuLabelStyle CssClass="MenuLabelStyle" />
                    <MenuVerbHoverStyle CssClass="MenuVerbHoverStyle" BorderWidth="1px" />
                    <HeaderStyle CssClass="HeaderStyle" HorizontalAlign="Center" Font-Size="0.7em" />
                    <MenuVerbStyle ForeColor="Gray" Font-Size="8" />
                    <TitleBarVerbStyle CssClass="TitleBarVerbStyle" Font-Underline="false" />
                    <MenuPopupStyle Font-Names="Verdana" BackColor="White" BorderColor="LightGray" BorderWidth="1px" />
                    <PartTitleStyle Font-Size="0.7em" ForeColor="#003399" />
                </asp:WebPartZone>
            </div>
        </div>
        <div style="height: 50%; position: relative;">
            <div id="content" style="width: 50%; height: 100%; float: left; position: absolute;">
                <div id="divLeft" class="ContainerWebPartZone" style="height: 82%; width: 98%;overflow: auto;border:1px solid #cccccc;">
                    <asp:WebPartZone ID="WebPartZoneLeft" HeaderText="Web Part Zone Left" Width="97%"
                        Height="90%" runat="server" CssClass="WebPartZone"
                        LayoutOrientation="Vertical">
                        <PartChromeStyle CssClass="PartChromeStyle" BorderStyle="None" />
                        <MenuLabelHoverStyle CssClass="MenuLabelHoverStyle" />
                        <EmptyZoneTextStyle Font-Size="0.8em" />
                        <MenuLabelStyle CssClass="MenuLabelStyle" />
                        <MenuVerbHoverStyle CssClass="MenuVerbHoverStyle" BorderWidth="1px" />
                        <HeaderStyle CssClass="HeaderStyle" HorizontalAlign="Center" Font-Size="0.7em" />
                        <MenuVerbStyle ForeColor="Gray" Font-Size="8" BorderWidth="0" />
                        <TitleBarVerbStyle CssClass="TitleBarVerbStyle" Font-Underline="false" />
                        <MenuPopupStyle Font-Names="Verdana" BackColor="White" BorderColor="LightGray" />
                        <PartTitleStyle Font-Size="0.7em" ForeColor="#003399" />
                    </asp:WebPartZone>
                </div>
            </div>
            <div style="width: 50%; height: 82%; float: right; position: relative; overflow: auto;border:1px solid #cccccc;" class="runtext">
                <div id="divRight" class="ContainerWebPartZone" style="height: 100%; width: 100%;">
                    <asp:WebPartZone ID="WebPartZoneRight" HeaderText="Web Part Zone Right" Width="100%"
                        Height="90%" runat="server" CssClass="WebPartZone"
                        LayoutOrientation="Vertical">
                        <PartChromeStyle CssClass="PartChromeStyle" />
                        <MenuLabelHoverStyle CssClass="MenuLabelHoverStyle" />
                        <EmptyZoneTextStyle Font-Size="0.8em" />
                        <MenuLabelStyle CssClass="MenuLabelStyle" />
                        <MenuVerbHoverStyle CssClass="MenuVerbHoverStyle" BorderWidth="1px" />
                        <HeaderStyle CssClass="HeaderStyle" HorizontalAlign="Center" Font-Size="0.7em" />
                        <MenuVerbStyle ForeColor="Gray" Font-Size="8" />
                        <TitleBarVerbStyle CssClass="TitleBarVerbStyle" Font-Underline="false" />
                        <MenuPopupStyle Font-Names="Verdana" BackColor="White" BorderColor="LightGray" BorderWidth="1px" />
                        <PartTitleStyle Font-Size="0.7em" ForeColor="#003399" />
                    </asp:WebPartZone>
                </div>
            </div>
        </div>
    </div>
    <%-- <script language="javascript" type="text/javascript">
        if (navigator.appName == 'Netscape') {
            document.getElementById('divHeader').style.height = screen.availHeight * 40 / 100;
            document.getElementById('divLeft').style.height = screen.availHeight * 40 / 100;
            document.getElementById('divRight').style.height = screen.availHeight * 40 / 100;
            document.getElementById('divLeft').style.width = screen.availWidth * 49 / 100;
            document.getElementById('divRight').style.width = screen.availWidth * 49 / 100;
        }
        </script>--%>

     <script>

         try {
             document.getElementById("tblMain").style.display = "none";

         }
         catch (ex) {

         }

    </script>
</asp:Content>
