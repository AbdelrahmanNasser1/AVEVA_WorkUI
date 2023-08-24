<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.LookupRibbonBar" %>
<link type="text/css" rel="stylesheet" href="<%=ThemeURL%>Common/StyleSheet/Global.css" />

<%--Showing the Action Bar in the Div Element - Start--%>
<div class="breadcrumb">
    <div class="actionItem"></div>
    <div id="actionBarDiv" class="actionBarDiv"></div>
</div>
<%--Showing the Action Bar in the Div Element - End--%>


<script type="text/javascript">
    var applicationName = '<%=applicationName%>';
    function ExecuteSettingsActionFlag(command)
    {
        LocalizeMessages();
        document.getElementById("gridframe").contentWindow.ExecuteActionByName(command);
        HideSubItemsActionBar();
        if (command == "_sys_security_settings")
        {
            LookupjsonObj = "";
            LoadActionBar();
        }

    }
    function ExecuteAction(command)
    {
        LocalizeMessages();
        document.getElementById("gridframe").contentWindow.ExecuteActionByName(command);
        HideSubItemsActionBar();
    }

    function ExecuteActionForSelectedRow(command)
    {
        var contentWindow = document.getElementById("gridframe").contentWindow;
        if (command === "_sys_edit")
        {
            command = GetActionBasedOnItemType(contentWindow.ListItemObj.ItemType);
        }

        LocalizeMessages();
        contentWindow.ExecuteActionForSelectedRow(command);
        HideSubItemsActionBar();
    }

    function GetActionBasedOnItemType(itemType)
    {
        var command = "_sys_edit";
        $.ajax({
            async: false,
            type: "GET",
            url: "../../NextGenForms/DatabaseLookupService.aspx/GetActionBasedOnItemType",
            contentType: "application/json; charset=utf-8",
            data: { itemType: JSON.stringify(itemType), app: JSON.stringify(applicationName) },
            dataType: "json",
            success: function (result)
            {
                command = result.d;
            },
            error: function (jqXHR, textStatus, err)
            {
                alert(err);
            },
        });

        return command;
    }

    function LocalizeMessages()
    {
        document.getElementById("gridframe").contentWindow.cannotPerDisable = '<%=GetLangSpecText("ec_rbn_wf_cannotperformondisabled")%>';
        document.getElementById("gridframe").contentWindow.noRowSelected = '<%=GetLangSpecText("ec_rbn_wf_norowselected")%>';
        document.getElementById("gridframe").contentWindow.norightforaction = '<%=GetLangSpecText("ec_rbn_wf_norightforaction")%>';
        document.getElementById("gridframe").contentWindow.sysDel = '<%=GetLangSpecText("ec_rbn_wf_sysdelete")%>';
        document.getElementById("gridframe").contentWindow.NotAbleToEditFolder = '<%=GetLangSpecText("ec_rbn_lookup_syseditFoloder")%>';
    }

    /* Hiding the Sub items of the Action Bar */
    function HideSubItemsActionBar()
    {
        ActionBar.hideSubMenus();
        LoadActionBar();
    }

    /* Showing the Right Action Bar */
    function LoadRightActionBar()
    {

        if (ActionBar._rightMenu)
        {
            ActionBar.hideRightMenu();
        }
        ActionBar.showRightMenu(RightLookupjsonObj);
    }

    var LookupjsonObj =
    [

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
                        "Text": "<%=GetLangSpecText("lookup_db")%>",
                        "Tooltip": "<%=GetLangSpecText("lookup_db_alttext")%>",
                        "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-DatabaseList.png",
                        "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-DatabaseList.png",
                        "Action": "javascript:ExecuteAction('_sys_new')",
                        "OpenMode": "Popup",
                        "SubItems": []
                    },
                    {
                        "Id": "D5408128-E331-4FAE-8107-0263F8CB595A",
                        "Text": "<%=GetLangSpecText("lookup_sk")%>",
                        "Tooltip": "<%=GetLangSpecText("lookup_sk_list_alttext")%>",
                        "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-RepositoryList.png",
                        "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-RepositoryList.png",
                        "Action": "javascript:ExecuteAction('_sys_new_lookup')",
                        "OpenMode": "Popup",
                        "SubItems": []
                    },
                    {
                        "Id": "B978F988-2A83-4B0F-91F8-ACDC6F66BEF3",
                        "Text": "<%=GetLangSpecText("lookup_webapi")%>",
                        "Tooltip": "<%=GetLangSpecText("New Web Api List lookup")%>",
                        "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-Web-API.png",
                        "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Web-API.png",
                        "Action": "javascript:ExecuteAction('_sys_new_webapi_lookup')",
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


        var RightLookupjsonObj =
        [
            {
                "Edit":
                {
                    "Id": "5987319E-C0E4-4142-9C01-53389025A3BF",
                    "Text": "<%=GetLangSpecText("ec_lookup_edit")%>",
                    "Tooltip": "<%=GetLangSpecText("ec_lookup_edit_alttext")%>",
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
                "Text": "<%=GetLangSpecText("ec_lookup_delete")%>",
                "Tooltip": "<%=GetLangSpecText("ec_lookup_delete_alttext")%>",
                "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-Delete.png",
                "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Delete.png",
                "Action": "javascript:ExecuteActionForSelectedRow('_sys_delete')",
                "OpenMode": "Popup",
                "SubItems": []
            }
        }


        ];

        //Function for loading the action bar 
        function LoadActionBar()
        {
            ActionBar.init(LookupjsonObj, "actionBarDiv");
        }

        //Loading the Action Bar 
        LoadActionBar();

</script>
<div style="width: 100%; height: 100%; white-space: nowrap; display: none;" class="divMain">
    <div class="divMenu" style="width: 380px;">
        <div class="divTopImage">
            <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 2px; border-collapse: separate">
                <tr>
                    <td style="height: 25px; text-align: left; padding-left: 5px;">
                        <span><a href="javascript:ExecuteAction('_sys_new')" class="sectionitem">
                            <img alt="<%=GetLangSpecText("lookup_db_alttext")%>" src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/lookupdatabase.png"
                                style="vertical-align: middle; border-width: 0" />
                            <%=GetLangSpecText("lookup_db")%>
                        </a></span>
                    </td>
                    <td style="height: 25px; text-align: left;">
                        <span><a href="javascript:ExecuteAction('_sys_new_lookup')" class="sectionitem">
                            <img alt="<%=GetLangSpecText("lookup_sk_list_alttext")%>" src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/lookupsklist.png"
                                style="vertical-align: middle; border-width: 0; height: 23px; width: 23px" />
                            <%=GetLangSpecText("lookup_sk")%>
                        </a></span>
                    </td>
                    <td style="height: 25px; text-align: left; padding-left: 5px;">
                        <span><a href="javascript:ExecuteAction('_sys_new_webapi_lookup')" class="sectionitem">
                            <img alt="<%=GetLangSpecText("New Web Api List lookup")%>" src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/lookupwebapilist.png"
                                style="vertical-align: middle; border-width: 0" />
                            <%=GetLangSpecText("lookup_webapi")%>
                        </a></span>
                    </td>
                    <%=topRowActionsNew%>
                </tr>
                <tr>
                    <td style="height: 25px; text-align: left;">
                        <span><a href="javascript:ExecuteSettingsActionFlag('_sys_newfolder')" class="sectionitem">
                            <img src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/folder-icon.png"
                                style="vertical-align: middle; border-width: 0" alt="<%=GetLangSpecText("ec_rbn_nl_folder") %>" />
                            <%=GetLangSpecText("ec_rbn_wf_newfolder") %>
                        </a></span>
                    </td>
                    <%=bottomRowActionsNew%>
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
            <%=GetLangSpecText("ec_rbn_wf_new")%>
        </div>
    </div>
    <div class="divMenu" style="width: 110px;">
        <div class="divTopImage">
            <table style="width: 100%; border-width: 0; height: 65px; border-spacing: 2px; border-collapse: separate">
                <tr>
                    <td style="text-align: left;">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_edit')" class="sectionitem">
                            <img alt="<%=GetLangSpecText("ec_lookup_edit_alttext")%>" src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/icon-edit.png"
                                style="vertical-align: middle; border-width: 0" width="23" height="23" />
                            <%=GetLangSpecText("ec_lookup_edit")%>
                        </a></span>
                    </td>

                </tr>
                <tr>
                    <td style="text-align: left;">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_delete')" class="sectionitem">
                            <img alt="<%=GetLangSpecText("ec_lookup_delete_alttext")%>" src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/delete.png"
                                style="vertical-align: middle; border-width: 0" height="23" width="23" />
                            <%=GetLangSpecText("ec_lookup_delete")%>
                        </a></span>
                    </td>
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
            <%=GetLangSpecText("ec_lookup_actions")%>
        </div>
    </div>
    <div class="divMenu" style="width: 80px;">
        <div class="divTopImage" style="width: 100%">
            <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 0; border-collapse: collapse; border: 0px solid;">
                <tr>
                    <td style="height: 25px; text-align: center; padding: 2px">

                        <a href="javascript:ExecuteSettingsActionFlag('_sys_security_settings')" class="sectionitem">
                            <img src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/icon-settings.png"
                                width="35" height="37" style="border-width: 0px" alt="<%=GetLangSpecText("ec_rbn_nl_security_alt") %>" />
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
