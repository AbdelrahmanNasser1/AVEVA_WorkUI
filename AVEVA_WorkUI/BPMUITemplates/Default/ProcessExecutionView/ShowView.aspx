<%@ Assembly Name="Workflow.NET.Web.Report.NET2" %>
<%@ Import namespace="Workflow.NET.Web.Report" %>
<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.ProcessExecutionView.ShowView" Theme="" StylesheetTheme="" %>


<html>
<head runat="server">
    <title><%=GR.GetString("Process execution view for")%> <%=wer.WorkflowExecutionDetails.WorkflowName+" ("+wer.WorkflowExecutionDetails.ExecutionId.ToString()+")" %></title>
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <meta http-equiv="X-UA-Compatible" content="IE=5">
    <style type="text/css">
        html, body
        {
            height:98%;
        }
    </style>
</head>
<body style="margin: 0px 0px 0px 0px; padding: 0px 0px 0px 0px; border: none;overflow:hidden;">
    <link rel="stylesheet" type="text/css" href="<%=cssPath %>CommonUXControls/StyleSheet/se.ui.min.css" />
    <script>
        // Initialize locales for message dialog
        se.ui.messageDialog.setGlobalOptions({
            localization: { // All localization related default can be set
                closeButtonCaption: "<%=GR.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                okButtonCaption: "<%=GR.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                cancelButtonCaption: "<%=GR.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                showDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                hideDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
            }
        });
    </script>
    <form id="form1" runat="server" style="height:100%;">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <asp:PlaceHolder ID="wevcontrol" runat="server"></asp:PlaceHolder>
    </form>
</body>
</html>