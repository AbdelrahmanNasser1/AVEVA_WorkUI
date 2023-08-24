using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using System.Web.Script.Services;
using System.Web.Services;
using Skelta.Core;
using System.Data;
using Skelta.Repository.Web.Lookup;
using Workflow.NET;

public partial class BPMUITemplates_Default_NextGenForms_UserLookup : System.Web.UI.Page
{
    private static string _applicationName = string.Empty;

    /// <summary>
    /// Gets the available provider list
    /// </summary>
    /// <param name="appName">Application Name</param>
    /// <returns>Provider list</returns>
    [WebMethod()]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string GetProviderList(string appName)
    {
        SkeltaResourceSetManager resourceManager = new SkeltaResourceSetManager();
        _applicationName = appName;
        var entity = Skelta.Entity.Entity.GetEntity(new ApplicationObject(appName), "UserEntity");
        var providerColl = new Skelta.Entity.DataSourceProviderCollection(entity);
        var providersRecords = providerColl.GetRecords();
        var providersList = (from DataRow row in providersRecords.Tables[0].Rows
                             select new Providers
                             {
                                 Name = resourceManager.GlobalResourceSet.GetString(row["DisplayName"].ToString()),
                                 Value = row["InstanceName"].ToString()
                             }).ToList();
        providersList.Insert(0, new Providers() { Name = resourceManager.GlobalResourceSet.GetString("user_lookup_provider_all"), Value = "All Providers" });
        //GetRepoList(appName);
        return Skelta.Forms.Web.CommonFunctions.GetJsonSerializeString(providersList);
    }

    [WebMethod()]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string GetPropertiesList(string providerName)
    {
        if (providerName != "All Providers")
        {
            var userLookUpSearch = new UserLookUpSearch(_applicationName);
            var refDrop = new DropDownList();
            userLookUpSearch.GetProviderSpecificEntityProperties(providerName, ref refDrop);
            var listResource = (from ListItem item in refDrop.Items select new Resources() { Name = item.Text, Value = item.Value }).ToList();
            var json = Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(listResource);
            return json;
        }
        else
        {
            var refDrop = new DropDownList();
            UserLookUpSearch.GetCommonResourceProperties(_applicationName, ref refDrop);
            var listResource = (from ListItem item in refDrop.Items select new Resources() { Name = item.Text, Value = item.Value }).ToList();
            var json = Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(listResource);
            return json;
        }
    }

    [WebMethod()]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string SearchUsers(string searchText, string providerName, string resourceProperties)
    {
        try
        {
            if (providerName == "All Providers")
            {
                providerName = string.Empty;
            }
            var userLookUpSearch = new UserLookUpSearch(_applicationName);
            var response = userLookUpSearch.SearchUsers(searchText, resourceProperties, true, providerName);
            var searchResults = response.Keys.Select(key => new SearchResult()
            {
                Name = response[key],
                Value = key.ToString()
            }).ToList();
            var json = Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(searchResults);
            return json;
        }
        catch (Exception ex)
        {
            return "";
        }
    }

    [WebMethod()]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetVirtualActorId(string userId, string appName)
    {
        _applicationName = appName;
        string vId = string.Empty;

        try
        {
            vId = GetVirtualId(userId);
        }
        catch (Exception ex)
        {
            Workflow.NET.Log log = new Workflow.NET.Log();
            log.LogError(ex, "Error at GetVirtualActorId = " + ex.Message);
        }

        var json = Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(new { vId = vId, uId = userId });
        return json;
    }

    [WebMethod()]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetVirtualRoleId(string roleId, string appName)
    {
        _applicationName = appName;
        string vId = string.Empty;

        try
        {
            vId = GetRoleId(roleId, appName);
        }
        catch (Exception ex)
        {
            Workflow.NET.Log log = new Workflow.NET.Log();
            log.LogError(ex, "Error at GetVirtualRoleId = " + ex.Message);
        }

        var json = Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(new { vId = vId, rId = roleId });
        return json;
    }

    [WebMethod()]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetDisplayText(string virtualId, string applicationName)
    {
        var strNameWithEmail = string.Empty;

        try
        {
            var actorId = new Guid(virtualId);
            if (!actorId.Equals(Guid.Empty))
            {
                var actor = new Skelta.HWS.Actor(new Skelta.Core.ApplicationObject(applicationName), actorId);
                string name = actor.Resource.Properties.Name.Value.ToString();
                string email;
                try
                {
                    email = actor.Resource.Properties.Email.Value.ToString();
                }
                catch { email = ""; }
                if (string.IsNullOrEmpty(email))
                    strNameWithEmail += name;
                else
                    strNameWithEmail += name + " [" + email + "]";
                strNameWithEmail += ";";
            }
        }
        catch (Exception ex)
        {
            SkeltaResourceSetManager resourceManager = new SkeltaResourceSetManager();
            Log log = new Log();
            log.LogError(ex, resourceManager.GlobalResourceSetForNextGenForms.GetString("FormNGFGetDisplayTextErrorUserNotFound").Replace("<@userid@>", virtualId));
        }

        var resultData = strNameWithEmail.EndsWith(";") ? strNameWithEmail.Remove(strNameWithEmail.LastIndexOf(";")) : strNameWithEmail;
        var json = Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(resultData);
        return json;
    }

