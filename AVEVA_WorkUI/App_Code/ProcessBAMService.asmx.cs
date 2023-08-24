using System;
using System.Collections.Generic;
using System.Text;
using System.Web.Services;
using Skelta.BAM.Configuration;

namespace BAMService
{

    [WebService(Namespace = "http://skelta.BAM.webservices/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class ProcessBAMService : System.Web.Services.WebService
    {
        public ProcessBAMService()
        {

            //Uncomment the following line if using designed components 
            //InitializeComponent(); 
        }

        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }

        /// <summary>
        /// To Process the BAM Report
        /// </summary>
        /// <param name="applicationName"></param>
        /// <param name="workflowName"></param>
        [WebMethod]
        public void ProcessBAM(string applicationName, string workflowName)
        {
            Skelta.Core.WorkflowObject objWF = new Skelta.Core.WorkflowObject(workflowName, new Skelta.Core.ApplicationObject(applicationName));
            Skelta.BAM.Runtime.BamUpdateWorkflow BAMUpdWF = new Skelta.BAM.Runtime.BamUpdateWorkflow(objWF);
            BAMUpdWF.Process();
        }

        /// <summary>
        /// To Process the OverDue Chart from the Web Service
        /// </summary>
        /// <param name="applicationName">Application Name</param>
        /// <param name="workflowName">Workflow Name</param>
        /// <param name="settings">BAMWorkflowSettings</param>
        /// <returns>Path to the chart</returns>
        [WebMethod]
        public string ProcessBAMOverDueChart(string ApplicationName, string WorkflowName)
        {
            string sPath = string.Empty;
            Skelta.BAM.AlertManager.AlertManagerActions objActions = new Skelta.BAM.AlertManager.AlertManagerActions();
            sPath = objActions.GetOverDueChartPathFromService(ApplicationName, WorkflowName);
            return sPath;
        }

        /// <summary>
        /// To Process the BAM KPI Chart by using the web service
        /// </summary>
        /// <param name="settings">BAMWorkflowSettings</param>
        /// <param name="cKpi">BAM KPI Settings</param>
        /// <returns>Path to the chart</returns>
        [WebMethod]
        public string ProcessBAMKPIChart(string ApplicationName, string WorkflowName, string KPIId)
        {
            string sPath = string.Empty;
            Skelta.BAM.AlertManager.AlertManagerActions objActions = new Skelta.BAM.AlertManager.AlertManagerActions();
            sPath = objActions.GetKPIPathFromService(ApplicationName, WorkflowName, KPIId);
            return sPath;
        }
    }

}

