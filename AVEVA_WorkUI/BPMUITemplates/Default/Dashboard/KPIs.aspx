<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.Bam.DashBoard.KPIs" Theme="" StylesheetTheme="" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>
<%@ Register Src="PeriodSlot.ascx" TagName="PeriodSlot" TagPrefix="uc2" %>
<%@ Register Src="ThresholdInput.ascx" TagName="ThresholdInput" TagPrefix="uc1" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ OutputCache Location="None" %>

<html>
<head id="Head1" runat="server"></head>
<script src="../Common/JavaScripts/jquery.min.js"></script>
<script src="../Common/JavaScripts/AutoLogoff.js"></script>
<script type="text/javascript">

    window.onresize = Resize;
    window.onload = Resize;
    function Resize() {
        var divdetails = document.getElementById("divdetails");
        var mainrow = document.getElementById("mainrow");
        // divdetails.style.height = document.body.clientHeight - 82;
    }
    function ShowPackageWindow() {
        if (GetSelectedRows()) {
            var application = '<%= AppName%>';
            var workflowName = '<%= WorkflowName%>';
            var url = "../Package/PackageList.aspx?&mode=BAM Workflow" + "&Name=" + workflowName + "&AppName=" + application + "&SettingsType=KPI";
            var windowparams = "height=320,width=500,resizable=yes,status=no";
            var oWindow = radopen(url, null);
            oWindow.set_modal(true);
            oWindow.set_title("BAM Workflow");
            oWindow.setSize(590, 360);
        }
        else {
            // alert("Select KPI(s) for Packaging");
            se.ui.messageDialog.showError("<%=GR.GetString("KPI(s)")%>", "<%=GR.GetString("BAM_Select_KPI_For_Package")%>");
        }
    }



    function RowSelected(rowObject) {
        var selRow = this.GetCellByColumnUniqueName(rowObject, "Id");
        //here selRow.innerHTML will hold the value for the selected row contact name
    }
    function GetSelectedRows() {
        if (grid.MasterTableView.SelectedRows.length > 0) {

            document.getElementById("hidGuid").value = "";
            for (var i = 0; i < grid.MasterTableView.SelectedRows.length; i++) {
                var curRow = grid.MasterTableView.GetCellByColumnUniqueName(grid.MasterTableView.SelectedRows[i], "Id");
                //  alert(curRow.innerHTML);
                document.getElementById("hidGuid").value += curRow.innerHTML + ",";
                //here curRow.innerHTML will hold the value for the selected rows contact names
            }
            document.getElementById("hidGuid").value = document.getElementById("hidGuid").value.substr(0, document.getElementById("hidGuid").value.lastIndexOf(','));
            //  alert(document.getElementById("hidGuid").value);
            return true;
        }
        else
            return false;
    }
    function GridCreated() {
        grid = this;
    }



    function ShowDataPointFrame(id) {
        var w = 1290;
        var h = 560;
        var ww = document.body.clientWidth;
        var wh = document.body.clientHeight;
        var l = (ww - w) / 2;
        var t = (wh - h) / 2;

        var frameel = document.getElementById("datapointframe");
        frameel.style.left = 18;
        frameel.style.top = t;
        frameel.style.width = w;
        frameel.style.height = h;
        frameel.style.display = "block";

        var loc = window.location.toString();
        loc = loc.replace("KPIs.aspx", "KPI.aspx");
        if (id)
            loc = loc + "&id=" + escape(id);
        frameel.src = loc;

    }

    function CloseDataPointFrameAndRefresh() {
        var frameel = document.getElementById("datapointframe");
        frameel.style.display = "none";
        if (window.navigator.userAgent.indexOf('MSIE') > 0)
            window.location.reload();
        else
            window.location.assign(window.location.toString());

    }


</script>
<style>
    .mainheading {
        font-family: Roboto;
        font-size: 11px;
        font-weight: bold;
    }

    .subheadingtitle {
        font-family: Roboto;
        font-size: 10px;
        font-weight: bold;
    }

    .subheading {
        font-family: Roboto;
        font-size: 10px;
        font-weight: bold;
    }

    .notepaddingleft {
        padding-right: 778px;
    }
</style>
<link rel="stylesheet" type="text/css" href="<%=cssPath%>Common/StyleSheet/Global.css" />
 <link rel="stylesheet" type="text/css" href="<%:cssPath%>TelerikAjax/StyleSheet/AWTGrid/Grid.AWTGrid.css">
