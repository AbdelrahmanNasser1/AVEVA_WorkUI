<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.AssociationHome" %>
<%@ Register Src="../ListControl/EventProviders.ascx" TagName="EventProviders" TagPrefix="uc1" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!Doctype html>
<html style="height:100%">
<head runat="server">
    <title>
        <%= _ResManager.GlobalResourceSet.GetString("ecm_view_assn_eventassociations")%>
    </title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    
</head>

<script  type="text/javascript">
    function ShowIframe(pagename) {
        document.getElementById('iframediv').style.display = "block";
        document.getElementById('iframe').src = pagename;
    }
    function ShowAssociationframe(pagename) {
        var lcsurl = '<%=lcsuri%>';
        if (lcsurl != null) {
            pagename = pagename + "?lcsuri=" + lcsurl;
        }
        document.getElementById('iframediv').style.display = "block";
        document.getElementById('iframe').src = pagename;
    }
</script>
<body style="height:100%;">
    <form id="from" runat="server" style="height:100%;overflow:hidden;">
	<%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <link href="<%=ThemeURL%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" type="text/css" href="<%=ThemeURL%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
     <link rel="stylesheet" type="text/css" href="<%=ThemeURL%>TelerikAjax/StyleSheet/AWTWindow/Window.css">
         <telerik:RadScriptManager runat="server" ID="RadScriptManager2" />
    <div style="width:100%;border-width:0px;height:100%;" id="Maingrid">
                <div class="divMain" id="Table1" style="width:100%; vertical-align: top;display:inline-block;height:79px;">  
                      <uc1:EventProviders ID="EventProviders1" runat="server"></uc1:EventProviders>                          
                <div class="divMenu" id="RibbonDiv" style="height: 79px; float: none;width:120px;display:inline-block">
                    <div class="divTopImage" style="width: 100%;height:50px;">
                            <a href="javascript:ShowAssociationframe('CurrentAssociations.aspx')">
                                <img src="<%=ThemeURL%>Repository/Site/images/icons-ribbon/view-all-Associations-icon.png"
                                title="<%= _ResManager.GlobalResourceSet.GetString("ecm_view_assn_viewallassociations")%>"
                                style="border:0px;" class="sectionitem" /></a>
                    </div>
                    <div class="sectiontitle divdowntext" style="height:29px;">
                          <%= _ResManager.GlobalResourceSet.GetString("ecm_view_assn_viewallassociations")%>
                     </div>
               </div>   
                </div>
                <div id="iframediv" style="display: block;overflow:hidden;">
                    <iframe frameborder="0" id="iframe" src="<%=EventProviders1.InitIfrmpath%>" width="100%" height=100%
                        style="border-width: 0px; padding: 0px; margin: 0px; overflow-x: hidden; width: 100%">
                    </iframe>
                </div>
    </div>
    <script type="text/javascript">
        var hgt = screen.availHeight;
        var hgt = screen.availHeight;     
        try
        {
            var height = document.getElementById("Maingrid").scrollHeight - document.getElementById("Table1").scrollHeight;
            if (window.parent.location.search != null && window.parent.location.search == '?FromArchestrA=true')
            {
                height = height - 15;
            }

            document.getElementById("iframediv").style.height = height + 'px';
        }
        catch (e)
        {
        }
    </script>
    </form>
      <telerik:RadWindowManager ID="windowManager" runat="server" VisibleStatusbar="false" Skin="AWTWindow" EnableEmbeddedSkins="false" RenderMode="Classic">
        <Windows>
            <telerik:RadWindow ID="ECWindow" runat="server"></telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
</body>
</html>
