<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="ShowExceptionReports.aspx.cs" Inherits="ShowExceptionReports" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>

<!DOCTYPE html>
<html>

<head runat="server">
    <title></title>
     <style>
        html, body
        {
            height:100%;
        }

    </style>
</head>
<body style="overflow:hidden;padding:2px;">
     <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=themePath %>CommonUXControls/StyleSheet/se.ui.min.css" />      
    <script>
        // Initialize locales for message dialog
        se.ui.messageDialog.setGlobalOptions({
            localization: { // All localization related default can be set
                closeButtonCaption: "<%=skrm.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                okButtonCaption: "<%=skrm.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                cancelButtonCaption: "<%=skrm.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                showDetailsCaption: "<%=skrm.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                hideDetailsCaption: "<%=skrm.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
            }
        });
    </script>
    <form id="form1" runat="server" style="height:100%;">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <script type="text/javascript">

            function InitGrid(gridId) {

                var grid = ISGetObject(gridId);
                grid.HidePadColumn = true;
            }
        </script>
        <link href="<%=themePath%>/Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />

  <%--  <div style="height:100%;">--%>
     <%--   <div id="divHeader" style="width:100%;height:10%">--%>
            <table id="divHeader" style="height:10%;width:100%;border-collapse:collapse;border-spacing:0px;">
                <tr >
                    <td align="left" colspan="4" >
                        <span class="MainHeading">
                            <%=pageHeader %></span>
                    </td>                 
                </tr>
                <tr>
                    <td style="text-align:left;">
                        <input type="checkbox" class="inputcheckbox" id="chkPreviewMode" onclick="ShowPreviewMode(this);" style="vertical-align: middle">
                           <span class="description"> <%=previewCheckBoxTxt%></span>
                         <input type="hidden" runat="server" id="hdnPreviewMode" />
                    </td>
                   
                     <td style="text-align:left;">
                        <input type="checkbox" class="inputcheckbox" id="chkfilter" onclick="StoreFilter(this);" style="vertical-align: middle">
                             <span class="description"><%=allowFilterText%></span>
                         <input type="hidden" runat="server" id="hdnFilter" />                        
                    </td>
                  
                    <td style="text-align:left;">
                        <span class="subtitle">
                            <%=displayApplicationName %>
                            </span> :<span class="description">
                                <%:application %></span>
                    </td>
                    <td style="text-align:left;">
                        <span class="subtitle">
                            <%=displayWorkflowName %></span>:<span class="description"><%:workflow%></span>
                    </td>                          
                </tr>
            </table>
       <%-- </div>--%>
        <%--<div id="divBody" style="height:80%;padding-bottom:5px;padding-top:2px">--%>
            <table style="height:80%;table-layout: fixed;width:100%;margin:0px auto;border-collapse:separate;border-spacing:1px;" >
                <tr style="height:100%;">
                    <td id="tdWebgridId" runat="server" style="width:100%;height:360px;vertical-align:top;" colspan="3">
                        <ISWebGrid:WebGrid ID="WebGrid1" runat="server" Height="100%" Width="100%" HorizontalAlign="NotSet"
                            AllowAutoDataCaching="false" DataCacheStorage="PageCache"
                            OnInitializeDataSource="WebGrid1_InitializeDataSource" OnInitializeLayout="WebGrid1_InitializeLayout"
                            OnPrepareDataBinding="WebGrid1_PrepareDataBinding" DisableFileSystemChecking="true"
                            OnInitializeRow="WebGrid1_InitializeRow" EnableWebResources="never">
                            <LayoutSettings AlwaysShowHelpButton="false" PagingMode="VirtualLoad" VirtualLoadMode="LargeData"
                                VirtualPageSize="20" CellClickAction="RowSelect" UseRelativePositioning="true"
                                AllowFilter="Yes" FilterBarVisible="false" PersistRowChecker="True" AlternatingColors="true"
                                GridLineStyle="Solid" GridLineColor="#afafaf" CellPaddingDefault="2" RowHeightDefault="20px"
                                GridLines="None" AutoFitColumns="true" AllowAddNew="No" AllowColumnMove="Yes" RowHeaders="No">
                                <HeaderStyle Wrap="false" Overflow="hidden" OverflowX="hidden" OverflowY="hidden"
                                    CssClass="GridHeaderStyle" ></HeaderStyle>
                                <FocusCellStyle BorderWidth="1px" BorderStyle="Solid" BorderColor="0, 45, 150"></FocusCellStyle>
                               <StatusBarCommandStyle Active-CssClass="GridStatusBarStyle" Normal-CssClass="GridStatusBarStyle" Over-CssClass="GridStatusBarStyle">
                                </StatusBarCommandStyle>
                                <GroupRowInfoStyle CssClass="GridGroupRowInfoStyle" BackgroundImage="Images/grid-title-bg1.png">
                                </GroupRowInfoStyle>                               
                                <EditTextboxStyle CssClass="LeftMenuEditStyle">
                                </EditTextboxStyle>
                                <FrameStyle GradientType="Vertical" CssClass="GridFrameStyle">
                                </FrameStyle>
                                <SelectedRowStyle CssClass="GridSelectedRowStyle"></SelectedRowStyle>
                                <AlternatingRowStyle CssClass="GridAlternatingRowStyle" OverflowX="hidden" OverflowY="hidden"
                                    CustomRules="text-overflow: ellipsis; overflow-x: hidden"></AlternatingRowStyle>
                                <StatusBarStyle CssClass="GridStatusBarStyle" >
                                    <Padding Top="2px" Left="2px" Bottom="2px" Right="2px"></Padding>
                                </StatusBarStyle>
                                <RowStyle CssClass="GridRowStyle" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden">
                                </RowStyle>
                                <NewRowStyle ForeColor="DarkGray" CssClass="GridNewRowStyle">
                                </NewRowStyle>
                                <EditFocusCellStyle BackColor="#E9CD82">
                                </EditFocusCellStyle>
                                <ClientSideEvents OnInitialize="InitGrid"  OnRowContextMenu="DisableContextMenu" OnCellDblClick="OpenDetailViewWindow"/>
                                <TextSettings Language="UseCulture">
                                </TextSettings>
                                <LostFocusRowStyle CssClass="GridLostFocusRowStyle">
                                </LostFocusRowStyle>
                                <ImageSettings 
                                    RefreshImage="<%$ ReplaceTemplateExpn:Grid/images/refresh.png%>" 
                                    MoreDataImage="<%$ ReplaceTemplateExpn:Grid/images/LoadMoreData.png%>"
                                    ExportImage="<%$ ReplaceTemplateExpn:Grid/images/Export.png%>"                                            
                                 />
                            </LayoutSettings>
                            <RootTable GridLineStyle="NotSet" TableHeaderVisible="false" Caption="Open Items">
                                <TableHeaderStyle GradientType="Vertical" CssClass="GridTableHeaderStyle" ForeColor="#15428B"
                                    BackgroundImage="Images/top-bg-green.png">
                                    <Padding Bottom="4px" Left="4px" Top="4px" Right="4px"></Padding>
                                </TableHeaderStyle>
                            </RootTable>
                        </ISWebGrid:WebGrid>
                    </td>
                </tr>
            </table>
        <%--</div>--%>
        <%--<div id="divFooter" style="height:10%;padding-top:5px;padding-bottom:2px">--%>
        <table id="divFooter" style=" height: 8%; width: 100%;">
            <tr>
                <td style="text-align: left; vertical-align: middle;">
                    <img src="<%=themePath%>Common/images/icon-note.png" alt="" style="border-width: 0" />
                    <span class="note"><%=doubleClickMesg %> </span>
                </td>
                <td style="text-align: right;padding:0px;">                    
                    <asp:Button ID="btnClearAll" runat="server" CssClass="inputsecondarybutton" OnClick="btnClearAll_Click" />
                    <asp:Button ID="btnClear" OnClientClick="javascript:return CheckSelected();" runat="server" CssClass="inputbutton" />                            
                </td>
            </tr>
        </table>
        <%--</div>--%>
    <%--</div>--%>
    </form>
