<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ManageViewsRibbonbar.ascx.cs"
    Inherits="ManageViewsRibbonbar.ManageViewsRibbonbar" %>
<link href="<%=ThemeURL%>Common/StyleSheet/Global.css" rel="stylesheet" />

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

        if (command == "_sys_security_settings") {
            ManageViewsjsonObj = "";
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
        document.getElementById("gridframe").contentWindow.NotAbleToEditFolder = '<%=GetLangSpecText("ec_rbn_nav_noedit_folder")%>';
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
        ActionBar.showRightMenu(ManageViewsRightJsonObj);
    }

    var ManageViewsjsonObj =
        [
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

    var ManageViewsRightJsonObj =
                [
                        {
                            "Edit":
                                {
                                    "Id": "5987319E-C0E4-4142-9C01-53389025A3BF",
                                    "Text": "<%=GetLangSpecText("ec_rbn_wf_edit")%>",
                                    "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_edit")%>",
                                    "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-Edit.png",
                                    "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Edit.png",
                                    "Action": "javascript:ExecuteActionForSelectedRow('_sys_edit')",
                                    "OpenMode": "Popup",
                                    "SubItems": []
                                }
                        },
                        {
                            "View":
                               {
                                   "Id": "D147D7FA-2307-4C2C-B1D7-A9A8B6D71C3E",
                                   "Text": "<%=GetLangSpecText("ec_rbn_wf_viewitemdetails")%>",
                                   "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_viewitemdetails")%>",
                                   "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-View.png",
                                   "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-View.png",
                                   "Action": "javascript:ExecuteActionForSelectedRow('_sys_view_item_details')",
                                   "OpenMode": "Popup",
                                   "SubItems": []
                               }
                        },
                        {
                            "Delete":
                               {
                                   "Id": "75211C43-A0E2-4BF5-A182-3B5D78E74700",
                                   "Text": "<%=GetLangSpecText("ec_rbn_wf_delete") %>",
                                   "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_delete") %>",
                                   "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-Delete.png",
                                   "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Delete.png",
                                   "Action": "javascript:ExecuteActionForSelectedRow('_sys_delete')",
                                   "OpenMode": "Popup",
                                   "SubItems": []
                               }
                        }

                ];


    //Function for loading the action bar 
    function LoadActionBar() {
        ActionBar.init(ManageViewsjsonObj, "actionBarDiv");
    }

    //Loading the Action Bar 
    LoadActionBar();

</script>
<div style="width: 100%; height: 100%;white-space:nowrap;display:none;" class="divMain">
    <div class="divMenu" style="width: 170px;">
        <div class="divTopImage">
            <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 2px; border-collapse: separate">
                <tr>
                    <td  style="text-align:left">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_edit')" class="sectionitem">
                            <img src="<%=ThemeURL%>/Repository/ListControl/images/icons-ribbon/icon-edit.png"
                                 width="23" height="23" style="vertical-align: middle" border="0" alt="<%=GetLangSpecText("ec_rbn_wf_newlist_edit_alttext") %>" />
                            <%=GetLangSpecText("ec_rbn_wf_edit")%></a></span>
                    </td>
                    <td style="text-align:left">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_delete')" class="sectionitem">
                            <img src="<%=ThemeURL%>/Repository/ListControl/images/icons-ribbon/delete.png" 
                                style="vertical-align: middle" border="0" alt="<%=GetLangSpecText("ec_rbn_wf_newlist_delete_alttext") %>" />
                            <%=GetLangSpecText("ec_rbn_wf_delete") %></a></span>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:left">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_view_item_details')"
                            class="sectionitem">
                            <img src="<%=ThemeURL%>/Repository/ListControl/images/icons-ribbon/icon-view-item.png"
                                width="23" height="23" style="vertical-align: middle"  border="0" alt="<%=GetLangSpecText("ec_rbn_wf_newlist_view_alttext") %>" />
                            <%=GetLangSpecText("ec_rbn_wf_viewitemdetails")%>
                        </a></span>
                    </td>
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
            <%=GetLangSpecText("ec_rbn_wf_actions") %>
            
        </div>
    </div>
    <div style="width: 80px;" class="divMenu">
        <div class="divTopImage">
            <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 0; border-collapse: collapse; border: 0px solid;">
                <tr>
                    <td style="height: 25px; text-align: center; padding: 2px">
                        <a href="javascript:ExecuteSettingsActionFlag('_sys_security_settings')" class="sectionitem">
                            <img src="<%=ThemeURL%>/Repository/ListControl/images/icons-ribbon/icon-settings.png"
                                style="border-width: 0" width="36" height="36" alt="<%=GetLangSpecText("ec_rbn_nl_security_alt") %>" />
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
