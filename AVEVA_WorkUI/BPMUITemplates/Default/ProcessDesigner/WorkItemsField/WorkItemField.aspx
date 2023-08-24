<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.Web.Designer.WorkItemsFieldPageCodeFile"
    Theme="" StylesheetTheme="" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>
<%@ Register TagPrefix="cc1" Namespace="Workflow.NET.Ajax" Assembly="Workflow.NET.NET2" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCType HTML>
<html style="height:100%">
<head id="Head1" runat="server">
    <title>
        <%=PageTitle%>
       
    </title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script> 
     <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script> 
      
    <style>
        html, body, form {
            height: 100% !important;
        }
    </style>
    <script>
 
        $(document).ready(function ()
        {
            var width = window.innerWidth;
            window.resizeTo(width + 28, 470);
        });

      
       
     function RefreshGrid()
     {   
          //var grid = ISGetObject("WebGrid1");
         var grid = wgGetGridById("WebGrid1");
         if (grid != null && grid != undefined)
          grid.Refresh();
          
     }

     function HidePadColumn(gridId) {

         var grid = ISGetObject(gridId);
         grid.HidePadColumn = true;
         //grid.RefreshAll();
         try {
             grid.GetRootTable().Columns[0].ResizeBestFit();
         } catch (e) { }
     }

     function RefreshGrid1()
     {
         var grid = ISGetObject("WebGrid1");         
         if (grid != null && grid != undefined)
            grid.Refresh();
        
     
     }
     function GridRefresh()
     {
        window.opener.RefreshGrid(); 
     }
     
     
    </script>

</head>



<script type='text/javascript' src='<%=JScriptPath%>'></script>

