<%@ Page Language="C#" Debug="true" AutoEventWireup="true"  Inherits="Skelta.Repository.List.ListView.CodeBehind.ShowListViewErrorMessage" %>

<link rel="stylesheet" type="text/css" href="<%=_ThemePath%>Common/StyleSheet/Global.css" />
<html  >
<head runat="server">
    <title></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
   
</head>
<body>
    <form id="form1" runat="server">
    <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
    <div>
        <table style="width: 100%;">
            <tr>
                <td style="padding-left:10px"><asp:Label ID="lblError" runat="server" CssClass="errormsg"></asp:Label></td>
            </tr>
            <tr>
                <td style="padding-left:10px"><asp:Label ID="lblReasons" runat="server" CssClass="description"></asp:Label></td>
            </tr>
            <tr>
                <td style="position: fixed; bottom: 0px; left: 0px; right: 0px; height: 32px; padding-top: 0px; padding-right: 2px;">
                    <input type="button" value="Close" class="inputbutton" onclick="Close()" style="float: right;" />
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
 <script type="text/javascript" language="javascript">
    function Close()
    {
        var win = GetRadWindow();
        win.close();
    }
    
     function GetRadWindow()
    {
        var oWindow = null;
        if (window.radWindow) oWindow = window.radWindow;
        else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
        return oWindow;
    } 

    
    </script>