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
using Workflow.NET.Web.Designer;
using Workflow.NET;

public partial class SkeltaTemplates_Default_ProcessDesigner_Queue : System.Web.UI.Page
{

    protected ProcessDesigner ProcessDesignerControl;
    public Skelta.HWS.Queue.QueueCollection calquecoll;
    public Skelta.HWS.Queue.Queue calqueue;

    protected ProcessDesignerAdapter pda;
    protected Property _SelProperty = null;
    protected string _NewVal;
    protected string _TempVal;
    protected string _Actionname = "";
    protected string _Propertyname = "";
    protected string valueString = "";
    protected string filename = "";
    protected string _applicationName = "";
    protected string _workflowName = "";
    protected string _fileName = "";
    protected string _JScriptPath = "";
    protected string _Helpimagetags = "";
    protected string _ApplicationName;
    protected string _Findnode;//_Findnode
    protected string ErrMsg = "";
    protected string strAssign = "";
    protected string strClose = "";
    protected string PropertyDisplayName = "";
	protected string PageTitle = "";


    protected void Page_Load(object sender, EventArgs e)
    {


        _Actionname = AntiXssEncoder.HtmlEncode(this.Context.Request["actionname"]);
        _Propertyname = AntiXssEncoder.HtmlEncode(this.Context.Request["selpropertyname"]);
        _fileName = this.Context.Request["QueueFilename"];


        _applicationName = Request.QueryString["ApplicationName"];
        _workflowName = Request.QueryString["WorkflowName"];
        //_fileName = Request.QueryString["FileName"];

        pda = new ProcessDesignerAdapter();
        pda.LoadControlInstance(false);

        ProcessDesignerControl = pda.ProcessDesignerControl;

		PageTitle = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Skelta BPM.NET 2007");
        lblQueueAvlbl.Text = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Available Queues");
        lblQueueSlctd.Text = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Selected Queues");
        PropertyDisplayName = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString(_Propertyname);
        strAssign = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Assign");
        strClose = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Close");
        //_Propertyname = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString(_Propertyname);
        _ApplicationName = ProcessDesignerControl.ApplicationName;

        Workflow.NET.Action selAction = ProcessDesignerControl.ProcessDefinition.Actions[_Actionname];
        _SelProperty = selAction.Properties[_Propertyname];
        Workflow.NET.PropertyTypes.PropertyQueue pr = (Workflow.NET.PropertyTypes.PropertyQueue)_SelProperty.PropertyHandler;

        Property pActionDefinition = ((ActionBase)ProcessDesignerControl.ActionsDefinition.Actions[selAction.ActionType]).Properties[_SelProperty.Name] as Property;
        string winParams = "height = " + pActionDefinition.HelpTemplateWinHeight + ", width = " + pActionDefinition.HelpTemplateWinWidth + ",scrollbars=yes,resizable=yes";
        string propertyhelp = " title=\"" + pActionDefinition.HelpString + "\" onclick=\"javascript:OpenHelpWin('" + ProcessDesignerControl.GetHelpPageUrl() + pActionDefinition.HelpTemplate + "','" + winParams + "')\"";
        _JScriptPath = ProcessDesignerControl.GetJscriptUrl("javascript\\PropertyPages.js");
        _Helpimagetags = propertyhelp;
        if (!Page.IsPostBack)
        {
            LoadItem();
        }
        else
        {
            btnUpdate_Click();
        }
    }

    protected void LoadItem()
    {
        Workflow.NET.PropertyTypes.PropertyQueue pr = (Workflow.NET.PropertyTypes.PropertyQueue)_SelProperty.PropertyHandler;
        string[] ar = new string[] { };
        if (!String.IsNullOrEmpty(pr.Value))
        {
            ar = pr.Value.Split('/');
        }
      
        int a = ar.Length;
        calquecoll = new Skelta.HWS.Queue.QueueCollection(new Skelta.Core.ApplicationObject(_ApplicationName));
        DataSet DsQueueProvider = calquecoll.GetRecords();

        foreach (DataRow row in DsQueueProvider.Tables[0].Rows)
        {
            LstQueue.Items.Add(row["Name"].ToString());

        }

        if (ar.Length > 0)
        {
            for (int i = 0; i < ar.Length; i++)
            {
                LstQueue.Items.Remove(ar[i].ToString());

            }

            LstSelQueue.DataSource = ar;
            LstSelQueue.DataBind();
        }


    }

    protected void btnUpdate_Click()
    {
          
        Workflow.NET.PropertyTypes.PropertyQueue pr = (Workflow.NET.PropertyTypes.PropertyQueue)_SelProperty.PropertyHandler;
        
        string _retriveString = Request["hidInput"];
        string _QueueName = "";
        string _QueueId = "";
        string[] _arName = new string[] { };
        if (!String.IsNullOrEmpty(_retriveString))
        {
            _arName = _retriveString.Split('/');
        }
        int _arLength = _arName.Length;
        if (_arLength > 0)
        {
            ArrayList arr = new ArrayList(_arLength);
            for (int i = 0; i < _arLength; i++)
            {
                _QueueName = _arName[i];

                calqueue = new Skelta.HWS.Queue.Queue(new Skelta.Core.ApplicationObject(_ApplicationName), _QueueName);
                _QueueId = calqueue.Id.ToString();

                if (String.IsNullOrEmpty(_NewVal))
                {
                    _NewVal = _QueueId;
                }
                else
                {
                    _NewVal = _NewVal + ";" + _QueueId;
                }
                
            }
            pr.ValueID = _NewVal;

        }
       
            
        pr.Value = Request["hidInput"];
        ((Workflow.NET.Interfaces.IPropertyExpression)(_SelProperty.PropertyHandler)).IsExpression = false;
        ProcessDesignerControl.WriteFile();
        //Response.Write("<script language='javascript'>window.setTimeout('window.opener.refreshselectedaction()',100);window.opener.parent._skProcessDesigner.RefreshProperties();window.setTimeout('window.close()',100); </script>");
        this.ClientScript.RegisterClientScriptBlock(this.GetType(), "refrParent", "RefreshParentPage();", true);
    }

}
