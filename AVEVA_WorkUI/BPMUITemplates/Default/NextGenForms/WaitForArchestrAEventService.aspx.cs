using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using Skelta.Forms.Core.Controls;
using Skelta.Forms2.Web;
using Skelta.Forms.Web.Common;
using Skelta.Forms2.Web.NextGenForms;
using Skelta.Repository.List.ListInfoExtractor;
using Skelta.Repository.Web.List;
using Workflow.NET;
using Skelta.BPM.ArchestrAEvents;
using Skelta.BPM.ArchestrAEvents.Helpers;
using Skelta.BPM.ArchestrAEvents.Models;
using System.Xml;
using Skelta.Repository.Security;

public partial class BPMUITemplates_Default_Repository_Site_WaitForArchestrAEventService : System.Web.UI.Page
{
    [WebMethod]
    //[ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Xml)]
    public static string GetWorkflowWaitForArchestrAEvent(string applicationName, string selectedAction)
    {
        Workflow.NET.Config config = new Workflow.NET.Config(applicationName);
        if (config.DataSourceType.ToUpperInvariant() == "ORACLE")
        {
            var resourceSet = new Workflow.NET.SkeltaResourceSetManager().GlobalResourceSet;

            throw new Exception(resourceSet.GetString("ASB_OracleNotSupported"));
        }

        var nextGenRenderer = new NextGenRenderer();
        ArchestrAListEventModel formHelper = new ArchestrAListEventModel();
        formHelper.ExpressionRequired = true;
        var baseForm = formHelper.GetWorkflowWaitForArchestrAEvent(new Workflow.NET.SkeltaResourceSetManager().GlobalResourceSet);
        if (baseForm != null)
        {
            if (baseForm.TopLevelForm.RenderDetails.Get("formUniqueKey") == null)
            {
                baseForm.TopLevelForm.RenderDetails.Add("formUniqueKey", Skelta.Forms.Core.Common.GetFormUniqueKey(applicationName, selectedAction + "_ASBEvent", string.Empty));
            }

            var viewAndViewModel = nextGenRenderer.GetSPA(baseForm);
            viewAndViewModel = Skelta.Forms2.Web.CommonFunctions.ProcessLocalization(viewAndViewModel, Skelta.Forms2.Web.CommonFunctions.GetCurrentECCulture);
            return viewAndViewModel;
        }

        return string.Empty;
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string SaveWorkflowWaitForArchestrAEvent(string instanceXml, string applicationName, string userId, string workflowName, string workflowVersion, string actionName, string designerinstanceid, string mode)
    {
        AjaxResponseObject ajaxResponseObject = new AjaxResponseObject();
        try
        {
            XmlValidation validations = new XmlValidation
            {
                AllowEmptyXml = false
            };

            if (!validations.IsValidXml(instanceXml) || !Skelta.Repository.Security.CommonFunctions.IsQueryStringValid(applicationName)
                || !Skelta.Repository.Security.CommonFunctions.IsQueryStringValid(workflowName) || !Skelta.Repository.Security.CommonFunctions.IsQueryStringValid(workflowVersion)
                || !Skelta.Repository.Security.CommonFunctions.IsQueryStringValid(actionName)
                || !Skelta.Repository.Security.CommonFunctions.IsQueryStringValid(designerinstanceid) || !Skelta.Repository.Security.CommonFunctions.IsQueryStringValid(mode))
            {
                ISkeltaResourceSet ResourceSet = new SkeltaResourceSetManager().GlobalResourceSetForNextGenForms;
                ajaxResponseObject.IsSuccess = false;
                ajaxResponseObject.ErrorMessage = ResourceSet.GetString("HtmlAndScript_Error");
                return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(ajaxResponseObject);
            }

            ArchestrAListEventModel formHelper = new ArchestrAListEventModel();
            formHelper.ExpressionRequired = true;
            formHelper.SaveWorkflowWaitForArchestrAEvent(applicationName, userId, workflowName, workflowVersion, actionName, designerinstanceid, instanceXml, mode);
            ajaxResponseObject.IsSuccess = true;
        }
        catch (Exception ex)
        {
            ajaxResponseObject.IsSuccess = false;
            ajaxResponseObject.ErrorMessage = ex.Message;
        }
        return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(ajaxResponseObject);
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetInstanceXmlWaitForArchestrAEvent(string applicationName, string userId, string workflowName, string workflowVersion, string actionName, string designerinstanceid)
    {
        ArchestrAListEventModel formHelper = new ArchestrAListEventModel();
        formHelper.ExpressionRequired = true;
        string instanceXml = formHelper.GetInstanceXmlWaitForArchestrAEvent(applicationName, userId, workflowName, workflowVersion, actionName, designerinstanceid);
        instanceXml = Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(instanceXml);

        return instanceXml;
    }
}
