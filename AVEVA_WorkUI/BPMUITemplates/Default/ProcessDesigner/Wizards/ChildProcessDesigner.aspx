<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChildProcessDesigner.aspx.cs" Inherits="SkeltaTemplates_Default_Wizards_ChildProcessDesigner" Theme="" StylesheetTheme="" %>
<%@ OutputCache Duration="60" Location="None" NoStore="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head runat="server">
    <title><%: pageTitle%></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
</head>

<body >
<!--<body style="BORDER-RIGHT:0px; BORDER-TOP:0px; FONT-SIZE:11px; MARGIN:0px; BORDER-LEFT:0px; CURSOR:default; BORDER-BOTTOM:0px;"> -->
    <form id="form1" runat="server">
	<%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <div>
      <asp:Panel ID="pnlSubProcess" runat="server" ScrollBars="Auto">
        </asp:Panel>
    </div>
    </form>
    
</body>
</html>

