<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Forms.Web.CodeBehind.OrganizeList" Debug="false" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>


<%@ Register Assembly="Skelta.Forms.Web" Namespace="Skelta.Forms.Web" TagPrefix="cc1" %>
<%@ Register TagPrefix="uc" TagName="Tree" Src="OrganizeListTree.ascx" %>

<!DOCTYPE html >
<html>
<head id="Head1" runat="server">
    <title>Organize Forms List</title>
    <script type="text/javascript">
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

      function closeWindow() {

          try {
              var oWindow = GetRadWindow();
              if(oWindow !=null)
              {
                  oWindow.close();                 
              }
              else
              {
                  window.opener.location.reload(); 
                  window.close();
              }
          }
          catch (err) {
             
          }
      }
      
      function ResizeOrganizeTree()
      {                       
        var oWndHeight = GetWindowHeight();
        var oWndWidth = GetWindowWidth();
        var skeltaTree = document.getElementById("tree_SkeltaOrganizeTree");
        var treePanel = document.getElementById("Pnl1");
        
        if(oWndHeight != 0)
        {            
            var windowheight = parseInt(oWndHeight);
            if(!((isNaN(windowheight)) || (windowheight == 0)))
            {
                if(windowheight>175)
                {
                    if (treePanel != null)
                        treePanel.style.height=windowheight - 135;
                    if(skeltaTree!=null)
                    {
                        if(treePanel.style.height != "")
                            skeltaTree.style.height = treePanel.style.height;
                    }
                }
            }
         }
         
         if (oWndWidth != 0) {
             var windowwidth = parseInt(oWndWidth);
             if (!((isNaN(windowwidth)) || (windowwidth == 0))) 
             {
                if (treePanel != null)
                 treePanel.style.width = windowwidth - 30;
                 if(skeltaTree != null)
                 {
                     if (treePanel.style.width != "")
                         skeltaTree.style.width = treePanel.style.width;
                 }
             }
         }
         
      }
        
      function GetWindowHeight() 
      {
        var winHeight = 0;
        if( typeof( window.innerWidth ) == 'number' ) 
         {
           //Non-IE            
           winHeight = window.innerHeight;
         } else if( document.documentElement && ( document.documentElement.clientWidth || document.documentElement.clientHeight ) )
         {
           //IE 6+ in 'standards compliant mode'            
           winHeight = document.documentElement.clientHeight;
         } else if( document.body && ( document.body.clientWidth || document.body.clientHeight ) )
         {
           //IE 4 compatible            
           winHeight = document.body.clientHeight;
         }
        return winHeight;
      }

        function GetWindowWidth() 
        {
            var winWidth = 0;
            if (typeof (window.innerWidth) == 'number') {
                //Non-IE
                winWidth = window.innerWidth;
            } else if (document.documentElement && (document.documentElement.clientWidth || document.documentElement.clientHeight)) {
                //IE 6+ in 'standards compliant mode'
                winWidth = document.documentElement.clientWidth;
            } else if (document.body && (document.body.clientWidth || document.body.clientHeight)) {
                //IE 4 compatible
                winWidth = document.body.clientWidth;
            }
            return winWidth;
      }
   
    </script>
</head>
<body style="margin:0;padding-top:1px;padding-left:7px;padding-right:7px"  onload="ResizeOrganizeTree()" onresize="ResizeOrganizeTree()">
<link href="<%=ThemePath%>Common/StyleSheet/Global.css"  rel="stylesheet" type="text/css" />
     <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=ThemePath %>CommonUXControls/StyleSheet/se.ui.min.css" />      
    <link rel="stylesheet" type="text/css" href="<%=ThemePath %>TelerikAjax/StyleSheet/AWTTreeView/TreeView.AWTTreeView.css" /> 
    <script>
        // Initialize locales for message dialog
        se.ui.messageDialog.setGlobalOptions({
            localization: { // All localization related default can be set
                closeButtonCaption: "<%=skeltaResManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                okButtonCaption: "<%=skeltaResManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                cancelButtonCaption: "<%=skeltaResManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                showDetailsCaption: "<%=skeltaResManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                hideDetailsCaption: "<%=skeltaResManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
            }
        });
    </script>
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager ID="radscriptMgr" runat="server"></telerik:RadScriptManager>       
        <table  style="border-width:0px;width:100%;">        
            <tr>
                <td>

                    <table style="width:100%;margin:auto;border-width:0;border-spacing:0px">                    
                    <tr>
                        <td rowspan="2" style="vertical-align: middle;width:40px;text-align:center;">
                            <img alt="" src="<%=ThemePath%>Repository/Site/images/icon-organize-small.png" style="vertical-align:middle;" />
                        </td>
                        <td class="MainHeading"> <asp:Label ID="lblTitle" CssClass="MainHeading" runat="server" Text="Organizing Forms" /></td>
                        
                    </tr>
                        <tr>
                        <td>
                            <asp:Label ID="lblDesc" CssClass="description" runat="server" Text="" />
                        </td>
                    </tr>
                                      
                </table>
               
                </td>
            </tr>        
            
            <tr style="width:100%;">
                <td style="width:100%;">
                <table style="border-width:0px;width:100%;border-spacing:0px;" >
                    <tr>
                        <td  style="vertical-align:top;width:100%;padding:5px;text-align:left">                        
                            <asp:Panel ID="Pnl1" runat="server" Height="300px" BorderStyle="Solid" BorderWidth="1" BorderColor="LightGray" Width="370px">
                            <uc:Tree ID="tree" runat="server" />
                            </asp:Panel>                         
                        </td>
                    </tr>
                </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table style="width:100%;border-width:0px;vertical-align:bottom;">
                      <tr style="vertical-align:bottom;">
                            <td style="text-align:right; vertical-align:middle;">
                                <asp:Button ID="btnCancel" runat="server" Text="" OnClientClick="closeWindow();"   CssClass="inputbutton"/>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table></form></body>
</html>
