<%@ Page Language="C#" AutoEventWireup="true"  Inherits="Workflow.NET.CodeBehind.Bam.ResourceWiseReport" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>

<!DOCTYPE HTML>
<html>
<head id="Head1" runat="server">
    <title>Resource Wise Report</title>
    <style type="text/css">
        html, body
        {
            height:98%;            
        }
    </style>
</head>
    <script type="text/javascript">
        function SaveLayout() {
            //var Url = 'BPMUITemplates/Default/BAM/SaveLayout.aspx';         
            var left = (screen.width / 2) - (320 / 2);
            var top = (screen.height / 2) - (185 / 2);
            var Url = 'SaveLayout.aspx';
            window.open(Url, 'LayoutSaving', 'height=185,width=340,resizable=no,scrollbars=no,status=no,top=' + top + ', left=' + left);
            //,'LayoutSaving', 'height=120,width=400,resizable=yes,scrollbars=no,status=no');
            //return false; 
        }
        function ExpandAll() {
            document.getElementById("IdExpand").click();
        }
        function CollapseAll() {
            document.getElementById("IdCollapse").click();
        }

        function SaveClick() {
            document.getElementById("_IdSaveBtn").click();
            var grid = ISGetObject("WebGrid1");
            grid.RefreshAll();
        }
        function DeleteLayout() {
            document.getElementById("_SelectedTreeNodeId").value = window.parent.document.getElementById("_idValue").value;
            document.getElementById("DeleteLayout_Button").click();
        }


        //Function to get the info about the edited row
        function EditMode(controlId, tblName, rowObject, xmlResponseObject) {
            var grid = ISGetObject(controlId);
            var dataMember = tblName;
            var newValue = rowObject.element.value;
            var RelNames = grid.GetSelectedObject().GetRowObject().RelNames;
            var User = null;
            var TypeOfWorkId = null;

            if (dataMember == "ChildTable") {
                TypeOfWorkId = RelNames.substring(35, 71);
                User = RelNames.substring(108);
                User = User.replace('</DataColumn></DataColumns>', '');
                User = User.replace('>', '');
                User = User.replace('<', '');

                grid.AddInput("dataMember", dataMember);
                grid.AddInput("newValue", newValue);
                grid.AddInput("TypeOfWorkId", TypeOfWorkId);
                grid.AddInput("User", User);
            }

            window.setTimeout("sendCstmReq()", 500);
            return true;
        }


        //Sending the values to ServerSide
        function sendCstmReq() {
            var grid = ISGetObject("WebGrid1");
            grid.SendCustomRequest();
        }

        function HideContextMenu(gridId, rowType, rowEl, rowMenu, location) {

            if (rowType != "Record") {
                if (rowType == "FilterRow") {
                    rowMenu.Items.GetNamedItem("mnuHelp").Hide();
                }

                if (rowType == "GroupHeader") //For GroupHeader context menu
                {
                    rowMenu.Items.GetNamedItem("mnuCopyRow").Hide();
                    rowMenu.Items.GetNamedItem("mnuSep3").Hide();
                    rowMenu.Items.GetNamedItem("mnuHelp").Hide();
                    rowMenu.Items.GetNamedItem("mnuSep9").Hide();
                }
                return true;
            }

            if (rowType == "Record") {
                // hide the default context menu
                for (i = 0; i <= 43; i++) {
                    rowMenu.Items[i].Hide();
                }


            }

        }


