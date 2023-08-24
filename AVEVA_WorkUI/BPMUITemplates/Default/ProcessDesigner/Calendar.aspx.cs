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
using Telerik.Web.UI;
using Workflow.NET.Web.Designer;
using Workflow.NET;
using Workflow.NET.PropertyTypes;
using Workflow.NET.Web.Designer.PropertyPages;
public partial class SkeltaTemplates_Default_ProcessDesigner_Calendar : System.Web.UI.Page
{

    protected ProcessDesigner ProcessDesignerControl;
    public Skelta.HWS.Calendar.CalendarCollection calColl;
    protected ProcessDesignerAdapter pda;
    protected Property _SelProperty = null;
    protected string _Text = "";
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
    private string nodeval;
    private string _Nodeval;//_Nodeval
    protected string _Findnode;//_Findnode
    protected string ErrMsg = "";
    protected string _GuIdValue;
    protected string _CalendarName;
    protected string sWorkflow = "";
    protected string nodvalue = "";
    protected string _PropertyDisplayName = "";
    protected string themePath;

     protected void Page_Load(object sender, EventArgs e)
    {
        this.themePath = Workflow.NET.TemplateExpressionBuilder.GetUrl(string.Empty).ToString();
         if(!Page.IsPostBack)
         {

                       
             
             _Actionname =AntiXssEncoder.HtmlEncode(this.Context.Request["actionname"]);
            _Propertyname =AntiXssEncoder.HtmlEncode(this.Context.Request["selpropertyname"]);
            _fileName =AntiXssEncoder.HtmlEncode(this.Context.Request["CalendarName"]);
            _applicationName =AntiXssEncoder.HtmlEncode(Request.QueryString["ApplicationName"]);
            _workflowName =AntiXssEncoder.HtmlEncode(Request.QueryString["WorkflowName"]);
            //_fileName = Request.QueryString["FileName"];
             //added to check localization
            if (this.Context.Request["DisableResourceSettings"].ToLower() == "true")
                ChkRsrcCalendar.Visible = false;
          
             pda = new ProcessDesignerAdapter();
            pda.LoadControlInstance(false);
            
            ProcessDesignerControl = pda.ProcessDesignerControl;
            ChkRsrcCalendar.Text = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Use Resource calendar if available");
            _ApplicationName = ProcessDesignerControl.ApplicationName;
            btnNoClndr.Text = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("No Calendar");
            btnSetClndr.Text = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Set Calendar");
            sWorkflow = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Skelta BPM.NET 2007");
            Workflow.NET.Action selAction = ProcessDesignerControl.ProcessDefinition.Actions[_Actionname];
            _SelProperty = selAction.Properties[_Propertyname];
            Workflow.NET.PropertyTypes.PropertyCalendar pr = (Workflow.NET.PropertyTypes.PropertyCalendar)_SelProperty.PropertyHandler;

            Property pActionDefinition = ((ActionBase)ProcessDesignerControl.ActionsDefinition.Actions[selAction.ActionType]).Properties[_SelProperty.Name] as Property;
            string winParams = "height = " + pActionDefinition.HelpTemplateWinHeight + ", width = " + pActionDefinition.HelpTemplateWinWidth + ",scrollbars=yes,resizable=yes";
            string propertyhelp = " title=\"" + pActionDefinition.HelpString + "\" onclick=\"javascript:OpenHelpWin('" + ProcessDesignerControl.GetHelpPageUrl() + pActionDefinition.HelpTemplate + "','" + winParams + "')\"";
            _JScriptPath = ProcessDesignerControl.GetJscriptUrl("javascript\\PropertyPages.js");
            _Helpimagetags = propertyhelp;
            _Nodeval = pr.Value;
            //_Propertyname = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString(_Propertyname);
             if (_Nodeval == "")
                _Nodeval = GetCookieValue(); 
            this.RadTree1.NodeExpand += new RadTreeViewEventHandler(this.RadTree1_NodeExpand);
            LoadRootNodes();
        
        }
        else
        {
            _Actionname =AntiXssEncoder.HtmlEncode(Request["hidactionname"]);
            _Propertyname =AntiXssEncoder.HtmlEncode(Request["hidpropertyname"]);
            //_applicationName = Request["hid_applicationName"];
            //_workflowName = Request["hid_workflowName"];
            _fileName =AntiXssEncoder.HtmlEncode(Request["hid_fileName"]);
            _applicationName =AntiXssEncoder.HtmlEncode(Request["_skappname"]);
            _workflowName =AntiXssEncoder.HtmlEncode(Request["_skworkflowname"]);
            //_fileName = Request["_skfilename"];
            _Nodeval =AntiXssEncoder.HtmlEncode(Request["hid_nodeVal"]);
           
            pda = new ProcessDesignerAdapter();
            pda.LoadControlInstance(false);

            ProcessDesignerControl = pda.ProcessDesignerControl;

            ProcessDesignerControl.ApplicationName = _applicationName;
            ProcessDesignerControl.WorkflowName = _workflowName;
            ProcessDesignerControl.FileName = _fileName;
            //
            ProcessDesignerControl.InitializeValues();
            ProcessDesignerControl.ProcessDefinition.PreProcessDiagaram();

            sWorkflow = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Workflow.NET");
            btnNoClndr.Text = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("No Calendar");
            btnSetClndr.Text = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("Set Calendar");
             //
            _ApplicationName = ProcessDesignerControl.ApplicationName;
            Workflow.NET.Action selAction = ProcessDesignerControl.ProcessDefinition.Actions[_Actionname];
            _SelProperty = selAction.Properties[_Propertyname];

        
         }
         _PropertyDisplayName = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString(_Propertyname);
         
    }
    private string GetCookieValue()
    {
        string cookieValue = "";
        if (HttpContext.Current.Request.Cookies[_applicationName+_workflowName + "_nodcookie"] != null)
            cookieValue = HttpContext.Current.Request.Cookies[_applicationName+_workflowName + "_nodcookie"].Value.ToString(); ;
        return cookieValue;
    }
    private void LoadRootNodes()
    {
        //RadTree1.Nodes.Clear();
        //System.Diagnostics.Debugger.Break();
        calColl = new Skelta.HWS.Calendar.CalendarCollection(new Skelta.Core.ApplicationObject(_ApplicationName));
        string FilterExp = "and InheritedFromId =@InheritedFromId";
        Guid parentId = new Guid();

        Skelta.Core.DS.SkeltaParameter param1 = new Skelta.Core.DS.SkeltaParameter("@InheritedFromId", parentId);
        DataSet DsCalProvider = calColl.GetRecords();
        System.Guid DocId;
        //e.NodeClicked.Nodes.Clear();
        string[] _Value = new string[] { };
        if (!String.IsNullOrEmpty(_Nodeval))
        {
            _Value= _Nodeval.Split('/');
            if (_Value[0].ToString() =="yes")
            {
                nodvalue = _Value[1].ToString();
                ChkRsrcCalendar.Checked = true;
            }
            else
            {
                nodvalue = _Value[1].ToString();
                ChkRsrcCalendar.Checked = false;
            }
        }
        foreach (DataRow row in DsCalProvider.Tables[0].Rows)
        {
            if (row["InheritedFromId"].ToString() == "")
            {
                if (row["ReferenceType"].ToString() == "")
                {
                    RadTreeNode node = new RadTreeNode();
                    node.Text = row["Name"].ToString();                   
                    DocId = new System.Guid(row["Id"].ToString());
                    node.Value = DocId.ToString();
                    //node.ID = DocId.ToString();
                    if (HasChildren(DocId.ToString()))
                        node.ExpandMode = TreeNodeExpandMode.ServerSideCallBack;
                    if (node.Text == nodvalue)
                    {
                        node.Selected = true;
                        _GuIdValue = node.Value;
                    }
                    RadTree1.Nodes.Add(node);
                    AddChildNode(node);
                }
            }
        }
        if (DsCalProvider.Tables[0].Rows.Count > 0)
        {
            //RadTree1.Skin = "Square/3DBlue";
            this.RadTree1.Skin = "AWTTreeView";
        }
        else
        {
           //ErrMsg = ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("No Calendars defined");
           ClientScript.RegisterClientScriptBlock(this.GetType(), "ShowBellyBarMessage", "<script>DisplayMessage();</script>");
            RadTree1.Visible = false;
        }
    }
    private void AddChildNode(RadTreeNode parentNode)
    {
        Skelta.HWS.Calendar.CalendarCollection calColl = new Skelta.HWS.Calendar.CalendarCollection(new Skelta.Core.ApplicationObject(_ApplicationName));
        string FilterExp = "and InheritedFromId =@InheritedFromId";
        Guid parentId = new Guid(parentNode.Value);

        Skelta.Core.DS.SkeltaParameter param1 = new Skelta.Core.DS.SkeltaParameter("@InheritedFromId", parentId);
        DataSet DsCalProvider = calColl.GetMatchingRecords(FilterExp, param1);
        System.Guid DocId;

       
        
        foreach (DataRow row in DsCalProvider.Tables[0].Rows)
        {
            if (row["ReferenceType"].ToString() == "")
            {
                RadTreeNode node = new RadTreeNode();
                node.Text = row["Name"].ToString();               
                DocId = new System.Guid(row["Id"].ToString());
                node.Value = DocId.ToString();
               // node.ID = DocId.ToString();
                if (HasChildren(DocId.ToString()))
                    node.ExpandMode = TreeNodeExpandMode.ServerSideCallBack;
                if (node.Text == nodvalue)
                {
                    node.Selected = true;
                    _GuIdValue = node.Value;
                }
                parentNode.Nodes.Add(node);
                AddChildNode(node);
            }
        }
        parentNode.Expanded = true;
    }
    

