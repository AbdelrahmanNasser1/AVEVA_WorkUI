<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.Lookup.UserLookupUserControl" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
<link href="<%=userLookupWebControl.GetCommonRelativeUrl("StyleSheet/Global.css")%>"  rel="stylesheet" type="text/css">
</telerik:RadScriptBlock>

<div style="padding-left:10px;padding-top:10px;padding-right:10px;padding-bottom:1px;">
    <table style="width:100%;border-spacing:0px;border-collapse:separate;" >
        <tr>
            <td style="vertical-align:bottom;height:20px;padding:3px;">
                <table style="width:100%;border-collapse:collapse;border-spacing:0px;">
                    <tr>
                        <td>
                            <table style="width:100%;border-collapse:collapse;border-spacing:0px;">
                                <tr>
                                    <td class="subtitle" style="width:40%">
                                         <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
                                        <img style="vertical-align:middle;border:0px;"  src="<%=ThemePath%>/Repository/ListControl/images/icons-ribbon/icon-users-list.png" />
                                        <%=strLookupheaderText %>
                                             </telerik:RadCodeBlock>
                                    </td>
                                    <td style="width:60%">
                                        <asp:Label ID="lblDisplayError" runat="server" CssClass="errormsg "></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
				    <tr>
				        <td>
				            <table style="width:100%;border-collapse:collapse;border-spacing:0px;">
				                <tr>
                                    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
                                    <td class="description" style="height:25px">
                                         
                                        <%=strLookupDescText %>
                                           
                                    </td>
                                     
                                    <td class="description" style="display:<%=strProviderOptionDisplay%>;text-align:right;">                                        
                                        <asp:DropDownList ID="ddlProvider" runat="server" Width="190px" CssClass="inputselect" AutoPostBack="true" onmouseover="if (this.title!=this.options[this.selectedIndex].title) this.title=this.options[this.selectedIndex].title;" OnSelectedIndexChanged="ddlProvider_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                    
                                     </telerik:RadCodeBlock> 
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="padding:3px;">
                <table style="width:100%;border-collapse:separate;border-spacing:1px;" class="tablebg">
                    <tr>
                        <td>
                            <table style="width:100%;border-spacing:0px;border-collapse:collapse;" class="tablebg">
                                <tr>
                                    <td class="lefttdbg" style="width:100%;padding:2px;">
                                        <table style="width:100%;border-collapse:collapse;border-spacing:0px;">
                                            <tr>
                                                <td style="width:65px">
                                                    <span class="description">
                                                         <telerik:RadCodeBlock ID="RadCodeBlock3" runat="server">
                                                        <%=strSearchFor%>
                                                             </telerik:RadCodeBlock>
                                                    </span>
                                                </td>
                                                <td style="width:160px">
                                                     <asp:TextBox ID="txtName" runat="Server" CssClass="inputtext" Width="160px"></asp:TextBox>
                                                </td>
                                                <td style="width:45px;text-align:center;">
                                                    <span class="description">
                                                         <telerik:RadCodeBlock ID="RadCodeBlock4" runat="server">
                                                        <%=strDisInText %>
                                                             </telerik:RadCodeBlock>
                                                    </span>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td class="lefttdbg" style="text-align:left;padding:2px;">
                                        <asp:DropDownList ID="ddlResprop" runat="server" Width="135px" onmouseover="if (this.title!=this.options[this.selectedIndex].title) this.title=this.options[this.selectedIndex].title;" CssClass="inputselect">
                                        </asp:DropDownList>
                                    </td>
                                    <td class="lefttdbg" style="text-align:right;padding:2px;">
                                         <telerik:RadCodeBlock ID="RadCodeBlock5" runat="server">
                                        <asp:Button runat="server" Text="<%=strSearchButtontext %>" CssClass="inputbutton" ID="btnSearch" OnClick="btnSearch_Click" />
                                             </telerik:RadCodeBlock>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <table style="width:100%;border-collapse:collapse;border-spacing:0px;">
                    <tr>
                        <td style="height: 10px">
                        </td>
                    </tr>
                </table>
                <table style="width:100%;border-collapse:separate;border-spacing:1px;" class="tablebg">
                    <tr>
                        <td class="lefttdbg" style="text-align:center;padding:4px;">
                            <table style="width:100%;border-collapse:collapse;border-spacing:0px;">
                                <tr>
                                    <td style="text-align:left;padding-left:13px;" >
                                        <span class="description">
                                             <telerik:RadCodeBlock ID="RadCodeBlock6" runat="server">
                                            <%=strAvailableResources%>
                                                 </telerik:RadCodeBlock>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <div id="divlistUser" style="height: 181px; width: 240px; overflow:auto; border:1px solid;">
                                            <asp:ListBox SelectionMode="Multiple" runat="Server" style="overflow:hidden !important; border:0px none !important; min-width:100%; min-height:100%;max-width:none;" ID="lstselres" CssClass="inputlistbox">
                                            </asp:ListBox>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td class="lefttdbg" style="text-align:center;width:50px;">
                            <table style="width:100%;margin:0px auto;border-collapse:collapse;border-spacing:0px;">
                                <tr>
                                    <td style="padding:1px;text-align:center;" >
                                        <asp:Button runat="server" Text=" > " Width="36" CssClass="lookupnavigationbutton" ID="btnMoveright"
                                            OnClick="btnright_Click" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding:1px;text-align:center;" >
                                        <asp:Button runat="server" Text=" >> " Width="36" CssClass="lookupnavigationbutton" ID="btnMoveAllRight"
                                            OnClick="btnmoveallright_Click" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 15px;padding:1px;">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding:1px;text-align:center;" >
                                        <asp:Button runat="server" CssClass="lookupnavigationbutton" ID="btnMoveLeft" Text=" < "
                                            Width="36" OnClick="btnleft_Click" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding:1px;text-align:center;" >
                                        <asp:Button runat="server" CssClass="lookupnavigationbutton" ID="btnMoveAllLeft" Text=" << "
                                            Width="36" OnClick="btnmoveallleft_Click" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td class="lefttdbg" style="padding:1px;text-align:center;" >
                            <table style="width:100%;border-collapse:collapse;border-spacing:0px;">
                                <tr>
                                    <td style="padding-left:13px;text-align:left;" >
                                        <span class="description">
                                             <telerik:RadCodeBlock ID="RadCodeBlock7" runat="server">
                                            <%=strSelectedResources%>
                                                 </telerik:RadCodeBlock>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <div id="divselectedUser" style="height: 181px; width: 240px; overflow:auto; border:1px solid;">
                                            <asp:ListBox SelectionMode="Multiple" runat="Server" style="overflow:hidden !important; border:0px none !important; min-width:100%; min-height:100%;max-width:none;" ID="lstselectedres" CssClass="inputlistbox">
                                            </asp:ListBox>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnSearch"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="lblDisplayError"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="lstselres" UpdatePanelHeight="100%"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="lstselectedres" UpdatePanelHeight="100%"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnMoveright">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lstselectedres"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnMoveAllRight">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lstselectedres"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnMoveLeft">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lstselectedres"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnMoveAllLeft">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lstselectedres"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="ddlProvider">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="ddlResprop"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
