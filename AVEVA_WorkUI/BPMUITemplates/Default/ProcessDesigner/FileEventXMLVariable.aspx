<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.WorkflowEvents.FileEventDataVariable" %>
<%@ Assembly Name="Workflow.NET.Web.Designer.NET2"%>
<%@ Import namespace="Workflow.NET.Web.Designer"%>
<%@ Assembly Name="Workflow.NET.NET2"%>
<%@ Import namespace="Workflow.NET"%>
<html>
<head id="Head1">
    <title><%= pagetitle %></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <link href="<%=_designerControl.GetCommonRelativeUrl("stylesheet/global.css")%>" rel="stylesheet" type="text/css" />
    <script type='text/javascript' src='<%=JScriptPath%>'></script>    
</head>
<body>
    <form id="form1" runat="server">
    <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
    <table  border="0" cellpadding="0" cellspacing="0" height="100%" width="100%" style="background-color:#fffff">
          <tr align="center">
            <td valign="bottom" height="25" background="<%=_designerControl.GetCommonRelativeUrl("Images/top-bg.gif")%>">
		        <table cellspacing="0" cellpadding="0" border="0" width="100%">
			        <tr>
				        <td valign="middle" height="25" class="Header2" style="height: 24px;color:White;font-size:12px"><b><%:_propertyName%></b></td>
				        <td valign="top" width="25"><a href="#"><img  id="helpimage" src="<%=_designerControl.GetCommonRelativeUrl("Images/main-help.gif")%>"  onclick="javascript:window.open('<%=_designerControl.GetHelpPageUrl()%>AboutTheXMLVariableUserInterface.html','test','width=600,height=500,scrollbars=yes,resizable=yes')" width="21" border="0" height="24"/></a></td>
			        </tr>
		        </table>
		    </td>
          </tr>
          <tr style="height:50px">
            <td style="height: 50px" >
              <table border="0" cellpadding="0" cellspacing="0" height="100%" width="100%" class="inputs">
                    <tr>
				        <td align="left" colspan="2">
				            <asp:Label ID="lblErrorMessage" runat="server" Font-Names="Verdana,Tahoma" Font-Size="11px" ForeColor="red"></asp:Label>
				            <asp:RequiredFieldValidator ID="rfvNewSPEventData" runat="server" ControlToValidate="txtNewSPEventData"
                                                                        ErrorMessage="Enter Variable Name" Display="Dynamic" EnableClientScript="false"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revNewSPEventData" runat="server" ControlToValidate="txtNewSPEventData"
                                                                        ErrorMessage="Invalid Variable Name" ValidationExpression="[0-9 a-z A-Z]*"  Display="Dynamic" EnableClientScript="false" ></asp:RegularExpressionValidator>
				        </td>
				    </tr>
                    <tr>
				        <td align="left" style="width: 300px">
					        <asp:Label ID="lblNewSPEventData" runat="server" CssClass="propertiesboxinput"></asp:Label>
				        </td>
				        <td align="left">
                            <asp:TextBox ID="txtNewSPEventData" runat="server" CssClass="propertiesboxinput" MaxLength="30"></asp:TextBox>
                        </td>
			        </tr>
	            </table>
                <br/>
	         </td>
	      </tr>
          <tr>
            <td align="right" valign="top" style="background-color:#256194;">
                <table border="0" cellpadding="0" cellspacing="0" width="90%" height="20%">
	                <tr valign="top">
	                    <td align="right" valign="top">
                            <asp:Button ID="btnOk" runat="server" OnClick="btnOk_Click" CssClass="input-buttonswork" CausesValidation="true" />
                            <asp:Button ID="btnClose" runat="server" OnClick="btnClose_Click" CssClass="input-buttonswork" CausesValidation="false"/>
                        </td>
                    </tr>
               </table>
           </td>
          </tr> 
      </table>
      <table>
      <tr>
      <td>
      </td>
      </tr>
      </table>
    </form>
</body>
</html>

