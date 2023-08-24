<%@ Page Language="C#" AutoEventWireup="true" Inherits="InstanceForm" EnableViewState="false" EnableEventValidation="false" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Initiate Form</title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%:bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <script type="text/javascript">
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

        function SizeToFit() {
            if (window.radWindow) {
                try {
                    var oWnd = GetRadWindow();
                    oWnd.setSize(850, 650);
                }
                catch (err) {
                }
            }
        }

        function DisplayMessage(message) {
            se.ui.messageDialog.showAlert("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(skrm.GlobalResourceSet.GetString("ec_rbn_nl_formlink"), false)%>", message);
        }
    </script>
</head>
<body onload="SizeToFit()" bgcolor="#ffffff" style="overflow:hidden; height: 100%; width: 100%; font-size: 9px;
    border: none; margin: 0px 0px 0px 0px; padding: none;" leftmargin="0px" topmargin="0px"
    rightmargin="0px" bottommargin="0px" scroll="no">
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        
        <link rel="stylesheet" type="text/css" href="<%:cssPath %>CommonUXControls/StyleSheet/se.ui.min.css" />  
        <script type="text/javascript">
            // Initialize locales for message dialog
            se.ui.messageDialog.setGlobalOptions({
                    localization: { // All localization related default can be set
                    closeButtonCaption: "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(skrm.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption"),false) %>", // "Close" is the default value
                    okButtonCaption: "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(skrm.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption"),false) %>", // "OK" is the default value
                    cancelButtonCaption: "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(skrm.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption"),false) %>", // "Cancel" is the default value
                    showDetailsCaption: "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(skrm.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption"),false) %>", // "Show Details" is the default value
                    hideDetailsCaption: "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(skrm.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption"),false) %>" // "Hide Details" is the default value
                }
            });
    

            function OpenDSWindow(controlId) {
                var u = _TemplateDirectorySkeltaForms + "Lookuplist.aspx?sfdcontainer=" + escape(controlId);
                var oWindow1 = window.radopen(u, null);
                oWindow1.setSize(parseInt(document.body.clientWidth / 2), parseInt(document.body.clientHeight / 1.5));
                oWindow1.set_left(500);
                return oWindow1;
            }
        </script>
        <div>
            <asp:Panel ID="pnl1" ScrollBars="None" runat="server">
            </asp:Panel>
        </div>
    </form>
</body>
</html>
