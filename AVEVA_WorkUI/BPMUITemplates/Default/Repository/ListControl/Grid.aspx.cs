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
using System.Data;
using System.Data.SqlClient;
using ISNet.WebUI.WebGrid;
using Workflow.NET.Ajax;
using Skelta.Repository.List;
using System.Collections.Generic;
using Skelta.Repository.Web.List;

public partial class BPMUITemplates_Default_Repository_ListControl_Grid : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    Skelta.Repository.Web.ListControl _ListControl;
    protected string templateDirectory = "";
    protected string templateRootDir = "";
    Skelta.Repository.List.ListItemCollection _ListItems = null;
    Guid _ListId = Guid.Empty;
    string _ListName = "";
    string _FilterColumn = "";
    string _FilterValue = "";
    Guid _UserId;
    ListDefinition listDefn = null;
    protected string ListControlName = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        string LoggedInUserId;

        ListPageParameters listParams = new ListPageParameters();
        listParams.ResolveCurrentUri();

        _ListId = listParams.ListId;
        _ListName = listParams.ListName;

        _FilterColumn = listParams.FilterColumn.Trim();
        _FilterValue = listParams.FilterValue.Trim();

        LoggedInUserId = listParams.LoggedInUserId;

        listDefn = new ListDefinition(new Skelta.Core.ApplicationObject(listParams.ApplicationName), _ListId);
        _ListItems = new Skelta.Repository.List.ListItemCollection(listDefn);        

        templateRootDir = listParams.TemplateRootDirectory;
        templateDirectory = listParams.TemplateListDirectory;
        ListControlName = listParams.Parameter;

        try
        {
           Skelta.HWS.Actor actor = new Skelta.HWS.Actor(new Skelta.Core.ApplicationObject(listParams.ApplicationName), LoggedInUserId);
           _UserId = actor.Id;

        }
        catch (Exception ex)
        {
        }
 
        WebGrid1.RuntimeLicenseKey = "D717O-38HL-4R4X7";
        WebGrid1.PrepareDataBinding += new DataSourceEventHandler(WebGrid1_PrepareDataBinding);
        WebGrid1.ScriptDirectory = templateRootDir + "Intersoft/Grid/CommonLibrary/WebGrid/V4_0_6200/";
        WebGrid1.SharedScriptDirectory = templateRootDir + "Intersoft/Grid/CommonLibrary/Shared/";
        WebGrid1.LayoutSettings.ImageSettings.Folder = templateRootDir + "Intersoft/Grid/CommonLibrary/Images/";
        WebGrid1.LayoutSettings.TextSettings.LocalizationFolder = templateRootDir + "Intersoft/Grid/CommonLibrary/WebGrid/V4_0_6200/Localization/";
        WebGrid1.LayoutSettings.HeaderStyle.BackgroundImage = templateRootDir + "Repository/ListControl/images/hrd-bg.gif";

    }


    void WebGrid1_PrepareDataBinding(object sender, DataSourceEventArgs e)
    {
        if (!IsPostBack || (WebGrid1.FlyPostBackAction == PostBackAction.RefreshAll))
        {
            WebGrid1.RootTable.Columns.Clear();

            WebGridColumn ListItemIdColumn = new WebGridColumn();
            ListItemIdColumn.Name = "Id";
            ListItemIdColumn.DataMember = "Id";
            ListItemIdColumn.Visible = false;
            ListItemIdColumn.Bound = true;
            WebGrid1.RootTable.Columns.Add(ListItemIdColumn);

            WebGridColumn ListItemTypeColumn = new WebGridColumn();
            ListItemTypeColumn.Name = "ItemType";
            ListItemTypeColumn.DataMember = "ItemType";
            ListItemTypeColumn.Caption = "";
            ListItemTypeColumn.ColumnType = ColumnType.Image;
            ListItemTypeColumn.Visible = true;
            ListItemTypeColumn.Bound = true;
            ListItemTypeColumn.Width = Unit.Pixel(30);
            WebGrid1.RootTable.Columns.Add(ListItemTypeColumn);

            SortedDictionary<string, Skelta.Forms.Core.Controls.BaseDataControl> fields = _ListItems.GetRecordsFieldMapping();
            foreach (KeyValuePair<string, Skelta.Forms.Core.Controls.BaseDataControl> pair in fields)
            {
                    WebGridColumn column = new WebGridColumn();
                    column.Name = pair.Value.Name;
                    column.Caption = pair.Value.Name;
                    column.DataMember = pair.Key;
                    column.Visible = true;
                    column.Bound = true;
                    //column.Width = pair.Value.GridDisplayWidth;
                    if (!pair.Value.DisplayInGrid)
                    {
                        column.Visible = false;
                    }
                    WebGrid1.RootTable.Columns.Add(column);
            }

            if (listDefn.IsItemVersioningEnabled){
                    WebGridColumn ListItemVersion = new WebGridColumn();
                    ListItemVersion.Name = "Version";
                    ListItemVersion.DataMember = "Version";
                    ListItemVersion.Visible = true;
                    ListItemVersion.Bound = true;
                    //ListItemVersion.Position = 250;
                    WebGrid1.RootTable.Columns.Add(ListItemVersion);
            }

            WebGridColumn ListItemStatus = new WebGridColumn();
            ListItemStatus.Name = "Status";
            ListItemStatus.DataMember = "Status";
            ListItemStatus.Visible = true;
            ListItemStatus.Bound = true;
            //ListItemStatus.Position = 300;
            WebGrid1.RootTable.Columns.Add(ListItemStatus);

            WebGridColumn ListItemIsDisabled = new WebGridColumn();
            ListItemIsDisabled.Name = "IsDisabled";
            ListItemIsDisabled.DataMember = "IsDisabled";
            ListItemIsDisabled.Visible = false;
            ListItemIsDisabled.Bound = true;
            WebGrid1.RootTable.Columns.Add(ListItemIsDisabled);
        }

        WebValueList ImageValueList = WebGrid1.RootTable.Columns.GetNamedItem("ItemType").ValueList;
        Hashtable ImageValues = new Hashtable();
        ImageValues.Add("0", "Images/folder.png");
        ImageValues.Add("1", "Images/workflow-grid-icon.png");
        ImageValueList.DataSource = ImageValues;


        WebValueList ValueStatusList = WebGrid1.RootTable.Columns.GetNamedItem("Status").ValueList;
        Hashtable StatusValues = new Hashtable();
        StatusValues.Add("1", "Draft");
        StatusValues.Add("2", "Completed");
        StatusValues.Add("3", "Published");

        ValueStatusList.DataSource = StatusValues;
    }

    protected void WebGrid1_InitializeDataSource(object sender, DataSourceEventArgs e)
    {
 
        try
        {
            WebGrid grid = (WebGrid)sender;
            grid.ClearCachedDataSource();

            if (Request.Form["ParentItemId"] != null && Request.Form["ParentItemId"] != "")
            {
                Guid _ListItemId = new Guid(Request.Form["ParentItemId"].ToString());
         //     DataTable itemsDataTable = _ListItems.GetRecords(_UserId,_ListItemId);

              DataTable itemsDataTable = _ListItems.GetRecords(_ListItemId);

                e.DataSource = itemsDataTable;
            }
            else if (_FilterColumn != "")
            {   
                DataTable itemsDataTable = _ListItems.GetRecords(_FilterColumn,_FilterValue);
                e.DataSource = itemsDataTable;
            }
            else
            {
        //      DataTable itemsDataTable = _ListItems.GetRecords(_UserId);

              DataTable itemsDataTable = _ListItems.GetRecords();
                e.DataSource = itemsDataTable;
            }
        }
        catch (Exception ex)
        {

        }
    }

    protected void WebGrid1_InitializePostBack(object sender, PostbackEventArgs e)
    {
        WebGrid1.ClientAction.RefreshAll();
    }

    protected void WebGrid1_InitializeLayout(object sender, LayoutEventArgs e)
    {
        // e.Layout.ClientSideEvents.OnCellDblClick = "DoCellClick";
    }

    protected void WebGrid1_InitializeRow(object sender, RowEventArgs e)
    {
        Guid _ListItemId = Guid.Empty;
        string _ItemStatus = "";
        string ItemType = "";

        //e.Row.Style.Overflow = ISNet.WebUI.Overflow.Hidden;
        //e.Row.Style.OverflowX = ISNet.WebUI.Overflow.Hidden;
        //e.Row.Style.OverflowY = ISNet.WebUI.Overflow.Hidden;
        //e.Row.Style.CustomRules = "text-overflow: ellipsis; overflow-x: hidden";

        if (e.Row.Type == ISNet.WebUI.WebGrid.RowType.Record)
        {


            if (e.Row.Cells.GetNamedItem("IsDisabled").Value.ToString() == "True")
            {
                e.Row.Style.BackColor = System.Drawing.Color.FromName("#ebebeb");
                e.Row.Style.ForeColor = System.Drawing.Color.FromName("#c6c6c6");
            }
        }


        ItemType = e.Row.Cells.GetNamedItem("ItemType").Value.ToString();

        if (listDefn.IsItemVersioningEnabled)
        {
            if (_ListName.ToLower() == "workflow")
            {
                if (ItemType == "0")
                    e.Row.Cells.GetNamedItem("Version").Text = "";
            }
            else
            {
                if (ItemType == "0")
                    e.Row.Cells.GetNamedItem("Version").Text = "";
            }
        }

        _ListItemId = (Guid)e.Row.Cells.GetNamedItem("Id").Value;
        _ItemStatus = e.Row.Cells.GetNamedItem("Status").Value.ToString();

        e.Row.Cells.GetNamedItem("Title").CustomAttributes = "itemDetails=\"" + _ListItemId + "," + _ListId + "," + _ItemStatus + "," + ItemType + "," + _ListName.ToLower() + "\"";
  
        
    }
}
