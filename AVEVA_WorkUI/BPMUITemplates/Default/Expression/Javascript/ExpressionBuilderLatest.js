//Declaration
var divtreeviewObj;
var divtreeviewLabelObj;
var divbubbleObj;
var browserCode=GetBrowserversion();        //IE - 1; fireFox--2
var newNodeValue="";
var nodeValue="";
var bubbleText="";
var newAssmblyUrl="";
var posX="",divXPos="";
var posY="",divYPos="";
var editorFrame;
var controlName="";
var editorTarget=null;
var addedNodestoMainContentArrary=new Array();
var addedNodestoParameterArrary=new Array();
var editor;
var IframeTreeObject=null;
var _displayExpressionString="";
var _actualExprtessionString="";
var _methodparameterList="";
var _expressionCode="";
var contentOfEditor="";
var _htmlVerexpString="";
var expCompResult="";
var editorTarget=null;
var errorCode="";
var referenceList="";
var callBackFunction="";
var parentControl;
var parentControlName="";
var functionList="";
var childwindow;
var extUIwindow;
var editorCtlName="";
var AutoHide=0;
var splitMode=0;
var splittercursorflag=0;
var dragmodetext="";
var resizeMode=0;
var nodeInfo="";
var compiledCode="";
var curentExpression=new Expression('','','','','','','','');

//Localized Messages
var errorAlertforExpression="";
var expErrorAlertforExpression="";
var expErrinExpression = "";
var expCodeInExpression = "";
var expErrorstext ="";
var expCompiledCode="";
var _returnType="";
var TempRetType = "";



function ExpressionEditor(controlID)
{
	this.ID = controlID;
	this.CallBackfunctionName="";
}

function refreshselectedaction()
{
    parent._skProcessDesigner.refreshaction();
    
 }

function GetExpressionEditor(expressionEditorID)
{
	var expEditor = null;
	expEditor = eval(expressionEditorID);
	return expEditor;
};

ExpressionEditor.prototype.SetExpression = function(expressionObject)
{
    editor = $find(editorCtlName);    
    //setTimeout(function () { editor.setFocus(); }, 10);
    
    if(expressionObject.HtmlVerexpString!="")
    {
        editor.set_html(HtmlDecode(expressionObject.HtmlVerexpString));

        //editor.set_html(replacestring(expressionObject.HtmlVerexpString,"$","+"));  
         _displayExpressionString = expressionObject.DisplayExpressionString; 
        //_actualExprtessionString = replacestring(expressionObject.ActualExprtessionString,"$","+");
        _actualExprtessionString = expressionObject.ActualExprtessionString;
	    _methodparameterList = expressionObject.MethodParameterList;
	    _htmlVerexpString =expressionObject.HtmlVerexpString;
	    functionList=expressionObject.ReferencedFunctionList;
	    referenceList = expressionObject.ReferenceList;
	    nodeInfo = expressionObject.NodeInfo;
	    ////setting the drop down
	    _returnType = expressionObject.ReturnType;
	    var NewReturnType=document.getElementById(TempRetType);
	    NewReturnType.value=_returnType;
	    
    }
    
    
 
  /*  _displayExpressionString; 
	_actualExprtessionString;
	_methodparameterList;
	encodeString(_htmlVerexpString);
	functionList;
	referenceList;
    */
};



function EncodeTheExpressionString(expressionString)
{
    if(expressionString!=null)
    {
        if(expressionString.indexOf("+")>-1)
        {
            expressionString = replaceExpressionstring(expressionString,"+","_x002B_")
        }
        if(expressionString.indexOf("-")>-1)
        {
            expressionString = replaceExpressionstring(expressionString,"-","_x002D_")
        }
        if(expressionString.indexOf("/")>-1)
        {
            expressionString = replaceExpressionstring(expressionString,"/","_x002F_")    
        }
    }
    return expressionString; 
}


function DecodeTheExpressionString(expressionString)
{
    if(expressionString!=null)
    {
        if(expressionString.indexOf("_x002B_")>-1)
        {
            expressionString = replaceExpressionstring(expressionString,"_x002B_","+")
        }
        if(expressionString.indexOf("_x002D_")>-1)
        {
            expressionString = replaceExpressionstring(expressionString,"_x002D_","-")
        }
        if(expressionString.indexOf("_x002F_")>-1)
        {
            expressionString = replaceExpressionstring(expressionString,"_x002F_","/")    
        }
    }
    return expressionString; 
}

function replacestring(stringtobereplaced,chartobereplaced,charbywhichreplaced)
{
  var out = ""; 
  if (stringtobereplaced==null) return; 
  var l = stringtobereplaced.length; 
  for (var i=0; i<l; i++) 
  { 
        var ch = stringtobereplaced.charAt(i); 
        if (ch == chartobereplaced) 
        {
           stringtobereplaced = stringtobereplaced.replace(ch,charbywhichreplaced);      
        }
  }
            
  return stringtobereplaced;          
}




function ReplaceSplTags(inputString,stringtobereplaced,stringbywhichreplaced)
{
    var returnstring = "";
    
    returnstring = inputString.replace(stringtobereplaced,stringbywhichreplaced);

    if(returnstring.indexOf(stringtobereplaced)>-1)
    {
        returnstring = ReplaceSplTags(returnstring,stringtobereplaced,stringbywhichreplaced)
    }
    return returnstring;
}

