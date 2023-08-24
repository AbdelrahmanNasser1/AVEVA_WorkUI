<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.AuthenticationUserRibbonBar" %>
<link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemeURL)%>Common/StyleSheet/Global.css" rel="stylesheet" />

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
            UsersjsonObj = "";
            LoadActionBar();
        }
    }
    function ExecuteAction(command) {
        LocalizeMessages();
        document.getElementById("gridframe").contentWindow.ExecuteActionByName(command);
        HideSubItemsActionBar();
        //IE    document.frames("gridframe").ExecuteActionByName(command);
    }

    function ExecuteActionForSelectedRow(command) {
        LocalizeMessages();
        document.getElementById("gridframe").contentWindow.ExecuteActionForSelectedRow(command);
        HideSubItemsActionBar();
        //IE    document.frames("gridframe").ExecuteActionForSelectedRow(command);
    }
    function LocalizeMessages() {
        document.getElementById("gridframe").contentWindow.cannotPerDisable = '<%=GetLangSpecText("ec_rbn_wf_cannotperformondisabled")%>';
        document.getElementById("gridframe").contentWindow.noRowSelected = '<%=GetLangSpecText("ec_rbn_wf_norowselected")%>';
        document.getElementById("gridframe").contentWindow.norightforaction = '<%=GetLangSpecText("ec_rbn_wf_norightforaction")%>';
        document.getElementById("gridframe").contentWindow.sysDel = '<%=GetLangSpecText("ec_rbn_wf_sysdelete")%>';
        document.getElementById("gridframe").contentWindow.NotAbleToEditFolder = '<%=GetLangSpecText("ec_rbn_nav_noedit_folder")%>';
    }
    /*function RefreshGrid(){
    document.getElementById("gridframe").contentWindow.RefreshGrid();
    }*/

    /* Hiding the Sub items of the Action Bar */
    function HideSubItemsActionBar() {
        ActionBar.hideSubMenus();
    }

    /* Showing the Right Action Bar */
    function LoadRightActionBar() {

        if (ActionBar._rightMenu) {
            ActionBar.hideRightMenu();
        }
        ActionBar.showRightMenu(RightUsersJsonObj);
    }

    var UsersjsonObj =
        [                   
            {
                "New": {
                    "Id": "E53C245D-E05B-4D4F-820D-40AD26479887",
                    "Text": "<%=GetLangSpecText("ec_rbn_au_new")%>",
                    "Tooltip": "<%=GetLangSpecText("ec_rbn_au_new_alttext")%>",
                    "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-New.png",
                    "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-New.png",
                    "Action": "javascript:ExecuteAction('_sys_new')",
                    "OpenMode": "Popup",
                    "SubItems": [ ]
                }
            },
            
            {
                "Security":
                {
                    "Id": "777397CB-1B26-4DBF-ACB0-2BEB0F551856",
                    "Text": "<%=GetLangSpecText("ec_rbn_wf_settings") %>",
                    "Tooltip": "<%=GetLangSpecText("ec_rbn_nl_security_alt") %>",
                    "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-Security.png",
                    "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Security.png",
                    "Action": "javascript:ExecuteSettingsActionFlag('_sys_security_settings')",
                    "OpenMode": "Popup",
                    "SubItems":
                    [

                    ]
                }
            }

        ];


    var RightUsersJsonObj =
                [
                    {
                        "Edit":
                            {
                                "Id": "5987319E-C0E4-4142-9C01-53389025A3BF",
                                "Text": "<%=GetLangSpecText("ec_rbn_au_edit")%>",
                                "Tooltip": "<%=GetLangSpecText("ec_rbn_au_edit_alttext")%>",
                                "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-Edit.png",
                                "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Edit.png",
                                "Action": "javascript:ExecuteActionForSelectedRow('_sys_edit')",
                                "OpenMode": "Popup",
                                "SubItems": []
                            }

                    },

                    {
                        "Delete":
                            {
                                "Id": "75211C43-A0E2-4BF5-A182-3B5D78E74700",
                                "Text": "<%=GetLangSpecText("ec_rbn_au_delete")%>",
                                "Tooltip": "<%=GetLangSpecText("ec_rbn_au_delete_alttext")%>",
                                "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-Delete.png",
                                "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Delete.png",
                                "Action": "javascript:ExecuteActionForSelectedRow('_sys_delete')",
                                "OpenMode": "Popup",
                                "SubItems": []
                            }
                    },

                    {
                        "ChangeOwner":
                            {
                                "Id": "7EF94379-B3A2-4554-97CB-F09952CF7666",
                                "Text": "<%=GetLangSpecText("ec_rbn_au_changeowner")%>",
                                "Tooltip": "<%=GetLangSpecText("ec_rbn_au_changeowner_alttext")%>",
                                "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-Change-Owner.png",
                                "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Change-Owner.png",
                                "Action": "javascript:ExecuteActionForSelectedRow('_sys_change_owner')",
                                "OpenMode": "Popup",
                                "SubItems": []
                            }


                    }

                    
                ];

    //Function for loading the action bar 
    function LoadActionBar() {
        ActionBar.init(UsersjsonObj, "actionBarDiv");
    }

    //Loading the Action Bar 
    LoadActionBar();

