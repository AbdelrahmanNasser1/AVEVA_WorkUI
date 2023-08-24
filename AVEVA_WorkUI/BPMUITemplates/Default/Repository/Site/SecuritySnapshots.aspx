<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.SecuritySnapshots" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title><%= _ResManager.GlobalResourceSet.GetString("ec_view_eff_securitysnapshots")%></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
       <link rel="stylesheet" type="text/css" href="<%$ReplaceTemplateExpn:Common/StyleSheet/Global.css%>" />

    <script language="javascript" type="text/javascript">
        /*function SetRoles()
        {
            var roles = parent.document.getElementById('hdnRoles').value;
            document.getElementById('lblRoles').Text = roles;
        }
        */
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
            try{bodydiv.style.height = parentdivheight - headerdiv.offsetHeight - footerdiv.offsetHeight - 18;}catch(e){}
            bodydiv.style.width =  '100px';
            bodydiv.style.width =  parentdiv.clientWidth -40;
            bodydiv.style.overflow =  'auto';
            parentdiv.style.overflow = 'hidden';
        }
        function GetRadWindow()
        {
            var oWindow = null;
            oWindow = window.frameElement.radWindow;
            return oWindow;
        } 

        function closeWindow()
        {   
           try
            {
                var oWindow = GetRadWindow();
                oWindow.close();
            }
            catch(e)
            {}
        }
        
        function visibleuserinfo()
        {
            if(navigator.appName =='Microsoft Internet Explorer')
            {
                document.getElementById('trUserMapping').style.display='block';
                document.getElementById('trRoles').style.display='block';
            }
            else
            {
                document.getElementById('trUserMapping').style.display ='table-row';
                document.getElementById('trRoles').style.display='table-row';
            }
            
        }
    </script>
</head>
<body style="overflow: hidden">
    <div id="divparent" style="overflow: hidden">
        <form id="form1" runat="server">
            <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
            <div id="divheader">
                <table width="96%" border="0" cellpadding="5" cellspacing="0" align="center">
                    <tr>
                        <td>
                            <img id="Img1" src="<%$ ReplaceTemplateExpn:/Repository/Site/images/view-security-small.png%>"
                                runat="server" align="absmiddle" width="25" height="25" />
                            <span class="pagetitle">
                                <%= _ResManager.GlobalResourceSet.GetString("ec_view_eff_securitysnapshots")%>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td class="description">
                            <%= _ResManager.GlobalResourceSet.GetString("ec_view_eff_securitysnapshotsDesc")%>
                        </td>
                    </tr>
                </table>
            </div>
            <div>
                <table id="TMain" width="96%" border="0" cellpadding="8" cellspacing="1" class="tablebg"
                    align="center">
                    <tr>
                        <td class="lefttdbg">
                            <div id="divbody">
                                <table width="100%" border="0" cellpadding="6" cellspacing="1" class="tablebg">
                                    <tr>
                                        <td width="50%" class="lefttdbg">
                                            <asp:Label ID="lblResourceName" runat="server" Font-Bold="true" CssClass="subtitle">
                                            </asp:Label><br />
                                            <span class="description">
                                                <%= _ResManager.GlobalResourceSet.GetString("ec_sec_snapshots_rolesmapped_username_desc")%>
                                            </span>
                                        </td>
                                        <td valign="middle" class="lefttdbg">
                                            <asp:Label ID="lblResourceValue" runat="server" CssClass="description">
                                            </asp:Label></td>
                                    </tr>
                                    <tr id="trUserMapping" style="display: none">
                                        <td valign="top" class="lefttdbg">
                                            <span class="subtitle">
                                                <%= _ResManager.GlobalResourceSet.GetString("ec_sec_snapshots_usermapping")%>
                                            </span>
                                            <br />
                                            <span class="description">
                                                <%= _ResManager.GlobalResourceSet.GetString("ec_sec_snapshots_rolesmapped_usermapping_desc")%>
                                            </span>
                                        </td>
                                        <td valign="middle" class="lefttdbg">
                                            <asp:Label ID="lblUserMapping" runat="server" CssClass="description">
                                            </asp:Label></td>
                                    </tr>
                                    <tr id="trRoles" style="display: none">
                                        <td valign="top" class="lefttdbg">
                                            <span class="subtitle">
                                                <%= _ResManager.GlobalResourceSet.GetString("ec_sec_snapshots_rolesmapped")%>
                                            </span>
                                            <br />
                                            <span class="description">
                                                <%= _ResManager.GlobalResourceSet.GetString("ec_sec_snapshots_rolesmapped_rolemapping_desc")%>
                                            </span>
                                        </td>
                                        <td valign="middle" class="lefttdbg">
                                            <asp:Label ID="lblRoles" runat="server" CssClass="description">
                                            </asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td valign="top" class="lefttdbg">
                                            <span class="subtitle">
                                                <%= _ResManager.GlobalResourceSet.GetString("ec_sec_snapshots_eff_sg")%>
                                            </span>
                                            <br />
                                            <span class="description">
                                                <%= _ResManager.GlobalResourceSet.GetString("ec_sec_snapshots_rolesmapped_effmapping_desc")%>
                                            </span>
                                        </td>
                                        <td valign="middle" class="lefttdbg">
                                            <asp:Label ID="lblEffective" runat="server" CssClass="description">
                                            </asp:Label></td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="divfooter">
                <table border="0" cellpadding="5" cellspacing="0" width="100%" align="center">
                    <tr>
                        <td class="lefttdbg">
                            <table id="TNote" width="100%" border="0" cellpadding="6" cellspacing="1">
                                <tr>
                                    <td colspan="4">
                                        <img id="Img2" runat="server" src="<%$ ReplaceTemplateExpn:/Common/Images/icon-note.png%>"
                                            align="absmiddle">
                                        <span class="note">
                                            <%= _ResManager.GlobalResourceSet.GetString("ec_view_eff_li_map_sg_note")%>
                                        </span>
                                        <br />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                    </td>
                                    <td colspan="2">
                                        <span class="description">
                                            <%=_DictatorHeading %>
                                        </span>
                                    </td>
                                </tr>
                            </table>
                            <table border="0" cellpadding="9" cellspacing="0" width="98%" align="center">
                                <tr>
                                    <td align="right" colspan="2">
                                        <input id="btnClose" type="button" class="inputbutton" onclick="closeWindow()" value='<%= _ResManager.GlobalResourceSet.GetString("ec_view_eff_li_map_close_button")%>'
                                             />
                                    </td>
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
