var addiconImagePath="";
var conditionalPageURL="";
var jsDecisionString="";

function OpenConditional(rowID)
{
    var winHeight=740;
    id = 'Con1';
    var height = screen.availHeight / 2;
    var width = screen.width / 2;
    var topValue = (height - 300 / 2);
    var leftValue = (width - 522 / 2);
    var topText = 'top=' + topValue;
    var leftText = 'left=' + leftValue;
    var alignment = topText + ',' + leftText; 
    window.open(conditionalPageURL + "&controlName=" + id + "&src=Decision&Rowid=" + rowID, id, 'height=' + winHeight + ',width=1000,resizable=yes,' + alignment + ',scrollbars=no,toolbars=0');
}


function AddNewRow()
{    
    var RowsCount = document.getElementById("totalRowCount").value;
    var newRowCount = parseInt(RowsCount) + 1;
    var innerHTML = AddRow(newRowCount);
    //Storing the Output values and Stop Processing Values in an array -Start
    var outputHiddenValues = new Array();
    var hiddenStopProcessingValues = new Array();
    for (var i = 0; i < newRowCount; i++) {
        if (document.getElementById("txtOutPut" + parseInt(i + 1)) != null)
        {
            outputHiddenValues[i + 1] = document.getElementById("txtOutPut" + parseInt(i + 1)).value;
        }
        if (document.getElementById("checkHalt" + parseInt(i + 1)) != null)
        {            
            hiddenStopProcessingValues[i + 1] = document.getElementById("checkHalt" + parseInt(i + 1)).checked;
        }
    }
    //Storing the Output values and Stop Processing Values in an array-End
    var divConditionLayersObj = document.getElementById("divConditionLayers");
    divConditionLayersObj.innerHTML = divConditionLayersObj.innerHTML + innerHTML;

    //Assigning values from the Output values and Stop Processing Values array -Start
    for (var i = 0; i < newRowCount; i++) {
        if (document.getElementById("txtOutPut" + parseInt(i + 1)) != null)
        {
            if (outputHiddenValues[i + 1] != null)
            {
                document.getElementById("txtOutPut" + parseInt(i + 1)).value = outputHiddenValues[i + 1];
            }
        }

        if (document.getElementById("checkHalt" + parseInt(i + 1)) != null)
        {
            if (hiddenStopProcessingValues[i + 1] != null)
            {
                if (hiddenStopProcessingValues[i + 1] == true)
                {
                    document.getElementById("checkHalt" + parseInt(i + 1)).checked = true;
                }
            }
        }
    }
    //Assigning values from the Output values and Stop Processing Values array -End
    document.getElementById("totalRowCount").value = newRowCount;
    eval("window.Decision" + newRowCount + " =new Decision()");
    ConditionArray[ConditionArray.length] = newRowCount;
}

function Decision()
{
    this.ConditionString = "";
    this.OutPut =  "";
    this.HaltExecution =  false;
}


