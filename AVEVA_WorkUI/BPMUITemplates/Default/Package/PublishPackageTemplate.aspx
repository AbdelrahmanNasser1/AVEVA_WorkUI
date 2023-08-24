<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Package.CodeBehind.PublishPackageTemplate" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>
<!DOCTYPE html>
<HTML>
  <HEAD id="HEAD1" runat="server">
		<title><%= resourceManager.GlobalResourceSet.GetString("pkg_pub")%></title>
      <script src="../Common/JavaScripts/jquery.min.js"></script>
       <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
      <style type="text/css">
          html, body {
              height: 100%;
          }
      </style>
</HEAD>
       <script type="text/javascript">
           function GetRadWindow() {
               var oWindow = null;
               if (window.frameElement != null)
                   oWindow = window.frameElement.radWindow;
               return oWindow;
           }

           function closeWindow() {
               var oWindow = GetRadWindow();
               window.parent.onclientCalled = false;
               window.parent.OnClientClose(oWindow);
               oWindow.close();
               window.parent.onclientCalled = null;
           }

           // Initialize locales for message dialog
           se.ui.messageDialog.setGlobalOptions({
               localization: { // All localization related default can be set
                   closeButtonCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                okButtonCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                cancelButtonCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                showDetailsCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                hideDetailsCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
            }
        });

        function showMessageAndClose(isError, message) {
            var pageTitle = '<%=resourceManager.GlobalResourceSet.GetString("pkg_pub") %>',
                self = window;

            if (isError) {
                se.ui.messageDialog.showError(pageTitle, message, closeHandlerFn);
            }
            else {
                se.ui.messageDialog.showAlert(pageTitle, message, closeHandlerFn);
            }

            // Only if it is a radWindow, hide it
            var oWindow = GetRadWindow();
            if (oWindow != null) {
                oWindow.hide();
            }

            function closeHandlerFn() {
                self.closeWindow(false);
            }
        }
    </script>

 <script type="text/javascript">

     function ChangeWindowSize() {
         //var oWindow = GetRadWindow();
         //oWindow.setSize(830, 400);
     }
     function resizeWindow() {
         var oWindow = GetRadWindow();
         oWindow.setSize(400, 200);
         oWindow.center();
     }
    
</script>
<body id="Body" style="margin: 0; left: 0; overflow: auto; height: 100%">
		<form id="Form1" method="post" style="height:100%;" runat="server">	
            <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <link href="<%=themePath%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
            <link href="<%=themePath%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
		<%if(logCount){ %>    
		<table id="pageHeaderTable" style="width:94%; border-width:0;margin:auto;" runat="server">
             <tr >
            <td class="pagetitle" colspan="4">
                <img alt="" src="<%=themePath%>/Repository/ListControl/images/icon-package-publish.png" style="vertical-align:middle" />
                <span class="pagetitle" >
                    <%= resourceManager.GlobalResourceSet.GetString("pkg_pub")%>  
                </span>
            </td>
           <td class="description" style="text-align:right;white-space: nowrap;">
            <%=packageTitle%><%=packageVersion%>
            </td>
        </tr>
        <tr>
            <td class="description" colspan=5>
                <%= resourceManager.GlobalResourceSet.GetString("pkg_publish_desc")%>
            </td>
        </tr>
        <tr >
        <td style="height:10px;"></td>
        </tr>        
    </table>
    <%}%>
		<table id="ErrorDetailsViewTable" style="border-spacing:1px;border-collapse:separate;width:94%;border-width:0;height:70%;margin:auto;vertical-align:middle" runat="server">
        <tr>
            <td style="text-align: center;padding-top:9%;" colspan="5" >
                <asp:Label ID="publishMessage" runat="server" Text="" CssClass="description" ></asp:Label>
            </td>
        </tr>
            <tr>
                <td style="bottom: 17px;right: 15px;position: absolute;" >
                    <input id="btnClose2" Value = "Close" runat="server" type="button" onclick="javascript: closeWindow();" class="inputbutton"  />
                    </td>
            </tr>
        <tr style="vertical-align:top">
            <td  id="LogHeader" class="lefttdbg" runat="server" style="height:90%;vertical-align:top;padding:8px">                
                
                <iswebgrid:webgrid id="errorDetailsView" tabindex="-1" runat="server" horizontalalign="NotSet"
                    allowautodatacaching="false" height="100%" disablefilesystemchecking="true"
                    enablewebresources="never" RenderingMode=HTML5 Width=99%>
                        <layoutsettings alternatingcolors="True" cellpaddingdefault="2" gridlinestyle="Solid"
                            gridlinecolor="224, 224, 224" rowheightdefault="22px" autoheight="false" allowsorting="Yes"
                            allowcolumnsizing="No" autofitcolumns="true" alwaysshowhelpbutton="false" allowexport="Yes">
                                                  
                                                     <HeaderStyle Wrap="false" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CssClass="GridHeaderStyle"></HeaderStyle>                
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
                                                    <GroupRowInfoStyle BackColor="#F1EFE2" BorderColor="White" BorderStyle="Solid" BorderWidth="1px"
                                                        Font-Names="Verdana" Font-Size="8pt">
                                                        <BorderSettings>
                                                            <Bottom Color="Silver" />
                                                            <Right Color="Silver" />
                                                        </BorderSettings>
                                                    </GroupRowInfoStyle>
                                                    <GroupByBox>
                                                        <LabelStyle BackColor="White" BorderColor="Navy" BorderStyle="Solid" BorderWidth="1px"
                                                            Font-Names="Verdana" Font-Size="8pt" />
                                                        <Style BackColor="Gray">
                                                            </Style>
                                                    </GroupByBox>
                                                    <EditTextboxStyle BorderStyle="None" BorderWidth="0px" Font-Names="Verdana" Font-Size="8pt">
                                                    </EditTextboxStyle>
                                                    <FrameStyle CssClass="GridFrameStyle">
                                                    </FrameStyle>
                                                    <SelectedRowStyle CssClass="GridSelectedRowStyle" />
                                                    <StatusBarStyle CssClass="GridStatusBarStyle">
                                                        <Padding Bottom="2px" Left="2px" Right="2px" Top="2px" />
                                                    </StatusBarStyle>
                                                    <RowStyle CssClass="GridRowStyle" />                                                        
                                                    <NewRowStyle CssClass="GridNewRowStyle">
                                                    </NewRowStyle>
                                                    <ScrollBarStyle ArrowColor="255, 192, 192" />
                                                    <TextSettings Language="UseCulture">
                                                    </TextSettings>                                                    
                                                </layoutsettings>
                        <roottable gridlinestyle="NotSet">
                                                </roottable>
                    </iswebgrid:webgrid>
            </td>
        </tr>
    </table>
			<table id="publishMessageTable"  style="border-spacing:1px; width:94%;margin:auto;border-width:0;visibility:hidden">
        
        <tr>   
            <td id="buttonOkColoum" runat="server" > 
            <asp:Button id="btnOk" runat="server" CssClass="inputbutton"  />
               
            <input id="btnClose" runat="server" type="button" onclick="javascript:closeWindow();" class="inputbutton" />
            </td>
        </tr>
    </table>
		</form>
	</body>
</HTML>