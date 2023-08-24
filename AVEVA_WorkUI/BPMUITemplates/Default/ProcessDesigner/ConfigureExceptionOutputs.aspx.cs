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
using System.Collections;
using Skelta.FarmManager;
using Workflow.NET;
using Workflow.NET.Web.Designer;
using System.Collections.Generic;
using Skelta.Core;
using Skelta.HWS;
using System.Xml;

namespace Skelta.Repository.CodeBehind.Codebehind.Site
{

    //------------------------------------------------------------------------------
    // Copyright (C) 2010 Invensys Systems Inc.  All rights reserved.
    // 
    // THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY
    // KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
    // IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
    // PARTICULAR PURPOSE.
    //------------------------------------------------------------------------------

    public partial class ConfigureExceptionOutputs : System.Web.UI.Page
    {
        
        protected String actionname = "";
        protected String propertyname = "";
        protected String valueString = "";
        protected String filename = "";
        public static string AdminUrl = "";
        public static string UserUrl = "";
        public static string _ApplicationName = "";
        public string _WorkflowName = "";
        public string _FileName = "";
        public string _TemplateName = "";
        public string _DesignerInstanceId = "";
        public string _Culture = "";
        
        protected ProcessDesignerAdapter PdAdapter;
        protected ProcessDesigner PdCtrl;
        protected Property selProperty = null;

