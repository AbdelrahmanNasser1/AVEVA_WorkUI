<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.ListDocumentView.DocumentViewUserControl" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<telerik:RadTabStrip RenderMode="Classic" runat="server" ID="ListDocumentViewTabStrip" Skin="AWTTabStrip" EnableEmbeddedSkins="false" SelectedIndex="0" Height="27px" Width="100%"
    MultiPageID="ListDocumentViewMultiPageView" EnableViewState="false" CausesValidation="false">
    <Tabs>
        <telerik:RadTab Text="" ID="GeneralTab"  Width="150" PageViewID="GeneralPage">
        </telerik:RadTab>
        <telerik:RadTab Text="" ID="ItemSpecificTab" Width="150" PageViewID="ItemSpecificPage">
        </telerik:RadTab>
    </Tabs>
</telerik:RadTabStrip>
<telerik:RadMultiPage ID="ListDocumentViewMultiPageView" runat="server" SelectedIndex="0">
    <telerik:RadPageView ID="GeneralPage" runat="server" Height="100%">
        <asp:Panel ID="pnlGeneral" runat="server">
        </asp:Panel>
    </telerik:RadPageView>
    <telerik:RadPageView Height="100%" ID="ItemSpecificPage" runat="server">
        <asp:Panel ID="pnlListSpecific" runat="server" BorderWidth="0" Height="900px">
        </asp:Panel>
    </telerik:RadPageView>
</telerik:RadMultiPage>
