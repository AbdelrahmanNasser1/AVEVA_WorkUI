<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/BPMUITemplates/Default/Repository/Site/Html5MasterPage.master" Inherits="Skelta.Repository.CodeBehind.WebAPI.WebApiSourceListControl" %>

<asp:Content ID="ContentTitle" ContentPlaceHolderID="MenuTitle" runat="server"> 
    <div>		
        <%=GetLangSpecText("WebApiSource_List") %>				
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
