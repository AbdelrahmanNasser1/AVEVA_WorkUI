<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.ViewSecurityGroupRights" %>
<%@ Register Src="../RightsControls/RightsMappingGrid.ascx" TagName="RightsMappingGrid"
    TagPrefix="uc2" %>
    

<!DOCTYPE HTML>
<html>
<head runat="server">
    <title><%= _ResManager.GlobalResourceSet.GetString("ec_view_sg_rights_title")%></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <style type="text/css">
        html,body{height:100%;}
    </style>
</head>
    <script type="text/javascript">
        function GetRadWindow(){
            var oWindow = null;

            if (window.radWindow) 
                oWindow = window.radWindow;
            else if (window.frameElement.radWindow) 
                oWindow = window.frameElement.radWindow;
	        else 
	        {
                var oManager = GetRadManager();
                if (oManager.getWindowByName("RadWindow1"))
                {
                    oWindow = oManager.getWindowByName("RadWindow1");
                }
                else
                    oWindow = oManager.getWindowByName("ECWindow");
            }
            return oWindow;
        }  
        
        function CloseWindow()
        {
          var oWindow = GetRadWindow();
          oWindow.close();
        }
        
        function SetRadWindowSize()
        {
            var oWindow = GetRadWindow();
            if (document.all || document.layers) 
            {
               var w = screen.availWidth - 300;  
               var h = screen.availHeight - 300; 
            }
            oWindow.setSize(w,h);
        }
        
        function OpenRadWindow(path)
        {
            /* This was opening inside the frame. I have change it for Web Parts
            If it is at Repository level then there won't be any parent.parent.GetRadWindowManager()*/            
            var oWindow;
            if ("<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_Level, false)%>" == "Repository") {
                var oBrowserWnd = GetRadWindow().BrowserWindow;
                oWindow = oBrowserWnd.radopen(path, null);
                oWindow.set_modal(true);
                oWindow.setSize(500, 500);
                oWindow.show();
            }
            else {
                var oManager = null;
                oManager = GetRadManager();
                oWindow = oManager.getWindowByName("ECWindow");
                oWindow.setUrl(path);
                oWindow.set_modal(true);
                oWindow.setSize(500, 500);
                oWindow.show();
            }
        }

        function GetRadManager() {
            var oManager = null;
            try {
                oManager = parent.parent.parent.GetRadWindowManagerForListControl();
            }
            catch (e) {
            }

            if (oManager == null) {
                try {
                    oManager = parent.parent.GetRadWindowManagerForListControl();
                }
                catch (e) {
                }

                if (oManager == null) {
                    try {
                        oManager = parent.GetRadWindowManagerForListControl();
                    }
                    catch (e) {
                        oManager = parent.GetRadWindowManager();
                    }
                }
            }

            return oManager;
        }

        function SetRoleInfo()
        {
//            document.getElementById('trRoles').style.display='none';
//            document.getElementById('trEffective').style.display='none';
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
            
//            var headerdiv = document.getElementById('divheader');
            var footerdiv = document.getElementById('divfooter');
            var parentdiv = document.getElementById('divparent');
            if (parentdiv.offsetParent==document.body)
                document.body.style.height = '100%';

            var parentdivheight = parentdiv.offsetParent.offsetHeight;
            parentdiv.style.height =  parentdivheight ;
            try{bodydiv.style.height = parentdivheight - footerdiv.offsetHeight -25 + 'px';}catch(e){}
            //bodydiv.style.width =  '100px';
            //bodydiv.style.width =  parentdiv.clientWidth;
            bodydiv.style.overflow =  'auto';
            parentdiv.style.overflow = 'hidden';
        }
        
        function displayFooter()
        {
            document.getElementById('tdNote').style.display="block";
        }
        
   function waitPreloadPage() 
    {   //DOM
        if (document.getElementById)
        {
            document.getElementById('prepage').style.visibility='hidden';
        }
        else
        {
            if (document.layers)
            { //NS4
                document.prepage.visibility = 'hidden';
            }
            else 
            { //IE4
                document.all.prepage.style.visibility = 'hidden';
            }
        }
    }            
    </script>

