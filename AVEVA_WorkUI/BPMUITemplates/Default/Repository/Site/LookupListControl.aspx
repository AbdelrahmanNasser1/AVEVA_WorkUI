<%@ Page Language="C#" Inherits="Skelta.Forms.Codebehind.LookupListControl" MasterPageFile="~/BPMUITemplates/Default/Repository/Site/Html5MasterPage.master" AutoEventWireup="true" Title="Untitled Page"%>
<%@ Register Assembly="Skelta.Forms.Web" Namespace="Skelta.Forms.Web" TagPrefix="cc1" %>


<asp:Content ID="Content3" ContentPlaceHolderID="MenuTitle" runat="server"> 
    <div>		
          <%=ListControl1.GlobalResourceSet.GetString("ec_menu_lookuplist") %>									
    </div>
</asp:Content>



<asp:Content ID="Content1" ContentPlaceHolderID="Cont" Runat="Server">

    <asp:Panel ID="PanelForm" runat="server" Height="100%">
        	    
    </asp:Panel>
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
