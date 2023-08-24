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
using Workflow.NET;
using Workflow.NET.Web.Designer;

public partial class SkeltaTemplates_Default_Wizards_ChildProcessDesigner : System.Web.UI.Page
{
    Workflow.NET.Web.Designer.ProcessDesigner pd = new Workflow.NET.Web.Designer.ProcessDesigner();
    protected string pageTitle = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string strTest = "";
        bool chk = false;
        string[] strAppName = Workflow.NET.Config.GetApplicationNames();
        foreach (string appName in strAppName)
        {
            if (appName == Request.QueryString["appName"].ToString())
            { 
                pd.ApplicationName = Request.QueryString["appName"];
                pd.WorkflowName = Request.QueryString["workflowname"];
                pageTitle =  pd.ApplicationName + ":"+ pd.WorkflowName;
                pd.Style.Add(HtmlTextWriterStyle.Position, "absolute");
                pd.Style.Add(HtmlTextWriterStyle.Top, "0px");
                pd.Style.Add(HtmlTextWriterStyle.Left, "0px");
                pd.Style.Add(HtmlTextWriterStyle.BorderStyle, "Thick");
                pd.Height = System.Web.UI.WebControls.Unit.Percentage(100);
                pd.Width = System.Web.UI.WebControls.Unit.Percentage(100);
                pd.ID = "Pd1";
                pnlSubProcess.Controls.Add(pd);
                chk = true;   
            }
        }

        if (chk == false)
        {
            strTest="<script language='javascript'>window.close()</script>";
            Page.ClientScript.RegisterStartupScript(this.GetType(),"Test", strTest);
        }
    }
}
