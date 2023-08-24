<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.ListItemChild" %>

<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title> </title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <style>
        html, body
        {
            height:100%;
        }

    </style>
</head>
<body style="margin:0;overflow:hidden">
    <form id="form1" runat="server" style="height:100%;">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <script language="javascript">
            //var tempDir = '<%=templateDirectory%>';
            function HideContextMenu(gridId, rowType, rowEl, rowMenu,location)
             {   
                 if (rowType != "Record") return true;	
                
                if(rowType =="Record")
                {
                    // hiding grid's default context menu
                    for (i=0;i<=43;i++){ 
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
                catch (e) { }

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
        <script language='JavaScript' src="<%=templateRootDir%>Repository/ListControl/Scripts/menu.js"></script>
        <link rel="stylesheet" type="text/css" href="<%=ThemeURL %>Common/StyleSheet/Global.css" />        

        
        <div style="height: 100%;">
            <ISWebGrid:WebGrid ID="WebGrid1" runat="server" HorizontalAlign="NotSet" OnInitializeDataSource="WebGrid1_InitializeDataSource"
                OnInitializeLayout="WebGrid1_InitializeLayout" OnInitializeRow="WebGrid1_InitializeRow" Height="100%"
                AllowAutoDataCaching="false" DisableFileSystemChecking="true" EnableWebResources="never">
                <RootTable GridLineStyle="NotSet" Caption="List">
                </RootTable>
                <LayoutSettings AlternatingColors="True" CellPaddingDefault="2" GridLineColor="224, 224, 224"
                    GridLineStyle="Solid" RowHeightDefault="20px" AutoFitColumns="true" AutoHeight="false"
                    AlwaysShowHelpButton="false" RowHeaders="No" GridLines="None">
                    <HeaderStyle Wrap="false" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CssClass="GridHeaderStyle"></HeaderStyle>
                    <ClientSideEvents OnInitialize="OnInitialize" OnRowContextMenu="HideContextMenu"></ClientSideEvents>
                    <FocusCellStyle CssClass="GridFocusCellStyle" />
                    <PreviewRowStyle ForeColor="#0000C0"></PreviewRowStyle>
                    <StatusBarCommandStyle Active-CssClass="GridStatusBarStyle" Normal-CssClass="GridStatusBarStyle" Over-CssClass="GridStatusBarStyle">
                    </StatusBarCommandStyle>
                    <GroupByBox>
                        <LabelStyle BackColor="White" BorderColor="Navy" BorderStyle="Solid" BorderWidth="1px"
                            Font-Names="Verdana" Font-Size="8pt" />
                        <Style BackColor="Gray"></Style>
                    </GroupByBox>
                    <EditTextboxStyle BorderStyle="None" BorderWidth="0px" Font-Names="Verdana" Font-Size="8pt">
                    </EditTextboxStyle>
                    <FrameStyle GradientType="Vertical" CssClass="GridFrameStyle" BorderStyle="Solid"></FrameStyle>
                    <SelectedRowStyle CssClass="GridSelectedRowStyle"></SelectedRowStyle>
                    <AlternatingRowStyle Overflow="Hidden" OverflowX="Hidden" OverflowY="Hidden" CssClass="GridAlternatingRowStyle" />
                    <StatusBarStyle CssClass="GridStatusBarStyle">
                        <Padding Top="0px" Left="0px" Bottom="0px" Right="0px"></Padding>
                    </StatusBarStyle>
                    <RowStyle Overflow="Hidden" OverflowX="Hidden" OverflowY="Hidden" CssClass="GridRowStyle" />
                    <NewRowStyle CssClass="GridNewRowStyle"></NewRowStyle>
                    <ImageSettings RefreshImage="<%$ ReplaceTemplateExpn:Grid/images/refresh.png%>" MoreDataImage="<%$ ReplaceTemplateExpn:Grid/images/LoadMoreData.png%>"
                        ExportImage="<%$ ReplaceTemplateExpn:Grid/images/Export.png%>" />
                </LayoutSettings>
            </ISWebGrid:WebGrid>
        </div>
    </form>
</body>
</html>
