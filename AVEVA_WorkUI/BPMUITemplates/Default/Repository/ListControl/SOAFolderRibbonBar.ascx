<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.WebControls_RibbonBar" %>
<link type="text/css" rel="stylesheet" href="<%=templateThemeDirectory%>Common/StyleSheet/Global.css" />

<%--Showing the Action Bar in the Div Element - Start--%>
        <div class="breadcrumb" >		                          
            <div class="actionItem"></div>   
            <div id="actionBarDiv" class="actionBarDiv"></div>
        </div>
<%--Showing the Action Bar in the Div Element - End--%>

<script type="text/javascript">
    var hgt = screen.availHeight;
    function ExecuteAction(command) {
        LocalizeMessages();
        document.getElementById("gridframe").contentWindow.ExecuteActionByName(command);
        HideSubItemsActionBar();
    }

    function ExecuteActionForSelectedRow(command) {
        LocalizeMessages();
        if (command == '_sys_delete') {
            parent.tabpage = "";
        }
        document.getElementById("gridframe").contentWindow.ExecuteActionForSelectedRow(command);
        HideSubItemsActionBar();
        

    }
    function ExecuteSettingsActionFlag(command) {
        LocalizeMessages();
        var flag = document.getElementById("gridframe").contentWindow.IsRowSelected();
        if (flag) {
            document.getElementById("gridframe").contentWindow.ExecuteActionForSelectedRow(command);
        }
        else {
            document.getElementById("gridframe").contentWindow.ExecuteActionByName(command);
        }

        if (command == "_sys_security_settings") {
            SOAFoldersjsonObj = "";
            LoadActionBar();
        }
    }
    function LocalizeMessages() {
        document.getElementById("gridframe").contentWindow.cannotPerDisable = '<%=GetLangSpecText("ec_rbn_wf_cannotperformondisabled")%>';
        document.getElementById("gridframe").contentWindow.noRowSelected = '<%=GetLangSpecText("ec_rbn_wf_norowselected")%>';
        document.getElementById("gridframe").contentWindow.norightforaction = '<%=GetLangSpecText("ec_rbn_wf_norightforaction")%>';
        document.getElementById("gridframe").contentWindow.sysDel = '<%=GetLangSpecText("ec_rbn_wf_sysdelete")%>';
        document.getElementById("gridframe").contentWindow.NotAbleToEditFolder = '<%=GetLangSpecText("ec_rbn_nav_noedit_folder")%>';
    }
    function TABLE1_onclick() {

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
        ActionBar.showRightMenu(RightSOAFoldersJsonObj);
    }

    var SOAFoldersjsonObj =
        [
            {
                "New": {
                    "Id": "E53C245D-E05B-4D4F-820D-40AD26479887",
                    "Text": "<%=GetLangSpecText("FolderManager_New")%>",
                    "Tooltip": "<%=GetLangSpecText("FolderManager_New_AltText")%>",
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


    var RightSOAFoldersJsonObj =
            [                    

                {
                    "Edit":
                    {
                        "Id": "5987319E-C0E4-4142-9C01-53389025A3BF",
                        "Text": "<%=GetLangSpecText("ec_rbn_soa_folder_edit")%>",
                        "Tooltip": "<%=GetLangSpecText("ec_rbn_soa_folder_edit_AltText")%>",
                        "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Edit.png",
                        "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Edit.png",
                        "Action": "javascript:ExecuteActionForSelectedRow('_sys_edit')",
                        "OpenMode": "Popup",
                        "SubItems": []
                    },
                },

                {
                    "Delete":
                    {
                        "Id": "75211C43-A0E2-4BF5-A182-3B5D78E74700",
                        "Text": "<%=GetLangSpecText("ec_rbn_soa_folder_delete")%>",
                        "Tooltip": "<%=GetLangSpecText("ec_rbn_soa_folder_delete_AltText")%>",
                        "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Delete.png",
                        "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Delete.png",
                        "Action": "javascript:ExecuteActionForSelectedRow('_sys_delete')",
                        "OpenMode": "Popup",
                        "SubItems": []
                    },
                }



            ];

    //Function for loading the action bar 
    function LoadActionBar() {
        ActionBar.init(SOAFoldersjsonObj, "actionBarDiv");
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
                        <a href="javascript:ExecuteAction('_sys_new')" class="sectionitem">
                            <img alt=" <%=GetLangSpecText("FolderManager_New_AltText")%>" src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/SAP-newConnection.png"
                                style="border-width: 0" width="36" height="36" />
                        </a>
                    </td>
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
            <%=GetLangSpecText("FolderManager_New")%>
        </div>
    </div>
    <div class="divMenu" style="width: 100px;">
        <div class="divTopImage">
            <table style="width:100%;height:65px;border-width:0;border-spacing:2px;border-collapse:separate">
                <tr>
                    <td style="text-align:left;height:25px;">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_edit')" class="sectionitem">
                            <img alt="<%=GetLangSpecText("ec_rbn_soa_folder_edit_AltText")%>" src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/icon-view-item.png"
                                style="vertical-align:middle;border-width:0" width="23" height="23" />
                            <%=GetLangSpecText("ec_rbn_soa_folder_edit")%>
                        </a></span>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:left;height:25px;">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_delete')" class="sectionitem">
                            <img alt=" <%=GetLangSpecText("ec_rbn_soa_folder_delete_AltText")%>" src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/delete.png"
                                 style="vertical-align:middle;border-width:0"  width="23" height="23" />
                            <%=GetLangSpecText("ec_rbn_soa_folder_delete")%></a></span>
                    </td>
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
            <%=GetLangSpecText("ec_rbn_soa_folder_actions")%>
        </div>
    </div>
    <div class="divMenu" style="width: 80px;">
        <div class="divTopImage">
            <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 0; border-collapse: collapse; border: 0px solid;">
                <tr>
                    <td style="height: 25px; text-align: center; padding: 2px">
            
            <a href="javascript:ExecuteSettingsActionFlag('_sys_security_settings')" class="sectionitem">
                <img src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/icon-settings.png"
                     style="border-width:0"  width="36" height="36" alt="<%=GetLangSpecText("ec_rbn_nl_security_alt") %>" />
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
