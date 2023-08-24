<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.ExecutionView" Title="ExecutionView Page" %>

<script src="../../Common/JavaScripts/jquery.min.js"></script>
<script src="../../Common/JavaScripts/AutoLogoff.js"></script>
<html>
<body>
<form runat="server">
    <%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <asp:Panel ID="Panel1" runat="server">
    </asp:Panel>
</form>
</body>
</html>

