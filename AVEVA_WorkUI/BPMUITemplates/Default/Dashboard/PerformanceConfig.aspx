<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.Bam.DashBoard.PerformanceConfig" Theme="" StylesheetTheme="" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ OutputCache Location="None" %>
<html>
<head id="Head1" runat="server">
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
</head>

<script>
     function Resize() {
        var divdetails = document.getElementById("divdetails");
        var mainrow = document.getElementById("mainrow");
      }
    function ShowPackageWindow() {
        if (GetSelectedRows()) {
            var application = '<%= applicationName%>';
            var workflowName = '<%= workFlowName%>';
            var url = "../Package/PackageList.aspx?&mode=BAM Workflow" + "&Name=" + workflowName + "&AppName=" + application + "&SettingsType=performance";
            var windowparams = "height=320,width=500,resizable=yes,status=no";
            var oWindow = radopen(url, null);
            oWindow.set_modal(true);
            oWindow.set_title("BAM Workflow");
            oWindow.setSize(590, 360);
        }
        else {
            se.ui.messageDialog.showError("<%=GR.GetString("BAM_Performance_Title_for_Page")%>", "<%=GR.GetString("BAM_Select_Performance_For_Package")%>");
        }
    }
    function RowSelected(rowObject) {
        var selRow = this.GetCellByColumnUniqueName(rowObject, "Id");
       }
    function GetSelectedRows() {
        if (grid.MasterTableView.SelectedRows.length > 0) {
            document.getElementById("hidGuid").value = "";
            for (var i = 0; i < grid.MasterTableView.SelectedRows.length; i++) {
                var curRow = grid.MasterTableView.GetCellByColumnUniqueName(grid.MasterTableView.SelectedRows[i], "Id");
                 document.getElementById("hidGuid").value += curRow.innerHTML + ",";
               }
            document.getElementById("hidGuid").value = document.getElementById("hidGuid").value.substr(0, document.getElementById("hidGuid").value.lastIndexOf(','));
            return true;
        }
        else
            return false;
    }
    function GridCreated() {
        grid = this;
    }

    function isIE11() {
        return !!navigator.userAgent.match(/Trident.*rv[ :]*11\./);
    }
    function ShowDataPointFrame(id) {
        var w = 900;
        var h = 574;
       
        var ww = document.body.clientWidth;
        var wh = document.body.clientHeight;
        var l = 220;
        var t = (wh - h) / 2;

        var frameel = document.getElementById("datapointframe");
        frameel.style.left = l;
        frameel.style.top = t;
        frameel.style.width = w;
        frameel.style.height = h;
        frameel.style.position = 'absolute';
        frameel.style.overflow = 'auto';
      //  frameel.style.display = "block";
        var loc = window.location.toString();
       loc = loc.replace("PerformanceConfig.aspx", "Conditions.aspx");
        
        if (id)
            loc = loc + "&id=" + escape(id);

         frameel.src = loc;
        //window.parent.location.href = loc;
        frameel.style.visibility = 'visible';
    }

    function CloseDataPointFrameAndRefresh() {
        var frameel = document.getElementById("datapointframe");
        //frameel.style.display = "none";
        frameel.style.visibility = 'hidden';

        if (window.navigator.userAgent.indexOf('MSIE') > 0 || isIE11())
            window.location.reload();
        else {
            window.location.assign(window.location.toString());
        }
    }
    
</script>

<style>
    .mainheading
    {
        font-family: Roboto;
        font-size: 11px;
        font-weight: bold;
    }
    .subheadingtitle
    {
        font-family: Roboto;
        font-size: 10px;
        font-weight: bold;
    }
    .subheading
    {
        font-family: Roboto;
        font-size: 10px;
        font-weight: bold;
    }
      .inputbuttonKPI
    {
    font-size: 14px;
    border: 0px solid #7b9ebd;
    background-color: #666;
    color: #ffffff;
    text-align: center;
    vertical-align: middle;
    height: 32px;
    width: 157px;
    font-family: "Segoe UI", "Tahoma", "Helvetica", "Arial", "sans-serif";
    }
    .notepaddingleft 
    {
        padding-right: 725px;
    }
