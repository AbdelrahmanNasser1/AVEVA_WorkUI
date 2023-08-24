<%@ Page Language="C#" AutoEventWireup="true"  Inherits="Workflow.NET.CodeBehind.Bam.Conditions" StylesheetTheme="" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html>
<html>
<head id="Head1">
    <title>Create/Edit condition</title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=cssPath%>Common/StyleSheet/Global.css" />
    <style>
        .levelwrap li {
            border-right: 1px solid gray;
            padding: 5px !important;
            margin: 4px !important;
        }
        .operatortyperesize {
            width: 202px !important;
            margin-left: 270px !important;
        }
        select#ActivityListAO {
            width: 43.5% !important;
            margin-left: 328px;
        }
        select#OperatorTypeAO {
            width: 43.5% !important;
            margin-left: 87px;
        }
        .Operatordesc {
            padding-left: 382px !important;
        }
        .ActivityStatusTypechkbox {
            padding-left: 376px !important;
        }
        
    </style>
    <script>
        function isIE11() {
            return !!navigator.userAgent.match(/Trident.*rv[ :]*11\./);
        }
        function CloseDataPointFrame() {
            if (window.navigator.userAgent.indexOf('MSIE') > 0 || isIE11()) {
                var ow = refreshRadWindow();
            }

            parent.CloseDataPointFrameAndRefresh();
        }

        function refreshRadWindow() {
            var oWindow = parent.parent.frameElement.radWindow;
            parent.parent.frameElement.contentWindow.location.reload();
        }
    </script>
