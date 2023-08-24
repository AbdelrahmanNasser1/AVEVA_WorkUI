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
using Skelta.Forms.Web;
using Workflow.NET;
using Skelta.Repository.Security;

public partial class BPMUITemplates_Default_Repository_Site_CreateDListTableHelp : System.Web.UI.Page
{
    protected Workflow.NET.SkeltaResourceSetManager resManager = new Workflow.NET.SkeltaResourceSetManager();
    protected void Page_Load(object sender, EventArgs e)
    {
        Skelta.Repository.Security.CommonFunctions.ValidateRequestFullQueryString(Request.QueryString);
        if (Skelta.Repository.Security.CommonFunctions.IsControlValuesValid(Page.Controls) == false)
        {
            throw new XssSecurityException();
        }
        string applicationName = Request["ApplicationName"];
        txtScript.Text = Skelta.Forms.Web.CommonFunctions.GetDLTableCreateScript(new Skelta.Core.ApplicationObject(applicationName));

    }
}
