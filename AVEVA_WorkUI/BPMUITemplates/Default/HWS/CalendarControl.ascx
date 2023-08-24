<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.HWS.Web.CalendarControl.CalendarClass" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<script type="text/javascript">
  var masterX = 0;
  var masterY = 0;
  try{ hidemasterpagecontents(); } catch(e){}
   
  
        function SelectedResource(id)
        {
            document.getElementById("hidPageType").value="resource";
            document.getElementById("hidSetResource").value = id;
            window.document.forms[0].submit();
        }
        
        function gridresize()
        {
         wgDoResize(true,true);
        }
    function SetResourceCalendar()
    {

        var hdnUser = "<%=hdnUserName.ClientID %>";

        //to get exact path from sharepoint and ec
        var userLookupPath = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(calControl.GetTemplateRelativeUrl("../Repository/Site/UserLookup.aspx?users="), false)%>";

        var userName = document.getElementById(hdnUser).value;
        userName = encodeURIComponent(userName);
        var urlParam;
        urlParam = '&singleselection=1';
        //pending need to check in different theme
        var oWindow = radopen(userLookupPath + userName + urlParam, null);
        oWindow.set_modal(true);
        oWindow.set_title("<%=WindowTitle%>");
        oWindow.setSize(590, 500);//555,320
        oWindow.setActive(true);
        oWindow.center();

        oWindow.add_beforeClose(onClientBeforeClose);

        function onClientBeforeClose(sender, args)
        {
            var returnValue = args.get_argument();

            if (returnValue !== null && returnValue !== undefined)
            {
                var ids;
                var names = '';
                var useridstring = '';

                // Avoid selecting multiple roles
                if (returnValue.indexOf("@!@") != -1)
                {
                    se.ui.messageDialog.showError("<%=resourceManager.GlobalResourceSet.GetString("Calendar_Heading") %>", '<%=ResourceCalErrMsg%>');
                    args.set_cancel(true);
                    return;
                }

                if (returnValue.lastIndexOf("^") != -1)
                {
                    var usernamestring = returnValue.substring(0, returnValue.lastIndexOf("^"));
                    useridstring = returnValue.substring(returnValue.lastIndexOf("^") + 1);
                    names = usernamestring;
                }
                if (useridstring == '')
                {
                    se.ui.messageDialog.showError("<%=resourceManager.GlobalResourceSet.GetString("Calendar_Heading") %>", '<%=NoResourceCalErrMsg%>');
                    args.set_cancel(true);
                    return;
                }
                //oArea.value = names;
                var oArea1 = document.getElementById(hdnUser);
                oArea1.value = useridstring;
                document.getElementById("hidPageType").value = "resource";
                document.getElementById("hidSetResource").value = useridstring;
                window.setTimeout(function ()
                {
                    window.document.forms[0].submit();
                }, 0);
            }

            sender.remove_beforeClose(onClientBeforeClose);
        }

        return false;
    }

    function SetResourceCalendar1()
    {
        var hdnUser = "<%=hdnUserName.ClientID %>";
        
        //to get exact path from sharepoint and ec
        var userLookupPath = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(calControl.GetTemplateRelativeUrl("CalendarUsers.aspx?application="), false)%>";      
       
        var application = '<%=ApplicationName%>';
        
        window.open(userLookupPath+application,'','height=300,width=490,resizable=yes,status=no')

        return false;
    }
    function CalendarConfirmation()
    {
        if(document.getElementById("hidIsConfirmed").value == "")
        {
            document.getElementById("hidIsConfirmed").value = "yes";
            se.ui.messageDialog.showConfirmation("<%=resourceManager.GlobalResourceSet.GetString("Calendar_Heading") %>", '<%=CalConfirmMsg%>', function (userResonse)
            {
                if (userResonse)
                {
                    document.getElementById("hidResourceId").value = document.getElementById("hidCalGuid").value;
                } else
                {
                    window.location.href = window.location.href;
                }
            });
        }
        
    }
    function SetCalendarGridHeight()
    {
        var CalendarHeights = '<%=CalendarHeight%>';
        var Grid1 = ISGetObject("WebGridCalList");
        
        if(!(Grid1 == 'undefined' || Grid1 == null))
            {
            Grid1.SetHeight(document.body.clientHeight * CalendarHeights / 100);
            }
          
    }
    
    //Context menu option - Package
    function PackageMenu(gridId, rowType, rowEl, rowMenu) {
        //Calendar Name -this needs to be changes instaed of hardcoding cell[1] get colname of CalendarName                                                            
        
        var calName = rowEl.cells[1].innerText;

        //Package
        var PackageStr = "Package";
        if (rowType != "Record") return true;
        if (rowType == "Record") {
            // hide the default context menu
            for (i = 0; i <= 43; i++) {
                rowMenu.Items[i].Hide();
            }
        }

        if (rowType == "Record") {
            if (rowType != "Record") return true;
            if (rowType == "Record") {
                // hide the default context menu
                for (i = 0; i <= 43; i++) {
                    rowMenu.Items[i].Hide();
                }
            }
        }
        return true;
    }
    function OpenPackageWindow() {
        try {
            // enterprise console calendar master page is already resizing the window, no need of increasing height and width 400 px.
            //window.resizeBy(400, 400);
        }
        catch (e) {
        }
        var templateUrl = '<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(calControl.GetTemplateRelativeUrl("CalendarView.aspx"), false)%>';
               templateUrl = '<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(calControl.TemplateDirectory, false)%>';
               var application = '<%=ApplicationName%>';
               var calName = '<%=_CalendarGuid%>';
               var url = templateUrl + "Package/PackageList.aspx?&mode=Calendar" + "&Name=" + calName + "&AppName=" + application;
               var oManager;
               try {
                   oManager = parent.GetRadWindowManager();
               }
               catch (e) { }

               if (oManager != null) {
                   var oWnd = oManager.getWindowByName("PackageWindow");
                   oWnd.setUrl(url);
                   oWnd.show();
               }
               else {
                   radopen(url, "PackageWindow");
               }

               return false;
           }
    function InitGrid(gridId)
    {
        var grid = ISGetObject(gridId);
        grid.HidePadColumn = true;
    }

    function ResizeGrid(controlId, actionName, lastRequestObject, xmlResponseObject)
    {        

        if (actionName == "RefreshAll" || actionName == "Refresh")
        {
            var WebGrid1 = ISGetObject(controlId);
            window.setTimeout(function ()
            {
                wgDoResize(true, true);
            }, 600);
            return true;            
        }

    }

    function OnWebgridColumnSort(controlId, columnObject) {
        var grid = ISGetObject(controlId);
        if (IS.chrome) {
            try
            {                
                var colHeaderElement = grid.RootTable.GetElement(WG40.COLHEADER, WG40.HTMLTABLE);
                var colHeaderElementTR = colHeaderElement.childNodes[1].childNodes[0];
                sortIndicatorElement = colHeaderElementTR.getElementsByClassName("DefSI");
                
                for (i = 0; i < sortIndicatorElement.length; i++)
                {                    
                    sortIndicatorElement[i].style.display = "";
                }
            }
            catch (e)
            { }
        }
        return true;
    }

    var tempcalControlHeight;
