<%@ Page Language="C#" AutoEventWireup="true"  Inherits="Skelta.Repository.Web.CodeBehind.FromAssociation" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>FormsList Options</title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
   
<style type="text/css">
<!--
.style1 {font-size:12px; color:#333333; text-decoration:none; font-family: "Segoe UI", "Trebuchet MS";}
-->
</style>


</head>
<body>
    <form id="frmOptions" runat="server">
    <%=System.Web.Helpers.AntiForgery.GetHtml()%>
          <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
         <link href="<%=cssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css" rel="stylesheet" type="text/css" />
         <link href="<%=cssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css" rel="stylesheet" type="text/css" />
         <asp:Panel ID="pnl1" runat="server">
 
         </asp:Panel>
    </form>
</body>

</html>
