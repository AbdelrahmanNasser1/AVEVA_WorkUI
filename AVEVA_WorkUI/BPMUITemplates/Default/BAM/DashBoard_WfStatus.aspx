<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DahBoard_WfStatus.aspx.cs" Inherits="BPMUITemplates_Default_BAM_TempStatus" %>



<html>
<head runat="server">
    <title>Dashboard Workflow Status Page</title>
    <style type="text/css">
        html, body
        {
            height:99%;  
            width:99%; 
            overflow:hidden;       
        }
</style>
</head>
<body  onload="setTimeout('LoadGraphframe()',10)" >
    <form id="form1" runat="server" style="height:100%;">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <div style="height:100%;width:100%;" > 
            <iframe id="iframestatus" style="width:100%;height:98%;PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; BORDER-TOP-STYLE: none; PADDING-TOP: 0px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BORDER-BOTTOM-STYLE: none;"></iframe>     
        </div>
    </form>
    
    <script type="text/javascript">
        var NoOfOcc = 0;
        var NoOfCalls = 0;

        function LoadGraphframe() {

            if (NoOfOcc == 0) {
                var frameel = document.getElementById('iframestatus');
                var w = frameel.offsetWidth - 20; var h = frameel.offsetHeight - 30;
                var heigth = '<%:this.Height%>';


                if (frameel.offsetHeight == 0 && heigth == 0) {
                    setTimeout('LoadGraphframeWait();', 200);
                }
                else {
                    setTimeout('LoadGraphframeWait();', 2);
                }
            }
            NoOfOcc = 1;
        }

        function LoadGraphframeWait() {
            var frameel = document.getElementById('iframestatus');
            var w = frameel.offsetWidth - 20; var h = frameel.offsetHeight - 30;

            var heigth = '<%:this.Height%>';
            var width;
            if (frameel.offsetHeight <= 3 && heigth == 0 && NoOfCalls < 10) {
                NoOfCalls = NoOfCalls + 1;
                setTimeout('LoadGraphframeWait();', 200);
                return;
            }

            var bamSuri = '<%:Request["BamSuri"]%>';
            var url = "DashBoard_WfStatusChart.aspx?BamSuri=" + bamSuri;

            try {
                if (w == 0) {
                    width = '<%:this.Width%>';
                    w = width;
                    w = w - 20;
                }
                if (h == 0) {
                    heigth = '<%:this.Height%>';
                    h = heigth;
                    h = h - 20;
                }
            }

            catch (err) { frameel.src = ""; return; }


            url = url + '&w=' + escape(w) + '&h=' + escape(h);
            var IR = '<%:this.IR%>';
            var ckey = '<%:this.CKey%>';

            if (IR != "") {
                url = url + "&IR=1";
            }
            if (ckey != "") {
                url = url + "&ckey=" + ckey;
            }
            frameel.src = url;
        }

        if (window.attachEvent) {
            //window.attachEvent("onload",LoadGraphframe);
            window.attachEvent("onresize", LoadGraphframe);
        }
        else {
            //window.addEventListener("load",LoadGraphframe);
            window.addEventListener("resize", LoadGraphframe, false);
        }
    </script> 
</body>

</html>
