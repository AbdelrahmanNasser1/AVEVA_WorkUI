<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.SOA.CodeBehind.Repository.SOAAssemblyListAdd" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid"  Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>
<%@ Register Assembly="Skelta.Forms.Web" Namespace="Skelta.Forms.Web" TagPrefix="cc1" %>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>
        <%=GR.GetString("soa_GACAssembly")%>
    </title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
     <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%$ ReplaceTemplateExpn:Common/StyleSheet/Global.css%>" />  
     <link href="<%$ ReplaceTemplateExpn:CommonUXControls/StyleSheet/se.ui.min.css%>"  rel="stylesheet" type="text/css" />  
    

<style type="text/css">

.hiddencol
{
    display:none;
}

html{height:100%;overflow:hidden;}
</style>
</head>
<body style="border: none; margin: 2px; padding: none;height:100% " >
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

         function DisplayMessage() {
             var strHdrMsg = '<%=GR.GetString("soa_AssemblyfromGAC")%>';
             var strMessage = '  <%=GR.GetString("soa_ErrorinLoading")%>';
             se.ui.messageDialog.showError(strHdrMsg, strMessage);
            
         }

        

</script>

    <form id="form1" runat="server" style="height:100%">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <script type="text/javascript">

            function HidePadColumn(gridId) {

                var grid = ISGetObject(gridId);
                //grid.HidePadColumn = true;
                //return true;
                try {
                    grid.GetRootTable().Columns[1].ResizeBestFit();
                } catch (e) { }
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
        </script>
        <div  id="ParentDiv" style="height:100%">
            <asp:Panel ID="Panel1" runat="server" Height="100%">
                <div id="HeaderDiv" style="height:8%">
                      <table style="width:100%;margin:auto;border-width:0">
                        <tr>
                            <td class="pagetitle ">
                                <img src="<%= templateThemeDirectory%>SOA/images/icon-assembly.png" alt="" style="vertical-align:middle" />                              
                                <%=GR.GetString("soa_AssemblyfromGAC")%>
                            </td>
                        </tr>
                        <tr>
                            <td class="description" style="padding-left:19px;">
                                &nbsp;&nbsp;<%=GR.GetString("soa_SelectGacDescription")%>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="BodyDiv" style="height:80%">
                     <table style="width:99%;margin:0px auto;border-width:0;border-style: solid; height:80%" >
                        <tr>
                            <td >
                                <table style="width:99%;margin:auto; border-width:0; height:80%">
                                    
                                    <tr >
                                        <td style="width: 100%;vertical-align:top;height:80%;" id="tdWebgrid">
                                            <ISWebGrid:webgrid id="WebGrid4" runat="server" HorizontalAlign="NotSet" AllowAutoDataCaching="false"
                                                DataCacheStorage="PageCache" height="350px"
                                                width="100%" DisableFileSystemChecking="true" EnableWebResources="never">
                                                <layoutsettings alternatingcolors="True" cellpaddingdefault="2" gridlinestyle="Solid"
                                                gridlinecolor="224, 224, 224" rowheightdefault="22px"  GridLines="None"
                                                autoheight="false" allowsorting="Yes" allowcolumnsizing="Yes" AutoFitColumns="true" 
                                                alwaysshowhelpbutton="false" RowHeaders="No">                                                   
                                                  <HeaderStyle Wrap="false" Height="20px" Overflow="hidden" OverflowX="hidden" OverflowY="hidden"
                                                    CssClass="GridHeaderStyle"></HeaderStyle>
                                                <FocusCellStyle CssClass="GridFocusCellStyle" />
                                                <PreviewRowStyle ForeColor="#0000C0"></PreviewRowStyle>
                                                     <StatusBarCommandStyle Active-CssClass="GridStatusBarStyle" Normal-CssClass="GridStatusBarStyle" Over-CssClass="GridStatusBarStyle">
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
                                                    <Style BackColor="Gray"></Style>
                                                </GroupByBox>                                 
                                                <EditTextboxStyle BorderStyle="None" BorderWidth="0px" Font-Names="Verdana" Font-Size="8pt">
                                                </EditTextboxStyle>
                                                <FrameStyle CssClass="GridFrameStyle"></FrameStyle>
                                                <SelectedRowStyle CssClass="GridSelectedRowStyle" />                                                
                                               <StatusBarStyle CssClass="GridStatusBarStyle">
                                                    <Padding Bottom="2px" Left="2px" Right="2px" Top="2px" />
                                               </StatusBarStyle>
                                                 <RowStyle  Overflow="Hidden" OverflowX="Hidden" OverflowY="Hidden"
                                                    CssClass="GridRowStyle"  CustomRules="text-overflow: ellipsis; overflow-x: hidden" />
                                                <NewRowStyle CssClass="GridNewRowStyle">
                                                </NewRowStyle>
                                               <AlternatingRowStyle CssClass="GridAlternatingRowStyle" />
                                                <TextSettings Language="UseCulture">
                                                </TextSettings>
                                                    <ImageSettings RefreshImage="<%$ ReplaceTemplateExpn:Grid/images/refresh.png%>" />
                                                    <ClientSideEvents OnInitialize="HidePadColumn" OnRowContextMenu="HideContextMenu" />
                                                </layoutsettings>
                                                
                                                <roottable gridlinestyle="NotSet">
                                                   
                                            </roottable>
                                            </ISWebGrid:webgrid>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table> 
                </div>
                <div id="FooterDiv" style="height:8%;padding-top:5px;">
                   <table style="width:100%;border-width:0;margin:auto; height: 100%;padding-top: 28px">
                        <tr>
                            <td style="text-align:right;vertical-align:top;padding-right:17px;">
                                <input type="button" id="btnClose" runat="server" onclick="javascript: closeWindow();" class="inputsecondarybutton" />
                                <asp:Button ID="SaveButton" runat="server" CssClass="inputbutton" OnClick="btnNext_Click"/>
                                </td>
                        </tr>
                    </table>
                </div>
            </asp:Panel>
        </div>
        <input type="hidden" runat="server" id="hidSelectedPath" />
        <input type="hidden" runat="server" id="hidSelectedName" />
        <input type="hidden" runat="server" id="hidSelectedVersion" />
    </form>
</body>
</html>

<script type="text/javascript">
    function GetRadWindow() {
        var oWindow = null;
        oWindow = window.frameElement.radWindow;
        return oWindow;
    }
    function closeWindow() {
        var oWindow = GetRadWindow();
        oWindow.close();
    }
    function ValidateRow() {
        var grid = ISGetObject("WebGrid4");
        var selectedObject = grid.GetSelectedObject();
        if (selectedObject == null) {
            // alert('<%=GR.GetString("soa_selectAssembly")%>');
            se.ui.messageDialog.showError('<%=GR.GetString("soa_AssemblyfromGAC")%>', '<%=GR.GetString("soa_selectAssembly")%>');
            return false;
        } else {
            var row = grid.GetSelectedObject().GetRowObject();
            if (row.Type == "Record") {

                var cell = row.GetCells().GetNamedItem("Path"); //row.GetCell("Path");
                
               // var cellElement = cell.GetElement();
                document.getElementById("hidSelectedPath").value = cell.GetElement().attributes["Path"].value;// cellElement.innerText; 
                cell = row.GetCell("AssemblyName");
                cellElement = cell.GetElement();
                document.getElementById("hidSelectedName").value = cellElement.innerText;
                cell = row.GetCell("Version");
                cellElement = cell.GetElement();
                document.getElementById("hidSelectedVersion").value = cellElement.innerText;
            }
        }
        __doPostBack('SaveButton', '');
    }
    function AddEventHandler(elementObject, eventName, functionObject) {
        if (document.addEventListener)
            elementObject.addEventListener(eventName, functionObject, false);
        else
            if (document.attachEvent)
                elementObject.attachEvent("on" + eventName, functionObject);
    }

    AddEventHandler(window, "resize", resizefunction);
    AddEventHandler(window, "load", resizefunction);

    function resizefunction() {
        var bodydiv = document.getElementById('BodyDiv');
        var headerdiv = document.getElementById('HeaderDiv');
        var footerdiv = document.getElementById('FooterDiv');
        var parentdiv = document.getElementById('ParentDiv');
        if (parentdiv.offsetParent == document.body)
        //   document.body.style.height = '100%';
            var gridObj = ISGetObject("WebGrid4");
            gridObj.SetHeight(window.innerHeight-130+'px');
        var parentdivheight = parentdiv.offsetParent.offsetHeight;
       // parentdiv.style.height = parentdivheight;
       // try { bodydiv.style.height = parentdivheight - headerdiv.offsetHeight - footerdiv.offsetHeight; } catch (e) { } //headerdiv.offsetHeight -
        bodydiv.style.width = '100%';
        bodydiv.style.width = parentdiv.clientWidth;
       //bodydiv.style.overflow = 'auto';
        //parentdiv.style.overflow = 'hidden';
    }

    
</script>

