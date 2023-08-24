<%@ page language="c#" inherits="Workflow.NET.Template.PageScriptExpEditor" codefile="ExpressionEditorCode.cs" theme="" stylesheettheme="" %>

<%@ assembly name="Workflow.NET.Web.Designer.NET2" %>
<%@ import namespace="Workflow.NET.Web.Designer" %>
<%@ assembly name="Workflow.NET.NET2" %>
<%@ import namespace="Workflow.NET" %>
<%@ import namespace="Skelta.Repository.List" %>
<%@ register assembly="Workflow.NET.Web.Designer.NET2" namespace="Workflow.NET.Web.Designer" tagprefix="cc1" %>
<%@ register tagprefix="radE" namespace="Telerik.Web.UI" assembly="Telerik.Web.UI" %>
 
 <script runat="server">

     protected ProcessDesigner ProcessDesignerControl;
     protected string _applicationName = "";
     protected string _workflowName = "";
     protected string _fileName = "";
     protected string _actionName = "";
     protected string _propertyNameName = "";
     protected StringBuilder _dllReferences ;
     protected string _userid = "";
     protected string _propertyDisplayName;//added for localization in the title of expression editor page
     protected Workflow.NET.SOAWebCollection soaWeb = new SOAWebCollection();
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

         if (_actionName == null)
         {
             _actionName = this.Context.Request["actionname"];
         }
         if (_propertyNameName == null)
         {
             _propertyNameName = this.Context.Request["propertyname"];
         }

         Workflow.NET.Action _selectedAction = ProcessDesignerControl.ProcessDefinition.Actions[_actionName];
         Property _selectedproperty = _selectedAction.Properties[_propertyNameName];
         _propertyDisplayName= _selectedproperty.DisplayName;//Getting the dispalyname value of selected property
         
         //Its returning null. So time being taking the UserID from UserContext.
         //_userid = ProcessDesignerControl.UserIdString;
         Skelta.Entity.UserContext objUserContext = new Skelta.Entity.UserContext();
         _userid = objUserContext.LoggedInUserId;

         //Instance of RuntimeObject Collection
         Workflow.NET.ExpressionBuilder.RuntimeObjectCollection runtimeObjectCollection = new Workflow.NET.ExpressionBuilder.RuntimeObjectCollection();
         //Adding differnt types of system classes Eg:Date,Math,String etc...    
         runtimeObjectCollection.Add(new Workflow.NET.ExpressionBuilder.RuntimeObject("Date", Type.GetType("System.DateTime"), "DateTime"));
         runtimeObjectCollection.Add(new Workflow.NET.ExpressionBuilder.RuntimeObject("Math", Type.GetType("System.Math"), "Math"));
         runtimeObjectCollection.Add(new Workflow.NET.ExpressionBuilder.RuntimeObject("String", Type.GetType("System.String"), "STring"));
         runtimeObjectCollection.Add(new Workflow.NET.ExpressionBuilder.RuntimeObject("Workflow Instance", typeof(Workflow.NET.Engine.Context), "Context", "Context", "_context"));

         Workflow.NET.SOAObjectsCollection ObjectCollectionSoa = null;
         Workflow.NET.SOAObjectsCollection soaExpress = new SOAObjectsCollection();

         if(!ProcessDesignerControl.IsQuickflow)
         {
             //Adding Workflow.NET.Engine.Context object for getting the Workflow instance
             
             runtimeObjectCollection.Add(new Workflow.NET.ExpressionBuilder.RuntimeObject("SOAStaticObjects", typeof(Workflow.NET.SOAObjectsCollection), "SOAStaticObjects"));
             runtimeObjectCollection.Add(new Workflow.NET.ExpressionBuilder.RuntimeObject("SOAWebObjects", typeof(Workflow.NET.SOAWebCollection), "SOAWebObjects"));
        
             ObjectCollectionSoa=(Workflow.NET.SOAObjectsCollection)ProcessDesignerControl.ProcessDefinition.SOAObjects;
             soaWeb.GetWebDetails(_applicationName, _userid);

             //Add the Static Objects here
             if (!IsPostBack)
             {
                 ObjectCollectionSoa.GetInternalStaticClasses(_applicationName, _userid);
             }
             //End of Static Objects        

              if (ObjectCollectionSoa != null)
                {
                    _dllReferences = new StringBuilder();
                    foreach (SOAObject soaObj in ObjectCollectionSoa)
                    {
                        if (soaObj.Internal)
                        {
                            if (!(_dllReferences.ToString().Trim().Contains(soaObj.AssemblyFullName)))
                            {
                                if (_dllReferences.Length > 0)
                                    _dllReferences.Append(",");
                                _dllReferences.Append(soaObj.AssemblyFullName);
                            }
                            continue;
                        }
                        string sClassName = soaObj.SOANameSpace + '.' + soaObj.SOAClassName;
                        if ((soaObj.AssemblyFullName.ToString().Trim() != "") & (System.IO.File.Exists(soaObj.AssemblyFullName)))
                        {
                            System.Reflection.Assembly asLoad = CommonFunctions.LoadAssembly(soaObj.AssemblyFullName);
                            string sClass = soaObj.SOAClassName;
                            Type tp = asLoad.GetType(sClassName);

                            //runtimeObjectCollection.Add(new Workflow.NET.ExpressionBuilder.RuntimeObject(soaObj.SOAClassName, tp, soaObj.SOAClassName));
                            runtimeObjectCollection.Add(new Workflow.NET.ExpressionBuilder.RuntimeObject(soaObj.Name, tp, soaObj.Name, soaObj.Name, soaObj.Name));

                            //  Workflow.NET.ExpressionBuilder.AssemblyDefinition newAssembly = new Workflow.NET.
                            if (!(_dllReferences.ToString().Trim().Contains(soaObj.AssemblyFullName)))
                            {
                                if (_dllReferences.Length > 0)
                                    _dllReferences.Append(",");
                                _dllReferences.Append(soaObj.AssemblyFullName);
                            }
                        }
                    }
                }
         }
         Workflow.NET.ExpressionBuilder.RenderInformationCollection renderInfoCollection = new Workflow.NET.ExpressionBuilder.RenderInformationCollection();
         if(!ProcessDesignerControl.IsQuickflow)
         {
             //Instance of RenderInformationCollection Class

             //Render Information for rendering Variables info in Object Browser
             renderInfoCollection.Add(new Workflow.NET.ExpressionBuilder.RenderInformation("VariableNodeHandler", @"[INSTALLDIR]Bin\\SkeltaObjectLibrary.NET2.dll", "Workflow.NET.VariablesCollection", "VariableRenderer"));

             renderInfoCollection.Add(new Workflow.NET.ExpressionBuilder.RenderInformation("XMLVariableCollectionNodeHandler", @"[INSTALLDIR]Bin\\SkeltaObjectLibrary.NET2.dll", "Workflow.NET.XmlVariableCollection", "XMLVariableCollectionRenderer"));
             //Render Information for rendering Resource Variable info in Object Browser
             renderInfoCollection.Add(new Workflow.NET.ExpressionBuilder.RenderInformation("XMLVariableNodeHandler", @"[INSTALLDIR]Bin\\SkeltaObjectLibrary.NET2.dll", "Workflow.NET.XmlVariable", "XMLVariableRenderer"));

             //Render Information for rendering Contents info in Object Browser
             renderInfoCollection.Add(new Workflow.NET.ExpressionBuilder.RenderInformation("ContentNodeHandler", @"[INSTALLDIR]Bin\\SkeltaObjectLibrary.NET2.dll", "Workflow.NET.ContentsCollection", "ContentRenderer"));
             //Render Information for rendering Resource Variable info in Object Browser
             renderInfoCollection.Add(new Workflow.NET.ExpressionBuilder.RenderInformation("ResourceNodeHandler", @"[INSTALLDIR]Bin\\SkeltaObjectLibrary.NET2.dll", "Workflow.NET.ResourcePropertiesCollection", "ResourceRenderer"));
             //Render Information for rendering Resource Variable info in Object Browser       
             //Render Information for rendering Resource SOAObject info in Object Browser
             renderInfoCollection.Add(new Workflow.NET.ExpressionBuilder.RenderInformation("SOAObjectCollectionHandler", @"[INSTALLDIR]Bin\\SkeltaObjectLibrary.NET2.dll", "Workflow.NET.SOAObjectsCollection", "SOAObjectRenderer"));

            renderInfoCollection.Add(new Workflow.NET.ExpressionBuilder.RenderInformation("SOAObjectStaticNodes", @"[INSTALLDIR]Bin\\SkeltaObjectLibrary.NET2.dll", "Workflow.NET.SOAObject", "SOAObject"));
            renderInfoCollection.Add(new Workflow.NET.ExpressionBuilder.RenderInformation("SOAWebObjectHandler", @"[INSTALLDIR]Bin\\SkeltaObjectLibrary.NET2.dll", "Workflow.NET.SOAWebCollection", "SOAWebObjects"));
         }
         else
         {
            //Render Information for rendering Variables info in Object Browser
             renderInfoCollection.Add(new Workflow.NET.ExpressionBuilder.RenderInformation("VariableNodeHandler", @"[INSTALLDIR]Bin\\SkeltaObjectLibrary.NET2.dll", "Workflow.NET.VariablesCollection", "VariableRenderer"));
            renderInfoCollection.Add(new Workflow.NET.ExpressionBuilder.RenderInformation("ResourceNodeHandler", @"[INSTALLDIR]Bin\\SkeltaObjectLibrary.NET2.dll", "Workflow.NET.ResourcePropertiesCollection", "ResourceRenderer"));
            
            renderInfoCollection.Add(new Workflow.NET.ExpressionBuilder.RenderInformation("XMLVariableCollectionNodeHandler", @"[INSTALLDIR]Bin\\SkeltaObjectLibrary.NET2.dll", "Workflow.NET.XmlVariableCollection", "XMLVariableCollectionRenderer"));            
            renderInfoCollection.Add(new Workflow.NET.ExpressionBuilder.RenderInformation("XMLVariableNodeHandler", @"[INSTALLDIR]Bin\\SkeltaObjectLibrary.NET2.dll", "Workflow.NET.XmlVariable", "XMLVariableRenderer"));

         }
         //Instance of BindingObjects Class   
         Workflow.NET.ExpressionBuilder.BindingObjects bindingObjectCollection = new Workflow.NET.ExpressionBuilder.BindingObjects();
         StringBuilder exprExtnReferences = new StringBuilder();
         if(!ProcessDesignerControl.IsQuickflow)
         {
             bindingObjectCollection.Add(new Workflow.NET.ExpressionBuilder.BindingObject("Workflow.NET.ResourcePropertiesCollection",ProcessDesignerControl.ActionsDefinition.Resources.ResourceProperties));
             bindingObjectCollection.Add(new Workflow.NET.ExpressionBuilder.BindingObject("Workflow.NET.ContentsCollection", ProcessDesignerControl.ProcessDefinition.Contents));


             bindingObjectCollection.Add(new Workflow.NET.ExpressionBuilder.BindingObject("Workflow.NET.VariablesCollection", ProcessDesignerControl.ProcessDefinition.Variables));
             bindingObjectCollection.Add(new Workflow.NET.ExpressionBuilder.BindingObject("Workflow.NET.XmlVariableCollection", ProcessDesignerControl.ProcessDefinition.XmlVariables, "Workflow.NET.XmlVariable"));

             bindingObjectCollection.Add(new Workflow.NET.ExpressionBuilder.BindingObject("Workflow.NET.SOAObjectsCollection", ProcessDesignerControl.ProcessDefinition.SOAObjects, "Workflow.NET.SOAObject"));
             bindingObjectCollection.Add(new Workflow.NET.ExpressionBuilder.BindingObject("Workflow.NET.SOAWebCollection",soaWeb, "Workflow.NET.SOAWebCollection"));



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
         else
         {
           bindingObjectCollection.Add(new Workflow.NET.ExpressionBuilder.BindingObject("Workflow.NET.ResourcePropertiesCollection",ProcessDesignerControl.ActionsDefinition.Resources.ResourceProperties));
           bindingObjectCollection.Add(new Workflow.NET.ExpressionBuilder.BindingObject("Workflow.NET.VariablesCollection", ProcessDesignerControl.ProcessDefinition.Variables));
           bindingObjectCollection.Add(new Workflow.NET.ExpressionBuilder.BindingObject("Workflow.NET.XmlVariableCollection", ProcessDesignerControl.ProcessDefinition.XmlVariables, "Workflow.NET.XmlVariable"));
         }

         Workflow.NET.ExpressionBuilder.InputObjectsInfo inputObjectsInfo = new Workflow.NET.ExpressionBuilder.InputObjectsInfo();

         if(!ProcessDesignerControl.IsQuickflow)
         {
             if (!(_dllReferences.ToString().Trim().Contains("Workflow.NET.NET2.dll")))
             {
                 if (_dllReferences.Length > 0)
                     _dllReferences.Append(",");
                 _dllReferences.Append(@"[INSTALLDIR]Bin\\Workflow.NET.NET2.dll");
             }
             if (exprExtnReferences.Length > 0)
                 _dllReferences.Append(",");
             _dllReferences.Append(exprExtnReferences);

             string[] strDllReferences = _dllReferences.ToString().Trim().Split(',');
             foreach (SOAObject soaObject in ObjectCollectionSoa)
             {
                 if(!( soaObject.Internal))
                     soaExpress.Add(soaObject.Name, ".Net", soaObject.Value, soaObject.SOAClassName, soaObject.ClassAliasName, soaObject.AssemblyFullName, soaObject.SOAConstructorParameters, soaObject.RegisteredInformation, soaObject.SOANameSpace, false);
             }
             inputObjectsInfo.ReferencedAssemblies = strDllReferences;
             
             inputObjectsInfo.SOAObjects = soaExpress;
             inputObjectsInfo.SOAWebObjects = soaWeb;
         }
         inputObjectsInfo.RenderInformationCollection = renderInfoCollection;
         inputObjectsInfo.RuntimeObjectCollection = runtimeObjectCollection;
         inputObjectsInfo.BindingObjects = bindingObjectCollection;
         ExpressionBuilderControl1.InputObjectsInfo = inputObjectsInfo;
     }
