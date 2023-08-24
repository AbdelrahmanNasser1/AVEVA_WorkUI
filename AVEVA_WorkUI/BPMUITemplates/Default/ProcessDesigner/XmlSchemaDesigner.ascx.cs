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
using Workflow.NET.Web.Designer;

public partial class SkeltaTemplates_Default_ProcessDesigner_XmlSchemaDesigner : System.Web.UI.UserControl
{
    protected XmlSchemaDesigner xmlSchemaDesigner;
    protected void Page_Load(object sender, EventArgs e)
    {
        xmlSchemaDesigner = (XmlSchemaDesigner)(this.Parent);
    }
}
