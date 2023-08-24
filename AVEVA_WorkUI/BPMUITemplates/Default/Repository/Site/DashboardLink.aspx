<%@ Page Language="C#" Inherits="Skelta.Repository.Web.CodeBehind.DashboardLink" MasterPageFile="~/BPMUITemplates/Default/Repository/Site/Html5MasterPage.master" AutoEventWireup="true" Title="Untitled Page" %>

<asp:Content ID="Content3" ContentPlaceHolderID="MenuTitle" runat="server">
    <div>        
        <%=ResourceManager.GlobalResourceSet.GetString("ec_menu_DashboardLink") %>
    </div>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Cont" runat="Server">
    <script type="text/javascript" src="../../Common/JavaScripts/spin.min.js"></script>
    <script type="text/javascript" src="../../NextGenForms/js/jquery.min.js"></script>
    <script type="text/javascript" src="../../NextGenForms/js/knockout.min.js"></script>
    <script type="text/javascript" src="../../NextGenForms/js/xml2json.min.js"></script>
    <script type="text/javascript" src="../../NextGenForms/app/Skelta.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" href="../../NextGenForms/css/DashboardLink.css" />
    <script>
        try {
            document.getElementById("tblMain").style.display = "none";
        }
        catch (ex) {

        }
    </script>
	    
	<tab></tab>
	<script type="text/javascript" src="../../Repository/Site/Scripts/DashboardLink.js"></script>
</asp:Content>