    private void RadTree1_NodeExpand(object o, RadTreeNodeEventArgs e)
    {
        Skelta.HWS.Calendar.CalendarCollection calColl = new Skelta.HWS.Calendar.CalendarCollection(new Skelta.Core.ApplicationObject(_ApplicationName));
        string FilterExp = "and InheritedFromId =@InheritedFromId";
        Guid parentId = new Guid(e.Node.Value);

        Skelta.Core.DS.SkeltaParameter param1 = new Skelta.Core.DS.SkeltaParameter("@InheritedFromId", parentId);
        DataSet DsCalProvider = calColl.GetMatchingRecords(FilterExp, param1);
        System.Guid DocId;

        e.Node.Nodes.Clear();
        foreach (DataRow row in DsCalProvider.Tables[0].Rows)
        {
            if (row["ReferenceType"].ToString() == "")
            {
                RadTreeNode node = new RadTreeNode();
                node.Text = row["Name"].ToString();              
                DocId = new System.Guid(row["Id"].ToString());
                node.Value = DocId.ToString();
                //node.ID = DocId.ToString();
                if (node.Text == nodvalue)
                {
                    node.Selected = true;

                }
                if (HasChildren(DocId.ToString()))
                    node.ExpandMode = TreeNodeExpandMode.ServerSideCallBack;
                e.Node.Nodes.Add(node);
            }
        }
        
        
    }

    

