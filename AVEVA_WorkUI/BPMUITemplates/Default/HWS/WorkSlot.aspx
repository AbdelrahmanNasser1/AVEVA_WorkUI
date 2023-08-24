<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.HWS.Web.CalendarControl.WorkSlotASPXCodeBehind"  Theme="" StylesheetTheme="" %>
<%@ Register Assembly="Skelta.HWS.Web.CalendarControl" Namespace="Skelta.HWS.Web.CalendarControl"  TagPrefix="cc1" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title><%=WkHeading%></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
	<style type="text/css">
	    html, body
	    {
	        height: 100%;
	    }
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
</head>
    
<body style="margin-top:0px;margin-left:0px">
    <form id="form1" runat="server" style="height:100%;">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
    <div style="height:100%;">
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        <table style="width:100%;margin:auto;  border-collapse:separate;border-spacing:1px;height:100%;"  >
            <tr>
                <td style="padding:0px;vertical-align:top;height:100%;"><cc1:WorkSlotControl ID="WorkSlotControl1" runat=server/></td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
