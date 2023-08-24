<%@ Page Language="C#" Trace="false" AutoEventWireup="true" Debug="true" Inherits="Workflow.NET.CodeBehind.PropertyTypes.ReportAttachmentInEmailConfiguration" %>

<%@ Register Assembly="Skelta.Forms.Web" Namespace="Skelta.Forms.Web" TagPrefix="cc1" %>


<html>
<head id="Head1" runat="server">
   <title>
        <%= sr.GetString("processdesigner_activity_attachment_configuration")%>
    </title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script> 

    <link href="<%:ProcessDesignerControl.GetCommonRelativeUrl("Stylesheet/global.css")%>"
        rel="stylesheet" type="text/css" />
    <%--<link href="Stylesheet/global.css" rel="stylesheet" type="text/css" />--%>
    <style type="text/css">
    
        .html, body {
        overflow: hidden;
        }
        .tablebg
        {
            height: 220px;
        }
    </style>
</head>
<body>
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

        function DisplayMessage() {
            var strMessage = '<%=sr.GetString("PD_Config_Mail_Attach") %>';
             var strHdrMsg = '<%=sr.GetString("processdesigner_activity_attachment_configuration_heading") %>';
             se.ui.messageDialog.showError(strHdrMsg, strMessage);
         }

    </script>
   <form id="form1" runat="server">
       <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
        <link href="<%:themePath%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
        <table border="0" cellpadding="0" cellspacing="1" width="100%">
            <tr>
                <td>
                    <table border="0" cellpadding="6" cellspacing="0" width="100%">
                        <tr valign="top" class="ListheaderCss">
                            <td style="padding-left:10px;" >
                                <span class="pagetitle">
                                    <%= sr.GetString("processdesigner_activity_attachment_configuration_heading")%>
                                </span>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <table border="0" cellpadding="0" cellspacing="1" width="100%">
                        <tr valign="top">
                            <td class="description" valign="middle" colspan="2" style="padding-left:10px;">
                                <%=Description %>
                            </td>                          
                        </tr>                      
                    </table>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <table align="center" border="0" cellpadding="6" cellspacing="2" class="" width="100%">
                        <tr id="tableRowAttachmentType" runat="server">
                            <td class="lefttdbg" style="width: 38%">
                                <span class="subtitle">
                                    <%= sr.GetString("processdesigner_activity_attachment_configuration_attachmenttype")%>
                                </span>
                                <br />
                                <span class="description">
                                   <%= sr.GetString("processdesigner_activity_attachment_configuration_attachmenttype_desc")%>
                                </span>
                            </td>
                            <td class="righttdbg">
                                    <asp:RadioButtonList id="RadioAttachmentType" runat="server">
                                    </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td class="" style="width: 38%">
                                <span class="subtitle">
                                    <%= sr.GetString("processdesigner_activity_attachment_attach_report")%>
                                </span>
                                <br />
                                <span class="description">
                                   <%= sr.GetString("processdesigner_activity_attachment_attach_report_desc")%>
                                </span>
                            </td>
                            <td class="tdbg">
                                <div id="OuterDiv" style="overflow:auto;padding-bottom:1px;height:150px;">
                                    <div class="GridHeaderStyle" >
                                    <a href="#" onclick="AddTextBox();" class="textlinkblacknormal">                                     
                                     <img src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ProcessDesignerControl.GetCommonRelativeUrl("Images/addRow.png"))%>" id="addRowImage" style="border:none;padding-top:12px;padding-left:5px;" />
                                        <%=sr.GetString("processdesigner_activity_attachment_add_row")%>
                                    </a>
                                        </div>
                                    <div id="VariableCollection0" style="padding-top:5px;">
                                           <input type="text" id="TextBoxReportGeneratorId0" Text="" disabled="disabled" style="width:250px;" class="inputtext"/>&nbsp;
                                           <img src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ProcessDesignerControl.GetCommonRelativeUrl("Images/icon-ReportExpn.gif"))%>" id="expressionImage" onclick="openEditor('TextBoxReportGeneratorId0','hiddenFullValue0','hiddenMode0','ClearAllImg0','DeleteRow0');" alt="<%=sr.GetString("processdesigner_activity_attachment_img_eb") %>"  title="<%=sr.GetString("processdesigner_activity_attachment_img_eb") %>" onmouseover="this.style.cursor='hand';this.style.cursor='pointer'" width="16" height="16" />&nbsp;
                                           <img src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ProcessDesignerControl.GetCommonRelativeUrl("Images/icon-ssrs-reports.png"))%>" id="ssrsReportImage" onclick="openSSRSReportList('TextBoxReportGeneratorId0','hiddenFullValue0','hiddenMode0','ClearAllImg0','DeleteRow0');" alt="<%=sr.GetString("processdesigner_activity_attachment_img_reort") %>" title="<%=sr.GetString("processdesigner_activity_attachment_img_reort") %>" onmouseover="this.style.cursor='hand';this.style.cursor='pointer'" />&nbsp;
                                           <img src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ProcessDesignerControl.GetCommonRelativeUrl("Images/new-input-icon.gif"))%>" id="ClearAllImg0" alt="<%=sr.GetString("processdesigner_activity_attachment_img_deldata") %>" title="<%=sr.GetString("processdesigner_activity_attachment_img_deldata") %>" style="visibility:hidden" onclick="clearExpression('TextBoxReportGeneratorId0','hiddenFullValue0','hiddenMode0','ClearAllImg0','DeleteRow0');" onmouseover="this.style.cursor='hand';this.style.cursor='pointer'" />
                                           <img src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ProcessDesignerControl.GetCommonRelativeUrl("Images/remove-selected-icon.gif"))%>" id="DeleteRow0" alt="<%=sr.GetString("processdesigner_activity_attachment_img_delrow") %>" title=="<%=sr.GetString("processdesigner_activity_attachment_img_delrow") %>" style="visibility:hidden" onclick="DeleteSpecificRow('VariableCollection0');"/>
                                           <input id="hiddenFullValue0" type="hidden" runat="server" name="hiddenFullValue" />
                                           <input id="hiddenMode0" type="hidden" runat="server" name="hiddenMode" />
                                     </div>
                                 </div>                              
                                                                 
                            </td>
                        </tr>
                        <%--<tr style="visibility:hidden">
                            <td class="lefttdbg" style="width: 38%">
                                <span class="subtitle">
                                    <%= sr.GetString("processdesigner_activity_attachment_configuration_sendmail")%>
                                </span>
                                <br />
                                <span class="description">
                                   <%= sr.GetString("processdesigner_activity_attachment_configuration_sendmail_desc")%>
                                </span>
                            </td>
                            <td class="righttdbg">
                                    <asp:RadioButtonList id="RadioSendMailOption" runat="server" Visible="false">
                                    </asp:RadioButtonList>
                            </td>
                        </tr>--%>
                        
                        <tr class="">
                            <td colspan="2" align="right">
                                <table width="100%" border="0" cellspacing="0" cellpadding="1">
                                    <tr>
                                        <td align="right" >
                                            <asp:Button ID="CloseButton" runat="server"  OnClick="CloseButton_Click"   CssClass="inputsecondarybutton" />
                                            &nbsp;<asp:Button ID="Submit" runat="server" OnClientClick="return CretaeString();" OnClick="Submit_Click"   CssClass="inputbutton" />    
                                            
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
        <input id="hidtxtParamId" type="hidden" name="hidRowSelectedNo" />
        <input id="hidFullValueId" type="hidden" name="hidRowSelectedNo" />
        <input id="hidModeId" type="hidden" name="hidRowWithActualValue" />
        <input id="hidImageId" type="hidden" name="hidImage" />
        <input id="hidDeleteRowImageId" type="hidden" name="hidDeleteRowImageId" />
        <input id="hiddenNumberOfVariable" type="hidden" name="hiddenNumberOfVariable" value="0" />
        <asp:HiddenField ID="HiddenStringValue" Value="" runat="server"/>
    </form>
