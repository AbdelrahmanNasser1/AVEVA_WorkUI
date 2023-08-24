<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CreateDListTableHelp.aspx.cs"
    Inherits="BPMUITemplates_Default_Repository_Site_CreateDListTableHelp" %>

<html>
<head runat="server">
    <title><%=resManager.GlobalResourceSet.GetString("FormListTableDynamicListHelpPageTitleText") %></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <link rel="stylesheet" type="text/css" href="<%$ ReplaceTemplateExpn:Common/StyleSheet/Global.css%>" />
</head>
<body>
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <div width="100%" height="100%">
            <table border=0 width="100%" height="100%">
                <tr height="10%">
                    <td>
                        <p class="MsoNormal" style='text-autospace: none'>
                            <span style='font-size: 13.0pt;font-family: Roboto,"Segoe UI"; 
                                text-decoration: none;'><%=resManager.GlobalResourceSet.GetString("FormListTableDynamicListHelp1Text") %></span></p>                        
                    </td>
                </tr>
                <tr height="10%">
                    <td>
                        <p class="MsoNormal" style='text-autospace: none'>
                            <span style='font-size: 10.0pt; font-family: Roboto,"Segoe UI"'><%=resManager.GlobalResourceSet.GetString("FormListTableDynamicListHelp2Text") %></span></p>
                    </td>
                </tr>
                <tr height="10%">
                    <td>
                        <p class="MsoNormal" style='text-autospace: none'>
                            <span style='font-size: 10.0pt; font-family: Roboto,"Segoe UI";'><%=resManager.GlobalResourceSet.GetString("FormListTableDynamicListHelp3Text") %>
                            </span>
                            <span style='font-size: 10.0pt; font-family: Roboto,"Segoe UI"; color: red'></span><span
                                style='font-size: 10.0pt; font-family: Roboto,"Segoe UI"; color: blue'></span><span style='font-size: 10.0pt;
                                    font-family: Roboto,"Segoe UI"; color: red'>&lt;<%=resManager.GlobalResourceSet.GetString("FormListTableDynamicListHelp4Text") %>&gt; <span style='color: black'>
                                        <%=resManager.GlobalResourceSet.GetString("FormListTableDynamicListHelp5Text") %></span></span></p>
                    </td>
                </tr>
                <%--<tr height="10%">
                    <td>
                        <p class="MsoNormal" style='text-autospace: none'>
                            <span style='font-size: 10.0pt; font-family: "Courier New"; color: blue'></span>
                            &nbsp;</p>
                    </td>
                </tr>--%>
                <td style="font-family:Roboto,'Segoe UI'">
                    <asp:TextBox ID="txtScript" runat="server" Width="100%" Height="100%" TextMode="MultiLine" ReadOnly=true Font-Names="Roboto,Segoe UI" ></asp:TextBox>
                </td>                
                <tr>                
            </table>
        </div>
    </form>
    
</body>
</html>
