<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.Channel.SupportedChannels" Theme="" StylesheetTheme="" EnableViewState="true"%>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<html>
<head id="Head1" runat="server">
    <title>Channels</title>
   <%-- <link href="<%=cssPath %>" rel="stylesheet" type="text/css">--%>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
     <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script> 
</head>

<script language="javascript" type="text/javascript">

    se.ui.messageDialog.setGlobalOptions({
        localization: { 
            closeButtonCaption: "<%=resourceSets.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                okButtonCaption: "<%=resourceSets.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>", 
                cancelButtonCaption: "<%=resourceSets.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>", 
                showDetailsCaption: "<%=resourceSets.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                hideDetailsCaption: "<%=resourceSets.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" 
            }
	});
        function DisplayMessage()
        {
          var strMessage = '<%=resourceSets.GlobalResourceSet.GetString("PD_Channel_Save_Success") %>';
         var strHdrMsg = '<%=resourceSets.GlobalResourceSet.GetString("Delivery Channels") %>';
          se.ui.messageDialog.showAlert(strHdrMsg, strMessage);
       }
    
    
    
    function DisplayErrorMessage()
    {
        var strMessage = '<%= errorMessages %>';
        var strHdrMsg = '<%=resourceSets.GlobalResourceSet.GetString("Delivery Channels") %>';
        se.ui.messageDialog.showError(strHdrMsg, strMessage);
    }
    
    function DisplayFormInstanceErrorMessage()
    {
        var strMessage = '<%= errorMessages %>';
        var strHdrMsg = '<%=resourceSets.GlobalResourceSet.GetString("Delivery Channels") %>';
        se.ui.messageDialog.showError(strHdrMsg, strMessage);
    }
    function LoadPages( url, frameid ) 
	{
	    
		window.parent.LoadUrl(url, frameid);
		
	}

	function BeforeClickHandler(sender, eventArgs) {
        var node = eventArgs.get_node();
		LoadPages( GetConfigUrl( node.get_value() ), 'frameConfigs' );
        eventArgs.set_cancel(false);
	}
	
	function BeforeClientContextMenuHandler(sender, eventArgs) {
        var node = eventArgs.get_node();
		LoadPages( GetConfigUrl( node.get_value() ), 'frameConfigs' );
        eventArgs.set_cancel(false);
	}
	
	function AfterToggleHandler(sender, eventArgs) {
        var node = eventArgs.get_node();
        var o = $find(<%= RadTree1.ClientID %>);
        o.unselectAllNodes();
        node.select();
	}
	
	
    function ContextMenuClick(sender, eventArgs) {
        var node = eventArgs.get_node();
        var item = eventArgs.get_menuItem();

		if ("<%= localRenameText %>" == item.get_text()) {
			
			node.startEdit();            
		}
        else if ("<%= localSecurityText %>" == item.get_text()) {
		    var width = screen.width;
		    var height = screen.availHeight;
		    var left = (width - 700) / 2;
		    var top = (height - 540) / 2;
            window.open(GetSettingsUrl(node.get_value()),"AccessRights","height=540,width=700,status=no,toolbar=no,menubar=no,location=no,resizable=yes, left=" + left + ", top=" + top);
		}
		return true;
	}
	
	function BeforeClientCheckHandler(sender, eventArgs) {
        var node = eventArgs.get_node();
        if (node.get_category() == "NonCheckable") {
			alert(node.get_text() + " is a Mandatory Channel...!");
            eventArgs.set_cancel(true);
		    //return false;
		}
	}
	
	function GetNodeText( joinedText ) {
		return GetText( joinedText, 'nodetext' );
	}
	
	function GetConfigUrl( joinedText ) {
		return GetText( joinedText, 'configurl' );
	}
	
	function GetSettingsUrl( joinedText ) {
		return GetText( joinedText, 'settingsurl' );
	}
	
	function GetText( joinedText, inText ) {
		var arrText = joinedText.split(',');
		
		for( var i=0; i<arrText.length; i++ ) {
			var itemText = arrText[i].split('$')[0];
			if ( itemText == inText ) {
				return arrText[i].split('$')[1];
			}
		}
		
		return '';
	}
	function CloseWindow() {
        window.setTimeout('window.parent.close()',50);
    }
	
</script>
<body>
    <form id="form1" runat="server">
		<%=System.Web.Helpers.AntiForgery.GetHtml()%> 
		<telerik:RadScriptManager ID="radscrManager" runat="server"></telerik:RadScriptManager>
        <link href="<%=themePath%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
		<link href="<%=themePath%>TelerikAjax/StyleSheet/AWTTreeView/TreeView.AWTTreeView.css" rel="stylesheet" />
		<link href="<%=cssPath%>" rel="stylesheet" type="text/css">

		<table cellpadding="0" cellspacing="1" height="100%" width="100%" border="0" style="border-collapse: collapse;border-style: none; border-right: 1px solid #666">
			<tr>
				<td>
					<table class="ListHeaderCss" cellpadding="0" cellspacing="0" width="100%"  >
						<tr>
						   <td  width=30% align=left style="padding-left: 5px"><span class="fontheading"><%=processDesignerAdapter.ProcessDesignerControl.GlobalResourceSet.GetString("Channel_PageHeader_Channels")%></span></td>
							<td valign="middle" width=70% align="right" style="padding-right:5px"><a href="#" onclick="javascript:window.open('<%=processDesignerAdapter.ProcessDesignerControl.GetHelpPageUrl()%><%=helpFile%>','newwin','width=600,height=500,resizable=yes,status=no,scrollbars=yes')">
						   <img border="0" src="<%=processDesignerAdapter.ProcessDesignerControl.GetCommonRelativeUrl("Images/main-help.gif")%> " align="right"  style="cursor:pointer" alt="<%=processDesignerAdapter.ProcessDesignerControl.GlobalResourceSet.GetString("HelpIconToolTip")%>"/></a></td>
					   </tr>
					</table>
				</td>
            </tr>
			<tr  height="95%" valign="top">
				<td class="lefttdbg"><br />
						<telerik:RadTreeView
							id="RadTree1" 
							SingleExpandPath="False" 
							MultipleSelect="False" 
							CheckBoxes="True" 
							EnableDragAndDrop="False"
							Height="95%"
							Width="100%"
							Skin="AWTTreeView"	
							EnableEmbeddedSkins="false"
							AllowNodeEditing="true"							
							runat="server" 
							OnContextMenuItemClick="HandleContextClick" 
							OnNodeEdit="HandleNodeEdit"
							OnClientContextMenuShowing = "BeforeClientContextMenuHandler"
							OnClientNodeClicking = "BeforeClickHandler"
							OnClientNodeChecked="AfterToggleHandler"
							OnClientContextMenuItemClicking="ContextMenuClick"
							OnClientNodeChecking="BeforeClientCheckHandler" ShowLineImages="false" ExpandAnimation-Type="None" CollapseAnimation-Type="None">
						</telerik:RadTreeView>
				</td>
			</tr>
			<tr>
				<td align="right" style="padding-right:15px; padding-bottom: 15px">
                    <asp:Button ID="ButtonClose" runat="server" CssClass="inputsecondarybutton" OnClick="ButtonClose_Click"/>
                    &nbsp;
					<asp:Button ID="ButtonSave" runat="server" CssClass="inputbutton" OnClick="ButtonSave_Click"/>
				</td>
			</tr>
		</table>
    </form>
</body>
</html>
