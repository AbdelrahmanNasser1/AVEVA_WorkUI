<%@ Page Language="C#" AutoEventWireup="true"  Inherits="Workflow.NET.CodeBehind.Bam.LatestWorkAnalysis" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>

<!DOCTYPE HTML>


<html >
<head id="Head1" runat="server">
    <title>Work Analysis Report</title>
    <style type="text/css">
        html, body
        {
            height:98%;
        }
</style> 
</head>
<body>
    <script language="javascript">
        function SaveLayout() {
            //var Url = 'BPMUITemplates/Default/BAM/SaveLayout.aspx';         
            var left = (screen.width / 2) - (320 / 2);
            var top = (screen.height / 2) - (185 / 2);
            var Url = 'SaveLayout.aspx';
            window.open(Url, 'LayoutSaving', 'height=185,width=340,resizable=no,scrollbars=no,status=no,top=' + top + ', left=' + left);
            //,'LayoutSaving', 'height=120,width=400,resizable=yes,scrollbars=no,status=no');
            // return false; 
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

        //Function to get the info about the edited column
        function EditMode(controlId, tblName, rowObject, xmlResponseObject) {
            var grid = ISGetObject(controlId);
            var dataMember = tblName;
            var newValue = rowObject.element.value;
            var RelNames = grid.GetSelectedObject().GetRowObject().RelNames;
            var User = null;
            var TypeOfWorkId = null;

            if (dataMember == "ParentTable") {
                TypeOfWorkId = RelNames.substring(35, 71);

                grid.AddInput("dataMember", dataMember);
                grid.AddInput("newValue", newValue);
                grid.AddInput("TypeOfWorkId", TypeOfWorkId);
            }
            else {
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

        //To send the data to the Server Side  
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
    <form id="form1" runat="server" style="height:100%;">
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <link rel="stylesheet" type="text/css" href="<%=cssPath %>Common/StyleSheet/Global.css" />
       
         <table style="width:100%;height:5%;" >
            <tr>      
                <td style="height:5%;width:93%;vertical-align:top;" class="subtitle">                  
                    <%=DisplayString%>
                    &nbsp;
                </td>        
                <td style="height:5%;vertical-align:top;width:2%;">
                    <img src=" <%= cssPath %>BAM/images/expand.gif" style="cursor: hand" onclick="ExpandAll()"
                        title="<%=_ExpandAllToolTip%>" align="absmiddle" />
                    <asp:Button ID="IdExpand" runat="server" Text="Expand all Row" Style="display:none" OnClick="IdExpand_Click" />
                </td>
                <td style="height:5%;vertical-align:top;width:2%;">                   
                    <img src="<%= cssPath %>BAM/images/collapse.gif" style="cursor: hand"
                        onclick="CollapseAll()" title="<%=_CollapseAllToolTip%>" align="absmiddle" />
                    <asp:Button ID="IdCollapse" runat="server" Text="Collapse all Row" Style="display:none" OnClick="IdCollapse_Click" />
                </td>                                
                     <%if (Request.QueryString["IR"] == null)
                        { if (_IsShowDelete)
                       { %>
                         <td style="height:5%;text-align:left;vertical-align:middle;width:2%;" >
                         <img src="<%= cssPath %>BAM/images/delete_bam.gif" style="cursor:hand"  hspace="10" onclick="DeleteLayout()"  align="absmiddle" />
                         <asp:Button ID="DeleteLayout_Button" runat=server Text="DeleteLayout" style="display:none"  OnClick="DeleteLayout_Click" /> 
                         </td>                         
                     <%}
                       else
                       { %>
                         <td style="height:5%;text-align:left;vertical-align:middle;width:2%;">
                        <img src="<%= cssPath %>BAM/images/save-layout.gif" style="cursor: hand"
                            hspace="10" onclick="SaveLayout()" title="<%=_ImageToolTip%>" align="absmiddle" />
                        <input type="hidden" id="SaveLayOutId" name="SaveLayOut" />
                        <asp:Button OnClick="_IdSaveBtn_Click" Style="display:none" CssClass="inputbutton"
                            Text="Save Layout" runat="server" ID="_IdSaveBtn" />
                    <%} }%>
                     
                    <input type="hidden" id="guidVal" name="guidVal" />
                </td>         
            </tr>
        </table>

        

        <table style="width:100%;height:95%;background-color: white">
             <tr>
                <td style="width:700px;text-align:left;background-color:white;height:2%;">
                    <table style="border-collapse:separate;border-spacing:2px;width:100%;" >
                        <tr>
                            <td>
                                <asp:Label ID="lblDescription1" runat="server" Text="Label" CssClass="description"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblDateRange" runat="server" Text="Label" CssClass="description"></asp:Label>
                            </td>
                        </tr>
                    </table>    
                </td>
            </tr>
            <tr>
                <td style="height:92%">
                    <ISWebGrid:WebGrid ID="WebGrid1" runat="server" Height="100%" Width="100%" HorizontalAlign="NotSet"
                        ScriptDirectory="<%$ ReplaceTemplateExpn:InterSoft/Grid/CommonLibrary/WebGrid/V6_0_7200/ %>"
                        SharedScriptDirectory="<%$ ReplaceTemplateExpn:InterSoft/Grid/CommonLibrary/Shared/ %>"
                        OnInitializeDataSource="WebGrid1_InitializeDataSource" OnInitializeLayout="WebGrid1_InitializeLayout" OnPrepareDataBinding="WebGrid1_PrepareDataBinding"  OnInitializePostBack="WebGrid1_InitializePostBack" AllowAutoDataCaching="false" OnExport="WebGrid1_Export" DisableFileSystemChecking="true" EnableWebResources="never" WebDesktopScriptDirectory="../InterSoft/Grid/CommonLibrary/WebDesktop/V2_5_2007/" >
                        <LayoutSettings AlternatingColors="True" CellPaddingDefault="2" GridLineColor="#afafaf"
                            AlwaysShowHelpButton="False" AllowFilter="Yes" AllowGrouping="Yes" GridLineStyle="Solid"
                            RowHeightDefault="23px" Hierarchical="True" ScriptDirectory="<%$ ReplaceTemplateExpn:InterSoft/Grid/CommonLibrary/WebGrid/V6_0_7200/ %>"
                            GridLines="None" AllowColumnMove="Yes" AllowExport="Yes" AllowSelectColumns="Yes"
                            AllowSorting="Yes" FilterBarVisible="False" AutoHeight="false"
                            AutoWidth="false" AllowEdit="Yes" PagingMode="VirtualLoad" VirtualLoadMode="LargeData" VirtualPageSize="50" RowHeaders="No">
                            <HeaderStyle Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CssClass="GridHeaderStyle" CustomRules="border-bottom: #73A1E4 1px solid; -moz-boz-flex: 0" Wrap="False">
                            </HeaderStyle>
                            <FocusCellStyle BorderColor="0, 45, 150" BorderStyle="Solid" BorderWidth="1px" />
                           <StatusBarStyle CssClass="GridStatusBarStyle">
                                             <Padding Top="2px" Left="2px" Bottom="2px" Right="2px"></Padding>
                                         </StatusBarStyle>
                                         <StatusBarCommandStyle Active-CssClass="GridStatusBarStyle" Normal-CssClass="GridStatusBarStyle" Over-CssClass="GridStatusBarStyle">
                                        </StatusBarCommandStyle>
                           <GroupRowInfoStyle CssClass="GridGroupRowInfoStyle"></GroupRowInfoStyle> 
                        
                        <GroupByBox>
                            <LabelStyle CssClass="LeftMenuLabelStyle"></LabelStyle>
                            <Style CssClass="TableGray"></Style>
                        </GroupByBox>
                        <EditTextboxStyle  CssClass="LeftMenuEditStyle"></EditTextboxStyle>                        
                        <FrameStyle CssClass="GridFrameStyle" >
                        </FrameStyle>
                        <SelectedRowStyle CssClass="GridSelectedRowStyle">
                        </SelectedRowStyle>
                        <AlternatingRowStyle  CssClass="GridAlternatingRowStyle" OverflowX="hidden" OverflowY="hidden"  CustomRules="text-overflow: ellipsis; overflow-x: hidden"></AlternatingRowStyle>
                          
                        <RowStyle BackColor="White" CustomRules="text-overflow: clip;"
                            CssClass="GridRowStyle" Overflow="Hidden" OverflowX="Hidden" OverflowY="Hidden" Wrap="False" />                            
                            <NewRowStyle CssClass="GridNewRowStyle"></NewRowStyle>                            
                            <EditFocusCellStyle CssClass="E9CD82ColorCode">
                            </EditFocusCellStyle>
                            <TextSettings Language="UseCulture">
                            </TextSettings>
                            <ClientSideEvents OnExitEditMode="EditMode" OnRowContextMenu="HideContextMenu" />
                            <ImageSettings RefreshImage="<%$ ReplaceTemplateExpn:Grid/images/refresh.png%>" MoreDataImage="<%$ ReplaceTemplateExpn:Grid/images/LoadMoreData.png%>"
                                            ExportImage="<%$ ReplaceTemplateExpn:Grid/images/Export.png%>"                                            
                                             /> 
                    </LayoutSettings>
                        <RootTable GridLineStyle="NotSet" HeaderClickAction="SortSingle" AllowGrouping="Yes" AllowEdit="Yes">
                        </RootTable>
                    </ISWebGrid:WebGrid>
                </td>
            </tr>
        </table>   
         <input type="hidden" id="_SelectedTreeNodeId"  name="_SelectedTreeNodeId" />  
    </form>
</body>
</html>
