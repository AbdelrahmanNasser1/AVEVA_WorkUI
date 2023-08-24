<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.HWS.Web.QueueControl.QueueClass"
    EnableViewState="true" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>
<%@ Register Assembly="Skelta.HWS.Web.WorkListLayoutControl" Namespace="Skelta.HWS.Web.WorkListLayoutControl" TagPrefix="cc1" %>



<link href="<%=_QControl.GetCommonRelativeUrl("StyleSheet/Global.css")%>" rel="stylesheet" type="text/css" />
 <script src="<%=JSPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=_QControl.GetThemeRelativeUrl("CommonUXControls/StyleSheet/se.ui.min.css")%>">
<link rel="stylesheet" type="text/css" href="<%=_QControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTTabStrip/TabStrip.AWTTabStrip.css")%>">
<link rel="stylesheet" type="text/css" href="<%=_QControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css")%>">
<link rel="stylesheet" type="text/css" href="<%=_QControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTWindow/Window.css")%>">

 
<script type="text/javascript">

    se.ui.messageDialog.setGlobalOptions({
        localization: {
            closeButtonCaption: "<%=ResourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                 okButtonCaption: "<%=ResourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
                 cancelButtonCaption: "<%=ResourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                 showDetailsCaption: "<%=ResourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                 hideDetailsCaption: "<%=ResourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
             }
     });
    
   
    var _SelectedRadTab="";
    function RefreshGrid_Escalation()
    {   
        try
        {
            var i=GetMOZBrowserversion();
            if(i==1)
            {
                var grid = ISGetObject("_WebGridEsclation");
                grid.RefreshAll();  
            }
            else
                window.location.href = window.location.href;
        }
        catch(e){}
    } 
    function isIE11() {
        return !!navigator.userAgent.match(/Trident.*rv[ :]*11\./);
    }
    function callExceptionScript()
    {       
        se.ui.messageDialog.showError('<%=ResourceManager.GlobalResourceSet.GetString("Queue_Header")%>', '<%=ResourceManager.GlobalResourceSet.GetString("Queue_RoleProvidernotmatchwithResHandler")%>');
    }

    function callUserLimitExceeded()
    {     
        se.ui.messageDialog.showError('<%=ResourceManager.GlobalResourceSet.GetString("Queue_Header")%>', '<%=ResourceManager.GlobalResourceSet.GetString("Queue_exception_userexceeded")%>');
    }
    
    function callUserDisabled(userId)
    {     
        se.ui.messageDialog.showError('<%=ResourceManager.GlobalResourceSet.GetString("Queue_Header")%>', '<%=ResourceManager.GlobalResourceSet.GetString("Queue_exception_userdisabled")%>');
    }
    function ShowQueueExistMsg()
    {              
       se.ui.messageDialog.showError('<%=ResourceManager.GlobalResourceSet.GetString("Queue_Header")%>', '<%=ResourceManager.GlobalResourceSet.GetString("Queue_AlreadyExists")%>');
    }
     
     function ShowHelp()
     {           
         var seltab=_SelectedRadTab;
         var left = (screen.width / 2) - (800 / 2);
         var top = (screen.height / 2) - (400 / 2);
         if(seltab.indexOf("Participants")>-1)
             window.open("<%=_QControl.GetHelpPageUrl()%>ParticipantsTab.html",'','height=400,width=800,resizable=yes,status=no,scrollbars=yes,top=' + top + ', left=' + left);
        else if(seltab.indexOf("Settings")>-1)
            window.open("<%=_QControl.GetHelpPageUrl()%>SettingsTab.html",'','height=400,width=800,resizable=yes,status=no,scrollbars=yes,top=' + top + ', left=' + left);
        else if(seltab.indexOf("Dispatch")>-1)
            window.open("<%=_QControl.GetHelpPageUrl()%>DispatchPatternsTab.html",'','height=400,width=800,resizable=yes,status=no,scrollbars=yes,top=' + top + ', left=' + left);
        else if(seltab.indexOf("Escalation")>-1)
            window.open("<%=_QControl.GetHelpPageUrl()%>EscalationTab.html",'','height=400,width=800,resizable=yes,status=no,scrollbars=yes,top=' + top + ', left=' + left);
         else
         {
             window.open("<%=_QControl.GetHelpPageUrl()%>QueueManagement.html",'','height=400,width=800,resizable=yes,status=no,scrollbars=yes,top=' + top + ', left=' + left);
         }
}
     
function beforeClick(sender, eventArgs) 
    {
        var tab = eventArgs.get_tab();
        _SelectedRadTab = "Tab is " + tab.get_text();  
}

function ShowChildWindowHelp()
{
    window.open("<%=_QControl.GetTemplateRelativeUrl("../Help/en-US/ParticipantsTab.html")%>",'','height=600,width=800,resizable=yes,status=no,scrollbars=yes');
}

    
function ValidateQueueName()
{
    
    var QueueNameTxt= document.getElementById('<%=_TxtQueueName.ClientID%>').value;
    var QueueDesc = document.getElementById('<%=_TxtDescription.ClientID %>').value;
       
    if(QueueNameTxt.length > 250)
    {
       se.ui.messageDialog.showError('<%=ResourceManager.GlobalResourceSet.GetString("Queue_Header")%>', '<%=ResourceManager.GlobalResourceSet.GetString("Queue_EnterValidQueueNameLength")%>');
        return false;  
    }

    if(QueueDesc != null  && QueueDesc.length > 150)
    {
         se.ui.messageDialog.showError('<%=ResourceManager.GlobalResourceSet.GetString("Queue_Header")%>', '<%=ResourceManager.GlobalResourceSet.GetString("Queue_EnterValidQueueDescLength")%>');
         return false;  
    }
         var iChars = "[#~&+\"\'<>|@!$%*()=/{}?]\\;"; 
         for (var i = 0; i < QueueNameTxt.length; i++) 
         {   
             if (iChars.indexOf(QueueNameTxt.charAt(i)) != -1)
             {       
                 se.ui.messageDialog.showError('<%=ResourceManager.GlobalResourceSet.GetString("Queue_Header")%>', '<%=ResourceManager.GlobalResourceSet.GetString("Queue_EnterValidQueueName")%>');
                return false;    
         
            } 
        }
  
        if (Trims(QueueNameTxt) != "")
        {
            return true;
        }
 
        else
        {
            se.ui.messageDialog.showError('<%=ResourceManager.GlobalResourceSet.GetString("Queue_Header")%>', '<%=ResourceManager.GlobalResourceSet.GetString("Queue_EnterQueueName")%>');
        return false;
        }
}
    
function Trims(sInString) 
{
    sInString = sInString.replace( /^\s+/g, "" );// strip leading
    sInString.replace( /\s+$/g, "" );// strip trailing
    return(sInString);
}
    
function HidePadColumn(gridId)
{  
    var grid = ISGetObject(gridId);
    grid.HidePadColumn = true;
}
    
function HidePadColumn1(gridId)
{
    var grid = ISGetObject(gridId);
    try{
        grid.GetRootTable().Columns[0].ResizeBestFit();
    } catch(e){}
}

function OnWebgridColumnSort(controlId, columnObject) {
    var grid = ISGetObject(controlId);
    if (IS.chrome)
    {
        try
        {                        
            var colHeaderElement = grid.RootTable.GetElement(WG40.COLHEADER, WG40.HTMLTABLE);

            var colHeaderElementTR = colHeaderElement.childNodes[0];
            sortIndicatorElement = colHeaderElementTR.getElementsByClassName("DefSI");            
            for (i = 0; i < sortIndicatorElement.length; i++) {
                sortIndicatorElement[i].style.display = "";
            }
        }
        catch(e)
        {}
    }
    return true;
}

</script>