</script>
<script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
<script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
<link href="<%=calControl.GetCommonRelativeUrl("StyleSheet/Global.css")%>" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="<%=cssPath1 %>CommonUXControls/StyleSheet/se.ui.min.css" /> 
<link rel="stylesheet" type="text/css" href="<%=cssPath1%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
<link rel="stylesheet" type="text/css" href="<%=cssPath1%>TelerikAjax/StyleSheet/AWTWindow/Window.css">
<link rel="stylesheet" type="text/css" href="<%=cssPath1%>TelerikAjax/StyleSheet/AWTTabStrip/TabStrip.AWTTabStrip.css">

<style type="text/css">
    .inlineWidthCSS {
        width:220px !important;
        max-width:220px !important;
    }
</style>
    <script>
        // Initialize locales for message dialog
        se.ui.messageDialog.setGlobalOptions({
            localization: { // All localization related default can be set
                closeButtonCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                okButtonCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                cancelButtonCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                showDetailsCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                hideDetailsCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
            }
        });
    </script>
<div id="divCalendarList" style="height: 100%">
    <table id="HeaderId" style="width: 100%; height: 6%; border-width: 0; border-spacing: 0px;" >
        <tr class="ListHeaderCss">
            <td class="fontheading" style="vertical-align: middle; padding-left: 8px; width: 80%;">
                <img alt="" src="<%=calControl.GetThemeRelativeUrl("Repository/ListControl/images/calendar.png")%>"
                    style="vertical-align: middle" />
                <span style="vertical-align: middle"><%=CalendarHeading%></span>
                <%if (_UserName!= ""){%>
                - &nbsp;&nbsp;<img src="<%=calControl.GetThemeRelativeUrl("HWS/images/icon-users.png")%>" 
                    alt="" style="border-width: 0; vertical-align: middle">
                <span style="vertical-align: middle"><%=_UserName%></span>
                <%}%>
                
            </td>
            
            <td style="width: auto; text-align: right;">
                <asp:ImageButton ID="btnNewCalendar" runat="server" ImageUrl="<%$ ReplaceTemplateExpn:Common/Images/Add.png %>" Visible="false" />
                <asp:ImageButton ID="btnResource" runat="server" ImageUrl="<%$ ReplaceTemplateExpn:HWS/images/Resource-Calendar.png %>" Visible="false" />
                <asp:ImageButton runat="server" ID="btnDelete" ImageUrl="<%$ ReplaceTemplateExpn:HWS/images/Delete.png %>" Visible="false" />
                <asp:ImageButton runat="server" ID="hiddenDelete" ImageUrl="<%$ ReplaceTemplateExpn:HWS/images/Delete.png %>" style="display:none;" />
            </td>
            <td style="width: 3%; padding: 0px; text-align: center;">
                <a href="#" onclick="JavaScript:ShowCalendarHelp();">
                    <img src="<%=calControl.GetThemeRelativeUrl("HWS/images/icon-help.png")%>"
                        alt="<%=CalendarHelp%>" title="<%=CalendarHelp%>" style="border-width: 0"></a>
            </td>
        </tr>
        <tr>
            <td class="description" colspan="2" style="vertical-align: top; width: 100%; padding-left: 6px;">
             <%=CalendarHeaderDesc%>
            </td>
        </tr>
        <%if (_ErrMsgNoCalendar != "")
          { %>
        <tr>
            <td class="ErrorMsg" style="text-align: center; vertical-align: top" colspan="2">
                <%=_ErrMsgNoCalendar%>
            </td>
        </tr>
        <% } %>
    </table>
    <table style="width: 100%; border-width: 0; border-spacing: 1px; border-collapse: separate; margin: auto; vertical-align: top; height: 90%" >
    
	    <input type="hidden" name="hidCalGuid" id="hidCalGuid" value="<%=_CalendarGuid%>" />
	    <input type="hidden" name="hidResourceId" id="hidResourceId" value="<%=_CalendarGuid%>" />
	    <input type="hidden" name="hidPageType" id="hidPageType" value="<%:_HidPageType%>" />
        <input type="hidden" name="hidcalid" id="hidcalid" value="<%=_InheritsFromId %>" />
        <input type="hidden" name="hidStatus" id="hidStatus" value="<%=_ViwStatus%>" />
        <input type="hidden" name="hidIsConfirmed" id="hidIsConfirmed" value="<%=Microsoft.Security.Application.Encoder.HtmlEncode(_hidIsConfirmed)%>" />
        <input type="hidden" name="hidSetResource" id="hidSetResource" value="<%=Microsoft.Security.Application.Encoder.HtmlEncode(_hidSetResource)%>" />
	
        <div style="display: none">
            <asp:TextBox ID="txtGuid" runat="server" CssClass="inputtext" ReadOnly="true"></asp:TextBox>
	    </div>
        <tr style="height: 100%">
            <td style="vertical-align: top; height: 100%">
                <div id="AddCalendar" style="height: 100%">
                    <table id="calendarWidthSP" style="width: 95%; height: 98%; border-width: 0; vertical-align: top">
                        <tr style="height: 1%; vertical-align: top">
                            <td class="description" style="padding-left: 3px;">
                                <!--removed tr td to fix webpart height issue-->
           <asp:Panel runat="server" ID="pnlCalendarList" Height="100%" Visible="false">
                        <%=CalendarGridHelpText%>                                                           
                   </td>
               	    </tr>
              	    
                        <tr style="height: 90%; vertical-align: top">
                            <td colspan="2" style="vertical-align: top; height: 88%; text-align: left">
                                <asp:Panel ID="pnlMainlist" runat="server" Height="100%">
                                    <ISWebGrid:WebGrid ID="WebGridCalList" runat="server" HorizontalAlign="NotSet" Height="100%" Width="100%"
                                     AllowAutoDataCaching="false" DataCacheStorage="PageCache" DisableFileSystemChecking="true"
                                     EnableWebResources="never" RenderingMode="HTML5">
                                     <LayoutSettings AlternatingColors="true" GridLineStyle="Solid"  
                                         GridLineColor="#afafaf" CellPaddingDefault="2" RowHeightDefault="20px" GridLines="None"
                                         StatusBarVisible="true" AlwaysShowHelpButton="false" AutoFitColumns="true" RowHeaders="No">
                                         <HeaderStyle CssClass="GridHeaderStyle"></HeaderStyle>
                                         <FocusCellStyle CssClass="GridFocusCellStyle"></FocusCellStyle>
                                         <FrameStyle CssClass="GridFrameStyle"></FrameStyle>
                                         <SelectedRowStyle CssClass="GridSelectedRowStyle"></SelectedRowStyle>
                                         <LostFocusRowStyle CssClass="GridSelectedRowStyle"></LostFocusRowStyle>
                                         <AlternatingRowStyle CssClass="GridAlternatingRowStyle" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden"></AlternatingRowStyle>
                                         <StatusBarStyle CssClass="GridStatusBarStyle">
                                             <Padding Top="2px" Left="2px" Bottom="2px" Right="2px"></Padding>
                                         </StatusBarStyle>
                                         <StatusBarCommandStyle Active-CssClass="GridStatusBarStyle" Normal-CssClass="GridStatusBarStyle" Over-CssClass="GridStatusBarStyle">
                                        </StatusBarCommandStyle>
                                         <RowStyle CssClass="GridRowStyle" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden"></RowStyle>
                                         <NewRowStyle CssClass="GridNewRowStyle"></NewRowStyle>
                                         <EditFocusCellStyle CssClass="GridEditFocusCellStyle"></EditFocusCellStyle>
                                         <ClientSideEvents OnRowContextMenu="DisableDefaultContextMenuItems" OnInitialize="InitGrid" OnColumnSort="OnWebgridColumnSort" />
                                         <TextSettings Language="UseCulture"></TextSettings>
                                         <HyperlinkStyle CssClass="GridHyperlinkStyle" />
                                         <ImageSettings RefreshImage="<%$ ReplaceTemplateExpn:Grid/images/refresh.png%>" MoreDataImage="<%$ ReplaceTemplateExpn:Grid/images/LoadMoreData.png%>"
                                                ExportImage="<%$ ReplaceTemplateExpn:Grid/images/Export.png%>" />
                                     </LayoutSettings>
                                     <RootTable GridLineStyle="NotSet">
                                         <TableHeaderStyle CssClass="GridTableHeaderStyle">
                                             <Padding Bottom="4px" Left="4px" Top="4px" Right="4px"></Padding>
                                         </TableHeaderStyle>
                                     </RootTable>
                                 </ISWebGrid:WebGrid>
                                </asp:Panel>
                           </td>
                        </tr>
                        <asp:HiddenField runat="server" ID="hdnUserName"></asp:HiddenField>
					    
                    </asp:Panel>
                
                    <asp:Panel runat="server" ID="pnlCalendarAdd" Height="96%">
                        
                            <%if(_ErrMsg != ""){ %>
                                <%ShowMessage(_ErrMsg); %>
                            <% } %>
                        <table style="width: 100%; vertical-align: top;">
                                <tr>
                                <td style="height: 5px; vertical-align: top; width: 2%;">
                                    <asp:ImageButton ID="btnListCal" runat="server" ImageUrl="<%$ ReplaceTemplateExpn:HWS/Images/Back-Previous.png %>" />
                                    </td>
                                    <td>
                                    <table style="width: 100%; height: 95%; vertical-align: top; margin-left: 20px; border-width: 0px; border-spacing: 1px; border-collapse: separate; overflow: auto">
                                        <tr style="vertical-align: top; height: 1%">
                                
                            <%if (_IsResource != "Yes"){%>
                                            <td class="lefttdbg" style="width: 35%; vertical-align: top; text-align: left; padding: 8px;" colspan="2">
                                                <span class="subtitle"><%=CalendarName%> </span>
                                                <img alt="" src="<%=calControl.GetThemeRelativeUrl("hws/images/mandatoryicon.gif")%>" style="vertical-align: top" visible="true" />
                                    <br />
                                    <span class="description"><%=CalendarNameDesc%></span>
                                </td>
                            <%}%>
                            <%if (_IsResource == "Yes"){%>    
                                            <td colspan="2" style="display: none">
                            <%  } else { %>
                                            <td colspan="2" style="text-align: left; padding: 8px">
                            <% } %>                             
                                                <asp:TextBox ID="txtName" runat="server" CssClass="inputtext" MaxLength="100" Width="353px"></asp:TextBox>
                                </td>                        
                            </tr>
                            <tr>
                                            <td class="lefttdbg" style="width: 35%; text-align: left; height: 12%; vertical-align: top; padding: 8px;" colspan="2">
                                    <span class="subtitle"><%=CalendarTimeZone%> </span>
                                    <br />
                                    <span class="description"><%=CalendarTimeZoneDesc%></span>
                                </td>
                                            <td colspan="2" style="vertical-align: top; text-align: left; padding: 8px; width: 357px !important;">
                                                <asp:DropDownList runat="server" ID="cboTimeZone" Width="357px" CssClass="inputselect"></asp:DropDownList>
                                </td>
                            </tr>
                                        <tr style="height: 12%; vertical-align: top; text-align: left">
                                            <td class="lefttdbg" style="width: 35%; vertical-align: top; height: 70%; padding: 8px;" colspan="2">
                                    <span class="subtitle"><%=CalendarInherits%> </span>
                                    <br />
                                    <span class="description"><%=CalendarInheritsDesc%> </span>
                                </td>
                                            <td colspan="2" style="height: 10%; vertical-align: top; padding: 8px">
                                                <div id="cmbLHS" style="width: 500px; height: 0px;">
                                                    <input type="hidden" name="hidcmbLHS_Input" id="hidcmbLHS_Input" value="" />
                                                    <input value="<%=_InheritsFrom%>" id="cmbLHS_Input" readonly name="cmbLHS_Input" onclick="ToggleTreeView()" style="width: 200px" class="inputtext">
                                                    <img alt="" src="<%=calControl.GetThemeRelativeUrl("HWS/images/calendar-1.png")%>" onmouseover="javascript:ChangeCalendarImage(this,'1');" onmouseout="javascript:ChangeCalendarImage(this,'2');" name="cmbLHS_Image" align="absmiddle" id="cmbLHS_Image" onclick="ToggleTreeView()"></img>&nbsp;
                                        <asp:Button ID="btnViewCalendar" runat="server" CssClass="inputbutton" Text="View" />
                                                    <div id="treeDiv" style="position: absolute; overflow: auto; visibility: hidden; border: solid 1px; background: white; height: 100px; width: 0px">
                                           
                                               <telerik:RadTreeView  ID = "RadTree1" Height="100" runat="server" AutoPostBack="false" OnClientNodeClicking = "ProcessClientClick">
                                              </telerik:RadTreeView>         
                                          
                                        </div>                                        
                                    </div>
                                </td>
                            </tr>
                            <%if (!_IsDefaultProvider){%>
                                        <tr style="vertical-align: top; height: 1%">
                                            <td class="lefttdbg" style="width: 35%; vertical-align: top; padding: 8px;" colspan="2">
                                    <span class="subtitle"><%=CalendarProvider%> </span>
                                    <br />
                                    <span class="description"><%=CalendarProviderDesc%></span>
                                </td>
                                            <td class="righttdbg" colspan="2" style="padding: 8px;">
                                                <asp:DropDownList runat="server" ID="cboProvider" CssClass="inputselect"></asp:DropDownList>
                                </td>
                            </tr>
                            <%}%>
                        </table>
                                    </td>
                                </tr>
                            
                            </table> 
                                        
                            
                        
                    <!--Start Default-->
                <%if (!_IsNew){ %>
               <%-- <tr>
                    <td style="height:50%">--%>
                       <div style="height: 50%;">
                        <table style="border-width: 0; width: 100%; margin: auto; border-spacing: 1px; border-collapse:separate; vertical-align:top; height: 100%">
                            <tr style="height: 100%">
                                <td style="vertical-align: top; height: 100%; padding: 1px">
                                   <telerik:RadTabStrip ID="RadTabStrip1" runat="server" MultiPageID="multiPageContent" AutoPostBack="true"  RenderMode="Classic"  Skin="AWTTabStrip"  SelectedIndex="0" Width="100%" EnableEmbeddedSkins="false">
                                    <Tabs>
                                    <telerik:RadTab ID="Tab1"  runat="server" Text="General" Width="90px"></telerik:RadTab>
                                     <telerik:RadTab ID="Tab2" runat="server" Text="Days" Width="90px"></telerik:RadTab>
                                     <telerik:RadTab ID="Tab3" runat="server" Text="Date" Width="90px"></telerik:RadTab>
                                    </Tabs>

                                   </telerik:RadTabStrip>
                                    <telerik:RadMultiPage ID="multiPageContent" runat="server"  CssClass="PageViewCss"  SelectedIndex="0" Width="100%" Height="100%" >
                                    <telerik:RadPageView ID="Page1" runat="server" Height="90%">
                                        <ISWebGrid:WebGrid
                                            ID="WebGridGeneral"
                                            runat="server"
                                            Height="100%"
                                            HorizontalAlign="NotSet"
                                            Width="100%" AllowAutoDataCaching="false" DataCacheStorage="PageCache" DisableFileSystemChecking="true" EnableWebResources="never">
                                            <LayoutSettings AlternatingColors="true"
                                                GridLineStyle="Solid" GridLineColor="#afafaf"
                                                CellPaddingDefault="2" RowHeightDefault="20px"
                                                GridLines="None" StatusBarVisible="true" AlwaysShowHelpButton="false" RowHeaders="No" AutoFitColumns="true" AutoHeight="false">
                                                <HeaderStyle CssClass="GridHeaderStyle"></HeaderStyle>
                                                <FocusCellStyle CssClass="GridFocusCellStyle"></FocusCellStyle>
                                                <FrameStyle CssClass="GridFrameStyle"></FrameStyle>
                                                <SelectedRowStyle CssClass="GridSelectedRowStyle"></SelectedRowStyle>
                                                <LostFocusRowStyle CssClass="GridSelectedRowStyle"></LostFocusRowStyle>
                                                <AlternatingRowStyle CssClass="GridAlternatingRowStyle"></AlternatingRowStyle>
                                                <StatusBarStyle CssClass="GridStatusBarStyle">
                                                    <Padding Top="2px" Left="2px" Bottom="2px" Right="2px"></Padding>
                                                </StatusBarStyle>
                                                <StatusBarCommandStyle Active-CssClass="GridStatusBarStyle" Normal-CssClass="GridStatusBarStyle" Over-CssClass="GridStatusBarStyle">
                                        </StatusBarCommandStyle>
                                                <RowStyle CssClass="GridRowStyle" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden"></RowStyle>
                                                <ClientSideEvents OnRowContextMenu="DisableDefaultContextMenuItems" OnAfterResponseProcess="ResizeGrid" OnInitialize="InitGrid" OnColumnSort="OnWebgridColumnSort"  />
                                                <TextSettings Language="UseCulture"></TextSettings>
                                                <ImageSettings RefreshImage="<%$ ReplaceTemplateExpn:Grid/images/refresh.png%>" MoreDataImage="<%$ ReplaceTemplateExpn:Grid/images/LoadMoreData.png%>"
                                                        ExportImage="<%$ ReplaceTemplateExpn:Grid/images/Export.png%>" />
                                            </LayoutSettings>
                                            <RootTable GridLineStyle="NotSet">
                                                <TableHeaderStyle CssClass="GridTableHeaderStyle">
                                                    <Padding Bottom="4px" Left="4px" Top="4px" Right="4px"></Padding>
                                                </TableHeaderStyle>
                                            </RootTable>
                                        </ISWebGrid:WebGrid>
                                         </telerik:RadPageView>
                                         <telerik:RadPageView ID="Page2" runat="server" Height="90%">
                                          <ISWebGrid:WebGrid ID="WebGridDay" runat="server" Height="100%" HorizontalAlign="NotSet"
                                            Width="100%" AllowAutoDataCaching="false" DataCacheStorage="PageCache" DisableFileSystemChecking="true" EnableWebResources="never">
                                            <LayoutSettings AlternatingColors="true" GridLineStyle="Solid" CellPaddingDefault="2" RowHeightDefault="20px" GridLines="None" StatusBarVisible="true" AlwaysShowHelpButton="false" RowHeaders="No" AutoFitColumns="true">
                                                <HeaderStyle CssClass="GridHeaderStyle"></HeaderStyle>
                                                <FocusCellStyle CssClass="GridFocusCellStyle"></FocusCellStyle>
                                                <FrameStyle CssClass="GridFrameStyle"></FrameStyle>
                                                <SelectedRowStyle CssClass="GridSelectedRowStyle"></SelectedRowStyle>
                                                <LostFocusRowStyle CssClass="GridSelectedRowStyle"></LostFocusRowStyle>
                                                <RowStyle CssClass="GridRowStyle" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden"></RowStyle>
                                                <NewRowStyle CssClass="GridNewRowStyle"></NewRowStyle>
                                                <EditFocusCellStyle CssClass="GridEditFocusCellStyle"></EditFocusCellStyle>
                                                <StatusBarStyle CssClass="GridStatusBarStyle">
                                                    <Padding Top="2px" Left="2px" Bottom="2px" Right="2px"></Padding>
                                                </StatusBarStyle>
                                                <StatusBarCommandStyle Active-CssClass="GridStatusBarStyle" Normal-CssClass="GridStatusBarStyle" Over-CssClass="GridStatusBarStyle">
                                        </StatusBarCommandStyle>
                                                    <ClientSideEvents OnRowContextMenu="DisableDefaultContextMenuItems" OnAfterResponseProcess="ResizeGrid" OnInitialize="InitGrid" OnColumnSort="OnWebgridColumnSort"  />
                                                <TextSettings Language="UseCulture"></TextSettings>
                                                <ImageSettings RefreshImage="<%$ ReplaceTemplateExpn:Grid/images/refresh.png%>" MoreDataImage="<%$ ReplaceTemplateExpn:Grid/images/LoadMoreData.png%>"
                                                        ExportImage="<%$ ReplaceTemplateExpn:Grid/images/Export.png%>" />
                                            </LayoutSettings>
                                            <RootTable GridLineStyle="NotSet"></RootTable>
                                        </ISWebGrid:WebGrid>
                                            </telerik:RadPageView>
                                        <telerik:RadPageView ID="PageView1" runat="server" Height="90%">
                                         <ISWebGrid:WebGrid ID="WebGridDate" runat="server" Height="100%" HorizontalAlign="NotSet"
                                            Width="100%" AllowAutoDataCaching="false" DataCacheStorage="PageCache" DisableFileSystemChecking="true" EnableWebResources="never">
                                            <LayoutSettings AlternatingColors="true" GridLineStyle="Solid" GridLineColor="#afafaf" CellPaddingDefault="2" RowHeightDefault="20px" GridLines="None" StatusBarVisible="true" AlwaysShowHelpButton="false" RowHeaders="No" AutoFitColumns="true">
                                                <HeaderStyle CssClass="GridHeaderStyle"></HeaderStyle>
                                                <FocusCellStyle CssClass="GridFocusCellStyle"></FocusCellStyle>
                                                <EditTextboxStyle CssClass="LeftMenuEditStyle"></EditTextboxStyle>
                                                <FrameStyle CssClass="GridFrameStyle"></FrameStyle>
                                                <SelectedRowStyle CssClass="GridSelectedRowStyle"></SelectedRowStyle>
                                                <LostFocusRowStyle CssClass="GridSelectedRowStyle"></LostFocusRowStyle>
                                                <AlternatingRowStyle CssClass="GridAlternatingRowStyle"></AlternatingRowStyle>
                                                <StatusBarStyle CssClass="GridStatusBarStyle">
                                                    <Padding Top="2px" Left="2px" Bottom="2px" Right="2px"></Padding>
                                                </StatusBarStyle>
                                                <StatusBarCommandStyle Active-CssClass="GridStatusBarStyle" Normal-CssClass="GridStatusBarStyle" Over-CssClass="GridStatusBarStyle">
                                        </StatusBarCommandStyle>
                                                <RowStyle CssClass="GridRowStyle" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden"></RowStyle>
                                                <NewRowStyle CssClass="GridNewRowStyle"></NewRowStyle>
                                                <EditFocusCellStyle CssClass="GridEditFocusCellStyle"></EditFocusCellStyle>
                                                    <ClientSideEvents OnRowContextMenu="DisableDefaultContextMenuItems" OnAfterResponseProcess="ResizeGrid" OnInitialize="InitGrid" OnColumnSort="OnWebgridColumnSort"  />
                                                <TextSettings Language="UseCulture"></TextSettings>
                                                <ImageSettings RefreshImage="<%$ ReplaceTemplateExpn:Grid/images/refresh.png%>" MoreDataImage="<%$ ReplaceTemplateExpn:Grid/images/LoadMoreData.png%>"
                                                        ExportImage="<%$ ReplaceTemplateExpn:Grid/images/Export.png%>" />
                                            </LayoutSettings>
                                            <RootTable GridLineStyle="NotSet"></RootTable>
                                        </ISWebGrid:WebGrid>
                                      </telerik:RadPageView>  
                                    </telerik:RadMultiPage>
                             </td>
                        </tr>
                    </table>  
                </div>
            <%} %> 
            </div>
                <div style="float: right;">               
                    <div style="text-align: right; vertical-align: bottom;">
                        <asp:Button ID="btnSetWorkslot" runat="server" CssClass="inputbutton" Text="Set Workslot" />
                        <asp:Button ID="btnSave" runat="server" CssClass="inputbutton" Text="Save" />
                    <%--<asp:Button runat="server" ID="btnListCal" Text="List" CssClass="inputbutton"   />--%>
                    <%--<asp:Button runat="server" ID="btnDelete" Text = "Delete" CssClass="inputbutton"  />--%>
                    <%if (_UserName== ""){%>
                        <asp:Button runat="server" ID="btnPackage" Visible="true" CssClass="inputbutton inlineWidthCSS" Text="Add To Package Template"  />
                    <%} %> 
                        </div>
            </div>
        </asp:Panel>
        </td>
        </tr>
       </table>
       </td>
        </tr>
    </table>
   </div>
                           

    
   <div style="height: 100px; width: 50px; display: none;">
        <input type="button" id="SearchUser" value="Open Window" />
        <telerik:RadWindowManager ID="Singleton" Height="280" Width="700" Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false"
         runat="server" BackColor="Black" Behaviors="Close, Move" DestroyOnClose="true" Overlay="false" RenderMode="Classic" VisibleStatusbar="false">  
           <Windows>
               <telerik:RadWindow ID="RadWindow1" Height="300px" Width="555px" runat="server" OpenerElementID="SearchUser" NavigateUrl="UserLookup.aspx" Left="" Title="User Lookup" Top="">
               </telerik:RadWindow>
               <telerik:RadWindow ID="PackageWindow" Height="580px" Width="555px" runat="server" Left="" Title="Add To Package Template" Top="" Behaviors="Close, Minimize, Maximize, Move, Resize, Reload">
               </telerik:RadWindow>
           </Windows>
         </telerik:RadWindowManager>
    </div>

                                                        
  
