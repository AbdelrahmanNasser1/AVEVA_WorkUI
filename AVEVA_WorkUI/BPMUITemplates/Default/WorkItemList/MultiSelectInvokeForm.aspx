<%@ Page Language="C#" AutoEventWireup="true"  Inherits="Skelta.Forms.Codebehind.WorkflowItemMultiSelectInvokeForm"  Theme="" StylesheetTheme=""  debug="true"%>
<%@ Register Assembly="Skelta.HWS.WorkListChannel.Web.WorkItemUIControl" Namespace="Skelta.HWS.WorkListChannel.Web.WorkItemUIControl" TagPrefix="cc1" %>
<!DOCTYPE html>
<html>
<head runat="server">
  <title></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <style>
        html, body, form {
            height: 100%;
            overflow:hidden
        }
    </style>
</head>
<body style="margin:0px;padding:0px;" >
    <form id="form1" runat="server">
         <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <link rel="stylesheet" type="text/css" href="<%=cssPath%>/Common/StyleSheet/Global.css" />
            <%if (enableTakeOwnership=="Yes"){ %>
        <table style="height:10%;width:100%;border-spacing:2px;border-collapse:separate;">
            <tr>
                <td style="text-align:right;padding:1px;">
                    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="inputselect"></asp:DropDownList>
                    <asp:Button ID="btnStatus" runat="server" Text="Go" CssClass="inputbutton"/>
                </td>
            </tr>
        </table>
            <%} %>
        <asp:Panel ID="pnl" runat="server" ScrollBars="Auto" Width="100%" Height="100%">
        </asp:Panel>    
    </form>
 <script type="text/javascript">
window.onbeforeunload = window.parent.opener.CheckMultiSelectInvokeFormClosed;
 </script> 
</body>
</html>
