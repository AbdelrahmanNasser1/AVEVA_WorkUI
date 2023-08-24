<%@ Page Language="C#" AutoEventWireup="true"    Inherits="Skelta.Repository.Web.EC.ExplorerPage"  %>
<%@ Register Assembly="Skelta.Repository.Web" Namespace="Skelta.Repository.Web.EC" TagPrefix="cc1" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<html>
<head id="Head1" runat="server">
    <title>Enterprise Console List</title>
    <script src="../../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../../Common/JavaScripts/AutoLogoff.js"></script>
    
</head>
<style type="text/css">
<!--
BODY
{
	BORDER-RIGHT: 0px; BORDER-TOP: 0px; MARGIN: 0px; BORDER-LEFT: 0px; CURSOR: default; BORDER-BOTTOM: 0px; 
}
-->
</style>
<body scroll="yes" >
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server" />
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <div>
            <cc1:ECExplorerControl runat="server" ID="ECExplorerControl1" ></cc1:ECExplorerControl>      
        </div>          
    </form>
</body>
</html>
