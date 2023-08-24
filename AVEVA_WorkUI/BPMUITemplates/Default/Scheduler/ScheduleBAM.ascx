<%@ Control Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.Scheduler.SchedulerUserControl" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<link rel="stylesheet" type="text/css" href="<%=cssPath%>Common/StyleSheet/Global.css" />
<link rel="stylesheet" type="text/css" href="<%=cssPath%>TelerikAjax/StyleSheet/AWTCalendar/Calendar.AWTCalendar.css" />
<link rel="stylesheet" type="text/css" href="<%=cssPath%>TelerikAjax/StyleSheet/AWTCalendar/Calendar.css" />
<link rel="stylesheet" type="text/css" href="<%=cssPath%>TelerikAjax/StyleSheet/AWTInput/Input.AWTInput.css" />
<script src="../Common/JavaScripts/jquery.min.js"></script>
<script src="../Common/JavaScripts/AutoLogoff.js"></script>
  <script>
    window.onresize = Resize;
    window.onload = Resize;
    
    function Resize()
    {
        var divdetails = document.getElementById("divdetails");
        var mainrow = document.getElementById("mainrow");       
    }

       
    function EveydayUnchecked()
    {
              
      var dayMonths = document.getElementById("<%=buttonLastDay.ClientID%>");
        dayMonths.checked = false;
     
    }
    function LastdayMonthUnchecked()
    {
       
      var dayMonth = document.getElementById("<%=buttonDay.ClientID%>");
        dayMonth.checked = false;
    }

    function ChangeInput(renderDay)
    {   
        var dateArray = renderDay.Date;
        var month = GetMonth(parseInt(dateArray[1])-1);  

        var dateString =  dateArray[2] +" " + month +" " + dateArray[0];
        activeInput.value = dateString;
        WriteTaskDetails();
        if (popup.IsVisible())
        {
            popup.Hide();                 
        }
    }
    
    function CloseDataPointFrame()
    {
        parent.CloseDataPointFrameAndRefresh();            
    }        
    
    function ConfirmDeletingBAMSchedule() {
        var confirm_value = document.createElement("INPUT");
        confirm_value.type = "hidden";
        confirm_value.name = "confirm_value";
       
        se.ui.messageDialog.showConfirmation("<%=GR.GetString("Basic Configuration")%>", "<%=GR.GetString("Confirm_DelteingBAMSchedule")%>",
       
                                         function (userResponse) {
                                             
                                             if (userResponse) {
                                                confirm_value.value = "Yes";
                                                document.forms[0].appendChild(confirm_value);
                                                document.getElementById('<%=DeleteScheduleHidden.ClientID%>').click();
                                               }
                                             else {
                                             confirm_value.value = "No";
                                             document.forms[0].appendChild(confirm_value);
                                             }
                                         });
      }
