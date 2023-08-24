<%@ Page Language="C#" MasterPageFile="~/BPMUITemplates/Default/Repository/Site/Html5MasterPage.master" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.ForwardWorkItem" %>
 

<asp:Content ID="Content3" ContentPlaceHolderID="MenuTitle" runat="server"> 
    <div>		        
        <%=GetLangSpecText("ec_menu_forward_workitem") %>							
    </div>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Cont" Runat="Server">
    <table style="width:100%;border-width:0;height:94%;border-spacing:0px;border-collapse:collapse;">
        <tr style="height:3%" class="ListHeaderCss">
            <td style="height:3%;vertical-align:middle;">
                &nbsp;&nbsp;<img alt="" src="<%=ThemePath%>Repository/Site/images/icon-manage-work-items.png" />
                <span class="fontheading" style="vertical-align:middle;display:inline-block;padding-bottom:17px;"><%=GetLangSpecText("ManageWorkItems")%></span>
            </td>
        </tr>
        <tr style="height:95%">
            <td style="vertical-align:top;text-align:center;height:100%" colspan="2" >
                <iframe id="WIframe" runat="Server" width="100%" height="100%" frameborder="0"  style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; BORDER-TOP-STYLE: none; PADDING-TOP: 0px; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BORDER-BOTTOM-STYLE: none;" scrolling="no"></iframe>
            </td>
        </tr>
    </table>

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



