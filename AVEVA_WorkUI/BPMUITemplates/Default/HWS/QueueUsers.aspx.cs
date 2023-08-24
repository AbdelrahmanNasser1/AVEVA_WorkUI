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

public partial class BPMUITemplates_Default_HWS_QueueUsers : System.Web.UI.Page
{
    protected string QueueTitle = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        SkeltaResourceSet _ObjResSet = new SkeltaResourceSetManager().GlobalResourceSet;
        QueueTitle = _ObjResSet.GetString("Queue");

        Skelta.HWS.Web.QueueControl.QueueControl queueControl = new Skelta.HWS.Web.QueueControl.QueueControl();
        queueControl.ApplicationName = Request.QueryString["application"];
        queueControl.ID = "Id";
        string UseridString = Request.QueryString["userId"];
        UseridString = UseridString.Replace("\\\\", @"\").Replace("amp;", "&");
        queueControl.UserId = (object)UseridString;
        Panel1.Controls.Add(queueControl);
    }
}
