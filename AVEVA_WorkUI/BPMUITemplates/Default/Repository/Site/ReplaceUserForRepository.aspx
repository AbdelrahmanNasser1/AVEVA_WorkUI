﻿<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/BPMUITemplates/Default/Repository/Site/HTML5MasterPage.master" Inherits="Skelta.Repository.ReplaceUser.BPMUITemplates_Default_Repository_Site_ReplaceUserForRepository" %>


<asp:Content ID="Content3" ContentPlaceHolderID="MenuTitle" runat="server"> 
    <div>		
      <%=resManager.GlobalResourceSet.GetString("ec_menu_replaceuser") %>				
    </div>
</asp:Content>


<asp:Content ID="Content1" ContentPlaceHolderID="Cont" Runat="Server">
    <iframe id="replaceUser" src="ReplaceUserUI.aspx" width="100%" height="100%" frameborder="0" style="overflow-x:hidden" scrolling="auto"></iframe>

     <script>

         try
         {
             document.getElementById("tblMain").style.display = "none";
         }
         catch (ex)
         {

         }

    </script>

</asp:Content>
