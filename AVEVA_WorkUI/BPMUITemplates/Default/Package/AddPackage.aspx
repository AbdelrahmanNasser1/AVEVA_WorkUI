<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Package.CodeBehind.AddPackage" %>

<%@ Register Assembly="Skelta.Forms.Web" Namespace="Skelta.Forms.Web" TagPrefix="cc1" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE html>
<html style="height:100%">
<head runat="server">
    <title>
        <%= resourceManager.GlobalResourceSet.GetString("pkg_upld")%>
    </title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <style type="text/css">
        .style1
        {
            width: 869px;
        }
        #tblPackagefile
        {
            height: 60px;
            width: 96%;
        }
        .inputs
        {
            font-family: "Segoe UI" , "Verdana";
            font-size: 12px;
            background-color: #FFFFFF;
            border: 1px solid #ccc;
            width: 20px;
            color: #333333;
        }
        .buttonMarging {
           margin-right:5px;
       }
        .textAreaMargin {
              margin-top: 15px;
        }
    </style>
    <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
</head>
<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
    <script type="text/javascript">

     function GetRadWindow() {
         var oWindow = null;
         if (window.frameElement != null)
             oWindow = window.frameElement.radWindow;
         return oWindow;
     }

        function closeBellyWindow() {
         var oWindow = GetRadWindow();
         window.parent.onclientCalled = false;
         window.parent.OnClientClose(oWindow);
         oWindow.close();
         window.parent.onclientCalled = null;
     }

     // Initialize locales for message dialog
     se.ui.messageDialog.setGlobalOptions({
         localization: { // All localization related default can be set
             closeButtonCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                   okButtonCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                   cancelButtonCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                   showDetailsCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                   hideDetailsCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
               }
           });

     function showMessageAndClose(messageType, message, isCloseRequired)
     {
         var pageTitle = '<%=resourceManager.GlobalResourceSet.GetString("pkg_upld") %>',
             self = window;
         var oWindow = GetRadWindow();
         switch (messageType)
         {
             case "Error":
                 if (isCloseRequired === "False")
                 {
                     se.ui.messageDialog.showError(pageTitle, message);                    
                 }
                 else 
                 {
                      se.ui.messageDialog.showError(pageTitle, message, closeHandlerFn);
                 }
                 break;
             case "Message":
                 se.ui.messageDialog.showAlert(pageTitle, message, closeHandlerFn);
                 break;
             default:
                 break;
         }
     }
     
     function closeHandlerFn()
     {
         self.closeBellyWindow(false);
     }  

     function importButtonEnableDisable(disable) {
         var installButton = document.getElementById('btnAddPackage');
         installButton.disabled = disable;
     }
    </script>
