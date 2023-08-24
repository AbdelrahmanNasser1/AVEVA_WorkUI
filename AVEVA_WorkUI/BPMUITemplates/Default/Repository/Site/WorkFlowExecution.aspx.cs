using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using Skelta.HWS;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Workflow.NET;
using Skelta.Entity;
using Workflow.NET.Report;
using Workflow.NET.Engine;
using Skelta.Repository.Web.List;
using System.Collections.Generic;
using Skelta.Repository.List;



public partial class SkeltaTemplates_Default_ProcessDesigner_WorkFlowExecution : System.Web.UI.Page
{


    protected UserContext usercontext = new UserContext();
    protected Skelta.HWS.WorkListChannel.Web.WebWorkItemAdapter adapter;
    protected Workflow.NET.SkeltaResourceSet GR;
    protected Workflow.NET.Web.Report.WorkflowExecutionReport wer;
    ListPageParameters listPageParameters = null;
    protected SkeltaResourceSet rs = new SkeltaResourceSetManager().GlobalResourceSet;
      
    Guid listGuid = Guid.Empty;
    protected Guid workflowId = Guid.Empty;
    const string workflowListName = "Workflow";
    string workflowname = String.Empty;
    string appname = String.Empty;
    string user = string.Empty;
    string lcsuri = String.Empty;
    string runAsQuickflow = String.Empty;
    string errormessage = String.Empty;
    string _LoggedInUser = String.Empty;
    string frmWfName = string.Empty;
    string formWorkflowColtitle = string.Empty;
    string formWFName = string.Empty;
    string formName = string.Empty;
    int formStatusFlag = 3;
    int formStatus = 0;
    string tabFormName = string.Empty;
   // ArrayList formsList = new ArrayList();
    Hashtable formsList = new Hashtable();
   // protected Skelta.Repository.List.ListItem item;
    Workflow.NET.Engine.Client ClientObj = null;
    Skelta.Repository.List.ListItemVersionStatus workflowStatus = ListItemVersionStatus.Published;
    string version = string.Empty;
    bool isPublished = false;
    protected void Page_Load(object sender, EventArgs e)
    {

        
        try
        {
            if (!Page.IsPostBack)
            {

                ListPageParameters listParams = new ListPageParameters();
                listParams.ResolveCurrentUri();
                _LoggedInUser = listParams.LoggedInUserId;
                listGuid = listParams.ListId;
                workflowId = listParams.ListItemId;
                appname = listParams.ApplicationName;
                version = listParams.VersionStamp;
                Skelta.Repository.List.ListDefinition workflowList = null;
                Skelta.Repository.List.ListItem workflowflowListItem = null;
                if (workflowId != Guid.Empty)
                {
                    workflowList = ListDefinition.GetList(new Skelta.Core.ApplicationObject(appname), workflowListName);
                    workflowflowListItem = new Skelta.Repository.List.ListItem(workflowList, workflowId,version);
                    workflowname = workflowflowListItem.Title;
                    version = workflowflowListItem.CurrentVersion.VersionStamp; 
                }

                if (workflowflowListItem!=null)//workflowflowListItem.Status == workflowStatus
                {
                    Skelta.Repository.List.ListDefinition _formList = new Skelta.Repository.List.ListDefinition(new Skelta.Core.ApplicationObject(listParams.ApplicationName), "Forms List");
                    Skelta.Repository.List.ListItemCollection formsListItem = new Skelta.Repository.List.ListItemCollection(_formList);
                    DataTable formitemsDataTable = formsListItem.GetAllRecords(_LoggedInUser);
                    if (formitemsDataTable.Rows.Count > 0)
                    {
                        SortedDictionary<string, Skelta.Forms.Core.Controls.BaseDataControl> fields = formsListItem.GetRecordsFullQueryFieldMapping();
                        foreach (System.Collections.Generic.KeyValuePair<string, Skelta.Forms.Core.Controls.BaseDataControl> pair in fields)
                        {
                            if (pair.Value.Name == "BoundToWorkflow")
                            {
                                formWorkflowColtitle = pair.Key;
                                break;
                            }
                        }

                        foreach (DataRow row in formitemsDataTable.Rows)
                        {
                            if (row[formWorkflowColtitle].ToString() == workflowname)
                            {
                                formWFName = Skelta.Repository.Security.CommonFunctions.SanitizeValue(Microsoft.Security.Application.Encoder.HtmlEncode(row[formWorkflowColtitle].ToString()));
                                formStatus = int.Parse(Microsoft.Security.Application.Encoder.HtmlEncode(row[1].ToString()));
                                tabFormName = Skelta.Repository.Security.CommonFunctions.SanitizeValue(Microsoft.Security.Application.Encoder.HtmlEncode(row["f00100_1"].ToString()));
                                formsList.Add(tabFormName, formStatus);
                            }
                        }

                    }

                    if (!string.IsNullOrEmpty(formWFName))
                    {
                        if (Request["lcsuri"] != null)
                        {
                            lcsuri = Request["lcsuri"];
                        }

                        if (Request["RunAsQuickflow"] != null)
                        {
                            runAsQuickflow = Request["RunAsQuickflow"];
                        }

                        //Changes done If Form is not pubished don't popup the form
                        if (formsList.Count > 1)
                        {
                            int iCount = 0;
                            IDictionaryEnumerator en = formsList.GetEnumerator();
                            while (en.MoveNext())
                            {
                                if (int.Parse(en.Value.ToString()) == formStatusFlag)
                                {
                                    string url = "SelectFormName.aspx" + "?applicationName=" + appname + "&wfname=" + workflowname + "&lcsuri=" + lcsuri;
                                    //Page.ClientScript.RegisterClientScriptBlock(typeof(string), "openwindow", "<script>window.open('" + url + "','SelectFormname','height=200,width=100,top=10 ,resizable=no')</script>");
                                    Response.Redirect(url, false);
                                }
                                else
                                {
                                    Page.ClientScript.RegisterClientScriptBlock(typeof(string), "alert", "<script>alert('" + rs.GetString("NoPublishedForm") + " " + en.Key.ToString() + " " + rs.GetString("FoundToExecute") + "' );window.close();</script>");
                                }
                            }

                        }
                        else
                        {

                            if (int.Parse(formsList[tabFormName].ToString()) == formStatusFlag)
                            {
                                if (Request["lcsuri"] != null)
                                {
                                    lcsuri = Request["lcsuri"];
                                }

                                if (Request["RunAsQuickflow"] != null)
                                {
                                    runAsQuickflow = Request["RunAsQuickflow"];
                                }

                                if (workflowflowListItem.Status == workflowStatus)
                                {
                                    isPublished = true;
                                   
                                }
                                else if (workflowflowListItem.Status != workflowStatus)
                                {
                                    isPublished = false;
                                }
                                
                                string url = "Publish.aspx?applicationName=";
                                url += Server.UrlEncode(appname) + "&formName=" + HttpUtility.UrlEncode(tabFormName) + "&lcsuri=" + lcsuri + "&isPublished=" + isPublished + "&mode=testRun";                             
                                Response.Redirect(url, false);
                            }
                            else
                            {
                                Page.ClientScript.RegisterClientScriptBlock(typeof(string), "alert", "<script>alert('" + rs.GetString("NoPublishedForm") + " " + tabFormName + " " + rs.GetString("FoundToExecute") + "' );window.close();</script>");
                                Page.ClientScript.RegisterClientScriptBlock(typeof(string), "close", "<script>var oWindow = GetRadWindow();oWindow.BrowserWindow;oWindow.close();function GetRadWindow(){ var oWindow = null;if (window.radWindow)oWindow = window.radWindow;else if (window.frameElement.radWindow)oWindow = window.frameElement.radWindow;return oWindow;};</script>");
                            }

                        }

                    }

                    else
                    {
                         ClientObj = new Workflow.NET.Engine.Client(appname, workflowname);
                        listPageParameters = new ListPageParameters();
                        try
                        {
                            if (Request["lcsuri"] != null)
                            {
                                lcsuri = Request["lcsuri"];
                                listPageParameters.ResolveCurrentUri();
                            }

                            if (Request["RunAsQuickflow"] != null)
                            {
                                runAsQuickflow = Request["RunAsQuickflow"];
                            }

                            _LoggedInUser = listPageParameters.LoggedInUserId;
                        }
                        catch (Exception userError)
                        {
                            _LoggedInUser = usercontext.LoggedInUserId;
                        }

                        if (_LoggedInUser == String.Empty)
                        {
                            _LoggedInUser = usercontext.LoggedInUserId;
                        }

                        int ExecutionId = -1;
                        try
                        {
                            if (workflowflowListItem.Status != workflowStatus)
                            {
                                //Page.ClientScript.RegisterClientScriptBlock(typeof(string), "close", "<script> window.opener.close();</script>"); 
                                string url = "Publish.aspx?lcsuri=" + lcsuri + "&mode=testRun";

                                if (!string.IsNullOrEmpty(runAsQuickflow) && runAsQuickflow.Equals("true"))
                                {
                                    url += "&RunAsQuickflow=" + runAsQuickflow;
                                }

                                // Page.ClientScript.RegisterClientScriptBlock(typeof(string), "open", "<script>self.close();window.open('" + url + "','','height=600,width=800,resizable=yes,status=no,scrolbars=yes');</script>");
                                Response.Redirect(url, false);

                            }
                            else
                            {
                                string url = "Publish.aspx?lcsuri=" + lcsuri + "&mode=testRun";
                                // Page.ClientScript.RegisterClientScriptBlock(typeof(string), "open", "<script>self.close();window.open('" + url + "','','height=600,width=800,resizable=yes,status=no,scrolbars=yes');</script>");
                                if (!string.IsNullOrEmpty(runAsQuickflow) && runAsQuickflow.Equals("true"))
                                {
                                    url += "&RunAsQuickflow=" + runAsQuickflow;
                                }

                                Response.Redirect(url, false);

                                //ExecutionId = ClientObj.Execute(version, _LoggedInUser, "<test>M</test>");
                            }
                        }
                        catch (Exception puberror)
                        {
                            if (puberror.Message.ToString().ToLowerInvariant().Contains("engine"))
                                errormessage = "WorkFlowEngineStopped";
                            else if (puberror.Message.ToString().ToLowerInvariant().Contains("disabled"))
                                errormessage = "PublishWorkflow";
                            throw puberror;
                        }
                        ClientObj.Close();
                        int ExecutionIdObj = System.Convert.ToInt32(ExecutionId);

                        //Security implementation
                        string SecuredUri = Workflow.NET.Report.WorkflowExecution.GetSecuredUriParameterForWorkflowExecutionReport(appname, ExecutionIdObj, _LoggedInUser, true, false);

                        string quickflowQueryString = string.Empty;
                        if (workflowflowListItem.ItemType == 8)
                        {
                            quickflowQueryString = "&isquickflow=true";
                        }

                        string Url = "../../ProcessExecutionView/ShowView.aspx?suri=" + HttpUtility.UrlEncode(SecuredUri) + "&cul=" + System.Threading.Thread.CurrentThread.CurrentUICulture.Name + quickflowQueryString;

                        Page.ClientScript.RegisterClientScriptBlock(typeof(string), "open", "<script>var oWindow = GetRadWindow();oWindow.BrowserWindow;oWindow.close();function GetRadWindow(){ var oWindow = null;if (window.radWindow)oWindow = window.radWindow;else if (window.frameElement.radWindow)oWindow = window.frameElement.radWindow;return oWindow;};window.open('" + Url + "','','height=600,width=800,resizable=yes,status=no,scrolbars=yes,top=300');</script>");
                        
                    }
                }
                else
                {
                    errormessage = rs.GetString("PublishWorkflow") + " " + workflowname + " " + rs.GetString("FoundToExecute");
                    Page.ClientScript.RegisterClientScriptBlock(typeof(string), "alert", "<script>alert('" + errormessage + "');window.close();</script>");
                }
            }
            else
            {

                ListPageParameters listParams = new ListPageParameters();
                listParams.ResolveCurrentUri();
                _LoggedInUser = listParams.LoggedInUserId;
                listGuid = listParams.ListId;
                workflowId = listParams.ListItemId;
                appname = listParams.ApplicationName;

            }

        }

        catch (Exception eee)
        {
            //drpFormsList.Visible = false;
            switch (errormessage)
            {
                case "PublishWorkflow":
                    {
                        errormessage = rs.GetString("PublishWorkflow") + " " + workflowname + " " + rs.GetString("FoundToExecute");
                        break;
                    }
                case "WorkFlowEngineStopped":
                    {
                        errormessage = rs.GetString("WorkFlowEngineStopped");
                        break;
                    }

                case "UserNotFound":
                    {
                        errormessage = rs.GetString("UserNotFound");
                        break;
                    }
            }           
            
            Page.ClientScript.RegisterClientScriptBlock(typeof(string), "alert", "<script>alert('" + errormessage + "');window.close();</script>");
        }

        finally
        {
            if (ClientObj != null)
            {
                ClientObj.Close();
            }
        }
    }
}
