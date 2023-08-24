<%@ Assembly Name="Workflow.NET.Web.Report.NET2" %>
<%@ Import namespace="Workflow.NET.Web.Report" %>
<%@ Page Language="C#" AutoEventWireup="true"  Inherits="Workflow.NET.CodeBehind.Bam.SkeltaTemplates_Default_BAM_ShowProcessView" Theme="" StylesheetTheme="" %>


<html  >
<head runat="server">
    <title><%=GR.GetString("Process execution view for")+" "+wer.WorkflowExecutionDetails.WorkflowName+" ("+wer.WorkflowExecutionDetails.ExecutionId.ToString()+")" %></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
</head>
<body>
    <form id="form1" runat="server">
	<%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <div>
        <asp:PlaceHolder ID="wevcontrol" runat="server"></asp:PlaceHolder>
    </div>
    </form>
</body>
</html>
