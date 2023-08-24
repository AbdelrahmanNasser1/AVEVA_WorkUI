<%@ Page Language="C#" AutoEventWireup="true" Inherits="BPMUITemplates_Default_SkeltaForms_AddControl"%>
<%@ Register Assembly="Skelta.Forms.Web" Namespace="Skelta.Forms.Web" TagPrefix="cc1" %>
<%@ Register Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ OutputCache Duration="60" Location="None" NoStore="true" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title><%=pagetitle %></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
</head>
<body  style="height:100%;width:100%;font-size:9px; border: none; margin: 0px 0px 0px 0px;" leftmargin="0px" topmargin="0px" rightmargin="0px" bottommargin="0px" scroll="no">
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
        <asp:Panel ID="pnl1" ScrollBars=none>
            <cc1:FormRenderer ID="FormRenderer1" runat=server InDesignMode=false />
        </asp:Panel>    
        <script>
            function DisableNextButton(url)
            {
                //document.getElementById(buttonid).enabled=false;
                var curwin=window.opener.open(url,'editctrlredirectedpage','height='+document.body.clientHeight+',width='+document.body.clientWidth+',resizable=yes');
                window.opener.updateNewControl();
                window.close();
                curwin.focus();
            }
        </script>
    </form>
</body>
</html>
