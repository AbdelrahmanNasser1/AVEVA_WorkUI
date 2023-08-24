using System;
using System.Collections.Generic;
using System.Globalization;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Workflow.NET;
using Workflow.NET.Attachment;


public partial class BPMUITemplates_Default_NextGenForms_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            SkeltaResourceSet resourceSet = new SkeltaResourceSetManager().GlobalResourceSetForNextGenForms;
            var applicationName = Request.QueryString["applicationName"];
            var securedValue = Request.QueryString["securedValue"];
            var fileName = Request.QueryString["fileName"];
            string filePath = Request.QueryString["filePath"];
            string storageType = Request.QueryString["storageType"];
            string cs = Request.QueryString["cs"];

            try
            {
                Skelta.Forms.Core.Controls.TypeOfAttachmentStorage attachmentStorageType = (Skelta.Forms.Core.Controls.TypeOfAttachmentStorage)int.Parse(storageType);

                if (attachmentStorageType == Skelta.Forms.Core.Controls.TypeOfAttachmentStorage.Cloud && !Workflow.NET.CommonFunctions.IsStorageTypeCloudSupported())
                {
                    throw new Exception(resourceSet.GetString("AttachmentCloudAvevaDriveNoSupport"));
                }

                if (attachmentStorageType == Skelta.Forms.Core.Controls.TypeOfAttachmentStorage.FileSystem && !Workflow.NET.CommonFunctions.IsStorageTypeFileSystemSupported())
                {
                    throw new Exception(resourceSet.GetString("AttachmentFileSystemNoSupport"));
                }

                if (string.IsNullOrEmpty(applicationName) ||
                    string.IsNullOrEmpty(fileName) ||
                    string.IsNullOrEmpty(cs))
                {
                    throw new Exception(resourceSet.GetString("AttachmentRequestParametersInvalidError"));
                }

                SE.Bpm.Convertors.Crypts.ChecksumCalculator checkSum = new SE.Bpm.Convertors.Crypts.ChecksumCalculator();

                if (attachmentStorageType == Skelta.Forms.Core.Controls.TypeOfAttachmentStorage.Database) // Attachment storage type is database
                {
                    if (string.IsNullOrEmpty(securedValue) ||
                        checkSum.Calculate(Encoding.UTF8.GetBytes(securedValue + applicationName + fileName + storageType)).ToString(CultureInfo.InvariantCulture) != cs)
                    {
                        throw new Exception(resourceSet.GetString("AttachmentRequestParametersInvalidError"));
                    }

                    Skelta.Forms.Core.SignatureSecurityMode attachmentSecurityMode = (Skelta.Forms.Core.SignatureSecurityMode)int.Parse(Request.QueryString["securityMode"]);

                    AttachmentCommonFunctions.AttachmentDownloadFromDatabase(securedValue, applicationName, fileName, attachmentSecurityMode == Skelta.Forms.Core.SignatureSecurityMode.None);
                }
                else
                {
                    if (checkSum.Calculate(Encoding.UTF8.GetBytes(filePath + applicationName + fileName + storageType)).ToString(CultureInfo.InvariantCulture) != cs)
                    {
                        throw new Exception(resourceSet.GetString("AttachmentRequestParametersInvalidError"));
                    }

                    if (AttachmentCommonFunctions.ContainsRelativePath(filePath))
                    {
                        throw new Exception(resourceSet.GetString("AttachmentRelativePathNotSupportedError"));
                    }
                    if (attachmentStorageType == Skelta.Forms.Core.Controls.TypeOfAttachmentStorage.FileSystem)
                    {
                        AttachmentCommonFunctions.AttachmentDownloadFromFileSystem(filePath, applicationName, fileName);
                    }
                    else
                    {
                        AttachmentCommonFunctions.AttachmentDownloadFromCloud(filePath, applicationName, fileName);
                    }
                }
            }
            catch (Exception ex)
            {
                string errorTitle = resourceSet.GetString("Attachment_Error_Title_Download");
                string errorMessage = resourceSet.GetString("Attachment_Error_MSG_Downloading");

                if (ex is Aveva.WorkTasks.Plugin.CrossDomainException)
                {
                    if ((ex as Aveva.WorkTasks.Plugin.CrossDomainException).CanDisplayExceptionMessageToEndUser)
                    {
                        errorMessage = ex.Message;
                    }
                }

                Context.Response.ClearHeaders();
                Context.Response.ClearContent();
                Context.Response.Write("<script>window.parent.skelta.utilities.showError(\"" + Skelta.Forms.Core.Common.GetEscapedJavaScriptString(errorTitle) + "\", \"" + Skelta.Forms.Core.Common.GetEscapedJavaScriptString(errorMessage) + "\");</script>");

                Log logger = new Log();
                logger.LogError(ex, errorMessage);
            }
            Context.Response.End();
        }
        catch { }
    }
}