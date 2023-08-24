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
using SE.Bpm.RabbitMQ.Model;

public partial class WaitForRabbitMQService : System.Web.UI.Page
{
    [WebMethod]
    //[ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Xml)]
    public static string GetWorkflowWaitForRabbitMQ(string applicationName, string selectedAction)
    {
        ///var listParams = new ListPageParameters();
        ///listParams.ResolveUriValue(lcsuri);
        var nextGenRenderer = new NextGenRenderer();
        var baseForm = RabbitMQListModel.GetRMQWaitForMessageForm();
        if (baseForm != null)
        {
            if (baseForm.TopLevelForm.RenderDetails.Get("formUniqueKey") == null)
            {
                baseForm.TopLevelForm.RenderDetails.Add("formUniqueKey", Skelta.Forms.Core.Common.GetFormUniqueKey(applicationName, selectedAction + "_RMQEvent", string.Empty));
            }

            var viewAndViewModel = nextGenRenderer.GetSPA(baseForm);
            viewAndViewModel = Skelta.Forms2.Web.CommonFunctions.ProcessLocalization(viewAndViewModel, Skelta.Forms2.Web.CommonFunctions.GetCurrentECCulture);
            return viewAndViewModel;
        }

        return string.Empty;
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string SaveWorkflowWaitForRabbitMQMessage(string instanceXml, string applicationName, string userId, string workflowName, string workflowVersion, string actionName, string designerinstanceid, string mode)
    {
        AjaxResponseObject ajaxResponseObject = new AjaxResponseObject();
        try
        {
            if (!ValidateWaitForRabbitMQMessage(instanceXml) || !Skelta.Repository.Security.CommonFunctions.IsQueryStringValid(applicationName) || !Skelta.Repository.Security.CommonFunctions.IsQueryStringValid(userId) || !Skelta.Repository.Security.CommonFunctions.IsQueryStringValid(workflowName) || !Skelta.Repository.Security.CommonFunctions.IsQueryStringValid(workflowVersion) || !Skelta.Repository.Security.CommonFunctions.IsQueryStringValid(actionName) || !Skelta.Repository.Security.CommonFunctions.IsQueryStringValid(designerinstanceid) || !Skelta.Repository.Security.CommonFunctions.IsQueryStringValid(mode))
            {
                ajaxResponseObject.IsSuccess = false;
                ISkeltaResourceSet resourceManager = new SkeltaResourceSetManager().GlobalResourceSet;
                ajaxResponseObject.ErrorMessage = resourceManager.GetString("HtmlAndScript_Error");
                return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(ajaxResponseObject);
            }

            RabbitMQListModel formHelper = new RabbitMQListModel();
            ////formHelper.ExpressionRequired = true;
            formHelper.SaveWorkflowWaitForRabbitMQMessage(applicationName, userId, workflowName, workflowVersion, actionName, designerinstanceid, instanceXml, mode);
            ajaxResponseObject.IsSuccess = true;
        }
        catch (Exception ex)
        {
            ajaxResponseObject.IsSuccess = false;
            ajaxResponseObject.ErrorMessage = ex.Message;
        }
        return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(ajaxResponseObject);
        return string.Empty;
    }

    /// <summary>
    /// Validate Wait For RabbitMQ Message instance xml
    /// </summary>
    /// <param name="instanceXml">instance xml</param>
    /// <returns>validation result</returns>
    private static bool ValidateWaitForRabbitMQMessage(string instanceXml)
    {
        Skelta.Repository.Security.XmlValidation validation = new Skelta.Repository.Security.XmlValidation
        {
            AllowEmptyXml = false
        };

        validation.ValidationDetails.Add(new Skelta.Repository.Security.XmlValidationDetail
        {
            AllowEmptyValue = false,
            XPath = "//RMQEventFilter/RMQApplicationName",
            ValidationType = Skelta.Repository.Security.TypeOfValidation.XSSCheck
        });

        validation.ValidationDetails.Add(new Skelta.Repository.Security.XmlValidationDetail
        {
            AllowEmptyValue = false,
            XPath = "//RMQEventFilter/ConnectionType",
            ValidationType = Skelta.Repository.Security.TypeOfValidation.PatternBased,
            Pattern = "[0-1]",
            IsMatchPattern = true
        });

        validation.ValidationDetails.Add(new Skelta.Repository.Security.XmlValidationDetail
        {
            AllowEmptyValue = false,
            XPath = "//RMQEventFilter/Connection",
            ValidationType = Skelta.Repository.Security.TypeOfValidation.XSSCheck
        });

        validation.ValidationDetails.Add(new Skelta.Repository.Security.XmlValidationDetail
        {
            AllowEmptyValue = false,
            XPath = "//RMQEventFilter/Connection/@DVConnection",
            ValidationType = Skelta.Repository.Security.TypeOfValidation.XSSCheck
        });

        validation.ValidationDetails.Add(new Skelta.Repository.Security.XmlValidationDetail
        {
            AllowEmptyValue = false,
            XPath = "//RMQEventFilter/BindingType",
            ValidationType = Skelta.Repository.Security.TypeOfValidation.PatternBased,
            Pattern = "[0-5]",
            IsMatchPattern = true
        });

        validation.ValidationDetails.Add(new Skelta.Repository.Security.XmlValidationDetail
        {
            AllowEmptyValue = true,
            XPath = "//RMQEventFilter/XmlSchema",
            ValidationType = Skelta.Repository.Security.TypeOfValidation.XmlDocument,
            Validation = new Skelta.Repository.Security.XmlValidation
            {
                AllowEmptyXml = false
            }
        });

        validation.ValidationDetails.Add(new Skelta.Repository.Security.XmlValidationDetail
        {
            AllowEmptyValue = true,
            XPath = "//RMQEventFilter/JSONSample",
            ValidationType = Skelta.Repository.Security.TypeOfValidation.JsonObject,
            Validation = new Skelta.Repository.Security.XmlValidation
            {
                AllowEmptyXml = false
            }
        });

        validation.ExcludeXPaths.Add("//RMQEventFilter/MessageType");
        validation.ExcludeXPaths.Add("//RMQEventFilter/XPath");
        validation.ExcludeXPaths.Add("//RMQEventFilter/XPathValue");
        validation.ExcludeXPaths.Add("//RMQEventFilter/JSONPath");
        validation.ExcludeXPaths.Add("//RMQEventFilter/JSONPathValue");

        if (!validation.IsValidXml(instanceXml))
        {
            return false;
        }

        return true;
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetInstanceXmlWaitForRabbitMQMessage(string applicationName, string userId, string workflowName, string workflowVersion, string actionName, string designerinstanceid)
    {
        string instanceXml = RabbitMQListModel.GetInstanceXmlWaitForRabbitMQMessage(applicationName, userId, workflowName, workflowVersion, actionName, designerinstanceid);
        instanceXml = Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(instanceXml);
        return instanceXml;
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    public static string GetInstanceXmlForCallRabbitMQ(string applicationName, string userId, string workflowName, string workflowVersion, string actionName, string designerinstanceid)
    {
        string instanceXml = RabbitMQListModel.GetInstanceXmlForCallRabbitMQ(applicationName, userId, workflowName, workflowVersion, actionName, designerinstanceid);
        instanceXml = Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(instanceXml);
        return instanceXml;
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Xml)]
    public static string GetPropertyBaseFormForCallRabbitMQ(string applicationName, string selectedAction)
    {
        var nextGenRenderer = new NextGenRenderer();
        var baseForm = RabbitMQListModel.GetBaseFormForCallRMQ();
        if (baseForm != null)
        {
            if (baseForm.TopLevelForm.RenderDetails.Get("formUniqueKey") == null)
            {
                baseForm.TopLevelForm.RenderDetails.Add("formUniqueKey", Skelta.Forms.Core.Common.GetFormUniqueKey(applicationName, selectedAction + "_CallRMQ", string.Empty));
            }

            var viewAndViewModel = nextGenRenderer.GetSPA(baseForm);
            viewAndViewModel = Skelta.Forms2.Web.CommonFunctions.ProcessLocalization(viewAndViewModel, Skelta.Forms2.Web.CommonFunctions.GetCurrentECCulture);
            return viewAndViewModel;
        }

        return string.Empty;
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
    public static string SavePropertyBaseFormForCallRabbitMQ(string instanceXml, string applicationName, string userId, string workflowName, string workflowVersion, string actionName, string designerinstanceid, string mode)
    {
        AjaxResponseObject ajaxResponseObject = new AjaxResponseObject();
        try
        {
            if (!ValidateCallRabbitMQ(instanceXml) || !Skelta.Repository.Security.CommonFunctions.IsQueryStringValid(applicationName) || !Skelta.Repository.Security.CommonFunctions.IsQueryStringValid(userId) || !Skelta.Repository.Security.CommonFunctions.IsQueryStringValid(workflowName) || !Skelta.Repository.Security.CommonFunctions.IsQueryStringValid(workflowVersion) || !Skelta.Repository.Security.CommonFunctions.IsQueryStringValid(actionName) || !Skelta.Repository.Security.CommonFunctions.IsQueryStringValid(designerinstanceid) || !Skelta.Repository.Security.CommonFunctions.IsQueryStringValid(mode))
            {
                ajaxResponseObject.IsSuccess = false;
                ISkeltaResourceSet resourceManager = new SkeltaResourceSetManager().GlobalResourceSet;
                ajaxResponseObject.ErrorMessage = resourceManager.GetString("HtmlAndScript_Error");
                return Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(ajaxResponseObject);
            }

            RabbitMQListModel rabbitMQListModel = new RabbitMQListModel();
            ////formHelper.ExpressionRequired = true;
            rabbitMQListModel.SavePropertyBaseFormForCallRabbitMQ(applicationName, userId, workflowName, workflowVersion, actionName, designerinstanceid, instanceXml);
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
    /// Validate CallRabbitMQ instance xml
    /// </summary>
    /// <param name="instanceXml">instance xml</param>
    /// <returns>validation result</returns>
    private static bool ValidateCallRabbitMQ(string instanceXml)
    {
        Skelta.Repository.Security.XmlValidation validation = new Skelta.Repository.Security.XmlValidation
        {
            AllowEmptyXml = false
        };

        validation.ValidationDetails.Add(new Skelta.Repository.Security.XmlValidationDetail
        {
            AllowEmptyValue = false,
            XPath = "//SendMQData/RMQApplicationName",
            ValidationType = Skelta.Repository.Security.TypeOfValidation.XSSCheck
        });

        validation.ValidationDetails.Add(new Skelta.Repository.Security.XmlValidationDetail
        {
            AllowEmptyValue = false,
            XPath = "//SendMQData/ConnectionType",
            ValidationType = Skelta.Repository.Security.TypeOfValidation.PatternBased,
            Pattern = "[0-1]",
            IsMatchPattern = true
        });

        validation.ValidationDetails.Add(new Skelta.Repository.Security.XmlValidationDetail
        {
            AllowEmptyValue = false,
            XPath = "//SendMQData/Connection",
            ValidationType = Skelta.Repository.Security.TypeOfValidation.XSSCheck
        });

        validation.ValidationDetails.Add(new Skelta.Repository.Security.XmlValidationDetail
        {
            AllowEmptyValue = false,
            XPath = "//SendMQData/Connection/@DVConnection",
            ValidationType = Skelta.Repository.Security.TypeOfValidation.XSSCheck
        });

        validation.ExcludeXPaths.Add("//SendMQData/MessageNameExpression");
        validation.ExcludeXPaths.Add("//SendMQData/MessageTypeExpression");
        validation.ExcludeXPaths.Add("//SendMQData/CallRMQ_MessageDetails");
        validation.ExcludeXPaths.Add("//SendMQData/MessageDetailsExpression");

        if (!validation.IsValidXml(instanceXml))
        {
            return false;
        }

        return true;
    }
}
