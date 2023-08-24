<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.ProcessExecutionView.ShowXMLVariable" Theme="" StylesheetTheme="" %>
<%@ OutputCache Location="None"  %>
<html>
<head id="Head1" runat="server">
    <title><%=GR.GetString("Variable") + " " + Microsoft.Security.Application.Encoder.HtmlEncode(VariableName) + " " + GR.GetString("for Instance ID") + " - " + WE.ExecutionId.ToString() + " " + GR.GetString("of workflow ") + Microsoft.Security.Application.Encoder.HtmlEncode(WE.WorkflowName) + " "%></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
</head>
    
     <link href="<%=cssPath%>Common/StyleSheet/Global.css" rel="stylesheet" />

<body >
    <form id="form1" runat="server" style="width:100%;height:95%;overflow:hidden;">
	<%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <textarea readonly style="width:100%;height:100%" ><%=GetVariableValue() %></textarea>        
   </form>
</body>
</html>
