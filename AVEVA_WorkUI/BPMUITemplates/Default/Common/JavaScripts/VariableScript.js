/// <reference path="jquery.js" />
/// <reference path="kendo.all.js" />

//Variable declarartion

var lhsObj;
var imageLHSObj;
var inputLHSObj;

var mhsObj;
var imageMHSObj;
var inputMHSObj;
var MHSComboInstance;

var cmbOPRName;
var imageOPRObj;
var inputOPRObj;

var txtRHSObj, radRHSNumberControlObj, radRHSDateControlObj, radRHSTimeControlObj, radRHSDateTimeControlObj;
var radRHSNumberCoreObj, radRHSDateCoreObj, radRHSTimeCoreObj, radRHSDateTimeCoreObj;

var bubbleWindowObj;

var mode = "LHS";

var expbuilderURl = "";

var delteRowImg;
var ConditionDeleteLocal;
var conditionSelectLocal;
var conditionEnterValueLocal;
var ConditionObjTreeLocal;
var ObjTreeMode = 0;
var prevRow = 0;
var isObjectTreeInUse = false;

var InitialUpdatedVariableArray = new Array();
var FinalUpdatedVariableArray = new Array();
var SaveconditionalArray = new Array();

var updatedVariableRowList;
var variableListArray = new Array();
var rhsTextValue;
var nodeValue;

var objLHSRadDiv;
var objRHSRadDiv;
var objLHSRadTree;
var objRHSRadTree;
var xLHS = "";
var yLHS = "";
var xRHS = "";
var yRHS = "";
var lhsAllowValue = false;
var txtLHSObj;
var dateTimeUtil = new DateTimeUtility();
var numberUtil = new NumberUtility();

var oprComboObject;
var mhsComboObject;


$(document).ready(function () {    
    Initialize();
});

function VariableRow() {
    this.RHSMode = "Default";
    this.LHSColumn = "";
    this.RHSColumn = "";
    this.OPRColumn = "";
    this.ColumnExpression = new Expression('', '', '', '', '', '', '');
}

function Expression(DisplayExpressionString, ActualExprtessionString, MethodParameterList, HtmlVerexpString, ReferenceList, ReferencedFunctionList, nodeinfo) {
    this.DisplayExpressionString = DisplayExpressionString;
    this.ActualExprtessionString = ActualExprtessionString;
    this.MethodParameterList = MethodParameterList;
    this.HtmlVerexpString = HtmlVerexpString;
    this.ReferenceList = ReferenceList;
    this.ReferencedFunctionList = ReferencedFunctionList;
    this.NodeInfo = nodeinfo;
}

function HideEditMode()
{
    document.getElementById("HidY").value = "";
    document.getElementById("HidX").value = "";
    document.getElementById("HidYRHS").value = "";
    document.getElementById("HidXRHS").value = "";

    txtLHSObj.style.display = "none";
    inputLHSObj.style.display = "none";
    imageLHSObj.style.display = "none";
    oprComboObject.style.display = "none";
    Maximize(false, 0);
    HideTreeView();
    hideRHSInputControl();
    if (document.getElementById("hiddivNumber") != null) {
        PlaceLinkforText();

        mode = "LHS";
    }
}

//For placing control on the Link
//When user does mouseover on the link this function will be get called
//Parameters
// linkObject -- HyperLink object
// no -  selected row number
// combo  - LHS  or MHS or RHS
function alterLink(linkObject, no, combo) {
    document.getElementById("HidY").value = "";
    document.getElementById("HidX").value = "";
    document.getElementById("HidYRHS").value = "";
    document.getElementById("HidXRHS").value = "";
    Maximize(false, 0);
    HideTreeView();
    hideRHSInputControl();
    inputLHSObj.style.display = "none";
   if (document.getElementById("hiddivNumber") != null) {
        var prevRowDivObj = document.getElementById("divExpressionLayer" + document.getElementById("hiddivNumber").value);
        document.getElementById("hiddivNumber").value = no;
        PositionObj1(linkObject, combo);

        mode = combo;
    }
}
function alterLinkEnter(linkObject, no, combo) {
    document.getElementById("HidY").value = "";
    document.getElementById("HidX").value = "";
    document.getElementById("HidYRHS").value = "";
    document.getElementById("HidXRHS").value = "";
    txtLHSObj.style.display = "none";
    hideRHSInputControl();
    inputLHSObj.style.display = "none";
    if (document.getElementById("hiddivNumber") != null) {
        var prevRowDivObj = document.getElementById("divExpressionLayer" + document.getElementById("hiddivNumber").value);
        document.getElementById("hiddivNumber").value = no;
        PositionObj1(linkObject, combo);

        mode = combo;
    }

}

function alterLinkSelect(linkObject, no, combo) {
    document.getElementById("HidY").value = "";
    document.getElementById("HidX").value = "";
    document.getElementById("HidYRHS").value = "";
    document.getElementById("HidXRHS").value = "";
    Maximize(false, 0);
    HideTreeView();

    hideRHSInputControl();
    inputLHSObj.style.display = "none";
    if (document.getElementById("hiddivNumber") != null) {
        var prevRowDivObj = document.getElementById("divExpressionLayer" + document.getElementById("hiddivNumber").value);
        document.getElementById("hiddivNumber").value = no;
        PositionObj1(linkObject, combo);

        mode = combo;
    }

}

//Validating a row for valid entries
function validateRows(RowNo) {
    var Rownumber = RowNo - 1;
    if (!isUndefined(eval("window.Row" + Rownumber))) {
        //alert("t");
        var rhsVal = eval("window.Row" + Rownumber + ".RHSColumn");
        var lhsVal = eval("window.Row" + Rownumber + ".LHSColumn");
        var mhsVal = eval("window.Row" + Rownumber + ".OPRColumn");
        if (eval("window.Row" + Rownumber + ".RHSMode") == "Expression") {//
            if ((eval("window.Row" + Rownumber + ".ColumnExpression").DisplayExpressionString == "")
                || (lhsVal == "")) {
                //objectify(eval("window.Row"+Rownumber+".RHSColumn")).DisplayExpressionString
                imageLHSObj.style.display = "none";
                se.ui.messageDialog.showError(bellybarTitle, MSG_EnterProperValues);
                return false;
            }
            else {
                return true;
            }
        }
        else {
            if ((rhsVal == "") || (lhsVal == "")) {
                imageLHSObj.style.display = "none";
                //Handling inproper validation when the first row was deleted and focus on LHS
                if (Rownumber - 1 < InitialUpdatedVariableArray.length) {
                    var rowInfo = InitialUpdatedVariableArray[Rownumber - 1];
                    var rowData = rowInfo.split("~");
                    if (rowData[1] == "S") {
                        se.ui.messageDialog.showError(bellybarTitle, MSG_EnterProperValues);
                        return false;
                    }
                }
            }
            else if (mhsVal == "<##>" && rhsVal.indexOf("XmlVariables.") == -1) {
                imageLHSObj.style.display = "none";
                se.ui.messageDialog.showError(bellybarTitle, MSG_OprUsedWithXmlVars);
                return false;
            }
            else {
                return true;
            }
        }
    }
}
//Initialize function for setting default behaviour  
function Initialize() {

    //Setting invisibility to the LHS
    imageLHSObj = document.getElementById('cmbLHS_Image');
    imageLHSObj.style.position = "absolute";
    imageLHSObj.style.visibility = "visible";

    inputLHSObj = document.getElementById('cmbLHS_Input');
    inputLHSObj.style.position = "absolute";
    inputLHSObj.style.visibility = "visible";

    txtLHSObj = document.getElementById('txtLHS');
    txtLHSObj.style.position = "absolute";
    txtLHSObj.style.visibility = "visible";

    mhsComboObject = document.getElementById(cmbMHSName);
    oprComboObject = document.getElementById(cmbOPRName);
             
    bubbleWindowObj = document.getElementById("bubbleWindow");
    bubbleWindowObj.style.position = "absolute";
    bubbleWindowObj.style.visibility = "visible";

    imageLHSObj.style.display = "none";
    inputLHSObj.style.display = "none";
    mhsComboObject.style.display = "none";
    oprComboObject.style.display = "none";   
    bubbleWindowObj.style.display = "none";

    InitializeRHSInputControls();

    var updatedVariableRowList = document.getElementById("HiddenJsString").value;

    if (updatedVariableRowList != "") {
        var variableListArray = objectify(updatedVariableRowList);
        for (var i = 0; i < variableListArray.length; i++) {
            var elementNo = parseInt(i + 1);

            var divExpLayerObj = document.getElementById("divExpressionLayer" + elementNo);
            if (variableListArray[i] != null) {
                if (divExpLayerObj == null) {
                    var nextRowHTML = AddRow(parseInt(elementNo - 1));
                    if (nextRowHTML != "")
                        document.getElementById("divExpressionLayers").innerHTML = document.getElementById("divExpressionLayers").innerHTML + nextRowHTML;
                }

                CreateRow(elementNo, variableListArray[i]);
            }
        }

        nextRowHTML = AddRow(variableListArray.length);
        if (nextRowHTML != "")
            document.getElementById("divExpressionLayers").innerHTML = document.getElementById("divExpressionLayers").innerHTML + nextRowHTML;
    }
}

function CreateRow(currentRow, updatedvariableRow) {
    // Set the global variables with the row values
    if (isUndefined(eval("window.Row" + currentRow)))
        eval("window.Row" + currentRow + " =new VariableRow()");

    eval("window.Row" + currentRow + ".LHSColumn=updatedvariableRow.LHSColumn");
    if (updatedvariableRow.RHSMode == "Expression") {
        eval("window.Row" + currentRow + ".RHSColumn=objectify(updatedvariableRow.RHSColumn).DisplayExpressionString");
        var updatedExpression = new Expression();
        updatedExpression = updatedvariableRow.ColumnExpression;
        eval("window.Row" + currentRow + ".ColumnExpression =updatedExpression");
    }
    else {
        eval("window.Row" + currentRow + ".RHSColumn=updatedvariableRow.RHSColumn");
    }

    eval("window.Row" + currentRow + ".RHSMode=updatedvariableRow.RHSMode");
    eval("window.Row" + currentRow + ".OPRColumn=updatedvariableRow.OPRColumn");

    if (!IsAddedToArray(currentRow)) {
        var inArrLen = InitialUpdatedVariableArray.length;
        InitialUpdatedVariableArray[inArrLen] = currentRow + "~" + "S";
    }

    var tableObject = document.getElementById("TableExpression" + currentRow);
    tableObject.className = "tab";

    //Building HTML for the LHSDIV
    setLHSDivHtml(currentRow, updatedvariableRow.LHSColumn, updatedvariableRow.LHSMode);

    //Building HTML for the MHSDIV
    setMHSDivHtml(currentRow, updatedvariableRow.OPRColumn);

    //Building HTML for the RHSDIV
    if (updatedvariableRow.RHSMode == "Expression") {
        rhsTextValue = objectify(updatedvariableRow.RHSColumn).DisplayExpressionString;
    }
    else {
        rhsTextValue = updatedvariableRow.RHSColumn;
    }

    setRHSDivHtml(currentRow, rhsTextValue, updatedvariableRow.RHSMode);

    setDivObjectTreeHtml(currentRow);



}

