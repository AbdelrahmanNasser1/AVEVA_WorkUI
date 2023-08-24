<%@ Page Language="C#" Trace="false" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.PropertyTypes.SFReportParamLookup" %>
<%@ Register Assembly="Skelta.Forms.Web" Namespace="Skelta.Forms.Web" TagPrefix="cc1" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE html>
<html>
<head id="Head1">
    
   <title>
         <%= sr.GetString("processdesigner_activity_setparam_popup_title")%>
    </title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ProcessDesignerControl.GetCommonRelativeUrl("Stylesheet/global.css"))%>"
        rel="stylesheet" type="text/css" />   
    <script type='text/javascript' src='<%=Microsoft.Security.Application.Encoder.HtmlEncode(_JScriptPath)%>'></script>
    <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
       
   
    <style type="text/css">
    
        .html, body {
        overflow-x: hidden;
        height:100%;
        }
    </style>
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
   <form id="form1" runat="server" style="height:100%;">
    <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css" />
    <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css" />
    <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>TelerikAjax/StyleSheet/AWTInput/Input.AWTInput.css" />
    <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>TelerikAjax/StyleSheet/AWTCalendar/Calendar.AWTCalendar.css" />
    <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>TelerikAjax/StyleSheet/AWTCalendar/Calendar.css">

		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server" />
        <table border="0" cellpadding="0" cellspacing="1" width="100%">
            <tr>
                <td valign="top">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr valign="top">
                            <td class="ListHeaderCss" valign="middle" style="width:97%;padding-left:10px;">
                                <span class="fontheading">
                                    <%= sr.GetString("processdesigner_activity_setparam_heading")%>
                                </span>
                            </td>
                            <td valign="middle" >
                       <span title="Help">
                        <img src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ProcessDesignerControl.GetCommonRelativeUrl("Images/main-help.gif"))%>"
                        align="right" onclick="javascript:openhelpwin()" style="cursor: pointer" alt="<%=sr.GetString("processdesigner_activity_setparam_help")%>" /></span>
                    </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td valign="top" style="padding-left:10px;"> 
                    <table border="0" cellpadding="0" cellspacing="1" width="100%">
                        <tr valign="top">
                            <td class="description" valign="middle" colspan="2">
                                
                                    <%= sr.GetString("processdesigner_activity_setparam_heading_desc")%>
                                
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td valign="top" style="padding-left:10px;padding-right:10px;padding-top:10px;">
                    <table align="center" border="0"  cellspacing="2" class="tablebg" width="100%">
                        <tr>
                            <td class="lefttdbg" style="width: 30%;vertical-align:top;">
                                <span class="subtitle">
                                    <%=sr.GetString("processdesigner_activity_setparam_template_lbl")%>
                                </span>
                                <br />
                                <span class="description">
                                   <%=sr.GetString("processdesigner_activity_setparam_template_lbl_desc")%>
                                </span>
                            </td>
                            <td class="righttdbg" style="padding-left:5px;">
                                 <telerik:RadComboBox ID="drpdwnReportTemplate" runat="server" AllowCustomText="true"  MarkFirstMatch="true" RenderMode="Classic"
                                          EnableEmbeddedSkins="false"  Skin="AWTCombobox" AutoPostBack="true" MaxLength="250" Width="260px" DropDownWidth="260px"
                                           Height="150px" NoWrap="True"  OnClientSelectedIndexChanged="ShowImageAnimation" OnSelectedIndexChanged="On_SelectedIndexChanged">
                                     </telerik:RadComboBox>
                               <br />
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td class="lefttdbg" style="width: 30%;vertical-align:top;">
                                <span class="subtitle">
                                    <%=sr.GetString("processdesigner_activity_setparam_parameter_lbl")%>
                                </span>
                                <br />
                                <span class="description">
                                  <%=sr.GetString("processdesigner_ssrsactivity_setparam_parameter_lbl_desc")%>
                                  <br />
                                </span>
                            </td>
                            <td class="righttdbg" style="padding-left:5px;">
                            <label style="visibility:hidden;position:absolute;left:450px;top:180px" id="lblWait"><%=sr.GetString("processdesigner_activity_setparam_parameter_wait_text")%></label>
                                <div runat="server" id="hiddenCheckboxdiv" style="height:175px; overflow:auto;display:none;height:30px;">
                                
                                </div>
                                <div runat="server" id="parameterDiv" style="height:165px; overflow:auto;border-style:solid;border-width:1px;border-color:Gray">
                                
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="lefttdbg" style="width: 30%">
                                <span class="subtitle">
                                    <%= sr.GetString("processdesigner_activity_setparam_cretaevariable_lbl")%>
                                </span>
                                <br />
                                <span class="description">
                                  <%= sr.GetString("processdesigner_activity_setparam_cretaevariable_lbl_desc")%> 
                                  <br />
                                </span>
                            </td>
                            <td class="righttdbg">
                                <asp:RadioButtonList id="RadioVariableCreation" runat="server" onclick="SetTextBoxReadOnly();">
                                <asp:ListItem selected="true" Value="1">
                                    Generate variable automatically
                                </asp:ListItem>
                                <asp:ListItem Value="2">
                                    Create variable manually
                                </asp:ListItem>
                                </asp:RadioButtonList>
                                <br />
                                <div id="DivManualVariable" style="padding-left:5px;"><asp:Label ID="LableManualVariable" runat="server" Text="Variable name:"></asp:Label>&nbsp;<asp:TextBox ID="TextBoxManualVariable" CssClass="inputtext" runat="server" Text="" Width="250px"/></div>
                            </td>
                        </tr>
                       
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <table width="100%" border="0" cellspacing="0" cellpadding="1">
                        <tr>
                            <td align="right" style="padding-right:10px;padding-bottom:10px;padding-top:5px;">&nbsp;<asp:Button ID="CloseButton" runat="server" OnClick="CloseButton_Click" CssClass="inputsecondarybutton" />
                                <asp:Button ID="Submit" runat="server" OnClientClick="return Validate();" OnClick="Submit_Click" CssClass="inputbutton" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        
        <input id="hidtxtParamId" type="hidden"  name="hidRowSelectedNo" />
        <input id="hidFullValueId" type="hidden" name="hidRowSelectedNo" />
        <input id="hidModeId" type="hidden" name="hidRowWithActualValue" />
        <input id="hidImageId" type="hidden" name="hidImage" />
        <input id="hidParamName" type="hidden" name="hidParamName" />
        <input id="hidParamType" type="hidden" name="hidParamType" />       
        <input id="hidMutivalueParam" type="hidden" name="hidMutivalueParam" />
        <input id="hidFromMultiValueId" type="hidden" name="hidFromMultivalue" />
        <input id="hidFromMultiValueParam" type="hidden" name="hidFromMultiValueParam" />
        <input id="hidActualMultiValueParamId" type="hidden" name="hidActualMultiValueParamId" />
        <asp:HiddenField ID="hiddenNumberofParam" runat="server" Value="" />
        <asp:HiddenField ID="hiddenParamStringValue" runat="server" Value="" />
        <asp:HiddenField ID="HiddenActionName" runat="server" Value="" />
        <asp:HiddenField ID="historianConnectionName" runat="server" Value="" />
        <asp:HiddenField ID="historianConnectionNameforTimeZone" runat="server" Value="" />
        <asp:HiddenField ID="isHiddenIncluded" runat="server" Value="" />  
        <asp:HiddenField ID="hiddenExpressionUrl" runat="server" Value="" />
    </form>
