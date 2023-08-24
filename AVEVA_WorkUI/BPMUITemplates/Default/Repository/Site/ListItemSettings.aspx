<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.ListItemSettings" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

 
<!DOCTYPE html >
<html>
<head id="Head1" runat="server">
    <title></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>

</head>
<body>
    <form id="form1" runat="server" style="overflow:hidden;">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
        <telerik:RadScriptManager ID="radScriptManager" runat="server"></telerik:RadScriptManager>
        <link href="<%=cssPath%>/Global.css" rel="stylesheet" type="text/css" />
            <link rel="stylesheet" type="text/css" href="<%=themeURL%>TelerikAjax/StyleSheet/AWTTabStrip/TabStrip.AWTTabStrip.css">
    <link rel="stylesheet" type="text/css" href="<%=themeURL%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
    <link rel="stylesheet" type="text/css" href="<%=themeURL%>TelerikAjax/StyleSheet/AWTWindow/Window.css">
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
                <td  style="vertical-align:top;">
                    <table style="width:100%;border-collapse:collapse;border-spacing:0px;" >
                        <tr>
                            <td style="text-align:center;">
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


                                       
                                            <telerik:RadMultiPage ID="SettingsPage" runat="server" SelectedIndex="0">
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
                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                        <tr>
                                                            <td align="left">
                                                                <br />
                                                                <table width="95%" border="0" cellspacing="0" cellpadding="10">
                                                                    <tr id="trSGRM" runat="server">
                                                                        <td id="td1" width="88" align="left" valign="middle" runat="server">
                                                                        </td>
                                                                        <td id="td11" style="width: 45%" runat="server" align="left" valign="middle">
                                                                        </td>
                                                                        <td style="width: 5%;">
                                                                        </td>
                                                                        <td id="td2" width="88" align="left" valign="middle" runat="server">
                                                                        </td>
                                                                        <td id="td22" runat="server" style="width: 45%" align="left" valign="middle">
                                                                        </td>
                                                                        <td style="width: 5%;">
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trTurnON">
                                                                        <td id="td3" width="88" align="left" valign="middle" runat="server">
                                                                        </td>
                                                                        <td id="td33" style="width: 45%" align="left" valign="middle" runat="server">
                                                                        </td>
                                                                        <td style="width: 5%;">
                                                                        </td>
                                                                        <td id="td4" width="88" align="left" valign="middle" runat="server">
                                                                        </td>
                                                                        <td id="td44" style="width: 45%" align="left" valign="middle" runat="server">
                                                                        </td>
                                                                        <td style="width: 5%;">
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </telerik:RadPageView>
                                            </telerik:RadMultiPage>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