    [WebMethod()]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string GetDisplayTextForESign(string virtualId, string applicationName)
    {
        string name = string.Empty, actorName = string.Empty, providerDisplayName = string.Empty;

        try
        {
            var entity = Skelta.Entity.Entity.GetEntity(new ApplicationObject(applicationName), "UserEntity");
            var providerColl = new Skelta.Entity.DataSourceProviderCollection(entity);
            var providersRecords = providerColl.GetRecords();

            var actorId = new Guid(virtualId);
            if (!actorId.Equals(Guid.Empty))
            {
                var actor = new Skelta.HWS.Actor(new Skelta.Core.ApplicationObject(applicationName), actorId);
                actorName = actor.Resource.Properties.Name.Value.ToString();
                string providerName = actor.ProviderName;
                providerDisplayName = GetProviderDisplayName(providersRecords.Tables[0].Rows, providerName);
            }
        }
        catch (Exception ex)
        {
            Workflow.NET.Log log = new Workflow.NET.Log();
            log.LogError(ex, "Error at GetDisplayTextForESign = " + ex.Message);
        }

        name = actorName + " [" + providerDisplayName + "]";
        var json = Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(name);
        return json;
    }

    private static string GetProviderDisplayName(DataRowCollection rows, string instanceName)
    {
        var providerInstance = (from DataRow row in rows
                                where row["InstanceName"].ToString() == instanceName
                                select new Providers
                                {
                                    Name = row["DisplayName"].ToString(),
                                    Value = row["InstanceName"].ToString()
                                }).ToList();

        return providerInstance[0].Name.ToString();
    }

    [WebMethod()]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetRoleName(string virtualId, string applicationName)
    {
        string name = string.Empty, providerDisplayName = string.Empty;

        try
        {
            var virtualActor = new Skelta.Core.VirtualRole(new Skelta.Core.ApplicationObject(applicationName));
            name = virtualActor.GetRealRoleName(new Guid(virtualId)).ToString() + ",";
            name = name.EndsWith(",") ? name.Remove(name.LastIndexOf(",")) : name;

            var entity = Skelta.Entity.Entity.GetEntity(new ApplicationObject(applicationName), "UserEntity");
            var providerColl = new Skelta.Entity.DataSourceProviderCollection(entity);
            var providersRecords = providerColl.GetRecords();

            if (name.Contains("::"))
            {
                string[] names = name.Split(new string[1] { "::" }, StringSplitOptions.RemoveEmptyEntries);
                if (names.Length == 2)
                {
                    providerDisplayName = GetProviderDisplayName(providersRecords.Tables[0].Rows, names[0]);
                    name = names[1] + " [" + providerDisplayName + "]";
                }
            }
        }
        catch (Exception ex)
        {
            SkeltaResourceSetManager resourceManager = new SkeltaResourceSetManager();
            Log log = new Log();
            log.LogError(ex, resourceManager.GlobalResourceSetForNextGenForms.GetString("FormNGFGetDisplayTextErrorRoleNotFound").Replace("<@roleid@>", virtualId));
        }

        var json = Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(name);
        return json;
    }

    private static string GetVirtualId(string userId)
    {
        Guid virtualId = Skelta.Forms2.Web.CommonFunctions.GetVirtualActorId(_applicationName, userId);
        return virtualId.ToString();
    }

    public static string GetRoleId(string roleId, string appName)
    {
        var virtualActor = new Skelta.Core.VirtualRole(new Skelta.Core.ApplicationObject(appName));
        return virtualActor.GetVirtualRoleId(roleId).ToString();
    }

    [WebMethod()]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string GetRoles(string searchText, string appName, string provider)
    {
        if (provider == "All Providers")
        {
            provider = string.Empty;
        }

        var roleExecutionContextInfo = new RoleExecutionContextInfo();
        roleExecutionContextInfo.RoleSearchString = searchText;
        RoleExecutionContext.SetRoleExecutionContext(roleExecutionContextInfo);
        var addInProviderCollection = new AddInProviderCollection(new ApplicationObject(appName));
        //Skelta.Entity.RoleEntityProvider.IRoleEntityProvider _ISkeltaRoleProvider = (Skelta.Entity.RoleEntityProvider.IRoleEntityProvider)_AddInProviderCollection.GetProvidersForType(true, "Role")["RoleProvider"];
        var iSkeltaRoleProvider =
            (ISkeltaRoleProvider)addInProviderCollection.GetProvidersForType(true, "Role")["RoleProvider"];
        iSkeltaRoleProvider.ApplicationName = appName;

        iSkeltaRoleProvider.ProviderName = provider;

        string[] roles = iSkeltaRoleProvider.GetAllRoles();

        var entity = Skelta.Entity.Entity.GetEntity(new ApplicationObject(appName), "UserEntity");
        var providerColl = new Skelta.Entity.DataSourceProviderCollection(entity);
        var providersRecords = providerColl.GetRecords();

        var roleList = new List<Roles>();
        foreach (var role in roles)
        {
            var array = role.Split(':');
            string providerDisplayName = GetProviderDisplayName(providersRecords.Tables[0].Rows, array[0]);

            roleList.Add(new Roles() { Name = string.Format("{0} [{1}]", array[2], providerDisplayName), Value = role.ToString() });
        }

        var json = Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(roleList);
        RoleExecutionContext.RemoveRoleExecutionContext();

        return json;
    }

    /// <summary>
    /// Gets extended information of the userlookup
    /// </summary>
    /// <param name="appName">repository name</param>
    /// <param name="uId">logged in user</param>
    /// <returns>serialized extended information</returns>
    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetULookupExtendedInformation(string appName, string uId)
    {
        Guid virtualActorId = new Guid(uId.ToString().Trim());
        return Skelta.Forms2.Web.CommonFunctions.GetULookupExtendedInfo(appName, virtualActorId);
    }
}
public class Providers
{
    public string Name;
    public string Value;
}
public class Resources
{
    public string Name;
    public string Value;
}
public class SearchResult
{
    public string Name;
    public string Value;
}
public class Roles
{
    public string Name;
    public string Value;
}