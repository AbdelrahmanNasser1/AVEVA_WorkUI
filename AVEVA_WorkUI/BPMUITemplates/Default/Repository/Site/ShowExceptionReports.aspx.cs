using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using AntiXssEncoder = Microsoft.Security.Application.Encoder;

using Workflow.NET;
using Workflow.NET.Engine;
using Workflow.NET.Interfaces;
using Skelta.Core;
using Skelta.Core.DS;
using Skelta.Entity;
using Skelta.Repository.List;
using ISNet.WebUI.WebGrid;
using ISNet.WebUI;
using Skelta.Repository.Web.List;

public partial class ShowExceptionReports : System.Web.UI.Page
{
    protected SkeltaResourceSetManager skrm = new SkeltaResourceSetManager();
    protected string themePath = "";
    protected string pageHeader = "";
    protected string bellyBarPath = string.Empty;
    
    //protected WebGrid WebGrid1;
    protected string displayApplicationName = "";
    protected string displayWorkflowName = "";
    protected string checkBoxTxt = "";
    protected string checkEmptyMsg = "";
    protected string previewCheckBoxTxt = "";
    protected string allowFilterText = "";
    protected string doubleClickMesg = "";
    protected string application = "";// "CustomDSRepo";
    protected string workflow = "";// "TestException";
    protected string uncheckPreviewMsg = "";
    protected string uncheckFilterMgs = "";
    protected bool displayFooter = true;
    protected bool addPadding = false;
    protected string noRowsAvailable = string.Empty;
    string loggedInUser = "";
    string exceptionView = "";
    int executionId;
    int executionDetailsId;
    ListPageParameters listParams = null;
    bool isQuickflow = false;
    protected void Page_Load(object sender, EventArgs e)
    {
        
        Initialize();
        LocalizeLabels();
        
        btnClear.Click += new EventHandler(btnClear_Click);
       
        
    } 

    

