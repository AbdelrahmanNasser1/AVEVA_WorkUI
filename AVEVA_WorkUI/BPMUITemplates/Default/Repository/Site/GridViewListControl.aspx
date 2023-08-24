<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GridViewListControl.aspx.cs" Inherits="BPMUITemplates_Default_Repository_Site_GridViewListControl" MasterPageFile="~/BPMUITemplates/Default/Repository/Site/Html5MasterPage.master"%>


<asp:Content ID="Content3" ContentPlaceHolderID="MenuTitle" runat="server"> 
    <div>		
         <%=lcl.GlobalResourceSet.GetString("ec_menu_grid_views") %>							
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

