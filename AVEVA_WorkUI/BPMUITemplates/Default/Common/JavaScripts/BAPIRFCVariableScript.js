//
// Taken an earlier copy of VariableScript.js. Since the file was modified heavily for Update Variable related changes, we have created a copy of the VariableScript.js
// for BAPIRFCUpdateVariable.aspx page.
// In case of any history reference, please refer to VariableScript.js
//

//Variable declarartion

var lhsObj;
var imageLHSObj;
var inputLHSObj;

var cmbOPRName;
var imageOPRObj;
var inputOPRObj;

var txtRHSObj;
var bubbleWindowObj;

var mode = "LHS";

var expbuilderURl = "";

var delteRowImg;
var ConditionDeleteLocal;
var conditionSelectLocal;
var conditionEnterValueLocal;
var ConditionObjTreeLocal;
var ObjTreeMode = 0;
var txtRHSObj;
var prevRow = 0;
var isObjectTreeInUse = false;

var InitialUpdatedVariableArray = new Array();
var FinalUpdatedVariableArray = new Array();
var SaveconditionalArray = new Array();

var updatedVariableRowList;
var variableListArray = new Array();
var rhsTextValue;

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

function VariableRow()
{
    this.RHSMode = "Default";
    this.LHSColumn = "";
    this.RHSColumn = "";
    this.OPRColumn = "";
    this.ColumnExpression = new Expression('', '', '', '', '', '', '');
}

function Expression(DisplayExpressionString, ActualExprtessionString, MethodParameterList, HtmlVerexpString, ReferenceList, ReferencedFunctionList, nodeinfo)
{
    this.DisplayExpressionString = DisplayExpressionString;
    this.ActualExprtessionString = ActualExprtessionString;
    this.MethodParameterList = MethodParameterList;
    this.HtmlVerexpString = HtmlVerexpString;
    this.ReferenceList = ReferenceList;
    this.ReferencedFunctionList = ReferencedFunctionList;
    this.NodeInfo = nodeinfo;
}

//For placing control on the Link
//When user does mouseover on the link this function will be get called
//Parameters
// linkObject -- HyperLink object
// no -  selected row number
// combo  - LHS  or MHS or RHS
function alterLink(linkObject, no, combo)
{
    document.getElementById("HidY").value = "";
    document.getElementById("HidX").value = "";
    document.getElementById("HidYRHS").value = "";
    document.getElementById("HidXRHS").value = "";
    Maximize(false, 0);
    HideTreeView();
    document.getElementById("txtRHS").style.display = "none";
    document.getElementById("cmbLHS_Input").style.display = "none";
    if (document.getElementById("hiddivNumber") != null)
    {
        var prevRowDivObj = document.getElementById("divExpressionLayer" + document.getElementById("hiddivNumber").value);
        document.getElementById("hiddivNumber").value = no;
        PositionObj1(linkObject, combo);

        mode = combo;
    }

}
function alterLinkEnter(linkObject, no, combo)
{
    document.getElementById("HidY").value = "";
    document.getElementById("HidX").value = "";
    document.getElementById("HidYRHS").value = "";
    document.getElementById("HidXRHS").value = "";
    //Maximize(false,0);
    //HideTreeView();
    document.getElementById("txtLHS").style.display = "none";
    document.getElementById("txtRHS").style.display = "none";
    document.getElementById("cmbLHS_Input").style.display = "none";
    if (document.getElementById("hiddivNumber") != null)
    {
        var prevRowDivObj = document.getElementById("divExpressionLayer" + document.getElementById("hiddivNumber").value);
        document.getElementById("hiddivNumber").value = no;
        PositionObj1(linkObject, combo);

        mode = combo;
    }

}

