<%@ Page Language="C#" AutoEventWireup="true" Inherits="BPMUITemplates_Default_SkeltaForms_DeleteControl"%>

<%--<link rel="stylesheet" type="text/css" href="StyleSheet/Designer.css"/>
<link rel="stylesheet" type="text/css" href="StyleSheet/SkeltaForm.css"/>--%>
 <link href="<%=cssPath%>/SkeltaForm.css" rel="stylesheet" type="text/css" />
<link href="<%=cssPath%>/Designer.css" rel="stylesheet" type="text/css" />
<html>
<head runat="server">
    <title><%=resManager.GlobalResourceSet.GetString("DeleteControlPageTitleText") %></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
</head>
<body  scroll="no">
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
        <table height="100%" width="100%" align="center" cellpadding="3" cellspacing="1"
           class="tablebg">
            <tr style="height:40px;">
                <td  class="topheadertoolbox">
                    <%=resManager.GlobalResourceSet.GetString("DeleteControlPageHeaderText") %></td>
            </tr>
            <tr style="height:auto;" width="100%" align="center" valign="middle">
                <td height="100%" width="100%" class="contenttdbg">
                    <asp:Label ID="AddMessage" runat="server" Text="Add Control" CssClass="sf-formpublishlabel"></asp:Label>
                </td>
            </tr>
            <tr style="height:40px;" width="100%" align="center" valign="middle">
                <td class="footerbg">
                    <table height="100%" width="30%" cellpadding="0" cellspacing="0" border="0" style="float:right;">
                        <tr>
                            <td height="100%" width="13%" align="center" valign="middle">
                                <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="No" 
                                    CssClass="inputsecondarybutton" style="margin-right:10px;"/>
                            </td>
                            <td height="100%" width="13%" align="center" valign="middle">
                                <asp:Button ID="Button1" runat="server" Text="Yes" OnClick="Button1_Click" 
                                    CssClass="sf-inputsBox" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <script>
            function postDeleteAction()
            {
                window.opener.updateNewControl();
                window.close();
            }
        </script>
    </form>
</body>
</html>
