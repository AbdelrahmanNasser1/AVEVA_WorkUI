<%@ Page Language="C#" AutoEventWireup="true"  Inherits="Workflow.NET.Web.Designer.ExpressionBuilder.DecisionUI" Theme="" StylesheetTheme="" %>
<%@ Register TagPrefix="cc1" Namespace="Workflow.NET.Ajax" Assembly="Workflow.NET.NET2" %>
<link rel="stylesheet" type="text/css" href="<%=ProcessDesignerControl.GetThemeRelativeUrl("Common/stylesheet/Global.css")%>">
<script src="<%=ProcessDesignerControl.GetJscriptUrl("../Common/javascripts/DecisionScript.js")%>"></script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html >
<head id="Head1" runat="server">
    <title><%:PageTitle%></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
</head>
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
<body onload="Initialize();" >
    <script>
        se.ui.messageDialog.setGlobalOptions({
            localization: { // All localization related default can be set
                closeButtonCaption: "<%=ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                okButtonCaption: "<%=ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                cancelButtonCaption: "<%=ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                showDetailsCaption: "<%=ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                hideDetailsCaption: "<%=ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
            }
        });
    </script>
<form id="form1" runat="server">
     <%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <link href="<%:bellyBarPath%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
<div>
    <table cellspacing=0 cellpadding=0 width=100% border=0 >
      <tr>
           <td align="center">
           <table border=0 width=100% align=center ID="Table2" cellpadding="0" cellspacing="0" >
               <tr class="ListHeaderCss">
                   <td class="fontheading" width=30% align=left style="padding-left:20px"><span class="subtitle"><%=ProcessDesignerControl.GlobalResourceSet.GetString("DecisionDecision")%></span></td>
                    <td class="fontheading" valign="middle" width=70% align="right"><a href="#" onclick="javascript:window.open('<%=ProcessDesignerControl.GetHelpPageUrl()%>Dec-Decisions.html','newwin','width=600,height=500,resizable=yes,status=no,scrollbars=yes')">
				   <img border="0" src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ProcessDesignerControl.GetCommonRelativeUrl("Images/main-help.gif"))%> " align="right"  style="cursor:pointer" alt="<%=ProcessDesignerControl.GlobalResourceSet.GetString("Help")%>"/></a></td>
               </tr>
				<tr>
			    	<td class="lefttdbg" colspan=2 align=center>
				        <table border=0 width=94% ID="Table1" cellpadding="0" cellspacing="0">
                            <tr>
                                 <td><img src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ProcessDesignerControl.GetCommonRelativeUrl("images/spacer.gif"))%>" height="4" border="0"></td>
                            </tr> 				           
  				            <tr>
				                 
				                 <td width="99%" class="description" style="padding-left:20px"><a href="#" onclick="javascript:AddNewRow()" class="textlinkblackNormal"><img src="<%:ProcessDesignerControl.GetCommonRelativeUrl("images/new-row.gif")%>" align="absmiddle" border="0" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=ProcessDesignerControl.GlobalResourceSet.GetString("DecisionAddRule")%></a></td>
				            </tr>
				            <tr>
                                 <td><img src="<%:ProcessDesignerControl.GetCommonRelativeUrl("images/spacer.gif")%>" height="4" border="0"></td>
                            </tr> 				           
				            <tr>
				                <td colspan=2 >
			                            <div id="divMain"  style="Overflow: auto;width:100%;Height:545px; CURSOR: text; TEXT-ALIGN:center;" class="description">
		                                <table width=100% cellspacing=0 cellpadding=0 class="lefttdbg">
		                                      <tr>
		                                          <td align="center">
		                                                <div id="divConditionLayers">
		                                                 </div>
                                                         <div id="divElse">
                                                         <table width="96%" cellspacing="0" cellpadding="5" border="0" style="flex-align:initial">
                                                            <tr>
                                                                <td width="100%">
                                                                   <table width="100%" id="TableExpression1"  border=0 cellspacing=0 cellpadding="0">

                                                                        <tr>
                                                                           <td colspan=5 align="left">
                                                                               <table cellpadding="0" cellspacing="0" border="0" width="99%">
                                                                                   <tr class="description" >
                                    <td colspan="5" style="height:15px;text-align:left">
                                        <div class="lineCss"></div>
                                    </td>
                                    </tr>
                                                                                 <tr>
                                                                                    <td width=100%>
                                                                                   

										                                            
											                                            <table width=100% cellpadding=0 cellspacing=0 border="0">
                                                                                            
                                                                                            <tr>
                                                                                                <td valign="middle" height="25" class="header2"><span class="description">[ <%=ProcessDesignerControl.GlobalResourceSet.GetString("DecisionElse")%> ] (<%=ProcessDesignerControl.GlobalResourceSet.GetString("DecisionNoneofaboveconditiontrue")%>)</span></td>
                                                                                            </tr>
											                                             <tr>
											                                              <td colspan=4 width=100%>
											                                                <table id ="TableElse" cellpadding="5" cellspacing="0" border="0" height="50" width="100%">
												                                                <tr>
												                                                    <td width=59 class="description" align="right">
												                                                        <%=ProcessDesignerControl.GlobalResourceSet.GetString("DecisionOutput")%>
												                                                     </td>
												                                                     <td>
												                                                     <input type="text" id="txtElseOutPut" name="txtElseOutPut" class="inputtext" maxlength="50"  style="width:200px"/>&nbsp;
												                                                     </td>
												                                                </tr>
																					            </table>
																					             <tr>
												                                                    <td   height="22" align="right"></td>
												                                                </tr>
												                                        </table>
												                                    </fieldset>
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
                                              </td>    
		                                   </tr>
		                                </table>
        	                         </div>
				                </td>
				            </tr>
				            
				            <tr>
                                 <td><img src="<%:ProcessDesignerControl.GetCommonRelativeUrl("images/spacer.gif")%>" height="1" border="0"></td>
                            </tr>
                        </table>
                     </td>   
                 </tr>
                 <tr class="">
                     <td colspan="2">
                       <table width="100%" border="0" cellspacing="0" cellpadding="0">
                         <tr>
                            <td width="100%"  id="Td2" align="right">
                                   <input type="button" id="btnCancel" name="btnCancel" value="<%=ProcessDesignerControl.GlobalResourceSet.GetString("DecisionCancel")%>" onClick="window.close();" class="inputsecondarybutton">
                                       <input type="button" id="btnOk" name="btnOk" value="&nbsp;&nbsp;<%=ProcessDesignerControl.GlobalResourceSet.GetString("DecisionOk")%> &nbsp;&nbsp;" onClick="javascript:ClickOK();" class="inputbutton">	                                
                                &nbsp;
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
var stopprocessLocal = "<%=ProcessDesignerControl.GlobalResourceSet.GetString("DecisionStopProcessing")%>";
var enteropforruleLocal = "<%=ProcessDesignerControl.GlobalResourceSet.GetString("DecisionEnteropforrule")%>";
var buildvalidconforrule = "<%=ProcessDesignerControl.GlobalResourceSet.GetString("DecisionBuildvalidconforrule")%>";
var conditionFailedstring = "<%=ProcessDesignerControl.GlobalResourceSet.GetString("Condition Failed")%>";
var enterdifferentoutput= "<%=ProcessDesignerControl.GlobalResourceSet.GetString("EnterDifferentOutput")%>";

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
        document.getElementById("divMain").style.height=540;
        document.getElementById("TableElse").style.width=630;
        //document.getElementById("conditionEditImage").vspace=13; //commented as IE 11 not recognizing vspace
    }
}

