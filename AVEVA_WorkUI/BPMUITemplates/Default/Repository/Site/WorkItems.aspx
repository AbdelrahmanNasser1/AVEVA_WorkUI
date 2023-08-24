<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.WorkItems" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>
<%@ Register TagPrefix="cc1" Namespace="Workflow.NET.Ajax" Assembly="Workflow.NET.NET2" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE html>
<html style="height:100%">
<head id="Head1" runat="server">
    <title></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script> 
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>  
     <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script>
     
</head>
<script type="text/javascript">
        var menuitems="";
        var WorkItemListPath = '<%=_WorkItemListPath %>';
        var forwardwrkItemHeading = '<%=GetLangSpecText("ec_menu_forward_workitem") %>';
        var killwrkIemMesg = '<%=GetLangSpecText("ConfirmMsg1") %>';
        var removewrkItemMesg = '<%=GetLangSpecText("ConfirmMsg3") %>';
        var forwardWrkIemMesg = '<%=GetLangSpecText("Frd_WorkItems_confirm_Msg_user") %>';
        function OnClientClose()
        {
            try{
             RefreshGrid();
             document.body.scroll = "no";
             document.body.style.overflow = "hidden";
               }
             catch(e){
               }
        }
        
        function LoadMenuItems()
        {
             menuitems = document.getElementById('hdnmenuitems').value;
        }
        
        function ValidateCheckedRows()
        {
           // var atlonerow= document.getElementsByName("SelectAtleastone");

            var grd = ISGetObject('WebGrid1');            
            var checkedRows = grd.RootTable.GetCheckedRows();
            var row=null;
            if(grd.GetSelectedObject()!=null)
                row  = grd.GetSelectedObject().GetRowElement();
            if(checkedRows.length == 0 && row ==null)
            { 
                se.ui.messageDialog.showError('<%=GetLangSpecText("ec_menu_forward_workitem")%>','<%=SelectAtleastoneWI %>');
                return false;
            }
            else if (row != null && row.getAttribute("keyValue") == null && row.type != 'FilterRow')
            {
                se.ui.messageDialog.showError('<%=GetLangSpecText("ec_menu_forward_workitem")%>', '<%=SelectAtleastoneWI %>');

               return false;   
            }
            return true;
        }
        function Abort()
        {
            if(ValidateCheckedRows())
            {

               if(document.getElementById('hdnmenuitems').value.indexOf('Kill')!=-1)
               {

                   KillWorkItem();
               } 
               else
               {
                   se.ui.messageDialog.showAlert('<%=GetLangSpecText("ec_menu_forward_workitem")%>', '<%=NoRightsToAbortWI %>');
                   return false;
               } 
            }
        }
    
    // RA: Remove Work Item
    function RemoveWorkItems()
    {
       
        if (ValidateCheckedRows()) {
            if (document.getElementById('hdnmenuitems').value.indexOf('RemoveWorkItem') != -1) {

                RemoveWorkItem();
            }
            else {
                se.ui.messageDialog.showAlert('<%=GetLangSpecText("ec_menu_forward_workitem")%>', '<%=NoRightsToRemoveWI %>');
                return false;
            }
        }
    }

    function OpenWindow()
    {
           if(ValidateCheckedRows())
           {
                if(document.getElementById('hdnmenuitems').value.indexOf('Forward')!=-1)
                {
                    OpenCWindow();                    
                }
                else
                {
                    se.ui.messageDialog.showError('<%=GetLangSpecText("ec_menu_forward_workitem")%>', '<%=NoRightsToForwardWI %>');
                    return false;
                }
            
           } 
    }
        
        // Ayyub :: Commented from OnRowSelect of WebGrid, because it is not needed now.
        // To make it work, call this function OnRowSelect of WebGrid
        function CheckSelect(gridId, rowType, rowEl, rowMenu,location)
        {
               
           //To hide the menus which is showing for previous row
          // hideCursorMenus();   
       
            //For Ajax Call  -startssss
            var grid = wgGetGridById("WebGrid1");
            if (grid.GetSelectedObject() == null)
            {
              // alert("Please select a row."); 
               se.ui.messageDialog.showError('<%=GetLangSpecText("ec_menu_forward_workitem")%>', '<%=GetLangSpecText("select_row")%>');
                return; 
            }
            var row = wgGetGridById("WebGrid1").GetSelectedObject().GetRowElement();    
            var cell = wgGetCellByName(row, "Subject");                        
            
            if(cell==null)
              return;
             //For getting the Workflowname,Workitemid and Applicationname
             
             var Querystringvalues=cell.getAttribute("details");
             if(Querystringvalues==null) return;
             var QuerystringvaluesArr=Querystringvalues.split(',');    
             
             
             var workItemObj =new WorkItem();
             
            workItemObj.ApplicationName = QuerystringvaluesArr[0];
            workItemObj.WorkFlowName = QuerystringvaluesArr[1];
            workItemObj.WorkItemId = QuerystringvaluesArr[2];
            workItemObj.FormNames=QuerystringvaluesArr[3];  
           
             
            //CallServerSideMethod(null, 'CallforOwnerShipwithURL',"DataTableCondition",CallbackOwnership,'table',workItemObj);       
            CallServerSideMethod(null, 'CallforOwnerShipwithURL',"BuildURLCondition",CallbackOwnership,'table',workItemObj);                       
         
          
        //For Ajax Call -End

   
        }
        
