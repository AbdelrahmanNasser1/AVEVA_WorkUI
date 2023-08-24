<%@ Page Language="C#" AutoEventWireup="true"  Inherits="Skelta.Repository.Web.CodeBehind.DeleteFWatcherFolder"%>
   <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(cssPath)%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
  
<html>
<head id="Head1" runat="server">
    <title>
        <%=GR.GetString("ec_filewatcher_deletefolder")%>
    </title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=JSPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>

    <script language="javascript" type="text/javascript">
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
    setTimeout(function () {
        window.parent.document.getElementById("mainframe").contentWindow.document.getElementById("gridframe").contentWindow.RefreshGrid();
    }, 0);
}

</script>

</head>
<body >
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

    <form id="form1" runat="server" >
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        
        <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(cssPath)%>CommonUXControls/StyleSheet/se.ui.min.css"  rel="stylesheet" type="text/css" />  
        <div>
            <asp:Panel ID="ConfirmPanel" runat="server">
                <br />
                <br />
                <table cellpadding="5px" cellspacing="0" border="0" align="center" width="300">
                    <tr>
                        <td colspan="2" align="center">
                           <!-- <%=GR.GetString("ec_filewatcher_confirm")%> -->
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Button ID="Button1" runat="server" CssClass="inputbutton" /></td>
                        <td align="left">
                            <asp:Button ID="Button2" runat="server" OnClientClick="javascript:closeWindow();return false;"
                                CssClass="inputbutton" /></td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel ID="DelPanel" runat="server" Visible="false">
                <table id="deleteMessageTable" cellpadding="15px" cellspacing="0" border="0" align="center">
                    <tr>
                        <td align="center">
                            <asp:Label ID="DeleteMessage" runat="server" CssClass="description"></asp:Label>
                        </td>
                    </tr>
                </table>
                <table border="0" cellpadding="8" cellspacing="0" width="100%">
                    <tr>
                        <td align="center">
                            <asp:Button ID="CloseButton" runat="server" OnClientClick="javascript:closeWindow();return false;"
                                CssClass="inputbutton" Width="75px" /></td>
                    </tr>
                </table>
            </asp:Panel>
        </div>
    </form>
</body>
</html>
