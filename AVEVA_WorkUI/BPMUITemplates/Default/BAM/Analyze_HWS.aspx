<%@ Page Language="C#" AutoEventWireup="true"  Inherits="Workflow.NET.CodeBehind.Bam.SkeltaTemplates_Default_BAM_Analyze_HWS" Theme="" StylesheetTheme="" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE HTML>
<html>
<head id="Head1" runat="server">
    <title>Activity Details Page</title>   
    <style type="text/css">
        html, body
        {
            height:98%;
        }
</style>
    <script src="../CommonUXControls/scripts/jquery.min.js"></script>
	<script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
    
</head>

<script type="text/javascript">
function ShowMessagesWithBellyBar(messageToDisplay)
{  
    var bellyBarTitle = "<%=GR.GetString("Partitioning_Error_msge")%>";
    se.ui.messageDialog.showError(bellyBarTitle, messageToDisplay, function () {
        window.close();
    });
}
function  SaveLayout()
{ 
    
   var left = (screen.width / 2) - (340 / 2);
   var top = (screen.height / 2) - (185 / 2);
   var Url = 'SaveLayout.aspx';
   window.open(Url, 'LayoutSaving', 'height=230,width=540,resizable=no,scrollbars=no,status=no,top=' + top + ', left=' + left);
   
}
function ExpandAll()
{
     document.getElementById("IdExpand").click();
}
function CollapseAll()
{
     document.getElementById("IdCollapse").click();
}

function SaveClick()
{
  //  alert("hi");
    document.getElementById("_IdSaveBtn").click();
    var grid = ISGetObject("WebGrid1");
   grid.RefreshAll();
}

