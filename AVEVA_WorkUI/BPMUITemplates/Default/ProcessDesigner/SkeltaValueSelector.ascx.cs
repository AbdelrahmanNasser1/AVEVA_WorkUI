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

public partial class SkeltaValueSelector : System.Web.UI.UserControl
{
    //protected ValueSelector ValSelect;
    protected Literal literalControl1 = new Literal();
    protected string CtrlID = "";
    protected string CreateVar = "";
    protected string ValueItem = "Value";
    
    private string _valueType = "Value";
    private string _Value = "";
    private string _VariableOptions = "";
    private string _ContentOptions = "";
       
    protected void Page_Load(object sender, EventArgs e)
    {        
        CtrlID = this.ID;
        CreateVar = "window." + CtrlID + "=new ValueType('" + CtrlID + "');"; 
        

        

    }

    public string ValueType
    {
        get 
        { 
            string Expr = this.hValue.Value;
            if (Expr != "")
            {
                _valueType = GetValueFromExpression(ref Expr);
            }
            return _valueType; 
        }
        set { _valueType = value;}
    }

    private string _IsValueVisible = "true";
    public string IsValueVisible
    {
        get
        {
            return _IsValueVisible;
        }
        set
        {
            _IsValueVisible = value;
            if (_IsValueVisible.ToLower() == "false")
            {
                ValueItem = "Select";
                if (_valueType == "Value")
                    _valueType = "Select";
            }
        }
    }

    public string Value
    {
        get 
        {
            string Expr = this.hValue.Value;
            if (Expr != "")
            {
                _valueType = GetValueFromExpression(ref Expr);
                _Value = GetValueFromExpression(ref Expr);//this.hValue.Value;//this.Request["hValue"];
            }
            else
                _Value = "";
            return _Value;
        }
        set 
        {
            
            _Value = value;
            string Expr = GetSizePrefixedString(_valueType) + GetSizePrefixedString(_Value);
            this.hValue.Value = Expr;
        }
    }

    /// <summary>
    /// Set or get Skelta Variable options to fill the Variable drop down. 
    /// It should be html script like "<OPTION value='Variable.AbcDe'>Variable.Abc De</OPTION>
    /// </summary>
    public string VariableOptions
    {
        get { return _VariableOptions; }
        set { _VariableOptions = value; }
    }

    /// <summary>
    /// Set or get Skelta Content options to fill the Content drop down. 
    /// </summary>
    public string ContentOptions
    {
        get { return _ContentOptions; }
        set { _ContentOptions = value; }
    }


    private string GetValueFromExpression(ref string sData)
    {
        int iLength = int.Parse(sData.Substring(0, 4));
        sData = sData.Substring(4);
        int RowLength = 0;
        string sVal = sData.Substring(0, iLength);
        sData = sData.Substring(iLength); ;
        return sVal;
    }

    private string ConvertToString(int number, int width)
    {
        string str = number.ToString();
        str = str.PadLeft(4, '0');
        return str;
    }
    private string GetSizePrefixedString(string Expr)
    {
        return ConvertToString(Expr.Length, 4) + Expr;
    }

    #region Web Form Designer generated code
    override protected void OnInit(EventArgs e)
    {
        //
        // CODEGEN: This call is required by the ASP.NET Web Form Designer.
        //
        InitializeComponent();
        base.OnInit(e);
        //ValSelect = (ValueSelector)(this.Parent);
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
