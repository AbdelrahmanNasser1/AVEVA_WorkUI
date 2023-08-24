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

public partial class SkeltaTemplates_Default_openimage : System.Web.UI.Page
{
    ProcessDesignerAdapter pda;
    protected ProcessDesigner ProcessDesignerControl;
    protected string HelpUrl;

    protected void Page_Load(object sender, EventArgs e)
    {
        pda = new ProcessDesignerAdapter();
        pda.LoadControlInstance(false);
        ProcessDesignerControl = pda.ProcessDesignerControl;

        /*FileStream fs=File.Create("c:\\temp\\test.emf");
        
        byte[] bytes=ProcessDesignerControl.GetProcessImageBytes(1.0F, true);
        fs.Write(bytes, 0, bytes.Length);
        fs.Close();*/

        float zoom = 1.0F;
        int zoomi=0;
        string zoomString = this.Request["zoom"];
        if (!string.IsNullOrEmpty(zoomString))
           int.TryParse(zoomString, out zoomi);

       if (zoomi > 0)
           zoom =(float)Math.Round((double)zoomi / 100,2);

        Response.Clear();
        Response.ContentType = "image/png";
        Response.BinaryWrite(ProcessDesignerControl.GetProcessImageBytes(zoom,false));
        Response.End();
    }
}
