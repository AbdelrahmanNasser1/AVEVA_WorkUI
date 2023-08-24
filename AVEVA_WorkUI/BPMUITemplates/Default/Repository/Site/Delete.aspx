<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.Delete" %>
   <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(cssPath)%>/Global.css" rel="stylesheet" type="text/css" />

<script runat="server">

</script>

<html>
<head runat="server">
    <title><%=deleteTitle%></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link href="<%$ ReplaceTemplateExpn:CommonUXControls/StyleSheet/se.ui.min.css%>"  rel="stylesheet" type="text/css" />  
  <!--[if lt IE 7]>
  <script defer type="text/javascript" src="styles/pngfix.js"></script>
  <![endif]-->
    <meta http-equiv="Pragma" content="no-cache" />
<%--    <link href="styles/aquila.css" rel="stylesheet" type="text/css" />
--%>
</head>
<body class="validation-bg">

<script language="javascript" type="text/javascript">

se.ui.messageDialog.setGlobalOptions({
    localization: {
        closeButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
        okButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
        cancelButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
        showDetailsCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
        hideDetailsCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
    }
});

function GetRadWindow()
{
   var oWindow = null;
  if (window.radWindow) 
	oWindow = window.radWindow;
  else if (window.frameElement.radWindow) 
	oWindow = window.frameElement.radWindow;
  return oWindow;
} 
function closeWindow() {
    try
    {
        
        var oWindow = GetRadWindow();        
        setTimeout(function () {
            oWindow.hide();
            window.parent.document.getElementById("mainframe").contentWindow.document.getElementById("gridframe").contentWindow.RefreshGrid();
        }, 0);
        
    }
    catch (err)
    {
        if (window.opener.location.href.indexOf('VersionGrid.aspx', 0) != -1) {
            if (window.opener.top.opener.location.href.indexOf('Association.aspx', 0) != -1) {
                window.opener.RefreshGrid();
                window.close();
            }
        }
    }
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
                     <td style="text-align:right;padding:10px;padding-top: 50px;">
                        <asp:Button ID="CloseButton" runat="server" Text="" OnClientClick="javascript:closeWindow();return false;"
                            CssClass="inputbutton" /></td>
                </tr>
            </table>
         </asp:Panel>
    </div>
    </form>
</body>
</html>
