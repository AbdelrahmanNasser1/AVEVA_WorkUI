<%@ Page Language="C#" AutoEventWireup="true"  Inherits="Workflow.NET.CodeBehind.Bam.SkeltaTemplates_Default_BAM_Detail_Report"  Theme="" StylesheetTheme=""%>
<%@ Register Assembly="Skelta.BAM" Namespace="Skelta.BAM.UserControls" TagPrefix="DetailRep" %>


<html >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
     <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="#256194">
                        <tr>
                            <td height="25">
                                <font color="white" size="2">&nbsp;&nbsp;<b><%=DisplayString%></b></font>
                             </td>
                        </tr>
         </table><br />         
        <DetailRep:DetailReportControl ID="DetailedReport1"  runat="server"   ></DetailRep:DetailReportControl>
    
    </form>
</body>
</html>
