<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.HWS.Web.CalendarControl.WorkSlotClass" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<script runat="server">

    protected void cboWeekDays_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void WebGrid1_InitializeDataSource(object sender, DataSourceEventArgs e)
    {

    }
</script>
<script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
<script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>

<link href="<%=wkControl.GetCommonRelativeUrl("StyleSheet/Global.css")%>" rel="stylesheet"   type="text/css"/>
<link rel="stylesheet" type="text/css" href="<%=cssPath1 %>CommonUXControls/StyleSheet/se.ui.min.css" />  
<link rel="stylesheet" type="text/css" href="<%=cssPath1%>TelerikAjax/StyleSheet/AWTCalendar/Calendar.AWTCalendar.css">
<link rel="stylesheet" type="text/css" href="<%=cssPath1%>TelerikAjax/StyleSheet/AWTCalendar/Calendar.css">
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
<script type="text/javascript">
/*<![CDATA[*/
    function CloseWindow()
    {
    
		var windowType = document.getElementById("hidWorkHourType").value;     
        if(windowType == 1)
        {
            
            window.opener.RefreshCalendarGrid("WebGridGeneral");
        }
        else if(windowType ==2)    
        {
            window.opener.RefreshCalendarGrid("WebGridDay");
        }
        else
        {
            window.opener.RefreshCalendarGrid("WebGridDate");
        }
        
        window.close();
    }
    function ValidateCalDate()
    {
       var clientId = "<%=_ClientId %>";
       if(document.getElementById("hidWorkHourType").value == '2')
        {
            if(document.getElementById(clientId+"_cboWeekDays").value == '0')
            {
                se.ui.messageDialog.showError("<%=resourceManager.GlobalResourceSet.GetString("Calendar_WkHeading") %>", "<%=DaysTextDesc%>");
                return false;
            }
            
        }
        if(document.getElementById("hidWorkHourType").value == '3')
        {
            if(document.getElementById(clientId+"_datePickerDate").value == '')
            {
                se.ui.messageDialog.showError("<%=resourceManager.GlobalResourceSet.GetString("Calendar_WkHeading") %>", "<%=DaysTextDesc%>");
                return false;
            }
            
        }
        return true;
        
    }
    function AssignValues()
    {
        //top.frames[0].location.reload();
        if(top.frames[0] != null)
            top.frames[0].form1.submit();
        return true;    
    }
    
/*]]>*/
</script>
<div id="HeaderDiv" style="margin:0px;" >
    <input type="hidden" name="hidGuid" id="hidGuid" value="<%=_CalendarGuid%>" />
    <input id="hidWorkHourType" name="hidWorkHourType" type="hidden" value="<%=Microsoft.Security.Application.Encoder.HtmlEncode(_WorkHourType)%>" />
    <input id="hidWeekDay" name="hidWeekDay" type="hidden" value="<%=Microsoft.Security.Application.Encoder.HtmlEncode(cboWeekDays.SelectedValue)%>" />
    <input id="hidDate" name="hidDate" type="hidden" value="<%=_Date%>" />
    <input id="hidIsHoliday" name="hidIsHoliday" type="hidden" value="<%=_IsHoliday%>" />
    <input id="hidAppName" name="hidAppName" type="hidden" value="<%=ApplicationName%>" />
    <input id="hidAdd" name="hidAdd" type="hidden" value="<%=wkControl.CanAddCalendarWorkSlot%>" />
    <input id="hidDelete" name="hidDelete" type="hidden" value="<%=wkControl.CanDeleteCalendarWorkSlot%>" />
    <input id="hidCssPath" name="hidCssPath" type="hidden" value="<%=wkControl.GetCommonRelativeUrl("StyleSheet/Global.css")%>" />
               
    <table style="width:100%;margin:auto;border-width:0;">
        <tr class="ListHeaderCss">
           <td class="fontheading" colspan="2" style="padding:8px">
                <img src="<%=wkControl.GetThemeRelativeUrl("Repository/ListControl/images/calendar.png")%>" alt="" style="vertical-align:middle" />&nbsp;&nbsp;<%=WkHeading%>
            </td>
        </tr>
       
    </table>
