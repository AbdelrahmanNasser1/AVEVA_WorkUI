<%@ Page Language="C#" AutoEventWireup="true" EnableSessionState="True" EnableViewState="true"
    Inherits="Skelta.Forms.Web.Codebehind.SSRSReportHandler" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=15.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="cc2" %>

<%@ OutputCache Duration="60" Location="None" NoStore="true" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>
        <%= skrm.GlobalResourceSet.GetString("ssrs_rh_win_head") %>
    </title>
    <meta http-equiv="content-type" content="Type=text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <script type="text/javascript" src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <script language="JavaScript" type="text/javascript">

        ResizeToMaximum();

        //  Resizes the window to the maximum extent.
        function ResizeToMaximum()
        {
            try
            {
                if (IsWindowContainedInAFrame() == true)
                {
                    return;
                }

                window.moveTo(0, 0);
                window.resizeTo(screen.availWidth, screen.availHeight);

                ////if (document.all)
                ////{
                ////    top.window.resizeTo(screen.availWidth, screen.availHeight);
                ////}
                ////else if (document.layers || document.getElementById)
                ////{
                ////    if (top.window.outerHeight < screen.availHeight || top.window.outerWidth < screen.availWidth)
                ////    {
                ////        top.window.outerHeight = screen.availHeight;
                ////        top.window.outerWidth = screen.availWidth;
                ////    }
                ////}
            }
            catch (err)
            {
                return;
            }
        }

        function IsWindowContainedInAFrame()
        {
            try
            {
                if (window.frameElement != null)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (err)
            {
                return true;
            }
        }
    </script>
    <link rel="stylesheet" type="text/css" href="<%$ReplaceTemplateExpn:SkeltaForms/StyleSheet/skeltaform.css%>" />
    <style type="text/css">
        html, body, form
        {
            width: 100%;
            height: 100%;
            margin: 0;
            padding: 0;
            border-width: 0px;
        }

        div
        {
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            box-sizing: border-box;
        }
        html:not(.iebrowser) .container
        {
            position:relative;
        }
        html:not(.iebrowser) .child
        {
            position:absolute;
            top:0 !important;
            left:0 !important;
            right:0 !important;
            bottom:0 !important;
        }
        
        .iebrowser .container
        {

        }
        .iebrowser .child
        {
            width:100%;
            height:100%;
        }

        #ReportViewerControl_fixedTable [id^="VisibleReportContentReportViewerControl"]
        {
            overflow:auto;
            position:absolute;
            top:0;
            left:0;
            bottom:0;
            right:0;
        }
    </style>
</head>
<body style="overflow: hidden;">
    <script type="text/javascript">
        $(document).ready(function ()
        {
            if ((document.documentMode === 10) || (document.documentMode === 11))
            {
                $("html").addClass("iebrowser"); // Internet Explorer Specific

                RefreshReportViewerForIE();

                $(window).resize(RefreshReportViewerForIE);
            }
        });

        function RefreshReportViewerForIE()
        {
            var footerHeight = 42;
            if (IsWindowContainedInAFrame())
            {
                footerHeight = 0;
            }

            var reportViewerContainerHeight = $("html").height() - footerHeight;

            $("#RowReportViewer")[0].style.height = reportViewerContainerHeight + "px";
            $(".container")[0].style.height = reportViewerContainerHeight + "px";
            $(".child")[0].style.height = reportViewerContainerHeight + "px";

            ////$(".sf-ReportViewerControl")[0].style.height = reportViewerContainerHeight - 3 + "px !important";
        }
    </script>
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <asp:scriptmanager id="ScriptManager1" runat="server"></asp:scriptmanager>
        <table border="0" runat="server" id="TableMain" cellpadding="0" cellspacing="0" style="width:100%;height:100%; ">
            
        
            <tr runat="server" id="RowReportViewer" visible="true" >
                <td class="container">
                    <div class="child">
                        <cc2:ReportViewer ID="ReportViewerControl" EnableTheming="true" CssClass="sf-ReportViewerControl"
                            runat="server" AsyncRendering="true" Width="100%" Height="99%" EnableViewState="true" SizeToReportContent="false" EnableTelemetry="false" KeepSessionAlive="true">
                        </cc2:ReportViewer>
                    </div>
                </td>
            </tr>
            <tr runat="server" id="RowErrorMessage" style="vertical-align: middle" visible="false">
                <td align="center">
                    <asp:Label runat="server" ID="lblErrorMessage" Width="100%" ForeColor="#D81C3F" CssClass="sf-formlabeldescription"></asp:Label>
                </td>
            </tr>
            <tr id="RowCloseSeparatorSection" runat="server">
                <td height="2px"></td>
            </tr>
            <tr id="RowCloseSection" runat="server" valign="bottom" height="40px" align="right">
                <td valign="bottom" class="sf-saverow" style="vertical-align:middle; padding-right:10px;">
                    <input type="button" name="btnClose" value='<%=skrm.GlobalResourceSet.GetString("ssrs_button_close")%>'
                        onclick="window.close();" id="btnClose" class="sf-inputsBox" />
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
