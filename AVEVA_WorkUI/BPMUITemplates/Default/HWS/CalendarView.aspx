<%@ Page Language="C#" AutoEventWireup="true" EnableViewState="true"   Inherits="Workflow.NET.CodeBehind.Calendar.Controls.CalendarView" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOcType html >
<html>
<head runat="server">
    <title><%=PageTitle%></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <style>
        html, body
        {
            height: 100%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" style="height:100%">
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
		<div style="height:100%;overflow:hidden;">
			<asp:Panel ID="Panel1" runat="server" Height=100% Width="100%">
			</asp:Panel>
		</div>
    </form>
</body>
</html>
