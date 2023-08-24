<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.WebControls_RibbonBar" %>
 
 <link href="<%=templateThemeDirectory%>Common/StyleSheet/Global.css" rel="stylesheet" />



<script type="text/javascript" language="javascript">
var hgt = screen.availHeight;
function ExecuteAction(command) {
    LocalizeMessages();
        document.getElementById("gridframe").contentWindow.ExecuteActionByName(command);
    }

    function ExecuteActionForSelectedRow(command) {
        LocalizeMessages();
    
       
        document.getElementById("gridframe").contentWindow.ExecuteActionForSelectedRow(command);
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
    }
    
    function LocalizeMessages() {
        document.getElementById("gridframe").contentWindow.cannotPerDisable = '<%=GetLangSpecText("ec_rbn_wf_cannotperformondisabled")%>';
        document.getElementById("gridframe").contentWindow.noRowSelected = '<%=GetLangSpecText("ec_rbn_wf_norowselected")%>';
        document.getElementById("gridframe").contentWindow.norightforaction = '<%=GetLangSpecText("ec_rbn_wf_norightforaction")%>';
        document.getElementById("gridframe").contentWindow.sysDel = '<%=GetLangSpecText("ec_rbn_wf_sysdelete")%>';
        document.getElementById("gridframe").contentWindow.NotAbleToEditFolder = '<%=GetLangSpecText("ec_rbn_nav_noedit_folder")%>';

    }

</script>

