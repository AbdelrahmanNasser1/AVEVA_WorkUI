<%@ Page Language="C#" Trace="false" AutoEventWireup="true" enableSessionState="true" Inherits="Skelta.SSRS.Connector.CodeBehind.SSRSTestRun" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=15.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<!DOCTYPE html>
<html>
<head id="Head1">
   <title>
        <%= sr.GetString("test_ssr_execution_heading_title")%>
    </title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script>
      <link href="<%=_CssPath%>CommonUXControls/StyleSheet/se.ui.min.css"  rel="stylesheet" type="text/css" />  
    <link rel="stylesheet" type="text/css" href="<%:_CssPath%>TelerikAjax/StyleSheet/AWTInput/Input.AWTInput.css" />
    <link rel="stylesheet" type="text/css" href="<%:_CssPath%>TelerikAjax/StyleSheet/AWTCalendar/Calendar.AWTCalendar.css">
    <link rel="stylesheet" type="text/css" href="<%:_CssPath%>TelerikAjax/StyleSheet/AWTCalendar/Calendar.css">
    <meta http-equiv="content-type" content="Type=text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <link rel="stylesheet" href="<%=_CssPath%>Common/StyleSheet/Global.css" type="text/css" />    
    <style type="text/css">
    
        .html,body,form 
        {
            overflow-x: hidden;
            width: 100%;
            height: 100%;
            padding: 0;
            border-width: 0px;
        }
    </style>
</head>
<body onload="OnLOadControlDisable();">

    <script>

        se.ui.messageDialog.setGlobalOptions({
            localization: {
                closeButtonCaption: "<%=sr.GetString("se_ui_messagedialog_close_caption") %>",
        okButtonCaption: "<%=sr.GetString("se_ui_messagedialog_ok_caption") %>",
        cancelButtonCaption: "<%=sr.GetString("se_ui_messagedialog_cancel_caption") %>",
        showDetailsCaption: "<%=sr.GetString("se_ui_messagedialog_showdetails_caption") %>",
        hideDetailsCaption: "<%=sr.GetString("se_ui_messagedialog_hidedetails_caption") %>"
    }
        });

        function DisplayErrorMessage(strMessage) {
            var strHdrMsg = '<%=sr.GetString("test_ssr_execution_heading_title")%>';
            se.ui.messageDialog.showError(strHdrMsg, strMessage);
        }
        function DisplaySuccessMessage(strMessage) {
            var strHdrMsg = '<%=sr.GetString("test_ssr_execution_heading_title")%>';
            se.ui.messageDialog.showAlert(strHdrMsg, strMessage);
        }


    </script>

   <form id="form1" runat="server">
       <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
       <asp:scriptmanager id="ScriptManager1" runat="server"></asp:scriptmanager>
        <table style="width:100%;border-spacing:0px;border-spacing:1px;border-collapse:separate;" >
            <tr class="ListHeaderCss">
                <td style="vertical-align:top;">
                    <table style="width:100%;border-spacing:1px;border-collapse:separate;">
                        <tr style="vertical-align:top;">
                            <td style="vertical-align:middle;width:100%;padding:5px;">
                                <span class="fontheading">
                                    <%= sr.GetString("test_ssr_execution_heading")%>
                                </span>
                            </td>
                        </tr>
                         <tr style="vertical-align:top;">
                            <td class="description" style="vertical-align:middle;padding:5px;" colspan="2">
                                 <%= sr.GetString("test_ssr_execution_heading_desc")%>
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
           
            <tr>
                <td style="vertical-align:top;height:100%;">
                    <table style="margin:0px auto;border-spacing:2px;border-collapse:separate;width:100%;" class="tablebg" >
                        <tr>
                            <td class="lefttdbg" style="width: 30%;padding:5px;vertical-align:top;">
                                <span class="subtitle">
                                    <%=sr.GetString("processdesigner_activity_setparam_parameter_lbl")%>
                                </span>
                                <br />
                                <span class="description">
                                  <%=sr.GetString("processdesigner_activity_setparam_parameter_lbl_desc")%>
                                  <br />
                                </span>
                            </td>
                            <td class="righttdbg" style="padding:5px;">
                            <label style="visibility:hidden;position:absolute;left:450px;top:180px" id="lblWait"><%=sr.GetString("processdesigner_activity_setparam_parameter_wait_text")%></label>
                                <div runat="server" id="hiddenCheckboxdiv" style="overflow:auto;display:none;height:30px;">
                                
                                </div>
                                <div runat="server" id="parameterDiv" style="height:140px; overflow:auto;border:1px solid #666;">
                                
                                </div>
                            </td>
                        </tr>
                        <tr class="lefttdbg" style="height:20px;">
                            <td colspan="2">
                                <table style="width:100%;border-collapse:collapse;border-spacing:0px;">
                                    <tr>
                                        <td style="text-align:right;padding:3px;">
                                            <asp:Button ID="GoButton" OnClientClick="return Validate();" runat="server" OnClick="GoButton_Click" CssClass="inputbutton" Text="Go >>" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>

                        <tr>
                            <td class="righttdbg" colspan="2" style="max-height:300px;overflow:auto;padding-left:8px;padding-right:6px;padding-top:10px;">
                                <div runat="server" id="ShowReportDiv" style="height:300px; overflow:inherit;border:1px solid #666;">
                                    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Height="100%" Width="100%" ShowParameterPrompts="false" ShowCredentialPrompts="false" ProcessingMode="Remote" EnableTelemetry="false" KeepSessionAlive="true">
                                    </rsweb:ReportViewer>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
      
        <input id="hidtxtParamId" type="hidden" name="hidRowSelectedNo" />
        <input id="hidFullValueId" type="hidden" name="hidRowSelectedNo" />
        <input id="hidModeId" type="hidden" name="hidRowWithActualValue" />
        <input id="hidImageId" type="hidden" name="hidImage" />
        <input id="hidParamName" type="hidden" name="hidParamName" />
        <input id="hidParamType" type="hidden" name="hidParamType" />
        <asp:HiddenField ID="hiddenNumberofParam" runat="server" Value="" />
        <asp:HiddenField ID="hiddenParamStringValue" runat="server" Value="" />
        <asp:HiddenField ID="HiddenActionName" runat="server" Value="" />
        <asp:HiddenField ID="historianConnectionName" runat="server" Value="" />
        <asp:HiddenField ID="historianConnectionNameforTimeZone" runat="server" Value="" />
        <asp:HiddenField ID="isHiddenIncluded" runat="server" Value="" />
    </form>
    