</body>
</html>

<script type="text/javascript" language="javascript">

    var displayFooter = '<%=displayFooter %>';
    var addPadding = '<%=addPadding %>';
    var filterchkbox = document.getElementById('chkfilter');
    var hiddenfiltervalue = document.getElementById('hdnFilter');
    
    var previewChkBox = document.getElementById('chkPreviewMode');
    var hdnPreviewValue = document.getElementById('hdnPreviewMode');
    
    var webGrid = ISGetObject("WebGrid1");
    var getTotal = webGrid.TotalRows;
    webGrid.LayoutSettings.AutoFitColumns = true;
    
    if (previewChkBox.checked) {//show preview3 mode , click on Clear exceptions then check
        hdnPreviewValue.value = true;
    }
    else {
        hdnPreviewValue.value = false;
    }
    //Select the Filter checkbox, Enter the filter, select one exception and clear it, it will clear the exception and filter remains same
    if (filterchkbox.checked) {
        webGrid.LayoutSettings.AllowFilter = "Yes";
        webGrid.LayoutSettings.FilterBarVisible = true;
        hiddenfiltervalue.value = true;
        if (getTotal > 0)//only if any rows are available refresh the grid otherwise, status bar was going up
            webGrid.RefreshAll();//if you grid refresh columns are aligned to left
    }
    else {
        webGrid.LayoutSettings.AllowFilter = "No";
        webGrid.LayoutSettings.FilterBarVisible = false;
        hiddenfiltervalue.value = false;
        try{
        ClearFilters();
        }
        catch(e){};
        if (getTotal > 0)//only if any rows are available refresh the grid otherwise, status bar was going up
            webGrid.RefreshAll();
    }

    
    //alert(hdnPreviewValue.value);  
    
    
    
