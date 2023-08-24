//-----------------------------------------------------------------------------
// <copyright file="DataGridColumnEditService.cs" company="Invensys">
// Copyright (C) Invensys Systems Inc.
// This unpublished copyrighted work contains Trade Secret information
// of Invensys. Use, transfer, disclosure or copying
// without its express written permission is strictly forbidden
// </copyright>
//-----------------------------------------------------------------------------

using System;
using System.Collections.Generic;
using System.Web.Script.Services;
using System.Web.Services;
using System.Xml;
using Skelta.Forms2.Web.NextGenForms;
using Skelta.Repository.Web.List;

public partial class BPMUITemplates_Default_NextGenForms_DataGridColumnEditService : System.Web.UI.Page
{
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static object GetDataGridColumnSettingsUI(string gcsuri)
    {
        GridColumnSettingsParameters listParams = new GridColumnSettingsParameters();
        listParams.ResolveValue(gcsuri);

        var nextGenRenderer = new NextGenRenderer();
        var baseForm = DataGridColumnSettings.DataGridColumnSettingsForm(listParams);
        if (baseForm != null)
        {
            if (baseForm.TopLevelForm.RenderDetails.Get("formUniqueKey") == null)
            {
                baseForm.TopLevelForm.RenderDetails.Add("formUniqueKey", Skelta.Forms.Core.Common.GetFormUniqueKey(listParams.ApplicationName, "DataGridColumnSettings", string.Empty));
            }
            return new
            {
                app = listParams.ApplicationName,
                cs = Skelta.Forms2.Web.CommonFunctions.ProcessLocalization(nextGenRenderer.GetSPA(baseForm), Skelta.Forms2.Web.CommonFunctions.GetCurrentECCulture)
            };
        }

        return string.Empty;
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static object GetDataGridEditOperationsUI()
    {
        var nextGenRenderer = new NextGenRenderer();
        var baseForm = DataGridEditOperations.DataGridEditForm();
        string ApplicationName = new Skelta.Entity.UserContext().Repository.ApplicationName;
        if (baseForm != null)
        {
            if (baseForm.TopLevelForm.RenderDetails.Get("formUniqueKey") == null)
            {
                baseForm.TopLevelForm.RenderDetails.Add("formUniqueKey", Skelta.Forms.Core.Common.GetFormUniqueKey(ApplicationName, "DataGridEditOperations", string.Empty));
            }

            return new
            {
                app = ApplicationName,
                gedit = Skelta.Forms2.Web.CommonFunctions.ProcessLocalization(nextGenRenderer.GetSPA(baseForm), Skelta.Forms2.Web.CommonFunctions.GetCurrentECCulture)
            };
        }

        return string.Empty;
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static object UpdateColumnSettingsIngridConfigurationInstanceXml(string columnInstanceXml, string columnSettingsXml, string gcsuri)
    {
        GridColumnSettingsParameters listParams = new GridColumnSettingsParameters();
        listParams.ResolveValue(gcsuri);

        var columnSettingsXmlInstance = Skelta.Forms2.Web.CommonFunctions.UpdateColumnSettingsIngridConfigurationInstanceXml(columnInstanceXml, columnSettingsXml, listParams.Title);
        return columnSettingsXmlInstance;
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static object GetColumnInstanceXml(string columnSettingsXml, string gcsuri)
    {
        GridColumnSettingsParameters listParams = new GridColumnSettingsParameters();
        listParams.ResolveValue(gcsuri);

        var columnSettingsXmlInstance = Skelta.Forms2.Web.CommonFunctions.GetColumnInstanceXml(columnSettingsXml, listParams.Title);
        return columnSettingsXmlInstance;
    }
}