<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.Forms.Web.CodeBehind.CreateList.BPMUITemplates_Default_Repository_ListControl_DynamicRibbonBar" %>
<link rel="stylesheet" type="text/css" href="<%=ThemeURL%>Common/StyleSheet/Global.css" />

<script type="text/javascript" language="javascript">
    function ExecuteSettingsActionFlag(command)
    {
        LocalizeMessages();
    // Ayyub :: In MOM it is decided that List Settings should come from Ribbonbar(irrespective of whether item is selected or not) and ListItem settings should come from context menu
//        var flag =document.getElementById("gridframe").contentWindow.IsRowSelected();
//        if(flag)
//        {
//          document.getElementById("gridframe").contentWindow.ExecuteActionForSelectedRow(command);  
//        }
//        else
//        {       
 

            document.getElementById("gridframe").contentWindow.ExecuteActionByName(command);
//        }
    }
    function ExecuteAction(command){
        LocalizeMessages();
        document.getElementById("gridframe").contentWindow.ExecuteActionByName(command);
    }
    
    function ExecuteActionForSelectedRow(command){
    //Added by Harish for localization.
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
</script>

<table width="100%" height="90" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td height="75" align="left" valign="top" background="<%=ThemeURL%>Repository/ListControl/images/borders/center-bg-inside.png">
            <table width="50%" border="0" cellspacing="1" cellpadding="1">
                <tr>
                    <td style="width:5%" valign="top"><!--*********Up*************-->
                        <table width="80px" height="92" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td align="left" valign="top">
                                    <img  src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/top-left.png" width="5" height="5" /></td>
                                <td align="center" valign="top" background="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/top.png">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/top.png" width="5" height="5" /></td>
                                <td align="right" valign="top">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/top-right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td width="5" valign="bottom" background="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/left.png">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/left.png" width="5" height="5" /></td>
                                <td height="65" align="center" valign="middle" background="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/center-bg.png">
                                    <table width="100%" height="65" border="0" cellspacing="2" cellpadding="2">
                                        <tr>
                                            <td align="center">
                                                <a href="javascript:document.getElementById('gridframe').contentWindow.NavigateUp()" class="sectionitem">
                                                    <img src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/icon-up.png" border="0" alt="<%=GetLangSpecText("ec_rbn_wf_navigate_alt") %>" width="36" height="36" /></a>
                                                    </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="5" align="right" valign="bottom" background="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/right.png">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom" background="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom-left-2.png">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom-left-2.png" width="5" height="5" /></td>
                                <td height="21" align="center" valign="middle" class="sectiontitle">
                                    <%=GetLangSpecText("ec_rbn_wf_navigate") %>
                                </td>
                                <td align="right" valign="bottom" background="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom-right-2.png">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom-right-2.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom-left.png" width="5" height="5" /></td>
                                <td align="center" valign="bottom" background="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom.png">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom.png" width="5" height="5" /></td>
                                <td align="right" valign="bottom">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom-right.png" width="5" height="5" /></td>
                            </tr>
                        </table>
                    </td>
                    <td style="width:5%" valign="top"><!--*********NewFolder*************-->
                        <table width="80px" height="92" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td align="left" valign="top">
                                    <img  src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/top-left.png" width="5" height="5" /></td>
                                <td align="center" valign="top" background="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/top.png">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/top.png" width="5" height="5" /></td>
                                <td align="right" valign="top">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/top-right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td width="5" valign="bottom" background="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/left.png">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/left.png" width="5" height="5" /></td>
                                <td height="65" align="center" valign="middle" background="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/center-bg.png">
                                    <table width="100%" height="65" border="0" cellspacing="2" cellpadding="2">
                                        <tr>
                                            <td align="center">
                                                <a href="javascript:ExecuteSettingsActionFlag('_sys_newfolder')" class="sectionitem">
                                                    <img src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/folder-icon.png" border="0" alt="<%=GetLangSpecText("ec_rbn_wf_navigate_alt") %>" width="36" height="36" /></a>
                                                    </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="5" align="right" valign="bottom" background="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/right.png">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom" background="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom-left-2.png">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom-left-2.png" width="5" height="5" /></td>
                                <td height="21" align="center" valign="middle" class="sectiontitle">
                                    <%=GetLangSpecText("ec_rbn_wf_folder") %>
                                </td>
                                <td align="right" valign="bottom" background="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom-right-2.png">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom-right-2.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom-left.png" width="5" height="5" /></td>
                                <td align="center" valign="bottom" background="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom.png">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom.png" width="5" height="5" /></td>
                                <td align="right" valign="bottom">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom-right.png" width="5" height="5" /></td>
                            </tr>
                        </table>
                    </td>
                    <td style="width:5%" valign="top"><!--*********New*************-->
                        <table width="80px" height="92" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td align="left" valign="top">
                                    <img  src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/top-left.png" width="5" height="5" /></td>
                                <td align="center" valign="top" background="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/top.png">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/top.png" width="5" height="5" /></td>
                                <td align="right" valign="top">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/top-right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td width="5" valign="bottom" background="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/left.png">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/left.png" width="5" height="5" /></td>
                                <td height="65" align="center" valign="middle" background="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/center-bg.png">
                                    <table width="100%" height="65" border="0" cellspacing="2" cellpadding="2">
                                        <tr>
                                            <td align="center">
                                                <a href="javascript:ExecuteAction('_sys_new')" class="sectionitem">
                                                    <img src="<%=ThemeURL%>/Repository/ListControl/images/icons-ribbon/icon-package-new.png" border="0" alt="<%=GetLangSpecText("ec_rbn_wf_navigate_alt") %>" width="36" height="36" /></a>
                                                    </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="5" align="right" valign="bottom" background="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/right.png">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom" background="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom-left-2.png">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom-left-2.png" width="5" height="5" /></td>
                                <td height="21" align="center" valign="middle" class="sectiontitle">
                                    <%=GetLangSpecText("Pkg_rbn_new_packagetemplate")%>
                                </td>
                                <td align="right" valign="bottom" background="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom-right-2.png">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom-right-2.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom-left.png" width="5" height="5" /></td>
                                <td align="center" valign="bottom" background="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom.png">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom.png" width="5" height="5" /></td>
                                <td align="right" valign="bottom">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom-right.png" width="5" height="5" /></td>
                            </tr>
                        </table>
                    </td>
                    <td width="20%" valign="top"><!--*********Actions*************-->
                        <table width="350" height="92" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td align="left" valign="top">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/top-left.png" width="5" height="5" /></td>
                                <td align="center" valign="top" background="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/top.png">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/top.png" width="5" height="5" /></td>
                                <td align="right" valign="top">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/top-right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td width="5" valign="bottom" background="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/left.png">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/left.png" width="5" height="5" /></td>
                                <td height="65" align="center" valign="middle" background="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/center-bg.png">
                                    <table width="100%" height="65" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td height="25" align="left">
                                                <span><a href="javascript:ExecuteActionForSelectedRow('_sys_edit')" class="sectionitem">
                                                    <img alt="<%=GetLangSpecText("ec_rbn_pt_edit") %>" src="<%=ThemeURL%>/Repository/ListControl/images/icons-ribbon/icon-edit.png"
                                                        align="absmiddle" border="0" /><%=GetLangSpecText("ec_rbn_pt_edit")%></a></span></td>
                                            <td height="25" align="left">
                                                <span><a href="javascript:ExecuteActionForSelectedRow('_sys_view_package_template')" class="sectionitem">
                                                    <img alt="<%=GetLangSpecText("ec_rbn_pt_view") %>" src="<%=ThemeURL%>/Repository/ListControl/images/icons-ribbon/icon-view-package-template.png"
                                                        align="absmiddle" border="0"/><%=GetLangSpecText("ec_rbn_pt_view")%></a></span></td>                                            
 											<td height="25" align="left">
                                                <span><a href="javascript:ExecuteActionForSelectedRow('_sys_delete')" class="sectionitem">
                                                    <img alt="<%=GetLangSpecText("ec_rbn_pt_delete")%>" src="<%=ThemeURL%>/Repository/ListControl/images/icons-ribbon/delete.png"
                                                        align="absmiddle" border="0"/><%=GetLangSpecText("ec_rbn_pt_delete")%></a></span></td>
											<td height="25" align="left">
                                                <span><a href="javascript:ExecuteActionForSelectedRow('_sys_publish')" class="sectionitem">
                                                    <img alt="<%=GetLangSpecText("ec_rbn_pt_publish")%>" src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/icon-publish.png"
                                                        align="absmiddle" border="0"/><%=GetLangSpecText("ec_rbn_pt_publish")%></a></span></td>
                                        </tr>
                                        <tr>
                                            <%--<td height="25" align="left">
                                                <span><a href="javascript:ExecuteActionForSelectedRow('_sys_add_parameter_form')" class="sectionitem">
                                                    <img alt="<%=GetLangSpecText("Pkg_ptcm_parameterform") %>" src="<%=ThemeURL%>/Repository/ListControl/images/icons-ribbon/icon-add-parameter-form.png"
                                                        align="absmiddle" border="0"/><%=GetLangSpecText("Pkg_ptcm_parameterform")%></a></span></td>--%>
                                            <td height="25" align="left">
                                                <span><a href="javascript:ExecuteActionForSelectedRow('_sys_generate_package_template')" class="sectionitem">
                                                    <img alt="<%=GetLangSpecText("Pkg_rbn_generate_packagetemplate") %>" src="<%=ThemeURL%>/Repository/ListControl/images/icons-ribbon/icon-generate-package-template.png"
                                                       align="absmiddle" border="0" /><%=GetLangSpecText("Pkg_rbn_generate_packagetemplate")%></a></span></td>
                                            <td height="25" align="left">
                                                <span><a href="javascript:ExecuteActionForSelectedRow('_sys_download_package_template')" class="sectionitem">
                                                    <img alt="<%=GetLangSpecText("Pkg_ptcm_downloadpackagetemplate")%>" src="<%=ThemeURL%>/Repository/ListControl/images/icons-ribbon/icon-download-package-template.png"
                                                     width="23" height="23"  align="absmiddle" border="0"/>
                                                    <%=GetLangSpecText("Pkg_ptcm_downloadpackagetemplate")%>
                                                </a></span>
                                            </td>
                                            <td height="25" align="left">
                                               	 <span>
                                                <a href="javascript:ExecuteActionForSelectedRow('_sys_ship_package_template')" class="sectionitem">
                                                    <img alt="<%=GetLangSpecText("Pkg_ptcm_shippedpackagetemplate") %>" src="<%=ThemeURL%>/Repository/ListControl/images/icons-ribbon/icon-ship-package-template.png" align="absmiddle" border="0"/>
                                                    <%=GetLangSpecText("Pkg_ptcm_shippedpackagetemplate")%>
                                                </a>
                                                </span>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="5" align="right" valign="bottom" background="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/right.png">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom" background="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom-left-2.png">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom-left-2.png" width="5" height="5" /></td>
                                <td height="21" align="center" valign="middle" class="sectiontitle" >
                                    <%=GetLangSpecText("ec_rbn_wf_actions") %>
                                </td>
                                <td align="right" valign="bottom" background="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom-right-2.png">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom-right-2.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom-left.png" width="5" height="5" /></td>
                                <td align="center" valign="bottom" background="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom.png">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom.png" width="5" height="5" /></td>
                                <td align="right" valign="bottom">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom-right.png" width="5" height="5" /></td>
                            </tr>
                        </table>
                    </td>				
                    <td valign="top"><!--*********Security*************-->
                        <table width="80px" height="92" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td align="left" valign="top">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/top-left.png"  width="5" height="5" /></td>
                                <td align="center" valign="top" background="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/top.png" >
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/top.png"  width="5" height="5" /></td>
                                <td align="right" valign="top">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/top-right.png"  width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td width="5" valign="bottom" background="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/left.png" >
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/left.png"  width="5" height="5" /></td>
                                <td height="65" align="center" valign="middle" background="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/center-bg.png" >
                                    <table height="65" width="100%" border="0" cellspacing="2" cellpadding="2">
                                        <tr>
                                            <td height="60" align="center" >
                                                <a href="javascript:ExecuteSettingsActionFlag('_sys_security_settings')" class="sectionitem">
                                                    <img src="<%=ThemeURL%>Repository/ListControl/images/icons-ribbon/icon-settings.png" width="36" height="36"  border="0" alt="<%=GetLangSpecText("ec_rbn_nl_security_alt") %>"/>
                                                </a>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="5" align="right" valign="bottom" background="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/right.png" >
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/right.png"  width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom" background="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom-left-2.png" >
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom-left-2.png"  width="5" height="5" /></td>
                                <td height="21" align="center" valign="middle" class="sectiontitle" >
                                    <%=GetLangSpecText("ec_rbn_wf_settings") %>
                                </td>
                                <td align="right" valign="bottom" background="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom-right-2.png" >
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom-right-2.png"  width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom-left.png"  width="5" height="5" /></td>
                                <td align="center" valign="bottom" background="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom.png" >
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom.png"  width="5" height="5" /></td>
                                <td align="right" valign="bottom">
                                    <img src="<%=ThemeURL%>Repository/ListControl/images/borders-ribbon/bottom-right.png"  width="5" height="5" /></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
