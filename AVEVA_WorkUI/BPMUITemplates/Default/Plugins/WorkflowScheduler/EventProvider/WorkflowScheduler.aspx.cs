using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Xml;
using System.Xml.Schema;
using System.Text;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Generic;
using Workflow.NET.PropertyTypes;
using Skelta.Events;
using Workflow.NET;
using Skelta.Forms.Core.Controls;
using Skelta.Repository.Web.List;
using Skelta.Repository.Web;
using Skelta.Repository.List;
using Skelta.Repository.List.Action;
using Skelta.Entity;
using Skelta.Core;
using Workflow.NET.Web.Designer;
//using FileEventProvider;
using System.IO;
using Skelta.Events.Interfaces;
using Workflow.NET.Interfaces;
using Workflow.NET.Storage;



public partial class WorkflowScheduler : System.Web.UI.Page
{
    public string VDir = "";
    public string helpimagetags = "";
    public string addedvalue = "";
    protected string cssPath = "";
    protected string imgPath1 = "";
    protected string imgPath2 = "";
    protected string error = "";
    protected string applicationName = "";
    protected string workflowId = "";
    protected object styleUrl = Workflow.NET.TemplateExpressionBuilder.GetUrl("");
    protected object imgUrl1 = Workflow.NET.TemplateExpressionBuilder.GetUrl("Plugins/FileWatcher/Images");
    protected object imgUrl2 = Workflow.NET.TemplateExpressionBuilder.GetUrl("Images");
    protected void Page_Load(object sender, EventArgs e)
    {
        cssPath = styleUrl.ToString();
        imgPath1 = imgUrl1.ToString();
        imgPath2 = imgUrl2.ToString();
    }


    protected string GetLangSpecText(string keyName)
    {
        SkeltaResourceSetManager resManager = new SkeltaResourceSetManager();
        return resManager.GlobalResourceSet.GetString(keyName);
    }
}
