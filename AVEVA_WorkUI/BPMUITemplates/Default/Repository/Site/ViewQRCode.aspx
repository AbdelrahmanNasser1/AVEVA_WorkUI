<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.ViewQrCode" Title="" %>

<!DOCTYPE HTML>
<link href="<%=ThemePath%>Common/StyleSheet/Global.css" rel="stylesheet" />
    <form id="form1" runat="server" style="margin:0em">
         <%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <table style="width:100%;height:35px;vertical-align:middle;">
        <tr class="ListHeaderCss">            
            <td style="width:96%">
                <table style="width:100%;border-collapse:separate;margin-top:10px;">
                    <tr>                        
                        <td class="fontheading" style="display:table-cell; vertical-align:middle; text-align:center">
                          <asp:Image id="ImageControl" runat="server"/>
                        </td>                        
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <div id="divF" style="overflow: hidden">
        <table style="width: 100%; border-width: 0" >
            <tr>               
                <td style="text-align:right; padding-right:15px;" id="tdViewSubmit" runat="server">                    
                    <asp:Button ID="DownloadButton" runat="server" CssClass="inputbutton"/>
                </td>
            </tr>
        </table>
    </div>
	</form>
