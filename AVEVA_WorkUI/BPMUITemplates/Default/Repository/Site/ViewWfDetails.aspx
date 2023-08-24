<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.ViewWFDetails" %>
<%@ Register Assembly="Workflow.NET.NET2" Namespace="Workflow.NET.Ajax" TagPrefix="cc1" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>
<!DOCTYPE html>
<html >

<head id="Head1" runat="server">
    <title> </title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <style type="text/css">
        html,body,form{height:100%;}
    </style>
</head>
    
<body style="overflow:hidden;margin:0;padding:10px 10px 0px 10px;" >
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
    
<script language="javascript">
    var urlparams = "<%=urlParams%>";
    
    function OpenExnView(exnID, appName, userId) {

        var isChromeBrowser = window.navigator.userAgent.toLowerCase().indexOf('chrome') > -1;

        var IsIEElevenBrowser = false;
        //check if broser is IE11 
        if (isIE11()) {
            IsIEElevenBrowser = true;
        }
   var w,h;
   if (document.all || document.layers || isChromeBrowser || IsIEElevenBrowser) {
        w = screen.availWidth; 
        h = screen.availHeight;   
   }
    
   var winHeight = (h* 80/100);
   var winWidth  = (w* 60/100); 
    
   var winLeft = (w-winWidth)/2;
   var winTop  = (h-winHeight)/2;               

   window.open("../../Repository/Site/ExecutionView.aspx?eId="+exnID+"&app="+appName+"&uid="+userId,"","left="+winLeft+",top="+winTop+",width="+winWidth+",height="+winHeight+",resizable=1,scrollbars=1");

   
}


function Refresh()
{
    window.location.reload(true);    
}

function OpenCancelAWFPage(workflowName, executionId, userId)
{

    var w, h;

    var isChromeBrowser = window.navigator.userAgent.toLowerCase().indexOf('chrome') > -1;

    var IsIEElevenBrowser = false;
    //check if broser is IE11 
    if (isIE11())
    {
        IsIEElevenBrowser = true;
    }
    if (document.all || document.layers || isChromeBrowser || IsIEElevenBrowser)
    {
        w = screen.availWidth;
        h = screen.availHeight;
    }

    winHeight = (h * 30 / 100);
    winWidth = (w * 60 / 100);
    var oManager;

    try
    {
        oManager = parent.parent.GetRadWindowManager();
    }
    catch (err)
    {
        oManager = parent.GetRadWindowManager();
    }

    var oWnd = oManager.getWindowByName("ECWindow");
    oWnd.set_title("Cancel Security Approval Workflow");
    oWnd.setSize(400, 190);
    oWnd.setUrl("CancelSecApprovalWF.aspx?workflowName=" + workflowName + "&executionId=" + executionId + "&uid=" + userId + "&" + urlparams);
    oWnd.hide();
}

function isIE11() {
    return !!navigator.userAgent.match(/Trident.*rv[ :]*11\./);
}