function AddRow(currentRow) {    
    var innerHTML="";
    innerHTML="<div id=\"divConditionLayer"+currentRow+"\" style=\"padding-top:2px\">";
    innerHTML=innerHTML+"<table width=\"95%\" cellspacing=0 cellpadding=0 border=0>";
    innerHTML=innerHTML+"<tr>";
    innerHTML=innerHTML+"<td width=\"100%\">";
    innerHTML = innerHTML + "<fieldset border=\"none\" id=\"fldSet" + currentRow + "\" name=\"fldSet" + currentRow + "\">";
    innerHTML = innerHTML + "<legend border=\"none\"></legend>";
    innerHTML = innerHTML + "<table width=100%   height='40px' cellpadding=0 cellspacing=1 class=\"tablepdbg\" border=\"0\">";
    innerHTML = innerHTML + "<tr ><td colspan=\"4\" ><table width='100%' height='30px' cellpadding=0 cellspacing=0><tr class=\"GridHeaderStyle\"><td width='20%' style='padding-left:10px'>" + ruleLocal + "</td><td  width='80%' style='text-align:right;padding-right:10px'><a href=\"#\" class=\"a\" onclick=\"javascript:OpenConditional(" + currentRow + ")\"><img src='" + rulesicon + "' border=0 title=\"" + editconditionLocal + "\" alt=\"" + editconditionLocal + "\" hspace=\"3\" vspace=\"13\"/></a></td><td style='padding-right:10px'><a href=\"#\"  class=\"a\" onclick=\"DeleteRow(" + currentRow + ")\"><img src='" + deleteIcon + "' border=0  title=\"" + deleterule + "\" alt=\"" + deleterule + "\" hspace=\"3\" align=absmiddle/></a></td></tr></table></td></tr>";
    innerHTML=innerHTML+"<tr class=\"lefttdbg\">";
    innerHTML=innerHTML+"<td colspan=4 width=100%>";
    innerHTML=innerHTML+"<table cellpadding=\"5\" cellspacing=\"0\" border=\"0\">";
    innerHTML=innerHTML+"<tr>";
    innerHTML = innerHTML + "<td class=\"description\" align=right valign=\"top\">";
    innerHTML=innerHTML+""+conditionLocal;
    innerHTML=innerHTML+"<br/>";
    //innerHTML=innerHTML+"<a href=\"#\" class=\"a\" onclick=\"javascript:OpenConditional("+currentRow+")\"><img src='"+rulesicon+"' border=0 title=\""+editconditionLocal+"\" alt=\""+editconditionLocal+"\" hspace=\"3\" vspace=\"13\"/></a>";
    innerHTML=innerHTML+"</td>";
    innerHTML=innerHTML+"<td colspan=3>";
    innerHTML = innerHTML + "<div id=\"divCondition" + currentRow + "\" class=\"inputtextarea\" style=\"HEIGHT: 60px; width:570px; overflow:auto; border-style:solid;\" >&nbsp;</div>";
    innerHTML=innerHTML+"</td>";
    innerHTML=innerHTML+"</tr>";
    innerHTML=innerHTML+"<tr>";
    innerHTML=innerHTML+"<td width='10%' class=\"description\" align=\"right\">";
    innerHTML = innerHTML + "" + outputLocal;
    innerHTML=innerHTML+"</td>";
    innerHTML = innerHTML + "<td width='70%'>";
    innerHTML = innerHTML + "<input type=\"text\" id=\"txtOutPut" + currentRow + "\" name=\"txtOutPut" + currentRow + "\" class=\"inputtext\" maxlength=\"50\" style=\"width:200px\"/></td>";
    innerHTML = innerHTML + "<td width='5%' style='text-align:right;' class=\"description\"><input type=\"checkbox\" class=\"inputcheckbox\" id=\"checkHalt" + currentRow + "\" name=\"checkHalt" + currentRow + "\"/><td width='15%'  class=\"description\" nowrap>" + stopprocessLocal +"</td>";
    innerHTML=innerHTML+"</td>";
    innerHTML=innerHTML+"</tr>";
    innerHTML=innerHTML+"</table>";
    innerHTML=innerHTML+"<tr>";
    //innerHTML = innerHTML + "<td class=\"description\" height=\"22\" align=\"right\"><a href=\"#\"  class=\"a\" onclick=\"DeleteRow(" + currentRow + ")\"><img src='" + deleteIcon + "' border=0  title=\"" + deleterule + "\" alt=\"" + deleterule + "\" hspace=\"3\" align=absmiddle/></a></td>";
    innerHTML=innerHTML+"</tr>";
    innerHTML=innerHTML+"</table>";
    innerHTML=innerHTML+"</fieldset>";
    innerHTML=innerHTML+"</td>";
    innerHTML=innerHTML+"</tr>";
    innerHTML=innerHTML+"</table>";
    innerHTML=innerHTML+"</div>";
    return innerHTML;
}

function DeleteRow(rowno)
{
    
    var tobedeletedRow = 0;
    for(var i=0;i<ConditionArray.length;i++)
    {
        if(ConditionArray[i]!=0)
        {
           tobedeletedRow =  tobedeletedRow+1;
        }
    }
    
    if(tobedeletedRow>2)
    {
        for(var i=0;i<ConditionArray.length;i++)
        {
            if(ConditionArray[i]==rowno)
            {
               ConditionArray[i] =0;
            }
        }
        eval("Decision"+rowno+".ConditionString=\"\"");
        document.getElementById("divConditionLayer"+rowno).style.display="none";
    }
    else
    {
        document.getElementById("checkHalt"+rowno).checked=false;
        document.getElementById("txtOutPut"+rowno).value= "";
        eval("Decision"+rowno+".ConditionString=\"\"");
        var divObject = document.getElementById("divCondition"+rowno);  
        divObject.innerHTML = "";
        return false;
    }
}

