using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Workflow.NET;
using Workflow.NET.Web.Designer;
using System.IO;
using System.Text;
using System.Xml;
using System.Xml.Schema;
using Telerik.Web.UI;

public partial class XmlStorageCode : System.Web.UI.Page
{
    List<XmlVariableNode> nodeCollection = new List<XmlVariableNode>();
    XmlSchema schema = new XmlSchema();
    protected ProcessDesigner ProcessDesignerControl;
    private string actionName = "";
    private string propertyName = "";
    private string selectedVariableName = "";
    protected string InternalStorage = "";
     

    protected void Page_Load(object sender, EventArgs e)
    {
        actionName = this.Request["selectedaction"].ToString();
        propertyName = this.Request["propertyName"].ToString();
        ProcessDesignerAdapter PDA = new ProcessDesignerAdapter();
        PDA.LoadControlInstance(false);
        ProcessDesignerControl = PDA.ProcessDesignerControl;

        if (this.Page.Request["variablename"] != null)
            selectedVariableName = this.Request["variablename"].ToString();

        if (!this.Page.IsPostBack)
        {
            if (selectedVariableName.Trim() != "")
            {
                BildXmlTreeObject();

                
            }
        }
        else
        {
            InternalStorage = this.Request["CmbInternalStorage"];
        }
        
    }

    private void BildXmlTreeObject()
    {

        Workflow.NET.Action _selectedAction = ProcessDesignerControl.ProcessDefinition.Actions[actionName];
        Property _selectedproperty = _selectedAction.Properties[propertyName];
        XmlVariableCollection varColl = ((Workflow.NET.PropertyTypes.PropertyXmlVariable)(_selectedproperty.PropertyHandler)).XmlVariableCollection;

        XmlVariable selvariable = new XmlVariable();

        foreach (XmlVariable xVaraiable in varColl.Values)
        {
            if (xVaraiable.Name == selectedVariableName)
            {
                selvariable = xVaraiable;
                break;
            }
        }


        if (selvariable.Name != "")
        {
           // InternalStorage = ((Workflow.NET.XmlStorageType.XmlDocument)(selvariable.StorageHandler)).StorageData;
            List<XmlVariableNode> nodeList = selvariable.GetXMLVaraiableNodeList();
 
            XmlVariableNode rootNode = new XmlVariableNode();
            if (nodeList.Count > 0)
            {
                string listName = "";
                foreach (XmlVariableNode xmlVarNode in nodeList)
                {
                    listName = xmlVarNode.Name;
                    rootNode = xmlVarNode;
                    break;
                }
                
                RadTreeNode treeNode = new RadTreeNode();
                treeNode.Text = listName;
                treeNode.Value = listName;
                BuildChildNodes(rootNode,treeNode);
                RadTree1.Nodes.Add(treeNode);
               
            }

        }

    }



