<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.Channel.AspxFormConfig" Theme="" StylesheetTheme="" %>
<html>
<head runat="server">
    <title>Channels</title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
     <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script> 

     <%--<link href="<%=cssPath%>" rel="stylesheet" type="text/css">--%>
</head>
<link href="<%:cssPath%>" rel="stylesheet" type="text/css">
<body>
    <script>

        se.ui.messageDialog.setGlobalOptions({
            localization: {
                closeButtonCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                okButtonCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
                cancelButtonCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                showDetailsCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                hideDetailsCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
            }
         });
        function DisplayMessage() {
            var strMessage = '<%=resourceManager.GlobalResourceSet.GetString("AspxFormSaveMessage") %>';
             var strHdrMsg = '<%=resourceManager.GlobalResourceSet.GetString("ASPX Form Configuration") %>';
             se.ui.messageDialog.showAlert(strHdrMsg, strMessage);
        }

        function DisplayErrorMessage() {
            var strMessage = '<%=resourceManager.GlobalResourceSet.GetString("AspxFileEnterMessage") %>';
             var strHdrMsg = '<%=resourceManager.GlobalResourceSet.GetString("ASPX Form Configuration") %>';
             se.ui.messageDialog.showError(strHdrMsg, strMessage);
         }
        
    </script>



    <form id="form1" runat="server">
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
		<link href="<%:themePath%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
		<table border="0" cellpadding="0" height="100%" width="100%" style="border-spacing:0px">
			<tr height="95%" bgcolor=FFFFFF  valign="top">
				<td>
					<table border=0 height=10% width="100%" style="border-spacing:0px">
						<tr>
							<td colspan="2" style="padding:0px">
							<table class="ListHeaderCss" width="100%" style="border-spacing:0px"><tr><td style="padding-left: 5px"><span class="fontheading"><%=_StrAspxFormConfig%></span></td></tr></table>
								
							</td>
						</tr>
						<tr>
							<td width="30%" style="padding-top: 50px; padding-left: 5px" vertical-align: bottom;>
							<span class="description">
								<%=_StrAspxFileUrl%></span>
							</td>
							<td runat="server" id="_TDtoAddContents" style="height: 31px;  vertical-align: bottom; padding-left: 5px;padding-right:15px;">
									<asp:TextBox ID="txtInstance" CssClass="txtboxStyle" runat="server"></asp:TextBox>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td align="right" class="lefttdbg" style="height:18px; padding-bottom: 15px; padding-right: 15px">
					<asp:Button runat="server" Text="Save" ID="btnSave" OnClick="btnSave_Click" CssClass=inputbutton/>
				</td>
			</tr>
		</table>
    </form>
</body>
</html>

