<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.FlagforSGnRM" %>

<%-- In IE 8, the page is appearing completely blank --%>
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">--%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>
        <% _ResManager.GlobalResourceSet.GetString("ec_flag_wizard_title"); %>
    </title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <link href="<%$ ReplaceTemplateExpn:Common/StyleSheet/Global.css%>" rel="stylesheet" type="text/css" />
 

    <script type="text/javascript">
       // window.onload = load();
        function NextPage()
    {   
        var level;
        if("<%=_ListItemId %>" == "00000000-0000-0000-0000-000000000000")
            level = 'List';
        else
            level = 'ListItem';
        if(document.getElementById('rdoFalgs_0').checked)
              window.location = "SecurityGroupCustomizationList.aspx?lcsuri=<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_PageParams, false) %>&Level="+level;
        else if(document.getElementById('rdoFalgs_1').checked)
              window.location = "SecurityResourceMappingList.aspx?lcsuri=<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_PageParams, false) %>&Level="+level;
    }
    
    function CancelWizard()
    {
        if("<%=_ListItemId %>" == "00000000-0000-0000-0000-000000000000")
            window.location = "ListSettings.aspx?lcsuri=<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_PageParams,false) %>";
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
    <form id="form1" name="form1" runat="server" method="post" action="">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <br />
        <br />
        <div style="margin-left:auto;margin-right:auto;width:700px">
               <table style="padding:15px; width:700px;border:1px solid; border-color:#666; vertical-align:middle">
            <tr>
                <td align="center" valign="top">
                    <table width="700" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td>
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td style="width:50px; padding:5px;">                                          
                                              <img src="" id="flagImg"/>
                                              <%--<img src="<%=ThemeURL%>Repository/Site/images/wizard/titleicon.gif" width="50" height="50" />--%>
                                        </td>
                                        <td align="left">
                                            <span class="subtitle">
                                                <%=_Title %>
                                            </span>
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
                                                        <%=_Description %>
                                                        <br />
                                                        <br />
                                                    </td>
                                                </tr>
                                                <tr id="trSelect">
                                                    <td colspan="2">
                                                        <span class="subtitle"><%=_ResManager.GlobalResourceSet.GetString("ec_select")%></span>
                                                        <img src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemeURL)%>Repository/Site/images/wizard/title-HR.png" width="576" height="13" align="absmiddle" /></td>
                                                </tr>
                                                <tr>
                                                    <td width="15" height="36" align="center">
                                                        <br />
                                                        <br />
                                                    </td>
                                                    <td width="617">
                                                        <asp:RadioButtonList ID="rdoFalgs" CssClass="inputradio" runat="server" RepeatDirection="Vertical">
                                                            <asp:ListItem Text="Security Group Customization" Selected="true"></asp:ListItem>
                                                            <asp:ListItem Text="Resource Mapping"></asp:ListItem>
                                                        </asp:RadioButtonList>
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
                                            <input type="button" name="Cancel" value="<%=_ResManager.GlobalResourceSet.GetString("ec_cancel")%>" class="inputsecondarybutton" onclick="CancelWizard();" />
                                            <input type="button" name="Previous" value="<%=_ResManager.GlobalResourceSet.GetString("ec_previous")%>" class="inputbutton" onclick="javascript:window.location='flags.aspx?lcsuri=<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_PageParams, false) %>&Turn-Off=<%=_Turn_Off %>&flag=SGRM'" />
                                            <asp:Button ID="btnNext" Text=" Next " runat="server" CssClass="inputbutton" OnClick="btnNext_Click" />
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
