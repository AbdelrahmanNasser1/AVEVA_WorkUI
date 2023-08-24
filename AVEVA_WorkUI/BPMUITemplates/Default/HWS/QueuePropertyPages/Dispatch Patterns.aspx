<%@ Page language="c#" Inherits="PatternsProto.Dispatch_Patterns" CodeFile="Dispatch Patterns.aspx.cs" Theme="" StylesheetTheme=""  %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title></title>
        <script src="../../Common/JavaScripts/jquery.min.js"></script>
        <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="ProgId" content="VisualStudio.HTML">
		<meta name="Originator" content="Microsoft Visual Studio .NET 7.1">
		<script language=javascript>
		function dispRD()
		{
		//alert("checked");
		if(document.getElementById('autoAlloc').checked == false )
		{
		//alert("checked");
		
		document.getElementsByTagName("input")["rdRandom"].disabled=true;
		document.getElementsByTagName("input")["rdRobin"].disabled =true;
		document.getElementsByTagName("input")["rdShortest"].disabled =true;
		
		}
		else
		{
		document.getElementById('manuAlloc').checked = false;
		document.getElementsByTagName("input")["rdRandom"].disabled=false;
		document.getElementsByTagName("input")["rdRobin"].disabled=false;
		document.getElementsByTagName("input")["rdShortest"].disabled=false;
		}
		}
		function disableRD()
		{
		if(document.getElementById('autoAlloc').checked)
		{//alert("auto checked");
		document.getElementById('autoAlloc').checked = false;
		document.getElementsByTagName("input")["rdRandom"].disabled=true;
		document.getElementsByTagName("input")["rdRobin"].disabled =true;
		document.getElementsByTagName("input")["rdShortest"].disabled =true;
		}
		else
		{
		document.getElementsByTagName("input")["rdRandom"].disabled=true;
		document.getElementsByTagName("input")["rdRobin"].disabled =true;
		document.getElementsByTagName("input")["rdShortest"].disabled =true;
		}
		}
		</script>
		
	</HEAD>
	<body>
		<table id="Table3" cellSpacing="1" cellPadding="5" width="1064" bgColor="#6888b4" border="0" height="20">
			<tr>
				<td colspan="2"><b>Dispatch Patterns</b>
				</td>
			</tr>
			<TR bgColor="#eaf4ff">
				<TD  width="15%" align="left">
					Manual Allocation
				</TD>
				<td align="left">
					<INPUT  type="checkbox" id="manuAlloc" name="Checkbox11" onclick="disableRD();">
				</td>
			</TR>
			<TR bgColor="#eaf4ff">
				<TD width="15%" align="left">
					Automatic Allocation 
				</TD>
				<td align="left">
					<INPUT id="autoAlloc" type="checkbox" name="Checkbox12" onclick="dispRD();">
				</td>
			</TR>
			<tr bgColor="#eaf4ff">
				<td colspan="2" valign="middle">&nbsp;&nbsp;<INPUT type="radio" id="rdRandom" disabled name="radio1">Random
				</td>
			</tr>
			<tr bgColor="#eaf4ff">
				<td colspan="2">&nbsp;&nbsp;<INPUT type="radio" id="rdRobin" disabled name="radio1">Round Robin
				</td>
			</tr>
			<tr bgColor="#eaf4ff">
				<td colspan="2">&nbsp;&nbsp;<INPUT type="radio" id="rdShortest" disabled name="radio1">Shortest
				</td>
			</tr>
			<TR>
				<td height="20" colspan="2" align="center">
				</td>
			</TR>
		</table>
		
	</body>
</HTML>