// Called when the Object Tree node is clicked
function ProcessClientClick(sender, eventArgs) {
    
        var node = eventArgs.get_node();
    var currentRow = document.getElementById("hiddivNumber").value;
    if (node.get_value() == "BEXPFUV") {
        OpenEXPBuilder(currentRow);
        mode = "RHS";
        return false;
    }
    else if (node.get_value() == "FormParameters" || node.get_value() == "Pnode" || node.get_value() == "Variables" || node.get_value() == "Contents" || node.get_value() == "XmlVariables" || (node.get_value().indexOf("XmlDocumentType") > -1) || (node.get_value().indexOf("XmlIterator") > -1)) {
        return false;
    }
    else if (node.get_value() == "UPDENT") {
        if (mode != "LHS") {
            if (isUndefined(eval("window.Row" + currentRow)))
                eval("window.Row" + currentRow + " =new VariableRow()");

            eval("window.Row" + currentRow + ".RHSMode='Default'");
            eval("window.Row" + currentRow + ".RHSColumn=''");

            setRHSDivHtml(currentRow, "", "Default");

            ToggleTreeView();
            imageLHSObj.style.display = "none";
            inputLHSObj.style.display = "none";
            hideRHSInputControl();
            showRHSInputControl(currentRow);

            return false;

        }
    }
    else if (sender.get_id().indexOf("cmbOperator") == 0) {
        mode = "MHS";
    }
    else {
        ToggleTreeView();
        imageLHSObj.style.display = "none";
        inputLHSObj.style.display = "none";
        hideRHSInputControl();
    }


    if (mode == "LHS") {
        var tableObject = document.getElementById("TableExpression" + currentRow);
        tableObject.className = "tab";

        var lhsTextVal = node.get_value();
        var lhsOriginalTextVal = node.get_value();
        nodeValue = node.get_value();
        if ((lhsTextVal == "GalaxyBrowser" || lhsTextVal.substring(0, 13) == "GalaxyBrowser")
            && IsOpenedFromA2() == "yes") {

            var tagName = window.external.Service('aaGalaxyBrowser').TagName;
            var retValue = window.external.Service('aaGalaxyBrowser').OpenGalaxyBrowser('', '', '', tagName);
            if (retValue.indexOf("[") > -1 && retValue.indexOf("]") > -1) {
                var retValueOrginal = retValue;
                var index = retValue.indexOf("[");
                retValue = retValue.substring(0, index) + "[]";
            }
            lhsTextVal = retValue;
            lhsOriginalTextVal = retValue;
        }
        if ((lhsTextVal == "OPCClientBrowser" || lhsTextVal.substring(0, 16) == "OPCClientBrowser")) {
            var serverUrl = document.getElementById("OPCdata").value;
            var opcConInf = document.getElementById("OPCConInfo").value;
            //var retValue = window.showModalDialog("../OPCUA/TagBrowser.aspx?OPCdata=" + serverUrl + "&OPCConInfo=" + opcConInf, '', 'dialogWidth:496px;dialogHeight:400px;scroll:no');
            window.open("../OPCUA/TagBrowser.aspx?OPCdata=" + serverUrl + "&OPCConInfo=" + opcConInf, 'OPCClientWindow', 'width=496,height=450,scrollbars=no');
        } else {
            if (isUndefined(eval("window.Row" + currentRow)))
                eval("window.Row" + currentRow + " =new VariableRow()");
            eval("window.Row" + currentRow + ".LHSColumn=lhsOriginalTextVal");
            // eval("window.Row"+currentRow+".LHSColumn=node.get_value()"); %OLD CODE, A2%

            if (!IsAddedToArray(currentRow)) {
                var inArrLen = InitialUpdatedVariableArray.length;
                InitialUpdatedVariableArray[inArrLen] = currentRow + "~" + "S";
            }

            //Building HTML for the LHSDIV            
            setLHSDivHtml(currentRow, lhsTextVal, ((!isUndefined(eval("window.Row" + currentRow))) ? eval("window.Row" + currentRow + ".LHSMode") : "Default"));

            //Creating New Row
            var nextRowHTML = AddRow(currentRow);
            if (nextRowHTML != "")
                document.getElementById("divExpressionLayers").innerHTML = document.getElementById("divExpressionLayers").innerHTML + nextRowHTML;

            //Building HTML for the MHSDIV
            setMHSDivHtml(currentRow, ((!isUndefined(eval("window.Row" + currentRow))) ? eval("window.Row" + currentRow + ".OPRColumn") : ""));

            //Building HTML for the RHSDIV
            setRHSDivHtml(currentRow, ((!isUndefined(eval("window.Row" + currentRow))) ? eval("window.Row" + currentRow + ".RHSColumn") : ""), ((!isUndefined(eval("window.Row" + currentRow))) ? eval("window.Row" + currentRow + ".RHSMode") : "Default"));


            setDivObjectTreeHtml(currentRow);
        }


    }
    else if (mode == "MHS") {
        setMHSDivHtml(currentRow, node.get_text());

        if (isUndefined(eval("window.Row" + currentRow)))
            eval("window.Row" + currentRow + " =new VariableRow()");

        eval("window.Row" + currentRow + ".OPRColumn=node.get_text()");

       // if (MHSComboInstance != null)
       //     MHSComboInstance.hideDropDown();
        // alterLink(document.getElementById("link"+currentRow),currentRow,"OPR");


        if (!IsAddedToArray(currentRow)) {
            var inArrLen = InitialUpdatedVariableArray.length;
            InitialUpdatedVariableArray[inArrLen] = currentRow + "~" + "S";
        }
        oprComboObject.style.display = "none";
       // inputOPRObj.style.display = "none";
       // imageOPRObj.style.display = "none";

    }
    else {
        var rhsTextVal = node.get_value();
        var rhsOriginalTextVal = node.get_value();
        nodeValue = node.get_value();

        if ((rhsTextVal == "OPCClientBrowser" || rhsTextVal.substring(0, 16) == "OPCClientBrowser")) {
            var serverUrl = document.getElementById("OPCdata").value;
            var opcConInf = document.getElementById("OPCConInfo").value;
            //var retValue = window.showModalDialog("../OPCUA/TagBrowser.aspx?OPCdata=" + serverUrl + "&OPCConInfo=" + opcConInf, '', 'dialogWidth:496px;dialogHeight:400px;scroll:no');
            window.open("../OPCUA/TagBrowser.aspx?OPCdata=" + serverUrl + "&OPCConInfo=" + opcConInf, 'OPCClientWindow', 'width=496,height=450,scrollbars=no');
        }
        if ((rhsTextVal != "OPCClientBrowser" || rhsTextVal.substring(0, 16) != "OPCClientBrowser")) {

            if ((rhsTextVal == "GalaxyBrowser" || rhsTextVal.substring(0, 13) == "GalaxyBrowser")
                && IsOpenedFromA2() == "yes") {
                var tagName = window.external.Service('aaGalaxyBrowser').TagName;
                var retValue = window.external.Service('aaGalaxyBrowser').OpenGalaxyBrowser('', '', '', tagName);
                rhsTextVal = retValue;
                rhsOriginalTextVal = retValue;
            }

            if (isUndefined(eval("window.Row" + currentRow)))
                eval("window.Row" + currentRow + " =new VariableRow()");

            eval("window.Row" + currentRow + ".RHSColumn=rhsOriginalTextVal");
            eval("window.Row" + currentRow + ".RHSMode='ObjTree'");


            if (!IsAddedToArray(currentRow)) {
                var inArrLen = InitialUpdatedVariableArray.length;
                InitialUpdatedVariableArray[inArrLen] = currentRow + "~" + "S";
            }

            //Building HTML for the RHSDIV    

            setRHSDivHtml(currentRow, rhsTextVal, eval("window.Row" + currentRow + ".RHSMode"));
        }


    }

    return false;
}

function ProcessClientClickForCombo(comboObject) {
    var currentRow = document.getElementById("hiddivNumber").value;
    if (comboObject.get_value() == "BEXPFUV") {
        OpenEXPBuilder(currentRow);
        mode = "RHS";
        return false;
    }
    else if (comboObject.get_value() == "FormParameters" || comboObject.get_value() == "PcomboObject" || comboObject.get_value() == "Variables" || comboObject.get_value() == "Contents" || comboObject.get_value() == "XmlVariables" || (comboObject.get_value().indexOf("XmlDocumentType") > -1) || (comboObject.get_value().indexOf("XmlIterator") > -1)) {
        return false;
    }
    else if (comboObject.get_value() == "UPDENT") {
        if (mode != "LHS") {
            if (isUndefined(eval("window.Row" + currentRow)))
                eval("window.Row" + currentRow + " =new VariableRow()");

            eval("window.Row" + currentRow + ".RHSMode='Default'");
            eval("window.Row" + currentRow + ".RHSColumn=''");

            setRHSDivHtml(currentRow, "", "Default");

            ToggleTreeView();
            imageLHSObj.style.display = "none";
            inputLHSObj.style.display = "none";
            hideRHSInputControl();
            showRHSInputControl(currentRow);

            return false;

        }
    }
    else if (comboObject.get_id().indexOf("cmbOperator") == 0) {
        mode = "MHS";
    }
    else {
        ToggleTreeView();
        imageLHSObj.style.display = "none";
        inputLHSObj.style.display = "none";
        hideRHSInputControl();
    }


    if (mode == "LHS") {
        var tableObject = document.getElementById("TableExpression" + currentRow);
        tableObject.className = "tab";

        var lhsTextVal = comboObject.get_value();
        var lhsOriginalTextVal = comboObject.get_value();
        nodeValue = comboObject.get_value();
        if ((lhsTextVal == "GalaxyBrowser" || lhsTextVal.substring(0, 13) == "GalaxyBrowser")
            && IsOpenedFromA2() == "yes") {

            var tagName = window.external.Service('aaGalaxyBrowser').TagName;
            var retValue = window.external.Service('aaGalaxyBrowser').OpenGalaxyBrowser('', '', '', tagName);
            if (retValue.indexOf("[") > -1 && retValue.indexOf("]") > -1) {
                var retValueOrginal = retValue;
                var index = retValue.indexOf("[");
                retValue = retValue.substring(0, index) + "[]";
            }
            lhsTextVal = retValue;
            lhsOriginalTextVal = retValue;
        }
        if ((lhsTextVal == "OPCClientBrowser" || lhsTextVal.substring(0, 16) == "OPCClientBrowser")) {
            var serverUrl = document.getElementById("OPCdata").value;
            var opcConInf = document.getElementById("OPCConInfo").value;
            //var retValue = window.showModalDialog("../OPCUA/TagBrowser.aspx?OPCdata=" + serverUrl + "&OPCConInfo=" + opcConInf, '', 'dialogWidth:496px;dialogHeight:400px;scroll:no');
            window.open("../OPCUA/TagBrowser.aspx?OPCdata=" + serverUrl + "&OPCConInfo=" + opcConInf, 'OPCClientWindow', 'width=496,height=450,scrollbars=no');
        } else {
            if (isUndefined(eval("window.Row" + currentRow)))
                eval("window.Row" + currentRow + " =new VariableRow()");
            eval("window.Row" + currentRow + ".LHSColumn=lhsOriginalTextVal");
            // eval("window.Row"+currentRow+".LHSColumn=comboObject.get_value()"); %OLD CODE, A2%

            if (!IsAddedToArray(currentRow)) {
                var inArrLen = InitialUpdatedVariableArray.length;
                InitialUpdatedVariableArray[inArrLen] = currentRow + "~" + "S";
            }

            //Building HTML for the LHSDIV            
            setLHSDivHtml(currentRow, lhsTextVal, ((!isUndefined(eval("window.Row" + currentRow))) ? eval("window.Row" + currentRow + ".LHSMode") : "Default"));

            //Creating New Row
            var nextRowHTML = AddRow(currentRow);
            if (nextRowHTML != "")
                document.getElementById("divExpressionLayers").innerHTML = document.getElementById("divExpressionLayers").innerHTML + nextRowHTML;

            //Building HTML for the MHSDIV
            setMHSDivHtml(currentRow, ((!isUndefined(eval("window.Row" + currentRow))) ? eval("window.Row" + currentRow + ".OPRColumn") : ""));

            //Building HTML for the RHSDIV
            setRHSDivHtml(currentRow, ((!isUndefined(eval("window.Row" + currentRow))) ? eval("window.Row" + currentRow + ".RHSColumn") : ""), ((!isUndefined(eval("window.Row" + currentRow))) ? eval("window.Row" + currentRow + ".RHSMode") : "Default"));


            setDivObjectTreeHtml(currentRow);
        }


    }
    else if (mode == "MHS") {
        setMHSDivHtml(currentRow, comboObject.get_text());

        if (isUndefined(eval("window.Row" + currentRow)))
            eval("window.Row" + currentRow + " =new VariableRow()");

        eval("window.Row" + currentRow + ".OPRColumn=comboObject.get_text()");

        if (!IsAddedToArray(currentRow)) {
            var inArrLen = InitialUpdatedVariableArray.length;
            InitialUpdatedVariableArray[inArrLen] = currentRow + "~" + "S";
        }
        oprComboObject.style.display = "none";

    }
    else {
        var rhsTextVal = comboObject.get_value();
        var rhsOriginalTextVal = comboObject.get_value();
        nodeValue = comboObject.get_value();

        if ((rhsTextVal == "OPCClientBrowser" || rhsTextVal.substring(0, 16) == "OPCClientBrowser")) {
            var serverUrl = document.getElementById("OPCdata").value;
            var opcConInf = document.getElementById("OPCConInfo").value;
            //var retValue = window.showModalDialog("../OPCUA/TagBrowser.aspx?OPCdata=" + serverUrl + "&OPCConInfo=" + opcConInf, '', 'dialogWidth:496px;dialogHeight:400px;scroll:no');
            window.open("../OPCUA/TagBrowser.aspx?OPCdata=" + serverUrl + "&OPCConInfo=" + opcConInf, 'OPCClientWindow', 'width=496,height=450,scrollbars=no');
        }
        if ((rhsTextVal != "OPCClientBrowser" || rhsTextVal.substring(0, 16) != "OPCClientBrowser")) {

            if ((rhsTextVal == "GalaxyBrowser" || rhsTextVal.substring(0, 13) == "GalaxyBrowser")
                && IsOpenedFromA2() == "yes") {
                var tagName = window.external.Service('aaGalaxyBrowser').TagName;
                var retValue = window.external.Service('aaGalaxyBrowser').OpenGalaxyBrowser('', '', '', tagName);
                rhsTextVal = retValue;
                rhsOriginalTextVal = retValue;
            }

            if (isUndefined(eval("window.Row" + currentRow)))
                eval("window.Row" + currentRow + " =new VariableRow()");

            eval("window.Row" + currentRow + ".RHSColumn=rhsOriginalTextVal");
            eval("window.Row" + currentRow + ".RHSMode='ObjTree'");
            //eval("window.Row"+currentRow+".RHSColumn=comboObject.get_value()"); %OLD CODE, A2%


            if (!IsAddedToArray(currentRow)) {
                var inArrLen = InitialUpdatedVariableArray.length;
                InitialUpdatedVariableArray[inArrLen] = currentRow + "~" + "S";
            }

            //Building HTML for the RHSDIV    

            setRHSDivHtml(currentRow, rhsTextVal, eval("window.Row" + currentRow + ".RHSMode"));
        }


    }

    return false;
}

