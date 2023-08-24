<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Check.aspx.cs" Inherits="SkeltaTemplates_Default_ProcessDesigner_Check" Theme="" StylesheetTheme="" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <table>
        <tr>
            <td>
                Instance Name :
            </td>
            
            <td>
                <asp:TextBox ID="txtInstancenme" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Portal URL :
            </td>
            
            <td>
                <asp:TextBox ID="txtPortalURL" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Task List Name :
            </td>
            
            <td>
                <asp:TextBox ID="txtTaskListName" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Authenticated User :
            </td>
            
            <td>
                <asp:TextBox ID="txtUser" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                PassWord :
            </td>
            
            <td>
                <asp:TextBox ID="txtPassWord" runat="server"></asp:TextBox>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
