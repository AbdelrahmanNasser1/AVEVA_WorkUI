using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Security.Application;
using Skelta.Forms.Core.Controls;
using Skelta.Forms2.Web.NextGenForms;

public partial class BPMUITemplates_Default_NextGenForms_Export : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            var applicationName = Skelta.Repository.Security.CommonFunctions.SanitizeValue(Request.QueryString["applicationName"]);
            var formName = Skelta.Repository.Security.CommonFunctions.SanitizeValue(Request.QueryString["formName"]);
            var versionStamp = Skelta.Repository.Security.CommonFunctions.SanitizeValue(Request.QueryString["versionStamp"]);
            var listName = string.Empty;

            if (!string.IsNullOrEmpty(Request.QueryString["listName"]))
            {
                listName = Skelta.Repository.Security.CommonFunctions.SanitizeValue(Request.QueryString["listName"]);
            }

            var exportXmlString = string.Empty;

            if (!string.IsNullOrEmpty(listName) && listName == "Forms List")
            {
                Skelta.Repository.List.ListDataHandler ldh = new Skelta.Repository.List.ListDataHandler(applicationName, listName);
                var item = ldh.GetListItem(formName, versionStamp);
                ListTableForm tableForm = ((ListTableForm)item.ListForm.Records[0].FindControlByID("_sys_fmdef_new"));
                exportXmlString = this.GetFormXMLForExport(tableForm, item);
            }
            else
            {
                ListStructure listStructure = new ListStructure();
                exportXmlString = listStructure.GetListDefinitionXml(formName, applicationName);
            }

            var title = formName.Replace(" ", "_");
            var application = applicationName.Replace(" ", "_");

            Context.Response.Clear();
            Context.Response.AddHeader("content-disposition"
                , "attachment;filename=" + Encoder.HtmlEncode(application) + "_" + Encoder.HtmlEncode(title) + "_" + Encoder.HtmlEncode(versionStamp) + ".xml");

            Context.Response.Write(exportXmlString);
            Context.Response.End();

        }
        catch
        {
        }
    }

    private string GetFormXMLForExport(ListTableForm form, Skelta.Repository.List.ListItem lstItem)
    {
        string formXML = string.Empty;

        if (Skelta.Forms.Core.Common.IsListItemTypeNextGen(lstItem.ItemType))
        {
            formXML = ((ListTextDataItem)form.Records[0].FindControlByID("_sys_tempdef_xml")).Value.ToString();
            if (string.IsNullOrEmpty(formXML))
            {
                formXML = ((ListTextDataItem)form.Records[0].FindControlByID("_sys_def_xml")).Value.ToString();
            }
        }
        return formXML;
    }
}