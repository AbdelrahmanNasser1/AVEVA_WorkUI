<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SelectFormName.aspx.cs" Inherits="SelectFormName"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <link href="<%=cssPath%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title><%=GR.GetString("ec_testrun_selform_title")%></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
      <%--  <link rel="stylesheet" type="text/css" href="styles/aquila.css" />--%>

</head>
<script language="javascript">

function SizeToFit()
{
 var oWnd = GetRadWindow();  
 if (oWnd!=null)
 oWnd.setSize(400,300);  
}
function GetRadWindow()
{
  var oWindow = null;
  if (window.radWindow) 
      oWindow = window.radWindow;
  else if (window.frameElement!=null && window.frameElement.radWindow) 
      oWindow = window.frameElement.radWindow;
  return oWindow;
}    
</script>
<body onload="SizeToFit()">
    <form id="form1" runat="server">
     <%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <div>
    <table width="98%" height="120px" border="0" align="center" cellpadding="0" cellspacing="1" class="tablebg">
    <tr>
    <td class="lefttdbg" width="50%">
    <span class="subtitle"><%=GR.GetString("ec_testrun_selform_subtitle")%></span><br />
   <span class="description"><%=GR.GetString("ec_testrun_selform_desc")%></span>    
    </td>
    <td class="righttdbg">&nbsp;
     <asp:dropdownlist ID="drpFormsList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="FormsList_SelectedIndexChanged" CssClass="inputselect">
         </asp:dropdownlist>    
    </td>
      </tr>
    
    </table>
    <table width="100%" height="120px" border="0" align="center" cellpadding="0" cellspacing="1">
    <tr>
    <td>    
    <td align="right" class="lefttdbg">
    <asp:Button ID="btnSubmit" runat="server" Text="submit" CssClass="inputbutton" OnClick="btnSubmit_Click" />    
   </td></tr>
    
    </table>
    </div>
    </form>
</body>
</html>