<body id="Body"  onload="waitPreloadPage();" style="margin: 0; left: 0; overflow: hidden;">
    <div id="divparent" style="height:100%;">
        <div id="prepage" class="divBackgroundColor" style="visibility: visible; position: absolute;
            font-family: arial; font-size: 16; left: 0px; top: 0px; layer-background-color: white;
            height: 100%; width: 100%;">
            <table>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
            <div align="center">
                <font face="verdana" size="4" color="black"><b><%= _ResManager.GlobalResourceSet.GetString("LoadingMsg")%></b></font>
            </div>
            <table visible="false" id="indicator" style="height:20px;margin:0px auto;width:0px;">
                <tr>
                    <td align="center" bgcolor="#009900" width="100%">
                    </td>
                </tr>
            </table>
            <table id="indicatorimage" style="margin:0px auto;width:0px;">
                <tr>
                    <td style="text-align:center;width:100%">
                        <%--<asp:Image ID="imgLoading" runat="server" ImageUrl="<%=templateThemeDirectory%>SOA/images/download_line.gif" />--%>
                        <asp:Image ID="imgLoading" runat="server" ImageUrl="<%$ ReplaceTemplateExpn:SOA/images/download_line.gif%>" />
                    </td>
                </tr>
            </table>
        </div>
        <form id="form1" runat="server" style="height:100%;">
            <link href="<%=ThemeURL%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
            <%=System.Web.Helpers.AntiForgery.GetHtml()%>
            <div id="divbody">
            <table style="width:100%;">
                <tr>
                    <td style="padding:5px;">
                        <table style="width:100%;margin:0px auto;border-spacing:1px;border-collapse:separate;">
                            <tr>
                                <td>
                                    <table id="tblViewEffective" border="0" style="width:100%;margin:0px auto;border-spacing:1px;border-collapse:separate;" class="tablebg">
                                        <tr>
                                            <td style="padding:7px;vertical-align:top;"  class="subtitle" colspan="2">
                                                <%= _ResManager.GlobalResourceSet.GetString("ec_view_eff_security_sub_header")%>
                                                <asp:Label ID="lblEffectiveResource" runat="server" Text=""></asp:Label>
                                            </td>
                                            <td style="padding:7px;text-align:right;">
                                            <img src="<%=ThemeURL%>Repository/Site/images/arrow.gif" alt="" />
                                                <asp:HyperLink ID="hypSnapshots" runat="server" CssClass="HLink" Visible="false"><span class="textlinkblue"><%= _ResManager.GlobalResourceSet.GetString("ec_view_eff_securitysnapshots")%></span></asp:HyperLink>
                                            </td>
                                        </tr>  
                                    </table>  
                                </td>
                            </tr>
                            <tr>
                                <td>                          
                                    <table style="width:100%;border-spacing:1px;border-collapse:separate;" >
                                        <tr>
                                            <td colspan="5">                                       
                                                <uc2:RightsMappingGrid ID="RightsMappingGrid1" runat="server"></uc2:RightsMappingGrid>                                       
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                </td>
                    </tr>
                </table>
            </div>
            <div id="divfooter">
                <table style="width:100%;">
                    <tr>
                        <td id="tdNote" style="display:none;padding:10px;" class="note">
                            <span class="description">
                                &nbsp;<img src="<%=ThemeURL%>Common/images/icon-tips.png" align="absmiddle" />&nbsp;&nbsp;
                                <i><%=_DictatorHeading%></i> </span>
                        </td>
                    </tr>
                </table>
            </div>
            <asp:HiddenField ID="hdnRoles" runat="server" />
        </form>
    </div>
</body>
</html>