</body>
</html>
<script language="javascript" type="text/javascript">
    function openTagPicker(txtParamId, isMultiple)
    {
        var url = "../../SkeltaForms/SSRSHistorianTagLookUp.aspx?";
        if (isMultiple == "Y" || isMultiple == 'y')
        {
            isMultiple = "1";
        }
        else
        {
            isMultiple = "0";
        }

        url = url + "multiple=" + isMultiple + "&HistorianConnection=" + document.getElementById("<%=historianConnectionName.ClientID%>").value + "&datafieldid=" + txtParamId;

        window.open(url, "_default", "status=no,width=830,height=350,top=250,left=400")
    }

    function openTimeZonePicker(txtParamId)
    {

        var url = "../../SkeltaForms/SSRSTimeZonePicker.aspx?";
        var intRadcontrolId = txtParamId.replace("txtParam", "rnt");
        var timezoneid = -1;
        timezoneid = GetValueFromNumberControl(txtParamId.replace("txtParam", "rnt"), "");
        url = url + "HistorianConnection=" + document.getElementById("<%=historianConnectionNameforTimeZone.ClientID%>").value + "&timezone=" + timezoneid + "&datafieldid=" + intRadcontrolId;

        window.open(url, "_default", "status=no,width=470,height=190,top=370,left=580")
    }

    function SetSSRSTagValue(controlId, controlValue, connectionName, tagType)
    {
        if (document.getElementById(controlId) != null)
        {
            if (tagType == 'TimeZone')
            {
                SetValueToNumberControl($find(controlId), controlValue);
                if ((connectionName != null) && (connectionName != ""))
                {
                    document.getElementById("<%=historianConnectionNameforTimeZone.ClientID%>").value = connectionName;
                }
            }
            else if (tagType == 'Historian')
            {
                document.getElementById(controlId).value = controlValue;
                if ((connectionName != null) && (connectionName != ""))
                {
                    document.getElementById("<%=historianConnectionName.ClientID%>").value = connectionName;
                }
            }
        }
    }

