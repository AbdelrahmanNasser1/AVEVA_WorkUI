<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.SkeltaListStorageIteratorCodeFile" %>
<%@ Register TagPrefix="cc2" Namespace="Workflow.NET.Ajax" Assembly="Workflow.NET.NET2" %>
<%@ Register Assembly="Workflow.NET.Web.Designer.NET2" Namespace="Workflow.NET.Web.Designer" TagPrefix="cc1" %>
<link rel="stylesheet" type="text/css" href="<%=ProcessDesignerControl.GetCommonRelativeUrl("/stylesheet/global.css")%>">
<script src="<%=ProcessDesignerControl.GetJscriptUrl("../Common/javascripts/XmlTreeview.js")%>"></script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head id="Head1" runat="server">
    <title>XMl Iterator</title>
</head>
    <style>
        html, body {
            height:100%;
            overflow:auto;
            overflow-x:hidden !important;
        }
    </style>
<body>
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=cssPath %>CommonUXControls/StyleSheet/se.ui.min.css" />      
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
    <form id="form1" runat="server" method="post">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
      <table width=100% cellpadding=0 cellspacing=0  height="100%" border="0" class="tablebg">
            
            <tr>
                <td align="center" valign="top">
                    
                            <table width=100% cellspacing=1 cellpadding=2 height="100%" border=0>
                               
                             <tr>
                                <td class="lefttdbg" align="left" width="20%">
                                    <span class="description"> <%=ProcessDesignerControl.GlobalResourceSet.GetString("List XML Variable") %></span>
                                </td>
                                <td class="righttdbg"  width = "80%" align="left">
                                   <select id="XmlVaraiableList" class="inputselect" onchange="javascript:LoadParentXMLSchema(this)">  
                                        <option>--<%=ProcessDesignerControl.GlobalResourceSet.GetString("Select") %>--</option>
                                        <%=optionList%>
                                    </select>
                                </td>
                           </tr>
                            <tr>
                                <td colspan="2" class="lefttdbg" align="left">
                                    <table height="100%">
                                        <tr>
                                            <td>
                                                <span class="description"><%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariableSchema")%></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width=100% colspan="2" class="lefttdbg">
                                                <cc1:XmlSchemaDesigner ID="XmlSchemaDesigner1" Width="680px" Height="290px" IsSchemaEditable=false runat="server" />              
                                            </td>  
                                        </tr>
                                    </table>
                                    
                                </td>
                            </tr>
                        
                        </table>
                    
                </td>
            </tr>
            <tr class="lefttdbg">
                <td align="right" valign="top" >
                    <table cellpadding=1 cellspacing=1>
                        <tr>
                            <td>
                            <input type="button" id="btnCancel" value="<%=ProcessDesignerControl.GlobalResourceSet.GetString("ExpCancel")%>" class="inputsecondarybutton"  onclick="javascript:window.parent.close();"  />&nbsp;&nbsp;&nbsp;     
                                <input type="button" id="btnSave" value="<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlSaveVariable")%>" class="inputbutton" onclick="javascript: CallServer()" />    
                            </td>
                        </tr>
                   </table>
                    
                </td>
            </tr>
            
        </table>
    
    <input type="hidden" id="variablename" name="variablename"/> 
    <input type="hidden" id="variabledesc" name="variabledesc"/> 
    <input type="hidden" id="selNodexpath" name="selNodexpath" value="<%=selNodeParentxpath %>"/> 
    <input type="hidden" id="variablexpath" name="variablexpath" value ="<%=selNodexpath%>"  /> 
    <cc2:AjaxPageControl id="AjaxPageControl1" runat="server" style="Z-INDEX: 104; LEFT: 440px; POSITION: absolute; TOP: 88px"></cc2:AjaxPageControl>        
    </form>
</body>
</html>

<script>
CmbDIR_IMAGES  =   '<%=ProcessDesignerControl.GetCommonRelativeUrl()%>';
CmbDIR_IMAGES = CmbDIR_IMAGES +'/Images/';
    
CmbIMG_PLUS    =   CmbDIR_IMAGES + "btnPlus.gif";
CmbIMG_MINUS   =   CmbDIR_IMAGES + "btnMinus.gif";
CmbangleImage = CmbDIR_IMAGES+"angle.gif"
CmbMenuGif = CmbDIR_IMAGES+"9.gif"

CmbimgPlus.src = CmbIMG_PLUS;
CmbimgMinus.src = CmbIMG_MINUS;


var browsercode=GetBrowserversion();

var txareaObj = document.getElementById("xslText");

if(browsercode!=1)
{
if(txareaObj!=null)
{
txareaObj.rows=24;
txareaObj.cols=113;
}
}

var emode = "<%=Editvariable%>";
LoadDetails();
function LoadDetails()
{
    
    if(emode=="yes")
    {
    LoadParentXMLSchema(document.getElementById("XmlVaraiableList"));
    }
}

function LoadParentXMLSchema(control)
{
    var selectedValue = control.options[control.selectedIndex].value;
    var sendObj = selectedValue+"~"+"No";//No for Not concatenate
    var selectedData  = selectedValue.split('~');
    document.getElementById("selNodexpath").value = selectedData[2]; 
    document.getElementById("variablexpath").value = selectedData[2];     
    CallServerSideMethod(null, 'LoadTreeForXPath',"DataTableTest",CallbackLoadTreeForXPath,'table',sendObj);
}


