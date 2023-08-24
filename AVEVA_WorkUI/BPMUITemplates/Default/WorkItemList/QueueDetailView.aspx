<%@ Page Language="C#" AutoEventWireup="true"  Inherits="Workflow.NET.CodeBehind.WorkItemList.QueueDetailView" Theme="" StylesheetTheme=""  %>
<%@ OutputCache Location="None"  %>
<html>
<head id="Head1" runat="server">
<title>Queue Detail View</title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
</head>
<style  type="text/css">
.collapseblock
 {
 display:none;
 }
.expandblock 
{
display:inline;
}
</style>
<script type="text/javascript" language="javascript">

function toggleblocks (postid)
 { 

var detailsDiv = document.getElementById(postid); 
var linkID=document.getElementById('linkId');
if (detailsDiv.className=="expandblock") 
{ 
detailsDiv.className="collapseblock";
linkID.innerHTML="Show Details"; 


} 
else 
{ 
detailsDiv.className="expandblock"; 
linkID.innerHTML="Hide Details";

} 
} 

</script>

    <body leftmargin="0" topmargin="0">
<link href="<%=cssPath %>" rel="stylesheet" type="text/css">    
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class='tablebg'>
	  <tr>
		<td>
			<table width="100%"  border="0" cellpadding="4" cellspacing="1" class='tablebg'>
			  
			  <tr>
				<td width="32%" class="lefttdbg"><font class="subtitle">Subject</font></td>
				<td width="68%" class="righttdbg"><font class="description"><%=subject%></font></td>
			  </tr>
			  
			  <tr>
				<td width="32%" class="lefttdbg"><font class="subtitle">Notes</font></td>
				<td width="68%" class="righttdbg"><font class="description"><%=notes%></font></td>
			  </tr>
			  
			  <tr>
				<td width="32%" class="lefttdbg"><font class="subtitle">Application</font></td>
				<td width="68%" class="righttdbg"><font class="description"><%=application%></font></td>
			  </tr>
			
			  <tr>
			  	<td width="32%" class="lefttdbg"><font class="subtitle">Workflow</font></td>
			  	<td width="68%" class="righttdbg"><font class="description"><%=workflow%></font></td>
			  </tr>
			  <tr>
			  	<td width="32%" class="lefttdbg"><font class="subtitle">Workflow Instance Id</font></td>
			  	<td width="68%" class="righttdbg"><font class="description"><%=instanceid%> ( <b>Submitted By</b>: <%=submittedby%>) </font></td>
			  </tr>

			  <tr>
				<td class="lefttdbg"><font class="subtitle">Execution Details Id</font></td>
				<td class="righttdbg"><font class="description"><%=executiondetailsid%></font></td>
			  </tr>
			  <tr>
				<td class="lefttdbg"><font class="subtitle">WorkItem Id</font></td>
				<td class="righttdbg"><font class="description"><%=workitemid%></font></td>
			  </tr>
			  <tr>
				<td class="lefttdbg"><font class="subtitle">Activity</font></td>
				<td class="righttdbg"><font class="description"><%=activityname%></font></td>
			  </tr>
			  <tr>
				<td class="lefttdbg" valign="top"><font class="subtitle">Data Submitted</font></td>
				<td class="righttdbg"><!--<textarea name="textarea" cols="32" class="input1" rows="5">  
			  	</textarea>-->
			    <a href="javascript:toggleblocks('execDetails');" id="linkId" class="subtitle"><u>Show Details</u></a>
			    <br />
			  	<div id="execDetails" class="collapseblock">
			  	<textarea name="textarea" cols="32" class="inputtextarea" rows="5"> <%=datasubmitted%> 
			  	</textarea>
			  	</div>
			  	</td>
			  	
			  	
			  </tr>
			  
			</table>

		</td>
		
	  </tr>
	</table>
 </body>

</html>
