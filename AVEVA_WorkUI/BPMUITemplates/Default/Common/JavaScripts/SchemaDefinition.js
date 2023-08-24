//Treeview
var DIR_IMAGES="";//= "../Common/images/";
var IMG_PLUS="";
var IMG_MINUS = "";
var angleImage = "" ;
var MenuGif="";
var retNode;
var menuOpened=0;
var imgClicked=0;
var datatype="";
var xsdstring="";
var MenuDivObj;
var MenuSubDivObj;
var TopBgImgSrc="";
var objTree = new jsTree;
var imgPlus = new Image();
imgPlus.src = IMG_PLUS;
var imgMinus = new Image();
imgMinus.src = IMG_MINUS;
var isEditable='True';
var dataTypes="";
var displayDataTypes="";

//var DataTypes="string,integer,long,double,decimal,date,time,dateTime,boolean,base64Binary";

//alert(dataTypes);
//alert(displayDataTypes);

var INDENT_WIDTH = 19;

var rowCount=1;
var selectedRowId = 1;
var prevRow = 0;
var bubbleWindowObj;
var selectedvaraiable="";
var selectedvaraiableType="";
var selectedvaraiableDesc="";
var Iframesrc="";
var ModeOfUpdate="";
var nodeTextObj;




function jsTree() {

    //Public Properties 
    this.root = null;           //the root node of the tree
 
     //Public Collections 
    this.nodes = new Array;     //array for all nodes in the tree
   
    //Constructor
    //assign to local copy of the tree 
    objLocalTree = this;
}

//-----------------------------------------------------------------
// Method jsTree.createRoot()
//-----------------------------------------------------------------
//
// Description
//  This method creates the root of the tree.
//
// Parameters
//  strIcon (string) - the icon to display for the root.
//  strText (string) - the text to display for the root.
//  strURL (string) - the URL to navigate to when the root is clicked.
//  strTarget (string) - the target for the URL (optional).
//
// Returns
//  The jsTreeNode that was created.
//-----------------------------------------------------------------
jsTree.prototype.createRoot = function(strIcon, strText, strURL, strTarget,strType) {

    //create a new node 
    this.root = new jsTreeNode(strIcon, strText, strURL, strTarget,strType,null,"",false);
    
    //assign an ID for internal tracking 
    this.root.id = "root";
    
    //add it into the array of all nodes 
    this.nodes["root"] = this.root;
    
    //make sure that the root is expanded 
    this.root.expanded = true;
    
    //return the created node 
    return this.root;
}

//-----------------------------------------------------------------
// Method jsTree.buildDOM()
//-----------------------------------------------------------------
// Description
//  This method creates the HTML for the tree.
//
// Parameters
//  (none)
//
// Returns
//  (nothing)
//-----------------------------------------------------------------
jsTree.prototype.buildDOM = function() {

    //call method to add root to document, which will recursively
    //add all other nodes 
    if(this.root!=null)
        this.root.addToDOM(document.getElementById("xmlTreeDiv"));
}

//-----------------------------------------------------------------
// Method jsTree.toggleExpand()
//-----------------------------------------------------------------
// Description
//  This toggles the expansion of a node identified by an ID.
//
// Parameters
//  strNodeID (string) - the ID of the node that is being expanded/collapsed.
//
// Returns
//  (nothing)
//-----------------------------------------------------------------
jsTree.prototype.toggleExpand = function(strNodeID) {

    var objNode = this.nodes[strNodeID];
    
    //determine whether to expand or collapse
    if (objNode.expanded)
        objNode.collapse();
    else
        objNode.expand();
}

//-----------------------------------------------------------------
// Class jsTreeNode
//-----------------------------------------------------------------
// Description
//  The jsTreeNode class encapsulates the basic information for a node
//  in the tree.
//
// Parameters
//  strIcon (string) - the icon to display for this node.
//  strText (string) - the text to display for this node.
//  strURL (string) - the URL to navigate to when this node is clicked.
//  strTarget (string) - the target for the URL (optional).
//-----------------------------------------------------------------
//function jsTreeNode(strIcon, strText, strURL, strTarget) 
//code modification by Sajit on 22 monday 2004
function jsTreeNode(strIcon, strText, strURL, strTarget,strType,strParent,nodeDataType,IsRepeating) {

    this.icon = strIcon;            //the icon to display
    this.text = strText;            //the text to display
    this.url = strURL;              //the URL to link to
    this.target = strTarget;        //the target for the URL
    this.type=strType;				//the type of the node 
    this.parent=strParent;			//the node in which an attribute is contained.null if type=node
    this.DataType=nodeDataType;
    this.indent = 0;                //the indent for the node
    this.IsRepeating=IsRepeating;
    //this.expanded = false;          //is this node expanded?
    this.expanded = true;          //is this node expanded?
    this.childNodes = new Array;    //the collection of child nodes
}

//-----------------------------------------------------------------
// Method jsTreeNode.addChild()
//-----------------------------------------------------------------
//
// Description
//  This method adds a child node to the current node.
//
// Parameters
//  strIcon (string) - the icon to display for this node.
//  strText (string) - the text to display for this node.
//  strURL (string) - the URL to navigate to when this node is clicked.
//  strTarget (string) - the target for the URL (optional).
//
// Returns
//  The jsTreeNode that was created.
//-----------------------------------------------------------------
//Code modified by Sajit on 22 Nov 2004
//jsTreeNode.prototype.addChild = function (strIcon, strText, strURL, strTarget)
jsTreeNode.prototype.addChild = function (strIcon, strText, strURL, strTarget,strType,strParent,nodeDataType,IsRepeating) {
   
    
    // create a new node (NCZ, 1/27/02)
	// var objNode = new jsTreeNode(strIcon, strText, strURL, strTarget);
	//alert("in addChild"+ strParent);
	var _isRepeating=false;
	if(IsRepeating=="True")
	{
	    _isRepeating=true;
	}
	else
	{
	    _isRepeating=false;
	}
	var objNode = new jsTreeNode(strIcon, strText, strURL, strTarget,strType,strParent,nodeDataType,_isRepeating);
    
    //assign an ID for internal tracking (NCZ, 1/27/02)
    objNode.id = this.id + "_" + this.childNodes.length;
    
    //assign the indent for this node
    objNode.indent = this.indent + 1;
    
    //add into the array of child nodes (NCZ, 1/27/02)
    this.childNodes[this.childNodes.length] = objNode;
    
    //add it into the array of all nodes (NCZ, 1/27/02)
    objLocalTree.nodes[objNode.id] = objNode;
    
    //return the created node (NCZ, 1/27/02)
    return objNode;
}

