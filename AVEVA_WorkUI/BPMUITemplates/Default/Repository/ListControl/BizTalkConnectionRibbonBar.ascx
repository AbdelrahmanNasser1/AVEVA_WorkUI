<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.WebControls_RibbonBar" %>
 <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(templateThemeDirectory)%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />

  <!--[if lt IE 7]>
  <script defer type="text/javascript" src="scripts/pngfix.js"></script>
  <![endif]-->
<%--<style type="text/css">
			<!--
			a {
			text-decoration: none;
			color: #333333;
			}			
		.runtext1 {
			font-family: "Segoe UI", "Trebuchet MS";
			font-size: 11px;
			text-decoration: none;
			color: #333333;
		}
		.runtext2 {
			font-family: "Segoe UI", "Trebuchet MS";
			font-size: 10px;
			color: #333333;
			text-decoration: none;
		}
		.runtext3 {
			font-family: "Segoe UI", "Trebuchet MS";
			font-size: 11px;
			color: #333333;
			text-decoration: none;
		}
		
		a:hover.runtext2 {
			background-image: url(images/Mouseover1.png);
		}
		
		a:hover.category {
			background-image: url(images/Mouseover1.png);
		}
		
		#category {
			position:fixed;
			top:10px;
			}
			
		.tdbg {
			position: static;
			z-index: 1;
		}		
		-->
	    </style>--%>
<script type="text/javascript" language="javascript">
    function ExecuteSettingsActionFlag(command)
    {
    // Ayyub :: In MOM it is decided that List Settings should come from Ribbonbar(irrespective of whether item is selected or not) and ListItem settings should come from context menu
        LocalizeMessages();
        document.getElementById("gridframe").contentWindow.ExecuteActionByName(command);
    }
    function ExecuteAction(command){
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
        document.getElementById("gridframe").contentWindow.NotAbleToEditFolder = '<%=GetLangSpecText("ec_rbn_nav_noedit_folder")%>';
    }
</script>

<table width="100%" height="90" border="0" cellpadding="0" cellspacing="0">
     
    <tr>
       
        <td height="75" align="left" valign="top" background="<%=templateThemeDirectory %>Repository/ListControl/images/borders/center-bg-inside.png">
            <table width="215" border="0" cellspacing="1" cellpadding="1">
                <tr>
                    <td style="width:20%">
                        <table width="98px" height="92" border="0" cellpadding="0" cellspacing="0">
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
                                <td height="61" align="center" valign="middle" background="<%=templateThemeDirectory %>Repository/ListControl/images/borders-ribbon/center-bg.png">
                                    <table width="100%" border="0" cellspacing="2" cellpadding="2">
                                        <tr>
                                             <td height="62" align="center">
                                                <a href="javascript:ExecuteSettingsActionFlag('_sys_new')" class="sectionitem">
                                                    <img alt="<%=GetLangSpecText("ecm_list_cm_newbztcon_header_alttext") %>" src="<%=templateThemeDirectory %>Repository/ListControl/images/icons-ribbon/icon-BizTalk-Connection.png" border="0" width="36" height="36" />
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
                                    <%=GetLangSpecText("ecm_list_cm_newbztcon_header") %>
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
                    <td style="width:10%">
                        <table width="90px" height="92" border="0" cellpadding="0" cellspacing="0">
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
                                  
                                            <td height="62" align="left">
                                                <span><a href="javascript:ExecuteActionForSelectedRow('_sys_delete')" class="sectionitem">
                                                    <img alt="<%=GetLangSpecText("ecm_rbn_bztcon_deleteAltText")%>" src="<%=templateThemeDirectory %>Repository/ListControl/images/icons-ribbon/delete.png"
                                                        hspace="0" align="absmiddle" border="0" width="23" height="23" />&nbsp;<%=GetLangSpecText("ecm_rbn_bztcon_delete")%></a></span>
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
                                    <%=GetLangSpecText("ecm_rbn_bztcon_actions")%>
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
                    <td style="width:10%">
                        <table width="90px" height="92" border="0" cellpadding="0" cellspacing="0">
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
                                    <%=GetLangSpecText("ecm_rbn_bztcon_settings") %>
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
       
    </tr>
  
</table>
