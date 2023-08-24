<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Package.CodeBehind.DownloadPackageTemplate" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html>
<html>

<head>
    <title>
        <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
        <%= resManager.GlobalResourceSet.GetString("pkg_dwnld")%>
            </telerik:RadCodeBlock>
    </title>
    <script type="text/javascript" src="../Common/JavaScripts/jquery.min.js"></script>
    <script type="text/javascript" src="../Common/JavaScripts/AutoLogoff.js"></script>
    <script type="text/javascript" src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <script type="text/javascript" src="../Common/JavaScripts/spin.min.js"></script>
    <script type="text/javascript" src="../NextGenForms/js/knockout.min.js"></script>
    <script type="text/javascript" src="../NextGenForms/js/xml2json.min.js"></script>
    <script type="text/javascript" src="../NextGenForms/app/Skelta.min.js"></script>
    <script type="text/javascript" src="../NextGenForms/js/kendo.all.min.js"></script>
    <link rel="stylesheet" href="../NextGenForms/css/SkeltaForms.min.css" />

    <style type="text/css">
        .buttonMarging {
            margin-left: 5px;
            display: none;
        }
    </style>
</head>
<script type="text/javascript">
    var oWindow = null;
    function GetRadWindow()
    {
        oWindow = null;
        if (window.frameElement != null)
            oWindow = window.frameElement.radWindow;
        return oWindow;
    }

    function closeBellyWindow()
    {        
        var oWindow = GetRadWindow();
        window.parent.onclientCalled = false;
        window.parent.OnClientClose(oWindow);
        setTimeout(function () {
            oWindow.close();            
        }, 0);
        window.parent.onclientCalled = null;
    }

    function closeWin()
    {
        oWindow = GetRadWindow();
        setTimeout(function () {
            oWindow.close();            
        }, 0);
    }

    function CloseWindowImmediatly()
    {
        oWindow = GetRadWindow();
        setTimeout(function () {
            oWindow.close();            
        }, 0);
    }

    function CloseWindow()
    {
        oWindow = GetRadWindow();        
        setTimeout("RefreshDownloadStatus()", 2000);
    }    

    function RefreshDownloadStatus()
    {
        if (window != null && window.opener != null)
        {
            window.opener.RefreshGrid();
        }
        oWindow = GetRadWindow();
        setTimeout(function () {
            oWindow.close();            
        }, 0);
    }  

    // Initialize locales for message dialog
    se.ui.messageDialog.setGlobalOptions({
        localization: { // All localization related default can be set
            closeButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
            okButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
            cancelButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
            showDetailsCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
            hideDetailsCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
        }
    });

    function showMessageAndClose(messageType, message)
    {        
        $(document).ready(function ()
        {
            var pageTitle = '<%=resManager.GlobalResourceSet.GetString("pkg_dwnld") %>',
                self = window;
            var oWindow = GetRadWindow();
            
            switch (messageType)
            {
                case "Error":
                    se.ui.messageDialog.showError(pageTitle, message, closeHandlerFn);
                    if (oWindow != null)
                    {                        
                        setTimeout(function () {
                            oWindow.close();
							oWindow.hide();
                        }, 0);
                    }
                    break;
                case "Message":
                    se.ui.messageDialog.showAlert(pageTitle, message, closeHandlerFn);
                    if (oWindow != null)
                    {                       
                        setTimeout(function () {
                            oWindow.close();
							oWindow.hide();
                        }, 0);
                    }
                    break;
                case "DraftConfirmation":
                case "PublishConfirmation":
                    se.ui.messageDialog.showConfirmation(pageTitle,
                        message,
                        function (userResponse)
                        {
                            if (userResponse) {
                                document.getElementById("btnDownload").click();
                                window.setTimeout(closeHandlerFn, 2000);
                            }
                            else {
                                closeHandlerFn();
                            }
                        });         
                    break;
                case "GenerateConfirmation":                
                    se.ui.messageDialog.showConfirmation(pageTitle,
                        message,
                        function (userResponse)
                        {
                            if (userResponse)
                            {                                
                                if (oWindow != null)
                                {
                                    oWindow.setSize(820, 600);                                  
                                    oWindow.show();
                                    oWindow.center();
                                }                               
                                ShowProgress();                                   
                                document.getElementById("btnDownload").click();
                                window.setTimeout(closeHandlerFn, 2000);                                
                            }
                        });                   
                    break;
                case "DownloadConfirmation":
                    se.ui.messageDialog.showConfirmation(pageTitle,
                        message,
                        function (userResponse)
                        {
                            if (userResponse)
                            {                                
                                document.getElementById("btnDownload").click();								
                                window.setTimeout(closeHandlerFn, 2000);
								 if (oWindow != null)
                                {
								oWindow.hide();
								}
                            }
							else
							{
							 if (oWindow != null)
                                {
								oWindow.hide();
								}
							}
                        });                   
                    break;
                default:
                    // Only if it is a radWindow, show it
                    if (oWindow != null)
                    {
                        oWindow.show();
                    }
                    break;
            }

            function closeHandlerFn()
            {
                self.closeBellyWindow(false);
            }
        });
    }

    function OpenDownloadWindow(path)
    {       
        CloseWindowImmediatly();
        var oBrowserWnd = GetRadWindow().BrowserWindow;        
        var radWindow = oBrowserWnd.radopen(path, "NewWindow");
        if (radWindow != null)
        {
            if (radWindow.isClosed() == false) {
                radWindow.setSize(820, 600);
                radWindow.show();
                radWindow.center();
            }
        }
    }

    function closeHandlerFnRefresh()
    {
        window.setTimeout(self.closeBellyWindow(false), 2000);
    }

    function ShowProgress()
    {       
        var spinnerObj = new Spinner().spin();
        spinnerObj.el.style.top = "50%";
        spinnerObj.el.style.left = "50%";
        $("#skloader")[0].appendChild(spinnerObj.el);
        $('#skloader').attr("data-skloader", "1");
    }