    private void BuildChildNodes(XmlVariableNode xmlVarNode, RadTreeNode oRadTreeNode)
    {

        foreach (XmlVariableNode node in xmlVarNode.ChildNodes)
        {

            RadTreeNode treeNode = new RadTreeNode();
            treeNode.Text = XmlConvert.DecodeName(node.Name);
            treeNode.Value = node.Name;
            
            if (node.ChildNodes.Count > 0)
            {
                BuildChildNodes(node,treeNode);
            }
            oRadTreeNode.Nodes.Add(treeNode);
         }
    }
    
    
}
#region Comment
    //private void AjaxPageControl1_OnAjax_MethodCallEvent(object sender, string MethodName, Hashtable Arguments, out Workflow.NET.Ajax.ReturnTypeEnum ReturnType, out Workflow.NET.Ajax.JSObjectTable ReturnObject, out string ReturnXML)
    //{
    //    ReturnType = Workflow.NET.Ajax.ReturnTypeEnum.None;
    //    ReturnObject = null;
    //    ReturnXML = null;
    //    string variablename = "";
    //    string variabledescription = "";
    //    string internalStorage = "";
    //    string xslt = "";
    //    bool isValid = true;
    //    string editMode = "";
    //    string scope = "";
    //    switch (MethodName)
    //    {
    //        case "BuildXml":

    //            //return type of the object
    //            ReturnType = Workflow.NET.Ajax.ReturnTypeEnum.Object;

    //            //ReturnObject-to hold the data sent from the client
    //            ReturnObject = new Workflow.NET.Ajax.JSObjectTable(Arguments["table"]);

    //            //Casting the return object to JsObjectTable
    //            Workflow.NET.Ajax.JSObjectTable rootObj = (Workflow.NET.Ajax.JSObjectTable)ReturnObject.Value;

    //            try
    //            {
    //                foreach (Object o in rootObj.Keys)
    //                {
    //                    if (o.ToString() == "VaraiableName")
    //                        variablename = rootObj[o].Value.ToString();

    //                    else if (o.ToString() == "VaraiableDescription")
    //                        variabledescription = rootObj[o].Value.ToString();

    //                    else if (o.ToString() == "XmlSchema")
    //                    {
    //                        Workflow.NET.Ajax.JSObjectTable mainrootObj = (Workflow.NET.Ajax.JSObjectTable)rootObj[o];
    //                        BuildNodeList(mainrootObj);
    //                    }

    //                    else if (o.ToString() == "Xslt")
    //                    {
    //                        xslt = rootObj[o].Value.ToString();
    //                    }

    //                    else if (o.ToString() == "EditMode")
    //                    {
    //                        editMode = rootObj[o].Value.ToString();
    //                    }
    //                    else if (o.ToString() == "InternalStorage")
    //                    {
    //                        internalStorage = rootObj[o].Value.ToString();
    //                    }
    //                    else if (o.ToString() == "Scope")
    //                    {
    //                        scope = rootObj[o].Value.ToString();
    //                    }

    //                }

    //                Action _selectedAction = ProcessDesignerControl.ProcessDefinition.Actions[actionName];
    //                Property _selectedproperty = _selectedAction.Properties[propertyName];

    //                if (editMode == "ADD")
    //                {
    //                    if (variablename.Trim() != "")
    //                    {
    //                        isValid = ValidateVaraiable(variablename, ProcessDesignerControl.ProcessDefinition.Variables, ((Workflow.NET.PropertyTypes.PropertyXmlVariable)(_selectedproperty.PropertyHandler)).XmlVariableCollection);
    //                    }
    //                }
    //                if (isValid)
    //                {
    //                    if (xslt.Trim() != "")
    //                    {
    //                        xslt = xslt.Replace("&lt;", "<");
    //                        xslt = xslt.Replace("&gt;", ">");
    //                    }

    //                    string xsdschema = BuildXSdString();

    //                    XmlVariable xVariable = new XmlVariable();

    //                    Skelta.Core.AddInProvider provider = new Skelta.Core.AddInProvider(new Skelta.Core.ApplicationObject(ProcessDesignerControl.ApplicationName), GetProviderId("XmlDocument"));
    //                    Workflow.NET.Interfaces.IXmlStorageType _storageType = (Workflow.NET.Interfaces.IXmlStorageType)provider.CreateInstance(true);

    //                    if (editMode == "ADD")
    //                    {
    //                        xVariable.Name = variablename;
    //                        xVariable.Description = variabledescription;
    //                        xVariable.StorageType = "XmlDocument";
    //                        xVariable.Schema = xsdschema;
    //                        xVariable.Xslt = xslt;
    //                        xVariable.Scope = scope;
    //                        xVariable.StorageHandler = _storageType;
    //                        ((Workflow.NET.XmlStorageType.XmlDocument)(xVariable.StorageHandler)).StorageData = internalStorage;
    //                        ((Workflow.NET.XmlStorageType.XmlDocument)(xVariable.StorageHandler)).Xslt = xslt;
    //                        ((Workflow.NET.XmlStorageType.XmlDocument)(xVariable.StorageHandler)).Schema = xsdschema;
    //                        ((Workflow.NET.PropertyTypes.PropertyXmlVariable)(_selectedproperty.PropertyHandler)).XmlVariableCollection.Add(xVariable.Name, xVariable);
    //                    }
    //                    else
    //                    {
    //                        XmlVariableCollection xmlVarCol = ((Workflow.NET.PropertyTypes.PropertyXmlVariable)(_selectedproperty.PropertyHandler)).XmlVariableCollection;
    //                        foreach (XmlVariable xVar in xmlVarCol.Values)
    //                        {
    //                            if (xVar.Name == variablename)
    //                            {
    //                                xVar.Name = variablename;
    //                                xVar.Description = variabledescription;
    //                                xVar.StorageType = "XmlDocument";
    //                                xVar.Scope = scope;
    //                                xVar.Schema = xsdschema;
    //                                ((Workflow.NET.XmlStorageType.XmlDocument)(xVar.StorageHandler)).StorageData = internalStorage;
    //                                xVar.Xslt = xslt;
    //                                break;
    //                            }
    //                        }
    //                        ((Workflow.NET.PropertyTypes.PropertyXmlVariable)(_selectedproperty.PropertyHandler)).XmlVariableCollection = xmlVarCol;
    //                    }

    //                    ProcessDesignerControl.WriteFile();
    //                }
    //                else
    //                {
    //                    ArrayList al = new ArrayList();
    //                    al.Add("Error");
    //                    al.Add(ProcessDesignerControl.GlobalResourceSet.GetString("VariableexistsinvariableXmlvariableCollection"));
    //                    ReturnType = Workflow.NET.Ajax.ReturnTypeEnum.Object;
    //                    ReturnObject = new Workflow.NET.Ajax.JSObjectTable(al);
    //                }
    //            }
    //            catch (Exception e)
    //            {
    //                ArrayList al = new ArrayList();
    //                al.Add("Error");

    //                al.Add(e.Message);

    //                ReturnType = Workflow.NET.Ajax.ReturnTypeEnum.Object;
    //                ReturnObject = new Workflow.NET.Ajax.JSObjectTable(al);
    //            }
    //            break;
    //        default: break;
    //    }
    //}

    //private Guid GetProviderId(string storageType)
    //{
    //    Skelta.Core.AddInProviderCollection _Provider = new Skelta.Core.AddInProviderCollection(new Skelta.Core.ApplicationObject(ProcessDesignerControl.ApplicationName));

    //    string FilterExp = "where Type =@Type and Name=@Name";

    //    Skelta.Core.DS.SkeltaParameter param1 = new Skelta.Core.DS.SkeltaParameter("@Type", "XmlStorageType");
    //    Skelta.Core.DS.SkeltaParameter param2 = new Skelta.Core.DS.SkeltaParameter("@Name", storageType);

    //    DataSet DsProvider = _Provider.GetMatchingRecords(FilterExp, param1, param2);
    //    string s = "";
    //    if (DsProvider.Tables[0].Rows.Count > 0)
    //    {
    //        s = DsProvider.Tables[0].Rows[0].ItemArray.GetValue(0).ToString();
    //    }
    //    return new Guid(s);
    //}

    //private bool ValidateVaraiable(string variableName, Workflow.NET.VariablesCollection varCollection, Workflow.NET.XmlVariableCollection xmlVarCollection)
    //{
    //    bool returnValue = true;
    //    foreach (XmlVariable xmlVar in xmlVarCollection.Values)
    //    {
    //        if (xmlVar.Name.Trim() == variableName.Trim())
    //        {
    //            returnValue = false;
    //            break;
    //        }
    //    }

    //    foreach (Workflow.NET.Variable variable in varCollection)
    //    {
    //        if (variable.Name.Trim() == variableName.Trim())
    //        {
    //            returnValue = false;
    //            break;
    //        }
    //    }

    //    return returnValue;
    //}


    //private void BuildNodeList(Workflow.NET.Ajax.JSObjectTable rootObj)
    //{
    //    XmlVariableNode xmlNode = new XmlVariableNode();
    //    foreach (Object o in rootObj.Keys)
    //    {
    //        if (o.ToString() == "text")
    //            xmlNode.Name = rootObj[o].Value.ToString();

    //        else if (o.ToString() == "DataType")
    //        {
    //            GetXmlVariableNodeTypeFromXSD(xmlNode, rootObj[o].Value.ToString());
    //        }
    //        else if (o.ToString() == "type")
    //        {
    //            if (rootObj[o].Value.ToString() == "element")
    //                xmlNode.NodeType = XmlVariableNodeType.element;
    //            else if (rootObj[o].Value.ToString() == "attribute")
    //                xmlNode.NodeType = XmlVariableNodeType.attribute;
    //        }
    //        else if (o.ToString() == "IsRepeating")
    //        {
    //            if (rootObj[o].Value.ToString() == "True")
    //                xmlNode.IsRepeating = true;
    //            else
    //                xmlNode.IsRepeating = false;
    //        }
    //        else if (o.ToString() == "childNodes")
    //        {
    //            Workflow.NET.Ajax.JSObjectTable childObj = (Workflow.NET.Ajax.JSObjectTable)rootObj[o];
    //            if (childObj != null)
    //            {
    //                if (childObj.Count > 0)
    //                {
    //                    foreach (Object obj in childObj.Keys)
    //                    {
    //                        if (obj != null)
    //                        {
    //                            Workflow.NET.Ajax.JSObjectTable jsObject = (Workflow.NET.Ajax.JSObjectTable)childObj[obj];
    //                            if (jsObject != null)
    //                            {
    //                                if (jsObject.Count > 0)
    //                                    BuildNodeList(xmlNode, jsObject);
    //                            }
    //                        }
    //                    }
    //                }
    //            }

    //        }
    //    }
    //    nodeCollection.Add(xmlNode);
    //}

    //private void BuildNodeList(XmlVariableNode xParentNode, Workflow.NET.Ajax.JSObjectTable rootObj)
    //{
    //    XmlVariableNode xmlNode = new XmlVariableNode();
    //    foreach (Object o in rootObj.Keys)
    //    {
    //        if (o.ToString() == "text")
    //            xmlNode.Name = rootObj[o].Value.ToString();

    //        else if (o.ToString() == "DataType")
    //        {
    //            GetXmlVariableNodeTypeFromXSD(xmlNode, rootObj[o].Value.ToString());
    //        }
    //        else if (o.ToString() == "type")
    //        {
    //            if (rootObj[o].Value.ToString() == "element")
    //                xmlNode.NodeType = XmlVariableNodeType.element;
    //            else if (rootObj[o].Value.ToString() == "attribute")
    //                xmlNode.NodeType = XmlVariableNodeType.attribute;
    //        }
    //        else if (o.ToString() == "IsRepeating")
    //        {
    //            if (rootObj[o].Value.ToString() == "True")
    //                xmlNode.IsRepeating = true;
    //            else
    //                xmlNode.IsRepeating = false;
    //        }
    //        else if (o.ToString() == "childNodes")
    //        {
    //            Workflow.NET.Ajax.JSObjectTable childObj = (Workflow.NET.Ajax.JSObjectTable)rootObj[o];
    //            if (childObj.Count > 0)
    //            {
    //                foreach (Object obj in childObj.Keys)
    //                {
    //                    if (obj != null)
    //                    {
    //                        Workflow.NET.Ajax.JSObjectTable jsObject = (Workflow.NET.Ajax.JSObjectTable)childObj[obj];
    //                        if (jsObject != null)
    //                        {
    //                            if (jsObject.Count > 0)
    //                                BuildNodeList(xmlNode, jsObject);
    //                        }
    //                    }
    //                }
    //            }
    //        }
    //    }
    //    xParentNode.ChildNodes.Add(xmlNode);
    //}

    //private void GetXmlVariableNodeTypeFromXSD(XmlVariableNode xnode, string dataType)
    //{
    //    XmlVariableNodeDataType returnDataType;

    //    switch (dataType)
    //    {

    //        case "string":
    //            xnode.DataType = XmlVariableNodeDataType.String;
    //            break;
    //        case "integer":
    //            xnode.DataType = XmlVariableNodeDataType.Integer;
    //            break;
    //        case "double":
    //            xnode.DataType = XmlVariableNodeDataType.Double;
    //            break;
    //        case "long":
    //            xnode.DataType = XmlVariableNodeDataType.Long;
    //            break;
    //        case "dateTime":
    //            xnode.DataType = XmlVariableNodeDataType.DateTime;
    //            break;
    //        case "boolean":
    //            xnode.DataType = XmlVariableNodeDataType.Boolean;
    //            break;
    //        case "decimal":
    //            xnode.DataType = XmlVariableNodeDataType.Decimal;
    //            break;
    //        case "date":
    //            xnode.DataType = XmlVariableNodeDataType.Date;
    //            break;
    //        case "time":
    //            xnode.DataType = XmlVariableNodeDataType.Time;
    //            break;
    //        case "base64Binary":
    //            xnode.DataType = XmlVariableNodeDataType.Base64;
    //            break;
    //        default:
    //            break;
    //    }

    //}

    //private string BuildXSdString()
    //{
    //    TextWriter txt = new StringWriter();
    //    string xsstring = "";
    //    foreach (XmlVariableNode node in nodeCollection)
    //    {
    //        XmlSchemaElement xElement = new XmlSchemaElement();
    //        xElement.Name = node.Name;

    //        if (node.ChildNodes.Count > 0)
    //        {
    //            BuildSchema(node, xElement);
    //        }

    //        schema.Items.Add(xElement);


    //        XmlSchemaSet schemaSet = new XmlSchemaSet();
    //        schemaSet.Add(schema);
    //        schemaSet.Compile();

    //        XmlSchema compiledSchema = null;

    //        foreach (XmlSchema schema1 in schemaSet.Schemas())
    //        {
    //            compiledSchema = schema1;
    //        }

    //        XmlNamespaceManager nsmgr = new XmlNamespaceManager(new NameTable());
    //        nsmgr.AddNamespace("xsd", "http://www.w3.org/2001/XMLSchema");
    //        compiledSchema.Write(txt);
    //        xsstring = txt.ToString();

    //    }
    //    return xsstring;
    //}

    //private void BuildSchema(XmlVariableNode xnode, XmlSchemaElement xElement)
    //{

    //    XmlSchemaComplexType complexType = new XmlSchemaComplexType();
    //    xElement.SchemaType = complexType;

    //    if (xnode.NodeType == XmlVariableNodeType.element)
    //    {
    //        XmlSchemaSequence xSequence = new XmlSchemaSequence();
    //        foreach (XmlVariableNode node in xnode.ChildNodes)
    //        {
    //            if (node.NodeType == XmlVariableNodeType.element)
    //            {
    //                XmlSchemaElement xlement = new XmlSchemaElement();
    //                xlement.Name = node.Name;

    //                if (node.ChildNodes.Count > 0)
    //                {
    //                    BuildSchema(node, xlement);
    //                }
    //                else
    //                {
    //                    xlement.SchemaTypeName = new XmlQualifiedName(XmlVaraiableNodeType(node.DataType), "http://www.w3.org/2001/XMLSchema");
    //                }
    //                //xSequence.MinOccurs = 0;

    //                if (node.IsRepeating == true)
    //                {
    //                    xlement.MaxOccursString = "unbounded";
    //                }
    //                xSequence.Items.Add(xlement);

    //            }
    //            else
    //            {
    //                XmlSchemaAttribute xattr = new XmlSchemaAttribute();
    //                xattr.Name = node.Name;
    //                xattr.SchemaTypeName = new XmlQualifiedName(XmlVaraiableNodeType(node.DataType), "http://www.w3.org/2001/XMLSchema");
    //                complexType.Attributes.Add(xattr);
    //            }
    //        }
    //        complexType.Particle = xSequence;
    //    }
    //    else
    //    {
    //        XmlSchemaAttribute xattr = new XmlSchemaAttribute();
    //        xattr.Name = xnode.Name;
    //        xattr.SchemaTypeName = new XmlQualifiedName(XmlVaraiableNodeType(xnode.DataType), "http://www.w3.org/2001/XMLSchema");
    //        complexType.Attributes.Add(xattr);
    //    }
    //}

    //private string XmlVaraiableNodeType(XmlVariableNodeDataType dataType)
    //{
    //    string returnValueType = "";

    //    if (dataType == XmlVariableNodeDataType.String)
    //        returnValueType = "string";
    //    else if (dataType == XmlVariableNodeDataType.Integer)
    //        returnValueType = "integer";
    //    else if (dataType == XmlVariableNodeDataType.Long)
    //        returnValueType = "long";
    //    else if (dataType == XmlVariableNodeDataType.Boolean)
    //        returnValueType = "boolean";
    //    else if (dataType == XmlVariableNodeDataType.Base64)
    //        returnValueType = "base64Binary";
    //    else if (dataType == XmlVariableNodeDataType.Date)
    //        returnValueType = "date";
    //    else if (dataType == XmlVariableNodeDataType.Time)
    //        returnValueType = "time";
    //    else if (dataType == XmlVariableNodeDataType.DateTime)
    //        returnValueType = "dateTime";
    //    else if (dataType == XmlVariableNodeDataType.Double)
    //        returnValueType = "double";
    //    else if (dataType == XmlVariableNodeDataType.Decimal)
    //        returnValueType = "decimal";

    //    return returnValueType;
    //}
   ////oRadTreeNode = new RadTreeNode(xmlVarNode.Name, xmlVarNode.Name);
        //   if (xmlVarNode.ChildNodes.Count > 0)
        //    {
        //      foreach (XmlVariableNode XmlVAR in xmlVarNode.ChildNodes)
        //      {
        //          BuildChildNodes(XmlVAR, oRadTreeNode);
        //          //RadTreeNode oRadTreeNode1 = new RadTreeNode(XmlVAR.Name, XmlVAR.Name);
        //          //oRadTreeNode = new RadTreeNode();
        //          RadTreeNode oRadTreeNode1 = new RadTreeNode();
        //          oRadTreeNode = new RadTreeNode();
        //          oRadTreeNode1.Text = XmlVAR.Name;
        //          oRadTreeNode1.Value = XmlVAR.Name;
        //          oRadTreeNode.Nodes.Add(oRadTreeNode1);
                  
        //          //
        //          //oRadTreeNode.Text = XmlVAR.Name;
        //          //oRadTreeNode.Value = XmlVAR.Name;
                  
        //          //oRadTreeNode = new RadTreeNode(xmlVAR.Name, xmlVAR.Name);
                  
        //      }
               
        //   }