    protected void WebGrid1_InitializeRow(object sender, RowEventArgs e)
    {
        if (e.Row.Type == RowType.Record)
        {
            
            WebGridCell imageCell = e.Row.Cells.GetNamedItem("ImageType");
            if (imageCell != null)
            {
                if (e.Row.Cells.GetNamedItem("Type") != null)
                {
                    string imageType = e.Row.Cells.GetNamedItem("Type").Value.ToString();
                    if (imageType.Equals("error", StringComparison.OrdinalIgnoreCase))
                        imageCell.Image = this.themePath + "Repository/Site/images/erroricon.png";
                    else
                        imageCell.Image = themePath + "Repository/Site/images/icon-warnings.png";
                }
            }

            WebGridCell dateTimeCell = e.Row.Cells.GetNamedItem("UpdatedDateTime");

            if (dateTimeCell != null)
            {
                DateTime tempDate = (DateTime)dateTimeCell.Value;
                /*
                string dateFormat = "T";// skrm.GlobalResourceSet.GetString("E_dateFormat");
                if (DateTime.Compare(tempDate.Date, DateTime.Today).Equals(0))
                {
                    
                    dateTimeCell.Value = tempDate.ToString(dateFormat, System.Globalization.DateTimeFormatInfo.InvariantInfo);
                }
                else if (DateTime.Compare(tempDate.Date, DateTime.Today.AddDays(-1)).Equals(0))
                {
                    string format = skrm.GlobalResourceSet.GetString("E_yestDateFormat");
                    format = format.Replace("<%#datevar#%>",tempDate.ToString(dateFormat, System.Globalization.DateTimeFormatInfo.InvariantInfo));
                    dateTimeCell.Value = format;
                }
                else
                    dateTimeCell.Value = tempDate.ToLocalTime();
                 * */
                dateTimeCell.Value = tempDate.ToLocalTime();
            }
        }
    }
    protected void WebGrid1_InitializeDataSource(object sender, DataSourceEventArgs e)
    {        
        ApplicationObject appObj = new ApplicationObject(application);
        bool noRowsAvailable = false;
        DataTable exceptionTable = new DataTable();
        //bool isGlobal = false;
        //if (!string.IsNullOrEmpty(hdnCkvalue.Value))
        //    isGlobal = bool.Parse(hdnCkvalue.Value);

        //if (isGlobal)
        //{
        //    PersistedExceptionCollection applicationLevelExcepetionCollection = new PersistedExceptionCollection(appObj);
        //    using (DataSet recordsSet = applicationLevelExcepetionCollection.GetRecords())
        //    {
                
        //        if (recordsSet != null)
        //        {
        //            e.DataSource = recordsSet;
                    
        //        }

        //    }
        //}
        //else
        //{

        switch (exceptionView)
        {
            case "WORKFLOWVIEW":
                {
                    
                    PersistedExceptionCollection workflowLevelExcepetionCollection = new PersistedExceptionCollection(appObj, workflow);
                    using (DataSet recordsSet = workflowLevelExcepetionCollection.GetRecords())
                    {
                        if (recordsSet != null)
                        {
                            try
                            {
                                //Added this check, as the status bar in the grid was going up, when no rows were available
                                if (!(recordsSet.Tables[0].Rows.Count > 0))
                                {
                                    noRowsAvailable = true;
                                    //Columns are created, in the databinding event only, only if we bind the data that event get called
                                    //if (!(WebGrid1.RootTable.Columns.Count > 0))
                                    //    e.DataSource = recordsSet;
                                }
                                else
                                    e.DataSource = recordsSet;                                
                            }
                            catch
                            {
                            }

                        }


                    }
                    break;
                }
            case "EXECUTIONVIEW":
                {
                    PersistedExceptionCollection workflowLevelExcepetionCollection = new PersistedExceptionCollection(appObj, executionId);
                    using (DataSet recordsSet = workflowLevelExcepetionCollection.GetRecords())
                    {
                        if (recordsSet != null)
                        {
                            e.DataSource = recordsSet;

                        }
                    }
                    break;
                }
            case "EXECUTIONDETAILSVIEW":
                {
                    PersistedExceptionCollection workflowLevelExcepetionCollection = new PersistedExceptionCollection(appObj, executionId, executionDetailsId);
                    using (DataSet recordsSet = workflowLevelExcepetionCollection.GetRecords())
                    {
                        if (recordsSet != null)
                        {
                            e.DataSource = recordsSet;

                        }
                    }
                    break;
                }
        }
        //}
        if (noRowsAvailable)
        {
            DataColumn IdColumn = new DataColumn();
            IdColumn.ColumnName = "Id";
            DataColumn ImageTypeColumn = new DataColumn();
            ImageTypeColumn.ColumnName = "ImageType";
            DataColumn TypeColumn = new DataColumn();
            TypeColumn.ColumnName = "Type";
            DataColumn MessageColumn = new DataColumn();
            MessageColumn.ColumnName = "Message";
            DataColumn ProcessNameColumn = new DataColumn();
            ProcessNameColumn.ColumnName = "ProcessName";
            DataColumn LastUpdatedDateTimeColumn = new DataColumn();
            LastUpdatedDateTimeColumn.ColumnName = "LastUpdatedDateTime";
            DataColumn MachineNameColumn = new DataColumn();
            MachineNameColumn.ColumnName = "MachineName";
            DataColumn FileNameColumn = new DataColumn();
            FileNameColumn.ColumnName = "FileName";
            DataColumn ExecutionIdColumn = new DataColumn();
            ExecutionIdColumn.ColumnName = "ExecutionId";
            DataColumn ExecutionDetailsIdColumn = new DataColumn();
            ExecutionDetailsIdColumn.ColumnName = "ExecutionDetailsId";
            DataColumn ModuleNameColumn = new DataColumn();
            ModuleNameColumn.ColumnName = "ModuleName";
            exceptionTable.Columns.Add(IdColumn);
            exceptionTable.Columns.Add(ImageTypeColumn);
            exceptionTable.Columns.Add(TypeColumn);
            exceptionTable.Columns.Add(MessageColumn);
            exceptionTable.Columns.Add(ProcessNameColumn);
            exceptionTable.Columns.Add(LastUpdatedDateTimeColumn);
            exceptionTable.Columns.Add(MachineNameColumn);
            exceptionTable.Columns.Add(FileNameColumn);
            exceptionTable.Columns.Add(ExecutionIdColumn);
            exceptionTable.Columns.Add(ExecutionDetailsIdColumn);
            exceptionTable.Columns.Add(ModuleNameColumn);
            e.DataSource = exceptionTable;
        }

    }
    protected void WebGrid1_PrepareDataBinding(object sender, DataSourceEventArgs e)
    {
        if (!IsPostBack && !(WebGrid1.RootTable.Columns.Count>0))
        {   
            
            WebGrid1.RootTable.Columns.Clear();
            
            
            //WebGrid1.RootTable.GroupedColumns.Clear();
            //WebGrid1.RootTable.SortedColumns.Clear();

            WebGrid1.RootTable.Name = "CollectionBaseTable";

            WebGridColumn WorkItemIdColumn = new WebGridColumn();
            WorkItemIdColumn.Name = "Id";
            WorkItemIdColumn.DataMember = "Id";
            WorkItemIdColumn.Visible = false;
            WorkItemIdColumn.Bound = true;
            WebGrid1.RootTable.Columns.Add(WorkItemIdColumn);
            
                WebGridColumn WorkItemCheckIdColumn = new WebGridColumn();
                WorkItemCheckIdColumn.Name = "CheckBox";//If you are changing the name of this, then change the condition in Initialize()
                //WorkItemCheckIdColumn.Caption = skrm.GlobalResourceSet.GetString("SelectRecords");
                WorkItemCheckIdColumn.Bound = false;
                WorkItemCheckIdColumn.IsRowChecker = true;
                WorkItemCheckIdColumn.ColumnType = ColumnType.CheckBox;
                WorkItemCheckIdColumn.AllowGrouping = Grouping.No;
                WorkItemCheckIdColumn.AllowSorting = Sorting.No;
                WorkItemCheckIdColumn.ShowInSelectColumns = SelectColumns.No;
                //if (exceptionView == "WORKFLOWVIEW")
                //    WorkItemCheckIdColumn.Visible = true;
                //else
                //    WorkItemCheckIdColumn.Visible = false;
               
                WorkItemCheckIdColumn.Width = Unit.Pixel(25);
                WebGrid1.RootTable.Columns.Add(WorkItemCheckIdColumn);
            

            WebGridColumn WebGrid1TypeColumn = new WebGridColumn();
            WebGrid1TypeColumn.Name = "ImageType";
            WebGrid1TypeColumn.Caption = "";
            WebGrid1TypeColumn.ColumnType = ColumnType.Image;
            WebGrid1TypeColumn.Visible = true;
            WebGrid1TypeColumn.Bound = false;
            WebGrid1TypeColumn.AllowGrouping = Grouping.Yes;
            WebGrid1TypeColumn.AllowSorting = Sorting.No;
            WebGrid1TypeColumn.Width = Unit.Pixel(25);
            WebGrid1.RootTable.Columns.Add(WebGrid1TypeColumn);

            WebGridColumn WebGrid1Type = new WebGridColumn();
            WebGrid1Type.Name = "Type";
            WebGrid1Type.Caption = skrm.GlobalResourceSet.GetString("Level");
            WebGrid1Type.DataMember = "Type";
            WebGrid1Type.Visible = false;
            WebGrid1Type.Bound = true;
            WebGrid1Type.Width = Unit.Pixel(50);
            WebGrid1.RootTable.Columns.Add(WebGrid1Type);

            WebGridColumn WebGrid1Message = new WebGridColumn();
            WebGrid1Message.Name = "Message";
            WebGrid1Message.Caption = skrm.GlobalResourceSet.GetString("Message");
            WebGrid1Message.DataMember = "Message";
            WebGrid1Message.Visible = true;
            WebGrid1Message.Bound = true;
            WebGrid1Message.AllowSizing = ColumnSizing.No;
           // if (exceptionView == "WORKFLOWVIEW")
            WebGrid1Message.Width = Unit.Pixel(180);
            //else
               // WebGrid1Message.Width = Unit.Pixel(450);
            WebGrid1Message.AllowSorting = Sorting.No;
            WebGrid1Message.AllowGrouping = Grouping.No;        
          
            WebGrid1.RootTable.Columns.Add(WebGrid1Message);

            WebGridColumn WebGrid1DateTime = new WebGridColumn();
            WebGrid1DateTime.Name = "UpdatedDateTime";
            WebGrid1DateTime.Caption = skrm.GlobalResourceSet.GetString("Date and Time");
            WebGrid1DateTime.DataMember = "LastUpdatedDateTime";
            WebGrid1DateTime.Visible = true;
            WebGrid1DateTime.Bound = true;
            WebGrid1DateTime.AllowGrouping = Grouping.Yes;
            WebGrid1DateTime.AllowSorting = Sorting.Yes;
            WebGrid1.RootTable.Columns.Add(WebGrid1DateTime);

            WebGridColumn WebGrid1ProcessName = new WebGridColumn();
            WebGrid1ProcessName.Name = "ProcessName";
            WebGrid1ProcessName.Caption = skrm.GlobalResourceSet.GetString("Process");
            WebGrid1ProcessName.DataMember = "ProcessName";
            WebGrid1ProcessName.Visible = true;
            WebGrid1ProcessName.Bound = true;
            WebGrid1ProcessName.AllowSorting = Sorting.Yes;
            WebGrid1ProcessName.AllowGrouping = Grouping.Yes;
            WebGrid1.RootTable.Columns.Add(WebGrid1ProcessName);

            WebGridColumn WebGrid1Machine = new WebGridColumn();
            WebGrid1Machine.Name = "MachineName";
            WebGrid1Machine.Caption = skrm.GlobalResourceSet.GetString("MachineName");
            WebGrid1Machine.DataMember = "MachineName";
            WebGrid1Machine.Visible = true;
            WebGrid1Machine.Bound = true;
            WebGrid1Machine.AllowGrouping = Grouping.Yes;
            WebGrid1Machine.AllowSorting = Sorting.Yes;
            WebGrid1.RootTable.Columns.Add(WebGrid1Machine);

            WebGridColumn WebGrid1File = new WebGridColumn();
            WebGrid1File.Name = "FileName";
            WebGrid1File.Caption = skrm.GlobalResourceSet.GetString("FileName");
            WebGrid1File.DataMember = "FileName";
            WebGrid1File.Visible = false;
            WebGrid1File.Bound = true;
            WebGrid1File.AllowSizing = ColumnSizing.No;
            WebGrid1File.AllowSorting = Sorting.Yes;
            WebGrid1File.AllowGrouping = Grouping.Yes;
            WebGrid1.RootTable.Columns.Add(WebGrid1File);

            WebGridColumn WebGrid1ExecutionId = new WebGridColumn();
            WebGrid1ExecutionId.Name = "ExecutionId";
            WebGrid1ExecutionId.Caption = skrm.GlobalResourceSet.GetString("ExecutionId");
            WebGrid1ExecutionId.DataMember = "ExecutionId";
            WebGrid1ExecutionId.Visible = true;
            WebGrid1ExecutionId.Bound = true;
            WebGrid1ExecutionId.Width = Unit.Pixel(100);
            WebGrid1ExecutionId.FilterEditType = FilterEditType.TextBox;
            WebGrid1ExecutionId.AllowSorting = Sorting.Yes;
            WebGrid1ExecutionId.AllowGrouping = Grouping.Yes;            
            WebGrid1ExecutionId.HeaderTooltip = WebGrid1ExecutionId.Caption;

            WebGrid1.RootTable.Columns.Add(WebGrid1ExecutionId);

            WebGridColumn WebGrid1ExecutionDetailsId = new WebGridColumn();
            WebGrid1ExecutionDetailsId.Name = "ExecutionDetailsId";
            WebGrid1ExecutionDetailsId.HeaderTooltip = WebGrid1ExecutionDetailsId.Caption = skrm.GlobalResourceSet.GetString("ExecutionDetailsId");
            WebGrid1ExecutionDetailsId.DataMember = "ExecutionDetailsId";
            WebGrid1ExecutionDetailsId.Visible = isQuickflow? false:true;
            WebGrid1ExecutionDetailsId.Bound = true;
            WebGrid1ExecutionDetailsId.Width = Unit.Pixel(100);
            WebGrid1ExecutionDetailsId.AllowGrouping = Grouping.Yes;
            WebGrid1ExecutionDetailsId.AllowSorting = Sorting.Yes;            
            WebGrid1.RootTable.Columns.Add(WebGrid1ExecutionDetailsId);

            WebGridColumn WebGrid1ModuleName = new WebGridColumn();
            WebGrid1ModuleName.Name = "ModuleName";
            WebGrid1ModuleName.Caption = skrm.GlobalResourceSet.GetString("ModuleName");
            WebGrid1ModuleName.DataMember = "ModuleName";
            WebGrid1ModuleName.Visible = false;
            WebGrid1ModuleName.Bound = true;
            WebGrid1Machine.AllowSizing = ColumnSizing.No;
            WebGrid1Machine.AllowGrouping = Grouping.Yes;
            WebGrid1Machine.AllowSorting = Sorting.Yes;

            WebGrid1.RootTable.Columns.Add(WebGrid1ModuleName);        

           

            WebGrid1.RootTable.DataKeyField = "Id";

        }
    }
    protected void WebGrid1_InitializeLayout(object sender, LayoutEventArgs e)
    {        
        //if (Request["lcsuri"] != null)
        //{
        //    btnClear.Enabled = true;
        //    btnClearAll.Enabled = true;
        //}
        try
        {
            if (Request.Browser.Type.StartsWith("Firefox", StringComparison.OrdinalIgnoreCase))
            {
                e.Layout.AutoFitColumnsBuffering = false;                
            }

        }
        catch { }        
        string ispreview = hdnPreviewMode.Value;
        if (!string.IsNullOrEmpty(ispreview) && bool.Parse(ispreview))
        {
            WebGrid1.RootTable.PreviewRowVisible = true;
            PreviewRowSettings rowSettings = new PreviewRowSettings();
            rowSettings.DataMember = "Message";           
            WebGrid1.RootTable.PreviewRowSettings = rowSettings;
            //if (Request["lcsuri"] != null)
            //{
            //    btnClear.Enabled = false;
            //    btnClearAll.Enabled = false;
            //}
        }
        else
            WebGrid1.RootTable.PreviewRowVisible = false;

        string allowFilter = hdnFilter.Value;
        if (!string.IsNullOrEmpty(allowFilter) && bool.Parse(allowFilter))           
            e.Layout.FilterBarVisible = true;       
        else
            e.Layout.FilterBarVisible = false;    
           
        

    }


