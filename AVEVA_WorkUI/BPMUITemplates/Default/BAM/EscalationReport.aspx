<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.Bam.EscalationReport" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE HTML>
<html >
<head id="Head1" runat="server">
    <title>Escalation Report</title>
    <style type="text/css">
        html, body
        {
            height:98%;
        }
</style> 
</head>

<script type="text/javascript">
  function ShowProcessView(gridId,tblName,rowIndex,cellIndex,cellEl)
{   
    var grid = wgGetGridById("WebGrid1");
    if (grid.GetSelectedObject() == null)
    {
        se.ui.messageDialog.showError("<%=GR.GetString("SR_BAM_Desc") %>", "<%=GR.GetString("select_row") %>");
        return;
    }
    var row = wgGetGridById("WebGrid1").GetSelectedObject().GetRowElement();  
    var cell = wgGetCellByPosition(row, 0);    
    if(cell==null)
    return;
    var Urls=cell.getAttribute("skreporturl"); 
    if(Urls == null)
    {
        return;
    }       
      //window.open(Urls,'ProcessValue', 'height=500,width=700,resizable=yes,scrollbars=no,status=no');
    OpenBamPopup(Urls, 'Process Execution View', 700, 500);
  }

  //To open the window center of screen
  function OpenBamPopup(pageURL, title, popupWidth, popupHeight) {
      var left = (screen.width / 2) - (popupWidth / 2);
      var top = (screen.height / 2) - (popupHeight / 2);
      var targetPop = window.open(pageURL, title, 'status=no,scrollbars=no, resizable=yes, width=' + popupWidth + ', height=' + popupHeight + ', top=' + top + ', left=' + left);
  }

  function HideContextMenu(gridId, rowType, rowEl, rowMenu, location) {

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
    <form id="form1" runat="server" style="height:100%;">
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <link rel="stylesheet" type="text/css" href="<%:cssPath %>Common/StyleSheet/Global.css" />
        <link rel="stylesheet" type="text/css" href="<%:cssPath%>TelerikAjax/StyleSheet/AWTCalendar/Calendar.AWTCalendar.css">
        <link rel="stylesheet" type="text/css" href="<%:cssPath%>TelerikAjax/StyleSheet/AWTCalendar/Calendar.css">
        <link rel="stylesheet" type="text/css" href="<%:cssPath%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
        <link rel="stylesheet" type="text/css" href="<%:cssPath%>TelerikAjax/StyleSheet/AWTWindow/Window.css">
        <input type="hidden" id="_pageInstanceIds" name="_pageInstanceIds" runat="server" /> 
    
        <table style="width:100%;border-collapse: separate; border-spacing: 2px;height:5%;" class="tablebg">
            <tr>
                <td style="width:50%" class="lefttdbg">
                    <span class="subtitle">
                        <%=DisplayString%>
                        <asp:TextBox runat="server" ID="txtGridSize" Style="display:none;" AutoPostBack="true" OnTextChanged="SetSize"></asp:TextBox>
                    </span>
                    <br />
                    <asp:Label ID="lblDescription" runat="server" Text="Label" CssClass="description"></asp:Label><br />
                    <asp:Label ID="lblDescription1" runat="server" Text="Label" CssClass="description"></asp:Label>
                </td>
                <td class="righttdbg">
                     <table style="border-collapse: separate; border-spacing:2px;width:100%">
                             <tr>
                                <td style="text-align:right">
                                <span class="description"><%=GR.GetString("BAMEscalationReport_From")%> :</span>
                                </td>
                                <td style="text-align:left">
                                  <telerik:RadDatePicker RenderMode="Classic" Width="125px" ID="calanderInputFrom" runat="server"   Skin="AWTCalendar" EnableEmbeddedSkins="false">
                                    <Calendar ID="calanderFrom" runat="server"  Skin="AWTCalendar">
                                    </Calendar>
                                     <DateInput ToolTip="Date input" runat="server"></DateInput>
                                 </telerik:RadDatePicker>
                                </td>
                                <td style="text-align:right">
                                   <span class="description"> <%=GR.GetString("BAMEscalationReport_To")%> :</span>
                                </td>
                                <td style="text-align:left"> 
                                <telerik:RadDatePicker RenderMode="Classic" Width="125px" ID="calanderInputTo" runat="server"   Skin="AWTCalendar" EnableEmbeddedSkins="false">
                                    <Calendar ID="calanderTo" runat="server"  Skin="AWTCalendar">
                                    </Calendar>
                                    <DateInput ToolTip="Date input" runat="server"></DateInput>
                                 </telerik:RadDatePicker>

                                </td>
                                 <td style="height:5%;text-align:right;vertical-align:middle;width:2%;padding-right:10px;">
                                    <input type="image" style="cursor: hand; vertical-align: middle;" title="<%=GR.GetString("ec_BAMReports_ExportSettings_Tooltip")%>" src="<%:cssPath %>BAM/images/Export-Settings.png" onclick="OpenBAMExport(); return false;"/>
                                </td>
                                 <td style="text-align:right">
                                         <asp:Button ID="btnGenerate" runat="server" CssClass="inputbutton"  OnClick="btnGenerate_Click" />  
                                </td>                            
                            </tr>                                             
                        </table>    
                </td>
            </tr>
        </table>        
        
        
        <div style="width:100%;height:90%;">              
            <ISWebGrid:WebGrid ID="WebGrid1" runat="server" Height="100%" Width="100%" HorizontalAlign="NotSet"
                        ScriptDirectory="<%$ ReplaceTemplateExpn:InterSoft/Grid/CommonLibrary/WebGrid/V6_0_7200/ %>"
                        SharedScriptDirectory="<%$ ReplaceTemplateExpn:InterSoft/Grid/CommonLibrary/Shared/ %>"
                        AllowAutoDataCaching="false" OnExport="WebGrid1_Export" DisableFileSystemChecking="true"
                        EnableWebResources="never" WebDesktopScriptDirectory="../InterSoft/Grid/CommonLibrary/WebDesktop/V2_5_2007/">
                        <layoutsettings alternatingcolors="False" cellpaddingdefault="2" gridlinecolor="#afafaf"
                            alwaysshowhelpbutton="False" allowfilter="Yes" allowgrouping="Yes" gridlinestyle="Solid"
                            rowheightdefault="23px" hierarchical="True" scriptdirectory="<%$ ReplaceTemplateExpn:InterSoft/Grid/CommonLibrary/WebGrid/V6_0_7200/ %>"
                            gridlines="Both" allowcolumnmove="Yes" allowexport="Yes" allowselectcolumns="Yes"
                            allowsorting="Yes" filterbarvisible="False" autoheight="True" autowidth="True"
                            pagingmode="VirtualLoad" virtualloadmode="LargeData" virtualpagesize="50" RowHeaders="No">
                             <HeaderStyle Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CssClass="GridHeaderStyle"  CustomRules="border-bottom: #73A1E4 1px solid; -moz-boz-flex: 0" Wrap="False">
                </HeaderStyle>
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
                        <EditTextboxStyle  CssClass="LeftMenuEditStyle"></EditTextboxStyle>                        
                        <FrameStyle CssClass="GridFrameStyle">
                                </FrameStyle>
                        <SelectedRowStyle CssClass="GridSelectedRowStyle"></SelectedRowStyle>
                        <AlternatingRowStyle  CssClass="GridAlternatingRowStyle" OverflowX="hidden" OverflowY="hidden"  CustomRules="text-overflow: ellipsis; overflow-x: hidden"></AlternatingRowStyle>
                          
                        <RowStyle CssClass="GridRowStyle" CustomRules="text-overflow: ellipsis;"
                            Overflow="Hidden" OverflowX="Hidden" OverflowY="Hidden" Wrap="False" />                            
                            <NewRowStyle CssClass="GridNewRowStyle"></NewRowStyle>   
                            <ClientSideEvents OnCellDblClick="ShowProcessView()" OnRowContextMenu="HideContextMenu"  />                           
                            <EditFocusCellStyle CssClass="GridEditFocusCellStyle">
                            </EditFocusCellStyle>
                            <TextSettings Language="UseCulture">
                            </TextSettings>
                             <ImageSettings RefreshImage="<%$ ReplaceTemplateExpn:Grid/images/refresh.png%>" MoreDataImage="<%$ ReplaceTemplateExpn:Grid/images/LoadMoreData.png%>"
                                            ExportImage="<%$ ReplaceTemplateExpn:Grid/images/Export.png%>"                                            
                                             /> 
                    </layoutsettings>
                        <roottable gridlinestyle="NotSet" headerclickaction="SortSingle" allowgrouping="Yes">
                        </roottable>
                    </ISWebGrid:WebGrid>
         </div>
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

