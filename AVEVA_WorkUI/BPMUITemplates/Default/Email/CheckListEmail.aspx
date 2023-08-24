<%@ Page Language="C#" AutoEventWireup="true"  Inherits="Workflow.NET.CodeBehind.Mail.Email_CheckListEmail" Theme="" StylesheetTheme=""%>

<style>
<!--

textarea {
	font-family: Verdana;
	font-size: 11px;
	text-decoration: none;
	border: 1px solid #7b9ebd;
}

select {
	font-family: Verdana;
	font-size: 11px;
	text-decoration: none;
	border: 1px solid #7b9ebd;
}

input {
	font-family: Verdana;
	font-size: 11px;
	text-decoration: none;
	border: 1px solid #7b9ebd;
}

.runtext1 {
	font-family: Verdana;
	font-size: 11px;
	text-decoration: none;
	color: #000000;
}

.runtext2 {
	font-family: Verdana;
	font-size: 10px;
	font-weight:bold
	text-decoration: none;
	color: #FFFFFF;
}

BODY {
 BORDER-RIGHT: 0px; BORDER-TOP: 0px; FONT-SIZE: 11px; MARGIN: 0px; BORDER-LEFT: 0px; CURSOR: default; BORDER-BOTTOM: 0px;
}

TD
{
    FONT-SIZE: 10px;
    FONT-FAMILY: Verdana,Tahoma
}
.style1 {
	color: #FFFFFF;
	font-weight: bold;
}

-->
</style>

<html>
<head runat="server">
    <title>CheckList Email</title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
</head>
<body>
    <form id="form1" runat="server">
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <div>
        <table width='100%' cellspacing='1' cellpadding='3' border="0" bgcolor="#6489d4" align="center">
    <TR bgcolor="#eef0f6">
    <TD style="width: 755px; height: 42px">
       <table width='95%' border='0' align='center' cellpadding='5' cellspacing='1' bgcolor="#6489d4" class='runtextsmall'>
          <tr bgcolor="#f3f3f3">
              <td bgcolor="#f3f3f3" colspan="" style="width: 944px">                
				<asp:Label ID="lblStad" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
              </td>
          </tr>
      </table>
    <TR>
  </TABLE>
    </div>
    </form>
</body>
</html>
