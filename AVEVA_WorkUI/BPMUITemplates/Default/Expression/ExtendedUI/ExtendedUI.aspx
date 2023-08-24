<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ExtendedUI.aspx.cs" Inherits="SkeltaTemplates_Default_Expression_ExtendedUI" Theme="" StylesheetTheme=""%>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ Assembly Name="Workflow.NET.Web.Designer.NET2" %>
<%@ Import namespace="Workflow.NET.Web.Designer" %>
<script runat="server">
 
    protected ProcessDesigner PD;
    protected ExpressionBuilderControl exp;
    protected string _keyValue = "";  
    protected string _applicationName="";
    protected string _workflowName="";
    protected string _fileName="";

    
    override protected void OnLoad(EventArgs e)
    {
        base.OnLoad(e);
    }


  

</script>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head runat="server">
    <title></title>
    <script type="text/javascript" src="../../Common/JavaScripts/jquery.min.js"></script>
    <script type="text/javascript" src="../../Common/JavaScripts/AutoLogoff.js"></script>
</head>
<style type="text/css">
<!--
BODY
{
	BORDER-RIGHT: 0px; BORDER-TOP: 0px; FONT-SIZE: 11px; MARGIN: 0px; BORDER-LEFT: 0px; CURSOR: default; BORDER-BOTTOM: 0px; 
}
-->
</style>


<script type="text/javascript" src="<%=exp.GetJscriptUrl("javascript/ExpressionBuilderLatest.js")%>"></script>
<link rel="stylesheet" type="text/css" href="<%=exp.GetTemplateRelativeUrl("stylesheet/StyleDefault.css")%>">
	<link rel="stylesheet" type="text/css" href="<%=exp.GetTemplateRelativeUrl("TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css")%>">
	<link rel="stylesheet" type="text/css" href="<%=exp.GetTemplateRelativeUrl("TelerikAjax/StyleSheet/AWTCombobox/Combobox.css")%>">    
<body>
    <form id="form1" runat="server">
     <%=System.Web.Helpers.AntiForgery.GetHtml()%>
		<telerik:RadScriptManager ID="radScriptManager" runat="server"></telerik:RadScriptManager>
    <div>
             <table border="0" width="100%" class=Content ID="Table1" cellpadding="0" cellspacing="1" bgcolor="#256194">
	            <tr>
		            <td class="Header2">&nbsp;&nbsp;Extended UI</td>
	            </tr>
	            <tr>
		            <td height="100" valign="top" bgcolor="#FFFFFF" class="EnabledDTCText">
			            <div id="divMain" style="width:100%;Visibility:visible;display:block">
				            <table border="0" width="100%" align="center" ID="Table2" cellpadding="0" cellspacing="0">
			                    <tr>
			                        <td>&nbsp;</td>
			                    
			                    </tr>
			                    <TR>
			                        <td width="50%" valign="middle" align="center" bgcolor="#FFFFFF" class=ContentText>Path:</td>
			                        <td width="50%" valign="middle" bgcolor="#FFFFFF" >
				                    <telerik:RadComboBox  ID="RadComboBox1" 
							            Runat="server" 
							            Height="140px" 
							            Width="150px" 
							            Skin="AWTCombobox"  EnableEmbeddedSkins="false"
							            EnableLoadOnDemand="True"  RenderMode="Classic"							            >
							        </telerik:RadComboBox>
										 

				                    <asp:TextBox ID="pathfield" name="pathfield" runat=server Visible=false></asp:TextBox>
				                 </TD>							
			                  </tr> 
			 	            </table>
		                </div>
	    	            <div id="divStatus" style="width:100%;Visibility:hidden;display:none"></div>
	              </td>
	            </tr>
	             <tr>
                    <td colspan="2" align="right" bgcolor="#256194" height="26">
	                    <input type="button" name="btnGo" ID="btnGo" value="  OK  " onClick="javascript:OnSubmitExtendedUI();" class="input-buttonswork" >
	                    <input type="button" name="btnGo" ID="Button1" value="Cancel" onClick="javascript:window.close();" class="input-buttonswork" >
	                    <input type="hidden" id="ApplicationName" name="ApplicationName" value= "<%=_applicationName%>" />
	                    <input type="hidden" id="WorkflowName" name="WorkflowName" value="<%=_workflowName%>" />
	                    <input type="hidden" id="FileName" name="FileName" value="<%=_fileName%>" />
	                    <input type="hidden" id="KeyValue" name="KeyValue" value="<%=_keyValue%>" />
	                    
	               </td>
                </TR>		
	            <!--IN this the HTML content for the method will be replaced-->	
          </table>    
    </div>
    </form>
</body>
</html>
