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
namespace Skelta.Repository.Web.CodeBehind
{
    public partial class GridViewsRibbonBar : System.Web.UI.UserControl
    {
        protected string templateThemeDirectory = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            templateThemeDirectory = Convert.ToString(Workflow.NET.TemplateExpressionBuilder.GetUrl(""));
        }

        public string GetLangSpecText(string keyName)
        {
            SkeltaResourceSetManager resManager = new SkeltaResourceSetManager();
            string returnText;
            returnText = resManager.GlobalResourceSet.GetString(keyName);
            return returnText;


        }
    }
}