/*******************Rowobject*******************/
function ConditionRow(MHS)
{
	this.LHSBrace ="";
	this.LHSColumn  = new ConditionColumn();	
	this.MHSActualText  = "EQ" ;	
	this.MHSDisplayText  = MHS ;	
	this.RHSColumn  = new ConditionColumn();
	this.LHSMode= "default";
	this.RHSMode    = "default";
	this.LogicalOpr = "AND";
	this.LHSMode    = "default";
	this.RHSValue   = "" ;
	this.RHSBrace ="";
}
/********************************************/
/*******************Columnobject*******************/
function ConditionColumn()
{
	this.DisplayText  = "";	
	this.Actualtext   = "";	
	this.DataType      = "";	
	this.RefFunction  = "";
	this.ParamList="";
	this.ColumnMode="default";
	this.ColumnExpression = new Expression('','','','','','','');
}
/********************************************/

function Expression(DisplayExpressionString,ActualExprtessionString,MethodParameterList,HtmlVerexpString,ReferenceList,ReferencedFunctionList,nodeinfo)
{
	this.DisplayExpressionString=DisplayExpressionString;
	this.ActualExprtessionString=ActualExprtessionString;
	this.MethodParameterList=MethodParameterList;
	this.HtmlVerexpString=HtmlVerexpString;
	this.ReferenceList = ReferenceList;
	this.ReferencedFunctionList = ReferencedFunctionList;
	this.NodeInfo  = nodeinfo;
}

/*******************Expressionobject*********************/
function Expression(DisplayExpressionString,ActualExprtessionString,MethodParameterList,HtmlVerexpString,ReferenceList,ReferencedFunctionList,nodeinfo)
{
	this.DisplayExpressionString=DisplayExpressionString;
	this.ActualExprtessionString=ActualExprtessionString;
	this.MethodParameterList=MethodParameterList;
	this.HtmlVerexpString=HtmlVerexpString;
	this.ReferenceList = ReferenceList;
	this.ReferencedFunctionList = ReferencedFunctionList;
	this.NodeInfo  = nodeinfo;
}
/************************************************/


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
/*Invoke Form Multiple Outputs*/
function AddMultipleOutputNewRow()
{
    var RowsCount=document.getElementById("totalRowCount").value;
    var newRowCount = parseInt(RowsCount) + 1;
    //var innerHTML = AddMultipleOutputRow(newRowCount);
    //var divConditionLayersObj =document.getElementById("divConditionLayers");
    
   //divConditionLayersObj.innerHTML = divConditionLayersObj.innerHTML+ innerHTML;
  AddMultipleOutputRow(newRowCount);
    document.getElementById("totalRowCount").value = newRowCount;
    eval("window.Decision"+newRowCount+" =new Decision()");
    ConditionArray[ConditionArray.length]=newRowCount;
}

