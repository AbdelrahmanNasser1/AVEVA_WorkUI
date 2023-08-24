<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Forms.Web.CodeBehind.PreviewLookupDataSet" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html>
<html style="height:100%">
<head runat="server">
    <title></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <style>
        html, body, body * {
            box-sizing: border-box;
        }
    </style>
    <script type="text/javascript">

        var isMozilla = false;
        
        function AddEventHandler(elementObject, eventName, functionObject) {
            if (document.addEventListener)
                elementObject.addEventListener(eventName, functionObject, false);
            else
                if (document.attachEvent)
                    elementObject.attachEvent("on" + eventName, functionObject);
        }

        /* Resizing function is not required now everything inside commom table*/
        AddEventHandler(window, "resize", positionLayout);
        //AddEventHandler(window, "load", positionLayout);

        function UpdateRowDetails(gridId, rowType, rowEl, rowMenu) {
            var lblDisp = document.getElementById('lblDisplay');
            var lblVal = document.getElementById('lblValue');
            var idColumn = document.getElementById('HdnLookupValue').value;

            var isMultivalue = false;
            var mapperColumn = null;
            if (idColumn.indexOf(",") > 0) {
                isMultivalue = true;
                mapperColumn = idColumn.split(",");
            }

            var idDisColumn = document.getElementById('HdnLookupDisplay').value;
            var grid = wgGetGridById(gridId);
            var selectedRowObject = grid.GetSelectedObject();
            if (selectedRowObject != null) {
                var row = selectedRowObject.GetRowElement();
                var cells = selectedRowObject.GetRowObject().GetCells();
                for (var i = 0; i < cells.length; i++) {
                    if (cells[i] != null) {
                        if (idDisColumn.toLowerCase() == cells[i].Name.toLowerCase()) {
                            idDisColumn = cells[i].Name;
                            break;
                        }
                    }
                }

                var cellName = wgGetCellByName(row, idDisColumn);
                lblDisp.innerText = cellName.innerText;
                var idValue = cellName.getAttribute("details");
                lblVal.innerText = idValue;
            }
            else {
                alert("Select the record");
                return false;
            }
        }

        function GetRadWindow() {
            var oWindow = null;
            oWindow = window.frameElement.radWindow;
            return oWindow;
        }

        function btnClose_Click() {
            //window.close();
            var oWindow = GetRadWindow();
            oWindow.close();
        }

        function reSetupWindow(isParameterBased) {
            var oWindow1 = GetRadWindow();
            var windowWidth = oWindow1.get_width();
            var windowHeight = oWindow1.get_height();
            var mainPanel = document.getElementById("GridPanel");
            var resultPanel = document.getElementById("LookupResults");
            
            var parentWindow = oWindow1.BrowserWindow.parent;
            var parentWidth = parentWindow.screen.availWidth;
            var parentHeight = parentWindow.screen.availHeight;
            oWindow1.set_modal(true);
            if (isParameterBased == "False") {
                oWindow1.setSize(780,560);
                mainPanel.style.display = "block";
                resultPanel.style.display = "block";
            }
            else {
                oWindow1.setSize(600, 400);
                mainPanel.style.display = "none";
                resultPanel.style.display = "none";
            }

            oWindow1.center();
        }

        function positionLayout() {
            if (window.navigator.userAgent.indexOf("Firefox") > -1) {
                isMozilla = true;
            }

            setHeightAndWidthForMainLayouts();
            setGridPanelLayout();
            setGridPanelHeight()
        }

        function setHeightAndWidthForMainLayouts() {
            var headerDiv = document.getElementById("headerDiv");
            var bodyDiv = document.getElementById("bodyDiv");
            var footerDiv = document.getElementById("footerDiv");

            // Width setting
            headerDiv.style.width = "100%";
            bodyDiv.style.width = "100%";
            footerDiv.style.width = "100%";

            // Overflow setting
            bodyDiv.style.overflowX = 'hidden';
        }

        function setGridPanelHeight() {            
            var oWindow1 = GetRadWindow();
            var windowHeight = oWindow1.get_height();
            var GridParametersPanel = document.getElementById("GridParametersPanel");
            if (GridParametersPanel != null) {
                GridParametersPanel.style.height = (windowHeight - 170) + "px";
                GridParametersPanel.style.width = "100%";
                GridParametersPanel.style.overflow = "hidden";
                GridParametersPanel.style.overflowY = "auto";
            }

            var paramBodyTable = document.getElementById("paramBodyTable");
            if (paramBodyTable != null) {
                paramBodyTable.style.width = "100%";
            }
        }

        function setGridPanelLayout() {
            var GridPanel = document.getElementById("GridPanel");
            if (window.navigator.userAgent.indexOf("Firefox") > -1) {
                isMozilla = true;
            }
            if (isMozilla) {
                GridPanel.style.height = "300px";
                document.getElementById("WebGrid1_f").style.position = "";

            }
            else {
                GridPanel.style.height = "300px";

            }

            GridPanel.style.overflowX = "hidden";
            GridPanel.style.overflowY = "hidden";
        }

        function HidePadColumn(gridId) {

            var grid = ISGetObject(gridId);
            grid.HidePadColumn = true;
        }

        // Function was getting called from the Server side using ClientScript.RegisterStartupScript method, 
        // before the dom gets rendered hence need to use below workaround
        function PerformClientScriptExecutionForRadAjax(callFn) {           
            $(window).one("load", callFn);
        }
    </script>
