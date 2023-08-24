using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Diagnostics;
using System.Text;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Workflow.NET.ExpressionBuilder;
using Workflow.NET.Web.Designer;
using Workflow.NET;
using Skelta.Repository.Security;

namespace Workflow.NET.Template
{
    /// <summary>
    /// Summary description for FramePage.
    /// </summary>
    public partial class PageScriptExpEditor : System.Web.UI.Page
    {
        protected string DocType = "";
        protected string ipBoxControlName = "";
        private void Page_Load(object sender, System.EventArgs e)
        {

            if ((this.Request.Browser.Browser.ToString().ToLower() == "firefox") && (this.Request.Browser.Version.ToString() == "1.5"))
                DocType = "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">";
            else
               DocType= "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">" ;

            if (Skelta.Repository.Security.CommonFunctions.IsControlValuesValid(Page.Controls) == false)
            {
                throw new XssSecurityException();
            }
        }
        //Added for Localization
        public string GetLangSpecText(string keyName)
        {
            SkeltaResourceSetManager resManager = new SkeltaResourceSetManager();
            string returnText;
            returnText = resManager.GlobalResourceSet.GetString(keyName);
            return returnText;

        }                    
        #region Web Form Designer generated code
        override protected void OnInit(EventArgs e)
        {
            //
            // CODEGEN: This call is required by the ASP.NET Web Form Designer.
            //
            InitializeComponent();
            base.OnInit(e);
        }

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.Load += new System.EventHandler(this.Page_Load);
        }
        #endregion



        }
}
