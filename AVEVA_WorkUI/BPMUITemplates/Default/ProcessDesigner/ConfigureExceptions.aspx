<%@ Page Language="C#" AutoEventWireup="true"  Inherits="Skelta.Repository.CodeBehind.Codebehind.Site.ConfigureExceptions" CodeFile="ConfigureExceptions.aspx.cs" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<link rel="stylesheet" type="text/css" href="<%=cssPath %>Common/StyleSheet/Global.css" />
<html style="height:100%">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%:ProcessDesignerControl.GlobalResourceSet.GetString("Exception Mail Settings")%></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>

<style type="text/css">
    html, body, form {
        height:100% !important;
    }
</style>
      

</head>
<script type ="text/javascript" >

    function onPageLoad()
    {
        if (document.getElementById("radAdminRole").checked == true)
        {
            DisplayAdminRolediv();
        }
        else
        {
            DisplayAdminUserdiv();
        }

        if (document.getElementById("radProcessRole").checked == true)
        {
            DisplayUserRoleDiv();
        }
        else
        {
            DisplayUserDiv();
        }
    }
    
    function OpenAdminTemplateform()
    {
        var tempurl = "<%=AdminUrl%>";
        var width = screen.width;
        var height = screen.availHeight;
        var left = (width - 675) / 2;
        var top = (height - 600) / 2;
        window.open(tempurl, 'WorkflowMemo', 'height=600,width= 820,resizable=no, top=' + top + ', left= ' + left);

    }

    function OpenUserTemplateform()
    {
        var tempurl = "<%=UserUrl%>";
        var width = screen.width;
        var height = screen.availHeight;
        var left = (width - 675) / 2;
        var top = (height - 600) / 2;
        window.open(tempurl, 'WorkflowMemo', 'height=600,width=820,resizable=no, top=' + top + ', left= ' + left);
    }
    
    function selectUsers(clientid, sclientid, type)
    {
        var hdnUser = sclientid;
        var userName = document.getElementById(hdnUser).value;

        userName = encodeURIComponent(userName);
        var oWindow = radopen("../Repository/Site/UserLookup.aspx?users=" + userName, null);

        var AppName = "<%:_ApplicationName %>";
        oWindow.set_modal(true);
        oWindow.set_title("Select Users");
        oWindow.setSize(590, 500);
        oWindow.setActive(true);
        oWindow.center();

        oWindow.add_beforeClose(onClientBeforeCloseUsers);

        function onClientBeforeCloseUsers(sender, args)
        {
            var returnValue = args.get_argument();

            if (returnValue !== null && returnValue !== undefined)
            {
                var oArea = document.getElementById(clientid);
                var names = '';
                var useridstring = '';

                if (returnValue.lastIndexOf("^") != -1)
                {
                    var usernamestring = returnValue.substring(0, returnValue.lastIndexOf("^"));
                    useridstring = returnValue.substring(returnValue.lastIndexOf("^") + 1);
                    names = ReplaceAll(usernamestring, "@!@", ", ");
                }

                oArea.value = names;
                var oArea1 = document.getElementById(hdnUser);
                oArea1.value = useridstring;
            }

            sender.remove_beforeClose(onClientBeforeCloseUsers);
        }
    }

    //
    // Replaces all the match strings with the replace string in the source string
    // and returns the result.
    //
    function ReplaceAll(Source, stringToFind, stringToReplace)
    {
        var temp = Source.split(stringToFind);

        return temp.join(stringToReplace);
    }

    function selectRoles(clientid, sclientid, type)
    {
        var hdnRole = sclientid;
        var roleName = document.getElementById(hdnRole).value;

        roleName = encodeURIComponent(roleName);

        var oWindow = radopen("../Repository/Site/RoleLookup.aspx?roles=" + roleName, null);

        oWindow.set_modal(true);
        oWindow.set_title("Select Roles");
        oWindow.setSize(610, 450);
        oWindow.setActive(true);
        oWindow.center();

        oWindow.add_beforeClose(onClientBeforeCloseRoles);

        function onClientBeforeCloseRoles(sender, args)
        {
            var returnValue = args.get_argument();

            if (returnValue !== null && returnValue !== undefined)
            {
                var oArea = document.getElementById(clientid);
                var id;
                var names = '';
                var dataArray = returnValue.split(',');

                if (returnValue)
                {
                    for (var i = 0; i < dataArray.length; i++)
                    {
                        // For Generic roles (Roles with Providers)
                        // If Generic Role, It will split with ::
                        // If it is 'Everyone-Skelta' it will not split
                        if (dataArray[i].indexOf('::') != -1)
                        {
                            id = dataArray[i].split('::');
                            names = names + id[1] + ',';
                        }
                        else
                            names = names + dataArray[i] + ',';
                    }
                }

                oArea.value = names.substring(0, names.lastIndexOf(","));
                var oArea1 = document.getElementById(hdnRole);
                oArea1.value = returnValue;
            }

            sender.remove_beforeClose(onClientBeforeCloseRoles);
        }
    }
    
    function DisplayAdminUserdiv()
    {
        var chkDivAdminUser=document.getElementById("divAdminuser");
        if(chkDivAdminUser !=null)
        {
            document.getElementById("divAdminuser").style.display="block";  
        }      
        
        var chkDivAdminRole=document.getElementById("divAdminrole");
        if(chkDivAdminRole !=null)
        {
            document.getElementById("divAdminrole").style.display="none";  
        } 
        
        document.getElementById("<%=radAdminRole.ClientID %>").checked=false; 
        
    }
    
    function DisplayAdminRolediv()
    {
        
        var chkDivAdminRole=document.getElementById("divAdminrole");
        if(chkDivAdminRole !=null)
        {
            document.getElementById("divAdminrole").style.display="block";  
        } 
        
        var chkDivAdminUser=document.getElementById("divAdminuser");
        if(chkDivAdminUser !=null)
        {
            document.getElementById("divAdminuser").style.display="none";  
        }
        
        document.getElementById("<%=radAdminUser.ClientID %>").checked=false; 
    
    }
    
    function DisplayUserDiv()
    {
        var chkDivProcessuser=document.getElementById("divProcessuser");
        if(chkDivProcessuser !=null)
        {
            document.getElementById("divProcessuser").style.display="block";  
        } 
        
         var chkDivProcessrole=document.getElementById("divProcessUserrole");
        if(chkDivProcessrole !=null)
        {
            document.getElementById("divProcessUserrole").style.display="none";  
        } 
        
        document.getElementById("<%:radProcessRole.ClientID %>").checked=false; 
        
    
    }
    
    function DisplayUserRoleDiv()
    {
        var chkDivProcessrole=document.getElementById("divProcessUserrole");
        if(chkDivProcessrole !=null)
        {
            document.getElementById("divProcessUserrole").style.display="block";  
        } 
        var chkDivProcessuser=document.getElementById("divProcessuser");
        if(chkDivProcessuser !=null)
        {
            document.getElementById("divProcessuser").style.display="none";  
        } 
        
        document.getElementById("<%:radProcessUser.ClientID %>").checked=false; 
    
    }
    
    function openhelpwin()
    {
        window.open('<%:helpUrl%>StartActivity1.html#Exception','helpwin','height = 450, width = 600,scrollbars=yes,resizable=yes');    
    }
    
