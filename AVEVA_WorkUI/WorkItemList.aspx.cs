using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AVEVA_WorkUI
{
    public partial class WorkItemList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Skelta.Core.ApplicationObject application = new Skelta.Core.ApplicationObject("AVEVA_WorkTasksRepo");//Repository name

            object loggedinUserId = "3A626450-13AD-4A8E-8CFF-0ED37B43A67F";

            Skelta.Entity.UserContext userContext = new Skelta.Entity.UserContext(loggedinUserId, application, "skeltalist");

            Skelta.HWS.WorkListChannel.Web.WorkItemListControl.WorkItemControl wi = new Skelta.HWS.WorkListChannel.Web.WorkItemListControl.WorkItemControl();

            wi.ID = "WorkItemControl"; // This is mandatory.

            wi.ApplicationName = userContext.Repository.ApplicationName; //Provide Application or Repository name. This is mandatory.

            wi.UserIdString = userContext.LoggedInUserId; //Provide user ID string. This is mandatory.

            wi.Height = Unit.Percentage(100);

            wi.Width = Unit.Percentage(100);

            wi.ReadingPaneInPopupWindow = true;

            Panel1.Controls.Add(wi);
        }

    }
}