ExpressionEditor.prototype.BuildExpression = function () {
    
    editor = $find(editorCtlName);
    contentOfEditor = editor.get_text();
    
    if (trim(contentOfEditor) == "") {
        ShowMessagesWithBellyBar(2, validationMsg);
        //alert(validationMsg);
    }
    
    _htmlVerexpString = editor.get_html();
    callBackFunction = this.CallBackfunctionName;
    contentOfEditor = contentOfEditor.replace(/\n/gi, "");
    contentOfEditor = contentOfEditor.replace(/\r/gi, "");

    _displayExpressionString = contentOfEditor;

    if (trim(contentOfEditor) == "") {
        return false;
    }
    else {
        DisableButton();
    }
    //	if( (contentOfEditor.indexOf("[")==-1) || (contentOfEditor.indexOf("]")==-1) )
    //	{
    //	}//End of checking the user has replaced the place holders "[]"
    //	else//If place holder still remains then alert the user
    //	{
    //		alert(expPlaceHoderValidationMsg);
    //	}

    var _addedFunctionList = "";
    var _functionList = "";
    var _addedactualexpressionstring = "";
    var _nodeinfo = "";

    _addedactualexpressionstring = contentOfEditor;
    //_addedactualexpressionstring=escapeHTML(_addedactualexpressionstring);
    for (var mainNodeCount = 0; mainNodeCount <= addedNodestoMainContentArrary.length - 1; mainNodeCount++) {
        splitArray = addedNodestoMainContentArrary[mainNodeCount].split("~~");

        //  if(contentOfEditor.indexOf(splitArray[0])!=-1)		{

        var getMethodParameters = splitArray[2].split("$$");

        if (getMethodParameters[1] == "True") {
            var singleparameter = getMethodParameters[0]; //+ " " +	getMethodParameters[1];

            if (_methodparameterList.indexOf(singleparameter) == "-1") {
                if (trim(_methodparameterList) == "") {
                    _methodparameterList = getMethodParameters[0]; //+ " " +	getMethodParameters[1];
                }
                else {
                    _methodparameterList = _methodparameterList + "," + getMethodParameters[0]; //+ " " +	getMethodParameters[1];
                }
            }

            _addedactualexpressionstring = _addedactualexpressionstring.replace(trim(splitArray[0]), splitArray[1]);

            //The above code is not replacing the method name if the method has parameters. We are not fixing it generally because, it needs testing all the areas. Check for SOAWebObjects can be removed later.
            try {
                if (splitArray[0].match("^SOAWebObjects") == "SOAWebObjects") {
                    var methodname = splitArray[0].substring(0, splitArray[0].indexOf("("));
                    if (splitArray[1].indexOf("(") != -1) {
                        _addedactualexpressionstring = _addedactualexpressionstring.replace(methodname, splitArray[1].substring(0, splitArray[1].indexOf("(")));
                    }
                }
            }
            catch (err) {
            }

            if (trim(_nodeinfo) == "")
                _nodeinfo = splitArray[0] + "#" + splitArray[1];
            else
                _nodeinfo = _nodeinfo + "$" + splitArray[0] + "#" + splitArray[1];

            if (getMethodParameters[3] != "") {

                if (_addedFunctionList.indexOf(getMethodParameters[2]) == "-1") {
                    if (trim(_addedFunctionList) == "") {
                        _addedFunctionList = getMethodParameters[2];
                    }
                    else {
                        _addedFunctionList = _addedFunctionList + "#" + getMethodParameters[2];
                    }
                }
            }
            //}
            //else
            //{

            //}
        }
        else if (splitArray[0].indexOf("(") != -1) {
            var methodname = splitArray[0].substring(0, splitArray[0].indexOf("("));

            if (contentOfEditor.indexOf(methodname) != -1) {
                _addedactualexpressionstring = _addedactualexpressionstring.replace(methodname, splitArray[1].substring(0, splitArray[1].indexOf("(")));
            }

        }
    }

    //SOA WebObjects in Update Mode
    if (_addedactualexpressionstring.indexOf("SOAWebObjects.") != -1) {

        var indexSOAWebObject = _addedactualexpressionstring.indexOf("SOAWebObjects.");
        //Find till the method name
        var indexLastMethodName = 0;
        indexLastMethodName = _addedactualexpressionstring.indexOf(".", indexSOAWebObject);
        indexLastMethodName = _addedactualexpressionstring.indexOf("(", indexLastMethodName);
        var actualMethodName = _addedactualexpressionstring.substring(indexSOAWebObject, indexLastMethodName);
        var changedMethodName = actualMethodName;
        changedMethodName = actualMethodName.replace(/\./g, "_");
        _addedactualexpressionstring = _addedactualexpressionstring.replace(actualMethodName, changedMethodName);
        //Add the unique value to the existing
        var value = 0;
        if (functionList.indexOf(changedMethodName) != -1) {
            var methodNameWithInteger = functionList.indexOf("(", functionList.indexOf(changedMethodName));
            _addedactualexpressionstring = _addedactualexpressionstring.replace(changedMethodName, functionList.substring(functionList.indexOf(changedMethodName), methodNameWithInteger));

        }

        //Replace the same where ever the object is found
        _addedactualexpressionstring = RepalceActualSOAWebObjectsInAllPlaces(indexSOAWebObject, _addedactualexpressionstring, functionList);
    }


    if (trim(functionList) != "") {
        if (trim(_addedFunctionList) != "")
            functionList = functionList + "#" + _addedFunctionList;
    }
    else {
        if (trim(_addedFunctionList) != "")
            functionList = _addedFunctionList;
    }



    if (trim(_addedactualexpressionstring) != "") {
        if (trim(_actualExprtessionString) != "") {
            if (trim(nodeInfo) != "") {
                var nodeInfoArr = nodeInfo.split('$');

                for (var i = 0; i < nodeInfoArr.length; i++) {
                    var nodeInfovalueArr = nodeInfoArr[i].split('#');
                    _addedactualexpressionstring = _addedactualexpressionstring.replace(nodeInfovalueArr[0], nodeInfovalueArr[1]);
                }
            }
        }
        _actualExprtessionString = _addedactualexpressionstring;
    }

    //_actualExprtessionString = _addedactualexpressionstring;

    if (trim(nodeInfo) != "") {
        if (trim(_nodeinfo) != "") {
            nodeInfo = nodeInfo + "$" + _nodeinfo;
        }
    }
    else {
        if (trim(_nodeinfo) != "") {
            nodeInfo = _nodeinfo;
        }

    }


    if (_displayExpressionString != "") {
        _displayExpressionString = EncodeTheExpressionString(_displayExpressionString);
        _actualExprtessionString = EncodeTheExpressionString(_actualExprtessionString);
        _htmlVerexpString = EncodeTheExpressionString(_htmlVerexpString);

        /*parentControl.Expression.DisplayExpressionString=_displayExpressionString; 
        parentControl.Expression.ActualExprtessionString=_actualExprtessionString;
        parentControl.Expression.MethodParameterList=_methodparameterList;
        parentControl.Expression.HtmlVerexpString=encodeString(_htmlVerexpString);
        parentControl.Expression.ReferencedFunctionList=functionList;
        parentControl.Expression.ReferenceList=referenceList;
        parentControl.Expression.NodeInfo=nodeInfo;*/

        _returnType = document.getElementById("ExpressionBuilderControl1_ctl01_expReturnType");
        curentExpression.ReturnType = _returnType.value;

        curentExpression.DisplayExpressionString = _displayExpressionString;
        curentExpression.ActualExprtessionString = _actualExprtessionString;
        curentExpression.MethodParameterList = _methodparameterList;
        curentExpression.HtmlVerexpString = encodeString(_htmlVerexpString);
        curentExpression.ReferencedFunctionList = EncodeTheExpressionString(functionList);
        curentExpression.ReferenceList = referenceList;
        curentExpression.NodeInfo = nodeInfo;



        CallServerSideMethod(controlName, 'CheckExpression', "DataTableTest", CallbackCheckxpression, 'table', curentExpression);
        return false;
    }

};

ExpressionEditor.prototype.ClearEditor = function () {
    editor = $find(editorCtlName);
    editor.set_html("");
    addedNodestoMainContentArrary = new Array();
    functionList = "";
}

