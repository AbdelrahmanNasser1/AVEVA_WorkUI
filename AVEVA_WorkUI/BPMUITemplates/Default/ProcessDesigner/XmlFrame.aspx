<%@ Page Language="C#" AutoEventWireup="true" CodeFile="XmlFrame.aspx.cs" Inherits="XmlStorageCode" Debug="true"%>
<link rel="stylesheet" type="text/css" href="<%=ProcessDesignerControl.GetCommonRelativeUrl("stylesheet/global.css")%>">
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head id="Head1" runat="server">
    <title>XML Frame</title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
</head>

<script>
function onLoadExpandTree()
{
	var treeviewInstance = $find("<%= RadTree1.ClientID %>");
    var nodes = treeviewInstance.get_allNodes();
    var i=0;
    for (i = 0; i < nodes.length; i++)
    {
        if (nodes[i].get_nodes() != null)
        {
            nodes[i].expand();
        }
    }
}
</script>
<body onload="onLoadExpandTree()" style="font-size:9px; border: none; margin: 0px 0px 0px 0px; padding: none;" leftmargin="0px" topmargin="0px" rightmargin="0px" bottommargin="0px" scroll="no">

    <form id="form2" runat="server" method="post">
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
		<table cellspacing=0 cellpadding=0 width=100% border=0 class="tablebg">
			<tr>
				<td valign="bottom" height="25" class="lefttdbg" background="<%=ProcessDesignerControl.GetCommonRelativeUrl("Images/top-bg.gif")%>">
					<table cellspacing="0" cellpadding="0" border="0" width="100%">
						<tr>
							<td valign="middle" class="header" style="height: 25px"><span class="subtitle"> <%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariableSchema")%></span></td>
							<td valign="middle" class="header" width="25"><a href="#"><img src="<%=ProcessDesignerControl.GetCommonRelativeUrl("Images/close.gif")%>" onclick="javascript:parent.CloseIframe();" width="18" border="0" height="18"/></a></td>
						</tr>
					</table>
				</td>
			</tr>
	    </table>
			 <telerik:RadTreeView  ID="RadTree1" runat="server"  style="z-index:101; position: absolute;left: 2px; top: 25px; width:612px; overflow-x:auto; height:269px;overflow-y:auto>
			 </telerik:RadTreeView>
        
   <table cellspacing=0 cellpadding=0 width=100% border=0 style="z-index:101;position: absolute; top: 295px;" class="footer">
        <tr>
		<td valign="bottom" height="25" background="<%=ProcessDesignerControl.GetCommonRelativeUrl("Images/top-bg.gif")%>">
		    <table cellspacing="0" cellpadding="0" border="0" width="100%">
			    <tr>
				</tr>
		    </table>
		</td>
	    </tr>
	    </table>
   
   </form>     
</body>
</html>
