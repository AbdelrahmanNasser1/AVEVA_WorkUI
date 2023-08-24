<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.WorkItemList.InvokeFormDocumentView" %>

<%@ Register Assembly="Skelta.HWS.WorkListChannel.Web.WorkItemUIControl" Namespace="Skelta.HWS.WorkListChannel.Web.WorkItemUIControl" TagPrefix="cc1" %>
<%@ Import Namespace="Skelta.HWS" %>
<html>
<head id="Head1" runat="server">
    <title>WorkItem Detail View</title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
</head>

<body style="background-color: #ffffff; margin: 0; overflow: hidden;">
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
        <table border="0">
            <tr>
                <td>
                    <asp:Panel ID="pnlDocumentView" BorderColor="red" Width="100%" runat="server"></asp:Panel>
                </td>
            </tr>
        </table>

    </form>
</body>
</html>
