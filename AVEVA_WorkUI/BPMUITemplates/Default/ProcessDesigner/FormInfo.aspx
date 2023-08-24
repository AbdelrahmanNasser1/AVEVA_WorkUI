<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FormInfo.aspx.cs" Inherits="FormInfo" EnableEventValidation="true" EnableViewStateMac="true" ValidateRequest="true" Debug="true" %>

<%@ Assembly Name="Skelta.InvokeForm" %>
<%@ Import Namespace="Skelta.InvokeForm" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html>
<html>
<head id="Head1">
    <title>
        <%=WorkflowName%>-<%=_actionname%>-<%=PropertyDisplayName%></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <style>
        html, body, form
        {
            height: 100%;
            margin:0px;
        }
    </style>
    <link href="<%=ProcessDesignerControl.GetThemeRelativeUrl("common/stylesheet/Global.css")%>"
        rel="stylesheet" type="text/css" />
    <script type='text/javascript' src='<%=_JScriptPath%>'></script>
</head>
<body class="lefttdbg">
     <script>

         se.ui.messageDialog.setGlobalOptions({
             localization: {
                 closeButtonCaption: "<%=ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                okButtonCaption: "<%=ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
                cancelButtonCaption: "<%=ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                showDetailsCaption: "<%=ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                hideDetailsCaption: "<%=ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
            }
        });

        function DisplayMessage() {
            var strMessage = '<%=ErrMsg %>';
            var strHdrMsg = '<%=_actionname%>' +'-'+ '<%=PropertyDisplayName%>' ;
            se.ui.messageDialog.showError(strHdrMsg, strMessage);
        }



</script>

    
    <form id="form1" runat="server" name="wf_theform">
         <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
         <link href="<%=cssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css" rel="stylesheet" type="text/css" />
         <link href="<%=cssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css" rel="stylesheet" type="text/css" />
         <link href="<%=ProcessDesignerControl.GetThemeRelativeUrl("CommonUXControls/StyleSheet/se.ui.min.css")%>"  rel="stylesheet" type="text/css" />
    <table style="height: 100%;width:100%;" >
        <tr>
            <td style="width: 100%;vertical-align:top;padding-left:10px;padding-right:10px;" >
                <table style="height: 75%;width:100%;">
                    <tr style="vertical-align:top;" class="ListHeaderCss">
                        <td colspan="3" style="height: 26px;vertical-align:middle;">
                            <span class="subtitle">
                                <%=_actionname%>-<%=PropertyDisplayName%></span>
                        
                            <span title="<%=strHelpTooltip %>">
                                <img src="<%=ProcessDesignerControl.GetCommonRelativeUrl("Images/main-help.gif")%>"
                                    align="right" <%=_Helpimagetags%> style="cursor: pointer" alt="<%=strHelpTooltip %>" /></span>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100%;text-align:left;"  colspan="2">
                            <span class="description"><%=strFormDescription%></span>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="height: 100%;width:100%;text-align:left;vertical-align:top;" class="lefttdbg" >
                            <br />
                            <table style="height:70%;margin:0px auto;width:100%;border-spacing:1px;border-collapse:separate;" class="tablebg">
                                <%if (SelectedFormName != "")
                                { %>
                                <tr>
                                    <td  class="lefttdbg" style="height: 15%;vertical-align:middle;width:50%;text-align:left;">
                                        <span class="subtitle">
                                            <%=strAssociatedFormName%>
                                        </span>
                                        <br />
                                        <span class="description">
                                            <%=strAssocFormDescription%></span>
                                    </td>
                                    <td valign="middle" class="lefttdbg">
                                        <span class="subtitle">
                                            <%=SelectedFormName%>
                                            &nbsp;<%=SelectedVersion%></span>
                                    </td>
                                </tr>
                                <%} %>
                                <tr>
                                    <td style="vertical-align:middle;width:50%;" class="lefttdbg">
                                        <span class="subtitle">
                                            <%=strFormName%>
                                        </span>
                                        <br />
                                        <span class="description">
                                            <%=strFormNamDescription%></span>
                                    </td>
                                    <td class="righttdbg" style="vertical-align:middle;">
                                        <asp:Panel ID="WorkflowPanel" Width="200" runat="server">
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="vertical-align:middle;width:50%;" class="lefttdbg" >
                                        <span class="subtitle">
                                            <%=strFormVersion%>
                                        </span>
                                        <br />
                                        <span class="description">
                                            <%=strVersDescription%></span>
                                    </td>
                                    <td class="righttdbg" style="vertical-align:middle;">
                                        <asp:Panel ID="VersionPanel" Width="200" runat="server">
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <%if (ErrMsg == "")
                            { %>
                            <br />
                            <%} %>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="padding-left:12px;">
                <span class="description">
                    <img src="<%=ProcessDesignerControl.GetCommonRelativeUrl("images/icon-note.png")%>"
                        height="11" border="0" />&nbsp;<%=ProcessDesignerControl.GlobalResourceSet.GetString("Invoke_FormNoteUsers") %></span>
            </td>
        </tr>
        <tr>
            <td style="text-align:right;padding-right:10px;" >
                <input type="button" name="btnClear" class="inputsecondarybutton" onclick="javascript:window.close();"
                    value="<%=strClose%>" style="margin-right:10px;"/>
                <asp:Button ID="btnUpdate" runat="server" Text="Submit" CssClass="inputbutton" OnClick="Submit_Click" />
            </td>
        </tr>
    </table>
    <input type="hidden" name="hidactionname" id="hidactionname" value="<%= _actionname %>" />
    <input type="hidden" name="hidpropertyname" id="hidpropertyname" value="<%= _propertyname %>" />
    <input type="hidden" name="hid_applicationName" id="hid_applicationName" value="<%= ApplicationName %>" />
    <input type="hidden" name="hid_workflowName" id="hid_workflowName" value="<%= WorkflowName %>" />
    <input type="hidden" name="hid_fileName" id="hid_fileName" value="<%= _fileName %>" />
    </form>
</body>
</html>