function WorkItem()
{
    this.ApplicationName = "";
    this.WorkFlowName="";
    this.WorkItemId = "";
    this.FormNames="";
        
    
}
var strAccessErrMsg="";

function CallbackOwnership(context, result, response)
{    
   
    if(result !=null && response.Error==false)
    {     
       if(result=="{}" || result=="")
        {
          // alert(strAccessErrMsg);
           se.ui.messageDialog.showError('<%=GetLangSpecText("ec_menu_forward_workitem")%>', strAccessErrMsg);
           return;
        }
        var UrlsJs;
        eval("UrlJs="+result);
        
        var urldetails = UrlJs[UrlJs._DefaultFormName];
        var urlDetailsJs;
        eval("urlDetailsJs="+urldetails);    
        OpenUrl(urlDetailsJs); 
    }
    else
    {      
        // alert(strAccessErrMsg);
        se.ui.messageDialog.showError('<%=GetLangSpecText("ec_menu_forward_workitem")%>', strAccessErrMsg);
        
    }
    
}

function OpenUrl(ourl)
{
    
    var isFunction=false;
    var jsfunc=null;
    if( ourl.jsfunction && ourl.jsfunction != "" )
    {
        jsfunc = eval(ourl.jsfunction);
        if( !jsfunc ) 
        {
           // alert("No function found with name " + ourl.jsfunction);
            var dsMsg = '<%=GetLangSpecText("Frd_workitem_fn_not_found_msg")%>' + " " + ourl.jsfunction;
            se.ui.messageDialog.showError('<%=GetLangSpecText("ec_menu_forward_workitem")%>', dsMsg);
            strAccessErrMsg
            return;    
        }       
        else
        {
            isFunction = true;
        }
    }

    if( ourl.nonweb )
    {
            if( isFunction )
            {
                jsfunc(false,ourl.url,ourl.popf, ourl.popn, ourl.nonweb);
            }
          

    }
    else
    {
        
        if( ourl.pop ) //Open in Popup Window irrespective of Worklist display mode
        {
        
            if( isFunction )
            {
                jsfunc(true,ourl.url,ourl.popf, ourl.popn, ourl.nonweb);
            }
            else
            {
                OpenWorkItemInWindow(ourl.url,ourl.popn, ourl.popf);
            }
        
        }
        else
        {
        
            if( isFunction )
            {
                jsfunc(false,ourl.url,ourl.popf, ourl.popn, ourl.nonweb);
            }
            else
            {
                OpenWorkItemInWindow(ourl.url);
            }
        }
    }    
}

function NativeFormOpen(openInPopup, url, popupFeatures, popupName, isNonWeb )
{
    if( !openInPopup )
        OpenWorkItemInWindow(WorkItemListPath+"WorkItemList/WorkItemDetailView.aspx"+url);
    else
        OpenWorkItemInWindow(WorkItemListPath+"WorkItemList/WorkItemDetailView.aspx"+url,popupName, popupFeatures);
}

function OpenWorkflowStatusViewForm(openInPopup, url, popupFeatures, popupName, isNonWeb )
{
    if( !openInPopup )
        OpenWorkItemInWindow(WorkItemListPath+"WorkItemList/WorkflowStatusView.aspx"+url);
    else
        OpenWorkItemInWindow(WorkItemListPath+"WorkItemList/WorkflowStatusView.aspx"+url,popupName, popupFeatures);
}

 function OpenWorkItemInWindow(url,popupName,popupFeatures)
    {
      mywindow = window.open ( (url), (popupName && popupName != "")?popupName:"WinWorkItem", (popupFeatures && popupFeatures != "")?popupFeatures:"location=0, status=0, scrollbars=0, width=710, height=500,left=160,top=140, resizable=yes" );      
      
      return false;
     }
     
    function RefreshGridfromdetwindow()
    {  
        var grid = ISGetObject("WebGrid1");              
         
        var checkBrowser=GetBrowserversion1();

        if(GetBrowserversion1()=="4")
        {
           window.setTimeout(function() {grid.RefreshAll();}, 5);
        }
        else
        {
            grid.RefreshAll();                
        }
    } 
     
    function GetBrowserversion1()
    {
        var app=navigator.userAgent;
        
        if(app.indexOf("MSIE")>-1)
        {
            return 3;	
        }
        else if(app.indexOf("Firefox/1.5")>-1)
        {
            return 2;	
        }
        else if(app.indexOf("Firefox/")>-1)
        {
            return 2;	
        }
        else
        {
            return 4;
        }
    }
    
    </script>
