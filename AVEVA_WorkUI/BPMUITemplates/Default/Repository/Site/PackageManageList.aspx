<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/BPMUITemplates/Default/Repository/Site/Html5MasterPage.master" Inherits="Skelta.Package.CodeBehind.PackageManageList" %>
<%@ Register Assembly="Skelta.Repository.Web" Namespace="Skelta.Repository.Web" TagPrefix="cc1" %>


<asp:Content ID="Content3" ContentPlaceHolderID="MenuTitle" runat="server"> 
    <div>		
         <%=listControl1.GlobalResourceSet.GetString("ec_menu_managepackage") %>							
    </div>
</asp:Content>



<asp:Content ID="Content1" ContentPlaceHolderID="Cont" Runat="Server">
    <cc1:PagCrumbs ID="pageCrumb" runat="server" />
    <cc1:ListControl ID="listControl1" runat="server" Height="100%" HeaderControlPath="/Repository/ListControl/ListHeader.ascx" MenuControlPath="/Repository/ListControl/ManagePackageRibbonBar.ascx" VersionMenuControlPath="/Repository/ListControl/VersioningRibbonBar.ascx" ShowAllStandardColumns="true"/>
    <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link href="<%=templateThemeDirectory%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
     <script>

         try {
             document.getElementById("tblMain").style.display = "none";

         }
         catch (ex) {

         }

         function showError(msg)
         {
             var pageTitle = "<%=listControl1.GlobalResourceSet.GetString("ec_menu_managepackage") %>";
             se.ui.messageDialog.showError(pageTitle, msg, null);
         }
    </script>
</asp:Content>
