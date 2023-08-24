<%@ Control Language="C#" AutoEventWireup="true"    Inherits="Skelta.Repository.Web.CodeBehind.NavigationRibbonBar" %>
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
        document.frames("gridframe").ExecuteActionByName(command);
    }
</script>

<table width="100%" height="100" border="0" cellpadding="0" cellspacing="0">
    
    <tr>
       
        <td height="75" align="left" valign="top" background="images/borders/center-bg-inside.png">
            <table width="500" border="0" cellspacing="1" cellpadding="1">
                <tr>
                    
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
                                        </tr>
                                        <tr>
                                            <td height="25" align="left" class="runtext3">
                                                <img src="images/icons-ribbon/icon-workflow.png" width="16" height="16" hspace="2"
                                                    align="absmiddle" />
                                                <a href="javascript:ExecuteAction('_sys_new')" class="runtext3">Navigation
                                                    Link</a>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="4" align="right" valign="bottom" background="images/borders-ribbon/right.png">
                                    <img src="images/borders-ribbon/right.png" width="5" height="5" /></td>
                            </tr>
                            <tr>
                                <td valign="bottom" background="images/borders-ribbon/bottom-left-2.png" style="height: 16px">
                                    <img src="images/borders-ribbon/bottom-left-2.png" width="5" height="5" /></td>
                                <td align="center" valign="bottom" bgcolor="c1daf1" class="runtext1" style="height: 16px">
                                    New</td>
                                <td align="right" valign="bottom" background="images/borders-ribbon/bottom-right-2.png" style="height: 16px">
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
                                                    class="runtext2"> <a href="javascript:ExecuteAction('_sys_edit')" class="runtext2">Navigation
                                                    Link</a></span>
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
