<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.WebControls_RibbonBar" %>
<link rel="stylesheet" type="text/css" href="<%=templateThemeDirectory%>Common/StyleSheet/Global.css" />


        <%--Showing the Action Bar in the Div Element - Start--%>
        <div class="breadcrumb" >		                          
            <div class="actionItem"></div>   
            <div id="actionBarDiv" class="actionBarDiv"></div>
        </div>
        <%--Showing the Action Bar in the Div Element - End--%>
    
    <script type="text/javascript">   
    

    function ExecuteSettingsActionFlag(command) {
        LocalizeMessages();
        document.getElementById("gridframe").contentWindow.ExecuteActionByName(command);
        HideSubItemsActionBar();

        if (command == "_sys_security_settings")
        {
            WorkflowjsonObj = "";
            LoadActionBar();
        }
    }
    function ExecuteAction(command) {        
        LocalizeMessages();
        document.getElementById("gridframe").contentWindow.ExecuteActionByName(command);
        HideSubItemsActionBar();
       
    }

    function ExecuteActionForSelectedRow(command) {
        //Added by Harish for localization.
        LocalizeMessages();
        document.getElementById("gridframe").contentWindow.ExecuteActionForSelectedRow(command);
        HideSubItemsActionBar();
    }

    function ExecuteActionForMultiSelectedRow(command) {
        //Added by Harish for localization.
        LocalizeMessages();
        document.getElementById("gridframe").contentWindow.ExecuteActionForMultiSelectedRow(command);
        HideSubItemsActionBar();
    }
	
    function LoadRightActionBarForMultiSelect() {
        if (ActionBar._rightMenu) {
            ActionBar.hideRightMenu();
        }

        ActionBar.showRightMenu(RightWorkflowJsonObjForMultiSelect);
        }

    function LocalizeMessages() {
        document.getElementById("gridframe").contentWindow.ApprovalWFAttachedcontinue = '<%=GetLangSpecText("ec_rbn_wf_ApprovalWFAttached")%>';
        document.getElementById("gridframe").contentWindow.SecurityApprovalWFAttached = '<%=GetLangSpecText("ec_rbn_wf_SecurityWFAttached")%>';
        document.getElementById("gridframe").contentWindow.associationforWFonly = '<%=GetLangSpecText("ec_rbn_wf_associationforWFonly")%>';
        document.getElementById("gridframe").contentWindow.norightforaction = '<%=GetLangSpecText("ec_rbn_wf_norightforaction")%>';

        document.getElementById("gridframe").contentWindow.viewdesignOnlyForWF = '<%=GetLangSpecText("ec_rbn_wf_viewdesignOnlyForWF")%>';
        document.getElementById("gridframe").contentWindow.sysDel = '<%=GetLangSpecText("ec_rbn_wf_sysdelete")%>';
        document.getElementById("gridframe").contentWindow.designonlyforWF = '<%=GetLangSpecText("ec_rbn_wf_designonlyforWF")%>';
        document.getElementById("gridframe").contentWindow.cannotPerDisable = '<%=GetLangSpecText("ec_rbn_wf_cannotperformondisabled")%>';
        document.getElementById("gridframe").contentWindow.noRowSelected = '<%=GetLangSpecText("ec_rbn_wf_norowselected")%>';
        document.getElementById("gridframe").contentWindow.cannotOWV = '<%=GetLangSpecText("ec_rbn_wf_norightstoeditpublishedWF")%>';
        document.getElementById("gridframe").contentWindow.cannotOWVD = '<%=GetLangSpecText("ec_rbn_wf_norightstodesignpublishedWF")%>';
        document.getElementById("gridframe").contentWindow.cannotOWVP = '<%=GetLangSpecText("ec_rbn_wf_norightstorepublishWF")%>';
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

        ActionBar.showRightMenu(RightWorkflowJsonObj);

    }

   var WorkflowjsonObj =
        [

            {
                "Up":
                {
                    "Id": "498D4CBB-2446-493D-983A-8DFF0BD20AD8",
                    "Text": " <%=GetLangSpecText("ec_rbn_wf_navigate") %>",
                    "Tooltip":"<%=GetLangSpecText("ec_rbn_wf_navigate_alt") %>",
                    "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Up.png",
                    "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Up.png",
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
                    "Text": "<%=GetLangSpecText("ec_rbn_wf_new") %>",
                    "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_new") %>",
                    "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-New.png",
                    "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-New.png",
                    "Action": "",
                    "OpenMode": "Popup",
                    "SubItems": [
                        {
                            "Id": "80C33179-9B75-4248-A466-DA7F65789C0A",
                            "Text": "<%=GetLangSpecText("ec_rbn_wf_workflow") %>",
                            "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_workflow_alttext") %>",
                            "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Workflow.png",
                            "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Workflow.png",
                            "Action": "javascript:ExecuteAction('_sys_new')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        },
                        {
                            "Id": "A7EA1D1B-E563-424C-82AB-4421B3FB8CA9",
                            "Text": "<%=GetLangSpecText("ec_rbn_wf_quickflow") %>",
                            "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_quickflow_alttext") %>",
                            "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Quickflow.png",
                            "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Quickflow.png",
                            "Action": "javascript:ExecuteAction('_sys_newquickflow')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        },
                      
                        {
                            "Id": "0FA489EF-1F59-4A1D-B632-35DFCF144F82",
                            "Text": "<%=GetLangSpecText("ec_rbn_wf_listworkflow")%>",
                            "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_listworkflow_alttext")%>",
                            "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-List.png",
                            "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-List.png",
                            "Action": "javascript:ExecuteAction('_sys_newlistworkflow')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        },                      
                         {
                             "Id": "B1E63FED-AED6-4803-8DB2-7EE70D7DE93A",
                             "Text": "<%=GetLangSpecText("ec_rbn_wf_bamworkflow")%>",
                             "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_bamworkflow_alttext")%>",
                             "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-BAM.png",
                             "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-BAM.png",
                             "Action": "javascript:ExecuteAction('_sys_newbamworkflow')",
                             "OpenMode": "Popup",
                             "SubItems": []
                         },                                               
                        <%if(platform == Skelta.FarmManager.Platform.OnPremise) { %>
			            {
			                "Id": "941CB3C7-94B9-4429-A467-DA5751E8EDDC",
			                "Text": "<%=GetLangSpecText("ec_rbn_wf_filewatcherworkflow")%>",
			                "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_filewatcherworkflow_alttext")%>",
			                "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-FileWatcher.png",
			                "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-FileWatcher.png",
			                "Action": "javascript:ExecuteAction('_sys_newfilewatcherworkflow')",
			                "OpenMode": "Popup",
			                "SubItems": []
			            },
                        <%} %>
                        

                       {
                            "Id": "799F6317-9BD8-4141-9408-7F32EDB47B64",
                            "Text": "<%=GetLangSpecText("ec_rbn_wf_newfolder") %>",
                           "Tooltip": "<%=GetLangSpecText("ec_rbn_nl_folder") %>",
                            "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Folder.png",
                            "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Folder.png",
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

        var WorkflowjsonObjForMES =
       [

           {
               "Up":
               {
                   "Id": "498D4CBB-2446-493D-983A-8DFF0BD20AD8",
                   "Text": " <%=GetLangSpecText("ec_rbn_wf_navigate") %>",
                   "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_navigate_alt") %>",
                   "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Up.png",
                   "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Up.png",
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
                    "Text": "<%=GetLangSpecText("ec_rbn_wf_new") %>",
                    "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_new") %>",
                    "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-New.png",
                    "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-New.png",
                    "Action": "",
                    "OpenMode": "Popup",
                    "SubItems": [
                        {
                            "Id": "80C33179-9B75-4248-A466-DA7F65789C0A",
                            "Text": "<%=GetLangSpecText("ec_rbn_wf_workflow") %>",
                            "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_workflow_alttext") %>",
                            "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Workflow.png",
                            "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Workflow.png",
                            "Action": "javascript:ExecuteAction('_sys_new')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        },
                        {
                            "Id": "41C0F0BE-DAD5-4529-A7F9-0E631A0D0F75",
                            "Text": "<%=GetLangSpecText("ec_rbn_wf_quickflow") %>",
                            "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_quickflow_alttext") %>",
                            "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Quickflow.png",
                            "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Quickflow.png",
                            "Action": "javascript:ExecuteAction('_sys_newquickflow')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        },                   
                        {
                            "Id": "0FA489EF-1F59-4A1D-B632-35DFCF144F82",
                            "Text": "<%=GetLangSpecText("ec_rbn_wf_listworkflow")%>",
                            "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_listworkflow_alttext")%>",
                            "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-List.png",
                            "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-List.png",
                            "Action": "javascript:ExecuteAction('_sys_newlistworkflow')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        },                   
                         {
                             "Id": "B1E63FED-AED6-4803-8DB2-7EE70D7DE93A",
                             "Text": "<%=GetLangSpecText("ec_rbn_wf_bamworkflow")%>",
                             "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_bamworkflow_alttext")%>",
                             "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-BAM.png",
                             "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-BAM.png",
                             "Action": "javascript:ExecuteAction('_sys_newbamworkflow')",
                             "OpenMode": "Popup",
                             "SubItems": []
                         },
			            {
			                "Id": "941CB3C7-94B9-4429-A467-DA5751E8EDDC",
			                "Text": "<%=GetLangSpecText("ec_rbn_wf_filewatcherworkflow")%>",
			                "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_filewatcherworkflow_alttext")%>",
			                "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-FileWatcher.png",
			                "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-FileWatcher.png",
			                "Action": "javascript:ExecuteAction('_sys_newfilewatcherworkflow')",
			                "OpenMode": "Popup",
			                "SubItems": []
			            },


                         {
                             "Id": "F5A4EF0C-1DFB-44A8-9D9B-D26A460F6024",
                             "Text": "<%=GetLangSpecText("ec_rbn_wf_mesworkflow")%>",
                             "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_mesworkflow_alttext")%>",
                             "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-MES.png",
                             "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-MES.png",
                             "Action": "javascript:ExecuteAction('_sys_newmesworkflow')",
                             "OpenMode": "Popup",
                             "SubItems": []
                         },



                       {
                           "Id": "799F6317-9BD8-4141-9408-7F32EDB47B64",
                           "Text": "<%=GetLangSpecText("ec_rbn_wf_newfolder") %>",
                           "Tooltip": "<%=GetLangSpecText("ec_rbn_nl_folder") %>",
                           "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Folder.png",
                           "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Folder.png",
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



        var RightWorkflowJsonObj =
            [
                {
                    "Design":
                        {
                            "Id": "6A283908-4320-4F79-A18B-C50E38A7E16D",
                            "Text": "<%=GetLangSpecText("ec_rbn_wf_design") %>",
                            "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_design_alttext") %>",
                            "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Design.png",
                            "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Design.png",
                            "Action": "javascript:ExecuteActionForSelectedRow('_sys_designworkflow')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        }
                },

                {
                    "Publish":
                        {
                            "Id": "91BCE64E-56F7-4750-BCFB-B5A5F60BAD11",
                            "Text": " <%=GetLangSpecText("ec_rbn_wf_publish") %>",
                            "Tooltip": "<%=GetLangSpecText("ec_rbn_wf1_publish_alttext") %>",
                            "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Publish.png",
                            "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Publish.png",
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
                            "Tooltip": "<%=GetLangSpecText("ec_rbn_wf1_unpublish_alttext") %>",
                            "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-UnPublish.png",
                            "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-UnPublish.png",
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
                        "Tooltip": "<%=GetLangSpecText("ec_rbn_wf_editWf_alttext")%>",
                        "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Edit.png",
                        "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Edit.png",
                        "Action": "javascript:ExecuteActionForSelectedRow('_sys_edit')",
                        "OpenMode": "Popup",
                        "SubItems": []
                    }
                } ,
                {
                    "View":
                    {
                        "Id": "D147D7FA-2307-4C2C-B1D7-A9A8B6D71C3E",
                        "Text": "<%=GetLangSpecText("ec_rbn_wf_actionsView")%>",
                        "Tooltip": "<%=GetLangSpecText("ec_rbn_wf1_actionsView_alttext")%>",
                        "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-View.png",
                        "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-View.png",
                        "Action": "javascript:ExecuteActionForSelectedRow('_sys_view_designer')",
                        "OpenMode": "Popup",
                        "SubItems": []
                    }
                },

                {
                    "Delete":
                    {
                        "Id": "75211C43-A0E2-4BF5-A182-3B5D78E74700",
                        "Text": "<%=GetLangSpecText("ec_rbn_wf_delete") %>",
                        "Tooltip": "<%=GetLangSpecText("ec_rbn_wf1_delete_alttext") %>",
                        "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Delete.png",
                        "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Delete.png",
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
                            "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Change-Owner.png",
                            "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Change-Owner.png",
                            "Action": "javascript:ExecuteActionForSelectedRow('_sys_change_owner')",
                            "OpenMode": "Popup",
                            "SubItems": []
                        }
                 },

                

                {
                    "Associate":
                    {
                        "Id": "3A8EB734-EDBD-46AE-A04D-5973B397E1E8",
                        "Text": " <%=GetLangSpecText("ec_rbn_wf_associate") %>",
                        "Tooltip": "<%=GetLangSpecText("ecm_assn_associate") %>",
                        "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Associate.png",
                        "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Associate.png",
                        "Action": "javascript:ExecuteActionForSelectedRow('_sys_create_assn')",
                        "OpenMode": "Popup",
                        "SubItems":
                        [

                        ]
                    }
                }           

        ];


        var RightWorkflowJsonObjForMultiSelect =
        [

            {
                "PublishSelected":
                    {
                        "Id": "570ED901-91BE-49E6-B63B-BA5890563EC5",
                        "Text":  "<%=GetLangSpecText("ec_rbn_wf_publish") %>", 
                        "Tooltip": "<%=GetLangSpecText("ec_rbn_wf1_publish_alttext") %>",
                        "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Publish.png",
                        "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Publish.png",
                        "Action": "javascript:ExecuteActionForMultiSelectedRow('_sys_publish')",
                        "OpenMode": "Popup",
                        "SubItems": []
                    }
            },
            <%--{
                "PublishAll":
                    {
                        "Id": "6F138D5F-51F7-4B25-B76A-63B2E6036350",
                        "Text": "<%=GetLangSpecText("ec_rbn_Workflow_MultiPublishAll") %>",
                        "Tooltip": "<%=GetLangSpecText("ec_rbn_Workflow_MultiPublishAllToolTip") %>",
                        "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Publish.png",
                        "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Publish.png",
                        "Action": "javascript:ExecuteActionForMultiSelectedRow('_sys_publishall')",
                        "OpenMode": "Popup",
                        "SubItems": []
                    }
            },--%>

            {
                "UnPublishSelected":
                    {
                        "Id": "5F079C6A-0C28-41A5-A5D3-1E1E7AD267D0",
                        "Text": "<%=GetLangSpecText("ec_rbn_wf_unpublish") %>",
                        "Tooltip": "<%=GetLangSpecText("ec_rbn_wf1_unpublish_alttext") %>",
                        "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-UnPublish.png",
                        "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-UnPublish.png",
                        "Action": "javascript:ExecuteActionForMultiSelectedRow('_sys_unpublish')",
                        "OpenMode": "Popup",
                        "SubItems": []
                    }
                }
            <%--,
            {
                "UnPublishAll":
                    {
                        "Id": "B9661B00-6A00-4B20-8A4A-A28A82FB5BED",
                        "Text": "<%=GetLangSpecText("ec_rbn_Workflow_MultiUnPublishAll") %>",
                        "Tooltip": "<%=GetLangSpecText("ec_rbn_Workflow_MultiUnPublishAllToolTip") %>",
                        "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-UnPublish.png",
                        "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-UnPublish.png",
                        "Action": "javascript:ExecuteActionForMultiSelectedRow('_sys_unpublishall')",
                        "OpenMode": "Popup",
                        "SubItems": []
                    }
            }--%>

        ];

    //Function for loading the action bar 
    function LoadActionBar()
        {          
        var1 = null;
        var1 = "<%=checkMESInstalled%>"
        if (var1 == "")
        {
            ActionBar.init(WorkflowjsonObj, "actionBarDiv");
        }
        else
        {
            ActionBar.init(WorkflowjsonObjForMES, "actionBarDiv");
        }

        }
           
    //Loading the Action Bar 
    LoadActionBar();
   
    </script>