</body>
</html>
<script language="javascript" type="text/javascript">
   
    function openSSRSMutiValue(txtParamId, hiddenFullValueId, hiddenModeId, clearImgId, parameterFiledKey, paramType, paramfieldName, actualParamType, actualMultivalueParamId)
    {
        var url = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(exbuilderUrl, false)%>";
        url = url.replace('SFReportParamLookup.aspx', "SsrsMultiValueParam.aspx");
        var wfName = escape("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(workflowName, false)%>");
        var propertyName = escape("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(propertyname, false)%>")
        var actionNam = escape("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(actionname, false)%>");       
        var ExpFieldId = hiddenFullValueId;
        var paramValueId = actualMultivalueParamId;
       
        document.getElementById('hidtxtParamId').value = txtParamId;       
        document.getElementById('hidFullValueId').value = hiddenFullValueId;
        document.getElementById('hidModeId').value = hiddenModeId;
        document.getElementById('hidImageId').value = clearImgId;
        document.getElementById('hidParamType').value = paramType;   
        document.getElementById('hidActualMultiValueParamId').value= actualMultivalueParamId;     
     
     //   url = url + "&ParamType="+ paramType + "&ParamFieldName=" + paramfieldName + "&ActualParamtype=" + actualParamType + "&ParamValue=" + paramValue + "&ExpressionString=" + expString ;

      url = url + "&ParamType="+ paramType + "&ParamFieldName=" + paramfieldName + "&ActualParamtype=" + actualParamType + "&ActualValueId=" + paramValueId + "&ExpressionValueId=" + ExpFieldId ;

        window.open(url, "_default", "status=no,width=630,height=315,left=350,top=200")
    }
    function openEditor(txtParamId, hiddenFullValueId, hiddenModeId, clearImgId, paramKey, paramType, multiparamType, actualMultivalueParamId) {

        var url = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(exbuilderUrl, false)%>";
        url = url.replace('SFReportParamLookup.aspx', "ExpressionEditor.aspx");
        var wfName = escape("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(workflowName, false)%>");
        var propertyName = escape("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(propertyname, false)%>");
        var actionNam = escape("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(actionname, false)%>");


        document.getElementById('hidtxtParamId').value = txtParamId;
        document.getElementById('hidFullValueId').value = hiddenFullValueId;
        document.getElementById('hidModeId').value = hiddenModeId;
        document.getElementById('hidImageId').value = clearImgId;
        document.getElementById('hidParamName').value = paramKey;
        document.getElementById('hidParamType').value = paramType;
        document.getElementById('hidActualMultiValueParamId').value = actualMultivalueParamId;

        url = url + "&RHS=" + hiddenFullValueId;

        window.open(url, "_default", "status=no,width=830,height=500,top=100")
        //window.open("ExpressionEditor.aspx?ApplicationName=<%=applicationName%>&WorkflowName=" + wfName + "&SelectedProperty=" + propertyName + "&ActionName=" + actionNam + "&cul=en-US&Pdsuri=<%=pdsUri%>&SkDii=<%=skdii%>&RHS=" + clientIdhidRHS, "_default", "status=no,width=830,height=500,top=100");
    }
    
     function openTagPicker(txtParamId, hiddenFullValueId, hiddenModeId, clearImgId, paramName, paramType, isMultiple, actualMultivalueParamId, isMultivalue)
     {
        var url = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(exbuilderUrl, false)%>";
        url = url.replace('SFReportParamLookup.aspx', "SSRSHistorianTagLookUp.aspx");
        var wfName = escape("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(workflowName, false)%>");
        var propertyName = escape("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(propertyname, false)%>");
        var actionNam = escape("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(actionname, false)%>");

        document.getElementById('hidtxtParamId').value = txtParamId;
        document.getElementById('hidFullValueId').value = hiddenFullValueId;
        document.getElementById('hidModeId').value = hiddenModeId;
        document.getElementById('hidImageId').value = clearImgId;
        document.getElementById('hidParamName').value = paramName;
        document.getElementById('hidParamType').value = paramType;
        document.getElementById('hidActualMultiValueParamId').value= actualMultivalueParamId;     
        
        url = url + "&RHS=" + hiddenFullValueId + "&multiple=" + isMultiple + "&HistorianConnection=" + document.getElementById("<%=historianConnectionName.ClientID%>").value + "&DataFieldId=" + txtParamId + "&IsMultivalue=" + isMultivalue;
        
        window.open(url, "_default", "status=no,width=830,height=350,top=250,left=400")
        //window.open("ExpressionEditor.aspx?ApplicationName=<%=applicationName%>&WorkflowName=" + wfName + "&SelectedProperty=" + propertyName + "&ActionName=" + actionNam + "&cul=en-US&Pdsuri=<%=pdsUri%>&SkDii=<%=skdii%>&RHS=" + clientIdhidRHS, "_default", "status=no,width=830,height=500,top=100");
    }
    function openTimeZonePicker(txtParamId, hiddenFullValueId, hiddenModeId, clearImgId, paramName, paramType)
    {
             
        var url = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(exbuilderUrl, false)%>";
        url = url.replace('SFReportParamLookup.aspx', "SSRSTimeZonePicker.aspx");
        var wfName = escape("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(workflowName, false)%>");
        var propertyName = escape("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(propertyname, false)%>");
        var actionNam = escape("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(actionname, false)%>");

        document.getElementById('hidtxtParamId').value = txtParamId;
        document.getElementById('hidFullValueId').value = hiddenFullValueId;
        document.getElementById('hidModeId').value = hiddenModeId;
        document.getElementById('hidImageId').value = clearImgId;
        document.getElementById('hidParamName').value = paramName;
        document.getElementById('hidParamType').value = paramType;
       
        var timezoneid = -1;
        if(document.getElementById(txtParamId) != null)
        {
            timezoneid = GetValueFromNumberControl(txtParamId.replace("txtParam","rnt"), "");
        }
        
        url = url + "&RHS=" + hiddenFullValueId + "&HistorianConnection=" + document.getElementById("<%=historianConnectionNameforTimeZone.ClientID%>").value + "&TiemZone=" + timezoneid;
        
        window.open(url, "_default", "status=no,width=470,height=190,top=370,left=580")
        //window.open("ExpressionEditor.aspx?ApplicationName=<%=applicationName%>&WorkflowName=" + wfName + "&SelectedProperty=" + propertyName + "&ActionName=" + actionNam + "&cul=en-US&Pdsuri=<%=pdsUri%>&SkDii=<%=skdii%>&RHS=" + clientIdhidRHS, "_default", "status=no,width=830,height=500,top=100");
    }
    function setTagValue(exprnvalue, connectionName, name, isMultivalue)
    {
    
        var textFueldId = document.getElementById('hidtxtParamId').value;       
        if(document.getElementById('hidActualMultiValueParamId')!=null && isMultivalue =="yes")
        {
            document.getElementById(document.getElementById('hidActualMultiValueParamId').value).value = exprnvalue.replace(/,/g,"#$#");
        }
        if(document.getElementById(textFueldId) != null)
        {
         try{
                if(document.getElementById('hidtxtParamId')!= null &&
                document.getElementById('hidFullValueId')!= null &&
                document.getElementById('hidModeId')!= null && 
                document.getElementById('hidImageId')!= null)
                {
                    clearExp(document.getElementById('hidtxtParamId').value, document.getElementById('hidFullValueId').value, document.getElementById('hidModeId').value, document.getElementById('hidImageId').value)
                } 
            }
            catch(r)
            {
            
            }
            if(name == 'TimeZone')
            {
                SetValueToNumberControl(document.getElementById(textFueldId.replace("txtParam","rnt")), exprnvalue);
            }
            else{
            
                document.getElementById(textFueldId).value = exprnvalue;
                if(isMultivalue =="yes")
                {
                 document.getElementById(textFueldId).setAttribute("disabled", "disabled");
                }
            }
        }
        if(connectionName != null & connectionName != "")
        {
            if(name == 'Historian')
            {
                document.getElementById("<%=historianConnectionName.ClientID%>").value = connectionName;
            }
            if(name == 'TimeZone')
            {
                document.getElementById("<%=historianConnectionNameforTimeZone.ClientID%>").value = connectionName;
            }
        }
    }
    function setExpression(exprnvalue) 
    {
        if (exprnvalue != "") {
            document.getElementById(document.getElementById('hidImageId').value).style.visibility = "visible";
            document.getElementById(document.getElementById('hidModeId').value).value = "Expression";
            document.getElementById(document.getElementById('hidtxtParamId').value).setAttribute("disabled", "disabled");
            if(document.getElementById('hidParamName').value.toLowerCase() == 'tagname')
            {
                document.getElementById("<%=historianConnectionName.ClientID%>").value = "";
            }
            if(document.getElementById('hidParamName').value.toLowerCase() == 'timezoneid')
            {
                document.getElementById("<%=historianConnectionNameforTimeZone.ClientID%>").value = "";
            }
            SetExpressionForControls(document.getElementById('hidtxtParamId').value.replace("txtParam",""), document.getElementById('hidParamType').value, "T", document.getElementById('hidMutivalueParam').value);
        }
        
        document.getElementById(document.getElementById('hidFullValueId').value).setAttribute("value", exprnvalue);
        var tempMultivalueExp = exprnvalue.split("#@#");
        var multivalueExpr = tempMultivalueExp[0].split("#$#");
        var finalModifiedExprn =  "";
        var replacedExprn = "";
        var notReplacedExprn="";
        for (j=0 ;j< multivalueExpr.length;j++)
        {
             replacedExprn ="";
             notReplacedExprn ="";
        if(multivalueExpr[j].indexOf("{\"DisplayExpressionString") != -1)
        {
        var valueExpr = multivalueExpr[j];
        var str1 = valueExpr.replace(/["{}]/gi, "").split(/\n/g)
        for (i = 0; i < str1.length; i++) 
        {
            var str2 = str1[i].split(':');
            if (str2[0] == "DisplayExpressionString")
             {
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
            
               replacedExprn =newExprn;
           }
               
        else
         {
             notReplacedExprn = newExprn;
          }       
        }
        else
        {
            notReplacedExprn = multivalueExpr[j];
        }
        if(notReplacedExprn == "")
        {
            notReplacedExprn = "string.empty";
        }
        if(replacedExprn!="")
        {
            var finalExprn= replacedExprn;
        }
        else
        {
            finalExprn = notReplacedExprn;
        }
         
           finalExprn = finalExprn.replace(/^\s+/, '').replace(/\s+$/, '');
            if(finalModifiedExprn == "")
            {
             finalModifiedExprn = finalExprn;
             }
             else
             {
                finalModifiedExprn = finalModifiedExprn+"#$#"+finalExprn;
             }
     }
        if(finalModifiedExprn !="" || finalModifiedExprn!=null)
        {
             finalModifiedExprn = finalModifiedExprn.replace(/string.empty/g, "");
            var tempvar = finalModifiedExprn.split("#@#");
            document.getElementById(document.getElementById('hidtxtParamId').value).value= tempvar[0].replace(/#\$\#/g, ',');
            if(tempMultivalueExp.length == 2)
            {
                document.getElementById(document.getElementById('hidActualMultiValueParamId').value).value = finalModifiedExprn + "#@#" + "FMW";
            }
            else
            {
                document.getElementById(document.getElementById('hidActualMultiValueParamId').value).value = finalModifiedExprn; 
            }
        }
      
    }
    function SetExpressionForControls(number, type, isExpression, multiValue)
    {
  
        if(isExpression == "T")
        {
            document.getElementById("txtParam" + number).style.display = '';
            if(multiValue != "yes")
            {
            switch(type)
            {
                case "boolean":
                    document.getElementById("rbl" + number).style.display = 'none';
                    break;
                case "datetime":
                    ShowHideDateTimePicker(GetDateTimePickerControl("dtp" + number), false);
                    break;
                case "integer":
                case "float":
                    ShowHideNumberControl(GetNumberControl("rnt" + number), false);
                    break;
            }
            }
            else
            {
                document.getElementById("txtParam" + number).disabled = true;
            }
            var chkObj = GetChkNullObject(number);
            if(chkObj != null)
            {
                chkObj.style.display = 'none';
                document.getElementById("lblnull" + number).style.display = 'none';
            }
        }
        else
        {
            
            if(multiValue != "yes")
            {
            document.getElementById("txtParam" + number).style.display = 'none';
            switch(type)
            {
                case "boolean":
                    document.getElementById("rbl" + number).style.display = '';
                    break;
                case "datetime":
                    ShowHideDateTimePicker(GetDateTimePickerControl("dtp" + number), true);
                    break;
                case "integer":
                case "float":
                    ShowHideNumberControl(GetNumberControl("rnt" + number), true);
                    break;
                default:
                document.getElementById("txtParam" + number).style.display = '';
                break;
            }
            }
            else
            {
                 document.getElementById("txtParam" + number).disabled = true;
            }
            
            var chkObj = GetChkNullObject(number);
            if(chkObj != null)
            {
                chkObj.style.display = '';
                document.getElementById("lblnull" + number).style.display = '';
                if(chkObj.checked == true)
                {
                    document.getElementById("txtParam" + number).disabled = true;
                }
            }
        }
    }
    function setChAt(str, index, chr) {
        if (index > str.length - 1) return str;
        return str.substr(0, index) + chr + str.substr(index + 1);
    }
    function ltrim(s) {
        return s.replace(/^\s*/, "");
    }
    function rtrim(s) {
        return s.replace(/\s+$/, "");
    }
    function clearExp(txtParamId, hiddenFullValueId, hiddenModeId, clearImgId, hidActualMultiValueParamId)
    {
            document.getElementById('hidtxtParamId').value = "";
            document.getElementById('hidFullValueId').value = "";
            document.getElementById('hidModeId').value = "";
            document.getElementById('hidImageId').value = "";
            document.getElementById('hidActualMultiValueParamId').value ="";

            if (document.getElementById(txtParamId) != null) {
                document.getElementById(txtParamId).value = "";
                document.getElementById(txtParamId).disabled = "";
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

            if (document.getElementById(hidActualMultiValueParamId) != null) {
                document.getElementById(hidActualMultiValueParamId).value = "";
            }
    }
    function clearExpression(txtParamId, hiddenFullValueId, hiddenModeId, clearImgId, paramType, hidActualMultiValueParamId) 
    {
        se.ui.messageDialog.showConfirmation("<%= sr.GetString("processdesigner_activity_setparam_popup_title")%>",'<%= sr.GetString("processdesigner_activity_delte_expression")%>',function(conf){
            if (conf) 
            {
                var number = txtParamId.replace("txtParam","");
                var type = document.getElementById("hiddenParamType" + number).value;
                clearExp(txtParamId, hiddenFullValueId, hiddenModeId, clearImgId, hidActualMultiValueParamId);
                SetExpressionForControls(number, type, "F", paramType);
            }
        });
    }
   // SetTextBoxReadOnly();
    setTimeout(SetTextBoxReadOnly, 0);
    function SetTextBoxReadOnly()
    {
           var radio = document.getElementsByName("<%=RadioVariableCreation.ClientID%>");
            for (var ii = 0; ii < radio.length; ii++)
            {
                if (radio[ii].checked) {
                    var textBox;
                    textBox = document.getElementById("<%=TextBoxManualVariable.ClientID%>");
                    if (radio[ii].value == "2") 
                    {

                        if (textBox != null) 
                        {
                            textBox.disabled = "";
                        }
                    }
                    else {
                        if (textBox != null) {
                        var dropDownobj = $find('<%= drpdwnReportTemplate.ClientID %>');
                            textBox.setAttribute("disabled", "disabled");
                            if (dropDownobj != null && dropDownobj.get_selectedItem().get_text() != "--Select--") {
                                if (ltrim(rtrim(document.getElementById("<%=HiddenActionName.ClientID %>").value)) != ""){
                                    textBox.value = dropDownobj.get_selectedItem().get_text() + "_" + document.getElementById("<%=HiddenActionName.ClientID %>").value;
                                }
                                else
                                {
                                    textBox.value = dropDownobj.get_selectedItem().get_text() + "_" + "ReportGenerator";
                                }
                            }
                            else {
                                textBox.value = "";
                            }
                            
                        }
                    }
                }
            }
        }
        function GetSelectedValue() {
            var radio = document.getElementsByName("<%=RadioVariableCreation.ClientID%>");
            for (var ii = 0; ii < radio.length; ii++) {
                if (radio[ii].checked) {
                    return radio[ii].value;
                }
            }
        }
        function Validate()
         {
           var dropDownobj = $find('<%= drpdwnReportTemplate.ClientID %>');
            var totalPAramCount = document.getElementById("<%= hiddenNumberofParam.ClientID%>").value;
            var alertValue="";
            var count;
            if (dropDownobj.get_selectedItem() == null || dropDownobj.get_selectedItem().get_text() == "--Select--") {
                if (alertValue != "") {
                    alertValue = alertValue + "\n" + '<%= sr.GetString("ssrs_process_designer_ssrstemplate_msg")%>';
                }
                else {
                    alertValue = '<%= sr.GetString("ssrs_process_designer_ssrstemplate_msg")%>';
                }
            }
            //
            for(count=0; count < totalPAramCount; count++){
                var id = 'hiddenMandatory' + count;
                if (document.getElementById(id) != null && rtrim(ltrim(document.getElementById(id).value)) == "YES") {
                    var textboxid = 'txtParam' + count;
                    var type = document.getElementById('hiddenParamType' + count).value;
                    var mode = document.getElementById('hiddenMode' + count).value;
                    var textValue = "";
                    if(mode != "Expression")
                    {
                        switch(type)
                        {
                            case "boolean":
                                textValue = GetSelectedValueFromRadioButtonList("rbl" + count, "");
                            break;
                            case "datetime":
                                textValue = window["dtp" + count].GetDate();
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
                    }
                    else{
                        textValue = document.getElementById(textboxid).value;
                    }
                    
                    if (textValue == "") {
                        var paramName = 'hiddenParamName' + count;
                        if (document.getElementById(paramName) != null) {
                        var messageVal = '<%= sr.GetString("ssrs_process_designer_ssrsreportparam_msg")%>';
                        messageVal = messageVal.replace("{0}",document.getElementById(paramName).value);
                            if (alertValue != "") {
                                alertValue = alertValue + "\n" + messageVal;
                            }
                            else {
                                alertValue = messageVal;
                            }
                        }
                    }
                    
                }
            }
            
            if (GetSelectedValue() == 2) {
                if (document.getElementById("<%=TextBoxManualVariable.ClientID%>") != null && rtrim(ltrim(document.getElementById("<%=TextBoxManualVariable.ClientID%>").value)) == "") {
                    if (alertValue != "") {
                    alertValue = alertValue + "\n" + '<%= sr.GetString("ssrs_process_designer_variablename_msg")%>';
                    }
                    else{
                    alertValue = '<%= sr.GetString("ssrs_process_designer_variablename_msg")%>';
                    }
                }
            }
            
            if (alertValue == "") {
           var valueString = CreateValueString();
               // valueString = valueString.split("#%#");
                document.getElementById("<%=hiddenParamStringValue.ClientID %>").value = valueString;//valueString[0];             
                if(document.getElementById("chkShowHidden") != null && document.getElementById("chkShowHidden").checked == true)
                {
                    document.getElementById("<%=isHiddenIncluded.ClientID %>").value = "yes";
                }
                else
                {
                    document.getElementById("<%=isHiddenIncluded.ClientID %>").value = "no";
                }
               return true;
            }
            else {
                se.ui.messageDialog.showError("<%= sr.GetString("processdesigner_activity_setparam_popup_title")%>",alertValue);
                return false;
            }
        }
        function CreateValueString() 
        {
            var paramValueString;
            var paramSeparator;
            var paramValueSeparator;
            var paramSeparator;
            var multiValueIdString="";
            paramValueSeparator = "<%=_ValueSeparetor %>";
            paramSeparator = "<%=_ParamSeparetor %>";
            var totalPAramCount = document.getElementById("<%= hiddenNumberofParam.ClientID%>").value;
            for (count = 0; count < totalPAramCount; count++)
             {

                var id;
                var dataValueId;
                var hidMultivalueId;
                var paramName;
                var actualValue;
                var mode;
                var paramType;
                var expMode;               
                
                paramType  = document.getElementById("hiddenParamHidden" + count).value;
                id = 'hiddenMode' + count;
               
                 hidMultivalueId ="hidFromMultiValueParam" + count;
                if (document.getElementById(id).value == "Expression") 
                {
                    dataValueId = "hiddenFullValue" + count;
                    mode = "EXPRESSION";                   
                    actualValue = document.getElementById(dataValueId).value;
                }
                else {
                    dataValueId = "txtParam" + count;
                    mode = "TEXT";
                    var pramType = document.getElementById("hiddenParamType" + count).value;
                    var chkNullObj= GetChkNullObject(count);
                    
                    if((chkNullObj !=null) && (chkNullObj.checked == true))
                    {
                        actualValue = "@!NULL!@";
                    }
                    else
                    {
                        switch(pramType)
                        {
                            case "boolean":
                                actualValue = GetSelectedValueFromRadioButtonList("rbl" + count, "");
                            break;
                            case "datetime":
                                actualValue = window["dtp" + count].GetDate();
                                actualValue = GetDateFormated(actualValue);
                            break;
                            case "integer":
                            case "float":
                                actualValue = GetValueFromNumberControl("rnt" + count, "");
                            break;
                            default:
                            //This for Multivalue Param get the actual value not the comma separated value
                            if(document.getElementById("hiddenActualMutivalue"+ count)!= null && document.getElementById("hiddenActualMutivalue"+ count).value != null && document.getElementById("hiddenActualMutivalue"+ count).value!="")
                            {
                                 actualValue = document.getElementById("hiddenActualMutivalue"+ count).value;
                            }
                            else
                            {
                                actualValue = document.getElementById(dataValueId).value;
                            }
                            break;
                        }
                    }
               }
                paramName = rtrim(ltrim(document.getElementById('hiddenParamName' + count).value));
             if(paramType != "Y" ||  (paramType == "Y" && actualValue != ""))
                {
                    if (paramValueString == null || paramValueString == "")
                     {
                        
                        paramValueString = paramName + paramValueSeparator + mode + paramValueSeparator + actualValue + paramValueSeparator + pramType;
                    }
                    else
                     {
                        paramValueString = paramValueString + paramSeparator + paramName + paramValueSeparator + mode + paramValueSeparator + actualValue + paramValueSeparator + pramType;
                    }

                }
            }
            return paramValueString; //+ "#%#" + multiValueIdString;
        }
        function GetDateFormated(actualValue)
        {
            try{
                return actualValue.getFullYear() + "-" + (actualValue.getMonth() + 1) + "-" + actualValue.getDate() + "-" + actualValue.getHours() + "-" + actualValue.getMinutes() + "-" + actualValue.getSeconds() + "-" + actualValue.getMilliseconds();
            }
            catch(r)
            {
                return "";
            }
        }
        function GetValueFromNumberControl(controlId, defaultValue)
        {
            try{
                return window[controlId].GetValue();
            }
            catch(r)
            {
                return defaultValue;
            }
        }
        function SetParamIfValuePresent() 
        {
           var totalPAramCount = document.getElementById("<%= hiddenNumberofParam.ClientID%>").value;
           if (totalPAramCount != null && totalPAramCount > 0) {
               var paramValueString = document.getElementById("<%=hiddenParamStringValue.ClientID %>").value;
               if (paramValueString != null && paramValueString != "") {
                   for (count = 0; count < totalPAramCount; count++) {
                    if (document.getElementById('hiddenParamName' + count) != null) 
                    {
                           var loadedParameterName = rtrim(ltrim(document.getElementById('hiddenParamName' + count).value));
                           var params = paramValueString.split("<%=_ParamSeparetor %>");
                           if (params != null && params.length > 0) {
                               var isMatch = false;
                               for (countParam = 0; countParam < params.length; countParam++) 
                               {
                                   var paramName;
                                   var mode;
                                   var actualValue;
                                   var paramSplit = params[countParam].split("<%=_ValueSeparetor %>");
                                   if (paramSplit != null && paramSplit.length == 4) 
                                   {
                                       paramName = ltrim(rtrim(paramSplit[0]));
                                       mode = paramSplit[1];
                                       actualValue = paramSplit[2];
                                       if (loadedParameterName == paramName) 
                                       {

                                           if (mode == "TEXT") {
                                                SetParamValue("TEXT", count, actualValue);
                                                isMatch = true;
                                           }
                                           else 
                                           {
                                                SetParamValue("EXPRESSION", count, actualValue);
                                               if (document.getElementById('hidImageId') != null) {
                                                   document.getElementById('hidImageId').value = "ClearAllImg" + count;
                                               }
                                               if (document.getElementById('hidModeId') != null) {
                                                   document.getElementById('hidModeId').value = "hiddenMode" + count;
                                               }
                                               if (document.getElementById('hidtxtParamId') != null) {
                                                   document.getElementById('hidtxtParamId').value = "txtParam" + count;                                                   
                                               }
                                               if (document.getElementById('hidFullValueId') != null) {
                                                   document.getElementById('hidFullValueId').value = "hiddenFullValue" + count;
                                               } 
                                                if (document.getElementById('hidActualMultiValueParamId') != null) {
                                                   document.getElementById('hidActualMultiValueParamId').value = "hiddenActualMutivalue" + count;
                                               } 
                                                if (document.getElementById('hidFromMultiValueId') != null)
                                                 {
                                                   document.getElementById('hidFromMultiValueId').value = "hidFromMultiValueParam" + count;                                                   
                                               }                                             
                                               setExpression(actualValue);
                                               isMatch = true;
                                           }
                                       }
                                   }
                               }
                               if(isMatch == false)
                               {
                                    SetParamValue("TEXT", count, "");
                               }
                           }
                           else
                           {
                                SetParamValue("TEXT", count, "");
                           }
                       }
                   }
               }
               else{
                        for (count = 0; count < totalPAramCount; count++) {
                            LoadParametersFirstTime(count);
                        }
               }
           }
        }
        SetParamIfValuePresent();
        function SetParamValue(mode, count, actualValue)
        {
        
            if(document.getElementById("hiddenParamType" + count)!= null)
            {
                var type = document.getElementById("hiddenParamType" + count).value;
                switch(type)
                {
                    case "boolean":
                     if(document.getElementById("rbl" + count) != null)
                     {
                        if(mode == "TEXT")
                        {
                            document.getElementById("rbl" + count).style.display = '';
                            if(actualValue == "@!NULL!@")
                            {
                                SetRadioButtonListEnabled("rbl" + count, false);
                            }
                            else
                            {
                                SetRadioButtonListValue("rbl" + count, actualValue);
                            }
                        }
                        else
                        {
                            document.getElementById("rbl" + count).style.display = 'none';
                        }
                     }
                    break;
                    case "datetime":
                    if(document.getElementById("dtp" + count) != null)
                     {
                        if(mode == "TEXT")
                        {
                            ShowHideDateTimePicker(GetDateTimePickerControl("dtp" + count),true);
                            if(actualValue == "@!NULL!@")
                            {
                                EnableDateTimePicker(GetDateTimePickerControl("dtp" + count), false);
                            }
                            else
                            {
                                SetValueToDateTimeControlFromString(GetDateTimePickerControl("dtp" + count), actualValue);
                            }
                        }
                        else
                        {
                            ShowHideDateTimePicker(GetDateTimePickerControl("dtp" + count),false);
                        }
                     }
                    break;
                    case "integer":
                    case "float":
                    if(document.getElementById("rnt" + count) != null)
                     {
                        if(mode == "TEXT")
                        {
                            ShowHideNumberControl(GetNumberControl("rnt" + count),true);
                            if(actualValue == "@!NULL!@")
                            {
                                EnableNumberControl(GetNumberControl("rnt" + count), false);
                            }
                            else
                            {
                                SetValueToNumberControl(GetNumberControl("rnt" + count), actualValue);
                            }
                        }
                        else
                        {
                            ShowHideNumberControl(GetNumberControl("rnt" + count),false);
                        }
                     }
                    break;
                    default:
                    if(document.getElementById("txtParam" + count) != null)
                    {
                        if(mode == "TEXT")
                        {
                            document.getElementById("txtParam" + count).style.display = '';
                            if(actualValue == "@!NULL!@")
                            {
                                document.getElementById("txtParam" + count).disabled = true;
                            }
                            else
                            {
                                var tempActualValue = actualValue.split("#@#");
                                if(tempActualValue.length == 2)
                                {
                                   document.getElementById("hiddenActualMutivalue" + count).value = actualValue;
                                }
                                document.getElementById("txtParam" + count).value = tempActualValue[0].replace(/#\$\#/g, ',');
                            }
                        }
                        else
                        {
                            document.getElementById("txtParam" + count).style.display = '';
                        }
                    }
                    break;
                }
                if(mode == "TEXT")
                {
                    switch(type)
                    {
                        case "boolean":
                        case "datetime":
                        case "integer":
                        case "float":
                        if(document.getElementById("txtParam" + count) != null)
                        {
                            document.getElementById("txtParam" + count).style.display = 'none';
                        }
                        break;
                    }
                    if(document.getElementById("chk" + count)!=null)
                    {
                        document.getElementById("chk" + count).checked = (actualValue == "@!NULL!@");
                    }
                }
                else
                {
                    if(document.getElementById("chk" + count)!=null)
                    {
                        document.getElementById("chk" + count).style.display = 'none';
                        document.getElementById("lblnull" + count).style.display = 'none';
                    }
                }
            }
        }
        function LoadParametersFirstTime(count)
        {
        
            if(document.getElementById("hiddenParamType" + count)!= null)
            {
                if(document.getElementById("hidMutivalueParam" + count)!=null && document.getElementById("hidMutivalueParam" + count).value!="yes")
                {
                var type = document.getElementById("hiddenParamType" + count).value;
                switch(type)
                {
                    case "boolean":
                     if(document.getElementById("rbl" + count) != null)
                     {
                        document.getElementById("rbl" + count).style.display = '';
                     }
                    break;
                    case "datetime":
                    if(document.getElementById("dtp" + count) != null)
                     {
                        ShowHideDateTimePicker(GetDateTimePickerControl("dtp" + count),true);
                     }
                    break;
                    case "integer":
                    case "float":
                    if(document.getElementById("rnt" + count) != null)
                     {
                        ShowHideNumberControl(GetNumberControl("rnt" + count),true);
                     }
                    break;
                    default:
                    if(document.getElementById("txtParam" + count) != null)
                    {
                       document.getElementById("txtParam" + count).style.display = '';
                    }
                    break;
                    
                }
                }
                switch(type)
                {
                    case "boolean":
                    case "datetime":
                    case "integer":
                    case "float":
                    if(document.getElementById("txtParam" + count) != null)
                    {
                        document.getElementById("txtParam" + count).style.display = 'none';
                    }
                    break;
                }
            }
        }
    function ShowImageAnimation(sender, eventArgs) {
                document.getElementById("lblWait").style.visibility = "visible";      
            if (document.getElementById("<%=hiddenParamStringValue.ClientID %>") != null) {
                document.getElementById("<%=hiddenParamStringValue.ClientID %>").value = "";
            }
        }
    function openhelpwin()
    {
        window.open('<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(ProcessDesignerControl.GetHelpPageUrl(), false)%>ConfigureSSRSTemplate.html','helpwin','height = 450, width = 600,scrollbars=yes,resizable=yes');    
    }
    //------------------------------------------------
    // Rad Date Time Popup based on parent boundaries
    //
  
    
    function GetSelectedValueFromRadioButtonList(controlId, defaultValue)
    {
        try
        {
            var selectedValue = defaultValue;
            var f = document.forms[0];
            var e = f.elements[controlId];

            for (var i = 0; i < e.length; i++)
            {
                if (e[i].checked)
                {
                    selectedValue = e[i].value;
                    break;
                }
            }

            return selectedValue;
        }
        catch (err)
        {
            return defaultValue;
        }
    }

    function SetRadioButtonListEnabled(controlId, _enable)
    {
        var radioControl = document.forms[0].elements[controlId];

        for (var i = 0; i < radioControl.length; i++)
        {
            radioControl[i].disabled = !_enable;
        }
    }

    function SetRadioButtonListValue(controlId, setValue)
    {
        var radioControl = document.forms[0].elements[controlId];
        
        for (var i = 0; i < radioControl.length; i++)
        {
            if (radioControl[i].value == setValue)
            {
                radioControl[i].checked = true;
            }
            else
            {
                radioControl[i].checked = false;
            }
        }
    }
    function GetDateTimePickerControl(id)
    {
        return document.getElementById(id);
    }

    function ShowHideDateTimePicker(cntrl, _show)
    {
        var wrapperObj = document.getElementById(cntrl.id + "_wrapper");
        if (_show == true)
        {
            wrapperObj.style.display = "inline";
        }
        else
        {
            wrapperObj.style.display = "none";
        }
    }
    
    function EnableDateTimePicker(cntrl, _enable)
    {
        if (_enable == true)
        {
            window[cntrl.id].DateInput.Enable();
            window[cntrl.id].PopupButton.style.display = GetDisplayBlockString();
            window[cntrl.id].TimePopupButton.style.display = GetDisplayBlockString();
        }
        else
        {
            window[cntrl.id].DateInput.Disable();
            window[cntrl.id].PopupButton.style.display = "none";
            window[cntrl.id].TimePopupButton.style.display = "none";
        }
    }
    
    function SetValueToDateTimeControl(dateTimeCntrl, _dateObject)
    {
        window[dateTimeCntrl.id].SetDate(_dateObject);
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
        return document.getElementById(id);
    }
    
    function ShowHideNumberControl(cntrl, _show)
    {        
        var wrapperObj = document.getElementById(cntrl.id + "_wrapper");
        
        if (_show == true)
        {
            wrapperObj.style.display = "";
        }
        else
        {
            wrapperObj.style.display = "none";
        }
    }
    
    function EnableNumberControl(cntrl, _enable)
    {
        if (_enable == true)
        {
            window[cntrl.id].Enable();
        }
        else
        {
            window[cntrl.id].Disable();
        }
    }
    
    function SetValueToNumberControl(numberControl, _value)
    {
        window[numberControl.id].SetValue(_value);
    }
    function chkNull_OnClick(sender)
    {
        SetNullableToUI(sender.id.replace("chk", ""));
    }
    function chkShowHidden_OnClick(sender)
    {
        if((sender.checked))
        {
            if(document.getElementById("tblHidden")!=null)
            {
                document.getElementById("tblHidden").style.display = '';
                document.getElementById("hiddenCheckboxdiv").style.disply = '';
            }
            if(document.getElementById("tblNonHiddennotPresentLable") != null)
            {
                document.getElementById("tblNonHiddennotPresentLable").style.display = 'none';
            }
        }
        else{
            if(document.getElementById("tblHidden")!=null)
            {
                document.getElementById("tblHidden").style.display = 'none';
                document.getElementById("hiddenCheckboxdiv").style.disply = 'none';
            }
            if(document.getElementById("tblNonHiddennotPresentLable") != null)
            {
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
        catch(err)
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
        txtParm.disabled = ((chkNull != null) && (chkNull.checked == true));
        
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
</script>