ExpressionEditor.prototype.BuildAndViewExpression = function() {
    editor = $find(editorCtlName);
    contentOfEditor = editor.get_text();
    _htmlVerexpString = editor.get_html();
    callBackFunction = this.CallBackfunctionName;
    contentOfEditor = contentOfEditor.replace(/\n/gi, "");
    contentOfEditor = contentOfEditor.replace(/\r/gi, "");

    _displayExpressionString = contentOfEditor;

    if (trim(contentOfEditor) == "") {
        return false;
    }
    else {
        DisableButton();
    }
    //	if( (contentOfEditor.indexOf("[")==-1) || (contentOfEditor.indexOf("]")==-1) )
    //	{
    //	}//End of checking the user has replaced the place holders "[]"
    //	else//If place holder still remains then alert the user
    //	{
    //		alert(expPlaceHoderValidationMsg);
    //	}

    var _addedFunctionList = "";
    var _functionList = "";
    var _addedactualexpressionstring = "";
    var _nodeinfo = "";

    _addedactualexpressionstring = contentOfEditor;
    //_addedactualexpressionstring=escapeHTML(_addedactualexpressionstring);
    for (var mainNodeCount = 0; mainNodeCount <= addedNodestoMainContentArrary.length - 1; mainNodeCount++) {
        splitArray = addedNodestoMainContentArrary[mainNodeCount].split("~~");

        //  if(contentOfEditor.indexOf(splitArray[0])!=-1)		{

        var getMethodParameters = splitArray[2].split("$$");

        if (getMethodParameters[1] == "True") {
            var singleparameter = getMethodParameters[0]; //+ " " +	getMethodParameters[1];

            if (_methodparameterList.indexOf(singleparameter) == "-1") {
                if (trim(_methodparameterList) == "") {
                    _methodparameterList = getMethodParameters[0]; //+ " " +	getMethodParameters[1];
                }
                else {
                    _methodparameterList = _methodparameterList + "," + getMethodParameters[0]; //+ " " +	getMethodParameters[1];
                }
            }

            _addedactualexpressionstring = _addedactualexpressionstring.replace(trim(splitArray[0]), splitArray[1]);

            //The above code is not replacing the method name if the method has parameters. We are not fixing it generally because, it needs testing all the areas. Check for SOAWebObjects can be removed later.
            try {
                if (splitArray[0].match("^SOAWebObjects") == "SOAWebObjects") {
                    var methodname = splitArray[0].substring(0, splitArray[0].indexOf("("));
                    if (splitArray[1].indexOf("(") != -1) {
                        _addedactualexpressionstring = _addedactualexpressionstring.replace(methodname, splitArray[1].substring(0, splitArray[1].indexOf("(")));
                    }
                }
            }
            catch (err) {
            }

            if (trim(_nodeinfo) == "")
                _nodeinfo = splitArray[0] + "#" + splitArray[1];
            else
                _nodeinfo = _nodeinfo + "$" + splitArray[0] + "#" + splitArray[1];

            if (getMethodParameters[3] != "") {

                if (_addedFunctionList.indexOf(getMethodParameters[2]) == "-1") {
                    if (trim(_addedFunctionList) == "") {
                        _addedFunctionList = getMethodParameters[2];
                    }
                    else {
                        _addedFunctionList = _addedFunctionList + "#" + getMethodParameters[2];
                    }
                }
            }
            //}
            //else
            //{

            //}
        }
        else if (splitArray[0].indexOf("(") != -1) {
            var methodname = splitArray[0].substring(0, splitArray[0].indexOf("("));

            if (contentOfEditor.indexOf(methodname) != -1) {
                _addedactualexpressionstring = _addedactualexpressionstring.replace(methodname, splitArray[1].substring(0, splitArray[1].indexOf("(")));
            }

        }
    }

    //SOA WebObjects in Update Mode
    if (_addedactualexpressionstring.indexOf("SOAWebObjects.") != -1) {

        var indexSOAWebObject = _addedactualexpressionstring.indexOf("SOAWebObjects.");
        //Find till the method name
        var indexLastMethodName = 0;
        indexLastMethodName = _addedactualexpressionstring.indexOf(".", indexSOAWebObject);
        indexLastMethodName = _addedactualexpressionstring.indexOf("(", indexLastMethodName);
        var actualMethodName = _addedactualexpressionstring.substring(indexSOAWebObject, indexLastMethodName);
        var changedMethodName = actualMethodName;
        changedMethodName = actualMethodName.replace(/\./g, "_");
        _addedactualexpressionstring = _addedactualexpressionstring.replace(actualMethodName, changedMethodName);
        //Add the unique value to the existing
        var value = 0;
        if (functionList.indexOf(changedMethodName) != -1) {
            var methodNameWithInteger = functionList.indexOf("(", functionList.indexOf(changedMethodName));
            _addedactualexpressionstring = _addedactualexpressionstring.replace(changedMethodName, functionList.substring(functionList.indexOf(changedMethodName), methodNameWithInteger));

        }

        //Replace the same where ever the object is found
        _addedactualexpressionstring = RepalceActualSOAWebObjectsInAllPlaces(indexSOAWebObject, _addedactualexpressionstring, functionList);
    }


    if (trim(functionList) != "") {
        if (trim(_addedFunctionList) != "")
            functionList = functionList + "#" + _addedFunctionList;
    }
    else {
        if (trim(_addedFunctionList) != "")
            functionList = _addedFunctionList;
    }



    if (trim(_addedactualexpressionstring) != "") {
        if (trim(_actualExprtessionString) != "") {
            if (trim(nodeInfo) != "") {
                var nodeInfoArr = nodeInfo.split('$');

                for (var i = 0; i < nodeInfoArr.length; i++) {
                    var nodeInfovalueArr = nodeInfoArr[i].split('#');
                    _addedactualexpressionstring = _addedactualexpressionstring.replace(nodeInfovalueArr[0], nodeInfovalueArr[1]);
                }
            }
        }
        _actualExprtessionString = _addedactualexpressionstring;
    }

    //_actualExprtessionString = _addedactualexpressionstring;

    if (trim(nodeInfo) != "") {
        if (trim(_nodeinfo) != "") {
            nodeInfo = nodeInfo + "$" + _nodeinfo;
        }
    }
    else {
        if (trim(_nodeinfo) != "") {
            nodeInfo = _nodeinfo;
        }

    }


    if (_displayExpressionString != "") {
        _displayExpressionString = EncodeTheExpressionString(_displayExpressionString);
        _actualExprtessionString = EncodeTheExpressionString(_actualExprtessionString);
        _htmlVerexpString = EncodeTheExpressionString(_htmlVerexpString);

        /*parentControl.Expression.DisplayExpressionString=_displayExpressionString; 
        parentControl.Expression.ActualExprtessionString=_actualExprtessionString;
        parentControl.Expression.MethodParameterList=_methodparameterList;
        parentControl.Expression.HtmlVerexpString=encodeString(_htmlVerexpString);
        parentControl.Expression.ReferencedFunctionList=functionList;
        parentControl.Expression.ReferenceList=referenceList;
        parentControl.Expression.NodeInfo=nodeInfo;*/

        _returnType = document.getElementById("ExpressionBuilderControl1_ctl01_expReturnType");
        curentExpression.ReturnType = _returnType.value;

        curentExpression.DisplayExpressionString = _displayExpressionString;
        curentExpression.ActualExprtessionString = _actualExprtessionString;
        curentExpression.MethodParameterList = _methodparameterList;
        curentExpression.HtmlVerexpString = encodeString(_htmlVerexpString);
        curentExpression.ReferencedFunctionList = EncodeTheExpressionString(functionList);
        curentExpression.ReferenceList = referenceList;
        curentExpression.NodeInfo = nodeInfo;



        CallServerSideMethod(controlName, 'CheckExpression', "DataTableTest", CallbackViewxpression, 'table', curentExpression);
        return false;
    }

};



function RepalceActualSOAWebObjectsInAllPlaces(indexSOAWebObject, _addedactualexpressionstring, functionList) {
    var indexSOAWebObject = _addedactualexpressionstring.indexOf("SOAWebObjects.", indexSOAWebObject);
    if (indexSOAWebObject != -1) {
        //Find till the method name
        var indexLastMethodName = 0;
        indexLastMethodName = _addedactualexpressionstring.indexOf(".", indexSOAWebObject);
        indexLastMethodName = _addedactualexpressionstring.indexOf("(", indexLastMethodName);
        var actualMethodName = _addedactualexpressionstring.substring(indexSOAWebObject, indexLastMethodName);
        var changedMethodName = actualMethodName;
        changedMethodName = actualMethodName.replace(/\./g, "_");
        _addedactualexpressionstring = _addedactualexpressionstring.replace(actualMethodName, changedMethodName);
        //Add the unique value to the existing
        var value = 0;
        if (functionList.indexOf(changedMethodName) != -1) {
            var methodNameWithInteger = functionList.indexOf("(", functionList.indexOf(changedMethodName));
            var changedMethodNameForFunction = changedMethodName;
            changedMethodName = changedMethodName + "(";
            _addedactualexpressionstring = _addedactualexpressionstring.replace(changedMethodName, functionList.substring(functionList.indexOf(changedMethodNameForFunction), methodNameWithInteger + 1));

            _addedactualexpressionstring = RepalceActualSOAWebObjectsInAllPlaces(indexSOAWebObject, _addedactualexpressionstring, functionList);
        }
    }
    return _addedactualexpressionstring;
}

function EncodeTheExpressionString(expressionString)
{
    if(expressionString.indexOf("+")>-1)
    {
        expressionString = replaceExpressionstring(expressionString,"+","_x002B_")
    }
    if(expressionString.indexOf("-")>-1)
    {
        expressionString = replaceExpressionstring(expressionString,"-","_x002D_")
    }
    if(expressionString.indexOf("/")>-1)
    {
        expressionString = replaceExpressionstring(expressionString,"/","_x002F_")    
    }
    return expressionString; 
}


function DecodeTheExpressionString(expressionString)
{
    if(expressionString.indexOf("_x002B_")>-1)
    {
        expressionString = replaceExpressionstring(expressionString,"_x002B_","+")
    }
    if(expressionString.indexOf("_x002D_")>-1)
    {
        expressionString = replaceExpressionstring(expressionString,"_x002D_","-")
    }
    if(expressionString.indexOf("_x002F_")>-1)
    {
        expressionString = replaceExpressionstring(expressionString,"_x002F_","/")    
    }
    return expressionString; 
}

function replacestring(stringtobereplaced,chartobereplaced,charbywhichreplaced)
{
  var out = ""; 
  if (stringtobereplaced==null) return; 
  var l = stringtobereplaced.length; 
  for (var i=0; i<l; i++) 
  { 
        var ch = stringtobereplaced.charAt(i); 
        if (ch == chartobereplaced) 
        {
           stringtobereplaced = stringtobereplaced.replace(ch,charbywhichreplaced);      
        }
  }
            
  return stringtobereplaced;          
}

function replaceExpressionstring(stringtobereplaced,chartobereplaced,charbywhichreplaced)
{
  var out = ""; 
  if (stringtobereplaced==null) return; 
  
  stringtobereplaced = stringtobereplaced.replace(chartobereplaced,charbywhichreplaced);      
  
  if(stringtobereplaced.indexOf(chartobereplaced)>-1)
  {
        
        stringtobereplaced = replaceExpressionstring(stringtobereplaced,chartobereplaced,charbywhichreplaced);
  }
         
  return stringtobereplaced;          
}

function NotifyError(errString)
{
    //alert(errString);
    ShowMessagesWithBellyBar(2, errString);
}


