<%@ Page language="c#" Inherits="PatternsProto.QueueView" CodeFile="QueueView.aspx.cs" Theme="" StylesheetTheme=""  %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head runat=server>
		<title></title>

        <script src="../../Common/JavaScripts/jquery.min.js"></script>
        <script src="../../Common/JavaScripts/AutoLogoff.js"></script>

		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="ProgId" content="VisualStudio.HTML">
		<meta name="Originator" content="Microsoft Visual Studio .NET 7.1">
	</head>
	<body>
		<form id="form1">
            <%=System.Web.Helpers.AntiForgery.GetHtml()%>
			<a href="../ProtoMenu.aspx" class=titlesmain>Main Menu</a>
			<br>
			<table id="Table1" cellSpacing="1" cellPadding="5" width="1064" bgColor="#6888b4" border="0"
				height="20">
				<tr>
					<td colspan="2" align="left"><b> Queue View</b>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="left" width="50%" bgColor="#eaf4ff" height="30"><b>
					Partcipants : Product Team, Kevin, Michelle Rose</b> &nbsp;&nbsp;<!--<input id="text1" name="txt" disabled>-->
					</td>
				</tr>
				<tr>
					<td colspan="2"><b>Fields</b></td>
				</tr>
				<tr>
					<TD bgColor="#eaf4ff" height="30" width="25%" colspan="2"><div><TABLE border="0" cellspacing="1" cellpadding="4" width="100%" ID="Table2">
								<TR bgcolor="white">
									<TD colspan="4">Following are the custom field & values.
									</TD>
								</TR>
								<TR class="rowcol">
									<TD width="25%"><B>Name</B></TD>
									<TD width="25%"><B>DispName</B></TD>
									<TD width="10%"><B>Type</B></TD>
									<TD><B>Value</B></TD>
									<!--<TD width=10%>Custom fields set</TD>-->
								</TR>
								<TR bgcolor='E7E7E7'>
									<TD>&nbsp;Cust1</TD>
									<TD>&nbsp;Cust1</TD>
									<TD>&nbsp;string</TD>
									<TD>&nbsp;Value.SendTo.AdministratorId</TD>
								</TR>
								<TR bgcolor='F6F6F6'>
									<TD>&nbsp;Cust2</TD>
									<TD>&nbsp;Cust2</TD>
									<TD>&nbsp;string</TD>
									<TD>&nbsp;DefaultValue</TD>
								</TR>
								<TR bgcolor='E7E7E7'>
									<TD>&nbsp;Cust3</TD>
									<TD>&nbsp;Cust3</TD>
									<TD>&nbsp;string</TD>
									<TD>&nbsp;Variable.SubmittedBy.DepartmentID</TD>
								</TR>
								<TR class="rowcol">
									<TD colspan="5" height="1"><img src="?drawimage=spacer.gif" height="1"></TD>
								</TR>
							</TABLE>
						</div>
					</TD>
				</tr>
				<tr>
					<td colspan="2"><b>Dispatch Patterns</b>
					</td>
				</tr>
				<tr>
					<td colspan="2"><b>Access Rights</b>
					</td>
				</tr>
				<TR>
					<TD bgColor="#eaf4ff" height="30" width="25%">
						Can Put Back: <b>Yes</b></TD>
					<td bgColor="#eaf4ff" height="30">
						Can Ad Hoc Pick Task: <b>No</b></td>
				</TR>
				<TR>
					<TD bgColor="#eaf4ff" height="30" width="25%">
						Can Users Manually Pick Specific Item: <b>Yes</b></TD>
					<td bgColor="#eaf4ff" height="30">
						View Queue?: <b>No</b></td>
				</TR>
				<TR>
					<TD bgColor="#eaf4ff" height="30" width="25%">
						Can View Allocated Item: <b>No</b></TD>
					<td bgColor="#eaf4ff" height="30">
						Can View Unallocated Item: <b>Yes</b></td>
				</TR>
				<tr>
					<td colspan="2"><b>Escalation</b>
					</td>
				</tr>
				<tr>
					<TD bgColor="#eaf4ff" height="30" width="25%" colspan="2"><div id="divgridmulti" style="top:40">&nbsp;</div>
					</TD>
				</tr>
				<TR>
					<td height="20" colspan="2" align="right"><INPUT type="button" name="btnAdd" value="Back" ID="btnBck" onclick="javascript:window.history.back()">
					</td>
				</TR>
			</table>
			<!--<div id="divgridmulti" style="top:40">&nbsp;</div>-->
		</form>
		<SCRIPT>
