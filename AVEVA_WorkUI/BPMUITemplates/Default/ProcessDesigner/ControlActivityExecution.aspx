<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.PropertyTypes.ControlActivityExecution" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
       
<!DOCTYPE html>
<html>
<head id="Head1">
     <title><%=PageTitle%></title>
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
    <script language="javascript" type="text/javascript">
        function AlertWorkflowMessages(message) {
            //setTimeout("alert(\"" + message + "\")", 500);
            setTimeout(se.ui.messageDialog.showError('<%=PageTitle%>', message), 500);
        }
        function AlertSuccessSubmit(message) {
            //setTimeout("alert(\"" + message + "\")", 500);
            setTimeout(se.ui.messageDialog.showAlert('<%=PageTitle%>', message), 500);
        }
        function CloseWorkflowWindow() {
            window.setTimeout('window.opener.refreshselectedaction()', 100);
            window.opener.parent._skProcessDesigner.RefreshProperties();
            window.setTimeout('window.close()', 100);
        }
        function ViewClearImageOnPostBack(paramName) {
            if (paramName == "activity_runtime_loop_execution_name") {
                document.getElementById("imgClearLoopExeActName").style.visibility = "visible";
            }
            else if (paramName == "activity_runtime_workflow_level") {
                document.getElementById("imgClearWorkflowLevel").style.visibility = "visible";
            }
            else if (paramName == "activity_runtime_error_config") {
                document.getElementById("imgClearErrorConfig").style.visibility = "visible";
            }
            else if (paramName == "activity_runtime_workflow_name") {
                document.getElementById("imgClearWorkflowName").style.visibility = "visible";
            }
            else if (paramName == "activity_runtime_activity_name") {
                document.getElementById("imgClearActivityName").style.visibility = "visible";
            }
        }
        function HideClearImageOnPostBack(paramName) {
            if (paramName == "activity_runtime_loop_execution_name") {
                document.getElementById("imgClearLoopExeActName").style.visibility = "hidden";
            }
            else if (paramName == "activity_runtime_workflow_level") {
                document.getElementById("imgClearWorkflowLevel").style.visibility = "hidden";
            }
            else if (paramName == "activity_runtime_error_config") {
                document.getElementById("imgClearErrorConfig").style.visibility = "hidden";
            }
            else if (paramName == "activity_runtime_workflow_name") {
                document.getElementById("imgClearWorkflowName").style.visibility = "hidden";
            }
            else if (paramName == "activity_runtime_activity_name") {
                document.getElementById("imgClearActivityName").style.visibility = "hidden";
            }
        }
        function cleanExpression(paramName) {
            if (paramName == "WorkflowName") {
                if (document.getElementById("hidradWorkflowName") != null) {
                    document.getElementById("hidradWorkflowName").setAttribute("value", "");
                }
                if (document.getElementById("txtWorkflowName") != null) {
                    document.getElementById("txtWorkflowName").setAttribute("value", "");
                }
                if (document.getElementById("imgClearWorkflowName") != null) {
                    document.getElementById("imgClearWorkflowName").setAttribute("value", "");
                }
            }
            else if (paramName == "ActivityName") {
                if (document.getElementById("hidradActivityName") != null) {
                    document.getElementById("hidradActivityName").setAttribute("value", "");
                }
                if (document.getElementById("txtActivityName") != null) {
                    document.getElementById("txtActivityName").setAttribute("value", "");
                }
                if (document.getElementById("imgClearActivityName") != null) {
                    document.getElementById("imgClearActivityName").setAttribute("value", "");
                }
            }
        }
        function AfterClientCallBackError(sender, eventArgs) {
                
            eventArgs.set_cancel(true);
        }

    </script>
