<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Forms.Web.CodeBehind.ChoosePreviewForm" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="./js/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <script type="text/javascript">
        function RefreshGrid()
        {
            closeWin();
        }

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

        function hideWin()
        {
            var oWindow = GetRadWindow();
            oWindow.hide();
        }

        function openWin(uri)
        {
            var  w = screen.availWidth;
            var h = screen.availHeight;
            var winIsResizable = "1";
            var winIsScrollable = "0";
            var winHeight = (h * 85 / 100);
            var winWidth = (w * 85 / 100);
            var winLeft = (w - winWidth) / 2;
            var winTop = (h - winHeight) / 2;
            window.open(uri, '', "left=" + winLeft + ",top=" + winTop + ",width=" + winWidth + ",height=" + winHeight + ",resizable=" + winIsResizable + ",scrollbars=" + winIsScrollable + "\"");
            hideWin(); // here just hide the window, this will get closed when process designer closed.
        }
    </script>
</head>
<body>
    <script type="text/javascript" src="<%=JavaScriptPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link href="<%=ThemePath%>CommonUXControls/StyleSheet/se.ui.min.css"  rel="stylesheet" type="text/css" /> 
    <script type="text/javascript">
        se.ui.messageDialog.setGlobalOptions({
            localization: {
                closeButtonCaption: "<%=ResourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                okButtonCaption: "<%=ResourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
                cancelButtonCaption: "<%=ResourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                showDetailsCaption: "<%=ResourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                hideDetailsCaption: "<%=ResourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
            }
        });

        function DisplayErrorMessage(strTitle, strMessage, postMessageFn)
        {
            se.ui.messageDialog.showError(strTitle, strMessage, postMessageFn);
        }
    </script>
    <form id="form1" runat="server">
	<%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <div>
    
    </div>
    </form>
</body>
</html>
