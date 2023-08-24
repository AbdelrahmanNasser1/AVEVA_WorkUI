<%@ Page Language="C#" Trace="false" AutoEventWireup="true" Debug="true" Inherits="Workflow.NET.CodeBehind.PropertyTypes.SsrsMultiValueParam" %>
<%@ Register Assembly="Skelta.Forms.Web" Namespace="Skelta.Forms.Web" TagPrefix="cc1" %>


<html>
<head id="Head1" runat="server">
   <title>
        <%= sr.GetString("SSRS_multiValue_configuration")%>
    </title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link href="<%=ProcessDesignerControl.GetCommonRelativeUrl("Stylesheet/global.css")%>"
        rel="stylesheet" type="text/css" />
    <link href="Stylesheet/global.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
    
        .html, body {
        overflow-x: hidden;
        }
        .tablebg
        {
            height: 225px;
        }
    </style>
    <link href="<%=ThemePath%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
</head>
<body>
    <script>
        se.ui.messageDialog.setGlobalOptions({
            localization: { // All localization related default can be set
                closeButtonCaption: "<%=sr.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                okButtonCaption: "<%=sr.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                cancelButtonCaption: "<%=sr.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                showDetailsCaption: "<%=sr.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                hideDetailsCaption: "<%=sr.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
            }
        });
    </script>
   <form id="form1" runat="server">   
       <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
        <table border="0" cellpadding="5" cellspacing="1" width="100%">
            <tr>
                <td valign="top">
                    <table border="0" cellpadding="0" cellspacing="1" width="100%">
                        <tr valign="top">
                            <td class="header" valign="middle">
                                <span class="pagetitle">
                                    <%= sr.GetString("SSRS_multiValue_configuration_heading")%>
                                </span>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <table border="0" cellpadding="6" cellspacing="1" width="100%">
                        <tr valign="top">
                            <td class="description" valign="middle" colspan="2">
                                <%= sr.GetString("SSRS_multiValue_configuration_desc")%><br />
                                 <asp:Label ID="labelDateHelp" CssClass="note" width="600px" runat="server" Text="Variable name:" Visible="false" ></asp:Label> 
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <table align="center" border="0" cellpadding="4" cellspacing="2" class="tablebg" width="100%">
                      
                        <tr> 
                         <td class="lefttdbg"  width="40%" >
                           <span class="subtitle"> <%:paramDetail %></span><br />                              
                            </td>                          
                            <td class="righttdbg">
                                <div id="OuterDiv" style="height:150px;overflow:auto">
                                    <div id="VariableCollection0">
                                           <input type="text" id="txtParam0" Text=""  style="width:250;"  onkeypress="return onlyNumbers(event);"/>&nbsp;
                                           <img src="<%=ProcessDesignerControl.GetCommonRelativeUrl("Images/Expression-icon.gif")%>" id="expressionImage" onclick="openEditor('txtParam0','hiddenFullValue0','hiddenMode0','ClearAllImg0','DeleteRow0');" alt="<%=sr.GetString("processdesigner_activity_attachment_img_eb") %>"  title="<%=sr.GetString("processdesigner_activity_attachment_img_eb") %>" onmouseover="this.style.cursor='hand';this.style.cursor='pointer'" />&nbsp;
                                           <img src="<%=ProcessDesignerControl.GetCommonRelativeUrl("Images/new-input-icon.gif")%>" id="ClearAllImg0" alt="<%=sr.GetString("processdesigner_activity_attachment_img_deldata") %>" title="<%=sr.GetString("processdesigner_activity_attachment_img_deldata") %>" style="visibility:hidden" onclick="clearExpression('txtParam0','hiddenFullValue0','hiddenMode0','ClearAllImg0','DeleteRow0');" onmouseover="this.style.cursor='hand';this.style.cursor='pointer'" />
                                           <img src="<%=ProcessDesignerControl.GetCommonRelativeUrl("Images/icon-delete-row.png")%>" id="DeleteRow0" alt="<%=sr.GetString("processdesigner_activity_attachment_img_delrow") %>" title=="<%=sr.GetString("processdesigner_activity_attachment_img_delrow") %>" style="visibility:hidden" onclick="DeleteSpecificRow('VariableCollection0');"/>
                                           <input id="hiddenFullValue0" type="hidden" runat="server" name="hiddenFullValue" />
                                           <input id="hiddenMode0" type="hidden" runat="server" name="hiddenMode" />
                                     </div>
                                 </div>
                                 <a href="#" onclick="AddTextBox();"><%=sr.GetString("processdesigner_activity_attachment_add_row")%></a>
                            </td>
                        </tr>                       
                        <tr class="footer">
                            <td colspan="2"  align="right">
                                <table width="100%" border="0" cellspacing="0" cellpadding="2">
                                    <tr>
                                        <td colspan="2" align="right">
                                            &nbsp;<asp:Button ID="Submit" runat="server" OnClientClick="return CreateString();" OnClick="Submit_Click"   CssClass="inputbutton" />    
                                            <asp:Button ID="CloseButton" runat="server"  OnClick="CloseButton_Click"   CssClass="inputbutton" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <asp:RadioButtonList id="RadioSendMailOption" runat="server" Visible="false">
        </asp:RadioButtonList>
        <input id="hidMultitxtParamId" type="hidden" name="hidRowSelectedNo" />
         <input id="hidModeId" type="hidden" name="hidRowWithActualValue" />
        <input id="hidFullValueId" type="hidden" name="hidRowSelectedNo" />
        <input id="hidParentTextId" type="hidden" name="hidParentTextId" />
        <input id="hidImageId" type="hidden" name="hidImage" />
        <input id="hidDeleteRowImageId" type="hidden" name="hidDeleteRowImageId" />
        <input id="hiddenNumberOfVariable" type="hidden" name="hiddenNumberOfVariable" value="0" />      
        <asp:HiddenField ID="HiddenStringValue" Value="" runat="server"/>
         <asp:HiddenField ID="HiddenSavedExpStringValue" Value="" runat="server"/>
          <asp:HiddenField ID="hiddenActualParameterType" Value="" runat="server"/>
          <asp:HiddenField ID="hiddenParentActualValueId" value="" runat="server"></asp:HiddenField>
          <asp:HiddenField ID="hiddenParentExpressionValueId" value="" runat="server"></asp:HiddenField>
        
    </form>