function encodeString(htmlString)
{
      var out = ""; 
      if (htmlString==null) return; 
      var l = htmlString.length; 
      for (var i=0; i<l; i++) 
      { 
            var ch = htmlString.charAt(i);
            if(ch=="<")
            {
                ch="&lt;";
            }
            else if(ch==">")
            {
                ch="&gt;";
            } 
            out=out+ch;
      }
      return out;
}
function OnClientCommandExecuting (editor, commandName, oTool)
{ 
   
  if ("FindAndReplace" == commandName) return false;     
}


function InitializeExpressionEditor()
{
	divbubbleObj=document.getElementById("bubbleDiv");
	divbubbleObj.style.display="none";
	
	errLnkObj=document.getElementById("errorLink");
	errLnkObj.style.display="none";
	
	ErrorDivObj=document.getElementById("ErrorDiv");
	ErrorDivObj.style.display="none";
	
	
	editorFrame = document.getElementById(controlName + "_ctl01_RadEditor1_contentIframe");
	document.onmousemove=parentwindowmousemovehandler;
		
}

function parentwindowmousemovehandler(e)
{
   	if( !e ) e=event;
   	if(bubbleText!="")
    {
	    divbubbleObj=document.getElementById("bubbleDiv");
	    divbubbleObj.innerHTML	= bubbleText;
	    divbubbleObj.style.left = parseInt(e.clientX)+5 + 'px';
	    divbubbleObj.style.top  = parseInt(e.clientY)+23 + 'px';
	}
}



function mystartdraghandler(sender, eventArgs)
{        
    var node = eventArgs.get_node();    
    if (node.get_allowDrag()==true)
    {
        divbubbleObj=parent.document.getElementById("bubbleDiv");
	    editorFrame = window.parent.document.getElementById(controlName + "_ctl01_RadEditor1_contentIframe");
	    
	    IframeTreeObject=window.parent.document.getElementById ("RadTree1.ClientID");//ObjectTree_frame
	    newNodeValue = GetExactnodeValue(node.get_value());
        nodeValue = node.get_value();
	    
    	if(newNodeValue.indexOf("&lt;")!=-1)
	    {
            bubbleText = node.get_text();
            parent.bubbleText = node.get_text();
	    }
	    else
	    {
		    bubbleText = newNodeValue;	
		    parent.bubbleText=  newNodeValue;
	    }
	    	    
	    document.onmousemove=mousemovehandler;
        editorFrame.contentWindow.document.onmousemove=mousemovehandlerOnFrame;
	    editorFrame.contentWindow.document.onmouseup=mmh;	   
    	
	    parent.document.body.style.cursor = "hand";
	    editorFrame.contentWindow.document.body.style.cursor = "hand";
    	
	    divbubbleObj.style.visibility="visible";
	    divbubbleObj.style.display="block";
	    divbubbleObj.style.position="absolute";	
	}
	else
	{
        if (node.get_category()=="Clk")
            window.parent.openExtendedUI(node.ID, node.get_value());
	}
	return false;
}

function mousemovehandler(e)
{	
	if( !e ) e=	event;
	divbubbleObj=parent.document.getElementById("bubbleDiv");
	IframeTreeObject = window.parent.document.getElementById ("ObjectTree_frame");
	//debugger;
	findPos(document.getElementById('ExpTreeDiv'));//IframeTreeObject);	
	divbubbleObj.innerHTML	= bubbleText;
	divbubbleObj.style.left =(parseInt(divXPos)+ e.clientX-25)	+ 'px';
	divbubbleObj.style.top  =  (parseInt(divYPos)+ e.clientY-27)  + 'px';	
}

function mousemovehandlerOnFrame(e)
{	
    if( !e ) e= editorFrame.contentWindow.event;	
    editorFrame = window.parent.document.getElementById(controlName + "_ctl01_RadEditor1_contentIframe");
	divbubbleObj=parent.document.getElementById("bubbleDiv");
	findPos(editorFrame);	
	if(browserCode=="1")
	{
		divbubbleObj.style.left =  (parseInt(divXPos)+ e.clientX)	+ 'px';
		divbubbleObj.style.top  =  (parseInt(divYPos)+ e.clientY)  + 'px';	
	}
	else
	{
		
		divbubbleObj.style.left =   (parseInt(divXPos)+ e.clientX)	+ 'px';
		divbubbleObj.style.top  =   (parseInt(divYPos)+ e.clientY)  + 'px';
	}
}

function documentMouseUp(e)
{
	if( !e ) e=event;
	editorFrame = window.parent.document.getElementById(controlName + "_ctl01_RadEditor1_contentIframe");
	divbubbleObj=parent.document.getElementById("bubbleDiv");
	document.body.style.cursor="default";
	editorFrame.contentWindow.document.body.style.cursor = "default";
	divbubbleObj.innerHTML="";
	divbubbleObj.style.display="none";
}

function mmh(e)
{
    
		if( !e ) e=editorFrame.contentWindow.event;
		divbubbleObj=parent.document.getElementById("bubbleDiv");
		editorFrame = window.parent.document.getElementById(controlName + "_ctl01_RadEditor1_contentIframe");
		editorTarget = (document.all) ? e.srcElement : e.target;
		if(editorTarget!=null)
		{   
		    var mainArrayLength=parent.addedNodestoMainContentArrary.length;
			
			if(trim(nodeValue)!="")
			{
			    parent.addedNodestoMainContentArrary[mainArrayLength]=nodeValue;
			    nodeValue ="";
	        }
	        
	        if (editorTarget.tagName == "A")
			{
				if(newNodeValue!="")
				{
					try
				    {
				        editorTarget.innerHTML = HtmlDecode(newNodeValue);
				    }
				    catch(x)
				    {
				        editorTarget.outerHTML =HtmlDecode(newNodeValue);
				    }
					editorFrame.contentWindow.document.body.style.cursor = "default";
					document.body.style.cursor="default";
					newNodeValue="";
					divbubbleObj.innerHTML="";
					divbubbleObj.style.display="none";
				}
			}
			else
			{
				if(newNodeValue!="")
				{	
					//if(browserCode==1)
					//{

				    var newstr = HtmlDecode(trim(newNodeValue));
				    if (newstr.length > 13)
				    {
				        if (newstr.substring(0, 12) == "XmlVariables")
				        {
				            //newstr = escapeHTML(newstr);
				            newstr = newstr.replace(/[<]+/g, '&lt;');
				            newstr = newstr.replace(/[>]+/g, '&gt;');
				        }
				    }

				    parent.editor.pasteHtml(newstr);

					    //var range = window.external.menuArguments.document.getSelection();					    
                        //range.pasteHTML(trim(text));
                        //range.select();
                        //range.collapse(false);
                        
                	//}
					//else
					//{
					//    parent.editor.set_html(parent.editor.get_html() + " "+ HtmlDecode(newNodeValue));
					//}
					
				    newNodeValue="";
                    document.body.style.cursor="default";
				    editorFrame.contentWindow.document.body.style.cursor = "default";
				    divbubbleObj.innerHTML="";
				    divbubbleObj.style.display="none";
				}		
			}				
		}
}

function CallbackViewxpression(context, result, response) {
    var error = result;
    expCompResult = "";
    if (result != null) {
        expCompResult = error[0];
        compiledCode = error[1];
        var btnObj = document.getElementById("btnOk");
        btnObj.disabled = false;   
        OpenDiv(3);
    }
}

function CallbackCheckxpression(context, result, response) {
    
   var error="";   
   if((result!=null)&&(result!=""))
   {
        error=result;
   }
   else
   {
    if(response.result!=null)    {
        error=response.Window.h.responseText;
        error = error.substring(2,error.length-2);
    }
   }
   if(error!=null)
	{
	   if((error[0]!=null)&&(error[0]!=""))
	   {
		    expCompResult = error[0];
		    compiledCode = error[1];
		    var btnObj=document.getElementById("btnOk");
            btnObj.disabled=false;   
		    errLnkObj.style.visibility="visible";
		    errLnkObj.style.display="block";
		    errLnkObj.style.position="absolute";
		    OpenDiv(1);
		    //parentControl.Expression = new Expression('','','','','','','');
		}
		else
		    window.setTimeout('eval('+callBackFunction+'(curentExpression))',100);
	}
	else
	{
	  window.setTimeout('eval('+callBackFunction+'(curentExpression))',100);
	}	
}


////////////////////////////Saving Expression//////////////

function saveExpression(pdObject)
{
    CallServerSideMethod(controlName, 'SaveProperty',"DataTableSaveProperty",CallbackSaveProperty,'table',pdObject);
}