function IsOpenedFromA2() {
    wndw = window;
    var strE = wndw.external;
    var isFromWin;
    isFromWin = 'no';
    if (strE != null) {
        try {
            if (strE.toString().substring(0, 6) == "Skelta")
                isFromWin = 'yes';
        }
        catch (e) {
            isFromWin = 'no';
        }
    }
    return isFromWin;
}

function ProcessLHSClientEnter(textBox) {

    var currentRow = document.getElementById("hiddivNumber").value;
    var tableObject = document.getElementById("TableExpression" + currentRow);
    tableObject.className = "tab";

    var currentDivElement = "LHS" + currentRow;

    var divObj = document.getElementById(currentDivElement);

    var lhsTextActualVal = textBox.value;

    setLHSDivHtml(currentRow, textBox.value, "Default");


    //Creating New Row
    var nextRowHTML = AddRow(currentRow);
    if (nextRowHTML != "")
        document.getElementById("divExpressionLayers").innerHTML = document.getElementById("divExpressionLayers").innerHTML + nextRowHTML;

    setMHSDivHtml(currentRow, ((!isUndefined(eval("window.Row" + currentRow))) ? eval("window.Row" + currentRow + ".OPRColumn") : ""));


    if (isUndefined(eval("window.Row" + currentRow)))
        eval("window.Row" + currentRow + " =new VariableRow()");

    eval("window.Row" + currentRow + ".LHSColumn=lhsTextActualVal");

    if (!IsAddedToArray(currentRow)) {
        var inArrLen = InitialUpdatedVariableArray.length;
        InitialUpdatedVariableArray[inArrLen] = currentRow + "~" + "S";
    }

    setRHSDivHtml(currentRow, ((!isUndefined(eval("window.Row" + currentRow))) ? eval("window.Row" + currentRow + ".RHSColumn") : ""), ((!isUndefined(eval("window.Row" + currentRow))) ? eval("window.Row" + currentRow + ".RHSMode") : "Default"));


    setDivObjectTreeHtml(currentRow);


    //Hide the text box from LHS    
    txtLHSObj.style.display = "none";
}

function IsAddedToArray(rowNo) {
    var addedtoArray = false;
    for (var i = 0; i < InitialUpdatedVariableArray.length; i++) {
        if (InitialUpdatedVariableArray[i].indexOf(rowNo + "~" + "S") > -1) {
            addedtoArray = true;
            break;
        }
    }

    return addedtoArray;

}

function DeleteRow(currentRow) {

    var isRowExsts = true;
    oprComboObject.style.display = "none";
    inputLHSObj.style.display = "none";
    imageLHSObj.style.display = "none";
    hideRHSInputControl();

    if (document.getElementById("treeDiv").style.display != "none") {
        HideTreeView();
    }

    document.getElementById("divExpressionLayer" + currentRow).style.display = "none";

    InitialUpdatedVariableArray[currentRow - 1] = parseInt(currentRow) + "~" + "H";

    var prevRowsCount = currentRow - 1;

    for (var i = prevRowsCount; i > 0; i--) {
        if (document.getElementById("divExpressionLayer" + i) != null) {
            if (document.getElementById("divExpressionLayer" + i).style.display != "none") {
                isRowExsts = true;
                break;
            }
            else {
                isRowExsts = false;
            }
        }

    }


    if ((!isRowExsts) || (prevRowsCount == 0)) {
        if (document.getElementById("divExpressionLayer" + parseInt(currentRow + 1)) != null) {
            for (var i = parseInt(currentRow + 1); i <= InitialUpdatedVariableArray.length + 1; i++) {
                if (document.getElementById("divExpressionLayer" + i) != null) {
                    if (document.getElementById("divExpressionLayer" + i).style.display != "none") {
                        //var divOprv = document.getElementById("divlnkOPR"+i);
                        //divOprv.innerHTML="&nbsp;";
                        break;
                    }
                }
            }
        }
    }
}

function DisableNode(text) {
    var node = FindNodeByText(text);
    if (node != null)
        node.Disable();
}

function EnableNode(text) {
    var node = FindNodeByText(text);
    if (node != null)
        node.Enable();
}

function HandleChangeOperator(item) {
    var currentRow = document.getElementById("hiddivNumber").value;
    var currentDivElement = "DivRadCmb" + currentRow;
    var divObj = document.getElementById(currentDivElement);
    var selectedNodeTxt = "<A class=\"hyperText\" id=\"link" + currentRow + "\"    onmouseover=\"Javascript:alterLink(this," + currentRow + ",'OPR')\" onclick=\"Javascript:alterLink(this," + currentRow + ",'OPR')\" href=\"#\">" + DecodeTheExpressionString(item.Text) + "</A>";
    if (!isUndefined(eval("window.Row" + currentRow)))
        eval("window.Row" + currentRow + ".OPRColumn=item.Text");
    divObj.innerHTML = selectedNodeTxt;
    oprComboObject.style.display = "none";

}


function OpenEXPBuilder(curRow) {
    mode = "RHS";
    window.open(expbuilderURl + "&selRow=" + curRow + "&mode=" + mode + "&Src=UpdateVariable", "RHS" + curRow, 'width=840,height=488,resizable=yes,scrollbars=no,toolbars=0');
}

//Calculates the coordinates of the link control and places the specific element over there
//combo  - LHS  or MHS or RHS
function PositionObj(ctrl, combo) {
    var el = ctrl;
    var x = 0;
    var y = el.offsetHeight;

    //Walk up the DOM and add up all of the offset positions.
    while (el.offsetParent && el.tagName.toUpperCase() != 'BODY') {
        x += el.offsetLeft;
        y += el.offsetTop;
        el = el.offsetParent;
    }
    x += el.offsetLeft;
    y += el.offsetTop;

    var scrollTop = document.getElementById("divExpressionLayers").scrollTop;
    y = parseInt(y - scrollTop);

    var currentRow = document.getElementById("hiddivNumber").value;

    ValiderrCount = PlaceLinkforText();

    var result = validateRows(currentRow);

    if (result != false) {
        //
        inputLHSObj.value = "";

        if (combo == "LHS") {
            document.getElementById("cmbLHS").style.display = "block";



            if (!isUndefined(eval("window.Row" + currentRow))) {
                inputLHSObj.value = eval("window.Row" + currentRow + ".LHSColumn");
            }
            inputLHSObj.style.display = "block";
            inputLHSObj.style.left = x + 'px';
            inputLHSObj.style.top = (parseInt(y) - 15) + 'px';
            imageLHSObj.style.display = "block";
            imageLHSObj.style.left = x + inputLHSObj.offsetWidth + 'px';
            imageLHSObj.style.top = (parseInt(y) - 13) + 'px';
            oprComboObject.style.display = "none";
            txtRHSObj.style.display = "none";
        }
        else if (combo == "OPR") {
            if (document.getElementById(cmbOPRName + "Div") != null) {
                document.getElementById(cmbOPRName + "Div").style.display = "block";
            }
            else {
                document.getElementById(cmbOPRName).style.display = "block";
            }

            oprComboObject.style.display = "block";
            oprComboObject.style.left = (x - 10) + 'px';
            oprComboObject.style.top = (parseInt(y) - 15) + 'px';

            inputLHSObj.style.display = "none";
            imageLHSObj.style.display = "none";
            txtRHSObj.style.display = "none";

        }
        //
        if (combo == "RHS") {

            txtRHSObj.value = "";
            var RHSMode = "Default";

            if (isObjectTreeInUse)
                RHSMode = "ObjTree";

            if (!isUndefined(eval("window.Row" + currentRow)))
                RHSMode = eval("window.Row" + currentRow + ".RHSMode");

            if (RHSMode == "Default") {

                txtRHSObj.value = DecodeTheExpressionString(eval("window.Row" + currentRow + ".RHSColumn"));

                txtRHSObj.style.display = "block";

                txtRHSObj.style.left = (x) + 'px';
                txtRHSObj.style.top = (parseInt(y) - 15) + 'px';
                oprComboObject.style.display = "none";
                inputLHSObj.style.display = "none";
                imageLHSObj.style.display = "none";
            }
            else if (RHSMode == "Expression") {

                txtRHSObj.value = DecodeTheExpressionString(eval("window.Row" + currentRow + ".RHSColumn"));

                txtRHSObj.style.display = "block";
                txtRHSObj.style.left = x + 'px';
                txtRHSObj.style.top = (parseInt(y) - 15) + 'px';
                imageLHSObj.style.display = "block";
                imageLHSObj.style.left = x + txtRHSObj.offsetWidth + 'px';
                imageLHSObj.style.top = (parseInt(y) - 13) + 'px';
                oprComboObject.style.display = "none";
                inputLHSObj.style.display = "none";

            }
            else {
                document.getElementById("cmbLHS").style.display = "block";


                txtRHSObj.value = DecodeTheExpressionString(eval("window.Row" + currentRow + ".RHSColumn"));

                txtRHSObj.style.display = "block";

                txtRHSObj.style.left = x + 'px';
                txtRHSObj.style.top = (parseInt(y) - 15) + 'px';
                imageLHSObj.style.display = "block";
                imageLHSObj.style.left = x + txtRHSObj.offsetWidth + 'px';
                imageLHSObj.style.top = (parseInt(y) - 13) + 'px';
                oprComboObject.style.display = "none";
            }


        }



    }



}

