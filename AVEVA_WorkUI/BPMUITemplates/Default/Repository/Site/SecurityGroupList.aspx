<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.SecurityGroupList" Title="Security Group" %>
<%@ Register Assembly="Skelta.Repository.Web" Namespace="Skelta.Repository.Web" TagPrefix="cc1" %>

<asp:Content ID="Content3" ContentPlaceHolderID="MenuTitle" runat="server"> 
    <div>		       
       <%=ListControl1.GlobalResourceSet.GetString("EC_UXmenu_SecurityGroup")%>			
    </div>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Cont" runat="Server">
    <cc1:PagCrumbs ID="pageCrumb" runat="server" />
    <cc1:ListControl ID="ListControl1" runat="server" Height="100%" HeaderControlPath="/Repository/ListControl/ListHeader.ascx" MenuControlPath="/Repository/ListControl/SecurityGroupRibbonBar.ascx" ShowAllStandardColumns="true"/>

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

