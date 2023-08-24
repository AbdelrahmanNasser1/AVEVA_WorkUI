<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.ListItemVersions" %>
<%@ Register Assembly="Workflow.NET.NET2" Namespace="Workflow.NET.Ajax" TagPrefix="cc1" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <style>
        html, body
        {
            height:100%;
        }

    </style>
    <script language="javascript">
    function HideContextMenu(gridId, rowType, rowEl, rowMenu,location)
     {   
         if (rowType != "Record") return true;	
        
        if(rowType =="Record")
        {
            // hiding grid's default context menu
            for (i = 0; i <= 43; i++)
            { 
                rowMenu.Items[i].Hide();
            }           
        }
    }

    function Init() {
        var grid = ISGetObject("WebGrid1");
        try
        {           
            grid.HidePadColumn = true;
            grid.GetRootTable().Columns[0].ResizeBestFit();
            grid.GetRootTable().Columns[1].ResizeBestFit();

        }
        catch (e)
        { }

    }
    AddEventHandler(window, 'load', Init);
    AddEventHandler(window, 'resize', Init);

    function AddEventHandler(elementObject, eventName, functionObject) {
        if (document.addEventListener)
            elementObject.addEventListener(eventName, functionObject, false);
        else
            if (document.attachEvent)
                elementObject.attachEvent("on" + eventName, functionObject);
    }
   
     
</script>
</head>
<body style="margin: 0; overflow: hidden;">
    <form id="form1" runat="server" style="height:100%;">
        <script language='JavaScript' src="<%=templateRootDir%>Repository/ListControl/Scripts/menuversion.js"></script>
        <link rel="stylesheet" type="text/css" href="<%=ThemeURL %>Common/StyleSheet/Global.css" />        
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <div style="height: 100%;">
            <ISWebGrid:WebGrid ID="WebGrid1" runat="server" Height="100%" HorizontalAlign="NotSet"
                OnInitializeDataSource="WebGrid1_InitializeDataSource" OnInitializeLayout="WebGrid1_InitializeLayout"
                OnInitializeRow="WebGrid1_InitializeRow" AllowAutoDataCaching="false" DisableFileSystemChecking="true"
                EnableWebResources="never">
                <RootTable GridLineStyle="NotSet" Caption="List">
                </RootTable>
                <LayoutSettings AlternatingColors="True" CellPaddingDefault="2" GridLineColor="224, 224, 224" GridLineStyle="Solid"
                    RowHeightDefault="20px" AutoFitColumns="false" AutoHeight="false" AlwaysShowHelpButton="false" RowHeaders="No" GridLines="None">
                    <HeaderStyle Wrap="false" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CssClass="GridHeaderStyle"></HeaderStyle>
                    <ClientSideEvents  OnRowContextMenu="HideContextMenu"></ClientSideEvents>
                    <FocusCellStyle CssClass="GridFocusCellStyle" />
                    <PreviewRowStyle ForeColor="#0000C0"></PreviewRowStyle>
                    <GroupRowInfoStyle BackColor="#F1EFE2" BorderColor="White" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="8pt">
                        <BorderSettings>
                            <Bottom Color="Silver" />
                            <Right Color="Silver" />
                        </BorderSettings>
                    </GroupRowInfoStyle>
                    <EditTextboxStyle BorderStyle="None" BorderWidth="0px" Font-Names="Verdana" Font-Size="8pt"></EditTextboxStyle>
                    <FrameStyle GradientType="Vertical" CssClass="GridFrameStyle"></FrameStyle>
                    <SelectedRowStyle CssClass="GridSelectedRowStyle"></SelectedRowStyle>
                    <AlternatingRowStyle Overflow="Hidden" OverflowX="Hidden" OverflowY="Hidden" CssClass="GridAlternatingRowStyle" />
                    <StatusBarStyle CssClass="GridStatusBarStyle">
                        <Padding Top="0px" Left="0px" Bottom="0px" Right="0px"></Padding>
                    </StatusBarStyle>
                    <StatusBarCommandStyle Active-CssClass="GridStatusBarStyle" Normal-CssClass="GridStatusBarStyle" Over-CssClass="GridStatusBarStyle">
                    </StatusBarCommandStyle>
                    <RowStyle Overflow="Hidden" OverflowX="Hidden" OverflowY="Hidden" CssClass="GridRowStyle" />
                    <NewRowStyle CssClass="GridNewRowStyle"></NewRowStyle>
                    <ScrollBarStyle ArrowColor="255, 192, 192" />
                    <TextSettings Language="UseCulture">
                    </TextSettings>
                    <ImageSettings RefreshImage="<%$ ReplaceTemplateExpn:Grid/images/refresh.png%>" MoreDataImage="<%$ ReplaceTemplateExpn:Grid/images/LoadMoreData.png%>"
                        ExportImage="<%$ ReplaceTemplateExpn:Grid/images/Export.png%>" />
                </LayoutSettings>
            </ISWebGrid:WebGrid>
        </div>
    </form>
</body>
</html>
<script type="text/javascript">
    function isIE11() {
        return !!navigator.userAgent.match(/Trident.*rv[ :]*11\./);
    }

    function ResizeGrid() {
        if (isIE11()) {
            window.setTimeout(function () { wgDoResize(true, true); }, 600);
            return true;
        }
    }

    ResizeGrid();

</script>