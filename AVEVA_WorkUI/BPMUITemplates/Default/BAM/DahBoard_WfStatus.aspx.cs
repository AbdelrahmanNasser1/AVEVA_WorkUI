using System;
using System.Data;
using System.Text;
using System.Drawing;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using RepositorySecurityCommonFunctions = Skelta.Repository.Security.CommonFunctions;


public partial class BPMUITemplates_Default_BAM_TempStatus : System.Web.UI.Page
{
    protected int Height;
    protected int Width;
    protected string IR;
    protected string CKey;

    protected void Page_Load(object sender, EventArgs e)
    {
        RepositorySecurityCommonFunctions.ValidateRequestFullQueryString(Request.QueryString);
        if (!int.TryParse(Request.QueryString["Height"], out Height))
        {
            Height = 0;
            Workflow.NET.Log logger = new Workflow.NET.Log();
            logger.LogError(null, "Error reading query string. Expects integer value. Key:Height Value:(" + Request.QueryString["Height"] + ") on DashBoard_WfStatus.");
            logger.Close();
        }
        if (!int.TryParse(Request.QueryString["Width"], out Width))
        {
            Width = 0;
            Workflow.NET.Log logger = new Workflow.NET.Log();
            logger.LogError(null, "Error reading query string. Key:Width Value:(" + Request.QueryString["Width"] + ") on DashBoard_WfStatus.");
            logger.Close();
        }

        int ir;
        if (string.IsNullOrEmpty(Request.QueryString["IR"]) || int.TryParse(Request.QueryString["IR"], out ir))
        {
            IR = Request.QueryString["IR"];
        }
        else
        {
            Workflow.NET.Log logger = new Workflow.NET.Log();
            logger.LogError(null, "Error reading query string. Key:IR Value:(" + Request.QueryString["IR"] + ") on DashBoard_WfStatus.");
            logger.Close();
        }

        if (System.Text.RegularExpressions.Regex.Match(Request.QueryString["ckey"], "^[a-zA-Z0-9_]+$").Success)
        {
            CKey = Request.QueryString["ckey"];
        }
        else
        {
            Workflow.NET.Log logger = new Workflow.NET.Log();
            logger.LogError(null, "Error reading query string. Key:ckey Value:(" + Request.QueryString["ckey"] + ") on DashBoard_WfStatus.");
            logger.Close();
        }
    }
}
