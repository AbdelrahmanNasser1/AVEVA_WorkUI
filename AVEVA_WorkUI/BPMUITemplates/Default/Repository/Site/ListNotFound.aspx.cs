using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using AntiXssEncoder = Microsoft.Security.Application.Encoder;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Skelta.Forms.Web;
using Workflow.NET;

public partial class BPMUITemplates_Default_Repository_Site_CreateDListTableHelp : System.Web.UI.Page
{
    protected string ThemePath = "";
    protected Workflow.NET.SkeltaResourceSetManager resManager = new Workflow.NET.SkeltaResourceSetManager();
    protected string ListNotFoundTitle = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        ThemePath = Workflow.NET.TemplateExpressionBuilder.GetUrl("").ToString();
        ListNotFoundTitle = AntiXssEncoder.HtmlEncode(Request["ListName"]);
    }
}