function PositionObj1(ctrl, combo) {
    
    var currentRow = document.getElementById("hiddivNumber").value;

    ValiderrCount = PlaceLinkforText();

    var result = validateRows(currentRow);

    if (result != false) {
        var el = ctrl;
        var x = 0;
        var y = el.offsetHeight;

        //Walk up the DOM and add up all of the offset positions.
        while (el.offsetParent && el.tagName.toUpperCase() != 'BODY') {
            x += el.offsetLeft;
            y += el.offsetTop;
            el = el.offsetParent;
        }
        x += el.offsetLeft - 40;
        y += el.offsetTop - 33;

        var scrollTop = document.getElementById("divExpressionLayers").scrollTop;
        y = parseInt(y - scrollTop);

        //
        inputLHSObj.value = "";

        if (combo == "LHS") {
            oprComboObject.style.display = "none";
            hideRHSInputControl();

            if (!isUndefined(eval("window.Row" + currentRow))) {
                inputLHSObj.value = getDisplayTextForInputControl(eval("window.Row" + currentRow + ".LHSColumn"), true, eval("window.Row" + currentRow + ".LHSMode"));
            }
            if (lhsAllowValue == "True") {
                inputLHSObj.style.display = "none";
                imageLHSObj.style.display = "none";

                txtLHSObj.value = inputLHSObj.value;
                txtLHSObj.style.display = "block";
                txtLHSObj.style.left = x + 30 + 'px';
                txtLHSObj.style.top = (parseInt(y) + 14) + 'px';
            }
            else {
                txtLHSObj.style.display = "none";

                inputLHSObj.readOnly = true;
                inputLHSObj.style.display = "block";
                inputLHSObj.style.left = x + 30 + 'px';
                inputLHSObj.style.top = (parseInt(y) + 14) + 'px';
                imageLHSObj.style.display = "block";
                imageLHSObj.style.left = x + inputLHSObj.offsetWidth + 30 + 'px';
                imageLHSObj.style.top = (parseInt(y) + 16) + 'px';
            }
        }
        else if (combo == "OPR") {            
            inputLHSObj.style.display = "none";
            imageLHSObj.style.display = "none";
            hideRHSInputControl();

            if (document.getElementById(cmbOPRName + "Div") != null) {
                document.getElementById(cmbOPRName + "Div").style.display = "block";
            }
            else {
                document.getElementById(cmbOPRName).style.display = "block";
            }
            if (!isUndefined(eval("window.Row" + currentRow))) {
                
                if (eval("window.Row" + currentRow + ".OPRColumn") != "")
                {
                    oprComboObject.control.findItemByText(eval("window.Row" + currentRow + ".OPRColumn")).select();
                }               
            }

            oprComboObject.style.display = "block";
            oprComboObject.style.left = (x + 34) + 'px';
            oprComboObject.style.top = (parseInt(y) + 14) + 'px';
            oprComboObject.style.position = "absolute";
        }
        else if (combo == "RHS") {
            showRHSInputControl(currentRow, x, y);
        }
    }
}



function PlaceLinkforText(currentRow) {

    var errCount = 0;

    if (currentRow == null) {
        currentRow = prevRow;
    }
    else {
        currentRow = currentRow;
    }

    if (currentRow != 0) {
        if (trim(getRHSDivElement(currentRow).innerHTML) != "") {
            var rhsValue = getRHSInputControlValue(currentRow);

            if (trim(rhsValue) != "") {
                if (!isUndefined(eval("window.Row" + currentRow))) {
                    setRHSDivHtml(currentRow, rhsValue, "Default");

                    cmbMode = "RHS";
                    eval("window.Row" + currentRow + ".RHSColumn=rhsValue");
                    hideRHSInputControl();
                    errCount = 0;
                    prevRow = 0;
                }
            }

            var rhsVal = eval("window.Row" + currentRow + ".RHSColumn");
            var lhsVal = eval("window.Row" + currentRow + ".LHSColumn");
            var mhsVal = eval("window.Row" + currentRow + ".OPRColumn");

            if (mhsVal == "<##>" && rhsVal.indexOf("XmlVariables.") == -1) {
                errCount = 1;
            }
        }

        clearRHSInputControlValue();
        prevRow = 0;
    }

    return errCount;
}

function DisplayObjectTree(curRow) {
    HideTreeView();
    Maximize(false, 0);
    hideRHSInputControl();

    var currentRHSMode = eval("window.Row" + curRow + ".RHSMode");

    if (currentRHSMode == "Default") {
        eval("window.Row" + curRow + ".RHSMode='ObjTree'");
    }

    var rhsLinkObj = document.getElementById("rhsLink" + curRow);

    objTreeRHSMode = 1;

    objTreeLHSMode = 0;

    var x = findPosX(rhsLinkObj) - 10;
    var y = findPosY(rhsLinkObj) + 1 - document.getElementById("divExpressionLayers").scrollTop;

    showRHSInputControl(curRow, x - 30, y - 18);

    document.getElementById("hiddivNumber").value = curRow;
    mode = "RHS";

    isObjectTreeInUse = true;
}

function ToggleTreeView() {
    //HideAlttext(this);
    if (mode == "LHS") {
        if (document.getElementById("treeDiv").style.display != "none") {
            Maximize(false, 0);
            HideTreeView();
        }
        else {
            ShowTreeView();
            Maximize(true, 0);
        }
    }
    else {
        if (document.getElementById("RHSTreeDiv").style.display != "none") {
            Maximize(false, 0);
            HideTreeView();
        }
        else {
            ShowTreeView();
            Maximize(true, 0);
        }
    }
}

function ShowTreeView() {
    if (mode == "LHS") {
        document.getElementById("treeDiv").style.display = "block";

        var x = findPosX(inputLHSObj);
        var y = findPosY(inputLHSObj);
        // y = y - document.getElementById("divExpressionLayers").scrollTop;
        var n = 0;
        n = document.getElementById("divExpressionLayers").scrollTop;
        var divHeight = document.getElementById("treeDiv").style.height;
        divHeight = divHeight.substring(0, divHeight.length - 2);
        var TempHeight = divHeight;
        divHeight = divHeight - n;
        if ((document.body.offsetHeight - y) < parseInt(TempHeight)) {
            var newTop = parseInt(y) - parseInt(TempHeight); //Fix for not able to see treediv after 19 variables since divheight value is negative  newTop is always increasing.So changed to TempHeight
            document.getElementById("treeDiv").style.left = x + "px";
            document.getElementById("treeDiv").style.top = (parseInt(newTop)) + "px";
        }
        else {
            document.getElementById("treeDiv").style.left = x + "px";
            document.getElementById("treeDiv").style.top = (parseInt(y) + 18) + "px";
        }
    }
    else {
        document.getElementById("RHSTreeDiv").style.display = "block";
        var x = findPosX(txtRHSObj);
        var y = findPosY(txtRHSObj);
        var n = 0;
        n = document.getElementById("divExpressionLayers").scrollTop;
        var divHeight = document.getElementById("RHSTreeDiv").style.height;
        divHeight = divHeight.substring(0, divHeight.length - 2);
        var TempHeight = divHeight;
        divHeight = divHeight - n;
        //y = y - document.getElementById("divExpressionLayers").scrollTop;

        if ((document.body.offsetHeight - y) < parseInt(TempHeight)) {
            var newTop = parseInt(y) - parseInt(TempHeight); //Fix for not able to see treediv after 19 variables since divheight value is negative  newTop is always increasing.So changed to TempHeight
            document.getElementById("RHSTreeDiv").style.left = x + "px";
            document.getElementById("RHSTreeDiv").style.top = (parseInt(newTop)) + "px";
        }
        else {
            document.getElementById("RHSTreeDiv").style.left = x + "px";
            document.getElementById("RHSTreeDiv").style.top = (parseInt(y) + 18) + "px";
        }
    }
}

function HideTreeView() {
    if (mode == "LHS") {
        document.getElementById("treeDiv").style.display = "none";
    }
    else if (mode == "RHS") {
        document.getElementById("RHSTreeDiv").style.display = "none";
    }
}


function AddRow(currentRow) {
    var nextRow = parseInt(currentRow) + 1;
    var nextRowDivObj = document.getElementById("divExpressionLayer" + nextRow);
    var inHTMl = "";

    if (nextRowDivObj == null) {
        //alert(nextrow % 2);

        inHTMl = "<div id=\"divExpressionLayer" + nextRow + "\" style=\"width:100%;\">";
        if (parseInt(currentRow) % 2 == 0) {
            inHTMl = inHTMl + "<table width=\"100%\" cellspacing=2 cellpadding=0 border=0 style=\"height:40px;background-color:#f1f1f1\">";
        }
        else {
            inHTMl = inHTMl + "<table width=\"100%\" cellspacing=2 cellpadding=0 border=0 style=\"height:40px;background-color:#e0e1dd\">";
        }
        inHTMl = inHTMl + "<tr>";
        inHTMl = inHTMl + "<td width=\"100%\" class=\"\"> ";
        inHTMl = inHTMl + "<table width=\"100%\" id=\"TableExpression" + nextRow + "\"  border=0 cellspacing=0 cellpadding=6 class=\"tabInitial\">";
        inHTMl = inHTMl + "<tr>";
        inHTMl = inHTMl + "<td>";
        inHTMl = inHTMl + "<table width=100% cellspacing=0 cellpadding=0 border=0>";
        inHTMl = inHTMl + "<tr>";

        if (lhsAllowValue == "True") {
            inHTMl = inHTMl + "<td style=\"width: 36%;padding-left:10px\" class=\"description\"> <div id=\"LHS" + nextRow + "\" style=\"DISPLAY: inline;width:130px; \"><A class=\"GridHyperlinkStyle\" id=\"link" + nextRow + "\" onmouseover=\"Javascript:alterLinkEnter(this," + nextRow + ",'LHS')\" onclick=\"Javascript:alterLinkEnter(this," + nextRow + ",'LHS')\" href=\"#\">" + CAP_EnterValue + "</A></DIV></td>";
            //txtLHSObj.value="";
        }
        else {
            inHTMl = inHTMl + "<td style=\"width: 36%;padding-left:10px\" class=\"description\"> <div id=\"LHS" + nextRow + "\" style=\"DISPLAY: inline;width:130px; \"><A class=\"GridHyperlinkStyle\" id=\"link" + nextRow + "\" onmouseover=\"Javascript:alterLinkSelect(this," + nextRow + ",'LHS')\" onclick=\"Javascript:alterLinkSelect(this," + nextRow + ",'LHS')\" href=\"#\">" + CAP_Select + "</A></DIV></td>";
        }
        inHTMl = inHTMl + "<td width=20% class=\"description\"><div id=\"MHS" + nextRow + "\" style=\"DISPLAY: inline;width:50px \">&nbsp;</DIV></td>";
        inHTMl = inHTMl + "<td width=33% class=\"description\"><div id=\"RHS" + nextRow + "\" style=\"DISPLAY: inline;width:130px\">&nbsp;</div></td>";
        inHTMl = inHTMl + "<td width=9% class=\"description\"><div id=\"DivObjectTree" + nextRow + "\" style=\"DISPLAY: inline;width:40px\">&nbsp;</div></td>";
        inHTMl = inHTMl + "</tr>";
        inHTMl = inHTMl + "</table>";
        inHTMl = inHTMl + "</td>";
        inHTMl = inHTMl + "</tr>";
        inHTMl = inHTMl + "</table>";
        inHTMl = inHTMl + "</td>";
        inHTMl = inHTMl + "</tr> ";
        inHTMl = inHTMl + "</table>";
        inHTMl = inHTMl + "</div>";
    }
    return inHTMl;
}


