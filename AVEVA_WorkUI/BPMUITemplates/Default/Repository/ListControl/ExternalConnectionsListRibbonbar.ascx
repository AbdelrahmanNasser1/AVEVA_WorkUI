<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.ExternalConnectionsListRibbonbar" %>
<!--[if lt IE 7]>
  <script defer type="text/javascript" src="scripts/pngfix.js"></script>
  <![endif]-->
<link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemeURL)%>Common/StyleSheet/Global.css" />

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
        ActionBar.showRightMenu(RightExternalConnjsonObj);
    }

    var ExternalConnjsonObj =
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
                    "Id":"E53C245D-E05B-4D4F-820D-40AD26479887",
                    "Text":"<%=GetLangSpecText("ec_rbn_form_new")%>",
                    "Tooltip": "<%=GetLangSpecText("ec_rbn_ExtConn_newAlt")%>",
                    "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-New.png",
                    "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-New.png",
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
        
    var ExternalConnjsonObjForOPCUA =
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
                    "Text": "<%=GetLangSpecText("ec_rbn_form_new")%>",
                    "Tooltip": "<%=GetLangSpecText("ec_rbn_ExtConn_newAlt")%>",
                    "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-New.png",
                    "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-New.png",
                    "Action": "",
                    "OpenMode": "Popup",
                    "SubItems": [
                        {
                            "Id": "7EC08078-90F1-4699-AA43-874CD492B44C",
                            "Text": "<%=GetLangSpecText("ec_rbn_form_new")%>",
                            "Tooltip": "<%=GetLangSpecText("ec_rbn_ExtConn_newAlt")%>",
                            "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-New.png",
                            "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-New.png",
                            "Action": "javascript:ExecuteAction('_sys_new')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        },
                        {
                            "Id": "00DE99AC-11D4-49E8-9B3A-66D774B91D86",
                            "Text": "<%=GetLangSpecText("OPCUA")%>",
                            "Tooltip": "<%=GetLangSpecText("ec_rbn_ec_newopc_tooltip")%>",
                            "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/icon-new-OPC-event.png",
                            "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/icon-new-OPC-event.png",
                            "Action": "javascript:ExecuteAction('_sys_new_opc')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        }
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

        var RightExternalConnjsonObj =
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
                    var1 = null;
                    var1 = "<%=checkOPCUAInstalled%>"
                    if (var1 == "") {
                        ActionBar.init(ExternalConnjsonObj, "actionBarDiv");
                    }
                    else {
                        ActionBar.init(ExternalConnjsonObjForOPCUA, "actionBarDiv");
                    }
                }

                //Loading the Action Bar 
                LoadActionBar();

</script>
<div style="width: 100%; height: 100%; white-space: nowrap;display:none;" class="divMain">

    <div class="divMenu" style="width: 80px;">
        <div class="divTopImage" style="width: 100%">
            <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 0; border-collapse: collapse; border: 0px solid;">
                <tr>
                    <td style="height: 25px; text-align: center; padding: 2px">
                        <a href="javascript:document.getElementById('gridframe').contentWindow.NavigateUp()">
                            <img src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/icon-up.png" style="border-width: 0px;"
                                height="36" width="36" alt="<%=GetLangSpecText("ec_rbn_wf_navigate_alt") %>" />
                        </a>
                    </td>
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
            <%=GetLangSpecText("ec_rbn_wf_navigate")%>
        </div>
    </div>


    <div class="divMenu" style="width: 100px;">
        <div class="divTopImage" style="width: 100%">
            <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 0; border-collapse: collapse; border: 0px solid;">
                <tr>
                    <td style="height: 25px; text-align: center; padding: 2px">
                        <a href="javascript:ExecuteAction('_sys_new')" class="sectionitem">
                            <img alt="<%=GetLangSpecText("ec_rbn_wf_newlist_new_alttext") %>" src="<%=ThemeURL %>Repository/ListControl/images/icons-ribbon/newItemIcon.png"
                                hspace="2" align="absmiddle" border="0" />
                        </a>
                    </td>
                    <%=TopRowActionsNew %>
                </tr>
                 <tr>
                    <%=BottomRowActionsNew%>
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
            <%=GetLangSpecText("ec_rbn_form_new")%>
        </div>
    </div>

    <div class="divMenu" style="width: 120px;">
        <div class="divTopImage">
            <table style="width: 100%; height: 65px; border-width: 0; border-collapse: separate; border-spacing: 2px">
                <tr>
                    <td style="height: 25px; text-align: left;">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_edit')" class="sectionitem">
                            <img alt="<%=GetLangSpecText("ec_rbn_wf_edit_alttext")%>" src="<%=ThemeURL %>Repository/ListControl/images/icons-ribbon/icon-edit.png"
                                hspace="0" align="absmiddle" border="0" height="23" width="23" />
                            <%=GetLangSpecText("ec_rbn_wf_edit")%>
                        </a></span>
                    </td>
                </tr>
                <tr>
                    <td style="height: 25px; text-align: left;">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_delete')" class="sectionitem">
                            <img alt=" <%=GetLangSpecText("ec_rbn_wf_deleteform_alttext") %>" src="<%=ThemeURL %>Repository/ListControl/images/icons-ribbon/delete.png"
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
                            <img src="<%=ThemeURL %>Repository/ListControl/images/icons-ribbon/icon-settings.png" width="35" height="37" border="0" alt="<%=GetLangSpecText("ec_rbn_nl_security_alt") %>" />
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
