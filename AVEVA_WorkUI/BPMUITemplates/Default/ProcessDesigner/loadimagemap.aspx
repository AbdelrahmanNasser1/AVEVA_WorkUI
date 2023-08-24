<%@ Page Language="C#" AutoEventWireup="true" CodeFile="loadimagemap.aspx.cs" Inherits="SkeltaTemplates_Default_ProcessDesigner_loadimagemap" Theme="" StylesheetTheme="" %>
<%@ Import Namespace="Skelta.Repository.Security" %>
<html>
<head>
    <title>Untitled Page</title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <script language="javascript">
        function NodeClicked(nodename)
        {
            if( window.top.opener == null ) return;
            //if( window.top.opener.parent.parent._skProcessDesigner == null ) {alert("no"); return;}
            //if( window.top.opener.parent.parent._skProcessDesigner == null ) return;
            window.top.opener.NodeShow(nodename);
        }
    </script>
</head>
<body style="padding-right: 0px;padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px; border-style: none;">
    <form id="form1" runat="server">
    <%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <div>
        <asp:PlaceHolder ID="mapplaceholder" runat="server"></asp:PlaceHolder>
        <img src="openimage.aspx?<%=Request.QueryString.ToSafeQueryString()%>&imageCollUniqueId=<%=Microsoft.Security.Application.Encoder.UrlEncode(uniqueId) %>" usemap="#map1" border=0 /> 
    </div>
    </form>
</body>
</html>
