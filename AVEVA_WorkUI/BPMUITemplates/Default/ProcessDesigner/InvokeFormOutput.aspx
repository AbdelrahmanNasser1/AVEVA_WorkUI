<%@ Page Language="C#" AutoEventWireup="true"  Inherits="Workflow.NET.Web.Designer.ExpressionBuilder.ConditionalOutputUI" Theme="" StylesheetTheme="" %>
<%@ Register TagPrefix="cc1" Namespace="Workflow.NET.Ajax" Assembly="Workflow.NET.NET2" %>

<script src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ProcessDesignerControl.GetJscriptUrl("../Common/javascripts/DecisionScript.js"))%>"></script>
<!DOCTYPE HTML>
<html>
<head id="Head1" runat="server">
    <title><%:PageTitle%></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
     <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <style>
       html, body
        {
            height: 100%;
            overflow:hidden;
        }
       fieldset{
  border:none;
  padding:0;
  
}
legend{
  display:none;
}

    </style>
</head>

<body onload="Initialize();" style="overflow:hidden;" >
     <script>

         se.ui.messageDialog.setGlobalOptions({
             localization: {
                 closeButtonCaption: "<%=ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                 okButtonCaption: "<%=ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
                 cancelButtonCaption: "<%=ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                 showDetailsCaption: "<%=ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                 hideDetailsCaption: "<%=ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
             }
         });

        
</script>


<form id="form1" runat="server">
        <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ProcessDesignerControl.GetThemeRelativeUrl("Common/stylesheet/Global.css"))%>">
     <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ProcessDesignerControl.GetThemeRelativeUrl("CommonUXControls/StyleSheet/se.ui.min.css"))%>">
     <%=System.Web.Helpers.AntiForgery.GetHtml()%>
