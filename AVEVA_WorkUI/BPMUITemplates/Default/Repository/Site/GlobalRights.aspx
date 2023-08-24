<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.GlobalRights" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ Register Src="../RightsControls/RightsMappingGrid.ascx" TagName="RightsMappingGrid"
    TagPrefix="uc2" %>
      <link href="<%=cssPath%>/Global.css" rel="stylesheet" type="text/css" />


<html>
<head runat="server">
    <title><%=_ResManager.GlobalResourceSet.GetString("ec_sg_edit_title") %></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>    
</head>
    <script type="text/javascript" language="javascript">
        function OpenWindow(path)
        {            
            closeWindow();
            var winHeight;
            var winWidth;
            var marginForBreadCrumb = 0;
            var oBrowserWnd = GetRadWindow().BrowserWindow; 
            var oWin = oBrowserWnd.radopen(path, "RadWindow1");
            if('<%=_ListId %>' == '00000000-0000-0000-0000-000000000000')
            {
                winHeight = 500;
                winWidth = 500;
            }
            else
            {
                winHeight = 300;
                winWidth = 450;
                marginForBreadCrumb = 72;
            }
            var w,h;
            
           if (document.all || document.layers) {
                w = screen.availWidth;   //getMaxWidth();    
                h = screen.availHeight; //getMaxHeight();    
           }

            var winLeft = (w-winWidth)/2;
            var winTop  = ((h-winHeight)/2) - marginForBreadCrumb;    
            oWin.set_modal(true);
            oWin.setSize(winWidth, winHeight);
            oWin.center();            
        }
        
        function GetRadWindow()
        {
            var oWindow = null;
             oWindow = window.frameElement.radWindow;
            return oWindow;
        } 

        function closeWindow()
        {
          var oWindow = GetRadWindow();
          oWindow.close();                        
        }
        
        function noEditing(evt)
        {
            return false;
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
            try {
                var parentdivheight = parentdiv.offsetParent.offsetHeight;
                parentdiv.style.height = parentdivheight;
                 bodydiv.style.height = parentdivheight - headerdiv.offsetHeight - footerdiv.offsetHeight; } catch (e) { }
                bodydiv.style.width = '100px';
                bodydiv.style.width = parentdiv.clientWidth;
                bodydiv.style.overflow = 'auto';
                parentdiv.style.overflow = 'hidden';
            
        }
       
    </script>
<body  style="overflow:hidden" >
    <div id="divparent">
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        <div id="divheader">
            <table id="TMain" width="99%" align="center" border="0" cellpadding="7" cellspacing="1">
                <tr>
                    <td colspan="2" class="pagetitle ">
                        <img src="<%=ThemeURL%>Repository/Site/images/new-security-group.png" align="absmiddle" />&nbsp;&nbsp;
                        <%= _ResManager.GlobalResourceSet.GetString("ec_sg_edit_header")%>
                    </td>
                </tr>
                <tr id="sgdescription">
                    <td valign="top"  class="description" style="width: 91%"
                        colspan="2">&nbsp;&nbsp;&nbsp;
                        <%=_ResManager.GlobalResourceSet.GetString("ec_sg_edit_header_description")%>
                    </td>
                </tr>
                <tr style="width: 30px">
                    <td>
                        <table width="97%" align="center" border="0" cellpadding="7" cellspacing="1" class="tablebg">
                            <tr>
                                <td class="lefttdbg" valign="top" style="width: 45%">
                                <span class="subtitle">
                                    <%=_ResManager.GlobalResourceSet.GetString("ec_sg_sgTitle") %>
                                    </span>
                                    <br />
                                    <span class="description">
                                <%=_ResManager.GlobalResourceSet.GetString("ec_sg_sg_title_desc")%>
                                </span>
                                    &nbsp;
                                </td>
                                <td class="righttdbg" style="width: 55%">
                                    &nbsp;<asp:TextBox ID="txtSecurityGroup" onclick="this.blur()" onkeypress="return noEditing();" CssClass="inputtext" runat="server" Width="300px"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            </div>
        <div id="divbody">
            <table width="100%" border="0" cellspacing="0" cellpadding="5">
                <tr>
                    <td>
                        <table id="tableRights" width="96%" align="center" border="0" cellspacing="1" cellpadding="3">
                            <tr id="sgrights" align="center">
                                <td align="center">
                                    <uc2:RightsMappingGrid ID="RightsMappingGrid1" runat="server"></uc2:RightsMappingGrid>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            </div>                
            <div id="divfooter">
            <table border="0" cellpadding="10" cellspacing="0" width="100%" align="center">
                <tr>
                    <td align="right">
                        <asp:Button ID="btnSave" runat="server" CssClass="inputbutton" OnClick="btnSaveRights_Click"/>
                        <asp:HiddenField ID="hdnSecurityGroupId" runat="server" Value="" />
                    </td>
                </tr>
            </table>
            </div>
    </form>
    </div>
</body>
</html>
