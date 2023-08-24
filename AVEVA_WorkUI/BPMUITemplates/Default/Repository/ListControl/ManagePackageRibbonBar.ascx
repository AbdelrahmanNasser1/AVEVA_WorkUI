<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.WebControls_RibbonBar" %>
<link href="<%=templateThemeDirectory%>Common/StyleSheet/Global.css" rel="stylesheet" />

<%--Showing the Action Bar in the Div Element - Start--%>
        <div class="breadcrumb" >		                          
            <div class="actionItem"></div>   
            <div id="actionBarDiv" class="actionBarDiv"></div>
        </div>
 <%--Showing the Action Bar in the Div Element - End--%>

<script type="text/javascript">
    function ExecuteSettingsActionFlag(command) {
        LocalizeMessages();
        document.getElementById("gridframe").contentWindow.ExecuteActionByName(command);
        HideSubItemsActionBar();
        if (command == "_sys_security_settings") {
            ManagePackagejsonObj = "";
            LoadActionBar();
        }
    }

    function ExecuteAction(command) {
        LocalizeMessages();
        document.getElementById("gridframe").contentWindow.ExecuteActionByName(command);
        HideSubItemsActionBar();
    }

    function ExecuteActionForSelectedRow(command) {
        LocalizeMessages();
        document.getElementById("gridframe").contentWindow.ExecuteActionForSelectedRow(command);
        HideSubItemsActionBar();
    }

    function LocalizeMessages() {
        document.getElementById("gridframe").contentWindow.cannotPerDisable = '<%=GetLangSpecText("ec_rbn_wf_cannotperformondisabled")%>';
        document.getElementById("gridframe").contentWindow.noRowSelected = '<%=GetLangSpecText("ec_rbn_wf_norowselected")%>';
        document.getElementById("gridframe").contentWindow.norightforaction = '<%=GetLangSpecText("ec_rbn_wf_norightforaction")%>';
        document.getElementById("gridframe").contentWindow.sysDel = '<%=GetLangSpecText("ec_rbn_wf_sysdelete")%>';
    }

    /* Hiding the Sub items of the Action Bar */
    function HideSubItemsActionBar()
    {
        ActionBar.hideSubMenus();
        LoadActionBar();
    }

    /* Showing the Right Action Bar */
    function LoadRightActionBar() {


        if (ActionBar._rightMenu) {
            ActionBar.hideRightMenu();
        }

        ActionBar.showRightMenu(RightManagePackageJsonObj);

    }


    var ManagePackagejsonObj =
        [

            {
                "Up":
                {
                    "Id": "498D4CBB-2446-493D-983A-8DFF0BD20AD8",
                    "Text": " <%=GetLangSpecText("ec_rbn_wf_navigate") %>",
                    "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_navigate_alt") %>",
                    "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Up.png",
                    "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Up.png",
                    "Action": "javascript:document.getElementById('gridframe').contentWindow.NavigateUp()",
                    "OpenMode": "Popup",
                    "SubItems":
                    [

                    ]
                }
            },


            {
                "New": {
                    "Id": "E53C245D-E05B-4D4F-820D-40AD26479887",
                    "Text": "<%=GetLangSpecText("ec_rbn_wf_new") %>",
                    "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_new") %>",
                    "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-New.png",
                    "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-New.png",
                    "Action": "",
                    "OpenMode": "Popup",
                    "SubItems": [
                        {
                            "Id": "80C33179-9B75-4248-A466-DA7F65789C0A",
                            "Text": "<%=GetLangSpecText("ecm_rbn_pkg_upload")%>",
                            "Tooltip": "<%=GetLangSpecText("ecm_rbn_pkg_upload_alt") %>",
                            "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Upload.png",
                            "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Upload.png",
                            "Action": "javascript:ExecuteAction('_sys_package_add')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        },

                       {
                           "Id": "799F6317-9BD8-4141-9408-7F32EDB47B64",
                           "Text": "<%=GetLangSpecText("ec_rbn_wf_newfolder") %>",
                           "Tooltip": "<%=GetLangSpecText("ec_rbn_nl_folder") %>",
                           "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Folder.png",
                           "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Folder.png",
                           "Action": "javascript:ExecuteSettingsActionFlag('_sys_newfolder')",
                           "OpenMode": "Popup",
                           "SubItems": []
                       }

                    ]
                }
            },

            {
                "Organize":
                {
                    "Id": "D71DAC6A-C7E8-4BCA-B62E-8E65CCC259E7",
                    "Text": " <%=GetLangSpecText("ec_rbn_wf_organize")%>",
                    "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_organize") %>",
                    "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Organize.png",
                    "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Organize.png",
                    "Action": "javascript:ExecuteAction('_sys_organize')",
                    "OpenMode": "Popup",
                    "SubItems":
                    [

                    ]
                }
            },

            {
                "Security":
                {
                    "Id": "777397CB-1B26-4DBF-ACB0-2BEB0F551856",
                    "Text": "<%=GetLangSpecText("ec_rbn_wf_settings") %>",
                    "Tooltip": "<%=GetLangSpecText("ec_rbn_nl_security_alt") %>",
                    "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Security.png",
                    "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Security.png",
                    "Action": "javascript:ExecuteSettingsActionFlag('_sys_security_settings')",
                    "OpenMode": "Popup",
                    "SubItems":
                    [

                    ]
                }
            }

        ];




    var RightManagePackageJsonObj =
                  [

                        {
                            "Run":
                                {
                                    "Id": "91BCE64E-56F7-4750-BCFB-B5A5F60BAD11",
                                    "Text": " <%=GetLangSpecText("ecm_rbn_pkg_run")%>",
                                    "Tooltip": "<%=GetLangSpecText("ecm_rbn_pkg_run_alt") %>",
                                    "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Install.png",
                                    "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Install.png",
                                    "Action": "javascript:ExecuteActionForSelectedRow('_sys_run_package')",
                                    "OpenMode": "Popup",
                                    "SubItems": []
                                }
                        },

                        {
                            "Uninstall":
                            {
                                "Id": "99B592CA-76EC-4533-AE7A-CF317E0C3AA8",
                                "Text": "<%=GetLangSpecText("ecm_rbn_pkg_uninstall")%>",
                                "Tooltip": "<%=GetLangSpecText("ecm_rbn_pkg_uninstall_alt") %>",
                                "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Uninstall.png",
                                "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Uninstall.png",
                                "Action": "javascript:ExecuteActionForSelectedRow('_sys_uninstall_package')",
                                "OpenMode": "Popup",
                                "SubItems": []
                            }
                        },

                        {
                            "Edit":
                            {
                                "Id": "5987319E-C0E4-4142-9C01-53389025A3BF",
                                "Text": "<%=GetLangSpecText("ecm_rbn_pkg_edit") %>",
                                "Tooltip": "<%=GetLangSpecText("ecm_rbn_pkg_edit_alt") %>",
                                "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Edit.png",
                                "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Edit.png",
                                "Action": "javascript:ExecuteActionForSelectedRow('_sys_edit_settingsform')",
                                "OpenMode": "Popup",
                                "SubItems": []
                            }
                        },
                        {
                            "View":
                            {
                                "Id": "D147D7FA-2307-4C2C-B1D7-A9A8B6D71C3E",
                                "Text": "<%=GetLangSpecText("ecm_rbn_pkg_view") %>",
                                "Tooltip": "<%=GetLangSpecText("ecm_rbn_pkg_view_alt") %>",
                                "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-View.png",
                                "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-View.png",
                                "Action": "javascript:ExecuteActionForSelectedRow('_sys_view_package')",
                                "OpenMode": "Popup",
                                "SubItems": []
                            }
                        },

                        {
                            "Delete":
                            {
                                "Id": "75211C43-A0E2-4BF5-A182-3B5D78E74700",
                                "Text": "<%=GetLangSpecText("ecm_rbn_pkg_delete") %>",
                                "Tooltip": "<%=GetLangSpecText("ecm_rbn_pkg_delete_alt") %>",
                                "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Delete.png",
                                "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Delete.png",
                                "Action": "javascript:ExecuteActionForSelectedRow('_sys_delete')",
                                "OpenMode": "Popup",
                                "SubItems": []
                            }
                        },

                        {
                            "History":
                            {
                                "Id": "61924DD5-829D-4EFA-AE83-ED1520BA6437",
                                "Text": "<%=GetLangSpecText("ecm_rbn_pkg_history")%>",
                                "Tooltip": "<%=GetLangSpecText("ecm_rbn_pkg_history_alt") %>",
                                "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-generate-package.png",
                                "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-generate-package.png",
                                "Action": "javascript:ExecuteActionForSelectedRow('_sys_package_history')",
                                "OpenMode": "Popup",
                                "SubItems": []
                            }
                        }
                ];



        //Function for loading the action bar 
        function LoadActionBar() {
            ActionBar.init(ManagePackagejsonObj, "actionBarDiv");
        }

        //Loading the Action Bar 
        LoadActionBar();

