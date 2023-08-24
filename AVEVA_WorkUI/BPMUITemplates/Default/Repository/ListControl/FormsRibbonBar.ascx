<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.FormsRibbonBar" %>
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
            FormsjsonObj = "";
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
    function ExecuteActionForMultiSelectedRow(command) {
        //Added by Harish for localization.
        LocalizeMessages();
        document.getElementById("gridframe").contentWindow.ExecuteActionForMultiSelectedRow(command);
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
        ActionBar.showRightMenu(RightFormsJsonObj);
    }

    function LoadRightActionBarForMultiSelect() {
        if (ActionBar._rightMenu) {
            ActionBar.hideRightMenu();
        }

        ActionBar.showRightMenu(RightFormsJsonObjForMultiSelect);
    }

    var FormsjsonObj =
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
                    "Text": "<%=GetLangSpecText("ec_rbn_form_new") %>",
                    "Tooltip": "<%=GetLangSpecText("ec_rbn_form_new") %>",
                    "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-New.png",
                    "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-New.png",
                    "Action": "",
                    "OpenMode": "Popup",
                    "SubItems": [
                        {
                            "Id": "80C33179-9B75-4248-A466-DA7F65789C0A",
                            "Text": "<%=GetLangSpecText("ec_rbn_wf_ordinary_form") %>",
                            "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_ordinary_form_alttext") %>",
                            "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Form.png",
                            "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Form.png",
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


            var RightFormsJsonObj =
                [

                    {
                        "Design":
                            {

                                "Id": "6A283908-4320-4F79-A18B-C50E38A7E16D",
                                "Text": "<%=GetLangSpecText("ec_rbn_wf_design") %>",
                                "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_designform_alttext") %>",
                                "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Design.png",
                                "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Design.png",
                                "Action": "javascript:ExecuteActionForSelectedRow('_sys_designform')",
                                "OpenMode": "Popup",
                                "SubItems": []
                            }
                    },

                    {
                        "Publish":
                            {
                                "Id": "91BCE64E-56F7-4750-BCFB-B5A5F60BAD11",
                                "Text": " <%=GetLangSpecText("ec_rbn_wf_publish") %>",
                                "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_publish_alttext") %>",
                                "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Publish.png",
                                "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Publish.png",
                                "Action": "javascript:ExecuteActionForSelectedRow('_sys_publish')",
                                "OpenMode": "Popup",
                                "SubItems": []
                            }
                    },

                    {
                        "Unpublish":
                            {
                                "Id": "99B592CA-76EC-4533-AE7A-CF317E0C3AA8",
                                "Text": "<%=GetLangSpecText("ec_rbn_wf_unpublish") %>",
                                "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_unpublish_alttext") %>",
                                "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-UnPublish.png",
                                "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-UnPublish.png",
                                "Action": "javascript:ExecuteActionForSelectedRow('_sys_unpublish')",
                                "OpenMode": "Popup",
                                "SubItems": []
                            }
                    },

                    {
                        "Edit":
                            {
                                "Id": "5987319E-C0E4-4142-9C01-53389025A3BF",
                                "Text": "<%=GetLangSpecText("ec_rbn_wf_edit")%>",
                                "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_edit_alttext")%>",
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
                               "Id": "D147D7FA-2307-4C2C-B1D7-A9A8B6D71C3E",
                               "Text": "<%=GetLangSpecText("ec_rbn_wf_actionsView")%>",
                               "Tooltip": "<%=GetLangSpecText("ec_rbn_wf1_actionsViewform_alttext")%>",
                               "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-View.png",
                               "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-View.png",
                               "Action": "javascript:ExecuteActionForSelectedRow('_sys_preview')",
                               "OpenMode": "Popup",
                               "SubItems": []
                           }
                    },

                    {
                        "Delete":
                           {
                               "Id": "75211C43-A0E2-4BF5-A182-3B5D78E74700",
                               "Text": "<%=GetLangSpecText("ec_rbn_wf_delete") %>",
                               "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_deleteform_alttext") %>",
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
                    },

                    

                {
                    "Associate":
                    {
                        "Id": "3A8EB734-EDBD-46AE-A04D-5973B397E1E8",
                        "Text": " <%=GetLangSpecText("ec_rbn_wf_associate") %>",
                        "Tooltip": "<%=GetLangSpecText("ecm_assn_associate") %>",
                        "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Associate.png",
                        "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Associate.png",
                        "Action": "javascript:ExecuteActionForSelectedRow('_sys_create_assn')",
                        "OpenMode": "Popup",
                        "SubItems":  []
                    }
                }

                ];

            var RightFormsJsonObjForMultiSelect =
             [

                    {
                        "PublishSelected":
                            {
                                "Id": "570ED901-91BE-49E6-B63B-BA5890563EC5",
                                "Text": " <%=GetLangSpecText("ec_rbn_Workflow_MultiPublish") %>",
                                "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_publish_alttext") %>",
                                "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Publish.png",
                                "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Publish.png",
                                "Action": "javascript:ExecuteActionForMultiSelectedRow('_sys_publish')",
                                "OpenMode": "Popup",
                                "SubItems": []
                            }
                    },
                    <%--{
                        "PublishAll":
                            {
                                "Id": "6F138D5F-51F7-4B25-B76A-63B2E6036350",
                                "Text": "Publish All",
                                "Tooltip": "<%=GetLangSpecText("ec_rbn_wf1_publish_alttext") %>",
                                "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Publish.png",
                                "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Publish.png",
                                "Action": "javascript:ExecuteActionForMultiSelectedRow('_sys_publishall')",
                                "OpenMode": "Popup",
                                "SubItems": []
                            }
                    },--%>

                    {
                        "UnPublishSelected":
                            {
                                "Id": "5F079C6A-0C28-41A5-A5D3-1E1E7AD267D0",
                                "Text": "<%=GetLangSpecText("ec_rbn_wf_unpublish") %>",
                                "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_unpublish_alttext") %>",
                                "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-UnPublish.png",
                                "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-UnPublish.png",
                                "Action": "javascript:ExecuteActionForMultiSelectedRow('_sys_unpublish')",
                                "OpenMode": "Popup",
                                "SubItems": []
                            }
                    }<%--,

                    {
                        "UnPublishAll":
                            {
                                "Id": "B9661B00-6A00-4B20-8A4A-A28A82FB5BED",
                                "Text": "UnPublish All",
                                "Tooltip": "<%=GetLangSpecText("ec_rbn_wf1_unpublish_alttext") %>",
                                "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-UnPublish.png",
                                "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-UnPublish.png",
                                "Action": "javascript:ExecuteActionForMultiSelectedRow('_sys_unpublishall')",
                                "OpenMode": "Popup",
                                "SubItems": []
                            }
                    }--%>

             ];

            //Function for loading the action bar 
            function LoadActionBar() {
                ActionBar.init(FormsjsonObj, "actionBarDiv");
            }

            //Loading the Action Bar 
            LoadActionBar();

