<%@ Page Language="C#" Trace="false" AutoEventWireup="true" CodeBehind="~/BPMUITemplates/Default/ProcessDesigner/MessageConfiguration.aspx.cs"
    Inherits="ArchestrA.Mobile.Notification.ActivityProperty.MessageConfiguration" %>
<%@ Register Assembly="Skelta.Forms.Web" Namespace="Skelta.Forms.Web" TagPrefix="cc1" %>
<html>
<head id="Head1">
    <title>
        <%= sr.GetString("PushNotificationBrowserTitle")%>
    </title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link href="<%:processDesignerControl.GetCommonRelativeUrl("StyleSheet/Global.css")%>"
        rel="stylesheet" type="text/css" />
    <script type='text/javascript' src='<%:javaScriptPath%>'></script>
    <style type="text/css">
        .html, body
        {
            overflow-x: hidden;
        }
    </style>
</head>
<body onload="GetRadioButtonValue()">
    <script>
        se.ui.messageDialog.setGlobalOptions({
            localization: { // All localization related default can be set
                closeButtonCaption: "<%=sr.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                okButtonCaption: "<%=sr.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                cancelButtonCaption: "<%=sr.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                showDetailsCaption: "<%=sr.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                hideDetailsCaption: "<%=sr.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
            }
        });
    </script>
    <form id="form1" runat="server" style="height:100%;">
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
		<link href="<%:themePath%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
		<table border="0" cellpadding="3" cellspacing="1" width="100%">      
			<tr>          
                <td  style="width: 97%">
                    <span class="pagetitle">
                        <%= sr.GetString("PushNotificationPopHeading")%>
                    </span>
                </td>
                <td valign="right" >
                    <span title="Help">
                        <img src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(processDesignerControl.GetCommonRelativeUrl("Images/main-help.gif"))%>"
                            align="right" onclick="javascript:openhelpwin('All')" style="cursor: pointer"
                            alt="<%=sr.GetString("PushNotificationPopHelp")%>" /></span>
                </td>
        </tr>
    </table>
    <table border="0" cellpadding="8" cellspacing="1" width="100%" class="lefttdbg">
        <tr>
            <td class="description" valign="middle" colspan="2">
                <%= sr.GetString("PushNotificationPopDesc")%>
            </td>
        </tr>
    </table>
    <table border="0" cellpadding="6" cellspacing="1" width="98%" class="tablebg" align="center">
        <tr>
            <td class="lefttdbg" style="width: 50%">
                <span class="subtitle">
                    <%=sr.GetString("PushNotificationOprion")%>
                </span>
                <br />
                <span class="description">
                    <%=sr.GetString("PushNotificationOprionDesc")%>
                </span>
            </td>
            <td class="righttdbg">
                <asp:RadioButtonList ID="radioCustomizeNotification" runat="server" onclick="GetRadioButtonValue();"
                    CssClass="inputradio" RepeatDirection="Horizontal">
                    <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                    <asp:ListItem Text="No" Value="2"></asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
    </table>
    <table id="tblNotificationType" border="0" cellpadding="3" cellspacing="1" width="98%" class="tablebg" align="center">
        <tr>
            <td class="lefttdbg" style="width: 50%;vertical-align:top;">
                <span class="subtitle">
                    <%=sr.GetString("PushNotificationDeviceSelection")%>
                </span>
                <br />
                <span class="description">
                    <%=sr.GetString("PushNotificationDeviceSelectionDesc")%>
                </span>
            </td>
            <td class="righttdbg">
                <asp:CheckBoxList ID="checkBoxDevice" runat="server" onclick="GetRadioButtonValue();"
                    CssClass="inputcheckbox">
                    <asp:ListItem Selected="false" Value="1">
                                    iOS
                    </asp:ListItem>
					<asp:ListItem Selected="false" Value="2">
                                    Android
                    </asp:ListItem>
                    <asp:ListItem Selected="false" Value="3">
                                    Windows
                    </asp:ListItem>
                </asp:CheckBoxList>
                <table width="100%">
                    <tr>
                        <td style="width: 10%">
                        </td>
                        <td valign="middle">
                            <asp:RadioButton ID="radioTile" runat="server" Text="&nbsp;Tile" GroupName="Win8Message"
                                CssClass="inputradio" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 10%">
                        </td>
                        <td valign="middle">
                            <asp:RadioButton ID="radioToast" runat="server" Text="&nbsp;Toast" GroupName="Win8Message"
                                CssClass="inputradio" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table style="width:100%;border-collapse:separate;border-spacing:2px;">
        <tr>
            <td style="text-align:right;padding-bottom:45px;">
             <asp:Button ID="closeButton" runat="server" OnClick="CloseButton_Click" CssClass="inputsecondarybutton"
                    Text="Close" />
                <asp:Button ID="submit" runat="server" OnClick="Submit_Click"
                    CssClass="inputbutton" Text="Save" />
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
<script language="javascript" type="text/javascript">
    function openhelpwin(page) {
        var taretPage;
        if (page == "All") {
            taretPage = "PushNotificationMessage.html";
            window.open('<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(processDesignerControl.GetHelpPageUrl(), false)%>' + taretPage, 'helpwin', 'height = 450, width = 600,scrollbars=yes,resizable=yes');
        }
        else if (page == "Tile") {
            window.open('<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(processDesignerControl.GetHelpPageUrl(), false)%>' + 'TilePreview.html', 'helpwin', 'height = 700, width = 900,scrollbars=no,resizable=no');
        }
        else if (page == "Toast") {
            window.open('<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(processDesignerControl.GetHelpPageUrl(), false)%>' + 'ToastPreview.html', 'helpwin', 'height = 700, width = 900,scrollbars=no,resizable=no');
        }
    }

    function GetRadioButtonValue() {
      
      
        var list = document.getElementById("radioCustomizeNotification"); //Client ID of the radiolist
        var inputs = list.getElementsByTagName("input");
        var selected;
        for (var i = 0; i < inputs.length; i++) {
            if (inputs[i].checked) {
                selected = inputs[i];
                break;
            }
        }

        if (selected && selected.value == '2') {
            document.getElementById('tblNotificationType').style.visibility = 'visible';
            EnableDisableDeviceType(true);
        }
        else {
            document.getElementById('tblNotificationType').style.visibility = 'hidden';
            EnableDisableDeviceType(false);
        }
        return false;
    }

    function EnableDisableDeviceType(isEnable) {

        var list = document.getElementById("checkBoxDevice"); //Client ID of the radiolist
        var inputs = list.getElementsByTagName("input");
        var needDisable = true;
        for (var i = 0; i < inputs.length; i++) {
            if (isEnable) {
                inputs[i].disabled = false;
            }
            else {
                inputs[i].disabled = true;
            }

            if (inputs[i].disabled == false && (inputs[i].checked && inputs[i].value == 'on' || inputs[i].value == '2') && i == 1) 
            {
                needDisable = false;
                EnableDisableTileToast(true);
            }
        }

        if (needDisable) {
            EnableDisableTileToast(false);
        }
    }

    function EnableDisableTileToast(isEnable) {

        var tile = document.getElementById('radioTile');
        var toast = document.getElementById('radioToast');
        if (isEnable) 
        {
            if (tile != null && toast != null)
             {
                tile.disabled = false;
                toast.disabled = false;
            }
        }
        else {
            if (tile != null && toast != null) {
                tile.disabled = true;
                toast.disabled = true;
            }
        }

        if (!tile.checked && !toast.checked)
         {
            TileToastDefaultCheck(tile);
        }
    }

    function TileToastDefaultCheck(radioTobeChecked) 
    {
        radioTobeChecked.checked = true;
    }

</script>