function ShowUpdateRow(currentRow) {
    var currentRow = parseInt(currentRow);
    var currentRowDivObj = document.getElementById("divExpressionLayer" + currentRow);
    var inHTMl = "";

    if (currentRowDivObj == null) {
        inHTMl = "<div id=\"divExpressionLayer" + currentRow + "\" style=\"width:710px;\">";
        inHTMl = inHTMl + "<table width=\"100%\" cellspacing=2 cellpadding=0 border=0>";
        inHTMl = inHTMl + "<tr>";
        inHTMl = inHTMl + "<td width=\"100%\" class=\"rowbg\"> ";
        inHTMl = inHTMl + "<table width=\"100%\" id=\"TableExpression" + currentRow + "\"  border=0 cellspacing=0 cellpadding=6 class=\"tabInitial\">";
        inHTMl = inHTMl + "<tr>";
        inHTMl = inHTMl + "<td colspan=4 align=\"left\" class=\"rowbg\">";
        inHTMl = inHTMl + "<table width=100% cellspacing=0 cellpadding=0 border=0>";
        inHTMl = inHTMl + "<tr>";

        inHTMl = inHTMl + "<td width=7% class=\"ContentText\">&nbsp;</td>";
        inHTMl = inHTMl + "<td width=40% class=\"ContentText\"> <div id=\"LHS" + currentRow + "\" style=\"DISPLAY: inline;width:130px; \"><A class=\"hyperText\" id=\"link" + currentRow + "\" onmouseover=\"Javascript:alterLinkSelect(this," + currentRow + ",'LHS')\" onclick=\"Javascript:alterLinkSelect(this," + currentRow + ",'LHS')\" href=\"#\">" + CAP_Select + "</A></DIV></td>";
        inHTMl = inHTMl + "<td width=5% class=\"ContentText\"><div id=\"MHS" + currentRow + "\" style=\"DISPLAY: inline;width:50px \">&nbsp;</DIV></td>";
        inHTMl = inHTMl + "<td width=41% class=\"ContentText\"><div id=\"RHS" + currentRow + "\" style=\"DISPLAY: inline;width:130px\">&nbsp;</div></td>";
        inHTMl = inHTMl + "<td width=7% class=\"ContentText\"><div id=\"DivObjectTree" + currentRow + "\" style=\"DISPLAY: inline;width:40px\">&nbsp;</div></td>";
        inHTMl = inHTMl + "</tr>";
        inHTMl = inHTMl + "</table>";
        inHTMl = inHTMl + "</td>";
        inHTMl = inHTMl + "</tr>";
        inHTMl = inHTMl + "</table>";
        inHTMl = inHTMl + "</td>";
        inHTMl = inHTMl + "</tr> ";
        inHTMl = inHTMl + "</table>";
        inHTMl = inHTMl + "</div>";
    }
    return inHTMl;
}

function ShowAlttext(textObject) {//;
    var altText = "";

    if (textObject.GetWrapperElement) {
        textObject = textObject.GetWrapperElement();
    }

    var x = findPosX(textObject);
    var y = findPosY(textObject);
    //if(forcheck==1) 
    bubbleWindowObj.style.left = parseInt(x) + 10 + 'px';
    bubbleWindowObj.style.top = parseInt(y) + 30 + 'px';
    bubbleWindowObj.style.display = "block";

    var currentRow = document.getElementById("hiddivNumber").value;

    if (!isUndefined(eval("window.Row" + currentRow))) {
        //if(HSmode =="L")
        if (mode == "LHS") {
            var lhsMode = eval("window.Row" + currentRow + ".LHSMode");
            if (lhsMode == "Default") {
                altText = getDisplayTextForInputControl(eval("window.Row" + currentRow + ".LHSColumn"), true, lhsMode);
            }
            else if (lhsMode == "Expression") {
                altText = getDisplayTextForInputControl(eval("window.Row" + currentRow + ".ColumnExpression.DisplayExpressionString"), true, lhsMode);
            }
            else {
                altText = getDisplayTextForInputControl(eval("window.Row" + currentRow + ".LHSColumn"), true, lhsMode);
            }
        }

        if (mode == "RHS") {
            var rhsMode = eval("window.Row" + currentRow + ".RHSMode");
            if (rhsMode == "Default") {
                altText = getDisplayTextForInputControl(eval("window.Row" + currentRow + ".RHSColumn"), false, rhsMode, currentRow);
            }
            else if (rhsMode == "Expression") {
                altText = getDisplayTextForInputControl(eval("window.Row" + currentRow + ".ColumnExpression.DisplayExpressionString"), false, rhsMode);
            }
            else {
                altText = getDisplayTextForInputControl(eval("window.Row" + currentRow + ".RHSColumn"), false, rhsMode);
            }
        }
    }

    if (trim(altText) == "") {
        if (mode == "RHS" && rhsMode == "Default") {
            altText = conditionEnterValueLocal;
        }

        if (trim(altText) == "") {
            altText = conditionSelectLocal;
        }
    }

    if (altText.length > 35) {
        var count = altText.length / 35;
        count = Math.floor(count);
        var newAltText = "";

        for (i = 1; i <= count; i++) {
            newAltText += escapeHTML(altText.substr((i - 1) * 35, 35));
            if (altText.length > (i * 35)) {
                newAltText += "<br>";
            }
        }

        if (altText.length > ((i - 1) * 35)) {
            newAltText += escapeHTML(altText.substr((i - 1) * 35));
        }

        altText = newAltText;
    }
    else {
        altText = escapeHTML(altText);
    }

    bubbleWindowObj.innerHTML = altText;
}


function HideAlttext() {

    //divbubbleObj = document.getElementById("bubbleDiv");
    bubbleWindowObj.innerHTML = "";
    bubbleWindowObj.style.display = "none";

}

function ChangeRHSMODE() {
    if (prevRow == 0) {
        prevRow = document.getElementById("hiddivNumber").value;
    }
}


function findPosX(obj) {
    var curleft = 0;

    if (obj.offsetParent) {
        while (obj.offsetParent) {
            curleft += obj.offsetLeft
            obj = obj.offsetParent;
        }
    }

    else if (obj.x)
        curleft += obj.x;

    return curleft;
}
function findPosY(obj) {
    var curtop = 0;
    if (obj.offsetParent) {
        while (obj.offsetParent) {
            curtop += obj.offsetTop
            obj = obj.offsetParent;
        }
    }
    else if (obj.y)
        curtop += obj.y;
    return curtop;
}


function ltrim(s) {
    try {
        return s.replace(/^\s*/, "");
    }
    catch (e) {
        return s;
    }
}

function rtrim(s) {
    try {
        return s.replace(/\s*$/, "");
    }
    catch (e) {
        return s;
    }
}

function trim(s) {
    return rtrim(ltrim(s));
}

function ValidateFields() {

    var errCount = 0;
    for (var i = 1; i < InitialUpdatedVariableArray.length + 1; i++) {
        if (document.getElementById("divExpressionLayer" + i) != null) {
            if (document.getElementById("divExpressionLayer" + i).style.display != "none") {
                if (eval("window.Row" + i + ".RHSMode") == "Default") {
                    if (trim(eval("window.Row" + i + ".RHSValue")) == "") {
                        if (eval("window.Row" + i + ".IsRHSExists==true")) {
                            se.ui.messageDialog.showError(bellybarTitle, ConditionPlsEnterValueLocal);
                            var rhsLinkObj = document.getElementById("rhsLink" + i);
                            if (rhsLinkObj != null)
                                alterLink(rhsLinkObj, i, 'RHS');

                            setFocusOnControl("Default", getInputDataTypeForRow(i));

                            errCount = 1;
                            break;
                        }

                    }
                }
            }
        }
    }
    return errCount;
}

function Maximize(flag, val) {
    xLHS = findPosX(document.getElementById("treeDiv"));
    yLHS = (parseInt(findPosY(document.getElementById("treeDiv"))) + 3) + "px";
    xRHS = findPosX(document.getElementById("RHSTreeDiv"));
    yRHS = (parseInt(findPosY(document.getElementById("RHSTreeDiv"))) + 3) + "px";
    var maxed = "NO";
    var iframeObjBubble = document.getElementById("IframeShimForBubble");
    objLHSRadDiv = document.getElementById("treeDiv");
    objLHSRadTree = document.getElementById("RadTree1");
    objRHSRadDiv = document.getElementById("RHSTreeDiv");
    objRHSRadTree = document.getElementById("RadTree2");

    if (flag == true) {
        if (mode == "LHS") {
            if (objLHSRadDiv.style.height != 317 + 'px' && objLHSRadDiv.style.width != 550 + 'px') {
                document.getElementById("HidX").value = xLHS;
                document.getElementById("HidY").value = yLHS;

                objLHSRadDiv.style.height = 317 + 'px';
                objLHSRadDiv.style.width = 550 + 'px';
                var Temp = 300 + 'px';

                objLHSRadDiv.style.top = document.body.style.top + 130;
                objLHSRadDiv.style.left = document.body.style.left + 20;
                objLHSRadTree.style.top = document.body.style.top + 130;
                objLHSRadTree.style.left = document.body.style.left + 20;
                objLHSRadTree.style.height = Temp;//objLHSRadDiv.style.height;
                objLHSRadTree.style.width = objLHSRadDiv.style.width;
            }
        }
        else {
            if (objRHSRadDiv.style.height != 317 + 'px' && objRHSRadDiv.style.width != 550 + 'px') {
                document.getElementById("HidXRHS").value = xRHS;
                document.getElementById("HidYRHS").value = yRHS;

                objRHSRadDiv.style.height = 317 + 'px';
                objRHSRadDiv.style.width = 550 + 'px';
                var Temp = 300 + 'px';
                iframeObjBubble.style.display = "block";

                objRHSRadDiv.style.top = document.body.style.top + 130;
                objRHSRadDiv.style.left = document.body.style.left + 165;
                objRHSRadTree.style.top = document.body.style.top + 130;
                objRHSRadTree.style.left = document.body.style.left + 165;

                objRHSRadTree.style.height = Temp;//objRHSRadDiv.style.height;
                objRHSRadTree.style.width = objRHSRadDiv.style.width;
                objRHSRadDiv.style.zIndex = 10;

                iframeObjBubble.style.width = objRHSRadDiv.offsetWidth;
                iframeObjBubble.style.height = objRHSRadDiv.offsetHeight;
                iframeObjBubble.style.top = objRHSRadDiv.style.top;
                iframeObjBubble.style.left = objRHSRadDiv.style.left;
                iframeObjBubble.style.zIndex = objRHSRadDiv.style.zIndex - 1;
                iframeObjBubble.style.display = "block";
            }
        }
    }
    else {
        if (mode == "LHS") {
            if (objLHSRadDiv.style.height != 167 + 'px' && objLHSRadDiv.style.width != 272 + 'px') {
                objLHSRadDiv.style.height = 167 + 'px';
                objLHSRadDiv.style.width = 272 + 'px';
                var Temp = 150 + 'px';
                objLHSRadDiv.style.top = document.getElementById("HidY").value;
                objLHSRadDiv.style.left = document.getElementById("HidX").value;
                objLHSRadTree.style.top = document.getElementById("HidY").value;
                objLHSRadTree.style.left = document.getElementById("HidX").value;

                objLHSRadTree.style.height = Temp;//objLHSRadDiv.style.height;
                objLHSRadTree.style.width = objLHSRadDiv.style.width;
            }

        }
        else {
            if (objRHSRadDiv.style.height != 167 + 'px' && objRHSRadDiv.style.width != 272 + 'px') {
                iframeObjBubble.style.display = "none";
                objRHSRadDiv.style.height = 167 + 'px';
                objRHSRadDiv.style.width = 272 + 'px';
                var Temp = 150 + 'px';
                objRHSRadDiv.style.top = document.getElementById("HidYRHS").value;
                objRHSRadDiv.style.left = document.getElementById("HidXRHS").value;
                objRHSRadTree.style.top = document.getElementById("HidYRHS").value;
                objRHSRadTree.style.left = document.getElementById("HidXRHS").value;

                objRHSRadTree.style.height = Temp;//objRHSRadDiv.style.height;
                objRHSRadTree.style.width = objRHSRadDiv.style.width;
            }
        }


    }
}


