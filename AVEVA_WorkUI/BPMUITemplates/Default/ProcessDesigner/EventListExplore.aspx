<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EventListExplore.aspx.cs"
    Inherits="EventListExplore" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<%@ Register Assembly="Skelta.Repository.Web" Namespace="Skelta.Repository.Web.Lookup"
    TagPrefix="cc1" %>
<%@ Assembly Name="Workflow.NET.Web.Designer.NET2" %>
<%@ Import Namespace="Workflow.NET.Web.Designer" %>
<%@ Assembly Name="Workflow.NET.NET2" %>
<%@ Import Namespace="Workflow.NET" %>
<!DOCTYPE html>
<html>

<head id="Head1">
    <title>Event Associations<%= pagetitle %></title>
    <link href="<%=_designerControl.GetCommonRelativeUrl("stylesheet/Global.css")%>"
        rel="stylesheet" type="text/css" />

    <script type='text/javascript' src='<%=JScriptPath%>'>
    
    </script>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    
</head>
<style>        
        html, body {
            height:100%;
            overflow:hidden;
        }
</style>
<body scroll="yes" style="margin:10px">
    <form id="form1" runat="server" style="height:100%" >
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
         <link href="<%=cssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css" rel="stylesheet" type="text/css" />
         <link href="<%=cssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css" rel="stylesheet" type="text/css" />
        <table border="0" cellpadding="0" cellspacing="0" style="vertical-align:top;height:100%;width:100%">
            <tr>
                <td style="height:24px;vertical-align:top">
                    <table cellspacing="0" cellpadding="0" border="0" width="100%">
                        <tr >
                            <td class="fontHeading" style="height:24px;vertical-align:top">
                                    <%=_propertyName%>
                            </td>
                            <td valign="top" width="10" >
                                <!-- <a href="#"> </a> -->
                               <!-- <img id="helpimage" src="<%=_designerControl.GetCommonRelativeUrl("Images/main-help.gif")%>" /> --></td>
                        </tr>
                    </table>
                </td>
            </tr>
          
            <tr style="vertical-align:top">
                <td align="left" valign="top" >
                     
                    <table border="0" cellpadding="3" cellspacing="5" style="width:100%;height:100%;vertical-align:top">
                        <tr style="vertical-align:top">
                            <td colspan="2" style="height:24px;vertical-align:top" align="left" >
                                <asp:Label ID="lblhelp" runat="server" Text="" CssClass="subtitle" ForeColor="black"></asp:Label>
                            </td>
                        </tr>
                        
                        <tr  valign="top" style="height:24px;">
                            <td align="left" >
                                <asp:Label ID="lbllistexplorer" runat="server" Text="" CssClass="subtitle"></asp:Label>
                            </td>
                            <td >
                                <cc1:ListExplorer ID="listExplorer1" runat="server" />
                            </td>
                        </tr>
                        <tr id="trlookup" valign="top" runat="server" style="height:180px;">
                            <td align="left">
                                <asp:Label ID="lbllookup" runat="server" Text="Listitem " CssClass="description"></asp:Label>
                            </td>
                            <td>
                                <asp:Panel ID="listItemLookupPanel" Width="100%" runat="server">
                                </asp:Panel>
                            </td>
                        </tr>
                       
                    </table>
                </td>
            </tr>
            
            <tr>
               <td align="right" valign="bottom" style="padding-bottom: 10px;" height="20%"> 
                        <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
                        <td align="right">
                            <asp:Button ID="btnClose" CssClass="inputsecondarybutton" runat="server" OnClientClick="window.close();"
                                Text="Close" />
                            <asp:Button ID="btnSelect" CssClass="inputbutton" runat="server" Text="Select" OnClick="btnSelect_Click1" />
                        </td>
                    </table>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
