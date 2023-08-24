<%@ Control Language="C#" AutoEventWireup="true"    Inherits="Skelta.Repository.Web.CodeBehind.WebControls_RibbonBar" %>
  <!--[if lt IE 7]>
  <script defer type="text/javascript" src="scripts/pngfix.js"></script>
  <![endif]-->
<style type="text/css">
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
	    </style>

<script type="text/javascript" language="javascript">
    function ExecuteSettingsActionFlag(command) {
        LocalizeMessages();
        var flag = document.getElementById("gridframe").contentWindow.IsRowSelected();
        if (flag) {
            document.getElementById("gridframe").contentWindow.ExecuteActionForSelectedRow(command);
        }
        else {
            document.getElementById("gridframe").contentWindow.ExecuteActionByName(command);
        }
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

<table width="100%" height="100" border="0" cellpadding="0" cellspacing="0">   
    <tr>
        <td height="75" align="left" valign="top" background="images/borders/center-bg-inside.png">
            <table border="0" cellspacing="1" cellpadding="1">
                <tr>
                 <td width="80">
                    <table width="100%" height="90" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td align="left" valign="top">
                                    <img src="images/borders-ribbon/top-left.png" width="5" height="5" /></td>
                                <td align="center" valign="top" background="images/borders-ribbon/top.png">
                                    <img src="images/borders-ribbon/top.png" width="5" height="5" /></td>
                                <td align="right" valign="top">
                                    <img src="images/borders-ribbon/top-right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td width="5" valign="bottom" background="images/borders-ribbon/left.png">
                                    <img src="images/borders-ribbon/left.png" width="5" height="5" /></td>
                                <td height="61" align="center" valign="middle" background="images/borders-ribbon/center-bg.png">
                                    <table width="100%" border="0" cellspacing="2" cellpadding="2">
                                        <tr>
                                            <td height="61" align="center" class="runtext1">
                                                <a href="javascript:document.getElementById('gridframe').contentWindow.NavigateUp()"
                                                    class="runtext3">
                                                    <img src="images/icons-ribbon/icon-up.png" border="0" /></a></td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="5" align="right" valign="bottom" background="images/borders-ribbon/right.png">
                                    <img src="images/borders-ribbon/right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom" background="images/borders-ribbon/bottom-left-2.png">
                                    <img src="images/borders-ribbon/bottom-left-2.png" width="5" height="5" /></td>
                                <td height="17" align="center" valign="bottom" bgcolor="#ebf2fa" class="runtext1">
                                    <%=GetLangSpecText("ec_rbn_wf_navigate") %>
                                </td>
                                <td align="right" valign="bottom" background="images/borders-ribbon/bottom-right-2.png">
                                    <img src="images/borders-ribbon/bottom-right-2.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom">
                                    <img src="images/borders-ribbon/bottom-left.png" width="5" height="5" /></td>
                                <td align="center" valign="bottom" background="images/borders-ribbon/bottom.png">
                                    <img src="images/borders-ribbon/bottom.png" width="5" height="5" /></td>
                                <td align="right" valign="bottom">
                                    <img src="images/borders-ribbon/bottom-right.png" width="5" height="5" /></td>
                            </tr>
                        </table>         
                </td>
                 <td width="80">
                        <table width="100%" height="90" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td align="left" valign="top">
                                    <img src="images/borders-ribbon/top-left.png" width="5" height="5" /></td>
                                <td align="center" valign="top" background="images/borders-ribbon/top.png">
                                    <img src="images/borders-ribbon/top.png" width="5" height="5" /></td>
                                <td align="right" valign="top">
                                    <img src="images/borders-ribbon/top-right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td width="5" valign="bottom" background="images/borders-ribbon/left.png">
                                    <img src="images/borders-ribbon/left.png" width="5" height="5" /></td>
                                <td height="60" align="center" valign="middle" background="images/borders-ribbon/center-bg.png">
                                    <table width="100%" height="65" border="0" cellspacing="2" cellpadding="2">
                                        <tr>
                                        <td height="25" align="center" valign="middle" >
                                          <a href="javascript:ExecuteActionForSelectedRow('_sys_fill_form')" class="runtext3"><img src="images/icons-ribbon/fill-form-icon.png" border="0" /></a>
                                               
                                            </td>
                                            <td height="25" align="right" >
                                               
                                                    <%--<img src="images/icons-ribbon/icon-workflow.png" width="16" height="16" hspace="2"
                                                        align="absmiddle" /><a href="javascript:ExecuteAction('_sys_fill_form')" class="runtext3"><%=GetLangSpecText("ec_rbn_wf_initiator_form") %></a>
                                               --%>
                                            </td>
                                           
                                        </tr>                                 
                                    </table>
                                </td>
                                <td width="5" align="right" valign="bottom" background="images/borders-ribbon/right.png">
                                    <img src="images/borders-ribbon/right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom" background="images/borders-ribbon/bottom-left-2.png">
                                    <img src="images/borders-ribbon/bottom-left-2.png" width="5" height="5" /></td>
                                <td height="17" align="center" valign="bottom" bgcolor="#ebf2fa" class="runtext1">
                                  Fill Form
                                </td>
                                <td align="right" valign="bottom" background="images/borders-ribbon/bottom-right-2.png">
                                    <img src="images/borders-ribbon/bottom-right-2.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom">
                                    <img src="images/borders-ribbon/bottom-left.png" width="5" height="5" /></td>
                                <td align="center" valign="bottom" background="images/borders-ribbon/bottom.png">
                                    <img src="images/borders-ribbon/bottom.png" width="5" height="5" /></td>
                                <td align="right" valign="bottom">
                                    <img src="images/borders-ribbon/bottom-right.png" width="5" height="5" /></td>
                            </tr>
                        </table>
                    </td>
                   <td width="80">
                        <table width="100%" height="90" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td align="left" valign="top">
                                    <img src="images/borders-ribbon/top-left.png" width="5" height="5" /></td>
                                <td align="center" valign="top" background="images/borders-ribbon/top.png">
                                    <img src="images/borders-ribbon/top.png" width="5" height="5" /></td>
                                <td align="right" valign="top">
                                    <img src="images/borders-ribbon/top-right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td width="4" valign="bottom" background="images/borders-ribbon/left.png">
                                    <img src="images/borders-ribbon/left.png" width="5" height="5" /></td>
                                <td height="60" align="center" valign="middle" background="images/borders-ribbon/center-bg.png">
                                    <table width="100%" border="0" cellspacing="2" cellpadding="2">
                                        <tr>
                                            <td height="62" align="center" class="runtext1">
                                               <a href="javascript:ExecuteSettingsActionFlag('_sys_security_settings')">
                                                    <img src="images/icons-ribbon/icon-settings.png" width="35" height="37" border="0" />
                                                </a>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="4" align="right" valign="bottom" background="images/borders-ribbon/right.png">
                                    <img src="images/borders-ribbon/right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom" background="images/borders-ribbon/bottom-left-2.png">
                                    <img src="images/borders-ribbon/bottom-left-2.png" width="5" height="5" /></td>
                                <td height="16" align="center" valign="bottom" bgcolor="#ebf2fa" class="runtext1">
                                    <%=GetLangSpecText("ec_rbn_wf_settings") %>
                                </td>
                                <td align="right" valign="bottom" background="images/borders-ribbon/bottom-right-2.png">
                                    <img src="images/borders-ribbon/bottom-right-2.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom">
                                    <img src="images/borders-ribbon/bottom-left.png" width="5" height="5" /></td>
                                <td align="center" valign="bottom" background="images/borders-ribbon/bottom.png">
                                    <img src="images/borders-ribbon/bottom.png" width="5" height="5" /></td>
                                <td align="right" valign="bottom">
                                    <img src="images/borders-ribbon/bottom-right.png" width="5" height="5" /></td>
                            </tr>
                        </table>
                    </td>
                    <%-- <td>
                        <table width="100%" height="88" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td align="left" valign="top">
                                    <img src="images/borders-ribbon/top-left.png" width="5" height="5" /></td>
                                <td align="center" valign="top" background="images/borders-ribbon/top.png">
                                    <img src="images/borders-ribbon/top.png" width="5" height="5" /></td>
                                <td align="right" valign="top">
                                    <img src="images/borders-ribbon/top-right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td width="5" valign="bottom" background="images/borders-ribbon/left.png">
                                    <img src="images/borders-ribbon/left.png" width="5" height="5" /></td>
                                <td height="60" align="center" valign="middle" background="images/borders-ribbon/center-bg2.png">
                                   
                                    <table width="100%" border="0" cellspacing="2" cellpadding="2">
                                        <tr>
                                            <td height="62" align="center" class="runtext1">
                                                <a href="javascript:ExecuteActionForSelectedRow('_sys_create_assn')">
                                                    <img src="images/icons-ribbon/Associations-icon.png" border="0" /></a></td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="5" align="right" valign="bottom" background="images/borders-ribbon/right.png">
                                    <img src="images/borders-ribbon/right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom" background="images/borders-ribbon/bottom-left-2.png">
                                    <img src="images/borders-ribbon/bottom-left-2.png" width="5" height="5" /></td>
                                <td align="center" valign="bottom" bgcolor="#ebf2fa" class="runtext1" height="15">
                                    <table height="16" width="100%" border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td align="center" valign="middle" class="runtext1">
                                                <%=GetLangSpecText("ec_rbn_wf_associate") %>
                                            </td>
                                            <td width="5" align="right" valign="middle">
                                                <img src="images/borders-ribbon/bottom-right-2.png" border="0" /></td>
                                        </tr>
                                    </table>
                                </td>
                                <td align="right" valign="bottom" background="images/borders-ribbon/bottom-right-2.png">
                                    <img src="images/borders-ribbon/bottom-right-2.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom">
                                    <img src="images/borders-ribbon/bottom-left.png" width="5" height="5" /></td>
                                <td align="center" valign="bottom" background="images/borders-ribbon/bottom.png">
                                    <img src="images/borders-ribbon/bottom.png" width="5" height="5" /></td>
                                <td align="right" valign="bottom">
                                    <img src="images/borders-ribbon/bottom-right.png" width="5" height="5" /></td>
                            </tr>
                        </table>
                    </td>
                    
                    <td>
                        <table width="100%" height="86" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td align="left" valign="top">
                                    <img src="images/borders-ribbon/top-left.png" width="5" height="5" /></td>
                                <td align="center" valign="top" background="images/borders-ribbon/top.png">
                                    <img src="images/borders-ribbon/top.png" width="5" height="5" /></td>
                                <td align="right" valign="top">
                                    <img src="images/borders-ribbon/top-right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td width="5" valign="bottom" background="images/borders-ribbon/left.png">
                                    <img src="images/borders-ribbon/left.png" width="5" height="5" /></td>
                                <td align="center" valign="middle" background="images/borders-ribbon/center-bg.png">
                                    <table width="100%" height="62" border="0" cellspacing="1" cellpadding="0">
                                        <tr>
                                            <td height="32" align="left" class="runtext1">
                                                
                                            </td>
                                            <td align="left" class="runtext1">
                                                <img src="images/icons-ribbon/delete.png" hspace="0" align="absmiddle" /><span class="runtext2">
                                                    <a href="javascript:ExecuteActionForSelectedRow('_sys_delete')" class="runtext2">   Delete                     </a></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="31" align="left" class="runtext1">
                                                <img src="images/icons-ribbon/icon-publish.png" width="16" height="16" hspace="0"
                                                    align="absmiddle" /><span class="runtext2"><a href="javascript:ExecuteActionForSelectedRow('_sys_publish')"
                                                        class="runtext2"><%=GetLangSpecText("ec_rbn_wf_publish") %></a></span></td>
                                            
                                        </tr>
                                    </table>
                                </td>
                                <td width="5" align="right" valign="bottom" background="images/borders-ribbon/right.png">
                                    <img src="images/borders-ribbon/right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom" background="images/borders-ribbon/bottom-left-2.png">
                                    <img src="images/borders-ribbon/bottom-left-2.png" width="5" height="5" /></td>
                                <td align="center" valign="bottom" bgcolor="#ebf2fa" class="runtext1">
                                    <table width="100%" border="0" cellpadding="0" cellspacing="0" height="16">
                                        <tr>
                                            <td align="center" valign="middle" class="runtext1">
                                                <%=GetLangSpecText("ec_rbn_wf_actions") %>
                                            </td>
                                            <td width="5" align="right" valign="middle">
                                               
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td align="right" valign="bottom" background="images/borders-ribbon/bottom-right-2.png">
                                    <img src="images/borders-ribbon/bottom-right-2.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom">
                                    <img src="images/borders-ribbon/bottom-left.png" width="5" height="5" /></td>
                                <td align="center" valign="bottom" background="images/borders-ribbon/bottom.png">
                                    <img src="images/borders-ribbon/bottom.png" width="5" height="5" /></td>
                                <td align="right" valign="bottom">
                                    <img src="images/borders-ribbon/bottom-right.png" width="5" height="5" /></td>
                            </tr>
                        </table>
                    </td>--%>
                </tr>
            </table>
        </td>
       
    </tr>
  
</table>
