
<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Package.CodeBehind.GlobalSettings" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!Doctype html>
<html style="height:100%">
<head runat="server">
    <title>
        var pageTitle = <%= resourceManager.GlobalResourceSet.GetString("pkg_glbl_stng_title")%></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
</head>


<script  type="text/javascript">
    var removeMessage = "<%= this.resourceManager.GlobalResourceSet.GetString("pkg_rem_glbl_conf") %>";
    function GetRadWindow() {
        var oWindow = null;
        if (window.frameElement != null)
            oWindow = window.frameElement.radWindow;
        return oWindow;
    }
    function closeWindow(msg) {
        try {
            var oWindow = GetRadWindow();
            oWindow.close();
            if (msg)
                showMessageAndClose(pageTitle, msg);
                //alert(msg);
        }
        catch (e)
        { }
    }
    function ResizeWindow() {
        //var oWnd = GetRadWindow();
        //oWnd.SetSize(400, 220);
    }

    function showMessageAndClose(title, messageType, message)
    {
        var pageTitle = title;
        self = window;
        var oWindow = GetRadWindow();
        switch (messageType)
        {
            case "Error":
                se.ui.messageDialog.showError(pageTitle, message);
                break;
            case "Message":
                se.ui.messageDialog.showAlert(pageTitle, message);
                break;
            case "Confirmation":
                se.ui.messageDialog.showConfirmation(pageTitle,
                 message,
                function (userResponse)
                {
                    if (userResponse)
                    {
                        window.setTimeout(closeHandlerFn, 100);
                    }
                });

                break;
            default:
                // Only if it is a radWindow, show it
                break;
        }
    }
</script>

<body style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px;
    border-style: none; padding-top: 0px;height:100%">
    <form id="form1" runat="server" style="height:100%">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
    <link href="<%=themePath%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
    <link href="<%=themePath%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
        <link href="<%=themePath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css" rel="stylesheet" type="text/css" />
         <link href="<%=themePath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css" rel="stylesheet" type="text/css" />
    <div style="height:100%">
        <table style="width:94%;margin:auto;border-width:0;height:20%">
            <!--pagetitle GlobalSettings -->
             <tr>
                <td class="pagetitle" colspan="3">
                    <img alt="" src="<%=themePath%>/Repository/ListControl/images/icon-global-settings.png"
                       style="vertical-align:middle" />
                    <span class="pagetitle ">
                        <%= resourceManager.GlobalResourceSet.GetString("pkg_glbl_stng_title")%>
                    </span>
                </td>
            </tr>
            <tr>
                <td class="description" style="text-align:left; padding-left: 3.5%;">
                    <%= resourceManager.GlobalResourceSet.GetString("pkg_glbl_stng_desc")%>
                    
                </td>
            </tr>
        </table>
        
   <!--     <table id="errorMsgTable"  style="border-spacing:1px;border-collapse:separate;width:94%;margin:auto;
            border-width:0" visible="false">
            <tr id="lblMsg" runat="server">
                <td style="text-align:center;padding:5px" colspan="5">
                    <asp:Label ID="globalSettingsErrorMsg" runat="server" CssClass="errormsg" visible="false" />
                </td>
            </tr>
            <tr>
                <td style="text-align:center;padding:5px" colspan="5">
                    <input id="btnClose" runat="server" type="button" onclick="javascript:closeWindow();"
                        class="inputbutton" size="100" visible = "false"/>
                </td>
            </tr>
        </table>
     -->  
        <table style="width:45%; border-width:0;border-spacing:1px;padding-left: 6%;border-collapse:separate;"   class="tablebg" >
            <tr>
                <td class="lefttdbg" style="vertical-align:top;padding:2px;">
                    <span class="subtitle">
                        <%= resourceManager.GlobalResourceSet.GetString("pkg_glbl_frm_nme")%>
                    </span>
                </td>
                <td class="righttdbg" style="padding:2px">
                    <asp:Panel ID="pnlForm" Width="50%" runat="server">
                        <asp:TextBox ID="txtFormName" runat="server" CssClass="Inputtext" Visible="false"></asp:TextBox>                        
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td class="lefttdbg" style="vertical-align:top; width: 41%;padding:2px">
                    <span class="subtitle">
                        <%= resourceManager.GlobalResourceSet.GetString("pkg_glbl_frm_vrsn")%>
                    </span>
                </td>
                <td class="righttdbg" style="width: 50%;padding:2px">
                    <asp:Panel ID="pnlVersion" Width="50%" runat="server">
                    <asp:TextBox ID="txtFormVersion" runat="server" CssClass="Inputtext" Visible="false"></asp:TextBox>
                    </asp:Panel>                    
                </td>
            </tr>
        </table>
       <div style="bottom: 0px;position: absolute;right: 20px;">
                    <asp:Button ID="btnRemove" runat="server"  CssClass="inputsecondarybutton" OnClientClick="showMessageAndClose(pageTitle, 'Confirmation', removeMessage);"  OnClick="ButtonRemove_Click" />
           <input id="btnNext" runat="server" type="button" onserverclick="ButtonNext_Click" class="inputbutton"
                        size="100" />
                    <input id="btnUpdate" runat="server" type="button" onserverclick="ButtonUpdate_Click"
                        class="inputbutton" size="100" />
                    <%--<input id="btnRemove" runat="server" type="button" onserverclick="ButtonRemove_Click"
                        class="inputbutton" size="100" />--%>
                    <input id="btnCancel" runat="server" type="button" onclick="javascript:closeWindow();"
                        onserverclick="ButtonCancel_Click" class="inputbutton" visible=false  />
        </div>
    </div>
    </form>
</body>
</html>