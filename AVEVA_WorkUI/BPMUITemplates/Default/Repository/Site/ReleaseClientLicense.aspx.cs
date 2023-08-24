using Skelta.Entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Diagnostics;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Workflow.NET;
using Workflow.NET.Security.Client.SELicensing;

public partial class BPMUITemplates_Default_Repository_Site_ReleaseClientLicense : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            
            bool isCoreCountLicenseExists = CommonFunctions.IsCoreCountLicenseExists();

            if (!isCoreCountLicenseExists)
            {
                UserContext userContext = new UserContext();                
                
                if (userContext.LoggedInVirtualActorId != Guid.Empty)
                {      
                   ReleaseClientLicenseOnLogout(userContext);                       
                }
            }
        }
        catch (Exception ex)
        {
            Log log = new Log();
            log.LogInformation("Error in releasing Client License on window unload event: " + ex.Message);
        }

    }

    private static void ReleaseClientLicenseOnLogout(UserContext userContext)
    {
        
        string userName = userContext.GetUserName();
        string deviceId = string.Empty;
        if (HttpContext.Current.Request.Cookies[userName + "_skdeviceid"] != null)
        {
            deviceId = HttpContext.Current.Request.Cookies[userName + "_skdeviceid"].Value;
        }
        
        LicenseConnectionManager licManager = new LicenseConnectionManager();
        bool licenseReleased = licManager.ReleaseClientConnectionLicense(deviceId, userName);
        if (licenseReleased)
        {
            HttpRuntime.Cache.Remove(deviceId);
        }

    }
}