<script type="text/javascript">
  
  function DisableDefaultContextMenuItems(gridId, rowType, rowEl, rowMenu)
  {
    
  var i;
  var grid = wgGetGridById(gridId);                  
    if(rowType =="Record")
    {
        // hide the default context menu
        for (i=0;i<=43;i++)
        {                 
         //rowMenu.Items[i].visible = false;
         rowMenu.Items[i].Hide(); 
         
        }                       
                   
    } 	
 }

  var gridName1 = null;
  var count = 1;

  function setGridTempHeight()
  {
      
      if (tempcalControlHeight != null) {
          var calControlHeight = tempcalControlHeight;


          var grid = ISGetObject(gridName1);
          var tempHeight = calControlHeight * 45 / 100 + 'px';

          if (tempcalControlHeight < 550) {
              if (navigator.userAgent.indexOf("Firefox") > -1) {
                  tempHeight = calControlHeight * 36 / 100 + 'px';
              }
              else {
                  
                  tempHeight = calControlHeight * 35 / 100 + 'px';
              }
          }

          if (grid != null) {              
              grid.SetHeight(tempHeight);
          }

      }
  }

  function refreshGridChrome() {
      var grid = ISGetObject(gridName1);
      grid.Refresh();
  }

 function RefreshGridTimeOutCalendar()
  {     
     var grid = ISGetObject(gridName1);
     grid.RefreshAll();
     window.setTimeout(setGridTempHeight, 250);
     window.setTimeout(function () { wgDoResize(true, true); }, 1);

     //if (count === 1) {
     //    count = 2;
     //    grid.RefreshAll();
     //    if (tempcalControlHeight > 550)
     //    {
     //        if (navigator.userAgent.toLowerCase().indexOf('chrome') > 0 || navigator.userAgent.indexOf("Firefox") > -1) {
     //            window.setTimeout(setGridTempHeight, 1250);
     //            window.setTimeout(refreshGridChrome, 1250);
     //        }
     //        else {
     //            // Set gridheight for IE browser 
     //    //        grid.RefreshAll();
     //            window.setTimeout(setGridTempHeight, 250);
     //        }
     //    }
     //    else {
     //        if (navigator.userAgent.toLowerCase().indexOf('chrome') > 0 || navigator.userAgent.indexOf("Firefox") > -1) {
     //            window.setTimeout(setGridTempHeight, 1250);
     //            window.setTimeout(refreshGridChrome, 1250);
     //        }
     //        else {
     //            // Set gridheight for IE browser 
     //            //grid.RefreshAll();
     //            window.setTimeout(setGridTempHeight, 250);
     //        }
     //    }
     //}
     //else{
     //    grid.RefreshAll();
     //    if (tempcalControlHeight > 550) {
     //        if (navigator.userAgent.toLowerCase().indexOf('chrome') > 0 || navigator.userAgent.indexOf("Firefox") > -1) {
     //            var calControlHeight = tempcalControlHeight;
     //            var gridtemp = ISGetObject(gridName1);
     //            var tempHeight = calControlHeight * 45 / 100 + 'px';
     //            if (grid != null) {
     //                gridtemp.SetHeight(tempHeight);
     //                window.setTimeout(function () { wgDoResize(true, true); }, 1);
     //            }
     //        }
     //        else {
     //            // Set gridheight for IE browser 
     //            window.setTimeout(setGridTempHeight, 250);
     //        }
     //    }
     //    else {
     //        if (navigator.userAgent.toLowerCase().indexOf('chrome') > 0 || navigator.userAgent.indexOf("Firefox") > -1) {
     //            var calControlHeight = tempcalControlHeight;
     //            var gridtemp = ISGetObject(gridName1);
     //            var tempHeight = calControlHeight * 40 / 100 + 'px';
     //            if (navigator.userAgent.indexOf("Firefox") > -1) {
     //                tempHeight = calControlHeight * 36 / 100 + 'px';
     //            }

     //            if (grid != null) {
     //                gridtemp.SetHeight(tempHeight);
     //                window.setTimeout(function () { wgDoResize(true, true); }, 1);
     //            }
     //        }
     //        else {
     //            // Set gridheight for IE browser 
     //            window.setTimeout(setGridTempHeight, 250);
     //        }
     //    }
     //}

    
 }
 function RefreshCalendarGrid(gridName)
 {     
    gridName1 = gridName;  
    window.setTimeout(RefreshGridTimeOutCalendar, 550);
 }
 