function CallbackSaveProperty(context, result, response)
{    
    try
    {
        window.opener.refreshselectedaction();   
        window.opener.parent._skProcessDesigner.RefreshProperties();
    }
    catch(err)
    {

    }
    window.setTimeout('window.close()',50);
}
/////////////////////////////////////////////////



function GetExactnodeValue(nodeVal)
{

    
    var splitNodeValue=  nodeVal.split("~~");
	var newnodeVal = splitNodeValue[0];
	dragmodetext = splitNodeValue[6]
	return newnodeVal;
}

function AssignOperator(text)
{
    editor = $find(editorCtlName);
    var tobeAssgntext="";
    if(text=='&')
    { 
       tobeAssgntext = HtmlDecode("&amp;&amp;"); 
    }
    else
        tobeAssgntext = text;
        
    editor.set_html(editor.get_html() + " "+ tobeAssgntext);
}

function DisableEditorTools()
{
    document.getElementById("ExpressionBuilderControl1_ctl01_RadEditor1Top").style.display = "none";
	
}


function Handlewindows(direction)
{
    
	divtreeviewObj =document.getElementById("ExpTreeDiv");
	divtreeviewLabelObj =document.getElementById("ExpTreeLabelDiv");
	var newEditorWidth=0;
	eFrame = window.parent.document.getElementById(controlName + "_ctl01_RadEditor1_contentIframe");
	var splitterdivObj=document.getElementById("divSplitter");
	
	if(direction=="left")
	{
	    var treeviewTD = document.getElementById("treeviewTD");
	    var treeviewLabelTD = document.getElementById("treeviewLabelTD");
	    var EditorTD= document.getElementById("EditorTD");
	    var EditorLabelTD= document.getElementById("EditorLabelTD");
		divtreeviewObj.style.display="none";
		divtreeviewLabelObj.style.display="none";
		treeviewTD.style.width ="0%"
		treeviewLabelTD.style.width="0%"
		EditorTD.style.width ="98%"	
		EditorLabelTD.style.width ="70%";	
		findPos(eFrame);		
		newEditorWidth = parseInt(document.body.offsetWidth) - parseInt(divXPos);
		
		editor.setSize(parseInt(newEditorWidth) - 10, editor.get_element().style.height);		
		AutoHide=1;
	}
	else if(direction=="right")
	{
	    if(AutoHide==1)
	    {
	    	var treeviewTD = document.getElementById("treeviewTD");
	        var treeviewLabelTD = document.getElementById("treeviewLabelTD");
	        var EditorTD= document.getElementById("EditorTD");
	        var EditorLabelTD= document.getElementById("EditorLabelTD");
		    divtreeviewObj.style.visibility="visible";
		    divtreeviewObj.style.display="block";
		    divtreeviewObj.style.position="relative";	
		    divtreeviewLabelObj.style.visibility="visible";
		    divtreeviewLabelObj.style.display="block";
		    divtreeviewLabelObj.style.position="relative";	
		    treeviewTD.style.width ="30%";
		    treeviewLabelTD.style.width="27%";
		    EditorTD.style.width ="100%";	
		    EditorLabelTD.style.width ="65%";		    
		    findPos(eFrame);
		    newEditorWidth = parseInt(document.body.offsetWidth) - parseInt(divXPos);		    
		    editor.setSize(parseInt(newEditorWidth) - 10, editor.get_element().style.height -40);
	        AutoHide=0;
	    }
		
	}
}	

function OpenWindowforNewAssm()
{
	childwindow = window.open(newAssmblyUrl,controlName,'height=275,width=500,resizable=yes,scrollbars=no,toolbars=0'); 
}


