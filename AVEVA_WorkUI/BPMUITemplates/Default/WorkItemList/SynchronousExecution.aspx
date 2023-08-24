<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.HWS.WorkListChannel.Web.WorkItemUIControl.SynchronousASPXCodeBehind"
    Theme="" StylesheetTheme="" %>

<html>
<head runat="server">
    <title>Untitled Page</title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <input type="hidden" name="hidSynchData" value="<%=strUrl%>" />
    </form>
</body>

<script type="text/javascript">
    //debugger;
    var url = document.forms[0].hidSynchData.value;
    var err = "<%=errorMessage%>"
    if (err != "") {
        alert(err);
    }
    else {
        var Urls = url;
        if (Urls == "{}" || Urls == "") {
            alert("No access rights to view the detailed page.");
        }
        else {
            var UrlsJs;
            eval("UrlJs=" + Urls);

            var urldetails = UrlJs[UrlJs._DefaultFormName];
            var openInFrame = UrlJs["openInIframe"];
            var urlDetailsJs;
            eval("urlDetailsJs=" + urldetails);
            if (openInFrame)
            {
                urlDetailsJs.url = urlDetailsJs.url + "&openInIframe=" + openInFrame;
            }
            OpenUrl(urlDetailsJs)
        }
    }
    function OpenUrl(ourl)
    {
        var isFunction = false;
        var jsfunc = null;
        if (ourl.jsfunction && ourl.jsfunction != "") {
            jsfunc = eval(ourl.jsfunction);
            if (!jsfunc) {
                alert("No function found with name " + ourl.jsfunction);
                return;
            }
            else {
                isFunction = true;
            }
        }

        if (ourl.nonweb) {
            if (isFunction) {
                jsfunc(false, ourl.url, ourl.popf, ourl.popn, ourl.nonweb);
            }
            else {
                OpenWorkItemInHiddenIframe(ourl.url);
            }

        }
        else {

            if (ourl.pop) {

                if (isFunction) {
                    jsfunc(true, ourl.url, ourl.popf, ourl.popn, ourl.nonweb);
                }
                else {
                    OpenWorkItemInWindow(ourl.url, ourl.popn, ourl.popf);
                }

            }
            else {

                if (isFunction) {
                    jsfunc(false, ourl.url, ourl.popf, ourl.popn, ourl.nonweb);
                }
                else {
                    OpenWorkItemInPreviewPane(ourl.url);
                }
            }
        }
    }

    function NativeFormOpen(openInPopup, url, popupFeatures, popupName, isNonWeb) {
        if (self.opener) {
            try {

                self.opener.RefreshGridfromdetwindow();
            }
            catch (err)
        { }
            //window.close();
        }
        else {
            try {
                top.opener.RefreshGridfromdetwindow();
                var dvCnt = top.document.getElementById("divDocView");
                dvCnt.style.display = "block";
            }
            catch (err)
           { }
        }

        if (!openInPopup) {
            window.setTimeout(function() { OpenWorkItemInPreviewPane("WorkItemDetailView.aspx" + url); }, 1500);
        }
        else {

            self.setTimeout('winClose()', 1500)
            OpenWorkItemInWindow("WorkItemDetailView.aspx" + url, popupName, popupFeatures);
        }
    }
    function winClose() {
        top.window.close();
    }

    function OpenWorkItemInWindowForInvokeForm(url, popupName, popupFeatures) {
        var left = (screen.width / 2) - (710 / 2);
        var top = (screen.height / 2) - (500 / 2);
        mywindow = window.open((url), (popupName && popupName != "") ? popupName : "WinWorkItemFields", (popupFeatures && popupFeatures != "") ? popupFeatures : "location=0, status=0, scrollbars=0, width=710, height=500,resizable=yes,top=" + top + ", left=" + left + "");
        //mywindow.moveTo(0,0);
        return mywindow;
    }

    function OpenWorkflowItemInvokeForm(openInPopup, url, popupFeatures, popupName, isNonWeb) {
        var aspxPage = "ChooseInvokeForm.aspx";

        var currentOpenerWindow = window.parent.opener;
        
        if (typeof (window.parent.opener) != 'undefined') {
            try {
                window.parent.opener.RefreshGridfromdetwindow();
            }
            catch (err) {
                //alert(err);
            }
        }

        if (document.referrer.indexOf('FormView.aspx') > 0) {
            aspxPage = "FormView.aspx";

            try {

                self.setTimeout('winClose()', 1500)
            }
            catch (err) {
                window.close();
            }
            
            var openerWindow = OpenWorkItemInWindowForInvokeForm("ChooseInvokeForm.aspx" + url, popupName, popupFeatures);
            openerWindow.opener = currentOpenerWindow;
        }
        else {
            if (!openInPopup)
                OpenWorkItemInPreviewPane(aspxPage + url);
            else
                OpenWorkItemInWindow(aspxPage + url, popupName, popupFeatures);
        }
    }


    function OpenWorkItemInWindow(url, popupName, popupFeatures) {
        var left = (screen.width / 2) - (703 / 2);
        var top = (screen.height / 2) - (300 / 2);
        mywindow = window.open((url), (popupName && popupName != "") ? popupName : "WinWorkItemFields", (popupFeatures && popupFeatures != "") ? popupFeatures : "location=0, status=0, scrollbars=0, width=703, height=300, resizable=yes,top=" + top + ", left=" + left + "");
        mywindow.moveTo(0, 0);
        return false;
    }

    function OpenWorkItemInPreviewPane(url) {
        if (typeof (parent.document.getElementById("divDocView")) != 'undefined') {
            if (parent.document.getElementById("divDocView") != null) {
                parent.document.getElementById("divDocView").style.visibility = 'visible';
            }
        }
        location.href = url;
    }



</script>

</html>
