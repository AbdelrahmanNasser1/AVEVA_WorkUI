<%@ Page Language="C#" AutoEventWireup="true"  Debug="false" CodeFile="ShowExceptionDetailReport.aspx.cs" Inherits="BPMUITemplates_Default_Common_ShowExceptionDetailReport" %>

<link href="<%=themePath%>/Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
<html >
<head runat="server">
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
</head>
<body >
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <div style="height: 100%;">
        <div id="divHeader"style="height: 5%;">
            <table width="100%">
                <tr class="header">
                    <td>
                        <span class="pagetitle">
                            <%=pageHeader %></span>
                    </td>
                </tr>
            </table>
        </div>
        <div id="divBody" style="overflow:hidden;height:90%">
            <table class="tablebg">
                <tr>
                    <td class="lefttdbg">
                        <span class="descriptionbold">
                            <%=skrm.GlobalResourceSet.GetString("ED_AppName")%></span>
                    </td>
                    <td class="righttdbg">
                        <span class="description">
                            <%=expObj.Application.ApplicationName%></span>
                    </td>
                </tr>
                <tr>
                    <td class="lefttdbg">
                        <span class="descriptionbold">
                            <%=skrm.GlobalResourceSet.GetString("ED_WFName")%></span>
                    </td>
                    <td class="righttdbg">
                        <span class="description">
                            <%=expObj.Workflow%></span>
                    </td>
                </tr>
                 <tr>
                    <td class="lefttdbg">
                        <span class="descriptionbold">
                            <%=skrm.GlobalResourceSet.GetString("ED_Message")%></span>
                    </td>
                    <td class="righttdbg">
                        <span class="description">
                            <%=expObj.Message.Replace("\r\n", "<BR>")%></span>
                    </td>
                </tr>
                 <tr>
                    <td class="lefttdbg">
                        <span class="descriptionbold">
                            <%=skrm.GlobalResourceSet.GetString("ED_Source")%></span>
                    </td>
                    <td class="righttdbg">
                        <span class="description">
                            <%=expObj.Source.Replace("\r\n","<BR>")%></span>
                    </td>
                </tr>
               
                <tr>
                    <%--<td class="lefttdbg">
                        <span class="descriptionbold">
                            <%=skrm.GlobalResourceSet.GetString("Type")%></span>
                    </td>
                    <td class="righttdbg">
                        <span class="description"><%=expObj.ExceptionType%></span>
                    </td>--%>
                </tr>
                <tr>
                    <td class="lefttdbg">
                        <span class="descriptionbold">
                            <%=skrm.GlobalResourceSet.GetString("ED_MachineName")%></span>
                    </td>
                    <td class="righttdbg">
                        <span class="description">
                            <%=expObj.MachineName%></span>
                    </td>
                </tr>
                <tr>
                    <td class="lefttdbg">
                        <span class="descriptionbold">
                            <%=skrm.GlobalResourceSet.GetString("ED_ProcessName")%></span>
                    </td>
                    <td class="righttdbg">
                        <span class="description">
                            <%=expObj.ProcessName%></span>
                    </td>
                </tr>
                <tr>
                    <td class="lefttdbg">
                        <span class="descriptionbold">
                            <%=skrm.GlobalResourceSet.GetString("ED_FileName")%></span>
                    </td>
                    <td class="righttdbg">
                        <span class="description">
                            <%=expObj.FileName%></span>
                    </td>
                </tr>
                <tr>
                    <td class="lefttdbg">
                        <span class="descriptionbold">
                            <%=skrm.GlobalResourceSet.GetString("ED_ModuleName")%></span>
                    </td>
                    <td class="righttdbg">
                        <span class="description">
                            <%=expObj.ModuleName%></span>
                    </td>
                </tr>
                <tr>
                    <td class="lefttdbg">
                        <span class="descriptionbold">
                            <%=skrm.GlobalResourceSet.GetString("ED_ExecutionId")%></span>
                    </td>
                    <td class="righttdbg">
                        <span class="description">
                            <%=expObj.ExecutionId%></span>
                    </td>
                </tr>
                <tr>
                    <td class="lefttdbg">
                        <span class="descriptionbold">
                            <%=skrm.GlobalResourceSet.GetString("ED_ExecutionDetailsId")%></span>
                    </td>
                    <td class="righttdbg">
                        <span class="description">
                            <%=expObj.ExecutionDetailsId%></span>
                    </td>
                </tr>
                <tr>
                    <td class="lefttdbg">
                        <span class="descriptionbold">
                            <%=skrm.GlobalResourceSet.GetString("ED_WorkItemId")%></span>
                    </td>
                    <td class="righttdbg">
                        <span class="description">
                            <%=expObj.WorkItemId%></span>
                    </td>
                </tr>
                <tr>
                    <td class="lefttdbg">
                        <span class="descriptionbold">
                            <%=skrm.GlobalResourceSet.GetString("ED_FormName")%></span>
                    </td>
                    <td class="righttdbg">
                        <span class="description">
                            <%=expObj.FormName%></span>
                    </td>
                </tr>
                <tr>
                    <td class="lefttdbg">
                        <span class="descriptionbold">
                            <%=skrm.GlobalResourceSet.GetString("ED_ListItemId")%></span>
                    </td>
                    <td class="righttdbg">
                        <span class="description">
                            <%=expObj.ListItemId%></span>
                    </td>
                </tr>
                <tr>
                    <td class="lefttdbg">
                        <span class="descriptionbold">
                            <%=skrm.GlobalResourceSet.GetString("ED_QueueWorkItemId")%></span>
                    </td>
                    <td class="righttdbg">
                        <span class="description">
                            <%=expObj.QueueWorkItemId%></span>
                    </td>
                </tr>
               
                <tr>
                    <td class="lefttdbg">
                        <span class="descriptionbold">
                            <%=skrm.GlobalResourceSet.GetString("ED_LastModifiedOn")%></span>
                    </td>
                    <td class="righttdbg">
                        <span class="description">
                            <%=expObj.LastModifiedOn%></span>
                    </td>
                </tr>
            </table>
        </div>
        <div id="divFooter" style="height: 5%;">
            <table width="100%">
                <tr class="footer">
                    <td align="right">
                        <input type="button" value="Close" onclick="window.close();" class="inputbutton" />
                    </td>
                    
                </tr>
            </table>
        </div>
    </div>
    </form>
</body>
</html>