    void Initialize()
    {
       
        WebgridDeclarations();
        if (Request["lcsuri"] != null)
        {
            listParams = new ListPageParameters();
            listParams.ResolveCurrentUri();
            loggedInUser = listParams.LoggedInUserId;
            Guid listGuid = listParams.ListId;
            Guid workflowId = listParams.ListItemId;
            application = listParams.ApplicationName;
            string version = listParams.VersionStamp;
            Skelta.Repository.List.ListDefinition workflowList = null;
            Skelta.Repository.List.ListItem workflowflowListItem = null;
            if (workflowId != Guid.Empty)
            {
                workflowList = ListDefinition.GetList(new Skelta.Core.ApplicationObject(application), "Workflow");
                workflowflowListItem = new Skelta.Repository.List.ListItem(workflowList, workflowId, version);
                if (workflowflowListItem.ItemType == 8)
                {
                    isQuickflow = true;
                }
                workflow = workflowflowListItem.Title;
                exceptionView = "WORKFLOWVIEW";
                //version = workflowflowListItem.CurrentVersion.VersionStamp;
            }
            //WebGrid1.Height = Unit.Pixel(450);
            //WebGrid1.Width = Unit.Percentage(96);
            // To Resolve URL Spoofing.Check whether the current user has right.
            Skelta.Repository.Security.SecurityManager.CheckUrlAccessRight(Page, application, loggedInUser, "ActionViewExceptions", listParams.ListId, listParams.ListItemId, skrm.GlobalResourceSet.GetString("NoRight"), "blank.htm");

        }
        else if (Request["eview"] != null)
        {
            application = AntiXssEncoder.HtmlEncode(Request["application"]);
            workflow = AntiXssEncoder.HtmlEncode(Request["wf"]);
            executionId = Int32.Parse(Request["executionId"]);
            exceptionView = "EXECUTIONVIEW";
            string height = Request["h"];
            string width = Request["w"];
            if (!string.IsNullOrEmpty(height) && !string.IsNullOrEmpty(width))
            {                
                //WebGrid1.Height = Unit.Pixel(Int32.Parse(height));
                //WebGrid1.Width = Unit.Percentage(Int32.Parse(width));
            }
            tdWebgridId.Align = "left";
            displayFooter = false;
            addPadding = true;
            
            if (WebGrid1.RootTable.Columns.Count > 2)
            {                
                foreach (WebGridColumn column in WebGrid1.RootTable.Columns)
                {
                    if (column.Name == "CheckBox")
                    {
                        column.Visible = false;                        
                        break;
                    }
                }                
            }
           // WebGrid1.LayoutSettings.AutoFitColumns = true;//As columns are not aligned properly 
            
        }
        else if (Request["edetview"] != null)
        {
            //// Added encoding in the aspx page
            application = Request["application"];
            workflow = Request["wf"];
            executionDetailsId = Int32.Parse(Request["edid"]);
            executionId = Int32.Parse(Request["executionId"]);
            exceptionView = "EXECUTIONDETAILSVIEW";
            string height = Request["h"];
            string width = Request["w"];
            if (!string.IsNullOrEmpty(height) && !string.IsNullOrEmpty(width))
            {
                //WebGrid1.Height = Unit.Pixel(Int32.Parse(height));
                //WebGrid1.Width = Unit.Percentage(Int32.Parse(width));
            }

            if (WebGrid1.RootTable.Columns.Count > 2)
            {
                // WebGridColumn column2 = new WebGridColumn(); 
                foreach (WebGridColumn column in WebGrid1.RootTable.Columns)
                {
                    if (column.Name == "CheckBox")
                    {
                        column.Visible = false;
                        //column2 = column;
                        break;
                    }
                }
                //WebGrid1.RootTable.Columns.Remove(column2);
            }            
            tdWebgridId.Align = "left";
            displayFooter = false;
        }

         }

