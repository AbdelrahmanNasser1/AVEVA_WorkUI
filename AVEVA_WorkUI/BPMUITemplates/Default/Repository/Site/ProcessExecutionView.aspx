<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProcessExecutionView.aspx.cs" Inherits="ProcessExecutionView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >

<head runat="server">
    <title>Process Execution view</title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>    
    <table width="100%" cellpadding="0" cellspacing="0" border="0">
    <tr>
    <td>
      <asp:Panel ID="Panel1" runat="server"  Width="100%" Height="100%">
      </asp:Panel> 
    </td>
    </tr>
    </table>
     </form>
</body>
</html>