<div style="height:100%;">
    <table cellspacing=0 cellpadding=0 width=100% border=0 >
      <tr>
           <td align="center">
           <table border=0 width=100% align=center ID="Table2" cellpadding="0" cellspacing="0" >
               <tr class="ListHeaderCss">
                   <td style="padding-left:10px;text-align:left;width:30%;"><span class="subtitle"><%=ProcessDesignerControl.GlobalResourceSet.GetString("Invoke Form Action Outputs")%></span></td>
                   <td valign="middle" width=70% align="right"><a href="#" onclick="javascript:window.open('<%=ProcessDesignerControl.GetHelpPageUrl()%>InvokeForm-PossibleDistinctOutputs.html','newwin','width=600,height=500,scrollbars=yes,resizable=yes')">
				   <img border="0" src="<%:ProcessDesignerControl.GetCommonRelativeUrl("Images/main-help.gif")%> " align="right" style="cursor:pointer" alt="<%=ProcessDesignerControl.GlobalResourceSet.GetString("Help")%>"/></a></td>
               </tr>
               
				<tr>
			    	<td class="lefttdbg" colspan=2 align=center>
			    	<div id="divSetOutput">
				        <table width=94% ID="Table1" cellpadding="0" cellspacing="0" border="0" >
                            <tr>
                                 <td colspan=3><img src="<%:ProcessDesignerControl.GetCommonRelativeUrl("images/spacer.gif")%>" height="4" border="0"></td>
                            </tr> 				           
  				            <tr>
				                 <td width="1%" height=22>&nbsp;</td>
				                 <td>
				                    <table width="100%" cellpadding="0" cellspacing="0" border="0">
				                        <tr>
				                            <td class="description">
				                                <a href="#" onclick="javascript:AddMultipleOutputNewRow()" class="textlinkblackNormal"><img src="<%:ProcessDesignerControl.GetCommonRelativeUrl("images/Add-Rule.gif")%>" align="absmiddle" border="0" >&nbsp;<%=ProcessDesignerControl.GlobalResourceSet.GetString("Add Distinct Output")%></a>
				                            </td>
				                            <td class="description">
				                                <a href="#" onclick="javascript:ShowHideElseRow(true)" class="textlinkblackNormal"><img src="<%:ProcessDesignerControl.GetCommonRelativeUrl("images/Add-else.gif")%>" align="absmiddle" border="0" >&nbsp;<%=ProcessDesignerControl.GlobalResourceSet.GetString("Add Else Conditional Output")%></a>
				                            </td>
				                            <td class="description">
				                                <a href="#" onclick="javascript:GenerateButtonUI()" class="textlinkblackNormal"><img src="<%:ProcessDesignerControl.GetCommonRelativeUrl("images/condition-buttons.gif")%>" align="absmiddle" border="0" />&nbsp;<%= ProcessDesignerControl.GlobalResourceSet.GetString("Generate Condition for Form Buttons")%></a>
				                            </td>
				                        </tr>
				                    </table>
				                 </td>
				                 <td width="1%">&nbsp;</td>
				                 
				            </tr>
				            <tr>
                                 <td><img src="<%:ProcessDesignerControl.GetCommonRelativeUrl("images/spacer.gif")%>" height="4" border="0"></td>
                            </tr> 				           
				            <tr>
				                <td colspan=3 >
			                            <div id="divMain"  style="Overflow: auto;width:100%;Height:500px;">
		                                <table width=100% cellspacing=0 cellpadding=0 class="lefttdbg">
		                                      <tr>
		                                          <td align="center">
		                                                <div id="divConditionLayers">
		                                                 </div>
                                                         <div id="divElse">
                                                         <table width="97%" cellspacing="0" cellpadding="5" border="0">
                                                            <tr>
                                                                <td width="100%">
                                                                   <!--<table width="100%" id="TableExpression1"  border=0 cellspacing=0 cellpadding="0">
                                                                        <tr>
                                                                           <td colspan=4 align="left">
                                                                               <table cellpadding="0" cellspacing="0" border="1" width="90%">
                                                                                 <tr>
                                                                                    <td width=100%>-->
                                                                                       <fieldset id="Fieldset1" name="fldSet1" >
										                                                  <legend class="LegendText"><b></b></legend>					
											                                                <table width=100% cellpadding=0 cellspacing=1 border="0">
											                                                  <tr>
											                                                    <td width=100%>
											                                                        <table id ="TableElse" cellpadding="5" width="100%" cellspacing="1" border="0" height="50" class="tablepdbg">
                                                                                                         <tr class="GridHeaderStyle">
                                                                                                             <td>
                                                                                                                 <table width="100%">
                                                                                                                     <tr>
                                                                                                                         <td valign="middle"  nowrap>[ <%=ProcessDesignerControl.GlobalResourceSet.GetString("DecisionElse")%> ] (<%=ProcessDesignerControl.GlobalResourceSet.GetString("DecisionNoneofaboveconditiontrue")%>)</td>
                                                                                                                            <td class="description" height="22" style="text-align:right">
                                                                                                                            <a href="#"  class="a" onclick="ShowHideElseRow(false);"><img src="<%=deleteIcon%>" border=0  title="<%=ProcessDesignerControl.GlobalResourceSet.GetString("DecisionDeleteElseRule")%>" alt="<%=ProcessDesignerControl.GlobalResourceSet.GetString("DecisionDeleteRule")%>" hspace="3" align=absmiddle/></a>
                                                                                                                        </td>
                                                                                                                     </tr>
                                                                                                                 </table>
                                                                                                             </td>
                                                                                                            
                                                                                                        </tr>
												                                                        <tr class="lefttdbg">
                                                                                                            <td colspan="2">
                                                                                                                <table width="100%" cellspacing="0" cellpadding="0">
                                                                                                                    <tr>
                                                                                                                        <td class="description" width="10%">
												                                                                           <%=ProcessDesignerControl.GlobalResourceSet.GetString("DecisionOutput")%>
												                                                                         </td>
												                                                                         <td width="90%">
												                                                                            <input type="text" id="txtElseOutPut" name="txtElseOutPut" class="inputtext" maxlength="50"  style="width:200px"/>&nbsp;
												                                                                         </td>
                                                                                                                     </tr>
                                                                                                                </table>
                                                                                                            </td>
												                                                         </tr>
																					                </table>
																					              </td>
																					            </tr>
											                                                    
												                                            </table>
												                                        </fieldset>
                                                                                    <!--</td>
															                    </tr>
														                     </table>                                                                             
														          </td>
                                                                </tr>                                                      
                                                          </table>    -->
                                                       </td>
                                                     </tr> 
                                                  </table>
                                                </div>
                                              </td>    
		                                   </tr>
		                                </table>
        	                         </div>
				                </td>
				            </tr>
				            
				            <tr>
                                 <td><img src="<%:ProcessDesignerControl.GetCommonRelativeUrl("images/spacer.gif")%>" height="4" border="0"></td>
                            </tr>
                        </table>
                        </div>
                     </td>   
                 </tr>                
                     
                 <tr>
                      <td colspan=2 align="center">
                        <div id="divSetCompletionMaker" style="display:none;Overflow: auto;width:700px;Height:470px;"   >
                            <table width="100%" cellpadding="0" cellspacing="2">
                                <tr>
                                    <td>
                                         <table width="100%" >
                                            <tr>
                                                <td> 
                                                    <table width="100%" align="center" cellpadding="3">
                                                        <tr>
                                                            <td class="subtitle" align="left"> 
                                                               <%=ProcessDesignerControl.GlobalResourceSet.GetString("Set Completion Maker")%>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="description">
                                                                <%=ProcessDesignerControl.GlobalResourceSet.GetString("Set Completion Maker Description")%>
                                                               
                                                            </td>
                                                        </tr>
                                                     </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <table border=0  width="100%" align="center" >
                                                        <tr>
                                                            <td>
                                                                <table width="95%" cellpadding="3" cellspacing="3">
                                                                    <tr>
                                                                        <td class="subtitle" width="53%">
                                                                            <%=ProcessDesignerControl.GlobalResourceSet.GetString("Possible Outputs")%>
                                                                        </td>
                                                                        <td class="subtitle" >
                                                                           <% =ProcessDesignerControl.GlobalResourceSet.GetString("Is Completion Maker?")%>
                                                                        </td>
                                                                    </tr>
                                                                    <%=CompletionMakerData%>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                     </table>
                                                    
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table border=0  width="100%" align="center" >
                                            <tr>    
                                                <td >&nbsp;</td>
                                            </tr>
                                             <tr>
                                                <td  >
                                                    <table width="100%" class="lefttdbg" cellpadding="3" cellspacing="0">
                                                        <tr>
                                                            <td  class="lefttdbg" width="50%" style="padding-left:5px;"> 
                                                                <span class="subtitle"> <% =ProcessDesignerControl.GlobalResourceSet.GetString("Update output instance xml")%> </span><asp:CheckBox name="chkUpdateOutPutXMLOnlyForCompMakers" id="chkUpdateOutPutXMLOnlyForCompMakers" runat="server"/>
                                                                <br /><br />
                                                                <span class="description"> <% =ProcessDesignerControl.GlobalResourceSet.GetString("Update output instance xml description")%> </span>                                                  
                                                            </td>
                                                            
                                                       </tr>
                                                    </table>
                                                 </td>
                                            </tr>
                                             <tr>    
                                                <td >&nbsp;</td>
                                            </tr>
                                         </table>
                                    </td>
                                </tr>
                                <!--<tr>
                                    <td>
                                        <table border=0  width="90%" align="center" >
                                            <tr>    
                                                <td >&nbsp;</td>
                                            </tr>
                                             <tr>
                                                <td  >
                                                    <table width="100%" class="fieldset" cellpadding="3" cellspacing="0">
                                                        <tr>
                                                            <td  class="lefttdbg" width="50%"> 
                                                                <span class="subtitle">Enable final ouput matrix calculation </span>
                                                                <br /><br />
                                                                <span class="description">If checked, the workflow is alerted only when, the final output is decided as per the specifications</span>                                                  
                                                            </td>
                                                            <td class="righttdbg" valign="top">
                                                                <input type="checkbox" name="chkAffirmative" id="chkAffirmative" onclick="javascript:ShowAffirmative(this);" />
                                                            </td>
                                                       </tr>
                                                    </table>
                                                 </td>
                                            </tr>
                                             <tr>    
                                                <td >&nbsp;</td>
                                            </tr>
                                             <tr>
                                                <td  >
                                                    <div id="divAffirmativeUnchecked" style="display:none;">
                                                        <table width="100%" class="fieldset" cellpadding="3" cellspacing="0">
                                                            <tr>
                                                                <td class="lefttdbg" width="50%">
                                                                <span class="subtitle">Maximum actors required for completion</span></td>
                                                                <td class="righttdbg"><asp:TextBox runat="server" ID="txtMaxPerc" class="inputtext" Text="100" Width="50px"></asp:TextBox>
                                                                  <span class="description" >[% or Number]</span></td>
                                                             </tr>
                                                             <tr>
                                                                <td class="lefttdbg">
                                                                <span class="subtitle">Minimum actors required for completion</span></td>
                                                                <td  class="righttdbg"><asp:TextBox runat="server" ID="txtMinPerc" class="inputtext" Text="100" Width="50px"></asp:TextBox>
                                                                 <span class="description" >[% or Number]</span></td>
                                                             </tr>
                                                        </table>
                                                    </div>
                                            </td>
                                            </tr>  
                                            <tr>
                                            <td colspan="2">
                                                <div id="divAffirmativeChecked" style="display:none;">
                                                     <table width="100%" cellpadding="3" cellspacing="0">
                                                         <tr>
                                                            <td>
                                                                <fieldset class="fieldset" title="Affirmative Output Calculation"><legend ><span class="subtitle">Final Output Calculation</span></legend>
                                                                    <table width="100%" cellpadding="3" cellspacing="0">
                                                                        <tr>
                                                                            <td class="lefttdbg" width="50%">
                                                                                <span class="subtitle">Power Output</span>
                                                                                <span class="description">
                                                                                    <br /> Final Output is decidied for the activity on any occurence of the selected outputs
                                                                                </span>
                                                                            </td>
                                                                            <td class="righttdbg">
                                                                                <asp:CheckBoxList ID="chkSoleAffirmation" runat="server" RepeatColumns="2" RepeatDirection="horizontal" RepeatLayout="table" CssClass="inputcheckbox" onclick="javascript:EnableDisableLimitOutPut();"></asp:CheckBoxList>
                                                                                
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="lefttdbg">
                                                                                <span class="subtitle">Outputs with Limit</span>
                                                                                <span class="description">
                                                                                    <br /> Final Output will be considered as the selected output when the limit specified is reached
                                                                                </span>
                                                                            </td>
                                                                            <td class="righttdbg">
                                                                                <table>
                                                                                    <tr>
                                                                                        <td> <span class="description" >Possible Outputs</span></td>
                                                                                        <td> <span class="description" >Limit [% or Number]</span></td>
                                                                                    </tr>
                                                                                   
                                                                                </table>
                                                                              
                                                                               
                                                                            </td>
                                                                        </tr>
                                                                       
                                                                    </table>
                                                                </fieldset>
                                                            </td>
                                                         </tr>
                                                         
                                                 </table>
                                                </div>
                                            </td>
                                       </tr>          
                                    </table>
                                  </td>
                              </tr>
                               -->
                         </table>
                    </div>
                </td>
               </tr>
              
                 
                 <tr>
                     <td colspan="2">
                       <table width="100%" border="0" cellspacing="0" cellpadding="3" border="3">
                         <tr>
                            <td  id="Td2" align="right" style="padding-right:10px;padding-top:5px;">
                                       <input type="button" id="btnBack" name="btnBack" value="&nbsp;&nbsp;<%=ProcessDesignerControl.GlobalResourceSet.GetString("Back")%> &nbsp;&nbsp;" onClick="javascript:LoadConditions(true);" class="inputsecondarybutton" style="visibility:hidden;">
                                       <input type="button" id="btnCancel" name="btnCancel" value="&nbsp; <%=ProcessDesignerControl.GlobalResourceSet.GetString("InvokeForm_Condition_ButtonClose")%> &nbsp;" onClick="window.close();" class="inputsecondarybutton" style="margin-right:10px;">
                                       <input type="button" id="btnDelete" name="btnDelete" value="&nbsp; <%=ProcessDesignerControl.GlobalResourceSet.GetString("InvokeForm_Condition_ButtonDelete")%> &nbsp;"  onClick="ClickDelete1();" class="inputsecondarybutton" style="margin-right:10px;">
	                                   <input type="button" id="btnOk" name="btnOk" value="&nbsp;&nbsp;&nbsp;<%=ProcessDesignerControl.GlobalResourceSet.GetString("Next")%> &nbsp;&nbsp;&nbsp;" onClick="javascript:ClickOK();" class="inputbutton">
                                
                            </td>
                         </tr>
                       </table>                        
                     </td>
                  </tr>
            </table>         
        </td>
     </tr>
  </table>                   
