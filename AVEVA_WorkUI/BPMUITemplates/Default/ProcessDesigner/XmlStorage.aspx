<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.Template.XmlStorageCodeFile"  Theme="" StylesheetTheme="" %>
<%@ Register Assembly="Workflow.NET.Web.Designer.NET2" Namespace="Workflow.NET.Web.Designer" TagPrefix="cc1" %>
<%@ Register TagPrefix="cc2" Namespace="Workflow.NET.Ajax" Assembly="Workflow.NET.NET2" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<link rel="stylesheet" type="text/css" href="<%:ProcessDesignerControl.GetCommonRelativeUrl("/stylesheet/global.css")%>">
<!DOCTYPE HTML>
<html>
<head id="Head1" runat="server">
    
    <title>XML Storage</title>
</head>
     <style>
        html, body {
            height:100%;
            overflow:auto;
            overflow-x:hidden !important;
        }
    </style>
<body>
    <script src="<%:bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%:bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%:bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%:cssPath %>CommonUXControls/StyleSheet/se.ui.min.css" />
    <link rel="stylesheet" type="text/css" href="<%=cssPath%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
    <link rel="stylesheet" type="text/css" href="<%=cssPath%>TelerikAjax/StyleSheet/AWTWindow/Window.css">
    <script>
        se.ui.messageDialog.setGlobalOptions({
            localization: {
                closeButtonCaption: "<%:ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                okButtonCaption: "<%:ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
                cancelButtonCaption: "<%:ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                showDetailsCaption: "<%:ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                hideDetailsCaption: "<%:ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
            }
        });
    </script>
    <form id="form1" runat="server" method="post">
     <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server" />
        <table width=100% cellpadding=0 cellspacing=0 height="100%">
            <tr>
                <td valign=top align="center">
                    <table width=100% cellspacing=1 cellpadding=2 border=0  height="100%" class="tablebg">
                         <tr>
                            <td colspan=2 class="lefttdbg">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" >
                                    <tr>
                                        <td width="100%"id="Td1" align="Left">
                                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="headerpropertypage">
                                             <tr>
                                            <td width="1%" height="22" class="fontheading" >&nbsp;</td>
                                            <td width="10%" class= "fontheading" id="SchemaTD"><a onClick="OpenSchema();" class="textlinkblue" href="#" id="HrefSchema"><img src="<%:ProcessDesignerControl.GetCommonRelativeUrl("images/icon-schema.gif")%>" align="absmiddle" border="0" >&nbsp;<%:ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariableSchema")%> </a></td>
                                            <td width="10%"  class="fontheading" align="center" id="tdSeparator" runat="server"><img src="<%:ProcessDesignerControl.GetCommonRelativeUrl("images/divider-for-icons.gif")%>" width="2"  align="absmiddle" ></td>
                                            <td class="fontheading" id="tdXsl" runat="server"><a onClick="OpenXsl();" class="textlinkblue" id="HrefXsl" href="#"><img src="<%:ProcessDesignerControl.GetCommonRelativeUrl("images/icon-xsl.gif")%>" align="absmiddle" border="0">&nbsp;<%:ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariableXsl")%></a></td>
                                            </tr>                                      
                                             </table>
                                        </td>
                                   </tr>
                                </table>  
                            </td> 
                        </tr>
                        <tr>
                            <td class="lefttdbg">
                               <table width="100%" height="100%" cellpadding=0 cellspacing=0>
                                    <tr>
                                        <td class="lefttdbg" align="left" width="92%">
                                            &nbsp;
                                            <span class="subtitle"><%:ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariableUse")%>
                                            &nbsp;
                                            <select class="inputselect" id="CmbInternalStorage" name="CmbInternalStorage">
                                                <option value="contents">
                                                    <%:ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Content")%>
                                                </option>
                                                <option value="variables" >
                                                    <%:ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Variable")%>
                                                </option>
                                            </select>
                                            <%:ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariableForInternalStorage")%>
                                            </span> 
                                        </td>
                                        <td align="left" width="6%" class="lefttdbg">
                                            <img style="height:28px;width:30px;"  src="<%:ProcessDesignerControl.GetCommonRelativeUrl("Images/icon-forms-explorer.png")%>" id="refreshFormSchema" title="<%:ProcessDesignerControl.GlobalResourceSet.GetString("Get_schema_from_FORM")%>"
                                                onclick="javascript:OpenXmlFormListExplorer()" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                         <tr>
                            <td  class="lefttdbg">
                                <div id="divXslt" style="display:none" class="lefttdbg">
                                        <br />
                                         &nbsp;<textarea id="xslText" rows=24 cols=115 class="inputtextarea">
                                         </textarea> 
                                         <br />
                                </div>         
                                
                                <div id="divSchema" class="lefttdbg" style="height:100%">
                                       <cc1:XmlSchemaDesigner ID="XmlSchemaDesigner1" Width="680px" Height="245px" runat="server" />              
                                </div>
                            </td>    
                        </tr>
                   </table>
                 </td>
              </tr>           
            <tr >
                <td align="right" colspan=2 >
                    <table>
                        <tr>
                            <td>
                    <input type="button" id="btnCancel" value="<%:ProcessDesignerControl.GlobalResourceSet.GetString("ExpCancel")%>" class="inputsecondarybutton"  onclick="javascript: WindowClose()" />
                    &nbsp;&nbsp;                 <input type="button" id="btnSave" value="<%:ProcessDesignerControl.GlobalResourceSet.GetString("XmlSaveVariable")%>" class="inputbutton" onclick="javascript: CallServer()" />    
                            </td>
                        </tr>
                    </table>
                    

                </td>
            </tr>
            
        </table>
    
    <input type="hidden" id="variablename" name="variablename"/> 
    <input type="hidden" id="variabledesc" name="variabledesc"/> 
    <cc2:AjaxPageControl id="AjaxPageControl1" runat="server" style="Z-INDEX: 104; LEFT: 440px; POSITION: absolute; TOP: 88px"></cc2:AjaxPageControl>  
            <telerik:RadWindowManager ID="rwm" Skin="AWTWindow" EnableEmbeddedSkins="false" runat="server" Behaviors="Close" RenderMode="Classic" Modal="false" DestroyOnClose="true" VisibleStatusbar="false" ReloadOnShow="true" Height="200" Width="300">
            </telerik:RadWindowManager> 
        </form>
