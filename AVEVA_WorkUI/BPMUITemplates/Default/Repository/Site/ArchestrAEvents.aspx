<%@ Page Language="C#" AutoEventWireup="true"  Inherits="Skelta.BPM.ArchestrAEvents.CodeBehind.ArchestrAEventList" %>
<%@ Register Assembly="Skelta.Repository.Web" Namespace="Skelta.Repository.Web" TagPrefix="cc1" %>

<asp:Content ID="Content3" ContentPlaceHolderID="MenuTitle" runat="server"> 
    <div>		       
       <%=listControl.GlobalResourceSet.GetString("ec_menu_ArchestraEvents") %>			
    </div>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Cont" runat="Server">
    <cc1:PagCrumbs ID="pageCrumb" runat="server" />
    <cc1:ListControl ID="listControl" runat="server" Height="100%" HeaderControlPath="/Repository/ListControl/ListHeader.ascx" MenuControlPath="/Repository/ListControl/ArchestrAEventsListRibbonbar.ascx" VersionMenuControlPath="/Repository/ListControl/VersioningRibbonBar.ascx"/>

    <script>

        try {
            document.getElementById("tblMain").style.display = "none";

        }
        catch (ex) {

        }

    </script>
</asp:Content>