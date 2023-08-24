<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.ViewEffectiveSecurity" Title="Untitled Page" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
 

<!DOCTYPE HTML>
<html>
<head id="Head1" runat="server">
    <title></title>
    <style type="text/css">
        html,body{height:100%;}
    </style>
</head>

    <script type="text/javascript">
    function selectUsers(clientid)
    {
        var hdnUser = "<%=hdnUserName.ClientID %>";
        var userName = document.getElementById(hdnUser).value;
        userName = encodeURIComponent(userName);
        /* This was opening inside the frame. I have change it for Web Parts
        If it is at Repository level then there won't be any parent.parent.GetRadWindowManager()*/
        var oWindow;
        //window location is taken to support opening in the sharepoint context as the parent location was giving /BPMUISharePointTemplates
        var currentWinLocPath = window.location.pathname;
        var currentWinRelPath = currentWinLocPath.substring(0, currentWinLocPath.lastIndexOf('/'));
        if ("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_Level, false) %>" == "Repository")
        {
            var oWindow = radopen(currentWinRelPath + "/UserLookup.aspx?users=" + userName + "&singleselection=1", null);
            oWindow.set_modal(true);
            oWindow.set_title("Select Users");
            oWindow.setSize(630, 470);
            oWindow.setActive(true);
            oWindow.center();
        }
        else
        {
            var oManager = null;
            oManager = GetRadManager();

            oWindow = oManager.getWindowByName("ECWindow");
            var path = currentWinRelPath + "/UserLookup.aspx?users=" + userName + "&singleselection=1";
            oWindow.setUrl(path);
            oWindow.setSize(630, 470);
            oWindow.set_title("Select Users");
            oWindow.show();
            oWindow.setActive(true);
            oWindow.center();
        }

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
                        se.ui.messageDialog.showError('<%=resManager.GlobalResourceSet.GetString("ec_sg_view_title")%>', '<%=resManager.GlobalResourceSet.GetString("ec_viewEeffectiveSecurity_select_singleuser")%>');
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
                    se.ui.messageDialog.showError('<%=resManager.GlobalResourceSet.GetString("ec_sg_view_title")%>', '<%=resManager.GlobalResourceSet.GetString("ec_vieweffectivesecurity_nouser")%>');
                    args.set_cancel(true);
                    return;
                }

                oArea.value = names;
                var oArea1 = document.getElementById(hdnUser);
                oArea1.value = useridstring;
                document.getElementById('btnViewEffective').disabled = false;
                document.getElementById('btnViewEffective').focus();
            }

            sender.remove_beforeClose(onClientBeforeCloseUsers);
        }
    }

    function selectRoles(clientid)
    {
        var hdnRole = "<%=hdnRoles.ClientID %>";
        var roleName = document.getElementById(hdnRole).value;
        roleName = encodeURIComponent(roleName);
        /* This was opening inside the frame. I have change it for Web Parts
        If it is at Repository level then there won't be any parent.parent.GetRadWindowManager()*/
        var oWindow;
        //window location is taken to support opening in the sharepoint context as the parent location was giving /BPMUISharePointTemplates
        var currentWinLocPath = window.location.pathname;
        var currentWinRelPath = currentWinLocPath.substring(0, currentWinLocPath.lastIndexOf('/'));        
        if ("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_Level, false) %>" == "Repository")
        {
            oWindow = radopen(currentWinRelPath + "/RoleLookup.aspx?roles=" + roleName + "&singleselection=1", null);            
            oWindow.set_modal(true);
            oWindow.set_title("Select Roles");
            oWindow.setSize(630, 460);
            oWindow.setActive(true);
            oWindow.center();
        }
        else
        {
            var oManager = GetRadManager();
            oWindow = oManager.getWindowByName("ECWindow");
            var path = currentWinRelPath + "/RoleLookup.aspx?roles=" + roleName + "&singleselection=1";
            oWindow.setUrl(path);
            oWindow.setSize(630, 460);
            oWindow.set_title("Select Roles");
            oWindow.show();
            oWindow.setActive(true);
            oWindow.center();
        }

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
                        se.ui.messageDialog.showError('<%=resManager.GlobalResourceSet.GetString("ec_sg_view_title")%>', '<%=resManager.GlobalResourceSet.GetString("ec_viewEeffectiveSecurity_select_singlerole")%>');
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
                    se.ui.messageDialog.showError('<%=resManager.GlobalResourceSet.GetString("ec_sg_view_title")%>', '<%=resManager.GlobalResourceSet.GetString("ec_vieweffectivesecurity_norole")%>');
                    args.set_cancel(true);
                    return;
                }

                oArea.value = names.substring(0, names.lastIndexOf(","));
                var oArea1 = document.getElementById(hdnRole);
                oArea1.value = returnValue;
                document.getElementById('btnView').disabled = false;
                document.getElementById('btnView').focus();
            }

            sender.remove_beforeClose(onClientBeforeCloseRoles);
        }
    }
        
    function GetRadWindow()
    {
        var oWindow = null;

        if (window.radWindow) 
            oWindow = window.radWindow;
        else if (window.frameElement.radWindow) 
            oWindow = window.frameElement.radWindow;
        	
        return oWindow;
    }        
      
    function GetRadManager()
    {
        var oManager = null;
        try
        {
            oManager = parent.parent.parent.GetRadWindowManagerForListControl();
        }
        catch(e)
        {
        }

        if(oManager == null)
        {
            try
            {
                oManager = parent.parent.GetRadWindowManagerForListControl();
            }
            catch(e)
            {
            }

            if(oManager == null)
            {
                try
                {
                    oManager = parent.GetRadWindowManagerForListControl();
                }
                catch(e)
                {
                }
            }

            if(oManager == null)
            {
                oManager = window.GetRadWindowManagerForListControl();
            }
        }   
        
        return oManager;
    }

    function OpenWindow(path)
    {
        var themePath = '<%=ThemeURL%>';
        if (themePath.indexOf('layouts') > -1) {

            if ("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_Level, false) %>" == "Repository") {
                document.getElementById('ifViewDetails').src=path;
            }
            else{
                var oManager = null;
           
                oManager = GetRadManager();
            
                if(oManager != null)
                {
                    oWindow = oManager.getWindowByName("RadWindow1");
                    if(oWindow == null)
                    {
                        oWindow = oManager.getWindowByName("ECWindow");
                    }
            
                    oWindow.set_modal(true);
                    oWindow.setUrl(path);
                    oWindow.setSize(800, 470);
                    oWindow.set_title("Select Users");
                    oWindow.show();
                }  
            }
        }
        else
        {
            document.getElementById('ifViewDetails').src=path;
        }
    }
    
    function PreviouPgaeCall() {
        if ("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_Level, false) %>" == "Repository") {
            parent.document.location.href = "RepositorySettings.aspx";
            var refPage = document.referrer;
            if (refPage.indexOf("FromArchestrA") != -1) {
                parent.document.location.href = "RepositorySettings.aspx?FromArchestrA=true";
            }
        }

        else if ("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_Level, false) %>" == "List")
            document.location.href = "ListSettings.aspx?lcsuri=<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_PageParams, false) %>";

        else
            document.location.href = "ListItemSettings.aspx?lcsuri=<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_PageParams, false) %>";
    }
       
    function SetIframSize(level)
    {
        var hight;
        /*
        if ("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_Level, false) %>" == "Repository")
            hight = screen.availHeight - 206;
        else
            hight = screen.availHeight - 243;
        document.getElementById('ifViewDetails').style.height = hight;
        */
        var windowHeight = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : document.body.clientHeight;
        if ("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_Level, false) %>" == "Repository")
            hight = windowHeight - 190;
        else
            hight = windowHeight - 190;

        //alert(document.body.clientHeight);
        //alert(hight);
        document.getElementById('ifViewDetails').style.height = hight;
    }
    
    // Making header & footer constant
    AddEventHandler(window,'resize', resizefunction);
    AddEventHandler(window,'load', resizefunction);
       
    function AddEventHandler(elementObject, eventName, functionObject)
    {
        if(document.addEventListener)
            elementObject.addEventListener(eventName, functionObject, false);
        else
            if(document.attachEvent)
                elementObject.attachEvent("on" + eventName, functionObject);
    }
     
    function resize()
    {   
        var bodydiv = document.getElementById('divbody');
        var headerdiv = document.getElementById('divheader');
        var footerdiv = document.getElementById('divfooter');
        var parentdiv = document.getElementById('divparent');
        if (parentdiv.offsetParent==document.body)
            document.body.style.height = '100%';

        var parentdivheight = parentdiv.offsetParent.offsetHeight;
        parentdiv.style.height =  parentdivheight ;
        try{
            bodydiv.style.height = parentdivheight - headerdiv.offsetHeight-5 +'px';
        }
        catch(e){}
        //bodydiv.style.width =  '100px';
        //bodydiv.style.width =  parentdiv.clientWidth;
        
        bodydiv.style.overflow =  'auto';
        parentdiv.style.overflow = 'hidden';
    }

    function resizefunction()
    {
        resize();
        SetIframSize();
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
    </script>


<body id="Body" style="overflow:hidden;">
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=ThemeURL %>CommonUXControls/StyleSheet/se.ui.min.css" />
    <link rel="stylesheet" type="text/css" href="<%=ThemeURL%>TelerikAjax/StyleSheet/AWTTabStrip/TabStrip.AWTTabStrip.css">
<link rel="stylesheet" type="text/css" href="<%=ThemeURL%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
<link rel="stylesheet" type="text/css" href="<%=ThemeURL%>TelerikAjax/StyleSheet/AWTWindow/Window.css">
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
    <div id="divparent" style="overflow: hidden; height: 100%;">
        <form id="form1" runat="server" style="height:100%;">
            <link href="<%=cssPath%>/Global.css" rel="stylesheet" type="text/css" />
            <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
            <%=System.Web.Helpers.AntiForgery.GetHtml()%>
                        <div style="text-align:left;padding:5px;">
                            <input id="btnback"  runat="server" src="<%$ ReplaceTemplateExpn:HWS/Images/Back-Previous.png%>" type="image" onclick="PreviouPgaeCall();return false;" />
                </div>
            <div id="divheader">

                <telerik:RadTabStrip ID="ResourceMappingTabStrip" EnableEmbeddedSkins="false" SelectedIndex="0" MultiPageID="ResourceMapping" runat="server" Width="100%" Skin="AWTTabStrip" RenderMode="Classic" Orientation="HorizontalBottom" EnableViewState="false" CausesValidation="false">
                        <Tabs>
                            <telerik:RadTab  Text="" PageViewID="RoleMappingPage">
                            </telerik:RadTab>
                            <telerik:RadTab   Text="" PageViewID="UserMappingPage">
                            </telerik:RadTab>
                        </Tabs>
                </telerik:RadTabStrip> 

                
                <telerik:RadMultiPage ID="ResourceMapping" runat="server" SelectedIndex="0">
                    <telerik:RadPageView ID="RoleMappingPage" runat="server">
                        <table id="THeader" style="margin:0px auto;width:99%;">
                            <tr style="height:40px;width:90%;">
                                <td colspan="2" style="padding:5px;">
                                    <img src="<%=ThemeURL%>Repository/Site/images/effective-security-role.png"
                                    align="absmiddle" />&nbsp;
                                    <span  class="" style="font-family:Segoe UI;font-size: 14px;">
                                        <%= _ResManager.GlobalResourceSet.GetString("ec_reposettings_vieweffectivesecurity_role")%>
                                    </span>
                                    <br />
                                    <span class="description" style="margin-left:45px;">                                        
                                        <%= _ResManager.GlobalResourceSet.GetString("ec_reposettings_vieweffectivesecurity_role_desc")%>
                                    </span>
                                </td>
                                <td style="padding:5px;">
                                </td>
                            </tr>
                        </table>
                        <table id="TUser" style="width:99%;margin:0px auto;border-spacing:1px;border-collapse:separate;" class="tablebg">
                            <tr>
                                <td class="lefttdbg" style="width:50%;vertical-align:top;padding:7px;">
                                    <span class="subtitle">
                                        <%=_ResManager.GlobalResourceSet.GetString("ec_select_role")%>
                                    </span>
                                    <%--<br />--%>
                                    <span class="description">
                                    <%= _ResManager.GlobalResourceSet.GetString("ec_view_eff_security_role_description")%>
                                    </span>
                                </td>
                                <td class="righttdbg" style="width:50%;padding:10px;">                                    
                                    <asp:TextBox ID="txtRoleName" CssClass="inputtext" runat="server" onclick="this.blur()"
                                        Width="250px"></asp:TextBox>
                                        <input id="Button1" class="rolelookup" title="<%=_ResManager.GlobalResourceSet.GetString("ec_rolelookup_title")%>" onclick="selectRoles('<%=txtRoleName.ClientID %>');"
                                        type="button" value=".." name="SiteExplorer" style="padding-top:5px;"  />
                                    <asp:HiddenField ID="hdnRoles" runat="server" />
                                    <asp:Button ID="btnView" Enabled="false" runat="server" CssClass="inputbutton" OnClick="btnView_Click" OnClientClick="javascript:ValidateRole()" />
                                </td>
                            </tr>
                        </table>
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="UserMappingPage" runat="server">
                        <table id="THeader1" style="margin:0px auto;width:99%">
                            <tr style="height:40px;width:90%;">
                                <td colspan="2" style="vertical-align:middle;padding:5px;">
                                <img src="<%=ThemeURL%>Repository/Site/images/effective-security-user.png"
                                align="absmiddle" />&nbsp;
                                <span  class=""style="font-family:Segoe UI;font-size: 14px;">
                                    <%= _ResManager.GlobalResourceSet.GetString("ec_reposettings_vieweffectivesecurity")%>
                                    </span>
                                    <br />
                                    <span class="description" style="margin-left:45px;">                                    
                                        <%= _ResManager.GlobalResourceSet.GetString("ec_reposettings_vieweffectivesecurity_role_desc")%>
                                    </span>
                                </td>
                            </tr>
                        </table>
                        <table id="Table2" style="width:99%;margin:0px auto;border-collapse:separate;border-spacing:1px;" class="tablebg">
                            <tr>
                                <td class="lefttdbg" style="width:50%;vertical-align:top;padding:7px;">
                                    <span class="subtitle">
                                        <%=_ResManager.GlobalResourceSet.GetString("ec_select_user")%>
                                    </span>
                                    <%--<br />--%>
                                    <span class="description">
                                    <%= _ResManager.GlobalResourceSet.GetString("ec_view_eff_security_user_description")%>
                                    </span>
                                </td>
                                <td class="righttdbg" style="width:50%;padding:10px;">                                    
                                    <asp:TextBox ID="txtUserName" CssClass="inputtext" runat="server" onclick="this.blur()"
                                        Width="250px"></asp:TextBox>
                                        <input id="btnUserLookup" class="userlookup" title="<%=_ResManager.GlobalResourceSet.GetString("ec_userlookup_title")%>" onclick="selectUsers('<%=txtUserName.ClientID %>');" type="button" value=".." name="SiteExplorer" style="padding-top:5px;"    />
                                    <asp:HiddenField ID="hdnUserName" runat="server" />
                                    <asp:Button ID="btnViewEffective" runat="server" Enabled="false" CssClass="inputbutton" OnClick="btnViewEffective_Click"
                                         OnClientClick="ValidateUser()" />
                                </td>
                            </tr>
                        </table>
                    </telerik:RadPageView>
                </telerik:RadMultiPage>
            </div>
            <div id="divbody" style="height:75%;width:100%; overflow:hidden;">
                <iframe id="ifViewDetails"  style="display: none;height:98%;width:100%;border:none;" scrolling="no"></iframe>
            </div>
            
            <div style="height: 100px; width: 50px; display: none;">
                <input type="button" id="SearchUser" value="Open Window" />

    <telerik:RadWindowManager ID="Singleton" Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false"
        runat="server" Behaviors="Close, Minimize, Maximize, Move" DestroyOnClose="true" Overlay="false" RenderMode="Classic" VisibleStatusbar="false">  
            <Windows>
                <telerik:RadWindow ID="RadWindow1" Height="300px" Width="555px" runat="server" Skin="AWTWindow" OpenerElementID="SearchUser" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" RenderMode="Classic" VisibleStatusbar="false" Behaviors="Close" NavigateUrl="UserLookup.aspx">
                </telerik:RadWindow>
            </Windows>
    </telerik:RadWindowManager>
            </div>
            <asp:HiddenField ID="hdnValidate" runat="server" Value="" />
            <asp:HiddenField ID="hdnSelectedTab" runat="server" Value="" />
        </form>
    </div>
    <script type="text/javascript">
        var themePath = '<%=ThemeURL%>';
        if(themePath != null && themePath.toLowerCase().indexOf('_layouts') > -1)
        {
            var viewEffective = document.getElementById('btnViewEffective');
            if(viewEffective != null)
            {
                document.getElementById('btnViewEffective').disabled = false;
            }
            var viewButton = document.getElementById('btnView');

            if(viewButton != null)
            {
                document.getElementById('btnView').disabled = false;
            }
        }

        function ValidateRole()
        {
            var role = "<%=txtRoleName.ClientID %>";
            var validate = "<%=hdnValidate.ClientID %>";
            var rolevalue = document.getElementById(role).value;
            var emptyitem = "<%=Guid.Empty.ToString() %>";
        
             if(rolevalue == "")
             {
                 se.ui.messageDialog.showError('<%=resManager.GlobalResourceSet.GetString("ec_sg_view_title")%>','<%=resManager.GlobalResourceSet.GetString("ec_viewEeffectiveSecurity_select_role")%>');
            document.getElementById(validate).value = false;
        }
        else if(rolevalue.indexOf(",") != -1)
        {
            se.ui.messageDialog.showError('<%=resManager.GlobalResourceSet.GetString("ec_sg_view_title")%>','<%=resManager.GlobalResourceSet.GetString("ec_viewEeffectiveSecurity_select_singlerole")%>');
                document.getElementById(validate).value = false;
            }
            else
                document.getElementById(validate).value = true;
    }
    
    function ValidateUser()
    {
        var user = "<%=txtUserName.ClientID %>";
        var validate = "<%=hdnValidate.ClientID %>";
        var uservalue = document.getElementById(user).value;
        var emptyitem = "<%=Guid.Empty.ToString() %>";
        
        if(uservalue == "")
        {
            se.ui.messageDialog.showError('<%=resManager.GlobalResourceSet.GetString("ec_sg_view_title")%>','<%=resManager.GlobalResourceSet.GetString("ec_viewEeffectiveSecurity_select_user")%>');
            document.getElementById(validate).value = false;
        }
        else if(uservalue.indexOf("@!@") != -1)
        {
            se.ui.messageDialog.showError('<%=resManager.GlobalResourceSet.GetString("ec_sg_view_title")%>','<%=resManager.GlobalResourceSet.GetString("ec_viewEeffectiveSecurity_select_singleuser")%>');
                document.getElementById(validate).value = false;
            }
            else
                document.getElementById(validate).value = true;
    }
        </script>
</body>
</html>