<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SetPriorityForRole.aspx.cs" Inherits="BPMUITemplates_Default_HWS_SetPriorityForRole"  %>

<!DOCTYPE html>
<html>
<head runat="server">
<title></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=JSPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <style type="text/css">
        html, body,form
        {
            height:100%;            
            width:100%;
            overflow:hidden;
        }
    </style> 
<script type="text/javascript">
    var specialKeys = new Array();
    specialKeys.push(8); //Backspace
    function IsNumeric(e)
    {        
        var keyCode = e.which ? e.which : e.keyCode;
        var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) !== -1);
        return ret;
    }

    function GetRadWindow() {
        var oWindow = null;
        if (window.radWindow) oWindow = window.radWindow;
        else if (window.frameElement) {
            if (window.frameElement.radWindow)
                oWindow = window.frameElement.radWindow;
            else
                window.location.reload();
        }
        return oWindow;
    }
    function CloseWindow() {
        var oWindow = GetRadWindow();
        oWindow.close();
    }

    function RefreshandClose() {        
        GetRadWindow().BrowserWindow.RefreshGrid();
    }

    function ShowBellyBarAlertMessageWithCallBack(strTitle, strMessage) {
        se.ui.messageDialog.showAlert(strTitle, strMessage, function () {
            RefreshandClose();
        });
    }

    function Validate()
    {
        if (document.getElementById('txtPriority').value == '')
        {            
            se.ui.messageDialog.showError('<%=strWindowTitle%>', '<%=strValidateMessage%>');
            return false;
        }

        if (document.getElementById('txtPriority').value == 0) {
            se.ui.messageDialog.showError('<%=strWindowTitle%>', '<%=strValidateZero%>');
            return false;
        }
   }

</script>
</head>
<body>
    <script>
        se.ui.messageDialog.setGlobalOptions({
            localization: {
                closeButtonCaption: "<%=GR.GetString("se_ui_messagedialog_close_caption") %>",
                okButtonCaption: "<%=GR.GetString("se_ui_messagedialog_ok_caption") %>",
                cancelButtonCaption: "<%=GR.GetString("se_ui_messagedialog_cancel_caption") %>",
                showDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_showdetails_caption") %>",
                hideDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_hidedetails_caption") %>"
            }
        });
    </script>
    <form id="form1" runat="server" >
	<%=System.Web.Helpers.AntiForgery.GetHtml()%>
     <link href="<%=cssPath%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" type="text/css" />
     <link rel="stylesheet" type="text/css" href="<%=cssPath %>Common/StyleSheet/Global.css" />
       <br /> 
    <div style="height: 100%; width: 100%;">

         <div style="width: 100%;padding-left:20px;">
            <img alt="" src="<%=cssPath%>HWS/images/RolePriority.png" style="vertical-align:middle" /> 
            <span class="MainHeading"> <%=GR.GetString("Queue_RolePriorityDesc")%> </span>
         </div>


         <div style="width: 100%;padding:25px;">
            <div style="width:30%;float:left;">
             <span class="subtitle" style="width: 50%;vertical-align:middle;padding:6%"> <%=GR.GetString("Queue_RoleNameText")%> </span> 
            </div> 
            <div style="width:70%;float:right;">
                <asp:TextBox ID="txtRoleName" runat="server" ReadOnly="true" CssClass="inputtext" style="width: 60%;"  ></asp:TextBox>
            </div>                
         </div>
        <div style="width:100%;padding:25px;">
            <div style="width:30%;float:left;">
             <span class="subtitle" style="width: 50%;vertical-align:middle;padding:6%"> <%=GR.GetString("Queue_RolePriorityText")%> </span> 
            </div>
            <div style="width:70%;float:right;">
                <asp:TextBox ID="txtPriority" runat="server" CssClass="inputtext" style="width: 60%;" onkeypress="return IsNumeric(event);" onpaste="return false" MaxLength="4"  ></asp:TextBox>
            </div>
        </div>

        <div style="width:100%;padding:25px;"> 
                <img src="<%=cssPath%>Repository/Site/images/icon-warnings.png"  style="vertical-align:middle;" />
                                                            
            <span class="note" >
            <%= GR.GetString("Queue_RolePriorityDescNote")%>
            </span>

        </div>

        <div style="text-align: right; padding-top: 24%; padding-right: 20px;">                          
            <asp:Button ID="btnCancel" runat="server" OnClientClick="javascript:CloseWindow();" CssClass="inputsecondarybutton" /> &nbsp;
            <asp:Button ID="btnSetPriority" runat="server" Text="Save"  CssClass="inputbutton" OnClick="btnSetPriority_Click" OnClientClick="return Validate();" />
        </div>
 
    </div>
    </form>
</body>
</html>
