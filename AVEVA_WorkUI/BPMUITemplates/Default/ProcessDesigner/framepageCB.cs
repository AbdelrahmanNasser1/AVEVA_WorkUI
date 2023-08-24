using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Workflow.NET.Web.Designer;

namespace Workflow.NET.Template
{
	/// <summary>
	/// Summary description for FramePage.
	/// </summary>
	public partial class FramePageCB : System.Web.UI.Page
	{
		protected ProcessDesigner ProcessDesignerControl;

		private void Page_Load(object sender, System.EventArgs e)
		{
			// Put user code to initialize the page here
			ProcessDesignerControl = (ProcessDesigner)this.Context.Items["__Skelta_Control_Transfer_From"];
		}

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    
			this.Load += new System.EventHandler(this.Page_Load);
		}
		#endregion
	}
}
