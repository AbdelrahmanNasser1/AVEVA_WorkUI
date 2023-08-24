<%@ Page language="c#" Inherits="Skelta.SOA.CodeBehind.Repository.SOALoading" %>
<HTML>
  <HEAD runat="server">
		<title><%=GR.GetString("soa_Loadingplease")%></title>
      <script src="../../Common/JavaScripts/jquery.min.js"></script>
      <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
      <link rel="stylesheet" type="text/css" href="<%$ ReplaceTemplateExpn:Common/StyleSheet/Global.css%>" />
		<script>	
		var ctr = 1;
		var ctrMax = 50; // how many is up to you-how long does your end page take?
		var intervalId;		
		function Begin() 
		{	        
			var urlPath = '<%=sPageUrl%>';
			window.location.href = urlPath + "?mode=" + "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(Microsoft.Security.Application.Encoder.UrlEncode(Request.QueryString["mode"]), false)%>&lcsuri=" + "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(Microsoft.Security.Application.Encoder.UrlEncode(Request.QueryString["lcsuri"]), false)%>";
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
		    <div align=center><font  face="verdana" size="4" color="black"><b><%=GR.GetString("soa_LoadingDataPlease")%></b></font></div>
			<table visible="false" id=indicator border="0" cellpadding="0" cellspacing="0" width="0" height="20" align="center" >
				<tr>
					<td  align="center"  width="100%"></td>					
				</tr>
			</table>	
			<table id=indicatorimage border="0" cellpadding="0" cellspacing="0" width="0" align="center" >
				<tr>
					<td  align="center" width="100%">
					    <asp:Image ID="imgLoading" runat="server" ImageUrl="<%$ ReplaceTemplateExpn:SOA/images/download_line.gif%>"  />
					 
					</td>					
				</tr>
			</table>		
		</form>
	</body>
</HTML>
