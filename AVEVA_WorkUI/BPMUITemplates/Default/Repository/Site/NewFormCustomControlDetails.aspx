<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.NewFormCustomControlDetails" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title></title>
    <style>

        html, body, form
        {
            height: 100%;
        }

    </style>
    <script type="text/javascript" language="javascript">
    
        function RefreshParent() {
            window.opener.RefreshGrid();
            window.close();
        }

        //NOTE: { Goutham Ganesh V }
        //RefreshParent function is defined in skeltaforms.js also.
        //When called on closebutton click its calling skeltaforms.js 
        //RefreshParent function.
        var RefreshAndClose = RefreshParent;
        
        function ShowGACDiv() {
            document.getElementById("FromGAC").style.visibility = "visible";
            document.getElementById("FromGAC").style.display = "block";
            document.getElementById("FromFolder").style.visibility = "hidden";
            document.getElementById("FromFolder").style.display = "none";

        }

        function ShowFolderDiv() {
            document.getElementById("FromFolder").style.visibility = "visible";
            document.getElementById("FromFolder").style.display = "block";
            document.getElementById("FromGAC").style.visibility = "hidden";
            document.getElementById("FromGAC").style.display = "none";
        }

        function UpdateRowDetails(gridId, rowType, rowEl, rowMenu) {
            var vGridId = wgGetGridById(gridId);
            var tbCH = vGridId.Tables["Table1"].GetRow(rowEl).Grid;
            var version = vGridId.Tables["Table1"].GetRow(rowEl).RowElement.childNodes[1].outerText;
            var pkt = vGridId.Tables["Table1"].GetRow(rowEl).RowElement.childNodes[3].outerText;
            var asmname = vGridId.Tables["Table1"].GetRow(rowEl).RowElement.childNodes[0].outerText;
            var cul = vGridId.Tables["Table1"].GetRow(rowEl).RowElement.childNodes[2].outerText;
            if (document.getElementById("hidSelectedAssembly") != undefined)
                document.getElementById("hidSelectedAssembly").value = asmname + ", Version=" + version + ", Culture=" + cul + ", PublicKeyToken=" + pkt;
        }
        
        function FolderNodeClicked(sender, args)
        {
            if (document.getElementById("hidSelectedFolder") != undefined)
            {
                document.getElementById("hidSelectedFolder").value = args.get_node().get_value();
            }
        }
    </script>

    <link rel="stylesheet" type="text/css" href="<%$ ReplaceTemplateExpn:Common/StyleSheet/Global.css%>" />

