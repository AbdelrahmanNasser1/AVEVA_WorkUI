<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FormExplorer.aspx.cs" Inherits="FormExplorer" Debug="true"%>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!doctype html>
<link rel="stylesheet" type="text/css" href="<%=cssPath %>Common/stylesheet/Global.css" />
<html>
<head runat="server">
    <title><%=formExplorer.GlobalResourceSet.GetString("XmlFormListExplorer")%></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
</head>
<body style="overflow:hidden">
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
           <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
         <link href="<%=cssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css" rel="stylesheet" type="text/css" />
         <link href="<%=cssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css" rel="stylesheet" type="text/css" />
		 <table width="100%" height="100%" valign="top" cellpadding="3" cellspacing="1">
			<tr height="100%">
				<td class="lefttdbg" align="center" height="100%" valign="top" >
        			<table width="100%" border="0" cellpadding="3" cellspacing="1" class="tablebg">
           				 <tr valign="top" >
                			<td align="left"  class="lefttdbg" width="50%">
								<span class="subtitle">
                    			<%=formExplorer.GlobalResourceSet.GetString("XmlForm")%>
								</span>
               				 </td>
               				 <td align="left" width="50%" class="righttdbg">
                    		<asp:Panel ID="pnl" runat="server" Height="100%" Width="100%">
                   			 </asp:Panel>
                		</td>
           		 	</tr>
            		<tr valign="top">
                		<td align="left" width="50%" class="lefttdbg">
							<span class="subtitle">
                    		<%=formExplorer.GlobalResourceSet.GetString("XmlFormVersion")%>
							</span>
                		</td>
                		<td align="left" width="50%" class="righttdbg">
                    		<asp:Panel ID="pnl2" runat="server" Height="100%" Width="100%">
                    		</asp:Panel>
                		</td>
           			 </tr>
        		</table>
    	    </td>
	    </tr>
        <tr valign="bottom">
            <td align="right" class="lefttdbg">
            <input type="button" runat="server" class="inputbutton" id="save" value="Get Schema"
            onclick="UpdateParent()"></td>
        </tr>
    </table>
    <script>
    function UpdateParent()
    {
        
        var formComboBox = $find('<%= formlistexplorerCombo.ClientID %>');
        var id = formComboBox.get_value();
       

        if (id == "00000000-0000-0000-0000-000000000000") {
            alert('<%=formExplorer.GlobalResourceSet.GetString("XmlInvalidFormVersion")%>');
            return;
        }
        else if (id == "") {
        alert('<%=formExplorer.GlobalResourceSet.GetString("XmlInvalidSelectionForm")%>');
        return;
        }
        var formVersionCombobox = $find('versionlookup_versionlookup_versionlookup');       
        version = formVersionCombobox.get_value();        
        window.parent.CallServerFormRefresh(id,version);
        window.frameElement.radWindow.close();
    }
    </script>
    </form>
</body>
</html>
