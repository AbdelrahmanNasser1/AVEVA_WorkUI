<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.EditSecurityGroupMapping" %>
 
<!DOCTYPE HTML>
<html>
<head runat="server">
    <title><%=_ResManager.GlobalResourceSet.GetString("ec_srm_edit_title") %></title>
    <style>
        html,body{height:100%;}

    </style>
    <script type="text/javascript">
        function GetRadWindow()
        {
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
        
        function validatepriority()
        {
            var priority = document.getElementById('txtpriority');
            if(priority == null)
                return true;
            if(priority == '')
            {
                se.ui.messageDialog.showError('<%= _ResManager.GlobalResourceSet.GetString("ec_srm_title")%>', '<%= _ResManager.GlobalResourceSet.GetString("ec_srm_priority_empty")%>');
                return false;
            }
            else if(priority == 0)
            {
                se.ui.messageDialog.showError('<%= _ResManager.GlobalResourceSet.GetString("ec_srm_title")%>', '<%= _ResManager.GlobalResourceSet.GetString("ec_srm_priority_zero")%>');
                return false;
            }
            return true;
        }
        
        function showErrorMessage(message)
        {
            resizefunction(); 
            se.ui.messageDialog.showError('<%= _ResManager.GlobalResourceSet.GetString("ec_srm_title")%>', message);
        }
        
        function showSaveMessage(msg)
        {
            se.ui.messageDialog.showAlert('<%= _ResManager.GlobalResourceSet.GetString("ec_srm_title")%>', msg, function () { closeWin(); });
        }
        
        function onlyNumbers(evt)
        {
            var len = document.getElementById('txtpriority').value.length;
            if(len > 3)
                return false;
	        var e = event || evt; // for trans-browser compatibility
	        var charCode = e.which || e.keyCode;

	        if (charCode > 31 && (charCode < 48 || charCode > 57))
		        return false;
        		
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
        function resizefunction()
        {   
            var bodydiv = document.getElementById('divbody');
            var headerdiv = document.getElementById('divheader');
            var footerdiv = document.getElementById('divfooter');
            var parentdiv = document.getElementById('divparent');
            if (parentdiv.offsetParent==document.body)
                document.body.style.height = '100%';

            var parentdivheight = parentdiv.offsetParent.offsetHeight;
            parentdiv.style.height =  parentdivheight ;
            try{bodydiv.style.height = parentdivheight - footerdiv.offsetHeight ;}catch(e){}
            //bodydiv.style.width =  '100px';
            //bodydiv.style.width =  parentdiv.clientWidth;
            bodydiv.style.overflow =  'auto';
            parentdiv.style.overflow = 'hidden';
        }
    </script>
</head>
<body style="overflow:hidden">
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemeURL) %>CommonUXControls/StyleSheet/se.ui.min.css" />      
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
    <form id="form1" runat="server" style="height:100%;">
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(cssPath)%>/Global.css" rel="stylesheet" type="text/css" />
        <div id="divheader">
<%--                <table id="THeader" border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr style="height: 40px">
            <td class="hdredit" colspan="2">
                
            </td>
        </tr>
    </table>--%>
        </div>
        <div id="divbody" style="height:90%;">
            <table style="width:98%;border-collapse:separate;border-spacing:1px;margin:0px auto;" >
                <tr>
                    <td class="pagetitle" style="height:22px;padding:5px;" >
                        <img src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemeURL)%>Repository/ListControl/images/icons-ribbon/new-resource-mapping.png" style="vertical-align:middle;" /> &nbsp;&nbsp;<%=_ResourceTitle%>
                    </td>
                </tr>
                <tr>
                    <td id="Td4" class="description" colspan="2" style="padding:5px;">
                        &nbsp;&nbsp;<%=_ResourceHelpText%>
                    </td>
                </tr>
            </table>
            <table style="width:98%;margin:0px auto;border-collapse:separate;border-spacing:1px;" class="tablebg">
                <tr>
                    <td class="lefttdbg" valign="top" style="width:45%;vertical-align:top;padding:5px;">
                        <span class="subtitle">
                            <%=_ResourceLable%>
                        </span>
                        <br />
                        <span class="description">
                        <%= _ResManager.GlobalResourceSet.GetString("ec_srm_edit_resource")%>
                        </span><br /><br />
                    </td>
                    <td class="righttdbg" style="width:50%;padding:5px;">
                        <asp:TextBox ID="txtResource" CssClass="inputtext" runat="server" onclick="this.blur()" Width="300px"></asp:TextBox>
                        <asp:HiddenField ID="hdnResource" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="lefttdbg" valign="top" style="width: 45%;vertical-align:top;padding:5px;">
                        <span class="subtitle">
                            <%= _ResManager.GlobalResourceSet.GetString("ec_srm_securitygroup")%>
                        </span>
                        <br />
                        <span class="description">
                            <%= _ResManager.GlobalResourceSet.GetString("ec_srm_securitygroup_desc")%>
                        </span><br /><br />
                    </td>
                    <td class="righttdbg" style="width: 50%;padding:5px;">
                        <asp:DropDownList ID="cboSecurityGroup" CssClass="inputselect" runat="server" EnableViewState="true">
                        </asp:DropDownList>
                        <br />
                    </td>
                </tr>
                <tr id="trPriority" runat="server">
                    <td class="lefttdbg" valign="top" style="width: 45%;vertical-align:top;padding:2px;">
                        <span class="subtitle">
                            <%= _ResManager.GlobalResourceSet.GetString("ec_srm_priority")%>
                        </span>
                        <br />
                        <span class="description">
                        <%= _ResManager.GlobalResourceSet.GetString("ec_srm_priority_edit_note")%>
                        </span><br /><br />
                    </td>
                    <td class="righttdbg" style="width: 50%;padding:5px;">
                        <input class="inputtext" id="txtpriority" onkeypress="return onlyNumbers();" type="text" value="100" style="width: 55px"
                            runat="server" /></td>
                </tr>
                <tr id="trProvider" runat="server">
                    <td class="lefttdbg" valign="top" style="width: 45%;vertical-align:top;padding:2px;">
                        <span class="subtitle">
                            <%= _ResManager.GlobalResourceSet.GetString("ec_srm_provider")%>
                        </span>
                        <br />
                        <span class="description">
                            <%= _ResourceProviderDescription%>
                        </span><br /><br />
                    </td>
                    <td class="righttdbg" style="width: 50%;padding:5px;">
                        <asp:TextBox ID="txtProvider" CssClass="inputtext" runat="server" onclick="this.blur()" Width="150px"></asp:TextBox>
                        <br />
                    </td>
                </tr>
            </table>
        </div>
            <div id="divfooter">
            <table style="width:100%;border-collapse:collapse;border-spacing:0px;" >
                <tr>
                    <td style="text-align:right;padding:10px;"  colspan="2">
                            &nbsp;
                            <asp:Button ID="btnSave" runat="server" CssClass="inputbutton"  OnClientClick="return validatepriority();" OnClick="btnSave_Click" />
                            <asp:HiddenField ID="hdnEnityType" runat="server" />
                            <asp:HiddenField ID="hdnEffectiveId" runat="server" />
                            <asp:HiddenField ID="hdnIsUser" runat="server" />
                            <asp:HiddenField ID="hdnListId" runat="server" />
                            <asp:HiddenField ID="hdnListItemId" runat="server" />
                    </td>
                </tr>
            </table>
        </div>
    </form>
    </div>
</body>
</html>
