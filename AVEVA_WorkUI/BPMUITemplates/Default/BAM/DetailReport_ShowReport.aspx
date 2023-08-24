<%@ Page Language="C#" AutoEventWireup="true"  Inherits="Workflow.NET.CodeBehind.Bam.SkeltaTemplates_Default_BAM_DetailReport_ShowReport" Theme="" StylesheetTheme="" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>
<link rel="stylesheet" type="text/css" href="<%:csspath %>/global.css" />
 <script language="javascript">
 function  SaveLayout()
{ 
  
   
   var Url = 'SaveLayout.aspx';  
   window.open(Url,'LayoutSaving','height=155,width=350,resizable=no,scrollbars=no,status=no')//,'LayoutSaving', 'height=120,width=400,resizable=yes,scrollbars=no,status=no');
  // return false;
 
}


function SaveClick()
{
  //  alert("hi");
    document.getElementById("_IdSaveBtn").click();
    var grid = ISGetObject("WebGrid1");
   grid.RefreshAll();
}
 </script>   
<html >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
	<%=System.Web.Helpers.AntiForgery.GetHtml()%>
             <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#256194">
                       <tr>
                            <td height="25" width="96%">
                                <font color="white" size="2">&nbsp;&nbsp;<b><%=DisplayString%></b></font>                                
                             </td>                 
                             <td  align="right" valign="middle"width="2%"> 
                             <img src=" <%:csspath %>BAM/images/save-layout.gif"  style="cursor:hand"  hspace="10"  onclick="SaveLayout()" title="<%=_ImageToolTip%>"   align="absmiddle" />                             
                             <input type=hidden id="SaveLayOutId" name="SaveLayOut" />
                             <asp:Button  OnClick="_IdSaveBtn_Click"  style="display:none"   CssClass="inputbutton" Text="Save Layout"   runat=server ID="_IdSaveBtn" />     
                             <input type=hidden id="guidVal" name="guidVal" />
                            </td>
                        </tr>
                        </table>
                        
        <table width="100%" height="96.5%" border="0" cellpadding="0" cellspacing="0" bgcolor="#256194">                
          <tr>
            <td>                 
               <ISWebGrid:WebGrid ID="WebGrid1" runat="server" Height="100%" HorizontalAlign="NotSet"  AllowAutoDataCaching=true 
            Width="100%" DisableFileSystemChecking="true" EnableWebResources="never" >
            <LayoutSettings AlternatingColors="True" CellPaddingDefault="2" GridLineColor="221, 236, 254"  AlwaysShowHelpButton=False  AllowFilter=Yes 
                GridLineStyle="Solid" RowHeightDefault="20px" AllowGrouping=Yes  AllowColumnSizing=Yes  Hierarchical=True  GridLines="Vertical" AllowColumnMove="Yes" AllowExport="Yes" AllowSelectColumns="Yes" AllowSorting="Yes" FilterBarVisible="False" PagingMode="VirtualLoad" >
                <HeaderStyle Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CssClass="GridHeaderStyle" BackgroundImage="<%$ ReplaceTemplateExpn:BAM/Images/bg-for-grid-title.png%>" CustomRules="border-bottom: #73A1E4 1px solid; -moz-boz-flex: 0" Wrap="False">
                </HeaderStyle>
                <FocusCellStyle BorderColor="0, 45, 150" BorderStyle="Solid" BorderWidth="1px" />
                    <StatusBarCommandStyle>
                    <Active BaseStyle="Over" CssClass="RedColorCode">
                    </Active>
                    <Over CssClass="StatusBarCommandStyleClassOver">
                    </Over>
                    <Normal>
                        <Padding Top="1px" Left="1px" Bottom="1px" Right="1px"></Padding>
                    </Normal>
                 </StatusBarCommandStyle>
                       <GroupRowInfoStyle BorderColor="Black" BorderStyle="None"
                            Font-Names="Verdana" Font-Size="8pt" BackgroundImage="<%$ ReplaceTemplateExpn:BAM/Images/bg-for-grid-title.png%>" CustomRules="border-bottom: #73A1E4 1px solid">
                        </GroupRowInfoStyle>
                        
                        <GroupByBox>
                            <LabelStyle CssClass="LeftMenuLabelStyle"></LabelStyle>
                            <Style CssClass="TableGray"></Style>
                        </GroupByBox>
                        <EditTextboxStyle  CssClass="LeftMenuEditStyle"></EditTextboxStyle>                        
                        <FrameStyle BackgroundImage="<%$ ReplaceTemplateExpn:Bam/Images/bg-bam-grid.jpg%>">
                        </FrameStyle>
                        <SelectedRowStyle BackgroundImage="<%$ ReplaceTemplateExpn:hws/Images/selectetd-row-bg1.png%>">
                        </SelectedRowStyle>
                        <AlternatingRowStyle  CssClass="GridAlternatingRowStyle" OverflowX="hidden" OverflowY="hidden"  CustomRules="text-overflow: ellipsis; overflow-x: hidden"></AlternatingRowStyle>
                           <StatusBarStyle CssClass="GridStatusBarStyle">
                                <Padding Bottom="2px" Left="2px" Right="2px" Top="2px" />
                            </StatusBarStyle>
                        <RowStyle CssClass="GridRowStyle" CustomRules="text-overflow: clip;"
                           Overflow="Hidden" OverflowX="Hidden" OverflowY="Hidden" Wrap="False" />                            
                            <NewRowStyle CssClass="GridNewRowStyle"></NewRowStyle>                            
                            <EditFocusCellStyle CssClass="E9CD82ColorCode">
                            </EditFocusCellStyle>
                            <TextSettings Language="UseCulture">
                            </TextSettings>
                    </LayoutSettings>
                <RootTable GridLineStyle="NotSet" HeaderClickAction="SortSingle"  > 
                </RootTable>               
        </ISWebGrid:WebGrid>         
                     </td>                             
                                </tr>
                        </table>
    </form>
</body>
</html>