</script>
<script language='JavaScript' src="<%=templateDirectory%>Scripts/menuversion.js"></script>
<link rel="stylesheet" type="text/css" href="<%=csspath%>Common/StyleSheet/Global.css"/>
            <div style="height:100%">
            <ISWebGrid:WebGrid ID="WebGrid1" runat="server" HorizontalAlign="NotSet" Width="100%" Height="95%"
                        OnInitializeDataSource="WebGrid1_InitializeDataSource" OnInitializeLayout="WebGrid1_InitializeLayout" OnInitializeRow="WebGrid1_InitializeRow" AllowAutoDataCaching="false" DisableFileSystemChecking="true" EnableWebResources="never">
                        
                         <LayoutSettings AllowFilter="yes" filterbarvisible="false" RowHeaders="No"
                                       AlternatingColors="true"                                                  
                                       GridLineStyle="Solid" 
                                       GridLineColor="#afafaf" 
                                       CellPaddingDefault="2" 
                                       RowHeightDefault="22px" 
                                       GridLines="None" 
                                       StatusBarVisible="True" 
                                       NewRowLostFocusAction="AlwaysPrompt" 
                                       RowLostFocusAction="AlwaysPrompt"
                                       PagingMode="VirtualLoad"  VirtualPageSize="50"
                                       PromptBeforeDelete="true"  AutoHeight=false                                                 
                                       AutoFitColumns="True" ShowRefreshButton="true" AllowExport="Yes" AlwaysShowHelpButton="false" AllowSorting="yes" AllowColumnSizing="Yes">                                                                                         
                                                           <HeaderStyle Wrap="false" Height="20px" Overflow="hidden" OverflowX="hidden" OverflowY="hidden"
                                                    CssClass="GridHeaderStyle"></HeaderStyle>

                                    <FocusCellStyle CssClass="GridFocusCellStyle"></FocusCellStyle>
                                    <GroupRowInfoStyle CssClass="GridGroupRowInfoStyle"></GroupRowInfoStyle>
                                    <GroupByBox>
                                        <LabelStyle CssClass="GridLabelStyle"></LabelStyle>
                                    </GroupByBox>
                                    <EditTextboxStyle CssClass="GridEditTextboxStyle"></EditTextboxStyle>
                                    <FrameStyle GradientType="Vertical" CssClass="GridFrameStyle"></FrameStyle>
                                    <SelectedRowStyle CssClass="GridSelectedRowStyle" CustomRules="text-overflow: ellipsis; overflow-x: hidden"></SelectedRowStyle>
                                    <LostFocusRowStyle CssClass="GridLostFocusRowStyle"></LostFocusRowStyle>
                                    <AlternatingRowStyle CssClass="GridAlternatingRowStyle" CustomRules="text-overflow: ellipsis; overflow-x: hidden"/>
                                    <RowStyle CssClass="GridRowStyle" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden"></RowStyle>  
                                    <NewRowStyle CssClass="GridNewRowStyle"></NewRowStyle>
                                    <EditFocusCellStyle CssClass="GridEditFocusCellStyle"></EditFocusCellStyle>
                                    <TextSettings Language="UseCulture"></TextSettings>
                                    <ButtonStyle CssClass="inputbutton" Height="17px" ></ButtonStyle>
                                    <ClientSideEvents OnRowContextMenu="DisableContextMenu" />
                                    <TextSettings Language="UseCulture"></TextSettings>   
                                    <StatusBarStyle CssClass="GridStatusBarStyle">
                                        <Padding Top="2px" Left="2px" Bottom="2px" Right="2px"></Padding>
                                    </StatusBarStyle>
                        </layoutsettings>
                                <RootTable GridLineStyle="NotSet">
                                    <TableHeaderStyle CssClass="GridTableHeaderStyle">
                                        <Padding Bottom="4px" Left="4px" Top="4px" Right="4px"></Padding>
                                    </TableHeaderStyle>
                                </RootTable> 
                        </ISWebGrid:webgrid>      
            </div>              
    </form>
</body>
     <script language="javascript"  type="text/javascript">
      
     function DisableContextMenu(gridId, rowType, rowEl, rowMenu)
     {
         var i;
         var grid = wgGetGridById(gridId);	                 
         if (rowType != "Record") return true;	        
         if(rowType =="Record")
         { 
             // hide the default context menu
             for (i=0;i<=43;i++)
             {                              
                 rowMenu.Items[i].Hide();              
             }                                              
         } 	
     }
     function DoResize() {

         if (isIE11()) {
             document.body.style.paddingLeft = "10px";
             document.body.style.paddingRight = "10px";
             document.body.style.paddingBottom = "10px";
             document.body.style.paddingTop = "0px";
         }

         var WebGrid1 = ISGetObject("WebGrid1");
         window.setTimeout(function () {
             wgDoResize(true, true);
         }, 100);
         return true;
     }
     DoResize();

</script>
</html>