</head>
<body style="font-family: Roboto; font-size: 8px; border: none; margin: 0px 0px 0px 7px; padding: none; overflow:auto;" leftmargin="2px" topmargin="2px" rightmargin="2px" bottommargin="2px" horizantalscroll="no" id="PageViewDate">
   
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
         <telerik:RadScriptManager ID="RadScriptManager1" runat="server" />
         <script src="<%=JSPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
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


        function DisplayMessage(message) {

            se.ui.messageDialog.showAlert("<%=GR.GetString("Security_Rights_comn_Alert_for_list")%>", message);
        }
        function DisplayErrorMessage(message) {

            se.ui.messageDialog.showError("<%=GR.GetString("BAM_Performance_Title_for_Page")%>", message);
        }

    </script>
        <link href="<%=cssPath%>CommonUXControls/StyleSheet/se.ui.min.css"  rel="stylesheet" type="text/css" />  
         <link href="<%:cssPath%>TelerikAjax/StyleSheet/AWTTabStrip/TabStrip.AWTTabStrip.css" rel="stylesheet" type="text/css" />
        <link href="<%:cssPath%>TelerikAjax/StyleSheet/AWTCalendar/Calendar.AWTCalendar.css" rel="stylesheet" type="text/css" />
        <link href="<%:cssPath%>TelerikAjax/StyleSheet/AWTCalendar/Calendar.css" rel="stylesheet" type="text/css" />
        <link href="<%:cssPath%>TelerikAjax/StyleSheet/AWTInput/Input.AWTInput.css" rel="stylesheet" type="text/css" />
         <link href="<%:cssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css" rel="stylesheet" type="text/css" />
         <link href="<%:cssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css" rel="stylesheet" type="text/css" />
        <table width="885px">
            <tr>
                <td colspan="2">
           <telerik:RadTabStrip RenderMode="Classic" runat="server" ID="RadTabStrip1" Skin="AWTTabStrip"  EnableEmbeddedSkins="false"  Align="left" SelectedIndex="0" MultiPageID="RadMultiPage1">
                <Tabs>
                <telerik:RadTab runat="server" ID="tabName" PageViewID="PageView1" Text=""></telerik:RadTab>
                <telerik:RadTab runat="server" ID="tabDate" PageViewID="PageView2" Text=""></telerik:RadTab>
                </Tabs>
        </telerik:RadTabStrip> 
        </td>
            </tr>
        </table>

        <script>

            function load() {
                sdocument.getElementById("calendarContainer").style.display = "block";
            }

            function changeConditionByName() {
                var ws = document.getElementById("workflowStatus");
                var as = document.getElementById("activityStatus");
                var ao = document.getElementById("activityOutput");
                var wif = document.getElementById("WorkItemField");
                var qu = document.getElementById("Queue");

                ws.style.display = "none";
                as.style.display = "none";
                ao.style.display = "none";
                wif.style.display = "none";
                qu.style.display = "none";
                var drpselected = document.getElementById("ConditionType");
                switch (drpselected.value) {
                    case "Workflow Status": ws.style.display = "block"; break;
                    case "Activity Status": as.style.display = "block"; break;
                    case "Activity Output": ao.style.display = "block"; break;
                    case "Work Item Field": wif.style.display = "block"; break;
                    case "Queue": qu.style.display = "block"; break;
                }
            }

            function ClearCondition() {

                var Condition = document.getElementById("txtCondition");
                var ConditionFormatted = document.getElementById("txtConditionFormatted");

                Condition.value = "";
                ConditionFormatted.value = "";
            }

            function changeCondition() {
              changeConditionByName();
            }
            function changeConditions() {
               changeConditionByName();
            }

        </script>
      
            <telerik:RadMultiPage ID="RadMultiPage1"  runat="server" SelectedIndex="-1" Height="487px">
            <telerik:RadPageView ID="PageView1" runat="server" Height="450px">
                <table border="0" width="880px">
                    <tr>
                        <td colspan="2" style="width: 295px; height: 12px;">
                            <span class="description"><%=GR.GetString("BAMPerformance_Name")%></span>
                        </td>
                        <td colspan="2">
                            <asp:TextBox CssClass="inputtext" ID="txtConditionName" runat="server" Width="369px" MaxLength="80"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <span class="description"><%=GR.GetString("BAMPerformance_BamDescription")%></span>
                        </td>
                        <td colspan="2">
                            <asp:TextBox CssClass="inputtext" ID="txtDescription" runat="server" Rows="3" TextMode="MultiLine" Width="365px" MaxLength="200"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <span class="description"><%=GR.GetString("BAMPerformance_Condition")%></span>
                        </td>
                        <td colspan="2">
                            <asp:TextBox CssClass="inputtext" ID="txtCondition" runat="server" Rows="4" TextMode="MultiLine" Width="365px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2"></td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <table width="790px">
                                <tr>
                                    <td colspan="3">
                                        <span class="description"><%=GR.GetString("BAMPerformance_SelectWorkFlow")%></span>
                                    </td>
                                    <td >
                                        <telerik:RadComboBox ID="ddwSelectWorkFlow" runat="server" Skin="AWTCombobox" RenderMode="Classic" OnClientSelectedIndexChanged="changeConditions(this)" AutoPostBack="true" EnableEmbeddedSkins="false" Height="150px" >
                                        </telerik:RadComboBox>
                                    </td>
                                    <td>
                                        <asp:Button ID="ClearButton" CssClass="inputbutton" runat="server" ToolTip="Clear the Condition" Width="97px" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="width: 308px">
                                        <span class="description"><%=GR.GetString("BAMPerformance_Conditionbasedon")%></span>
                                    </td>
                                    <td>
                                        <asp:DropDownList CssClass="inputselect" ID="ConditionType" runat="server" Width="200px"  onchange="changeCondition();">
                                        </asp:DropDownList>
                                    </td>
                                    <td></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 200px;" colspan="4" valign="middle">

                            <!-- Div for WorkFlow Status -->
                            <div style="-moz-box-sizing: border-box; border: solid 1px black; background-color: White; padding: 5px 5px 5px 5px; display: block; height: 295px;" id="workflowStatus">
                                <span class="description"><%=GR.GetString("BAMPerformance_IfWorkflowStatusIs")%></span>
                                <asp:DropDownList CssClass="inputselect operatortyperesize" ID="OperaterType" runat="server">
                                </asp:DropDownList>
                                <br />
                                <div style="OVERFLOW: auto; HEIGHT: 235px" id="divWorkFlowStatus">
                                    <asp:CheckBoxList ID="WorkflowStatusTypes" runat="server" style="width: 100%;padding-left: 375px;padding-top: 5px;" CssClass="inputcheckbox">
                                    </asp:CheckBoxList>
                                    <br />
                                </div>
                                <table>
                                    <tr>
                                        <td style="HEIGHT: 26px;padding-left: 470px;padding-top: 5px;">
                                            <asp:Button ID="insertworkflow" CssClass="inputbutton" OnClick="insertworkflow_Click" runat="server"></asp:Button>&nbsp; 
                                            <asp:Button ID="insertworkflow_and" CssClass="inputbutton" runat="server"></asp:Button>&nbsp; 
                                            <asp:Button ID="insertworkflow_or" CssClass="inputbutton" runat="server"></asp:Button>&nbsp; 
                                        </td>
                                    </tr>
                                </table>

                            </div>

                            <!-- Div for Activity Status -->
                            <div style="-moz-box-sizing: border-box; border: solid 1px black; background-color: White; padding: 10px 5px 5px 5px; display: none; height: 220px;" id="activityStatus">
                                <span class="description Operatordesc"><%=GR.GetString("BAMPerformance_IfActivity")%> </span>
                                <asp:DropDownList CssClass="inputselect" ID="ActivityListAS" runat="server"></asp:DropDownList>
                                
                                <span class="description"><%=GR.GetString("BAMPerformance_hasstatus")%></span>
                                <asp:DropDownList CssClass="inputselect" ID="OperatorTypeAS" runat="server">
                                </asp:DropDownList>
                                <br />
                                <br />
                                <div style="OVERFLOW: auto; HEIGHT: 130px" id="divActivityStatus">
                                    <asp:CheckBoxList ID="ActivityStatusTypes" runat="server" Width="840px" CssClass="inputcheckbox ActivityStatusTypechkbox">
                                    </asp:CheckBoxList>
                                    <br />
                                    <br />
                                </div>
                                <table>
                                    <tr>
                                        <td style="HEIGHT: 26px;padding-left: 602px; padding-top: 20px;" align="center">
                                            <asp:Button ID="asinsert" CssClass="inputbutton" runat="server"></asp:Button>&nbsp; 
                                            <asp:Button ID="asinsert_or" CssClass="inputbutton" runat="server"></asp:Button>&nbsp; 
                                        </td>
                                    </tr>
                                </table>
                            </div>

                            <!-- Div for activity Output -->
                            <div style="-moz-box-sizing: border-box; border: solid 1px black; background-color: White; padding: 5px 5px 5px 5px; display: none; height: 220px;" id="activityOutput">
                                <span class="description"><%=GR.GetString("BAMPerformance_IfActivity")%> </span>
                                <asp:DropDownList CssClass="inputselect" ID="ActivityListAO" runat="server">
                                </asp:DropDownList>
                                <br />
                                <br />
                                <span class="description"><%=GR.GetString("BAMPerformance_hasstartedbecauseofIncomingLinkhavingCondition")%></span>
                                <asp:DropDownList CssClass="inputselect" ID="OperatorTypeAO" runat="server">
                                </asp:DropDownList>
                                <br />
                                <div style="OVERFLOW: auto; HEIGHT: 110px">
                                    <asp:CheckBoxList ID="activityOutputs" runat="server" Width="340px" CssClass="inputcheckbox">
                                    </asp:CheckBoxList>
                                </div>
                                <table>
                                    <tr>
                                        <td style="HEIGHT: 26px; padding-left: 602px; padding-top: 20px;" align="center">
                                            <asp:Button ID="aoinsert" runat="server" CssClass="inputbutton"></asp:Button>&nbsp;
                                            <asp:Button ID="aoinsert_or" runat="server" CssClass="inputbutton"></asp:Button>&nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </div>

                            <!-- Div for WorkItemFields -->
                            <div style="-moz-box-sizing: border-box; border: solid 1px black; background-color: White; padding: 5px 5px 5px 5px; display: none; height: 220px;" id="WorkItemField">
                                <span class="description"><%=GR.GetString("BAMPerformance_SelectWorkItemField")%></span>
                                <br />
                                <div style="OVERFLOW: auto; HEIGHT: 170px" id="divWorkItemFields">
                                    <asp:CheckBoxList ID="chkWorkItemField1" runat="server" CssClass="inputcheckbox" Height="26px" Width="350px" RepeatColumns="2"></asp:CheckBoxList>
                                    <br />
                                </div>
                                <table>
                                    <tr>
                                        <td style="HEIGHT: 26px; width: 400px;padding-left: 602px;" align="center">
                                            <asp:Button ID="aoinsertWI" OnClick="aoinsertWI_Click" runat="server" CssClass="inputbutton"></asp:Button>&nbsp;
                                            <asp:Button ID="aoinsert_orWI" OnClick="aoinsert_orWI_Click" runat="server" CssClass="inputbutton"></asp:Button>&nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </div>

                            <!-- Div for Queue -->
                            <div style="-moz-box-sizing: border-box; border: solid 1px black; background-color: White; padding: 5px 5px 5px 5px; display: none; width: 868px; height: 220px;" id="Queue">
                                <span class="description"><%=GR.GetString("BAMPerformance_SelectQueue")%></span>
                                <br />
                                <div style="OVERFLOW: auto; HEIGHT: 170px" id="divQueue">
                                    <asp:CheckBoxList ID="chkQueue" runat="server" CssClass="inputcheckbox" Width="350px" RepeatColumns="2"></asp:CheckBoxList>
                                    <br />
                                </div>
                                <table >
                                    <tr>
                                        <td style="HEIGHT: 26px; width: 400px;padding-left: 612px;" align="center">
                                            <asp:Button ID="aoinsertQueue" OnClick="aoinsertQueue_Click" runat="server" CssClass="inputbutton"></asp:Button>&nbsp;
                                            <asp:Button ID="aoinsert_orQueue" OnClick="aoinsert_orQueue_Click" runat="server" CssClass="inputbutton"></asp:Button>&nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 0px;">
                            <asp:TextBox Style="FONT-SIZE: 9px; FONT-FAMILY: Roboto" ID="txtConditionFormatted" runat="server" Visible="False"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </telerik:RadPageView>
            <telerik:RadPageView ID="PageView2" runat="server">
                <div >
                    <div>

                        <!-- Div for the WorkItem Fields for Combination level -->
                        <div style="BORDER-RIGHT: black 1px solid; PADDING-RIGHT: 5px; BORDER-TOP: black 1px solid; PADDING-LEFT: 5px; PADDING-BOTTOM: 5px; BORDER-LEFT: black 1px solid; PADDING-TOP: 5px; BORDER-BOTTOM: black 1px solid; HEIGHT:38px; BACKGROUND-COLOR: white; moz-box-sizing: border-box; width: 865px;overflow:auto;" id="Div4">
                            <span class="description"><%=GR.GetString("BAMPerformance_SelectWorkItemField")%></span>
                            <br />
                            <div style="" id="DivWorkItemField">
                                <asp:CheckBoxList ID="chkWorkItemField" runat="server" RepeatColumns="2" CssClass="inputcheckbox"></asp:CheckBoxList>
                                <br />
                            </div>
                        </div>
                        <br />

                        <!-- Div for the WorkItem Fields for Combination level -->
                        <div style="BORDER-RIGHT: black 1px solid; PADDING-RIGHT: 5px; BORDER-TOP: black 1px solid; PADDING-LEFT: 5px; PADDING-BOTTOM: 5px; BORDER-LEFT: black 1px solid; PADDING-TOP: 5px; BORDER-BOTTOM: black 1px solid; HEIGHT: 54px; BACKGROUND-COLOR: white; moz-box-sizing: border-box; width: 865px;" id="Div3">
                            <asp:CheckBox ID="chkAck" runat="server" OnCheckedChanged="chkSame_CheckedChanged" Font-Size="Small" CssClass="inputcheckbox" />
                            <br />
                            <asp:CheckBox ID="chkCalRes" runat="server" Font-Size="Small" CssClass="inputcheckbox" />
                        </div>
                        <br />

                        <!-- Div for the Date Range for Process -->
                        <div style="BORDER-RIGHT: black 1px solid; PADDING-RIGHT: 5px; BORDER-TOP: black 1px solid; DISPLAY: block; PADDING-LEFT: 5px; LEFT: 9px; PADDING-BOTTOM: 5px; BORDER-LEFT: black 1px solid; PADDING-TOP: 5px; BORDER-BOTTOM: black 1px solid; HEIGHT: 180px; BACKGROUND-COLOR: white; moz-box-sizing: border-box; width: 865px;" id="Div1">
                            <span class="description"><%=GR.GetString("BAMPerformance_SelectDateRangeForProcess")%>:</span>
                            <br />
                            <div>
                                <div style="HEIGHT: 50px" border="0" cellpadding="5" cellspacing="0">
                                    <asp:RadioButtonList ID="rBtnDateRangeProcess" runat="server" AutoPostBack="True" Height="34px" Width="330px" CssClass="inputradio" OnSelectedIndexChanged="rBtnDateRangeProcess_SelectedIndexChanged" RepeatColumns="2">
                                        <asp:ListItem Value="Lastweek"></asp:ListItem>
                                        <asp:ListItem Value="Fortnight"></asp:ListItem>
                                        <asp:ListItem Value="Lastmonth"></asp:ListItem>
                                        <asp:ListItem Value="Daterange"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                            </div>
                            
                            <div style="padding-top:20px;">
                                <div style="float:left;width:50%;">
                                    
                                    <span class="description"><%=GR.GetString("BAMPerformance_From")%></span>
                                   <telerik:RadDatePicker ID="startDate" runat="server" Width="125px" RenderMode="Classic" EnableEmbeddedSkins="false" Skin="AWTCalendar">
                                       <DateInput Skin="AWTInput" runat="server"></DateInput>
                                       <Calendar ID="Calendar1" runat="server" Skin="AWTCalendar">
                                       </Calendar>
                                   </telerik:RadDatePicker>
                                  </div>
                                <div style="float:right;width:50%;">

                                    <span class="description"><%=GR.GetString("BAMPerformance_To")%></span>
                                    <telerik:RadDatePicker ID="endDate" runat="server" Width="125px" RenderMode="Classic" EnableEmbeddedSkins="false" Skin="AWTCalendar">
                                       <DateInput Skin="AWTInput" runat="server"></DateInput>
                                       <Calendar ID="Calendar2" runat="server" Skin="AWTCalendar">
                                       </Calendar>
                                   </telerik:RadDatePicker>
                                </div>
                            </div>
                            <div style="padding-top:50px;">
                            <asp:CheckBox ID="chkSame" runat="server" OnCheckedChanged="chkSame_CheckedChanged" CssClass="inputcheckbox" AutoPostBack="True"></asp:CheckBox>&nbsp;<span class="description"><%=GR.GetString("BAMPerformance_ApplySameDateRangeforCalculatingWeightedAverage")%></span>
                                </div>
                        </div>
                        <br />

                        <!-- Div for the Date Range for Calculating the Weighted Avg -->
                        <div style="BORDER-RIGHT: black 1px solid; PADDING-RIGHT: 5px; BORDER-TOP: black 1px solid; DISPLAY: block; PADDING-LEFT: 5px; PADDING-BOTTOM: 5px; BORDER-LEFT: black 1px solid; PADDING-TOP: 5px; BORDER-BOTTOM: black 1px solid; HEIGHT: 130px; BACKGROUND-COLOR: white; moz-box-sizing: border-box; width: 868px;" id="Div2">
                            <span class="description"><%=GR.GetString("BAMPerformance_SelectDateRangeForCalculatingWeightedAverage")%>:</span>&nbsp; 
                                <br />
                            <div>
                                <asp:RadioButtonList ID="rBtnDateRange" runat="server" AutoPostBack="True" Height="34px" Width="330px" CssClass="inputradio" OnSelectedIndexChanged="rBtnDateRange_SelectedIndexChanged" RepeatColumns="2">
                                    <asp:ListItem Value="Lastweek"></asp:ListItem>
                                    <asp:ListItem Value="Fortnight"></asp:ListItem>
                                    <asp:ListItem Value="Lastmonth"></asp:ListItem>
                                    <asp:ListItem Value="Daterange"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                            <br />
                             <div style="padding-top:55px;">
                                <div style="float:left;width:50%;">
                                <span class="description"><%=GR.GetString("BAMPerformance_From")%></span>
                                       <telerik:RadDatePicker ID="firstInput" runat="server" Width="125px" RenderMode="Classic" EnableEmbeddedSkins="false" Skin="AWTCalendar">
                                       <DateInput Skin="AWTInput" runat="server"></DateInput>
                                       <Calendar ID="Calendar3" runat="server" Skin="AWTCalendar">
                                       </Calendar>
                                   </telerik:RadDatePicker>  
                                </div>
                                <div style="float:right;width:50%;">
                                                  <span class="description"><%=GR.GetString("BAMPerformance_To")%></span>
                                       <telerik:RadDatePicker ID="secondInput" runat="server" Width="125px" Skin="AWTCalendar" RenderMode="Classic" EnableEmbeddedSkins="false">
                                       <DateInput Skin="AWTInput" runat="server"></DateInput>
                                       <Calendar ID="Calendar4" runat="server" Skin="AWTCalendar">
                                       </Calendar>
                                   </telerik:RadDatePicker>    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
           </telerik:RadPageView>
        </telerik:RadMultiPage>
     
       <div style="height:15px;text-align: right;margin-right: 15px">
                    <asp:Button ID="DeleteButton" runat="server" OnClick="DeleteButton_Click" CssClass="inputbutton" /> &nbsp; &nbsp;
                    <asp:Button ID="CancelButton" runat="server" OnClientClick="CloseDataPointFrame()" CssClass="inputsecondarybutton" /> &nbsp; &nbsp;
                    <asp:Button ID="SaveButton" runat="server" OnClick="SaveButton_Click1" CssClass="inputbutton" />
          
       </div>
    </form>
</body>
</html>