//-----------------------------------------------------------------
// Method jsTreeNode.addToDOM()
//-----------------------------------------------------------------
//
// Description
//  This method adds DOM elements to a parent DOM element.
//
// Parameters
//  objDOMParent (HTMLElement) - the parent DOM element to add to.
//
// Returns
//  (nothing)
//-----------------------------------------------------------------
jsTreeNode.prototype.addToDOM = function (objDOMParent) {

    //create the URL (NCZ, 1/27/02)
   // var strHTMLLink = "<a href=\"" + this.url + "\"";
    //Modified by shanmug on 5 OCT 04</SPAN></FONT></P>
	//alert("add to DOM"+this.parent);
    var strHTMLLink = this.url;
        
	//var strHTMLLink = "<a href=\"#\" onclick=\"" + this.url + "\" ";
    //if (this.target)
        //strHTMLLink += " target=\"" + this.target + "\"";
    //strHTMLLink += ">";
    
    //create the layer for the node (NCZ, 1/27/02)
    var objNodeDiv = document.createElement("div");
    
    //add it to the DOM parent element (NCZ, 1/27/02)
    objDOMParent.appendChild(objNodeDiv);
    
    //create string buffer (NCZ, 1/27/02)
    var d = new jsDocument;
    
    //begin the table (NCZ, 1/27/02)
    //Shanmug Added div on 6 Dec 04 to make the tree view align properly
    d.writeln("<div><table border=\"0\" bordercolor=red cellpadding=\"2\" cellspacing=\"0\"><tr>");
    
    //no indent needed for root or level under root (NCZ, 1/27/02)
    if (this.indent > 1) {
        d.write("<td width=\"");
        d.write(this.indent * INDENT_WIDTH);
        d.write("\">&nbsp;</td>");
    }
    
    //there is no plus/minus image for the root (NCZ, 1/27/02)
    if (this.indent > 0) {
    
        d.write("<td width=\"18\" align=\"center\">");
        
        //if there are children, then add a plus/minus image (NCZ, 1/27/02)
        if (this.childNodes.length > 0) {
            d.write("<a href=\"javascript:objLocalTree.toggleExpand('");
            d.write(this.id);
            d.write("')\"><img src=\"");
            d.write(this.expanded ? imgMinus.src : imgPlus.src);
            d.write("\" border=\"0\" hspace=\"1\" id=\"");
            d.write("imgPM_" + this.id);
            d.write("\" /></a>");
        }
        
        d.write("</td>");
    }
    if(isEditable=='True')
        strHTMLLink = "<a href=\"#\" onclick=\"javascript:OpenMenu('"+this.id+"',this,'"+this.parent+"','"+this.type+"')\"><img border=0 src=\""+MenuGif+"\" alt=\"Menu\"></a>";
    
    var elementImg="";
    var altMsg="";
    
    if(this.type=="element")
    {
        elementImg ="<img hspace=\"1\" src=\"" + DIR_IMAGES+"element.gif" + "\" border=\"0\" alt=\""+"element"+"\" align=\"absmiddle\" />";
    }
    else if(this.type=="attribute")
    {
        elementImg ="<img hspace=\"1\" src=\"" + DIR_IMAGES+"attribute.gif" + "\" border=\"0\" alt=\""+"attribute"+"\" align=\"absmiddle\" />";
    }
    
   
    if((this.childNodes.length==0)&&(this.id!="root"))
    {
        if(trim(this.DataType)!="")
        {
            if(isEditable=='True')
                d.write("<td nowrap=\"nowrap\" class=\"contenttext\"><img hspace=\"1\" src=\"" + this.icon + "\" border=\"0\"  align=\"absmiddle\" /> "+elementImg+"<input type=\"text\" id=\"text"+this.id+"\" size=30 onclick=\"javascript:ClickStyle(this)\" onblur=\"javascript:BlurStyle(this)\"  class=\"BlurStyle\" value='"+this.text+"' onchange=\"javascript:textChange('"+this.id+"',this.value,'"+this.type+"','"+this.parent+"',this)\" >("+this.DataType+")" + strHTMLLink +"</td>");
            else
                d.write("<td nowrap=\"nowrap\" class=\"contenttext\"><img hspace=\"1\" src=\"" + this.icon + "\" border=\"0\" align=\"absmiddle\" /> "+elementImg+"<input type=\"text\" id=\"text"+this.id+"\" size=30 onclick=\"javascript:ClickStyle(this)\" onblur=\"javascript:BlurStyle(this)\"  readonly class=\"BlurStyle\" value='"+this.text+"'\" >("+this.DataType+")" + strHTMLLink +"</td>");
                    
        }
        else
        {
            if(isEditable=='True')
            {
                d.write("<td nowrap=\"nowrap\" class=\"contenttext\"><img hspace=\"1\" src=\"" + this.icon + "\" border=\"0\" align=\"absmiddle\" /> "+elementImg+"<input type=\"text\" id=\"text"+this.id+"\" size=30 onclick=\"javascript:ClickStyle(this)\" onblur=\"javascript:BlurStyle(this)\" class=\"BlurStyle\" value='"+this.text+"' onchange=\"javascript:textChange('"+this.id+"',this.value,'"+this.type+"','"+this.parent+"',this)\" >" + strHTMLLink +"</td>");
            }
            else
            {
                d.write("<td nowrap=\"nowrap\" class=\"contenttext\"><img hspace=\"1\" src=\"" + this.icon + "\" border=\"0\" align=\"absmiddle\" /> "+elementImg+"<input type=\"text\" id=\"text"+this.id+"\" size=30 onclick=\"javascript:ClickStyle(this)\" onblur=\"javascript:BlurStyle(this)\" readonly class=\"BlurStyle\" value='"+this.text+"' onchange=\"javascript:textChange('"+this.id+"',this.value,'"+this.type+"','"+this.parent+"',this)\" >" + strHTMLLink +"</td>");
            }
        }
    }
    else
    {
     if(trim(this.DataType)!="")
        {
                if(isEditable=='True')
                    {
                      if(this.childNodes.length==0)
                      {
                  d.write("<td nowrap=\"nowrap\" class=\"contenttext\"><img hspace=\"1\" src=\"" + this.icon + "\" border=\"0\" align=\"absmiddle\" />"+elementImg+"<input type=\"text\" id=\"text"+this.id+"\" size=30 onclick=\"javascript:ClickStyle(this)\" onblur=\"javascript:BlurStyle(this)\" class=\"BlurStyle\" value='"+this.text+"' onchange=\"javascript:textChange('"+this.id+"',this.value,'"+this.type+"','"+this.parent+"',this)\" >("+this.DataType+")" + strHTMLLink +"</td>");
                      
                      }
                      else
                      {
                       d.write("<td nowrap=\"nowrap\" class=\"contenttext\"><img hspace=\"1\" src=\"" + this.icon + "\" border=\"0\" align=\"absmiddle\" />"+elementImg+"<input type=\"text\" id=\"text"+this.id+"\" size=30 onclick=\"javascript:ClickStyle(this)\" onblur=\"javascript:BlurStyle(this)\" class=\"BlurStyle\" value='"+this.text+"' onchange=\"javascript:textChange('"+this.id+"',this.value,'"+this.type+"','"+this.parent+"',this)\" >"+ strHTMLLink +"</td>");
                      }
                      
                   }
                    else
                    {
                    
                     if(this.childNodes.length==0)
                      {
                    
                       d.write("<td nowrap=\"nowrap\" class=\"contenttext\"><img hspace=\"1\" src=\"" + this.icon + "\" border=\"0\" align=\"absmiddle\" />"+elementImg+"<input type=\"text\"  id=\"text"+this.id+"\" size=30 onclick=\"javascript:ClickStyle(this)\" onblur=\"javascript:BlurStyle(this)\"  readonly class=\"BlurStyle\" value='"+this.text+"'>("+this.DataType+")" + strHTMLLink +"</td>");
                       }
                       else
                       {
                        d.write("<td nowrap=\"nowrap\" class=\"contenttext\"><img hspace=\"1\" src=\"" + this.icon + "\" border=\"0\" align=\"absmiddle\" />"+elementImg+"<input type=\"text\"  id=\"text"+this.id+"\" size=30 onclick=\"javascript:ClickStyle(this)\" onblur=\"javascript:BlurStyle(this)\"  readonly class=\"BlurStyle\" value='"+this.text+"'>" + strHTMLLink +"</td>");
                        
                       }
                     }
         }
         else
         {
                 if(isEditable=='True')
                {
                   d.write("<td nowrap=\"nowrap\" class=\"contenttext\"><img hspace=\"1\" src=\"" + this.icon + "\" border=\"0\" align=\"absmiddle\" />"+elementImg+"<input type=\"text\" id=\"text"+this.id+"\" size=30 onclick=\"javascript:ClickStyle(this)\" onblur=\"javascript:BlurStyle(this)\" class=\"BlurStyle\" value='"+this.text+"' onchange=\"javascript:textChange('"+this.id+"',this.value,'"+this.type+"','"+this.parent+"',this)\" >" + strHTMLLink +"</td>");
               }
                else
                {
                   d.write("<td nowrap=\"nowrap\" class=\"contenttext\"><img hspace=\"1\" src=\"" + this.icon + "\" border=\"0\" align=\"absmiddle\" />"+elementImg+"<input type=\"text\"  id=\"text"+this.id+"\" size=30 onclick=\"javascript:ClickStyle(this)\" onblur=\"javascript:BlurStyle(this)\"  readonly class=\"BlurStyle\" value='"+this.text+"'>" + strHTMLLink +"</td>");
                 }       
         
         }           
    }
    d.writeln("</tr></table></div>");
        
    //assign the HTML to the layer (NCZ, 1/27/02)
    objNodeDiv.innerHTML = d;
    
    //create the layer for the children (NCZ, 1/27/02)
    var objChildNodesLayer = document.createElement("div");
    objChildNodesLayer.setAttribute("id", "divChildren_" + this.id);
    objChildNodesLayer.style.position = "relative";
    objChildNodesLayer.style.display = (this.expanded ? "block" : "none");
    objNodeDiv.appendChild(objChildNodesLayer);
    
    //call for all children (NCZ, 1/27/02)
    for (var i=0; i < this.childNodes.length; i++)
    {
       if(this.childNodes[i]!=null) 
            this.childNodes[i].addToDOM(objChildNodesLayer);
    }   
}

function GetDisplayText(input)
{
   var dtarr= dataTypes.split(',');
   var dispdtarr= displayDataTypes.split(',');
   var retvalue="";
   for(var i=0;i<dtarr.length;i++)
   {
        if(input==dtarr[i])
        {
            retvalue = dispdtarr[i]; 
            break;
        }
   
   }
   return retvalue;
}


//-----------------------------------------------------------------
// Method jsTreeNode.collapse()
//-----------------------------------------------------------------
// Description
//  This method expands the jsTreeNode's children to be hidden.
//
// Parameters
//  (none)
//
// Returns
//  (nothing)
//-----------------------------------------------------------------
jsTreeNode.prototype.collapse = function () {

    //check to see if the node is already collapsed (NCZ, 1/27/02)
    if (!this.expanded) {
    
        //throw an error (NCZ, 1/27/02)
        throw "Node is already collapsed"

    } else {
    
        //change the state of the node (NCZ, 1/27/02)
        this.expanded = false;
        
        //change the plus/minus image to be plus (NCZ, 1/27/02)
        document.images["imgPM_" + this.id].src = imgPlus.src;
        
        //hide the child nodes (NCZ, 1/27/02)
        document.getElementById("divChildren_" + this.id).style.display = "none";
    }
}


//-----------------------------------------------------------------
// Method jsTreeNode.expand()
//-----------------------------------------------------------------
// Description
//  This method expands the jsTreeNode's children to be displayed.
//
// Parameters
//  (none)
//
// Returns
//  (nothing)
//-----------------------------------------------------------------
jsTreeNode.prototype.expand = function () {

    //check to see if the node is already expanded (NCZ, 1/27/02)
    if (this.expanded) {
    
        //throw an error (NCZ, 1/27/02)
        throw "Node is already expanded"
    
    } else {
    
        //change the state of the node (NCZ, 1/27/02)
        this.expanded = true;
        
        //change the plus/minus image to be minus (NCZ, 1/27/02)
        document.images["imgPM_" + this.id].src = imgMinus.src;
        
        //show the child nodes (NCZ, 1/27/02)
        document.getElementById("divChildren_" + this.id).style.display = "block";
    }
}

function jsDocument() 
{
	this.text = new Array();		//array to store the string
	this.write = function (str) { this.text[this.text.length] = str; }
	this.writeln = function (str) { this.text[this.text.length] = str + "\n"; }
	this.toString = function () { return this.text.join(""); }
	this.clear = function () { delete this.text; this.text = null; this.text = new Array; }
}
//Method needed to change the style sheet of the xml tree textbox when the blur event of the textbox is fired
function BlurStyle(objElement)
{
	event.srcElement.className="BlurStyle";
}
//Method to handle click event of xml tree textbox
function ClickStyle(objElement)
{
	event.srcElement.className="ClickStyle";
}
//**********************************

//***************************************************
function TreeClick(taskName)
{
    switch(taskName)
    {
        
        case "ADD":
                //AddChild('Element');
                OpenPropertyBox(taskName);
                break;    
        case "Edit":
                OpenPropertyBox(taskName);   
                break;
        case "Delete":
                Delete(document.getElementById("HiddennodeId").value);break;
                break;
    }        

}

function AddChild(nodeType)
{
    var clickedNode = document.getElementById("HiddennodeId").value;
    var parentNode = document.getElementById("HiddenParentnodeId").value;
    
    
    if(clickedNode=="root")
    {
         if(nodeType=="Element")
                objTree.root.addChild(angleImage, "Element", "", "_blank","element","root");
          else
                objTree.root.addChild(angleImage, "Attribute", "", "_blank","attribute","root");
                
    }
    else
    {
        AddChildNode(objTree.root,clickedNode,nodeType);
    }
 
    BuildTree();
	ClearMenu();
}

function CreateNode(mode)
{
    var clickedNode = document.getElementById("HiddennodeId").value;
    var parentNode = document.getElementById("HiddenParentnodeId").value;
    var nodeType="";
    var nodetext="";
    var nodeDataType="";
    var isrepeated=false;
    var isValid=true;
    
    nodeType = document.getElementById("cmbNodeType").value;
    nodetext = document.getElementById("txtNodeText").value;
    nodeDataType =document.getElementById("cmbnodedatatype").value;
    isrepeated =document.getElementById("chkRepeating").checked;
    
    if(trim(nodetext)=="")
    {
        alert("Please enter Name");
        document.getElementById("txtNodeText").focus();
        isValid =false;
    } 
    else
    {
        isValid = CheckInputValue(trim(nodetext));
    }
    
    if(isValid)
    {
        if(mode=="ADD")
        { 
            if(clickedNode=="root")
            {
                 if(nodeType=="element")
                        objTree.root.addChild(angleImage, trim(nodetext), "", "_blank","element","root",nodeDataType,isrepeated);
                  else
                        objTree.root.addChild(angleImage, trim(nodetext), "", "_blank","attribute","root",nodeDataType,isrepeated);
                        
            }
            else
            {
                AddChildNode(objTree.root,clickedNode,nodeType,trim(nodetext),nodeDataType,isrepeated);
            }
        }
        else
        {
             var node = GetNode(clickedNode);
             node.text = trim(nodetext);
             node.type = nodeType;
             node.DataType =nodeDataType;
             node.IsRepeating=isrepeated;
        }
        BuildTree();
	    ClearMenu();
	    var proprObj =document.getElementById("PropertyDiv"); 
        proprObj.style.display="none";
   }
   else
   {
        document.getElementById("txtNodeText").focus();
        return false;
   } 
}
function AddChildNode(node,clickedNodeID,nodeType,nodetext,nodeDataType,isrepeated)
{
    for(var i=0; i < node.childNodes.length;i++)
    {
        if(node.childNodes[i].id == clickedNodeID)
        {
            if(nodeType=="element")
                node.childNodes[i].addChild(angleImage, nodetext, "", "_blank","element",clickedNodeID,nodeDataType,isrepeated);
            else
                node.childNodes[i].addChild(angleImage, nodetext, "", "_blank","attribute",clickedNodeID,nodeDataType,isrepeated);    
        }
        else
        {
          AddChildNode(node.childNodes[i],clickedNodeID,nodeType,nodetext,nodeDataType,isrepeated);        		            
        }
     }
}

