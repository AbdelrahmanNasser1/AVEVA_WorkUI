<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.ViewEffectiveListMapping" %>

<!DOCTYPE HTML>
<html>
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <style type="text/css">
        html,body{height:100%;}
    </style>
    <script type="text/javascript">
        function OpenWindow(path)
        {
            try
            {
                var oManager = null;
                try {
                    oManager = parent.parent.parent.parent.GetRadWindowManagerForListControl();
                }
                catch (e) {
                }

                if (oManager == null) {
                    oManager = parent.parent.GetRadWindowManager();
                }

                var oWnd = oManager.getWindowByName("ECWindow");

                if (document.all || document.layers) 
                {
                   var w = screen.availWidth;  
                   var h = screen.availHeight; 
                }
                oWnd.setUrl(path);                
                oWnd.setSize(760, 520);
                oWnd.center();
                oWnd.show();
            }
            catch(e)
            {
            }
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
        function resizefunction() {
            var bodydiv = document.getElementById('divbody');
            var headerdiv = document.getElementById('divheader');
            var footerdiv = document.getElementById('divfooter');
            var parentdiv = document.getElementById('divparent');
            if (parentdiv.offsetParent == document.body)
                document.body.style.height = '100%';

            var parentdivheight = parentdiv.offsetParent.clientHeight;//parentdiv.offsetParent.offsetHeight;
            parentdiv.style.height = parentdivheight;
            if (navigator.userAgent.indexOf("MSIE") != -1)
                try { bodydiv.style.height = parentdivheight - headerdiv.offsetHeight - footerdiv.offsetHeight - (parentdivheight * 1 / 100); } catch (e) { }
            else
                try { bodydiv.style.height = parentdivheight - headerdiv.offsetHeight - footerdiv.offsetHeight - (parentdivheight * 35 / 100); } catch (e) { }
            //bodydiv.style.width =  '100px';
            //bodydiv.style.width =  parentdiv.clientWidth - (parentdiv.clientWidth * 2.5 / 100);
            bodydiv.style.overflow = 'auto';
            var themePath = '<%=ThemeURL%>';
            if (themePath.indexOf('layouts') > -1) {
                parentdiv.style.overflow = 'auto';
            }
            else {
            parentdiv.style.overflow = 'hidden';
                headerdiv.style.height = '10%';
        }
        }
        function back() {
            document.location.href = 'ListSettings.aspx?lcsuri=<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_PageParams, false) %>'
        }
    </script>

    <link rel="stylesheet" type="text/css" href="<%$ReplaceTemplateExpn:Common/StyleSheet/Global.css%>" />
</head>
<body id="Body" style="overflow:hidden;">
    <div id="divparent" style="height:100%;">
        <form id="form1" runat="server" style="height:100%;">
            <%=System.Web.Helpers.AntiForgery.GetHtml()%>
                        <div style="text-align:left;padding-left:5px; height:10%">
                            <input id="backButton"  runat="server" src="<%$ ReplaceTemplateExpn:HWS/Images/Back-Previous.png%>" type="image" onclick="back(); return false;" />
                        </div>
            <div id="divheader" style="height:20%">
                <table style="width:96%;text-align:center;border-spacing:1px;border-collapse:separate;">
                    <tr>
                        <td style="padding-left:10px;text-align:left;">
                            <img id="Img1" src="<%$ ReplaceTemplateExpn:/Repository/Site/images/view-security-small.png%>"
                                runat="server" align="absmiddle" width="25" height="25" />
                            <span class="pagetitle">
                                <%= _ResManager.GlobalResourceSet.GetString("ec_listsettings_securitymapping")%>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td class="description" style="padding:10px;text-align:left;">
                            <%= _ResManager.GlobalResourceSet.GetString("ec_listsettings_securitymapping_Desc")%>
                            &nbsp;(<%= _ResManager.GlobalResourceSet.GetString("ec_view_eff_li_map_description")%>)
                        </td>
                    </tr>
                </table>
            </div>
                        <div id="divbody" style="overflow: auto;height:40%;width:98%;padding:10px;">
                            <table style="margin:0px auto;width:100%;border-collapse:separate;border-spacing:1px;"  class="tablebg">
                                <tr>
                                    <td style="width:15%;padding:5px;vertical-align:top;text-align:left;" class='tableheaderbg' >
                                        <span class="subtitle">
                                            <%= _ResManager.GlobalResourceSet.GetString("ec_srm_securitygroup")%>
                                        </span>
                                    </td>
                                    <td style="width:40%;vertical-align:top;padding:5px;text-align:left;" class='tableheaderbg'>
                                        <span class="subtitle">
                                            <%= _ResManager.GlobalResourceSet.GetString("ec_srm_rolename")%>
                                        </span>
                                    </td>
                                    <td style="width:40%;vertical-align:top;padding:5px;text-align:left;" class='tableheaderbg'>
                                        <span class="subtitle">
                                            <%= _ResManager.GlobalResourceSet.GetString("ec_srm_username")%>
                                        </span>
                                    </td>
                                </tr>
                                <%=_Table %>
                            </table>
                        </div>
            <div id="divfooter" style="height:30%">
            <table style="width: 98%">
                <tr>
                    <td>
                        <table style="width:98%";>
                            <tr>
                                <td class="note">
                                    <img id="Img2" runat="server" src="<%$ ReplaceTemplateExpn:/Common/Images/icon-note.png%>"
                                        vertical-align="text-bottom">&nbsp;<%= _ResManager.GlobalResourceSet.GetString("ec_view_eff_li_map_sg_note")%>
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td class="note" style="padding:20px;">
                                    <%=_DictatorHeading %>
                                </td>
                            </tr>
                            <%--<tr>
                                <td align="right">
                                    <input id="backButton" type="button" runat="server" class="inputbutton" onclick="back();"
                                       style="width: 60px" />
                                </td>
                            </tr>--%>
                        </table>
                    </td>
                </tr>
            </table>
            </div>
        </form>
    </div>
</body>
</html>
