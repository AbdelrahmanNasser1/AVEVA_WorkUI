<%@ Assembly Name="Workflow.NET.NET2" %>
<%@ Assembly Name="Workflow.NET.Web.Designer.NET2" %>
<%@ Import namespace="Workflow.NET.Web.Designer" %>
<%@ Import namespace="Workflow.NET" %>
<%@ Control Language="c#" AutoEventWireup="false" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" inherits="Workflow.NET.Web.Designer.ToolboxUserControl" %>


<script type="text/javascript" src="<%=ProcessDesignerControl.GetJscriptUrl("javascript/DiagramDD.js")%>"></script>

<table height="100%" width="100%" cellspacing=0 cellpadding=0 class="sktoolboxwindow" unselectable="on">
<tr height="20px" ><td>
<DIV unselectable="on" class=sktoolboxtitle id=sk_toolbox_title style="WIDTH: 100%;"><TABLE id=skpop_properties_table cellSpacing=0 cellPadding=0 unselectable="on">
<TR>
<TD id=sk_toolbox_titletext width="100%" windowname="properties" style="vertical-align:bottom;"><SPAN class="sktoolboxtitlefont" id=skpop_properties_titlespan><%=GlobalRS.GetString("Skelta Actions")%></SPAN></TD>
<TD width=19><IMG id=skpop_properties_closebutton src="<%=ProcessDesignerControl.GetTemplateRelativeUrl("graphics/popupclose.gif")%>" onclick="ToggleToolBox()"></TD></TR></TABLE></DIV>
</td></tr>
<tr height=2px><td></td>
<tr height="20px"><td align=center>
<SELECT id="_skpdcategorybox" class="sk_toolbox_category" style="width: <%=(ToolboxControl.Width)%>" onchange="_skpdShowCategory(this);">
<% 
foreach( Category c in ToolboxControl.Categories)
{
%>
<OPTION value="<%=c.Name%>"><%=GlobalRS.GetString(c.DisplayName)%></OPTION>
<%
}
%>
</SELECT>
</td></tr>
<tr height=2px><td></td></tr>
<tr height="100%" ><td>
<div id="_skpdactionsdisplay" style = "overflow: auto; width: 100%; height: 100%" class="sk_toolbox_body">
<% 
    int ActionsInRow = 1;
    string PWidth = "100%";
	foreach( Category c in ToolboxControl.Categories)
    {
        int RowCount = 0;
        int ColCount = 0;		
		%>
		<div id="_skpdcategory<%=c.Name%>" style="display: none">
		    <table cellpadding=2 cellspacing=0 width="100%">
			<%
				int intCounter=1;
				foreach( ActionBase ab in c.Actions )
				{
                    if( ColCount == 0 )
                    {
				    %>
				        <tr><td width="<%=PWidth %>">
				    <%}
                    if( ActionsInRow == 2 && ColCount == 1 )
                    {
                    %>
				        <td  width="<%=PWidth %>">
				    <%} %>
				        <div  align="center"   id="_skpdcategory<%=intCounter%><%=c.Name%>" style="font-family: Arial; font-size: 9px;color: black;border:1;-moz-user-select:none;" unselectable="on">
							<%if(this.Context.Request.Browser.Browser.ToLower()=="ie") {%>							
							<div title="<%=GlobalRS.GetString(ab.Description)%>"  style="background-image: url(<%=ProcessDesignerControl.GetActionImageUrl(ab.ActionImageResourceName)%>); width: 40px; height: 40px;" <%=ToolboxControl.GetActionAttributes(ab)%> unselectable="on"></div>
							<%
							}
							else 
							{%>
							<div  title="<%=GlobalRS.GetString(ab.Description)%>"   style="background-image: url(<%=ProcessDesignerControl.GetActionImageUrl(ab.ActionImageResourceName)%>); width: 40px; height: 40px; -moz-user-focus:ignore;-moz-user-input:disabled;-moz-user-select:none;" <%=ToolboxControl.GetActionAttributes(ab)%> unselectable="on"></div>
							<%}%>
							
						    <div unselectable="on" class="sk_toolbox_action_title"  style="-moz-user-select:none;"  align="center" id="_skp<%=intCounter%><%=c.Name%>"><%=GlobalRS.GetString(ab.DisplayName)%></div>
				        </div>
				        </td>
				    <% ColCount++;
                        if( ColCount > (ActionsInRow-1) )
                        {
                         %>
                         </tr><tr height=10px><td></td></tr>
                         <%   
                            ColCount=0;
                            RowCount++;
                        }
                     %>
												
				<%
				intCounter=intCounter+1;
				}

                if (ColCount == 1) 
                {
        	%>  <td width="50%"></td></tr>
        	<%  }%>
				</table>
			</div>
		
<%
}
%>

</div>

</td></tr>
</table>
<script>
var _skpdcurVisibleCategory = document.getElementById("_skpdcategorybox").options[0].value;
_skpdShowDiv(_skpdcurVisibleCategory);

function _skpdResizeToolbox(w,h)
{
 
	document.getElementById("_skpdcategorybox").style.width = w +'px';	 
	document.getElementById("_skpdactionsdisplay").style.height = (h > 44) ? h - 44 + 'px' : 0 + 'px';

	
}



function _skpdShowCategory(selobj)
{
    
	var selCat=selobj.options[selobj.selectedIndex].value;
	var lsUrl = "<%= Microsoft.Security.Application.Encoder.JavaScriptEncode(this.Request.QueryString.ToString(), false) %>";
	var ApplicationName = "<%= ProcessDesignerControl.ApplicationName %>";
	var WorkflowName = "<%= ProcessDesignerControl.WorkflowName %>";
    var versionStamp = "<%= ProcessDesignerControl.FileName %>";
  
	_skpdShowDiv(selCat);
}

function closeRad()
{ 
parent._skRadWindow = false;
}

function _skpdShowDiv(catName)
{
	_skpdHideDiv(_skpdcurVisibleCategory);
	
	var d = document.getElementById("_skpdcategory"+catName);
	d.style.display = "block";
	_skpdcurVisibleCategory = catName;
}

function _skpdHideDiv(catName)
{
	var d = document.getElementById("_skpdcategory"+catName);
	d.style.display = "none";
}


</script>
