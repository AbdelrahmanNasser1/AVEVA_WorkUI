 <%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Package.CodeBehind.RunPackage" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>

<HTML>
<link href="<%=themePath%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />

  <HEAD id="HEAD1" runat="server">
		<title><%= resourceManager.GlobalResourceSet.GetString("pkg_run")%></title>
        <script src="../Common/JavaScripts/jquery.min.js"></script>
        <script src="../Common/JavaScripts/AutoLogoff.js"></script>
        <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
</HEAD>
 <script language="javascript" type="text/javascript">
     var pageTitle = "<%= resourceManager.GlobalResourceSet.GetString("pkg_run")%>";
     function GetRadWindow() {
         var oWindow = null;
         if (window.frameElement != null)
             oWindow = window.frameElement.radWindow;
         return oWindow;
     }
    
     function closeWindow(msg) {
         var oWindow = GetRadWindow();
         oWindow.close();
         if (msg)
             se.ui.messageDialog.showError(pageTitle, msg, null);
     }
     function ChangeWindowSize() {
         var oWindow = GetRadWindow();
         oWindow.setSize(820, 380);
     }
     function resizeWindow() {  
          
         var oWindow = GetRadWindow();
         //oWindow.setSize(800, 610);
     }
     function ErrorWindow() {         
         var oWindow = GetRadWindow();
         oWindow.setSize(400, 200);
     }
    function ValidatePackage()
    {
      document.getElementById("hidRunType").value  = "install";
      document.getElementById("mode").value  = "run";
      return true;
  }
 
</script>
<body id="Body" style="margin: 0; left: 0; overflow: auto; height: 100%" onload="ChangeWindowSize();" >
		<form id="Form1" method="post" runat="server">	
              <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
          <link href="<%=themePath%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />  
		<input type="hidden" name="hidRunType" id="hidRunType"	value="" />
		<input type="hidden" name="mode" id="mode"	value="" />
		
		 <table id="PageHeaderTable" width="94%" border="0" align="center" runat="server">
        <tr>
            <td class="pagetitle" colspan="4">
                <img src="<%=themePath%>/Repository/ListControl/images/icon-package-run.png" align="absmiddle" />
                <span class="pagetitle"><%= resourceManager.GlobalResourceSet.GetString("pkg_run")%></span>
            </td>
            <td class="description" align="right" nowrap = "true">
            <%=packageTitle%><%=packageVersion%>
            </td>
        </tr>
     
        <tr>
            <td style="height: 10px;">
            </td>
        </tr>      
          <tr>
        <td><span class="description"><%= resourceManager.GlobalResourceSet.GetString("pkg_InstallDesc")%> </span></td>
        <td>
<br />
 </td>
        </tr>  
    </table>
   
    <div id="BodyDiv">
                  
                    <table cellpadding="5" cellspacing="1" border="0" class="tablebg" width="94%" align="center">
                        <tr>
                            <td class="lefttdbg" valign="top" style="width: 41%">
                                <span class="subtitle">
                                    <%= resourceManager.GlobalResourceSet.GetString("pkg_InstallType")%> 
                                </span>
                                <br />
                                <span class="description">
                                    <%= resourceManager.GlobalResourceSet.GetString("pkg_InstallTypeDesc")%> 
                                </span>
                            </td>
                            <td class="righttdbg" style="width: 50%">
                                <asp:RadioButtonList id="radInstallationType" CssClass="inputradio" runat="server" RepeatDirection="Vertical"></asp:RadioButtonList>
                            </td>
                        </tr>
                       
                    </table>
                    </div>
                     <div id="FooterDiv">
                    <table id="footerTable" cellpadding="9" cellspacing="0" border="0" width="94%" align="right">
                        <tr>
                            <td id="footertd" class="pagetitle " colspan="2" align="right">
                                <asp:Button ID="btnOk" runat="server" CssClass="inputbutton" Text="Continue" />
                                &nbsp;
                                 <input id="btnClose" runat="server" type="button" onclick="javascript:closeWindow();" value="Close" class="inputbutton" />
                            </td>
                        </tr>
                    </table>
                </div>
		
			
		</form>
	</body>
</HTML>
