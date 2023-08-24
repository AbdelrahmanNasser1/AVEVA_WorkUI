<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.RepositorySettings" Title="" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>



<asp:Content ID="Content2" ContentPlaceHolderID="MenuTitle" runat="server"> 
    <div>		
        <%=_ResManager.GlobalResourceSet.GetString("ec_reposettings_header")%>				
    </div>
</asp:Content>



<asp:Content ID="Content1" ContentPlaceHolderID="Cont" runat="Server">
<link href="<%=ThemeURL%>Common/StyleSheet/Global.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="<%=ThemeURL%>TelerikAjax/StyleSheet/AWTTabStrip/TabStrip.AWTTabStrip.css">
<link rel="stylesheet" type="text/css" href="<%=ThemeURL%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
<link rel="stylesheet" type="text/css" href="<%=ThemeURL%>TelerikAjax/StyleSheet/AWTWindow/Window.css">

    <script language="javascript" type="text/javascript">
        function right() {
            var len = history.length;
            alert('<%= _ResManager.GlobalResourceSet.GetString("ec_security_page_alert")%>');
        history.back(len);
    }

    </script>
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
    <table style="width:100%;height:35px;vertical-align:middle;">
        <tr class="ListHeaderCss">            
            <td style="width:96%">
                <table style="width:100%;border-collapse:separate;border-spacing:5px;">
                    <tr>
                        <td style="width:2%;height:3%;text-align:left;vertical-align:middle;">
                            <img src="<%=ThemeURL%>Repository/Site/Images/icon-settings.png" />
                        </td>
                        <td class="fontheading" style="padding:2px;">
                          <span></span>  <%= _ResManager.GlobalResourceSet.GetString("ec_reposettings_header")%>
                        </td>
                        <td id="bcrumb" class="" style="padding:4px;">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table style="width:100%;border-collapse:collapse;border-spacing:0px;">
        <tr>
            <td style="vertical-align:top;">
                <table style="width:100%;border-collapse:collapse;border-spacing:0px;">
                    <tr>
                        <td style="text-align:center;">
                            <table style="width:100%;">                               
                                <tr>
                                    <td style="vertical-align:top;">
                                        <telerik:RadTabStrip ID="SettingsTabStrip" EnableEmbeddedSkins="false" SelectedIndex="0"                MultiPageID="SettingsPage" runat="server" Width="100%"
                                             Skin="AWTTabStrip" RenderMode="Classic" Orientation="HorizontalBottom" EnableViewState="false"                 CausesValidation="false">
                                                <Tabs>
                                                <telerik:RadTab  Text="" PageViewID="StandardSettingsPage">
                                                </telerik:RadTab>
                                                <telerik:RadTab   Text="" PageViewID="AdvancedSettingsPage">
                                                </telerik:RadTab>
                                                </Tabs>
                                             </telerik:RadTabStrip>     

                                        <telerik:RadMultiPage ID="SettingsPage" runat="server" SelectedIndex="0" RenderMode="Classic">
                                            <telerik:RadPageView ID="StandardSettingsPage" runat="server">
                                                <table style="width:100%" >
                                                    <tr>
                                                        <td style="text-align:center;">
                                                            <br />
                                                            <table style="width:95%">
                                                                <tr>
                                                                    <td style="width:88px;text-align:right;vertical-align:middle;padding:10px;">
                                                                        <a runat ="server"  id="vEffectiveSecForRepoImg" href="ViewEffectiveSecurityForRepository.aspx?Level=Repository" class="textlinkblue">
                                                                            <img src="<%=ThemeURL%>Repository/Site/Images/view-effective-security.gif" width="50"
                                                                                height="50" border="0" /></a>

                                                                    </td>
                                                                    <td style="width: 45%;text-align:left;vertical-align:middle;padding:10px;">
                                                                        <a runat ="server"  id="vEffectiveSecForRepoLink" href="ViewEffectiveSecurityForRepository.aspx?Level=Repository" class="textlinkblue">
                                                                            <%= _ResManager.GlobalResourceSet.GetString("ec_reposettings_vieweffectivesecurity")%>
                                                                        </a>
                                                                        <br />
                                                                        <span class="description">
                                                                            <%= _ResManager.GlobalResourceSet.GetString("ec_reposettings_vieweffectivesecuritydescription")%>
                                                                        </span>
                                                                    </td>
                                                                    <td style="width:5%;padding:10px;">
                                                                    </td>
                                                                    <td style="width:88px;text-align:right;vertical-align:middle;padding:10px;">
                                                                        <a runat ="server"  id="vEffecMappingImg" href="ViewEffMapping.aspx?Level=Repository" class="textlinkblue">
                                                                            <img src="<%=ThemeURL%>Repository/Site/Images/View-security-mapping.gif" width="50" height="50"
                                                                                border="0" /></a></td>
                                                                    <td style="width: 45%;text-align:left;vertical-align:middle;padding:10px;">
                                                                        <a runat ="server"  id="vEffecMappingLink" href="ViewEffMapping.aspx?Level=Repository" class="textlinkblue">
                                                                            <%= _ResManager.GlobalResourceSet.GetString("ec_reposettings_securitymapping")%>
                                                                        </a>
                                                                        <br />
                                                                        <span class="description">
                                                                            <%= _ResManager.GlobalResourceSet.GetString("ec_reposettings_securitymappingdescription")%>
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
															<% if(isCloudPlatform == false) { %>
                                                                <tr>
																
                                                                    <td style="width:88px;text-align:right;vertical-align:middle;padding:10px;">
                                                                        <a runat ="server"  id="vSecMappingImg" href="SecurityGroupMappingList.aspx" class="textlinkblue">
                                                                            <img src="<%=ThemeURL%>Repository/Site/Images/manage-security-mapping.png" alt="Manage Resource Mapping"
                                                                                width="50" height="50" border="0" /></a></td>
																
                                                                    <td style="text-align:left;width:45%;vertical-align:middle;padding:10px;">
                                                                        <a runat ="server"  id="vSecMappingLink" href="SecurityGroupMappingList.aspx" class="textlinkblue">
                                                                            <%= _ResManager.GlobalResourceSet.GetString("ec_reposettings_resourcemapping")%>
                                                                        </a>
                                                                        <br />
                                                                        <span class="description">
                                                                            <%= _ResManager.GlobalResourceSet.GetString("ec_reposettings_resourcemappingdescription")%>
                                                                        </span>
                                                                    </td>
                                                                    <td style="width:5%;padding:10px;">
                                                                    </td>
                                                                    <td style="width:88px;text-align:right;vertical-align:middle;padding:10px;">
                                                                        <a runat ="server"  id="secGroupListImg" href="SecurityGroupList.aspx" class="textlinkblue">
                                                                            <img src="<%=ThemeURL%>Repository/Site/Images/manage-security-groups.png" alt="Manage Security"
                                                                                width="50" height="50" border="0" /></a></td>
                                                                    <td  style="text-align:left;width:45%;vertical-align:middle;padding:10px;">
                                                                        <a runat ="server"  id="secGroupListLink" href="SecurityGroupList.aspx" class="textlinkblue">
                                                                            <%= _ResManager.GlobalResourceSet.GetString("ec_reposettings_securitygroup")%>
                                                                        </a>
                                                                        <br />
                                                                        <span class="description">
                                                                            <%= _ResManager.GlobalResourceSet.GetString("ec_reposettings_securitygroupdescription")%>
                                                                        </span>
                                                                    </td>
                                                                    <%--<td style="width: 5%">
                                                                    </td>--%>
                                                                </tr>
																<%}%>
                                                                <tr>
                                                                    <td style="width:88px;text-align:right;vertical-align:middle;padding:10px;">
                                                                        <a runat ="server"  id="navigationListImg" href="NavigationList.aspx" class="textlinkblue">
                                                                            <img src="<%=ThemeURL%>Repository/Site/Images/manage-navigation-list.png" alt="Manage Navigation List"
                                                                                width="50" height="50" border="0" /></a></td>
                                                                    <td style="text-align:left;width:45%;vertical-align:middle;padding:10px;">
                                                                        <a runat ="server"  id="navigationListLink" href="NavigationList.aspx" class="textlinkblue">
                                                                            <%= _ResManager.GlobalResourceSet.GetString("ec_reposettings_navigationlist")%>
                                                                        </a>
                                                                        <br />
                                                                        <span class="description">
                                                                            <%= _ResManager.GlobalResourceSet.GetString("ec_reposettings_navigationlistdescription")%>
                                                                        </span>
                                                                    </td>
                                                                    <td style="width: 5%;padding:10px;">
                                                                    </td>
                                                                    <td style="width:88px;text-align:right;vertical-align:middle;padding:10px;">
                                                                        <a runat ="server"  id="securityRightsImg" href="SecurityRightsList.aspx" class="textlinkblue">
                                                                            <img src="<%=ThemeURL%>Repository/Site/Images/manage-security-rights.png" alt="Manage Security Rights"
                                                                                width="50" height="50" border="0" /></a></td>
                                                                    <td style="text-align:left;width:45%;vertical-align:middle;padding:10px;" colspan="2">
                                                                        <a runat ="server"  id="securityRightsLink" href="SecurityRightsList.aspx" class="textlinkblue">
                                                                            <%= _ResManager.GlobalResourceSet.GetString("ec_reposettings_securityrights")%>
                                                                        </a>
                                                                        <br />
                                                                        <span class="description">
                                                                            <%= _ResManager.GlobalResourceSet.GetString("ec_reposettings_securityrightsdescription")%>
                                                                        </span>
                                                                    </td>
                                                                    <td style="width:5%;padding:10px;">
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width:88px;text-align:right;vertical-align:middle;padding:10px;">
                                                                        <a  runat ="server"  id="eventProviderListImg" href="EventProvidersList.aspx" class="textlinkblue">
                                                                            <img src="<%=ThemeURL%>Repository/Site/Images/manage-event-provider.png" alt="Manage Event Providers"
                                                                                width="50" height="50" border="0" /></a></td>
                                                                    <td style="text-align:left;width:45%;vertical-align:middle;padding:10px;">
                                                                        <a runat ="server"  id="eventProviderListLink"  href="EventProvidersList.aspx" class="textlinkblue">
                                                                            <%= _ResManager.GlobalResourceSet.GetString("ec_reposettings_eventproviders")%>
                                                                        </a>
                                                                        <br />
                                                                        <span class="description">
                                                                            <%= _ResManager.GlobalResourceSet.GetString("ec_reposettings_eventprovidersdescription")%>
                                                                        </span>
                                                                    </td>
                                                                    <td style="width:5%;padding:10px;">
                                                                    </td>
																	<% if(isCloudPlatform == true) {%>
																	<td style="width:88px;text-align:right;vertical-align:middle;padding:10px;">
                                                                        <a runat ="server"  id="secGroupListImgCloud" href="SecurityGroupList.aspx" class="textlinkblue">
                                                                            <img src="<%=ThemeURL%>Repository/Site/Images/manage-security-groups.png" alt="Manage Security"
                                                                                width="50" height="50" border="0" /></a></td>
                                                                    <td  style="text-align:left;width:45%;vertical-align:middle;padding:10px;">
                                                                        <a runat ="server"  id="secGroupListLinkCloud" href="SecurityGroupList.aspx" class="textlinkblue">
                                                                            <%= _ResManager.GlobalResourceSet.GetString("ec_reposettings_securitygroup")%>
                                                                        </a>
                                                                        <br />
                                                                        <span class="description">
                                                                            <%= _ResManager.GlobalResourceSet.GetString("ec_reposettings_securitygroupdescription")%>
                                                                        </span>
                                                                    </td>
																	<%}%>
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

    <script>

        try
        {
            document.getElementById("tblMain").style.display = "none";
        }
        catch (ex) {

        }

    </script>
</asp:Content>
