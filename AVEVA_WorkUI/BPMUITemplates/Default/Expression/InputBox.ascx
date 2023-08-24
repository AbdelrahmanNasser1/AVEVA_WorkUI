<%@ Control Language="c#" AutoEventWireup="false" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" inherits="Workflow.NET.Template.ControlScriptIB"%>
<script runat=server>
override protected void OnLoad(EventArgs e)
{
	base.OnLoad(e);
}
</script>
<table border="0" width="100%" align="center" cellspacing=0 cellpadding=0>				
	<tr>
		<td  style="text-align:left;vertical-align:top;padding-bottom:10px;">
		      <img id="Img<%=inpBox.ID%>" src="<%=inpBox.GetTemplateRelativeUrl("graphics/Expression-icon.gif")%>" title="<%=expExpressionEditor%>" alt="<%=expExpressionEditor%>"  onclick="javscript:IPBAttachEXPControl('<%=inpBox.ID%>')" style="cursor:pointer" border=0><asp:Literal ID="literalControl1" runat="server" Visible="true"></asp:Literal> 					      
		</td>
	</tr>
</table>			

