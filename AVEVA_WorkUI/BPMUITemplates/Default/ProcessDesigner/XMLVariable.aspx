<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.Template.XMLVariableCodeFile" Theme="" StylesheetTheme=""%>
<%@ Register Assembly="Workflow.NET.NET2" Namespace="Workflow.NET.Ajax" TagPrefix="cc1" %>
<!DOCTYPE HTML>
<html>
<head id="Head1" runat="server">
<meta http-equiv="x-ua-compatible" content="IE=10">
<title><%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariables")%></title>
</head>
    <style>
        html, body {
            height:100%;
            overflow:hidden;
            
        }
    </style>
<script src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ProcessDesignerControl.GetCommonJScriptRelativeUrl("javascripts/SchemaDefinition.js"))%>"></script>
<body>
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(cssPath) %>CommonUXControls/StyleSheet/se.ui.min.css" />      
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

<script type="text/javascript">

function ChangeSource(srctype)
{
    
}
</script>
<form id="FrmXmlVaraiable" runat="server" method="post">
    <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ProcessDesignerControl.GetCommonRelativeUrl("/stylesheet/global.css"))%>">
    <%=System.Web.Helpers.AntiForgery.GetHtml()%>
<div><input type="hidden" id="HdnModeEdit" />
    <table cellspacing=0 cellpadding=0 width=100% border=0 >
        <tr>
		<td>
		    <table cellspacing="1" cellpadding="1" border="0" width="100%" class="ListHeaderCss">
			    <tr>
				    <td style="padding-left:16px"> 
				    <span class="fontheading"><%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariables")%></span></td>
				    <td valign="top" width="25" ><a href="#">
                        <img src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ProcessDesignerControl.GetCommonRelativeUrl("Images/main-help.gif"))%>"  alt="<%=ProcessDesignerControl.GlobalResourceSet.GetString("HelpIconToolTip")%>" onclick="javascript:window.open('<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(ProcessDesignerControl.GetHelpPageUrl(), false)%>AboutTheXMLVariableUserInterface.html','test','width=600,height=500,scrollbars=yes,resizable=yes')"  border="0" /></a></td>
			    </tr>
		    </table>
		</td>
	    </tr>
	    <tr>
            <td align="center" width="100%" height="100%">
               <table border=0 width="95%" height="100%" align=center ID="Table2" cellpadding="1" cellspacing="0" class="tablebg">
                    <tr>
                         <td class="lefttdbg">
                             <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="100%"id="Td1" align="Left">
                                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="headerpropertypage">
                                             <tr>
                                            <td width="10" height="22"  >&nbsp;</td>
                                            <td width="120" class="fontheading"  ><a onClick="AddNewVariable();" class="subtitle" style="text-decoration:none;" href="#"><img src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ProcessDesignerControl.GetCommonRelativeUrl("images/new-row.gif"))%>" align="absmiddle" border="0" > <%=ProcessDesignerControl.GlobalResourceSet.GetString("NewXmlVariable")%> </a></td>
                                            <td width="50"  align="center" ><img src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ProcessDesignerControl.GetCommonRelativeUrl("images/divider-for-icons.gif"))%>" width="2"  align="absmiddle" ></td>
                                            <td class="fontheading"><a onClick="removeselected();" class="subtitle" href="#" style="text-decoration:none;"><img src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ProcessDesignerControl.GetCommonRelativeUrl("images/remove-selected-icon.gif"))%>"  border="0" align="absmiddle">  <%=ProcessDesignerControl.GlobalResourceSet.GetString("RemoveXmlvariable")%></a></td>
                                            </tr>                                      
                                         </table>
                                    </td>
                               </tr>
                            </table>        
                        </td>
                    </tr>
                    <tr>
                        <td>
                             <table width="100%" cellspacing=0 cellpadding=0 border=0 class="lefttdbg"  >
                                    <tr>
                                        <td width="100%" align="center" >
                                           <div id="divVariables" style="HEIGHT: 160px; width:100%;" class="tablebg">							                                            
                                           <table width="100%" border="0" cellpadding="0" cellspacing="0" >
                                              <tr>
                                                <td width="30%" class=GridHeaderStyle><%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariableName")%> </td>
                                                <td width="30%"  class=GridHeaderStyle>&nbsp;<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariableType")%> </td>
                                                <td width="40%" class=GridHeaderStyle><%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariableDescription")%></td>
                                              </tr>
                                            </table> 
                                             <div id="variablesList" style="HEIGHT: 118px; width:100%;overflow:auto" class="GridFrameStyle">
                                              <%=VariableList%>
                                            </div>
                                          </div>
                                        </td>
                                    </tr> 
                              </table>
                           </td>
                      </tr>
                     <tr>
                        <td class="lefttdbg">
                           <table width=100% cellspacing=1 cellpadding=2 border=0 align="center" class="tablebg">
                                <tr>
                                     <td class="lefttdbg" align="Left" width="20%" valign=middle>
                                             <span class="description"> <%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariableName")%> </span>
                                     </td>
                                     <td class="righttdbg">
                                             <input type="text" id="variableName"  class="inputtext" value="<%=VariableName%>" maxlength="30" />      
                                     </td>
                                      <td class="lefttdbg" width="20%" align=left valign=middle style="padding-left:2%;">
                                             <span class="description"><%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariableType")%> </span>
                                      </td>
                                     <td class="righttdbg" >
                                             <asp:DropDownList ID=cboProvider runat="server" CssClass="inputselect" >
                                             </asp:DropDownList>
                                     </td>
                                  </tr>
                                  <tr>
                                     <td class="lefttdbg" width="20%" valign=middle align="left">
                                        <span class="description"><%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariableDescription")%></span>
                                     </td>
                                     <td class="righttdbg" width="25%"><textarea id="VarDescription"  rows=2 class="inputtextarea" cols=25 ><%=VariableDescription%></textarea></td>
                                      
                                     <td class="lefttdbg"  width="20%" align=left valign=middle style="padding-left:2%;">
                                             <span class="description"><%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariableScope")%> </span>
                                     </td>
                                     <td class="righttdbg">
                                             <select id="variablescope" name="variablescope" class="inputselect">
                                                    <option value="global" selected><%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariableGlobal")%></option>
                                                    <option value="local"><%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariableLocal")%></option>                                               
                                             </select>
                                     </td>
                                    
                                </tr>
                               <tr>
                                <td colspan="4" style="height:3px;width:98%">
                                    <div class="lineCss"></div>
                                </td>
                                </tr>

                                 <tr>
                                    <td valign=middle class="lefttdbg" colspan="4" >
                                            <div id="xmlDoc" style="width:100%;height:398px;" >
                                                <iframe id="Xml_frame" style="WIDTH:100%; HEIGHT: 355px;"  scrolling="no" marginheight="0" marginwidth="0"  frameborder="no"></iframe>
                                            </div>          
                                    </td>
                               </tr>
                                
                     </table>
                        </td>
                    </tr>                       
          
        </table>
        </td>
      </tr>
    </table>         
              
   <cc1:AjaxPageControl ID="AjaxPageControl1" runat="server" />	                        