</div>

<cc1:ajaxpagecontrol id="AjaxPageControl1" runat="server" style="Z-INDEX: 104; LEFT: 440px; POSITION: absolute; TOP: 88px"></cc1:ajaxpagecontrol>
<input type="hidden" id="totalRowCount" name="totalRowCount" value=0 />
<input type="hidden" id="CurrentRow" name="CurrentRow"/>
<input type="hidden" id="HiddenJsDecisionString" name="HiddenJsDecisionString" value="<%=Server.HtmlEncode(jsDecisionString)%>"/> 

<input type="hidden" id="hidPageType" name="hidPageType" value="<%=HidPageType%>"/>
<input type="hidden" id="hidOutputs" name="hidOutputs" />
<input type="hidden" id="hidOutputsTotatCount" name="hidOutputsTotatCount" />
<input type="hidden" id="hidJsDecisionBeforeCompletionMaker" name="hidJsDecisionBeforeCompletionMaker" value="<%=Server.HtmlEncode(jsDecisionString)%>" />
<input type="hidden" id="hidIsBuutonAvailable" name="hidIsBuutonAvailable" value="<%=FormButtonAvailable%>"/>
<input type="hidden" id="hidCompletionMakerChanges" name="hidCompletionMakerChanges"/>
</form>
</body>
</html>
<script type="text/javascript">

