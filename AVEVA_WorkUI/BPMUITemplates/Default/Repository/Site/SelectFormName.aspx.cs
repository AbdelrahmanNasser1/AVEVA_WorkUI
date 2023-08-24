using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Skelta.Repository.Web.List;

public partial class SelectFormName : System.Web.UI.Page
{
    string formWorkflowColtitle = string.Empty;
    string formWFName = string.Empty;
    string workflowname = String.Empty;
    string appname = String.Empty;
    ArrayList formsList = new ArrayList();
   static string formName = string.Empty;
   protected string cssPath = "";
   protected object cssUrl = Workflow.NET.TemplateExpressionBuilder.GetUrl("");
    int formStatusFlag = 3;
    string lcsuri = "";

    protected Workflow.NET.SkeltaResourceSet GR = new Workflow.NET.SkeltaResourceSetManager().GlobalResourceSet; 
    protected void Page_Load(object sender, EventArgs e)
    {
        ListPageParameters listParams = new ListPageParameters();
        listParams.ResolveCurrentUri();
        cssPath = cssUrl.ToString();
        appname = Request["applicationName"]; ;
        workflowname = Request["wfname"];
        lcsuri = Request["lcsuri"];
        btnSubmit.Text = GR.GetString("ec_testrun_selform_submit");
        Skelta.Repository.List.ListDefinition _formList = new Skelta.Repository.List.ListDefinition(new Skelta.Core.ApplicationObject(appname), "Forms List");
        Skelta.Repository.List.ListItemCollection formsListItem = new Skelta.Repository.List.ListItemCollection(_formList);
        DataTable formitemsDataTable = formsListItem.GetAllRecords(listParams.LoggedInUserId);
       // btnSubmit.Attributes.Add("onClick", "ShowAlert();");
        ListItem defaultItem = new ListItem();
        defaultItem.Text = GR.GetString("ec_testrun_selform_Forms");
        if(!drpFormsList.Items.Contains(defaultItem))
        drpFormsList.Items.Add(defaultItem);
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
                    formWFName = row[formWorkflowColtitle].ToString();
                    if(int.Parse(row[1].ToString())==formStatusFlag)
                    formsList.Add(row["f00100_1"].ToString());

                }
            }

        }

        if (!string.IsNullOrEmpty(appname) && !string.IsNullOrEmpty(workflowname))
        {
            

            foreach (string frmItem in formsList)
            {
                if (drpFormsList.Items.FindByValue(frmItem) == null)
                    drpFormsList.Items.Add(frmItem);
            }
            
       
        }
    }
    protected void FormsList_SelectedIndexChanged(object sender, EventArgs e)
    {
        formName = drpFormsList.SelectedItem.ToString();
      
        
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (string.IsNullOrEmpty(formName) || formName == GR.GetString("ec_testrun_selform_Forms"))  //if(formName!=GR.GetString("ec_testrun_selform_Forms"))      
            {
                ShowAlert(GR.GetString("ec_testrun_selform_Forms_error"));
            }
            else
            {
                string url = "Publish.aspx" + "?applicationName=" + HttpUtility.UrlEncode(appname) + "&formName=" + HttpUtility.UrlEncode(formName) + "&lcsuri=" + HttpUtility.UrlEncode(lcsuri) + "&mode=testRun";
                Response.Redirect(url);
            }
        }
        catch
        { 
        }
        finally
        {
            formName = "";
        }
    }
    private void ShowAlert(string message)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append(@"<script language='javascript'>");
        sb.Append(@"alert( """ + message + @""" );");
        sb.Append(@"</script>");
        string strScript = sb.ToString();
        Page.ClientScript.RegisterClientScriptBlock(GetType(), "onClick", strScript);

    }
}
