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
using Workflow.NET;
using Telerik.Web.UI;
using Skelta.Repository.List;
using Skelta.Core;

namespace Skelta.Forms.Web.CodeBehind
{
    public partial class DynamicOrderByBuilder : System.Web.UI.Page
    {
        protected string ThemePath;
        protected SkeltaResourceSet resManager = new SkeltaResourceSetManager().GlobalResourceSet;
        string listName,appName;
        ListDefinition listDefinition;
        protected string JSPath = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            JSPath = Workflow.NET.CommonFunctions.GetJSReferencePath();
            appName = HttpUtility.UrlDecode(Request["Repository"]);
            ThemePath = Workflow.NET.TemplateExpressionBuilder.GetUrl("").ToString();
            listDefinition = ListDefinition.GetList(new ApplicationObject(appName), listName);
            listName = HttpUtility.UrlDecode(Request["ListName"]);
            hdnListName.Value = listName.Trim();
            listDefinition = ListDefinition.GetList(new ApplicationObject(appName), listName);
            LoadTableSchema(listName.Trim());     
            RadTreeViewDisplay.NodeClick += new RadTreeViewEventHandler(RadTreeViewDisplay_NodeClick);
            if (!this.IsPostBack)
                RadOrderByText.Value = resManager.GetString("LookupOrderByQueyClickHereText");
            btnAdd.Value = resManager.GetString("LookupOrderByQueyAddButtonText");
            btnClear.Value = resManager.GetString("LookupOrderByQueyClearButtonText");
            btnSave.Value = resManager.GetString("LookupOrderByQueySaveButtonText");
            btnCancel.Value = resManager.GetString("LookupOrderByQueyCancelButtonText");
        }


        void RadTreeViewDisplay_NodeClick(object o, RadTreeNodeEventArgs e)
        {
            DataTable dtTableSchema = null;
            try
            {
                if (hdnTableType.Value.Trim() == "OrderBy")
                {
                    string[] SelectedTableName = e.Node.Text.Trim().Split('.');
                    string strSelectedTableName = SelectedTableName[0].ToString().Trim();

                    string[] SelectedTableValue = e.Node.Value.Trim().Trim().Split('.');
                    string strSelectedTableValue = SelectedTableValue[0].ToString().Trim();
                    RadOrderByColumnName.Items.Clear();
                    RadOrderByAscDsc.Items.Clear();
                    RadOrderByAscDsc.Items.Add(new RadComboBoxItem("ASC", "ASC"));
                    RadOrderByAscDsc.Items.Add(new RadComboBoxItem("DESC", "DESC"));

                    dtTableSchema = Workflow.NET.CommonFunctions.GetTableSchema(appName, e.Node.Text.Trim());
                    string[] strTableResolve = e.Node.Value.Trim().Split('`');
                    Skelta.Repository.List.ListItemCollection lc = new Skelta.Repository.List.ListItemCollection(listDefinition);
                    
                    foreach (DataColumn dc in dtTableSchema.Columns)
                    {
                        //'Id', 'Application', 'CreatedBy', 'CreatedDateTime', 'LastUpdatedDateTime', 'WIP', 'WIPItemId', 'MainItemId', 'ParentItemId', 'RecordParentItemId', 'TableId', 'ItemRowIndex', 'IsLatest', 'Version', 'VersionHistory', 'Status', 'LockedBy', 'LockedOn', 'ListID', 'SecuritySettings', 'ItemId', 'ItemType', 'SecurityItemId', 'Owner', 'ModifiedBy', 'AuditTrail', 'IsDisabled','SecurityCustomizationId','WorkflowStatus')
                        if (IsUserColumn(dc.ColumnName))
                        {
                            if (Convert.ToString(dc.ColumnName).ToLowerInvariant() == "title" && Convert.ToString(e.Node.Text).ToLowerInvariant() == "skelistitemdatanv")
                            {
                                if (e.Node.Parent != null)
                                    continue;
                            }
                            string virtualColumnName = lc.GetVirtualColumnNameCaseInsensitive(e.Node.Value.Split('`')[0], dc.ColumnName);
                            virtualColumnName = virtualColumnName.Replace("\"", "");
                            if (string.IsNullOrEmpty(virtualColumnName))
                                virtualColumnName = dc.ColumnName;
                            RadOrderByColumnName.Items.Add(new RadComboBoxItem(strSelectedTableName + "." + dc.ColumnName.Trim(), strSelectedTableValue + "." + dc.ColumnName.Trim() + "$" + virtualColumnName));
                        }
                    }
                    RadOrderByText.Value = e.Node.Text;
                    //hdnDisplayColumnTable.Value = strTableResolve[0].Trim();
                }
            }
            catch (Exception ex)
            {             
                throw;
            }
            finally
            {
                if (dtTableSchema != null)
                    dtTableSchema.Dispose();
                dtTableSchema = null;
            }
        }       

        
        private void LoadTableSchema(string SelectedListName)
        {
            try
            {
                if (SelectedListName != string.Empty)
                {
                    //Get the Schema information about the Selected List Id
                    RadTreeViewDisplay.Nodes.Clear();
                    //Bind the Data to the RadTreeView

                    Skelta.Repository.List.ListDefinition listDefinition = ListDefinition.GetList(new ApplicationObject(appName), SelectedListName);
                    Skelta.Repository.List.ListDefinition.ListTableInfo objListTableInfo = listDefinition.GetListTableTree();

                    //Navigate through the nodes and build the Xml
                    string sXmlData = GetXmlDataFromListInfo(objListTableInfo);
                    RadTreeViewDisplay.LoadXmlString(sXmlData.Trim());
                    //On Bind Data Clear the List Views
                   // RadOrderByText.Value = "";
                    if (RadOrderByText.Value == resManager.GetString("LookupOrderByQueyClickHereText"))
                        RadOrderByColumnName.Items.Clear();
                }
            }
            catch (Exception ex)
            {
                throw;
            }
        }