//    function GetBrowserversion() {        
//        var app = navigator.userAgent;

//        if (app.indexOf("MSIE") > -1) {
//            return 1;
//        }
//        else if (app.indexOf("Firefox/1.5") > -1) {
//            return 2;
//        }
//        else if (app.indexOf("Firefox/") > -1) {
//            return 2;
//        }
//        else {
//            return 4;
//        }
//    }
//    if (GetBrowserversion() >= 2) {
//       // webGrid.Height = "450px";        
//        //webGrid.LayoutSettings.AutoHeight = true
//        //document.getElementById('divBody').style.height = "100";
//    }
    if (displayFooter == "False" || displayFooter == "false") {
        document.getElementById('divFooter').style.display = "none";
    }
    else {
        document.getElementById('divFooter').style.display = ""; //Changed as the row was not expanding to 100% width 
    }
    if (addPadding.toUpperCase() == 'TRUE') {
        document.getElementById('divHeader').style.paddingTop = "25px";
    }
    else {
        document.getElementById('divHeader').style.paddingTop = "10px";
    }
    function DisableContextMenu(gridId, rowType, rowEl, rowMenu) {
        var i;
        var grid = wgGetGridById(gridId);
        if (rowType != "Record") return true;
        if (rowType == "Record") {
            // hide the default context menu
            for (i = 0; i <= 43; i++) {
                rowMenu.Items[i].Hide();
            }
        }
    }

    function OpenDetailViewWindow(gridId, rowType, rowEl, rowMenu) {        
        var left = (screen.width- 600)/2;
        var top = (screen.height-480) / 2;
//        var right = (screen.width / 2) - 25;
        var webGrid = ISGetObject("WebGrid1");
        var selRow = webGrid.GetSelectedObject().GetRowElement();
        var exceptionId = selRow.keyValue;
        var application="<%:application %>";
        var responseurl="application="+escape(application)+"&exceptionId="+escape(exceptionId);
        window.open("ShowExceptionDetailReport.aspx?" + responseurl, "WinShowExceptionDetails", "menubar=no,toolbar=no,status=no,resizable=no,directories=no,height=480,width=600,scrollbars=1,dependent=yes,top="+top+", left="+left);
        //alert(application);
    }
    
    function StoreHiddenValue(checkboxId)
    {      
        
        var hdnVal = document.getElementById('hdnCkvalue');
        hdnVal.value = checkboxId.checked;
        var grid = ISGetObject("WebGrid1");
        grid.Refresh();
    }
    
    function ShowPreviewMode(checkboxid)
    {
        // check if filters are checked. Don't do any operations before unchecking the filters
        
        var filterMode = document.getElementById('chkfilter');
         if(filterMode.checked)
         {
              se.ui.messageDialog.showError("<%=skrm.GlobalResourceSet.GetString("ED_pageHeader") %>", "<%=uncheckFilterMgs %>");
              checkboxid.checked = false;
              return false;
         }
         else
         {
            var hdnValue = document.getElementById('hdnPreviewMode');
            hdnValue.value = checkboxid.checked;
            var grid = ISGetObject("WebGrid1");
            var getTotal = grid.TotalRows;
            if (getTotal > 0)
                grid.Refresh();
            else {
                if (checkboxid.checked) {
                    se.ui.messageDialog.showError("<%=skrm.GlobalResourceSet.GetString("ED_pageHeader") %>", "<%=noRowsAvailable %>");
                    checkboxid.checked = false;
                    return false;
                }
            }
        }
    }
    
    function CheckSelected()
    {
        var grid = ISGetObject("WebGrid1");
        if (getTotal > 0) {
            var checkRows = grid.RootTable.GetCheckedRows();
            if (checkRows == '') {
                se.ui.messageDialog.showError("<%=skrm.GlobalResourceSet.GetString("ED_pageHeader") %>", "<%=checkEmptyMsg %>");
                return false;
            }
        }
        else {
            se.ui.messageDialog.showError("<%=skrm.GlobalResourceSet.GetString("ED_pageHeader") %>", "<%=noRowsAvailable %>");
            return false;
        }
    }

    function StoreFilter(checkBoxId) {
                   
         // check if preview mode is checked. don't do any operations when preview mode is checked.
         var previewMode = document.getElementById('chkPreviewMode');
         if(previewMode.checked)
         {
              se.ui.messageDialog.showError("<%=skrm.GlobalResourceSet.GetString("ED_pageHeader") %>", "<%=uncheckPreviewMsg %>");
              checkBoxId.checked = false;
              return false;
         }
          else {              
            var hdnValue = document.getElementById('hdnFilter');
            hdnValue.value = checkBoxId.checked;
            var grid = ISGetObject("WebGrid1");
            var getTotal = grid.TotalRows;
            ClearFilters();
            if (getTotal > 0)//only if any rows are available refresh the grid otherwise, status bar was going up
                grid.RefreshAll(); //we need refreshAll here otherwise filterbar is not shown in the grid
            else {
                if (checkBoxId.checked) {
                    se.ui.messageDialog.showError("<%=skrm.GlobalResourceSet.GetString("ED_pageHeader") %>", "<%=noRowsAvailable %>");
                    checkBoxId.checked = false;
                    return false;
                }                
            }
           // 

            if (!checkBoxId.checked) {
                grid.LayoutSettings.AutoFitColumns = true;                  
                grid.LayoutSettings.AllowFilter = "No";               
                grid.LayoutSettings.FilterBarVisible = false;
                
            }
            else {
                grid.LayoutSettings.AutoFitColumns = true;  
                grid.LayoutSettings.AllowFilter = "Yes";                
                grid.LayoutSettings.FilterBarVisible = true;
            }
                      
        }
    }

    function ClearFilters() {              
        // retrieves WebGrid's object
        var grid = ISGetObject("WebGrid1");
        try {
            // access WebGrid's RootTable
            var rootTable = grid.RootTable;
            var filterRow = rootTable.GetFilterRow(); // get FilterRow element
            var filterCells = rootTable.ToRowObject(filterRow).GetCells(); // get FilterRow's WebGridCell collection 

            // clear the FilterRow's text
            for (var i = 0; i < filterCells.length; i++) {
                var filterCell = filterCells[i];
                if (filterCell != null)
                    filterCell.SetText("", true);
            }

            // remove all Filter configurations
            while (rootTable.FilteredColumns[0] != null) {
                rootTable.FilteredColumns.RemoveAt(0);
            }
            rootTable.UpdateUI(); // apply changes 
        }
        catch (e) {
        }       
    }

    function RefreshGrid() {
        // retrieves WebGrid's object
        var grid = ISGetObject("WebGrid1");
        grid.refreshAll();
    }

    function isIE11() {
        return !!navigator.userAgent.match(/Trident.*rv[ :]*11\./);
    }

    function ResizeGridNow() {
       if (isIE11()) {
            var grid = ISGetObject("WebGrid1");
             grid.SetHeight(430 + 'px');
        }
    }

    function ResizeGrid() {           
      window.setTimeout(function () { wgDoResize(true, true); }, 600);
      return true;
    }
    ResizeGrid();
</script>
