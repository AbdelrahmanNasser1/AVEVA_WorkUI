using System;
using System.Text;
using System.Drawing;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using AntiXssEncoder = Microsoft.Security.Application.Encoder;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.OleDb;





public partial class SkeltaTemplates_Default_BAM_DashBoard_WfInstancesFrame : System.Web.UI.Page
{
    /// <summary>
    /// Store Height
    /// </summary>
    protected int Height;
    /// <summary>
    /// Store Width
    /// </summary>
    protected int Width;
    /// <summary>
    /// Store IR
    /// </summary>
    protected string IR;
    /// <summary>
    /// Store ckey
    /// </summary>
    protected string CKey;

    protected void Page_Load(object sender, EventArgs e)
    {
        Workflow.NET.Log logger = new Workflow.NET.Log();
        if (!int.TryParse(Request.QueryString["Height"], out Height))
        {
            Height = 0;
            logger.LogError(null, "Error reading query string. Expects integer value. Key:Height Value:(" + Request.QueryString["Height"] + ") on DashBoard_WfInstances.");
        }
        if (!int.TryParse(Request.QueryString["Width"], out Width))
        {
            Width = 0;
            logger.LogError(null, "Error reading query string. Key:Width Value:(" + Request.QueryString["Width"] + ") on DashBoard_WfInstances.");
        }

        int ir;
        if (string.IsNullOrEmpty(Request.QueryString["IR"]) || int.TryParse(Request.QueryString["IR"], out ir))
        {
            IR = AntiXssEncoder.HtmlEncode(Request.QueryString["IR"]);
        }
        else
        {
            logger.LogError(null, "Error reading query string. Key:IR Value:(" + Request.QueryString["IR"] + ") on DashBoard_WfInstances.");
        }

        if (System.Text.RegularExpressions.Regex.Match(Request.QueryString["ckey"], "^[a-zA-Z0-9_]+$").Success)
        {
            CKey = AntiXssEncoder.HtmlEncode(Request.QueryString["ckey"]);
        }
        else
        {
            logger.LogError(null, "Error reading query string. Key:ckey Value:(" + Request.QueryString["ckey"] + ") on DashBoard_WfInstances.");
        }
        logger.Close();
    }
}
