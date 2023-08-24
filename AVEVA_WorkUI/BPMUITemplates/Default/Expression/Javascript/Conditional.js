
var divXPos = 0;
var divYPos = 0;
var eventObj = null;
var lhsvalue = "";
var selectedRow = "";
var mainDivId;
var browserCode = GetBrowserversion();        //IE - 1; fireFox--2
var mouseeventObj = null;
var lhsObj;
var imageLHSObj;
var inputLHSObj;
var rhsObj;
var imageRHSObj;
var radTreeObj;
var inputRHSObj;
var imageOPRObj;
var cmbOPRObj = "";
var inputOPRObj;
var imageBoolObj;
var inputBoolObj;
var cmbBOOLObj;
var imageRHSCalObj;
var mhsObj;
var imageMHSObj;
var inputMHSObj;
var cmbMHSObj = "";
var mainDivId;
var MenuInstance;
var MHSComboInstance;
var mhsDivOpened = 0;
var MenuDivObj;
var txtRHSObj;
var CalIMGRHSObj;
var changeRHSmode = 0;
var prevRow = 0;
var objTreeRHSMode = 0;
var cmbMHSName = "";
var cmbOPRName = "";
var menuImg = "";
var cmbBoolName = "";
var expbuilderURl = "";
var InitialconditionalArray = new Array();
var FinalconditionalArray = new Array();
var SaveconditionalArray = new Array();
var controlName = "";
var ValiderrCount = 0;
var validateMode = 0;
var objTreeLHSMode = 0;
var HSmode = "";
var menuImgSrc = "";
var errorIcon = "";
var errorGif = "";
var errLnkObj;
//Localized Messages
var errorAlertforExpression = "";
var expErrorAlertforExpression = "";
var expErrinExpression = "";
var expErrorstext = "";
var expCompiledCode = "";
var compileCodeImage = "";
var closeImg = "";
var ErrorDivObj;
var bubbleWindowObj;
var forcheck = 0;
var cmbboolObj = "";
var ConditionentervaliddateLocal = "";
var ConditionenternumericvalueLocal = "";
var ConditionEnterValueLocal = "";
var olddivHeight;
var olddivWidth;
var olddivleft;
var olddivtop;
var oldTreeHeight;
var oldTreeWidth;
var oldValuestaken = false;
var Maximized = false;

var mhsComboObject;
var oprComboObject;
var boolComboObject;


function Initialize() {
    lhsObj = document.getElementById("cmbLHS");
    imageLHSObj = document.getElementById('cmbLHS_Image');
    inputLHSObj = document.getElementById('cmbLHS_Input');
    imageLHSObj.style.display = "none";
    cmbboolObj = document.getElementById("boolctrl");
    inputLHSObj.style.display = "none";

    mhsComboObject = document.getElementById(cmbMHSName);
    oprComboObject = document.getElementById(cmbOPRName);
    boolComboObject = document.getElementById(cmbBoolName);

    mhsComboObject.style.display = "none";
    oprComboObject.style.display = "none";
    boolComboObject.style.display = "none";
        
    //inputMHSObj.style.width = 100 + 'px';    
    //inputOPRObj.style.width = 30 + 'px';    
    //inputBoolObj.style.width = 90 + 'px';


    MenuDivObj = document.getElementById('MenuDiv');
    MenuDivObj.style.display = "none";

    txtRHSObj = document.getElementById('txtRHS');
    txtRHSObj.style.display = "none";

    CalIMGRHSObj = document.getElementById('CalIMGRHS');
    CalIMGRHSObj.style.display = "none";

    bubbleWindowObj = document.getElementById("bubbleWindow");
    bubbleWindowObj.style.display = "none";

    errLnkObj = document.getElementById("errorLink");
    errLnkObj.style.display = "none";

    ErrorDivObj = document.getElementById("ErrorsWindow");
    ErrorDivObj.style.display = "none";

}

function htmlencode(str) {
    var div = document.createElement('div');
    div.appendChild(document.createTextNode(str));
    return div.innerHTML;
}

function HandleClose(comboBox) {
    if (trim(document.getElementById(cmbMHSName + "_Input").value) == "") {
        var currentRow = htmlencode(document.getElementById("hiddivNumber").value);
        if (currentRow != "")
        {
            var currentDivElement = "MHS" + currentRow;
            var divObj = document.getElementById(currentDivElement);
            var selectedNodeTxt = "<A class=\"GridHyperlinkStyle\" id=\"link" + currentRow + "\" onmouseover=\"Javascript:alterLink(this," + currentRow + "," + currentRow + ",event,'MHS')\" onclick=\"Javascript:alterLink(this," + currentRow + "," + currentRow + ",event,'MHS')\" href=\"#\">Equals</A>";
            divObj.innerHTML = "&nbsp;" + selectedNodeTxt + "&nbsp;";//removed ":" for consistency
            mhsComboObject.style.display = "none";
        }
    }
    mhsDivOpened = 0;
}

function HandleOpen(comboBox) {
    //mhsDivOpened=1;

}

function OpenDiv(mode) {

    var tableStr = "";

    if (mode == 1)
        tableStr = GetErrorlist();
    else
        tableStr = GetCompiledCode();


    var errLinkObj = document.getElementById("errorLink");
    var x = findPosX(errLnkObj);
    var y = findPosY(errLnkObj);



    ErrorDivObj.style.left = parseInt(x + 0) + 'px';
    ErrorDivObj.style.top = parseInt(y - 260) + 'px';

    ErrorDivObj.style.position = "absolute";
    ErrorDivObj.style.visibility = "visible";
    ErrorDivObj.style.display = "block";
    ErrorDivObj.innerHTML = tableStr;
    ErrorDivObj.style.width = 500;
    ErrorDivObj.style.height = 250;

}

function GetErrorlist() {
    var tableStr = "<table width=500 height=250 border=0 bgcolor=\"ffffff\" cellspacing=0 cellpadding=0><tr class=\"header\"><td width=\"4%\" align=\"left\"><img src=" + errorIcon + " width=\"21\" height=\"20\" /></td><td width=\"50%\" class=\"description\" align=\"left\">" + expErrinExpression + "</td><td width=\"30%\" valign=middle align=\"right\" class=\"description\"><a href=\"#\" onclick=\"javascript:OpenDiv(2)\" class='ErrorHyperlinkStyle'><img src=" + compileCodeImage + " border=0 align='absmiddle'/>&nbsp;" + expCompiledCode + "</a></td><td width=\"10%\" align=\"right\"  class=\"description\"><a href=\"#\" onclick=\"javascript:CloseDiv()\"><img src=" + closeImg + " width=\"17\" height=\"17\" border=0/></a></td></tr>";
    tableStr = tableStr + "<tr><td colspan=\"4\" class=\"description\" align=left valign='top'>";
    tableStr = tableStr + "<div id=\"ErrorInnerDiv\" style=\"Overflow: auto;\ width=500px; height:220px;\">";
    tableStr = tableStr + expCompResult.replace(/SelectStyle/g, "description");
    tableStr = tableStr + "</div>";
    tableStr = tableStr + "</td></tr>";
    tableStr = tableStr + "</table>";
    return tableStr;
}

function GetCompiledCode() {
    var tableStr = "<table width=500 height=250 border=0 bgcolor=\"ffffff\" cellspacing=0 cellpadding=0><tr class=\"header\" ><td width=\"4%\" align=\"left\"><img src=" + errorIcon + " width=\"21\" height=\"20\" /></td><td width=\"50%\"  class=\"description\" align=\"left\">" + expErrinExpression + "</td><td width=\"30%\" valign=middle align=\"right\"   class=\"description\"><a href=\"#\" onclick=\"javascript:OpenDiv(1)\" class='ErrorHyperlinkStyle'><img src=" + errorGif + " border=0 align='absmiddle'/>&nbsp;" + expErrorstext + "</a></td><td width=\"10%\" align=\"right\"   class=\"description\"><a href=\"#\" onclick=\"javascript:CloseDiv()\"><img src=" + closeImg + " width=\"17\" height=\"17\" border=0/></a></td></tr>";
    tableStr = tableStr + "<tr><td colspan=\"4\"  class=\"description\" align=left valign='top'>";
    tableStr = tableStr + "<div id=\"ErrorInnerDiv\" style=\"Overflow: auto;\ width=500px; height:220px;\">";
    tableStr = tableStr + "<table><tr><td class='description'>";
    var renderCode = HtmlDecode(compiledCode);
    renderCode = replacestring(renderCode, '~', '&');
    tableStr = tableStr + renderCode;
    tableStr = tableStr + "</td></tr></table>";
    tableStr = tableStr + "</div>";
    tableStr = tableStr + "</td></tr>";
    tableStr = tableStr + "</table>";
    return tableStr;
}

function replacestring(stringtobereplaced, chartobereplaced, charbywhichreplaced) {
    var out = "";
    if (stringtobereplaced == null) return;
    var l = stringtobereplaced.length;
    for (var i = 0; i < l; i++) {
        var ch = stringtobereplaced.charAt(i);
        if (ch == chartobereplaced) {
            stringtobereplaced = stringtobereplaced.replace(ch, charbywhichreplaced);
        }
    }

    return stringtobereplaced;
}
function CloseDiv() {
    var divObj = document.getElementById("ErrorsWindow");
    divObj.style.display = "none";
    forcheck = 1;
}

function GetBrowserversion() {
    var app = navigator.userAgent;
    if (app.indexOf("MSIE") > -1) {
        return 1;
    }
    else if (app.indexOf("Firefox/1.5") > -1) {
        return 2;
    }
    else {
        return 3;
    }
}

function alterLink(lnkObj, no, divNo, evnt, combo) {

    PageInit();
    Initialize();    
    if ((!(typeof (eval("window.Row" + no)) == "undefined")) && (!(typeof ("window.Row" + no + ".LHSColumn") == "undefined"))) {
        if (eval("window.Row" + no + ".LHSColumn.DataType") == "System.Boolean" && combo == "MHS") {
            return;
        }
    }

    if (txtRHSObj.style.width != 211 + 'px') {
        txtRHSObj.style.width = 211 + 'px';
    }
    Maximize(false, 0);
    if (document.getElementById("hiddivNumber").value != "") {
        mhsComboObject.control.hideDropDown();
        oprComboObject.control.hideDropDown();
        boolComboObject.control.hideDropDown();
    }

    if (document.getElementById("hiddivNumber") != null) {
        var prevRowDivObj = document.getElementById("divExpressionLayer" + document.getElementById("hiddivNumber").value);
        var rhsType = document.getElementById("hidLHStype").value;

        if (ValiderrCount == 0)
            document.getElementById("hiddivNumber").value = divNo;

        PositionObj(lnkObj, no, evnt, rhsType, combo);
        eventObj = evnt;
    }

    var divNumberVal = document.getElementById("hiddivNumber").value;
    var currentRow = parseInt(divNumberVal);

    if (isNaN(currentRow)) {
        return;
    }

    var currentDivElement = "divlnkOPR" + currentRow;
    var divObj = document.getElementById(currentDivElement);


    if (GetBrowserversion() == 1) {
        if (eval("window.Row" + currentRow) != null && divObj != null)
            eval("window.Row" + currentRow + ".LogicalOpr=divObj.outerText");
    }
    else {
        if (divObj.innerText == undefined)
            divObj.innerText = 'and';
        if (eval("window.Row" + currentRow) != null && divObj != null && eval("window.Row" + currentRow + ".LogicalOpr") != null)
            eval("window.Row" + currentRow + ".LogicalOpr=divObj.innerText");
    }
}


function FindNodeByText(text) {
    var node = radTreeObj.control.findNodeByText(text);
    return node;
}

function DisableNode(text) {
    var node = FindNodeByText(text);
    if (node != null)
        node.disable();
}

function EnableNode(text) {
    var node = FindNodeByText(text);
    if (node != null)
        node.enable();
}


