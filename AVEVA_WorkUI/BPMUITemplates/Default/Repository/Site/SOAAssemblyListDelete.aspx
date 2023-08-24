<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.SOA.CodeBehind.Repository.SOAAssemblyListDelete" %>
    
<html>
<head runat="server">
    <title>
        <%=GR.GetString("soa_DeleteAssembly")%>
    </title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <link href="<%$ ReplaceTemplateExpn:Common/StyleSheet/Global.css%>" rel="stylesheet" type="text/css" />  
    <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script>
     <link href="<%$ ReplaceTemplateExpn:CommonUXControls/StyleSheet/se.ui.min.css%>"  rel="stylesheet" type="text/css" />  
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
  oWindow.close();
}
    </script>

</head>
<body >
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
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

        <div >
            <!--<asp:Panel ID="ConfirmPanel" runat="server" Visible="false">
                <br />
                <br />
                <table cellpadding="5px" cellspacing="0" border="0" align="center" width="300">
                    <tr>
                        <td colspan="2" align="center" class="runtext">
                            <%=GR.GetString("soa_sureyouwanttodelete")%>
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
            </asp:Panel>-->
            <asp:Panel ID="DelPanel" runat="server" Visible="true">
                <table id="deleteMessageTable" cellpadding="15px" cellspacing="0" border="0" align="center">
                    <tr>
                        <td align="center">
                            <asp:Label ID="DeleteMessage" runat="server" CssClass="successfulmsg"></asp:Label>
                        </td>
                    </tr>
                </table>
                <table border="0" cellpadding="8" cellspacing="0" width="100%">
                    <tr>
                        <td style="text-align:right;padding:8px;padding-top: 43px;">
                            <asp:Button ID="CloseButton" runat="server" OnClientClick="javascript:closeWindow();return false;"
                                CssClass="inputbutton" /></td>
                    </tr>
                </table>
            </asp:Panel>
        </div>
    </form>
</body>
</html>
