<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Package.CodeBehind.MessageDetails" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>
<%@ Register TagPrefix="cc2" Namespace="Workflow.NET.Ajax" Assembly="Workflow.NET.NET2" %>
<!DOCTYPE html>
<html style="height:100%">

<head id="Head1" runat="server">
<title><%= ResourceManager.GlobalResourceSet.GetString("pkg_hstry_message_details_title")%></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <style type="text/css">
         .buttonMarging {
           margin-right:5px;
       }
           tbody > tr[type="Record"] > td[type="Cell"]:first-of-type{
              padding-left:10px !important;
          }
           tbody > tr[type="ColHeader"] > td[type="Column"]:first-of-type{
              padding-left:10px !important;
          }
    </style>
</head>
    <script type="text/javascript">
        function HidePadColumnMessageDetailsGrid(gridId) {

            var grid = ISGetObject(gridId);
            grid.HidePadColumn = true;
        }
        </script>
<body id="Body" style="margin: 0; left: 0; overflow: auto; height: 100%"  onload="resizeWindow();">
		<form id="Form1" method="post" runat="server" style="height:100%">	
            <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
	<link href="<%=ThemePath%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
    	<div style="height:100%">
		 <table id="PageHeaderTable" style="width:98%; border-width:0;margin:auto;" runat="server">
        <tr>
            <td class="pagetitle" style="padding:5px;padding-top:12px;padding-left:0.2%;">
                <div style="height:20px;"><div style="position:absolute;float:left;"><img src="<%=ThemePath%>/Repository/ListControl/images/icon-package-history.png"  alt="" style="vertical-align:middle;"  /></div>
                  <div id="HeadDiv" style="position:absolute;float:left;padding-left:2.8%;" class="pagetitle" ><%= ResourceManager.GlobalResourceSet.GetString("pkg_hstry_message_details_title")%></div>
                     <div class="description" style="float:right;padding-right:2%"> <%=this.ListParameters.CustomQueryParameter%></div>
                </div>
            </td>
        </tr>
        <tr>
            <td class="description" style="text-align:left;padding-left:2.8%;padding-bottom:10px;" id="tdDescription">
                <%=this.ResourceManager.GlobalResourceSet.GetString("pkg_hstry_desc")%></td><td class="description" id="tdProgress" style="padding-left:2.5%;text-align:left;display:none"><%=this.PackageProgressText%><img src="<%=ThemePath%>/Repository/Site/images/windows-preloader.gif"  alt="" style="vertical-align:middle"  />
            </td>
        </tr>
    </table>
                   <div style="height: 80%; width:95%; vertical-align: top;padding-left:2%;margin:0 auto;">                          
                    <ISWebGrid:WebGrid ID="MessageDetailsLogs" TabIndex="-1" runat="server" HorizontalAlign="NotSet"
                        AllowAutoDataCaching="false" Width="98%" Height="100%" DisableFileSystemChecking="true" 
                        EnableWebResources="never" OnInitializeRow="MessageDetailsLogs_InitializeRow">
                        <LayoutSettings AllowFilter="yes" filterbarvisible="false"
                                       GridLineColor="#afafaf" 
                                       CellPaddingDefault="2" 
                                       RowHeightDefault="22px" 
                                       RowHeaders="No"
                                       GridLines="None"
                                       StatusBarVisible="True" 
                                       NewRowLostFocusAction="AlwaysPrompt" 
                                       RowLostFocusAction="AlwaysPrompt"
                                       PagingMode="VirtualLoad"  VirtualPageSize="50"
                                       PromptBeforeDelete="true"                                                    
                                       AutoFitColumns="True" ShowRefreshButton="true" AllowExport="Yes" AlwaysShowHelpButton="false" AllowSorting="yes" AllowColumnSizing="Yes">                                                                                         
                                                       <HeaderStyle Wrap="false" Height="20px" Overflow="hidden" OverflowX="hidden" OverflowY="hidden"
                                                    CssClass="GridHeaderStyle"></HeaderStyle>
                                    <FocusCellStyle CssClass="GridFocusCellStyle"></FocusCellStyle>                                    
                                    <FrameStyle CssClass="GridFrameStyle"></FrameStyle>
                            <AlternatingRowStyle CssClass="GridAlternatingRowStyle" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden"/>
                                    <SelectedRowStyle CssClass="GridSelectedRowStyle"></SelectedRowStyle>
                                    <LostFocusRowStyle CssClass="LostFocusRowStyle"></LostFocusRowStyle>
                                    
                                    <StatusBarStyle CssClass="GridStatusBarStyle">
                                         <Padding Top="0px" Left="0px" Bottom="0px" Right="0px"></Padding>
                </StatusBarStyle>
                <StatusBarCommandStyle Active-CssClass="GridStatusBarStyle" Normal-CssClass="GridStatusBarStyle" Over-CssClass="GridStatusBarStyle">
                 </StatusBarCommandStyle>
                                    <RowStyle CssClass="GridRowStyle" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden"></RowStyle>  
                                    <NewRowStyle CssClass="GridNewRowStyle" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden"></NewRowStyle>
                                    <EditFocusCellStyle CssClass="GridEditFocusCellStyle"></EditFocusCellStyle>
                                    <ClientSideEvents OnAfterResponseProcess="ResizeGridMessageDetailsGrid"  OnInitialize="HidePadColumnMessageDetailsGrid" OnRowContextMenu="DisableDefaultContextMenuItems" />
                                    <TextSettings Language="UseCulture"></TextSettings>
                                    <HyperlinkStyle CssClass="GridHyperlinkStyle"/>
                                </LayoutSettings>
                                <RootTable GridLineStyle="NotSet">
                                </RootTable> 
                    </ISWebGrid:WebGrid>
                                </div>
                                 <table id="Table1"  style="border-spacing:0px; width:93%;border-width:0;margin:auto"> 
                                     <tr><td>&nbsp;</td></tr> 
                                         
            <tr>
                <td style="bottom: 20px; left: 3.1%;position: absolute;">
                    <table>
                        <tr>
                            <td><img src="<%=ThemePath%>Common/Images/icon-errors.png" onclick="Javascript:ShowMessageType('ERROR');" alt=""/></td><td class="description" style="vertical-align:middle"><a class="textlinkblacknormal" onclick="Javascript:ShowMessageType('ERROR');" href="#"><span id="errorCount" class="description" style="vertical-align:top"><%=this.ErrorCount%></span></a>&nbsp;<a class="GridHyperlinkStyle" onclick="Javascript:ShowMessageType('ERROR');" href="#" style="vertical-align:top"><%= ResourceManager.GlobalResourceSet.GetString("pkg_History_Errors")%></a>&nbsp;</td>
                            <td><img src="<%=ThemePath%>Common/Images/icon-warning.png" onclick="Javascript:ShowMessageType('WARNING');" alt=""/></td><td class="description" style="vertical-align:top"><a class="textlinkblacknormal" onclick="Javascript:ShowMessageType('WARNING');" href="#"><span id="warningCount" class="description"><%=this.WarningCount%></span></a>&nbsp;<a class="GridHyperlinkStyle" onclick="Javascript:ShowMessageType('WARNING');" href="#"><%= ResourceManager.GlobalResourceSet.GetString("pkg_History_Warnings")%></a></td>
                            <td><img src="<%=ThemePath%>Common/Images/icon-information.png" onclick="Javascript:ShowMessageType('INFORMATION');" alt=""/></td><td class="description" style="vertical-align:top"> <a class="textlinkblacknormal" onclick="Javascript:ShowMessageType('INFORMATION');" href="#"><span id="informationCount" class="description"><%=this.InformationCount%></span></a>&nbsp;<a class="GridHyperlinkStyle" onclick="Javascript:ShowMessageType('INFORMATION');" href="#"><%= ResourceManager.GlobalResourceSet.GetString("pkg_History_Information")%></a></td>             
                            <td><img src="<%=ThemePath%>Common/Images/icon-all.png" onclick="Javascript:ShowMessageType('ALL');" alt=""/></td><td class="description" style="vertical-align:top"><a class="textlinkblacknormal" onclick="Javascript:ShowMessageType('ALL');" href="#"> <span id="allCount" class="description"><%=this.AllCount%></span></a>&nbsp;<a class="GridHyperlinkStyle" onclick="Javascript:ShowMessageType('ALL');" href="#"><%= ResourceManager.GlobalResourceSet.GetString("RepoProviderSearch_All")%></a></td>             
                        </tr>
                    </table>
                </td></tr></table>
                
              <div style="bottom: 20px; right: 20px;position: absolute;">
                    <input id="ButtonClose" runat="server" type="button" onclick="javascript: closeWindow();"
                        class="inputsecondarybutton buttonMarging" />
                        <%--<asp:Button ID="ButtonClear" runat="server" Visible="false" OnClick="ButtonClear_Click" CssClass="inputbutton" />--%>
                </div>
       <input id="hidMsgType" type="hidden" name="hidMsgType" value="<%: this.MessageType%>">
