<%@ Page Language="C#" Trace="false" AutoEventWireup="true" Debug="true" Inherits="Workflow.NET.CodeBehind.PropertyTypes.SsrsReportTemplates" %>
<%@ Register Assembly="Skelta.Forms.Web" Namespace="Skelta.Forms.Web" TagPrefix="cc1" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE html>
<html>
<head id="Head1">
   <title>
      
    </title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script> 
    <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ProcessDesignerControl.GetCommonRelativeUrl("Stylesheet/global.css"))%>" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(themePath)%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css" />
    <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(themePath)%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css" />
     <style type="text/css">
        .html, body {
        overflow-x: hidden;
        }
        .tablebg
        {
            height: 20px;
        }
    </style>
</head>
<body>
    <script>
        se.ui.messageDialog.setGlobalOptions({
            localization: {
                closeButtonCaption: "<%=sr.GetString("se_ui_messagedialog_close_caption") %>",
                okButtonCaption: "<%=sr.GetString("se_ui_messagedialog_ok_caption") %>",
                cancelButtonCaption: "<%=sr.GetString("se_ui_messagedialog_cancel_caption") %>",
                showDetailsCaption: "<%=sr.GetString("se_ui_messagedialog_showdetails_caption") %>",
                hideDetailsCaption: "<%=sr.GetString("se_ui_messagedialog_hidedetails_caption") %>"
            }
 });
        
    </script>
   <form id="form1" runat="server">
   <%=System.Web.Helpers.AntiForgery.GetHtml()%>
   <telerik:RadScriptManager ID="RadScriptManager1" runat="server" />
       <link href="<%=themePath%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
        <table border="0" cellpadding="0" cellspacing="1" width="100%">
            
            <tr>
                <td valign="top">
                    <table border="0" cellpadding="0" cellspacing="1" width="100%">
                        <tr valign="top" class="ListheaderCss">
                            <td class="fontheading" style="vertical-align:middle;padding-left:10px;">
                                <span class="pagetitle">
                                    <%= sr.GetString("processdesigner_activity_attachment_report_heading")%>
                                </span>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <table border="0" cellpadding="0" cellspacing="1" width="100%">
                        <tr valign="top">
                            <td class="subtitle"  colspan="2" style="vertical-align:middle;padding-left:10px;">
                                <%= sr.GetString("processdesigner_activity_attachment_report_desc")%><br />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <table align="center" border="0" cellpadding="5" cellspacing="2" class="" width="100%">
                        <tr>
                            <td class="" style="width: 38%;padding-left:10px;">
                                <span class="subtitle">
                                   <%= sr.GetString("processdesigner_activity_attachment_report_row")%>
                                </span>
                            </td>
                            <td>
                               <telerik:RadComboBox ID="RadDropDownSSRSTemplate" runat="server" AllowCustomText="true"  MarkFirstMatch="true" RenderMode="Classic"
                                         AutoPostBack="true" EnableEmbeddedSkins="false"  Skin="AWTCombobox" Width="260px"  MaxLength="250" DropDownWidth="260px"
                                           Height="60px" NoWrap="True">
                                 </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">

                            </td>
                        </tr>
                        <tr class="">
                            <td colspan="2" align="right" style="padding-top:50px;">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3">
                                    <tr>
                                        <td align="right" style="padding-bottom:0px" >
                                            <asp:Button ID="CloseButton" runat="server"  OnClick="CloseButton_Click"   CssClass="inputsecondarybutton" />
                                            &nbsp;<asp:Button ID="Submit" runat="server" OnClientClick="return Validate();" OnClick="Submit_Click"   CssClass="inputbutton"  />    
                                            
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
           
        </table>
        
        <input id="hidtxtParamId" type="hidden" name="hidRowSelectedNo" />
        <input id="hidFullValueId" type="hidden" name="hidRowSelectedNo" />
        <input id="hidModeId" type="hidden" name="hidRowWithActualValue" />
        <input id="hidImageId" type="hidden" name="hidImage" />
        <input id="hidDeleteRowImageId" type="hidden" name="hidDeleteRowImageId" />
        <input id="hiddenNumberOfVariable" type="hidden" name="hiddenNumberOfVariable" value="0" />
    </form>
</body>
</html>
<script language="javascript" type="text/javascript">
    function Validate() {
        var selectedItem = $find('<%= RadDropDownSSRSTemplate.ClientID %>');
        if (selectedItem.get_selectedItem() == null || selectedItem.get_selectedItem().get_text() == "--Select--") {
               
            se.ui.messageDialog.showError('<%=sr.GetString("processdesigner_activity_attachment_report_heading") %>', '<%=sr.GetString("processdesigner_activity_information_select_Report") %>');
            return false;
        }
       
        return true;
    }
</script>

