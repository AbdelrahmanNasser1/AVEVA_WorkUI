<%@ Page Language="C#" AutoEventWireup="true"  Inherits="Workflow.NET.CodeBehind.InvokeWS.ListWebServices"  Theme="" StylesheetTheme=""%>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>


<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>"<%:PageTitle%>"</title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script>
	    <style>
        html, body {
            height: 100%;
            width: 100%;
            overflow: hidden;
        }

  
    </style>
 </head>
    <script language="JScript" type="text/javascript">
		
		//var CtrlId=-1;
		var CtrlId="WebGrid1";
		function WebGrid1_OnRowSelect(controlId, tblName, rowIndex, rowEl)
		{
		    var c=document.getElementById("chkPrv");
		    if (c==null) return;
		    if (!c.checked) 
		    {
		        //chkPrv_OnClick();
		        return;
		    }
		        
		    CtrlId=controlId;
			var WebGrid1 = ISGetObject(controlId); 
			var row = WebGrid1.GetSelectedObject().GetRowElement();
			var WSId = wgGetCellByName(row, "ID"); 
			var QryString=document.getElementById("hQryString").value;
			var o=document.getElementById("ifWSMthds");
			o.src="PreviewWSMethods.aspx?ServiceId=" + WSId.innerText + QryString;

			return true;
		}

		function ShowPreviewMethods() {		    
		    
		    if (CtrlId<0) return; 
		    var WebGrid1 = ISGetObject(CtrlId); 
 		if(WebGrid1.GetSelectedObject())
		    {
			var row = WebGrid1.GetSelectedObject().GetRowElement();
			var WSId = wgGetCellByName(row, "ID"); 
			var QryString=document.getElementById("hQryString").value;			
			var o=document.getElementById("ifWSMthds");
			o.src="PreviewWSMethods.aspx?ServiceId=" + WSId.innerText + QryString;
		    }
		    else
		    {
		        //alert('Please select a row to preview the methods.')
 		    //alert('<%=GR.GetString("ws_Webservice_PreviewMetodalert")%>');
 		    ShowMessagesWithBellyBar(2, '<%=GR.GetString("ws_Webservice_PreviewMetodalert")%>');
		    }

		}
		function WebGrid1_OnRowContextMenu(gridId, rowType, rowEl, rowMenu)
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
//              // quit if not a record.
//              if (rowType != "Record") return true;              

              var row = wgGetGridById(gridId).GetSelectedObject().GetRowElement();
              var Id = wgGetCellByName(row, "ID"); 
              var URL = wgGetCellByName(row, "WebServiceURL");
              var cMenuCaptions=document.getElementById("hMenuCaptions");

              var arrMnuCaptions=cMenuCaptions.value.split(',');
              //rowMenu.add( new MenuItem(arrMnuCaptions[0],function() {EditWebService(Id.innerText);},"../Images/wsedit.gif" ));
              
              var menuItem = new WebMenuItem(); 
              menuItem.Text = arrMnuCaptions[0];   
              menuItem.Name = "EditMenu";   
              menuItem.OnClick = "EditWebService('"+Id.innerText+"')";             
              menuItem.ImageURL="../Images/wsedit.gif";
              rowMenu.Items.Add(menuItem);  

              
              //rowMenu.add( new MenuItem(arrMnuCaptions[1],function() {DeleteWebService(gridId,Id.innerText);},"../Images/wsdelete.gif" ));
              var menuItem = new WebMenuItem(); 
              menuItem.Text = arrMnuCaptions[1];   
              menuItem.Name = "DeleteMenu";   
              menuItem.OnClick = "DeleteWebService('"+gridId+"','"+Id.innerText+"')";             
              menuItem.ImageURL="../Images/wsdelete.gif";
              rowMenu.Items.Add(menuItem);  

              //rowMenu.add( new MenuItem(arrMnuCaptions[2],function() {BindWebService(Id.innerText,URL.innerText);},"../Images/wsbind.gif" ));
              var menuItem = new WebMenuItem(); 
              menuItem.Text = arrMnuCaptions[2];   
              menuItem.Name = "BindMenu";   
              menuItem.OnClick = "BindWebService('"+Id.innerText+"','"+URL.innerText+"')";             
              menuItem.ImageURL="../Images/wsbind.gif";
              rowMenu.Items.Add(menuItem);  
              
              //rowMenu.add( new MenuItem(arrMnuCaptions[3],function() {RefreshWebService(gridId,Id.innerText);},"../Images/wsrefresh.gif" ));
              var menuItem = new WebMenuItem(); 
              menuItem.Text = arrMnuCaptions[3];   
              menuItem.Name = "RefreshMenu";   
              menuItem.OnClick = "RefreshWebService('"+gridId+"','"+Id.innerText+"')";             
              menuItem.ImageURL="../Images/wsrefresh.gif";
              rowMenu.Items.Add(menuItem);                 
              return true;

        }    
        
        function EditWebService(WSId)
        {
            //alert(WSId);
            var QryString=document.getElementById("hQryString").value;
            window.location.href="NewWS.aspx?ServiceId=" + WSId + QryString;
        }
        
        function BindWebService(WSId,WSDLURL)
        {
            //alert(WSId + "##" + WSDLURL);
            var QryString=document.getElementById("hQryString").value;
            //alert(QryString);
            //window.location.href="ListMethods.aspx?ServiceId=" + WSId + "&WSDL_URL=" + WSDLURL + QryString 
            window.location.href="WSFields.aspx?ServiceId=" + WSId + "&WSDL_URL=" + WSDLURL + QryString 
        }
        
        function RefreshWebService(gridId,WSId)
        {
            //alert(WSId);
//            var QryString=document.getElementById("hQryString").value;
//            window.location.href="NewWS.aspx?ServiceId=" + WSId + QryString;

            var grd = wgGetGridById(gridId);
            grd.AddInput("Purpose","Refresh")
            grd.SendCustomRequest(); 
            return true;

        }
        
        function DeleteWebService(gridId,WSId)
        {
            var grd = wgGetGridById(gridId);
            grd.AddInput("Purpose","Delete")
            grd.SendCustomRequest(); 
            return true;

        }

        function WebGrid1_OnCellDblClick(gridId, tblName, rowIndex, cellIndex, cellEl)
        {
            try
            {
                var grid = wgGetGridById(gridId);
                var row = wgGetGridById(gridId).GetSelectedObject().GetRowElement();

                var rowType = row.type;

                // quit if not a record.
                if (rowType != "Record") return true;

                var Id = wgGetCellByName(row, "ID");

                EditWebService(Id.innerText);
            }
            catch (Err)
            {

            }

            return true;
        }

        function chkPrv_OnClick()
        {
            var c=document.getElementById("chkPrv");
		    if (c!=null) 
		    {
		        if (c.checked) 
		        {
		            ShowPreviewMethods();
		            return;
		        }
		    }
		    var o=document.getElementById("ifWSMthds");
			o.src="PreviewWSMethods.aspx?ServiceId=";
        }
		
        