var deleteIcon = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(deleteIcon, false)%>";
var rulesicon = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(rulesicon, false)%>";

var deleterule = "<%=ProcessDesignerControl.GlobalResourceSet.GetString("DecisionDeleteRule")%>";
var outputLocal = "<%=ProcessDesignerControl.GlobalResourceSet.GetString("DecisionOutput")%>";
var ruleLocal = "<%=ProcessDesignerControl.GlobalResourceSet.GetString("DecisionRule")%>";
var conditionLocal = "<%=ProcessDesignerControl.GlobalResourceSet.GetString("DecisionCondition")%>";
var editconditionLocal = "<%=ProcessDesignerControl.GlobalResourceSet.GetString("DecisionEditCondition")%>";
var stopprocessLocal = "Is Completion Maker";//"<%=ProcessDesignerControl.GlobalResourceSet.GetString("DecisionStopProcessing")%>";
var enteropforruleLocal = "<%=ProcessDesignerControl.GlobalResourceSet.GetString("DecisionEnteropforrule")%>";
var enteropexists = "<%=ProcessDesignerControl.GlobalResourceSet.GetString("DecisionEnteropexists")%>";
var enterspexists = "<%=ProcessDesignerControl.GlobalResourceSet.GetString("DecisionEnterspexists")%>";
var buildvalidconforrule = "<%=ProcessDesignerControl.GlobalResourceSet.GetString("DecisionBuildvalidconforrule")%>";
var AffirmativeOutput = "";//pending
var AffirmativePercentage = "";
var AffirmativeNegativeOutput = "";
var nextButtonText ="  <%=ProcessDesignerControl.GlobalResourceSet.GetString("Next")%>  ";
var okButtonText   ="  <%=ProcessDesignerControl.GlobalResourceSet.GetString("OK")%>  ";
var elseconditionexists = "<%=ProcessDesignerControl.GlobalResourceSet.GetString("DecisionElseExists")%>";
var deleteConfirmLocal = "<%=ProcessDesignerControl.GlobalResourceSet.GetString("InvokeForm_Condition_ClearConfirm")%>";
var completionMakerChanges = "";
var ConditionArray =new Array();

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

function Initialize()
{
    var browserversion = GetBrowserversion();
    
    if(browserversion!=1)
    {
        document.getElementById("divMain").style.height=500;
        var conditionEditImage=document.getElementById("conditionEditImage");
        if(conditionEditImage!=null)
        {
            conditionEditImage.vspace=13;
        }
    }
}

