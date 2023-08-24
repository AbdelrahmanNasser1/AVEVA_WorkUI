<%@ Page language="c#" Inherits="PatternsProto.EscalationProperties" CodeFile="EscalationProperties.aspx.cs" Theme="" StylesheetTheme=""  %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>EscalationProperties</title>
        <script src="../../Common/JavaScripts/jquery.min.js"></script>
        <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<%=System.Web.Helpers.AntiForgery.GetHtml()%>
			<br>
			<br>
			<div id="wftriggerdiv" STYLE="DISPLAY:none;position:absolute">
				<TABLE border="0" bgcolor="#D2D3D3" cellspacing="1" cellpadding="3" ID="Table5">
					<TR bgcolor="white">
						<TD valign="top" width="20%">
							Application Name
						</TD>
						<td width="80%">
							<input type="text" value="" NAME="txtAppName" CLASS="INPUTS1">
						</td>
					</TR>
					<TR bgcolor="white">
						<TD valign="top" width="20%">
							Workflow Name
						</TD>
						<td width="80%">
							<input type="text" value="" NAME="txtWfName" CLASS="INPUTS1">
						</td>
					</TR>
					<TR bgcolor="white">
						<TD valign="top" width="20%">
							Version
						</TD>
						<td width="80%">
							<input type="text" value="" NAME="txtVersions" CLASS="INPUTS1">
						</td>
					</TR>
					<tr bgcolor="white">
						<td colspan="2">
							<table ID="Table2">
								<tr>
									<td width="35">
										Field :
									</td>
									<td width="40">
										<SELECT id="Select2Reminder" name="Select2Reminder" language="javascript">
											<OPTION value="Variable">Variable</OPTION>
											<OPTION value="Content">Content</OPTION>
											<OPTION value="Value" selected>Value</OPTION>
										</SELECT>
									</td>
									<td>
										<div id="expr3Reminder">&nbsp;</div>
									</td>
									<td width="20">
										<input type="button" class="buttons" value="Append" ID="Button2" NAME="Button2">
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<TR bgcolor="white">
						<TD valign="top" width="20%">
							Contents
						</TD>
						<td width="80%">
							<input type="checkbox" name="chkContent" onclick="javascript:if(this.checked && document.Form1.wf_textareaContent.value != ''){alert('If this option is checked the value entered for Contents will not be considered.')}">Pass 
							parent worklfow contents to child
							<br>
							<Textarea style="width:550;height:140" class="list" id="wf_textareaContent" name="wf_textareaContent"></Textarea>
						</td>
					</TR>
					<tr bgcolor="white">
						<td colspan="2" align=center>
							<input type=button class=buttons value=" Submit ">
						</td>
					</tr>	
				</TABLE>
			</div>			
			<div id="seekApproval" STYLE="DISPLAY:none;position:absolute">
				<table>
					<tr bgcolor="white">
						<td colspan="2" align=center>
							UI not defined.
						</td>
					</tr>
				</TABLE>
			</div>
			<div id="assignTask" STYLE="DISPLAY:none;position:absolute">
				<table>
					<tr bgcolor="white">
						<td colspan="2" align=center>
							UI not defined.
						</td>
					</tr>
				</TABLE>
			</div>
			<div id="seekComment" STYLE="DISPLAY:none;position:absolute">
				<table>
					<TR bgcolor="white">
						<TD valign="top" width="20%">
							Comments
						</TD>
						<td width="80%">
							<Textarea style="width:350;height:140" class="list" id="wf_textareaContent" name="wf_textareaContent"></Textarea>
						</td>
					</TR>
					<tr bgcolor="white">
						<td colspan="2" align=center>
							<input type=button class=buttons value=" Submit ">
						</td>
					</tr>
				</TABLE>
			</div>			
			<div id="remindermessagediv" STYLE="DISPLAY:none;position:absolute">
				<TABLE border="0" bgcolor="#D2D3D3" cellspacing="1" cellpadding="3" ID="Table5">
					<TR bgcolor="white">
						<TD width="20%">
							Resource to whom reminder has to be sent.
						</TD>
						<TD>
							<input name='btnSetPref' class="buttons" type="button" style='' TABINDEX='' value='Set Resource'
								onclick="javascript:window.open('Actors.aspx?resfilter=1','CapPref','height=550,width=700,resizable=yes,scrollbars=yes','')">
							(Give an indication if the resource is already set)
						</TD>
					</TR>
					<tr bgcolor="white">
						<td colspan="2">
							<table ID="Table2">
								<tr>
									<td width="35">
										Field :
									</td>
									<td width="40">
										<SELECT id="Select3Reminder" name="Select3Reminder" language="javascript" onchange="return Select3Reminder_onclick();">
											<OPTION value="Variable">Variable</OPTION>
											<OPTION value="Content">Content</OPTION>
											<OPTION value="Value" selected>Value</OPTION>
										</SELECT>
									</td>
									<td>
										<div id="expr2Reminder">&nbsp;</div>
									</td>
									<td width="20">
										<input type="button" class="buttons" value="Append" onclick="return InsertFieldReminder();"
											ID="Button2" NAME="Button2">
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<TR bgcolor="white">
						<TD valign="top" width="20%">
							Subject
						</TD>
						<td width="80%">
							<Textarea style="width:550;height:140" class="list" id="wf_textareaSubject" name="wf_textareaSubject"
								onfocus="javascript:IdentifyMe(this)"></Textarea>
						</td>
					</TR>
					<TR bgcolor="white">
						<TD valign="top" width="20%">
							Notes
						</TD>
						<td width="80%">
							<Textarea style="width:550;height:140" class="list" id="wf_textareaNotes" name="wf_textareaNotes"
								onfocus="javascript:IdentifyMe(this)"></Textarea>
						</td>
					</TR>
					<tr bgcolor="white">
						<td colspan="2" align=center>
							<input type=button class=buttons value=" Submit ">
						</td>
					</tr>
				</TABLE>
			</div>
			<div id="reassigndiv" STYLE="DISPLAY:none;position:absolute">
				<TABLE border="0" bgcolor="#D2D3D3" cellspacing="1" cellpadding="3" ID="Table9">
					<TR bgcolor="white">
						<TD width="25%">
							Resource to whom work item has to be re assigned.
						</TD>
						<TD>
							<input name='btnSetPref' class="buttons" type="button" style='' TABINDEX='' value='Set Resource'
								onclick="javascript:window.open('Actors.aspx?resfilter=1','CapPref','height=550,width=700,resizable=yes,scrollbars=yes','')">
							(Give an indication if the resource is already set)
						</TD>
					</TR>
					<tr bgcolor="white">
						<td colspan="2" align=center>
							<input type=button class=buttons value=" Submit ">
						</td>
					</tr>
				</TABLE>
			</div>
		</form>
	</body>
	<SCRIPT>
