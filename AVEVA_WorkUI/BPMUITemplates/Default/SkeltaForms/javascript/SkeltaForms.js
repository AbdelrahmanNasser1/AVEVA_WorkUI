var _skidmap;
var _skselectedformclient;
function sf_selectRowOnLoad(formclient, rowtoselectid, selectedrowstoreid, detailsid, detailpageid, index)
{
    try
    {
        var selectedRowElements = document.getElementById(selectedrowstoreid);
        var lastElemId = selectedRowElements.value;
        if (lastElemId != null && lastElemId != "")
        {
            var lastElem = document.getElementById(lastElemId);
            if (lastElem != null)
            {
                lastElem.className = "sf-gridrow";

                if (lastElem.childNodes[0] != null && lastElem.childNodes[0].childNodes[0] != null && lastElem.childNodes[0].childNodes[0].tagName == 'IMG')
                {
                    lastElem.childNodes[0].innerHTML = lastElem.childNodes[0].innerHTML.replace("editedrow.png", "defaultrow.png");
                }
            }
        }
    } catch (err1) { }
    _skselectedformclient = formclient;
    var selectedrowstorerealid;
    var isAddRowClick = false;
    // when clicked on addnew button this clientId will give the clientID after it is added to the page
    var selectedRowElement = document.getElementById(selectedrowstoreid);
    if (selectedRowElement == null)
    {
        //when rendering the clientId after assigned to page will be different from the assigned at the control level due to INamingContainer
        //get the real client id after it is assigned to the page..
        if (_skidmap != null)
        {
            selectedrowstorerealid = _skidmap[selectedrowstoreid];
            selectedRowElement = document.getElementById(selectedrowstorerealid);
            isAddRowClick = true;
        }
    }
    if (selectedRowElement == null) return; //alert("Cannot find selected value holder");
    var rowElement = document.getElementById(rowtoselectid);
    if (rowElement == null)
    {
        //alert("Invalid row to select on load for "+formclient+","+rowtoselectid+","+detailpageid);
        return;
    }
    else
    {
        rowElement.className = "sf-gridselectedrow";
        selectedRowElement.value = rowtoselectid;
        //alert(selectedRowElement.value);
        //var detailsSectionId = formclient + "_detailspages";
        //if it is due to addrow click use the selectedrowstoreid(which the clientID after assigned to Page)
        //else get the selectedrowstorerealid fetched from skidmap object.
        var str;
        if (!isAddRowClick)
            str = new String(selectedrowstoreid);
        else
            str = new String(selectedrowstorerealid);
        var regEx = new RegExp('_srid', 'gi');
        str = str.replace(regEx, '_detailspages');
        var detailsSectionId = str;
        var detailsSection;
        try
        {
            detailsSection = eval(detailsSectionId);
        }
        catch (e) { }
        if (!(typeof detailsSection == 'undefined') && detailsSection != null)
        {
            detailsSection.SelectPageById(formclient + "_dp" + index);
        }
        //else
        //alert("No details");
    }
}

function OpenDSWindow(containerid, uniqueid, mappedid, mappedname, CacheKey, ListName, versionstamp)
{
    var features = ',resizable=yes';
    var u = _TemplateDirectorySkeltaForms + "Lookuplist.aspx?sfdcontainer=" + escape(containerid) + "&controlid=" + escape(uniqueid) + "&mappedparentid=" + escape(mappedid) + "&mappedparentname=" + mappedname + "&cachekey=" + CacheKey + "&listname1=" + ListName + "&versionstamp=" + versionstamp;
    var oWindow1 = CenterWindow(u, 'controllookup', parseInt(document.body.clientWidth, 10), parseInt(document.body.clientHeight * .50, 10), 50, features);
    return oWindow1;
}

function OpenSSRSReportViewerConfigurationWindow(containerid, uniqueid, mappedid, CacheKey, ListName, versionstamp, reportTemplateTitle, ReportViewOption, hiddenControlId)
{
    var features = ',resizable=yes';
    var u = _TemplateDirectorySkeltaForms + "SSRSReportConfiguration.aspx?sfdcontainer=" + escape(containerid) + "&controlid=" + escape(uniqueid) + "&mappedparentid=" + escape(mappedid) + "&cachekey=" + CacheKey + "&listname1=" + ListName + "&versionstamp=" + versionstamp + "&reportTemplateTitle=" + reportTemplateTitle + "&reportViewOption=" + ReportViewOption + "&hiddenControlId=" + hiddenControlId;
    var oWindow1 = CenterWindow(u, 'reportViewerConfiguration', 1000, 650, 50, features);
    return oWindow1;
}

function OpenSSRSReportViewerPopupWindow(AppName, InstXmlId, CacheKey, ListName, reportViewerControlId, versionstamp, formname)
{
    var u = GetSSRSReportViewerPageUrl(AppName, InstXmlId, CacheKey, ListName, reportViewerControlId, versionstamp, '1', formname);
    //var u = _TemplateDirectorySkeltaForms + "SSRSReportHandler.aspx?appname=" + AppName + "&instxmlid=" + InstXmlId + "&cachekey=" + CacheKey + "&listname1=" + ListName + "&reportViewerControlId=" + escape(reportViewerControlId) + "&versionstamp=" + versionstamp + "&showclose=" + showclose;
    return window.open(u, 'reportViewPopup', 'top=100,left=100,height=500,width=770,resizable=yes');
}

function GetSSRSReportViewerPageUrl(AppName, InstXmlId, CacheKey, ListName, reportViewerControlId, versionstamp, showclose, formname)
{
    return _TemplateDirectorySkeltaForms + "SSRSReportHandler.aspx?appname=" + AppName + "&instxmlid=" + InstXmlId + "&cachekey=" + CacheKey + "&listname1=" + ListName + "&reportViewerControlId=" + escape(reportViewerControlId) + "&versionstamp=" + versionstamp + "&showclose=" + showclose + "&formname=" + formname;
}

var _ctlToBeFocusedforAppendRow;
function sf_selectRow(formclient, index, selectedrowstoreid, obj)
{
    _ctlToBeFocusedforAppendRow = obj;

    _skselectedformclient = formclient;
    sf_onFocus(obj);
    //alert(selectedrowstoreid);
    var selectedrowstorerealid;//will hold the clientID assigned to the control when added to the INamingContainer
    var isAddRowClick = false;
    // when clicked on addnew button this clientId will give the clientID after it is added to the page
    var selectedRowElement = document.getElementById(selectedrowstoreid);
    //var selectedRowElement = document.getElementById(_skidmap[selectedrowstoreid]);
    if (selectedRowElement == null)
    {
        //when rendering the clientId after assigned to page will be different from the assigned at the control level due to INamingContainer
        //get the real client id after it is assigned to the page..
        if (_skidmap != null)
        {
            selectedrowstorerealid = _skidmap[selectedrowstoreid];
            selectedRowElement = document.getElementById(selectedrowstorerealid);
            isAddRowClick = true;
        }
    }
    if (_skidmap != null && selectedRowElement == null) return; //alert("Cannot find selected value holder");
    var rowElementId = formclient + "_trrow_" + index;
    var rowElement = document.getElementById(rowElementId);
    if (rowElement != null && selectedRowElement != null)
    {
        var lastElementId = selectedRowElement.value;
        if (lastElementId != null && lastElementId != "")
        {
            var lastElement = document.getElementById(lastElementId);
            if (lastElement != null)
            {
                lastElement.className = "sf-gridrow";

                if (lastElement.childNodes[0] != null && lastElement.childNodes[0].childNodes[0] != null && lastElement.childNodes[0].childNodes[0].tagName == 'IMG')
                {
                    lastElement.childNodes[0].innerHTML = lastElement.childNodes[0].innerHTML.replace("editedrow.png", "defaultrow.png");
                }
            }
        }
        rowElement.className = "sf-gridselectedrow";
        if (rowElement.childNodes[0] != null && rowElement.childNodes[0].childNodes[0] != null && rowElement.childNodes[0].childNodes[0].tagName == 'IMG')
        {
            rowElement.childNodes[0].innerHTML = rowElement.childNodes[0].innerHTML.replace("newrow.png", "editedrow.png");
            rowElement.childNodes[0].innerHTML = rowElement.childNodes[0].innerHTML.replace("defaultrow.png", "editedrow.png");
        }
        selectedRowElement.value = rowElementId;
        //alert(selectedRowElement.value);
        //        if(!isAddRowClick)
        //            document.getElementById(selectedrowstoreid).value = rowElementId;
        //        else
        //            document.getElementById(selectedrowstorerealid).value = rowElementId;
        //var detailsSectionId = formclient + "_detailspages";
        //if it is due to addrow click use the selectedrowstoreid(which the clientID after assigned to Page)
        //else get the selectedrowstorerealid fetched from skidmap object.
        var str;
        if (!isAddRowClick)
            str = new String(selectedrowstoreid);
        else
            str = new String(_skidmap[selectedrowstoreid]);
        var regEx = new RegExp('_srid', 'gi');
        str = str.replace(regEx, '_dps');
        var detailsSectionId = str;
        var detailsSection;
        try
        {
            detailsSection = eval(detailsSectionId);
        }
        catch (e) { }
        if (!(typeof detailsSection == 'undefined') && detailsSection != null)
        {
            detailsSection.SelectPageById(formclient + "_dp" + index);
        }
        //else
        //   alert("No details");

    }
    else
    {
        if (selectedRowElement != null) alert("not found");
    }

}
function sf_updateMappers(values)
{

    var toprenderid = _skidmap["TOPFORMRENDERERID"];
    var hdnMapperId = _skidmap[toprenderid + "_gsm"];
    var mapperValues = document.getElementById(hdnMapperId).value;
    if (!(mapperValues == "" || mapperValues == null))
    {
        if (mapperValues.indexOf(values) == -1)
            document.getElementById(hdnMapperId).value += values;
    }
    else
        document.getElementById(hdnMapperId).value = values;
}

String.prototype.startsWith = function (str) { return (this.match("^" + str) == str) }
String.prototype.endsWith = function (str) { return (this.match(str + "$") == str) }

function sf_updateSummary(columnName, isfloat, roundResults, roundToDecimal, outputType, resultColumn, mapperField)
{

    //Ensure ClientIDs
    if (_skidmap == null)
    {
        return;
    }
    var resultColumnrealId = _skidmap[resultColumn];
    //var mapperFieldrealId = _skidmap[mapperField];
    var mapperFieldrealId = mapperField;

    if (document.getElementById(resultColumnrealId) == null) return;

    var mapRecords = new Array();
    if (mapperField)
    {
        var mappingStr = document.getElementById(mapperFieldrealId).value;
        var mappings = mappingStr.split(",");
        for (var map in mappings)
        {
            mapRecords.push(mappings[map]);
        }
    }
    else
        alert("No Map field found");

    var total = 0;
    var recId = 0;
    //here have for loop till except the last record..
    while (true)
    {
        //var crecId = recId+1;
        var currentColumn = columnName + "_" + mapRecords[recId];
        //LOGIC TO GET THE UPDATE SUMMARY VALUES -- ROHIT
        var toprenderid = _skidmap["TOPFORMRENDERERID"];
        var hdnMapperId = _skidmap[toprenderid + "_gsm"];
        var mapperValues = document.getElementById(hdnMapperId).value;
        if (mapperValues == "" || mapperValues == null)
            return;

        var mValues = mapperValues.split('}{');
        for (var i = 0; i < mValues.length; i++)
        {
            //Apply correction
            if (!mValues[i].startsWith("{"))
            {
                mValues[i] = "{" + mValues[i];
            }

            if (!mValues[i].endsWith("}"))
            {
                mValues[i] = mValues[i] + "}";
            }

            var actualStr = mValues[i].substr(1, mValues[i].length - 2);
            var pair = actualStr.split("$");
            if (currentColumn == pair[0])
            {
                currentColumn = pair[1]; break;
            }
        }

        //END OF LOGIC
        var currentColumnrealId = _skidmap[currentColumn];

        if (document.getElementById(currentColumnrealId))
        {
            var valueToTest = parseFloat(document.getElementById(currentColumnrealId).value);
            if (valueToTest)
            {
                total += parseFloat(document.getElementById(currentColumnrealId).value);
            }
            recId++;
        }
        else
            break;

    }
    var finalValue;
    if (outputType == 1)
    {
        try
        {
            var summaryControl = window[resultColumnrealId];
            if (summaryControl != null)
            {
                summaryControl.SetValue(recId);
            }
        }
        catch (err)
        {

        }
        //document.getElementById(resultColumnrealId).value = recId;
        return; // recId; //Count
    }
    if (recId > 0)
    {
        if (outputType == 3) total = total / recId; //Average
    }
    else
    {
        document.getElementById(resultColumnrealId).value = 0;
    }
    if (isfloat)
    {
        if (roundResults)
            finalValue = sf_roundNumber(total, roundToDecimal);
        else
            finalValue = total;
    }
    else
    {
        if (roundResults)
            finalValue = Math.round(total);
        else
            finalValue = Math.floor(total);
    }
    try
    {
        var summaryControl = window[resultColumnrealId];
        if (summaryControl != null)
        {
            summaryControl.SetValue(finalValue);
        }
    }
    catch (err)
    {

    }
    //document.getElementById(resultColumnrealId).value = finalValue;
}

