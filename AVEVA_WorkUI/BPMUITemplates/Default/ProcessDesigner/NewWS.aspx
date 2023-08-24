<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NewWS.aspx.cs" Inherits="NewWS" Theme="" StylesheetTheme="" %>



<html >
<head runat="server">
    <title><%=l_WSTitle %></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
	    <link href="Stylesheet/global.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript">
<!--

function Text1_onclick() {

}

function Checkbox1_onclick() {
    if(document.getElementById("Checkbox1").checked)
        document.getElementById("SecDiv").style.display='block';
    else
        document.getElementById("SecDiv").style.display='none';
}

// -->
</script>
</head>
<body>
    <form id="form1" runat="server">
	<%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <div>
	<table width="750" border="0" cellpadding="0" cellspacing="1">
            <tr>
              <td class="header2"><table width="100%" border="0" cellspacing="0" cellpadding="0"class="header2">
                <tr>
                  <td width="95%"><%=l_WSTitle %></td>
                  <td width="5%"><a href="#"><img src="Images/help.gif" alt="Help" width="21" height="24" border="0"></a></td>
                </tr>
              </table></td>
            </tr>
            <tr>
				  <td>
					<table width="750" border="0" cellpadding="8" cellspacing="0">
						<tr>
						  <td width="40%" bgcolor="#F0F0F0"><strong><%=l_WSApplicationName%>:</strong> <%=pApplicationName%></td>
						  <td width="32%" bgcolor="#F0F0F0"><strong><%=l_WSWorkflowName%>:</strong><%=pWorkflowName %></td>
						  <td width="28%" bgcolor="#F0F0F0"><strong><%=l_WSFileName%>:</strong><%=pFileName%></td>
						</tr>
						<tr>
						  <td bgcolor="#F0F0F0"><strong><%=l_WSActionName%>:</strong><%=pActionName%></td>
						  <td  colspan="2" bgcolor="#F0F0F0"><strong><%=l_WSPropertyName%>:</strong><%=pPropertyName%></td>
						</tr>
				  </table>
				</td>
			</tr>
			<tr>
				<td><Br />
				
        <TABLE  bgcolor="#256194" id="Table1" align="center" cellSpacing="5" cellPadding="4" width="410" border="0">
							<TR>
								<TD height=40 style="width: 200px"><font color="#FFFFFF"><%=l_WSName%></font></TD>
								<TD>
                                    &nbsp;<asp:TextBox ID="txtWSName" runat="server" 
                                        Width="250px"></asp:TextBox></TD>
							</TR>
							<TR>
								<TD height=40 style="width: 200px"><font color="#FFFFFF"><%=l_WSURL%></font></TD>
								<TD>
                                    &nbsp;<asp:TextBox ID="txtWSDLURL" runat="server" Width="250px"></asp:TextBox></TD>
							</TR>
			</TABLE>
     <br />
	         <TABLE  bgcolor="#256194" id="Table1" align="center" cellSpacing="1" cellPadding="4" width="410" border="0">
							<TR>
								<TD height=30 style="width: 200px" bgcolor="#F0F0F0" colspan="2"><input id="Checkbox1" type="checkbox" language="javascript" onclick="Checkbox1_onclick()" /> <%=l_WSAuthenticated%></TD>
							</TR>
			</TABLE>
        <br />
        <div id="SecDiv" style="display:none">
			<TABLE  bgcolor="#256194" id="Table1" align="center" cellSpacing="1" cellPadding="3" width="370" border="0">
									<TR>
										<TD bgcolor="#F0F0F0" height=25 style="width: 99px"><%=l_WSLoginName%></TD>
										<TD bgcolor="#F0F0F0" style="width: 192px"><asp:TextBox ID="txtUser" runat="server" Width="160px"></asp:TextBox></TD>
									</TR>
									<TR>
										<TD bgcolor="#F0F0F0" height=25 style="width: 99px"><%=l_WSPassword%>&nbsp;</TD>
										<TD bgcolor="#F0F0F0" style="width: 192px"><asp:TextBox ID="txtPWd" runat="server"
												Width="159px"></asp:TextBox></TD>
									</TR>
									<TR>
										<TD bgcolor="#F0F0F0" height=25 style="width: 99px"><%=l_WSDomain%></TD>
										<TD bgcolor="#F0F0F0" style="width: 192px"><asp:TextBox ID="txtDomain" runat="server" Width="153px"></asp:TextBox></TD>								 
									</TR>
							</Table>
		</div>
                    <asp:Label ID="lblError" runat="server" ForeColor="Red" Text="Error: " Visible="False"></asp:Label><br />
			<table border=0 height="30" width="750" cellpadding="0" cellspacing="0" bgcolor="#256194">
				<tr>
					<td align="right">
					<asp:Button ID="btnCancel" class="input-buttonswork" runat="server" OnClick="btnCancel_Click" Text="Cancel" />
                    <asp:Button ID="cmdAddWebService" class="input-buttonswork" runat="server" OnClick="Button2_Click" Text="Save Web Service" />
							&nbsp;&nbsp;
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
