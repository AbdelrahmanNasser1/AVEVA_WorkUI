//-----------------------------------------------------------------------------
// <copyright file="AssociationService.cs" company="Invensys">
// Copyright (C) Invensys Systems Inc.
// This unpublished copyrighted work contains Trade Secret information
// of Invensys. Use, transfer, disclosure or copying
// without its express written permission is strictly forbidden
// </copyright>
//-----------------------------------------------------------------------------

using Newtonsoft.Json;
using Skelta.Forms.Core.Controls;
using Skelta.Forms2.Web.NextGenForms;
using Skelta.Package.Common;
using Skelta.Repository.List;
using Skelta.Repository.Security;
using Skelta.Repository.Web.List;
using System;
using System.Collections.Generic;
using System.Web.Script.Services;
using System.Web.Services;
using System.Xml;
using Workflow.NET;

public partial class BPMUITemplates_Default_NextGenForms_AssociationService : System.Web.UI.Page
{
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static object GetFormXMLMappingUI(string fxmuri, string Schema, string xmlvariable, string WorkflowInfo, string GridNode, IEnumerable<string> rightCodes)
    {
        var ajaxResponseObject = Skelta.Forms2.Web.CommonSecurityLib.CheckSecurityAndGetPageDefaultsFormXmlMapping(fxmuri, rightCodes);
        if (ajaxResponseObject.IsSuccess)
        {
            return GetMappingUI(fxmuri, Schema, xmlvariable, WorkflowInfo, GridNode, string.Empty);
        }
        else
        {
            return ajaxResponseObject;
        }
    }

    private static object GetMappingUI(string fxmuri, string Schema, string xmlvariable, string WorkflowInfo, string GridNode, string InvokeWorkflowId)
    {
        var listParams = new FormXmlMappingListParameter();
        listParams.ResolveValue(fxmuri);

        string latestFormSchema = string.Empty;
        string workflowSchemaData = string.Empty;
        if (listParams.Mode == "InvokeWorkflow")
        {
            var workflowDetail = WorkflowInfo.Split(Skelta.Forms.Core.Common.WorkflowDetailsDelimiter.ToCharArray(), StringSplitOptions.RemoveEmptyEntries);
            string versionWorkflow = Skelta.Forms2.Web.CommonFunctions.GetWorkflowsVersion(listParams.ApplicationName, workflowDetail[0], workflowDetail[1]);
            listParams.WorkflowName = workflowDetail[0];
            listParams.WorkflowVersion = versionWorkflow;
            var workflowDesigner = new Workflow.NET.Designer(listParams.ApplicationName, workflowDetail[0], versionWorkflow);
            if (workflowDesigner.XMLVariables.ContainsKey(xmlvariable))
            {
                string getCachedInfo = Skelta.Forms2.Web.CommonFunctions.GetCachedKey(listParams.ApplicationName, listParams.ListId.ToString(), Skelta.Forms2.Web.CommonFunctions.StagingDefinitionCacheKey, listParams.VersionStamp);
                BaseForm formDefinition = System.Web.HttpRuntime.Cache[getCachedInfo] as BaseForm;
                InvokeWorkflowSchema invokeWorkflowSchema = (Schema == InvokeWorkflowSchema.DataGrid.ToString()) ? InvokeWorkflowSchema.DataGrid : InvokeWorkflowSchema.FullForm;
                latestFormSchema = Skelta.Forms2.Web.CommonFunctions.GetLatestInvokeWorkflowSchema(formDefinition, invokeWorkflowSchema, listParams.ApplicationName, workflowDetail[0], workflowDetail[1], GridNode);
                if (!Skelta.Forms2.Web.CommonFunctions.CheckXmlSchemaMatches(listParams.ApplicationName, workflowDetail[0], workflowDetail[1], xmlvariable, latestFormSchema))
                {
                    workflowSchemaData = workflowDesigner.XMLVariables[xmlvariable].Schema;
                }
            }

            if (string.IsNullOrEmpty(workflowSchemaData))
            {
                return string.Empty;
            }
        }

