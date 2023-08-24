<%@ Page Language="C#" AutoEventWireup="true" Inherits="ExportForm_FromContext" Debug="true" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html>
<html>
<link href="<%=ThemePath%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
<head id="Head1" runat="server">
    <title><%=Export%></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <script>
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
        function CloseWindow() {
            var oWindow = GetRadWindow();
            oWindow.hide();
        }
    </script>
</head>
<body onload="DisplayMessageWithConfirm()" >
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

    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
         <asp:HiddenField ID="hdnEDID" runat="server" />
         <link href="<%=ThemePath%>CommonUXControls/StyleSheet/se.ui.min.css"  rel="stylesheet" type="text/css" /> 
        <link rel="stylesheet" type="text/css" href="<%=ThemePath%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
 <link rel="stylesheet" type="text/css" href="<%=ThemePath%>TelerikAjax/StyleSheet/AWTWindow/Window.css">
    
               

        <telerik:RadWindowManager ID="RadWindowManager1"  Skin="AWTWindow" EnableEmbeddedSkins="false" 
         runat="server"  RenderMode="Classic" VisibleStatusbar="false"> 
        <Windows>
        <telerik:RadWindow  ID="lookup" runat="server" Behaviors="Close" ReloadOnShow="false" ShowContentDuringLoad="false" DestroyOnClose="true">
        </telerik:RadWindow>       
        </Windows>
      </telerik:RadWindowManager>



    <div>
        <asp:Panel ID="ConfirmPanel" runat="server">
            <br />
            <br />
            <table style="border-spacing:0px;border-width:0;margin:auto;width:100%">
                <tr>
                    <td colspan="2" style="text-align:center;padding:5px" class="description">
                        <%=ExportFormText%>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:right;padding-top:25px;padding-right:5px;">
                       <asp:Button ID="btnCancel" runat="server" Text="" OnClick="btnCancel_Click" CssClass="inputsecondarybutton" />
                    <%--</td>
                    <td style="text-align:left;padding:5px">--%>
                       <asp:Button ID="btnExport"  runat="server" Text="" OnClick="btnExport_Click" Visible="true"
                            CssClass="inputbutton" />
                       
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </div>
    </form>
    <script>
        function DisplayMessageWithConfirm() {            
            var strHdrMsg = '<%=resManager.GlobalResourceSet.GetString("List_item_Operation_for_list")%>';
            var oWindow = GetRadWindow();
            oWindow.show();
            oWindow.setSize(10, 10);
            oWindow.center();
           
            var confMessage = '<%=ExportFormText%>';
             if (document.getElementById('hdnEDID').value == "") {
                document.getElementById('hdnEDID').value = "someval";
                se.ui.messageDialog.showConfirmation(strHdrMsg, confMessage,
                              function (userResponse) {                                  
                                  if (userResponse) {
                                      document.getElementById('btnExport').click();                                      
                                      oWindow.hide();
                                     
                                  }
                                  else {
                                      CloseWindow();

                                  }

                              });
               
            }

        }

       

    </script>
</body>
</html>
