<%@ Page Language="C#" AutoEventWireup="true"  Inherits="Workflow.NET.CodeBehind.WorkItemList.WorkflowStatusView" %>

<html>
<head runat="server">
    <title>Workflow Status View</title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
</head>
<body style="border: none; margin: none; padding: none;overflow:-moz-scrollbars-none;" leftmargin="2px" topmargin="2px" rightmargin="2px" bottommargin="2px" scroll="no">
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <div>
        <asp:Panel ID="panelView" runat="server"></asp:Panel>
        </div>
    </form>
</body>
</html>
