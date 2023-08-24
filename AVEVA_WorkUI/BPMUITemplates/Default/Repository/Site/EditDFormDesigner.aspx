<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Forms.Web.CodeBehind.CreateList.BPMUITemplates_Default_Repository_Site_EditDFormDesigner" EnableEventValidation="false" EnableViewState="false" %>

<%@ Register Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <telerik:RadCodeBlock runat="server" ID="RadCodeBlock1">
        <title><%=pageTitle %></title>
    </telerik:RadCodeBlock>
    <meta http-equiv="content-type" content="Type=text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
</head>
<body onload="ShowListFormDesigner();">
    <telerik:RadCodeBlock runat="server" ID="RadCodeBlock2">
        <script src="<%=JSPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
        <link href="<%=ThemePath%>CommonUXControls/StyleSheet/se.ui.min.css"  rel="stylesheet" type="text/css" /> 
        <link rel="stylesheet" type="text/css" href="<%:ThemePath%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
        <link rel="stylesheet" type="text/css" href="<%:ThemePath%>TelerikAjax/StyleSheet/AWTWindow/Window.css">
        <script>
            se.ui.messageDialog.setGlobalOptions({
                localization: {
                    closeButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                    okButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
                    cancelButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                    showDetailsCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                    hideDetailsCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
                }
            });

            function DisplayErrorMessage(strMessage, postMessageFn) {
                var strHdrMsg = '<%=_ResManager.GlobalResourceSet.GetString("Regenerate_List_Form_Title")%>';
                se.ui.messageDialog.showAlert(strHdrMsg, strMessage, postMessageFn);
             }
        </script>
    </telerik:RadCodeBlock>
    <form id="form1" runat="server">
        <telerik:RadCodeBlock runat="server" ID="RadCodeBlock3">
            <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        </telerik:RadCodeBlock>
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        <div>
            <telerik:RadWindowManager Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" RenderMode="Classic" 
                Behaviors="None" ID="RadWindowManager1" runat="server" OnClientClose="onClientClose" VisibleStatusbar="false">
            </telerik:RadWindowManager>
        </div>
        <asp:Button runat="server" ID="Button1" OnClick="Button1_Click" Style="display: none;" />
    </form>
    <telerik:RadCodeBlock runat="server" ID="RadCodeBlock4">
        <script type="text/javascript">
            var _regenerateFormValue = "";
            //var __validationErrors="";
            var _validationErrors = "<%=_validationErrors%>";
            var _repositoryName = "<%=_repositoryName%>";
            var _listName = "<%=_listName%>";
            var _IsListCreated = "<%=_IsListCreated%>";
            var _listNotCreatedMsg="<%=_listNotCreatedMsg%>";

            function GetRadWindow() {
                var oWindow = null;
                oWindow = window.frameElement.radWindow;
                return oWindow;
            }

            function callBack() {
                document.getElementById("Button1").click();
            }

            function onClientClose(sender, args)
            {
                if (args && args.get_argument())
                {
                    getRegenerateValue(null, args.get_argument());
                }
            }

            function ShowListFormDesigner()
            {
                if (_IsListCreated == 'No')
                {
                    se.ui.messageDialog.showError('<%=_ResManager.GlobalResourceSet.GetString("Regenerate_List_Form_Title")%>', _listNotCreatedMsg, function () {
                        window.close();
                        return false;
                    }
            
                    );
        
                   // return false;
                }

                url = "EditListRegenerateForm.aspx";
                var queryString = window.location.href.substring((window.location.href.indexOf('?') + 1));
                var array1 = queryString.split('&'); // Each array element is in format "fieldname=value"
                for (var i = 0; i < array1.length; i++) {
                    var tempArray = array1[i].split('='); // Separate fieldname and value

                    if ((tempArray[0] == "ContextMenu") && (tempArray[1] == "False"))
                        url = "EditListRegenerateForm.aspx?ContextMenu=False";
                }

                var oWindow1 = radopen(url, "ListFormDesigner");
                oWindow1.set_modal(true);
                oWindow1.setSize(665, 220);
                oWindow1.center();
                return false;
            }

            function getRegenerateValue(radWindow, returnRegenerateFormValue) {
                _regenerateFormValue = returnRegenerateFormValue;

                if (_regenerateFormValue == "ReGenerateFormTrue") {
                    callBack();
                }
                else
                    if (_regenerateFormValue == "ReGenerateFormFalse") {
                        if (_validationErrors != "")
                        {
                            ShowListFormValidationPage(_repositoryName, _listName);
                        }
                        else
                        {
                            if (window.opener.CloseNRefresh)
                            {
                                window.opener.CloseNRefresh();
                            }
                            else
                            {
                                window.opener.RefreshGrid();
                            }
                            
                            window.close();
                        }
                    }
            }

            function ShowListFormValidationPage(applicationName, listName) {
                url = "CreateDLFValidate.aspx";
                url = url + "?ApplicationName=" + applicationName;
                url = url + "&ListName=" + listName;
                url = url + "&ValidationType=OnListSave";

                //alert(url);

                var oWindow1 = radopen(url, "ListFormValidationPage");
                oWindow1.set_modal(true);
                oWindow1.set_title("Validation Error");
                oWindow1.setSize(700, 500);
                oWindow1.center();
            }
        </script>
    </telerik:RadCodeBlock>
</body>
</html>
