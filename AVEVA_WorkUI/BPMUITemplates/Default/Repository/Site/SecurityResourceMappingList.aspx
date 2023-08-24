<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.SecurityResourceMappingList" Title="Security Resource Mapping" %>
<%@ Register Assembly="Skelta.Repository.Web" Namespace="Skelta.Repository.Web" TagPrefix="cc1" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!Doctype HTML>
<HTML>
    <head>
        <title><%=_ResManager.GlobalResourceSet.GetString("ec_srm_customization_title") %></title>
        <script src="../../Common/JavaScripts/jquery.min.js"></script>
        <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    </head>
    <style type="text/css">
        html,body{height:100%;overflow:hidden;}
    </style>
    <body>
    <form id="form1" style="height:100%;width:100%" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
         <cc1:PagCrumbs ID="pageCrumb" runat="server" />
<cc1:ListControl ID="ListControl1" runat="server" Height="100%" HeaderControlPath="/Repository/ListControl/ListHeader.ascx" MenuControlPath="/Repository/ListControl/SecurityResourceMappingRibbonBar.ascx" VersionMenuControlPath="/Repository/ListControl/VersioningRibbonBar.ascx" ShowAllStandardColumns="true"/>
</form>
</body>
</HTML>

