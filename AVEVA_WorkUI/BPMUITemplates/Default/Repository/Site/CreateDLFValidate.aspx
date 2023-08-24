<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CreateDLFValidate.aspx.cs" Inherits="BPMUITemplates_Default_Repository_Site_CreateDLFValidate" %>

<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>

<!DOCTYPE html>
<html>


<head runat="server">
    <title>Validate List</title>
    <meta http-equiv="content-type" content="Type=text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <style type="text/css">
        html, body, form
        {
            height: 100%;
        }
    </style>
</head>
<body style="overflow-y: hidden; padding: 4px;">
    <script language="javascript" type="text/javascript">

        var ValidationType = "<%=ValidationType%>";
        function closeWindow()
        {
            var oWindow = null;
            if (window.frameElement != null)
                oWindow = window.frameElement.radWindow;
            if (oWindow != null)
                oWindow.close(); // it is a rad window opened form the List   
            //alert(oWindow.BrowserWindow);
            if (ValidationType == "OnListSave")
                oWindow.BrowserWindow.close();
            else if (oWindow == null)
                window.close();
        }

        function OnInitialize(gridId)
        {
            var grid = wgGetGridById(gridId);
            grid.HidePadColumn = true;
        }

    </script>
    <form id="form1" runat="server" style="height: 100%;">
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <link href="<%=themePath%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
        <div style="height: 100%; overflow: auto">
            <table border="0" height="100%" width="100%">
                <tr height="10%">
                    <td width="10%">
                        <table border="0" height="100%" width="100%">
                            <tr>
                                <td width="5%" align="center" valign="top">
                                    <img src="<%=themePath%>Repository/Site/images/error.gif" width="30" height="30" />
                                </td>
                                <td>
                                    <asp:Label ID="lblError" runat="server" Text="Label" CssClass="errormsg"></asp:Label><br>
                                    <br>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr height="80%">
                    <td style="vertical-align: top;">
                        <ISWebGrid:WebGrid ID="WGrdMthdPrv" runat="server" Height="100%" HorizontalAlign="NotSet" Width="100%"
                            OnInitializeDataSource="WGrdMthdPrv_InitializeDataSource" AllowAutoDataCaching="false" DisableFileSystemChecking="true" EnableWebResources="Never">
                            <RootTable GridLineStyle="NotSet" Caption="List">
                            </RootTable>
                            <LayoutSettings AlternatingColors="True" PagingMode="VirtualLoad"
                                VirtualLoadMode="Custom" FilterBarVisible="false" AllowFilter="Yes" GridLineStyle="Solid"
                                GridLineColor="#afafaf" CellPaddingDefault="1" RowHeightDefault="50px" GridLines="None"
                                VirtualPageSize="20" AutoFitColumns="true"
                                AllowSorting="no" AllowColumnSizing="Yes" AlwaysShowHelpButton="false" AllowContextMenu="false" ShowRefreshButton="false" RowHeaders="No">
                                <HeaderStyle CssClass="GridHeaderStyle"></HeaderStyle>
                                <ClientSideEvents OnInitialize="OnInitialize"></ClientSideEvents>
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
                                <GroupRowInfoStyle CssClass="GroupRowInfoStyle"
                                    BackgroundImage="<%$ ReplaceTemplateExpn:hws/Images/ColBk.gif%>"
                                    CustomRules="border-bottom: #73A1E4 1px solid">
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
                                <StatusBarStyle CssClass="GridStatusBarStyle">
                                    <Padding Top="2px" Left="2px" Bottom="2px" Right="2px"></Padding>
                                </StatusBarStyle>
                                <RowStyle CustomRules="text-overflow: ellipsis; overflow-x: hidden" CssClass="GridRowStyle"></RowStyle>
                                <NewRowStyle CssClass="NewRowStyleClass">
                                </NewRowStyle>
                                <AlternatingRowStyle CssClass="GridAlternatingRowStyle" />
                                <TextSettings Language="UseCulture">
                                </TextSettings>
                            </LayoutSettings>
                        </ISWebGrid:WebGrid>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right; padding-right: 10px;">
                        <asp:Button ID="Ok" runat="server" Text="Close" OnClientClick="javascript:closeWindow(false);return false;" CssClass="inputbutton" />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