var PrevContentDiv;
var FocusedTextArea;
var mandatory="True";
	
	var valuediv = "<SELECT id='valueinput'>";
	valuediv += "<OPTION Value='Value.SendTo.Email'>Value.SendTo.Email</OPTION><OPTION Value='Value.SendTo.FirstName'>Value.SendTo.FirstName</OPTION><OPTION Value='Value.SendTo.Name'>Value.SendTo.Name</OPTION><OPTION Value='Value.SendTo.Project'>Value.SendTo.Project</OPTION><OPTION Value='Value.SendTo.UserId'>Value.SendTo.UserId</OPTION>";
	valuediv +=	"</SELECT>";

	var variablediv = "<SELECT id='valueinput'>";
	variablediv += "<OPTION value='Variable.Variable1'>Variable1</OPTION><OPTION value='Variable.Variable2'>Variable2</OPTION><OPTION Value='Variable.SubmittedBy.Email'>Variable.SubmittedBy.Email</OPTION><OPTION Value='Variable.SubmittedBy.FirstName'>Variable.SubmittedBy.FirstName</OPTION><OPTION Value='Variable.SubmittedBy.Name'>Variable.SubmittedBy.Name</OPTION><OPTION Value='Variable.SubmittedBy.Project'>Variable.SubmittedBy.Project</OPTION><OPTION Value='Variable.SubmittedBy.UserId'>Variable.SubmittedBy.UserId</OPTION>";
	variablediv +=	"</SELECT>";

	var contentdiv = "<SELECT id='valueinput'>";
	contentdiv += "";
	contentdiv +=	"</SELECT>";

	var oexpr2Reminder;

	oexpr2Reminder = document.getElementsByTagName("div")["expr2Reminder"];
		
