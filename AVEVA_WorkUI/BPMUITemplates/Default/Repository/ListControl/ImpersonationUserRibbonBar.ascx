<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.AuthenticationUserRibbonBar" %>
  <!--[if lt IE 7]>
  <script defer type="text/javascript" src="scripts/pngfix.js"></script>
  <![endif]-->
<link type="text/css" rel="stylesheet" href="<%=ThemeURL%>Common/StyleSheet/Global.css" /> 


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
        document.getElementById("gridframe").contentWindow.ExecuteActionByName(command);

        HideSubItemsActionBar();

        if (command == "_sys_security_settings") {
            ImpersonationUsersjsonObj = "";
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
    }

    /* Showing the Right Action Bar */
    function LoadRightActionBar() {

        if (ActionBar._rightMenu) {
            ActionBar.hideRightMenu();
        }
        ActionBar.showRightMenu(RightImpersonationUsersJsonObj);
    }

    var ImpersonationUsersjsonObj =
        [
            {
                "New": {
                    "Id": "E53C245D-E05B-4D4F-820D-40AD26479887",
                    "Text": "<%=GetLangSpecText("_Ec_Impersonate_New")%>",
                    "Tooltip": "<%=GetLangSpecText("_Ec_Impersonate_NewAlttext")%>",
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


    var RightImpersonationUsersJsonObj =
                        [
                            {
                                "Edit":
                                    {
                                        "Id": "5987319E-C0E4-4142-9C01-53389025A3BF",
                                        "Text": "<%=GetLangSpecText("_Ec_Impersonate_Edit")%>",
                                        "Tooltip": "<%=GetLangSpecText("_Ec_Impersonate_Edit_Alttext")%>",
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
                                        "Text": "<%=GetLangSpecText("_Ec_Impersonate_Delete")%>",
                                        "Tooltip": "<%=GetLangSpecText("_Ec_Impersonate_Delete_AltText")%>",
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
                    ActionBar.init(ImpersonationUsersjsonObj, "actionBarDiv");
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
             <a href="javascript:ExecuteSettingsActionFlag('_sys_new')" class="sectionitem">
               <img alt="<%=GetLangSpecText("_Ec_Impersonate_NewAlttext")%>" src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/SAP-newConnection.png" border="0" width="30" height="30" />
             </a>
                        </td>
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
           <%=GetLangSpecText("_Ec_Impersonate_New")%>
        </div>
    </div>
    <div class="divMenu" style="width: 120px;">
        <div class="divTopImage">
            <table style="width:110px; height:65px;border-width:0;border-collapse:separate;border-spacing:2px" >
                <tr>
                    <td style="height:20px;text-align:left;">                      

                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_edit')" class="sectionitem">
                                <img alt="<%=GetLangSpecText("_Ec_Impersonate_Edit_Alttext")%>" src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/icon-edit.png"
                                    hspace="0" align="absmiddle" border="0"  width="21" height="21"/>
                                <%=GetLangSpecText("_Ec_Impersonate_Edit")%>
                            </a>
                        </span>
                    </td>
                </tr>
                <tr>
                    <td style="height:20px;text-align:left;">
                         <span><a href="javascript:ExecuteActionForSelectedRow('_sys_delete')" class="sectionitem">
                                                    <img alt="<%=GetLangSpecText("_Ec_Impersonate_Delete_AltText")%>" src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/delete.png"
                                                        hspace="0" align="absmiddle" border="0" width="21" height="21"/>
                                                    <%=GetLangSpecText("_Ec_Impersonate_Delete")%>
                                                </a></span>
                    </td>
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
            <%=GetLangSpecText("_Ec_Impersonate_Actions")%>
        </div>
    </div>
    <div class="divMenu" style="width:80px;">
        <div class="divTopImage" style="width:100%">            
            <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 0; border-collapse: collapse; border: 0px solid;">
                <tr>
                    <td style="height: 25px; text-align: center; padding: 2px">
             <a href="javascript:ExecuteSettingsActionFlag('_sys_security_settings')" class="sectionitem">
               <img src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/icon-settings.png" border="0" alt="<%=GetLangSpecText("ec_rbn_nl_security_alt") %>" width="36" height="36"/>
             </a>
                        </td>
                </tr>
            </table>
        </div>
    
    <div class="sectiontitle divdowntext">
        <%=GetLangSpecText("ec_rbn_wf_settings")%>
    </div>
    </div>
</div>




