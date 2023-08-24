<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.SharePoint.CodeBehind.XmlListCodeFile"  Theme="" StylesheetTheme="" %>
<%@ Register Assembly="Workflow.NET.Web.Designer.NET2" Namespace="Workflow.NET.Web.Designer" TagPrefix="cc1" %>
<%@ Register TagPrefix="cc2" Namespace="Workflow.NET.Ajax" Assembly="Workflow.NET.NET2" %>
<link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ProcessDesignerControl.GetCommonRelativeUrl("stylesheet/global.css"))%>">
<script src="<%=ProcessDesignerControl.GetJscriptUrl("../Common/javascripts/XmlTreeview.js")%>"></script>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head id="Head1" runat="server">
    <title>SharePoint Xml</title>
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
    <form id="form1" runat="server">
    <%=System.Web.Helpers.AntiForgery.GetHtml()%>
           <table width=100% cellpadding=0 cellspacing=0  border="0" height="100%" class="tablebg" >
            <tr>
                <td valign="top" align="center">
                    
                    <table width=100% height=100% cellspacing=1 cellpadding=2 border=0>                             
                         <tr>
                            <td class="lefttdbg" align="left" width="136px" >
                                <span class="description"><%=ProcessDesignerControl.GlobalResourceSet.GetString("XMLSiteURLWithStar") %></span>
                            </td>
                            <td class="righttdbg" width="185px" align="left">
                                 <asp:TextBox ID="SiteUrl" runat="server" ReadOnly=true Width="135px" CssClass="inputtext" ></asp:TextBox>
                                         <asp:HiddenField ID="ListName" runat="server" /><asp:HiddenField ID="ListId" runat="server" />
                                        <asp:Image ID="imgButton" runat="server" border="0" align="absmiddle"/>
										 <asp:HiddenField ID="Repositories" runat="server" />                                   
                            </td>
                            <td class="lefttdbg" align="left" width="20%" >
                                <span class="description"><%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlSPListName")%></span>
                            </td>
                            <td class="righttdbg"  >
                                <asp:TextBox ID="FormLibrary" runat="server" ReadOnly=true CssClass="inputtext" ></asp:TextBox>
                            </td>
                        </tr>
                       
                        <tr>
                            <td class="lefttdbg" colspan="4" >
                                <table cellpadding=0 cellspacing=0 width=98%  border="0">
                                       <tr>
                                        <td class="lefttdbg" width=50%>
                                             <span class="subtitle"><%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariableSchema")%></span>
                                        </td>
                                        <td class="lefttdbg" width=50% align="Right">
                                             <input type="button" id="SchemaButton" value="<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVarRefreshSchema")%>" class="inputbutton" onclick="javascrpt:RefreshSchema();" /> &nbsp;&nbsp;
                                        </td>
                                     </tr>
                                     <tr>
                                        <td width=100% class="lefttdbg" colspan="2" valign="top" >
                                            <cc1:XmlSchemaDesigner ID="XmlSchemaDesigner1" Width="681px" Height="190px" IsSchemaEditable=false runat="server" />              
                                        </td>  
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        
                        <tr>
                            <td class="lefttdbg" colspan="4">
                                <table width="98%" cellspacing=0  cellpadding=1 border=0 align="center" >
                                      <tr>
                                         <td  class="lefttdbg"  >
                                             <span class="subtitle"><%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVarWorkChooseListItemScope") %></span>
                                         </td> 
                                      </tr>
                                      <tr>
                                            <td>
                                               <table width=100% cellspacing=1 cellpadding=2 border=0 class="tablebg"  align="center" >
                                                    <tr >
                                                        
                                                         <td  class="righttdbg" width="20%" >
                                                             <asp:RadioButton ID="RadioButton1" class="inputradio" GroupName="ChooseItem" runat="server" onclick="EnableDisableRunTimeCheck();"/><span class="description">&nbsp;<%=ProcessDesignerControl.GlobalResourceSet.GetString("XMLCurrent")%> </span>
                                                          </td>
                                                          <td  class="righttdbg" valign="top">
                                                             <table>
                                                                <tr>
                                                                    <td><img src="<%=ProcessDesignerControl.GetThemeRelativeUrl("images/icon-tips.png")%>" height="16" border="0">
                                                                    </td>
                                                                    <td>
                                                                    <span class="help"><%=ProcessDesignerControl.GlobalResourceSet.GetString("SPXmlVarRunTimeCurrentContextText") %></span>
                                                                    </td>
                                                                </tr>
                                                              </table>
                                                          </td>
                                                     </tr>
                                                     <tr>
                                                          <td class="righttdbg" valign=top>
                                                            <asp:RadioButton ID="RadioButton2" class="inputradio" GroupName="ChooseItem" runat="server" onclick="EnableDisableRunTimeCheck();"/><span class="description">&nbsp;<%=ProcessDesignerControl.GlobalResourceSet.GetString("XMLVarNew")%> </span>
                                                           </td>
                                                           <td class="righttdbg" >
                                                            <table>
                                                                <tr>
                                                                    <td valign="top" ><asp:CheckBox ID="ChkRunTimeContext" runat="server" class="inputcheckbox" />
                                                                    </td>
                                                                    <td>
                                                                    <span class="description"><%=ProcessDesignerControl.GlobalResourceSet.GetString("SPXmlVarRunTimeContextText") %></span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td><img src="<%=ProcessDesignerControl.GetCommonRelativeUrl("images/icon-note.png")%>" height="16" border="0">
                                                                    </td>
                                                                    <td><asp:HiddenField ID="SiteId" runat="server" />
               
                                                                    <span class="note"><%=ProcessDesignerControl.GlobalResourceSet.GetString("SPXmlVarRunTimeContextTextNote") %></span>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                           
                                                          </td>
                                                    </tr>                                             
                                            </table>
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
                    <table cellpadding=0 cellspacing=0 class="lefttdbg">
                        <tr>
                            <td align="right">
                            <input type="button" id="btnCancel" value="<%=ProcessDesignerControl.GlobalResourceSet.GetString("ExpCancel")%>" class="inputsecondarybutton"  onclick="javascript: WindowClose()" />    
                            &nbsp;&nbsp;&nbsp;     
                                <input type="button" id="btnSave" value="<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlSaveVariable")%>" class="inputbutton" onclick="    javascript: CallServer()" />&nbsp;&nbsp;&nbsp;
                          </td>
                       </tr>
                    </table>

                </td>
            </tr>
               
        </table>
    
        <cc2:AjaxPageControl id="AjaxPageControl1" runat="server" style="Z-INDEX: 104; LEFT: 440px; POSITION: absolute; TOP: 88px"></cc2:AjaxPageControl> 
    </form>
