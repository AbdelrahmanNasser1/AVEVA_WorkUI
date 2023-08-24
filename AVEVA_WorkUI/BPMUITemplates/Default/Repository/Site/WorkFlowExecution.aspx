<%@ Assembly Name="Workflow.NET.Web.Report.NET2" %>
<%@ Import namespace="Workflow.NET.Web.Report" %>
<%@ Page Language="C#"  Debug="true"  AutoEventWireup="true" CodeFile="WorkFlowExecution.aspx.cs" Inherits="SkeltaTemplates_Default_ProcessDesigner_WorkFlowExecution" Theme="" StylesheetTheme="" %>
<html>
<head id="Head1" runat="server">
    <title></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
</head>

<body style="margin: 0px 0px 0px 0px; padding: 0px 0px 0px 0px; border: none; ">
    <form id="form1" runat="server"> 
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
   <%--  <table id="table1" width="100%" height="100%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
    <td align=center>
     <asp:dropdownlist ID="drpFormsList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="FormsList_SelectedIndexChanged">
         <asp:ListItem>Select Form</asp:ListItem>
     </asp:dropdownlist>
    </td>
    </tr>
    </table>  --%> 
    </form>
</body>
</html>