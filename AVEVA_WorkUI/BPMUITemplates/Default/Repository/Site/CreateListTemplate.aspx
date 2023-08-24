<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.CodeBehind.Codebehind.Site.CreateListTemplate" %>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title><%=pagetitle%></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <style>
        html, body, form
        {
            height: 100%;
            overflow: hidden;
        }
    </style>
    <script type="text/javascript">

        var oWindow = null;
        function GetRadWindow() {
            oWindow = null;
            if (window.frameElement != null)
                oWindow = window.frameElement.radWindow;
            return oWindow;
        }

        function closeWin() {
            oWindow = GetRadWindow();
            setTimeout(function () {
                oWindow.close();
            }, 0);
        }

        function hideWin() {
            oWindow = GetRadWindow();
            setTimeout(function () {
                oWindow.hide();
            }, 0);
        }

        function downloadFileAndShowMessage() {
            document.getElementById("downloadExcel").click();
            setTimeout(showSaveMessage, 50);
        }

        function showSaveMessage() {
            hideWin();
            se.ui.messageDialog.showAlert("<%=resManager.GlobalResourceSet.GetString("ec_rbn_wf_CreateExcel") %>", "<%=resManager.GlobalResourceSet.GetString("ec_CreateExcel_Message") %>", function () {
                closeWin();
            });           

        }


    </script>
</head>
<body style="height: 100%; width: 100%; border: none; margin: 0px 0px 0px 0px; padding: 0px;" onload="downloadFileAndShowMessage();">

     <script>
         se.ui.messageDialog.setGlobalOptions({
             localization: {
                 closeButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                okButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
                cancelButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                showDetailsCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                hideDetailsCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
            }
        });

         function DisplayErrorMessage(strMessage) {
             var strHdrMsg = '<%=resManager.GlobalResourceSet.GetString("FormImportControlPageTitleText")%>';
             se.ui.messageDialog.showError(strHdrMsg, strMessage); 
         }
    </script>
    <form id="frmCreateTemplate" runat="server">
         <link href="<%=themePath%>CommonUXControls/StyleSheet/se.ui.min.css"  rel="stylesheet" type="text/css" />         
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>    

        <div style="display:none;">
            <asp:Button ID="downloadExcel" runat="server" OnClick="downloadExcel_Click" />
            <asp:HiddenField ID="hidValue" runat="server" />
        </div>

    </form>
</body>
</html>
