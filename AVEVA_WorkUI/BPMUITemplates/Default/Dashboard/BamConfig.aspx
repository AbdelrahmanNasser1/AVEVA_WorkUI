<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.Bam.DashBoard.BamConfig" Theme="" StylesheetTheme="" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<html>
<head id="Head1" runat="server">
    <title class="mainHeading">BAM Configuration
    </title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <%--<meta http-equiv="X-UA-Compatible" content="IE=5">--%>
</head>
<style>
    .tabstrip li {
        list-style: none;
        list-style-image: none;
        list-style-position: outside;
        float: left;
        margin: 7px !important;
        padding: 2px 18px !important;
        border-right: 1px solid gray;
    }
</style>
<script>
    window.onresize = Resize;
    var showOverdueConfig = "<%=showOverdueConfig%>";
        var showKPIs = "<%=showKPIs%>";
    var showKPIdataPoints = "<%=showKPIdataPoints%>";
    var showAlertManager = "<%=showAlertManager%>";
    var showbasicconfig = "<%=showbasicconfig%>";
    var showPerformanceConfig = "<%=showPerformanceConfig%>";

    function Resize() {
        var w = document.body.clientWidth + 60;
        var h = document.body.clientHeight;
        var tabheight = 35;
        var frame = document.getElementById('frame1');
        frame.style.position = "absolute";
        frame.style.left = 0;
        frame.style.top = 45;
        frame.style.width = w;
        // frame.style.height = h-tabheight;            

        var tabstrip = document.getElementById('tabstrip1');
        tabstrip.style.position = "absolute";
        tabstrip.style.left = 0;
        // tabstrip.style.top=h-tabheight;
        tabstrip.style.width = w;
        // tabstrip.style.height = h;
    }

    function ProcessTabClick(tabitem, eventArgs) {
        var tab = eventArgs.get_tab();
        if (tab.get_value() == "basic") BasicConfigurationWindow();
        if (tab.get_value() == "overdue") OverdueConfigWindow();
        if (tab.get_value() == "kpi") KPIDataPointsWindow();
        if (tab.get_value() == "kpis") KPIsWindow();
        if (tab.get_value() == "Performance") PerformanceWindow();
        if (tab.get_value() == "Alert") AlertWindow();
    }

    function ShowConfigWindow() {


        if (showbasicconfig == "True") BasicConfigurationWindow();
        if (showOverdueConfig == "True") OverdueConfigWindow();
        if (showKPIdataPoints == "True") KPIDataPointsWindow();
        if (showKPIs == "True") KPIsWindow();
        if (showPerformanceConfig == "True") PerformanceWindow();
        if (showAlertManager == "True") AlertWindow();
    }

    function GotoPage(url) {

        var l = window.location.toString();
        l = l.replace("BamConfig.aspx", url);
        document.getElementById('framecontent').src = l;
    }

    function BasicConfigurationWindow() {
        GotoPage("basicconfig.aspx");
    }

    function PerformanceWindow() {
        GotoPage("PerformanceConfig.aspx");
    }

    function OverdueConfigWindow() {

            if (showOverdueConfig == "True") {
                GotoPage("overdueconfig.aspx");
            }
            else {
                ShowConfigWindow();
            }

        }


        function KPIDataPointsWindow() {
            GotoPage("KPIDataPoints.aspx");
        }

        function KPIsWindow() {
            GotoPage("KPIs.aspx");
        }

        function AlertWindow() {
            GotoPage("AlertManager.aspx");
        }
        function ShowMessage() {
           // alert('You do not have rights to configure BAM.'); 
            se.ui.messageDialog.showAlert("<%=GR.GlobalResourceSet.GetString("Security_Rights_comn_Alert_for_list")%>", "<%=GR.GlobalResourceSet.GetString("BAM_No_Rights_To_Configure_Settings")%>");
        }

</script>
<style>
    html {
        overflow: hidden;
    }
</style>

<body onload="Resize();OverdueConfigWindow();" style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px; border-style: none; overflow: hidden;" scroll="no">
    
    
    
     <form id="form1" runat="server">
         <script src="<%:JSPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
        <link href="<%:cssPath%>CommonUXControls/StyleSheet/se.ui.min.css"  rel="stylesheet" type="text/css" />
         <link href="<%:cssPath%>TelerikAjax/StyleSheet/AWTTabStrip/TabStrip.AWTTabStrip.css" rel="stylesheet" type="text/css" />
         <telerik:RadScriptManager ID="RadScriptManager1" runat="server" />
         <script>
             se.ui.messageDialog.setGlobalOptions({
                 localization: {
                     closeButtonCaption: "<%=GR.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                okButtonCaption: "<%=GR.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
                cancelButtonCaption: "<%=GR.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                showDetailsCaption: "<%=GR.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                hideDetailsCaption: "<%=GR.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
            }
        });
        </script>
        <div id='tabstrip1' style="width: 100%; height: 15%;">
             <telerik:RadTabStrip RenderMode="Classic" runat="server" ID="RadTabStrip1" Skin="AWTTabStrip" Orientation="HorizontalBottom" EnableEmbeddedSkins="false" OnClientTabSelected="ProcessTabClick"  SelectedIndex="0">
                <Tabs>
                <telerik:RadTab Text="Overdue Analysis" runat="server" ID="overdue" Value="overdue"></telerik:RadTab>
                <telerik:RadTab Text="KPI Data Points" runat="server" ID="kpi" Value="kpi" ></telerik:RadTab>
                <telerik:RadTab Text="KPI(s)" runat="server" ID="kpis" Value="kpis"></telerik:RadTab>
                <telerik:RadTab Text="Performance" ID="Performance" runat="server" Value="Performance"></telerik:RadTab>
                <telerik:RadTab Text="Alert" ID="Alert" runat="server" Value="Alert"></telerik:RadTab>
                <telerik:RadTab Text="Process Now" ID="basic" runat="server" Value="basic"></telerik:RadTab>
            </Tabs>
        </telerik:RadTabStrip>  
        </div>
        <div id='frame1' style="height: 92%; width: 100%;">
            <iframe id='framecontent' style="width: 100%; height: 100%; border-style: none;"
                src="blank.htm"></iframe>
        </div>
    </form>
</body>
</html>