function EncodeTheExpressionString(expressionString) {
    if (expressionString != null) {
        if (expressionString.indexOf("+") > -1) {
            expressionString = replaceExpressionstring(expressionString, "+", "_x002B_")
        }
        if (expressionString.indexOf("-") > -1) {
            expressionString = replaceExpressionstring(expressionString, "-", "_x002D_")
        }
        if (expressionString.indexOf("/") > -1) {
            expressionString = replaceExpressionstring(expressionString, "/", "_x002F_")
        }
    }
    return expressionString;
}


function DecodeTheExpressionString(expressionString) {
    if (expressionString != null) {
        if (expressionString.indexOf("_x002B_") > -1) {
            expressionString = replaceExpressionstring(expressionString, "_x002B_", "+")
        }
        if (expressionString.indexOf("_x002D_") > -1) {
            expressionString = replaceExpressionstring(expressionString, "_x002D_", "-")
        }
        if (expressionString.indexOf("_x002F_") > -1) {
            expressionString = replaceExpressionstring(expressionString, "_x002F_", "/")
        }
    }
    return expressionString;
}


function replaceExpressionstring(stringtobereplaced, chartobereplaced, charbywhichreplaced) {
    var out = "";
    if (stringtobereplaced == null) return;

    stringtobereplaced = stringtobereplaced.replace(chartobereplaced, charbywhichreplaced);

    if (stringtobereplaced.indexOf(chartobereplaced) > -1) {

        stringtobereplaced = replaceExpressionstring(stringtobereplaced, chartobereplaced, charbywhichreplaced);
    }

    return stringtobereplaced;
}

function TruncateString(TrunStr) {
    TrunStr = TrunStr.replace('~', '');
    TrunStr = TrunStr.replace('`', '');
    TrunStr = TrunStr.replace('!', '');
    TrunStr = TrunStr.replace('@', '');
    TrunStr = TrunStr.replace('#', '');
    TrunStr = TrunStr.replace('$', '');
    TrunStr = TrunStr.replace('%', '');
    TrunStr = TrunStr.replace('^', '');
    TrunStr = TrunStr.replace('&', '');
    TrunStr = TrunStr.replace('(', '');
    TrunStr = TrunStr.replace(')', '');
    TrunStr = TrunStr.replace('[', '');
    TrunStr = TrunStr.replace(']', '');
    TrunStr = TrunStr.replace('|', '');
    TrunStr = TrunStr.replace('{', '');
    TrunStr = TrunStr.replace('}', '');
    TrunStr = TrunStr.replace(':', '');
    TrunStr = TrunStr.replace(';', '');
    TrunStr = TrunStr.replace(',', '');
    TrunStr = TrunStr.replace('=', '');
    TrunStr = TrunStr.replace('?', '');
    TrunStr = TrunStr.replace(' ', '');
    TrunStr = TrunStr.replace('+', '');
    TrunStr = TrunStr.replace('-', '');
    TrunStr = TrunStr.replace('*', '');
    TrunStr = TrunStr.replace('/', '');
    TrunStr = TrunStr.replace('\\', '');

    return TrunStr;
}

function escapeHTML(str) {
    var div = document.createElement('div');
    var text = document.createTextNode(str);
    div.appendChild(text); return div.innerHTML;
}


function getLHSDivElement(row) {
    return document.getElementById("LHS" + row);
}

function setLHSDivHtml(row, coreValue, lhsMode) {
    getLHSDivElement(row).innerHTML = "<A class=\"hyperText\" id=\"link" + row + "\" onmouseover=\"Javascript:alterLink(this," + row + ",'LHS')\" onclick=\"Javascript:alterLink(this," + row + ",'LHS')\" href=\"#\">" + getDisplayText(coreValue, true, lhsMode) + "</A>" + "&nbsp;";
}

function getMHSDivElement(row) {
    return document.getElementById("MHS" + row);
}

function setMHSDivHtml(row, coreValue) {
    getMHSDivElement(row).innerHTML = "<A class=\"hyperText\" id=\"link" + row + "\"   onmouseover=\"Javascript:alterLink(this," + row + ",'OPR')\" onclick=\"Javascript:alterLink(this," + row + ",'OPR')\" href=\"#\">" + getDisplayTextForMHS(coreValue) + "</A>";
}

function getRHSDivElement(row) {
    return document.getElementById("RHS" + row);
}

function setRHSDivHtml(row, coreValue, rhsMode) {
    getRHSDivElement(row).innerHTML = "<A class=\"hyperText\" id=\"rhsLink" + row + "\"   onmouseover=\"Javascript:alterLink(this," + row + ",'RHS')\" onclick=\"Javascript:alterLink(this," + row + ",'RHS')\" href=\"#\">" + getDisplayText(coreValue, false, rhsMode, row) + "</A>";
}

function setDivObjectTreeHtml(row) {
    document.getElementById("DivObjectTree" + row).innerHTML = "<a href=\"#\"><img id=\"ObjImage" + row + "\" src='" + objectTreeImg + "' alt='" + ConditionObjTreeLocal + "' border=0 onclick=\"javascript:DisplayObjectTree(" + row + ")\"></a>&nbsp;&nbsp;<a href=\"#\"><img id=\"DelImage" + row + "\" alt='" + ConditionDeleteLocal + "' title='" + ConditionDeleteLocal + "' src='" + delteRowImg + "' border=0 onclick=\"javascript:DeleteRow(" + row + ")\"></a>";
}

function getDisplayTextFromVariableTree(coreValue, isLHS) {
     if ((coreValue.substring(0, 9) === "Variable.")
        || (coreValue.substring(0, 13) === "XmlVariables.")
        || (coreValue.substring(0, 8) === "Content.")
        || (coreValue.substring(0, 10) === "Parameter.")) {
        var tree = ((isLHS === true) ? $find(radTreeLHSClientId) : $find(radTreeRHSClientId));
        var node = tree.findNodeByValue(coreValue);

        if (node !== null) {
            if (coreValue.substring(0, 13) === "XmlVariables.") {

                var retVal = node.get_text(),
                    tempNode = node.get_parent();

                while (tempNode != null) {

                    if (tempNode.get_parent() != null) {
                        if (!tempNode.get_text)
                            break;
                        retVal = tempNode.get_text() + "." + retVal;
                    }
                  
                     tempNode = tempNode.get_parent();                  
                }

                return retVal;
            }

            return node.get_text();
        }
    }

    return coreValue;
}

function getDisplayTextForRHS(mode, row, coreValue) {
    if (trim(coreValue) == "") {
        return "";
    }

    var dataType = getInputDataTypeForRow(row);

    if (mode == "Default") {
        if (isNumberDataType(dataType)) {
            return numberUtil.getNumberDisplayText(coreValue, doesNumberHasDecimalPlaces(dataType));
        }
        else if (isDateTimeDataType(dataType)) {
            switch (dataType) {
                case "DATE":
                    return dateTimeUtil.getDisplayTextFromInvariantStringValue(coreValue, true);
                    break;
                case "TIME":
                    return dateTimeUtil.getDisplayTextFromInvariantStringValue(coreValue, false, true);
                    break;
                case "DATETIME":
                    return dateTimeUtil.getDisplayTextFromInvariantStringValue(coreValue);
                    break;
            }
        }
    }

    return getDisplayTextFromVariableTree(coreValue, false);
}

function getDisplayText(coreValue, isLHS, mode, row) {
    var displayText = "";

    if (mode == "Default" && !isLHS) {
        displayText = getDisplayTextForRHS(mode, row, coreValue);
    }
    else {
        displayText = getDisplayTextFromVariableTree(coreValue, isLHS);
    }

    if (isLHS !== true) {
        if (displayText == "") {
            return escapeHTML(CAP_EnterValue);
        }
    }

    if (mode === "Expression") {
        displayText = DecodeTheExpressionString(displayText);
    }

    var displayLength = displayText.length;

    if (displayLength > 32) {
        if (coreValue.substring(0, 9) == "Variable.") {
            displayText = displayText.substring(0, 3) + ".." + displayText.substring(displayLength - 28, displayLength);

        }
        else if (coreValue.substring(0, 13) == "XmlVariables.") {
            displayText = displayText.substring(0, 6) + ".." + displayText.substring(displayLength - 25, displayLength);

        }
        else {
            displayText = displayText.substring(0, 6) + ".." + displayText.substring(displayLength - 24, displayLength);
        }

    }

    return escapeHTML(displayText);
}

function getDisplayTextForInputControl(coreValue, isLHS, mode, row) {
    var displayText = "";

    if (mode == "Default" && !isLHS) {
        displayText = getDisplayTextForRHS(mode, row, coreValue);
    }
    else {
        displayText = getDisplayTextFromVariableTree(coreValue, isLHS);
    }

    if (mode === "Expression") {
        displayText = DecodeTheExpressionString(displayText);
    }

    return displayText;
}

function getDisplayTextForMHS(coreValue) {
    var displayText = "=";

    if (coreValue !== "") {
        displayText = coreValue;
    }

    return displayText;
}

function isUndefined(obj) {
    return ((typeof obj === "undefined") || (obj == null));
}

function isNumberDataType(dataType) {
    switch (dataType) {
        case "NUMBER":
        case "INTEGER":
        case "FLOAT":
        case "LONG":
        case "DOUBLE":
        case "DECIMAL":
            return true;
    }

    return false;
}

function doesNumberHasDecimalPlaces(dataType) {
    switch (dataType) {
        case "NUMBER":
        case "INTEGER":
            return false;
    }

    return true;
}

function isDateTimeDataType(dataType) {
    switch (dataType) {
        case "DATE":
        case "TIME":
        case "DATETIME":
            return true;
    }

    return false;
}

function getInputDataTypeForRow(row) {
    try {
        var treeObj = $find(radTreeLHSClientId).findNodeByValue(eval("window.Row" + row + ".LHSColumn")).get_attributes();
        var variableDataType = treeObj.getAttribute("datatype");
        return variableDataType ;
    }
    catch (e) {
        return "STRING";
    }
}