</body>
</html>
<script language="javascript" type="text/javascript">


    function openEditor(txtParamId, hiddenFullValueId, hiddenModeId, clearImgId, deleteImageId) {

        /*document.getElementById('hidRowSelectedNo').value = clientQueryTextbox;
        document.getElementById('hidRowWithActualValue').value = clientIdhidRHS;
        document.getElementById('hidTextboxValue').value = clientTxtValue;
        document.getElementById('hidImage').value = clientHidImg;*/

        var url = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(exbuilderUrl, false)%>";
        url = url.replace('ReportAttachmentInEmailConfiguration.aspx', "ExpressionEditor.aspx");
        var wfName = escape("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(workflowName, false)%>");
        var propertyName = escape("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(propertyname, false)%>");
        var actionNam = escape("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(actionname, false)%>");

        document.getElementById('hidtxtParamId').value = txtParamId;
        document.getElementById('hidFullValueId').value = hiddenFullValueId;
        document.getElementById('hidModeId').value = hiddenModeId;
        document.getElementById('hidImageId').value = clearImgId;

        url = url + "&RHS=" + hiddenFullValueId;

        window.open(url, "_default", "status=no,width=830,height=500,left=300,top=200")
    }
    function openSSRSReportList(txtParamId, hiddenFullValueId, hiddenModeId, clearImgId, deleteImageId) {
        var url = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(exbuilderUrl, false)%>";
        url = url.replace('ReportAttachmentInEmailConfiguration.aspx', "SsrsReportTemplates.aspx");
        var wfName = escape("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(workflowName, false)%>");
        var propertyName = escape("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(propertyname, false)%>")
        var actionNam = escape("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(actionname, false)%>");

        
        document.getElementById('hidtxtParamId').value = txtParamId;
        document.getElementById('hidFullValueId').value = hiddenFullValueId;
        document.getElementById('hidModeId').value = hiddenModeId;
        document.getElementById('hidImageId').value = clearImgId;

        url = url + "&RHS=" + document.getElementById(hiddenFullValueId).value;

        window.open(url, "_default", "status=no,width=630,height=200,left=550,top=390")
    }
    function SetReport(reportName) {
       if (reportName != null && reportName != "") {
            var nameValue = reportName.split("@!@");
            if (nameValue != null & nameValue.length == 2) {
                //debugger;
                document.getElementById(document.getElementById('hidImageId').value).style.visibility = "visible";
                document.getElementById(document.getElementById('hidModeId').value).value = "SSRSReport";
                document.getElementById(document.getElementById('hidtxtParamId').value).setAttribute("disabled", "disabled");

                document.getElementById(document.getElementById('hidFullValueId').value).setAttribute("value", nameValue[1]);
                document.getElementById(document.getElementById('hidtxtParamId').value).setAttribute("value", nameValue[0]);
            }
        }
    }
    function setExpression(exprnvalue) {
        if (exprnvalue != "") {
            document.getElementById(document.getElementById('hidImageId').value).style.visibility = "visible";
            document.getElementById(document.getElementById('hidModeId').value).value = "Expression";
            document.getElementById(document.getElementById('hidtxtParamId').value).setAttribute("disabled", "disabled");
                
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
            document.getElementById(document.getElementById('hidtxtParamId').value).setAttribute("value", newExprn);
        }
        else {
            document.getElementById(document.getElementById('hidtxtParamId').value).setAttribute("value", newExprn);
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
       // conf = confirm('<%= sr.GetString("processdesigner_activity_delte_expressionreport")%>');
       
        se.ui.messageDialog.showConfirmation(
            
                       "<%=sr.GetString("processdesigner_activity_attachment_configuration_heading") %>",
                        "<%=sr.GetString("processdesigner_activity_delte_expressionreport") %>",
                        function (userResponse) {
                           
                            if (userResponse) {
                                document.getElementById('hidtxtParamId').value = "";
                                document.getElementById('hidFullValueId').value = "";
                                document.getElementById('hidModeId').value = "";
                                document.getElementById('hidImageId').value = "";


                                if (document.getElementById(txtParamId) != null) {
                                    document.getElementById(txtParamId).value = "";
                                }


                                if (document.getElementById(hiddenFullValueId) != null) {
                                    document.getElementById(hiddenFullValueId).value = "";
                                }


                                if (document.getElementById(hiddenModeId) != null) {
                                    document.getElementById(hiddenModeId).value = "";
                                }

                                if (document.getElementById(clearImgId)) {
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
            strNewVAriable = '<div style="padding-top:5px;" id="VariableCollection' + newNumber +'">';
            strNewVAriable = strNewVAriable + '<input type="text" id="TextBoxReportGeneratorId' + newNumber + '" Text="" disabled="disabled" class="inputtext" style="width:250; "/>&nbsp; '
            strNewVAriable = strNewVAriable + '<img src="<%:ProcessDesignerControl.GetCommonRelativeUrl("Images/icon-ReportExpn.gif")%>" id="expressionImage' + newNumber + '" onclick="openEditor(&quot;TextBoxReportGeneratorId' + newNumber + '&quot;,&quot;hiddenFullValue' + newNumber + '&quot;,&quot;hiddenMode' + newNumber + '&quot;,&quot;ClearAllImg' + newNumber + '&quot;,&quot;DeleteRow' + newNumber + '&quot;);" alt="<%=sr.GetString("processdesigner_activity_attachment_img_eb") %>" title="<%=sr.GetString("processdesigner_activity_attachment_img_eb") %>" onmouseover="this.style.cursor=' + hand + ';this.style.cursor=' + pointer + '" />&nbsp; ';
            strNewVAriable = strNewVAriable + '<img src="<%:ProcessDesignerControl.GetCommonRelativeUrl("Images/icon-ssrs-reports.png")%>" id="ssrsReportImage' + newNumber + '" onclick="openSSRSReportList(&quot;TextBoxReportGeneratorId' + newNumber + '&quot;,&quot;hiddenFullValue' + newNumber + '&quot;,&quot;hiddenMode' + newNumber + '&quot;,&quot;ClearAllImg' + newNumber + '&quot;,&quot;DeleteRow' + newNumber + '&quot;);" alt="<%=sr.GetString("processdesigner_activity_attachment_img_reort") %>" title="<%=sr.GetString("processdesigner_activity_attachment_img_reort") %>" onmouseover="this.style.cursor=' + hand + ';this.style.cursor=' + pointer + '" />&nbsp; ';
            strNewVAriable = strNewVAriable + '<img src="<%:ProcessDesignerControl.GetCommonRelativeUrl("Images/remove-selected-icon.gif")%>" id="DeleteRow' + newNumber + '" onclick="DeleteSpecificRow(&quot;VariableCollection' + newNumber + '&quot;);" alt="<%=sr.GetString("processdesigner_activity_attachment_img_delrow") %>" title="<%=sr.GetString("processdesigner_activity_attachment_img_delrow") %>" onmouseover="this.style.cursor=' + hand + ';this.style.cursor=' + pointer + '" />&nbsp; ';
            strNewVAriable = strNewVAriable + '<img src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ProcessDesignerControl.GetCommonRelativeUrl("Images/new-input-icon.gif"))%>" id="ClearAllImg' + newNumber + '" onclick="clearExpression(&quot;TextBoxReportGeneratorId' + newNumber + '&quot;,&quot;hiddenFullValue' + newNumber + '&quot;,&quot;hiddenMode' + newNumber + '&quot;,&quot;ClearAllImg' + newNumber + '&quot;,&quot;DeleteRow' + newNumber + '&quot;);" alt="<%=sr.GetString("processdesigner_activity_attachment_img_deldata") %>" title="<%=sr.GetString("processdesigner_activity_attachment_img_deldata") %>" style="visibility:hidden" onmouseover="this.style.cursor=' + hand + ';this.style.cursor=' + pointer + '" />&nbsp; ';
            strNewVAriable = strNewVAriable + '<input type="hidden" id="hiddenFullValue' + newNumber + '" />';
            strNewVAriable = strNewVAriable + '<input type="hidden" id="hiddenMode' + newNumber + '" />';

            strNewVAriable = strNewVAriable + '</div>';
            idValueCollection = GetValue(parseInt(currentVariableNumber));
            outerDivValue.innerHTML = outerDivValue.innerHTML + strNewVAriable;
            SetValue(idValueCollection);
            document.getElementById("hiddenNumberOfVariable").value = newNumber;
        }
        else
        {
            // alert("Error while adding, try again.");
            DisplayMessage();
        }
    }
    function GetValue(id) {
        var collection = new Array();
        var i;
        if(id == 0)
        {
            collection[0] = "TextBoxReportGeneratorId0@#$" + document.getElementById("TextBoxReportGeneratorId0").value;
        }
        if(id > 0) {
            for(i=0;i<=id;i++) {
                if (document.getElementById("TextBoxReportGeneratorId" + i) != null) {
                    collection[i] = "TextBoxReportGeneratorId" + i + "@#$" + document.getElementById("TextBoxReportGeneratorId" + i).value;
                }
            }
        }
        return collection;
    }
    function SetValue(collection) {
        var i;
        if (collection != null) {
            for (i = 0; i < collection.length; i++) {
                valuePair = collection[i].split("@#$");
                if (valuePair != null && valuePair.length == 2 && document.getElementById(valuePair[0])!= null) {
                    document.getElementById(valuePair[0]).value = valuePair[1];
                }
            }
        }
    }
    function CretaeString() {

        var finalString = "";
        var hidenValueSringObj = document.getElementById("<%=HiddenStringValue.ClientID %>");
        if (hidenValueSringObj != null) {
            if (document.getElementById("hiddenNumberOfVariable") != null) {
                var MaxVariableCount = parseInt(document.getElementById("hiddenNumberOfVariable").value);
                if (MaxVariableCount > 0) {
                    var variableCount = 0;
                    for (variableCount = 0; variableCount <= MaxVariableCount; variableCount++) {
                        var divid = "VariableCollection" + variableCount;
                        if (document.getElementById(divid) != null) {
                            var modeofVariable = document.getElementById("hiddenMode" + variableCount).value;
                            var fullValueofVariable = document.getElementById("hiddenFullValue" + variableCount).value;
                            var displayValueofVariable = document.getElementById("TextBoxReportGeneratorId" + variableCount).value;
                            if (fullValueofVariable != "" && ltrim(rtrim(modeofVariable)) != "") {
                                if (finalString != "") {
                                    finalString = finalString + "@@!@@" + displayValueofVariable + "@!@" + modeofVariable + "@!@" + fullValueofVariable;
                                }
                                else {
                                    finalString = displayValueofVariable + "@!@" + modeofVariable + "@!@" + fullValueofVariable;
                                }
                            }
                        }
                    }
                    hidenValueSringObj.value = finalString;
                }
                else {
                    var mode = document.getElementById("hiddenMode0").value;
                    var fullValue = document.getElementById("hiddenFullValue0").value;
                    var displayValue = document.getElementById("TextBoxReportGeneratorId0").value;
                    if (fullValue != null && fullValue != "" && ltrim(rtrim(displayValue)) != "") {
                        hidenValueSringObj.value = displayValue + "@!@" + mode + "@!@" + fullValue;
                    }
                }
            }
        }
    }
    
    function PopulateValue() {

        var hiddenValue = document.getElementById("<%=HiddenStringValue.ClientID %>");
        if (hiddenValue != null && hiddenValue.value != "") {
            var variables = hiddenValue.value.split("@@!@@");

            if (variables != null && variables.length > 0) {
                var variableCount = variables.length;
                if (variableCount == 1) {
                    var splitValues = variables[0].split("@!@");
                    document.getElementById("TextBoxReportGeneratorId0").value = splitValues[0];
                    document.getElementById("hiddenMode0").value = splitValues[1];
                    document.getElementById("hiddenFullValue0").value = splitValues[2];
                    document.getElementById("ClearAllImg0").style.visibility = "visible";
                }
                else {
                    var loopCount = 0;
                    for (loopCount = 0; loopCount < variableCount; loopCount++) {
                        if (loopCount == 0) {
                            var splitValues = variables[0].split("@!@");
                            document.getElementById("TextBoxReportGeneratorId0").value = splitValues[0];
                            document.getElementById("hiddenMode0").value = splitValues[1];
                            document.getElementById("hiddenFullValue0").value = splitValues[2];
                            document.getElementById("ClearAllImg0").style.visibility = "visible";
                        }
                        else {
                            AddTextBox();
                            var maxValue = parseInt(document.getElementById("hiddenNumberOfVariable").value);
                            var splitDynamicValues = variables[loopCount].split("@!@");
                            document.getElementById("TextBoxReportGeneratorId" + maxValue).value = splitDynamicValues[0];
                            document.getElementById("hiddenMode" + maxValue).value = splitDynamicValues[1];
                            document.getElementById("hiddenFullValue" + maxValue).value = splitDynamicValues[2];
                            document.getElementById("ClearAllImg" + maxValue).style.visibility = "visible";
                        }
                    }
                }
            }
            hiddenValue.value = "";
        }
    }
    PopulateValue();
   
</script>

