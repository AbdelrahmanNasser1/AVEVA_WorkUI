<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Forms.Web.CodeBehind.AdvancedSettingsForGridConfiguration" EnableViewState="true" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html>
<html style="height: 100%; width: 100%">
<head id="Head1" runat="server">
    <title>
        <%= ResManager.GlobalResourceSet.GetString("sk_gridconfig_advancedsettingspagetitle")%>
    </title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
     <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script>
    
    <style type="text/css">
        .lbl
        {
            width: 100px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            text-decoration: none;
        }

        iframe
        {
            border-style: none;
            padding:0px;
        }
    </style>
</head>

<body id="body" style="padding: 0px; margin: 0px; border-style: none; height: 100%; width: 100%; overflow: hidden;">

    <script>
        se.ui.messageDialog.setGlobalOptions({
            localization: {
                closeButtonCaption: "<%=ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                okButtonCaption: "<%=ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
                cancelButtonCaption: "<%=ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                showDetailsCaption: "<%=ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                hideDetailsCaption: "<%=ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
            }
        });


        function DisplayErrorMessage(strMessage) {
            var strHdrMsg = '<%=ResManager.GlobalResourceSet.GetString("sk_gridconfig_advancedsettingspagetitle")%>';
            se.ui.messageDialog.showError(strHdrMsg, strMessage);
        }
    </script>
    <div id="divparent" style="height: 100%; width: 100%">
        <form id="gridconfig" runat="server" style="height: 100%; width: 100%">
            <telerik:RadScriptManager ID="RadScriptManager1" runat="server" />
            <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
            <link href="<%=ThemeURL%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
            <link href="<%=ThemeURL%>CommonUXControls/StyleSheet/se.ui.min.css"  rel="stylesheet" type="text/css" /> 
            <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemeURL)%>TelerikAjax/StyleSheet/AWTTabStrip/TabStrip.AWTTabStrip.css" />         
           <%=System.Web.Helpers.AntiForgery.GetHtml()%>
           </telerik:RadScriptBlock>
         <telerik:RadAjaxPanel ID="AjaxPanel" runat="server" Width="100%" Height="100%">
        <div id="divbody" style="height:90%;width:100%" >
        <table  style="height:100%;width:100%;margin:auto;border-width:0;">    
        <tr style="height:100%">
            <td  class="tdbg" style="padding:0px;height:100%;width:100%;margin:auto">
           <telerik:RadTabStrip ID="AdvancedSettingsTabs" CssClass="TabRadTabstrip" runat="server" MultiPageID="AdvancedSettingsPages" SelectedIndex="0" Skin="AWTTabStrip" EnableEmbeddedSkins="false" RenderMode="Classic"    >
               <Tabs>
                <telerik:RadTab runat="server"  ID="GridColoringTab" PageViewID="GridColoringPage"  Width="100%" Height=98% >
                </telerik:RadTab>
                <telerik:RadTab runat="server"  ID="GridContextMenuTab" PageViewID="GridContextMenuPage"  Width="100%" Visible="false" >
                </telerik:RadTab>
               </Tabs>
           </telerik:RadTabStrip>
            <telerik:RadMultiPage ID="AdvancedSettingsPages" runat="server" CssClass="PageViewCss" SelectedIndex="0" Height="94%" Width="100%">
                <telerik:RadPageView ID="GridColoringPage" Width="100%" Height="100%" runat="server">
                 <iframe id="GridColoringFrame" height="100%" width="100%" runat="server"></iframe>
                </telerik:RadPageView>
                <telerik:RadPageView ID="GridContextMenuPage"  width="100%" height="100%" runat="server">
                <iframe id="GridContextMenuFrame" height="100%" width="100%" runat="server"></iframe>
                </telerik:RadPageView>
            </telerik:RadMultiPage>
            </td>
        </tr>
        </table>
        </div>    
        <div id="divfooter" style="height:40px; vertical-align:middle;right:0px; position:absolute; padding-right:10px;padding-top:10px;">    
             <asp:Button ID="CloseButton" runat="server" CssClass="inputsecondarybutton" OnClientClick="closeWindow();"/>               
        </div>                    
       </telerik:RadAjaxPanel>
            <script type="text/javascript">
                function GetRadWindow()
                {
                    var oWindow = null;
                    if (window.frameElement != null)
                        oWindow = window.frameElement.radWindow;
                    return oWindow;
                }

                function closeWindow(msg)
                {
                    if (msg)
                        // alert(msg);
                        se.ui.messageDialog.showError("Head", msg);
                    var oWindow = GetRadWindow();
                    oWindow.close();
                }

                AddEventHandler(window, 'resize', resizefunction);
                AddEventHandler(window, 'load', resizefunction);

                function AddEventHandler(elementObject, eventName, functionObject)
                {
                    if (document.addEventListener)
                        elementObject.addEventListener(eventName, functionObject, false);
                    else
                        if (document.attachEvent)
                            elementObject.attachEvent("on" + eventName, functionObject);
                }
                function resizefunction()
                {
                    var correctionfactor;
                    if (navigator.userAgent.indexOf('MSIE') > -1)
                    {
                        correctionfactor = -15;
                    }
                    else
                    {
                        correctionfactor = 5;
                    }

                    var bodydiv = document.getElementById('divbody');
                    var footerdiv = document.getElementById('divfooter');
                    var parentdiv = document.getElementById('divparent');
                }

            </script>
        </form>
    </div>
</body>
</html>
