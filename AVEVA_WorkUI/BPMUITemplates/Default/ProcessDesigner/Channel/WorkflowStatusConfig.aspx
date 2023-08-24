<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.Channel.WorkflowStatusConfig"  %>

<script runat="server">  
  
</script>

<html>
<head id="Head1" runat="server">
    <title>Channels</title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
     <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script> 
     
</head>
<link href="<%=cssPath %>" rel="stylesheet" type="text/css">
<body>

     <script>

         se.ui.messageDialog.setGlobalOptions({
             localization: {
                 closeButtonCaption: "<%=GR.GetString("se_ui_messagedialog_close_caption") %>",
                okButtonCaption: "<%=GR.GetString("se_ui_messagedialog_ok_caption") %>",
                cancelButtonCaption: "<%=GR.GetString("se_ui_messagedialog_cancel_caption") %>",
                showDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_showdetails_caption") %>",
                hideDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_hidedetails_caption") %>"
            }
        });
        function DisplayMessage() {
            var strMessage = '<%=StrSetFormConfig %>';
            var strHdrMsg = '<%=GR.GetString("Workflow Execution Status") %>';
            se.ui.messageDialog.showAlert(strHdrMsg, strMessage);
        }

        
    </script>



    <form id="form1" runat="server">
		 <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <link href="<%=themePath%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
    <table border="0" cellpadding="0" cellspacing="1" height="100%" width="100%" style="border-spacing:0px">
			<tr height="95%"  valign="top">
				<td>
					<table border=0 height=22% width="100%" style="border-spacing:0px">					
						<tr>
							<td colspan="2" class="ListHeaderCss" style="vertical-align:middle; padding:0px">
							<table width=100% style="border-spacing:0px">
							<tr><td style="padding-left:5px"><span class="fontheading">
								<%=GR.GetString("Workflow Execution Status")%></span>	</td></tr>
							</table>
														
							</td>
						</tr>
						<tr>
							<td width="25%" class="lefttdbg" style="vertical-align:middle; padding-left: 5px;padding-top: 20px;">
							<span class="description">
							<%=GR.GetString("CanControlWorkflow")%></span>								
							</td>
							<td runat="server" id="CanControlWorkflow" class="lefttdbg" style="vertical-align:middle; padding-top: 20px;">
									<asp:CheckBox ID="chkCanControlWorkflow" CssClass="inputcheckbox" runat="server" Width=300 />
							</td>
						</tr>
						
						<tr>
							<td width="25%" valign="middle" class="lefttdbg" style="vertical-align:middle; padding-left: 5px;">
							<span class="description">
								<%=GR.GetString("OnlyAnalystsView")%>									</span>
							</td>
							<td runat="server" id="_OnlyAnalystsView" class="lefttdbg" style="vertical-align:middle">
									<asp:CheckBox ID="chkWorkflowStatus" CssClass="inputcheckbox" runat="server" Width=300 />
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td align="right" height=20 style="padding-right: 15px; padding-bottom: 15px">
					<asp:Button runat="server" ID="btnSave" OnClick="btnSave_Click" CssClass="inputbutton" />
				</td>
			</tr>
		</table>
    </form>
</body>
</html>
<script language="javascript" type="text/javascript">
	
</script>







