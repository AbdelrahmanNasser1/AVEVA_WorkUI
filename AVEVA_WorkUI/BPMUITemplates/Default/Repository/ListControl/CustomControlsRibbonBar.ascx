<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.FormsRibbonBar" %>
 <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(templateThemeDirectory)%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />

<%--Showing the Action Bar in the Div Element - Start--%>
        <div class="breadcrumb" >		                          
            <div class="actionItem"></div>   
            <div id="actionBarDiv" class="actionBarDiv"></div>
        </div>
<%--Showing the Action Bar in the Div Element - End--%>

<script type="text/javascript" language="javascript">
 function ExecuteSettingsActionFlag(command)
    {
        LocalizeMessages();
        var flag = document.getElementById("gridframe").contentWindow.IsRowSelected();
        if(flag)
        {
          document.getElementById("gridframe").contentWindow.ExecuteActionForSelectedRow(command);  
        }
        else
        {
            document.getElementById("gridframe").contentWindow.ExecuteActionByName(command);
        }

        HideSubItemsActionBar();

        if (command == "_sys_security_settings") {
            CustomControlsjsonObj = "";
            LoadActionBar();
        }

    }
    function ExecuteAction(command){
        LocalizeMessages();
        document.getElementById("gridframe").contentWindow.ExecuteActionByName(command);
        HideSubItemsActionBar();
    }
    
    function ExecuteActionForSelectedRow(command){
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
        LoadActionBar();
    }

    /* Showing the Right Action Bar */
    function LoadRightActionBar() {

        if (ActionBar._rightMenu) {
            ActionBar.hideRightMenu();
        }
        ActionBar.showRightMenu(CustomControlsRightJsonObj);
    }

    var CustomControlsjsonObj =
        [

            {
                "New": {
                    "Id": "E53C245D-E05B-4D4F-820D-40AD26479887",
                    "Text": "<%=GetLangSpecText("ec_rbn_form_new")%>",
                    "Tooltip": "<%=GetLangSpecText("ec_rbn_form_new")%>",
                    "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-New.png",
                    "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-New.png",
                    "Action": "",
                    "OpenMode": "Popup",
                    "SubItems": [
                        {
                            "Id": "80C33179-9B75-4248-A466-DA7F65789C0A",
                            "Text": "<%=GetLangSpecText("FormMyNewCustomControl") %>",
                            "Tooltip": "<%=GetLangSpecText("ec_rbn_FormControl_newAlt") %> ",
                            "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-FormControl.png",
                            "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-FormControl.png",
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

    var CustomControlsRightJsonObj =
            [
                    {
                        "Edit":
                            {
                                "Id": "5987319E-C0E4-4142-9C01-53389025A3BF",
                                "Text": "<%=GetLangSpecText("ec_rbn_wf_edit")%>",
                                "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_edit")%>",
                                "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Edit.png",
                                "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Edit.png",
                                "Action": "javascript:ExecuteActionForSelectedRow('_sys_edit')",
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
            ActionBar.init(CustomControlsjsonObj, "actionBarDiv");
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
                       <a href="javascript:document.getElementById('gridframe').contentWindow.NavigateUp()">
                            <img src="<%=templateThemeDirectory %>Repository/ListControl/images/icons-ribbon/icon-up.png" style="border-width:0px;" 
                                    height="36" width="36" alt="<%=GetLangSpecText("ec_rbn_wf_navigate_alt") %>"/>
                       </a>
                     </td>
                    </tr>
                </table>
        </div>
        <div class="sectiontitle divdowntext">
            <%=GetLangSpecText("ec_rbn_wf_navigate")%>
        </div>
    </div>


    <div class="divMenu" style="width: 130px;">
        <div class="divTopImage" style="width: 100%">
            <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 0; border-collapse: collapse; border: 0px solid;">
                <tr>
                    <td style="height: 25px; text-align: center; padding: 2px">
                        <a href="javascript:ExecuteAction('_sys_new')" class="sectionitem">
                            <img alt="<%=GetLangSpecText("FormMyNewControl") %>" src="<%=templateThemeDirectory %>Repository/ListControl/images/icons-ribbon/SAP-newConnection.png"                                                    
                                hspace="2" align="absmiddle" border="0" height="23" width="23" /><%=GetLangSpecText("FormMyNewCustomControl") %>
                        </a>
                    </td>
                    </tr>
                <tr>
                    <td style="height: 25px; text-align: center; padding: 2px">
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
            <%=GetLangSpecText("ec_rbn_form_new")%>
        </div>
    </div>

    <div class="divMenu" style="width: 110px;">
        <div class="divTopImage">
            <table style="width:100%; height:65px;border-width:0;border-collapse:separate;border-spacing:2px" >
                <tr>
                    <td style="height:25px;text-align:left;">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_edit')" class="sectionitem">
                                                    <img alt="<%=GetLangSpecText("ec_rbn_wf_edit_alttext")%>" src="<%=templateThemeDirectory %>Repository/ListControl/images/icons-ribbon/icon-edit.png"
                                                        hspace="0" align="absmiddle" border="0" height="23" width="23" />
                                                    <%=GetLangSpecText("ec_rbn_wf_edit")%>
                                                </a></span>
                    </td>
                </tr>
                <tr>
                    <td style="height:25px;text-align:left;">
                         <span><a href="javascript:ExecuteActionForSelectedRow('_sys_delete')" class="sectionitem">
                                                    <img alt=" <%=GetLangSpecText("ec_rbn_wf_deleteform_alttext") %>" src="<%=templateThemeDirectory %>Repository/ListControl/images/icons-ribbon/delete.png"
                                                        hspace="0" align="absmiddle" border="0" width="23" height="23" />
                                                    <%=GetLangSpecText("ec_rbn_wf_delete") %>
                                                </a></span>
                    </td>
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
            <%=GetLangSpecText("ec_rbn_wf_actions") %>
        </div>
    </div>


    <div class="divMenu" style="width: 80px;">
        <div class="divTopImage" style="width: 100%">
             <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 0; border-collapse: collapse; border: 0px solid;">
                <tr>
                    <td style="height: 25px; text-align: center; padding: 2px">           
                         <a href="javascript:ExecuteSettingsActionFlag('_sys_security_settings')">
                              <img src="<%=templateThemeDirectory %>Repository/ListControl/images/icons-ribbon/icon-settings.png" width="35" height="37" border="0" alt="<%=GetLangSpecText("ec_rbn_nl_security_alt") %>"/>
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


