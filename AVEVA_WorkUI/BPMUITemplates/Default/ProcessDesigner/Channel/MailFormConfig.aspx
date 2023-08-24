<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.Channel.MailFormConfig" Theme="" StylesheetTheme="" %>

<!--<script runat="server">

    //protected void OnCheckChange(object sender, EventArgs e)
    //{

    //    txtReminderTime.Enabled = chkFollowup.Checked;
    //}
</script>
-->
<html style="height:100%">
<head id="Head1" runat="server">
    <title>Channels</title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script> 
 </head>
<link href="<%=cssPath %>" rel="stylesheet" type="text/css">

<body style="height:100%">
    <script>

    se.ui.messageDialog.setGlobalOptions({
            localization: { 
                closeButtonCaption: "<%=resourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                okButtonCaption: "<%=resourceSet.GetString("se_ui_messagedialog_ok_caption") %>", 
                cancelButtonCaption: "<%=resourceSet.GetString("se_ui_messagedialog_cancel_caption") %>", 
                showDetailsCaption: "<%=resourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                hideDetailsCaption: "<%=resourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" 
            }
        });
   function closeHandlerFn()
    {
        //self.closeWindow(false);
    }
    function DisplayError() {
        var strHdrMsg = '<%=resourceSet.GetString("Channel_MailConfig") %>';
        var strMessage = '<%=resourceSet.GetString("SilentInstallation_InvalidInputs") %>';
        se.ui.messageDialog.showError(strHdrMsg, strMessage);
    }
    </script>
    <form id="form1" runat="server" onsubmit="javascript:return ValidateTime();">
		 <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <link href="<%=themePath%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
    <table border="0" cellpadding="0" height="100%" class="tablebg" width="100%" style="border-spacing: 0px">
			<tr height="95%"  valign="top">
				<td class="lefttdbg">
					<table border="0" height="10%" width="100%" style="border-spacing: 0px">
						<tr>
                            <td colspan="2" style="padding:0px" >
                            <table width="100%" class="ListHeaderCss"><tr><td style="padding-left: 5px"><span class="fontheading">
								<%=ChannelMailConfig%></span></td></tr> </table>
                            </td>
						</tr>
                        <tr>
                            <td colspan="2" style="height: 27px; padding-left: 5px">
                            <span class="note">
								<%=ChannelSaveMailConfig%></span>
                            </td>
                        </tr>
						<tr>
							<td style="height: 42px; width: 25%; padding-left: 5px; vertical-align: middle">
							<span class="description">
								<%=ChannelMailFollowup%></span>
							</td>
							<td style="width: 257px; height: 42px; vertical-align: middle; padding-left:0px;">
                                <asp:CheckBox ID="chkFollowup" AutoPostBack="true" CssClass="chkboxStyle"  OnCheckedChanged="OnCheckChange" runat="server"></asp:CheckBox>
							</td>
						</tr>
					</table>
                    <table border="0" height="10%" width="100%" style="border-spacing: 0px">
                        <tr>
							<td width="25%" class="input" style="height: 31px; padding-left: 5px;  vertical-align: middle">
							   <span class="description"> <%=ChannelMailReminderTime%></span>
							</td>
							<td style="height: 31px;  vertical-align: middle; padding-left: 5px;padding-right:15px;" >
							    <asp:TextBox ID="txtReminderTime" CssClass="txtboxStyle" runat="server"></asp:TextBox>
							</td>
                        </tr>
                    </table>
				</td>
			</tr>
			<tr>
				<td align="right" class="lefttdbg" style="height:18px; padding-bottom: 15px; padding-right: 15px">
					<asp:Button runat="server" Text="Save" ID="btnSave" OnClick="btnSave_Click" CssClass="inputbutton"/>
				</td>
			</tr>
		</table>
    </form>
</body>
</html>
<script language="javascript" type="text/javascript">

	function ValidateTime()
	{
        var toMatchstr='';
        var err=false;
        var errstr='';

		toMatchstr = document.getElementById('txtReminderTime').value;
		if (toMatchstr.indexOf('.') < 0 )
			toMatchstr += '.00:00:00'

		var timeSpanPat = /^\d*\.[0-2]{1}[0-3]{1}\:[0-5]{1}[0-9]{1}\:[0-5]{1}[0-9]{1}/;
		var timeSpanPat1 = /^\d*\.[0-1]{1}[0-9]{1}\:[0-5]{1}[0-9]{1}\:[0-5]{1}[0-9]{1}/;
		var matchArray = toMatchstr.match(timeSpanPat);
		var matchArray1 = toMatchstr.match(timeSpanPat1);
		if(matchArray == null && matchArray1 == null)
		{
		    errText = "<%=ChannelErrMsgTimeSpan%>";
			err=true;
			//errstr += errText + toMatchstr +"\r\n";
			errstr += errText + "\r\n";
			var strHdrMsg = '<%=resourceSet.GetString("Channel_MailConfig") %>';
		    se.ui.messageDialog.showError(strHdrMsg, errstr, closeHandlerFn);
			document.getElementById('txtReminderTime').value="0.00:00:00";
			return false;
		}
		else
		    return true;
		
	}

   

<%= messages %>

</script>
