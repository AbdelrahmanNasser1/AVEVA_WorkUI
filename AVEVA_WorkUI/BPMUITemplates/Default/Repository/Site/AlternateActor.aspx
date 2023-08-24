<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/BPMUITemplates/Default/Repository/Site/HTML5MasterPage.master" Inherits="Skelta.Repository.Web.CodeBehind.AlternateActor" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MenuTitle" runat="server"> 
    <div>		
      <%=ResManager.GlobalResourceSet.GetString("ec_menu_alternate_actor") %>				
    </div>
</asp:Content>


<asp:Content ID="Content1" ContentPlaceHolderID="Cont" Runat="Server">
    <iframe id="alternateActorFrame" src="<%=PagePath %>" width="100%" height="100%" frameborder="0" style="overflow:hidden"></iframe>
</asp:Content>
