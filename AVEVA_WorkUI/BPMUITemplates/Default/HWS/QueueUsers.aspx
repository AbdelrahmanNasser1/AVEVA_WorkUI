<%@ Page Language="C#" AutoEventWireup="true" EnableViewState="true"   Inherits="Workflow.NET.CodeBehind.Queue.QueueUsers" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE HTML>
<html>
<head runat="server">
    <title><%=QueueTitle%></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <style>
    html,body{ height:100%;overflow:hidden;}     
    </style>
</head>
<body>
    <form id="form1" runat="server" style="height:100%;">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        <asp:Panel ID="Panel1" runat="server" Width="100%">
        </asp:Panel>                 
    
    </form>
</body>
</html>
