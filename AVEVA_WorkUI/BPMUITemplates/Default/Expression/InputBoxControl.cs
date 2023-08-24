namespace Workflow.NET.Template
{
    using System;
    using System.Data;
    using System.Drawing;
    using System.Web;
    using System.Web.UI.WebControls;
    using System.Web.UI.HtmlControls;
    using Workflow.NET.ExpressionBuilder;
    using Workflow.NET.Web.Designer;


    /// <summary>
    ///		Summary description for Control.
    /// </summary>
    public class ControlScriptIB : System.Web.UI.UserControl
    {
        protected InputBox inpBox;
        protected System.Web.UI.WebControls.PlaceHolder ControlPlaceHolder;
        protected Literal literalControl1 = new Literal();
        private Expression _expression = new Expression();
        protected bool loadExpression = false;
        protected string expExpressionEditor = "";
        protected string expClearExp = "";
        protected string PdID = "";




        private void Page_Load(object sender, System.EventArgs e)
        {

            _expression = inpBox.Expression;
            if (_expression.ExpressionString != null)
            {
                loadExpression = true;
            }
            inpBox.JSONExpression = Server.HtmlEncode(inpBox.JSONExpression);
            literalControl1.Text = inpBox.RegisterScript();

            ProcessDesignerAdapter PDA = new ProcessDesignerAdapter();
            PDA.LoadControlInstance(false);
            ProcessDesigner ProcessDesignerControl = PDA.ProcessDesignerControl;
            PdID = ProcessDesignerControl.ID;
            expExpressionEditor = ProcessDesignerControl.GlobalResourceSet.GetString("ExpExpressionEditor");
            expClearExp = ProcessDesignerControl.GlobalResourceSet.GetString("ExpClearExp");




            if (!Page.ClientScript.IsStartupScriptRegistered("Bubble"))
            {
                // Form the script to be registered at client side.
                String scriptString = "";
                scriptString += "<div id=\"bubbleWindow\" style=\"background-color:#ffffe1;border:1px solid black; CURSOR: text; font-family: Verdana, Arial, Helvetica, sans-serif;	font-size: 10px; TEXT-ALIGN:left;\"></div>";
                this.Page.ClientScript.RegisterStartupScript(this.GetType(), "Bubble", scriptString);
            }


            if (!Page.ClientScript.IsStartupScriptRegistered("Startup"))
            {
                // Form the script to be registered at client side.
                String scriptString = "<script language=JavaScript>";
                scriptString += "var inputCancelImage='" + inpBox.GetTemplateRelativeUrl("graphics/input-iocn.gif") + "';\n";
                scriptString += "var PDID='" + ProcessDesignerControl.ID + "';\n";
                //scriptString += "var LocaleExpDelete='" + ProcessDesignerControl.GlobalResourceSet.GetString("ExpDeleteExp") + "';\n";
                scriptString += "var LocaleExpDelete=\"" + ProcessDesignerControl.GlobalResourceSet.GetString("ExpDeleteExp") + "\"\n";
                
                scriptString += "var bubbleWindowObj = document.getElementById(\"bubbleWindow\");\n";
                scriptString += "bubbleWindowObj.style.display=\"none\";\n";
                scriptString += "var expClearExp='" + expClearExp + "'";
                scriptString += "<";
                scriptString += "/";
                scriptString += "script>";
                this.Page.ClientScript.RegisterStartupScript(this.GetType(), "Startup", scriptString);
            }


        }

        #region Web Form Designer generated code
        override protected void OnInit(EventArgs e)
        {
            //
            // CODEGEN: This call is required by the ASP.NET Web Form Designer.
            //
            InitializeComponent();
            base.OnInit(e);
            inpBox = (InputBox)(this.Parent);
        }

        /// <summary>
        ///		Required method for Designer support - do not modify
        ///		the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.Load += new System.EventHandler(this.Page_Load);
        }
        #endregion
    }
}

