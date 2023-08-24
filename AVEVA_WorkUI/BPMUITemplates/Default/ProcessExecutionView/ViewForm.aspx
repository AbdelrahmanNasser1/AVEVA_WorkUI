<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.ProcessExecutionView.ViewForm" Theme="" StylesheetTheme="" Debug="true" %>

<%@ Register Assembly="Skelta.HWS" Namespace="Skelta.HWS" TagPrefix="cc2" %>
<%@ Register Assembly="Skelta.HWS.WorkListChannel.Web" Namespace="Skelta.HWS.WorkListChannel.Web" TagPrefix="cc1" %>
<%@ Register Assembly="Workflow.NET.NET2" Namespace="Workflow.NET" TagPrefix="cc3" %>

<html>
<head id="Head1" runat="server">
    <title></title>

    <script language="javascript" src="JavaScript/jsFunctions.js"></script>
    <script>
        // window.onresize = Resize;
        // window.onload = Resize;
        function Resize()
        {
            var divdetails = document.getElementById("divdetails");
            var mainrow = document.getElementById("mainrow");

            if (divdetails != null)
                divdetails.style.height = frameElement.offsetHeight - 90;

            if (mainrow != null)
                mainrow.style.height = frameElement.offsetHeight - 45;

            var textArea = document.getElementById("RawcontentText");
            if (textArea != null)
            {
                //textArea.cols =  frameElement.offsetWidth * 0.18;
                //textArea.rows =  frameElement.offsetHeight * 0.06;
                textArea.style.width = frameElement.offsetWidth - 31;
                textArea.style.height = frameElement.offsetHeight - 117;

            }
        }
    </script>

</head>

<script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
<script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
<script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
<link href="<%=cssPath%>Common/StyleSheet/Global.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="<%=cssPath%>CommonUXControls/StyleSheet/se.ui.min.css" />

<body style="overflow: hidden;">
    <script>
        // Initialize locales for message dialog
        se.ui.messageDialog.setGlobalOptions({
            localization: { // All localization related default can be set
                closeButtonCaption: "<%=resourceSet.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                okButtonCaption: "<%=resourceSet.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                cancelButtonCaption: "<%=resourceSet.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                showDetailsCaption: "<%=resourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                hideDetailsCaption: "<%=resourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
            }
        });
    </script>
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <table width="100%" cellspacing="0" cellpadding="0" border="0">
            <tr>
                <td valign="bottom" height="25" background="<%=cssPath %>ProcessExecutionView/graphics/Common-Heading-bg.png">

                    <table cellspacing="0" class="header" cellpadding="0" border="0" width="100%">
                        <tr>
                            <td valign="middle"><span class="subtitle"><%=pageTitle%></span></td>
                            <td valign="top"></td>
                        </tr>
                        <tr>
                            <td valign="middle" colspan="2" height="5"><span class="header1"></span></td>
                        </tr>
                    </table>
                </td>
            </tr>

        </table>
        <asp:Panel ID="pnlUIControl" runat="server" ScrollBars="None"></asp:Panel>
    </form>
</body>
</html>
