<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.SecurityGroupMapping" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE HTML>
<html>
<head runat="server">    
    <title>
        <%= _ResManager.GlobalResourceSet.GetString("ec_srm_title")%>
    </title>
    <style>
        html,body{height:100%;}
    </style>
        
</head>

<script type="text/javascript" >

    function selectUsers(clientid)
    {
        var oWindow = radopen("UserLookup.aspx?users=" + encodeURIComponent(document.getElementById('usrNameHidden').value) + "&singleselection=1", null);

        oWindow.set_modal(true);
        oWindow.set_title('Select Users');
        oWindow.setSize(600, 480);
        oWindow.setActive(true);
        oWindow.center();

        oWindow.add_beforeClose(onClientBeforeCloseUsers);

        function onClientBeforeCloseUsers(sender, args)
        {
            var returnValue = args.get_argument();

            if (returnValue !== null && returnValue !== undefined)
            {
                var oArea = document.getElementById(clientid);
                var ids;
                var names = '';
                var useridstring = '';

                if (returnValue != ",")
                {

                    // Avoid selecting multiple roles
                    if (returnValue.indexOf("@!@") != -1)
                    {
                        se.ui.messageDialog.showError('<%=_ResManager.GlobalResourceSet.GetString("ec_srm_title")%>', '<%=_ResManager.GlobalResourceSet.GetString("ec_viewEeffectiveSecurity_select_singleuser")%>');
                        args.set_cancel(true);
                        return;
                    }

                    if (returnValue.lastIndexOf("^") != -1)
                    {
                        var usernamestring = returnValue.substring(0, returnValue.lastIndexOf("^"));
                        useridstring = returnValue.substring(returnValue.lastIndexOf("^") + 1);
                        names = usernamestring;
                    }
                }
                else
                {
                    se.ui.messageDialog.showError('<%=_ResManager.GlobalResourceSet.GetString("ec_srm_title")%>', '<%=_ResManager.GlobalResourceSet.GetString("ec_vieweffectivesecurity_nouser")%>');
                    args.set_cancel(true);
                    return;
                }

                oArea.value = names;
                var oArea1 = document.getElementById('usrNameHidden');
                oArea1.value = useridstring;
                document.getElementById("cboSecurityGroups").disabled = false;
            }

            sender.remove_beforeClose(onClientBeforeCloseUsers);
        }
    }

    function selectRoles(clientid)
    {
        var oWindow = radopen("RoleLookup.aspx?roles=" + encodeURIComponent(document.getElementById('hdnRoles').value) + "&singleselection=1", null);

        oWindow.set_modal(true);
        oWindow.set_title('Select Roles');
        oWindow.setSize(600, 450);
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
                    if (returnValue.indexOf(",") != -1)
                    {
                        se.ui.messageDialog.showError('<%=_ResManager.GlobalResourceSet.GetString("ec_srm_title")%>', '<%=_ResManager.GlobalResourceSet.GetString("ec_viewEeffectiveSecurity_select_singlerole")%>');
                        args.set_cancel(true);
                        return;
                    }
                    else
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
                }
                else
                {
                    se.ui.messageDialog.showError('<%=_ResManager.GlobalResourceSet.GetString("ec_srm_title")%>', '<%=_ResManager.GlobalResourceSet.GetString("ec_vieweffectivesecurity_norole")%>');
                    args.set_cancel(true);
                    return;
                }

                oArea.value = names.substring(0, names.lastIndexOf(","));
                var oArea1 = document.getElementById('hdnRoles');
                oArea1.value = returnValue;
                document.getElementById("cbolistnames").disabled = false;
            }

            sender.remove_beforeClose(onClientBeforeCloseRoles);
        }
    }

    function selectUserGroups(clientid)
    {
        var oWindow = radopen("RoleLookup.aspx?roles=" + encodeURIComponent(document.getElementById('hdnUserGroupName').value) + "&singleselection=1", null);

        oWindow.set_modal(true);
        oWindow.set_title('Select Roles');
        oWindow.setSize(600, 450);
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
                    if (returnValue.indexOf(",") != -1)
                    {
                        se.ui.messageDialog.showError('<%=_ResManager.GlobalResourceSet.GetString("ec_srm_title")%>', '<%=_ResManager.GlobalResourceSet.GetString("ec_viewEeffectiveSecurity_select_singlerole")%>');
                        args.set_cancel(true);
                        return;
                    }
                    else
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
                }
                else
                {
                    se.ui.messageDialog.showError('<%=_ResManager.GlobalResourceSet.GetString("ec_srm_title")%>', '<%=_ResManager.GlobalResourceSet.GetString("ec_vieweffectivesecurity_norole")%>');
                    args.set_cancel(true);
                    return;
                }

                oArea.value = names.substring(0, names.lastIndexOf(","));
                var oArea1 = document.getElementById('hdnUserGroupName');
                oArea1.value = returnValue;
                document.getElementById("cboUserGroupSecurity").disabled = false;
                document.getElementById("btnListUsers").disabled = false;
                try
                {
                    if (document.getElementById("<%=lstUsers.ClientID %>") != null)
                        document.getElementById("<%=lstUsers.ClientID %>").options.length = 0;
                }
                catch (e)
                {
                }
            }

            sender.remove_beforeClose(onClientBeforeCloseRoles);
        }
    }
        
    function showSaveMessage(msg)
    {
        se.ui.messageDialog.showAlert('<%=_ResManager.GlobalResourceSet.GetString("ec_srm_title")%>',msg,function(){closeWin();});
    }
    
    function showErrorMessage(message)
    {
        resizefunction(); 
        se.ui.messageDialog.showError('<%=_ResManager.GlobalResourceSet.GetString("ec_srm_title")%>',message);
    }    
        
    function GetRadWindow(){
        var oWindow = null;

    if (window.radWindow) 
        oWindow = window.radWindow;
    else if (window.frameElement.radWindow) 
        oWindow = window.frameElement.radWindow;

        return oWindow;
    }

    function closeWin() {
        var oWindow = GetRadWindow();
        try {
            //window.GetRadWindow().BrowserWindow.window.document.getElementById('mainframe').contentWindow.document.getElementById("mainframe").contentWindow.document.getElementById("gridframe").contentWindow.RefreshGrid();
            oWindow.BrowserWindow.window.document.getElementById('mainframe').contentWindow.document.getElementById("mainframe").contentWindow.document.getElementById("gridframe").contentWindow.RefreshGrid();
        }
        catch (e)
        { }
        oWindow.close();
        
    }

    function OpenSearchWindow()
    {
        var button = window.document.getElementById('SearchUser').click();
    }
    function OpenUserWindow()
    {
        var button = window.document.getElementById('ShowUserWindow').click();
    }
    // ajay modified to handle the changes like backspace and delete and left and right keys are not working in mozilla
    function onlyNumbers(e) {

        evt = e || window.event; // for trans-browser compatibility
        var charCode = evt.which || evt.keyCode;

        if (charCode > 31 && (charCode < 48 || charCode > 57)) {
            if (charCode == 37 || charCode == 39 || charCode == 46)
                return true;
            else
                return false;
        }
            
        var len = document.getElementById('txtpriority').value.length;
        if (len > 3) {
            if (charCode == 8 || charCode == 37 || charCode == 39 || charCode == 46) // in sequence : backspace,leftarrow,rightarrow,delete
                return true;
            else {
                return false;
            }
	    }
        return true;
    }
    
    // Making header & footer constant
    AddEventHandler(window,'resize', resizefunction);
    //AddEventHandler(window,'load', resizefunction);

    function AddEventHandler(elementObject, eventName, functionObject)
    {
        if(document.addEventListener)
            elementObject.addEventListener(eventName, functionObject, false);
        else
            if(document.attachEvent)
                elementObject.attachEvent("on" + eventName, functionObject);
    }
    
    function resizefunction() {
        try {
            var bodydiv = document.getElementById('divbody');
            //            var headerdiv = document.getElementById('divheader');
            var footerdiv = document.getElementById('divfooter');
            var parentdiv = document.getElementById('divparent');
            if (parentdiv.offsetParent == document.body)
                document.body.style.height = '100%';

            var parentdivheight = parentdiv.offsetParent.offsetHeight;
            parentdiv.style.height = parentdivheight;
            //var bodydivheight = bodydiv.style.height;
            try { bodydiv.style.height = parentdivheight - footerdiv.offsetHeight - 40; } catch (e) { }
           // bodydiv.style.width = '100px';
            bodydiv.style.width = parentdiv.clientWidth;
            bodydiv.style.overflow = 'auto';
            parentdiv.style.overflow = 'hidden';

            var bodydiv1 = document.getElementById('divbody1');
            var footerdiv1 = document.getElementById('divfooter1');
            //bodydivheight = bodydiv1.style.height;    
            try { bodydiv1.style.height = parentdivheight - footerdiv.offsetHeight - 40; } catch (e) { }
            bodydiv1.style.overflow = 'auto';
           // bodydiv1.style.width = '100px';
            bodydiv1.style.width = parentdiv.clientWidth;

            var bodydiv2 = document.getElementById('divbody2');
            
            //bodydivheight = bodydiv1.style.height;    
            try { bodydiv2.style.height = parentdivheight - footerdiv.offsetHeight - 40; } catch (e) { }
            bodydiv2.style.overflow = 'auto';
            // bodydiv1.style.width = '100px';
            bodydiv2.style.width = parentdiv.clientWidth;
        }
        catch (e) {
        }
    }

    function SetFocus()
    {
        try
        {
            document.body.focus();
        }
        catch(e)
        {

        }
    }


    function ShowProgressBar() {        
            document.getElementById('dvProgressBar').style.visibility = 'visible';
      }

    function HideProgressBar() {        
            document.getElementById('dvProgressBar').style.visibility = "hidden";
      }

