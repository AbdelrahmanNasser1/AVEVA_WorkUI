<%@ Page Language="C#" AutoEventWireup="true"  Inherits="Skelta.Repository.CodeBehind.Codebehind.Site.ConfigureExceptionOutputs" CodeFile="ConfigureExceptionOutputs.aspx.cs" %>


<html>
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=_propertyHeading%></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
</head>
<script type ="text/javascript" > 
function openhelpwin()
    {
        
        window.open('<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(helpUrl, false)%>StartActivity1.html#Exception','helpwin','height = 450, width = 600,scrollbars=yes,resizable=yes');    
    }
</script>
<body style="overflow:hidden;">
<form id="FExp"  runat="server">
	<%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <link rel="stylesheet" type="text/css" href="<%:cssPath%>Common/StyleSheet/Global.css" />
	<div id="divcheck" style="overflow:auto;height:560px;" >
	<table style="width:100%;height:100%">
   
	<tr>
		<td valign="middle" height="25" style="padding-bottom:3px;">
            <table cellspacing="0" cellpadding="0" class="ListHeaderCss" border="0" width="100%">
                <tr>
                    <td valign="middle" height="25" style="padding-left: 10px">
                        <span class="fontheading">
                            <%=_propertyHeading%>
                        </span>
                    </td>
                     <td valign="middle" style="padding-right: 10px">
                       <span title="<%=helpText%>">
                        <img src="<%:PdCtrl.GetCommonRelativeUrl("Images/main-help.gif")%>"
                        align="right" onclick="javascript:openhelpwin()" style="cursor: pointer" alt="<%=helpText%>" /></span>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
   
   <tr>
       <td align="left"  colspan="2" valign="top" >                                                
             <table width="95%" border="0" cellspacing="2" cellpadding="6" align="center"  class="tablebg" >
                <tr>
                    <td class="lefttdbg" align="left"  width="45%" valign="top" >
                        <span class="subtitle"><%=_MappedErrorOutputs%></span>                        
                        <br/>
                        <span class="description"><%=_MappedErrorOutputsDescription%></span>                                              
                        <br />
                        <span class="description"><%=_ExcludeOrIncludeOutputsMessage%></span> 
                    </td>
                    <td class="righttdbg">
                        <asp:CheckBoxList ID="chkOutPuts" runat="server" CssClass="inputcheckbox" ></asp:CheckBoxList> 
                        <span class="description"><%=_NoOutputs%></span> 
                    </td>                   
                    
                 </tr>
                 <tr>
                 <td class="lefttdbg"  colspan="2" >
                 <span class="subtitle"><%=_ErrorBehaviourDescription%></span>
                 </td>
                 </tr>
                
                 <tr>
                    <td class="lefttdbg" align="left"  width="45%">
                        <span class="subtitle"><%=_ErrorBehaviour%></span> 
                        <br />
                        <span class="description"><%=_ErrorBehaviourItemsDescription%></span>
                        <br />
                        <span class="description"><%=_ErrorBehaviourItems1Description%></span>
                    </td>
                    <td class="righttdbg">
                        <asp:RadioButtonList ID="radErrorBehaviour" runat="server" CssClass="inputradio">
                        </asp:RadioButtonList>
                    </td>
                    
                 </tr>
                 
                 <tr>
                 <td class="lefttdbg" colspan="2" >
                 <img id="Img2" runat="server" src="<%$ ReplaceTemplateExpn:/Common/Images/icon-note.png%>" align="absmiddle" />
                 <span class="description";" ><%=_RaiseErrorDescription%></span>
                 </td>                 
                 </tr>
                
                <tr>
                <td class="lefttdbg" colspan="2">
                <%if (!string.IsNullOrEmpty(_SpChanged)){ %>
                <img id="Img3" runat="server" src="<%$ ReplaceTemplateExpn:/Common/Images/icon-note.png%>" align="absmiddle" />
                <span class="description">
                    <%=_PropStopOnExceptionHidden%>
                    <%=_SpChanged%> 
                </span>
                <%} %>
                </td>
                </tr>
                
                <tr>
                 <td class="lefttdbg" colspan="2" >
                 <img id="Img1" runat="server" src="<%$ ReplaceTemplateExpn:/Common/Images/icon-note.png%>" align="absmiddle" />
                 <span class="description"><%=_EnableErrorEncounteredDesc%></span>
                 </td>                 
                 </tr>
             </table>
                            
         
         </td>
   </tr>    
       
  
</table>  

 </div>
    <div>
        <table style="width:100%;height:10%;">
             <tr>
             <td>     
            <table width="100%" border="0" cellspacing="0">
                <tr>
                    <td width="100%" align="right" style="padding:10px">
                        <input type="button" name="Submit2" width="40%" class="inputsecondarybutton" value="Close" tabindex="23"
                            id="btnCancel" runat="server"  onclick="window.close()"/>
                        &nbsp;<input type="button" name="Submit" class="inputbutton" value="OK" id="btnOk"
                            runat="server" onserverclick="btnOk_Click" tabindex="22" />
                        
                        
                    </td>
                   
                </tr>
            </table>

      </td>
      </tr>

        </table>

    </div>

</form>
</body>

</html>
