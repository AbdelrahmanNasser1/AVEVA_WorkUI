<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.UserLookup" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html >

<html  style="height:100%">
<head runat="server">

    <title><%=_ResManager.GlobalResourceSet.GetString("ec_userlookup_title")%></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <script type="text/javascript" >
        
        function GetRadWindow()
        {
            var oWindow = null;
            oWindow = window.frameElement.radWindow;
            return oWindow;
        }

        function setValues(users)
        {
            var oWindow = GetRadWindow();
            oWindow.close(users);
        }

        function validateButton() {
           se.ui.messageDialog.showError("<%=_ResManager.GlobalResourceSet.GetString("ec_userlookup_title")%>", "<%=_ResManager.GlobalResourceSet.GetString("ec_userlookup_btnValidation")%>");
        }
         
        function SetValuesForNonRadWindow(users,propName,propDispName,providerName) {
            
            if (window.opener != null) 
            {

                if (window.opener.DisplayBuildConditionForUsers != null) 
                {
                    window.opener.DisplayBuildConditionForUsers(users, propName, propDispName, providerName);
                }                
               
            }
           window.close();
        }

        function CloseUserLookupWin() 
        {                     
            window.opener.closeUserlookup();
        }

    </script>
</head>
<body style="height:100%" >
    <form id="form1" runat="server" style="height:98%">
        
	<%=System.Web.Helpers.AntiForgery.GetHtml()%>
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
                
                 se.ui.messageDialog.showError("<%=_ResManager.GlobalResourceSet.GetString("ec_userlookup_title")%>", message);

              }
        </script>
        <div style="height:100%;overflow:hidden;">
            <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
            <asp:Panel ID="PanelUserLookup" runat="server" height="92%">
            </asp:Panel>
            <table style="width:100%;height:8%;border-width:0;">
                <tr>
                    <td style="text-align:right;width:100%;padding-right:10px;padding-top:0px;">
                        <asp:Button ID="btnUserUpdate" runat="server" CssClass="inputbutton" OnClick="BtnUserUpdate_Click" /></td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
