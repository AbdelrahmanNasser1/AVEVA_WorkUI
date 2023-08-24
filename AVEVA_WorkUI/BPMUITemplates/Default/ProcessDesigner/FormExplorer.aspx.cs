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
using Workflow.NET;
using Skelta.Repository.Web.Lookup;
using Telerik.Web.UI;
using Skelta.Repository.List;
using Skelta.Repository;
using System.Collections.Generic;
using System.Text;

public partial class FormExplorer : System.Web.UI.Page
{
    protected VersionLookup formVersionLookup;
    protected RadComboBox formlistexplorerCombo;
    Skelta.Repository.List.ListItemCollection formslistItemCollection;
    protected SkeltaResourceSetManager formExplorer = new SkeltaResourceSetManager();
    protected string cssPath = Workflow.NET.TemplateExpressionBuilder.GetUrl("").ToString();
    string appName;
    string selectText;

    protected void Page_Load(object sender, EventArgs e)
    {
        
        selectText = formExplorer.GlobalResourceSet.GetString("ListLookup_Select");
        save.Value = formExplorer.GlobalResourceSet.GetString("Get_Schema");
        appName = Request["ApplicationName"];       
        GetFormsTable();
        formlistexplorerCombo = new RadComboBox();
        //check the control id.
        formlistexplorerCombo.ID = "formComboBox";
        formlistexplorerCombo.Skin = "AWTCombobox";

        

        formlistexplorerCombo.SelectedIndexChanged += new RadComboBoxSelectedIndexChangedEventHandler(formlistexplorerCombo_SelectedIndexChanged);
        PopulateListExplorerComboWithFormNames();
        formlistexplorerCombo.Height = 120;
        formlistexplorerCombo.DropDownWidth = 210;
        formlistexplorerCombo.EnableLoadOnDemand = true;
        formlistexplorerCombo.ItemsRequested += new RadComboBoxItemsRequestedEventHandler(formlistexplorerCombo_ItemsRequested);
        formlistexplorerCombo.AutoPostBack = true;
        formlistexplorerCombo.AllowCustomText = false;
        formlistexplorerCombo.EnableEmbeddedSkins = false;
        formlistexplorerCombo.Width = 220;
        
        //
        // {Rupesh M. Kokal}
        // Note: In IE browsers, RadCombobox have issues. Please refer to the RadCombobox.js 
        // file in the themes folder for more information. Hence to use the RadCombobox.js from
        // the themes folder, we set UseEmbeddedScripts to false.
        //
        //formlistexplorerCombo.UseEmbeddedScripts = false;

        pnl.Controls.Add(formlistexplorerCombo);
        
        RadComboBox formVersionLookupDummy = new RadComboBox();
        formVersionLookupDummy.ID = "versionlookupdummy";
        formVersionLookupDummy.Skin = "AWTCombobox";
        formVersionLookupDummy.Width = 220;        
        formVersionLookupDummy.EnableLoadOnDemand = false;
        formVersionLookupDummy.EnableEmbeddedSkins = false;
        formVersionLookupDummy.Items.Add(new RadComboBoxItem(selectText,Guid.Empty.ToString()));
        pnl2.Controls.Add(formVersionLookupDummy);

        

        //propertyname=XmlVariables&selectedAction=Start&ApplicationName=REO1&WorkflowName=testForm1&FileName=1&TemplateName=Default&Cul=en-US&pdsuri=XVL97zajEbW3xgs1QYr3LeoZnFaBBKCf_Oxcemao0m8!&SkDii=1b6535e3f002400fa18c251952cb6907&variablename=SKEventData
    }

    /// <summary>
    /// This function is used to show the items which starts with the character/s entered in the Look up text box.
    /// </summary>
    /// <param name="o">Current object from which event is fired</param>
    /// <param name="e">Event arguments</param>
    public void formlistexplorerCombo_ItemsRequested(object o, RadComboBoxItemsRequestedEventArgs e)
    {
        PopulateListExplorerComboWithFormNames(); //loads data into formlistexplorerCombo combo box
        int count = formlistexplorerCombo.Items.Count;
        if (!string.IsNullOrEmpty(e.Text))
        {
            //loop through each element in the combo box
            //and remove the items whose text is not starting with the specified text in e.Text
            for (int i = count - 1; i >= 0; i--)
            {
                if (!formlistexplorerCombo.Items[i].Text.ToLower().StartsWith(e.Text.ToLower()))
                    formlistexplorerCombo.Items.Remove(i);
            }
        }
    }

    private void GetFormsTable()
    {
        try
        {
            formslistItemCollection = new Skelta.Repository.List.ListItemCollection(new ListDefinition(new Skelta.Core.ApplicationObject(appName), "Forms List"));

        }
        catch (Exception ex)
        {
            throw new Exception("Error at getting the ListItemCollection for Forms List with Application Name : " + appName + " : Additional Information " + ex.Message);
        }
    }

    private void PopulateListExplorerComboWithFormNames()
    {
        //Workflow.NET.CommonFunctions.GetAllWorkFlows("asd");

        //formlistexplorerCombo.DataSource = formslistItemCollection.GetRecordsWithAllFields("", "", "sysuser");
        formlistexplorerCombo.DataSource = formslistItemCollection.GetRecordsForConsume("", new List<IDataParameter>(), Display.AllItems, "sysuser", true, new List<string>(), 0, DisplayItemType.NonFolders);
        formlistexplorerCombo.DataValueField = "Id";
        formlistexplorerCombo.DataTextField = "f00100_1";
        formlistexplorerCombo.DataBind();        
        formlistexplorerCombo.Items.Insert(0, new RadComboBoxItem(selectText, Guid.Empty.ToString()));
    }

    void formlistexplorerCombo_SelectedIndexChanged(object o, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        //throw new Exception("The method or operation is not implemented.");
        formVersionLookup = new VersionLookup();
        formVersionLookup.ID = "versionlookup";

        if(!string.IsNullOrEmpty(formlistexplorerCombo.SelectedValue))
            formVersionLookup.ListItemId = new Guid(formlistexplorerCombo.SelectedValue);
        formVersionLookup.ApplicationName = appName;
        formVersionLookup.ListName = "Forms List";
        formVersionLookup.DropDownHeight = 80;
        formVersionLookup.Width = 220;
        formVersionLookup.VersionType = Skelta.Repository.Web.Lookup.VersionLookup.VersionTypes.All;
        pnl2.Controls.Clear();
        pnl2.Controls.Add(formVersionLookup);

    }

}
