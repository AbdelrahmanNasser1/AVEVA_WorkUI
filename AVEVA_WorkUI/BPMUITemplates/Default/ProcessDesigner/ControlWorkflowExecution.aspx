<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.PropertyTypes.ControlWorkflowExecution" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html>
<html>
<head id="Head1">
    
    <title><%:PageTitle%></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
      <style>
        html, body {
            height: 100%;
            width: 100%;
            overflow: hidden;
        }

  
    </style>
    <link href="<%:bellyBarPath%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
     <script language="javascript" type="text/javascript">
         function AlertWorkflowMessages(message) {
             //setTimeout("alert(\"" + message + "\")", 500);
             setTimeout(se.ui.messageDialog.showError('<%=PageTitle%>', message), 500);
         }
         function AlertSuccessSubmit(message) {
             //setTimeout("alert(\"" + message + "\")", 500);
             setTimeout(se.ui.messageDialog.showAlert('<%=PageTitle%>', message), 500)
         }
         function CloseWorkflowWindow() {
             window.setTimeout('window.opener.refreshselectedaction()', 100);
             window.opener.parent._skProcessDesigner.RefreshProperties();
             window.setTimeout('window.close()', 100);
         }
    </script>
</head>
<body style="margin:10px">
    <script>
        se.ui.messageDialog.setGlobalOptions({
            localization: { // All localization related default can be set
                closeButtonCaption: "<%=_resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                okButtonCaption: "<%=_resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                cancelButtonCaption: "<%=_resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                showDetailsCaption: "<%=_resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                hideDetailsCaption: "<%=_resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
            }
        });
    </script>
    <form id="frmControlWorkflowExecution" runat="server">
        <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
         </telerik:RadScriptBlock>
         <telerik:RadScriptManager ID="RadScriptManager1" runat="server" />
        <telerik:RadScriptBlock ID="RadScriptBlock2" runat="server">
        <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ProcessDesignerControl.GetCommonRelativeUrl("stylesheet/Global.css"))%>" rel="stylesheet" type="text/css" />
        <link href="<%=ProcessDesignerControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css")%>" rel="stylesheet" type="text/css" />
        <link href="<%=ProcessDesignerControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css")%>" rel="stylesheet" type="text/css" /> 
       </telerik:RadScriptBlock>
        <table cellpadding="0" cellspacing="0" border="0" style="height:100%;width:98%;">
            <tr>
                <td valign="middle" style="height:25px">
                    <table cellspacing="0" cellpadding="0" border="0" width="100%">
                        <tr>
                            <td valign="middle" height="25" >
                                <span class="fontheading" runat="server" id="spanWFDetails">
                                  Workflow Details
                                </span>
                            </td>
                            <td valign="middle">
                                <span title="Help" ><telerik:RadCodeBlock runat="server" ID="RadCodeBlock2">
                                    <img src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ProcessDesignerControl.GetCommonRelativeUrl("Images/main-help.gif"))%>"
                                        align="right" style="cursor: pointer" alt="Help" <%=HelpImageTags%>/></telerik:RadCodeBlock>
                                </span>
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td  style="height:5px">
                </td>
            </tr>
            <tr>
                <td style="height:10px; background-color:White;">  
                    <table cellspacing="0" cellpadding="0" border="0" width="100%" >
                        <tr>
                            <td style="width:5px">
                            </td>
                            <td>
                                <span class="description"  runat="server" id="spanActivityDetails">
                                    To abort the child workflow, either select the name of child workflow or the name of workflow activity associated with it.
                                    User can select 'Specify workflow name/Specify activity name' from the drop down and assign variable to it using the expression editor. 
                                </span>  
                            </td>
                            <td style="width:3px">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td  style="height:5px">
                </td>
            </tr>
            <tr>
                <td align="left" valign="top">
                    <telerik:RadAjaxPanel ID="radAjaxPanelWorkflowDetails" runat="server" EnableAJAX="true">
                   <telerik:RadCodeBlock runat="server" ID="RadCodeBlock1">
                    <div style="width:100%;overflow:auto;height:400px;">
                    <table width="100%" border="0" cellspacing="2" cellpadding="6" align="center"  class="tablebg" >
                         <tr>
                            <td class="lefttdbg" align="left"  valign="top" style="width:40%">
                                <span class="subtitle" runat="server" id="spanSelectWorkflow">Select Workflow</span>
                                <img alt="Mandatory" id="img4" runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/Images/mandatoryicon.png%>" hspace="2" align="top" visible="true" />
                                <br/>
                                <span class="description" runat="server" id="spanSelectWorkflowDesc">Select either "Child workflow name" or "Worfklow activity name" to which the workflow is associated.</span> 
                            </td>
                            <td class="righttdbg" style="width:60%">
                                <asp:RadioButtonList ID="rdWorkflowName" AutoPostBack="true" runat="server" CssClass="inputradio">
                                </asp:RadioButtonList>
                            </td>
                         </tr>
                         <tr>
                             <td class="lefttdbg" align="left"  valign="top">
                                  <span class="subtitle" runat="server" id="spanChildWFName">Child Workflow Name</span>
                                  <br/>
                                  <span class="description"  runat="server" id="spanChildWFNameDesc">Select child workflow which needs to be aborted.</span> 
                             </td>
                             <td class="righttdbg">
                                <table width="100%" border="0" cellspacing="2" cellpadding="2" align="left">
                                    <tr>
                                        <td style="width:55%">
                                            <telerik:RadComboBox ID="radCmbChildWorkflowName" runat="server" AutoPostBack="true" Skin="AWTCombobox" Width="245px" RenderMode="Classic"
                                                 ErrorMessage="" ShowWhileLoading="false" Enabled="false" Height="100px" AllowCustomText="true" MarkFirstMatch="true" EnableEmbeddedSkins="false"
                                                OnClientItemsRequestFailed="AfterClientCallBackError">
                                            </telerik:RadComboBox>
                                         </td>
                                        <td style="width:30%">
                                            <asp:TextBox ID="txtChildWorkflowName" runat="server" CssClass="inputtext" Width="130px" ></asp:TextBox>
                                        </td>
                                        <td style="width:15%">
                                            <span style="width: 5px;"></span><img alt="" id="imgPdChildWorkflowName"
                                                    onmousemove="this.style.cursor='hand'"
                                                    onclick="openEditorControlRunTime('ChildWorkflowName');"
                                                    runat="server"
                                            />
                                            &nbsp;<img style="visibility:hidden;" id="imgClearChildWorkflowName" alt="" onmousemove="this.style.cursor='hand'" onclick="clearExpression('ChildWorkflowName');" runat="server"/>
                                        </td>
                                    </tr>
                                </table>
                             </td>
                         </tr>
                         <tr>
                             <td class="lefttdbg" align="left"  valign="top" >
                                  <span class="subtitle" runat="server" id="spanWFActivityName">Workflow Activity Name</span>
                                  <br/>
                                  <span class="description" runat="server" id="spanWFActivityNameDesc">Select workflow activity to which child workfklow is associated and will be aborted.</span> 
                             </td>
                             <td class="righttdbg">
                                 <table width="100%" border="0" cellspacing="2" cellpadding="2" align="left">
                                    <tr>
                                        <td style="width:55%">
                                             <telerik:RadComboBox ID="radCmbWorkflowActivity" runat="server" AutoPostBack="true" Skin="AWTCombobox" Width="245px" RenderMode="Classic"
                                                 ErrorMessage="" ShowWhileLoading="false" Enabled="false" Height="100px" AllowCustomText="true" MarkFirstMatch="true" EnableEmbeddedSkins="false"
                                                OnClientItemsRequestFailed="AfterClientCallBackError"></telerik:RadComboBox>                                          
                                        </td>
                                        <td style="width:30%">
                                            <asp:TextBox ID="txtWorkflowActivity" runat="server" CssClass="inputtext" Width="130px" ></asp:TextBox>
                                        </td>
                                        <td style="width:15%">
                                            <span style="width: 5px;"></span><img alt="" id="imgPdWorkflowActivity"
                                                    onmousemove="this.style.cursor='hand'"
                                                    onclick="openEditorControlRunTime('WorkflowActivityName');"
                                                    runat="server"
                                            />
                                            &nbsp;<img style="visibility:hidden;" id="imgClearWorkflowActivity" alt="" onmousemove="this.style.cursor='hand'" onclick="clearExpression('WorkflowActivityName');" runat="server"/>
                                        </td>
                                    </tr>
                                </table>
                             </td>
                         </tr>
                     </table>
                     </div> 
                       </telerik:RadCodeBlock>
                    </telerik:RadAjaxPanel>
                   
                 </td>
            </tr>
            <tr>
                <td style="height:10px">
                </td>
            </tr>
            
        </table>

        <table style="width:100%;padding:5px;">
            <tr>
                <td style="vertical-align:top;height:25px;padding-right:10px;">
                    <table width="100%" border="0" cellspacing="2" cellpadding="2" >
                        <tr>
                            <td style="text-align:right" width="90%">
                                <asp:Button ID="btnClose" runat="server" Text="Close"  class="inputsecondarybutton" tabindex="22" />
                            </td>
                            <td style="text-align:right" width="10%">
                                <asp:Button ID="btnClear" runat="server" Text="Clear"  class="inputsecondarybutton" tabindex="22" />
                            </td>
                            <td style="text-align:right" width="10%">
                                <asp:Button ID="btnUpdate" runat="server" Text="Update"  class="inputbutton" tabindex="22" />
                            </td>
                        </tr>
                   </table>   
                </td>
            </tr>
        </table>
    <input id="hidradCmbParamName" type="hidden" runat="server" />
    <input id="hidradChildWorkflowName" type="hidden" runat="server" />
    <input id="hidradWorkflowActivityName" type="hidden" runat="server" />
    </form>
