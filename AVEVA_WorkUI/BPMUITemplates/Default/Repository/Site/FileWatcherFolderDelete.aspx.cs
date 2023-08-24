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
using Skelta.Repository.List;
using Skelta.Repository.Web.List;
using Skelta.Forms.Core.Controls;
using Workflow.NET;
using Workflow.NET.Storage;
using Workflow.NET.DataHandler;
using Workflow.NET.Interfaces;
public partial class FileWatcherFolderDelete : System.Web.UI.Page
{
    static string _Repository;
    string SqlQuery = "";
    static Guid _ListGuid = Guid.Empty;
    static DataTable dtAssemblyItems;
    static string _ListName;
    protected Workflow.NET.SkeltaResourceSet GR = new Workflow.NET.SkeltaResourceSetManager().GlobalResourceSet;

    
    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {
            if (!this.Page.IsPostBack)
            {
                ListPageParameters listParams = new ListPageParameters();
                listParams.ResolveCurrentUri();
                _ListGuid = listParams.ListItemId;
                _ListName = listParams.ListName;
                _Repository = listParams.ApplicationName;

                Button1.Text = GR.GetString("ec_filewatcher_yes");
                Button2.Text = GR.GetString("ec_filewatcher_no");
                CloseButton.Text = GR.GetString("ec_filewatcher_close");
            }
        }
        catch (Exception ex)
        {
           // Alert(GR.GetString("soa_ErrorInFolderInfo"));
        }

    }




    protected void Button1_Click(object sender, EventArgs e)
    {

        try
        {
            
            ListDefinition ld = new ListDefinition(new Skelta.Core.ApplicationObject(_Repository), "FileWatcher List");
            IDataHandler dbhandler = DataHandlerFactory.GetDataHandler(ld.Configuration);
            IDataParameter paramId = dbhandler.GetParameter("@Id", _ListGuid);
           
            SqlQuery = "Select FolderName from  SKFWFolderList " +
                           "WHERE Id =@Id";//'" + id + "' ";
            using (dbhandler)
            {
                dtAssemblyItems = dbhandler.ReadData(SqlQuery, paramId);
            }
            string strName = dtAssemblyItems.Rows[0]["foldername"].ToString();
            IDataHandler dbhandler1 = DataHandlerFactory.GetDataHandler(ld.Configuration);
            IDataParameter paramId1 = dbhandler1.GetParameter("@name", strName);
            SqlQuery = "Select Id from  SKEventServicePorts " +
                                       "WHERE Name =@name";
            dtAssemblyItems = null;
            
            using (dbhandler1)
            {
                dtAssemblyItems = dbhandler1.ReadData(SqlQuery, paramId1);
            }
            Guid idPort=new Guid (dtAssemblyItems.Rows[0]["id"].ToString());  

            SqlQuery = "SELECT * FROM SKEventBindings ";
            SqlQuery += "WHERE PortGuid=@Parms";
            IDataHandler dbhandler3 = DataHandlerFactory.GetDataHandler(ld.Configuration);
            IDataParameter GuidParam = dbhandler3.GetParameter("@Parms", idPort);
            DataTable temp = null;
            
            using (dbhandler3)
            {

                temp = dbhandler3.ReadData(SqlQuery, GuidParam);

            }
                        

            if (temp.Rows.Count > 0)
            {
                ConfirmPanel.Visible = false;
                DelPanel.Visible = true;
                DeleteMessage.Text = GR.GetString("ec_filewatcher_AsssociationExists");
            }
            else
            {
                try
                {
                    dtAssemblyItems = null;
                    IDataHandler dbhandler4 = DataHandlerFactory.GetDataHandler(ld.Configuration);
                    IDataParameter paramId2 = dbhandler4.GetParameter("@Id", _ListGuid);
                    SqlQuery = "Delete SKFWFolderList " +
                                "WHERE Id =@Id";//'" + id + "' ";
                    using (dbhandler4)
                    {
                        dtAssemblyItems = dbhandler4.ReadData(SqlQuery, paramId2);
                    }
                    IDataHandler dbhandler5 = DataHandlerFactory.GetDataHandler(ld.Configuration);
                    IDataParameter paramId3 = dbhandler5.GetParameter("@Id", idPort);

                    dtAssemblyItems = null;
                    SqlQuery = "Delete SKEventServicePorts " +
                                "WHERE Id =@Id";//'" + id + "' ";
                    using (dbhandler5)
                    {
                        dtAssemblyItems = dbhandler5.ReadData(SqlQuery, paramId3);
                    }
                    ConfirmPanel.Visible = false;
                    DelPanel.Visible = true;
                    DeleteMessage.Text = GR.GetString("ec_filewatcher_PortDeleted");
                }
                catch (Exception)
                {
                    ConfirmPanel.Visible = false;
                    DelPanel.Visible = true;
                    DeleteMessage.Text = GR.GetString("ec_filewatcher_Port_unable_del");
                }
            }



        }
        catch (Exception Ex)
        {
            ConfirmPanel.Visible = false;
            DelPanel.Visible = true;
            DeleteMessage.Text = GR.GetString("ec_filewatcher_error");
        }



    }
}
