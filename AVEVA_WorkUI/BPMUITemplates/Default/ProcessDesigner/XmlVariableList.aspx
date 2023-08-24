<%@ Page Language="C#" AutoEventWireup="true" CodeFile="XmlVariableList.aspx.cs" Inherits="XmlVariableList" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ Register Assembly="Skelta.Repository.Web" Namespace="Skelta.Repository.Web.Lookup"  TagPrefix="cc1" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
	<title><%=WorkflowName%>-<%=_actionname%>-<%=PropertyDisplayName%></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
     
</head>
    <style>        
        html, body {
            height:100%;
            overflow:hidden;
        }
    </style>	
    <link href="<%=ProcessDesignerControl.GetCommonRelativeUrl("/stylesheet/global.css")%>" rel="stylesheet" type="text/css" />
    <script type='text/javascript' src='<%=_JScriptPath%>'></script>
    <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
<body leftmargin="0px" topmargin="0px" rightmargin="0px" bottommargin="0px" scroll="yes" > 
    
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

         function DisplayMessage() {
             var strHdrMsg = '<%=_actionname%>' + '-' + '<%=PropertyDisplayName%>';
             var strMessage = '<%=ErrMsg%>';
             se.ui.messageDialog.showError(strHdrMsg, strMessage);
         }


