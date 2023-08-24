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

public partial class SkeltaTemplates_Default_ProcessDesigner_NavigatorWindow : System.Web.UI.Page
{
    protected string strRefresh = "";
    protected string strZoomLevel = "";
    protected string cssPath="";
    protected string pageTitle = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        object relativePath = Workflow.NET.TemplateExpressionBuilder.GetUrl("Common/");
        cssPath = relativePath.ToString();
        
        Workflow.NET.SkeltaResourceSetManager resourceManager = new Workflow.NET.SkeltaResourceSetManager();
        strRefresh = resourceManager.GlobalResourceSet.GetString("Refresh");
        strZoomLevel = resourceManager.GlobalResourceSet.GetString("Zoom Level");
        pageTitle = resourceManager.GlobalResourceSet.GetString("Process Map Image for Navigation");

    }
}