//alert()
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
function ChangeMessage(objSelItem)
{
	
	var divObj = document.getElementsByTagName("div")["divescLevelMessage"]
	var dispMessage=""
	
	switch (objSelItem.value) 
	{
   case "Acknowledge Warning" :
       dispMessage  = "Valid till the Min [Number or %] of users has not taken ownership (acknowledged) or acted up on the work item till the escalation level is reached. "
       dispMessage += "This level is not resposible for the completion of action. Multiple escalation paths can be set for this level.";
       break;
   case "Acknowledge TimeOut" :
       dispMessage  = "Valid till the Min [Number or %] of users has not taken ownership (acknowledged) or acted up on the work item till the escalation level is reached."
	   dispMessage += "This level is resposible for the completion of action. Only single escalation path can be set for this level."
	   break;
   case "Action Warning" :
	   dispMessage  =	"Valid till the Min [Number or %] of Participants required has not acted up on the work item till the escalation level is reached."
	   dispMessage  +=	"This level is not resposible for the completion of action. Multiple escalation paths can be set for this level."
	   break;
   case "Action TimeOut" :
	   dispMessage  =	"Valid till the Min [Number or %] of Participants required has not acted up on the work item till the escalation level is reached."
	   dispMessage  +=	"This level is resposible for the completion of action. Only single escalation path can be set for this level."
	   break;
	} 
	divObj.innerHTML = dispMessage;
	divObj.style.display="block";
	
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
function ShowSepDiv(selObj)
{
	var val = selObj.value;
	if(val != "")
	{
		if(PrevContentDiv)
			PrevContentDiv.style.display="none"
		
		PrevContentDiv = document.getElementById(val);
		PrevContentDiv.style.display="block" 
	}
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

	AddColumnMulti('Time Interval',0,null,null,true,'15%','timespan','0.00:00:00');
	AddColumnMulti('Recurring?',0,'select','Select:,Yes:YES,No:NO',true,'10%','','');
	AddColumnMulti('Recurring Time Interval',0,null,null,true,'20%','timespan','0.00:00:00');
	AddColumnMulti('Escalation Types',0,null,null,true,'35%','','TimeOutWarning-');
	AddColumnMulti('Properties',0,null,null,true,'18%','','');
	//AddColumnMulti('Path',0,null,null,true,'15%','','TimeOutWarning-');

//AddRowMulti('','','','','');
	AddRowMulti('0.00:01:00','Yes','0.00:00:20','Reminder Message','View');
	AddRowMulti('0.00:02:00','Yes','0.00:00:50','Reminder Message, Workflow Trigger','View');
	AddRowMulti('0.00:20:00','No','0.00:00:00','','','TimeOutWarning1');
	
	AddRowMulti('0.00:05:00','Yes','0.00:01:00','Reminder Message, Workflow Trigger','View');
	AddRowMulti('0.00:07:00','No','0.00:02:50','Re Assign','View');
	AddRowMulti('0.00:00:40','Yes','0.00:00:00','Action Output','View');
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
		innerhtml = "<TABLE width=1010 bgcolor=#808080 cellspacing=1>";

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

		
		innerhtml +="</TABLE>";
		obj.innerHTML = innerhtml;
		//height = (rows.length * 15) + 60;

		//window.setTimeout('findObjMulti("wf_gridinput0").focus();',250);
	}

	function GetDisplayStringMulti(rowid,colid,string)
	{
		
		
		var colwidth = cols[colid].width;
		var displaystring =string;
		
		if((cols.length - 1) == colid)
		{
			if (string.length > 0)
				returnvalue = "<A title='" + string + "' class=gridanchor href='#' onclick=\"javascript:window.open('EscalationProperties.aspx?mode=details','properdetails','height=200,width=300,resizable=yes,scrollbars=yes','')\">" + displaystring + "</A>";
			else
				returnvalue = "&nbsp;";
		}
		else
		{
			if (string.length > 0)
				returnvalue = "<A title='" + string + "' class=gridanchor href='javascript:selectrowmulti("+ rowid +")'>" + displaystring + "</A>";
			else
				returnvalue = "&nbsp;";
		}
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
		</SCRIPT>
	</body>
</html>