</telerik:RadCodeBlock>
<body style="padding-right: 0px; overflow: hidden; height: 93%; padding-left: 0px; padding-bottom: 0px; margin: 0px; border-style: none; padding-top: 0px" onload="resizeWindow()">
    <form id="Form2" method="post" runat="server" style="height: 100%">
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        <telerik:RadCodeBlock ID="RadCodeBlock6" runat="server">
            <%=System.Web.Helpers.AntiForgery.GetHtml()%>
            <link href="<%=themeURL%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
            <link href="<%=themeURL%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
            <link rel="stylesheet" type="text/css" href="<%=themeURL%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css" />
        </telerik:RadCodeBlock>
        <div style="height: 100%;">
            <input type="hidden" name="hidconfirmField" id="hidconfirmField" value="" />
            <table id="pageHeaderTable" style="width: 92%; padding-top: 15px; margin: auto; height: 10%; border-width: 0" runat="server">
                <tr>
                    <td colspan="3">
                        <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
                            <img alt="" src="<%=themeURL%>/Repository/ListControl/images/Icon-package-add.png"
                                style="vertical-align: middle"/>
                            <span class="pagetitle">
                                <%= resourceManager.GlobalResourceSet.GetString("pkg_upld")%></span>
                            <br />
                            <div class="description" style="padding-left: 36px;">
                                <%= resourceManager.GlobalResourceSet.GetString("pkg_upld_desc")%>
                            </div>
                        </telerik:RadCodeBlock>
                    </td>
                </tr>
            </table>
            <telerik:RadAjaxPanel ID="mainPanel" runat="Server" Width="100%" Height="100%" EnableAJAX="false">
                <div id="BodyDiv" style="overflow: hidden; width: 98%; height: 65%;">
                    <table id="tblPackagefile" style="width: 80%; margin: auto;" class="tablebg">
                        <tr>
                            <td class="lefttdbg" style="width: 40%; padding: 2px">
                                <telerik:RadCodeBlock ID="RadCodeBlock3" runat="server">
                                    <div class="subtitle">
                                        <%=resourceManager.GlobalResourceSet.GetString("pkg_file") %>
                                    </div>
                                    <div class="description">
                                        <%=resourceManager.GlobalResourceSet.GetString("pkg_file_desc") %>
                                    </div>
                                </telerik:RadCodeBlock>
                            </td>
                            <td class="righttdbg" style="width: 60%; padding: 2px; vertical-align: top">
                                <asp:FileUpload ID="packageFileId" runat="server" Width="100%" CssClass="inputs" onchange="importButtonEnableDisable(false)" />
                            </td>
                        </tr>
                        <tr>
                            <td class="lefttdbg" style="width: 40%;">
                                <telerik:RadCodeBlock ID="RadCodeBlock4" runat="server">
                                    <div class="subtitle">
                                        <%=resourceManager.GlobalResourceSet.GetString("pkg_desc") %>
                                    </div>
                                    <div class="description">
                                        <%=resourceManager.GlobalResourceSet.GetString("pkg_desc_dtls") %>
                                    </div>
                                </telerik:RadCodeBlock>
                            </td>
                            <td class="righttdbg" style="width: 60%; padding-top: 20px; padding-left: 2px;">
                                <asp:TextBox ID="descriptiontxtBox" runat="server" Width="98%" Rows="4" CssClass="inputtextarea textAreaMargin"
                                    TextMode="MultiLine" />
                            </td>
                        </tr>
                    </table>

                </div>
                <div style="bottom: 20px; right: 20px; position: absolute">
                    <telerik:RadCodeBlock ID="RadCodeBlock5" runat="server">
                        <input type="button" value="<%=resourceManager.GlobalResourceSet.GetString("pkg_cncl_btn") %>" onclick="javascript: closeWin();" class="inputsecondarybutton buttonMarging" />
                    </telerik:RadCodeBlock>
                    <asp:Button ID="btnAddPackage" runat="server" CssClass="inputbutton" disabled="true" />

                </div>
                <telerik:RadWindowManager ID="Singleton" Skin="AWTWindow" runat="server" RenderMode="Classic" EnableEmbeddedSkins="false" DestroyOnClose="true">
                    <Windows>
                        <telerik:RadWindow ID="PackageConfirm" Behaviors="Move" Height="175px" Width="400px" SetModal="true" runat="server" Left="" RenderMode="Lightweight"
                            Title="Package Confirmation" Top="" />
                    </Windows>
                </telerik:RadWindowManager>
            </telerik:RadAjaxPanel>
        </div>
        <telerik:RadScriptBlock ID="RadScriptBlock2" runat="server">
            <script type="text/javascript">
          function GetRadWindow() {
              var oWindow = null;
              if (window.radWindow)
                  oWindow = window.radWindow;
              else if (window.frameElement.radWindow)
                  oWindow = window.frameElement.radWindow;
              return oWindow;
          }

          function closeWin(msg) {
              if (msg)
                  alert(msg);
              var oWindow = GetRadWindow();
              oWindow.close();
          }

          function resizeWindow() {
              var oWindow = GetRadWindow();
              if (oWindow.isClosed() == false)
              {
                  oWindow.setSize(600, 380);
              }
          }

          function OpenPackageConfirmation(filepath, app, listid, parentItem, description, packageDefFilePath)
          {
              var url = "..\\..\\Package\\PackageConfirmation.aspx?mode=confirm&file=" + filepath + "&app=" + app + "&listid=" + listid + "&parent=" + parentItem + "&description=" + description + "&pkgDefPath=" + packageDefFilePath;
              var oBrowserWnd = GetRadWindow().BrowserWindow;
              oWnd = oBrowserWnd.radopen(url, "PackageConfirm");
          }
            </script>
        </telerik:RadScriptBlock>
    </form>
</body>
</html>