function findPosX(obj)
{
var curleft = 0;
if (obj.offsetParent)
{
while (obj.offsetParent)
{
  curleft += obj.offsetLeft
  obj = obj.offsetParent;
}
}

else if (obj.x)
curleft += obj.x;

return curleft;
}
function findPosY(obj)
{
var curtop = 0;
if (obj.offsetParent)
{
while (obj.offsetParent)
{
  curtop += obj.offsetTop
  obj = obj.offsetParent;
}
}
else if (obj.y)
curtop += obj.y;
return curtop;
}




function findPos(ctlObj)
{
var element = ctlObj;
var x1 = 0;
var y1 = element.offsetHeight;

//Walk up the DOM and add up all of the offset positions.
while (element.offsetParent && element.tagName.toUpperCase() != 'BODY')
{
x1 += element.offsetLeft;
y1 += element.offsetTop;
element = element.offsetParent;
}

x1 += element.offsetLeft;
y1 += element.offsetTop;

divXPos=x1;
divYPos=y1;
}

function OntreedivLeave()
{
    
}


function ToggleTreeView()
{
    
    if (document.getElementById("treeDiv").style.visibility == "visible")
    {
		HideTreeView();
		//document.getElementById("cmbLHS").style.display="none";		
		
	}
	else		
		ShowTreeView();		
	
	
		
}