    void LocalizeLabels()
    {
        this.Title = skrm.GlobalResourceSet.GetString("E_pageTitle");
        this.themePath = Workflow.NET.TemplateExpressionBuilder.GetUrl("").ToString();
        bellyBarPath = Workflow.NET.CommonFunctions.GetJSReferencePath();
        pageHeader = skrm.GlobalResourceSet.GetString("E_pageHeader");
        btnClear.Text = skrm.GlobalResourceSet.GetString("E_clearExp");
        btnClearAll.Text = skrm.GlobalResourceSet.GetString("E_clearAllExp");
        displayApplicationName = skrm.GlobalResourceSet.GetString("e_appName");
        displayWorkflowName = skrm.GlobalResourceSet.GetString("E_workflowName");
        checkBoxTxt = skrm.GlobalResourceSet.GetString("Show application level exceptions");
        checkEmptyMsg = skrm.GlobalResourceSet.GetString("E_rowCheckerAlertMsg");
        previewCheckBoxTxt = skrm.GlobalResourceSet.GetString("E_previewMode");
        allowFilterText = skrm.GlobalResourceSet.GetString("E_showFilters");
        doubleClickMesg = skrm.GlobalResourceSet.GetString("E_doubleclickdesc");
        uncheckPreviewMsg = skrm.GlobalResourceSet.GetString("E_uncheckPreMsg");
        uncheckFilterMgs = skrm.GlobalResourceSet.GetString("E_uncheckFilterMsg");
        noRowsAvailable = skrm.GlobalResourceSet.GetString("sk_replaceuser_securityreports_norowsavailable");

    }

