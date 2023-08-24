<%@ Page Language="C#" AutoEventWireup="true" Inherits="ReplaceControl" %>
<%@ Register Assembly="Skelta.Forms.Web" Namespace="Skelta.Forms.Web" TagPrefix="cc1" %>
<%@ Register Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" TagPrefix="telerik" %>
<html>
<head runat="server">
    <title>Replace Control</title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
</head>
<body  bgcolor="#ffffff" style="height:100%;width:100%;font-size:9px; border: none; margin: 0px 0px 0px 0px; padding: none;" leftmargin="0px" topmargin="0px" rightmargin="0px" bottommargin="0px" scroll="no">
    <link rel="stylesheet" type="text/css" href="<%:commonCssPath%>CommonUXControls/StyleSheet/se.ui.min.css">
    <link rel="stylesheet" type="text/css" href="<%:commonCssPath%>TelerikAjax/StyleSheet/AWTInput/Input.AWTInput.css" />
    <link rel="stylesheet" type="text/css" href="<%:commonCssPath%>TelerikAjax/StyleSheet/AWTCalendar/Calendar.AWTCalendar.css">
    <link rel="stylesheet" type="text/css" href="<%:commonCssPath%>TelerikAjax/StyleSheet/AWTCalendar/Calendar.css">
    <link rel="stylesheet" type="text/css" href="<%:commonCssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css">
    <link rel="stylesheet" type="text/css" href="<%:commonCssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css">
    <link rel="stylesheet" type="text/css" href="<%:commonCssPath%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
    <link rel="stylesheet" type="text/css" href="<%:commonCssPath%>TelerikAjax/StyleSheet/AWTWindow/Window.css">
    <form id="form1" runat="server">
         <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        <div>
            <asp:Panel ID="pnl" ScrollBars=none runat="server">
            </asp:Panel>
        </div>
        <script>
            function postSaveAction()
            {
                window.opener.updateNewControl();
                window.close();
            }
        </script>
    </form>
</body>
</html>
