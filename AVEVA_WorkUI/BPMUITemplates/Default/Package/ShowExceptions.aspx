<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Package.CodeBehind.ShowExceptions"
    Title="Logs Generated While Adding to Package Template" %>

<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>
<!DOCTYPE html>
<html style="height: 100%">

<head id="HEAD1" runat="server">
    <style type="text/css">
        .ieScroll {
            not;
        }
    </style>
    <title>
        <%= resourceManager.GlobalResourceSet.GetString("Error Logs")%></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
</head>

<script type="text/javascript">
    function HidePadColumn(gridId) {

        var grid = ISGetObject(gridId);
        grid.HidePadColumn = true;
    }

    function GetRadWindow() {
        var oWindow = null;
        if (window.frameElement != null)
            oWindow = window.frameElement.radWindow;
        return oWindow;
    }
    function closeWindow() {
        try {
            var oWindow = GetRadWindow();
            oWindow.close();
        }
        catch (e)
        { }
    }
    function ChangeWindowSize() {
        try {
            var oWindow = GetRadWindow();
            oWindow.setSize(820, 380);
        }
        catch (e)
        { }
    }
    function DisableDefaultContextMenuItems(gridId, rowType, rowEl, rowMenu) {

        if (rowType != "Record") {

            if (rowType == "FilterRow") {
                rowMenu.Items.GetNamedItem("mnuHelp").Hide();
            }

            return true;
        }
        var i;
        var grid = wgGetGridById(gridId);
        if (rowType == "Record") {
            // hide the default context menu
            for (i = 0; i <= 43; i++) {
                //rowMenu.Items[i].visible = false;
                rowMenu.Items[i].Hide();

            }

        }
    }
</script>

