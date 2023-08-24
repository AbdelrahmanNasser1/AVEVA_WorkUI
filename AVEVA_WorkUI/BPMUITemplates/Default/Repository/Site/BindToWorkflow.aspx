<%@ Page Language="C#" AutoEventWireup="true" Inherits="BindToWorkflow" Debug="true"
    EnableEventValidation="true" EnableViewStateMac="true" ValidateRequest="true" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE html>
<html style="height:100%">
<head runat="server">
    <script language="JavaScript">
        function alertUser(errorMsg, okMsg, uri)
        {
            se.ui.messageDialog.showConfirmation(document.title, errorMsg, function (val)
            {
                if(val)
                {
                    window.location.href = "FormXmlMapping.htm?" + uri;
                    //document.getElementById("ButtonHidden").click();
                }
            });
        }

        function alertOverride(errorMsg, okMsg) {
            se.ui.messageDialog.showConfirmation(document.title, errorMsg, function (val) {
                if (val) {
                    document.getElementById("ButtonHidden").click();
                }
            });
        }

        function alertNoMappingValidation(errorMsg, okMsg) {
            se.ui.messageDialog.showAlert(document.title, errorMsg);
        }

        function alertMessage(msg) {
            se.ui.messageDialog.showAlert(document.title, msg);
        }

        function alertMapping(errorMsg, okMsg, uri)
        {
            se.ui.messageDialog.showConfirmation(document.title, errorMsg, function (val)
            {
                if(val)
                {
                    window.location.href = "FormXmlMapping.htm?" + uri;
                }
            });
        }
        // #Mallikarjun#
        //Check if this page opens from Rad window then don't resize
        if (typeof (window.opener) != 'undefined')
        {
            var sw = window.screen.width;
            var sh = window.screen.height;
            window.resizeTo(sw * .70, sh * .60);
            window.moveTo(sw * .19, sh * .20);


        }

        function GetRadWindow()
        {
            var oWindow = null;
            if (window.radWindow)
                oWindow = window.radWindow;
            else if (window.frameElement.radWindow)
                oWindow = window.frameElement.radWindow;
            return oWindow;
        }
    </script>
    <title>
        <%=resManager.GlobalResourceSet.GetString("FormBindToWorkflowPageTitle") %></title>
    <style type="text/css">
        .hiddenControl
        {
            display: none;
        }
    </style>
