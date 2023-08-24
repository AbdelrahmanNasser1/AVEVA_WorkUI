<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Forms.Web.CodeBehind.CreateList.BPMUITemplates_Default_Repository_Site_DeleteDList" %>
<link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
<html>
<head runat="server">
    <title><%=PageTitle%></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>

    <script language="javascript" type="text/javascript">

function GetRadWindow()
{
   var oWindow = null;
  if (window.radWindow) 
	oWindow = window.radWindow;
  else if (window.frameElement.radWindow) 
	oWindow = window.frameElement.radWindow;
  return oWindow;
} 
//GetRadWindow().OnClientClose=refreshGrid;
function closeWindow() 
{
    var oWindow = GetRadWindow();
    window.parent.document.getElementById("mainframe").contentWindow.document.getElementById("gridframe").contentWindow.RefreshGrid();

    // Note: {Rupesh Kokal}
    // The below code is commented. The function of the below code is to close the window, which would execute 
    // the OnClientClose event in SkeltaCreateList.aspx page. But when the page is loaded fresh, and when we delete
    // an item, it does the call the OnClientClose event and refresh the grid. If we delete another item, and when 
    // the below line is called, it does not trigger the OnClientClose event, hence the refresh grid is not triggerred.
    // Hence we have commented the below line and explicitly refreshed the grid with the previous line of code.
    //////oWindow.Close();
}
function refreshGrid()
{
window.top.location.reload();
}

    </script>

</head>
<body>
     <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>CommonUXControls/StyleSheet/se.ui.min.css"  rel="stylesheet" type="text/css" /> 
     <script src="<%=JSPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <script>

        se.ui.messageDialog.setGlobalOptions({
            localization: {
                closeButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                okButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
                cancelButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                showDetailsCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                hideDetailsCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
            }
        });

    </script>
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <div class="validation-bg">
        <asp:Panel ID="DelPanel" runat="server">
        <table id="deleteMessageTable" cellpadding="15px" cellspacing="0" border="0" align="center">
                <tr>
                 <td align="center">
                        <asp:Label ID="DeleteMessage" runat="server" Text="" CssClass="successfulmsg"></asp:Label>
                    </td>
                </tr>
            </table>
             <table border="0" cellpadding="8" cellspacing="0" width="100%">
                <tr>
                <td align="center">
                        <asp:Button ID="btnDelete" runat="server" Text="" OnClientClick="javascript:closeWindow();return false;"
                            CssClass="inputbutton" Width="75px" /></td>
                </tr>
            </table>
            </asp:Panel>
            <%--<table width="100%" cellpadding="0" cellspacing="0" border="0" height="88%">
                <tr>
                    <td align="center">
                        <table border="0" width="100%" cellpadding="0" cellspacing="0">
                            <tr>
                                <td align="center">
                                    <img src="<%=IconName%>" align="absmiddle" />
                                    <span class="description">
                                        <%=OutPutMessage%></span>
                                
                                </td>
                            </tr>
                            <tr>
                                <td align="center" valign="middle">
                                    <input id="btnDelete" style="width:15%;" runat="server" type="button" value="OK" lang="javascript"
                                        onclick="return Button2_onclick()" class="inputbutton"/>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>--%>
        </div>
    </form>
</body>
</html>
