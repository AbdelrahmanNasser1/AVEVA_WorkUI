<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.DeleteResourceMapping" %>
 <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(cssPath)%>/Global.css" rel="stylesheet" type="text/css" />
<!Doctype HTML>
<html>
<head runat="server">
    <title><%=_ResManager.GlobalResourceSet.GetString("ec_srm_del_title") %></title>
<%--    <link href="styles/aquila.css" rel="stylesheet" type="text/css" />
--%>
    <script type="text/javascript" language="javascript">
       function GetRadWindow(){
  var oWindow = null;

  if (window.radWindow) 
	oWindow = window.radWindow;
  else if (window.frameElement.radWindow) 
	oWindow = window.frameElement.radWindow;
	
  return oWindow;
}

function closeWin() {
    var oWindow = GetRadWindow();
    try
    {        
        oWindow.BrowserWindow.window.document.getElementById('mainframe').contentWindow.document.getElementById("gridframe").contentWindow.RefreshGrid();
    }
    catch (e)
    { }
    setTimeout(function ()
    {
        oWindow.close();
    }, 0);    
}
        function focusonno()
        {
            try
            {
            var userid = document.getElementById('btnNo');
            userid.focus();
            }
            catch(e)
            {}
        }
    </script>

</head>
<body style="overflow:hidden" onload="focusonno();">
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemeURL) %>CommonUXControls/StyleSheet/se.ui.min.css" />      
    <script>
        se.ui.messageDialog.setGlobalOptions({
            localization: {
                closeButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                okButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
                cancelButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                showDetailsCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                hideDetailsCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
            }
        });
    </script>
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <div>
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr height="40px">
                    <td class="bodytext" align="center">
                    <%--<img src="<%=ThemeURL%>Repository/Site/images/resource-mapping-delete.png" align="absmiddle" />&nbsp;&nbsp; --%>
                    </td>
                </tr>
                <tr><td class="description" align="center">
                <asp:Label ID="lblMessage" CssClass="description" runat="server" Text=""></asp:Label>
                </td></tr>
                <tr align="center">
                    <td class="bodytext" align="center"><br>
                        <asp:Button ID="btnYes" CssClass="inputbutton" runat="server" Text="Yes" Visible="true"
                            OnClick="btnYes_Click" />
                        <asp:Button ID="btnNo" CssClass="inputbutton" runat="server" Text="Cancel" Visible="true"
                            OnClick="btnNo_Click" />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
