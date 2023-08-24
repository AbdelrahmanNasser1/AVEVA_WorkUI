<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.BAMRights" %>
<%@ Register Src="../RightsControls/BAMRightsGrid.ascx" TagName="BAMRightsGrid" TagPrefix="uc1" %>
<!DOCTYPE HTML>
<html>
<head runat="server">
    <title><%= _ResManager.GlobalResourceSet.GetString("ec_bam_rights_title") %></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
     <%--<link rel="stylesheet" type="text/css" href="<%$ReplaceTemplateExpn:Repository/Site/styles/aquila.css%>" />--%>
     <link rel="stylesheet" type="text/css" href="<%$ReplaceTemplateExpn:Common/StyleSheet/Global.css%>" />
         <link rel="stylesheet" type="text/css" href="<%$ReplaceTemplateExpn:TelerikAjax/StyleSheet/AWTTreeView/TreeView.AWTTreeView.css%>" />
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
                for (i = 0; i < nodes.get_count(); i++) {
                    if (checked) {
                        nodes.getNode(i).check();
                    }
                    else {
                        nodes.getNode(i).set_checked(false);
                    }
                    if (nodes.getNode(i).get_nodes().get_count() > 0) {
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
                        node = node.get_parent();

                        if (node.check)
                        {
                            node.check();//To uncheck parents use UnCheck() function
                        }
                        else
                        {
                            break;
                        }
                    }
                }
//                else // If user unchecks the last node then the parent node should also be unchecked
//                {   debugger;
//                    if(node.Parent.CheckedNodes == 0)
//                    {
//                        node.Parent.UnCheck();
//                        node = node.Parent;
//                    }
//                }

            }
            
            function GetBAMRights(rightsvalue)
            {
//                debugger;
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
            try{bodydiv.style.height = 230+'px';}catch(e){}
            bodydiv.style.width =  '100%';
            bodydiv.style.width =  parentdiv.clientWidth;
            bodydiv.style.overflow =  'auto';
            parentdiv.style.overflow = 'hidden';
        }
      </script>
</head>
<body style="margin:0;overflow:hidden;">
    <div id="divparent">
        <form id="form1" runat="server">
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
            <div id="divheader">
                <table border="0" cellpadding="7" cellspacing="0" width="96%" align="center">
                    <tr>
                        <td class="pagetitle ">
                            <img src="<%$ ReplaceTemplateExpn:/Repository/Site/images/BAM-right.png%>"  runat="server" width="25" height="25" alt="" style="vertical-align:middle;"/>
                            <%=_ResManager.GlobalResourceSet.GetString("ec_bam_rights_header")%>
                        </td>
                    </tr>
                    <tr>
                        <td class="description">
                            <%=_ResManager.GlobalResourceSet.GetString("ec_bam_rights_inclusion")%>
                        </td>
                    </tr>                    
                </table>
            </div>
            <div id="divbody" style="overflow:hidden">
                <table border="0" cellpadding="5" cellspacing="1" width="96%" height="92%" class="tablebg" align="center">
                    <tr>
                        <td class="lefttdbg">
                            <table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" height="100%;">
                                <tr>
                                    <td style="height:35px">
                                        <asp:CheckBox ID="chkInclusion" CssClass="inputcheckbox" runat="server" /></td>
                                </tr>
                                <tr>
                                    <td >
                                        <div class="FieldSet" style="overflow: auto; height: 100%; width: 100%; border: 0px;">
                                            <uc1:BAMRightsGrid id="BAMRightsGrid1" runat="server">
                                            </uc1:BAMRightsGrid>
                                        </div>
                                    </td>
                                </tr>
                                <%--<tr>
                        <td>
                            <%--<div style="overflow: auto; height: 100%; width: 100%; border:1px; border-color:#CCCCCC;">
                                <uc1:BAMRightsGrid id="BAMRightsGrid1" runat="server">
                                </uc1:BAMRightsGrid>
                            </div>
                        </td>
                    </tr>--%>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
            
            <div id="divfooter">
                <table border="0" cellpadding="3" cellspacing="0" style="width: 96%" align="center">
                    <tr>
                        <td>
                            <table border="0" cellpadding="0" cellspacing="1" style="width: 100%" >
                                <tr>
                                    <td >
                                        <img id="Img1" runat="server" src="<%$ ReplaceTemplateExpn:/Common/Images/icon-note.png%>"
                                            align="absmiddle">&nbsp;<span class="note"> <%= _ResManager.GlobalResourceSet.GetString("ec_view_eff_li_map_sg_note")%></span>
                                       
                                    </td>
                                </tr>
                                <tr>
                               
                                <td ><span class="note"> <%=_ResManager.GlobalResourceSet.GetString("ec_bam_rights_inclusion_description")%></span> </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Button ID="btnSave" runat="server" CssClass="inputbutton"  OnClick="SaveRights"
                                />
                            <asp:Button ID="btnReset" runat="server" CssClass="inputbutton"  OnClick="Reset"
                                />
                           <%-- <input id="btnCancel" type="button" class="inputbutton" value="Close" onclick="javascript:closeWindow();"
                                style="width: 60px" />--%>
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
