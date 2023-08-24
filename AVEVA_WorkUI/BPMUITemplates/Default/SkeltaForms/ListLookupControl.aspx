<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Forms.Web.CodeBehind.ListLookupControl" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html>
<html>
<head>
    <title>
        <%=pageTitle%>
    </title>
    <link rel="stylesheet" type="text/css" href="<%=cssPath%>SkeltaForms/StyleSheet/SkeltaForm.css" />
    <link href="<%=cssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css" rel="stylesheet" type="text/css" />
         <link href="<%=cssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css" rel="stylesheet" type="text/css" />
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <script type="text/javascript">
        function CloseWindow() {
            try {
                window.close();
            }
            catch (err)
        { }
        }
        function SaveClick(listItemValue, listItemText, textId, hiddenfieldId) {
            try {

                var hiddenInputId = window.opener._skidmap[hiddenfieldId];
                var textInputId = window.opener._skidmap[textId];
                window.opener.document.getElementById(hiddenInputId).value = listItemValue;
                window.opener.document.getElementById(textInputId).value = listItemText;
                window.opener.document.getElementById(textInputId.replace("_text", "")).value = listItemText;
                CloseWindow();
            }
            catch (err)
    { }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
     <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
     <table border="0" width="100%" style="height: 100%;" class="sf-formbackground">
        <tr>
            <td colspan="3">
                 <div id="divheader">
                        <table width="100%" align="center" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td style="float: left; margin-right: 10px; margin-top: 5px; padding-left: 10px;" class="sf-topleveltitle">
                                    <img src="<%=cssPath%>SkeltaForms/images/new-form-icon.png" align="absmiddle" />
                                    &nbsp;<%=pageTitle%>
                                    <br />
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="sf-formlabeldescription"> (
                                        <%=pageDescription%>
                                        )</span>
                                </td>
                            </tr>
                        </table>
                    </div>
            </td>
        </tr>
        <tr style="height: 40px;" align="center">
            <td style="width: 5%;">
            </td>
            <td align="left" style="width: 40%;" class="sf-formlabel" valign="middle">
                <%:selectItem %>
            </td>
            <td style="width: 55%;" align="left">
                <input type="hidden" id="Hidden1" runat="server" />
                <asp:Panel ID="listItemPanel" Width="200" runat="server" />
            </td>
        </tr>
        <tr>
            <td style="width: 5%;">
            </td>
            <td align="left" style="width: 40%;" class="sf-formlabel" valign="middle">
                <%:selectItemVersion %>
            </td>
            <td style="width: 55%;">
                <asp:Panel ID="listItemVersionPanel" Width="200" runat="server">
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td colspan="3" style="height: 80%">
                <asp:Panel ID="pnl2" Height="100%" Width="100%">
                </asp:Panel>
            </td>
        </tr>
        <tr valign="bottom" align="right">
            <td valign="bottom" class="sf-saverow" colspan="3">
                <div class="footerbg">
                    <div class="divBottomButton">
                        <asp:Button ID="cancelButton" runat="server" Class="inputsecondarybutton" OnClientClick="javascript:CloseWindow()">
                        </asp:Button>
                        <asp:Button ID="saveButton"   runat="server" Class="sf-inputsBox" OnClick="HandleSaveClick" />
                    </div>
                </div>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
