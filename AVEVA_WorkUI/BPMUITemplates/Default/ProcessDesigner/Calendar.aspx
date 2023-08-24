<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Calendar.aspx.cs" Inherits="SkeltaTemplates_Default_ProcessDesigner_Calendar" Debug="true"%>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<html style="height: 100%">
<head id="Head1">
    <title><%=sWorkflow%>-<%=_Actionname%>-<%=_PropertyDisplayName%></title>
    <link href="<%=ProcessDesignerControl.GetCommonRelativeUrl("stylesheet/Global.css")%>" rel="stylesheet" type="text/css" />
       <script src="../Common/JavaScripts/jquery.min.js"></script> 
     <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
   
  
    <script type='text/javascript' src='<%=_JScriptPath%>'></script>
</head>
<body style="overflow:hidden;" >

    <script>

        se.ui.messageDialog.setGlobalOptions({
            localization: {
                closeButtonCaption: "<%=ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
            okButtonCaption: "<%=ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
            cancelButtonCaption: "<%=ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
            showDetailsCaption: "<%=ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
            hideDetailsCaption: "<%=ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
        }
    });

        function DisplayMessage() {
             var strMessage = '<%=ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("No Calendars defined") %>';
              var strHdrMsg = '<%=_PropertyDisplayName%>';
              se.ui.messageDialog.showError(strHdrMsg, strMessage);
          }



</script>


    <form id="form1" runat="server" > 
      <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
             </telerik:RadScriptManager>
      <link href="<%=themePath%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" /> 
      <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(themePath)%>TelerikAjax/StyleSheet/AWTTreeView/TreeView.AWTTreeView.css" />
     <table style="border-spacing:1px;border-collapse:separate;height:300px;width:100%;">
      <tr >
        <td style="width: 99%" valign="top" > 
		    <table width="100%" border="0" cellspacing="0" cellpadding="0" >
                <tr valign="top">
                    <td class="ListHeaderCss" valign="middle" style="padding-left:10px">
                        <span class="fontheading">
                            <%=_Actionname%>
                            -<%=_PropertyDisplayName%></span></td>
                    <td class="ListHeaderCss" valign="middle" style="padding-right:10px">
                        <span title="Help">
                            <img src="<%=ProcessDesignerControl.GetCommonRelativeUrl("Images/main-help.gif")%>"
                                align="right" style="cursor: pointer" <%=_Helpimagetags%>/></span></td>
                </tr>
                <tr>
                    <%--<td style="width: 100%" class="errormsg" colspan="2">
                        &nbsp;&nbsp;<%=ErrMsg%></td>--%>
                </tr>
                <tr>
                    <td colspan="2" class="lefttdbg" align="center">
                        <%-- <br />--%>
                        <table style="width: 97%;border-spacing: 1px; border-collapse: separate;" class="tablePdbg">
                            <tr>
                                <td class="lefttdbg" style="padding:1px;" >                                  

                                    <telerik:RadTreeview ID="RadTree1"  RenderMode="Classic" runat="server" Height="160px" Width="170px" Skin="AWTTreeView"
                                    AutoPostBack="false"  EnableEmbeddedSkins="false"  OnClientNodeClicking="ProcessClientClick" ShowLineImages="false">
                                </telerik:RadTreeview>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>      
            </table>
         </td>
      </tr>
        <tr>
            <td style="height: 30%" colspan="0">
                <table border="0" style="width: 100%">
                    <tr>
                        <td align="left" style="width: 60%">
                            <asp:CheckBox ID="ChkRsrcCalendar" runat="server" CssClass="inputcheckbox" />
                        </td>
                        <td align="right" style="padding-top: 10px; padding-right: 10px; white-space: nowrap">
                             <asp:Button ID="btnNoClndr" runat="server" Text="Remove" CssClass="inputsecondarybutton" OnClick="btnNoClndr_Click"
                                />&nbsp;
                        <asp:Button ID="btnSetClndr" runat="server" Text="Set Calendar" CssClass="inputbutton"
                                OnClick="btnSetClndr_Click"/>&nbsp;                           
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
           <input type="hidden" name="hidactionname" id="hidactionname" value="<%= _Actionname %>" />
                        <input type="hidden" name="hidpropertyname" id="hidpropertyname" value="<%= _Propertyname %>" /> 
                        <input type="hidden" name="hid_applicationName" id="hid_applicationName" value="<%= _ApplicationName %>" /> 
                        <input type="hidden" name="hid_workflowName" id="hid_workflowName" value="<%= _workflowName %>" /> 
                        <input type="hidden" name="hid_fileName" id="hid_fileName" value="<%= _fileName %>" />
                        <input type="hidden" name="hid_nodval" id="hid_nodval" value="" />
                         <input type="hidden" name="hid_findnode" id="hid_findnode" value="<%=_Findnode %>" />               
                        
                        <%=pda.GetHTML()%>
                                  
    </form>
        <script language="javascript" type="text/javascript">

            function ProcessClientClick(sender, eventArgs)
            {
                var node = eventArgs.get_node();
                lhsvalue = node.get_text();
                document.getElementsByTagName("input")["hid_nodval"].value = lhsvalue + "/" + node.get_value();
            }
       
        
        </script> 



</body>
</html>
