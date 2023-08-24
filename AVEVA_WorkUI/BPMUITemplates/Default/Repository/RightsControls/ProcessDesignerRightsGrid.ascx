<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.ProcessDesignerRightsGrid" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<telerik:RadScriptManager ID="RadScriptManager1" runat="server" />
<telerik:RadTreeView  ID="RadTreeView1" runat="server" CheckBoxes="True" Skin="AWTTreeView" OnClientNodeChecked="AfterCheck" RenderMode="Classic" EnableEmbeddedSkins="false" ShowLineImages="false">
</telerik:RadTreeView>
