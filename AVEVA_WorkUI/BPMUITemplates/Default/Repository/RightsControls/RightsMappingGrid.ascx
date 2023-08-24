<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.RightsMappingGrid" %>
<%@ Register Assembly="Skelta.Repository.Web" Namespace="Skelta.Repository.Web.Repository"
    TagPrefix="cc1" %>


<script src="../../Common/JavaScripts/jquery.min.js"></script>
<script src="../../Common/JavaScripts/AutoLogoff.js"></script>

<script language="javascript" type="text/javascript">
    function ShowSecurityHelp()
    {
        var left;
        var top;
        left = (screen.width / 2) - (720 / 2);
        top = (screen.availHeight / 2) - (460 / 2);

     window.open("SecurityGroupRights.html", "HELP", "top=" + top + ",left=" + left + ",width=600,height=400,scrollbars=yes,location=no,menubar=no,resizable=yes,status=no,toolbar=no");
       } 
</script>
<asp:Panel ID="pnlGrid" runat="server" Height="100%" Width="100%" BackColor="transparent">
</asp:Panel>

