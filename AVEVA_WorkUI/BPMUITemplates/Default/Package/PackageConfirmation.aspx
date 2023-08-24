<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Package.CodeBehind.PackageConfirmation" %>
<!DOCTYPE html>
<html>
<link href="<%=themePath%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
<head runat="server">
    <title>
        <%=pageTitle%></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <style type="text/css">
        /*html,body{
              border-top:1px solid #666666;
        }*/
             .buttonMarging {
           margin-left:5px;
       }
    </style>
    <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
</head>
<body>
    <script language="javascript" type="text/javascript">
        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow)
                oWindow = window.radWindow;
            else if (window.frameElement.radWindow)
                oWindow = window.frameElement.radWindow;
            return oWindow;
        }

        function ConfirmYes() {
            var file = "<%=file%>";
            var app = "<%=applicationName%>";
            var listid = "<%=listId%>";
            var parent = "<%=parentItemId%>";
            var description = "<%=description%>";
            
            var name="<%=name%>";
            var version="<%=version%>";
            var mode="<%=mode%>";
            var include="<%=include%>";
            var listParams="<%=listParams%>";
            var objName = "<%=objectName%>";
            var pkgDefPath = "<%=packageFilePath%>";
            var url;
            var oBrowserWnd = GetRadWindow().BrowserWindow;
            if (name)
                //window.parent.location = "AddToPackageTemplate.aspx?" + listParams + "&pkgTmpName=" + name + "&pkgTmpVersion=" + version + "&mode=" + mode + "&include=" + include + "&AppName=" + app + "&Name=" + objName + "&pkgDefPath=" + pkgDefPath + "&pkgOverwrite=true";
                url = "..\\..\\Package\\AddToPackageTemplate.aspx?" + listParams + "&pkgTmpName=" + name + "&pkgTmpVersion=" + version + "&mode=" + mode + "&include=" + include + "&AppName=" + app + "&Name=" + objName + "&pkgDefPath=" + pkgDefPath + "&pkgOverwrite=true";
            else
                //oWindow.location = "AddPackage.aspx?mode=Confirm&file=" + file + "&app=" + app + "&listid=" + listid + "&parent=" + parent + "&description=" + description + "&pkgDefPath=" + pkgDefPath;
                url = "..\\..\\Package\\AddPackage.aspx?mode=Confirm&file=" + file + "&app=" + app + "&listid=" + listid + "&parent=" + parent + "&description=" + description + "&pkgDefPath=" + pkgDefPath;
            // Closing the current window while opening child window
            // closeParent parameter as true to close the parent window as well
            CloseWindow(true);
            var oWindow = oBrowserWnd.radopen(url, "WindowCloseBehaviour");
            oWindow.setSize(600, 500);
            oWindow.center();
        }

        function CloseWindow(closeParent) {
            var oWindow = GetRadWindow();
            oWindow.close(closeParent);
        }

        // Initialize locales for message dialog
        se.ui.messageDialog.setGlobalOptions({
            localization: { // All localization related default can be set
                closeButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                okButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                cancelButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                showDetailsCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                hideDetailsCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
            }
        });

        function showMessageAndClose(messageType, message) {
            var pageTitle = '<%=pageTitle%>',
                    self = window;
            var oWindow = GetRadWindow();
            switch (messageType) {
                case "Error":
                    se.ui.messageDialog.showError(pageTitle, message, closeHandlerFn);
                    break;
                case "Message":
                    se.ui.messageDialog.showAlert(pageTitle, message, closeHandlerFn);
                    break;
                default:
                    break;
            }
        }

        function closeHandlerFn() {
            var oWindow = GetRadWindow();
            // This is to close current window
            oWindow.hide();
            oWindow.close();
            if (oWindow.BrowserWindow.length > 1 && oWindow.BrowserWindow[1].name == 'WindowCloseBehaviour') {
                // This is to close parent window
                oWindow.BrowserWindow[1].close()
            }
            //window.parent.closeBellyWindow(false);
        }
    </script>

    <form id="form1" runat="server">
	<%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <link href="<%=themePath%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
    <div>
        <table border="0" width="100%" align="center">
            <tr>
                <td style="text-align: center;padding-top:8%;">
                    <img src="<%=themePath%>Repository/Site/images/icon-error.png" align="absmiddle" /><span
                        class="description">
                        <%=confirmationMessage%></span>
                </td>
            </tr>
            <tr>
               <td style="  bottom: 12px;right: 15px;position: absolute;">
                    <input id="btnNo" type="button" runat="server" class="inputsecondarybutton" onclick="javascript: CloseWindow(false);" />
                    <input id="btnYes" type="button" runat="server" class="inputbutton buttonMarging" onclick="javascript: ConfirmYes();" />
                   <asp:Button ID="buttonOverwriteManagePackage" runat="server" class="inputbutton buttonMarging" Text="Button" Visible="false" />
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>