<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.ListQueryPropertyPage"%>
<%@ Register Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="Workflow.NET.Web.Designer.NET2" Namespace="Workflow.NET.Web.Designer" TagPrefix="cc1"%>
<%@ Register Src="../../../Repository/Site/UcDynamicControl.ascx" TagName="DynamicQuery" TagPrefix="ucDQ" %>
<!DOCTYPE html>
<html>
<head id="Head1">
    <title><%:pagetitle %></title>
    <link href="<%:_designerControl.GetThemeRelativeUrl("Common/StyleSheet/Global.css")%>" rel="stylesheet" type="text/css" />
    <link href="<%:_designerControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css")%>" rel="stylesheet" type="text/css" />
    <link href="<%:_designerControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css")%>" rel="stylesheet" type="text/css" />
    <script src="../../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="../../../CommonUXControls/scripts/window/se.ui.min.js"></script>
    
<script language="javascript">
   function GetQueryFromMemo()
    {
   
        editorHtml = window.opener.GetMemoContent();//RadEContentTextareaRadEditor1
    
        if(editorHtml!=null)
        {
            var queryArea = document.getElementById('IdDynamicQuery_txtQuery');
            if(queryArea!=null && queryArea.value =="")
                queryArea.value = editorHtml
        }
 
    }
</script>
</head>
     <style>
       html, body
        {
            height: 100%;
            margin:10px;
        }

    </style>
<body onload="javascript:GetQueryFromMemo();">
    <form id="form1" runat="server" style="height:100%">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
         <table  border="0" cellpadding="0" cellspacing="0" style="height:96%;width:100%" >
              <tr>
                <td style="padding-bottom:1px;height:20px">
		            <table cellspacing="0" cellpadding="0" border="0" width="100%">
			            <tr>
				            <td  class="fontheading"><%:_propertyName%></td>
				            <td style="vertical-align:bottom" width="25"><a href="#"><img  id="helpimage"  src="<%:_designerControl.GetCommonRelativeUrl("Images/main-help.gif")%>" <%=_helpImageTags %> onclick="javascript:window.open('<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_designerControl.GetHelpPageUrl(), false)%>XmlListNavigatorActivity-QueryBuilder.html','test','width=600,height=500,scrollbars=yes,resizable=yes')"  border="0"/></a></td>
			            </tr>
		            </table>
		        </td>
              </tr>
            
	          <tr >
	                <td style="height:45%">
                      
	                            <table class="fieldset"  width="100%">
	                                <tr>
	                                    <td style="width: 20%" align="left">
                                            <asp:Label ID="lblListName" CssClass="subtitle" runat="server"></asp:Label>
                                        </td>
                                        <td>
                                            <telerik:RadComboBox ID="RadComboListName" AutoPostBack="true" runat="server" Width="160" Height="120px"
                                                Skin="AWTCombobox" RenderMode="Classic" EnableEmbeddedSkins="false">
                                            </telerik:RadComboBox>
                                            <input type="hidden" id="hdnListName" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <div  id="divparent" runat="server">        
                                                <ucDQ:DynamicQuery  Id="IdDynamicQuery" runat="server">
                                                </ucDQ:DynamicQuery>
                                            </div>      
                                        </td>
                                    </tr>   
                                                                
	                            </table>
	                       
                    </td>
                </tr>
               
                <tr>            
                    <td style="text-align:right" colspan="2">                     
                        <table border="0" cellpadding="0" cellspacing="0" width="100%" >
                            <tr valign="top">
                                <td style="text-align:right;padding-right:5px">
                                    <asp:Button ID="btnClose" runat="server" OnClick="btnClose_Click" CssClass="inputbutton"/>                                   
                                </td>
                            </tr>
                        </table>
                   </td>
                </tr> 
         </table>             
    </form>
</body>
</html>