        ListDefinition _List = ListDefinition.GetList(new Skelta.Core.ApplicationObject(listParams.ApplicationName), "Forms List");
        Skelta.Repository.List.ListItem item = new Skelta.Repository.List.ListItem(_List, listParams.ListItemId, listParams.VersionStamp);
        BaseForm _dbDefn = ((BaseForm)item.ListForm.Records[0].FindControlByID("_sys_fmdef_new"));
        string formXmlDef = ((ListTextDataItem)_dbDefn.Records[0].FindControlByID("_sys_def_xml")).Value;
        string MappingDefXML = ((ListTextDataItem)_dbDefn.Records[0].FindControlByID("_sys_workflow_mappingdef")).Value;
        string WorkflowVersion = listParams.WorkflowVersion;

        if (listParams.WorkflowVersion == string.Empty)
        {
            Skelta.Repository.List.ListItem workflowListItem = null;
            Skelta.Repository.List.ListDataHandler listHandler = new Skelta.Repository.List.ListDataHandler(listParams.ApplicationName, "Workflow");
            if (listHandler != null)
            {
                workflowListItem = listHandler.GetListItem(listParams.WorkflowName);
                if (workflowListItem != null)
                {
                    WorkflowVersion = workflowListItem.CurrentVersion.VersionStamp;
                }
            }
        }

        var nextGenRenderer = new NextGenRenderer();
        var baseForm = MappingForm.GetFormXmlMappingBaseForm(listParams, xmlvariable, InvokeWorkflowId);
        if (baseForm != null)
        {
            if (baseForm.TopLevelForm.RenderDetails.Get("formUniqueKey") == null)
            {
                baseForm.TopLevelForm.RenderDetails.Add("formUniqueKey", Skelta.Forms.Core.Common.GetFormUniqueKey(listParams.ApplicationName, listParams.ListItemId + "_Association", string.Empty));
            }

            Workflow.NET.Designer designer = new Workflow.NET.Designer(listParams.ApplicationName, listParams.WorkflowName, WorkflowVersion);
            Workflow.NET.XmlVariable XVariableForm = designer.GetFormXmlVariable(formXmlDef, Workflow.NET.Designer.FormType.BaseForm, "SFFormData", "Generated by Skelta Forms", "variables");

            Workflow.NET.Diagram _diagram = Workflow.NET.Diagram.OpenFile(listParams.ApplicationName, listParams.WorkflowName, WorkflowVersion);
            _diagram.PreProcessDiagaram();

            var doc = new XmlDocument();

            var workflowSchema = (listParams.Mode == "InvokeWorkflow") ? workflowSchemaData : _diagram.XmlVariables["SFFormData"].Schema.ToString();
            var FormSchema = (listParams.Mode == "InvokeWorkflow") ? latestFormSchema : XVariableForm.Schema.ToString();

            //// Get Primary Form (Form associated to a workflow without mapping) Details in case of new mapping
            List<string> PrimaryFormDetails = (listParams.Mode == "new") ? MappingForm.GetPrimaryFormDetails(listParams) : null;

            return new
            {
                a = listParams.ApplicationName,
                l = listParams.ListItemId,
                m = listParams.Mode,
                pf = PrimaryFormDetails,
                insXML = MappingDefXML,
                workflowXMLDataSource = Skelta.Forms.Web.Common.AssociationHelper.BuildXmlTree(doc, workflowSchema),
                formXMLDataSource = Skelta.Forms.Web.Common.AssociationHelper.BuildXmlTree(doc, FormSchema),
                af = Skelta.Forms2.Web.CommonFunctions.ProcessLocalization(nextGenRenderer.GetSPA(baseForm), Skelta.Forms2.Web.CommonFunctions.GetCurrentECCulture)
            };
        }

