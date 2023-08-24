<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.WorkFlow.Scheduler.SkeltaWorkflowScheduler" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<link rel="stylesheet" type="text/css" href="<%=cssPath%>Common/StyleSheet/Global.css">
<link rel="stylesheet" type="text/css" href="<%=cssPath%>TelerikAjax/StyleSheet/AWTCalendar/Calendar.AWTCalendar.css">
<link rel="stylesheet" type="text/css" href="<%=cssPath%>TelerikAjax/StyleSheet/AWTCalendar/Calendar.css">
<link rel="stylesheet" type="text/css" href="<%=cssPath%>TelerikAjax/StyleSheet/AWTInput/Input.AWTInput.css">
<link rel="stylesheet" type="text/css" href="<%=cssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css">
<link rel="stylesheet" type="text/css" href="<%=cssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css">
<script src="../Common/JavaScripts/jquery.min.js"></script>
<script src="../Common/JavaScripts/AutoLogoff.js"></script>

<script type="text/javascript">
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

     
      function UpdateTaskdetails() {
          WriteTaskDetails();  
      }
</script>
<telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
<table style="width: 98%; border-spacing: 2px; border-width: 0px; border-collapse: separate;">

    <tr>
        <td style="text-align: center; vertical-align: middle; padding: 1px; height: 3%;">
            <table style="width: 99%; border-spacing: 1px; border-collapse: separate; border-width: 0px">
                <tr>
                    <td style="padding: 2px">
                        <table style="border-spacing: 1px; border-width: 0px; width: 94%; margin: auto" class="fieldset">
                            <tr>
                                <td style="width: 20px; text-align: left">
                                    <img alt="" src="<%=cssPath%>HWS/images/Task-Run.png" />
                                </td>
                                <td style="width: 95%; text-align: left">
                                    <div class="description" id="TaskDetails" runat="server">
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
        <td colspan="2" style="text-align: center">
            <table style="border-width: 0; border-spacing: 1px; width: 90%; border-collapse: separate;">
                <tr>
                    <td style="width: 20%; padding-left: 3px" class="righttdbg">
                        <span class="description"><%=GR.GetString("SchStartDate")%></span>
                    </td>
                    <td style="width: 30%; padding: 2px" class="righttdbg">
                      
                        <telerik:RadDatePicker RenderMode="Classic" Width="150px" ID="TxtStartDate" runat="server" Skin="AWTCalendar" EnableEmbeddedSkins="false">         
                                  <DateInput Skin="AWTCalendar" runat="server">
                                  </DateInput>
                                  <ClientEvents OnDateSelected="UpdateTaskdetails" />
                                  <Calendar  runat="server" Skin="AWTCalendar" ID="Calendar1">
                                  </Calendar>
                         </telerik:RadDatePicker>                      
                    </td>
                    <td></td>
                    <td class="righttdbg" style="padding-left: 5px;">
                        <span class="description"><%=GR.GetString("SchScheduleTask")%></span>
                    </td>
                    <td class="righttdbg" style="padding-right: 20px;">
                        <asp:DropDownList ID="DropDownSchedTask" runat="server" CssClass="inputselect" />

                        <script type="text/javascript">
                                  function GetDDID()
                                  {
                                  var temp=document.getElementById("<%=DropDownSchedTask%>");
                                  }
                        </script>

                    </td>

                </tr>
                <tr>
                    <td style="width: 20%;" class="righttdbg">
                        <span class="description"><%=GR.GetString("SchEndDate")%></span>
                    </td>
                    <td style="width: 30%; padding: 2px;" class="righttdbg">
                     <telerik:RadDatePicker RenderMode="Classic" Width="150px" ID="TxtEndDate" runat="server" Skin="AWTCalendar" EnableEmbeddedSkins="false">         
                                  <DateInput Skin="AWTCalendar" runat="server">
                                  </DateInput>
                                  <Calendar  runat="server" Skin="AWTCalendar" ID="Calendar2">
                                  </Calendar>
                      </telerik:RadDatePicker> 
                     </td>
                    <td></td>

                    <td class="righttdbg" style="padding-left:5px;">
                        <span class="description"><%=GR.GetString("SchStartTime")%></span>
                    </td>
                    <td class="righttdbg" style="padding-right:20px;">
                       <telerik:RadMaskedTextBox ID="RadMaskedTimeBox" runat="server" Mask="<0..12> : <0..59>  <AM|PM>" PromptChar=" " Skin="AWTInput" EnableEmbeddedSkins="false"
                            Font-Names="Segoe UI" Font-Size="14px" Width="152px" RoundNumericRanges="false" Label=""  ResetCaretOnFocus="true" LabelCssClass="subtitle" Text="0100AM" TextWithLiterals="01 : 00  AM">
                       <ClientEvents OnValueChanged="UpdateTaskdetails" /> 
                       </telerik:RadMaskedTextBox>
                    </td>
                </tr>
            </table>
        </td>
    </tr>

    <tr>
        <td colspan="2" style="text-align: center; padding: 2px;">
            <table style="border-width: 0; width: 90%; border-spacing: 0px">
                <tr>
                    <td>
                        <fieldset id="Fieldset1" name="fldSet1" class="FieldSet">
                            <legend class="LegendText" style="text-align: left;">
                                <div id="divLabel" runat="server">
                                    <span class="description"><%=GR.GetString("SchScheduleTaskDaily")%></span>
                                </div>
                            </legend>
                            <table style="width: 100%; border-width: 0px; border-spacing: 0">
                                <tr>
                                    <td colspan="4" style="width: 80%">
                                        <div id="divDayWeek" style="visibility: visible" runat="server">
                                            <table id="TableElse" style="width: 100%; border-width: 0px">
                                                <tr>
                                                    <td class="description" style="width: 10%; text-align: right; padding: 2px">
                                                        <span class="description"><%=GR.GetString("SchEvery")%></span>
                                                    </td>
                                                    <td style="width: 10%; padding: 2px">
                                                         <telerik:RadMaskedTextBox ID="RadMaskedEveryDayBox" runat="server" Mask="####" PromptChar=" " Skin="AWTInput" EnableEmbeddedSkins="false"
                                                           Font-Names="Segoe UI" Font-Size="14px" Width="30px" RoundNumericRanges="false" Label=""  ResetCaretOnFocus="true" LabelCssClass="subtitle">
                                                           <ClientEvents OnValueChanged="UpdateTaskdetails" />
                                                             </telerik:RadMaskedTextBox>
                                                    </td>
                                                    <td class="description" style="text-align: left; padding: 2px">
                                                        <div id="divSchedluType" runat="server">
                                                            <span class="description"><%=GR.GetString("Schdays")%></span>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div id="divMonth" style="visibility: hidden; width: 100%;" runat="server">
                                            <table style="width: 100%">
                                                <tr>
                                                    <td> 
                                                        <div style="height:40px;width: 100%;padding-left:24px">
                                                            <div id="divlast" style="width: 10px; float: left; height: 10px; margin: 10px;vertical-align:baseline">
                                                            <asp:RadioButton ID="buttonDay" runat="server" RepeatDirection="Horizontal" CssClass="inputradio"  onclick="EveydayUnchecked()" Checked="true" ></asp:RadioButton>
                                                               
                                                            </div>
                                                            <div id="divlast1" style="width: 20px; float: left; height: 10px; margin: 10px;vertical-align:baseline">
                                                                <span class="description"><%=GR.GetString("SchEvery")%></span>
                                                            </div>
                                                            <div id="divlast3" style="width: 20px; float: left; height: 10px; margin: 10px;vertical-align:text-top">
                                                               
                                                                <telerik:RadMaskedTextBox ID="RadMaskedEveryMonthBox" runat="server" Mask="<1..31>" PromptChar=" " Skin="AWTInput" EnableEmbeddedSkins="false"
                                                                 Font-Names="Segoe UI" Font-Size="14px" Width="30px" RoundNumericRanges="false" Label=""  ResetCaretOnFocus="true" LabelCssClass="subtitle">
                                                               </telerik:RadMaskedTextBox>
                                                            </div>
                                                            <div id="divlast4" style="width: 90px; float: left; height: 10px; margin: 10px;vertical-align:bottom">
                                                                <span class="description"><%=GR.GetString("Schmonths")%></span>
                                                            </div>
                                                        </div>

                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                    
                                                    <div style="height:55px;width: 100%;padding-left:24px">
                                                        <div id="divlast5" style="width: 15px; float: left; height: 10px; margin: 10px;vertical-align:baseline">
                                                      <asp:RadioButton ID="buttonLastDay" runat="server" RepeatDirection="Horizontal" CssClass="inputradio" onclick="LastdayMonthUnchecked()"></asp:RadioButton>
                                                        </div>
                                                        <div id="divS" runat="server" style="height: 10px;vertical-align:text-top;width:143px;margin-left:17px;padding-bottom:10px;padding-top:10px;">
                                                           <span class="description" ><%=GR.GetString("WSchduler_Last_day_Of_months")%></span>                                                            
                                                        </div>
                                                        
                                                    </div>
                                                        <div style="height: 40px;vertical-align:text-top;margin-top:-50px;margin-left:50px;">
                                                            <input type="button" value="<%=GR.GetString("SchSelectMonth")%>" onclick="Javascript:return OpenMonthsWindow();"
                                                                    id="buttonMonths" class="inputbutton"  />
                                                        </div>
                                                        </td>
                                                </tr>
                                            </table>
                                                                                  
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
            </table>
        </td>
    </tr>

    <tr>
        <td colspan="2" style="text-align: center; padding: 1px;">
            <table style="border-width: 0; width: 90%">
                <tr>
                    <td>
                        <fieldset id="Fieldset2" name="fldSet1" class="FieldSet">
                            <legend class="LegendText" style="text-align: left;">
                                <asp:CheckBox ID="CheckBoxRepeat" runat="server"></asp:CheckBox>
                                <%=GR.GetString("SchRepeatTask")%>
                            </legend>
                            <table style="width: 100%; border-width: 0">
                                <tr>
                                    <td class="description" style="width: 10%; text-align: right;">
                                        <span class="description"><%=GR.GetString("SchEvery")%></span>
                                    </td>
                                    <td style="width: 10%; padding: 2px">
                                      <telerik:RadMaskedTextBox ID="RadMaskedEveryMinHrBox" runat="server"  Mask="####" PromptChar="" Font-Names="Segoe UI"  EnableEmbeddedSkins="false"
                                        Font-Size="14px" Width="30px" RoundNumericRanges="false" Label="" ResetCaretOnFocus="true" LabelCssClass="subtitle">
                                      <ClientEvents OnValueChanged="UpdateTaskdetails" />
                                      </telerik:RadMaskedTextBox>
                                     </td>
                                    <td style="text-align: left;">
                                        <asp:DropDownList ID="DropDownHourMin" runat="server" CssClass="inputselect" />
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
            </table>
        </td>
    </tr>

    <tr>
        <td colspan="2" style="text-align: center; padding: 1px;">
            <table style="width: 90%; border-width: 0;">
                <tr>
                    <td>
                        <fieldset id="Fieldset3" name="fldSet1" class="FieldSet">
                            <legend class="LegendText" style="text-align: left;">
                                <%=GR.GetString("ec_schedule_wkflw_dtls")%>                                    
                            </legend>
                            <table style="border-width: 0; width: 100%">
                                <tr>

                                    <td class="description" style="padding-left: 5px; text-align: right; width: 11%">
                                        <span class="description"><%=GR.GetString("ec_schedule_wkflw_ver")%>   </span>
                                    </td>
                                    <td style="text-align: left; padding-left: 10px;">
                                        <asp:Panel ID="VersionPanel" runat="server">
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
            </table>
        </td>
    </tr>



    <!--end -->

    <tr>
        <td>
            <input type="hidden" id="hidweekdays" name="hidweekdays" value="1" runat="server" />
            <input type="hidden" id="hidmonths" name="hidmonths" value="1,2,3,4,5,6,7,8,9,10,11,12"
                runat="server" />
            <div id="calendarContainer" style="display: none;" runat="server">
                &nbsp;
            </div>
            <div id="PropertyDiv" style="border: 1px solid #256194; display: none" runat="server" />
        </td>
    </tr>
    <tr>
        <td style="width: 100%;" class="TableContainer">
            <table style="width: 100%; border-width: 0px">
                <tr>
                    <td id="Td2" style="text-align: right; width: 100%; padding-top: 2px; padding-right: 10px;">

                        <asp:Button ID="btnCancel" runat="server" CssClass="inputsecondarybutton" OnClick="btnCancel_Click" />
                        <asp:Button ID="btnSave" runat="server" CssClass="inputbutton" OnClick="btnSave_Click" />
                    </td>
                </tr>


            </table>
        </td>

    </tr>
    <tr>
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
               
                if (!ObjRepeatChecked.checked)
               {

                    document.getElementById("<%=DropDownHourMin.ClientID%>").disabled=true;    
                    var EveryHrInput = '<%= RadMaskedEveryMinHrBox.ClientID %>'+"_"+'Text';

                    if(document.getElementById(EveryHrInput)!=null)
                    {
                    document.getElementById(EveryHrInput).disabled=true;
                    }
                    
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
                   if (document.getElementById("<%=buttonDay.ClientID%>").checked == true)
                       monthlyVal = document.getElementById('<%=RadMaskedEveryMonthBox.ClientID %>').value                   
                   else
                       monthlyVal =  "<%=GR.GetString("WSchduler_Last_day_Of_months_msg")%>";
                   

                   months = document.getElementById("<%=hidmonths.ClientID%>").value;

                   var monthstring = getMonthsString(months);
                    if(monthstring != null)
                    {
                        var monthstringArr = monthstring.split(",");
                        if (document.getElementById("<%=buttonDay.ClientID%>").checked == false)
                            if (monthstringArr.length == 12)
                                taskMode = "<%=GR.GetString("Schonday")%>" + " " + monthlyVal + " " + "<%=GR.GetString("Schofeverymonth")%>";
                            else
                                taskMode = "<%=GR.GetString("Schonday")%>" + " " + monthlyVal + " " + "<%=GR.GetString("SchSOf")%>" + " " + monthstring;
                        else
                            if(monthstringArr.length==12)
                            taskMode =  " "  + monthlyVal + " " + "<%=GR.GetString("Schofeverymonth")%>";
                            else
                            taskMode = " " + monthlyVal + " " + "<%=GR.GetString("SchSOf")%>" + " " + monthstring;

                    }
                } 
              
               var startTime = document.getElementById('<%=RadMaskedTimeBox.ClientID %>').value;              
               startTime = startTime.replace(" ", "");
               startTime = startTime.replace(" ","");
               startTime = startTime.replace(" ","");
                                   
             
               var datePickers = document.getElementById("<%=TxtStartDate.ClientID%>").value;
               var Sdate = new Date(datePickers);
               var startdate = Sdate.getMonth()+1 + "/" + Sdate.getDate() + "/" + Sdate.getFullYear();
                                 
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
                var day1 = "<%=GR.GetString("Schdays")%>";
                var week1 = "<%=GR.GetString("Schweeks")%>";
                var month1 = "<%=GR.GetString("Schmonths")%>";
              if(ctrl.options[ctrl.selectedIndex].value=="Weekly")
              {
                    labelDiv.innerHTML = "<%=GR.GetString("SchScheduleTaskWeekly")%>";
                    divSchedluType.innerHTML = week1 + " &nbsp;&nbsp;<input type=\"button\" class=\"inputbutton\" value=\"<%=GR.GetString("SchSelectWeekDay")%>\" onclick=\"Javascript:return OpenWeekDaysWindow();\" id=\"buttonWeek\" />";
                    divMonth.style.display="none";
                    divDayWeek.style.visibility="visible";
                    divDayWeek.style.display="block";               
               }
               else if(ctrl.options[ctrl.selectedIndex].value=="Monthly")
               {
                    labelDiv.innerHTML = "<%=GR.GetString("SchScheduleTaskMonthly")%>";
                    divSchedluType.innerHTML =month1; //"of the month[s]";
                    divDayWeek.style.display="none";
                    divMonth.style.visibility="visible";
                    divMonth.style.display="block";                     
               }
              else if(ctrl.options[ctrl.selectedIndex].value=="Daily")
               {
                    labelDiv.innerHTML = "<%=GR.GetString("SchScheduleTaskDaily")%>";
                    divSchedluType.innerHTML =day1; //"day[s]";
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
                var DIR_IMAGES="<%=cssPath%>"+'common/images/';
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
                innerHTMl = innerHTMl + "<td  width=\"50%\" align='left'>&nbsp;&nbsp;&nbsp;&nbsp;<%=GR.GetString("SchSelectMonth")%></td>";
                  innerHTMl = innerHTMl + "<td width=\"43%\"   id=\"Td1\" align=\"left\">";
                innerHTMl = innerHTMl + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=GR.GetString("Scheduler_Sel_All_Months")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=\"Checkbox\" value =\"All\" checked id=\"chkAll\" name=\"All\" onClick=\"javascript:CheckAllMonths();\">";
                innerHTMl = innerHTMl + "</td>";

                      innerHTMl =innerHTMl+"<td  align='right'><a href=\"#\" onclick=\"javascript:CloseDiv()\"><img src="+closeImg+" width=\"17\" height=\"17\" border=0 onClick=\"CloseDiv();\"/></a>";
                     innerHTMl =innerHTMl+"</td>";
                innerHTMl = innerHTMl + "</tr>";
                 innerHTMl =innerHTMl+"<tr><td></td></tr>";
                   
                    if(bcode==1)
                    {
                        innerHTMl =innerHTMl+" <tr>";
                        innerHTMl =innerHTMl+"<td class=\"description\"  colspan=\"2\"><%=GR.GetString("SchMonthsSelect")%></td>";
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
                        innerHTMl =innerHTMl+"<td class=\"description\" width=30%>";
                        
                        if(isSelectedday)
                            innerHTMl =innerHTMl+"<input type=\"Checkbox\" value =\""+parseInt((parseInt(i) + 1))+"\" checked id=\"Month"+parseInt((parseInt(i) + 1))+"\" onClick=\"javascript:UnselectAll();\"/>";
                       else
                            innerHTMl =innerHTMl+"<input type=\"Checkbox\" value =\""+parseInt((parseInt(i) + 1))+"\"  id=\"Month"+parseInt((parseInt(i) + 1))+ "\" onClick=\"javascript:UnselectAll();\"/>";
                        
                        innerHTMl =innerHTMl+"</td>"; 
                       
                        i = i + 1;     
                        isSelectedday = GetSelectedMonths(i+1);
                       
                        innerHTMl =innerHTMl+"<td class=\"description\" align='Left' width=60%>";
                        innerHTMl =innerHTMl+""+splitMonths[i]+"";        
                        innerHTMl =innerHTMl+"</td>";
                        innerHTMl =innerHTMl+"<td class=\"description\" align='right' width=40%>";
                       
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
                   innerHTMl =innerHTMl+"<tr>";
                                 innerHTMl =innerHTMl+"<td colspan=3 width=100% >";
                                     innerHTMl =innerHTMl+"<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">";
                                        innerHTMl =innerHTMl+"<tr>";
                                            
                                        
                                              innerHTMl =innerHTMl+"<td  width=\"80%\"   id=\"Td2\" align=\"right\">";                                                                                           
                                              innerHTMl = innerHTMl + "<input type=\"button\" id=\"btnCancel\" class=\"inputsecondarybutton\" name=\"btnCancel\" value=\"<%=GR.GetString("SchCancelButton")%>\" onClick=\"CloseDiv();\">&nbsp;";
                                              innerHTMl = innerHTMl + "<input type=\"button\" id=\"btnOk\" class=\"inputbutton\" name=\"btnOk\" value=\"&nbsp;&nbsp;<%=GR.GetString("SchOKButton")%>&nbsp;&nbsp;\" onClick=\"javascript:UpdateSelectedMonths();\">&nbsp;";                                                                
                                                      innerHTMl =innerHTMl+"</td>";   
                                                       
                                                innerHTMl =innerHTMl+"</tr>"; 
                                            innerHTMl =innerHTMl+"</table>";
                            innerHTMl =innerHTMl+"</td>";    

                    innerHTMl =innerHTMl+"</table>";
                    innerHTMl =innerHTMl+"</td>";    

                    innerHTMl =innerHTMl+"</tr>";
                     innerHTMl =innerHTMl+"</table>";
                  var proprObj =document.getElementById("<%=PropertyDiv.ClientID%>");  
                  proprObj.innerHTML =  innerHTMl;
                  proprObj.style.position="absolute";
                  proprObj.style.visibility="visible";
                  proprObj.style.display="block";  
                  proprObj.style.left = 470 + 'px';
                  proprObj.style.top = 155 + 'px';       
                  proprObj.style.width = 400 + 'px';
                   proprObj.style.height = 320+'px';
                 var selMonths = document.getElementById("<%=hidmonths.ClientID%>").value;
                var monthcounts = selMonths.split(",");
                if (parseInt(monthcounts.length) == 12)
                {
                 document.getElementById("chkAll").checked = true;
                }
                else
                {
                 document.getElementById("chkAll").checked = false;
                 
                }
              // HideCalendarDiv();
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
                var DIR_IMAGES="<%=cssPath%>"+'common/images/';
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
                    innerHTMl =innerHTMl+"<td  align='left'><%=GR.GetString("SchSelectWeekDay")%></td>";
                    innerHTMl =innerHTMl+"<td  align='right'><a href=\"#\" onclick=\"javascript:CloseDiv()\"><img src="+closeImg+" width=\"17\" height=\"17\" border=0 onClick=\"CloseDiv();\"/></a>";
//                  innerHTMl =innerHTMl+"<td bgcolor=\"#256194\" class=\"header2\" align='right'>";
                    innerHTMl =innerHTMl+"</td>";
                    innerHTMl =innerHTMl+"</tr>";
                    
                    if(bcode==1)
                    {
                        innerHTMl =innerHTMl+" <tr>";
                        innerHTMl =innerHTMl+"<td  class=\"description\" colspan=\"2\"><%=GR.GetString("SchWeeksSelect")%></td>";
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
                        innerHTMl =innerHTMl+"<td class=\"inputcheckbox\" width=22%>";
                        
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
                   //     innerHTMl =innerHTMl+" <tr>";
                  //      innerHTMl =innerHTMl+"<td colspan=\"2\"><img src=\"Images/Spacer.gif\" border=\"0\" height=\"8\"></td>";
                   //     innerHTMl =innerHTMl+"</tr>";
                    } innerHTMl = innerHTMl + "<tr>";
                    innerHTMl = innerHTMl + "<td colspan=3 width=100%   >";
                    innerHTMl = innerHTMl + "<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">";

                    innerHTMl = innerHTMl + "<tr>";
                    innerHTMl = innerHTMl + "<td width=\"20%\"   id=\"Td1\" align=\"left\">";
                    innerHTMl = innerHTMl + "<input   type=\"Checkbox\" value =\"All\" checked id=\"chkAll\" name=\"All\"  onClick=\"javascript:CheckAllDays();\"><%=GR.GetString("SchSAll")%>"; innerHTMl = innerHTMl + "</td>";

                    innerHTMl = innerHTMl + "<td   width=\"80%\"   id=\"Td2\" align=\"right\">";
                    innerHTMl = innerHTMl + "<input type=\"button\" class=\"inputsecondarybutton\" id=\"btnCancel\" name=\"btnCancel\" value=\"<%=GR.GetString("SchCancelButton")%>\" onClick=\"CloseDiv();\" class=\"input-button\">&nbsp;";
                    innerHTMl = innerHTMl + "<input type=\"button\" class=\"inputbutton\" id=\"btnOk\" name=\"btnOk\" value=\"&nbsp;&nbsp;<%=GR.GetString("SchOKButton")%>&nbsp;&nbsp;\" onClick=\"javascript:UpdateSelectedDays();\" class=\"input-button\">&nbsp;";
                    innerHTMl = innerHTMl + "</td>";
                    innerHTMl = innerHTMl + "</tr>";
                    innerHTMl = innerHTMl + "</table>";
                    innerHTMl = innerHTMl + "</td>";
                    innerHTMl = innerHTMl + "</tr>";
                    innerHTMl = innerHTMl + "</table>";
                    innerHTMl = innerHTMl + "</td>";
                    innerHTMl = innerHTMl + "</tr>";
                    innerHTMl = innerHTMl + "</table>";
                     
                  var proprObj =document.getElementById("<%=PropertyDiv.ClientID%>");  
                  proprObj.innerHTML =  innerHTMl;

                 proprObj.style.position="absolute";
                 proprObj.style.visibility="visible";

                  proprObj.style.display="block";  
                  proprObj.style.left = 470 + 'px';
                  proprObj.style.top = 150 + 'px';       
                  proprObj.style.width=330+'px';
                //  HideCalendarDiv();
                  var ctrlAll = document.getElementById("All");
                  ctrlAll.checked = false;
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
                everyday = wkdays.split(",");
              
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
                divPropertyDiv.style.display="none";
            }
            
            function UpdateSelectedMonths()
            {               
                var selectedmonths = "";
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
                divPropertyDiv.style.display="none";
            }

            function CloseDiv()
            {
                var divPropertyDiv = document.getElementById("<%=PropertyDiv.ClientID%>");    
                divPropertyDiv.style.display = "none";
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