function LoadConditions(isBack)
{

    var decisionsObject=new Array();
    var strigified = document.getElementById("HiddenJsDecisionString").value;
    var IsButtonAvailable = document.getElementById("hidIsBuutonAvailable").value;
    
    if(isBack)
    {
        document.getElementById("divSetOutput").style.display = 'block';
        document.getElementById("btnOk").value=nextButtonText;
        document.getElementById("divSetCompletionMaker").style.display = 'none';
        document.getElementById("btnBack").style.visibility='hidden';
        //Changes in completion maker are sent to server  for repopulation
        var rowCount = parseInt(document.getElementById("totalRowCount").value);
        var  updateOnlyForCM= "";
        if(document.getElementById("chkUpdateOutPutXMLOnlyForCompMakers").checked)
            updateOnlyForCM= "Yes";
        else
            updateOnlyForCM= "No";
        
        completionMakerChanges = "<Outputs UpdateOnlyForCM='"+updateOnlyForCM+"'>";
        for(var i=1;i<=rowCount;i++)
        {
            if(document.getElementById("output"+i)!=null)
            {
                var outputValue = document.getElementById("output"+i).value;
                if(document.getElementById("selCompletionMakerID"+i).options[0].selected)
                {
                    completionMakerChanges += "<Data Output='"+outputValue+"' status='yes'></Data>";
                }
                else
                {
                    completionMakerChanges += "<Data Output='"+outputValue+"' status='no'></Data>";
                }
            }
        }
        completionMakerChanges += "</Outputs>";
        
        document.getElementById("hidCompletionMakerChanges").value = completionMakerChanges;
        //Ends here changes in completion maker are sent to server  for repopulation
        document.getElementById("divConditionLayers").innerHTML ="";
        for(var i=0;i<ConditionArray.length;i++)
             {
                if(ConditionArray[i]!=0)
                {
                     if(eval("window.Decision"+ConditionArray[i])!=null)
                     {
                        if(document.getElementById("divConditionLayers"+ConditionArray[i])!=null)
                            document.getElementById("divConditionLayers"+ConditionArray[i]).innerHTML ="";
                        decisionsObject[i]=eval("window.Decision"+ConditionArray[i]);  
                     }
                }     
             }
             
    }
    else
         decisionsObject =objectify(strigified);
        
    
    if(decisionsObject!=null)
    {
        var elseExists = false;
        for(var i=0;i<=decisionsObject.length;i++)
        {
           var decision = decisionsObject[i];
           
           if(decision!=null)
           {
                if(decision.ConditionString=="Else")
                {
                   
                    eval("window.Decision"+parseInt(i+1)+" =new Decision()"); 
                    eval("window.Decision"+parseInt(i+1)+" =decisionsObject["+i+"]");
                    if(!isBack)
                        ConditionArray[ConditionArray.length]=parseInt(i+1);
                    document.getElementById("txtElseOutPut").value= eval("window.Decision"+parseInt(i+1)+".OutPut"); 
                    document.getElementById("totalRowCount").value=parseInt(document.getElementById("totalRowCount").value)+1;
                     if(decision.OutPut=="")
                        document.getElementById("divElse").style.display="none";
                    elseExists = true;
                }
                else
                {
                    eval("window.Decision"+parseInt(i+1)+" =new Decision()"); 
                    eval("window.Decision"+parseInt(i+1)+" =decisionsObject["+i+"]");
                    AddMultipleOutputRow(parseInt(i+1));     
                    
                    //var innerHTML = AddMultipleOutputRow(parseInt(i+1));                   
                    //var divConditionLayersObj =document.getElementById("divConditionLayers");    
                    //divConditionLayersObj.innerHTML = divConditionLayersObj.innerHTML+ innerHTML;
                   
                    if(!isBack)
                        ConditionArray[ConditionArray.length]=parseInt(i+1);
                   strigifiedCondition = eval("window.Decision"+parseInt(i+1)+".ConditionString");
                   var FinalconditionalArray =new Array();
                   FinalconditionalArray = objectify(strigifiedCondition);
                   var innerHTMl ="";
                   innerHTMl = "<table width=100% cellspacing=2 cellpadding=2 align=center>";
                    
                   for(var j=0;j<FinalconditionalArray.length;j++)
                   {
                        var ConditionRow = FinalconditionalArray[j]; 
                        
                        innerHTMl = innerHTMl+"<tr>";
                        innerHTMl = innerHTMl+"<td width=7% >&nbsp;</td>";
                 
                        var lhsValue ="";
                        var rhsValue ="";       
                        
                        if(ConditionRow.LHSColumn.LHSMode=="Expression")
                            lhsValue = escapeHTML(DecodeTheExpressionString(ConditionRow.LHSColumn.ColumnExpression.DisplayExpressionString),false,0);
	                    else
	                        lhsValue =escapeHTML(ConditionRow.LHSColumn.DisplayText,false,0);
	                     
	                     
	                    if(ConditionRow.RHSMode=="default")
	                        rhsValue =escapeHTML(ConditionRow.RHSValue,false,0);
	                        
	                    else if(ConditionRow.RHSMode=="Expression")
                            rhsValue = escapeHTML(DecodeTheExpressionString(ConditionRow.RHSColumn.ColumnExpression.DisplayExpressionString),false,0);
	                    else
	                        rhsValue = escapeHTML(ConditionRow.RHSColumn.DisplayText,false,0);  
	                        
	                   
	                   if(trim(ConditionRow.LogicalOpr)!="")
	                        innerHTMl = innerHTMl+"<td width=93% class='tdbg' >"+ConditionRow.LogicalOpr +"&nbsp;"+lhsValue+"&nbsp;"+ ConditionRow.MHSDisplayText+"&nbsp;:"+rhsValue+"</td>";
                       else
                            innerHTMl = innerHTMl+"<td width=93% class='tdbg' >"+lhsValue+"&nbsp;"+ ConditionRow.MHSDisplayText+"&nbsp;:"+rhsValue+"</td>"; 
                            
                        innerHTMl = innerHTMl+"</tr>";
                   }     
                   var divObject = document.getElementById("divCondition"+parseInt(i+1));
                   innerHTMl += "</table>";
                   divObject.innerHTML = innerHTMl;  
                   
                   if(!isBack)
                        document.getElementById("totalRowCount").value=parseInt(document.getElementById("totalRowCount").value)+1;
                   
                  document.getElementById("txtOutPut"+parseInt(i+1)).value= eval("window.Decision"+parseInt(i+1)+".OutPut");  
                 
                }
           }          
        }    
        if(!elseExists)
        {
            document.getElementById("divElse").style.display="none";
        }
    }
    else
    {
        //var innerHTML = AddMultipleOutputRow(1,1);
        //var divConditionLayersObj =document.getElementById("divConditionLayers");    
          //  divConditionLayersObj.innerHTML = innerHTML;
        
        AddMultipleOutputRow(1,1);
        document.getElementById("totalRowCount").value = 2;
        ConditionArray[0]=1;
        window.Decision1 =new Decision(); 
       
        window.Decision2 =new Decision();
        window.Decision2.ConditionString='Else';
        ConditionArray[1]=2;
    }
    
     if(IsButtonAvailable == "no")
        {
        // alert("Form details not available");
         se.ui.messageDialog.showError( "<%=ProcessDesignerControl.GlobalResourceSet.GetString("Invoke Form Action Outputs")%>", "<%=ProcessDesignerControl.GlobalResourceSet.GetString("PD_Form_Invoke_Form_Output_details")%>");
        }
        
    
 
}

addiconImagePath ="<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(addiconImagePath, false)%>";
conditionalPageURL = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(ConditionalPageURL, false)%>";
LoadConditions(false);
function escapeHTML (str){var div = document.createElement('div');var text = document.createTextNode(str);div.appendChild(text);return div.innerHTML;}

</script>

