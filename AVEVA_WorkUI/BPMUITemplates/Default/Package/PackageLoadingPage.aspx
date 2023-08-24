<%@ Page language="c#" Inherits="Skelta.Package.CodeBehind.PackageLoadingPage" %>
<HTML>
<link href="<%=themePath%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
<!--<link href="<%=themePath%>common/styles/global.css" rel="stylesheet" type="text/css" />-->
  <HEAD runat="server">
		<title><%=resourceManager.GetString("Publishingworkflow_IntermediatePageMessageTitle")%></title>
      <script src="../Common/JavaScripts/jquery.min.js"></script>
      <script src="../Common/JavaScripts/AutoLogoff.js"></script>
      <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
</HEAD>
	<body id="Body"  onload="Begin()" onunload="End()">
	<script>
    var w,h;
    var oWindow = GetRadWindow();
    if(oWindow==null) //if it is not from list ie from the process designer
    {
        w = screen.availWidth;   //getMaxWidth();    
        h = screen.availHeight; //getMaxHeight();   
        
       window.moveTo((w/2)-100,(h/2)-100);//move the windw to the center of the screen
       //set the the window style also.
       document.getElementById('Body').className="validation-bgsmall";       
     }
     else
     {
        document.getElementById('Body').className="validation-bg";
     }
	function GetRadWindow()
	{
		var oWindow = null;
		if(window.frameElement!=null)
			oWindow = window.frameElement.radWindow;
		return oWindow;
	} 

		var ctr = 1;
		var ctrMax = 50; // how many is up to you-how long does your end page take?
		var intervalId;		
		function Begin() 
		{	
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
			if (curCtr <= (ctrMaxIterations + 10000)) 
			{				
				return curCtr;
			}
			else 
			{
				indicator.style.width =0;
				return 1;
			}
		}

		function showMessageAndClose(messageType, message)
		{
		    var pageTitle = '<%=resourceManager.GetString("PKG_IntermediatePageMessageInstallBellyTitle") %>',
                    self = window;
		    var oWindow = GetRadWindow();
		    switch (messageType)
		    {
		        case "Error":
		            se.ui.messageDialog.showError(pageTitle, message, closeHandlerFn);
		            break;
		        case "Message":
		            se.ui.messageDialog.showAlert(pageTitle, message, closeHandlerFn);
		            break;
		        default:
		            break;
		    }

		    function closeHandlerFn()
		    {
		        self.closeBellyWindow(false);
		    }
		}

	    function closeBellyWindow()
	    {
	        var oWindow = GetRadWindow();
	        var check = false;
	        try
	        {
	            window.parent.onclientCalled = false;
	            window.parent.OnClientClose(oWindow);
	            oWindow.close();
	            window.parent.onclientCalled = null;
	        }
	        catch (e)
	        {
	            check = true;
	        }

	        if (check === true)
	        {
	            try
	            {
	                window.parent.parent.onclientCalled = false;
	                window.parent.parent.OnClientClose(oWindow);
	                oWindow.close();
	                window.parent.parent.onclientCalled = null;
	            }
	            catch (e)
	            {
	            }
	        }
	    }
		</script>
		<form id="Form1" method="post" runat="server">	
			<%=System.Web.Helpers.AntiForgery.GetHtml()%> 
			<table visible="false" id=indicator border="0" cellpadding="0" cellspacing="0" width="0" height="20" align="center" >
				<tr>
					<td  align="center" width="100%" class="description"><B><%=resourceManager.GetString("PKG_IntermediatePageMessageInstall")%></B></td>
				</tr>
			</table>	
			<table id=indicatorimage border="0" cellpadding="0" cellspacing="0" width="0" align="center" >
				<tr>
					<td  align="center" width="100%">
					    <asp:Image ID="imgLoading" runat="server" ImageUrl="<%$ ReplaceTemplateExpn:SOA/images/download_line.gif%>" />
					</td>					
				</tr>
			</table>		
		</form>
	</body>
</HTML>
