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

public partial class BPMUITemplates_Default_Repository_Site_HiddenWorkItemList : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                //created intermediate page to open workitemlist page to fix refresh issue.
                Response.Write("<script language='Javascript'> location.href = 'WorkItemList.aspx'</script>");
                //this.Context.Response.End();
            }
            catch (Exception ex)
            {
                //if (!ex.Message.ToLowerInvariant().Contains("thread was being aborted"))
                //{
                //    Log log = new Log();
                //    log.LogInformation(ex.Message);
                //}
            }
        }
       
    }