function alterLinkSelect(linkObject, no, combo)
{
    document.getElementById("HidY").value = "";
    document.getElementById("HidX").value = "";
    document.getElementById("HidYRHS").value = "";
    document.getElementById("HidXRHS").value = "";
    Maximize(false, 0);
    HideTreeView();

    document.getElementById("txtRHS").style.display = "none";
    document.getElementById("cmbLHS_Input").style.display = "none";
    if (document.getElementById("hiddivNumber") != null)
    {
        var prevRowDivObj = document.getElementById("divExpressionLayer" + document.getElementById("hiddivNumber").value);
        document.getElementById("hiddivNumber").value = no;
        PositionObj1(linkObject, combo);

        mode = combo;
    }

}
//Validating a row for valid entries
function validateRows(RowNo)
{
    var Rownumber = RowNo - 1;
    if (eval("window.Row" + Rownumber) != null)
    {
        //alert("t");
        var rhsVal = eval("window.Row" + Rownumber + ".RHSColumn");
        var lhsVal = eval("window.Row" + Rownumber + ".LHSColumn");
        var mhsVal = eval("window.Row" + Rownumber + ".OPRColumn");
        if (eval("window.Row" + Rownumber + ".RHSMode") == "Expression")
        {//
            if ((eval("window.Row" + Rownumber + ".ColumnExpression").DisplayExpressionString == "") || (eval("window.Row" + Rownumber + ".LHSColumn") == ""))
            {
                //objectify(eval("window.Row"+Rownumber+".RHSColumn")).DisplayExpressionString
                imageLHSObj.style.visibility = "hidden";
                imageLHSObj.style.display = "none";
                se.ui.messageDialog.showError(BellyBarTitile, ValidationMsg);
                return false;
            }
            else
            {
                return true;
            }
        }
        else
        {
            if ((rhsVal == "") || (lhsVal == ""))
            {
                imageLHSObj.style.visibility = "hidden";
                imageLHSObj.style.display = "none";
                //Handling inproper validation when the first row was deleted and focus on LHS
                if (Rownumber - 1 < InitialUpdatedVariableArray.length)
                {
                    var rowInfo = InitialUpdatedVariableArray[Rownumber - 1];
                    var rowData = rowInfo.split("~");
                    if (rowData[1] == "S")
                    {
                        se.ui.messageDialog.showError(BellyBarTitile, ValidationMsg);
                        return false;
                    }
                }
            }
            else if (mhsVal == "<##>" && rhsVal.indexOf("XmlVariables.") == -1)
            {
                imageLHSObj.style.visibility = "hidden";
                imageLHSObj.style.display = "none";
                se.ui.messageDialog.showError(BellyBarTitile, "Operator <##> can be used only with xmlvariables");

                return false;
            }
            else
            {
                return true;
            }
        }
    }
}
//Initialize function for setting default behaviour  
function Initialize()
{
    //LHS object
    lhsObj = document.getElementById("cmbLHS");
    //Setting invisibility to the LHS
    imageLHSObj = document.getElementById('cmbLHS_Image');
    inputLHSObj = document.getElementById('cmbLHS_Input');
    imageLHSObj.style.display = "none";
    inputLHSObj.style.display = "none";
    txtLHSObj = document.getElementById('txtLHS');

    //Setting invisibility to the RHS

    //Setting invisibility to the OPR
    imageOPRObj = document.getElementById(cmbOPRName + "_Image");
    inputOPRObj = document.getElementById(cmbOPRName + "_Input");
    imageOPRObj.style.display = "none";
    inputOPRObj.style.display = "none";

    txtRHSObj = document.getElementById('txtRHS');
    txtRHSObj.style.display = "none";

    bubbleWindowObj = document.getElementById("bubbleWindow");
    bubbleWindowObj.style.display = "none";

    txtRHSObj = document.getElementById('txtRHS');
    txtRHSObj.style.display = "none";

    var updatedVariableRowList = document.getElementById("HiddenJsString").value;

    if (updatedVariableRowList != "")
    {
        var variableListArray = objectify(updatedVariableRowList);
        for (var i = 0; i < variableListArray.length; i++)
        {
            var elementNo = parseInt(i + 1);

            var divExpLayerObj = document.getElementById("divExpressionLayer" + elementNo);
            if (variableListArray[i] != null)
            {
                if (divExpLayerObj == null)
                {
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

function CreateRow(currentRow, updatedvariableRow)
{
    var tableObject = document.getElementById("TableExpression" + currentRow);
    tableObject.className = "tab";

    var currentDivElement = "LHS" + currentRow;

    var divObj = document.getElementById(currentDivElement);

    var lhsTextVal = updatedvariableRow.LHSColumn;
    //alert(lhsTextVal);
    //CHECKPOINT
    lhsTextVal = TruncateString(lhsTextVal);
    //EndCHECK

    if (lhsTextVal.length > 32)
    {
        if (lhsTextVal.substring(0, 8) == "Variable")
        {
            var length = lhsTextVal.length;
            lhsTextVal = lhsTextVal.substring(0, 3) + ".." + lhsTextVal.substring(length - 28, length);

        }
        else if (lhsTextVal.substring(0, 11) == "XmlVariable")
        {

            // var attribute="<b>(A)</b>";
            var length = lhsTextVal.length;
            //lhsTextVal.replace(/!/,attribute);
            lhsTextVal = lhsTextVal.substring(0, 6) + ".." + lhsTextVal.substring(length - 25, length);

        }
        else
        {
            var length = lhsTextVal.length;
            lhsTextVal = lhsTextVal.substring(0, 6) + ".." + lhsTextVal.substring(length - 24, length);
        }

    }
    //Building HTML for the LHSDIV            

    var selectedNodeTxt = "<A class=\"hyperText\" id=\"link" + currentRow + "\" onmouseover=\"Javascript:alterLink(this," + currentRow + ",'LHS')\" onclick=\"Javascript:alterLink(this," + currentRow + ",'LHS')\" href=\"#\">" + lhsTextVal + "</A>";
    divObj.innerHTML = selectedNodeTxt + "&nbsp;";

    var MHS = document.getElementById("MHS" + currentRow);
    var mhsTextVal = updatedvariableRow.OPRColumn;
    if (mhsTextVal == "") mhsTextVal = "=";
    var currentMHSDivElementName = "MHS" + currentRow;
    var currentMHSDivElement = document.getElementById(currentMHSDivElementName);
    var TextForOperator = "<A class=\"hyperTextWithoutLink\" id=\"link" + currentRow + "\"   onmouseover=\"Javascript:alterLink(this," + currentRow + ",'OPR')\" onclick=\"Javascript:alterLink(this," + currentRow + ",'OPR')\" href=\"#\">" + mhsTextVal + "</A>";
    currentMHSDivElement.innerHTML = TextForOperator;


    var RHS = document.getElementById("RHS" + currentRow);

    if (updatedvariableRow.RHSMode == "Expression")
    {
        rhsTextValue = objectify(updatedvariableRow.RHSColumn).DisplayExpressionString;
    }
    else
    {
        rhsTextValue = updatedvariableRow.RHSColumn;
    }
    //CHECKPOINT
    rhsTextValue = TruncateString(rhsTextValue);
    //EndCHECK

    if (rhsTextValue.length > 32)
    {
        if (rhsTextValue.substring(0, 8) == "Variable")
        {
            var length = rhsTextValue.length;
            rhsTextValue = rhsTextValue.substring(0, 3) + ".." + rhsTextValue.substring(length - 28, length);

        }
        else if (rhsTextValue.substring(0, 11) == "XmlVariable")
        {
            var length = rhsTextValue.length;
            rhsTextValue = rhsTextValue.substring(0, 6) + ".." + rhsTextValue.substring(length - 25, length);

        }
        else
        {
            var length = rhsTextValue.length;
            rhsTextValue = rhsTextValue.substring(0, 6) + ".." + rhsTextValue.substring(length - 24, length);
        }

    }



    var currentRHSDivElementName = "RHS" + currentRow;
    var currentRHSDivElement = document.getElementById(currentRHSDivElementName);
    var TextForRHS = "<A class=\"hyperText\" id=\"rhsLink" + currentRow + "\"   onmouseover=\"Javascript:alterLink(this," + currentRow + ",'RHS')\" onclick=\"Javascript:alterLink(this," + currentRow + ",'RHS')\" href=\"#\">" + DecodeTheExpressionString(rhsTextValue) + "</A>";
    currentRHSDivElement.innerHTML = TextForRHS;

    document.getElementById("DivObjectTree" + currentRow).innerHTML = "<a href=\"#\"><img id=\"ObjImage" + currentRow + "\" src='" + objectTreeImg + "' alt='" + ConditionObjTreeLocal + "' border=0 onclick=\"javascript:DisplayObjectTree(" + currentRow + ")\"></a>&nbsp;&nbsp;<a href=\"#\"><img id=\"DelImage" + currentRow + "\" alt='" + ConditionDeleteLocal + "' title='" + ConditionDeleteLocal + "' src='" + delteRowImg + "' border=0 onclick=\"javascript:DeleteRow(" + currentRow + ")\"></a>";


    if (eval("window.Row" + currentRow) == null)
        eval("window.Row" + currentRow + " =new VariableRow()");

    eval("window.Row" + currentRow + ".LHSColumn=updatedvariableRow.LHSColumn");
    if (updatedvariableRow.RHSMode == "Expression")
    {
        eval("window.Row" + currentRow + ".RHSColumn=objectify(updatedvariableRow.RHSColumn).DisplayExpressionString");
        var updatedExpression = new Expression();
        updatedExpression = updatedvariableRow.ColumnExpression;
        eval("window.Row" + currentRow + ".ColumnExpression =updatedExpression");
    }
    else
    {
        eval("window.Row" + currentRow + ".RHSColumn=updatedvariableRow.RHSColumn");
    }

    eval("window.Row" + currentRow + ".RHSMode=updatedvariableRow.RHSMode");
    eval("window.Row" + currentRow + ".OPRColumn=updatedvariableRow.OPRColumn");

    if (!IsAddedToArray(currentRow))
    {
        var inArrLen = InitialUpdatedVariableArray.length;
        InitialUpdatedVariableArray[inArrLen] = currentRow + "~" + "S";
    }


}

function ProcessClientClick(node)
{
    var currentRow = document.getElementById("hiddivNumber").value;
    if (node.Value == "BEXPFUV")
    {
        OpenEXPBuilder(currentRow);
        mode = "RHS";
        return false;
    }
    else if (node.Value == "Variables" || node.Value == "Contents" || node.Value == "XmlVariables" || (node.Value.indexOf("XmlDocumentType") > -1) || (node.Value.indexOf("XmlIterator") > -1))
    {
        return false;
    }
    else if (node.Value == "UPDENT")
    {
        if (mode != "LHS")
        {
            var divObj = document.getElementById("RHS" + currentRow);
            //var TextForRHS="<A class=\"hyperText\" id=\"rhsLink"+currentRow+"\"   onmouseover=\"Javascript:alterLink(this,"+currentRow+",'RHS')\" onclick=\"Javascript:alterLink(this,"+currentRow+",'RHS')\" href=\"#\">enter value</A>";
            //divObj.innerHTML=TextForRHS;
            if (eval("window.Row" + currentRow) == null)
                eval("window.Row" + currentRow + " =new VariableRow()");

            eval("window.Row" + currentRow + ".RHSMode='Default'");
            eval("window.Row" + currentRow + ".RHSColumn=''");

            //if(eval("window.Row"+currentRow+".RHSColumn") == "")
            //{
            var TextForRHS = "<A class=\"hyperText\" id=\"rhsLink" + currentRow + "\"   onmouseover=\"Javascript:alterLink(this," + currentRow + ",'RHS')\" onclick=\"Javascript:alterLink(this," + currentRow + ",'RHS')\" href=\"#\">Enter Value</A>";
            //}
            //else
            //{
            //var TextForRHS="<A class=\"hyperText\" id=\"rhsLink"+currentRow+"\"   onmouseover=\"Javascript:alterLink(this,"+currentRow+",'RHS')\" onclick=\"Javascript:alterLink(this,"+currentRow+",'RHS')\" href=\"#\">"+eval("window.Row"+currentRow+".RHSColumn")+"</A>";
            //}
            divObj.innerHTML = TextForRHS;

            ToggleTreeView();
            imageLHSObj.style.display = "none";
            inputLHSObj.style.display = "none";
            txtRHSObj.value = "";
            txtRHSObj.readOnly = false;

            return false;

        }
    }
    else if (node.ClientID.indexOf("cmbOperator") == 0)
    {
        mode = "MHS";
    }
    else
    {
        ToggleTreeView();
        imageLHSObj.style.display = "none";
        inputLHSObj.style.display = "none";
        txtRHSObj.style.display = "none";
    }
    //
    if (mode == "LHS")
    {
        var tableObject = document.getElementById("TableExpression" + currentRow);
        tableObject.className = "tab";

        var currentDivElement = "LHS" + currentRow;

        var divObj = document.getElementById(currentDivElement);

        var lhsTextVal = node.Value;
        var lhsOriginalTextVal = node.Value;
        if ((lhsTextVal == "GalaxyBrowser" || lhsTextVal.substring(0, 13) == "GalaxyBrowser")
         && IsOpenedFromA2() == "yes")
        {

            var tagName = window.external.Service('aaGalaxyBrowser').TagName;
            var retValue = window.external.Service('aaGalaxyBrowser').OpenGalaxyBrowser('', '', '', tagName);
            if (retValue.indexOf("[") > -1 && retValue.indexOf("]") > -1)
            {
                var retValueOrginal = retValue;
                var index = retValue.indexOf("[");
                retValue = retValue.substring(0, index) + "[]";
            }
            lhsTextVal = retValue;
            lhsOriginalTextVal = retValue;
        }
        if ((lhsTextVal == "OPCClientBrowser" || lhsTextVal.substring(0, 16) == "OPCClientBrowser"))
        {
            var serverUrl = document.getElementById("OPCdata").value;
            var opcConInf = document.getElementById("OPCConInfo").value;
            //var retValue = window.showModalDialog("../OPCUA/TagBrowser.aspx?OPCdata=" + serverUrl + "&OPCConInfo=" + opcConInf, '', 'dialogWidth:496px;dialogHeight:400px;scroll:no');
            var retValue = window.open("../OPCUA/TagBrowser.aspx?OPCdata=" + serverUrl + "&OPCConInfo=" + opcConInf, 'OPCClientWindow', 'width=496,height=400,scrollbars=no');
            lhsTextVal = retValue;
            lhsOriginalTextVal = retValue;
        }

        //CHECKPOINT
        lhsTextVal = TruncateString(lhsTextVal);
        //EndCHECK

        if (lhsTextVal.length > 32)
        {
            if (lhsTextVal.substring(0, 8) == "Variable")
            {
                var length = lhsTextVal.length;
                lhsTextVal = lhsTextVal.substring(0, 3) + ".." + lhsTextVal.substring(length - 28, length);

            }
            else if (lhsTextVal.substring(0, 11) == "XmlVariable")
            {
                //            var attribute="A";
                //            var element="E";
                //            var count=0;
                //            for(var i=11;i<lhsTextVal.length;i++)
                //            {
                //                 if(lhsTextVal.substring(i,i+1) == "!")
                //                 count++;
                //            }
                //            if(count==0)
                //            {
                //                lhsTextVal+=element.bold();                
                //            }
                //            else
                //            {
                //                lhsTextVal=lhsTextVal.replace(/!/,"")
                //                lhsTextVal+=attribute.bold();
                //            }
                //                

                var length = lhsTextVal.length;
                lhsTextVal = lhsTextVal.substring(0, 6) + ".." + lhsTextVal.substring(length - 25, length);
            }
            else
            {
                var length = lhsTextVal.length;
                lhsTextVal = lhsTextVal.substring(0, 6) + ".." + lhsTextVal.substring(length - 24, length);
            }

        }


        //Building HTML for the LHSDIV            
        var selectedNodeTxt = "<A class=\"hyperText\" id=\"link" + currentRow + "\"   onmouseover=\"Javascript:alterLink(this," + currentRow + ",'LHS')\" onclick=\"Javascript:alterLink(this," + currentRow + ",'LHS')\" href=\"#\">" + lhsTextVal + "</A>";
        divObj.innerHTML = selectedNodeTxt + "&nbsp;";

        //divObj.innerHTML = divObj.innerHTML.replace('$','!');

        //Creating New Row
        var nextRowHTML = AddRow(currentRow);
        if (nextRowHTML != "")
            document.getElementById("divExpressionLayers").innerHTML = document.getElementById("divExpressionLayers").innerHTML + nextRowHTML;

        var MHS = document.getElementById("MHS" + currentRow);

        var currentMHSDivElementName = "MHS" + currentRow;
        var currentMHSDivElement = document.getElementById(currentMHSDivElementName);
        var mhsTextVal = "=";
        if (eval("window.Row" + currentRow) != null)
            if (eval("window.Row" + currentRow + ".OPRColumn") != "")
                mhsTextVal = eval("window.Row" + currentRow + ".OPRColumn");
        var TextForOperator = "<A class=\"hyperTextWithoutLink\" id=\"link" + currentRow + "\"   onmouseover=\"Javascript:alterLink(this," + currentRow + ",'OPR')\" onclick=\"Javascript:alterLink(this," + currentRow + ",'OPR')\" href=\"#\">" + mhsTextVal + "</A>";
        currentMHSDivElement.innerHTML = TextForOperator;


        var RHS = document.getElementById("RHS" + currentRow);

        var currentRHSDivElementName = "RHS" + currentRow;
        var currentRHSDivElement = document.getElementById(currentRHSDivElementName);
        if (eval("window.Row" + currentRow) != null)
        {
            //CHECKPOINT
            var TrunStr = eval("window.Row" + currentRow + ".RHSColumn").replace('~', '');
            TrunStr = TruncateString(TrunStr);
            //EndCHECK

            if (TrunStr == "")
            {
                var TextForRHS = "<A class=\"hyperText\" id=\"rhsLink" + currentRow + "\"   onmouseover=\"Javascript:alterLink(this," + currentRow + ",'RHS')\" onclick=\"Javascript:alterLink(this," + currentRow + ",'RHS')\" href=\"#\">" + EnterValueText + "</A>";
            }
            else
            {
                if (TrunStr.length <= 32)
                    var TextForRHS = "<A class=\"hyperText\" id=\"rhsLink" + currentRow + "\"   onmouseover=\"Javascript:alterLink(this," + currentRow + ",'RHS')\" onclick=\"Javascript:alterLink(this," + currentRow + ",'RHS')\" href=\"#\">" + DecodeTheExpressionString(TrunStr) + "</A>";
                else
                {
                    //New Changes
                    if (TrunStr.substring(0, 8) == "Variable")
                    {
                        var length = TrunStr.length;
                        var Trimmed = TrunStr.substring(0, 3) + ".." + TrunStr.substring(length - 28, length);
                        var TextForRHS = "<A class=\"hyperText\" id=\"rhsLink" + currentRow + "\"   onmouseover=\"Javascript:alterLink(this," + currentRow + ",'RHS')\" onclick=\"Javascript:alterLink(this," + currentRow + ",'RHS')\" href=\"#\">" + Trimmed + "</A>";

                    }
                    else if (TrunStr.substring(0, 11) == "XmlVariable")
                    {
                        var length = TrunStr.length;
                        var Trimmed = TrunStr.substring(0, 6) + ".." + TrunStr.substring(length - 25, length);
                        var TextForRHS = "<A class=\"hyperText\" id=\"rhsLink" + currentRow + "\"   onmouseover=\"Javascript:alterLink(this," + currentRow + ",'RHS')\" onclick=\"Javascript:alterLink(this," + currentRow + ",'RHS')\" href=\"#\">" + Trimmed + "</A>";
                    }
                    else
                    {
                        var length = TrunStr.length;
                        var Trimmed = TrunStr.substring(0, 6) + ".." + TrunStr.substring(length - 24, length);
                        var TextForRHS = "<A class=\"hyperText\" id=\"rhsLink" + currentRow + "\"   onmouseover=\"Javascript:alterLink(this," + currentRow + ",'RHS')\" onclick=\"Javascript:alterLink(this," + currentRow + ",'RHS')\" href=\"#\">" + Trimmed + "</A>";
                    }

                    //End of New Changes   
                }
            }
        }

        if (eval("window.Row" + currentRow) == null)
        {
            var TextForRHS = "<A class=\"hyperText\" id=\"rhsLink" + currentRow + "\"   onmouseover=\"Javascript:alterLink(this," + currentRow + ",'RHS')\" onclick=\"Javascript:alterLink(this," + currentRow + ",'RHS')\" href=\"#\">" + EnterValueText + "</A>";
        }

        currentRHSDivElement.innerHTML = TextForRHS;

        document.getElementById("DivObjectTree" + currentRow).innerHTML = "<a href=\"#\"><img id=\"ObjImage" + currentRow + "\" src='" + objectTreeImg + "' alt='" + ConditionObjTreeLocal + "' border=0 onclick=\"javascript:DisplayObjectTree(" + currentRow + ")\"></a>&nbsp;&nbsp;<a href=\"#\"><img id=\"DelImage" + currentRow + "\" alt='" + ConditionDeleteLocal + "' title='" + ConditionDeleteLocal + "' src='" + delteRowImg + "' border=0 onclick=\"javascript:DeleteRow(" + currentRow + ")\"></a>";


        if (eval("window.Row" + currentRow) == null)
            eval("window.Row" + currentRow + " =new VariableRow()");
        eval("window.Row" + currentRow + ".LHSColumn=lhsOriginalTextVal");
        // eval("window.Row"+currentRow+".LHSColumn=node.Value"); %OLD CODE, A2%

        if (!IsAddedToArray(currentRow))
        {
            var inArrLen = InitialUpdatedVariableArray.length;
            InitialUpdatedVariableArray[inArrLen] = currentRow + "~" + "S";
        }

    }
    else if (mode == "MHS")
    {
        var mhsTextVal = node.Text;
        var MHS = document.getElementById("MHS" + currentRow);

        var currentMHSDivElementName = "MHS" + currentRow;
        var currentMHSDivElement = document.getElementById(currentMHSDivElementName);
        //var selectedNodeTxt= "<A class=\"hyperText\" id=\"link"+currentRow+"\"   onmouseover=\"Javascript:alterLink(this,"+currentRow+",'LHS')\" onclick=\"Javascript:alterLink(this,"+currentRow+",'LHS')\" href=\"#\">"+lhsTextVal+"</A>";

        var TextForOperator = "<A class=\"hyperText\" id=\"link" + currentRow + "\"   onmouseover=\"Javascript:alterLink(this," + currentRow + ",'OPR')\" onclick=\"Javascript:alterLink(this," + currentRow + ",'OPR')\" href=\"#\">" + mhsTextVal + "</A>";
        currentMHSDivElement.innerHTML = TextForOperator;
        if (eval("window.Row" + currentRow) == null)
            eval("window.Row" + currentRow + " =new VariableRow()");

        eval("window.Row" + currentRow + ".OPRColumn=node.Text");


        if (!IsAddedToArray(currentRow))
        {
            var inArrLen = InitialUpdatedVariableArray.length;
            InitialUpdatedVariableArray[inArrLen] = currentRow + "~" + "S";
        }
        inputOPRObj.style.display = "none";
        imageOPRObj.style.display = "none";

    }
    else
    {
        //
        var currentDivElement = "RHS" + currentRow;
        var divRHSObj = document.getElementById(currentDivElement);
        var rhsTextVal = node.Value;
        var rhsOriginalTextVal = node.Value;

        if ((rhsTextVal == "OPCClientBrowser" || rhsTextVal.substring(0, 16) == "OPCClientBrowser"))
        {
            var serverUrl = document.getElementById("OPCdata").value;
            var opcConInf = document.getElementById("OPCConInfo").value;
            //var retValue = window.showModalDialog("../OPCUA/TagBrowser.aspx?OPCdata=" + serverUrl + "&OPCConInfo=" + opcConInf, '', 'dialogWidth:496px;dialogHeight:400px;scroll:no');
            window.open("../OPCUA/TagBrowser.aspx?OPCdata=" + serverUrl + "&OPCConInfo=" + opcConInf, 'OPCClientWindow', 'width=496,height=400,scrollbars=no');
            var retValue = document.getElementById("txtRHS").value;
            rhsTextVal = retValue;
            rhsOriginalTextVal = retValue;
        }

        if ((rhsTextVal == "GalaxyBrowser" || rhsTextVal.substring(0, 13) == "GalaxyBrowser")
         && IsOpenedFromA2() == "yes")
        {
            var tagName = window.external.Service('aaGalaxyBrowser').TagName;
            var retValue = window.external.Service('aaGalaxyBrowser').OpenGalaxyBrowser('', '', '', tagName);
            rhsTextVal = retValue;
            rhsOriginalTextVal = retValue;
        }
        //CHECKPOINT
        rhsTextVal = TruncateString(rhsTextVal);
        //EndCHECK

        if (rhsTextVal.length > 32)
        {
            if (rhsTextVal.substring(0, 8) == "Variable")
            {
                var length = rhsTextVal.length;
                rhsTextVal = rhsTextVal.substring(0, 3) + ".." + rhsTextVal.substring(length - 28, length);
            }
            else if (rhsTextVal.substring(0, 11) == "XmlVariable")
            {
                var length = rhsTextVal.length;
                rhsTextVal = rhsTextVal.substring(0, 6) + ".." + rhsTextVal.substring(length - 25, length);
            }
            else
            {
                var length = rhsTextVal.length;
                rhsTextVal = rhsTextVal.substring(0, 6) + ".." + rhsTextVal.substring(length - 24, length);
            }

        }

        //Building HTML for the LHSDIV            
        var selectedNodeTxt = "<A class=\"hyperText\" id=\"rhsLink" + currentRow + "\"   onmouseover=\"Javascript:alterLink(this," + currentRow + ",'RHS')\" onclick=\"Javascript:alterLink(this," + currentRow + ",'RHS')\" href=\"#\">" + DecodeTheExpressionString(rhsTextVal) + "</A>";
        divRHSObj.innerHTML = selectedNodeTxt + "&nbsp;";

        if (eval("window.Row" + currentRow) == null)
            eval("window.Row" + currentRow + " =new VariableRow()");

        eval("window.Row" + currentRow + ".RHSColumn=rhsOriginalTextVal");
        //eval("window.Row"+currentRow+".RHSColumn=node.Value"); %OLD CODE, A2%


        if (!IsAddedToArray(currentRow))
        {
            var inArrLen = InitialUpdatedVariableArray.length;
            InitialUpdatedVariableArray[inArrLen] = currentRow + "~" + "S";
        }
    }
    return false;
}

function IsOpenedFromA2()
{
    wndw = window;
    var strE = wndw.external;
    var isFromWin;
    isFromWin = 'no';
    if (strE != null)
    {
        try
        {
            if (strE.toString().substring(0, 6) == "Skelta")
                isFromWin = 'yes';
        }
        catch (e)
        {
            isFromWin = 'no';
        }
    }
    return isFromWin;
}
function ProcessLHSClientEnter(textBox)
{

    var currentRow = document.getElementById("hiddivNumber").value;
    var tableObject = document.getElementById("TableExpression" + currentRow);
    tableObject.className = "tab";

    var currentDivElement = "LHS" + currentRow;

    var divObj = document.getElementById(currentDivElement);

    var lhsTextActualVal = textBox.value;
    var lhsTextVal = textBox.value;

    //CHECKPOINT
    lhsTextVal = TruncateString(lhsTextVal);
    //EndCHECK

    if (lhsTextVal.length > 32)
    {
        var length = lhsTextVal.length;
        lhsTextVal = lhsTextVal.substring(0, 6) + ".." + lhsTextVal.substring(length - 24, length);
    }

    //Building HTML for the LHSDIV            
    var selectedNodeTxt = "<A class=\"hyperText\" id=\"link" + currentRow + "\"   onmouseover=\"Javascript:alterLinkEnter(this," + currentRow + ",'LHS')\" onclick=\"Javascript:alterLinkEnter(this," + currentRow + ",'LHS')\" href=\"#\">" + lhsTextVal + "</A>";
    divObj.innerHTML = selectedNodeTxt + "&nbsp;";

    //Creating New Row
    var nextRowHTML = AddRow(currentRow);
    if (nextRowHTML != "")
        document.getElementById("divExpressionLayers").innerHTML = document.getElementById("divExpressionLayers").innerHTML + nextRowHTML;

    var MHS = document.getElementById("MHS" + currentRow);

    var currentMHSDivElementName = "MHS" + currentRow;
    var currentMHSDivElement = document.getElementById(currentMHSDivElementName);
    var mhsTextVal = "=";
    if (eval("window.Row" + currentRow) != null)
        if (eval("window.Row" + currentRow + ".OPRColumn") != "")
            mhsTextVal = eval("window.Row" + currentRow + ".OPRColumn");
    var TextForOperator = "<A class=\"hyperTextWithoutLink\" id=\"link" + currentRow + "\"   onmouseover=\"Javascript:alterLink(this," + currentRow + ",'OPR')\" onclick=\"Javascript:alterLink(this," + currentRow + ",'OPR')\" href=\"#\">" + mhsTextVal + "</A>";
    currentMHSDivElement.innerHTML = TextForOperator;


    var RHS = document.getElementById("RHS" + currentRow);

    var currentRHSDivElementName = "RHS" + currentRow;
    var currentRHSDivElement = document.getElementById(currentRHSDivElementName);
    var TextForRHS;
    if (eval("window.Row" + currentRow) != null)
    {
        //CHECKPOINT
        var TrunStr = eval("window.Row" + currentRow + ".RHSColumn").replace('~', '');
        TrunStr = TruncateString(TrunStr);

        //EndCHECK

        if (TrunStr == "")
        {
            TextForRHS = "<A class=\"hyperText\" id=\"rhsLink" + currentRow + "\"   onmouseover=\"Javascript:alterLink(this," + currentRow + ",'RHS')\" onclick=\"Javascript:alterLink(this," + currentRow + ",'RHS')\" href=\"#\">" + EnterValueText + "</A>";
        }
        else
        {
            if (TrunStr.length <= 32)
                TextForRHS = "<A class=\"hyperText\" id=\"rhsLink" + currentRow + "\"   onmouseover=\"Javascript:alterLink(this," + currentRow + ",'RHS')\" onclick=\"Javascript:alterLink(this," + currentRow + ",'RHS')\" href=\"#\">" + DecodeTheExpressionString(TrunStr) + "</A>";
            else
            {
                if (TrunStr.substring(0, 8) == "Variable")
                {
                    var length = TrunStr.length;
                    var Trimmed = TrunStr.substring(0, 3) + ".." + TrunStr.substring(length - 28, length);
                    TextForRHS = "<A class=\"hyperText\" id=\"rhsLink" + currentRow + "\"   onmouseover=\"Javascript:alterLink(this," + currentRow + ",'RHS')\" onclick=\"Javascript:alterLink(this," + currentRow + ",'RHS')\" href=\"#\">" + Trimmed + "</A>";

                }
                else if (TrunStr.substring(0, 11) == "XmlVariable")
                {
                    var length = TrunStr.length;
                    var Trimmed = TrunStr.substring(0, 6) + ".." + TrunStr.substring(length - 25, length);
                    TextForRHS = "<A class=\"hyperText\" id=\"rhsLink" + currentRow + "\"   onmouseover=\"Javascript:alterLink(this," + currentRow + ",'RHS')\" onclick=\"Javascript:alterLink(this," + currentRow + ",'RHS')\" href=\"#\">" + Trimmed + "</A>";
                }
                else
                {
                    var length = TrunStr.length;
                    var Trimmed = TrunStr.substring(0, 6) + ".." + TrunStr.substring(length - 24, length);
                    TextForRHS = "<A class=\"hyperText\" id=\"rhsLink" + currentRow + "\"   onmouseover=\"Javascript:alterLink(this," + currentRow + ",'RHS')\" onclick=\"Javascript:alterLink(this," + currentRow + ",'RHS')\" href=\"#\">" + Trimmed + "</A>";
                }
            }
        }
    }
    else
    {
        TextForRHS = "<A class=\"hyperText\" id=\"rhsLink" + currentRow + "\"   onmouseover=\"Javascript:alterLink(this," + currentRow + ",'RHS')\" onclick=\"Javascript:alterLink(this," + currentRow + ",'RHS')\" href=\"#\">" + EnterValueText + "</A>";
    }

    currentRHSDivElement.innerHTML = TextForRHS;

    document.getElementById("DivObjectTree" + currentRow).innerHTML = "<a href=\"#\"><img id=\"ObjImage" + currentRow + "\" src='" + objectTreeImg + "' alt='" + ConditionObjTreeLocal + "' border=0 onclick=\"javascript:DisplayObjectTree(" + currentRow + ")\"></a>&nbsp;&nbsp;<a href=\"#\"><img id=\"DelImage" + currentRow + "\" alt='" + ConditionDeleteLocal + "' title='" + ConditionDeleteLocal + "' src='" + delteRowImg + "' border=0 onclick=\"javascript:DeleteRow(" + currentRow + ")\"></a>";


    if (eval("window.Row" + currentRow) == null)
        eval("window.Row" + currentRow + " =new VariableRow()");

    eval("window.Row" + currentRow + ".LHSColumn=lhsTextActualVal");

    if (!IsAddedToArray(currentRow))
    {
        var inArrLen = InitialUpdatedVariableArray.length;
        InitialUpdatedVariableArray[inArrLen] = currentRow + "~" + "S";
    }
    //Hide the text box from LHS    
    txtLHSObj.style.visibility = "hidden";
}

function IsAddedToArray(rowNo)
{
    var addedtoArray = false;
    for (var i = 0; i < InitialUpdatedVariableArray.length; i++)
    {
        if (InitialUpdatedVariableArray[i].indexOf(rowNo + "~" + "S") > -1)
        {
            addedtoArray = true;
            break;
        }
    }

    return addedtoArray;

}

function DeleteRow(currentRow)
{

    var isRowExsts = true;
    inputOPRObj.style.display = "none";
    imageOPRObj.style.display = "none";
    inputLHSObj.style.display = "none";
    imageLHSObj.style.display = "none";
    txtRHSObj.style.display = "none";
    if (document.getElementById("treeDiv").style.visibility == "visible")
    {
        HideTreeView();
    }

    document.getElementById("divExpressionLayer" + currentRow).style.display = "none";

    InitialUpdatedVariableArray[currentRow - 1] = parseInt(currentRow) + "~" + "H";

    var prevRowsCount = currentRow - 1;

    for (var i = prevRowsCount; i > 0; i--)
    {
        if (document.getElementById("divExpressionLayer" + i) != null)
        {
            if (document.getElementById("divExpressionLayer" + i).style.display != "none")
            {
                isRowExsts = true;
                break;
            }
            else
            {
                isRowExsts = false;
            }
        }

    }


    if ((!isRowExsts) || (prevRowsCount == 0))
    {
        if (document.getElementById("divExpressionLayer" + parseInt(currentRow + 1)) != null)
        {
            for (var i = parseInt(currentRow + 1) ; i <= InitialUpdatedVariableArray.length + 1; i++)
            {
                if (document.getElementById("divExpressionLayer" + i) != null)
                {
                    if (document.getElementById("divExpressionLayer" + i).style.display != "none")
                    {
                        //var divOprv = document.getElementById("divlnkOPR"+i);
                        //divOprv.innerHTML="&nbsp;";
                        break;
                    }
                }
            }
        }
    }
}

function DisableNode(text)
{
    var node = FindNodeByText(text);
    if (node != null)
        node.Disable();
}

function EnableNode(text)
{
    var node = FindNodeByText(text);
    if (node != null)
        node.Enable();
}

function HandleChangeOperator(item)
{
    var currentRow = document.getElementById("hiddivNumber").value;
    var currentDivElement = "DivRadCmb" + currentRow;
    var divObj = document.getElementById(currentDivElement);
    var selectedNodeTxt = "<A class=\"hyperText\" id=\"link" + currentRow + "\"    onmouseover=\"Javascript:alterLink(this," + currentRow + ",'OPR')\" onclick=\"Javascript:alterLink(this," + currentRow + ",'OPR')\" href=\"#\">" + DecodeTheExpressionString(item.Text) + "</A>";
    if (eval("window.Row" + currentRow) != null)
        eval("window.Row" + currentRow + ".OPRColumn=item.Text");
    divObj.innerHTML = selectedNodeTxt;
    imageOPRObj.style.display = "none";
    inputOPRObj.style.display = "none";

}


function OpenEXPBuilder(curRow)
{
    mode = "RHS";
    window.open(expbuilderURl + "&selRow=" + curRow + "&mode=" + mode + "&Src=UpdateVariable", "RHS" + curRow, 'width=840,height=488,resizable=yes,scrollbars=no,toolbars=0');
}

//Calculates the coordinates of the link control and places the specific element over there
//combo  - LHS  or MHS or RHS
function PositionObj(ctrl, combo)
{
    var el = ctrl;
    var x = 0;
    var y = el.offsetHeight;

    //Walk up the DOM and add up all of the offset positions.
    while (el.offsetParent && el.tagName.toUpperCase() != 'BODY')
    {
        x += el.offsetLeft;
        y += el.offsetTop;
        el = el.offsetParent;
    }
    x += el.offsetLeft;
    y += el.offsetTop;

    var scrollTop = document.getElementById("divMain").scrollTop;
    y = parseInt(y - scrollTop);

    var currentRow = document.getElementById("hiddivNumber").value;

    ValiderrCount = PlaceLinkforText();

    var result = validateRows(currentRow);

    if (result != false)
    {
        //
        inputLHSObj.value = "";

        if (combo == "LHS")
        {

            document.getElementById("cmbLHS").style.visibility = "visible";
            document.getElementById("cmbLHS").style.display = "block";



            if (eval("window.Row" + currentRow) != null)
            {
                inputLHSObj.value = eval("window.Row" + currentRow + ".LHSColumn");
            }
            inputLHSObj.style.visibility = "visible";
            inputLHSObj.style.display = "block";
            inputLHSObj.style.position = "absolute";
            inputLHSObj.style.left = x + 'px';
            inputLHSObj.style.top = (parseInt(y) - 15) + 'px';
            imageLHSObj.style.visibility = "visible";
            imageLHSObj.style.display = "block";
            imageLHSObj.style.position = "absolute";
            imageLHSObj.style.left = x + inputLHSObj.offsetWidth + 'px';
            imageLHSObj.style.top = (parseInt(y) - 15) + 'px';
            inputOPRObj.style.display = "none";
            imageOPRObj.style.display = "none";
            txtRHSObj.style.display = "none";
        }
        else if (combo == "OPR")
        {
            if (document.getElementById(cmbOPRName + "Div") != null)
            {
                document.getElementById(cmbOPRName + "Div").style.visibility = "visible";
                document.getElementById(cmbOPRName + "Div").style.display = "block";
            }
            else
            {
                document.getElementById(cmbOPRName + "_wrapper").style.visibility = "visible";
                document.getElementById(cmbOPRName + "_wrapper").style.display = "block";
            }
            inputOPRObj.style.visibility = "visible";
            inputOPRObj.style.display = "block";
            inputOPRObj.style.position = "absolute";
            inputOPRObj.style.left = (x - 10) + 'px';
            inputOPRObj.style.top = (parseInt(y) - 15) + 'px';

            imageOPRObj.style.visibility = "visible";
            imageOPRObj.style.display = "block";
            imageOPRObj.style.position = "absolute";
            imageOPRObj.style.left = parseInt((x - 10) + inputOPRObj.offsetWidth) + 'px';
            imageOPRObj.style.top = (parseInt(y) - 15) + 'px';

            inputLHSObj.style.display = "none";
            imageLHSObj.style.display = "none";
            txtRHSObj.style.display = "none";

        }
        //
        if (combo == "RHS")
        {

            txtRHSObj.value = "";
            var RHSMode = "Default";

            if (isObjectTreeInUse)
                RHSMode = "ObjTree";

            if (eval("window.Row" + currentRow) != null)
                RHSMode = eval("window.Row" + currentRow + ".RHSMode");

            if (RHSMode == "Default")
            {

                txtRHSObj.value = DecodeTheExpressionString(eval("window.Row" + currentRow + ".RHSColumn"));

                txtRHSObj.style.visibility = "visible";
                txtRHSObj.style.display = "block";
                txtRHSObj.style.position = "absolute";

                txtRHSObj.style.left = (x) + 'px';
                txtRHSObj.style.top = (parseInt(y) - 15) + 'px';
                inputOPRObj.style.display = "none";
                imageOPRObj.style.display = "none";
                inputLHSObj.style.display = "none";
                imageLHSObj.style.display = "none";
            }
            else if (RHSMode == "Expression")
            {

                txtRHSObj.value = DecodeTheExpressionString(eval("window.Row" + currentRow + ".RHSColumn"));

                txtRHSObj.style.visibility = "visible";
                txtRHSObj.style.display = "block";
                txtRHSObj.style.position = "absolute";
                txtRHSObj.style.left = x + 'px';
                txtRHSObj.style.top = (parseInt(y) - 15) + 'px';
                imageLHSObj.style.visibility = "visible";
                imageLHSObj.style.display = "block";
                imageLHSObj.style.position = "absolute";
                imageLHSObj.style.left = x + txtRHSObj.offsetWidth + 'px';
                imageLHSObj.style.top = (parseInt(y) - 15) + 'px';

                inputOPRObj.style.display = "none";
                imageOPRObj.style.display = "none";
                inputLHSObj.style.display = "none";

            }
            else
            {
                document.getElementById("cmbLHS").style.visibility = "visible";
                document.getElementById("cmbLHS").style.display = "block";


                txtRHSObj.value = DecodeTheExpressionString(eval("window.Row" + currentRow + ".RHSColumn"));

                txtRHSObj.style.visibility = "visible";
                txtRHSObj.style.display = "block";
                txtRHSObj.style.position = "absolute";
                txtRHSObj.style.left = x + 'px';
                txtRHSObj.style.top = (parseInt(y) - 15) + 'px';
                imageLHSObj.style.visibility = "visible";
                imageLHSObj.style.display = "block";
                imageLHSObj.style.position = "absolute";
                imageLHSObj.style.left = x + txtRHSObj.offsetWidth + 'px';
                imageLHSObj.style.top = (parseInt(y) - 15) + 'px';

                inputOPRObj.style.display = "none";
                imageOPRObj.style.display = "none";
            }


        }



    }



}
function PositionObj1(ctrl, combo)
{
    var el = ctrl;
    var x = 0;
    var y = el.offsetHeight;

    //Walk up the DOM and add up all of the offset positions.
    while (el.offsetParent && el.tagName.toUpperCase() != 'BODY')
    {
        x += el.offsetLeft;
        y += el.offsetTop;
        el = el.offsetParent;
    }
    x += el.offsetLeft - 40;
    y += el.offsetTop - 33;

    var scrollTop = document.getElementById("divMain").scrollTop;
    y = parseInt(y - scrollTop);

    var currentRow = document.getElementById("hiddivNumber").value;

    ValiderrCount = PlaceLinkforText();

    var result = validateRows(currentRow);

    if (result != false)
    {
        //
        inputLHSObj.value = "";

        if (combo == "LHS")
        {
            if (eval("window.Row" + currentRow) != null)
            {
                inputLHSObj.value = eval("window.Row" + currentRow + ".LHSColumn");
            }
            if (lhsAllowValue == "True")
            {
                document.getElementById("cmbLHS").style.visibility = "hidden";
                txtLHSObj.value = inputLHSObj.value;
                txtLHSObj.style.display = "block";
                txtLHSObj.style.visibility = "visible";
                txtLHSObj.style.display = "block";
                txtLHSObj.style.position = "absolute";
                txtLHSObj.style.left = x + 30 + 'px';
                txtLHSObj.style.top = (parseInt(y) + 18) + 'px';
            }
            else
            {
                document.getElementById("cmbLHS").style.visibility = "visible";
                document.getElementById("cmbLHS").style.display = "block";
                document.getElementById("cmbLHS_Input").readOnly = true;
                inputLHSObj.style.visibility = "visible";
                inputLHSObj.style.display = "block";
                inputLHSObj.style.position = "absolute";
                inputLHSObj.style.left = x + 30 + 'px';
                inputLHSObj.style.top = (parseInt(y) + 18) + 'px';
                imageLHSObj.style.visibility = "visible";
                imageLHSObj.style.display = "block";
                imageLHSObj.style.position = "absolute";
                imageLHSObj.style.left = x + inputLHSObj.offsetWidth + 30 + 'px';
                imageLHSObj.style.top = (parseInt(y) + 18) + 'px';
            }

            inputOPRObj.style.display = "none";
            imageOPRObj.style.display = "none";
            txtRHSObj.style.display = "none";
            /*
            document.getElementById("cmbLHS").style.visibility="visible";	
            document.getElementById("cmbLHS").style.display="block";  
            
           
        
            if(eval("window.Row"+currentRow)!=null)
            {
                inputLHSObj.value=eval("window.Row"+currentRow+".LHSColumn"); 
            }
            inputLHSObj.style.visibility="visible";
            inputLHSObj.style.display="block"; 
            inputLHSObj.style.position="absolute";
            inputLHSObj.style.left = x+30+ 'px';
            inputLHSObj.style.top = (parseInt(y)+18) + 'px';
            imageLHSObj.style.visibility="visible";
            imageLHSObj.style.display="block"; 
            imageLHSObj.style.position="absolute";
            imageLHSObj.style.left = x + inputLHSObj.offsetWidth+30 + 'px';
            imageLHSObj.style.top = (parseInt(y)+18) + 'px'; 
            inputOPRObj.style.display="none";
            imageOPRObj.style.display="none"; 
            txtRHSObj.style.display="none"; 
            */
        }
        else if (combo == "OPR")
        {

            if (document.getElementById(cmbOPRName + "Div") != null)
            {
                document.getElementById(cmbOPRName + "Div").style.visibility = "visible";
                document.getElementById(cmbOPRName + "Div").style.display = "block";
            }
            else
            {
                document.getElementById(cmbOPRName + "_wrapper").style.visibility = "visible";
                document.getElementById(cmbOPRName + "_wrapper").style.display = "block";
            }
            if (eval("window.Row" + currentRow) != null)
            {
                if (eval("window.Row" + currentRow + ".OPRColumn") != "")
                    inputOPRObj.value = eval("window.Row" + currentRow + ".OPRColumn");
            }
            inputOPRObj.style.visibility = "visible";
            inputOPRObj.style.display = "block";
            inputOPRObj.style.position = "absolute";
            inputOPRObj.style.left = (x + 34) + 'px';
            inputOPRObj.style.top = (parseInt(y) + 18) + 'px';


            imageOPRObj.style.visibility = "visible";
            imageOPRObj.style.display = "block";
            imageOPRObj.style.position = "absolute";
            imageOPRObj.style.left = parseInt((x + 34) + inputOPRObj.offsetWidth) + 'px';
            imageOPRObj.style.top = (parseInt(y) + 18) + 'px';



            inputLHSObj.style.display = "none";
            imageLHSObj.style.display = "none";
            txtRHSObj.style.display = "none";


        }
        //
        if (combo == "RHS")
        {

            txtRHSObj.value = "";
            var RHSMode = "Default";

            if (isObjectTreeInUse)
                RHSMode = "ObjTree";

            if (eval("window.Row" + currentRow) != null)
                RHSMode = eval("window.Row" + currentRow + ".RHSMode");



            if (RHSMode == "Default")
            {

                txtRHSObj.value = DecodeTheExpressionString(eval("window.Row" + currentRow + ".RHSColumn"));

                txtRHSObj.style.visibility = "visible";
                txtRHSObj.style.display = "block";
                txtRHSObj.style.position = "absolute";

                txtRHSObj.style.left = x + 30 + 'px';
                //txtRHSObj.style.top = (parseInt(y)-15) + 'px';
                txtRHSObj.style.top = (parseInt(y) + 18) + 'px';
                txtRHSObj.readOnly = false;
                inputOPRObj.style.display = "none";
                imageOPRObj.style.display = "none";
                inputLHSObj.style.display = "none";
                imageLHSObj.style.display = "none";
            }
            else if (RHSMode == "Expression")
            {

                txtRHSObj.value = DecodeTheExpressionString(eval("window.Row" + currentRow + ".RHSColumn"));

                txtRHSObj.style.visibility = "visible";
                txtRHSObj.style.display = "block";
                txtRHSObj.style.position = "absolute";
                txtRHSObj.style.left = x + 30 + 'px';
                //txtRHSObj.style.top = (parseInt(y)-15) + 'px'; 
                txtRHSObj.style.top = (parseInt(y) + 18) + 'px';
                txtRHSObj.readOnly = true;

                imageLHSObj.style.visibility = "visible";
                imageLHSObj.style.display = "block";
                imageLHSObj.style.position = "absolute";
                imageLHSObj.style.left = x + txtRHSObj.offsetWidth + 30 + 'px';
                //imageLHSObj.style.top = (parseInt(y)-15) + 'px';
                imageLHSObj.style.top = (parseInt(y) + 18) + 'px';

                inputOPRObj.style.display = "none";
                imageOPRObj.style.display = "none";
                inputLHSObj.style.display = "none";

            }
            else
            {
                document.getElementById("cmbLHS").style.visibility = "visible";
                document.getElementById("cmbLHS").style.display = "block";


                txtRHSObj.value = DecodeTheExpressionString(eval("window.Row" + currentRow + ".RHSColumn"));

                txtRHSObj.style.visibility = "visible";
                txtRHSObj.style.display = "block";
                txtRHSObj.style.position = "absolute";
                txtRHSObj.style.left = x + 30 + 'px';
                //txtRHSObj.style.top = (parseInt(y)-15) + 'px';
                txtRHSObj.style.top = (parseInt(y) + 18) + 'px';
                txtRHSObj.readOnly = true;
                imageLHSObj.style.visibility = "visible";
                imageLHSObj.style.display = "block";
                imageLHSObj.style.position = "absolute";
                imageLHSObj.style.left = x + 30 + txtRHSObj.offsetWidth + 'px';
                //imageLHSObj.style.top = (parseInt(y)-15) + 'px'; 
                imageLHSObj.style.top = (parseInt(y) + 18) + 'px';

                inputOPRObj.style.display = "none";
                imageOPRObj.style.display = "none";
            }


        }



    }



}



function PlaceLinkforText(currentRow)
{

    var errCount = 0;
    if (currentRow == null)
        currentRow = prevRow;
    else
        currentRow = currentRow;

    if (currentRow != 0)
    {
        var divObjRHS = document.getElementById("RHS" + currentRow);
        var rhsTextVal = txtRHSObj.value;

        if (trim(divObjRHS.innerHTML) != "")
        {
            if (trim(rhsTextVal) != "")
            {

                if (eval("window.Row" + currentRow) != null)
                {
                    //CHECKPOINT
                    rhsTextVal1 = TruncateString(rhsTextVal);
                    //EndCHECK



                    if (rhsTextVal.length > 32)

                        // rhsTextVal1 = rhsTextVal.substring(0,20)+"..";
                    {

                        //New Changes
                        if (rhsTextVal.substring(0, 8) == "Variable")
                        {
                            var length = rhsTextVal.length;
                            rhsTextVal1 = rhsTextVal.substring(0, 3) + ".." + rhsTextVal.substring(length - 28, length);


                        }
                        else if (rhsTextVal.substring(0, 11) == "XmlVariable")
                        {
                            var length = rhsTextVal.length;
                            rhsTextVal1 = rhsTextVal.substring(0, 6) + ".." + rhsTextVal.substring(length - 25, length);

                        }
                        else
                        {
                            var length = rhsTextVal.length;
                            rhsTextVal1 = rhsTextVal.substring(0, 6) + ".." + rhsTextVal.substring(length - 24, length);
                        }
                    }
                        //End of New Changes    

                    else
                        rhsTextVal1 = rhsTextVal;

                    divObjRHS.innerHTML = "<a href=\"#\" id=\"rhsLink" + currentRow + "\" class=\"hyperText\" OnMouseOver=\"javascript:alterLink(this," + currentRow + ",'RHS')\" Onclick=\"javascript:alterLink(this," + currentRow + ",'RHS')\" name=\"rhsLink" + currentRow + "\">" + DecodeTheExpressionString(rhsTextVal1) + "</a>";
                    cmbMode = "RHS";
                    eval("window.Row" + currentRow + ".RHSColumn=txtRHSObj.value");
                    txtRHSObj.style.display = "none";
                    errCount = 0;
                    prevRow = 0;
                }
            }
            var rhsVal = eval("window.Row" + currentRow + ".RHSColumn");
            var lhsVal = eval("window.Row" + currentRow + ".LHSColumn");
            var mhsVal = eval("window.Row" + currentRow + ".OPRColumn");

            if (mhsVal == "<##>" && rhsVal.indexOf("XmlVariables.") == -1)
            {
                errCount = 1;
            }

        }
        txtRHSObj.value = "";
        //prevRow =0;
    }
    return errCount;
}

function DisplayObjectTree(curRow)
{
    HideTreeView();
    Maximize(false, 0);
    txtRHSObj.style.display = "none";
    document.getElementById("cmbLHS_Input").style.display = "none";

    var rhsLinkObj = document.getElementById("rhsLink" + curRow);

    objTreeRHSMode = 1;

    objTreeLHSMode = 0;

    var x = findPosX(rhsLinkObj) - 10;
    var y = findPosY(rhsLinkObj) - 2;

    document.getElementById("txtRHS").style.visibility = "visible";
    document.getElementById("txtRHS").style.display = "block";
    var inputRHSObj = document.getElementById("txtRHS");
    inputRHSObj.style.visibility = "visible";
    inputRHSObj.style.display = "block";
    inputRHSObj.style.position = "absolute";
    inputRHSObj.style.left = x + 'px';
    inputRHSObj.style.top = (parseInt(y)) + 'px';

    inputRHSObj.value = DecodeTheExpressionString(eval("window.Row" + curRow + ".RHSColumn"));

    imageLHSObj.style.visibility = "visible";
    imageLHSObj.style.display = "block";
    imageLHSObj.style.position = "absolute";
    imageLHSObj.style.left = x + inputRHSObj.offsetWidth + 'px';
    imageLHSObj.style.top = (parseInt(y)) + 'px';

    imageLHSObj.value = eval("window.Row" + curRow + ".RHSColumn");
    inputOPRObj.style.display = "none";
    imageOPRObj.style.display = "none";
    //txtRHSObj.style.display="none";

    /*imageBoolObj.style.display="none";
    inputBoolObj.style.display="none";
    txtRHSObj.value="";
    txtRHSObj.style.display="none";
    CalIMGRHSObj.style.display="none";
    
    if(eval("window.Row"+curRow)!=null)
        eval("window.Row"+curRow+".RHSMode='ObjTree'");*/

    document.getElementById("hiddivNumber").value = curRow;
    mode = "RHS";

    isObjectTreeInUse = true;

    eval("window.Row" + curRow + ".RHSMode='ObjTree'");

}

function ToggleTreeView()
{
    //HideAlttext(this);
    if (mode == "LHS")
    {
        if (document.getElementById("treeDiv").style.visibility == "visible")
        {
            Maximize(false, 0);
            HideTreeView();
            //document.getElementById("cmbLHS").style.display="none";		

        }
        else
        {

            ShowTreeView();
            Maximize(true, 0);
        }
    }
    else
    {
        if (document.getElementById("RHSTreeDiv").style.visibility == "visible")
        {
            Maximize(false, 0);
            HideTreeView();
            //document.getElementById("cmbLHS").style.display="none";		

        }
        else
        {
            ShowTreeView();
            Maximize(true, 0);
        }

    }
}
function ShowTreeView()
{
    if (mode == "LHS")
    {
        document.getElementById("treeDiv").style.visibility = "visible";
        document.getElementById("treeDiv").style.display = "block";
        var cmbLHSObj = document.getElementById("cmbLHS_Input");
        var x = findPosX(cmbLHSObj);
        var y = findPosY(cmbLHSObj);
        // y = y - document.getElementById("divMain").scrollTop;
        var n = 0;
        n = document.getElementById("divMain").scrollTop;
        var divHeight = document.getElementById("treeDiv").style.height;
        divHeight = divHeight.substring(0, divHeight.length - 2);
        var TempHeight = divHeight;
        divHeight = divHeight - n;
        if ((document.body.offsetHeight - y) < parseInt(TempHeight))
        {
            var newTop = parseInt(y) - parseInt(TempHeight); //Fix for not able to see treediv after 19 variables since divheight value is negative  newTop is always increasing.So changed to TempHeight
            document.getElementById("treeDiv").style.left = x + "px";
            document.getElementById("treeDiv").style.top = (parseInt(newTop)) + "px";
        }
        else
        {
            document.getElementById("treeDiv").style.left = x + "px";
            document.getElementById("treeDiv").style.top = (parseInt(y) + 18) + "px";
        }
    }
    else
    {
        document.getElementById("RHSTreeDiv").style.visibility = "visible";
        document.getElementById("RHSTreeDiv").style.display = "block";
        var cmbLHSObj = document.getElementById("txtRHS");
        var x = findPosX(cmbLHSObj);
        var y = findPosY(cmbLHSObj);
        var n = 0;
        n = document.getElementById("divMain").scrollTop;
        var divHeight = document.getElementById("RHSTreeDiv").style.height;
        divHeight = divHeight.substring(0, divHeight.length - 2);
        var TempHeight = divHeight;
        divHeight = divHeight - n;
        //y = y - document.getElementById("divMain").scrollTop;

        if ((document.body.offsetHeight - y) < parseInt(TempHeight))
        {
            var newTop = parseInt(y) - parseInt(TempHeight); //Fix for not able to see treediv after 19 variables since divheight value is negative  newTop is always increasing.So changed to TempHeight
            document.getElementById("RHSTreeDiv").style.left = x + "px";
            document.getElementById("RHSTreeDiv").style.top = (parseInt(newTop)) + "px";
        }
        else
        {
            document.getElementById("RHSTreeDiv").style.left = x + "px";
            document.getElementById("RHSTreeDiv").style.top = (parseInt(y) + 18) + "px";
        }


    }

}

//function ShowTreeView()
//{
//	if(mode=="LHS")
//	{
//	    document.getElementById("treeDiv").style.visibility = "visible";
//	    document.getElementById("treeDiv").style.display="block"; 
//	    var cmbLHSObj = document.getElementById("cmbLHS_Input");
//	    var x = findPosX(cmbLHSObj);
//	    var y = findPosY(cmbLHSObj);
//	    var divHeight = document.getElementById("treeDiv").style.height;
//	    divHeight = divHeight.substring(0,divHeight.length-2);

//	    y = y - document.getElementById("divMain").scrollTop;

//	    if((document.body.offsetHeight - y)<parseInt(divHeight))
//	    {
//	        var newTop = parseInt(y) - parseInt(divHeight); 
//	        document.getElementById("treeDiv").style.left= x+"px";
//	        document.getElementById("treeDiv").style.top = (parseInt(newTop))+"px";
//	    }
//	    else
//	    {   document.getElementById("treeDiv").style.left= x+"px";
//	        document.getElementById("treeDiv").style.top = (parseInt(y) + 18)+"px";
//	    } 
//	}
//	else
//	{
//	    document.getElementById("RHSTreeDiv").style.visibility = "visible";
//	    document.getElementById("RHSTreeDiv").style.display="block"; 
//	    var cmbLHSObj = document.getElementById("txtRHS");
//	    var x = findPosX(cmbLHSObj);
//	    var y = findPosY(cmbLHSObj);
//	    var divHeight = document.getElementById("RHSTreeDiv").style.height;
//	    divHeight = divHeight.substring(0,divHeight.length-2);

//	    y = y - document.getElementById("divMain").scrollTop;

//	    if((document.body.offsetHeight - y)<parseInt(divHeight))
//	    {
//	        var newTop = parseInt(y) - parseInt(divHeight); 
//	        document.getElementById("RHSTreeDiv").style.left= x+"px";
//	        document.getElementById("RHSTreeDiv").style.top = (parseInt(newTop))+"px";
//	    }
//	    else
//	    {   document.getElementById("RHSTreeDiv").style.left= x+"px";
//	        document.getElementById("RHSTreeDiv").style.top = (parseInt(y) + 18)+"px";
//	    } 


//}

//}

function HideTreeView()
{
    if (mode == "LHS")
        document.getElementById("treeDiv").style.visibility = "hidden";
    else if (mode == "RHS")
        document.getElementById("RHSTreeDiv").style.visibility = "hidden";
}


function AddRow(currentRow)
{
    var nextRow = parseInt(currentRow) + 1;
    var nextRowDivObj = document.getElementById("divExpressionLayer" + nextRow);
    var inHTMl = "";

    if (nextRowDivObj == null)
    {
        //alert(nextrow % 2);

        inHTMl = "<div id=\"divExpressionLayer" + nextRow + "\" style=\"width:100%;\">";
        if (parseInt(currentRow) % 2 == 0)
        {
            inHTMl = inHTMl + "<table width=\"100%\" cellspacing=2 cellpadding=0 border=0 style=\"height:40px;background-color:#f1f1f1\">";
        }
        else
        {
            inHTMl = inHTMl + "<table width=\"100%\" cellspacing=2 cellpadding=0 border=0 style=\"height:40px;background-color:#e0e1dd\">";
        }
        inHTMl = inHTMl + "<tr>";
        inHTMl = inHTMl + "<td width=\"100%\" class=\"\"> ";
        inHTMl = inHTMl + "<table width=\"100%\" id=\"TableExpression" + nextRow + "\"  border=0 cellspacing=0 cellpadding=6 class=\"tabInitial\">";
        inHTMl = inHTMl + "<tr>";
        inHTMl = inHTMl + "<td>";
        inHTMl = inHTMl + "<table width=100% cellspacing=0 cellpadding=0 border=0>";
        inHTMl = inHTMl + "<tr>";

        if (lhsAllowValue == "True")
        {
            inHTMl = inHTMl + "<td style=\"width: 36%;padding-left:10px\" class=\"description\"> <div id=\"LHS" + nextRow + "\" style=\"DISPLAY: inline;width:130px; \"><A class=\"GridHyperlinkStyle\" id=\"link" + nextRow + "\" onmouseover=\"Javascript:alterLinkEnter(this," + nextRow + ",'LHS')\" onclick=\"Javascript:alterLinkEnter(this," + nextRow + ",'LHS')\" href=\"#\">Enter</A></DIV></td>";
            //txtLHSObj.value="";
        }
        else
        {
            inHTMl = inHTMl + "<td style=\"width: 36%;padding-left:10px\" class=\"description\"> <div id=\"LHS" + nextRow + "\" style=\"DISPLAY: inline;width:130px; \"><A class=\"GridHyperlinkStyle\" id=\"link" + nextRow + "\" onmouseover=\"Javascript:alterLinkSelect(this," + nextRow + ",'LHS')\" onclick=\"Javascript:alterLinkSelect(this," + nextRow + ",'LHS')\" href=\"#\">Select</A></DIV></td>";
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


function ShowUpdateRow(currentRow)
{
    var currentRow = parseInt(currentRow);
    var currentRowDivObj = document.getElementById("divExpressionLayer" + currentRow);
    var inHTMl = "";

    if (currentRowDivObj == null)
    {
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
        inHTMl = inHTMl + "<td width=40% class=\"ContentText\"> <div id=\"LHS" + currentRow + "\" style=\"DISPLAY: inline;width:130px; \"><A class=\"hyperText\" id=\"link" + currentRow + "\" onmouseover=\"Javascript:alterLinkSelect(this," + currentRow + ",'LHS')\" onclick=\"Javascript:alterLinkSelect(this," + currentRow + ",'LHS')\" href=\"#\">Select</A></DIV></td>";
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

function ShowAlttext(textObject)
{//;
    var altText = "";
    var x = findPosX(textObject);
    var y = findPosY(textObject);
    //if(forcheck==1) 
    bubbleWindowObj.style.left = parseInt(x) + 10 + 'px';
    bubbleWindowObj.style.top = parseInt(y) + 30 + 'px';
    bubbleWindowObj.style.visibility = "visible";
    bubbleWindowObj.style.display = "block";
    bubbleWindowObj.style.position = "absolute";

    var currentRow = document.getElementById("hiddivNumber").value;

    if (eval("window.Row" + currentRow) != null)
    {
        //if(HSmode =="L")
        if (mode == "LHS")
        {
            if (eval("window.Row" + currentRow + ".LHSMode") == "default")
            {
                altText = eval("window.Row" + currentRow + ".LHSColumn");
                if (altText.length > 35)
                {
                    var count = altText.length / 35;
                    count = Math.floor(count);
                    for (i = 1; i <= count; i++)
                    {
                        altText = altText.substring(0, (i * 35) - count) + '<br>' + altText.substring((i * 35) - count, altText.length);
                    }
                }
            }
            else if (eval("window.Row" + currentRow + ".LHSMode") == "Expression")
            {
                altText = DecodeTheExpressionString(eval("window.Row" + currentRow + ".ColumnExpression.DisplayExpressionString"));
                if (altText.length > 35)
                {
                    var count = altText.length / 35;
                    count = Math.floor(count);
                    for (i = 1; i <= count; i++)
                    {
                        altText = altText.substring(0, (i * 35) - count) + '<br>' + altText.substring((i * 35) - count, altText.length);
                    }
                }
            }
            else
            {
                altText = eval("window.Row" + currentRow + ".LHSColumn");
                altText = escapeHTML(altText);
                if (altText.length > 35)
                {
                    var count = altText.length / 35;
                    count = Math.floor(count);
                    for (i = 1; i <= count; i++)
                    {
                        altText = altText.substring(0, (i * 35) - count) + '<br>' + altText.substring((i * 35) - count, altText.length);
                    }
                }
            }
        }

        if (mode == "RHS")
        {
            if (eval("window.Row" + currentRow + ".RHSMode") == "default")
            {
                altText = DecodeTheExpressionString(eval("window.Row" + currentRow + ".RHSValue"));
                if (altText.length > 35)
                {
                    var count = altText.length / 35;
                    count = Math.floor(count);
                    for (i = 1; i <= count; i++)
                    {
                        altText = DecodeTheExpressionString(altText.substring(0, (i * 35) - count) + '<br>' + altText.substring((i * 35) - count, altText.length));
                    }
                }
            }
            else if (eval("window.Row" + currentRow + ".RHSMode") == "Expression")
            {
                altText = DecodeTheExpressionString(eval("window.Row" + currentRow + ".ColumnExpression.DisplayExpressionString"));
                if (altText.length > 35)
                {
                    var count = altText.length / 35;
                    count = Math.floor(count);
                    for (i = 1; i <= count; i++)
                    {
                        altText = DecodeTheExpressionString(altText.substring(0, (i * 35) - count) + '<br>' + altText.substring((i * 35) - count, altText.length));
                    }
                }
            }
            else
            {
                altText = DecodeTheExpressionString(eval("window.Row" + currentRow + ".RHSColumn"));
                if (altText.length > 35)
                {
                    var count = altText.length / 35;
                    count = Math.floor(count);
                    for (i = 1; i <= count; i++)
                    {
                        altText = DecodeTheExpressionString(altText.substring(0, (i * 35) - count) + '<br>' + altText.substring((i * 35) - count, altText.length));
                    }
                }
            }
        }
    }

    if (trim(altText) == "")
    {
        if (textObject.id == "txtRHS")

            altText = conditionEnterValueLocal;

        if (trim(altText) == "")

            altText = conditionSelectLocal;

    }

    //alert(altText);
    bubbleWindowObj.innerHTML = altText;

}


function HideAlttext()
{

    //divbubbleObj = document.getElementById("bubbleDiv");
    bubbleWindowObj.innerHTML = "";
    bubbleWindowObj.style.display = "none";

}

function ChangeRHSMODE()
{
    if (prevRow == 0)
        prevRow = document.getElementById("hiddivNumber").value;
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


function ltrim(s)
{
    return s.replace(/^\s*/, "");
}

function rtrim(s)
{
    return s.replace(/\s*$/, "");
}

function trim(s)
{
    return rtrim(ltrim(s));
}

function ValidateFields()
{

    var errCount = 0;
    for (var i = 1; i < InitialUpdatedVariableArray.length + 1; i++)
    {
        if (document.getElementById("divExpressionLayer" + i) != null)
        {
            if (document.getElementById("divExpressionLayer" + i).style.display != "none")
            {
                if (eval("window.Row" + i + ".RHSMode") == "default")
                {
                    if (trim(eval("window.Row" + i + ".RHSValue")) == "")
                    {
                        if (eval("window.Row" + i + ".IsRHSExists==true"))
                        {
                            se.ui.messageDialog.showError(BellyBarTitile, ConditionPlsEnterValueLocal);
                            var rhsLinkObj = document.getElementById("rhsLink" + i);
                            if (rhsLinkObj != null)
                                alterLink(rhsLinkObj, i, 'RHS');
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

function Maximize(flag, val)
{
    xLHS = findPosX(document.getElementById("treeDiv"));
    yLHS = findPosY(document.getElementById("treeDiv"));
    xRHS = findPosX(document.getElementById("RHSTreeDiv"));
    yRHS = findPosY(document.getElementById("RHSTreeDiv"));
    var maxed = "NO";
    var iframeObjBubble = document.getElementById("IframeShimForBubble");
    objLHSRadDiv = document.getElementById("treeDiv");
    objLHSRadTree = document.getElementById("RadTree1");
    objRHSRadDiv = document.getElementById("RHSTreeDiv");
    objRHSRadTree = document.getElementById("RadTree2");

    if (flag == true)
    {
        if (mode == "LHS")
        {
            if (objLHSRadDiv.style.height != 317 + 'px' && objLHSRadDiv.style.width != 550 + 'px')
            {
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
        else
        {
            if (objRHSRadDiv.style.height != 317 + 'px' && objRHSRadDiv.style.width != 550 + 'px')
            {
                document.getElementById("HidXRHS").value = xRHS;
                document.getElementById("HidYRHS").value = yRHS;

                objRHSRadDiv.style.height = 317 + 'px';
                objRHSRadDiv.style.width = 550 + 'px';
                var Temp = 300 + 'px';
                iframeObjBubble.style.visibility = "visible";

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
    else
    {
        if (mode == "LHS")
        {
            if (objLHSRadDiv.style.height != 167 + 'px' && objLHSRadDiv.style.width != 272 + 'px')
            {
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
        else
        {
            if (objRHSRadDiv.style.height != 167 + 'px' && objRHSRadDiv.style.width != 272 + 'px')
            {
                iframeObjBubble.style.visibility = "hidden";
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


function EncodeTheExpressionString(expressionString)
{
    if (expressionString != null)
    {
        if (expressionString.indexOf("+") > -1)
        {
            expressionString = replaceExpressionstring(expressionString, "+", "_x002B_")
        }
        if (expressionString.indexOf("-") > -1)
        {
            expressionString = replaceExpressionstring(expressionString, "-", "_x002D_")
        }
        if (expressionString.indexOf("/") > -1)
        {
            expressionString = replaceExpressionstring(expressionString, "/", "_x002F_")
        }
    }
    return expressionString;
}


function DecodeTheExpressionString(expressionString)
{
    if (expressionString != null)
    {
        if (expressionString.indexOf("_x002B_") > -1)
        {
            expressionString = replaceExpressionstring(expressionString, "_x002B_", "+")
        }
        if (expressionString.indexOf("_x002D_") > -1)
        {
            expressionString = replaceExpressionstring(expressionString, "_x002D_", "-")
        }
        if (expressionString.indexOf("_x002F_") > -1)
        {
            expressionString = replaceExpressionstring(expressionString, "_x002F_", "/")
        }
    }
    return expressionString;
}


function replaceExpressionstring(stringtobereplaced, chartobereplaced, charbywhichreplaced)
{
    var out = "";
    if (stringtobereplaced == null) return;

    stringtobereplaced = stringtobereplaced.replace(chartobereplaced, charbywhichreplaced);

    if (stringtobereplaced.indexOf(chartobereplaced) > -1)
    {

        stringtobereplaced = replaceExpressionstring(stringtobereplaced, chartobereplaced, charbywhichreplaced);
    }

    return stringtobereplaced;
}

function TruncateString(TrunStr)
{
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
function escapeHTML(str) { var div = document.createElement('div'); var text = document.createTextNode(str); div.appendChild(text); return div.innerHTML; }