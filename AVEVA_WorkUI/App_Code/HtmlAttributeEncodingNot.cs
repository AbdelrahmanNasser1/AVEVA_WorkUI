using System;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.IO;
using System.Text;

/// <summary>
/// Summary description for HttpEncoder
/// </summary>
public class HtmlAttributeEncodingNot : System.Web.Util.HttpEncoder
{
    protected override void HtmlAttributeEncode(string value, System.IO.TextWriter output)
    {
        //Old code - had performance issues.
        //value = value.Replace("&", "&amp;").Replace("<", "&lt;").Replace("\"", "&quot;");
        if (value != null)
        {
            if (output == null)
            {
                throw new ArgumentNullException("output");
            }
            foreach (char c in value)
            {

                switch (c)
                {
                    case '&':
                        output.Write("&amp;");
                        break;
                    case '<':
                        output.Write("&lt;");
                        break;
                    case '"':
                        output.Write("&quot;");
                        break;
                    default:
                        output.Write(c);
                        break;
                }
            }
        }

    }

}
