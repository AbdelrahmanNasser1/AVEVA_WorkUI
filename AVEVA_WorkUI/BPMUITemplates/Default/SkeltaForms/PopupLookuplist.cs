using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using Skelta.Forms.Core.Controls;
using Skelta.Forms.Core.Controls.DesignTime;
using Skelta.Forms.Core;
using Skelta.Forms.Core.Interfaces;
using Telerik.Web.UI;
using Skelta.Forms.Web.Designer;
using Workflow.NET;
using Skelta.Forms.Codebehind;
using Skelta.FarmManager;


public partial class PopupLookuplist : System.Web.UI.Page
{
    protected Skelta.Repository.Web.Lookup.ListLookup listlookup1 = new Skelta.Repository.Web.Lookup.ListLookup();
    protected Skelta.Entity.UserContext usrctx;
    protected Skelta.Repository.List.ListDefinition _List;
    protected string listitem = "";
    protected string listitemid = "";
    protected RadComboBox dl;
    protected Skelta.Repository.List.ListItem item;
    protected string ThemePath = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        ThemePath = Workflow.NET.TemplateExpressionBuilder.GetUrl("").ToString();
        Label l1 = new Label();
        l1.Text = "Database List";
        l1.CssClass = "runtext";

        usrctx = new Skelta.Entity.UserContext();
        listlookup1.MinLength = 0;
        listlookup1.ID = "listlookup";
        listlookup1.ListName = "Connection List";
        listlookup1.Enabled = true;
        listlookup1.ApplicationName = usrctx.Repository.ApplicationName;
        listlookup1.StatusToDisplay = Skelta.Repository.DisplayStatus.All;
        //listlookup1.AutoPostBack = true;

        pnl1.Controls.Add(new LiteralControl("<table><tr><td width=70 class='runtext'>"));
        pnl1.Controls.Add(l1);
        pnl1.Controls.Add(new LiteralControl("</td><td>"));
        pnl1.Controls.Add(listlookup1);
        pnl1.Controls.Add(new LiteralControl("</td></tr></table>"));
    }

    protected void close_click(object sender, EventArgs e)
    {
        ClientScript.RegisterStartupScript(Type.GetType("System.String"), "CloseWindow", "<script language=\"javascript\">window.opener.location.reload();window.close();</script>");
    }

    protected void sendData_click(object sender, EventArgs e)
    {
        Cache["lookup"] = listlookup1.Text;
        ClientScript.RegisterStartupScript(Type.GetType("System.String"), "CloseWindow", "<script language=\"javascript\">window.opener.location.reload();window.close();</script>");
    }
     
  }

 