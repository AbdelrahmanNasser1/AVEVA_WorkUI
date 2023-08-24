<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.ProcessExecutionView.OpenImageMap" Theme="" StylesheetTheme="" %>
<%@ OutputCache Location="None"  %>
<html>


<head runat="server">

    <title>Untitled Page</title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    
    <script language="javascript">
    
        function NodeClicked(nodename,el)
        {        
            if( el.getAttribute("awesuri") != null )
            {
                var left = (screen.width / 2) - (700 / 2);
                var top = (screen.height / 2) - (500 / 2);
                var loc="showview.aspx?suri="+el.getAttribute("awesuri")+"&cul="+parent._skUICulture;
                window.open(loc, el.getAttribute('edid'), 'height=500,width=700,resizable=yes,scrollbars=no,status=no,top=' + top + ', left=' + left);
                return;
            }
            if( el.getAttribute("edid") != null )
            {
                var left = (screen.width / 2) - (650 / 2);
                var top = (screen.height / 2) - (300 / 2);                             

                var loc=window.location.toString();
                loc=loc.replace("OpenImageMap.aspx","executiondetailswindow.aspx");            
                loc += "&edid="+el.getAttribute("edid");
                //Added the id ,as the Mozilla browser opens a new window everytime 
                window.open(loc,"WinExecutionDetails",'height=300,width=650,resizable=yes,scrollbars=yes,status=no,top=' + top + ', left=' + left);
            }
        }

        function WriteClientTime(TimeVal,DisplayType)
        {
            if( TimeVal == null || TimeVal == "" ) return "";
            var outtime="";
			var writeTime = convertutctoclientdate(TimeVal)
			TodaysDate =  new Date();
			
			var assigneddate = writeTime.getDate() +"/"+ writeTime.getMonth()+ 1 +"/"+ writeTime.getFullYear();
			var TodaysDateValue = TodaysDate.getDate() +"/"+ TodaysDate.getMonth()+ 1 +"/"+ TodaysDate.getFullYear();
			var dn="AM" 
			hours  = writeTime.getHours();
			minutes = writeTime.getMinutes();
			seconds = writeTime.getSeconds();
			if (hours >= 12)
			{
				dn="PM"
				hours=hours-12
			//this is so the hours written out is 
			//in 12-hour format, instead of the default //24-hour format.
			}
			if (hours == 0 )
					hours = 12
			//this is so the hours written out 
			//when hours=0 (meaning 12a.m) is 12
			if (minutes <= 9)
				minutes="0"+ minutes
			if (seconds <= 9)
				seconds="0"+ seconds		
			var assignedtime = hours +":"+ minutes +":"+ seconds +" "+ dn ;
			if (DisplayType == 0)
			{
				outtime += assignedtime;
			}		
			else
			{
				
				
				if (TodaysDateValue == assigneddate)
				{
					outtime += assignedtime;
				}
				else
				{
					
					if (TodaysDate.getFullYear() == writeTime.getFullYear())
					{
						outtime += (GetMonthName(writeTime.getMonth()+ 1) +"-"+ writeTime.getDate() +", "+ assignedtime);
					}
					else
					{
						outtime += (writeTime.getDate() +"-"+ GetMonthName(writeTime.getMonth()+ 1) +"-"+ writeTime.getFullYear() +", "+ assignedtime );
					}
				}
			 }

            return outtime;
        }


        
        function NodeShowToolTip(el)
        {
            el.title="";
            el.alt="";

            var df=el.getAttribute("df");
            
            var a=new Array();
            a.push("<table border='0' width='275px' class='description' ><tr><td colspan=2>");
            a.push("<b><%=GR.GetString("Report Designer Action Details")%></b><br><%=GR.GetString("(Click on the node to see more details)")%></td>");
            a.push("</tr>");
            
            if( df==2 )
            {
                if( el.getAttribute("ecount") != 1 )
                {
                    a.push("<tr><td colspan=2><b>[<%=GR.GetString("This activity has executed")%> "+el.getAttribute("ecount")+" <%=GR.GetString("times")%>]</b></td>");
                    a.push("</tr>");    
                    a.push("<tr><td colspan=2><%=GR.GetString("See Execution View for previous executions details") %></td>");
                    a.push("</tr>");    

                }
            }
            
            a.push("<tr><td width='130px'><%=GR.GetString("Report Designer Label Action name")%></td>");
            a.push("<td>"+el.getAttribute("aname")+"</td></tr>");
            
            a.push("<tr><td><%=GR.GetString("Report Designer Label Status")%></td>");
            a.push("<td>"+el.getAttribute("astatus")+"</td></tr>");

            a.push("<tr><td><%=GR.GetString("Report Designer Label Execution start time")%></td>");
            a.push("<td>"+WriteClientTime(el.getAttribute("astime"),1)+"</td></tr>");
            //'"+action.StartTime.ToString("G",System.Globalization.DateTimeFormatInfo.InvariantInfo)+"'

            a.push("<tr><td><%=GR.GetString("Report Designer Label Execution end time")%></td>");            
            a.push("<td>"+WriteClientTime(el.getAttribute("aetime"),1)+"</td></tr>");


            a.push("<tr><td><%=GR.GetString("Report Designer Label Output")%></td>");
            a.push("<td>"+el.getAttribute("aoutput")+"</td></tr>");

            a.push("<tr><td><%=GR.GetString("Report Designer Label Host")%></td>");
            a.push("<td>"+el.getAttribute("ahost")+"</td></tr>");

            a.push("<tr><td><%=GR.GetString("Report Designer Label Fast Time")%></td>");
            a.push("<td>"+el.getAttribute("afasttime")+" minutes</td></tr>");
            
            a.push("<tr><td><%=GR.GetString("Report Designer Label Slow Time")%></td>");
            a.push("<td>"+el.getAttribute("aslowtime")+" minutes</td></tr>");
            
            a.push("<tr><td><%=GR.GetString("Report Designer Label Average Time")%></td>");
            a.push("<td>"+el.getAttribute("aavgtime")+" minutes</td></tr>");


            a.push("</table>");                 
            
            parent.ShowToolTip(el,a.join(""),280,window);            
            
        }
        
        
        
        
        function NodeHideTooltip(el)
        {
            try
            {
                parent.HideToolTip();
            }
            catch(e) {}
        }
        
        function convertutctoclientdate(utcdatetime)
        {
	        //alert( "inside function" + utcdatetime );
	        //return false;
	        if (utcdatetime=='') return '';
	        var d1 = new Date()

	        var strtemp
	        //getTimezoneOffset gives the Time Difference in Minutes
	        if (d1.getTimezoneOffset()<=0)
		        sign=1
	        else
		        sign=-1
	        offsettime=Math.abs(d1.getTimezoneOffset())

	        //Hours
	        offsettime2=offsettime/60

	        strtemp=offsettime2.toString()
	        strtemp2=""
	        strtemp2=strtemp.split(".")
	        if (strtemp2.length>0)
		        offsethrs=eval(strtemp2[0])	
	        else
		        offsethrs=eval(strtemp)

	        offsethrs=sign*offsethrs

	        //Minutes
	        offsetmins=sign*(offsettime%60)

	        var d2 = new Date(utcdatetime)
	        d2.setHours(d2.getHours()+offsethrs)	
	        d2.setMinutes(d2.getMinutes()+offsetmins)
	        formatstring(d2.getMinutes(),2);

	        return d2;
        }
        
        function formatstring(strtemp,n)
        {
	        var s,s2,i;
	        s=strtemp.toString()
	        s2='';
	        if (s.length<n)
	        {
		        for(i=1;i<=n-s.length;i++)
		        s2=s2+'0';
	        }
	        return (s2+s)
        }
        
        function GetMonthName(MonthNo)
        {
        	
	        if(MonthNo==1)
		        return "<%=GR.GetString("Jan")%>";
	        if(MonthNo==2)
		        return "<%=GR.GetString("Feb")%>";
	        if(MonthNo==3)
		        return "<%=GR.GetString("Mar")%>";
	        if(MonthNo==4)
		        return "<%=GR.GetString("Apr")%>";
	        if(MonthNo==5)
		        return "<%=GR.GetString("May")%>";
	        if(MonthNo==6)
		        return "<%=GR.GetString("Jun")%>";
	        if(MonthNo==7)
		        return "<%=GR.GetString("Jul")%>";
	        if(MonthNo==8)
		        return "<%=GR.GetString("Aug")%>";
	        if(MonthNo==9)
		        return "<%=GR.GetString("Sep")%>";
	        if(MonthNo==10)
		        return "<%=GR.GetString("Oct")%>";
	        if(MonthNo==11)
		        return "<%=GR.GetString("Nov")%>";
	        if(MonthNo==12)
		        return "<%=GR.GetString("Dec")%>";								
        	
        }

        parent.document.getElementById("sumStartedOn").innerHTML = WriteClientTime("<%= WE.StartedOn.ToString("G",System.Globalization.DateTimeFormatInfo.InvariantInfo) %>",1);
        parent.document.getElementById("sumSubmittedBy").innerHTML = "<%=((WE.SubmittedBy != null)?(string)WE.SubmittedBy.Properties.Name.Value:"N.A.") %>";
        parent.document.getElementById("sumWorkflowName").innerHTML = "<%=(WE.WorkflowName+" (v "+WE.WorkflowVersion.ToString()+")") %>";
        parent.document.getElementById("sumEndedAt").innerHTML = WriteClientTime("<%= (WE.ExecutionEndedAt != DateTime.MinValue) ? WE.ExecutionEndedAt.ToString("G",System.Globalization.DateTimeFormatInfo.InvariantInfo) : WE.LastUpdatedOn.ToString("G",System.Globalization.DateTimeFormatInfo.InvariantInfo)%>",1);
        parent.document.getElementById("sumEndedAtTitle").innerHTML = "<%= (WE.ExecutionEndedAt != DateTime.MinValue)?GR.GetString("Ended On"):GR.GetString("Last Activity") %>";
        parent.document.getElementById("sumStatus").innerHTML = "<%= WE.StatusMessage%>";
        parent.document.getElementById("sumInstanceId").innerHTML = "<%=WE.ExecutionId.ToString() %>";
        parent.document.getElementById("sumInstanceId").innerHTML = "<%=WE.ExecutionId.ToString() %>";
        parent.document.getElementById("sumStatusImage").src = parent.ImagesLocation + "workflow-<%= WE.InternalStatus.ToLower().Trim()%>.png";
        parent.SetControlButtonsState("<%=WE.InternalStatus %>");
    </script>
    <META http-equiv="Page-Exit"CONTENT="progid:DXImageTransform.Microsoft.Fade(duration=0.5,overlap=1.0) " />
</head>
<body style="background-color:white; padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px; border-style: none;">
    <form id="form1" runat="server">
	<%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <div style="padding-top:2%">
        <asp:PlaceHolder ID="mapplaceholder" runat="server"></asp:PlaceHolder>
        <img src="openimage.aspx<%:this.Page.Request.Url.Query%>&imageCollUniqueId=<%:uniqueId %>" usemap="#map1" border="0" /> 
    </div>
    </form>
</body>
</html>
