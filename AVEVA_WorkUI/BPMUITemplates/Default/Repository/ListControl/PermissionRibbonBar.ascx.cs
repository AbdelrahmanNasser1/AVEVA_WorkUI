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

public partial class WebControls_RibbonBar : System.Web.UI.UserControl
{
    protected string templateDirectory = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        Skelta.Repository.Web.ListControl _ListControl = null;
        _ListControl = (Skelta.Repository.Web.ListControl)this.Context.Items["___skelta_listcontrol"];

        templateDirectory = _ListControl.TemplateDirectory +"Repository/ListControl/";

    }
}
