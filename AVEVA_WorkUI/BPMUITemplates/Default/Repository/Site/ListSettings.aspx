<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.ListSettings" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>



<!DOCTYPE html >
<html>
<head runat="server" id="head1">
    <title></title>
</head>
<body>
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=bellyBarCss %>CommonUXControls/StyleSheet/se.ui.min.css" /> 
    <link href="<%=cssPath%>/Global.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="<%=bellyBarCss%>TelerikAjax/StyleSheet/AWTTabStrip/TabStrip.AWTTabStrip.css">
    <link rel="stylesheet" type="text/css" href="<%=bellyBarCss%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
    <link rel="stylesheet" type="text/css" href="<%=bellyBarCss%>TelerikAjax/StyleSheet/AWTWindow/Window.css">

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
    </script>
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager ID="radScriptManager" runat="server"></telerik:RadScriptManager>
        <div style="height: 300px; width: 50px; display: none">
            <input type="button" id="SearchUser" value="Open Window" />
           
            <telerik:RadWindowManager ID="Singleton" Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false"
             runat="server" Behaviors="Close, Minimize, Maximize, Move" DestroyOnClose="true" Overlay="false" RenderMode="Classic" VisibleStatusbar="false">  
            <Windows>
                    <telerik:RadWindow ID="RadWindow1" Height="300px" Width="555px" runat="server" Skin="AWTWindow" OpenerElementId="SearchUser" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" RenderMode="Classic" VisibleStatusbar="false" Behaviors="Close" NavigateUrl="UserLookup.aspx">
                    </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>

        </div>
        <table style="width:100%;border-collapse:collapse;border-spacing:0px;">
            <tr>
                <td style="vertical-align:top;">
                    <telerik:RadTabStrip ID="SettingsTabStrip" runat="server" Width="100%"
                                            EnableEmbeddedSkins="false" SelectedIndex="0"  MultiPageID="SettingsPage"
                                             Skin="AWTTabStrip" RenderMode="Classic" Orientation="HorizontalBottom" EnableViewState="false" CausesValidation="false">
                                            <Tabs>
                                                <telerik:RadTab  Text="" PageViewID="StandardSettingsPage">
                                                </telerik:RadTab>
                                                <telerik:RadTab  Text="" PageViewID="AdvancedSettingsPage">
                                                </telerik:RadTab>
                                            </Tabs>
                                        </telerik:RadTabStrip>

                       


                    <telerik:RadMultiPage ID="SettingsPage" runat="server" SelectedIndex="0" RenderMode="Classic">
                        <telerik:RadPageView ID="StandardSettingsPage" runat="server">
                            <table style="width:100%">
                                <tr>
                                    <td style="text-align:center;">
                                        <br />
                                        <table style="width:95%">
                                            <tr>
                                                <td style="width:88px;text-align:right;vertical-align:middle;padding:10px;">
                                                    <a href="ViewEffectiveSecurity.aspx?<%=_PageParams%>&Level=List" class="textlinkblue">
                                                        <img src="<%=imgPath%>/view-effective-security.gif" width="50" height="50" border="0" /></a></td>
                                                <td style="width: 45%;text-align:left;vertical-align:middle;padding:10px;">
                                                    <a href="ViewEffectiveSecurity.aspx?<%=_PageParams%>&Level=List" class="textlinkblue">
                                                        <%= _ResManager.GlobalResourceSet.GetString("ec_listsettings_vieweffectivesecurity")%>
                                                    </a>
                                                    <br />
                                                    <span class="description">
                                                        <%= _ResManager.GlobalResourceSet.GetString("ec_listsettings_vieweffectivesecuritydescription")%>
                                                    </span>
                                                </td>
                                                <td style="width:5%;padding:10px;">
                                                </td>
                                                <td style="width:88px;text-align:right;vertical-align:middle;padding:10px;">
                                                    <a href="ViewEffectiveListMapping.aspx?<%=_PageParams%>&Level=List" class="textlinkblue">
                                                        <img src="<%=imgPath%>/View-security-mapping.gif" width="50" height="50" border="0" /></a></td>
                                                <td style="width: 45%;text-align:left;vertical-align:middle;padding:10px;">
                                                    <a href="ViewEffectiveListMapping.aspx?<%=_PageParams%>&Level=List" class="textlinkblue">
                                                        <%= _ResManager.GlobalResourceSet.GetString("ec_listsettings_securitymapping")%>
                                                    </a>
                                                    <br />
                                                    <span class="description">
                                                        <%= _ResManager.GlobalResourceSet.GetString("ec_listsettings_securitymappingdescription")%>
                                                    </span>
                                                </td>
                                                <td style="width:5%;padding:10px;">
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </telerik:RadPageView>
                        <telerik:RadPageView ID="AdvancedSettingsPage" runat="server">
                            <table style="width:100%;">
                                <tr>
                                    <td style="text-align:center;">
                                        <br />
                                        <table style="width:95%;">
                                            <tr>
                                                <td id="td1" style="width:88px;text-align:right;vertical-align:middle;padding:10px;" runat="server">
                                                </td>
                                                <td id="td11" style="width: 45%;text-align:left;vertical-align:middle;padding:10px;" runat="server">
                                                </td>
                                                <td style="width:5%;padding:10px;">
                                                </td>
                                                <td id="td2" style="width:88px;text-align:right;vertical-align:middle;padding:10px;" runat="server">
                                                </td>
                                                <td id="td22" runat="server" style="width: 45%;text-align:left;vertical-align:middle;padding:10px;">
                                                </td>
                                                <td style="width:5%;padding:10px;">
                                                </td>
                                            </tr>
                                            <tr id="trTurnON">
                                                <td id="td3" style="width:88px;text-align:right;vertical-align:middle;padding:10px;" runat="server">
                                                </td>
                                                <td id="td33" style="width: 45%;text-align:left;vertical-align:middle;padding:10px;" runat="server">
                                                </td>
                                                <td style="width:5%;padding:10px;">
                                                </td>
                                                <td id="td4" style="width:88px;text-align:right;vertical-align:middle;padding:10px;" runat="server">
                                                </td>
                                                <td id="td44" style="width: 45%;text-align:left;vertical-align:middle;padding:10px;" runat="server">
                                                </td>
                                                <td style="width:5%;padding:10px;">
                                                </td>
                                            </tr>
                                            <%if (isPackageEnabled)
                                              {%>
                                            <tr>
                                                <td style="width:88px;text-align:right;vertical-align:middle;padding:10px;" runat="server">
                                                    <a onclick="javascript:ShowPackageWindow('rm');" class="textlinkblue">
                                                        <img src="<%=imgPath%>/SecurityRMPackage.gif" width="50" height="50" border="0" /></a>
                                                </td>
                                                <td style="width: 45%;text-align:left;vertical-align:middle;padding:10px;">
                                                    <a onclick="javascript:ShowPackageWindow('rm');" class="textlinkblue">
                                                        <%= _ResManager.GlobalResourceSet.GetString("ec_listsettings_addpackagerm")%>
                                                    </a>
                                                    <br />
                                                    <span class="description">
                                                        <%= _ResManager.GlobalResourceSet.GetString("ec_listsettings_addpackagermdescription")%>
                                                    </span>
                                                </td>
                                                <td style="width:5%;padding:10px;">
                                                </td>
                                                <td style="width:88px;text-align:right;vertical-align:middle;padding:10px;" runat="server">
                                                    <a onclick="javascript:ShowPackageWindow('sg');" class="textlinkblue">
                                                        <img src="<%=imgPath%>/SecuritySGPackage.gif" width="50" height="50" border="0" /></a>
                                                </td>
                                                <td style="width: 45%;text-align:left;vertical-align:middle;padding:10px;">
                                                    <a onclick="javascript:ShowPackageWindow('sg');" class="textlinkblue">
                                                        <%= _ResManager.GlobalResourceSet.GetString("ec_listsettings_addpackagesg")%>
                                                    </a>
                                                    <br />
                                                    <span class="description">
                                                        <%= _ResManager.GlobalResourceSet.GetString("ec_listsettings_addpackagesgdescription")%>
                                                    </span>
                                                </td>
                                                <td style="width:5%;padding:10px;">
                                                </td>
                                            </tr>
                                            <%} %>
                                            
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </telerik:RadPageView>
                    </telerik:RadMultiPage>
                </td>
            </tr>
        </table>
    </form>
    <script type="text/javascript" language="javascript">
        function ShowPackageWindow(type) {
            var application = '<%=_Repository%>';
            var securityType;
            if (type == 'sg') {
                securityType = 'SECURITYLISTSG';
                if (!('<%=_Flag%>' == 'sg' || '<%=_Flag%>' == 'sgrm')) {
                    se.ui.messageDialog.showError('<%= _ResManager.GlobalResourceSet.GetString("ec_reposettings_vieweffectivesecurity_role")%>', '<%= _ResManager.GlobalResourceSet.GetString("ec_listsettings_sg_not_enabled")%>');
                    return;
                }
            }
            else {
                securityType = 'SECURITYLISTRM';
                if (!('<%=_Flag%>' == 'rm' || '<%=_Flag%>' == 'sgrm')) {
                    se.ui.messageDialog.showError('<%= _ResManager.GlobalResourceSet.GetString("ec_reposettings_vieweffectivesecurity_role")%>', '<%= _ResManager.GlobalResourceSet.GetString("ec_listsettings_rm_not_enabled")%>');
                    return;
                }
            }
            var url = "../../Package/PackageList.aspx?<%=_PageParams%>&mode=" + securityType + "&AppName=" + application;
            var windowparams = "height=320,width=500,resizable=yes,status=no";
            var oWindow = radopen(url, null);
            oWindow.set_modal(true);
            oWindow.set_title("ListSecurity Packaging");
            oWindow.setSize(590, 360);
        }
    </script>
</body>
</html>
