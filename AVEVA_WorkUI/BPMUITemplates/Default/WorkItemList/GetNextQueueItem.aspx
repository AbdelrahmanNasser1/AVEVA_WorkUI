<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.WorkItemList.GetNextQueue" Theme="" StylesheetTheme=""%>



<html>
<head id="Head1" runat="server">
    <title>Get Next Queue Item</title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>    
    <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
</head>
<script language="javascript" type="text/javascript"> 
    
    se.ui.messageDialog.setGlobalOptions({
        localization: {
            closeButtonCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                   okButtonCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
                   cancelButtonCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                   showDetailsCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                   hideDetailsCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
               }
     });
     
     function GridRefresh()
     {     
        window.opener.RefreshGrid();         
     }
     
     function ShowBellyBarAlertMessage(strTitle,strMessage)
     {         
         window.opener.ShowBellyBarAlertMessageWithWindowClose(strTitle,strMessage);
     }
</script>
<body>
    <form id="form1" runat="server">
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <link rel="stylesheet" type="text/css" href="<%=templateDirectory+"CommonUXControls/StyleSheet/se.ui.min.css"%>"/>
    <div>
    
    </div>
    </form>
</body>
</html>
