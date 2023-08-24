<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.ViewEffectiveListSecurityGroup" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE HTML>
<html>
<head id="Head1" runat="server">
    <title><%= _ResManager.GlobalResourceSet.GetString("ec_rbn_effectivemapping")%></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <style>
        html,body{height:100%;}

    </style>
  <link rel="stylesheet" type="text/css" href="<%$ReplaceTemplateExpn:Common/StyleSheet/Global.css%>" />
    <link rel="stylesheet" type="text/css" href="<%$ReplaceTemplateExpn:TelerikAjax/StyleSheet/AWTWindow/Window.css%>" />
    <link rel="stylesheet" type="text/css" href="<%$ReplaceTemplateExpn:TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css%>" />
     
    <script type="text/javascript">
        function OpenWindow(path)
        {
            var oBrowserWnd = GetRadWindow().BrowserWindow;
            var oWin = oBrowserWnd.radopen(path, "RadWindow1");
            oWin.set_modal(true);
            oWin.setSize(800, 500);
            oWin.center();
        }
    </script>

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

        function closeWindow()
        {
          var oWindow = GetRadWindow();
          //parent.document.location.reload();
          oWindow.close();
        }

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
            try{bodydiv.style.height = parentdivheight - headerdiv.offsetHeight - footerdiv.offsetHeight - 23;}catch(e){}//headerdiv.offsetHeight -
            //bodydiv.style.width =  '100px';
            //bodydiv.style.width = parentdiv.clientWidth - 30;
            //bodydiv.style.overflow =  'scroll';
            parentdiv.style.overflow = 'hidden';
        }
        
       
    </script>

</head>
<body style="overflow: hidden">
    <div id="divparent" style="overflow:hidden;height:100%;">
        <form id="form1" runat="server" style="height:100%;">
             <%=System.Web.Helpers.AntiForgery.GetHtml()%>
            <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
            <div id="divheader">                
                <table style="width:96%;margin:0px auto;border-spacing:1px;border-collapse:separate;">
                    <tr>
                        <td style="padding:5px;">
                            <img src="<%$ ReplaceTemplateExpn:/Repository/Site/images/view-security-small.png%>"
                                runat="server" style="vertical-align:middle;" />&nbsp;
                            <span class="pagetitle"><%= _ResManager.GlobalResourceSet.GetString("ec_view_eff_l_sg_header")%></span>
                        </td>
                    </tr>
                    <tr>
                        <td class="description" style="padding:5px;">
                            <%= _ResManager.GlobalResourceSet.GetString("ec_view_eff_l_sg_desc1")%>
                        </td>
                    </tr>
                </table>
            </div>
            
                    <div id="divbody" style="height:60%;overflow:auto;">
                            <%=_Table %>
                    </div>
            <div id="divfooter">
                <table style="width: 100%;margin:0px auto;" >
                    <tr>
                        <td style="">
                            <table style="width: 100%;border-spacing:1px;border-collapse:separate;">
                                <tr>
                                    <td colspan="4">
                                       <span class="subtitle">&nbsp;&nbsp;<%= _ResManager.GlobalResourceSet.GetString("ec_Legend")%></span>
                                    
                                    </td>
                                </tr>
                            </table>
                            <table style="border-collapse:collapse;border-spacing:0px;">
                                <tr>
                                    <td style="padding:5px;" >
                                        <img style="vertical-align:middle" id="imgNoMapping" alt="No Mapping" src="<%$ ReplaceTemplateExpn:/Repository/Site/Images/no-mapping.png%>"
                                            runat="server" />&nbsp;
                                            <span class="description">
                                        <%= _ResManager.GlobalResourceSet.GetString("ec_view_eff_l_sg_nomappig_text")%>
                                        </span>
                                        &nbsp;&nbsp;</td>
                                    <td style="text-align:center;padding:5px;" >
                                        |</td>
                                    <td style="padding:5px;">
                                        <img id="imgYes" alt="Modified" src="<%$ ReplaceTemplateExpn:/Repository/Site/Images/yes.png%>"
                                            runat="server" />&nbsp;
                                            <span class="description">
                                        <%= _ResManager.GlobalResourceSet.GetString("ec_view_eff_l_sg_YES_text")%>
                                        </span>
                                        &nbsp;&nbsp;</td>
                                    <td style="text-align:center;padding:5px;">
                                        |</td>
                                    <td style="padding:5px;">
                                        <img id="imgNo" alt="Not modified" src="<%$ ReplaceTemplateExpn:/Repository/Site/Images/no.png%>" runat="server" />&nbsp;
                                        <span class="description">
                                        <%= _ResManager.GlobalResourceSet.GetString("ec_view_eff_l_sg_NO_text")%>
                                        </span>&nbsp;&nbsp;</td>
                                    <td style="text-align:center;padding:5px;">
                                        </td>
                                   
                                </tr>
                            </table>

                        </td>
                    </tr>
                    <tr>
                        <td style="text-align:right;">
                            <input id="btnClose" type="button" class="inputbutton" onclick="closeWindow()" value="<%= _ResManager.GlobalResourceSet.GetString("ec_closeButton")%>"
                              />
                        </td>
                    </tr>
                </table>
            </div>
            <div style="height: 80%; width: 80%; display: none">
                <input type="button" id="btnOpen" value="Open Window" />
                <telerik:RadWindowManager ID="Singleton" Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false"
                    runat="server" Behaviors="Close, Minimize, Maximize, Move" DestroyOnClose="true" Overlay="false" RenderMode="Classic" VisibleStatusbar="false">  
                    <Windows>
                        <telerik:RadWindow ID="RadWindow1" Height="600" Width="800" runat="server" Skin="AWTWindow" OpenerElementId="btnOpen" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" RenderMode="Classic" VisibleStatusbar="false" Behaviors="Close, Minimize, Maximize, Move" NavigateUrl="ViewGlobalRights.aspx">
                        </telerik:RadWindow>
                    </Windows>
                </telerik:RadWindowManager>
            </div>
        </form>
    </div>
</body>
</html>
