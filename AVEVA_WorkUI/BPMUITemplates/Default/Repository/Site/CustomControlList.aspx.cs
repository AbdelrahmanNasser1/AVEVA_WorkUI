using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using Skelta.Forms.Core;
using Skelta.Forms.Core.Controls;
using Skelta.Forms.Web;
using Workflow.NET.Web.Designer;

using Skelta.Repository.Web;


namespace Skelta.Forms.Codebehind
{
    ///<exclude/>
    public partial class CustomControList : System.Web.UI.Page
    {
        //protected Panel PanelForm;
        protected Skelta.Repository.Web.ListControl lcl;
        protected void Page_Load(object sender, EventArgs e)
        {
            lcl = new Skelta.Repository.Web.ListControl();
            lcl.ID = "lclCustomControl";
            Skelta.Entity.UserContext uContext = new Skelta.Entity.UserContext();
            lcl.LoggedInUserId = uContext.LoggedInUserId;
            lcl.RepositoryName = uContext.Repository.ApplicationName;
            lcl.ListName = "Form Controls";
            lcl.MenuControlPath = "/Repository/ListControl/CustomControlsRibbonBar.ascx";
            lcl.HeaderControlPath = "/Repository/ListControl/ListHeader.ascx";            
            Skelta.Repository.Web.PagCrumbs pg = new Skelta.Repository.Web.PagCrumbs();
            lcl.Height = Unit.Percentage(100);
            pg.ID = "pageCrumb";
            PanelForm.Controls.Add(pg);
            PanelForm.Controls.Add(lcl);
        }
    }
}