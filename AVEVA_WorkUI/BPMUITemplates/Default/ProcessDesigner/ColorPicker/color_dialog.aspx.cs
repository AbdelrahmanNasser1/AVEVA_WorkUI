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


public partial class BPMUITemplates_Default_ProcessDesigner_ColorPicker_color_dialog : System.Web.UI.Page
{
    protected Workflow.NET.SkeltaResourceSetManager ResourceManager;
    protected void Page_Load(object sender, EventArgs e)
    {
        ResourceManager = new Workflow.NET.SkeltaResourceSetManager();
        
    }
}