function GetNode(nodeID)
{
    if(nodeID=="root")
    {
       return objTree.root;
    }    
    else
    {
        return GetSelectedNode(nodeID,objTree.root);
    }
}

function GetSelectedNode(nodeID,node)
{
     
     for(var i=0; i < node.childNodes.length;i++)
        {
            if(node.childNodes[i]!=null)
            {
                if(node.childNodes[i].id==nodeID)
                {
                   retNode = node.childNodes[i];
                   break;
                }
                else
                {
                  GetSelectedNode(nodeID,node.childNodes[i]);        		            
                }
            }
        }		
   if(node.childNodes!=null)
   {
        if( node.childNodes.length==0)
        {
            if(node.id==nodeID)
            {
               retNode = node;
            }
        }
    }
    return retNode;
}
				
function OpenPropertyBox(mode) {

    var innerHTMl = "";
    TopBgImgSrc = DIR_IMAGES + "top-bg.gif"
    var closeImg = DIR_IMAGES + "delete-trans.png"

    var nodtext = "";
    var nodType = "";
    var nodeDataType = "";
    var IsRepeating = "";
    var bcode = GetBrowserversion();
    if (mode == "Edit") {
        clickedNode = document.getElementById("HiddennodeId").value;
        var node = GetNode(clickedNode);
        nodtext = node.text;
        nodType = node.type;
        nodeDataType = node.DataType
        IsRepeating = node.IsRepeating;
    }
    innerHTMl = "<table border=\"0\" width=\"100%\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" ID=\"Table7\">";
    innerHTMl = innerHTMl + "<tr>";
    innerHTMl = innerHTMl + "<td align=\"center\">";
    innerHTMl = innerHTMl + "<table border=\"0\" width=\"100%\" class=\"lefttdbg\" align=\"center\" cellpadding=\"4\" cellspacing=\"0\" ID=\"Table8\">";
    innerHTMl = innerHTMl + "<tr class=\"ListHeaderCss\">";
    innerHTMl = innerHTMl + "<td  class=\"fontheading\" align='left'>" + XmlSchemaProperties + "</td>";
    innerHTMl = innerHTMl + "<td align='right'><a href=\"#\" onclick=\"javascript:CloseDiv()\"><img src=" + closeImg + " width=\"17\" height=\"17\" border=0 onClick=\"CloseDiv();\"/></a>";
    innerHTMl = innerHTMl + "</td>";
    innerHTMl = innerHTMl + "</tr>";

    if (bcode == 1) {
        innerHTMl = innerHTMl + " <tr>";
        innerHTMl = innerHTMl + "<td colspan=\"2\"><img src=\"Images/Spacer.gif\" border=\"0\" height=\"8\"></td>";
        innerHTMl = innerHTMl + "</tr>";
    }
    innerHTMl = innerHTMl + "<tr>";
    innerHTMl = innerHTMl + "<td class=\"contenttext\" align='center'>";
    innerHTMl = innerHTMl + "" + XmlSchemaElementName + ":";
    innerHTMl = innerHTMl + "</td>";
    innerHTMl = innerHTMl + "<td class=\"contenttext\">";
    innerHTMl = innerHTMl + "<input type=\"text\"  class=\"contenttext\" value =\"" + nodtext + "\" id=\"txtNodeText\"/>";
    innerHTMl = innerHTMl + "</td>";
    innerHTMl = innerHTMl + "</tr>";
    innerHTMl = innerHTMl + " <tr>";
    innerHTMl = innerHTMl + "<td class=\"contenttext\" align='center'>";
    innerHTMl = innerHTMl + "" + XmlSchemaElementType + ":";
    innerHTMl = innerHTMl + "</td>";
    innerHTMl = innerHTMl + "<td class=\"contenttext\">";
    innerHTMl = innerHTMl + "<select id=\"cmbNodeType\" class=\"contenttext\">";
    if (nodType == "element")
        innerHTMl = innerHTMl + "<option value='element' selected>" + XmlSchemaElement + "</option>";
    else
        innerHTMl = innerHTMl + "<option value='element' selected>" + XmlSchemaElement + "</option>";

    if (nodType == "attribute")
        innerHTMl = innerHTMl + "<option value='attribute' selected>" + XmlSchemaAttribute + "</option>";
    else
        innerHTMl = innerHTMl + "<option value='attribute'>" + XmlSchemaAttribute + "</option>";

    innerHTMl = innerHTMl + "</select>";
    innerHTMl = innerHTMl + "</td>";
    innerHTMl = innerHTMl + "</tr>";
    innerHTMl = innerHTMl + "<tr>";
    innerHTMl = innerHTMl + "<td class=\"contenttext\" align='center'>";
    innerHTMl = innerHTMl + "" + XmlSchemaElementDataType + ": ";
    innerHTMl = innerHTMl + "</td>";
    innerHTMl = innerHTMl + "<td class=\"contenttext\">";
    innerHTMl = innerHTMl + "<select id=\"cmbnodedatatype\" class=\"contenttext\">";

    var DatatypeArr = dataTypes.split(",");
    var displayDatatypeArr = displayDataTypes.split(",");
    for (var i = 0; i < DatatypeArr.length; i++) {
        if (nodeDataType == DatatypeArr[i])
            innerHTMl = innerHTMl + "<option value='" + DatatypeArr[i] + "' selected>" + displayDatatypeArr[i] + "</option>";
        else
            innerHTMl = innerHTMl + "<option value='" + DatatypeArr[i] + "'>" + displayDatatypeArr[i] + "</option>";
    }
    innerHTMl = innerHTMl + "</select>";
    innerHTMl = innerHTMl + "</td>";
    innerHTMl = innerHTMl + "</tr>";
    innerHTMl = innerHTMl + " <tr>";
    innerHTMl = innerHTMl + "<td class=\"contenttext\" align='center'>";
    innerHTMl = innerHTMl + "" + XmlSchemaElementRepeat + ":";
    innerHTMl = innerHTMl + "</td>";
    innerHTMl = innerHTMl + "<td class=\"contenttext\">";

    if (IsRepeating == true)
        innerHTMl = innerHTMl + " <input type=\"checkbox\" id=\"chkRepeating\" checked />";
    else
        innerHTMl = innerHTMl + " <input type=\"checkbox\" id=\"chkRepeating\" />";

    innerHTMl = innerHTMl + "</td>";
    innerHTMl = innerHTMl + "</tr>";
    if (bcode == 1) {
        innerHTMl = innerHTMl + " <tr>";
        innerHTMl = innerHTMl + "<td colspan=\"2\"><img src=\"Images/Spacer.gif\" border=\"0\" height=\"8\"></td>";
        innerHTMl = innerHTMl + "</tr>";
    } innerHTMl = innerHTMl + "<tr>";
    innerHTMl = innerHTMl + "<td colspan=2 width=100% >";
    innerHTMl = innerHTMl + "<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">";
    innerHTMl = innerHTMl + "<tr>";
    innerHTMl = innerHTMl + "<td width=\"100%\"   id=\"Td2\" align=\"right\">";
    innerHTMl = innerHTMl + "<input type=\"button\" id=\"btnCancel\" name=\"btnCancel\" value=\"" + XmlSchemaCancel + "\" onClick=\"CloseDiv();\" class=\"inputsecondarybutton\">&nbsp;";
    innerHTMl = innerHTMl + "<input type=\"button\" id=\"btnOk\" name=\"btnOk\" value=\"&nbsp;&nbsp;" + XmlSchemaOK + "&nbsp;&nbsp;\" onClick=\"javascript:CreateNode('" + mode + "');\" class=\"inputbutton\">&nbsp;";
    innerHTMl = innerHTMl + "</td>";
    innerHTMl = innerHTMl + "</tr>";
    innerHTMl = innerHTMl + "</table>";
    innerHTMl = innerHTMl + "</td>";
    innerHTMl = innerHTMl + "</tr>";
    innerHTMl = innerHTMl + "</table>";
    innerHTMl = innerHTMl + "</td>";
    innerHTMl = innerHTMl + "</tr>";
    innerHTMl = innerHTMl + "</table>";
    var proprObj = document.getElementById("PropertyDiv");
    proprObj.innerHTML = innerHTMl;
    proprObj.style.position = "absolute";
    proprObj.style.visibility = "visible";
    proprObj.style.display = "block";
    proprObj.style.left = 250 + 'px';
    proprObj.style.top = 5 + 'px';
    proprObj.style.width = 300 + 'px';
    document.getElementById("txtNodeText").focus();
    document.getElementById("txtNodeText").focus();
    document.getElementById("txtNodeText").focus();
}

function setFocus()
{
   
}

function CloseDiv()	
{
    var proprObj =document.getElementById("PropertyDiv"); 
    proprObj.style.display="none";
}
	