        protected string _propertyHeading = "";
        protected string _MappedErrorOutputs = "";
        protected string _ErrorBehaviour = "";
        protected string _MappedErrorOutputsDescription = "";
        protected string _MappedErrorOutputsLinksDescription = "";
        protected string _ExcludeOrIncludeOutputsMessage = "";
        protected string _ErrorBehaviourDescription = "";
        protected string _ErrorBehaviourItemsDescription = "";
        protected string _ErrorBehaviourItems1Description = "";
        bool isErrorOutputsChanged = false;
        System.Collections.Generic.SortedDictionary<string, bool> actionXmlErrorOutputs = new SortedDictionary<string, bool>();
        bool isStopOnExceptionPropertyOverrided = false;
        protected string _NoOutputs = "";
        protected string _RaiseErrorDescription = "";
        protected string _SpChanged = "";
        protected string _PropStopOnExceptionHidden = "";
        protected string cssPath = "";
        protected string _EnableErrorEncounteredDesc = "";
        protected string helpUrl = "";
        protected string helpText = "";
        protected void Page_Load(object sender, EventArgs e)
        {

            cssPath = Convert.ToString(Workflow.NET.TemplateExpressionBuilder.GetUrl(""));
            actionname = this.Context.Request["actionname"];
            propertyname = this.Context.Request["selpropertyname"];
            filename = this.Context.Request["wfFilename"];

            _ApplicationName = this.Context.Request["ApplicationName"];
            _WorkflowName = this.Context.Request["WorkflowName"];
            _FileName = this.Context.Request["FileName"];
            _TemplateName = this.Context.Request["TemplateName"];
            _DesignerInstanceId = this.Context.Request["SkDii"];
            _Culture = this.Context.Request["cul"];
            System.Threading.Thread.CurrentThread.CurrentUICulture = new System.Globalization.CultureInfo(_Culture);
            
            InitializePdControl();
            

            _propertyHeading = PdCtrl.GlobalResourceSet.GetString("Raise Error on Unhandled Linked Output");
            _MappedErrorOutputs = PdCtrl.GlobalResourceSet.GetString("Mapped Error Outputs");
            _ErrorBehaviour = PdCtrl.GlobalResourceSet.GetString("Error Behaviour");
            _MappedErrorOutputsDescription = PdCtrl.GlobalResourceSet.GetString("MappedErrorOutputDescription");
            _MappedErrorOutputsLinksDescription = PdCtrl.GlobalResourceSet.GetString("MappedErrorOutputLinkDescription");
            _ExcludeOrIncludeOutputsMessage = PdCtrl.GlobalResourceSet.GetString("ExcludeOrIncludeOutputsMessage");   
            _ErrorBehaviourDescription = PdCtrl.GlobalResourceSet.GetString("ErrorBehaviourDescription");
            _RaiseErrorDescription = PdCtrl.GlobalResourceSet.GetString("RaiseErrorPropertyDescription");
            _ErrorBehaviourItemsDescription = PdCtrl.GlobalResourceSet.GetString("ErrorBehaviourItemsDescription");
            _ErrorBehaviourItems1Description = PdCtrl.GlobalResourceSet.GetString("ErrorBehaviourItems1Description");
//            _PropStopOnExceptionHidden = PdCtrl.GlobalResourceSet.GetString("PropStopOnExceptionHidden"); 
            _EnableErrorEncounteredDesc = PdCtrl.GlobalResourceSet.GetString("EnableErrorEncounteredDesc");
            
            helpUrl = PdCtrl.GetHelpPageUrl();
            helpText = PdCtrl.GlobalResourceSet.GetString("Help");  


            Workflow.NET.Action selAction = PdCtrl.ProcessDefinition.Actions[actionname];
            selProperty = selAction.Properties[propertyname];


            SortedList sl = selAction.GetReturnValues();
            foreach (ReturnValue r in sl.Values)
            {
                
                if (r.Value == "Error Encountered")
                    continue;
              ListItem strListItem = new ListItem(PdCtrl.GlobalResourceSet.GetString(r.Value), r.Value);
             //   ListItem strListItem = new ListItem(PdCtrl.GlobalResourceSet.GetString("Pt_Error_Occurred"), r.Value);
                
                if (r.IsErrorOutput)
                {
                    strListItem.Selected = true;
                    //strListItem.Attributes.Add("Style", "color: #c20f13;");
                    actionXmlErrorOutputs.Add(r.Value, true);
                }

                if(!chkOutPuts.Items.Contains(strListItem))  
                    chkOutPuts.Items.Add(strListItem);


            }
            if (sl.Count == 1 || sl.Count==0)
            {
                if(sl.ContainsKey("Error Encountered")) 
                    _NoOutputs = PdCtrl.GlobalResourceSet.GetString("NoOutputsDescription");
                else
                    _NoOutputs = PdCtrl.GlobalResourceSet.GetString("NoOutputsDescription");
            }

            //reading the start property

            Workflow.NET.Action startAction = PdCtrl.ProcessDefinition.Actions["Start"];
            string isConfiguredAtWorkflowLevel = "";
            if (startAction.Properties.Contains("Raise Exception if Completion Maker Output is not linked?"))
            {
                isConfiguredAtWorkflowLevel = (string)((Property)startAction.Properties["Raise Exception if Completion Maker Output is not linked?"]).Value;
            }

            //Handled for Sharepoint Stop On Exceptions Property
            string stopOnExceptions = ""; 
            if (selAction.Properties.Contains("StopOnExceptions"))
            {
                stopOnExceptions = Convert.ToString(selAction.Properties["StopOnExceptions"].Value);
                isStopOnExceptionPropertyOverrided = true;
                isErrorOutputsChanged = true;

                
                    if (isConfiguredAtWorkflowLevel == "Default [Backward Compatible]")
                    {
                        if (stopOnExceptions.ToUpperInvariant() == "YES")
                            _SpChanged = PdCtrl.GlobalResourceSet.GetString("SponExceptionYes");
                        else if(stopOnExceptions.ToUpperInvariant() == "NO")
                            _SpChanged = PdCtrl.GlobalResourceSet.GetString("SponExceptionNo");
                    }
                               

            }
            string errorsEncounteredProperty = "";
            if (selAction.Properties.Contains("Errors"))
            {
                errorsEncounteredProperty = Convert.ToString(selAction.Properties["Errors"].Value);    
                if (isConfiguredAtWorkflowLevel == "Default [Backward Compatible]")
                {
                    if (errorsEncounteredProperty.ToUpperInvariant() == "NO")
                        _SpChanged += PdCtrl.GlobalResourceSet.GetString("SponEnableErrorNo");
                    else
                        _SpChanged += PdCtrl.GlobalResourceSet.GetString("SponEnableErrorYes");
                }

            }

            if (_SpChanged != "")
            {
                if(stopOnExceptions!="")
                    _PropStopOnExceptionHidden = PdCtrl.GlobalResourceSet.GetString("PropStoponExceptionhidden");   
                else
                    _PropStopOnExceptionHidden = PdCtrl.GlobalResourceSet.GetString("PropEnableErrorsHidden");   
            }
            
            if (!IsPostBack)
            {

                
                //For Setting the Error Behaviour property

                radErrorBehaviour.Items.Add(new ListItem(PdCtrl.GlobalResourceSet.GetString("Stop With Error"), "Stop With Error"));
                radErrorBehaviour.Items.Add(new ListItem(PdCtrl.GlobalResourceSet.GetString("Exit Activity With Error Output"), "Error Encountered"));
       
                                
                Workflow.NET.PropertyTypes.PropertyRaiseError pr = (Workflow.NET.PropertyTypes.PropertyRaiseError)selProperty.PropertyHandler;

                string strExcludedOutputs = pr.ExcludedErrorOutputs;
                string strIncludedOutputs = pr.IncludedErrorOutputs;

                if (strIncludedOutputs != "")
                {
                    string[] strIncludedOutputsArray = strIncludedOutputs.Split(',');

                    for (int i = 0; i < strIncludedOutputsArray.Length; i++)
                    {

                        ListItem oSelectedItem = chkOutPuts.Items.FindByValue(strIncludedOutputsArray[i]);
                        if (oSelectedItem != null)
                        {
                            oSelectedItem.Selected = true;
                        }
                    }

                }

                if (strExcludedOutputs != "")
                {
                    string[] strExcludedOutputsArray = strExcludedOutputs.Split(',');

                    for (int i = 0; i < strExcludedOutputsArray.Length; i++)
                    {
                        ListItem oSelectedItem = chkOutPuts.Items.FindByValue(strExcludedOutputsArray[i]);
                        if (oSelectedItem != null)
                        {
                            oSelectedItem.Selected = false;
                        }
                    }

                }

                //Changes made for the Sharepoint Activities for overriding the Stop On Exceptions property
                if (selAction.Properties.Contains("StopOnExceptions"))
                {
                    
                    if (selAction.Properties.Contains("StopOnExceptions"))
                    {
                        stopOnExceptions = Convert.ToString(selAction.Properties["StopOnExceptions"].Value);                        
                    }


                    if (pr.StopOnError && stopOnExceptions.ToUpperInvariant() == "YES")
                    {
                        if (radErrorBehaviour.Items.Contains(radErrorBehaviour.Items.FindByValue("Stop With Error")))
                            radErrorBehaviour.Items.FindByValue("Stop With Error").Selected = true;

                    }
                    else
                    {
                        if (radErrorBehaviour.Items.Contains(radErrorBehaviour.Items.FindByValue("Error Encountered")))
                            radErrorBehaviour.Items.FindByValue("Error Encountered").Selected = true;


                    }


                }
                else //For Normal Activities
                {


                    if (pr.StopOnError)
                    {
                        if (radErrorBehaviour.Items.Contains(radErrorBehaviour.Items.FindByValue("Stop With Error")))
                            radErrorBehaviour.Items.FindByValue("Stop With Error").Selected = true;

                    }
                    else
                    {
                        if (radErrorBehaviour.Items.Contains(radErrorBehaviour.Items.FindByValue("Error Encountered")))
                            radErrorBehaviour.Items.FindByValue("Error Encountered").Selected = true;


                    }

                }

            }

            chkOutPuts.SelectedIndexChanged += new EventHandler(chkOutPuts_SelectedIndexChanged);
            radErrorBehaviour.SelectedIndexChanged += new EventHandler(radErrorBehaviour_SelectedIndexChanged); 
            
            btnOk.Value = PdCtrl.GlobalResourceSet.GetString("Ok");
            btnCancel.Value = PdCtrl.GlobalResourceSet.GetString("Cancel");    
                

        }