</div>
</form>
</body>
</html>
<script>

InitializeElements();
Iframesrc= "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(IframeURl, false)%>";

SelectRow(1,'<%=SelectedVariableName%>','<%=SelectedVariableType%>','<%=SelectedVariableDesc%>',true,'<%=SelectedVariableScope%>');

function refreshGrid(variableName)
{
    CallServerSideMethod(null, 'RefreshXmlList',"DataTableTest",CallbackRefreshGrid,'table',variableName);
}

function CallbackRefreshGrid(context, result, response)
{
   var res = result;
   document.getElementById("variablesList").innerHTML = result[2];
   SelectRow(result[0],result[1],result[3],document.getElementById("VarDescription").value,false,result[4]);
}

function removeselected()
{
  if(trim(selectedvaraiable)!="")  
        CallServerSideMethod(null, 'RemoveVariable',"DataTableTest",CallbackRemoveVariable,'table',selectedvaraiable);
}

function CallbackRemoveVariable(context, result, response)
{
    if(result!=null)
    {
        if(result[0]!="")
        {
            if(result[0]=="Exception")
            {
                se.ui.messageDialog.showError("<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariables") %>", result[1]);
            }
            else
            {
                document.getElementById("variablesList").innerHTML = result[0];
                SelectRow(1,result[1],result[3],result[2],true,result[4]);
            }
        }
        else
        {
            document.getElementById("variablesList").innerHTML ="";
            FillDefinition("","");
            document.getElementById("variableName").value= "";
            document.getElementById("VarDescription").value= ""; 
        }
    }   
}

function ChangeStorageSrc(cmb)
{


  var iframeSrc = Iframesrc; //document.getElementById("Xml_frame").src;
  var selectedtext="";
  
  if(cmb.options.length>0)
  {
   // var splitArr = cmb.options[cmb.selectedIndex].value.split('$');
    selectedtext =  cmb.options[cmb.selectedIndex].value;//splitArr[1];//cmb.options[cmb.selectedIndex].text;
  }  
  var nnerHTMl="";
  DividerIcon = '<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(ProcessDesignerControl.GetCommonRelativeUrl("images/divider-for-icons.gif"), false)%>';
  if(selectedtext!="")
  {
      LoadXmlDocument(selectedtext,iframeSrc,nnerHTMl);
  }
}
function GetBrowserversion()
{
	var app=navigator.userAgent;
	if(app.indexOf("MSIE")>-1)
	{
		return 1;	
	}
	else if(app.indexOf("Firefox/")>-1)
	{
		return 2;	
	}
	else
	{
	    return 3;
	}
}

var browser = GetBrowserversion();

if(browser==2)
{
 document.getElementById("xmlDoc").style.height="410px";
 document.getElementById("Xml_frame").scrolling="yes";
 }
</script>