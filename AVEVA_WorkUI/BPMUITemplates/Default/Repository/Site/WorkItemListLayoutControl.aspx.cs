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
using Skelta.HWS.Web.WorkListLayoutControl;
using Skelta.Repository.Security;
using Skelta.Repository.List;
using Skelta.Core;
public partial class SkeltaTemplates_Default_WorkItemList_T : System.Web.UI.Page
{
    /// <summary>
    /// variable is used to get the localized text
    /// </summary>
    protected Workflow.NET.SkeltaResourceSetManager resManager = new Workflow.NET.SkeltaResourceSetManager();
    protected void Page_Load(object sender, EventArgs e)
    {
        

        
        
    }

    protected override void OnInit(EventArgs e)
    {
        string applicationName = string.Empty;
        Skelta.Entity.UserContext uContext = new Skelta.Entity.UserContext();
        Skelta.HWS.Web.WorkListLayoutControl.WorkListLayoutControl globalLayoutContol = new Skelta.HWS.Web.WorkListLayoutControl.WorkListLayoutControl();
        globalLayoutContol.ApplicationName = uContext.Repository.ApplicationName;
        applicationName = uContext.Repository.ApplicationName;
        if (SecurityManager.GetSecurityFlag(uContext.Repository.ApplicationName))
        {
            // check the CanConsumeItem right
            ListDefinition listDef = ListDefinition.GetList(new ApplicationObject(applicationName), "NavigationDetails");
            ListDataHandler ldh = new ListDataHandler(applicationName, "NavigationDetails");
            Guid navigationListId = listDef.Id;
            Guid navigationListItemId = Guid.Empty;
            if (ldh != null)
            {
                navigationListItemId = ldh.GetListItemId("ec_menu_workitem_layout");
            }

            bool CanConsumeRight = Skelta.Repository.Security.SecurityManager.CheckSecurityRight(applicationName, uContext.LoggedInUserId, "CanConsumeItem", navigationListId, navigationListItemId);
            if (!CanConsumeRight)
            {
                string htmlUrl = "blank.htm";
                Page.ClientScript.RegisterStartupScript(Type.GetType("System.String"), "errorMsg", "<script>alert('" + this.resManager.GlobalResourceSet.GetString("NoRight") + "');window.open('" + htmlUrl + "', '_self');</script>");
                return;
            }
        }
       // globalLayoutContol.UserIdString = uContext.LoggedInUserId;
        globalLayoutContol.ID = "WorkItemListLayoutControl";        
        globalLayoutContol.GlobalLayout = true;
        globalLayoutContol.EnableClose = false; 
        globalLayoutContol.Height = Unit.Percentage(100);      
        PanelWorkItemListLayout.Controls.Add(globalLayoutContol);

    }
    
}