</body>
</html>

<script>
EnableDisableRunTimeCheck();
function EnableDisableRunTimeCheck()
{
if(document.getElementById('RadioButton1').checked)
{
    document.getElementById('ChkRunTimeContext').checked= false;
    document.getElementById('ChkRunTimeContext').disabled=true;
    }
else    
    document.getElementById('ChkRunTimeContext').disabled=false;
}
    
function GetPlugInContent(plugInContent)
{
   
   plugInContent = plugInContent.replace("|$|","'");
   var content = plugInContent.split("#");
   
   if(content.length>1)
            {
            
              var parentContent = content[0].split('~');
              
              document.getElementById("Repositories").value  = parentContent[0];
              
              if(parentContent.length>3)
              {
                  if(parentContent[1].indexOf("}")>-1)
                  { 
                    document.getElementById("SiteUrl").value = parentContent[1].substring(parseInt(parentContent[1].indexOf("}")) + 1);  
                    document.getElementById("SiteId").value = parentContent[1].substring(1,parseInt(parentContent[1].indexOf("}")));  
                  }
                  else
                  {
                    document.getElementById("SiteUrl").value = parentContent[1];  
                  }
                 
                  if(content[1].indexOf("}")>-1)
                  { 
                    document.getElementById("ListName").value = content[1].substring(parseInt(content[1].indexOf("}")) + 1);  
                    document.getElementById("ListId").value =content[1].substring(1,parseInt(content[1].indexOf("}")));  
                  }
                  else
                  {
                    document.getElementById("ListName").value=content[1];
                  }
                  
                  document.getElementById("FormLibrary").value = document.getElementById("ListName").value
                  
                  var parameterValue =  document.getElementById("SiteId").value +"$"+ document.getElementById("SiteUrl").value +"$"+document.getElementById("ListId").value +"$"+document.getElementById("ListName").value+"$"+document.getElementById("Repositories").value ;
                  
                  CallServerSideMethod(null, 'LoadTreeForList',"DataTableTest",CallbackLoadTreeForList,'table',parameterValue);
                
              }
            }
   
   
}

