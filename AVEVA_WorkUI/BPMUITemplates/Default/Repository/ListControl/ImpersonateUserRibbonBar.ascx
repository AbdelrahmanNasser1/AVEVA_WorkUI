<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.ImpersonateUserRibbonBar" %>
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

<script language="javascript">
    function ExecuteAction(command){
        LocalizeMessages();
        document.frames("gridframe").ExecuteActionByName(command);
    }
    function LocalizeMessages() {
        document.getElementById("gridframe").contentWindow.cannotPerDisable = '<%=GetLangSpecText("ec_rbn_wf_cannotperformondisabled")%>';
        document.getElementById("gridframe").contentWindow.noRowSelected = '<%=GetLangSpecText("ec_rbn_wf_norowselected")%>';
        document.getElementById("gridframe").contentWindow.norightforaction = '<%=GetLangSpecText("ec_rbn_wf_norightforaction")%>';
        document.getElementById("gridframe").contentWindow.sysDel = '<%=GetLangSpecText("ec_rbn_wf_sysdelete")%>';
        document.getElementById("gridframe").contentWindow.NotAbleToEditFolder = '<%=GetLangSpecText("ec_rbn_nav_noedit_folder")%>';
    }
</script>

<table width="100%" height="100" border="2" cellpadding="0" cellspacing="0">
    
    <tr>
       
        <td height="75" align="left" valign="top" background="images/borders/center-bg-inside.png">
            <table width="500" border="0" cellspacing="1" cellpadding="1">
                <tr>
                                <td>
                        <table width="60" height="90" border="0" cellpadding="0" cellspacing="0">
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
                                               <a href="javascript:document.frames['gridframe'].NavigateUp()" class="runtext3">   <img src="images/icons-ribbon/icon-up.png" border="0" /></a></td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="4" align="right" valign="bottom" background="images/borders-ribbon/right.png">
                                    <img src="images/borders-ribbon/right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom" background="images/borders-ribbon/bottom-left-2.png">
                                    <img src="images/borders-ribbon/bottom-left-2.png" width="5" height="5" /></td>
                                <td height="16" align="center" valign="bottom" bgcolor="c1daf1" class="runtext1">
                                    Navigate
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
                        <table width="90" height="90" border="0" cellpadding="0" cellspacing="0">
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
                                    <table width="100%" height="65" border="0" cellspacing="2" cellpadding="2">
                                        <tr>
                                            <td height="25" align="left">
                                                <div id="category">
                                                    <img src="images/icons-ribbon/icon-category.png" width="16" height="16" hspace="2"
                                                        align="absmiddle" /><a href="javascript:ExecuteAction('_sys_new')" class="runtext3"><%=GetLangSpecText("ec_rbn_wf_folder") %></a><%--Category_sys_newcategory--%>
