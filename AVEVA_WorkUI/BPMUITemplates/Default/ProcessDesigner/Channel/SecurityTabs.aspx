<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.Channel.SecurityTabs" Theme="" StylesheetTheme=""%>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<html style="height:100%">
<head runat="server">
    <title><%=Channel_PageTitle%></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    
    
</head>
<body rightmargin=0 leftmargin=0 bottommargin=0 topmargin=0 style="height:100%">
	<script language="javascript" type="text/javascript">
        function LoadUrl(frameId, url, selectTabIndex) {
            document.getElementById(frameId).src = url;
            SelectTab(selectTabIndex);
        }

        function SelectTab(tabIndex) {
            if (typeof(ChannelConfigTab.Tabs) != 'undefined')
                ChannelConfigTab.Tabs[tabIndex].click();
        }
    </script>
    <form id="form1" runat="server" style="height:100%">
	<%=System.Web.Helpers.AntiForgery.GetHtml()%>
		<telerik:RadScriptManager runat="server" ID="radScriptManager" />
        
        <link rel="stylesheet" type="text/css" href="<%:cssPath%>TelerikAjax/StyleSheet/AWTTabStrip/TabStrip.AWTTabStrip.css">        
    	<table style="height:98%; width:100%">
		<tr height="100%">
			<td height="100%" style="padding-top: 15px">
					

				<telerik:RadTabStrip ID="ChannelConfigTab" EnableEmbeddedSkins="false" SelectedIndex="0"  MultiPageID="ChannelMapping" runat="server" Width="100%"
                        Skin="AWTTabStrip" RenderMode="Classic" Orientation="HorizontalBottom" EnableViewState="false" CausesValidation="false">
                            <Tabs>
                            <telerik:RadTab  Text=""  PageViewID="ChannelMappingPage">
                            </telerik:RadTab>
                            <telerik:RadTab  Text=""  PageViewID="ChannelUserMappingPage">
                            </telerik:RadTab>
                            <telerik:RadTab Text=""  PageViewID="ChannelRolesMappingPage">
                            </telerik:RadTab>
                            </Tabs>
                        </telerik:RadTabStrip>  

				<telerik:RadMultiPage ID="ChannelMapping" Height="100%" Width="100%" runat="server" SelectedIndex="0" RenderMode="Classic">
					<telerik:RadPageView ID="ChannelMappingPage" runat="server" width="100%" height="100%">
						<iframe id="frameCurrent" name="frameCurrent" frameborder="no" width="100%" height="100%" src="" scrolling="no"></iframe>
					</telerik:RadPageView>
					<telerik:RadPageView ID="ChannelUserMappingPage" runat="server" width="100%" height="100%">
						<iframe id="frameUsers" name="frameUsers" frameborder="no" width="100%" height="100%" src="" scrolling="no"></iframe>
					</telerik:RadPageView>
					<telerik:RadPageView ID="ChannelRolesMappingPage" runat="server" width="100%" height="100%">
						<iframe id="frameRoles" name="frameRoles" frameborder="no" width="100%" height="100%" src="" scrolling="no"></iframe>
					</telerik:RadPageView>
					</telerik:RadMultiPage>

			

			</td>
		</tr>
	</table>
    </form>
</body>
</html>

<script language="javascript">
	LoadUrl('frameCurrent', '<%= userConfigUrl %>', 0);
</script>