function ShowTreeView()
{
	
	document.getElementById("treeDiv").style.visibility = "visible";
	/*var cmbLHSObj = document.getElementById("cmbLHS_Input");
	/var x = findPosX(cmbLHSObj);
	var y = findPosY(cmbLHSObj);
	
	document.getElementById("treeDiv").style.top=(parseInt(y) + 18)+"px";
	document.getElementById("treeDiv").style.left= x +"px";
	 */
	 //finding x and y position is giving problem in webapart mode and directly assigning relative position to show the treeview nect below the textbox.
	 document.getElementById("treeDiv").style.position = "relative";
	 document.getElementById("treeDiv").style.width = "314px";//set the width onclick of treeview to avoid horizantal scrollbar
    // alert(document.getElementById("treeDiv").style.height);
	 //document.getElementById("treeDiv").style.height = "200px"; // Set the height, otherwise Firefox will not display the div, it only displys the contents
	 //document.getElementById("treeDiv").style.width = parseInt(document.getElementById("<%=calControl.ClientID%>").style.width)* 25/100+'px';
	 
}

function HideTreeView()
{
	document.getElementById("treeDiv").style.visibility = "hidden";
}

    function ProcessClientClick(sender, eventArgs)
    {
        var node = eventArgs.get_node();
        lhsvalue = node.get_text();
        document.getElementById("cmbLHS_Input").value=lhsvalue;
        document.getElementById("hidcmbLHS_Input").value = node.get_value();
        document.getElementById("hidcalid").value = node.get_value();
        HideTreeView();
    }
