<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.EventProvidersListRibbonBar" %>

<link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemeURL)%>Common/StyleSheet/Global.css" rel="stylesheet" />

<%--Showing the Action Bar in the Div Element - Start--%>
        <div class="breadcrumb" >		                          
            <div class="actionItem"></div>   
            <div id="actionBarDiv" class="actionBarDiv"></div>
        </div>
<%--Showing the Action Bar in the Div Element - End--%>


<script type="text/javascript">
    function ExecuteSettingsActionFlag(command)
    {
        LocalizeMessages();
        document.getElementById("gridframe").contentWindow.ExecuteActionByName(command);
    }
    function ExecuteAction(command){
        LocalizeMessages();
        document.getElementById("gridframe").contentWindow.ExecuteActionByName(command);    
    //IE    document.frames("gridframe").ExecuteActionByName(command);
    }
    
    function ExecuteActionForSelectedRow(command){
        LocalizeMessages();
        document.getElementById("gridframe").contentWindow.ExecuteActionForSelectedRow(command);
    //IE    document.frames("gridframe").ExecuteActionForSelectedRow(command);
    }
    function LocalizeMessages() {
        document.getElementById("gridframe").contentWindow.cannotPerDisable = '<%=GetLangSpecText("ec_rbn_wf_cannotperformondisabled")%>';
        document.getElementById("gridframe").contentWindow.noRowSelected = '<%=GetLangSpecText("ec_rbn_wf_norowselected")%>';
        document.getElementById("gridframe").contentWindow.norightforaction = '<%=GetLangSpecText("ec_rbn_wf_norightforaction")%>';
        document.getElementById("gridframe").contentWindow.sysDel = '<%=GetLangSpecText("ec_rbn_wf_sysdelete")%>';
        document.getElementById("gridframe").contentWindow.NotAbleToEditFolder = '<%=GetLangSpecText("ec_rbn_nav_noedit_folder")%>';
    }
   /* function RefreshGrid(){
        document.getElementById("gridframe").contentWindow.RefreshGrid();
    }*/

    /* Hiding the Sub items of the Action Bar */
    function HideSubItemsActionBar() {
        ActionBar.hideSubMenus();
    }

    /* Showing the Right Action Bar */
    function LoadRightActionBar() {

        if (ActionBar._rightMenu) {
            ActionBar.hideRightMenu();
        }
        ActionBar.showRightMenu(RightEventProviderJsonObj);
    }

    var EventProviderjsonObj =
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
            }<%if(platform == Skelta.FarmManager.Platform.OnPremise) { %>,
            {
                "New": {
                    "Id": "E53C245D-E05B-4D4F-820D-40AD26479887",
                    "Text": "<%=GetLangSpecText("ec_rbn_ep_New")%>",
                    "Tooltip": "<%=GetLangSpecText("ec_rbn_ep_New_alt") %>",
                    "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-New.png",
                    "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-New.png",
                    "Action": "javascript:ExecuteAction('_sys_new')",
                    "OpenMode": "Popup",
                    "SubItems": []
                }
            }
            <%}%>
        ];


            var RightEventProviderJsonObj =
                            [

                                {
                                    "Edit":
                                    {
                                        "Id": "5987319E-C0E4-4142-9C01-53389025A3BF",
                                        "Text": "<%=GetLangSpecText("ec_rbn_ep_edit")%>",
                                        "Tooltip": "<%=GetLangSpecText("ec_rbn_ep_edit_alt")%>",
                                        "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-Edit.png",
                                        "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Edit.png",
                                        "Action": "javascript:ExecuteActionForSelectedRow('_sys_edit')",
                                        "OpenMode": "Popup",
                                        "SubItems": []
                                    },
                                 },

                        {
                            "ChangeOwner":
                            {
                                "Id": "BB0027D5-8883-4D5A-B0CB-F3C6F61D0AA9",
                                "Text": "<%=GetLangSpecText("ec_rbn_ep_changeowner")%>",
                                "Tooltip": "<%=GetLangSpecText("ec_rbn_nl_changeowner_alt")%>",
                                "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-Change-Owner.png",
                                "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Change-Owner.png",
                                "Action": "javascript:ExecuteActionForSelectedRow('_sys_change_owner')",
                                "OpenMode": "Popup",
                                "SubItems": []
                            },
                        }


                    ];

                        //Function for loading the action bar 
                        function LoadActionBar() {
                            ActionBar.init(EventProviderjsonObj, "actionBarDiv");
                        }

                        //Loading the Action Bar 
                        LoadActionBar();

                        function PreviouPgaeCall() {

                            var curstr = parent.document.location.href;
                            curstr = curstr.replace("EventProvidersList.aspx", "RepositorySettings.aspx");
                            parent.document.location.href = curstr;
                            //var refPage = document.referrer;
                            //if (refPage.indexOf("FromArchestrA") != -1) {
                            //    parent.document.location.href = "RepositorySettings.aspx?FromArchestrA=true";
                            //}
                        }


</script>

<div style="width: 100%; height: 100%;display:none;" class="divMain">
<div class="divMenu" style="width: 80px;">
        <div class="divTopImage" style="width:100%">           
              <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 0; border-collapse: collapse; border: 0px solid;">
                <tr>
                    <td style="height: 25px; text-align: center; padding: 2px">
            <a href="javascript:ExecuteAction('_sys_new')" class="sectionitem">
              <img src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/icon-event-providers.png"  style="vertical-align:middle;border:0px;" alt="<%=GetLangSpecText("ec_rbn_ep_New_alt") %>" />
            </a>
                        </td>
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
		<%=GetLangSpecText("ec_rbn_ep_New")%>
        </div>
</div>


<div class="divMenu" style="width: 160px;">
        <div class="divTopImage">
            <table style="width:160px; height:65px;border-width:0;border-collapse:separate;border-spacing:2px" >
                <tr>
                    <td style="height:20px;text-align:left;">                      

                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_edit')" class="sectionitem">
                                <img src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/icon-edit.png"
                                    style="vertical-align:middle;border:0px;" alt="<%=GetLangSpecText("ec_rbn_ep_edit_alt")%>" />
                                <%=GetLangSpecText("ec_rbn_ep_edit")%>
                        </a></span>
                    </td>
                </tr>
                <tr>
                    <td style="height:20px;text-align:left;">
                         <span><a href="javascript:ExecuteActionForSelectedRow('_sys_change_owner')" class="sectionitem">
                                <img src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/changeowner.png"  style="vertical-align:middle;border:0px;" alt="<%=GetLangSpecText("ec_rbn_nl_changeowner_alt")%>" />
                                <%=GetLangSpecText("ec_rbn_ep_changeowner")%>
                         </a></span>
                    </td>
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
	     <%=GetLangSpecText("ec_rbn_ep_actions")%>
        </div>
    </div>


<div class="divMenu" style="width:80px;">
        <div class="divTopImage" style="width:100%">            
            <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 0; border-collapse: collapse; border: 0px solid;">
                <tr>
                    <td style="height: 25px; text-align: center; padding: 2px">
             <a href="javascript:ExecuteSettingsActionFlag('_sys_security_settings')" class="sectionitem">
                 <img src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/icon-settings.png" style="border:0px;vertical-align:middle;" alt="<%=GetLangSpecText("ec_rbn_nl_security_alt") %>" />
              </a>
                        </td>
                </tr>
            </table>

        </div>
    
    <div class="sectiontitle divdowntext">
	<%=GetLangSpecText("ec_rbn_ep_settings") %>
    </div>
</div>

</div>