var ListsComboInstance = "";//

function RefreshSchema()
{
    if(trim(document.getElementById("Repositories").value)!="")
      {
         var parameterValue =  document.getElementById("SiteId").value +"$"+ document.getElementById("SiteUrl").value +"$"+document.getElementById("ListId").value +"$"+document.getElementById("ListName").value+"$"+document.getElementById("Repositories").value ;
                  
        CallServerSideMethod(null, 'LoadTreeForList',"DataTableTest",CallbackLoadTreeForList,'table',parameterValue);
     }
}


function CallServer()
{
//debugger;
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
       
    
    var xVariable =new XmlVariable();
    xVariable.VaraiableName = top.document.getElementById("variableName").value;
    xVariable.VaraiableDescription = top.document.getElementById("VarDescription").value;
    xVariable.EditMode = top.document.getElementById("HdnModeEdit").value;
    xVariable.Scope = top.document.getElementById("variablescope").value;
    xVariable.ListName=document.getElementById("ListName").value;  
    xVariable.SiteUrl=document.getElementById("SiteUrl").value;
    xVariable.ListId=document.getElementById("ListId").value;  
    xVariable.SiteId=document.getElementById("SiteId").value;
    xVariable.WebApplicationId=document.getElementById("Repositories").value;
    xVariable.XmlSchema =objTree.root;
    
    if(document.getElementById("RadioButton1").checked==true)
    {
         xVariable.ListItemType ="Current";
    }
    else if(document.getElementById("RadioButton2").checked==true)
    {
        xVariable.ListItemType ="New";
    }
    
    if(xVariable.ListItemType !="Current")
    {
        
       if(document.getElementById("ChkRunTimeContext").checked==true)
           xVariable.NewScopeListFromRunTimeSiteContext = "false";
        else
            xVariable.NewScopeListFromRunTimeSiteContext = "true";
            
    }
    
    CallServerSideMethod(null, 'SaveVariable',"DataTableTest",CallbackSaveVariable,'table',xVariable);
}

function WindowClose()
{

window.parent.close();
}

function XmlVariable()
{
    this.VaraiableName = "";
    this.VaraiableDescription = "";
    this.SiteUrl = "";
    this.ListName="";
    this.SiteId = "";
    this.ListId="";
    this.ListItemType="Current"; 
    this.WebApplicationId="";   
    this.Scope = "global";
    this.NewScopeListFromRunTimeSiteContext="false";
}

function CallbackSaveVariable(context, result, response)
{
   var error;
    
   if((result!=null)&&(result!=""))
   {
        error=result;
   }
   if(error!=null)
   {
        if(error[0]=="errReturned")
        {
            se.ui.messageDialog.showError('<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariables")%>', error[1]);
            return false;
        }   
   }
    se.ui.messageDialog.showAlert('<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariables")%>', '<%=ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("XmlVariableSave")%>');
  
  top.refreshGrid(top.document.getElementById("variableName").value);
  
  /*if(document.getElementById('hidcheck').value!='1')
  {
        var browserCode=GetBrowserversion();
        
        if(browserCode=="1")
	    { 
            top.frames[0].location.reload(false);
        } 
     
  }*/
   //top.frames[0].history.go();*/
}

