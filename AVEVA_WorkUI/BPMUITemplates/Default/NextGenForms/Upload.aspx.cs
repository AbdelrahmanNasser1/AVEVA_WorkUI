//-----------------------------------------------------------------------------
// <copyright file="Upload.aspx.cs" company="Invensys">
// Copyright (C) Invensys Systems Inc.
// This unpublished copyrighted work contains Trade Secret information
// of Invensys. Use, transfer, disclosure or copying
// without its express written permission is strictly forbidden
// </copyright>
//-----------------------------------------------------------------------------
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Skelta.Forms2.Web;
using RepositorySecurityCommonFunctions = Skelta.Repository.Security.CommonFunctions;
using Skelta.Repository.Security;
using Workflow.NET;
using Workflow.NET.Attachment;
using Workflow.NET.Interfaces;

/// <summary>
/// Class for uploading attachment
/// </summary>
public partial class BPMUITemplates_Default_NextGenForms_Upload : System.Web.UI.Page
{
    /// <summary>
    /// Page load method
    /// </summary>
    /// <param name="sender">sender object</param>
    /// <param name="e">event arguments</param>
    protected void Page_Load(object sender, EventArgs e)
    {
        AjaxResponseObject ajaxResponseObject = new AjaxResponseObject();
        ajaxResponseObject.IsSuccess = true;

        var resSet = new SkeltaResourceSetManager().GlobalResourceSetForNextGenForms;

        try
        {
            if (!RepositorySecurityCommonFunctions.IsControlValuesValid(Page.Controls))
            {
                throw new XssSecurityException();
            }

            var file = Request.Files[0];
            var cloudFileNamePattern = @"/^[^|\/]{0,1024}[^.|\/]$/";
            var applicationName = Request.Headers["applicationName"];
            string renderDetailsInternalValueEncoded = Request.Headers["renderDetailsInternalValue"];
            string cs = Request.Headers["cs"];

            if (string.IsNullOrEmpty(applicationName) ||
                string.IsNullOrEmpty(renderDetailsInternalValueEncoded) ||
                string.IsNullOrEmpty(cs))
            {
                throw new Exception(resSet.GetString("AttachmentRequestParametersInvalidError"));
            }

            string renderDetailsInternalValue = HttpUtility.UrlDecode(renderDetailsInternalValueEncoded);

            Dictionary<string, string> details = Skelta.Forms.Core.Common.DecryptDictionary(renderDetailsInternalValue);

            if (details.Count < 1)
            {
                throw new Exception(resSet.GetString("AttachmentRequestParametersInvalidError"));
            }

            Skelta.Forms.Core.Controls.TypeOfAttachmentStorage attachmentStorageType = (Skelta.Forms.Core.Controls.TypeOfAttachmentStorage)int.Parse(details["AttachmentStorageType"]);

            if (attachmentStorageType == Skelta.Forms.Core.Controls.TypeOfAttachmentStorage.Cloud && !Workflow.NET.CommonFunctions.IsStorageTypeCloudSupported())
            {
                throw new Exception(resSet.GetString("AttachmentCloudAvevaDriveNoSupport"));
            }

            if (attachmentStorageType == Skelta.Forms.Core.Controls.TypeOfAttachmentStorage.Cloud && Workflow.NET.CommonFunctions.IsPatternMatching(cloudFileNamePattern, file.FileName))
            {
                throw new Exception("FormNGFFileNameValidationUploadForCloudError");
            }

            string fileExtensions = details["FileExtensions"];

            //TODO: Need to check the file extensions and relative paths present in the file path.
            SE.Bpm.Convertors.Crypts.ChecksumCalculator checkSum = new SE.Bpm.Convertors.Crypts.ChecksumCalculator();

            if (attachmentStorageType == Skelta.Forms.Core.Controls.TypeOfAttachmentStorage.Database)
            {
                if (checkSum.Calculate(Encoding.UTF8.GetBytes(applicationName + renderDetailsInternalValueEncoded)).ToString(CultureInfo.InvariantCulture) != cs)
                {
                    throw new Exception(resSet.GetString("AttachmentRequestParametersInvalidError"));
                }

                if (AttachmentCommonFunctions.IsValidFileExtension(file.FileName, fileExtensions) == false)
                {
                    throw new Exception(resSet.GetString("AttachmentInvalidFileExtensionError").Replace("<@fileextension@>", System.IO.Path.GetExtension(file.FileName)));
                }

                Skelta.Forms.Core.SignatureSecurityMode attachmentSecurityMode = (Skelta.Forms.Core.SignatureSecurityMode)int.Parse(details["SecurityMode"], CultureInfo.InvariantCulture);

                var persistHeader = details["PersistHeader"] == "1" ? true : false;
                ExecuteAttachmentDataPurgingAsync(applicationName);
                var securedValue = AttachmentCommonFunctions.AttachmentUploadToDatabase(file, applicationName, persistHeader, attachmentSecurityMode == Skelta.Forms.Core.SignatureSecurityMode.None);
                ajaxResponseObject.Result = securedValue;
            }
            else
            {
                var filePathEncodedValue = Request.Headers["filePath"];

                if (string.IsNullOrEmpty(filePathEncodedValue) ||
                    checkSum.Calculate(Encoding.UTF8.GetBytes(applicationName + filePathEncodedValue + renderDetailsInternalValueEncoded)).ToString(CultureInfo.InvariantCulture) != cs)
                {
                    throw new Exception(resSet.GetString("AttachmentRequestParametersInvalidError"));
                }

                var filePath = HttpUtility.UrlDecode(filePathEncodedValue);

                if (AttachmentCommonFunctions.ContainsRelativePath(filePath))
                {
                    throw new Exception(resSet.GetString("AttachmentRelativePathNotSupportedError"));
                }

                if (AttachmentCommonFunctions.IsValidFileExtension(filePath, fileExtensions) == false)
                {
                    throw new Exception(resSet.GetString("AttachmentInvalidFileExtensionError").Replace("<@fileextension@>", System.IO.Path.GetExtension(filePath.Substring(filePath.LastIndexOf("\\") + 1))));
                }

                if (attachmentStorageType == Skelta.Forms.Core.Controls.TypeOfAttachmentStorage.FileSystem)
                {
                    ajaxResponseObject.Result = AttachmentCommonFunctions.AttachmentUploadToFileSystem(filePath, applicationName);
                }
                else
                {
                    ajaxResponseObject.Result = AttachmentCommonFunctions.AttachmentUploadToCloud(filePath, applicationName);
                }
            }
        }
        catch (Exception ex)
        {
            Log logger = new Log();
            string genericErrorMessage = resSet.GetString("Attachment_Error_Uploading");
            if (ex.Message == "FormNGFFileNameValidationUploadForCloudError")
            {
                genericErrorMessage = resSet.GetString(ex.Message);
            }

            if (ex is Aveva.WorkTasks.Plugin.CrossDomainException)
            {
                if ((ex as Aveva.WorkTasks.Plugin.CrossDomainException).CanDisplayExceptionMessageToEndUser)
                {
                    genericErrorMessage = ex.Message;
                }
            }

            logger.LogError(ex, genericErrorMessage);

            ajaxResponseObject.IsSuccess = false;
            ajaxResponseObject.ErrorMessage = genericErrorMessage;
        }

        Response.Write(Skelta.Forms2.Web.CommonFunctions.GetJsonSerializeString(ajaxResponseObject));
    }