</div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="25" align="left" class="runtext3">
                                                <img src="images/icons-ribbon/icon-workflow.png" width="16" height="16" hspace="2"
                                                    align="absmiddle" /><a href="javascript:ExecuteAction('_sys_edit')" class="runtext3"><%=GetLangSpecText("ec_rbn_wf_folder") %></a></td><%--Workflow--%>
                                        </tr>
                                    </table>
                                </td>
                                <td width="4" align="right" valign="bottom" background="images/borders-ribbon/right.png">
                                    <img src="images/borders-ribbon/right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom" background="images/borders-ribbon/bottom-left-2.png">
                                    <img src="images/borders-ribbon/bottom-left-2.png" width="5" height="5" /></td>
                                <td height="16" align="center" valign="bottom" bgcolor="c1daf1" class="runtext1">
                                    New</td>
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
                        <table width="90" height="90" border="0" cellpadding="0" cellspacing="0">
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
                                            <td height="25" align="center" class="runtext1">
                                                <a href="#">
                                                    <img src="images/icons-ribbon/icon-views.png" width="29" height="27" border="0" /></a></td>
                                        </tr>
                                        <tr>
                                            <td height="25" align="center" class="runtext1">
                                                <a href="#" class="runtext1">Views</a><br />
                                                <a href="#">
                                                    <img src="images/borders-ribbon/down-arrow.png" width="5" height="4" hspace="4" vspace="4"
                                                        border="0" /></a></td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="4" align="right" valign="bottom" background="images/borders-ribbon/right.png">
                                    <img src="images/borders-ribbon/right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom" background="images/borders-ribbon/bottom-left-2.png">
                                    <img src="images/borders-ribbon/bottom-left-2.png" width="5" height="5" /></td>
                                <td height="16" align="center" valign="bottom" bgcolor="c1daf1" class="runtext1">
                                    Views
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
                        <table width="60" height="90" border="0" cellpadding="0" cellspacing="0">
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
                                                <a href="#">
                                                    <img src="images/icons-ribbon/icon-settings.png" width="35" height="37" border="0" /></a></td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="4" align="right" valign="bottom" background="images/borders-ribbon/right.png">
                                    <img src="images/borders-ribbon/right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom" background="images/borders-ribbon/bottom-left-2.png">
                                    <img src="images/borders-ribbon/bottom-left-2.png" width="5" height="5" /></td>
                                <td height="16" align="center" valign="bottom" bgcolor="c1daf1" class="runtext1">
                                    Settings
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
                        <table width="160" height="88" border="0" cellpadding="0" cellspacing="0">
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
                                <td height="60" align="center" valign="middle" background="images/borders-ribbon/center-bg2.png">
                                    <table width="100%" border="0" cellspacing="1" cellpadding="1">
                                        <tr>
                                            <td height="32" align="left" class="runtext1">
                                                <img src="images/icons-ribbon/icon-sharepoint.png" width="16" height="16" hspace="0"
                                                    align="absmiddle" /><span class="runtext2"><a href="#" class="runtext2"> SharePoint</a></span></td>
                                            <td align="left" class="runtext1">
                                                <img src="images/icons-ribbon/icon-file-system.png" width="16" height="16" hspace="0"
                                                    align="absmiddle" /><span class="runtext2"><a href="#" class="runtext2">File System</a></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="32" align="left" class="runtext1">
                                                <img src="images/icons-ribbon/icon-enterprise.png" width="16" height="16" hspace="0"
                                                    align="absmiddle" /><span class="runtext2"> <a href="#" class="runtext2">Enterprise
                                                        List</a> </span>
                                            </td>
                                            <td align="left" class="runtext1">
                                                <img src="images/icons-ribbon/icon-scheduler.png" width="16" height="16" hspace="0"
                                                    align="absmiddle" /><span class="runtext2"><a href="#" class="runtext2"> Scheduler</a></span></td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="4" align="right" valign="bottom" background="images/borders-ribbon/right.png">
                                    <img src="images/borders-ribbon/right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom" background="images/borders-ribbon/bottom-left-2.png">
                                    <img src="images/borders-ribbon/bottom-left-2.png" width="5" height="5" /></td>
                                <td align="center" valign="bottom" bgcolor="c1daf1" class="runtext1" height="15">
                                    <table height="15" width="100%" border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td align="center" valign="middle" class="runtext1">
                                                Associate</td>
                                            <td width="5" align="right" valign="middle">
                                                <a href="#" title="Associate">
                                                    <img src="images/arrow-more.png" border="0" /></a></td>
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
                        <table width="75" height="90" border="0" cellpadding="0" cellspacing="0">
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
                                    <table width="100%" border="0" height="65" cellspacing="1" cellpadding="1">
                                        <tr>
                                            <td height="25" align="left" class="runtext1">
                                                <img src="images/icons-ribbon/icon-process.png" width="16" height="16" hspace="0"
                                                    align="absmiddle" /><span class="runtext2"><a href="#" class="runtext2">Process</a></span></td>
                                        </tr>
                                        <tr>
                                            <td height="25" align="left" class="runtext1">
                                                <img src="images/icons-ribbon/icon-workflow.png" width="16" height="16" hspace="0"
                                                    align="absmiddle" /><span class="runtext2"><a href="#" class="runtext2">Workflow</a></span></td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="4" align="right" valign="bottom" background="images/borders-ribbon/right.png">
                                    <img src="images/borders-ribbon/right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom" background="images/borders-ribbon/bottom-left-2.png">
                                    <img src="images/borders-ribbon/bottom-left-2.png" width="5" height="5" /></td>
                                <td height="16" align="center" valign="bottom" bgcolor="c1daf1" class="runtext1">
                                    Link</td>
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
                 <!--   <td>
                        <table width="190" height="90" border="0" cellpadding="0" cellspacing="0">
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
                                    <table width="100%" border="0" height="65" cellspacing="1" cellpadding="1">
                                        <tr>
                                            <td height="18" align="left" class="runtext2">
                                                <img src="images/icons-ribbon/icon-process.png" width="16" height="16" hspace="0"
                                                    align="absmiddle" /><a href="#" class="runtext2">Process</a>
                                            </td>
                                            <td align="left" class="runtext1">
                                                <img src="images/icons-ribbon/icon-parent-folder.png" width="16" height="16" hspace="0"
                                                    align="absmiddle" /><span class="runtext2"><a href="#" class="runtext2">Parent Folder</a></span></td>
                                        </tr>
                                        <tr>
                                            <td height="20" align="left" class="runtext1">
                                                <img src="images/icons-ribbon/icon-parentworkflow.png" width="16" height="16" hspace="0"
                                                    align="absmiddle" /><span class="runtext2"><a href="#" class="runtext2">Parent Workflows</a></span></td>
                                            <td align="left" class="runtext1">
                                                <img src="images/icons-ribbon/icon-queue.png" width="16" height="16" hspace="0" align="absmiddle" /><span
                                                    class="runtext2"><a href="#" class="runtext2">Queue(s)</a></span></td>
                                        </tr>
                                        <tr>
                                            <td height="20" align="left" class="runtext1">
                                                <img src="images/icons-ribbon/icon-childworkflow.png" width="16" height="16" hspace="0"
                                                    align="absmiddle" /><span class="runtext2"><a href="#" class="runtext2">Child Workflows</a></span></td>
                                            <td align="left" class="runtext1">
                                                <img src="images/icons-ribbon/arrow.png" width="16" height="16" hspace="0" align="absmiddle" /><span
                                                    class="runtext2"><a href="#" class="runtext2">Calendar</a></span></td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="4" align="right" valign="bottom" background="images/borders-ribbon/right.png">
                                    <img src="images/borders-ribbon/right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom" background="images/borders-ribbon/bottom-left-2.png">
                                    <img src="images/borders-ribbon/bottom-left-2.png" width="5" height="5" /></td>
                                <td height="16" align="center" valign="bottom" bgcolor="c1daf1" class="runtext1">
                                    Mappings</td>
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
                    </td> -->
                    <td>
                        <table width="120" height="86" border="0" cellpadding="0" cellspacing="0">
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
                                <td align="center" valign="middle" background="images/borders-ribbon/center-bg.png">
                                    <table width="100%" height="63" border="0" cellspacing="1" cellpadding="0">
                                        <tr>
                                            <td height="31" align="left" class="runtext1">
                                                <img src="images/icons-ribbon/icon-edit.png" width="16" height="16" hspace="0" align="absmiddle" /><span
                                                    class="runtext2"><a href="#" class="runtext2"> Edit</a></span>
                                            </td>
                                            <td align="left" class="runtext1">
                                                <img src="images/icons-ribbon/icon-expire.png" width="16" height="16" hspace="0"
                                                    align="absmiddle" /><span class="runtext2"><a href="#" class="runtext2"> Expire</a></span></td>
                                        </tr>
                                        <tr>
                                            <td height="31" align="left" class="runtext1">
                                                <img src="images/icons-ribbon/icon-publish.png" width="16" height="16" hspace="0"
                                                    align="absmiddle" /><span class="runtext2"><a href="#" class="runtext2">Publish</a></span></td>
                                            <td align="left" class="runtext1">
                                                <img src="images/icons-ribbon/icon-archive.png" width="16" height="16" hspace="0"
                                                    align="absmiddle" />
                                                <span class="runtext2"><a href="#" class="runtext2">Archive</a></span></td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="4" align="right" valign="bottom" background="images/borders-ribbon/right.png">
                                    <img src="images/borders-ribbon/right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom" background="images/borders-ribbon/bottom-left-2.png">
                                    <img src="images/borders-ribbon/bottom-left-2.png" width="5" height="5" /></td>
                                <td align="center" valign="bottom" bgcolor="c1daf1" class="runtext1">
                                    <table width="100%" border="0" cellpadding="0" cellspacing="0" height="16">
                                        <tr>
                                            <td align="center" valign="middle" class="runtext1">
                                                Actions</td>
                                            <td width="5" align="right" valign="middle">
                                                <a href="#" title="More Actions">
                                                    <img src="images/arrow-more.png" width="10" height="10" border="0" /></a></td>
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
            
                </tr>
            </table>
        </td>
        
    </tr>
    
</table>