function LoadConditions()
{
    var decisionsObject=new Array();
    var strigified = document.getElementById("HiddenJsDecisionString").value;
    decisionsObject =objectify(strigified);
    
    if(decisionsObject!=null)
    {
        for(var i=0;i<=decisionsObject.length;i++)
        {
           var decision = decisionsObject[i];
           
           if(decision!=null)
           {
                if(decision.ConditionString=="Else")
                {
                    
                    eval("window.Decision"+parseInt(i+1)+" =new Decision()"); 
                    eval("window.Decision"+parseInt(i+1)+" =decisionsObject["+i+"]"); 
                    ConditionArray[ConditionArray.length]=parseInt(i+1);
                    document.getElementById("txtElseOutPut").value= eval("window.Decision"+parseInt(i+1)+".OutPut"); 
                    document.getElementById("totalRowCount").value=parseInt(document.getElementById("totalRowCount").value)+1;
        
                }
                else
                {
                    eval("window.Decision"+parseInt(i+1)+" =new Decision()"); 
                    eval("window.Decision"+parseInt(i+1)+" =decisionsObject["+i+"]");     
                    var innerHTML = AddRow(parseInt(i+1));
                    var divConditionLayersObj =document.getElementById("divConditionLayers");    
                    divConditionLayersObj.innerHTML = divConditionLayersObj.innerHTML+ innerHTML;
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
	                        innerHTMl = innerHTMl+"<td width=93% class='description' >"+ConditionRow.LogicalOpr +"&nbsp;"+lhsValue+"&nbsp;"+ ConditionRow.MHSDisplayText+"&nbsp;:"+rhsValue+"</td>";
                       else
                            innerHTMl = innerHTMl+"<td width=93% class='description' >"+lhsValue+"&nbsp;"+ ConditionRow.MHSDisplayText+"&nbsp;:"+rhsValue+"</td>"; 
                            
                        innerHTMl = innerHTMl+"</tr>";
                   }     
                   var divObject = document.getElementById("divCondition"+parseInt(i+1));
                   innerHTMl += "</table>";
                   divObject.innerHTML = innerHTMl;  
                   
                   document.getElementById("totalRowCount").value=parseInt(document.getElementById("totalRowCount").value)+1;
                   
                  if(eval("window.Decision"+parseInt(i+1)+".HaltExecution==true"))
                    document.getElementById("checkHalt"+parseInt(i+1)).checked=true;
                 
                  document.getElementById("txtOutPut"+parseInt(i+1)).value= eval("window.Decision"+parseInt(i+1)+".OutPut");  
                 
                }
           }          
        } 
        
        if(GetBrowserversion() != 0)
        {
            //To reset the outputs as there was some issues encountered
            for(var i=0;i<=decisionsObject.length;i++)
            {
                if (document.getElementById("txtOutPut" + parseInt(i + 1)) != null ) {
                    document.getElementById("txtOutPut" + parseInt(i + 1)).value = eval("window.Decision" + parseInt(i + 1) + ".OutPut");
                }
                
                if(document.getElementById("checkHalt"+parseInt(i+1)) !=null)
                {
                    if(eval("window.Decision" + parseInt(i + 1) + ".HaltExecution==true"))
                        document.getElementById("checkHalt"+parseInt(i+1)).checked=true;
                }
                
            }
        }   
    }
    else
    {
        var innerHTML = AddRow(1,1);
        var divConditionLayersObj =document.getElementById("divConditionLayers");    
        divConditionLayersObj.innerHTML = innerHTML;
        document.getElementById("totalRowCount").value = 2;
        ConditionArray[0]=1;
        window.Decision1 =new Decision(); 
       
        window.Decision2 =new Decision();
        window.Decision2.ConditionString='Else';
        ConditionArray[1]=2;
    }
 
}

