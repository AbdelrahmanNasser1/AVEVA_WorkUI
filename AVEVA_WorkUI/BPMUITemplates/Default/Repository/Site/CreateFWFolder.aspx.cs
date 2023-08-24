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
using System.Xml;
using ISNet.WebUI.WebGrid;
using System.Reflection;
using Skelta.Repository.Web.List;
using Skelta.Repository.List;
using Workflow.NET;
using Skelta.Forms.Core.Controls;
using System.IO;
using Skelta.Events;
using Skelta.Events.Interfaces;
using System.Collections.Generic;
using Skelta.Core;
using System.Text.RegularExpressions;


public partial class CreateFWFolder : System.Web.UI.Page
{
    private string _Repository = "";
    private string userId = "";
    public string error = "";
    public string title = string.Empty;
    public string ttleMesg = string.Empty;
    protected string cssPath = "";
    protected string imgPath = "";
    protected object styleUrl = Workflow.NET.TemplateExpressionBuilder.GetUrl("SOA");
    protected object imgUrl = Workflow.NET.TemplateExpressionBuilder.GetUrl("Repository/Site/Images");
    protected void Page_Load(object sender, EventArgs e)
    {
        cssPath = styleUrl.ToString();
        imgPath = imgUrl.ToString();
        ListPageParameters listParams = new ListPageParameters();
        listParams.ResolveCurrentUri();
        _Repository = listParams.ApplicationName;
        userId = listParams.LoggedInUserId;
        title = GetLangSpecText("ec_filewatcher_Add");
        ttleMesg = GetLangSpecText("ec_filewatcher_AddNew");
        txtFolderTitle.Focus();  
    }

    protected void btnNext_Click(object sender, EventArgs e)
    {
        
        try
        {
            if (txtFolderTitle.Text.Trim() == string.Empty)
            {
                error = GetLangSpecText("ec_filewatcher_title");
                return;
            }

            if (txtFolderPath.Text.Trim() == string.Empty || txtFolderPath.Text.Trim() == "\\")
            {
                error = GetLangSpecText("ec_filewatcher_Path");
                return;
            }
            if (txtFolderPath.Text.Length > 100)
            {
                error = GetLangSpecText("ec_filewatcher_Length");
                return;
            }


            string patternMatch = @"[#~&+\""'<>|@{}(),;^=!$]";
            Regex reg = new Regex(patternMatch, RegexOptions.CultureInvariant);
            if (Regex.IsMatch(txtFolderPath.Text, patternMatch))
            {

                error = GetLangSpecText("ec_filewatcher_SpecialCharacters");
                return;
            }

           

            ListDefinition objFileWList = new ListDefinition(new Skelta.Core.ApplicationObject(_Repository), "FileWatcher List");
            Skelta.Repository.List.ListItem Filelist = new Skelta.Repository.List.ListItem(objFileWList);
            Filelist.LoggedInUserId = userId;


            int flag = 0;
            AddInProviderCollection addInProviderCollection = new AddInProviderCollection(new ApplicationObject(_Repository));
            IEventClientServiceProvider fileEvntPrvdr = (IEventClientServiceProvider)addInProviderCollection.GetProvidersForType(false, "EventHost")["FileWatcher"];

            IEventPort fileEventPort = fileEvntPrvdr.GetNewEventPort();
            if (!txtFolderPath.Text.EndsWith("\\"))
            {
                txtFolderPath.Text = txtFolderPath.Text.ToUpper() + "\\";
            }
            fileEventPort.PortName = txtFolderPath.Text.Trim().ToUpper();
            ((ListTextDataItem)Filelist.ListForm.Records[0].FindControlByID("_sys_filewatcher_folder")).Value = txtFolderPath.Text.ToUpper();
            fileEventPort.PortXmlString = "<FILEWATCHER><PORTNAME>" + txtFolderPath.Text.ToUpper() + "</PORTNAME></FILEWATCHER>";
            string strPort = txtFolderPath.Text.Trim().ToUpper();
            string[] str = strPort.Split(':');
            if (str.Length > 1)
            {
                if (!str[1].StartsWith("\\"))
                {
                    str[1] = ":\\" + str[1];
                    strPort = "";
                    for (int i = 0; i < str.Length; ++i)
                    {
                        strPort = strPort + str[i];
                    }
                }
            }
            //bool chkFolder = false;

            //if (!Directory.Exists(strPort))
            //{
               
            //}
            //else
            //{
            //    chkFolder = true;
            //}

            //if (chkFolder == true)
            {
                Dictionary<string, IEventPort> eventPorts = GetAllEventPorts(_Repository, "FileWatcher");
                //int intCount = eventPorts.Count + 1;
                ((ListTextDataItem)Filelist.ListForm.Records[0].FindControlByID("_sys_filewatcher_title")).Value = txtFolderTitle.Text.Trim(); 
                foreach (string portName in eventPorts.Keys)
                {
                    if (eventPorts[portName].PortName == strPort)
                    {
                        flag = 1;
                        error = GetLangSpecText("ec_filewatcher_duplicateport");
                    }
                }

                if (flag == 0)

                {
                    EventServicePort evntServicePort = new EventServicePort(new ApplicationObject(_Repository));
                    evntServicePort.EventPort = fileEventPort;
                    try
                    {
                        Filelist.Save(ListItemVersionStatus.Published);
                    }
                    catch (Exception)
                    {
                        //Random random = new Random();
                        //((ListTextDataItem)Filelist.ListForm.Records[0].FindControlByID("_sys_filewatcher_title")).Value = txtFolderTitle.Text.Trim();
                        //Filelist.Save(ListItemVersionStatus.Published);
                        error = GetLangSpecText("ec_filewatcher_Dup");
                        return;
                    }
                    
                    evntServicePort.Save();
                  
                    Filelist = null;
                    

                    Page.ClientScript.RegisterClientScriptBlock(typeof(Page), "regJs", "<script>alert('New folder saved successfully');</script>");
                    Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "regJs", "<script>closeWindow();</script>");

                }
            }
            //else//
            //{
            //    error = GetLangSpecText("ec_filewatcher_portnotfound");
            //}

        }
        catch (Exception ex)
        {
            //error = GetLangSpecText("ec_filewatcher_Dup"); 
        }
    
} 
    protected string GetLangSpecText(string keyName)
    {
        SkeltaResourceSetManager resManager = new SkeltaResourceSetManager();
        return resManager.GlobalResourceSet.GetString(keyName);
    }





    private Dictionary<string, IEventPort> GetAllEventPorts(string _Repository, string eventProviderName)
    {
        //If it is not given here, for every serviceprovider class, geteventports method should be implemented.
        // it will be duplication of code everywhere.
           Dictionary<string, IEventPort> colEventPorts = new Dictionary<string, IEventPort>();
            if (_Repository !=string.Empty)
            {
                EventServicePortCollection colEventServicePorts = new EventServicePortCollection(new ApplicationObject(_Repository), eventProviderName);
                foreach (EventServicePort evntPort in colEventServicePorts.Items)
                    colEventPorts.Add(evntPort.Name, evntPort.EventPort);
            }
      

        return colEventPorts;
    }

   


}
