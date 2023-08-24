<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.HWS.Web.WorkListLayoutControl.WorkListLayoutClass" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

 <link rel="stylesheet" type="text/css" href="<%=TemplateDirectory%>common/StyleSheet/Global.css" />
 
<link rel="stylesheet" type="text/css" href="<%=TemplateDirectory%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css" />
<link rel="stylesheet" type="text/css" href="<%=TemplateDirectory%>TelerikAjax/StyleSheet/AWTWindow/Window.css" />
<link href="<%=TemplateDirectory%>CommonUXControls/StyleSheet/se.ui.min.css"  rel="stylesheet" type="text/css" />  
<style type="text/css">
    .inlineWidthCSS {
        width:220px !important;
        max-width:220px !important;
    }
</style>
<script src="../../Common/JavaScripts/jquery.min.js"></script>
<script src="../../Common/JavaScripts/AutoLogoff.js"></script>
 <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script>
 
<div id="HeaderDiv" style="height: 6%;">
    <table style="width: 100%; margin: 0px auto;">
        <tr>
            <td class="pagetitle" style="padding: 3px;font-size:18px;" colspan="2">
                <img src="<%=TemplateDirectory%>Workitemlist/images/icon-global-workitem-layout.png" style="vertical-align:middle;"  /><%=StrHeading%>
            </td>
        </tr>
       
    </table>
</div>
<div id="BodyDiv" style="overflow:hidden;height:24%;">
    <table style="margin: 0px auto; width: 96%; border-collapse: separate; border-spacing: 1px;" class="tablebg" border="0">
        <tr id="GlobalLayouttr" style="display: none; width: 100%;">
            <td class="lefttdbg" style="width: 48%; text-align: left; height: 55px; padding: 3px; vertical-align: top;">
                <span class="subtitle">
                    <%=GR.GetString("WIL_LayoutNames")%>                                            
                </span>
                <br />
                <span class="description">
                    <%=GR.GetString("WIL_LayoutNamesDesc")%>
                </span>
            </td>
            <td class="righttdbg" style="width:15%; vertical-align:top; height: 55px;padding-top:8px;">
                <asp:DropDownList ID="ddlLayouts" runat="server" Visible="false" AutoPostBack="true"
                    CssClass="inputselect">
                </asp:DropDownList>
            </td>            
            <td class="righttdbg" style="width:33%;padding:3px;vertical-align:top;height:55px;padding-top:8px;">
                <span class="subtitle" id="NewLayoutLink" style="display: none;">
                    <a href="javascript:DisplayNewLayoutTextBox();" id="linkid" class="textlinkblue">
                        <u><%=GR.GetString("WIL_NewLayoutLink")%></u>
                    </a>
                </span>
            </td>
        </tr>
        <tr id="CustomLayouttr" style="display:none;width: 100%;">
                        
            <td class="righttdbg" style="width:51%;text-align:left;height:55px;padding:3px;vertical-align:top;">
                <span class="subtitle">
                    <%=GR.GetString("WIL_NewLayoutLinkName")%>
                </span>
                <br />
                <span class="description">
                    <%=GR.GetString("WIL_NewLayoutLinkDesc")%>
                </span>
                
            </td>
            <td class="righttdbg" style="width:12%; vertical-align:top; height: 55px;padding-top:8px;padding-left:10px;">
                </td>
            <td class="righttdbg"  style="width:33%;padding:3px;vertical-align:top;height:55px;padding-top:8px;">
                <asp:TextBox ID="txtLayoutName" runat="server" Enabled="false" CssClass="inputtext" MaxLength="50"></asp:TextBox>
            </td>
            
                
            
        </tr>
    </table>
    
