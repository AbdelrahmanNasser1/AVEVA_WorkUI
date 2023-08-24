<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.Bam.ReportErrorPage" %>
<link rel="stylesheet" type="text/css" href="<%=cssPath %>Common/StyleSheet/Global.css" />
<html>
<head runat="server">
    <title>Report Error</title>
</head>
<body>
    <form id="form1" runat="server">
	<%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <table style="width:100%;height:100%;">
            <tr style="width:100%;height:100%;">
                <td style="width:100%;height:100%;" valign="middle" align="center">
                    <asp:Label ID="errorMessage" CssClass="errormsg" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
