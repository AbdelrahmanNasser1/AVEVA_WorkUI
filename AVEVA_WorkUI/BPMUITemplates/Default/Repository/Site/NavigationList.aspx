<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.NavigationList" %>
<%@ Register Assembly="Skelta.Repository.Web" Namespace="Skelta.Repository.Web" TagPrefix="cc1" %>



<asp:Content ID="Content3" ContentPlaceHolderID="MenuTitle" runat="server"> 
    <div>		
       <%=ListControl1.GlobalResourceSet.GetString("EC_UXmenu_NavigationList")%>		
    </div>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Cont" runat="Server">
    <cc1:PagCrumbs ID="pageCrumb" runat="server" />
    <cc1:ListControl ID="ListControl1" Height="100%" runat="server" HeaderControlPath="/Repository/ListControl/ListHeader.ascx" MenuControlPath="/Repository/ListControl/NavigationListRibbonBar.ascx" VersionMenuControlPath="/Repository/ListControl/VersioningRibbonBar.ascx" ShowAllStandardColumns="true"/>
    <script>

        try {
            document.getElementById("tblMain").style.display = "none";
        }
        catch (ex) {

        }

    </script>


</asp:Content>