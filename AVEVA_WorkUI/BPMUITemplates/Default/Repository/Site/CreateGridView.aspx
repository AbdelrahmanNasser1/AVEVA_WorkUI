<%@ Page Language="C#" AutoEventWireup="false"  Inherits="Skelta.Repository.Site.CodeBehind.CreateFormDataGridView" MaintainScrollPositionOnPostback="true" Debug="true" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>

<!DOCTYPE html>
<html style="height:100%">
<head id="Head1" runat="server">
<title><%= _PageTitle%></title>
<script src="../../Common/JavaScripts/jquery.min.js"></script>
<script src="../../Common/JavaScripts/AutoLogoff.js"></script>
</head>
<script type="text/javascript">

    function HideGroupByItem(controlId, col, menu, isGroup, location) {
        for (var i = 0; i < menu.Items.length; i++) {
            //Hiding these context menu options
            // 3-GroupByfield, 4-GroupByBox, 5-MenuItemSeperator1, 6-RemoveColumn
            if (i == 3 || i == 4 || i == 5 || i == 6) {
                menu.Items[i].Hide();
            }
        }
    }

    function HidePadColumn(gridId) {
        var grid = ISGetObject(gridId);
        grid.HidePadColumn = true;
    }

    function GetRadWindow() {
        var oWindow = null;
        if (window.frameElement != null)
            oWindow = window.frameElement.radWindow;
        return oWindow;
    }
    function CloseWindow() {
        if (document.getElementById('<%=hidSavelayout.ClientID%>') != null || document.getElementById('<%=hidSavelayout.ClientID%>') != undefined) {
            document.getElementById('<%=hidSavelayout.ClientID%>').value = "closeclicked";
        }
        var oWindow = GetRadWindow();
        oWindow.close();
    }

    function AssignValue() {
        if (document.getElementById('<%=ddlConfigNames.ClientID%>').value == "Select") {
           
           // alert("<%=_validateConfiguration%>");
            se.ui.messageDialog.showError('<%=_Skrm.GlobalResourceSet.GetString("GridView_PageTitle")%>', '<%=_validateConfiguration%>');
            return false; 
        }
        document.getElementById('<%=hidSavelayout.ClientID%>').value = "clicked";
        return true;

    }

    function AssignResetValue() {
        var CheckReset = false;//= confirm('<%=_Skrm.GlobalResourceSet.GetString("GridView_btnResetConfirm")%>');


        se.ui.messageDialog.showConfirmation('<%=_Skrm.GlobalResourceSet.GetString("GridView_PageTitle")%>', '<%=_Skrm.GlobalResourceSet.GetString("GridView_btnResetConfirm")%>',
                          function (userResponse) {
                              if (userResponse) {
                                  document.getElementById('<%=hidSavelayout.ClientID%>').value = "resetclicked";
                                  CheckReset = true;
                                  return true;

                              }
                          });


        if (!CheckReset) {
           
            return false;
        }
        

    }

    function AddEventHandler(elementObject, eventName, functionObject) {

        if (document.addEventListener)
            elementObject.addEventListener(eventName, functionObject, false);
        else
            if (document.attachEvent)
                elementObject.attachEvent("on" + eventName, functionObject);
    }

    /* Resizing function is not required now everything inside commom table*/
    AddEventHandler(window, "resize", resizefunction);
    AddEventHandler(window, "load", resizefunction);

    function isIE11() {
        return !!navigator.userAgent.match(/Trident.*rv[ :]*11\./);
    }

    function resizefunction() {

        var bodydiv = document.getElementById('DataGridBodyDiv');
        var headerdiv = document.getElementById('DataGridHeaderDiv');
        var footerdiv = document.getElementById('DataGridFooterDiv');
        var parentdiv = document.getElementById('DataGridParentDiv');
        if (parentdiv.offsetParent == document.body)
            document.body.style.height = '100%';

        var parentdivheight = parentdiv.offsetParent.offsetHeight;
     //   parentdiv.style.height = parentdivheight;
        try {
            //bodydiv.style.height = parentdivheight - headerdiv.offsetHeight - footerdiv.offsetHeight;
         } catch (e) { } //headerdiv.offsetHeight -
      //  bodydiv.style.width = '100px';
      //  bodydiv.style.width = parentdiv.clientWidth;

        if (parentdivheight > 0) {
            try {
                var Grid1 = ISGetObject("WebGridForLayout");
                window.setTimeout(function () {
                    wgDoResize(true, true);
                }, 200);
                if (!(Grid1 == 'undefined' || Grid1 == null)) {
                    if (isIE11()) {
                       // Grid1.SetHeight(parentdivheight - 10 + "px");
                    }
                }
            }
            catch (e) {

            }

        }
        bodydiv.style.overflow = 'auto';
        parentdiv.style.overflow = 'hidden';
    }        
