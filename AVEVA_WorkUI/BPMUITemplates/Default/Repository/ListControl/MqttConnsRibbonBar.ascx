<%@ Control Language="C#"  AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.MqttConnectionRibbonBar" %>

<link href="<%=ThemeUrl%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />

<%--Showing the Action Bar in the Div Element - Start--%>
<div class="breadcrumb">
    <div class="actionItem"></div>
    <div id="actionBarDiv" class="actionBarDiv"></div>
</div>
<%--Showing the Action Bar in the Div Element - End--%>


<script type="text/javascript">
    function ExecuteSettingsActionFlag(command) {
        // Ayyub :: In MOM it is decided that List Settings should come from Ribbonbar(irrespective of whether item is selected or not) and ListItem settings should come from context menu
        LocalizeMessages();
        document.getElementById("gridframe").contentWindow.ExecuteActionByName(command);
        if (command == "_sys_security_settings") {
            DbConnjsonObj = "";
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
    }

    /* Showing the Right Action Bar */
    function LoadRightActionBar() {

        if (ActionBar._rightMenu) {
            ActionBar.hideRightMenu();
        }
        ActionBar.showRightMenu(RightDbConnJsonObj);
    }

    var mqttconnjsonObj =
        [
            {
                "Up":
                    {
                        "Id": "498D4CBB-2446-493D-983A-8DFF0BD20AD8",
                        "Text": " <%=GetLangSpecText("ec_rbn_wf_navigate") %>",
                        "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_navigate_alt") %>",
                        "Image": "<%=ThemeUrl%>Repository/ListControl/images/ActionBarIcons/AB-Up.png",
                        "HoverImage": "<%=ThemeUrl%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Up.png",
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
                    "Text": "<%=GetLangSpecText("ec_rbn_wf_new")%>",
                    "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_new")%>",
                    "Image": "<%=ThemeUrl%>Repository/ListControl/images/ActionBarIcons/AB-New.png",
                    "HoverImage": "<%=ThemeUrl%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-New.png",
                    "Action": "",
                    "OpenMode": "Popup",
                    "SubItems": [
                        {
                            "Id": "80C33179-9B75-4248-A466-DA7F65789C0A",
                            "Text": "<%=GetLangSpecText("ecm_rbn_mqtt_new") %>",
                             "Tooltip": "<%=GetLangSpecText("ecm_rbn_mqtt_new_alt") %>",
                             "Image": "<%=ThemeUrl%>Repository/ListControl/images/ActionBarIcons/AB-List.png",
                             "HoverImage": "<%=ThemeUrl%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-List.png",
                             "Action": "javascript:ExecuteAction('_sys_new')",
                             "OpenMode": "Popup",
                             "SubItems": []
                         },

                         {
                             "Id": "799F6317-9BD8-4141-9408-7F32EDB47B64",
                             "Text": "<%=GetLangSpecText("ec_rbn_wf_newfolder") %>",
                           "Tooltip": "<%=GetLangSpecText("ec_rbn_nl_folder") %>",
                           "Image": "<%=ThemeUrl%>Repository/ListControl/images/ActionBarIcons/AB-Folder.png",
                           "HoverImage": "<%=ThemeUrl%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Folder.png",
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
                        "Image": "<%=ThemeUrl%>Repository/ListControl/images/ActionBarIcons/AB-Organize.png",
                        "HoverImage": "<%=ThemeUrl%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Organize.png",
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
                        "Image": "<%=ThemeUrl%>Repository/ListControl/images/ActionBarIcons/AB-Security.png",
                        "HoverImage": "<%=ThemeUrl%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Security.png",
                        "Action": "javascript:ExecuteSettingsActionFlag('_sys_security_settings')",
                        "OpenMode": "Popup",
                        "SubItems":
                            [

                            ]
                    }
            }

        ];


    var RightDbConnJsonObj =
        [

            {
                "Edit":
                    {
                        "Id": "5987319E-C0E4-4142-9C01-53389025A3BF",
                        "Text": "<%=GetLangSpecText("ecm_rbn_mqtt_edit")%>",
                        "Tooltip": "<%=GetLangSpecText("ecm_rbn_mqtt_edit_alt")%>",
                        "Image": "<%=ThemeUrl%>Repository/ListControl/images/ActionBarIcons/AB-Edit.png",
                        "HoverImage": "<%=ThemeUrl%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Edit.png",
                        "Action": "javascript:ExecuteActionForSelectedRow('_sys_edit')",
                        "OpenMode": "Popup",
                        "SubItems": []
                  },
          },
          {
              "View":
                  {
                      "Id": "D147D7FA-2307-4C2C-B1D7-A9A8B6D71C3E",
                      "Text": "<%=GetLangSpecText("ecm_rbn_mqtt_view")%>",
                      "Tooltip": "<%=GetLangSpecText("ecm_rbn_mqtt_view_alt") %>",
                      "Image": "<%=ThemeUrl%>Repository/ListControl/images/ActionBarIcons/AB-View.png",
                      "HoverImage": "<%=ThemeUrl%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-View.png",
                      "Action": "javascript:ExecuteActionForSelectedRow('_sys_view_mqttconn')",
                      "OpenMode": "Popup",
                      "SubItems": []
                  }
          },
          {
              "Delete":
                  {
                      "Id": "75211C43-A0E2-4BF5-A182-3B5D78E74700",
                      "Text": "<%=GetLangSpecText("ecm_rbn_mqtt_delete")%>",
                      "Tooltip": "<%=GetLangSpecText("ecm_rbn_mqtt_delete_alt")%>",
                      "Image": "<%=ThemeUrl%>Repository/ListControl/images/ActionBarIcons/AB-Delete.png",
                      "HoverImage": "<%=ThemeUrl%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Delete.png",
                      "Action": "javascript:ExecuteActionForSelectedRow('_sys_delete')",
                      "OpenMode": "Popup",
                      "SubItems": []
                    },
            }
        ];

    //Function for loading the action bar 
    function LoadActionBar() {
        ActionBar.init(mqttconnjsonObj, "actionBarDiv");
    }

    //Loading the Action Bar 
    LoadActionBar();


</script>
