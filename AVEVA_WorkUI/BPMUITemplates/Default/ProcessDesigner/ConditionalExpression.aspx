<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ConditionalExpression.aspx.cs" Inherits="SkeltaTemplates_Default_ProcessDesigner_ConditionalExpression" Theme="" StylesheetTheme="" %>

<%@ Register Assembly="Workflow.NET.Web.Designer.NET2" Namespace="Workflow.NET.Web.Designer" TagPrefix="cc1" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE HTML>
<html>
<head id="Head1" runat="server">
    <title><%: ProcessDesignerControl.GlobalResourceSet.GetString("ConditionDesigner")%></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <script>

        var originalUnescape = new Object();
        originalUnescape = window.unescape;
        window.unescape = overridenUnescape;
        function overridenUnescape(loadOnDemandUrl)
        {
            // window.unescape = originalUnescape; 
            var extraLoadOnDemandParams = loadOnDemandUrl.replace(document.location.pathname + document.location.search, '');
            var retObj = (document.location.pathname + document.location.search) + originalUnescape(extraLoadOnDemandParams);
            return retObj;
        }
    </script>
</head>
<style>
    html, body {
        height: 100%;
        overflow: hidden;
    }
</style>
<body onload="Initialize();" style="margin-left: 10px; margin-right: 10px">
    <form id="form1" runat="server">
         <%=System.Web.Helpers.AntiForgery.GetHtml()%>
         <telerik:RadScriptManager ID="radSc1" runat="server"></telerik:RadScriptManager>
        <div>
            <cc1:ConditionalDesigner ID="ConditionalDesigner1" runat="server" />
        </div>
    </form>
</body>
</html>