</body>
</html>
 <script type="text/javascript">
     var expbuilderURl = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(ExpbuilderURl, false)%>";
     var clearExpressionMessage = "<%=ClearExpressionMessage%>";
      /// <summary>
      /// Opens the Expression editor
      /// </summary>
      function openEditorControlRunTime(paramName) {
          hidradCmbParamName = paramName;
          expbuilderURl = expbuilderURl.replace("ControlWorkflowExecution.aspx", "ExpressionEditor.aspx");
          var expressionValue = "";
          var finalURL = "";
          if (hidradCmbParamName == "ChildWorkflowName") {
              if (document.getElementById("txtChildWorkflowName").getAttribute("disabled") == true)
                  return;
              expressionValue = "hidradChildWorkflowName";
          }
          else if (hidradCmbParamName == "WorkflowActivityName") {
          if (document.getElementById("txtWorkflowActivity").getAttribute("disabled") == true)
                  return;
              expressionValue = "hidradWorkflowActivityName";
          }
          if (expressionValue != "") {
              finalURL = expbuilderURl + "&RHS=" + expressionValue;
          }
          else {
              finalURL = expbuilderURl;
          }
          window.open(finalURL, "_default", "status=no,width=830,height=500,top=250,left=250");
      }
      /// <summary>
      /// When the expression editor is closed, this method is called.
      /// </summary>
      function setExpression(exprnvalue) {
          if (exprnvalue == "") {
              return;
          }
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
          }
          if (hidradCmbParamName == "ChildWorkflowName") {
              document.getElementById("hidradChildWorkflowName").setAttribute("value", exprnvalue);
              document.getElementById("txtChildWorkflowName").setAttribute("value", newExprn);
              document.getElementById("imgClearChildWorkflowName").style.visibility = "visible";
          }
          else if (hidradCmbParamName == "WorkflowActivityName") {
          document.getElementById("hidradWorkflowActivityName").setAttribute("value", exprnvalue);
          document.getElementById("txtWorkflowActivity").setAttribute("value", newExprn);
          document.getElementById("imgClearWorkflowActivity").style.visibility = "visible";
          }
      }
      /// <summary>
      /// When clear image button is clicked this method is called.
      /// </summary>
      function clearExpression(paramName) {
          se.ui.messageDialog.showConfirmation('<%=PageTitle%>', clearExpressionMessage, function (answer)
          {
              if (answer)
              {
                  hidradCmbParamName = paramName;
                  if (hidradCmbParamName == "ChildWorkflowName")
                  {
                      document.getElementById("hidradChildWorkflowName").setAttribute("value", "");
                      document.getElementById("txtChildWorkflowName").setAttribute("value", "");
                      document.getElementById("imgClearChildWorkflowName").style.visibility = "hidden";
                  }
                  else if (hidradCmbParamName == "WorkflowActivityName")
                  {
                      document.getElementById("hidradWorkflowActivityName").setAttribute("value", "");
                      document.getElementById("txtWorkflowActivity").setAttribute("value", "");
                      document.getElementById("imgClearWorkflowActivity").style.visibility = "hidden";
                  }
              }
          });
      }
      function ltrim(s) {
          return s.replace(/^\s*/, "");
      }
      function setChAt(str, index, chr) {
          if (index > str.length - 1) return str;
          return str.substr(0, index) + chr + str.substr(index + 1);
      }
      function OpenHelpWin(page, winproperties) {
          if (winproperties.indexOf('resizable') < 0)
              winproperties = winproperties + ',resizable=yes';
          if (winproperties.indexOf('scrollbars') < 0)
              winproperties = winproperties + ',scrollbars=yes';
          window.open(page, 'helpPage', winproperties);
     }

     function AfterClientCallBackError(sender, eventArgs) {

         eventArgs.set_cancel(true);
     }
 </script>