    void WebgridDeclarations()
    {
        WebGrid1.RuntimeLicenseKey = Workflow.NET.CommonFunctions.GetWebgridRuntimeLicenseKey;
        string interSoftPath = "../../";
        WebGrid1.ScriptDirectory = interSoftPath + Workflow.NET.CommonFunctions.WebGridScriptDirectory;
        WebGrid1.SharedScriptDirectory = interSoftPath + Workflow.NET.CommonFunctions.WebGridSharedScriptDirectory;
        WebGrid1.LayoutSettings.ImageSettings.Folder = interSoftPath + Workflow.NET.CommonFunctions.WebGridLayoutImageSettingsFolder;
        WebGrid1.LayoutSettings.TextSettings.LocalizationFolder = interSoftPath + Workflow.NET.CommonFunctions.WebGridLayoutTextSettingsLocalizationFolder;
        WebGrid1.WebDesktopScriptDirectory = interSoftPath + Workflow.NET.CommonFunctions.WebGridWebDesktopScriptDirectory;
        //WebGrid1.Height = Unit.Percentage(80);
        //WebGrid1.Width = Unit.Percentage(95);
        //Height="570px" Width="96%"
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        ArrayList exceptionIds = WebGrid1.RootTable.GetCheckedRows();
        if (exceptionIds.Count > 0)
        {
            foreach (string exceptionId in exceptionIds)
            {
                try
                {
                    Guid id = Workflow.NET.CommonFunctions.IsGuid(exceptionId);
                    if (!id.Equals(Guid.Empty))
                    {
                        PersistedException expObj = new PersistedException(new ApplicationObject(application), id);
                        expObj.Delete();
                    }
                }
                catch (Exception exp)
                {
                    Log logger = new Log();
                    logger.LogError(exp, "Error while deleting the exception message for id {"+exceptionId+"}", application);
                    logger.Close();
                }
            }            
            WebGrid1.RebindDataSource();
        }
        
    }

