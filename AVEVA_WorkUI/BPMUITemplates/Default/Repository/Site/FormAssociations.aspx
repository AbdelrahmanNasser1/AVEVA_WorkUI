<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.FormAssociation" %>
<!DOCTYPE html >
<html style="height:100%">
<head id="Head1" runat="server">
    <title>_GRS.GlobalResourceSet.GetString("ec_cur_association_title")%></title>
</head>
<body style="margin:0;overflow:hidden;height:100%" >
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=ThemePath %>CommonUXControls/StyleSheet/se.ui.min.css" />      
    <script>
        // Initialize locales for message dialog
        se.ui.messageDialog.setGlobalOptions({
            localization: { // All localization related default can be set
                closeButtonCaption: "<%=_GRS.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                okButtonCaption: "<%=_GRS.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                cancelButtonCaption: "<%=_GRS.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                showDetailsCaption: "<%=_GRS.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                hideDetailsCaption: "<%=_GRS.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
            }
        });
    </script>
<script  type ="text/javascript">
    var themePath = '<%=Workflow.NET.Config.GetTemplateDirectoryFromWebConfig()%>';
    if (themePath.indexOf('layouts') > -1) {
        document.forms[0].style.height = '100% !important'; 
    }

function NaviagateBack(message)
{
//    window.parent.location.href('WorkflowList.aspx');
//    window.history.back();
    se.ui.messageDialog.showAlert("<%=_GRS.GlobalResourceSet.GetString("ecm_list_cm_view_associations") %>", message);
}

</script>
    <form id="form1" runat="server" style="height:100%">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <asp:Panel ID="ListPanel" runat="server" Height="100%" Width="100%">
        </asp:Panel>
    </form>
</body>
</html>