</body>
</html>

<script>
document.getElementById("HrefSchema").className = "textlinkblue";
document.getElementById("HrefXsl").className = "textlinkblue";

var divSchObj =document.getElementById("divSchema");
var divXsltObj =document.getElementById("divXslt");
var browsercode=GetBrowserversion();

var txareaObj = document.getElementById("xslText");

if(browsercode!=1)
{
txareaObj.rows=23;
txareaObj.cols=113;
}

function SelectInternalStorage()
{
    var oOption = document.getElementById("CmbInternalStorage");
    var selectIndex=1;
    for(var i=0;i<oOption.options.length;i++)
    {
        if(oOption.options[i].value==selectInternalStorage)
        {
            selectIndex = i;    
        }
    }
    
    document.getElementById("CmbInternalStorage").selectedIndex=selectIndex;
}

var selectInternalStorage ='<%:InternalStorage%>';

SelectInternalStorage();
/*
objTree.buildDOM();

var strInnerHTML = document.getElementById("xmlTreeDiv").innerHTML;
document.getElementById("xmlTreeDiv").innerHTML = strInnerHTML.replace("<DIV><DIV>",""); 
*/

function CallServer()
{
    if(top.document.getElementById("variableName").value=="")
    {
        top.document.getElementById("variableName").focus();
        se.ui.messageDialog.showError('<%:ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariables")%>', '<%:ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariableEnterVariableName")%>');
        return false;
    }
    else
    {
        if (!CheckInputValue(top.document.getElementById("variableName").value))
        {
            top.document.getElementById("variableName").focus();
            return false;
        }
        else
        {
            if(top.document.getElementById("variablescope").value=="local" &&
            document.getElementById("CmbInternalStorage").value == "contents")
            {
            se.ui.messageDialog.showError('<%:ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariables")%>', '<%:ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariableLocalScopeForContent")%>');
            return false;
            }
        }
    }   
    var xVariable =new XmlVariable();
    xVariable.VaraiableName = top.document.getElementById("variableName").value;
    xVariable.VaraiableDescription = top.document.getElementById("VarDescription").value;
    xVariable.XmlSchema =objTree.root;
    xVariable.EditMode = top.document.getElementById("HdnModeEdit").value;
    xVariable.InternalStorage = document.getElementById("CmbInternalStorage").value;
    xVariable.Scope = top.document.getElementById("variablescope").value
    var textareaObj = document.getElementById("xslText");
    var encodedHtml ="";
    encodedHtml = EncodeHtml(textareaObj.value);
    xVariable.Xslt = encodedHtml;
    CallServerSideMethod(null, 'BuildXml',"DataTableTest",CallbackBuildXml,'table',xVariable);
}

