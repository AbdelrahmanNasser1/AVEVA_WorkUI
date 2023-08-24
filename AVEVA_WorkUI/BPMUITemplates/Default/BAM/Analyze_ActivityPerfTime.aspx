<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.Bam.Analyze_ActivityPerfTime" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE HTML>
<html>
<head id="Head1" runat="server">
    <title>Untitled Page</title>
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

            if (rowType == "Record")
            {
                // hide the default context menu
                for (i = 0; i <= 43; i++)
                {
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
function ShowMessagesWithBellyBar(messageToDisplay)
{   
    var bellyBarTitle = "<%=GR.GetString("Partitioning_Error_msge")%>";
    se.ui.messageDialog.showError(bellyBarTitle, messageToDisplay, function () {
        window.close();
    });
}
    </script>
<body>
        <link rel="stylesheet" type="text/css" href="<%:cssPath %>Common/StyleSheet/Global.css" />
        <link rel="stylesheet" type="text/css" href="<%:cssPath%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
        <link rel="stylesheet" type="text/css" href="<%:cssPath%>TelerikAjax/StyleSheet/AWTWindow/Window.css">
      <form id="form1" runat="server" style="height:100%">
         <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
            <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <input type="hidden" id="_pageInstanceIds" name="_pageInstanceIds" runat="server" />   
        <table style="width:100%;border-collapse:separate;border-spacing: 2px;" >
            <tr>
                <td style="height:5%;width:94%" class="subtitle">
                    &nbsp;<%:DisplayString%>
                    <asp:TextBox runat="server" ID="txtGridSize" Style="display:none;" AutoPostBack="true" OnTextChanged="SetSize"></asp:TextBox>
                </td>            
                <td style="height:5%;text-align:right;vertical-align:middle;width:2%;padding-right:10px;">
                     <input type="image" style="cursor: hand; vertical-align: middle;" title="<%=GR.GetString("ec_BAMReports_ExportSettings_Tooltip")%>" src="<%:cssPath %>BAM/images/Export-Settings.png" onclick="OpenBAMExport(); return false;"/>
                 </td>    
            </tr>
        </table>
        
        
        <div style="height:99%">
                    <ISWebGrid:WebGrid ID="WebGrid1" runat="server" Height="100%" Width="100%" HorizontalAlign="NotSet"
                        AllowAutoDataCaching="false" DataCacheStorage="PageCache" 
                        DisableFileSystemChecking="true" EnableWebResources="never">
                        <LayoutSettings AlternatingColors="True" CellPaddingDefault="2" GridLineColor="#afafaf"
                            AlwaysShowHelpButton="False" AllowFilter="Yes" AllowGrouping="Yes" GridLineStyle="Solid"
                            RowHeightDefault="23px" AllowColumnSizing="Yes" Hierarchical="True" GridLines="None"
                            AllowColumnMove="Yes" AllowExport="Yes" AllowSelectColumns="yes" AllowSorting="Yes"
                            FilterBarVisible="False" PagingMode="VirtualLoad" VirtualLoadMode="LargeData"
                            VirtualPageSize="50" RowHeaders="No">
                        <HeaderStyle Overflow="hidden" OverflowX="hidden" OverflowY="hidden" 
                               CssClass="GridHeaderStyle" 
                                CustomRules="border-bottom: #73A1E4 1px solid; -moz-boz-flex: 0" Wrap="False"></HeaderStyle>                                               
                        <FocusCellStyle CssClass="GridFocusCellStyle" BorderStyle="Solid"  BorderWidth="1px"  ></FocusCellStyle>
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
                                <EditTextboxStyle></EditTextboxStyle>
                                <FrameStyle CssClass="GridFrameStyle">
                                </FrameStyle>
                            <SelectedRowStyle CssClass="GridSelectedRowStyle"></SelectedRowStyle>
                                    <AlternatingRowStyle  CssClass="GridAlternatingRowStyle" OverflowX="hidden" OverflowY="hidden"  CustomRules="text-overflow: ellipsis; overflow-x: hidden"></AlternatingRowStyle>
                                     
                                <RowStyle CssClass="GridRowStyle" CustomRules="text-overflow: ellipsis; overflow-x: hidden">
                                 </RowStyle>
                                 <ClientSideEvents  OnRowContextMenu="HideContextMenu"   />  
                                  <NewRowStyle CssClass="GridNewRowStyle">
                                  </NewRowStyle>
                                    <EditFocusCellStyle CssClass="GridEditFocusCellStyle">
                                    </EditFocusCellStyle>
                                    <TextSettings Language="UseCulture">
                                    </TextSettings> 
                            <ImageSettings RefreshImage="<%$ ReplaceTemplateExpn:Grid/images/refresh.png%>" MoreDataImage="<%$ ReplaceTemplateExpn:Grid/images/LoadMoreData.png%>"
                                            ExportImage="<%$ ReplaceTemplateExpn:Grid/images/Export.png%>"                                            
                                             />                                  
                            </LayoutSettings>
                        <roottable gridlinestyle="NotSet" headerclickaction="SortSingle" allowgrouping="Yes" ColumnFooters="No"  > 
                        </roottable>
                    </ISWebGrid:WebGrid>
               </div>
        <input type="hidden" id="_SelectedTreeNodeId" name="_SelectedTreeNodeId"  />        
        <telerik:RadWindowManager ID="Singleton" Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false"
         runat="server" Behaviors="Close,Move" RenderMode="Classic" VisibleStatusbar="false"> 
            <Windows>
                <telerik:RadWindow ID="RadWindow1" Height="390px" Width="555px" runat="server" Left="" NavigateUrl="BAMExport.aspx" Top="" >
                </telerik:RadWindow>
            </Windows>
       </telerik:RadWindowManager>   
    </form>
</body>
</html>


