<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.WorkItemList.ShowResourceCalendar" Theme="" StylesheetTheme="" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE HTML>
<html>
<head runat="server">
     <style>
        html,body {height:100%;}
    </style>
    <title><%=CalendarTitle%></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <script type="text/javascript">
        $(window).bind('resize', function (e) {
            if (window.RT) clearTimeout(window.RT);
            window.RT = setTimeout(function () {
                this.location.reload(false); /* false to get page from cache */
            }, 1);
        });
    </script>
</head>
<body style="padding-left:10px;padding-right:10px;">
    <form id="form1" runat="server" style="height:100%;overflow:hidden;">
	<%=System.Web.Helpers.AntiForgery.GetHtml()%>
         <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
    <div style="height:100%;overflow-y:auto;overflow-x:hidden">
        <asp:Panel ID="ResPanel" runat="server" Height="100%" Width="100%"></asp:Panel>  
    </div>
    </form>
</body>
</html>