</div>
<div id="GridDiv" style="overflow-x: auto !important;overflow-y:hidden!important; height: 60%;">
    <table id="webGridtable" style="border-spacing: 1px; border-collapse: separate; width: 98%; margin: 0px auto; height: 100%;" border="0" class="tablebg">
        <tr>
            <td class="lefttdbg" style="vertical-align: top; height: 35px; width: 45%; padding-left: 15px;" colspan="2">
                <span class="subtitle">
                    <%=GR.GetString("WIL_LayoutSetColumns")%>
                </span>
                <br />
                <span class="description">
                    <%=GR.GetString("WIL_LayoutSetColumnsDesc")%>
                </span>
                <br />
            </td>
        </tr>
        <tr>
            <td class="righttdbg" style="vertical-align: top;width:100%;padding-left:15px;" colspan="2">
                
                <ISWebGrid:WebGrid ID="WebGrid1" runat="server" Height="100%" HorizontalAlign="NotSet" Width="100%" RenderingMode="HTML5"
                    OnInitializeDataSource="WebGrid1_InitializeDataSource" OnPrepareDataBinding="WebGrid1_PrepareDataBinding" AllowAutoDataCaching="false" DataCacheStorage="PageCache" ViewStateStorage="None" DisableFileSystemChecking="true" EnableWebResources="never">
                    <LayoutSettings FilterBarVisible="false" StatusBarVisible="false"  GroupByBoxVisible="false" AutoFitColumns="false" AllowGrouping="Yes" AllowColumnMove="Yes" AllowColumnSizing="yes" AllowSelectColumns="Yes" AllowSorting="Yes" AllowFilter="Yes" AlwaysShowHelpButton="false" PagingMode="None" ShowRefreshButton="false" VirtualPageSize="10" CellClickAction="RowSelect" UseRelativePositioning="true" PersistRowChecker="false" AllowAddNew="No" AlternatingColors="True" GridLineStyle="Solid" GridLineColor="#afafaf" CellPaddingDefault="2" RowHeightDefault="20px" GridLines="None" RowHeaders="No">
                        <HeaderStyle Wrap="false" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CssClass="GridHeaderStyle"></HeaderStyle>
                        <FocusCellStyle CssClass="GridFocusCellStyle"></FocusCellStyle>
                        <GroupRowInfoStyle CssClass="GridGroupRowInfoStyle"></GroupRowInfoStyle>
                        <GroupByBox>
                            <LabelStyle CssClass="GridLabelStyle"></LabelStyle>
                            <Style BackColor="#ececec"></Style>
                        </GroupByBox>
                        <FrameStyle GradientType="Vertical" CssClass="GridFrameStyle"></FrameStyle>
                        <SelectedRowStyle CssClass="GridSelectedRowStyle"></SelectedRowStyle>
                        <AlternatingRowStyle CssClass="GridAlternatingRowStyle" OverflowX="hidden" OverflowY="hidden"></AlternatingRowStyle>
                        <StatusBarStyle CssClass="GridStatusBarStyle">
                            <Padding Top="2px" Left="2px" Bottom="2px" Right="2px"></Padding>
                        </StatusBarStyle>       
                        <RowStyle CssClass="GridRowStyle" Overflow="hidden" OverflowX="hidden" OverflowY="hidden"></RowStyle>
                        <LostFocusRowStyle CssClass="GridLostFocusRowStyle"></LostFocusRowStyle>
                        <EditTextboxStyle CssClass="GridEditTextBoxStyle"></EditTextboxStyle>
                        <EditFocusCellStyle CssClass="GridEditFocusCellStyle"></EditFocusCellStyle>
                        <ClientSideEvents  />
                        <TextSettings Language="UseCulture">                            
                        </TextSettings>
                    </LayoutSettings>
                    <RootTable GridLineStyle="NotSet" TableHeaderVisible="False">
                        <TableHeaderStyle GradientType="Vertical" CssClass="GridTableHeaderStyle">
                            <Padding Bottom="4px" Left="4px" Top="4px" Right="4px"></Padding>
                        </TableHeaderStyle>
                    </RootTable>
                </ISWebGrid:WebGrid>

            </td>
        </tr>

    </table>
</div>