</script>
<body>
    <form id="form1" runat="server" style="height:100%;">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <link rel="stylesheet" type="text/css" href="<%=cssPath %>Common/StyleSheet/Global.css" />
        <table style="width:100%;height:5%">
            <tr>
                <td style="height:1%;width:60%" class="subtitle">
                    <span id="spResourceTooltip" runat="server" class="description"><%=DisplayString%></span> 
                    
                </td>
                <td style="height:1%;width:35%;text-align:right">
                     <asp:Label ID="lblDescription1" runat="server" Text="Label" CssClass="description" Visible="false" ></asp:Label>
                     
                    <asp:LinkButton ID="lnkBack" runat="server" OnClick="lnkBack_Click" CssClass="textlinkblue"></asp:LinkButton>

                </td>
                
                <td style="height:1%;vertical-align:top;">
                    <img src=" <%= cssPath %>BAM/images/expand.gif" style="cursor: hand" onclick="ExpandAll()"
                        title="<%=_ExpandAllToolTip%>" align="absmiddle" />
                    <asp:Button ID="IdExpand" runat="server" Text="Expand all Row" Style="display: none"
                        OnClick="IdExpand_Click" />
                </td>
                <td style="height:1%;text-align:right;vertical-align:top;">                   
                    <img src=" <%= cssPath %>BAM/images/collapse.gif" style="cursor: hand" onclick="CollapseAll()"
                        title="<%=_CollapseAllToolTip%>" align="absmiddle" />
                    <asp:Button ID="IdCollapse" runat="server" Text="Collapse all Row" Style="display: none"
                        OnClick="IdCollapse_Click" />
                </td>
                <%if (Request.QueryString["IR"] == null)
                        { if (_IsNotDrillDown)
                  { %>
                <%if (_IsShowDelete)
                  { %>
                <td style="height:1%;text-align:right;vertical-align:top;">
                    <img src="<%= cssPath %>BAM/images/delete_bam.gif" style="cursor: hand" onclick="DeleteLayout()"
                        hspace="10" align="absmiddle" />
                    <asp:Button ID="DeleteLayout_Button" runat="server" Text="DeleteLayout" Style="display: none"
                        OnClick="DeleteLayout_Click" />
                </td>
                <%}
                  else
                  { %>
                <td style="height:1%;vertical-align:top;">
                    <img src="<%= cssPath %>BAM/images/save-layout.gif" style="cursor: hand" hspace="10"
                        onclick="SaveLayout()" title="<%=_ImageToolTip%>" align="absmiddle" />
                    <input type="hidden" id="SaveLayOutId" name="SaveLayOut" />
                    <asp:Button OnClick="_IdSaveBtn_Click" Style="display: none" CssClass="inputbutton"
                        Text="Save Layout" runat="server" ID="_IdSaveBtn" />
                    <%} %>
                    <%} }%>
                    <input type="hidden" id="guidVal" name="guidVal" />
                </td>
            </tr>
        </table>
        <table style="width:100%;height:95%" border="0">   
            <tr>
            <td>
            <asp:Label ID="lblDateRange" runat="server" Text="Label" CssClass="description"></asp:Label>
            </td>
            </tr>                   
            <tr >
                <td style="width: 80%;text-align:justify">
                    
                    <asp:Label ID="lblUser" runat="server" CssClass="description"
                        Visible="False"></asp:Label>&nbsp;
                    <asp:DropDownList ID="ddlUser" runat="server" OnSelectedIndexChanged="ddlUser_SelectedIndexChanged"
                        AutoPostBack="true" Visible="false" CssClass="inputselect">
                    </asp:DropDownList>   
                 </td>                  
            </tr>
            <tr>
                <td style="height:93%;vertical-align:top;" >
                    <ISWebGrid:WebGrid ID="WebGrid1" runat="server" Height="100%" Width="100%" HorizontalAlign="NotSet"
                        ScriptDirectory="<%$ ReplaceTemplateExpn:InterSoft/Grid/CommonLibrary/WebGrid/V6_0_7200/ %>"
                        SharedScriptDirectory="<%$ ReplaceTemplateExpn:InterSoft/Grid/CommonLibrary/Shared/ %>"
                        OnInitializeDataSource="WebGrid1_InitializeDataSource" OnInitializeLayout="WebGrid1_InitializeLayout"
                        OnPrepareDataBinding="WebGrid1_PrepareDataBinding" OnInitializePostBack="WebGrid1_InitializePostBack"
                        OnExport="WebGrid1_Export" AllowAutoDataCaching="false" DisableFileSystemChecking="true"
                        EnableWebResources="never" WebDesktopScriptDirectory="../InterSoft/Grid/CommonLibrary/WebDesktop/V2_5_2007/">
                        <LayoutSettings AlternatingColors="True" CellPaddingDefault="2" GridLineColor="#afafaf"
                            AlwaysShowHelpButton="False" AllowFilter="Yes" AllowGrouping="Yes" GridLineStyle="Solid"
                            RowHeightDefault="23px" Hierarchical="True" ScriptDirectory="<%$ ReplaceTemplateExpn:InterSoft/Grid/CommonLibrary/WebGrid/V6_0_7200/ %>"
                            GridLines="Both" AllowColumnMove="Yes" AllowExport="Yes" AllowSelectColumns="Yes"
                            AllowSorting="Yes" FilterBarVisible="False" AutoHeight="False" AutoWidth="False"
                            Culture="English" PagingMode="VirtualLoad" VirtualLoadMode="LargeData" VirtualPageSize="50" RowHeaders="No">
                            <HeaderStyle Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CssClass="GridHeaderStyle"                                
                                CustomRules="border-bottom: #73A1E4 1px solid; -moz-boz-flex: 0" Wrap="False"></HeaderStyle>
                            <FocusCellStyle CssClass="GridFocusCellStyle" />                            
                       <GroupRowInfoStyle CssClass="GridGroupRowInfoStyle"></GroupRowInfoStyle> 
                        
                        <GroupByBox>
                            <LabelStyle CssClass="LeftMenuLabelStyle"></LabelStyle>
                            <Style CssClass="TableGray"></Style>
                        </GroupByBox>
                        <EditTextboxStyle  CssClass="LeftMenuEditStyle"></EditTextboxStyle>                        
                       <FrameStyle CssClass="GridFrameStyle">
                                </FrameStyle>
                        <SelectedRowStyle CssClass="GridSelectedRowStyle">
                        </SelectedRowStyle>
                         <AlternatingRowStyle  CssClass="GridAlternatingRowStyle" OverflowX="hidden" OverflowY="hidden"  CustomRules="text-overflow: ellipsis; overflow-x: hidden"></AlternatingRowStyle>
                           <StatusBarStyle CssClass="GridStatusBarStyle">
                                <Padding Bottom="2px" Left="2px" Right="2px" Top="2px" />
                            </StatusBarStyle>
                        <RowStyle  CssClass="GridRowStyle" CustomRules="text-overflow: clip;"
                           Overflow="Hidden" OverflowX="Hidden" OverflowY="Hidden" Wrap="False" />                            
                            <NewRowStyle CssClass="GridNewRowStyle"></NewRowStyle>                            
                            <EditFocusCellStyle CssClass="GridEditFocusCellStyle">
                            </EditFocusCellStyle>
                            <TextSettings Language="UseCulture">
                            </TextSettings>
                            <ClientSideEvents OnExitEditMode="EditMode" OnRowContextMenu="HideContextMenu" />
                    </LayoutSettings>
                        <RootTable GridLineStyle="NotSet" HeaderClickAction="SortSingle" AllowGrouping="Yes"
                            AllowSorting="Yes">
                        </RootTable>
                    </ISWebGrid:WebGrid>
                </td>
            </tr>
        </table>
        <input type="hidden" id="_SelectedTreeNodeId" name="_SelectedTreeNodeId" />
    </form>
    <script>
        document.getElementById("spResourceTooltip").title = "<%=lblDescription1.Text%>";
     </script>
</body>
</html>
