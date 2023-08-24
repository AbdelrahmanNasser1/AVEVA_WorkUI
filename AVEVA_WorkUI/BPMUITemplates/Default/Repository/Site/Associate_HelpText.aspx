<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.Associate_HelpText" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Event Associations</title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <link href="styles/aquila.css" rel="stylesheet" type="text/css" />
</head>
<body style="padding: 0px; margin: 0px">
    <form id="form1" runat="server">
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <table width="100%" border="0" cellspacing="0" cellpadding="6" background="images/bg-help.jpg"
            height="400">
            <tr>
                <td valign="top">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td valign="top">
                                <table border="0" cellpadding="1" cellspacing="0">
                                    <tr>
                                        <td id="700" class="bodytext" height="22" valign="top">
                                            <br />
                                            <img src="images/icons-ribbon/Associations-icon.png" align="absmiddle">&nbsp;&nbsp;Associate
                                            &nbsp;&nbsp;
                                            <!-- (Available Associations -&nbsp;<a href="javascript:parent.ShowIframe('Associate_Sharepoint.aspx')">2</a>)-->
                                        </td>
                                    </tr>
                                    <tr>
                                        <td id="onetidListDescriptionText" class="runtext" style="height: 28px">
                                            Use this Page to associate the workflow with any of the providers that are listed
                                            above. If you want to view the existing associations then click on view associations.
                                            <br />
                                            <br />
                                            <br />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="runtext">
                                        </td>
                                    </tr>
                                    <!--                <tr>
                                    <td class="bodytext">
                                        <img src="images/sharepoint-icon-20x20.png" align="absmiddle">&nbsp;&nbsp;Enterprise  &nbsp;&nbsp;  (Available Associations -&nbsp;<a href="javascript:parent.ShowIframe('Associate_Enterprise.aspx')">4</a>)</td>
                                </tr>
                                <tr>
                                    <td id="Td1" class="runtext" style="height: 28px">
                                        Select this option to associate a workflow with a specified process, category, Skelta BPM workflow or folder.
                                        <br /><br /><br />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="runtext">
                                    </td>
                                </tr>
                                <tr>
                                    <td class="bodytext">
                                        <img src="images/file-system-20x20.png" align="absmiddle">&nbsp;&nbsp;File System  &nbsp;&nbsp;  (Available Associations -&nbsp;<a href="javascript:parent.ShowIframe('Associate_Sharepoint.aspx')">0</a>)</td>
                                </tr>
                                <tr>
                                    <td id="Td2" class="runtext" style="height: 28px">
                                        To create a new Skelta workflow, enter the name of the workflow and short description.
                                        Select the relevant category and then Click Create; the new workflow will appear
                                        in the Tree to the left. New workflows are initially created with a blank process.
                                        <br /><br /><br />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="runtext">
                                    </td>
                                </tr>
                                <tr>
                                    <td class="bodytext">
                                        <img src="images/Scheduler-icon-20x20.png" align="absmiddle">&nbsp;&nbsp;Scheduler  &nbsp;&nbsp;  (Available Associations -&nbsp;<a href="javascript:parent.ShowIframe('Associate_Sharepoint.aspx')">2</a>)</td>
                                </tr>
                                <tr>
                                    <td id="Td3" class="runtext" style="height: 28px">
                                        To create a new Skelta workflow, enter the name of the workflow and short description.
                                        Select the relevant category and then Click Create; the new workflow will appear
                                        in the Tree to the left. New workflows are initially created with a blank process.
                                        <br /><br /><br />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="runtext">
                                    </td>
                                </tr>
                                <tr>
                                    <td class="bodytext">
                                        <img src="images/sap-integration-icon-20x20.png" align="absmiddle">&nbsp;&nbsp;SAP</td>
                                </tr>
                                <tr>
                                    <td id="Td4" class="runtext" style="height: 28px">
                                        To create a new Skelta workflow, enter the name of the workflow and short description.
                                        Select the relevant category and then Click Create; the new workflow will appear
                                        in the Tree to the left. New workflows are initially created with a blank process.
                                        <br /><br /><br />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>-->
                                </table>
                            </td>
                        </tr>
                    </table>
    </form>
</body>
</html>
