<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AuditTrail.aspx.cs" Inherits="AuditTrail" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>
<!DOCTYPE HTML>
<html>
<head id="Head1" runat="server">
    <title><%=_ResMgr.GlobalResourceSet.GetString("Audit_History") %></title>
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
     <script type="text/javascript">

         function HideContextMenu(gridId, rowType, rowEl, rowMenu, location) {
             if (rowType != "Record") return true;

             if (rowType == "Record") {
                 // hiding grid's default context menu
                 for (i = 0; i <= 43; i++) {
                     rowMenu.Items[i].Hide();
                 }
             }
         }

         function Init()
         {
             var grid = ISGetObject("WebGrid1");            
             try {
                 grid.GetRootTable().Columns[0].ResizeBestFit();
                
             } catch (e) { }

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
     <script type="text/javascript" src="<%=templateRootDir %>Repository/ListControl/Scripts/menu.js"></script>
     <link rel="stylesheet" type="text/css" href="<%=ThemeURL %>Common/StyleSheet/Global.css" />        
     
            <div style="height:100%;width:98%;padding-left:8px;">
                    <ISWebGrid:WebGrid ID="WebGrid1" runat="server" HorizontalAlign="NotSet" OnInitializeDataSource="WebGrid1_InitializeDataSource"
                    OnInitializeLayout="WebGrid1_InitializeLayout" OnInitializeRow="WebGrid1_InitializeRow" 
                    AllowAutoDataCaching="false" DisableFileSystemChecking="true" EnableWebResources="never" Height="100%" RenderingMode="HTML5">
                    <RootTable GridLineStyle="NotSet" Caption="List">
                    </RootTable>
                    <layoutsettings allowexport="yes" alternatingcolors="True" pagingmode="VirtualLoad"
                        virtualloadmode="Custom" filterbarvisible="false" allowfilter="Yes" gridlinestyle="Solid"
                        gridlinecolor="#afafaf" cellpaddingdefault="1" rowheightdefault="22px" gridlines="None"
                        virtualpagesize="20" AutoFitColumns="false" AutoHeight="false"  allowsorting="no"
                        allowcolumnsizing="Yes" alwaysshowhelpbutton="false" RowHeaders="No" >
                        <HeaderStyle Wrap="false" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CssClass="GridHeaderStyle"></HeaderStyle>
                        <ClientSideEvents  OnRowContextMenu="HideContextMenu" ></ClientSideEvents>
                        <FocusCellStyle CssClass="GridFocusCellStyle"/>
                        <PreviewRowStyle ForeColor="#0000C0"></PreviewRowStyle>
                        <StatusBarCommandStyle Active-CssClass="GridStatusBarStyle" Normal-CssClass="GridStatusBarStyle" Over-CssClass="GridStatusBarStyle">
                        </StatusBarCommandStyle>
                        <GroupRowInfoStyle BackColor="#F1EFE2" BorderColor="White" BorderStyle="Solid" BorderWidth="1px"
                            Font-Names="Verdana" Font-Size="8pt">
                            <BorderSettings>
                                <Bottom Color="Silver" />
                                <Right Color="Silver" />
                            </BorderSettings>
                        </GroupRowInfoStyle>
                        <GroupByBox>
                            <LabelStyle BackColor="White" BorderColor="Navy" BorderStyle="Solid" BorderWidth="1px"
                                Font-Names="Verdana" Font-Size="8pt" />
                            <Style BackColor="Gray"></Style>
                        </GroupByBox>
                        <EditTextboxStyle BorderStyle="None" BorderWidth="0px" Font-Names="Verdana" Font-Size="8pt">
                        </EditTextboxStyle>
                        <FrameStyle GradientType="Vertical" CssClass="GridFrameStyle" ></FrameStyle>
                        <SelectedRowStyle CssClass="GridSelectedRowStyle"></SelectedRowStyle>
                        <StatusBarStyle CssClass="GridStatusBarStyle">
                        <Padding Top="0px" Left="0px" Bottom="0px" Right="0px"></Padding>
                        </StatusBarStyle>
                        <RowStyle Overflow="Hidden" OverflowX="Hidden" OverflowY="Hidden" CssClass="GridRowStyle" />
                        <AlternatingRowStyle CssClass="GridAlternatingRowStyle" Overflow="Hidden" OverflowX="Hidden" OverflowY="Hidden" />
                        <NewRowStyle CssClass="GridNewRowStyle"></NewRowStyle>
                        
                        <TextSettings Language="UseCulture">
                        </TextSettings>
                        <ImageSettings 
                            RefreshImage="<%$ ReplaceTemplateExpn:Grid/images/refresh.png%>" 
                            MoreDataImage="<%$ ReplaceTemplateExpn:Grid/images/LoadMoreData.png%>"
                            ExportImage="<%$ ReplaceTemplateExpn:Grid/images/Export.png%>"                                            
                         />
                    </layoutsettings>
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