<body onload="LoadMenuItems()" style="height:100%">
    <form id="form1" runat="server" style="height:100%">
         <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>  
         <script>
             se.ui.messageDialog.setGlobalOptions({
                 localization: {
                     closeButtonCaption: "<%=GetLangSpecText("se_ui_messagedialog_close_caption") %>",
                   okButtonCaption: "<%=GetLangSpecText("se_ui_messagedialog_ok_caption") %>",
                   cancelButtonCaption: "<%=GetLangSpecText("se_ui_messagedialog_cancel_caption") %>",
                   showDetailsCaption: "<%=GetLangSpecText("se_ui_messagedialog_showdetails_caption") %>",
                   hideDetailsCaption: "<%=GetLangSpecText("se_ui_messagedialog_hidedetails_caption") %>"
               }
           });
</script>

     <link rel="stylesheet" type="text/css" href="<%=themedir%>Common/StyleSheet/Global.css" />
     <link href="<%=themedir%>CommonUXControls/StyleSheet/se.ui.min.css"  rel="stylesheet" type="text/css" />   
     <link rel="stylesheet" type="text/css" href="<%=themedir%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
     <link rel="stylesheet" type="text/css" href="<%=themedir%>TelerikAjax/StyleSheet/AWTWindow/Window.css">
      <script type="text/javascript">
            var tempDir = '<%=templateDirectory%>'; 
            var forwardItem= '<%=forwardItem%>';  
          var abortItem = '<%=abortItem%>';
          var removeWorkItem = '<%=removeWorkItem%>';
          var themeDirtoPass = '<%=themedir%>';
        </script>
      <script type="text/javascript" src="<%=templateDirectory%>Scripts/menu.js"></script>

        <table style="border-width: 0; width: 100%; border-spacing: 0">
            <tr>
                <td style="text-align: left; vertical-align: top; padding-left: 10px;">
                    <span class="description"><%=GetLangSpecText("PageDescHead") %></span>
                </td>
                <td>
                    <div id="btnDiv" style="height: 6%; text-align: right; padding-top: 5px; padding-right: 5px; position: relative">
                        <input type="button" id="btnRemoveWorkItem" value="<%=GetLangSpecText("mgwi_remove_workitem_btn")%>" buttonsecondary-skbtn="submit" onclick="javascript: RemoveWorkItems();" />&nbsp;
                        <input type="button" id="btnAbort" value="<%=GetLangSpecText("mgwi_abort_btn")%>" buttonsecondary-skbtn="submit" onclick="javascript: Abort()" />&nbsp;
                        <input type="button" id="btnContinue" value="<%=GetLangSpecText("mgwi_fwd_btn")%>" class="inputbutton" onclick="javascript: OpenWindow()" />

                        <asp:HiddenField ID="hdnmenuitems" runat="server" />
                        <asp:HiddenField ID="hdnWFNames" runat="server" />
                        <asp:HiddenField ID="hdnWorkItemIds" runat="server" />
                        <asp:HiddenField ID="hdnEDtlsIds" runat="server" />
                        <asp:HiddenField ID="hdnExID" runat="server" />
                        <asp:HiddenField ID="hiddenTemplatePath" runat="server" />
                    </div>
                </td>
            </tr>
        </table>

       
        <div style="height:97%;width:100%;overflow:hidden;padding-top:7px; position:relative;" id="divWitemGrid">
            <ISWebGrid:WebGrid ID="WebGrid1" Width="100%" Height="98%" runat="server" HorizontalAlign="NotSet"
                OnInitializeDataSource="WebGrid1_InitializeDataSource" OnInitializeLayout="WebGrid1_InitializeLayout" 
                OnInitializeRow="WebGrid1_InitializeRow" AllowAutoDataCaching="false" DisableFileSystemChecking="true" EnableWebResources="never">
                <RootTable GridLineStyle="NotSet">
                    <TableHeaderStyle CssClass="GridTableHeaderStyle">
                        <Padding Bottom="4px" Left="4px" Top="4px" Right="4px"></Padding>
                    </TableHeaderStyle>
                </RootTable>
                <LayoutSettings InProgressUIBehavior="ChangeCursorToHourGlass" AllowGrouping="Yes" AutoFitColumns="true" AlternatingColors="true" CellPaddingDefault="2" GridLineColor="#afafaf"
                    GridLineStyle="Solid" RowHeightDefault="23px" AutoHeight="false" AllowFilter="Yes" StatusBarVisible="true" AlwaysShowHelpButton="false"
                    GridLines="None" FilterBarVisible="false" RowHeaders="No" AllowSelectColumns="Yes" VirtualPageSize="200" PagingMode="VirtualLoad" VirtualLoadMode="LargeData" >
                    <HeaderStyle Wrap="false" Overflow="Hidden" OverflowX="Hidden" OverflowY="Hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden" CssClass="GridHeaderStyle"></HeaderStyle>
                    <ClientSideEvents OnInitialize="OnInitialize" OnRowContextMenu="ShowFWIContextMenu"></ClientSideEvents>
                    <%-- To open a WorkItemDetails window call the below client function --%>
                    <%--OnRowSelect="CheckSelect"--%>
                    <FocusCellStyle CssClass="GridFocusCellStyle"></FocusCellStyle>
                    <FrameStyle CssClass="GridFrameStyle"></FrameStyle>
                    <SelectedRowStyle CssClass="GridSelectedRowStyle"></SelectedRowStyle>
                    <AlternatingRowStyle CssClass="GridAlternatingRowStyle" OverflowX="hidden" OverflowY="hidden"></AlternatingRowStyle>
                    <LostFocusRowStyle CssClass="LostFocusRowStyle"></LostFocusRowStyle>
                    <StatusBarStyle CssClass="GridStatusBarStyle">
                        <Padding Top="2px" Left="2px" Bottom="2px" Right="2px"></Padding>
                    </StatusBarStyle>
                    <StatusBarCommandStyle Active-CssClass="GridStatusBarStyle" Normal-CssClass="GridStatusBarStyle" Over-CssClass="GridStatusBarStyle"> 
                    </StatusBarCommandStyle>
                    <GroupRowInfoStyle CssClass="GridGroupRowInfoStyle"></GroupRowInfoStyle>
                    
                    <RowStyle CssClass="GridRowStyle" Overflow="Hidden" OverflowX="Hidden" OverflowY="Hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden"></RowStyle>
                    <NewRowStyle CssClass="GridNewRowStyle"></NewRowStyle>
                    <EditFocusCellStyle CssClass="GridEditFocusCellStyle"></EditFocusCellStyle>
                    <TextSettings Language="UseCulture"></TextSettings>
                    <HyperlinkStyle CssClass="GridHyperlinkStyle" />
                     <ImageSettings RefreshImage="<%$ ReplaceTemplateExpn:Grid/images/refresh.png%>" />
                </LayoutSettings>

            </ISWebGrid:WebGrid>
        </div>
                <script type="text/javascript">
            var appWin = navigator.userAgent;
            var check = '<%= templateDirectory%>';
            if (appWin.indexOf("Chrome") > -1 || appWin.indexOf("Firefox") > -1)
            {
                document.getElementById("divWitemGrid").style.height = "90%";
            }

            if (check.indexOf("_layouts") > 0) {
                if (screen.width < 1400) {
                    document.getElementById("btnDiv").style.height = "7%";
                }
            }
        </script>
    <cc1:AjaxPageControl ID="AjaxPageControl1" runat="server" Style="z-index: 104; left: 440px;
            position: absolute; top: 88px"></cc1:AjaxPageControl>
    <telerik:RadWindowManager ID="RadWindowMgr1" Skin="AWTWindow" runat="server" Behaviors="Close, Minimize, Maximize, Move" OnClientClose="OnClientClose" VisibleStatusbar="false" VisibleOnPageLoad="false" EnableEmbeddedSkins="false" RenderMode="Classic">
        <windows>
            <telerik:RadWindow ID="ForwardWindow" Width="500" Height="400" Runat="server">
            </telerik:RadWindow>
            <telerik:RadWindow ID="RemoveWindow" Width="500" Height="400" Runat="server" />
            <telerik:RadWindow ID="AbortWindow" Width="500" Height="400" Runat="server" />
        </windows>
    </telerik:RadWindowManager>
        </form>
      
</body>
</html>
