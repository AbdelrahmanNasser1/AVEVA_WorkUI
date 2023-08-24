<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.WorkItemList.ReassignWorkItem" Theme="" StylesheetTheme="" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE HTML>
<html>
<head >
    <title><%=_StrReassign%></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <style>
        html,body {height:100%;}
    </style>
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

   

    function GridRefresh()
    {
        var Openedfrom = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_strOpenfrom, false)%>";
        if (Openedfrom == "")
            window.opener.RefreshGrid();
        else
            window.opener.RefreshGridfromdetview();
    }

    function selectUsers(clientid)
    {
        var urlParam;
        urlParam = '?users=' + encodeURIComponent(document.getElementById('usrNameHidden').value) + '&singleselection=1';
        var oWindow = radopen("../Repository/Site/UserLookup.aspx" + urlParam, null);

        oWindow.set_modal(true);
        oWindow.set_title('Select User');
        oWindow.setSize(600, 500);

        var winLeft = (590 - 490) / 2;
        var winTop = (360 - 340) / 2;
        oWindow.moveTo(winLeft, winTop);

        oWindow.add_beforeClose(onClientBeforeCloseUserLookup);

        function onClientBeforeCloseUserLookup(sender, args)
        {
            var returnValue = args.get_argument();

            if (returnValue !== null && returnValue !== undefined)
            {
                var oArea = document.getElementById(clientid);
                var ids;
                var names = '';
                var useridstring = '';

                if (returnValue.indexOf("@!@") != -1)
                {
                    alert('<%= resourceManager.GlobalResourceSet.GetString("ec_change_owner_single_user")%>');
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

            sender.remove_beforeClose(onClientBeforeCloseUserLookup);
        }
    }

     function ClearUserLookupDataAfterReassign()
     {         
         document.getElementById("usrNameHidden").value = "";
         document.getElementById("usrName").value = "";
     }
     function ShowBellyBarErrorMessage(title,message)
     {         
         se.ui.messageDialog.showError(title, message);
     }
    
     function ShowBellyBarAlertMessage(title,message)
     {         
         se.ui.messageDialog.showAlert(title, message);
     }
</script>

<body style="overflow:hidden;" >
    <form id="form1" runat="server" style="height:100%;">
     <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
     <link rel="stylesheet" type="text/css" href="<%=commonCssPath+"common/StyleSheet/Global.css"%>" />
     <link rel="stylesheet" type="text/css" href="<%=commonCssPath+"CommonUXControls/StyleSheet/se.ui.min.css"%>" />
         <link rel="stylesheet" type="text/css" href="<%=commonCssPath+ "TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css"%>">
    <link rel="stylesheet" type="text/css" href="<%=commonCssPath+ "TelerikAjax/StyleSheet/AWTWindow/Window.css"%>">

    <table style="width:100%;height:100%;border-spacing:1px;border-collapse:separate;">
	<tr style="vertical-align:top;" class="ListHeaderCss">
		<td style="vertical-align:bottom;height:25px;">
			<table style="width:100%;border-collapse:collapse;border-spacing:0px;">
				<tr>
					<td class="fontheading" style="height:25px;"><img src="<%=commonCssPath%>Workitemlist/images/Reassign-workitems.png" align="absmiddle" /><%=_StrReassign%></td>
					<td valign="top" width="20"></td>
				</tr>
			</table>		
		</td>
	</tr>
	
	<tr style="vertical-align:top;">
		<td style="vertical-align:bottom;height:25px;">
			<table style="width:100%;border-spacing:0px;border-collapse:collapse;">
				<tr>
					<td class="description" style="height:25px;">&nbsp;&nbsp;&nbsp;&nbsp;<%=_StrReassignDesc%></td>
					<td style="vertical-align:top;width:20px" ></td>
				</tr>
			</table>		
		</td>
	</tr>
	<tr>
	<td style="vertical-align:bottom;height:25px;">
	    <table style="margin:0px auto;border-spacing:1px;border-collapse:separate;width:100%;" class="tablebg" >
		    <tr>									
			  <td class="lefttdbg" style="width:400px;height:35px;">
				<asp:Label ID="lblDisplayError" CssClass="errormsg" runat="server" Visible="false"></asp:Label>
			  </td>										
		   </tr>
        </table>
    </td>
	</tr>
		
	<tr>
	<td style="vertical-align:top;">
    <table id="TMain" style="width:96%;margin:0px auto;border-spacing:1px;border-collapse:separate;"   class="tablebg">
        <tr>
            <td class="lefttdbg"  style="width: 45%;vertical-align:top;">
                <span class="subtitle">
                    <%=resourceManager.GlobalResourceSet.GetString("Wiz_select_userlookup")%>
                    </span><br />
                    <span class="description">
                    <%= resourceManager.GlobalResourceSet.GetString("Wiz_Select_singleUser_desc")%>
                 </span>
                <br />
            </td>
            <td class="righttdbg" style="width: 55%;vertical-align:top;">
                
                <asp:TextBox ID="usrName" CssClass="inputtext" runat="server" onclick="this.blur()" Width="200px"></asp:TextBox>
                <input id="Button6" class="userlookup" onclick="selectUsers('<%=usrName.ClientID %>');"
                    type="button" title="<%=resourceManager.GlobalResourceSet.GetString("ec_userlookup_title")%>" value=".." name="SiteExplorer" style="padding-top:5px;" />
                <asp:HiddenField ID="usrNameHidden" EnableViewState="true" runat="server" />
            </td>
        </tr>
    </table>
   </td>
   </tr> 
	
       
    <tr>
	<td style="vertical-align:bottom;padding-bottom:10px;">
		<table style="margin:0px auto;border-spacing:1px;border-collapse:collapse;width:100%;"  class="tablebg">
            
			<tr>                
		        <td class="lefttdbg" style="text-align:right;padding-right:10px;width:100%;"> 			        
		        <asp:Button runat="server" ID="btnClose" CssClass="inputsecondarybutton" OnClientClick="GridRefresh()" Text="Close"  /> 
		        </td> 

                <td class="lefttdbg" style="text-align:right;padding-right:10px;width:100%;"> 	                
		            <asp:Button runat="server" ID="btnReassign" CssClass="inputbutton" OnClick="btnReassign_Click" Text="Reassign"  /> 		        
		        </td>		         
            </tr>
	   </table> 
	</td> 
	</tr> 
</table>      

        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="btnReassign">                    
                </telerik:AjaxSetting>                
            </AjaxSettings>

        </telerik:RadAjaxManager>


        <telerik:RadWindowManager ID="RadWindowManager1" Modal="true" Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false"
         runat="server" Behaviors="Close, Move" RenderMode="Classic" VisibleStatusbar="false">
        </telerik:RadWindowManager>

    </form>   
</body>
</html>
