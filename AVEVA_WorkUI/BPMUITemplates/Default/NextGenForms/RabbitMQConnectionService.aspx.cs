using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using Ganss.XSS;
using Skelta.Forms.Core.Controls;
using Skelta.Forms2.Web;
using Skelta.Forms.Web.Common;
using Skelta.Forms2.Web.NextGenForms;
using Skelta.Repository.List;
using Skelta.Repository.List.ListInfoExtractor;
using Skelta.Repository.Web.List;
using Workflow.NET;
using Skelta.BPM.ArchestrAEvents;
using Skelta.BPM.ArchestrAEvents.Helpers;
using Skelta.BPM.ArchestrAEvents.Models;
using SE.Bpm.RabbitMQ.Model;
using SE.Bpm.RabbitMQ.Provider;

public partial class BPMUITemplates_Default_Repository_Site_RabbitMQConnectionService : System.Web.UI.Page
{
    [WebMethod]
    //[ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Xml)]
    public static string GetNewRMQConnection(string lcsuri)
    {        
        var listParams = new ListPageParameters();
        listParams.ResolveUriValue(lcsuri);
        var nextGenRenderer = new NextGenRenderer();
        BaseForm baseForm = RabbitMQListModel.GetRMQConnectionForm();

        //var baseForm = formHelper.GetArchestrAEventForm(new Workflow.NET.SkeltaResourceSetManager().GlobalResourceSet);
        if (baseForm != null)
        {
            if (baseForm.TopLevelForm.RenderDetails.Get("formUniqueKey") == null)
            {
                baseForm.TopLevelForm.RenderDetails.Add("formUniqueKey", Skelta.Forms.Core.Common.GetFormUniqueKey(listParams.ApplicationName, listParams.ListItemId + "_RMQ", string.Empty));
            }

            var viewAndViewModel = nextGenRenderer.GetSPA(baseForm);
            viewAndViewModel = Skelta.Forms2.Web.CommonFunctions.ProcessLocalization(viewAndViewModel, Skelta.Forms2.Web.CommonFunctions.GetCurrentECCulture);
            return viewAndViewModel;
        }

        return string.Empty;
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetInstanceXmlRMQConnection(string lcsuri)
    {
        var listParams = new ListPageParameters();
        listParams.ResolveUriValue(lcsuri);
        RabbitMQListModel formHelper = new RabbitMQListModel();

        string instanceXml = formHelper.GetInstanceXml(listParams.ApplicationName, listParams.ListItemId);
        instanceXml = Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(instanceXml);
        return instanceXml;
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string SaveRMQConnection(string instanceXml, string sv)
    {
        AjaxResponseObject ajaxResponseObject = new AjaxResponseObject();
        try
        {
            var pageParameters = new ListPageParameters();
            pageParameters.ResolveUriValue(sv);

            Skelta.Repository.Security.XmlValidation validation = new Skelta.Repository.Security.XmlValidation();
            validation.AllowEmptyXml = false;
            validation.ConsiderOtherNodesForXSS = true;            

            Skelta.Repository.Security.XmlValidationDetail xmlTitleValidation = GetXssValidationDetail("//RabbitMQConnection/Title");
            xmlTitleValidation.AllowEmptyValue = false;
            validation.ValidationDetails.Add(xmlTitleValidation);

            Skelta.Repository.Security.XmlValidationDetail descValidation = GetXssValidationDetail("//RabbitMQConnection/Description");
            validation.ValidationDetails.Add(descValidation);

            Skelta.Repository.Security.XmlValidationDetail connectionTypeValidation = GetPatternValidationDetail("//RabbitMQConnection/ConnectionType", RegexPatternUtility.RangePattern(0,1,1));
            connectionTypeValidation.AllowEmptyValue = false;
            validation.ValidationDetails.Add(connectionTypeValidation);

            Skelta.Repository.Security.XmlValidationDetail bindingTypeValidation = GetPatternValidationDetail("//RabbitMQConnection/BindingType", RegexPatternUtility.RangePattern(0,2,1));
            bindingTypeValidation.AllowEmptyValue = false;
            validation.ValidationDetails.Add(bindingTypeValidation);

            Skelta.Repository.Security.XmlValidationDetail durableValidation = GetPatternValidationDetail("//RabbitMQConnection/Durable", RegexPatternUtility.BooleanPattern);
            durableValidation.AllowEmptyValue = false;
            validation.ValidationDetails.Add(durableValidation);

            Skelta.Repository.Security.XmlValidationDetail xmlUserValidation = GetXssValidationDetail("//RabbitMQConnection/UserName");
            xmlUserValidation.AllowEmptyValue = true;
            validation.ValidationDetails.Add(xmlUserValidation);

            Skelta.Repository.Security.XmlValidationDetail queueNameValidation = GetXssValidationDetail("//RabbitMQConnection/QueueName");
            queueNameValidation.AllowEmptyValue = false;          
            validation.ValidationDetails.Add(queueNameValidation);

            Skelta.Repository.Security.XmlValidationDetail connectionStringValidation = GetXssValidationDetail("//RabbitMQConnection/ConnectionString");
            connectionStringValidation.AllowEmptyValue = false;
            validation.ValidationDetails.Add(connectionStringValidation);

            validation.ExcludeXPaths.Add("//RabbitMQConnection/Password");

            if (!validation.IsValidXml(instanceXml))
            {
                SkeltaResourceSetManager resManager = new SkeltaResourceSetManager();
                ajaxResponseObject.ErrorMessage = resManager.GlobalResourceSet.GetString("HtmlAndScript_Error");
                ajaxResponseObject.IsSuccess = false;
                return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(ajaxResponseObject);
            }

            RabbitMQListModel formHelper = new RabbitMQListModel();
            if (pageParameters.ActionId != "_sys_new")
            {
                string oldInstanceXml = formHelper.GetInstanceXml(pageParameters.ApplicationName, pageParameters.ListItemId);
                string oldConnectionType = RabbitMQListModel.FindXPathValue(oldInstanceXml, "//RabbitMQConnection/ConnectionType");
                string newConnectionType = RabbitMQListModel.FindXPathValue(instanceXml, "//RabbitMQConnection/ConnectionType");
                if (oldConnectionType != newConnectionType)
                {
                    ListDataHandler ldh = new ListDataHandler(pageParameters.ApplicationName, "RabbitMQConnection");
                    string connectionName = ldh.GetListItemTitle(pageParameters.ListItemId);
                    Tuple<bool, string> deleteStatus = MessageQueueConnectionDeleteHandler.CheckConnectionUsedInWorkflow(pageParameters.ApplicationName, connectionName);
                    ////if (formHelper.IsConnectionUsedInAssociation(pageParameters.ApplicationName, oldInstanceXml, instanceXml, pageParameters.ListItemId))
                    if (!deleteStatus.Item1)
                    {
                        ajaxResponseObject.IsSuccess = false;
                        SkeltaResourceSetManager resManager = new SkeltaResourceSetManager();
                        ////ajaxResponseObject.ErrorMessage = resManager.GlobalResourceSet.GetString("RMQ_ConnectionAssociatedWarning");
                        ajaxResponseObject.ErrorMessage = deleteStatus.Item2;
                        return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(ajaxResponseObject);
                    }
                }
            }
            else
            {
                string title = RabbitMQListModel.FindXPathValue(instanceXml, "//RabbitMQConnection/Title").Trim();
                string sanitizedTitle = (new HtmlSanitizer()).Sanitize(title);
                if (title != sanitizedTitle)
                {
                    ajaxResponseObject.IsSuccess = false;
                    SkeltaResourceSetManager resManager = new SkeltaResourceSetManager();
                    ajaxResponseObject.ErrorMessage = resManager.GlobalResourceSet.GetString("HtmlAndScript_Error");
                    return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(ajaxResponseObject);
                }
            }

            formHelper.SaveRMQConnection(pageParameters.ActionId, pageParameters.ApplicationName, pageParameters.ListItemId, pageParameters.LoggedInUserId, pageParameters.ParentItemId, instanceXml);
            ajaxResponseObject.IsSuccess = true;
        }
        catch (Exception ex)
        {
            ajaxResponseObject.IsSuccess = false;
            ajaxResponseObject.ErrorMessage = string.Empty;
            new Log().LogError(ex, string.Format(CultureInfo.InvariantCulture, "Error while saving RMQ connection"));
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
    public static string GetRabbitMQAssociationForm(string lcsuri)
    {
        var listParams = new ListPageParameters();
        listParams.ResolveUriValue(lcsuri);
        var nextGenRenderer = new NextGenRenderer();
        var baseForm = RabbitMQListModel.GetRMQAssociationForm();
        if (baseForm != null)
        {
            if (baseForm.TopLevelForm.RenderDetails.Get("formUniqueKey") == null)
            {
                baseForm.TopLevelForm.RenderDetails.Add("formUniqueKey", Skelta.Forms.Core.Common.GetFormUniqueKey(listParams.ApplicationName, listParams.ListItemId + "_RMQEvent", string.Empty));
            }

            var viewAndViewModel = nextGenRenderer.GetSPA(baseForm);
            viewAndViewModel = Skelta.Forms2.Web.CommonFunctions.ProcessLocalization(viewAndViewModel, Skelta.Forms2.Web.CommonFunctions.GetCurrentECCulture);
            return viewAndViewModel;
        }

        return string.Empty;
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string SaveRabbitMQAssociation(string instanceXml, string sv)
    {
        AjaxResponseObject ajaxResponseObject = new AjaxResponseObject();
        try
        {
            if (!ValidateMessageQueueAssociation(instanceXml))
            {
                ajaxResponseObject.IsSuccess = false;
                ISkeltaResourceSet resourceManager = new SkeltaResourceSetManager().GlobalResourceSet;
                ajaxResponseObject.ErrorMessage = resourceManager.GetString("HtmlAndScript_Error");
                return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(ajaxResponseObject);
            }
            
            var pageParameters = new ListPageParameters();
            pageParameters.ResolveUriValue(sv);
            RabbitMQListModel formHelper = new RabbitMQListModel();
            formHelper.SaveRabbitMQAssociation(pageParameters.ApplicationName, pageParameters.LoggedInUserId, pageParameters.ListItemId, pageParameters.VersionStamp, instanceXml);
            ajaxResponseObject.IsSuccess = true;
        }
        catch (Exception ex)
        {
            ajaxResponseObject.IsSuccess = false;
            ajaxResponseObject.ErrorMessage = ex.Message;
        }
        return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(ajaxResponseObject);
    }

    /// <summary>
    /// Get Pattern Validation Detail
    /// </summary>
    /// <param name="xpath">xml path </param>
    /// <param name="pattern">pattern string</param>
    /// <returns>returns xml validation detail</returns>
    private static Skelta.Repository.Security.XmlValidationDetail GetPatternValidationDetail(string xpath, string pattern)
    {
        Skelta.Repository.Security.XmlValidationDetail xmlTitleValidation = new Skelta.Repository.Security.XmlValidationDetail();
        xmlTitleValidation.XPath = xpath;
        xmlTitleValidation.ValidationType = Skelta.Repository.Security.TypeOfValidation.PatternBased;
        xmlTitleValidation.Pattern = pattern;
        xmlTitleValidation.IsMatchPattern = true;       
        return xmlTitleValidation;
    }

    /// <summary>
    /// Get Xss ValidationDetail
    /// </summary>
    /// <param name="xpath">xml path</param>    
    /// <returns>returns xml validation detail</returns>
    private static Skelta.Repository.Security.XmlValidationDetail GetXssValidationDetail(string xpath)
    {
        Skelta.Repository.Security.XmlValidationDetail xmlTitleValidation = new Skelta.Repository.Security.XmlValidationDetail();
        xmlTitleValidation.XPath = xpath;
        xmlTitleValidation.ValidationType = Skelta.Repository.Security.TypeOfValidation.XSSCheck;       
        return xmlTitleValidation;
    }

    /// <summary>
    /// Validate Message Queue Association
    /// </summary>
    /// <param name="instanceXml">instance xml</param>
    /// <returns>validation result</returns>
    private static bool ValidateMessageQueueAssociation(string instanceXml)
    {
        Skelta.Repository.Security.XmlValidation validation = new Skelta.Repository.Security.XmlValidation
        {
            AllowEmptyXml = false
        };

        validation.ValidationDetails.Add(new Skelta.Repository.Security.XmlValidationDetail
        {
            AllowEmptyValue = false,
            XPath = "//RMQAssociation/RMQApplicationName",
            ValidationType = Skelta.Repository.Security.TypeOfValidation.XSSCheck
        });

        validation.ValidationDetails.Add(new Skelta.Repository.Security.XmlValidationDetail
        {
            AllowEmptyValue = false,
            XPath = "//RMQAssociation/ConnectionType",
            ValidationType = Skelta.Repository.Security.TypeOfValidation.PatternBased,
            Pattern = "1",
            IsMatchPattern = true
        });

        validation.ValidationDetails.Add(new Skelta.Repository.Security.XmlValidationDetail
        {
            AllowEmptyValue = false,
            XPath = "//RMQAssociation/Connection",
            ValidationType = Skelta.Repository.Security.TypeOfValidation.XSSCheck
        });

        validation.ValidationDetails.Add(new Skelta.Repository.Security.XmlValidationDetail
        {
            AllowEmptyValue = false,
            XPath = "//RMQAssociation/Connection/@DVConnection",
            ValidationType = Skelta.Repository.Security.TypeOfValidation.XSSCheck
        });

        validation.ValidationDetails.Add(new Skelta.Repository.Security.XmlValidationDetail
        {
            AllowEmptyValue = false,
            XPath = "//RMQAssociation/BindingType",
            ValidationType = Skelta.Repository.Security.TypeOfValidation.PatternBased,
            Pattern = "[0-5]",
            IsMatchPattern = true
        });

        validation.ValidationDetails.Add(new Skelta.Repository.Security.XmlValidationDetail
        {
            AllowEmptyValue = true,
            XPath = "//RMQAssociation/XmlSchema",
            ValidationType = Skelta.Repository.Security.TypeOfValidation.XmlDocument,
            Validation = new Skelta.Repository.Security.XmlValidation
            {
                AllowEmptyXml = false
            }
        });

        validation.ValidationDetails.Add(new Skelta.Repository.Security.XmlValidationDetail
        {
            AllowEmptyValue = true,
            XPath = "//RMQAssociation/JSONSample",
            ValidationType = Skelta.Repository.Security.TypeOfValidation.JsonObject,
            Validation = new Skelta.Repository.Security.XmlValidation
            {
                AllowEmptyXml = false
            }
        });

        if (!validation.IsValidXml(instanceXml))
        {
            return false;
        }

        return true;
    }
}