function sf_reUpdateSummary(columnName, isfloat, roundResults, roundToDecimal, outputType, resultColumn, mapperField, random)
{
    if (_skidmap == null)
    {
        return;
    }
    var resultColumnrealId = _skidmap[resultColumn];
    //var mapperFieldrealId = _skidmap[mapperField];
    var mapperFieldrealId = mapperField;

    if (document.getElementById(resultColumnrealId) == null) return;

    var mapRecords = new Array();
    if (mapperField)
    {
        var mappingStr = document.getElementById(mapperFieldrealId).value;
        var mappings = mappingStr.split(",");
        for (var map in mappings)
        {
            mapRecords.push(mappings[map]);
        }
    }
    else
        alert("No Map field found");

    var total = 0;
    var recId = 0;
    //here have for loop till except the last record..
    while (true)
    {
        //var crecId = recId+1;
        var currentColumn = columnName + "_" + mapRecords[recId];
        //LOGIC TO GET THE UPDATE SUMMARY VALUES -- ROHIT
        var toprenderid = _skidmap["TOPFORMRENDERERID"];
        var hdnMapperId = _skidmap[toprenderid + "_gsm"];
        var mapperValues = document.getElementById(hdnMapperId).value;
        if (mapperValues == "" || mapperValues == null)
            return;

        var mValues = mapperValues.split('}{');
        for (var i = 0; i < mValues.length; i++)
        {
            //Apply correction
            if (!mValues[i].startsWith("{"))
            {
                mValues[i] = "{" + mValues[i];
            }

            if (!mValues[i].endsWith("}"))
            {
                mValues[i] = mValues[i] + "}";
            }

            var actualStr = mValues[i].substr(1, mValues[i].length - 2);
            var pair = actualStr.split("$");
            if (currentColumn == pair[0])
            {
                currentColumn = pair[1]; break;
            }
        }

        //END OF LOGIC
        var currentColumnrealId = _skidmap[currentColumn];

        if (document.getElementById(currentColumnrealId))
        {
            var valueToTest = parseFloat(document.getElementById(currentColumnrealId).value);
            if (valueToTest)
            {
                total += parseFloat(document.getElementById(currentColumnrealId).value);
            }
            recId++;
        }
        else
            break;

    }
    var finalValue;
    if (outputType == 1)
    {
        try
        {
            var summaryControl = window[resultColumnrealId];
            if (summaryControl != null)
            {
                summaryControl.SetValue(recId);
            }
        }
        catch (err)
        {

        }
        //document.getElementById(resultColumnrealId).value = recId;
        return; // recId; //Count
    }
    if (recId > 0)
    {
        if (outputType == 3) total = total / recId; //Average
    }
    else
    {
        document.getElementById(resultColumnrealId).value = 0;
    }
    if (isfloat)
    {
        if (roundResults)
            finalValue = sf_roundNumber(total, roundToDecimal);
        else
            finalValue = total;
    }
    else
    {
        if (roundResults)
            finalValue = Math.round(total);
        else
            finalValue = Math.floor(total);
    }
    try
    {
        var summaryControl = window[resultColumnrealId];
        if (summaryControl != null)
        {
            summaryControl.SetValue(finalValue);
        }
    }
    catch (err)
    {

    }
    //document.getElementById(resultColumnrealId).value = finalValue;
}
function sf_roundNumber(rnum, rlength)
{
    if (rnum > 8191 && rnum < 10485)
    {
        rnum = rnum - 5000;
        var newnumber = Math.round(rnum * Math.pow(10, rlength)) / Math.pow(10, rlength);
        newnumber = newnumber + 5000;
    }
    else
    {
        var newnumber = Math.round(rnum * Math.pow(10, rlength)) / Math.pow(10, rlength);
    }
    return newnumber;
}

var apnlCollec;
function DoAjaxRequest(ajaxId)
{
    if (apnlCollec == undefined)
        apnlCollec = new Object();

    if (apnlCollec[ajaxId] == undefined)
    {
        apnlCollec[ajaxId] = true;
        var ajaxPanelCltID = _skidmap[ajaxId];
        var arjs = 'RefreshingAjax';
        if (ajaxPanelCltID != undefined)
        {
            window[ajaxPanelCltID].ajaxRequest(arjs);
        }
    }
    else
    {
        return;
    }
}

function ReceiveServerData(arg, context)
{
    alert("Date from server: " + arg);
}


var inQueue = false;
var callServerOnRelease = false;

var pendingRequests = new Array();
function sf_raiseOnValueChange(oldValue, newValue, ajaxPanel, controlId)
{
    apnlCollec = new Object();
    if (!inQueue)
    {
        SetCurrentState();
        CallServerSideMethod(_skidmap["TOPFORMRENDERERID"], 'BuildForm', "DataTableTest", CallbackBuildXml, 'table', _skstatemap);
        inQueue = true;
    }
    else
    {
        pendingRequests.push("sf_raiseOnValueChange();");
    }
}

function sf_raiseOnValueChanged(tabObj)
{
    apnlCollec = new Object();
    if (!inQueue)
    {
        SetCurrentState();
        CallServerSideMethod(_skidmap["TOPFORMRENDERERID"], 'BuildForm', "DataTableTest", CallbackBuildXml, 'table', _skstatemap);
        inQueue = true;
    }
    else
    {
        pendingRequests.push("sf_raiseOnValueChange();");
    }
}
function CallbackBuildXml(context, result, response)
{
    //    var d = new Date();
    //    var val1 = d.getHours() + ":" + d.getMinutes() + ":" + d.getSeconds() + "." + d.getMilliseconds();
    //    alert("Start Time = " + val1);
    //    alert(result.length);
    // alert(result);
    if (result != null)
    {

        for (var i = 0; i < result.length; i++)
        {
            try
            {
                eval(result[i]);
            }
            catch (err) { }
            //a.text+=result[i];
        }
    }
    inQueue = false;
    if (pendingRequests.length > 0)
    {
        pendingRequests.splice(0, 1);
        sf_raiseOnValueChange();
    }

    //   var d2 = new Date();
    //   var val2 = d2.getHours() + ":" + d2.getMinutes() + ":" + d2.getSeconds() + "." + d2.getMilliseconds();
    //   alert("End Time = " + val2);

}

function sf1_raiseOnValueChange(oldValue, newValue, ajaxPanel, controlId)
{
    apnlCollec = new Object();
    if (!inQueue)
    {
        SetCurrentState();
        CallServerSideMethod(_skidmap["TOPFORMRENDERERID"], 'BuildForm', "DataTableTest", CallbackBuildXml, 'table', _skstatemap);
        inQueue = true;
    }
    else
    {
        pendingRequests.push("sf_raiseOnValueChange();");
    }

}

function sf_raiseOnValueChange()
{
    apnlCollec = new Object();
    if (!inQueue)
    {
        SetCurrentState();
        CallServerSideMethod(_skidmap["TOPFORMRENDERERID"], 'BuildForm', "DataTableTest", CallbackBuildXml, 'table', _skstatemap);
        inQueue = true;
    }
    else
    {
        pendingRequests.push("sf_raiseOnValueChange();");
    }
}
function sfAppendOneRow(cltId, currentrecord, totalNoOfRecs, senderUniqueId)
{
    var ajaxPanelClientID = _skidmap[cltId];
    if (currentrecord == totalNoOfRecs)
        CallServerSideMethod(_skidmap["TOPFORMRENDERERID"], 'AddGridRow', ajaxPanelClientID, CallbackGridAppended, 'table', _skstatemap, senderUniqueId);
}

function sfAppendOneRowForTime(timeobj, args)
{
    var ajaxCurrentPanel = timeobj.DivElement.getAttribute('ajaxcurrentId');
    var currentRecId = timeobj.DivElement.getAttribute('recordId');
    var RecCount = timeobj.DivElement.getAttribute('recordsCount');
    var senderUniqueId = dateobj.TextBoxElement.getAttribute('uqid');
    var ajaxPanelCurrentClientID = _skidmap[ajaxCurrentPanel];
    if (parseInt(currentRecId, 10) == parseInt(RecCount, 10))
    {
        CallServerSideMethod(_skidmap["TOPFORMRENDERERID"], 'AddGridRow', ajaxPanelCurrentClientID, CallbackGridAppended, 'table', _skstatemap, senderUniqueId);
    }
}

function sfAppendOneRowForDate(dateobj, args)
{
    var ajaxCurrentPanel = dateobj.TextBoxElement.getAttribute('ajaxcurrentId');
    var currentRecId = dateobj.TextBoxElement.getAttribute('recordId');
    var RecCount = dateobj.TextBoxElement.getAttribute('recordsCount');
    var senderUniqueId = dateobj.TextBoxElement.getAttribute('uqid');
    var ajaxPanelCurrentClientID = _skidmap[ajaxCurrentPanel];
    if (parseInt(currentRecId, 10) == parseInt(RecCount, 10))
    {
        CallServerSideMethod(_skidmap["TOPFORMRENDERERID"], 'AddGridRow', ajaxPanelCurrentClientID, CallbackGridAppended, 'table', _skstatemap, senderUniqueId);
    }
}

function CallbackGridAppended(context, response)
{
    for (var i = 0; i < response.length; i++)
    {
        try { eval(response[i]); } catch (aErr) { }
    }
}

function sf_raiseOnValueChangeForCombo(Comboitem, eventargs)
{

    sf_raiseOnValueChange("", Comboitem.Value, Comboitem.ComboBox.ID + "_parentajax", Comboitem.ComboBox.ID);

}

function sf_raiseOnValueChangeDate(sender)
{
    var dateElement = sender.get_element();
    var ajaxPanel = dateElement.getAttribute('ajaxId');
    var ctrlid = dateElement.getAttribute('controlId');
    var oldVal = dateElement.getAttribute('oldVal');
    sf_raiseOnValueChange(oldVal, sender.get_value(), ajaxPanel, ctrlid);
}

function sf_raiseOnValueChangeComplex(complexObj)
{
    sf_raiseOnValueChange();
}

function sf_raiseOnValueChangeNumber(senderRadNumeric)
{
    var numberElement = senderRadNumeric.get_element();
    var ajaxPanel = numberElement.getAttribute('ajaxId');
    var ctrlid = numberElement.getAttribute('controlId');
    var oldVal = numberElement.getAttribute('oldVal');
    sf_raiseOnValueChange(oldVal, senderRadNumeric.get_value(), ajaxPanel, ctrlid);
}

