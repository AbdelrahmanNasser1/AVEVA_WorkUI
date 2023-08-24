using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Skelta.Repository.Web;

public partial class BPMUITemplates_Default_Repository_Site_GridViewListControl : System.Web.UI.Page
{
    protected Skelta.Repository.Web.ListControl lcl;
    protected void Page_Load(object sender, EventArgs e)
    {
        lcl = new Skelta.Repository.Web.ListControl();
        lcl.ID = "";
        lcl.Height = Unit.Percentage(100);
        Skelta.Entity.UserContext uContext = new Skelta.Entity.UserContext();
        lcl.LoggedInUserId = uContext.LoggedInUserId;
        lcl.RepositoryName = uContext.Repository.ApplicationName;
        lcl.ListName = "FormDataGrid Views";
        lcl.MenuControlPath = "/Repository/ListControl/GridViewsRibbonBar.ascx";
        lcl.HeaderControlPath = "/Repository/ListControl/ListHeader.ascx";
        lcl.VersionMenuControlPath = "/Repository/ListControl/VersioningRibbonBar.ascx";
        Skelta.Repository.Web.PagCrumbs pg = new Skelta.Repository.Web.PagCrumbs();
        pg.ID = "pageCrumb";
        PanelForm.Controls.Add(pg);
        PanelForm.Controls.Add(lcl);
    }
}