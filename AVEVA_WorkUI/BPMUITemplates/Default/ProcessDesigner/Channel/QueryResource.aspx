<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.Channel.QueryResource" Theme="" StylesheetTheme="" %>

<%@ Register Assembly="Workflow.NET.Web.Designer.NET2" Namespace="Workflow.NET.Web.Designer" TagPrefix="cc1" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>


<html>
<head>
    <title>Untitled Page</title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
	<script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script> 
    
</head>
<script type="text/javascript">
	
	se.ui.messageDialog.setGlobalOptions({
        localization: {
            closeButtonCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
            okButtonCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
            cancelButtonCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
            showDetailsCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
            hideDetailsCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
        }
    });
		
    function DisplayMessage() {
        var header = '<%=resourceManager.GlobalResourceSet.GetString("Channel_Label_Users") %>';
        var message = '<%=resourceManager.GlobalResourceSet.GetString("SilentInstallation_InvalidInputs") %>';
        se.ui.messageDialog.showError(header, message);
    }

    function AddItemsToParentListBox(){
        var o = window.parent.document.getElementById('ListBoxUsers');
    }
    function selectUsers(clientid)
    {
        var oWindow = radopen("../../Repository/Site/UserLookup.aspx?users=" + encodeURIComponent(document.getElementById('usrNameHidden').value), null);
        oWindow.set_modal(true);
        oWindow.set_title('Select User');
        oWindow.setSize(630, 470);
        oWindow.center();

        oWindow.add_beforeClose(onClientBeforeCloseUserLookup);

        function onClientBeforeCloseUserLookup(sender, args)
        {
            var returnValue = args.get_argument();

            if (returnValue !== null && returnValue !== undefined)
            {
                var oArea = document.getElementById(clientid.trim());
                var ids;
                var names = '';
                var useridstring = '';

                if (returnValue != ",")
                {
                    if (returnValue.lastIndexOf("^") != -1)
                    {
                        var usernamestring = returnValue.substring(0, returnValue.lastIndexOf("^"));
                        useridstring = returnValue.substring(returnValue.lastIndexOf("^") + 1);
                        names = ReplaceAll(usernamestring, "@!@", ", ");
                    }
                }

                oArea.value = names;
                var oArea1 = document.getElementById('usrNameHidden');
                oArea1.value = useridstring;
            }

            sender.remove_beforeClose(onClientBeforeCloseUserLookup);
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
		
</script>
<body>
    <form id="form1" runat="server">
        <telerik:RadCodeBlock runat="server" ID="RadCodeBlock3">
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager runat="server" ID="radScriptManager" />
        <link href="<%=cssPath%>" rel="stylesheet" type="text/css">
	    <link href="<%=cssPathForBellyBar%>" rel="stylesheet" />
            <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css" />
            <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>TelerikAjax/StyleSheet/AWTWindow/Window.css" />
        </telerik:RadCodeBlock>

        
        <table width="100%" border="0" cellpadding="0" cellspacing="1" style="height: 94%;">
             <tr width="100%" style="height: 5%;">
                <td colspan="2">&nbsp;
                </td>
            </tr>
            <tr width="100%" style="height:90%;vertical-align: top">
                <td width="100%">
                    <telerik:RadAjaxPanel ID="AjPanel" runat="server">
                        
				<table id="TMain" width="94%" align="center" border="0" cellpadding="7" cellspacing="1" class="tablebg">
                    <tr>
                        <telerik:RadCodeBlock runat="server" ID="RadCodeBlock1">
                        <td class="lefttdbg" valign="top" style="width: 45%">
                            <span class="subtitle">
                                <%=resourceManager.GlobalResourceSet.GetString("Wiz_channel_select_userlookup")%>
                                </span><br /><br />
                                <span class="description">
                                <%= resourceManager.GlobalResourceSet.GetString("Wiz_channel_select_user_desc")%>
                             </span>
                            <br />
                        </td>
                        </telerik:RadCodeBlock>
                        <telerik:RadCodeBlock runat="server" ID="RadCodeBlock2">
                        <td class="righttdbg" style="width: 55%">
                            
                            <asp:TextBox ID="usrName" CssClass="inputtext" runat="server" onclick="this.blur()" Width="200px"></asp:TextBox>
                            <input id="Button6" class="userlookup" onclick="selectUsers('<%=usrName.ClientID %>');"
                                type="button" title="<%=resourceManager.GlobalResourceSet.GetString("ec_userlookup_title")%>" value=".." name="SiteExplorer" />
                            <asp:HiddenField ID="usrNameHidden" EnableViewState="true" runat="server" />
                        </td>
                        </telerik:RadCodeBlock>
                    </tr>
                </table>	
                            
			</telerik:RadAjaxPanel>  
                </td>
            </tr>
            <tr width="100%" style="height:5%;">
                <td align="right" height="27px" style="padding-right: 10px" colspan="2">
                    <asp:Button ID="ButtonSave" CssClass="inputbutton" runat="server" />
                </td>
            </tr>
        </table>       

        <telerik:RadWindowManager ID="Singleton" Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false"
         runat="server" Behaviors="Close,Move,Maximize" VisibleStatusbar="false">
        </telerik:RadWindowManager>

    </form>
</body>
</html>
