<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.InvokeWS.ListMethods" Theme="" StyleSheetTheme=""%>

<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>

<!DOCTYPE html>
<html >
<head runat="server">
    <title><%=l_WSTitle%></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
	    
</head>
<body style="padding:10px;">
    <form id="form1" runat="server">
    <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
    <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(PdCtrl.GetCommonRelativeUrl("stylesheet/Global.css"))%>" rel="stylesheet" type="text/css">
    <div>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td ><table width="100%" border="0" cellspacing="0" cellpadding="0" class="header2">
                <tr class="ListHeaderCss">
                  <td width="95%" class="fontheading"><%=l_WSTitle%></td>
                  <td width="5%" class="fontheading"><a href="#">
                  <img src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(PdCtrl.GetCommonRelativeUrl("images/main-help.gif"))%>" alt="<%=GR.GetString("HelpAltText")%>"  border="0" onclick="javascript:openhelpinpdmode()"></a></td>
                </tr>
              </table></td>
            </tr>
		<tr>
		<td>
			<table border=0 height="90" width="100%" cellpadding="2" cellspacing="0">
			<tr>
					<td>
                        <ISWebGrid:webgrid id="WebGrid1" runat="server" height="269px" horizontalalign="NotSet"
                            width="98%" OnInitializeDataSource="WebGrid1_InitializeDataSource" AllowAutoDataCaching="false"
                            DisableFileSystemChecking="true" EnableWebResources="Never">

                             <LayoutSettings AllowFilter="yes" filterbarvisible="false" RowHeaders="No"
                                       AlternatingColors="true"                                                  
                                       GridLineStyle="Solid" 
                                       GridLineColor="#afafaf" 
                                       CellPaddingDefault="2" 
                                       RowHeightDefault="22px" 
                                       GridLines="None" 
                                       StatusBarVisible="True" 
                                       NewRowLostFocusAction="AlwaysPrompt" 
                                       RowLostFocusAction="AlwaysPrompt"
                                       PagingMode="VirtualLoad"  VirtualPageSize="50"
                                       PromptBeforeDelete="true"  AutoHeight=false                                                 
                                       AutoFitColumns="True" ShowRefreshButton="true" AllowExport="Yes" AlwaysShowHelpButton="false" AllowSorting="yes" AllowColumnSizing="Yes">                                                                                         
                                                           <HeaderStyle Wrap="false" Height="20px" Overflow="hidden" OverflowX="hidden" OverflowY="hidden"
                                                    CssClass="GridHeaderStyle"></HeaderStyle>

                                    <FocusCellStyle CssClass="GridFocusCellStyle"></FocusCellStyle>
                                    <GroupRowInfoStyle CssClass="GridGroupRowInfoStyle"></GroupRowInfoStyle>
                                    <GroupByBox>
                                        <LabelStyle CssClass="GridLabelStyle"></LabelStyle>
                                    </GroupByBox>
                                    <EditTextboxStyle CssClass="GridEditTextboxStyle"></EditTextboxStyle>
                                    <FrameStyle GradientType="Vertical" CssClass="GridFrameStyle"></FrameStyle>
                                    <SelectedRowStyle CssClass="GridSelectedRowStyle" CustomRules="text-overflow: ellipsis; overflow-x: hidden"></SelectedRowStyle>                                    
                                    <AlternatingRowStyle CssClass="GridAlternatingRowStyle" CustomRules="text-overflow: ellipsis; overflow-x: hidden"/>
                                    <RowStyle CssClass="GridRowStyle" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden"></RowStyle>  
                                    <NewRowStyle CssClass="GridNewRowStyle"></NewRowStyle>
                                    <EditFocusCellStyle CssClass="GridEditFocusCellStyle"></EditFocusCellStyle>
                                    <TextSettings Language="UseCulture"></TextSettings>
                                    <ButtonStyle CssClass="inputbutton" Height="17px" ></ButtonStyle>
                                    <ClientSideEvents OnRowContextMenu="DisableContextMenu" />
                                    <TextSettings Language="UseCulture"></TextSettings>   
                                    <StatusBarStyle CssClass="GridStatusBarStyle">
                                        <Padding Top="2px" Left="2px" Bottom="2px" Right="2px"></Padding>
                                    </StatusBarStyle>
                        </layoutsettings>
                                <RootTable GridLineStyle="NotSet">
                                    <TableHeaderStyle CssClass="GridTableHeaderStyle">
                                        <Padding Bottom="4px" Left="4px" Top="4px" Right="4px"></Padding>
                                    </TableHeaderStyle>
                                </RootTable> 
                        </ISWebGrid:webgrid>                    
                    </td>
				</tr>
				</table>
				</td>
				
			</tr>
			<tr>
				<td>
			<table border=0 width="98%" cellpadding="0" cellspacing="0">
				<tr>
                     <td  class="lefttdbg" style="text-align:left">
                               <span class="description"><%=GR.GetString("ws_listmethods_selrow_desc")%></span>
                           </td>
					<td style="text-align:right">
					    <asp:Button ID="Button1" runat="server" class="inputbutton" Text="Bind Parameters" OnClick="Button1_Click" />							
					</td>
				</tr>
				</table>			
				</td>
			</tr>			
		</table>		
	<table border=0 width="99%" cellpadding="4" cellspacing="0">
				    <tr>
                      <td style="text-align:right;padding-right:7px">
                          <asp:Button ID="btnWSList" runat="server"  Text="List" CssClass="inputbutton" OnClick="btnWSList_Click"/>            
                          <!--<asp:Button ID="btnWSMthdList" runat="server"  Text="Method List" Width="110" CssClass="input-buttonswork"/>-->
                          <asp:Button ID="btnWSFields" runat="server" Text="Fields" CssClass="inputbutton" OnClick="btnWSFields_Click"/>
                       </td>
                    </tr>
				    
				</table>
    </div>
    <script language="javascript"  type="text/javascript">
      
     function openhelpinpdmode()
     {        
        window.open('<%=PdCtrl.GetHelpPageUrl()%>WebService-WebServiceDetails.html','','height=450,width=600,resizable=yes,status=no,scrollbars=yes');
     }
   function DisableContextMenu(gridId, rowType, rowEl, rowMenu)
    {
        var i;
        var grid = wgGetGridById(gridId);	                 
        if (rowType != "Record") return true;	        
        if(rowType =="Record")
        { 
            // hide the default context menu
            for (i=0;i<=43;i++)
            {                              
             rowMenu.Items[i].Hide();              
            }                                              
        } 	
   }

   function isIE11() {
       return !!navigator.userAgent.match(/Trident.*rv[ :]*11\./);
   }

   function ResizeGrid() {
       if (isIE11()) {
           var grid = ISGetObject("WebGrid1");
           grid.SetHeight(269 + 'px');
       }
   }

   ResizeGrid();
     </script>
    </form>
</body>
</html>
