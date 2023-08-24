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
using Skelta.Repository.Web.List;
using Skelta.Repository.Security;
using Skelta.Repository.List.EventProvider;
using Skelta.Repository.List.Action;

public partial class BPMUITemplates_Default_Repository_Site_DeleteGridView : System.Web.UI.Page
{
    protected string lcsuri = string.Empty;
    private Skelta.Repository.List.ListItem _ItemForDelete = null;
    private Skelta.Repository.List.ListDefinition _ListViewDefinition = null;
    string _LoggedInUser = "";
    ListPageParameters listPageParameters = null;
    protected string deleteTitle = string.Empty;
    protected string closeButtonText = string.Empty;
    private string delSuccessText = string.Empty;
    private string delFailureText = string.Empty;
    protected string delConfirmText = string.Empty;
    protected string delUserViewtext = string.Empty;  
    protected string Yes = string.Empty;
    protected string No = string.Empty;
    SecurityRightsHandler SecurityHandler = null;
    ListAction action = null;
    protected string cssPath = "";
    protected string JSPath = string.Empty;
    protected object cssUrl = Workflow.NET.TemplateExpressionBuilder.GetUrl("Common/StyleSheet");
    protected Workflow.NET.SkeltaResourceSetManager resManager;
    protected void Page_Load(object sender, EventArgs e)
    {
        Skelta.Repository.Security.CommonFunctions.ValidateRequestFullQueryString(Request.QueryString);
        cssPath = cssUrl.ToString();
        setLocalizedVariableValues();
        JSPath = Workflow.NET.CommonFunctions.GetJSReferencePath();
        //Response.Redirect("ShowAllViews.aspx");
        listPageParameters = new ListPageParameters();
        if (this.Page.Request["lcsuri"] != null)
        {
            lcsuri = this.Page.Request["lcsuri"];
            listPageParameters.ResolveCurrentUri();
        }
        _LoggedInUser = listPageParameters.LoggedInUserId;
        if (!string.IsNullOrEmpty(listPageParameters.ApplicationName) && !string.IsNullOrEmpty(listPageParameters.ListName))
        {
            _ListViewDefinition = Skelta.Repository.List.ListDefinition.GetList(new Skelta.Core.ApplicationObject(listPageParameters.ApplicationName), listPageParameters.ListName);

            if (!Guid.Equals(listPageParameters.ListItemId, Guid.Empty))
            {
                try
                {
                    //_ItemForDelete = new Skelta.Repository.List.ListItem(_ListViewDefinition, listPageParameters.ListItemId);
                    
                    Skelta.Forms.Web.Common.FormDataGridViewItem _ItemForDelete = new Skelta.Forms.Web.Common.FormDataGridViewItem(new Skelta.Core.ApplicationObject(listPageParameters.ApplicationName), listPageParameters.ListItemId);                    
                    _ItemForDelete.LoggedInUserId = _LoggedInUser;
                    if (_ItemForDelete.AdminView == true)
                    {
                        _ItemForDelete.Delete();


                        if (_ItemForDelete.LastVerifyError != "")
                        {
                            DeleteMessage.Text = _ItemForDelete.LastVerifyError;
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "alertmsg", "<script>se.ui.messageDialog.showError(\"" + resManager.GlobalResourceSet.GetString("List_item_Operation_for_list") + "\",\"" + DeleteMessage.Text + "\");closeWindow();</script>");
                        }
                        else
                        {
                            DeleteMessage.Text = delSuccessText;
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "alertmsg", "<script>se.ui.messageDialog.showAlert(\"" + resManager.GlobalResourceSet.GetString("List_item_Operation_for_list") + "\",\"" + DeleteMessage.Text + "\");closeWindow();</script>");
                        }
                    }
                     else
                    {
                        DeleteMessage.Text= delUserViewtext;
                       // DeleteMessage.CssClass = "errormsg";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "alertmsg", "<script>se.ui.messageDialog.showError(\"" + resManager.GlobalResourceSet.GetString("List_item_Operation_for_list") + "\",\"" + DeleteMessage.Text + "\");closeWindow();</script>");
                        
                    }
                }
                catch (Exception ex)
                {
                    DeleteMessage.Text = delFailureText;
                    Workflow.NET.Log logger = new Workflow.NET.Log();
                    logger.LogError(ex, delFailureText, _ListViewDefinition.Application.ApplicationName);
                    logger.Close();
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "alertmsg", "<script>se.ui.messageDialog.showError(\"" + resManager.GlobalResourceSet.GetString("List_item_Operation_for_list") + "\",\"" + DeleteMessage.Text + "\");closeWindow();</script>");
                }
            }
        }

    }

    private void setLocalizedVariableValues()
    {
         resManager = new Workflow.NET.SkeltaResourceSetManager();
        deleteTitle = resManager.GlobalResourceSet.GetString("Del_PageTitle");
        closeButtonText = resManager.GlobalResourceSet.GetString("Del_closeButton");
        delSuccessText = resManager.GlobalResourceSet.GetString("Del_success");
        delFailureText = resManager.GlobalResourceSet.GetString("Del_Failure");
        delConfirmText = resManager.GlobalResourceSet.GetString("Del_Confirm");
        Yes = resManager.GlobalResourceSet.GetString("Yes");
        No = resManager.GlobalResourceSet.GetString("No");
        delUserViewtext = resManager.GlobalResourceSet.GetString("Del_UserView");  
        CloseButton.Text = closeButtonText;
    }
}