<body style="height:100%;padding-left:10px;padding-right:10px;padding-top:2px;overflow:hidden;">
    <form id="form1" runat="server" style="width:100%; height:100%;">
	<%=System.Web.Helpers.AntiForgery.GetHtml()%>
      <link rel="stylesheet" type="text/css" href="<%=PdCtrl.GetThemeRelativeUrl("Common/StyleSheet/Global.css")%>" />
      <link href="<%=themePath%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
      <link rel="stylesheet" type="text/css" href="<%:themePath%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
      <link rel="stylesheet" type="text/css" href="<%:themePath%>TelerikAjax/StyleSheet/AWTWindow/Window.css">
        <telerik:RadScriptManager ID="radScriptManager" runat="server"></telerik:RadScriptManager>
        <div id="divWorkItem" runat="server" style="height:100%">
            <table cellspacing="0" cellpadding="0" border="0" style="height:100%; width:100%">
                <tr>
                    <td valign="middle" style="height:5%" class="ListHeaderCss" colspan="2">
                        <table cellspacing="0" cellpadding="0" border="0" width="100%">
                            <tr>
                                <td valign="middle" height="25px" style="padding-left:10px" >
                                    <span class="fontheading">
                                        <%=PdCtrl.GlobalResourceSet.GetString("Wif_WorkItemField")%>
                                    </span>
                                </td>
                                <%if (_CheckFromPd == "false")
                                  {%>
                                <td valign="top"  width="25">
                                    <a href="#">
                                        <img alt="#" src="<%=PdCtrl.GetCommonRelativeUrl("images/main-help.gif")%>" "<%=PropertyHelp%>"
                                            title="<%=PdCtrl.GlobalResourceSet.GetString("wif_Imagehelp")%>" border="0" /></a></td>
                                <%}
                                  else
                                  { %>
                                <td valign="top" width="25" style="padding-right:10px">
                                    <a href="#">
                                        <img alt="#" src="<%=PdCtrl.GetCommonRelativeUrl("images/main-help.gif")%>" onclick="javascript:openhelpinpdmode()"
                                            title="<%=PdCtrl.GlobalResourceSet.GetString("wif_Imagehelp")%>" border="0" /></a></td>
                                <%} %>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="padding:0px; height:80%; vertical-align:top;">
                        <table width="100%" style="height:100%;border-spacing:0px" cellspacing="1" border="0">
                            <tr style="height:100%">
                                <td style="vertical-align:top; height:100%; padding:0px;overflow:auto;";>                                    
                                    <telerik:RadWindowManager ID="Singleton" Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false"
                                       runat="server" Behaviors="Close,Move" RenderMode="Classic" VisibleStatusbar="false" >      
                                    </telerik:RadWindowManager>
                                    <ISWebGrid:WebGrid ID="WebGrid1" runat="server" Height="300px" HorizontalAlign="NotSet"
                                        Width="100%" OnInitializeDataSource="WebGrid1_InitializeDataSource" OnPrepareDataBinding="WebGrid1_PrepareDataBinding"
                                        OnInitializeRow="WebGrid1_InitializeRow" OnInitializeLayout="WebGrid1_InitializeLayout"
                                        AllowAutoDataCaching="false" ViewStateStorage="None" DisableFileSystemChecking="true"
                                        EnableWebResources="never" >
                                        <LayoutSettings AllowExport="Yes" AutoWidth="true" AllowSorting="Yes" UseRelativePositioning="true"
                                            PersistRowChecker="True" AlwaysShowHelpButton="false" AllowAddNew="Yes" AlternatingColors="true"
                                            GridLineStyle="Solid" GridLineColor="221, 236, 254" CellPaddingDefault="2" RowHeightDefault="20px" AutoFitColumns="true"
                                            GridLines="None" RowHeaders="No">
                                            <HeaderStyle Wrap="false" Overflow="hidden" OverflowX="hidden" OverflowY="hidden"
                                                CssClass="GridHeaderStyle"></HeaderStyle>
                                            <FocusCellStyle CssClass="GridFocusCellStyle"></FocusCellStyle>
                                              <StatusBarCommandStyle Active-CssClass="GridStatusBarStyle" Normal-CssClass="GridStatusBarStyle" Over-CssClass="GridStatusBarStyle"> 
                                              </StatusBarCommandStyle>
                                            <GroupRowInfoStyle CssClass="GridGroupRowInfoStyle">
                                            </GroupRowInfoStyle>
                                            <GroupByBox>
                                                <LabelStyle CssClass="GridLabelStyle"></LabelStyle>
                                                <Style BackColor="#ececec"></Style>
                                            </GroupByBox>
                                            <EditTextboxStyle BorderStyle="None" BorderWidth="0px" Font-Size="8pt" Font-Names="Verdana">
                                            </EditTextboxStyle>
                                            <FrameStyle GradientType="Vertical" CssClass="GridFrameStyle">
                                            </FrameStyle>
                                            <AlternatingRowStyle CssClass="GridAlternatingRowStyle" OverflowX="hidden" OverflowY="hidden"></AlternatingRowStyle>
                                            <SelectedRowStyle CssClass="GridSelectedRowStyle"></SelectedRowStyle>
                                            <AlternatingRowStyle CssClass="GridAlternatingRowStyle" OverflowX="hidden" OverflowY="hidden">
                                            </AlternatingRowStyle>
                                            <StatusBarStyle CssClass="GridStatusBarStyle">
                                                <Padding Top="2px" Left="2px" Bottom="2px" Right="2px"></Padding>
                                            </StatusBarStyle>
                                            <RowStyle CssClass="GridRowStyle" Overflow="hidden" OverflowX="hidden" OverflowY="hidden">
                                            </RowStyle>
                                            <NewRowStyle CssClass="GridNewRowStyle">
                                            </NewRowStyle>
                                            <EditFocusCellStyle CssClass="GridEditFocusCellStyle">
                                            </EditFocusCellStyle>
                                            <ClientSideEvents OnEnterEditMode="WebGrid1_OnEnterEditMode" OnRowContextMenu="WebGrid1_OnRowContextMenu"
                                                OnBeforeDelete="javascript:CheckbeforeDelete()" OnInitialize="HidePadColumn"/>
                                            <TextSettings Language="UseCulture">
                                            </TextSettings>
                                            <ImageSettings RefreshImage="<%$ ReplaceTemplateExpn:Grid/images/refresh.png%>"
                                                 ExportImage="<%$ ReplaceTemplateExpn:Grid/images/Export.png%>"                                            
                                                 />
                                        </LayoutSettings>
                                        <RootTable GridLineStyle="NotSet">
                                        </RootTable>
                                    </ISWebGrid:WebGrid>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td style="vertical-align:middle; padding-left:10px; padding-bottom:10px; height:15%; width: 60%">
                                    <img src="<%=PdCtrl.GetCommonRelativeUrl("images/icon-warning.png")%>" />
                                    <span class="warningmsg">
                                        <%=PdCtrl.GlobalResourceSet.GetString("Wif_Warning")%>
                                    </span>
                    </td>
                    <td style="width:40%; padding-bottom:10px;height:15%;padding-right:0px; ">
                        <table border="0" >
                            <tr style="height:30%;">
                                <td style="width:90%;"> &nbsp;</td>
                                <td style="width:10%;">
                                    <asp:Button CssClass="inputsecondarybutton" ID="btnCancel" runat="server"/>
                                </td>
                                <td style="text-align: right;">
                                    <div id="divAddbtn" style="display: none; padding-left: 10px">
                                        <asp:Button CssClass="inputbutton" ID="btnAddNew" runat="server" />
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <div id="divAddWorkItemField" runat="server" style="width:100%;height:450px;">
            <table style="width:100%; border-spacing:0px;">
                <tr style="width:100%">
                    <td style="width:100%;padding:0px;height:400px;vertical-align:top;">
                        <table cellpadding="0" cellspacing="1" border="0" width="100%" style="border-spacing:0px">
                            <tr>
                                <td height="25" class="ListHeaderCss" style="width:100%; vertical-align:middle">
                                    <table cellspacing="0" cellpadding="0" border="0" width="100%">
                                        <tr>
                                            <td valign="middle" height="25" class="fontheading" style="padding-left: 10px">
                                                <span>
                                                    <%=PdCtrl.GlobalResourceSet.GetString("Wif_AddWorkitemField")%>
                                                </span>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <table width="100%" border="0" cellpadding="5" cellspacing="3" class="tablebg">
                                        <tr>
                                            <td width="40%" height="24" align="left" class="lefttdbg">
                                            <span class="subtitle">
                                                <%=PdCtrl.GlobalResourceSet.GetString("Wif_Name")%>
                                                </span>
                                                <img src="<%=PdCtrl.GetThemeRelativeUrl("hws/images/mandatoryicon.gif")%>" style="vertical-align: top" visible="true" />
                                            </td>
                                            <td width="60%" class="righttdbg">
                                                <asp:TextBox ID="txtName" MaxLength="250" CssClass="inputtext" runat="server"></asp:TextBox>&nbsp;&nbsp;
                                                <%if (showapplicationlevelcheckbox == "Y")
                                                  {  %>
                                                <asp:CheckBox ID="CheckapplicationScope" CssClass="inputcheckbox" runat="server" OnClick="setWorkTasksProState()" /><span class="description"><%=PdCtrl.GlobalResourceSet.GetString("Wif_ApplicationLevel")%></span>
                                                <%} %>
                                            </td>
                                        </tr>
                                        <tr>
                                           <td width="30%" height="24" align="left" class="lefttdbg">
                                            <span class="subtitle">
                                                <%=PdCtrl.GlobalResourceSet.GetString("Wif_DisplayName")%>
                                                </span><img src="<%=PdCtrl.GetThemeRelativeUrl("hws/images/mandatoryicon.gif")%>" style="vertical-align: top" visible="true" /></td>
                                            <td width="70%" class="righttdbg">
                                                <asp:TextBox ID="txtDisplayName" MaxLength="100" CssClass="inputtext" runat="server"></asp:TextBox>&nbsp;&nbsp;
                                                <%if (showapplicationlevelcheckbox == "Y")
                                                  {  %>
                                                <asp:CheckBox ID="IsWorkTasksProScope" CssClass="inputcheckbox" runat="server" /><span class="description"><%=PdCtrl.GlobalResourceSet.GetString("Wif_WorkTasksProScope")%></span>
                                                <%} %>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="24" align="left" class="lefttdbg">
                                            <span class="subtitle">
                                                <%=PdCtrl.GlobalResourceSet.GetString("Wif_Type")%>
                                                </span><img src="<%=PdCtrl.GetThemeRelativeUrl("hws/images/mandatoryicon.gif")%>" style="vertical-align: top" visible="true" /></td>
                                            <td class="righttdbg">
                                                <asp:DropDownList ID="ddlType" CssClass="inputselect" runat="server">
                                                </asp:DropDownList>
                                                <asp:HiddenField ID="hidType" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td  height="24" align="left" class="lefttdbg">
                                            <span class="subtitle">
                                                <%=PdCtrl.GlobalResourceSet.GetString("Wif_Defaultvaluetype")%>
                                                </span><img src="<%=PdCtrl.GetThemeRelativeUrl("hws/images/mandatoryicon.gif")%>" style="vertical-align: top" visible="true" /></td>
                                            <td class="righttdbg">
                                                <select id="ddlValueType" class="inputselect" runat="server" name="ddlValueType" onchange="ChangeValType()">
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                           <td  height="24" align="left" class="lefttdbg">
                                            <span class="subtitle">
                                                <%=PdCtrl.GlobalResourceSet.GetString("Wif_Defaultvalue")%>
                                                </span></td>
                                            <td  class="righttdbg">
                                                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                                    <tr>
                                                        <td width="10%">
                                                            <div id="divTxtBox">
                                                                <input type="text" maxlength="500" class="inputtext" id="txtDefaultValue" value="" runat="server"/>
                                                            </div>
                                                            <div id="divDropDown" style="display: none">
                                                                <select id="ddlContentsVariables" name="ddlContentsVariables" class="inputselect" onchange="ChangeXmlVariable(this);">
                                                                </select>
                                                            </div>
                                                        </td>
                                                        <td style="padding-right:0px;padding-left:2px; text-align: right; width: 10%">
                                                            <input value="" class="inputtext" id="cmbLHS_Input" name="cmbLHS_Input" style="width: 150px;
                                                                display: none" onclick="ToggleTreeView('')" />
                                                            <div id="treeDiv" style="position: absolute; display: none; border: solid 1px; width: 150px;
                                                                background: white; height: 150px; overflow: auto; overflow-x: auto; text-align:left">
                                                            </div>
                                                        </td>
                                                        <td style="padding-left: 4px; width: 10%">
                                                            <img alt="" id="cmbLHS_Image" src="<%=PdCtrl.GetCommonRelativeUrl("Images/down-arrowLatest.gif")%>"
                                                                style="display: none;" class="ComboBoxImageNew" onclick="ToggleTreeView('')" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="99%" align="right" colspan="2" class="lefttdbg" style="padding-right:10px;padding-top:100px;">
                                                <asp:Button ID="btnAddWorkItemFieldCancel" CssClass="inputsecondarybutton" runat="server" />&nbsp;
                                                <asp:Button CssClass="inputbutton" ID="btnSetCustomFields" runat="server" OnClick="SetWorkItemFieldsButton_Click" OnClientClick="return ValidateData()"  />
                                                <asp:Button ID="btnAddWorkItemField" CssClass="inputbutton" runat="server" OnClick="btnAddWorkItemField_Click"  OnClientClick="return ValidateData()" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <iframe id="IframeShim" scrolling="no" frameborder="no" style="position: absolute;
                    top: 0px; left: 0px; display: none;"></iframe>
            </table>
        </div>
        <cc1:AjaxPageControl ID="AjaxPageControl1" runat="server" Style="z-index: 104; left: 440px;
            position: absolute; top: 88px"></cc1:AjaxPageControl>

        <script src="<%=PdCtrl.GetJscriptUrl("javascript/XmlTreeView.js")%>"></script>

        <script language="javascript" type="text/javascript">
   
      function openhelpinpdmode()
     {
        window.open("<%=PdCtrl.GetHelpPageUrl()%>WorkitemFields.html",'','height=450,width=600,resizable=yes,status=no,scrollbars=yes');
     }
      
      var CheckPdflag="";
      checkpdflag();   
        function checkpdflag()
        {
         CheckPdflag='<%=_CheckFromPd%>';
         if(CheckPdflag=='true')
         {
            if(document.getElementById("divAddbtn") !=null )
               document.getElementById("divAddbtn").style.display='block';    
         }
        }   
        
            function ShowPackageWindow(guidItem)
            {
                var application = '<%=_ApplicationName%>';

                var url = "../../Package/PackageList.aspx?&mode=WorkItemField" + "&AppName=" + application + "&GuidForDropDown=" + guidItem;

                mywindow = radopen(url, null);
                mywindow.set_modal(true);
                mywindow.set_title("Work Item Field");
                mywindow.setSize(400, 320);

                // mywindow = window.open(url, "WinWorkItemFields1", "location=10, status=0, scrollbars=0, width=950, height=600, resizable=yes");
                // mywindow.moveTo(10, 10);
                return false;
            }

     function WebGrid1_OnRowContextMenu(gridId, rowType, rowEl, rowMenu)
      {     
      
            checkpdflag();
            // quit if not a record.
            var i;
            var grid = wgGetGridById(gridId);	                 
            if (rowType != "Record") return true;	
            if(rowType =="Record")
                { 
                    // hide the default context menu
                    for (i=0;i<=43;i++)
                    {                                  
                        if(i!=22)
                            rowMenu.Items[i].Hide();                  
                    }                                                  
                } 			        
           
                var row = wgGetGridById(gridId).GetSelectedObject().GetRowElement();
                var cellName = wgGetCellByName(row, "Name"); 
                var Id=cellName.getAttribute("hiddenData1");                
                var Name=cellName.innerText;
                var cellDisplayName = wgGetCellByName(row, "DisplayName");
                var DisplayName=cellDisplayName.innerText;
                var cellType=wgGetCellByName(row, "Type");
                var Type=cellType.innerText;//removed escape after json changes
                var MappedColumnValue=cellType.getAttribute("hiddenData1");
                var CellDefaultValue=wgGetCellByName(row, "DefaultValue");
                var DefaultValue=escape(CellDefaultValue.innerText);  
                var OriginalType=CellDefaultValue.getAttribute("hiddenData1");
                var strSetWorkItemField="<%=PdCtrl.GlobalResourceSet.GetString("Wif_SetWorkItemFields")%>";
                var strUnSetWorkItemField="<%=PdCtrl.GlobalResourceSet.GetString("Wif_UnSetWorkItemFields")%>";                                         
         if (CheckPdflag == 'false') {
             //rowMenu.add( new MenuItem("Set WorkItemField",function() {SetWorkItemField(Id,Name,DisplayName,Type,MappedColumnValue,DefaultValue,'set');},"" ));				
            
             var menuItem = new WebMenuItem();
             menuItem.Text = strSetWorkItemField;
             menuItem.Name = "SetWorkItemFieldSet";
             menuItem.OnClick = "SetWorkItemField('" + Id + "','" + Name + "','" + DisplayName + "','" + OriginalType + "','" + MappedColumnValue + "','" + DefaultValue + "','" + 'set' + "')";
             menuItem.ImageURL = "<%=Workflow.NET.TemplateExpressionBuilder.GetUrl(@"HWS/images/Workitem-Fields-set.png").ToString()%>"; 
             rowMenu.Items.Add(menuItem);

             //rowMenu.add( new MenuItem("UnSet WorkItemField",function() {SetWorkItemField(Id,Name,DisplayName,Type,MappedColumnValue,DefaultValue,'unset');},"" ));				
             var menuItem1 = new WebMenuItem();
             menuItem1.Text = strUnSetWorkItemField;
             menuItem1.Name = "SetWorkItemFieldUnSet";
             menuItem1.OnClick = "SetWorkItemField('" + Id + "','" + Name + "','" + DisplayName + "','" + OriginalType + "','" + MappedColumnValue + "','" + DefaultValue + "','" + 'unset' + "')";
             menuItem1.ImageURL = "<%=Workflow.NET.TemplateExpressionBuilder.GetUrl(@"HWS/images/Workitem-Fields-unset.png").ToString()%>";  
             rowMenu.Items.Add(menuItem1);
         }

         if (CheckPdflag == 'true')
         {
             var menuItemPkg = new WebMenuItem();
             menuItemPkg.Text = "<%=PdCtrl.GlobalResourceSet.GetString("Add to Package Template")%>";
             menuItemPkg.Name = "<%=PdCtrl.GlobalResourceSet.GetString("Add to Package Template")%>";
             menuItemPkg.ImageURL = "<%=Workflow.NET.TemplateExpressionBuilder.GetUrl(@"HWS/images/icon-package.png").ToString()%>";  
             menuItemPkg.OnClick = "ShowPackageWindow('" + Id + "')";
             rowMenu.Items.Add(menuItemPkg);
         }

         return true;
     }

       function ChangeXmlVariable(cmdctl)
       {
           
           var varType = document.getElementById("ddlValueType");
           if(varType.value=="XmlVariables")
           {
               document.getElementById("cmbLHS_Input").style.visibility = "visible";
               document.getElementById("cmbLHS_Input").style.display="block";
               document.getElementById("cmbLHS_Image").style.visibility = "visible";
               document.getElementById("cmbLHS_Image").style.display="block";
               OnChangeVaraiable('',cmdctl);
           }
           else
           {
               document.getElementById("cmbLHS_Input").style.display = "none";
               if (document.getElementById("treeDiv") != null) {
                   document.getElementById("treeDiv").style.display = "none";
                   document.getElementById("treeDiv").style.visibility = "hidden";
               }
               document.getElementById("cmbLHS_Image").style.display = "none";
               
           }
       
       } 
       function CheckbeforeDelete()
       {            
            var getconfirm= confirm("<%=jsConfirmMsg %>");
            if (getconfirm== true)
             {
                return true;
             }
             else
             {
                return false;
             }
       }
        </script>

        <script language="javascript" type="text/javascript">
    
    
   
    
    function AddWorkItemField()
    {
        var width = screen.width;
        var height = screen.availHeight;
        var left = (width - 600) / 2;
        var top = (height - 500) / 2;
      mywindow = window.open(AddWorkItemFieldUrl(location.href), "WinWorkItemFields", "location=0, status=0, scrollbars=0, width=600, height=500, resizable=no, left=" + left + ", top=" + top);
      //mywindow.moveTo(0,0);
      return false;
     }          
          
    function AddWorkItemFieldUrl( currentUrl )
     {
        if( currentUrl.indexOf('?') >= 0 ) 
        {
            currentUrl += '&';
        }
        else 
        {
            currentUrl += '?';
        }
        
        currentUrl += 'div=divAddWorkItemField';
        return currentUrl;
    }
     function EditWorkItemField(id,name,dispname,type,defvalue)
    {
         var urlparameters = '&WrkItmMode=edit&Id=' + id + '&Name=' + name + '&DisplayName=' + dispname + '&Type=' + type + '&DefaultValue=' + defvalue;
         var width = screen.width;
         var height = screen.availHeight;
         var left = (width - 600) / 2;
         var top = (height - 293) / 2;
         mywindow = window.open(EditWorkItemFieldUrl(location.href + urlparameters), "WinWorkItemFields1", "location=0, status=0, scrollbars=0, width=600, height=293, resizable=yes, left=" + left + ", top= " + top);
      //mywindow.moveTo(0,0);      
      return false;
     }  
    function SetWorkItemField(id,name,dispname,type,mappedcolumn,defvalue,mode)
     {
       
        var width = screen.width;
        var height = screen.availHeight;
        var left = (width - 600) / 2;
        var top = (height - 293) / 2;
        var urlparameters = '&WrkItmMode=' + mode + '&Id=' + id + '&Name=' + name + '&DisplayName=' + dispname + '&Type=' + type + '&DefaultValue=' + defvalue + '&MappedColumn=' + mappedcolumn;
        
      mywindow = window.open(EditWorkItemFieldUrl(location.href + urlparameters), "WinWorkItemFields1", "location=0, status=0, scrollbars=0, width=600, height=293, resizable=no, left=" + left + ", top= " + top);
      //mywindow.moveTo(0,0);      
      return false;
     }           
          
    function EditWorkItemFieldUrl( currentUrl ) 
    {
        if( currentUrl.indexOf('?') >= 0 ) 
        {
            currentUrl += '&';
        }
        else 
        {
            currentUrl += '?';
        }
        
        currentUrl += 'div=divAddWorkItemField';
        return currentUrl;
    }
    
     function Close() 
     {
        window.close();
     }
     
    function CallbackSaveProperty(context, result, response)
    {
     
     if(result !=null && response.Error==false)
     {
       arrValues=new Array();
       arrValues=result;       
       
       var ValueType=arrValues[arrValues.length-1]; 
       var i;
       if(arrValues.length ==1 && ValueType!="SetValue")
       {
         divDropDown.style.display='none';
         // alert("<%=jsAlertMsgNoContents %>");  alert('No contents found.setting the default value.');  
         DisplayErrorMessage();
         document.getElementById("ddlValueType").value="SetValue"; 
         divTxtBox.style.display='block';      
       
       }
       else if(arrValues.length >1)
       {
         document.getElementsByTagName("select")["ddlContentsVariables"].options.length=0;
         for(i=0;i<=arrValues.length-2;i++)
         {
            var optName=arrValues[i];            
            var optNameArray=optName.split("$");
            addOption("ddlContentsVariables",optNameArray[0],optNameArray[1],i,"");                 
         
         }
         
         divDropDown.style.display='block';
         divTxtBox.style.display='none';
       
       }  
       else if(arrValues.length ==1 && ValueType=="SetValue")
       {
         divDropDown.style.display='none';
         divTxtBox.style.display='block';       
       }
       
       var varType = document.getElementById("ddlValueType");
       //if(varType.value=="XmlVariables")
       //{
        ChangeXmlVariable(document.getElementById("ddlContentsVariables"));
       //}
        
     }
     else if(response.Error==true)
     {
         // alert("<%=jsAlertMsgError %>");//alert('Error occured while processing.');
         se.ui.messageDialog.showError('<%=PdCtrl.GlobalResourceSet.GetString("Wif_AddWorkitemField")%>', '<%=jsAlertMsgError%>');
        // var ErrMsge='<%=jsAlertMsgError%>';
       //  DisplayProcessErrorMessage(ErrMsge);
     }
     
    }
 
       function LoadTreeview(datatype,nodetext,xpath)
        {
            var nodeText = "XmlVariables"+"."+document.getElementById("ddlContentsVariables").value+ ReplaceString(xpath.replace('$$','.'));

            var selectedvariableText = nodeText;
            Maximize(false,"treeDiv");
            document.getElementById("treeDiv").style.display="none";
           document.getElementById("treeDiv").style.visibility = "hidden";
           document.getElementById("IframeShim").style.visibility = "hidden";
           document.getElementById("cmbLHS_Input").value = selectedvariableText;

        }
        <%=assignxmltree%>

        function ReplaceString(xpath)
        {

          xpath = xpath.replace('$','.')

          var l = xpath.length;

          for (var i=0; i<l; i++)
          {
            var ch = xpath.charAt(i);

            if(ch=='$')
            {

                xpath = xpath.replace(ch,'.')
            }
          }
          return xpath;
        }
 
      function addOption(selectbox,text,value,position,selvalue)
       {
            //To Handled the logic of selecting the xml variable name in the 
            //Xmlvariable name drop down when we are setting the workitemfield.
            var optn = new Option;
            
            if(selvalue.indexOf('XmlVariables')>=0)
            {
                var xmlvarvalue=selvalue.split('XmlVariables.');
                var xmlvarnamearr=xmlvarvalue[1].split('.');
                var xmlvarname=xmlvarnamearr[0];
                
                 optn.text = text;
                 optn.value = value;                        
                 document.getElementsByTagName("select")[selectbox].options[position] =  optn;
                 if(xmlvarname==value)
                 {                    
                    document.getElementsByTagName("select")[selectbox].options[position].selected=true;                    
                 }  
                
            }
            else
            {
                optn.text = text;
                optn.value = value;                        
                document.getElementsByTagName("select")[selectbox].options[position] =  optn;
                if(selvalue==value)
                {                    
                    document.getElementsByTagName("select")[selectbox].options[position].selected=true;                    
                }
            }  
       }
    
    function test()
    {
          
           var grid = ISGetObject("WebGrid1");
           var row = grid.RootTable.GetRow(2);

           for (var i = 0; i < 2; i++)
           {
               row.Check();
               row = row.GetNextRow();
           }

    
    }
    function WebGrid1_OnEnterEditMode(gridId,tblName,editObject)
    {
        
        
        var row = wgGetGridById(gridId).GetSelectedObject().GetRowElement();
        var cellName = wgGetCellByName(row, "Name"); 
        var Id=cellName.hiddenData1;
        var Name=cellName.innerText;
        var cellDisplayName = wgGetCellByName(row, "DisplayName");
        var DisplayName=cellDisplayName.innerText;
        var cellType=wgGetCellByName(row, "Type");
        var Type=cellType.innerText;
        var CellDefaultValue=wgGetCellByName(row, "DefaultValue");
        var DefaultValue=escape(CellDefaultValue.innerText);
        var OriginalType=CellDefaultValue.getAttribute("hiddenData1");
        EditWorkItemField(Id,Name,DisplayName,OriginalType,DefaultValue);             
    
    }
   
   
   
    callonchange();
    function callonchange()
    {

      var flag='<%=flagChange%>';
      var SelValue='<%=SelType%>';
      if(flag==1)
      {
        arrEditValues=new Array();
        arrEditValues='<%=ArrVariables%>'; 
        
       if(arrEditValues.length >1)
       {
         document.getElementsByTagName("select")["ddlContentsVariables"].options.length=0;
          var outputValuesArr = arrEditValues.split(',')
            for (var i=0;i<outputValuesArr.length;i++)
            {
                if(outputValuesArr[i] != "")
                {
                    var optName=outputValuesArr[i];            
                    var optNameArray=optName.split("$");
                    addOption("ddlContentsVariables",optNameArray[0],optNameArray[1],i,SelValue);     
                
                }
            }
        
         divDropDown.style.display='block';
         divTxtBox.style.display='none';
         
         if(document.getElementById("ddlValueType").value=="XmlVariables")
         {
            ChangeXmlVariable(document.getElementById("ddlContentsVariables"));
            document.getElementById("cmbLHS_Input").value=SelValue;
         }
       }    
      } 
    }
    function ChangeValType() 
     {
        
        var ddlValue=document.getElementById("ddlValueType").value;               
        CallServerSideMethod(null, 'ChangeValue',"DataTableCondition",CallbackSaveProperty,'table',ddlValue);       
               
     }
     
     function ToggleTreeView()
        {                
        if (document.getElementById("treeDiv").style.visibility == "visible")
        {
            Maximize(false,'treeDiv');
            HideTreeView();            
        }
        else
        {
            ShowTreeView();
            Maximize(true,'treeDiv');
        }
        }

        function ShowTreeView(controlID)
        {
            
            var divControlObj = document.getElementById("treeDiv");

            divControlObj.style.visibility = "visible";
            divControlObj.style.display="block";
            divControlObj.style.position="absolute";
            var cmbLHSObj =document.getElementById("cmbLHS_Input");
            var x = findPosX(cmbLHSObj);
            var y = findPosY(cmbLHSObj);
            divControlObj.style.left = (parseInt(x)+1) + "px";
            divControlObj.style.top  = (parseInt(y)- 150 ) +"px";
              if(document.getElementById("Max"+controlID)!=null)
                                {
        
                                    hrefText="<A href=\"#\" onclick=\"Maximize(true,'"+ "treeDiv"+controlID +"')\">";
                                    document.getElementById("Max"+controlID).innerHTML= hrefText+ "<span style=\"font-family:verdana; font-size:7pt; text-decoration:none;\">"+"Maximize"+"</span></a>";
                        }
        }
        
        function OnChangeVaraiable(controlId,selectCtrl)
        {
            var selectedvar = selectCtrl.value;
            var divName = "treeDiv";

            document.getElementById(divName).innerHTML = "";

            
            if(selectedvar!="")
            {
                
                if(eval("obj"+selectedvar)!=null)
                {
                    eval("obj"+selectedvar).buildDOM(divName);

                    var strInnerHTML = document.getElementById(divName).innerHTML;
                    document.getElementById(divName).innerHTML = strInnerHTML.replace("<DIV><DIV>","");
                    document.getElementById(divName).style.zIndex=100;
                    
                              if(document.getElementById("Max"+controlId)!=null)
                                                {
            
                                                    hrefText="<A href=\"#\" onclick=\"Maximize(true,'"+ "treeDiv"+controlId +"')\">";
                                                    document.getElementById("Max"+controlId).innerHTML= hrefText+ "<span style=\"font-family:verdana; font-size:7pt; text-decoration:none;\">"+"Maximize"+"</span></a>";
                        }
                 }
               
            }     
         }

        function HideTreeView(controlID)
        {
            document.getElementById("treeDiv").style.visibility = "hidden";


        }
        
        
        
        function findPosX(obj)
        {
              var curleft = 0;
              if (obj.offsetParent)
              {
                    while (obj.offsetParent)
                    {
                          curleft += obj.offsetLeft
                          obj = obj.offsetParent;
                    }
              }

              else if (obj.x)
                    curleft += obj.x;

              return curleft;
        }

        function findPosY(obj)
        {
              var curtop = 0;
              if (obj.offsetParent)
              {
                    while (obj.offsetParent)
                    {
                          curtop += obj.offsetTop
                          obj = obj.offsetParent;
                    }
              }
              else if (obj.y)
                    curtop += obj.y;
              return curtop;
        }
     
                           
        </script>

        <script>
    
    function GetMOZBrowserversion()
    {
        var app=navigator.userAgent;
        if(app.indexOf("MSIE")>-1)
        {
            return 1;	
        }
        else if(app.indexOf("Firefox/1.5")>-1)
        {
            return 2;	
        }
        else
        {
            return 3;
        }
    }
    
    var i=GetMOZBrowserversion();
    if(i!=1)
    {
    
        RefreshGrid1();
    }

    var specialKeys = new Array();
    specialKeys.push(8); //Backspace
    function IsNumeric(e) {
        if (ddlType.selectedIndex == 2) {
            var keyCode = e.which ? e.which : e.keyCode;
            var result = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1);
            return result;
        } else {
            return true;
        }
    }
    function ValidateData()
    {                
        var numbersOnly = /^\d+$/;
        var decimalOnly = /^[0-9,.]*$/;
        var strMessage;

        var workitemFieldName = document.getElementById("txtName").value;
        var workitemFieldDisplayName = document.getElementById("txtDisplayName").value;
                
        var ddlValue1 = document.getElementById("ddlValueType").value;
        var txtDValue = document.getElementById("txtDefaultValue").value;
        var ddlGType = document.getElementById("ddlType").value;
               

         var iChars = "[#~&+\"\'<>|@!$%*^()=/{}?]\\;"; 
         for (var i = 0; i < workitemFieldName.length; i++) 
         {   
             if (iChars.indexOf(workitemFieldName.charAt(i)) != -1)
             {       
                 se.ui.messageDialog.showError('<%=PdCtrl.GlobalResourceSet.GetString("Wif_AddWorkitemField")%>', '<%=PdCtrl.GlobalResourceSet.GetString("Wif_EnterValidWorkItemFieldName")%>');
                return false;    
         
            } 
        }

        for (var i = 0; i < workitemFieldDisplayName.length; i++) 
        {   
             if (iChars.indexOf(workitemFieldDisplayName.charAt(i)) != -1)
             {       
                 se.ui.messageDialog.showError('<%=PdCtrl.GlobalResourceSet.GetString("Wif_AddWorkitemField")%>', '<%=PdCtrl.GlobalResourceSet.GetString("Wif_EnterValidWorkItemFieldDisplayName")%>');
                return false;    
         
            } 
        }

        

        
        if (ddlValue1 == "SetValue")
        {

            var iCharsForvalue = "<>%"; 

            for (var i = 0; i < txtDValue.length; i++) 
            {   
                 if (iCharsForvalue.indexOf(txtDValue.charAt(i)) != -1)
                 {       
                     se.ui.messageDialog.showError('<%=PdCtrl.GlobalResourceSet.GetString("Wif_AddWorkitemField")%>', '<%=PdCtrl.GlobalResourceSet.GetString("Wif_EnterValidWorkItemFieldDefaultvalue")%>');
                    return false;    
         
                 } 
            }

           
            if (!numbersOnly.test(txtDValue) && ddlGType == "number") {
                se.ui.messageDialog.showError('<%=PdCtrl.GlobalResourceSet.GetString("Wif_AddWorkitemField")%>', '<%=PdCtrl.GlobalResourceSet.GetString("Email_Res_Apprv_FailStatus")%>');
                return false;
            }
            else if (ddlGType == "datetime") {
                var res = Date.parse(txtDValue);
                if (res.toString().indexOf("NaN") > -1) {
                    se.ui.messageDialog.showError('<%=PdCtrl.GlobalResourceSet.GetString("Wif_AddWorkitemField")%>', '<%=PdCtrl.GlobalResourceSet.GetString("Email_Res_Apprv_FailStatus")%>');
                    return false;
                }
                return res.toString().indexOf("NaN") > -1 ? false : true;
            }
            else if (ddlGType == "decimal" && !decimalOnly.test(txtDValue)) {
                se.ui.messageDialog.showError('<%=PdCtrl.GlobalResourceSet.GetString("Wif_AddWorkitemField")%>', '<%=PdCtrl.GlobalResourceSet.GetString("Email_Res_Apprv_FailStatus")%>');
                return false;
            }
            else {
                return true;
            }
        }
        return true;
    }


         
    
        </script>



    </form>

    <script>
    //Added for retaining the selection whenever alert happens
    //due to duplicate workitem field getting entered etc.
   function callChangevalueType()
   {
     var checkflagsel='<%=ErrMsg%>';
     if(checkflagsel !='')
     {
        ChangeValType();         
     }
   }
    callChangevalueType();
     
    </script>
    <script>

        se.ui.messageDialog.setGlobalOptions({
            localization: {
                closeButtonCaption: "<%=PdCtrl.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                okButtonCaption: "<%=PdCtrl.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
                cancelButtonCaption: "<%=PdCtrl.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                showDetailsCaption: "<%=PdCtrl.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                hideDetailsCaption: "<%=PdCtrl.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
            }
          });

        function DisplayErrorMessage() {
            var strMessage = '<%=jsAlertMsgNoContents %>';
            var strHdrMsg = '<%=PdCtrl.GlobalResourceSet.GetString("Wif_AddWorkitemField")%>';
             se.ui.messageDialog.showError(strHdrMsg, strMessage);
        }
        function DisplayEmailErrorMessage(strMessage) {
            
            var strHdrMsg = '<%=PdCtrl.GlobalResourceSet.GetString("Wif_AddWorkitemField")%>';
            se.ui.messageDialog.showError(strHdrMsg, strMessage);
        }
        function DisplayProcessErrorMessage(strMessage) {

            var strHdrMsg = '<%=PdCtrl.GlobalResourceSet.GetString("Wif_AddWorkitemField")%>';
            se.ui.messageDialog.showError(strHdrMsg, strMessage);
        }
        function DisplayValidationMessage() {
           
            var strMessage = '<%=ErrMsg %>';
            var strHdrMsg = '<%=PdCtrl.GlobalResourceSet.GetString("Wif_AddWorkitemField")%>';
            se.ui.messageDialog.showError(strHdrMsg, strMessage);
        }

        

        function closeHandlerFn() {
            self.closeWindow(false);
        }

        function setWorkTasksProState() {

            var checkApplicationScope = document.getElementById("CheckapplicationScope").checked;
            if (checkApplicationScope == true) {
                document.getElementById("IsWorkTasksProScope").disabled = false;
            }
            else {
                document.getElementById("IsWorkTasksProScope").disabled = true;
                document.getElementById("IsWorkTasksProScope").checked = false;
            }
        }

    </script>

</body>
</html>
