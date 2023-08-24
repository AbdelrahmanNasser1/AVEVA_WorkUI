<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.AssociationListRibbonBar" %>
<link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemeURL)%>Common/StyleSheet/Global.css" rel="stylesheet" />


<%--Showing the Action Bar in the Div Element - Start--%>
        <div class="breadcrumb" >		                          
            <div class="actionItem"></div>   
            <div id="actionBarDiv" class="actionBarDiv"></div>
        </div>
<%--Showing the Action Bar in the Div Element - End--%>

<script type="text/javascript" >
    function ExecuteSettingsActionFlag(command) {
        // Ayyub :: In MOM it is decided that List Settings should come from Ribbonbar(irrespective of whether item is selected or not) and ListItem settings should come from context menu
        LocalizeMessages();
        document.getElementById("gridframe").contentWindow.ExecuteActionByName(command);
    }
    function ExecuteAction(command) {
        LocalizeMessages();
        document.getElementById("gridframe").contentWindow.ExecuteActionByName(command);
    }

    function ExecuteActionForSelectedRow(command) {
        LocalizeMessages();
        document.getElementById("gridframe").contentWindow.ExecuteActionForSelectedRow(command);
    }
    function LocalizeMessages() {
        document.getElementById("gridframe").contentWindow.cannotPerDisable = '<%=GetLangSpecText("ec_rbn_wf_cannotperformondisabled")%>';
        document.getElementById("gridframe").contentWindow.noRowSelected = '<%=GetLangSpecText("ec_rbn_wf_norowselected")%>';
        document.getElementById("gridframe").contentWindow.norightforaction = '<%=GetLangSpecText("ec_rbn_wf_norightforaction")%>';
        document.getElementById("gridframe").contentWindow.sysDel = '<%=GetLangSpecText("ec_rbn_wf_sysdelete")%>';
        document.getElementById("gridframe").contentWindow.NotAbleToEditFolder = '<%=GetLangSpecText("ec_rbn_nav_noedit_folder")%>';
    }

    var AssociateJsonObj =
        [
            

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

    //Function for loading the action bar 
    function LoadActionBar() {
        ActionBar.init(AssociateJsonObj, "actionBarDiv");
    }

    //Loading the Action Bar 
    LoadActionBar();

</script>
<div style="width: 100%; height: 100%;display:none;" class="divMain" >
            <div class="divMenu" style="width: 100px;">
            <div class="divTopImage" style="width: 100%;height:40px;">
                <a href="javascript:ExecuteSettingsActionFlag('_sys_security_settings')" class="sectionitem">
                    <img src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/icon-settings.png"
                       style="border-width:0px" alt="<%=GetLangSpecText("ec_rbn_nl_security_alt") %>" />
                </a>
            </div>
           
       
           <div class="sectiontitle divdowntext" style="height:17px;">
                <%=GetLangSpecText("ec_rbn_wf_settings") %>
            </div>
 </div>
   
</div> 