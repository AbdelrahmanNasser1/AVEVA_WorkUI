<%@ Page Language="C#" MasterPageFile="~/BPMUITemplates/Default/Repository/Site/HTML5MasterPage.master" EnableEventValidation="false" 
    AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.HomePage2" Title="Untitled Page" %>
<%@ Register Src="WebPartManager.ascx" TagName="ECWebPartManager"
    TagPrefix="uc1" %>


<asp:Content ID="Content3" ContentPlaceHolderID="MenuTitle" runat="server"> 
    <div>		
         <%=resourceManager.GlobalResourceSet.GetString("ec_menu_webpartdashboard") %>							
    </div>
</asp:Content>



<asp:Content ID="Content1" ContentPlaceHolderID="Cont" runat="server">
<style type="text/css">
    html, body {
        height:100%;
        overflow:hidden;
    }
</style>
    <div style="width: 100%; height: 100%; position: absolute;overflow:hidden;">
        <uc1:ECWebPartManager ID="ECWebPartManager1" runat="server" />
        <div style="height: 49%;width:100%; position: relative;overflow:auto;">
            <div id="divHeader" class="ContainerWebPartZone" style="height: 75%;">
                            <asp:WebPartZone ID="WebPartZoneHeader" HeaderText="Web Part Zone Header" Width="100%"
                                Height="90%" runat="server" ShowTitleIcons="true" class="WebPartZone"
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
        <div style="height: 50%; width:99%; margin-left:7px; position: relative;padding-top:5px;padding-left:2px;">
            <div id="content" style="width: 50%; height: 83%; float: left; position: absolute;overflow:auto; border:1px solid #BBBBBB;">
                  <div id="divLeft" class="ContainerWebPartZone" style="height: 80%; width: 100%;">
                    <asp:WebPartZone ID="WebPartZoneLeft" HeaderText="Web Part Zone Left" Width="100%"
                        Height="98%" runat="server" class="WebPartZone"
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
            <div style="width: 49%; height: 84%; float: right; position: relative; border:1px solid #BBBBBB;overflow:auto;margin-right:0px;" class="runtext">
                  <div id="divRight" class="ContainerWebPartZone" style="height: 80%; width: 100%;">
                    <asp:WebPartZone ID="WebPartZoneRight" HeaderText="Web Part Zone Right" Width="100%"
                        Height="98%" runat="server" class="WebPartZone"
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

     <script>

         try
         {
             document.getElementById("tblMain").style.display = "none";
         }
         catch (ex) {

         }

         function isIE11() {
             return !!navigator.userAgent.match(/Trident.*rv[ :]*11\./);
         }

         function ResizeGrid() {
             if (isIE11()) {
                 try
                 {
                     window.setTimeout(function () { wgDoResize(true, true); }, 600);
                 }
                 catch (ex)
                 {
                 }
                 return true;
             }
         }

         ResizeGrid();

    </script>
</asp:Content>