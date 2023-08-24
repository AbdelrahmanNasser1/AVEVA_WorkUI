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
using Workflow.NET;
using Skelta.Repository.Security;
using System.Web.Helpers;

public partial class BPMUITemplates_Default_Repository_Site_CreateDListFormEditConfirm : System.Web.UI.Page
{
    protected string _listParams="";
    protected string _formItemId="";
    protected string _formEdit = "";

    protected string themePath = "";
    protected string PageTitle = "";
    protected string SavedListChangesText = "";
    protected string EditFormText = "";
    
    protected SkeltaResourceSetManager _ResManager = new SkeltaResourceSetManager();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Skelta.Repository.Security.CommonFunctions.IsControlValuesValid(Page.Controls) == false)
        {
            throw new XssSecurityException();
        }
		
		if (IsPostBack)
        {
            AntiForgery.Validate();
        }
			
        PageTitle = _ResManager.GlobalResourceSet.GetString("FormDynamicListCreateDListConfirmPageTitle");
        btnYes.Value = _ResManager.GlobalResourceSet.GetString("FormCrtDListConfirmButtonOkText");
        //btnNo.Value = _ResManager.GlobalResourceSet.GetString("FormDynamicListCreateDListConfirmButtonNo");
        EditFormText = _ResManager.GlobalResourceSet.GetString("FormDynamicListCreateDListConfirmEditFormText");
        SavedListChangesText = _ResManager.GlobalResourceSet.GetString("FormDListCreatedSuccess");
        _listParams = AntiXssEncoder.HtmlEncode(Request["listParams"]);
        _formItemId = AntiXssEncoder.HtmlEncode(Request["formItemId"]);
        _formEdit = AntiXssEncoder.HtmlEncode(Request["formEdit"]);
        themePath = Workflow.NET.TemplateExpressionBuilder.GetUrl("").ToString();
    }
}
