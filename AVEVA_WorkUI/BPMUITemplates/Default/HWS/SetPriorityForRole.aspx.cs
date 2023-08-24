using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Skelta.Core;
using Skelta.HWS;
using Telerik.Web.UI;
using Workflow.NET;
using Workflow.NET.Interfaces;
using Workflow.NET.Storage;

public partial class BPMUITemplates_Default_HWS_SetPriorityForRole : System.Web.UI.Page
{
    protected string cssPath = string.Empty;
    protected SkeltaResourceSet GR = new SkeltaResourceSetManager().GlobalResourceSet;
    Skelta.Core.ApplicationObject applnObject;
    string applicationName = string.Empty;
    string roleId = string.Empty;
    string roleName = string.Empty;
    string queueName = string.Empty;
    Guid queueId = Guid.Empty;
    protected string JSPath = string.Empty;
    protected string strWindowTitle = string.Empty;
    protected string strSetPriorityMessage = string.Empty;
    protected string strValidateMessage = string.Empty;
    protected string strValidateZero = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {

        cssPath = Convert.ToString(Workflow.NET.TemplateExpressionBuilder.GetUrl(""));
        JSPath = Workflow.NET.CommonFunctions.GetJSReferencePath();

        btnSetPriority.Text = GR.GetString("Wif_save");
        btnCancel.Text = GR.GetString("altActor_buttonCaption_Cancel");
        strWindowTitle = GR.GetString("Queue_RolePriority");
        strSetPriorityMessage = GR.GetString("Queue_RolePriorityMessage");
        strValidateMessage = GR.GetString("Queue_RolePriorityBlank");
        strValidateZero = GR.GetString("Queue_RolePriorityZero");

        applicationName = Request.QueryString["application"];
        roleId = Request.QueryString["roleId"];
        roleName = Request.QueryString["RoleName"];
        queueName = Request.QueryString["QueName"];

        txtRoleName.Text = roleName;
        Skelta.HWS.Queue.Queue queueObject;
        applnObject = new Skelta.Core.ApplicationObject(applicationName);
        queueObject = new Skelta.HWS.Queue.Queue(applnObject, queueName);
        queueId = queueObject.Id;

        if (!IsPostBack)
        {
            int priority = GetPriority(new Guid(roleId), queueId);
            txtPriority.Text = Convert.ToString(priority);
        }
            
    }

    /// <summary>
    /// Method for Getting the Priority based on the Role Id and Queue Id
    /// </summary>
    /// <param name="roleId">Virtual Role Id</param>
    /// <param name="queueId">Queue Id</param>
    /// <returns>Integer value</returns>
    private int GetPriority(Guid roleId,Guid queueId)
    {
        int prioritySet = 9999;
        
        string virRoleName = "";        
        VirtualRole virRoleObj = new VirtualRole(applnObject);
        virRoleName = virRoleObj.GetRealRoleName(roleId).ToString();
        
        Skelta.HWS.Queue.ParticipantCollection pnt = new Skelta.HWS.Queue.ParticipantCollection(applnObject, queueId, virRoleName, false);
        DataSet ds=pnt.GetRecords();

        foreach (DataRow dr in ds.Tables[0].Rows)
        {
            if(dr["RolePriority"] != DBNull.Value)            
                prioritySet = Convert.ToInt32(dr["RolePriority"]);
        }
        
        return prioritySet;

    }
    /// <summary>
    /// Method for setting the Priority for the Role
    /// </summary>
    /// <param name="sender">Button Sender</param>
    /// <param name="e">Event Args</param>
    protected void btnSetPriority_Click(object sender, EventArgs e)
    {
        int priority =Convert.ToInt32(txtPriority.Text);

        string virRoleName = "";
        VirtualRole virRoleObj = new VirtualRole(applnObject);
        virRoleName = virRoleObj.GetRealRoleName(new Guid(roleId)).ToString();
        
        Skelta.HWS.Queue.ParticipantCollection pnt = new Skelta.HWS.Queue.ParticipantCollection(applnObject, queueId, virRoleName, false);
        DataSet ds = pnt.GetRecords();

        using (IDataHandler dataHandler = DataHandlerFactory.GetDataHandler(new Config(applicationName)))
        {
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                string strSql = "Update SKQueueParticipants  set RolePriority=@RolePriority Where Id=@Id and VirtualRoleId=@VirtualRoleId";
                IDataParameter paramPriority = dataHandler.GetParameter("@RolePriority", priority);
                IDataParameter paramId = dataHandler.GetParameter("@Id", new Guid(dr["Id"].ToString()));
                IDataParameter paramRoleId = dataHandler.GetParameter("@VirtualRoleId", new Guid(roleId));
                dataHandler.ExecuteUpdate(strSql, paramPriority, paramId,paramRoleId);
            }           

        }

        //Page.ClientScript.RegisterClientScriptBlock(GetType(), "regJs", "<script>RefreshandClose();</script>");
        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "PickQueue", "<script>ShowBellyBarAlertMessageWithCallBack('" + strWindowTitle + "','" + strSetPriorityMessage + "');</script>");
       
    }
}