</head>
<body style="width: 100%;height:100%; font-size: 9px; border: none; margin: 0px 0px 0px 0px;overflow:hidden;
    padding: none;" onload="javascript:CheckSelection();LocalizeButonText();" >
    <form id="form1" runat="server" style="height:100%"><link href="<%=cssPath%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
	<%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
       
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
          <link href="<%=cssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css" rel="stylesheet" type="text/css" />
         <link href="<%=cssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="<%=cssPath%>CommonUXControls/StyleSheet/se.ui.min.css" />  
        <script>
        se.ui.messageDialog.setGlobalOptions({
            localization: {
                closeButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                okButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
                cancelButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                showDetailsCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                hideDetailsCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
            }
        });
    </script>
    <div style="height:100%">
        <asp:HiddenField ID="RadioIndex" runat="server" />
        <table style="width:100%;border-spacing:1px;border-width:0;height:100%" >
            <tr style="height:10%">
                <td style="vertical-align:top;text-align:left;width:100%;padding:5px">
                    <span class="pagetitle">
                        <%=resManager.GlobalResourceSet.GetString("FormBindToWorkflowTitle") %></span><br />
                    <asp:Label ID="Label1" runat="server" Text="Bind the Skelta form to a Skelta workflow"
                        CssClass="description"></asp:Label>
                </td>
            </tr>
            <tr style="height: 90%">
                <td style="width:100%;vertical-align:top">
                    <table style="width:100%;border-width:0;border-spacing:1px"   class="tablebg">
                        <tr style="vertical-align:top">
                            <td style="width:40%;padding:8px" class="lefttdbg">
                                <span class="subtitle">
                                    <%=resManager.GlobalResourceSet.GetString("FormBindToWorkflowChooseTask")%></span><br />
                                <span class="description">
                                    <%=resManager.GlobalResourceSet.GetString("FormBindToWorkflowChooseTaskDesc")%></span>
                            </td>
                            <td style="width:60%;text-align:left;vertical-align:top" class="righttdbg">
                                <table style="width:100%;border-width:0"  >
                                    <tr>
                                        <td style="vertical-align:middle; width:30%;padding:6px">
                                            <asp:RadioButtonList ID="RadioButtonList1" AutoPostBack="true" runat="server" OnTextChanged="RadioButtonList1_SelectedIndexChanged"
                                                CssClass="inputradio" Width="350px">                                                
                                            </asp:RadioButtonList>
                                        </td>
                                        <td style="vertical-align:top;padding:6px">
                                            <table style=" width:100%;">
                                                <tr>
                                                    <td style="padding:3px">
                                                        <asp:Panel ID="Panel1" runat="server" Height="100%" Width="50%">
                                                        </asp:Panel>
                                                    </td>
                                                    <td>
                                                        <asp:Panel ID="Panel2" runat="server" Height="100%" Width="60%">
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr style="vertical-align:top">
                            <td style="width:40%;padding:8px" class="lefttdbg">
                                <span class="subtitle">
                                    <%=resManager.GlobalResourceSet.GetString("FormExecute")%></span><br />
                                <span class="description">
                                    <%=resManager.GlobalResourceSet.GetString("FormExecuteDesc")%></span>
                            </td>
                            <td style="width:60%;text-align:left;vertical-align:top" class="righttdbg">
                                <table style="width:100%;border-width:0"  >
                                    <tr>
                                        <td style="vertical-align:middle; width:30%;padding:6px" class="inputcheckbox">
                                <input type="checkbox" runat="server" id="SyncCheck" class="inputcheckbox" />
                                    <%=resManager.GlobalResourceSet.GetString("FormExecuteSynchronous")%>
                                             </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label2" runat="server" CssClass="successfulmsg" Style="z-index: 100;"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="text-align:right;width:100%">
                    <table style="width:100%" >
                        <tr>
                            <td style="text-align:right; margin-right:5px;">
                                <span id="buttonWrapper">
                                <asp:Button ID="ButtonHidden" runat="server" Height="0px" Width="0px" OnClick="ButtonHidden_Click"
                                        Text="" style="visibility:hidden" />
                                 <input type="button" id="Button2" name="Button2" value="Close" onclick="javascript: CloseWindowBound();"
                                    class="inputsecondarybutton" style="margin-right:10px;"/>   
                                </span>
                                <asp:Button ID="Button1" runat="server" CssClass="inputbutton" OnClick="Button1_Click"
                                        Text="Next" />
                            </td>
                            <td>
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
<script type="text/javascript" language="javascript">
    function CheckSelection()
    {
        var radioId = document.getElementById('RadioButtonList1');

        if (document.getElementById(radioId.id + "_" + 2).checked)
        {
            document.getElementById("Button1").style.display = 'none';
            document.getElementById('Button2').value = '<%=resManager.GlobalResourceSet.GetString("FormFinishButtonText")%>';
        }
    }

    function LocalizeButonText()
    {
        var hfradio = document.getElementById('RadioIndex');

        if (hfradio.value == "0")
        {
            //document.getElementById('Button1').value = '<%=resManager.GlobalResourceSet.GetString("FormSaveButtonText")%>';
            document.getElementById('Button2').value = '<%=resManager.GlobalResourceSet.GetString("FormCloseButtonText")%>';
        }
        else if (hfradio.value == "1")
        {
            //document.getElementById('Button1').value = '<%=resManager.GlobalResourceSet.GetString("FormNextButtonText")%>';
            document.getElementById('Button2').value = '<%=resManager.GlobalResourceSet.GetString("FormCloseButtonText")%>';
        }
        else
        {
            document.getElementById('Button2').value = '<%=resManager.GlobalResourceSet.GetString("FormFinishButtonText")%>';
        }
    }

    function CloseWindowBound()
    {
        try
        {
            window.opener.window.closeWin();
            var oWnd = GetRadWindow();
            oWnd.close();

        }

        catch (err)
        {
            try
            {
                var oWnd = GetRadWindow();
                oWnd.close();
            }
            catch (err2)
            {
                window.close();
            }
        }

        // Refresh Parent Grid
        try
        {
            var oWin = window.opener.GetRadWindow();
            oWin.BrowserWindow.window.document.getElementById('mainframe').contentWindow.document.getElementById("gridframe").contentWindow.RefreshGrid();
        }
        catch (err)
        {
        }
    }
</script>
