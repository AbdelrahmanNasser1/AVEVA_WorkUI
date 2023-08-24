<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.Channel.RoleConfig"
    Theme="" StylesheetTheme="" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>


<html>
<head >
    <title>Untitled Page</title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
	<script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script> 

    <script language="javascript" type="text/javascript">
	
         se.ui.messageDialog.setGlobalOptions({
             localization: {
                 closeButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                okButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
                cancelButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                showDetailsCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                hideDetailsCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
            }
        });
		
        function DisplayMessage() {
            var header = '<%=Channel_PageHeader_AvailableRoles %>';
            var message = '<%=_ResManager.GlobalResourceSet.GetString("SilentInstallation_InvalidInputs") %>';
            se.ui.messageDialog.showError(header, message);
        }
				
		function addAllToParent(){
			if(selectedList.length >= 0) {
				var len = selectedList.length -1;
				window.parent.frames['frameCurrent'].ClearListBox('ListBoxRoles');
				for(i=len; i>=0; i--){
					window.parent.frames['frameCurrent'].AddListItem('ListBoxRoles', selectedList.item(i).text,selectedList.item(i).value );
				}
				window.parent.frames['frameCurrent'].SetRHSHeight();			
				window.parent.SelectTab(0);
			}
			return false;
			
		}

        function selectRoles(clientid)
        {
            var roleName = document.getElementById('hdnRoles').value;
            roleName = encodeURIComponent(roleName);
            var oWindow = radopen("../../Repository/Site/RoleLookup.aspx?roles=" + roleName, null);

            oWindow.set_modal(true);
            oWindow.set_title('Select Roles');
            oWindow.setSize(610, 470);
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
                    else
                    {
                        alert('<%=_ResManager.GlobalResourceSet.GetString("ec_vieweffectivesecurity_norole")%>');
                        args.set_cancel(true);
                        return;
                    }

                    oArea.value = names.substring(0, names.lastIndexOf(","));
                    var oArea1 = document.getElementById('hdnRoles');
                    oArea1.value = returnValue;
                }

                sender.remove_beforeClose(onClientBeforeCloseRoles);
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
		<telerik:RadScriptManager runat="server" ID="radScriptManager" />
		<link href="<%=cssPath%>Common/StyleSheet/Global.css" rel="stylesheet"    type="text/css">
<link href="<%=cssPath%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
		 <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(cssPath)%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css" />
            <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(cssPath)%>TelerikAjax/StyleSheet/AWTWindow/Window.css" />
		
        <table border="0" cellpadding="0" cellspacing="1" width="100%" height="94%">
              <tr width="100%" style="height: 5%;">
                <td colspan="2">&nbsp;
                </td>
            </tr>
            <tr width="100%" style="height: 90%; vertical-align:top">
			<td width="100%">
			
				<table id="TMain" width="94%" align="center" border="0" cellpadding="7" cellspacing="1" class="tablebg">
                    <tr>
                        <td class="lefttdbg" valign="top" style="width: 45%">
                            <span class="subtitle">
                                <%= _ResManager.GlobalResourceSet.GetString("Wiz_channel_select_rolelookup")%>
                            </span>
                        <br /><br />
                        <span class="description">
                            <%= _ResManager.GlobalResourceSet.GetString("Wiz_channel_select_role_desc")%>
                        </span>
                        <br />
                        </td>
                        <td class="righttdbg" style="width: 55%">
                            
                            <asp:TextBox ID="roleName" CssClass="inputtext" runat="server" onclick="this.blur()"
                            Width="200px"></asp:TextBox>
                            <input id="btnRoleExplorer" class="rolelookup" title="<%=_ResManager.GlobalResourceSet.GetString("ec_rolelookup_title")%>" onclick="selectRoles('<%=roleName.ClientID %>');"
                            type="button" value=".." name="roleExplorer" />
                            <asp:HiddenField ID="hdnRoles" runat="server" />
                        </td>
                    </tr>
                </table>								
			
			</td>
		</tr>
            <tr style="height:5%">
                <td align="right" colspan="3" style="padding-right: 10px" >                    
                    <asp:Button ID="btnrolesave" runat="server" Text="<%=Channel_ButtonCaption_Submit%>"  CssClass="inputbutton" />
                </td>
            </tr>
        </table>
        
        <telerik:RadWindowManager ID="Singleton" Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false"
		    runat="server" Behaviors="Close,Move,Maximize" VisibleStatusbar="false" >         
       </telerik:RadWindowManager>
    </form>
</body>
</html>

