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
using System.Xml;
using Workflow.NET;
using System.Text;
using Skelta.FarmManager;

public partial class AuditTrail : System.Web.UI.Page
{
    protected string ThemeURL = string.Empty;
    protected string templateDirectory = "";
    protected string templateRootDir = "";
    Skelta.Repository.List.ListItemCollection _ListItems = null;
    Guid _ListId = Guid.Empty;
    Guid _ListItemId = Guid.Empty;
    string _ListName = "";
    string _LoggedInUserId = "";
    string _ApplicationName = "";
    Workflow.NET.Interfaces.IDataHandler DBHandler = null;
    string _TableName = "";
    protected SkeltaResourceSetManager _ResMgr = new SkeltaResourceSetManager();

    /// <summary>
    /// Gets or sets a value indicating whether CloudPlatform
    /// </summary>
    private bool CloudPlatform { get; set; }

    /// <summary>
    /// Platform Type
    /// </summary>
    private Platform platform = Platform.OnPremise;

    protected void Page_Load(object sender, EventArgs e)
    {
		    Skelta.Repository.Security.CommonFunctions.ValidateRequestFullQueryString(Request.QueryString);

        if (!Skelta.Repository.Security.CommonFunctions.IsControlValuesValid(this.Controls))
        {
            throw new Skelta.Repository.Security.XssSecurityException();
        }

        ListPageParameters listParams = new ListPageParameters();
        listParams.ResolveCurrentUri();
        this.platform = Workflow.NET.CommonFunctions.GetPlatformType();
        this.CloudPlatform = (this.platform == Skelta.FarmManager.Platform.OnPremise) ? false : true;

        Workflow.NET.DateCorrectionFactor.RegisterDateCorrectionFactorScript();

        _ListId = listParams.ListId;
        _ListName = listParams.ListName;
        _ListItemId = listParams.ListItemId;
        _LoggedInUserId=listParams.LoggedInUserId;
        _ApplicationName = listParams.ApplicationName;

        ListDefinition listDefn = new ListDefinition(new Skelta.Core.ApplicationObject(listParams.ApplicationName), _ListId);
        _ListItems = new Skelta.Repository.List.ListItemCollection(listDefn);
        _TableName = listDefn.TableName;

        Config config = new Config(listParams.ApplicationName);
        DBHandler = Workflow.NET.Storage.DataHandlerFactory.GetDataHandler(config);

        templateRootDir = listParams.TemplateRootDirectory;
        templateDirectory = listParams.TemplateListDirectory;

        WebGrid1.RuntimeLicenseKey = Workflow.NET.CommonFunctions.GetWebgridRuntimeLicenseKey;
        WebGrid1.PrepareDataBinding += new DataSourceEventHandler(WebGrid1_PrepareDataBinding);
        WebGrid1.ScriptDirectory = templateRootDir + Workflow.NET.CommonFunctions.WebGridScriptDirectory;
        WebGrid1.SharedScriptDirectory = templateRootDir + Workflow.NET.CommonFunctions.WebGridSharedScriptDirectory;
        WebGrid1.WebDesktopScriptDirectory = templateRootDir + Workflow.NET.CommonFunctions.WebGridWebDesktopScriptDirectory;
        WebGrid1.LayoutSettings.ImageSettings.Folder = templateRootDir + Workflow.NET.CommonFunctions.WebGridLayoutImageSettingsFolder;
        WebGrid1.LayoutSettings.TextSettings.LocalizationFolder = templateRootDir + Workflow.NET.CommonFunctions.WebGridLayoutTextSettingsLocalizationFolder;
        WebGrid1.LayoutSettings.AllowExport = (!this.CloudPlatform) ? Export.Yes : Export.No;

        Object TEBObject = Workflow.NET.TemplateExpressionBuilder.GetUrl("");
        ThemeURL = TEBObject.ToString();
        TEBObject = null;

        // To Resolve URL Spoofing.Check whether the current user has right to edit.
        Skelta.Repository.Security.SecurityManager.CheckUrlAccessRight(Page, _ApplicationName, _LoggedInUserId, "ActionViewAuditHistory", _ListId, _ListItemId, _ResMgr.GlobalResourceSet.GetString("NoRight"), "../Site/blank.htm");   
      }

