<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.SecurityApprovalDocumentView" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<link href="<%=ThemeURL%>Common/StyleSheet/Global.css" rel="Stylesheet" />
<link href="<%=ThemeURL%>TelerikAjax/StyleSheet/AWTTabStrip/TabStrip.AWTTabStrip.css" rel="stylesheet" type="text/css" />
<html>
<head runat="server">
    <title>Requested Action Summary</title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
</head>
<body id="body" runat="server" leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0">
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server" />
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
            <table style="width:100%;height:95%;" >
            <tr>
             <td colspan="2">
            <asp:Panel ID="approvalDocView" runat="server" >
            </asp:Panel>
            </td>
            </tr>
        </table>
    </form>
</body>
</html>
