<%@ Page Language="C#" AutoEventWireup="true" Inherits="BPMUITemplates_Default_SkeltaForms_ImportForm" %>

<%@ OutputCache Duration="60" Location="None" NoStore="true" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title><%=pagetitle%></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <style>
        html, body, form
        {
            height: 100%;
            overflow: hidden;
        }
    </style>
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

        function LocalizeText() {
            document.getElementById('btnImport').value = '<%=buttonimporttext %>';
            document.getElementById('btnClose').value = '<%=buttonclosetext %>';
        }
        function import_ClientClick(sender) {            
            $(sender).attr('disabled', true);
            setTimeout(function () {
                $("#btnHidImport")[0].click();
            }, 0);            
            return false;
        }
    </script>
</head>
<body style="height: 100%; width: 100%; border: none; margin: 0px 0px 0px 0px; padding: 0px;" onload="LocalizeText();">

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
    <form id="frmImport" runat="server">
         <link href="<%=ThemePath%>CommonUXControls/StyleSheet/se.ui.min.css"  rel="stylesheet" type="text/css" /> 
        <link rel="stylesheet" type="text/css" href="<%=ThemePath%>SkeltaForms/StyleSheet/Designer.css" />
        <link rel="stylesheet" type="text/css" href="<%=ThemePath%>SkeltaForms/StyleSheet/SkeltaForm.css" />
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <title><%=pagetitle %></title>
        <table height="100%" width="100%" align="center" border="0" cellpadding="3" cellspacing="1">
            <tr>
                <td class="sf-formlabeldescription"><%=ImportFileText%></td>
                <tr height="50%" width="100%" align="center" valign="middle">
                    <td height="100%" width="100%" class="contenttdbg">
                        <input id="filepath" type="file" runat="server" style="width: 380px" class="inputs" />
                    </td>
                </tr>
            <tr>
                <td style="width: 100%">
                    <div style="height: 40px; width: 380px; outline-width: 0; padding: 0px 0px 0px 0px;">
                        <div class="successfulmsg">
                            <asp:Label ID="lblStatus" class="test" runat="server" Width="100%"></asp:Label>
                        </div>
                    </div>

                </td>
            </tr>
            <tr>
                <td class="footerbg" style="height:30px !important;">
                    <div style="float: right;">
                        <asp:Button ID="btnClose" runat="server" OnClick="btnClose_Click" CssClass="inputsecondarybutton" Style="margin-right: 2px;" Text="No" />
                        <asp:Button ID="btnImport" runat="server" Text="Yes" CssClass="sf-inputsBox" OnClientClick="return import_ClientClick(this)" />
                        <asp:Button ID="btnHidImport" runat="server" Text="Yes" CssClass="sf-inputsBox" OnClick="btnImport_Click" style="display:none" />
                    </div>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
