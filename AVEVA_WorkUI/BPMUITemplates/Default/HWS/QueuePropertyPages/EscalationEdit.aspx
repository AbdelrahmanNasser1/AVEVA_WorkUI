<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.Queue.QueEscalationEdit" %>

<!DOCTYPE HTML>
<html>


<head id="Head1" runat="server">
    <title><%=resourceManager.GetString("Escalation")%></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=JSPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>      
    <script type="text/javascript">

        var pageLoadMode = "<%=Microsoft.Security.Application.Encoder.HtmlEncode(pageLoadMode)%>";
        function HelpLink() {
            var left = (screen.width / 2) - (800 / 2);
            var top = (screen.height / 2) - (400 / 2);
            window.open("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_QControl.GetHelpPageUrl(), false)%>EscalationTab.html", '', 'height=400,width=800,resizable=yes,status=no,scrollbars=yes, top=' + top + ', left=' + left);
        }

        function funTe() {
            //alert("Teststs");
            //return false; 
            var objChkReminder = document.getElementById('chkReminderMessage');
            var objChkNotification = document.getElementById('ChkNotification');
            var objchkMoveToDifferentQueue = document.getElementById('chkMoveToDifferentQueue');
            var objchkCallworkflow = document.getElementById('chkCallworkflow');
            var objchkReassign = document.getElementById('chkReassigns');

            var objchkTriggerEsc = document.getElementById('chkTriggerEsc');
            var objchkendWf = document.getElementById('chkendwf');
            var objchkPutbackinQueue = document.getElementById('chkPutbackinQueue');

            if (objchkendWf.checked == true || objChkReminder.checked == true || objChkNotification.checked == true || objchkMoveToDifferentQueue.checked == true || objchkCallworkflow.checked == true || objchkReassign.checked == true || objchkTriggerEsc.checked == true || objchkPutbackinQueue.checked == true) {
                //alert("hh");
                return true;
            }
            else {
               // alert('<%=resourceManager.GetString("Please select Escalation Types")%>');//alert("Please select Escalation Types");
                se.ui.messageDialog.showError('<%=resourceManager.GetString("Queue_Header")%>', '<%=resourceManager.GetString("Please select Escalation Types")%>');
        return false;
    }

}

function OpenReminderMessage() 
{
    var ReminderWinHt = 200;
    var appbr = navigator.userAgent;
    if (appbr.indexOf("MSIE") > -1)
        ReminderWinHt = 210;
    else
        ReminderWinHt = 224;

    var ReminderWinWidth = 750;

    if (navigator.userAgent.indexOf("Firefox") != -1)
        ReminderWinWidth = 660;

    var left;
    var top;
    left = (screen.width / 2) - (ReminderWinWidth / 2);
    top = (screen.height / 2) - (ReminderWinHt / 2);

    var app = document.getElementById("txtApplication").value;
    var wfname = document.getElementById("selLevelwrkflow").value;  
    window.open('<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_QControl.GetEscalationURL("QueuePropertyPages/QueueEscalation.aspx"), false)%>pageview=remindermessagediv&rem=1&idTxt=txtReminderMsg&workflowname=' + wfname + '&applicationname=' + app, 'EscalationTypes', "top=" + top + ",left=" + left + ",height=" + ReminderWinHt + ",width="+ ReminderWinWidth +",resizable=yes,scrollbars=no");

}

                function OpenWinForSetTimeInterval() {
                    var ReminderWinHt = 480;

                    var left;
                    var top;
                    left = (screen.width / 2) - (530 / 2);
                    top = (screen.height / 2) - (ReminderWinHt / 2);

                    var app = document.getElementById("txtApplication").value;
                    var wfname = document.getElementById("selLevelwrkflow").value;                    
                    window.open('<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_QControl.GetEscalationURL("QueuePropertyPages/SetEscTimeInterval.aspx"), false)%>pageLoadMode=' + pageLoadMode + '&pageview=remindermessagediv&rem=1&idTxt=txtReminderMsg&workflowname=' + wfname + '&applicationname=' + app, 'EscalationTypes', "top=" + top + ",left=" + left + ",height=" + ReminderWinHt + ",width=530,resizable=yes,scrollbars=no");


}