</script>
<div style="width: 100%; height: 100%;display:none;" class="divMain">
    <div class="divMenu" style="width: 80px;">
        <div class="divTopImage" style="width: 100%">
            <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 0; border-collapse: collapse; border: 0px solid;">
                <tr>
                    <td style="height: 25px; text-align: center; padding: 2px">
            <a href="javascript:document.getElementById('gridframe').contentWindow.NavigateUp()"
                class="sectionitem">
                <img src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/icon-up.png"
                   style="border-width:0" alt="<%=GetLangSpecText("ec_rbn_wf_navigate_alt") %>" width="36" height="36" /></a>

</td>
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
            <%=GetLangSpecText("ec_rbn_wf_navigate") %>
        </div>
    </div>
    <div style="width: 110px;" class="divMenu">
        <div class="divTopImage">
            <table style="width:100%;height:65px;border-width:0">
                <tr>
                    <td style="text-align:left" class="sectionitem">
                        <span class="sectionitem"><a href="javascript:ExecuteAction('_sys_package_add')"
                            class="sectionitem">
                            <img src="<%=templateThemeDirectory%>/Repository/ListControl/images/icons-ribbon/Icon-package-add.png"
                                 alt="<%=GetLangSpecText("ecm_rbn_pkg_upload_alt") %>" style="vertical-align:middle;border-width:0" />
                            <%=GetLangSpecText("ecm_rbn_pkg_upload")%>
                        </a></span>
                    </td>
                </tr>
                <tr>
                    <td style="height:25;text-align:left">
                        <span><a href="javascript:ExecuteSettingsActionFlag('_sys_newfolder')" class="sectionitem">
                            <img alt="<%=GetLangSpecText("ec_rbn_nl_folder") %>" src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/icon-new-folder.png"
                                width="23" height="23" style="vertical-align:middle;border-width:0" />
                            <%=GetLangSpecText("ec_rbn_wf_newfolder") %>
                        </a></span>
                    </td>
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
            <%=GetLangSpecText("ec_rbn_wf_new") %>
        </div>
    </div>
    <div style="width:320px;" class="divMenu">
        <div class="divTopImage">
            <table style="width:100%;height:65px; border-width:0;border-spacing:2px;border-collapse:separate" >
                <tr>
                    <td style="height:25;text-align:left" class="sectionitem">
                        <span class="sectionitem"><a href="javascript:ExecuteActionForSelectedRow('_sys_edit_settingsform')"
                            class="sectionitem">
                            <img src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/icon-edit.png"
                                alt="<%=GetLangSpecText("ecm_rbn_pkg_edit_alt") %>"   style="vertical-align:middle;border-width:0" />
                            <%=GetLangSpecText("ecm_rbn_pkg_edit") %></a></span>
                    </td>
                    <td style="height:25;text-align:left" class="sectionitem">
                        <span class="sectionitem"><a href="javascript:ExecuteActionForSelectedRow('_sys_view_package')"
                            class="sectionitem">
                            <img src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/icon-view-item.png"
                                alt="<%=GetLangSpecText("ecm_rbn_pkg_view_alt") %>"   style="vertical-align:middle;border-width:0" />
                            <%=GetLangSpecText("ecm_rbn_pkg_view") %></a></span>
                    </td>
                    <td style="text-align:left" class="sectionitem">
                        <span class="sectionitem"><a href="javascript:ExecuteActionForSelectedRow('_sys_delete')"
                            class="sectionitem">
                            <img src="<%=templateThemeDirectory%>/Repository/ListControl/images/icons-ribbon/delete.png"
                                alt="<%=GetLangSpecText("ecm_rbn_pkg_delete_alt") %>"   style="vertical-align:middle;border-width:0"/>
                            <%=GetLangSpecText("ecm_rbn_pkg_delete") %>
                        </a></span>
                    </td>
                </tr>
                <tr>
                    <td style="height:25px;text-align:left" class="sectionitem">
                        <span class="sectionitem"><a href="javascript:ExecuteActionForSelectedRow('_sys_run_package')"
                            class="sectionitem">
                            <img src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/icon-package-install.png"
                                alt="<%=GetLangSpecText("ecm_rbn_pkg_run_alt") %>"   style="vertical-align:middle;border-width:0" />
                            <%=GetLangSpecText("ecm_rbn_pkg_run")%></a></span>
                    </td>
                    <td style="height:25px;text-align:left" class="sectionitem">
                        <span class="sectionitem"><a href="javascript:ExecuteActionForSelectedRow('_sys_uninstall_package')"
                            class="sectionitem">
                            <img src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/icon-package-uninstall.png"
                                  style="vertical-align:middle;border-width:0" alt="<%=GetLangSpecText("ecm_rbn_pkg_uninstall_alt") %>" />
                            <%=GetLangSpecText("ecm_rbn_pkg_uninstall")%></a></span>
                    </td>
                    <td style="height:25px;text-align:left" class="sectionitem">
                        <span class="sectionitem"><a href="javascript:ExecuteActionForSelectedRow('_sys_package_history')"
                            class="sectionitem">
                            <img src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/icon-package-history.png"
                                alt="<%=GetLangSpecText("ecm_rbn_pkg_history_alt") %>"  style="vertical-align:middle;border-width:0"/>
                            <%=GetLangSpecText("ecm_rbn_pkg_history")%></a></span>
                    </td>
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
            <%=GetLangSpecText("ec_rbn_wf_actions") %>
        </div>
    </div>
    <div style="width: 85px;" class="divMenu">
        <div class="divTopImage">
            <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 0; border-collapse: collapse; border: 0px solid;">
                <tr>
                    <td style="height: 25px; text-align: center; padding: 2px">
            <a href="javascript:ExecuteAction('_sys_organize')" class="sectionitem">
                <img src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/icon-organize-items.png"
                    width="36" height="36" style="border-width:0" alt="<%=GetLangSpecText("ec_rbn_wf_organize") %>" /></a>
                        </td>
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
            <%=GetLangSpecText("ec_rbn_wf_organize")%>
        </div>
    </div>
    <div style="width: 85px;" class="divMenu">
        <div class="divTopImage">
            <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 0; border-collapse: collapse; border: 0px solid;">
                <tr>
                    <td style="height: 25px; text-align: center; padding: 2px">
            <a href="javascript:ExecuteSettingsActionFlag('_sys_security_settings')" class="sectionitem">
                <img src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/icon-settings.png"
                    width="36" height="36"  style="border-width:0" alt="<%=GetLangSpecText("ec_rbn_nl_security_alt") %>" />
            </a>
                        </td>
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
            <%=GetLangSpecText("ec_rbn_wf_settings") %>
        </div>
    </div>
</div>