<div id="FooterDiv" style="overflow: auto; height: 10%;padding-top:5px;">
    <table style="width: 100%; margin: 0px auto; border-collapse: collapse; border-spacing: 0px;" border="0">
        <tr>
            <td style="text-align: right; width: 100%;padding-top:2px;padding-right:10px;">
                
                
                <asp:Button ID="btnDeleteLayout" runat="server" CssClass="inputsecondarybutton" />
               
                <%if (_CheckViewType != "Queue" && WorkflowType != "workflow")
                       { %>
                <asp:Button ID="buttonPackageTemplateLayout" runat="server" CssClass="inputsecondarybutton inlineWidthCSS" OnClientClick="ShowPackageWindow(); return false;"/>
               
                 <telerik:RadWindowManager VisibleOnPageLoad="false" Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" runat="server" BackColor="Black" Behaviors="Minimize,Maximize,Close" DestroyOnClose="true" Overlay="false" RenderMode="Classic" VisibleStatusbar="false">
                </telerik:RadWindowManager>

                <%}%>
                <asp:Button ID="btnSaveLayout" runat="server" CssClass="inputbutton" OnClientClick="return AssignValue()" />
            </td>
            <td style="padding: 5px;">
                <%if (_CheckViewType != "Queue" && _EnableClose=="true"){%>
                <input type="button" class="inputbutton" value="<%=StrCancel%>" id="btnCancel" onclick="window.close();" name="btnCancel">
                <%}%>
            </td>
            <asp:HiddenField ID="hidSpecificLayout" runat="server" />
        </tr>

    </table>
</div>