</script>
<body onload="onPageLoad();" style="height:100%;overflow:hidden;">
    <script src="<%:bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=cssPath %>CommonUXControls/StyleSheet/se.ui.min.css" />  
       <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(cssPath)%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css" />
            <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(cssPath)%>TelerikAjax/StyleSheet/AWTWindow/Window.css" />
    <script>
        se.ui.messageDialog.setGlobalOptions({
            localization: { 
                closeButtonCaption: "<%:ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>", 
                okButtonCaption: "<%:ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
                cancelButtonCaption: "<%:ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                showDetailsCaption: "<%:ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>", 
                hideDetailsCaption: "<%:ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" 
            }
        });
    </script>
<form id="FExp"  runat="server" style="width:100%; height:100%">
    <%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
             </telerik:RadScriptManager>
<table width="100%" cellpadding="0" cellspacing="0" border="0" style="height:100%">
    <tr>
     <td valign="middle" class="ListHeaderCss" style="width:100%">
            <table cellspacing="0" cellpadding="0" border="0" width="100%">
                <tr>
                    <td valign="middle" height="25" style="padding-left: 10px" >
                        <span class="fontheading">
                            <%:ProcessDesignerControl.GlobalResourceSet.GetString("Exception Mail Settings")%>
                        </span>
                    </td>
                    <td valign="middle" style="padding-right:10px" height="25">
                       <span title="Help">
                        <img src="<%:ProcessDesignerControl.GetCommonRelativeUrl("Images/main-help.gif")%>"
                        align="right" onclick="javascript:openhelpwin()" style="cursor: pointer" alt="<%=helpText%>" /></span>
                    </td>                    
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td style="width:100%;">
                 <table width="100%" border="0" cellspacing="2" cellpadding="6" class="tablebg" style="height:100%">
                                        <tr>
                                            <td class="fontheading" colspan="3">
                                                <%:ProcessDesignerControl.GlobalResourceSet.GetString("ExcepMail_GroupA")%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lefttdbg" align="left" width="30%">
                                                <%--<span class="description"><%=ProcessDesignerControl.GlobalResourceSet.GetString("ExcepMail_processadmin")%></span>                                                                                                                        --%>
                                            </td>
                                            <td class="righttdbg">
                                                <input id="radAdminUser" type="radio" name="radAdminUser" value="AdminUser" runat="server" checked onclick="DisplayAdminUserdiv()" class="inputradio"/>
                                                <span class="description"><%:ProcessDesignerControl.GlobalResourceSet.GetString("ExcepMail_User")%></span>
                                                <input id="radAdminRole" type="radio" name="radAdminRole" value="AdminRole" runat="server" onclick="DisplayAdminRolediv()"/>
                                                <span class="description"><%:ProcessDesignerControl.GlobalResourceSet.GetString("ExcepMail_Role")%></span>
                                            </td>
                                            <td id="divAdminuser" class="righttdbg" style="vertical-align: middle">
                                                <asp:TextBox ID="txtAdminUserName" CssClass="inputtext" runat="server" onclick="this.blur()"
                                                    ></asp:TextBox>
                                                <input id="btnUserLookup" class="userlookup" title="<%:ProcessDesignerControl.GlobalResourceSet.GetString("ec_userlookup_title")%>" onclick="selectUsers('<%=txtAdminUserName.ClientID %>','<%=hdnUserName.ClientID%>','admin');"
                                                    type="button" value=".." name="SiteExplorer"  style="padding-top:5px;"/>
                                                <asp:HiddenField ID="hdnUserName" runat="server" />
                                            </td>

                                            <td id="divAdminrole" class="righttdbg" style="display: none; vertical-align: middle">
                                                <asp:TextBox ID="txtRoleName" CssClass="inputtext" runat="server" onclick="this.blur()"></asp:TextBox>
                                                <input id="Button1" class="rolelookup" title="<%:ProcessDesignerControl.GlobalResourceSet.GetString("ec_rolelookup_title")%>" onclick="selectRoles('<%=txtRoleName.ClientID %>','<%=hdnRoles.ClientID%>','admin');"
                                                    type="button" value=".." name="SiteExplorer" />
                                                <asp:HiddenField ID="hdnRoles" runat="server" />
                                            </td>

                                        </tr>
                                        <tr>
                                            <td class="lefttdbg" align="left">
                                                <%--<span class="description"><%=ProcessDesignerControl.GlobalResourceSet.GetString("ExcepMail_Processadmintemplate")%></span> --%>
                                            </td>
                                            <td class="righttdbg" colspan="3">
                                                <input id="rdAdminTemplate" type="radio" name="Template" value="CreateTemplate" runat="server" onclick="OpenAdminTemplateform()" class="inputradio"/>
                                                <a href="javascript:OpenAdminTemplateform()" class="textlinkblue"><%:ProcessDesignerControl.GlobalResourceSet.GetString("Create/Open")%></a>
                                                <br />
                                                <br />
                                                <input id="rdAdminTempDefault" name="Template" type="radio" class="inputradio" runat="server" value="DefaultTemplate"/>
                                                <span class="description"><%:ProcessDesignerControl.GlobalResourceSet.GetString("ExcepMail_TemplateFile")%></span>
                                                <%--<asp:TextBox ID="txtAdminTemplateFile" runat="server" CssClass="inputtext" Visible="true"  Width="175" ToolTip ="Specify your HTML Template filename here" EnableViewState ="true" ></asp:TextBox>--%>
                                                <img id="imgAdmin" alt="" runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/Images/erroricon.png%>" hspace="2" align="middle" visible="false" />

                                                <asp:DropDownList ID="ddlAdminTemplateFiles" runat="server" CssClass="inputselect"></asp:DropDownList>

                                                <br />
                                                <br />
                                                <span class="description"><%:ProcessDesignerControl.GlobalResourceSet.GetString("ExcepMail_SelectFile")%></span>
                                                <br />
                                                <span class="description"><%:ProcessDesignerControl.GlobalResourceSet.GetString("ExcepMail_FilePath")%></span>

                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" class="lefttdbg">
                                                <div style="border-bottom: 1px solid #ccc;width: 96%;padding-left:4%"></div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="fontheading" colspan="3">
                                                <%:ProcessDesignerControl.GlobalResourceSet.GetString("ExcepMail_GroupB")%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lefttdbg" align="left">
                                                <%--<span class="description"><%=ProcessDesignerControl.GlobalResourceSet.GetString("ExcepMail_processuser")%></span> --%>
                                                                                                                       
                                            </td>

                                            <td class="righttdbg">
                                                <input id="radProcessUser" type="radio" name="radProcessUser" value="ProcessUser" runat="server" checked onclick="DisplayUserDiv()" class="inputradio"/>
                                                <span class="description"><%:ProcessDesignerControl.GlobalResourceSet.GetString("ExcepMail_User")%></span>
                                                <input id="radProcessRole" type="radio" name="radProcessRole" value="ProcessRole" runat="server" onclick="DisplayUserRoleDiv()"/><span class="description"><%=ProcessDesignerControl.GlobalResourceSet.GetString("ExcepMail_Role")%></span>
                                            </td>
                                            <td id="divProcessuser" class="righttdbg">
                                                <asp:TextBox ID="txtProcessUserName" CssClass="inputtext" runat="server" onclick="this.blur()"
                                                    ></asp:TextBox>
                                                <input id="Button3" class="userlookup" title="<%:ProcessDesignerControl.GlobalResourceSet.GetString("ec_userlookup_title")%>" onclick="selectUsers('<%=txtProcessUserName.ClientID %>','<%=hdnProcessUser.ClientID%>','user');"
                                                    type="button" value=".." name="SiteExplorer"  style="padding-top:5px;"/>
                                                <asp:HiddenField ID="hdnProcessUser" runat="server" />
                                            </td>

                                            <td id="divProcessUserrole" class="righttdbg" style="display: none;">
                                                <asp:TextBox ID="txtProcessUserRoleName" CssClass="inputtext" runat="server" onclick="this.blur()"></asp:TextBox>
                                                <input id="btnProcessRole" class="rolelookup" title="<%:ProcessDesignerControl.GlobalResourceSet.GetString("ec_rolelookup_title")%>" onclick="selectRoles('<%=txtProcessUserRoleName.ClientID %>','<%=hdnProcessUserRoles.ClientID%>','user');"
                                                    type="button" value=".." name="SiteExplorer" />
                                                <asp:HiddenField ID="hdnProcessUserRoles" runat="server" />
                                            </td>

                                        </tr>
                                        <tr>
                                            <td class="lefttdbg" align="left">
                                                <%--<span class="description"><%=ProcessDesignerControl.GlobalResourceSet.GetString("ExcepMail_Processusertemplate")%></span> --%>
                                            </td>
                                            <td class="righttdbg" colspan="3">
                                                <input id="rdProcessTemplate" type="radio" name="UTemplate" value="UCreateTemplate" class="inputradio"
                                                    runat="server" onclick="OpenUserTemplateform()" />
                                                <a href="javascript:OpenUserTemplateform()" class="textlinkblue"><%:ProcessDesignerControl.GlobalResourceSet.GetString("Create/Open")%></a>
                                                <br />
                                                <br />
                                                <input id="rdProcessTempDefault" name="UTemplate" type="radio" runat="server" class="inputradio"
                                                    value="UDefaultTemplate" /><span class="description"><%:ProcessDesignerControl.GlobalResourceSet.GetString("ExcepMail_TemplateFile")%></span>
                                                <%--<asp:TextBox ID="txtUsersTemplateFile" runat="server" CssClass="inputtext"
                                                                    Width="175" ToolTip ="Specify your HTML Template filename here" EnableViewState ="true" Visible="true"  >
                                                                </asp:TextBox>--%>
                                                <img id="imgUser" alt="" runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/Images/erroricon.png%>"
                                                    hspace="2" align="middle" visible="false" />

                                                <asp:DropDownList ID="ddlUserTemplateFiles" runat="server" CssClass="inputselect"></asp:DropDownList>

                                                <br />
                                                <br />
                                                <span class="description" id="idUserText" align="right"><%:ProcessDesignerControl.GlobalResourceSet.GetString("ExcepMail_SelectFile")%></span>
                                                <br />
                                                <span class="description"><%:ProcessDesignerControl.GlobalResourceSet.GetString("ExcepMail_FilePath")%></span>
                                            </td>
                                        </tr>
                                    </table>
        </td>
    </tr>  
    <tr>
    <td style="padding-bottom: 10px; padding-top: 10px;">    
    <table width="100%" cellpadding="0" cellspacing="0" border="0" height="100%">                              
        <tr>
             <div style="border-bottom: 1px solid #ccc;width: 96%;padding-left:4%"></div>
             <td valign="top" colspan="2" style="padding-left:10px; height:10%;padding-top:10px;" >
                  <span class="description"><%:ProcessDesignerControl.GlobalResourceSet.GetString("TemplateDesc")%></span>  
             </td>
        </tr>
    </table>  
    </td>
    </tr>   
    <tr>
      <td style="vertical-align:top; padding-bottom: 10px">     
            <table width="100%" border="0" cellspacing="0" cellpadding="2" style="height:100%">
                <tr>
                    <td width="100%" align="right" style="padding-right:10px; height:10%">
                        <input type="button" name="btnClear" class="inputsecondarybutton" id="btnClear" runat="server"
                            tabindex="23"  value="Clear Saved Configuration" /> &nbsp;
                        <input type="button" name="Submit2" class="inputsecondarybutton" value="Close" tabindex="23"
                            id="btnCancel" runat="server"  onclick="window.close()"/> &nbsp;
                        <input type="button" name="Submit" class="inputbutton" value="OK" id="btnOk"
                            runat="server" onserverclick="btnOk_Click" tabindex="22" />
                        
                        <asp:HiddenField ID="idPopupValueAdmin" runat="server" />
                        <asp:HiddenField ID="idPopupValueUsers" runat="server" />
                        <asp:HiddenField ID="idAdmins" runat="server" />
                        <asp:HiddenField ID="idUsers" runat="server" />
                    </td>
                </tr>
            </table>

      </td>
      </tr>
</table>  

    <telerik:RadWindowManager ID="RadWindowManager1" EnableEmbeddedSkins="false" runat="server" 
        Behaviors="Resize,Move,Close,Maximize" RenderMode="Classic" VisibleStatusbar="false" Skin="AWTWindow">          
    </telerik:RadWindowManager>

</form>
</body>

</html>
