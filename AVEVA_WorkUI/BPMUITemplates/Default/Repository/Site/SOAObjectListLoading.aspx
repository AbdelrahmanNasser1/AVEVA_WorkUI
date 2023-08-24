<%@ Page language="c#" Inherits="Skelta.SOA.CodeBehind.Repository.SOAObjectListLoading" %>
<HTML>
  <HEAD>
		<title>Loading, please wait...</title>				
		<script>	
		var ctr = 1;
		var ctrMax = 50; // how many is up to you-how long does your end page take?
		var intervalId;		
		function Begin() 
		{	    
			window.location.href = "SOAObjectListAdd.aspx?assemblyPath=" + "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(Microsoft.Security.Application.Encoder.UrlEncode(Request.QueryString["assemblyPath"]), false)%>&assemblyName=" + "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(Microsoft.Security.Application.Encoder.UrlEncode(Request.QueryString["assemblyName"]), false)%>&assemblyVersion=" + "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(Microsoft.Security.Application.Encoder.UrlEncode(Request.QueryString["assemblyVersion"]), false)%>" + "&repoName=" + "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(Microsoft.Security.Application.Encoder.UrlEncode(Request.QueryString["repoName"]), false)%>&userId=" + "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(Microsoft.Security.Application.Encoder.UrlEncode(Request.QueryString["userId"]), false)%>&lcsuri=" + "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(Microsoft.Security.Application.Encoder.UrlEncode(Request.QueryString["lcsuri"]), false)%>";
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
		    <div style="text-align:center"><font face="verdana" size="2" color="black"><%=GR.GetString("soa_LoadingDataPlease")%></font></div>
			<table visible="false" id=indicator style="margin:0px auto;border-spacing:0px;border-collapse:collapse;height:20px;width:0px;" >
				<tr>
					<td  style="width:100%;text-align:center;"></td>					
				</tr>
			</table>	
			<table id=indicatorimage border="0" cellpadding="0" cellspacing="0" width="0" align="center" >
				<tr>
					<td  style="width:100%;text-align:center;">
					    <asp:Image ID="imgLoading" runat="server" ImageUrl="<%$ ReplaceTemplateExpn:SOA/images/download_line.gif%>" />
					</td>					
				</tr>
			</table>		
		</form>
	</body>
</HTML>
