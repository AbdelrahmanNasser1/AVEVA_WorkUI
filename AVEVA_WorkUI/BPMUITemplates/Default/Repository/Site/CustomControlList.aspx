<%@ Page Language="C#" Inherits="Skelta.Forms.Codebehind.CustomControList" CodeFile="CustomControlList.aspx.cs" MasterPageFile="~/BPMUITemplates/Default/Repository/Site/HTML5MasterPage.master" AutoEventWireup="true"%>
<%@ Register Assembly="Skelta.Forms.Web" Namespace="Skelta.Forms.Web" TagPrefix="cc1" %>
 
<asp:Content ID="Content3" ContentPlaceHolderID="MenuTitle" runat="server"> 
    <div>		
       <%=lcl.GlobalResourceSet.GetString("ec_menu_CustomControls") %>						
    </div>
</asp:Content>
   
<asp:Content ID="Content1" ContentPlaceHolderID="Cont" Runat="Server">
        <asp:Panel ID="PanelForm" runat="server" Height="100%">        	    
        </asp:Panel>  
    
     <script>

         try {
             document.getElementById("tblMain").style.display = "none";

         }
         catch (ex) {

         }

    </script>     
</asp:Content>
