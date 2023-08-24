<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.Forms.Web.CodeBehind.CreateList.BPMUITemplates_Default_Repository_ListControl_DynamicRibbonBar" %>
  <!--[if lt IE 7]>
  <script defer type="text/javascript" src="scripts/pngfix.js"></script>
  <![endif]-->
<link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemeURL)%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />


<%--Showing the Action Bar in the Div Element - Start--%>
        <div class="breadcrumb" >		                          
            <div class="actionItem"></div>   
            <div id="actionBarDiv" class="actionBarDiv"></div>
        </div>
<%--Showing the Action Bar in the Div Element - End--%>


<script type="text/javascript" language="javascript">
    function ExecuteSettingsActionFlag(command) {
        LocalizeMessages();    
        document.getElementById("gridframe").contentWindow.ExecuteActionByName(command);

        HideSubItemsActionBar();

        if (command == "_sys_security_settings") {
            DynamicListjsonObj = "";
            LoadActionBar();
        }

    }
    function ExecuteAction(command) {        
        LocalizeMessages();
        document.getElementById("gridframe").contentWindow.ExecuteActionByName(command);
        HideSubItemsActionBar();
    }
    
    function ExecuteActionForSelectedRow(command){
        LocalizeMessages();
     
        document.getElementById("gridframe").contentWindow.ExecuteActionForSelectedRow(command);
        HideSubItemsActionBar();
    }
    function LocalizeMessages()
    {
        document.getElementById("gridframe").contentWindow.cannotPerDisable = '<%=GetLangSpecText("ec_rbn_wf_cannotperformondisabled")%>';
        document.getElementById("gridframe").contentWindow.noRowSelected = '<%=GetLangSpecText("ec_rbn_wf_norowselected")%>';
        document.getElementById("gridframe").contentWindow.norightforaction = '<%=GetLangSpecText("ec_rbn_wf_norightforaction")%>';
        document.getElementById("gridframe").contentWindow.sysDel = '<%=GetLangSpecText("ec_rbn_wf_sysdelete")%>';
        document.getElementById("gridframe").contentWindow.NotAbleToEditFolder = '<%=GetLangSpecText("ec_rbn_nav_noedit_folder")%>';
        document.getElementById("gridframe").contentWindow.viewdesignOnlyForDL = '<%=GetLangSpecText("ec_rbn_wf_viewdesignOnlyForWF")%>';
    }


    /* Hiding the Sub items of the Action Bar */
    function HideSubItemsActionBar() {
        ActionBar.hideSubMenus();
        LoadActionBar();
    }

    /* Showing the Right Action Bar */
    function LoadRightActionBar()
    {
        if (ActionBar._rightMenu) {
            ActionBar.hideRightMenu();
        }
        ActionBar.showRightMenu(RightDynamicListjsonObj);
    }

    var DynamicListjsonObj =
        [

            {
                "Up":
                {
                    "Id": "498D4CBB-2446-493D-983A-8DFF0BD20AD8",
                    "Text": " <%=GetLangSpecText("ec_rbn_wf_navigate") %>",
                    "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_navigate_alt") %>",
                    "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-Up.png",
                    "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Up.png",
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
                    "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-New.png",
                    "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-New.png",
                    "Action": "",
                    "OpenMode": "Popup",
                    "SubItems": [
                        {
                            "Id": "80C33179-9B75-4248-A466-DA7F65789C0A",
                            "Text": "<%=GetLangSpecText("ec_rbn_dl_new_list_item") %>",
                            "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_newlist_new_alttext") %>",
                            "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-List.png",
                            "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-List.png",
                            "Action": "javascript:ExecuteSettingsActionFlag('_sys_new')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        },                     

                        {
                            "Id": "799F6317-9BD8-4141-9408-7F32EDB47B64",
                            "Text": "<%=GetLangSpecText("ec_rbn_wf_newfolder") %>",
                            "Tooltip": "<%=GetLangSpecText("ec_rbn_nl_folder") %>",
                            "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-Folder.png",
                            "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Folder.png",
                            "Action": "javascript:ExecuteSettingsActionFlag('_sys_newfolder')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        }

                    ]
                }
            },

            {
                "New": {
                    "Id": "E53C245D-E05B-4D4F-820D-40AD26479887",
                    "Text": "<%=GetLangSpecText("ec_rbn_wf_new") %>",
                    "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_new") %>",
                    "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-New.png",
                    "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-New.png",
                    "Action": "",
                    "OpenMode": "Popup",
                    "SubItems": [
                        {
                            "Id": "80C33179-9B75-4248-A466-DA7F65789C0A",
                            "Text": "<%=GetLangSpecText("ec_rbn_dl_new_list_item") %>",
                            "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_newlist_new_alttext") %>",
                            "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-List.png",
                            "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-List.png",
                            "Action": "javascript:ExecuteSettingsActionFlag('_sys_new')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        }                       

                    ]
                }
            },

            {
                "Template": {
                    "Id": "7C219EEA-5F77-47D0-A5C8-96F8D7569503",
                    "Text": "<%=GetLangSpecText("ec_rbn_wf_ImportData") %>",
                    "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_ImportData") %>",
                    "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-ListTemplate.png",
                    "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-ListTemplate.png",
                    "Action": "",
                    "OpenMode": "Popup",
                    "SubItems": [
                        {
                            "Id": "33F8E4BC-A569-41C6-8C4A-2D409B65A793",
                            "Text": "<%=GetLangSpecText("ec_rbn_wf_CreateExcel") %>",
                            "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_CreateExcel") %>",
                            "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-CreateExcel.png",
                            "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-CreateExcel.png",
                            "Action": "javascript:ExecuteAction('_sys_new_template')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        },

                        {
                            "Id": "A034A5D8-4C71-4C43-82BD-FCCB82635056",
                            "Text": "<%=GetLangSpecText("ec_rbn_wf_ImportFromExcel") %>",
                            "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_ImportFromExcel") %>",
                            "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-ImportListData.png",
                            "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-ImportListData.png",
                            "Action": "javascript:ExecuteAction('_sys_importdatafromtemplate')",
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
                    "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-Organize.png",
                    "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Organize.png",
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

    var RightDynamicListjsonObj =
                [
                    {
                        "Edit":
                            {
                                "Id": "5987319E-C0E4-4142-9C01-53389025A3BF",
                                "Text": "<%=GetLangSpecText("ec_rbn_wf_edit")%>",
                                "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_newlist_edit_alttext") %>",
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
                                "Id": "5987319E-C0E4-4142-9C01-53389025A3BF",
                                "Text": "<%=GetLangSpecText("ec_rbn_wf_viewitemdetails")%>",
                                "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_newlist_view_alttext") %>",
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
                                "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_newlist_delete_alttext") %>",
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
        
        <%if (IsFolderSupported){ %>        
            DynamicListjsonObj[2]="";        
        <% } else { %> 
            DynamicListjsonObj[1] = "";
        <%  } %>

        <%if (!isAdministrator){ %>   
        DynamicListjsonObj[3] = "";
        <%  } %>

        <%if (nonSupportedListName){ %>   
        DynamicListjsonObj[3] = "";
        <%  } %>

        ActionBar.init(DynamicListjsonObj, "actionBarDiv");
    }

    //Loading the Action Bar 
    LoadActionBar();

</script>

<div style="width:100%; height:100%;display:none;" class="divMain">
    <div class="divMenu" style="width: 80px;">
            <div class="divTopImage" style="width: 100%">
                <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 0; border-collapse: collapse; border: 0px solid;">
                <tr>
                    <td style="height: 25px; text-align: center; padding: 2px">
                        <a href="javascript:document.getElementById('gridframe').contentWindow.NavigateUp()"
                            class="sectionitem">
                           <img src="<%=ThemeURL%>/repository/listcontrol/images/icons-ribbon/icon-up.png" style="border:none;vertical-align:middle;" alt="<%=GetLangSpecText("ec_rbn_wf_navigate_alt") %>"/></a>
                    </td>
                </tr>
                </table>
            </div>
            <div class="sectiontitle divdowntext">
                <%=GetLangSpecText("ec_rbn_wf_navigate")%>
            </div>
    </div>

    <div style="width: 120px;" class="divMenu">
        <div class="divTopImage">
            <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 2px; border-collapse: separate">
                <%if (IsFolderSupported){ %>
                <tr>
                    <td style="height: 25px; text-align: left">
                        <a href="javascript:ExecuteSettingsActionFlag('_sys_new')" class="sectionitem">
                                <img src="<%=ThemeURL%>/Repository/ListControl/images/icons-ribbon/icon-new-list-item.png"  style="vertical-align:middle;width:23px;height:23px;border:none;" alt="<%=GetLangSpecText("ec_rbn_wf_newlist_new_alttext") %>" />
                                <%=GetLangSpecText("ec_rbn_dl_new_list_item") %>
                       </a>
                    </td>                    
                </tr>
                <tr>                    
                    <td style="height: 25px; text-align: left">
                        <span> <a href="javascript:ExecuteSettingsActionFlag('_sys_newfolder')" class="sectionitem">
                                <img src="<%=ThemeURL%>/Repository/ListControl/images/icons-ribbon/folder-icon.png" style="vertical-align:middle;width:23px;height:23px;border:none;" alt="<%=GetLangSpecText("ec_rbn_nl_folder") %>"/>
                                <%=GetLangSpecText("ec_rbn_wf_newfolder") %>
                         </a></span>
                    </td>
                </tr>
                <%}%>
                 <%else { %>
                    <tr>
                    <td style="height: 25px; text-align: left">
                        <a href="javascript:ExecuteSettingsActionFlag('_sys_new')" class="sectionitem">
                                <img src="<%=ThemeURL%>/Repository/ListControl/images/icons-ribbon/icon-new-list-item.png" style="vertical-align:middle;width:23px;height:23px;border:none;" alt="<%=GetLangSpecText("ec_rbn_wf_newlist_new_alttext") %>" />
                                <%=GetLangSpecText("ec_rbn_dl_new_list_item") %>
                       </a>
                    </td>                    
                </tr>
                <%}%>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
            <%=GetLangSpecText("ec_rbn_au_new")%> <%=strListName%>
        </div>
    </div>

<div style="width: 200px;" class="divMenu">
        <div class="divTopImage">
            <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 2px; border-collapse: separate" >
                <tr>
                    <td style="height: 25px;text-align: left">
                        <span >
                            <a href="javascript:ExecuteActionForSelectedRow('_sys_edit')" class="sectionitem">
                             <img src="<%=ThemeURL%>/Repository/ListControl/images/icons-ribbon/icon-edit.png" style="vertical-align:middle;width:23px;height:23px;border:none;" alt="<%=GetLangSpecText("ec_rbn_wf_newlist_edit_alttext") %>" />
                                 <%=GetLangSpecText("ec_rbn_wf_edit")%>
                            </a></span>
                    </td>
                    <td style="height: 25px; text-align: left">
                       <span><a href="javascript:ExecuteActionForSelectedRow('_sys_view_item_details')" class="sectionitem">
                                <img src="<%=ThemeURL%>/Repository/ListControl/images/icons-ribbon/icon-view-item.png" style="vertical-align:middle;width:23px;height:23px;border:none;" alt="<%=GetLangSpecText("ec_rbn_wf_newlist_view_alttext") %>"/>
                                <%=GetLangSpecText("ec_rbn_wf_viewitemdetails")%>
                            </a></span>
                    </td>
                </tr>
                <tr>
                    <td style="height: 25px;text-align: left">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_delete')" class="sectionitem">
                                <img src="<%=ThemeURL%>/Repository/ListControl/images/icons-ribbon/delete.png" style="vertical-align:middle;width:23px;height:23px;border:none;" alt="<%=GetLangSpecText("ec_rbn_wf_newlist_delete_alttext") %>"/>
                                <%=GetLangSpecText("ec_rbn_wf_delete") %></a>
                        </span>
                    </td>
                    
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
             <%=GetLangSpecText("ec_rbn_wf_actions") %>
        </div>
    </div>

    <div style="width: 100px;" class="divMenu">
        <div class="divTopImage">
            <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 0; border-collapse: collapse; border: 0px solid;">
                <tr>
                    <td style="height: 25px; text-align: center; padding: 2px">
            <a href="javascript:ExecuteAction('_sys_organize')" class="sectionitem">
                 <img src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/icon-organize-items.png" style="vertical-align:middle;width:36px;height:36px;border:none;" alt="<%=GetLangSpecText("ec_rbn_wf_organize") %>"/></a>
                        </td>
                    </tr>
                </table>
        </div>
        <div class="sectiontitle divdowntext">
             <%=GetLangSpecText("ec_rbn_wf_organize")%>
        </div>
    </div>
    <div style="width: 100px;" class="divMenu">
        <div class="divTopImage">
            <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 0; border-collapse: collapse; border: 0px solid;">
                <tr>
                    <td style="height: 25px; text-align: center; padding: 2px">
                            <a href="javascript:ExecuteSettingsActionFlag('_sys_security_settings')" class="sectionitem">
                                <img src="<%=ThemeURL%>/Repository/ListControl/images/icons-ribbon/icon-settings.png" style="vertical-align:middle;width:36px;height:36px;border:none;" alt="<%=GetLangSpecText("ec_rbn_nl_security_alt") %>"/>
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

