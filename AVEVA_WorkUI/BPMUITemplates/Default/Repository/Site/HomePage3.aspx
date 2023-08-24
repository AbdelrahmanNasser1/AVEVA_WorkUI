<%@ Page Language="C#" MasterPageFile="~/BPMUITemplates/Default/Repository/Site/HTML5MasterPage.master" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.HomePage3" EnableEventValidation="false" Title="Untitled Page" %>
<%@ Register Src="WebPartManager.ascx" TagName="ECWebPartManager" TagPrefix="uc1" %>


<asp:Content ID="Content3" ContentPlaceHolderID="MenuTitle" runat="server"> 
    <div>		
         <%=resourceManager.GlobalResourceSet.GetString("ec_menu_webpartdashboard") %>							
    </div>
</asp:Content>


<asp:Content ID="Content1" ContentPlaceHolderID="Cont" runat="server">
	<%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <div style="width: 100%; height: 100%; position: absolute">
        <uc1:ECWebPartManager ID="ECWebPartManager1" runat="server" />
        <div style="height: 20%;width:99%;position: relative; overflow: auto;border: 1px solid #CCC;">
            <div id="divHeader" class="ContainerWebPartZone" style="height: 94%; width: 99%;">
                <asp:WebPartZone ID="WebPartZoneHeader" HeaderText="Web Part Zone Header" Width="100%"
                    Height="98%" runat="server" ShowTitleIcons="true" CssClass="WebPartZone"
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

        <div style="height: 40%; width: 99.7%; position: relative;">
            <div style="width: 33%;height:99%; display: inline-block; float: left;border: 1px solid #CCC;overflow:auto;">
                <asp:WebPartZone ID="WebPartZoneLeft" HeaderText="Web Part Zone Left" Width="100%"
                    Height="98%" runat="server" CssClass="WebPartZone"
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
            <div style="width: 33%;height:99%; display: inline-block; float: left;border-top: 1px solid #CCC;border-bottom:1px solid #CCC;overflow:auto;">
                <asp:WebPartZone ID="WebPartZoneCenter" HeaderText="Web Part Zone Center" Width="100%"
                    Height="80%" runat="server" CssClass="WebPartZone"
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
           
            <div class="ContainerWebPartZone" style="width: 33%;height:99%; display: inline-block; float: left;border: 1px solid #CCC;overflow:auto;/*overflow-x:hidden !important;overflow-y:auto;*/">
               <%-- <div id="floatRight" class="ContainerWebPartZone" style="height: 95%; position: relative;">--%>
                    <asp:WebPartZone ID="WebPartZoneRight" HeaderText="Web Part Zone Right" Width="100%"
                        Height="95%" runat="server" CssClass="WebPartZone"
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
                <%--</div>--%>
            </div>
        </div>

        <div style="height: 38%; position: relative; overflow: auto;">
            <div id="divFooter" class="ContainerWebPartZone" style="height: 82%; width: 99%; overflow: auto; border: 1px solid #CCC;">
                <asp:WebPartZone ID="WebPartZoneFooter" HeaderText="Web Part Zone Footer" Width="95%"
                    Height="85%" runat="server" CssClass="WebPartZone"
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
        <script>

            try {
                document.getElementById("tblMain").style.display = "none";

            }
            catch (ex) {

            }

    </script>
</asp:Content>
