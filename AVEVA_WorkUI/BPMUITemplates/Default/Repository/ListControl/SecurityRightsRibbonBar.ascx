<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SecurityRightsRibbonBar.ascx.cs"
    Inherits="BPMUITemplates_Default_Repository_ListControl_SecurityRightsRibbonBar" %>

<link href="<%=ThemeURL%>Common/StyleSheet/Global.css" rel="stylesheet" />

<%--Showing the Action Bar in the Div Element - Start--%>
        <div class="breadcrumb" >		                          
            <div class="actionItem"></div>   
            <div id="actionBarDiv" class="actionBarDiv"></div>
        </div>
<%--Showing the Action Bar in the Div Element - End--%>


<script language="javascript">

    function ExecuteAction(command) {
        LocalizeMessages();
        document.getElementById("gridframe").contentWindow.ExecuteActionByName(command);    
   
    }
    
    function ExecuteActionForSelectedRow(command){
        LocalizeMessages();
    
        document.getElementById("gridframe").contentWindow.ExecuteActionForSelectedRow(command);
    
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
        ActionBar.showRightMenu(RightSecurityJsonObj);
    }

    var SecurityRightsjsonObj =
        [
            {
                "Up":
                  {
                      "Id": "498D4CBB-2446-493D-983A-8DFF0BD20AD8",
                      "Text": " <%=GetLangSpecText("ec_rbn_wf_navigate") %>",
                      "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_navigate_alt") %>",
                      "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-Up.png",
                      "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Up.png",
                      "Action": "javascript:PreviouPgaeCall()",
                      "OpenMode": "Popup",
                      "SubItems": []
                  }
            },
            {
                "New": {
                    "Id": "E53C245D-E05B-4D4F-820D-40AD26479887",
                    "Text": "<%=GetLangSpecText("ec_rbn_new")%>",
                    "Tooltip": "<%=GetLangSpecText("ec_rbn_securityright_new")%>",
                    "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-New.png",
                    "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-New.png",
                    "Action": "javascript:ExecuteAction('_sys_new')",
                    "OpenMode": "Popup",
                    "SubItems": []
                }
            }
        ];


    var RightSecurityJsonObj =
                    [

                        {
                            "Edit":
                            {
                                "Id": "5987319E-C0E4-4142-9C01-53389025A3BF",
                                "Text": "<%=GetLangSpecText("ec_rbn_ver_edit")%>",
                                "Tooltip": "<%=GetLangSpecText("ec_rbn_securityright_edit") %>",
                                "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-Edit.png",
                                "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Edit.png",
                                "Action": "javascript:ExecuteActionForSelectedRow('_sys_edit')",
                                "OpenMode": "Popup",
                                "SubItems": []
                            },
                        },

                        {
                            "View":
                            {
                                "Id": "BB0027D5-8883-4D5A-B0CB-F3C6F61D0AA9",
                                "Text": "<%=GetLangSpecText("ec_rbn_view") %>",
                                "Tooltip": "<%=GetLangSpecText("ec_rbn_securityright_view") %>",
                                "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-View.png",
                                "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-View.png",
                                "Action": "javascript:ExecuteActionForSelectedRow('_sys_view_rights')",
                                "OpenMode": "Popup",
                                "SubItems": []
                            },
                        },

                        {
                            "Delete":
                            {
                                "Id": "75211C43-A0E2-4BF5-A182-3B5D78E74700",
                                "Text": "<%=GetLangSpecText("ec_rbn_wf_delete") %>",
                                "Tooltip": "<%=GetLangSpecText("ec_rbn_securityright_delete") %>",
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
                            ActionBar.init(SecurityRightsjsonObj, "actionBarDiv");
                        }

                        //Loading the Action Bar 
                        LoadActionBar();

                        function PreviouPgaeCall() {

                            var curstr = parent.document.location.href;
                            curstr = curstr.replace("SecurityRightsList.aspx", "RepositorySettings.aspx");
                            parent.document.location.href = curstr;
                            //var refPage = document.referrer;
                            //if (refPage.indexOf("FromArchestrA") != -1) {
                            //    parent.document.location.href = "RepositorySettings.aspx?FromArchestrA=true";
                            //}
                        }
</script>


<div style="width: 100%; height: 100%;display:none;" class="divMain">
    <div class="divMenu" style="width: 150px;">
            <div class="divTopImage" style="width:100%">           
                           <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 0; border-collapse: collapse; border: 0px solid;">
                <tr>
                    <td style="height: 25px; text-align: center; padding: 2px">
                 <a href="javascript:ExecuteAction('_sys_new')" class="sectionitem">
                    <img src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/new-security.png" style="vertical-align:middle;border:0;" alt="<%=GetLangSpecText("ec_rbn_securityright_new")%>"/></a>
            </td>
                </tr>
            </table>
                        </div>
            <div class="sectiontitle divdowntext">
		    <%=GetLangSpecText("ec_rbn_securityright_new")%>
            </div>
    </div>

    <div class="divMenu" style="width: 190px;">
        <div class="divTopImage">
            <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 2px; border-collapse: separate">
                <tr>
                    <td  style="text-align:left">
                         <span><a href="javascript:ExecuteActionForSelectedRow('_sys_edit')" class="sectionitem">
                                                    <img src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/icon-edit.png"
                                                        border="0" hspace="0" width="23" height="23" align="absmiddle" alt="<%=GetLangSpecText("ec_rbn_edit_securityGroup_alttext") %>" />
                                                    <%=GetLangSpecText("ec_rbn_ver_edit")%>
                                                </a></span>
                    </td>
                    <td style="text-align:left">
                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_view_rights')"    class="sectionitem"">
                                                    <img src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/icon-view-item.png" 
                                                        style="border:0px;vertical-align:middle;" alt="<%=GetLangSpecText("ec_rbn_securityright_view") %>" />
                            <span><%=GetLangSpecText("ec_rbn_view") %>
                                                        </a></span>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:left">
                         <span><a href="javascript:ExecuteActionForSelectedRow('_sys_delete')" class="sectionitem">
                                                    <img src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/delete.png" border="0" height="23" width="23"
                                                        hspace="0" align="absmiddle" alt="<%=GetLangSpecText("ec_rbn_securityright_delete") %>" />
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

    

</div>