function AddMultipleOutputRow(currentRow)
{
    if (navigator.userAgent.indexOf("MSIE 7.0") > 0)
        {
        
        var innerHTML = "";
            innerHTML="<div id=\"divConditionLayer"+currentRow+"\" width=\"98%\">";
            innerHTML=innerHTML+"<table width=\"97%\" cellspacing=0 cellpadding=5 border=0>";
            innerHTML=innerHTML+"<tr>";
            innerHTML=innerHTML+"<td width=\"100%\">";
            innerHTML = innerHTML + "<fieldset id=\"fldSet" + currentRow + "\" name=\"fldSet" + currentRow + "\">";
            innerHTML = innerHTML + "<legend class=\"subtitle\">1</legend>";					
            innerHTML=innerHTML+"<table width=100% cellpadding=0 cellspacing=0 border=\"0\" bgcolor=\"white\">";
            innerHTML=innerHTML+"<tr>";
            innerHTML=innerHTML+"<td colspan=4 width=100%>";
            innerHTML=innerHTML+"<table cellpadding=\"5\" cellspacing=\"0\" border=\"0\" width=98%>";
            innerHTML=innerHTML+"<tr>";
            innerHTML = innerHTML + "<td class=\"description\" align=right valign=\"top\" width=\"10%\">";
            innerHTML=innerHTML+""+conditionLocal+":";
            innerHTML=innerHTML+"<br/>";
            innerHTML=innerHTML+"<a href=\"#\" class=\"a\" onclick=\"javascript:OpenConditional("+currentRow+")\"><img src='"+rulesicon+"' border=0 title=\""+editconditionLocal+"\" alt=\""+editconditionLocal+"\" hspace=\"3\" vspace=\"13\"/></a>";
            innerHTML=innerHTML+"</td>";
            innerHTML=innerHTML+"<td width=\"87%\">";
            innerHTML = innerHTML + "<div id=\"divCondition" + currentRow + "\" class=\"inputtextarea\" style=\"HEIGHT: 60px; width:100%; overflow:auto; border-style:solid;\" >&nbsp;</div>";
            innerHTML=innerHTML+"</td>";
            innerHTML=innerHTML+"</tr>";
            innerHTML=innerHTML+"<tr>";
            innerHTML=innerHTML+"<td class=\"description\" align=\"right\">";
            innerHTML=innerHTML+""+outputLocal+":";    																	                                         
            innerHTML=innerHTML+"</td>";
            innerHTML = innerHTML + "<td>";
            innerHTML = innerHTML + "<input type=\"text\" id=\"txtOutPut" + currentRow + "\" name=\"txtOutPut" + currentRow + "\" class=\"inputtext\" maxlength=\"50\" style=\"width:200px\"/>&nbsp;";
            innerHTML=innerHTML+"</td>";
            innerHTML=innerHTML+"</tr>";
            innerHTML=innerHTML+"</table>";
            innerHTML=innerHTML+"<tr>";
            innerHTML = innerHTML + "<td class=\"description\" height=\"22\" align=\"right\"><a href=\"#\"  class=\"a\" onclick=\"DeleteMultipleOutputRow(" + currentRow + ")\"><img src='" + deleteIcon + "' border=0  title=\"" + deleterule + "\" alt=\"" + deleterule + "\" hspace=\"3\" align=absmiddle/></a></td>";
            innerHTML=innerHTML+"</tr>";
            innerHTML=innerHTML+"</table>";
            innerHTML=innerHTML+"</fieldset>";
            innerHTML=innerHTML+"</td>";
            innerHTML=innerHTML+"</tr>";
            innerHTML=innerHTML+"</table>";
            innerHTML=innerHTML+"</div>";
            document.getElementById('divConditionLayers').innerHTML= document.getElementById('divConditionLayers').innerHTML + innerHTML;
            }
            else
            {
        
        var divCLElem=document.createElement('div');
        divCLElem.id = "divConditionLayer" + currentRow;

        var innerHTML = "";
        innerHTML = "<div id=\"divConditionLayer" + currentRow + "\" style=\"padding-top:2px\">";

        innerHTML = innerHTML + "<table width=\"95%\" cellspacing=0 cellpadding=0 border=0>";
        innerHTML = innerHTML + "<tr>";
        innerHTML = innerHTML + "<td width=\"100%\">";
        innerHTML = innerHTML + "<fieldset border=\"none\" id=\"fldSet" + currentRow + "\" name=\"fldSet" + currentRow + "\">";
        innerHTML = innerHTML + "<legend border=\"none\"></legend>";
        innerHTML = innerHTML + "<table width=100%   height='40px' cellpadding=0 cellspacing=1 class=\"tablepdbg\" border=\"0\">";
        innerHTML = innerHTML + "<tr ><td colspan=\"4\" ><table width='100%' height='30px' cellpadding=0 cellspacing=0><tr class=\"GridHeaderStyle\"><td width='20%' style='padding-left:10px'>" + ruleLocal + "</td><td  width='80%' style='text-align:right;padding-right:10px'><a href=\"#\" class=\"a\" onclick=\"javascript:OpenConditional(" + currentRow + ")\"><img src='" + rulesicon + "' border=0 title=\"" + editconditionLocal + "\" alt=\"" + editconditionLocal + "\" hspace=\"3\" vspace=\"13\"/></a></td><td style='padding-right:10px'><a href=\"#\"  class=\"a\" onclick=\"DeleteMultipleOutputRow(" + currentRow + ")\"><img src='" + deleteIcon + "' border=0  title=\"" + deleterule + "\" alt=\"" + deleterule + "\" hspace=\"3\" align=absmiddle/></a></td></tr></table></td></tr>";
        innerHTML = innerHTML + "<tr class=\"lefttdbg\">";
        innerHTML = innerHTML + "<td colspan=4 width=100%>";
        innerHTML = innerHTML + "<table cellpadding=\"5\" cellspacing=\"0\" border=\"0\">";
        innerHTML = innerHTML + "<tr>";
        innerHTML = innerHTML + "<td class=\"description\" align=right valign=\"top\">";
        innerHTML = innerHTML + "" + conditionLocal;
        innerHTML = innerHTML + "<br/>";
        //innerHTML=innerHTML+"<a href=\"#\" class=\"a\" onclick=\"javascript:OpenConditional("+currentRow+")\"><img src='"+rulesicon+"' border=0 title=\""+editconditionLocal+"\" alt=\""+editconditionLocal+"\" hspace=\"3\" vspace=\"13\"/></a>";
        innerHTML = innerHTML + "</td>";
        innerHTML = innerHTML + "<td colspan=3>";
        innerHTML = innerHTML + "<div id=\"divCondition" + currentRow + "\" class=\"inputtextarea\" style=\"HEIGHT: 60px; width:570px; overflow:auto; border-style:solid;\" >&nbsp;</div>";
        innerHTML = innerHTML + "</td>";
        innerHTML = innerHTML + "</tr>";
        innerHTML = innerHTML + "<tr>";
        innerHTML = innerHTML + "<td width='10%' class=\"description\" >";
        innerHTML = innerHTML + "" + outputLocal;
        innerHTML = innerHTML + "</td>";
        innerHTML = innerHTML + "<td width='70%'>";
        innerHTML = innerHTML + "<input type=\"text\" id=\"txtOutPut" + currentRow + "\" name=\"txtOutPut" + currentRow + "\" class=\"inputtext\" maxlength=\"50\" style=\"width:200px\"/></td>";
        innerHTML = innerHTML + "<td width='5%' style='text-align:right;' class=\"description\"></td>";
        innerHTML = innerHTML + "</td>";
        innerHTML = innerHTML + "</tr>";
        innerHTML = innerHTML + "</table>";
        innerHTML = innerHTML + "<tr>";
        //innerHTML = innerHTML + "<td class=\"description\" height=\"22\" align=\"right\"><a href=\"#\"  class=\"a\" onclick=\"DeleteRow(" + currentRow + ")\"><img src='" + deleteIcon + "' border=0  title=\"" + deleterule + "\" alt=\"" + deleterule + "\" hspace=\"3\" align=absmiddle/></a></td>";
        innerHTML = innerHTML + "</tr>";
        innerHTML = innerHTML + "</table>";
        innerHTML = innerHTML + "</fieldset>";
        innerHTML = innerHTML + "</td>";
        innerHTML = innerHTML + "</tr>";
        innerHTML = innerHTML + "</table>";
        innerHTML = innerHTML + "</div>";
        divCLElem.innerHTML = innerHTML;
        
        document.getElementById('divConditionLayers').appendChild(divCLElem);
        }
}

function DeleteMultipleOutputRow(rowno)
{
    
    var tobedeletedRow = 0;
    for(var i=0;i<ConditionArray.length;i++)
    {
        if(ConditionArray[i]!=0)
        {
           tobedeletedRow =  tobedeletedRow+1;
        }
    }
    
    if(tobedeletedRow>=2)
    {
        for(var i=0;i<ConditionArray.length;i++)
        {
            if(ConditionArray[i]==rowno)
            {
               ConditionArray[i] =0;
            }
        }
        eval("Decision"+rowno+".ConditionString=\"\"");
        document.getElementById("divConditionLayer"+rowno).style.display="none";
    }
    else
    {
        //document.getElementById("checkHalt"+rowno).checked=false;
        document.getElementById("txtOutPut"+rowno).value= "";
        eval("Decision"+rowno+".ConditionString=\"\"");
        var divObject = document.getElementById("divCondition"+rowno);  
        divObject.innerHTML = "";
        return false;
    }
}