function InitializeKendoControls() {

    // Set the kendo culture as per the server culture for all kendo widgets.
    kendo.culture(UI_CULTURE);

    dateTimeUtil.InvariantShortDateFormat = INVARIANT_CULTURE_DATE_FORMAT;
    dateTimeUtil.InvariantLongTimeFormat = INVARIANT_CULTURE_TIME_LONG_FORMAT;

    dateTimeUtil.LocaleShortDateFormat = UI_CULTURE_DATE_FORMAT;
    dateTimeUtil.LocaleLongTimeFormat = UI_CULTURE_TIME_LONG_FORMAT;

    InitializeKendoNumberControl();
    InitializeKendoDateControl();
    InitializeKendoTimeControl();
    InitializeKendoDateTimeControl();
}

function InitializeKendoNumberControl() {
    // create NumericTextBox from input HTML element
    $("#txtRHSNumber").kendoNumericTextBox({
        format: "#.#########",
        decimals: 9,
        placeholder: PLACEHOLDER_MSG_NUMBER.replace("<@samplevalue@>", numberUtil.getLocaleStringFromNumber(1234.78, true)),
        upArrowText: CAP_INCREASE_VALUE,
        downArrowText: CAP_DECREASE_VALUE,
        spinners: true,
        spin: ChangeRHSMODE
    });

    radRHSNumberCoreObj = $('#txtRHSNumber').data("kendoNumericTextBox");
    radRHSNumberControlObj = radRHSNumberCoreObj.wrapper[0];

    InitializeKendoCommonSettings(radRHSNumberCoreObj, radRHSNumberControlObj);
}

function ReinitializeKendoNumberControlBasedOnDataType(dataType) {
    if (isNumberDataType(dataType)) {
        var placeHolderText = "";

        if (doesNumberHasDecimalPlaces(dataType)) {
            radRHSNumberCoreObj.options.format = "#,.#########";
            radRHSNumberCoreObj.options.decimals = 9;
            placeHolderText = PLACEHOLDER_MSG_NUMBER.replace("<@samplevalue@>", numberUtil.getLocaleStringFromNumber(1234.78, true));
        }
        else {
            radRHSNumberCoreObj.options.format = "n0";
            radRHSNumberCoreObj.options.decimals = 0;
            placeHolderText = PLACEHOLDER_MSG_NUMBER.replace("<@samplevalue@>", numberUtil.getLocaleStringFromNumber(1234, false));
        }

        if (placeHolderText !== radRHSNumberCoreObj.options.placeholder) {
            radRHSNumberCoreObj.options.placeholder = placeHolderText;
            radRHSNumberCoreObj._text.prop("placeholder", placeHolderText);
        }
    }
}

function InitializeKendoDateControl() {
    // create Kendo Date from input HTML element
    $("#txtRHSDate").kendoDatePicker({
        format: UI_CULTURE_DATE_FORMAT,
        open: ChangeRHSMODE
    });

    radRHSDateCoreObj = $("#txtRHSDate").data("kendoDatePicker");
    radRHSDateControlObj = radRHSDateCoreObj.wrapper[0];

    InitializeKendoCommonSettings(radRHSDateCoreObj, radRHSDateControlObj);
    InitializeKendoDateTimePickerCommonSettings(radRHSDateCoreObj);
}

function InitializeKendoTimeControl() {
    // create Kendo Time from input HTML element
    $("#txtRHSTime").kendoTimePicker({
        format: UI_CULTURE_TIME_LONG_FORMAT,
        timeFormat: UI_CULTURE_TIME_SHORT_FORMAT,
        open: ChangeRHSMODE
    });

    radRHSTimeCoreObj = $("#txtRHSTime").data("kendoTimePicker");
    radRHSTimeControlObj = radRHSTimeCoreObj.wrapper[0];

    InitializeKendoCommonSettings(radRHSTimeCoreObj, radRHSTimeControlObj);
    InitializeKendoDateTimePickerCommonSettings(radRHSTimeCoreObj);
}

function InitializeKendoDateTimeControl() {
    // create Kendo DateTime from input HTML element
    $("#txtRHSDateTime").kendoDateTimePicker({
        format: UI_CULTURE_DATE_FORMAT + " " + UI_CULTURE_TIME_LONG_FORMAT,
        timeFormat: UI_CULTURE_TIME_SHORT_FORMAT,
        open: ChangeRHSMODE
    });

    radRHSDateTimeCoreObj = $("#txtRHSDateTime").data("kendoDateTimePicker");
    radRHSDateTimeControlObj = radRHSDateTimeCoreObj.wrapper[0];

    InitializeKendoCommonSettings(radRHSDateTimeCoreObj, radRHSDateTimeControlObj);
    InitializeKendoDateTimePickerCommonSettings(radRHSDateTimeCoreObj);
}

function InitializeKendoCommonSettings(kendoCoreObj, kendoControlObj) {
    kendoControlObj.style.position = "absolute";
    kendoCoreObj.wrapper.mouseenter(function () { ShowAlttext(this); });
    kendoCoreObj.wrapper.mouseleave(function () { HideAlttext(this); });
}

function InitializeKendoDateTimePickerCommonSettings(kendoCoreObj) {
    //
    // NOTE: { Rupesh M. Kokal : 28-Nov-2014 }
    // Since there is no updation of value when we change the value of the date/time picker via keyboard
    // and hover out of the control to some other control without selecting anything else in the date/time
    // picker control. Hence we have created a SK_UpdateChanges method, which helps us resolve the issue.
    //
    kendoCoreObj.SK_UpdateChanges = function () {
        var that = this,
            value = that.element.val();
        if (value !== that._oldText) {
            that._change(value);
        }
    };

    if (!isUndefined(kendoCoreObj.dateView)) {
        // In case of Date Picker and DateTime Picker control, the date picker control is represented by _dateIcon.
        kendoCoreObj._dateIcon.prop("title", CAL_TOOLTIP_DateButton);
    }

    if (!isUndefined(kendoCoreObj.timeView)) {
        // In case of DateTime Picker control, the time picker control is represented by _timeIcon.
        if (!isUndefined(kendoCoreObj._timeIcon)) {
            kendoCoreObj._timeIcon.prop("title", CAL_TOOLTIP_TimeButton);
        }

        // In case of Time Picker control, the picker control is represented by _arrow.
        if (!isUndefined(kendoCoreObj._arrow)) {
            kendoCoreObj._arrow.prop("title", CAL_TOOLTIP_TimeButton);
        }
    }
}

function InitializeRHSInputControls() {
    txtRHSObj = document.getElementById('txtRHS');
    txtRHSObj.style.position = "absolute";
    txtRHSObj.style.visibility = "visible";

    InitializeKendoControls();

    //onmouseover="javascript:ShowAlttext(this)" 
    //onmouseout="javascript:HideAlttext(this)" 
    //onpaste="javascript:ChangeRHSMODE()"
    //onkeyup="javascript:ChangeRHSMODE()"

    hideRHSInputControl();
}

function clearRHSInputControlValue() {
    txtRHSObj.value = "";
    radRHSNumberCoreObj.value("");
    radRHSDateCoreObj.value("");
    radRHSTimeCoreObj.value("");
    radRHSDateTimeCoreObj.value("");
}

function setRHSInputControlValue(row, _value) {
    var RHSMode = "Default",
        rhsText = "",
        dataType = getInputDataTypeForRow(row);

    if (isObjectTreeInUse)
        RHSMode = "ObjTree";

    if (!isUndefined(eval("window.Row" + row))) {
        RHSMode = eval("window.Row" + row + ".RHSMode");
        rhsText = eval("window.Row" + row + ".RHSColumn");
    }

    if (!isUndefined(_value)) {
        rhsText = _value;
    }

    if (rhsText == "") {
        clearRHSInputControlValue();
        return;
    }

    if (RHSMode == "Default") {
        if (isNumberDataType(dataType)) {
            radRHSNumberCoreObj.value(numberUtil.getNumberFromInvariantString(rhsText));
        }
        else if (isDateTimeDataType(dataType)) {
            var dateVal;
            switch (dataType) {
                case "DATE":
                    dateVal = dateTimeUtil.getDateTimeFromInvariantString(rhsText, true);
                    if (isUndefined(dateVal)) {
                        radRHSDateCoreObj.value("");
                    }
                    else {
                        radRHSDateCoreObj.value(dateVal);
                    }
                    break;
                case "TIME":
                    dateVal = dateTimeUtil.getDateTimeFromInvariantString(rhsText, false, true);
                    if (isUndefined(dateVal)) {
                        radRHSTimeCoreObj.value("");
                    }
                    else {
                        radRHSTimeCoreObj.value(dateVal);
                    }
                    break;
                case "DATETIME":
                    dateVal = dateTimeUtil.getDateTimeFromInvariantString(rhsText);
                    if (isUndefined(dateVal)) {
                        radRHSDateTimeCoreObj.value("");
                    }
                    else {
                        radRHSDateTimeCoreObj.value(dateVal);
                    }
                    break;
            }
        }
        else {
            txtRHSObj.value = rhsText;
        }
    }
    else {
        txtRHSObj.value = getDisplayTextForInputControl(rhsText, false, RHSMode);
    }
}

function getRHSInputControlValue(row) {
    var RHSMode = "Default";

    if (isObjectTreeInUse)
        RHSMode = "ObjTree";

    if (!isUndefined(eval("window.Row" + row)))
        RHSMode = eval("window.Row" + row + ".RHSMode");

    if (RHSMode == "Default") {
        var dataType = getInputDataTypeForRow(row);

        if (isNumberDataType(dataType)) {
            radRHSNumberCoreObj._blur();
            return numberUtil.getInvariantStringFromNumber(radRHSNumberCoreObj.value(), doesNumberHasDecimalPlaces(dataType));
        }
        else if (isDateTimeDataType(dataType)) {
            switch (dataType) {
                case "DATE":
                    radRHSDateCoreObj.SK_UpdateChanges();
                    return dateTimeUtil.getInvariantStringFromDateTime(radRHSDateCoreObj.value(), true);
                    break;
                case "TIME":
                    radRHSTimeCoreObj.SK_UpdateChanges();
                    return dateTimeUtil.getInvariantStringFromDateTime(radRHSTimeCoreObj.value(), false, true);
                    break;
                case "DATETIME":
                    radRHSDateTimeCoreObj.SK_UpdateChanges();
                    return dateTimeUtil.getInvariantStringFromDateTime(radRHSDateTimeCoreObj.value());
                    break;
            }
        }
        else {
            return txtRHSObj.value;
        }
    }

    return "";
}

function getRHSControlObject(RHSMode, dataType) {
    if (RHSMode == "Default") {
        if (isNumberDataType(dataType)) {
            return radRHSNumberControlObj;
        }
        else if (isDateTimeDataType(dataType)) {
            switch (dataType) {
                case "DATE":
                    return radRHSDateControlObj;
                    break;
                case "TIME":
                    return radRHSTimeControlObj;
                    break;
                case "DATETIME":
                    return radRHSDateTimeControlObj;
                    break;
            }
        }
    }

    return txtRHSObj;
}

function getRHSCoreObject(RHSMode, dataType) {
    if (RHSMode == "Default") {
        if (isNumberDataType(dataType)) {
            return radRHSNumberCoreObj;
        }
        else if (isDateTimeDataType(dataType)) {
            switch (dataType) {
                case "DATE":
                    return radRHSDateCoreObj;
                    break;
                case "TIME":
                    return radRHSTimeCoreObj;
                    break;
                case "DATETIME":
                    return radRHSDateTimeCoreObj;
                    break;
            }
        }
    }

    return txtRHSObj;
}