<%--           <cc2:AjaxPageControl id="AjaxPageControl1" runat="server" style="z-index: 104; left: 440px;
                               position: absolute; top: 88px">
                           </cc2:AjaxPageControl>--%>
    </div>    
    <script type="text/javascript" >
        var closewindowGlobal = "0";
        function GetRadWindow() {
            var oWindow = null;
            if (window.frameElement != null)
                oWindow = window.frameElement.radWindow;
            return oWindow;
        }
        function closeWindow() {
         var oWindow = GetRadWindow();
            oWindow.close();
        }
        var globalMsg = "1"; 
        function resizeWindow() {
            var w = screen.availWidth;
            var h = screen.availHeight;
            var oWindow = GetRadWindow();
            w = w * .9;
            h = h * .8;
            if (window.parent.location.search != null && window.parent.location.search == '?FromArchestrA=true') {
     
            }
            else {
                oWindow.setSize(w, h);
            }
            oWindow.center();
            // if page is getting closed then we should not maximize else it will not close the window
            if (closewindowGlobal == "1") {
            }
            else {
                oWindow.maximize();
            }
            AutoRefesh();
            //RefreshGrid();
        }
        function QueryToSave() {
            this.SimpleQuery = "";
            this.CamlQuery = "";
        }

        function AutoRefesh() {
            //auto refresh
            var querytosave = new QueryToSave();
            querytosave.SimpleQuery = "data";
            window.parent.CallServerSideMethod(null, 'SaveQuery', "DataTableTest", CallbackSaveQueryNew, 'table', querytosave);
        }
        function CallbackSaveQueryNew(context, result, response) {
            if (result == "refresh") {
                document.getElementById('tdProgress').style.display = "block";
                document.getElementById('tdDescription').style.display = "none";
                RefreshGrid();
            }
            else {
                document.getElementById('tdProgress').style.display = "none";
                document.getElementById('tdDescription').style.display = "block";
               
                if (globalMsg == "1") {
                    globalMsg = "2";
                    RefreshGrid();
                    
                    var msg = "<%=this.ConfirmationMessage%>";
                    var tempClicked = document.getElementById('hidMsgType').value;
                    if (msg != "") {
                        var temp1 = result;
                        var temp = temp1[0].split(",");
                        document.getElementById('errorCount').innerHTML = temp[1];
                        document.getElementById('warningCount').innerHTML = temp[2];
                        document.getElementById('informationCount').innerHTML = temp[3];
                        document.getElementById('allCount').innerHTML = temp[4];

                        // do not show the successful message if user clicks on Error or warning link
                        //if (tempClicked == "") {
                        //    alert(msg);
                        //}
                    }
                    }
                else
                {
                    RefreshGridWithoutTimeOut();
                    
                        }
                }
        }    
        function RefreshGrid1() {
            try {                
                var grid = ISGetObject("MessageDetailsLogs");
                grid.RefreshAll(); //do not use Refresh() as it is failing in IE7
                //using timeout to adjust the grid height
                window.setTimeout(AutoRefesh, 3000);
            }
            catch (e) { }
        }
        function ResizeGridMessageDetailsGrid(controlId) {
            try {
                if (navigator.userAgent.indexOf("Firefox") > -1) {
                 
                        var WebGrid1 = ISGetObject(controlId);
                        window.setTimeout(function () { wgDoResize(true, true); }, 100);
                    
                }

            }
            catch (e) { }
        }
        
        function RefreshGrid() {
            try {
                var i = GetMOZBrowserversion();
                if (i == 1) {
                    var grid = ISGetObject("MessageDetailsLogs");
                    grid.Refresh(); //do not use Refresh() as it is failing in IE7 removed RefreshAll as now we are not supporting IE7

                }
                else {
                    var grid2 = ISGetObject("MessageDetailsLogs");
                    
                    //window.location.href = window.location.href;
                    grid2.Refresh(); 
                }
                //window.opener.location.href = window.opener.location.href;

                //using timeout to adjust the grid height
                window.setTimeout(AutoRefesh, 5000);
            }
            catch (e) { }
        }
        function RefreshGridWithoutTimeOut() {
            try {
                var i = GetMOZBrowserversion();
                if (i == 1) {
                    var grid = ISGetObject("MessageDetailsLogs");
                    grid.Refresh(); //do not use Refresh() as it is failing in IE7

                }
                else {
                    var grid2 = ISGetObject("MessageDetailsLogs");
                    //window.location.href = window.location.href;
                    
                    grid2.Refresh();
                }
            }
            catch (e) { }
        }
        function RefreshGridAfterClear() {
            // no need to clear alreay refresh calling from onload event
           
        }
        // If Mozila it should refresh the grids, to avoid Communication error
        function GetMOZBrowserversion() {
            var app = navigator.userAgent;
            
            if (app.indexOf("MSIE") > -1) {
                    return 1;
            }
            else if (app.indexOf("Firefox/1.5") > -1) {
                 return 2;
            }
            else {
                 return 3;
            }
        }
    function DisableDefaultContextMenuItems(gridId, rowType, rowEl, rowMenu) {
            var i;
            var grid = wgGetGridById(gridId);
            if (rowType == "Record") {
                // hide the default context menu
                for (i = 0; i <= 43; i++) {
                    //rowMenu.Items[i].visible = false;
                    rowMenu.Items[i].Hide();

                }
            }
			
if (rowType != "Record") {
        
		if (rowType == "FilterRow") 
        {
            rowMenu.Items.GetNamedItem("mnuHelp").Hide();
        }
		
        return true;
    }
    }

    function ShowMessageType(type) {
        document.getElementById("hidMsgType").value = type;
        window.document.forms[0].submit();
    }

    function setHeight() {
        try
        {
            var Grid2 = ISGetObject("MessageDetailsLogs");
            var winHeight = window.outerHeight;
            var ds = window.innerHeight;

            if (winHeight < 760 & ds < 500)
            {
                Grid2.SetHeight(ds - 120 + 'px'); // 36
            }

            if (winHeight < 760 & ds < 600)
            {
                Grid2.SetHeight(ds - 160 + 'px'); // 36
            }

            if (window.parent.location.search != null && window.parent.location.search == '?FromArchestrA=true' && winHeight < 760)
            {
                Grid2.SetHeight(ds - 190 + 'px');
                document.getElementById("HeadDiv").setAttribute("style", "padding-left:35px;position:absolute;");
            }

            if (winHeight < 760 & ds > 600)
            {
                Grid2.SetHeight(ds - 210 + 'px'); //170
            }

            //ResizeGrid();

            Grid2.Refresh();

        }
        catch (e) { }
    }
    setHeight();
    </script>
    </form>
</body>
</html>