function WindowClose()
{

window.parent.close();
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

function CallbackBuildXml(context, result, response)
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
            se.ui.messageDialog.showError('<%:ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariables")%>', error[1]);
            return false;
        }   
   }
    se.ui.messageDialog.showAlert('<%:ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariables")%>', '<%:ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("XmlVariableSave")%>');
  
  top.refreshGrid(top.document.getElementById("variableName").value);
  
  if(document.getElementById('hidcheck').value!='1')
  {
        var browserCode=GetBrowserversion();
        
        if(browserCode=="1")
	    { 
            top.frames[0].location.reload(false);
        } 
     
  }
   //top.frames[0].history.go();
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
function XmlVariable()
{
    this.VaraiableName = "";
    this.VaraiableDescription = "";
    this.XmlSchema;
    this.Xslt = "";
    this.EditMode="";
    this.InternalStorage ="";
    this.Scope = "global";
}

function OpenSchema()
{
    document.getElementById("HrefSchema").className = "textlinkred";
    document.getElementById("HrefXsl").className = "textlinkblue";
    divXsltObj.style.display="none";
    divSchObj.style.visibility="visible";
    divSchObj.style.display="block";
    divSchObj.style.position="relative";
}

function OpenXsl()
{
    document.getElementById("HrefXsl").className = "textlinkred";
    document.getElementById("HrefSchema").className = "textlinkblue";
    divSchObj.style.display="none";
    divXsltObj.style.visibility="visible";
    divXsltObj.style.display="block";
    divXsltObj.style.position="relative";
    txareaObj = document.getElementById("xslText");
    txareaObj.focus();
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


function CheckInputValue(nodetext)
{
    if (/\s/.test(nodetext))
    {
        se.ui.messageDialog.showError('<%:Skelta.Forms.Core.Common.GetEscapedJavaScriptString(ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariables"))%>', '<%:Skelta.Forms.Core.Common.GetEscapedJavaScriptString(ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("XmlVariableVariableNamespace"))%>');
        return false;
    }

    var pattern = "^[^!=|~\\s@#$%^&*()+`\\-\\\\{}:\\\"<>?\\[\\];',./_\\d][^!=|~\\s@#$%^&*()+`\\-\\\\{}:\\\"<>?\\[\\];',./]+$";
    var validateTextRegex = new RegExp(pattern);
    if (!validateTextRegex.test(nodetext))
    {
        se.ui.messageDialog.showError('<%:Skelta.Forms.Core.Common.GetEscapedJavaScriptString(ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariables"))%>', '<%:Skelta.Forms.Core.Common.GetEscapedJavaScriptString(ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Err_XmlVariableSpecialCharacters"))%>');
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
function OpenXmlFormListExplorer()
{
    var oWindow =  radopen("FormExplorer.aspx"+window.location.search+"&ListName=Forms List",null);
	oWindow.setSize(400, 200);

}

function CallServerFormRefresh(formId,formVersion)
{
    CallServerSideMethod(null, 'RefreshFormXml',"DataTableTest",CallbackRefreshXml,'table',formId+"$"+formVersion);
}

function CallbackRefreshXml(context,result,response)
{
 eval(result);
}
</script>