<script>
function CloseWindowForNullData(decisions)
{
    var valid=false;
    if(decisions.length>0)
    {
        for(var i=0; i<decisions.length;i++)
        {
            var decision = decisions[i];
            
            if(decision!=null)
            {
                if((decision.ConditionString!="Else")&&(decision.ConditionString!=""))
                {
                    valid = true;
                }
                else
                {
                    if((decision.ConditionString!="Else")&&(trim(decision.OutPut)!=""))
                    {
                        valid = true;
                    }
                }
            }
        }
    }
    if(valid)
    {
        return true;
    }
    else
    {
        CallServerSideMethod(null, 'ResetData',"DataTableCondition",CallbackSaveProperty,'table',"");       
        return false;
    }
}
function ClickDelete1()
{
   
    //if(confirm(deleteConfirmLocal))
    //{
    //document.getElementById("hidPageType").value = "4";   
    //document.forms[0].submit();
    //}
    se.ui.messageDialog.showConfirmation('<%=ProcessDesignerControl.GlobalResourceSet.GetString("Invoke Form Action Outputs")%>',deleteConfirmLocal,
                        
                         function (userResponse) {
                           
                             if (userResponse) {
                                document.getElementById("hidPageType").value = "4";   
                                document.forms[0].submit();  
                             }
                         });


}
function ClickOK()
{
    
    if(document.getElementById("divSetCompletionMaker").style.display == 'block')
    {
        ClickOKAfterCompletionMaker();
    }
    else
    {
        //validate before proceeding with the next step
        var outputValToSetFlag = "";
        var decisions=new Array();
        var valid=true;
        var j =0;
        for(var i=0;i<ConditionArray.length;i++)
         {
            if(ConditionArray[i]!=0)
            {
                 var element =ConditionArray[i];   
                 
                 if(eval("window.Decision"+element)!=null)
                 {
                    var outputVal = "";
                     if(eval("window.Decision"+element+".ConditionString =='Else'"))
                        {
                           outputVal =document.getElementById("txtElseOutPut").value; 
                        }
                     else
                        {
                            outputVal =document.getElementById("txtOutPut"+element).value;  
                        }
                        eval("window.Decision"+element+".OutPut=outputVal");
                        outputValToSetFlag = outputValToSetFlag + outputVal+ ";"; 
                        decisions[i]=eval("window.Decision"+element);  
                       j = parseInt(j+1);
                }
            }     
         }
         //Cannot have invalid decisions on click of ok
         //var isDataAvailable = CloseWindowForNullData(decisions);
         //if(isDataAvailable)
        // {
             valid = validatedecisions(decisions);
         
             if(valid)
             {   
                document.getElementById("hidPageType").value = "1";
                //store all possible outputs in one hidden variable with semicolon separated and then submit the form 
                document.getElementById("hidOutputs").value = outputValToSetFlag;
                document.getElementById("hidOutputsTotatCount").value = j;//implemented since if user deletes existing row then to get actual row count
                
                //to set the output values
                newDecisions = formatDecisions(decisions);
                var stringified = stringify(newDecisions);
                stringified = stringified;
                document.getElementById("hidJsDecisionBeforeCompletionMaker").value = stringified;//to retain the prevoius conditions
                        
                document.forms[0].submit();
            }
        //}
    }
 }
 //on page load
 
 if(document.getElementById("hidPageType").value == "1") 
 {

    if(document.getElementById("divSetCompletionMaker").style.display == 'block')
    {
        document.getElementById("divSetOutput").style.display = 'block';
        document.getElementById("btnOk").value=nextButtonText;
        document.getElementById("divSetCompletionMaker").style.display = 'none';
        ClickOKAfterCompletionMaker();
    }
    else
    {
        document.getElementById("divSetOutput").style.display = 'none';
        document.getElementById("divSetCompletionMaker").style.display = 'block';
        document.getElementById("btnOk").value=okButtonText;
        document.getElementById("btnBack").style.visibility = 'visible';
        for(var i=0;i<ConditionArray.length;i++)
        {
            if(ConditionArray[i]!=0)
            {
                 var element =ConditionArray[i];  
                 
                  if(eval("window.Decision"+element)!=null)
                 {
                    if(eval("window.Decision"+element+".ConditionString =='Else'"))
                    {
                       var elseOutput =document.getElementById("txtElseOutPut").value; 
                       eval("window.Decision"+element+".OutPut =elseOutput");                   
                    }
                    else
                    {
                        var outputVal =document.getElementById("txtOutPut"+element).value; 
                    }   
                 }    
            }
       }
   }
}

 
function ClickOKAfterCompletionMaker()
{
  var decisions=new Array();
  var valid=true;
  /*if(trim(document.getElementById("txtElseOutPut").value)!="")
  {
    var newrowcount = parseInt(document.getElementById("totalRowCount").value) + 1;
    eval("window.Decision"+newrowcount+" =new Decision()");
    eval("window.Decision"+newrowcount+".ConditionString='Else'");
    ConditionArray[ConditionArray.length]=newrowcount;
 }*/
 
 for(var i=0;i<ConditionArray.length;i++)
 {
    if(ConditionArray[i]!=0)
    {
         var element =ConditionArray[i];   
         
         if(eval("window.Decision"+element)!=null)
         {
             if(eval("window.Decision"+element+".ConditionString =='Else'"))
                {
                   var elseOutput =document.getElementById("txtElseOutPut").value; 
                   eval("window.Decision"+element+".OutPut =elseOutput");                   
                }
             else
                {
                    var outputVal =document.getElementById("txtOutPut"+element).value;  
                    eval("window.Decision"+element+".OutPut=outputVal");
                    /*if(document.getElementById("checkHalt"+element).checked==true)
                        eval("window.Decision"+element+".HaltExecution=true");
                    else
                        eval("window.Decision"+element+".HaltExecution=false");*/
                }
                decisions[i]=eval("window.Decision"+element);  
        }
    }     
 }
 
 valid = validatedecisions(decisions) ;
 
 
 if(valid)
 { 
     //to set the output values
     
     newDecisions = formatDecisions(decisions);
     var stringified = stringify(newDecisions);
     stringified = stringified;
    
     CallServerSideMethod(null, 'SaveProperty',"DataTableCondition",CallbackSaveProperty,'table',stringified);  
     
     
     //to set the completionMaker
     var completionMaker = GetCompletionMakerData();//"yes,Approve;no,Reject";//pending try to pass array object issue may come if output contains , or ; chars     
     CallServerSideMethod(null, 'CompletionMaker',"DataTableCondition",CallbackCompletionMaker,'table',completionMaker);               
     
 }
 else
 {
    return false;
 }
}
/*
Not required since the final output sectioin is removed from this property
function onCompletionMakerChange()
{
    var chkAffirmativeTableRef = document.getElementById('chkSoleAffirmation');
    if(chkAffirmativeTableRef!=null)
    {
        var rowLength = chkAffirmativeTableRef.rows.length;
        for(var l=0;l<rowLength;l++)
        {
            var cellLength = chkAffirmativeTableRef.rows(0).cells.length;
            for(var c=0;c<cellLength;c++)
                chkAffirmativeTableRef.rows(0).deleteCell(0);
               
            chkAffirmativeTableRef.rows(0).removeNode();    
        }
    }
    var lmtAffirmationDropDown = document.getElementById('ddlLimitAffirmation');
    lmtAffirmationDropDown.options.length=0;
 
     var contradictionDropDown = document.getElementById('ddlContradiction');
     contradictionDropDown.options.length=0;
 
    var rowCount = parseInt(document.getElementById("totalRowCount").value);
    for(var i=1;i<=rowCount;i++)
    {
        if(document.getElementById("selCompletionMakerID"+i).options[0].selected)
        {
            var outputValue = document.getElementById("output"+i).value;
            addItemToAffirmationControls(outputValue,outputValue);
        }
      
    }
}

function CallbackToShowAffirmation(context, result, response)
{
    document.getElementById("hidPageType").value = "3"; 
  
    document.form1.submit();
    document.getElementById("divSetOutput").style.display = 'none';
    document.getElementById("divSetCompletionMaker").style.display = 'none';
    document.getElementById("divAffirmativeChecked").style.display = 'block';
    document.getElementById("btnOk").value=okButtonText;  
}

function addItemToAffirmationControls(textValue, valueValue)
{
 var chkAffirmativeTableRef = document.getElementById('chkSoleAffirmation');
 var chkAffirmativeTableRow = null;
 var chkAffirmativeTableCell = null;
 var existingRows = chkAffirmativeTableRef.rows.length;
 for(var i=0;i<existingRows;i++)
    {
        if(chkAffirmativeTableRef.rows(i).cells.length<2)
        {
            chkAffirmativeTableRow = chkAffirmativeTableRef.rows(i);
            break;
        }
       
    }
 if(chkAffirmativeTableRow == null)
    chkAffirmativeTableRow = chkAffirmativeTableRef.insertRow(); 
    
 var chkAffirmativeTableCell = chkAffirmativeTableRow.insertCell();

 var chkAffirmativeCheckBoxRef = document.createElement('input');
 var chkAffirmativeLabelRef = document.createElement('label');

 chkAffirmativeCheckBoxRef.type = 'checkbox';
 chkAffirmativeLabelRef.innerHTML = textValue;
 chkAffirmativeCheckBoxRef.value = valueValue;
 

 chkAffirmativeTableCell.appendChild(chkAffirmativeCheckBoxRef);
 chkAffirmativeTableCell.appendChild(chkAffirmativeLabelRef);
  
 

 var lmtAffirmationDropDown = document.getElementById('ddlLimitAffirmation');
 var optnAffirmation = document.createElement("OPTION");
 optnAffirmation.text = textValue;
 optnAffirmation.value = valueValue;
 lmtAffirmationDropDown.options.add(optnAffirmation);
 
 var contradictionDropDown = document.getElementById('ddlContradiction');
 var optnContradict = document.createElement("OPTION");
 optnContradict.text = textValue;
 optnContradict.value = valueValue;
 contradictionDropDown.options.add(optnContradict);
 
}

function ShowAffirmative(chkAffirmation)
{
    if(chkAffirmation.checked)
    {
        document.getElementById("divAffirmativeChecked").style.display = 'block';
        document.getElementById("divAffirmativeUnchecked").style.display = 'none';
        document.getElementById("divAffirmativeUnchecked").style.position = 'absolute';        
    }
    else
    {
        document.getElementById("btnOk").value=nextButtonText;
        document.getElementById("divAffirmativeChecked").style.display = 'none';
        document.getElementById("divAffirmativeChecked").style.position = 'absolute';
        document.getElementById("divAffirmativeUnchecked").style.display = 'block';   
    }
}

ShowAffirmative(document.getElementById("chkAffirmative"));

function EnableDisableLimitOutPut()
{

     var elementRef = document.getElementById('<%= chkSoleAffirmation.ClientID %>');
     var checkBoxArray = elementRef.getElementsByTagName('input');
     for (var i=0; i<checkBoxArray.length; i++) 
     { 
      var checkBoxRef = checkBoxArray[i];
      
     
            var labelArray = checkBoxRef.parentNode.getElementsByTagName('label');

           if ( labelArray.length > 0 )
           {
                for(var l=1;l<=checkBoxArray.length;l++)
                {
                    var limitoutput = eval(document.getElementById("limitoutput"+l));
                    var limitoutputval = eval(document.getElementById("limitoutputvalue"+l));
                    if(limitoutput.value==labelArray[0].innerHTML)
                    {
                        if ( checkBoxRef.checked == true ) 
                        {
                            limitoutput.disabled = true;
                            limitoutputval.disabled= true;
                        }
                        else
                        {
                            limitoutputval.disabled= false;
                            limitoutput.disabled = false;
                        }
                    }
                }   
                
           }
       
     }

}
*/
function GetCompletionMakerData()
{
    var rowCount = parseInt(document.getElementById("totalRowCount").value);
    var  updateOnlyForCM= "";
    if(document.getElementById("chkUpdateOutPutXMLOnlyForCompMakers").checked)
        updateOnlyForCM= "Yes";
    else
        updateOnlyForCM= "No";
        
    var completionMakerData = "<Outputs UpdateOnlyForCM='"+updateOnlyForCM+"'>";
    for(var i=1;i<=rowCount;i++)
    {
        if(document.getElementById("output"+i)!=null)
        {
            var outputValue = document.getElementById("output"+i).value;
            if(document.getElementById("selCompletionMakerID"+i).options[0].selected)
            {
                completionMakerData += "<Data Output='"+outputValue+"' status='yes'></Data>";
            }
            else
            {
                completionMakerData += "<Data Output='"+outputValue+"' status='no'></Data>";
            }
        }
    }
    completionMakerData += "</Outputs>";
    
    return completionMakerData;
}
function CompletionMakerData(output,status)
{
this.output=output;
this.status=status;
}
function AffirmativeQuery()
{
    this.AffirmativeOutput = "";
    this.AffirmativePercentage = "";
    this.AffirmativeNegativeOutput = "";
}

    


