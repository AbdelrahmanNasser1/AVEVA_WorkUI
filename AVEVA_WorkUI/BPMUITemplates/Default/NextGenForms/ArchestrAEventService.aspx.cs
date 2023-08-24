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


public partial class BPMUITemplates_Default_Repository_Site_ArchestrAEventService : System.Web.UI.Page
{
    [WebMethod]
    //[ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Xml)]
    public static string GetNewArchestrAEvent(string lcsuri)
    {
        var listParams = new ListPageParameters();
        listParams.ResolveUriValue(lcsuri);
        var nextGenRenderer = new NextGenRenderer();
        ArchestrAListEventModel formHelper = new ArchestrAListEventModel();
        var baseForm = formHelper.GetArchestrAEventForm(new Workflow.NET.SkeltaResourceSetManager().GlobalResourceSet);
        if (baseForm != null)
        {
            if (baseForm.TopLevelForm.RenderDetails.Get("formUniqueKey") == null)
            {
                baseForm.TopLevelForm.RenderDetails.Add("formUniqueKey", Skelta.Forms.Core.Common.GetFormUniqueKey(listParams.ApplicationName, listParams.ListItemId + "_ASB", string.Empty));
            }

            var viewAndViewModel = nextGenRenderer.GetSPA(baseForm);
            viewAndViewModel = Skelta.Forms2.Web.CommonFunctions.ProcessLocalization(viewAndViewModel, Skelta.Forms2.Web.CommonFunctions.GetCurrentECCulture);
            return viewAndViewModel;
        }

        return string.Empty;
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetInstanceXmlArchestrAEvent(string lcsuri)
    {
        var listParams = new ListPageParameters();
        listParams.ResolveUriValue(lcsuri);
        ArchestrAListEventModel formHelper = new ArchestrAListEventModel();

        string instanceXml = formHelper.GetInstanceXml(listParams.ApplicationName, listParams.ListItemId);
        instanceXml = Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(instanceXml);
        return instanceXml;
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string SaveArchestrAEvent(string instanceXml, string sv)
    {
        AjaxResponseObject ajaxResponseObject = new AjaxResponseObject();
        try
        {
            if (!Skelta.Repository.Security.CommonFunctions.ValidateXmlInstance(instanceXml))
            {
                ajaxResponseObject.IsSuccess = false;
                ISkeltaResourceSet resourceManager = new SkeltaResourceSetManager().GlobalResourceSet;
                ajaxResponseObject.ErrorMessage = resourceManager.GetString("HtmlAndScript_Error");
                return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(ajaxResponseObject);
            }

            var pageParameters = new ListPageParameters();
            pageParameters.ResolveUriValue(sv);
            ArchestrAListEventModel formHelper = new ArchestrAListEventModel();
            formHelper.SaveArchestrAEvent(pageParameters.ActionId, pageParameters.ApplicationName, pageParameters.ListItemId, pageParameters.LoggedInUserId, pageParameters.ParentItemId, instanceXml);
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
    public static string CheckSecurityAndGetPageDefaults(string secUri, IEnumerable<string> rightCodes)
    {
        return Skelta.Forms2.Web.CommonSecurityLib.CheckSecurityAndGetPageDefaults(secUri, rightCodes);
    }

    [WebMethod]
    //[ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Xml)]
    public static string GetWorkflowArchestrAEvent(string lcsuri)
    {
        var listParams = new ListPageParameters();
        listParams.ResolveUriValue(lcsuri);
        var nextGenRenderer = new NextGenRenderer();
        ArchestrAListEventModel formHelper = new ArchestrAListEventModel();
        var baseForm = formHelper.GetWorkflowArchestrAEventForm(new Workflow.NET.SkeltaResourceSetManager().GlobalResourceSet, listParams.ApplicationName, listParams.ListItemId);
        if (baseForm != null)
        {
            if (baseForm.TopLevelForm.RenderDetails.Get("formUniqueKey") == null)
            {
                baseForm.TopLevelForm.RenderDetails.Add("formUniqueKey", Skelta.Forms.Core.Common.GetFormUniqueKey(listParams.ApplicationName, listParams.ListItemId + "_ASBEvent", string.Empty));
            }

            var viewAndViewModel = nextGenRenderer.GetSPA(baseForm);
            viewAndViewModel = Skelta.Forms2.Web.CommonFunctions.ProcessLocalization(viewAndViewModel, Skelta.Forms2.Web.CommonFunctions.GetCurrentECCulture);
            return viewAndViewModel;
        }

        return string.Empty;
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string SaveWorkflowArchestrAEvent(string instanceXml, string sv)
    {
        AjaxResponseObject ajaxResponseObject = new AjaxResponseObject();
        try
        {
            if (!Skelta.Repository.Security.CommonFunctions.ValidateXmlInstance(instanceXml))
            {
                ajaxResponseObject.IsSuccess = false;
                ISkeltaResourceSet resourceManager = new SkeltaResourceSetManager().GlobalResourceSet;
                ajaxResponseObject.ErrorMessage = resourceManager.GetString("HtmlAndScript_Error");
                return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(ajaxResponseObject);
            }

            var pageParameters = new ListPageParameters();
            pageParameters.ResolveUriValue(sv);
            ArchestrAListEventModel formHelper = new ArchestrAListEventModel();
            formHelper.SaveWorkflowArchestrAEvent(pageParameters.ApplicationName, pageParameters.LoggedInUserId, pageParameters.ListItemId, pageParameters.VersionStamp, instanceXml);
            ajaxResponseObject.IsSuccess = true;
        }
        catch (Exception ex)
        {
            ajaxResponseObject.IsSuccess = false;
            ajaxResponseObject.ErrorMessage = ex.Message;
        }
        return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(ajaxResponseObject);
    }

}
