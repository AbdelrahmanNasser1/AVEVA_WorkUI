<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Forms.Web.CodeBehind.CreateList.BPMUITemplates_Default_Repository_Site_CreateDListDesigner" EnableViewState="false" EnableEventValidation="false" %>

<%@ Register Assembly="Skelta.Forms.Web" Namespace="Skelta.Forms.Web" TagPrefix="cc1" %>
<%@ Register Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html>
<script type="text/javascript" language="javascript">
    function updateNewControl()
    {
        var scrollElement = document.getElementById("Rbodydiv");
        var scrollTopPosition = scrollElement.scrollTop;

        window.location.reload();

        setTimeout(function ()
        {
            var scrollElement = document.getElementById("Rbodydiv");
            scrollElement.scrollTop = scrollTopPosition;
        }, 500);
    }
    function CloseNRefresh()
    {
        try
        {
            if (_mode == "Edit")
                window.opener.RefreshGrid();
            else
                window.opener.parent.RefreshGrid();

            window.close();
        }
        catch (ex)
        {
            window.close();
        }
    }
    var radWindow = GetRadWindow();
    if (radWindow != null) {
        window.open(window.location.href, '', width = screen.availHeight, height = screen.availWidth);
        closeWin();
    }
    window.moveTo(0, 0);
    window.resizeTo(screen.availWidth, screen.availHeight);

    var _listParams;
    var _mode;
    var _formItemId;
    var _applicationName;
    var _listName;
    var _validationErrors;
    var _regenerateFormValue = "";
    var _frmVerType;

    function PromptForAutoRegenerateForm(listParams, mode, formItemId, applicationName, listName, validationErrors, fcMode)
    {
        se.ui.messageDialog.showConfirmation(document.title, "<%=EditAutoGeneratedForm_Prompt %>",
                                                function (yes)
                                                {
                                                    var editForm = "0";

                                                    if (yes)
                                                    {
                                                        editForm = "1";
                                                    }

                                                    CallBtnSaveListClick("1", editForm);
                                                });
    }


    function ShowListFormDesigner(listParams, mode, formItemId, applicationName, listName, frmVerType, validationErrors)
    {
        //UnloadPage(); // This is extra call, because once the window.opener got reloaded, the link between the top window and listdesigner will be broken, hence window.opener.RefreshGrid() will not work
        _listParams = listParams;
        _mode = mode;
        _formItemId = formItemId;
        _applicationName = applicationName;
        _listName = listName;
        _validationErrors = validationErrors;
        _frmVerType = frmVerType;

        if (mode == "Edit")
        {
            confirmCallBackFn("true");
        }
        else
        {
            try
            {
                setTimeout("window.opener.top.location.reload()", 750);
                //window.opener.top.location.reload();
            } catch (ex) { }
            url = "CreateDListFormEditConfirm.aspx";
            url = url + "?ApplicationName=" + applicationName;
            url = url + "&formItemId=" + _formItemId;
            url = url + "&listParams=" + _listParams;
            url = url + "&formEdit=" + mode;
            //var oWindow1 = window.open(url, "Validation Error", "location=1,status=1,scrollbars=1,width=400,height=100");
            //oWindow1.moveTo((screen.availWidth / 2) - 200, (screen.availHeight / 2) - 50);

            var oManager = GetRadWindowManager();
            var oWindow1 = oManager.getWindowByName("w1");
            oWindow1.setUrl(url);
            oWindow1.setSize(600, 175);

            //var oWindow1 = radopen(url, "w1");
            oWindow1.set_modal(true);

            //oWindow1.Center();
            //oWindow1.SetTitle("Form Edit - Confirmation");
            oWindow1.show();
            try
            {
                oWindow1.center();
            }
            catch (e)
            { }
        }

        if (window["Sys"] !== undefined && window["Sys"] !== null)
        {
            Sys.Application.remove_load(ShowListFormDesigner);
        }
    }

    // GetRadWindowManager does not reflect immediately when calling a method
    // from the Server side using ClientScript.RegisterStartupScript method, 
    // hence need to use below workaround
    function PerformInitialReponseScriptExecutionForRadWindowManager(callFn)
    {
        var windowManagerCheckFn = function ()
        {
            var radWindowMgr = GetRadWindowManager();
            if (radWindowMgr == undefined || radWindowMgr == null)
            {
                Sys.Application.remove_load(callFn);
                Sys.Application.add_load(callFn);
            }
            else
            {
                callFn();
            }
        };

        if (window["Sys"] == undefined || window["Sys"] == null)
        {
            setTimeout(function ()
            {
                windowManagerCheckFn();
            }, 0);
        }
        else
        {
            windowManagerCheckFn();
        }
    }

    function UnloadPage()
    {
        try
        {
            unlock();
            window.opener.RefreshGrid(); // this may work only direct designer 
        }
        catch (ex) { }
    }
    function getXMLHttpRequest()
    {
        if (window.XMLHttpRequest)
        {
            return new window.XMLHttpRequest;
        }
        else
        {
            try
            {
                return new ActiveXObject("MSXML2.XMLHTTP.3.0");
            }
            catch (ex)
            {
                return null;
            }
        }
    }

    function S4()
    {
        return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
    }
    function getguid()
    {
        return (S4() + S4() + "-" + S4() + "-" + S4() + "-" + S4() + "-" + S4() + S4() + S4());
    }
    function unlock()
    {
        var hidItemId = document.getElementById("hiditemid");
        var hidListId = document.getElementById("hidlistid");
        var hidunlock = document.getElementById("hidunlock");
        if (hidItemId != null)// consider unlock
        {
            var unlock;
            var itemid = hidItemId.value;
            var listid = hidListId.value;
            if (hidunlock == null)
            {
                unlock = "true";
            }
            else
            {
                unlock = hidunlock.value;
            }
            if (unlock == "true")
            {
                var tempId = getguid();
                var url = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(R.TemplateDirectory, false) %>Repository/Site/Unlock.aspx?listid=" + listid + "&itemid=" + itemid + "&tempid=" + tempId;
                if (navigator && navigator.sendBeacon) {
                    navigator.sendBeacon(url, null);
                }
                else {
                    var oReq = getXMLHttpRequest();
                    oReq.open("GET", url, false);
                    oReq.send(null);
                }                
            }
        }
    }
    function setunlockhidvalue()
    {
        document.getElementById("hidunlock").value = "false";
    }

    function ShowValidationErrorPage(ErrorFldNms, ErrorFldTyps, ErrorGrdCaps, ErrSmLvlTbls, TitleExists, UniqueFieldExists, strLookupErrors, ErrMpdXmls, strLookUpDisplayColErs)
    {
        //debugger;
        //alert(UniqueFieldExists);
        if (typeof (strLookUpDisplayColErs) == 'undefined') strLookUpDisplayColErs = "";
        url = "CreateDListErrorPage.aspx?Type=2";
        url = url + "&EFldNm=" + escape(ErrorFldNms);
        url = url + "&EFldTyp=" + escape(ErrorFldTyps);
        url = url + "&EGrdCap=" + escape(ErrorGrdCaps);
        url = url + "&ESmLvlTbls=" + escape(ErrSmLvlTbls);
        url = url + "&ETitle=" + TitleExists;
        url = url + "&EUniquefld=" + UniqueFieldExists;
        url = url + "&ELk=" + escape(strLookupErrors);
        url = url + "&EMpdXml=" + escape(ErrMpdXmls);
        url = url + "&EDLK=" + strLookUpDisplayColErs;

        var oWindow1 = radopen(url, null);
        oWindow1.set_modal(true);
        oWindow1.set_title("Validation Error");
        oWindow1.setSize(700, 500);
        oWindow1.center();

        //var oWindow1 = window.open(url, "Validation Error", "location=1,status=1,scrollbars=1,width=700,height=500");
        //oWindow1.moveTo((screen.availWidth / 2) - 350, (screen.availHeight / 2) - 250);
        ////var oManager2 = GetRadWindowManager();
        ////alert(oManager2);
        ////var oWindow2 = oManager2.getWindowByName("RadWindow1");
        ////alert(oWindow2);
        ////if (oWindow2 == null)
        ////{
        ////    oWindow2 = radopen(url, null);
        ////}
        ////oWindow2.SetTitle("Validation Error");
        ////oWindow2.SetSize(700, 500);
        ////oWindow2.SetModal(true);
        ////oWindow2.SetUrl(url);
        ////oWindow2.Show();
        ////oWindow2.Center();
    }

    function ShowListFormValidationPage(applicationName, listName)
    {
        url = "CreateDLFValidate.aspx";
        url = url + "?ApplicationName=" + applicationName;
        url = url + "&ListName=" + listName;
        url = url + "&ValidationType=OnListSave";

        var oWindow1 = radopen(url, "ListFormValidationPage");
        oWindow1.set_modal(true);
        oWindow1.set_title("Validation Error");
        oWindow1.setSize(700, 500);
        oWindow1.center();
    }
    function OnClientClose(radWindow)
    {
        if (radWindow.get_name() == "ListFormValidationPage")
            CloseNRefresh();//alert (radWindow.Name + " is being closed");
    }
    var IsForeignQueryChanged = "False";
    function UpdateLookupQueryStatus(val)
    {
        IsForeignQueryChanged = val;
    }

    function confirmCallBackFn(arg)
    {
        if (_mode == "Edit")
        {
            if (IsForeignQueryChanged == "True")
            {
                alert("<%=ForeignKeyError %>");
            }
        }
        var rslt = '';
        rslt = rslt + arg + '';
        if (_mode == "Edit")
        {
            if (rslt == "true")
                window.location = "EditDFormDesigner.aspx?ContextMenu=False&ValidationErrors=" + _validationErrors + "&listName=" + _listName + "&frmVerType=" + _frmVerType + "&" + _listParams;
            else
            {
                if (_validationErrors == "")
                    CloseNRefresh();
                else
                    ShowListFormValidationPage(_applicationName, _listName);
            }
        }
        else
        {
            CloseNRefresh();
        }
    }

    function CallBtnSaveListClick(isNGF, isEdit)
    {
        document.getElementById("hdnNGF_Edit").value = isNGF + '|||' + isEdit;
        document.getElementById("BtnSaveList").click();
    }

    function GetRadWindow() {
        var oWindow = null;
        if (window.radWindow)
            oWindow = window.radWindow;
        else if (window.frameElement!=null)
            oWindow = window.frameElement.radWindow;
        return oWindow;
    }

    function closeWin() {
        var oWindow = GetRadWindow();
        if (oWindow != null) {
            oWindow.close();
        }
    }