function OpenNotification() {
    var NotifyWinHt = 200;
    var appbr = navigator.userAgent;
    if (appbr.indexOf("MSIE") > -1)
        NotifyWinHt = 210;
    else
        NotifyWinHt = 224;

    var NotifyWinWidth = 750;

    if (navigator.userAgent.indexOf("Firefox") != -1)
        NotifyWinWidth = 660;


    var left;
    var top;
    left = (screen.width / 2) - (NotifyWinWidth / 2);
    top = (screen.height / 2) - (NotifyWinHt / 2);

    var app = document.getElementById("txtApplication").value;
    var wfname = document.getElementById("selLevelwrkflow").value;  
    window.open('<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_QControl.GetEscalationURL("QueuePropertyPages/QueueEscalation.aspx"), false)%>pageview=remindermessagediv&idTxt=txtNotification&workflowname=' + wfname + '&applicationname=' + app, 'EscalationTypes', "top=" + top + ",left=" + left + ",height=" + NotifyWinHt + ",width="+NotifyWinWidth+",resizable=yes,scrollbars=no");

}

function OpenCallWorkflow() {
    var WflowWinHt = 310;
    var appbr = navigator.userAgent;
    if (appbr.indexOf("MSIE") > -1)
        WflowWinHt = 310;
    else
        WflowWinHt = 320;

    var left;
    var top;
    left = (screen.width / 2) - (800 / 2);
    top = (screen.height / 2) - (WflowWinHt / 2);

    var app = document.getElementById("txtApplication").value;
    var wfname = document.getElementById("selLevelwrkflow").value;


    var calApp = document.getElementById("txtcalApplication").value;
    var calWfname = document.getElementById("txtcalWorkflow").value;

    
    window.open('<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_QControl.GetEscalationURL("QueuePropertyPages/QueueEscalation.aspx"), false)%>pageview=wftriggerdiv&idTxt=txtcallback&calworkflowname=' + calWfname + '&calApplicationname=' + calApp + '&workflowname=' + wfname + '&applicationname=' + app, 'EscalationTypes', "top=" + top + ",left=" + left + ",height=" + WflowWinHt + ",width=800,resizable=yes,scrollbars=no");
}

function OpenReassign() {
    var app = document.getElementById("txtApplication").value;
    var Guid = document.getElementById("txtQueueId").value;
    var VirtualId = document.getElementById("txtreassign").value;

    var ReassignWinHt = 190;
    var appbr = navigator.userAgent;
    if (appbr.indexOf("MSIE") > -1)
        ReassignWinHt = 206;
    else
        ReassignWinHt = 210;

    var left;
    var top;
    left = (screen.width / 2) - (300 / 2);
    top = (screen.height / 2) - (ReassignWinHt / 2);

    
    window.open('<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_QControl.GetEscalationURL("QueuePropertyPages/QueueEscalation.aspx"), false)%>pageview=reassigndiv&reass=1&idTxt=txtreassign&appname=' + app + '&guid=' + Guid + '&VirID=' + VirtualId, 'EscalationTypes', "top=" + top + ",left=" + left + ",height=" + ReassignWinHt + ",width=300,resizable=yes,scrollbars=no")

}

function EscalationTypes() {

    var objEsc = document.getElementById("selLevel");
    //alert(objEsc.value);
    if (objEsc.value == "Queue Item Created") {
        document.getElementById('chkReminderMessage').disabled = true;
        document.getElementById('chkPutbackinQueue').disabled = true;
        document.getElementById('chkReassigns').disabled = true;
        document.getElementById('chkendwf').disabled = false;
    }
    else {
        document.getElementById('chkReminderMessage').disabled = false;
        document.getElementById('chkPutbackinQueue').disabled = false;
        document.getElementById('chkReassigns').disabled = false;
        document.getElementById('chkendwf').disabled = true;
        document.getElementById('chkendwf').checked = false;
        ///                objchkend.checked=false;
    }


}