</style>
<link rel="stylesheet" type="text/css" href="<%=cssPath%>Common/StyleSheet/Global.css" />
<body class="lefttdbg" style="border: none; margin: 0px; padding: 0px;overflow:hidden;padding-right: 60px;">
   
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
         <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
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

                se.ui.messageDialog.showError("<%=GR.GetString("BAM_Performance_Title_for_Page")%>", message);
            }

        </script>
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
        <link href="<%=cssPath%>CommonUXControls/StyleSheet/se.ui.min.css"  rel="stylesheet" type="text/css" />  
        <link rel="stylesheet" type="text/css" href="<%=cssPath%>TelerikAjax/StyleSheet/AWTGrid/Grid.AWTGrid.css">
    <input type="hidden" name="hidGuid" id="hidGuid" value="" />
    
    <table width="100%" height="98%" cellspacing="0" cellpadding="0" border="0" class="lefttdbg">
        <tr>
            <td valign="bottom" 
                style="height: 25px">
                <table border="0" cellspacing="1" cellpadding="2" width="100%" height="25px" style="table-layout: fixed;">
                    <tr>
                        <td align="left" style="height: 35px;padding-left:17px;padding-top: 13px" class="subtitle">
                            <span class="subtitle">
                                <%=GR.GetString("Performance")%></span>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="height: 10px">
            </td>
        </tr>
        <tr id="mainrow">
            <td style="height:98%;">
                <table cellspacing="1" cellpadding="4" border="0" width="98%" height="100%" align="center">
                    <tr>
                        <td class="lefttdbg" colspan="2" align="center" style="height: 100%">
                            <div id="divdetails" style="width: 100%; height: 100%; overflow: auto;">
                                <telerik:RadGrid ID="RadGrid1" runat="server" AllowAutomaticDeletes="True"  AllowAutomaticInserts="True" ImagesPath="<%$ ReplaceTemplateExpn:TelerikAjax/StyleSheet/AWTGrid/Grid%>"
                                        AllowAutomaticUpdates="True" HorizontalAlign="NotSet" Height="99%" Skin="AWTGrid" EnableEmbeddedSkins="false" RenderMode="Classic">
                                   <clientsettings>
                                            <Selecting AllowRowSelect="True" />
                                            <Scrolling AllowScroll="True" />
                                  </clientsettings>
                                <mastertableview AutoGenerateColumns="false">
                                            <EditFormSettings>
                                            <EditColumn UniqueName="EditCommandColumn">
                                            </EditColumn>
                                            </EditFormSettings>
                                            <Columns>
                                <telerik:GridHyperLinkColumn DataTextField="Title" HeaderText="Name" DataNavigateUrlFields="Id" DataNavigateUrlFormatString="javascript:ShowDataPointFrame('{0}')"
                                                    UniqueName="Title">
                                    <ItemStyle Width="600px" />
                                </telerik:GridHyperLinkColumn> 
                                    <telerik:GridBoundColumn DataField="Id" HeaderText="ID" UniqueName="Id" Display="False" Visible="false">
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
                                    function datapointframe_onclick() {

                                    }

                                    function IMG1_onclick() {

                                    }
                                </script>

                            </div>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="height: 10px">
            </td>
        </tr>
        <tr>
            <td >
                <table width="92%"  border="0" cellspacing="0" cellpadding="2">
                    <tr>
                        <td colspan="2" style="height: 2px">
                        </td>
                    </tr>
                    <tr>
                        <td align="right" valign="top">
                           <%-- <span class="description">
                                <%=GR.GetString("BAMPerformance_clickonTypeOfWorktoeditordelete") %></span>
                            <input type="button" class="inputbutton" id="NewTypeOfWork" name="btnok" onclick="ShowDataPointFrame();"
                                size="" runat="server">--%>
                        </td>
                        <td width="10">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
        <div style="bottom: 0;right: 0;position: fixed;padding-right: 77px;">
              <span class="description notepaddingleft">
                                <%=GR.GetString("BAMPerformance_clickonTypeOfWorktoeditordelete") %></span>
            <input type="button" class="inputsecondarybutton" value="<%=GR.GetString("Cancel")%>" name="btncancel"
                   onclick="Check();" id="Button3"/>	
            <input type="button" class="inputbutton" id="NewTypeOfWork" name="btnok" onclick="ShowDataPointFrame();"
                   size="" runat="server"/>
        </div>
    <iframe id="datapointframe" style="position: absolute;visibility:hidden; border: solid 1px black;"
        src="blank.htm" onclick="return datapointframe_onclick()"></iframe>
    </form>
</body>
</html>
