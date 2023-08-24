<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DeleteGridView.aspx.cs" Inherits="BPMUITemplates_Default_Repository_Site_DeleteGridView"  %>
   <link href="<%=cssPath%>/Global.css" rel="stylesheet" type="text/css" />



<html>
<head id="Head1" runat="server">
    <title><%=deleteTitle%></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
  <!--[if lt IE 7]>
  <script defer type="text/javascript" src="styles/pngfix.js"></script>
  <![endif]-->
    <meta http-equiv="Pragma" content="no-cache" />
</head>
<body class="validation-bg">

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
se.ui.messageDialog.setGlobalOptions({
    localization: {
        closeButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                okButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
                cancelButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                showDetailsCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                hideDetailsCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
            }
     });
        
   </script>
  <form id="form1" runat="server">
    <%=System.Web.Helpers.AntiForgery.GetHtml()%>


  <div class="validation-bg">
       <link href="<%=cssPath%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
                <script src="<%=JSPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
       <asp:Panel ID="DelPanel" runat="server">
      <table id="deleteMessageTable" cellpadding="15px" cellspacing="0" border="0" align="center">
                <tr>
                    <td align="center">
                        <asp:Label ID="DeleteMessage" runat="server" Text="" CssClass="successfulmsg"></asp:Label>
                    </td>
                </tr>
            </table>
             <table border="0" cellpadding="8" cellspacing="0" width="100%">
                <tr>
                    <td align="center">
                        <asp:Button ID="CloseButton" runat="server" Text="" OnClientClick="javascript:closeWindow();return false;"
                            CssClass="inputbutton" Width="75px" /></td>
                </tr>
            </table>
         </asp:Panel>
    </div>
    </form>
</body>
</html>