function MenuHTML(nodeType)
{
    var innerHTMl="";
    
    innerHTMl ="<table summary=\"menu root group\" class=\"MenuGroup\" cellpadding=\"0\" cellspacing=\"0\" style=\"width:0px;height:0px;\">";
	
	//Add
	
	innerHTMl =innerHTMl +"<tr>";
	innerHTMl =innerHTMl +"<td><table id=\"Menu1_0\" width=100% cellpadding=\"0\" cellspacing=\"0\" border=0 summary=\"menu root group\">";
    innerHTMl =innerHTMl +"<tr>";
	innerHTMl =innerHTMl +"<td align=\"left\" style=\"width:5px;\">&#160;</td>";
	
	if((nodeType=="element")||(nodeType=="rootnode"))
	{
	innerHTMl =innerHTMl +"<td style=\"white-space:nowrap;\" class=\"MenuItem\"><a href=\"#\" onclick=\"TreeClick('ADD')\" class=\"hyperText1\" onmouseover=\"ChangemenuItemClass('Menu1_0','"+nodeType+"')\">"+MenuAddString+"</a></td>";
	}
	else
	{
	innerHTMl =innerHTMl +"<td style=\"white-space:nowrap;\" class=\"MenuItem\"><a href=\"#\" disabled class=\"hyperText1\" onmouseover=\"ChangemenuItemClass('Menu1_0','"+nodeType+"')\">"+MenuAddString+"</a></td>";
	}
	
	innerHTMl =innerHTMl +"<td align=\"right\" style=\"width:5px;\">&#160;</td>";
	innerHTMl =innerHTMl +"</tr>";
	innerHTMl =innerHTMl +"</table>";
	innerHTMl =innerHTMl +"</td>";
	innerHTMl =innerHTMl +"</tr>";
	
	//Edit
	
	innerHTMl =innerHTMl +"<tr>";
	innerHTMl =innerHTMl +"<td><table id=\"Menu1_1\" width=100% cellpadding=\"0\" cellspacing=\"0\" border=0 summary=\"menu root group\">";
    innerHTMl =innerHTMl +"<tr>";
	innerHTMl =innerHTMl +"<td align=\"left\" style=\"width:5px;\">&#160;</td>";
	
	
	innerHTMl =innerHTMl +"<td style=\"white-space:nowrap;\" class=\"MenuItem\"><a href=\"#\" onclick=\"TreeClick('Edit')\" class=\"hyperText1\" onmouseover=\"ChangemenuItemClass('Menu1_1','"+nodeType+"')\">"+MenuEditString+"</a></td>";
	
	innerHTMl =innerHTMl +"<td align=\"right\" style=\"width:5px;\">&#160;</td>";
	innerHTMl =innerHTMl +"</tr>";
	innerHTMl =innerHTMl +"</table>";
	innerHTMl =innerHTMl +"</td>";
	innerHTMl =innerHTMl +"</tr>";
	//Delete
	innerHTMl =innerHTMl +"<tr>";
	innerHTMl =innerHTMl +"<td><table id=\"Menu1_2\" width=100% class=\"MenuItem\" cellpadding=\"0\" cellspacing=\"0\" summary=\"menu root group\">";
	innerHTMl =innerHTMl +"<tr>";
	innerHTMl =innerHTMl +"<td align=\"left\" style=\"width:5px;\">&#160;</td>";
	innerHTMl =innerHTMl +"<td style=\"white-space:nowrap;\"><a href=\"#\" onclick=\"TreeClick('Delete')\" class=\"hyperText1\" onmouseover=\"ChangemenuItemClass('Menu1_2','"+nodeType+"')\">"+MenuDeleteString+"</a></td>";
	innerHTMl =innerHTMl +"<td align=\"right\" style=\"width:5px;\">&#160;</td>";
	innerHTMl =innerHTMl +"</tr>";
	innerHTMl =innerHTMl +"</table>";
	innerHTMl =innerHTMl +"</td>";
	innerHTMl =innerHTMl +"</tr>";
	
	
    innerHTMl =innerHTMl +"</table>";

    return  innerHTMl;
}	

function GetSubMenuHTML()
{
      var innerHTMl="";
      var clickedNode = document.getElementById("HiddennodeId").value;
      var datatype = GetNodeDataType(objTree.root,clickedNode);
      
      innerHTMl= innerHTMl+"<table summary=\"menu root group\" class=\"MenuGroup\" cellpadding=\"0\" cellspacing=\"0\" width=\"70px\">";
	 
	  innerHTMl= innerHTMl+"<tr>";
	  innerHTMl= innerHTMl+"<td width=100%><table id=\"Menu4_0\"  border=0 width=100%  cellpadding=\"0\" cellspacing=\"0\" summary=\"menu root group\" >";
	 
	  innerHTMl= innerHTMl+"<tr>";
	  innerHTMl= innerHTMl+"<td width=100% class=\"MenuItem\">";
	  
	  if(datatype=="string")
	    innerHTMl= innerHTMl+"<div id=\"submenudivstring\">&nbsp;<img src=\"images/tick-icon.gif\" id=\"img1\"  border=0/>&nbsp;<a href=\"#\" onclick=\"AssignDataType('string','Menu4_0')\" class=\"hyperText1\" onmouseover=\"ChangeSubmenuItemClass('Menu4_0')\">string</a></div>";
	  else
	    innerHTMl= innerHTMl+"<div id=\"submenudivstring\">&nbsp;&nbsp;<a href=\"#\" onclick=\"AssignDataType('string','Menu4_0')\" class=\"hyperText1\" onmouseover=\"ChangeSubmenuItemClass('Menu4_0')\">string</a></div>";
	  
	  innerHTMl= innerHTMl+"</td>";
	  innerHTMl= innerHTMl+"</tr>";
	  innerHTMl= innerHTMl+"</table>";
	  innerHTMl= innerHTMl+"</td>";
	  innerHTMl= innerHTMl+"</tr>";
	  
	  innerHTMl= innerHTMl+"<tr>";
	  innerHTMl= innerHTMl+"<td width=100%><table id=\"Menu4_1\"  border=0 width=100%  cellpadding=\"0\" cellspacing=\"0\" summary=\"menu root group\">";
	  innerHTMl= innerHTMl+"<tr>";
	  innerHTMl= innerHTMl+"<td width=100% class=\"MenuItem\">";
	  
	  if(datatype=="integer")
	    innerHTMl= innerHTMl+"<div id=\"submenudivinteger\">&nbsp;<img src=\"images/tick-icon.gif\" id=\"img1\"  border=0/>&nbsp;<a href=\"#\" onclick=\"AssignDataType('integer','Menu4_1')\" class=\"hyperText1\" onmouseover=\"ChangeSubmenuItemClass('Menu4_1')\">integer</a></div>";
	  else
	    innerHTMl= innerHTMl+"<div id=\"submenudivinteger\">&nbsp;&nbsp;<a href=\"#\" onclick=\"AssignDataType('integer','Menu4_1')\" class=\"hyperText1\" onmouseover=\"ChangeSubmenuItemClass('Menu4_1')\">integer</a></div>";
	    
	  innerHTMl= innerHTMl+"</td>";
	  innerHTMl= innerHTMl+"</tr>";
	  
	  innerHTMl= innerHTMl+"</table>";
	  innerHTMl= innerHTMl+"</td>";
	  innerHTMl= innerHTMl+"</tr>";
	  
	 
	  innerHTMl= innerHTMl+"<tr>";
	  innerHTMl= innerHTMl+"<td width=100%><table id=\"Menu4_3\"  border=0 width=100%  cellpadding=\"0\" cellspacing=\"0\" summary=\"menu root group\">";
	  innerHTMl= innerHTMl+"<tr>";
	  innerHTMl= innerHTMl+"<td width=100% class=\"MenuItem\">";
	  
	  if(datatype=="boolean")
	    innerHTMl= innerHTMl+"<div id=\"submenudivboolean\">&nbsp;<img src=\"images/tick-icon.gif\" id=\"img1\"  border=0/>&nbsp;<a href=\"#\" onclick=\"AssignDataType('boolean','Menu4_3')\" class=\"hyperText1\" onmouseover=\"ChangeSubmenuItemClass('Menu4_3')\">boolean</a></div>";
	  else
	     innerHTMl= innerHTMl+"<div id=\"submenudivboolean\">&nbsp;&nbsp;<a href=\"#\" onclick=\"AssignDataType('boolean','Menu4_3')\" class=\"hyperText1\" onmouseover=\"ChangeSubmenuItemClass('Menu4_3')\">boolean</a></div>";
	      
	  innerHTMl= innerHTMl+"</td>";
	  innerHTMl= innerHTMl+"</tr>";
	  innerHTMl= innerHTMl+"</table>";
	  innerHTMl= innerHTMl+"</td>";
	  innerHTMl= innerHTMl+"</tr>";
	  
	  innerHTMl= innerHTMl+"<tr>";
	  innerHTMl= innerHTMl+"<td width=100%><table id=\"Menu4_2\"  border=0 width=100%  cellpadding=\"0\" cellspacing=\"0\" summary=\"menu root group\">";
	  innerHTMl= innerHTMl+"<tr>";
	  innerHTMl= innerHTMl+"<td width=100% class=\"MenuItem\">";
	  
	  if(datatype=="date")
	    innerHTMl= innerHTMl+"<div id=\"submenudivdate\">&nbsp;<img src=\"images/tick-icon.gif\" id=\"img1\"  border=0/>&nbsp;<a href=\"#\" onclick=\"AssignDataType('date','Menu4_2')\" class=\"hyperText1\" onmouseover=\"ChangeSubmenuItemClass('Menu4_2')\">date</a></div>";
	  else
	     innerHTMl= innerHTMl+"<div id=\"submenudivdate\">&nbsp;&nbsp;<a href=\"#\" onclick=\"AssignDataType('date','Menu4_2')\" class=\"hyperText1\" onmouseover=\"ChangeSubmenuItemClass('Menu4_2')\">date</a></div>";
	      
	  innerHTMl= innerHTMl+"</td>";
	  innerHTMl= innerHTMl+"</tr>";
	  innerHTMl= innerHTMl+"</table>";
	  innerHTMl= innerHTMl+"</td>";
	  innerHTMl= innerHTMl+"</tr>";
	 
	 
	  innerHTMl= innerHTMl+"</table>";
      return innerHTMl;      
 }


function AssignDataType(dataType,menuItem)
{
    
    var divObj1  =  document.getElementById("submenudivstring");
    divObj1.innerHTML="&nbsp;&nbsp;<a href=\"#\" onclick=\"AssignDataType('string','Menu4_0')\" class=\"hyperText1\" onmouseover=\"ChangeSubmenuItemClass('Menu4_0')\">string</a>";
    
    var divObj2  =  document.getElementById("submenudivinteger");
    divObj2.innerHTML="&nbsp;&nbsp;<a href=\"#\" onclick=\"AssignDataType('integer','Menu4_1')\" class=\"hyperText1\" onmouseover=\"ChangeSubmenuItemClass('Menu4_1')\">integer</a>";
    
    var divObj3  =  document.getElementById("submenudivdate");
    divObj3.innerHTML="&nbsp;&nbsp;<a href=\"#\" onclick=\"AssignDataType('date','Menu4_2')\" class=\"hyperText1\" onmouseover=\"ChangeSubmenuItemClass('Menu4_2')\">date</a>";
    
    
    var divObj4  =  document.getElementById("submenudivboolean");
    divObj4.innerHTML="&nbsp;&nbsp;<a href=\"#\" onclick=\"AssignDataType('boolean','Menu4_3')\" class=\"hyperText1\" onmouseover=\"ChangeSubmenuItemClass('Menu4_3')\">boolean</a>";
    
    
    var divObj  =  document.getElementById("submenudiv"+dataType);
    var inHtml = "&nbsp;<img src=\"images/tick-icon.gif\" id=\"img1\"  border=0/>&nbsp;<a href=\"#\" onclick=\"AssignDataType('"+dataType+"','"+menuItem+"')\" class=\"hyperText1\" onmouseover=\"ChangeSubmenuItemClass('"+menuItem+"')\">"+dataType+"</a>";
    divObj.innerHTML=inHtml;    
    
    var clickedNode = document.getElementById("HiddennodeId").value;
        
    AssignDataTypefortheNode(objTree.root,clickedNode,dataType);
    
    ClearMenu();    
}