function sf_UpdateNumberMaxMinValue(senderNumber, argsNumber)
{
    // Get all the necessary values.
    //Check If the control is mandatory, if not
    // Assumption is that these values are culture neutral.
    // type-cast value as float before comparison
    // IF Controls value is less than MinValue,
    // Set minvalue as the controls value.
    // else if CurrentValue greater than maxValue,
    // Set Controls value as max value

    var minValue = senderNumber.get_minValue();
    var maxValue = senderNumber.get_maxValue();
    var userEnteredValue = argsNumber.NewValue;

    if (userEnteredValue < minValue)
    {
        senderNumber.set_value(minValue);
    }
    else if (userEnteredValue > maxValue)
    {
        senderNumber.set_value(maxValue);
    }
}



function sf_validateDateOnValueChange(sender)
{
    var radDate = window[sender.ClientID];
    var controlId = radDate.TextBoxElement.getAttribute("errspan");
    var inputStyle = radDate.TextBoxElement.getAttribute("inputSpanStyle");
    if (radDate.TextBoxElement.getAttribute("mandatory") == "True")
    {
        if (radDate.GetValue() == "")
        {
            document.getElementById(controlId).className = inputStyle + "error";
            document.getElementById(controlId).title = mandatoryMessage;
        }
        else
        {
            document.getElementById(controlId).className = "sf-spanmandatory";
            document.getElementById(controlId).title = "Mandatory";
        }
    }
    else //if (radDate.TextBoxElement.getAttribute("mandatory") == "False")
    {
        document.getElementById(controlId).className = "sf-span";
        document.getElementById(controlId).title = "";
    }
}

function sf_validateNumberValueOnChange(sender, controlId, inputStyle, minMaxErrMsg)
{
    var senderValue = sender.value;
    var enableAutoUpdate = sender.getAttribute("enableAutoUpdate");

    if (sender.getAttribute("mandatory") == "True")
    {
        if (senderValue == "")
        {
            document.getElementById(controlId).className = inputStyle + "error";
            document.getElementById(controlId).title = mandatoryMessage;
            return;
        }
        else
        {
            document.getElementById(controlId).className = "sf-spanmandatory";
            document.getElementById(controlId).title = "Mandatory";
        }
    }

    if (enableAutoUpdate === "false")
    {
        var value = parseFloat(sender.value);
        var minValue = parseFloat(sender.getAttribute("minvalue"));
        var maxValue = parseFloat(sender.getAttribute("maxvalue"));

        if (senderValue && !(value >= minValue && value <= maxValue))
        {
            document.getElementById(controlId).className = inputStyle + "error";
            document.getElementById(controlId).title = minMaxErrMsg;
        }
        else
        {
            document.getElementById(controlId).className = inputStyle;
            document.getElementById(controlId).title = "";
        }
    }
}

function sf_validateOnValueChange(sender, controlId, inputStyle)
{
    var senderValue = sender.value;

    try
    {
        if (sender.getAttribute("EmptyValue") == senderValue)
        {
            senderValue = "";
        }
    }
    catch (Err) { }

    if (sender.getAttribute("mandatory") == "True")
    {
        if (senderValue == "")
        {
            document.getElementById(controlId).className = inputStyle + "error";
            document.getElementById(controlId).title = mandatoryMessage;
        }
        else
        {
            document.getElementById(controlId).className = "sf-spanmandatory";
            document.getElementById(controlId).title = "Mandatory";
        }
    }
    else //if (sender.getAttribute("mandatory") == "False")
    {
        document.getElementById(controlId).className = inputStyle;
        document.getElementById(controlId).title = "";
    }
}

function sf_validateMaskSetValue(sender, coreValue)
{
    sender.TextBoxElement.value = coreValue;
}

function sf_validateMaskOnValueChange(sender, controlId, inputStyle)
{
    var radmask = window[sender.id.replace("_text", "")];
    var sValue = new String(radmask.GetValueWithPromptAndLiterals());
    var hiddenValueId = _skidmap[sender.getAttribute("controlUniqueid") + "h"];
    document.getElementById(hiddenValueId).value = sValue;
    if (sender.getAttribute("mandatory") == "True")
    {
        if (radmask.value == "")
        {
            document.getElementById(controlId).className = inputStyle + "error";
            document.getElementById(controlId).title = mandatoryMessage;
        }
        else
        {
            document.getElementById(controlId).className = "sf-spanmandatory";
            document.getElementById(controlId).title = "Mandatory";
        }
    }
    else
    {
        document.getElementById(controlId).className = "sf-span";
        document.getElementById(controlId).title = "";
    }
}

function sf_validateDurationOnValueChange(sender, controlId, inputStyle)
{
    var radmask = window[sender.id.replace("_text", "")];
    var sValue = new String(radmask.GetValueWithPromptAndLiteralsOpenPopup());
    if (sender.getAttribute("mandatory") == "True")
    {
        if (radmask.value <= "000000000")
        {
            document.getElementById(controlId).className = inputStyle + "error";
            document.getElementById(controlId).title = mandatoryMessage;
        }
        else
        {
            document.getElementById(controlId).className = "sf-spanmandatory";
            document.getElementById(controlId).title = "Mandatory";
        }
    }
    else
    {
        document.getElementById(controlId).className = "sf-span";
        document.getElementById(controlId).title = "";
    }
}

var sk_focusedElementId = null;
function sf_onFocus(objectWhichGotFocus)
{
    try
    {
        if (objectWhichGotFocus != null && !CheckIfElementIsDiv(objectWhichGotFocus))
        {
            if (sk_focusedElementId != null)
            {
                sf_LooseFocus(sk_focusedElementId);
            }
            sk_focusedElementId = objectWhichGotFocus.id;
            objectWhichGotFocus.select();
        }
    }
    catch (err)
    {
    }
}

//This method checks if the dom element passed is DIV
function CheckIfElementIsDiv(obj)
{
    var isDiv = false;
    try
    {
        var nodeName = obj.nodeName.toLowerCase();
        isDiv = nodeName == "div" ? true : false;
        //console.log(nodeName + ": " + obj.id + ": " + isDiv);
        return isDiv;
    }
    catch (err)
    {
        return isDiv;
    }
}

function sf_setLastFocus()
{
    try
    {

        if (sk_focusedElementId != null && sk_focusedElementId != "" && sk_focusedElementId != 'undefined')
        {
            var el = document.getElementById(sk_focusedElementId);
            if (el != null)
            {
                el.focus();
            }
        }
    } catch (err) { }
}

var sf_LastFocus = null;
function sf_gotFocus(sender)
{
    if (sf_LastFocus != null && sf_LastFocus.id != sender.id)
    {
        sf_LooseFocus(sf_LastFocus);
    }
    sf_LastFocus = sender;
}

function sf_LooseFocus(senderId)
{

    //sf_MarkError(senderId,true,"Value must be specified");

    //document.getElementById(errSpan).className="sf-spanerror";
}

function sf_MarkError(senderId, iserror, errorMessage)
{
    try
    {
        if (!senderId) return;
        var el = document.getElementById(senderId);
        if (!el) return;
        var errSpan = el.getAttribute("errspan");
        var isMandatory = false;

        try
        {
            isMandatory = (el.getAttribute("mandatory") == "True") ? true : false;
        }
        catch (Err) { }

        if (errSpan == null)
        {
            try
            {
                actid = senderId.split('~');
                if (actid[1] != null)
                {
                    actid[1] = actid[1].replace('_text', 'sp');
                    errSpan = actid[1];
                }
            }
            catch (err)
            {
            }
        }
        var errSpanEl = document.getElementById(errSpan);

        if (iserror)
        {
            errSpanEl.className = "sf-spanerror";
            errSpanEl.title = errorMessage;
        }
        else
        {
            if (isMandatory)
            {
                errSpanEl.className = "sf-spanmandatory";
                errSpanEl.title = "Mandatory";
            }
            else
            {
                errSpanEl.className = "sf-span";
                errSpanEl.title = "";
            }
        }
    }
    catch (err)
    { }
}

sf_setupKeyboardEvents();

function sf_setupKeyboardEvents()
{
    if (window.addEventListener)
    {
        window.addEventListener('keydown', sf_keydown, false);
    }
    else
    {
        window.attachEvent('onkeydown', sf_keydown);
        document.attachEvent('onkeydown', sf_keydown);
    }

}

function sf_keydown(evt)
{
    if (!evt) evt = window.event;
    var textareabox;
    if (evt.srcElement != null && evt.srcElement.id != "")
    {
        textareabox = document.getElementById(evt.srcElement.id);
        if (textareabox != null && textareabox.type == "textarea")
        {
            if (evt.keyCode == 13)
            {

                return true;
            }
        }
    }

    if (evt.shiftKey && evt.keyCode != 16)
    {
        //Shift + insert 45
        //Shift + Delete 46
        if (evt.keyCode == 45)
        {
            sf_AddNewRow();
            evt.returnValue = false;
            return false;
        }
        if (evt.keyCode == 46)
        {
            sf_DeleteRow();
            evt.returnValue = false;
            return false;
        }
        //alert(evt.keyCode);
    }
}

function sf_AddNewRow()
{
    var addButtonId = "lbl" + _skselectedformclient;
    var id = _skidmap[addButtonId];
    if (!id) { return; }
    var el = document.getElementById(id);
    if (!el) { return; }
    el.click(); //Does not work in firefox
}


function sf_DeleteRow()
{
    var addButtonId = "lbld" + _skselectedformclient;
    var id = _skidmap[addButtonId];
    if (!id) { return; }
    var el = document.getElementById(id);
    if (!el) { return; }
    el.click(); //Does not work in firefox
}

function AddEventHandler(elementObject, eventName, functionObject)
{
    if (document.addEventListener)
        elementObject.addEventListener(eventName, functionObject, false);
    else
        if (document.attachEvent)
            elementObject.attachEvent("on" + eventName, functionObject);
}


function OpenUserLookup(controlId, uniqueid, CacheKey, ListName, userLookUpId, ajaxid)
{
    var ajId = _skidmap[ajaxid];
    var serverVariables = "UpdateUserExp@$@" + controlId + "@$@" + uniqueid + "@$@" + CacheKey + "@$@" + ListName + "@$@" + userLookUpId + "@$@" + ajaxid;
    window[ajId].AjaxRequest(serverVariables);
    //For User Lookup,we need to pass the Existing Information so that the users are shown in the RHS of UserLookup
}

function OpenLookupInput(ajaxid, controlId, LookupId)
{
    var ajxId = _skidmap[ajaxid];
    var serverVar = "CallLookUpInput@&@" + ajxId + "@&@" + controlId + "@&@" + LookupId;
    window[ajxId].AjaxRequest(serverVar);
}

function fillUsers(radwindow, callBackInformation)
{
    var Info = new Array();
    //Info=callBackInformation.split("$");
    var info1 = callBackInformation.substring(0, callBackInformation.indexOf('$'));
    var info2 = callBackInformation.substring(callBackInformation.indexOf('$') + 1, callBackInformation.lastIndexOf('$'));
    var info3 = callBackInformation.substring(callBackInformation.lastIndexOf('$') + 1);
    Info[0] = info1;
    Info[1] = info2;
    Info[2] = info3;

    var UserLookupTextBox = document.getElementById(_skidmap[Info[0] + "_usertext"]);
    var userNameWithEmail = Info[1];
    //userNameWithEmail = userNameWithEmail.replace("_","'");
    UserLookupTextBox.textContent = userNameWithEmail;
    UserLookupTextBox.value = userNameWithEmail;
    //UserLookupTextBox.innerText=Info[1];
    //UserLookupTextBox.value=Info[1];
    var HiddenFieldInfo = _skidmap[Info[0] + "_user_hiddeninformation"];
    var hiddenField = document.getElementById(HiddenFieldInfo);

    hiddenField.value = Info[0] + "$" + userNameWithEmail + "$" + Info[2];
    if (UserLookupTextBox.getAttribute("onchange") != null)
    {
        sf_raiseOnValueChange();
    }
    //window.ClientClose();

}