        private string GetXmlDataFromListInfo(ListDefinition.ListTableInfo objListTableInfo)
        {
            try
            {
                System.Text.StringBuilder strXmlData = new System.Text.StringBuilder();
                if (objListTableInfo != null)
                {
                    strXmlData.Append("<Tree>");
                    string strTableName = objListTableInfo.ListTableName;
                    string strTableAlias = objListTableInfo.ListTableAlias;
                    Guid gTableId = objListTableInfo.TableId;
                    strTableAlias = strTableAlias + "`" + gTableId.ToString().Trim();
                    strXmlData.Append("<Node Text='" + strTableName + "' Value='" + strTableAlias + "' Expanded='True'>");
                    foreach (Skelta.Repository.List.ListDefinition.ListTableInfo infoList in objListTableInfo.ChildTables.Values)
                    {
                        string strChildTableName = infoList.ListTableName;
                        string strChildTableAlias = infoList.ListTableAlias;
                        Guid gChildTableId = objListTableInfo.TableId;
                        strChildTableAlias = strChildTableAlias + "`" + gChildTableId.ToString().Trim();

                        strXmlData.Append("<Node Text='" + strChildTableName + "' Value='" + strChildTableAlias + "'>");
                        if (infoList.ChildTables.Count > 0)
                        {
                            //Call a Generalized method which adds the table directlly
                            AddChildTables(infoList, strXmlData);
                        }
                        strXmlData.Append(" </Node>");
                    }
                    strXmlData.Append(" </Node>");
                }
                strXmlData.Append("</Tree>");
                return strXmlData.ToString().Trim();
            }
            catch (Exception ex)
            {               
                throw;
            }
        }


