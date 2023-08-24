<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.Bam.ZoomReport" %>

<!DOCTYPE HTML>

<html>
<head runat="server">
    <title></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <style type="text/css">
        html, body
        {
            height:99%;
            overflow:hidden;
        }
</style>

    <script type="text/JavaScript">
        function GetUrl() {
            
            var browserCode = GetBrowserversion();                
            var url = '<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(Request.QueryString["UrlPlaceHolder"], false)%>';
            var title = '<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(Request.QueryString["ReportTitle"], false)%>';
            var description = '<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(Request.QueryString["ReportDescription"], false)%>';
            var hdnUrl = window.window.window.parent.document.getElementById(url);
            var reportTitle = window.window.window.parent.document.getElementById(title);
            var reportDescription = window.window.window.parent.document.getElementById(description);
            var frameZoomReport = document.getElementById("<%=zoomReport.ClientID%>");
            frameZoomReport.src = hdnUrl.value;
            if (browserCode == 1) {
                document.getElementById("<%=reportTitle.ClientID%>").innerText = reportTitle.value;
                document.getElementById("<%=reportDescription.ClientID%>").innerText = reportDescription.value;
            } else {
                document.getElementById("<%=reportTitle.ClientID%>").innerHTML = reportTitle.value;
                document.getElementById("<%=reportDescription.ClientID%>").innerHTML = reportDescription.value;
            }
        }

        function GetBrowserversion() {
            var app = navigator.userAgent;
            if (app.indexOf("MSIE") > -1) {
                return 1;
            }
            else if (app.indexOf("Firefox/1.5") > -1) {
                return 2;
            }
            else {
                return 3;
            }
        }        
        
    </script>

</head>
<body onload="GetUrl();">
    <form id="form1" runat="server" style="height:100%" >
    <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
    <link rel="stylesheet" type="text/css" href="<%=cssPath %>Common/StyleSheet/Global.css" />
    <table style="width:100%;height:100%;border-collapse:separate;border-spacing:10px;text-align:center'>
        <tr style="height:20px;">
            <td style="text-align:left">
                <asp:Label ID="reportTitle" CssClass="subtitle" runat="server"></asp:Label><asp:Label
                    ID="reportDescription" CssClass="description" runat="server"></asp:Label>
            </td>
        </tr>
        <tr style="width:100%;height:100%'>
            <td style="height: 100%; width: 100%;vertical-align:top;">
                <iframe src="" runat="server" marginwidth="0" marginheight="0" frameborder="0" 
                id="zoomReport" scrolling="no" style="height: 100%; width: 100%;border-collapse:collapse;"></iframe>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