function resizefunction() {
    var bodydiv = document.getElementById('bodydiv');
    if (bodydiv != null) {
       
        bodydiv.style.width = '80%';
        bodydiv.style.height = '80%';
    }
}

function GetSelectedValueFromRadioButtonList(controlId, defaultValue) {
    try {
        var selectedValue = defaultValue;
        var f = document.forms[0];
        var e = f.elements[controlId];

        for (var i = 0; i < e.length; i++) {
            if (e[i].checked) {
                selectedValue = e[i].value;
                break;
            }
        }

        return selectedValue;
    }
    catch (err) {
        return defaultValue;
    }
}

function SetRadioButtonListEnabled(controlId, _enable) {
    var radioControl = document.forms[0].elements[controlId];

    for (var i = 0; i < radioControl.length; i++) {
        radioControl[i].disabled = !_enable;
    }
}

function SetRadioButtonListValue(controlId, setValue) {
    var radioControl = document.forms[0].elements[controlId];

    for (var i = 0; i < radioControl.length; i++) {
        if (radioControl[i].value == setValue) {
            radioControl[i].checked = true;
        }
        else {
            radioControl[i].checked = false;
        }
    }
}

    function GetDateTimePickerControl(id)
    {
        return $find(id);
    }

    function EnableDateTimePicker(cntrl, _enable)
    {
        cntrl.set_enabled(_enable);
    }

    function SetValueToDateTimeControl(dateTimeCntrl, _dateObject)
    {
        dateTimeCntrl.set_selectedDate(_dateObject);
    }

    // Below method would be required if we need to consider UTC value
    function SetUTCValueToDateTimeControl(dateTimeCntrl, _dateValue)
    {
        var dateObj = new Date();

        try
        {
            if ((_dateValue == "")
                || (_dateValue == null))
            {
                SetValueToDateTimeControl(dateTimeCntrl, "");
                return;
            }

            var _dateParts = _dateValue.split("-");

            dateObj.setUTCFullYear(_dateParts[0], parseInt(_dateParts[1]) - 1, _dateParts[2]);
            dateObj.setUTCHours(_dateParts[3], _dateParts[4], _dateParts[5], _dateParts[6]);

            SetValueToDateTimeControl(dateTimeCntrl, dateObj);
        }
        catch (err)
        {
            SetValueToDateTimeControl(dateTimeCntrl, "");
        }
    }

    function SetValueToDateTimeControlFromString(dateTimeCntrl, _dateValue)
    {
        var dateObj = new Date();

        try
        {
            if ((_dateValue == "")
                || (_dateValue == null))
            {
                SetValueToDateTimeControl(dateTimeCntrl, "");
                return;
            }

            var _dateParts = _dateValue.split("-");

            dateObj.setFullYear(_dateParts[0], parseInt(_dateParts[1]) - 1, _dateParts[2]);
            dateObj.setHours(_dateParts[3], _dateParts[4], _dateParts[5], _dateParts[6]);

            SetValueToDateTimeControl(dateTimeCntrl, dateObj);
        }
        catch (err)
        {
            SetValueToDateTimeControl(dateTimeCntrl, "");
        }
    }

    function GetNumberControl(id)
    {
        return $find(id);
    }

    function EnableNumberControl(cntrl, _enable)
    {
        if (_enable)
        {
            cntrl.enable();
        }
        else
        {
            cntrl.disable();
        }
    }

    function SetValueToNumberControl(numberControl, _value)
    {
        numberControl.set_value(_value);
    }

