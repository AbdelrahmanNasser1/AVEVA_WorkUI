<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.FormVersionGrid" %>
<%@ Register Assembly="Workflow.NET.NET2" Namespace="Workflow.NET.Ajax" TagPrefix="cc1" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>
<!DOCTYPE html>
<html style="height:100%">
<head id="Head1" runat="server">
    <title> </title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
</head>
<body style="margin:0;height:99%;width:100%;overflow:hidden" >
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=themedir %>CommonUXControls/StyleSheet/se.ui.min.css" />      
    <script>
        se.ui.messageDialog.setGlobalOptions({
            localization: {
                closeButtonCaption: "<%=_resmgr.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>", 
                okButtonCaption: "<%=_resmgr.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>", 
                cancelButtonCaption: "<%=_resmgr.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>", 
                showDetailsCaption: "<%=_resmgr.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>", 
                hideDetailsCaption: "<%=_resmgr.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" 
            }
        });
    </script>
    <form id="form1" runat="server" style="height:100%;width:100%;">
	<%=System.Web.Helpers.AntiForgery.GetHtml()%>
<script type="text/javascript">
    var urlparams = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(urlParams, false)%>";
    var themeDirectoryForImages = '<%=themedir %>';
    var templateDirectory = '<%=templateDirectory%>';

    function ResizeGrid() {
        var gridObj = wgGetGridById("WebGrid1"); gridObj.SetHeight("400px");

    }
    function ResizeGrid1(controlId, actionName, lastRequestObject, xmlResponseObject) {
        if (navigator.userAgent.toLowerCase().indexOf('chrome') > 0 || navigator.userAgent.indexOf("Firefox") > -1) {

            if (actionName == "RefreshAll" || actionName == "Refresh") {

                var WebGrid1 = ISGetObject(controlId);
                window.setTimeout(function () {
                    wgDoResize(true, true);
                }, 600);
                return true;


            }
        }

    }

    function OnWebgridColumnSort(controlId, columnObject) {
        var grid = ISGetObject(controlId);

        if (IS.chrome) {
            try {
                var colHeaderElement = grid.RootTable.GetElement(WG40.COLHEADER, WG40.HTMLTABLE);

                var colHeaderElementTR = colHeaderElement.childNodes[1].childNodes[0];
                sortIndicatorElement = colHeaderElementTR.getElementsByClassName("DefSI");
                for (i = 0; i < sortIndicatorElement.length; i++) {
                    sortIndicatorElement[i].style.display = "";
                }
            }
            catch (e)
            { }
        }
        return true;
    }
</script>
<script type="text/javascript" src="<%=templateDirectory%>Scripts/menuversion.js"></script>
<link rel="stylesheet" type="text/css" href="<%=themedir %>Common/StyleSheet/Global.css" />
        <script src="../../Common/JavaScripts/spin.min.js"></script>

