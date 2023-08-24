<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NavigatorWindow.aspx.cs"
    Inherits="SkeltaTemplates_Default_ProcessDesigner_NavigatorWindow" Theme="" StylesheetTheme=""  %>
<%@ Import Namespace="Skelta.Repository.Security" %>

<html>
<head>
    <title><%=pageTitle%></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
</head>
<link href="<%=cssPath%>StyleSheet/Global.css" rel="stylesheet" type="text/css" />
<body scroll="no" style="overflow: -moz-scrollbars-none; padding-right: 0px; padding-left: 0px;
    padding-bottom: 0px; margin: 0px; padding-top: 0px; border-style: none;">
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <table width="100%" height="100%" cellpadding="0" cellspacing="0" style="-moz-box-sizing: border-box;">
            <tr height="20px" class="header">
                <td>
                <span class="pagetitle">
                    <%=strZoomLevel%></span>
                    :&nbsp;
                    <select id="selectzoom" class="inputselect" onchange="changeUri();">
                        <option value="5">5%</option>
                        <option value="10">10%</option>
                        <option value="15">15%</option>
                        <option value="20">20%</option>
                        <option value="25">25%</option>
                        <option value="30" selected>30%</option>
                        <option value="35">35%</option>
                        <option value="40">40%</option>
                        <option value="45">45%</option>
                        <option value="50">50%</option>
                        <option value="55">55%</option>
                        <option value="60">60%</option>
                        <option value="65">65%</option>
                        <option value="70">70%</option>
                        <option value="75">75%</option>
                        <option value="80">80%</option>
                        <option value="90">90%</option>
                        <option value="100">100%</option>
                        <option value="125">125%</option>
                        <option value="200">200%</option>
                    </select>
                    <input type="button" class="inputbutton" value="<%=strRefresh%>" onclick="document.getElementById('imgframe').contentWindow.document.location.reload();" />
                </td>
            </tr>
            <tr class="lefttdbg">
                <td>
                    <iframe id="imgframe" src="loadimagemap.aspx?<%=Request.QueryString.ToSafeQueryString()%>&zoom=30"
                        width="100%" height="100%" frameborder="0"></iframe>
                </td>
            </tr>
        </table>

        <script language="javascript">
            function changeUri()
            {
                var frm=document.getElementById("imgframe");
                var sel = document.getElementById("selectzoom");                
                frm.src = "loadimagemap.aspx?<%=Request.QueryString.ToSafeQueryString()%>&zoom="+sel.value;
            }
            
        </script>

    </form>
</body>
</html>