    private bool HasChildren(string calGuid)
    {
        Skelta.HWS.Calendar.CalendarCollection calColl = new Skelta.HWS.Calendar.CalendarCollection(new Skelta.Core.ApplicationObject(_ApplicationName));
        string FilterExp = "and InheritedFromId =@InheritedFromId";
        Guid parentId = new Guid(calGuid);

        Skelta.Core.DS.SkeltaParameter param1 = new Skelta.Core.DS.SkeltaParameter("@InheritedFromId", parentId);
        DataSet DsCalProvider = calColl.GetMatchingRecords(FilterExp, param1);
        if (DsCalProvider.Tables[0].Rows.Count > 0)
        {
            return true;
        }
        else

            return false;
    }


    protected void btnSetClndr_Click(object sender, EventArgs e)
    {
        Workflow.NET.PropertyTypes.PropertyCalendar pr = (Workflow.NET.PropertyTypes.PropertyCalendar)_SelProperty.PropertyHandler;
		pr.Value = "";
            if (RadTree1.SelectedNode != null)
            {
                _CalendarName = RadTree1.SelectedNode.Text;
                _GuIdValue = RadTree1.SelectedNode.Value;
                pr.Value = _CalendarName + "/" + _GuIdValue;
            }
          
        if (ChkRsrcCalendar.Checked)
        {
            pr.Value = "yes" + "/" + pr.Value;

        }
        else
        {
            pr.Value = "no" + "/" + pr.Value;
        }
        
        
        ((Workflow.NET.Interfaces.IPropertyExpression)(_SelProperty.PropertyHandler)).IsExpression = false;
        ProcessDesignerControl.WriteFile();
        HttpCookie _objcookie = new HttpCookie(_applicationName+_workflowName+ "_nodcookie", pr.Value);
        _objcookie.HttpOnly = true;
        if (HttpContext.Current.Request.IsSecureConnection)
        {
            _objcookie.Secure = true;
        }

        Response.Cookies.Set(_objcookie);
        Response.Write("<script language='javascript'> window.opener.parent._skProcessDesigner.RefreshProperties();window.setTimeout('window.close()',100); </script>");
    }




    protected void btnNoClndr_Click(object sender, EventArgs e)
    {
        Workflow.NET.PropertyTypes.PropertyCalendar pr = (Workflow.NET.PropertyTypes.PropertyCalendar)_SelProperty.PropertyHandler;
        pr.Value = "";
        ((Workflow.NET.Interfaces.IPropertyExpression)(_SelProperty.PropertyHandler)).IsExpression = false;
        ProcessDesignerControl.WriteFile();
        HttpCookie _objcookie = new HttpCookie(_applicationName + _workflowName + "_nodcookie", null);
        _objcookie.HttpOnly = true;
        if (HttpContext.Current.Request.IsSecureConnection)
        {
            _objcookie.Secure = true;
        }

        Response.Cookies.Set(_objcookie);
        Response.Write("<script language='javascript'> window.setTimeout('window.opener.refreshselectedaction()',100);window.opener.top._skProcessDesigner.RefreshProperties();window.setTimeout('window.close()',100); </script>");
    
    }
   
}





