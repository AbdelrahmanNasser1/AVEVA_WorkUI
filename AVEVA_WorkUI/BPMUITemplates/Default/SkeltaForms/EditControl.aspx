<%@ Page Language="C#" AutoEventWireup="true" Inherits="EditFormProperties" EnableViewState="false" EnableEventValidation="false" %>

<%@ Register Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="Skelta.Forms.Web" Namespace="Skelta.Forms.Web" TagPrefix="cc1" %>
<%@ OutputCache Duration="60" Location="None" NoStore="true" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Edit Properties</title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
</head>
<body scroll="no" onunload="UnloadPage();">
    <link rel="stylesheet" type="text/css" href="<%:commonCssPath%>CommonUXControls/StyleSheet/se.ui.min.css">
    <link rel="stylesheet" type="text/css" href="<%:commonCssPath%>TelerikAjax/StyleSheet/AWTInput/Input.AWTInput.css" />
    <link rel="stylesheet" type="text/css" href="<%:commonCssPath%>TelerikAjax/StyleSheet/AWTCalendar/Calendar.AWTCalendar.css">
    <link rel="stylesheet" type="text/css" href="<%:commonCssPath%>TelerikAjax/StyleSheet/AWTCalendar/Calendar.css">
    <link rel="stylesheet" type="text/css" href="<%:commonCssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css">
    <link rel="stylesheet" type="text/css" href="<%:commonCssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css">
    <link rel="stylesheet" type="text/css" href="<%:commonCssPath%>TelerikAjax/StyleSheet/AWTTabStrip/TabStrip.AWTTabStrip.css">
    <link rel="stylesheet" type="text/css" href="<%:commonCssPath%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
    <link rel="stylesheet" type="text/css" href="<%:commonCssPath%>TelerikAjax/StyleSheet/AWTWindow/Window.css">
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        <script type="text/javascript">
            function OpenListItemLookup(ListLookupType, controlId, uniqueid, FormId, LookUpListName, xmlNodeBound, RepositoryName, versionStamp, loggedInUserId) {
                var u = "";
                if (ListLookupType == "PrintableForm")
                    u = _TemplateDirectorySkeltaForms + "FormItemLookup.aspx?sfdcontainer=" + escape(controlId) + "&controlid=" + escape(uniqueid) + "&associatedFormId=" + FormId + "&LkUpLstNm=" + LookUpListName + "&callingForm=" + xmlNodeBound + "&RepoName=" + RepositoryName + "&versionStamp=" + versionStamp + "&LoggedInUserId=" + loggedInUserId;
                else
                    u = _TemplateDirectorySkeltaForms + "ListItemLookup.aspx?sfdcontainer=" + escape(controlId) + "&controlid=" + escape(uniqueid) + "&associatedFormId=" + FormId + "&LkUpLstNm=" + LookUpListName + "&callingForm=" + xmlNodeBound + "&RepoName=" + RepositoryName + "&versionStamp=" + versionStamp + "&LoggedInUserId=" + loggedInUserId;
                var features = ',resizable=yes';
                var oWindow1 = CenterWindow(u, 'controldelete', 520, 450, 50, features);
                return oWindow1;
            }

            function UnloadPage() {
                var isNewCtrl = document.getElementById("controlNewlyAdded").value;
                if (isNewCtrl == "True" && !parentAlreadyRefreshed)
                {
                    //Refresh the parent page.
                    window.opener.updateNewControl();
                }
            }
            var parentAlreadyRefreshed = false;
            function CloseAndRefreshParentPage()
            {
                window.opener.updateNewControl();
                parentAlreadyRefreshed = true;
                window.close();
            }

            function openListLookupControlPage(encrptedUrl) {
                try {
                    var features = ',resizable=no';
                    var url = _TemplateDirectorySkeltaForms + "ListLookupControl.aspx?" + encrptedUrl;
                    var oWindow1 = CenterWindow(url, 'ListLookupControl', 600, 500, 50, features);
                    return oWindow1;
                }
                catch (err)
                { }
            }

            function ValidateInvokeWorkflow() {
                try {
                    var workflow = document.getElementById(_skidmap[workflowDetailsId]).value;
                    var xmlVariable = document.getElementById(_skidmap[xmlVariableId]).value;
                    if (workflow && xmlVariable) {
                        return true;
                    }
                    alert('<%= invokeWorkflowValidationMessage%>');
                    return false;
                }
                catch (err)
                { }
            }

            function ValidateInvokeWorkflowSchema() {
                try {
                    var schema = document.getElementById(_skidmap[formSchemaLookupId]).value;
                    var workflow = document.getElementById(_skidmap[workflowDetailsId]).value;
                    var xmlVariable = document.getElementById(_skidmap[xmlVariableId]).value;
                    if (workflow && xmlVariable && schema) {
                        return true;
                    }
                    alert('<%= invokeWorkflowValidationMessage1%>');
                    return false;
                }
                catch (err)
                { }
            }

           function CenterWindow(url, windowName, windowWidth, windowHeight, windowOuterHeight, features) {
                var centerLeft = parseInt((window.screen.availWidth - windowWidth) / 2);
                var centerTop = parseInt(((window.screen.availHeight - windowHeight) / 2) - windowOuterHeight);
                var windowFeatures = 'width=' + windowWidth + ',height=' + windowHeight + ',left=' + centerLeft + ',top=' + centerTop + features;
                var win = window.open(url, windowName, windowFeatures);
                win.focus();
                return win;
            }
        </script>
        <asp:Panel ID="pnl" runat="server" ScrollBars="None">
            <asp:HiddenField ID="controlNewlyAdded" runat="server" />
        </asp:Panel>
    </form>
</body>
</html>
