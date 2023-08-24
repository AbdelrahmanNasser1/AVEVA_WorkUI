<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.RoleLookup"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">

    <title><%= _ResManager.GlobalResourceSet.GetString("ec_rolelookup_title")%></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <script type="text/javascript" language="javascript">
        function GetRadWindow()
        {
            var oWindow = null;
            oWindow = window.frameElement.radWindow;
            return oWindow;
        }

        function setValues(roles)
        {
            var oWindow = GetRadWindow();
            oWindow.close(roles);
        }

        function validateButton() 
        {
           // alert('<%=_ResManager.GlobalResourceSet.GetString("ec_rolelookup_btnValidation")%>');
            se.ui.messageDialog.showError("<%=_ResManager.GlobalResourceSet.GetString("ec_rolelookup_title")%>", "<%=_ResManager.GlobalResourceSet.GetString("ec_rolelookup_btnValidation")%>");

        }
        function ReplaceAll(Source, stringToFind, stringToReplace)
        {
            var temp = Source;
            var index = temp.indexOf(stringToFind);

            while (index != -1)
            {
                temp = temp.replace(stringToFind, stringToReplace);
                index = temp.indexOf(stringToFind);
            }
            return temp;
        }

        function SetValuesForNonRadWindow(roles) 
        {
            if (window.opener != null) 
            {
                if (window.opener.DisplayBuildConditionForRoles != null) 
                {
                    window.opener.DisplayBuildConditionForRoles(roles);
                }
            }

            window.close();
        }

        function CloseRoleLookupWin() 
        {
            window.opener.closeUserlookup();
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <script src="<%=JSPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
        <link href="<%=cssPath%>CommonUXControls/StyleSheet/se.ui.min.css"  rel="stylesheet" type="text/css" />  
        <link href="<%=cssPath%>Common/StyleSheet/Global.css" rel="stylesheet" />
        <script>
            se.ui.messageDialog.setGlobalOptions({
                localization: {
                    closeButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                     okButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
                     cancelButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                     showDetailsCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                     hideDetailsCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
                 }
             });

             function DisplayErrorMessage(message) {

                 se.ui.messageDialog.showError("<%=_ResManager.GlobalResourceSet.GetString("ec_rolelookup_title")%>", message);

             }
        </script>
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <div>
             <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
            <asp:Panel ID="PanelUserLookup" runat="server">
            </asp:Panel>
            <table width="100%" cellSpacing="1" cellPadding="1" border="0">
                <tr>
                    <td align="right" height="24" width="100%" style="padding-right:10px;padding-top:9px;">
                        <asp:Button ID="btnRoleUpdate" runat="server" CssClass="inputbutton" OnClick="BtnRoleUpdate_Click" /></td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
