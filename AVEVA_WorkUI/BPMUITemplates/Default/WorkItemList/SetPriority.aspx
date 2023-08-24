<%@ Page Language="C#" AutoEventWireup="true"  Inherits="Workflow.NET.CodeBehind.WorkItemList.SetPriority" Theme="" StylesheetTheme="" %>


<html>
<head id="Head1" runat="server">
    <title>Set Priority</title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
</head>
<script language="javascript" type="text/javascript">                
     function GridRefresh()
     {
         //Changed the function of Refreshing the grid window.opener.RefreshGrid();
         //Since now the window is not opening instead of it is opening in hidden iframe
         self.parent.RefreshGridwithoutclose();
     }
</script>
<body>
    <form id="form1" runat="server">
         <%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <div>
    
    </div>
    </form>
</body>
</html>
