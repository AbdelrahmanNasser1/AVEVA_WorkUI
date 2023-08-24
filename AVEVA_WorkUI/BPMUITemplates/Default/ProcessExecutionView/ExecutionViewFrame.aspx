<%@ Assembly Name="Workflow.NET.Web.Report.NET2" %>
<%@ Import namespace="Workflow.NET.Web.Report" %>
<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.ProcessExecutionView.ExecutionViewFrame" Theme="" StylesheetTheme="" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<script runat="server">

    WorkflowExecutionReport _BaseControl;
    Workflow.NET.SkeltaResourceSet GR=null;    
    override protected void OnLoad(EventArgs e)
    {
        base.OnLoad(e);
        _BaseControl = ((WorkflowExecutionReport)this.Context.Items["__Skelta_Control_Transfer_From"]);
        GR = _BaseControl.GlobalResourceSet;        
    }
</script>



<html>
<head runat="server">
    <title>Untitled Page</title>
    <script src="<%=_BaseControl.GetJscriptUrl("javascript/DiagramEVCommon.js")%>"></script>
    <script src="<%=_BaseControl.GetJscriptUrl("javascript/DiagramProperties.js")%>"></script>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <script>
        var _skTemplateDir = "<%=_BaseControl.TemplateDirectory%>";
        
       
        function ProcessTabClick(sender, eventArgs)
        {
            var tab = eventArgs.get_tab();
            var tabValue = tab.get_value();
            LoadReport(tabValue);
        }
        
 
        function LoadReport(name)
        {
            parent._skLoadedReport = name;
            var reportFrame = document.getElementById("reportframe");
            reportFrame.src = "<%=_BaseControl.GetTemplateRelativeUrl("OpenImageMap.aspx")%>?report="+name+"&zoom="+escape(parent._skZoom)+"&eid="+escape(parent._skExecutionID)+"&app="+escape(parent._skApplicationName)+"&cul="+escape(parent._skUICulture);
        }
        
        if( _skBrowser.ie )
        {
            window.onresize=parent.Paint;
        }
        else
        {
            parent.window.onresize=parent.Paint;
        }
    </script>
    <link rel="stylesheet" type="text/css" href="<%=_BaseControl.GetTemplateRelativeUrl("stylesheet/wer.css")%>">
</head>
<body onload="SkInitialize();InitiateEV();" style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px; border-style: none;overflow:-moz-scrollbars-none;width: 100%; height: 100%; " scroll="no">
    <form id="form1" runat="server">
    <%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <iframe id='reportframe' src="<%=_BaseControl.GetTemplateRelativeUrl("blank.htm")%>" bordercolor="#D8E6F5" frameborder="1" style="width: 100%; height: auto;"></iframe>
    <div id='tabstrip1' style="width: 100%;background-color:White;">

        <telerik:RadTabStrip ID="RadTabStrip1" EnableEmbeddedSkins="false" SelectedIndex="0"  runat="server" Width="100%"   Skin="AWTTabStrip" RenderMode="Classic" Orientation="HorizontalBottom" 	OnClientTabSelected="ProcessTabClick">
            <Tabs>
                <telerik:RadTab runat="server" Text="Status view" Value="status">
                </telerik:RadTab>
                <telerik:RadTab runat="server" Text="Analysts status view" Value="analyst">
                </telerik:RadTab>
                <telerik:RadTab runat="server" Text=" Progress view" Value="progress">
                </telerik:RadTab>
                <telerik:RadTab runat="server" Text=" Analysts progress view" Value="analystprogress">
                </telerik:RadTab>
            </Tabs>
            </telerik:RadTabStrip>
         
    </div>
    

    </form>
</body>
</html>
