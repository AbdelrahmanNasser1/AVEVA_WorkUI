<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.Channel.Channel" Theme="" StylesheetTheme="" %>
<html>
<head id="Head1" runat="server">
    <title><%:PageTitle%></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
     <script type="text/javascript">
		function LoadUrl( url, frameId ) {
		    document.getElementById(frameId).src = url; 
		}
    </script>
</head>
    <script src="<%=JSPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link href="<%:cssPaths%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
<frameset rows="*" cols="40%,*" frameborder="0" border="0" framespacing="0">
		<frame src="<%:supportedChannelsUrl %>" name="leftFrame" scrolling="No" id="frameSupported" />
        <frame src="<%:configurationFrameUrl %>" scrolling="no" name="mainFrame" id="frameConfigs" />
</frameset>
</html>
