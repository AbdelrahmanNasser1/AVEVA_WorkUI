<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/BPMUITemplates/Default/Repository/Site/Html5MasterPage.master" Inherits="Skelta.Repository.Web.CodeBehind.WebAPIListControl" %>
<%@ Register Assembly="Skelta.Forms.Web" Namespace="Skelta.Forms.Web" TagPrefix="cc1" %>
 
<asp:Content ID="Content3" ContentPlaceHolderID="MenuTitle" runat="server"> 
    <div>		        
        <%=resManager.GlobalResourceSet.GetString("ec_menu_webapi") %>				
    </div>
</asp:Content>


<asp:Content ID="Content1" ContentPlaceHolderID="Cont" Runat="Server">
    <asp:Panel ID="panelForm" runat="server" Height="100%">        	    
    </asp:Panel>        

    <script>

         try
         {
             document.getElementById("tblMain").style.display = "none";

         }
         catch (ex) {

         }

    </script>
</asp:Content>
