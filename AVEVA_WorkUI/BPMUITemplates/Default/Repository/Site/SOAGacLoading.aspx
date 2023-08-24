<%@ Page language="c#" Inherits="Skelta.SOA.CodeBehind.Repository.SOALoading" %>

<!DOCTYPE html>
<HTML>
  <HEAD runat="server">
		<title><%=GR.GetString("soa_Loadingplease")%></title>
      <script src="../../Common/JavaScripts/jquery.min.js"></script>
      <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
      <link rel="stylesheet" type="text/css" href="<%$ ReplaceTemplateExpn:Common/StyleSheet/Global.css%>" />  
		<script>	
		var ctr = 1;
		var ctrMax = 100; // how many is up to you-how long does your end page take?
		var intervalId;		
		function Begin() 
		{	    
			window.location.href = "SOAAssemblyListAdd.aspx?lcsuri=" + "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(Microsoft.Security.Application.Encoder.UrlEncode(Request.QueryString["lcsuri"]), false)%>";
			intervalId = window.setInterval("ctr=UpdateIndicator(ctr, ctrMax)", 50);
		}	
		function End() 
		{
		    for(i=0;i<5000;i++)
		    {		        
		    
		    }
			window.clearInterval(intervalId);			
		}
	
		function UpdateIndicator(curCtr, ctrMaxIterations) 
		{	
			curCtr += 1;			
			if (curCtr <= (ctrMaxIterations + 10000)) {
				//indicator.style.width =curCtr*10 +"px";
				return curCtr;
			}
			else 
			{
				indicator.style.width =0;
				return 1;
			}
		}
		</script>

</HEAD>
	<body onload="Begin()" onunload="End()">
		<form id="Form1" method="post" runat="server">
			<%=System.Web.Helpers.AntiForgery.GetHtml()%>
		    <div style="text-align:center"><font face="Roboto,Segoe UI,Arial,Verdana" size="2" color="black"><%=GR.GetString("soa_LoadingDataPlease")%></font></div>
			<table visible="false" id=indicator  style="margin:0px auto;border-spacing:0px;border-collapse:collapse;height:20px;width:0px;">
				<tr>
					<td style="width:100%;text-align:center;"></td>					
				</tr>
			</table>	
			<table id=indicatorimage style="margin:0px auto;border-spacing:0px;border-collapse:collapse;" >
				<tr>
					<td style="width:100%;text-align:center;">
					    <asp:Image ID="imgLoading" runat="server" ImageUrl="<%$ ReplaceTemplateExpn:SOA/images/download_line.gif%>" />
					</td>					
				</tr>
			</table>		
		</form>
	</body>
</HTML>
