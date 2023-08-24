<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.List.ListView.DeleteView" %>
   <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(cssPath)%>/Global.css" rel="stylesheet" type="text/css" />

<script runat="server">

</script>

<html>
<head runat="server">
    <title><%=deleteTitle%></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
     <!--[if lt IE 7]>
  <script defer type="text/javascript" src="styles/pngfix.js"></script>
  <![endif]-->
    <meta http-equiv="Pragma" content="no-cache" />
<%--    <link href="styles/aquila.css" rel="stylesheet" type="text/css" />
--%>
</head>
     <script src="<%=JSPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(cssPaths)%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
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
/*
function DeleteConfirm()
{
    var oWindow = GetRadWindow();
    var response = confirm("Are you sure want to delete");
    if(response)
    {  
       //oWindow.SetUrl(oWindow.GetUrl()+"&DelConfirm=true");
       document.form1.submit();
    }
    else
    {
           oWindow.Close();
    }
}
*/
   </script>
    <form id="form1" runat="server">
        <script>
            se.ui.messageDialog.setGlobalOptions({
                localization: {
                    closeButtonCaption: "<%=resourcesManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                        okButtonCaption: "<%=resourcesManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
                        cancelButtonCaption: "<%=resourcesManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                        showDetailsCaption: "<%=resourcesManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                        hideDetailsCaption: "<%=resourcesManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
                    }
                });
        </script>
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <div class="validation-bg">
       <!--<asp:Panel ID="ConfirmPanel" runat="server" Visible="false">
       <br /><br />
       <table cellpadding="5px" cellspacing="0" border="0" align="center" width="300">
       <tr>
       <td colspan="2" align="center" class="runtext"><%=delConfirmText%></td>
       </tr>
       <tr>
       <td align="right"> 
           <asp:Button ID="YesButton" runat="server" Text="" OnClick="Yes_Click" CssClass="inputbutton" />
       </td>
       <td align="left"> 
           <asp:Button id="NoButton" runat="server"  Text=""  OnClientClick="javascript:closeWindow();return false;" class="inputbutton"/>
       </td>
       </tr>
       </table>
       </asp:Panel> -->
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
