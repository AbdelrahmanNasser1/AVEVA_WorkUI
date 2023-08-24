<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.ViewGlobalRights" %>

<%@ Register Src="../RightsControls/RightsMappingGrid.ascx" TagName="RightsMappingGrid"   TagPrefix="uc2" %>

<!DOCTYPE HTML>
<html>
<head>
    <title><%=_ResManager.GlobalResourceSet.GetString("ec_sg_view_title") %></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <style type="text/css">
        html,body{height:100%;}
    </style>    
    
    <script type="text/javascript">
        function GetRadWindow()
        {
            var oWindow = null;
            oWindow = window.frameElement.radWindow;
            return oWindow;
        } 

        function closeWindow()
        {   
            /* Opening this page in another window from ViewEffectiveListSecurityGroup.aspx page
            var level = "<%=Request.QueryString["ListId"] %>";
            if(level != "")//"ListItem")
            {
                document.location.href = "ViewEffectiveListSecurityGroup.aspx?lcsuri=<%=_PageParams%>" ;
            }
            else */
            {
            try
            {
                var oWindow = GetRadWindow();
                oWindow.close();
                }
                catch(e)
                {
                    
                }
            }
        }
        
        function DisplayDictatorInfo()
        {
            document.getElementById('tabledictator').style.display='block';
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
            var headerdiv = document.getElementById('divheader');
            var bodydiv = document.getElementById('divbody');
            var footerdiv = document.getElementById('divfooter');
            var parentdiv = document.getElementById('divparent');
            if (parentdiv.offsetParent==document.body)
                document.body.style.height = '100%';
            //debugger;  
            var parentdivheight = parentdiv.offsetParent.offsetHeight;            
            parentdiv.style.height =  parentdivheight ;
            try
            {
                bodydiv.style.height = parentdivheight - headerdiv.offsetHeight - footerdiv.offsetHeight +"px";
            }
            catch(e)
            {
            
            }//headerdiv.offsetHeight -
            //bodydiv.style.width =  '100%';
            //bodydiv.style.width =  parentdiv.clientWidth;
            bodydiv.style.overflow =  'auto';
            parentdiv.style.overflow = 'hidden';
        }

        

    </script>

</head>
<body style="overflow: hidden">
    <div id="divparent" style="height:100%;">
        <form id="form1" runat="server" style="height:100%;">
            <%=System.Web.Helpers.AntiForgery.GetHtml()%>
            <link href="<%=ThemeURL%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
            <div id="divheader">                
                <table id="TMain" style="width:100%;border-spacing:1px;border-collapse:separate;">
                    <tr style="width:100%">
                        <td colspan="2" style="padding:1px;">
                            &nbsp;&nbsp;&nbsp;
                            <img src="<%=ThemeURL%>Repository/Site/images/new-security-group.png" align="absmiddle" />&nbsp;&nbsp;
                            <span class="pagetitle ">
                                <%=_ResManager.GlobalResourceSet.GetString("ec_sg_view_sgtitle")%>
                            </span>
                            <br />
                            &nbsp;&nbsp;&nbsp; <span class="description">
                                <%=_ResManager.GlobalResourceSet.GetString("ec_sg_view_purpose") %>
                            </span>
                        </td>
                    </tr>
                    <tr style="width: 100%">
                        <td style="padding:1px;">
                            <table  class="tablebg"  style="margin:0px auto;width:97%;border-spacing:1px;border-collapse:separate;">
                                <tr>
                                    <td class="lefttdbg" valign="top" style="width:45%;vertical-align:top;padding:7px;">
                                        <span class="subtitle">
                                            <%=_ResManager.GlobalResourceSet.GetString("ec_sg_sgTitle") %>
                                        </span>
                                        <br />
                                        <span class="description">
                                            <%=_ResManager.GlobalResourceSet.GetString("ec_sg_sg_title_desc")%>
                                        </span>&nbsp;
                                    </td>
                                    <td class="righttdbg" style="width: 64%;text-align:left;padding:7px;">
                                        &nbsp;<asp:TextBox ID="txtSecurityGroup" CssClass="inputtext" runat="server" Width="300px"
                                            onclick="this.blur()"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="width: 100%">
                    <td style="padding:1px;">
                    <table id="tabledictator" style="display:none;width:95%;margin:0px auto;border-collapse:separate;border-spacing:1px;"  class="tablebg">
                    <tr>
                        <td class="lefttdbg" style="width: 91%;padding:8px;" colspan="2">
                            <img src="<%=ThemeURL%>Common/Images/icon-tips.png" alt="" align="absmiddle" />
                            <span class="description"><%=_DictatorHeading %></span>
                        </td>
                    </tr>
                    </table>
                    </td>
                    </tr>
                </table>
                <%--
                    
                </table>--%>
                <%--</td>
                    </tr>
                </table>--%>
            </div>
            <%--<tr>
                <td align="center">--%>
            <div id="divbody" style="height:80%">
                <table  style="width:100%;">
                    <tr>
                        <td style="padding:2px;">
                            <table id="tableRights" style="width:100%;margin:0px auto;border-collapse:separate;border-spacing:1px;" >
                                <tr id="sgrights" style="text-align:left">
                                    <td style="text-align:left;padding:10px;">
                                        <uc2:RightsMappingGrid ID="RightsMappingGrid1" runat="server"></uc2:RightsMappingGrid>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
            <%--</td>
            </tr>--%>
            <div id="divfooter">
                <table style="margin:0px auto;width:100%;">
                    <tr>
                        <td style="text-align:right;padding:10px;"  colspan="2">
                            <input id="btnClose" type="button" class="inputbutton" onclick="closeWindow()" value="<%=_ResManager.GlobalResourceSet.GetString("ec_closeButton") %>"
                                 />
                        </td>
                    </tr>
                </table>
            </div>
        </form>
    </div>
</body>
</html>
