<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.GridConfigurationsRibbonBar"
    CodeFile="GridConfigurationsRibbonBar.ascx.cs" %>
<link href="<%=templateThemeDirectory%>Common/StyleSheet/Global.css" rel="stylesheet"
    type="text/css" />

<%--Showing the Action Bar in the Div Element - Start--%>
        <div class="breadcrumb" >		                          
            <div class="actionItem"></div>   
            <div id="actionBarDiv" class="actionBarDiv"></div>
        </div>
<%--Showing the Action Bar in the Div Element - End--%>

<script type="text/javascript" >
    function ExecuteSettingsActionFlag(command) {
        LocalizeMessages();
        var flag = document.getElementById("gridframe").contentWindow.IsRowSelected();
        if (flag) {
            document.getElementById("gridframe").contentWindow.ExecuteActionForSelectedRow(command);
        }
        else {
            document.getElementById("gridframe").contentWindow.ExecuteActionByName(command);
        }

        HideSubItemsActionBar();

        if (command == "_sys_security_settings") {
            GridConfigjsonObj = "";
            LoadActionBar();
        }
    }
    function ExecuteAction(command) {
        LocalizeMessages();
        document.getElementById("gridframe").contentWindow.ExecuteActionByName(command);
        HideSubItemsActionBar();
    }

    function ExecuteActionForSelectedRow(command) {
        //added  for localization
        LocalizeMessages();
        document.getElementById("gridframe").contentWindow.ExecuteActionForSelectedRow(command);
        HideSubItemsActionBar();
    }
    function LocalizeMessages() {
        document.getElementById("gridframe").contentWindow.norightforaction = '<%=GetLangSpecText("ec_rbn_wf_norightforaction")%>';
        document.getElementById("gridframe").contentWindow.sysDel = '<%=GetLangSpecText("ec_rbn_wf_sysdelete")%>';
        document.getElementById("gridframe").contentWindow.cannotOWF = '<%=GetLangSpecText("ec_rbn_wf_norightstoeditpublishedform")%>';
        document.getElementById("gridframe").contentWindow.cannotOWFD = '<%=GetLangSpecText("ec_rbn_wf_norightstodesignpublishedform")%>';
        document.getElementById("gridframe").contentWindow.cannotOWFP = '<%=GetLangSpecText("ec_rbn_wf_norightstorepublishform")%>';
        document.getElementById("gridframe").contentWindow.cannotPerDisable = '<%=GetLangSpecText("ec_rbn_wf_cannotperformondisabled")%>';
        document.getElementById("gridframe").contentWindow.noRowSelected = '<%=GetLangSpecText("ec_rbn_wf_norowselected")%>';
        document.getElementById("gridframe").contentWindow.associationforWFonly = '<%=GetLangSpecText("ec_rbn_wf_associationforWFonly")%>';
        document.getElementById("gridframe").contentWindow.norightforaction = '<%=GetLangSpecText("ec_rbn_wf_norightforaction")%>';
        document.getElementById("gridframe").contentWindow.sysDel = '<%=GetLangSpecText("ec_rbn_wf_sysdelete")%>';
        document.getElementById("gridframe").contentWindow.NotAbleToEditFolder = '<%=GetLangSpecText("ec_rbn_nav_noedit_folder")%>';
        document.getElementById("gridframe").contentWindow.designonlyforForm = '<%=GetLangSpecText("ec_rbn_wf_designonlyforWF")%>';
        document.getElementById("gridframe").contentWindow.viewdesignOnlyForFL = '<%=GetLangSpecText("ec_rbn_wf_viewdesignOnlyForWF")%>';
    }

    /* Hiding the Sub items of the Action Bar */
    function HideSubItemsActionBar() {
        ActionBar.hideSubMenus();
        LoadActionBar();
    }

    /* Showing the Right Action Bar */
    function LoadRightActionBar() {

        if (ActionBar._rightMenu) {
            ActionBar.hideRightMenu();
        }
        ActionBar.showRightMenu(RightGridConfigjsonObj);
    }


    var GridConfigjsonObj =
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
                            "Text": "<%=GetLangSpecText("sk_gridconfig_rbn_new")%>",
                            "Tooltip": "<%=GetLangSpecText("sk_gridconfig_rbn1") %>",
                            "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Data-Grid.png",
                            "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Data-Grid.png",
                            "Action": "javascript:ExecuteAction('_sys_new')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        },                                                                  
                        {
                            "Id": "799F6317-9BD8-4141-9408-7F32EDB47B64",
                            "Text": "<%=GetLangSpecText("ec_rbn_wf_newfolder") %>",
                            "Tooltip": "<%=GetLangSpecText("ec_rbn_nl_folder") %>",
                            "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Folder.png",
                            "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Folder.png",
                            "Action": "javascript:ExecuteAction('_sys_newfolder')",
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
                     "Text": " <%=GetLangSpecText("sk_gridconfig_rbn_organizetxt") %>",
                     "Tooltip": "<%=GetLangSpecText("sk_gridconfig_rbn_organize") %>",
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


       var RightGridConfigjsonObj =
                [
                    {
                        "Edit":
                            {
                                "Id": "5987319E-C0E4-4142-9C01-53389025A3BF",
                                "Text": "<%=GetLangSpecText("sk_gridconfig_rbn_edit")%>",
                                "Tooltip": "<%=GetLangSpecText("ec_rbn_grd_ctl_edit") %>",
                                "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Edit.png",
                                "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Edit.png",
                                "Action": "javascript:ExecuteActionForSelectedRow('_sys_edit')",
                                "OpenMode": "Popup",
                                "SubItems": []
                            }
                    },

                    {
                        "View":
                            {
                                "Id": "5987319E-C0E4-4142-9C01-53389025A3BF",
                                "Text": "<%=GetLangSpecText("sk_gridconfig_rbn_view")%>",
                                "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_actionsView") %>",
                                "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-View.png",
                                "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-View.png",
                                "Action": "javascript:ExecuteActionForSelectedRow('_sys_view_item_details')",
                                "OpenMode": "Popup",
                                "SubItems": []
                            }
                   },
                   {
                        "Delete":
                            {
                                "Id": "75211C43-A0E2-4BF5-A182-3B5D78E74700",
                                "Text": "<%=GetLangSpecText("sk_gridconfig_rbn_delete")%>",
                                "Tooltip": "<%=GetLangSpecText("Delete Grid Configuration")%>",
                                "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Delete.png",
                                "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Delete.png",
                                "Action": "javascript:ExecuteActionForSelectedRow('_sys_delete')",
                                "OpenMode": "Popup",
                                "SubItems": []
                            }
                    },

            {
                "ChangeOwner":
                    {
                        "Id": "7EF94379-B3A2-4554-97CB-F09952CF7666",
                        "Text": "<%=GetLangSpecText("ec_rbn_wf_changeowner") %>",
                        "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_changeowner_alttext") %>",
                        "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Change-Owner.png",
                        "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Change-Owner.png",
                        "Action": "javascript:ExecuteActionForSelectedRow('_sys_change_owner')",
                        "OpenMode": "Popup",
                        "SubItems": []
                    }


            }
        ];

            //Function for loading the action bar 
            function LoadActionBar() {
                ActionBar.init(GridConfigjsonObj, "actionBarDiv");
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
    <div style="width: 200px;" class="divMenu">
        <div class="divTopImage">
            <table style="width:100%;height:65px;border-width:0;border-spacing:2px;border-collapse:separate" >
                <tr>
                    <td style="height:25px;text-align:left">
                        <a href="javascript:ExecuteAction('_sys_new')" class="sectionitem">
                            <img hspace="2" align="absmiddle" src="<%=templateThemeDirectory%>/Repository/ListControl/images/icons-ribbon/GridConfig.png"
                                border="0" alt="<%=GetLangSpecText("sk_gridconfig_rbn1") %>" height="23" width="23" />
                            <%=GetLangSpecText("sk_gridconfig_rbn_new")%></a>
                    </td>
                </tr>
                <tr>
                    <td style="height:25px;text-align:left">
                        <span><a href="javascript:ExecuteAction('_sys_newfolder')" class="sectionitem">
                            <img alt="<%=GetLangSpecText("ec_rbn_nl_folder") %>" src="<%=templateThemeDirectory %>Repository/ListControl/images/icons-ribbon/icon-new-folder.png"
                                border="0" height="23" width="23" align="absmiddle" />
                            <%=GetLangSpecText("ec_rbn_wf_newfolder") %>
                        </a></span>
                    </td>
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
            <%=GetLangSpecText("ecm_rbn_pkgtemp_new")%>
        </div>
    </div>
    <div style="width: 280px;" class="divMenu">
        <div class="divTopImage">
            <table style="width:100%; height:65px;border-width:0;border-spacing:2px;border-collapse:separate">
                <tr>
                    <td style="height:25px;text-align:left">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_edit')" class="sectionitem">
                            <img alt="<%=GetLangSpecText("ec_rbn_grd_ctl_edit") %>" hspace="2" src="<%=templateThemeDirectory%>/Repository/ListControl/images/icons-ribbon/icon-edit.png"
                                align="absmiddle" border="0" /><%=GetLangSpecText("sk_gridconfig_rbn_edit")%></a></span>
                    </td>
                    <td style="height:25px;text-align:left">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_view_item_details')"
                            class="sectionitem">
                            <img alt="<%=GetLangSpecText("ec_rbn_wf_actionsView") %>" hspace="2" src="<%=templateThemeDirectory%>/Repository/ListControl/images/icons-ribbon/icon-view-item.png"
                                align="absmiddle" border="0" /><%=GetLangSpecText("sk_gridconfig_rbn_view")%></a></span>
                    </td>
                </tr>
                <tr>
                    <td style="height:25px;text-align:left">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_delete')" class="sectionitem">
                            <img alt="<%=GetLangSpecText("Delete Grid Configuration")%>" hspace="2" src="<%=templateThemeDirectory%>/Repository/ListControl/images/icons-ribbon/delete.png"
                                align="absmiddle" border="0" /><%=GetLangSpecText("sk_gridconfig_rbn_delete")%></a></span>
                    </td>
                    <td style="height:25px;text-align:left">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_change_owner')" class="sectionitem">
                            <img alt="<%=GetLangSpecText("ec_rbn_wf_changeowner_alttext")%>" hspace="2" src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/changeowner.png"
                                align="absmiddle" border="0" /><%=GetLangSpecText("ec_rbn_wf_changeowner")%></a></span>
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
                <img src="<%=templateThemeDirectory %>Repository/ListControl/images/icons-ribbon/icon-organize-items.png"
                    width="36" height="36" border="0" alt="<%=GetLangSpecText("sk_gridconfig_rbn_organize") %>" /></a>
                         </td>
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
            <%=GetLangSpecText("sk_gridconfig_rbn_organizetxt") %>
        </div>
    </div>
    <div style="width: 85px;" class="divMenu">
        <div class="divTopImage">
             <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 0; border-collapse: collapse; border: 0px solid;">
                <tr>
                    <td style="height: 25px; text-align: center; padding: 2px">
            <a href="javascript:ExecuteSettingsActionFlag('_sys_security_settings')" class="sectionitem">
                <img src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/icon-settings.png"
                    width="36" height="36" border="0" alt="<%=GetLangSpecText("ec_rbn_nl_security_alt") %>" />
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