<%-- Outer Table --%>
<div id="divQueueList" style="vertical-align:top;">

    <table id="QMainList" style="border-collapse: collapse; border-spacing: 2px; height: 100%; margin:0px auto;vertical-align: top;width:100%;">
        <% if (Request.QueryString["RoleUsers"] == null && Request.QueryString["accessrights"] == null && Request.QueryString["roleList"] == null && Request.QueryString["UserList"] == null)
       {%>
        <tr>
            <td>
                <table style="width:99%;height:6%;margin:auto;border-width:0;border-spacing:0px;vertical-align:top;" >
        <tr class="ListHeaderCss">
            <td class="MainHeading" style="padding-left: 8px;width:89%;text-align:left;vertical-align:middle;">
                <img src="<%=_QControl.GetThemeRelativeUrl("hws/images/icon-queue.png")%>" style="vertical-align: middle;" />
                <%=ResourceManager.GlobalResourceSet.GetString("Queue_Header")%>
                <asp:Label ID="_LblQueueName1" runat="server" Visible="false" CssClass="TitleStyle"></asp:Label>
            </td>
            
            <td style="text-align:right;" >
                <div id="newQueueButton" style="height: 30px;">
                <asp:ImageButton id="AddNew" runat="server" ImageUrl="<%$ ReplaceTemplateExpn:Common/Images/Add.png %>"
                                         OnClientClick="ShowNewQueue(); return false"/></div>
            </td>
            <td style="width:3%;padding-left:5px;text-align:center;">
                <a href="#" onclick="JavaScript:ShowHelp();">
                    <img src="<%=_QControl.GetCommonRelativeUrl("../hws/images/icon-help.png")%>" alt="<%=_StrHelp%>"
                        style="border-width:0"></a>
            </td>
        </tr>
                    <tr>
 <td class="description" colspan="2" style="vertical-align:top;width:100%;padding-left:6px;">
                    <%=ResourceManager.GlobalResourceSet.GetString("Queue_HeaderDesc")%>
            </td>
                    </tr>
            </table>
            </td>
        </tr>
        
        <%}%>

        <% if (Request.QueryString["RoleUsers"] == null && Request.QueryString["accessrights"] == null && Request.QueryString["roleList"] == null && Request.QueryString["UserList"] == null && !_PnlQueueMaster.Visible)
           {%>
        <tr>
            <td style="height: 25px; width:50%" text-align: right; padding: 0px; padding-left:8px; width:100%;" id="Td6">
                <asp:ImageButton runat="server" ID="btnList" ImageUrl="<%$ ReplaceTemplateExpn:HWS/Images/Back-Previous.png%>" ImageAlign="Left"
                                         OnClick= "QueueMain_Click"/>&nbsp;
            <asp:Label ID="_LblQueueName2" runat="server" class="subtitle" style ="padding-left:1px;"></asp:Label>
            </td>
        </tr>
        <%} %>
        <tr style="height:100%;vertical-align:top;">
            <td colspan="3" style="text-align: center; vertical-align: top; padding: 2px;height:100%;">
                <!-- Queue List page details   -->
                <asp:Panel ID="_PnlQueueMaster" runat="server">
                    <table id="QTable1" style="height: 100%; margin:0px auto; vertical-align: top; border-collapse: collapse; border-spacing: 1px;" class="lefttdbg"  >
                        <tr style="height:100%;">
                            <td colspan="2" style="text-align: left;height: 100%">
                                <table id="ETable" style="height: 92%; width: 100%; margin: 0 auto; border-collapse: collapse;">
                                    <tr style="height: 100%">
                                        <td colspan="5" style="height: 100%; width:95%; vertical-align: top;">
                                            <!-- New Queue Grid -->                                            
                                            <ISWebGrid:WebGrid ID="_WebGridQueEdit" runat="server" HorizontalAlign="NotSet"
                                                Width="100%" Height="100%" AllowAutoDataCaching="false" ViewStateStorage="None" DisableFileSystemChecking="true" EnableWebResources="never">
                                                <LayoutSettings PagingMode="VirtualLoad" VirtualPageSize="20" AlwaysShowHelpButton="false"
                                                    AllowExport="Yes" CellClickAction="RowSelect" UseRelativePositioning="true" PersistRowChecker="True" AutoFitColumns="True" AllowSorting="Yes"
                                                    AllowAddNew="No" AlternatingColors="True" GridLineStyle="Solid" GridLineColor="#afafaf"
                                                    CellPaddingDefault="2" RowHeightDefault="20px" GridLines="None" AutoHeight="false" RowHeaders="No">
                                                    <HeaderStyle CssClass="GridHeaderStyle"></HeaderStyle>
                                                    <FocusCellStyle CssClass="GridFocusCellStyle"></FocusCellStyle>
                                                    <GroupRowInfoStyle CssClass="GridGroupRowInfoStyle"></GroupRowInfoStyle>
                                                    <GroupByBox>
                                                        <LabelStyle CssClass="GridLabelStyle"></LabelStyle>
                                                    </GroupByBox>
                                                    <EditTextboxStyle CssClass="GridEditTextboxStyle"></EditTextboxStyle>
                                                    <FrameStyle GradientType="Vertical" CssClass="GridFrameStyle"></FrameStyle>
                                                    <SelectedRowStyle CssClass="GridSelectedRowStyle"></SelectedRowStyle>
                                                    <LostFocusRowStyle CssClass="GridLostFocusRowStyle"></LostFocusRowStyle>
                                                    <AlternatingRowStyle CssClass="GridAlternatingRowStyle" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden"></AlternatingRowStyle>
                                                    <StatusBarStyle CssClass="GridStatusBarStyle">
                                                        <Padding Top="2px" Left="2px" Bottom="2px" Right="2px"></Padding>
                                                    </StatusBarStyle>
                                        <StatusBarCommandStyle Active-CssClass="GridStatusBarStyle" Normal-CssClass="GridStatusBarStyle" Over-CssClass="GridStatusBarStyle">
                                        </StatusBarCommandStyle>
                                                    <RowStyle Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CssClass="GridRowStyle" CustomRules="text-overflow: ellipsis; overflow-x: hidden"></RowStyle>
                                                    <NewRowStyle CssClass="GridNewRowStyle"></NewRowStyle>
                                                    <EditFocusCellStyle CssClass="GridEditFocusCellStyle"></EditFocusCellStyle>
                                                    <ClientSideEvents OnRowContextMenu="WebGridQueEditMenu" OnCellDblClick="OndblClick" OnInitialize="HidePadColumn1"  OnColumnSort="OnWebgridColumnSort" />
                                                    <TextSettings Language="UseCulture"></TextSettings>
                                                    <ImageSettings RefreshImage="<%$ ReplaceTemplateExpn:Grid/images/refresh.png%>" MoreDataImage="<%$ ReplaceTemplateExpn:Grid/images/LoadMoreData.png%>"
                                            ExportImage="<%$ ReplaceTemplateExpn:Grid/images/Export.png%>"/>
                                                </LayoutSettings>
                                                <RootTable GridLineStyle="NotSet">
                                                    <TableHeaderStyle GradientType="Vertical" CssClass="GridTableHeaderStyle">
                                                        <Padding Bottom="4px" Left="4px" Top="4px" Right="4px"></Padding>
                                                    </TableHeaderStyle>
                                                </RootTable>

                                            </ISWebGrid:WebGrid>
                                           
                                            <!-- END New Queue Grid -->
                                        </td>
                                    </tr>

                                    <telerik:RadWindowManager ID="RadWindowManagerX" Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false"
                                    runat="server" Behaviors="Close" DestroyOnClose="true" Overlay="false" RenderMode="Classic" VisibleStatusbar="false">  
                                        <Windows>
                                            <telerik:RadWindow ID="PackageWindow" Height="570px" Width="500px" runat="server" Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" RenderMode="Classic" VisibleStatusbar="false" Behaviors="Close">
                                            </telerik:RadWindow>
                                        </Windows>
                                    </telerik:RadWindowManager>
                                    <tr>
                                        <td colspan="5" style="vertical-align: top; text-align: center">
                                            <div id="newQueueControls" style="display: none;">
                                                <table style="width: 100%; height: 100%" border="0" class="tablebg">
                                                    <tr style="text-align: center">
                                                        <td style="padding: 5px; width: 30%; text-align: left;">&nbsp;<span class='subtitle'><%=ResourceManager.GlobalResourceSet.GetString("Queue_Name")%></span><img src="<%=_QControl.GetThemeRelativeUrl("hws/images/mandatoryicon.gif")%>" style="vertical-align: top" visible="true" />
                                                            <asp:TextBox ID="_TxtQueueName" runat="server" CssClass="inputtext" Width="55%"></asp:TextBox></td>
                                                        <td style="padding: 5px; width: 60%; text-align: left;">&nbsp;<span class='subtitle'><%=ResourceManager.GlobalResourceSet.GetString("Queue_Description")%></span>
                                                            <asp:TextBox ID="_TxtDescription" runat="server" CssClass="inputtext" Width="65%"></asp:TextBox></td>
                                                        <td style="padding: 5px; width: 10%; text-align: right;">
                                                            <asp:Button runat="server" ID="BtnQueueNext" Text=" Add &gt;&gt; " OnClick="BtnQueueNext_Click" CssClass="inputbutton" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                   <%-- <tr>
                                        <td style="height: 30px" colspan="5">
                                            <div id="newQueueButton" style="height: 30px;">
                                                <table style="width: 100%; height: 100%;border-collapse:collapse;" border="0">
                                                    <tr>
                                                        <td style="width: 100%; text-align:right;">
                                                            <asp:ImageButton id="AddNew" runat="server" ImageUrl="<%$ ReplaceTemplateExpn:HWS/Images/New-Queue.png %>"
                                         OnClientClick="ShowNewQueue(); return false"/></td>
                                                        
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>--%>
                                </table>
                            </td>
                        </tr>
                    </table>

                    <script type="text/javascript">
                        //Function to show textboxes for entering queu detailsx
                        function ShowNewQueue() {
                            document.getElementById('newQueueControls').style.display = 'block';
                            var newQueueBtn = document.getElementById('newQueueButton');
                            newQueueBtn.style.display = 'none';
                            newQueueBtn.style.visibility = 'hidden';
                            ///newQueueBtn.parentNode.style.display = 'hidden';
                            ///newQueueBtn.style.display = 'none';
                        } 
                        var QMsg= "<%=_StrQueMsg %>";
                        if (QMsg.indexOf("QueueExists") > -1)
                            ShowQueueExistMsg();


                        //var gridQEdit=ISGetObject("_WebGridQueEdit");
                        //gridQEdit.SetHeight(450);

                    </script>

                </asp:Panel>

                <!-- landing page details ends , second page details starts -->
                <asp:Panel ID="_PnlQueueDetail" runat="server" Visible="false" Width="100%">
                    <table style="width: 100%;margin:0px auto;border-collapse: collapse; border-spacing: 1px;" border="0">
                        <tr>
                            <td colspan="2" class="leftdtdbg" style="margin:0px auto;padding: 5px;width:100%;">
                                <!-- Showing Users from ROLEPROVIDER  -->
                                <%
                    if (Request.QueryString["RoleUsers"] != null)
                    {
                                %>
                                <table style="width: 100%; margin:0px auto; border-collapse: collapse; border-spacing: 1px;border:1px solid;" >
                                    <tr>
                                        <td class="lefttdbg" style="padding:5px;">
                                            <span class="subtitle"><%=ResourceManager.GlobalResourceSet.GetString("Queue_RoleUsers")%></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="lefttdbg" style="padding: 5px; text-align: right;">
                                            <div id="viewroleusers" style="overflow: auto; width: 200px; height: 200px;">
                                                <%-- Table for each role--%>
                                                <table style="width: 100%; text-align: center">
                                                    <%
                                        foreach (string RoleUsr in RoleUsers)
                                        {
                                                    %>
                                                    <tr>
                                                        <td style="text-align: left; width: 90%">
                                                            <img src="<%=_QControl.GetTemplateRelativeUrl("images/user-icon-single.png")%>"
                                                                style="border:0;vertical-align:middle;" id="Img10" />
                                                            <span class="description"><%=RoleUsr%></span>
                                                        </td>
                                                    </tr>
                                                    <%} %>
                                                </table>
                                            </div>
                                </table>
                                <%
                    }
                    else if (Request.QueryString["accessrights"] != null)
                    {	    
                                %>
                                <!-- Access Rights Pages   -->
                                <div id="divaccessrights" style="position: absolute; left: 0; top: 0; width:98%;height:100%; padding-left:15px;padding-right:15px;">
                                    <table id="Table18" style="text-align: left; border-collapse: collapse; border-spacing: 1px; width: 100%; height: 20px;" class="tablebg">
                                        <tr>
                                            <td class="lefttdbg" style="text-align: left">
                                                <span class='subtitle'><%=ResourceManager.GlobalResourceSet.GetString("Queue_RunTimeAccessRights")%></span>
                                            </td>
                                            <td style="width: 5%; text-align: right;padding-right:5px;" class="lefttdbg">
                                                <a href="#" onclick="JavaScript:ShowChildWindowHelp();">
                                                    <img src="<%=_QControl.GetCommonRelativeUrl("images/main-help.gif")%>" alt="<%=_StrHelp%>" title="<%=_StrHelp%>"
                                                        border="0"></a></td>
                                        </tr>
                                        <tr>
                                            <td class="righttdbg" style="height: 30px; text-align: left" colspan="2">
                                                <asp:CheckBox ID="_ChkQueOwner" onClick="CheckOther();" CssClass="inputcheckbox" runat="server" />&nbsp;
                                                <span class='description'><%=ResourceManager.GlobalResourceSet.GetString("Queue_QueueOwner")%></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="righttdbg" style="text-align: left; height: 10px">
                                                <asp:CheckBox ID="_ChkViewQue" CssClass="inputcheckbox" onclick="ViewQueCheck(this.checked);" runat="server" />&nbsp;
                                <span class='description'><%=ResourceManager.GlobalResourceSet.GetString("Queue_CanViewQueueItems")%></span>
                                            </td>
                                            <td class="righttdbg" style="height: 30px; text-align: left; width: 50%;">
                                                <asp:CheckBox ID="_ChkViewDisItem" CssClass="inputcheckbox" onclick="ViewDisItemCheck(this.checked);" runat="server" />&nbsp;
                                <span class='description'><%=ResourceManager.GlobalResourceSet.GetString("Queue_CanViewAllocatedItems")%></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="righttdbg" style="height: 30px; text-align: left; width: 50%;">
                                                <asp:CheckBox ID="_ChkAdHocPictTask" CssClass="inputcheckbox" onclick="AdHocPictTaskCheck(this.checked);"
                                                    runat="server" />&nbsp;
                                <span class='description'><%=ResourceManager.GlobalResourceSet.GetString("Queue_CanAdHocPickTask")%></span>
                                            </td>
                                            <td class="righttdbg" style="height: 30px; text-align: left;">
                                                <asp:CheckBox ID="_ChkPlanQueItem" CssClass="inputcheckbox" onclick="PlanQueItemCheck(this.checked);" runat="server" />&nbsp;
                                <span class='description'><%=ResourceManager.GlobalResourceSet.GetString("Queue_CanPlanQueueItem")%></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="righttdbg" style="height: 30px; text-align: left; width: 50%;">
                                                <asp:CheckBox ID="_ChkBackInSameQue" CssClass="inputcheckbox" onclick="DeselectOwner(this.checked);" runat="server"
                                                    Checked="false" />&nbsp;
                                <span class='description'><%=ResourceManager.GlobalResourceSet.GetString("Queue_CanPutBackinQueue")%></span>
                                            </td>
                                            <td class="righttdbg" style="height: 30px; text-align: left;">
                                                <asp:CheckBox ID="_ChkPutBackInDiffQue" CssClass="inputcheckbox" onclick="MovetoDifferentQueue(this.checked);"
                                                    runat="server" />&nbsp;
                                <span class='description'><%=ResourceManager.GlobalResourceSet.GetString("Queue_CanMovetoDifferentQueue")%></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="righttdbg" style="height: 30px; text-align: left;">
                                                <asp:CheckBox ID="_ChkRecallAllocated" CssClass="inputcheckbox" onclick="RecallAllocatedCheck(this.checked);"
                                                    runat="server" />&nbsp;
                                <span class='description'><%=ResourceManager.GlobalResourceSet.GetString("Queue_CanRecallAllocatedItems")%></span>
                                            </td>
                                            <td class="righttdbg" style="height: 30px; text-align: left;">
                                                <asp:CheckBox ID="_ChkPriorityLvl" CssClass="inputcheckbox" onclick="ChangePriorityLevel(this.checked);" runat="server" />&nbsp;
                                <span class='description'><%=ResourceManager.GlobalResourceSet.GetString("Queue_CanChangePrioritylevel")%></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="righttdbg" style="height: 30px; text-align: left;">
                                                <asp:CheckBox ID="_ChkUsrBasedAlloc" CssClass="inputcheckbox" onclick="Check_User_Pattern_Time_Alloc(this.checked);"
                                                    runat="server" />&nbsp;
                                <span class='description'><%=ResourceManager.GlobalResourceSet.GetString("Queue_CanDoUserBasedAllocation")%></span>
                                            </td>
                                            <td class="righttdbg" style="height: 30px; text-align: left;">
                                                <asp:CheckBox ID="_ChkPtrnBasedAlloc" CssClass="inputcheckbox" onclick="Check_User_Pattern_Time_Alloc(this.checked);"
                                                    runat="server" />&nbsp;
                                <span class='description'><%=ResourceManager.GlobalResourceSet.GetString("Queue_CanDoPatternBasedAllocation")%></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="righttdbg" style="height: 30px; text-align: left;" colspan="2">
                                                <asp:CheckBox ID="_ChkTimeBasedAlloc" CssClass="inputcheckbox" onclick="Check_User_Pattern_Time_Alloc(this.checked);"
                                                    runat="server" />&nbsp;
                                <span class='description'><%=ResourceManager.GlobalResourceSet.GetString("Queue_CanDoTimeBasedAllocation")%></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="righttdbg" style="height: 30px; text-align: left;" colspan="2">
                                                <asp:CheckBox ID="_ChkPartforAutoDisp" CssClass="inputcheckbox" runat="server" />&nbsp;
                                <span class='description'><%=ResourceManager.GlobalResourceSet.GetString("Queue_ConsiderQueueOwnerasParticipantforAutomaticDispatch")%></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="righttdbg" style="height: 0px; text-align: left;">
                                                <asp:CheckBox ID="_ChkManualPickSpecificItem" CssClass="inputcheckbox" onclick="DeselectOwner(this.checked);"
                                                    runat="server" Visible="false" /><!--Can Users Manually Pick Specific Item (Enabled for Manual Dispatch)--></td>
                                            <td class="righttdbg" style="height: 0px; text-align: left;">
                                                <asp:CheckBox ID="_ChkDisabParticipant" CssClass="inputcheckbox" onclick="DeselectOwner(this.checked);" runat="server"
                                                    Visible="false" /><!--Disable Participant--></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" class="lefttdbg" style="text-align: left">
                                                <span class='subtitle'><%=ResourceManager.GlobalResourceSet.GetString("Queue_DesignTimeAccessRights")%></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="righttdbg" style="height: 30px; text-align: left;">
                                                <asp:CheckBox ID="_ChkParticipants" CssClass="inputcheckbox" onclick="ParticipantsCheck(this.checked)" runat="server" />&nbsp;
                                <span class='description'><%=ResourceManager.GlobalResourceSet.GetString("Queue_ManageParticipants")%></span>
                                            </td>
                                            <td class="righttdbg" style="height: 30px; text-align: left;">
                                                <asp:CheckBox ID="_ChkAccessRights" CssClass="inputcheckbox" onclick="SetAccessRightsCheck(this.checked);"
                                                    runat="server" />&nbsp;
                                <span class='description'><%=ResourceManager.GlobalResourceSet.GetString("Queue_SetAccessRights")%></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="righttdbg" style="height: 30px; text-align: left;">
                                                <asp:CheckBox ID="_ChkSettings" CssClass="inputcheckbox" onclick="DeselectOwner(this.checked);" runat="server" />&nbsp;
                                <span class='description'><%=ResourceManager.GlobalResourceSet.GetString("Queue_ChangeSettings")%></span>
                                            </td>
                                            <td class="righttdbg" style="height: 30px; text-align: left;">
                                                <asp:CheckBox ID="_ChkDispatchPattern" CssClass="inputcheckbox" onclick="DeselectOwner(this.checked);" runat="server" />&nbsp;
                                <span class='description'><%=ResourceManager.GlobalResourceSet.GetString("Queue_ManageDispatchPatterns")%></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="righttdbg" style="height: 30px; text-align: left;" colspan="2">
                                                <asp:CheckBox ID="_ChkEscalation" CssClass="inputcheckbox" onclick="DeselectOwner(this.checked);" runat="server" />&nbsp;
                                <span class='description'><%=ResourceManager.GlobalResourceSet.GetString("Queue_ManageEscalation")%></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="righttdbg" style="height: 0px; text-align: left;" colspan="2">
                                                <asp:CheckBox ID="_ChkFields" CssClass="inputcheckbox" onclick="DeselectOwner(this.checked);" runat="server"
                                                    Visible="false" /><!--&nbsp;Fields--></td>
                                        </tr>

                                        <tr>
                                            <td colspan="2" style="text-align: right;padding-right:10px;" class='lefttdbg'>
                                                <!-- <INPUT id="button134" class=inputbutton type="button" value="Update" name="button3"> -->
                                                <asp:Button ID="btnAccessRights" CssClass="inputbutton" OnClick="btnAccessRights_ServerClick"
                                                    runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>

                                <script type="text/javascript">
          
                                    CanOwnerPartCheck();
                                    function CanOwnerPartCheck()
                                    {
                                        if(document.getElementById('<%=_ChkQueOwner.ClientID%>').checked)
                                            document.getElementById('<%=_ChkPartforAutoDisp.ClientID%>').disabled=false;
                                        else           
                                        {
                                            document.getElementById('<%=_ChkPartforAutoDisp.ClientID%>').checked=false;
                                            document.getElementById('<%=_ChkPartforAutoDisp.ClientID%>').disabled=true;
                                        }
                                    }
                        
                                    function CheckOther()
                                    {
                                        var k1=document.getElementById('<%=_ChkQueOwner.ClientID%>');
                                        if(k1.checked)
                                        {
                                            document.getElementById('<%=_ChkBackInSameQue.ClientID%>').checked=true;
                                            document.getElementById('<%=_ChkPlanQueItem.ClientID%>').checked=true;
                                            document.getElementById('<%=_ChkAdHocPictTask.ClientID%>').checked=true;
                                            document.getElementById('<%=_ChkViewDisItem.ClientID%>').checked=true;
                                            document.getElementById('<%=_ChkViewQue.ClientID%>').checked=true;
                                            document.getElementById('<%=_ChkPutBackInDiffQue.ClientID%>').checked=true;
                                            document.getElementById('<%=_ChkPriorityLvl.ClientID%>').checked=true;
                                            document.getElementById('<%=_ChkPtrnBasedAlloc.ClientID%>').checked=true;
                                            document.getElementById('<%=_ChkRecallAllocated.ClientID%>').checked=true;
                                            document.getElementById('<%=_ChkUsrBasedAlloc.ClientID%>').checked=true;
                                            document.getElementById('<%=_ChkTimeBasedAlloc.ClientID%>').checked=true;
                                            document.getElementById('<%=_ChkParticipants.ClientID%>').checked=true;
                                            document.getElementById('<%=_ChkDispatchPattern.ClientID%>').checked=true;
                                            document.getElementById('<%=_ChkAccessRights.ClientID%>').checked=true;
                                            document.getElementById('<%=_ChkSettings.ClientID%>').checked=true;
                                            document.getElementById('<%=_ChkEscalation.ClientID%>').checked=true;
                                            document.getElementById('<%=_ChkPartforAutoDisp.ClientID%>').disabled=false;
                		        
                                        }
                                        else
                                        { 
                                            document.getElementById('<%=_ChkPartforAutoDisp.ClientID%>').checked=false;
                                            document.getElementById('<%=_ChkPartforAutoDisp.ClientID%>').disabled=true;
                                        }   
                                    }
						
						
                                    function ViewDisItemCheck(stat)
                                    {
                                        if(stat==true)
                                        {
                                            //document.getElementById('<%=_ChkViewQue.ClientID%>').checked=true;
                           }
                           else      
                           {
                               document.getElementById('<%=_ChkQueOwner.ClientID%>').checked=false;
                               document.getElementById('<%=_ChkRecallAllocated.ClientID%>').checked=false;
                               CanOwnerPartCheck();
                           }
                       }
						
                       function ViewQueCheck(stat)
                       {
                           if(stat==false)
                           {
                               document.getElementById('<%=_ChkQueOwner.ClientID%>').checked=false;
                                 document.getElementById('<%=_ChkViewDisItem.ClientID%>').checked=false;
                                 document.getElementById('<%=_ChkAdHocPictTask.ClientID%>').checked=false;
                                 document.getElementById('<%=_ChkPlanQueItem.ClientID%>').checked=false;
                                 document.getElementById('<%=_ChkRecallAllocated.ClientID%>').checked=false;
                                 document.getElementById('<%=_ChkPriorityLvl.ClientID%>').checked=false;
                                 document.getElementById('<%=_ChkPutBackInDiffQue.ClientID%>').checked=false;
						     
                                 document.getElementById('<%=_ChkUsrBasedAlloc.ClientID%>').checked=false;
                                 document.getElementById('<%=_ChkPtrnBasedAlloc.ClientID%>').checked=false;
                                 document.getElementById('<%=_ChkTimeBasedAlloc.ClientID%>').checked=false;
                                 CanOwnerPartCheck();
                             }
						    
                         }
						
                         function PlanQueItemCheck(stat)
                         {
                             if(stat==true)
                             {
                                 document.getElementById('<%=_ChkAdHocPictTask.ClientID%>').checked=true;       
                                document.getElementById('<%=_ChkViewQue.ClientID%>').checked=true;
                            }
                            else      
                            {
                                document.getElementById('<%=_ChkQueOwner.ClientID%>').checked=false;
                                CanOwnerPartCheck();
                            }  
                        }
						
						
                        function AdHocPictTaskCheck(stat)
                        {
                            if(stat==false)
                            {
                                document.getElementById('<%=_ChkQueOwner.ClientID%>').checked=false;
                                document.getElementById('<%=_ChkPlanQueItem.ClientID%>').checked=false;
                                CanOwnerPartCheck();
                            }
                            else
                                document.getElementById('<%=_ChkViewQue.ClientID%>').checked=true;
                        }
						
                        function SetAccessRightsCheck(stat)
                        {
                            if(stat==true)
                                document.getElementById('<%=_ChkParticipants.ClientID%>').checked=true; 
                            else      
                            {
                                document.getElementById('<%=_ChkQueOwner.ClientID%>').checked=false;
                                CanOwnerPartCheck();
                            }
                        }
						
                        function ParticipantsCheck(stat)
                        {
                            if(stat==false)
                            {
                                document.getElementById('<%=_ChkQueOwner.ClientID%>').checked=false;
                                document.getElementById('<%=_ChkAccessRights.ClientID%>').checked=false;
                                CanOwnerPartCheck();						         
                            }
                        }
						
                        function ChangePriorityLevel(stat)
                        {
                            if(stat==false)
                            {
                                document.getElementById('<%=_ChkQueOwner.ClientID%>').checked=false;
                                CanOwnerPartCheck();
                            }
                            else
                            {
                                document.getElementById('<%=_ChkViewQue.ClientID%>').checked=true;
                            }
                        }
						
                        function MovetoDifferentQueue(stat)
                        {
                            if(stat==false)
                            {
                                document.getElementById('<%=_ChkQueOwner.ClientID%>').checked=false;
                              CanOwnerPartCheck();
                          }
                          else
                          {
                              document.getElementById('<%=_ChkViewQue.ClientID%>').checked=true;
                          }
                      }
						
                      function DeselectOwner(stat)
                      {
                          if(stat==false)
                          {
                              document.getElementById('<%=_ChkQueOwner.ClientID%>').checked=false;
                                 CanOwnerPartCheck();
                             }   
                         }
						
                         function RecallAllocatedCheck(stat)
                         {
                             if(stat==false)
                             {
                                 document.getElementById('<%=_ChkQueOwner.ClientID%>').checked=false;
                                CanOwnerPartCheck();
                            }   
                            else if(stat==true)    
                            {
                                document.getElementById('<%=_ChkViewQue.ClientID%>').checked=true;
                                document.getElementById('<%=_ChkViewDisItem.ClientID%>').checked=true;
                            }
                    }
						
                    function Check_User_Pattern_Time_Alloc(stat)
                    {
                        if(stat==false)
                        {
                            document.getElementById('<%=_ChkQueOwner.ClientID%>').checked=false;
                            CanOwnerPartCheck();
                        }
                        else if(stat==true)    
                        {
                            document.getElementById('<%=_ChkViewQue.ClientID%>').checked=true;
                        }
                }
						
                //						    function CheckAll(objCheckBox)
                //						    {
                //						        var checkBoxCount=12;
                //						        if(objCheckBox.checked)
                //						        {
                //						        
                //						            for(k=1;k<=checkBoxCount;k++)
                //						            {
                //						                var checkObj = eval("document.getElementsByTagName('input')['CheckboxQueueOwner"+k+"']")
                //						                checkObj.checked=true;
                //				   		                  
                //						            }
                //						        }
                //						        else
                //						        {
                //						            for(k=1;k<=checkBoxCount;k++)
                //						            {
                //						                var checkObj = eval("document.getElementsByTagName('input')['CheckboxQueueOwner"+k+"']")
                //						                checkObj.checked=false;
                //						            }
                //						        }
                //						    }
                                </script>

                                <%
                    }
                    else if (Request.QueryString["resset"] != null && Request.QueryString["roleList"] != null)
                    {
                                %>
                                <!-- Add  RoleList starts   -->

                                <script type="text/javascript">

                                    function ResizeGrid1(controlId, actionName, lastRequestObject, xmlResponseObject)
                                    {
                                        if(actionName=="RefreshAll" || actionName=="Refresh")
                                        {
                        
                                            var WebGrid1 = ISGetObject(controlId);
                                            window.setTimeout(function () {
                                                wgDoResize(true, true);
                                            }, 600);
                                            return true;
                                        }
                                    }

                                    function selectRoles(clientid) 
                                    {
                                        var roles = encodeURIComponent(document.getElementById('<%=roleNameHidden.ClientID %>').value);

                                        var oWindow = radopen("../Repository/Site/RoleLookup.aspx?roles=" + roles, null);

                                        oWindow.set_modal(true);
                                        oWindow.set_title('Select Roles');
                                        oWindow.setSize(600, 500);
                                        oWindow.setActive(true);
                                        oWindow.center();

                                        oWindow.add_beforeClose(onClientBeforeCloseRoles);

                                        function onClientBeforeCloseRoles(sender, args)
                                        {
                                            var returnValue = args.get_argument();

                                            if (returnValue !== null && returnValue !== undefined)
                                            {
                                                var oArea = document.getElementById(clientid);
                                                var id;
                                                var names = '';

                                                var dataArray = returnValue.split(',');

                                                if (returnValue) 
                                                {
                                                    for (var i = 0; i < dataArray.length; i++) 
                                                    {
                                                        // For Generic roles (Roles with Providers)
                                                        // If Generic Role, It will split with ::
                                                        // If it is 'Everyone-Skelta' it will not split
                                                        if (dataArray[i].indexOf('::') != -1) 
                                                        {
                                                            id = dataArray[i].split('::');
                                                            names = names + id[1] + ',';
                                                        }
                                                        else
                                                            names = names + dataArray[i] + ',';
                                                    }
                                                }
                                                else 
                                                {
                                                    // alert('<%=ResourceManager.GlobalResourceSet.GetString("Queue_Roles_a_role")%>');
                                                    se.ui.messageDialog.showError('<%=ResourceManager.GlobalResourceSet.GetString("Queue_Header")%>', '<%=ResourceManager.GlobalResourceSet.GetString("Queue_Roles_a_role")%>');
                                                    args.set_cancel(true);
                                                    return;
                                                }

                                                oArea.value = names.substring(0, names.lastIndexOf(','));
                                                var oArea1 = document.getElementById('<%=roleNameHidden.ClientID %>');
                                                oArea1.value = returnValue;
                                            }

                                            sender.remove_beforeClose(onClientBeforeCloseRoles);
                                        }
                                    }

                    
                                    function Validate() {
                                        if (document.getElementById('<%=roleName.ClientID %>').value == '') {
                                           // alert('<%= ResourceManager.GlobalResourceSet.GetString("Queue_Roles_a_role")%>');
                                            se.ui.messageDialog.showError('<%=ResourceManager.GlobalResourceSet.GetString("Queue_Header")%>', '<%=ResourceManager.GlobalResourceSet.GetString("Queue_Roles_a_role")%>');
                            document.getElementById('<%=roleNameHidden.ClientID %>').value = '';
                            return false;
                        }

                        return true;
                    }

                    function showErrorMessage(msg) {
                       // alert(msg);
                        se.ui.messageDialog.showError('<%=ResourceManager.GlobalResourceSet.GetString("Queue_Header")%>', msg);
                    }
                    
                    // Making header & footer constant
                    AddEventHandler(window, 'resize', resizefunction);
                    AddEventHandler(window, 'load', resizefunction);

                    function AddEventHandler(elementObject, eventName, functionObject) {
                        if (document.addEventListener)
                            elementObject.addEventListener(eventName, functionObject, false);
                        else
                            if (document.attachEvent)
                                elementObject.attachEvent("on" + eventName, functionObject);
                    }
                    function resizefunction() {//debugger;
                        
                        var bodydiv = document.getElementById('divbodyRole');
                        var headerdiv = document.getElementById('divheaderRole');
                        var footerdiv = document.getElementById('divfooterRole');
                        var parentdiv = document.getElementById('divQueueList');
                        
                        parentdiv.style.width = document.body.clientWidth - 10 +"px";
                        parentdiv.style.height = document.body.clientHeight - 10 +"px";

                        var parentdivheight = document.body.clientHeight - 10;
                        
                        try { bodydiv.style.height = parentdivheight - headerdiv.offsetHeight - footerdiv.offsetHeight +"px"; } catch (e) { }
                        bodydiv.style.width = parentdiv.style.width;
                        bodydiv.style.overflow = 'auto';
                        parentdiv.style.overflow = 'hidden';
                    }
                                </script>

                                <div id="divheaderRole">
                                    <table style="width: 100%; margin: 0px auto; border-collapse: separate; border-spacing: 1px;" border="0">
                                        <tr>
                                            <td style="padding: 2px;text-align:left;">
                                                <table style="width: 100%; margin: 0px auto;">
                                                    <tr>
                                                        <td id="Td4" class="pagetitle">
                                                            <img src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/icon-role.png"
                                                               style="vertical-align:middle;" />&nbsp;&nbsp;
                                                                <%= ResourceManager.GlobalResourceSet.GetString("Queue_RoleSelection")%>
                                                        </td>
                                                        <td style="width: 5%; height: 25px; text-align: right; padding: 0px;">
                                                            <a href="#" onclick="JavaScript:ShowChildWindowHelp();">
                                                                <img src="<%=_QControl.GetCommonRelativeUrl("images/main-help.gif")%>" alt="<%=_StrHelp%>"
                                                                    border="0"></a>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr style="height: 30px;">
                                            <td id="Td5" class="description" style="text-align:left;">&nbsp;&nbsp;
                                <%= ResourceManager.GlobalResourceSet.GetString("Queue_Roles_desc")%>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="divbodyRole">
                                    <table id="Table2" style="width:99%;margin:0px auto;border-collapse:separate;border-spacing:1px;" class="tablebg">
                                        <tr>
                                            <td class="lefttdbg" style="width: 45%;vertical-align:top;padding:7px;text-align:left;">
                                                <span class="subtitle">
                                                    <%=ResourceManager.GlobalResourceSet.GetString("Queue_Roles_Select_Role")%>
                                                </span>
                                               <br />
                                                <span class="description">
                                                    <%= ResourceManager.GlobalResourceSet.GetString("Queue_Roles_desc2")%>
                                                </span>
                                                <br />
                                            </td>
                                            <td class="righttdbg" style="width: 55%;padding:7px;text-align:left;">
                                                <asp:TextBox ID="roleName" CssClass="inputtext" runat="server" onclick="this.blur()"
                                                    Width="200px"></asp:TextBox>
                                                <input id="Button2" class="rolelookup" onclick="selectRoles('<%=roleName.ClientID %>');"
                                                    type="button" title="<%=ResourceManager.GlobalResourceSet.GetString("Queue_Roles_rolelookup_title")%>"
                                                    value=".." name="SiteExplorer" style="vertical-align:top;" />
                                                <asp:HiddenField ID="roleNameHidden" EnableViewState="true" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="">
                                    <table style="width:100%;">
                                        <tr>
                                            <td colspan="2" style="text-align:right;padding:0px;"><div style="width:90%;text-align:right;padding-top:300px; float:right">
                                                <asp:Button ID="BtnRoleUpdate" runat="server" CssClass="inputbutton" OnClientClick=" return Validate();"
                                                     OnClick="BtnRoleUpdateClick" /></div>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div style="height: 300px; width: 50px; display: none">
                                    <input type="button" id="SearchRole" value="Open Window" />
                                </div>

                                <telerik:RadWindowManager ID="SingletonRole" Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false"
                                runat="server" BackColor="Black" Behaviors="Close, Minimize, Maximize, Move"  DestroyOnClose="true" Overlay="false" RenderMode="Classic" VisibleStatusbar="false"> 
                                    <Windows>
                                        <telerik:RadWindow ID="RadWindowRole" Height="300px" Width="555px" runat="server" OpenerElementID="SearchRole"
                                            NavigateUrl="RoleLookup.aspx" Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" RenderMode="Classic" VisibleStatusbar="false">
                                        </telerik:RadWindow>
                                    </Windows>
                                </telerik:RadWindowManager>
                                
                                

                                <!-- RoleList Finish, Add UserList starts-->
                                <%
                    }
                    else if (Request.QueryString["resset"] != null && Request.QueryString["UserList"] != null)
                    {
                                %>

                                <script type="text/javascript" >
                                    function selectUsers(clientid) 
                                    {
                                        var users = encodeURIComponent(document.getElementById('<%=usrNameHidden.ClientID %>').value);
                                        var oWindow = radopen("../Repository/Site/UserLookup.aspx?users=" + users, null);
                                        oWindow.set_modal(true);
                                        oWindow.set_title('Select User');
                                        oWindow.setSize(600, 500);
                                        oWindow.setActive(true);
                                        oWindow.center();

                                        oWindow.add_beforeClose(onClientBeforeCloseUsers);

                                        function onClientBeforeCloseUsers(sender, args)
                                        {
                                            var returnValue = args.get_argument();

                                            if (returnValue !== null && returnValue !== undefined)
                                            {
                                                var oArea = document.getElementById(clientid);
                                                var ids;
                                                var names = '';
                                                var useridstring = '';

                                                if (returnValue.lastIndexOf("^") != -1) 
                                                {
                                                    var usernamestring = returnValue.substring(0, returnValue.lastIndexOf("^"));
                                                    useridstring = returnValue.substring(returnValue.lastIndexOf("^") + 1);
                                                    names = usernamestring;
                                                }

                                                oArea.value = ReplaceAll(names, "@!@", ", ");
                                                var oArea1 = document.getElementById('<%=usrNameHidden.ClientID %>');
                                                oArea1.value = useridstring;
                                            }

                                            sender.remove_beforeClose(onClientBeforeCloseUsers);
                                        }
                                    }

                                    function Validate() {
                                        if (document.getElementById('<%=usrName.ClientID %>').value == '') {
                                           // alert('<%= ResourceManager.GlobalResourceSet.GetString("Queue_Users_a_user")%>');
                                            se.ui.messageDialog.showError('<%=ResourceManager.GlobalResourceSet.GetString("Queue_Header")%>', '<%= ResourceManager.GlobalResourceSet.GetString("Queue_Users_a_user")%>');

                                            document.getElementById('<%=usrNameHidden.ClientID %>').value = '';
                                            return false;
                                        }

                                        return true;
                                    }

                                    function ReplaceAll(Source, stringToFind, stringToReplace)
                                    {
                                        var temp = Source.split(stringToFind);

                                        return temp.join(stringToReplace);
                                    }

                                    function showErrorMessage(msg) {
                                        //alert(msg);
                                        se.ui.messageDialog.showError('<%=ResourceManager.GlobalResourceSet.GetString("Queue_Header")%>', msg);
                                    }

                                    // Making header & footer constant
                                    AddEventHandler(window, 'resize', resizefunction);
                                    AddEventHandler(window, 'load', resizefunction);

                                    function AddEventHandler(elementObject, eventName, functionObject) {
                                        if (document.addEventListener)
                                            elementObject.addEventListener(eventName, functionObject, false);
                                        else
                                            if (document.attachEvent)
                                                elementObject.attachEvent("on" + eventName, functionObject);
                                    }
                                    function resizefunction() 
                                    {
                                        var bodydiv = document.getElementById('divbodyUser');
                                        var headerdiv = document.getElementById('divheaderUser');
                                        var footerdiv = document.getElementById('divfooterUser');
                                        var parentdiv = document.getElementById('divQueueList');

                                        parentdiv.style.width = document.body.clientWidth - 10 +"px";
                                        parentdiv.style.height = document.body.clientHeight - 10 +"px";

                                        var parentdivheight = document.body.clientHeight - 10;

                                        try 
                                        {
                                            bodydiv.style.height = parentdivheight - headerdiv.offsetHeight - footerdiv.offsetHeight +"px"; 
                            
                                        } catch (e) { }
                                        bodydiv.style.width = parentdiv.style.width;
                                        bodydiv.style.overflow = 'auto';
                                        parentdiv.style.overflow = 'hidden';
                                    }
                                </script>

                                <div id="divheaderUser">
                                    <table style="width:100%;margin:0px auto;border-collapse:separate;border-spacing:1px;" border="0">
                                        <tr>
                                            <td style="padding:2px;">
                                                <table style="width:100%;margin:0px auto;">
                                                    <tr>
                                                        <td id="Td2" class="pagetitle" style="text-align:left;">
                                                            <img src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/icon-users-list.png"
                                                                style="vertical-align:middle" />&nbsp;&nbsp;
                                            <%= ResourceManager.GlobalResourceSet.GetString("Queue_AddUsers")%>
                                                        </td>
                                                        <td style="padding:0px;width:5%;height:25px;text-align:right">
                                                            <a href="#" onclick="JavaScript:ShowChildWindowHelp();">
                                                                <img src="<%=_QControl.GetCommonRelativeUrl("images/main-help.gif")%>" alt="<%=_StrHelp%>"
                                                                    border="0"></a>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr style="height:30px;text-align:left;">
                                            <td id="Td3" class="description">&nbsp;&nbsp;
                                <%= ResourceManager.GlobalResourceSet.GetString("Queue_Users_desc")%>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="divbodyUser">
                                    <table id="TMain" style="width:99%;margin:0px auto;border-collapse:separate;border-spacing:1px;" class="tablebg">
                                        <tr>
                                            <td class="lefttdbg" style="width: 45%;padding:7px;vertical-align:top;text-align:left;">
                                                <span class="subtitle">
                                                    <%=ResourceManager.GlobalResourceSet.GetString("Queue_Users_Select_User")%>
                                                </span>
                                                <br />
                                                <br />
                                                <span class="description">
                                                    <%= ResourceManager.GlobalResourceSet.GetString("Queue_Users_desc2")%>
                                                </span>
                                                <br />
                                            </td>
                                            <td class="righttdbg" style="width: 55%;text-align:left;padding:7px;">
                                                <asp:TextBox ID="usrName" CssClass="inputtext" runat="server" onclick="this.blur()"
                                                    Width="200px"></asp:TextBox>
                                                <input id="Button1" class="userlookup" onclick="selectUsers('<%=usrName.ClientID %>');"
                                                    type="button" title="<%=ResourceManager.GlobalResourceSet.GetString("Queue_Users_userlookup_title")%>"
                                                    value=".." name="SiteExplorer" />
                                                <asp:HiddenField ID="usrNameHidden" EnableViewState="true" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="">
                                    <table border="0" style="width:100%;">
                                        <tr>
                                            <td><div style="width:90%;text-align:right;padding-top:266px; float:right">
                                                <asp:Button ID="btnUserUpdate" runat="server" CssClass="inputbutton" OnClientClick=" return Validate();"
                                                     OnClick="BtnUserUpdate_Click" />
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div style="height: 300px; width: 50px; display: none">
                                    <input type="button" id="SearchUser" value="Open Window" />
                                </div>                               
                                
                                
                                <telerik:RadWindowManager ID="SingletonUser" Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false"
                                runat="server" BackColor="Black" Behaviors="Close, Minimize, Maximize, Move"  DestroyOnClose="true" Overlay="false" RenderMode="Classic" VisibleStatusbar="false"> 
                                    <Windows>
                                        <telerik:RadWindow ID="RadWindowUser" Height="300px" Width="555px" runat="server" OpenerElementID="SearchUser"
                                            NavigateUrl="UserLookup.aspx"  Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" RenderMode="Classic" VisibleStatusbar="false">
                                        </telerik:RadWindow>
                                    </Windows>
                                </telerik:RadWindowManager>
                                <%
                    }
                    else if (Request.QueryString["iframe"] != null)
                    { %>
                               
                                <%}
                  else
                  {%>
                                <table style="width:100%;height:100%;border:0px solid;" class="lefttdbg">
                                    <tr>
                                        <td>                                            
                                             <telerik:RadTabStrip ID="RadTabStrip1" EnableEmbeddedSkins="false" SelectedIndex="0"  MultiPageID="RadMultiPage1" runat="server" Width="100%"
                                             Skin="AWTTabStrip" RenderMode="Classic" Orientation="HorizontalBottom" OnClientTabSelecting="beforeClick" OnClientTabSelected="onTabSelected"  >
                                                <Tabs>
                                                    <telerik:RadTab  PageViewID="ResourceFilter">
                                                    </telerik:RadTab>
                                                    <telerik:RadTab  PageViewID="DispatchPatterns">
                                                    </telerik:RadTab>
                                                    <telerik:RadTab  PageViewID="Setting">
                                                    </telerik:RadTab>
                                                    <telerik:RadTab  PageViewID="Escalation">
                                                    </telerik:RadTab>
                                                </Tabs>
                                             </telerik:RadTabStrip>                                            
                                        </td>
                                    </tr>
                                </table>
                                <telerik:RadMultiPage ID="RadMultiPage1" runat="server" Width="100%" Height="100%" SelectedIndex="0" RenderMode="Classic" >
                                    <telerik:RadPageView ID="ResourceFilter" runat="server">

                                        <script type="text/javascript">
                                           


                                            function OpenWindow(type)
                                            {


                                                QName = '<%=Microsoft.Security.Application.Encoder.UrlEncode(Microsoft.Security.Application.Encoder.JavaScriptEncode(strQueueName, false)) %>';
                               
                                                var urlStr = "<%=PreviousUrl%>";
                               
                                                var userId = '<%=QueueUserId%>';
                                                userId = userId.replace('&', 'amp;');
                                                var application = '<%=_ApplicationName%>';
                                                var templateURL = '<%=_QControl.GetTemplateRelativeUrl("QueueUsers.aspx")%>';
                                                templateURL += '?application='+application+'&userId='+escape(userId)+'&QueName=' + QName+'&';

                                                var left;
                                                var top;
                                                left = (screen.width / 2) - (720 / 2);
                                                top = (screen.availHeight / 2) - (520 / 2);   
                                          
                                                switch (type) 
                                                {                            	
                                                    case "roleList":
                                                        window.open(templateURL + 'resset=1&roleList=1', '',"top="+top+",left="+left+",height=520,width=720,resizable=yes,status=no");                                                                                                                                            
                                                        break;
                                    
                                                    case "UserList":
                                                        window.open(templateURL + 'resset=1&UserList=1', '', "top="+top+",left="+left+",height=520,width=720,resizable=yes,status=no");
                                                        break;
                                    
                                                    case "EditFilter":
                                                        left = (screen.width / 2) - (280 / 2);
                                                        top = (screen.height / 2) - (150 / 2); 
                                                        window.open('?resset=1&RoleUsers=1', '', 'height=150,width=280,resizable=yes,left=' + left + ', top=' + top );// Old values height=120,width=250
                                                        //window.open(templateURL+'resset=1&RoleUsers=1','','height=150,width=280,resizable=no')// Old values height=120,width=250
                                                        break;
                                    
                                                    case "resfilter":
                                                        left = (screen.width / 2) - (600 / 2);
                                                        top = (screen.height / 2) - (300 / 2); 
                                                        window.open('?viewusers=1', '', 'height=300,width=600,resizable=yes,left=' + left + ', top=' + top );
                                                        //window.open(templateURL+'viewusers=1','','height=300,width=600,resizable=no')
                                                        break;
                                    
                                                    case "accessrights":
                                                        left = (screen.width / 2) - (520 / 2);
                                                        top = (screen.height / 2) - (700 / 2); 
                                                        window.open('?accessrights=1', '', 'height=700,width=520,resizable=yes,left=' + left + ', top=' + top );
                                                        //window.open(templateURL+'accessrights=1','','height=700,width=520,resizable=no')
                                                        break;                                                            	
                                                }
                                
                                            }
                                        </script>
                                        
                                        <div id="divParticipants" style="height:100%;width:100%;padding-top:0px;">
                                            <div style="width:100%;height:100%;">
                                                <div> 
                                                    <div style="vertical-align:top;">
                                                        <div style="width:100%;height:100%;border-collapse:separate;" class="">
                                                            <div>
                                                                <div class='lefttdbg' style="text-align:left;padding:1px;" >
                                                                    <span class='description'><%=ResourceManager.GlobalResourceSet.GetString("Queue_ParticipantDesc")%></span>                                                                    
                                                                </div>
                                                            </div>
                                                            <div>
                                                                <div class='lefttdbg' style="text-align:center;height:100%">
                                                                    <div style="width:100%;height:95%;">
                                                                        <div style="vertical-align:top">
                                                                            <div  style="text-align:left;width:99%;height:75%;padding-top:2px;" class="lefttdbg">
                                                                                <!-- New Participant Grid -->
                                                                                <ISWebGrid:WebGrid ID="_WebGridParticipants" runat="server" HorizontalAlign="NotSet"
                                                                                    Height="95%" Width="100%"  AllowAutoDataCaching="false" DataCacheStorage="PageCache" DisableFileSystemChecking="true" EnableWebResources="never">
                                                                                    <LayoutSettings PagingMode="VirtualLoad" VirtualPageSize="20" AlwaysShowHelpButton="false" AllowSorting="Yes"
                                                                                        AllowExport="Yes" CellClickAction="RowSelect" UseRelativePositioning="true" PersistRowChecker="True"
                                                                                        AllowAddNew="No" AlternatingColors="True" GridLineStyle="Solid" GridLineColor="#afafaf"
                                                                                        CellPaddingDefault="2" RowHeightDefault="20px" GridLines="None" AutoFitColumns="true" RowHeaders="No">
                                                                                        <HeaderStyle CssClass="GridHeaderStyle"></HeaderStyle>
                                                                                        <FocusCellStyle CssClass="GridFocusCellStyle"></FocusCellStyle>
                                                                                        <GroupRowInfoStyle CssClass="GridGroupRowInfoStyle"></GroupRowInfoStyle>
                                                                                        <GroupByBox>
                                                                                            <LabelStyle CssClass="GridLabelStyle"></LabelStyle>
                                                                                        </GroupByBox>
                                                                                        <EditTextboxStyle CssClass="GridEditTextboxStyle"></EditTextboxStyle>
                                                                                        <FrameStyle GradientType="Vertical" CssClass="GridFrameStyle"></FrameStyle>
                                                                                        <SelectedRowStyle CssClass="GridSelectedRowStyle"></SelectedRowStyle>
                                                                                        <LostFocusRowStyle CssClass="LostFocusRowStyle"></LostFocusRowStyle>
                                                                                        <AlternatingRowStyle CssClass="GridAlternatingRowStyle" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden"></AlternatingRowStyle>
                                                                                        <StatusBarStyle CssClass="GridStatusBarStyle">
                                                                                            <Padding Top="2px" Left="2px" Bottom="2px" Right="2px"></Padding>
                                                                                        </StatusBarStyle>
                                                                                        <StatusBarCommandStyle Active-CssClass="GridStatusBarStyle" Normal-CssClass="GridStatusBarStyle" Over-CssClass="GridStatusBarStyle">
                                        </StatusBarCommandStyle>
                                                                                        <RowStyle CssClass="GridRowStyle" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden"></RowStyle>
                                                                                        <NewRowStyle CssClass="GridNewRowStyle"></NewRowStyle>
                                                                                        <EditFocusCellStyle CssClass="GridEditFocusCellStyle"></EditFocusCellStyle>
                                                                                        <ClientSideEvents OnRowContextMenu="HandleRowContextMenu" OnInitialize="HidePadColumn" OnColumnSort="OnWebgridColumnSort"/>
                                                                                        <TextSettings Language="UseCulture"></TextSettings>
                                                                                        <ImageSettings RefreshImage="<%$ ReplaceTemplateExpn:Grid/images/refresh.png%>" MoreDataImage="<%$ ReplaceTemplateExpn:Grid/images/LoadMoreData.png%>"
                                            ExportImage="<%$ ReplaceTemplateExpn:Grid/images/Export.png%>"/>
                                                                                    </LayoutSettings>
                                                                                    <RootTable GridLineStyle="NotSet">
                                                                                        <TableHeaderStyle GradientType="Vertical" CssClass="GridTableHeaderStyle">
                                                                                            <Padding Bottom="4px" Left="4px" Top="4px" Right="4px"></Padding>
                                                                                        </TableHeaderStyle>
                                                                                    </RootTable>
                                                                                </ISWebGrid:WebGrid>
                                                                                <!-- END New Participant Grid -->
                                                                            </div>
                                                                            
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div style="width:70%;">
                                                                 <div>
                                                                                <table style="width:99%;text-align:left;border-collapse:separate;border-spacing:1px;" >
                                                                                    <tr>
                                                                                        <td class="lefttdbg" style="font-weight:bold">
                                                                                            <span class="description"><%=ResourceManager.GlobalResourceSet.GetString("Queue_Q.O")%></span>
                                                                                        </td>
                                                                                        <td class="lefttdbg" style="white-space:nowrap;">
                                                                                            <span class="description"><%=ResourceManager.GlobalResourceSet.GetString("Queue_QueueOwner")%></span>
                                                                                        </td>
                                                                                        <td class="lefttdbg" style="font-weight:bold">
                                                                                            <span class="description"><%=ResourceManager.GlobalResourceSet.GetString("Queue_V.Q")%></span>
                                                                                        </td>
                                                                                        <td class="lefttdbg" style="white-space:nowrap;">
                                                                                            <span class="description"><%=ResourceManager.GlobalResourceSet.GetString("Queue_ViewQueue")%></span>
                                                                                        </td>
                                                                                        <td class="lefttdbg" style="font-weight:bold">
                                                                                            <span class="description"><%=ResourceManager.GlobalResourceSet.GetString("Queue_V.A.I")%></span>
                                                                                        </td>
                                                                                        <td class="lefttdbg" style="white-space:nowrap;">
                                                                                            <span class="description"><%=ResourceManager.GlobalResourceSet.GetString("Queue_ViewAllocatedItem")%></span>
                                                                                        </td> 
                                                                                        <td class="lefttdbg" style="font-weight:bold">
                                                                                            <span class="description"><%=ResourceManager.GlobalResourceSet.GetString("Queue_A.D.P.T")%></span>
                                                                                        </td>
                                                                                        <td class="lefttdbg" style="white-space:nowrap;">
                                                                                            <span class="description"><%=ResourceManager.GlobalResourceSet.GetString("Queue_AdHocPickTask")%></span>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td class="lefttdbg" style="font-weight:bold">
                                                                                            <span class="description"><%=ResourceManager.GlobalResourceSet.GetString("Queue_P.Q")%></span>
                                                                                        </td>
                                                                                        <td class="lefttdbg" style="white-space:nowrap;">
                                                                                            <span class="description"><%=ResourceManager.GlobalResourceSet.GetString("Queue_PlanQueueItem")%></span>
                                                                                        </td>
                                                                                        <td class="lefttdbg" style="font-weight:bold">
                                                                                            <span class="description"><%=ResourceManager.GlobalResourceSet.GetString("Queue_P.B.Q")%></span>
                                                                                        </td>
                                                                                        <td class="lefttdbg" style="white-space:nowrap;">
                                                                                            <span class="description"><%=ResourceManager.GlobalResourceSet.GetString("Queue_PutBackInQueue")%></span>
                                                                                        </td>
                                                                                        <td class="lefttdbg" style="font-weight:bold">
                                                                                            <span class="description"><%=ResourceManager.GlobalResourceSet.GetString("Queue_M.D.Q")%></span>
                                                                                        </td>
                                                                                        <td class="lefttdbg" style="white-space:nowrap;">
                                                                                            <span class="description"><%=ResourceManager.GlobalResourceSet.GetString("Queue_MoveToDifferentQueue")%></span>
                                                                                        </td>
                                                                                        <td class="lefttdbg" style="white-space:nowrap;">
                                                                                        </td>
                                                                                        <td class="lefttdbg" style="white-space:nowrap;">
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </div>
                                                            </div>
                                                            <br /><br />
                                                            <div>
                                                                <div style="text-align:right" class="lefttdbg">
                                                                        <div>
                                                                            <div style="text-align:right;float:right; width:98%">
                                                                                 
                                                                                <input type="button" name="btnAddExpression" id="btnAddExpression" value="<%=ResourceManager.GlobalResourceSet.GetString("Queue_AddRoles")%>"
                                                                                    class="inputbutton" onclick="javascript:OpenWindow('roleList')" title="<%=ResourceManager.GlobalResourceSet.GetString("Queue_AddRoles")%>" />
                                                                                
                                                 <telerik:RadWindowManager ID="RadWindowManager1" Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false"
                                                 runat="server" Behaviors="Close, Move" DestroyOnClose="true" Overlay="false" RenderMode="Classic" VisibleStatusbar="false">    
                                                </telerik:RadWindowManager>
                                                                               
                                                                                <%-- <asp:ImageButton id="btnAddFilre" runat="server" ImageUrl="<%$ ReplaceTemplateExpn:HWS/Images/Add-User.png %>"
                                         OnClientClick="OpenWindow('UserList'); return false"/>--%>
                                                                                <input type="button" name="btnAddFilre" id="btnAddFilre" value="<%=ResourceManager.GlobalResourceSet.GetString("Queue_AddUsers")%>"
                                                                                    class="inputbutton" onclick="javascript:OpenWindow('UserList')" title="<%=ResourceManager.GlobalResourceSet.GetString("Queue_AddUsers")%>" />
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                                </div>
                                                        </div>
                                                    </div>
                                                </div>
                                        <%--</div>--%>
                                    </telerik:RadPageView>
                                    <script  type="text/javascript">
                                        //ResizeParticipants();
                                        function ResizeParticipants() {
                                            //                            if (document.body.clientHeight > 800) {
                                            var QueueHeights = '<%=QHeight%>';
                                            var divParticipants = document.getElementById("divParticipants");
                                            divParticipants.style.height = document.body.clientHeight * QueueHeights / 100 - (document.body.clientHeight * 10 / 100);
                                            //                            }
                                        }
                                    </script>
                                    <telerik:RadPageView runat="server" ID="Setting" >

                                        <%
                            if (Request.QueryString["RoleUsers"] == null && Request.QueryString["accessrights"] == null && Request.QueryString["roleList"] == null && Request.QueryString["UserList"] == null)
                            { %>

                                        <table style="width:95%;margin:0px auto;width:100%;height:100%;border-collapse:separate;border-spacing:1px;" class="">
                                            <tr>
                                                <td class='lefttdbg' style="padding:3px;text-align:left;">
                                                    <span class='description'><%=ResourceManager.GlobalResourceSet.GetString("Queue_SettingsDes")%></span>
                                                    
                                                </td>
                                            </tr>

                                        </table>
                                        <div id="divSettings" style="overflow-x:hidden; height:80%;padding-left:5px;position:absolute;">                                            
                                            <table style="height:30%;border-collapse:separate;border-spacing:1px;width:98%;" class="tablebg" border="0">
                                                <tr style="width:100%;">
                                                    <td class="lefttdbg" style="width:40%;vertical-align:top;text-align:left;">
                                                        <span class="subtitle">
                                                            <%=ResourceManager.GlobalResourceSet.GetString("Queue_QueuePreference")%>
                                                        </span>
                                                        <br />
                                                        <span class='description'><%=ResourceManager.GlobalResourceSet.GetString("Queue_QueuePreferenceDesc")%></span>
                                                    </td>
                                                    <td class="lefttdbg" style="width:60%;vertical-align:top;text-align:left;">
                                                        <table style="width:100%;height:100%;" class="righttdbg" id="Table15" >
                                                            <tr>
                                                                <td class="" style="width:40%;vertical-align:top;text-align:left;">
                                                                    <asp:CheckBox ID="_ChkResourceAvl" runat="server" CssClass="inputcheckbox" onclick="cc();" />
                                                                    <span class="description" style="padding-bottom:5px;"><%=ResourceManager.GlobalResourceSet.GetString("Queue_CheckResourceAvailibilityDuringAutoDispatch")%></span>
                                                                </td>
                                                                       <td style="width:5%;text-align:right;vertical-align:top;">
                                                                                <asp:RadioButton ID="_RdoManulDispatch" CssClass="inputradio" GroupName="_ResourceUnAvailDispatch" runat="server" /></td>
                                                                            <td style="text-align:left;vertical-align:top;"><span class="description"><%=ResourceManager.GlobalResourceSet.GetString("Queue_DoManualDispatch")%></span></td>
                                                                        
                                                                            <td style="width:5%;text-align:right;vertical-align:top;">
                                                                                <asp:RadioButton ID="_RdoResourceUnAvailable" CssClass="inputradio" GroupName="_ResourceUnAvailDispatch"  runat="server" /></td>
                                                                            <td style="text-align:left;vertical-align:top;" >
                                                                                <span class="description"><%=ResourceManager.GlobalResourceSet.GetString("Queue_Fireactionoutput")%></span>
                                                                            </td>

                                                            </tr>
                                                            <asp:CheckBox ID="_ChkOwnerShipMan" runat="server" CssClass="inputcheckbox" Checked="false" Visible="false" />                                                                                                                       
                                                            
                                                        </table>

                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="lefttdbg" style="width:40%">
                                                        <span class="description" style="visibility: hidden;">Check the box to enable actor availability. Choose from the two dispatch options given. Check the box to enable actor availability. Choose from the two dispatch options. </span>
                                                    </td>
                                                    <td class="lefttdbg" style="text-align:right;width:60%;padding-right:20px;">
                                                        <asp:Button ID="BtnSettingUpdate" runat="server"  CssClass="inputbutton"
                                                            OnClick="BtnSettingUpdateClick" />
                                                    </td>
                                                </tr>                                                                                              
                                            </table>
                                            <table style="height:70%;border-collapse:separate;border-spacing:1px;width:99%;vertical-align:top;" class="" border="0">
                                                 <tr>
                                                    <td class="lefttdbg" colspan="2" style="text-align:left;width:100%;vertical-align:top;height:50%">
                                                        <div id="layoutctrldiv" runat="server" style="overflow:auto;">
                                                            <cc1:WorkListLayoutControl ID="WorkListLayoutControl1" runat="server" EnableClose="False"
                                                                BorderWidth="0"  AutoFitColumns="true"/>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <%  }    %>
                                    </telerik:RadPageView>


                                    <script  type="text/javascript">
                                        //ResizeSettings();
                                        //function ResizeSettings() {
                                        //                       var QueueHeights = '<%=QHeight%>';
                                        //                           var divSettings = document.getElementById("divSettings");
                                        //                           var height = document.body.clientHeight * QueueHeights / 100;
                                        //                           divSettings.style.height = height - (height * 20 / 100);
                                        //}
                                        //to adjust the workitem layout control height and width according to the screen resolution.
                                        //ResizeWorkListLayoutControl();
                                        function ResizeWorkListLayoutControl() {
                                            var workListLayoutDiv = document.getElementById("<%=layoutctrldiv.ClientID%>");     
                                            if(workListLayoutDiv)
                                            {   
                                                var isFromSp = "<%=IsFromSharePointUI%>";
                                                if(isFromSp == "True")
                                                {
                                                    //workListLayoutDiv.style.height = document.body.clientHeight - (document.body.clientWidth * 30 / 100); //305;//286
                                                    //workListLayoutDiv.style.width = document.body.clientWidth - (document.body.clientWidth * 2 /100);
                                                }
                                                else
                                                {
                                                    //workListLayoutDiv.style.height ="200px";// document.body.clientHeight - (document.body.clientHeight * 35 / 100); //430;
                                                    //workListLayoutDiv.style.width = "200px";//document.body.clientWidth - (document.body.clientWidth * 1 / 100);
                                                }
                         
                                                //workListLayoutDiv.style.overflow="auto";                        
                                            }
                                        }
                                        cc();     
                                        function cc()
                                        {
                    
                                            if(document.getElementById('<%=_ChkResourceAvl.ClientID%>').checked==true)
                                            {
                                                document.getElementById('<%=_RdoManulDispatch.ClientID%>').disabled=false;
                                                document.getElementById('<%=_RdoResourceUnAvailable.ClientID%>').disabled=false;
                                                if(document.getElementById('<%=_RdoManulDispatch.ClientID%>').checked==false && document.getElementById('<%=_RdoResourceUnAvailable.ClientID%>').checked==false)
                                                {                        
                                                    document.getElementById('<%=_RdoManulDispatch.ClientID%>').checked=true;
                       }
                   }
                   else
                   {
                       document.getElementById('<%=_RdoManulDispatch.ClientID%>').disabled=true;
                                                document.getElementById('<%=_RdoResourceUnAvailable.ClientID%>').disabled=true;
                                                document.getElementById('<%=_RdoManulDispatch.ClientID%>').checked=false;
                                                document.getElementById('<%=_RdoResourceUnAvailable.ClientID%>').checked=false;
                                            }
                                        }
                                        function closewindow()
                                        {
               
                                            if('<%=Request.QueryString.Count %>'==2)
                   {
                       window.close();
                   }
               }
                                    </script>

                                    <telerik:RadPageView runat="server" ID="DispatchPatterns" Height="70%">

                                        <table style="width:100%;" class="">
                                            <tr>
                                                <td class='lefttdbg' style="text-align:left;padding:1px;" >
                                                    <span class='description'>
                                                        <%=ResourceManager.GlobalResourceSet.GetString("Queue_DispatchPatternDesc")%>
                                                    </span>                                                    
                                                </td>
                                            </tr>
                                        </table>
                                        <div id="divDispatchPattern" style="overflow:auto;height:80%;width:100%;">
                                            <table style="width:100%;height:100%;border-collapse:separate;border-spacing:1px;" class="tablebg" border="0">
                                                <tr>
                                                    <td class="lefttdbg" colspan="2" style="padding:8px;text-align:left;">
                                                        <span class="subtitle"><%=ResourceManager.GlobalResourceSet.GetString("Queue_AutomaticDispatch")%></span>
                                                        <br />
                                                        <span class='description'><%=ResourceManager.GlobalResourceSet.GetString("Queue_AutomaticDispatchDesc")%></span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="padding:8px;width:50%;text-align:left;" class="lefttdbg">
                                                        <span class="subtitle"><%=ResourceManager.GlobalResourceSet.GetString("Queue_SimilarRepetitiveTasks")%></span>
                                                        <br />
                                                        <span class="description"><%=ResourceManager.GlobalResourceSet.GetString("Queue_SimilarRepetitiveTasks_desc")%></span>
                                                    </td>
                                                    <td style="padding:8px;text-align:left;" class="righttdbg">
                                                        <asp:CheckBox runat="server" CssClass="inputcheckbox" ID="_ChkSimilarTasks" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="lefttdbg" style="padding:8px;text-align:left;"><span class="subtitle"><%=ResourceManager.GlobalResourceSet.GetString("Queue_MatchingGlobalField")%></span>
                                                        <br />
                                                        <span class='description'><%=ResourceManager.GlobalResourceSet.GetString("Queue_MatchingGlobalFieldDesc")%></span>
                                                    </td>
                                                    <td class="righttdbg" style="padding:8px;text-align:left;">
                                                        <asp:DropDownList ID="_DdlMatchGlobalField" runat="server" CssClass="inputselect">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="lefttdbg" style="padding:8px;text-align:left;"><span class="subtitle"><%=ResourceManager.GlobalResourceSet.GetString("Queue_SearchIn")%></span>
                                                        <br />
                                                        <span class='description'><%=ResourceManager.GlobalResourceSet.GetString("Queue_SearchInDesc")%></span>
                                                    </td>
                                                    <td style="height:25px" class="righttdbg">
                                                        <table style="width:40%" border="0">
                                                            <tr>
                                                                <td style="width:2%">
                                                                    <asp:RadioButton ID="_RdoQueue" CssClass="inputradio" runat="server" GroupName="_RdoGroup1" Checked="true" />
                                                                </td>
                                                                <td style="width:15%;text-align:left;"><span class="description"><%=ResourceManager.GlobalResourceSet.GetString("Queue_Queue")%></span></td>
                                                                <td style="width:2%">
                                                                    <asp:RadioButton ID="_RdoActivityList" CssClass="inputradio" GroupName="_RdoGroup1" runat="server" /></td>
                                                                <td style="width:21%;text-align:left;"><span class="description"><%=ResourceManager.GlobalResourceSet.GetString("Queue_Workitem")%></span></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="lefttdbg" style="vertical-align:top;padding:8px;text-align:left;"><span class="subtitle"><%=ResourceManager.GlobalResourceSet.GetString("Queue_providerType")%></span>
                                                        <br />
                                                        <span class='description'><%=ResourceManager.GlobalResourceSet.GetString("Queue_providerTypeDesc")%></span>
                                                    </td>
                                                    <td style="height:25px" class="righttdbg">

                                                        <%=AutoDispatchData%>
                                                       
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td class="lefttdbg" colspan="2" style="vertical-align:top;padding:8px;text-align:left;">
                                                        <span class="subtitle"><%=ResourceManager.GlobalResourceSet.GetString("Queue_ManualDispatch")%></span>
                                                        <br />
                                                        <span class='description'><%=ResourceManager.GlobalResourceSet.GetString("Queue_ManualDispatchDesc")%></span>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td class="lefttdbg" style="width:50%;text-align:left;padding:8px;">

                                                        <span class="subtitle"><%=ResourceManager.GlobalResourceSet.GetString("Queue_ShowGetNextIteminWorkitem")%></span>
                                                        <br />
                                                        <span class="description"><%=ResourceManager.GlobalResourceSet.GetString("Queue_ShowGetNextIteminWorkitemDesc")%></span>
                                                    </td>
                                                    <td class="righttdbg" style="text-align:left;">
                                                        <asp:CheckBox ID="_ChkGetNextItem" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="lefttdbg" style="text-align:left;padding:8px;">
                                                        <span class="subtitle">
                                                            <%=ResourceManager.GlobalResourceSet.GetString("Queue_SetGetNextItemProperties")%>
                                                        </span>
                                                        <br />
                                                        <span class="description">
                                                            <%=ResourceManager.GlobalResourceSet.GetString("Queue_DoOrderBy")%></span>
                                                        <br />
                                                        <span class='description'><%=ResourceManager.GlobalResourceSet.GetString("Queue_DoOrderByDesc")%></span>
                                                    </td>
                                                    <td class="righttdbg" style="text-align:left;padding:8px;">
                                                        <asp:DropDownList ID="_DdlOrderBy" runat="server" Width="340px" CssClass="inputselect">
                                                        </asp:DropDownList>
                                                        <asp:DropDownList ID="_DdlSort" runat="server" CssClass="inputselect">
                                                        </asp:DropDownList><br />
                                                        <div style="text-align:left; padding-top:5px;"><input type="button" id="BtnClear" value="<%=ResourceManager.GlobalResourceSet.GetString("Queue_Clear")%>"
                                                            class="inputsecondarybutton" onclick="ClearValue();" />&nbsp;
                                                        <input type="button" id="BtnSet" value="<%=ResourceManager.GlobalResourceSet.GetString("Queue_Set")%>"
                                                            class="inputbutton" onclick="SetOrderybyValue();" /></div>
                                                        <br />
                                                        <br />
                                                        <%=OrderByStr%></td>
                                                    <%--</td>--%>
                                                </tr>

                                                <tr>
                                                    <td class="lefttdbg" style="text-align:left;padding:8px;">
                                                        <span class="subtitle">
                                                           <%=ResourceManager.GlobalResourceSet.GetString("Queue_providerType")%></span>
                                                        <br />
                                                        <span class='description'><%=ResourceManager.GlobalResourceSet.GetString("Queue_ManualProviderTypeDesc")%></span>
                                                    </td>
                                                    <td class="righttdbg">
                                                        <%=ManualDispatchData%>
                                                    </td>

                                                </tr>
                                            </table>
                                        </div>

                                        <table style="width:100%;margin:0px auto;"  class="lefttdbg">
                                           
                                             <tr>
                                                <td style="text-align:right;padding-top:10px;">
                                                    <asp:Button id="btnDispatch" runat="server" CssClass="inputbutton" 
                                         OnClick="btnDispatch_click" />
                                                </td>

                                            </tr>

                                        </table>

                                        <script type="text/javascript">

                                            //loadCheckGetNextItem();      
                                            //to set the horizantal scroll bar for dispatch pattern          
                                            //ResizeDispatchPatterns();
                                            function ResizeDispatchPatterns() {
                                                //divDispatchPattern
                                                //debugger;
                                                var dispatchPatternDiv = document.getElementById("divDispatchPattern");

                                                if (dispatchPatternDiv) 
                                                {
                                                    var isFromSp = "<%=IsFromSharePointUI%>";
                                                    if (isFromSp == "True") {
                                                        dispatchPatternDiv.style.height = document.body.clientHeight - 148;
                                                    }
    
                                                    var QHeights = '<%=QHeight%>';

                                                    var heightType = '<%=_QControl.QueueControlHeight.Type %>';
                                                    if (QHeights == '0') 
                                                    {
                                                        //dispatchPatternDiv.style.height = document.body.clientHeight * QHeights / 100;
                                                        if (isFromSp != "True") {
                                                            //dispatchPatternDiv.style.height = QHeights;//commented not working in firefox3.6
                                                        }
                                                    }
                                                    else if(heightType == 'Percentage')
                                                        dispatchPatternDiv.style.height = document.body.clientHeight * QHeights / 100 - (document.body.clientHeight * 10 / 100);
                                                    else
                                                        dispatchPatternDiv.style.height = QHeights - (document.body.clientHeight * 10 / 100);

                                                    if(isFromSp !== "True" && QHeights==0)
                                                    {
                                                        //dispatchPatternDiv.style.height = document.body.clientHeight - (document.body.clientHeight * 45 / 100);
                                                        var qControlHeight = parseInt(document.getElementById("<%=_QControl.ClientID%>").style.height);
                                                        var dispatchPattenDivHeight;
                                                        if (qControlHeight > 500)
                                                            dispatchPattenDivHeight = qControlHeight * 62 / 100 + 'px';
                                                        else
                                                            dispatchPattenDivHeight = qControlHeight * 32 / 100 + 'px';
                                                        dispatchPatternDiv.style.height = dispatchPattenDivHeight;
                                                    }
                                                    else
                                                    {
                                                        var qControlHeight = document.body.clientHeight* 55/100;
                                                        dispatchPatternDiv.style.height = qControlHeight;
                                                    }
        
                                                    dispatchPatternDiv.style.overflow = "auto";
                                                }
                                            }
                                            // After 1 second Queue control height will be available, hence call the function to set dispatchpattern height
                                            //window.setTimeout(ResizeDispatchPatterns, 500);
                                            function loadCheckGetNextItem()
                                            {
                                                var m = document.getElementsByName("PullDispatch");
                                                if(m[0])
                                                {
                                                    if(m[0].checked)
                                                        checkGetNextItem(1)
                                                    else
                                                        checkGetNextItem(2)
                                                }
                                            }   
                                            function checkGetNextItem(stat)
                                            {
                                                if(stat==1)
                                                {
                                                    document.getElementById('<%=_ChkGetNextItem.ClientID%>').checked=false;
                                                    document.getElementById('<%=_ChkGetNextItem.ClientID%>').disabled=true;
                                                }       
                                                else if(stat==2)
                                                {
                                                    document.getElementById('<%=_ChkGetNextItem.ClientID%>').checked=true;
        document.getElementById('<%=_ChkGetNextItem.ClientID%>').disabled=false;
    }       
}
		
		 
function openlinkinnewwindow(str)
{

}		
	
function SetOrderybyValue()
{
    n1=document.getElementById('<%=_DdlOrderBy.ClientID%>').selectedIndex; 
    if(n1>0)
    {
    
        n2=document.getElementById('<%=_DdlSort.ClientID%>').selectedIndex; 
        if(document.getElementById("OrderByText").value=="")
        {
            document.getElementById("OrderByText").value=document.getElementById('<%=_DdlOrderBy.ClientID%>').options[n1].value + " "+ document.getElementById('<%=_DdlSort.ClientID%>').options[n2].text.replace('Asc','');
            document.getElementById("OrderByTextArea").value=document.getElementById('<%=_DdlOrderBy.ClientID%>').options[n1].text + " "+ document.getElementById('<%=_DdlSort.ClientID%>').options[n2].text.replace('Asc','');
        }            
        else
        {
            document.getElementById("OrderByText").value+=","+document.getElementById('<%=_DdlOrderBy.ClientID%>').options[n1].value + " "+ document.getElementById('<%=_DdlSort.ClientID%>').options[n2].text.replace('Asc','');
            document.getElementById("OrderByTextArea").value+=","+document.getElementById('<%=_DdlOrderBy.ClientID%>').options[n1].text + " "+ document.getElementById('<%=_DdlSort.ClientID%>').options[n2].text.replace('Asc','');
        }            

        
    }    
}
		
function ClearValue()
{
    document.getElementById("OrderByText").value="";
    document.getElementById("OrderByTextArea").value="";
    
}

                                        </script>

                                    </telerik:RadPageView>
                                    <telerik:RadPageView runat="server" ID="Escalation">
                                        <div id="divEscalation" style="height: 100%; overflow: hidden;">
                                            <table style="width:100%;border-collapse:collapse;border-spacing:1px;height: 100%">
                                                <tr>
                                                    <td class='lefttdbg' style="padding:1px;text-align:left;">
                                                        <span class="description">
                                                            <%=ResourceManager.GlobalResourceSet.GetString("Queue_EscalationDesc")%></span>
                                                        
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="padding:1px;">

                                                        <table border="0" style="margin:0px auto;">
                                                            <tr>
                                                                <td style="text-align:left;width:100%;">
                                                                    <!--     *********** Esclation Grid***********************       -->
                                                                    <ISWebGrid:WebGrid ID="_WebGridEsclation" runat="server" HorizontalAlign="NotSet"
                                                                        AllowAutoDataCaching="false" ViewStateStorage="None" Width="100%" Height="100%" DisableFileSystemChecking="true" EnableWebResources="never">
                                                                        <LayoutSettings PagingMode="VirtualLoad" VirtualPageSize="20" AlwaysShowHelpButton="false"
                                                                            AllowExport="Yes" CellClickAction="RowSelect" UseRelativePositioning="true" PersistRowChecker="True" AllowSorting="Yes"
                                                                            AllowAddNew="No" AlternatingColors="True" GridLineStyle="Solid" GridLineColor="#afafaf"
                                                                            CellPaddingDefault="2" RowHeightDefault="20px" GridLines="None" RowHeaders="No" AutoFitColumns="true">
                                                                            <HeaderStyle CssClass="GridHeaderStyle"></HeaderStyle>
                                                                            <FocusCellStyle CssClass="GridFocusCellStyle"></FocusCellStyle>
                                                                            <FrameStyle CssClass="GridFrameStyle"></FrameStyle>
                                                                            <SelectedRowStyle CssClass="GridSelectedRowStyle"></SelectedRowStyle>
                                                                            <LostFocusRowStyle CssClass="LostFocusRowStyle"></LostFocusRowStyle>
                                                                            <AlternatingRowStyle CssClass="GridAlternatingRowStyle" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" ></AlternatingRowStyle>
                                                                            <StatusBarStyle CssClass="GridStatusBarStyle">
                                                                                <Padding Top="2px" Left="2px" Bottom="2px" Right="2px"></Padding>
                                                                            </StatusBarStyle>
                                                                            <StatusBarCommandStyle Active-CssClass="GridStatusBarStyle" Normal-CssClass="GridStatusBarStyle" Over-CssClass="GridStatusBarStyle">
                                                                            </StatusBarCommandStyle>
                                                                            <RowStyle CssClass="GridRowStyle" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" ></RowStyle>
                                                                            <NewRowStyle CssClass="GridNewRowStyle"></NewRowStyle>
                                                                            <EditFocusCellStyle CssClass="GridEditFocusCellStyle"></EditFocusCellStyle>
                                                                            <ClientSideEvents OnRowContextMenu="HandleRowContextMenuEscalation" OnInitialize="HidePadColumn" OnColumnSort="OnWebgridColumnSort"  />
                                                                            <TextSettings Language="UseCulture"></TextSettings>
                                                                            <ImageSettings RefreshImage="<%$ ReplaceTemplateExpn:Grid/images/refresh.png%>" MoreDataImage="<%$ ReplaceTemplateExpn:Grid/images/LoadMoreData.png%>"
                                            ExportImage="<%$ ReplaceTemplateExpn:Grid/images/Export.png%>"/>
                                                                        </LayoutSettings>
                                                                        <RootTable GridLineStyle="NotSet">
                                                                            <TableHeaderStyle GradientType="Vertical" CssClass="GridTableHeaderStyle">
                                                                                <Padding Bottom="4px" Left="4px" Top="4px" Right="4px"></Padding>
                                                                            </TableHeaderStyle>
                                                                        </RootTable>
                                                                    </ISWebGrid:WebGrid>
                                                                    <!--
                                                  <div id=divgridmulti style="TOP: 40px">&nbsp;</DIV>  -->
                                                                </td>
                                                            </tr>
                                                        </table>

                                                    </td>
                                                </tr>

                                            </table>
                                        </div>
                                        <%--<br /><br />--%>

                                        <table style="width:100%">

                                            <tr>

                                                <td class="lefttdbg" style="height:15px;text-align:right;padding-right:17px">
                                                    <input type="button" name="btnAddEscalation" onclick="AddNewEscalation()" id="btnAddEscalation"
                                                        value='<%=ResourceManager.GlobalResourceSet.GetString("Queue_AddEscalation")%>' title="<%=ResourceManager.GlobalResourceSet.GetString("Queue_AddEscalation")%>" class="inputbutton" /></td>
                                                        <%--<asp:ImageButton id="btnAddEscalation" runat="server" ImageUrl="<%$ ReplaceTemplateExpn:Common/Images/Add.png %>"
                                         OnClientClick="AddNewEscalation(); return false;"/>
                                                </td>--%>
                                            </tr>
                                        </table>

                                        <!--<table width="95%" border="3" align="center" cellpadding="0" cellspacing="0" id="Table17">
                                                        <tr>
                                                            <td height="10" align="center">
                                                                <div id="divescLevelMessage" style="display: none; position: relative; width: 100%">
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>-->
                                        <div id="divescalaltionAdd" style="display:none;position:relative;text-align:center">
                                            <table id="Table19" style="margin:0px auto;border-collapse:separate;border-spacing:1px;width:98%;" >
                                                <tr>
                                                    <td style="width:25%;vertical-align:top;text-align:left">Workflows
                                                    </td>
                                                    <td style="text-align:left">
                                                        <select class="select" name="selLevelwrkflow" id="selLevelwrkflow" runat="server">
                                                        </select>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width:25%;vertical-align:top;text-align:left">QueueItem Stages
                                                    </td>
                                                    <td style="text-align:left">
                                                        <select class="select" name="selLevel" onchange="EscalationTypes()">
                                                            <option value="Queue Item Created">Queue Item Created</option>
                                                            <option value="Queue Item Picked">Queue Item Picked</option>
                                                        </select>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width:25%;vertical-align:top;text-align:left">Escalation Time Inteval
                                                    </td>
                                                    <td style="text-align:left">
                                                        <input class="inputs" id="Text2" type="text" name="txtEscalationTimeInterval">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width:25%;text-align:left">Recurring
                                                    </td>
                                                    <td style="text-align:left">
                                                        <input id="Checkbox28" type="checkbox" name="chkRecuring">
                                                    </td>
                                                </tr>                                               
                                                <tr>
                                                    <td colspan="2" style="vertical-align:top;text-align:left" class="header2">Escalation Types
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2" style="vertical-align:top;">
                                                        <table style="width:100%"  id="Table20">
                                                            <tr>
                                                                <td style="padding:3px;width:5%">                                                                    
                                                                    <input id="chkReminderMessage" runat="server" type="checkbox">
                                                                </td>
                                                                <td style="width:25%;text-align:left">Reminder Message
                                                                </td>
                                                                <td style="text-align:left">
                                                                    <script type="text/javascript">
                                                                       
                                                                        function ShowEscalationReminder()
                                                                        {                                                                            
                                                                            var left;
                                                                            var top;
                                                                            left = (screen.width / 2) - (650 / 2);
                                                                            top = (screen.height / 2) - (200 / 2);   
                                                                            
                                                                            window.open('<%=_QControl.GetTemplateRelativeUrl("QueuePropertyPages/QueueEscalation.aspx")%>?pageview=remindermessagediv&rem=1&idTxt=txtReminderMsg','EscalationTypes',"top="+top+",left="+left+",height=200,width=650,resizable=yes,scrollbars=yes");
                                                                        }
                                                                        
                                                                    </script>
                                                                    <input class="inputbutton" id="btnReminder" style="visibility: hidden" onclick="javascript:ShowEscalationReminder();"
                                                                        type="button" value="Set Properties" name="btnReminder">
                                                                    <input type="hidden" id="txtReminderMsg" name="txtReminderMsg" />
                                                                    <input type="hidden" id="txtRemSubject" name="txtRemSubject" />
                                                                    <input type="hidden" id="txtRemNotes" name="txtRemNotes" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width:5%">
                                                                    <!-- <input id=Checkbox30    onclick="visibutton('chkNotification','btnNotification')"    type=checkbox  name=chkNotification> -->
                                                                    <input id="ChkNotification" runat="server" type="checkbox" name="chkNotification">
                                                                </td>
                                                                <td style="width:25%;text-align:left">Notification
                                                                </td>
                                                                <td style="text-align:left">

                                                                    <script type="text/javascript">
                                                                       
                                                                        function ShowNotificationReminder()
                                                                        {                                                                            
                                                                            var left;
                                                                            var top;
                                                                            left = (screen.width / 2) - (650 / 2);
                                                                            top = (screen.height / 2) - (200 / 2);   
                                                                            
                                                                            window.open('<%=_QControl.GetTemplateRelativeUrl("QueuePropertyPages/QueueEscalation.aspx")%>?pageview=remindermessagediv&rem=1&idTxt=txtNotification','EscalationTypes',"top="+top+",left="+left+",height=200,width=650,resizable=yes,scrollbars=yes");
                                                                        }
                                                                        
                                                                    </script>

                                                                    <input class="inputbutton" id="Button6" style="visibility: hidden" onclick="javascript:ShowNotificationReminder();"
                                                                        type="button" value="Set Properties" name="btnNotification">
                                                                    <input type="hidden" id="txtNotification" name="txtNotification" />
                                                                    <input type="hidden" id="txtNotifSubject" name="txtNotifSubject" />
                                                                    <input type="hidden" id="txtNotifNotes" name="txtNotifNotes" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width:5%">
                                                                    <!-- <input id=Checkbox31   onclick="visiList('chkMovetoQueue','listQueue')" type=checkbox  name=chkMovetoQueue> -->
                                                                    <input id="chkMoveToDifferentQueue" runat="server" type="checkbox" name="chkMovetoQueue">
                                                                </td>
                                                                <td style="width:35%;text-align:left">Move To Different Queue
                                                                </td>
                                                                
                                                                <td style="text-align:left">                                                                    
                                                                    <div id="Select2_Queue_div" style="visibility: Hidden">
                                                                        <select id="Select2_Queue" runat="server">
                                                                        </select>
                                                                    </div>                                                                    
                                                                    <a href="QueueView.aspx" style="visibility: Hidden" id="viewLink" onclick="popup = window.open('<%=_QControl.GetTemplateRelativeUrl("QueuePropertyPages/QueueView.aspx")%>', 'PopupPage', 'height=500,width=780,scrollbars=yes,resizable=yes'); return false"
                                                                        target="_blank">View</a>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width:5%">
                                                                    <!-- <input id=Checkbox32   onclick="visibutton('chkReassign','btnReassign')" type=checkbox  name=chkReassign> -->
                                                                    <input id="chkReassigns" runat="server" type="checkbox">
                                                                </td>
                                                                <td style="text-align:left">Re Assign
                                                                </td>
                                                                <td style="text-align:left">
                                                                    <input class="inputbutton" id="btnReassign" style="visibility: hidden" onclick="OpenReassign()"
                                                                        type="button" value="Set Properties" name="btnReassign">
                                                                    <input type="hidden" id="txtreassign" name="txtreassign" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width:5%">                                                                    
                                                                    <input id="chkTriggerEsc" runat="server" type="checkbox">
                                                                </td>
                                                                <td style="text-align:left">Trigger Escalate Output
                                                                </td>
                                                                <td style="text-align:left"></td>
                                            
                                                            </tr>
                                                            <tr>
                                                                <td style="width:5%">                                                                    
                                                                    <input id="chkCallworkflow" runat="server" type="checkbox" name="chkCallWF" />
                                                                </td>
                                                                <td style="text-align:left">Call a Workflow
                                                                </td>
                                                                <td style="text-align:left">
                                                                    <input class="inputbutton" id="Button14" style="visibility: hidden" onclick="javascript:window.open('<%=_QControl.GetTemplateRelativeUrl("QueuePropertyPages/QueueEscalation.aspx")%>    ?pageview=wftriggerdiv&idTxt=txtcallback','EscalationTypes','height=315,width=700,resizable=yes,scrollbars=yes','')"
                                                                        type="button" value="Set Properties" name="btnCallWF">
                                                                    <input type="hidden" id="txtcallback" name="txtcallback" />
                                                                    <input type="hidden" id="txtcalApplication" name="txtcalApplication" />
                                                                    <input type="hidden" id="txtcalWorkflow" name="txtcalWorkflow" />
                                                                    <input type="hidden" id="txtcalContent" name="txtcalContent" />
                                                                    <input type="hidden" id="txtcalVer" name="txtcalVer" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width:5%">                                                                    
                                                                    <input id="chkPutbackinQueue" runat="server" type="checkbox">
                                                                </td>
                                                                <td colspan="2" style="text-align:left">Put Back In Queue
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2" style="text-align:right">
                                                        <input type="button" runat="server" id="btnSaveEsc" onserverclick="btnSaveEsc_Click"
                                                            class="inputbutton" name="btnSaveEsc" value=" Save " /></td>
                                                </tr>
                                            </table>
                                            <br>
                                        </div>
                                        <!--    --------------------------------------------------------  -->
                                        <div id="divescalaltionEdit" style="display: none; position: relative; width: 100%; text-align: center;">
                                            <table style="width:94%;margin:0px auto;border-collapse:collapse;border-spacing:1px;" >
                                                <tr>
                                                    <td>
                                                        <input type="text" id="txtApplication" value='<%=_ApplicationName%>' />
                                                        <input type="text" id="txtQueueId" value='<%=_QueueGUID%>' />
                                                        <iframe id="ifEscalation" style="width: 100%; height: 250px;border:none;"></iframe>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </telerik:RadPageView>
                                    <script type="text/javascript">
                                        //ResizeEscalation();
                                        function ResizeEscalation() {
                                            var QueueHeights = '<%=QHeight%>';
                                            var divEscalation = document.getElementById("divEscalation");
                                            divEscalation.style.height = document.body.clientHeight * QueueHeights / 100 - (document.body.clientHeight * 10 / 100);
                                        }
                                    </script>
                                </telerik:RadMultiPage>

                                <script>


	                    
                                    //---------------------------------
                                    function OpenReassign()
                                    {
   
                                        var app=document.getElementById("txtApplication").value;
                                        var Guid=document.getElementById("txtQueueId").value;   
                                        window.open('<%=_QControl.GetTemplateRelativeUrl("QueuePropertyPages/QueueEscalation.aspx")%>?pageview=reassigndiv&reass=1&idTxt=txtreassign&appname='+app+'&guid='+Guid,'EscalationTypes','height=120,width=600,resizable=yes,scrollbars=yes')
    
                                    }
                                    function HideEditEscalation()
                                    {  
            
                                        javascript:document.getElementsByTagName('div')['divescalaltionEdit'].style.display='none';
                                        javascript:document.getElementsByTagName('div')['divescalaltionAdd'].style.display='none';
            
                                        //            var grid = ISGetObject("_WebGridEsclation");
                                        //            grid.RefreshAll();  
                                        try
                                        {
                                            var i=GetMOZBrowserversion();
                                            //  if(i==1)
                                            //  {
                                            var grid = ISGetObject("_WebGridEsclation");
                                            grid.Refresh();  
                                            //   }
                                            //   else
                                            //      window.location.href = window.location.href;
                                        }
                                        catch(e){}         
            
                                    }
         
                                    function AddNewEscalation()
                                    {
                                        
                                        var EscWinHt=0;
                                        var app=navigator.userAgent;
                                        if(app.indexOf("MSIE")>-1)
                                            EscWinHt = 490;//418;
                                        else 
                                            EscWinHt = 520;//415;

                                        var left = (screen.width / 2) - (800 / 2);
                                        var top = (screen.height / 2) - (EscWinHt / 2);
                                        
                                        var ApplicationName=document.getElementById("txtApplication").value;
                                        var QueuId=document.getElementById("txtQueueId").value; 
                                        javascript:window.open('<%=_QControl.GetEscalationURL("QueuePropertyPages/EscalationEdit.aspx")%>application='+ ApplicationName + '&QueID=' + QueuId + '&addnew=yes','',"top="+top+",left="+left+",height="+EscWinHt+",width=800,resizable=yes,scrollbars=yes");
                                    }         

                                    function AddEscalation()
                                    {
                                        EditEscalation("addnew")
                                    }
 
                                    function EditEscalation(selQName)
                                    {
   
                                        var EscWinHt=0;
                                        var app=navigator.userAgent;
                                        if(app.indexOf("MSIE")>-1)
                                            EscWinHt = 490;//418;
                                        else 
                                            EscWinHt = 520;//415;

                                        var left = (screen.width / 2) - (600 / 2);
                                        var top = (screen.height / 2) - (EscWinHt / 2);

                                        var objFrame=document.getElementById("ifEscalation");
                                        var ApplicationName=document.getElementById("txtApplication").value;
                                        var QueuId=document.getElementById("txtQueueId").value;
       
                                        javascript:window.open('<%=_QControl.GetEscalationURL("QueuePropertyPages/EscalationEdit.aspx")%>EscId=' + selQName + '&application='+ ApplicationName + '&QueID=' + QueuId + '&addnew=edit','',"top="+top+",left="+left+",height="+EscWinHt+",width=720,resizable=yes,scrollbars=yes");   
                                    }

                                    function DeleteEscalation(selEscGuid)
                                    {
                                        var urlStr = "<%=PreviousUrl%>";
                                        QueueName='<%=Microsoft.Security.Application.Encoder.UrlEncode(Microsoft.Security.Application.Encoder.JavaScriptEncode(strQueueName, false)) %>';
                                       // alert(urlStr+"qName="+QueueName+"&deleteEscalation=yes&EscalationID="+selEscGuid);
                                       javascript:location.href=urlStr+"qName="+QueueName+"&deleteEscalation=yes&EscalationID="+selEscGuid; 
       
                                    }
	               
	

		
                                </script>

                                <%}%>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
       <%-- <% if (Request.QueryString["RoleUsers"] == null && Request.QueryString["accessrights"] == null && Request.QueryString["roleList"] == null && Request.QueryString["UserList"] == null && !_PnlQueueMaster.Visible)
   {%>
        <tr>
            <td style="height: 25px; text-align: right; padding: 0px;width:100%;" class="footer" colspan="4"  id="Td1">
                <asp:ImageButton runat="server" ID="btnList" ImageUrl="<%$ ReplaceTemplateExpn:BAM/Images/zoom-popup.png%>"
                                         OnClick= "QueueMain_Click"/>&nbsp;
            </td>
        </tr>
        <%} %>--%>
        
    </table>