function chkNull_OnClick(sender) {
    SetNullableToUI(sender.id.replace("chk", ""));
}
function chkShowHidden_OnClick(sender) {
    if ((sender.checked)) {
        if (document.getElementById("tblHidden") != null) {
            document.getElementById("tblHidden").style.display = '';
            document.getElementById("hiddenCheckboxdiv").style.disply = '';
        }
        if (document.getElementById("tblNonHiddennotPresentLable") != null) {
            document.getElementById("tblNonHiddennotPresentLable").style.display = 'none';
        }
    }
    else {
        if (document.getElementById("tblHidden") != null) {
            document.getElementById("tblHidden").style.display = 'none';
            document.getElementById("hiddenCheckboxdiv").style.disply = 'none';
        }
        if (document.getElementById("tblNonHiddennotPresentLable") != null) {
            document.getElementById("tblNonHiddennotPresentLable").style.display = '';
        }

    }
}
    function GetChkNullObject(i)
    {
        var chkNull = document.getElementById("chk" + i);

        try
        {
            if (chkNull.id == chkNull.id)
            {
                // Just to check if the element exists.
            }
        }
        catch (err)
        {
            chkNull = null;
        }

        return chkNull;
    }

    function SetNullableToUI(id)
    {
        var chkNull = GetChkNullObject(id);
        var txtParm = document.getElementById("txtParam" + id);
        var dataType = document.getElementById("hiddenParamType" + id).value;

        var boolParm = null;
        var dateTimeParm = null;
        var numericParm = null;

        switch (dataType)
        {
            case "boolean":
                boolParm = document.getElementById("rbl" + id);
                break;
            case "datetime":
                dateTimeParm = GetDateTimePickerControl("dtp" + id);
                break;
            case "integer":
            case "float":
                numericParm = GetNumberControl("rnt" + id);
                break;
            case "string":
            default:
                break;
        }
        if (txtParm != null)
        {
            txtParm.disabled = ((chkNull != null) && (chkNull.checked == true));
        }

        if (boolParm != null)
        {
            boolParm.disabled = ((chkNull != null) && (chkNull.checked == true));
            // Below call is required for Mozilla to disable the radio buttons.
            SetRadioButtonListEnabled(boolParm.id, !((chkNull != null) && (chkNull.checked == true)));
        }

        if (dateTimeParm != null)
        {
            EnableDateTimePicker(dateTimeParm, !((chkNull != null) && (chkNull.checked == true)));
        }

        if (numericParm != null)
        {
            EnableNumberControl(numericParm, !((chkNull != null) && (chkNull.checked == true)));
        }
    }

    function GetDisplayBlockString()
    {
        //        if (document.getElementById("hdnIsBrowserIEType").value == "1")
        //        {
        //            return "inline";
        //        }
        //        else
        //        {
        //            return "";
        //        }
        return "";
    }

    function Validate()
    {
        var totalPAramCount = document.getElementById("<%= hiddenNumberofParam.ClientID%>").value;
        var alertValue = "";
        var count;

        //
        for (count = 0; count < totalPAramCount; count++)
        {
            var id = 'hiddenMandatory' + count;
            if (document.getElementById(id) != null && rtrim(ltrim(document.getElementById(id).value)) == "YES")
            {
                var textboxid = 'txtParam' + count;
                var type = document.getElementById('hiddenParamType' + count).value;

                var textValue = "";
                switch (type)
                {
                    case "boolean":
                        textValue = GetSelectedValueFromRadioButtonList("rbl" + count, "");
                        break;
                    case "datetime":
                        textValue = $find("dtp" + count).get_selectedDate();
                        textValue = GetDateFormated(textValue);
                        break;
                    case "integer":
                    case "float":
                        textValue = GetValueFromNumberControl("rnt" + count, "");
                        break;
                    default:
                        textValue = document.getElementById(textboxid).value;
                        break;
                }

                if (textValue == "")
                {
                    var paramName = 'hiddenParamName' + count;
                    if (document.getElementById(paramName) != null)
                    {
                        var messageVal = '<%= sr.GetString("ssrs_process_designer_ssrsreportparam_msg")%>';
                        messageVal = messageVal.replace("{0}", document.getElementById(paramName).value);
                        if (alertValue != "")
                        {
                            alertValue = alertValue + "</br>" + messageVal;
                        }
                        else
                        {
                            alertValue = messageVal;
                        }
                    }
                }
            }
        }
        if (alertValue == "")
        {
            document.getElementById("<%=hiddenParamStringValue.ClientID %>").value = CreateValueString();
            if (document.getElementById("chkShowHidden") != null && document.getElementById("chkShowHidden").checked == true)
            {
                document.getElementById("<%=isHiddenIncluded.ClientID %>").value = "yes";
            }
            else
            {
                document.getElementById("<%=isHiddenIncluded.ClientID %>").value = "no";
            }

            return true;
        }
        else
        {
            // alert(alertValue);
            DisplayErrorMessage(alertValue);
            return false;
        }
    }
    function OnLOadControlDisable() {
        if (document.getElementById("chkShowHidden") != null && document.getElementById("chkShowHidden").checked == true && document.getElementById("tblHidden") != null) {
            document.getElementById("tblHidden").style.display = "";
        }
        var totalPAramCount = document.getElementById("<%= hiddenNumberofParam.ClientID%>").value;
        for (count = 0; count < totalPAramCount; count++) {
            var chkNullObj = GetChkNullObject(count);

            if ((chkNullObj != null) && (chkNullObj.checked == true)) {
                chkNull_OnClick(chkNullObj)
            }
        }
    }
    function CreateValueString() {
        var paramValueString;
        var paramSeparator;
        var paramValueSeparator;
        var paramSeparator;
        paramValueSeparator = "<%=_ValueSeparetor %>";
        paramSeparator = "<%=_ParamSeparetor %>";
        var totalPAramCount = document.getElementById("<%= hiddenNumberofParam.ClientID%>").value;
        for (count = 0; count < totalPAramCount; count++) {

            var id;
            var dataValueId;
            var paramName;
            var actualValu;
            var mode;
            var paramType;

            paramType = document.getElementById("hiddenParamHidden" + count).value;

            dataValueId = "txtParam" + count;
            mode = "TEXT";
            var pramType = document.getElementById("hiddenParamType" + count).value;
            var chkNullObj = GetChkNullObject(count);

            if ((chkNullObj != null) && (chkNullObj.checked == true)) {
                actualValue = "@!NULL!@";
            }
            else {
                switch (pramType) {
                    case "boolean":
                        actualValue = GetSelectedValueFromRadioButtonList("rbl" + count, "");
                        break;
                    case "datetime":
                        actualValue = $find("dtp" + count).get_selectedDate();
                        actualValue = GetDateFormated(actualValue);
                        break;
                    case "integer":
                    case "float":
                        actualValue = GetValueFromNumberControl("rnt" + count, "");
                        break;
                    default:
                        actualValue = document.getElementById(dataValueId).value;
                        break;
                }
            }

            paramName = rtrim(ltrim(document.getElementById('hiddenParamName' + count).value));
            if (paramType != "Y" || (paramType == "Y" && actualValue != "")) {
                if (paramValueString == null || paramValueString == "") {
                    paramValueString = paramName + paramValueSeparator + mode + paramValueSeparator + actualValue + paramValueSeparator + pramType;
                }
                else {
                    paramValueString = paramValueString + paramSeparator + paramName + paramValueSeparator + mode + paramValueSeparator + actualValue + paramValueSeparator + pramType;
                }
            }
        }
        return paramValueString;
    }
    function ltrim(s) {
        return s.replace(/^\s*/, "");
    }
    function rtrim(s) {
        return s.replace(/\s+$/, "");
    }
    function GetDateFormated(actualValue)
    {
        try
        {
            return actualValue.getFullYear() + "-" + (actualValue.getMonth() + 1) + "-" + actualValue.getDate() + "-" + actualValue.getHours() + "-" + actualValue.getMinutes() + "-" + actualValue.getSeconds() + "-" + actualValue.getMilliseconds();
        }
        catch (r)
        {
            return "";
        }
    }
    function GetValueFromNumberControl(controlId, defaultValue)
    {
        try
        {
            return $find(controlId).get_value();
        }
        catch (r)
        {
            return defaultValue;
        }
    }
</script>


