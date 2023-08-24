<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.Forms.Web.CodeBehind.ListStructureUserControl" %>
<%@ Register Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" TagPrefix="telerik" %>

    <link rel="stylesheet" type="text/css" href="<%:commonCssPath%>TelerikAjax/StyleSheet/AWTTreeView/TreeView.AWTTreeView.css"/>

    <div style="width: 100%; height: 100%; overflow: auto;">
        <table style="width: 100%; height: 100%;">
            <tr id="trIgnoreBlankXml" runat="server">
                <td style="width: 70%" align="right" class="sf-subformtitle">
                    <%= resManager.GlobalResourceSet.GetString("ListStructureMessage1Text") %>
                </td>
                <td align="left" style="width: 30%">
                    <asp:RadioButtonList ID="rblIgnoreBlank" AutoPostBack="true" CssClass="sf-radiobuttongroup" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Selected="True" Text="Yes" Value="Yes">                            
                        </asp:ListItem>
                        <asp:ListItem Text="No" Value="No">                            
                        </asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td style="width: 100%;" colspan="2">
                    <telerik:RadTreeView ID="TreeViewListStructure" Width="100%" Height="380px" style="overflow:auto"
						Skin="AWTTreeView"	EnableEmbeddedSkins="false" RenderMode="Classic" ShowLineImages="false"
                        EnableViewState="true" runat="server">
                    </telerik:RadTreeView>
                </td>
            </tr>
            <tr>
                <td style="text-align:right;padding-top:5px;padding-right:10px;" colspan="2">
                    <asp:Button ID="btnCancel" Text="Close" CssClass="inputsecondarybutton" OnClientClick="javascript:window.close();" runat="server" />
                    <asp:Button ID="btnExport" Text="Export" CssClass="sf-inputsBox" runat="server" />
                </td>
            </tr>
        </table>
    </div>

