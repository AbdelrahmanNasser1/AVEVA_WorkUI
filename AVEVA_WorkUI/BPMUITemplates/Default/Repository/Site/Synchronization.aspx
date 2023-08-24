<%@ Page Language="C#" AutoEventWireup="true" Inherits="Synchronization" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<link href="<%=ThemeURL %>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
    

<html>
<head runat="server">
    <title><%=_ResManager.GlobalResourceSet.GetString("ec_sync_page_title") %></title>
</head>
    <script type="text/javascript" language="javascript">
        function OpenWindow(path)
        {
            var oBrowserWnd = GetRadWindow().BrowserWindow; 
            var oWin = oBrowserWnd.radopen(path, "RadWindow1");       
        }
        
        function GetRadWindow(){
            var oWindow = null;

            if (window.radWindow) 
                oWindow = window.radWindow;
            else if (window.frameElement.radWindow) 
                oWindow = window.frameElement.radWindow;

            return oWindow;
        }           

        function closeWindow(){
            resizefunction();
            var oWindow = GetRadWindow(); 
            se.ui.messageDialog.showAlert('<%=_ResManager.GlobalResourceSet.GetString("ec_sync_page_title") %>', '<%=_ResManager.GlobalResourceSet.GetString("ec_sg_edit_save") %>', function () { oWindow.close(); });
        }
        
        // Get radio button list value
        function GetRadioButtonValue()
        {
            var radio = document.getElementsByName('<%=rdoprompt.ClientID %>');
            for (var j = 0; j < radio.length; j++)
            {
                if (radio[j].checked)
                    return radio[j].value;
            }
        }

        
        function validate()
        {
            var btnText = GetRadioButtonValue();
            if(btnText == 'No')
            {
                closeWindow();
                return false;
            }
            return true;
        }
        
        function visibleNote()
        {
            if(navigator.userAgent.indexOf("MSIE")>-1)
            {
                document.getElementById('trNote').style.display='block';
                document.getElementById('trLists').style.display='block';
            }
            else
            {
                document.getElementById('trNote').style.display='table-row';
                document.getElementById('trLists').style.display='table-row'; 
            }
            document.getElementById('tableLists').style.height='100%';
        }
        
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
            parentdiv.style.height =  parentdivheight ;
            try{bodydiv.style.height = parentdivheight - headerdiv.offsetHeight - footerdiv.offsetHeight ;}catch(e){}
            bodydiv.style.width =  '100px';
            bodydiv.style.width =  parentdiv.clientWidth;
            bodydiv.style.overflow =  'auto';
            parentdiv.style.overflow = 'hidden';
        }
    </script>
<body style="overflow:hidden">
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=ThemeURL %>CommonUXControls/StyleSheet/se.ui.min.css" />      
    <link rel="stylesheet" type="text/css" href="<%=ThemeURL%>TelerikAjax/StyleSheet/AWTTreeView/TreeView.AWTTreeView.css" />
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
    <div id="divparent">
        <form id="form1" runat="server">
            <%=System.Web.Helpers.AntiForgery.GetHtml()%>
            <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
            <div id="divheader">
                <table border="0" cellpadding="6" cellspacing="0" width="100%">
                    <tr>
                        <td height="41" valign="middle">
                        <span class="pagetitle">&nbsp;
                        <img src="<%=ThemeURL%>Repository/Site/images/new-security-group.png" align="absmiddle" />&nbsp;&nbsp;
                            <%=_ResManager.GlobalResourceSet.GetString("ec_sync_title") %>
                            </span>
                            <br />&nbsp;
                            <span class="description"><%=_ResManager.GlobalResourceSet.GetString("ec_sync_desc") %><br />&nbsp;&nbsp;<%=_ResManager.GlobalResourceSet.GetString("ec_sync_desc2") %></span>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="divbody">
                <table id="tableLists" border="0" cellpadding="10" cellspacing="1" width="96%" align="center" class="tablebg">
                    <tr id="trLists" style="display: none">
                        <td style="width: 50%" class="lefttdbg" valign="middle">
                            <span class="subtitle">
                                <%=_ResManager.GlobalResourceSet.GetString("ec_menu_Lists")%>
                            </span>
                            <br />
                            <span class="description">
                                <%=_ResManager.GlobalResourceSet.GetString("ec_sync_desc3") %>
                            </span>
                        </td>
                        <td style="width: 50%; height:100%" class="lefttdbg">
                            <div style="overflow:auto; height: 100%">
                            <table border="0" cellpadding="0" cellspacing="0" style="height: 100%; width:100%">
                                <tr>
                                    <td style="width: 100%" class="lefttdbg" valign="middle">
                                    <span class="description">
                                        <telerik:RadTreeView ID="RadTreeView1" runat="server" EnableEmbeddedSkins="false" Skin="AWTTreeView">
                                        </telerik:RadTreeView>
                                        </span>
                                    </td>
                                </tr>
                            </table>
                            </div>
                        </td>
                    </tr>
                    <tr >
                        <td class="lefttdbg" colspan="2">
                        <span class="note">
                                <img src="<%=ThemeURL%>Common/Images/icon-tips.png" alt="" align="absmiddle" />
                                </span>
                        <span class="description">
                            <%=_LevelMessage %>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 50%" class="lefttdbg" valign="middle">
                        <span class="description">
                            <%=_ResManager.GlobalResourceSet.GetString("ec_sync_prompt") %>
                            </span>
                        </td>
                        <td style="width: 50%" class="lefttdbg" valign="middle">
                            <asp:RadioButtonList ID="rdoprompt" CssClass="inputradio" RepeatDirection="Horizontal" runat="server">
                                <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                <asp:ListItem Selected="true" Text="No" Value="No"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                        </tr>
                </table>
            </div>
            <div id="divfooter">
                <br />
                <table border="0" cellpadding="2" cellspacing="0" width="96%" align=center>
                    <tr id="trNote" style="display: none">
                        <td width="10px" valign="top">
                            <span class="note">
                                <img src="<%=ThemeURL%>Repository/Site/images/icon-warnings.png" alt="" align="absmiddle" />&nbsp;&nbsp;
                            </span>
                        </td>
                        <td>
                            <span class="note"><font>
                                <%= _RepositoryLevelNote%></font>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td class="bodytext" align="right" height="41" valign="middle" colspan="3">
                            <asp:Button ID="btnYes" CssClass="inputbutton" runat="server" Text="Submit" Visible="true"
                               OnClientClick="return validate();" OnClick="btnYes_Click" />                            
                        </td>
                    </tr>
                </table>
            </div>
        </form>
    </div>
</body>
</html>