</script>
<body id="Body" style="margin: 0; left: 0; overflow: auto; height: 100%" >
    <div id="skloader" class="skloader" data-skloader="0" style="height: 100%; width: 100%; position: absolute;"></div>    
    <form id="Form1" method="post" runat="server">
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        <telerik:RadCodeBlock ID="RadCodeBlock5" runat="server">
            <%=System.Web.Helpers.AntiForgery.GetHtml()%>
            <script>
                function HideProgress() {
                    setTimeout(function () {
                        $('#skloader').attr("data-skloader", "0");
                    }, 0);

                }
            </script>

            <link href="<%:themePath%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
            <link rel="stylesheet" type="text/css" href="<%=themePath%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css" />
        </telerik:RadCodeBlock>
        <table id="publishMessageTable" style="border-spacing: 0px; border-width: 0; margin: auto"; width:"100%; ">
            <tr>
                <td style="height: 5px; padding: 5px" colspan="5"></td>
            </tr>
            <tr>
                <td style="text-align: center; padding-top: 8.5%;" colspan="2">
                    <asp:Label ID="downloadMessage" runat="server" CssClass="successfulmsg"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="bottom: 17px; right: 15px; position: absolute;">
                    <input id="btnClose" runat="server" type="button" onclick="javascript: closeWin();" class="inputbutton" style="display: none;" />
                    <asp:Button ID="btnDownload" runat="server" UseSubmitBehavior="false" OnClick="ButtonDownload_Click" CssClass="inputbutton buttonMarging"/>
                </td>
            </tr>
        </table>
        <telerik:RadWindowManager ID="RadWindowManager1" Skin="AWTWindow" EnableEmbeddedSkins="false" Behaviors="Close" runat="server">
            <Windows>
                <telerik:RadWindow ID="NewWindow" RenderMode="Lightweight" runat="server"></telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>
    </form>
</body>
</html>