</script>
<%=DocType%>
<html>
<head id="Head1" runat="server">
    
    <title><%:GetLangSpecText("Title_Expression_Editior")%>:<%:_actionName%>:<%:GetLangSpecText(_propertyDisplayName.Replace("$$$", "'").Replace("$$_$$", "+").Replace("$$__$$", "="))%></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
</head>
    


<body onload="javascript:LoadExpression();resizePage();" onresize="resizePage();">
<div id="divExpressionEditor"> 
       <table cellpadding="0" cellspacing="0" border="0">
           <tr>
                <td>
                    <form id="form1" runat="server" style="position: fixed">
					<%=System.Web.Helpers.AntiForgery.GetHtml()%>
                   <asp:ScriptManager ID="ScriptManager1" runat="server" />
                        <div style="padding-right: 15px;">
                            <cc1:expressionbuildercontrol id="ExpressionBuilderControl1" onclientexpressionsubmit="GetExpression" runat="server" />
                            <input type="hidden" id="ApplicationName" name="ApplicationName" value="<%=_applicationName%>" />
                                <input type="hidden" id="WorkflowName" name="WorkflowName" value="<%=_workflowName%>" />
                                <input type="hidden" id="FileName" name="FileName" value="<%=_fileName%>" />
                               
                        </div>
                    </form>
                </td>
            </tr>
        </table>
