<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.Bam.DashBoard.KPIClass" Theme="" StylesheetTheme="" %>
<%@ Register Src="PeriodSlot.ascx" TagName="PeriodSlot" TagPrefix="uc2" %>
<%@ Register Src="ThresholdInput.ascx" TagName="ThresholdInput" TagPrefix="uc1" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ OutputCache Location="None" %>
<html>
<head id="Head1" runat="server"></head>
<style>
    .inputselect {
        width: 246px;
    }

    .nametext {
        left: -15px;
        position: relative;
    }
</style>
<link rel="stylesheet" type="text/css" href="<%=cssPath%>Common/StyleSheet/Global.css" />
<link rel="stylesheet" type="text/css" href="<%=cssPath%>TelerikAjax/StyleSheet/AWTGrid/Grid.AWTGrid.css">

<script>
    function CloseDataPointFrame() {
        parent.CloseDataPointFrameAndRefresh();
    }

</script>
<script src="../Common/JavaScripts/jquery.min.js"></script>
<script src="../Common/JavaScripts/AutoLogoff.js"></script>

<body style="border: none; margin: 0px 0px 0px 7px; padding: 0px; overflow-x: hidden;" leftmargin="2px" rightmargin="2px" bottommargin="2px">

    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <script src="<%=JSPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
        <script>
            se.ui.messageDialog.setGlobalOptions({
                localization: {
                    closeButtonCaption: "<%=GR.GetString("se_ui_messagedialog_close_caption") %>",
                    okButtonCaption: "<%=GR.GetString("se_ui_messagedialog_ok_caption") %>",
                    cancelButtonCaption: "<%=GR.GetString("se_ui_messagedialog_cancel_caption") %>",
                    showDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_showdetails_caption") %>",
                    hideDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_hidedetails_caption") %>"
                }
            });


            function DisplayMessage(message) {

                se.ui.messageDialog.showAlert("<%=GR.GetString("Security_Rights_comn_Alert_for_list")%>", message);
            }
            function DisplayErrorMessage(message) {

                se.ui.messageDialog.showError("<%=GR.GetString("New KPI")%>", message);
            }

        </script>
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        <link href="<%=cssPath%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" type="text/css" />
        <table border="0">
            <tr></tr>
            <tr></tr>
            <tr></tr>
            <tr>
                <td>
                    <span class="description"><%=GR.GetString("Name")%></span> </td>
                <td colspan="2" style="height: 22px">
                    <asp:TextBox ID="KPIName" runat="server" CssClass="inputtext nametext" Width="613px" MaxLength="50" /></td>
            </tr>
            <tr>
                <td>
                    <span class="description"><%=GR.GetString("Data Point(s)")%></span></td>
            </tr>
            <tr>
                <td style="" colspan="2">
                    <div style="height: 110px; overflow-y: auto; overflow-x: hidden; border: 0px;">
                        <telerik:RadGrid ID="KPIDataPointsGrid" runat="server" HorizontalAlign="NotSet" ImagesPath="<%$ ReplaceTemplateExpn:TelerikAjax/StyleSheet/AWTGrid/Grid%>"
                            AllowAutomaticDeletes="True" AllowAutomaticInserts="True" AllowAutomaticUpdates="True"
                            GroupingEnabled="False" Height="100px" DataSourceID="ObjectDataSource1" RenderMode="Classic" Skin="AWTGrid" EnableEmbeddedSkins="false">
                            <MasterTableView DataSourceID="ObjectDataSource1" DataKeyNames="DataPointId" AutoGenerateColumns="False"
                                CommandItemDisplay="Top" EditMode="InPlace">
                                <EditFormSettings>
                                 <EditColumn  UniqueName="EditCommandColumn">
                                  </EditColumn>
                                </EditFormSettings>
                                <CommandItemTemplate>
                                     <asp:LinkButton ID="addNewButton" runat="server" CommandName="InitInsert" Visible='<%# !KPIDataPointsGrid.MasterTableView.IsItemInserted %>'><img style="border:0px" alt="" src="AddRecord.gif" /><%=GR.GetString("Add New") %>
                                     </asp:LinkButton>
                                </CommandItemTemplate>
                                <Columns>
                                    <telerik:GridEditCommandColumn HeaderStyle-Width="20px" ItemStyle-Width="20px" ButtonType="ImageButton" UniqueName="EditCommandColumn" >
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridTemplateColumn UniqueName="KPIDataPoint" HeaderStyle-Width="200px" HeaderText="Data Point">
                                        <ItemTemplate>
                                            <span style="width: 200px; overflow-x: hidden;">
                                                <%# _BCM.Settings.KPIDataPoints[new Guid((string)Eval("DataPointId"))].Name %>
                                            </span>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:DropDownList CssClass="inputselect" Enabled='<%# KPIDataPointsGrid.MasterTableView.IsItemInserted %>' Width="175px" ID="DataPointList" DataSource='<%# _KPI.GetKPIDataPointsMaster() %>'
                                                DataMember="KPIDataPointMaster" DataTextField="KPI Data Point" DataValueField="DataPointId"
                                                SelectedValue='<%# Bind("DataPointId") %>' runat="server">
                                            </asp:DropDownList>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn UniqueName="Threshold" HeaderStyle-Width="125px" ItemStyle-Width="125px" HeaderText="Threshold">
                                        <ItemTemplate>
                                            <%# ((Eval("ThresholdType").ToString().Trim().ToLower() == "notset") ? (GR.GetString("Not Set")) : (Eval("ThresholdValue") + (Eval("ThresholdType").ToString().Trim().ToLower() != "absolutevalue" ? "%" : "")))%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <span style="width: 125px;">
                                                <uc1:ThresholdInput ID="ThresholdInput1" ThresholdType='<%# Bind("ThresholdType") %>'
                                                    ThresholdValue='<%# Bind("ThresholdValue") %>' runat="server" />
                                            </span>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderStyle-Width="20px">
                                        <ItemTemplate>
                                            <asp:LinkButton Width="20px" runat="server" ID="deleteButton" CommandName="Delete" Visible='<%# !KPIDataPointsGrid.MasterTableView.IsItemInserted %>'><img style="border:0px" src="Delete.gif" /></asp:LinkButton>
                                        </ItemTemplate>
                                        <ItemStyle Width="20px" />
                                    </telerik:GridTemplateColumn>
                                </Columns>
                                <ExpandCollapseColumn ButtonType="ImageButton" UniqueName="ExpandColumn" Visible="False">
                                    <HeaderStyle Width="19px" />
                                </ExpandCollapseColumn>
                                <RowIndicatorColumn UniqueName="RowIndicator" Visible="False">
                                    <HeaderStyle Width="20px" />
                                </RowIndicatorColumn>
                                <HeaderStyle CssClass="inputtext" Wrap="True" />
                            </MasterTableView>
                             <FilterMenu HoverBackColor="LightSteelBlue" HoverBorderColor="Navy" 
                                SelectColumnBackColor="Control" 
                                TextColumnBackColor="Window">
                            </FilterMenu>
                            <ClientSettings>
                                <Scrolling AllowScroll="true" ScrollHeight="80" UseStaticHeaders="true" />
                            </ClientSettings>
                        </telerik:RadGrid>
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <span class="descriptionbold"><%=GR.GetString("Slots for Trend Analysis") %></span>
                    <table align="center" border="0" cellpadding="3" cellspacing="1" class="tablebg" style="width: 100%">
                        <tr>
                            <td class="description"><%=GR.GetString("Slot") %></td>
                            <td class="description"><%=GR.GetString("Slot Period") %></td>
                        </tr>

                        <tr>
                            <td class="lefttdbg"><span class="description"><%=GR.GetString("Slot1")+" (<=)" %></span></td>
                            <td class="lefttdbg">
                                <uc2:PeriodSlot ID="PeriodSlot1" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="lefttdbg"><span class="description"><%=GR.GetString("Slot2")+" (> "+GR.GetString("Slot1")+" <= )" %></span></td>
                            <td class="lefttdbg">
                                <uc2:PeriodSlot ID="PeriodSlot2" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="lefttdbg"><span class="description"><%=GR.GetString("Slot3")+" (> "+GR.GetString("Slot2")+" <= )" %></span></td>
                            <td class="lefttdbg">
                                <uc2:PeriodSlot ID="PeriodSlot3" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="lefttdbg"><span class="description"><%=GR.GetString("Slot4")+" (> "+GR.GetString("Slot3")+" <= )" %></span></td>
                            <td class="lefttdbg">
                                <uc2:PeriodSlot ID="PeriodSlot4" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="lefttdbg"><span class="description"><%=GR.GetString("Slot5")+" (> "+GR.GetString("Slot4")+" <= )" %></span></td>
                            <td class="lefttdbg">
                                <uc2:PeriodSlot ID="PeriodSlot5" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="lefttdbg"><span class="description"><%=GR.GetString("Slot6")+" (> "+GR.GetString("Slot5")+" <= )" %></span></td>
                            <td class="lefttdbg">
                                <uc2:PeriodSlot ID="PeriodSlot6" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="lefttdbg"><span class="description"><%=GR.GetString("Slot7")+" (> "+GR.GetString("Slot6")+" <= )" %></span></td>
                            <td class="lefttdbg">
                                <uc2:PeriodSlot ID="PeriodSlot7" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="lefttdbg"><span class="description"><%=GR.GetString("Slot8")+" (> "+GR.GetString("Slot7")+" <= )" %></span></td>
                            <td class="lefttdbg">
                                <uc2:PeriodSlot ID="PeriodSlot8" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="lefttdbg"><span class="description"><%=GR.GetString("Slot9")+" (> "+GR.GetString("Slot8")+" <= )" %></span></td>
                            <td class="lefttdbg">
                                <uc2:PeriodSlot ID="PeriodSlot9" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="lefttdbg"><span class="description"><%=GR.GetString("Slot10")+" (> "+GR.GetString("Slot9")+" <= )" %></span></td>
                            <td class="lefttdbg">
                                <uc2:PeriodSlot ID="PeriodSlot10" runat="server" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="right" colspan="2" style="padding-right: 15px;">
                    <asp:Button ID="DeleteButton" CssClass="inputbutton" runat="server" Text="Delete" />
                    &nbsp;<asp:Button ID="CancelButton"
                        runat="server" Text="Cancel" CssClass="inputsecondarybutton" OnClientClick="CloseDataPointFrame()" />&nbsp;<asp:Button ID="SaveButton" runat="server" CssClass="inputbutton" Text="Save" /></td>
            </tr>
        </table>

        <script>document.getElementById("<%=KPIName.ClientID %>").focus();</script>

        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DataObjectTypeName="Skelta.BAM.Configuration.KPI_DataItem"
            DeleteMethod="Remove" InsertMethod="Insert" SelectMethod="SelectData" TypeName="Skelta.BAM.Configuration.KPI_DataTable"
            UpdateMethod="Update"></asp:ObjectDataSource>
    </form>
</body>
</html>