var opener = null;
function  OpenWorkslotWindow(type)
{
    
    var wt="565";//"565";
    var ht = "410";
    var leftPos;
	var topPos;
	if(type != "1")
	{
	    ht="540";
	}
	
	if (screen)
	{
		leftPos = (screen.width / 2) - wt/2;
		topPos = (screen.height / 2) - ht/2;
	}
	
	var calGuid = document.getElementById("hidCalGuid").value;
	
	var appName = "<%=ApplicationName %>";
	
	var clientId = "<%=_ClientId %>";
	
	var canAdd = "<%=_CanAddCalendarWorkSlot %>";
	
	var canDelete = "<%=_CanDeleteCalendarWorkSlot %>";
	
    var txtNameObj = document.getElementById(clientId+"_txtName");
    
	var calName = txtNameObj.value;

    var varSt=document.getElementById("hidStatus").value;
    if(varSt == "")
    {    
    //window.open("<%=calControl.GetCommonRelativeUrl("../hws/workslot.aspx")%>?id="+calGuid+"&add="+canAdd+"&delete="+canDelete+"&type="+type+"&calName="+calName+"&appname="+appName+"","WorkSlot",'toolbar=no,width='+ wt +',height='+ ht +',resizable=no,toolbars=0,Left='+leftPos+',Top='+topPos+'');
        opener = window.open("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(calControl.GetWorkSlotURL("workslot.aspx"), false)%>id="+calGuid+"&add="+canAdd+"&delete="+canDelete+"&type="+type+"&calName="+escape(calName)+"&appname="+appName+"","WorkSlot",'toolbar=no,width='+ wt +',height='+ ht +',resizable=yes,toolbars=0,Left='+leftPos+',Top='+topPos+'');    
     }
    return false;
}
  

