<%@ Page Language="C#" MasterPageFile="~/BPMUITemplates/Default/Repository/Site/HTML5MasterPage.master" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.ImpersonationUserList" %>
<%@ Register Assembly="Skelta.Repository.Web" Namespace="Skelta.Repository.Web" TagPrefix="cc1" %>


<asp:Content ID="Content3" ContentPlaceHolderID="MenuTitle" runat="server"> 
    <div>		
          <%=ListControl1.GlobalResourceSet.GetString("ec_menu_imperuser") %>									
    </div>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Cont" runat="Server">
    <cc1:PagCrumbs ID="pageCrumb" runat="server" />
    <cc1:ListControl ID="ListControl1" runat="server" HeaderControlPath="/Repository/ListControl/ListHeader.ascx" MenuControlPath="/Repository/ListControl/ImpersonationUserRibbonBar.ascx" VersionMenuControlPath="/Repository/ListControl/VersioningRibbonBar.ascx" Height="100%" />

     <script>

         try {
             document.getElementById("tblMain").style.display = "none";

         }
         catch (ex) {

         }

    </script>
</asp:Content>