</head>
<body style="padding:10px;">
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
           <form id="form1" runat="server">
          <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
         <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
         </telerik:RadScriptBlock>
         <telerik:RadScriptManager ID="RadScriptManager1" runat="server"/>
         <telerik:RadScriptBlock ID="RadScriptBlock2" runat="server">
         <link href="<%=ProcessDesignerControl.GetCommonRelativeUrl("stylesheet/Global.css")%>" rel="stylesheet" type="text/css" />
         <link href="<%=bellyBarPath%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />    
         <link href="<%=ProcessDesignerControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css")%>" rel="stylesheet" type="text/css" />
         <link href="<%=ProcessDesignerControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css")%>" rel="stylesheet" type="text/css" /> 
          </telerik:RadScriptBlock>
          <table style="width:98%;border-spacing:0px;border-collapse:collapse">           
            <tr>
                <td valign="middle">
                    <table cellspacing="0" cellpadding="0" border="0" width="100%">
                        <tr>
                            <td class="fontheading" >
                                <span runat="server" id="spanActDetailLabel">
                                  Activity Details                         
                                </span>
                            </td>
                            <td style="padding-right:10px">
                                <span title="Help"><telerik:RadCodeBlock runat="server" ID="RadCodeBlock2">
                                    <img src="<%:ProcessDesignerControl.GetCommonRelativeUrl("Images/main-help.gif")%>"
                                        align="right" style="cursor: pointer" alt="Help" <%=HelpImageTags%>/>
                                    </telerik:RadCodeBlock>
                                </span>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            
            <tr>
                <td>
                    <table cellspacing="0" cellpadding="0" border="0" width="100%" >
                        <tr>
                            <td style="width:5px">
                            </td>
                            <td>
                                <span class="description" runat="server" id="spanActDetails">
                                    Using Abort Activity Execution, the user can abort an activity present in the same workflow or child workflow.
                                    User can select 'Specify workflow &nbsp;&nbsp;&nbsp; level/Specify value/Specify activity name/Specify workflow name' from the drop down and assign variable to it using the expression editor. 
                                    The same procedure can be followed for specifying the execution instance ID for workflow/activity. 
                                    Execution instance ID is the runtime ID of the workflow/activity.
                                </span>  
                            </td>
                            <td style="width:3px">
                            </td>
                        </tr>
                    </table>                         
                </td>
            </tr>
            
            <tr>
                <td align="left" valign="top">
                    <telerik:RadAjaxPanel ID="radAjaxPanelDropDown" runat="server" EnableAJAX="true">
                         <telerik:RadCodeBlock runat="server" ID="RadCodeBlock1">
                    <div style="width:100%;overflow:auto;height:400px;">
                    <table style="width:100%;border-collapse:separate;border-spacing:2px;margin:0px auto;"  class="tablebg" >
                         <tr>
                             <td class="lefttdbg" style="width:40%;text-align:left;vertical-align:top;padding:5px;">
                                  <span class="subtitle" runat="server" id="spanWLName">Workflow level</span>
                                  <img alt="Mandatory" id="img2" runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/Images/mandatoryicon.png%>" hspace="2" align="top" visible="true" />
                                    <br/>
                                    <span class="description" runat="server" id="spanWLHelp">Whether an activity that is to be aborted is present in the 
                                        same workflow or child workflow.</span> 
                             </td>
                             <td class="righttdbg"  style="width:55%;padding:5px;">
                                <table style="width:100%;border-collapse:separate;border-spacing:2px;text-align:left;">
                                    <tr>
                                        <td style="width:55%;padding:2px;">
                                            <telerik:RadComboBox ID="radCmbWorkflowLevel" runat="server" AutoPostBack="true" Skin="AWTCombobox" Width="245px" ErrorMessage="" OnClientItemsRequestFailed="AfterClientCallBackError"
                                                AllowCustomText="true" MarkFirstMatch="true"  EnableEmbeddedSkins="false" RenderMode="Classic" Height="150px">
                                            </telerik:RadComboBox>
                                        </td>
                                        <td style="width:30%;padding:2px;">
                                            <asp:TextBox ID="txtWorkflowLevel" runat="server" CssClass="inputtext" Width="130px" ></asp:TextBox>
                                        </td>
                                        <td style="width:15%;padding:2px;">
                                            <span style="width: 5px;"></span><img alt="" id="imgPdWorkflowLevel"
                                                    onmousemove="this.style.cursor='hand'"
                                                    onclick="openEditorControlRunTime('WorkflowLevel');"
                                                    runat="server"
                                            />
                                            &nbsp;<img id="imgClearWorkflowLevel" alt="" onmousemove="this.style.cursor='hand'" onclick="clearExpression('WorkflowLevel');" runat="server"/>
                                        </td>
                                    </tr>
                                </table>
                             </td>
                         </tr>
                         <tr>
                             <td class="lefttdbg" style="text-align:left;vertical-align:top;padding:5px;">
                              <span class="subtitle" runat="server" id="spanWFName">Workflow Name/Instance ID</span>
                                <br/>
                                <span class="description" runat="server" id="spanWFHelp">Name/Instance ID of workflow assocaited with the activity that is to be aborted.</span> 
                             </td>
                             <td class="righttdbg" style="padding:5px;">
                                <table style="width:100%;border-collapse:separate;border-spacing:2px;text-align:left;">
                                    <tr>
                                        <td style="width:55%;padding:2px;">
                                            <telerik:RadComboBox ID="radCmbWorkflowName" runat="server" AutoPostBack="true" Skin="AWTCombobox" RenderMode="Classic"
                                                 Width="245px" ErrorMessage="" ShowWhileLoading="false" Height="100px" OnClientItemsRequestFailed="AfterClientCallBackError" AllowCustomText="true" MarkFirstMatch="true" EnableEmbeddedSkins="false">
                                            </telerik:RadComboBox>
                                        </td>
                                        <td style="width:30%;padding:2px;">
                                            <asp:TextBox ID="txtWorkflowName" runat="server" CssClass="inputtext" Width="130px" ></asp:TextBox>
                                        </td>
                                        <td style="width:15%;padding:2px;">
                                            <span style="width: 5px;"></span><img alt="" id="imgPdWorkflowName"
                                                    onmousemove="this.style.cursor='hand'"
                                                    onclick="openEditorControlRunTime('WorkflowName');"
                                                    runat="server"
                                            />
                                            &nbsp;<img style="visibility:hidden;" id="imgClearWorkflowName" alt="" onmousemove="this.style.cursor='hand'" onclick="clearExpression('WorkflowName');" runat="server"/>
                                        </td>
                                    </tr>
                                </table>
                             </td>
                         </tr>
                         <tr>
                             <td class="lefttdbg" style="text-align:left;vertical-align:top;padding:5px;">
                              <span class="subtitle" runat="server" id="spanActName">Activity Name/Instance ID</span>
                              <img alt="Mandatory" id="img6" runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/Images/mandatoryicon.png%>" hspace="2" align="top" visible="true" />
                                <br/>
                                <span class="description" runat="server" id="spanActHelp">Name/Instance ID of activity on which needs to be aborted.</span> 
                             </td>
                             <td class="righttdbg" style="padding:5px;">     
                                 <telerik:RadAjaxPanel ID="radAjaxPanelActivityName" runat="server" EnableAJAX="true">
                                <div>
                                <table style="width:100%;border-collapse:separate;border-spacing:2px;text-align:left;">
                                    <tr>
                                        <td style="width:55%;padding:2px;">                                       
                                             <telerik:RadComboBox ID="radCmbActivityName" runat="server" AutoPostBack="true" Skin="AWTCombobox" EnableEmbeddedSkins="false" RenderMode="Classic"
                                                 Width="245px" ErrorMessage="" ShowWhileLoading="false" Height="100px" OnClientItemsRequestFailed="AfterClientCallBackError" AllowCustomText="true" MarkFirstMatch="true">
                                            </telerik:RadComboBox>                                          
                                        </td>
                                        <td style="width:30%;padding:2px;">
                                            <asp:TextBox ID="txtActivityName" runat="server" CssClass="inputtext" Width="130px" ></asp:TextBox>
                                        </td>
                                        <td style="width:15%;padding:2px;">
                                            <span style="width: 5px;"></span><img alt="" id="imgPdActivityName"
                                                    onmousemove="this.style.cursor='hand'"
                                                    onclick="openEditorControlRunTime('ActivityName');"
                                                    runat="server"
                                            />
                                            &nbsp;<img style="visibility:hidden;" id="imgClearActivityName" alt="" onmousemove="this.style.cursor='hand'" onclick="clearExpression('ActivityName');" runat="server"/>
                                        </td>
                                    </tr>
                                </table>
                                </div>
                               </telerik:RadAjaxPanel>
                              </td>
                         </tr>
                         <tr>
                             <td class="lefttdbg" style="text-align:left;vertical-align:top;padding:5px;" >
                                  <span class="subtitle" runat="server" id="spanLoopName">Loop execution step entry activity name</span>
                                    <br/>
                                    <span class="description" runat="server" id="spanLoopHelp">Name of the Loop execution step entry activity.</span> 
                             </td>
                             <td class="righttdbg" style="padding:5px;">
                                 <telerik:RadAjaxPanel ID="radAjaxPanelLoopExeActName" runat="server" EnableAJAX="true">
                                <div>
                                <table style="width:100%;border-collapse:separate;border-spacing:2px;text-align:left;">
                                    <tr>
                                        <td style="width:55%;padding:2px;">
                                            <telerik:RadComboBox ID="radCmbLoopExeActName" runat="server" AutoPostBack="true" Skin="AWTCombobox" EnableEmbeddedSkins="false" RenderMode="Classic"
                                                 Width="245px" ErrorMessage="" ShowWhileLoading="false" Height="100px" OnClientItemsRequestFailed="AfterClientCallBackError" AllowCustomText="true" MarkFirstMatch="true">
                                            </telerik:RadComboBox>
                                         </td>
                                        <td style="width:30%;padding:2px;">
                                            <asp:TextBox ID="txtLoopExeActName" runat="server" CssClass="inputtext" Width="130px" ></asp:TextBox>
                                        </td>
                                        <td style="width:15%;padding:2px;">
                                            <span style="width: 5px;"></span><img alt="" id="imgPdLoopExeActName"
                                                    onmousemove="this.style.cursor='hand'"
                                                    onclick="openEditorControlRunTime('LoopName');"
                                                    runat="server" />
                                            &nbsp;<img style="visibility:hidden;" id="imgClearLoopExeActName" alt="" onmousemove="this.style.cursor='hand'" onclick="clearExpression('LoopName');" runat="server"/>
                                        </td>
                                    </tr>
                                </table>
                                </div>
                              </telerik:RadAjaxPanel>
                             </td>
                         </tr>
                         <tr>
                             <td class="lefttdbg" style="text-align:left;vertical-align:top;padding:5px;">
                              <span class="subtitle" runat="server" id="spanErrorName">Error if activity instance not found</span>
                              <img alt="Mandatory" id="img3" runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/Images/mandatoryicon.png%>" hspace="2" align="top" visible="true" />
                                <br/>
                                <span class="description" runat="server" id="spanErrorHelp">Whether an error should be displayed if the below mentioned Activity Name/Instance ID is not found.</span> 
                             </td>
                             <td class="righttdbg" style="padding:5px;">
                                 <telerik:RadAjaxPanel ID="radAjaxPanelErrorConfig" runat="server" EnableAJAX="true">
                                 <div>
                                 <table style="width:100%;border-collapse:separate;border-spacing:2px;text-align:left;">
                                    <tr>
                                        <td style="width:55%;padding:2px;">
                                             <telerik:RadComboBox ID="radCmbErrorConfig" runat="server" AutoPostBack="true" Skin="AWTCombobox" EnableEmbeddedSkins="false" RenderMode="Classic"
                                                 Width="245px" ErrorMessage="" ShowWhileLoading="false" Height="100px" OnClientItemsRequestFailed="AfterClientCallBackError" AllowCustomText="true" MarkFirstMatch="true">
                                            </telerik:RadComboBox>                                            
                                        </td>
                                        <td style="width:30%;padding:2px;">
                                            <asp:TextBox ID="txtErrorConfig" runat="server" CssClass="inputtext" Width="130px" ></asp:TextBox>
                                        </td>
                                        <td style="width:15%;padding:2px;">
                                            <span style="width: 5px;"></span><img alt="" id="imgPdErrorConfig"
                                                    onmousemove="this.style.cursor='hand'"
                                                    onclick="openEditorControlRunTime('ErrorConfig');"
                                                    runat="server"
                                            />
                                            &nbsp;<img style="visibility:hidden;" id="imgClearErrorConfig" alt="" onmousemove="this.style.cursor='hand'" onclick="clearExpression('ErrorConfig');" runat="server"/>
                                        </td>
                                    </tr>
                                </table>
                                </div>
                                    </telerik:RadAjaxPanel>
                                 </td>
                         </tr>
                     </table>
                     </div>
                       </telerik:RadCodeBlock>
                     </telerik:RadAjaxPanel>
                   
                 </td>
            </tr>
        </table>
             <table style="width:100%;padding:5px;">
            <tr>
                <td style="vertical-align:top;height:25px;padding:5px;">
                    <table style="width:100%;border-collapse:separate;border-spacing:2px;">
                        <tr>
                            <td style="text-align:right;padding-right:15px;">
                               <asp:Button ID="btnClose" runat="server" Text="Close"  class="inputsecondarybutton" tabindex="22" />
                               <asp:Button ID="btnUpdate" runat="server" Text="Update"  class="inputbutton" tabindex="22" />
                            </td>
                        </tr>
                   </table>   
                </td>
            </tr>
        </table>
           
    <input id="hidradCmbParamName" type="hidden" runat="server" />
    <input id="hidradCmbLoopExeActName" type="hidden" runat="server" />
    <input id="hidradWorkflowLevel" type="hidden" runat="server" />
    <input id="hidradErrorConfig" type="hidden" runat="server" />
    <input id="hidradWorkflowName" type="hidden" runat="server" />
    <input id="hidradActivityName" type="hidden" runat="server" />
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
          expbuilderURl = expbuilderURl.replace("ControlActivityExecution.aspx", "ExpressionEditor.aspx");
          var expressionValue = "";
          var finalURL = "";
          if (hidradCmbParamName == "LoopName") {
              if (document.getElementById("txtLoopExeActName").getAttribute("disabled") == true)
                  return;
              expressionValue = "hidradCmbLoopExeActName";
          }
          else if (hidradCmbParamName == "WorkflowLevel") {
              if (document.getElementById("txtWorkflowLevel").getAttribute("disabled") == true)
                  return;
              expressionValue = "hidradWorkflowLevel";
          }
          else if (hidradCmbParamName == "ErrorConfig") {
              if (document.getElementById("txtErrorConfig").getAttribute("disabled") == true)
                  return;
              expressionValue = "hidradErrorConfig";
          }
          else if (hidradCmbParamName == "WorkflowName") {
              if (document.getElementById("txtWorkflowName").getAttribute("disabled") == true)
                  return;
              expressionValue = "hidradWorkflowName";
          }
          else if (hidradCmbParamName == "ActivityName") {
              if (document.getElementById("txtActivityName").getAttribute("disabled") == true)
                  return;
              expressionValue = "hidradActivityName";
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
          if (hidradCmbParamName == "LoopName") {
              document.getElementById("hidradCmbLoopExeActName").setAttribute("value", exprnvalue);
              document.getElementById("txtLoopExeActName").setAttribute("value", newExprn);
              document.getElementById("imgClearLoopExeActName").style.visibility = "visible";
          }
          else if (hidradCmbParamName == "WorkflowLevel") {
              document.getElementById("hidradWorkflowLevel").setAttribute("value", exprnvalue);
              document.getElementById("txtWorkflowLevel").setAttribute("value", newExprn);
              document.getElementById("imgClearWorkflowLevel").style.visibility = "visible";
          }
          else if (hidradCmbParamName == "ErrorConfig") {
              document.getElementById("hidradErrorConfig").setAttribute("value", exprnvalue);
              document.getElementById("txtErrorConfig").setAttribute("value", newExprn);
              document.getElementById("imgClearErrorConfig").style.visibility = "visible";
          }
          else if (hidradCmbParamName == "WorkflowName") {
              document.getElementById("hidradWorkflowName").setAttribute("value", exprnvalue);
              document.getElementById("txtWorkflowName").setAttribute("value", newExprn);
              document.getElementById("imgClearWorkflowName").style.visibility = "visible";
          }
          else if (hidradCmbParamName == "ActivityName") {
              document.getElementById("hidradActivityName").setAttribute("value", exprnvalue);
              document.getElementById("txtActivityName").setAttribute("value", newExprn);
              document.getElementById("imgClearActivityName").style.visibility = "visible";
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
                  if (hidradCmbParamName == "LoopName")
                  {
                      document.getElementById("hidradCmbLoopExeActName").setAttribute("value", "");
                      document.getElementById("txtLoopExeActName").setAttribute("value", "");
                      document.getElementById("imgClearLoopExeActName").style.visibility = "hidden";
                  }
                  else if (hidradCmbParamName == "WorkflowLevel")
                  {
                      document.getElementById("hidradWorkflowLevel").setAttribute("value", "");
                      document.getElementById("txtWorkflowLevel").setAttribute("value", "");
                      document.getElementById("imgClearWorkflowLevel").style.visibility = "hidden";
                  }
                  else if (hidradCmbParamName == "ErrorConfig")
                  {
                      document.getElementById("hidradErrorConfig").setAttribute("value", "");
                      document.getElementById("txtErrorConfig").setAttribute("value", "");
                      document.getElementById("imgClearErrorConfig").style.visibility = "hidden";
                  }
                  else if (hidradCmbParamName == "WorkflowName")
                  {
                      document.getElementById("hidradWorkflowName").setAttribute("value", "");
                      document.getElementById("txtWorkflowName").setAttribute("value", "");
                      document.getElementById("imgClearWorkflowName").style.visibility = "hidden";
                  }
                  else if (hidradCmbParamName == "ActivityName")
                  {
                      document.getElementById("hidradActivityName").setAttribute("value", "");
                      document.getElementById("txtActivityName").setAttribute("value", "");
                      document.getElementById("imgClearActivityName").style.visibility = "hidden";
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
        </script>