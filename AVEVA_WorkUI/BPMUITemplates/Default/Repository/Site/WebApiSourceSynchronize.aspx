<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.CodeBehind.WebAPI.WebApiSourceSynchronize" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
    <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="../../CommonUXControls/StyleSheet/se.ui.min.css" /> 
    <script src="../../CommonUXControls/scripts/jquery.min.js"></script>
	<script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script>
<head runat="server">
    <title><%=this.SynchronizeTitle %></title>

</head>
	<body id="Body">        
        <script>
            se.ui.messageDialog.setGlobalOptions({
                localization: {
                    closeButtonCaption: "<%=ResourceManager.GetString("se_ui_messagedialog_close_caption") %>",
                    okButtonCaption: "<%=ResourceManager.GetString("se_ui_messagedialog_ok_caption") %>",
                    cancelButtonCaption: "<%=ResourceManager.GetString("se_ui_messagedialog_cancel_caption") %>",
                    showDetailsCaption: "<%=ResourceManager.GetString("se_ui_messagedialog_showdetails_caption") %>",
                    hideDetailsCaption: "<%=ResourceManager.GetString("se_ui_messagedialog_hidedetails_caption") %>"
                }
            });

            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow) oWindow = window.radWindow;
                else if (window.frameElement) {
                    if (window.frameElement.radWindow)
                        oWindow = window.frameElement.radWindow;
                    else
                        window.location.reload();
                }
                return oWindow;
            }
            function closeWindow() {
                var oWindow = GetRadWindow();
                oWindow.hide();
            }

            function closeWindowAndRefreshGrid() {
                refreshParentGrid();
                var oWindow = GetRadWindow();
                oWindow.hide();
            }

            function refreshParentGrid() {
                if (self.opener) {
                    try {
                        self.opener.document.getElementById("mainframe").contentWindow.document.getElementById("gridframe").contentWindow.RefreshGrid();
                    }
                    catch (err) { }
                    //window.close();
                }
                else {
                    try {
                        window.parent.document.getElementById("mainframe").contentWindow.document.getElementById("gridframe").contentWindow.RefreshGrid();
                    }
                    catch (err) { }
                }
            }
        </script>
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <table visible="true" id=indicator border="0" cellpadding="0" cellspacing="0" width="0" height="40" align="center" >
				<tr>
					<td  align="center" width="100%" class="description"></td>
				</tr>
			</table>
        <table id="MessageTable" style="border-spacing: 0; border-width: 0; margin: auto;padding-top:5px;">
            <tr>
                <td align="center" width="100%">
                        
                    <div id="innerMessage" style="height:80px;overflow:auto;">
                        <asp:Label ID="LabelSyncMessage" runat="server" Text="" CssClass="successfulmsg"></asp:Label>
                    </div>
                </td>
            </tr>
        </table>
        <table style="border-width:0;border-spacing:0;width:100%;">
            <tr>
                <td style="text-align:right;padding-top: 13px;padding-right:10px;">
                    <asp:Button ID="ButtonClose" runat="server" Text="Close" OnClientClick="closeWindowAndRefreshGrid()" CssClass="inputbutton"/>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