function OpenSelfWindow()
 { 
   var varCalGuid=document.getElementById("hidcalid").value;
   var varParId = "<%=DocId %>";
  if(varCalGuid != "" && document.getElementById("cmbLHS_Input").value != "")
  {
      var leftPos;
      var topPos;

      
    leftPos = (screen.width / 2) - 700 / 2;
    topPos = (screen.height / 2) - 510 / 2;
      

     var templateURL = '<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(calControl.GetTemplateRelativeUrl("CalendarView.aspx"), false)%>';
     var appName = "<%=ApplicationName %>";
        if("<%=_IsResource%>" == "No")
        {
            window.open(templateURL + "?view=yesy&visible=false&application="+appName+"&Id=" + varCalGuid,'Calendar','toolbar=no,height=510,width=700,resizable=yes,Left='+leftPos+',Top='+topPos,'');
        }
        else
        {
            window.open(templateURL + "?view=yesy&visible=false&application="+appName + "&Id=" + varCalGuid,'Calendar','toolbar=no,height=510,width=700,resizable=yes,Left=' + leftPos + ',Top=' + topPos,'');
        }
     }
     else
     {
     //window.open(window.location.pathname + "?view='yesy'&id=" + "<%=DocId %>",'Calendar','toolbar=no,height=478,width=710,resizable=no','');
      se.ui.messageDialog.showError("<%=resourceManager.GlobalResourceSet.GetString("Calendar_Heading") %>", '<%=CalendarViewAlert%>');
     }
   
   return false;
 }
