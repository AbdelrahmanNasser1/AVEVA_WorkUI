<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.Channel.Blank"
    Theme="" StylesheetTheme="" %>

<html>
<head runat="server">
    <title>Untitled Page</title>
</head>
<link href="<%:cssPath %>" rel="stylesheet" type="text/css">
<body style="height: 100%; width: 100%; left: 0px; top: 0px">
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <table border="0" cellpadding="0" cellspacing="0" style="height: 100%; width: 100%">
            <tr valign="top" style="height: 100%; width: 100%">
                <td style="height: 100%; width: 100%;">
                    <table border="0" style="height: 100%; width: 100%; border-spacing:0px">
                        <tr valign="top" style="height:50%">
                            <td style="padding:0px">
                                <table border="0" style="width:100%; border-spacing:0px" class="ListHeaderCss">
                                    <tr>
                                        <td rowspan="2"  style="width:100%; padding-left: 5px">
                                        <span class="fontheading">
                                            <%= Channel_Text_Configuration %></span>
                                        </td>
                                    </tr>
                                    <tr>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr style="height:50%">
                            <td class="input" style="padding-left: 5px; vertical-align:top; text-align: center">
                            <span class="description" style="text-align:center">
                                <%= Channel_Text_NotDefined %></span>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
