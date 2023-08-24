<%@ Page Language="C#" AutoEventWireup="true" EnableViewState="true" EnableEventValidation="false"
    Inherits="Skelta.Forms.Web.CodeBehind.DynamicQueryBuilder"  %>

<%@ Register Src="UcDynamicControl.ascx" TagName="DynamicQuery" TagPrefix="ucDQ" %>
<!DOCTYPE html>
<html style="height:100%">
<head runat="server">
    <title></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <script type="text/javascript" >
        function GetRadWindow() {
            var oWindow = null;
            oWindow = window.frameElement.radWindow;
            return oWindow;
        }

        function setValues(squery) {
            var oWindow = GetRadWindow();
            oWindow.close(squery);
        }

        function SetQueryText(QueryText) {
            setValues(QueryText);
        }
        function HideWindow() {
            var oWindow = GetRadWindow();
            oWindow.close();
        }
    </script>
</head>
<body style="height:100%">
    <form id="frmDynamicQueryBuilder" runat="server" style="height:100%">
     <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
    <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>Common/StyleSheet/Global.css" />
    <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>TelerikAjax/StyleSheet/AWTInput/Input.AWTInput.css" />
    <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>TelerikAjax/StyleSheet/AWTTreeView/TreeView.AWTTreeView.css" />
    <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css" />
    <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css" />

    <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <div class="sf-formbackground" id="divparent" runat="server" style="height:100%">
        <ucDQ:DynamicQuery Id="IdDynamicQuery" runat="server">
        </ucDQ:DynamicQuery>
    </div>
    </form>
</body>
</html>