addiconImagePath ="<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(addiconImagePath, false)%>";
conditionalPageURL = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(ConditionalPageURL, false)%>";
LoadConditions();
function escapeHTML (str){var div = document.createElement('div');var text = document.createTextNode(str);div.appendChild(text);return div.innerHTML;}

</script>

<script>

function ClickOK()
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
                    if(document.getElementById("checkHalt"+element).checked==true)
                        eval("window.Decision"+element+".HaltExecution=true");
                    else
                        eval("window.Decision"+element+".HaltExecution=false");
                }
                decisions[i]=eval("window.Decision"+element);  
        }
    }     
 }
 
 valid = validatedecisions(decisions) ;
 
 
 if(valid)
 { 
    newDecisions = formatDecisions(decisions);
     var stringified = stringify(newDecisions);
     CallServerSideMethod(null, 'SaveProperty',"DataTableCondition",CallbackSaveProperty,'table',stringified);       
 }
 else
 {
    return false;
 }
}

function CallbackSaveProperty(context, result, response)
{
    window.opener.parent._skProcessDesigner.refreshaction();
    window.opener.parent._skProcessDesigner.RefreshProperties();
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
                    se.ui.messageDialog.showError('<%=ProcessDesignerControl.GlobalResourceSet.GetString("DecisionDecision")%>', buildvalidconforrule);
                    break;            
                }
                else
                {
                    if((trim(decision.OutPut)==""))
                    {
                        valid = false;
                        se.ui.messageDialog.showError('<%=ProcessDesignerControl.GlobalResourceSet.GetString("DecisionDecision")%>', enteropforruleLocal);
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

function validatedecisions(decisions) {    
    var valid=true;
    if(decisions.length>0)
    {
        for(var i=0; i<decisions.length;i++)
        {
            var decision = decisions[i];
            
            if(decision!=null)
            {
                if((decision.ConditionString!="Else")&&(decision.ConditionString==""))
                {
                    valid = false;
                    se.ui.messageDialog.showError('<%=ProcessDesignerControl.GlobalResourceSet.GetString("DecisionDecision")%>', buildvalidconforrule);
                    break;            
                }
                else
                {
                    if ((trim(decision.OutPut) == ""))
                    {
                        valid = false;
                        se.ui.messageDialog.showError('<%=ProcessDesignerControl.GlobalResourceSet.GetString("DecisionDecision")%>', enteropforruleLocal);
                        break;
                    }
                    else if (trim(decision.OutPut)== conditionFailedstring) 
                    {
                        valid = false;
                        se.ui.messageDialog.showError('<%=ProcessDesignerControl.GlobalResourceSet.GetString("DecisionDecision")%>', enterdifferentoutput);
                        break;
                    }                    
                }               
            }
        }
    }
    return valid;
}



</script>