function ChangeRHSMODE() {
    if (prevRow == 0)
        prevRow = document.getElementById("hiddivNumber").value;
}

function PositionObj(ctlObj, no, evnt, rhsType, combo) {
    var el = ctlObj;
    var x = 0;
    var y = el.offsetHeight;
    //Walk up the DOM and add up all of the offset positions.
    while (el.parentNode != null && el.tagName.toUpperCase() != 'BODY') {
        x += el.offsetLeft;
        y += el.offsetTop;
        el = el.offsetParent;
    }

    x += el.offsetLeft;
    y += el.offsetTop;

    var scrollTop = document.getElementById("divMain").scrollTop;
    y = parseInt(y - scrollTop);

    if (popup != null) {
        if (popup.IsVisible()) {
            popup.Hide();
        }
    }

    var divNumberVal = htmlencode(document.getElementById("hiddivNumber").value);
    var curRow = parseInt(divNumberVal);

    if (isNaN(curRow)) {
        return;
    }

    ValiderrCount = PlaceLinkforText();

    if (ValiderrCount > 0)
        return false;

    if (txtRHSObj != null)
        txtRHSObj.style.display = "none";

    if (CalIMGRHSObj != null)
        CalIMGRHSObj.style.display = "none";

    if (inputLHSObj != null)
        inputLHSObj.value = "";

    document.getElementById("treeDiv").style.visibility = "hidden";
    objTreeLHSMode = 0;

    if (combo == "LHS") {
        objTreeRHSMode = 0;
        document.getElementById("cmbLHS").style.visibility = "visible";
        document.getElementById("cmbLHS").style.display = "block";
        HSmode = "L";

        if (radTreeObj != null) {
            DisableNode('Enter Value');

        }

        if (inputLHSObj != null) {
            mhsComboObject.style.display = "none";
            inputLHSObj.style.visibility = "visible";
            inputLHSObj.style.display = "block";
            inputLHSObj.style.position = "absolute";
            inputLHSObj.style.left = x + 'px';
            inputLHSObj.style.top = (parseInt(y) - 14) + 'px';
            //inputLHSObj.style.top = (parseInt(y)-15) + 'px';

            if (eval("window.Row" + curRow) != null) {
                if (eval("window.Row" + curRow + ".LHSMode") == "Expression") {
                    document.getElementById("cmbLHS_Input").value = eval("DecodeTheExpressionString(window.Row" + curRow + ".LHSColumn.ColumnExpression.DisplayExpressionString)");
                }
                else {
                    inputLHSObj.value = eval("window.Row" + curRow + ".LHSColumn.DisplayText")
                }
            }
            else
                inputLHSObj.value = "";


            imageLHSObj.style.visibility = "hidden";
            imageLHSObj.style.display = "block";
            imageLHSObj.style.position = "absolute";
            imageLHSObj.style.left = x + inputLHSObj.offsetWidth + 'px';
            imageLHSObj.style.top = (parseInt(y) - 14) + 'px';

            oprComboObject.style.display = "none";
            boolComboObject.style.display = "none";


            txtRHSObj.value = "";
            txtRHSObj.style.display = "none";
            CalIMGRHSObj.style.display = "none";
            objTreeLHSMode = 1;


        }

    }
    //On mouse over MHS
    else if (combo == "MHS") {

        var rowObje = "";
        var rowObjeReturnType = "";
        if (eval("window.Row" + curRow + ".LHSMode") == "Expression") {//window.Row1.LHSColumn.ColumnExpression
            rowObje = eval("window.Row" + curRow + ".LHSColumn");
            if (rowObje.ColumnExpression.ReturnType == "System.Boolean") {
                rowObjeReturnType = "System.Boolean";

            }
        }
        var dType = eval("window.Row" + curRow + ".LHSColumn.DataType");

        if (dType == "System.Boolean" || rowObjeReturnType == "System.Boolean") {
            inputLHSObj.style.display = "none";
            imageLHSObj.style.display = "none";
            return false;
        }
        HSmode = "M";

        mhsComboObject.style.visibility = "visible";
        mhsComboObject.style.display = "block";
        mhsComboObject.style.left = (x - 10) + 'px';
        mhsComboObject.style.top = (parseInt(y) - 15) + 'px';
        mhsComboObject.style.position = "absolute";
        inputMHSObj = document.getElementById(cmbMHSName + "_Input");

        if (eval("window.Row" + curRow) != null)
        {
            inputMHSObj.value = eval("window.Row" + curRow + ".MHSDisplayText")
        }
        else
        {
            inputMHSObj.value = "";
        }
        var divNumberVal = document.getElementById("hiddivNumber").value;
        var curRow = parseInt(divNumberVal);
        if (isNaN(curRow)) {
            return;
        }

        var lhsType = "";

        if (eval("window.Row" + curRow + ".LHSColumn.ColumnExpression.ReturnType") != null) {
            lhsType = eval("window.Row" + curRow + ".LHSColumn.ColumnExpression.ReturnType");
        }
        else
            lhsType = eval("window.Row" + curRow + ".LHSColumn.DataType");
                
        mhsComboObject.control.requestItems(lhsType, false);
        mhsComboObject.control.requestItems(lhsType, false);
        //Double Time is required for maintaining the same state
        mhsComboObject.control.toggleDropDown();
        inputLHSObj.style.display = "none";
        imageLHSObj.style.display = "none";        
        oprComboObject.style.display = "none";
        boolComboObject.style.display = "none";
        document.getElementById("treeDiv").style.visibility = "hidden";
        txtRHSObj.value = "";
        txtRHSObj.style.display = "none";
        CalIMGRHSObj.style.display = "none";
    }

    else if (combo == "OPR")
    {
        inputOPRObj = document.getElementById(cmbOPRName + "_Input");
        HSmode = "O";
        if (eval("window.Row" + curRow) != null)
        {            
            inputOPRObj.value = eval("window.Row" + curRow + ".LogicalOpr")
        }
        else
        {           
            inputOPRObj.value = "and";
        }

        oprComboObject.style.display = "block";
        oprComboObject.style.left = (x - 10) + 'px';
        oprComboObject.style.top = (parseInt(y) - 15) + 'px';
        oprComboObject.style.position = "absolute";       
        inputLHSObj.style.display = "none";
        imageLHSObj.style.display = "none";
        mhsComboObject.style.display = "none";
        boolComboObject.style.display = "none";
        txtRHSObj.value = "";
        txtRHSObj.style.display = "none";
        CalIMGRHSObj.style.display = "none";
    }
    else if (combo == "RHS") {
        mhsComboObject.style.display = "none";        
        HSmode = "R";
        var RHSMode = "";
        EnableNode('Enter Value');

        if (eval("window.Row" + curRow) != null) {

            if (eval("window.Row" + curRow + ".RHSMode") == "default") {
                txtRHSObj.value = eval("window.Row" + curRow + ".RHSValue");
                RHSMode = eval("window.Row" + curRow + ".RHSMode");
            }
            else if (eval("window.Row" + curRow + ".RHSMode") == "Expression") {
                document.getElementById("cmbLHS_Input").value = eval("DecodeTheExpressionString(window.Row" + curRow + ".RHSColumn.ColumnExpression.DisplayExpressionString)");
                RHSMode = eval("window.Row" + curRow + ".RHSMode");
            }
            else {
                document.getElementById("cmbLHS_Input").value = eval("window.Row" + curRow + ".RHSColumn.DisplayText")
                RHSMode = eval("window.Row" + curRow + ".RHSMode");
            }
            var dataType = "";

            if (eval("window.Row" + curRow + ".LHSColumn.ColumnExpression.DisplayExpressionString") != "") {
                dataType = eval("window.Row" + curRow + ".LHSColumn.ColumnExpression.ReturnType");
            }
            else
                dataType = eval("window.Row" + curRow + ".LHSColumn.DataType");



            if ((dataType == "string") || (dataType == "numeric") || (dataType == "number") || (dataType == "int") || (dataType == "System.Int32") || (dataType == "System.Int64") || (dataType == "System.Double") || (dataType == "System.Decimal") || (dataType == "date") || (dataType == "System.DateTime") || (dataType == "date") || (dataType == "System.String") || (dataType == "System.Boolean") || (dataType == "float") || (dataType == "decimal") || (dataType == "bool")) {

            }
            else {

                RHSMode = "ObjTree";
            }
        }
        else {
            txtRHSObj.value = "";
        }

        if ((RHSMode == "ObjTree") || (RHSMode == "Expression")) {
            objTreeRHSMode = 1;
            document.getElementById("cmbLHS").style.visibility = "visible";
            document.getElementById("cmbLHS").style.display = "block";
            inputLHSObj.style.visibility = "visible";
            inputLHSObj.style.display = "block";
            inputLHSObj.style.position = "absolute";
            inputLHSObj.style.left = x + 'px';
            inputLHSObj.style.top = (parseInt(y - 13)) + 'px';

            imageLHSObj.style.visibility = "hidden";
            imageLHSObj.style.display = "block";
            imageLHSObj.style.position = "absolute";
            imageLHSObj.style.left = x + inputLHSObj.offsetWidth + 'px';
            imageLHSObj.style.top = (parseInt(y - 13)) + 'px';
            //ToggleTreeView();

            mhsComboObject.style.display = "none";
            oprComboObject.style.display = "none";
            boolComboObject.style.display = "none";            
            txtRHSObj.style.display = "none";
            CalIMGRHSObj.style.display = "none";


        }
        else {

            if (eval("window.Row" + curRow + ".LHSColumn.ColumnExpression.DisplayExpressionString") != "") {
                dataType = eval("window.Row" + curRow + ".LHSColumn.ColumnExpression.ReturnType");
            }
            else
                dataType = eval("window.Row" + curRow + ".LHSColumn.DataType");



            if (dataType == "System.Boolean")
            {
                inputBoolObj = document.getElementById(cmbBoolName + "_Input");
                if (eval("window.Row" + curRow) != null) {
                   inputBoolObj.value = eval("window.Row" + curRow + ".RHSValue")
                }

                else {                    
                    inputBoolObj.value = "true";
                }

                boolComboObject.style.visibility = "visible";
                boolComboObject.style.display = "block";
                boolComboObject.style.left = (x - 10) + 'px';
                boolComboObject.style.top = (parseInt(y) - 15) + 'px';
                boolComboObject.style.position = "absolute";


                inputLHSObj.style.display = "none";
                imageLHSObj.style.display = "none";
                mhsComboObject.style.display = "none";
                txtRHSObj.value = "";
                txtRHSObj.style.display = "none";
                CalIMGRHSObj.style.display = "none";
            }
            else {
                txtRHSObj.style.visibility = "visible";
                txtRHSObj.style.display = "block";
                txtRHSObj.style.position = "absolute";
                txtRHSObj.style.left = (x) + 'px';
                txtRHSObj.style.top = (parseInt(y) - 13) + 'px';

                if (eval("window.Row" + curRow + ".OprValidate=='no'")) {
                    if ((eval("window.Row" + curRow + ".LHSColumn.DataType") == "date") || (eval("window.Row" + curRow + ".LHSColumn.DataType") == "System.DateTime") || (eval("window.Row" + curRow + ".LHSColumn.ColumnExpression.ReturnType") == "System.DateTime") || (eval("window.Row" + curRow + ".LHSColumn.ColumnExpression.ReturnType") == "date"))
                    {
                        txtRHSObj.style.width = 150 + 'px';
                        CalIMGRHSObj.style.visibility = "visible";
                        CalIMGRHSObj.style.display = "block";
                        CalIMGRHSObj.style.position = "absolute";
                        CalIMGRHSObj.style.left = parseInt((x) + txtRHSObj.offsetWidth) + 'px';
                        CalIMGRHSObj.style.top = (parseInt(y) - 13) + 'px';
                    }
                }
                inputLHSObj.style.display = "none";
                imageLHSObj.style.display = "none";
                boolComboObject.style.display = "none";
            }
        }

    }
}


