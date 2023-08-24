<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.ListExplorer" EnableEventValidation="true" EnableViewStateMac="true" ValidateRequest="true" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ Register Assembly="Skelta.Repository.Web" Namespace="Skelta.Repository.Web.Lookup"
    TagPrefix="cc1" %>
<!Doctype html>
<html style="height:100%" >
<head runat="server">
    <%--<title>List Explorer</title>--%>
<%--    <link rel="stylesheet" type="text/css" href="<%$ReplaceTemplateExpn:Repository/Site/styles/aquila.css%>" />

--%>  
 <link rel="stylesheet" type="text/css" href="<%$ReplaceTemplateExpn:Common/StyleSheet/Global.css%>" />
   <!--[if lt IE 7]>
  <script defer type="text/javascript" src="../../../Repository/Site/scripts/pngfix.js"></script>
  <![endif]-->
    <script src="../../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../../Common/JavaScripts/AutoLogoff.js"></script>
    <script type="text/javascript" language="javascript">
        
function GetRadWindow()
{
    
    var oWindow = null;
     oWindow = window.frameElement.radWindow;
    return oWindow;
} 

function setValues(id1)
{    
    var oWindow = GetRadWindow();
    if (typeof oWindow !== 'undefined' && oWindow.close) {
        oWindow.close(id1);
    }
}
function setSize() {
    this.parent.parent.parent.document.body.scrollTop = 0;
}



    </script>

</head>
<body onload="setSize()" style="height:90%;overflow:hidden;">
    <form id="form1" runat="server" style="height:100%">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
         <link href="<%=ThemeURL%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css" rel="stylesheet" type="text/css" />
         <link href="<%=ThemeURL%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css" rel="stylesheet" type="text/css" />
        <div style="height:100%">
            <table style="margin:0px auto;height:100%;border-spacing:1px;border-collapse:separate;">
                <tr>
                    <td style="height:10%;padding:2px;">
                        <table style="width:100%;border-spacing:0px;border-collapse:collapse;">
                            <tr>
                                <td class="pagetitle" style="padding:2px;">
                                    <img src="<%=ThemeURL%>Plugins/EnterpriseConsole/Images/Icon-ListExplorer.png"   align="absmiddle"/> <%=_ResManager.GlobalResourceSet.GetString("ListExplorer")%>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding:4px;">
                                    <asp:Label ID="lblhelp" runat="server" Text="" CssClass="description"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td style="height:70%;vertical-align:top">
                        <table border="0" width="98%" cellpadding="2" cellspacing="1" class="tablebg" align="center">
                            <tr>
                                <td class="lefttdbg" style="width:35%;">
                                    <asp:Label ID="lbllistexplorer" runat="server" Text="" CssClass="subtitle"></asp:Label>
                                </td>
                                <td style="width:50%" class="righttdbg">
                                    <cc1:ListExplorer ID="listExplorer1" runat="server" />
                                </td>
                            </tr>
                            <tr id="trlookup" runat="server">
                                <td class="lefttdbg">
                                    <asp:Label ID="lbllookup" runat="server" Text="Listitem " CssClass="subtitle"></asp:Label>
                                </td>
                                <td class="righttdbg">

                                    <asp:Panel ID="listItemLookupPanel" runat="server">
                                    </asp:Panel>                                   

                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td style="vertical-align:bottom;height:10%;">
                        <table style="width:100%;border-collapse:separate;border-spacing:2px;" >
                        <tr>
                        <td style="padding:2px;">
                        <asp:Label ID="lblValidation" runat ="server" Text="" CssClass="errormsg"></asp:Label>
                        </td>
                        </tr>
                            <tr>
                                <td style="width:100%;text-align:right;">
                                    <asp:Button ID="btnClose" CssClass="inputsecondarybutton" runat="server" OnClientClick="setValues('/');"
                                        Text="Close" />
                                </td>
                                <td style="text-align:right;height:50px;">
                                    <asp:Button ID="btnSelect" CssClass="inputbutton" runat="server" Text="Select" OnClick="btnSelect_Click1" />
                                </td>
                                
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