function GetNodeDataType(node,nodeName)
{
    for(var i=0; i < node.childNodes.length;i++)
    {
        if(node.childNodes[i]!=null)
        {
            if(node.childNodes[i].id==nodeName)
            {
                datatype = node.childNodes[i].DataType;
                break;
            }
            else
            {
              GetNodeDataType(node.childNodes[i],nodeName);        		            
            }
        }
    }
    return datatype;	
}

function AssignDataTypefortheNode(node,nodeName,dataType)
{
    for(var i=0; i < node.childNodes.length;i++)
    {
        if(node.childNodes[i]!=null)
        {
            if(node.childNodes[i].id==nodeName)
            {
                node.childNodes[i].DataType =dataType; ;
            }
            else
            {
              AssignDataTypefortheNode(node.childNodes[i],nodeName,dataType);        		            
            }
        }
    }	
}
	
		
function Delete(nodeID)
{
    DeleteNode(objTree.root,nodeID);
    BuildTree();
    ClearMenu();
}	

function BuildTree()
{
    document.getElementById("xmlTreeDiv").innerHTML = "";
    objTree.buildDOM();
    var strInnerHTML = document.getElementById("xmlTreeDiv").innerHTML;
	document.getElementById("xmlTreeDiv").innerHTML = strInnerHTML.replace("<DIV><DIV>","");
}	
		
function DeleteNode(node,nodeId)
{
   if(nodeId=="root")
   {
        var childNodes=new Array();
        objTree.root.childNodes = childNodes; 
        textChange("root","root","node","",null); 
   }  

    for(var i=0; i < node.childNodes.length;i++)
    {
        if(node.childNodes[i]!=null)
        {
            if(node.childNodes[i].id==nodeId)
            {
                var childNodes=new Array();
                node.childNodes[i] = null;
            }
            else
            {
              DeleteNode(node.childNodes[i],nodeId);        		            
            }
        }
    }		
}
	
function textChange(nodeID,newValue,type,parent,ctrl)
{
    if(nodeID=="root")
    {
        if(objTree!=null)
        {
            var isValid = CheckInputValue(trim(newValue));
            if(isValid)
            {
                objTree.root.text=newValue;
            }
            else
            {
                if(ctrl!=null)
                       ctrl.value =  node.childNodes[i].text;
            }
        }
    }
    else
    {
        changeText(objTree.root,newValue,nodeID,ctrl);
    }
}

function changeText(node,nodeValue,nodeID,ctrl)
{
     for(var i=0; i < node.childNodes.length;i++)
        {
           if(node.childNodes[i]!=null)
           {
                if(node.childNodes[i].id==nodeID)
                {
                    var isValid = CheckInputValue(trim(nodeValue));
                    if(isValid)
                    {
                        node.childNodes[i].text = nodeValue;
                    }
                    else
                    {
                        if(ctrl!=null)
                           ctrl.value =  node.childNodes[i].text;
                    }   
                }
                else
                {
                  changeText(node.childNodes[i],nodeValue,nodeID,ctrl);        		            
                }
           }
        }		
    if( node.childNodes!=null)
    {
        if( node.childNodes.length==0)
        {
            if(node.id==nodeID)
            {
                    var isValid = CheckInputValue(trim(nodeValue));
                    if(isValid)
                    {
                        node.text = nodeValue;
                    }
                    else
                    {
                        if(ctrl!=null)
                           ctrl.value =  node.childNodes[i].text;
                    }   
            }
        }
    }

}


function OpenMenu(nodeId,obj,parentNodeId,nodeType)
{
   var x = findPosX(obj);
    var y = findPosY(obj);
    MenuDivObj = document.getElementById("MenuDiv");
    
    
    
    MenuDivObj.style.left = (parseInt(x)+10) + 'px';
    
    var scrollTop = document.getElementById("xmlTreeDiv").scrollTop;
    
    y = parseInt(y - scrollTop);
    
    
    if((document.body.offsetHeight)-(y)<70)
    {
        y = y - 70;
    }
    
    MenuDivObj.style.top = (parseInt(y)+ 8 ) + 'px';
    MenuDivObj.style.position="absolute";
    MenuDivObj.style.visibility="visible";
    MenuDivObj.style.display="block";
    MenuDivObj.innerHTML = MenuHTML(nodeType);
           
    imgClicked=1;
    document.getElementById("HiddennodeId").value = nodeId;
    document.getElementById("HiddenParentnodeId").value = parentNodeId;
   
}

function ClearMenu()
{
    MenuDivObj.style.display="none";  
    menuOpened=0;
    document.getElementById("Menu1_0").style.backgroundColor="white";
    document.getElementById("Menu1_1").style.backgroundColor="white";
    document.getElementById("Menu1_2").style.backgroundColor="white";
}

function windowmouseclickhandler(e)
{
if( !e ) e=event;

if((menuOpened==1))
{
    MenuDivObj.style.display="none";  
    menuOpened=0;
    document.getElementById("Menu1_0").style.backgroundColor="white";
    document.getElementById("Menu1_1").style.backgroundColor="white";
    document.getElementById("Menu1_2").style.backgroundColor="white";
}
if(imgClicked==0)
{
    MenuDivObj.style.display="none";   
    menuOpened=0;
    if(document.getElementById("Menu1_0")!=null)
    {
        document.getElementById("Menu1_0").style.backgroundColor="white";
        document.getElementById("Menu1_1").style.backgroundColor="white";
        document.getElementById("Menu1_2").style.backgroundColor="white";
    }
}	

        
}

function windowmousemovehandler(e)
{
if( !e ) e=event;

imgClicked = 0;
}

function ChangemenuItemClass(menuItem,nodeType)
{
document.getElementById("Menu1_0").style.backgroundColor="white";
document.getElementById("Menu1_1").style.backgroundColor="white";
document.getElementById("Menu1_2").style.backgroundColor="white";
menuItemObj =document.getElementById(menuItem);
menuItemObj.style.backgroundColor="#cccccc";
}

function ChangeSubmenuItemClass(menuItem)
{
document.getElementById("Menu4_0").style.backgroundColor="white";
document.getElementById("Menu4_1").style.backgroundColor="white";
document.getElementById("Menu4_2").style.backgroundColor="white";
document.getElementById("Menu4_3").style.backgroundColor="white";
submenuItemObj =document.getElementById(menuItem);
submenuItemObj.style.backgroundColor="#cccccc";
}

function Initialize()
{

    MenuDivObj = document.getElementById('MenuDiv');
    MenuDivObj.style.display="none";
    
    MenuSubDivObj = document.getElementById('MenuSubDiv');
    MenuSubDivObj.style.display="none";
 	
}

function GetBrowserversion()
{
	var app=navigator.userAgent;
	if(app.indexOf("MSIE")>-1)
	{
		return 1;	
	}
	else if(app.indexOf("Firefox/1.5")>-1)
	{
		return 2;	
	}
	else
	{
	    return 3;
	}
}


function InitializeElements()
{
    var browserCode = GetBrowserversion();
    
    if(browserCode==1)
        document.getElementById("variablesList").style.height=120;
    
    var oOption = document.getElementById("cboProvider");
    var selectIndex=0;
    
    for(var i=0;i<oOption.options.length;i++)
    {
        var optvale =  oOption.options[i].value;
        if(optvale=="XmlDocument")
        {
            selectIndex = i;    
        }
    }
    
    document.getElementById("cboProvider").selectedIndex=selectIndex;
    ChangeStorageSrc(document.getElementById("cboProvider"));
    
}
//*********************************************************

function SchemaEditor(ID)
{
    this.ID =ID;
    this.XmlString="";
}

SchemaEditor.prototype.LoadSchema = function()
{
    //create the xml tree structure
  /* if(this.XmlString=="")
   {
      	objTree.createRoot("Images/Condition.gif","Root", "","node","rootnode"); 
		objTree.buildDOM();
		var strInnerHTML = document.getElementById("xmlTreeDiv").innerHTML;
		document.getElementById("xmlTreeDiv").innerHTML = strInnerHTML.replace("<DIV><DIV>","");      
   } */
}

SchemaEditor.prototype.GetXML = function()
{
    var returnXSD="";
    var mainNode =objTree.root;
    
    returnXSD = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
    returnXSD = returnXSD+"<xs:schema attributeFormDefault=\"unqualified\" elementFormDefault=\"qualified\" xmlns:xs=\"http://www.w3.org/2001/XMLSchema\">";
        returnXSD = returnXSD+"<xs:element name=\""+mainNode.text+"\">";
         returnXSD = returnXSD+"<xs:complexType>";
         returnXSD = returnXSD+ "<xs:sequence>";
         returnXSD = returnXSD+ GenerateXSD(objTree.root);
         returnXSD = returnXSD+ "</xs:sequence>";
         returnXSD = returnXSD+"</xs:complexType>";   
        returnXSD = returnXSD+"</xs:element>";
    returnXSD = returnXSD+"</xs:schema>";
    return returnXSD;
}

function GenerateXSD(node)
{
    
    for(var i=0;i<node.childNodes.length;i++)
    {
       xsdstring = BuildXSD(node.childNodes[i]); 
    }
    return xsdstring;        
}

function BuildXSD(node)
{
    xsdstring = xsdstring + "<xs:element name=\""+node.text+"\">";
    xsdstring = xsdstring+ "<xs:complexType>";
    xsdstring = xsdstring+ "<xs:sequence>";
    
    for(var i=0;i<node.childNodes.length;i++)
    {
        if(node.childNodes[i]!=null)
        {
            if(node.childNodes[i].type=="element")
            {
                if(node.childNodes[i].childNodes!=null)
                {
                    if(node.childNodes[i].childNodes.length==0)
                    {
                        xsdstring = xsdstring+ "<xs:element name=\""+node.childNodes[i].text+"\" type=\"xs:"+node.childNodes[i].DataType+"\"/>";
                    }
                }
                
                if(node.childNodes[i].childNodes!=null)
                { 
                    if(node.childNodes[i].childNodes.length>0)
                    {
                        BuildXSD(node.childNodes[i]);   
                    }
                }
            }
        }    
    }
    
    xsdstring = xsdstring+ "</xs:sequence>";
    
    for(var i=0;i<node.childNodes.length;i++)
    {
        if(node.childNodes[i]!=null)
        {
            if(node.childNodes[i].type=="attribute")
            {
               xsdstring = xsdstring+ "<xs:attribute name=\""+node.childNodes[i].text+"\" type=\"xs:"+node.childNodes[i].DataType+"\" use=\"required\"/>";
            }
        }    
    }
    xsdstring = xsdstring+"</xs:complexType>"; 
    xsdstring = xsdstring+"</xs:element>";   
    
    return xsdstring;
}


function LoadSchemaFromFile()
{
    document.getElementById('hidcheck').value = '1';
    var xFile="";
	xFile = document.getElementById("XMLFile").value;
	var isValid=true;
			
	if(Trim(xFile)!="")
	{   
		if(xFile.indexOf('.')>0)
		{
			
			var fileName = Trim(xFile);
	        fileName = fileName.substring(fileName.lastIndexOf('.')+1,fileName.length);
	    
	        if((fileName.toLowerCase()=="xml")||(fileName.toLowerCase()=="xsd"))
			{
			}
			else
			{
				alert(FileUploadMsg);
				isValid=false;
			}
		}
		else
		{
			alert(FileUploadMsg);
			isValid=false;
		}
	}
	else
		{
			alert(FileUploadMsg);
			isValid=false;
		}
	if(isValid==true)
	{
        document.forms[0].encoding="multipart/form-data";
        document.forms[0].submit();
    }
}

