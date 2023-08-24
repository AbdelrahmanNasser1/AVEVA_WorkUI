<%@ Page language="c#" AutoEventWireup="false" inherits="Workflow.NET.Web.Designer.ExpressionBuilder.PageScriptOL" Theme="" StylesheetTheme=""  %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<telerik:RadCodeBlock ID="radCodeBlock1" runat="server">
<script runat="server">
 
  protected string DocType = "";     
  override protected void OnLoad(EventArgs e)
    {
        base.OnLoad(e);
        if ((this.Request.Browser.Browser.ToString().ToLower() == "firefox") && (this.Request.Browser.Version.ToString() == "1.5"))
            DocType = "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">";
        else
            DocType = "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">";    
    }
 </script>
<%=DocType%>
</telerik:RadCodeBlock>
<html>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style><head>
		<title>Object Tree</title>
        <script src="../Common/JavaScripts/jquery.min.js"></script>
        <script src="../Common/JavaScripts/AutoLogoff.js"></script>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
	</head>
	<body MS_POSITIONING="GridLayout" onresize="resizeTree()" onload="resizeTree()">
		<telerik:RadScriptBlock ID="RadScriptBlock3" runat="server">
		<link rel="stylesheet" type="text/css" href="<%=exp.GetTemplateRelativeUrl("stylesheet/StyleDefault.css")%>">
		<link href="<%=exp.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTTreeView/TreeView.AWTTreeView.css")%>" rel="stylesheet" />
		<script src="<%=exp.GetJscriptUrl("javascript/ExpressionBuilderLatest.js")%>"></script>
		</telerik:RadScriptBlock>
		<table cellpadding="0" cellspacing="0" border="0">
           <tr>
               <td>
		<form id="Form1" method="post" runat="server">
			<telerik:RadCodeBlock ID="radCodeBlock2" runat="server">
			<%=System.Web.Helpers.AntiForgery.GetHtml()%> 
				</telerik:RadCodeBlock>
			<table width=100% border=0 align=center cellpadding="0" cellspacing="0" ID="Table1">
				<tr>
					<telerik:RadCodeBlock ID="radCodeBlock3" runat="server">
					<td valign=top class="BodyContent" background="<%=exp.GetTemplateRelativeUrl("graphics/tree-bg.gif")%>">
						</telerik:RadCodeBlock>
						<table width=100% border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td background="<%=exp.GetTemplateRelativeUrl("graphics/tree-bg.gif")%>" >
								    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" Height="450px" Width="195px" EnableAJAX=false>
									    <telerik:RadTreeView id="RadTree1"  Height="440px"
										    Width="220px" 
										    Skin="AWTTreeView" EnableEmbeddedSkins="false"									    							   
										    OnClientNodeDragStart="mystartdraghandler"										    
										    EnableDragAndDrop="true" ShowLineImages="false"
										    runat="server" >		  
									    </telerik:RadTreeView>
								     </telerik:RadAjaxPanel> 
								</td>
							</tr>
					  </table>
					</td>
				</tr>				
			
		  </tablE>
		</form></td></tr></table>
	</body>
</html>
			
<script language="javascript">
var editorTarget=null;
var nodeValue="";
window["RadTree1"].LoadOnDemandUrl="<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(LoadOnDemandUrl, false)%>&rtvID=RadTree1";  


 
 function resizeTree()
  {
  
    var app=navigator.userAgent;
    var broeswerCode=0;
    if(app.indexOf("MSIE")>-1)
	{
		broeswerCode =  1;	
	}
    
	else if(app.indexOf("Mozilla")>-1)
	{
		broeswerCode =  2;	
	}
	
	else if(app.indexOf("Firefox")>-1)
	{
		broeswerCode =  2;	
	}
	else 
	{
		broeswerCode = 3;	
	}
    
   //var treeDiv = document.getElementById("RadTree1Div");
   var treeDiv = document.getElementById("RadTree1");

   var intCompensate = 6;
   var treeheight =0;
   var treewidth =0;
   
   if(broeswerCode==1)
   {
    treeheight = document.body.offsetHeight;
    treewidth = document.body.offsetWidth;
   }
   else if(broeswerCode==2)
   {
        treeheight = parseInt(document.documentElement.clientHeight) * 0.961;
        treewidth = document.documentElement.clientWidth;
   }
   else
   {
    treeDiv.style.height = "10px";
    treeDiv.style.width = "10px";
    treeheight = document.documentElement.clientHeight;
    treewidth = document.documentElement.clientWidth;
   }
   
    
   
   if(parseInt(treeheight)> intCompensate)
   {
        treeDiv.style.height = parseInt(treeheight)+ "px";
   }    
    
   if(parseInt(treewidth)> intCompensate)     
        treeDiv.style.width = treewidth + "px";
        
        
  }

 
 
 
 function resizeTreeFromOut(objHeight,objWidth)
  {
    var app=navigator.userAgent;
    var broeswerCode=0;
    if(app.indexOf("MSIE")>-1)
	{
		broeswerCode =  1;	
	}
	else if(app.indexOf("Mozilla/5.0")>-1)
	{
		broeswerCode =  2;	
	}
	else if(app.indexOf("Firefox/1.5")>-1)
	{
		broeswerCode =  2;	
	}
	else 
	{
		broeswerCode = 3;	
	}
    
   //var treeDiv = document.getElementById("RadTree1Div");
   var treeDiv = document.getElementById("RadTree1");
   var intCompensate = 6;
   var treeheight =0;
   var treewidth =0;
   
   if(broeswerCode==1)
   {
    treeheight = document.body.offsetHeight;
    treewidth = document.body.offsetWidth;
   }
   else if(broeswerCode==2)
   {
        if(objHeight!=null)
        {
            treeheight = objHeight;
            treewidth = parseInt(objWidth);
        }
        else
        {
            treeheight = parseInt(document.documentElement.clientHeight) * 0.961;
            treewidth = document.documentElement.clientWidth;
        }

   }
   else
   {
    treeDiv.style.height = "10px";
    treeDiv.style.width = "10px";
    treeheight = document.documentElement.clientHeight;
    treewidth = document.documentElement.clientWidth;
   }
   
   if(parseInt(treeheight)> intCompensate)
   {
        treeDiv.style.height = parseInt(treeheight)+ "px";
    }    
   if(parseInt(treewidth)> intCompensate)     
        treeDiv.style.width = treewidth + "px";
  }


</script>
