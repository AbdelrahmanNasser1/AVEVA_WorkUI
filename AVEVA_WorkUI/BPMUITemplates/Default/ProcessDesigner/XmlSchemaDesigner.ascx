<%@ Control language="c#" AutoEventWireup="false" inherits="Workflow.NET.Template.XmlSchemaDesignerPageCodeFile"%>
<script src="<%=xmlSchemaDesigner.GetJscriptUrl("../Common/javascripts/SchemaDefinition.js")%>"></script>
<link rel="stylesheet" type="text/css" href="<%=xmlSchemaDesigner.GetCommonRelativeUrl("../ProcessDesigner/stylesheet/SchemaDefinition.css")%>">
<table border="0" width="100%" align="center" cellpadding="0" cellspacing="0" ID="Table3">
	       <tr>
	       <td>
                <table border="0" width="100%" align="center" cellpadding="1" cellspacing="0" ID="Table1" >
                 <%if(xmlSchemaDesigner.IsSchemaEditable){%>
	                <tr>
	                <td align="center">
	                    <table border="0" width="100%" align="center" cellpadding="2" cellspacing="0" ID="Table6">
	                  
	                    <tr>
	                            <td class="subtitle" align="left" width="6%">
	                                &nbsp;<%=xmlSchemaDesigner.GlobalResourceSet.GetString("XmlVariableSchemaFile")%> :
	                            </td>
	                            <td align="left">
	                                <input type="file" id="XMLFile" name="XMLFile" class="inputtext" style="width:280px" />&nbsp;&nbsp; <input type="button" class="inputbutton" value="<%=xmlSchemaDesigner.GlobalResourceSet.GetString("XmlVariableSchemaFileLoad")%>" onclick="javascript:LoadSchemaFromFile()"/>
	                                <input type="hidden" id="hidcheck" name="hidcheck" value="<%= hidcheckvalue %>" />
	                            </td>
	                            
	                     </tr>
	                    
	                    </table>
	                </td>
	                </tr>
	                 <%}%>
	                <tr>
		                <td align="center" >
		                				
		                    <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%" ID="Table2">
				                <tr>
                                    <td >
				                          <table border="0" cellpadding="1" cellspacing="1" width="100%" ID="Table4">
					                            <tr>
						                            <td colspan="2" valign="top" align="center">
    												    <div id="divSource"  style="display:block;">
	                    							    <table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" ID="Table5">
						                		            <tr>
								                                <td width=5%>
								                                    &nbsp;
								                                </td>
								                                <td class="lefttdbg" width=90%>
									                                 <div id="xmlTreeDiv" style="display:block;OVERFLOW: auto; WIDTH: <%=xmlSchemaDesigner.Width%>; HEIGHT: <%=xmlSchemaDesigner.Height%>;"  class="NewTableContainer" ></div>
										                        </td>
										                        <td width=5%>
								                                    &nbsp;
								                                </td>
									                        </tr>
								                        </table>
							                        </div>
						                        </td>
					                        </tr>
					                  </table> 
					                </td>
					            </tr>
					          </table>     
                         </td>
                    </tr>
            </table>
          </td>
        </tr>
      </table>  
            
            <input type="hidden" id="HiddennodeId" name="HiddennodeId" /> 
	                            <input type="hidden" id="HiddenParentnodeId" name="HiddenParentnodeId" /> 
			    <div id="MenuDiv" style="border:1px #256194;"  style="display:none" ></div>     
                <div id="MenuSubDiv" style="border:1px #256194;"  style="display:none" ></div> 
                
                <div id="PropertyDiv" style="border:1px solid #256194;display:none"/>
                
                
<script type="text/javascript">
OnLoad();
isEditable = '<%=xmlSchemaDesigner.IsSchemaEditable%>';
var exceptionstring="<%=xmlSchemaDesigner.ExceptionString%>";
var MenuAddString = '<%=xmlSchemaDesigner.GlobalResourceSet.GetString("XmlSchemaAdd")%>';
var MenuEditString = '<%=xmlSchemaDesigner.GlobalResourceSet.GetString("XmlSchemaEdit")%>';
var MenuDeleteString = '<%=xmlSchemaDesigner.GlobalResourceSet.GetString("XmlSchemaDelete")%>';
var XmlSchemaProperties =  '<%=xmlSchemaDesigner.GlobalResourceSet.GetString("XmlSchemaProperties")%>';
var XmlSchemaElementName =  '<%=xmlSchemaDesigner.GlobalResourceSet.GetString("XmlSchemaElementName")%>';
var XmlSchemaElementType  =  '<%=xmlSchemaDesigner.GlobalResourceSet.GetString("XmlSchemaElementType")%>';
var XmlSchemaElementDataType =  '<%=xmlSchemaDesigner.GlobalResourceSet.GetString("XmlSchemaElementDataType")%>';
var XmlSchemaElementRepeat = '<%=xmlSchemaDesigner.GlobalResourceSet.GetString("XmlSchemaElementRepeat")%>';
var XmlSchemaOK = '<%=xmlSchemaDesigner.GlobalResourceSet.GetString("ExpOK")%>';
var XmlSchemaCancel = '<%=xmlSchemaDesigner.GlobalResourceSet.GetString("ExpCancel")%>';
var XmlSchemaElement = '<%=xmlSchemaDesigner.GlobalResourceSet.GetString("XmlSchemaElement")%>';
var XmlSchemaAttribute = '<%=xmlSchemaDesigner.GlobalResourceSet.GetString("XmlSchemaAttribute")%>';

dataTypes = '<%=xmlSchemaDesigner.DataTypes%>';
displayDataTypes= '<%=xmlSchemaDesigner.DisplayDatatypes%>';

var FileUploadMsg = '<%=xmlSchemaDesigner.GlobalResourceSet.GetString("XmlSchemaSpecifyFile")%>' 

if(exceptionstring!="")
{
    alert(exceptionstring);
}
function GetXML()
{
    var objectString = stringify(objTree.root);
    document.getElementById("hidden1").value = objectString; 
}

function OnLoad()
{
    DIR_IMAGES  =   '<%=xmlSchemaDesigner.GetCommonRelativeUrl()%>';
    DIR_IMAGES = DIR_IMAGES +'/Images/';
    
    IMG_PLUS    =   DIR_IMAGES + "btnPlus.gif";
    IMG_MINUS   =   DIR_IMAGES + "btnMinus.gif";
    angleImage = DIR_IMAGES+"angle.gif"
    MenuGif = DIR_IMAGES+"9.gif"
    
    imgPlus.src = IMG_PLUS;
    imgMinus.src = IMG_MINUS;

    
    /*objTree.buildDOM();
    
	var strInnerHTML = document.getElementById("xmlTreeDiv").innerHTML;
	document.getElementById("xmlTreeDiv").innerHTML = strInnerHTML.replace("<DIV><DIV>",""); 
	*/
	//top.document.getElementById("VarDescription").value = document.getElementById("xmlTreeDiv").innerHTML;
	
	MenuDivObj = document.getElementById('MenuDiv');
    MenuDivObj.style.display="none";
    
    MenuSubDivObj = document.getElementById('MenuSubDiv');
    MenuSubDivObj.style.display="none";
	
	document.onclick=windowmouseclickhandler;
	document.onmousemove=windowmousemovehandler;
}
</script>