<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.CancelSecApprovalWF" %>
<html>
<head runat="server">
 <title><%=cancelAppWfTitle%></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
<meta http-equiv="Pragma" content="no-cache" />
<script language='JavaScript' type="text/javascript" >
function GetRadWindow()
{
   var oWindow = null;
  if (window.radWindow) 
	oWindow = window.radWindow;
  else if (window.frameElement.radWindow) 
	oWindow = window.frameElement.radWindow;
  return oWindow;
} 
function closeWindow()
{
  var oWindow = GetRadWindow();
  oWindow.close();
}
</script>
</head>
<link  rel="stylesheet" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(csspath)%>Common/StyleSheet/Global.css" type="text/css" />
<body id="body" runat="server" leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0">
     <script>
         se.ui.messageDialog.setGlobalOptions({
             localization: {
                 closeButtonCaption: "<%=GR.GetString("se_ui_messagedialog_close_caption") %>",
                 okButtonCaption: "<%=GR.GetString("se_ui_messagedialog_ok_caption") %>",
                 cancelButtonCaption: "<%=GR.GetString("se_ui_messagedialog_cancel_caption") %>",
                 showDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_showdetails_caption") %>",
                 hideDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_hidedetails_caption") %>"
             }
         });
    </script>

   
    <form id="form1" runat="server">
	<%=System.Web.Helpers.AntiForgery.GetHtml()%>
 <script src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(JSPath)%>CommonUXControls/scripts/window/se.ui.min.js"></script>
        <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(csspath)%>CommonUXControls/StyleSheet/se.ui.min.css"  rel="stylesheet" type="text/css" />  
        <div>
        <asp:Panel ID="CacelPanel" runat="server" Visible="True">
          <table id="CancelMessageTable" cellpadding="15px" cellspacing="0" border="0" align="center">
                    <tr>
                        <td align="center">
                            <asp:Label ID="CancelMessage" runat="server" Text="Simple Test" CssClass="description"></asp:Label>
                        </td>
                    </tr>
                </table>
                 <table border="0" cellpadding="8" cellspacing="0" width="100%">
                    <tr>
                        <td align="center">
                            <asp:Button ID="CloseButton" runat="server" Text="Close" OnClientClick="javascript:closeWindow();return false;"
                                CssClass="inputbutton" Width="75px" /></td>
                    </tr>
                </table>
         </asp:Panel>
        </div>
    </form>
</body>
</html>