</head>
<body style="height: 100%; width: 100%; font-size: 9px; border: none; margin: 0px 0px 0px 0px; overflow: hidden"  scroll="no">
     <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=templateThemeDirectory %>CommonUXControls/StyleSheet/se.ui.min.css" />
    <link rel="stylesheet" type="text/css" href="<%=templateThemeDirectory %>TelerikAjax/StyleSheet/AWTTreeView/TreeView.AWTTreeView.css" />
    <form id="form1" runat="server">
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
<script language="javascript" type="text/javascript" src="../../SkeltaForms/javascript/SkeltaForms.js"></script>
    <asp:Panel ID="pnl" runat="server" Height="100%">
        <table style="width:98%;margin:0px auto;height:20px;border-collapse:collapse;border-spacing:0px;">
            <tr>
                <td style="width:100%;text-align:left;" class="subtitle">
                    <%=dllSourceTitle %>
                </td>
            </tr>
            <tr>
                <td class="inputradio" style="width:100%;text-align:center;" >
                    <asp:RadioButtonList ID="rblSourceSelector" runat="server"  RepeatDirection="Horizontal">
                        <asp:ListItem Text="GAC" Value="From GAC" Selected="True" onclick="ShowGACDiv()"></asp:ListItem>
                        <asp:ListItem Text="Folder" Value="From Folder" onclick="ShowFolderDiv()"></asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
        </table>
        <div id="FromGAC" style="height:76%;padding-left:10px;padding-right:10px;">
           
                    <ISWebGrid:WebGrid ID="WebGrid4" runat="server" HorizontalAlign="NotSet" AllowAutoDataCaching="false"
                        DataCacheStorage="PageCache" Height="100%" Width="100%" DisableFileSystemChecking="true"
                        EnableWebResources="never">
                        <LayoutSettings AlternatingColors="True" CellPaddingDefault="2" GridLineStyle="Solid"
                            GridLineColor="224, 224, 224" RowHeightDefault="22px" AutoHeight="false" AllowSorting="Yes"
                            AllowColumnSizing="Yes" AutoFitColumns="true" AlwaysShowHelpButton="false" GridLines="None" RowHeaders="No">
                            <HeaderStyle Wrap="false" Height="20px" Overflow="hidden" OverflowX="hidden" OverflowY="hidden"
                                CssClass="GridHeaderStyle"></HeaderStyle>
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
                                <Style BackColor="Gray">
                                    </Style>
                            </GroupByBox>
                            <EditTextboxStyle BorderStyle="None" BorderWidth="0px" Font-Names="Verdana" Font-Size="8pt">
                            </EditTextboxStyle>
                            <FrameStyle CssClass="GridFrameStyle">
                            </FrameStyle>
                            <SelectedRowStyle CssClass="GridSelectedRowStyle" />
                            <StatusBarStyle CssClass="GridStatusBarStyle">
                                <Padding Bottom="2px" Left="2px" Right="2px" Top="2px" />
                            </StatusBarStyle>
                            <RowStyle Overflow="Hidden" OverflowX="Hidden" OverflowY="Hidden" CssClass="GridRowStyle"
                                CustomRules="text-overflow: ellipsis; overflow-x: hidden" />
                            <NewRowStyle CssClass="GridNewRowStyle">
                            </NewRowStyle>

                            <AlternatingRowStyle CssClass="GridAlternatingRowStyle" />
                            <ClientSideEvents OnRowContextMenu="DisableContextMenu" OnCellClick="UpdateRowDetails" />
                            <TextSettings Language="UseCulture">
                            </TextSettings>
                             <ImageSettings RefreshImage="<%$ ReplaceTemplateExpn:Grid/images/refresh.png%>" MoreDataImage="<%$ ReplaceTemplateExpn:Grid/images/LoadMoreData.png%>"
                              ExportImage="<%$ ReplaceTemplateExpn:Grid/images/Export.png%>"         
                                />
                        </LayoutSettings>
                        <RootTable GridLineStyle="NotSet">
                        </RootTable>
                    </ISWebGrid:WebGrid>
                                   
        </div>
        <div id="FromFolder" style="visibility: hidden; display: none;height:80%;">
            <div id="FolderBody" style="height:96%;">
                <table style="width:97.5%;margin:0px auto;height:100%;border:1px solid;"  class="fieldset">
                    <tr>
                        <td  style="height:100%">
                            <table style="width:100%;margin:0px auto;height:100%;">
                                <tr>
                                    <td class="tdTreeView" style="height: 100%; width: 100%;vertical-align:top;">
                                      <telerik:RadTreeView ID="RadTreeFolder" runat="server" EnableViewState="true" Height="100%" Width="400px" EnableEmbeddedSkins="false" Skin="AWTTreeView">
                                       </telerik:RadTreeView>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <input type="hidden" runat="server" id="hidSelectedAssembly" />
        <input type="hidden" runat="server" id="hidSelectedFolder" />
        <table style="width:100%;margin:0px auto;vertical-align: bottom;height:10%">
            <tr>
                <td class="subtitle" style="width: 30%;padding-left:15px;text-align:left;">
                    <%=lastSavedPath %>
                    </td>
                    <td style="width: 65%">
                        <asp:TextBox ID="txtLSAsmName" runat="server" Width="98%" Height="18" CssClass="fieldset"
                            ReadOnly="true"></asp:TextBox>
                    </td>
                
            </tr>
            <tr>
                <td style="text-align:right;" colspan="2">
                    <table style="width:100%;">
                        <tr>
                            <td style="text-align:right;padding-right:10px;">
                                <asp:Button ID="btnClose" runat="server" OnClientClick="RefreshAndClose();return false;" class="inputsecondarybutton"
                                    Text="Close" />
                                <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" class="inputbutton"
                                    Text="Save" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </asp:Panel>
    </form>
</body>
</html>
