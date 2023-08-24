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
public partial class BPMUITemplates_Default_Repository_Site_Filewatcherfolder : System.Web.UI.Page
{



    protected void Page_Init(object sender, EventArgs e)
    {
        string ApplicationName = "";
        UserContext UserCtx;
        try
        {
            ////Accessing the user context values set during the login.
            UserCtx = new UserContext();
            ApplicationName = UserCtx.Repository.ApplicationName;

            ListControl1.RepositoryName = ApplicationName;
            ListControl1.ListName = "FileWatcher List";

            ListControl1.LoggedInUserId = UserCtx.LoggedInUserId;
            ListControl1.FilterColumn = "";
            ListControl1.FilterValue = "";
        }
        catch (Exception ex)
        {
        }
    
    
    }
    protected void Page_Load()
    {
       


    }
}
