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
using Skelta.Repository.Web.List;
using Skelta.Repository.List;


namespace ManageViewsRibbonbar
{
    public partial class ManageViewsRibbonbar : System.Web.UI.UserControl
    {
        protected string NewItem_htmlScript = "";
        protected string strListName = "";
        protected string RibbonToolBarWidth = "20%";//If no folder "30%";
        protected bool IsFolderSupported = true;
        protected string ThemeURL = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            //SetActionsHtmlScripts();
            object relativePath = Workflow.NET.TemplateExpressionBuilder.GetUrl("");
            ThemeURL = relativePath.ToString();

            ListPageParameters listParams = new ListPageParameters();
            listParams.ResolveCurrentUri();
            string listName = listParams.ListName;         

            ListDefinition listDLDef = ListDefinition.GetList(new Skelta.Core.ApplicationObject(listParams.ApplicationName), listParams.ListName);
            if (!((Skelta.Forms.Core.Controls.ListMainForm)listDLDef.Definition).IsFolderSupported)
            {
                IsFolderSupported = false;
                RibbonToolBarWidth = "20%";
            }
        }
        private void SetActionsHtmlScripts()
        {
            ListPageParameters listParams = new ListPageParameters();
            listParams.ResolveCurrentUri();
            string listName = listParams.ListName;
            SetListName(listName);

            NewItem_htmlScript = "<tr>";
            //NewItem_htmlScript += " <td height=\"25\" align=\"left\" class=\"runtext3\">";
            //NewItem_htmlScript += "     <img src=\"images/icons-ribbon/leave-skelta.png\" width=\"21\" height=\"21\" hspace=\"2\"  align=\"absmiddle\" />";
            //NewItem_htmlScript += "     <a href=\"javascript:ExecuteAction('_sys_leave_new')\" class=\"runtext3\">" + GetLangSpecText("ec_rbn_wf_leave") + "</a>";
            //NewItem_htmlScript += " </td>";


            //NewItem_htmlScript += SetActionRenderScripts("leave-skelta.png", "_sys_" + listName + "_new", "ec_rbn_" + listName);
            NewItem_htmlScript += SetActionRenderScripts("icon-new-list-item.png", "_sys_new", listName);


            //NewItem_htmlScript += " <td height=\"25\" align=\"left\">";
            //NewItem_htmlScript += "     <img src=\"images/icons-ribbon/folder-icon.png\" width=\"21\" height=\"21\" hspace=\"2\" align=\"absmiddle\" />";
            //NewItem_htmlScript += "     <a href=\"javascript:ExecuteAction('_sys_newcategory')\" class=\"runtext3\">" + GetLangSpecText("ec_rbn_wf_folder") + "</a>";
            //NewItem_htmlScript += " </td>";

            //Folder
            ListDefinition listDLDef = ListDefinition.GetList(new Skelta.Core.ApplicationObject(listParams.ApplicationName), listParams.ListName);
            if (((Skelta.Forms.Core.Controls.ListMainForm)listDLDef.Definition).IsFolderSupported)
                NewItem_htmlScript += SetActionRenderScripts("folder-icon.png", "_sys_newcategory", "ec_rbn_wf_folder");
            NewItem_htmlScript += "</tr>";

        }

        private string SetActionRenderScripts(string imagePath, string execActionParam, string actionNameKey)
        {
            //string imagePath = "leave-skelta.png";
            //string execActionParam = "_sys_leave_new";
            //string actionNameKey="ec_rbn_wf_leave"

            string htmlScript = "";
            htmlScript += " <td height=\"25\" align=\"left\" class=\"runtext3\">";
            htmlScript += "     <img src=\"images/icons-ribbon/" + imagePath + "\" width=\"21\" height=\"21\" hspace=\"2\"  align=\"absmiddle\" />";
            htmlScript += "     <a href=\"javascript:ExecuteAction('" + execActionParam + "')\" class=\"runtext3\">" + GetLangSpecText(actionNameKey) + "</a>";
            htmlScript += " </td>";
            return htmlScript;

        }



        public string GetLangSpecText(string keyName)
        {
            SkeltaResourceSetManager resManager = new SkeltaResourceSetManager();
            string returnText;
            returnText = resManager.GlobalResourceSet.GetString(keyName);
            return returnText;

        }

        protected void SetListName(string listName)
        {
            strListName = listName;
            if (strListName.Length > 17)
                strListName = strListName.Substring(0, 15) + "...";

        }
    }
}