<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.WorkflowEvents.WorkflowEventDataVariable" %>
<%@ Assembly Name="Workflow.NET.Web.Designer.NET2"%>
<%@ Import namespace="Workflow.NET.Web.Designer"%>
<%@ Assembly Name="Workflow.NET.NET2"%>
<%@ Import namespace="Workflow.NET"%>
<!DOCTYPE html>
<html>

<head id="Head1">
    <title><%= pagetitle %></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(_designerControl.GetCommonRelativeUrl("stylesheet/Global.css"))%>" rel="stylesheet" type="text/css" />
    <script type='text/javascript' src='<%=JScriptPath%>'></script>    
</head>
    <style>
       html, body
        {
            height: 100%;
            overflow:hidden;
        }
      

    </style>
    <link href="<%=bellyBarPath%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
<body style="margin:10px">
 <script>
     se.ui.messageDialog.setGlobalOptions({
         localization: { // All localization related default can be set
             closeButtonCaption: "<%=_resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                okButtonCaption: "<%=_resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                cancelButtonCaption: "<%=_resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                showDetailsCaption: "<%=_resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                hideDetailsCaption: "<%=_resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
            }
        });
    </script>

 <form id="form1" runat="server">
     <%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <table  border="0" cellpadding="0" cellspacing="0" style="height:100%;width:100%">
          <tr >
            <td valign="top">
		        <table cellspacing="0" cellpadding="0" border="0" width="100%" class="ListHeaderCss">
			        <tr >
				        <td valign="middle" height="25" style="text-align:left"><span class="fontheading"> <%=Microsoft.Security.Application.Encoder.HtmlEncode(_propertyName)%></span></td>
				        <td valign="top" width="25"><a href="#"><img  id="helpimage" src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(_designerControl.GetCommonRelativeUrl("Images/main-help.gif"))%>"  onclick="javascript:window.open('<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_designerControl.GetHelpPageUrl(), false)%>AboutTheXMLVariableUserInterface.html','test','width=600,height=500,scrollbars=yes,resizable=yes')" border="0"/></a></td>
			        </tr>
		        </table>
		    </td>
          </tr>
          <tr >
            <td>
              <table border="0" cellpadding="2" cellspacing="2" width="100%">
                    <tr>
				        <td align="left" colspan="2">
				            <asp:Label ID="lblErrorMessage" runat="server" CssClass="description" ></asp:Label>
				            <asp:RequiredFieldValidator ID="rfvNewSPEventData" runat="server" ControlToValidate="txtNewSPEventData"
                                                                        ErrorMessage="Enter Variable Name" Display="Dynamic" EnableClientScript="false"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revNewSPEventData" runat="server" ControlToValidate="txtNewSPEventData"
                                                                        ErrorMessage="Invalid Variable Name" ValidationExpression="[0-9 a-z A-Z]*"  Display="Dynamic" EnableClientScript="false" ></asp:RegularExpressionValidator>
				        </td>
				    </tr>
                  
                    <tr>
				        <td >
					        <asp:Label ID="lblNewSPEventData" CssClass="subtitle" runat="server"></asp:Label>
				        </td>
				        <td style="text-align:right">
                            <asp:TextBox ID="txtNewSPEventData" CssClass="inputtext" runat="server"  style="width:240px" MaxLength="30"></asp:TextBox>
                        </td>
			        </tr>
                  <tr>
                      <td colspan="2" style="height:65px">&nbsp;</td>
                  </tr>
                  <tr valign="top" >
	                    <td style="text-align:right;" colspan="2">
                            <asp:Button ID="btnClose" runat="server" OnClick="btnClose_Click" CssClass="inputsecondarybutton" CausesValidation="false"/>
                            <asp:Button ID="btnOk" runat="server" OnClick="btnOk_Click" CssClass="inputbutton" CausesValidation="true" />
                            
                        </td>
                    </tr>
	            </table>
                <br/>
	         </td>
	      </tr>
         
      </table>
    <!--  <table>
      <tr>
      <td>
      </td>
      </tr>
      </table> -->
    </form>
</body>
</html>

