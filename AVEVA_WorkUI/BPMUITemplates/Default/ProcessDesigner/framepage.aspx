<%@ Assembly Name="Workflow.NET.Web.Designer.NET2" %>
<%@ Import namespace="Workflow.NET.Web.Designer" %>
<%@ Page language="c#" AutoEventWireup="false" CodeFile="framePageCB.cs" inherits="Workflow.NET.Template.FramePageCB" Theme="" StylesheetTheme=""%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>FramePage</title>
        <script src="../Common/JavaScripts/jquery.min.js"></script>
        <script src="../Common/JavaScripts/AutoLogoff.js"></script>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
	</head>
	<body>
	Frame Page
		<form id="Form1" method="post" runat="server">
			<%=System.Web.Helpers.AntiForgery.GetHtml()%>
		</form>
	</body>
</html>
