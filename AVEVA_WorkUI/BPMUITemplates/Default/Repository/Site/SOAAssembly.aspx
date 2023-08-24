<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/BPMUITemplates/Default/Repository/Site/Html5MasterPage.master"  Inherits="Skelta.SOA.CodeBehind.Repository.SOAAssembly" %>
<%@ Register Assembly="Skelta.Repository.Web" Namespace="Skelta.Repository.Web" TagPrefix="cc1" %>


<asp:Content ID="Content3" ContentPlaceHolderID="MenuTitle" runat="server"> 
    <div>		
       <%=ListControl1.GlobalResourceSet.GetString("ec_soa_assembly") %>					
    </div>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Cont" Runat="Server">
    <cc1:PagCrumbs ID="pageCrumb" runat="server" />
    <cc1:ListControl ID="ListControl1" Height=100% runat="server" HeaderControlPath="/Repository/ListControl/ListHeader.ascx" MenuControlPath="/Repository/ListControl/SOAAssemblyListRibbonBar.ascx" VersionMenuControlPath="/Repository/ListControl/VersioningRibbonBar.ascx" ShowAllStandardColumns="true"/>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=templateThemeDirectory %>CommonUXControls/StyleSheet/se.ui.min.css" />      
     <script>

        try
        {
            document.getElementById("tblMain").style.display = "none";

        }
        catch (ex) {

        }

    </script>
</asp:Content>
