<%@ Page Language="C#" AutoEventWireup="true" CodeFile="memo.aspx.cs" Inherits="_Default"
     Theme="" StylesheetTheme="" %>

<%@ Register TagPrefix="radE" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE html> 
<html>



<script type='text/javascript' src='<%=JScriptPath%>'></script>

<script type='text/javascript'>
    function ShowErrorMsg(errmsg)
    {
        //alert(errmsg);
        ShowMessagesWithBellyBar(2, errmsg);
    }
</script>

<head runat="server">
    <title>
        <%=PageTitle%>
    </title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
</head>
<body style="overflow:hidden;height:100%;">
    <form id="form1" runat="server" style="height:100%;">
         <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <link href="<%=themePath%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
        <script>
            // Initialize locales for message dialog
            se.ui.messageDialog.setGlobalOptions({
                localization: { // All localization related default can be set
                    closeButtonCaption: "<%=resource.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                    okButtonCaption: "<%=resource.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                    cancelButtonCaption: "<%=resource.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                    showDetailsCaption: "<%=resource.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                    hideDetailsCaption: "<%=resource.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
                }
            });

            function ShowMessagesWithBellyBar(messageType, messageToDisplay)
            {
                var bellyBarTitle = "<%=PageTitle%>";
                switch (messageType)
                {
                    case 1: se.ui.messageDialog.showAlert(bellyBarTitle, messageToDisplay);
                        break;
                    case 2: se.ui.messageDialog.showError(bellyBarTitle, messageToDisplay);
                        break;
                }
            }
        </script>
        <link href="<%=ProcessDesignerControl.GetCommonRelativeUrl("StyleSheet/Global.css")%>"
    rel="stylesheet" type="text/css" />
     <link href="<%=ProcessDesignerControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/SkeltaEditor/Editor.css")%>" rel="stylesheet" type="text/css" />    
    <link href="<%=ProcessDesignerControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/SkeltaEditor/Editor.SkeltaEditor.css")%>" rel="stylesheet" type="text/css" />
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <table style="width:100%;border-collapse:separate;border-spacing:1px;height:100%;">
            <tr>
                <td style="width: 100%;">
                    <table style="width:100%;border-collapse:collapse;border-spacing:0px;">
                        <tr class="ListHeaderCss">
                            <td class="fontHeading" style="padding-left:10px;">                               
                                 <%=prop%>                                
                            </td>
                            <td style="text-align:right">
                                <span title="Help" class="description">
                                    <img src="<%=ProcessDesignerControl.GetCommonRelativeUrl("Images/main-help.gif")%>"
                                        alt="Help" <%=helpimagetags%> style="cursor: pointer;"  /></span>
                            </td>
                        </tr>
                        
                    </table>
                </td>
            </tr>
            <tr style="height:100%;">
                            <td style="padding-left:10px;padding-right:10px;height:100%;" colspan="2">
                                
                                            <radE:RadEditor ID="RadEditor1" runat="server" Editable="true" SaveInFile="true"
                                                ShowHtmlMode="false" ShowPreviewMode="false" OnClientCommandExecuting="OnClientCommandExecuting"
                                                ShowSubmitCancelButtons="false" 
                                                ToolsFile="<%$ ReplaceTemplateExpn:Expression/Editor/ToolsFileMemo.xml%>" Skin="SkeltaEditor"
                                                AllowScripts="true" Width="100%" EditModes="Design" EnableEmbeddedSkins="false"  >
                                            </radE:RadEditor>
                                        
                            </td>
                        </tr>
            <tr>
                <td style="height:30px;padding-top:20px;">
                    <table style="width:100%">
                        <tr>
                            <td style="height: 30px;width:80%;">                               
                                <asp:Label ID="lbl" CssClass="errormsg" runat="server" Text=""></asp:Label>
                            </td>                                       
                            <td style="text-align:right;width:10%;padding-right:10px;">
                            <input name="button2" type="button" class="inputsecondarybutton"  id="btnClear"
                                onclick="window.close()" value="<%=Close%>" /></td>
                            <td style="text-align:right;width:10%;padding-right:8px;">
                            <asp:Button ID="btnUPDATE" runat="server" OnClick="Button1_Click" CssClass="inputbutton" />
                            </td>
                                   
                                <input type="hidden" name="hidactionname" id="hidactionname" value="<%= actionname %>" />
                                <input type="hidden" name="hidpropertyname" id="hidpropertyname" value="<%= propertyname %>" />
                                <input type="hidden" name="hid_applicationName" id="hid_applicationName" value="<%= _applicationName %>" />
                                <input type="hidden" name="hid_workflowName" id="hid_workflowName" value="<%= _workflowName %>" />
                                <input type="hidden" name="hid_fileName" id="hid_fileName" value="<%= _fileName %>" />
                                <input type="hidden" name="hidact" id="hidact" value="<%=act%>" />
                                <input type="hidden" name="hidprop" id="hidprop" value="<%=prop%>" />
                                <input type="hidden" name="hidUpdate" id="hidUpdate" value="<%=Update%>" />
                                <input type="hidden" name="hidClose" id="hidClose" value="<%=Close%>" />
                                <input type="hidden" name="hidWorkflow" id="hidWorkflow" value="<%=sWorkflow%>" />
                                <%=pda.GetHTML()%>
                            </tr>
                        </table>
                            </td>
                        </tr>
                    </table>
                
    </form>
</body>
</html>

<script type="text/javascript">



        function clientConfirm()
        {
            var editor = $find("<%=RadEditor1.ClientID%>");
                if (editor.get_text()== "")
                     {
                    //alert("Cannot Update");
                    ShowMessagesWithBellyBar(2, "Cannot Update");
                         return false;
                     }
                   
                    var toConfirm = confirm( "Are you sure you want to update?");
                    if (toConfirm)
                    {
                     return true;
                    }
                    else
                     {
                        return false;
                     }
                    
            
            }
            

       function OnClientCommandExecuting (editor, commandName, oTool)
        { 
          if ("FindAndReplace" == commandName) 
          return false;     
        }


           
</script>

