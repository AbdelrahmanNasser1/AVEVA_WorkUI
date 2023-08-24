<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.VersioningRibbonBar" %>
<link href="<%=ThemeURL%>Common/StyleSheet/Global.css" rel="stylesheet" />

 <%--Showing the Action Bar in the Div Element - Start--%>
        <div class="breadcrumb" >		                          
            <div class="actionItem"></div>   
            <div id="actionBarDiv" class="actionBarDiv"></div>
        </div>
 <%--Showing the Action Bar in the Div Element - End--%>

<script type="text/javascript">
    function ExecuteAction(command) {
        LocalizeMessages();
        document.getElementById("gridframe").contentWindow.ExecuteActionByName(command);
        // document.frames("gridframe").ExecuteActionByName(command);
    }

    function ExecuteActionForSelectedRow(command) {
        LocalizeMessages();
        document.getElementById("gridframe").contentWindow.ExecuteActionForSelectedRow(command);
        // document.frames("gridframe").ExecuteActionForSelectedRow(command);
    }
    function LocalizeMessages() {
        document.getElementById("gridframe").contentWindow.cannotPerDisable = '<%=GetLangSpecText("ec_rbn_wf_cannotperformondisabled")%>';
        document.getElementById("gridframe").contentWindow.noRowSelected = '<%=GetLangSpecText("ec_rbn_wf_norowselected")%>';
        document.getElementById("gridframe").contentWindow.norightforaction = '<%=GetLangSpecText("ec_rbn_wf_norightforaction")%>';
        document.getElementById("gridframe").contentWindow.sysDel = '<%=GetLangSpecText("ec_rbn_wf_sysdelete")%>';
        document.getElementById("gridframe").contentWindow.selectItemRow = '<%=GetLangSpecText("ec_rbn_wf_selectItemRow")%>';
        document.getElementById("gridframe").contentWindow.NotAbleToEditFolder = '<%=GetLangSpecText("ec_rbn_nav_noedit_folder")%>';
        document.getElementById("gridframe").contentWindow.cannotOWV = '<%=GetLangSpecText("ec_rbn_wf_norightstoeditpublishedWF")%>';
        document.getElementById("gridframe").contentWindow.cannotOWVD = '<%=GetLangSpecText("ec_rbn_wf_norightstodesignpublishedWF")%>';
        document.getElementById("gridframe").contentWindow.cannotOWVP = '<%=GetLangSpecText("ec_rbn_wf_norightstorepublishWF")%>';
        document.getElementById("gridframe").contentWindow.cannotOWF = '<%=GetLangSpecText("ec_rbn_wf_norightstoeditpublishedform")%>';
        document.getElementById("gridframe").contentWindow.cannotOWFD = '<%=GetLangSpecText("ec_rbn_wf_norightstodesignpublishedform")%>';
        document.getElementById("gridframe").contentWindow.cannotOWFP = '<%=GetLangSpecText("ec_rbn_wf_norightstorepublishform")%>';
    }

    function ExecuteActionForMultiSelectedRow(command) {
        //Added by Harish for localization.
        LocalizeMessages();
        document.getElementById("gridframe").contentWindow.ExecuteActionForMultiSelectedRow(command);
        
    }
    //Function for loading the action bar 
    function LoadActionBar() {
        ActionBar.init("", "actionBarDiv");
    }

    //Loading the Action Bar 
    LoadActionBar();

    /* Showing the Right Action Bar */
    function LoadRightActionBar() {
        
        if (ActionBar._rightMenu) {
            ActionBar.hideRightMenu();
        }

         <%if (FormsList){ %>
                RightVersionJsonObj[0] = "";
                RightVersionJsonObj[5] = "";
                RightVersionJsonObj[7] = "";
        <% } else if (isWorkflowList) { %>
                RightVersionJsonObj[1] = "";
                RightVersionJsonObj[6] = "";
                RightVersionJsonObj[7] = "";
        <%  } else { %>

                RightVersionJsonObj[0] = "";
                RightVersionJsonObj[1] = "";
                RightVersionJsonObj[2] = "";
                RightVersionJsonObj[3] = "";
                RightVersionJsonObj[5] = "";
                RightVersionJsonObj[6] = "";
                RightVersionJsonObj[9] = "";
<%  } %>


        ActionBar.showRightMenu(RightVersionJsonObj);

    }

      function LoadRightActionBarForMultiSelect() {
        if (ActionBar._rightMenu) {
            ActionBar.hideRightMenu();
        }

        ActionBar.showRightMenu(RightWorkflowJsonObjForMultiSelect);
    }

    var RightVersionJsonObj =
            [
                {
                    "Design":
                        {
                            "Id": "6A283908-4320-4F79-A18B-C50E38A7E16D",
                            "Text": "<%=GetLangSpecText("ec_rbn_wf_design") %>",
                            "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_design_alttext") %>",
                            "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-Design.png",
                            "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Design.png",
                            "Action": "javascript:ExecuteActionForSelectedRow('_sys_designworkflow')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        }
                },

                {
                    "DesignForm":
                        {

                            "Id": "407C8FEF-7E47-4C04-BA8D-51FF4C218172",
                            "Text": "<%=GetLangSpecText("ec_rbn_wf_design") %>",
                            "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_designform_alttext") %>",
                            "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-Design.png",
                            "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Design.png",
                            "Action": "javascript:ExecuteActionForSelectedRow('_sys_designform')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        }
                },

                {
                    "Publish":
                        {
                            "Id": "91BCE64E-56F7-4750-BCFB-B5A5F60BAD11",
                            "Text": " <%=GetLangSpecText("ec_rbn_wf_publish") %>",
                            "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_publish") %>",
                            "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-Publish.png",
                            "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Publish.png",
                            "Action": "javascript:ExecuteActionForSelectedRow('_sys_publish')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        }
                },

                {
                    "UnPublish":
                        {
                            "Id": "99B592CA-76EC-4533-AE7A-CF317E0C3AA8",
                            "Text": "<%=GetLangSpecText("ec_rbn_wf_unpublish") %>",
                            "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_unpublish") %>",
                            "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-UnPublish.png",
                            "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-UnPublish.png",
                            "Action": "javascript:ExecuteActionForSelectedRow('_sys_unpublish')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        }
                },


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
                    "View":
                    {
                        "Id": "D147D7FA-2307-4C2C-B1D7-A9A8B6D71C3E",
                        "Text": "<%=GetLangSpecText("ec_rbn_wf_actionsView")%>",
                        "Tooltip": "<%=GetLangSpecText("ec_rbn_wf1_actionsView_alttext")%>",
                        "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-View.png",
                        "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-View.png",
                        "Action": "javascript:ExecuteActionForSelectedRow('_sys_view_designer')",
                        "OpenMode": "Popup",
                        "SubItems": []
                    }
                },

                {
                    "PreviewForm":
                    {
                        "Id": "D147D7FA-2307-4C2C-B1D7-A9A8B6D71C3E",
                        "Text": "<%=GetLangSpecText("ec_rbn_wf_actionsView")%>",
                        "Tooltip": "<%=GetLangSpecText("ec_rbn_wf1_actionsViewform_alttext")%>",
                        "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-View.png",
                        "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-View.png",
                        "Action": "javascript:ExecuteActionForSelectedRow('_sys_preview')",
                        "OpenMode": "Popup",
                        "SubItems": []
                    }
                },

                {
                    "ViewItem":
                    {
                        "Id": "D147D7FA-2307-4C2C-B1D7-A9A8B6D71C3E",
                        "Text": "<%=GetLangSpecText("ec_rbn_wf_actionsView")%>",
                        "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_actionsView")%>",
                        "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-View.png",
                        "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-View.png",
                        "Action": "javascript:ExecuteActionForSelectedRow('_sys_view_item_details')",
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
                },

                 {
                     "ChangeOwner":
                        {
                            "Id": "7EF94379-B3A2-4554-97CB-F09952CF7666",
                            "Text": "<%=GetLangSpecText("ec_rbn_wf_changeowner") %>",
                            "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_changeowner_alttext") %>",
                            "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-Change-Owner.png",
                            "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Change-Owner.png",
                            "Action": "javascript:ExecuteActionForSelectedRow('_sys_change_owner')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        }
                 }               

        ];

     var RightWorkflowJsonObjForMultiSelect =
        [

            {
                "PublishSelected":
                    {
                        "Id": "570ED901-91BE-49E6-B63B-BA5890563EC5",
                        "Text": " <%=GetLangSpecText("ec_rbn_wf_publish") %>",
                        "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_publish") %>",
                        "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-Publish.png",
                        "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Publish.png",
                        "Action": "javascript:ExecuteActionForMultiSelectedRow('_sys_publish')",
                        "OpenMode": "Popup",
                        "SubItems": []
                    }
            },            

            {
                "UnPublishSelected":
                    {
                        "Id": "5F079C6A-0C28-41A5-A5D3-1E1E7AD267D0",
                        "Text": "<%=GetLangSpecText("ec_rbn_wf_unpublish") %>",
                        "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_unpublish") %>",
                        "Image": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/AB-UnPublish.png",
                        "HoverImage": "<%=ThemeURL%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-UnPublish.png",
                        "Action": "javascript:ExecuteActionForMultiSelectedRow('_sys_unpublish')",
                        "OpenMode": "Popup",
                        "SubItems": []
                    }
            },

            

        ];

</script>