    /// <summary>
    /// Purge attachment data from database asynchronously
    /// </summary>
    /// <param name="applicationName">application name</param>
    /// <returns>task when completes</returns>
    private static Task PurgeAttachmentDataFromDBAsync(string applicationName)
    {
        return Task.Run(() =>
        {
            PurgeAttachmentDataFromDB(applicationName);
        });
    }

    /// <summary>
    /// Purge attachment data from database
    /// </summary>
    /// <param name="applicationName">application name</param>
    private static void PurgeAttachmentDataFromDB(string applicationName)
    {
        Config configObject = new Config(applicationName);
        using (IDataHandler objDataHandlerhandler = Workflow.NET.Storage.DataHandlerFactory.GetDataHandler(configObject))
        {
            IDataParameter[] parameters = new IDataParameter[3];
            parameters[0] = objDataHandlerhandler.GetParameter("@dateValue", DateTime.UtcNow.AddDays(-2));
            parameters[1] = objDataHandlerhandler.GetParameter("@formVersion", 1);
            parameters[2] = objDataHandlerhandler.GetParameter("@applicationName", applicationName);
            objDataHandlerhandler.ExecuteProcedure("USP_DeleteOlderTempItemsInDBForAttachment", parameters);
        }
    }

    /// <summary>
    /// Calling Asynchronous method using await
    /// </summary>
    /// <param name="applicationName">application name</param>
    private static async void ExecuteAttachmentDataPurgingAsync(string applicationName)
    {
        await PurgeAttachmentDataFromDBAsync(applicationName);
    }
}