</div>
<!-- only scripts   -->

<script id="clientEventHandlersJS" type="text/javascript">

    var errMsg;    

    function linkOpen(selQName)
    {
        var urlStr = "<%=PreviousUrl%>";
        javascript:location.href=urlStr+"qName="+encodeURI(selQName); 
    }
    function DeleteOpen(selQName) {   
        var urlStr = "<%=PreviousUrl%>";
        javascript:location.href=urlStr+"qName="+selQName+"&delete=yes"; 
    }
    function PackageOpen(queueName, applicationName) 
    {
        var templateUrl = '<%=_QControl.TemplateDirectory%>';  
        var url = templateUrl + "Package/PackageList.aspx?&mode=Queue" + "&Name=" + queueName + "&AppName=" + applicationName;           
        var oWindow = radopen(url, null);
        oWindow.set_modal(true);
        oWindow.set_title("<%=ResourceManager.GlobalResourceSet.GetString("Queue_Package")%>");
        oWindow.setSize(590, 360);
    }



</script>

<script type="text/javascript">
    
   
    function HandleRowContextMenuEscalation(gridId, rowType, rowEl, rowMenu)
    {                         
        var row = wgGetGridById(gridId).GetSelectedObject().GetRowElement();              
        var columnname= "<%=ResourceManager.GlobalResourceSet.GetString("Queue_Escalation_EscalationStage")%>";
        var EditStr="<%=ResourceManager.GlobalResourceSet.GetString("Queue_Edit")%>";
        var DelStr="<%=ResourceManager.GlobalResourceSet.GetString("Queue_Delete")%>";
        var cell = row.cells[1];//wgGetCellByName(row, columnname); _WebGridParticipants
        var gid=cell.getAttribute("Escalation_ID");
        if (gid === null) {
            gid = row.cells[0].getAttribute("Escalation_ID");
        }

        var DisEsc='<%=_DisableEscalation%>';
        if (rowType == "Record")
        {
            //rowMenu.add( new MenuSeparator("_") );                     
            if(DisEsc!=1)
            {
                //rowMenu.add( new MenuItem(EditStr,function() {EditEscalation(gid);}, "" ));                         
                var menuItem = new WebMenuItem(); 
                menuItem.Text = EditStr;   
                menuItem.Name = "EditEscalation";   
                menuItem.OnClick = "EditEscalation('"+gid+"')";             
                //menuItem.ImageURL=imgfolder+"";
                rowMenu.Items.Add(menuItem);  

                          
                //rowMenu.add( new MenuItem(DelStr,function() {DeleteEscalation(gid);}, "" ));                         
                var menuItem = new WebMenuItem(); 
                menuItem.Text = DelStr;   
                menuItem.Name = "DeleteEscalation";   
                menuItem.OnClick = "DeleteEscalation('"+gid+"')";             
                //menuItem.ImageURL=imgfolder+"";
                rowMenu.Items.Add(menuItem); 
            } 
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
        //if(!IS.moz && !IS.ie){
        //    rowMenu.Show(location.X +250, location.Y + 160);
        //}
        
        return true;
    }
        function EscalationTypes()
        {
            var objEsc=document.getElementById("selLevel");
            
            if(objEsc.value=="Queue Item Created")
            { 
                document.getElementById('<%=chkReminderMessage.ClientID%>').disabled=true;
                document.getElementById('<%=chkPutbackinQueue.ClientID%>').disabled=true;
                document.getElementById('<%=chkReassigns.ClientID%>').disabled=true;
            }
            else
            {
                document.getElementById('<%=chkReminderMessage.ClientID%>').disabled=false;
                document.getElementById('<%=chkPutbackinQueue.ClientID%>').disabled=false;  
                document.getElementById('<%=chkReassigns.ClientID%>').disabled=false;  
            }
        }  
                
		
		    
        function showCustInfo(url) 
        { 
            //window.open(url,windowparams);
        }
	

        function OndblClick(gridId, rowType, rowEl, rowMenu)
        {
            var testGrid=wgGetGridById(gridId);
            var imgFolder=wgGetGridById(gridId,"/Folder");
        
            var selRow = testGrid.GetSelectedObject().GetRowElement();
            //var getNewQueue= document.getElementById('newQueueButton');
            //getNewQueue.style.display = 'none';
            //getNewQueue.style.visibility = 'hidden';

            var quenamecolname="<%=ResourceManager.GlobalResourceSet.GetString("Queue_Name")%>";
            var SelQName = wgGetCellByName(selRow, quenamecolname).innerText;
                    
            //Added for getting the queue name from custom attributes as multiple spaces between the queue names is
            //giving the problem while editing
            var queuedescriptioncolname="<%=ResourceManager.GlobalResourceSet.GetString("Queue_Description")%>";                    
            var descritpioncellvalue = wgGetCellByName(selRow, queuedescriptioncolname);
            if(descritpioncellvalue !=null)
            {
                var getqueuenamefromattributes = descritpioncellvalue.getAttribute("PassQName");
                if(getqueuenamefromattributes !=null)
                {
                    SelQName=getqueuenamefromattributes;
                }
            }
                    
            var Selcellvalue = wgGetCellByName(selRow, quenamecolname);
            var SelAcc = Selcellvalue.getAttribute("AllowAccess");
            if(SelAcc.substring(0,3)=="Yes")
            {
                linkOpen(SelQName);
            }   
            else if(SelAcc=="No")
            {
                        
               // alert("<%=ResourceManager.GlobalResourceSet.GetString("Queue_ThisuserdosntbelongtothisQueue")%>");
                se.ui.messageDialog.showAlert('<%=ResourceManager.GlobalResourceSet.GetString("Queue_Header")%>', '<%=ResourceManager.GlobalResourceSet.GetString("Queue_ThisuserdosntbelongtothisQueue")%>');
            }
        }
		   
        function WebGridQueEditMenu(gridId, rowType, rowEl, rowMenu)
        {
            var testGrid=wgGetGridById(gridId);
            var imgFolder=wgGetGridById(gridId,"/Folder");
            var selRow = testGrid.GetSelectedObject().GetRowElement();
            //var x= findClientPosX(rowMenu);
            //var y = findClientPosY(rowMenu);
            var quenamecolname="<%=ResourceManager.GlobalResourceSet.GetString("Queue_Name")%>";
                    
            var Selcellvalue = wgGetCellByName(selRow, quenamecolname);
            var SelAcc = Selcellvalue.getAttribute("AllowAccess");
                    
            var EditStr="<%=ResourceManager.GlobalResourceSet.GetString("Queue_Edit")%>";
                    
            var DeleteStr="<%=ResourceManager.GlobalResourceSet.GetString("Queue_Delete")%>";                  
            //Package
            var PackageStr="<%=ResourceManager.GlobalResourceSet.GetString("ecm_list_cm_package")%>";                                                          
            var SelQName = wgGetCellByName(selRow, quenamecolname).innerText;
                    
            //Added for getting the queue name from custom attributes as multiple spaces between the queue names is
            //giving the problem while editing
            var queuedescriptioncolname="<%=ResourceManager.GlobalResourceSet.GetString("Queue_Description")%>";                    
            var descritpioncellvalue = wgGetCellByName(selRow, queuedescriptioncolname);
            if(descritpioncellvalue !=null)
            {
                var getqueuenamefromattributes = descritpioncellvalue.getAttribute("PassQName");
                if(getqueuenamefromattributes !=null)
                {
                    SelQName=getqueuenamefromattributes;
                }
            }
                    
            if (rowType != "Record") return true;	
        
            if(rowType =="Record")
            {
                // hide the default context menu
                for (i=0;i<=43;i++)
                {                                          
                    rowMenu.Items[i].Hide();                          
                }                       
                                   
            } 
                    
                    
            if(SelAcc.substring(0,3) =="Yes" && rowType == "Record")
            {                                  
                //rowMenu.add( new MenuSeparator("_") );                                                    
                var EditimagePath = "<%=_QControl.GetTemplateRelativeUrl("images/icon-edit-right-click.png")%>";
                var DeleteimagePath = "<%=_QControl.GetTemplateRelativeUrl("images/icon-delete-right-click.png")%>";
                var PackageimagePath = "<%=_QControl.GetTemplateRelativeUrl("images/icon-package.png")%>";
                //rowMenu.add( new MenuItem(EditStr,function() {linkOpen(SelQName);},EditimagePath));
                var menuItem = new WebMenuItem(); 
                menuItem.Text = EditStr;   
                menuItem.Name = "linkOpen";   
                menuItem.OnClick = "linkOpen('"+SelQName+"')";             
                menuItem.ImageURL=EditimagePath;
                rowMenu.Items.Add(menuItem); 
                                         
                                         
                var separator = new WebMenuItem();
                separator.Type = "Separator";       
                separator.Name = "MySeparator";
                rowMenu.Items.Add(separator);
                                  
                //                          //Package Option
                //hiding Package context menu

                var application =  '<%=_ApplicationName%>';
                var packageItem = new WebMenuItem(); 
                packageItem.Text = PackageStr;   
                packageItem.Name = "PackageOpen";   
                packageItem.OnClick = "PackageOpen('"+SelQName+"','"+application+"')";             
                packageItem.ImageURL=PackageimagePath;                          
                rowMenu.Items.Add(packageItem);                                        
                var separator1 = new WebMenuItem();
                separator1.Type = "Separator";       
                separator1.Name = "MySeparator";
                rowMenu.Items.Add(separator1);
                
                if(SelAcc=="YesOwner" || SelAcc=="YesManageQueueRights")
                {
                    //rowMenu.add( new MenuItem(DeleteStr,function(){DeleteOpen(SelQName);},DeleteimagePath ));
                    var menuItem1 = new WebMenuItem(); 
                    menuItem1.Text = DeleteStr;   
                    menuItem1.Name = "DeleteOpen";   
                    menuItem1.OnClick = "DeleteOpen('"+SelQName+"')";             
                    menuItem1.ImageURL=DeleteimagePath;
                    rowMenu.Items.Add(menuItem1);                                                                        
                }     
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
            else if(SelAcc=="No")
            {
                //alert("<%=ResourceManager.GlobalResourceSet.GetString("Queue_ThisuserdosntbelongtothisQueue")%>");
                se.ui.messageDialog.showAlert('<%=ResourceManager.GlobalResourceSet.GetString("Queue_Header")%>', '<%=ResourceManager.GlobalResourceSet.GetString("Queue_ThisuserdosntbelongtothisQueue")%>');

                if (rowType == "Record")
                {
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


            }
            //if(!IS.moz && !IS.ie){
               
            //    // alert(+'----'+event.clientY);
            //    //rowMenu.Show();
            //}
            return true;
        }     
        function deleteparticipant(k1,k2,k3)
        {
            var urlStr = "<%=PreviousUrl%>";
            javascript:location.href=urlStr+"qName="+k1+"&deleteActorOrRoleName="+k2+"&UsrOrRole="+k3;
        }

    function SetPriorityForRole(url)
    {
        var oWindow = radopen(url, null);
        oWindow.set_modal(true);
        oWindow.set_title("<%=ResourceManager.GlobalResourceSet.GetString("Queue_RolePriority")%>");
        oWindow.setSize(480, 440);       
    }
		    
    function ChangeOwnerAsParticipant(k1,k2,k3,k4)
    {
        var urlStr = "<%=PreviousUrl%>";
        javascript:location.href=urlStr+"qName="+k1+"&ChangeRightsUsrOrRole="+k2+"&UsrOrRole="+k3+"&EnableAsParticipant="+k4;
    }
    function HandleRowContextMenu(gridId, rowType, rowEl, rowMenu)
    {          
          
            var testGrid=wgGetGridById(gridId);
            var imgFolder=wgGetGridById(gridId,"/Folder");
            var selRow = testGrid.GetSelectedObject().GetRowElement();
            var participantcolumnname =   "<%=ResourceManager.GlobalResourceSet.GetString("Queue_Participants")%>";                        
            var categorycolumnname =   "<%=ResourceManager.GlobalResourceSet.GetString("Queue_Category")%>";                        
            var QName='<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(strQueueName, false) %>';
            var CatName= "<%=ResourceManager.GlobalResourceSet.GetString("Queue_Category")%>";
            // var cellName = wgGetCellByName(selRow, "Category");
            var cellName = wgGetCellByName(selRow, CatName);
            var Id=cellName.getAttribute("hiddenData1");                
            var SelCategory=cellName.innerText;
                    
                  
            // var SelCategory = escape(wgGetCellByName(selRow, categorycolumnname).innerText);
            var k0 = wgGetCellByName(selRow, participantcolumnname);
            var SelVirActID = k0.getAttribute("VirtualActorId");
            var DeleteStr="<%=ResourceManager.GlobalResourceSet.GetString("Queue_Delete")%>";
                    
            var urlStr = "<%=PreviousUrl%>";

            var SetAccStr="<%=ResourceManager.GlobalResourceSet.GetString("Queue_SetAccessRights")%>";
                    
            var ViewUsr="<%=ResourceManager.GlobalResourceSet.GetString("Queue_ViewUsers")%>";
                    
            var ConsAsPart="<%=ResourceManager.GlobalResourceSet.GetString("Queue_ConsiderasParticipant")%>";
        var DonotConAsPart="<%=ResourceManager.GlobalResourceSet.GetString("Queue_DonotConsiderasParticipant")%>";

        var SetPriorityContextMenuText="<%=ResourceManager.GlobalResourceSet.GetString("Queue_RolePriorityContextMenu")%>"
                            
            var left;
            var top;

            var app=navigator.userAgent;
            if(app.indexOf("MSIE")>-1)
            {
                WinHt = 480;
                SetWinWidth=600;
            }
            else 
            {
                WinHt = 490;
                SetWinWidth=600;
            }
		       
            var urlStr = '<%=_QControl.GetTemplateRelativeUrl("QueueUsers.aspx")%>';
            var application = '<%=_ApplicationName%>';
            var userId = '<%=QueueUserId%>';
            //userId = userId.replace('&', 'amp;');
            userId = escape(userId);  
            var QName='<%=Microsoft.Security.Application.Encoder.UrlEncode(Microsoft.Security.Application.Encoder.JavaScriptEncode(strQueueName, false)) %>';
            urlStr += '?application='+application+'&userId='+userId+'&QueName=' + QName+'&';

            if (rowType == "Record")
            {                                                    
                //if role category show menu for viewroleusers  
                //fixed issue with localization as if we localize then View Role Users context menu was not coming
                if (SelCategory=="<%=ResourceManager.GlobalResourceSet.GetString("Role")%>")//if (SelCategory=="Role")
                { 
                              
                    var cellroleName=k0.innerText;
                    //rowMenu.add( new MenuItem(ViewUsr,function() {showCustInfo(window.open(urlStr+'resset=1&RoleUsers=1&VirtualId='+SelVirActID,'','height=236,width=250,resizable=yes,status=no'));},""));// Old values height=206,width=220
                    var menuItem = new WebMenuItem(); 
                    menuItem.Text = ViewUsr;   
                    menuItem.Name = "showCustInfo";   
                    //menuItem.OnClick = "showCustInfo(window.open(urlStr+'"+accessrights=1&UsrOrRoleName=+"'+SelVirActID +'"&Usr="'+SelCategory,'"+height='+WinHt+',width=498,resizable=no,status=no+"'))";             
		               
                    var strparams= urlStr+"resset=1&RoleUsers=1&VirtualId="+SelVirActID;

                    left = (screen.width / 2) - (320 / 2);
                    top  = (screen.height / 2) - (300 / 2);

                    var strwindowparams="height=300,width=320,resizable=yes,status=no,top=" + top + ", left=" + left;//seena width=610 width and height was more
                    menuItem.ImageURL="";
                    menuItem.OnClick = "showCustInfo(window.open('"+strparams+"','','"+strwindowparams+"'))";     
                                 
                    rowMenu.Items.Add(menuItem); 
                    var separator = new WebMenuItem();
                    separator.Type = "Separator";       
                    separator.Name = "MySeparator";
                    //rowMenu.Items.Add(separator);  //seena no need of separator    
                    
                    //For Set Proirity
                    var menuItem = new WebMenuItem(); 
                    menuItem.Text = SetPriorityContextMenuText;   
                    menuItem.Name = "SetPriority";                      
                    var urlStr1 = '<%=_QControl.GetTemplateRelativeUrl("SetPriorityForRole.aspx")%>';
                    urlStr1 += '?application='+application+'&roleId='+SelVirActID+'&RoleName='+cellroleName+'&QueName=' + QName;                    
                    menuItem.ImageURL="";                     
                    menuItem.OnClick = "SetPriorityForRole('"+urlStr1+"')";                                  
                    rowMenu.Items.Add(menuItem); 
                    


                }
                            
                //determine whether the menu should show accessrights, delete
                var k4 =  '<%=_DisableAccesRights%>';
                var obj = '<%=_DisableParticipantContent%>';
                var virActId =  '<%=_VirtualActorId%>';
                var isQueOwner =  '<%=_IsQueueOwner%>';
                var isQueueOwnerasParticipant =  '<%=_IsQueueOwnerasParticipant%>';
                                                      
                if(k4!='1' && obj !='1' && SelVirActID != virActId  )
                {                              
                    //rowMenu.add( new MenuItem(SetAccStr , function() {showCustInfo(window.open(urlStr+'accessrights=1&UsrOrRoleName='+SelVirActID +'&Usr='+SelCategory,'','height='+WinHt+',width=498,resizable=no,status=no'));}, ""));
                    var menuItem = new WebMenuItem(); 
                    menuItem.Text = SetAccStr;   
                    menuItem.Name = "showAccessRights";                                     
                    var strparams= urlStr+"accessrights=1&UsrOrRoleName="+SelVirActID + "&Usr=" +SelCategory;    
                        
                    left = (screen.width / 2) - (WinHt / 2);
                    top  = (screen.height / 2) - (SetWinWidth / 2);
                    menuItem.OnClick="showCustInfo(window.open('"+ strparams +"', '', 'height="+WinHt+",width=" + SetWinWidth +",resizable=yes,status=no,top=" + top + ", left=" + left +"'))";  
                    //var strwindowparams="height="+WinHt+",width=498,resizable=no,status=no";
                    menuItem.ImageURL="";
                    //menuItem.OnClick = "showCustInfo('"+strparams+"','"+strwindowparams+"')";
                    // rowMenu.Items.Clear();  
                    rowMenu.Items.Add(menuItem);
                                 
                    // rowMenu.add( new MenuItem(DeleteStr , function() {deleteparticipant(QName,SelVirActID,SelCategory);}));
                    var menuItem = new WebMenuItem(); 
                    menuItem.Text = DeleteStr;   
                    menuItem.Name = "deleteparticipant";   
                    menuItem.OnClick = "deleteparticipant('"+QName+"','"+SelVirActID+"','"+SelCategory+"')";             
                    //menuItem.ImageURL=imgfolder+"";
                    rowMenu.Items.Add(menuItem); 
                    //                                  
                }
                        
                //if(obj!='1' && SelVirActID != virActId)                                
                                
                if(isQueOwner==1 &&  isQueueOwnerasParticipant==0 && SelVirActID == virActId )
                {   
                    //rowMenu.add( new MenuItem(ConsAsPart , function() {ChangeOwnerAsParticipant(QName,SelVirActID,SelCategory,"yes");}));
                    var menuItem = new WebMenuItem(); 
                    var strYes= "yes";
                    menuItem.Text = ConsAsPart;   
                    menuItem.Name = "ChangeOwnerAsParticipantYes";   
                    menuItem.OnClick = "ChangeOwnerAsParticipant('"+QName+"','"+SelVirActID+"','"+SelCategory+"','"+strYes+"')";             
                    //menuItem.ImageURL=imgfolder+"";
                    rowMenu.Items.Add(menuItem);
                                                                     
                    //                                  var separator = new WebMenuItem();
                    //                                    separator.Type = "Separator";       
                    //                                    separator.Name = "MySeparator";
                    //                                    rowMenu.Items.Add(separator);
                                                                   
                }
                else if(isQueOwner==1 &&  isQueueOwnerasParticipant==1 && SelVirActID == virActId )
                {   
                    //rowMenu.add( new MenuItem(DonotConAsPart , function() {ChangeOwnerAsParticipant(QName,SelVirActID,SelCategory,"no");}));
                    var menuItem = new WebMenuItem(); 
                    var strNo ="no";
                    menuItem.Text = DonotConAsPart;   
                    menuItem.Name = "ChangeOwnerAsParticipantNo";   
                    menuItem.OnClick = "ChangeOwnerAsParticipant('"+QName+"','"+SelVirActID+"','"+SelCategory+"','"+strNo+"')";             
                    //menuItem.ImageURL=imgfolder+"";
                    rowMenu.Items.Add(menuItem);                                  
                    //                               var separator = new WebMenuItem();
                    //                                    separator.Type = "Separator";       
                    //                                    separator.Name = "MySeparator";
                    //                                    rowMenu.Items.Add(separator);
                                  
                }                                                                                      
                                   
                if (rowType != "Record") return true;	
                var i;
                var grid = wgGetGridById(gridId);	
                                  
                                   
                if (rowType != "Record") return true;	
                                    
                if(rowType =="Record")
                {
                    // hide the default context menu
                    for (i=0;i<=43;i++)
                    {        
                        //if((i!=1)||(i!=14))                                                 
                        rowMenu.Items[i].Hide(); 
                                         
                    }                       
                                                   
                } 	
                                                                                                                                                                                                          
            }
                    
            //if(!IS.moz && !IS.ie){
            //    rowMenu.Show(location.X +250, location.Y + 160);
            //}
                    
            return true;
        }
                             
        
        var obj = '<%=_DisableParticipantContent%>';
        if(obj=='1')
        {
            document.getElementById('btnAddFilre').disabled = true;
            document.getElementById('btnAddExpression').disabled = true;
        }
        
        // If Mozila it should refresh the grids, to avoid Communication error
        function GetMOZBrowserversion()
        {
            var app=navigator.userAgent;
            if(app.indexOf("MSIE")>-1)
            {
                return 1;	
            }
            else if(app.indexOf("Firefox/1.5")>-1)
            {
                return 2;	
            }
            else
            {
                return 3;
            }
        }
         
        function QueueRefreshGrid()
        {   
            try
            {
                var i=GetMOZBrowserversion();
                if(i==1)
                {
                    var grid = ISGetObject("_WebGridQueEdit");
                    grid.RefreshAll();  
                }
                else
                    window.location.href = window.location.href;
            }
            catch(e){}

        }  
         
        function RefreshGrid(flag)
        {   
            try
            {
                var i=GetMOZBrowserversion();
                if(i==1)
                {
                    //  var grid = ISGetObject("_WebGridParticipants");
                    //   grid.RefreshAll(); //do not use Refresh() as it is failing in IE7
                   
                    window.location.href = window.location.href;
                }
                else
                {
                    if (flag =="1")
                    {            
                        
                        window.location.href = window.location.href.replace(/(deleteuser=)[^\&]+/, '$1' + "False");
                    }
                    else
                    {
                       
                        window.location.href = window.location.href;
                    }
                }
                //window.opener.location.href = window.opener.location.href;
                    
                //using timeout to adjust the grid height
                window.setTimeout(ReSizeQueueGrid, 400);
            }
            catch(e){}
             
        } 
 

        var i=GetMOZBrowserversion();
        //        if(i!=1)
        //        {
        //            //QueueRefreshGrid();
        //            //RefreshGrid_Escalation();
        //            //RefreshGrid();
        //        }
       
        

    
        function MsgforParticipantNotAdd(selCnt,notAddedCnt)
        {
            
            if(selCnt==notAddedCnt)
            { 
                Msg = "<%=ResourceManager.GlobalResourceSet.GetString("Queue_selectedParticipants")%> ";
                Msg = Msg + "<%=ResourceManager.GlobalResourceSet.GetString("Queue_alreadyexistandhavenotbeenadded")%>";
            }
            else
            {
                Msg = "<%=ResourceManager.GlobalResourceSet.GetString("Queue_Outofthe")%>";
                Msg = Msg + " " + selCnt + " ";
                Msg = Msg + "<%=ResourceManager.GlobalResourceSet.GetString("Queue_selectedParticipants")%>";
                Msg = Msg + " " + notAddedCnt + " ";
                Msg = Msg + "<%=ResourceManager.GlobalResourceSet.GetString("Queue_alreadyexistandhavenotbeenadded")%>";
            }    
           // alert(Msg); 
            se.ui.messageDialog.showError("<%=ResourceManager.GlobalResourceSet.GetString("Queue_Header")%>", Msg);

           
        }

</script>

<script type="text/javascript">    
    function ReSizeQueueGrid() {        
        var QueueHeights = '<%=QHeight%>';
        //alert('sss');
        var Grid1 = ISGetObject("_WebGridQueEdit");
        var Grid2 = ISGetObject("_WebGridParticipants");
        var Grid3 = ISGetObject("_WebGridEsclation");
        var heightType = '<%=_QControl.QueueControlHeight.Type %>';
        var height;
        if (heightType == "Percentage")
            height = document.body.clientHeight * QueueHeights / 100;
        else
            height = QueueHeights;
        var width = document.body.clientWidth;
        var queueClientId = "<%=_QControl.ClientID%>";
        var qControlWidth, qControlHeight;

        if (document.getElementById(queueClientId).style.height == "") {
            qControlHeight = document.body.clientHeight;
        }
        else {
            qControlHeight = parseInt(document.getElementById(queueClientId).style.height);
            //alert(qControlHeight);
        }
        if (document.getElementById(queueClientId).style.width == "") {
            qControlWidth = document.body.clientWidth;
        }
        else {
            qControlWidth = parseInt(document.getElementById(queueClientId).style.width);
        }

        

        if (qControlHeight > 0) {
            //height = qControlHeight * QueueHeights / 100;
            if (QueueHeights == '0') {//debugger;
                if (!(Grid1 == 'undefined' || Grid1 == null)) 
                {
                    var editTableHeight, editGridHeight;
                    if (qControlHeight > 500) {
                        editGridHeight = qControlHeight * 80 / 100 + 'px';
                        editTableHeight = qControlHeight * 85 / 100 + 'px';
                    }
                    else if (qControlHeight > 250) {
                        if (navigator.appName == 'Netscape') {
                            editGridHeight = qControlHeight * 65 / 100 + 'px';
                            editTableHeight = qControlHeight * 70 / 100 + 'px';
                        }
                        else {
                            editGridHeight = qControlHeight * 62 / 100 + 'px';
                            editTableHeight = qControlHeight * 70 / 100 + 'px';
                        }
                    }
                    else {
                        editGridHeight = qControlHeight * 55 / 100 + 'px';
                        editTableHeight = qControlHeight * 60 / 100 + 'px';
                    }
                    document.getElementById('ETable').style.height = editTableHeight;
                    Grid1.SetHeight(editGridHeight);
                    if (navigator.appName == 'Netscape') 
                    {
                        
                        var editTableWidth, editGridWidth;
                        if (qControlWidth > 800) {
                            editGridWidth = qControlWidth * 98 / 100;
                            editTableWidth = qControlWidth * 98 / 100;
                        }
                        else {
                            editGridWidth = qControlWidth * 50 / 100;
                            editTableWidth = qControlWidth * 50 / 100;
                            Grid1.Width = qControlWidth + 'px';
                        }
                        document.getElementById('ETable').style.width = qControlWidth * 98 / 100 + 'px';
                        document.getElementById('QMainList').style.width = qControlWidth * 98 / 100 + 'px';                        
                        document.getElementById('QTable1').style.width = qControlWidth * 98 / 100 + 'px';
                    }
                }
                
                if (!(Grid2 == 'undefined' || Grid2 == null)) 
                {
                    
                    var participantDivHeight, participantGridHeight, participantDivWidth, participantGridWidth, divSettingsHeight;
                    var divDispatchPatternHeight, divDispatchPatternWidth;
                    
                    if (navigator.appName == 'Netscape') 
                    {
                        
                        if (qControlHeight > 500) 
                        {
                            participantGridHeight = qControlHeight * 45 / 100 + 'px';                            
                            participantDivHeight = qControlHeight * 75 / 100 + 'px';
                            divSettingsHeight = qControlHeight * 65 / 100 + 'px';
                            divDispatchPatternHeight = qControlHeight * 70 / 100 + 'px';
                        }
                        else 
                        {
                            participantGridHeight = qControlHeight * 35 / 100 + 'px';
                            participantDivHeight = qControlHeight * 66 / 100 + 'px';
                            divSettingsHeight = qControlHeight * 42 / 100 + 'px';
                            divDispatchPatternHeight = qControlHeight * 28 / 100 + 'px';
                        }
                    }
                    else 
                    {
                        if (qControlHeight > 500) 
                        {
                            
                            participantGridHeight = qControlHeight * 45 / 100 + 'px';
                            participantDivHeight = qControlHeight * 75 / 100 + 'px';
                            divSettingsHeight = qControlHeight * 70 / 100 + 'px';
                            divDispatchPatternHeight = qControlHeight * 70 / 100 + 'px';
                        }
                        else if (qControlHeight > 400) 
                        {
                            participantGridHeight = qControlHeight * 45 / 100 + 'px';
                            participantDivHeight = qControlHeight * 65 / 100 + 'px';
                            divSettingsHeight = qControlHeight * 60 / 100 + 'px';
                            divDispatchPatternHeight = qControlHeight * 55 / 100 + 'px';
                        }
                        else 
                        {
                            
                            participantGridHeight = qControlHeight * 50 / 100 + 'px';
                            participantDivHeight = qControlHeight * 50 / 100 + 'px';
                            divSettingsHeight = qControlHeight * 38 / 100 + 'px';
                            divDispatchPatternHeight = qControlHeight * 30 / 100 + 'px';
                        }
                    }
                    
                    // Width
                    
                    if (qControlWidth > 800) 
                    {
                        
                        participantDivWidth = qControlWidth * 98 / 100 + 'px';
                        
                    }
                    else 
                    {
                        participantDivWidth = qControlWidth * 99 / 100 + 'px';
                        participantGridWidth = qControlWidth * 50 / 100 + 'px';
                        divDispatchPatternWidth = qControlWidth * 95 / 100 + 'px';
                        Grid2.Width = participantGridWidth;

                        // alert(participantDivWidth);
                        document.getElementById('divParticipants').style.width = participantDivWidth;
                        document.getElementById('divDispatchPattern').style.width = divDispatchPatternWidth;
                    }
                    Grid2.SetHeight(participantGridHeight);

                    try{
                        if (isIE11()) {
                            HidePadColumn1("_WebGridParticipants");
                        }
                    }
                    catch(ex)
                    {

                    }
                    //participantDivHeight=participantDivHeight+'px';
                    //participantDivHeight = participantDivHeight - 55;
                    document.getElementById('divParticipants').style.height = participantDivHeight;
                   // alert(document.getElementById('divParticipants').style.height);
                    if(navigator.userAgent.indexOf("Firefox") > -1)
                    {
                        document.getElementById('divParticipants').style.width = participantDivWidth;
                        //if(qControlHeight<300){
                        //    Grid2.SetHeight(180+'px');
                        //}
                    }

                    document.getElementById('divSettings').style.height = divSettingsHeight;
                    if(!(divDispatchPatternHeight == 'undefined' || divDispatchPatternHeight == null))
                        document.getElementById('divDispatchPattern').style.height = divDispatchPatternHeight;
                    //document.getElementById('divDispatchPattern').style.width = divEscalationWidth;
                }
                if (!(Grid3 == 'undefined' || Grid3 == null)) {
                    var divEscalationHeight, escalationGridHeight, divEscalationWidth, escalationGridWidth;
                    
                    if (qControlHeight > 500) {
                        escalationGridHeight = qControlHeight * 55 / 100 + 'px';
                        divEscalationHeight = qControlHeight * 67 / 100 + 'px';
                    }
                    else if (qControlHeight > 400) {
                        escalationGridHeight = qControlHeight * 50 / 100 + 'px';
                        divEscalationHeight = qControlHeight * 55 / 100 + 'px';
                    }
                    else {
                        escalationGridHeight = qControlHeight * 30 / 100 + 'px';
                        divEscalationHeight = qControlHeight * 42 / 100 + 'px';
                    }

                    if (qControlWidth > 800) {
                        divEscalationWidth = qControlWidth * 98 / 100 + 'px';
                        escalationGridWidth = qControlWidth * 98 / 100 + 'px';
                    }
                    else {
                        if (navigator.appName == 'Netscape') {
                            divEscalationWidth = qControlWidth * 92 / 100 + 'px';
                            escalationGridWidth = qControlWidth * 86 / 100 + 'px';
                        }
                        else {
                            divEscalationWidth = qControlWidth * 96 / 100 + 'px';
                            escalationGridWidth = qControlWidth * 86 / 100 + 'px';
                        }
                    }

                    Grid3.SetHeight(escalationGridHeight);
                    Grid3.Width = escalationGridWidth;
                    document.getElementById('divEscalation').style.height = divEscalationHeight;
                    document.getElementById('divEscalation').style.width = divEscalationWidth;
                }
            }
            else {
                if (!(Grid1 == 'undefined' || Grid1 == null)) {

                    if (navigator.appName == 'Netscape') {
                        //Grid1.SetHeight(height - (height * 40 / 100));
                        Grid1.SetHeight(qControlHeight);
                    }
                    else {
                        //Grid1.SetHeight(height);
                        Grid1.SetHeight(qControlHeight);
                    }
                    document.getElementById('ETable').style.height = qControlHeight;

                    //Grid1.SetHeight(height);
                    //Grid1.SetHeight(document.body.clientHeight - (document.body.clientHeight * 20 / QueueHeights));
                }
                if (!(Grid2 == 'undefined' || Grid2 == null)) {
                    //Grid2.SetHeight(height - (height * 40 / 100));
                    
                    Grid2.SetHeight(qControlHeight);
                    document.getElementById('divParticipants').style.width = qControlHeight;
                    //Grid2.SetHeight(document.body.clientHeight - (document.body.clientHeight * 60 / QueueHeights));
                }
                if (!(Grid3 == 'undefined' || Grid3 == null)) {
                    //Grid3.SetHeight(height - (height * 35 / 100));
                    Grid3.SetHeight(qControlHeight);
                    document.getElementById('divSettings').style.width = qControlHeight;
                    //Grid3.SetHeight(document.body.clientHeight - (document.body.clientHeight * 50 / QueueHeights));
                }
            }
            var QueueHeights = '<%=QHeight%>';
            var divSettings = document.getElementById("divSettings");
            if (!(divSettings == 'undefined' || divSettings == null)) {
                if (height > 0)
                    divSettings.style.height = height - (height * 10 / 100);
                else {
                    //divSettings.style.height = document.body.clientHeight - (document.body.clientHeight * 40 / 100);

                    var isCheckFromSp = "<%=IsFromSharePointUI%>";
                    if (isCheckFromSp == "True") {
                        divSettings.style.width = document.body.clientWidth - (document.body.clientWidth * 12 / 100);
                    }

                }
            }
        }
        else {
            if (QueueHeights == '0') {
                if (!(Grid1 == 'undefined' || Grid1 == null)) {
                    Grid1.SetHeight(document.body.clientHeight - (document.body.clientHeight * 20 / 100));
                }

                if (!(Grid2 == 'undefined' || Grid2 == null)) {
                    Grid2.SetHeight(document.body.clientHeight - (document.body.clientHeight * 52 / 100));
                }
                if (!(Grid3 == 'undefined' || Grid3 == null)) {
                    Grid3.SetHeight(document.body.clientHeight - (document.body.clientHeight * 45 / 100));
                    document.getElementById('divSettings').style.height = (document.body.clientHeight * 60 / 100)
                }
            }
        }
        
        if(navigator.userAgent.indexOf("Firefox") > -1){

            if(qControlHeight < 300){
                //window.setTimeout(ReSizeQueueGrid, 10);
                try{
                    //alert(qControlHeight);
                    //document.getElementById('ETable').style.height= 200 +'px';
                    //document.getElementById('ETable').style.width= 300 +'px';
                    var heightTemp = qControlHeight - 60 +'px';
                    if(Grid1 != undefined){
                        Grid1.SetHeight(heightTemp);}
                    var h2 = qControlHeight*60/100 + 'px';
                    
                    if(Grid2 != undefined){ 
                        Grid2.SetHeight(h2);
                    }
                   
                    if(Grid3 != undefined){ 
                        Grid3.SetHeight(h2 - 10);
                        Grid3.Refresh();
                    }
                    
                    document.getElementById('divParticipants').style = qControlHeight;
                    document.getElementById('divSettings').style = qControlHeight;
                    document.getElementById('divDispatchPattern').style = qControlHeight;
                    document.getElementById('divEscalation').style = qControlHeight;

                    //document.getElementById('QTable1').style.width = 90 +'%';
                    //Grid1.Width = 300 +'px';
                }
                catch(e){}
            }
        }
        if (window.parent.parent.location.href.indexOf('FromArchestrA') != -1) {
            document.getElementById('divParticipants').style.overflowY = 'scroll';
        }
    }
    
    function SetQueueHeight() {
        var QueueHeights = '<%=QHeight%>';
        return;
        if(QueueHeights > 10)
        {
            QueueHeights = QueueHeights-20;
        }
       
        var Grid1 = ISGetObject("_WebGridQueEdit");
        var Grid2 = ISGetObject("_WebGridParticipants");
       
        var Grid3 = ISGetObject("_WebGridEsclation");
        if (!(Grid1 == 'undefined' || Grid1 == null))
            Grid1.SetHeight(document.body.clientHeight * QueueHeights / 100 - (document.body.clientHeight * 10 / 100));
        /*if (!(Grid2 == 'undefined' || Grid2 == null))
            Grid2.SetHeight(document.body.clientHeight * QueueHeights / 100);
        if (!(Grid3 == 'undefined' || Grid3 == null))
            Grid3.SetHeight(document.body.clientHeight * QueueHeights / 100);*/
        //       var dispatchPatternDiv = document.getElementById("divDispatchPattern");
        //       dispatchPatternDiv.style.height = document.body.clientHeight * QueueHeights / 100;
    }

</script>
<script type="text/javascript">
    function onTabSelected(sender, eventArgs) {
        var tab = eventArgs.get_tab();
        /*if (args.Tab.Index == 2)
        {
          ResizeWorkListLayoutControl();
        }*/

        if (tab.get_index() == 3) {
            var grid = ISGetObject("_WebGridEsclation");            
            grid.Refresh();
            window.setTimeout(function () {wgDoResize(true, true);}, 600);
            //grid.HidePadColumn=true;
            //HidePadColumn2("_WebGridEsclation");
        }

        if(navigator.userAgent.indexOf("Firefox") > -1){
            // if(worklistheight<60 & !isNaN(worklistheight)){
            
            var Grid2 = ISGetObject("_WebGridParticipants");
            if(Grid2!= null){ Grid2.Refresh();}
        }
    }

    //ResizeQueuePage();
    function ResizeQueuePage()
    {
        var QueueHeights = '<%=QHeight%>';
        if (QueueHeights != '0px' && QueueHeights != '0') 
        {
            document.getElementById("divQueueList").style.height = QueueHeights;
        }
    }
   
    function calllistlayoutdivresize()
    {   
        try
        {
            var queueClientId = "<%=_QControl.ClientID%>";
            var queueControlWidth,  queueControlHeight;
            var worklistwidth, worklistheight;
            // If the control's height is not known
            if(document.getElementById(queueClientId).style.height == "")
            {
                worklistwidth = document.body.clientWidth* 95/100;
                worklistheight = document.body.clientHeight* 50/100;
            }
            else
            {
                worklistwidth=parseInt(document.getElementById("<%=_QControl.ClientID%>").style.width)* 90/100+'px';
                worklistheight=parseInt(document.getElementById("<%=_QControl.ClientID%>").style.height)* 27/100+'px';
            }
            var controlNode = document.getElementById('<%=WorkListLayoutControl1.ClientID%>');
            if(!(controlNode == null || controlNode == 'undefined')) 
            { 
                for(var i=0; i<controlNode.childNodes.length; i++)
                {
                    if(controlNode.childNodes[i] !=null || controlNode.childNodes[i] !='undefined') {
                        //                    if (controlNode.childNodes[i].id == "BodyDiv") {
                        //                        controlNode.childNodes[i].style.width = worklistwidth;
                        //                        controlNode.childNodes[i].style.height = '10px';
                        //                        controlNode.childNodes[i].style.display = 'none';
                        //                    }

                        var isCheckFromSp = "<%=IsFromSharePointUI%>";
                        if (isCheckFromSp == "True") {
                            worklistwidth=worklistwidth-30;
                        }

                        if(controlNode.childNodes[i].id=="GridDiv")
                        {
                            controlNode.childNodes[i].style.width= window.innerWidth - 50 +'px';
                            //controlNode.childNodes[i].style.height=worklistheight;
                        }
                        else if(controlNode.childNodes[i].id=="FooterDiv")
                        {
                            controlNode.childNodes[i].style.width=window.innerWidth - 50 +'px';
                        }
                    }
                }         
            }

            if(navigator.userAgent.indexOf("Firefox") > -1){
                // if(worklistheight<60 & !isNaN(worklistheight)){
                try{ var Grid2 = ISGetObject("_WebGridParticipants");
                    Grid2.SetHeight(120+'px');
                    //ResizeGrid();
                         Grid2.Refresh();
                }
                catch(e){ }
            }
        }
        catch(e)
        {
      
        }

    }
    function callAfter500Queue() {                
        calllistlayoutdivresize();
        var queueClientId = "<%=_QControl.ClientID%>";
        var testHeight = parseInt(document.getElementById(queueClientId).style.height);
        var Grid1 = ISGetObject("_WebGridQueEdit");
        // for Dashboard Home page 1 if queue height <400 then it will not call below method
        //alert(testHeight);
        if(testHeight > 400){
            ReSizeQueueGrid();
        }
        
        if(testHeight<400 & navigator.userAgent.indexOf("Firefox") === -1){
            // Grid1.RefreshAll();
            try{ Grid1.SetHeight(testHeight -60 +'px');
                Grid1.Refresh();
                //window.setTimeout(ResizeGrid(), 500);
            }
            catch(e){ }
        }

        if(isNaN(testHeight) || testHeight === undefined || testHeight === null){            
            window.setTimeout(ReSizeQueueGrid, 500);
        }

        if(navigator.userAgent.indexOf("Firefox") > -1){
            if(testHeight<400){
               
                    window.setTimeout(ReSizeQueueGrid, 500);
                    //window.setTimeout(ReSizeQueueGrid, 500);
                    //window.setTimeout(ResizeGrid(), 500);
                }
                //var Grid2 = ISGetObject("_WebGridParticipants");
                //Grid2.SetHeight(180+'px');
                //Grid2.Refresh();
            }
        }
            
    if (navigator.userAgent.toLowerCase().indexOf('chrome') > 0 || navigator.userAgent.indexOf("Firefox") > -1)
    {
        window.setTimeout(callAfter500Queue, 150);
    }
    else
    {          
        if (window.parent.parent.location.href.indexOf('FromArchestrA') > 0) {
            window.setTimeout(callAfter500Queue, 800);
        }
        else
        {
            window.setTimeout(callAfter500Queue, 650);
        }
    }

    function ResizeGrid() 
    {
       
        if (navigator.userAgent.toLowerCase().indexOf('chrome') > 0 || navigator.userAgent.indexOf("Firefox") > -1) 
        { 
              
            window.setTimeout(function () {wgDoResize(true, true);}, 1000);
            return true;
        }
    }

    ResizeGrid();


</script>
