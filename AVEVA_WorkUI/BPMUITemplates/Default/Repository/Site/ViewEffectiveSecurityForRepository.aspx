<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.ViewEffectiveSecurityForRepository" Title="Untitled Page" %>



<asp:Content ID="Content3" ContentPlaceHolderID="MenuTitle" runat="server"> 
    <div>		
       <%=resManager.GlobalResourceSet.GetString("EC_UXmenu_SecurityRights")%>		
    </div>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Cont" Runat="Server">
    <iframe id="vieweff" src="ViewEffectiveSecurity.aspx?Level=Repository" width="100%" height="100%" frameborder="0" scrolling="no"></iframe>

     <script>

         try {
             document.getElementById("tblMain").style.display = "none";
         }
         catch (ex) {

         }

    </script>
</asp:Content>