<script>
    var src = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(this.Context.Request["src"], false)%>";
    var rowID = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(this.Context.Request["Rowid"], false)%>";
    var conditionRows = new Array();


    function Initialize()
    {
        var browserversion = GetBrowserversion();
        if (browserversion != 1)
        {
            document.getElementById("divMain").style.height = 470;
        }
    }

    function EncodeTheExpressionString(expressionString)
    {
        //There is a problem in getting the Actual Text and the Display Text from the decision activity.
        //This should be handlled in the decision code itself. 
        expressionString = expressionString.replace(/SOAObjects./g, "");
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
        return expressionString;
    }


    function DecodeTheExpressionString(expressionString)
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

    LoadConditions();
    function LoadConditions()
    {
        var constring = "";
        if (src == 'Decision')
        {
            constring = window.opener["Decision" + rowID].ConditionString;
            conditionRows = objectify(constring);
            if (conditionRows != null)
            {
                var totalConditionCount = conditionRows.length;
                if (conditionRows.length > 0)
                {
                    for (var i = 0; i < conditionRows.length; i++)
                    {

                        var elementNo = parseInt(i + 1);
                        var conditionalRow = conditionRows[i];

                        var LHSText = "";

                        var divExpLayerObj = document.getElementById("divExpressionLayer" + elementNo);

                        if (divExpLayerObj == null)
                        {
                            var nextRowHTML = AddRow(parseInt(elementNo - 1));
                            if (nextRowHTML != "")
                                document.getElementById("divExpressionLayers").innerHTML = document.getElementById("divExpressionLayers").innerHTML + nextRowHTML;
                        }

                        var currentLHSDivElement = document.getElementById("LHS" + elementNo);

                        window["Row" + elementNo] = new ConditionRow('On');

                        window["Row" + elementNo] = conditionalRow;

                        if (window["Row" + elementNo].LHSMode == "Expression")
                        {
                            LHSText = DecodeTheExpressionString(window["Row" + elementNo].LHSColumn.ColumnExpression.DisplayExpressionString);
                        }
                        else
                        {
                            LHSText = window["Row" + elementNo].LHSColumn.DisplayText;
                        }

                        var displayText = "";

                        if (LHSText.length > 27)
                        {
                            if (LHSText.substring(0, 8) == "Variable")
                            {
                                var length = LHSText.length;
                                displayText = LHSText.substring(0, 3) + ".." + LHSText.substring(length - 23, length);

                            }
                            else if (LHSText.substring(0, 11) == "XmlVariable")
                            {
                                var length = LHSText.length;
                                displayText = LHSText.substring(0, 6) + ".." + LHSText.substring(length - 17, length);

                            }

                            else
                            {
                                var length = LHSText.length;
                                displayText = LHSText.substring(0, 6) + ".." + LHSText.substring(length - 17, length);
                            }
                        }
                        else
                            displayText = LHSText;


                        LHSText = "<A class=\"hyperText\" id=\"link" + elementNo + "\"   onmouseover=\"Javascript:alterLink(this," + elementNo + "," + elementNo + ",event,'LHS')\" onclick=\"Javascript:alterLink(this," + elementNo + "," + elementNo + ",event,'LHS')\" href=\"#\">" + displayText + "</A>";
                        currentLHSDivElement.innerHTML = "&nbsp;" + LHSText + "&nbsp;";

                        if (trim(window["Row" + elementNo].LogicalOpr) != "")
                        {
                            var oprTxt = "<A class=\"hyperText\" id=\"link" + elementNo + "\"    onmouseover=\"Javascript:alterLink(this," + elementNo + "," + elementNo + ",event,'OPR')\" onclick=\"Javascript:alterLink(this," + elementNo + "," + elementNo + ",event,'OPR')\" href=\"#\">" + window["Row" + elementNo].LogicalOpr + "</A>";
                            document.getElementById("divlnkOPR" + elementNo).innerHTML = "&nbsp;" + oprTxt + "&nbsp;";
                        }

                        document.getElementById("divBrac" + elementNo).innerHTML = window["Row" + elementNo].LHSBrace;
                        document.getElementById("divRBrac" + elementNo).innerHTML = window["Row" + elementNo].RHSBrace;

                        var currentMHSDivElement = document.getElementById("MHS" + elementNo);
                        var mhsText = window["Row" + elementNo].MHSDisplayText;

                        displayText = "";
                        if (mhsText.length > 20)
                            displayText = mhsText.substring(0, 20) + "..";
                        else
                            displayText = mhsText;


                        currentMHSDivElement.innerHTML = "<A class=\"hyperText\" id=\"link" + elementNo + "\"    onmouseover=\"Javascript:alterLink(this," + elementNo + "," + elementNo + ",event,'MHS')\" onclick=\"Javascript:alterLink(this," + elementNo + "," + elementNo + ",event,'MHS')\" href=\"#\">" + displayText + "</A>";

                        var currentRHSDivElement = document.getElementById("RHS" + elementNo);
                        var rhsText = "";


                        if (window["Row" + elementNo].RHSMode == "default")
                        {
                            rhsText = window["Row" + elementNo].RHSValue;
                        }
                        else if (window["Row" + elementNo].RHSMode == "Expression")
                        {
                            rhsText = DecodeTheExpressionString(window["Row" + elementNo].RHSColumn.ColumnExpression.DisplayExpressionString);
                        }
                        else
                        {
                            rhsText = window["Row" + elementNo].RHSColumn.DisplayText;
                        }

                        displayText = "";
                        if (rhsText.length > 27)
                        {
                            if (rhsText.substring(0, 8) == "Variable")
                            {
                                var length = rhsText.length;
                                displayText = rhsText.substring(0, 3) + ".." + rhsText.substring(length - 23, length);

                            }
                            else if (LHSText.substring(0, 11) == "XmlVariable")
                            {
                                var length = rhsText.length;
                                displayText = rhsText.substring(0, 6) + ".." + rhsText.substring(length - 17, length);

                            }

                            else
                            {
                                var length = rhsText.length;
                                displayText = rhsText.substring(0, 6) + ".." + rhsText.substring(length - 17, length);
                            }
                        }
                        else
                            displayText = rhsText;

                        currentRHSDivElement.innerHTML = HtmlDecode("&lt;a href=&quot;#&quot; id=&quot;rhsLink" + elementNo + "&quot; class=&quot;hyperText&quot; OnMouseOver=&quot;javascript:alterLink(this," + elementNo + "," + elementNo + ",event,'RHS')&quot; Onclick=&quot;javascript:alterLink(this," + elementNo + "," + elementNo + ",event,'RHS')&quot;id=&quot;val1&quot; name=&quot;rhsLink" + elementNo + "&quot;&gt;" + displayText + "&lt;a&gt");

                        var menudivObj = document.getElementById("divlnkmenu" + elementNo);
                        menudivObj.innerHTML = "<a href=\"#\" id=\"lnkMenu\"+currentRow ><img src='" + menuImgSrc + "' id=\"imageMenu" + elementNo + "\" border=0 onclick=\"javascript:OpenMenu(this," + elementNo + ")\"></a>";

                        document.getElementById("DivDelImage" + elementNo).innerHTML = "<a href=\"#\"><img id=\"ObjImage" + elementNo + "\" src='" + objectTreeImg + "' alt='Object Tree' border=0 onclick=\"javascript:DisplayObjectTree(" + elementNo + ")\"></a>&nbsp;&nbsp;<a href=\"#\"><img id=\"DelImage" + elementNo + "\" alt='Delte' src='" + delteRowImg + "' border=0 onclick=\"javascript:DeleteRow(" + elementNo + ")\"></a>";
                        var tableObject = document.getElementById("TableExpression" + elementNo);
                        tableObject.className = "tab";

                        if (totalConditionCount == elementNo)
                        {
                            var nextRowHTML = AddRow(elementNo);
                            if (nextRowHTML != "")
                                document.getElementById("divExpressionLayers").innerHTML = document.getElementById("divExpressionLayers").innerHTML + nextRowHTML;
                        }

                        if (!IsAddedToArray(elementNo))
                        {
                            var inArrLen = InitialconditionalArray.length;
                            InitialconditionalArray[inArrLen] = elementNo + "~" + "S";
                        }
                    }
                }
            }
        }
    }
</script>
