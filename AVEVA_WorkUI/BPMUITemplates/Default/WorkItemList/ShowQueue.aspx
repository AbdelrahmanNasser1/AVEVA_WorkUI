<%@ Page Language="C#" AutoEventWireup="true"  Inherits="Workflow.NET.CodeBehind.WorkItemList.ShowQueue" Theme="" StylesheetTheme="" %>
<%@ Register Assembly="Skelta.HWS.Web.QueueControl" Namespace="Skelta.HWS.Web.QueueControl"
    TagPrefix="cc1" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE HTML>

<script src="<%=JSPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=ThemeRelativeUrl%>">

<html>
<head runat="server">
    <style>
        html,body {height:100%;}
    </style>
    <title><%=QueueTitle%></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <script type="text/javascript">
        $(window).bind('resize', function (e) {
            if (window.RT) clearTimeout(window.RT);
            window.RT = setTimeout(function () {
                this.location.reload(false); /* false to get page from cache */
           }, 1);
        });

        function showErrorMessage(header, message) {
                        se.ui.messageDialog.showError(header, message);
                    }
    </script>
</head>
   <script type="text/javascript" >             
     
            se.ui.messageDialog.setGlobalOptions({
        localization: {
            closeButtonCaption: "<%=ResourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                 okButtonCaption: "<%=ResourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
                 cancelButtonCaption: "<%=ResourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                 showDetailsCaption: "<%=ResourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                 hideDetailsCaption: "<%=ResourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
             }
     });
        </script>
<body onresize="" style="padding-left:10px;padding-right:10px;">
    <form id="form1" runat="server" style="height:100%;">
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
		<div id="divLoad" style="height:100%;overflow:hidden;">
			<asp:Panel ID="QueuePanel" runat="server" Height="100%">
			</asp:Panel> 
		</div>     
    </form>
</body>
</html>