//***********************************************************
function findPosX(obj)
{
var curleft = 0;

if (obj.offsetParent)
{
    while (obj.offsetParent)
    {
      curleft += obj.offsetLeft
      obj = obj.offsetParent;
    }
}

else if (obj.x)
curleft += obj.x;

return curleft;
}

function findPosY(obj)
{
var curtop = 0;
if (obj.offsetParent)
{
while (obj.offsetParent)
{
  curtop += obj.offsetTop
  obj = obj.offsetParent;
}
}
else if (obj.y)
curtop += obj.y;
return curtop;
}    
//Common Functions
function ltrim ( s )
{
return s.replace( /^\s*/, "" );
}

function rtrim ( s )
{
	return s.replace( /\s*$/, "" );
}

function trim ( s )
{
	return rtrim(ltrim(s));
}

// Removes leading and trailing spaces from the passed string. Also removes
	// consecutive spaces and replaces it with one space. If something besides
	// a string is passed in (null, custom object, etc.) then return the input.
	function Trim(inputString) 
	{
		if (typeof inputString != "string") { return inputString; }
		var retValue = inputString;
		var ch = retValue.substring(0, 1);
		while (ch == " ") { // Check for spaces at the beginning of the string
			retValue = retValue.substring(1, retValue.length);
			ch = retValue.substring(0, 1);
		}
		ch = retValue.substring(retValue.length-1, retValue.length);
		while (ch == " ") { // Check for spaces at the end of the string
			retValue = retValue.substring(0, retValue.length-1);
			ch = retValue.substring(retValue.length-1, retValue.length);
		}

		return retValue; // Return the trimmed string back to the user
	} // Ends the "tr



function SelectRow(rowID,variableName,variableType,variableDesc,loadDefinition,variableScope)
{
    
    document.getElementById("variableName").readOnly=true;
    if(prevRow!=rowID)
    {
        var tdprevvarNameObject = document.getElementById("tdVarName"+prevRow);
        var tdprevStorageTypeObject = document.getElementById("tdStorageType"+prevRow);
        var tdprevVarDetails = document.getElementById("tdVarDetails"+prevRow);

        if(tdprevvarNameObject!=null)
        {   
            tdprevvarNameObject.className = "GridRowStyle";
            tdprevStorageTypeObject.className = "GridRowStyle";
            tdprevVarDetails.className = "GridRowStyle";
        /*     
            tdprevvarNameObject.style.backgroundColor = "#ffffff";
            tdprevStorageTypeObject.style.backgroundColor = "#ffffff";
            tdprevVarDetails.style.backgroundColor = "#ffffff";
            */
          //  document.getElementById("tdnbspfirst"+prevRow).style.backgroundColor = "#ffffff";
           // document.getElementById("tdnbspsecond"+prevRow).style.backgroundColor = "#ffffff";
          //  document.getElementById("tdnbspthird"+prevRow).style.backgroundColor = "#ffffff";
           // document.getElementById("tdnbspfour"+prevRow).style.backgroundColor = "#ffffff";
            
        }
        prevRow = rowID;
    }
    
    var tdvarNameObject = document.getElementById("tdVarName"+rowID);
    
    var tdStorageTypeObject = document.getElementById("tdStorageType"+rowID);
    var tdVarDetails = document.getElementById("tdVarDetails"+rowID);
    
    if(tdvarNameObject!=null)
    {
    
        tdvarNameObject.className = "GridSelectedRowStyle";
        tdStorageTypeObject.className = "GridSelectedRowStyle";
        tdVarDetails.className = "GridSelectedRowStyle";
        
    /*
        tdvarNameObject.style.backgroundColor = "#ece9d8";
        tdStorageTypeObject.style.backgroundColor = "#ece9d8";
        tdVarDetails.style.backgroundColor = "#ece9d8";
        */
        //document.getElementById("tdnbspfirst"+rowID).style.backgroundColor = "#ece9d8";
        //document.getElementById("tdnbspsecond"+rowID).style.backgroundColor = "#ece9d8";
       // document.getElementById("tdnbspthird"+rowID).style.backgroundColor = "#ece9d8";
        //document.getElementById("tdnbspfour"+rowID).style.backgroundColor = "#ece9d8";
    }
    
    selectedvaraiable = variableName;
    selectedvaraiableDesc = variableDesc;
    selectedvaraiableType=variableType;
    
    if(selectedvaraiableType=="")
        selectedvaraiableType="XmlDocument";
    
    document.getElementById("cboProvider").value = selectedvaraiableType; 
    
    document.getElementById("HdnModeEdit").value="Edit";
    
    document.getElementById("variableName").value= variableName;
    document.getElementById("VarDescription").value= variableDesc;
    
    //if(loadDefinition)
    //{
        FillDefinition(variableName,variableType,variableScope);
        //top.frames[0].location.reload(false);
    //}
}

function  FillDefinition(variableName,variableType,variableScope)
{
 //debugger;
 var variablescopeCmb =  document.getElementById("variablescope");
 
 for(var i=0; i<variablescopeCmb.options.length;i++)
 {
    if( variablescopeCmb.options[i].value==variableScope)
    {
        variablescopeCmb.selectedIndex = i;
        break;
    }
 }

  var cmb = document.getElementById("cboProvider"); 
  if(cmb.options.length>0)
  {
      var frameSrc = Iframesrc;
      if(variableType!="")
      {
        if(variableType == "XmlDocument" || variableType == "XmlFormLibrary")
        {
         if(variableType=="XmlDocument")
         {
             frameSrc = frameSrc.replace("XmlIterator.aspx","XmlStorage.aspx")
             nnerHTMl = "XmlDocument";
         }
         else if(variableType=="XmlFormLibrary")
            {
            frameSrc = frameSrc.replace("XmlStorage.aspx","XmlInfoPath.aspx");
            nnerHTMl = "XmlFormLibrary";
            }
        }
      
        else
        {
//       if(variableType=="XmlIterator")
//      {
            frameSrc = frameSrc.replace("XmlStorage.aspx",variableType+".aspx");
            nnerHTMl = variableType;
//      }   
//      else if(variableType=="XmlSPList")
//      {
//        frameSrc = frameSrc.replace("XmlStorage.aspx","XmlSpList.aspx");
//        nnerHTMl = "XmlSPList";
//      }    
        }
       }  
     
      if(trim(variableName )!="")
            frameSrc = frameSrc+"&variablename="+variableName;
      
      //document.getElementById("Xml_frame").src = frameSrc; 
      //top.frames[0].location.reload(false); 
      
      parent.frames[0].location.href=frameSrc;//+"&variablename="+variableName;

  }
} 


function CallServerForXMLVariable()
{
    //CallServerSideMethod(null, 'LoadElements',"DataTableTest",CallbackLoadElements,'table',"Sample");
}

function CallbackLoadElements(context, result, response)
{
   //alert('Hi');
}
function AddNewVariable()
{
    document.getElementById("variableName").value="";
    document.getElementById("variableName").readOnly=false;
    document.getElementById("variableName").focus();
    document.getElementById("VarDescription").value="";
    InitializeElements();
    FillDefinition("",'XmlDocument');
    document.getElementById("HdnModeEdit").value="ADD";
}

function HandleBubbleWindow(rowID,divObj)
{
    var x =findPosX(divObj);
    var y =findPosY(divObj);
    bubbleWindowObj = document.getElementById("bubbleWindow");
    //if(forcheck==1) debugger;
    bubbleWindowObj.style.left = parseInt(x)- 240 + 'px';
    bubbleWindowObj.style.top  = parseInt(y)+30 + 'px';   	
    bubbleWindowObj.style.visibility="visible";
    bubbleWindowObj.style.display="block";
    bubbleWindowObj.style.position="absolute";	
    var bubbleHTML = HtmlDecode("<xsd:schema xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns=\"generic\" elementFormDefault=\"qualified\" targetNamespace=\"generic\"><xsd:element name=\"bookstore\" type=\"bookstoreType\"/>  <xsd:complexType name=\"bookstoreType\"> <xsd:sequence maxOccurs=\"unbounded\"> <xsd:element name=\"book\" type=\"bookType\"/> </xsd:sequence> </xsd:complexType> <xsd:complexType name=\"bookType\">  <xsd:sequence> <xsd:element name=\"title\" type=\"xsd:string\"/> <xsd:element name=\"author\" type=\"authorName\"/> <xsd:element name=\"price\" type=\"xsd:decimal\"/>  </xsd:sequence> 	<xsd:attribute name=\"genre\" type=\"xsd:string\"/>  </xsd:complexType> <xsd:complexType name=\"authorName\"> <xsd:sequence> <xsd:element name=\"first-name\" type=\"xsd:string\"/> <xsd:element name=\"last-name\" type=\"xsd:string\"/> </xsd:sequence> </xsd:complexType></xsd:schema>");
    bubbleWindowObj.innerText = bubbleHTML;
}

function HideBubbleWindow(rowID)
{
     bubbleWindowObj.style.display="none";

}


function findPosX(obj)
{
var curleft = 0;

if (obj.offsetParent)
{
    while (obj.offsetParent)
    {
      curleft += obj.offsetLeft
      obj = obj.offsetParent;
    }
}

else if (obj.x)
curleft += obj.x;

return curleft;
}
function findPosY(obj)
{
var curtop = 0;
if (obj.offsetParent)
{
while (obj.offsetParent)
{
  curtop += obj.offsetTop
  obj = obj.offsetParent;
}
}
else if (obj.y)
curtop += obj.y;
return curtop;
}

function CheckInputValue(nodetext)
{
      var retValue= true;  
      
      var l = nodetext.length;   
      
      for (var i=0; i<l; i++) 
      { 
        var ch = nodetext.charAt(i); 

        if(i==0)
        {
            var asciiValue =  ch.charCodeAt(0);
            if( ((asciiValue>64)&&(asciiValue<91)) ||((asciiValue>96)&&(asciiValue<123)))
            {
            }
            else
            {
                alert('XML node name must begin with letters');
                retValue=false;
                break;
            }
        }
        else
        {   
            var errFlag=0;  
            switch(trim(ch))
            {
                case "":
                    alert('XML node name should not contain spaces');
                    errFlag=2;
                    retValue=false;
                    break;

                case"$":
                    errFlag=1;
                    break;
                
                case"%":
                    errFlag=1;
                    break;    
                
                case"&":
                    errFlag=1;
                    break;        
                 
                 case"+":
                    errFlag=1;
                    break;           
                
                case";":
                    errFlag=1;
                    break;           
               
                case"?":
                    errFlag=1;
                    break;                   
                
                case"<":
                    errFlag=1;
                    break;               
                    
                case">":
                    errFlag=1;
                    break;   
                 
                 case"/":
                    errFlag=1;
                    break;                      
                 
                 case "@":
                    errFlag=1;
                    break;
            
                case "#":
                    errFlag=1;
                    break;
               break;                      
                 
               case "^":
                    errFlag=1;
                    break;
              
              case "*":
                    errFlag=1;
                    break;   
              
              case "(":
                    errFlag=1;
                    break;
              
              case ")":
                    errFlag=1;
                    break;      
                    
               case "}":
                    errFlag=1;
                    break;
              
              case "{":
                    errFlag=1;
                    break;                  
                    
            }   
            
            if(errFlag==1)
            {
                alert('XML node name should not contain invalid characters');
                retValue=false;
                break;
            }
            else  if(errFlag==2)
            {
                retValue=false;
                break;
            }
      }
   }
  return retValue;
}


