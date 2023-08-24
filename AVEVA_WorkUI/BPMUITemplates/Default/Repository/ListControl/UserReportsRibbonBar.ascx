<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.WebControls_RibbonBar" %>
<link href="<%=templateThemeDirectory%>Common/StyleSheet/Global.css" rel="stylesheet"
    type="text/css" />

<script type="text/javascript" language="javascript">
var hgt = screen.availHeight;
    function ExecuteAction(command){
        LocalizeMessages();
        document.getElementById("gridframe").contentWindow.ExecuteActionByName(command);
    }
    
    function ExecuteActionForSelectedRow(command){
        LocalizeMessages();
        if( command == '_sys_delete' )
        {
            parent.tabpage="";
        }
        document.getElementById("gridframe").contentWindow.ExecuteActionForSelectedRow(command);
    }
    function ExecuteSettingsActionFlag(command)
    {
        LocalizeMessages();
        var flag = document.getElementById("gridframe").contentWindow.IsRowSelected();
        if(flag)
        {
          document.getElementById("gridframe").contentWindow.ExecuteActionForSelectedRow(command);  
        }
        else
        {
            document.getElementById("gridframe").contentWindow.ExecuteActionByName(command);
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

</script>

<table width="100%" height="104" border="0" cellpadding="0" cellspacing="0">
   
    <tr>
       
        <td height="75" align="left" valign="top" background="<%=templateThemeDirectory %>/Repository/ListControl/images/borders/center-bg-inside.png">
            <table width="420" border="0" cellspacing="1" cellpadding="1">
                <tr>
                    <td>
                        <table width="80px" height="92" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td align="left" valign="top">
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/top-left.png" width="5" height="5" /></td>
                                <td align="center" valign="top" background="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/top.png">
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/top.png" width="5" height="5" /></td>
                                <td align="right" valign="top">
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/top-right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td width="5" valign="bottom" background="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/left.png">
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/left.png" width="5" height="5" /></td>
                                <td height="61" align="center" valign="middle" background="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/center-bg.png">
                                    <table width="100%" border="0" cellspacing="2" cellpadding="2">
                                        <tr>
                                            <td height="61" align="center">
                                                <a href="javascript:document.getElementById('gridframe').contentWindow.NavigateUp()">
                                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/icon-up.png" border="0" width="36" height="36" alt="<%=GetLangSpecText("ec_rbn_userDesign_Report_action_navigate_alt") %>"/></a></td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="5" align="right" valign="bottom" background="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/right.png">
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom" background="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/bottom-left-2.png">
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/bottom-left-2.png" width="5" height="5" /></td>
                                <td height="21" align="center" valign="middle" class="sectiontitle">
                                    <%=GetLangSpecText("ec_rbn_userDesign_Report_action_navigate")%>
                                </td>
                                <td align="right" valign="bottom" background="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/bottom-right-2.png">
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/bottom-right-2.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom">
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/bottom-left.png" width="5" height="5" /></td>
                                <td align="center" valign="bottom" background="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/bottom.png">
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/bottom.png" width="5" height="5" /></td>
                                <td align="right" valign="bottom">
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/bottom-right.png" width="5" height="5" /></td>
                            </tr>
                        </table>
                    </td>
                    <td align="left">
                        <table width="80px" height="92" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td align="left" valign="top">
                                    <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/top-left.png"
                                        width="5" height="5" /></td>
                                <td align="center" valign="top" background="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/top.png">
                                    <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/top.png"
                                        width="5" height="5" /></td>
                                <td align="right" valign="top">
                                    <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/top-right.png"
                                        width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td width="5" valign="bottom" background="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/left.png">
                                    <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/left.png"
                                        width="5" height="5" /></td>
                                <td height="60" align="center" valign="middle" background="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/center-bg.png">
                                    <table width="100%" height="65" border="0" cellspacing="2" cellpadding="2">
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td height="30" align="left">
                                                <a href="javascript:ExecuteAction('_sys_new')">
                                                    <img alt="<%=GetLangSpecText("ec_rbn_userDesign_Report_New")%> " src="<%=templateThemeDirectory %>Repository/ListControl/images/icons-ribbon/Icon-design-reports-big.png"
                                                        border="0" width="36" height="36" /></a></td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="5" align="right" valign="bottom" background="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/right.png">
                                    <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/right.png"
                                        width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom" background="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/bottom-left-2.png">
                                    <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/bottom-left-2.png"
                                        width="5" height="5" /></td>
                                <td height="21" align="center" valign="middle" class="sectiontitle">
                                    <%=GetLangSpecText("ec_rbn_userDesign_Report_New_btn")%>
                                </td>
                                <td align="right" valign="bottom" background="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/bottom-right-2.png">
                                    <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/bottom-right-2.png"
                                        width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom">
                                    <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/bottom-left.png"
                                        width="5" height="5" /></td>
                                <td align="center" valign="bottom" background="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/bottom.png">
                                    <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/bottom.png"
                                        width="5" height="5" /></td>
                                <td align="right" valign="bottom">
                                    <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/bottom-right.png"
                                        width="5" height="5" /></td>
                            </tr>
                        </table>
                    </td>
                       <td>
                        <table width="145px" height="92" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td align="left" valign="top">
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/top-left.png" width="5" height="5" /></td>
                                <td align="center" valign="top" background="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/top.png">
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/top.png" width="5" height="5" /></td>
                                <td align="right" valign="top">
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/top-right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td width="5" valign="bottom" background="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/left.png">
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/left.png" width="5" height="5" /></td>
                                <td align="center" valign="middle" background="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/center-bg.png">
                                    <table width="100%" height="67" border="0" cellspacing="1" cellpadding="0">
                                        <tr>
                                            <td align="left">
                                                <span><a href="javascript:ExecuteActionForSelectedRow('_sys_preview')" class="sectionitem">
                                                    <img alt=" <%=GetLangSpecText("ec_rbn_userDesign_Report_action_preview_altext")%>" src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/icon-view-item.png"
                                                        hspace="0" align="absmiddle" border="0" width="23" height="23" /><span>
                                                            <%=GetLangSpecText("ec_rbn_userDesign_Report_action_preview")%></a></span>
                                            </td>
                                            <td align="left">
                                                <span><a href="javascript:ExecuteActionForSelectedRow('_sys_delete')" class="sectionitem">
                                                    <img alt=" <%=GetLangSpecText("ec_rbn_userDesign_Report_Delete_alltext")%>" src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/delete.png"
                                                        hspace="0" align="absmiddle" border="0" width="23" height="23" /><span>
                                                            <%=GetLangSpecText("ec_rbn_userDesign_Report_Delete_btn")%></a></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" colspan="2">
                                                <span><a href="javascript:ExecuteActionForSelectedRow('_sys_edit')" class="sectionitem">
                                                    <img alt="  <%=GetLangSpecText("ec_rbn_userDesign_Report_Edit_btn_alltext")%>" src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/icon-edit.png"
                                                        hspace="0" align="absmiddle" border="0" width="23" height="23" />
                                                    <%=GetLangSpecText("ec_rbn_userDesign_Report_Edit_btn")%>
                                                </a></span>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="5" align="right" valign="bottom" background="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/right.png">
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom" background="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/bottom-left-2.png">
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/bottom-left-2.png" width="5" height="5" /></td>
                                <td align="center" valign="bottom">
                                    <table width="100%" border="0" cellpadding="0" cellspacing="0" height="21">
                                        <tr>
                                            <td align="center" valign="middle" class="sectiontitle">
                                                <%=GetLangSpecText("ec_rbn_userDesign_Report_action")%>
                                            </td>
                                           <%-- <td width="5" align="right" valign="middle">                                               
                                            </td>--%>
                                        </tr>
                                    </table>
                                </td>
                                <td align="right" valign="bottom" background="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/bottom-right-2.png">
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/bottom-right-2.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom">
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/bottom-left.png" width="5" height="5" /></td>
                                <td align="center" valign="bottom" background="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/bottom.png">
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/bottom.png" width="5" height="5" /></td>
                                <td align="right" valign="bottom">
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/bottom-right.png" width="5" height="5" /></td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <table width="80px" height="92" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td align="left" valign="top">
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/top-left.png" width="5" height="5" /></td>
                                <td align="center" valign="top" background="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/top.png">
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/top.png" width="5" height="5" /></td>
                                <td align="right" valign="top">
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/top-right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td width="5" valign="bottom" background="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/left.png">
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/left.png" width="5" height="5" /></td>
                                <td height="60" align="center" valign="middle" background="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/center-bg.png">
                                    <table width="100%" height="65" border="0" cellspacing="2" cellpadding="2">
                                        <tr>
                                            <td height="62" align="center">
                                                <a href="javascript:ExecuteSettingsActionFlag('_sys_newfolder')">
                                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/folder-icon.png" width="36" height="36" border="0" alt="<%=GetLangSpecText("ec_rbn_userDesign_Report_folder_altext") %>" />
                                                </a>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="5" align="right" valign="bottom" background="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/right.png">
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom" background="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/bottom-left-2.png">
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/bottom-left-2.png" width="5" height="5" /></td>
                                <td height="21" align="center" valign="middle" class="sectiontitle">
                                    <%=GetLangSpecText("ec_rbn_userDesign_Report_folder")%>
                                </td>
                                <td align="right" valign="bottom" background="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/bottom-right-2.png">
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/bottom-right-2.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom">
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/bottom-left.png" width="5" height="5" /></td>
                                <td align="center" valign="bottom" background="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/bottom.png">
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/bottom.png" width="5" height="5" /></td>
                                <td align="right" valign="bottom">
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/bottom-right.png" width="5" height="5" /></td>
                            </tr>
                        </table>
                    </td>   
                    <td>
                        <table width="80px" height="92" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td align="left" valign="top">
                                    <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/top-left.png"
                                        width="5" height="5" /></td>
                                <td align="center" valign="top" background="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/top.png">
                                    <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/top.png"
                                        width="5" height="5" /></td>
                                <td align="right" valign="top">
                                    <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/top-right.png"
                                        width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td width="4" valign="bottom" background="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/left.png">
                                    <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/left.png"
                                        width="5" height="5" /></td>
                                <td height="62" align="center" valign="middle" background="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/center-bg.png">
                                    <table width="100%" border="0" cellspacing="2" cellpadding="2">
                                        <tr>
                                            <td height="62" align="center">
                                                <a href="javascript:ExecuteSettingsActionFlag('_sys_security_settings')">
                                                    <img src="<%=templateThemeDirectory %>Repository/ListControl/images/icons-ribbon/icon-settings.png"
                                                        width="35" height="37" border="0" alt="<%=GetLangSpecText("ec_rbn_nl_security_alt") %>" />
                                                </a>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="4" align="right" valign="bottom" background="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/right.png">
                                    <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/right.png"
                                        width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom" background="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/bottom-left-2.png">
                                    <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/bottom-left-2.png"
                                        width="5" height="5" /></td>
                                <td height="21" align="center" valign="middle" class="sectiontitle">
                                    <%=GetLangSpecText("ec_rbn_userDesign_Report_action_settings")%>
                                </td>
                                <td align="right" valign="bottom" background="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/bottom-right-2.png">
                                    <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/bottom-right-2.png"
                                        width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom">
                                    <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/bottom-left.png"
                                        width="5" height="5" /></td>
                                <td align="center" valign="bottom" background="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/bottom.png">
                                    <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/bottom.png"
                                        width="5" height="5" /></td>
                                <td align="right" valign="bottom">
                                    <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/bottom-right.png"
                                        width="5" height="5" /></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
       
    </tr>
    
</table>