function LoadTreeForList()
{  

    var UrlValue = document.getElementById("URLText").value;
     
    if(UrlValue =="")
    {
        alert("Enter URL");
    }
    else
    {
        ListsComboInstance.RequestItems(UrlValue, false);
    }
    
   
}

function HandleChangeLists(item)
{
    
    var parameterValue = document.getElementById("URLText").value +","+ item.Text ;

    CallServerSideMethod(null, 'LoadTreeForList',"DataTableTest",CallbackLoadTreeForList,'table',parameterValue);
    
}


function CallbackLoadTreeForList(context, result, response)
{
    
   if(result!=null)
   {
       if(result[0]!=null && result[0]!='o')
       {
           se.ui.messageDialog.showError('<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariables")%>', result[1]);
       }
       else
       { 
           var objTree = new jsTree;
           eval(result);
           document.getElementById("xmlTreeDiv").innerHTML = "";
           objTree.buildDOM();   
           var strInnerHTML = document.getElementById("xmlTreeDiv").innerHTML;
           document.getElementById("xmlTreeDiv").innerHTML = strInnerHTML.replace("<DIV><DIV>",""); 
       }
   }
 }


function CheckInputValue(nodetext)
{
      var retValue= true;  
      
      var l = nodetext.length;   
      
      for (var i=0; i<l; i++) 
      { 
        var ch = nodetext.charAt(i); 

            var errFlag=0;  
            switch(trim(ch))
            {
                case "":
                    se.ui.messageDialog.showError('<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariables")%>', '<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariableVariableNamespace")%>');
                    errFlag=2;
                    retValue=false;
                    break;

                case"$":
                    errFlag=1;
                    break;

               case"\"":
                    errFlag=1;
                    break;
                    
                case"\\":
                    errFlag=1;
                    break;
                    
                case"[":
                    errFlag=1;
                    break;
                    
                case",":
                    errFlag=1;
                    break;
                    
                case"]":
                    errFlag=1;
                    break;
                    
                case"%":
                    errFlag=1;
                    break;    
                
                case"&":
                    errFlag=1;
                    break;        
                 
                 case"+":
                    errFlag=1;
                    break;           
                
                case";":
                    errFlag=1;
                    break;           
                 
                case":":
                    errFlag=1;
                    break;               
                
                case"?":
                    errFlag=1;
                    break; 
                                      
                 case"'":
                    errFlag=1;
                    break; 
                
                case"<":
                    errFlag=1;
                    break;               
                    
                case">":
                    errFlag=1;
                    break;   
                 
                 case"/":
                    errFlag=1;
                    break;                      
                 case"\\":
                    errFlag=1;
                    break; 
                 case "@":
                    errFlag=1;
                    break;
            
                case "#":
                    errFlag=1;
                    break;
               break;     
                                
                case "-":
                    errFlag=1;
                    break;  
               case "^":
                    errFlag=1;
                    break;
              
              case "*":
                    errFlag=1;
                    break;   
              
              case "(":
                    errFlag=1;
                    break;
              
              case ")":
                    errFlag=1;
                    break;      
                    
               case "}":
                    errFlag=1;
                    break;
              
              case "{":
                    errFlag=1;
                    break;  
                    
              case ".":
                    errFlag=1;
                    break;                
                    
            }   
            
            if(errFlag==1)
            {
                se.ui.messageDialog.showError('<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariables")%>', '<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariableVariableNamespecialchar")%>');
                retValue=false;
                break;
            }
            else  if(errFlag==2)
            {
                retValue=false;
                break;
            }
      
   }
  return retValue;
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

<%=spScripts%>