function visibutton(chck, btn) {
    //Reminder Message 
    //alert("s");
    var objChkReminder = document.getElementById('chkReminderMessage')
    document.getElementById('chkRecuring').disabled = true;

    if (objChkReminder.checked == true) {
        document.getElementById("btnReminder").style.visibility = 'visible';
        document.getElementById('chkRecuring').disabled = false;

    }
    else {
        document.getElementById("btnReminder").style.visibility = 'hidden';
    }

    //Notification
    var objChkNotification = document.getElementById('ChkNotification')
    if (objChkNotification.checked == true) {
        document.getElementById("Button6").style.visibility = 'visible';
        document.getElementById('chkRecuring').disabled = false;

    }
    else {
        document.getElementById("Button6").style.visibility = 'hidden';
    }

    //Move To Different Queue chkMoveToDifferentQueue

    var objchkMoveToDifferentQueue = document.getElementById('chkMoveToDifferentQueue')
    if (objchkMoveToDifferentQueue.checked == true) {
        document.getElementById("Select2_Queue_div").style.visibility = 'visible';
    }
    else {
        document.getElementById("Select2_Queue_div").style.visibility = 'hidden';
    }

    //Trigger Escalate Output 
    var objchkTriggerEsc = document.getElementById('chkTriggerEsc')
    if (objchkTriggerEsc.checked == true) {
        document.getElementById('chkRecuring').disabled = false;
    }

    // Fire action output "Time Out for Queue Task"
    var objchkendWf = document.getElementById('chkendwf');
    if (objchkendWf.checked == true) {
        document.getElementById('chkRecuring').disabled = false;
    }

    //Call a Workflow 
    var objchkCallworkflow = document.getElementById('chkCallworkflow')
    if (objchkCallworkflow.checked == true) {
        //alert("sds");
        document.getElementById("Button14").style.visibility = 'visible';
    }
    else {
        document.getElementById("Button14").style.visibility = 'hidden';
    }

    //Put Back In Queue (Validation: Can be set only for picked stage)


    //Re Assign (Validation: Can be set only for picked stage) btnReassign

    var objchkReassign = document.getElementById('chkReassigns')
    if (objchkReassign.checked == true) {
        //alert("sds");
        document.getElementById("btnReassign").style.visibility = 'visible';
    }
    else {
        document.getElementById("btnReassign").style.visibility = 'hidden';
    }

}


    </script>
