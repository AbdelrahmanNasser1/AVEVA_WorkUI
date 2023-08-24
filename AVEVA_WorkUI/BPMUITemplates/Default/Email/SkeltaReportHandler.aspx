<%@ Page Language="C#" AutoEventWireup="true"  Inherits="Workflow.NET.CodeBehind.Mail.SkeltaReportHandler" Theme="" StylesheetTheme="" %>

<html>
<head id="Head1" runat="server">
<link rel="stylesheet" type="text/css" href="/EnterpriseConsole/BPMUITemplates/Default/Common/StyleSheet/Global.css">
    <title>
        <%= sr.GetString("report_handler")%>
    </title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <style type="text/css">
    
        .html, body {
        overflow-x: hidden;
        }
        .tablebg
        {
            height: 225px;
        }
    </style>
     <script src="../CommonUXControls/scripts/jquery.min.js"></script>
	<script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
    
</head>

    <script type="text/javascript">
function ShowMessagesWithBellyBar(messageToDisplay)
{  
    var bellyBarTitle = "<%=sr.GetString("Partitioning_Error_msge")%>";
    se.ui.messageDialog.showError(bellyBarTitle, messageToDisplay, function () {
        window.close();
    });
        }
  </script>

<body scroll="auto">
<form id="form1" runat="server">
<%=System.Web.Helpers.AntiForgery.GetHtml()%>
<asp:Panel ID="DropDownPannel" runat="server">
<br />
<table border="0" cellpadding="4" cellspacing="1" class='tablebg' width="50%" style="height:8;" align="center">
    <tr align="center">
    <td width="20%" class="lefttdbg"><font class="subtitle"><%= sr.GetString("report_handler_select_Report")%></font></td>
    <td width="60%" class="righttdbg"><font class="description">
        <asp:DropDownList ID="ReportTemplateList" AutoPostBack="true" runat="server" Width="300">
        </asp:DropDownList>
    </td>
    <td width="20%" class="lefttdbg"><font class="subtitle"><asp:Button ID="Download" Text="Download Report" runat="server" OnClick="On_DownloadClick" /></td>
    </tr>
</table> 
</asp:Panel>     
</form>
</body>
</html>