function setFocusOnControl(rhsMode, dataType) {
    try {
        var controlObj = getRHSControlObject(rhsMode, dataType);

        if (controlObj.id == "txtRHS") {
            controlObj.focus();
        }
        else {
            getRHSCoreObject(rhsMode, dataType).focus();
        }
    }
    catch (e) {
        return;
    }
}

function showRHSInputControl(row, x, y) {
    var RHSMode = "Default",
        rhsText = "";

    if (isObjectTreeInUse) {
        RHSMode = "ObjTree";
    }

    if (!isUndefined(eval("window.Row" + row))) {
        RHSMode = eval("window.Row" + row + ".RHSMode");
    }

    isObjectTreeInUse = (RHSMode == "ObjTree");

    var dataType = getInputDataTypeForRow(row);
    var controlObj = getRHSControlObject(RHSMode, dataType);

    if (RHSMode == "Default") {
        ReinitializeKendoNumberControlBasedOnDataType(dataType);
    }

    if (x >= 0 && y >= 0) {
        var yoffset = 14;
        controlObj.style.left = x + 30 + 'px';
        controlObj.style.top = (parseInt(y) + yoffset) + 'px';
        imageLHSObj.style.left = x + parseInt(controlObj.style.width) + 30 + 'px';
        imageLHSObj.style.top = (parseInt(y) + yoffset + 2) + 'px';
    }

    txtRHSObj.readOnly = (RHSMode != 'Default');

    clearRHSInputControlValue();

    setRHSInputControlValue(row);

    if (RHSMode == "Default") {
        imageLHSObj.style.display = "none";
    }
    else {
        imageLHSObj.style.display = "block";
    }

    controlObj.style.display = "block";

    txtLHSObj.style.display = "none";
    inputLHSObj.style.display = "none";
    oprComboObject.style.display = "none";
 //   inputOPRObj.style.display = "none";
  //  imageOPRObj.style.display = "none";
}

function hideRHSInputControl() {
    txtRHSObj.style.display = "none";

    radRHSNumberControlObj.style.display = "none";

    hideRHSDateTimeControlCommonFn(radRHSDateControlObj, radRHSDateCoreObj);
    hideRHSDateTimeControlCommonFn(radRHSTimeControlObj, radRHSTimeCoreObj);
    hideRHSDateTimeControlCommonFn(radRHSDateTimeControlObj, radRHSDateTimeCoreObj);
}

function hideRHSDateTimeControlCommonFn(dateTimeControlObj, dateTimeCoreObj) {
    dateTimeControlObj.style.display = "none";

    if (!isUndefined(dateTimeCoreObj.dateView) && dateTimeCoreObj.dateView.popup.visible()) {
        dateTimeCoreObj.close("date");
    }

    if (!isUndefined(dateTimeCoreObj.timeView) && dateTimeCoreObj.timeView.popup.visible()) {
        dateTimeCoreObj.close("time");
    }
}

function DateTimeUtility() {
    var self = this;

    self.InvariantShortDateFormat = "MM/dd/yyyy";
    self.InvariantLongTimeFormat = "HH:mm:ss";

    self.LocaleShortDateFormat = self.InvariantShortDateFormat;
    self.LocaleLongTimeFormat = self.InvariantLongTimeFormat;

    self.getDisplayTextFromInvariantStringValue = function (_dateTimeInvariantStringValue, hasDatePart, hasTimePart) {
        try {
            if (areInvariantAndLocaleFormatSame(hasDatePart, hasTimePart)) {
                return _dateTimeInvariantStringValue;
            }

            var dateTimeValue = self.getDateTimeFromInvariantString(_dateTimeInvariantStringValue, hasDatePart, hasTimePart);
            return self.getLocaleStringFromDateTime(dateTimeValue, hasDatePart, hasTimePart);
        }
        catch (e) {
            return "";
        }
    };

    function getDateTimeFormat(hasDatePart, hasTimePart, dateFormat, timeFormat) {
        if (isUndefined(hasDatePart)) {
            hasDatePart = false;
        }
        if (isUndefined(hasTimePart)) {
            hasTimePart = false;
        }

        if (!hasDatePart && !hasTimePart) {
            hasDatePart = true;
            hasTimePart = true;
        }

        return ((hasDatePart ? dateFormat : "") + ((hasDatePart && hasTimePart) ? " " : "") + (hasTimePart ? timeFormat : ""));
    }

    function getInvariantDateTimeFormat(hasDatePart, hasTimePart) {
        return getDateTimeFormat(hasDatePart, hasTimePart, self.InvariantShortDateFormat, self.InvariantLongTimeFormat);
        //return ((hasDatePart ? self.InvariantShortDateFormat + " " : "") + (hasTimePart ? self.InvariantLongTimeFormat : ""));
    }

    function getLocaleDateTimeFormat(hasDatePart, hasTimePart) {
        return getDateTimeFormat(hasDatePart, hasTimePart, self.LocaleShortDateFormat, self.LocaleLongTimeFormat);
    }

    function getLocaleDateTimeFormatArray(hasDatePart, hasTimePart) {
        return [getLocaleDateTimeFormat(hasDatePart, hasTimePart)];
    }

    function getInvariantDateTimeFormatArray(hasDatePart, hasTimePart) {
        return [getInvariantDateTimeFormat(hasDatePart, hasTimePart)];
    }

    function areInvariantAndLocaleFormatSame(hasDatePart, hasTimePart) {
        return (getInvariantDateTimeFormat(hasDatePart, hasTimePart) === getLocaleDateTimeFormat(hasDatePart, hasTimePart));
    }

    function getStringFromDateTime(_value, format, locale) {
        try {
            var retVal = kendo.toString(_value, format, locale);
            if (isUndefined(retVal)) {
                return "";
            }
            return retVal;
        }
        catch (e) {
            return "";
        }
    }

    function getDateTimeFromString(_value, formatArray, culture) {
        try {
            var retVal = kendo.parseDate(_value, formatArray, "en-US");

            if (isUndefined(retVal)) {
                return null;
            }

            return retVal;
        }
        catch (e) {
            return null;
        }
    }

    self.getLocaleStringFromDateTime = function (_value, hasDatePart, hasTimePart) {
        return getStringFromDateTime(_value, getLocaleDateTimeFormat(hasDatePart, hasTimePart));
    };

    self.getInvariantStringFromDateTime = function (_value, hasDatePart, hasTimePart) {
        return getStringFromDateTime(_value, getInvariantDateTimeFormat(hasDatePart, hasTimePart), "en-US");
    };

    self.getDateTimeFromInvariantString = function (_value, hasDatePart, hasTimePart) {
        return getDateTimeFromString(_value, getInvariantDateTimeFormatArray(hasDatePart, hasTimePart));
    };

    self.getDateTimeFromLocaleString = function (_value, hasDatePart, hasTimePart) {
        return getDateTimeFromString(_value, getLocaleDateTimeFormatArray(hasDatePart, hasTimePart));
    };
}

function NumberUtility() {
    var self = this;
    self.DecimalDisplayFormat = "#,.#########";
    self.DecimalStorageFormat = "#.#########";
    self.IntegerDisplayFormat = "n0";
    self.IntegerStorageFormat = "#";

    self.getNumberDisplayText = function (_value, _hasDecimal) {
        try {
            var numValue = self.getNumberFromInvariantString(_value);
            return self.getLocaleStringFromNumber(numValue, _hasDecimal);
        }
        catch (e) {
            return "";
        }
    };

    self.getLocaleStringFromNumber = function (_value, _hasDecimal) {
        try {
            var retVal = kendo.toString(_value, (_hasDecimal ? self.DecimalDisplayFormat : self.IntegerDisplayFormat));
            if (isUndefined(retVal)) {
                return "";
            }
            return retVal;
        }
        catch (e) {
            return "";
        }
    };

    self.getInvariantStringFromNumber = function (_value, _hasDecimal) {
        try {
            var retVal = kendo.toString(_value, (_hasDecimal ? self.DecimalStorageFormat : self.IntegerStorageFormat), "en-US");
            if (isUndefined(retVal)) {
                return "";
            }
            return retVal;
        }
        catch (e) {
            return "";
        }
    };

    self.getNumberFromInvariantString = function (_value) {
        try {
            return kendo.parseFloat(_value, "en-US");
        }
        catch (e) {
            return null;
        }
    };

    self.getNumberFromLocaleString = function (_value) {
        try {
            return kendo.parseFloat(_value);
        }
        catch (e) {
            return null;
        }
    };
}


function setValue(valueReturned) {
    rhsTextValue = valueReturned;
    lhsTextVal = valueReturned;
    var rhsOriginalTextVal = valueReturned;
    var lhsOriginalTextVal = valueReturned;
    var currentRow = document.getElementById("hiddivNumber").value;
    if (mode == "LHS") {
        if (isUndefined(eval("window.Row" + currentRow)))
            eval("window.Row" + currentRow + " =new VariableRow()");
        eval("window.Row" + currentRow + ".LHSColumn=lhsOriginalTextVal");
        // eval("window.Row"+currentRow+".LHSColumn=node.get_value()"); %OLD CODE, A2%

        if (!IsAddedToArray(currentRow)) {
            var inArrLen = InitialUpdatedVariableArray.length;
            InitialUpdatedVariableArray[inArrLen] = currentRow + "~" + "S";
        }

        //Building HTML for the LHSDIV            
        setLHSDivHtml(currentRow, lhsTextVal, ((!isUndefined(eval("window.Row" + currentRow))) ? eval("window.Row" + currentRow + ".LHSMode") : "Default"));

        //Creating New Row
        var nextRowHTML = AddRow(currentRow);
        if (nextRowHTML != "")
            document.getElementById("divExpressionLayers").innerHTML = document.getElementById("divExpressionLayers").innerHTML + nextRowHTML;

        //Building HTML for the MHSDIV
        setMHSDivHtml(currentRow, ((!isUndefined(eval("window.Row" + currentRow))) ? eval("window.Row" + currentRow + ".OPRColumn") : ""));

        //Building HTML for the RHSDIV
        setRHSDivHtml(currentRow, ((!isUndefined(eval("window.Row" + currentRow))) ? eval("window.Row" + currentRow + ".RHSColumn") : ""), ((!isUndefined(eval("window.Row" + currentRow))) ? eval("window.Row" + currentRow + ".RHSMode") : "Default"));


        setDivObjectTreeHtml(currentRow);
    }
    else {
        if ((nodeValue == "GalaxyBrowser" || nodeValue.substring(0, 13) == "GalaxyBrowser")
            && IsOpenedFromA2() == "yes") {
            var tagName = window.external.Service('aaGalaxyBrowser').TagName;
            var retValue = window.external.Service('aaGalaxyBrowser').OpenGalaxyBrowser('', '', '', tagName);
            rhsTextVal = retValue;
            rhsOriginalTextVal = retValue;
        }

        if (isUndefined(eval("window.Row" + currentRow)))
            eval("window.Row" + currentRow + " =new VariableRow()");

        eval("window.Row" + currentRow + ".RHSColumn=rhsOriginalTextVal");
        eval("window.Row" + currentRow + ".RHSMode='ObjTree'");
        //eval("window.Row"+currentRow+".RHSColumn=node.get_value()"); %OLD CODE, A2%


        if (!IsAddedToArray(currentRow)) {
            var inArrLen = InitialUpdatedVariableArray.length;
            InitialUpdatedVariableArray[inArrLen] = currentRow + "~" + "S";
        }

        //Building HTML for the RHSDIV            
        setRHSDivHtml(currentRow, valueReturned, eval("window.Row" + currentRow + ".RHSMode"));
    }
}