</head>
<body onload="visibutton('chkReminder','btnReminder');EscalationTypes()">
    <script>
        se.ui.messageDialog.setGlobalOptions({
            localization: {
                closeButtonCaption: "<%=resourceManager.GetString("se_ui_messagedialog_close_caption") %>",
            okButtonCaption: "<%=resourceManager.GetString("se_ui_messagedialog_ok_caption") %>",
            cancelButtonCaption: "<%=resourceManager.GetString("se_ui_messagedialog_cancel_caption") %>",
            showDetailsCaption: "<%=resourceManager.GetString("se_ui_messagedialog_showdetails_caption") %>",
            hideDetailsCaption: "<%=resourceManager.GetString("se_ui_messagedialog_hidedetails_caption") %>"
        }
          });


    </script>

    <form id="form1" runat="server">
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <link href="<%=JSPath%>CommonUXControls/StyleSheet/se.ui.min.css"  rel="stylesheet" type="text/css" />
        <link rel="stylesheet" type="text/css" href="<%=_QControl.GetThemeRelativeUrl("Common/StyleSheet/Global.css")%>" />        
        <input type="hidden" id="txtApplication" value='<%:_ApplicationName%>' />
        <input type="hidden" id="txtQueueId" value='<%:_QueueGUID%>' />

        <div id="divescalaltionAdd" style="text-align: left;overflow:auto;height:480px;">
            <table id="Table19" style="width: 100%;">
                <tr class="ListHeaderCss">
                    <td style="width: 100%; padding: 3px;">
                        <span class="fontheading">
                            <%=resourceManager.GetString("Queue_Escalation_Title")%>
                        </span>
                        <asp:Label ID="_LblQueueName1" runat="server" CssClass="subtitle"></asp:Label>
                    </td>
                    <td style="width: 5%; text-align: center; padding: 3px;">
                        <a href="#" onclick="JavaScript:HelpLink();">
                            <img src="<%=_QControl.GetCommonRelativeUrl("../hws/images/icon-help.png")%>" alt="<%=resourceManager.GetString("Help")%>" title="<%=resourceManager.GetString("Help")%>"
                                border="0">
                        </a>
                    </td>
                </tr>
                <tr>
                    <td class='lefttdbg' colspan="2" style="padding: 2px">
                        <span class='description'>
                            <%=resourceManager.GetString("Queue_EscalationNotifyDesc")%></span>
                    </td>
                </tr>

            </table>
            <table id="Table1" style="width: 100%; border-collapse: separate; border-spacing: 1px;" class="tablebg">
                <tr>
                    <td style="width: 50%; padding: 1px; vertical-align: top; text-align: left;" colspan="3">
                        <table style="width: 100%; border-collapse: separate; border-spacing: 1px;" border="0" class="tablebg">
                            <tr>
                                <td class="lefttdbg" style="width: 50%; padding: 2px;">
                                    <span class="subtitle">
                                        <%=resourceManager.GetString("Queue_Escalation_Workflows")%></span>
                                    <br />
                                    <span class="description"><%=resourceManager.GetString("Queue_Escalation_WorkflowsDesc")%></span>
                                </td>
                                <td style="width: 50%; text-align: left; padding: 2px;" class="righttdbg">
                                    <select name="selLevelwrkflow" runat="server"  class="inputselect" id="selLevelwrkflow">
                                        
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="lefttdbg" style="vertical-align: top; text-align: left; padding: 2px;">
                                    <span class="subtitle"><%=resourceManager.GetString("Queue_QueueItem_Stages")%></span>
                                    <br />
                                    <span class="description"><%=resourceManager.GetString("Queue_QueueItem_StagesDesc")%></span>
                                </td>
                                <td style="text-align: left; padding: 2px;" class="righttdbg">
                                    <select id="selLevel" name="selLevel" runat="server" onchange="EscalationTypes()" class="inputselect">
                                        <option value="Queue Item Created">Queue Item Created</option>
                                        <option value="Queue Item Picked">Queue Item Picked</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td style="vertical-align: top; text-align: left; padding: 2px; width: 50%;" class="lefttdbg">
                                    <span class="subtitle"><%=resourceManager.GetString("Queue_Escalation_Time_Inteval")%></span>
                                    <br />
                                    <span class="description"><%=resourceManager.GetString("Queue_Escalation_Time_IntevalDesc")%></span>
                                </td>
                                <%
                                    if (EscalationInterval != "")
                                    {  
                                %>
                                <td style="text-align: left; padding: 2px;" class="righttdbg">
                                    <input type="text" class="inputtext" id="txtEscalationTimeInterval" name="txtEscalationTimeInterval"
                                        value="<%=EscalationInterval%>" style="width:200px">
                                    <input id="Button1" class="inputbutton" type="button" value="<%=resourceManager.GetString("Set")%>" name="btnSetEscTimeInterval" onclick="OpenWinForSetTimeInterval();">
                                </td>
                                <%
                                    }
                                    else
                                    {    
                                %>
                                <td style="text-align: left; padding: 2px;" class="righttdbg">
                                    <input type="text" class="inputtext" id="Text1" name="txtEscalationTimeInterval" value="0.00:00:00" style="width:200px">

                                    <input id="Button2" class="inputbutton" type="button" value="<%=resourceManager.GetString("Set")%>" style="margin-left:10px;" name="btnSetEscTimeInterval" onclick="OpenWinForSetTimeInterval();">
                                </td>
                                <%} %>
                            </tr>
                            <tr>
                                <td class="lefttdbg" style="text-align: left; padding: 2px;">
                                    <span class="subtitle"><%=resourceManager.GetString("Queue_Escalation_Recurring")%></span>
                                    <br />
                                    <span class="description"><%=resourceManager.GetString("Queue_Escalation_RecurringDesc")%></span>
                                </td>
                                <td style="text-align: left; padding-left: 6px;" class="righttdbg">
                                    <input type="checkbox" class="inputcheckbox" id="chkRecuring" runat="server" name="chkRecuring" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <table class="tablebg" style="margin: 0px auto; border-collapse: separate; border-spacing: 1px; width: 100%; padding: 2px;" border="0">
                <tr>
                    <td style="width: 50%; padding: 3px; vertical-align: top;" class="lefttdbg">
                        <span class="subtitle">
                            <%=resourceManager.GetString("Queue_Escalation_Types")%></span>
                        <br />
                        <span class="description"><%=resourceManager.GetString("Queue_Escalation_TypesDesc")%></span>
                    </td>
                    <td colspan="2" style="vertical-align: top; width: 50%; padding: 3px;" class="righttdbg">
                        <table style="width: 100%; border-collapse: collapse; border-spacing: 1px;" class="righttdbg">
                            <tr>
                                <td style="width: 5%; padding: 3px;">
                                    <input type="checkbox" class="inputcheckbox" id="chkReminderMessage" runat="server">
                                </td>
                                <td style="width: 80%; padding: 3px; text-align: left;">
                                    <span class='description'><%=resourceManager.GetString("Queue_Reminder_Message")%></span>
                                </td>
                                <td style="text-align: left; padding: 3px;">
                                    <input class="inputbutton" id="btnReminder" style="visibility: hidden" onclick="OpenReminderMessage();"
                                        type="button" value="<%=resourceManager.GetString("Queue_btn_Set_Properties")%>" title="<%=resourceManager.GetString("Queue_btn_Set_Properties")%>"
                                        name="btnReminder">
                                    <input type="hidden" id="txtReminderMsg" name="txtReminderMsg" />
                                    <input type="hidden" id="txtRemSubject" value="<%=_ReminderMessageSubject%>" name="txtRemSubject" />
                                    <input type="hidden" id="txtRemNotes" value="<%=_ReminderMessageNotes%>" name="txtRemNotes" />
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 5%; padding: 3px;">
                                    <!-- <input id=Checkbox30    onclick="visibutton('chkNotification','btnNotification')"    type=checkbox  name=chkNotification> -->
                                    <input id="ChkNotification" runat="server" type="checkbox" name="chkNotification">
                                </td>
                                <td style="text-align: left; padding: 3px; width: 80%;">
                                    <span class='description'><%=resourceManager.GetString("Queue_Escalation_Notification")%></span>
                                </td>
                                <td style="text-align: left; padding: 3px;">
                                    <input class="inputbutton" id="Button6" style="visibility: hidden" onclick="OpenNotification();"
                                        type="button" value="<%=resourceManager.GetString("Queue_btn_Set_Properties")%>"
                                        name="btnNotification" title="<%=resourceManager.GetString("Queue_btn_Set_Properties")%>">
                                    <input type="hidden" id="txtNotification" name="txtNotification" />
                                    <input type="hidden" id="txtNotifSubject" value="<%=_NotificationSubject%>" name="txtNotifSubject" />
                                    <input type="hidden" id="txtNotifNotes" value="<%=_Notificationnotes%>" name="txtNotifNotes" />
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 5%; padding: 3px;">
                                    <input id="chkMoveToDifferentQueue" runat="server" type="checkbox" class='inputcheckbox' name="chkMovetoQueue">
                                </td>
                                <td style="text-align: left; width: 80%; padding: 3px;">
                                    <span class='description'><%=resourceManager.GetString("Queue_Move_To_Different_Queue")%></span>
                                </td>
                                <td style="text-align: left; padding: 3px;">
                                    <div id="Select2_Queue_div" style="text-align: left; width: 100%; padding-top: 16px; visibility: Hidden;">
                                        <select id="Select2_Queue" runat="server"  class="inputselect">
                                        </select>
                                        <a href="QueueView.aspx" style="visibility: Hidden" id="viewLink" onclick="popup = window.open('../QueuePropertyPages/QueueView.aspx', 'PopupPage', 'height=500,width=780,scrollbars=yes,resizable=yes'); return false" target="_blank">View</a>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 5%; padding: 3px;">
                                    <!-- <input id=Checkbox32   onclick="visibutton('chkReassign','btnReassign')" type=checkbox  name=chkReassign> -->
                                    <input type="checkbox" id="chkReassigns" runat="server" class="inputchecckbox">
                                </td>
                                <td style="text-align: left; padding: 3px; width: 80%;">
                                    <span class='description'><%=resourceManager.GetString("Queue_Re_Assign")%></span>
                                </td>
                                <td style="text-align: left; padding: 3px;">
                                    <input class="inputbutton" id="btnReassign" style="visibility: hidden" onclick="OpenReassign()"
                                        type="button" value="<%=resourceManager.GetString("Queue_btn_Set_Properties")%>"
                                        name="btnReassign" title="<%=resourceManager.GetString("Queue_btn_Set_Properties")%>" >
                                    <input type="hidden" id="txtreassign" name="txtreassign" value="<%=_StrActorId%>" />
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 5%; padding: 3px;">
                                    <input type="checkbox" class="inputcheckbox" id="chkTriggerEsc" runat="server" name="chkTriggerEsc">
                                </td>
                                <td style="text-align: left; padding: 3px; width: 80%;">
                                    <span class='description'><%=resourceManager.GetString("Queue_Trigger_Escalate_Output")%></span>
                                </td>
                                <td style="text-align: left; padding: 3px;"></td>
                                <!--
                                            <INPUT id=txtTrigger style="VISIBILITY: hidden" type=text class=INPUTS1 name=txtTrigger>                                    </TD>
                                        -->
                            </tr>
                            <tr>
                                <td style="width: 5%; padding: 3px;">
                                    <!--  <INPUT id=Checkbox34     onclick="visibutton('chkCallWF','btnCallWF')" type=checkbox         name="chkCallWF" /> -->
                                    <input type="checkbox" id="chkCallworkflow" class="inputcheckbox" runat="server" name="chkCallWF" />
                                </td>
                                <td style="text-align: left; padding: 3px; width: 80%;">
                                    <span class='description'><%=resourceManager.GetString("Queue_Call_a_Workflow")%></span>
                                </td>
                                <td style="text-align: left; padding: 3px;">
                                    <input class="inputbutton" id="Button14" style="visibility: hidden" onclick="OpenCallWorkflow();"
                                        type="button" value="<%=resourceManager.GetString("Queue_btn_Set_Properties")%>"
                                        name="btnCallWF" title="<%=resourceManager.GetString("Queue_btn_Set_Properties")%>">
                                    <input type="hidden" id="txtcallback" name="txtcallback" />
                                    <input type="hidden" value="<%=_InvokeApplicationName%>" id="txtcalApplication" name="txtcalApplication" />
                                    <input type="hidden" value="<%=_InvokeWorkflowName%>" id="txtcalWorkflow" name="txtcalWorkflow" />
                                    <input type="hidden" value="<%=_InvokeContent%>" id="txtcalContent" name="txtcalContent" />
                                    <input type="hidden" value="<%=_InokeVersion%>" id="txtcalVer" name="txtcalVer" />
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 5%; padding: 3px;">
                                    <input id="chkPutbackinQueue" runat="server" type="checkbox" class='inputcheckbox' name="chkPutbackinQueue">
                                </td>
                                <td colspan="2" style="text-align: left; padding: 3px; width: 80%;">
                                    <span class='description'><%=resourceManager.GetString("Queue_Put_Back_In_Queue")%></span>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 5%; padding: 3px;">
                                    <input type="checkbox" name="chkendwf" class="inputcheckbox" runat="server" id="chkendwf" />
                                </td>
                                <td colspan="2" style="text-align: left; padding: 3px;">
                                    <span class='description'><%=resourceManager.GetString("Queue_Trigger_TimeOut")%></span>
                            </tr>
                        </table>
                    </td>
                </tr>

            </table>
            
        </div>
        <div id="btnNewSave">
            <table style="width: 100%; margin: 0px auto;">
                <tr>
                    <td colspan="2" style="float: right;padding-right:10px;">
                        <asp:Button ID="BtnNewSave" runat="server" Text="Save" CssClass="inputbutton" />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
