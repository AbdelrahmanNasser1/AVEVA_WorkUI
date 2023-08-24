using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using Skelta.Core;
using Workflow.NET;

public partial class BPMUITemplates_Default_Common_ShowExceptionDetailReport : System.Web.UI.Page
{
    protected SkeltaResourceSetManager skrm = new SkeltaResourceSetManager();
    protected string themePath = "";
    protected string pageHeader = "";
    protected string ApplicationName = "";
    protected string exceptionId = "";
    protected PersistedException expObj;
    protected void Page_Load(object sender, EventArgs e)
    {
        LocalizeLabels();

        ApplicationName = Request["application"];
        string exceptionId = Request["exceptionId"];
        expObj = new PersistedException(new ApplicationObject(ApplicationName), new Guid(exceptionId));
    }

    void LocalizeLabels()
    {
        this.Title = skrm.GlobalResourceSet.GetString("ED_pageTitle");
        this.themePath = Workflow.NET.TemplateExpressionBuilder.GetUrl("").ToString();
        pageHeader = skrm.GlobalResourceSet.GetString("ED_pageHeader");
        
    }
}
