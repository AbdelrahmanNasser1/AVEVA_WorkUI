<%@ Assembly Name="Workflow.NET.Web.Designer.NET2" %>
<%@ Import namespace="Workflow.NET.Web.Designer" %>
<%@ Page language="c#" AutoEventWireup="false" EnableViewState="false"  Theme="" StylesheetTheme="" %>
<%@ Register TagPrefix="cc1" Namespace="Workflow.NET.Web.Designer" Assembly="Workflow.NET.Web.Designer.NET2" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ OutputCache Duration="60" Location="None" NoStore="true" %>

<script runat=server>
    ProcessDesignerAdapter pda;
    ProcessDesigner ProcessDesignerControl;
     
	override protected void OnLoad(EventArgs e)
	{
		base.OnLoad(e);
      
        
        pda = new ProcessDesignerAdapter();
        pda.LoadControlInstance(true);
        ProcessDesignerControl = pda.ProcessDesignerControl;
		PDPlaceHolder.Controls.Add(ProcessDesignerControl);	
	}

</script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
        <META http-equiv="Page-Enter"CONTENT="progid:DXImageTransform.Microsoft.Fade(Duration=.250,overlap=1.0)" />
		<title></title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link rel="stylesheet" type="text/css" href="<%=ProcessDesignerControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css")%>">
		<link rel="stylesheet" type="text/css" href="<%=ProcessDesignerControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css")%>">
		<link rel="stylesheet" type="text/css" href="<%=ProcessDesignerControl.GetThemeRelativeUrl("ProcessDesigner/stylesheet/properties.css")%>">
        <script type="text/javascript" src="<%=ProcessDesignerControl.GetJscriptUrl("javascript/DiagramCommon.js")%>"></script>		
        <script type="text/javascript" src="<%=ProcessDesignerControl.GetTemplateRelativeUrl("javascript/propertiestrackchanges.js")%>"></script>
        <script type="text/javascript" src="<%=ProcessDesignerControl.GetTemplateRelativeUrl("javascript/ExpressionBuilderLatest.js")%>"></script>
	</head>
	<body onLoad="SkInitialize();checksize();lookForChanges();if (typeof ReAlignIPBox != 'undefined') ReAlignIPBox();if (typeof DisplayErrors != 'undefined') DisplayErrors();" onBeforeUnload="return warnOfUnsavedChanges()" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px; BORDER-STYLE: none;background: white;" scroll="no" onresize="javascript:if (typeof ReAlignIPBox != 'undefined') ReAlignIPBox();">
		<form id="Form1" method="post"  runat="server" autocomplete="off">
			<%=System.Web.Helpers.AntiForgery.GetHtml()%>
			<telerik:RadScriptManager ID="RadScriptManager1" runat="server" />
			<asp:PlaceHolder ID="PDPlaceHolder" Runat="server"></asp:PlaceHolder>
			<%=pda.GetHTML()%>
		</form>		
	</body>
</html>
