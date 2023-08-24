<%@ Control Language="C#" AutoEventWireup="true"  Inherits="Workflow.NET.CodeBehind.Bam.DashBoard.BAMDashboardChartBase" %>
<%@ Assembly Name="Skelta.BAM" %>
<%@ Import namespace="Skelta.BAM.UserControls" %>
<%@ Import namespace="Skelta.BAM.Configuration" %>
<iframe id="<%=ChartControl.GetUniqueIdForControl("frame")%>" src="<%=ChartControl.GetPageUrl("blank.htm")%>"  width="100%" height="100%" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; BORDER-TOP-STYLE: none; PADDING-TOP: 0px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BORDER-BOTTOM-STYLE: none; width: 100%; height: 100%;" scrolling="no" ></iframe> 

<script>
    
    
    var NoOfOcc = 0;  
    var NoOfCalls = 0;  
    function LoadGraph<%=ChartControl.GetUniqueIdForControl("frame")%>FunctionWait() 
    {
        var frameel = document.getElementById('<%=ChartControl.GetUniqueIdForControl("frame")%>');
        var w = frameel.offsetWidth - 20; var h = frameel.offsetHeight - 32;
        //debugger;
        var heigth = '<%=this.Height%>';
        var width;
        if(frameel.offsetHeight <= 3 && heigth == 0 && NoOfCalls < 10){
                NoOfCalls = NoOfCalls + 1;//alert(NoOfCalls);debugger;
                setTimeout('LoadGraph<%=ChartControl.GetUniqueIdForControl("frame")%>FunctionWait();', 200); 
                return;
            }
               
        var url = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(Skelta.BAM.UserControls.BAMDashboardChartAdapter.GetUrl(ChartControl), false) %>";
            
            try
            {            
                 if(w==0 || w == -20)
                 {                
                    width = '<%=this.Width%>';
                    w = width;                    
                    w = w -20;
                 }
                 if(h==0 || h == -32)
                 {
                    //heigth = '<%=this.Height%>';
                    h= heigth;
                    h = h -20;                     
                 }
            }                     
            catch(err){frameel.src = ""; return;}                  
            url = url + '&w='+escape(w)+'&h='+escape(h); 
            var IR = '<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(this.IR, false)%>';
            var ckey = '<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(this.CKey, false)%>';     
                 
            if(IR != "")
            {
                url = url + "&IR=1";
            }
             if(ckey!= "")
            {
                url = url + "&ckey=" + ckey;
            }
            frameel.src = url;           
    }
    function LoadGraph<%=ChartControl.GetUniqueIdForControl("frame")%>Function() 
    {
    
        if(NoOfOcc == 0)
        {    
            var frameel = document.getElementById('<%=ChartControl.GetUniqueIdForControl("frame")%>');
            heigth = '<%=this.Height%>';
            if(frameel.offsetHeight == 0 && heigth == 0){
                    setTimeout('LoadGraph<%=ChartControl.GetUniqueIdForControl("frame")%>FunctionWait();', 200);
                }
                else
                {
                    setTimeout('LoadGraph<%=ChartControl.GetUniqueIdForControl("frame")%>FunctionWait();', 2);
                }
        }        
        NoOfOcc=1;
    }

    if( window.attachEvent ) 
    {
        //window.attachEvent("onload",LoadGraph<%=ChartControl.GetUniqueIdForControl("frame")%>Function);
        window.attachEvent("onload",CallResizeAsync);
        window.attachEvent("onresize",CallResizeAsync);
    }
    else
    {
        window.addEventListener("load",CallResizeAsync,false);
        window.addEventListener("resize",CallResizeAsync,false);
    }
    
    function CallResizeAsync()
    {
    
        setTimeout('LoadGraph<%=ChartControl.GetUniqueIdForControl("frame")%>Function()',10); 
    }
</script>

