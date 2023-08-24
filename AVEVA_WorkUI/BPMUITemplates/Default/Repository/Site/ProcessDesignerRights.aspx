<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.ProcessDesignerRights" %>
<%@ Register Src="../RightsControls/ProcessDesignerRightsGrid.ascx" TagName="ProcessDesignerRightsGrid" TagPrefix="uc1" %>
<html>
<head runat="server">
    <title><%=_ResManager.GlobalResourceSet.GetString("ec_process_designer_rights_title") %></title>
    <link rel="stylesheet" type="text/css" href="<%$ReplaceTemplateExpn:Common/StyleSheet/Global.css%>" />
     <link rel="stylesheet" type="text/css" href="<%$ReplaceTemplateExpn:TelerikAjax/StyleSheet/AWTTreeView/TreeView.AWTTreeView.css%>" />
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
        <script type="text/javascript" language="javascript">
            function GetRadWindow()
            {
                var oWindow = null;
                 oWindow = window.frameElement.radWindow;
                return oWindow;
            } 

            
            // Checks/UnChecks all the children nodes
            function UpdateAllChildren(nodes, checked)
            {
                var i;
                for (i = 0; i < nodes.get_count(); i++)
                {
                    if (checked)
                    {
                        nodes.getNode(i).check();
                    }
                    else
                    {
                        nodes.getNode(i).set_checked(false);
                    }
                    if (nodes.getNode(i).get_nodes().get_count() > 0)
                    {
                        UpdateAllChildren(nodes.getNode(i).get_nodes(), checked);
                    }
                }
            }
            function AfterCheck(sender, eventArgs)
            {
                var childNodes = eventArgs.get_node().get_nodes();
                var isChecked = eventArgs.get_node().get_checked();
                UpdateAllChildren(childNodes, isChecked);
                CheckParents(eventArgs.get_node());
            }
            
            // It Checks the parent nodes
            function CheckParents(node)
            {   
                if (node.get_checked())
                {
                    while (node.get_parent() != null)
                    {
                        node.get_parent().check();//To uncheck parents use UnCheck() function
                        node = node.get_parent();
                    }
                }

            }
            
            function GetProcessDesignerRights(rightsvalue)
            {
                var oWindow = GetRadWindow();
                oWindow.close(rightsvalue);
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
            try{bodydiv.style.height = parentdivheight - headerdiv.offsetHeight - footerdiv.offsetHeight ;}catch(e){}
            bodydiv.style.width =  '100px';
            bodydiv.style.width =  parentdiv.clientWidth;
            bodydiv.style.overflow =  'auto';
            parentdiv.style.overflow = 'hidden';
        }
        </script>
</head>
<body scroll="no">
    <div id="divparent">
        <form id="form1" runat="server">
            <%=System.Web.Helpers.AntiForgery.GetHtml()%>
            <div id="divheader">
                <table border="0" cellpadding="7" cellspacing="0" width="96%" align="center">
                    <tr>
                        <td class="pagetitle ">
                            <img src="<%$ ReplaceTemplateExpn:/Repository/Site/images/PDRight.png%>" runat="server" alt="" style="vertical-align:middle;"
                                width="25" height="25" />
                            <%=_ResManager.GlobalResourceSet.GetString("ec_process_designer_rights_header")%>
                        </td>
                    </tr>
                    <tr>
                        <td class="description">
                            <%=_ResManager.GlobalResourceSet.GetString("ec_process_designer_rights_inclusion")%>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="divbody" style="overflow:hidden;">
                <table border="0" cellpadding="7" cellspacing="1" width="98%" class="tablebg" align="center" height="100%">
                    <tr>
                        <td class="lefttdbg">
                            <table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" height="100%;">
                                <tr>
                                    <td style="height: 35px" valign="top">
                                        <asp:CheckBox ID="chkInclusion" CssClass="inputcheckbox" runat="server" Text="Check for Inclusion" />
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top">
                                        <div style="overflow: auto; height: 100%; border: 1px; border-color: #CCCCCC;">
                                            <uc1:ProcessDesignerRightsGrid ID="ProcessDesignerRightsGrid1" runat="server">
                                            </uc1:ProcessDesignerRightsGrid>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="divfooter">
                <table border="0" cellpadding="5" cellspacing="0" style="width: 98%" align="center">
                    <tr>
                        <td>
                            <table width="96%" border="0" cellpadding="0" cellspacing="1">
                                <tr>
                                    <td>
                                        <img id="Img1" runat="server" src="<%$ ReplaceTemplateExpn:/Common/Images/icon-note.png%>"
                                            align="absmiddle">&nbsp;<span class="note"> <%= _ResManager.GlobalResourceSet.GetString("ec_view_eff_li_map_sg_note")%></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                   <span class="description"><%=_ResManager.GlobalResourceSet.GetString("ec_process_designer_rights_inclusion_description") %></span>  
                                    </td>
                                </tr>
                            </table>
                          </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Button ID="btnSave" runat="server" CssClass="inputbutton"  OnClick="SaveRights"
                                />
                            <asp:Button ID="btnReset" runat="server" CssClass="inputbutton" OnClick="Reset"
                               />
                            <asp:HiddenField ID="hdnArgument" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td height="7">
                        </td>
                    </tr>
                </table>
            </div>
        </form>
    </div>
</body>
</html>