<script type="text/javascript">
    
    

       if ('<%=_CheckViewType%>' == 'Queue') 
       {
           if ('<%=_WorkListLayoutControl.Width.Value%>' > 0) {
               var worklistControlWidthvalue = '<%=_WorkListLayoutControl.Width.Value%>';
               if (document.getElementById("GridDiv") != null) {                   
                   if ('<%=_WorkListLayoutControl.Width.Type%>' == 'Pixel') {
                       document.getElementById("GridDiv").style.width = worklistControlWidthvalue;
                   }
                   else {
                       if (navigator.appName == 'Netscape') {
                           document.getElementById("GridDiv").style.width = window.screen.width * (worklistControlWidthvalue - 15) / 100;
                       }
                       else {
                           document.getElementById("GridDiv").style.width = window.screen.width * (worklistControlWidthvalue - 5) / 100;
                       }
                   }

               }

               if (document.getElementById("FooterDiv") != null) {
                   if ('<%=_WorkListLayoutControl.Width.Type%>' == 'Pixel') {
                       document.getElementById("FooterDiv").style.width = worklistControlWidthvalue;
                   }
                   else {
                       if (navigator.appName == 'Netscape') {
                           document.getElementById("FooterDiv").style.width = window.screen.width * (worklistControlWidthvalue - 15) / 100;
                       }
                       else {
                           document.getElementById("FooterDiv").style.width = window.screen.width * (worklistControlWidthvalue - 5) / 100;
                       }
                   }

               }

           }
           else {
               if (document.getElementById("GridDiv") != null) {
                   document.getElementById("GridDiv").style.width = window.innerWidth - 150 + 'px;';
                   
                    var Grid1 = ISGetObject("WebGrid1");
                     Grid1.SetHeight(105 + 'px');
                     document.getElementById("webGridtable").style.height = 85 + '%';
                     
                  document.getElementById("GridDiv").style.height = 180 + 'px';
               
               }
           }
       }
       else 
       {
           
            if(document.getElementById("BodyDiv") !=null)
                document.getElementById("BodyDiv").style.width = window.innerWidth - 50 +'px';            
                  
            if(document.getElementById("GridDiv") !=null)
                document.getElementById("GridDiv").style.width = window.innerWidth - 10 + 'px';
                  
            if(document.getElementById("FooterDiv") !=null)
                document.getElementById("FooterDiv").style.width = window.innerWidth - 10 + 'px';

            var GridDivHeight = document.getElementById("GridDiv").clientHeight;
            GridDivHeight = GridDivHeight - 60;
           
            var Grid1 = ISGetObject("WebGrid1");
            Grid1.SetHeight(GridDivHeight + 'px');

            if ('<%=_CheckGlobalLayout%>' == 'False')
            {
                Grid1.SetHeight(GridDivHeight + 150 + 'px');
            }
            
       }

    if('<%=_CheckGlobalLayout%>'=='True')
    {
        document.getElementById("GlobalLayouttr").style.display="block";  
    }
    
    function CallForDeleteLayout(msg)
    {
        alert(msg);
        closewin();
    }

    function CallForShowMessage(msg) {
        alert(msg);        
    }

    function closewin()
    {
      if('<%=_EnableClose%>'=='true')
      {
      window.close(); 
      }
    
    }
    
    function AssignValue()
    {        
        
        if(document.getElementById('<%=ddlLayouts.ClientID%>') !=null)
        {
           if(document.getElementById('<%=ddlLayouts.ClientID%>').value=="CustomLayout")
           {
               if (document.getElementById('<%=txtLayoutName.ClientID%>').value=="")
               {
                  // alert('<%=GR.GetString("WIL_Enterlayoutname")%>');
                   se.ui.messageDialog.showError('<%=GR.GetString("ec_menu_workitem_layout")%>', '<%=GR.GetString("WIL_Enterlayoutname")%>');
                return false;
               }  
           }
           else if(document.getElementById('<%=ddlLayouts.ClientID%>').value=="Select a Layout")
           {
               //  alert('<%=GR.GetString("WIL_Selectlayoutname")%>');ec_menu_workitem_layout

            se.ui.messageDialog.showError('<%=GR.GetString("ec_menu_workitem_layout")%>', '<%=GR.GetString("WIL_Selectlayoutname")%>');
            return false;
           }
        }
        document.getElementById('<%=hidSpecificLayout.ClientID%>').value="SpecificLayout";
    }
    

    function DisplayNewLayoutTextBox()
    { 
        document.getElementById("CustomLayouttr").style.display="block"; 
        document.getElementById('<%=txtLayoutName.ClientID%>').disabled=false;      
         var Grid1 = ISGetObject("WebGrid1");
         //if(Grid1 !=null || Grid1 !=undefined) 
          //  Grid1.SetHeight(225 + 'px');
    } 

    function EnableOrDisableCustomLayout(ctrl)
    {
        if(ctrl !=null)
        {      
            if(ctrl.value=="CustomLayout")
            {
                document.getElementById("NewLayoutLink").style.display="block";                   
                return false;
                
            }
            else if(ctrl.value !="Select a Layout")
            { 
                document.getElementById("NewLayoutLink").style.display="none";   
                document.getElementById("CustomLayouttr").style.display="none";                 
                document.forms[0].submit();                                  
            }
            else 
            {
                document.getElementById("NewLayoutLink").style.display="none";   
                document.getElementById("CustomLayouttr").style.display="none";                                            
            }                       
        }

    }
    
    function ShowPackageWindow() {
        var application = '<%=_AppName%>';
        var itemGuid = '<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(GuidForDropDown, false)%>';
        var itemName = '<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(itemNameForDropDown, false)%>';
        var SelLName = document.getElementById('<%=ddlLayouts.ClientID%>').value;
        if (SelLName == "CustomLayout" || SelLName == "Select a Layout") {
           // alert('<%=GR.GetString("WIL_Selectlayoutname")%>');
            se.ui.messageDialog.showError('<%=GR.GetString("ec_menu_workitem_layout")%>', '<%=GR.GetString("WIL_Selectlayoutname")%>');
            return false;
        }

        if (!itemGuid) {
           // alert('<%=GR.GetString("WorkList layout not yet saved.")%>');
            se.ui.messageDialog.showError('<%=GR.GetString("ec_menu_workitem_layout")%>', '<%=GR.GetString("WorkList layout not yet saved.")%>');
            return false;
        }
        var url = "../../Package/PackageList.aspx?&mode=Global WorkItem Layout" + "&AppName=" + application + "&GuidForDropDown=" + itemGuid + "&itemNameForDropDown=" + itemName;

        var windowparams = "height=320,width=500,resizable=yes,status=no";
        var oWindow = radopen(url, null);
        oWindow.set_modal(true);
        oWindow.set_title("Global WorkItem Layout");
        oWindow.setSize(590, 360);
    }


    se.ui.messageDialog.setGlobalOptions({
        localization: {
            closeButtonCaption: "<%=GR.GetString("se_ui_messagedialog_close_caption") %>",
                 okButtonCaption: "<%=GR.GetString("se_ui_messagedialog_ok_caption") %>",
                 cancelButtonCaption: "<%=GR.GetString("se_ui_messagedialog_cancel_caption") %>",
                 showDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_showdetails_caption") %>",
                 hideDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_hidedetails_caption") %>"
             }
    });

</script>