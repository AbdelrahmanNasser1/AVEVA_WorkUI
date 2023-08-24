<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.GridViewsRibbonBar"
    CodeFile="GridViewsRibbonBar.ascx.cs" %>
<link href="<%=templateThemeDirectory%>Common/StyleSheet/Global.css" rel="stylesheet"
    type="text/css" />
<!--[if lt IE 7]>
  <script defer type="text/javascript" src="scripts/pngfix.js"></script>
  <![endif]-->

<%--Showing the Action Bar in the Div Element - Start--%>
        <div class="breadcrumb" >		                          
            <div class="actionItem"></div>   
            <div id="actionBarDiv" class="actionBarDiv"></div>
        </div>
<%--Showing the Action Bar in the Div Element - End--%>


<script type="text/javascript">
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
            GridViewsjsonObj = "";
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
    }

    /* Showing the Right Action Bar */
    function LoadRightActionBar() {

        if (ActionBar._rightMenu) {
            ActionBar.hideRightMenu();
        }
        ActionBar.showRightMenu(RightGridViewsjsonObj);
    }


    var GridViewsjsonObj =
        [
            {
                "New": {
                "Id": "E53C245D-E05B-4D4F-820D-40AD26479887",
                "Text": "<%=GetLangSpecText("ec_rbn_au_new")%>",
                "Tooltip": "<%=GetLangSpecText("ec_rbn_grid_ctl_newView") %>",
                "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-New.png",
                "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-New.png",
                "Action": "javascript:ExecuteAction('_sys_new')",
                "OpenMode": "Popup",
                "SubItems": []
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


    var RightGridViewsjsonObj =
        [
            {
                "Edit":
                    {
                        "Id": "5987319E-C0E4-4142-9C01-53389025A3BF",
                        "Text": "<%=GetLangSpecText("ec_rbn_grd_ctl_edit")%>",
                        "Tooltip": "<%=GetLangSpecText("ec_rbn_grd_ctl_edit")%>",
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
                        "Text": "<%=GetLangSpecText("ec_rbn_grdview_View")%>",
                        "Tooltip": "<%=GetLangSpecText("ec_rbn_grdview_View")%>",
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
                        "Text": "<%=GetLangSpecText("ec_rbn_grdview_delete")%>",
                        "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_deletegrdview_alttext") %>",
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
            ActionBar.init(GridViewsjsonObj, "actionBarDiv");
        }

        //Loading the Action Bar 
        LoadActionBar();

</script>
<div style="width: 100%; height: 100%;display:none;" class="divMain">
    <div class="divMenu" style="width: 100px;">
        <div class="divTopImage" style="width: 100%">
    <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 0; border-collapse: collapse; border: 0px solid;">
                <tr>
                    <td style="height: 25px; text-align: center; padding: 2px">
            <a href="javascript:ExecuteAction('_sys_new')" class="sectionitem"  >
                <img alt="<%=GetLangSpecText("ec_rbn_grid_ctl_newView") %>" src="<%=templateThemeDirectory %>Repository/ListControl/images/icons-ribbon/form-default.png"
                   style="vertical-align:middle;border-width:0" height="23" width="23" /><%=GetLangSpecText("ec_rbn_grid_ctl_newView")%></a>
            </td>
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
            <%=GetLangSpecText("ec_rbn_grid_ctl_new") %>
        </div>
    </div>
    <div style="width: 250px;" class="divMenu">
        <div class="divTopImage">
            <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 0; border-collapse: collapse; border: 0px solid;">
                <tr>
                    <td style="text-align:left">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_edit')" class="sectionitem">
                            <img alt="<%=GetLangSpecText("ec_rbn_grd_ctl_edit")%>" src="<%=templateThemeDirectory %>Repository/ListControl/images/icons-ribbon/icon-edit.png"
                                hspace="0" align="absmiddle" border="0" height="23" width="23" />
                            <%=GetLangSpecText("ec_rbn_grd_ctl_edit")%>
                        </a></span>
                    </td>
                    <td  style="text-align:left">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_view_item_details')"
                            class="sectionitem">
                            <img alt="<%=GetLangSpecText("ec_rbn_grdview_View")%>" src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/icon-view-item.png"
                                hspace="0" align="absmiddle" border="0" height="23" width="23" />
                            <%=GetLangSpecText("ec_rbn_grdview_View")%>
                        </a></span>
                    </td>
                </tr>
                <tr>
                    <td  style="text-align:left">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_delete')" class="sectionitem">
                            <img alt=" <%=GetLangSpecText("ec_rbn_wf_deletegrdview_alttext") %>" src="<%=templateThemeDirectory %>Repository/ListControl/images/icons-ribbon/delete.png"
                                hspace="0" align="absmiddle" border="0" width="23" height="23" />
                            <%=GetLangSpecText("ec_rbn_grdview_delete")%>
                        </a></span>
                    </td>
                    <td  style="height:31px;text-align:left">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_change_owner')" class="sectionitem">
                            <img alt="<%=GetLangSpecText("ec_rbn_wf_changeowner_alttext") %>" src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/changeowner.png"
                                hspace="0" align="absmiddle" border="0" height="23" width="23" /><span>
                                    <%=GetLangSpecText("ec_rbn_wf_changeowner") %></a></span>
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
            <a href="javascript:ExecuteSettingsActionFlag('_sys_security_settings')" class="sectionitem">
                <img src="<%=templateThemeDirectory %>Repository/ListControl/images/icons-ribbon/icon-settings.png"
                    width="35" height="37" style="border-width:0" alt="<%=GetLangSpecText("ec_rbn_nl_security_alt") %>" />
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