        private void AddChildTables(ListDefinition.ListTableInfo infoList, System.Text.StringBuilder strXmlData)
        {
            try
            {
                foreach (Skelta.Repository.List.ListDefinition.ListTableInfo infoListChild in infoList.ChildTables.Values)
                {
                    string strChildTableName = infoListChild.ListTableName;
                    string strChildTableAlias = infoListChild.ListTableAlias;
                    Guid gChildTableId = infoListChild.TableId;
                    strChildTableAlias = strChildTableAlias + "`" + gChildTableId.ToString().Trim();

                    strXmlData.Append("<Node Text='" + strChildTableName + "' Value='" + strChildTableAlias + "'>");
                    if (infoListChild.ChildTables.Count > 0)
                    {
                        //Call a Generalized method which adds the table directlly
                        AddChildTables(infoListChild, strXmlData);
                    }
                    strXmlData.Append(" </Node>");
                }
            }
            catch (Exception ex)
            {               
                throw;
            }
        }


        bool IsUserColumn(string columnName)
        {
            if ((!columnName.Equals("Description", StringComparison.InvariantCultureIgnoreCase)) && (!columnName.Equals("Application", StringComparison.InvariantCultureIgnoreCase)) && (!columnName.Equals("CreatedBy", StringComparison.InvariantCultureIgnoreCase)) && (!columnName.Equals("CreatedDateTime", StringComparison.InvariantCultureIgnoreCase)) && (!columnName.Equals("LastUpdatedDateTime", StringComparison.InvariantCultureIgnoreCase)) && (!columnName.Equals("WIP", StringComparison.InvariantCultureIgnoreCase))
                           && (!columnName.Equals("WIPItemId", StringComparison.InvariantCultureIgnoreCase)) && (!columnName.Equals("MainItemId", StringComparison.InvariantCultureIgnoreCase)) && (!columnName.Equals("ParentItemId", StringComparison.InvariantCultureIgnoreCase)) && (!columnName.Equals("RecordParentItemId", StringComparison.InvariantCultureIgnoreCase)) && (!columnName.Equals("TableId", StringComparison.InvariantCultureIgnoreCase)) && (!columnName.Equals("ItemRowIndex", StringComparison.InvariantCultureIgnoreCase)) && (!columnName.Equals("IsLatest", StringComparison.InvariantCultureIgnoreCase)) && (!columnName.Equals("Version", StringComparison.InvariantCultureIgnoreCase))
                           && (!columnName.Equals("VersionHistory", StringComparison.InvariantCultureIgnoreCase)) && (!columnName.Equals("Status", StringComparison.InvariantCultureIgnoreCase)) && (!columnName.Equals("LockedBy", StringComparison.InvariantCultureIgnoreCase)) && (!columnName.Equals("LockedOn", StringComparison.InvariantCultureIgnoreCase)) && (!columnName.Equals("ListID", StringComparison.InvariantCultureIgnoreCase)) && (!columnName.Equals("SecuritySettings", StringComparison.InvariantCultureIgnoreCase)) && (!columnName.Equals("ItemId", StringComparison.InvariantCultureIgnoreCase)) && (!columnName.Equals("ItemType", StringComparison.InvariantCultureIgnoreCase)) && (!columnName.Equals("SecurityItemId", StringComparison.InvariantCultureIgnoreCase)) && (!columnName.Equals("Owner", StringComparison.InvariantCultureIgnoreCase)) && (!columnName.Equals("ModifiedBy", StringComparison.InvariantCultureIgnoreCase)) && (!columnName.Equals("AuditTrail", StringComparison.InvariantCultureIgnoreCase)) && (!columnName.Equals("IsDisabled", StringComparison.InvariantCultureIgnoreCase)) && (!columnName.Equals("SecurityCustomizationId", StringComparison.InvariantCultureIgnoreCase)) && (!columnName.Equals("WorkflowStatus", StringComparison.InvariantCultureIgnoreCase)))
            {
                return true;
            }
            return false;
        }
    }
}