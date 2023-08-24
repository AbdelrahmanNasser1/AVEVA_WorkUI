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
using Workflow.NET;
using System.Xml;
using System.Text;

public partial class SkeltaTemplates_Default_ProcessDesigner_ConditionalExpression : System.Web.UI.Page
{
    protected ProcessDesigner ProcessDesignerControl;
    protected string _applicationName = "";
    protected string _workflowName = "";
    protected string _fileName = "";
    protected string _actionName = "";
    protected string _propertyNameName = "";
    protected StringBuilder _dllReferences;
    override protected void OnLoad(EventArgs e)
    {
        base.OnLoad(e);     
        ProcessDesignerAdapter PDA = new ProcessDesignerAdapter();
        PDA.LoadControlInstance(false);
        ProcessDesignerControl = PDA.ProcessDesignerControl;

        _applicationName = ProcessDesignerControl.ApplicationName;
        _workflowName = ProcessDesignerControl.WorkflowName;
        _fileName = ProcessDesignerControl.FileName;
        _actionName = this.Context.Request["selectedaction"];
        _propertyNameName = this.Context.Request["selectedProperty"];

        Workflow.NET.Action _selectedAction = ProcessDesignerControl.ProcessDefinition.Actions[_actionName];
        Property _selectedproperty = _selectedAction.Properties[_propertyNameName];
        
        //Instance of RuntimeObject Collection
        Workflow.NET.ExpressionBuilder.RuntimeObjectCollection runtimeObjectCollection = new Workflow.NET.ExpressionBuilder.RuntimeObjectCollection();
      
        //Adding Workflow.NET.Engine.Context object for getting the Workflow instance
        runtimeObjectCollection.Add(new Workflow.NET.ExpressionBuilder.RuntimeObject("Workflow Instance", typeof(Workflow.NET.Engine.Context), "Context", "Context", "_context"));
      
                
        //Instance of RenderInformationCollection Class
        Workflow.NET.ExpressionBuilder.RenderInformationCollection renderInfoCollection = new Workflow.NET.ExpressionBuilder.RenderInformationCollection();

         if(!ProcessDesignerControl.IsQuickflow)
         {
            //Render Information for rendering Variables info in Object Browser
            renderInfoCollection.Add(new Workflow.NET.ExpressionBuilder.RenderInformation("VariableNodeHandler", @"[INSTALLDIR]Bin\\SkeltaObjectLibrary.NET2.dll", "Workflow.NET.VariablesCollection", "VariableRenderer"));
            //Render Information for rendering Contents info in Object Browser
            renderInfoCollection.Add(new Workflow.NET.ExpressionBuilder.RenderInformation("ContentNodeHandler", @"[INSTALLDIR]Bin\\SkeltaObjectLibrary.NET2.dll", "Workflow.NET.ContentsCollection", "ContentRenderer"));
            //Render Information for rendering Resource Variable info in Object Browser
            renderInfoCollection.Add(new Workflow.NET.ExpressionBuilder.RenderInformation("ResourceNodeHandler", @"[INSTALLDIR]Bin\\SkeltaObjectLibrary.NET2.dll", "Workflow.NET.ResourcePropertiesCollection", "ResourceRenderer"));
            //Render Information for rendering Xml Variable info in Object Browser
            renderInfoCollection.Add(new Workflow.NET.ExpressionBuilder.RenderInformation("XMLVariableCollectionNodeHandler", @"[INSTALLDIR]Bin\\SkeltaObjectLibrary.NET2.dll", "Workflow.NET.XmlVariableCollection", "XMLVariableCollectionRenderer"));
            //Render Information for rendering Xml Variable info in Object Browser
            renderInfoCollection.Add(new Workflow.NET.ExpressionBuilder.RenderInformation("XMLVariableNodeHandler", @"[INSTALLDIR]Bin\\SkeltaObjectLibrary.NET2.dll", "Workflow.NET.XmlVariable", "XMLVariableRenderer"));
         }
         else
         {
             //Render Information for rendering Variables info in Object Browser
            renderInfoCollection.Add(new Workflow.NET.ExpressionBuilder.RenderInformation("VariableNodeHandler", @"[INSTALLDIR]Bin\\SkeltaObjectLibrary.NET2.dll", "Workflow.NET.VariablesCollection", "VariableRenderer"));
            //Render Information for rendering Xml Variable info in Object Browser
            renderInfoCollection.Add(new Workflow.NET.ExpressionBuilder.RenderInformation("XMLVariableCollectionNodeHandler", @"[INSTALLDIR]Bin\\SkeltaObjectLibrary.NET2.dll", "Workflow.NET.XmlVariableCollection", "XMLVariableCollectionRenderer"));
            //Render Information for rendering XMl Variable info in Object Browser
            renderInfoCollection.Add(new Workflow.NET.ExpressionBuilder.RenderInformation("XMLVariableNodeHandler", @"[INSTALLDIR]Bin\\SkeltaObjectLibrary.NET2.dll", "Workflow.NET.XmlVariable", "XMLVariableRenderer"));

         }
            
      
      
        

        //Instance of BindingObjects Class    
        Workflow.NET.ExpressionBuilder.BindingObjects bindingObjectCollection = new Workflow.NET.ExpressionBuilder.BindingObjects();

        if(!ProcessDesignerControl.IsQuickflow)
         {
      
          bindingObjectCollection.Add(new Workflow.NET.ExpressionBuilder.BindingObject("Workflow.NET.ResourcePropertiesCollection",ProcessDesignerControl.ActionsDefinition.Resources.ResourceProperties));
          bindingObjectCollection.Add(new Workflow.NET.ExpressionBuilder.BindingObject("Workflow.NET.ContentsCollection", ProcessDesignerControl.ProcessDefinition.Contents));          
         }

        
        bindingObjectCollection.Add(new Workflow.NET.ExpressionBuilder.BindingObject("Workflow.NET.VariablesCollection", ProcessDesignerControl.ProcessDefinition.Variables));
        bindingObjectCollection.Add(new Workflow.NET.ExpressionBuilder.BindingObject("Workflow.NET.XmlVariableCollection", ProcessDesignerControl.ProcessDefinition.XmlVariables, "Workflow.NET.XmlVariable"));
        
        
        StringBuilder exprExtnReferences = new StringBuilder();
        if(!ProcessDesignerControl.IsQuickflow)
         {
                if(_selectedproperty.PropertyHandler is Workflow.NET.IPropertyExpressionExtensionAssemblies)
                {
                    Workflow.NET.IPropertyExpressionExtensionAssemblies expressionExtnAssms = (Workflow.NET.IPropertyExpressionExtensionAssemblies)_selectedproperty.PropertyHandler;
            
                    for (int assmCount=0; assmCount < expressionExtnAssms.PropertyExpressionAssemblies.Count;assmCount++ )
                    {
                        Workflow.NET.ExpressionExtensionAssembly extnAssmbly
                                        = expressionExtnAssms.PropertyExpressionAssemblies[assmCount];
            
                        runtimeObjectCollection.Add(extnAssmbly.GetRunTimeObject(_applicationName));
                
                        Workflow.NET.ExpressionBuilder.RenderInformation rendererFromExpr = extnAssmbly.GetRendererInformation(_applicationName);
                        if(rendererFromExpr!=null)
                            renderInfoCollection.Add(rendererFromExpr);
                    
                        Workflow.NET.ExpressionBuilder.BindingObject bindingObjFromExpr = extnAssmbly.GetBindingObject(_applicationName,_selectedAction);
                        if(bindingObjFromExpr!=null)
                            bindingObjectCollection.Add(bindingObjFromExpr);
                
                        if (exprExtnReferences.Length > 0)
                            exprExtnReferences.Append(",");
                        exprExtnReferences.Append(extnAssmbly.GetReferenceDllPaths(_applicationName));
                    }
                }
         }        
        Workflow.NET.ExpressionBuilder.InputObjectsInfo inputObjectsInfo = new Workflow.NET.ExpressionBuilder.InputObjectsInfo();
        Workflow.NET.SOAObjectsCollection ObjectCollectionSoa = (Workflow.NET.SOAObjectsCollection)ProcessDesignerControl.ProcessDefinition.SOAObjects;
        _dllReferences = new StringBuilder();
        if(!ProcessDesignerControl.IsQuickflow)
         {
            if (ObjectCollectionSoa != null )
            {
                    
           
                foreach (SOAObject soaObj in ObjectCollectionSoa)
                {
                    // string sClassName = soaObj.SOANameSpace + '.' + soaObj.SOAClassName;
                    if ((soaObj.AssemblyFullName.ToString().Trim() != "") & (System.IO.File.Exists(soaObj.AssemblyFullName)))
                    {
                        //System.Reflection.Assembly asLoad = CommonFunctions.LoadAssembly(soaObj.AssemblyFullName);
                        //string sClass = soaObj.SOAClassName;
                        //Type tp = asLoad.GetType(sClassName);

                        //runtimeObjectCollection.Add(new Workflow.NET.ExpressionBuilder.RuntimeObject(soaObj.SOAClassName, tp, soaObj.SOAClassName));
                        //  System.Diagnostics.Debugger.Break();

                        //This commented to fix the issue Class's are displayed in dropdown of Decision action.
                        // runtimeObjectCollection.Add(new Workflow.NET.ExpressionBuilder.RuntimeObject(soaObj.SOAClassName, tp, soaObj.SOAClassName, soaObj.SOAClassName, soaObj.SOAClassName));

                        //  Workflow.NET.ExpressionBuilder.AssemblyDefinition newAssembly = new Workflow.NET.
                        if (_dllReferences.Length > 0)
                            _dllReferences.Append(",");
                        _dllReferences.Append(soaObj.AssemblyFullName);
                    }
                }
           
                //Added this for static methods //decision it was throwing error for static methods because the assembly was not geeting added to the inputObjectsInfo.ReferencedAssemblies
                System.Data.DataTable dtAssemblyList = Workflow.NET.ExpressionBuilder.SOAHandler.GetAllRegisteredAssemblies(_applicationName, 1);
                if (dtAssemblyList != null)
                {
                    foreach (System.Data.DataRow row in dtAssemblyList.Rows)
                    {
                        if (_dllReferences.Length > 0)
                            _dllReferences.Append(",");
                        _dllReferences.Append(row["AssemblyName"].ToString().Trim());
                    }

                }
               
                //Fix for the Webmethod issue in dicision action.
                System.Data.DataTable dtWebAssemblyList = Workflow.NET.ExpressionBuilder.SOAHandler.GetAllRegisteredAssemblies(_applicationName, 2);
                string Uri = string.Empty;
                string userID=string.Empty;
                string password=string.Empty;
                string domain = string.Empty;
                System.Reflection.Assembly loadAssembly = null;
                if (dtWebAssemblyList != null)
                {
                    foreach (System.Data.DataRow row in dtWebAssemblyList.Rows)
                    {

                        Uri = row["AssemblyName"].ToString().Trim();
                        string objeclXmlString = row["ObjectXml"].ToString().Trim();
                        System.Xml.XmlDocument xml = new XmlDocument();
                        xml.LoadXml(objeclXmlString);
                        System.Xml.XmlNodeList xnList = xml.SelectNodes("/UserInfo");
                        foreach (XmlNode xn in xnList)
                        {
                            userID = xn["UserName"].InnerText;
                            password = xn["Password"].InnerText;
                            domain=xn["Domain"].InnerText;
                        }

                        loadAssembly = CommonFunctions.CompileWSDLToProxy(Uri, userID, password, domain);
                        if (loadAssembly != null)
                        {
                            if (_dllReferences.Length > 0)
                                _dllReferences.Append(",");
                            _dllReferences.Append(loadAssembly.Location.Trim());
                        }
                           
                    }
                }
            }
            //This whole thing can be fine tuned with single function.
        }
      
        if (_dllReferences.Length > 0)
            _dllReferences.Append(",");

        _dllReferences.Append(@"[INSTALLDIR]Bin\\Workflow.NET.NET2.dll");
        
        if (exprExtnReferences.Length > 0)
               _dllReferences.Append(",");
        _dllReferences.Append(exprExtnReferences);
        
        string[] strDllReferences = _dllReferences.ToString().Trim().Split(',');
        inputObjectsInfo.RuntimeObjectCollection = runtimeObjectCollection;
        inputObjectsInfo.RenderInformationCollection = renderInfoCollection;
        inputObjectsInfo.ReferencedAssemblies = strDllReferences;
        inputObjectsInfo.BindingObjects = bindingObjectCollection;
        ConditionalDesigner1.InputObjectsInfo = inputObjectsInfo;	
    }
}