function ValidateCalendar(type)
{
    var clientId = "<%=_ClientId %>";
    if(type == "1")
    {
        var txtNameObj = document.getElementById(clientId+"_txtName");
        
        if(txtNameObj.value == "")
        {
            se.ui.messageDialog.showError("<%=resourceManager.GlobalResourceSet.GetString("Calendar_Heading") %>", '<%=ErrCalendarName%>', function () { txtNameObj.select(); });
            return false;
        }
        var isResource = "<%=_IsResource %>";
        if(isResource == "Yes")
        {
            if(document.getElementById("cmbLHS_Input").value  == "")
            {
                se.ui.messageDialog.showError("<%=resourceManager.GlobalResourceSet.GetString("Calendar_Heading") %>", '<%=CalendarViewAlert%>');
                return false;
            }
        }
        document.getElementById("hidPageType").value  = "save";
    }
    else if(type == "2")
    {
        document.getElementById("hidPageType").value  = "add";
        
    }
    else if(type == "3")
    {
        
        document.getElementById("hidPageType").value  = "list";
        
    }
    return true;
}
function DeleteCalendar()
{
    se.ui.messageDialog.showConfirmation("<%=resourceManager.GlobalResourceSet.GetString("Calendar_Heading") %>", "<%=ErrConfirmDelete%>", function (userResponse)
    {
        if (userResponse)
        {
            document.getElementById("hidPageType").value = "delete";
            document.getElementById("<%=hiddenDelete.ClientID%>").click();
        }
    });
}
function ValidateButtons()
{
    var isDefault = "<%=_IsDefaultProvider%>";
    
   /* if(isDefault == "False")
    {
        if(document.getElementById("btnNew") != null)
            document.form1.btnNew.disabled = true;
        if(document.getElementById("Button1") != null)
            document.form1.Button1.disabled = true;
        if(document.getElementById("Button2") != null)
            document.form1.Button2.disabled = true;
    }*/
}
function ChangeCalendarImage(obj, type)
		{
			if (type=='1')
			{
				obj.src = '<%=calControl.GetThemeRelativeUrl("HWS/images/calendar-2.png")%>';
				ToggleTreeView();
			}
			else if(type=='2')
			{
				obj.src = '<%=calControl.GetThemeRelativeUrl("HWS/images/calendar-1.png")%>';
			}
		}
		
		
        function ShowCalendarHelp()
            {
            var w, h;
            w = screen.availWidth;
            h = screen.availHeight;
            var left = (w / 2) - (800 / 2);
            var top = (h / 2) - (400 / 2);
            var topValue = 'top=' + top;
            var leftValue = 'left=' + left;
                //window.open('<%:calControl.GetTemplateRelativeUrl("../Help/en-US/AboutTheCalendarControl.html")%>','','height=600,width=800,resizable=yes,status=no;scrolbars=yes');
            window.open('<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(calControl.GetHelpPageUrl(), false)%>AboutTheCalendarControl.html', '', topValue + "," + leftValue + ',height=400,width=800,resizable=yes,status=no,scrollbars=yes');
            }
     
        if(document.getElementById("hidCalGuid").value  != "00000000-0000-0000-0000-000000000000" && document.getElementById("hidPageType").value != "add" && document.getElementById("hidPageType").value != "delete")
        {
            if(document.getElementById("cmbLHS_Input") != null)
            {
                document.getElementById("cmbLHS_Input").disabled = true;//HideTreeView();
                document.getElementById("cmbLHS_Image").disabled = true;
                document.getElementById("cmbLHS_Image").style.display="none";//hiding as it is not disabling in firefox
                
            }
        }   
        else
        {
            if(document.getElementById("cmbLHS_Input") != null)
            {
                document.getElementById("cmbLHS_Input").disabled = false;//HideTreeView();
                document.getElementById("cmbLHS_Image").disabled = false;
            }
        }
   //ReSizeCalendarGrid();
   function ReSizeCalendarGrid()
   {
   
    var CalendarHeights = '<%=calControl.CalendarControlHeight%>';
    
       if (CalendarHeights == '0px') {
            var Grid1 = ISGetObject("WebGridCalList");
            
            if(!(Grid1 == 'undefined' || Grid1 == null))
                {
                Grid1.SetHeight(document.body.clientHeight - 310);//Sharepoint - 350 //SP 2010 - 150 EC - 310 (right now not fixing for 2010  since no flag to check whether it is 2010 webapp)
                }
      }
   }
   
   ResizeCalendarPage();
   function ResizeCalendarPage()
   {
        var CalendarHeights = '<%=calControl.CalendarControlHeight%>';
        if (CalendarHeights != '0px') 
            document.getElementById("divCalendarList").style.height = CalendarHeights;
   }
   
    function callAfter500()
    {
        
        var calClientId = "<%=calControl.ClientID%>";
        var CalendarHeights = '<%=CalendarHeight%>';
        var calControlWidth, calControlHeight;
          if (document.getElementById(calClientId).style.height == "")
          {
            calControlWidth = document.body.clientWidth;
            calControlHeight = document.body.clientHeight;
          }
          else
          {
            calControlWidth = parseInt(document.getElementById(calClientId).style.width);
            calControlHeight = parseInt(document.getElementById(calClientId).style.height);
          }

        var calDivHeight, editGridHeight;
        var panelAddCalendar = document.getElementById('<%=pnlCalendarAdd.ClientID %>');
        var webGridCalList = document.getElementById('<%=WebGridCalList.ClientID %>');
        var Grid1 = ISGetObject("WebGridCalList");
    
        if (CalendarHeights == '0px' || CalendarHeights == '0') // If the calendar height is not set
        {
            if (panelAddCalendar !== null) // Add new calendar screen
            {                
                if (calControlHeight > 500)
                {
                    calDivHeight = calControlHeight * 85 / 100;
                }
                else
                {
                    calDivHeight = calControlHeight * 75 / 100;
                }
            }
            else // Calendar list
            {
                
                if (calControlHeight > 500)
                {
                    editGridHeight = calControlHeight * 85 / 100;
                    calDivHeight = calControlHeight * 85 / 100;
                }
                else if (calControlHeight > 250)
                {
                    if (navigator.appName == 'Netscape') 
                        editGridHeight = calControlHeight * 50 / 100;
                    else
                        editGridHeight = calControlHeight * 55 / 100;
                    calDivHeight = calControlHeight * 80 / 100;
                }
                  else {
                    editGridHeight = calControlHeight * 40 / 100;
                    calDivHeight = calControlHeight * 62 / 100;
                }
            }
            
            if (navigator.appName == 'Netscape') {
                // Refreshing grids
                //commented as if user clicks on day tab while general tab grid is still refreshing then page crash happens
                //RefreshCalendarSlotGrids();
                document.getElementById('AddCalendar').style.height = calDivHeight  + 'px';
                if (webGridCalList !== null)
                {
                    Grid1.SetHeight(editGridHeight + 'px');
                    document.getElementById('AddCalendar').style.width = (calControlWidth * 99 / 100) + 'px';
                      if (calControlWidth < 500)
                        Grid1.FrameObj.style.width = (calControlWidth * 97 / 100) + 'px';
                }
            }
            else {
                if (panelAddCalendar !== null)
                {
                    if (calControlHeight < 500)
                    {
                       if ('<%=_UserName%>' == '')
                          document.getElementById('AddCalendar').style.height = calDivHeight +30 + 'px';
                    else
                          document.getElementById('AddCalendar').style.height = calDivHeight +30 + 'px';
                    }
                }
                if (webGridCalList !== null && editGridHeight !== undefined)
                {
                    webGridCalList.style.height = editGridHeight + 'px';
                    Grid1.SetHeight(editGridHeight + 'px');
                    webGridCalList.parentNode.style.height = editGridHeight - 10 + 'px';
                 
                }
            }
        }

          // For MSIE grid height was not cuming propelry 
          var ua = window.navigator.userAgent;
          var msie = ua.indexOf('MSIE ');
          var trident = ua.indexOf('Trident/');
          
         
          
          if (calControlHeight < 525) {
              tempcalControlHeight = calControlHeight;
              var Grid2 = ISGetObject("WebGridCalList");
              try {
                  Grid2.SetHeight(calControlHeight - 80 + 'px');
              }
              catch (e) { }

              var generalGrid = ISGetObject("WebGridGeneral");
              var dayGrid = ISGetObject("WebGridDay");
              var dateGrid = ISGetObject("WebGridDate");

             
                document.getElementById('AddCalendar').style.height = calDivHeight + 5 + 'px';
                if (document.getElementById("errormsgtd"))
                {
                    if(document.getElementById("errormsgtd").innerText !="")
                        calControlHeight = calControlHeight - 25;
                }

                try
                {
                   generalGrid.SetHeight(calControlHeight - 315 + 'px');
                   dayGrid.SetHeight(calControlHeight - 315 + 'px');
                   //dateGrid.SetHeight(calControlHeight - 315 + 'px');
                }
                catch (e)
                {

                }
             
              
              if (msie > 0 || trident > 0)
              {
                  var tempHeight = calControlHeight * 30 / 100 + 'px';
                  //if (generalGrid != null) {
                  //    generalGrid.SetHeight(tempHeight);
                  //    dayGrid.SetHeight(tempHeight);
                  //    dateGrid.SetHeight(tempHeight);
                  //}
              }
              else
              {
                  var tempHeight = calControlHeight * 30 / 100 + 'px';

                  //if (generalGrid != null) {
                      
                  //    generalGrid.SetHeight(tempHeight);
                  //    dayGrid.SetHeight(tempHeight);
                  //    dateGrid.SetHeight(tempHeight);
                  //}

              }

              //document.getElementById("calendarWidthSP").style = calControlHeight;
          }
          else {
              if (msie > 0 || trident > 0) {
                  tempcalControlHeight = calControlHeight;
                  var generalGrid = ISGetObject("WebGridGeneral");
                  var dayGrid = ISGetObject("WebGridDay");
                  var dateGrid = ISGetObject("WebGridDate");
                  var tempHeight = calControlHeight * 45 / 100 + 'px';
                  if (generalGrid != null) {
                      generalGrid.SetHeight(tempHeight);
                      //generalGrid.Refresh();
                      dayGrid.SetHeight(tempHeight);
                      dateGrid.SetHeight(tempHeight);
                  }
              }
              else {
                  tempcalControlHeight = calControlHeight;
                  var generalGrid = ISGetObject("WebGridGeneral");
                  var dayGrid = ISGetObject("WebGridDay");
                  var dateGrid = ISGetObject("WebGridDate");
                  var tempHeight = calControlHeight * 45 / 100 + 'px';
                  if (generalGrid != null) {
                      generalGrid.SetHeight(tempHeight);
                      //generalGrid.Refresh();
                      dayGrid.SetHeight(tempHeight);
                      dateGrid.SetHeight(tempHeight);
                  }
              }
          }
          if (window.parent.parent.location.href.indexOf('FromArchestrA') != -1) {
              document.getElementById('AddCalendar').style.overflowY = 'scroll';
          }

          window.setTimeout(function () { wgDoResize(true, true); }, 600);
    }

     
     
          
      document.getElementById("calendarWidthSP").style.width = 100 + '%';
       
      

    function RefreshCalendarSlotGrids() {
        try {
            var generalGrid = ISGetObject("WebGridGeneral");
            var dayGrid = ISGetObject("WebGridDay");
            var dateGrid = ISGetObject("WebGridDate");
            if (generalGrid !== null) {
                generalGrid.Refresh();
            }
            if (dayGrid !== null) {
                dayGrid.Refresh();
            }
            if (dateGrid !== null) {
                dateGrid.Refresh();
            }
        }
        catch (e) {
        }
    }

    if (navigator.userAgent.toLowerCase().indexOf('chrome') > 0) {
        window.setTimeout(callAfter500, 50);
    }
    else {
        window.setTimeout(callAfter500, 500);        
    }

 //   function ResizeGrid() {
 //       // if (navigator.userAgent.toLowerCase().indexOf('chrome') > 0 || navigator.userAgent.indexOf("Firefox") > -1) 
 //       {
 //           window.setTimeout(function () { wgDoResize(true, true); }, 600);
 //           window.setTimeout(setGridTempHeight, 250);
 //           return true;
 //       }
 //   }
 //ResizeGrid();
</script>								

