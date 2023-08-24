<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DashBoard_WfInstances.aspx.cs" Inherits="SkeltaTemplates_Default_BAM_DashBoard_WfInstancesFrame" %>


<html>
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <style type="text/css">
        html, body
        {
            height:95%;  
            overflow:hidden;
        }
</style>
</head>
<body onload="setTimeout('LoadGraphinstanceframe()',10)" >
    <form id="form1" runat="server" style="height:100%;">
	<%=System.Web.Helpers.AntiForgery.GetHtml()%>
         <div style="height:100%;width:100%;" > 
            <iframe id="iframeInstancestatus" style="width:100%;height:100%;PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; BORDER-TOP-STYLE: none; PADDING-TOP: 0px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BORDER-BOTTOM-STYLE: none;"></iframe> 
        </div>
    </form>
    
    <script type="text/javascript">
        var NoOfOcc = 0;
        var NoOfCalls = 0;

        function LoadGraphinstanceframe() {
            if (NoOfOcc == 0) {
                var frameel = document.getElementById('iframeInstancestatus');
                var w = frameel.offsetWidth; var h = frameel.offsetHeight - 25;
                var heigth = '<%=this.Height%>';

                if (frameel.offsetHeight == 0 && heigth == 0) {
                    setTimeout('LoadGraphinstanceframeWait();', 200);
                }
                else {
                    setTimeout('LoadGraphinstanceframeWait();', 2);
                }
            }
            NoOfOcc = 1;
        }

        function LoadGraphinstanceframeWait() {
            var frameel = document.getElementById('iframeInstancestatus');
            var w = frameel.offsetWidth-10; var h = frameel.offsetHeight - 45;
           
            var heigth = '<%=this.Height%>';
            var width;
            if (frameel.offsetHeight <= 3 && heigth == 0 && NoOfCalls < 10) {
                NoOfCalls = NoOfCalls + 1;
                setTimeout('LoadGraphinstanceframeWait();', 200);
                return;
            }

            var bamSuri = '<%:Request["BamSuri"]%>';
            var url = "DashBoard_WfInstancesChart.aspx?BamSuri=" + bamSuri;

            try {
                if (w == 0) {
                    width = '<%:Request["Width"]%>';
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
            var IR = '<%=this.IR%>';
            var ckey = '<%=this.CKey%>';

            if (IR != "") {
                url = url + "&IR=1";
            }
            if (ckey != "") {
                url = url + "&ckey=" + ckey;
            }
            frameel.src = url;
        }
        
    if( window.attachEvent ) 
    {
        //window.attachEvent("onload",LoadGraphframe);
        window.attachEvent("onresize", LoadGraphinstanceframe);
    }
    else
    {
        //window.addEventListener("load",LoadGraphframe);
        window.addEventListener("resize", LoadGraphinstanceframe, false);
    }
    </script> 
</body>
</html>