</script>
<html>
<head runat="server">
    <title>List Designer</title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
</head>
<body style="height: 100%; width: 100%; padding: 0; margin: 0; overflow: hidden;" onunload="UnloadPage();">
    <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%:commonCssPath%>CommonUXControls/StyleSheet/se.ui.min.css">
    <link rel="stylesheet" type="text/css" href="<%:commonCssPath%>TelerikAjax/StyleSheet/AWTInput/Input.AWTInput.css" />
    <link rel="stylesheet" type="text/css" href="<%:commonCssPath%>TelerikAjax/StyleSheet/AWTCalendar/Calendar.AWTCalendar.css">
    <link rel="stylesheet" type="text/css" href="<%:commonCssPath%>TelerikAjax/StyleSheet/AWTCalendar/Calendar.css">
    <link rel="stylesheet" type="text/css" href="<%:commonCssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css">
    <link rel="stylesheet" type="text/css" href="<%:commonCssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css">
    <link rel="stylesheet" type="text/css" href="<%:commonCssPath%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
    <link rel="stylesheet" type="text/css" href="<%:commonCssPath%>TelerikAjax/StyleSheet/AWTWindow/Window.css">
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

        function showMessage(message){
            se.ui.messageDialog.showError("<%=_ResManager.GlobalResourceSet.GetString("FormDynamicListEdit") %>", message, function () { window.close(); });
    }
    </script>
    <form id="form1" runat="server">
	    <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        <div>
            <asp:Panel ID="Panel1" runat="server">
                <cc1:FormRenderer ID="R" runat="server" InDesignMode="True" />
                 <telerik:RadWindowManager ID="RadWindowManager1" Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" runat="server"  
                        Behaviors="None" DestroyOnClose="true" Overlay="false" RenderMode="Classic" VisibleStatusbar="false" OnClientClose="OnClientClose" CenterIfModal="true" Modal="true">  
                    <Windows>
                        <telerik:RadWindow ID="w1" runat="server" Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" RenderMode="Classic">
                        </telerik:RadWindow> 
                        <telerik:RadWindow ID="RadWindow1" runat="server" Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" RenderMode="Classic">
                        </telerik:RadWindow>                                            
                    </Windows>
                </telerik:RadWindowManager>
            </asp:Panel>

        </div>

        <asp:Button runat="server" ID="BtnSaveList" Style="display: none"></asp:Button>
        <input type="hidden" runat="server" id="hdnNGF_Edit" />
        <asp:HiddenField ID="hiditemid" runat="server" Value="" />
        <asp:HiddenField ID="hidlistid" runat="server" Value="" />
        <asp:HiddenField ID="hidunlock" runat="server" Value="" />
    </form>
</body>
</html>
