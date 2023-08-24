<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Forms.Web.CodeBehind.CreateList.BPMUITemplates_Default_Repository_Site_CreateDListErrorPage" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>

<!DOCTYPE html>
<html >
<head runat="server">
    <title><%=pageTitle %></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    
</head>
<body style="height: 100%; width: 100%; font-size: 9px; border: none; margin: 0px 0px 0px 0px;
    overflow-y:hidden;" >

    <script language="javascript" type="text/javascript">
    var IsListValidation='<%=IsListValidation%>';
    function closeWindow()
    {
        var oWindow = null;
        if(window.frameElement!=null)
            oWindow = window.frameElement.radWindow;
      
        if (oWindow != null)
        {
            oWindow.close(); // it is a rad window opened form the List      
            if (IsListValidation != 'yes')
                window.parent.close();
        }
        else
        {
            window.close();
        }
    }
    
    function OnInitialize(gridId)
    {
        var grid = wgGetGridById(gridId);
        grid.HidePadColumn = true; 
    }


    </script>

    <form id="form1" runat="server" >
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css"/>
        <%if (ErrorType < 2)
       {%>
        <div style="padding:20px; padding-top:20px;" >
        
                    <asp:Label ID="Label1" runat="server" Text="Label" cssclass="errormsg"></asp:Label>             
            
            
        </div>
        <%} %>
        <%if (ErrorType == 2)
       {%>
        <div style="overflow-y:hidden;overflow:hidden">
            <table width="95%" align="center" height="90%" border=0>
                <tr height="10%">
                    <td>
                        <img src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>Repository/Site/images/error.gif" width="30" height="30"
                            align="absmiddle" />
                        <asp:Label ID="lblError1" runat="server" Text="Label" CssClass="errormsg"></asp:Label><br>
                        <br>
                    </td>
                </tr>
                <tr height="80%">
                    <td>
                        <iswebgrid:webgrid id="WGrdValidateList" runat="server" height="330px" horizontalalign="NotSet"
                            width="100%" oninitializedatasource="WGrdValidateList_InitializeDataSource" allowautodatacaching="false"
                            disablefilesystemchecking="true" enablewebresources="Never">
                            <RootTable GridLineStyle="NotSet" Caption="List">
                            </RootTable>
                            <LayoutSettings AlternatingColors="True" PagingMode="VirtualLoad"
                                VirtualLoadMode="Custom" FilterBarVisible="false" AllowFilter="Yes" GridLineStyle="Solid"
                                GridLineColor="#afafaf" CellPaddingDefault="1" RowHeightDefault="20px" GridLines="None"
                                VirtualPageSize="20" AutoFitColumns="true"  RowHeaders="No"
                                AllowSorting="no" AllowColumnSizing="Yes" AlwaysShowHelpButton="false" AllowContextMenu="false" ShowRefreshButton="false" >
                                <HeaderStyle CssClass="GridHeaderStyle" ></HeaderStyle>
                                <ClientSideEvents OnInitialize="OnInitialize" ></ClientSideEvents>
                                <FocusCellStyle CssClass="GridFocusCellStyle" />
                                <PreviewRowStyle ForeColor="#0000C0">
                                </PreviewRowStyle>
                                <StatusBarCommandStyle>
                                    <Active BackColor="RoyalBlue" BaseStyle="Over">
                                    </Active>
                                    <Over BackColor="CornflowerBlue" BorderColor="Navy" BorderStyle="Solid" BorderWidth="1px">
                                    </Over>
                                    <Normal>
                                        <Padding Bottom="1px" Left="1px" Right="1px" Top="1px" />
                                    </Normal>
                                </StatusBarCommandStyle>
                                <GroupRowInfoStyle CssClass="GroupRowInfoStyle"
                                                        BackgroundImage="<%$ ReplaceTemplateExpn:hws/Images/ColBk.gif%>"
                                                        CustomRules="border-bottom: #73A1E4 1px solid">
                                                    </GroupRowInfoStyle>
                                <GroupByBox>
                                    <LabelStyle BackColor="White" BorderColor="Navy" BorderStyle="Solid" BorderWidth="1px"
                                        Font-Names="Verdana" Font-Size="8pt" />
                                    <Style BackColor="Gray"></Style>
                                </GroupByBox>
                                <EditTextboxStyle BorderStyle="None" BorderWidth="0px" Font-Names="Verdana" Font-Size="8pt">
                                </EditTextboxStyle>
                                <FrameStyle CssClass="GridFrameStyle"></FrameStyle>
                                <SelectedRowStyle CssClass="GridSelectedRowStyle"></SelectedRowStyle>
                                <StatusBarStyle CssClass="GridStatusBarStyle">
                                                        <Padding Top="2px" Left="2px" Bottom="2px" Right="2px"></Padding>
                                                    </StatusBarStyle>
                                <RowStyle CustomRules="text-overflow: ellipsis; overflow-x: hidden" CssClass="GridRowStyle">
                                                    </RowStyle>
                                                    <NewRowStyle CssClass="GridNewRowStyle">
                                                    </NewRowStyle>
                                
                                <TextSettings Language="UseCulture">
                                </TextSettings>
                                <AlternatingRowStyle CssClass="GridAlternatingRowStyle" />
                            </LayoutSettings>
                        </iswebgrid:webgrid>
                    </td>
                </tr>
            </table>
        </div>
        <%} %>
        <table width="95%" height="10%" align="center" border="0" style="padding-top:20px">
            <tr>
                <td style="text-align:right;padding-right:10px">
                    <asp:Button ID="Cancel" runat="server" Text="Close" OnClientClick="javascript:closeWindow(false);return false;"
                        CssClass="inputbutton" />
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