function CallbackSaveProperty(context, result, response)
{    
    window.opener.parent._skProcessDesigner.refreshaction();
    window.opener.parent._skProcessDesigner.RefreshProperties();   
          
    if(navigator.userAgent.toLowerCase().indexOf("chrome") < 0)
    {        
        window.setTimeout('window.close()',50);
    }
    else
    {
        window.setTimeout('window.close()',5000);
    }
}
function CallbackCompletionMaker(context, result, response)
{
    window.setTimeout('window.close()',50);    
}

function formatDecisions(decisions)
{
    var newDecisions=new Array();
    var elsedecision;
    
    if(decisions.length>0)
    {
        for(var i=0; i<decisions.length;i++)
        {
            var decision = decisions[i];
            
            if((decision!=null)&&(decision.ConditionString!="Else"))
            {
                newDecisions[newDecisions.length] = decision;
                
                if((decision.ConditionString!="Else")&&(decision.ConditionString==""))
                {
                    valid = false;
                   // alert(buildvalidconforrule);
                    se.ui.messageDialog.showError( "<%=ProcessDesignerControl.GlobalResourceSet.GetString("Invoke Form Action Outputs")%>", buildvalidconforrule);
                    break;            
                }
                else
                {
                    if((decision.ConditionString!="Else")&&(trim(decision.OutPut)==""))
                    {
                        valid = false;
                        // alert(enteropforruleLocal);
                        se.ui.messageDialog.showError( "<%=ProcessDesignerControl.GlobalResourceSet.GetString("Invoke Form Action Outputs")%>", enteropforruleLocal);
                        break;            
                    }
                }
            }
            else 
            {
                if(decision!=null)
                {
                    if((decision.ConditionString=="Else"))
                        elsedecision = decision;
                }
            }
        }
        
        newDecisions[newDecisions.length] = elsedecision;
    }
    return newDecisions;
}