function GetBrowserversion()
{
    var app = navigator.userAgent;
    
	if(app.indexOf("MSIE")>-1 || app.indexOf("Trident")>-1)
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

function findPos(ctlObj)
{
	var element = ctlObj;
	var x1 = 0;
	var y1 = 0;//element.offsetHeight;

	//Walk up the DOM and add up all of the offset positions.
	while (element.offsetParent && element.tagName.toUpperCase() != 'BODY')
	{
		x1 += element.offsetLeft;
		y1 += element.offsetTop;
		element = element.offsetParent;
	}
	
	x1 += element.offsetLeft;
	y1 += element.offsetTop;

	divXPos=parseInt(x1) + 5;
	divYPos= parseInt(y1) + 23;
}


//********************Splitter*************************//


function Onmouseplitter()
{
    eFrame = window.parent.document.getElementById ("RadEContentIframe"+parent.editorCtlName);	
    document.body.style.cursor = "w-resize";
    
    
}

function Onmouseleaveplitter()
{
    splittercursorflag =1;  
    
    if(splitMode==0)
    {
        document.body.style.cursor = "default";
    }
}

function Onmousedownsplitter()
{
    divLineObj.style.visibility="visible";
	divLineObj.style.display="block";
	divLineObj.style.position="absolute";
	divLineObj.style.zIndex=1;
	divLineObj.style.top = eFrame.style.top;
	divLineObj.style.height=parseInt(editor.GetHeight())+"px";//+4;
	document.onmousemove=Splittermousemovehandler;
	
	eFrame = window.parent.document.getElementById(controlName + "_ctl01_RadEditor1_contentIframe");
	findPos(eFrame);
	
	
	if(browserCode=="1")
	{
	    eFrame.contentWindow.document.onmousemove=SplitmousemovehandlerOnFrame;
	    eFrame.contentWindow.document.onmouseup=SplitMouseUpOneframe;
	    
	}
	else
	{
	    editor.AttachEventHandler ("onmousemove", SplitmousemovehandlerOnFrame);
	    editor.AttachEventHandler ("onmouseup", SplitMouseUpOneframe);	    
	}
	
	ObjectListObj.contentWindow.document.onmousemove=SplitmousemovehandlerOnObjListFrame;
	//ObjectListObj.contentWindow.document.body.style.cursor = "w-resize";
	ObjectListObj.contentWindow.document.onmouseup=SplitMouseUpOneObjListframe;	 
	splitMode = 1;
	divbubbleObj.innerHTML="";
	divbubbleObj.style.display="none";
}



function Splittermousemovehandler(e)
{
	if( !e ) e=event;
	var eFrameObj = window.parent.document.getElementById(controlName + "_ctl01_RadEditor1_contentIframe");
	
	if(splitMode == 1)
        eFrame.contentWindow.document.body.style.cursor = "w-resize";	
	else
	{
	    eFrame.contentWindow.document.body.style.cursor = "default";	
	}   
	findPos(eFrameObj);
    divLineObj.style.left = parseInt(e.clientX) + 'px';	
    divLineObj.style.top = parseInt(divYPos) - 25 + 'px';	
}

function SplitmousemovehandlerOnFrame(e)
{	
	if( !e ) e= editorFrame.contentWindow.event;	
	
	editorFrame = window.parent.document.getElementById(controlName + "_ctl01_RadEditor1_contentIframe");
	
	var eclientXeditor = findPosX(editorFrame);
	var eclientYeditor = findPosY(editorFrame);
	
	
	
	if(browserCode=="1")
	{
		divLineObj.style.left =  ((parseInt(eclientXeditor)+ e.clientX)	+ 3)+ 'px';
	}
	else
	{
	 	divLineObj.style.left =   ((parseInt(eclientXeditor)+ e.clientX)	+ 3)+ 'px';
	 	divLineObj.style.top  =   "20"	+ 'px';
	}
}

function SplitMouseUpOneframe(e)
{
    var newX=0;
    if( !e ) e= editorFrame.contentWindow.event;	
   
    if(splitMode == 1)
    {
        divLineObj.style.display="none";
        eFrame.contentWindow.document.body.style.cursor = "default";
        var xposofeditorframe =  findPosX(eFrame);
        var yposofeditorframe =  findPosY(eFrame);
        var popupSplitWidth = 0;
        var eclientX=0;
        var boundaryRigtX=0
        if(browserCode==1)
        {
            popupSplitWidth = document.body.offsetWidth;             
            boundaryRigtX =  parseInt(parseInt(e.clientX)+parseInt(xposofeditorframe))/popupSplitWidth;

            if(boundaryRigtX>0.577014) 
            {
                newX  = parseInt(popupSplitWidth)*0.577014;
            }
            else
                newX = (parseInt(xposofeditorframe)+ parseInt(e.clientX));
            
            ObjectListObj.style.width= newX +'px'; 
            eFrame.style.left = parseInt(newX) +'px';
            
            editor.SetSize((parseInt(popupSplitWidth)- parseInt(eFrame.style.left)-30),editor.GetHeight());        
            
          
        }
        else
        {
            popupSplitWidth = document.documentElement.clientWidth;;             
            boundaryRigtX =  parseInt(parseInt(e.clientX)+parseInt(xposofeditorframe))/popupSplitWidth;
            
            if(boundaryRigtX>0.577014) 
            {
                newX  = parseInt(popupSplitWidth)*0.577014;
            }
            else
                newX = (parseInt(xposofeditorframe)+ parseInt(e.clientX));
            
            editor.SetSize(10,editor.GetHeight()); 
            ObjectListObj.style.width= newX +'px'; 
            eFrame.style.left = parseInt(newX) +'px';
            editor.SetSize((parseInt(popupSplitWidth)- parseInt(eFrame.style.left)-30),editor.GetHeight());
                         
        }
        
        splitMode=0;
        eFrame.contentWindow.document.body.style.cursor = "default";
        ObjectListObj.contentWindow.document.body.style.cursor = "default";
        document.body.style.cursor = "default";
    }
}

function SplitMouseUpOneObjListframe(e)
{
    if( !e ) e= ObjectListObj.contentWindow.event;	
    findPos(eFrame);      
    newx=findPosX(ObjectListObj);
    var newEditorWidth=0;
    var editorWidth =editor.GetWidth();
    var eframeLeft=eFrame.style.left;
    
    if(splitMode == 1)
    {
        if(parseInt(e.clientX)>60)
        {
           findPos(ObjectListObj);
           ObjectListObj.style.width= parseInt((parseInt(divXPos)+ parseInt(e.clientX)))+30+'px'; //"230px";//parseInt(e.clientX)+'px';
           eFrame.style.left = parseInt(e.clientX)+'px';
           newEditorWidth = parseInt(parseInt(popupWidth) - parseInt(eFrame.style.left));
           editor.SetSize(parseInt(newEditorWidth)-80,editor.GetHeight());        
        }
        divLineObj.style.display="none";
        ObjectListObj.contentWindow.document.body.style.cursor = "default";
        splitMode=0;
        eFrame.contentWindow.document.body.style.cursor = "default";
        document.body.style.cursor = "default";
    }
}

function SplitmousemovehandlerOnObjListFrame(e)
{	
	if( !e ) e= ObjectListObj.contentWindow.event;	
	findPos(ObjectListObj);
	
	
   if(splitMode == 1)
        ObjectListObj.contentWindow.document.body.style.cursor = "w-resize";	
	else
	{
	   ObjectListObj.contentWindow.document.body.style.cursor = "default";	
	}
	
	if(browserCode=="1")
	{
		divLineObj.style.left =  (parseInt(divXPos)+ e.clientX)	+ 'px';
	}
	else
	{
		divLineObj.style.left =  (parseInt(divXPos)+ e.clientX)	+ 'px';
	}
}

//**********************************************************



function InputBox(inputBoxID)
{
	this.ID = inputBoxID;
	this.Expression=new Expression('','','','','','','');
	this.pageURL="";
	this.AssociatedControlID="";
	this.LoadIframeShim="";
	this.iframeObj=null;
	this.IsExpression=false;
}

InputBox.prototype.OpenExpressionEditor = function() {
    var winHeight = 0;
    if (browserCode == 1) winHeight = 485;
    else winHeight = 491;

    window.open(this.pageURL + "&controlName=" + escape(this.ID), this.ID, 'height=' + winHeight + ',width=840,resizable=yes,scrollbars=no,toolbars=0');
};

InputBox.prototype.ToggleDiv=function() 
{
    var ctlId = this.AssociatedControlID;
	if(ctlId!=null)
	{
	    var ctlObj= document.getElementById(ctlId);
	   	
	    var divControlObj = document.getElementById("Div"+this.AssociatedControlID);
	    divControlObj.style.visibility="visible";
	    divControlObj.style.display="block"; 
	    divControlObj.style.position="absolute";
	    var dispExpression =this.Expression.DisplayExpressionString;//dispExpression
    	
    	if( (trim(dispExpression).substring(trim(dispExpression).length-1,trim(dispExpression).length)=="\"")&&(trim(dispExpression).substring(0,1)=="\""))
    	{
    	    dispExpression = trim(dispExpression).substring(1,trim(dispExpression).length-1);
    	}

            	
    	if(dispExpression.length>40)
    	{
    	    var length=dispExpression.length;
    	    dispExpression = dispExpression.substring(0,6)+".."+dispExpression.substring(length-32,length);
       }
        
	    var tableContent = "<table width=100% cellspacing=0 callpadding=0 border=0 height='"+ctlObj.offsetHeight+"'><tr><td align=left style='class:propertiesboxpropertyExpText' alt='what' bgcolor='FFFFFF' vailgn='top'><span class='propertiesboxpropertyExpText'>"+dispExpression+"</span></td><td align='right' bgcolor='white'><a href='#' style='cursor:Hand' onclick=\"javscript:IPBDEAttachEXPControl('"+this.ID+"')\"><img border=0 id='inp1' alt='"+expClearExp+"' src="+inputCancelImage+"></img></a></td></tr></table>"
        //divControlObj.innerHTML	="<table background='"+inputExpbkGroundImage+"' border=0 width='"+(parseInt(ctlObj.style.width)+5)+"' height='"+(parseInt(ctlObj.style.height)+5)+"'><tr><td  width='"+ctlObj.style.width+"' height='"+ctlObj.style.height+"' align=center class='contentText' > <b>Expression</b> </td></tr></table>";	//HtmlDecode("&lt;Table&gt;&lt;tr&gt;&lt;td class='TableContainer'&gt;Wdhat&lt;/td&gt;&lt;/tr&gt;&lt;/Table&gt;");
        
        divControlObj.innerHTML	=tableContent;
        
        var x=findPosX(ctlObj);
        var y=findPosY(ctlObj);
        
        //alert(divControlObj.innerHTML);
        //alert(parseInt(divYPos));
        //divControlObj.parent = ctlObj;
        //ctlObj.appendChild(document.body.removeChild(divControlObj));
        if(browserCode==1)
        {
            divControlObj.style.left= x - 2;
	        divControlObj.style.top = y;
	        divControlObj.style.width = ctlObj.offsetWidth;
	        divControlObj.style.height = ctlObj.offsetHeight ;
	    }
	    else
	    {
	        divControlObj.style.left= x - 2;
	        divControlObj.style.top = y - 2;
	        divControlObj.style.width =   ctlObj.offsetWidth-2;
	        divControlObj.style.height =  ctlObj.offsetHeight;
	    }
	    
	    
    	
    	
	    if(this.LoadIframeShim=="True")
	    {
		    var iframeObj=document.getElementById("Iframe"+this.AssociatedControlID);
		    divControlObj.style.display = "block";
		    iframeObj.style.width = divControlObj.offsetWidth;  
		    iframeObj.style.height = divControlObj.offsetHeight;
		    iframeObj.style.top = divControlObj.style.top;
		    iframeObj.style.left = divControlObj.style.left;
		    iframeObj.style.zIndex = divControlObj.style.zIndex - 1;
		    iframeObj.style.display = "block";      
	    }
	}
	
}

function ResetExpressionMode(hiddenControlName)
{
    var hiddenExpObj = document.getElementById(hiddenControlName);
    hiddenExpObj.value="";
}




function ReAlignIPBox()
{  
    for (i = 0; i < document.forms.length; i++) 
	{  
		for (j = 0; j < document.forms[i].elements.length; j++) 
		{ 
	        var formField=document.forms[i].elements[j];   
		    var formFieldType=formField.type.toLowerCase();
		       
	        if(formFieldType=="hidden")
	          {
	            if(formField.value!="")
                {
                        var fieldName = formField.name;
                        
                        if(fieldName.indexOf("HIDDENIPBOXEXPVAL")!=-1)
                        {
                              var ipctlName=fieldName.substring(17,fieldName.length);   
                             var _ipBox = GetExpressionEditor(ipctlName);
                             
                             if(formField.value!="")
                             {
                                var _expObject = objectify(formField.value);
                                _ipBox.Expression = _expObject;
                             }
                              _ipBox.ToggleDiv();
                        }
                  }
              }
		}  
	}

}


function CallLoadExpBuilder(hiddenObjectID,ipbControlID)
{
  /* var hiddenObjectIDObj=document.getElementById(hiddenObjectID);
   var hiddenObjectIDObjvalue =  hiddenObjectIDObj.value;
   
   if(trim(hiddenObjectIDObjvalue)!="")
   {
        var ipBoxObject = GetExpressionEditor(ipbControlID);
        expObject = objectify(hiddenObjectIDObjvalue);
        ipBoxObject.Expression = expObject;
        ipBoxObject.ToggleDiv();
        
   }*/            
}

function GetInputBox(inputBoxClientID)
{
	var ipbox = null;
	ipbox = eval(inputBoxClientID);
	return ipbox;
};


function IPBAttachEXPControl(inputBoxClientID)
{
    //alert('Hi');
    //debugger;
	var ipbox = null;
	ipbox = eval(inputBoxClientID);
	ipbox.IsExpression=true;
	if (ipbox == null)
	return;
	ipbox.OpenExpressionEditor();
};

function IPBDEAttachEXPControl(inputBoxClientID)
{
    var ipbox = null;
	ipbox = eval(inputBoxClientID);
	ipbox.IsExpression=false;
	if (ipbox == null)
	return;
	ipbox.DeattachExpressionEditor();
};

InputBox.prototype.DeattachExpressionEditor=function() 
{
   	
   	var divControlObj = document.getElementById("Div"+this.AssociatedControlID);
	divControlObj.style.display="none";
	
	if(this.LoadIframeShim=="True")
	{
		var iframeObj=document.getElementById("Iframe"+this.AssociatedControlID);
		iframeObj.style.display = "none";
	}
	window.top.CallServerSideMethod(null, 'Test',1,CallbackDTTest,'param1',1,'param2','2,1','param3',3);
}

function CallbackDTTest(context, result, response)
{
}

function IPBAssignEXP(inputBoxClientID)
{
	var ipbox = null;
	ipbox = eval(inputBoxClientID);
	if (ipbox == null)
	return;
	ipbox.ToggleDiv();
};

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

function IntitlizeInpputBox(element)
{
	CallServerSideMethod(element, 'OnLoad',1,CallbackDTTest,'param1',1,'param2','2,1','param3',3);
}

function SendObjectToServer(element,ExpObj)
{	
	
	CallServerSideMethod(element, 'BuildExpression',"DataTableTest",CallbackDTTest,'table',ExpObj);
	
}
function CallbackDTTest(context, result, response)
{
	if(result!=null)
	{
		_actualExprtessionString=result[0];
		_displayExpressionString=result[1];
		_htmlVerexpString=result[2];
		_methodparameterList=result[5];
	}
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


function CloseDiv()
{
	var divObj=document.getElementById("ErrorDiv");	
	divObj.style.display="none";
}


function GetErrorlist() {
    var tableStr = "<table width=500 height=250 border=0 cellspacing=0 cellpadding=0  bgcolor=\"#ffffff\"><tr  class=\"header\" ><td width=\"4%\" align=\"left\" bgcolor=\"#ffffff\"><img src=" + errorIcon + " width=\"21\" height=\"20\" /></td><td width=\"50%\"  bgcolor=\"#ffffff\" class=\"note\" align=\"left\">" + expErrinExpression + ":</td><td width=\"30%\" valign=middle align=\"right\"  bgcolor=\"#ffffff\" class=\"note\"><a href=\"#\" onclick=\"javascript:OpenDiv(3)\" class='a'><img src=" + compileCodeImage + " border=0 align='absmiddle'/>&nbsp;<span class='a'>" + expCompiledCode + "</span></a></td><td width=\"10%\" align=\"right\"  bgcolor=\"#ffffff\"><a href=\"#\" onclick=\"javascript:CloseDiv()\"><img src=" + closeImg + " width=\"17\" height=\"17\" border=0/></a></td></tr>";
    tableStr = tableStr +"<tr><td colspan=\"4\" align=left valign='top'>";
    tableStr = tableStr + "<div id=\"ErrorInnerDiv\" style=\"Overflow: auto;\ width:500px; height:220px;\">";
    tableStr = tableStr + "<table><tr><td class='description'>";
    tableStr = tableStr + expCompResult.replace(/SelectStyle/g, "description");    
    tableStr = tableStr + "</td></tr></table>";
	tableStr = tableStr + "</div>";
	tableStr = tableStr +"</td></tr>";
	tableStr = tableStr +"</table>";
	return tableStr;
}

function GetCompiledCode()
{
    var tableStr="<table width=500 height=250 border=0 bgcolor=\"ffffff\" cellspacing=0 cellpadding=0 ><tr class=\"header\"><td width=\"4%\" align=\"left\"><img src="+errorIcon+" width=\"21\" height=\"20\" /></td><td width=\"50%\" class=\"note\" align=\"left\">"+expErrinExpression+":</td><td width=\"30%\" valign=middle align=\"right\"><a href=\"#\" onclick=\"javascript:OpenDiv(1)\" class='a'><img src="+errorGif+" border=0 align='absmiddle'/>&nbsp;<span class='note'>"+expErrorstext+"</span></a></td><td width=\"10%\" align=\"right\"><a href=\"#\" onclick=\"javascript:CloseDiv()\"><img src="+closeImg+" width=\"17\" height=\"17\" border=0/></a></td></tr>";
	tableStr = tableStr +"<tr><td colspan=\"4\" align=left valign='top'>";
	tableStr = tableStr + "<div id=\"ErrorInnerDiv\" style=\"Overflow: auto;\ width:500px; height:220px;\">";
	tableStr = tableStr + "<table><tr><td class='description'>";
	tableStr = tableStr + HtmlDecode(compiledCode);
	tableStr = tableStr + "</td></tr></table>";
	tableStr = tableStr + "</div>";
	tableStr = tableStr +"</td></tr>";
	tableStr = tableStr +"</table>";
	return tableStr;
}

function GetCompiledCodeForView() {
    var tableStr = "<table width=500 height=250 border=0 bgcolor=\"ffffff\" cellspacing=0 cellpadding=0 ><tr class=\"header\"><td width=\"4%\" align=\"left\"><img src=" + errorIcon + " width=\"21\" height=\"20\" /></td><td width=\"50%\" class=\"note\" align=\"left\">" + expCodeInExpression + ":</td><td width=\"30%\" valign=middle align=\"right\"><a href=\"#\" onclick=\"javascript:OpenDiv(1)\" class='a'><img src=" + errorGif + " border=0 align='absmiddle'/>&nbsp;<span class='note'>" + expErrorstext + "</span></a></td><td width=\"10%\" align=\"right\"><a href=\"#\" onclick=\"javascript:CloseDiv()\"><img src=" + closeImg + " width=\"17\" height=\"17\" border=0/></a></td></tr>";
    tableStr = tableStr + "<tr><td colspan=\"4\" align=left valign='top'>";
    tableStr = tableStr + "<div id=\"ErrorInnerDiv\" style=\"Overflow: auto;\ width:500px; height:220px;\">";
    tableStr = tableStr + "<table><tr><td class='description'>";
    tableStr = tableStr + HtmlDecode(compiledCode);
    tableStr = tableStr + "</td></tr></table>";
    tableStr = tableStr + "</div>";
    tableStr = tableStr + "</td></tr>";
    tableStr = tableStr + "</table>";
    return tableStr;
}

function OpenDiv(mode)
{
		var tableStr="";
		
		if(mode==1)
		    tableStr = GetErrorlist();
		else if(mode==2)
		    tableStr = GetCompiledCode();
		else
		    tableStr = GetCompiledCodeForView();
		
		var divObj=document.getElementById("ErrorDiv");	
		var errLinkObj=document.getElementById("errorLink");
		findPos(errLinkObj);
		if (parseInt(divYPos) < 300) {
		    divYPos = 489;
		}		
		divObj.style.left = (parseInt(divXPos)) + 'px';
		divObj.style.top = (parseInt(divYPos)- 300) + 'px';
		divObj.style.position="absolute";
		divObj.style.visibility="visible";
		divObj.style.display = "block";		
		divObj.innerHTML=tableStr;
		divObj.style.width=500;
		divObj.style.height=250;
		
}

function OpenInnerDiv()
{
    var divSCIObj = document.getElementById("SourceCodeInnerDiv");
    divSCIObj.style.visibility="visible"
	divSCIObj.style.display="block"

}

function OnSubmitNewAssembly()
{
   	    
   	var DllInputObj=document.getElementById("hidpath");
   	var DirInputObj=document.getElementById("hiddirPath");
   	var selectedValue="";
   	var errorCode ="";
   	if(DirInputObj.value!="")
   	    selectedValue=DllInputObj.value+componentName;
   	else
   	    selectedValue= DirInputObj.value;
   	
   	
	if(trim(selectedValue)=="")
	{
		alert("Please Enter an Assembly file.");
	}
	else
	{
		var enteredAssembly=trim(selectedValue);
		posOfDot=enteredAssembly.lastIndexOf('.');
		var filetype=enteredAssembly.substring(posOfDot+1,enteredAssembly.length);
		
		if(trim(filetype.toLowerCase())!="dll")
		{
			alert("Invalid Assembly file.");	
		}
		else
		{
			if(window.opener.childwindow!=null)
			{
				window.opener.SaveAssembly(enteredAssembly);			
			}
			else
			{
				alert("This window has lost the reference to the Parent window,Please create new instance for this window.");
				window.close();		
			}
		}
	}
}

function SaveAssembly(ObjectTobeSent)
{
   // alert(controlName);
    CallServerSideMethod(controlName, 'SaveAssembly',"DataTableTest",CallbackSaveAssembly,'table',ObjectTobeSent);
}

function CallbackSaveAssembly(context, result, response)
{
    var resMsg=response.Window.h.responseText;
    errMsg = resMsg.substring(2,resMsg.length-2);
     
    if((errMsg!=null)&& (errMsg!=""))
	{
	    splitArr = errMsg.split(",");
	  
		if(splitArr[0].indexOf("Error")>-1)
		{	
			errorCode=splitArr[1];
			childwindow.AssignErrorCode(errorCode);
		}
		else
		{
			childwindow.RefreshParent();
		}
	}
	else
	{
		childwindow.RefreshParent();
	}
}


function AssignErrorCode(errCode)
{
	var errorMsg="";
	
	if(errCode!="")
	{
		if(errCode=='AssmFileNotFound')
			errorMsg = "File or assembly name was not found";
		else if(errCode=='EXPAssmFormat')
			errorMsg = "The format of the file is invalid,Please provide a valid Dotnet Assembly file.";	
		else
		    errorMsg = errCode;	
		
		if(errorMsg!="")
		{
		    //alert(errorMsg);
		    ShowMessagesWithBellyBar(2, errorMsg);
			errorMsg="";
		}
	}
}

function RefreshParent()
{
	window.opener.ObjectTree_frame.location.reload();
	//window.opener.referenceList=window.opener.referenceList +","+fileObj.value;
	window.close();
}


function PDControlObject()
{
	this.ApplicationName="";
	this.WorkflowName="";
	this.FileName="";
	this.Path="";
	this.KeyValue="";
}

function OnSubmitExtendedUI()
{
    var enteredValue= document.getElementById("RadComboBox1_Input").value;
    var newpdObj = new PDControlObject();
   	newpdObj.ApplicationName=document.getElementById("ApplicationName").value;
	newpdObj.WorkflowName=document.getElementById("WorkflowName").value;
	newpdObj.FileName=document.getElementById("FileName").value;
	newpdObj.KeyValue=document.getElementById("KeyValue").value;
	newpdObj.Path=enteredValue;
	window.opener.SaveExtendeddUIInfo(newpdObj);		
}

function SaveExtendeddUIInfo(tobeSavedInfo)
{
    CallServerSideMethod(controlName, 'SaveExtendeddUIInfo',"DataTableTest",CallbackSaveExtendeddUIInfo,'table',tobeSavedInfo);
}

function CallbackSaveExtendeddUIInfo(context, result, response)
{
    extUIwindow.RefreshParent();
}    

function openExtendedUI(nodeID,nodevalue)
{
    var splitVal=nodeID.split('#');
    var nodeKey=splitVal[0];
    var nodeKeyValue=splitVal[1];
    var nodeKeyFieldObject=document.getElementById("extNodeKey");
    var nodeValueFieldObject=document.getElementById("extNodeValue");
    nodeKeyFieldObject.value = nodeKey;
    nodeValueFieldObject.value=nodeKeyValue;
    var actualURL = extUIurl.replace("ExtendedUI.aspx",nodevalue);
    extUIwindow = window.open(actualURL+"&keyvalue="+nodeKey,"UI"+controlName,'height=147,width=500,resizable=yes,scrollbars=no,toolbars=0'); 
}

function resizePage()
{
    
   //if(browserCode=="1")
	//{
        popupWidth = document.body.offsetWidth;
        popupHeight = document.body.offsetHeight;

        if (navigator.userAgent.indexOf("Firefox") > -1)
        {
            popupHeight = document.body.clientHeight;
        }
	    	    
        editorwidth = editor.get_element().style.width;
 	    editorHeight = editor.get_element().style.height;
	    
	    if(popupHeight<50)
	       return false;
	    else
	    {    
	        if(editorwidth!=0)
	        {
	            editorwidth = parseInt(popupWidth) * 0.64;	            
	            editorHeight = parseInt(popupHeight) - 100;	            
	            objectListFrameWidth = parseInt(popupWidth) * 0.3;
	            
	            document.getElementById("RadTreeDiv").style.height=(parseInt(popupHeight))- 100;
                document.getElementById("RadTreeDiv").style.width=objectListFrameWidth;//ObjectListObj
                editor.setSize(editorwidth,editorHeight);
            }
        }
   // }
   // else if(browserCode=="2")
   // {
   //     popupWidth = document.body.clientWidth;
   //     popupHeight = document.documentElement.clientHeight; 
   //     editorwidth = editor.get_element().style.width;
   //     editorHeight = editor.get_element().style.height;
	    
   //     editor.setSize(parseInt(popupWidth * 0.6247),parseInt(popupHeight * 0.919));	    
	    
   //     document.getElementById("RadTreeDiv").style.height=parseInt(popupHeight * 0.919) + "px";
   //     document.getElementById("RadTreeDiv").style.width=parseInt(popupWidth * 0.35) + "px";
   //     top.frames[0].resizeTreeFromOut(parseInt(popupHeight * 0.919),parseInt(popupWidth) * 0.35);
   // }
    
   //else
   //{
   //   if(document.documentElement.clientHeight<250)
   //           return false;
        
   //   //var  divSplitterObj=document.getElementById("divSplitter");
   //   //divSplitterObj.style.height=10;    
   //   document.getElementById("RadTreeDiv").style.height=5;
   //   document.getElementById("RadTreeDiv").style.width=5;
   //   editor.setSize(10,10);
            
   //   var popupFFHeight = document.documentElement.clientHeight; 
   //   var popupFFWidth = document.documentElement.clientWidth;
      
   //   editorwidth  = parseInt(popupFFWidth)* 0.6247;
   //   editorHeight = parseInt(popupFFHeight)* 0.95;
      
   //   if((parseInt(popupFFHeight)-parseInt(editorHeight))>3)
   //         editorHeight = parseInt(popupFFHeight)- 52;
      
   //   objectListFrameWidth  = parseInt(popupFFWidth) * 0.35;
      
   //   //ObjectListObj.style.height=parseInt(popupFFHeight)* 0.91;
   //   //ObjectListObj.style.width=objectListFrameWidth;
      
   //   document.getElementById("RadTreeDiv").style.height=editorHeight;
   //   document.getElementById("RadTreeDiv").style.width=objectListFrameWidth;
      
   //   editor.setSize(editorwidth,editorHeight);
      
   //}
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

function HtmlDecode(s) 
	{ 
      var out = ""; 
      if (s==null) return; 
      var l = s.length; 
      for (var i=0; i<l; i++) 
      { 
            var ch = s.charAt(i); 
            if (ch == '&') 
            { 
                  var semicolonIndex = s.indexOf(';', i+1); 
            if (semicolonIndex > 0) 
            { 
                        var entity = s.substring(i + 1, semicolonIndex); 
                        if (entity.length > 1 && entity.charAt(0) == '#') 
                        { 
                              if (entity.charAt(1) == 'x' || entity.charAt(1) == 'X') 
                                    ch = String.fromCharCode(eval('0'+entity.substring(1))); 
                              else 
                                    ch = String.fromCharCode(eval(entity.substring(1))); 
                        } 
                    else 
                      { 
                              switch (entity) 
                              { 
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

                                    case 'Icirc': ch = String.fromCharCode(0x00ce ); break; 

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
      return out;//.replace("<","&lt;");//escapeHTML(out); // this is placing anchor tag in editor for methods
} 
function escapeHTML(str) { var div = document.createElement('div'); var text = document.createTextNode(str); div.appendChild(text); return div.innerHTML; }
function SetFocusOnEditor()
{
    editor = $find(editorCtlName);
    setTimeout(function () { editor.setFocus(); }, 10);
}