</div>    
    </body>
</html>

<script type="text/javascript">
    var newpdObj = new PDObject();
    var srcPage = '<%:this.Context.Request["Src"]%>';
var selectedRow = '<%:this.Context.Request["selRow"]%>';
    var columnMode = '<%:this.Context.Request["mode"]%>';
    var validationMsg = "<%:ProcessDesignerControl.GlobalResourceSet.GetString("ExpressionEditor_ValidateExpression")%>";

    function PDObject() {
        this.ApplicationName = "<%:_applicationName%>";
    this.WorkflowName = "<%:_workflowName%>";
    this.FileName = "<%:_fileName%>";
    this.ActionName = "<%:_actionName%>";
    this.propertyName = "<%:_propertyNameName%>";
    this.ExpressionString = "";
}

    function GetExpression(expObj) {
    if (srcPage == "Con") {
        var rowObject = eval("window.opener.Row" + selectedRow);
        var expText = "";

        if (rowObject == null) return false;

        curentExpression.DisplayExpressionString = DecodeTheExpressionString(_displayExpressionString);
        curentExpression.ActualExprtessionString = DecodeTheExpressionString(_actualExprtessionString);
        curentExpression.HtmlVerexpString = DecodeTheExpressionString(_htmlVerexpString);

        if (trim(expObj.DisplayExpressionString).length > 32) {
            var length = trim(expObj.DisplayExpressionString).length;
            expText = trim(expObj.DisplayExpressionString).substring(0, 6) + ".." + trim(expObj.DisplayExpressionString).substring(length - 24, length);
        }
        else
            expText = trim(expObj.DisplayExpressionString);

        if (columnMode == "RHS") {
            rowObject.RHSMode = "Expression";
            rowObject.RHSColumn.ColumnExpression.DisplayExpressionString = expObj.DisplayExpressionString;
            rowObject.RHSColumn.ColumnExpression.ActualExprtessionString = expObj.ActualExprtessionString;
            rowObject.RHSColumn.ColumnExpression.MethodParameterList = expObj.MethodParameterList;
            rowObject.RHSColumn.ColumnExpression.HtmlVerexpString = expObj.HtmlVerexpString;
            rowObject.RHSColumn.ColumnExpression.ReferencedFunctionList = expObj.ReferencedFunctionList;
            rowObject.RHSColumn.ColumnExpression.ReferenceList = expObj.ReferenceList;
            rowObject.RHSColumn.ColumnExpression.NodeInfo = expObj.NodeInfo;
            rowObject.RHSColumn.ColumnExpression.ReturnType = expObj.ReturnType;
            var divObj = window.opener.document.getElementById("RHS" + selectedRow);
            divObj.innerHTML = HtmlDecode("&lt;a href=&quot;#&quot; id=&quot;rhsLink" + selectedRow + "&quot; class=&quot;hyperText&quot; OnMouseOver=&quot;javascript:alterLink(this," + selectedRow + "," + selectedRow + ",event,'RHS')&quot; Onclick=&quot;javascript:alterLink(this," + selectedRow + "," + selectedRow + ",event,'RHS')&quot;id=&quot;val1&quot; name=&quot;rhsLink" + selectedRow + "&quot;&gt;" + expText + "&lt;a&gt");
        }
        else if (columnMode == "LHS") {

            rowObject.LHSColumn.LHSMode = "Expression";
            rowObject.LHSColumn.ColumnExpression.DisplayExpressionString = expObj.DisplayExpressionString;
            rowObject.LHSColumn.ColumnExpression.ActualExprtessionString = expObj.ActualExprtessionString;
            rowObject.LHSColumn.ColumnExpression.MethodParameterList = expObj.MethodParameterList;
            rowObject.LHSColumn.ColumnExpression.HtmlVerexpString = expObj.HtmlVerexpString;
            rowObject.LHSColumn.ColumnExpression.ReferencedFunctionList = expObj.ReferencedFunctionList;
            rowObject.LHSColumn.ColumnExpression.ReferenceList = expObj.ReferenceList;
            rowObject.LHSColumn.ColumnExpression.NodeInfo = expObj.NodeInfo;
            rowObject.LHSColumn.ColumnExpression.ReturnType = expObj.ReturnType;


            var divLHSObj = window.opener.document.getElementById("LHS" + selectedRow);
            var selectedNodeTxt = "<A class=\"hyperText\" id=\"link" + selectedRow + "\" onmouseover=\"Javascript:alterLink(this," + selectedRow + "," + selectedRow + ",event,'LHS')\" onclick=\"Javascript:alterLink(this," + selectedRow + "," + selectedRow + ",event,'LHS')\" href=\"#\">" + expText + "</A>";
            divLHSObj.innerHTML = selectedNodeTxt;
            window.opener.document.getElementById("DivDelImage" + selectedRow).innerHTML = "<a href=\"#\"><img id=\"ObjImage" + selectedRow + "\" src='" + window.opener.objectTreeImg + "' alt='Object Tree' border=0 onclick=\"javascript:DisplayObjectTree(" + selectedRow + ")\"></a>&nbsp;<a href=\"#\"><img id=\"DelImage" + selectedRow + "\" alt='Delte' src='" + window.opener.delteRowImg + "' border=0 onclick=\"javascript:DeleteRow(" + selectedRow + ")\"></a>";

            var tableObject = window.opener.document.getElementById("TableExpression" + selectedRow);
            tableObject.className = "tab";

            var nextRowHTML = window.opener.AddRow(selectedRow);
            if (nextRowHTML != "")
                window.opener.document.getElementById("divExpressionLayers").innerHTML = window.opener.document.getElementById("divExpressionLayers").innerHTML + nextRowHTML;

            selectedNodeTxt = "<A class=\"hyperText\" id=\"link" + selectedRow + "\" onmouseover=\"Javascript:alterLink(this," + selectedRow + "," + selectedRow + ",event,'MHS')\" onclick=\"Javascript:alterLink(this," + selectedRow + "," + selectedRow + ",event,'MHS')\" href=\"#\">Equals</A>";

            var currentDivElement = "MHS" + selectedRow;
            var divMHSObj = window.opener.document.getElementById(currentDivElement);

            divMHSObj.innerHTML = selectedNodeTxt;

            var divRHSObj = window.opener.document.getElementById("RHS" + selectedRow);
            divRHSObj.innerHTML = window.opener.HtmlDecode("&lt;a href=&quot;#&quot; id=&quot;rhsLink" + selectedRow + "&quot; class=&quot;hyperText&quot; OnMouseOver=&quot;javascript:alterLink(this," + selectedRow + "," + selectedRow + ",event,'RHS')&quot; Onclick=&quot;javascript:alterLink(this," + selectedRow + "," + selectedRow + ",event,'RHS')&quot;id=&quot;val1&quot; name=&quot;rhsLink" + selectedRow + "&quot;&gt;enter a value&lt;a&gt");


            if (!window.opener.IsAddedToArray(selectedRow)) {
                var inArrLen = window.opener.InitialconditionalArray.length;
                window.opener.InitialconditionalArray[inArrLen] = selectedRow + "~" + "S";
            }

        }
        window.opener.document.getElementById("treeDiv").style.visibility = "hidden";
        window.opener.document.getElementById("cmbLHS_Input").style.visibility = "hidden";
        window.opener.imageLHSObj.style.display = "none";
        window.setTimeout('window.close()', 100);
    }
    else if (srcPage == "UpdateVariable") {
        //curentExpression.DisplayExpressionString= DecodeTheExpressionString(_displayExpressionString); 
        //curentExpression.ActualExprtessionString= DecodeTheExpressionString(_actualExprtessionString);
        //curentExpression.HtmlVerexpString=DecodeTheExpressionString(_htmlVerexpString);
        //Custom Changes
        var rowObject = eval("window.opener.Row" + selectedRow);
        var expText = "";

        if (rowObject == null) return false;
        

        expText = trim(expObj.DisplayExpressionString);

        if (columnMode == "RHS") {
            rowObject.RHSMode = "Expression";
            rowObject.RHSColumn = expObj.DisplayExpressionString;
            rowObject.ColumnExpression.DisplayExpressionString = expObj.DisplayExpressionString;
            rowObject.ColumnExpression.ActualExprtessionString = expObj.ActualExprtessionString;
            rowObject.ColumnExpression.MethodParameterList = expObj.MethodParameterList;
            rowObject.ColumnExpression.HtmlVerexpString = expObj.HtmlVerexpString;
            rowObject.ColumnExpression.ReferencedFunctionList = expObj.ReferencedFunctionList;
            rowObject.ColumnExpression.ReferenceList = expObj.ReferenceList;
            rowObject.ColumnExpression.NodeInfo = expObj.NodeInfo;
            rowObject.ColumnExpression.ReturnType = expObj.ReturnType;

            window.opener.setRHSDivHtml(selectedRow, expText, "Expression");

            if (!window.opener.IsAddedToArray(selectedRow)) {
                var inArrLen = window.opener.InitialUpdatedVariableArray.length;
                window.opener.InitialUpdatedVariableArray[inArrLen] = selectedRow + "~" + "S";
            }
        }

        window.opener.document.getElementById("treeDiv").style.display = "none";
        window.opener.document.getElementById("RHSTreeDiv").style.display = "none";

        window.opener.Maximize(false, 0);
        window.opener.imageLHSObj.style.display = "none";
        window.opener.inputLHSObj.style.display = "none";
        window.opener.hideRHSInputControl();

        window.setTimeout('window.close()', 100);
    }
    else if (srcPage == "SOAConstructorExpression") {

        var ipBox = window.opener.GetInputBox('IB_ExpressionControl');

        expObj.ActualExprtessionString = _actualExprtessionString;
        ipBox.Expression.ActualExprtessionString = _actualExprtessionString;
        ipBox.Expression.DisplayExpressionString = expObj.DisplayExpressionString;
        ipBox.Expression.MethodParameterList = expObj.MethodParameterList;
        ipBox.Expression.HtmlVerexpString = expObj.HtmlVerexpString;
        ipBox.Expression.ReferencedFunctionList = expObj.ReferencedFunctionList;
        ipBox.Expression.ReferenceList = expObj.ReferenceList;
        ipBox.Expression.NodeInfo = expObj.NodeInfo;
        ipBox.Expression.ReturnType = expObj.ReturnType;
        var stringified = stringify(expObj);
        window.opener.document.getElementById('hdnActualExpression').value = stringified;
        window.opener.document.getElementById('tbExpression').value = expObj.DisplayExpressionString;
        window.opener.document.getElementById('tbExpression').setAttribute('readOnly', true);
        // window.opener.document.getElementById('btnUpdate').setAttribute('disabled', false);
        window.opener.document.getElementById('btnUpdate').disabled = false;
        window.setTimeout('window.close()', 100);
    }
    else if (newpdObj.propertyName == "Query Builder") {

        stringified = stringify(expObj);
        window.opener.setExpression(stringified);
        newpdObj.ExpressionString = stringified;
        saveExpression(newpdObj);
        window.setTimeout('window.opener.refreshselectedaction()', 1000);
    }
    else if (newpdObj.propertyName == "SetParameter") {
        stringified = stringify(expObj);
        window.opener.setExpression(stringified);
        newpdObj.ExpressionString = stringified;
        saveExpression(newpdObj);
        window.setTimeout('window.opener.refreshselectedaction()', 1000);
    }
    else if (newpdObj.propertyName == "AttachReport") {
        stringified = stringify(expObj);
        window.opener.setExpression(stringified);
        newpdObj.ExpressionString = stringified;
        saveExpression(newpdObj);
        window.setTimeout('window.opener.refreshselectedaction()', 1000);
        self.close();
    }
    else if (newpdObj.propertyName == "ActivityDetails") {

        stringified = stringify(expObj);
        window.opener.setExpression(stringified);
        newpdObj.ExpressionString = stringified;
        saveExpression(newpdObj);
        window.setTimeout('window.opener.refreshselectedaction()', 1000);        
    }
    else if (newpdObj.propertyName == "WorkflowDetails") {

        stringified = stringify(expObj);
        window.opener.setExpression(stringified);
        newpdObj.ExpressionString = stringified;
        saveExpression(newpdObj);
        window.setTimeout('window.opener.refreshselectedaction()', 1000);        
    }
    else if (newpdObj.propertyName == "Select Command") {
        stringified = stringify(expObj);
        window.opener.setExpression(stringified);
        newpdObj.ExpressionString = stringified;
        saveExpression(newpdObj);
        window.setTimeout('window.opener.refreshselectedaction()', 1000);
        self.close();
    }
    else if (newpdObj.propertyName === "configASBEventFilter")
    {
        stringified = stringify(expObj);
        //var decodedString = objectify(DecodeTheExpressionString(stringified));
        newpdObj.ExpressionString = DecodeTheExpressionString(stringified);
        //newpdObj.ExpressionString = stringified;
        window.opener.skeltaUtils.setExpressionEditor(newpdObj);
        //window.setTimeout('window.opener.refreshselectedaction()', 1000);
        self.close();
        }
    else if (newpdObj.propertyName === "configRMQEventFilter") {
        stringified = stringify(expObj);
        //var decodedString = objectify(DecodeTheExpressionString(stringified));
        newpdObj.ExpressionString = DecodeTheExpressionString(stringified);
        //newpdObj.ExpressionString = stringified;
        window.opener.skeltaUtils.setExpressionEditor(newpdObj);
        //window.setTimeout('window.opener.refreshselectedaction()', 1000);
        self.close();
    }
    else if (newpdObj.propertyName === "configLogicAppConnectionData" || newpdObj.propertyName === "configWaitForLogicAppAlert" || newpdObj.propertyName === "configRMQConnection" || newpdObj.propertyName === "configWebAPI") {
         stringified = stringify(expObj);
        newpdObj.ExpressionString = DecodeTheExpressionString(stringified);
        window.opener.skeltaUtils.setExpressionEditor(newpdObj);
        self.close();
    }
    else {
        var stringified = stringify(expObj);
        newpdObj.ExpressionString = stringified;
        saveExpression(newpdObj);
    }
}

