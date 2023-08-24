<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.Bam.BAMContextMenu" %>

<HTML>
  <HEAD id="HEAD1" runat="server">
	<title></title>		
      <script src="../Common/JavaScripts/jquery.min.js"></script>
      <script src="../Common/JavaScripts/AutoLogoff.js"></script>
	<script>	
	var ctr = 1;
	var ctrMax = 50; // how many is up to you-how long does your end page take?
	var intervalId;		
	function Begin() 
	{
		var urlPath = '<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(sUrl, false)%>';
		if(urlPath != "")
		{
		    window.location.href = urlPath;
		    intervalId = window.setInterval("ctr=UpdateIndicator(ctr, ctrMax)", 50);
	    }
	    else
	    {
            window.frameElement.radWindow.close();
	    }
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
		    <div align=center><font face="Roboto" size="4" color="black"><b><%=GR.GetString("Loading")%></b></font></div>
			<table visible="false" id=indicator border="0" cellpadding="0" cellspacing="0" width="0" height="20" align="center" >
				<tr>
					<td  align="center" bgcolor="#009900" width="100%"></td>					
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
