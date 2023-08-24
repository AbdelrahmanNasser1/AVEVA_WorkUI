<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.VersioningRibbonBar" %>
<link href="<%=ThemeURL%>Common/StyleSheet/Global.css" rel="stylesheet" />

<%--Showing the Action Bar in the Div Element - Start--%>
        <div class="breadcrumb" >		                          
            <div class="actionItem"></div>   
            <div id="actionBarDiv" class="actionBarDiv"></div>
        </div>
 <%--Showing the Action Bar in the Div Element - End--%>

<script type="text/javascript">
    function ExecuteAction(command) {
        LocalizeMessages();
        document.getElementById("gridframe").contentWindow.ExecuteActionByName(command);
    }

    function ExecuteActionForSelectedRow(command) {
        LocalizeMessages();
        document.getElementById("gridframe").contentWindow.ExecuteActionForSelectedRow(command);
    }
    function LocalizeMessages() {
        document.getElementById("gridframe").contentWindow.cannotPerDisable = '<%=GetLangSpecText("ec_rbn_wf_cannotperformondisabled")%>';
        document.getElementById("gridframe").contentWindow.noRowSelected = '<%=GetLangSpecText("ec_rbn_wf_norowselected")%>';
        document.getElementById("gridframe").contentWindow.norightforaction = '<%=GetLangSpecText("ec_rbn_wf_norightforaction")%>';
        document.getElementById("gridframe").contentWindow.sysDel = '<%=GetLangSpecText("ec_rbn_wf_sysdelete")%>';
        document.getElementById("gridframe").contentWindow.selectItemRow = '<%=GetLangSpecText("ec_rbn_wf_selectItemRow")%>';
    }

    //Function for loading the action bar 
    function LoadActionBar() {
        ActionBar.init("", "actionBarDiv");
    }

    //Loading the Action Bar 
    LoadActionBar();

    /* Showing the Right Action Bar */
    function LoadRightActionBar() {

        if (ActionBar._rightMenu) {
            ActionBar.hideRightMenu();
        }

        ActionBar.showRightMenu(RightPackageTemplateJsonObj);

    }

    var RightPackageTemplateJsonObj =
                [
                    {
                        "Publish":
                            {
                                "Id": "91BCE64E-56F7-4750-BCFB-B5A5F60BAD11",
                                "Text": " <%=GetLangSpecText("ecm_rbn_pkgtemp_publish")%>",
                            "Tooltip": "<%=GetLangSpecText("ecm_rbn_pkgtemp_publish_alt")%>",
                                "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-Publish.png",
                                "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Publish.png",
                                "Action": "javascript:ExecuteActionForSelectedRow('_sys_publish')",
                                "OpenMode": "Popup",
                                "SubItems": []
                            }
                    },

                    {
                        "Unpublish":
                        {
                            "Id": "99B592CA-76EC-4533-AE7A-CF317E0C3AA8",
                            "Text": "<%=GetLangSpecText("ecm_rbn_pkgtemp_unpublish")%>",
                            "Tooltip": "<%=GetLangSpecText("ecm_rbn_pkgtemp_unpublish_alt")%>",
                            "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-UnPublish.png",
                            "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-UnPublish.png",
                            "Action": "javascript:ExecuteActionForSelectedRow('_sys_unpublish')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        }
                    },
                    {
                        "Generate":
                        {
                            "Id": "61924DD5-829D-4EFA-AE83-ED1520BA6437",
                            "Text": "<%=GetLangSpecText("ecm_rbn_pkgtemp_generate")%>",
                            "Tooltip": "<%=GetLangSpecText("ecm_rbn_pkgtemp_generate_alt") %>",
                            "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-generate-package.png",
                            "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-generate-package.png",
                            "Action": "javascript:ExecuteActionForSelectedRow('_sys_generate_package_template')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        }
                    },
                    {
                        "Edit":
                        {
                            "Id": "5987319E-C0E4-4142-9C01-53389025A3BF",
                            "Text": "<%=GetLangSpecText("ecm_rbn_pkgtemp_edit")%>",
                            "Tooltip": "<%=GetLangSpecText("ecm_rbn_pkgtemp_edit_alt") %>",
                            "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-Edit.png",
                            "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Edit.png",
                            "Action": "javascript:ExecuteActionForSelectedRow('_sys_edit_package_template')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        }
                    },
                    {
                        "View":
                        {
                            "Id": "D147D7FA-2307-4C2C-B1D7-A9A8B6D71C3E",
                            "Text": "<%=GetLangSpecText("ecm_rbn_pkgtemp_view")%>",
                            "Tooltip": "<%=GetLangSpecText("ecm_rbn_pkgtemp_view_alt") %>",
                            "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-View.png",
                            "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-View.png",
                            "Action": "javascript:ExecuteActionForSelectedRow('_sys_view_package_template')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        }
                    },

                    {
                        "Delete":
                        {
                            "Id": "75211C43-A0E2-4BF5-A182-3B5D78E74700",
                            "Text": "<%=GetLangSpecText("ecm_rbn_pkgtemp_delete")%>",
                            "Tooltip": "<%=GetLangSpecText("ecm_rbn_pkgtemp_delete_alt")%>",
                            "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-Delete.png",
                            "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Delete.png",
                            "Action": "javascript:ExecuteActionForSelectedRow('_sys_delete')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        }
                    },

                    {
                        "Download":
                            {
                                "Id": "54915935-5E51-40C2-8E68-7D4275E96E35",
                                "Text": "<%=GetLangSpecText("ecm_rbn_pkgtemp_download")%>",
                                "Tooltip": "<%=GetLangSpecText("ecm_rbn_pkgtemp_download_alt")%>",
                                "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-Download.png",
                                "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Download.png",
                                "Action": "javascript:ExecuteActionForSelectedRow('_sys_download_package_template')",
                                "OpenMode": "Popup",
                                "SubItems": []
                            }
                    }
                ];

</script>



<div style="width: 100%; height: 100%;display:none;" class="divMain">
    <div class="divMenu" style="width: 410px;">
        <div class="divTopImage">
            <table style="width: 400px; height: 65px; border-width: 0;border-spacing:2px;">
                <tr>
                    <td style="height: 25px; text-align: left">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_edit_package_template')"
                            class="sectionitem">
                            <img alt="<%=GetLangSpecText("ecm_rbn_pkgtemp_edit_alt") %>" src="<%=ThemeURL%>/Repository/ListControl/images/icons-ribbon/icon-edit.png"
                                style="vertical-align: middle; border-width: 0px" /><%=GetLangSpecText("ecm_rbn_pkgtemp_edit")%></a></span>
                    </td>
                    <td style="height: 25px; text-align: left">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_view_package_template')"
                            class="sectionitem">
                            <img alt="<%=GetLangSpecText("ecm_rbn_pkgtemp_view_alt") %>" src="<%=ThemeURL%>/Repository/ListControl/images/icons-ribbon/icon-view-item.png"
                                style="vertical-align: middle; border-width: 0px" /><%=GetLangSpecText("ecm_rbn_pkgtemp_view")%></a></span>
                    </td>
                    <td style="height: 25px; text-align: left">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_delete')" class="sectionitem">
                            <img alt="<%=GetLangSpecText("ecm_rbn_pkgtemp_delete_alt")%>" src="<%=ThemeURL%>/Repository/ListControl/images/icons-ribbon/delete.png"
                                style="vertical-align: middle; border-width: 0px" /><%=GetLangSpecText("ecm_rbn_pkgtemp_delete")%></a></span>
                    </td>
                </tr>
                <tr>
                    <td style="height: 25px; text-align: left; padding: 2px">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_publish')" class="sectionitem">
                            <img alt="<%=GetLangSpecText("ecm_rbn_pkgtemp_publish_alt")%>" src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/icon-publish.png"
                                style="vertical-align: middle; border-width: 0px" /><%=GetLangSpecText("ecm_rbn_pkgtemp_publish")%></a></span>
                    </td>
                    <td style="height: 25px; text-align: left; padding: 2px">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_unpublish')" class="sectionitem">
                            <img alt="<%=GetLangSpecText("ecm_rbn_pkgtemp_unpublish_alt")%>" src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/icon-unpublish.png"
                                style="vertical-align: middle; border-width: 0px" /><%=GetLangSpecText("ecm_rbn_pkgtemp_unpublish")%></a></span>
                    </td>
                    <td style="height: 25px; text-align: left; padding: 2px">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_generate_package_template')"
                            class="sectionitem">
                            <img alt="<%=GetLangSpecText("ecm_rbn_pkgtemp_generate_alt") %>" src="<%=ThemeURL%>/Repository/ListControl/images/icons-ribbon/icon-generate-package-template.png"
                                style="vertical-align: middle; border-width: 0px" /><%=GetLangSpecText("ecm_rbn_pkgtemp_generate")%></a></span>
                    </td>
                    <td style="height: 25px; text-align: left; padding: 2px">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_download_package_template')"
                            class="sectionitem">
                            <img alt="<%=GetLangSpecText("ecm_rbn_pkgtemp_download_alt")%>" src="<%=ThemeURL%>/Repository/ListControl/images/icons-ribbon/icon-download-package-template.png"
                                width="20" height="20" style="vertical-align: middle; border-width: 0px" />
                            <%=GetLangSpecText("ecm_rbn_pkgtemp_download")%>
                        </a></span>
                    </td>
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
            <%=GetLangSpecText("ec_rbn_wf_actions") %>
        </div>
    </div>
</div>