function ReplaceSplTags(inputString, stringtobereplaced, stringbywhichreplaced) {
    var returnstring = "";

    returnstring = inputString.replace(stringtobereplaced, stringbywhichreplaced);

    if (returnstring.indexOf(stringtobereplaced) > -1) {
        returnstring = ReplaceSplTags(returnstring, stringtobereplaced, stringbywhichreplaced)
    }
    return returnstring;
}

setTimeout("LoadExpression();", 100);

    function LoadExpression() {
       
    if (srcPage == "Con") {
        var rowObject = eval("window.opener.Row" + selectedRow);
        var expEditor = GetExpressionEditor("ExpressionBuilderControl1");
        if (columnMode == "RHS") {
            rowObject.RHSColumn.ColumnExpression.DisplayExpressionString = DecodeTheExpressionString(rowObject.RHSColumn.ColumnExpression.DisplayExpressionString);
            rowObject.RHSColumn.ColumnExpression.ActualExprtessionString = DecodeTheExpressionString(rowObject.RHSColumn.ColumnExpression.ActualExprtessionString);
            rowObject.RHSColumn.ColumnExpression.HtmlVerexpString = DecodeTheExpressionString(rowObject.RHSColumn.ColumnExpression.HtmlVerexpString);

            if (rowObject.RHSColumn.ColumnExpression.DisplayExpressionString != "") {


                expEditor.SetExpression(rowObject.RHSColumn.ColumnExpression);
            }
        }
        else if (columnMode == "LHS") {
            rowObject.LHSColumn.ColumnExpression.DisplayExpressionString = DecodeTheExpressionString(rowObject.LHSColumn.ColumnExpression.DisplayExpressionString);
            rowObject.LHSColumn.ColumnExpression.ActualExprtessionString = DecodeTheExpressionString(rowObject.LHSColumn.ColumnExpression.ActualExprtessionString);
            rowObject.LHSColumn.ColumnExpression.HtmlVerexpString = DecodeTheExpressionString(rowObject.LHSColumn.ColumnExpression.HtmlVerexpString);

            if (rowObject.LHSColumn.ColumnExpression.DisplayExpressionString != "") {
                expEditor.SetExpression(rowObject.LHSColumn.ColumnExpression);
            }
        }
    }
    else if (srcPage == "UpdateVariable") {
        var rowObject = eval("window.opener.Row" + selectedRow);
        var expEditor = GetExpressionEditor("ExpressionBuilderControl1");
        if (columnMode == "RHS") {
            //if(rowObject.ColumnExpression.DisplayExpressionString!="")
            //expEditor.SetExpression(rowObject.ColumnExpression);
            if (rowObject.ColumnExpression.DisplayExpressionString != "") {
                rowObject.ColumnExpression.DisplayExpressionString = DecodeTheExpressionString(rowObject.ColumnExpression.DisplayExpressionString);
                rowObject.ColumnExpression.ActualExprtessionString = DecodeTheExpressionString(rowObject.ColumnExpression.ActualExprtessionString);
                rowObject.ColumnExpression.HtmlVerexpString = DecodeTheExpressionString(rowObject.ColumnExpression.HtmlVerexpString);
                expEditor.SetExpression(rowObject.ColumnExpression);
            }
        }

    }
    else if (srcPage == "SOAConstructorExpression") {
        var actualData = window.opener.document.getElementById('hidNodeValue').value;
        var assemblyPath = window.opener.document.getElementById('hidAssemblyName').value;
        var nameSpaceName = window.opener.document.getElementById('hidNameSpaceName').value;
        var className = window.opener.document.getElementById('hidClassName').value;
        if (nameSpaceName != "") {
            actualData = "new " + nameSpaceName + "." + className + "(" + actualData + ")";
        }
        else {
            actualData = "new " + className + "(" + actualData + ")";
        }
        var ipBox = window.opener.GetInputBox('IB_ExpressionControl');
        var expEditor = GetExpressionEditor("ExpressionBuilderControl1");
        if (window.opener.document.getElementById('hdnActualExpression').value == "") {
            ipBox.Expression.DisplayExpressionString = actualData;
            ipBox.Expression.ActualExprtessionString = actualData;
            ipBox.Expression.HtmlVerexpString = actualData;
            ipBox.Expression.ReturnType = "object";
            ipBox.Expression.ReferenceList = "[INSTALLDIR]Bin$$Workflow.NET.NET2.dll," + assemblyPath;
            expEditor.SetExpression(ipBox.Expression);
        }
        else {
            if (window.opener.document.getElementById('hdnActualExpression').value != "") {
                expEditor.SetExpression(objectify(DecodeTheExpressionString(window.opener.document.getElementById('hdnActualExpression').value)));
            }
        }
    }
    else if (newpdObj.propertyName == "Query Builder") {
        var inputBox = '<%:this.Context.Request["RHS"]%>';
                 var some = window.opener.document.getElementById(inputBox).value;
                 var expEditor = GetExpressionEditor("ExpressionBuilderControl1");
                 if (window.opener.document.getElementById(inputBox).value != "") {

                     expEditor.SetExpression(objectify(DecodeTheExpressionString(window.opener.document.getElementById(inputBox).value)));
                 }
    }
	else if (newpdObj.propertyName == "AttachReport") {
	    var inputBox = '<%:this.Context.Request["RHS"]%>';
            var expEditor = GetExpressionEditor("ExpressionBuilderControl1");
            if (window.opener.document.getElementById(inputBox).value != "") {

                expEditor.SetExpression(objectify(DecodeTheExpressionString(window.opener.document.getElementById(inputBox).value)));
            }
        }
        else if (newpdObj.propertyName == "ActivityDetails") {
            var inputBox = '<%:this.Context.Request["RHS"]%>';
                var some = window.opener.document.getElementById(inputBox).value;
                var expEditor = GetExpressionEditor("ExpressionBuilderControl1");
                if (window.opener.document.getElementById(inputBox).value != "") {

                    expEditor.SetExpression(objectify(DecodeTheExpressionString(window.opener.document.getElementById(inputBox).value)));
                }
            }
            else if (newpdObj.propertyName == "WorkflowDetails") {
                var inputBox = '<%:this.Context.Request["RHS"]%>';
                var some = window.opener.document.getElementById(inputBox).value;
                var expEditor = GetExpressionEditor("ExpressionBuilderControl1");
                if (window.opener.document.getElementById(inputBox).value != "") {

                    expEditor.SetExpression(objectify(DecodeTheExpressionString(window.opener.document.getElementById(inputBox).value)));
                }
            }
            else if (newpdObj.propertyName == "Select Command") {

                var inputBox = '<%:this.Context.Request["RHS"]%>';
                    var some = window.opener.document.getElementById(inputBox).value;
                    var expEditor = GetExpressionEditor("ExpressionBuilderControl1");
                    if (window.opener.document.getElementById(inputBox).value != "") {
                        expEditor.SetExpression(objectify(DecodeTheExpressionString(window.opener.document.getElementById(inputBox).value)));
                    }
            }
            else if (newpdObj.propertyName === "configASBEventFilter")
            {
                var val = window.opener.skeltaUtils.getExpressionEditor();
                if (val)
                {
                    var expEditor = GetExpressionEditor("ExpressionBuilderControl1");
                    //var expression = JSON.parse(val.ExpressionString);
                    //expEditor.SetExpression(expression);
                    expEditor.SetExpression(objectify(DecodeTheExpressionString(val.ExpressionString)));
                }
    }
    else if (newpdObj.propertyName === "configRMQEventFilter") {
        var val = window.opener.skeltaUtils.getExpressionEditor();
        if (val) {
            var expEditor = GetExpressionEditor("ExpressionBuilderControl1");
            //var expression = JSON.parse(val.ExpressionString);
            //expEditor.SetExpression(expression);
            expEditor.SetExpression(objectify(DecodeTheExpressionString(val.ExpressionString)));
        }
    }
    else if (newpdObj.propertyName === "configLogicAppConnectionData" || newpdObj.propertyName === "configWaitForLogicAppAlert" || newpdObj.propertyName === "configRMQConnection" || newpdObj.propertyName === "configWebAPI") {
         var val = window.opener.skeltaUtils.getExpressionEditor();
        if (val) {
            var expEditor = GetExpressionEditor("ExpressionBuilderControl1");
            expEditor.SetExpression(objectify(DecodeTheExpressionString(val.ExpressionString)));
        }
    }
    else
    {
        var ipBox = window.opener.GetInputBox(parentControlName);
        var expEditor = GetExpressionEditor("ExpressionBuilderControl1");                    
        if (ipBox.Expression.DisplayExpressionString != "") {
            expEditor.SetExpression(ipBox.Expression);
        }
        else
        {
            SetFocusOnEditor();
        }
    }
}

