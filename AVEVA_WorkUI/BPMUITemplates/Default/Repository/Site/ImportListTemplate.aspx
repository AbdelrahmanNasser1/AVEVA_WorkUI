<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.CodeBehind.Codebehind.Site.ImportListTemplate" %>

<!DOCTYPE html>
<html style="height: 100%">
<head runat="server">
    <title>
        <%= resManager.GlobalResourceSet.GetString("ec_rbn_wf_ImportFromExcel")%></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <style type="text/css">
        .inputs {
            font-family: "Segoe UI", "Verdana";
            font-size: 12px;
            background-color: #FFFFFF;
            border: 1px solid #ccc;            
            color: #333333;
        }        

        .buttonMarging {
            margin-right: 5px;
        }
    </style>
    <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script>
</head>
<script type="text/javascript">

   
    function closeWin() {
        oWindow = GetRadWindow();
        setTimeout(function () {
            oWindow.close();
        }, 0);
    }

    function GetRadWindow() {
        var oWindow = null;
        if (window.frameElement != null)
            oWindow = window.frameElement.radWindow;
        return oWindow;
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
    
    
    function importButtonEnableDisable(disable) {
        var installButton = document.getElementById('btnImportData');
        installButton.disabled = disable;
    }

    function import_ClientClick(sender) {
        $(sender).attr('disabled', true);
        setTimeout(function () {
            $("#btnHidImport")[0].click();
        }, 0);
        return false;
    }

    function showSaveMessage(message) {
        
        se.ui.messageDialog.showAlert("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(resManager.GlobalResourceSet.GetString("ec_rbn_wf_ImportFromExcel"), false)%>", message, function () {
            closeWin();
        });

    }

    function showErrorMessage(message) {
        se.ui.messageDialog.showError("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(resManager.GlobalResourceSet.GetString("ec_rbn_wf_ImportFromExcel"), false)%>", message);
    }

    function showValidationMessage(message) {
        se.ui.messageDialog.showError("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(resManager.GlobalResourceSet.GetString("ec_rbn_wf_ImportFromExcel"), false)%>", message, function () {
            closeWin();
        });
    }

</script>
    <body style="padding-right: 0px; overflow: hidden; height: 93%; padding-left: 0px; padding-bottom: 0px; margin: 0px; border-style: none; padding-top: 0px;">
    <form id="Form2" method="post" runat="server" style="height: 100%">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <link href="<%:themePath%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
        <link href="<%:themePath%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />

        <div style="height: 100%">
            <table id="pageHeaderTable" style="width: 92%; padding-top: 15px; margin: auto; height: 10%; border-width: 0" runat="server">
                <tr>
                    <td colspan="3">
                        <img alt="" src="<%=themePath%>/Repository/ListControl/images/Icon-package-add.png"
                            style="vertical-align: middle;" />
                        <span class="pagetitle">
                            <%= resManager.GlobalResourceSet.GetString("ec_rbn_wf_ImportFromExcel")%></span>
                        <br />
                        <div class="description" style="padding-left: 36px;">
                            <%= resManager.GlobalResourceSet.GetString("ec_rbn_wf_ImportFromExcelDesc")%>
                        </div>
                    </td>
                </tr>
            </table>
            <div id="BodyDiv" style="overflow: hidden; width: 98%; height: 65%">
                <table id="tblTemplatefile" style="width: 80%; border-width: 0px; margin: auto"
                    class="tablebg">
                    <tr>
                        <td class="lefttdbg" style="width: 40%; padding-left: 4px; padding-top:20px;">
                            <div class="subtitle">
                                <%=resManager.GlobalResourceSet.GetString("ec_ListImport_file") %>
                            </div>
                            <div class="description">
                                <%=resManager.GlobalResourceSet.GetString("ec_ListImport_filedesc") %>
                            </div>
                        </td>
                        <td class="righttdbg" style="width: 60%; padding-left: 4px; padding-top:20px; vertical-align: top">
                            <asp:FileUpload ID="listTemplateFile" runat="server" Width="100%" CssClass="inputs" onchange="importButtonEnableDisable(false)" />
                        </td>
                    </tr>                   
                </table>

            </div>
            <div style="bottom: 20px; right: 20px; position: absolute;">
                <input type="button" value="<%=resManager.GlobalResourceSet.GetString("pkg_cncl_btn") %>" onclick="javascript: closeWin();" class="inputsecondarybutton buttonMarging" />
                <asp:Button ID="btnImportData" runat="server" CssClass="inputbutton" disabled="true" OnClientClick="return import_ClientClick(this)" />
                <asp:Button ID="btnHidImport" runat="server" Text="Yes" CssClass="inputbutton" OnClick="btnImport_Click" style="display:none" />

            </div>

        </div>

        <script type="text/javascript">
          function GetRadWindow() {
              var oWindow = null;
              if (window.radWindow)
                  oWindow = window.radWindow;
              else if (window.frameElement.radWindow)
                  oWindow = window.frameElement.radWindow;
              return oWindow;
          }

          function closeWin() {
              oWindow = GetRadWindow();
              setTimeout(function () {
                  oWindow.close();
              }, 0);
          }

          function resizeWindow() {
              var oWindow = GetRadWindow();
              if (oWindow.isClosed() == false) {
                  oWindow.setSize(600, 380);
              }
          }

</script>
</form>
</body>
</html>
