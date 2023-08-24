using Newtonsoft.Json;
using System.Web.Caching;
using Skelta.Forms2.Web.NextGenForms;
using Skelta.Package.PackageObjects.Common;
using Skelta.Repository.Web.List;
using System.Web.Script.Services;
using System.Web.Services;
using Skelta.Forms2.Web;
using Skelta.Forms2.Web.Common;
using Skelta.HWS;
using System.Web.Caching;
using Newtonsoft.Json;
using Skelta.Core;
using System;

public partial class BPMUITemplates_Default_NextGenForms_PackageService : System.Web.UI.Page
{
    /// <summary>
    /// Gets the new package runtime settings form Definition
    /// </summary>
    /// <returns>the view and view model of the new runtime settings form</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetPackageTemplateSettingsForm(string lcsuri, string repoName, string userId, string packageTemplateId, string packageVersion, string packageListType, string nodeData, string packageOverwrite)
    {
        ListPageParameters listParams = new ListPageParameters();
        listParams.ResolveUriValue(lcsuri);
        return (new SettingsFormHelper()).LoadFormsSettingsForm(listParams, packageTemplateId, packageVersion, packageListType, nodeData, repoName, userId, packageOverwrite);
    }
      
    /// <summary>
    /// Gets the new package runtime settings form Definition
    /// </summary>
    /// <returns>the view and view model of the new runtime settings form</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetManagePackageSettingsForm(string lcsuri, string packageName, string packageVersion, string packageListType, string nodeData)
    {
        ListPageParameters listParams = new ListPageParameters();
        listParams.ResolveUriValue(lcsuri);
        return (new ManagePackageSettingsFormHelper()).LoadManageSettingsForm(listParams, packageName, packageVersion, packageListType, nodeData);
    }
    
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetCurrentContextWithSecurityCheckForList(string secUri, string[] rightCodes, bool forList, string mode, string repoName, string loggedInUserId)
    {
        if (!string.IsNullOrEmpty(secUri))
        {
            return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(Skelta.Forms2.Web.CommonSecurityLib.GetCurrentContextWithSecurityCheck(secUri, rightCodes, forList, mode));
        }
        else
        {
            loggedInUserId = GetLoggedInUserId(repoName, loggedInUserId);
            return SettingsFormHelper.GetNonListItemSecurityCheck(repoName, loggedInUserId);
        }
    }

    /// <summary>
    /// Save Package Settings during design time
    /// </summary>
    /// <param name="xmlInstance">The instance xml</param>
    /// <param name="lcsuri">the encoded uri</param>
    /// <param name="repoName">Repository name</param>
    /// <param name="userId">Logged in user id</param>
    /// <param name="packageVersion">Package version</param>
    /// <param name="packageName">Package name</param>
    /// <param name="nodeData">Node data</param>
    /// <returns>the result whether it was success or failure with details</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string SavePackageSettingsForm(string xmlInstance, string lcsuri, string repoName, string userId, string packageVersion, string packageName, string nodeData)
    {
        ListPageParameters listParams = new ListPageParameters();
        listParams.ResolveUriValue(lcsuri);
        listParams = ResolveUrl(listParams, repoName, userId);
        return (new SettingsFormHelper()).SavePackageSettingsForm(listParams, xmlInstance, packageName, packageVersion, nodeData);
    }

    /// <summary>
    /// Save Package Settings at install time
    /// </summary>
    /// <param name="xmlInstance">The instance xml</param>
    /// <param name="lcsuri">the encoded uri</param>
    /// <returns>the result whether it was success or failure with details</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string SaveManagePackageSettingsForm(string xmlInstance, string lcsuri, string packageVersion, string packageName, string nodeData)
    {
        ListPageParameters listParams = new ListPageParameters();
        listParams.ResolveUriValue(lcsuri);

        return (new ManagePackageSettingsFormHelper()).SaveManagePackageSettingsForm(listParams, xmlInstance, packageName, packageVersion, nodeData);
    }

    /// <returns>a boolean which says the submit was success or not</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetAppName(string secUri)
    {
        ListPageParameters listParams = new ListPageParameters();
        listParams.ResolveUriValue(secUri);
      
        return JsonConvert.SerializeObject(listParams.ApplicationName);
    }

    /// <summary>
    /// Validates the SQL script against restricted commands
    /// </summary>
    /// <param name="sqlScript">SQL script</param>
    /// <returns>the result whether it was success or failure with details</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string IsScriptContainsInvalidCommand(string sqlScript)
    {
        return (new SettingsFormHelper()).IsScriptContainsInvalidCommand(sqlScript);
    }

