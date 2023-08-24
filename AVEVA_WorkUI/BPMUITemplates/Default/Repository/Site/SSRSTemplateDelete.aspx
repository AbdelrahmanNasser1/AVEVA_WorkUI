<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.SSRS.Connector.CodeBehind.SSRSTemplateDelete" %>
<link  rel="stylesheet" href="<%=_CssPath%>Common/StyleSheet/Global.css" type="text/css" />

<script runat="server">

</script>

<html>
<head runat="server">
    <title><%=_GlobalResource.GetString("ec_ssrs_template_delete_title")%></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
     <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script>
      <link href="<%$ ReplaceTemplateExpn:CommonUXControls/StyleSheet/se.ui.min.css%>"  rel="stylesheet" type="text/css" />  
  <!--[if lt IE 7]>
  <script defer type="text/javascript" src="styles/pngfix.js"></script>
  <![endif]-->
<%--    <link href="styles/aquila.css" rel="stylesheet" type="text/css" />
--%>
</head>
<body>

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
function closeWin()
{
 var oWindow = GetRadWindow();             
 oWindow.close();
}

se.ui.messageDialog.setGlobalOptions({
    localization: {
        closeButtonCaption: "<%=_GlobalResource.GetString("se_ui_messagedialog_close_caption") %>",
        okButtonCaption: "<%=_GlobalResource.GetString("se_ui_messagedialog_ok_caption") %>",
        cancelButtonCaption: "<%=_GlobalResource.GetString("se_ui_messagedialog_cancel_caption") %>",
        showDetailsCaption: "<%=_GlobalResource.GetString("se_ui_messagedialog_showdetails_caption") %>",
        hideDetailsCaption: "<%=_GlobalResource.GetString("se_ui_messagedialog_hidedetails_caption") %>"
    }
    });
</script>
  <form id="form1" runat="server">
      <%=System.Web.Helpers.AntiForgery.GetHtml()%>
  <div >
       <asp:Panel ID="ConfirmPanel" runat="server">
       <br /><br />
       <table cellpadding="5" cellspacing="0" border="0" align="center" width="300">
       <tr>
       <td align="center">
            <asp:Label ID="LblErroMessage"   CssClass="successfulmsg"  Text="" runat="server"></asp:Label>
       </td>
       </tr>
       <tr>
           <td align="center">
                <input id="CloseButton" type="button"   value="Close" onclick="javascript:closeWin();return false;" class="inputbutton"/>
           </td>
       </tr>
       </table>
       </asp:Panel>
      &nbsp;
    </div>
    </form>
</body>
</html>
