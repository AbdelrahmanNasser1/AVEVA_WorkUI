<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.ProcessDesignerView" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title><%=pageTitle%></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>     
</head>
<body>
    <form id="form1" runat="server">
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
		<telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
		<div>
			<asp:Panel ID="Panel1" runat="server" BorderWidth="0">
			</asp:Panel>
		
		</div>
    </form>
</body>
</html>
