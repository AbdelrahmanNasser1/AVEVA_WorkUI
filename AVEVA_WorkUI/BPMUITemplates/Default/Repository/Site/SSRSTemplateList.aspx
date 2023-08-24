<%@ Page Language="C#" Trace="false" AutoEventWireup="true" Debug="true" Inherits="Skelta.SSRS.Connector.TemplateList" MasterPageFile="~/BPMUITemplates/Default/Repository/Site/HTML5MasterPage.master" Title="Templates"%>

<asp:Content ID="Content3" ContentPlaceHolderID="MenuTitle" runat="server"> 
    <div>		
       <%=listControl1.GlobalResourceSet.GetString("ec_menu_ssrs_template") %>					
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
        catch (ex) {

        }

    </script>
</asp:Content>
	
	


