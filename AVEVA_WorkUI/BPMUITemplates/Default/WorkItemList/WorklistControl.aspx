<%@ Page Language="C#" AutoEventWireup="true"  Inherits="Workflow.NET.CodeBehind.WorkItemList.WorklistControl" %>

<%@ Register Assembly="Skelta.HWS.Web.WorkListLayoutControl" Namespace="Skelta.HWS.Web.WorkListLayoutControl"
    TagPrefix="cc1" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <style type="text/css">
        html,body,form {height:100%;}
    </style>
<script>
window.onresize = Resize;

function Resize()
{
  if(document.body.clientWidth <=document.body.scrollWidth)
  {
    document.body.style.overflow="auto";
    document.body.scroll="auto"; 
  }
  
}

if (document.getElementById("divworklist") != null) {

    document.getElementById("divworklist").style.width = window.screen.width - 100;
 }

</script>
    <title><%=PageTitle%></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
</head>
<body onload="Resize()"  style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px;PADDING-BOTTOM: 0px;MARGIN: 0px 0px 0px 0px; Border-style: none; PADDING-TOP: 0px;" >
    <form id="form1" runat="server" >
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager ID="radScriptMgr" runat="server"></telerik:RadScriptManager>

		<div id="divworklist" style="overflow:auto;vertical-align:top;" >
			<cc1:WorkListLayoutControl ID="WorkListLayoutControl1" runat="server"  />
		</div>
    </form>
</body>
</html>
