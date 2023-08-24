<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.ListControl_Grid" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>

<!DOCTYPE html >
<html style="height:100%;">
<head runat="server">
    <title></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>   
</head>
<body style="margin: 0;height: 100%;width:100%;overflow:hidden;" onload="resizeToArchestrAEnvironment();">
    <form id="form1" runat="server" style="height:100%;width:100%;">
    <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <script  type="text/javascript">

            
            var belMesgfrDspy = '<%=_ResManager.GlobalResourceSet.GetString("List_item_delete_cofrm_msg_usr") %>'; 
            var belMesgfrDspyindetail = '<%=_ResManager.GlobalResourceSet.GetString("List_item_delete_confrm_msg_for_all_actions") %>'; 
            var bellstMsg = '<%=_ResManager.GlobalResourceSet.GetString("List_item_Operation_for_list") %>'; 
            var belDownloadHead = '<%=_ResManager.GlobalResourceSet.GetString("Rpt_list_item_Attachment_belly_bar_Head") %>'; 
            var belDownloadMessage = '<%=_ResManager.GlobalResourceSet.GetString("Rpt_list_item_Attachment_belly_bar_Msg") %>'; 
            var belSecurityHead = '<%=_ResManager.GlobalResourceSet.GetString("Security_Rights_comn_Alert_for_list") %>'; 
            var belMulResumePublishHead = '<%=_ResManager.GlobalResourceSet.GetString("ec_Workflow_MultiResumePublishHead") %>';
            var belMulResumePublishMessage = '<%=_ResManager.GlobalResourceSet.GetString("ec_Workflow_MultiResumePublishMessage") %>';
            var belMulPauseUnPublishHead = '<%=_ResManager.GlobalResourceSet.GetString("ec_Workflow_MultiPauseUnPublishHead") %>';
            var belMulPauseUnPublishMessage = '<%=_ResManager.GlobalResourceSet.GetString("ec_Workflow_MultiPauseUnpublishMessage") %>';
            var belMulPublishStatusHead = '<%=_ResManager.GlobalResourceSet.GetString("ec_Workflow_PublishStatusHead") %>';
            var belMulPublishStatusMessage = '<%=_ResManager.GlobalResourceSet.GetString("ec_Workflow_PublishStatusMessage") %>';
            var belMulPublishFailedStatusMessage = '<%=_ResManager.GlobalResourceSet.GetString("ec_Workflow_PublishFailedStatusMessage") %>';
            var belMulUnPublishStatusHead = '<%=_ResManager.GlobalResourceSet.GetString("ec_Workflow_UnPublishStatusHead") %>';
            var belMulUnPublishStatusMessage = '<%=_ResManager.GlobalResourceSet.GetString("ec_Workflow_UnPublishStatusMessage") %>';
            var belMulUnPublishFailedStatusMessage = '<%=_ResManager.GlobalResourceSet.GetString("ec_Workflow_UnPublishFailedStatusMessage") %>';
            var belMulPublishFormsStatusMessage = '<%=_ResManager.GlobalResourceSet.GetString("ec_forms_PublishStatusMessage") %>';
            var belMulPublishFormsFailedStatusMessage = '<%=_ResManager.GlobalResourceSet.GetString("ec_forms_PublishFailedStatusMessage") %>';
            var belMulUnPublishFormsStatusMessage = '<%=_ResManager.GlobalResourceSet.GetString("ec_forms_UnPublishStatusMessage") %>';
            var belMulUnPublishFormsFailedStatusMessage = '<%=_ResManager.GlobalResourceSet.GetString("ec_forms_UnPublishFailedStatusMessage") %>';
            var bellyConfirmMsgWebApiSourceSync = '<%=_ResManager.GlobalResourceSet.GetString("webapisource_sych_confirm") %>'; 
            var FormDataRedefineMappingMessage = '<%=_ResManager.GlobalResourceSet.GetString("FormDataRedefineMapping") %>';
            var FormAlreadyHasMappingMessage = '<%=_ResManager.GlobalResourceSet.GetString("FormAlreadyHasMappingMessage") %>';
            var FormDataRedefineAssociationMessage = '<%=_ResManager.GlobalResourceSet.GetString("FormDataRedefineAssociation") %>';
            var FormBellyBarTitleMessage = '<%=_ResManager.GlobalResourceSet.GetString("FormBellyBarTitle") %>';
            var FormXMLEditMappingsButton = '<%=_ResManager.GlobalResourceSet.GetString("FormXMLEditMappingsButton") %>';
            var FormXMLEditAssociationButton = '<%=_ResManager.GlobalResourceSet.GetString("FormXMLEditAssociationButton") %>';
            
            var FormXMLCancelButton = '<%=_ResManager.GlobalResourceSet.GetString("FormXMLCancelButton") %>';

            if (navigator.userAgent.toLowerCase().indexOf('msie') > 0) {
                document.body.style.width = '99.8%';
            }

            var tempDir = '<%=templateDirectory%>';
            var isReadonly = '<%=readOnly%>';
            var themeDirectoryForImages = '<%=themedir %>';
            HideActionBarForReadOnlyListView();
            function HideActionBarForReadOnlyListView()
            { 
                if (isReadonly == "True")
                {
                    window.parent.$("#leftMenu").css("display", "none");                   
                }
            }

            function resizeToArchestrAEnvironment() {

                var gridObj = wgGetGridById("WebGrid1");
                gridObj.SetHeight("99%");

                if (window.parent.parent.location.href.indexOf('FromArchestrA') != -1) {
                    if (window.parent.parent.location.href.indexOf('AAOpenMode') != -1) return;
                    gridObj.SetHeight("99%");
                }
            }

            var loadmore = 0;

            function WebGrid1_OnBeforeRequest(controlId, action) {//debugger;
                var WebGrid1 = ISGetObject(controlId);

                if (action == "More") {
                    loadmore += 1;
                    document.getElementById('hdnRows').value = 50 + (loadmore * 50);
                }

                return true;
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

                HideActionBarForReadOnlyListView();
                
            }

            function OnColumnContextMenu(controlId, column, contextMenu) {
                var grid = ISGetObject(controlId);
                contextMenu.ClientSideEvents.OnMenuItemClick = "MenuClicked";
            }

            function MenuClicked(controlId, menuItem) {
                if (menuItem.Name == "mnuFilterBar") {
                    window.setTimeout(function () { wgDoResize(true, true); }, 100);
                }
            }

            function OnWebgridColumnSort(controlId, columnObject) {
                var grid = ISGetObject(controlId);
                if (IS.chrome)
                {
                    try
                    {                        
                        var colHeaderElement = grid.RootTable.GetElement(WG40.COLHEADER, WG40.HTMLTABLE);

                        var colHeaderElementTR = colHeaderElement.childNodes[0];
                        sortIndicatorElement = colHeaderElementTR.getElementsByClassName("DefSI");
                        for (i = 0; i < sortIndicatorElement.length; i++) {
                            sortIndicatorElement[i].style.display = "";
                        }
                    }
                    catch(e)
                    {}
                }
                return true;
            }


        </script>

        <script type="text/javascript" src="<%=templateDirectory%>Scripts/menu.js"></script>
        <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script>             
         <link rel="stylesheet" type="text/css" href="<%=themedir %>Common/StyleSheet/Global.css" />
        <script src="../../Common/JavaScripts/spin.min.js"></script>
        <ISWebGrid:WebGrid ID="WebGrid1" runat="server" HorizontalAlign="NotSet" Width="100%" 
            OnInitializeDataSource="WebGrid1_InitializeDataSource" OnInitializeLayout="WebGrid1_InitializeLayout"
            OnInitializeRow="WebGrid1_InitializeRow" AllowAutoDataCaching="false" DisableFileSystemChecking="true"
            EnableWebResources="never" Height="99%"  >
            <roottable gridlinestyle="NotSet" caption="List">
            </roottable>
            <layoutsettings allowexport="yes" alternatingcolors="True" pagingmode="VirtualLoad" 
                virtualloadmode="Custom" filterbarvisible="false" allowfilter="Yes" gridlinestyle="Solid"
                gridlinecolor="#afafaf" cellpaddingdefault="1" rowheightdefault="25px" gridlines="None" RowHeaders="No"
                virtualpagesize="100" autofitcolumns="true" autoheight="true" allowsorting="no" AutoWidth="false"
                allowcolumnsizing="Yes" alwaysshowhelpbutton="false" >
                <HeaderStyle CssClass="GridHeaderStyle" Wrap="false" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden" ></HeaderStyle>
                <ClientSideEvents OnInitialize="OnInitialize" OnRowContextMenu="ShowContextMenu" OnBeforeRequest="WebGrid1_OnBeforeRequest"
                    OnCellDblClick="DoCellClick" OnRowSelect="RowSelect" onAfterResponseProcess="ResizeGrid1" OnColumnContextMenu="OnColumnContextMenu" OnColumnSort="OnWebgridColumnSort" ></ClientSideEvents>
                <FocusCellStyle CssClass="GridFocusCellStyle"/>
                <PreviewRowStyle ForeColor="#0000C0"></PreviewRowStyle>
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
                <FrameStyle GradientType="Vertical" CssClass="GridFrameStyle"></FrameStyle>
                <SelectedRowStyle CssClass="GridSelectedRowStyle"></SelectedRowStyle>
                <StatusBarStyle CssClass="GridStatusBarStyle">
                <Padding Top="0px" Left="0px" Bottom="0px" Right="0px"></Padding>
                </StatusBarStyle>
                <StatusBarCommandStyle Active-CssClass="GridStatusBarStyle" Normal-CssClass="GridStatusBarStyle" Over-CssClass="GridStatusBarStyle">
                 </StatusBarCommandStyle>
                <RowStyle CssClass="GridRowStyle" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden"/>
                <NewRowStyle CssClass="GridNewRowStyle"></NewRowStyle>                
                <AlternatingRowStyle CssClass="GridAlternatingRowStyle" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden"></AlternatingRowStyle>
                <TextSettings Language="UseCulture">
                </TextSettings>
                 <ImageSettings RefreshImage="<%$ ReplaceTemplateExpn:Grid/images/refresh.png%>" MoreDataImage="<%$ ReplaceTemplateExpn:Grid/images/LoadMoreData.png%>"
                 ExportImage="<%$ ReplaceTemplateExpn:Grid/images/Export.png%>" />
            </layoutsettings>
        </ISWebGrid:WebGrid>
        <asp:HiddenField ID="hdnRows" runat="server" />
    </form>
     <script type="text/javascript">
         if (sysDel == undefined || sysDel == null)
             sysDel = '<%=_ResManager.GlobalResourceSet.GetString("ec_rbn_wf_sysdelete") %>';
		 if (sysCreateTemplate == undefined || sysCreateTemplate == null)
                sysCreateTemplate = '<%=_ResManager.GlobalResourceSet.GetString("ec_sysCreateTemplate_managepacke") %>'; 
         if (sysDel_WF == undefined || sysDel_WF == null)
             sysDel_WF = '<%=_ResManager.GlobalResourceSet.GetString("ec_rbn_wf_sysdelete_WF") %>';
         if (norightforaction == undefined || norightforaction == null)
             norightforaction = '<%=_ResManager.GlobalResourceSet.GetString("ec_rbn_wf_norightforaction") %>';
         if (SecurityApprovalWFAttached == undefined || SecurityApprovalWFAttached == null)
             SecurityApprovalWFAttached = '<%=_ResManager.GlobalResourceSet.GetString("ec_rbn_wf_SecurityWFAttached") %>';
         if (ApprovalWFAttachedcontinue == undefined || ApprovalWFAttachedcontinue == null)
             ApprovalWFAttachedcontinue = '<%=_ResManager.GlobalResourceSet.GetString("ec_rbn_wf_ApprovalWFAttached") %>';
         if (cannotPerDisable == undefined || cannotPerDisable == null)
             cannotPerDisable = '<%=_ResManager.GlobalResourceSet.GetString("ec_rbn_wf_cannotperformondisabled") %>';
         if (canEOIO == undefined || canEOIO == null)
             canEOIO = '<%=_ResManager.GlobalResourceSet.GetString("ec_edit_owned_items_only") %>';
         if (canVOIO == undefined || canVOIO == null)
             canVOIO = '<%=_ResManager.GlobalResourceSet.GetString("ec_view_owned_items_only") %>';
         if (noRowSelected == undefined || noRowSelected == null)
             noRowSelected = '<%=_ResManager.GlobalResourceSet.GetString("ec_rbn_wf_norowselected") %>';
 </script>
</body>
</html>
