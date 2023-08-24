using System;
using System.Collections.Generic;
using System.Linq;
using System.Globalization;
using System.Web.Script.Services;
using System.Web.Services;
using Skelta.Forms2.Web.Common;
using Skelta.Forms2.Web.NextGenForms;
using Skelta.Repository.Web.List;
using Skelta.Forms2.Web;
using Skelta.Forms.Core;
using Workflow.NET;

public partial class BPMUITemplates_Default_Repository_Site_CommonService : System.Web.UI.Page
{
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string CheckSecurityAndGetPageDefaults(string secUri, IEnumerable<string> rightCodes)
    {
        return CommonSecurityLib.CheckSecurityAndGetPageDefaults(secUri, rightCodes);
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static object GetParametersMappingUI(string secUri, IEnumerable<string> lookups, string application, string userId)
    {
        ISkeltaResourceSet resourceSet = new Workflow.NET.SkeltaResourceSetManager().GlobalResourceSetForNextGenForms;
        try
        {
            var pageParameters = new ListPageParameters();
            pageParameters.ResolveUriValue(secUri);
            var key = Common.GetFormUniqueKey(pageParameters.ApplicationName, Convert.ToString(pageParameters.ListItemId, CultureInfo.InvariantCulture), "_PM");
            var parameterMappingBaseform = GridConfigurationHelper.GetViewAndViewModelForParametersMapping(new Workflow.NET.SkeltaResourceSetManager().GlobalResourceSet, key);
            var configurationHelper = new GridConfigurationHelper();
            return new
            {
                Definition = new NextGenRenderer().GetSPA(parameterMappingBaseform),
                Levels = configurationHelper.GetAllLevels(application, userId, lookups),
                Key = key,
                IsSuccess = true,
                ErrorMessage = string.Empty
            };
        }
        catch (Exception ex)
        {
            string errMsg = resourceSet.GetString("err_parameter_mapping_ui");
            var log = new Log();
            log.LogError(ex, errMsg);

            return new
            {
                IsSucess = false,
                ErrorMessage = errMsg
            };
        }
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string CheckParametersExistsForLookup(string secUri, IEnumerable<string> lookups)
    {
        var pageParameters = new ListPageParameters();
        pageParameters.ResolveUriValue(secUri);
        foreach (var lookup in lookups)
        {
            var parameters = LookupHelper.LookupParameters(pageParameters.ApplicationName, pageParameters.LoggedInUserId, lookup);
            if (parameters.Count() == 0)
            {
                return lookup;
            }
        }

        return string.Empty;
    }
}
