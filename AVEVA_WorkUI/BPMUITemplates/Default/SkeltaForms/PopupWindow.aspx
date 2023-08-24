<%@ Page Language="C#" AutoEventWireup="true" CodeFile ="PopupLookuplist.cs" Inherits="PopupLookuplist" Debug="true" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<html>
<head runat="server">
    <title> DB list Explorer</title>
<link type="text/css" rel="stylesheet" href="<%$ReplaceTemplateExpn:telerik/RadControls/ComboBox/Skins/WindowsXP/Styles.css%>" />
<link type="text/css" rel="stylesheet" href="<%$ReplaceTemplateExpn:Repository/Site/styles/aquila.css%>" />
<link rel="stylesheet" type="text/css" href="<%$ReplaceTemplateExpn:SkeltaForms/StyleSheet/skeltaform.css%>" />
<script src="../Common/JavaScripts/jquery.min.js"></script>
<script src="../Common/JavaScripts/AutoLogoff.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
         <link href="<%=ThemePath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css" rel="stylesheet" type="text/css" />
         <link href="<%=ThemePath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css" rel="stylesheet" type="text/css" />
        <div>
        <table width="99%" align="center" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>
                    <img src="<%=ThemePath%>SkeltaForms/images/dashcurveLT.gif" width="7" height="7" /></td>
                <td height="7" align="center" background="<%=ThemePath%>SkeltaForms/images/dashtopline.gif">
                    <img src="<%=ThemePath%>SkeltaForms/images/dashtopline.gif" width="7" height="7" /></td>
                <td align="right">
                    <img src="<%=ThemePath%>SkeltaForms/images/dashcurveRT.gif" width="7" height="7" /></td>
            </tr>
            <tr>
                <td width="7" background="<%=ThemePath%>SkeltaForms/images/dashleftline.gif">
                    <img src="<%=ThemePath%>SkeltaForms/images/dashleftline.gif" width="7" height="7" /></td>
                <td height="50" bgcolor="#f1f1f1" class="sf-topleveltitle">
                    <img src="<%=ThemePath%>SkeltaForms/images/new-form-icon.png" align="absmiddle" />
                    &nbsp; Database Lookup
                    <br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="sf-formlabeldescription">
                        (
                       Select the data base connection item
                        )</span>
                </td>
                <td width="7" align="right" background="<%=ThemePath%>SkeltaForms/images/dashrightline.gif">
                    <img src="<%=ThemePath%>SkeltaForms/images/dashrightline.gif" width="7" height="7" /></td>
            </tr>
            <tr>
                <td valign="bottom">
                    <img src="<%=ThemePath%>SkeltaForms/images/dashcurveLB.gif" width="7" height="7" /></td>
                <td height="7" align="center" valign="bottom" background="<%=ThemePath%>SkeltaForms/images/dashbottomline.gif">
                    <img src="<%=ThemePath%>SkeltaForms/images/dashbottomline.gif" width="7" height="7" /></td>
                <td align="right" valign="bottom">
                    <img src="<%=ThemePath%>SkeltaForms/images/dashcurveRB.gif" width="7" height="7" /></td>
            </tr>
        </table>
        <table width="100%">
            <tr>
                <td height="1">
                </td>
            </tr>
        </table>
            <table border="0" width="100%">
                <tr>
                    <td style="height: 50" valign="bottom">
                        <asp:Panel ID="pnl1" runat="server" Height="100%">
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td align="right" class="sf-saverow" colspan="2" style="width: 100%">
                        <input type="submit" name="btnsubmit" value="Submit" id="btnSubmit" class="inputsBox"
                            onserverclick="sendData_click" runat="server" />
                        <input type="submit" name="btnClose" value="Close" onserverclick="close_click" id="btnClose"
                            class="inputsBox" runat="server" />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