#endregion 



/*
void InitializeElements()

        {

            string listName="";

            foreach (XmlVariable oXmlVariable in ProcessDesignerControl.ProcessDefinition.XmlVariables.Values)

            {

                if (oXmlVariable.Name == "Firstvar")

                {

                    listName = ((Enterprise.XmlStorageType.ListStorage)(oXmlVariable.StorageHandler)).ListName; 

                    oXmlvariableNodeList = oXmlVariable.GetXMLVaraiableNodeList();

                    break;

                }

            }

 

            XmlVariableNode rootnode=new XmlVariableNode();

 

            foreach (XmlVariableNode xnode in oXmlvariableNodeList)

            {

                if (xnode.ChildNodes.Count > 0)

                {

                    foreach (XmlVariableNode childNode in xnode.ChildNodes)

                    {

                        rootnode = childNode;

                        break;

                    }

                }

            }

 

            RadTreeNode treeNode = new RadTreeNode();

            treeNode.Text = listName;

            treeNode.Value = listName;

            LoadXmlVariableChildNodes(treeNode, rootnode);

            RadTree1.Nodes.Add(treeNode);

        }

 

 

        void LoadXmlVariableChildNodes(RadTreeNode parentNode, XmlVariableNode node)

        {

            foreach (XmlVariableNode xnode in node.ChildNodes)

            {

                RadTreeNode treeNode = new RadTreeNode();

                treeNode.Text = decodetheelementName(xnode.Name);

                treeNode.Value = xnode.Name;

                

                if(xnode.ChildNodes.Count > 0)

                {

                    LoadXmlVariableChildNodes(treeNode, xnode);

                }

 

                parentNode.Nodes.Add(treeNode);

            }

        }

 

 

        string decodetheelementName(string encodedname)

        {

            string returnValue = "";

 

            returnValue = encodedname;

 

            for (int i = 0; i < encodedname.Length;i++ )

            {

                if (encodedname[i] == '_')

                {

                    returnValue = XmlConvert.DecodeName(returnValue);

                }

            }

            return returnValue;

 

        }

 
*/