function fillRoles(radwindow, callBackInformation)
{
    var Info = new Array();
    Info = callBackInformation.split("$");
    var UserLookupTextBox = document.getElementById(_skidmap[Info[0] + "_roletext"]);
    UserLookupTextBox.textContent = Info[1];
    UserLookupTextBox.value = Info[1];
    var HiddenFieldInfo = _skidmap[Info[0] + "_role_hiddeninformation"];
    var hiddenField = document.getElementById(HiddenFieldInfo);
    hiddenField.value = callBackInformation;
    if (UserLookupTextBox.getAttribute("onchange") != null)
    {
        sf_raiseOnValueChange();
    }
    //window.ClientClose();
}

function LoadFormulaDiv(item)
{
    var imgArray = document.getElementsByTagName('img');
    var img;
    for (var i = 0; i < imgArray.length; i++)
    {
        var imgsrc = imgArray[i].src;
        var fileNameIndex = imgsrc.lastIndexOf("/") + 1;
        var filename = imgsrc.substr(fileNameIndex);
        if (imgsrc.indexOf('/EnterpriseConsole/BPMUITemplates/Default/SkeltaForms/images/rolelookupcontrolimage.png') != -1 || filename === "rolelookupcontrolimage.png")
        {
            img = imgArray[i];
            break;
        }
    }
    if (item.Value == "TRUE")
    {
        document.getElementById("calculatedproperty_formulatext_" + item.ComboBox.ID).style.visibility = "visible";
        img.style.visibility = "visible";
    }
    else if (item.Value == "FALSE")
    {
        document.getElementById("calculatedproperty_formulatext_" + item.ComboBox.ID).style.visibility = "hidden";
        img.style.visibility = "hidden";
    }
}

function OpenSelectListTableControl(container, controlId, mappedId, CacheKey, ListName)
{
    var tableName = document.getElementById(_skidmap[controlId]).control.get_value();
    var u = _TemplateDirectorySkeltaForms + "ListTableSelect.aspx?sfdcontainer=" + escape(container) + "&controlid=" + escape(controlId) + "&mappedparentid=" + escape(mappedId) + "&cachekey=" + CacheKey + "&ListName=" + ListName + "&TableName=" + tableName;
    var oWindow1;
    oWindow1 = window.open(u, 'controlopenlist', 'left=100,top=100,height=' + parseInt(document.body.clientHeight, 10) + ',width=' + parseInt(document.body.clientWidth, 10) + ',resizable=no');

    return oWindow1;
}

function SetSelectListTableValue(controlId, tableName, oldTableName)
{
    document.getElementById(_skidmap[controlId]).control.set_value(tableName);
    ClientClose();
}

function LoadTargetDate(uniqueId)
{
    var btn = document.getElementById(uniqueId + "_btn");
    if (btn.value == "Show Date")
    {
        document.getElementById(uniqueId + "_calDiv").style.display = "";
        document.getElementById(uniqueId + "_calDiv").style.visibility = "visible";
        btn.value = "Hide Date";
    }
    else
    {
        document.getElementById(uniqueId + "_calDiv").style.display = "none";
        document.getElementById(uniqueId + "_calDiv").style.visibility = "hidden";
        btn.value = "Show Date";
    }
}

function OnNumberError(sender)
{
    var radNumberElement = sender.get_element();
    var controlId = radNumberElement.getAttribute("errspan");
    var inputStyle = radNumberElement.getAttribute("inputSpanStyle");

    if (sender.isEmpty() == true || (parseFloat(sender.value) >= parseFloat(radNumberElement.getAttribute("minvalue")) && parseFloat(sender.value) <= parseFloat(radNumberElement.getAttribute("minvalue"))))
    {
        document.getElementById(controlId).className = inputStyle;
    }
    else
    {
        document.getElementById(controlId).className = inputStyle + "error";
        document.getElementById(controlId).title = skFormsMessages.NumberErrOutOfRange.replace("<@minvalue@>", sender.MinValue).replace("<@maxvalue@>", sender.MaxValue);
    }
}

function OnValueChangedAndRaise(sender)
{

    OnValueChanged(sender);
    sf_raiseOnValueChange();
}

function OnValueChanged(sender)
{
    var str;
    str = new String(sender.ClientID);
    if (str.search('mask') != -1)
    {
        str = str.replace('mask', 'datetime');
        var strMask = new String(sender.ClientID + "_text");
        var datepicker = window[str];
        var sdate = CalDate(sender.GetValueWithPromptAndLiterals());
        document.getElementById(strMask).getAttribute("ValueChange").value = "Mask";
        datepicker.DisableEvents();
        datepicker.SetDate(sdate);
        datepicker.EnableEvents();
    }
    else if (str.search('datetime') != -1)
    {
        var str;
        str = new String(sender.ClientID);
        str = str.replace('datetime', 'mask');
        var duration = window[str];
        duration.DisableEvents();
        if (document.getElementById(str + "_text").getAttribute("ValueChange") != "Mask")
        {
            duration.SetValue(dateDiff(sender.GetDate()));
        }
        duration.EnableEvents();
        document.getElementById(str + "_text").getAttribute("ValueChange").value = "Both";
    }
}

function CalDate(sValue)
{
    var sduration = new String(sValue);
    var sArrDuration1 = sduration.split(".");
    var sArrDuration2 = sArrDuration1[1].split(":");
    var days = sArrDuration1[0];
    var hrs = sArrDuration2[0];
    var mins = sArrDuration2[1];
    var secs = sArrDuration2[2];

    var todaydate = new Date();
    var date1 = new Date(todaydate.getTime() + days * 24 * 60 * 60 * 1000 + hrs * 60 * 60 * 1000 + mins * 60 * 1000 + secs * 1000);
    return date1;
}

function dateDiff(selectedDate)
{
    date1 = new Date();
    date2 = new Date();
    diff = new Date();

    date1temp = new Date(selectedDate);
    date1.setTime(date1temp.getTime());

    date2temp = new Date();
    date2.setTime(date2temp.getTime());

    // sets difference date to difference of first date and second date

    if (date1.getTime() - date2.getTime() < 0) return "000.00:00:00";

    diff.setTime(date1.getTime() - date2.getTime());

    timediff = diff.getTime();

    days = Math.floor(timediff / (1000 * 60 * 60 * 24));
    timediff -= days * (1000 * 60 * 60 * 24);

    hours = Math.floor(timediff / (1000 * 60 * 60));
    timediff -= hours * (1000 * 60 * 60);

    mins = Math.floor(timediff / (1000 * 60));
    timediff -= mins * (1000 * 60);

    secs = Math.floor(timediff / 1000);
    timediff -= secs * 1000;

    var sDays = new String(days);
    var sHrs = new String(hours);
    var sMins = new String(mins);
    var sSecs = new String(secs);

    timespan = new String();

    timespan = sDays;

    if (timespan.length < 2)
        timespan = "0" + timespan;
    if (timespan.length < 3)
        timespan = "0" + timespan;
    else if (timespan.length > 3)
        return "000.00:00:00";
    timespan = timespan + ".";

    if (sHrs.length < 2)
        timespan += "0" + sHrs;
    else
        timespan += sHrs;
    timespan = timespan + ":";

    if (sMins.length < 2)
        timespan += "0" + sMins;
    else
        timespan += sMins;
    timespan = timespan + ":";

    if (sSecs.length < 2)
        timespan += "0" + sSecs;
    else
        timespan += sSecs;

    return timespan;
}

function DisableContextMenu(gridId, rowType, rowEl, rowMenu)
{
    if (rowType != "Record") return true;
    if (rowType == "Record")
    {
        // hide the default context menu
        for (i = 0; i < 16; i++)
        {
            rowMenu.items[i].visible = false;
        }
    }
}

//function RefreshMainGrid() {
//    try {
//        var win = window.opener.GetRadWindow();
//        if (win != null) {
//            // For Edit Form and For New Form Mode        
//            win.BrowserWindow.window.document.getElementById('mainframe').contentWindow.document.getElementById("gridframe").contentWindow.RefreshGrid();
//        }
//    }
//    catch (err) {
//        // For Item Design
//        window.opener.RefreshGrid();
//    }
//}

function RefreshParent()
{
    try
    {
        if (typeof (window.opener) == 'undefined')
        {

            window.top.parent.location.href = window.top.parent.location.href;
            window.setTimeout('window.close();', 1000);
        }
        else
        {
            window.opener.window.closeWin();
            //window.opener.location.href = window.opener.location.href;
            var oWnd = GetRadWindow();
            oWnd.close();
            //window.setTimeout('oWnd.close();', 1000); 
            // window.opener.top.location.href =  window.opener.top.location.href;

        }
    }
    catch (err)
    {
        try
        {
            window.close();
        }
        catch (err) { }
    }
}

function getCalendarHeight(dpID)
{
    var datePicker = window[dpID.replace("_dateInput_text", "")];
    var popupElement = datePicker.GetPopupContainer();
    var dimensions = datePicker.GetElementDimensions(popupElement);
    return dimensions.height;
}

function getTimeViewHeight(dpID)
{
    var timePicker = window[dpID.replace("_dateInput_text", "")];
    var popupElement = timePicker.GetTimePopupContainer();
    var dimensions = timePicker.GetElementDimensions(popupElement);
    return dimensions.height - 10;
}

function getElementPosition(dpID)
{
    var datePicker = window[dpID.replace("_dateInput_text", "")];
    var textBox = datePicker.GetTextBox();
    var position = datePicker.GetElementPosition(textBox);
    return position;
}

function PopupAboveTime(dpID)
{
    var sdpID = new String(dpID.replace("_dateInput_text", ""));
    var timePicker = window[sdpID];
    var popupElementHeight = getTimeViewHeight(sdpID);
    var position = getElementPosition(sdpID);

    if (!timePicker.IsTimePopupVisible())
    {
        timePicker.ShowTimePopup(position.x, position.y - popupElementHeight);      
    }
    else
    {
        timePicker.HideTimePopup();
    }
}

function PopupBelowTime(dpID)
{
    var sdpID = new String(dpID.replace("_dateInput_text", ""));
    var timePicker = window[sdpID];
    var position = getElementPosition(sdpID);

    if (!timePicker.IsTimePopupVisible())
    {
        timePicker.ShowTimePopup(position.x, position.y + 20);    
    }
    else
    {
        timePicker.HideTimePopup();
    }
}

function sfDatePopUp(dateItem)
{
    var skID = "";
    try
    {
        skID = _skidmap[dateItem].replace("_dateInput_text", "");
    }
    catch (err)
    {
        skID = dateItem;
    }
    var dpWrapper = document.getElementById(skID).parentNode;
    var dpOffsetTop = getElementPosition(skID).y + dpWrapper.offsetHeight;
    //// Issue: in the Mobile, TopMost and BottomMost datetime input control's 
    //// date picker was opening improperly or colliding with the header or footer
    //// Cause: document.body.offsetHeight returns 0 in Chrome and other browsers
    //// Solution: Window.innerHeight gives proper value
    if (IsMobile())
    {
        var pageHeight = window.innerHeight;
    }
    else
    {
        var pageHeight = document.body.offsetHeight;
    }

    var calHeight = 150;//getCalendarHeight(skID);
    if ((dpOffsetTop + calHeight) > pageHeight)
    {
        PopupAbove(skID);
    }
    else
    {
        PopupBelow(skID);
    }

}
function sfTimePopUp(timeItem)
{
    //document.getElementById(_skidmap[timeItem]).GetTimePopupContainer().className ="sf-timeview";

    var skId = "";
    try
    {
        skId = _skidmap[timeItem].replace("_dateInput_text", "");
    }
    catch (err)
    {
        skId = timeItem;
    }
    var timePicker = window[skId];
    timePicker.GetTimePopupContainer().className = "sf-timeview"
    var dpWrapper = document.getElementById(skId).parentNode;
    var dpOffsetTop = getElementPosition(skId).y + dpWrapper.offsetHeight;

    //// Issue: in the Mobile, TopMost and BottomMost datetime input control's 
    //// date picker was opening improperly or colliding with the header or footer
    //// Cause: document.body.offsetHeight returns 0 in Chrome and other browsers
    //// Solution: Window.innerHeight gives proper value
    if (IsMobile())
    {
        var pageHeight = window.innerHeight;
    }
    else
    {
        var pageHeight = document.body.offsetHeight;
    }

    var calHeight = 200;

    if ((dpOffsetTop + calHeight) > pageHeight)
    {
        PopupAboveTime(skId);
    }
    else
    {
        PopupBelowTime(skId);
    }
}