</script>

<body style="padding-left:10px;padding-right:10px">
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(PdCtrl.GetCommonRelativeUrl("stylesheet/Global.css"))%>" rel="stylesheet" type="text/css">
        <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(themePath)%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
        <script>
            // Initialize locales for message dialog
            se.ui.messageDialog.setGlobalOptions({
                localization: { // All localization related default can be set
                    closeButtonCaption: "<%=GR.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                    okButtonCaption: "<%=GR.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                    cancelButtonCaption: "<%=GR.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                    showDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                    hideDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
                }
            });

            function ShowMessagesWithBellyBar(messageType, messageToDisplay)
            {
                var bellyBarTitle = "<%=GR.GetString("WS_Web Services") %>";
            switch (messageType)
            {
                case 1: se.ui.messageDialog.showAlert(bellyBarTitle, messageToDisplay);
                    break;
                case 2: se.ui.messageDialog.showError(bellyBarTitle, messageToDisplay);
                    break;
            }
        }
        </script>
        <script language="javascript">
        function openhelpinpdmode()
        {        
             window.open('<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(PdCtrl.GetHelpPageUrl(), false)%>WebService-WebServiceDetails.html','','height=450,width=600,resizable=yes,status=no,scrollbars=yes');
        }
        </script>
	    <div>
	        <table width="98%" border="0" cellpadding="0" cellspacing="1">
                <tr>
                  <td class="header" 
                      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="header2">
                    <tr class="ListHeaderCss"> 
                      <td width="95%" class="fontheading"><span class="subtitle"><%=l_WSTitle%></span></td>
                      <td width="5%" class="fontheading" style="padding-right:10px"><a href="#">
                      <img src="<%:PdCtrl.GetCommonRelativeUrl("images/main-help.gif")%>" alt="<%=GR.GetString("HelpAltText")%>"  border="0" onclick="javascript:openhelpinpdmode()"></a></td>
                    </tr>
                  </table></td>
                </tr>
	        </table>

			<table cellpadding="5" cellspacing="0" border="0" width="100%">
			<tr>
				<td>
				<div style="width:98%">
					<ISWebGrid:WebGrid ID="WebGrid1" runat="server" Height="200px" HorizontalAlign="NotSet"
						CellPaddingDefault="1"  Width="100%"  OnInitializeDataSource="WebGrid1_InitializeDataSource" OnInitializePostBack="WebGrid1_InitializePostBack" AllowAutoDataCaching=false DisableFileSystemChecking="true" EnableWebResources="never">
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
                                    <ClientSideEvents OnRowSelect="WebGrid1_OnRowSelect" OnRowContextMenu="WebGrid1_OnRowContextMenu" OnCellDblClick="WebGrid1_OnCellDblClick" />
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
                    </ISWebGrid:WebGrid>
				</div>
			
			</td>
			</tr>
			</table>
		
			  <table border="0" height="30" cellpadding="0" width="98%" cellspacing="0" >
				<tr>
					<td width="30%" >
						    <input type=checkbox ID="chkPrv" Width="150px" class="inputcheckbox" onclick="chkPrv_OnClick();" /><span class="description"> <%=l_WSPreviewMethods%></span>
						    <input type=hidden id="hQryString" value="<%:QryString%>" />
						    <input type=hidden id="hServiceIdRefresh" runat=server value="" />
						    <input type=hidden id="hMenuCaptions" value="<%=l_WSMnu_Edit%>,<%=l_WSMnu_Delete%>,<%=l_WSMnu_Bind%>,<%=l_WSMnu_Refresh%>" />
						</td>
					<td width="70%" style="text-align:right;padding-right:10px;padding-bottom:4px;" >
							<asp:Button ID="Button1" cssclass="inputbutton" runat="server"  Text="Add" OnClick="Button1_Click"/>
					</td>
				</tr>
				</table>
				 <table border="0" width="99%" cellpadding="0" cellspacing="0" style="flex-align:center">
				    <tr>
				        <td style="text-align:right;flex-align:center">
				            <iframe id="ifWSMthds" src="PreviewWSMethods.aspx" width="100%" height=180 marginwidth=0 style="border:none;text-align:right" ></iframe>
				        </td>
				    </tr>
				       <tr>
                          <td  class="lefttdbg" valign="bottom" height="20" >
                                <img src="<%:PdCtrl.GetThemeRelativeUrl("ProcessDesigner/Images/icon-tips.gif")%>" align=absmiddle  />
                               <span class="description"><%=GR.GetString("ws_listwebservices_selrow_Desc")%></span>
                           </td>
                        </tr>                 				    			    
				    
				</table>
        </div>
    </form>
     <script>

         function isIE11() {
             return !!navigator.userAgent.match(/Trident.*rv[ :]*11\./);
         }

         function ResizeGrid() {
             if (isIE11()) {
                 var grid = ISGetObject("WebGrid1");
                 grid.SetHeight(200 + 'px');
             }
         }

         ResizeGrid();

    </script>
</body>
</html>
