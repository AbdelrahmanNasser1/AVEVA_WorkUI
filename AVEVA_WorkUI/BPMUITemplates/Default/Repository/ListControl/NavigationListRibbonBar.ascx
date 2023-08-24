<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.NavigationListRibbonBar" %>

<link href="<%=ThemeURL%>Common/StyleSheet/Global.css" rel="stylesheet" />

<%--Showing the Action Bar in the Div Element - Start--%>
        <div class="breadcrumb" >		                          
            <div class="actionItem"></div>   
            <div id="actionBarDiv" class="actionBarDiv"></div>
        </div>
<%--Showing the Action Bar in the Div Element - End--%>
    


<script language="javascript">
    function ExecuteSettingsActionFlag(command) {
        LocalizeMessages();
        document.getElementById("gridframe").contentWindow.ExecuteActionByName(command);

        HideSubItemsActionBar();

        if (command == "_sys_security_settings") {
            NavigationListjsonObj = "";
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
    function LocalizeMessages() {
        document.getElementById("gridframe").contentWindow.cannotPerDisable = '<%=GetLangSpecText("ec_rbn_wf_cannotperformondisabled")%>';
        document.getElementById("gridframe").contentWindow.noRowSelected = '<%=GetLangSpecText("ec_rbn_wf_norowselected")%>';
        document.getElementById("gridframe").contentWindow.norightforaction = '<%=GetLangSpecText("ec_rbn_wf_norightforaction")%>';
        document.getElementById("gridframe").contentWindow.sysDel = '<%=GetLangSpecText("ec_rbn_wf_sysdelete")%>';
        document.getElementById("gridframe").contentWindow.NotAbleToEditFolder = '<%=GetLangSpecText("ec_rbn_nav_noedit_folder")%>';
    
    }
    function Execute(command)
    {
        var flag =document.getElementById("gridframe").contentWindow.IsRowSelected();
        if(flag)
        {
            //var Yes = confirm('Are you sure you want to delete?');
            //if(Yes)
                ExecuteActionForSelectedRow(command);
        }
        else {
            alert('<%=GetLangSpecText("ec_rbn_nav_select_a_row")%>');
        }
    }
    /*function RefreshGrid(){
        document.getElementById("gridframe").contentWindow.RefreshGrid();
    }*/

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

        ActionBar.showRightMenu(RightNavigationJsonObj);

    }
    function PreviouPageCall() {

        var curstr = parent.document.location.href;
        curstr = curstr.replace("NavigationList.aspx", "RepositorySettings.aspx");
        parent.document.location.href = curstr;
    }

    var NavigationListjsonObj =
         [
             {
                 "Up":
                   {
                       "Id": "498D4CBB-2446-493D-983A-8DFF0BD20AD8",
                       "Text": " <%=GetLangSpecText("ec_rbn_wf_navigate") %>",
                      "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_navigate_alt") %>",
                      "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-Up.png",
                      "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Up.png",
                     "Action": "javascript:PreviouPageCall()",
                      "OpenMode": "Popup",
                      "SubItems": []
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
                            "Id": "DEE26CA6-205C-4C7D-961F-5F8AD2C22181",
                            "Text": "<%=GetLangSpecText("ec_rbn_nl_navigation")%>",
                            "Tooltip": "<%=GetLangSpecText("ec_rbn_nl_navigation_navlink_alt")%>",
                            "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-Navigation.png",
                            "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Navigation.png",
                            "Action": "javascript:ExecuteAction('_sys_new')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        },
                        {
                            "Id": "0FA489EF-1F59-4A1D-B632-35DFCF144F82",
                            "Text": "<%=GetLangSpecText("ec_rbn_nl_formlink")%>",
                            "Tooltip": "<%=GetLangSpecText("ec_rbn_nl_navigation_formlink_alt")%>",
                            "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-Form-Link.png",
                            "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Form-Link.png",
                            "Action": "javascript:ExecuteAction('_sys_new_form_link')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        },
                        {
                            "Id": "80C33179-9B75-4248-A466-DA7F65789C0A",
                            "Text": "<%=GetLangSpecText("ec_rbn_nl_listlink")%>",
                            "Tooltip": "<%=GetLangSpecText("ec_rbn_nl_navigation_listlink_alt")%>",
                            "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-List-Link.png",
                            "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-List-Link.png",
                            "Action": "javascript:ExecuteAction('_sys_new_list_link')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        },
                        
                        {
                            "Id": "9998D86A-DAB1-4AB5-9363-7FD9EABAD7E9",
                            "Text": "<%=GetLangSpecText("ec_rbn_wf_newfolder") %>",
                            "Tooltip": "<%=GetLangSpecText("ec_rbn_nl_folder_new_folder")%>",
                            "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-folder.png",
                            "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-folder.png",
                            "Action": "javascript:ExecuteSettingsActionFlag('_sys_newfolder')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        },
						{
                            "Id": "89C33179-9B75-4248-A466-DA7F65789C0A",
                            "Text": "<%=GetLangSpecText("ec_rbn_nl_dashboard_link")%>",
                            "Tooltip": "<%=GetLangSpecText("ec_rbn_nl_navigation_dashboardlink_alt")%>",
                            "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-Dashboard-Link.png",
                            "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Dashboard-Link.png",
                            "Action": "javascript:ExecuteAction('_sys_new_dashboard_link')",
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

    var RightNavigationJsonObj =
            [
                

                {
                    "Edit":
                        {
                        "Id": "5987319E-C0E4-4142-9C01-53389025A3BF",
                        "Text": "<%=GetLangSpecText("ec_rbn_nl_edit")%>",
                         "Tooltip": "<%=GetLangSpecText("ec_rbn_nl_edit_alt")%>",
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
                        "Text": "<%=GetLangSpecText("ec_rbn_nl_delete")%>",
                        "Tooltip": "<%=GetLangSpecText("ec_rbn_nl_delete_alt")%>",
                        "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-Delete.png",
                        "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Delete.png",
                        "Action": "javascript:Execute('_sys_delete')",
                        "OpenMode": "Popup",
                        "SubItems": []
                    }
                },

                 {
                     "ChangeOwner":
                        {
                            "Id": "7EF94379-B3A2-4554-97CB-F09952CF7666",
                            "Text": "<%=GetLangSpecText("ec_rbn_nl_changeowner")%>",
                            "Tooltip": "<%=GetLangSpecText("ec_rbn_nl_changeowner_alt")%>",
                            "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-Change-Owner.png",
                            "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Change-Owner.png",
                            "Action": "javascript:ExecuteActionForSelectedRow('_sys_change_owner')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        }
                 }

            ];



                //Function for loading the action bar 
                    function LoadActionBar()
                    {                   
                        ActionBar.init(NavigationListjsonObj, "actionBarDiv");                   
                    }

                    //Loading the Action Bar 
                    LoadActionBar();

                    function PreviouPgaeCall() {

                        var curstr = parent.document.location.href;
                        curstr = curstr.replace("NavigationList.aspx", "RepositorySettings.aspx");
                        parent.document.location.href = curstr;
                        //var refPage = document.referrer;
                        //if (refPage.indexOf("FromArchestrA") != -1) {
                        //    parent.document.location.href = "RepositorySettings.aspx?FromArchestrA=true";
                        //}
                    }



</script>

<div style="width: 100%; height: 100%;display:none;" class="divMain">

    <div style="width: 230px;" class="divMenu">
        <div class="divTopImage" style="width:100%;">
            <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 0; border-collapse: collapse;border:0px solid;"  >
                <tr>
                    <td style="height: 25px; text-align: left; padding-left: 10px;">
                         <span><a href="javascript:ExecuteAction('_sys_new')" class="sectionitem">
                        <img src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/add-nav.png" 
                            style="vertical-align:middle;border:0px;"  alt="<%=GetLangSpecText("ec_rbn_nl_navigation_navlink_alt")%>" /><%=GetLangSpecText("ec_rbn_nl_navigation")%></a></span>
                    </td>
                    <td style="height: 25px; text-align: left; padding-left: 10px">
                       <span><a href="javascript:ExecuteAction('_sys_new_form_link')" class="sectionitem">
                            <img src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/add-form-link.png"
                                style="vertical-align:middle;border:0px;"  alt="<%=GetLangSpecText("ec_rbn_nl_navigation_formlink_alt")%>"
                                 />
                            <%=GetLangSpecText("ec_rbn_nl_formlink")%>
                        </a></span>
                    </td>
                    </tr>
                <tr>
                    <td style="height: 25px; text-align: left; padding-left: 10px">
                        <span><a href="javascript:ExecuteAction('_sys_new_list_link')" class="sectionitem">
                                                        <img src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/add-list-link.png"
                                                            style="vertical-align:middle;border:0px;"  alt="<%=GetLangSpecText("ec_rbn_nl_navigation_listlink_alt")%>" />
                                                        <%=GetLangSpecText("ec_rbn_nl_listlink")%>
                                                    </a></span>
                    </td>
                    <td style="height: 25px; text-align: left; padding-left: 10px">
                        <span><a href="javascript:ExecuteSettingsActionFlag('_sys_newfolder')" class="sectionitem">
                            <img src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/folder-icon.png" style="vertical-align:middle;border:0px;" alt="<%=GetLangSpecText("ec_rbn_nl_folder_new_folder")%>" />
                            <%=GetLangSpecText("ec_rbn_wf_newfolder") %>
                        </a></span>
                    </td>
                    
                </tr>
               
            </table>
        </div>
        <div class="sectiontitle divdowntext">
            <%=GetLangSpecText("ec_rbn_nl_new") %>
        </div>
    </div>

     <div style="width: 230px;" class="divMenu">
        <div class="divTopImage">
            <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 0; border-collapse: collapse">
                <tr>
                    <td style="height: 25px; text-align: left; padding: 2px;">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_edit')" class="sectionitem">
                            <img src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/icon-edit.png"
                                style="vertical-align:middle;border:0px;" alt="<%=GetLangSpecText("ec_rbn_nl_edit_alt")%>" />
                            <%=GetLangSpecText("ec_rbn_nl_edit")%>
                        </a></span>
                    </td>
                    <td style="height: 25px; text-align: left; padding: 2px;">
                        <span><a href="javascript:Execute('_sys_delete')" class="sectionitem">
                            <img src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/delete.png" 
                                style="vertical-align:middle;border:0px;"  alt="<%=GetLangSpecText("ec_rbn_nl_delete_alt")%>"  />
                            <%=GetLangSpecText("ec_rbn_nl_delete")%>
                        </a></span>
                    </td>
                    
                </tr>
                <tr>
                    <td style="height: 25px; text-align: left; padding: 2px">
                         <span><a href="javascript:ExecuteActionForSelectedRow('_sys_change_owner')" class="sectionitem">
                                                    <img src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/changeowner.png"
                                                        hspace="0" align="absmiddle" alt="<%=GetLangSpecText("ec_rbn_nl_changeowner_alt")%>"
                                                        border="0" width="22" height="22" />
                                                    <%=GetLangSpecText("ec_rbn_nl_changeowner")%>
                                                </a></span>
                    </td>
                    
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
            <%=GetLangSpecText("ec_rbn_nl_actions") %>
        </div>
    </div>

    <div style="width: 85px;" class="divMenu">
        <div class="divTopImage">
              <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 0; border-collapse: collapse; border: 0px solid;">
                <tr>
                    <td style="height: 25px; text-align: center; padding: 2px">
            <a href="javascript:ExecuteAction('_sys_organize')" class="sectionitem">
                <img src="<%=ThemeURL %>Repository/ListControl/images/icons-ribbon/icon-organize-items.png"
                    style="border-width: 0" alt="<%=GetLangSpecText("ec_rbn_wf_organize") %>" /></a>
                        </td>
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
            <%=GetLangSpecText("ec_rbn_wf_organize")%>
        </div>
    </div>
    <div style="width: 85px;" class="divMenu">
        <div class="divTopImage">
           <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 0; border-collapse: collapse; border: 0px solid;">
                <tr>
                    <td style="height: 25px; text-align: center; padding: 2px"> <a href="javascript:ExecuteSettingsActionFlag('_sys_security_settings')" class="sectionitem">
                <img src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/icon-settings.png"
                    style="border-width: 0; vertical-align: middle;" alt="<%=GetLangSpecText("ec_rbn_nl_security_alt") %>" />
            </a>
                    </td>
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
            <%=GetLangSpecText("ec_rbn_nl_settings") %>
        </div>
    </div>

</div>