</div>
<%if(_WorkHourType !="1") {%>
<div id="BodyDiv" >   
    <table style="border-width:0px;margin:auto;width:99%" class="tablebg">
        <tr>
            <td class="lefttdbg" style="width: 45%;vertical-align:top" colspan="2">
                <span class="subtitle"><%=DaysText%> </span>
                    <img id="imgTitlemandator" alt="<%=MandatoryText%>" src="<%=wkControl.GetThemeRelativeUrl("hws/images/mandatoryicon.gif")%>" style="vertical-align:middle" visible="true" />                             
                    <br />
                <span class="description"><%=DaysTextDesc%> </span>
            </td>
            <td class="righttdbg" colspan="2">
            <%if(_WorkHourType =="2") {%>
                <asp:DropDownList runat="server" ID="cboWeekDays" CssClass="inputselect">
                        <asp:ListItem Value="su">Sun</asp:ListItem>
                        <asp:ListItem Value="mo">Mon</asp:ListItem>
                        <asp:ListItem Value="tu">Tue</asp:ListItem>
                        <asp:ListItem Value="we">Wed</asp:ListItem>
                        <asp:ListItem Value="th">Thu</asp:ListItem>
                        <asp:ListItem Value="fr">Fri</asp:ListItem>
                        <asp:ListItem Value="sa">Sat</asp:ListItem>
                    </asp:DropDownList>
                    <asp:Button runat="server" Text="Get Details" id="btnSearchDay" CssClass="inputbutton"/>
            <%} %>
            <%if (_WorkHourType == "3"){%>
                <table>
                    <tr>
                        <td>
                          <telerik:RadDatePicker RenderMode="Classic" Width="125px" ID="datePickerDate" runat="server"   Skin="AWTCalendar" EnableEmbeddedSkins="false">
                                    <Calendar ID="Calendar1" runat="server"  Skin="AWTCalendar">
                                    </Calendar>
                          </telerik:RadDatePicker>  
                        </td>
                        <td>
                            <asp:Button runat="server" ID="btnSearchDate" CssClass="inputbutton" Text="Get Details"/>
                        </td>
                    </tr>
                </table>
            <%} %>
            </td>
        </tr>
        <%if (_ShowHoliday){%>
        <tr>
            <td class="lefttdbg" style="width: 45%;vertical-align:top" colspan="2">
                <span class="subtitle"><%=WkHoliday%></span>
                <br />
                <span class="description"><%=WkHolidayDesc%></span>
            </td>
            <td class="righttdbg" colspan="2">
                <asp:RadioButtonList RepeatDirection=Horizontal CssClass="inputradio" runat="server" ID="radIsHoliday" AutoPostBack=true>
                    <asp:ListItem>Yes</asp:ListItem>
                    <asp:ListItem Selected=true>No</asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <%}%>
    </table>
</div>
<%}%>
<div style="height:300px;">
    <table style="border-width:0;width:100%;margin:auto;border-spacing:1px;border-collapse:separate;height:100%;">
        <tr>            
            <td style="text-align:right;height:100%;" colspan="2">
                <iframe src="WorkSLotGridControl.aspx" runat="server" style="height:100%;width:100%;border:none;"  id="frameGrid" ></iframe>
             </td>
        </tr>   
        <tr>
            <td colspan=2>
                <img src="<%=wkControl.GetThemeRelativeUrl("Common/Images/icon-note.png")%>" alt="" style="vertical-align:middle">
               
                     <asp:Label ID="userMessageLabel"  CssClass="note" runat=server><%=CalendarGridHelp%></asp:Label>	
                
            </td>
        </tr>                   
    </table>
</div>   
<div id="Div1">
    <table style="width:100%;border-width:0;margin:auto;border-spacing:1px;border-collapse:separate">
        <tr style="vertical-align:top">
            <td style="text-align:right;padding:3px">
                 <asp:Button runat="server" ID="btnSave"     CssClass="inputbutton" Text="Save"  Visible=false/>&nbsp;
                 <asp:Button runat="server" ID="btnDelete"   CssClass="inputbutton" Text="Delete"/>
                 <asp:Button runat="server" ID="btnClose"    CssClass="inputbutton" Text="Close"/>
            </td>
          
        </tr>
    </table>
</div>
 
 <script>

      try {
          document.getElementById("tblMain").style.display = "none";
      }
      catch (ex) {
      }

      function isIE11() {
          return !!navigator.userAgent.match(/Trident.*rv[ :]*11\./);
      }

    </script>