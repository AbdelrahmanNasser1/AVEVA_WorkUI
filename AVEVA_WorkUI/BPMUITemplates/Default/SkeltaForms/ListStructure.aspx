<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Forms.Web.CodeBehind.ListStructure" %>
<%@ Register Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="ListStructureUserControl.ascx" TagName="ListStructure" TagPrefix="ucLS" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title><%=PageTitle%></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
</head>
 <link rel="stylesheet" type="text/css" href="<%=cssPath %>/SkeltaForms/StyleSheet/skeltaform.css" /> 
<body>
    <form id="form1" runat="server">
         <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
    <div id="divparent" runat="server" style="width:100%; height:100%;">    
        <table  style="width:100%;">
            <tr>
                <td>
                    <ucLS:ListStructure ID="ucListStructure" runat="server" />
                </td>
            </tr>            
        </table>           
    </div>      
    </form>
</body>
</html>
