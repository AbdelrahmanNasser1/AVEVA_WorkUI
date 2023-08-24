<%@ Assembly Name="Workflow.NET.Web.Designer.NET2" %>
<%@ Import namespace="Workflow.NET.Web.Designer" %>
<%@ Control Language="c#" AutoEventWireup="false" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" src="PDControls.cs" inherits="Workflow.NET.Template.ControlScript"%>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<script>
    <% if( ProcessDesignerControl.UseTopmostWindowForRenderingOnClientSide ) { %>
        var _skTopWindow = window.top;
        var _skUseTopCanvas = true;
        window.top._skTopWindow = window.top;
        window.top._skUseTopCanvas = true;
    <% }
     else 
     { %>
        var _skTopWindow = window;
        var _skUseTopCanvas = false;
    <% } %>
</script>
<link rel="stylesheet" type="text/css" href="<%=ProcessDesignerControl.GetTemplateRelativeUrl("menu/menu.css")%>"/>
<iframe id="<%=ProcessDesignerControl.GetUniqueIdForControl("diagram1")%>" src="<%=ProcessDesignerControl.GetPageUrl("ProcessDesigner.aspx")%>" width="100%" height="100%" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; BORDER-TOP-STYLE: none; PADDING-TOP: 0px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BORDER-BOTTOM-STYLE: none;" scrolling="no" ></iframe> 




<telerik:RadWindowManager ID="RadWindowManager3" Skin="AWTWindow" EnableEmbeddedSkins="false" 
         runat="server" RenderMode="Classic" VisibleStatusbar="false">          
         </telerik:RadWindowManager>