    void WebGrid1_PrepareDataBinding(object sender, DataSourceEventArgs e)
    {
        if (!IsPostBack || (WebGrid1.FlyPostBackAction == PostBackAction.RefreshAll))
        {
            WebGrid1.RootTable.Columns.Clear();

            WebGridColumn Action = new WebGridColumn();
            Action.Name = "Action";
            Action.DataMember = "ac";
            Action.Caption = _ResMgr.GlobalResourceSet.GetString("vah_grd_action"); 
            Action.Visible = true;
            Action.Bound = true;
            WebGrid1.RootTable.Columns.Add(Action);

            WebGridColumn User = new WebGridColumn();
            User.Name = "User"; //"Action Performed By";
            User.DataMember = "usr";
            User.Caption = _ResMgr.GlobalResourceSet.GetString("vah_grd_user");
            User.Visible = true;
            User.Bound = true;
            WebGrid1.RootTable.Columns.Add(User);

            WebGridColumn Version = new WebGridColumn();
            Version.Name = "Version";
            Version.DataMember = "ver";
            Version.Caption = _ResMgr.GlobalResourceSet.GetString("vah_grd_version");
            Version.Visible = true;
            Version.Bound = true;
            WebGrid1.RootTable.Columns.Add(Version);

            //added this change to handle upgrade.
            int columnCount;
            int expectedColumnCount = 0;
            try
            {
                columnCount = ((System.Data.DataSet)(WebGrid1.DataSource)).Tables[0].Columns.Count;
                expectedColumnCount = ((System.Data.DataSet)(WebGrid1.DataSource)).Tables[0].Columns.Contains("utcdt") ? 5 : 4;
            }
            catch (Exception)
            {
                columnCount = 0;
            }
            if (columnCount > expectedColumnCount)
            {

                WebGridColumn Message = new WebGridColumn();
                Message.Name = "Message";
                //If rows are not there the column names will differ.so added this condition
                if (WebGrid1.VirtualLoadArgs.TotalDataSourceRows > 0)
                {
                    Message.DataMember = "AuditMessage_Text";
                }
                else
                {
                    Message.DataMember = "msg";
                }
                Message.Caption = _ResMgr.GlobalResourceSet.GetString("vah_grd_message");
                Message.Visible = true;
                Message.Width = Unit.Pixel(400);
                Message.Bound = true;
                WebGrid1.RootTable.Columns.Add(Message);
            }
            

            WebGridColumn Date = new WebGridColumn();
            Date.Name = "Date";
            Date.DataMember = "dt";
            Date.Caption = _ResMgr.GlobalResourceSet.GetString("vah_grd_date");
            Date.Visible = true;
            Date.Bound = true;
            Date.Width = Unit.Pixel(200);
            WebGrid1.RootTable.Columns.Add(Date);
        }


    }

    protected void WebGrid1_InitializeDataSource(object sender, DataSourceEventArgs e)
    {
        IDataReader dr = null;
        int totalrows;
        try
        {
            WebGrid grid = (WebGrid)sender;
            grid.ClearCachedDataSource();
            StringBuilder strbldr = new StringBuilder();
            string Query = "SELECT Id, AuditTrail FROM "+ _TableName + " WHERE Id =@ListItemId";
            List<IDataParameter> paramCollection = new List<IDataParameter>();
            IDataParameter paramListItemIdParam = DBHandler.GetParameter("@ListItemId", _ListItemId);
            paramCollection.Add(paramListItemIdParam);
            dr = DBHandler.ExecuteReader(Query, paramCollection.ToArray());
            DataTable dt = new DataTable();
            while (dr.Read())
            {
                if (!string.IsNullOrEmpty(dr[1].ToString()))
                {
                    strbldr.Append("<Root>");
                    strbldr.Append(dr[1].ToString());
                    strbldr.Append("</Root>");
                }
                else
                {
                    DataColumn dc1 = new DataColumn("ac");
                    DataColumn dc2 = new DataColumn("usr");
                    DataColumn dc3 = new DataColumn("ver");
                    DataColumn dc4 = new DataColumn("dt");
                    DataColumn dc5 = new DataColumn("msg");                   
                    dt.Columns.Add(dc1);
                    dt.Columns.Add(dc2);
                    dt.Columns.Add(dc3);
                    dt.Columns.Add(dc4);
                    dt.Columns.Add(dc5);                   
                }

            }
            if (!string.IsNullOrEmpty(strbldr.ToString()))
            {
                XmlDocument doc = new XmlDocument();
                doc.LoadXml(strbldr.ToString());

                System.IO.StringReader strrdr = new System.IO.StringReader(doc.DocumentElement.OuterXml);
                DataSet DS = new DataSet();
                DS.ReadXml(strrdr);

                double utcOffset = Workflow.NET.DateCorrectionFactor.GetDateCorrectionFactorInMinutes();

                foreach (DataRow row in DS.Tables[0].Rows)
                {
                    DateTime utcDateTime = (string.IsNullOrEmpty(row["dt"].ToString()))
                        ? DateTime.Parse(row["utcdt"].ToString(), System.Globalization.DateTimeFormatInfo.InvariantInfo)
                        : DateTime.Parse(row["dt"].ToString(), System.Globalization.DateTimeFormatInfo.InvariantInfo).ToUniversalTime();

                    DateTime localDateTime = utcDateTime.AddMinutes(utcOffset);
                    row["dt"] = localDateTime;
                }
                e.DataSource = DS;
                totalrows = DS.Tables[0].Rows.Count;
            }
            else
            {
                e.DataSource = dt;
                totalrows = dt.Rows.Count;
            }
            WebGrid1.VirtualLoadArgs.TotalDataSourceRows = totalrows;
        }
        catch (Exception ex)
        {
            throw new Exception("Error at getting the Audit Trail informaiton of list item for the Grid, Additional Information " + ex.Message);
        }
        finally
        {
            if (dr != null)
                dr.Close();
            if (DBHandler != null)
                DBHandler.Dispose();
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
        try
        {
            if (e.Row.Cells.GetNamedItem("User") != null)
            {
                Skelta.Core.VirtualActor vActor = new Skelta.Core.VirtualActor(new Skelta.Core.ApplicationObject(_ApplicationName));
                Guid _VirtualActorId = vActor.GetVirtualActorId(e.Row.Cells.GetNamedItem("User").Value.ToString());
                Workflow.NET.Resource resource = Workflow.NET.ResourceHandler.GetResourceHandler(_ApplicationName).Resources.GetResource(vActor.GetRealActorID(Skelta.Repository.Security.CommonFunctions.ConvertByteArrayToGuid(_VirtualActorId.ToString(), _VirtualActorId)));
                e.Row.Cells.GetNamedItem("User").Text = resource.Properties.Name.Value.ToString();
            }
        }
        catch (Exception)
        {   // If Owner column does not have any value, it should not throw an error, but it display a message in logger console
            //logger.LogInformation("Initializing Row: Owner information is not available.");
        }
    }

}
