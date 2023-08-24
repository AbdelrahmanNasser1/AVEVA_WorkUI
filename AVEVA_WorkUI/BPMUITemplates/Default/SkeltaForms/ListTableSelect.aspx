<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Forms.Web.CodeBehind.CreateList.ListTableSelect" %>
<%@ Register Src="..\Repository\Site\SkeltaListTableSelect.ascx" TagName="SkeltaListTableSelect" TagPrefix="uc1" %>
<%@ Register Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" TagPrefix="telerik" %>

<html>
<head runat="server">
    <title><%=resManager.GlobalResourceSet.GetString("FormListListTableControlPageTitleText") %></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <script type="text/javascript" language="javascript">
        function LocalizeText() {
            document.getElementById('Button1').value = '<%=resManager.GlobalResourceSet.GetString("FormListListTableControlSelectButtonText") %>';
            ReSetTableData();
        }

        function ReSetTableData() {
            var gentable = document.getElementById("RadioGenTbl");
            var exsttable = document.getElementById("RadioExistTbl");
            var ctrlid = "ListTable";
            var selectlist = document.getElementById("ListTable_lstListTables");
            var tableName = '<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(selectedTableName, false) %>';
            if (tableName != "SKEListItemDataNV" && tableName != "GenericTable" && tableName!="") {
                gentable.checked = false;
                exsttable.checked = true;
                document.getElementById("ExistTableDiv").style.display = 'block';
            }
            else {
                gentable.checked = true;
                exsttable.checked = false;
                document.getElementById("ExistTableDiv").style.display = 'none';
            }
            if (selectlist != null && exsttable.checked) {
                for (var i = 0; i < selectlist.length; i++) {
                    if (selectlist[i].value == tableName) {
                        selectlist[i].selected = true;
                        document.getElementById(ctrlid + '_hValue').value = "ExistingTable";
                        break;
                    }
                }
            }
        }
    </script>
</head>
<body onload="LocalizeText();">
    <link rel="stylesheet" type="text/css" href="<%:commonCssPath%>SkeltaForms/StyleSheet/skeltaform.css">
    <link rel="stylesheet" type="text/css" href="<%:commonCssPath%>CommonUXControls/StyleSheet/se.ui.min.css">
    <script>
        se.ui.messageDialog.setGlobalOptions({
            localization: { 
                closeButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>", 
                okButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>", 
                cancelButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>", 
                showDetailsCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                hideDetailsCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" 
            }
        });

        function showMessage(message) {
            se.ui.messageDialog.showError("<%=resManager.GlobalResourceSet.GetString("FormListListTableControlPageTitleText") %>", message);
        }
    </script>
    <form id="form1" runat="server">
        <telerik:RadCodeBlock runat="server" ID="RadCodeBlock1">
	        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        </telerik:RadCodeBlock>
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        <div>
            <table cellpadding="3" cellspacing="0" border="0" width="100%" height="100%" align="center">
                <tr>
                    <td valign="top" height="90%">
                        <uc1:SkeltaListTableSelect ID="ListTable" runat=server/>
                    </td>
                </tr>
                <tr>
                    <td height="25" style="text-align:right;vertical-align:middle;">
                        <asp:Button ID="Button1" runat="server" CssClass="sf-inputsBox" OnClick="Button1_Click" Text="Select"/>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
