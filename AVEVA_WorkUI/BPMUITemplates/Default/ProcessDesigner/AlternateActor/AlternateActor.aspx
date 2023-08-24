<%@ Page Language="C#" AutoEventWireup="true"  Inherits="Skelta.HWS.UserControls.CodeBehind" Theme=""  StylesheetTheme=""%>
<%@ Register Src="AlternateActor.ascx" TagName="AlternateActor" TagPrefix="uc1" %>
<!DOCTYPE html >
<html>
<head runat="server">
    <title><%=PageTitle%></title>
    
    <style>    
        html,body,form { padding:0; margin:0; width:100%;  height: 100%; overflow:hidden; }
    </style>
	
</head>
<body  style="overflow:hidden">
     <script src="<%=JavaScriptReferencePath%>Common/JavaScripts/jquery.min.js"></script>
     <script src="<%=JavaScriptReferencePath%>Common/JavaScripts/AutoLogoff.js"></script>   
     <script src="<%=JavaScriptReferencePath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <script>
        se.ui.messageDialog.setGlobalOptions({
            localization: {
                closeButtonCaption: "<%=objResourceSet.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
             okButtonCaption: "<%=objResourceSet.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
             cancelButtonCaption: "<%=objResourceSet.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
             showDetailsCaption: "<%=objResourceSet.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
             hideDetailsCaption: "<%=objResourceSet.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
         }
        });       
    </script>
    <form id="form1" runat="server" style="height:100%;">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <link rel="stylesheet" type="text/css" href="<%:commonCssPath%>CommonUXControls/StyleSheet/se.ui.min.css">
    <table style="height:100%;width:100%;border-spacing:0px;border-collapse:collapse;">
		<tr style="height:100%; width:100%;vertical-align:top;">
			<td style="height:100%;width:100%">
				<uc1:AlternateActor ID="AlternateActor1" runat="server" />
			</td>
		</tr>
    </table>
    </form>
</body>
</html>
 <script>
    

     try {
         document.getElementById("tblMain").style.display = "none";
     }
     catch (ex) {
     }

     function isIE11() {
         return !!navigator.userAgent.match(/Trident.*rv[ :]*11\./);
     }

    </script>