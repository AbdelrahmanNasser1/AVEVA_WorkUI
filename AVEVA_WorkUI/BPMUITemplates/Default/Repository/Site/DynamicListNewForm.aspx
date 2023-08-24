<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Forms.Web.CodeBehind.CreateList.BPMUITemplates_Default_Repository_Site_DynamicListNewForm"
    EnableEventValidation="false" EnableViewState="false" %>

<%@ Register Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>
        <%:LocalizedPageOpenModeCaption%>
        <%:formtitle%>       

    </title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <style type="text/css">

        html, body
        {
            height: 98%;
            overflow-y:hidden;
            
        }
    </style>

</head>
<body >
    <link rel="stylesheet" type="text/css" href="<%:commonCssPath%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
    <link rel="stylesheet" type="text/css" href="<%:commonCssPath%>TelerikAjax/StyleSheet/AWTWindow/Window.css">
    <form id="form1" runat="server" style="height:99%;">
    <%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <div style="overflow: hidden;height:100%;padding-top:2px;">
        <asp:Panel ID="panel1" runat="server">
        </asp:Panel>
       <asp:HiddenField ID="hiditemid" runat="server" Value="" />
        <asp:HiddenField ID="hidlistid" runat="server" Value="" />
        <asp:HiddenField ID="hidunlock" runat="server" Value="" />
    </div>
    <telerik:RadWindowManager  Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" 
        Behaviors="Close,Move" ID="RadWindowManager1" runat="server" RenderMode="Classic" VisibleStatusbar="false" DestroyOnClose="true">
    </telerik:RadWindowManager>
    </form>
</body>
</html>

<script language="javascript" type="text/javascript" src="../../SkeltaForms/javascript/SkeltaForms.js"></script>
<script language="javascript">
    function CloseNRefresh() {
        var oWindow = GetRadWindow();
        if (oWindow != null) {
            try {
                parent.document.getElementById("mainframe").contentWindow.document.getElementById("gridframe").contentWindow.RefreshGrid();
            }
            catch (err) { }
            oWindow.hide();
        }
        else {
            window.opener.location.reload();
            window.close();
        }
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

    function ShowErrorMessage(Message) {
        //radalert(Message, 500, 210, "List Error Alert");
        alert(Message);
    }

    function UpdateLookupControlValue(controlvalue, ajaxid, controlId, isdropdown, recordId) {


        var serverVariables = "UpdateLookupControlValue!@!" + controlId + "!@!" + controlvalue + "!@!" + recordId;
        try {
            if (isdropdown == '') {
                var ajId = window.opener.opener._skidmap[ajaxid];
                window.opener.opener.window[ajId].AjaxRequest(serverVariables);
                window.opener.close();
                window.close();
            }
            else {
                var ajId = window.opener._skidmap[ajaxid];
                window.opener.window[ajId].AjaxRequest(serverVariables);
                window.close();
            }
        }
        catch (err) {
            window.close();
        }
    }

    function getXMLHttpRequest() {
        if (window.XMLHttpRequest) {
            return new window.XMLHttpRequest;
        }
        else {
            try {
                return new ActiveXObject("MSXML2.XMLHTTP.3.0");
            }
            catch (ex) {
                return null;
            }
        }
    }

    function S4() {
        return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
    }
    function getguid() {
        return (S4() + S4() + "-" + S4() + "-" + S4() + "-" + S4() + "-" + S4() + S4() + S4());
    }
    function UnlockAndRefresh() {
        try {
            // this function will get on every close of the radwindow.. this is leveraged for unlock. if the hidfield exist with unlock flag then unlock else ignore unlock and do grid refresh
            var hidItemId = document.getElementById("hiditemid");
            var hidListId = document.getElementById("hidlistid");
            var hidunlock = document.getElementById("hidunlock");

            if (hidItemId == null)// dont consider unlock
            {
                // if hid field no need to refresh.. keep it the same..
            }
            else {
                var unlock;
                if (hidItemId != null)// consider unlock
                {
                    var unlock;
                    var itemid = hidItemId.value;
                    var listid = hidListId.value;
                    if (hidunlock == null || hidunlock == "") {
                        unlock = "true";
                    }
                    else {
                        unlock = hidunlock.value;
                        if (unlock == "") {
                            unlock = "true";
                        }
                    }
                    if (unlock == "true") {
                        var tempId = getguid();
                        var url = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(TemplateDirectory, false) %>Repository/Site/Unlock.aspx?listid=" + listid + "&itemid=" + itemid + "&tempid=" + tempId;
                        if (navigator && navigator.sendBeacon) {
                            navigator.sendBeacon(url, null);
                        }
                        else {
                            var oReq = getXMLHttpRequest();
                            oReq.open("GET", url, false);
                            oReq.send(null);
                        }
                        //var winpop = window.open(url, "unlock", "left=2000,top=2000,width=1,height=1");

                        parent.document.getElementById("mainframe").contentWindow.document.getElementById("gridframe").contentWindow.RefreshGrid();
                    }
                }
            }
        }
        catch (e) {
        }
    }
    
  
</script>