        void radErrorBehaviour_SelectedIndexChanged(object sender, EventArgs e)
        {
            isErrorOutputsChanged = true;
        }

        void chkOutPuts_SelectedIndexChanged(object sender, EventArgs e)
        {
            isErrorOutputsChanged = true;
        }

        /// <summary>
        /// Initializing the Process Designer Control
        /// </summary>
        private  void InitializePdControl()
        {

            PdAdapter = new ProcessDesignerAdapter();
            PdAdapter.LoadControlInstance(false);
            PdCtrl = PdAdapter.ProcessDesignerControl;
            _ApplicationName = PdCtrl.ApplicationName;
            _WorkflowName = PdCtrl.WorkflowName;
            _FileName = PdCtrl.FileName;
            PdCtrl.InitializeValues();

        }


                        
        
        string GetSecuredValue()
        {
            Dictionary<string, string> dictSuri = new Dictionary<string, string>();
            dictSuri["s"] = _ApplicationName + _WorkflowName;
            return Workflow.NET.SecureUriParameters.GetEncryptedValue(dictSuri, true);
        }
        

        /// <summary>
        /// Code for Saving the Property value on click of OK Button 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>        
        protected void btnOk_Click(object sender, EventArgs e)
        {

            string strExceptionOutputSettings = "";

            if (isErrorOutputsChanged)
            {

                // getting the Selected checkbox items
                string strSelectedItems = "";
                foreach (ListItem lst in chkOutPuts.Items)
                {
                    if (lst.Selected)
                    {

                        if (!actionXmlErrorOutputs.ContainsKey(lst.Value))
                        {
                            if (strSelectedItems == "")
                                strSelectedItems = lst.Value;
                            else
                                strSelectedItems += "," + lst.Value;
                        }
                    }
                }

                // getting the Not Selected checkbox items
                string strUnSelectedItems = "";
                foreach (ListItem lst in chkOutPuts.Items)
                {
                    if (!lst.Selected)
                    {
                        if (actionXmlErrorOutputs.ContainsKey(lst.Value))
                        {
                            if (strUnSelectedItems == "")
                                strUnSelectedItems = lst.Value;
                            else
                                strUnSelectedItems += "," + lst.Value;
                        }
                        
                    }
                }

                //for Getting the Error Behaviour
                string stroptionsErrorBehaviour = "";
                stroptionsErrorBehaviour = radErrorBehaviour.SelectedValue;
                
                
                strExceptionOutputSettings = "";

                //Saving the value of the property in the definition
                Workflow.NET.PropertyTypes.PropertyRaiseError prRaiseError = (Workflow.NET.PropertyTypes.PropertyRaiseError)selProperty.PropertyHandler;
                prRaiseError.EnableRaiseErrors = true;
                prRaiseError.Value = strExceptionOutputSettings;
                prRaiseError.ExcludedErrorOutputs = strUnSelectedItems;
                prRaiseError.IncludedErrorOutputs = strSelectedItems;  

                if (stroptionsErrorBehaviour == "Stop With Error")
                {
                    prRaiseError.StopOnError = true;
                    
                }
                else
                {
                    prRaiseError.StopOnError = false;
                    
                }
                if (isStopOnExceptionPropertyOverrided)
                {
                    prRaiseError.StopOnExceptionPropertyOverrided = true;
                }
            }

            PdCtrl.WriteFile();            
            Response.Write("<script language='javascript'> window.setTimeout('window.opener.refreshselectedaction()',100);window.opener.parent._skProcessDesigner.RefreshProperties();window.setTimeout('window.close()',100); </script>");

        }



    }
}