</script>
   <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
 <table border="0" cellspacing="1" cellpadding="1" style="width: 100%; height: 100%;">
            <tr>
                <td > 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td valign="middle">
                                <img src="<%=cssPath%>common/images/icon-scheduler.png" align="absmiddle" hspace="2" hspace="2" />                                
                           <span class="subtitle"> <%=GR.GetString("SchSchedulerCaption")%></span> 
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="center" height="40" valign="middle">
                    <table cellspacing="1" cellpadding="2" border="0" width="99%">
                        <tr>
                            <td class="lefttdbg">
                                <table cellspacing="1" cellpadding="1" border="0" width="100%" class="">
                                    <tr>
                                        <td style="width: 36px; height: 20px" align="right">
                                            <img src="<%=cssPath%>HWS/images/down-arrow.gif" />
                                        </td>
                                        <td width="95%" class="description">
                                            <div id="TaskDetails" runat="server">
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td  style="height: 20px" align="center">
                    <table border="0" cellspacing="2" cellpadding="2" width="99%" class="lefttdbg">
                        <tr>
                            <td width="30%" style="height: 26px" class="subtitle">
                               
                              <span class="subtitle"> <%=GR.GetString("SchStartDate")%></span> 
                            </td>
                           
                            <td width="20%" style="height: 26px" class="subtitle">
                               <span class="subtitle"><%=GR.GetString("SchEndDate")%></span>
                            </td>
                           
                        </tr>
                        <tr>
                             <td width="30%" style="height: 26px">            
                                 <telerik:RadDatePicker RenderMode="Classic" Width="125px" ID="TxtStartDate" runat="server" Skin="AWTCalendar" EnableEmbeddedSkins="false">         
                                  <DateInput  Skin="AWTCalendar" runat="server">
                                  </DateInput>
                                  <Calendar  runat="server" Skin="AWTCalendar" ID="Calendar2">
                                  </Calendar>
                                 </telerik:RadDatePicker> 
                                </td>
                             <td width="30%" style="height: 26px">
                                 <telerik:RadDatePicker RenderMode="Classic" Width="125px" ID="TxtEndDate" runat="server" Skin="AWTCalendar" EnableEmbeddedSkins="false">         
                                  <DateInput Skin="AWTCalendar" runat="server">
                                  </DateInput>
                                  <Calendar  runat="server" Skin="AWTCalendar" ID="Calendar1">
                                  </Calendar>
                                  </telerik:RadDatePicker> 
                             </td>
                        </tr>
                        <tr>
                            <td class="subtitle">
                               
                               <span class="subtitle"> <%=GR.GetString("SchScheduleTask")%></span>
                            </td>
                            
                            <td class="subtitle">
                               
                              <span class="subtitle"><%=GR.GetString("SchStartTime")%></span>
                            </td>
                           
                        </tr>
                        <tr>
                            <td>
                                <asp:DropDownList CssClass="inputselect" ID="DropDownSchedTask" runat="server" Style="" />

                                <script type="text/javascript">
                                    function GetDDID() {
                                        var temp = document.getElementById("<%=DropDownSchedTask%>");
                                  }
                                </script>

                            </td>
                             <td>
                        <telerik:RadMaskedTextBox ID="RadMaskedTimeBox" runat="server" Mask="<0..12> : <0..59>  <AM|PM>" PromptChar=" " Skin="AWTInput" EnableEmbeddedSkins="false" RenderMode="Classic"
                            Font-Names="Segoe UI" Font-Size="12px" Width="80px" RoundNumericRanges="false" Label=""  ResetCaretOnFocus="true" LabelCssClass="LabelStyle" CssClass="Default_Default" Text="0100AM" TextWithLiterals="01 : 00  AM">
                        </telerik:RadMaskedTextBox>
                        </td>
                        </tr>
                    </table>
                </td>
            </tr>
            
            <tr>
                <td  align="center">
                    <table border="0" cellspacing="0" cellpadding="1" width="100%">
                        <tr>
                            <td hight="40px"></td>
                        </tr>
                        <tr>
                            <td style="width:50%" class="subtitle">
                               
                                    
                                        <div id="divLabel" runat="server" >
                                            <%=GR.GetString("SchScheduleTaskDaily")%>
                                        </div>
                                   
                                    <table width="100%" cellpadding="0" cellspacing="1" border="0">
                                        <tr>
                                            <td colspan="4" width="100%">
                                                <div id="divDayWeek" style="visibility: visible" runat="server">
                                                    <table id="TableElse" cellpadding="5" cellspacing="0" border="0" width="100%">
                                                        <tr>
                                                            <td width="10%" class="description" align="right" style="height: 50px">
                                                             <span class="description"> <%=GR.GetString("SchEvery")%></span>  
                                                            </td>
                                                            <td width="10%" style="height: 50px">
                                                             <telerik:RadMaskedTextBox ID="RadMaskedEveryDayBox" runat="server" Mask="####" PromptChar=" " Skin="AWTInput" EnableEmbeddedSkins="false" RenderMode="Classic"
                                                           Font-Names="Segoe UI" Font-Size="12px" Width="30px" RoundNumericRanges="false" Label=""  ResetCaretOnFocus="true" LabelCssClass="LabelStyle">
                                                           </telerik:RadMaskedTextBox>
                                                            </td>
                                                            <td class="description" align="left" style="height: 50px">
                                                                <div id="divSchedluType" runat="server">
                                                                    <span class="description"> <%=GR.GetString("Schdays")%></span>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div id="divMonth" style="visibility: hidden;" runat="server" >
                                                    <table id="Table1" cellpadding="2" cellspacing="0" border="0" width="100%" hight="250px" >
                                                        <tr>
                                                            <td width="10%" align="left"><asp:RadioButton ID="buttonDay" runat="server" RepeatDirection="Horizontal" CssClass="inputradio" onclick="EveydayUnchecked()" Checked="true"></asp:RadioButton></td>
                                                            <td width="10%" class="bgoutput" align="left" style="height: 10px" >
                                                                <span class="description"> <%=GR.GetString("SchEvery")%></span>
                                                            </td>
                                                            <td width="5%" align="left">
                                                                <telerik:RadMaskedTextBox ID="RadMaskedEveryMonthBox" runat="server" Mask="<1..31>" PromptChar=" " Skin="AWTInput" EnableEmbeddedSkins="false"
                                                                 Font-Names="Segoe UI" Font-Size="12px" Width="30px" RoundNumericRanges="false" Label=""  ResetCaretOnFocus="true" LabelCssClass="LabelStyle">
                                                               </telerik:RadMaskedTextBox>
                                                            </td>
                                                            <td width="50%" class="bgoutput" align="left">
                                                             <span class="description"> <%=GR.GetString("Schmonths")%></span>
                                                            </td>
                                                        </tr>
                                                        
                                                    </table>
                                                    <table id="Table2" cellpadding="2" cellspacing="0" border="0" width="100%">
                                                        <tr >
                                                            <td width="10%" align="left"> <asp:RadioButton ID="buttonLastDay" runat="server" RepeatDirection="Horizontal" CssClass="inputradio" onclick="LastdayMonthUnchecked()"></asp:RadioButton></td>
                                                            <td width="90%" align="left">
                                                                 <span class="description" ><%=GR.GetString("WSchduler_Last_day_Of_months")%></span>                                                            
                                                            </td>
                                                        
                                                        </tr>
                                                      </table>
                                                   <table id="Table3" cellpadding="2" cellspacing="1" border="0" width="100%" >
                                                         <td width="50%" align="right" >
                                                                <input type="button" value="<%=GR.GetString("Select Month")%>" onclick="Javascript:return OpenMonthsWindow();"
                                                                        id="buttonMonths" class="inputbutton" />                                                       
                                                            </td>

                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                               
                            </td>
                            
                             <td style="width:50%" class="subtitle">
                              
                                   
                                        <asp:CheckBox ID="CheckBoxRepeat" runat="server" CssClass="inputcheckbox" ></asp:CheckBox>
                                         <%=GR.GetString("SchRepeatTask")%>
                                    
                                    <table border="0" cellspacing="0" cellpadding="5" width="100%">
                                        <tr>
                                            <td width="10%" class="bgoutput" align="right" height="50px">
                                               <span class="description" > <%=GR.GetString("SchEvery")%></span>
                                            </td>
                                            <td width="10%">
                                                 <telerik:RadMaskedTextBox ID="RadMaskedEveryMinHrBox" runat="server"  Mask="####" PromptChar="" Font-Names="Segoe UI"  EnableEmbeddedSkins="false"
                                                   Font-Size="12px" Width="30px" RoundNumericRanges="false" Label="" ResetCaretOnFocus="true" LabelCssClass="LabelStyle">
                                                 </telerik:RadMaskedTextBox>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="DropDownHourMin" runat="server"  CssClass="inputselect" />
                                            </td>
                                        </tr>
                                    </table>
                                
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
           
           
            <tr>
                <td>
                    <input type="hidden" id="hidweekdays" name="hidweekdays" value="1" runat="server" />
                    <input type="hidden" id="hidmonths" name="hidmonths" value="1,2,3,4,5,6,7,8,9,10,11,12"
                        runat="server" />
                    <div id="calendarContainer" style="display: none;" runat="server">
                        &nbsp;</div>
                    <div id="PropertyDiv" style="border: 1px solid #256194; display: none" runat="server" />
                </td>
            </tr>
            <tr>
                <td width="100%" class="TableContainer" height="24">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td  id="Td2" align="right" style="padding-bottom:10px;padding-right:10px;">                              
                                <asp:Button ID="btnCancel" runat="server"  CssClass="inputbutton" OnClick="btnCancel_Click" OnClientClick="CloseDataPointFrame()" />
                                <asp:Button ID="DeleteSchedule" runat="server" CssClass="inputbutton" OnClientClick="ConfirmDeletingBAMSchedule(); return false;"  Visible="false"/>
                                <asp:Button ID="DeleteScheduleHidden" runat="server" OnClick="DeleteBamSchedule" style="display:none;"/>
                                  <asp:Button ID="btnSave" runat="server" CssClass="inputbutton" OnClick="btnSave_Click" />
                            </td>
                        </tr> 
                    </table>
                </td>
            </tr>
        </table>
        
        <script type="text/javascript">
        /*<![CDATA[*/       
            var popup, calendarContainer, activeInput, isVisible; 
            var ObjRepeatChecked = document.getElementById("<%=CheckBoxRepeat.ClientID%>");    
            var taskDetailsDiv  = document.getElementById("<%=TaskDetails.ClientID%>");                             
            Onload();
            
            function Onload()
            {
               if(!ObjRepeatChecked.checked)
               {

                    document.getElementById("<%=DropDownHourMin.ClientID%>").disabled=true;    
                    var EveryHrInput = '<%= RadMaskedEveryMinHrBox.ClientID %>';
                    if( document.getElementById(EveryHrInput)!=null)
                    document.getElementById(EveryHrInput).disabled=true;
                    
                }
                var divMonth = document.getElementById("<%=divMonth.ClientID%>");
                divMonth.style.display="none";                
               WriteTaskDetails();                          
            }
            
            function WriteTaskDetailsServer(strVal)
            {         
                var value = strVal;                
                taskDetailsDiv.innerText = "";       

               taskDetailsDiv.innerText = "Task will Run at: " + value;
            }
            
            function WriteTaskDetails(strVal)
            {     
              var taskMode = null;                        
              if(strVal == null)
              {           
               var dailyVal = document.getElementById('<%=RadMaskedEveryDayBox.ClientID %>').value;     
               if(document.getElementById("<%=DropDownSchedTask.ClientID%>").options[document.getElementById("<%=DropDownSchedTask.ClientID%>").selectedIndex].value=="Daily")
               {
                    if(dailyVal==1)
                        taskMode = "<%=GR.GetString("SchEveryDay")%>";
                    else
                        taskMode = "<%=GR.GetString("SchEvery")%>" + " " +trim(dailyVal)+" days";    
               }
               else if(document.getElementById("<%=DropDownSchedTask.ClientID%>").options[document.getElementById("<%=DropDownSchedTask.ClientID%>").selectedIndex].value=="Weekly")
               {         

                   weekdays = document.getElementById("<%=hidweekdays.ClientID%>").value;       
                    var weekstring  = getWeekDaysString(weekdays);
                    if(dailyVal==1)
                        taskMode = "<%=GR.GetString("SchEvery")%>" + " " + weekstring + " " + "<%=GR.GetString("Schofeveryweek")%>";  
                    else
                        taskMode = "<%=GR.GetString("SchEvery")%>" + " " + weekstring + " " + "<%=GR.GetString("Schofevery")%>" + " " + trim(dailyVal)+  " " + "<%=GR.GetString("Schweek")%>" + " ";    
               }                
               else if(document.getElementById("<%=DropDownSchedTask.ClientID%>").options[document.getElementById("<%=DropDownSchedTask.ClientID%>").selectedIndex].value=="Monthly")
               {
                    monthlyVal = document.getElementById('<%=RadMaskedEveryMonthBox.ClientID %>').value 
                    months = document.getElementById("<%=hidmonths.ClientID%>").value;
                    var monthstring  = getMonthsString(months);
                    if(monthstring != null)
                    {
                        var monthstringArr = monthstring.split(",");
                        if(monthstringArr.length==12)
                            taskMode = "<%=GR.GetString("Schonday")%>" + " "  + monthlyVal + " " + "<%=GR.GetString("Schofeverymonth")%>";
                        else
                            taskMode = "<%=GR.GetString("Schonday")%>" + " " + monthlyVal + " " + "<%=GR.GetString("SchSOf")%>" + " " + monthstring;
                    }
                } 
              
               var startTime = document.getElementById('<%=RadMaskedTimeBox.ClientID %>').value;              
               startTime = startTime.replace(" ","");
               startTime = startTime.replace(" ","");
               startTime = startTime.replace(" ","");
               var startdate = document.getElementById("<%=TxtStartDate.ClientID%>").value;
               var repeatText = "<%=GR.GetString("SchAt")%>" + " ";
               var checkCtrl = document.getElementById("<%=CheckBoxRepeat.ClientID%>");
               
               if(checkCtrl.checked)
               {
                  var everyminhrVal = document.getElementById('<%=RadMaskedEveryMinHrBox.ClientID %>').value;  
                  var hrmins = document.getElementById("<%=DropDownHourMin.ClientID%>").options[document.getElementById("<%=DropDownHourMin.ClientID%>").selectedIndex].value;
                  repeatText = "<%=GR.GetString("SchEvery")%>" + " " + trim(everyminhrVal) + " "+ hrmins+  " " + "<%=GR.GetString("SchSFrom")%>" + " ";;
               }
               else
               {
                   repeatText = "<%=GR.GetString("SchAt")%>" + " ";
               }
               if(taskMode != null)
               {                  
                 taskDetailsDiv.innerText = "<%=GR.GetString("SchTaskwillRun")%>" + " "+ repeatText+startTime+" "+taskMode+", " +  "<%=GR.GetString("Schstarting")%>" + " " + startdate;
              }
            }
            else
            {   
                var value = strVal.toString();
                  taskDetailsDiv.innerText = "<%=GR.GetString("SchTaskwillRunat")%>" + " " + value;
            }
            }
            
            function getWeekDaysString(days)
            {
                 var ListOfdays = "Mon,Tue,Wed,Thu,Fri,Sat,Sun";
                 var returnval = "";
                 var eachday = days.split(",");
                 var eacListOfDays = ListOfdays.split(",");
                 
                 for(var i=0;i<eachday.length;i++)
                 {
                    if(trim(returnval) == "")
                    {
                        returnval = eacListOfDays[parseInt(eachday[i])-1];
                    }
                    else
                    {
                        returnval = returnval + "," + eacListOfDays[parseInt(eachday[i])-1];
                    }
                 }
                 return returnval;
            }
            
            function getMonthsString(months)
            {
                 var ListOfMonths = "Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec";
                 var returnval = "";
                 var eachMon = months.split(",");
                 var eacListOfMonths = ListOfMonths.split(",");
                 
                 for(var i=0;i<eachMon.length;i++)
                 {
                   if(trim(returnval) == "")
                    {
                        returnval = eacListOfMonths[parseInt(eachMon[i])-1];
                    }
                    else
                    {
                        returnval = returnval + "," + eacListOfMonths[parseInt(eachMon[i])-1];
                    }
                  }
                 return returnval;
            }

           function onChangeRadMaskedEveryDayBox (input, args)
           {
                 WriteTaskDetails();
           }
            
            function onChangeRadMaskedTextBox (input, args)
            {
                 WriteTaskDetails();
            }
            
            function onChangeRadMaskedEveryMinHrBox (input, args)
            {
                 WriteTaskDetails();
            }
            
            function  DoEnable(ctrl1)
            { 
                
                var ctrl = document.getElementById("<%=CheckBoxRepeat.ClientID%>")
                var EveryHrInput = '<%= RadMaskedEveryMinHrBox.ClientID %>';               
                if(!ctrl.checked)
                {
                    document.getElementById("<%=DropDownHourMin.ClientID%>").disabled=true;    
                    document.getElementById(EveryHrInput).disabled=true;
                    document.getElementById(EveryHrInput).value="";
                    WriteTaskDetails();
                }
                else
                {
                    document.getElementById("<%=DropDownHourMin.ClientID%>").disabled=false;    
                    document.getElementById(EveryHrInput).disabled=false;      
                } 
            }
            
            function ChangeDropDownHourMin(ctrl)
            {
                 WriteTaskDetails();
            }
 
            function ChangeTaskType(ctrl1)
            {   
                var ctrl = document.getElementById("<%=DropDownSchedTask.ClientID%>");               
                var labelDiv = document.getElementById("<%=divLabel.ClientID%>");     
                var divSchedluType = document.getElementById("<%=divSchedluType.ClientID%>");           
                var divDayWeek = document.getElementById("<%=divDayWeek.ClientID%>");  
                var divMonth = document.getElementById("<%=divMonth.ClientID%>"); 

              if(ctrl.options[ctrl.selectedIndex].value=="Weekly")
              {
                    labelDiv.innerHTML="Schedule Task Weekly";
                    divSchedluType.innerHTML = "week[s] on &nbsp;&nbsp;<input type=\"button\" class=\"inputbutton\" value=\"Select WeekDay\" onclick=\"Javascript:return OpenWeekDaysWindow();\" id=\"buttonWeek\" />";
                    divMonth.style.display="none";
                    divDayWeek.style.visibility="visible";
                    divDayWeek.style.display="block";               
               }
               else if(ctrl.options[ctrl.selectedIndex].value=="Monthly")
               {
                    labelDiv.innerHTML="Schedule Task Monthly";
                    divSchedluType.innerHTML = "of the month[s]";
                    divDayWeek.style.display="none";
                    divMonth.style.visibility="visible";
                    divMonth.style.display="block";                     
               }
              else if(ctrl.options[ctrl.selectedIndex].value=="Daily")
               {
                    labelDiv.innerHTML="Schedule Task Daily";
                    divSchedluType.innerHTML = "day[s]";
                    divMonth.style.display="none";
                    divDayWeek.style.visibility="visible";
                    divDayWeek.style.display="block";               
               }
                WriteTaskDetails();
            }
              
            function OpenMonthsWindow()
            {
                OpenMonthsWindow('Add');    
            }
            
            function GetBrowserversion()
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
            
            function OpenMonthsWindow(mode)
            {
               
                var DIR_IMAGES = "<%=cssPath%>" + 'common/images/';
                var innerHTMl="";
                TopBgImgSrc = DIR_IMAGES+"top-bg.gif"
                var closeImg = DIR_IMAGES+"close.gif"
               
                var nodtext="";
                var nodType="";
                var nodeDataType="";
                var IsRepeating="";
                var bcode = GetBrowserversion();
                if(mode=="Edit")
                {
                }        
                innerHTMl ="<table border=\"0\" width=\"100%\" class=\"lefttdbg\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" ID=\"Table7\">";
                innerHTMl =innerHTMl+"<tr>";
                innerHTMl =innerHTMl+"<td align=\"center\">";
                innerHTMl =innerHTMl+"<table border=\"0\" width=\"100%\" align=\"center\" cellpadding=\"4\" cellspacing=\"0\" ID=\"Table8\">";
                innerHTMl =innerHTMl+"<tr>";
                innerHTMl = innerHTMl + "<td  width=\"49%\" align='left'>&nbsp;&nbsp;&nbsp;&nbsp;<%=GR.GetString("SchSelectMonth")%></td>";

                innerHTMl = innerHTMl + "<td width=\"43%\"   id=\"Td1\" align=\"left\">";
                innerHTMl = innerHTMl + "<%=GR.GetString("Scheduler_Sel_All_Months")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=\"Checkbox\" value =\"All\" checked id=\"chkAll\" name=\"All\" onClick=\"javascript:CheckAllMonths();\">";
                innerHTMl = innerHTMl + "&nbsp;&nbsp;&nbsp;&nbsp;</td>";
                innerHTMl =innerHTMl+"<td  align='right'><a href=\"#\" onclick=\"javascript:CloseDiv()\"><img src="+closeImg+" width=\"19\" height=\"19\" border=0 onClick=\"CloseDiv();\"/></a>";
                innerHTMl =innerHTMl+"</td>";
                innerHTMl =innerHTMl+"</tr>";
                 innerHTMl =innerHTMl+"<tr><td></td></tr>";
                    if(bcode==1)
                    {
                        innerHTMl =innerHTMl+" <tr>";
                        innerHTMl =innerHTMl+"<td  class=\"description\"  colspan=\"2\"><%=GR.GetString("SchMonthsSelect")%></td>";
                        innerHTMl =innerHTMl+"</tr>";
                    }
                 
                    var month = "<%=GR.GetString("SchJan")%>" + "," + "<%=GR.GetString("SchFeb")%>" + "," + "<%=GR.GetString("SchMar")%>" + "," + "<%=GR.GetString("SchApr")%>" + "," + "<%=GR.GetString("SchMay")%>" + "," + "<%=GR.GetString("SchJun")%>" + "," + "<%=GR.GetString("SchJul")%>" + "," + "<%=GR.GetString("SchAug")%>" + "," + "<%=GR.GetString("SchSep")%>" + "," + "<%=GR.GetString("SchOct")%>" + "," + "<%=GR.GetString("SchNov")%>" + "," + "<%=GR.GetString("SchDec")%>";
                    var splitMonths = month.split(",");
                
                    for(var i=0; i<splitMonths.length;i++) 
                    {
                        innerHTMl =innerHTMl+ "<tr>";
                        innerHTMl =innerHTMl+ "<td colspan=\"2\">";
                        innerHTMl =innerHTMl+"<table border=\"0\" width=\"90%\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" ID=\"Table9\">";
                        innerHTMl =innerHTMl+"<tr>";
                        innerHTMl =innerHTMl+"<td class=\"description\" align='Left' width=40%>";
                        innerHTMl =innerHTMl+""+splitMonths[i]+"";   
                       
                        isSelectedday = GetSelectedMonths(i+1);
                        innerHTMl =innerHTMl+"</td>";
                        innerHTMl =innerHTMl+"<td class=\"description\" width=20%>";
                        
                        if(isSelectedday)
                            innerHTMl =innerHTMl+"<input type=\"Checkbox\" class=\"inputcheckbox\"  value =\""+parseInt((parseInt(i) + 1))+"\" checked id=\"Month"+parseInt((parseInt(i) + 1))+"\" onClick=\"javascript:UnselectAll();\"/>";
                       else
                            innerHTMl =innerHTMl+"<input type=\"Checkbox\" class=\"inputcheckbox\" value =\""+parseInt((parseInt(i) + 1))+"\"  id=\"Month"+parseInt((parseInt(i) + 1))+"\" onClick=\"javascript:UnselectAll();\"/>";
                        
                        innerHTMl =innerHTMl+"</td>"; 
                       
                        i = i + 1;     
                        isSelectedday = GetSelectedMonths(i+1);
                       
                        innerHTMl =innerHTMl+"<td class=\"description\" align='Left' width=40%>";
                        innerHTMl =innerHTMl+""+splitMonths[i]+"";        
                        innerHTMl =innerHTMl+"</td>";
                        innerHTMl =innerHTMl+"<td class=\"description\" width=40%>";
                       
                        if(isSelectedday)
                            innerHTMl =innerHTMl+"<input type=\"Checkbox\" value =\""+parseInt((parseInt(i) + 1))+"\" checked id=\"Month"+parseInt((parseInt(i) + 1))+"\" onClick=\"javascript:UnselectAll();\"/>";
                        else
                            innerHTMl =innerHTMl+"<input type=\"Checkbox\" value =\""+parseInt((parseInt(i) + 1))+"\"  id=\"Month"+parseInt((parseInt(i) + 1))+"\" onClick=\"javascript:UnselectAll();\"/>";
                        
                        innerHTMl =innerHTMl+"</td>"; 
                        innerHTMl =innerHTMl+"</tr>"; 
                        innerHTMl =innerHTMl+"</table>";
                        innerHTMl =innerHTMl+"</td>"; 
                        innerHTMl =innerHTMl+"</tr>";
                    }
                innerHTMl = innerHTMl + "<tr>";
                innerHTMl = innerHTMl + "<td></td>";
                innerHTMl = innerHTMl + "</tr>";
                innerHTMl = innerHTMl + "<tr>";
                innerHTMl = innerHTMl + "<td></td>";
                innerHTMl = innerHTMl + "</tr>";
                innerHTMl = innerHTMl + "<tr>";
                innerHTMl = innerHTMl + "<td></td>";
                innerHTMl = innerHTMl + "</tr>";
                innerHTMl = innerHTMl + "<tr>";
                if (bcode == 1) {
                    innerHTMl = innerHTMl + " <tr>";
                    innerHTMl = innerHTMl + "<td colspan=\"2\"><img src=\"Images/Spacer.gif\" border=\"0\" height=\"8\"></td>";
                    innerHTMl = innerHTMl + "</tr>";
                } innerHTMl = innerHTMl + "<tr>";
                innerHTMl = innerHTMl + "<td colspan=3 width=100% class=\"header256194ColorCode\" >";
                innerHTMl = innerHTMl + "<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">";
                innerHTMl = innerHTMl + "<tr>";
                innerHTMl = innerHTMl + "<td width=\"80%\"   id=\"Td2\" align=\"right\">";
                innerHTMl = innerHTMl + "<input type=\"button\" id=\"btnCancel\" class=\"inputsecondarybutton\" name=\"btnCancel\" value=\"<%=GR.GetString("SchCancelButton")%>\" onClick=\"CloseDiv();\">&nbsp;";
                innerHTMl = innerHTMl + "<input type=\"button\" id=\"btnOk\" class=\"inputbutton\" name=\"btnOk\" value=\"&nbsp;&nbsp;<%=GR.GetString("SchOKButton")%>&nbsp;&nbsp;\" onClick=\"javascript:UpdateSelectedMonths();\">&nbsp;";
                innerHTMl = innerHTMl + "</td>";

                innerHTMl = innerHTMl + "</tr>";
                innerHTMl = innerHTMl + "</table>";
                innerHTMl = innerHTMl + "</td>";

                innerHTMl = innerHTMl + "</tr>";
                innerHTMl = innerHTMl + "</table>";
                innerHTMl = innerHTMl + "</td>";

                innerHTMl = innerHTMl + "</tr>";
                innerHTMl = innerHTMl + "</table>";
                var proprObj = document.getElementById("<%=PropertyDiv.ClientID%>");
                proprObj.innerHTML = innerHTMl;
                proprObj.style.position = "absolute";
                proprObj.style.visibility = "visible";
                proprObj.style.display = "block";
                proprObj.style.left = 400 + 'px';
                proprObj.style.top = 100 + 'px';
                proprObj.style.width = 570 + 'px';
                var selMonths = document.getElementById("<%=hidmonths.ClientID%>").value;
                var monthcounts = selMonths.split(",");
                if (parseInt(monthcounts.length) == 12) {
                    document.getElementById("chkAll").checked = true;
                }
                else {
                    document.getElementById("chkAll").checked = false;

                }
                HideCalendarDiv();
          }

       
           function CheckAllMonths() 
           {  
                var ctrAll = document.getElementById("chkAll"); 
                if(ctrAll.checked == true)
                {   
                    for(var i=1;i<13;i++)
                    {
                        var ctrl = document.getElementById("Month"+i);
                        ctrl.checked = true;
                    }
                }
                else
                {
                    for(var i=1;i<13;i++)
                    {
                        var ctrl = document.getElementById("Month"+i);
                        ctrl.checked = false;
                    }  
               }   
               
            }             
            
            function CheckAllDays()
            {  
                var ctrAll = document.getElementById("chkAll");   
                if(ctrAll.checked == true)
                {   
                    for(var i=1;i<8;i++)
                    {
                        var ctrl = document.getElementById("Day"+i);
                        ctrl.checked = true;
                    }
                }
                else
                {
                    for(var i=1;i<8;i++)
                    {
                        var ctrl = document.getElementById("Day"+i);
                        ctrl.checked = false;
                   }   
               }               
            }               
 
            function OpenWeekDaysWindow(mode)
            {
                var DIR_IMAGES = "<%=cssPath%>" + 'common/images/';
                var innerHTMl="";
                TopBgImgSrc = DIR_IMAGES+"top-bg.gif"
                var closeImg = DIR_IMAGES+"close.gif"               

                var nodtext="";
                var nodType="";
                var nodeDataType="";
                var IsRepeating="";
                var bcode = GetBrowserversion();
                if(mode=="Edit")
                {
                }        
                    innerHTMl ="<table border=\"0\" width=\"100%\" class=lefttdbg align=\"center\" cellpadding=\"0\" cellspacing=\"0\" ID=\"Table7\">";
                    innerHTMl =innerHTMl+"<tr>";
                    innerHTMl =innerHTMl+"<td align=\"center\">";
                    innerHTMl =innerHTMl+"<table border=\"0\" width=\"100%\" align=\"center\" cellpadding=\"4\" cellspacing=\"0\" ID=\"Table8\">";
                    innerHTMl =innerHTMl+"<tr>";
                    innerHTMl =innerHTMl+"<td  class=\"subtitle\" align='left'><%=GR.GetString("SchSelectWeekDay")%></td>";
                    innerHTMl =innerHTMl+"<td  class=\"description\" align='right'><a href=\"#\" onclick=\"javascript:CloseDiv()\"><img src="+closeImg+" width=\"17\" height=\"17\" border=0 onClick=\"CloseDiv();\"/></a>";
                    innerHTMl =innerHTMl+"</td>";
                    innerHTMl =innerHTMl+"</tr>";
                    
                    if(bcode==1)
                    {
                        innerHTMl =innerHTMl+" <tr>";
                        innerHTMl =innerHTMl+"<td colspan=\"2\"  class=\"description\" ><%=GR.GetString("SchWeeksSelect")%></td>";
                        innerHTMl =innerHTMl+"</tr>";
                    }
                 
                    var week = "<%=GR.GetString("SchMon")%>" + "," + "<%=GR.GetString("SchTue")%>" + "," + "<%=GR.GetString("SchWed")%>" + "," + "<%=GR.GetString("SchThu")%>" + "," + "<%=GR.GetString("SchFri")%>" + "," + "<%=GR.GetString("SchSat")%>" + "," + "<%=GR.GetString("SchSun")%>";
                    var splitWeekdays = week.split(",");
                    wkdays = document.getElementById("<%=hidweekdays.ClientID%>").value;
                 
                    for(var i=0; i<splitWeekdays.length;i++) 
                    {
                        innerHTMl =innerHTMl+ "<tr>";
                        innerHTMl =innerHTMl+ "<td colspan=\"2\">";
                        innerHTMl =innerHTMl+"<table border=\"0\" width=\"90%\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" ID=\"Table9\">";
                        innerHTMl =innerHTMl+"<tr>";
                        innerHTMl =innerHTMl+"<td class=\"description\" align='Left' width=28%>";
                        innerHTMl =innerHTMl+""+splitWeekdays[i]+":";   
                        
                        innerHTMl =innerHTMl+"</td>";
                        innerHTMl =innerHTMl+"<td class=\"description\" width=22%>";
                        
                        var isSelectedday = GetSelectedWeekDays(i+1);
                        
                        if(isSelectedday)
                            innerHTMl =innerHTMl+"<input type=\"Checkbox\" value =\""+parseInt((parseInt(i) + 1))+"\" checked id=\"Day"+parseInt((parseInt(i) + 1))+"\"/>";
                        else
                            innerHTMl =innerHTMl+"<input type=\"Checkbox\" value =\""+parseInt((parseInt(i) + 1))+"\" id=\"Day"+parseInt((parseInt(i) + 1))+"\"/>";
                        
                        innerHTMl =innerHTMl+"</td>"; 
                        innerHTMl =innerHTMl+"<td class=\"description\" align='Left' width=28%>";
                       
                        i = i + 1;   
                        
                        if(i==7)
                            innerHTMl =innerHTMl+"&nbsp;";        
                        else
                           innerHTMl =innerHTMl+""+splitWeekdays[i]+":";                         

                       innerHTMl =innerHTMl+"</td>";                        
                       innerHTMl =innerHTMl+"<td class=\"description\" width=22%>";
                       
                        if(i==7)
                            innerHTMl =innerHTMl+"&nbsp;";        
                        else
                        {
                            isSelectedday = GetSelectedWeekDays(i+1);                        
                            if(isSelectedday)
                                innerHTMl =innerHTMl+"<input type=\"Checkbox\" value =\""+parseInt((parseInt(i) + 1))+"\" checked id=\"Day"+parseInt((parseInt(i) + 1))+"\"/>";
                            else
                                innerHTMl =innerHTMl+"<input type=\"Checkbox\" value =\""+parseInt((parseInt(i) + 1))+"\" id=\"Day"+parseInt((parseInt(i) + 1))+"\"/>";
                      
                        }
                        innerHTMl =innerHTMl+"</td>";                    
                        innerHTMl =innerHTMl+"</tr>"; 
                        innerHTMl =innerHTMl+"</table>";
                        innerHTMl =innerHTMl+"</td>"; 
                        innerHTMl =innerHTMl+"</tr>";
                    }
                    if(bcode==1)
                    {
                        innerHTMl =innerHTMl+" <tr>";
                        innerHTMl =innerHTMl+"<td colspan=\"2\"><img src=\"Images/Spacer.gif\" border=\"0\" height=\"8\"></td>";
                        innerHTMl =innerHTMl+"</tr>";
                    }  innerHTMl =innerHTMl+"<tr>";
                                 innerHTMl =innerHTMl+"<td colspan=3 width=100%  class=\"description\" >";
                                     innerHTMl =innerHTMl+"<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">";

                                       innerHTMl =innerHTMl+"<tr>";                                        
                                            innerHTMl =innerHTMl+"<td width=\"20%\"   class=\"description\"  id=\"Td1\" align=\"left\">";                                      
                                                       innerHTMl =innerHTMl+"<input type=\"Checkbox\" value =\"All\" checked id=\"chkAll\" name=\"All\"  onClick=\"javascript:CheckAllDays();\">All";
                                                       innerHTMl =innerHTMl+"</td>";    
                                        
                                              innerHTMl =innerHTMl+"<td width=\"80%\"   id=\"Td2\" align=\"right\">";                                      
                                              innerHTMl = innerHTMl + "<input type=\"button\" class=\"inputsecondarybutton\" id=\"btnCancel\" name=\"btnCancel\" value=\"<%=GR.GetString("SchCancelButton")%>\" onClick=\"CloseDiv();\" class=\"inputbutton\">&nbsp;";
                                                    innerHTMl =innerHTMl+"<input type=\"button\" class=\"inputbutton\" id=\"btnOk\" name=\"btnOk\" value=\"&nbsp;&nbsp;<%=GR.GetString("SchOKButton")%>&nbsp;&nbsp;\" onClick=\"javascript:UpdateSelectedDays();\" class=\"inputbutton\">&nbsp;";                                                            
                                                     
                                                      innerHTMl =innerHTMl+"</td>";    
                                                innerHTMl =innerHTMl+"</tr>";                                                 
                                            innerHTMl =innerHTMl+"</table>";
                            innerHTMl =innerHTMl+"</td>";    
                     innerHTMl =innerHTMl+"</tr>"; 
                     innerHTMl =innerHTMl+"</table>";
                    innerHTMl =innerHTMl+"</td>";    
                     innerHTMl =innerHTMl+"</tr>";
                    innerHTMl =innerHTMl+"</table>";
                     
                  var proprObj =document.getElementById("<%=PropertyDiv.ClientID%>");  
                  proprObj.innerHTML =  innerHTMl;

                 proprObj.style.position="absolute";
                 proprObj.style.visibility="visible";

                  proprObj.style.display="block";  
                  proprObj.style.left = 400 + 'px';
                  proprObj.style.top = 100 + 'px';       
                  proprObj.style.width=570+'px';
                  HideCalendarDiv();
                  var ctrlAll = document.getElementById("All");
                  ctrlAll.checked = false;
           }

            function UnselectAll() {

                var selectedmonths = "";
                for (var counter = 1; counter < 13; counter++) {
                    var ctrl = document.getElementById("Month" + counter);
                    if (ctrl.checked) {
                        if (selectedmonths == "")
                            selectedmonths = counter;
                        else
                            selectedmonths = selectedmonths + "," + counter;
                    }
                }
                document.getElementById("<%=hidmonths.ClientID%>").value = selectedmonths;
                var selMonths = document.getElementById("<%=hidmonths.ClientID%>").value;
                var monthcounts = selMonths.split(",");
                if (parseInt(monthcounts.length) == 12) {
                    document.getElementById("chkAll").checked = true;
                }
                else {
                    document.getElementById("chkAll").checked = false;
                }
            }
            function GetSelectedWeekDays(day)
            {
                var retflag=false;
                wkdays = document.getElementById("<%=hidweekdays.ClientID%>").value;

                everyday  = wkdays.split(",");
                for(var i=0 ; i<everyday.length;i++)
                {
                    if(everyday[i]== day)
                    {
                        retflag=true;    
                        break;
                    }
                }
                return retflag;
            }
            
            function GetSelectedMonths(day)
            {
                var retflag=false;
                wkdays = document.getElementById("<%=hidmonths.ClientID%>").value;
                everyday  = wkdays.split(",");
                for(var i=0 ; i<everyday.length;i++)
                {
                    if(everyday[i]== day)
                    {
                        retflag=true;    
                        break;
                    }
                }
                return retflag;
            }    
            
            function UpdateSelectedDays()
            {
                var selecteddays="";
                for(var i=1;i<8;i++)
                {
                    var ctrl = document.getElementById("Day"+i);
                    if(ctrl.checked)
                    {
                        if(selecteddays=="")
                            selecteddays = i;
                        else
                            selecteddays = selecteddays + ","+ i;
                    }
                }                

                document.getElementById("<%=hidweekdays.ClientID%>").value = selecteddays;
                WriteTaskDetails();
                var divPropertyDiv=document.getElementById("<%=PropertyDiv.ClientID%>");    
                divPropertyDiv.style.display = "none";
                ShowCalendarDiv();
            }


            function UpdateSelectedMonths()
            {               
                var selectedmonths="";
                for(var i=1;i<13;i++)
                {
                    var ctrl = document.getElementById("Month"+i);
                    if(ctrl.checked)
                    {
                        if(selectedmonths=="")
                            selectedmonths = i;
                        else
                           selectedmonths = selectedmonths + ","+ i;
                   }
                }         
                document.getElementById("<%=hidmonths.ClientID%>").value = selectedmonths;
                WriteTaskDetails();               
                var divPropertyDiv=document.getElementById("<%=PropertyDiv.ClientID%>");    
                divPropertyDiv.style.display = "none";
                ShowCalendarDiv();
            }

            function HideCalendarDiv() {
                document.getElementById('<%=TxtStartDate.ClientID%>_wrapper').style.display = "none";
                document.getElementById('<%=TxtEndDate.ClientID%>_wrapper').style.display = "none";
             }

            function ShowCalendarDiv() {
                document.getElementById('<%=TxtStartDate.ClientID%>_wrapper').style.display = "block";
                 document.getElementById('<%=TxtEndDate.ClientID%>_wrapper').style.display = "block";
            }
            function CloseDiv()
            {
               var divPropertyDiv=document.getElementById("<%=PropertyDiv.ClientID%>");    
                divPropertyDiv.style.display = "none";
                ShowCalendarDiv();
           }
 
            function GetMonth(no)
            {
                var month = "<%=GR.GetString("SchJan")%>" + "," + "<%=GR.GetString("SchFeb")%>" + "," + "<%=GR.GetString("SchMar")%>" + "," + "<%=GR.GetString("SchApr")%>" + "," + "<%=GR.GetString("SchMay")%>" + "," + "<%=GR.GetString("SchJun")%>" + "," + "<%=GR.GetString("SchJul")%>" + "," + "<%=GR.GetString("SchAug")%>" + "," + "<%=GR.GetString("SchSep")%>" + "," + "<%=GR.GetString("SchOct")%>" + "," + "<%=GR.GetString("SchNov")%>" + "," + "<%=GR.GetString("SchDec")%>";
                var splitMonths = month.split(",");               
                return splitMonths[no];
            }

           function PositionX(inputElement) 
            {
               var offsetLeft = 0;
                if(inputElement!=null)
                {
                    if (inputElement.offsetParent)
                    {
                        while (inputElement.offsetParent)
                        {
                              offsetLeft += inputElement.offsetLeft;
                              inputElement = inputElement.offsetParent;
                        }
                    }
                    else if (inputElement.x)
                    {
                          offsetLeft += inputElement.x;
                    }
                }
                return offsetLeft;
            }
            
            function PositionY(inputElement) 
            {
                var offsetTop = 0;
                if(inputElement!=null)
                {
                    if (inputElement.offsetParent)
                    {
                          while (inputElement.offsetParent)
                          {
                              offsetTop += inputElement.offsetTop;
                              inputElement = inputElement.offsetParent;
                          }
                    }
                    else if (inputElement.y)
                    {
                          offsetTop += inputElement.y;
                    }
                }
                return offsetTop;
            }
            
            function ltrim ( s )    
            {
               return s.replace( /^\s*/, "" );
            } 

           function rtrim ( s )
           {
              return s.replace( /\s*$/, "" );
           } 

          function trim ( s )
          {
              return rtrim(ltrim(s));
          }    
          
          function SaveandClosetheWindow()
          {
            parent.CloseDataPointFrameAndRefresh();            
            parent.parent.parent.location.reload();
          }
        /*]]>*/
        </script>