</script>
<div style="width: 100%; height: 100%;white-space:nowrap;display:none;" class="divMain">
    <div class="divMenu" style="width: 80px;">
        <div class="divTopImage" style="width: 100%">
            <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 0; border-collapse: collapse; border: 0px solid;">
                <tr>
                    <td style="height: 25px; text-align: center; padding: 2px">
                        <a href="javascript:document.getElementById('gridframe').contentWindow.NavigateUp()"
                            class="sectionitem">
                            <img src="<%=templateThemeDirectory %>Repository/ListControl/images/icons-ribbon/icon-up.png"
                                style="border-width: 0" height="36" width="36" alt="<%=GetLangSpecText("ec_rbn_wf_navigate_alt") %>" /></a>
                     </td>
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
            <%=GetLangSpecText("ec_rbn_wf_navigate") %>
        </div>
    </div>
    <div style="width: 120px;" class="divMenu">
        <div class="divTopImage">
            <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 2px; border-collapse: separate">
                <tr>
                    <td style="height: 25px; text-align: left; padding-left:20px">
                        <a href="javascript:ExecuteAction('_sys_new')" class="sectionitem">
                            <img alt="<%=GetLangSpecText("ec_rbn_wf_ordinary_form_alttext") %>" src="<%=templateThemeDirectory %>Repository/ListControl/images/icons-ribbon/icon-NGF.png"
                                style="border-width: 0; vertical-align: middle" height="23" width="23" /><%=GetLangSpecText("ec_rbn_wf_ordinary_form") %></a>
                    </td>
                </tr>
                <tr>
                    <td style="height: 25px; text-align: left; padding-left:20px">
                        <span><a href="javascript:ExecuteAction('_sys_newfolder')" class="sectionitem">
                            <img alt="<%=GetLangSpecText("ec_rbn_nl_folder") %>" src="<%=templateThemeDirectory %>Repository/ListControl/images/icons-ribbon/icon-new-folder.png"
                                style="border-width: 0; vertical-align: middle" height="23" width="23" />
                            <%=GetLangSpecText("ec_rbn_wf_newfolder") %>
                        </a></span>
                    </td>
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
            <%=GetLangSpecText("ec_rbn_form_new") %>
        </div>
    </div>
    <div style="width: 350px;" class="divMenu">
        <div class="divTopImage">
            <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 0; border-collapse: collapse; border: 0px solid;">
                <tr>
                    <td style="height: 25px; text-align: left; padding: 2px">
                        <a href="javascript:ExecuteActionForSelectedRow('_sys_designform')" class="sectionitem">
                            <img alt="<%=GetLangSpecText("ec_rbn_wf_designform_alttext") %>" src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/designerView.png"
                                style="vertical-align: middle; border-width: 0"  />
                            <%=GetLangSpecText("ec_rbn_wf_design") %>
                        </a>
                    </td>
                    <td style="text-align: left;padding:3px">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_edit')" class="sectionitem">
                            <img alt="<%=GetLangSpecText("ec_rbn_wf_edit_alttext")%>" src="<%=templateThemeDirectory %>Repository/ListControl/images/icons-ribbon/icon-edit.png"
                                style="vertical-align: middle; border-width: 0" />
                            <%=GetLangSpecText("ec_rbn_wf_edit")%>
                        </a></span>
                    </td>
                    <td style="text-align: left;padding:3px">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_preview')" class="sectionitem">
                            <img alt="<%=GetLangSpecText("ec_rbn_wf1_actionsViewform_alttext")%>" src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/icon-view-item.png"
                                style="vertical-align: middle; border-width: 0" />
                            <%=GetLangSpecText("ec_rbn_wf_actionsView")%>
                        </a></span>
                    </td>
                    <td style="text-align: left;padding:3px">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_delete')" class="sectionitem">
                            <img alt=" <%=GetLangSpecText("ec_rbn_wf_deleteform_alttext") %>" src="<%=templateThemeDirectory %>Repository/ListControl/images/icons-ribbon/delete.png"
                                style="vertical-align: middle; border-width: 0" />
                            <%=GetLangSpecText("ec_rbn_wf_delete") %>
                        </a></span>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: left;padding:3px">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_publish')" class="sectionitem">
                            <img alt="<%=GetLangSpecText("ec_rbn_wf_publish_alttext") %>" src="<%=templateThemeDirectory %>Repository/ListControl/images/icons-ribbon/icon-publish.png"
                                style="vertical-align: middle; border-width: 0" /><%=GetLangSpecText("ec_rbn_wf_publish") %></a></span>
                    </td>
                    <td style="text-align: left;padding:3px">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_unpublish')" class="sectionitem">
                            <img alt="<%=GetLangSpecText("ec_rbn_wf_unpublish_alttext") %>" src="<%=templateThemeDirectory %>Repository/ListControl/images/icons-ribbon/icon-unpublish.png"
                                style="vertical-align: middle; border-width: 0" /><%=GetLangSpecText("ec_rbn_wf_unpublish") %></a></span>
                    </td>
                    <td style="text-align: left;padding:3px" colspan="2">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_change_owner')" class="sectionitem">
                            <img alt="<%=GetLangSpecText("ec_rbn_wf_changeowner_alttext") %>" src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/changeowner.png"
                                style="vertical-align: middle; border-width: 0" />
                            <%=GetLangSpecText("ec_rbn_wf_changeowner") %></a></span>
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
            <a href="javascript:ExecuteActionForSelectedRow('_sys_create_assn')" class="sectionitem">
                <img src="<%=templateThemeDirectory %>Repository/ListControl/images/icons-ribbon/Associations-icon.png"
                     style=" border-width: 0" width="34" height="37" alt="<%=GetLangSpecText("ecm_assn_associate") %>" /></a>
                         </td>
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
            <%=GetLangSpecText("ec_rbn_wf_associate") %>
        </div>
    </div>
    <div style="width: 80px;" class="divMenu">
        <div class="divTopImage">
            <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 0; border-collapse: collapse; border: 0px solid;">
                <tr>
                    <td style="height: 25px; text-align: center; padding: 2px">
            <a href="javascript:ExecuteAction('_sys_organize')" class="sectionitem">
                <img src="<%=templateThemeDirectory %>Repository/ListControl/images/icons-ribbon/icon-organize-items.png"
                    width="36" height="36"  style="border-width: 0" alt="<%=GetLangSpecText("ec_rbn_wf_organize") %>" /></a>
             </td>
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
            <%=GetLangSpecText("ec_rbn_wf_organize")%>
        </div>
    </div>
    <div style="width: 80px;" class="divMenu">
        <div class="divTopImage">
            <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 0; border-collapse: collapse; border: 0px solid;">
                <tr>
                    <td style="height: 25px; text-align: center; padding: 2px">
            <a href="javascript:ExecuteSettingsActionFlag('_sys_security_settings')" class="sectionitem">
                <img src="<%=templateThemeDirectory %>Repository/ListControl/images/icons-ribbon/icon-settings.png"
                    width="35" height="37"  style="border-width: 0" alt="<%=GetLangSpecText("ec_rbn_nl_security_alt") %>" />
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