function GetRadWindow()
{
    var oWindow = null;
    if (window.radWindow) oWindow = window.radWindow;
    else if (window.frameElement)
    {
        if (window.frameElement.radWindow)
            oWindow = window.frameElement.radWindow;
        else
            window.location.reload();
    }
    return oWindow;
}

function isIE()
{
    return (navigator.userAgent.match(/MSIE|Trident/i) != null) ? true : false;
}

//OnClientItemsRequesting event is not fired in IE when rendering in standards mode to handle that doing the same operation using OnClientKeyPressing event
function ComboBoxKeyPress(sender, ajaxId, parameterNames, parameterIds, controlType)
{
    if (isIE() === true)
    {
        //window.console.log('ComboBoxKeyPress');
        AddItems(sender, ajaxId, parameterNames, parameterIds, controlType);
        //setting TextHidden and ValueHidden to "" and SelectedIndex to -1 was explicitly done to handle clearing issue - on clearing all the characters still it was retaining the old value
        sender.TextHidden.value = "";
        sender.ValueHidden.value = "";
        sender.SelectedIndex = -1;
        //this will fire onitem requested server side event
        sender.RequestItems("", false);
    }
}

function AddItems(sender, ajaxId, parameterNames, parameterIds, controlType)
{
    var values = parameterIds.split("~");
    var controlTypes = controlType.split("@#@");
    var cttrlValue = "";
    for (var i = 0; i < values.length; i++)
    {
        if (values[i] != "")
        {
            var ctrlId = "";
            var tempValue = "";
            switch (controlTypes[i])
            {
                case "userlookup":
                    {
                        ctrlId = _skidmap[values[i] + "_user_hiddeninformation"];
                        tempValue = typeof (document.getElementById(ctrlId).value) == "undefined" ? "" : document.getElementById(ctrlId).value;
                        tempValue = tempValue.split("$")[2];
                        break;
                    }
                case "booleaninput":
                    {
                        ctrlId = _skidmap[values[i]];
                        ctrlId1 = document.getElementById(ctrlId + "_0");
                        ctrlId2 = document.getElementById(ctrlId + "_1");
                        if (ctrlId1.checked)
                        {
                            tempValue = "1";
                        }
                        if (ctrlId2.checked)
                        {
                            tempValue = "0";
                        }
                        break;
                    }
                case "rolelookup":
                    {

                        ctrlId = _skidmap[values[i] + "_role_hiddeninformation"];
                        tempValue = typeof (document.getElementById(ctrlId).value) == "undefined" ? "" : document.getElementById(ctrlId).value;
                        tempValue = tempValue.split("$")[2];
                        break;
                    }
                case "radiobuttongroup":
                    {
                        ctrlId = _skidmap[values[i]];
                        var radioControl = window[ctrlId];
                        if (radioControl != null)
                        {
                            var itemCount = radioControl.childNodes[0].childNodes[0].childNodes.length;
                            for (var i = 0; i < itemCount; i++)
                            {
                                var item = document.getElementById(ctrlId + "_" + i);
                                if (item.checked)
                                {
                                    tempValue = item.value;
                                    break;
                                }

                            }
                        }
                        break;
                    }
                case "checklist":
                    {
                        ctrlId = _skidmap[values[i]];
                        var checkListontrol = window[ctrlId];
                        if (checkListontrol != null)
                        {
                            var itemCount = checkListontrol.childNodes[0].childNodes[0].childNodes.length;
                            var val = '';
                            for (var i = 0; i < itemCount; i++)
                            {
                                var item = document.getElementById(ctrlId + "_" + i);
                                if (item.checked)
                                {
                                    val += item.offsetParent.innerText + ';';
                                    break;
                                }

                            }
                            if (val != "")
                            {
                                tempValue = val.substring(0, val.length - 1);// remove last ;
                                tempValue += "@#@checklist@#@";
                            }
                        }
                        break;
                    }
                case "grid":
                    {
                        values[i] = values[i].replace("datagrid_", "");
                        ctrlId = _skidmap[values[i]];
                        ctrlId1 = document.getElementById(ctrlId)
                        tempValue = ctrlId1.value;
                        break;
                    }
                default:
                    ctrlId = _skidmap[values[i]];
                    if (typeof (document.getElementById(ctrlId).value) == "undefined")
                    {
                        try
                        {
                            tempValue = window[ctrlId].GetValue();
                        }
                        catch (err)
                        { }
                    }
                    else
                    {
                        tempValue = document.getElementById(ctrlId).value;
                    }

                    break;
            }


            cttrlValue += tempValue + '~';
        }
    }
    // BELOW LINE IS COMMENTED SINCE NumberOfItems PROPERTY FOR SHOW MORE DATA WAS UNABLE TO LOAD MORE DATA
    //sender.ClearItems();
    sender.ClientDataString = cttrlValue;
    //sender.RequestItems("", false);
}

var isDropDownAbove = false;
var isLookupDropDownOpenStatusHiddenId = "";
var isLookupDropDownOpen = false;
var scrollBeforeDropdownClose = false;

function LookUpDropDownOpen(combo, LookupInputHeight)
{
    //This function will be called whenever the lookup is clicked
    var itemid = combo.ID;
    var chk = navigator.userAgent;
    if (chk.indexOf("Firefox") != -1)
    {
        //This is a fix where in if the lookup dropdown header is having more columns,
        //then it was coming out of the div since scroll bar was disabled. 
        //A logic has been designed to fit the whole dropdown window to adjust to the lookup input's width
        var itemwebid = _skidmap[itemid];
        var length;
        var dropdownplaceholder = itemwebid + "_DropDownPlaceholder";
        var item = document.getElementById(dropdownplaceholder);
        if (item != null)
        {
            var lookupinput = document.getElementById(itemwebid + "_Input");
            if (lookupinput != null)
            {
                length = lookupinput.offsetWidth;
            }
            item.style.width = length;
            item.style.overflow = "auto";
        }

        var showmoreresults = itemwebid + "_MoreResultsBox";
        var moreresults = document.getElementById(showmoreresults);
        if (moreresults != null)
        {
            moreresults.style.width = length;
            moreresults.style.overflow = "auto";
        }

        var dropdownid = itemwebid + "_DropDown";
        var dropdown = document.getElementById(dropdownid);
        if (dropdown != null)
        {
            dropdown.style.width = length;
            dropdown.style.overflow = "auto";
        }
    }

    //This logic has been implemented to hide the dropdown when user open's the lookup dropdown 
    //and scrolls the page.
    var hiddenId = combo.DomElement.id + "_hidden_dd_Opened";
    var dropdownDiv = combo.DropDownPlaceholder;
    var field = document.getElementById(hiddenId);
    if (field == null)
    {
        field = document.createElement("input");
        field.setAttribute("id", hiddenId);
        field.setAttribute("type", "hidden");
        field.setAttribute("value", dropdownDiv.id);
        document.body.appendChild(field);
    }
    else
    {
        field.value = dropdownDiv.id;
    }

    //This function call is necessary to decide whether lookup dropdown should come below or above the lookup input.
    if (LookupInputHeight == 0)
        alignDropDownHeight(combo);

    isLookupDropDownOpenStatusHiddenId = hiddenId;
    isLookupDropDownOpen = true;

    //    if (enableAutoComplete == "True") {
    //        if (combo.SelectedItem != null) {
    //            combo.RequestItems(combo.SelectedItem.Text, false);
    //        }
    //        else {
    //            combo.RequestItems("", false);
    //        }
    //    }
    //    else {
    combo.RequestItems("", false);
    //    }
}

function deactivateLookupDropDown()
{
    //This function will hide the lookup dropdown div if it is open.
    var hiddenDropDownstatus = document.getElementById(isLookupDropDownOpenStatusHiddenId);
    if (hiddenDropDownstatus != null)
    {
        if (scrollBeforeDropdownClose == true)
        {
            var ids = hiddenDropDownstatus.value;
            var dropdownId, overlayId, senderId;
            var dropDownDiv, overlayDiv;
            if (ids.indexOf('!!!') > 0)
            {
                dropdownId = ids.substring(0, ids.indexOf('!!!'));
                ids = ids.replace(dropdownId + "!!!", "");
                overlayId = ids;
                senderId = ids.replace("_Overlay", "");
                dropDownDiv = document.getElementById(dropdownId);
                overlayDiv = document.getElementById(overlayId);
            }
            else
            {
                dropdownId = ids;
                senderId = ids.replace("_DropDownPlaceholder", "");
                dropDownDiv = document.getElementById(dropdownId);
            }

            var sender = window[senderId];
            if (sender != null)
            {
                var textbox = document.getElementById(senderId + "_Input");
                if (textbox != null)
                    textbox.blur();
            }
            if (dropDownDiv != null)
            {
                dropDownDiv.style.display = "none";
                if (overlayDiv != null)
                    overlayDiv.style.display = "none";
                isLookupDropDownOpen = false;
            }
        }
    }
    scrollBeforeDropdownClose = false;
}

/* ---check if user agent is mobile 
currently for this release checking only for iphone and ipad... in future needs to be checked for more mobile user agents like - andriod or windows..etc */
function IsMobile()
{
    if ((navigator.userAgent.indexOf('iPhone') != -1) || (navigator.userAgent.indexOf('iPad') != -1))
    {
        return true;
    }
    else
    {
        return false;
    }
}


function alignDropDownHeight(sender)
{
    //This function will decide whether to load lookup dropdown below or above the lookup input.
    var dropdownDiv = sender.DropDownPlaceholder;
    var windowHeight = document.body.clientHeight;
    if (IsMobile())
    {
        windowHeight = window.innerHeight;
    }
    var dropdownHeight = dropdownDiv.clientHeight;
    var dropdownTop = dropdownDiv.offsetTop;

    var hiddenId = sender.DomElement.id + "_hidden_dd_status";
    var field = document.getElementById(hiddenId);
    if (field == null)
    {
        field = document.createElement("input");
        field.setAttribute("id", hiddenId);
        field.setAttribute("type", "hidden");
        field.setAttribute("value", "true");
        document.body.appendChild(field);
    }
    var input = document.getElementById(sender.DomElement.id + "_Input");
    var positionOfLookupInput = findPosition(input);
    var bodyDiv = document.getElementById(sender.DomElement.id.substring(0, 1) + "bodydiv");
    var scrollPosition;
    if (bodyDiv != null)
        scrollPosition = document.getElementById(sender.DomElement.id.substring(0, 1) + "bodydiv").scrollTop;
    else
        scrollPosition = 0;
    var elementTop = positionOfLookupInput[1] - scrollPosition;
    var heightAvailable = windowHeight - elementTop + input.clientHeight;

    if (heightAvailable < dropdownHeight)
    {
        isDropDownAbove = true;
        var difference = elementTop - dropdownHeight;
        if (difference < 0)
            difference = 0;
        dropdownDiv.style.top = difference + "px";
        if (sender.Overlay != null)
        {
            sender.Overlay.style.top = difference + "px";
            sender.Overlay.style.height = "2px";
        }
        var hiddenInfo = document.getElementById(isLookupDropDownOpenStatusHiddenId);
        if (sender.Overlay != null)
            if (hiddenInfo != null && hiddenInfo.value.indexOf('!!!') == -1)
                hiddenInfo.value += "!!!" + sender.Overlay.id;
    }
    else
    {
        dropdownDiv.style.top = elementTop + input.clientHeight;
        if (sender.Overlay != null)
        {
            sender.Overlay.style.top = elementTop + input.clientHeight;
            sender.Overlay.style.height = "2px";
        }
    }
}

