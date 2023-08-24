<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.ViewEffectiveMapping" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>


<!DOCTYPE HTML>
<html>
<head id="Head1" runat="server">
    <title></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <style type="text/css">
        html,body{height:100%;}
    </style>
    <link rel="stylesheet" type="text/css" href="<%$ReplaceTemplateExpn:Common/StyleSheet/Global.css%>" />
  
</head>
    
    <script type="text/javascript" language="javascript">
        function OpenWindow(path)
        {
            var oWindow = radopen(path, "RadWindow1");
            oWindow.set_modal(true);            
            oWindow.setSize(800, 500);
            oWindow.center();           
        }
        
        // Making header & footer constant
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
            var headerdiv = document.getElementById('divheader');
            var bodydiv = document.getElementById('divbody');
            var footerdiv = document.getElementById('divfooter');
            var parentdiv = document.getElementById('divparent');
            if (parentdiv.offsetParent==document.body)
                document.body.style.height = '100%';
 
            var parentdivheight = parentdiv.offsetParent.clientHeight;//screen.height - 110;//(parentdiv.offsetParent.clientHeight) * "this.Height.Value"/100;//parentdiv.offsetParent.offsetHeight;
            parentdiv.style.height =  parentdivheight ;
            try{bodydiv.style.height = parentdivheight - headerdiv.offsetHeight - footerdiv.offsetHeight - 15;}catch(e){}//headerdiv.offsetHeight -
            bodydiv.style.width =  '100%';
            bodydiv.style.width =  parentdiv.clientWidth - (parentdiv.clientWidth * 2.5 / 100);
            bodydiv.style.overflow =  'auto';
            parentdiv.style.overflow = 'hidden';
        }
             
    function PreviouPgaeCall()
    {
        parent.document.location.href = "RepositorySettings.aspx";
        var refPage = document.referrer;
        if (refPage.indexOf("FromArchestrA") != -1) {
            parent.document.location.href = "RepositorySettings.aspx?FromArchestrA=true";
        }
    }
    </script>      

<body id="Body" style="overflow:hidden;">
      <link rel="stylesheet" type="text/css" href="<%=ThemeURL%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
    <link rel="stylesheet" type="text/css" href="<%=ThemeURL%>TelerikAjax/StyleSheet/AWTWindow/Window.css">
    <div id="divparent" style="height:100%;">
        <form id="form1" runat="server" style="height:100%;">
            <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
             <div style="text-align:left;padding-left:5px;">
                 <input id="btnback" runat="server"  src="<%$ ReplaceTemplateExpn:HWS/Images/Back-Previous.png%>" type="image" onclick="PreviouPgaeCall(); return false;"
                                 />
                        </div>
            <div id="divheader">
                <table id="THeader" style="width:96%;text-align:center;border-spacing:1px;border-collapse:separate;">
                    <tr>
                        <td style="padding-left:15px;text-align:left;">
                            <img id="Img1" src="<%$ ReplaceTemplateExpn:/Repository/Site/images/view-security-small.png%>"
                                runat="server" align="absmiddle" width="25" height="25" />
                            <span class="pagetitle">
                                <%= _ResManager.GlobalResourceSet.GetString("ec_reposettings_securitymapping")%>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td class="description" style="padding-left:20px;text-align:left;">
                            <%= _ResManager.GlobalResourceSet.GetString("ec_view_eff_l_sg_description")%>
                            &nbsp;(<%= _ResManager.GlobalResourceSet.GetString("ec_view_eff_l_sg_desc3_new")%>)
                        </td>
                    </tr>
                </table>
            </div>
            <table style="width:98%;margin:0px auto;border-collapse:separate;border-spacing:1px;height:80%;vertical-align:top;" class="tablebg" >
                <tr>
                    <td class="lefttdbg" style="width:100%;height:60%;text-align:left;padding:8px;vertical-align:top;" >
                        <div id="divbody">
                            <table style="margin:0px auto;width:100%;border-collapse:separate;border-spacing:1px;"  class="tablebg">
                                <tr>
                                    <td style="width:15%;padding:5px;vertical-align:top;text-align:left;" class='tableheaderbg' >
                                        <span class="subtitle">
                                            <%= _ResManager.GlobalResourceSet.GetString("ec_view_eff_l_sg_name")%>
                                        </span>
                                    </td>
                                    <td style="width:40%;vertical-align:top;padding:5px;text-align:left;" class='tableheaderbg'>
                                        <span class="subtitle">
                                            <%= _ResManager.GlobalResourceSet.GetString("ec_view_eff_l_sg_mapped_roles")%>
                                        </span>
                                    </td>
                                    <td style="width:40%;vertical-align:top;padding:5px;text-align:left;" class='tableheaderbg'>
                                        <span class="subtitle">
                                            <%= _ResManager.GlobalResourceSet.GetString("ec_view_eff_l_sg_mapped_users")%>
                                        </span>
                                    </td>
                                </tr>
                                <%=_Table %>
                            </table>
                        </div>
                    </td>
                </tr>
            </table>          
            <div style="height: 80%; width: 80%; display: none">
                <input type="button" id="btnOpen" value="Open Window" />
                <telerik:RadWindowManager ID="Singleton" Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false"
                    runat="server" Behaviors="Close, Minimize, Maximize, Move" DestroyOnClose="true" Overlay="false" RenderMode="Classic" VisibleStatusbar="false">  
                    <Windows>
                        <telerik:RadWindow ID="RadWindow1" Height="500" Width="800" runat="server" Skin="AWTWindow" OpenerElementId="btnOpen" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" RenderMode="Classic" VisibleStatusbar="false" Behaviors="Close, Minimize, Maximize, Move" NavigateUrl="ViewGlobalRights.aspx">
                        </telerik:RadWindow>
                    </Windows>
                </telerik:RadWindowManager>
            </div>
        </form>
    </div>
</body>
</html>