function ltrim(s) {
    return s.replace(/^\s*/, "");
}

function rtrim(s) {
    return s.replace(/\s*$/, "");
}

function trim(s) {
    return rtrim(ltrim(s));
}

function DecodeTheExpressionString(expressionString) {
    if (expressionString.indexOf("_x002B_") > -1) {
        expressionString = replaceExpressionstring(expressionString, "_x002B_", "+")
    }
    if (expressionString.indexOf("_x002D_") > -1) {
        expressionString = replaceExpressionstring(expressionString, "_x002D_", "-")
    }
    if (expressionString.indexOf("_x002F_") > -1) {
        expressionString = replaceExpressionstring(expressionString, "_x002F_", "/")
    }
    return expressionString;
}

function replacestring(stringtobereplaced, chartobereplaced, charbywhichreplaced) {
    var out = "";
    if (stringtobereplaced == null) return;
    var l = stringtobereplaced.length;
    for (var i = 0; i < l; i++) {
        var ch = stringtobereplaced.charAt(i);
        if (ch == chartobereplaced) {
            stringtobereplaced = stringtobereplaced.replace(ch, charbywhichreplaced);
        }
    }

    return stringtobereplaced;
}




function ReplaceSplTags(inputString, stringtobereplaced, stringbywhichreplaced) {
    var returnstring = "";

    returnstring = inputString.replace(stringtobereplaced, stringbywhichreplaced);

    if (returnstring.indexOf(stringtobereplaced) > -1) {
        returnstring = ReplaceSplTags(returnstring, stringtobereplaced, stringbywhichreplaced)
    }
    return returnstring;
}

