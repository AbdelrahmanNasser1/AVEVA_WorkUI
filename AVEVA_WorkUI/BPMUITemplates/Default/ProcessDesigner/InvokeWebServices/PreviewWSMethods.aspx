<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.InvokeWS.PreviewWSMethods" Theme="" StylesheetTheme=""%>

<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>


<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>Web Services</title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
   
</head>
<body>
    <form id="frmPrvMthd" runat="server">
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <link  rel="stylesheet" href="<%=cssPath%>Common/StyleSheet/global.css" type="text/css" />
		<div style="width:99%" style="text-align:right">
		<iswebgrid:webgrid id="WGrdMthdPrv" runat="server" height="160px" horizontalalign="NotSet"
        width="100%" OnInitializeDataSource="WGrdMthdPrv_InitializeDataSource"  AllowAutoDataCaching=false DisableFileSystemChecking="true" EnableWebResources="never">
            <LayoutSettings AllowFilter="yes" filterbarvisible="false" RowHeaders="No"
                                       AlternatingColors="true"                                                  
                                       GridLineStyle="Solid" 
                                       GridLineColor="#afafaf" 
                                       CellPaddingDefault="2" 
                                       RowHeightDefault="22px" 
                                       GridLines="None" 
                                       StatusBarVisible="True" 
                                       NewRowLostFocusAction="AlwaysPrompt" 
                                       RowLostFocusAction="AlwaysPrompt"
                                       PagingMode="VirtualLoad"  VirtualPageSize="50"
                                       PromptBeforeDelete="true"  AutoHeight=false                                                 
                                       AutoFitColumns="True" ShowRefreshButton="true" AllowExport="Yes" AlwaysShowHelpButton="false" AllowSorting="yes" AllowColumnSizing="Yes">                                                                                         
                                                           <HeaderStyle Wrap="false" Height="20px" Overflow="hidden" OverflowX="hidden" OverflowY="hidden"
                                                    CssClass="GridHeaderStyle"></HeaderStyle>

                                    <FocusCellStyle CssClass="GridFocusCellStyle"></FocusCellStyle>
                                    <GroupRowInfoStyle CssClass="GridGroupRowInfoStyle"></GroupRowInfoStyle>
                                    <GroupByBox>
                                        <LabelStyle CssClass="GridLabelStyle"></LabelStyle>
                                    </GroupByBox>
                                    <EditTextboxStyle CssClass="GridEditTextboxStyle"></EditTextboxStyle>
                                    <FrameStyle GradientType="Vertical" CssClass="GridFrameStyle"></FrameStyle>
                                    <SelectedRowStyle CssClass="GridSelectedRowStyle" CustomRules="text-overflow: ellipsis; overflow-x: hidden"></SelectedRowStyle>                                    
                                    <AlternatingRowStyle CssClass="GridAlternatingRowStyle" CustomRules="text-overflow: ellipsis; overflow-x: hidden"/>
                                    <RowStyle CssClass="GridRowStyle" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden"></RowStyle>  
                                    <NewRowStyle CssClass="GridNewRowStyle"></NewRowStyle>
                                    <EditFocusCellStyle CssClass="GridEditFocusCellStyle"></EditFocusCellStyle>
                                    <TextSettings Language="UseCulture"></TextSettings>
                                    <ButtonStyle CssClass="inputbutton" Height="17px" ></ButtonStyle>
                                    <ClientSideEvents OnRowContextMenu="DisableContextMenu" />
                                    <TextSettings Language="UseCulture"></TextSettings>   
                                    <StatusBarStyle CssClass="GridStatusBarStyle">
                                        <Padding Top="2px" Left="2px" Bottom="2px" Right="2px"></Padding>
                                    </StatusBarStyle>
                        </layoutsettings>
                                <RootTable GridLineStyle="NotSet">
                                    <TableHeaderStyle CssClass="GridTableHeaderStyle">
                                        <Padding Bottom="4px" Left="4px" Top="4px" Right="4px"></Padding>
                                    </TableHeaderStyle>
                                </RootTable> 
                    </ISWebGrid:WebGrid>
    </div>
    <script language="javascript"  type="text/javascript">

        function DisableContextMenu(gridId, rowType, rowEl, rowMenu) {
            if (rowType != "Record") return true;
            if (rowType == "Record") {
                // hide the default context menu
                for (i = 0; i <= 43; i++) {
                    rowMenu.Items[i].Hide();
                }
            }
        }
        function isIE11() {
            return !!navigator.userAgent.match(/Trident.*rv[ :]*11\./);
        }

        function ResizeGrid() {
            if (isIE11()) {
                var grid = ISGetObject("WGrdMthdPrv");
                grid.SetHeight(160 + 'px');
            }
        }

        ResizeGrid();
     </script>
    </form>
</body>
</html>