</script>


<body style="overflow: hidden" onload="javascript:HideProgressBar()">
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=ThemeURL %>CommonUXControls/StyleSheet/se.ui.min.css" />      
    <script>
        se.ui.messageDialog.setGlobalOptions({
            localization: { 
                closeButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>", 
                okButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>", 
                cancelButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>", 
                showDetailsCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                hideDetailsCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" 
            }
        });
    </script>
    <form id="form1" runat="server" style="height:100%;">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager runat="server" ID="radScriptManager" />
        <link href="<%=ThemeURL%>Common/StyleSheet/Global.css" rel="stylesheet"  type="text/css" />
        <link rel="stylesheet" type="text/css" href="<%:ThemeURL%>TelerikAjax/StyleSheet/AWTTabStrip/TabStrip.AWTTabStrip.css">
        <link rel="stylesheet" type="text/css" href="<%:ThemeURL%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
            <link rel="stylesheet" type="text/css" href="<%:ThemeURL%>TelerikAjax/StyleSheet/AWTWindow/Window.css">

        <div id="divparent" style="overflow: hidden;height:100%;">
            <table style="width:100%;height:100%; border-collapse:collapse;border-spacing:0px;">
                <tr>
                    <td style="width:100%;height:100%;vertical-align:top;padding-top:10px;">


                        <telerik:RadTabStrip ID="ResourceMappingTabStrip" EnableEmbeddedSkins="false" SelectedIndex="0"  MultiPageID="ResourceMapping" runat="server" Width="100%"
                        Skin="AWTTabStrip" RenderMode="Classic" Orientation="HorizontalBottom" EnableViewState="false" CausesValidation="false">
                            <Tabs>
                            <telerik:RadTab  Text=""  PageViewID="RoleMappingPage">
                            </telerik:RadTab>
                            <telerik:RadTab  Text=""  PageViewID="UserMappingPage">
                            </telerik:RadTab>
                            <telerik:RadTab Text=""  PageViewID="UserGroupMappingPage">
                            </telerik:RadTab>
                            </Tabs>
                        </telerik:RadTabStrip>     
                                                
                        <telerik:RadMultiPage ID="ResourceMapping" Height="85%" runat="server" SelectedIndex="0" RenderMode="Classic">
                            <telerik:RadPageView ID="RoleMappingPage" Height="100%" runat="server">                                
                                <div id="divbody" >
                                    <table style="width:98%;border-collapse:separate;border-spacing:1px;margin:0px auto;"  >
                                        <tr>
                                            <td id="Td3" class="pagetitle" style="text-align:left;padding:7px;">                                                
                                                <%= _ResManager.GlobalResourceSet.GetString("ec_srm_role_title")%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td id="Td4" class="description" colspan="2" style="padding:7px;">
                                            
                                                <%= _ResManager.GlobalResourceSet.GetString("ec_srm_role_helptext")%>
                                            </td>
                                        </tr>
                                    </table>
                                    <table style="width:98%;margin:0px auto;border-collapse:separate;border-spacing:1px;"  class="tablebg">
                                        <tr>
                                            <td class="lefttdbg" style="width: 45%;vertical-align:top;padding:7px;">
                                                <span class="subtitle">
                                                    <%= _ResManager.GlobalResourceSet.GetString("ec_srm_iconrolelabel")%>
                                                </span>
                                                <br />
                                                <span class="description">
                                                <%= _ResManager.GlobalResourceSet.GetString("ec_srm_iconroledesc")%>
                                                </span>
                                                <br />
                                            </td>
                                            <td class="righttdbg" style="width: 50%;vertical-align:top;padding:7px;">
                                                
                                                <asp:TextBox ID="roleName" CssClass="inputtext" runat="server" onclick="this.blur()"
                                                    Width="200px"></asp:TextBox>
                                                    <input id="btnRoleExplorer" class="rolelookup" title="<%=_ResManager.GlobalResourceSet.GetString("ec_rolelookup_title")%>" onclick="selectRoles('<%=roleName.ClientID %>');"
                                                    type="button" value=".." name="roleExplorer" style="padding-top:5px;" />
                                                <asp:HiddenField ID="hdnRoles" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lefttdbg" style="vertical-align:middle;padding:7px;" >
                                                <span class="subtitle">
                                                    <%= _ResManager.GlobalResourceSet.GetString("ec_srm_securitygroup")%>
                                                </span>
                                                <br />
                                                <span class="description"><%= _ResManager.GlobalResourceSet.GetString("ec_srm_securitygroup_desc")%>
                                                        </span>
                                                
                                                <br />
                                            </td>
                                            <td class="righttdbg" style="padding:7px;">
                                                <asp:DropDownList CssClass="inputselect" ID="cbolistnames" runat="server" EnableViewState="true">
                                                </asp:DropDownList></td>
                                        </tr>
                                        <tr>
                                            <td class="lefttdbg" style="padding:7px;" >
                                                <span class="subtitle">
                                                    <%= _ResManager.GlobalResourceSet.GetString("ec_srm_priority")%>
                                                </span>
                                                <br />
                                                <span class="description">
                                                <%= _ResManager.GlobalResourceSet.GetString("ec_srm_priority_desc")%>
                                                </span>
                                                <br />
                                            </td>
                                            <td class="righttdbg" style="padding:7px;">
                                                <input class="inputtext" id="txtpriority" onkeypress="return onlyNumbers(event);" type="text"
                                                    value="100" style="width: 55px" runat="server" /></td>
                                        </tr>
                                        <tr>
                                            <td id="tdNote" class="lefttdbg" colspan="2" style="padding:7px;">
                                                <table border="0" cellpadding="5" cellspacing="0">
                                                    <tr>
                                                        <td style="width:10px; vertical-align:top;">
                                                            <span class="note">
                                                                <img src="<%=ThemeURL%>Repository/Site/images/icon-warnings.png" alt="plese note"
                                                                    style="vertical-align:middle;" /></span></td>
                                                        <td class="lefttdbg">
                                                            <span class="note">
                                                                <%= _ResManager.GlobalResourceSet.GetString("ec_srm_priority_note")%>
                                                            </span>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                    
                                </div>                                
                            </telerik:RadPageView>
                            <telerik:RadPageView ID="UserMappingPage" runat="server" RenderMode="Classic">
                                <div id="divbody1">
                                    <table style="width:98%;border-spacing:1px;border-collapse:separate;margin:0px auto;" >
                                        <tr>
                                            <td id="Td5" class="pagetitle" style="height:22px;padding:7px;">                                             
                                                <%= _ResManager.GlobalResourceSet.GetString("ec_srm_user_title")%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td id="Td6" class="description" colspan="2" style="padding:7px;">
                                            
                                                <%= _ResManager.GlobalResourceSet.GetString("ec_srm_user_helptext")%>
                                            </td>
                                        </tr>
                                    </table>
                                    <table style="width:98%;margin:0px auto;border-spacing:1px;border-collapse:separate;"  class="tablebg">
                                        <tr>
                                            <td class="lefttdbg" valign="top" style="width: 45%;padding:7px;">
                                                <span class="subtitle">
                                                    <%= _ResManager.GlobalResourceSet.GetString("ec_srm_iconuserlabel")%>
                                                </span>
                                                <br />
                                                <span class="description">
                                                    <%= _ResManager.GlobalResourceSet.GetString("ec_srm_iconuserdesc")%>
                                                </span>
                                                <br />
                                                <br />
                                            </td>
                                            <td class="righttdbg" style="width: 50%;padding:7px;">
                                                
                                                <asp:TextBox ID="usrName" CssClass="inputtext" runat="server" onclick="this.blur()"
                                                    Width="200px"></asp:TextBox>
                                                    <input id="Button6" class="userlookup" title="<%=_ResManager.GlobalResourceSet.GetString("ec_userlookup_title")%>" onclick="selectUsers('<%=usrName.ClientID %>');"
                                                    type="button" value=".." name="SiteExplorer" style="padding-top:5px;" />
                                                <asp:HiddenField ID="usrNameHidden" EnableViewState="true" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lefttdbg" style="vertical-align:middle;padding:7px;">
                                                <span class="subtitle">
                                                    <%= _ResManager.GlobalResourceSet.GetString("ec_srm_securitygroup")%>
                                                </span>
                                                <br />
                                                <span class="description">
                                                    <%= _ResManager.GlobalResourceSet.GetString("ec_srm_securitygroup_desc")%>
                                                </span>
                                                <br />
                                                <br />
                                            </td>
                                            <td class="righttdbg" style="width: 50%;padding:7px;">
                                                <asp:DropDownList ID="cboSecurityGroups" CssClass="inputselect" runat="server" EnableViewState="true">
                                                </asp:DropDownList>
                                                <br />
                                            </td>
                                        </tr>
                                        
                                    </table>
                                </div>
                            </telerik:RadPageView>

                            <telerik:RadPageView ID="UserGroupMappingPage" Height="100%" runat="server" RenderMode="Classic">
                                <telerik:RadAjaxPanel ID="mainPanel" runat="Server" Width="100%" Height="100%" >
                                 <div id="divbody2" style="overflow:auto;" >
                                     <telerik:RadCodeBlock runat="server" ID="RadCodeBlock1">
                                  <table style="width:98%;border-collapse:separate;border-spacing:1px;margin:0px auto;"  >
                                        <tr>
                                            <td id="tdUserGrouptitle" class="pagetitle" style="text-align:left;padding:7px;">                                               
                                                <%= _ResManager.GlobalResourceSet.GetString("ec_srm_usersgroupmapping_title")%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td id="tdUserGroupdesc" class="description" colspan="2" style="padding:7px;">
                                            
                                                <%= _ResManager.GlobalResourceSet.GetString("ec_srm_usersgroupmapping_helptext")%>
                                            </td>
                                        </tr>
                                    </table>
                                     <table style="width:98%;margin:0px auto;border-collapse:separate;border-spacing:1px;"  class="tablebg">
                                         
                                        <tr>
                                            
                                            <td class="lefttdbg" style="width: 45%;vertical-align:top;padding:7px;">
                                                <span class="subtitle">
                                                    <%= _ResManager.GlobalResourceSet.GetString("ec_srm_iconrolelabel")%>
                                                </span>
                                                <br />
                                                <span class="description">
                                                <%= _ResManager.GlobalResourceSet.GetString("ec_srm_iconroledesc")%>
                                                </span>
                                                <br />
                                            </td>
                                            
                                            <td class="righttdbg" style="width: 50%;vertical-align:top;padding:7px;">
                                                 
                                                <asp:TextBox ID="txtUserGroupName" CssClass="inputtext" runat="server" onclick="this.blur()"
                                                    Width="200px" ></asp:TextBox>
                                                    <input id="btnUserGroupExplorer" class="rolelookup" title="<%=_ResManager.GlobalResourceSet.GetString("ec_rolelookup_title")%>" onclick="selectUserGroups('<%=txtUserGroupName.ClientID %>');"
                                                        type="button" value=".." name="roleExplorer" style="padding-top: 5px;" />&nbsp;&nbsp;
                                                <asp:HiddenField ID="hdnUserGroupName" runat="server" />
                                               
                                                <asp:Button ID="btnListUsers" runat="server" CssClass="inputbutton" Text="List Users" OnClick="btnListUsers_Click"  OnClientClick="javascript:ShowProgressBar()" />&nbsp; 
                                                    
                                            </td>
                                        </tr>
                                         <tr>
                                             <td class="lefttdbg" style="width: 45%;vertical-align:top;padding:7px;">
                                                 <span class="subtitle">
                                                    <%= _ResManager.GlobalResourceSet.GetString("ec_srm_selectusersgrouplabel")%>
                                                </span>
                                                <br />
                                                <span class="description">
                                                <%= _ResManager.GlobalResourceSet.GetString("ec_srm_iconusergroupdesc")%>
                                                </span>
                                                <br />
                                                 </td>

                                             <td class="righttdbg" style="width: 50%;vertical-align:top;padding:7px;">
                                                <asp:ListBox runat="server" ID="lstUsers" Height="225px" Width="235px" CssClass="TextboxStyle"
                                                    SelectionMode="Multiple"></asp:ListBox>
                                                <div ID="dvProgressBar" style="left:60%;visibility: hidden;top:40%;position:absolute;" >
                                                <asp:Image ID="imgLoading" runat="server" ImageUrl="<%$ ReplaceTemplateExpn:SOA/images/download_line.gif%>"  />
                                             </div>
                                             </td>
                                              
                                         </tr>
                                         
                                        <tr>
                                            <td class="lefttdbg" style="vertical-align:middle;padding:7px;" >
                                                <span class="subtitle">
                                                    <%= _ResManager.GlobalResourceSet.GetString("ec_srm_securitygroup")%>
                                                </span>
                                                <br />
                                                <span class="description"><%= _ResManager.GlobalResourceSet.GetString("ec_srm_securitygroup_desc")%>
                                                        </span>
                                                
                                                <br />
                                            </td>
                                            <td class="righttdbg" style="padding:7px;">
                                                <asp:DropDownList CssClass="inputselect" ID="cboUserGroupSecurity" runat="server" EnableViewState="true">
                                                </asp:DropDownList></td>
                                        </tr>                                      
                                       
                                    </table>
                                         </telerik:RadCodeBlock>
                                 </div>
                                 </telerik:RadAjaxPanel>
                            </telerik:RadPageView>
                        </telerik:RadMultiPage>
                        <div id="divfooter">
                            <table style="width:100%;border-collapse:collapse;border-spacing:0px;">
                                <tr>
                                    <td style="text-align:right;padding-right:20px;padding-top:20px;" >
                                        <asp:Button ID="btnSaveUserRole" runat="server" CssClass="inputbutton" OnClick="btnSaveUserRole_Click" />&nbsp;                                        
                                    </td>
                                    
                                </tr>
                            </table>
                        </div>
                        
                        <div style="height:300px; width:50px; display: none">
                            <input type="button" id="SearchUser" value="Open Window" />
                            </div>                          

                        <telerik:RadWindowManager ID="Singleton" Skin="AWTWindow" EnableEmbeddedSkins="false" runat="server" Behaviors="Close" RenderMode="Classic" VisibleStatusbar="false">  
                        <Windows>
                            <telerik:RadWindow ID="RadWindow1" Height="300px" Width="555px" runat="server"  OpenerElementID="SearchUser" NavigateUrl="UserLookup.aspx" Left="" Title="User Lookup" Top="">
                            </telerik:RadWindow>             
                        </Windows>
                        </telerik:RadWindowManager> 
                        
                        <asp:HiddenField ID="mappedusrHidden" EnableViewState="true" runat="server" />
                        <asp:HiddenField ID="overwriteusrHidden" EnableViewState="true" runat="server" />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