</head>
<body onload="positionLayout()" style="overflow:hidden;height:100%">
    <form id="form1" runat="server" style="height:100%">
       <telerik:RadScriptManager ID="RadScriptManager1" runat="server" />  
        <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
    <%=System.Web.Helpers.AntiForgery.GetHtml()%>
            </telerik:RadCodeBlock>
        <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
             <link rel="stylesheet" type="text/css" href="<%=CSSPath %>Common/StyleSheet/Global.css" />
             <link rel="stylesheet" type="text/css" href="<%=CSSPath%>SkeltaForms/StyleSheet/skeltaform.css" />
       </telerik:RadScriptBlock>
        <telerik:RadAjaxPanel ID="radAjaxPanel" runat="server" EnableAJAX="false" ScrollBars="None" Height="100%" >
            <div id="headerDiv" style="height:15%;">
                <table style="border-width:0px;width:100%;margin:auto;height:100%">
                    <tr>
                        <td class="pagetitle" style="padding:2px">
                            <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
                            <img src="<%=CSSPath%>Repository/ListControl/images/icons-ribbon/lookupdatabase.png" alt="" style="text-align:left" />
                            <%=PageTitle%>
                                </telerik:RadCodeBlock>
                        </td>
                    </tr>
                    <tr>
                        <td class="description" style="padding:2px">       
                            <telerik:RadCodeBlock ID="RadCodeBlock3" runat="server">
                            <%=PageDescription%>
                                </telerik:RadCodeBlock>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="bodyDiv" style="height:74%;overflow:hidden" >
                <asp:panel id="GridParametersPanel" runat="server" Width="100%">                    
                    <asp:panel id="ParameterPanle" runat="server" Width="100%">                    
                    </asp:panel>
                </asp:panel>
                <telerik:RadCodeBlock ID="RadCodeBlock4" runat="server">
                    
                <asp:panel id="GridPanel" runat="server" Width="100%" style="display:none;">
                    <label id="Label1" class="description" runat="server" style="width:95%">                        
                        <%=ResourceManager.GlobalResourceSet.GetString("lookup_ShowselectedLookupData")%>                          
                    </label>
                    <ISWebGrid:WebGrid ID="WebGrid1" runat="server" HorizontalAlign="NotSet" Height="260px"
                        AllowAutoDataCaching="false" DataCacheStorage="PageCache" OnInitializeDataSource="WebGrid1_InitializeDataSource"
                        OnInitializeLayout="WebGrid1_InitializeLayout" OnPrepareDataBinding="WebGrid1_PrepareDataBinding"
                        OnInitializeRow="WebGrid1_InitializeRow" DisableFileSystemChecking="true" EnableWebResources="never">
                        <LayoutSettings AutoFitColumns="false" AlwaysShowHelpButton="false" PagingMode="VirtualLoad"
                            VirtualLoadMode="LargeData" VirtualPageSize="10" CellClickAction="RowSelect"
                            UseRelativePositioning="True" PersistRowChecker="True" AllowAddNew="No" AlternatingColors="true"
                            GridLineStyle="Solid" GridLineColor="#afafaf" CellPaddingDefault="2" RowHeightDefault="20px"
                            GridLines="None" AutoHeight="False" AutoWidth="False" RowHeaders="No">
                            <HeaderStyle CssClass="GridHeaderStyle" Wrap="false" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden" ></HeaderStyle>
                            <FocusCellStyle CssClass="GridFocusCellStyle"></FocusCellStyle>
                            <StatusBarCommandStyle>
                                <Active BaseStyle="Over" BackColor="RoyalBlue">
                                </Active>
                                <Over BorderStyle="Solid" BorderWidth="1px" BorderColor="#002D96" BackColor="#FBE9B8">
                                </Over>
                                <Normal>
                                    <Padding Top="1px" Left="1px" Bottom="1px" Right="1px"></Padding>
                                </Normal>
                            </StatusBarCommandStyle>
                            <grouprowinfostyle cssclass="gridrowinfostyle" backgroundimage="<%$ replacetemplateexpn:workitemlist/images/grid-title-bg1.png%>"
                                customrules="border-bottom: #73a1e4 1px solid">
                            </grouprowinfostyle>
                            <GroupByBox>
                                <LabelStyle CssClass="LeftMenuLabelStyle"></LabelStyle>
                                        <Style BackColor="#ececec">                                        
                            </Style>
                            </GroupByBox>
                            <EditTextboxStyle CssClass="LeftMenuEditStyle">
                            </EditTextboxStyle>
                            <FrameStyle CssClass="GridFrameStyle">
                            </FrameStyle>
                            <SelectedRowStyle CssClass="GridSelectedRowStyle"></SelectedRowStyle>
                            <StatusBarStyle CssClass="GridStatusBarStyle">
                                <Padding Top="2px" Left="2px" Bottom="2px" Right="2px"></Padding>
                            </StatusBarStyle>
                            <RowStyle CssClass="GridRowStyle" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden"></RowStyle>
                            <NewRowStyle CssClass="GridNewRowStyle">
                            </NewRowStyle>
                            <AlternatingRowStyle CssClass="GridAlternatingRowStyle" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden"></AlternatingRowStyle>
                            <EditFocusCellStyle CssClass="GridEditFocusCellStyle">
                            </EditFocusCellStyle>
                            <ClientSideEvents OnCellDblClick="UpdateRowDetails" OnInitialize="HidePadColumn"/>
                            <TextSettings Language="UseCulture">
                            </TextSettings>
                            <LostFocusRowStyle CssClass="LostFocusRowStyle">
                            </LostFocusRowStyle>
                        </LayoutSettings>
                        <RootTable GridLineStyle="NotSet" TableHeaderVisible="false" Caption="Open Items">
                        <TableHeaderStyle GradientType="Vertical" CssClass="GridTableHeaderStyle">
                            <Padding Bottom="4px" Left="4px" Top="4px" Right="4px"></Padding>
                        </TableHeaderStyle>
                        </RootTable>
                    </ISWebGrid:WebGrid>
                      
                </asp:panel>   

                    </telerik:RadCodeBlock>
                    
                <asp:panel id="LookupResults" runat="server" Height="100px" Width="100%" style="display:none;" >
                    <input type="hidden" id="HdnLookupDisplay" runat="server" name="HdnLookupDisplay" />
                    <input type="hidden" id="HdnLookupValue" runat="server" name="HdnLookupValue" />                    
                    <table style="width:100%;margin:auto;border-width:0px;border-spacing:1px">
                        <tr>                    
                            <td id="Td1" class="lefttdbg" runat="server"  style="height:30px;width:50%">
                                <label id="lblDisplayTitle" class="subtitle" runat="server">
                                    <telerik:RadCodeBlock ID="RadCodeBlock5" runat="server">
                                    <%=ResourceManager.GlobalResourceSet.GetString("lookup_dbDisplay_Text_Value_Title")%>
                                        </telerik:RadCodeBlock>
                                </label>
                            </td>
                            <td class="righttdbg">
                                <label id="lblDisplay" class="subtitle" runat="server">
                            
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td id="Td2" class="lefttdbg" runat="server"  style="height:30px;width:50%">
                                <label id="lblValueTitle" class="subtitle" runat="server">
                                    <telerik:RadCodeBlock ID="RadCodeBlock6" runat="server">
                                    <%=ResourceManager.GlobalResourceSet.GetString("lookup_dbValue_Text_Value_Title")%>
                                        </telerik:RadCodeBlock>
                                </label>
                            </td>
                            <td class="righttdbg">
                                <label id="lblValue" class="subtitle" runat="server">
                            
                                </label>
                            </td>
                        </tr>
                    </table>                            
                </asp:panel>
            </div>
            <div id="footerDiv" style="height:10%;">
                <table id="footerTable" style="width:100%">
                    <tr>
                        <td id="ProceedButtonTD" style="text-align:right" >
                            <input type="button" title="" value="Proceed" id="BtnPreview" onServerClick="PreviewDataSet_Click" class="inputbutton" runat="server" />
                            <input type="button" id="BtnClose" title="" value="Close" runat="server" class="inputsecondarybutton" onclick="btnClose_Click();"/>
                        </td>
                    </tr>
                </table>
            </div>
             </telerik:RadAjaxPanel>
       </form>
</body>
</html>
