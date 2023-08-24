<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.VersionListGrid" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!Doctype html >
<html>
<head runat="server">
 <style>
        html, body
        {
            height: 100%;
        }
    </style>
    <script type="text/javascript" src="../../CommonUXControls/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="../../CommonUXControls/scripts/jquery.easing.1.3.js"></script>  
    <script type="text/javascript" src="../../CommonUXControls/scripts/ActionBar/actionbar.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server" style="height:100%">
	<%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager ID="radScriptManager" runat="server"></telerik:RadScriptManager>
        <link rel="stylesheet" type="text/css" href="<%=themeDirectory%>CommonUXControls/StyleSheet/UXControls.css"> 
          <link rel="stylesheet" type="text/css" href="<%=themeDirectory%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
           <link rel="stylesheet" type="text/css" href="<%=themeDirectory%>TelerikAjax/StyleSheet/AWTWindow/Window.css">
       <div style="width: 100%; height: 100%;margin:0px;overflow:hidden;" id="ribbondiv">
                 <div id="divRibbonBar" style="overflow:hidden;">
                    <asp:Panel ID="Panel1" runat="server" Width="100%" Height="15%">
                    </asp:Panel>
                </div>
                <div id="divgridpage">
                    <iframe id="gridframe" src="<%=GetSecureUrl("VersionGrid.aspx")%>" visible=true
                     style="height:100%;width:100%;  padding-right: 0px;
                     padding-left: 0px; padding-bottom: 0px; margin: 0px; border-style:none;border-top-style: none;
                     padding-top: 0px; border-right-style: none; border-left-style: none; border-bottom-style: none;overflow:hidden;"></iframe>
                </div>
          </div>
    </form>
   
    <telerik:RadWindowManager ID="Singleton" Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false"
             runat="server" Behaviors="Close, Minimize, Maximize, Move" Overlay="false" RenderMode="Classic" VisibleStatusbar="false">  
            <Windows>
                    <telerik:RadWindow ID="WindowCloseBehaviour" runat="server" Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" RenderMode="Classic" VisibleStatusbar="false" Behaviors="Move" Title="Edit Workflow" Modal="true">
                    </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>

    <script  type="text/javascript">
        try
        {
            if (navigator.userAgent.toLowerCase().indexOf('msie') > 0)
                document.getElementById("divgridpage").style.height = document.getElementById("ribbondiv").scrollHeight - document.getElementById("divRibbonBar").scrollHeight - 35 + 'px';
            else
                document.getElementById("divgridpage").style.height = document.getElementById("ribbondiv").scrollHeight - document.getElementById("divRibbonBar").scrollHeight + 'px';
            document.getElementById("divRibbonBar").style.width = document.getElementById("<%=Panel1.ClientID%>").scrollWidth + 'px';
            document.getElementById("gridframe").style.width = document.getElementById("<%=Panel1.ClientID%>").scrollWidth  + 'px';
         }
        catch (e)
        {

        }
    </script>

</body>
</html>

