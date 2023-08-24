<%@ Page Language="C#" AutoEventWireup="true" Debug="true" Inherits="Skelta.Repository.Web.CodeBehind.ViewDownloadFile" %>
<%@ Register Assembly="Skelta.Forms.Web" Namespace="Skelta.Forms.Web" TagPrefix="cc1" %>

<!DOCTYPE HTML>
<html>
<head runat="server">
    <title></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
     <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <style type="text/css">
        html,body{height:100%;}
    </style>

    <script language="javascript" type="text/javascript">
        function Localizetext() {
           
            document.getElementById('btnClose').value = '<%=buttonclosetext %>';
            var oWindow = GetRadWindow();
            if (oWindow != null) { // condition for belly bar from report list.
                oWindow.show();
                document.getElementById('btnDownload').click();
                closeWindow();
            }
           
        }
function GetRadWindow()
{
   var oWindow = null;
  if (window.radWindow) 
	oWindow = window.radWindow;
  else if (window.frameElement.radWindow) 
	oWindow = window.frameElement.radWindow;
  return oWindow;
}
function closeWindow()
{
    try
    {
        var controlId = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(controlId, false)%>";
        var formsKey = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(formsKey, false)%>";
        if (controlId != undefined && controlId != '' && formsKey != undefined && formsKey != '')
        {
            self.parent["viewModelObject_" + formsKey].topLevelForm.popupObjectItem.state("close");
            return;
        }
        else
        {
            for (var i = 0; i < window.parent.dhtmlwindow.tobjects.length ; i++)
                window.parent.dhtmlwindow.tobjects[i].hide();
        }
    }
    catch (err)
    {
        try
        {
            var oWindow = GetRadWindow();
            oWindow.hide();
        }
        catch (err)
        {
            window.close();
        }
    }
}
    </script>
</head>
<body onload="javascript:Localizetext();" style="overflow:hidden;height:100%;">
     
    <form id="form1" runat="server" style="height:100%;">
        <link type="text/css" rel="stylesheet" href="stylesheet/skeltaform.css" />
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <table style="vertical-align:middle; height:100%;width:100%;">
            <tr>
                <td colspan="3" align="center" style="padding-bottom:10px;">
                    <span class="sf-attachradio">
                        <%=text1 %>
                    </span>
                </td>
            </tr>
            <tr align="right">
                <td colspan="3">
                    <asp:Button ID="btnView" Visible="false" CssClass="sf-inputsBox" runat="server" Text="View" />   
                    <asp:Button ID="btnClose"  CssClass="inputsecondarybutton" OnClientClick="javascript:closeWindow();return false;" runat="server" Text="Close" />
                    <asp:Button ID="btnDownload"  CssClass="sf-inputsBox" runat="server" Text="Download" />                                     
                    <asp:Label ID="InjectScript" runat="server"></asp:Label>
                </td>        
            </tr>
        </table>    
    </form>
</body>
</html>