<body class="lefttdbg" style="border: none; margin: none; padding: none;" leftmargin="2px" topmargin="2px" rightmargin="2px" bottommargin="2px">

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


            function DisplayErrorMessage(message) {

                se.ui.messageDialog.showAlert("<%=GR.GetString("Security_Rights_comn_Alert_for_list")%>", message);
            }

        </script>
        <link href="<%=cssPath%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" type="text/css" />
        <script>
            function Check() {
                var oManager;
                try {
                    oManager = parent.parent.parent.parent.GetRadWindowManagerForListControl();
                }
                catch (e) { }
                if (oManager == null || oManager == 'undefined') {
                    // If it is list inside another list
                    var oManager;
                    try {
                        oManager = parent.parent.parent.GetRadWindowManagerForListControl();
                    }
                    catch (e) { }
                }
                if (oManager == null || oManager == 'undefined')
                    oManager = parent.parent.GetRadWindowManagerForListControl();
                var oWnd = oManager.getWindowByName("WindowCloseBehaviour");
                oWnd.close();
            }

        </script>
        <input type="hidden" name="hidGuid" id="hidGuid" value="" />

        <table width="97%" height="98%" cellspacing="0" cellpadding="0" border="0" class="lefttdbg">
            <tr>
                <td valign="bottom" height="25">
                    <table border="0" cellspacing="1" cellpadding="2" width="100%" height="25px">
                        <tr>
                            <td align="left" class="subtitle" style="height: 35px;padding-left:17px;padding-top: 13px"><span class="subtitle"><%=GR.GetString("Key Performance Indicators for")%> <%=_BAMConfigurationAdapter.WorkflowName %> <%=GR.GetString("Workflow")%></span>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>


            <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
            <tr id="mainrow">
                <td>
                    <table cellspacing="1" cellpadding="0" border="0" width="97.5%" height="100%" align="center">
                        <tr>
                            <td class="lefttdbg" colspan="2" align="center" height="100%">
                                <table border="0" cellspacing="1" cellpadding="2" width="100%" height="25px" style="table-layout: fixed;">
                                    <tr>
                                        <th align="left"></th>
                                    </tr>
                                </table>
                                <div id="divdetails" style="width: 100%; height: 100%; overflow: auto;">
                                    <telerik:RadGrid ID="RadGrid1" runat="server" AllowAutomaticDeletes="True"  AllowAutomaticInserts="True" ImagesPath="<%$ ReplaceTemplateExpn:TelerikAjax/StyleSheet/AWTGrid/Grid%>"
                                        AllowAutomaticUpdates="True" HorizontalAlign="NotSet" Height="90%" Skin="AWTGrid" EnableEmbeddedSkins="false" RenderMode="Classic">
                                        <clientsettings>
                                        <Selecting AllowRowSelect="True" />
                                         <Scrolling AllowScroll="True"/>
                                       </clientsettings>
                                        <mastertableview autogeneratecolumns="false">
                                        <EditFormSettings>
                                            <EditColumn  UniqueName="EditCommandColumn">
                                            </EditColumn>
                                        </EditFormSettings>
                                        <Columns>
                                            <telerik:GridHyperLinkColumn DataTextField="Name" HeaderText="KPI Name" DataNavigateUrlFields="Id" DataNavigateUrlFormatString="javascript:ShowDataPointFrame('{0}')" ><ItemStyle Width="600px" /></telerik:GridHyperLinkColumn>
                                            <telerik:GridBoundColumn DataField="Id" HeaderText="ID" UniqueName="Id" Display="false">
                                            </telerik:GridBoundColumn>
                                        </Columns>
                                        <ExpandCollapseColumn ButtonType="ImageButton" UniqueName="ExpandColumn" Visible="False">
                                            <HeaderStyle Width="19px" />
                                        </ExpandCollapseColumn>
                                        <RowIndicatorColumn UniqueName="RowIndicator" Visible="False">
                                            <HeaderStyle Width="20px" />
                                        </RowIndicatorColumn>
                                    </mastertableview>
                                        <selecteditemstyle backcolor="DarkOrange" forecolor="White" />
                                        <filtermenu hoverbackcolor="LightSteelBlue" hoverbordercolor="Navy" notselectedimageurl="NotSelectedMenu.gif"
                                            selectcolumnbackcolor="Control" selectedimageurl="SelectedMenu.gif"
                                            textcolumnbackcolor="Window"></filtermenu>
                                    </telerik:RadGrid>
                                    <script type="text/javascript">
                                        function OpenRow(index) {
                                            var row = this.Rows[index];
                                            var id = row.Control.children[1].innerHTML;
                                            ShowDataPointFrame(id);

                                        }
                                    </script>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td height="5"></td>
            </tr>

        </table>
        <div style="bottom: 0; right: 0; position: fixed; padding-right: 60px; padding-bottom: 5px;">
            <span class="note notepaddingleft"><%= GR.GetString("double click on any of the row to edit or delete a KPI")%></span>
            <input type="button" class="inputsecondarybutton" value="<%=GR.GetString("Cancel")%>" name="btncancel"
                onclick="Check();" id="Button3">
            <input type="button" class="inputbutton" value="<%=GR.GetString("New KPI") %>"New" name="btnok" onClick="ShowDataPointFrame();" ID="Button2">
        </div>
        <iframe id="datapointframe" style="position: absolute; display: none; border: solid 1px black;" src="blank.htm"></iframe>
    </form>
</body>
</html>
