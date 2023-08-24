<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.Unpublish" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>

<!DOCTYPE html>
<html>

<head runat="server">
    <title><%=UnPublishTitle %></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>    
  <!--[if lt IE 7]>
  <script defer type="text/javascript" src="styles/pngfix.js"></script>
  <![endif]-->
    
</head>
<body  class="validation-bgsmall" onunload="ShowAASynchFinishPage();">

<script type="text/javascript">

var UnpublishCompleted="<%=IsUnpublishCompleted%>";
function ShowAASynchFinishPage() {
    try {
        if(window==null) return;
        if(window.opener==null) return;
        
            
        if (window.opener.location.pathname.indexOf("AAAssociation.aspx", 0) != -1)
        {
            if (UnpublishCompleted == 'yes')
                window.opener.RefreshGrid();
        }
        if(window.opener.name=='AAWFAssociationPopUp')
        {
            if(UnpublishCompleted=='yes')
                window.opener.CloseUnpublish();
        }

        // this code is used when unpublishing the workflow from InvokeWorkflow Control - Edit Properties window
        try {
            if (window.opener.name === 'saveasdraftwindow') {
                if (UnpublishCompleted === 'yes')
                    window.opener.document.getElementById("updateOnUnPublishField").value = UnpublishCompleted;
                window.opener.document.getElementById("postBackButton").click();
            }
        }
        catch (err)
        {}

        if (window.opener.location.href.indexOf("VersionGrid.aspx", 0) != -1) {
            if (window.opener.top.opener.location.href.indexOf("AAAssociation.aspx", 0) != -1) {
                window.opener.top.opener.RefreshGrid();
                window.opener.RefreshGrid();
                closeWindow();
            }
        }
    }
    catch (e)
    { }
}
       
    
function GetRadWindow()
{
    var oWindow = null;
     oWindow = window.frameElement.radWindow;
    return oWindow;
} 
function closeWindow()
{
    //ShowAASynchFinishPage();
    
  try
  {  
      var oWindow = GetRadWindow();      
      oWindow.close();      
  }
  catch(err) {
    window.close();
  }
  
}
function ChangeSize()
{
    //alert('ChangeSize');    
    try
    {
        var oWindow = GetRadWindow();    
        oWindow.setSize(600, 500);
        oWindow.center();
        oWindow.show();
    }catch(err)
    {   
        if(window.name!="resizedWindow")
        {
            var w,h;                  
            var winWidth, winHeight;
            winWidth=500;
            winHeight=450;
            if (document.all || document.layers) 
            {
                w = screen.availWidth;
                h = screen.availHeight;
            }       
            var winLeft = (w-winWidth)/2;
            var winTop  = (h-winHeight)/2;            
            var newWin=window.open(window.location.href,"resizedWindow","width=" + winWidth + ",height=" + winHeight + ",left=" + winLeft + ",top=" + winTop);
            newWin.opener=window.opener;
            window.close();
            return newWin;
        }
        
    }
    
}
function grd1_Init(gridId) 
 {
   var grid = wgGetGridById(gridId);
   grid.HidePadColumn = true; // never show pad column eventhough vertical scrollbar is shown, nicer UI when autofitcolumn is used.
}
function WebGrid1_OnRowContextMenu(gridId, rowType, rowEl, rowMenu,location)
 {   
      var i;
      if (rowType != "Record") return true;   
        if(rowType =="Record")
        {
            // hide the default context menu
           for (i=0;i<=35;i++)
            { 
             rowMenu.items[i].Hide();
            }
        }
}



    </script>

    <form id="form1" runat="server"><link href="<%=themePath%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <div >
            <table id="unpublishMessageTable"   style=" border-spacing:0;border-width:0;margin:auto;width:100%">
                <tr>
                    <td style="text-align:left;padding-top: 28px;padding-left: 48px;">
                        <asp:Label ID="UnPublishMessage" runat="server" CssClass="successfulmsg" Width="88%"></asp:Label>
                        <br />
                        <asp:Label ID="UnPublishErrMsg" runat="server" CssClass="errormsg"></asp:Label>
                    </td>
                </tr>
            </table>
            <asp:Panel ID="ReportPanelForRunningAndPause" runat="server" Width="100%">
                <table style="width:97%;border-width:0;margin:auto;" class="tablebg" >
                    <tr>
                        <td class="lefttdbg">
                            <table style="width:100%;border-width:0;margin:auto;border-spacing:0">
                                <tr>
                                    <td style="height:65px">
                                        <table style="width:100%;border-width:0;border-spacing:0" >
                                            <tr>
                                                <td style="padding:15px" >
                                                    <span class="subtitle"><%=KillHeader %> : </span>
                                                    <br />
                                                <span class="description">  <%=KillDesc %></span>  
                                                    <br />
                                                    <br />
                                                    <span class="subtitle"><strong><%=Note %>:</strong></span><span class="description"> <%=KillNoteDesc %> </span>
                                                </td>
                                                <td style="width:30%;padding:15px">
                                                    <asp:Button ID="KillButton" runat="server" Text="" OnClick="KillButton_Click" CssClass="inputbutton"
                                                        />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height:65px">
                                        <table style="width:100%;border-width:0;border-spacing:0">
                                            <tr>
                                                <td style="padding:15px">
                                                    <span class="subtitle"><%=PauseHeader %> : </span>
                                                    <br />
                                                 <span class="description"><%=PauseDesc %></span>
                                                    <br />
                                                    <br />
                                                    <span class="note"><strong><%=Note %> :</strong><%=PauseNoteDesc %></span>
                                                </td>
                                                <td style="width:30%;padding:15px">
                                                    <asp:Button ID="PauseButton" runat="server" Text="" OnClick="PauseButton_Click"
                                                        CssClass="inputbutton" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height:65px">
                                        <table style="width:100%;border-width:0;border-spacing:0">
                                            <tr>
                                                <td style="padding:15px">
                                                    <span class="subtitle"><%=CancelHeader %> : </span>
                                                    <br />
                                                <span class="description"><%=CancelDesc %></span></td>
                                                <td style="width:30%;padding:15px">
                                                    <asp:Button ID="Cancel1" runat="server" Text="" OnClientClick="javascript:closeWindow();"
                                                        CssClass="inputsecondarybutton"/>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel ID="ReportPanelForOnlyPause" runat="server" Width="100%" Visible="false">
                <table style="width:99%;border-width:0;margin:auto;" >
                    <tr>
                        <td >
                            <table style="width:100%; border-width:0;margin:auto;border-spacing:0">
                                <tr>
                                    <td  style="height:65px" >
                                        <table style="width:100%;border-width:0;border-spacing:0" >
                                            <tr>
                                                <td>
                                                    <span class="subtitle"><%=KillPauseHeader %> : </span><span></span>
                                                    <br />
                                                  <span class="description"> <%=KillPauseDesc %></span> 
                                                    <br />
                                                    <br />
                                                    <span class="note"><strong><%=Note %> :</strong><%=KillPauseNoteDesc %>  </span>
                                                </td>
                                                <td style="width:30%">
                                                    <asp:Button ID="KillPauseButton" runat="server" Text="" OnClick="KillPauseButton_Click"
                                                        CssClass="inputbutton"/>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height:65px">
                                        <table style="width:100%; border-width:0;border-spacing:0" >
                                            <tr>
                                                <td style="padding:1px">
                                                    <span class="subtitle"><%=UPWORHeader %> : </span>
                                                    <br />
                                                  <span class="description">  <%=UPWORDesc %></span>
                                                    <br />
                                                    <br />
                                                    <span class="note"><strong><%=Note %> :</strong><%=UPWORNoteDesc %> </span>
                                                </td>
                                                <td style="width:30%;padding:4px">
                                                    <asp:Button ID="UnPublishButton" runat="server" Text="" OnClick="UnPublishButton_Click"
                                                        CssClass="inputbutton"/>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height:75px">
                                        <table style="width:100%;border-width:0;border-spacing:0"  >
                                            <tr>
                                                <td style="padding-top:4px">
                                                    <span class="subtitle"><%=CancelHeader %> :</span>
                                                    <br />
                                                <span class="description">  <%=CancelDesc %></span></td>
                                                <td style="width:30%;padding:4px">
                                                    <asp:Button ID="Cancel2" runat="server" Text="" OnClientClick="javascript:closeWindow();"
                                                        CssClass="inputsecondarybutton"/>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel ID="ErrorsPanel" runat="server" Visible="false">
                <%--  <asp:GridView ID="ErrorDetailsView" runat="server"  PagerSettings-Mode="NumericFirstLast" PagerSettings-Position="Bottom" PageSize="20" HeaderStyle-CssClass="hdrtextnew" AlternatingRowStyle-BackColor="#f5f5f5" RowStyle-BackColor="#e2f0fe" >
           <FooterStyle ForeColor="#000066" BackColor="White"></FooterStyle>
        </asp:GridView>--%>
                <table style="height: 400; width: 100%;border-width:0;vertical-align:top;border-spacing:1">
                    <tr>
                        <td style="vertical-align:top">
                            <ISWebGrid:WebGrid ID="ErrorDetailsView" runat="server" Height="400px" Width="100%"
                                AllowAutoDataCaching="false" DataCacheStorage="PageCache" DisableFileSystemChecking="true" EnableWebResources="never">
                                <LayoutSettings StatusBarVisible="false" AlternatingColors="True" CellPaddingDefault="2"
                                    GridLineColor="221, 236, 254" AlwaysShowHelpButton="False" AllowFilter="Yes"
                                    AllowGrouping="Yes" AutoFitColumns="true" GridLineStyle="Solid" RowHeightDefault="20px"
                                    AllowColumnSizing="Yes" Hierarchical="True" GridLines="Vertical" AllowColumnMove="Yes"
                                    AllowExport="Yes" AllowSelectColumns="yes" FilterBarVisible="False">
                                    <ClientSideEvents OnInitialize="grd1_Init" OnRowContextMenu="WebGrid1_OnRowContextMenu" /> 
                                    <HeaderStyle CssClass="GridHeaderStyle"  CustomRules="border-bottom: #73A1E4 1px solid; -moz-boz-flex: 0" Overflow="Hidden"
                                        OverflowX="Hidden" OverflowY="Hidden" Wrap="False"></HeaderStyle>
                                    <FocusCellStyle CssClass="GridFocusCellStyle" />
                                    <StatusBarCommandStyle>
                                        <Active BackColor="RoyalBlue" BaseStyle="Over">
                                        </Active>
                                        <Over BackColor="#FBE9B8" BorderColor="#002D96" BorderStyle="Solid" BorderWidth="1px">
                                        </Over>
                                        <Normal>
                                            <Padding Bottom="1px" Left="1px" Right="1px" Top="1px" />
                                        </Normal>
                                    </StatusBarCommandStyle>
                                    <GroupRowInfoStyle BorderColor="Black" BorderStyle="None" Font-Names="Verdana" Font-Size="8pt"
                                        BackgroundImage="<%$ ReplaceTemplateExpn:InterSoft/Grid/CommonLibrary/Images/ColBk.gif%>"
                                        CustomRules="border-bottom: #73A1E4 1px solid">
                                    </GroupRowInfoStyle>
                                    <GroupByBox>
                                        <LabelStyle BackColor="White" BorderColor="Navy" BorderStyle="Solid" BorderWidth="1px"
                                            Font-Names="Verdana" Font-Size="8pt" />
                                        <Style BackColor="Gray"></Style>
                                    </GroupByBox>
                                    <EditTextboxStyle BorderStyle="None" BorderWidth="0px" Font-Names="Verdana" Font-Size="8pt">
                                    </EditTextboxStyle>
                                    <FrameStyle BackColor="#A9C7F4" BackgroundImage="<%$ ReplaceTemplateExpn:Repository/Site/images/bg-bam-grid.jpg%>">
                                    </FrameStyle>
                                    <SelectedRowStyle CssClass="GridSelectedRowStyle" />
                                    <AlternatingRowStyle BackColor="#DDECFE" CustomRules="text-overflow: clip; " Font-Names="Verdana"
                                        Font-Size="8pt" Overflow="Hidden" OverflowX="Hidden" OverflowY="Hidden" Wrap="False" />
                                    <StatusBarStyle CssClass="GridStatusBarStyle">
                                        <Padding Bottom="2px" Left="2px" Right="2px" Top="2px" />
                                    </StatusBarStyle>
                                    <RowStyle CssClass="GridRowStyle" Overflow="Hidden" OverflowX="Hidden" OverflowY="Hidden" Wrap="False" />
                                    <NewRowStyle CssClass="GridNewRowStyle">
                                    </NewRowStyle>
                                    <EditFocusCellStyle CssClass="GridEditFocusCellStyle">
                                    </EditFocusCellStyle>
                                    <TextSettings Language="UseCulture">
                                    </TextSettings>
                                </LayoutSettings>
                                <RootTable GridLineStyle="NotSet" HeaderClickAction="SortSingle" AllowGrouping="Yes">
                                </RootTable>
                            </ISWebGrid:WebGrid>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <table style="border-width:0;width:100%;border-spacing:0;">
                <tr>
                    <td style="text-align:right;padding-top: 65px;padding-right: 8px;">
                        <asp:Button ID="CloseButton" runat="server" Text="" OnClientClick="javascript:closeWindow();return false;"
                            Visible="false" CssClass="inputbutton"/>
                         </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
