<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/BPMUITemplates/Default/Repository/Site/HTML5MasterPage.master" CodeFile="Filewatcherfolder.aspx.cs" Inherits="BPMUITemplates_Default_Repository_Site_Filewatcherfolder" Debug="true"%>
<%@ Register Assembly="Skelta.Repository.Web" Namespace="Skelta.Repository.Web" TagPrefix="cc1" %>

<asp:Content ID="Content3" ContentPlaceHolderID="MenuTitle" runat="server"> 
    <div>	        
        <%=ListControl1.GlobalResourceSet.GetString("ec_menu_filewatcher") %>						
    </div>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Cont" Runat="Server">
    <cc1:PagCrumbs ID="pageCrumb" runat="server" />
    <cc1:ListControl ID="ListControl1" runat="server" Height="100%" HeaderControlPath="/Repository/ListControl/ListHeader.ascx" MenuControlPath="/Repository/ListControl/FileWatcherFolderRibbonBar.ascx" VersionMenuControlPath="/Repository/ListControl/VersioningRibbonBar.ascx" ShowAllStandardColumns="true"/>
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
