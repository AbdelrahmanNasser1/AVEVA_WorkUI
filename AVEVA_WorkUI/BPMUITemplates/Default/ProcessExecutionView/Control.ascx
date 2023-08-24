<%@ Assembly Name="Workflow.NET.Web.Report.NET2" %>
<%@ Import namespace="Workflow.NET.Web.Report" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Control.ascx.cs" Inherits="SkeltaTemplates_Default_ExecutionView_Control" %>
<script runat=server>
    WorkflowExecutionReport _BaseControl;

    override protected void OnLoad(EventArgs e)
    {
        base.OnLoad(e);
        _BaseControl = ((WorkflowExecutionReport)this.Parent);
    }
</script>
<iframe id="<%=_BaseControl.GetUniqueIdForControl("wer1")%>" src="<%=_BaseControl.GetPageUrl("ExecutionView.aspx")%>" width="100%" height="100%" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px; border: solid 1px;" scrolling="no" ></iframe> 
