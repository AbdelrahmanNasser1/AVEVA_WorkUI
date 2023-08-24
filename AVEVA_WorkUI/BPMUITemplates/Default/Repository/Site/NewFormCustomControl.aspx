<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.NewFormCustomControl" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <style>
        html, body, form
        {
            height: 100%;
        }

    </style>
    <link rel="stylesheet" href="../../CommonUXControls/StyleSheet/se.ui.min.css" />
</head>
<body style="height: 100%; width: 100%; font-size: 9px; border: none; margin: 0px 0px 0px 0px;
    overflow: hidden" scroll="no">
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
    </form>
</body>
</html>
