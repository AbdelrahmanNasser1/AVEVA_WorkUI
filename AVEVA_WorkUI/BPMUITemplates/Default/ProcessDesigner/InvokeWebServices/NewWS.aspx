<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.InvokeWS.NewWS" Theme="" StylesheetTheme="" %>


<!DOCTYPE html>
<html>
<head runat="server">
    <title><%=l_WSTitle %></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
     <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="../../CommonUXControls/StyleSheet/se.ui.min.css" />   
     <style>
        html, body {
            height: 100%;
            width: 100%;
            overflow: hidden;
        }

  
    </style>

	    <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(PdCtrl.GetCommonRelativeUrl("stylesheet/Global.css"))%>" rel="stylesheet" type="text/css">
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
function openhelpinpdmode()
 {
     window.open('<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(PdCtrl.GetHelpPageUrl(), false)%>WebService-WebServiceDetails.html', '', 'height=450,width=600,resizable=yes,status=no,scrollbars=yes');
 }
      function showErrorMessage(message)
        {
           se.ui.messageDialog.showError('<%=GR.GetString("WS_Web Services") %>', message);
        }
</script>
</head>
<body style="padding-left:10px;padding-right:10px">
     <script>
        se.ui.messageDialog.setGlobalOptions({
            localization: { // All localization related default can be set
                closeButtonCaption: "<%=GR.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                okButtonCaption: "<%=GR.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                cancelButtonCaption: "<%=GR.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                showDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                hideDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
            }
        });
    </script>
    <form id="form1" runat="server">
         <%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <div>
	<table width="100%" border="0" cellpadding="0" cellspacing="1" class="lefttdbg">
            <tr>
                <td >
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" >
                        <tr class="ListHeaderCss">
                            <td width="95%" class="fontheading">
                                <span class="subtitle">
                                    <%=l_WSTitle %>
                                </span>
                            </td>
                            <td width="5%" class="fontheading">
                                <a href="#">
                                    <img src="<%:PdCtrl.GetCommonRelativeUrl("images/main-help.gif")%>" alt="<%=GR.GetString("HelpAltText")%>" border="0"
                                        onclick="javascript:openhelpinpdmode()"></a></td>
                        </tr>
                    </table>
                </td>
            </tr>
			<tr>
				<td>
                    <table id="Table2" cellspacing="1" cellpadding="4" width="100%" border="0" class="tablebg">
                        <tr >
                            <td style="width:30%" class="lefttdbg">
                                <span class="subtitle">
                                    <%=l_WSName%>
                                </span>
                                <br />
                               <span class="description">
                                   <%=l_WSProxyNameDesc %>
                                </span> 
                            </td>
                            <td class="righttdbg" style="width:70%">
                                <asp:TextBox ID="txtWSName"  CssClass="inputtext" runat="server" Width="450px"></asp:TextBox></td>
                        </tr>
                       
                        <tr>
                            <td height="40" style="width:30%" class="lefttdbg" >
                                <span class="subtitle">
                                    <%=l_WSURL%></span>
                                     <br />
                               <span class="description">
                                   <%=l_WSProxyURlDesc %>
                                </span>
                                
                            </td>
                            <td class="righttdbg" style="width:70%">
                                <asp:TextBox ID="txtWSDLURL" CssClass="inputtext" runat="server" Width="450px"></asp:TextBox></td>
                        </tr>
                         <tr>
                            <td colspan="2" style="height:30px"></td>
                        </tr>
                        <tr>
                         <td height="40" style="width: 30%" class="lefttdbg" >
                                <span class="subtitle">
                                    <%=l_WSAuthenticated%></span>
                                    <br />
                                     <span class="description">
                                   <%=l_WSAutenticatedDesc %>
                                </span>
                                
                            </td>
                            <td class="righttdbg" style="width:70%">
                                <input id="Checkbox1" type="checkbox" class="inputcheckbox" language="javascript"
                                    onclick="Checkbox1_onclick()" />
                                    <span class="description">
                                      <%=l_WSSelectText %>
                                    </span>
                            </td>
                        </tr>
                    </table>
                                      
                    <br />
                    <div id="SecDiv" style="display: none">
                        <table id="Table4" cellspacing="1" cellpadding="4" width="100%" border="0" class="tablebg">
                            <tr>
                                <td height="25" style="width: 30%" class="lefttdbg">
                                   <span class="description"><%=l_WSLoginName%></span>
                                </td>
                                <td  style="width:70%" class="righttdbg">
                                    <asp:TextBox ID="txtUser" CssClass="inputtext" runat="server" Width="450px"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td class="lefttdbg" >
                                  <span class="description"><%=l_WSPassword%></span>
                                    &nbsp;</td>
                                <td class="righttdbg">
                                    <asp:TextBox ID="txtPWd" CssClass="inputtext" TextMode="Password" runat="server" Width="450px"></asp:TextBox></td>
                                    <input id="hiddenPwd" type="hidden" name="hiddenPwd" value="" />
                            </tr>
                            <tr>
                                <td class="lefttdbg"  style="width:30%">
                                   <span class="description"><%=l_WSDomain%></span>
                                </td>
                                <td class="righttdbg" style="width:70%">
                                    <asp:TextBox ID="txtDomain"  CssClass="inputtext" runat="server" Width="450px"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td class="lefttdbg" >
                                   <span class="description"><%=l_WSProxyUrl%></span>
                                </td>
                                <td class="righttdbg" style="width:70%">
                                    <asp:TextBox ID="txtProxyURL" CssClass="inputtext" runat="server" Width="450px"></asp:TextBox></td>
                            </tr>
                        </table>
                    </div>
                    <asp:Label ID="lblError" runat="server"  CssClass="errormsg" Visible="False"></asp:Label><br />
                    <table border="0" width="100%" cellpadding="4" cellspacing="1" >
                        <tr>
                            <td style="padding-right:20px;text-align:right">
                                <asp:Button ID="btnCancel" CssClass="inputsecondarybutton" runat="server" OnClick="btnCancel_Click"
                                    Text="Cancel" />  &nbsp;&nbsp;<asp:Button ID="cmdAddWebService" CssClass="inputbutton" runat="server" OnClick="Button2_Click"
                                    Text="Save Web Service" />
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