/* --Used to initialize the touchstart and touchmove events for the divs where scrolling is not happening */
function InitializeIScrollTouchEvents(divId)
{
    if (IsMobile())
    {
        var X = 0,
        Y = 0,
        cont = parent.document.getElementById(divId);

        document.body.addEventListener('touchstart',
        function (event)
        {
            //		        if (event.target.id === divId)
            //		        {
            //		            event.preventDefault();
            parent.window.scrollTo(0, 0);
            X = event.targetTouches[0].pageX;
            Y = event.targetTouches[0].pageY;
            //		            event.stopPropagation();
            //		        }
        });

        document.body.addEventListener('touchmove',
        function (event)
        {
            //		        if (event.target.id === divId)
            //		        {
            event.preventDefault();
            // --- Get current position
            var newX = event.targetTouches[0].pageX;
            var newY = event.targetTouches[0].pageY;
            cont.scrollLeft -= (newX - X);
            cont.scrollTop -= (newY - Y);
            X = newX;
            Y = newY;
            //		            //event.stopPropagation();
            //		        }
        });
    }
}

function findPosition(obj)
{
    // this function smartly identify the position of the element with respect to the parent elment.
    // Please note that if the user want to get the position with respect to height or width, 
    // he must get the scroll position of the body div and subtract it.
    try
    {
        var posX = obj.offsetLeft; var posY = obj.offsetTop;
        while (obj.offsetParent)
        {
            posX = posX + obj.offsetParent.offsetLeft;
            posY = posY + obj.offsetParent.offsetTop;
            if (obj == document.getElementsByTagName('body')[0]) { break }
            else { obj = obj.offsetParent; }
        }
        return [posX, posY]
    }
    catch (err)
    {
        return null;
    }
}

function SetDropValues(sender)
{
    var sUniqueId = sUniqueId = sender.ComboBox.ClientID;
    document.getElementById(sUniqueId).value = sender.Value;
}

function AlertMsg(sender)
{
    alert("Lookup data source is empty. Set the data source");
    return false;
}

function AlertMsgItemNotFound(sender, errorMsg)
{
    alert(errorMsg);
    return false;
}

function ExecuteAction(responseurl, combo)
{
    window.open(_TemplateDirectorySkeltaForms + "../Repository/Site/DynamicListNewForm.aspx?" + responseurl, "NewListItem", "menubar=no,toolbar=no,status=no,directories=no");
}

function CloseInvokeFormWorkItemWindow()
{
    try
    {
        if (typeof (window.parent.opener) != "undefined")
        {
            window.parent.opener.window.RefreshGrid();//workitem -3355
            window.parent.close();
        }
        else
        {
            window.parent.top.RefreshGridwithoutclose();
        }
    }
    catch (err)
    {
        if (typeof (window.parent.opener) != "undefined")
        {
            window.parent.close();
        }
        else
        {
            window.parent.top.RefreshGridwithoutclose();
        }
    }
}

function DoNotCloseInvokeFormWorkItemWindow()
{

    try
    {
        if (typeof (window.parent.opener) != "undefined")
        {
            window.parent.opener.top.RefreshGridwithoutclose();
            //window.parent.close();
        }
        else
        {
            window.parent.top.RefreshGridwithoutclose();
        }

    }
    catch (err)
    {
        if (typeof (window.parent.opener) != "undefined")
        {
            //window.parent.close();
        }
        else
        {
            window.parent.top.RefreshGridwithoutclose();
        }
    }
}

function SetCurrentState()
{
    try
    {

        var _updatestatemap = new Array();
        for (var i = 0; i < _skstatemap.length; i++)
        {
            var particles = _skstatemap[i].split(',');
            //particles[0]---ID
            //particles[1]---ClientID
            //particles[2]---StateUpdatedString
            //particles[3]---Type of Control        
            try
            {
                GetCurrentState(particles, _updatestatemap);
            }
            catch (err)
            {
            }

        }
        _skstatemap = _updatestatemap;
    }
    catch (err)
    {
        //failed to build the state information
    }

}
//Dynamically generated function
function GetCurrentState(ctrlObjectRep, UpdateStateMap)
{//Values of the Controls are sent only for radio and checkboxes as it is not retained in partial postbacks
    //Source yet to be investigated
    switch (ctrlObjectRep[3])
    {
        case 'TextInput':
            state = GetStateForTextMaskEmailPhoneNumberInputs(ctrlObjectRep[1]);
            UpdateStateMap.push(ctrlObjectRep[0] + ',' + ctrlObjectRep[1] + ',' + state + ',' + ctrlObjectRep[3]);
            break;
        case 'DateInput':
            state = GetStateForDateAndTimeInput(ctrlObjectRep[1].replace('_dateInput', ''));
            UpdateStateMap.push(ctrlObjectRep[0] + ',' + ctrlObjectRep[1] + ',' + state + ',' + ctrlObjectRep[3]);
            break;
        case 'DateTimeInput':
            state = GetStateForDateAndTimeInput(ctrlObjectRep[1].replace('_dateInput', ''));
            UpdateStateMap.push(ctrlObjectRep[0] + ',' + ctrlObjectRep[1] + ',' + state + ',' + ctrlObjectRep[3]);
            break;
        case 'TimeInput':
            state = GetStateForDateAndTimeInput(ctrlObjectRep[1].replace('_dateInput', ''));
            UpdateStateMap.push(ctrlObjectRep[0] + ',' + ctrlObjectRep[1] + ',' + state + ',' + ctrlObjectRep[3]);
            break;
        case 'MaskedInput':
            state = GetStateForTextMaskEmailPhoneNumberInputs(ctrlObjectRep[1]);
            UpdateStateMap.push(ctrlObjectRep[0] + ',' + ctrlObjectRep[1] + ',' + state + ',' + ctrlObjectRep[3]);
            break;
        case 'Phone':
            state = GetStateForTextMaskEmailPhoneNumberInputs(ctrlObjectRep[1]);
            UpdateStateMap.push(ctrlObjectRep[0] + ',' + ctrlObjectRep[1] + ',' + state + ',' + ctrlObjectRep[3]);
            break;
        case 'Duration':
            state = GetStateForTextMaskEmailPhoneNumberInputs(ctrlObjectRep[1]);
            UpdateStateMap.push(ctrlObjectRep[0] + ',' + ctrlObjectRep[1] + ',' + state + ',' + ctrlObjectRep[3]);
            break;
        case 'Number':
            state = GetStateForTextMaskEmailPhoneNumberInputs(ctrlObjectRep[1]);
            UpdateStateMap.push(ctrlObjectRep[0] + ',' + ctrlObjectRep[1] + ',' + state + ',' + ctrlObjectRep[3]);
            break;
        case 'RadComboBox':
            //Load the default one for time being
            UpdateStateMap.push(ctrlObjectRep[0] + ',' + ctrlObjectRep[1] + ',' + ctrlObjectRep[2] + ',' + ctrlObjectRep[3]);
            break;
        case 'RadioButtonGroup':
            state = GetStateForRadioButtonList(ctrlObjectRep[1]);
            UpdateStateMap.push(ctrlObjectRep[0] + ',' + ctrlObjectRep[1] + ',' + state + ',' + ctrlObjectRep[3]);
            break;
        case 'CheckBoxListControl':
            state = GetStateForCheckList(ctrlObjectRep[1]);
            UpdateStateMap.push(ctrlObjectRep[0] + ',' + ctrlObjectRep[1] + ',' + state + ',' + ctrlObjectRep[3]);
            break;
        case 'RadioButtonList':
            state = GetStateForRadioButtonList(ctrlObjectRep[1]);
            UpdateStateMap.push(ctrlObjectRep[0] + ',' + ctrlObjectRep[1] + ',' + state + ',' + ctrlObjectRep[3]);
            break;
            //                case 'ListBox':
            //                    state = GetStateForListBox(ctrlObjectRep[1]);
            //                    UpdateStateMap.push(ctrlObjectRep[0] + ',' + ctrlObjectRep[1] + ',' + state + ',' + ctrlObjectRep[3]);
            //                    break;
        default:
            UpdateStateMap.push(ctrlObjectRep[0] + ',' + ctrlObjectRep[1] + ',' + ctrlObjectRep[2] + ',' + ctrlObjectRep[3]);
            break;

    }

    //UpdateStateMap.push(ctrlObjectRep.join(''));//Put the length of the string and the string.. this way we can parse it same way.. ask Soorjith on how to do it ..

}

//function GetStateForListBox(listboxid)
//{
//    //debugger;
//    if (window[listboxid] != null || document.getElementById(listboxid) != null)
//    {
//        var listboxObj = window[listboxid];
//        if (!listboxObj)
//            listboxObj = document.getElementById(listboxid);

//        var listboxStyle = listboxObj.style;
//        var listItems = listboxObj.options;
//        
//        var val = "";

//        for (var itemIndex = 0; itemIndex < listItems.length; itemIndex++)
//        {
//            if (listItems[itemIndex].selected == true)
//            {
//                val += listItems[itemIndex].value + ";";
//            }
//        }

//        if (val != "")
//        {
//            val = val.substring(0, val.length - 1); // remove last ;
//        }

//        return (listboxStyle.display + '$' + listboxStyle.visibility + '$' + listboxStyle.width + '$' + listboxStyle.height + '$' + listboxObj.readOnly + '$' + listboxObj.disabled + '$' + val); //+','+textObjStyle.disabled);//'' enable 'disabled' disabled
//    }
//}

function GetStateForRadioButtonList(rblid)
{
    try
    {
        if (window[rblid] != null || document.getElementById(rblid) != null)
        {
            var radiobuttonlist = window[rblid];
            if (!radiobuttonlist)
                radiobuttonlist = document.getElementById(rblid);

            var radiostyle = radiobuttonlist.style;

            var radioButtonItems = radiobuttonlist.getElementsByTagName("input");
            var val = "";

            for (var itemIndex = 0; itemIndex < radioButtonItems.length; itemIndex++)
            {
                if (radioButtonItems[itemIndex].checked)
                {
                    val = radioButtonItems[itemIndex].value;
                    break;
                }
            }

            return (radiostyle.display + '$' + radiostyle.visibility + '$' + radiostyle.width + '$' + radiostyle.height + '$' + radiobuttonlist.readOnly + '$' + radiobuttonlist.disabled + '$' + val);
        }
    }
    catch (e) { }
}

function GetStateForCheckList(radioid)
{
    try
    {
        if (window[radioid] != null || document.getElementById(radioid) != null)
        {
            var radiobuttonlist = window[radioid];
            if (!radiobuttonlist)
                radiobuttonlist = document.getElementById(radioid);

            var radiostyle = radiobuttonlist.style;

            var radioButtonItems = radiobuttonlist.getElementsByTagName("input");
            var val = '';

            for (var itemIndex = 0; itemIndex < radioButtonItems.length; itemIndex++)
            {
                val += (radioButtonItems[itemIndex].checked) ? "on;" : "off;";
            }

            if (val != "")
            {
                val = val.substring(0, val.length - 1); // remove last ';'
            }
            return (radiostyle.display + '$' + radiostyle.visibility + '$' + radiostyle.width + '$' + radiostyle.height + '$' + radiobuttonlist.readOnly + '$' + radiobuttonlist.disabled + '$' + val);
        }
    }
    catch (e) { }
}