</div>
    
 <telerik:RadCodeBlock ID="RadCodeBlock8" runat="server">
<script src="<%=Workflow.NET.CommonFunctions.GetJSReferencePath()%>Common/JavaScripts/jquery.min.js"></script>
<script src="<%=Workflow.NET.CommonFunctions.GetJSReferencePath()%>Common/JavaScripts/AutoLogoff.js"></script>
</telerik:RadCodeBlock>

<telerik:RadScriptBlock ID="radsc1" runat="server">
<script language="javascript">

    SetLHSHeight();

    SetRHSHeight();

    function SetLHSHeight()
    {
        SetListBoxSize('<%=lstselres.ClientID%>');
    }

    function SetRHSHeight()
    {
        SetListBoxSize('<%=lstselectedres.ClientID%>');
    }

    function SetListBoxSize(listBoxElementId)
    {
        var lstAvailableNames = document.getElementById(listBoxElementId);

        if (lstAvailableNames != null)
        {
            if (lstAvailableNames.offsetHeight < lstAvailableNames.scrollHeight) // consider only when not equal, because we add 1px for rounding related issues.
            {
                lstAvailableNames.style.height = (lstAvailableNames.scrollHeight + 1) + "px"; // 1px added for rounding related issues.
            }
        }
    }

</script>
</telerik:RadScriptBlock>
