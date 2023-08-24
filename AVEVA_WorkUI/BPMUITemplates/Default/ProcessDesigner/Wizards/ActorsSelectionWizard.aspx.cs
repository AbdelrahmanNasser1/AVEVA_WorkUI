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

public partial class SkeltaTemplates_Default_ProcessDesigner_Wizards_ActorsSelectionWizard : System.Web.UI.Page
{
    protected Workflow.NET.Web.Designer.ProcessDesigner ProcessDesignerControl=new Workflow.NET.Web.Designer.ProcessDesigner() ;
    protected string actorsSelectionWizardTitle = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        Workflow.NET.SkeltaResourceSetManager resourceManager = new Workflow.NET.SkeltaResourceSetManager();
        actorsSelectionWizardTitle=resourceManager.GlobalResourceSet.GetString("Wiz_ActorsSelectionWizard");        
    }
}
