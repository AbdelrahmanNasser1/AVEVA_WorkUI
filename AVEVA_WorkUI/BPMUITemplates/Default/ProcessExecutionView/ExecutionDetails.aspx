<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.ProcessExecutionView.ExecutionDetails" Theme="" StylesheetTheme=""%>
<%@ OutputCache Location="None"  %>


<html>
<head runat="server">
    <title><%=GR.GetString("Detailed messages for workflow step")%></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <style type="text/css">
        html,body{height:98%;}
    </style>
    <script language="javascript" SRC="JavaScript/jsFunctions.js"></script>
    <script>
    window.onresize = Resize;
    window.onload = Resize;
    function Resize()
    {
        var divdetails = document.getElementById("divdetails");
        var mainrow = document.getElementById("mainrow");
        divdetails.style.height = frameElement.offsetHeight - 90;
        mainrow.style.height = frameElement.offsetHeight - 45;
    }
    </script>
</head>
   
   <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(cssPath)%>Common/StyleSheet/Global.css" rel="stylesheet" />


<body style="overflow:-moz-no-scroll;overflow:hidden;padding-top:10px;">
    <form id="form1" runat="server" style="height:100%;overflow:hidden;">
    <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
    <table width="100%" cellspacing="0" cellpadding="0" border="0">
	<tr>
        <td>
		<table cellspacing="0" class="ListHeaderCSS" cellpadding="0" border="0" width="100%">
			<tr>
				<td valign="middle" height="25"><span class="subtitle" style="padding-left:8px;"><%=WE.GlobalResourceSet.GetString("Step Details")%></span></td>
				<td valign="top" width="25"></td>
			</tr>
			<tr>
				<td valign="middle" colspan="2" height="5"></td>
			</tr>
		</table>
		</td>
	</tr>
		<tr id="mainrow">
			<td>
					<table style="border:0; width:100%; height:100%">
							<tr>
									<td class="" colspan="2" align="center" height="100%">

											<table border="0" cellspacing="1" cellpadding="2" width="100%" height="30px" class="GridHeaderStyle" style="table-layout:fixed;">
											    <tr class="subtitle"><td align="left" width="125px"><%=WE.GlobalResourceSet.GetString("Message type")%></td><td align="left" width="140px"><%=WE.GlobalResourceSet.GetString("Date time")%></td><td align="left"><%=WE.GlobalResourceSet.GetString("Description")%></td></tr></table>  									
											    <div id="divdetails" class="description" style="width:100%;height:100%;overflow:auto;">
											    <asp:PlaceHolder ID="Details" runat="server"></asp:PlaceHolder>  
											    </div>
									</td>
							</tr>
					</table>
			</td>
		</tr>
	</table>

        
   </form>
</body>
</html>
