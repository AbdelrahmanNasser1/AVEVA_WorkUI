<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.Queue.QueueEscalation" Theme="" StylesheetTheme="" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE HTML>
<html>
	<head>
		<title><%=resourceManager.GetString("Escalation Properties")%></title>

        <script src="../../Common/JavaScripts/jquery.min.js"></script>
        <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
       <link rel="stylesheet" type="text/css" href="<%=_QControl.GetThemeRelativeUrl("Common/StyleSheet/Global.css")%>" />
		<link rel="stylesheet" type="text/css" href="<%=_QControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css")%>" />
		<link rel="stylesheet" type="text/css" href="<%=_QControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css")%>" />

		<script language="javascript">
		    
		    function funCheckUser()
		     {
                var radioButtons = document.getElementById("<%=radioResource.ClientID%>");
		        var rdolist = radioButtons.getElementsByTagName("input");
                var _intCount=document.getElementById("txtCount").value; 
                    for(var i=0;i<rdolist.length;i++)
                    {
                      if(rdolist[i].checked)
                         {
                           //alert(rdolist[i].value);
                          // document.getElementById("txtMessage").value=rdolist[i].value;
                          window.opener.document.getElementById("txtreassign").value=rdolist[i].value;
                          window.close();
                          return true
                         }
                    }
                    window.close(); 
		     }
		
		    function OnLoadValues()
		     {
		     //return true;
				
		      var idx=document.getElementById("txtId").value;
		      
		      if(idx=="txtReminderMsg")
		         {                                       
		          document.getElementById("wf_textareaSubject").value=window.opener.document.getElementById("txtRemSubject").value
		          document.getElementById("wf_textareaNotes").value=window.opener.document.getElementById("txtRemNotes").value
		         }
		      else if(idx=="txtNotification")
		       {
		          document.getElementById("wf_textareaSubject").value=window.opener.document.getElementById("txtNotifSubject").value
		          document.getElementById("wf_textareaNotes").value=window.opener.document.getElementById("txtNotifNotes").value        
		        }
		      else if(idx=="txtcallback")
		       {
		       
		         document.getElementById("txtAppName").value=window.opener.document.getElementById("txtcalApplication").value;
		         document.getElementById("txtWfName").value=window.opener.document.getElementById("txtcalWorkflow").value;
		         document.getElementById("wf_textareaContent").value=window.opener.document.getElementById("txtcalContent").value;
		         document.getElementById("txtVersions").value=window.opener.document.getElementById("txtcalVer").value;    
		        }
		        
		       // alert(window.opener.document.getElementById("txtApplication").value);
		       //  document.getElementById("txtApplication").value=window.opener.document.getElementById("txtApplication").value;
		       //  document.getElementById("txtGuid").value=window.opener.document.getElementById("txtQueueId").value;
		         
		     }
		    function SubmitValues()
		      {
		      var idx=document.getElementById("txtId").value;
		      //alert(idx);
		      if(idx=="txtReminderMsg")
		         {
		           window.opener.document.getElementById("txtRemSubject").value=document.getElementById("wf_textareaSubject").value;
		           window.opener.document.getElementById("txtRemNotes").value=document.getElementById("wf_textareaNotes").value
		          /*
		            strSubjectMsg="<subject>"+document.getElementById("wf_textareaSubject").value + "</subject>";
		            strNotesMsg="<notes>"+document.getElementById("wf_textareaNotes").value + "</notes>";
		            window.opener.document.getElementById("txtReminderMsg").value=strSubjectMsg+strNotesMsg;
		            */
		            }
		      else if(idx=="txtNotification")
		       {
		            /*
		            strSubjectMsg="<subject>" + document.getElementById("wf_textareaSubject").value + "</subject>";
		            strNotesMsg="<notes>"+document.getElementById("wf_textareaNotes").value + "</notes>";
		            window.opener.document.getElementById("txtNotification").value=strSubjectMsg+strNotesMsg;        
		            */
		           window.opener.document.getElementById("txtNotifSubject").value=document.getElementById("wf_textareaSubject").value;
		           window.opener.document.getElementById("txtNotifNotes").value=document.getElementById("wf_textareaNotes").value
		       }
		       else if(idx=="txtcallback")
		       {
		       
		        //workflow combo control
		        var appName="";
		        var radComboApp;
		        if(typeof(<%=RadComboBox2.ClientID%>) != 'undefined')
				{					
                    radComboApp = $find("<%= RadComboBox2.ClientID %>"); 
                    appName = radComboApp.get_value();
		        }
		        else
		            appName = document.getElementById('txtApplication').value;    
		        
		        //workflow combo control                
                //get the workflow seleted for using within actionsdata in search actor page

                  var radCombo = $find("<%= RadComboBox1.ClientID %>");                               
				  var wfName = radCombo.get_value();				  

		         window.opener.document.getElementById("txtcalApplication").value=appName;//document.getElementById("txtAppName").value;
		         window.opener.document.getElementById("txtcalWorkflow").value=wfName;//document.getElementById("txtWfName").value;
		         window.opener.document.getElementById("txtcalContent").value=document.getElementById("wf_textareaContent").value;
		         window.opener.document.getElementById("txtcalVer").value=document.getElementById("txtVersions").value;   
		         /*
		         strApplication="<application>" + document.getElementById("txtAppName").value + "</application>";
		         strWorkflow="<workflow>" + document.getElementById("txtWfName").value + "</workflow>";
		         strV="<ver>" + document.getElementById("txtVersions").value + "</ver>";
		         strContent="<content>" + document.getElementById("wf_textareaContent").value + "</content>";
		        // var obj=strApplication+strWorkflow+strContent;
		         window.opener.document.getElementById("txtcallback").value=strApplication + strWorkflow+strContent+strV;
		         */
		       }
		       
		       
		             
		        window.close();
		      }
        </script>
	</head>
	
	<body onload="OnLoadValues()">
		
		<form id="Form1" method="post" runat="server" style="height:100%;">
			<telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
			<%=System.Web.Helpers.AntiForgery.GetHtml()%> 
		    <input type="hidden"id="txtCount" value='<%=intCount%>' />
		    <input type="hidden" id="txtId" value=<%=Request.QueryString["idTxt"]%> />
		    <!--
		    <input type="hidden" id="txtApplication" />
		    <input type="hidden" id="txtGuid" />
		    
		    -->
			<div id="wftriggerdiv" STYLE="DISPLAY:none;position:absolute;left:0;top:0;">
				<TABLE style="width:100%;height:100%;border-collapse:separate;border-spacing:1px;"  class="tablebg" cellpadding="3" ID="Table5" >
					<TR>
						<TD style="vertical-align:top;padding:3px;width:20%" class="lefttdbg">
							<span class='subtitle'><%=resourceManager.GetString("Queue_Escalation_call_Workfow_application")%></span> 
						</TD>
						<td style="width:80%;padding:3px;" class="righttdbg">
							<input type="hidden" value="" NAME="txtAppName" id="txtAppName">
							

							<telerik:RadComboBox   ID="RadComboBox2" EnableLoadOnDemand="false" Height="150px" RenderMode="Classic" runat="server"  Skin="AWTCombobox"   AutoPostBack="True"  EnableEmbeddedSkins="false" AllowCustomText="false">
                                  </telerik:RadComboBox>

                                            <asp:TextBox ID="txtApplication" runat="server" Visible="false" CssClass="inputtext"></asp:TextBox>
						</td>
					</TR>
					<TR>
						<TD style="vertical-align:top;padding:3px;width:20%;" class="lefttdbg">
							<span class='subtitle'><%=resourceManager.GetString("Queue_Escalation_call_Workfow_workflowname")%></span>
						</TD>
						<td style="padding:3px;width:80%;" class="righttdbg">
							<input type="hidden" value="" NAME="txtWfName" id="txtWfName">
							

							<telerik:RadComboBox   ID="RadComboBox1" EnableLoadOnDemand="false" Height="150px" RenderMode="Classic" runat="server"  Skin="AWTCombobox"   AutoPostBack="True"  EnableEmbeddedSkins="false" AllowCustomText="false">
                                  </telerik:RadComboBox>

						</td>
					</TR>
					<TR>
						<TD style="vertical-align:top;width:20%;padding:3px;" class="lefttdbg">
							<span class='subtitle'><%=resourceManager.GetString("Queue_Escalation_call_Workfow_Version")%></span>
						</TD>
						<td style="width:80%;padding:3px;" class="righttdbg">
							<input type="text" value="" name="txtVersions" class="inputtext" id="txtVersions" >
						</td>
					</TR>
					<tr>
					    <td class='lefttdbg' style="padding:3px;">
							<span class="subtitle"><%=resourceManager.GetString("Queue_Escalation_Field")%></span> 
						</td>
						<td  class='righttdbg' style="padding:3px;">
						    <table ID="Table2" class='tablebg' style="border-collapse:collapse;border-spacing:0px;width:60%;">
								<tr>
									<td class='righttdbg'>
										<SELECT id="Select2Reminder" name="Select2Reminder" class="inputselect" onChange="return Select2Reminder_onclick();">
                                            <OPTION value="Select" selected  ><%=resourceManager.GetString("Select")%></OPTION>											
											<OPTION value="Content"><%=resourceManager.GetString("Content")%></OPTION>
											<OPTION value="Value" ><%=resourceManager.GetString("Value")%></OPTION>
                                            <OPTION value="Variable"><%=resourceManager.GetString("Variable")%></OPTION>
										</SELECT>
									</td>
									<td  class='righttdbg'>
										<div id="exprNewReminder">&nbsp;</div>
									</td>
									<td style="width:20px;" class="righttdbg">
										<input type="button" class=inputbutton value="<%=resourceManager.GetString("Queue_btn_Append")%>" ID="Button2" NAME="Button2"  onClick="return InsertFieldNewReminder();">
									</td>
								</tr>
							</table>
						</td>
					</tr>
					
					<TR>
						<TD style="vertical-align:top;width:20%;padding:3px;" class="lefttdbg">
						<span class='subtitle'><%=resourceManager.GetString("Queue_Escalation_Contents")%></span>
						<br /><font class="description"><%=resourceManager.GetString("Queue_Escalation_ContentsDesc")%></font>
						</TD>
						<td style="vertical-align:top;width:80%;padding:3px;" class="righttdbg">						
							<Textarea style="width:615px;height:90px;" class="inputtextarea" id="wf_textareaContent" name="wf_textareaContent"></Textarea>
						</td>
					</TR>
					<tr>
						<td colspan="2" style="text-align:right;padding-right:10px;padding-top:15px;"  class="lefttdbg">
							<input type=button class="inputbutton" id="btn2"  value="<%=resourceManager.GetString("Queue_btn_Submit_Escalation")%>" onclick="SubmitValues()">
						</td>
					</tr>	
				</TABLE>
		  </div>			
			<div id="seekApproval" STYLE="DISPLAY:none;position:absolute">
				<table>
					<tr class="lefttdbg">
						<td colspan="2" align=center>
							UI not defined.
						</td>
					</tr>
				</TABLE>
			</div>
			<div id="assignTask" STYLE="DISPLAY:none;position:absolute">
				<table>
					<tr class="lefttdbg">
						<td colspan="2" align=center>
							UI not defined.
						</td>
					</tr>
				</TABLE>
			</div>
			<div id="seekComment" STYLE="DISPLAY:none;position:absolute">
				<table>
					<TR class="lefttdbg">
						<TD valign="top" width="20%">
							<span class="subtitle"><%=resourceManager.GetString("Queue_Escalation_Field")%></span>
						</TD>
						<td width="80%">
							<Textarea style="width:350;height:140" class="inputtextarea" id="Textarea1" name="Textarea1"></Textarea>
						</td>
					</TR>
					<tr class="lefttdbg">
						<td colspan="2" align="right">
							<input type=button class="inputbutton" id="btn3" value=" Submit " onclick="SubmitValues(this)">
						</td>
					</tr>
				</TABLE>
			</div>			
			<div id="remindermessagediv" STYLE="DISPLAY:none;position:absolute;left:0;top:0;">
				<TABLE style="border-collapse:separate;border-spacing:1px;width:100%;"  ID="Table1">					
					<tr>
						<td colspan="4" style="padding:0px;" >
							<table ID="Table3" style="width:100%;"  class='tablebg'>
								<tr>
									<td class='lefttdbg' style="width:20%;padding:1px;">
										<span class='subtitle'><%=resourceManager.GetString("Queue_Escalation_Field")%></span></td>
									<td class='righttdbg' style="padding:1px;">
										<SELECT id="Select3Reminder" name="Select3Reminder" class="inputselect" language="javascript" onChange="return Select3Reminder_onclick();">
										   <OPTION value="Select" selected  ><%=resourceManager.GetString("Select")%></OPTION>											
											<OPTION value="Content"><%=resourceManager.GetString("Content")%></OPTION>
											<OPTION value="Value" ><%=resourceManager.GetString("Value")%></OPTION>
                                            <OPTION value="Variable"><%=resourceManager.GetString("Variable")%></OPTION>										
										</SELECT>
									</td>
									<td  class='righttdbg' style="padding:1px;">
										<div id="expr2Reminder">&nbsp;</div>
									</td>
									<td style="padding:3px;width:20%;" class='righttdbg'>
										<input type="button" class="inputbutton" value="<%=resourceManager.GetString("Queue_btn_Append")%>" onClick="return InsertFieldReminder();"	ID="Button1" NAME="Button2">
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<TR>
						<TD style="vertical-align:top;width:20%;padding:3px;" class='lefttdbg'>
							<span class="subtitle"><%=resourceManager.GetString("Queue_Escalation_Subject")%></span>
						</TD>
						<td style="width:80%;padding:3px;" class='righttdbg'>
							<Textarea style="width:570px;height:50px;" class="inputtextarea" id="wf_textareaSubject" name="wf_textareaSubject"
								onfocus="javascript:IdentifyMe(this)"></Textarea>
						</td>
					</TR>
					<TR>
						<TD style="vertical-align:top;width:20%;padding:3px;"  class="lefttdbg">
							<span class="subtitle"><%=resourceManager.GetString("Queue_Escalation_Notes")%></span>
						</TD>
						<td style="vertical-align:top;width:80%;padding:3px;" class="righttdbg">
							<Textarea style="width:570px;height:50px;" class="inputtextarea" id="wf_textareaNotes" name="wf_textareaNotes"
								onfocus="javascript:IdentifyMe(this)"></Textarea>
						</td>
					</TR>
					<tr >
						<td colspan="2" style="text-align:right;padding:3px;" class="lefttdbg">
							<input type=button class="inputbutton" value="<%=resourceManager.GetString("Queue_btn_Submit_Escalation")%>" id="btnRem" onclick="SubmitValues()">
						</td>
					</tr>
				</TABLE>
			</div>
			<div id="reassigndiv" STYLE="DISPLAY:none;position:absolute;left:0;top:0;width:100%">
				<TABLE border="0" class="tablebg" cellspacing="1" cellpadding="3" width="100%" ID="Table9">
					<TR>
						<TD class='lefttdbg' width="25%">
                            <span class='subtitle'><%=resourceManager.GetString("Queue_Reassign")%></span>
						</TD>
					</tr>		
					<tr>
						<TD class='lefttdbg'>
							<TABLE width="100%" border="0" cellpadding="1" cellspacing="1">
                              <tr>
                                <td>
                                    <div  style="Overflow:auto;height:120px;">
                                    <span class="style11">
                                        <asp:RadioButtonList ID="radioResource" CssClass="inputradio" runat="server">
                                        </asp:RadioButtonList> 
                                    </span>
                                    </div>
                                 </td>                          
                                       
                              </tr> 
                              </TABLE>
						</TD>
					</TR>
					<tr>
						<td colspan="2" align="right" class='lefttdbg'>
							<input type=button class="inputbutton" value="<%=resourceManager.GetString("Queue_btn_Submit_Escalation")%>" id="btn1" onclick="funCheckUser()">
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

	var ResVar = "<%=_ResourceVariables%>";
	var ConVal = "<%=_ContentValues%>";
    
    var seldiv = "";
	
    
	var valuediv = "<input type=text  id='valueinput' class='inputtext' name='valueinput' />";
	

	var variablediv = "<SELECT id='valueinput' class='inputselect'>";
	variablediv += "'" + ResVar + "'";
	variablediv +=	"</SELECT>";

	var contentdiv = "<SELECT id='valueinput' class='inputselect'>";
	contentdiv += "'" + ConVal + "'";
	contentdiv +=	"</SELECT>";

	var oexpr2Reminder;
	var oexprNewReminder;

	oexpr2Reminder = document.getElementsByTagName("div")["expr2Reminder"];
	
	oexprNewReminder = document.getElementsByTagName("div")["exprNewReminder"];
	
		
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

        function changeDivNewReminder( divvar )
		{
			if( !oexprNewReminder )
				oexprNewReminder = document.getElementsByTagName("div")["exprNewReminder"];

			oexprNewReminder.innerHTML = eval(divvar);
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
                case "Select": changeDivReminder("seldiv");
								break;																
				default: changeDivReminder("variablediv");
					     break;

			}

			return false;
		}

		function Select2Reminder_onclick()
		{
			var oselect2 = document.getElementsByTagName("select")["Select2Reminder"];

			switch(oselect2.value)
			{
				case "Value": changeDivNewReminder("valuediv");
							break;
				case "Variable": changeDivNewReminder("variablediv");
								break;

				case "Content": changeDivNewReminder("contentdiv");
								break;
                case "Select":changeDivNewReminder("seldiv");
								break;								
				default: changeDivNewReminder("variablediv");
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
			//var ovalueinput = document.getElementsByTagName("select")["valueinput"];
			var ovalueinput = document.getElementById("valueinput");
		    if(!FocusedTextArea)
			    FocusedTextArea = document.getElementById("wf_textareaSubject");//document.Form1.wf_textareaSubject;//(not working in framework4)
			var otextarea=FocusedTextArea;
			if(ovalueinput!=null)
			    if(ovalueinput.value!="")
			        if(oselect3.value=="Value")
			            otextarea.value += ovalueinput.value;
			        else
		                otextarea.value += "<"+"%#"+ ovalueinput.value +"%"+">";
	        //otextarea.value += "<#"+ ovalueinput.value +">";
			FocusedTextArea.focus();
		}

        function InsertFieldNewReminder()
		{		
			var oselect2 = document.getElementsByTagName("select")["Select2Reminder"];
			//var ovalueinput = document.getElementsByTagName("select")["valueinput"];
			
			var ovalueinput = document.getElementById("valueinput");
			var FocusedTextNewArea =document.getElementById("wf_textareaContent");// document.Form1.wf_textareaContent;//(not working in framework4)
			var otextarea=FocusedTextNewArea;
			
			if(ovalueinput!=null)
			    if(ovalueinput.value!="")
			        if(oselect2.value=="Value")
			            otextarea.value += ovalueinput.value;
			        else
		                otextarea.value += "<"+"%#"+ ovalueinput.value +"%"+">";
			//otextarea.value += "<#"+ ovalueinput.value +">";
			FocusedTextNewArea.focus();
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
				controltext = "<SELECT name=\""+ControlName+"\" class=inputselect style='"+widthstr+"' TABINDEX='"+TabIndex+"'>";
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
				controltext ="<SELECT name=\""+ControlName+"\" class=inputselect style='"+widthstr+"' TABINDEX='"+TabIndex+"'>";
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
        /*
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
		*/
	}

	function GetDisplayStringMulti(rowid,colid,string)
	{
	  /*
		var colwidth = cols[colid].width;
		var displaystring =string;
		
		if (string.length > 0)
			returnvalue = "<A title='" + string + "' class=gridanchor href='javascript:selectrowmulti("+ rowid +")'>" + displaystring + "</A>";
		else
			returnvalue = "&nbsp;";
		return returnvalue;
		*/
	}

	function addnewrowmulti()
	{
	  /*
		if( !checkandaddvaluesmulti() )
		{
			DrawGridMulti();
		}
		else
		{
			alert(errstr);
			window.setTimeout('findObjMulti("wf_gridinput0").focus();',250);
		}
        */
	}

	function removeselectedmulti()
	{
	   /*
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
		*/
	}

	function checkandaddvaluesmulti()
	{
	/*
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
        */
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