<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Package.CodeBehind.ShipPackageTemplate" %>
<!DOCTYPE html>
<HTML style="height:100%">
<link href="<%=themePath%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
<head runat="server">
    <title><%= resourceManager.GlobalResourceSet.GetString("pkg_shp_ttl")%></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
      <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <style  type="text/css">
         .buttonMarging {
           margin-left:5px;
           display:none;
       }
        </style>
    </head>
<script type="text/javascript" language="javascript">
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

    function closeWin(msg) {        
        var oWindow = GetRadWindow();
        oWindow.close();
    }

    function resizeWindow() {
        var oWindow = GetRadWindow();
        oWindow.setSize(450,170);
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

    function showMessageAndClose(messageType, message) {
        var pageTitle = '<%=resourceManager.GlobalResourceSet.GetString("pkg_shp_ttl") %>',
                 self = window;
                var oWindow = GetRadWindow();
                switch (messageType) {
                    case "Error":
                        se.ui.messageDialog.showError(pageTitle, message, closeHandlerFn);
                        if (oWindow != null) {
                            oWindow.hide();
                        }
                        break;

                    case "Message":
                        se.ui.messageDialog.showAlert(pageTitle, message, closeHandlerFn);
                        if (oWindow != null) {
                            oWindow.hide();
                        }
                        break;

                    case "Confirmation":
                        se.ui.messageDialog.showConfirmation(pageTitle,
                         message,
                        function (userResponse) {
                            if (userResponse) {
                                document.getElementById("btnYes").click();
                                ////window.setTimeout(closeHandlerFn, 1);
                            }
                        });

                        if (oWindow != null) {
                            oWindow.hide();
                        }
                        break;

                    default:
                        // Only if it is a radWindow, show it
                        if (oWindow != null) {
                            oWindow.show();
                        }
                        break;
                }

                function closeHandlerFn() {
                    self.closeWindow(false);
                }
    }

    function closeHandlerFnRefresh() {
        window.setTimeout(self.closeWindow(false), 10);
    }
</script>
<body id="Body" style="margin: 0; left: 0; overflow: auto; height: 100%" onload="resizeWindow();">
		<form id="Form1" method="post" runat="server">		
            <link href="<%=themePath%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
            <%=System.Web.Helpers.AntiForgery.GetHtml()%>
		<div >
		<table id="pageHeaderTable" width="94%" border="0" align="center" runat="server">
       
        <tr style="height:15px;">
        <td></td>
        </tr>        
        <tr>
            <td style="text-align:center;padding-top:2%;" colspan="5">
                <asp:Label ID="shipMessage" runat="server" Text="" CssClass="successfulmsg"></asp:Label>
            </td>
        </tr>
    </table>	    
			<table cellpadding="1" cellspacing="0" border="0" width="100%">			
			
				<tr id="rowButton" runat="server">
				<td style="bottom: 18px;right: 15px;position: absolute;">
                            <input type="button" runat="server"  onclick="closeWin();" id="btnClose" class="inputsecondarybutton" style="display:none;"/>
                            <asp:Button ID="btnYes" runat="server" UseSubmitBehavior="false" Text="" CssClass="inputbutton buttonMarging"/> 
                            </td>    
				</tr>
               
				</table>		
				</div>
		</form>
	</body>
</HTML>