</script>
<body style="overflow: auto;height:100%">

    <script>
        se.ui.messageDialog.setGlobalOptions({
            localization: {
                closeButtonCaption: "<%=_Skrm.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                okButtonCaption: "<%=_Skrm.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
                cancelButtonCaption: "<%=_Skrm.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                showDetailsCaption: "<%=_Skrm.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                hideDetailsCaption: "<%=_Skrm.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
            }
        });
        function DisplayErrorMessage(strMessage) {

            var strHdrMsg = '<%=_Skrm.GlobalResourceSet.GetString("GridView_PageTitle")%>';
             se.ui.messageDialog.showError(strHdrMsg, strMessage);
         }
         function DisplaySuccessMessage(strMessage) {

             var strHdrMsg = '<%=_Skrm.GlobalResourceSet.GetString("GridView_PageTitle")%>';
             se.ui.messageDialog.showAlert(strHdrMsg, strMessage);
         }
         </script>

    </script>


<div id="DataGridParentDiv" style="height:100%">
            <form id="form1" runat="server" style="height:100%">
            <%=System.Web.Helpers.AntiForgery.GetHtml()%>
            <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(_ThemePath)%>Common/StyleSheet/Global.css" /> 
                 <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(_ThemePath)%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
                <script src="<%=JSPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
                    <div id="DataGridHeaderDiv" style="height:17%">
                         <table style="width:100%;margin:auto;border-width:0;border-spacing:0px">                    
                           <tr>
                            <td rowspan="2" style="vertical-align: middle;width:40px;text-align:center;">
                                <img src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(_ThemePath)%>Repository/ListControl/images/icons-ribbon/form-default.png" style="vertical-align:middle" />
                            </td>
                            <td class="MainHeading"><%=_Skrm.GlobalResourceSet.GetString("GridView_NewConfiguration")%></td>
                            </tr>
                            <tr>
                                <td class="description" style="padding-bottom:10px;">
                                   <%=_Skrm.GlobalResourceSet.GetString("GridView_NewConfigurationDesc")%>
                                </td>
                            </tr>                    
                        </table>                         
                     </div> 
                     <div id="DataGridBodyDiv" style="height:75%">
                        <table style="width:98%;border-width:0;border-spacing:1px;margin:auto;height:30%"   class="tablebg" >                                                                                  
                            <tr>
                                <td class="lefttdbg" id="tdName" runat="server" style="width:50%;padding:6px" >
                                    <span class="subtitle">
                                        <%=_Skrm.GlobalResourceSet.GetString("GridView_ConfigurationDesc")%>
                                    </span> <br />
                                           <span class="description">
                                        <%=_Skrm.GlobalResourceSet.GetString("GridView_ConfigDetDesc")%>
                                    </span>                            
                                </td>
                                <td class="righttdbg" style="padding:6px;width:50%;">                                                                                                       
                                   <asp:DropDownList ID="ddlConfigNames" runat="server" CssClass="inputselect" Width="175px" AutoPostBack="true" ></asp:DropDownList>                                                                           
                                </td>                                                                     
                            </tr>
                           
                            <tr>
                                <td class="lefttdbg" runat="server" style="width:50%;padding:6px;" >
                                    <span class="subtitle">
                                        <%=_Skrm.GlobalResourceSet.GetString("GridView_Name")%>
                                    </span><br />
                                           <span class="description">
                                        <%=_Skrm.GlobalResourceSet.GetString("GridView_NameDesc")%>
                                    </span>                            
                                    
                                </td>
                                <td class="righttdbg" style="width:50%;padding:6px;">                                                                                                       
                                   <asp:TextBox ID="txtViewName" runat="server" CssClass="inputtext" MaxLength="50" Width="172px" ></asp:TextBox>  
                                </td>                                                                     
                            </tr>
                        </table>                   
                    
                            <table style="width:100%;border-width:0;border-spacing:1px;margin:auto;height:65%" >                                
                                <tr style="height:100%">                                    
                                    <td class="rightdbg" style="padding:6px;height:100%" >         
                                    <div style="height:100%">                                                                                                                
                                         <ISWebGrid:WebGrid  id="WebGridForLayout" runat="server" height="100%" horizontalalign="NotSet"  Width="100%"  
                                                AllowAutoDataCaching="false"  DataCacheStorage="PageCache"  ViewStateStorage="None" DisableFileSystemChecking="true" EnableWebResources="never" >                    
                                                <LayoutSettings  GroupByBoxVisible="false"  AutoFitColumns="true" AllowGrouping="No" AllowColumnMove="Yes" AllowColumnSizing="yes" AllowSelectColumns="Yes"  
                                                AllowSorting="Yes" AllowFilter="Yes" AlwaysShowHelpButton="false"   PagingMode="None" ShowRefreshButton="false"    VirtualPageSize="10"  CellClickAction="RowSelect"  UseRelativePositioning="true" PersistRowChecker="false"   AllowAddNew="No" AlternatingColors="true"  
                                                GridLineStyle="Solid" GridLineColor="#afafaf" CellPaddingDefault="2" RowHeightDefault="20px" GridLines="None" FilterBarVisible="false" AutoWidth="false" RowHeaders="No">
                                                <HeaderStyle Wrap="false" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CssClass="GridHeaderStyle"></HeaderStyle>                                                            
                                                <FocusCellStyle CssClass="GridFocusCellStyle"></FocusCellStyle>
                                                <GroupRowInfoStyle CssClass="GridGroupRowInfoStyle"></GroupRowInfoStyle>                          
                                                <GroupByBox>
                                                    <LabelStyle CssClass="GridLabelStyle"></LabelStyle>
                                                    <Style BackColor="#ececec" ></Style>                            
                                                </GroupByBox>                                                            
                                                <FrameStyle GradientType="Vertical" CssClass="GridFrameStyle"></FrameStyle>
                                                <SelectedRowStyle CssClass="GridSelectedRowStyle"></SelectedRowStyle>                           
                                                <AlternatingRowStyle  CssClass="GridAlternatingRowStyle" OverflowX="hidden" OverflowY="hidden"></AlternatingRowStyle>
                                                <StatusBarStyle CssClass="GridStatusBarStyle">
                                                    <Padding Top="2px" Left="2px" Bottom="2px" Right="2px"></Padding>
                                                </StatusBarStyle>                            
                                                <RowStyle CssClass="GridRowStyle" Overflow="hidden" OverflowX="hidden" OverflowY="hidden"></RowStyle>                            
                                                <LostFocusRowStyle CssClass="GridLostFocusRowStyle"></LostFocusRowStyle> 
                                                <EditTextboxStyle CssClass="GridEditTextBoxStyle"></EditTextboxStyle>
                                                <EditFocusCellStyle CssClass="GridEditFocusCellStyle"></EditFocusCellStyle>                                                                                                                                  
                                                <TextSettings Language="UseCulture">
                                                </TextSettings>
                                                <ClientSideEvents OnColumnContextMenu="HideGroupByItem"></ClientSideEvents>
                                                </LayoutSettings>                                                
                                                
                                                <RootTable GridLineStyle="NotSet" TableHeaderVisible="False"  >                                     
                                                <TableHeaderStyle GradientType="Vertical"  CssClass="GridTableHeaderStyle">
							                        <Padding Bottom="4px" Left="4px" Top="4px" Right="4px"></Padding>
							                    </TableHeaderStyle>   
							                    							
                                                </RootTable>
                                                
                                            </ISWebGrid:WebGrid>                                     
                                   </div> 
                                    </td>                                                                   
                                </tr>
                               
                        </table> 
                   </div>
    
        <div id="DataGridFooterDiv" style="height:8%;text-align:right;vertical-align:bottom;padding-right:8px">
                <asp:Button ID="btnResetLayout" buttonsecondary-skbtn="submit" runat="server" OnClientClick="return AssignResetValue()" />                             
                <asp:Button ID="btnClose" buttonsecondary-skbtn="submit" runat="server" OnClientClick="CloseWindow()"  />                                        
                <asp:Button ID="btnSaveLayout" class="inputbutton" runat="server" OnClientClick="return AssignValue()"  />                       
       </div>
        <asp:HiddenField ID="hidConfigname" runat="server" />  
        <asp:HiddenField ID="hidSavelayout" runat="server" />  
    
    </form>
</div>
</body>
</html>
