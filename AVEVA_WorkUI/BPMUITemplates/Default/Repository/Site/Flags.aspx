<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.Flags" %>

<%-- In IE 8, the page is appearing completely blank --%>
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">--%>
<! Doctype HTML>
<html>
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title><% _ResManager.GlobalResourceSet.GetString("ec_flag_wizard_title"); %></title>
    <link href="<%$ ReplaceTemplateExpn:Common/StyleSheet/Global.css%>" rel="stylesheet" type="text/css" />
    
    <script type="text/javascript">
       // window.onload = load();
        function NextPage()
    {
        var sg = document.getElementById('chkSecurityGroup');
        var rm = document.getElementById('chkResourceMapping');
        
        if(sg != null & rm != null)
        {
            if(sg.checked & rm.checked)
                window.location = "FlagforSGnRM.aspx?lcsuri=<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_PageParams, false) %>&item=SGRM&Turn-Off=<%=_Turn_Off %>";
            else if(sg.checked)
                window.location = "FlagSecurityGroup.aspx?lcsuri=<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_PageParams, false) %>&item=SG&Turn-Off=<%=_Turn_Off %>";
            else if(rm.checked)
                window.location = "FlagSecurityGroup.aspx?lcsuri=<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_PageParams, false) %>&item=RM&Turn-Off=<%=_Turn_Off %>";
            else
                se.ui.messageDialog.showError('<%= _ResManager.GlobalResourceSet.GetString("ec_flag_wizard_title") %>', '<%= _ResManager.GlobalResourceSet.GetString("ec_flag_select_any_checkbox") %>');
        }
        else if(sg != null)
        {
            if(sg.checked)
                window.location = "FlagSecurityGroup.aspx?lcsuri=<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_PageParams, false) %>&item=SG&Turn-Off=<%=_Turn_Off %>";
            else
                se.ui.messageDialog.showError('<%= _ResManager.GlobalResourceSet.GetString("ec_flag_wizard_title") %>', '<%= _ResManager.GlobalResourceSet.GetString("ec_flag_select_any_checkbox") %>');
        }
        else if(rm != null)
        {
            if(rm.checked)
                window.location = "FlagSecurityGroup.aspx?lcsuri=<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_PageParams, false) %>&item=RM&Turn-Off=<%=_Turn_Off %>";
            else
                se.ui.messageDialog.showError('<%= _ResManager.GlobalResourceSet.GetString("ec_flag_wizard_title") %>', '<%= _ResManager.GlobalResourceSet.GetString("ec_flag_select_any_checkbox") %>');
        }                
    }
    
    function CancelWizard()
    {
        if("<%=_ListItemId %>" == "00000000-0000-0000-0000-000000000000")
            window.location = "ListSettings.aspx?lcsuri=<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_PageParams, false) %>";
        else 
            window.location = "ListItemSettings.aspx?lcsuri=<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_PageParams, false) %>";
    }
        function loadImage() {
            if ("<%=_Title %>" == "Enable Security Wizard") {
                document.getElementById('flagImg').src = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(ThemeURL, false)%>Repository/Site/images/wizard/titleicon.gif";
        }
        else {
                document.getElementById('flagImg').src = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(ThemeURL, false)%>Repository/Site/images/wizard/titleicon1.gif";
        }
    }
</script>
</head>
<body>
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemeURL) %>CommonUXControls/StyleSheet/se.ui.min.css" />      
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
    </script>
    <form id="form1" name="form1" runat="server" method="post" action="">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
         <br />
        <br />
        <div style="margin-left:auto;margin-right:auto;width:700px">
               <table style="padding:15px;width:700px;border:1px solid; border-color:#666; vertical-align:middle">
            <tr>
                <td align="center" valign="top">
                    <table width="700" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td>
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td style="width:50px; padding:5px;">
                                            <img src="" id="flagImg" />
                                            <%--<img src="<%=ThemeURL%>Repository/Site/images/wizard/titleicon.gif" width="50" height="50" />--%>
                                            </td>
                                        <td>
                                            <span class="subtitle"><%=_Title %> </span>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td height="250" align="center" valign="middle" class="f0f0f0ColorCode">
                                <table width="95%" height="135" border="0" cellpadding="6" cellspacing="2" class="b9d1eaColorCode">
                                    <tr>
                                        <td align="left" valign="top" bgcolor="#FFFFFF" class="description">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td colspan="2" class="description">
                                                        <%=_Description%>
                                                        <br />
                                                        <br />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <span class="subtitle"><%=_ResManager.GlobalResourceSet.GetString("ec_select")%></span>
                                                      <%-- <hr style="width:70%" />--%></td>
                                                </tr>
                                                <tr>
                                                    <td width="15" height="36" align="center">
                                                        <br />
                                                        <br />
                                                        <br />
                                                    </td>
                                                    <td width="617">
                                                    
                                                            <asp:CheckBox ID="chkSecurityGroup" CssClass="inputcheckbox" Text="Security Group customization" runat="server" />
                                                            <br />
                                                            <asp:CheckBox ID="chkResourceMapping" CssClass="inputcheckbox" Text="Resource Mapping" runat="server" />
                                                        
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <table width="95%" height="30" border="0" cellpadding="6" cellspacing="3">
                                    <tr>
                                        <td align="right" class="runtext1">
                                            &nbsp;
                                            <input type="button" name="Cancel" value="<%=_ResManager.GlobalResourceSet.GetString("ec_cancel")%>" class="inputsecondarybutton" onclick="CancelWizard();" />
                                              <input type="button" name="Next" value="<%=_ResManager.GlobalResourceSet.GetString("ec_next")%>" class="inputbutton" onclick="NextPage(); "/><%--"javascript:window.location='Flags-02.html'+window.location.search"--%>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
            </div>
    </form>
    <script type="text/javascript">
        loadImage();
    </script>
</body>
    
</html>
