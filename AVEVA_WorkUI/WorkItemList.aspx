<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WorkItemList.aspx.cs" Inherits="AVEVA_WorkUI.WorkItemList" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">

        function isIE11() {

        return !!navigator.userAgent.match(/Trident.*rv[ :]*11\./);

        }

        function ResizeGrid() {

        if (isIE11()) {

        window.setTimeout(function () { wgDoResize(true, true); }, 600);

        return true;

        }
        } 

    </script>
</head>
<body onload="ResizeGrid();">
    <form id="form1" runat="server">
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        <div>
            <asp:Panel ID="Panel1" runat="server" Height="100%" Width="100%"></asp:Panel>
            <div style="height:100%;"> hello World</div>
            <style type="text/css">
            html, body, form
            {
                height: 100%;
            }
            </style>
        </div>
    </form>
</body>
</html>
