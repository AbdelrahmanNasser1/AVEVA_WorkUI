//Treeview****************************
var CmbDIR_IMAGES="";//= "../Common/images/";
var CmbIMG_PLUS="";
var CmbIMG_MINUS = "";
var CmbangleImage = "" ;
var CmbMenuGif="";
var CmbobjTree = new CmbjsTree;
var CmbimgPlus = new Image();
CmbimgPlus.src = CmbIMG_PLUS;
var CmbimgMinus = new Image();
CmbimgMinus.src = CmbIMG_MINUS;

var DataTypes="string,integer,long,double,decimal,date,time,datetime,boolean,base64";

var CmbINDENT_WIDTH = 19;

var maxImageIncluded=false;

var olddivHeight;
var olddivWidth;
var olddivleft;
var maximize=true;
var MaximizeText="";
var hrefText="";

function CmbjsTree() {

    //Public Properties 
    this.root = null;           //the root node of the tree
 
     //Public Collections 
    this.nodes = new Array;     //array for all nodes in the tree
   
    //Constructor
    //assign to local copy of the tree 
    CmbobjLocalTree = this;
}

//-----------------------------------------------------------------
// Method CmbjsTree.createRoot()
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
//  The CmbjsTreeNode that was created.
//-----------------------------------------------------------------
CmbjsTree.prototype.createRoot = function(strIcon, strText, strURL, strTarget,strType,xPath) {

    //create a new node 
    this.root = new CmbjsTreeNode(strIcon, strText, strURL, strTarget,strType,null,xPath,false);
    
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
// Method CmbjsTree.buildDOM()
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
CmbjsTree.prototype.buildDOM = function() {

    //call method to add root to document, which will recursively
    //add all other nodes 
    if(this.root!=null)
        this.root.addToDOM(document.getElementById("treeDiv"));
}

//-----------------------------------------------------------------
// Method CmbjsTree.toggleExpand()
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
CmbjsTree.prototype.toggleExpand = function(strNodeID) {

    var objNode = this.nodes[strNodeID];
    
    //determine whether to expand or collapse
    if (objNode.expanded)
        objNode.collapse();
    else
        objNode.expand();
}

//-----------------------------------------------------------------
// Class CmbjsTreeNode
//-----------------------------------------------------------------
// Description
//  The CmbjsTreeNode class encapsulates the basic information for a node
//  in the tree.
//
// Parameters
//  strIcon (string) - the icon to display for this node.
//  strText (string) - the text to display for this node.
//  strURL (string) - the URL to navigate to when this node is clicked.
//  strTarget (string) - the target for the URL (optional).
//-----------------------------------------------------------------
//function CmbjsTreeNode(strIcon, strText, strURL, strTarget) 
//code modification by Sajit on 22 monday 2004
function CmbjsTreeNode(strIcon, strText, strURL, strTarget,strType,strParent,nodeDataType,IsRepeating) {

    this.icon = strIcon;            //the icon to display
    //Elizabeth commented to support special charaters in xml nodes        
    //this.text = strText;            //the text to display
    this.text = strText.replace("<","&lt;"); // replaced < with &lt; because the tree view is trimming the text after that
    this.url = strURL;              //the URL to link to
    this.target = strTarget;        //the target for the URL
    this.type=strType;				//the type of the node 
    this.parent=strParent;			//the node in which an attribute is contained.null if type=node
    this.DataType=nodeDataType;
    this.indent = 0;                //the indent for the node
    this.IsRepeating=true;
    //this.expanded = false;          //is this node expanded?
    this.expanded = true;          //is this node expanded?
    this.childNodes = new Array;    //the collection of child nodes
}

//-----------------------------------------------------------------
// Method CmbjsTreeNode.addChild()
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
//  The CmbjsTreeNode that was created.
//-----------------------------------------------------------------
//Code modified by Sajit on 22 Nov 2004
//CmbjsTreeNode.prototype.addChild = function (strIcon, strText, strURL, strTarget)
CmbjsTreeNode.prototype.addChild = function (strIcon, strText, strURL, strTarget,strType,strParent,nodeDataType,IsRepeating) {

    // create a new node (NCZ, 1/27/02)
	// var objNode = new CmbjsTreeNode(strIcon, strText, strURL, strTarget);
	//alert("in addChild"+ strParent);
	var objNode = new CmbjsTreeNode(strIcon, strText, strURL, strTarget,strType,strParent,nodeDataType,IsRepeating);
    
    //assign an ID for internal tracking (NCZ, 1/27/02)
    objNode.id = this.id + "_" + this.childNodes.length;
    
    //assign the indent for this node
    objNode.indent = this.indent + 1;
    
    //add into the array of child nodes (NCZ, 1/27/02)
    this.childNodes[this.childNodes.length] = objNode;
    
    //add it into the array of all nodes (NCZ, 1/27/02)
    CmbobjLocalTree.nodes[objNode.id] = objNode;
    
    //return the created node (NCZ, 1/27/02)
    return objNode;
}

//-----------------------------------------------------------------
// Method CmbjsTreeNode.addToDOM()
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
CmbjsTreeNode.prototype.addToDOM = function (objDOMParent) {

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
    var d = new CmbjsDocument;
    
    //begin the table (NCZ, 1/27/02)
    //Shanmug Added div on 6 Dec 04 to make the tree view align properly
    //d.writeln("<div><table border=\"0\" bordercolor=red cellpadding=\"1\" cellspacing=\"0\"><tr>");
    var maxImg = this.icon.replace("Condition.gif","icon-maximize.png");
   
   if(!maxImageIncluded)
        {
         hrefText = "<A href=\"#\" onclick=\"Maximize(true,'"+ objDOMParent.id +"')\">";
         d.writeln("<div><table border=\"0\" bordercolor=red cellpadding=\"2\" cellspacing=\"0\" width=100%><tr><td align=\"left\" bgcolor=\"#e1e1e1\" width=\"1%\"  valign=\"middle\"><A href=\"#\" onclick=\"Maximize(true,'"+ objDOMParent.id +"')\"><img id=\"MaximizeImg\" hspace=\"1\" src='"+maxImg+"' border=0 align='absmiddle'>"+"<span id=\"TextSpan\" style=\"font-family:verdana; font-size:7pt; text-decoration:none;\">"+"Maximize"+"</span>"+"</a></td><td align=\"left\" bgcolor=\"#e1e1e1\" width=\"99%\" ><div id='Max"+objDOMParent.id+"' style=\"width:20px\"></div></td></tr><tr>");
    }
    else
    {
            d.writeln("<div><table border=\"0\" bordercolor=red cellpadding=\"2\" colspan=2 cellspacing=\"0\" width=100%><tr>"); 
    }
    
    
    
    //no indent needed for root or level under root (NCZ, 1/27/02)
    if (this.indent > 1) {
        d.write("<td width=\"");
        d.write(this.indent * CmbINDENT_WIDTH);
        d.write("\">&nbsp;</td>");
    }
    
    //there is no plus/minus image for the root (NCZ, 1/27/02)
    if (this.indent > 0) {
    
        d.write("<td width=\"18\" align=\"center\">");
        
        //if there are children, then add a plus/minus image (NCZ, 1/27/02)
        if (this.childNodes.length > 0) {
            d.write("<a href=\"javascript:CmbobjLocalTree.toggleExpand('");
            d.write(this.id);
            d.write("')\"><img src=\"");
            d.write(this.expanded ? CmbimgMinus.src : CmbimgPlus.src);
            d.write("\" border=\"0\" hspace=\"1\" id=\"");
            d.write("imgPM_" + this.id);
            d.write("\" /></a>");
        }
        
        d.write("</td>");
    }
    
    //strHTMLLink = "<a href=\"#\" onclick=\"javascript:OpenMenu('"+this.id+"',this,'"+this.parent+"','"+this.type+"')\"><img border=0 src=\""+MenuGif+"\" alt=\"Menu\"></a>";
    
    if((this.childNodes.length==0)&&(this.id!="root"))
    {
      d.write("<td nowrap=\"nowrap\" class=\"contenttext\"><img hspace=\"1\" src=\"" + this.icon + "\" border=\"0\" align=\"absmiddle\" /> <a href=\"#\" onclick=\"javascript:LoadTreeview('"+this.DataType+"','"+this.text+"')\" class=\"description\">"+this.text+"</a></td>");
    }
    else
    {
    if(!maxImageIncluded)
        {
        d.write("<td nowrap=\"nowrap\" class=\"contenttext\"><img hspace=\"1\" src=\"" + this.icon + "\" border=\"0\" align=\"absmiddle\" />  <a href=\"#\" onclick=\"javascript:LoadTreeview('"+this.DataType+"','"+this.text+"')\" class=\"description\">"+this.text+"</a></td>");
        maxImageIncluded=true;
        }
        else
            {
d.write("<td nowrap=\"nowrap\" class=\"contenttext\"><img hspace=\"1\" src=\"" + this.icon + "\" border=\"0\" align=\"absmiddle\" />  <a href=\"#\" onclick=\"javascript:LoadTreeview('"+this.DataType+"','"+this.text+"')\" class=\"description\">"+this.text+"</a></td>");
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

//-----------------------------------------------------------------
// Method CmbjsTreeNode.collapse()
//-----------------------------------------------------------------
// Description
//  This method expands the CmbjsTreeNode's children to be hidden.
//
// Parameters
//  (none)
//
// Returns
//  (nothing)
//-----------------------------------------------------------------
CmbjsTreeNode.prototype.collapse = function () {

    //check to see if the node is already collapsed (NCZ, 1/27/02)
    if (!this.expanded) {
    
        //throw an error (NCZ, 1/27/02)
        throw "Node is already collapsed"

    } else {
    
        //change the state of the node (NCZ, 1/27/02)
        this.expanded = false;
        
        //change the plus/minus image to be plus (NCZ, 1/27/02)
        document.images["imgPM_" + this.id].src = CmbimgPlus.src;
        
        //hide the child nodes (NCZ, 1/27/02)
        document.getElementById("divChildren_" + this.id).style.display = "none";
    }
}


//-----------------------------------------------------------------
// Method CmbjsTreeNode.expand()
//-----------------------------------------------------------------
// Description
//  This method expands the CmbjsTreeNode's children to be displayed.
//
// Parameters
//  (none)
//
// Returns
//  (nothing)
//-----------------------------------------------------------------
CmbjsTreeNode.prototype.expand = function () {

    //check to see if the node is already expanded (NCZ, 1/27/02)
    if (this.expanded) {
    
        //throw an error (NCZ, 1/27/02)
        throw "Node is already expanded"
    
    } else {
    
        //change the state of the node (NCZ, 1/27/02)
        this.expanded = true;
        
        //change the plus/minus image to be minus (NCZ, 1/27/02)
        document.images["imgPM_" + this.id].src = CmbimgMinus.src;
        
        //show the child nodes (NCZ, 1/27/02)
        document.getElementById("divChildren_" + this.id).style.display = "block";
    }
}

function CmbjsDocument() 
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
function Maximize(mode,div) {       
    var divTreeObj = document.getElementById(div);
    var divHeight;
    var divWidth;
    var winHeight;
    var winWidth;
    var divtop;
    var imgObject = document.getElementById("MaximizeImg");
    var Spanoftext=document.getElementById("TextSpan");
    
    if(divTreeObj!=null)
    {
        if((maximize)&&(mode))
        {
            divHeight = divTreeObj.style.height;
            divWidth = divTreeObj.style.width;
            
            olddivHeight = divHeight;
            olddivWidth = divWidth;
            olddivleft =  divTreeObj.style.left;
                        
            winHeight =  document.body.offsetHeight;
            winWidth =  document.body.offsetWidth;
            divtop = divTreeObj.style.top.substring(0,(divTreeObj.style.top).length-2);
            divTreeObj.style.left=20;
            divTreeObj.style.width =   winWidth-50;
	        divTreeObj.style.height =  (parseInt(winHeight)-divtop) - 20;
	        
	        var iframeObj=document.getElementById("IframeShim");
	        
	        if(iframeObj!=null)
	        {
	            iframeObj.style.width = divTreeObj.offsetWidth ;
		        iframeObj.style.height = divTreeObj.offsetHeight ;
		        iframeObj.style.top = divTreeObj.style.top;
		        iframeObj.style.left = divTreeObj.style.left;
		        iframeObj.style.zIndex = divTreeObj.style.zIndex - 1;
                iframeObj.style.display = "block";
	        
	        }

	        if (imgObject != null) {
	            var iSrc = imgObject.src.replace("icon-maximize.png", "icon-minimize.png");
	            document.getElementById("Max" + div).innerHTML = hrefText; //+ "<span style=\"font-family:verdana; font-size:7pt; text-decoration:none;\">"+"Minimize"+"</span></a>";
	            imgObject.src = iSrc;
	            Spanoftext.innerHTML = Spanoftext.innerHTML.replace("Maximize", "Minimize");
	            maximize = false;
	        }
	    }
	    else
	    {
	      if(mode==true)
	       {
	            divTreeObj.style.left=olddivleft;
                divTreeObj.style.width =   olddivWidth;
	            divTreeObj.style.height =  olddivHeight;
	            var iSrc = imgObject.src.replace("icon-minimize.png","icon-maximize.png");
	            imgObject.src = iSrc;
	            maximize=true;
	       }
	       if((mode==false)&&(maximize==false))
	       {
	            divTreeObj.style.left=olddivleft;
                divTreeObj.style.width =   olddivWidth;
	            divTreeObj.style.height =  olddivHeight;
	            var iSrc = imgObject.src.replace("icon-minimize.png","icon-maximize.png");
	            Spanoftext.innerHTML = Spanoftext.innerHTML.replace("Minimize", "Maximize");
	            imgObject.src = iSrc;
	            maximize=true;
	       }
	       
	        var iframeObj=document.getElementById("IframeShim");
	        
	        if(iframeObj!=null)
	        {
	            iframeObj.style.width = divTreeObj.offsetWidth ;
		        iframeObj.style.height = divTreeObj.offsetHeight ;
		        iframeObj.style.top = divTreeObj.style.top;
		        iframeObj.style.left = divTreeObj.style.left;
		        iframeObj.style.zIndex = divTreeObj.style.zIndex - 1;
                iframeObj.style.display = "block";
	        
	        }
	       
	       if(document.getElementById("Max"+div)!=null)
	       {
	                        document.getElementById("Max"+div).innerHTML= hrefText;
	                        Spanoftext.innerHTML=Spanoftext.innerHTML.replace("Minimize","Maximize");
	                        //+ "<span style=\"font-family:verdana; font-size:7pt; text-decoration:none;\">"+"Maximize"+"</span></a>";
	        }   
	     }          
    }
    
 
}
function replacestringChars(stringtobereplaced,chartobereplaced,charbywhichreplaced)
    {
      var out = ""; 
      if (stringtobereplaced==null) return; 
      var l = stringtobereplaced.length; 
      for (var i=0; i<l; i++) 
      { 
            var ch = stringtobereplaced.charAt(i); 
            if (ch == chartobereplaced) 
            {
               stringtobereplaced = stringtobereplaced.replace(ch,charbywhichreplaced);      
            }
      }
                
      return stringtobereplaced;          
    }