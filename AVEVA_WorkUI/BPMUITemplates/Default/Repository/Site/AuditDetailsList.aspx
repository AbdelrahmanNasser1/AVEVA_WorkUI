<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.AuditDetailsList" MasterPageFile="~/BPMUITemplates/Default/Repository/Site/HTML5MasterPage.master" Title="Untitled Page"%>
<%@ Register Assembly="Skelta.Repository.Web" Namespace="Skelta.Repository.Web" TagPrefix="cc1" %>


<asp:Content ID="Content3" ContentPlaceHolderID="MenuTitle" runat="server"> 
    <div>		
         <%=lcl.GlobalResourceSet.GetString("ec_menu_audit_details") %>				
    </div>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Cont" Runat="Server">
   
    <asp:Panel ID="panelForm" runat="server" Height="100%" Width="100%">
        	    
    </asp:Panel>
          
    <script>

        try {
            document.getElementById("tblMain").style.display = "none";

        }
        catch (ex) {

        }

    </script>
</asp:Content>

