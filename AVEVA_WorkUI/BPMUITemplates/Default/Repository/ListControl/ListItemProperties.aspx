<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.ListItemProperties" Debug="true" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE HTML>
<html>
<head runat="server">
    <title><%if(FormsList){ %><%=resourceManager.GlobalResourceSet.GetString("form_properties")%>
    <%} %>
    <%else { %><%=resourceManager.GlobalResourceSet.GetString("wf_properties")%><%} %></title>
     <style>
        html, body
        {
            height:100%;
        }

    </style>
    <script type="text/javascript">
        

         function HideContextMenu(gridId, rowType, rowEl, rowMenu, location) {
             if (rowType != "Record") return true;

             if (rowType == "Record") {
                 // hiding grid's default context menu
                 for (i = 0; i <= 43; i++) {
                     rowMenu.Items[i].Hide();
                 }
             }
         }

        function Init()
        {
            var frameHeight = document.getElementById("versionFrame");
            try
            {
                frameHeight.style.height = document.body.clientHeight - 30 + 'px';                
                
            }
            catch (e) { }

            var childItemsframeHeight = document.getElementById("childItemsFrame");
            try {
                childItemsframeHeight.style.height = document.body.clientHeight - 30 + 'px';


            } catch (e) { }

        }
        AddEventHandler(window, 'load', Init);
        AddEventHandler(window, 'resize', Init);

        function AddEventHandler(elementObject, eventName, functionObject) {
            if (document.addEventListener)
                elementObject.addEventListener(eventName, functionObject, false);
            else
                if (document.attachEvent)
                    elementObject.attachEvent("on" + eventName, functionObject);
        }
       

    </script>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
</head>
    
<body style="margin: 0; overflow: hidden">
    <link rel="stylesheet" type="text/css" href="<%=cssPath%>TelerikAjax/StyleSheet/AWTTabStrip/TabStrip.AWTTabStrip.css">
    <form id="form1" runat="server" style="height:100%;">	
         <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
    <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
        <div style="height:100%;">
            <telerik:RadTabStrip ID="RadTabStrip1" runat="server" MultiPageID="RadMultiPage2" RenderMode="Classic" UnSelectChildren="True" Skin="AWTTabStrip" SelectedIndex="0" Width="100%" EnableEmbeddedSkins="false">
                <Tabs>
                    <telerik:RadTab ID="Tab1"  Text="Versions" Width="45%" Height="100%" PageViewID="VersionPage" runat="server">
                    </telerik:RadTab>
                    <telerik:RadTab ID="ChildWFS" runat="server" Text="Child Items" Width="45%" Height="100%" PageViewID="ChildItemsPage">
                    </telerik:RadTab>
                </Tabs>
            </telerik:RadTabStrip>
                <telerik:RadMultiPage ID="RadMultiPage2" runat="server"  SelectedIndex="0" Width="100%" Height="200" >
                    <telerik:RadPageView ID="VersionPage" runat="server" Width="100%">
                    <iframe width="100%"  frameborder="0" height="100%"  id="versionFrame" scrolling="auto" src="ListItemVersions.aspx?<%=QParams%>">
                    </iframe>
                    </telerik:RadPageView>
                  <telerik:RadPageView ID="ChildItemsPage" runat="server">
                    <iframe width="100%" frameborder="0" height="100%" id="childItemsFrame" scrolling="auto" src="ListItemChild.aspx?<%=QParams%>">
                    </iframe>
                    </telerik:RadPageView>
             </telerik:RadMultiPage>
        </div>
    </form>
</body>
</html>