function DeleteLayout()
{
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

<body>
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%:cssPath %>CommonUXControls/StyleSheet/se.ui.min.css" /> 
    <link rel="stylesheet" type="text/css" href="<%:cssPath%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
    <link rel="stylesheet" type="text/css" href="<%:cssPath%>TelerikAjax/StyleSheet/AWTWindow/Window.css">
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
    <form id="form1" runat="server" style="height:100%" >
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
     <link rel="stylesheet" type="text/css" href="<%:cssPath %>Common/StyleSheet/Global.css" />
     <input type="hidden" id="_pageInstanceIds" name="_pageInstanceIds" runat="server" />   
     <table style="width:100%;border-collapse: separate; border-spacing: 2px;height:5%;">
                        <tr>
                            
                            <td style="height:5%;width:92%" class="subtitle">
                              <%:DisplayString%>   
                                <asp:TextBox runat="server" ID="txtGridSize" Style="display:none;" AutoPostBack="true" OnTextChanged="SetSize"></asp:TextBox>                       
                             </td>   
                             
                            <td style="height:5%;width:2%;vertical-align:middle;">
                                <img src=" <%= cssPath %>BAM/images/expand.gif" style="cursor:hand;vertical-align:middle;"  onclick="ExpandAll()" title="<%=_ExpandAllToolTip%>"  />                             
                                <asp:Button ID="IdExpand" runat=server Text="Expand all Row" style="display:none"  OnClick="IdExpand_Click" />
                             </td>
                             
                             <td style="height:5%;text-align:right;vertical-align:middle;width:2%;">                             
                                 <img src="<%:cssPath %>BAM/images/collapse.gif" style="cursor: hand;vertical-align:middle" onclick="CollapseAll()"
                                title="<%=_CollapseAllToolTip%>"  />
                                <asp:Button ID="IdCollapse" runat=server Text="Collapse all Row" style="display:none"  OnClick="IdCollapse_Click" />
                             </td>   
                             
                              <%if (Request.QueryString["IR"] == null) { if (_IsShowDelete)
                                    { %>
                                 <td style="height:5%;text-align:right;vertical-align:middle;width:2%;padding-right:10px;">
                                 <img src="<%:cssPath %>BAM/images/delete_bam.gif" style="cursor: hand;vertical-align:middle;"
                                    onclick="DeleteLayout()" title="<%=_DeleteToolTip%>"  />                            
                                 <asp:Button ID="DeleteLayout_Button" runat=server Text="DeleteLayout" style="display:none"  OnClick="DeleteLayout_Click" /> 
                                 </td>                         
                             <%}
                                    else
                                    { %>                          
                                 <td style="text-align:right;vertical-align:middle;width:2%;height:5%;padding-right:10px;">
                                  <img src="<%:cssPath %>BAM/images/save-layout.gif" style="cursor: hand;vertical-align:middle"
                                    onclick="SaveLayout()" title="<%=_ImageToolTip%>"  />                            
                                 <input type=hidden id="SaveLayOutId" name="SaveLayOut" />
                                 <asp:Button  OnClick="_IdSaveBtn_Click"  style="display:none"   CssClass="inputbutton" Text="Save Layout"   runat=server ID="_IdSaveBtn" />     
                                 <input type=hidden id="guidVal" name="guidVal" />
                                </td>
                             <%} } %>    
                            <td style="height:5%;text-align:right;vertical-align:middle;width:2%;padding-right:10px;">
                                <input type="image" style="cursor: hand; vertical-align: middle;" title="<%=GR.GetString("ec_BAMReports_ExportSettings_Tooltip")%>" src="<%:cssPath %>BAM/images/Export-Settings.png" onclick="OpenBAMExport(); return false;"/>
                            </td>                       
                        </tr>
                        </table>
                        
        <div style="width:100%;height:98%;">
                 
            <ISWebGrid:WebGrid ID="WebGrid1" runat="server" Height="100%" HorizontalAlign="NotSet" AllowAutoDataCaching="false" DataCacheStorage="PageCache" OnPrepareExportExecute="WebGrid1_PrepareExportExecute"
                Width="99.8%" DisableFileSystemChecking="true" EnableWebResources="never">
                <LayoutSettings AlternatingColors="True" CellPaddingDefault="2" GridLineColor="#afafaf" AlwaysShowHelpButton="False" AllowFilter="Yes"
                    GridLineStyle="Solid" RowHeightDefault="23px" AllowGrouping="Yes" AllowColumnSizing="Yes" Hierarchical="True" GridLines="None" AllowColumnMove="Yes" AllowExport="Yes" AllowSelectColumns="Yes"
                    AllowSorting="Yes" FilterBarVisible="False" PagingMode="VirtualLoad"
                    VirtualLoadMode="LargeData" VirtualPageSize="50" RowHeaders="No">
                    <HeaderStyle Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CssClass="GridHeaderStyle" Wrap="False"></HeaderStyle>
                    <FocusCellStyle CssClass="GridFocusCellStyle" />
                   
                    <GroupRowInfoStyle CssClass="GridGroupRowInfoStyle"></GroupRowInfoStyle>
                    <GroupByBox>
                        <LabelStyle CssClass="LeftMenuLabelStyle"></LabelStyle>
                        <Style CssClass="TableGray"></Style>
                    </GroupByBox>
                    <EditTextboxStyle CssClass="LeftMenuEditStyle"></EditTextboxStyle>
                    <FrameStyle CssClass="GridFrameStyle">
                    </FrameStyle>
                    <SelectedRowStyle CssClass="GridSelectedRowStyle"></SelectedRowStyle>
                    <AlternatingRowStyle CssClass="GridAlternatingRowStyle" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden"></AlternatingRowStyle>
                    <StatusBarStyle CssClass="GridStatusBarStyle">
                                             <Padding Top="2px" Left="2px" Bottom="2px" Right="2px"></Padding>
                    </StatusBarStyle>
                    <StatusBarCommandStyle Active-CssClass="GridStatusBarStyle" Normal-CssClass="GridStatusBarStyle" Over-CssClass="GridStatusBarStyle">
                     </StatusBarCommandStyle>
                    <RowStyle CssClass="GridRowStyle" CustomRules="text-overflow: ellipsis;"
                        Overflow="Hidden" OverflowX="Hidden" OverflowY="Hidden" Wrap="False" />
                    <NewRowStyle CssClass="GridNewRowStyle"></NewRowStyle>
                    <EditFocusCellStyle CssClass="GridEditFocusCellStyle">
                    </EditFocusCellStyle>
                    <TextSettings Language="UseCulture">
                    </TextSettings>
                    <ClientSideEvents OnRowContextMenu="HideContextMenu" />
                    <ImageSettings RefreshImage="<%$ ReplaceTemplateExpn:Grid/images/refresh.png%>" MoreDataImage="<%$ ReplaceTemplateExpn:Grid/images/LoadMoreData.png%>"
                                            ExportImage="<%$ ReplaceTemplateExpn:Grid/images/Export.png%>"                                            
                                             />
                </LayoutSettings>
                <RootTable GridLineStyle="NotSet" HeaderClickAction="SortSingle">
                </RootTable>
            </ISWebGrid:WebGrid> 
        </div>
        <input type="hidden" id="_SelectedTreeNodeId"  name="_SelectedTreeNodeId" />          
        <telerik:RadWindowManager ID="Singleton" Height="400px" Width="555px" Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false"
            runat="server" Behaviors="Close,Move" VisibleStatusbar="false">
            <Windows>
                <telerik:RadWindow ID="RadWindow1" Height="390px" Width="555px" runat="server" Left="" NavigateUrl="BAMExport.aspx" Top="">
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>
    </form>
</body>
</html>
