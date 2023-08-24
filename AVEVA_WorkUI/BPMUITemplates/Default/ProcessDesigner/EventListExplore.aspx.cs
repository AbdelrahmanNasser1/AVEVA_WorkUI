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
using Skelta.Entity;
using System.Diagnostics;
using Workflow.NET.Web.Designer;
using System.Text;
using Workflow.NET;
using Workflow.NET.Storage;
using Workflow.NET.DataHandler;
using Workflow.NET.Interfaces;
using Skelta.Repository.List;

public partial class EventListExplore : System.Web.UI.Page
{
    protected SkeltaResourceSetManager _ResManager = new SkeltaResourceSetManager();
    protected Skelta.Repository.Web.Lookup.ListItemLookup listItemLookup;
    UserContext usrctx = new UserContext();
    bool _ShowSelectListItem = true;
    protected Property selProperty = null;
    protected Property selProperty1 = null;
    protected Property selProperty2 = null;
    protected Property selProperty3 = null;
    protected ProcessDesigner ProcessDesignerControl;
    protected String actionname = "";
    protected String propertyname = "";
    protected String filename = "";
    protected ProcessDesignerAdapter pda;
    protected ProcessDesignerAdapter designerAdapter;
    protected String _fileName = "";
    Workflow.NET.Log logger = new Workflow.NET.Log();
    protected ProcessDesigner _designerControl;
    protected String _propertyName = "";
    public string pagetitle;
    protected String JScriptPath = "";
    protected string cssPath = string.Empty;

    protected void Page_Init(object sender, EventArgs e)
    {

        listExplorer1.ApplicationName = usrctx.Repository.ApplicationName;
        listExplorer1.AutoPostBack = true;
        listExplorer1.ListSelectionChanged += new Skelta.Repository.Web.Lookup.ListExplorer.ListSelectionChangedHandler(listExplorer1_ListSelectionChanged);
    }
    protected void Page_Load(object sender, EventArgs e)
    {

        Object TEBObject = Workflow.NET.TemplateExpressionBuilder.GetUrl("");
        cssPath = TEBObject.ToString();        

        SetUICultureText();
        _propertyName = _ResManager.GlobalResourceSet.GetString("_WorkFlowEvent_Assiciation");
        actionname = this.Context.Request["actionname"];
        propertyname = this.Context.Request["selpropertyname"];
        _fileName = this.Context.Request["wfmemoFilename"];
        pda = new ProcessDesignerAdapter();
        pda.LoadControlInstance(false);
        ProcessDesignerControl = pda.ProcessDesignerControl;
        ProcessDesignerControl.FileName = _fileName;
        ProcessDesignerControl.InitializeValues();
        ProcessDesignerControl.ProcessDefinition.PreProcessDiagaram();
       
        designerAdapter = new ProcessDesignerAdapter();
        designerAdapter.LoadControlInstance(false);
        _designerControl = designerAdapter.ProcessDesignerControl;
        
        Workflow.NET.Action selAction = ProcessDesignerControl.ProcessDefinition.Actions[actionname];
        selProperty = selAction.Properties[propertyname];

        listItemLookup = new Skelta.Repository.Web.Lookup.ListItemLookup();
        listItemLookup.ID = this.ClientID + "listItemLookup";
        listItemLookup.MinLength = 0;



        if (!Guid.Equals(Guid.Empty, listExplorer1.Value))
        {
            listItemLookup.ListName = listExplorer1.Text;
            listItemLookup.Enabled = true;
            listItemLookup.ApplicationName = usrctx.Repository.ApplicationName;
            listItemLookup.Height = 3;
            listItemLookupPanel.Controls.Add(listItemLookup);
        }
        else
        {
            //listItemLookup.Enabled = false;
        }

        trlookup.Visible = false;

        try
        {
            if (Request.QueryString["mode"].ToLower() == "list")
                _ShowSelectListItem = false;


        }
        catch { }

    }

    void listExplorer1_ListSelectionChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
       
        Workflow.NET.Action selAct = ProcessDesignerControl.ProcessDefinition.Actions[actionname];
        selProperty3 = selAct.Properties["EventScope"];
        // Workflow.NET.PropertyTypes.PropertyString pr5 = (Workflow.NET.PropertyTypes.PropertyString)selProperty3.PropertyHandler;

