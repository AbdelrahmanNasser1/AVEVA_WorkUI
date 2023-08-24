<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.DeleteRights" %>
<link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(cssPath)%>/Global.css" rel="stylesheet" type="text/css" />

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <%--  <link href="styles/aquila.css" rel="stylesheet" type="text/css" />--%>
    <title><%=_ResManager.GlobalResourceSet.GetString("ec_rights_delete_title") %></title>

    <script type="text/javascript" language="javascript">
        function GetRadWindow()
        {
            var oWindow = null;
            if (window.radWindow)
                oWindow = window.radWindow;
            else if (window.frameElement.radWindow)
                oWindow = window.frameElement.radWindow;
            return oWindow;
        } 

        function closeWindow(isDeleted)
        { 
          if (isDeleted)
          {
              se.ui.messageDialog.showAlert('<%=_ResManager.GlobalResourceSet.GetString("ec_rights_delete_title") %>', '<%=_ResManager.GlobalResourceSet.GetString("ec_rights_del_msg") %>', closeHandlerFn);
          }
        }

        function closeHandlerFn() {
            var oWindow = GetRadWindow();            
            try {
                oWindow.BrowserWindow.window.document.getElementById('mainframe').contentWindow.document.getElementById("gridframe").contentWindow.RefreshGrid();
            }
            catch (e) {}
            oWindow.close();
            }
        
        function focusonno()
        {
            try
            {
                var userid = document.getElementById('NoButton');
                userid.focus();
            }
            catch(e)
            {}
        }
        
           // Making header & footer constant
        //AddEventHandler(window,'resize', resizefunction);
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
            try{bodydiv.style.height = parentdivheight - headerdiv.offsetHeight - footerdiv.offsetHeight ;}catch(e){}
            bodydiv.style.width =  '100px';
            bodydiv.style.width =  parentdiv.clientWidth;
            bodydiv.style.overflow =  'auto';
            parentdiv.style.overflow = 'hidden';
        }
    </script>

</head>
<body style="overflow:hidden" onload="focusonno();">
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemeURL) %>CommonUXControls/StyleSheet/se.ui.min.css" />      
    <script>
        // Initialize locales for message dialog
        se.ui.messageDialog.setGlobalOptions({
            localization: { // All localization related default can be set
                closeButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                okButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                cancelButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                showDetailsCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                hideDetailsCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
            }
        });
    </script>
    <div id="divparent">
        <form id="form1" runat="server">
            <%=System.Web.Helpers.AntiForgery.GetHtml()%>
            <div id="divheader">
            </div>
            <div id="divbody">
                            <table border="0" cellpadding="5" cellspacing="0" width="95%" align="center">
                    <tr height="60">
                        <td align="center" colspan="2">
                            <img src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemeURL)%>Repository/Site/images/security-right-delete.png"
                                align="absmiddle" />&nbsp;&nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="description">
                            <%=_ResManager.GlobalResourceSet.GetString("ec_rights_description") %>
                        </td>
                    </tr>
                </table>
                <table cellpadding="5px" cellspacing="0" border="0" align="center" width="100%">
                    <tr>
                        <td colspan="2" align="center" class="description">
                        <br />
                            <%=_ResManager.GlobalResourceSet.GetString("ec_rights_prompt") %> "<b><%=_RightName%></b>"?</td>
                    </tr>
                    <tr>
                        <td class="bodytext" align="center">
                            <input id="NoButton" runat="server" type="button" onclick="javascript:closeWindow(false);return false;"
                                class="inputbutton"/>
                            <asp:Button ID="YesButton" runat="server" CssClass="inputbutton" />

                        </td>
                    </tr>
                </table>

            </div>
            <div id="divfooter">
            </div>
        </form>
    </div>
  
</body>
</html>