function PlaceLinkforText(selectedRow) {
    var errCount = 0;
    var currentRow = "";
    if (selectedRow == null)
        currentRow = prevRow;
    else
        currentRow = selectedRow;

    if (currentRow != 0) {
        var divObjRHS = document.getElementById("RHS" + currentRow);
        var rhsTextVal = txtRHSObj.value;

        if (trim(divObjRHS.innerHTML) != "") {
            if (trim(rhsTextVal) != "") {
                if (eval("window.Row" + currentRow) != null) {

                    var rdtype = "";

                    if (eval("window.Row" + currentRow + ".OprValidate=='yes'")) {
                        rdtype = "int";
                    }
                    else {
                        rdtype = eval("window.Row" + currentRow + ".LHSColumn.DataType");
                    }

                    isValid = validateEnteredValue(rdtype);

                    if (isValid) {
                        if (eval("window.Row" + currentRow + ".RHSMode") == "default")
                            eval("window.Row" + currentRow + ".RHSValue=rhsTextVal");

                        eval("window.Row" + currentRow + ".RHSColumn.DisplayText=rhsTextVal");
                        eval("window.Row" + currentRow + ".RHSColumn.ActualText=rhsTextVal");

                        //	                    if(rhsTextVal.length>20)
                        //	                        rhsTextVal1 = rhsTextVal.substring(0,20)+"..";
                        //	                    else
                        //	                        rhsTextVal1 = rhsTextVal
                        //CHECKPOINT
                        rhsTextVal = TruncateString(rhsTextVal);
                        if (rhsTextVal.length > 27) {
                            if (rhsTextVal.substring(0, 8) == "Variable") {
                                var length = rhsTextVal.length;
                                rhsTextVal1 = rhsTextVal.substring(0, 3) + ".." + rhsTextVal.substring(length - 23, length);

                            }
                            else if (rhsTextVal.substring(0, 11) == "XmlVariable") {
                                var length = rhsTextVal.length;
                                rhsTextVal1 = rhsTextVal.substring(0, 6) + ".." + rhsTextVal.substring(length - 17, length);

                            }

                            else {
                                var length = rhsTextVal.length;
                                rhsTextVal1 = rhsTextVal.substring(0, 6) + ".." + rhsTextVal.substring(length - 17, length);
                            }
                        }
                        else
                            rhsTextVal1 = rhsTextVal;

                        divObjRHS.innerHTML = "<a href=\"#\" id=\"rhsLink" + currentRow + "\" class=\"GridHyperlinkStyle\" OnMouseOver=\"javascript:alterLink(this," + currentRow + "," + currentRow + ",event,'RHS')\" Onclick=\"javascript:alterLink(this," + currentRow + "," + currentRow + ",event,'RHS')\" name=\"rhsLink" + currentRow + "\">" + rhsTextVal1 + "</a>";
                        txtRHSObj.style.display = "none";
                        CalIMGRHSObj.style.display = "none";
                        errCount = 0;
                        prevRow = 0;
                    }
                    else {
                        errCount = 1;
                        divObjRHS.innerHTML = "<a href=\"#\" id=\"rhsLink" + currentRow + "\" class=\"GridHyperlinkStyle\" OnMouseOver=\"javascript:alterLink(this," + currentRow + "," + currentRow + ",event,'RHS')\" Onclick=\"javascript:alterLink(this," + currentRow + "," + currentRow + ",event,'RHS')\" name=\"rhsLink" + currentRow + "\">Enter Value</a>";
                        var defValue = "";
                        if (eval("window.Row" + currentRow + ".RHSMode") == "default")
                            eval("window.Row" + currentRow + ".RHSValue=defValue");
                    }
                }
            }
            else {
                var defValue = "";
                if (eval("window.Row" + currentRow + ".RHSMode") == "default")
                    eval("window.Row" + currentRow + ".RHSValue=defValue");

                if (document.getElementById("MHS" + currentRow).innerHTML == "&nbsp;") {
                }
                else {
                    divObjRHS.innerHTML = "<a href=\"#\" id=\"rhsLink" + currentRow + "\" class=\"GridHyperlinkStyle\" OnMouseOver=\"javascript:alterLink(this," + currentRow + "," + currentRow + ",event,'RHS')\" Onclick=\"javascript:alterLink(this," + currentRow + "," + currentRow + ",event,'RHS')\" name=\"rhsLink" + currentRow + "\">Enter Value</a>";
                }
            }
        }
        txtRHSObj.value = "";
        //prevRow =0;
    }
    return errCount;
}


