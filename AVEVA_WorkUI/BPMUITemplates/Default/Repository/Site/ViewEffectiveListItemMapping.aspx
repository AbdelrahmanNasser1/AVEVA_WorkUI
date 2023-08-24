<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.ViewEffectiveListItemMapping" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Security Mapping for List Item</title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    
    <script type="text/javascript" language="javascript">
        function OpenWindow(path)
        {
            try
            {
                var oManager =  parent.parent.GetRadWindowManager();
                var oWnd     = oManager.getWindowByName("ECWindow");

                if (document.all || document.layers) 
                {
                   var w = screen.availWidth;  
                   var h = screen.availHeight; 
                }
                oWnd.setUrl(path);
                
                oWnd.setSize(800,600);
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
            if(navigator.userAgent.indexOf("MSIE")!=-1)
                try{bodydiv.style.height = parentdivheight - headerdiv.offsetHeight - footerdiv.offsetHeight - (parentdivheight * 2 / 100) ;}catch(e){}
            else
                try{bodydiv.style.height = parentdivheight - headerdiv.offsetHeight - footerdiv.offsetHeight - (parentdivheight * 32 / 100) ;}catch(e){}
            bodydiv.style.width =  '100px';
            bodydiv.style.width =  parentdiv.clientWidth - (parentdiv.clientWidth * 2.5 / 100);
            bodydiv.style.overflow =  'auto';
            parentdiv.style.overflow = 'hidden';
        }
        function back() {
            document.location.href = 'ListItemSettings.aspx?lcsuri=<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_PageParams, false) %>'
        }
    </script>

     <link rel="stylesheet" type="text/css" href="<%$ReplaceTemplateExpn:Common/StyleSheet/Global.css%>" />
</head>
<body id="Body">
    <div id="divparent">
        <form id="form1" runat="server">
            <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
            <div id="divheader">
                <table width="96%" cellpadding="5" cellspacing="0" border="0" align="center">
                    <tr>
                        <td>
                            <img id="Img1" src="<%$ ReplaceTemplateExpn:/Repository/Site/images/view-security-small.png%>"
                                runat="server" align="absmiddle" width="25" height="25" />
                            <span class="pagetitle">
                                <%= _ResManager.GlobalResourceSet.GetString("ec_listitemsettings_securitymapping")%>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td class="description">
                            <%= _ResManager.GlobalResourceSet.GetString("ec_listitemsettings_securitymapping_ListItemDesc")%>
                            &nbsp;(<%= _ResManager.GlobalResourceSet.GetString("ec_view_eff_li_map_description")%>)
                        </td>
                    </tr>
                </table>
            </div>
                <table border="0" cellpadding="8" cellspacing="1" width="96%" class="tablebg" align="center">
                    <tr>
                        <td class="lefttdbg" style="width: 100%; height: 100%;">
                            <div id="divbody" style="overflow: auto;">
                                <table border="0" cellpadding="5" cellspacing="1" class="tablebg" style='width: 98%;'>
                                    <tr>
                                        <td width="15%" class='tableheaderbg' valign="top">
                                            <span class="subtitle">
                                                <%= _ResManager.GlobalResourceSet.GetString("ec_view_eff_l_sg_name")%>
                                            </span>
                                        </td>
                                        <td width="40%" class='tableheaderbg' valign="top">
                                            <span class="subtitle">
                                                <%= _ResManager.GlobalResourceSet.GetString("ec_view_eff_l_sg_mapped_roles")%>
                                            </span>
                                        </td>
                                        <td width="40%" class='tableheaderbg' valign="top">
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
            <div id="divfooter">
                <table width="100%" border="0" cellpadding="10" cellspacing="1" align="left">
                    <tr>
                        <td>
                            <table width="98%" border="0" cellpadding="6" cellspacing="1">
                                <tr>
                                    <%--<td width="20px">
                                    </td>--%>
                                    <td>
                                        <img id="Img2" runat="server" src="<%$ ReplaceTemplateExpn:/Common/Images/icon-note.png%>"
                                            align="left">&nbsp;<span class="note"><%= _ResManager.GlobalResourceSet.GetString("ec_view_eff_li_map_sg_note")%></span>
                                    </td>
                                </tr>
                                <tr>
                                    <%--<td width="20px">
                                    </td>--%>
                                    <td class="note">
                                        <%=_DictatorHeading %>
                                    </td>
                                    <td align="right" valign="bottom">
                                        <input id="backButton" type="button" runat="server" class="inputbutton" onclick="back();"
                                            style="width: 60px" />
                                    </td>
                                </tr>
                                <tr style="height: 10px;">
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </form>
    </div>
</body>
</html>
