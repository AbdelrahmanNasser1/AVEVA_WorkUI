using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Workflow.NET.Web.Report;



public partial class ProcessExecutionView : System.Web.UI.Page
{
    protected Workflow.NET.Web.Report.WorkflowExecutionReport wf;
    string appName = string.Empty;
    string ExecutionId = string.Empty;
 

    protected void Page_Load(object sender, EventArgs e)
    {
        wf = new Workflow.NET.Web.Report.WorkflowExecutionReport();       
        wf.Application = Request["application"].Trim().ToString();
        wf.ExecutionId = Int32.Parse(Request["executionid"].ToString());
        wf.Width=800;
        wf.Height=555;
        Panel1.Controls.Add(wf);
       }
 }