        return string.Empty;
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static object GetFormXMLMappingUIForInvokeWorkflow(string ListId, string ApplicationName, string FormName, string VersionStamp, string ListName, string Schema, string xmlvariable, string WorkflowInfo, string GridNode, string InvokeWorkflowId, IEnumerable<string> rightCodes)
    {
        var formxmlMappingParam = new FormXmlMappingListParameter();
        formxmlMappingParam.ListId = new Guid(ListId);
        formxmlMappingParam.ListItemId = new Guid(ListId);
        formxmlMappingParam.ListName = ListName;
        formxmlMappingParam.VersionStamp = VersionStamp;
        formxmlMappingParam.ApplicationName = ApplicationName;
        formxmlMappingParam.FormName = FormName;
        formxmlMappingParam.LoggedInUserId = new Skelta.Entity.UserContext().LoggedInUserId;
        formxmlMappingParam.Mode = "InvokeWorkflow";

        ListDefinition _List = ListDefinition.GetList(new Skelta.Core.ApplicationObject(ApplicationName), "Forms List");
        Skelta.Repository.List.ListItem item = new Skelta.Repository.List.ListItem(_List, new Guid(ListId), VersionStamp);
        Skelta.Forms.Core.Controls.ListMainForm listForm = (Skelta.Forms.Core.Controls.ListMainForm)item.ListForm.Records[0];
        var listTable = (ListTableForm)listForm.FindControlByID("_sys_fmdef_new");
        var workflowName = ((ListTextDataItem)listTable.Records[0].FindControlByID("_sys_workflow_assn")).Value;
        var formWorkflowVersion = ((ListTextDataItem)listTable.Records[0].FindControlByID("_sys_formdef_filename")).Value;

        if (!string.IsNullOrEmpty(workflowName))
        {
            formxmlMappingParam.WorkflowName = workflowName;
            formxmlMappingParam.WorkflowVersion = formWorkflowVersion;
        }

        string fxmuri = formxmlMappingParam.GetSecuredUriParameter();
        if (!string.IsNullOrEmpty(fxmuri))
        {
            fxmuri = fxmuri.Substring(fxmuri.IndexOf("=") + 1);
            var ajaxResponseObject = Skelta.Forms2.Web.CommonSecurityLib.CheckSecurityAndGetPageDefaultsFormXmlMapping(fxmuri, rightCodes);
            if (ajaxResponseObject.IsSuccess)
            {
                return GetMappingUI(fxmuri, Schema, xmlvariable, WorkflowInfo, GridNode, InvokeWorkflowId);
            }
            else
            {
                return ajaxResponseObject;
            }
        }
        else
        {
            return "Error";
        }
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static object SaveMapping(string formXmlMapUri, string mappingXML)
    {
        var logger = new Log();
        var formxmlMappingParam = new FormXmlMappingListParameter();
        formxmlMappingParam.ResolveValue(formXmlMapUri);
        ListDefinition _List = ListDefinition.GetList(new Skelta.Core.ApplicationObject(formxmlMappingParam.ApplicationName), "Forms List");
        Skelta.Repository.List.ListItem item = new Skelta.Repository.List.ListItem(_List, formxmlMappingParam.ListItemId, formxmlMappingParam.VersionStamp);
        var resourceSet = new Workflow.NET.SkeltaResourceSetManager().GlobalSkeltaResourceSet;

        try {
            XmlValidation validations = new XmlValidation();
            validations.AllowEmptyXml = false;
            if (validations.IsValidXml(mappingXML))
            {
            Skelta.Forms.Web.Common.AssociationHelper.SaveMapping(item, mappingXML, formxmlMappingParam);
            return string.Format(resourceSet.GetString("FormDataMappingSaveSuccess"), item.Title, formxmlMappingParam.WorkflowName, formxmlMappingParam.WorkflowVersion);
            }
            else
            {
                var resourceManager = new Workflow.NET.SkeltaResourceSetManager().GlobalResourceSet;
                return resourceManager.GetString("HtmlAndScript_Error");
            }
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "Error while saving Mapping of Form: " + item.Title + "with Workflow: " + formxmlMappingParam.WorkflowName);
            logger.Close();
        }
        finally
        {
            logger.Close();
        }

        return resourceSet.GetString("FormDataMappingError");
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static object CheckforAssociationandMapping(string lcsuri)
    {
        return Skelta.Forms.Web.Common.AssociationHelper.CheckForAssociationMapping(lcsuri);
    }
}