<body id="Body" style="margin: 0; left: 0; overflow: hidden; height: 100%">
    <form id="Form1" method="post" runat="server" style="height: 100%">
	<%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <link href="<%=themePath%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
        <%if(logCount){ %>
        <table id="pageHeaderTable" width="94%" border="0" align="center" runat="server">
            <tr>
                <td class="pagetitle" colspan="4">
                    <img src="<%=themePath%>/Repository/ListControl/images/icon-package-template.png"
                        alt="" style="vertical-align: middle" />
                    <span class="pagetitle"><%=resourceManager.GlobalResourceSet.GetString("PKG_Exceptions") %></span>
                </td>
                <td class="description" align="right" nowrap="true"></td>
            </tr>
            <tr>
                <td class="description">
                    <%= resourceManager.GlobalResourceSet.GetString("PKG_Exception_Heading")%>
                </td>
            </tr>
            <tr>
                <td class="errormsg" align="center"><%= resourceManager.GlobalResourceSet.GetString("PKG_Exception_HeadingDesc")%></td>
            </tr>
            <tr>
                <td style="height: 10px;"></td>
            </tr>
        </table>
        <%} else { %>
        <table id="Table1" style="width: 94%; border-width: 0; margin: auto" runat="server">
            <tr>
                <td class="pagetitle" colspan="4">
                    <img src="<%=themePath%>/Repository/ListControl/images/icon-package-template.png"
                        alt="" style="vertical-align: middle" />
                    <span class="pagetitle">Exceptions</span>
                </td>
                <td class="description" style="text-align: right; white-space: nowrap">
                    <%:packageTitle%><%:packageVersion%>
                </td>
            </tr>
            <%-- <tr>
            <td class="description">
                
            </td>
        </tr>
        <tr>
            <td style="height: 10px;">
            </td>
        </tr>--%>
        </table>
        <%} %>
        <table id="errorDetailsViewTable" style="border-spacing: 1px; width: 94%; border-width: 0; height: 80%; vertical-align: top; margin: auto" runat="server">
            <tr>
                <td colspan="5" style="height: 5%; text-align: center; padding: 2px">
                    <asp:Label ID="publishMessage" runat="server" Text="" CssClass="successfulmsg"></asp:Label>
                </td>
            </tr>
            <tr style="height: 100%; padding: 2px">
                <td id="LogHeader" class="lefttdbg" runat="server" style="height: 100%; vertical-align: top">
                    <div style="height: 95%; width: 100%;">
                        <ISWebGrid:WebGrid ID="errorDetailsView" TabIndex="-1" runat="server" HorizontalAlign="NotSet"
                            AllowAutoDataCaching="false" Width="100%" Height="100%" DisableFileSystemChecking="true"
                            EnableWebResources="never">
                            <LayoutSettings PagingMode="VirtualLoad" RowHeaders="No" VirtualPageSize="20" AlwaysShowHelpButton="false"
                                AllowExport="Yes" CellClickAction="RowSelect" UseRelativePositioning="true" PersistRowChecker="True" AllowColumnSizing="Yes" AutoFitColumns="true"
                                AllowAddNew="No" AlternatingColors="true" GridLineStyle="Solid" GridLines="None" GridLineColor="#afafaf" AllowSorting="Yes"
                                CellPaddingDefault="2" RowHeightDefault="22px" AllowFilter="yes" FilterBarVisible="false">
                                <HeaderStyle Wrap="false" Height="20px"
                                    CssClass="GridHeaderStyle"></HeaderStyle>

                                <FocusCellStyle CssClass="GridFocusCellStyle"></FocusCellStyle>
                                <GroupRowInfoStyle CssClass="GridGroupRowInfoStyle"></GroupRowInfoStyle>
                                <GroupByBox>
                                    <LabelStyle CssClass="GridLabelStyle"></LabelStyle>
                                </GroupByBox>
                                <EditTextboxStyle CssClass="GridEditTextboxStyle"></EditTextboxStyle>
                                <FrameStyle GradientType="Vertical" CssClass="GridFrameStyle"></FrameStyle>
                                <SelectedRowStyle CssClass="GridSelectedRowStyle"></SelectedRowStyle>
                                <LostFocusRowStyle CssClass="GridLostFocusRowStyle"></LostFocusRowStyle>
                                <AlternatingRowStyle CssClass="GridAlternatingRowStyle" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden" />
                                <RowStyle CssClass="GridRowStyle" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden"></RowStyle>
                                <NewRowStyle CssClass="GridNewRowStyle"></NewRowStyle>
                                <EditFocusCellStyle CssClass="GridEditFocusCellStyle"></EditFocusCellStyle>
                                <TextSettings Language="UseCulture"></TextSettings>
                                <ButtonStyle CssClass="inputbutton"></ButtonStyle>
                                <ClientSideEvents OnAfterInitialize="ResizeGrid" OnInitialize="HidePadColumn" OnButtonClick="LogButtonClickHandler" OnRowContextMenu="DisableDefaultContextMenuItems" />
                                <TextSettings Language="UseCulture"></TextSettings>
                                <StatusBarStyle CssClass="GridStatusBarStyle">
                                    <Padding Top="2px" Left="2px" Bottom="2px" Right="2px"></Padding>
                                </StatusBarStyle>
                            </LayoutSettings>
                            <RootTable GridLineStyle="NotSet">
                            </RootTable>
                        </ISWebGrid:WebGrid>
                    </div>
                </td>
            </tr>
        </table>
        <table id="publishMessageTable" style="width: 94%; margin: auto; border-spacing: 1px; border-width: 0">
            <tr id="buttonRow" runat="server">
                <td style="text-align: right" id="buttonOkColoum" runat="server">
                    <asp:Button ID="btnOk" runat="server" Text="Proceed" CssClass="inputbutton" Visible="false" />
                    <input id="btnClose" runat="server" type="button" onclick="javascript: closeWindow();"
                        class="inputbutton" size="100" />
                </td>
            </tr>
        </table>
    </form>
    <script type="text/javascript">
        (function ReSizeQueueGrid() {
            var Grid1 = ISGetObject("errorDetailsView");
            var tempHeight = screen.availHeight;
            if (!(Grid1 == 'undefined' || Grid1 == null)) {
                tempHeight = tempHeight * 39 / 100 + 'px';
                Grid1.SetHeight(tempHeight);
            }
        }());

    </script>
</body>
</html>
