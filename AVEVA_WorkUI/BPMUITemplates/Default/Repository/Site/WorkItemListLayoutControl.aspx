<%@ Page Language="C#" MasterPageFile="~/BPMUITemplates/Default/Repository/Site/HTML5MasterPage.master" AutoEventWireup="true" CodeFile="WorkItemListLayoutControl.aspx.cs" Inherits="SkeltaTemplates_Default_WorkItemList_T" Theme="" StylesheetTheme=""  %>


<asp:Content ID="Content3" ContentPlaceHolderID="MenuTitle" runat="server"> 
    <div>		
       <%=resManager.GlobalResourceSet.GetString("ec_menu_workitem_layout") %>				
    </div>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Cont" Runat="Server">
    <table border=0 style="height:100%;width:100%;vertical-align:top;" >
    <tr style="height:100%;width:100%;">
    <td style="text-align:left;vertical-align:top;height:100%;width:100%;" >
    <asp:Panel BackColor="transparent" ID="PanelWorkItemListLayout" runat="server" Height="100%" Width="100%" CssClass="panelWorkItems"  ></asp:Panel>
    </td>    
    </tr>    
    </table>  

    
     <script>

         try {
             document.getElementById("tblMain").style.display = "none";

         }
         catch (ex) {

         }

    </script>
</asp:Content>
