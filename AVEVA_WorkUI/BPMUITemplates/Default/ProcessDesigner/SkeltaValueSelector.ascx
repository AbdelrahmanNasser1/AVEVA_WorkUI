<%@ Control Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.Web.Designer.PropertyPages.SkeltaValueSelector" %>
<script src="<%=JavaScriptPath%>"></script>

<link href="<%=cssPath%>StyleSheet/global.css" rel="stylesheet" />
<TABLE width=100% border=0 cellspacing=0 cellpadding=0>
  <tr>
    <td>
      <table width=100% border=0 cellspacing=0 cellpadding=1>
        <tr>
          <td width="20%">
            <SELECT id="Select<%=CtrlID%>" class="inputselect" name="Select<%=CtrlID%>" language="javascript" onchange="return Select_onclick('Select<%=CtrlID%>','expr<%=CtrlID%>','<%=CtrlID%>');">
                 <OPTION value='<%=ValueItem%>' ><%=strValueItem%></OPTION>
              <OPTION value='Variable' ><%=strVariable%></OPTION>
              <OPTION value='Content' ><%=strContent%></OPTION>
              <OPTION value='XmlVariable' ><%=strXmlVariable%></OPTION>
            </SELECT>            
          </td>
          <td width="80%"><div id="expr<%=CtrlID%>"></div><!--<div id="expr<%=CtrlID%>"><input id="valueinput" name="Xvalueinput10" type='text' value=''></div>--></td>
        </tr>        
      </table>      
    </td>
  </tr>
</TABLE>
<asp:HiddenField ID="hValue" runat="server"/>
<script language=javascript>

        //document.onclick=windowmouseclickhandler;
        
        var valuediv<%=CtrlID%> = "<input id='valueinput<%=CtrlID%>' name='valueinput<%=CtrlID%>' class='inputtext' type='text' value='' onkeyup=\"return ValTypeText_onChange(this,'<%=CtrlID%>');\" onblur=\"return ValTypeText_onChange(this,'<%=CtrlID%>');\">";
        
        //var valuediv = "<input id='valueinput<%=CtrlID%>' name='valueinput<%=CtrlID%>' type='text' value=''>";
		var variablediv<%=CtrlID%> = "<SELECT id='valueinput<%=CtrlID%>' class='inputselect' name='valueinput<%=CtrlID%>' onchange=\"return SelectVarCont_onclick('valueinput<%=CtrlID%>','<%=CtrlID%>');\">";
		//variablediv<%=CtrlID%> += "<OPTION value='Variable.EmailApprove'>Variable.EmailApprove</OPTION><OPTION Value='Variable.SubmittedBy.Email ID,Variable.SubmittedBy.Email'>Variable.SubmittedBy.Email ID</OPTION><OPTION Value='Variable.SubmittedBy.First Name,Variable.SubmittedBy.FirstName'>Variable.SubmittedBy.First Name</OPTION><OPTION Value='Variable.SubmittedBy.Last Name,Variable.SubmittedBy.LastName'>Variable.SubmittedBy.Last Name</OPTION><OPTION Value='Variable.SubmittedBy.UserID,Variable.SubmittedBy.UserID'>Variable.SubmittedBy.UserID</OPTION><OPTION Value='Variable.SubmittedBy.Employee Name,Variable.SubmittedBy.UserName'>Variable.SubmittedBy.Employee Name</OPTION>";
		variablediv<%=CtrlID%> += "<%=VariableOptions%>";
		variablediv<%=CtrlID%> +=	"</SELECT>";

		var contentdiv<%=CtrlID%> = "<SELECT id='valueinput<%=CtrlID%>'class='inputselect' name='valueinput<%=CtrlID%>' onchange=\"return SelectVarCont_onclick('valueinput<%=CtrlID%>','<%=CtrlID%>');\">";
		contentdiv<%=CtrlID%> += "<%=ContentOptions%>";
		contentdiv<%=CtrlID%> +=	"</SELECT>";
		
		var XmlVariablediv<%=CtrlID%> = "<SELECT id='valueinput<%=CtrlID%>' class='inputselect' name='valueinput<%=CtrlID%>' onchange=\"return OnChangeVaraiable('<%=CtrlID%>',this)\">";
		XmlVariablediv<%=CtrlID%> += "<%=XmlVariableOptions%>";
		XmlVariablediv<%=CtrlID%> +=	"</SELECT>";
		
		var Selectdiv<%=CtrlID%> = "<input id='valueinput<%=CtrlID%>'class='inputtext' name='valueinput<%=CtrlID%>' type='hidden' value='' >";
		
		
		var SendTodiv<%=CtrlID%> = "<SELECT id='valueinput<%=CtrlID%>' class='inputselect' name='valueinput<%=CtrlID%>' onchange=\"return SelectVarCont_onclick('valueinput<%=CtrlID%>','<%=CtrlID%>');\">";
		SendTodiv<%=CtrlID%> += "<%=SendToOptions%>";
		SendTodiv<%=CtrlID%> +=	"</SELECT>";
        
        var Passworddiv<%=CtrlID%>="<input id='valueinput<%=CtrlID%>' class='inputtext' name='valueinput<%=CtrlID%>' type='password' value='' onkeyup=\"return ValTypeText_onChange(this,'<%=CtrlID%>');\" onblur=\"return ValTypeText_onChange(this,'<%=CtrlID%>');\">";
        
        SetSelectedValueType('Select<%=CtrlID%>','<%=ValueType%>');
		Select_onclickInitialize('Select<%=CtrlID%>','expr<%=CtrlID%>','<%=CtrlID%>');
		SetSelectedValue('valueinput<%=CtrlID%>','<%=Value%>','<%=ValueType%>');
	    SelectVarCont_onclick('valueinput<%=CtrlID%>','<%=CtrlID%>','<%=Value%>');
//alert("Test4");	    
</script>