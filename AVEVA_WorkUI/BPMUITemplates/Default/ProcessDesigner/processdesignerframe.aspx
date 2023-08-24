<%@ Assembly Name="Workflow.NET.Web.Designer.NET2" %>
<%@ Import namespace="Workflow.NET.Web.Designer" %>
<%@ Page language="c#" inherits="Workflow.NET.Template.PageFrameScript" CodeFile="PDPageFrame.cs" Theme="" StylesheetTheme=""%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title></title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link rel="stylesheet" type="text/css" href="<%:ProcessDesignerControl.GetThemeRelativeUrl("ProcessDesigner/stylesheet/pd.css")%>">
		<link rel="stylesheet" type="text/css" href="<%:ProcessDesignerControl.GetTemplateRelativeUrl("menu/menu.css")%>">
		<script>
			var ImagesLocation="<%:ProcessDesignerControl.GetThemeRelativeUrl("ProcessDesigner/graphics/")%>";
			var PDControlID = "<%=ProcessDesignerControl.ID%>";
			var _skTemplateDir = "<%=ProcessDesignerControl.TemplateDirectory%>";
			var _skPageUrl = "<%=ProcessDesignerControl.GetPageUrl("uurrii")%>";
			var _skAdapterParams = "<%=ProcessDesignerControl.GetAdapterUrlParams(true)%>";
			var _SlowConnectionTimeout=30000;
		</script>
		<script type="text/javascript" src="<%=ProcessDesignerControl.GetJscriptUrl("javascript/DiagramCommon.js")%>"></script>		
		<script type="text/javascript" src="<%=ProcessDesignerControl.GetJscriptUrl("javascript/DiagramObj.js")%>"></script>
		<script type="text/javascript" src="<%=ProcessDesignerControl.GetJscriptUrl("javascript/propertypages.js")%>"></script>			
		<script type="text/javascript" src="<%=ProcessDesignerControl.GetJscriptUrl("javascript/diagram.js")%>"></script>	
		<script type="text/javascript" src="<%=ProcessDesignerControl.GetJscriptUrl("javascript/actionextensions.js")%>"></script>	
		<script type="text/javascript" src="<%=ProcessDesignerControl.GetJscriptUrl("javascript/PageSearch.js")%>"></script>
		<script type="text/javascript" src="<%=ProcessDesignerControl.GetJscriptUrl("colorpicker/color_conv.js")%>"></script>
		<script>
		var _HidePropertiesBeforeLoad=false;
		function ChangeZoom(zoomvalue)
		{
			document.body.style.zoom=zoomvalue;
			if( zoomvalue != "100%" )
			{
				document.body.style.backgroundImage="none";
			}	
			else
			{
				document.body.style.backgroundImage="url(<%:ProcessDesignerControl.GetTemplateRelativeUrl("graphics/backgrid.gif")%>)";
			}
		}		
		
		function ToggleGrid()
		{
		    if( document.body.style.backgroundImage != null && document.body.style.backgroundImage != "" && document.body.style.backgroundImage != "none" )
		    {
		        document.body.style.backgroundImage="none";
		    }
			else
			{
				document.body.style.backgroundImage="url(<%:ProcessDesignerControl.GetTemplateRelativeUrl("graphics/backgrid.gif")%>)";
			}
		}

		</script>
        <script src="../../Common/JavaScripts/jquery.min.js"></script>
        <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
	</head>
	<body onload="SkInitialize();setTimeout('InitializeProcessDesigner(\'FlowCanvas\')',500);" rightmargin=0 bottommargin=0 topmargin=0 leftmargin=0 style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; Border-style: none; PADDING-TOP: 0px;">
        
<script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=cssPath %>CommonUXControls/StyleSheet/se.ui.min.css" />      
<script>
    // Initialize locales for message dialog
    se.ui.messageDialog.setGlobalOptions({
        localization: { // All localization related default can be set
            closeButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
            okButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
            cancelButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
            showDetailsCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
            hideDetailsCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
        }
    });

    </script>
		<div id="FlowCanvas"></div>
		
		<iframe src="blank.htm" id="skTxtFrame" style="z-Index: 50000; PADDING-RIGHT: 0px; DISPLAY: block; PADDING-LEFT: 0px; LEFT: -200px; PADDING-BOTTOM: 0px; MARGIN: 0px; WIDTH: 10px; PADDING-TOP: 0px; POSITION: absolute; TOP: -200px; HEIGHT: 10px" scrolling="no" marginheight="0" marginwidth="0" frameborder="no"></iframe>
		<script>SetupIframe();</script>
		</body>
</html>
