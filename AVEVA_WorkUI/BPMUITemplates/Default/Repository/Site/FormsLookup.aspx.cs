using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Workflow.NET;
using System.Resources;
using Skelta.Repository;
using Skelta.Repository.List;
using System.Text;
using System.Collections.Generic;


public partial class FormsLookup : System.Web.UI.Page
{
    ListDefinition _ListDef ;
    Skelta.Repository.List.ListItem _ListItem;
    Skelta.Repository.List.ListItemCollection _ListItemCol;
    string strListName = "Forms List";
    string strrepository = "";
    public SkeltaWebControlsBase SWCB;
    public string strPath;
    Skelta.Repository.Web.Lookup.FormLookupWebControl flwk = new Skelta.Repository.Web.Lookup.FormLookupWebControl();
    Skelta.Entity.UserContext uContext;
    Workflow.NET.Log logger = new Log();
    string strOption = "";
    string strFormNames = "";
    string strFormIds = "";
    string ArgValue="";
    string strformsfor = "";
    SkeltaResourceSetManager resMgr = new SkeltaResourceSetManager();
    protected string strNoteOwned = "";
    protected string strNoteAllow = "";
    protected string strForm_Lookup = "";
    protected string strCancelText = "";
    protected string themepath = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        themepath = Workflow.NET.TemplateExpressionBuilder.GetUrl("").ToString();
        strNoteOwned = resMgr.GlobalResourceSet.GetString("NoteOwnedOnly");
        strNoteAllow = resMgr.GlobalResourceSet.GetString("NoteAllow");
        strForm_Lookup = resMgr.GlobalResourceSet.GetString("Form_Lookup");
        strCancelText = resMgr.GlobalResourceSet.GetString("BtnCancelText");
        try
        {
             SWCB = new SkeltaWebControlsBase();
             uContext = new Skelta.Entity.UserContext();
             strrepository = uContext.Repository.ApplicationName;
             flwk.ApplicationName= strrepository;
             flwk.ListName = "Forms List";
             if (Request.QueryString["Option"] != null)
                 strOption = Request.QueryString["Option"].ToString();
             if (strOption.ToLowerInvariant().IndexOf("true") != -1)
             {
                 flwk.FormforOwnedItems = true;
                 Page.ClientScript.RegisterStartupScript(GetType(), "true", "DisplayAllow();", true);
             }
             else
             {
                 Page.ClientScript.RegisterStartupScript(GetType(), "true", "DisplayOwned();", true);
             }
             if (Request.QueryString["formsfor"] != null)
             {
                 strformsfor = Request.QueryString["formsfor"].ToString();
                 flwk.FormsFor = strformsfor.Trim();
             }
               

             if(Request.QueryString["fn"] != null)
                 strFormNames = Request.QueryString["fn"].ToString();
             if(Request.QueryString["fid"] != null)
                 strFormIds = Request.QueryString["fid"].ToString();
             if(Request.QueryString["argValue"] != null)
             {
                 ArgValue = Request.QueryString["argValue"].ToString();
                 flwk.Parameters = Microsoft.Security.Application.Encoder.HtmlEncode(ArgValue);
             }
             if(Request.QueryString["ownedId"] != null)
                 flwk.DefaullFormIdForOwnedItems = Microsoft.Security.Application.Encoder.HtmlEncode(Request.QueryString["ownedId"]);
             if(Request.QueryString["nonownedId"] != null)
                 flwk.DefaultFormIdForNonOwnedItems = Microsoft.Security.Application.Encoder.HtmlEncode(Request.QueryString["nonownedId"]);

             if (Request.QueryString["ownedver"] != null)
                 flwk.DefaultOwnedFormVersion = Microsoft.Security.Application.Encoder.HtmlEncode(Request.QueryString["ownedver"]);
             if (Request.QueryString["nonownedver"] != null)
                 flwk.DefaultNonOwnedFormVersion = Microsoft.Security.Application.Encoder.HtmlEncode(Request.QueryString["nonownedver"]);

             if (Request.QueryString["defformId"] != null)
                 flwk.DefaultFormId = Microsoft.Security.Application.Encoder.HtmlEncode(Request.QueryString["defformId"]);
             if (Request.QueryString["defformVer"] != null)
                 flwk.DefaultFormVer = Microsoft.Security.Application.Encoder.HtmlEncode(Request.QueryString["defformVer"]);             

                
             if (!IsPostBack)
             {
                 if (!string.IsNullOrEmpty(strFormIds) && !string.IsNullOrEmpty(strFormNames))
                 {
                     string[] FormNames = strFormNames.Split(new char[] { ',' });
                     string[] FormIds = strFormIds.Split(new char[] { ',' });

                     SortedList<string, string> selectedforms = new SortedList<string, string>();
                     for (int i = 0; i < FormNames.Length; i++)
                     {
                         if (FormNames[i] != "")
                             selectedforms.Add(FormNames[i], FormIds[i]);
                     }
                     flwk.SelectedForms = selectedforms;

                 }
             }
   
        }
        catch(Exception ex)
        {
            Log log = new Log();
            log.LogInformation(ex.Message);
            log.Close();
            throw new Exception("There is an error. Please see the Logger console for the error message.");
        }
        flwk.ID = "FormsLookup";
        btnContinue.Text = resMgr.GlobalResourceSet.GetString("BtnContinueText");
        btnContinue.ToolTip = resMgr.GlobalResourceSet.GetString("BtnContinueToolTip");
        PanelFormsLookup.Controls.Add(flwk);
       
    }
    protected void btnContinue_Click(object sender, EventArgs e)
    {
        StringBuilder FormName = new StringBuilder();  
        StringBuilder FormId = new StringBuilder();
        
        System.Collections.Generic.SortedList<string,string> SLSelectedForms  = flwk.SelectedForms;
        //if (SLSelectedForms.Count > 0)
        //{

            foreach (KeyValuePair<string, string> KVP in SLSelectedForms)
            {
                FormName.Append(KVP.Key.ToString() + ",");
                FormId.Append(KVP.Value.ToString() + ",");
            }
            string strforms = "";
            
            if (flwk.FormsFor.ToLowerInvariant().Equals("create"))
                strforms = FormName.ToString() + ":" + FormId.ToString() + ":" + flwk.DefaultFormId + ":" + flwk.DefaultFormVer;
            else
                strforms = FormName.ToString() + ":" + FormId.ToString() + ":" + flwk.DefaullFormIdForOwnedItems + ":" + flwk.DefaultFormIdForNonOwnedItems + ":" + flwk.DefaultOwnedFormVersion + ":" + flwk.DefaultNonOwnedFormVersion;

            Page.ClientScript.RegisterClientScriptBlock(GetType(), "regJSval", "<script>ReturnValues(\"" + strforms + "\");</script>");       
        
    }


    
}
