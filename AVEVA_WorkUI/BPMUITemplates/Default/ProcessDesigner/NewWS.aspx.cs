using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using AntiXssEncoder = Microsoft.Security.Application.Encoder;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Workflow.NET.ActionHandler.InvokeWebServices;
using Workflow.NET.Web.Designer;

public partial class NewWS : System.Web.UI.Page
{
    protected string pApplicationName = "";
    protected string pWorkflowName = "";
    protected string pFileName = "";
    protected string pActionName = "";
    protected string pPropertyName = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        GetLocaleStrings();
        pApplicationName = AntiXssEncoder.HtmlEncode(Request.QueryString["ApplicationName"]);
        pWorkflowName = AntiXssEncoder.HtmlEncode(Request.QueryString["WorkflowName"]);
        pFileName = AntiXssEncoder.HtmlEncode(Request.QueryString["FileName"]);
        pActionName = AntiXssEncoder.HtmlEncode(Request.QueryString["actionname"]);
        pPropertyName = AntiXssEncoder.HtmlEncode(Request.QueryString["propertyName"]);
        
        lblError.Text = "";
        lblError.Visible = false;
        if (!Page.IsPostBack)
            ShowWebServiceForEdit();
    }

#region Localization Strings
    protected string l_WSApplicationName = "";
    protected string l_WSTitle = "";
    protected string l_WSWorkflowName = "";
    protected string l_WSFileName = "";
    protected string l_WSActionName = "";
    protected string l_WSPropertyName = "";
    
    protected string l_WSName = "";
    protected string l_WSURL = "";

    protected string l_WSAuthenticated = "";
    protected string l_WSLoginName = "";
    protected string l_WSPassword = "";
    protected string l_WSDomain = "";

    protected string l_WSCancel = "";
    protected string l_WSSaveWS = "";
    
    

    private void GetLocaleStrings()
    {
        Workflow.NET.SkeltaResourceSetManager resourceManager = new Workflow.NET.SkeltaResourceSetManager();
        l_WSTitle = resourceManager.GlobalResourceSet.GetString("WS_Web Services");
        l_WSApplicationName = resourceManager.GlobalResourceSet.GetString("WS_Application Name");
        l_WSWorkflowName = resourceManager.GlobalResourceSet.GetString("WS_Workflow Name");
        l_WSFileName = resourceManager.GlobalResourceSet.GetString("WS_File Name");
        l_WSActionName = resourceManager.GlobalResourceSet.GetString("WS_Action Name");
        l_WSPropertyName = resourceManager.GlobalResourceSet.GetString("WS_Property Name");



        l_WSName = resourceManager.GlobalResourceSet.GetString("WS_WebService Name");
        l_WSURL = resourceManager.GlobalResourceSet.GetString("WS_WebService URL");

        l_WSAuthenticated = resourceManager.GlobalResourceSet.GetString("WS_Authenticated");
        l_WSLoginName = resourceManager.GlobalResourceSet.GetString("WS_Login Name");
        l_WSPassword = resourceManager.GlobalResourceSet.GetString("WS_Password");
        l_WSDomain = resourceManager.GlobalResourceSet.GetString("WS_Domain Name");

        l_WSCancel = resourceManager.GlobalResourceSet.GetString("WS_Cancel");
        l_WSSaveWS = resourceManager.GlobalResourceSet.GetString("WS_Save Web Service");

        btnCancel.Text = l_WSCancel;
        cmdAddWebService.Text = l_WSSaveWS;
    }
#endregion

    protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
    {

    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        lblError.Text = "";
        lblError.Visible = false;
        WebServiceClient WSClient = new WebServiceClient();

        WSClient.UserName = txtUser.Text;
        WSClient.Password = txtPWd.Text;
        WSClient.DomainName = txtDomain.Text;
        
        //string ApplicationName = "Skelta3";
        //string WorkflowName = "Default";
        string ApplicationName = Request.QueryString["ApplicationName"];
        string WorkflowName = Request.QueryString["WorkflowName"];
        string ServiceURL = txtWSDLURL.Text;
        string ServiceName = txtWSName.Text;
        string UserName = txtUser.Text;
        string Password = txtPWd.Text;
        string DomainName = txtDomain.Text;

        //if(ServiceObj.SaveFileToDB(ServiceURL, ApplicationName, WorkflowName,_pServiceName,_pServiceURL,_pUserName,_pPassword,_pDomainName ))
        Guid WSId = Guid.Empty;
        try
        {
            if (Request.QueryString["ServiceId"] == "")
                WSId = WSClient.SaveToDB(ServiceURL, ApplicationName, WorkflowName, WebServiceClient.WS_NAMESPACE, ServiceName, ServiceURL, UserName, Password, DomainName);
            else
                WSId = WSClient.SaveToDB(new Guid(Request.QueryString["ServiceId"]), ServiceURL, ApplicationName, WorkflowName, WebServiceClient.WS_NAMESPACE, ServiceName, ServiceURL, UserName, Password, DomainName);
        }
        catch (Exception ex)
        {
            lblError.Text = "Error in adding web service. Please check the WSDL URL(Usage Example: ...\\Service1.asmx?wsdl). Error:" + ex.Message;
            lblError.Visible = true;
            return;
        }
        if (WSId != Guid.Empty)
        {
            lblError.Text = "";
            lblError.Visible = false;
            BackToList();
        }
        else
        {
            lblError.Text = "Error in adding web service. Please check the WSDL URL.(Usage Example: ...\\Service1.asmx?wsdl)";
            lblError.Visible = true;
        }
    }

    private void BackToList()
    {
        string actionname = this.Context.Request["actionname"];
        string propertyname = this.Context.Request["propertyName"];
        string qryString = "?actionname=" + actionname + "&propertyname=" + propertyname;
        //string pdaQryString = "&ApplicationName=" + Request.QueryString["ApplicationName"] + "&WorkflowName=" + Request.QueryString["WorkflowName"] + "&FileName=" + Request.QueryString["FileName"] + "&TemplateName=" + Request.QueryString["TemplateName"] + "&Cul=" + Request.QueryString["Cul"];
        ProcessDesignerAdapter pda = new ProcessDesignerAdapter();
        pda.LoadControlInstance(false);
        string pdaQryString = pda.GetUrlParameters(false);
        pdaQryString = "&" + pdaQryString;
        Response.Redirect("ListWebServices.aspx" + qryString + pdaQryString); 
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        BackToList();
    }

    private void ShowWebServiceForEdit()
    {
        if (Request.QueryString["ServiceId"]=="") return;
        
        string ApplicationName = Request.QueryString["ApplicationName"];
        string WorkflowName = Request.QueryString["WorkflowName"];
        Guid WSId=new Guid(Request.QueryString["ServiceId"]);
        InvokeWebService objInvWS = new InvokeWebService(new Skelta.Core.ApplicationObject(ApplicationName), WSId);
        
        
        lblError.Text = "";
        lblError.Visible = false;

        txtWSDLURL.Text = objInvWS.WebServiceURL;
        txtWSName.Text = objInvWS.WebServiceName;
        txtUser.Text = objInvWS.LoginName;
        txtPWd.Text = objInvWS.ServicePassword;
        txtDomain.Text = objInvWS.DomainName;            
        

    }

}
