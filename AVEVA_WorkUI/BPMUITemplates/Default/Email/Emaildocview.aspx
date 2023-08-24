<%@ Page Language="C#" AutoEventWireup="true"  Inherits="Workflow.NET.CodeBehind.Mail.Emaildocview" Theme="" StylesheetTheme="" %>
<html>
<head runat="server">
    <title>Untitled Page</title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
</head>
<body scroll="auto">
<script type="text/javascript" language="javascript">
        function ShowMessage(msg)
        {
            alert(msg);
            window.close();            
        }        
</script>
    <form id="form1" runat="server">
	<%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <div>
    
    </div>
    </form>
</body>
</html>
