<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GridConfigurationListControl.aspx.cs" Inherits="BPMUITemplates_Default_Repository_Site_GridConfigurationListControl" MasterPageFile="~/BPMUITemplates/Default/Repository/Site/html5MasterPage.master" Debug="true"%>


<asp:Content ID="Content3" ContentPlaceHolderID="MenuTitle" runat="server"> 
    <div>		
         <%=lcl.GlobalResourceSet.GetString("ec_menu_grid_configuration") %>							
    </div>
</asp:Content>


<asp:Content ID="Content1" ContentPlaceHolderID="Cont" Runat="Server">
    <%--<link rel="stylesheet" href="../../NextGenForms/css/SkeltaForms.min.css" />
    <style>
        #scriptframe
        {
            width:100%;
            height:100%;
        }
    </style>--%>

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
        <div id="scriptFrameDiv" class="popuptemplate" style="z-index: 1000002; display: none;">
        <div class="skpopup_overlay"></div>
        <div class="skpopup_maindivPopupForm" style="height: 90%; width: 90%; margin: 0; top: 5%; left: 5%; min-width: 1000px !important;">
            <iframe id="scriptframe" data-sksw="0" style="border: none;"></iframe>
        </div>
    </div>

</asp:Content>

