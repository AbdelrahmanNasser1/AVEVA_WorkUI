<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.DeleteNavigation" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(cssPath)%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
<head runat="server">
    <title>
        <%=deleteTitle%>
    </title>
    <meta http-equiv="Pragma" content="no-cache" />

    <script language="javascript" type="text/javascript">
    
function GetRadWindow()
{
   var oWindow = null;
  if (window.radWindow) 
	oWindow = window.radWindow;
  else if (window.frameElement.radWindow) 
	oWindow = window.frameElement.radWindow;
		var oTop = document.body.scrollTop;     
        document.body.scroll = "no";     
        document.body.style.overflow = "hidden";     
        document.body.scrollTop = oTop;   
  return oWindow;
} 
function closeWindow()
{
    var oWindow = GetRadWindow();
    try {
        oWindow.BrowserWindow.window.document.getElementById('mainframe').contentWindow.document.getElementById("gridframe").contentWindow.RefreshGrid();
    }
    catch (e) { }
    setTimeout(function () {
        oWindow.close();
    }, 0);   
}

    </script>

</head>
<body onload="GetRadWindow()">
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(cssPath) %>CommonUXControls/StyleSheet/se.ui.min.css" />      
    <script>
        // Initialize locales for message dialog
        se.ui.messageDialog.setGlobalOptions({
            localization: { // All localization related default can be set
                closeButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                okButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                cancelButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                showDetailsCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                hideDetailsCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
            }
        });
    </script>
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
        <div>
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
                        <asp:Button ID="btnOK" runat="server" OnClientClick="javascript:closeWindow();return false;"
                            CssClass="inputbutton" Width="75px" />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