function HtmlDecode(s) 
	{ 
      var out = ""; 
      if (s==null) return; 
      var l = s.length; 
      for (var i=0; i<l; i++) 
      { 
            var ch = s.charAt(i); 
            if (ch == '&') 
            { 
                  var semicolonIndex = s.indexOf(';', i+1); 
            if (semicolonIndex > 0) 
            { 
                        var entity = s.substring(i + 1, semicolonIndex); 
                        if (entity.length > 1 && entity.charAt(0) == '#') 
                        { 
                              if (entity.charAt(1) == 'x' || entity.charAt(1) == 'X') 
                                    ch = String.fromCharCode(eval('0'+entity.substring(1))); 
                              else 
                                    ch = String.fromCharCode(eval(entity.substring(1))); 
                        } 
                    else 
                      { 
                              switch (entity) 
                              { 
                                    case 'quot': ch = String.fromCharCode(0x0022); break; 
                                    case 'amp': ch = String.fromCharCode(0x0026); break; 
                                    case 'lt': ch = String.fromCharCode(0x003c); break; 
                                    case 'gt': ch = String.fromCharCode(0x003e); break; 
                                    case 'nbsp': ch = String.fromCharCode(0x00a0); break; 
                                    case 'iexcl': ch = String.fromCharCode(0x00a1); break; 
                                    case 'cent': ch = String.fromCharCode(0x00a2); break;
                                    case 'pound': ch = String.fromCharCode(0x00a3); break; 
                                    case 'curren': ch = String.fromCharCode(0x00a4); break; 
                                    case 'yen': ch = String.fromCharCode(0x00a5); break; 
                                    case 'brvbar': ch = String.fromCharCode(0x00a6); break; 
                                    case 'sect': ch = String.fromCharCode(0x00a7); break; 
                                    case 'uml': ch = String.fromCharCode(0x00a8); break; 
                                    case 'copy': ch = String.fromCharCode(0x00a9); break; 
                                    case 'ordf': ch = String.fromCharCode(0x00aa); break; 
                                    case 'laquo': ch = String.fromCharCode(0x00ab); break; 
                                    case 'not': ch = String.fromCharCode(0x00ac); break; 
                                    case 'shy': ch = String.fromCharCode(0x00ad); break; 
                                    case 'reg': ch = String.fromCharCode(0x00ae); break;
                                    case 'macr': ch = String.fromCharCode(0x00af); break;
                                    case 'deg': ch = String.fromCharCode(0x00b0); break; 
                                    case 'plusmn': ch = String.fromCharCode(0x00b1); break;
                                    case 'sup2': ch = String.fromCharCode(0x00b2); break; 
                                    case 'sup3': ch = String.fromCharCode(0x00b3); break; 
                                    case 'acute': ch = String.fromCharCode(0x00b4); break; 
                                    case 'micro': ch = String.fromCharCode(0x00b5); break; 
                                    case 'para': ch = String.fromCharCode(0x00b6); break; 
                                    case 'middot': ch = String.fromCharCode(0x00b7); break;
                                    case 'cedil': ch = String.fromCharCode(0x00b8); break; 
                                    case 'sup1': ch = String.fromCharCode(0x00b9); break; 
                                    case 'ordm': ch = String.fromCharCode(0x00ba); break; 
                                    case 'raquo': ch = String.fromCharCode(0x00bb); break; 
                                    case 'frac14': ch = String.fromCharCode(0x00bc); break; 
                                    case 'frac12': ch = String.fromCharCode(0x00bd); break; 
                                    case 'frac34': ch = String.fromCharCode(0x00be); break; 

                                    case 'iquest': ch = String.fromCharCode(0x00bf); break; 

                                    case 'Agrave': ch = String.fromCharCode(0x00c0); break; 

                                    case 'Aacute': ch = String.fromCharCode(0x00c1); break; 

                                    case 'Acirc': ch = String.fromCharCode(0x00c2); break; 

                                    case 'Atilde': ch = String.fromCharCode(0x00c3); break; 

                                    case 'Auml': ch = String.fromCharCode(0x00c4); break; 

                                    case 'Aring': ch = String.fromCharCode(0x00c5); break; 

                                    case 'AElig': ch = String.fromCharCode(0x00c6); break; 

                                    case 'Ccedil': ch = String.fromCharCode(0x00c7); break; 

                                    case 'Egrave': ch = String.fromCharCode(0x00c8); break; 

                                    case 'Eacute': ch = String.fromCharCode(0x00c9); break; 

                                    case 'Ecirc': ch = String.fromCharCode(0x00ca); break; 

                                    case 'Euml': ch = String.fromCharCode(0x00cb); break; 

                                    case 'Igrave': ch = String.fromCharCode(0x00cc); break; 

                                    case 'Iacute': ch = String.fromCharCode(0x00cd); break; 

                                    case 'Icirc': ch = String.fromCharCode(0x00ce ); break; 

                                    case 'Iuml': ch = String.fromCharCode(0x00cf); break; 

                                    case 'ETH': ch = String.fromCharCode(0x00d0); break; 

                                    case 'Ntilde': ch = String.fromCharCode(0x00d1); break; 

                                    case 'Ograve': ch = String.fromCharCode(0x00d2); break; 

                                    case 'Oacute': ch = String.fromCharCode(0x00d3); break; 

                                    case 'Ocirc': ch = String.fromCharCode(0x00d4); break; 

                                    case 'Otilde': ch = String.fromCharCode(0x00d5); break; 

                                    case 'Ouml': ch = String.fromCharCode(0x00d6); break; 

                                    case 'times': ch = String.fromCharCode(0x00d7); break; 

                                    case 'Oslash': ch = String.fromCharCode(0x00d8); break; 

                                    case 'Ugrave': ch = String.fromCharCode(0x00d9); break; 

                                    case 'Uacute': ch = String.fromCharCode(0x00da); break; 

                                    case 'Ucirc': ch = String.fromCharCode(0x00db); break; 

                                    case 'Uuml': ch = String.fromCharCode(0x00dc); break; 

                                    case 'Yacute': ch = String.fromCharCode(0x00dd); break; 

                                    case 'THORN': ch = String.fromCharCode(0x00de); break; 

                                    case 'szlig': ch = String.fromCharCode(0x00df); break; 

                                    case 'agrave': ch = String.fromCharCode(0x00e0); break; 

                                    case 'aacute': ch = String.fromCharCode(0x00e1); break; 

                                    case 'acirc': ch = String.fromCharCode(0x00e2); break; 

                                    case 'atilde': ch = String.fromCharCode(0x00e3); break; 

                                    case 'auml': ch = String.fromCharCode(0x00e4); break; 

                                    case 'aring': ch = String.fromCharCode(0x00e5); break; 

                                    case 'aelig': ch = String.fromCharCode(0x00e6); break; 

                                    case 'ccedil': ch = String.fromCharCode(0x00e7); break; 

                                    case 'egrave': ch = String.fromCharCode(0x00e8); break; 

                                    case 'eacute': ch = String.fromCharCode(0x00e9); break; 

                                    case 'ecirc': ch = String.fromCharCode(0x00ea); break; 

                                    case 'euml': ch = String.fromCharCode(0x00eb); break; 

                                    case 'igrave': ch = String.fromCharCode(0x00ec); break; 

                                    case 'iacute': ch = String.fromCharCode(0x00ed); break; 

                                    case 'icirc': ch = String.fromCharCode(0x00ee); break; 

                                    case 'iuml': ch = String.fromCharCode(0x00ef); break; 

                                    case 'eth': ch = String.fromCharCode(0x00f0); break; 

                                    case 'ntilde': ch = String.fromCharCode(0x00f1); break; 

                                    case 'ograve': ch = String.fromCharCode(0x00f2); break; 

                                    case 'oacute': ch = String.fromCharCode(0x00f3); break; 

                                    case 'ocirc': ch = String.fromCharCode(0x00f4); break; 

                                    case 'otilde': ch = String.fromCharCode(0x00f5); break; 

                                    case 'ouml': ch = String.fromCharCode(0x00f6); break; 

                                    case 'divide': ch = String.fromCharCode(0x00f7); break; 

                                    case 'oslash': ch = String.fromCharCode(0x00f8); break; 

                                    case 'ugrave': ch = String.fromCharCode(0x00f9); break; 

                                    case 'uacute': ch = String.fromCharCode(0x00fa); break; 

                                    case 'ucirc': ch = String.fromCharCode(0x00fb); break; 

                                    case 'uuml': ch = String.fromCharCode(0x00fc); break; 

                                    case 'yacute': ch = String.fromCharCode(0x00fd); break; 

                                    case 'thorn': ch = String.fromCharCode(0x00fe); break; 

                                    case 'yuml': ch = String.fromCharCode(0x00ff); break; 

                                    case 'OElig': ch = String.fromCharCode(0x0152); break; 

                                    case 'oelig': ch = String.fromCharCode(0x0153); break; 

                                    case 'Scaron': ch = String.fromCharCode(0x0160); break; 

                                    case 'scaron': ch = String.fromCharCode(0x0161); break; 

                                    case 'Yuml': ch = String.fromCharCode(0x0178); break; 

                                    case 'fnof': ch = String.fromCharCode(0x0192); break; 

                                    case 'circ': ch = String.fromCharCode(0x02c6); break; 

                                    case 'tilde': ch = String.fromCharCode(0x02dc); break; 

                                    case 'Alpha': ch = String.fromCharCode(0x0391); break; 

                                    case 'Beta': ch = String.fromCharCode(0x0392); break; 

                                    case 'Gamma': ch = String.fromCharCode(0x0393); break; 

                                    case 'Delta': ch = String.fromCharCode(0x0394); break; 

                                    case 'Epsilon': ch = String.fromCharCode(0x0395); break; 

                                    case 'Zeta': ch = String.fromCharCode(0x0396); break; 

                                    case 'Eta': ch = String.fromCharCode(0x0397); break; 

                                    case 'Theta': ch = String.fromCharCode(0x0398); break; 

                                    case 'Iota': ch = String.fromCharCode(0x0399); break; 

                                    case 'Kappa': ch = String.fromCharCode(0x039a); break; 

                                    case 'Lambda': ch = String.fromCharCode(0x039b); break; 

                                    case 'Mu': ch = String.fromCharCode(0x039c); break; 

                                    case 'Nu': ch = String.fromCharCode(0x039d); break; 

                                    case 'Xi': ch = String.fromCharCode(0x039e); break; 

                                    case 'Omicron': ch = String.fromCharCode(0x039f); break; 

                                    case 'Pi': ch = String.fromCharCode(0x03a0); break; 

                                    case ' Rho ': ch = String.fromCharCode(0x03a1); break; 

                                    case 'Sigma': ch = String.fromCharCode(0x03a3); break; 

                                    case 'Tau': ch = String.fromCharCode(0x03a4); break; 

                                    case 'Upsilon': ch = String.fromCharCode(0x03a5); break; 

                                    case 'Phi': ch = String.fromCharCode(0x03a6); break; 

                                    case 'Chi': ch = String.fromCharCode(0x03a7); break; 

                                    case 'Psi': ch = String.fromCharCode(0x03a8); break; 

                                    case 'Omega': ch = String.fromCharCode(0x03a9); break; 

                                    case 'alpha': ch = String.fromCharCode(0x03b1); break; 

                                    case 'beta': ch = String.fromCharCode(0x03b2); break; 

                                    case 'gamma': ch = String.fromCharCode(0x03b3); break; 

                                    case 'delta': ch = String.fromCharCode(0x03b4); break; 

                                    case 'epsilon': ch = String.fromCharCode(0x03b5); break; 

                                    case 'zeta': ch = String.fromCharCode(0x03b6); break; 

                                    case 'eta': ch = String.fromCharCode(0x03b7); break; 

                                    case 'theta': ch = String.fromCharCode(0x03b8); break; 

                                    case 'iota': ch = String.fromCharCode(0x03b9); break; 

                                    case 'kappa': ch = String.fromCharCode(0x03ba); break; 

                                    case 'lambda': ch = String.fromCharCode(0x03bb); break; 

                                    case 'mu': ch = String.fromCharCode(0x03bc); break; 

                                    case 'nu': ch = String.fromCharCode(0x03bd); break; 

                                    case 'xi': ch = String.fromCharCode(0x03be); break; 

                                    case 'omicron': ch = String.fromCharCode(0x03bf); break; 

                                    case 'pi': ch = String.fromCharCode(0x03c0); break; 

                                    case 'rho': ch = String.fromCharCode(0x03c1); break; 

                                    case 'sigmaf': ch = String.fromCharCode(0x03c2); break; 

                                    case 'sigma': ch = String.fromCharCode(0x03c3); break; 

                                    case 'tau': ch = String.fromCharCode(0x03c4); break; 

                                    case 'upsilon': ch = String.fromCharCode(0x03c5); break; 

                                    case 'phi': ch = String.fromCharCode(0x03c6); break; 

                                    case 'chi': ch = String.fromCharCode(0x03c7); break; 

                                    case 'psi': ch = String.fromCharCode(0x03c8); break; 

                                    case 'omega': ch = String.fromCharCode(0x03c9); break; 

                                    case 'thetasym': ch = String.fromCharCode(0x03d1); break; 

                                    case 'upsih': ch = String.fromCharCode(0x03d2); break; 

                                    case 'piv': ch = String.fromCharCode(0x03d6); break; 

                                    case 'ensp': ch = String.fromCharCode(0x2002); break; 

                                    case 'emsp': ch = String.fromCharCode(0x2003); break; 

                                    case 'thinsp': ch = String.fromCharCode(0x2009); break; 

                                    case 'zwnj': ch = String.fromCharCode(0x200c); break; 

                                    case 'zwj': ch = String.fromCharCode(0x200d); break; 

                                    case 'lrm': ch = String.fromCharCode(0x200e); break; 

                                    case 'rlm': ch = String.fromCharCode(0x200f); break; 

                                    case 'ndash': ch = String.fromCharCode(0x2013); break; 

                                    case 'mdash': ch = String.fromCharCode(0x2014); break; 

                                    case 'lsquo': ch = String.fromCharCode(0x2018); break; 

                                    case 'rsquo': ch = String.fromCharCode(0x2019); break; 

                                    case 'sbquo': ch = String.fromCharCode(0x201a); break; 

                                    case 'ldquo': ch = String.fromCharCode(0x201c); break; 

                                    case 'rdquo': ch = String.fromCharCode(0x201d); break; 

                                    case 'bdquo': ch = String.fromCharCode(0x201e); break; 

                                    case 'dagger': ch = String.fromCharCode(0x2020); break; 

                                    case 'Dagger': ch = String.fromCharCode(0x2021); break; 

                                    case 'bull': ch = String.fromCharCode(0x2022); break; 

                                    case 'hellip': ch = String.fromCharCode(0x2026); break; 

                                    case 'permil': ch = String.fromCharCode(0x2030); break; 

                                    case 'prime': ch = String.fromCharCode(0x2032); break; 

                                    case 'Prime': ch = String.fromCharCode(0x2033); break; 

                                    case 'lsaquo': ch = String.fromCharCode(0x2039); break; 

                                    case 'rsaquo': ch = String.fromCharCode(0x203a); break; 

                                    case 'oline': ch = String.fromCharCode(0x203e); break; 

                                    case 'frasl': ch = String.fromCharCode(0x2044); break; 

                                    case 'euro': ch = String.fromCharCode(0x20ac); break; 

                                    case 'image': ch = String.fromCharCode(0x2111); break; 

                                    case 'weierp': ch = String.fromCharCode(0x2118); break; 

                                    case 'real': ch = String.fromCharCode(0x211c); break; 

                                    case 'trade': ch = String.fromCharCode(0x2122); break; 

                                    case 'alefsym': ch = String.fromCharCode(0x2135); break; 

                                    case 'larr': ch = String.fromCharCode(0x2190); break; 

                                    case 'uarr': ch = String.fromCharCode(0x2191); break; 

                                    case 'rarr': ch = String.fromCharCode(0x2192); break; 

                                    case 'darr': ch = String.fromCharCode(0x2193); break; 

                                    case 'harr': ch = String.fromCharCode(0x2194); break; 

                                    case 'crarr': ch = String.fromCharCode(0x21b5); break; 

                                    case 'lArr': ch = String.fromCharCode(0x21d0); break; 

                                    case 'uArr': ch = String.fromCharCode(0x21d1); break; 

                                    case 'rArr': ch = String.fromCharCode(0x21d2); break; 

                                    case 'dArr': ch = String.fromCharCode(0x21d3); break; 

                                    case 'hArr': ch = String.fromCharCode(0x21d4); break; 

                                    case 'forall': ch = String.fromCharCode(0x2200); break; 

                                    case 'part': ch = String.fromCharCode(0x2202); break; 

                                    case 'exist': ch = String.fromCharCode(0x2203); break; 

                                    case 'empty': ch = String.fromCharCode(0x2205); break; 

                                    case 'nabla': ch = String.fromCharCode(0x2207); break; 

                                    case 'isin': ch = String.fromCharCode(0x2208); break; 

                                    case 'notin': ch = String.fromCharCode(0x2209); break; 

                                    case 'ni': ch = String.fromCharCode(0x220b); break; 

                                    case 'prod': ch = String.fromCharCode(0x220f); break; 

                                    case 'sum': ch = String.fromCharCode(0x2211); break; 

                                    case 'minus': ch = String.fromCharCode(0x2212); break; 

                                    case 'lowast': ch = String.fromCharCode(0x2217); break; 

                                    case 'radic': ch = String.fromCharCode(0x221a); break; 

                                    case 'prop': ch = String.fromCharCode(0x221d); break; 

                                    case 'infin': ch = String.fromCharCode(0x221e); break; 

                                    case 'ang': ch = String.fromCharCode(0x2220); break; 

                                    case 'and': ch = String.fromCharCode(0x2227); break; 

                                    case 'or': ch = String.fromCharCode(0x2228); break; 

                                    case 'cap': ch = String.fromCharCode(0x2229); break; 

                                    case 'cup': ch = String.fromCharCode(0x222a); break; 

                                    case 'int': ch = String.fromCharCode(0x222b); break; 

                                    case 'there4': ch = String.fromCharCode(0x2234); break; 

                                    case 'sim': ch = String.fromCharCode(0x223c); break; 

                                    case 'cong': ch = String.fromCharCode(0x2245); break; 

                                    case 'asymp': ch = String.fromCharCode(0x2248); break; 

                                    case 'ne': ch = String.fromCharCode(0x2260); break; 

                                    case 'equiv': ch = String.fromCharCode(0x2261); break; 

                                    case 'le': ch = String.fromCharCode(0x2264); break; 

                                    case 'ge': ch = String.fromCharCode(0x2265); break; 

                                    case 'sub': ch = String.fromCharCode(0x2282); break; 

                                    case 'sup': ch = String.fromCharCode(0x2283); break; 

                                    case 'nsub': ch = String.fromCharCode(0x2284); break; 

                                    case 'sube': ch = String.fromCharCode(0x2286); break; 

                                    case 'supe': ch = String.fromCharCode(0x2287); break; 

                                    case 'oplus': ch = String.fromCharCode(0x2295); break; 

                                    case 'otimes': ch = String.fromCharCode(0x2297); break; 

                                    case 'perp': ch = String.fromCharCode(0x22a5); break; 

                                    case 'sdot': ch = String.fromCharCode(0x22c5); break; 

                                    case 'lceil': ch = String.fromCharCode(0x2308); break; 

                                    case 'rceil': ch = String.fromCharCode(0x2309); break; 

                                    case 'lfloor': ch = String.fromCharCode(0x230a); break; 

                                    case 'rfloor': ch = String.fromCharCode(0x230b); break; 

                                    case 'lang': ch = String.fromCharCode(0x2329); break; 

                                    case 'rang': ch = String.fromCharCode(0x232a); break; 

                                    case 'loz': ch = String.fromCharCode(0x25ca); break; 

                                    case 'spades': ch = String.fromCharCode(0x2660); break; 

                                    case 'clubs': ch = String.fromCharCode(0x2663); break; 

                                    case 'hearts': ch = String.fromCharCode(0x2665); break; 

                                    case 'diams': ch = String.fromCharCode(0x2666); break; 

                                    default: ch = ''; break; 
                              } 
                        } 
                        i = semicolonIndex; 
                  } 
            } 
            out += ch; 
      } 
      return out; 
} 
function LoadXmlDocument(selectedtext,iframeSrc,nnerHTMl)
{
  if(selectedtext == "XmlDocument" || selectedtext == "XmlFormLibrary")
  {
      if(selectedtext=="XmlDocument")
      {
        iframeSrc = iframeSrc.replace("XmlIterator.aspx","XmlStorage.aspx")
        nnerHTMl = "XmlDocument";
      }
      else if(selectedtext=="XmlFormLibrary")
      {
        iframeSrc = iframeSrc.replace("XmlStorage.aspx","XmlInfoPath.aspx");
        nnerHTMl = "XmlFormLibrary";
      }
  }
  else
  {   
        iframeSrc = iframeSrc.replace("XmlStorage.aspx",selectedtext+".aspx");
        nnerHTMl = selectedtext;   
      
   }   
      
     
     parent.frames[0].location.href=iframeSrc;
     //document.getElementById("Xml_frame").href = iframeSrc;
     //document.getElementById("Xml_frame").src = iframeSrc;


}
