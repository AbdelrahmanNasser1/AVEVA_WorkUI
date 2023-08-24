<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.ChangOwner" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html>
<html style="height:100%">
<head runat="server">
   <title><%= _ResManager.GlobalResourceSet.GetString("ec_change_owner_title")%></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link href="<%$ReplaceTemplateExpn:Common/StyleSheet/Global.css%>" rel="stylesheet" type="text/css" />
</head>
<script type="text/javascript">
        var localClientId = "";
        function selectUsers(clientid)
        {
            localClientId = clientid;
            var oWindow = radopen("UserLookup.aspx?users=" + encodeURIComponent(document.getElementById('usrNameHidden').value) + "&singleselection=1", null);

            oWindow.set_modal(true);
            oWindow.set_title('Select User');
            oWindow.setSize(590, 480);
            oWindow.setActive(true);
            oWindow.center();
            oWindow.add_beforeClose(onClientBeforeClose);
        }

        function onClientBeforeClose(sender, args)
        {
            var returnValue = args.get_argument();

            if (returnValue !== null && returnValue !== undefined)
            {
                var oArea = document.getElementById(localClientId);
                var names = '';
                var useridstring = '';

                if (returnValue.indexOf("@!@") != -1)
                {
                    se.ui.messageDialog.showError('<%=_ResManager.GlobalResourceSet.GetString("ec_change_owner_title")%>', '<%= _ResManager.GlobalResourceSet.GetString("ec_change_owner_single_user")%>');
                    args.set_cancel(true);
                    return;
                }

                if (returnValue.lastIndexOf("^") != -1)
                {
                    var usernamestring = returnValue.substring(0, returnValue.lastIndexOf("^"));
                    useridstring = returnValue.substring(returnValue.lastIndexOf("^") + 1);
                    names = usernamestring;
                }

                oArea.value = names;
                var oArea1 = document.getElementById('usrNameHidden');
                oArea1.value = useridstring;
            }

            sender.remove_beforeClose(onClientBeforeClose);
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

        function Validate()
        {
            if(document.getElementById('usrName').value=='')
            {
                se.ui.messageDialog.showError('<%=_ResManager.GlobalResourceSet.GetString("ec_change_owner_title")%>', '<%= _ResManager.GlobalResourceSet.GetString("ec_change_owner_a_user")%>');
                document.getElementById('usrNameHidden').value='';
                return false;
            }
            
        }

        function showSaveMessage(msg)
        {
            alert(msg);
            closeWin();
        }

        function closeWin()
        {
            try {
                var oWindow = GetRadWindow();
                oWindow.close();
            }
            catch (err) {
                if (window.opener.location.href.indexOf('VersionGrid.aspx', 0) != -1) {
                    if (window.opener.top.opener.location.href.indexOf('Association.aspx', 0) != -1) {
                        window.opener.RefreshGrid();
                        window.close();
                    }
                }
            }
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

        function resizefunction()
        {   
            var bodydiv = document.getElementById('divbody');
            var headerdiv = document.getElementById('divheader');
            var footerdiv = document.getElementById('divfooter');
            var parentdiv = document.getElementById('divparent');
            if (parentdiv.offsetParent==document.body)
                document.body.style.height = '100%';

            var parentdivheight = parentdiv.offsetParent.offsetHeight;
            try{bodydiv.style.height = parentdivheight - headerdiv.offsetHeight - footerdiv.offsetHeight ;}catch(e){}
            bodydiv.style.overflow =  'auto';
            parentdiv.style.overflow = 'hidden';
        }
</script>

<body style="overflow:hidden;height:100%">

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


    <div id="divparent" style="height:100%">
        <form id="form1" runat="server" style="height:100%">
             <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
            <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemeURL)%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
           <link rel="stylesheet" type="text/css" href="<%=ThemeURL%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
            <link rel="stylesheet" type="text/css" href="<%=ThemeURL%>TelerikAjax/StyleSheet/AWTWindow/Window.css">
            <div id="divheader">
                
                 <table style="width:100%;margin:auto;border-width:0;border-spacing:0px">                    
                    <tr>
                        <td rowspan="2" style="vertical-align: middle;width:40px;text-align:center;">
                            <img alt="" src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemeURL)%>Repository/Site/images/icon-change-owner.png" style="vertical-align:middle" />
                        </td>
                        <td class="MainHeading"> <%= _ResManager.GlobalResourceSet.GetString("ec_change_owner_info")%></td>
                        
                    </tr>

                    <tr>
                        <td id="Td2" class="description" style="padding-bottom:10px;">
                           <%= _ResManager.GlobalResourceSet.GetString("ec_change_owner_desc")%>
                        </td>
                    </tr>                    
                </table>


            </div>
            <div id="divbody" style="height:80%">
                <table id="TMain" style="width:98%;margin:auto;border-width:0;border-spacing:1px;"  class="tablebg">
                    <tr>
                        <td class="lefttdbg" style="width: 50%;padding:7px;vertical-align:top">
                        <span class="subtitle">
                                        <%=_ResManager.GlobalResourceSet.GetString("ec_select_user")%>
                                        </span><br />
                                        <span class="description">
                            <%= _ResManager.GlobalResourceSet.GetString("ec_change_owner_desc2")%>
                            </span>
                            <br />
                        </td>
                        <td class="righttdbg" style="width: 50%;padding-left:4px;">
                            
                            <asp:TextBox ID="usrName" CssClass="inputtext" runat="server" onclick="this.blur()" Width="200px"></asp:TextBox>
                            
                            <input id="Button6" class="userlookup" onclick="selectUsers('<%=usrName.ClientID %>');"
                                type="button" title="<%=_ResManager.GlobalResourceSet.GetString("ec_userlookup_title")%>" value=".." name="SiteExplorer" style="padding-top:5px;" />
                            <asp:HiddenField ID="usrNameHidden" EnableViewState="true" runat="server" />
                        </td>
                    </tr>
                </table>
            </div>
            <div id="divfooter">
                <table style="border-width:0;border-spacing:0;width:100%" >
                    <tr>
                        <td colspan="2"  style="padding-bottom:2px;text-align:right;padding-right:10px;">
                            <asp:Button ID="btnSaveUser" runat="server" CssClass="inputbutton" OnClientClick="Validate();"
                                 OnClick="btnSaveUser_Click" />
                        </td>
                    </tr>
                </table>
            </div>
            <div style="width: 50px; display: none">
                <input type="button" id="SearchUser" value="Open Window" />
                </div>

        <telerik:RadWindowManager ID="Singleton" Skin="AWTWindow" EnableEmbeddedSkins="false" 
         runat="server" Behaviors="Close"   RenderMode="Classic" VisibleStatusbar="false">  
           <Windows>
               <telerik:RadWindow ID="RadWindow1" Height="300px" Width="555px" runat="server" OpenerElementID="SearchUser" NavigateUrl="UserLookup.aspx" Left="" Title="User Lookup" Top="">
               </telerik:RadWindow>             
           </Windows>
         </telerik:RadWindowManager>            
        </form>
    </div>
</body>
</html>