function IdentifyMe(textObj)
{
	FocusedTextArea = textObj;	
}
function changeDivReminder( divvar )
		{
			if( !oexpr2Reminder )
				oexpr2Reminder = document.getElementsByTagName("div")["expr2Reminder"];

			oexpr2Reminder.innerHTML = eval(divvar);
		}

		function Select3Reminder_onclick()
		{
			var oselect3 = document.getElementsByTagName("select")["Select3Reminder"];

			switch(oselect3.value)
			{
				case "Value": changeDivReminder("valuediv");
							break;
				case "Variable": changeDivReminder("variablediv");
								break;

				case "Content": changeDivReminder("contentdiv");
								break;
				default: changeDivReminder("variablediv");
					     break;

			}

			return false;
		}

	//variable declaration for scroll
	var obj;
	var height=255;
	var imgtop=40;
	var visiblewidth = 460 + 20;
	var visible=180;
	var visibletop=0;
	var slidespeed =10;
	var visibleheight=180;
	var stopslidingup=false;
	var stopslidingdn=false;
	//*************************************

	var errstr="";
	var rowempty=false;
	var cols= new Array(0);
	var rows= new Array(0);
	var CustomControls = new Array();
	var gridwidth = 460;
	var mandatory="False";

	AddColumnMulti('Time Interval',0,null,null,true,'25%','timespan','0.00:00:00');
	AddColumnMulti('Recurring?',0,'select','Select:,Yes:YES,No:NO',true,'10%','','');
	AddColumnMulti('OutPut',0,null,null,true,'40%','','TimeOutWarning-');
	AddColumnMulti('Recurring Time Interval',0,null,null,true,'25%','timespan','0.00:00:00');

	AddRowMulti('0.00:01:00','YES','TimeOutWarning','0.00:00:20');AddRowMulti('0.00:20:00','NO','TimeOutWarning1','0.00:00:00');AddRowMulti('0.00:00:40','YES','TimeOutWarning2','0.00:00:00');
	DrawGridMulti();
	function InsertFieldReminder()
		{

			var oselect3 = document.getElementsByTagName("select")["Select3Reminder"];
			var ovalueinput = document.getElementsByTagName("select")["valueinput"];
			
			if(!FocusedTextArea)
				FocusedTextArea = document.Form1.wf_textareaSubject
				
			var otextarea=FocusedTextArea;
			otextarea.value += "<#"+ ovalueinput.value +">";
			FocusedTextArea.focus();
		}

	function findObjMulti(n, d)
	{
		var p,i,x;
		if(!d) d=document;
		if((p=n.indexOf("?"))>0&&parent.frames.length)
		{
			d=parent.frames[n.substring(p+1)].document;
			n=n.substring(0,p);
		}
		if(!(x=d[n])&&d.all) x=d.all[n];
		for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
		for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
		if(!x && d.getElementById) x=d.getElementById(n);
		return x;
	}


	function GetControlTextMulti(ControlName, ControlType, Width, TabIndex, Values,defaultvalue)
	{
		var controltext="";
		var valuearray;
		var i;

		var widthstr;

		if(Width > 0)
			widthstr = "width: "+Width;
		else
			widthstr = "";

		switch(ControlType)
		{
			case "select":
				controltext = "<SELECT name=\""+ControlName+"\" class=gridtableinputs style='"+widthstr+"' TABINDEX='"+TabIndex+"'>";
				var selectvalues=Values.split(",");

				for(i=0;i<selectvalues.length;i++)
				{
					valuearray = selectvalues[i].split(":");
					if (defaultvalue == valuearray[1])
						controltext	+= "<OPTION value=\"" + valuearray[1] + "\" selected>" + valuearray[0] + "</OPTION>";
					else
						controltext	+= "<OPTION value=\"" + valuearray[1] + "\">" + valuearray[0] + "</OPTION>";
				}
				controltext += "</SELECT>";
				break;
			case "variable":
				controltext ="<SELECT name=\""+ControlName+"\" class=gridtableinputs style='"+widthstr+"' TABINDEX='"+TabIndex+"'>";
				controltext += "<OPTION value='Variable.[Email] = [Variable.SubmittedBy.Email]'>Variable.[Email] = [Variable.SubmittedBy.Email]</OPTION><OPTION value='Variable.[FirstName] = ['Jim'] Or [Project] = [Variable.SubmittedBy.Project]'>Variable.[FirstName] = ['Jim'] Or [Project] = [Variable.SubmittedBy.Project]</OPTION>";
				controltext +=	"</SELECT>";
				break;
			default:
				controltext ="<input name=\""+ControlName+"\" class=gridtableinputs type=textbox style='"+widthstr+"' TABINDEX='"+TabIndex+"' value='"+ defaultvalue+"'>";
				break;

		}

		return controltext;
	}

	function getcustomcontrolindexmulti(controlname)
	{
		var returnvalue=-1;
		var i=0;
		for(i=0;i<CustomControls.length;i++)
		{
			if (CustomControls[i].name == controlname)
				returnvalue = i;
		}
		return returnvalue;
	}

	function rowmulti()
	{
		this.selected =false;
		this.cols = new Array(cols.length);
	}

	function colmulti()
	{
		this.titlestring = "";
		this.width=0; //Max width of the field
		this.type="";
		this.values="";
		this.mandatory=false;
		this.displaywidth=""; //Display width for the column (to be specified with the TD tag)
		this.validationtype="";
	}

	function AddColumnMulti(titlestring,width,type,values,mandatory,displaywidth,validationtype,defaultvalue)
	{
		var arrayindex = 0;
		arrayindex  = cols.length;
		cols[arrayindex] = new colmulti();
		cols[arrayindex].titlestring = titlestring;

		//if( parseInt(width) >= 100 )
		//	cols[arrayindex].width = 0;
		//else
		//	cols[arrayindex].width = (parseInt(gridwidth)) * parseInt(width) / 100;

		cols[arrayindex].width = parseInt(width);
		cols[arrayindex].displaywidth = displaywidth;
		cols[arrayindex].mandatory = mandatory;
		cols[arrayindex].validationtype = validationtype;
		cols[arrayindex].defaultvalue = defaultvalue;

		if( type != null )
		{
			if( type == "select" )
			{
				cols[arrayindex].type = type;
				cols[arrayindex].values=values;
			}
			if( type == "variable" )
			{
				cols[arrayindex].type = type;
			}

		}
	}

	function AddRowMulti()
	{
		var newarrayid = rows.length;
		rows[newarrayid] = new rowmulti();
		for (i=0;i<cols.length;i++)
		{
			if((arguments.length-1) >= i)
			{
				rows[newarrayid].cols[i] = arguments[i];
			}
			else
			{
				rows[newarrayid].cols[i] = "";
			}
		}
	}

	function DrawGridMulti()
	{

		if(navigator.userAgent.indexOf("Netscape") >0 )
				document.all = document.getElementsByTagName("*");

		var obj = document.all["divgridmulti"];
		var controltext ="";
		var customcontrolindex;

		var innerhtml="";
		var colwidth=0;
		innerhtml = "<TABLE width=460 bgcolor=#808080 cellspacing=1>";

		innerhtml += "<TR bgcolor=#d4d0c8>";
		innerhtml += "<TD bgcolor=#d4d0c8 width=15>&nbsp;</TD>";

		for (i = 0;i<cols.length;i++)
		{
			innerhtml += "<TD width='"+cols[i].displaywidth+"'>";
			innerhtml += cols[i].titlestring;
			innerhtml +="</TD>";
		}
		innerhtml +="</TR>";
		for (i = 0;i<rows.length;i++)
		{
			innerhtml +="<TR bgcolor=white>";
			innerhtml += "<TD bgcolor=#d4d0c8 width=15>&nbsp;</TD>";
			for(j=0;j<cols.length;j++)
			{
				innerhtml += "<TD height=15 >";
				innerhtml += "<div id='rowmulti" + i +"colmulti" + j +"'>" + GetDisplayStringMulti(i,j,rows[i].cols[j]) + "</div>";
				innerhtml += "</TD>";
			}
			innerhtml +="</TR>";
		}

		innerhtml += "<TR bgcolor=white>";
		innerhtml += "<TD bgcolor=#d4d0c8 width=15>&nbsp;</TD>";
		for (i = 0;i<cols.length;i++)
		{
			colwidth = cols[i].width;
			if (parseInt(colwidth) ==0)
				colwidth = parseInt(gridwidth) / (cols.length + 1);

			innerhtml += "<TD>";

			controltext=GetControlTextMulti("wf_gridinput" + i , cols[i].type, cols[i].width, i+1, cols[i].values,cols[i].defaultvalue);

			innerhtml += controltext;

			innerhtml +="</TD>";
		}
		innerhtml +="</TR>";
		innerhtml +="</TABLE>";
		obj.innerHTML = innerhtml;
		//height = (rows.length * 15) + 60;

		//window.setTimeout('findObjMulti("wf_gridinput0").focus();',250);
	}

	function GetDisplayStringMulti(rowid,colid,string)
	{
		var colwidth = cols[colid].width;
		var displaystring =string;
		
		if (string.length > 0)
			returnvalue = "<A title='" + string + "' class=gridanchor href='javascript:selectrowmulti("+ rowid +")'>" + displaystring + "</A>";
		else
			returnvalue = "&nbsp;";
		return returnvalue;
	}

	function addnewrowmulti()
	{
		if( !checkandaddvaluesmulti() )
		{
			DrawGridMulti();
		}
		else
		{
			alert(errstr);
			window.setTimeout('findObjMulti("wf_gridinput0").focus();',250);
		}

	}

	function removeselectedmulti()
	{
		if(navigator.userAgent.indexOf("Netscape") >0 )
					document.all = document.getElementsByTagName("*");

		obj = document.all["wf_gridinput0"];
		if (obj.value.length > 0 )
		{
			checkandaddvaluesmulti()
		}

		var temprows=new Array();
		var arrayindex = 0;
		for (i=0;i<rows.length;i++)
		{
			if (! rows[i].selected)
			{
				temprows[temprows.length] = rows[i];
			}
		}
		rows = temprows;
		DrawGridMulti();
	}

	function checkandaddvaluesmulti()
	{
		var temprow = new rowmulti();
		var flag = false;
		var err=false;

		errstr="";
		if(navigator.userAgent.indexOf("Netscape") >0 )
			document.all = document.getElementsByTagName("*");

		var obj;
		for (i=0;i<cols.length;i++)
		{
			obj = document.all["wf_gridinput" + i];
			//alert(cols[i].validationtype)
			var objValue = obj.value;
			if (objValue.length > 0 )
				{
					flag=true;
					if( cols[i].validationtype.length > 0 && cols[i].validationtype == "timespan")
					{
						var toMatchstr = obj.value
						if (toMatchstr.indexOf(".") < 0 )
							toMatchstr += ".00:00:00"

						var timeSpanPat = /^\d*\.[0-2]{1}[0-3]{1}\:[0-5]{1}[0-9]{1}\:[0-5]{1}[0-9]{1}/;
						var timeSpanPat1 = /^\d*\.[0-1]{1}[0-9]{1}\:[0-5]{1}[0-9]{1}\:[0-5]{1}[0-9]{1}/;
						var matchArray = toMatchstr.match(timeSpanPat);
						var matchArray1 = toMatchstr.match(timeSpanPat1);
						if(matchArray == null && matchArray1 == null)
						{
							err=true;
							errstr += "Not a valid Time Span (dd.hh:mm:ss) Value "+ cols[i].titlestring +"\r\n";
						}
					}
				}
			else

				if( cols[i].mandatory)
				{
					err=true;
					errstr += "Please specify value for "+cols[i].titlestring+"\r\n";
				}


			if(objValue.indexOf('<') >= 0 || objValue.indexOf('>') >=0)
			{
				err=true;
				errstr += "Please specify valid value for "+cols[i].titlestring+"\r\n";
			}

			temprow.cols[i] = objValue;
		}
		if (flag && !err)
			rows[rows.length] = temprow;

		//if(rows.length == 0 && !flag)
		//	flag = false;

		rowempty = !flag;

		if(mandatory =="True" && rows.length == 0)
			{
				rowempty=false;
				err=true;
				errstr += "Atleast one rowmulti needs to be defined.\r\n";
			}
		return (err);

	}

	function selectrowmulti(rowid)
	{
		var obj
		for (i=0;i<cols.length;i++)
		{
			obj = document.all["rowmulti"+rowid + "colmulti" + i];
			if (rows[rowid].selected)
				obj.style.backgroundColor = "white";
			else
				obj.style.backgroundColor = "#DBEAF5";
		}
		rows[rowid].selected  = !rows[rowid].selected;
	}

	function getgridvaluesmulti()
	{
		var returnstring="";
		var returnsubstring = "";

		returnstring += ConvertToStringmulti(rows.length,4);
		for (i=0;i<rows.length;i++)
		{
			returnsubstring = "";
			returnsubstring += ConvertToStringmulti(cols.length,4);
			for (j=0;j<cols.length;j++)
			{
				returnsubstring += "$" + ConvertToStringmulti(rows[i].cols[j].length,4)+rows[i].cols[j] ;
			}

			returnsubstring = ConvertToStringmulti( returnsubstring.length, 4 )+returnsubstring;
			returnstring +="#" + returnsubstring;
		}


		return returnstring;
	}

	function ConvertToStringmulti(  number,  width )
	{
		var str="";
		var i;

		str=number.toString();
		var l = str.length;
		for(i=0;i<(width-l);i++)
		{
			str = "0" + str;
		}
		return str.substring(0,width);
	}
function ShowSepDiv(selObj)
{
	var val = selObj;
	if(val != "")
	{
		if(PrevContentDiv)
			PrevContentDiv.style.display="none"
		
		PrevContentDiv = document.getElementById(val);
		PrevContentDiv.style.display="block" 
	}
}
	</SCRIPT>
	<%
if (Request.QueryString["pageview"] != null)
{
	Response.Write("<script>ShowSepDiv(\""+Request.QueryString["pageview"]+"\")</script>");
}
else
{
	Response.Write("Property details will be displayed here");
}
%>
</html>
