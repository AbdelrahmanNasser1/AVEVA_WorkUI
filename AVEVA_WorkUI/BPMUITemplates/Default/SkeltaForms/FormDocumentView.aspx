<%@ Page Language="C#" AutoEventWireup="true" Inherits="FormDocumentView" %>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Form</title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
</head>
<link rel="stylesheet" type="text/css" href="<%=cssPath%>SkeltaForms\StyleSheet\SkeltaForm.css" />


<body scroll="no" style="overflow: hidden;">
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <div>
            <asp:Label ID="errorMessageLabel" runat="server" CssClass="sf-formerror" />
            <asp:Panel ID="viewPanel" ScrollBars="None" runat="server">
            </asp:Panel>
            <iframe id="frame" runat="server" style="visibility: hidden; display: none;"></iframe>
        </div>
    </form>
</body>
</html>
