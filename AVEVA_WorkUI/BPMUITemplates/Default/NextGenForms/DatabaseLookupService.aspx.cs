using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using Skelta.Forms.Core.Controls;
using Skelta.Forms.Web.Common;
using Skelta.Forms2.Web.NextGenForms;
using Skelta.Repository.List.ListInfoExtractor;
using Skelta.Repository.Web.List;
using Workflow.NET;
using System.IO;
using System.Xml.Serialization;
public partial class BPMUITemplates_Default_Repository_Site_DatabaseLookupService : System.Web.UI.Page
{
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetNewDBLookup(string lcsuri)
    {
        var listParams = new ListPageParameters();
        listParams.ResolveUriValue(lcsuri);
        var nextGenRenderer = new NextGenRenderer();
        var baseForm = StoredProcedureLookupForm.NewLookupForm(new Workflow.NET.SkeltaResourceSetManager().GlobalResourceSet);
        if (baseForm != null)
        {
            if (baseForm.TopLevelForm.RenderDetails.Get("formUniqueKey") == null)
            {
                baseForm.TopLevelForm.RenderDetails.Add("formUniqueKey", Skelta.Forms.Core.Common.GetFormUniqueKey(listParams.ApplicationName, listParams.ListItemId + "_DB", string.Empty));
            }

            return nextGenRenderer.GetSPA(baseForm);
        }

        return string.Empty;
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static object GetStoredProcedureForm(string lcsuri, string mode)
    {
        var listParams = new ListPageParameters();
        listParams.ResolveUriValue(lcsuri);
        var nextGenRenderer = new NextGenRenderer();
        var connections = StoredProcedureHelper.GetConnections(listParams.ApplicationName, new ListInfoExtractor(), listParams.LoggedInUserId);
        var baseForm = StoredProcedureLookupForm.StoredProcedureLookup(connections, new Workflow.NET.SkeltaResourceSetManager().GlobalResourceSet, mode);
        if (baseForm != null)
        {
            if (baseForm.TopLevelForm.RenderDetails.Get("formUniqueKey") == null)
            {
                baseForm.TopLevelForm.RenderDetails.Add("formUniqueKey", Skelta.Forms.Core.Common.GetFormUniqueKey(listParams.ApplicationName, "_SP", string.Empty));
            }

            var storedProcedureInstanceXml = Guid.Empty.Equals(listParams.ListItemId) ? string.Empty : StoredProcedureHelper.GetStoredProcedureInstanceXml(listParams.ApplicationName, listParams.ListItemId);
            if (Workflow.NET.Config.GetDebugLevel() == 2)
            {
                var logger = new Log();
                logger.LogInformation("Loading form for stored procedure.");
                logger.Close();
            }

            return new
            {
                a = listParams.ApplicationName,
                uid = listParams.LoggedInUserId,
                sp = nextGenRenderer.GetSPA(baseForm),
                i = storedProcedureInstanceXml
            };
        }

        return string.Empty;
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string CheckSecurityAndGetPageDefaults(string secUri, IEnumerable<string> rightCodes)
    {
        return Skelta.Forms2.Web.CommonSecurityLib.CheckSecurityAndGetPageDefaults(secUri, rightCodes);
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetSPColumnsOrParams(string sp, string appName, string cn, string uid, int mt)
    {
        var ajaxObject = new Dictionary<string, object>();
        try
        {
            var dataHandler = Skelta.Forms.Web.CommonFunctions.GetDataHandler(appName, uid, 1, cn);
            var parameters = StoredProcedureHelper.GetDataParameters(sp, dataHandler);
            var parametersList = parameters as IList<IDataParameter> ?? parameters.ToList();
            var inParameters = StoredProcedureHelper.GetDataParameters(parametersList, ParameterDirection.Input);
            var outParameters = StoredProcedureHelper.GetDataParameters(parametersList, ParameterDirection.InputOutput);
            var inputDataParameters = inParameters as IList<IDataParameter> ?? inParameters.ToList();
            var inOutDataParameters = outParameters as IList<IDataParameter> ?? outParameters.ToList();
            if ((inParameters == null || !inputDataParameters.Any()) && (outParameters == null || !inOutDataParameters.Any()))
            {
                return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(StoredProcedureHelper.GetStoredProcedureColumns(new SkeltaResourceSetManager().GlobalResourceSet, sp, inputDataParameters, inOutDataParameters, appName, dataHandler));
            }

            ajaxObject["isSuccess"] = true;
            var inputParameters = StoredProcedureHelper.GetParameters(inputDataParameters);
            var inputOutputParameters = StoredProcedureHelper.GetParameters(inOutDataParameters);
            ajaxObject["parameters"] = inputParameters.Concat(inputOutputParameters);
            if (Workflow.NET.Config.GetDebugLevel() == 2)
            {
                var logger = new Log();
                logger.LogInformation("Loading columns or parameters for stored procedure (" + sp + ").");
                logger.Close();
            }

            return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(ajaxObject);
        }
        catch (System.Exception e)
        {
            var logger = new Log();
            logger.LogError(e, "Error while getting the Data handler for connection: " + cn, appName);
            logger.Close();
            ajaxObject["isSuccess"] = false;
            ajaxObject["errorMessage"] = e.Message;
        }

        return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(ajaxObject);
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string GetSPColumnsUsingParameters(string sp, string appName, string cn, string uid, int mt, IEnumerable<LookupParameter> ip)
    {
        var ajaxObject = new Dictionary<string, object>();
        try
        {
            var dataHandler = Skelta.Forms.Web.CommonFunctions.GetDataHandler(appName, uid, 1, cn);
            var parameters = StoredProcedureHelper.GetDataParameters(sp, dataHandler);
            var parametersList = parameters as IList<IDataParameter> ?? parameters.ToList();
            var inParameters = StoredProcedureHelper.GetDataParameters(parametersList, ParameterDirection.Input);
            var updatedInParameters = StoredProcedureHelper.UpdateValueForDataParameters(ip, inParameters);
            var outParameters = StoredProcedureHelper.GetDataParameters(parametersList, ParameterDirection.InputOutput);
            if (Workflow.NET.Config.GetDebugLevel() == 2)
            {
                var logger = new Log();
                logger.LogInformation("Loading columns using parameters for stored procedure (" + sp + ").");
                logger.Close();
            }

            return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(StoredProcedureHelper.GetStoredProcedureColumns(new SkeltaResourceSetManager().GlobalResourceSet, sp, updatedInParameters, outParameters, appName, dataHandler));
        }
        catch (System.Exception e)
        {
            var logger = new Log();
            logger.LogError(e, "Error while getting the Data handler for connection: " + cn, appName);
            logger.Close();
            ajaxObject["isSuccess"] = false;
            ajaxObject["errorMessage"] = e.Message;
        }

        return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(ajaxObject);
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string SaveStoredProcedure(dynamic spd, string sv)
    {
        var logger = new Log();
        var resourceSet = new Workflow.NET.SkeltaResourceSetManager().GlobalResourceSetForNextGenForms;
        Skelta.Forms2.Web.AjaxResponseObject ajaxResponseObject = new Skelta.Forms2.Web.AjaxResponseObject();
        ajaxResponseObject.IsSuccess = true;

        try
        {
            var storedProcedureData = spd as Dictionary<string, object>;
            var pageParameters = new ListPageParameters();
            pageParameters.ResolveUriValue(sv);
            var configDetails = storedProcedureData["ConfigurationDetails"].ToString();
            storedProcedureData["ConfigurationDetails"] = configDetails;
            if (Workflow.NET.Config.GetDebugLevel() == 2)
            {
                string action = pageParameters.ActionId == "_sys_edit" ? "edited" : "created";
                string userName = Skelta.Forms.Web.CommonFunctions.GetActorName();
                string message = string.Empty;
                if (pageParameters.ActionId == "_sys_edit")
                {
                    message = resourceSet.GetString("FormNGFSPUpdated");
                }
                else
                {
                    message = resourceSet.GetString("FormNGFSPCreated");
                }

                message = message.Replace("<@paramSPName@>", Convert.ToString(storedProcedureData["Title"])).Replace("<@paramUserName@>", userName).Replace("<@paramTime@>", DateTime.Now.ToString());
                logger.LogInformation(message);
            }

            var result = StoredProcedureHelper.SaveStoredProcedureLookup(pageParameters.ActionId, pageParameters.ApplicationName, pageParameters.ListItemId, pageParameters.LoggedInUserId, pageParameters.ParentItemId, storedProcedureData);

            ajaxResponseObject.IsSuccess = result.Item1;
            // Using ErrorMessage member to show the UI Message on the client side.
            ajaxResponseObject.ErrorMessage = result.Item2.Trim();
        }
        catch (Exception ex)
        {
            ajaxResponseObject.IsSuccess = false;
            ajaxResponseObject.ErrorMessage = resourceSet.GetString("FormNGFErrorStoredProcedureSaveError");
            logger.LogError(ex, ajaxResponseObject.ErrorMessage);
        }
        finally
        {
            logger.Close();
        }

        return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(ajaxResponseObject);
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetInstanceXml(string lcsuri)
    {
        var pageParameters = new ListPageParameters();
        pageParameters.ResolveUriValue(lcsuri);
        var instanceXml = StoredProcedureHelper.GetStoredProcedureInstanceXml(pageParameters.ApplicationName, pageParameters.ListItemId);
        return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(instanceXml);
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static object ValidateLookupTitle(string title, string appName)
    {
        var isLookupPresent = !StoredProcedureHelper.IsLookupItemPresent(title, appName, new ListInfoExtractor());
        var ishavingSpecialCharacters = DBLookupCommonUtility.ValidateIfLookupTitleHasSpecialCharacter(title);
        var startsWithNumber = DBLookupCommonUtility.ValidateIfLookupTitleStartsWithNumber(title);
        var startsWithsys = DBLookupCommonUtility.ValidateIfLookupStartsWithSys(title);
        return new
        {
            p = isLookupPresent,
            s = ishavingSpecialCharacters,
            n = startsWithNumber,
            sys = startsWithsys
        };
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static object GetActionBasedOnItemType(string itemType, string app)
    {
        return Skelta.Forms.Web.CommonFunctions.GetEditActionBasedOnItemType(itemType, app);
    }
}