</script>
<div style="width: 100%; height: 100%;white-space:nowrap;display:none;" class="divMain">
    <div class="divMenu" style="width: 80px;">
        <div class="divTopImage" style="width: 100%">
            <table style="width: 100%; height:65px; border-width: 0; border-spacing: 0; border-collapse: collapse; border: 0px solid;">
                <tr>
                    <td style="height: 25px; text-align: center; padding: 2px">
                        <a href="javascript:ExecuteAction('_sys_new')" class="sectionitem">
                            <img alt="<%=GetLangSpecText("ec_rbn_au_new_alttext")%>" src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/SAP-newConnection.png"
                              style="border-width:0" width="36" height="36" />
                        </a>
                    </td>
                    </tr>
                </table>
        </div>
        <div class="sectiontitle divdowntext">
            <%=GetLangSpecText("ec_rbn_au_new")%>
        </div>
    </div>
    <!-- Start Actions -->
    <div style="width: 170px;" class="divMenu">
        <div class="divTopImage">
            <table style="width:100%;height:65px;border-width:0;border-collapse:separate;border-spacing:2px">
                <tr>
                    <td style="text-align:left;height:25px">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_edit')" class="sectionitem">
                            <img alt="<%=GetLangSpecText("ec_rbn_au_edit_alttext")%>" src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/icon-edit.png"
                                style="vertical-align:middle;border-width:0" width="23" height="23" />
                            <%=GetLangSpecText("ec_rbn_au_edit")%>
                        </a></span>
                    </td>
                    <td style="text-align:left;height:25px">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_delete')" class="sectionitem">
                            <img alt="<%=GetLangSpecText("ec_rbn_au_delete_alttext")%>" src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/delete.png"
                                style="vertical-align:middle;border-width:0" width="23" height="23" />
                            <%=GetLangSpecText("ec_rbn_au_delete")%>
                        </a></span>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="height:25px;text-align:left">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_change_owner')" class="sectionitem">
                            <img alt="<%=GetLangSpecText("ec_rbn_au_changeowner_alttext")%>" src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/changeowner.png"
                                style="vertical-align:middle;border-width:0" width="22" height="22" />
                                    <%=GetLangSpecText("ec_rbn_au_changeowner")%></a></span>
                    </td>
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
            <%=GetLangSpecText("ec_rbn_au_actions")%>
        </div>
    </div>
    <!-- End Actions -->
    <div style="width: 80px;" class="divMenu">
        <div class="divTopImage">
            <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 0; border-collapse: collapse; border: 0px solid;">
                <tr>
                    <td style="height: 25px; text-align: center; padding: 2px">
            
            <a href="javascript:ExecuteSettingsActionFlag('_sys_security_settings')" class="sectionitem">
                <img src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/icon-settings.png"
                    width="35" height="37" style="border-width:0" alt="<%=GetLangSpecText("ec_rbn_nl_security_alt") %>" />
            </a>
                        </td>
                    </tr>
                </table>
        </div>
        <div class="sectiontitle divdowntext">
            <%=GetLangSpecText("ec_rbn_au_settings") %>
        </div>
    </div>
</div>
