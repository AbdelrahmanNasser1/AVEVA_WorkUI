<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.Bpm.ArchestrAEvents.ArchestrAEventsListGrid" %>
<link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(themeURL)%>Common/StyleSheet/Global.css" />

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
            PackageTemplatejsonObj = "";
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
        document.getElementById("gridframe").contentWindow.NotAbleToViewFolder = '<%=GetLangSpecText("ec_rbn_nav_noview_folder")%>';
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

        ActionBar.showRightMenu(RightPackageTemplateJsonObj);

    }


    var PackageTemplatejsonObj =
        [

            {
                "Up":
                {
                    "Id": "498D4CBB-2446-493D-983A-8DFF0BD20AD8",
                    "Text": " <%=GetLangSpecText("ec_rbn_wf_navigate") %>",
                    "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_navigate_alt") %>",
                    "Image": "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(themeURL, false)%>Repository/ListControl/images/ActionBarIcons/AB-Up.png",
                    "HoverImage": "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(themeURL, false)%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Up.png",
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
                    "Image": "<%=themeURL%>Repository/ListControl/images/ActionBarIcons/AB-New.png",
                    "HoverImage": "<%=themeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-New.png",
                    "Action": "",
                    "OpenMode": "Popup",
                    "SubItems": [
                        {
                            "Id": "80C33179-9B75-4248-A466-DA7F65789C0A",
                            "Text": "<%=GetLangSpecText("ecm_rbn_asbtemp_new") %>",
                            "Tooltip": "<%=GetLangSpecText("ecm_rbn_asbtemp_new_alt") %>",
                            "Image": "<%=themeURL%>Repository/ListControl/images/ActionBarIcons/AB-List.png",
                            "HoverImage": "<%=themeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-List.png",
                            "Action": "javascript:ExecuteAction('_sys_new')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        },

                       {
                           "Id": "799F6317-9BD8-4141-9408-7F32EDB47B64",
                           "Text": "<%=GetLangSpecText("ec_rbn_wf_newfolder") %>",
                           "Tooltip": "<%=GetLangSpecText("ec_rbn_nl_folder") %>",
                           "Image": "<%=themeURL%>Repository/ListControl/images/ActionBarIcons/AB-Folder.png",
                           "HoverImage": "<%=themeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Folder.png",
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
                    "Image": "<%=themeURL%>Repository/ListControl/images/ActionBarIcons/AB-Organize.png",
                    "HoverImage": "<%=themeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Organize.png",
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
                    "Image": "<%=themeURL%>Repository/ListControl/images/ActionBarIcons/AB-Security.png",
                    "HoverImage": "<%=themeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Security.png",
                    "Action": "javascript:ExecuteSettingsActionFlag('_sys_security_settings')",
                    "OpenMode": "Popup",
                    "SubItems":
                    [

                    ]
                }
            }

        ];




            var RightPackageTemplateJsonObj =
                        [

                    {
                        "Edit":
                        {
                            "Id": "5987319E-C0E4-4142-9C01-53389025A3BF",
                            "Text": "<%=GetLangSpecText("ecm_rbn_asb_edit")%>",
                            "Tooltip": "<%=GetLangSpecText("ecm_rbn_asb_edit_alt") %>",
                            "Image": "<%=themeURL%>Repository/ListControl/images/ActionBarIcons/AB-Edit.png",
                            "HoverImage": "<%=themeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Edit.png",
                            "Action": "javascript:ExecuteActionForSelectedRow('_sys_edit')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        }
                    },
                    {
                        "View":
                        {
                            "Id": "D147D7FA-2307-4C2C-B1D7-A9A8B6D71C3E",
                            "Text": "<%=GetLangSpecText("ecm_rbn_asb_view")%>",
                            "Tooltip": "<%=GetLangSpecText("ecm_rbn_asb_view_alt") %>",
                            "Image": "<%=themeURL%>Repository/ListControl/images/ActionBarIcons/AB-View.png",
                            "HoverImage": "<%=themeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-View.png",
                            "Action": "javascript:ExecuteActionForSelectedRow('_sys_view_asb')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        }
                    },

                    {
                        "Delete":
                        {
                            "Id": "75211C43-A0E2-4BF5-A182-3B5D78E74700",
                            "Text": "<%=GetLangSpecText("ecm_rbn_asb_delete")%>",
                            "Tooltip": "<%=GetLangSpecText("ecm_rbn_asb_delete_alt")%>",
                            "Image": "<%=themeURL%>Repository/ListControl/images/ActionBarIcons/AB-Delete.png",
                            "HoverImage": "<%=themeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Delete.png",
                            "Action": "javascript:ExecuteActionForSelectedRow('_sys_delete')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        }
                    }
                ];


                    //Function for loading the action bar 
                    function LoadActionBar() {
                        ActionBar.init(PackageTemplatejsonObj, "actionBarDiv");
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
                <img src="<%=themeURL%>Repository/ListControl/images/icons-ribbon/icon-up.png" style="border-width:0"
                    alt="<%=GetLangSpecText("ec_rbn_wf_navigate_alt") %>" width="36" height="36" />
            </a>
                        </td>
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
            <%=GetLangSpecText("ec_rbn_wf_navigate") %>
        </div>
    </div>
    <div style="width: 170px;" class="divMenu">
        <div class="divTopImage">
            <table style="width:100%;height:65px;border-width:0;border-collapse:separate;border-spacing:2px;">
                <tr>
                    <td style="height:25px;text-align:left">
                        <span><a href="javascript:ExecuteAction('_sys_new')" class="sectionitem">
                            <img alt="<%=GetLangSpecText("ecm_rbn_asb_new_alt") %>" src="<%=themeURL%>Repository/ListControl/images/icons-ribbon/icon-package-new.png"
                                width="26" height="26" style="vertical-align:middle;border-width:0" /><%=GetLangSpecText("ecm_rbn_asb_new") %></a></span>
                    </td>
                </tr>
                <tr>
                    <td style="height:25px;text-align:left">
                        <span><a href="javascript:ExecuteSettingsActionFlag('_sys_newfolder')" class="sectionitem">
                            <img alt="<%=GetLangSpecText("ec_rbn_nl_folder") %>" src="<%=themeURL%>Repository/ListControl/images/icons-ribbon/icon-new-folder.png"
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
    <div style="width: 400px;" class="divMenu">
        <div class="divTopImage">
            <table style="width:100%;height:65px;border-width:0;border-collapse:separate;border-spacing:2px;">
                <tr>
                    <td style="height:25px;text-align:left">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_edit')"
                            class="sectionitem">
                            <img alt="<%=GetLangSpecText("ecm_rbn_asb_edit_alt") %>"  src="<%=themeURL%>/Repository/ListControl/images/icons-ribbon/icon-edit.png"
                              style="vertical-align:middle;border-width:0" /><%=GetLangSpecText("ecm_rbn_asb_edit")%></a></span>
                    </td>
                    <td style="height:25px;text-align:left">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_view_asb')"
                            class="sectionitem">
                            <img alt="<%=GetLangSpecText("ecm_rbn_asb_view_alt") %>"  src="<%=themeURL%>/Repository/ListControl/images/icons-ribbon/icon-view-item.png"
                               style="vertical-align:middle;border-width:0" /><%=GetLangSpecText("ecm_rbn_asb_view")%></a></span>
                    </td>
                    <td style="height:25px;text-align:left">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_delete')" class="sectionitem">
                            <img alt="<%=GetLangSpecText("ecm_rbn_asb_delete_alt")%>"  src="<%=themeURL%>/Repository/ListControl/images/icons-ribbon/delete.png"
                                style="vertical-align:middle;border-width:0" /><%=GetLangSpecText("ecm_rbn_asb_delete")%></a></span>
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
                <img src="<%=themeURL %>Repository/ListControl/images/icons-ribbon/icon-organize-items.png"
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
                <img src="<%=themeURL%>Repository/ListControl/images/icons-ribbon/icon-settings.png"
                    width="36" height="36" style="border-width:0" alt="<%=GetLangSpecText("ec_rbn_nl_security_alt") %>" />
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
