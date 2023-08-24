<%@ Page Language="C#" AutoEventWireup="true"  Inherits="Workflow.NET.CodeBehind.Bam.DrillDownOverDue" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html> 
<html>
<head id="Head1" runat="server">
    <title>Work Analysis Report</title>
    <style type="text/css">
        html, body
        {
            height:98%;
        }
</style> 
</head>
<body>
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%:cssPath %>CommonUXControls/StyleSheet/se.ui.min.css" />      
    <script>
        // Initialize locales for message dialog
        se.ui.messageDialog.setGlobalOptions({
            localization: { // All localization related default can be set
                closeButtonCaption: "<%=GR.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                okButtonCaption: "<%=GR.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                cancelButtonCaption: "<%=GR.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                showDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                hideDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
            }
        });
    </script>
    <script language="javascript">
        function ShowProcessView(gridId, tblName, rowIndex, cellIndex, cellEl) {
            var grid = wgGetGridById("WebGrid1");
            if (grid.GetSelectedObject() == null) {
                se.ui.messageDialog.showError("<%=GR.GetString("SR_BAM_Desc") %>", "<%=GR.GetString("select_row") %>");
                return;
            }
            var row = wgGetGridById("WebGrid1").GetSelectedObject().GetRowElement();
            var cell = wgGetCellByPosition(row, 0);
            if (cell == null)
                return;
            var Urls = cell.getAttribute("skreporturl");
            if (Urls == null) {
                return;
            }
            //window.open(Urls, 'ProcessValue', 'height=500,width=700,resizable=yes,scrollbars=no,status=no');
            OpenBamPopup(Urls, 'Process Execution View', 700, 500);
        }

        //To open the window center of screen
        function OpenBamPopup(pageURL, title, popupWidth, popupHeight) {
            var left = (screen.width / 2) - (popupWidth / 2);
            var top = (screen.height / 2) - (popupHeight / 2);
            var targetPop = window.open(pageURL, title, 'status=no,scrollbars=no, resizable=yes, width=' + popupWidth + ', height=' + popupHeight + ', top=' + top + ', left=' + left);
        }

        function SaveLayout() {
            var Url = 'SaveLayout.aspx';
            window.open(Url, 'LayoutSaving', 'height=230,width=550,resizable=no,scrollbars=no,status=no')//,'LayoutSaving', 'height=120,width=400,resizable=yes,scrollbars=no,status=no');
        }
        function ExpandAll() {
            document.getElementById("IdExpand").click();
        }
        function CollapseAll() {
            document.getElementById("IdCollapse").click();
        }

        function SaveClick() {
            document.getElementById("_IdSaveBtn").click();
            var grid = ISGetObject("WebGrid1");
            grid.RefreshAll();
        }
        function DeleteLayout() {
            document.getElementById("_SelectedTreeNodeId").value = window.parent.document.getElementById("_idValue").value;
            document.getElementById("DeleteLayout_Button").click();
        }

        function HideContextMenu(gridId, rowType, rowEl, rowMenu, location)
        {

            if (rowType != "Record") {
                if (rowType == "FilterRow") {
                    rowMenu.Items.GetNamedItem("mnuHelp").Hide();
                }

                if (rowType == "GroupHeader") //For GroupHeader context menu
                {
                    rowMenu.Items.GetNamedItem("mnuCopyRow").Hide();
                    rowMenu.Items.GetNamedItem("mnuSep3").Hide();
                    rowMenu.Items.GetNamedItem("mnuHelp").Hide();
                    rowMenu.Items.GetNamedItem("mnuSep9").Hide();
                }
                return true;
            }

            if (rowType == "Record") {
                // hide the default context menu
                for (i = 0; i <= 43; i++) {
                    rowMenu.Items[i].Hide();
                }


            }

        }

        function OpenBAMExport() {
            var oWindow = radopen("BAMExport.aspx", null);
            oWindow.set_modal(true);
            oWindow.setSize(480, 195);
            oWindow.setActive(true);
        }
    </script>
    <form id="form1" runat="server" style="height:100%;">
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
        <link rel="stylesheet" type="text/css" href="<%:cssPath %>Common/StyleSheet/Global.css" />
         <link rel="stylesheet" type="text/css" href="<%:cssPath%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
        <link rel="stylesheet" type="text/css" href="<%:cssPath%>TelerikAjax/StyleSheet/AWTWindow/Window.css">
        <input type="hidden" id="_pageInstanceIds" name="_pageInstanceIds" runat="server" />  
        <table style="width:100%;height:5%;">
            <tr>        
                <td style="height:5%;width:60%" class="subtitle">                
                   <span id="spOverdue" runat="server" class="description"> <%=DisplayString%></span>
                    <asp:TextBox runat="server" ID="txtGridSize" Style="display:none;" AutoPostBack="true" OnTextChanged="SetSize"></asp:TextBox>                    
                </td>
                <td style="height:5%;width:30%;text-align:right;">
                <asp:Label ID="lblDescription1" runat="server" Text="Label" CssClass="description" Visible="false"></asp:Label>
                <asp:LinkButton ID="IdLinkBack" runat="server"  Text="LinkButton1" CssClass="textlinkblue"  OnClientClick="javascript:history.back(); return false;"></asp:LinkButton>
                </td>                    
                 
                <td style="height:5%;width:2%;text-align:right;" >                
                    <img src=" <%:cssPath %>BAM/images/expand.gif" style="cursor: hand" onclick="ExpandAll()"
                        title="<%=_ExpandAllToolTip%>" align="absmiddle" />
                    <asp:Button ID="IdExpand" runat="server" Text="Expand all Row" Style="display: none"
                        OnClick="IdExpand_Click" />
                </td>
                <td style="height:5%;width:3%;text-align:right;" >                   
                    <img src=" <%:cssPath %>BAM/images/collapse.gif" style="cursor: hand" onclick="CollapseAll()"
                        title="<%=_CollapseAllToolTip%>" align="absmiddle" />
                    <asp:Button ID="IdCollapse" runat="server" Text="Collapse all Row" Style="display: none"
                        OnClick="IdCollapse_Click" />
                </td>                       
            </tr>
        </table>
        <table style="width:100%;height:5%;background-color:white">
             <tr>
                <td style="width:100%;text-align:left;background-color:white;">
                    <table style="width:100%">
                        
                        <tr id="dataMismatch" runat="server">
                            <td style="padding:1px;">
                                <asp:Label ID="lblDescription2" runat="server" Text="Label" CssClass="errormsg"></asp:Label>
                            </td>
                        </tr>
                       
                    </table>    
                </td>
                 <td style="height:5%;text-align:right;vertical-align:middle;width:2%;padding-right:10px;">
                    <input type="image" style="cursor: hand; vertical-align: middle;" title="<%=GR.GetString("ec_BAMReports_ExportSettings_Tooltip")%>" src="<%:cssPath %>BAM/images/Export-Settings.png" onclick="OpenBAMExport(); return false;"/>
                </td>
            </tr>
            </table>
            <div style="width:100%;height:92%;vertical-align:top;">
                    <ISWebGrid:WebGrid ID="WebGrid1" runat="server" Height="100%" Width="100%" HorizontalAlign="NotSet"
                        ScriptDirectory="<%$ ReplaceTemplateExpn:InterSoft/Grid/CommonLibrary/WebGrid/V6_0_7200/ %>"
                        SharedScriptDirectory="<%$ ReplaceTemplateExpn:InterSoft/Grid/CommonLibrary/Shared/ %>"
                        OnInitializeDataSource="WebGrid1_InitializeDataSource" OnInitializeLayout="WebGrid1_InitializeLayout" OnPrepareDataBinding="WebGrid1_PrepareDataBinding" OnExport="WebGrid1_Export" AllowAutoDataCaching="false" DisableFileSystemChecking="true" EnableWebResources="never" WebDesktopScriptDirectory="../InterSoft/Grid/CommonLibrary/WebDesktop/V2_5_2007/">
                        <LayoutSettings AlternatingColors="true" CellPaddingDefault="2" GridLineColor="#afafaf"
                            AlwaysShowHelpButton="False" AllowFilter="Yes" AllowGrouping="Yes" GridLineStyle="Solid"
                            RowHeightDefault="23px" Hierarchical="True" ScriptDirectory="<%$ ReplaceTemplateExpn:InterSoft/Grid/CommonLibrary/WebGrid/V6_0_7200/ %>"
                            GridLines="None" AllowColumnMove="Yes" AllowExport="Yes" AllowSelectColumns="Yes"
                            AllowSorting="Yes" FilterBarVisible="False" AutoHeight="false" AutoFitColumns="false"
                            AutoWidth="true" AllowEdit="Yes" PagingMode="VirtualLoad" VirtualLoadMode="LargeData" VirtualPageSize="50" RowHeaders="No">
                            <HeaderStyle CssClass="GridHeaderStyle" ></HeaderStyle>
                            <FocusCellStyle CssClass="GridFocusCellStyle" />
                            <StatusBarStyle CssClass="GridStatusBarStyle">
                                             <Padding Top="2px" Left="2px" Bottom="2px" Right="2px"></Padding>
                                         </StatusBarStyle>
                                         <StatusBarCommandStyle Active-CssClass="GridStatusBarStyle" Normal-CssClass="GridStatusBarStyle" Over-CssClass="GridStatusBarStyle">
                                        </StatusBarCommandStyle>
                            <GroupRowInfoStyle CssClass="GridGroupRowInfoStyle"></GroupRowInfoStyle>

                            <GroupByBox>
                                <LabelStyle CssClass="LeftMenuLabelStyle"></LabelStyle>
                                <Style CssClass="TableGray"></Style>
                            </GroupByBox>
                            <EditTextboxStyle CssClass="LeftMenuEditStyle"></EditTextboxStyle>
                            <FrameStyle CssClass="GridFrameStyle">
                            </FrameStyle>
                            <SelectedRowStyle CssClass="GridSelectedRowStyle"></SelectedRowStyle>
                            <AlternatingRowStyle  CssClass="GridAlternatingRowStyle" OverflowX="hidden" OverflowY="hidden"  CustomRules="text-overflow: ellipsis; overflow-x: hidden"></AlternatingRowStyle>
                            
                            <RowStyle  Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CssClass="GridRowStyle" Wrap="False" CustomRules="text-overflow: ellipsis; overflow-x: hidden">
                             </RowStyle>
                            <ClientSideEvents OnCellDblClick="ShowProcessView()" OnRowContextMenu="HideContextMenu" />
                            <NewRowStyle CssClass="GridNewRowStyle"></NewRowStyle>
                            <EditFocusCellStyle CssClass="GridEditFocusCellStyle">
                            </EditFocusCellStyle>
                            <TextSettings Language="UseCulture">
                            </TextSettings>
                            <ImageSettings RefreshImage="<%$ ReplaceTemplateExpn:Grid/images/refresh.png%>" MoreDataImage="<%$ ReplaceTemplateExpn:Grid/images/LoadMoreData.png%>"
                                            ExportImage="<%$ ReplaceTemplateExpn:Grid/images/Export.png%>"                                            
                                             />                                 
                        </LayoutSettings>
                        <RootTable GridLineStyle="NotSet" HeaderClickAction="SortSingle" AllowGrouping="Yes" AllowEdit="Yes">
                        </RootTable>
                    </ISWebGrid:WebGrid>
              </div>
        <telerik:RadWindowManager ID="Singleton" Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false"
            runat="server" Behaviors="Close,Move" RenderMode="Classic" VisibleStatusbar="false">
            <Windows>
                <telerik:RadWindow ID="RadWindow1" Height="390px" Width="555px" runat="server" Left="" NavigateUrl="BAMExport.aspx" Top="">
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>
    </form>
    <script>
        document.getElementById("spOverdue").title = "<%=lblDescription1.Text%>";
     </script>
</body>
</html>
