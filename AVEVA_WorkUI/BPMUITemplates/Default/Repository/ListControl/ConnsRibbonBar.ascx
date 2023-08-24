<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.AuthenticationUserRibbonBar" %>
<link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemeURL)%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
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

    var DbConnjsonObj =
        [
            {
                "New": {
                    "Id": "E53C245D-E05B-4D4F-820D-40AD26479887",
                    "Text": "<%=GetLangSpecText("ec_dblookupnew")%>",
                    "Tooltip": "<%=GetLangSpecText("ec_dblookupnew_alttext")%>",
                    "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-New.png",
                    "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-New.png",
                    "Action": "javascript:ExecuteSettingsActionFlag('_sys_new')",
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


  var RightDbConnJsonObj =
            [

                {
                    "Edit":
                    {
                        "Id": "5987319E-C0E4-4142-9C01-53389025A3BF",
                        "Text": "<%=GetLangSpecText("_Ec_Impersonate_Edit")%>",
                        "Tooltip": "<%=GetLangSpecText("_Ec_dblookup_Edit_Alttext")%>",
                        "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-Edit.png",
                        "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Edit.png",
                        "Action": "javascript:ExecuteActionForSelectedRow('_sys_edit')",
                        "OpenMode": "Popup",
                        "SubItems": []
                    },
                },
                {
                    "Delete":
                    {
                        "Id": "75211C43-A0E2-4BF5-A182-3B5D78E74700",
                        "Text": "<%=GetLangSpecText("_Ec_Impersonate_Delete")%>",
                        "Tooltip": "<%=GetLangSpecText("_Ec_dblookup_Delete_Alttext")%>",
                        "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-Delete.png",
                        "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Delete.png",
                        "Action": "javascript:ExecuteActionForSelectedRow('_sys_delete')",
                        "OpenMode": "Popup",
                        "SubItems": []
                    },
                }
          ];

        //Function for loading the action bar 
        function LoadActionBar() {
            ActionBar.init(DbConnjsonObj, "actionBarDiv");
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
                        <a href="javascript:ExecuteSettingsActionFlag('_sys_new')" class="sectionitem">
                            <img alt=" <%=GetLangSpecText("ec_dblookupnew_alttext")%>" src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/SAP-newConnection.png"
                                style="border-width:0" width="36" height="36" />
                        </a>
                     </td>
                    </tr>
                </table>
        </div>
        <div class="sectiontitle divdowntext">
            <%=GetLangSpecText("ec_dblookupnew")%>
        </div>
    </div>
    <div class="divMenu" style="width: 110px;">
        <div class="divTopImage">
            <table style="width:100%; height:65px;border-width:0;border-collapse:separate;border-spacing:2px" >
                <tr>
                    <td style="height:30;text-align:left;">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_edit')" class="sectionitem">
                            <img alt="<%=GetLangSpecText("_Ec_dblookup_Edit_Alttext")%>" src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/icon-edit.png"
                               style="vertical-align:middle;border-width:0" width="23" height="23" />
                                    <%=GetLangSpecText("_Ec_Impersonate_Edit")%></a></span>
                    </td>
                </tr>
                <tr>
                    <td style="height:30;text-align:left;">
                        <a href="javascript:ExecuteActionForSelectedRow('_sys_delete')" class="sectionitem">
                            <img alt="<%=GetLangSpecText("_Ec_dblookup_Delete_Alttext")%>" src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/delete.png"
                               style="vertical-align:middle;border-width:0" height="23" width="23" />
                            <%=GetLangSpecText("_Ec_Impersonate_Delete")%></a>
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
                               style="border-width:0" alt="<%=GetLangSpecText("ec_rbn_nl_security_alt") %>" width="36" height="36" />
                        </a>
                        </td>
                    </tr>
                 </table>
        </div>
    
    <div class="sectiontitle divdowntext">
        <%=GetLangSpecText("ecm_rbn_bztcon_settings") %>
    </div>
    </div>
</div>
