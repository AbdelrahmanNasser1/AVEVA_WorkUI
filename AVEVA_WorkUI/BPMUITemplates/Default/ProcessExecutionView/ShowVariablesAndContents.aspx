<%@ Page Language="C#" AutoEventWireup="true"  Inherits="Workflow.NET.CodeBehind.ProcessExecutionView.ShowVariablesAndContents" Theme="" StylesheetTheme="" %>
<%@ OutputCache Location="None"  %>
<html>
<head id="Head1" runat="server">
    <title><%=GR.GetString("Detailed messages for workflow step")%></title>
    <script language="javascript" SRC="JavaScript/jsFunctions.js"></script>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <script>
    window.onresize = Resize;
    window.onload = Resize;
    function Resize()
    {
        var divdetails = document.getElementById("divdetails");
        var mainrow = document.getElementById("mainrow");
        
        if(divdetails!=null)
            divdetails.style.height = frameElement.offsetHeight - 110;
            
        if(mainrow!=null)    
            mainrow.style.height = frameElement.offsetHeight - 45;
        
        var textArea=document.getElementById("RawcontentText");
        if(textArea!=null)
        {
            //textArea.cols =  frameElement.offsetWidth * 0.18;
            //textArea.rows =  frameElement.offsetHeight * 0.06;
            textArea.style.width = frameElement.offsetWidth - 31;
            textArea.style.height = frameElement.offsetHeight - 117;
                
        }
    }

    function ShowVariableValue(varTitle, msg) 
    {

        var l = window.location.toString();
        l = l.replace("ShowVariablesAndContents.aspx", "ShowXMLVariable.aspx");
        l += "&vn=" + encodeURIComponent(varTitle);
        var winObj = window.open(l, null, "scrollbars=no,titlebar=no,status=no,location=no,resizable=yes,width=600,height=400");
    }


    
    </script>

</head>
    <style type="text/css">
        .ellipsisClass {
            max-width: 120px;
            text-overflow: ellipsis;
            overflow: hidden;
            white-space: nowrap;
        }
    </style>
    
     <link href="<%=cssPath%>Common/StyleSheet/Global.css" rel="stylesheet" />

<body  style="overflow:hidden;">
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <table width="100%" cellspacing="0" cellpadding="0" border="0">
	<tr>
		<%--<td valign="bottom" height="25" background="<%=cssPath %>ProcessExecutionView/graphics/Common-Heading-bg.png">--%>

			<table cellspacing="0" class="ListHeaderCSS" cellpadding="0" border="0" width="100%">
			<tr>
				<td valign="middle" height="25" ><span class="subtitle" style="padding-left:8px;"><%=PageTitle%></span></td>
				<td valign="top" width="25"></td>
			</tr>
			<tr>
				<td valign="middle" colspan="2" height="5"><span class="header1" ></span></td>
			</tr>
		</table>
		</td>
	</tr>
		<tr id="mainrow">
			<td>
					<table cellspacing="1" cellpadding="4" border="0" width="100%" height="100%" align="center">
							<tr>
									<td colspan="2" align="center" height="100%">
 <%if( DisplayMode=="variables") { int i=0; %>
											<table class="GridHeaderStyle" border="0" cellspacing="1" cellpadding="4" width="100%" height="30px" style="table-layout:fixed;">
											    <tr class="subtitle"><td align="left"><%=GR.GetString("Variable Name")%></td><td align="left"><%=GR.GetString("Data Type of Value")%></td><td align="left"><%=GR.GetString("Value")%></td></tr></table>  									
											    <div id="divdetails" style="width:100%;height:100%;overflow:auto;">
											    
                                                    <table style="background-color:#f5f4f4; table-layout:fixed;" cellspacing="1" cellpadding="4" width="100%">
                                                        <%foreach (System.Collections.Generic.KeyValuePair<string, object> pair in Variables)
                                                          {
														  i++;
														  %>
                                                        <tr style="background-color:White;" class="description">
                                                           <td align="left" valign=top class="ellipsisClass"><%=pair.Key %></td> 
                                                           <td align="left" valign=top class="ellipsisClass"><%=(pair.Value == null) ? "" :pair.Value.GetType().ToString()%></td> 
                                                           <td align="left" valign=top class="ellipsisClass"><%=GetVariableString(i,pair.Key,pair.Value)%></td> 
                                                        </tr>
                                                        <%} %>
                                                    </table>
											    </div>
<%} %>											    
 <%if( DisplayMode=="contents") { %>
											<table class="GridHeaderStyle" border="0" cellspacing="1" cellpadding="2" width="100%" height="30px" style="table-layout:fixed;">
											    <tr><td align="left" class="subtitle" width="250px"><%=GR.GetString("Content Name")%></td><td align="left"><%=GR.GetString("Value")%></td></tr></table>  									
											    <div id="divdetails" style="width:100%;height:100%;overflow:auto;">
											    
                                                    <table style="background-color:#f5f4f4"  cellspacing="1" cellpadding="4" width="100%" style="table-layout:fixed;">
                                                        <% if( Contents != null && Contents.Count > 0) 
                                                           { %>                                                    
                                                            <%foreach (System.Collections.Generic.KeyValuePair<string, string> pair in Contents)
                                                              {%>
                                                            <tr style="background-color:White;" class="description">
                                                               <td  valign=top width="250px" class="ellipsisClass"><%=pair.Key %></td> 
                                                               <td  valign=top class="ellipsisClass"><pre><%=(pair.Value==null)?"":pair.Value%></pre></td> 
                                                            </tr>
                                                            <%} %>
                                                      <%} %>                                          
                                                        
                                                    </table>
											    </div>
<%} %>											    
<%if( DisplayMode=="content") { %>
											<table border="0" cellspacing="1" cellpadding="2" width="100%" height="30px" class="ddddddColorCode">
											    <tr><td class="description" align="left"><%=GR.GetString("Content (raw format)")%></td></tr></table>  									
											    <div id="divdetails" style="width:100%;height:100%;overflow:auto;">
											    
                                                    <table cellspacing="1" cellpadding="2" width="100%" style="table-layout:fixed;">
                                                            <tr>
                                                               <td  valign=top ><pre><textarea id="RawcontentText" class="inputtext" cols="0" rows="0"><%=Content%></textarea></pre></td> 
                                                            </tr>                                                        
                                                    </table>
											    </div>
<%} %>											    
											    

									</td>
							</tr>
					</table>
			</td>
		</tr>
	</table>
   </form>
</body>
</html>
