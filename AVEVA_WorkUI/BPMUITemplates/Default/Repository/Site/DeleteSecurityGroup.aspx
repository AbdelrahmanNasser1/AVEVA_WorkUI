<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.DeleteSecurityGroup" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head><%-- runat="server"--%>
    <title><%=_ResManager.GlobalResourceSet.GetString("ec_sg_del_title") %></title>
    <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemeURL)%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" language="javascript">
        function OpenWindow(path)
        {
            // Opening inside the browser window as the browser's child window
            var oBrowserWnd = GetRadWindow().BrowserWindow; 
            var oWindow = oBrowserWnd.radopen(path, "RadWindow1");

            var w,h;
            var winHeight = 500;
            var winWidth = 800;

            if (document.all || document.layers) {
                w = screen.availWidth;   //getMaxWidth();    
                h = screen.availHeight; //getMaxHeight();    
            }

            var winLeft = (w-winWidth)/2;
            var winTop  = (h-winHeight)/2;    
            oWindow.setSize(winWidth,winHeight);
            oWindow.moveTo(winLeft,winTop);
        }
        
        function GetRadWindow()
        {
            var oWindow = null;
             oWindow = window.frameElement.radWindow;
            return oWindow;
        } 

        function closeWindow(isDeleted)
        {            
          var oWindow = GetRadWindow();
          if (isDeleted)
          {
              se.ui.messageDialog.showAlert('<%=_ResManager.GlobalResourceSet.GetString("ec_sg_del_title") %>', '<%=_ResManager.GlobalResourceSet.GetString("ec_sg_del_del_msg") %>', function ()
              {
                  try {
                      oWindow.BrowserWindow.window.document.getElementById('mainframe').contentWindow.document.getElementById("gridframe").contentWindow.RefreshGrid();                     

                  }
                  catch (e) { }
                  oWindow.close();
              });
          }
        }      

        
        function focusonno()
        {
            try
            {
                var userid = document.getElementById('NoButton');
                userid.focus();
            }
            catch(e)
            {}
        }
    </script>

</head>
<body style="overflow: hidden" onload="focusonno();">
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemeURL) %>CommonUXControls/StyleSheet/se.ui.min.css" />   
    <link rel="stylesheet" type="text/css" href="<%:ThemeURL%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
    <link rel="stylesheet" type="text/css" href="<%:ThemeURL%>TelerikAjax/StyleSheet/AWTWindow/Window.css">

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
    </script>
    <div id="divparent">
        <form id="form1" runat="server">
            <%=System.Web.Helpers.AntiForgery.GetHtml()%>
            <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
            <div id="divheader">
                <table border="0" cellpadding="5" cellspacing="0" width="95%" align="center">
                    <tr height="60">
                        <td align="center" style="width: 91%" colspan="2">
                        
                            <img src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemeURL)%>Repository/Site/images/security-group-delete.png"
                                align="absmiddle" />&nbsp;&nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <asp:Label ID="lblMessage" runat="server" CssClass="description"></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="divbody" runat="server">
                <table border="0" cellpadding="5" cellspacing="0" width="95%" align="center">
                    <tr>
                        <td align="center" valign="top" class="description" style="width: 91%" colspan="2">
                            <a class='textlinkblue' href='#' onclick='OpenWindow(<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_Windowpath, false) %> );'>
                                <%=_ResManager.GlobalResourceSet.GetString("ec_sg_del_resourcemapping") %>
                            </a>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="divfooter">
                <asp:Panel ID="PanelConfirm" runat="server">
                    <table cellpadding="5px" cellspacing="0" border="0" align="center" width="95%">
                        <tr>
                            <td colspan="2" align="center" class="description">
                                <%=_ResManager.GlobalResourceSet.GetString("ec_sg_del_description") %>
                                "<b><%=_SecurityGroupName %></b>"?</td>
                        </tr>
                        <tr align="center">
                            <td style="width: 50%" align="center">
                                <asp:Button ID="YesButton" runat="server" OnClick="YesButton_Click"
                                    Width="60px" CssClass="inputbutton" />
                                <input id="NoButton" type="button" runat="server" onclick="javascript:closeWindow(false);return false;"
                                    class="inputbutton" style="width: 60px" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <asp:Panel ID="PanelDel" runat="server" Visible="false">
                    <table id="deleteMessageTable" cellpadding="15px" cellspacing="0" border="0" align="center">
                        <tr>
                            <td align="center">
                                <asp:Label ID="DeleteMessage" runat="server" Text="" CssClass="description"></asp:Label>
                            </td>
                        </tr>
                    </table>
                    <table border="0" cellpadding="8" cellspacing="0" width="100%">
                        <tr>
                            <td align="center">
                                <asp:Button ID="CloseButton" runat="server" Text="" OnClientClick="javascript:closeWindow();return false;"
                                    CssClass="inputbutton" Width="75px" /></td>
                        </tr>
                    </table>
                </asp:Panel>
            </div>
            <div style="height: 80%; width: 80%; display: none">
                <input type="button" id="btnOpen" value="Open Window" />
                <telerik:RadWindowManager ID="Singleton" Skin="AWTWindow" runat="server" Behaviors="Close, Minimize, Maximize, Move" EnableEmbeddedSkins="false" VisibleStatusbar="false">
                    <Windows>
                        <telerik:RadWindow ID="RadWindow1" Height="600" Width="800" runat="server" OpenerElementId="btnOpen"
                            NavigateUrl="ViewGlobalRights.aspx" />
                    </Windows>
                </telerik:RadWindowManager>
            </div>
        </form>
    </div>
</body>
</html>
