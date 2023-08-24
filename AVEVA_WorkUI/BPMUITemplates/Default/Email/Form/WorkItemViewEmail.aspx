<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.Mail.WorkItemViewEmail" Debug="false" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title><%=strDuplicateResponseTitle%></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
</head>

<style>
                <!--
                textarea {
	            font-family: Verdana;
	            font-size: 14px;
	            text-decoration: none;
	            border: 1px solid #7b9ebd;}
                select {
	            font-family: Verdana;
	            font-size: 14px;
	            text-decoration: none;
	            border: 1px solid #7b9ebd; }
                input {
	            font-family: Verdana;
	            font-size: 14px;
	            text-decoration: none;
	            border: 1px solid #7b9ebd;
                    }
                .runtext1 {
	            font-family: Verdana;
	            font-size: 14px;
	            text-decoration: none;
	            color: #000000;
                }
                .runtext2 {
	            font-family: Verdana;
	            font-size: 14px;
	            font-weight:bold
	            text-decoration: none;
	            color: #FFFFFF;
                }

                BODY {
                BORDER-RIGHT: 0px; BORDER-TOP: 0px; FONT-SIZE: 14px; MARGIN: 0px; BORDER-LEFT: 0px; CURSOR: default; BORDER-BOTTOM: 0px;
                }
                TD
                        {
                FONT-SIZE: 14px;
                    FONT-FAMILY: Verdana,Tahoma
                    }
                    .style1 {
	                 color: #FFFFFF;
	            font-weight: bold;
                    }
.style2 {
	font-family: Verdana;
	font-size: 14px;
}
                    -->
                </style>

<body  leftmargin='2' topmargin='2' marginwidth='2' marginheight='2'>
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <div>
            <%if(DuplicateTask){%>
                <table width='95%' border='0' align='center' cellpadding='5' cellspacing='1' bordercolor="#CCCCCC" bgcolor="#FFFFFF" class="style2">
                    <tr bgcolor='#f3f3f3'>
                        <td bgcolor='#EBEBEB' colspan='2' style='height: 130px'>
	                        <%=strDuplicateResponseTitle%><br />
                             <%:strDuplicateResponseText%>           
                        </td>
                    </tr>
                </table>
            <%} %>        

            <%if(isWorkItemReassigned){%>
                <table width='95%' border='0' align='center' cellpadding='5' cellspacing='4' bordercolor="#CCCCCC" bgcolor="#FFFFFF" class="style2">
                    <tr bgcolor='#f3f3f3'>
                        <td bgcolor='#EBEBEB' colspan='2' style='height: 130px'>
	                        <%=strReassignedWorkitemResponseTitle%>:<br /><br />
                             <%:strReassignedWorkitemResponseText%>           
                        </td>
                    </tr>
                </table>
            <%} %>  
        </div>
    </form>
</body>
</html>