function validatedecisions(decisions)
{

    var valid=true;
    if(decisions.length>0)
    {
        var alldecisions="";
        var conditionElsePresent="false";
        var decisionsArray = new Array();
        var count=0;
        for(var i=0; i<decisions.length;i++)
        {
            var decision = decisions[i];
            
            if(decision!=null)
            {
            
                if(decision.ConditionString.toLowerCase()=="else")
                    conditionElsePresent ="true";
                //if((decision.ConditionString!="Else")&&(decision.ConditionString==""))
                if(decision.ConditionString=="")
                {
                    valid = false;
                    // alert(buildvalidconforrule);
                    se.ui.messageDialog.showError( "<%=ProcessDesignerControl.GlobalResourceSet.GetString("Invoke Form Action Outputs")%>", buildvalidconforrule);
                    break;            
                }
                else
                {
                    //if((decision.ConditionString!="Else")&&(trim(decision.OutPut)==""))
                    if(trim(decision.OutPut)=="")
                    {
                        valid = false;
                        // alert(enteropforruleLocal);
                        se.ui.messageDialog.showError( "<%=ProcessDesignerControl.GlobalResourceSet.GetString("Invoke Form Action Outputs")%>", enteropforruleLocal);
                        break;            
                    }
                    else
                    {
                        if(trim(decision.OutPut).match(/[!#$~`&*(){}@:;_+<>,./\\|\"'?^%]/)!=null)
                        {
                            valid = false;
                            //alert(enterspexists);
                            se.ui.messageDialog.showError( "<%=ProcessDesignerControl.GlobalResourceSet.GetString("Invoke Form Action Outputs")%>", enterspexists);
                            break;
                        }
                        else
                        {
                            if(trim(decision.OutPut).indexOf('-')>0) //Found issue when included in reg exp
                            {
                            valid = false;
                                // alert(enterspexists);
                            se.ui.messageDialog.showError( "<%=ProcessDesignerControl.GlobalResourceSet.GetString("Invoke Form Action Outputs")%>", enterspexists);
                            break;
                            }
                        }
                        if(alldecisions.indexOf(decision.OutPut+"{#$%}")>=0)
                        {
                           for(var j=0; j<count;j++)
                            {
                                if(decision.OutPut==decisionsArray[j])
                                {
                                    valid = false;
                                   // alert(enteropexists);
                                    se.ui.messageDialog.showError( "<%=ProcessDesignerControl.GlobalResourceSet.GetString("Invoke Form Action Outputs")%>", enteropexists);
                                    break;  
                                }
                            }  
                        }
                        alldecisions+=decision.OutPut+"{#$%}";
                        decisionsArray[count]=decision.OutPut;
                        count++;
                    }
                    
                }
            }
        }
        if(conditionElsePresent=="true" && count==1)
        {
            valid = false;
            // alert(buildvalidconforrule);
            se.ui.messageDialog.showError( "<%=ProcessDesignerControl.GlobalResourceSet.GetString("Invoke Form Action Outputs")%>", buildvalidconforrule);
            return;            
        }
    }
    return valid;
}
function GenerateButtonUI()
{
    document.getElementById("hidPageType").value = "2";   
    document.forms[0].submit();
}
function ShowHideElseRow(show)
{
    if(show)
    {
         if(document.getElementById("divElse").style.display=="block")
         {
             // alert(elseconditionexists);
             se.ui.messageDialog.showError( "<%=ProcessDesignerControl.GlobalResourceSet.GetString("Invoke Form Action Outputs")%>", elseconditionexists);
            return true;
         }
         
         var elseConditionAvailable = false;   
         
          for(var i=0;i<ConditionArray.length;i++)
            {
                if(eval("window.Decision"+parseInt(i+1))!=null)
                {
                    if(eval("Decision"+parseInt(i+1)+".ConditionString")=="Else")
                    {
                        ConditionArray[i]=parseInt(i+1);
                        elseConditionAvailable = true;
                        break;
                    }
                }
            }
            if(!elseConditionAvailable)
            {
                var RowsCount=document.getElementById("totalRowCount").value;
                var newRowCount = parseInt(RowsCount)+1;
                document.getElementById("totalRowCount").value = newRowCount;
                eval("window.Decision"+newRowCount+" =new Decision()");
                eval("Decision"+newRowCount+".ConditionString=\"Else\"");
                ConditionArray[ConditionArray.length]=newRowCount;
         
            }
         document.getElementById("divElse").style.display="block";
    }
    else
    {
        for(var i=0;i<ConditionArray.length;i++)
        {
            if(eval("window.Decision"+parseInt(i+1))!=null)
            {
                if(eval("window.Decision"+parseInt(i+1)+".ConditionString")=="Else")
                {
                    eval("Decision"+parseInt(i+1)+".OutPut=\"\"");
                    ConditionArray[i]=0;
                    break;
                }
            }
        }
        document.getElementById("txtElseOutPut").value="";
        document.getElementById("divElse").style.display="none";
    }
}




</script>

