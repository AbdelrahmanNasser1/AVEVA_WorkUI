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
using System.IO;

public partial class SkeltaTemplates_Default_ProcessDesigner_SaveAsPNG : System.Web.UI.Page
{
    ProcessDesignerAdapter pda;
    protected ProcessDesigner ProcessDesignerControl;

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

        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=" + ProcessDesignerControl.ApplicationName + "_" + ProcessDesignerControl.WorkflowName + "_" + ProcessDesignerControl.FileName + ".png");
        Response.BinaryWrite(ProcessDesignerControl.GetProcessImageBytes(zoom, false));
        Response.End();
    }

}
