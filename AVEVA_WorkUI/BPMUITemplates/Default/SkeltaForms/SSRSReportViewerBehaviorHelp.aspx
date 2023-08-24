<%@ Page Language="C#" Trace="false" AutoEventWireup="true" Debug="true" Inherits="Skelta.Forms.Web.Codebehind.SSRSReportViewerBehaviorHelp" %>

<%@ OutputCache Duration="60" Location="None" NoStore="true" %>
<html>
<head id="Head1" runat="server">
    <title>
        <%= skrm.GlobalResourceSet.GetString("ssrs_report_viewer_behavior_helper_win_head") %>
    </title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <link rel="stylesheet" type="text/css" href="<%$ ReplaceTemplateExpn:SkeltaForms/StyleSheet/skeltaform.css%>" />
</head>
<body>
    <form id="form1" runat="server">
         <%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <table border="0" width="100%" style="height: 100%;" class="sf-formbackground">
        <tr>
            <td align="center" valign="middle">
                <img src='<% = Workflow.NET.TemplateExpressionBuilder.GetUrl("SkeltaForms/Images/" + skrm.GlobalResourceSet.GetString("ssrs_rv_cnfg_help_image_name")).ToString() %>' />
            </td>
        </tr>
        <tr>
            <td height="10px">
            </td>
        </tr>
        <tr>
            <td align="center" valign="middle">
                <table border="0" cellpadding="0" cellspacing="0" class="sf-formlabeldescription">
                    <tr>
                        <td width="40px" style="color:Red;font-weight:bolder"><%= skrm.GlobalResourceSet.GetString("ssrs_behavior_number_1")%></td>
                        <td>
                            <%= skrm.GlobalResourceSet.GetString("ssrs_behavior_show_parameters_prompts")%>
                        </td>
                    </tr>
                    <tr>
                        <td width="40px" style="color:Red;font-weight:bolder"><%= skrm.GlobalResourceSet.GetString("ssrs_behavior_number_2")%></td>
                        <td>
                            <%= skrm.GlobalResourceSet.GetString("ssrs_behavior_show_back_button")%>
                        </td>
                    </tr>
                    <tr>
                        <td width="40px" style="color:Red;font-weight:bolder"><%= skrm.GlobalResourceSet.GetString("ssrs_behavior_number_3")%></td>
                        <td>
                            <%= skrm.GlobalResourceSet.GetString("ssrs_behavior_show_export_controls")%>
                        </td>
                    </tr>
                    <tr>
                        <td width="40px" style="color:Red;font-weight:bolder"><%= skrm.GlobalResourceSet.GetString("ssrs_behavior_number_4")%></td>
                        <td>
                            <%= skrm.GlobalResourceSet.GetString("ssrs_behavior_show_find_controls")%>
                        </td>
                    </tr>
                    <tr>
                        <td width="40px" style="color:Red;font-weight:bolder"><%= skrm.GlobalResourceSet.GetString("ssrs_behavior_number_5")%></td>
                        <td>
                            <%= skrm.GlobalResourceSet.GetString("ssrs_behavior_show_page_navigation_controls")%>
                        </td>
                    </tr>
                    <tr>
                        <td width="40px" style="color:Red;font-weight:bolder"><%= skrm.GlobalResourceSet.GetString("ssrs_behavior_number_6")%></td>
                        <td>
                            <%= skrm.GlobalResourceSet.GetString("ssrs_behavior_show_print_button")%>
                        </td>
                    </tr>
                    <tr>
                        <td width="40px" style="color:Red;font-weight:bolder"><%= skrm.GlobalResourceSet.GetString("ssrs_behavior_number_7")%></td>
                        <td>
                            <%= skrm.GlobalResourceSet.GetString("ssrs_behavior_show_refresh_button")%>
                        </td>
                    </tr>
                    <tr>
                        <td width="40px" style="color:Red;font-weight:bolder"><%= skrm.GlobalResourceSet.GetString("ssrs_behavior_number_8")%></td>
                        <td>
                            <%= skrm.GlobalResourceSet.GetString("ssrs_behavior_show_zoom_control")%>
                        </td>
                    </tr>
                    <tr>
                        <td width="40px" style="color:Red;font-weight:bolder"><%= skrm.GlobalResourceSet.GetString("ssrs_behavior_number_9")%></td>
                        <td>
                            <%= skrm.GlobalResourceSet.GetString("ssrs_behavior_show_toolbar")%>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr height="100%">
            <td align="right" valign="bottom">
                <input type="button" id="btnClose" class="sf-inputsBox" onclick="window.close(); return false;"
                    value="<%= skrm.GlobalResourceSet.GetString("ssrs_report_viewer_behavior_helper_button_close") %>" />
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
