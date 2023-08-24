<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BAMExport.aspx.cs" Inherits="BPMUITemplates_Default_BAM_BAMExport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" style="height: 100%;">
<head runat="server">
    <title><%=GR.GetString("ec_BAMReports_ExportSettings")%></title>
    <script>
        function GetRadWindow() {
             var oWindow = null;
             if (window.radWindow) oWindow = window.radWindow;
             else if (window.frameElement) {
                if (window.frameElement.radWindow)
                    oWindow = window.frameElement.radWindow;
                else
                    window.location.reload();
            }
            return oWindow;
        }
        function CloseWindow() {
            var oWindow = GetRadWindow();
            oWindow.close();
        }

        function ChangeWebgridSize() {
            GetRadWindow().BrowserWindow.document.getElementById('txtGridSize').value = window.self.document.getElementById("txtNumber").value;
            CloseWindow();
            GetRadWindow().BrowserWindow.document.getElementById('txtGridSize').onchange();
        }

        var specialKeys = new Array();
        specialKeys.push(8); //Backspace
        function IsNumeric(e) {
            var keyCode = e.which ? e.which : e.keyCode;
            var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) !== -1);
            return ret;
        }

    </script>
</head>

<body style="height: 100%; width: 100%;">
    <form id="form1" runat="server">
        <link rel="stylesheet" type="text/css" href="<%=cssPath %>Common/StyleSheet/Global.css" />
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <br />
        <div id="divExport" style="height: 100%; width: 100%;">
            <div style="width: 100%;">
               <span class="Subtitle" style="width: 50%;vertical-align:middle;padding:6%"> <%=GR.GetString("ec_BAMReports_Export")%> </span> 
                <asp:TextBox runat="server" ID="txtNumber" CssClass="inputtext" style="width: 37%;" onkeypress="return IsNumeric(event);" onpaste="return false" MaxLength="9"></asp:TextBox>
            </div>
            <div style="text-align: right; padding-top: 15%; padding-right: 10px;">
                <button type="button" name="btnExportClose" class="inputsecondarybutton" onclick="javascript:CloseWindow();" style="margin-right: 10px;"><%=GR.GetString("ec_BAMReports_BtnExportClose")%></button>
                <asp:Button ID="ExportRecords" runat="server" Text="Update" OnClientClick="javascript:ChangeWebgridSize();" CssClass="inputbutton" />
            </div>
        </div>
    </form>
</body>
</html>