function GetStateForTextMaskEmailPhoneNumberInputs(textboxid)
{
    if (window[textboxid] != null)
    {
        var radtextbox = window[textboxid];
        var textObjStyle = radtextbox.style;
        if (radtextbox.runtimeStyle == null)
        {
            radtextbox.runtimeStyle = radtextbox.style;
        }
        return (textObjStyle.display + '$' + textObjStyle.visibility + '$' + radtextbox.runtimeStyle.width + '$' + radtextbox.runtimeStyle.height + '$' + radtextbox.readOnly + '$' + radtextbox.disabled + '$');//+','+textObjStyle.disabled);//'' enable 'disabled' disabled
    }
}
function GetStateForDateAndTimeInput(datetimeboxid)
{
    if (window[datetimeboxid] != null)
    {
        dateObj = window[datetimeboxid];
        dateboxObj = window[datetimeboxid].DateInput.TextBoxElement;
        dateBoxElementObj = window[datetimeboxid].DateInput.TextBoxElement;
        var dateObjStyle = dateBoxElementObj.style;
        return (dateObj.MaxDate + '$' + dateObj.MinDate + '$' + dateObjStyle.display + '$' + dateObjStyle.visibility + '$' + dateBoxElementObj.readOnly + '$' + dateBoxElementObj.disabled + '$'); //+','+textObjStyle.disabled);//
    }
}

function setRowFocusAfterAppend()
{
    focusctrl(_ctlToBeFocusedforAppendRow);
}
function focusctrl(ctTBF)
{
    try
    {
        var ctrId = ctTBF.id;
        if (ctrId.indexOf("_dateInput_text") > -1)
        {
            objectToBeFocused = window[ctrId.replace("_dateInput_text", "")];
            document.getElementById(objectToBeFocused.DateInput.TextBoxElement.id).focus();
        }
        else if (ctrId.indexOf("_text") > -1)
        {
            objectToBeFocused = window[ctrId.replace("_text", "")];
            document.getElementById(objectToBeFocused.TextBoxElement.id).focus();
        }
        else
        {
            objectToBeFocused = window[ctrId];
            if (objectToBeFocused == undefined)
            {
                document.getElementById(ctrId).focus();
            }
            else
            {
                document.getElementById(objectToBeFocused).focus();
            }
        }

    }
    catch (error)
    {
    }
}

var winid = '';
function OpenAttachmentWindow(ctrlWebID, btnId, repoName, hdnId, extns, coreid, windowid, persistheader, buff)
{
    //winid=windowid;
    //var radwin=window.radopen(_TemplateDirectorySkeltaForms+"SkeltaAttachment.aspx?WebId="+ctrlWebID+"&BtnId="+btnId+"&rname="+repoName+"&HdnID="+hdnId+"&extns="+extns+"&CoreID="+coreid+"&persistHeader="+persistheader+"&buffer="+buff,windowid);       
    //return radwin;
    var attachwin = dhtmlwindow.open("attachwin", "iframe", _TemplateDirectorySkeltaForms + "SkeltaAttachment.aspx?WebId=" + ctrlWebID + "&BtnId=" + btnId + "&rname=" + repoName + "&HdnID=" + hdnId + "&extns=" + extns + "&CoreID=" + coreid + "&persistHeader=" + persistheader + "&buffer=" + buff, "Attach", "width=500px,height=130px,resize=0,center=1", "recal");
    attachwin.onclose = sf_attachmentClose;

    var divEle;
    divEle = document.getElementById("xdivmasking");
    if (divEle == null)
    {
        divEle = document.createElement('div');
        divEle.setAttribute("id", "xdivmasking");
        document.body.appendChild(divEle);
    }
    divEle.style.display = "block";
    divEle.style.visibility = "visible";
    var divSty = document.getElementById("xdivmasking").style;
    divSty.position = "absolute"; divSty.top = "0px"; divSty.left = "0px"; divSty.width = document.body.clientWidth; divSty.height = document.body.clientHeight;
    divSty.zIndex = "46"; divSty.opacity = ".50"; divSty.backgroundColor = "#000";
    divSty.filter = "alpha(opacity=50)";

    return attachwin;

}
function sf_attachmentClose()
{
    divEle = document.getElementById("xdivmasking");
    divEle.style.display = "none";
    divEle.style.visibility = "hidden";
    return true;
}
function sf_attachmentmodalreset()
{
    try
    {
        var divSty = document.getElementById("xdivmasking").style;
        divSty.width = document.body.clientWidth; divSty.height = document.body.clientHeight;
    }
    catch (err)
    {
    }
}

function UpdateFileToHiddenField(hiddenId, attachmentId)
{
}
function ViewDownloadFile(uri)
{
    var w, h;
    if (document.all || document.layers)
    {
        w = screen.availWidth;
        h = screen.availHeight;
    }

    winHeight = (h * 15 / 100);
    winWidth = (w * 25 / 100);

    var randomnumber = Math.floor(Math.random() * 100000);
    var date = new Date();
    var ticks = date.getTime();

    var builtUrl = '';
    if (uri.endsWith('.aspx') && uri.indexOf('?') == -1)
    {
        builtUrl = uri + "?radrandomcache=" + randomnumber + ticks;
    }
    else
    {
        builtUrl = uri + "&radrandomcache=" + randomnumber + ticks;
    }
    var downloadwin = dhtmlwindow.open("downloadwin", "iframe", _TemplateDirectorySkeltaForms + builtUrl, skFormsMessages.TitleViewOrDownloadFile, "width=" + winWidth + ",height=" + winHeight + ",resize=0,center=1", "recal");
    return downloadwin;
}

String.prototype.endsWith = function (str) { return (this.match(str + "$") == str) }

/// function to handle the form submit on "Enter".
function KeyDown(e)
{
    try
    {
        var evtobj = window.event ? window.event : e;
        if (evtobj.keyCode == 13)
        {
            var returnflag = true;
            var srcEl = evtobj.srcElement ? evtobj.srcElement : e.target;
            var t = srcEl.type;

            if (t == "")
            {

                if (!srcEl.href)
                    returnflag = false;
            }
            else
            {
                switch (t)
                {
                    case "submit":
                    case "button":
                    case "image":
                        {
                            break;
                        }
                    default:
                        {
                            returnflag = false;
                            break;
                        }
                }
            }
            return returnflag;
        }
    }
    catch (Error)
    {
        desc = Error.description ? Error.description : Error;
        alert(desc);

    }
}
function AlertErrs(msg)
{
    if (typeof window.alertValidationMessages == 'function')
    {
        alertValidationMessages(ReplaceAll(unescape(msg), "+", " "));
    }
    else
    {
        alert(ReplaceAll(unescape(msg), "+", " "));
    }
}
function ReplaceAll(Source, stringToFind, stringToReplace)
{

    var temp = Source;

    var index = temp.indexOf(stringToFind);

    while (index != -1)
    {

        temp = temp.replace(stringToFind, stringToReplace);

        index = temp.indexOf(stringToFind);

    }

    return temp;
}


function sf_FormMaximize()
{
    try
    {
        var frameElem = GetRadWindow();
        if (frameElem != null)
        {
            frameElem.maximize();
        }
        else
        {
            window.moveTo(0, 0);
            window.resizeTo(screen.availWidth, screen.availHeight);
        }
    }
    catch (err)
    {
    }
}

function sf_verifyExpressionBuilderVisibility(ExpressionBuilderWebId)
{
    try
    {
        var skidmapctrl = new String(_skidmap[ExpressionBuilderWebId]);
        var combo = window[skidmapctrl];
        var expTxt = document.getElementById(skidmapctrl + "_expression_text");
        var imgArray = document.getElementsByTagName('img');
        var td = document.getElementById('calculatedproperty_formulatext_' + ExpressionBuilderWebId);
        var img;
        for (var i = 0; i < imgArray.length; i++)
        {
            var imgsrc = imgArray[i].src;
            var fileNameIndex = imgsrc.lastIndexOf("/") + 1;
            var filename = imgsrc.substr(fileNameIndex);
            if (imgsrc.indexOf('/EnterpriseConsole/BPMUITemplates/Default/SkeltaForms/images/rolelookupcontrolimage.png') != -1 || filename === "rolelookupcontrolimage.png")
            {
                img = imgArray[i];
                break;
            }
        }
        if (combo.GetText() == "True")
        {
            expTxt.style.visibility = "visible";
            img.style.visibility = "visible";
            td.style.visibility = "visible";
        }
        else if (combo.GetText() == "False")
        {
            expTxt.style.visibility = "hidden";
            img.style.visibility = "hidden";
            td.style.visibility = "hidden";
        }
    }
    catch (err)
    {

    }
}

function OpenPopup(url, height, width, windowName)
{
    //var options = 'top=100,left=300,height=' + height + ',width=' + width;
    //var popWin;
    windowName = ReplaceAll(windowName, "-", "");
    //popWin = window.open(url, windowName, options);
    if (height == 0)
        height = 400;
    if (width == 0)
        width = 500;
    var options = 'top=100,left=300,height=' + height + ',width=' + width;
    var dialogoptions = 'dialogTop:100;dialogLeft:300;dialogHeight:' + height + 'px;dialogWidth:' + width + 'px;';
    var popWin;
    //appending the dummy querystring &X=X as # was getting appended to the end of the request and causing problems in server side while reading - incase of multilevel popupform
    url = url + "&X=X";
    if (window.showModalDialog)
        popWin = window.showModalDialog(url, window, dialogoptions);
    else
        popWin = window.open(url, windowName, options);
    return popWin;
}

function OpenFormDefinitionWindow(url)
{
    var lookupWin = window.open(url, "FormLookupPageTitle", "width=420,height=285");
    return lookupWin;
}

function OpenSPExplorer(val, id, appName)
{
    var spExpWin = window.open(_TemplateDirectorySkeltaForms + "FormSharePointExplorer.aspx?CurrentValue=" + val + "&Id=" + id + "&appName=" + appName, "", "width=450,height=700");
    return spExpWin;
}


var _CurrentTabStrip = null;
var _NewIndex = null;
var _FireTabEvents = true;
function sf_tabSelected(tabStp)
{
    if (_FireTabEvents)
    {
        _CurrentTabStrip = tabStp;

        var lv = null;
        lv = eval("window.sel" + tabStp.ID + "lstVal");
        if (lv == null)
        {
            eval("window.sel" + tabStp.ID + "lstVal = " + tabStp.InitialState.SelectedIndex + ";");
            lv = eval("window.sel" + tabStp.ID + "lstVal");
        }
        _NewIndex = tabStp.SelectedIndex;
        _FireTabEvents = false;
        _CurrentTabStrip.Tabs[lv].Select();
        apnlCollec = new Object();
        if (!inQueue)
        {
            SetCurrentState();
            CallServerSideMethod(_skidmap["TOPFORMRENDERERID"], 'ValidateTabs', "DataTableTest", CallbackBuildXmlForTabs, 'table', _skstatemap, 'tabStripID', _CurrentTabStrip.ID, 'tabCurrentIndex', lv, 'parentID', _CurrentTabStrip.DomElement.getAttribute("parentID"));
            inQueue = true;
        }
    }
    else
        _FireTabEvents = true;

}
function CallbackBuildXmlForTabs(context, result, response)
{
    if (result != null)
    {

        for (var i = 0; i < result.length; i++)
        {
            try
            {
                eval(result[i]);
            }
            catch (err) { }
        }
    }

    var valid = eval("window.sel" + _CurrentTabStrip.ID + "Validity");

    if (!valid)
    {
        var lv = eval("window.sel" + _CurrentTabStrip.ID + "lstVal");
    }
    else
    {
        _FireTabEvents = false;
        _CurrentTabStrip.Tabs[_NewIndex].Select();
        eval("sel" + _CurrentTabStrip.ID + "lstVal = " + _NewIndex + ";");
    }
    inQueue = false;
    //FOR NEXT TIME

}

function ToggleTreeView(treeObj)
{
    var treeId = _skidmap[treeObj];
    if (document.getElementById(treeId).style.visibility == "hidden")
    {
        document.getElementById(treeId).style.visibility = "visible";
        document.getElementById(treeId).style.display = "block"
    }
    else
    {
        document.getElementById(treeId).style.visibility = "hidden";
        document.getElementById(treeId).style.display = "none";
    }
}
function TreeClicked(selectedTreeObject)
{
    var collection = new Array();
    collection = selectedTreeObject.Value.split('~');
    if (collection[2] == "unselectable")
    {
    }
    else
    {
        document.getElementById(_skidmap[collection[1]]).value += "<%" + selectedTreeObject.Text + "%>";
        var rootId = collection[1].substring(0, collection[1].indexOf("c"));
        var hdnCtlId = rootId + "h";
        document.getElementById(_skidmap[hdnCtlId]).value += "<%" + selectedTreeObject.Text + "%>";
        ToggleTreeView(collection[2]);
    }
}

