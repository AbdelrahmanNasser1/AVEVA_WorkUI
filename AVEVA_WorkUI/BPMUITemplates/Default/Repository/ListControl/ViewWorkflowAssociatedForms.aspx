<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.ViewWorkflowAssociatedForms" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Associated Forms</title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
</head>
    <body style="margin:0;overflow:hidden">
    <form id="form1" runat="server">
          <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
    <%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <div>
           <telerik:RadMultiPage ID="RadMultiPage2" runat="server"  SelectedIndex="0" Width="98%" Height="25" >
                    <telerik:RadPageView ID="VersionPage" runat="server" Width="100%">
                    <iframe width="97%"  frameborder="0" id="versionFrame" src="ListItemVersions.aspx?<%=QParams%>" style="height:95vh;margin:14px 14px 14px 15px;">
                    </iframe>
                    </telerik:RadPageView>
             </telerik:RadMultiPage> 
    </div>
    </form>
</body>
</html>
