<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.ProcessExecutionView.ShowFormDetails" Theme="" StylesheetTheme="" %>

<%@ OutputCache Location="None" %>
<html>
<head id="Head1" runat="server">
    <title><%=resourceSet.GetString("Detailed messages for workflow step")%></title>
    <script language="javascript" src="../Common/JavaScripts/jsFunctions.js"></script>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <script>
        window.onresize = Resize;
        window.onload = Resize;
        function Resize() {
            var divdetails = document.getElementById("divdetails");
            var mainrow = document.getElementById("mainrow");

            //if(divdetails!=null)
            //    divdetails.style.height = frameElement.offsetHeight - 90;

            if (mainrow != null)
                mainrow.style.height = frameElement.offsetHeight - 35;


        }
    </script>

</head>
<!--<link rel="stylesheet" type="text/css" href="<%=cssPath %>ProcessExecutionView/Stylesheet/global.css" />-->
<link href="<%=cssPath%>Common/StyleSheet/Global.css" rel="stylesheet" />

<body style="overflow:hidden;">
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
        <table width="100%" height="100%" cellspacing="0" cellpadding="0" border="0">
            <tr>
                <td valign="bottom" height="25" background="<%=cssPath %>ProcessExecutionView/graphics/Common-Heading-bg.png">

                    <table cellspacing="0" class="header" cellpadding="0" border="0" width="100%">
                        <tr>
                            <td valign="middle" height="25"><span class="subtitle"><%=PageTitle%></span></td>
                            <td valign="top" width="25"></td>
                        </tr>
                        <tr>
                            <td valign="middle" colspan="2" height="5"><span class="header1"></span></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="mainrow">
                <td>
                    <table style="border: 0; width: 100%; height: 100%">
                        <tr>
                            <td class="" colspan="2" align="center" height="100%">
                               <div id="divdetails" style="width: 100%; height: 73%; overflow: auto;">
                                    <asp:Panel ID="pnlUIControl" runat="server" Height="200px"></asp:Panel>
                                </div>
                            </td>
                        </tr>
                    </table>

                </td>
            </tr>
        </table>
    </form>
</body>
</html>