function CallbackLoadTreeForXPath(context, result, response)
{
   
   var objTree = new jsTree;
   eval(result);
   document.getElementById("xmlTreeDiv").innerHTML = "";
   objTree.buildDOM();   
   var strInnerHTML = document.getElementById("xmlTreeDiv").innerHTML;
   document.getElementById("xmlTreeDiv").innerHTML = strInnerHTML.replace("<DIV><DIV>",""); 
}

function CallServer()
{  
  
    if(top.document.getElementById("variableName").value=="")
    {
        top.document.getElementById("variableName").focus();
        se.ui.messageDialog.showError('<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariables")%>', '<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariableEnterVariableName")%>');
        return false;
    }
    else
    {
        if (!CheckInputValue(top.document.getElementById("variableName").value))
        {
            top.document.getElementById("variableName").focus();
            return false;
        }
    }  
    
    if(trim(document.getElementById("XmlVaraiableList").value)=="")
    {
        se.ui.messageDialog.showError('<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariables")%>', '<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariableSelectXmlVariable")%>');
        return false;
    }
    
    if(trim(document.getElementById("selNodexpath").value)=="")
    {
        se.ui.messageDialog.showError('<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariables")%>', '<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariableSelectNode")%>');
        return false;
    }
  
    
    var xVariable =new XmlVariable();
    xVariable.VaraiableName = top.document.getElementById("variableName").value;
    xVariable.VaraiableDescription = top.document.getElementById("VarDescription").value;
    xVariable.ParentVariableName = document.getElementById("XmlVaraiableList").value;
    xVariable.ParentNodeXPath = document.getElementById("selNodexpath").value;
    xVariable.EditMode = top.document.getElementById("HdnModeEdit").value;
    xVariable.VariableXpath = document.getElementById("variablexpath").value
    xVariable.Scope = top.document.getElementById("variablescope").value
    var textareaObj = document.getElementById("xslText");
    CallServerSideMethod(null, 'BuildXml',"DataTableTest",CallbackBuildXmlVariable,'table',xVariable);
}

function WindowClose()
{

window.parent.close();
}

function CallbackBuildXmlVariable(context, result, response)
{
   var error;    
   if((result!=null)&&(result!=""))
   {
        error=result;
   }
   if(error!=null)
   {
        if(error[0]=="Error")
        {
            se.ui.messageDialog.showError('<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariables")%>', error[1]);
            return false;
        }   
   }
    se.ui.messageDialog.showAlert('<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariables")%>', '<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariableSave")%>');
  top.refreshGrid(top.document.getElementById("variableName").value);
 }


function XmlVariable()
{
    this.VaraiableName = "";
    this.VaraiableDescription = "";
    this.ParentVariableName ="";
    this.ParentNodeXPath = "";
    this.VariableXpath="";
    this.Xslt = "";
    this.EditMode="";
    this.Scope="global";
}


function EncodeHtml(stringtobereplaced)
{
    var retString = "";
    if(stringtobereplaced!="")
    {
       retString = replacestring(stringtobereplaced,'<','&lt;') 
       retString = replacestring(retString,'>','&gt;') 
       retString = replacestring(retString,'>','&gt;') 
       retString = replacestring(retString,'<','&lt;')
    }
    return retString;
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
function OpenSchema()
{
    document.getElementById("HrefSchema").className = "top-links-selected";
    document.getElementById("HrefXsl").className = "top-links";
    if(divXsltObj!=null)
    {
    divXsltObj.style.display="none";
    }
    divSchObj.style.visibility="visible";
    divSchObj.style.display="block";
    divSchObj.style.position="relative";
}

function OpenXsl()
{
    document.getElementById("HrefXsl").className = "top-links-selected";
    document.getElementById("HrefSchema").className = "top-links";
    divSchObj.style.display="none";
    if(divXsltObj!=null)
    {
    divXsltObj.style.visibility="visible";
    divXsltObj.style.display="block";
    divXsltObj.style.position="relative";
    var txareaObj = document.getElementById("xslText");
    txareaObj.focus();
    }
}

    function CheckInputValue(nodetext)
    {
        if (/\s/.test(nodetext))
        {
            se.ui.messageDialog.showError('<%=Skelta.Forms.Core.Common.GetEscapedJavaScriptString(ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariables"))%>', '<%=Skelta.Forms.Core.Common.GetEscapedJavaScriptString(ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("XmlVariableVariableNamespace"))%>');
            return false;
        }

        var pattern = "^[^!=|~\\s@#$%^&*()+`\\-\\\\{}:\\\"<>?\\[\\];',./_\\d][^!=|~\\s@#$%^&*()+`\\-\\\\{}:\\\"<>?\\[\\];',./]+$";
        var validateTextRegex = new RegExp(pattern);
        if (!validateTextRegex.test(nodetext))
        {
            se.ui.messageDialog.showError('<%=Skelta.Forms.Core.Common.GetEscapedJavaScriptString(ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariables"))%>', '<%=Skelta.Forms.Core.Common.GetEscapedJavaScriptString(ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Err_XmlVariableSpecialCharacters"))%>');
            return false;
        }

        return true;
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


</script>
