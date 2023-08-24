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
using System.Diagnostics;
using Workflow.NET;
using Skelta.Entity;

public partial class BPMUITemplates_Default_Common_CustomErrors : System.Web.UI.Page
{
    protected string _Error = "";
    protected string errorText = "Error!";
    protected string bellyBarPath, cssPath;
    protected SkeltaResourceSetManager resManager = new SkeltaResourceSetManager();
    protected string messageDialogClose;
    protected string messageDialogOk;
    protected string messageDialogCancel;
    protected string messageDialogShowDetails;
    protected string messageDialogHideDetails;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            // When skucontextinfo2 cookie is modified, it was throwing an exception which was showing the stack trace.
            showDivmsg.Visible = false;
            lblErr.Text = "An error has occurred. See the Work Tasks log file or contact the system administrator for more details.";
            messageDialogClose = resManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption");
            messageDialogOk = resManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption");
            messageDialogCancel = resManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption");
            messageDialogShowDetails = resManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption");
            messageDialogHideDetails = resManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption");
            cssPath = Convert.ToString(Workflow.NET.TemplateExpressionBuilder.GetUrl(""));
            bellyBarPath = Workflow.NET.CommonFunctions.GetJSReferencePath();
            var uContext = new UserContext();

            errorText = resManager.GlobalResourceSet.GetString("Err_CustomErrorMsgHeading");
            if (Application["errormsg"] != null)
            {
                showDivmsg.Visible = false;

                if (Application["httprequestvalidationmessage"] != null)
                {
                    lblErr.Text = ReplaceValidationMessage(Application["err"].ToString());
                }
                else
                {

                    lblErr.Text = resManager.GlobalResourceSet.GetString("Err_CustomErrorMsg");
                }

                Log log = new Log();
                log.LogWarning(Application["errormsg"].ToString());
                log.LogWarning(Application["err"].ToString());

            }
            else if (Application["userloggedOff"] != null)
            {
                lblErr.Text = resManager.GlobalResourceSet.GetString("ec_logoutuser");
                Application.Remove("userloggedOff");
            }
            else if(string.IsNullOrEmpty(uContext.LoggedInUserId) == true)
            {
                lblErr.Text = resManager.GlobalResourceSet.GetString("Err_InvalidUserSession");
            }                 
        }
        catch { }        
    }

    private string ReplaceValidationMessage(string errorMessage)
    {
        int firstStringPosition = errorMessage.IndexOf("(");
        int secondStringPosition = errorMessage.IndexOf("=");
        string fieldName = errorMessage.Substring(firstStringPosition + 1, secondStringPosition - firstStringPosition - 1);

        return System.Web.HttpUtility.HtmlEncode(errorMessage.Replace("(", " ").Replace(")", "").Replace("Request.Form", "").Replace("from the client", "from the field").Replace("=",", value=").Replace(fieldName, ""));
        
    }
}