</script>
   
    <form id="form1" runat="server"  > 
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
         <link href="<%=cssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css" rel="stylesheet" type="text/css" />
         <link href="<%=cssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css" rel="stylesheet" type="text/css" />
         <link href="<%=ProcessDesignerControl.GetThemeRelativeUrl("CommonUXControls/StyleSheet/se.ui.min.css")%>" rel="stylesheet" type="text/css" />   
    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="ListHeaderCss">
    <tr valign="top">                  
          <td valign="middle" style="padding-left:15px;">
          <span class="fontheading"> <%=_actionname%>-<%=PropertyDisplayName%></span></td>
          <td valign="middle"><span title="Help" ><img src="<%=ProcessDesignerControl.GetCommonRelativeUrl("Images/main-help.gif")%>" align="right" <%=_Helpimagetags%> style="cursor:pointer" alt="Help"/></span></td>
        </tr>
      <tr >
        <td style="width: 99%" valign="top" colspan="2" > 
		    <table width="100%" border="0" cellspacing="0" cellpadding="0" >
                                  
                        <%if (ErrMsg =="")
                           { %>
                       <tr>
                        <td height="14px"></td>
                       </tr>    
                       <%} %>  
                       <%else {%>
	                        <tr>
	                            <td  valign="middle" colspan=2 align=center class="lefttdbg"  nowrap>
	                      <!--    <span class="errormsg"> <%=ErrMsg%></span> -->
			                    </td>				                
	                        </tr>
	                        <%} %>        
                    <tr>
	                     <td colspan="2"  class="lefttdbg" align="center" valign=top>
	                    
	                    <table width="95%" height="100" cellspacing="1" cellpadding="3" border="0" class="tablebg">
	                    
	                        <tr>
	                            <td  valign="middle" class="lefttdbg " nowrap>
	                            <span class="subtitle"> <%=strListMsg%></span>
			                    </td>
				                <td class="righttdbg" valign="middle">
				                    <asp:RadioButtonList CssClass="inputradio" runat=Server ID="radList" RepeatDirection=Horizontal AutoPostBack="true" OnSelectedIndexChanged="radList_OnSelectedIndexChanged">
				                       
				                    </asp:RadioButtonList>
                                 </td> 
	                        </tr>
	                        
	                        <%if(IsListXml){ %>
	                        <tr>
	                            <td valign="middle" class="lefttdbg">
	                            <span class="subtitle"><%=strListName%></span>
			                    </td>
	                            <td class="righttdbg" valign="middle">
                                    <cc1:ListExplorer ID="listExplorer1" runat="server" />
                                </td>
	                        </tr>
	                        <%}else{ %>
			                <tr>
			                    <td  valign="middle" class="lefttdbg">
			                    <span class="subtitle"><%=strFormName%></span>
			                    </td>
			                   
				                <td class="righttdbg" valign="middle">
				                    <asp:Panel ID ="WorkflowPanel"  runat="server"></asp:Panel>
                                 </td>    
                           </tr>
                           <tr>
                            <td  valign="middle" class="lefttdbg">
                            <span class="subtitle"><%=strFormVersion%></span>
                            </td>
                            <td class="righttdbg" valign="middle">
				                    <asp:Panel ID ="VersionPanel"  runat="server" ></asp:Panel>
                                 </td>    
                           </tr>
                           <%} %>
                           
                           <tr>
                            <td  valign="middle" class="lefttdbg">
                            <span class="subtitle"><%=strXmlName%></span>
                            </td>
                            <td class="righttdbg" valign="middle">
				                    <asp:TextBox runat=Server ID="txtXmlName" width="150" CssClass="inputtext" MaxLength="30"></asp:TextBox>
                                 </td>    
                           </tr>
                            <tr>
                            <td  valign="middle" class="lefttdbg">
                            <span class="subtitle"><%=strXmlDesc%></span>
                            </td>
                            <td class="righttdbg" valign="middle">
				                    <asp:TextBox runat=Server ID="txtXmlDescription" width="150" TextMode=MultiLine Rows=3 CssClass="inputtextarea"></asp:TextBox>
                                 </td>    
                           </tr>
                         </table><br />
                         
                         </td>
                     </tr>  
                       <%if (IsListXml)
                           { %>
                       <tr>
                        <td height=27></td>
                       </tr>    
                       <%} %>
                     
                            </table>
                         </td>
      </tr>
      <tr class="lefttdbg">
        <td colspan="2" align=right>
            <table cellpadding="2" cellspacing="1">
                  <tr>                                     
                    <td align="right" style="padding-right:10px; padding-top:10px;padding-bottom:2px;">
                        <input type="button" name="btnClear" class="inputsecondarybutton" OnClick="javascript: window.close();" value="<%=strClose%>" style="margin-right:10px;" />
                        <asp:Button ID="btnUpdate" runat="server" Text="Submit"  CssClass="inputbutton" OnClick="Submit_Click"  />                       
                    </td>                        
                  </tr>                    
            </table>
        </td>
      
      </tr>            
    </table>
    
     <input type="hidden" name="hidactionname" id="hidactionname" value="<%= _actionname %>" />
    <input type="hidden" name="hidpropertyname" id="hidpropertyname" value="<%= _propertyname %>" /> 
    <input type="hidden" name="hid_applicationName" id="hid_applicationName" value="<%= ApplicationName %>" /> 
    <input type="hidden" name="hid_workflowName" id="hid_workflowName" value="<%= WorkflowName %>" />     
    <input type="hidden" name="hid_fileName" id="hid_fileName" value="<%= _fileName %>" />
    </form>    
</body>
</html>
<script language="javascript">
function ValidateXmlName()
{
if(document.getElementById("txtXmlName").value=="")
    {
        document.getElementById("txtXmlName").focus();
    //  alert('<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariableEnterVariableName")%>');
    se.ui.messageDialog.showError("<%=_actionname%>" + "-" + "<%=PropertyDisplayName%>", "<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariableEnterVariableName")%>");
        return false;
    }
    else
    {
        if (!CheckInputValue(document.getElementById("txtXmlName").value))
        {
            document.getElementById("txtXmlName").focus();
            return false;
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
                    // alert('<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariableVariableNamespace")%>');
                    se.ui.messageDialog.showError("<%=_actionname%>" + "-" + "<%=PropertyDisplayName%>", "<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariableVariableNamespace")%>");
                    errFlag = 2;
                    retValue=false;
                    break;

                case"$":
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
               
                // alert('<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariableVariableNamespecialchar")%>');
                se.ui.messageDialog.showError("<%=_actionname%>" + "-" + "<%=PropertyDisplayName%>", "<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariableVariableNamespecialchar")%>");
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