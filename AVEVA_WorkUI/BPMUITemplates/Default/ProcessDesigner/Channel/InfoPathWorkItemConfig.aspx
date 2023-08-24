<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.Channel.InfoPathWorkItemConfig" Theme="" StylesheetTheme="" %>
<html>
<head id="Head1" runat="server">
    <title>Channels</title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
</head>
<link href="<%=cssPath %>" rel="stylesheet" type="text/css">
<body>
    <form id="form1" runat="server">
    <%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <table border="0" cellpadding="0" cellspacing="1" height="100%" width="100%" >
        <tr>
            <td valign="top">
            <table class="tableheaderbg" width="100%"><tr><td><span class="pagetitle"> <%=messages %></span></td></tr></table>
               
            </td>
        </tr>
                  </table>
    </form>
</body>
</html>
