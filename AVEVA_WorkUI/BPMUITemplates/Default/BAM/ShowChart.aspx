<%@ Page Language="C#" AutoEventWireup="true"  Inherits="Workflow.NET.CodeBehind.Bam.ShowChart" Theme="" StylesheetTheme="" %>
<%@ Register Assembly="Skelta.BAM" Namespace="Skelta.BAM.UserControls" TagPrefix="cc1" %>

<!DOCTYPE HTML>
<html>
<head>
    <title>Chart Test</title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <style type="text/css">
        html, body
        {
            height:98%;            
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" style="height:100%;">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <cc1:BAMDashboardChart ID="BAMDashboardChart1" runat="server" Height="100%" />
    </form>
</body>
</html>