function AfterToggleHandler(node) {

    if (node.Nodes != null) {
        if (node.Nodes[0] != null) {
            if (node.Nodes[0].ID == "Error")
                alert(node.Nodes[0].Value);
        }
    }
}

function resizeTree() {

    var app = navigator.userAgent;
    var broeswerCode = 0;
    if (app.indexOf("MSIE") > -1) {
        broeswerCode = 1;
    }

    else if (app.indexOf("Mozilla") > -1) {
        broeswerCode = 2;
    }

    else if (app.indexOf("Firefox") > -1) {
        broeswerCode = 2;
    }
    else {
        broeswerCode = 3;
    }

    //var treeDiv = document.getElementById("RadTree1Div");
    var treeDiv = document.getElementById("RadTree1");

    var intCompensate = 6;
    var treeheight = 0;
    var treewidth = 0;

    if (broeswerCode == 1) {
        treeheight = document.body.offsetHeight;
        treewidth = document.body.offsetWidth;
    }
    else if (broeswerCode == 2) {
        treeheight = parseInt(document.documentElement.clientHeight) * 0.961;
        treewidth = document.documentElement.clientWidth;
    }
    else {
        treeDiv.style.height = "10px";
        treeDiv.style.width = "10px";
        treeheight = document.documentElement.clientHeight;
        treewidth = document.documentElement.clientWidth;
    }



    if (parseInt(treeheight) > intCompensate) {
        treeDiv.style.height = parseInt(treeheight) + "px";
    }

    if (parseInt(treewidth) > intCompensate)
        treeDiv.style.width = treewidth + "px";


}