<ISWebGrid:WebGrid ID="WebGrid1" runat="server" HorizontalAlign="NotSet" Width="100%" Height="99%" RenderingMode="HTML5"
                        OnInitializeDataSource="WebGrid1_InitializeDataSource" OnInitializeLayout="WebGrid1_InitializeLayout" OnInitializeRow="WebGrid1_InitializeRow" AllowAutoDataCaching="false" DisableFileSystemChecking="true" EnableWebResources="never">
                        <RootTable GridLineStyle="NotSet" Caption="List">
                        </RootTable>
                       <LayoutSettings AlternatingColors="true" CellPaddingDefault="2" GridLineColor="224, 224, 224"
                            GridLineStyle="Solid" RowHeightDefault="25px" AutoFitColumns="true" AutoHeight="true" AutoWidth="false" AllowSorting="yes" AllowColumnSizing="no" AlwaysShowHelpButton="false"
                            RowHeaders="No" GridLines="None">
                            <HeaderStyle Wrap="false" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CssClass="GridHeaderStyle"  CustomRules="border-bottom: #73A1E4 1px solid" ></HeaderStyle>
                            <ClientSideEvents  OnInitialize="OnInitialize" OnRowContextMenu="ShowContextMenu" OnCellDblClick="DoCellClick" OnRowSelect="RowSelect" OnColumnSort="OnWebgridColumnSort" onAfterResponseProcess="ResizeGrid1"></ClientSideEvents>
                            <FocusCellStyle CssClass="GridFocusCellStyle" />
                            <PreviewRowStyle ForeColor="#0000C0">
                            </PreviewRowStyle>
                            <StatusBarCommandStyle>
                                <Active BackColor="RoyalBlue" BaseStyle="Over">
                                </Active>
                                <Over BackColor="CornflowerBlue" BorderColor="Navy" BorderStyle="Solid" BorderWidth="1px">
                                </Over>
                                <Normal>
                                    <Padding Bottom="1px" Left="1px" Right="1px" Top="1px" />
                                </Normal>
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
                            <FrameStyle CssClass="GridFrameStyle"></FrameStyle>
                            <SelectedRowStyle CssClass="GridSelectedRowStyle"></SelectedRowStyle>
                            <AlternatingRowStyle CssClass="GridAlternatingRowStyle" Overflow="Hidden" OverflowX="Hidden" OverflowY="Hidden"  CustomRules="text-overflow: ellipsis; overflow-x: hidden"
                                />
                            <StatusBarStyle CssClass="GridStatusBarStyle">
                            <Padding Top="0px" Left="0px" Bottom="0px" Right="0px"></Padding>
                            </StatusBarStyle>
                            <RowStyle CssClass="GridRowStyle" Overflow="Hidden" OverflowX="Hidden" OverflowY="Hidden"  CustomRules="text-overflow: ellipsis; overflow-x: hidden"
                                />
                            <NewRowStyle CssClass="GridNewRowStyle">
                            </NewRowStyle>
                             <ImageSettings RefreshImage="<%$ ReplaceTemplateExpn:Grid/images/refresh.png%>" MoreDataImage="<%$ ReplaceTemplateExpn:Grid/images/LoadMoreData.png%>"
                             ExportImage="<%$ ReplaceTemplateExpn:Grid/images/Export.png%>" />
                            <TextSettings Language="UseCulture">
                            </TextSettings>
                        </LayoutSettings>
                    </ISWebGrid:WebGrid>
    </form>
    <script  type="text/javascript">        
        var bellyBarTitle = '<%=_resmgr.GlobalResourceSet.GetString("List_item_Operation_for_list") %>';
        if (sysDel == undefined || sysDel == null)
            sysDel = '<%=_resmgr.GlobalResourceSet.GetString("ec_rbn_wf_sysdelete") %>';
        if (norightforaction == undefined || norightforaction == null)
            norightforaction = '<%=_resmgr.GlobalResourceSet.GetString("ec_rbn_wf_norightforaction") %>';
        if (ApprovalWFAttachedcontinue == undefined || ApprovalWFAttachedcontinue == null)
            ApprovalWFAttachedcontinue = '<%=_resmgr.GlobalResourceSet.GetString("ec_rbn_wf_ApprovalWFAttached") %>';
        if (cannotPerDisable == undefined || cannotPerDisable == null)
            cannotPerDisable = '<%=_resmgr.GlobalResourceSet.GetString("ec_rbn_wf_cannotperformondisabled") %>';
        if (noRowSelected == undefined || noRowSelected == null)
            noRowSelected = '<%=_resmgr.GlobalResourceSet.GetString("ec_rbn_wf_norowselected") %>';

            var belMulPublishFormsStatusMessage = '<%=_resmgr.GlobalResourceSet.GetString("ec_forms_PublishStatusMessage") %>';
            var belMulPublishFormsFailedStatusMessage = '<%=_resmgr.GlobalResourceSet.GetString("ec_forms_PublishFailedStatusMessage") %>';
            var belMulUnPublishFormsStatusMessage = '<%=_resmgr.GlobalResourceSet.GetString("ec_forms_UnPublishStatusMessage") %>';
            var belMulUnPublishFormsFailedStatusMessage = '<%=_resmgr.GlobalResourceSet.GetString("ec_forms_UnPublishFailedStatusMessage") %>';
            var belMulPublishStatusHead = '<%=_resmgr.GlobalResourceSet.GetString("ec_Workflow_PublishStatusHead") %>';           
            var belMulUnPublishStatusHead = '<%=_resmgr.GlobalResourceSet.GetString("ec_Workflow_UnPublishStatusHead") %>';
    </script>
</body>
</html>