<table width="100%" height="100" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td align="left" valign="top">
            <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders/left-top-inside.png" width="4" height="4" /></td>
        <td align="center" valign="top" background="<%=templateThemeDirectory %>Repository/ListControl/images/borders/center-top-inside.png">
            <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders/center-top-inside.png" width="4" height="4" /></td>
        <td align="right" valign="top">
            <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders/right-top-inside.png" width="4" height="4" /></td>
    </tr>
    <tr>
        <td width="4" valign="bottom" background="<%=templateThemeDirectory %>Repository/ListControl/images/borders/left-bg-inside.png">
            <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders/left-inside.png" width="4" height="6" />
        </td>
        <td height="75" align="left" valign="top" background="<%=templateThemeDirectory %>Repository/ListControl/images/borders/center-bg-inside.png">
            <table width="250" border="0" cellspacing="1" cellpadding="1">
                <tr>                   
                    
                    <td style="width:5%">
                        <table width="80px" height="90" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td align="left" valign="top">
                                    <img  src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/top-left.png" width="5" height="5" /></td>
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
                                                <a href="javascript:document.getElementById('gridframe').contentWindow.NavigateUp()"
                                                    class="sectionitem">
                                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/icon-up.png" border="0" /></a></td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="5" align="right" valign="bottom" background="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/right.png">
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom" background="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/bottom-left-2.png">
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/bottom-left-2.png" width="5" height="5" /></td>
                                <td height="21" align="center" valign="bottom" class="sectiontitle"  >
                                    <%=GetLangSpecText("ec_rbn_wf_navigate") %>
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
                    
                    <td width=5%>
                        <table width="80px" height="90" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td align="left" valign="top">
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/top-left.png"  width="5" height="5" /></td>
                                <td align="center" valign="top" background="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/top.png">
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/top.png"  width="5" height="5" /></td>
                                <td align="right" valign="top">
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/top-right.png"  width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td width="5" valign="bottom" background="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/left.png" >
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/left.png"  width="5" height="5" /></td>
                                <td height="60" align="center" valign="middle" background="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/center-bg.png" >
                                    <table width="100%" border="0" cellspacing="2" cellpadding="2">
                                        <tr>
                                             <td height="62" align="center">
                                                <a href="javascript:ExecuteSettingsActionFlag('_sys_newfolder')">
                                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/folder-icon.png"  border="0" />
                                                </a>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="5" align="right" valign="bottom" background="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/right.png" >
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/right.png"  width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom" background="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/bottom-left-2.png" >
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/bottom-left-2.png"  width="5" height="5" /></td>
                                <td height="21" align="center" valign="bottom" class="sectiontitle" >
                                    <%=GetLangSpecText("ec_rbn_wf_folder")%>
                                </td>
                                <td align="right" valign="bottom" background="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/bottom-right-2.png" >
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/bottom-right-2.png"  width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom">
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/bottom-left.png"  width="5" height="5" /></td>
                                <td align="center" valign="bottom" background="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/bottom.png" >
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/bottom.png"  width="5" height="5" /></td>
                                <td align="right" valign="bottom">
                                    <img src="<%=templateThemeDirectory%>Repository/ListControl/images/borders-ribbon/bottom-right.png"  width="5" height="5" /></td>
                            </tr>
                        </table>
                    </td>
                    
                    
                    <td width=10% valign="top">
                        <!-- ***************** Edit/Delete ***************** -->
                        <table width="340px" height="90" border="0" cellpadding="0" cellspacing="0" align="center">
                            <tr>
                                <td align="left" valign="top">
                                    <img src="<%=templateThemeDirectory%>/Repository/ListControl/images/borders-ribbon/top-left.png" width="5" height="5" /></td>
                                <td align="center" valign="top" background="<%=templateThemeDirectory%>/Repository/ListControl/images/borders-ribbon/top.png">
                                    <img src="<%=templateThemeDirectory%>/Repository/ListControl/images/borders-ribbon/top.png" width="5" height="5" /></td>
                                <td align="right" valign="top">
                                    <img src="<%=templateThemeDirectory%>/Repository/ListControl/images/borders-ribbon/top-right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td width="5" valign="bottom" background="<%=templateThemeDirectory%>/Repository/ListControl/images/borders-ribbon/left.png">
                                    <img src="<%=templateThemeDirectory%>/Repository/ListControl/images/borders-ribbon/left.png" width="5" height="5" /></td>
                                <td align="center" valign="middle" background="<%=templateThemeDirectory%>/Repository/ListControl/images/borders-ribbon/center-bg.png">
                                    <table width="100%" height="67" border="0" cellspacing="1" cellpadding="0">
                                        <tr>
                                            <td align="left" class="sectionitem">
                                                <img src="<%=templateThemeDirectory%>/Repository/ListControl/images/icons-ribbon/Icon-package-add.png" hspace="0" align="absmiddle" /><span class="sectionitem">
                                                    <a href="javascript:ExecuteSettingsActionFlag('_sys_package_add')" class="sectionitem">
                                                        <%=GetLangSpecText("Upload")%>
                                                    </a></span>
                                            </td>
                                            <td height="25" align="left" class="sectionitem">
                                                <img src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/icon-view-package.png"  hspace="2"
                                                    align="absmiddle" /><a href="javascript:ExecuteActionForSelectedRow('_sys_view_package')" class="sectionitem"><%=GetLangSpecText("View") %></a>
                                            </td>
                                             
                                          <td height="25" align="left" class="sectionitem">
                                                <img src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/icon-edit-settings.png"  hspace="2"
                                                    align="absmiddle" /><a href="javascript:ExecuteActionForSelectedRow('_sys_edit_settingsform')" class="sectionitem"><%=GetLangSpecText("Edit") %></a>
                                            </td>    
                                             <td height="25" align="left" class="sectionitem">
                                                <img src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/icon-package-install.png"  hspace="2"
                                                    align="absmiddle" /><a href="javascript:ExecuteActionForSelectedRow('_sys_run_package')" class="sectionitem"><%=GetLangSpecText("Run") %></a>
                                            </td>
                                         </tr>
                                        <tr>
                                        <td align="left" class="sectionitem">
                                                <img src="<%=templateThemeDirectory%>/Repository/ListControl/images/icons-ribbon/icon-package-delete.png" hspace="0" align="absmiddle" /><span class="sectionitem">
                                                    <a href="javascript:ExecuteActionForSelectedRow('_sys_delete')" class="sectionitem">
                                                        <%=GetLangSpecText("ec_rbn_wf_delete") %>
                                                    </a></span>
                                            </td>
                                            <td height="25" align="left" class="sectionitem">
                                            <img src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/icon-package-uninstall.png"  
                                                    hspace="2" align="absmiddle" /><a href="javascript:ExecuteActionForSelectedRow('_sys_uninstall_package')"
                                                        class="sectionitem"><%=GetLangSpecText("ec_rbn_package_uninstall")%></a>                                                
                                            </td>
                                            <td height="25" align="left" class="sectionitem" >
                                                <img src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/icon-package-history.png"  hspace="2"
                                                    align="absmiddle" /><a href="javascript:ExecuteActionForSelectedRow('_sys_package_history')" class="sectionitem"><%=GetLangSpecText("History") %></a>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="5" align="right" valign="bottom" background="<%=templateThemeDirectory%>/Repository/ListControl/images/borders-ribbon/right.png">
                                    <img src="<%=templateThemeDirectory%>/Repository/ListControl/images/borders-ribbon/right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom" background="<%=templateThemeDirectory%>/Repository/ListControl/images/borders-ribbon/bottom-left-2.png">
                                    <img src="<%=templateThemeDirectory%>/Repository/ListControl/images/borders-ribbon/bottom-left-2.png" width="5" height="5" /></td>
                                <td align="center" valign="bottom" class="sectiontitle">
                                    <table width="100%" border="0" cellpadding="0" cellspacing="0" height="21">
                                        <tr>
                                            <td align="center" valign="middle" class="sectionitem">
                                                <%=GetLangSpecText("Actions")%>
                                            </td>
                                            <td width="5" align="right" valign="middle" class="sectiontitle">                                                
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td align="right" valign="bottom" background="<%=templateThemeDirectory%>/Repository/ListControl/images/borders-ribbon/bottom-right-2.png">
                                    <img src="<%=templateThemeDirectory%>/Repository/ListControl/images/borders-ribbon/bottom-right-2.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom">
                                    <img src="<%=templateThemeDirectory%>/Repository/ListControl/images/borders-ribbon/bottom-left.png" width="5" height="5" /></td>
                                <td align="center" valign="bottom" background="<%=templateThemeDirectory%>/Repository/ListControl/images/borders-ribbon/bottom.png">
                                    <img src="<%=templateThemeDirectory%>/Repository/ListControl/images/borders-ribbon/bottom.png" width="5" height="5" /></td>
                                <td align="right" valign="bottom">
                                    <img src="<%=templateThemeDirectory%>/Repository/ListControl/images/borders-ribbon/bottom-right.png" width="5" height="5" /></td>
                            </tr>
                        </table>
                    </td>
                                        
                   <!-- <td style="width:5%">
                        <table width="106px" height="90" border="0" cellpadding="0" cellspacing="0" align="center">
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
                                            <td height="25" align="left" class="sectionitem">
                                                <img src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/icon-package-install.png"  hspace="2"
                                                    align="absmiddle" /><a href="javascript:ExecuteActionForSelectedRow('_sys_run_package')" class="sectionitem"><%=GetLangSpecText("Run") %></a>
                                            </td>
                                            </tr>
                                            <tr>
                                            <td height="25" align="left" class="sectionitem">
                                            <img src="<%=templateThemeDirectory%>Repository/ListControl/images/icons-ribbon/icon-package-uninstall.png"  
                                                    hspace="2" align="absmiddle" /><a href="javascript:ExecuteActionForSelectedRow('_sys_uninstall_package')"
                                                        class="sectionitem"><%=GetLangSpecText("ec_rbn_package_uninstall")%></a>                                                
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
                                <td height="17" align="center" valign="bottom" class="sectionitem" >
                                    <%=GetLangSpecText("ec_rbn_package_managepackage") %>
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
                    </td>-->
                    
                    <td style="width:5%"><%--Security--%>
                        <table width="90px" height="90" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td align="left" valign="top">
                                    <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/top-left.png" width="5" height="5" /></td>
                                <td align="center" valign="top" background="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/top.png">
                                    <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/top.png" width="5" height="5" /></td>
                                <td align="right" valign="top">
                                    <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/top-right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td width="5" valign="bottom" background="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/left.png">
                                    <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/left.png" width="5" height="5" /></td>
                                <td height="60" align="center" valign="middle" background="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/center-bg.png">
                                    <table width="100%" border="0" cellspacing="2" cellpadding="2">
                                        <tr>
                                            <td height="62" align="center">
                                                <a href="javascript:ExecuteSettingsActionFlag('_sys_security_settings')" class="sectionitem">
                                                    <img src="<%=templateThemeDirectory %>Repository/ListControl/images/icons-ribbon/icon-settings.png" border="0" alt="<%=GetLangSpecText("ec_rbn_nl_security_alt") %>" width="36" height="36"/>
                                                </a>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="5" align="right" valign="bottom" background="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/right.png">
                                    <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom" background="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/bottom-left-2.png">
                                    <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/bottom-left-2.png" width="5" height="5" /></td>
                                <td height="21" align="center" valign="middle"  class="sectiontitle">
                                    <%=GetLangSpecText("ec_rbn_wf_settings") %>
                                </td>
                                <td align="right" valign="bottom" background="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/bottom-right-2.png">
                                    <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/bottom-right-2.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom">
                                    <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/bottom-left.png" width="5" height="5" /></td>
                                <td align="center" valign="bottom" background="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/bottom.png">
                                    <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/bottom.png" width="5" height="5" /></td>
                                <td align="right" valign="bottom">
                                    <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/bottom-right.png" width="5" height="5" /></td>
                            </tr>
                        </table>
                    </td>
                                       
                    
                    
                </tr>
            </table>
        </td>
        <td width="4" align="right" valign="bottom" background="<%=templateThemeDirectory %>Repository/ListControl/images/borders/right-inside.png">
            <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders/right-inside.png" width="4" height="6" /></td>
    </tr>
    <tr>
        <td valign="bottom">
            <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders/left-bottom-inside.png" width="4" height="4" /></td>
        <td align="center" valign="bottom" background="<%=templateThemeDirectory %>Repository/ListControl/images/borders/center-bottom-inside.png">
            <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders/center-bottom-inside.png" width="4" height="4" /></td>
        <td align="right" valign="bottom">
            <img src="<%=templateThemeDirectory %>Repository/ListControl/images/borders/right-bottom-inside.png" width="4" height="4" /></td>
    </tr>
</table>
