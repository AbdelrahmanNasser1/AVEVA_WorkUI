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

public partial class BPMUITemplates_Default_Repository_ListControl_SecurityGroupRibbonBar : System.Web.UI.UserControl
{
    protected string ThemeURL = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        Object TEBObject = Workflow.NET.TemplateExpressionBuilder.GetUrl("");
        ThemeURL = TEBObject.ToString();
        TEBObject = null;
    }
    public string GetLangSpecText(string keyName)
    {
        SkeltaResourceSetManager resManager = new SkeltaResourceSetManager();
        string returnText;
        returnText = resManager.GlobalResourceSet.GetString(keyName);
        return returnText;


    }
}
