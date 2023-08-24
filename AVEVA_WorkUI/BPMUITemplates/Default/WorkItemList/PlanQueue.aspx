<%@ Page Language="C#" AutoEventWireup="true"  Inherits="Workflow.NET.CodeBehind.WorkItemList.PlanQueue" Theme="" StylesheetTheme="" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE HTML>
<html>
<head id="Head1" runat="server">
    <title><%=windowTitle%></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
     <style>
        html,body {height:100%;}
    </style>
    
</head>
<script language="javascript" type="text/javascript" >
     
    se.ui.messageDialog.setGlobalOptions({
        localization: {
            closeButtonCaption: "<%=_ResourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
            okButtonCaption: "<%=_ResourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
            cancelButtonCaption: "<%=_ResourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
            showDetailsCaption: "<%=_ResourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
            hideDetailsCaption: "<%=_ResourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
        }
    });
     
     function GridRefresh()
     {     
        window.opener.RefreshGrid();         
     }

     function ShowBellyBarErrorMessage(title, message) {
         se.ui.messageDialog.showError(title, message);
     }

     function ShowBellyBarAlertMessage(title, message) {
         se.ui.messageDialog.showAlert(title, message);
     }
</script> 
<body style="padding-left:8px;padding-right:8px;">
    <form id="form1" runat="server" style="height:100%;">
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
		<telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
		<link rel="stylesheet" type="text/css" href="<%=commonCssPath+"common/StyleSheet/Global.css"%>" />
		<link rel="stylesheet" type="text/css" href="<%=commonCssPath+"CommonUXControls/StyleSheet/se.ui.min.css"%>" />
		<table style="width:100%;border-spacing:1px;border-collapse:separate;" >
			<tr style="vertical-align:top;" class="ListHeaderCss" >
			<td style="padding:2px;vertical-align:top;height:25px;" colspan="2">
				<table style="width:100%;border-spacing:0px;border-collapse:collapse;" >
					<tr>
						<td class="fontheading" style="height:25px;"><%=strPlanQueue%></td>
						<td style="vertical-align:top;width:20px;"></td>
					</tr>				
				</table>		
			</td>
		</tr>	
		
		<tr>
			<td style="padding-bottom:4px;" colspan="2">
			   <table style="width:100%;border-spacing:1px;border-collapse:separate;margin:0px auto;" class="tablebg">
					<tr>									
						<td class="lefttdbg" style="width:400px;">
							<asp:Label ID="lblDisplayError" CssClass="errormsg" runat=server Visible="false"></asp:Label>
						</td>										
					</tr>
				</table>
			</td>
		</tr>	
		
		<tr>
			<td colspan="2" class="subtitle">
			<%=strTimeSpan%>:	    
				<asp:TextBox ID="txtPlanTime" runat="server" CssClass="inputtext" Text="0.00:00:00"></asp:TextBox>    
				(d.hh:mm:ss)   																				
			</td>
		</tr>
		
		<tr>        
		 <td  style="text-align:right;width:100%;padding-right:10px;padding-top:5px;">         	    
			<asp:Button runat="server" ID="btnClose" CssClass="inputsecondarybutton" OnClientClick="GridRefresh()"   />		        			         			        
		   </td> 

			<td  style="text-align:right;width:100%;padding-right:10px;padding-top:5px;">        			        
			<asp:Button runat="server" ID="btnPlan" CssClass="inputbutton" OnClick="btnPlan_Click"    />
		</td> 
		</tr>   
		
		<tr>
		<td colspan="2">
		<span class="description"><%=strNotePlan%></span>
		</td>
		</tr>
		
		</table>
		<telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="btnPlan">
                    
                </telerik:AjaxSetting>              

            </AjaxSettings>

        </telerik:RadAjaxManager>
    </form>
</body>
</html>
