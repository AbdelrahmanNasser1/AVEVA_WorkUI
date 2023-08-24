<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.ProcessDesigner" %>
<%@ Register Assembly="Workflow.NET.Web.Designer.NET2" Namespace="Workflow.NET.Web.Designer"
    TagPrefix="cc1" %>
<!Doctype HTML>
<html>
<head runat="server">
    <title>Process Designer for Workflow - <%:workflowName%> </title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
</head>
<body rightmargin=0 bottommargin=0 topmargin=0 leftmargin=0 style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; Border-style: none; PADDING-TOP: 0px;">
    <form id="form1" runat="server">
	<%=System.Web.Helpers.AntiForgery.GetHtml()%>
            <asp:Panel ID="Panel1" runat="server" BorderWidth="0">
        </asp:Panel>
    
        </form>
</body>
</html>