function ValidateFields() {
    var errCount = 0;
    for (var i = 1; i < InitialconditionalArray.length + 1; i++) {
        if (document.getElementById("divExpressionLayer" + i) != null) {
            if (document.getElementById("divExpressionLayer" + i).style.display != "none") {
                if (eval("window.Row" + i + ".RHSMode") == "default") {
                    if (trim(eval("window.Row" + i + ".RHSValue")) == "") {
                        if (eval("window.Row" + i + ".IsRHSExists==true")) {
                            // alert(ConditionPlsEnterValueLocal);
                            se.ui.messageDialog.showError(BellybarTitle, ConditionPlsEnterValueLocal, function () {
                                txtRHSObj.style.display != "none";
                                txtRHSObj.focus();
                            });
                            var rhsLinkObj = document.getElementById("rhsLink" + i);
                            if (rhsLinkObj != null)
                                alterLink(rhsLinkObj, i, i, null, 'RHS');

                            if (txtRHSObj.style.display != "none")
                                txtRHSObj.focus();

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


function validateEnteredValue(dataType) {
    var isValid = true;

    if ((dataType == "numeric") || (dataType == "int") || (dataType == "number") || (dataType == "System.Int32") || (dataType == "System.Int64") || (dataType == "System.Double") || (dataType == "System.Decimal") || (dataType == "System.Int16") || (dataType == "float") || (dataType == "decimal")) {
        if (isNaN(txtRHSObj.value)) {
            isValid = false;
            alert(ConditionenternumericvalueLocal);
        }
    }
    else if ((dataType == "date") || (dataType == "System.DateTime")) {
        if (!checkDate(txtRHSObj.value)) {
            isValid = false;
            alert(ConditionentervaliddateLocal);
        }
    }

    //alert(isValid);
    return isValid;
}

function ValidateForm() {

}

function SetTextBox(id, s) {
    document.getElementById(id).value = s;
    HideTreeView();
}
//function Minimize()
//{
//        objLHSRadDiv.style.height=150+'px';
//        objLHSRadDiv.style.width = 162 + 'px';
//        document.getElementById("treeDiv").style.visibility = "visible";
//	                            
//             objLHSRadDiv.style.top = document.getElementById("HidY").value;
//             objLHSRadDiv.style.left = document.getElementById("HidX").value;
//             objLHSRadTree.style.top = document.getElementById("HidY").value ;
//             objLHSRadTree.style.left = document.getElementById("HidX").value;
//           
//        objLHSRadTree.style.height = objLHSRadDiv.style.height;
//        objLHSRadTree.style.width = objLHSRadDiv.style.width;
//		HideTreeView();
//}
function ToggleTreeView() {
    //HideAltText(this);
    if (document.getElementById("treeDiv").style.visibility == "visible") {

        Maximize(false, 0);
        HideTreeView();
        //document.getElementById("cmbLHS").style.display="none";		

    }
    else
        ShowTreeView();



}

function ToggleTreeViewRHS() {
    document.getElementById("cmbRHS").style.visibility = "visible"
    document.getElementById("cmbRHS").style.display = "block";

    if (document.getElementById("treeRHSDiv").style.visibility == "visible")
        document.getElementById("treeRHSDiv").style.visibility = "hidden";
    else {

        document.getElementById("treeRHSDiv").style.visibility = "visible";
        var cmbLHSObj = document.getElementById("cmbRHS_Input");
        var x = findPosX(cmbLHSObj);
        var y = findPosY(cmbLHSObj);
        document.getElementById("treeRHSDiv").style.left = x + "px";
        document.getElementById("treeRHSDiv").style.top = (parseInt(y) + 21) + "px";

    }
}


function ShowTreeView() {
    document.getElementById("treeDiv").style.visibility = "visible";
    document.getElementById("treeDiv").style.display = "block";
    var cmbLHSObj = document.getElementById("cmbLHS_Input");
    var x = findPosX(cmbLHSObj);
    var y = findPosY(cmbLHSObj);
    var divHeight = document.getElementById("treeDiv").style.height;
    divHeight = divHeight.substring(0, divHeight.length - 2);

    //y = y - document.getElementById("divMain").scrollTop;

    if ((document.body.offsetHeight - y) < parseInt(divHeight)) {
        var newTop = parseInt(y) - parseInt(divHeight);
        document.getElementById("treeDiv").style.left = x + "px";
        document.getElementById("treeDiv").style.top = (parseInt(newTop)) + "px";
    }
    else {
        document.getElementById("treeDiv").style.left = x + "px";
        document.getElementById("treeDiv").style.top = (parseInt(y) + 18) + "px";
    }
    //debugger;
    /*if(olddivWidth!=null)
    {
      document.getElementById("MaxDiv").innerHTML= "<a href=\"#\" onclick=\"Maximize(false)\"><img id=\"Img1\" hspace=\"1\" src=\""+maxImage +"\" border=0 align='absmiddle'><span style=\"font-family:verdana; font-size:7pt; text-decoration:none;\">"+"Maximize"+"</span></a>";   
    } */
}

function HideTreeView() {
    document.getElementById("treeDiv").style.visibility = "hidden";
}





//function Maximize(mode,flag)
//{

//    var divTreeObj = document.getElementById("treeDiv");
//     var treeDiv = document.getElementById(treeName+"Div");
//     
//    var divHeight;
//    var divWidth;
//    
//    if(mode)
//    {
//          divHeight = divTreeObj.style.height;
//          divWidth = divTreeObj.style.width;  
//     
//          if(!oldValuestaken )
//          {
//              olddivHeight = divHeight;
//              olddivWidth = divWidth;
//              olddivleft =  divTreeObj.style.left;
//              olddivtop = divTreeObj.style.top
//              oldTreeHeight = treeDiv.style.height;
//              oldTreeWidth = treeDiv.style.width; 
//          }
//          winHeight =  document.body.offsetHeight;
//          winWidth =  document.body.offsetWidth;
//          divtop =    20;//divTreeObj.style.top - 10; //divTreeObj.style.top.substring(0,(divTreeObj.style.top).length-2);
//          divTreeObj.style.left=40;
//          divTreeObj.style.width =   winWidth-100;
//          divTreeObj.style.height =  (parseInt(winHeight)) - 100;
//          //var treeDiv = document.getElementById(treeName+"Div");
//          divTreeObj.style.top = divtop; 
//          treeDiv.style.height = divTreeObj.style.height;
//          treeDiv.style.width =  divTreeObj.style.width;
//            
//          var minImage = maxImage.replace("icon-maximize","icon-minimize");
//           
//           document.getElementById("MaxDiv").innerHTML= "<a href=\"#\" onclick=\"Maximize(false,0)\"><img id=\"Img1\" hspace=\"1\" src=\""+minImage +"\" border=0 align='absmiddle'><span style=\"font-family:verdana; font-size:7pt; text-decoration:none;\">"+"Minimize"+"</span></a>";
//           
//    }
//    else
//    {
//    
//            if(olddivWidth!=null)
//            {
//                     divTreeObj.style.width    =  olddivWidth;
//                     divTreeObj.style.height   =  olddivWidth;   
//                     
//                     if(flag==0){
//                        divTreeObj.style.left     =  olddivleft;
//                        divTreeObj.style.top     =   olddivtop;
//                        
//                        }
//                     treeDiv.style.height      =  oldTreeHeight;
//                     treeDiv.style.width       =  oldTreeWidth;
//            
//                     document.getElementById("MaxDiv").innerHTML= "<a href=\"#\" onclick=\"Maximize(true,0)\"><img id=\"Img1\" hspace=\"1\" src=\""+maxImage +"\" border=0 align='absmiddle'><span style=\"font-family:verdana; font-size:7pt; text-decoration:none;\">"+"Maximize"+"</span></a>";
//            }        
//                     
//               
//    
//    }

//}

function ProcessClientClickforRHS(node) {
    
    if (node.Value == "NA")
        return false;


    ToggleTreeViewRHS();
    var divNumberVal = htmlencode(document.getElementById("hiddivNumber").value);
    var currentRow = parseInt(divNumberVal);

    if (isNaN(currentRow)) {
        return;
    }

    var currentDivElement = "RHS" + currentRow;
    var divObj = document.getElementById(currentDivElement);
    if (node.Value == "BuildExp") {
        OpenTreeView(selectedRow);
        return false;
    }
    else if (node.Value == "inpVal") {
        var txtHtml = "<input type=\"Text\" id=\"txt1\" class='Input_WindowsOlive' Onchange=\"javascript:textOnchange(this,'RHS" + currentRow + "')\">";
        divObj.innerHTML = txtHtml;
        var cmbRHSobj = document.getElementById("cmbRHS");
        cmbRHSobj.style.display = "none";
    }
    else {
        divObj.innerHTML = node.Text;
        imageRHSObj.style.display = "none";
        inputRHSObj.style.display = "none";
    }
    return false;
}



function ProcessClientClick(sender, eventArgs) {
    var node = eventArgs.get_node();
    lhsvalue = node.get_value();
    if (lhsvalue == "NA")
        return false;

    var splitValue = lhsvalue.split("`");

    var nodeValue = splitValue[0];

    var divNumberVal = htmlencode(document.getElementById("hiddivNumber").value);
    var currentRow = parseInt(divNumberVal);

    if (isNaN(currentRow)) {
        return;
    }

    selectedRow = currentRow;
    var currentDivElement = "LHS" + currentRow;
    document.getElementById("hidLHStype").value = nodeValue;

    var spliArr = nodeValue.split("~~");

    if (spliArr[0] == "BEXP") {
        OpenEXPBuilder(selectedRow);
        return false;
    }
    else {
        HideTreeView();

        if (objTreeRHSMode == 0) {

            if (spliArr[1] == "ent")
                return false;
            var divObj1 = document.getElementById(currentDivElement);
            var nodeText = "";

            //	            if(spliArr[0].length>20)
            //	            {
            //	                nodeText =spliArr[0].substring(0,20)+".."; 
            //	            }
            //	            else
            //	                nodeText =spliArr[0]; 


            //CHECKPOINT
            spliArr[0] = TruncateString(spliArr[0]);
            if (spliArr[0].length > 27) {
                if (spliArr[0].substring(0, 8) == "Variable") {
                    var length = spliArr[0].length;
                    nodeText = spliArr[0].substring(0, 3) + ".." + spliArr[0].substring(length - 23, length);
                }
                else if (spliArr[0].substring(0, 11) == "XmlVariable") {
                    var length = spliArr[0].length;
                    nodeText = spliArr[0].substring(0, 6) + ".." + spliArr[0].substring(length - 17, length);
                }

                else {
                    var length = spliArr[0].length;
                    nodeText = spliArr[0].substring(0, 6) + ".." + spliArr[0].substring(length - 17, length);
                }
            }
            else
                nodeText = spliArr[0];
            var selectedNodeTxt = "<A class=\"GridHyperlinkStyle\" id=\"link" + currentRow + "\"   onmouseover=\"Javascript:alterLink(this," + currentRow + "," + currentRow + ",event,'LHS')\" onclick=\"Javascript:alterLink(this," + currentRow + "," + currentRow + ",event,'LHS')\" href=\"#\">" + nodeText + "</A>";
            divObj1.innerHTML = selectedNodeTxt + "&nbsp;";//newstring;

            document.getElementById("DivDelImage" + selectedRow).innerHTML = "<a href=\"#\"><img id=\"ObjImage" + selectedRow + "\" src='" + objectTreeImg + "' alt='" + ConditionObjTreeLocal + "' border=0 onclick=\"javascript:DisplayObjectTree(" + selectedRow + ")\"></a>&nbsp;&nbsp;<a href=\"#\"><img id=\"DelImage" + selectedRow + "\" alt='" + ConditionDeleteLocal + "' title='" + ConditionDeleteLocal + "' src='" + delteRowImg + "' border=0 onclick=\"javascript:DeleteRow(" + selectedRow + ")\"></a>";

            var tableObject = document.getElementById("TableExpression" + currentRow);
            tableObject.className = "tab";

            document.getElementById("hidLHStype").value = spliArr[0];

            var MHS = document.getElementById("MHS" + currentRow);

            var nextRowHTML = AddRow(currentRow);

            var menudivObj = document.getElementById("divlnkmenu" + currentRow);
            menudivObj.innerHTML = "<a href=\"#\" id=\"lnkMenu" + currentRow + "\"><img src='" + menuImgSrc + "' id=\"imageMenu" + currentRow + "\" alt=" + ConditionParenthesesLocal + " title=" + ConditionParenthesesLocal + " border=0 onclick=\"javascript:OpenMenu(this," + currentRow + ")\"></a>";


            if (nextRowHTML != "")
                document.getElementById("divExpressionLayers").innerHTML = document.getElementById("divExpressionLayers").innerHTML + nextRowHTML;

            var MHS = document.getElementById("MHS" + currentRow);
            findPos(MHS);

            var currentDivElement = "MHS" + currentRow;
            var divObj = document.getElementById(currentDivElement);
            var selectedNodeTxt = "";
            //Support for bool Operator. Enabling only equals if bool type is selected
            if (spliArr[2] == "bool") {
                spliArr[2] = "System.Boolean";
            };
              	    
            if ((spliArr[2] == "date") || (spliArr[2] == "System.DateTime")) {

                selectedNodeTxt = "<A class=\"GridHyperlinkStyle\" id=\"link" + currentRow + "\" onmouseover=\"Javascript:alterLink(this," + currentRow + "," + currentRow + ",event,'MHS')\" onclick=\"Javascript:alterLink(this," + currentRow + "," + currentRow + ",event,'MHS')\" href=\"#\">On</A>";
                eval("window.Row" + currentRow + " =new ConditionRow('On')");
                eval("window.Row" + currentRow + ".LHSColumn.DisplayText=spliArr[0]");
                eval("window.Row" + currentRow + ".LHSColumn.Actualtext=spliArr[1]");

                if (spliArr[2].indexOf('$$') == -1) {
                    eval("window.Row" + currentRow + ".LHSColumn.DataType=spliArr[2]");
                    eval("window.Row" + currentRow + ".LHSColumn.RefFunction=spliArr[3]");
                    eval("window.Row" + currentRow + ".LHSColumn.ParamList=spliArr[5]");
                }
                else {
                    var parameters = spliArr[2].split('$$');
                    eval("window.Row" + currentRow + ".LHSColumn.DataType=spliArr[6]");
                    eval("window.Row" + currentRow + ".LHSColumn.RefFunction=parameters[3]");
                    eval("window.Row" + currentRow + ".LHSColumn.ParamList=parameters[0]");
                }
            }
            else {

                selectedNodeTxt = "<A class=\"GridHyperlinkStyle\" id=\"link" + currentRow + "\" onmouseover=\"Javascript:alterLink(this," + currentRow + "," + currentRow + ",event,'MHS')\" onclick=\"Javascript:alterLink(this," + currentRow + "," + currentRow + ",event,'MHS')\" href=\"#\">Equals</A>";
                eval("window.Row" + currentRow + " =new ConditionRow('Equals')");
                eval("window.Row" + currentRow + ".LHSColumn.DisplayText=spliArr[0]");
                eval("window.Row" + currentRow + ".LHSColumn.Actualtext=spliArr[1]");

                if (spliArr[2] != null) {
                    if (spliArr[2].indexOf('$$') == -1) {
                        eval("window.Row" + currentRow + ".LHSColumn.DataType=spliArr[2]");
                        eval("window.Row" + currentRow + ".LHSColumn.RefFunction=spliArr[3]");
                        eval("window.Row" + currentRow + ".LHSColumn.ParamList=spliArr[5]");
                    }
                    else {

                        var parameters = spliArr[2].split('$$');
                        eval("window.Row" + currentRow + ".LHSColumn.DataType=spliArr[4]");
                        eval("window.Row" + currentRow + ".LHSColumn.RefFunction=parameters[2]");
                        eval("window.Row" + currentRow + ".LHSColumn.ParamList=parameters[0]");
                    }
                }
            }

            if (!IsAddedToArray(currentRow)) {
                var inArrLen = InitialconditionalArray.length;
                InitialconditionalArray[inArrLen] = currentRow + "~" + "S";
            }
            var lhsType = eval("window.Row" + currentRow + ".LHSColumn.DataType");
            mhsComboObject.control.requestItems(lhsType, false);
            mhsComboObject.control.requestItems(lhsType, false);
            //divObj.innerHTML = "&nbsp;" + selectedNodeTxt + "&nbsp;";
            divObj.innerHTML = selectedNodeTxt;
            var divObj3 = document.getElementById("RHS" + currentRow);
            divObj3.innerHTML = HtmlDecode("&lt;a href=&quot;#&quot; id=&quot;rhsLink" + currentRow + "&quot; class=&quot;GridHyperlinkStyle&quot; OnMouseOver=&quot;javascript:alterLink(this," + currentRow + "," + currentRow + ",event,'RHS')&quot; Onclick=&quot;javascript:alterLink(this," + currentRow + "," + currentRow + ",event,'RHS')&quot;id=&quot;val1&quot; name=&quot;rhsLink" + currentRow + "&quot;&gt;" + conditionEnterValueLocal + "&lt;a&gt");
        }
        else {
            var selectedNodeTxt = "";
            if (spliArr[1] == "ent") {
                selectedNodeTxt = "<A class=\"GridHyperlinkStyle\" id=\"rhsLink" + currentRow + "\"   onmouseover=\"Javascript:alterLink(this," + currentRow + "," + currentRow + ",event,'RHS')\" onclick=\"Javascript:alterLink(this," + currentRow + "," + currentRow + ",event,'RHS')\" href=\"#\">" + conditionEnterValueLocal + "</A>";

                if (eval("window.Row" + currentRow) != null) {
                    eval("window.Row" + currentRow + ".RHSMode='default'");
                    eval("window.Row" + currentRow + ".RHSColumn=new ConditionColumn()");

                }
            }
            else {
                var nodeText = "";
                //	        if(spliArr[0].length>20)
                //	        {
                //	            nodeText =spliArr[0].substring(0,20)+".."; 
                //	        }
                //	        else
                //	            nodeText =spliArr[0]; 
                //CHECKPOINT
                spliArr[0] = TruncateString(spliArr[0]);
                if (spliArr[0].length > 27) {
                    if (spliArr[0].substring(0, 8) == "Variable") {
                        var length = spliArr[0].length;
                        nodeText = spliArr[0].substring(0, 3) + ".." + spliArr[0].substring(length - 23, length);
                    }
                    else if (spliArr[0].substring(0, 11) == "XmlVariable") {
                        var length = spliArr[0].length;
                        nodeText = spliArr[0].substring(0, 6) + ".." + spliArr[0].substring(length - 17, length);
                    }

                    else {
                        var length = spliArr[0].length;
                        nodeText = spliArr[0].substring(0, 6) + ".." + spliArr[0].substring(length - 17, length);
                    }
                }
                else
                    nodeText = spliArr[0];
                selectedNodeTxt = "<A class=\"GridHyperlinkStyle\" id=\"rhsLink" + currentRow + "\"   onmouseover=\"Javascript:alterLink(this," + currentRow + "," + currentRow + ",event,'RHS')\" onclick=\"Javascript:alterLink(this," + currentRow + "," + currentRow + ",event,'RHS')\" href=\"#\">" + nodeText + "</A>";

                if (eval("window.Row" + currentRow) != null) {
                    eval("window.Row" + currentRow + ".RHSColumn.DisplayText=spliArr[0]");
                    eval("window.Row" + currentRow + ".RHSColumn.Actualtext=spliArr[1]");

                    if (spliArr[2] != null) {
                        if (spliArr[2].indexOf('$$') == -1) {
                            eval("window.Row" + currentRow + ".RHSColumn.DataType=spliArr[2]");
                            //eval("window.Row"+currentRow+".LHSColumn.DataType=spliArr[6]"); 
                            eval("window.Row" + currentRow + ".RHSColumn.RefFunction=spliArr[3]");
                            eval("window.Row" + currentRow + ".RHSColumn.ParamList=spliArr[5]");
                        }
                        else {

                            var parameters = spliArr[2].split('$$');
                            eval("window.Row" + currentRow + ".RHSColumn.DataType=spliArr[4]");
                            eval("window.Row" + currentRow + ".RHSColumn.RefFunction=parameters[2]");
                            eval("window.Row" + currentRow + ".RHSColumn.ParamList=parameters[0]");
                        }
                    }
                    eval("window.Row" + currentRow + ".RHSMode='ObjTree'");
                }
            }
            var divObj3 = document.getElementById("RHS" + currentRow);
            divObj3.innerHTML = selectedNodeTxt;
            objTreeRHSMode = 0;
        }

        if (eval("window.Row" + currentRow) != null) {
            if (currentRow == 1)
                eval("window.Row" + currentRow + ".LogicalOpr=''");
        }

        imageLHSObj.style.display = "none";
        inputLHSObj.style.display = "none";
    }
    return false;
}

function IsAddedToArray(rowNo) {
    var addedtoArray = false;
    for (var i = 0; i < InitialconditionalArray.length; i++) {
        if (InitialconditionalArray[i].indexOf(rowNo + "~" + "S") > -1) {
            addedtoArray = true;
            break;
        }
    }

    return addedtoArray;
}

function ShowAlttext(textObject) {
    var altText = "";
    var x = findPosX(textObject);
    var y = findPosY(textObject);
    
    bubbleWindowObj.style.left = parseInt(x) + 10 + 'px';
    bubbleWindowObj.style.top = parseInt(y) + 30 + 'px';
    bubbleWindowObj.style.visibility = "visible";
    bubbleWindowObj.style.display = "block";
    bubbleWindowObj.style.position = "absolute";

    var divNumberVal = document.getElementById("hiddivNumber").value;
    var currentRow = parseInt(divNumberVal);

    if (isNaN(currentRow)) {
        return;
    }

    if (eval("window.Row" + currentRow) != null) {
        if (HSmode == "L") {
            if (eval("window.Row" + currentRow + ".LHSMode") == "default") {//debugger;
                altText = eval("window.Row" + currentRow + ".LHSColumn.DisplayText");
                if (altText.length > 35) {
                    var count = altText.length / 35;
                    count = Math.floor(count);
                    for (i = 1; i <= count; i++) {
                        altText = altText.substring(0, (i * 35) - count) + '<br>' + altText.substring((i * 35) - count, altText.length);
                    }
                }
            }
            else if (eval("window.Row" + currentRow + ".LHSMode") == "Expression") {
                altText = eval("DecodeTheExpressionString(window.Row" + currentRow + ".LHSColumn.ColumnExpression.DisplayExpressionString)");
                if (altText.length > 35) {
                    var count = altText.length / 35;
                    count = Math.floor(count);
                    for (i = 1; i <= count; i++) {
                        altText = altText.substring(0, (i * 35) - count) + '<br>' + altText.substring((i * 35) - count, altText.length);
                    }
                }
            }
            else {
                altText = eval("window.Row" + currentRow + ".LHSColumn.DisplayText");
                if (altText.length > 35) {
                    var count = altText.length / 35;
                    count = Math.floor(count);
                    for (i = 1; i <= count; i++) {
                        altText = altText.substring(0, (i * 35) - count) + '<br>' + altText.substring((i * 35) - count, altText.length);
                    }
                }
            }
        }

        if (HSmode == "R") {
            if (eval("window.Row" + currentRow + ".RHSMode") == "default") {
                altText = eval("window.Row" + currentRow + ".RHSValue");
                if (altText.length > 35) {
                    var count = altText.length / 35;
                    count = Math.floor(count);
                    for (i = 1; i <= count; i++) {
                        altText = altText.substring(0, (i * 35) - count) + '<br>' + altText.substring((i * 35) - count, altText.length);
                    }
                }
            }
            else if (eval("window.Row" + currentRow + ".RHSMode") == "Expression") {
                altText = eval("DecodeTheExpressionString(window.Row" + currentRow + ".RHSColumn.ColumnExpression.DisplayExpressionString)");
                if (altText.length > 35) {
                    var count = altText.length / 35;
                    count = Math.floor(count);
                    for (i = 1; i <= count; i++) {
                        altText = altText.substring(0, (i * 35) - count) + '<br>' + altText.substring((i * 35) - count, altText.length);
                    }
                }
            }
            else {
                altText = eval("window.Row" + currentRow + ".RHSColumn.DisplayText");
                if (altText.length > 35) {
                    var count = altText.length / 35;
                    count = Math.floor(count);
                    for (i = 1; i <= count; i++) {
                        altText = altText.substring(0, (i * 35) - count) + '<br>' + altText.substring((i * 35) - count, altText.length);
                    }
                }
            }
        }
    }

    if (trim(altText) == "") {
        if (textObject.id == "txtRHS")

            altText = conditionEnterValueLocal;

        if (trim(altText) == "")

            altText = conditionSelectLocal;

    }


    bubbleWindowObj.innerHTML = altText;
}

function HideAlttext() {
    //divbubbleObj = document.getElementById("bubbleDiv");
    bubbleWindowObj.innerHTML = "";
    bubbleWindowObj.style.display = "none";

}

function windowmousemovehandler(e) {
    //document.onmousemove=windowmousemovehandler;
    if (!e) e = event;
    divbubbleObj = document.getElementById("bubbleDiv");
    divbubbleObj.style.visibility = "visible";
    divbubbleObj.style.display = "block";
    divbubbleObj.style.position = "absolute";
    divbubbleObj.innerHTML = "Hi";
    divbubbleObj.style.left = parseInt(e.clientX) + 10 + 'px';
    divbubbleObj.style.top = parseInt(e.clientY) + 10 + 'px';
}

function OpenEXPBuilder(curRow) {
    var winHeight = 0;
    var mode = "";

    if (eval("window.Row" + curRow) == null) {
        eval("window.Row" + curRow + " =new ConditionRow('Equals')");
    }

    if (objTreeLHSMode == 1) {
        eval("window.Row" + curRow + ".LHSMode='Expression'");
        mode = "LHS";
    }
    else {
        mode = "RHS";
        eval("window.Row" + curRow + ".RHSMode='Expression'");
    }

    if (browserCode == 1) winHeight = 485;
    else winHeight = 491;
    var currentRow = document.getElementById("hiddivNumber").value;
    expbuilderURl = expbuilderURl.replace("src=Decision", "Src=Con");

    var height = screen.availHeight / 2;
    var width = screen.width / 2;
    var topValue = (height - 300 / 2);
    var leftValue = (width - 522 / 2);
    var topText = 'top=' + topValue;
    var leftText = 'left=' + leftValue;
    var alignment = topText + ',' + leftText;

    window.open(expbuilderURl + "&selRow=" + currentRow + "&mode=" + mode, "LHS" + curRow, 'height=' + winHeight + ',width=840,resizable=yes,' + alignment + ',scrollbars=no,toolbars=0');
}


//Function for handling onchange event for cmbMHS
function HandleChangeMHS(combo, eventArgs) {
    var item = eventArgs.get_item();
    var divNumberVal = htmlencode(document.getElementById("hiddivNumber").value);
    var currentRow = parseInt(divNumberVal);

    if (isNaN(currentRow)) {
        return;
    }

    var currentDivElement = "MHS" + currentRow;
    var divObj = document.getElementById(currentDivElement);
    var displaytext = item.get_text();

    if (displaytext.length > 15)
        displaytext = displaytext.substring(0, 15) + "..";
    else
        displaytext = item.get_text();

    var selectedNodeTxt = "<A class=\"GridHyperlinkStyle\" id=\"link" + currentRow + "\"    onmouseover=\"Javascript:alterLink(this," + currentRow + "," + currentRow + ",event,'MHS')\" onclick=\"Javascript:alterLink(this," + currentRow + "," + currentRow + ",event,'MHS')\" href=\"#\">" + displaytext + "</A>";

    divObj.innerHTML = "&nbsp;" + selectedNodeTxt + "&nbsp;";

    var splitVal = item.get_value().split('~');

    eval("window.Row" + currentRow + ".MHSActualText=splitVal[0]");
    eval("window.Row" + currentRow + ".MHSDisplayText=item.get_text()");
    mhsComboObject.style.display = "none";
    eval("window.Row" + currentRow + ".OprValidate='no'");
    eval("window.Row" + currentRow + ".RHSValue=''");

    var divObj3 = document.getElementById("RHS" + currentRow);


    if (splitVal[1] == 'false') {
        divObj3.innerHTML = "";

        if (eval("window.Row" + currentRow) != null) {
            eval("window.Row" + currentRow + ".IsRHSExists=false");
        }
    }
    else {
        if (splitVal.length == 3) {
            if (splitVal[2] == "int") {
                eval("window.Row" + currentRow + ".OprValidate='yes'");
            }
        }

        divObj3.innerHTML = HtmlDecode("&lt;a href=&quot;#&quot; id=&quot;rhsLink" + currentRow + "&quot; class=&quot;GridHyperlinkStyle&quot; OnMouseOver=&quot;javascript:alterLink(this," + currentRow + "," + currentRow + ",event,'RHS')&quot; Onclick=&quot;javascript:alterLink(this," + currentRow + "," + currentRow + ",event,'RHS')&quot;id=&quot;val1&quot; name=&quot;rhsLink" + currentRow + "&quot;&gt;" + conditionEnterValueLocal + "&lt;a&gt");
        if (eval("window.Row" + currentRow) != null)
            eval("window.Row" + currentRow + ".IsRHSExists=true");
    }
}


function HandleChangeOperator(combo, eventArgs) {
    var item = eventArgs.get_item();
    var divNumberVal = htmlencode(document.getElementById("hiddivNumber").value);
    var currentRow = parseInt(divNumberVal);

    if (isNaN(currentRow)) {
        return;
    }

    var currentDivElement = "divlnkOPR" + currentRow;
    var divObj = document.getElementById(currentDivElement);
    var selectedNodeTxt = "<A class=\"GridHyperlinkStyle\" id=\"link" + currentRow + "\"    onmouseover=\"Javascript:alterLink(this," + currentRow + "," + currentRow + ",event,'OPR')\" onclick=\"Javascript:alterLink(this," + currentRow + "," + currentRow + ",event,'OPR')\" href=\"#\">" + item.get_text() + "</A>";
    if (eval("window.Row" + currentRow) != null)
        eval("window.Row" + currentRow + ".LogicalOpr=item.get_text()");
    divObj.innerHTML = selectedNodeTxt;
    oprComboObject.style.display = "none";
    boolComboObject.style.display = "none";
}

function HandleChangeBoolean(combo, eventArgs) {
    var item = eventArgs.get_item();
    var divNumberVal = htmlencode(document.getElementById("hiddivNumber").value);
    var currentRow = parseInt(divNumberVal);

    if (isNaN(currentRow)) {
        return;
    }

    var currentDivElement = "RHS" + currentRow;
    var divObj = document.getElementById(currentDivElement);
    selectedNodeTxt = "<A class=\"GridHyperlinkStyle\" id=\"rhsLink" + currentRow + "\"   onmouseover=\"Javascript:alterLink(this," + currentRow + "," + currentRow + ",event,'RHS')\" onclick=\"Javascript:alterLink(this," + currentRow + "," + currentRow + ",event,'RHS')\" href=\"#\">" + item.get_text() + "</A>";
    if (eval("window.Row" + currentRow) != null)
        eval("window.Row" + currentRow + ".RHSValue=item.get_text()");
    divObj.innerHTML = selectedNodeTxt;
    //imageBoolObj.style.display = "none";
    //inputBoolObj.style.display = "none";
    boolComboObject.style.display = "none";
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




function findPos(ctlObj) {
    var element = ctlObj;
    var x1 = 0;
    var y1 = element.offsetHeight;

    //Walk up the DOM and add up all of the offset positions.
    while (element.offsetParent && element.tagName.toUpperCase() != 'BODY') {
        x1 += element.offsetLeft;
        y1 += element.offsetTop;
        element = element.offsetParent;
    }

    x1 += element.offsetLeft;
    y1 += element.offsetTop;

    divXPos = x1;
    divYPos = y1;
}


function AddRow(currentRow) {
    var nextRow = parseInt(currentRow) + 1;
    var nextRowDivObj = document.getElementById("divExpressionLayer" + nextRow);
    var inHTMl = "";

    if (nextRowDivObj == null) {
        inHTMl = "<div id=\"divExpressionLayer" + nextRow + "\" style=\"width:100%;\">";
        if (parseInt(currentRow) % 2 == 0) {
            inHTMl = inHTMl + "<table width=\"100%\" cellspacing=0 cellpadding=0 border=0 style=\"height:40px;background-color:#f1f1f1\">";
        }
        else {
            inHTMl = inHTMl + "<table width=\"100%\" cellspacing=0 cellpadding=0 border=0 style=\"height:40px;background-color:#e0e1dd\">";
        }

        inHTMl = inHTMl + "<tr>";
        inHTMl = inHTMl + "<td width=\"100%\"colspan=\"5\" > ";
        inHTMl = inHTMl + "<table width=\"100%\" id=\"TableExpression" + nextRow + "\"  border=0 cellspacing=0 cellpadding=0>";
        inHTMl = inHTMl + "<tr>";
        inHTMl = inHTMl + "<td colspan=4>";
        inHTMl = inHTMl + "<table width=100% cellspacing=0 cellpadding=0 border=0 style=\"height:40px;\">";
        inHTMl = inHTMl + "<tr>";

        inHTMl = inHTMl + "<td style=\"width:5%;padding-left:10px\"  class=\"description\"><div id=\"divlnkmenu" + nextRow + "\" style=\"DISPLAY: inline;width:10px; \">&nbsp;</DIV></td>";
        inHTMl = inHTMl + "<td width=5% class=\"description\"> <div id=\"divlnkOPR" + nextRow + "\" style=\"DISPLAY: inline;width:30px; \"><A class=\"GridHyperlinkStyle\" id=\"link" + nextRow + "\" onmouseover=\"Javascript:alterLink(this," + nextRow + "," + nextRow + ",event,'OPR')\" onclick=\"Javascript:alterLink(this," + nextRow + "," + nextRow + ",event,'OPR')\" href=\"#\">and</A></DIV></td>";
        inHTMl = inHTMl + "<td width=1% class=\"description\"><div id=\"divBrac" + nextRow + "\" style=\"DISPLAY: inline;width:30px \">&nbsp;</DIV></td>";
        inHTMl = inHTMl + "<td width=20% class=\"description\"><div id=\"LHS" + nextRow + "\" style=\"padding-left:20px;text-align:left;width:170px\"><A class=\"GridHyperlinkStyle\" id=\"link" + nextRow + "\"  onmouseover=\"Javascript:alterLink(this," + nextRow + "," + nextRow + ",event,'LHS')\" onclick=\"Javascript:alterLink(this," + nextRow + "," + nextRow + ",event,'LHS')\" href=\"#\">Select</A></div></td>";
        inHTMl = inHTMl + "<td width=17% class=\"description\"><div id= \"MHS" + nextRow + "\" style=\"padding-left:14px;text-align:left;width:140px;\">&nbsp;</div></td>";
        inHTMl = inHTMl + "<td width=33% class=\"description\"><div id=\"RHS" + nextRow + "\" style=\"padding-left:14px;text-align:left; width:170px;\">&nbsp;</div></td>";
        inHTMl = inHTMl + "<td width=1% class=\"description\"><div id=\"divRBrac" + nextRow + "\" style=\"text-align:left;width:30px; \">&nbsp;</DIV></td>";
        inHTMl = inHTMl + "<td width=10% class=\"description\"><div id=\"DivDelImage" + nextRow + "\" style=\"text-align:left;width:40px;\">&nbsp;</div></td>";

        inHTMl = inHTMl + "</tr>";
        inHTMl = inHTMl + "</table>";
        inHTMl = inHTMl + "</td>";
        inHTMl = inHTMl + "</tr>";
        inHTMl = inHTMl + "</table>";
        inHTMl = inHTMl + "</td>";
        inHTMl = inHTMl + "</tr> ";
        inHTMl = inHTMl + "</table>";
        inHTMl = inHTMl + "</div>";
        eval("window.Row" + nextRow + " =new ConditionRow('Equals')");
    }
    return inHTMl;
}

function OntreedivLeave() {

}


function DisplayObjectTree(curRow) {
    var rhsLinkObj = document.getElementById("rhsLink" + curRow);
    Maximize(false, 0);
    HideTreeView();
    objTreeRHSMode = 1;

    objTreeLHSMode = 0;

    var x = findPosX(rhsLinkObj);
    var y = findPosY(rhsLinkObj);

    document.getElementById("cmbLHS").style.visibility = "visible";
    document.getElementById("cmbLHS").style.display = "block";

    inputLHSObj.style.visibility = "visible";
    inputLHSObj.style.display = "block";
    inputLHSObj.style.position = "absolute";
    inputLHSObj.style.left = x + 'px';
    inputLHSObj.style.top = (parseInt(y)) + 'px';

    imageLHSObj.style.visibility = "hidden";
    imageLHSObj.style.display = "block";
    imageLHSObj.style.position = "absolute";
    imageLHSObj.style.left = x + inputLHSObj.offsetWidth + 'px';
    imageLHSObj.style.top = (parseInt(y)) + 'px';
    mhsComboObject.style.display = "none";
    oprComboObject.style.display = "none";
    boolComboObject.style.display = "none";
    txtRHSObj.value = "";
    txtRHSObj.style.display = "none";
    CalIMGRHSObj.style.display = "none";
    Maximize(false, 0);
    if (eval("window.Row" + curRow) != null)
        eval("window.Row" + curRow + ".RHSMode='ObjTree'");

    document.getElementById("hiddivNumber").value = curRow;

}

function OnDivScroll() {
    document.getElementById("txtRHS").style.display = "none";
    document.getElementById("CalIMGRHS").style.display = "none";
    inputLHSObj.style.display = "none";
    imageLHSObj.style.display = "none";
    mhsComboObject.style.display = "none";
    oprComboObject.style.display = "none";
    boolComboObject.style.display = "none";
}


function ClickLink(lnkObj, divID) {
    if (lnkObj != null) {
        lnkObj.onclick = function (processedEvent) { OpenContextMenu(this, processedEvent); };
        mainDivId = divID;
    }
}

function OpenContextMenu(clickedElement, e) {
    if (!e) {
        e = window.event;
    }
    e.returnValue = false;
    e.cancelBuble = true;
    var OldContextHandler = document.oncontextmenu;
    document.oncontextmenu = null;
    MenuInstance.OnContext(e, clickedElement);
    document.oncontextmenu = OldContextHandler;
}

function AddBrace(item) {

    var divbraceObj = document.getElementById("divBrac" + mainDivId);
    var rhsbracHtml = "";
    if (item == "A(") {
        divbraceObj.innerHTML = divbraceObj.innerHTML + "(";
        s = divbraceObj.innerHTML;
        s = s.replace(/\s*&nbsp;/, "")
        eval("window.Row" + mainDivId + ".LHSBrace=s");
    }
    else if (item == "A)") {
        document.getElementById("divRBrac" + mainDivId).innerHTML = document.getElementById("divRBrac" + mainDivId).innerHTML + ")";
        rhsbracHtml = document.getElementById("divRBrac" + mainDivId).innerHTML;
        s = rhsbracHtml.replace(/\rhsbracHtml*&nbsp;/, "");
        s = s.replace(/\s*&nbsp;/, "")
        eval("window.Row" + mainDivId + ".RHSBrace=s");
    }
    else if (item == "R(") {
        if (divbraceObj.innerHTML.length != 0) {
            divbraceObj.innerHTML = divbraceObj.innerHTML.substring(0, divbraceObj.innerHTML.length - 1);
            s = divbraceObj.innerHTML;
            s = s.replace(/\s*&nbsp;/, "")
            eval("window.Row" + mainDivId + ".LHSBrace=s");
        }
    }
    else if (item == "R)") {
        if (document.getElementById("divRBrac" + mainDivId).innerHTML.length != 0) {

            document.getElementById("divRBrac" + mainDivId).innerHTML = document.getElementById("divRBrac" + mainDivId).innerHTML.substring(0, document.getElementById("divRBrac" + mainDivId).innerHTML.length - 1);
            s = document.getElementById("divRBrac" + mainDivId).innerHTML;
            s = s.replace(/\s*&nbsp;/, "")
            eval("window.Row" + mainDivId + ".RHSBrace=s");
        }
    }
    MenuDivObj.style.display = "none";
}

/*******************Rowobject*******************/
function ConditionRow(MHS) {
    this.LHSBrace = "";
    this.LHSColumn = new ConditionColumn();
    this.MHSActualText = "EQ";
    this.MHSDisplayText = MHS;
    this.RHSColumn = new ConditionColumn();
    this.LHSMode = "default";
    this.RHSMode = "default";
    this.LogicalOpr = "and";
    this.LHSMode = "default";
    this.RHSValue = "";
    this.RHSBrace = "";
    this.OprValidate = "no";
    this.IsRHSExists = true;
}
/********************************************/
/*******************Columnobject*******************/
function ConditionColumn() {
    this.DisplayText = "";
    this.Actualtext = "";
    this.DataType = "";
    this.RefFunction = "";
    this.ParamList = "";
    this.ColumnMode = "default";
    this.ColumnExpression = new Expression('', '', '', '', '', '', '');
}
/********************************************/

function Expression(DisplayExpressionString, ActualExprtessionString, MethodParameterList, HtmlVerexpString, ReferenceList, ReferencedFunctionList, nodeinfo) {
    this.DisplayExpressionString = DisplayExpressionString;
    this.ActualExprtessionString = ActualExprtessionString;
    this.MethodParameterList = MethodParameterList;
    this.HtmlVerexpString = HtmlVerexpString;
    this.ReferenceList = ReferenceList;
    this.ReferencedFunctionList = ReferencedFunctionList;
    this.NodeInfo = nodeinfo;
}

/*******************Expressionobject*********************/
function Expression(DisplayExpressionString, ActualExprtessionString, MethodParameterList, HtmlVerexpString, ReferenceList, ReferencedFunctionList, nodeinfo) {
    this.DisplayExpressionString = DisplayExpressionString;
    this.ActualExprtessionString = ActualExprtessionString;
    this.MethodParameterList = MethodParameterList;
    this.HtmlVerexpString = HtmlVerexpString;
    this.ReferenceList = ReferenceList;
    this.ReferencedFunctionList = ReferencedFunctionList;
    this.NodeInfo = nodeinfo;
}
/********************************************************/




function DeleteRow(selectedRow) {
    var isRowExsts = true;
    inputLHSObj.style.display = "none";
    imageLHSObj.style.display = "none";
    var RHSTextBox = document.getElementById("txtRHS");
    RHSTextBox.style.display = "none";
    mhsComboObject.style.display = "none";
    oprComboObject.style.display = "none";
    boolComboObject.style.display = "none";    
    MenuDivObj.style.display = "none";

    if (document.getElementById("treeDiv").style.visibility == "visible") {
        HideTreeView();
    }

    document.getElementById("divExpressionLayer" + selectedRow).style.display = "none";

    InitialconditionalArray[selectedRow - 1] = parseInt(selectedRow) + "~" + "H";

    var prevRowsCount = selectedRow - 1;

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
        if (document.getElementById("divExpressionLayer" + parseInt(selectedRow + 1)) != null) {
            for (var i = parseInt(selectedRow + 1); i <= InitialconditionalArray.length + 1; i++) {
                if (document.getElementById("divExpressionLayer" + i) != null) {
                    if (document.getElementById("divExpressionLayer" + i).style.display != "none") {
                        var divOprv = document.getElementById("divlnkOPR" + i);
                        divOprv.innerHTML = "&nbsp;";
                        break;
                    }
                }
            }
        }
    }

}

function ltrim(s) {
    return s.replace(/^\s*/, "");
}

function rtrim(s) {
    return s.replace(/\s*$/, "");
}

function trim(s) {
    return rtrim(ltrim(s));
}

function checkDate(Dtval) {
    var flagval;
    var tempStr;

    for (i = 0; i < Dtval.length; i++) {
        tempStr = Dtval.charAt(i);

        if ((tempStr >= 0) && (tempStr <= 9)) {
        }
        else {
            if (tempStr == "/") {
            }
            else {
                // 
                flagval = false;
                return
                false;
            }
        }
    }
    if (Dtval.indexOf("/") == "-1") {
        //flagval=false;
        return false;
    }

    if (flagval != false) {
        var Dtval1 = Dtval.split("/")

        if ((Dtval1[0] == 0) || (Dtval1[0] > 12)
            || (Dtval1[0].length > 2) || (Dtval1[1] == 0) || (Dtval1[1].length > 2) || (Dtval1[1]
                > 31) || (Dtval1[2] < 1975) || (Dtval1[2] > 2100) || (Dtval1[2].length < 4) || (Dtval1
                [2].length > 4)) {

            //flagval=false;    
            return false;
        }
    }
    return true;
}


function HtmlDecode(s) {
    var out = "";
    if (s == null) return;
    var l = s.length;
    for (var i = 0; i < l; i++) {
        var ch = s.charAt(i);
        if (ch == '&') {
            var semicolonIndex = s.indexOf(';', i + 1);
            if (semicolonIndex > 0) {
                var entity = s.substring(i + 1, semicolonIndex);
                if (entity.length > 1 && entity.charAt(0) == '#') {
                    if (entity.charAt(1) == 'x' || entity.charAt(1) == 'X')
                        ch = String.fromCharCode(eval('0' + entity.substring(1)));
                    else
                        ch = String.fromCharCode(eval(entity.substring(1)));
                }
                else {
                    switch (entity) {
                        case 'quot': ch = String.fromCharCode(0x0022); break;
                        case 'amp': ch = String.fromCharCode(0x0026); break;
                        case 'lt': ch = String.fromCharCode(0x003c); break;
                        case 'gt': ch = String.fromCharCode(0x003e); break;
                        case 'nbsp': ch = String.fromCharCode(0x00a0); break;
                        case 'iexcl': ch = String.fromCharCode(0x00a1); break;
                        case 'cent': ch = String.fromCharCode(0x00a2); break;
                        case 'pound': ch = String.fromCharCode(0x00a3); break;
                        case 'curren': ch = String.fromCharCode(0x00a4); break;
                        case 'yen': ch = String.fromCharCode(0x00a5); break;
                        case 'brvbar': ch = String.fromCharCode(0x00a6); break;
                        case 'sect': ch = String.fromCharCode(0x00a7); break;
                        case 'uml': ch = String.fromCharCode(0x00a8); break;
                        case 'copy': ch = String.fromCharCode(0x00a9); break;
                        case 'ordf': ch = String.fromCharCode(0x00aa); break;
                        case 'laquo': ch = String.fromCharCode(0x00ab); break;
                        case 'not': ch = String.fromCharCode(0x00ac); break;
                        case 'shy': ch = String.fromCharCode(0x00ad); break;
                        case 'reg': ch = String.fromCharCode(0x00ae); break;
                        case 'macr': ch = String.fromCharCode(0x00af); break;
                        case 'deg': ch = String.fromCharCode(0x00b0); break;
                        case 'plusmn': ch = String.fromCharCode(0x00b1); break;
                        case 'sup2': ch = String.fromCharCode(0x00b2); break;
                        case 'sup3': ch = String.fromCharCode(0x00b3); break;
                        case 'acute': ch = String.fromCharCode(0x00b4); break;
                        case 'micro': ch = String.fromCharCode(0x00b5); break;
                        case 'para': ch = String.fromCharCode(0x00b6); break;
                        case 'middot': ch = String.fromCharCode(0x00b7); break;
                        case 'cedil': ch = String.fromCharCode(0x00b8); break;
                        case 'sup1': ch = String.fromCharCode(0x00b9); break;
                        case 'ordm': ch = String.fromCharCode(0x00ba); break;
                        case 'raquo': ch = String.fromCharCode(0x00bb); break;
                        case 'frac14': ch = String.fromCharCode(0x00bc); break;
                        case 'frac12': ch = String.fromCharCode(0x00bd); break;
                        case 'frac34': ch = String.fromCharCode(0x00be); break;

                        case 'iquest': ch = String.fromCharCode(0x00bf); break;

                        case 'Agrave': ch = String.fromCharCode(0x00c0); break;

                        case 'Aacute': ch = String.fromCharCode(0x00c1); break;

                        case 'Acirc': ch = String.fromCharCode(0x00c2); break;

                        case 'Atilde': ch = String.fromCharCode(0x00c3); break;

                        case 'Auml': ch = String.fromCharCode(0x00c4); break;

                        case 'Aring': ch = String.fromCharCode(0x00c5); break;

                        case 'AElig': ch = String.fromCharCode(0x00c6); break;

                        case 'Ccedil': ch = String.fromCharCode(0x00c7); break;

                        case 'Egrave': ch = String.fromCharCode(0x00c8); break;

                        case 'Eacute': ch = String.fromCharCode(0x00c9); break;

                        case 'Ecirc': ch = String.fromCharCode(0x00ca); break;

                        case 'Euml': ch = String.fromCharCode(0x00cb); break;

                        case 'Igrave': ch = String.fromCharCode(0x00cc); break;

                        case 'Iacute': ch = String.fromCharCode(0x00cd); break;

                        case 'Icirc': ch = String.fromCharCode(0x00ce); break;

                        case 'Iuml': ch = String.fromCharCode(0x00cf); break;

                        case 'ETH': ch = String.fromCharCode(0x00d0); break;

                        case 'Ntilde': ch = String.fromCharCode(0x00d1); break;

                        case 'Ograve': ch = String.fromCharCode(0x00d2); break;

                        case 'Oacute': ch = String.fromCharCode(0x00d3); break;

                        case 'Ocirc': ch = String.fromCharCode(0x00d4); break;

                        case 'Otilde': ch = String.fromCharCode(0x00d5); break;

                        case 'Ouml': ch = String.fromCharCode(0x00d6); break;

                        case 'times': ch = String.fromCharCode(0x00d7); break;

                        case 'Oslash': ch = String.fromCharCode(0x00d8); break;

                        case 'Ugrave': ch = String.fromCharCode(0x00d9); break;

                        case 'Uacute': ch = String.fromCharCode(0x00da); break;

                        case 'Ucirc': ch = String.fromCharCode(0x00db); break;

                        case 'Uuml': ch = String.fromCharCode(0x00dc); break;

                        case 'Yacute': ch = String.fromCharCode(0x00dd); break;

                        case 'THORN': ch = String.fromCharCode(0x00de); break;

                        case 'szlig': ch = String.fromCharCode(0x00df); break;

                        case 'agrave': ch = String.fromCharCode(0x00e0); break;

                        case 'aacute': ch = String.fromCharCode(0x00e1); break;

                        case 'acirc': ch = String.fromCharCode(0x00e2); break;

                        case 'atilde': ch = String.fromCharCode(0x00e3); break;

                        case 'auml': ch = String.fromCharCode(0x00e4); break;

                        case 'aring': ch = String.fromCharCode(0x00e5); break;

                        case 'aelig': ch = String.fromCharCode(0x00e6); break;

                        case 'ccedil': ch = String.fromCharCode(0x00e7); break;

                        case 'egrave': ch = String.fromCharCode(0x00e8); break;

                        case 'eacute': ch = String.fromCharCode(0x00e9); break;

                        case 'ecirc': ch = String.fromCharCode(0x00ea); break;

                        case 'euml': ch = String.fromCharCode(0x00eb); break;

                        case 'igrave': ch = String.fromCharCode(0x00ec); break;

                        case 'iacute': ch = String.fromCharCode(0x00ed); break;

                        case 'icirc': ch = String.fromCharCode(0x00ee); break;

                        case 'iuml': ch = String.fromCharCode(0x00ef); break;

                        case 'eth': ch = String.fromCharCode(0x00f0); break;

                        case 'ntilde': ch = String.fromCharCode(0x00f1); break;

                        case 'ograve': ch = String.fromCharCode(0x00f2); break;

                        case 'oacute': ch = String.fromCharCode(0x00f3); break;

                        case 'ocirc': ch = String.fromCharCode(0x00f4); break;

                        case 'otilde': ch = String.fromCharCode(0x00f5); break;

                        case 'ouml': ch = String.fromCharCode(0x00f6); break;

                        case 'divide': ch = String.fromCharCode(0x00f7); break;

                        case 'oslash': ch = String.fromCharCode(0x00f8); break;

                        case 'ugrave': ch = String.fromCharCode(0x00f9); break;

                        case 'uacute': ch = String.fromCharCode(0x00fa); break;

                        case 'ucirc': ch = String.fromCharCode(0x00fb); break;

                        case 'uuml': ch = String.fromCharCode(0x00fc); break;

                        case 'yacute': ch = String.fromCharCode(0x00fd); break;

                        case 'thorn': ch = String.fromCharCode(0x00fe); break;

                        case 'yuml': ch = String.fromCharCode(0x00ff); break;

                        case 'OElig': ch = String.fromCharCode(0x0152); break;

                        case 'oelig': ch = String.fromCharCode(0x0153); break;

                        case 'Scaron': ch = String.fromCharCode(0x0160); break;

                        case 'scaron': ch = String.fromCharCode(0x0161); break;

                        case 'Yuml': ch = String.fromCharCode(0x0178); break;

                        case 'fnof': ch = String.fromCharCode(0x0192); break;

                        case 'circ': ch = String.fromCharCode(0x02c6); break;

                        case 'tilde': ch = String.fromCharCode(0x02dc); break;

                        case 'Alpha': ch = String.fromCharCode(0x0391); break;

                        case 'Beta': ch = String.fromCharCode(0x0392); break;

                        case 'Gamma': ch = String.fromCharCode(0x0393); break;

                        case 'Delta': ch = String.fromCharCode(0x0394); break;

                        case 'Epsilon': ch = String.fromCharCode(0x0395); break;

                        case 'Zeta': ch = String.fromCharCode(0x0396); break;

                        case 'Eta': ch = String.fromCharCode(0x0397); break;

                        case 'Theta': ch = String.fromCharCode(0x0398); break;

                        case 'Iota': ch = String.fromCharCode(0x0399); break;

                        case 'Kappa': ch = String.fromCharCode(0x039a); break;

                        case 'Lambda': ch = String.fromCharCode(0x039b); break;

                        case 'Mu': ch = String.fromCharCode(0x039c); break;

                        case 'Nu': ch = String.fromCharCode(0x039d); break;

                        case 'Xi': ch = String.fromCharCode(0x039e); break;

                        case 'Omicron': ch = String.fromCharCode(0x039f); break;

                        case 'Pi': ch = String.fromCharCode(0x03a0); break;

                        case ' Rho ': ch = String.fromCharCode(0x03a1); break;

                        case 'Sigma': ch = String.fromCharCode(0x03a3); break;

                        case 'Tau': ch = String.fromCharCode(0x03a4); break;

                        case 'Upsilon': ch = String.fromCharCode(0x03a5); break;

                        case 'Phi': ch = String.fromCharCode(0x03a6); break;

                        case 'Chi': ch = String.fromCharCode(0x03a7); break;

                        case 'Psi': ch = String.fromCharCode(0x03a8); break;

                        case 'Omega': ch = String.fromCharCode(0x03a9); break;

                        case 'alpha': ch = String.fromCharCode(0x03b1); break;

                        case 'beta': ch = String.fromCharCode(0x03b2); break;

                        case 'gamma': ch = String.fromCharCode(0x03b3); break;

                        case 'delta': ch = String.fromCharCode(0x03b4); break;

                        case 'epsilon': ch = String.fromCharCode(0x03b5); break;

                        case 'zeta': ch = String.fromCharCode(0x03b6); break;

                        case 'eta': ch = String.fromCharCode(0x03b7); break;

                        case 'theta': ch = String.fromCharCode(0x03b8); break;

                        case 'iota': ch = String.fromCharCode(0x03b9); break;

                        case 'kappa': ch = String.fromCharCode(0x03ba); break;

                        case 'lambda': ch = String.fromCharCode(0x03bb); break;

                        case 'mu': ch = String.fromCharCode(0x03bc); break;

                        case 'nu': ch = String.fromCharCode(0x03bd); break;

                        case 'xi': ch = String.fromCharCode(0x03be); break;

                        case 'omicron': ch = String.fromCharCode(0x03bf); break;

                        case 'pi': ch = String.fromCharCode(0x03c0); break;

                        case 'rho': ch = String.fromCharCode(0x03c1); break;

                        case 'sigmaf': ch = String.fromCharCode(0x03c2); break;

                        case 'sigma': ch = String.fromCharCode(0x03c3); break;

                        case 'tau': ch = String.fromCharCode(0x03c4); break;

                        case 'upsilon': ch = String.fromCharCode(0x03c5); break;

                        case 'phi': ch = String.fromCharCode(0x03c6); break;

                        case 'chi': ch = String.fromCharCode(0x03c7); break;

                        case 'psi': ch = String.fromCharCode(0x03c8); break;

                        case 'omega': ch = String.fromCharCode(0x03c9); break;

                        case 'thetasym': ch = String.fromCharCode(0x03d1); break;

                        case 'upsih': ch = String.fromCharCode(0x03d2); break;

                        case 'piv': ch = String.fromCharCode(0x03d6); break;

                        case 'ensp': ch = String.fromCharCode(0x2002); break;

                        case 'emsp': ch = String.fromCharCode(0x2003); break;

                        case 'thinsp': ch = String.fromCharCode(0x2009); break;

                        case 'zwnj': ch = String.fromCharCode(0x200c); break;

                        case 'zwj': ch = String.fromCharCode(0x200d); break;

                        case 'lrm': ch = String.fromCharCode(0x200e); break;

                        case 'rlm': ch = String.fromCharCode(0x200f); break;

                        case 'ndash': ch = String.fromCharCode(0x2013); break;

                        case 'mdash': ch = String.fromCharCode(0x2014); break;

                        case 'lsquo': ch = String.fromCharCode(0x2018); break;

                        case 'rsquo': ch = String.fromCharCode(0x2019); break;

                        case 'sbquo': ch = String.fromCharCode(0x201a); break;

                        case 'ldquo': ch = String.fromCharCode(0x201c); break;

                        case 'rdquo': ch = String.fromCharCode(0x201d); break;

                        case 'bdquo': ch = String.fromCharCode(0x201e); break;

                        case 'dagger': ch = String.fromCharCode(0x2020); break;

                        case 'Dagger': ch = String.fromCharCode(0x2021); break;

                        case 'bull': ch = String.fromCharCode(0x2022); break;

                        case 'hellip': ch = String.fromCharCode(0x2026); break;

                        case 'permil': ch = String.fromCharCode(0x2030); break;

                        case 'prime': ch = String.fromCharCode(0x2032); break;

                        case 'Prime': ch = String.fromCharCode(0x2033); break;

                        case 'lsaquo': ch = String.fromCharCode(0x2039); break;

                        case 'rsaquo': ch = String.fromCharCode(0x203a); break;

                        case 'oline': ch = String.fromCharCode(0x203e); break;

                        case 'frasl': ch = String.fromCharCode(0x2044); break;

                        case 'euro': ch = String.fromCharCode(0x20ac); break;

                        case 'image': ch = String.fromCharCode(0x2111); break;

                        case 'weierp': ch = String.fromCharCode(0x2118); break;

                        case 'real': ch = String.fromCharCode(0x211c); break;

                        case 'trade': ch = String.fromCharCode(0x2122); break;

                        case 'alefsym': ch = String.fromCharCode(0x2135); break;

                        case 'larr': ch = String.fromCharCode(0x2190); break;

                        case 'uarr': ch = String.fromCharCode(0x2191); break;

                        case 'rarr': ch = String.fromCharCode(0x2192); break;

                        case 'darr': ch = String.fromCharCode(0x2193); break;

                        case 'harr': ch = String.fromCharCode(0x2194); break;

                        case 'crarr': ch = String.fromCharCode(0x21b5); break;

                        case 'lArr': ch = String.fromCharCode(0x21d0); break;

                        case 'uArr': ch = String.fromCharCode(0x21d1); break;

                        case 'rArr': ch = String.fromCharCode(0x21d2); break;

                        case 'dArr': ch = String.fromCharCode(0x21d3); break;

                        case 'hArr': ch = String.fromCharCode(0x21d4); break;

                        case 'forall': ch = String.fromCharCode(0x2200); break;

                        case 'part': ch = String.fromCharCode(0x2202); break;

                        case 'exist': ch = String.fromCharCode(0x2203); break;

                        case 'empty': ch = String.fromCharCode(0x2205); break;

                        case 'nabla': ch = String.fromCharCode(0x2207); break;

                        case 'isin': ch = String.fromCharCode(0x2208); break;

                        case 'notin': ch = String.fromCharCode(0x2209); break;

                        case 'ni': ch = String.fromCharCode(0x220b); break;

                        case 'prod': ch = String.fromCharCode(0x220f); break;

                        case 'sum': ch = String.fromCharCode(0x2211); break;

                        case 'minus': ch = String.fromCharCode(0x2212); break;

                        case 'lowast': ch = String.fromCharCode(0x2217); break;

                        case 'radic': ch = String.fromCharCode(0x221a); break;

                        case 'prop': ch = String.fromCharCode(0x221d); break;

                        case 'infin': ch = String.fromCharCode(0x221e); break;

                        case 'ang': ch = String.fromCharCode(0x2220); break;

                        case 'and': ch = String.fromCharCode(0x2227); break;

                        case 'or': ch = String.fromCharCode(0x2228); break;

                        case 'cap': ch = String.fromCharCode(0x2229); break;

                        case 'cup': ch = String.fromCharCode(0x222a); break;

                        case 'int': ch = String.fromCharCode(0x222b); break;

                        case 'there4': ch = String.fromCharCode(0x2234); break;

                        case 'sim': ch = String.fromCharCode(0x223c); break;

                        case 'cong': ch = String.fromCharCode(0x2245); break;

                        case 'asymp': ch = String.fromCharCode(0x2248); break;

                        case 'ne': ch = String.fromCharCode(0x2260); break;

                        case 'equiv': ch = String.fromCharCode(0x2261); break;

                        case 'le': ch = String.fromCharCode(0x2264); break;

                        case 'ge': ch = String.fromCharCode(0x2265); break;

                        case 'sub': ch = String.fromCharCode(0x2282); break;

                        case 'sup': ch = String.fromCharCode(0x2283); break;

                        case 'nsub': ch = String.fromCharCode(0x2284); break;

                        case 'sube': ch = String.fromCharCode(0x2286); break;

                        case 'supe': ch = String.fromCharCode(0x2287); break;

                        case 'oplus': ch = String.fromCharCode(0x2295); break;

                        case 'otimes': ch = String.fromCharCode(0x2297); break;

                        case 'perp': ch = String.fromCharCode(0x22a5); break;

                        case 'sdot': ch = String.fromCharCode(0x22c5); break;

                        case 'lceil': ch = String.fromCharCode(0x2308); break;

                        case 'rceil': ch = String.fromCharCode(0x2309); break;

                        case 'lfloor': ch = String.fromCharCode(0x230a); break;

                        case 'rfloor': ch = String.fromCharCode(0x230b); break;

                        case 'lang': ch = String.fromCharCode(0x2329); break;

                        case 'rang': ch = String.fromCharCode(0x232a); break;

                        case 'loz': ch = String.fromCharCode(0x25ca); break;

                        case 'spades': ch = String.fromCharCode(0x2660); break;

                        case 'clubs': ch = String.fromCharCode(0x2663); break;

                        case 'hearts': ch = String.fromCharCode(0x2665); break;

                        case 'diams': ch = String.fromCharCode(0x2666); break;

                        default: ch = ''; break;
                    }
                }
                i = semicolonIndex;
            }
        }
        out += ch;
    }
    return out;
}

function EncodeTheExpressionString(expressionString) {
    if (expressionString.indexOf("+") > -1) {
        expressionString = replaceExpressionstring(expressionString, "+", "_x002B_")
    }
    if (expressionString.indexOf("-") > -1) {
        expressionString = replaceExpressionstring(expressionString, "-", "_x002D_")
    }
    if (expressionString.indexOf("/") > -1) {
        expressionString = replaceExpressionstring(expressionString, "/", "_x002F_")
    }
    return expressionString;
}


function DecodeTheExpressionString(expressionString) {
    if (expressionString.indexOf("_x002B_") > -1) {
        expressionString = replaceExpressionstring(expressionString, "_x002B_", "+")
    }
    if (expressionString.indexOf("_x002D_") > -1) {
        expressionString = replaceExpressionstring(expressionString, "_x002D_", "-")
    }
    if (expressionString.indexOf("_x002F_") > -1) {
        expressionString = replaceExpressionstring(expressionString, "_x002F_", "/")
    }
    return expressionString;
}

function replacestring(stringtobereplaced, chartobereplaced, charbywhichreplaced) {
    var out = "";
    if (stringtobereplaced == null) return;
    var l = stringtobereplaced.length;
    for (var i = 0; i < l; i++) {
        var ch = stringtobereplaced.charAt(i);
        if (ch == chartobereplaced) {
            stringtobereplaced = stringtobereplaced.replace(ch, charbywhichreplaced);
        }
    }

    return stringtobereplaced;
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


function ReplaceSplTags(inputString, stringtobereplaced, stringbywhichreplaced) {
    var returnstring = "";

    returnstring = inputString.replace(stringtobereplaced, stringbywhichreplaced);

    if (returnstring.indexOf(stringtobereplaced) > -1) {
        returnstring = ReplaceSplTags(returnstring, stringtobereplaced, stringbywhichreplaced)
    }
    return returnstring;
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

//function rcbDispatcher(N,eventName,eventArgs)
//{
//var comboInstance=null; try {comboInstance=window[N]; }catch (e){}
//if (typeof(comboInstance)=="\x75ndefi\x6e\x65d" || comboInstance==null)
//{return; }
//if (typeof(comboInstance.HandleEvent)!="\x75ndefi\x6e\x65d")
//{comboInstance.HandleEvent(eventName,eventArgs); 
//}
//}  
