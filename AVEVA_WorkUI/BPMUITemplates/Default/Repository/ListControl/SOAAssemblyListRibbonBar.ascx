<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.WebControls_RibbonBar" %>
<!--[if lt IE 7]>
  <script defer type="text/javascript" src="scripts/pngfix.js"></script>
  <![endif]-->
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
        HideSubItemsActionBar();
        if (command == "_sys_security_settings") {
            SOAAssemblyjsonObj = "";
            LoadActionBar();
        }
    }
    function LocalizeMessages() {
        document.getElementById("gridframe").contentWindow.cannotPerDisable = '<%=GetLangSpecText("ec_rbn_wf_cannotperformondisabled")%>';
        document.getElementById("gridframe").contentWindow.noRowSelected = '<%=GetLangSpecText("ec_rbn_wf_norowselected")%>';
        document.getElementById("gridframe").contentWindow.norightforaction = '<%=GetLangSpecText("ec_rbn_wf_norightforaction")%>';
        document.getElementById("gridframe").contentWindow.sysDel = '<%=GetLangSpecText("ec_rbn_wf_sysdelete")%>';
        document.getElementById("gridframe").contentWindow.NotAbleToEditFolder = '<%=GetLangSpecText("ec_rbn_nav_noedit_folder")%>';
        document.getElementById("gridframe").contentWindow.viewdesignOnlyForSOA = '<%=GetLangSpecText("ec_rbn_wf_viewdesignOnlyForWF")%>';
    }
    function TABLE1_onclick() {

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
        ActionBar.showRightMenu(SOAAssemblyRightJsonObj);
    }

    var SOAAssemblyjsonObj =
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
                    "Text":"<%=GetLangSpecText("ec_soa_new_assembly")%>",
                    "Tooltip":"<%=GetLangSpecText("ec_soa_new_assembly")%>",
                    "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-New.png",
                    "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-New.png",
                    "Action": "",
                    "OpenMode": "Popup",
                    "SubItems": [
                        {
                            "Id": "80C33179-9B75-4248-A466-DA7F65789C0A",
                            "Text": "<%=GetLangSpecText("ec_soa_GAC")%>",
                            "Tooltip": "<%=GetLangSpecText("ec_soa_GAC_Alttext")%>",
                            "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-FromGAC.png",
                            "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-FromGAC.png",
                            "Action": "javascript:ExecuteAction('_sys_new')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        },
                        {
                            "Id": "9664481B-727B-4AEE-8014-DBAF61903246",
                            "Text": "<%=GetLangSpecText("ec_soa_SelectAsembly")%>",
                            "Tooltip": "<%=GetLangSpecText("ec_soa_SelectAsembly_altText")%>",
                            "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-FromAssemblyFolder.png",
                            "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-FromAssemblyFolder.png",
                            "Action": "javascript:ExecuteAction('_sys_soa_assembly')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        },
                        {
                            "Id": "0F579F22-71F1-4679-94D8-2525C3D43DC2",
                            "Text": "<%=GetLangSpecText("ec_soa_web")%>",
                            "Tooltip": "<%=GetLangSpecText("From Web_altText")%>",
                            "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-FromWeb.png",
                            "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-FromWeb.png",
                            "Action": "javascript:ExecuteAction('_sys_new_web')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        },


                       {
                           "Id": "799F6317-9BD8-4141-9408-7F32EDB47B64",
                           "Text": "<%=GetLangSpecText("ec_rbn_wf_newfolder") %>",
                           "Tooltip": "<%=GetLangSpecText("ec_rbn_nl_folder") %>",
                           "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Folder.png",
                           "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Folder.png",
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


    var SOAAssemblyRightJsonObj =
                [
                    {
                        "Edit":
                            {

                                "Id": "5987319E-C0E4-4142-9C01-53389025A3BF",
                                "Text": "<%=GetLangSpecText("ec_rbn_soa_edit")%>",
                                "Tooltip": "<%=GetLangSpecText("ec_rbn_soa_edit_alttext")%>",
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
                               "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_actionsView_alttext")%>",
                               "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-View.png",
                               "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-View.png",
                               "Action": "javascript:ExecuteActionForSelectedRow('_sys_view_propertiessoa')",
                               "OpenMode": "Popup",
                               "SubItems": []
                           }
                    },
                    {
                        "Delete":
                           {
                               "Id": "75211C43-A0E2-4BF5-A182-3B5D78E74700",
                               "Text": "<%=GetLangSpecText("ec_rbn_soa_delete")%>",
                               "Tooltip": "<%=GetLangSpecText("ec_rbn_soa_delete_alttext")%>",
                               "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Delete.png",
                               "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Delete.png",
                               "Action": "javascript:ExecuteActionForSelectedRow('_sys_delete')",
                               "OpenMode": "Popup",
                               "SubItems": []
                           }
                    }	


                                   

                ];

    //Function for loading the action bar 
    function LoadActionBar() {
        ActionBar.init(SOAAssemblyjsonObj, "actionBarDiv");
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
                        <img src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/icon-up.png"
                            border="0" width="36" height="36" alt="<%=GetLangSpecText("ec_rbn_wf_navigate_alt") %>" /></a>
                        </td>
                    </tr>
                 </table>
          </div>  
          <div class="sectiontitle divdowntext">
               <%=GetLangSpecText("ec_rbn_wf_navigate") %>
          </div>
      
    </div>
    <div style="width: 320px;" class="divMenu">
        <div class="divTopImage">
            <table style="width:100%;height:65px;border-width:0;border-spacing:2px;border-collapse:separate">
                <tr>
                    <td style="text-align:left;padding:0px;">
                        <a href="javascript:ExecuteAction('_sys_new')" class="sectionitem">
                            <img alt=" <%=GetLangSpecText("ec_soa_GAC_Alttext")%>" src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/icon-assembly-global.png"
                               style="vertical-align:middle;border-width:0" width="23" height="23" />
                            <%=GetLangSpecText("ec_soa_GAC")%>
                        </a>
                    </td>
                    
                    <td style="text-align:left">
                        <a href="javascript:ExecuteAction('_sys_soa_assembly')" class="sectionitem">
                            <img alt=" <%=GetLangSpecText("ec_soa_SelectAsembly_altText")%>" src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/icon-assembly-selection.png"
                                style="vertical-align:middle;border-width:0" width="23" height="23" />
                            <%=GetLangSpecText("ec_soa_SelectAsembly")%>
                        </a>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:left;padding:3px;">
                        <a href="javascript:ExecuteAction('_sys_new_web')" class="sectionitem">
                            <img alt="<%=GetLangSpecText("From Web_altText")%>" src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/icon-SOA-Web.png"
                                style="vertical-align:middle;border-width:0" width="23" height="23" />
                            <%=GetLangSpecText("ec_soa_web")%>
                        </a>
                    </td>
                    <td style="text-align:left">
                        <a href="javascript:ExecuteSettingsActionFlag('_sys_newfolder')" class="sectionitem">
                            <img src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/folder-icon.png"
                                width="23" height="23" style="vertical-align:middle;border-width:0" alt="<%=GetLangSpecText("ec_rbn_nl_folder") %>" />
                            <%=GetLangSpecText("ec_rbn_wf_newfolder") %>
                        </a>
                    </td>
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
            <%=GetLangSpecText("ec_soa_new_assembly")%>
        </div>
    </div>
    <div style="width: 190px;" class="divMenu">
        <div class="divTopImage">
            <table style="width:100%;height:65px;border-width:0;border-spacing:2px;border-collapse:separate">
                <tr>
                    <td style="text-align:left">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_edit')" class="sectionitem">
                            <img alt="  <%=GetLangSpecText("ec_rbn_soa_edit_alttext")%>" src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/icon-edit.png"
                                style="vertical-align:middle;border-width:0" width="23" height="23" />
                            <%=GetLangSpecText("ec_rbn_soa_edit")%>
                        </a></span>
                    </td>
                    <td style="text-align:left">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_view_propertiessoa')"
                            class="sectionitem">
                            <img alt=" <%=GetLangSpecText("ec_rbn_wf_actionsView_alttext")%>" src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/icon-view-item.png"
                                style="vertical-align:middle;border-width:0" width="23" height="23" />
                                    <%=GetLangSpecText("ec_rbn_wf_actionsView")%></a></span>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:left" colspan="1">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_delete')" class="sectionitem">
                            <img alt=" <%=GetLangSpecText("ec_rbn_soa_delete_alttext")%>" src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/delete.png"
                                style="vertical-align:middle;border-width:0" width="23" height="23" />
                                    <%=GetLangSpecText("ec_rbn_soa_delete")%></a></span> 
                    </td>
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
            <%=GetLangSpecText("ec_rbn_soa_actions")%>
        </div>
    </div>
    <div style="width: 80px;" class="divMenu">
        <div class="divTopImage">
             <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 0; border-collapse: collapse; border: 0px solid;">
                <tr>
                    <td style="height: 25px; text-align: center; padding: 2px">
                        <a href="javascript:ExecuteSettingsActionFlag('_sys_security_settings')" class="sectionitem">
                            <img src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/icon-settings.png"
                               style="border-width:0" width="36" height="36" alt="<%=GetLangSpecText("ec_rbn_nl_security_alt") %>" />
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
