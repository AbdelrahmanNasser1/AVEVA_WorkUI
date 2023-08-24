<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.WorkItemList.GroupView" %>
<%@ Register Assembly="Skelta.HWS.WorkListChannel.Web.WorkItemUIControl" Namespace="Skelta.HWS.WorkListChannel.Web.WorkItemUIControl" TagPrefix="cc1" %>



<html>
<head runat="server">
    <title>GroupUI Page</title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
</head>
<body   rightmargin=0 bottommargin=0 topmargin=0 leftmargin=0 style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px;  PADDING-BOTTOM: 0px; MARGIN: 0px 0px 0px 0px; Border-style: none; PADDING-TOP: 0px;">
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <cc1:WorkItemUIControl ID="WorkItemUIControl1" runat="server" />    
    </form>
</body>
</html>
