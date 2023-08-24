<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.HWS.Web.CalendarControl.WorkSlotGridClass" Theme=""  StylesheetTheme=""%>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>
<!DOCTYPE html >
<html style="height:100%">
<head runat="server">
    <title>Untitled Page</title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
</head>

<script type="text/javascript">
        function GetValues()
        {
            document.getElementById("hidDate").value = parent.document.getElementById("hidDate").value;
            document.getElementById("hidIsHoliday").value = parent.document.getElementById("hidIsHoliday").value;
            document.getElementById("hidAppName").value = parent.document.getElementById("hidAppName").value;
            document.getElementById("hidCssPath").value = parent.document.getElementById("hidCssPath").value;
            document.getElementById("hidAdd").value = parent.document.getElementById("hidAdd").value;
            document.getElementById("hidDelete").value = parent.document.getElementById("hidDelete").value;
            
            
            if(document.getElementById("hidCalendarGuid").value == "00000000-0000-0000-0000-000000000000")
            {
                document.getElementById("hidCalendarGuid").value = parent.document.getElementById("hidGuid").value;
                document.getElementById("hidWorkHourType").value = parent.document.getElementById("hidWorkHourType").value;
                document.getElementById("hidWeekDay").value = parent.document.getElementById("hidWeekDay").value;
                
                document.forms[0].submit();
            }
        }

        function isIE11() {
            return !!navigator.userAgent.match(/Trident.*rv[ :]*11\./);
        }

        function ResizeGrid() {
            if (isIE11()) {
                window.setTimeout(function () { wgDoResize(true, true); }, 1400);
                return true;
            }
        }
    </script>
<body onload="javascript:GetValues()"  style="margin:0px;padding:0px; height:100%;">
    <form id="form1" runat="server" style="height:98%">
            <%=System.Web.Helpers.AntiForgery.GetHtml()%>
            <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(_CssPath)%>" rel="stylesheet" type="text/css">
            <input type="hidden" name="hidCalendarGuid" id="hidCalendarGuid" value="<%=_CalendarGuid %>" />
            <input type="hidden" name="hidWorkHourType" id="hidWorkHourType" value="<%=Microsoft.Security.Application.Encoder.HtmlEncode(_WorkHourType) %>" />
            <input type="hidden" name="hidWeekDay" id="hidWeekDay" value="<%=Microsoft.Security.Application.Encoder.HtmlEncode(_WeekDay) %>" />
            <input type="hidden" name="hidDate" id="hidDate" value="<%=Microsoft.Security.Application.Encoder.HtmlEncode(_Date) %>" />
            <input type="hidden" name="hidIsHoliday" id="hidIsHoliday" value="<%=_IsHoliday %>" />
            <input type="hidden" name="hidAppName" id="hidAppName" value="<%=Microsoft.Security.Application.Encoder.HtmlEncode(_ApplicationName) %>" />
            <input type="hidden" name="hidCssPath" id="hidCssPath" value="<%=Microsoft.Security.Application.Encoder.HtmlEncode(_CssPath) %>" />
            <input id="hidAdd" name="hidAdd" type="hidden" value="<%=_CanAddCalendarWorkSlot%>" />
            <input id="hidDelete" name="hidDelete" type="hidden" value="<%=_CanDeleteCalendarWorkSlot%>" />
             
            <iswebgrid:webgrid id="WebGrid1" runat="server" horizontalalign="NotSet" 
                    scriptdirectory="../InterSoft/Grid/CommonLibrary/WebGrid/V6_0_7200/"
                    sharedscriptdirectory="../InterSoft/Grid/CommonLibrary/Shared/" height="265px" 
                    AllowAutoDataCaching="false"  DisableFileSystemChecking="true" EnableWebResources="never" 
                    WebDesktopScriptDirectory="../InterSoft/Grid/CommonLibrary/WebDesktop/V2_5_2007/">
                    <LayoutSettings AlternatingColors="True" ScriptDirectory="../InterSoft/Grid/CommonLibrary/WebGrid/V6_0_7200/" 
                        GridLineStyle="Solid" GridLineColor="#afafaf" CellPaddingDefault="2" RowHeightDefault="20px" GridLines="None" StatusBarVisible="True" NewRowLostFocusAction="AlwaysPrompt" RowLostFocusAction="AlwaysPrompt" PromptBeforeDelete="true" AlwaysShowHelpButton="false" RowHeaders="yes" >
                        <HeaderStyle CssClass="GridHeaderStyle"></HeaderStyle>
                        <FocusCellStyle CssClass="GridFocusCellStyle"></FocusCellStyle>
                        <EditTextboxStyle CssClass="GridEditTextboxStyle"></EditTextboxStyle>
                        <FrameStyle CssClass="GridFrameStyle"></FrameStyle>
                        <SelectedRowStyle CssClass="GridSelectedRowStyle"></SelectedRowStyle>
                        <ImageSettings Folder="../InterSoft/Grid/CommonLibrary/Images/"></ImageSettings>
                        <StatusBarStyle CssClass="GridStatusBarStyle">
                            <Padding Top="2px" Left="2px" Bottom="2px" Right="2px"></Padding>
                        </StatusBarStyle>
                        <TextSettings Language="UseCulture"  LocalizationFolder="../InterSoft/Grid/CommonLibrary/WebGrid/V6_0_7200/Localization/"></TextSettings>
                        <RowStyle CssClass="GridRowStyle" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden"></RowStyle>
                                           <AlternatingRowStyle CssClass="GridAlternatingRowStyle" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden"></AlternatingRowStyle>
                        <NewRowStyle CssClass="GridNewRowStyle"></NewRowStyle>
                        <EditFocusCellStyle CssClass="GridEditFocusCellStyle" ></EditFocusCellStyle>
                        <ClientSideEvents OnRowContextMenu="doRowContextMenu" OnInitialize="ResizeGrid"/>
                    </LayoutSettings>
                    <RootTable GridLineStyle="NotSet"></RootTable>
            </iswebgrid:webgrid>
    </form>
    <script type="text/javascript" >
        function doRowContextMenu(gridId, rowType, rowEl, rowMenu)
        {
            if (rowType != "Record") 
                return true;	
            var i;
            var grid = wgGetGridById(gridId);
            if(rowType =="Record")
            {
            
                // hide the default context menu
                for (i=0;i<=43;i++)
                {  
                    if(i!=22)                                   
                        rowMenu.Items[i].Hide(); 
                }                                                      
            } 
        }
    </script>
    
</body>


</html>
