<%@ Page Language="C#" AutoEventWireup="true" Inherits="DissociateToWorkflow" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<html>
<head id="Head1" runat="server">
 <link href="<%$ ReplaceTemplateExpn:Common/StyleSheet/Global.css%>" rel="stylesheet"
        type="text/css" />
    <title>Dissociate</title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%$ ReplaceTemplateExpn:CommonUXControls/StyleSheet/se.ui.min.css%>" />      
   <link rel="stylesheet" type="text/css" href="<%$ ReplaceTemplateExpn:TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css%>" /> 
    <link rel="stylesheet" type="text/css" href="<%$ ReplaceTemplateExpn:TelerikAjax/StyleSheet/AWTWindow/Window.css%>" />
    <script>
      function GetRadWindow()
      {
        var oWindow = null;
        if (window.radWindow) oWindow = window.radWindow;
        else if(window.frameElement)
        { 
            if (window.frameElement.radWindow) 
                oWindow = window.frameElement.radWindow;
            else 
                window.location.reload();
        }
        return oWindow;
    }
    function CloseWindow()
    {
        var oWindow =GetRadWindow();
        oWindow.close();
    }

        function alertForAssociation(errorMsg)
        {
            se.ui.messageDialog.showAlert(document.title, errorMsg);
        }
    </script>
</head>
<body >
    <form id="form1" runat="server">
         <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server" />
        <telerik:RadWindowManager ID="RadWindowManager1" Skin="AWTWindow" EnableEmbeddedSkins="false" runat="server" Behaviors="Close" RenderMode="Classic"> 
            <Windows>
                <telerik:RadWindow  ID="lookup" runat="server" DestroyOnClose="true" ReloadOnShow="true">
                </telerik:RadWindow>
            </Windows>
       </telerik:RadWindowManager> 
  <div >
       <asp:Panel ID="ConfirmPanel" runat="server">
       <br /><br />
       <table cellpadding="5px" cellspacing="0" border="0" align="center" width="300">
       <tr>
       <td colspan="2" align="center" class="description"><%=DissociateText%></td>
       </tr>
       <tr>
       <td align="right"> 
           <asp:Button ID="btnNo" runat="server" Text="" OnClick="btnNo_Click" CssClass="inputsecondarybutton"/>
       </td>
       <td align="left"> 
           <asp:Button ID="btnYes" runat="server" Text="" OnClick="btnYes_Click" CssClass="inputbutton" />
       </td>
       </tr>
       </table>
       </asp:Panel>
    </div>
    </form>
</body>
</html>
