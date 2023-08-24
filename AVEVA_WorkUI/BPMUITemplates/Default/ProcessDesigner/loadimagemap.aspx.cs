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

public partial class SkeltaTemplates_Default_ProcessDesigner_loadimagemap : System.Web.UI.Page
{
    ProcessDesignerAdapter pda;
    protected ProcessDesigner ProcessDesignerControl;
    protected string uniqueId = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        pda = new ProcessDesignerAdapter();
        pda.LoadControlInstance(false);
        ProcessDesignerControl = pda.ProcessDesignerControl;

        float zoom = 1.0F;
        int zoomi = 0;
        string zoomString = this.Request["zoom"];
        if (!string.IsNullOrEmpty(zoomString))
            int.TryParse(zoomString, out zoomi);

        if (zoomi > 0)
            zoom = (float)Math.Round((double)zoomi / 100, 2);

        string map = ProcessDesignerControl.GetProcessImageAreaMap(zoom);
        string[] mapArr = map.Split(new string[] { "##" }, StringSplitOptions.None);
        map = mapArr[0];
        if (mapArr.Length == 2)
        {
            uniqueId = mapArr[1];
        }
        mapplaceholder.Controls.Add(new LiteralControl(map));

       // mapplaceholder.Controls.Add(new LiteralControl(ProcessDesignerControl.GetProcessImageAreaMap(zoom)));
    }
}