function TreeValueChanged(txtobj, enableAppend)
{
    var hdnId = txtobj.getAttribute("hiddenCtrl");
    var hdnCtlId = _skidmap[hdnId];
    document.getElementById(hdnCtlId).value = txtobj.value;
}

function OnCheckBoxClicked()
{
    setTimeout(function () { sf_raiseOnValueChange(); }, 10);
}

function SetStateForCheckBox(radioid, checkListValue)
{
    try
    {
        if (window[radioid] != null || document.getElementById(radioid) != null)
        {
            var radiobuttonlist = window[radioid];
            if (!radiobuttonlist)
                radiobuttonlist = document.getElementById(radioid);

            var radioButtonItems = radiobuttonlist.getElementsByTagName("input");

            if (checkListValue.endsWith(";"))
            {
                checkListValue = checkListValue.substring(0, checkListValue.length - 1); // remove last ';'
            }

            var values = checkListValue.split(';');

            if (values.length == radioButtonItems.length)
            {
                for (var itemIndex = 0; itemIndex < radioButtonItems.length; itemIndex++)
                {
                    radioButtonItems[itemIndex].checked = (values[itemIndex] == "on");
                }
            }
        }
    }
    catch (e) { }
}

function SetStateForRadioButtonGroup(rblid, index)
{
    try
    {
        if (window[rblid] != null || document.getElementById(rblid) != null)
        {
            var radiobuttonlist = window[rblid];
            if (!radiobuttonlist)
                radiobuttonlist = document.getElementById(rblid);

            var radioButtonItems = radiobuttonlist.getElementsByTagName("input");

            for (var itemIndex = 0; itemIndex < radioButtonItems.length; itemIndex++)
            {
                radioButtonItems[itemIndex].checked = false;
            }

            if ((index >= 0) && (index < radioButtonItems.length))
            {
                radioButtonItems[index].checked = true;
            }
        }
    }
    catch (e) { }
}

function SetStateForDropDownList(ddlid, index)
{
    try
    {
        if (window[ddlid] != null || document.getElementById(ddlid) != null)
        {
            var dropdownlist = window[ddlid];
            if (!dropdownlist)
                dropdownlist = document.getElementById(ddlid);

            var dropdownItems = dropdownlist.getElementsByTagName("option");

            for (var itemIndex = 0; itemIndex < dropdownItems.length; itemIndex++)
            {
                dropdownItems[itemIndex].selected = false;
            }

            if ((index >= 0) && (index < dropdownItems.length))
            {
                dropdownItems[index].selected = true;
            }
            else
            {
                // Be default select the first item in the list, if there 
                // is no other item being selected.
                dropdownlist.selectedIndex = 0;
            }
        }
    }
    catch (e) { }
}

function CenterWindow(url, windowName, windowWidth, windowHeight, windowOuterHeight, features)
{
    var centerLeft = parseInt((window.screen.availWidth - windowWidth) / 2);
    var centerTop = parseInt(((window.screen.availHeight - windowHeight) / 2) - windowOuterHeight);
    var windowFeatures = 'width=' + windowWidth + ',height=' + windowHeight + ',left=' + centerLeft + ',top=' + centerTop + features;
    var win = window.open(url, windowName, windowFeatures);
    win.focus();
    return win;
}

function RefreshFormGrid(gridId, srcVal)
{
    var loader = _skidmap["pp" + gridId];
    document.getElementById(loader).style.display = "block";

    var randomnumber = Math.floor(Math.random() * 100000);
    var date = new Date();
    var ticks = date.getTime();

    var builtUrl = '';
    if (srcVal.endsWith('.aspx') && srcVal.indexOf('?') == -1)
    {
        builtUrl = srcVal + "?radrandomcache=" + randomnumber + ticks;
    }
    else
    {
        builtUrl = srcVal + "&radrandomcache=" + randomnumber + ticks;
    }
    document.getElementById(_skidmap[gridId]).src = builtUrl;
}

function SSRSRefreshFormFrame(frameId, popupLinkId, srcVal, instXmlId)
{
    var randomnumber = Math.floor(Math.random() * 100000);
    var date = new Date();
    var ticks = date.getTime();

    var builtUrl = '';
    if (srcVal.endsWith('.aspx') && srcVal.indexOf('?') == -1)
    {
        builtUrl = srcVal + "?radrandomcache=" + randomnumber + ticks;
    }
    else
    {
        builtUrl = srcVal + "&radrandomcache=" + randomnumber + ticks;
    }

    document.getElementById(_skidmap[frameId]).src = builtUrl;

    document.getElementById(_skidmap[popupLinkId]).setAttribute("skinstxmlid", instXmlId);
}

function SSRSOnReportViewerPopupLinkClick(popupLinkControl)
{
    if (!popupLinkControl)
    {
        return;
    }

    OpenSSRSReportViewerPopupWindow(popupLinkControl.getAttribute("skrepositoryname"),
                                    popupLinkControl.getAttribute("skinstxmlid"),
                                    popupLinkControl.getAttribute("skformassociateditemid"),
                                    popupLinkControl.getAttribute("skformassociatedlistname"),
                                    popupLinkControl.getAttribute("skreportviewerid"),
                                    popupLinkControl.getAttribute("skversionstamp"),
                                    popupLinkControl.getAttribute("sktoplevelformname"));

}

//Shows overlay mask div on click of form level button, which disable any interaction with form.
function ShowOverlay(sender)
{
    try
    {
        var btn = document.getElementById(sender.id);
        btn.hideFocus = true;
        btn.disabled = true;
        var divOverlay = document.getElementById("overlaydiv");
        if (!divOverlay)
        {
            divOverlay = document.createElement('div');
            divOverlay.setAttribute("id", "overlaydiv");
            document.body.appendChild(divOverlay);
        }
        divOverlay.style.display = "block";
        divOverlay.style.visibility = "visible";
        var divStyle = document.getElementById("overlaydiv").style;
        divStyle.position = "absolute"; divStyle.top = "0px"; divStyle.left = "0px"; divStyle.width = "100%"; divStyle.height = "100%";
        divStyle.zIndex = "999"; divStyle.opacity = "0.2"; divStyle.backgroundColor = "#000";
        divStyle.filter = "alpha(opacity=20)";
    } catch (err)
    { }
}

//Hides the overlaydiv
function HideOverlay()
{
    try
    {
        var divOverlay = document.getElementById("overlaydiv");
        divOverlay.style.visibility = "hidden";
        divOverlay.style.display = "none";
    } catch (err)
    { }
}

//To show messages based on device types
function ShowAlertMessages(message)
{
    try
    {
        // alertValidationMessages is defined in skeltawindowserver.js
        if (typeof window.alertValidationMessages == 'function')
        {
            alertValidationMessages(message);
        }
        else
        {
            alert(message);
        }
    }
    catch (err)
    {
    }
}
// this variable is used maintain the content div ids and hiddenfield id which is used to save scroll positions
// and it is defined and updated in server side.
var scrollingMap;

//this variable is used lock scroll positions during ajax post backs.
var lockScrollPositions = false;

//To maintain scroll position
function SaveScrollPosition(div, hdnFieldID)
{
    try
    {
        if (!lockScrollPositions)
        {
            var scrolledposition = document.getElementById(_skidmap[hdnFieldID]);
            scrolledposition.value = div.scrollTop;
        }
    }
    catch (err)
    {
    }
}

//To retain scroll postion on ajax postback
function RetainScrollPositions()
{
    try
    {
        if (scrollingMap != null)
        {
            setTimeout(function ()
            {
                try
                {
                    for (var divId in scrollingMap)
                    {
                        var bodyDiv = document.getElementById(divId);
                        if (bodyDiv != null)
                        {
                            var hiddenfieldId = scrollingMap[divId];
                            var scrolledposition = document.getElementById(_skidmap[hiddenfieldId]);
                            if (scrolledposition != null && scrolledposition.value != "")
                            {
                                bodyDiv.scrollTop = scrolledposition.value;
                            }
                        }
                    }
                }
                catch (innerError)
                {
                }
            },
    0);
        }
    } catch (outerError)
    { }
    finally
    {
        lockScrollPositions = false;
    }
}

//This event occurs whenever the ajax request starts
function OnAjaxRequestStart()
{
    try
    {
        //alert('OnAjaxRequestStart');
        //locking scroll postions, because during the ajax postback scroll positions should not be updated.
        lockScrollPositions = true;
    }
    catch (err)
    {
    }
}


/// Set focus for very first control on form load
/// <param name="firstElementIdToBeFocussed">Controls UniqueId</param>


function SetFocusToFirstControlOnLoad(firstElementIdToBeFocussed)
{
    try
    {
        if (firstElementIdToBeFocussed != null)
        {
            var firstControlToBeFocussed = document.getElementById(_skidmap[firstElementIdToBeFocussed]);
            if (firstControlToBeFocussed != null)
            {
                firstControlToBeFocussed.focus();
            }
        }
    }
    catch (err)
    {
    }
}

function CheckRowInFormDataGrid(id)
{
    try
    {
        var frame = document.getElementById(_skidmap[id]);
        frame.contentWindow.HighlightRow();
    }
    catch (err)
    { }
}

function CreateFrame(url)
{
    var width = 710;
    var height = 500;
    var left = (screen.width / 2) - (width / 2);
    var top = (screen.height / 2) - (height / 2);
    window.open(url, 'frame', 'directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,height=' + height + ',width=' + width + ', , top=' + top + ', left=' + left + '');
}

function ShowSaveAsDraftOptions(mismatchurl, hiddenfieldId)
{
    try
    {
        //E_E_SaveButtons_E_E_SaveButtons_sys_ixxyy1234134_skforms_submitid ///alert(C10);
        var confirmationShown = document.getElementById(_skidmap[hiddenfieldId]).value;
        if (confirmationShown === "0")
        {
            window.open(mismatchurl, 'saveasdraftwindow', 'directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,height=500,width=600,top=100,left=100');
        }
    }
    catch (err) { }
}

function HandleAttachmentValueChange(id)
{
    var hiddenField = document.getElementById(_skidmap[id]);
    if (hiddenField != null)
    {
        if (hiddenField.getAttribute("onchange") != null)
        {
            sf_raiseOnValueChange();
        }
    }
}

function HandleCheckBoxReadOnly(id, readOnly)
{
    var checkObj = ''; checkObj = document.getElementById(_skidmap[id]);
    try
    {
        var cbInputItems = checkObj.getElementsByTagName('input');
        for (var itemIndex = 0; itemIndex < cbInputItems.length; itemIndex++)
        {
            if (readOnly)
            {
                cbInputItems[itemIndex].onclick = function () { return false; };
            }
            else
            {
                if (arguments.length == 3 && arguments[2] == "hasDependecies")
                {
                    cbInputItems[itemIndex].onclick = function () { OnCheckBoxClicked(); sf_onFocus(this); };
                }
                else
                {
                    cbInputItems[itemIndex].onclick = function () { };
                }
            }
        }
    }
    catch (err)
    {
    }
}

function GetQueryStrings(windowObject)
{
    var assoc = {};
    var decode = function (s) { return decodeURIComponent(s.replace(/\+/g, " ")); };
    var queryString = windowObject.location.search.substring(1);
    var keyValues = queryString.split('&');

    for (var i in keyValues)
    {
        var key = keyValues[i].split('=');
        if (key.length > 1)
        {
            assoc[decode(key[0])] = decode(key[1]);
        }
    }

    return assoc;
}
