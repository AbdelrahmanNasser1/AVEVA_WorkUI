<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.WebControls_RibbonBar" %>
 
<link href="<%=templateThemeDirectory%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />

<%--Showing the Action Bar in the Div Element - Start--%>
        <div class="breadcrumb" >		                          
            <div class="actionItem"></div>   
            <div id="actionBarDiv" class="actionBarDiv"></div>
        </div>
<%--Showing the Action Bar in the Div Element - End--%>


<script type="text/javascript">
var hgt = screen.availHeight;
function ExecuteAction(command)
    {
        LocalizeMessages();
        document.getElementById("gridframe").contentWindow.ExecuteActionByName(command);
        HideSubItemsActionBar();
    }

    function ExecuteActionForSelectedRow(command) {
        LocalizeMessages();
          if( command == '_sys_delete' )
        {
            parent.tabpage="";
        }
        document.getElementById("gridframe").contentWindow.ExecuteActionForSelectedRow(command);
        HideSubItemsActionBar();
        
    }
    function ExecuteSettingsActionFlag(command) {
        LocalizeMessages();  
        var flag =document.getElementById("gridframe").contentWindow.IsRowSelected();
        if(flag)
        {
          document.getElementById("gridframe").contentWindow.ExecuteActionForSelectedRow(command);  
        }
        else
        {
            document.getElementById("gridframe").contentWindow.ExecuteActionByName(command);
        }

        if (command == "_sys_security_settings") {
            SSRSTemplatejsonObj = "";
            LoadActionBar();
        }
    }
    function LocalizeMessages() {
        document.getElementById("gridframe").contentWindow.cannotPerDisable = '<%=GetLangSpecText("ec_rbn_wf_cannotperformondisabled")%>';
        document.getElementById("gridframe").contentWindow.noRowSelected = '<%=GetLangSpecText("ec_rbn_wf_norowselected")%>';
        document.getElementById("gridframe").contentWindow.norightforaction = '<%=GetLangSpecText("ec_rbn_wf_norightforaction")%>';
        document.getElementById("gridframe").contentWindow.sysDel = '<%=GetLangSpecText("ec_rbn_wf_sysdelete")%>';
        document.getElementById("gridframe").contentWindow.NotAbleToEditFolder = '<%=GetLangSpecText("ec_rbn_nav_noedit_folder")%>';

    }
function TABLE1_onclick() {

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
    ActionBar.showRightMenu(RightSSRSTemplateJsonObj);
}

var SSRSTemplatejsonObj =
    [
             {
                 "New":
                     {
                        "Id": "E53C245D-E05B-4D4F-820D-40AD26479887",
                        "Text": "<%=GetLangSpecText("ec_ssrs_template_new")%>",
                        "Tooltip": "<%=GetLangSpecText("ec_ssrs_New_template_alttext")%>",
                        "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-New.png",
                        "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-New.png",
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
                    "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Security.png",
                    "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Security.png",
                    "Action": "javascript:ExecuteSettingsActionFlag('_sys_security_settings')",
                    "OpenMode": "Popup",
                    "SubItems": []
                }
            }

    ];


    var RightSSRSTemplateJsonObj =
                    [
                        {
                            "Edit":
                            {
                                "Id": "5987319E-C0E4-4142-9C01-53389025A3BF",
                                "Text": "<%=GetLangSpecText("ec_ssrs_template_edit")%>",
                                "Tooltip": "<%=GetLangSpecText("ec_ssrs_template_edit_Alttext")%>",
                                "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Edit.png",
                                "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Edit.png",
                                "Action": "javascript:ExecuteActionForSelectedRow('_sys_edit')",
                                "OpenMode": "Popup",
                                "SubItems": []
                           },
                        },
                        {
                            "Delete":
                            {
                                "Id": "75211C43-A0E2-4BF5-A182-3B5D78E74700",
                                "Text": "<%=GetLangSpecText("ec_ssrs_template_Delete")%>",
                                "Tooltip": "<%=GetLangSpecText("ec_ssrs_template_delete_Alttext")%>",
                                "Image": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/AB-Delete.png",
                                "HoverImage": "<%=templateThemeDirectory%>Repository/ListControl/images/ActionBarIcons/HoverIcons/AB-Delete.png",
                                "Action": "javascript:ExecuteActionForSelectedRow('_sys_delete')",
                                "OpenMode": "Popup",
                                "SubItems": []
                            },
                        }

                 ];

                //Function for loading the action bar 
                function LoadActionBar() {
                    ActionBar.init(SSRSTemplatejsonObj, "actionBarDiv");
                }

                //Loading the Action Bar 
                LoadActionBar();


</script>

<div style="width: 100%; height: 100%;display:none;" class="divMain">
<div class="divMenu" style="width: 80px;">
        <div class="divTopImage" style="width:100%">  
             <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 0; border-collapse: collapse; border: 0px solid;">
                <tr>
                    <td style="height: 25px; text-align: center; padding: 2px">                 
              <a href="javascript:ExecuteAction('_sys_new')" class="sectionitem">
                   <img alt="<%=GetLangSpecText("ec_ssrs_New_template_alttext")%>"  src="<%=templateThemeDirectory %>Repository/ListControl/images/icons-ribbon/SSRS-newTemplate.png" style="border-width:0px;width:36px;height:36px;" />
              </a>
                        </td>
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
		<%=GetLangSpecText("ec_ssrs_template_new")%>
        </div>
</div>


<div class="divMenu" style="width: 110px;">
        <div class="divTopImage">
            <table style="width:110px; height:65px;border-width:0;border-collapse:separate;border-spacing:2px" >
                <tr>
                    <td style="height:20px;text-align:left;">                      

                        <span><a href="javascript:ExecuteActionForSelectedRow('_sys_edit')" class="sectionitem">
                            <img alt=" <%=GetLangSpecText("ec_ssrs_template_edit_Alttext")%>" src="<%=templateThemeDirectory %>Repository/ListControl/images/icons-ribbon/icon-edit.png"
                                style="width:23px;height:23px;vertical-align:middle;border-width:0px;" />
                            <%=GetLangSpecText("ec_ssrs_template_edit")%>
                         </a></span>
                    </td>
                </tr>
                <tr>
                    <td style="height:20px;text-align:left;">
                         <span>
                          <a href="javascript:ExecuteActionForSelectedRow('_sys_delete')" class="sectionitem">
                                    <img alt="<%=GetLangSpecText("ec_ssrs_template_delete_Alttext")%>" src="<%=templateThemeDirectory %>Repository/ListControl/images/icons-ribbon/delete.png"
                                        style="width:23px;height:23px;vertical-align:middle;border-width:0px;" />
                                    <%=GetLangSpecText("ec_ssrs_template_Delete")%>
                          </a>
                         </span>
                    </td>
                </tr>
            </table>
        </div>
        <div class="sectiontitle divdowntext">
		<%=GetLangSpecText("ec_ssrs_template_Actions")%>
        </div>
    </div>


<div class="divMenu" style="width:80px;">
        <div class="divTopImage" style="width:100%">  
             <table style="width: 100%; height: 65px; border-width: 0; border-spacing: 0; border-collapse: collapse; border: 0px solid;">
                <tr>
                    <td style="height: 25px; text-align: center; padding: 2px">                  
              <a href="javascript:ExecuteSettingsActionFlag('_sys_security_settings')" class="sectionitem">
                  <img src="<%=templateThemeDirectory %>Repository/ListControl/images/icons-ribbon/icon-settings.png" border="0" alt="<%=GetLangSpecText("ec_rbn_nl_security_alt") %>" style="width:36px;height:36px;"/>
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
