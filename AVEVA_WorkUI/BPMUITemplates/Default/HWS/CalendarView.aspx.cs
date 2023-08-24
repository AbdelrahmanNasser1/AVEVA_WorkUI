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

public partial class BPMUITemplates_Default_HWS_CalendarView : System.Web.UI.Page
{
    protected string PageTitle = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        SkeltaResourceSet _ObjResSet = new SkeltaResourceSetManager().GlobalResourceSet;
        PageTitle = _ObjResSet.GetString("Calendar View");

        Skelta.HWS.Web.CalendarControl.CalendarControl calendarControl = new Skelta.HWS.Web.CalendarControl.CalendarControl();
        calendarControl.ApplicationName = Request.QueryString["application"];
        calendarControl.ID = "Id";
        Panel1.Controls.Add(calendarControl);
    }
}