    protected void btnClearAll_Click(object sender, EventArgs e)
    {
        ApplicationObject appObj = new ApplicationObject(application);
        bool isrecordsDeleted = false;
        //bool isGlobal = false;
        //if (!string.IsNullOrEmpty(hdnCkvalue.Value))
        //    isGlobal = bool.Parse(hdnCkvalue.Value);
        //if (isGlobal)
        //{
        //    PersistedExceptionCollection applicationLevelExcepetionCollection = new PersistedExceptionCollection(appObj);
        //    foreach (PersistedException expObj in applicationLevelExcepetionCollection.Items)
        //    {
        //        expObj.Delete();
        //        isrecordsDeleted = true;
        //    }
        //}
        //else
        //{
        switch (exceptionView)
        {
            case "WORKFLOWVIEW":
                {
                    PersistedExceptionCollection workflowLevelExcepetionCollection = new PersistedExceptionCollection(appObj, workflow);
                    foreach (PersistedException expObj in workflowLevelExcepetionCollection.Items)
                    {
                        expObj.Delete();
                        isrecordsDeleted = true;
                    }
                    break;
                }
            case "EXECUTIONVIEW":
                {
                    PersistedExceptionCollection workflowLevelExcepetionCollection = new PersistedExceptionCollection(appObj, executionId);
                    foreach (PersistedException expObj in workflowLevelExcepetionCollection.Items)
                    {
                        expObj.Delete();
                        isrecordsDeleted = true;
                    }
                    break;
                }
            case "EXECUTIONDETAILSVIEW":
                {
                    PersistedExceptionCollection workflowLevelExcepetionCollection = new PersistedExceptionCollection(appObj, executionId, executionDetailsId);
                    foreach (PersistedException expObj in workflowLevelExcepetionCollection.Items)
                    {
                        expObj.Delete();
                        isrecordsDeleted = true;
                    }
                    break;
                }
        }
        //}
        if (isrecordsDeleted)
            WebGrid1.RebindDataSource();// = true;
    }
}
