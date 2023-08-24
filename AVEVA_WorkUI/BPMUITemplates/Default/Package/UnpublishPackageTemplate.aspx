<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Package.CodeBehind.UnpublishPackageTemplate" %>
<!Doctype html>
<HTML>
  <HEAD runat="server">
		<title><%= resourceManager.GlobalResourceSet.GetString("pkg_unpublish_Belly_title")%></title>
      <script src="../Common/JavaScripts/jquery.min.js"></script>
       <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
</HEAD>
	<body id="Body">

        <script language="javascript" type="text/javascript">
            function GetRadWindow() {
                var oWindow = null;
                if (window.frameElement != null)
                    oWindow = window.frameElement.radWindow;
                return oWindow;
            }

            function closeWindow() {
                var oWindow = GetRadWindow();
                window.parent.onclientCalled = false;
                window.parent.OnClientClose(oWindow);
                oWindow.close();
                window.parent.onclientCalled = null;
            }

            // Initialize locales for message dialog
            se.ui.messageDialog.setGlobalOptions({
                localization: { // All localization related default can be set
                    closeButtonCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                   okButtonCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                   cancelButtonCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                   showDetailsCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                   hideDetailsCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
               }
           });

           function showMessageAndClose(isError, message) {
               var pageTitle = '<%=resourceManager.GlobalResourceSet.GetString("pkg_unpublish_Belly_title") %>',
                self = window;

            if (isError) {
                se.ui.messageDialog.showError(pageTitle, message, closeHandlerFn);
            }
            else {
                se.ui.messageDialog.showAlert(pageTitle, message, closeHandlerFn);
            }


            // Only if it is a radWindow, hide it
            function closeHandlerFn() {
                self.closeWindow(false);
            }
        }
    </script>
		<form id="Form1" method="post" runat="server">	
            <%=System.Web.Helpers.AntiForgery.GetHtml()%>
		<link href="<%=themePath%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
            <link href="<%=themePath%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
			<table id="publishMessageTable" style="border-spacing:0;border-width:0;margin:auto;width:100%;" >
			 <tr>
                    <td  style="text-align: center;padding-top:11%;">
                        <asp:Label ID="unpublishMessage" runat="server" Text="" CssClass="description"></asp:Label>
                        </td>
                     </tr>
                     <tr>
                     <td  style="bottom: 17px;right: 15px;position: absolute;">
                        <asp:Button ID="closeButton" runat="server" Text="" OnClientClick="javascript:closeWindow();"
                            CssClass="inputbutton"/>
				</td>
				</tr>
				
			</table>		
		</form>
	</body>
</HTML>