</body>
</html>
<script language="javascript" type="text/javascript">

    function GetSavedValueFromParent() {
        
        var actualValueId = window.opener.document.getElementById(document.getElementById("<%=hiddenParentActualValueId.ClientID %>").value);
        if (actualValueId != null) {
            var tempActualValue = actualValueId.value.split("#@#")
            if (tempActualValue.length == 2) {
                document.getElementById("<%=HiddenStringValue.ClientID %>").value = tempActualValue[0];
            }
        }

        var expressionValueId = window.opener.document.getElementById(document.getElementById("<%=hiddenParentExpressionValueId.ClientID %>").value);

        if (expressionValueId != null) {
            var tempExpnValue = expressionValueId.value.split("#@#")
         if (tempExpnValue.length == 2) {
             document.getElementById("<%=HiddenSavedExpStringValue.ClientID %>").value = tempExpnValue[0];
         }
        }
        
    }
    function onlyNumbers(e)
     {
         if (document.getElementById("<%=hiddenActualParameterType.ClientID %>") != null)
          {
             evt = e || window.event; // for trans-browser compatibility
             var charCode = evt.which || evt.keyCode;

             if (document.getElementById("<%=hiddenActualParameterType.ClientID %>").value == "Integer") {
                 if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                     return false;
                 }
             }
             else if (document.getElementById("<%=hiddenActualParameterType.ClientID %>").value == "Float") 
             {
                 charCode = String.fromCharCode(charCode);
                 var regex = /[0-9]|\./;
                 if (!regex.test(charCode)) 
                 {
                     return false;
                 }
             }

             return true;
         }

         return true;
    }

   

    function openEditor(txtParamId, hiddenFullValueId, hiddenModeId, clearImgId, deleteImageId) {
       
        var url = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(exbuilderUrl, false)%>";
        url = url.replace('SsrsMultiValueParam.aspx', 'ExpressionEditor.aspx');
        var wfName = escape("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(workflowName, false)%>");
        var propertyName = escape("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(propertyname, false)%>");
        var actionNam = escape("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(actionname, false)%>");

        document.getElementById('hidMultitxtParamId').value = txtParamId;
        document.getElementById('hidFullValueId').value = hiddenFullValueId;
        document.getElementById('hidModeId').value = hiddenModeId;
        document.getElementById('hidImageId').value = clearImgId;

        url = url + "&RHS=" + hiddenFullValueId;

        window.open(url, "_blank", "status=no,width=830,height=500,top=100")
    }

    function setExpression(exprnvalue) {
      
        if (exprnvalue != "" && exprnvalue != null) 
        {
            document.getElementById(document.getElementById('hidImageId').value).style.visibility = "visible";
            document.getElementById(document.getElementById('hidModeId').value).value = "Expression";           
            document.getElementById(document.getElementById('hidMultitxtParamId').value).setAttribute("disabled", "disabled");
                
        }

        document.getElementById(document.getElementById('hidFullValueId').value).setAttribute("value", exprnvalue);
        var valueExpr = exprnvalue;
        var str1 = valueExpr.replace(/["{}]/gi, "").split(/\n/g)
        for (i = 0; i < str1.length; i++) {
            var str2 = str1[i].split(':');
            if (str2[0] == "DisplayExpressionString") {
                var newExprn = str2[1];
                newExprn = ltrim(newExprn);
                break;
            }
        }

        newExprn = newExprn.replace('\\', ' ');
        newExprn = newExprn.replace(',', ' ');
        var pos = newExprn.indexOf('\\');
        if (pos >= 0)
         {
            newExprn = newExprn.replace('\\', ' ');
            var k = newExprn.lastIndexOf(',');
            newExprn = setChAt(newExprn, k, '');
            newExprn = newExprn.replace(/_x002B_/g, "+");
            newExprn = newExprn.replace(/_x002D_/g, "-");
            newExprn = newExprn.replace(/_x002F_/g, "/");
            newExprn = newExprn.replace('//', ' ');
            newExprn = newExprn.replace('"', ' ');
            document.getElementById(document.getElementById('hidMultitxtParamId').value).setAttribute("value", newExprn);
        }
        if(newExprn.indexOf("_x002D"!=-1))
        {
            newExprn = newExprn.replace(/_x002D_/g, "-");
             document.getElementById(document.getElementById('hidMultitxtParamId').value).setAttribute("value", newExprn);
        }
        else 
        {
            document.getElementById(document.getElementById('hidMultitxtParamId').value).setAttribute("value", newExprn);
        }
    }

    function setExpressionFromMultiValue(exprnvalue, count) 
    {
       
        if (exprnvalue != "" && exprnvalue != null) {
                document.getElementById('hidImageId').value= "ClearAllImg" + count;
                document.getElementById('hidModeId').value = "hiddenMode" + count;
                document.getElementById('hidMultitxtParamId').value = "txtParam" + count;
                document.getElementById('hidFullValueId').value = "hiddenFullValue" + count;

            document.getElementById(document.getElementById('hidImageId').value).style.visibility = "visible";
            document.getElementById(document.getElementById('hidModeId').value).value = "Expression";
            document.getElementById(document.getElementById('hidMultitxtParamId').value).setAttribute("disabled", "disabled");

        }
      
        document.getElementById(document.getElementById('hidFullValueId').value).setAttribute("value", exprnvalue);
        var valueExpr = exprnvalue;
        var str1 = valueExpr.replace(/["{}]/gi, "").split(/\n/g)
        for (i = 0; i < str1.length; i++) {
            var str2 = str1[i].split(':');
            if (str2[0] == "DisplayExpressionString") {
                var newExprn = str2[1];
                newExprn = ltrim(newExprn);
                break;
            }
        }

        newExprn = newExprn.replace('\\', ' ');
        newExprn = newExprn.replace(',', ' ');
        var pos = newExprn.indexOf('\\');
        if (pos >= 0) {
            newExprn = newExprn.replace('\\', ' ');
            var k = newExprn.lastIndexOf(',');
            newExprn = setChAt(newExprn, k, '');
            newExprn = newExprn.replace(/_x002B_/g, "+");
            newExprn = newExprn.replace(/_x002D_/g, "-");
            newExprn = newExprn.replace(/_x002F_/g, "/");
            newExprn = newExprn.replace('//', ' ');
            newExprn = newExprn.replace('"', ' ');
            document.getElementById(document.getElementById('hidMultitxtParamId').value).setAttribute("value", newExprn);
        }
        if (newExprn.indexOf("_x002D" != -1)) {
            newExprn = newExprn.replace(/_x002D_/g, "-");
            document.getElementById(document.getElementById('hidMultitxtParamId').value).setAttribute("value", newExprn);
        }
        else {
            document.getElementById(document.getElementById('hidMultitxtParamId').value).setAttribute("value", newExprn);
        }
    }
    function ltrim(s) {
        return s.replace(/^\s*/, "");
    }
    function setChAt(str, index, chr) {
        if (index > str.length - 1) return str;
        return str.substr(0, index) + chr + str.substr(index + 1);
    }
    function clearExpression(txtParamId, hiddenFullValueId, hiddenModeId, clearImgId, delteImageId) {
        se.ui.messageDialog.showConfirmation("<%= sr.GetString("SSRS_multiValue_configuration")%>", '<%= sr.GetString("SSRS_Multivalue_Exp_Clear")%>', function (conf)
        {
            if (conf)
            {
                document.getElementById('hidMultitxtParamId').value = "";
                document.getElementById('hidFullValueId').value = "";
                document.getElementById('hidModeId').value = "";
                document.getElementById('hidImageId').value = "";
                if (window.opener.document.getElementById(window.opener.document.getElementById('hidFullValueId').value) != null)
                {
                    window.opener.document.getElementById(window.opener.document.getElementById('hidFullValueId').value).setAttribute("value", "");
                }
                if (document.getElementById(txtParamId) != null)
                {
                    document.getElementById(txtParamId).value = "";
                    document.getElementById(txtParamId).disabled = false;
                }

                if (document.getElementById(hiddenFullValueId) != null)
                {
                    document.getElementById(hiddenFullValueId).value = "";
                }

                if (document.getElementById(hiddenModeId) != null)
                {
                    document.getElementById(hiddenModeId).value = "";
                }

                if (document.getElementById(clearImgId))
                {
                    document.getElementById(clearImgId).style.visibility = "hidden";
                }
            }
        });
    }
    function DeleteSpecificRow(divId) {
        if (document.getElementById("OuterDiv")!=null && document.getElementById(divId) != null && rtrim(ltrim(divId)) != 'VariableCollection0') {
            document.getElementById("OuterDiv").removeChild(document.getElementById(divId)); 
        }

    }
    function rtrim(s) {
        return s.replace(/\s+$/, "");
    }
    function AddTextBox() {
        var outerDivValue = document.getElementById("OuterDiv");
        var currentVariableNumber = document.getElementById("hiddenNumberOfVariable").value;
        var newNumber = parseInt(currentVariableNumber) + 1;
        var strNewVAriable = "";
        var idValueCollection;
        if(outerDivValue!=null)
        {
            var hand = "'hand'";
            var pointer = "'pointer'";
            strNewVAriable = '<div id="VariableCollection' + newNumber +'">';
            strNewVAriable = strNewVAriable + '<input type="text" id="txtParam' + newNumber + '" Text=""  style="width:250;" onkeypress="return onlyNumbers(event);"/>&nbsp; '
            strNewVAriable = strNewVAriable + '<img src="<%=ProcessDesignerControl.GetCommonRelativeUrl("Images/Expression-icon.gif")%>" id="expressionImage' + newNumber + '" onclick="openEditor(&quot;txtParam' + newNumber + '&quot;,&quot;hiddenFullValue' + newNumber + '&quot;,&quot;hiddenMode' + newNumber + '&quot;,&quot;ClearAllImg' + newNumber + '&quot;,&quot;DeleteRow' + newNumber + '&quot;);" alt="<%=sr.GetString("processdesigner_activity_attachment_img_eb") %>" title="<%=sr.GetString("processdesigner_activity_attachment_img_eb") %>" onmouseover="this.style.cursor=' + hand + ';this.style.cursor=' + pointer + '" />&nbsp; ';
           // strNewVAriable = strNewVAriable + '<img src="<%=ProcessDesignerControl.GetCommonRelativeUrl("Images/icon-ssrs-reports.png")%>" id="ssrsReportImage' + newNumber + '" onclick="openSSRSReportList(&quot;txtParam' + newNumber + '&quot;,&quot;hiddenFullValue' + newNumber + '&quot;,&quot;hiddenMode' + newNumber + '&quot;,&quot;ClearAllImg' + newNumber + '&quot;,&quot;DeleteRow' + newNumber + '&quot;);" alt="<%=sr.GetString("processdesigner_activity_attachment_img_reort") %>" title="<%=sr.GetString("processdesigner_activity_attachment_img_reort") %>" onmouseover="this.style.cursor=' + hand + ';this.style.cursor=' + pointer + '" />&nbsp; ';
            strNewVAriable = strNewVAriable + '<img src="<%=ProcessDesignerControl.GetCommonRelativeUrl("Images/icon-delete-row.png")%>" id="DeleteRow' + newNumber + '" onclick="DeleteSpecificRow(&quot;VariableCollection' + newNumber + '&quot;);" alt="<%=sr.GetString("processdesigner_activity_attachment_img_delrow") %>" title="<%=sr.GetString("processdesigner_activity_attachment_img_delrow") %>" onmouseover="this.style.cursor=' + hand + ';this.style.cursor=' + pointer + '" />&nbsp; ';
            strNewVAriable = strNewVAriable + '<img src="<%=ProcessDesignerControl.GetCommonRelativeUrl("Images/new-input-icon.gif")%>" id="ClearAllImg' + newNumber + '" onclick="clearExpression(&quot;txtParam' + newNumber + '&quot;,&quot;hiddenFullValue' + newNumber + '&quot;,&quot;hiddenMode' + newNumber + '&quot;,&quot;ClearAllImg' + newNumber + '&quot;,&quot;DeleteRow' + newNumber + '&quot;);" alt="<%=sr.GetString("processdesigner_activity_attachment_img_deldata") %>" title="<%=sr.GetString("processdesigner_activity_attachment_img_deldata") %>" style="visibility:hidden" onmouseover="this.style.cursor=' + hand + ';this.style.cursor=' + pointer + '" />&nbsp; ';
            strNewVAriable = strNewVAriable + '<input type="hidden" id="hiddenFullValue' + newNumber + '" />';
            strNewVAriable = strNewVAriable + '<input type="hidden" id="hiddenMode' + newNumber + '" />';

            strNewVAriable = strNewVAriable + '</div>';
            idValueCollection = GetValue(parseInt(currentVariableNumber));
            outerDivValue.innerHTML = outerDivValue.innerHTML + strNewVAriable;
            SetValue(idValueCollection);
            document.getElementById("hiddenNumberOfVariable").value = newNumber;
           // AddSettingsToTextBox('txtParam' + newNumber);
        }
        else
        {
            se.ui.messageDialog.showError("<%= sr.GetString("SSRS_multiValue_configuration")%>", "Error while adding, try again.");
        }
    }
    function GetValue(id) {
       
        var collection = new Array();
        var i;
        if(id == 0)
        {
            collection[0] = "txtParam0@#$" + document.getElementById("txtParam0").value;
        }
        if(id > 0) {
            for(i=0;i<=id;i++) {
                if (document.getElementById("txtParam" + i) != null) {
                    collection[i] = "txtParam" + i + "@#$" + document.getElementById("txtParam" + i).value;
                }
            }
        }
        return collection;
    }
    function SetValue(collection) {
       
        var i;
        if (collection != null) {
            for (i = 0; i < collection.length; i++) {
                if (collection[i] != null)
            {
                valuePair = collection[i].split("@#$");
                if (valuePair != null && valuePair.length == 2 && document.getElementById(valuePair[0]) != null) {
                    document.getElementById(valuePair[0]).value = valuePair[1];
                }
                }
            }
        }
    }
    function CreateString() {
       
        var finalString = "";
        var hidenValueSringObj = document.getElementById("<%=HiddenStringValue.ClientID %>");
        var mode = "";
        var fullValueofVariable = "";
        var finalFullvalueOfVariable = "";
        var tempMode = "";
        if (hidenValueSringObj != null) 
        {
            if (document.getElementById("hiddenNumberOfVariable") != null) 
            {
                var MaxVariableCount = parseInt(document.getElementById("hiddenNumberOfVariable").value);
                if (MaxVariableCount > 0) {
                    var variableCount = 0;
                    for (variableCount = 0; variableCount <= MaxVariableCount; variableCount++) 
                    {
                        var divid = "VariableCollection" + variableCount;
                        if (document.getElementById(divid) != null) 
                        {
                          //  var modeofVariable = document.getElementById("hiddenMode" + variableCount).value;
                            fullValueofVariable = document.getElementById("hiddenFullValue" + variableCount).value;
                           
                            if (finalFullvalueOfVariable != "" && fullValueofVariable!="") 
                            {
                                finalFullvalueOfVariable = finalFullvalueOfVariable + "#$#" + fullValueofVariable;
                            }
                            else if(fullValueofVariable!="")
                            {
                                finalFullvalueOfVariable = fullValueofVariable;
                            }
                            var multiValueParam = "";
                            multiValueParam = document.getElementById("txtParam" + variableCount).value;
                            if (document.getElementById("<%=hiddenActualParameterType.ClientID %>") != null && document.getElementById("<%=hiddenActualParameterType.ClientID %>").value == "DateTime") {
                                multiValueParam = FormatDate(multiValueParam);
                            }
                            mode = document.getElementById('hiddenMode' + variableCount).value;

                            multiValueParam = multiValueParam.replace(/^\s+/, '').replace(/\s+$/, '');
                            if (multiValueParam == "") {
                                multiValueParam = "string.empty";
                            }
                                if (multiValueParam.indexOf("Variable.") == -1 && multiValueParam.indexOf("XMLVariable.") == -1) 
                                {
                                    if (mode != "Expression") 
                                    {
                                        if (finalFullvalueOfVariable != "") 
                                        {

                                            finalFullvalueOfVariable = finalFullvalueOfVariable + "#$#" + multiValueParam;
                                        }
                                        else
                                         {
                                            finalFullvalueOfVariable = multiValueParam;
                                        }
                                    }
                                }
                                if (finalString != "") 
                                {
                                    finalString = finalString + "#$#" + multiValueParam ;
                                }
                                else 
                                {
                                   
                                    finalString = multiValueParam;
                                }                           
                        }
                        }
                        finalString = finalString.replace(/string.empty/g, "");
                    hidenValueSringObj.value = finalString;
                }
                else 
                {
                    var multiValueParam = document.getElementById("txtParam0").value;
                    if (document.getElementById("<%=hiddenActualParameterType.ClientID %>") != null && document.getElementById("<%=hiddenActualParameterType.ClientID %>").value == "DateTime") {
                        multiValueParam = FormatDate(multiValueParam);
                    }               
                        hidenValueSringObj.value = multiValueParam;
                        mode = document.getElementById('hiddenMode0').value;
                        finalFullvalueOfVariable = document.getElementById('hiddenFullValue0').value;
                   
                }
            }

             ReplaceWithComma(hidenValueSringObj.value);
             window.opener.document.getElementById(window.opener.document.getElementById('hidActualMultiValueParamId').value).setAttribute("value", hidenValueSringObj.value + "#@#" + "FMW");
             window.opener.document.getElementById(window.opener.document.getElementById('hidModeId').value).setAttribute("value", "TEXT");
             if (finalFullvalueOfVariable.indexOf("{\"DisplayExpressionString") != -1) 
             {
                 finalFullvalueOfVariable = finalFullvalueOfVariable.replace(/string.empty/g, "");
                 window.opener.document.getElementById(window.opener.document.getElementById('hidModeId').value).setAttribute("value", "Expression");
                 window.opener.document.getElementById(window.opener.document.getElementById('hidFullValueId').value).setAttribute("value", finalFullvalueOfVariable + "#@#" + "FMW");
               
            }
            window.setTimeout('window.close()', 100);
           
        }
    }
    function ReplaceWithComma(paramValue) 
    {
        paramValue = paramValue.replace(/#\$\#/g, ',');

        //changed to work in mozilla
        window.opener.document.getElementById(window.opener.document.getElementById('hidtxtParamId').value).disabled = false;
        window.opener.document.getElementById(window.opener.document.getElementById('hidtxtParamId').value).setAttribute("value", "");
        window.opener.document.getElementById(window.opener.document.getElementById('hidtxtParamId').value).setAttribute("value", paramValue);
        window.opener.document.getElementById(window.opener.document.getElementById('hidtxtParamId').value).disabled = true;
    }

    function FormatDate(dateValue) {
      
     //user entered value 2013-06-23-00-00-00
        //format 2013-06-23T00:00:00.0000000
        var splitDateValue = dateValue.split("-");
        var dateTimeString = splitDateValue[0] + "-" + splitDateValue[1] + "-" + splitDateValue[2] + "T" + splitDateValue[3] + ":" + splitDateValue[4] + ":" + splitDateValue[5] + "." + "0000000";
        return dateTimeString;
//         var dateTimeValue = new Date(parseInt(splitDateValue[0]), parseInt(splitDateValue[1]),parseInt(splitDateValue[2]), parseInt(splitDateValue[3]), parseInt(splitDateValue[4]), parseInt(splitDateValue[5]), parseInt(splitDateValue[6]));
//         return date.format("isoDateTime");
    }

    function PopulateDateTimeValue(savedDateTime) {
        var dateString = savedDateTime.replace("T", ":");
        dateString = dateString.split(".");
        return dateString[0].replace(/:/g,"-");
   
    }
    function PopulateValue() {

        var hiddenValue = document.getElementById("<%=HiddenStringValue.ClientID %>");
        var savedExpressionString = "";
        if (document.getElementById("<%=HiddenSavedExpStringValue.ClientID %>") != null) 
        {
            savedExpressionString = document.getElementById("<%=HiddenSavedExpStringValue.ClientID %>").value;
        }
        var savedExpSplitString="";
        if (savedExpressionString != null && savedExpressionString != "") 
            {
                savedExpSplitString = savedExpressionString.split("#$#");
            }
            if (hiddenValue != null && hiddenValue.value != "") 
            {
                var variables = hiddenValue.value.split("#$#");
               
                    if (variables != null && variables.length > 0) {
                        var variableCount = variables.length;
                        if (variableCount == 1) {
                            if (document.getElementById("hiddenActualParameterType").value == "DateTime") {
                                document.getElementById("txtParam0").value = PopulateDateTimeValue(variables[0]);
                            }
                            else {
                                document.getElementById("txtParam0").value = variables[0];
                            }
                            if (savedExpSplitString.length == 1) 
                            {
                                if (savedExpSplitString[0] != null && savedExpSplitString[0] != "")
                                 {
                                if(savedExpSplitString[0].indexOf("{\"DisplayExpressionString")!=-1)
                                {
                                    document.getElementById("hiddenFullValue0").value = savedExpSplitString[0];
                                    }
                                    if (document.getElementById('hidImageId') != null) {
                                        document.getElementById('hidImageId').value = "ClearAllImg0";
                                    }
                                    if (document.getElementById('hidModeId') != null) {
                                        document.getElementById('hidModeId').value = "hiddenMode0";
                                    }
                                    if (document.getElementById('hidMultitxtParamId') != null) {
                                        document.getElementById('hidMultitxtParamId').value = "txtParam0";
                                    }
                                    if (document.getElementById('hidFullValueId') != null) {
                                        document.getElementById('hidFullValueId').value = "hiddenFullValue0";
                                    }

                                }

                            }

                        }
                        else {
                            var loopCount = 0;
                            for (loopCount = 0; loopCount < variableCount; loopCount++) {
                                if (loopCount == 0) {
                                    if (document.getElementById("hiddenActualParameterType").value == "DateTime") {
                                        document.getElementById("txtParam0").value = PopulateDateTimeValue(variables[0]);
                                    }
                                    else {
                                        document.getElementById("txtParam0").value = variables[0];
                                    }
                                    if (savedExpSplitString[0] != null && savedExpSplitString[0] != "") {
                                        if (savedExpSplitString[0].indexOf("{\"DisplayExpressionString") != -1) {
                                            document.getElementById("hiddenFullValue0").value = savedExpSplitString[0];
                                        }
                                        if (document.getElementById('hidImageId') != null) {
                                            document.getElementById('hidImageId').value = "ClearAllImg0";
                                        }
                                        if (document.getElementById('hidModeId') != null) {
                                            document.getElementById('hidModeId').value = "hiddenMode0";
                                        }
                                        if (document.getElementById('hidMultitxtParamId') != null) {
                                            document.getElementById('hidMultitxtParamId').value = "txtParam0";
                                        }
                                        if (document.getElementById('hidFullValueId') != null) {
                                            document.getElementById('hidFullValueId').value = "hiddenFullValue0";
                                        }
                                    }
                                    
                                }
                                else {
                                    AddTextBox();
                                    var maxValue = parseInt(document.getElementById("hiddenNumberOfVariable").value);
                                    if (document.getElementById("hiddenActualParameterType").value == "DateTime") {
                                        document.getElementById("txtParam" + maxValue).value = PopulateDateTimeValue(variables[loopCount]);
                                    }
                                    else {
                                        document.getElementById("txtParam" + maxValue).value = variables[loopCount];
                                    }  //splitDynamicValues[0];
                                    if (savedExpSplitString[loopCount] != null && savedExpSplitString[loopCount] != "") {
                                        if (savedExpSplitString[loopCount].indexOf("{\"DisplayExpressionString") != -1) 
                                        {
                                            document.getElementById("hiddenFullValue" + maxValue).value = savedExpSplitString[loopCount];
                                        }
                                        if (document.getElementById('hidImageId') != null) {
                                            document.getElementById('hidImageId').value = "ClearAllImg" + loopCount;
                                        }
                                        if (document.getElementById('hidModeId') != null) {
                                            document.getElementById('hidModeId').value = "hiddenMode" + loopCount;
                                        }
                                        if (document.getElementById('hidMultitxtParamId') != null) {
                                            document.getElementById('hidMultitxtParamId').value = "txtParam" + loopCount;
                                        }
                                        if (document.getElementById('hidFullValueId') != null) {
                                            document.getElementById('hidFullValueId').value = "hiddenFullValue" + loopCount;
                                        }
                                    }
                                   
                                }
                            }
                        }
                    }
                    hiddenValue.value = "";

                    if (savedExpressionString != "" && savedExpSplitString != "" && savedExpSplitString != null) {
                        for (expCount = 0; expCount < savedExpSplitString.length; expCount++) {
                            if (savedExpSplitString[expCount].indexOf("{\"DisplayExpressionString") != -1) {
                                setExpressionFromMultiValue(savedExpSplitString[expCount], expCount);
                            }
                        }
                    }
                }

            }

    GetSavedValueFromParent();
    PopulateValue();
   
</script>

