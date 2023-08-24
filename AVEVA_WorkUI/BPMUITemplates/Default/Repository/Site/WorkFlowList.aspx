<%@ Page Language="C#" MasterPageFile="~/BPMUITemplates/Default/Repository/Site/Html5MasterPage.master" AutoEventWireup="true"  Inherits="Skelta.Repository.Web.CodeBehind.WorkFlowList" Title="Untitled Page" %>
<%@ Register Assembly="Skelta.Repository.Web" Namespace="Skelta.Repository.Web" TagPrefix="cc1" %>

<asp:Content ID="Content3" ContentPlaceHolderID="MenuTitle" runat="server"> 
    <div>		
       <%=ListControl1.GlobalResourceSet.GetString("ec_menu_Workflows") %>					
    </div>
</asp:Content>


<asp:Content ID="Content1" ContentPlaceHolderID="Cont" runat="Server">       

    <cc1:PagCrumbs ID="pageCrumb" runat="server" />
    <cc1:ListControl ID="ListControl1" runat="server" Height=100% HeaderControlPath="/Repository/ListControl/ListHeader.ascx" MenuControlPath="/Repository/ListControl/WorkflowRibbonBar.ascx" VersionMenuControlPath="/Repository/ListControl/VersioningRibbonBar.ascx" ShowAllStandardColumns="true"/>     

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

