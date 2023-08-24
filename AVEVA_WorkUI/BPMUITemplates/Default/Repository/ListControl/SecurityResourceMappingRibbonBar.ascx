<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SecurityResourceMappingRibbonBar.ascx.cs"
    Inherits="SecurityResourceMappingRibbonBar" %>
    
<link href="<%=ThemeURL%>Common/StyleSheet/Global.css" type="text/css" rel="stylesheet" />
<%--Showing the Action Bar in the Div Element - Start--%>
        <div class="breadcrumb" >		                          
            <div class="actionItem"></div>   
            <div id="actionBarDiv" class="actionBarDiv"></div>
        </div>
<%--Showing the Action Bar in the Div Element - End--%>



<script type="text/javascript">
    function ExecuteAction(command) {
        LocalizeMessages();
        //document.frames("gridframe").ExecuteActionByName(command);
        document.getElementById("gridframe").contentWindow.ExecuteActionByName(command);
    }
    
    function ExecuteActionForSelectedRow(command){

        LocalizeMessages();
        //document.frames("gridframe").ExecuteActionForSelectedRow(command);
        document.getElementById("gridframe").contentWindow.ExecuteActionForSelectedRow(command);

    }
    function LocalizeMessages() {
        document.getElementById("gridframe").contentWindow.cannotPerDisable = '<%=GetLangSpecText("ec_rbn_wf_cannotperformondisabled")%>';
        document.getElementById("gridframe").contentWindow.noRowSelected = '<%=GetLangSpecText("ec_rbn_wf_norowselected")%>';
        document.getElementById("gridframe").contentWindow.norightforaction = '<%=GetLangSpecText("ec_rbn_wf_norightforaction")%>';
        document.getElementById("gridframe").contentWindow.sysDel = '<%=GetLangSpecText("ec_rbn_wf_sysdelete")%>';
    }
    function PreviouPgaeCall()
    {
        var parentstr = parent.document.location.href;
        parentstr = parentstr.split("?lcsuri=");
        var level = parentstr[1].split("&Level=");
        
        var curstr = document.location.href;
        var cururl = curstr.split("?lcsuri=");
        var URL;
        if(level[1]=="List")
        {
            cururl[0] = cururl[0].replace(/ListGridPage.aspx/, "ListSettings.aspx");
            URL = cururl[0].replace(/ListControl/,"Site");
            parent.document.location.href = URL + "?lcsuri="+level[0];
        }
        else
        {
            cururl[0] = cururl[0].replace(/ListGridPage.aspx/, "ListItemSettings.aspx");
            URL = cururl[0].replace(/ListControl/,"Site");
            parent.document.location.href = URL + "?lcsuri="+level[0];
        }
     //   alert(URL);
    }

    var SecurityResourceMappingJsonObj = [
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
              },
        },
        {
            "New":
                {
                    "Id": "E53C245D-E05B-4D4F-820D-40AD26479887",
                    "Text": "<%=GetLangSpecText("ec_sap_New")%>",
                    "Tooltip": "<%=GetLangSpecText("ec_rbn_resourcemapping_new")%>",
                    "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-New.png",
                    "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-New.png",
                    "Action": "javascript:ExecuteAction('_sys_new')",
                    "OpenMode": "Popup",
                    "SubItems": []
                }
        }
        
    ];

    var RightSecurityResourceMappingJsonObj =
                        [

                            {
                                "Edit":
                                {
                                    "Id": "5987319E-C0E4-4142-9C01-53389025A3BF",
                                    "Text": "<%=GetLangSpecText("ec_rbn_ver_edit")%>",
                                "Tooltip": "<%=GetLangSpecText("ec_rbn_ver_edit") %>",
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
                                "Text": "<%=GetLangSpecText("ec_rbn_wf_delete") %>",
                                "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_delete") %>",
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
                            ActionBar.init(SecurityResourceMappingJsonObj, "actionBarDiv");
                        }

                        //Loading the Action Bar 
                        LoadActionBar();

                        /* Showing the Right Action Bar */
                        function LoadRightActionBar() {

                            if (ActionBar._rightMenu) {
                                ActionBar.hideRightMenu();
                            }
                            ActionBar.showRightMenu(RightSecurityResourceMappingJsonObj);
                        }

</script>

<div style="width: 100%; height: 100%;display:none;" class="divMain">
    <div class="divMenu" style="width: 90px;">
        <div class="divTopImage" style="width: 100%">
               <%--<input id="btnBack"  class="BackButton" type="button" onclick="PreviouPgaeCall();" 
                                                    value=".." title="<%=GetLangSpecText("ec_rbn_resourcemapping_navigation_alt") %>"/>--%>
            <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 0; border-collapse: collapse; border: 0px solid;">
                <tr>
                    <td style="height: 25px; text-align: center; padding: 2px">
            <a href="javascript:PreviouPgaeCall()"
                class="sectionitem">
                <img src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/icon-up.png"
                    alt="<%=GetLangSpecText("ec_rbn_resourcemapping_navigation_alt") %>" style="border-width: 0; float: none" /></a>
                        </td>
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
           <%=GetLangSpecText("ec_rbn_navigation")%>
        </div>
    </div>
    
     <div class="divMenu" style="width: 100px;">
        <div class="divTopImage" style="width: 100%">
            <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 0; border-collapse: collapse; border: 0px solid;">
                <tr>
                    <td style="height: 25px; text-align: center; padding: 2px">
                          <a href="javascript:ExecuteAction('_sys_new')" class="sectionitem">
                                                    <img  alt="<%=GetLangSpecText("ec_rbn_resourcemapping_new") %>" src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/new-resource-mapping.png" 
                                                        border="0" style="width:25px;height:25px;"
                                                      />  
                              <%=GetLangSpecText("ec_rbn_new") %></a>
                        </td>
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
           <%=GetLangSpecText("ec_rbn_new") %>
        </div>
    </div>
    <div class="divMenu" style="width: 120px;">
        <div class="divTopImage">
            <table style="width: 100%; height: 65px; border-width: 0; border-collapse: separate; border-spacing: 2px;border:0px solid;">
               <tr>
                    <td style="height: 25px; text-align: left; padding: 2px">
                        <span>
                            <a href="javascript:ExecuteActionForSelectedRow('_sys_edit')" class="sectionitem">
                                <img alt=" <%=GetLangSpecText("ec_sap_Edit_Alttext")%>" src="<%=ThemeURL %>Repository/ListControl/images/icons-ribbon/icon-edit.png"
                                    style="vertical-align:middle;border:0px;width:21px;height:21px;" />
                                <%=GetLangSpecText("ec_rbn_ver_edit")%>
                            </a>
                        </span>
                    </td>
                </tr>
                <tr>
                    <td style="height: 25px; text-align: left; padding: 2px">
                          <span>
                            <a href="javascript:ExecuteActionForSelectedRow('_sys_delete')" class="sectionitem">
                                <img alt="<%=GetLangSpecText("ec_sap_Delete_Alttext")%>" src="<%=ThemeURL %>Repository/ListControl/images/icons-ribbon/delete.png"
                                    style="vertical-align: middle; width: 21px; height: 21px; text-align: center; border-width: 0;padding-right:3px;" />
                                <%=GetLangSpecText("ec_rbn_wf_delete")%>
                            </a>
                        </span>
                    </td>
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
            <%=GetLangSpecText("ec_rbn_wf_actions")%>
        </div>
    </div>
</div>

 