function resizeTreeFromOut(objHeight, objWidth) {
    var app = navigator.userAgent;
    var broeswerCode = 0;
    if (app.indexOf("MSIE") > -1) {
        broeswerCode = 1;
    }
    else if (app.indexOf("Mozilla/5.0") > -1) {
        broeswerCode = 2;
    }
    else if (app.indexOf("Firefox/1.5") > -1) {
        broeswerCode = 2;
    }
    else {
        broeswerCode = 3;
    }

    //var treeDiv = document.getElementById("RadTree1Div");
    var treeDiv = document.getElementById("RadTree1");
    var intCompensate = 6;
    var treeheight = 0;
    var treewidth = 0;

    if (broeswerCode == 1) {
        treeheight = document.body.offsetHeight;
        treewidth = document.body.offsetWidth;
    }
    else if (broeswerCode == 2) {
        if (objHeight != null) {
            treeheight = objHeight;
            treewidth = parseInt(objWidth);
        }
        else {
            treeheight = parseInt(document.documentElement.clientHeight) * 0.961;
            treewidth = document.documentElement.clientWidth;
        }

    }
    else {
        treeDiv.style.height = "10px";
        treeDiv.style.width = "10px";
        treeheight = document.documentElement.clientHeight;
        treewidth = document.documentElement.clientWidth;
    }

    if (parseInt(treeheight) > intCompensate) {
        treeDiv.style.height = parseInt(treeheight) + "px";
    }
    if (parseInt(treewidth) > intCompensate)
        treeDiv.style.width = treewidth + "px";
}

</script>