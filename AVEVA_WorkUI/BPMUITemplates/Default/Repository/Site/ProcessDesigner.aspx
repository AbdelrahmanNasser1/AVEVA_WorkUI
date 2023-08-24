<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.Site_ProcessDesigner" %>

<%@ Register Assembly="Workflow.NET.Web.Designer.NET2" Namespace="Workflow.NET.Web.Designer"
    TagPrefix="cc1" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE html>
<html>
<head runat="server">
   
    <title><%=processDesignerType%> - <%:workflowName%> </title>
   
    <script type="text/javascript">
        function RefreshParent() {            
            try {                
                unlock();
                if (window.parent.opener.parent.location.pathname.indexOf("WFAssociate.aspx") != -1) {
                    var frameWindow = window.parent.opener.window.frameElement.radWindow;
                    if (frameWindow != null) {
                        frameWindow.close();
                    }
                }
                
                if (window.opener.frameElement != null)
                {
                    if (window.opener.location.pathname.indexOf("WorkflowTasks.aspx") != -1)
                    {
                        
                        var frameWindow1 = window.opener.frameElement.radWindow;
                        if (frameWindow1 != null)
                        {
                            frameWindow1.close();
                        }

                    }                    
                }                
                //window.opener.GetRadWindow().BrowserWindow.location.href = window.opener.GetRadWindow().BrowserWindow.location.href;
                if (!(window.opener.parent.document.getElementById('gridframe') == undefined || window.opener.parent.document.getElementById('gridframe') == null))
                    window.opener.parent.document.getElementById('gridframe').contentWindow.RefreshGrid();
                else
                {
                    if (window.opener.location.pathname.indexOf("WorkflowTasks.aspx") < 0) {
                        window.opener.GetRadWindow().BrowserWindow.window.document.getElementById('mainframe').contentWindow.document.getElementById("gridframe").contentWindow.RefreshGrid();
                    }
                }
            }
            catch (e) {
            }
        }

        function setunlockhidvalue() {
            document.getElementById("hidunlock").value = "false";
        }
    </script>
    <script type="text/javascript">
        //try {
        //    window.moveTo(0, 0);
        //    window.resizeTo(screen.availWidth, screen.availHeight);
        //} catch (err) {

        //}
    </script>
</head>

<body onunload="RefreshParent()" rightmargin="0" bottommargin="0" topmargin="0" leftmargin="0" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; Border-style: none; PADDING-TOP: 0px;overflow:hidden;height:100%;">
<script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
<script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
<script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=cssPath %>CommonUXControls/StyleSheet/se.ui.min.css" />      
<script>
    // Initialize locales for message dialog
    se.ui.messageDialog.setGlobalOptions({
        localization: { // All localization related default can be set
            closeButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
            okButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
            cancelButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
            showDetailsCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
            hideDetailsCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
        }
    });

    function showMessage(message) {
        se.ui.messageDialog.showError("<%=_ResManager.GlobalResourceSet.GetString("ecm_list_cm_designworkflow") %>", message.replace("!", "'").replace("!", "'"), function () { window.close(); });
    }
    </script>
    <form id="form1" runat="server">
<%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
        <asp:Panel ID="Panel1" runat="server" BorderWidth="0">
        </asp:Panel>

        <asp:HiddenField ID="hiditemid" runat="server" Value="" />
        <asp:HiddenField ID="hidlistid" runat="server" Value="" />
        <asp:HiddenField ID="hidunlock" runat="server" Value="" />
    </form>
</body>
</html>
<script type="text/javascript">
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
    function unlock() {
        var hidItemId = document.getElementById("hiditemid");
        var hidListId = document.getElementById("hidlistid");
        var hidunlock = document.getElementById("hidunlock");
        if (hidItemId != null)// consider unlock
        {
            var unlock;
            var itemid = hidItemId.value;
            var listid = hidListId.value;
            if (hidunlock == null) {
                unlock = "true";
            }
            else {
                unlock = hidunlock.value;

            }
           
            if (unlock == "true") {                
                var tempId = getguid();
                var url = "Unlock.aspx?listid=" + listid + "&itemid=" + itemid + "&tempid=" + tempId;                
                if (navigator && navigator.sendBeacon) {
                    navigator.sendBeacon(url, null);
                }
                else
                {
                    var oReq = getXMLHttpRequest();
                    oReq.open("GET", url, false);
                    oReq.send(null);
                }                
            }
        }
    }
</script>
