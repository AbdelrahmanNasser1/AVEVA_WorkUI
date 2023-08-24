<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.Site_Unlock" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <script language="javascript" type="text/javascript">
        function closeWindow() {
            window.open('', '_self', '');
            window.close();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
		<div>
		
		</div>
    </form>
</body>
</html>