    /// <summary>
    /// Validates the SQL script against restricted commands
    /// </summary>
    /// <param name="sqlScript">SQL script</param>
    /// <returns>the result whether it was success or failure with details</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string IsScriptContainsInvalidCommandAlterTable(string sqlScript)
    {
        return (new SettingsFormHelper()).IsScriptContainsInvalidCommandAlterTable(sqlScript);
    }

    /// <summary>
    /// Validates the SQL script against restricted commands
    /// </summary>
    /// <param name="sqlScript">SQL script</param>
    /// <param name="sqlScriptFile">SQL script from file</param>
    /// <returns>the result whether it was success or failure with details</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string ValidateSqlScript(string sqlScript, string sqlScriptFile)
    {
        return (new SettingsFormHelper()).ValidateSqlScript(sqlScript, sqlScriptFile);
    }

    /// <summary>
    /// Validates the SQL script against restricted commands
    /// </summary>
    /// <param name="instanceXml">Form instance xml</param>
    /// <returns>the result whether it was success or failure with details</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string ValidateDBScriptInDBConnection(string instanceXml)
    {
        return (new SettingsFormHelper()).ValidateDBScriptInDBConnection(instanceXml);
    }

    /// <summary>
    /// Validates the SQL script against restricted commands with ALTER TABLE command
    /// </summary>
    /// <param name="lcsuri">Lcs uri</param>
    /// <param name="repositoryName">Repository name</param>
    /// <param name="instanceXml">Form instance xml</param>
    /// <param name="userId">Logged in user id</param>
    /// <param name="packageName">Package id</param>
    /// <param name="packageVersion">Package version</param>
    /// <param name="listType">List name</param>
    /// <param name="packageListType">Package list type</param>
    /// <returns>the result whether it was success or failure with details</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string ValidateDBScriptFromInstanceXmlWithAlterTable(string lcsuri, string repositoryName, string instanceXml, string userId, string packageName, string packageVersion, string listType, string packageListType)
    {
        ListPageParameters listParams = new ListPageParameters();
        listParams.ResolveUriValue(lcsuri);
        listParams = ResolveUrl(listParams, repositoryName, userId);
        return (new SettingsFormHelper()).ValidateDBScriptFromInstanceXmlWithAlterTable(listParams, instanceXml, userId, packageName, packageVersion, listType, packageListType);
    }

    /// <summary>
    /// Validates the SQL script of Database Activities against restricted commands with ALTER TABLE command
    /// </summary>
    /// <param name="instanceXml">Form instance xml</param>
    /// <returns>the result whether it was success or failure with details</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string ValidateDBScriptFromInstanceXmlInDatabaseActivities(string instanceXml)
    {
        return (new SettingsFormHelper()).ValidateDBScriptFromInstanceXmlInDatabaseActivities(instanceXml);
    }

    /// <summary>
    /// Get package template
    /// </summary>
    /// <param name="lcsuri">the encoded uri</param>
    /// <returns>list of package templates in JSON format</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetPackageTemplates(string lcsuri)
    {
        ListPageParameters listParams = new ListPageParameters();
        listParams.ResolveUriValue(lcsuri);
        return (new PackageGlobalItemSettingsFormHelper()).GetPackageTemplates(listParams.ApplicationName);
    }

    /// <summary>
    /// Get list of version of package template
    /// </summary>
    /// <param name="lcsuri">the encoded uri</param>
    /// <param name="packageTemplateName">package template name</param>
    /// <returns>list of versions in JSON format</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetPackageTemplateVersions(string lcsuri, string packageTemplateName)
    {
        ListPageParameters listParams = new ListPageParameters();
        listParams.ResolveUriValue(lcsuri);
        return (new PackageGlobalItemSettingsFormHelper()).GetPackageTemplateVersions(listParams.ApplicationName, packageTemplateName);
    }

    /// <summary>
    /// Sets application name and logged in user id for non-list items
    /// </summary>
    /// <param name="listParameter">List page parameters</param>
    /// <param name="repositoryName">Repository name</param>
    /// <param name="loggedUserId">Logged in user id</param>
    /// <returns>List page parameters after setting application name and logged in user id</returns>
    private static ListPageParameters ResolveUrl(ListPageParameters listParameter, string repositoryName, string loggedUserId)
    {
        if (string.IsNullOrEmpty(listParameter.ApplicationName))
        {
            listParameter.ApplicationName = repositoryName;
            loggedUserId = GetLoggedInUserId(repositoryName, loggedUserId);
            listParameter.LoggedInUserId = loggedUserId;
        }

        return listParameter;
    }

    private static string GetLoggedInUserId(string repoName, string loggedInUserId)
    {
        Guid newGuid;
        if (Guid.TryParse(loggedInUserId, out newGuid))
        {
            Actor actor = new Actor(new ApplicationObject(repoName), newGuid);
            loggedInUserId = actor.RealActorId.ToString();
        }

        return loggedInUserId;
    }
}
