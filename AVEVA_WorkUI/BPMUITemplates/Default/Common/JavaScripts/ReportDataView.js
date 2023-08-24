var bV=parseInt(navigator.appVersion);
NS4=(document.layers) ? true : false;
IE4=((document.all)&&(bV>=4))?true:false;
ver4 = (NS4 || IE4) ? true : false;

isExpanded = false;

function getIndex($1) {
	ind = null;
	for (i=0; i<document.layers.length; i++) {
		whichEl = document.layers[i];
		if (whichEl.id == $1) {
			ind = i;
			break;
		}
	}
	return ind;
}

function arrange() {
	nextY = document.layers[firstInd].pageY + document.layers[firstInd].document.height;
	for (i=firstInd+1; i<document.layers.length; i++) {
		whichEl = document.layers[i];
		if (whichEl.visibility != "hide") {
			whichEl.pageY = nextY;
			nextY += whichEl.document.height;
		}
	}
}

function FolderInit(){
	if (NS4) {
	firstEl = "m000Parent";
	firstInd = getIndex(firstEl);
	showAll();
		for (i=0; i<document.layers.length; i++) {
			whichEl = document.layers[i];
			if (whichEl.id.indexOf("Child") != -1) whichEl.visibility = "hide";
		}
		arrange();
	}
	else {
		tempColl = document.all.tags("DIV");
		for (i=0; i<tempColl.length; i++) {
			if (tempColl(i).className == "child") tempColl(i).style.display = "none";
		}
	}
}

function FolderExpand($1,$2) {
	if (!ver4) return;
	if (IE4) { ExpandIE($1,$2) } 
	else { ExpandNS($1,$2) }
}

function ExpandIE($1,$2)
 {
	
	mExpanTree = eval($1 + "Tree");	
	Expanda = eval($1 + "a");		
	Expanda.blur();		
	ExpandChild = eval($1 + "Child");
	
	if ($2 != "top")
         { 
		
		ExpandTree = eval($1 + "Tree");
		//ExpandFolder = eval($1 + "Folder");
	}
	
	if (ExpandChild.style.display == "none")
	 {
		ExpandChild.style.display = "block";
                if ($2 != "top") 
                { 
                	if ($2 == "last") 
                	{ ExpandTree.src = "<%#VirtualDirectory%>/images/Lminus.gif"; 
                	}
			else 
			{ 
			ExpandTree.src = "<%#VirtualDirectory%>/images/Tminus.gif"; }
			//ExpandFolder.src = "<%#VirtualDirectory%>/images/openfoldericon.gif";	
		}
		else
		 { 
		 	
		 	mExpanTree.src = "<%#VirtualDirectory%>/images/topopen.gif"; 		 
		 }
	}
	else
	 {
		
		ExpandChild.style.display = "none";
                if ($2 != "top") 
                { 
	                if ($2 == "last") 
	                { ExpandTree.src = "<%#VirtualDirectory%>/images/Lplus.gif"; 
	                }
			else 
			{ 
			ExpandTree.src = "<%#VirtualDirectory%>/images/Tplus.gif"; 
			}
			//ExpandFolder.src = "<%#VirtualDirectory%>/images/foldericon.gif";
		}
		else 
		{
		
			mExpanTree.src = "<%#VirtualDirectory%>/images/top.gif"; 
		}
	}
}
function ExpandNS($1,$2) {
	ExpandChild = eval("document." + $1 + "Child")
        if ($2 != "top") { 
		ExpandTree = eval("document." + $1 + "Parent.document." + $1 + "Tree")
		//ExpandFolder = eval("document." + $1 + "Parent.document." + $1 + "Folder")
	}	
	if (ExpandChild.visibility == "hide") {
		ExpandChild.visibility = "show";
                if ($2 != "top") { 
               		if ($2 == "last") { ExpandTree.src = "<%#VirtualDirectory%>/images/Lminus.gif"; }
			else { ExpandTree.src = "<%#VirtualDirectory%>/images/Tminus.gif"; }
			//ExpandFolder.src = "<%#VirtualDirectory%>/images/openfoldericon.gif";	
		}
		else { mExpanTree.src = "<%#VirtualDirectory%>/images/topopen.gif"; }
	}
	else {
		ExpandChild.visibility = "hide";
                if ($2 != "top") { 
               		if ($2 == "last") { ExpandTree.src = "<%#VirtualDirectory%>/images/Lplus.gif"; }
			else { ExpandTree.src = "<%#VirtualDirectory%>/images/Tplus.gif"; }
			//ExpandFolder.src = "<%#VirtualDirectory%>/images/foldericon.gif";	
		}
		else { mExpanTree.src = "<%#VirtualDirectory%>/images/top.gif"; }
	}
	arrange();
}

function showAll() {
	for (i=firstInd; i<document.layers.length; i++) {
		whichEl = document.layers[i];
		whichEl.visibility = "show";
	}
}


with (document) {
	write("<STYLE TYPE='text/css'>");
	if (NS4) {
		write(".parent { font-size: 11px;color: black; font-size:9pt; line-height:0pt; color:black; text-decoration:none; margin-top: 0px; margin-bottom: 0px; position:absolute; visibility:hidden;font-family:verdana }");
		write(".child { font-size: 11px;margin-left:10px;text-decoration:none; font-size:9pt; line-height:15pt; position:absolute;font-family:verdana }");
	        write(".item { font-size: 11px;color: black; text-decoration:none;font-family:verdana }");
	        write(".highlight { font-size: 11px;color: blue; text-decoration:none;font-family:verdana }");
	}
	else {
		write(".parent { font-size: 11px;text-decoration: none; color: black;font-family:verdana }");
		write(".child { font-size: 11px;margin-left:10px; display:none;font-family:verdana }");
	        write(".item { font-size: 11px;color: black; text-decoration:none; cursor: hand;font-family:verdana }");
	        write(".highlight { font-size: 11px;color: blue; text-decoration:none;font-family:verdana }");
	        write(".icon { font-size: 11px;margin-right: 5;font-family:verdana }")
	}
	write("</STYLE>");
}

onload = FolderInit;