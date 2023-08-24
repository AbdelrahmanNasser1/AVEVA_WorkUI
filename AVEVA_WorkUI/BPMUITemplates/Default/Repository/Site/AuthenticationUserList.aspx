<%@ Page Language="C#" MasterPageFile="~/BPMUITemplates/Default/Repository/Site/Html5MasterPage.master" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.AuthenticationUserList" %>
<%@ Register Assembly="Skelta.Repository.Web" Namespace="Skelta.Repository.Web" TagPrefix="cc1" %>



<asp:Content ID="Content3" ContentPlaceHolderID="MenuTitle" runat="server"> 
    <div>		
        <%=ListControl1.GlobalResourceSet.GetString("ec_menu_user") %>					
    </div>
</asp:Content>



<asp:Content ID="Content1" ContentPlaceHolderID="Cont" runat="Server">
    <cc1:PagCrumbs ID="pageCrumb" runat="server" />
    <cc1:ListControl ID="ListControl1" runat="server"  HeaderControlPath="/Repository/ListControl/ListHeader.ascx" MenuControlPath="/Repository/ListControl/AuthenticationUserRibbonBar.ascx" VersionMenuControlPath="/Repository/ListControl/VersioningRibbonBar.ascx" Height="100%" />

     <script>

         try
         {
             document.getElementById("tblMain").style.display = "none";
         }
         catch (ex)
         {

         }

    </script>
</asp:Content>