        listItemLookupPanel.Controls.Clear();
        if (_ShowSelectListItem)
        {
            
           // if (selProperty3.Value.ToString()   == "ListItem")
            if (selProperty3.Value.ToString().Contains("ListItem"))
            {
                trlookup.Visible = true;

                listItemLookup = new Skelta.Repository.Web.Lookup.ListItemLookup();
                listItemLookup.ID = this.ClientID + "listItemLookup";
                listItemLookup.MinLength = 0;
                if (!Guid.Equals(Guid.Empty, listExplorer1.Value))
                {
                    listItemLookup.ListName = listExplorer1.Text;
                    listItemLookup.Enabled = true;
                }
            }
            else
            {
                listItemLookup.Enabled = false;
            }
            listItemLookup.ApplicationName = usrctx.Repository.ApplicationName;
            listItemLookupPanel.Controls.Add(listItemLookup);
        }
    }
    protected void btnSelect_Click(object sender, EventArgs e)
    {

    }


    public DataTable GetListNames(string strRepository)
    {
        DataTable dbTable=null;
        try
        {
            string strQuery = string.Empty;
            strQuery = "Select Name,Id from SKEListDefinition where Application= '" + strRepository +"'";
            
            ListDefinition ld = ListDefinition.GetList(new Skelta.Core.ApplicationObject(strRepository), "Workflow");
            IDataHandler dbhandler = DataHandlerFactory.GetDataHandler(ld.Configuration); 
           
                using (dbhandler)
                {
                    dbTable = dbhandler.ReadData(strQuery, null);

                }
                
           
        
        }
        catch (Exception)
        {
        }
        return dbTable;
    
    }
    protected void OnListChange(object sender, EventArgs e)
    {

    }



    protected void btnSelect_Click1(object sender, EventArgs e)
    {


        string listitemid = "";
        string listid = "";

        if (!Guid.Equals(Guid.Empty, listExplorer1.Value))
        {
            listid = listExplorer1.Value.ToString();
        }

        try
        {
            if (listItemLookup != null)
                if (!string.IsNullOrEmpty(listItemLookup.Text))
                    listitemid = listItemLookup.Value.ToString();


            ///new code added


            Workflow.NET.PropertyTypes.PropertyListId pr = (Workflow.NET.PropertyTypes.PropertyListId)selProperty.PropertyHandler;
            
            pr.Value = listid;

            pr.ValueHTML = listid;

            ((Workflow.NET.Interfaces.IPropertyExpression)(selProperty.PropertyHandler)).IsExpression = false;
            ProcessDesignerControl.WriteFile();

            Workflow.NET.Action selAction1 = ProcessDesignerControl.ProcessDefinition.Actions[actionname];
            selProperty1 = selAction1.Properties["ListItemId"];

            Workflow.NET.PropertyTypes.PropertyString pr1 = (Workflow.NET.PropertyTypes.PropertyString)selProperty1.PropertyHandler;
            pr1.Value = listitemid;

            ((Workflow.NET.Interfaces.IPropertyExpression)(selProperty1.PropertyHandler)).IsExpression = false;
            ProcessDesignerControl.WriteFile();



        }



        catch (Exception ex)
        {
            listitemid = "";
        }
        Response.Write("<script language='javascript'> window.setTimeout('window.opener.refreshselectedaction()',100);window.opener.parent._skProcessDesigner.RefreshProperties();window.setTimeout('window.close()',100); </script>");
      //  Page.ClientScript.RegisterClientScriptBlock(GetType(), "regJSval", "<script>setValues('" + listid + "/" + listitemid + "');</script>");

    }


    protected void btnClose_Click(object sender, EventArgs e)
    {
        string listitemid = "";
        string listid = "";
        Page.ClientScript.RegisterClientScriptBlock(GetType(), "regJSval", "<script>setValues('" + listid + "/" + listitemid + "');</script>");

    }

    private void SetUICultureText()
    {
        
        btnSelect.Text = _ResManager.GlobalResourceSet.GetString("ecm_assn_explr_btnAttach");
        btnClose.Text = _ResManager.GlobalResourceSet.GetString("ecm_assn_explr_btnClose");
        lbllistexplorer.Text = _ResManager.GlobalResourceSet.GetString("ecm_assn_explr_lbllist");
        lbllookup.Text = _ResManager.GlobalResourceSet.GetString("ecm_assn_explr_lbllistitem");
        lblhelp.Text = _ResManager.GlobalResourceSet.GetString("ecm_assn_explr_lblhelp");
        
       // _propertyName = _ResManager.GlobalResourceSet.GetString("_WorkFlowEvent_Assiciation");
    }
}
