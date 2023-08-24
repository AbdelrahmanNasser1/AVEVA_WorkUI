<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/BPMUITemplates/Default/Repository/Site/Html5MasterPage.master" Inherits="Skelta.SOA.CodeBehind.Repository.SOAFolders" %>
<%@ Register Assembly="Skelta.Repository.Web" Namespace="Skelta.Repository.Web" TagPrefix="cc1" %>


<asp:Content ID="Content3" ContentPlaceHolderID="MenuTitle" runat="server"> 
    <div>		
       <%=ListControl1.GlobalResourceSet.GetString("ec_soa_folder") %>					
    </div>
</asp:Content>



<asp:Content ID="Content1" ContentPlaceHolderID="Cont" Runat="Server">
    <cc1:PagCrumbs ID="pageCrumb" runat="server" />
    <cc1:ListControl ID="ListControl1" runat="server" HeaderControlPath="/Repository/ListControl/ListHeader.ascx" height="100%" MenuControlPath="/Repository/ListControl/SOAFolderRibbonBar.ascx" VersionMenuControlPath="/Repository/ListControl/VersioningRibbonBar.ascx" ShowAllStandardColumns="true"/>

    <script>

        try {
            document.getElementById("tblMain").style.display = "none";

        }
        catch (ex) {

        }

    </script>
</asp:Content>
