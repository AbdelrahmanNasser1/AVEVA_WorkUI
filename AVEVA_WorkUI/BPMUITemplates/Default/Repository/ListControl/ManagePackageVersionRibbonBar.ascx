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

    var RightManagePackageJsonObj =
                  [

                        {
                            "Run":
                                {
                                    "Id": "91BCE64E-56F7-4750-BCFB-B5A5F60BAD11",
                                    "Text": " <%=GetLangSpecText("ecm_rbn_pkg_run")%>",
                                    "Tooltip": "<%=GetLangSpecText("ecm_rbn_pkg_run_alt") %>",
                                    "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-Install.png",
                                    "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Install.png",
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
                                "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-Uninstall.png",
                                "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Uninstall.png",
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
                                "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-Edit.png",
                                "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Edit.png",
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
                                "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-View.png",
                                "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-View.png",
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
                                "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-Delete.png",
                                "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Delete.png",
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
                                "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-generate-package.png",
                                "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-generate-package.png",
                                "Action": "javascript:ExecuteActionForSelectedRow('_sys_package_history')",
                                "OpenMode": "Popup",
                                "SubItems": []
                            }
                        }
                  ];


    /* Showing the Right Action Bar */
    function LoadRightActionBar()
    {

        if (ActionBar._rightMenu) {
            ActionBar.hideRightMenu();
        }

        ActionBar.showRightMenu(RightManagePackageJsonObj);

    }
</script>
<div style="width: 100%; height: 100%;display:none;" class="divMain">
    <div class="divMenu" style="width: 320px;">
        <div class="divTopImage">
            <table style="width:310px;height:65px;border-width:0;border-spacing:2px;border-collapse:separate">
                <tr>
                    <td style="height:25px;text-align:left" class="sectionitem">
                        <a  href="javascript:ExecuteActionForSelectedRow('_sys_edit_settingsform')" class="sectionitem"><img src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/icon-edit.png"
                            alt="<%=GetLangSpecText("ecm_rbn_pkg_edit_alt") %>"  style="vertical-align:middle;border-width:0" /> <%=GetLangSpecText("Edit") %></a>
                    </td>
                    <td style="height:25px;text-align:left" class="sectionitem">
                        <a href="javascript:ExecuteActionForSelectedRow('_sys_view_package')" class="sectionitem"><img src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/icon-view-item.png"
                            alt="<%=GetLangSpecText("ecm_rbn_pkg_view_alt") %>"  style="vertical-align:middle;border-width:0" /> <%=GetLangSpecText("View") %></a>
                    </td>
                    <td style="text-align:left" class="sectionitem">
                        <span class="sectionitem"> 
                        <a href="javascript:ExecuteActionForSelectedRow('_sys_delete')"
                                    class="sectionitem"><img src="<%=ThemeURL%>/Repository/ListControl/images/icons-ribbon/delete.png"
                            alt="<%=GetLangSpecText("ecm_rbn_pkg_delete_alt") %>"  style="vertical-align:middle;border-width:0" /> <%=GetLangSpecText("ec_rbn_wf_delete") %>
                                </a></span>
                    </td>
                </tr>
                <tr>
                    <td style="height:25px;text-align:left" class="sectionitem">
                        <a href="javascript:ExecuteActionForSelectedRow('_sys_run_package')" class="sectionitem"><img src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/icon-package-install.png"
                            alt="<%=GetLangSpecText("ecm_rbn_pkg_run_alt") %>"  style="vertical-align:middle;border-width:0"  /> <%=GetLangSpecText("ecm_rbn_pkg_run") %></a>
                    </td>
                    <td style="height:25px;text-align:left" class="sectionitem">
                        <a href="javascript:ExecuteActionForSelectedRow('_sys_uninstall_package')" class="sectionitem"><img src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/icon-package-uninstall.png"
                            alt="<%=GetLangSpecText("ecm_rbn_pkg_uninstall_alt") %>"  style="vertical-align:middle;border-width:0"  /> <%=GetLangSpecText("ec_rbn_package_uninstall")%></a>
                    </td>
                    <td style="height:25px;text-align:left" class="sectionitem">
                        <a  href="javascript:ExecuteActionForSelectedRow('_sys_package_history')" class="sectionitem"><img src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/icon-package-history.png"
                            alt="<%=GetLangSpecText("ecm_rbn_pkg_history_alt") %>"  style="vertical-align:middle;border-width:0"  /> <%=GetLangSpecText("ecm_rbn_pkg_history") %></a>
                    </td>
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
            <%=GetLangSpecText("ec_rbn_wf_actions") %>
        </div>
    </div>
</div>
