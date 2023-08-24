using System;
using System.Web.UI;
using Workflow.NET;

public partial class BPMUITemplates_Default_BAM_BAMExport : Page
{
    protected SkeltaResourceSet GR = new SkeltaResourceSetManager().GlobalResourceSet;
    protected string cssPath;

    protected void Page_Load(object sender, EventArgs e)
    {
        ExportRecords.Text = GR.GetString("ec_BAMReports_BtnExport");
        cssPath = Convert.ToString(TemplateExpressionBuilder.GetUrl(""));        
    }
}