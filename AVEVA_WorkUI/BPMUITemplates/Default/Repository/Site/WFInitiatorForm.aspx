<%@ Page Language="C#" MasterPageFile="~/BPMUITemplates/Default/Repository/Site/Html5MasterPage.master" AutoEventWireup="true" Inherits="Skelta.Forms.Web.CodeBehind.WorkflowInitiator" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>




<asp:Content ID="Content3" ContentPlaceHolderID="MenuTitle" runat="server">
    <div>
        <%=resourceManager.GetString("ec_wf_initiator") %>
    </div>
</asp:Content>


<asp:Content ID="Content1" ContentPlaceHolderID="Cont" runat="Server">
    <telerik:RadCodeBlock ID="radCodeBlock1" runat="server">
        <link rel="stylesheet" type="text/css" href="<%:ThemePath%>TelerikAjax/StyleSheet/AWTTreeView/TreeView.AWTTreeView.css"/>
    </telerik:RadCodeBlock>
    <script type="text/javascript">
        function OpenForm(url)
        {
            var width = (80 / 100) * screen.availWidth;
            var height = (80 / 100) * screen.availHeight;
            var left = (screen.availWidth / 2) - (width / 2);
            var top = (screen.availHeight / 2) - (height / 2);
            window.open(url, '', 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=yes, resizable=yes, copyhistory=no, left=' + left + ', top=' + top + ', height=' + height + ',width=' + width);
        }
    </script>
    <table style="width: 100%; height: 40px; vertical-align: middle; border-collapse: collapse; border-spacing: 0px;">
        <tr>
            <td style="width: 100%">
                <table style="width: 100%; border-collapse: collapse; border-spacing: 0px;">
                    <tr>
                        <td style="width: 20%; padding-left: 10px;">
                            <telerik:RadCodeBlock ID="radcodeblock2" runat="server">
                                <span class="pagetitle"><%=resourceManager.GetString("ec_wf_initiator")%></span>
                            </telerik:RadCodeBlock>
                        </td>
                        <td id="bcrumb"></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" Style="position: absolute; top: 40px; bottom: 0; left: 0; right: 0;">
        <div style="height: 100%; width: 100%; overflow: auto;">
            <table style="width: 100%; border-collapse: separate; border-spacing: 5px; height: 100%;">
                <tr>
                    <td style="height: 100%; width: 100%; padding: 5px;">
                        <asp:Panel ID="PanelForm" runat="server" Height="100%" ScrollBars="Auto">
                            <asp:Label ID="label1" Style="margin-left: 5px" CssClass="description" runat="server" Text=""></asp:Label>
                        </asp:Panel>
                    </td>
                </tr>
            </table>
        </div>
    </telerik:RadAjaxPanel>

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
