    var menuXpos = 0;
var menuYpos = 0;

var radAjaxControlId;
var UrlJs;
var ListItemObj;
var ParentItemId = "00000000-0000-0000-0000-000000000000";

var gValue;
var gName;
var gType;
var gProperties;
var gUri;
var selectItemRow; //added for localization
var breadCrumb="";
var SelCellText = "";
var _popmenu = null;
var sysDel;
var sysCreateTemplate;
var noRowSelected;
var norightforaction;
var ApprovalWFAttachedcontinue;
var cannotPerDisable;

var _ListControlName = parent.parent.ListControlId;

var menuObject;

// This function will be called back after the Ajax call with result sent from server side.
function BuildWorkflowContextMenu(context, result, response) {

    if(result !=null && response.Error==false)
     {  	      	        
	        eval("UrlJs="+result);
            eval("UrlJs2="+result);
            eval("UrlJs3="+result);

            	        
	        cnt = 0;
	        for(var key in UrlJs)
	        { 
	            cnt++;
	        }
	            
		    var FormMenuYpos=menuYpos;
//	        for(var key in UrlJs)

            var name1,value1,type1,properties1,uri1,iconpath1,parentName1;

            for(var key=0; key<cnt;key++)
	        {   
	            parentName1 = eval("UrlJs[\""+key+"\"][\"ParentName\"]");
	        	            
	        	if(parentName1 == ""){

 	                name1       = eval("UrlJs[\""+key+"\"][\"Name\"]");
	                value1      = eval("UrlJs[\""+key+"\"][\"Value\"]");
                    type1       = eval("UrlJs[\""+key+"\"][\"Type\"]");
                    properties1 = eval("UrlJs[\""+key+"\"][\"Properties\"]");
                    uri1        = eval("UrlJs[\""+key+"\"][\"Uri\"]");
                    iconpath1 = eval("UrlJs[\"" + key + "\"][\"IconPath\"]"); 

                    ///------------------------------------------1st Level Menu--------------------------------------------------------------//

                    var mnuMainItem = new WebMenuItem();
                    mnuMainItem.Text = name1;
                    mnuMainItem.Name = value1;
                    mnuMainItem.OnClick = "javascript:ExecuteAction('" + name1 + "','" + value1 + "','" + type1 + "','" + properties1 + "','" + uri1 + "', ListItemObj)";
                    mnuMainItem.ImageURL = themeDirectoryForImages + "Repository/ListControl/Images/MenuIcons/" + iconpath1 + ".png";
                    

                ///-------------------------------------------- 2nd Level Menu ----------------------------------------------------------//

                
                for (var key2 in UrlJs2)
                {
                
                    if (UrlJs2[key2]["ParentName"] == UrlJs[key]["Value"])
                    {

                        var menuSubItem = new WebMenuItem();
                        menuSubItem.Text = UrlJs2[key2]["Name"];
                        menuSubItem.Name = UrlJs2[key2]["Value"];
                        menuSubItem.OnClick = "javascript:ExecuteAction('" + UrlJs2[key2]["Name"] + "','" + UrlJs2[key2]["Value"] + "','" + UrlJs2[key2]["Type"] + "','" + UrlJs2[key2]["Properties"] + "','" + UrlJs2[key2]["Uri"] + "', ListItemObj)";
                        menuSubItem.ImageURL = themeDirectoryForImages + "Repository/ListControl/Images/MenuIcons/" + UrlJs2[key2]["IconPath"] + ".png";
                        if (mnuMainItem.Items.GetNamedItem(UrlJs2[key2]["Value"]) == null)
                            mnuMainItem.Items.Add(menuSubItem);

                        ///-------------------------------------------- 3rd Level Menu for Specific Version -------------------------------------//

                         //Creating the version choices as 3rd level menu for Specific Version option.
                        if (UrlJs2[key2]["Value"] == "_sys_saveas_specific_version")
                        {                            
                            for(var key3 in UrlJs3){
                                if (UrlJs3[key3]["ParentName"] == "_sys_saveas_specific_version")
                                {
                                    var menuSubInnerItem = new WebMenuItem();
                                    menuSubInnerItem.Text = UrlJs3[key3]["Name"];
                                    menuSubInnerItem.Name = UrlJs3[key3]["Name"];
                                    menuSubInnerItem.OnClick = "javascript:ExecuteAction('" + UrlJs2[key2]["Name"] + "','" + UrlJs2[key2]["Value"] + "','" + UrlJs2[key2]["Type"] + "','" + UrlJs2[key2]["Properties"] + "','" + UrlJs2[key2]["Uri"] + "&version=" + UrlJs3[key3]["Properties"] + "', ListItemObj)";
                                    menuSubInnerItem.ImageURL = themeDirectoryForImages + "Repository/ListControl/Images/MenuIcons/" + UrlJs3[key3]["IconPath"] + ".png";
                                    if (menuSubItem.Items.GetNamedItem(UrlJs3[key3]["Name"]) == null)
                                        menuSubItem.Items.Add(menuSubInnerItem);

	                            }
	                        }
                        }
             
	                }
                 }     
                    //--------------------//
                    if (menuObject.Items.GetNamedItem(value1) == null)
                        menuObject.Items.Add(mnuMainItem);
	            } 

 	       }
            menuObject.Show(menuXpos, menuYpos);
 	  
    }
} 


function OnInitialize(){
 //On grid intialize, nothin added now.
}

function ListItem()
{
    this.ListId = "";
    this.ListItemId = ""; 
    this.ListItemStatus = "";
    this.VersionStamp = ""
    this.SpecificVersionToSave = "";
    this.ParentItemId = "";
    this.ActionToRun = "";
    this.IsVersionGrid = "";
    this.ListItemName = "";
}
function ShowContextMenu(gridId, rowType, rowEl, rowMenu,location)
 {   
      var row = wgGetGridById("WebGrid1").GetSelectedObject().GetRowElement();    
     var cell = wgGetCellByName(row, "Version");                        

     if(cell==null)
        return;
             
     //For getting the Workflowname,Workitemid and Applicationname from the attribute added to the 'Title' column.
     var Querystringvalues = cell.getAttribute("itemDetails");
     if(Querystringvalues == null) return;
     var QuerystringvaluesArr=Querystringvalues.split(',');                       
 
     
        var i;
      var grid = wgGetGridById(gridId);	
            
        if (rowType != "Record") return true;	
        
        if(rowType =="Record")
        {
            // hide the default context menu
            for (i=0;i<=43;i++)
            {                 
             //rowMenu.Items[i].visible = false;
             rowMenu.Items[i].Hide(); 
             
            }                       
                       
        }
        menuObject = rowMenu;
  //Assigning values to the ListItem object
     ListItemObj = new ListItem();
     ListItemObj.ListItemId = QuerystringvaluesArr[0];
     ListItemObj.ListId = QuerystringvaluesArr[1];
     ListItemObj.ListItemStatus = QuerystringvaluesArr[2]; 
     ListItemObj.ParentItemId = "00000000-0000-0000-0000-000000000000";
     ListItemObj.VersionStamp = cell.innerText;
     ListItemObj.IsVersionGrid = "Y";

     try {
         parent.parent.CallServerSideMethod(_ListControlName, 'DefaultMenu', 'DefaultMenu', BuildWorkflowContextMenu, 'ListItemDetails', ListItemObj);
     }
     catch (err) { }         
 
     menuXpos = location.X;
     menuYpos = location.Y;      
}

function RowSelect(gridId, rowType, rowEl, rowMenu, location) {

    var count = 0;
    try {
        var checkedRows = ISGetObject("WebGrid1").RootTable.GetCheckedRows();
        count = checkedRows.length;
    }
    catch (e) { }

    if (count == 0) {

        if (typeof (parent.LoadRightActionBar) != 'undefined') {
            parent.LoadRightActionBar();
        }


        if (typeof (parent.parent.LoadRightActionBar) != 'undefined')
            parent.parent.LoadRightActionBar();
    }
         
                 var row = wgGetGridById("WebGrid1").GetSelectedObject().GetRowElement();    
        var cell = wgGetCellByName(row, "Version");                        
         
         if(cell==null)
            return;
         
         SelCellText = cell.innerText;
 
          var Querystringvalues = cell.getAttribute("itemDetails");
         if(Querystringvalues == null) return;
         var QuerystringvaluesArr=Querystringvalues.split(',');  
         
         ListItemObj = new ListItem();
         ListItemObj.ListItemId = QuerystringvaluesArr[0];
         ListItemObj.ListId = QuerystringvaluesArr[1];
         ListItemObj.VersionStamp = SelCellText; //versionCell.innerText;  
         ListItemObj.ListItemStatus = QuerystringvaluesArr[2]; 
         ListItemObj.ParentItemId = ParentItemId;
         ListItemObj.IsVersionGrid = "Y";

}

//On cell double click - displaying child items
function DoCellClick(gridId, rowType, rowEl, rowMenu,location){
     var listItem = wgGetGridById("WebGrid1").GetSelectedObject().GetRowElement();    
     var versionColumn = wgGetCellByName(listItem, "Version");

     if (versionColumn==null)
        return;
   
     //For getting the Workflowname,Workitemid and Applicationname         
     var Querystringvalues = versionColumn.getAttribute("itemDetails");
     if(Querystringvalues == null) return;
     var QuerystringvaluesArr=Querystringvalues.split(',');                       
     
     var ListItemId = QuerystringvaluesArr[0];
     var ListId = QuerystringvaluesArr[1];
     var ListItemStatus = QuerystringvaluesArr[2];
    
    //Passing ParentItemId to access it with Request.Form
	 var grid = ISGetObject(gridId);
     grid.AddInput("ParentItemId", ListItemId);   
   
     ParentItemId = ListItemId;
     var actionToPerform = QuerystringvaluesArr[3];
     if (actionToPerform != "") {
         ExecuteActionForSelectedRow(actionToPerform);
     }
    
     grid.RefreshAll();
     return true;	     
}     


//------------------------------- Fuctions to execute action request from context menu. -------------------------//

// Opening files in new window or same page for 'ASPXUIAction' actions.
function OpenFile(uri,properties)
{
    var winProperties = properties.split("||");
  
    var winOpenerType   = winProperties[0];
    var winPosition     = winProperties[1];
    var winSize         = winProperties[2];    
    var winHeight       = winProperties[4];
    var winWidth        = winProperties[3];
    var winTop          = winProperties[5];
    var winLeft         = winProperties[6];
    var winTitle        = winProperties[7];
    var winIsResizable  = winProperties[8];
    var winIsScrollable = winProperties[9];
    var winIsModal      = winProperties[10];
    
    var w,h;
    w = screen.availWidth;
    h = screen.availHeight;
    winIsResizable = "1";

  //Checking for Window Size Property
    switch(winSize)
    {
        case "ScreenPropotional":
            winHeight = (h* 75/100);
            winWidth  = (w* 73/100); 
            break;
        
        case "Maximized":
            winHeight = h;
            winWidth  = w;
            break;
        
        case "Specified":
            winHeight = winHeight;
            winWidth  = winWidth;
            break;
    }    
  
    
  //Checking for Window Position Property
    switch(winPosition)
    {
        case "Center":
            winLeft = (w-winWidth)/2;
            winTop  = (h-winHeight)/2;               
            break;
            
        case "TopLeft":                        
            winTop  = 0;
            winLeft = 0;                
            break;
        
        case "BottomLeft":                       
            winTop  = h-winHeight;
            winLeft = 0;                
            break;
            
        case "TopRight":                        
            winTop  = 0;
            winLeft = w-winWidth;                
            break;
            
        case "BottomRight":                       
            winTop  = h-winHeight;
            winLeft = w-winWidth;                
            break;
            
        case "TopCenter":                        
            winTop  = 0;
            winLeft = (w-winWidth)/2;                
            break;
            
        case "BottomCenter":                        
            winTop  = h-winHeight;
            winLeft = (w-winWidth)/2;                
            break;

    }

    switch(winOpenerType)
    {
        case "Popup":
            //Opening the RAD window 
            try {
                var oManager = parent.parent.GetRadWindowManagerForListControl();
                var oWnd = oManager.getWindowByName("ECWindow");

                oWnd.set_title(winTitle);

                oWnd.setSize(winWidth, winHeight);
                oWnd.setUrl(uri);
                oWnd.show();
            }
            catch (err) {
                if (parent.window.opener.location.href.indexOf("AAAssociation.aspx", 0) != -1) {
                    window.open(uri, '', "left=" + winLeft + ",top=" + winTop + ",width=" + winWidth + ",height=" + winHeight + ",resizable=" + winIsResizable + ",scrollbars=" + winIsScrollable + "\"");
                }
            }
            break;

        case "PopupWithClose":
            //Opening the RAD window 
            try {
                if (parent.parent.location.href.indexOf("VersionListGrid.aspx") != -1)
                {
                    uri = "../" + uri;
                }

                var oManager = parent.parent.GetRadWindowManagerForListControl();
                var oWnd = oManager.getWindowByName("WindowCloseBehaviour");

                oWnd.set_title(winTitle);

                oWnd.setSize(winWidth, winHeight);
                oWnd.setUrl(uri);
                oWnd.show();
            }
            catch (err) {
                if (parent.window.opener.location.href.indexOf("AAAssociation.aspx", 0) != -1) {
                    window.open(uri, '', "left=" + winLeft + ",top=" + winTop + ",width=" + winWidth + ",height=" + winHeight + ",resizable=" + winIsResizable + ",scrollbars=" + winIsScrollable + "\"");
                }
            }
            break;

        case "HidePopup":
            try {
                if (parent.parent.location.href.indexOf("VersionListGrid.aspx") != -1) {
                    uri = "../" + uri;
                }

                var oManager = parent.parent.GetRadWindowManagerForListControl();
                var oWnd = oManager.getWindowByName("WindowCloseBehaviour");

                oWnd.set_title(winTitle);

                oWnd.setSize(winWidth, winHeight);
                oWnd.setUrl(uri);
                oWnd.hide();
                RefreshGrid();
            }
            catch (err) {
                
                }
            break;

        case "Inplace":
            parent.document.location.href = uri;
        break;

        case "Window":
            window.open(uri,'',"left="+winLeft+",top="+winTop+",width="+winWidth+",height="+winHeight+",resizable="+winIsResizable+",scrollbars="+winIsScrollable+"\"");
        break;
    }
  
}

function ExecuteAction(name, value, type, properties, uri, itemObj) {
    
    gValue = name;
    gName = value;
    gType = type;
    gProperties = properties;
    gUri = uri;
    
     if(properties.indexOf('Inplace') != -1)
        DoCellClick();

    if(ListItemObj !== undefined){
        ListItemObj.ActionToRun = value;
    }
    else{
        ListItemObj = itemObj;
    }

    try { parent.parent.CallServerSideMethod(_ListControlName, "CheckSecuirtyStatus", "CheckSecuirtyStatus", SetSecurityCheckResponse, 'ListItemDetails', ListItemObj); }
    catch (err) {
        if (parent.window.opener.location.href.indexOf("AAAssociation.aspx", 0) != -1) {
            parent.window.opener.CallServerSideMethod(_ListControlName, "CheckSecuirtyStatus", "CheckSecuirtyStatus", SetSecurityCheckResponse, 'ListItemDetails', ListItemObj);
        }
    }         
  
    if(properties.indexOf('Inplace') == -1)
        SelCellText = "";           
   
}

function SetSecurityCheckResponse(context, result, response) {
  name = gValue;
  value = gName;
  type = gType;
  properties = gProperties;
  uri = gUri;
  
    eval("var JsRightsType ="+result);
         
    for(var key in JsRightsType){            
        var rightValue = JsRightsType[key]["RightTypeValue"];
    }
    
    if(rightValue == "0"){
        SecurityCheck = "DNL";
    }
    else if(rightValue == "1"){
        SecurityCheck = "ALL";
    }
    else if(rightValue == "2"){
         SecurityCheck = "APP";
    }
    else if(rightValue == "3"){
        SecurityCheck = "AWP";
    }
    else if (rightValue == "5") {
        SecurityCheck = "OVW";
    }
    else if(rightValue == "7"){
        SecurityCheck = "OWPUBFRM";
        }
              
//    alert(rightValue);


    if(SecurityCheck == "DNL"){
        //alert("You do not have rights to perform this action.");
        if (norightforaction == null || norightforaction == undefined)
            norightforaction = "You do not have rights to perform this action.";
        se.ui.messageDialog.showAlert(bellyBarTitle, norightforaction);
        return; 
    }
    
    if(SecurityCheck == "AWP"){
//       if(!confirm("There is an approval workflow involved to perform this action. Do you want to continue?")){
//           SecurityCheck = "DNL";
         if (ApprovalWFAttachedcontinue == null || ApprovalWFAttachedcontinue == undefined)
            ApprovalWFAttachedcontinue = "There is an approval workflow involved to perform this action. Do you want to continue?";
        if (!confirm(ApprovalWFAttachedcontinue)) {
            SecurityCheck = "DNL";
         return;   
       }
   }
   if (SecurityCheck == "OVW") {
       //alert('You do not have rights to design a published workflow.');
       if (value == "_sys_designworkflow") {
           if (typeof cannotOWVD == "undefined" || cannotOWVD == null || cannotOWVD == undefined)
               cannotOWVD = 'You do not have rights to design a published workflow.';
           se.ui.messageDialog.showAlert(bellyBarTitle, cannotOWVD);
       }
       else if (value == "_sys_edit") {
           if (typeof cannotOWV == "undefined" ||cannotOWV == null || cannotOWV == undefined)
               cannotOWV = 'You do not have rights to edit a published workflow.';
           se.ui.messageDialog.showAlert(bellyBarTitle, cannotOWV);
       }
       else if (value == "_sys_publish") {
           if (cannotOWVP == null || cannotOWVP == undefined)
               cannotOWVP = 'You do not have rights to republish a workflow.';
           se.ui.messageDialog.showAlert(bellyBarTitle, cannotOWVP);
       }
       return;
   }
   if (SecurityCheck == "OWPUBFRM") {
       // alert('You do not have rights to edit a published form.');
       if (value == "_sys_designform") {
           if (typeof cannotOWFD == "undefined" || cannotOWFD == null || cannotOWFD == undefined)
               cannotOWFD = 'You do not have rights to design a published form.';
           se.ui.messageDialog.showAlert(bellyBarTitle, cannotOWFD);
       }
       else if (value == "_sys_edit") {
           if ( typeof cannotOWF == "undefined" || cannotOWF == null || cannotOWF == undefined)
               cannotOWF = 'You do not have rights to edit a published form.';
           se.ui.messageDialog.showAlert(bellyBarTitle, cannotOWF);
       }
       else if (value == "_sys_publish") {
           if (cannotOWFP == null || cannotOWFP == undefined)
               cannotOWFP = 'You do not have rights to republish a form.';
           se.ui.messageDialog.showAlert(bellyBarTitle, cannotOWFP);
       }
       return;
   }
    if(SecurityCheck !== "DNL"){
        if(value == "_sys_showChildItems"){
            var grid = ISGetObject("WebGrid1");
     
            var litemid = ListItemObj.ListItemId;
            grid.AddInput("ParentItemId", litemid);   
            ParentItemId = litemid;

            breadCrumb = parent.parent.breadCrumbTemp + "&nbsp;&nbsp;<img src='"+tempDir+"images/arrow.gif'>&nbsp;&nbsp;<span class='bclinkinact'>"+ SelCellText +"  </span>";
            parent.parent.breadCrumbTemp += "&nbsp;&nbsp;<img src='"+tempDir+"images/arrow.gif'>&nbsp;&nbsp;<a href=\"javascript:NavigateGrid('"+litemid+"','"+parent.parent.cnt+"')\" class='bclink'>"+ SelCellText +"</a>  ";
            parent.parent.breadCrumbArr[parent.parent.cnt] = litemid + "||" + SelCellText;
            parent.parent.cnt++;

            parent.parent.document.getElementById("bcrumb").innerHTML = breadCrumb;
                        
            grid.RefreshAll();
            return;
         }
        else if(type == "ASPXUIAction"){
            if (value == '_sys_delete') {
                var yes = "";
                if (sysDel != undefined) {
                    se.ui.messageDialog.showConfirmation(bellyBarTitle, sysDel, function (userResponse)
                    {
                        if (userResponse)
                        {
                            OpenFile(uri, properties);
                        }
                    });
                }
                else {
                    se.ui.messageDialog.showConfirmation('Are you sure you want to delete?', sysDel, function (userResponse)
                    {
                        if (userResponse)
                        {
                            OpenFile(uri, properties);
                        }
                    });
                }
                //if(!yes)
                //    return;
            }
            
            if(value == "_sys_view_properties"){
                 ShowDetailsPane();
                 return;
             }

            /*if(value == "_sys_saveas_specific_version"  && name !== "subitems"){
                return;
            }*/   
            if (value != '_sys_delete')
            {
                if (value == "_sys_publish" && uri.indexOf("PackageTemplate") == -1)
                {
                    try
                    {
                        parent.parent.CallServerSideMethod(_ListControlName, "PublishListItem", "PublishListItem", PublishResponseCallback, "ListItemDetails", ListItemObj);
                    }
                    catch (err)
                    {
                        if (parent.window.opener.location.href.indexOf("AAAssociation.aspx", 0) != -1)
                        {
                            parent.window.opener.CallServerSideMethod(_ListControlName, "PublishListItem", "PublishListItem", PublishResponseCallback, "ListItemDetails", ListItemObj);
                        }
                    }

                    return;
                }
                if (value == "_sys_unpublish" && uri.indexOf("PackageTemplate") == -1)
                {
                    try
                    {
                        parent.parent.CallServerSideMethod(_ListControlName, "UnpublishListItem", "UnpublishListItem", UnpublishResponseCallback, "ListItemDetails", ListItemObj);
                    }
                    catch (err)
                    {
                        if (parent.window.opener.location.href.indexOf("AAAssociation.aspx", 0) != -1)
                        {
                            parent.window.opener.CallServerSideMethod(_ListControlName, "UnpublishListItem", "UnpublishListItem", UnpublishResponseCallback, "ListItemDetails", ListItemObj);
                        }
                    }

                    return;
                }

                OpenFile(uri, properties);
            }
        }         
        else if(type == "SystemAction"){
            if (value == '_sys_delete') {
                var yes = "";
                if (sysDel != undefined) {
                    se.ui.messageDialog.showConfirmation(bellyBarTitle, sysDel, function (userResponse)
                    {
                        if (userResponse)
                        {
                            SendRequestToServer(value, ListItemObj);
                        }
                    });
                }
                else {
                    se.ui.messageDialog.showConfirmation('Are you sure you want to delete?', sysDel, function (userResponse)
                    {
                        if (userResponse)
                        {
                            SendRequestToServer(value, ListItemObj);
                        }
                    });
                }

                return;
            }
            if(value == "_sys_saveas_specific_version"){
                ListItemObj.SpecificVersionToSave = name; 
            }
            if (value == '_sys_createpackage') {
                var yes = false;
                if (sysCreateTemplate !== undefined) {
                    se.ui.messageDialog.showConfirmation(bellyBarTitle, sysCreateTemplate,
                        function (userResponse) {
                            if (userResponse) {
                                yes = true;
                                SendRequestToServer(value, ListItemObj);
                            }
                        });
                }
                if (!yes)
                    return;
            }
			else
			{
				SendRequestToServer(value, ListItemObj);
			}
        }
    }                      
}

function PublishResponseCallback(context, result, response) 
{
    eval("var publishMessage =" + result);

    for (var key in publishMessage) 
    {
        var message = publishMessage[key]["Message"];
        var title = publishMessage[key]["Name"];
        var msgtype = publishMessage[key]["MessageType"];
    }

    if (message !== "")
    {
        if (msgtype == "information")
        {
            se.ui.messageDialog.showAlert(title, message, function () { RefreshGrid(); });
        }
        else
        {
            se.ui.messageDialog.showError(title, message);
        }
        return;
    }
    else
    {
        OpenFile(uri, properties);
    }
}

function UnpublishResponseCallback(context, result, response)
{
    eval("var unpublishMessage =" + result);

    for (var key in unpublishMessage)
    {
        var message = unpublishMessage[key]["Message"];
        var title = unpublishMessage[key]["Name"];
        var msgtype = unpublishMessage[key]["MessageType"];
    }
    if (message !== "")
    {
        if (msgtype == "information")
        {
            se.ui.messageDialog.showAlert(title, message, function () { RefreshGrid(); });
        }
        else
        {
            se.ui.messageDialog.showError(title, message);
        }
        return;
    }
    else
    {
        OpenFile(uri, properties);
    }
}

// Sending Ajax request to server for actions of type 'SystemAction'
function SendRequestToServer(commandName, parameter)
{
    var o = new Object();
    o["command"] = commandName;
    o["parameter"] = parameter;
     
   var ajaxArgs = parent.parent.stringify(o);
   
   try{
        eval(parent.parent.radAjaxControlId.ajaxRequest(ajaxArgs));
        //RefreshGrid();
        setTimeout("RefreshGrid()",750);
   }
   catch(err){
        alert(err.description );
   }

}

// called from the Ribbon bar actions.
function ExecuteActionByName(actionName){

    //Assigning values to the ListItem object
     var ParentListItemObj = new ListItem();
     ParentListItemObj.ParentItemId = ParentItemId;
     ParentListItemObj.ListItemId = "00000000-0000-0000-0000-000000000000";
     ParentListItemObj.ListId = "00000000-0000-0000-0000-000000000000";
     ParentListItemObj.ActionToRun = actionName;
     ListItemObj.IsVersionGrid = "Y";

     parent.parent.CallServerSideMethod(_ListControlName,"ExecuteAction","ExecuteAction",ProcessAjaxResponse,'ListItemDetails',ParentListItemObj);          
}

// called after recieving the response from the server(for ribbon bar actions).
function ProcessAjaxResponse(context, result, response)
{
    if(result != null && response.Error==false)
     {  	      	        
	        eval("UrlJs="+result);
	        for(var key in UrlJs)
	        {            
	            ExecuteAction(UrlJs[key]["Name"],UrlJs[key]["Value"],UrlJs[key]["Type"],UrlJs[key]["Properties"],UrlJs[key]["Uri"],null);
	        }
	  }
} 

// called from the Ribbon bar actions.
function ExecuteActionForSelectedRow(actionName) {
    if (SelCellText == "") {
        if (wgGetGridById("WebGrid1").GetSelectedObject() != null) {
            var row = wgGetGridById("WebGrid1").GetSelectedObject().GetRowElement();
            var cell = wgGetCellByName(row, "Version");
            if (cell == null) {
                //alert('Please select an item row to perform this action.');
                if (noRowSelected == null || noRowSelected == undefined)
                    noRowSelected = 'Please select an item row to perform this action.';
                alert(noRowSelected);
                return;
            }
            SelCellText = cell.innerText;
        }
    }

//Assigning action value to the ListItem object
   if(SelCellText !== ""){

     ListItemObj.ActionToRun = actionName;
     try { parent.parent.CallServerSideMethod(_ListControlName, "ExecuteAction", "ExecuteAction", ProcessAjaxResponse, 'ListItemDetails', ListItemObj); }
     catch (err) {
         if (parent.window.opener.location.href.indexOf("AAAssociation.aspx", 0) != -1) {
             parent.window.opener.CallServerSideMethod(_ListControlName, "ExecuteAction", "ExecuteAction", ProcessAjaxResponse, 'ListItemDetails', ListItemObj);
         }
     }         
   }
   else{
       if (noRowSelected != undefined)
           alert(noRowSelected); //"Please select an item row to perform this action.");
       else
           alert("Please select an item row to perform this action.");
   }
}

function RefreshGrid()
{
     var grid = ISGetObject("WebGrid1");
     grid.RefreshAll();
     return true;	     
}

function getMaxHeight() {  
    var h=0;  
    if (window.document.innerHeight>h)   
	    h=window.document.innerHeight;  
    if (window.document.documentElement.clientHeight>h)   		

    h=window.document.documentElement.clientHeight;  
    if (window.document.body.clientHeight>h)   
	    h=window.document.body.clientHeight;  

//alert(h); 
return h;

}

function getMaxWidth() {
    var w = 0;

    if (window.document.innerWidth > w)
        w = window.document.innerWidth;
    if (window.document.documentElement.clientWidth > w)

        w = window.document.documentElement.clientWidth;
    if (window.document.body.clientWidth > w)
        w = window.document.body.clientWidth;

    //alert(w); 
    return w;
}

function showTempMessage(type){

  //Checking for Window Size Property
    switch(type)
    {
        case "settings":
            alert("This functionality is currently disabled in beta version.\n From this section there will be option to manage permissions, version settings, add columns, views etc.");
            break;
        case "views":
            alert("This functionality is currently disabled in beta version.\n ");
            break;
        case "archive":
            alert("This functionality is currently disabled in beta version.\n ");
            break;        
        case "deleteall":
            alert("This functionality is currently disabled in beta version.\n ");
            break;       
        case "expire":
            alert("This functionality is currently disabled in beta version.\n ");
            break;                   
    }
    

}

 var isMozilaForGrid = false;

 function resizeOnItemClick(IsSharepoint) {

     var chk = navigator.userAgent;
     if (chk.indexOf("Firefox") > -1) {
         isMozilaForGrid = true;
     }
     else {
         isMozilaForGrid = false;
     }
     
     var grid = wgGetGridById("WebGrid1");
     if (IsSharepoint == "False") {
         if (!isMozilaForGrid) {
             grid.SetHeight("100%");
             grid.LayoutSettings.AutoHeight = false;
         }
         else {
             grid.SetHeight("100%");
             grid.LayoutSettings.AutoHeight = true;
         }
     }
     else {
         grid.LayoutSettings.AutoHeight = true;
         grid.SetHeight("100%");
         //document.getElementById("gridframe").style.overflow = "auto";
     }
}


var MultiSelectLoaderScript = MultiSelectLoaderScript || {};

// Create container called Loader.
MultiSelectLoaderScript.Loader = {
    ShowLoader: function () {
        var loaderDiv = $("#skloader");
        if (loaderDiv[0] === undefined) {
            $(document.body).append('<div id="skloader" class="skloader"></div>');
            loaderDiv = $("#skloader");
        }
        loaderDiv.attr('data-skloader', 1)
        var spinnerObj = new Spinner().spin();
        spinnerObj.el.style.top = "50%";
        spinnerObj.el.style.left = "50%";
        loaderDiv[0].appendChild(spinnerObj.el);
    },

    HideLoader: function (control) {
        var loaderDiv = $("#skloader");
        if (loaderDiv[0] === undefined) {
        }
        else {
            loaderDiv.attr('data-skloader', 0)
        }
    }
}

function MultiSelectOperation(controlId, tblName, colName, checkboxValue, originalCheckBoxValue) {
    var grd = ISGetObject(controlId);
    var checkedRows = grd.RootTable.GetCheckedRows();
    if (checkedRows.length > 0)
    {
        if (typeof (parent.LoadRightActionBarForMultiSelect) != 'undefined') {
            parent.LoadRightActionBarForMultiSelect();
        }
        if (typeof (parent.parent.LoadRightActionBarForMultiSelect) != 'undefined')
            parent.parent.LoadRightActionBarForMultiSelect();
    }
    else
    {
        if (typeof (parent.LoadRightActionBar) != 'undefined') {
            parent.LoadRightActionBar();
        }


        if (typeof (parent.parent.LoadRightActionBar) != 'undefined') {
            parent.parent.LoadRightActionBar();
        }
    }

    return true;
}

function ExecuteActionForMultiSelectedRow(actionName) {
    var grd = ISGetObject('WebGrid1');
    var checkedRows = grd.RootTable.GetCheckedRows();

    if (checkedRows.length > 0)
    {        
        GetMultiSelectListItems(actionName);
    }
    else
    {
        se.ui.messageDialog.showError(bellyBarTitle, noRowSelected);
    }


}

var ListItemArr;
var ListName;
function GetMultiSelectListItems(actionName) {
    ListItemArr = new Array();
    var grd = ISGetObject('WebGrid1');
    var checkedRows = grd.RootTable.GetCheckedRows();

    if (checkedRows.length > 0) {
        
        for (var i = 0; i < checkedRows.length; i++)
        {

            var cell = wgGetCellByName(checkedRows[i], "Version");
            if (cell == null)
                return;
                        
            SelCellText = cell.innerText;
            var Querystringvalues = cell.getAttribute("itemDetails");
            if (Querystringvalues == null) return;
            var QuerystringvaluesArr = Querystringvalues.split(',');
                        
            ListItemObj = new ListItem();
            ListItemObj.ListItemId = QuerystringvaluesArr[0];
            ListItemObj.ListId = QuerystringvaluesArr[1];
            ListItemObj.VersionStamp = SelCellText;
            ListItemObj.ListItemStatus = QuerystringvaluesArr[2];
            ListItemObj.ParentItemId = ParentItemId;
            ListItemObj.IsVersionGrid = "Y";
            ListItemObj.ActionToRun = actionName;
            ListItemObj.ListItemName = QuerystringvaluesArr[4];
            if (QuerystringvaluesArr[5] != null)
                ListName = QuerystringvaluesArr[5];
            ListItemArr.push(ListItemObj);
        }
        MultiSelectLoaderScript.Loader.ShowLoader();
        if (ListName == "Forms List")
        {
            parent.parent.CallServerSideMethod(_ListControlName, "MultiSelectItemsPublishUnpublish", "MultiSelectItemsPublishUnpublish", SetMultiSelectSecurityCheckResponse, 'ListItemDetailsArr', ListItemArr);
        }
        else
        {
            try
            {
                parent.parent.CallServerSideMethod(_ListControlName, "MultiSelectCheckForPausedOrRunningInstances", "MultiSelectCheckForPausedOrRunningInstances", SetMultiSelectResponseForPublishUnpublish, 'ListItemDetailsArr', ListItemArr);
            }
            catch (err)
            {
                if (parent.window.opener.location.href.indexOf("AAAssociation.aspx", 0) != -1)
                {
                    parent.window.opener.CallServerSideMethod(_ListControlName, "MultiSelectCheckForPausedOrRunningInstances", "MultiSelectCheckForPausedOrRunningInstances", SetMultiSelectResponseForPublishUnpublish, 'ListItemDetailsArr', ListItemArr);
                }
            }
        }
    }

}
function SetMultiSelectResponseForPublishUnpublish(context, result, response) {
    var msgBellyTitle;
    var msgBellyMessage;
    MultiSelectLoaderScript.Loader.HideLoader();
    eval("var opResult =" + result);

    for (var key in opResult) {
        var instancesExist = opResult[key]["RunningOrPausedInstancesExist"];
        var actionSelected = opResult[key]["ActionSelected"];
        if (actionSelected == "_sys_publish") {
            msgBellyTitle = belMulResumePublishHead;
            msgBellyMessage = belMulResumePublishMessage;
        }
        else {
            msgBellyTitle = belMulPauseUnPublishHead;
            msgBellyMessage = belMulPauseUnPublishMessage;
        }
        if (instancesExist == true) {
            se.ui.messageDialog.showConfirmation(msgBellyTitle, msgBellyMessage,
                function (userResponse) {
                    if (userResponse) {
                        MultiSelectLoaderScript.Loader.ShowLoader();
                        try
                        {
                            parent.parent.CallServerSideMethod(_ListControlName, "MultiSelectItemsWithPauseOrResume", "MultiSelectItemsWithPauseOrResume", SetMultiSelectSecurityCheckResponse, 'ListItemDetailsArr', ListItemArr);
                        }
                        catch (err)
                        {
                            if (parent.window.opener.location.href.indexOf("AAAssociation.aspx", 0) != -1)
                            {
                                parent.window.opener.CallServerSideMethod(_ListControlName, "MultiSelectItemsWithPauseOrResume", "MultiSelectItemsWithPauseOrResume", SetMultiSelectSecurityCheckResponse, 'ListItemDetailsArr', ListItemArr);
                            }
                        }
                    }
                });
        }
        else {
            MultiSelectLoaderScript.Loader.ShowLoader();
            try
            {
                parent.parent.CallServerSideMethod(_ListControlName, "MultiSelectItemsPublishUnpublish", "MultiSelectItemsPublishUnpublish", SetMultiSelectSecurityCheckResponse, 'ListItemDetailsArr', ListItemArr);
            }
            catch (err)
            {
                if (parent.window.opener.location.href.indexOf("AAAssociation.aspx", 0) != -1)
                {
                    parent.window.opener.CallServerSideMethod(_ListControlName, "MultiSelectItemsPublishUnpublish", "MultiSelectItemsPublishUnpublish", SetMultiSelectSecurityCheckResponse, 'ListItemDetailsArr', ListItemArr);
                }
            }
        }
    }


}

function SetMultiSelectSecurityCheckResponse(context, result, response) {    
    MultiSelectLoaderScript.Loader.HideLoader();
    eval("var opResult =" + result);

    for (var key in opResult) {
        var successItems = opResult[key]["SuccessItems"];
        var failedItems = opResult[key]["FailedItems"];
        var actionSelected = opResult[key]["ActionSelected"];        

        if (actionSelected == "_sys_publish") {

            var pubMsgToShow;

            if (failedItems == "" && successItems != "") {
                pubMsgToShow = (ListName == "Workflow" ? belMulPublishStatusMessage : belMulPublishFormsStatusMessage) + ".";
            }

            if (successItems == "" && failedItems != "") {
                pubMsgToShow = (ListName == "Workflow" ? belMulPublishFailedStatusMessage : belMulPublishFormsFailedStatusMessage) + ": " + failedItems;
            }
            if (successItems != "" && failedItems != "") {
                se.ui.messageDialog.showAlert(belMulPublishStatusHead, (ListName == "Workflow" ? belMulPublishFailedStatusMessage : belMulPublishFormsFailedStatusMessage) + ": " + failedItems);
            }
            else {
                se.ui.messageDialog.showAlert(belMulPublishStatusHead, pubMsgToShow);
            }
        }
        else {

            var unPubMsgToShow;

            if (failedItems == "" && successItems != "") {
                unPubMsgToShow = (ListName == "Workflow" ? belMulUnPublishStatusMessage : belMulUnPublishFormsStatusMessage) + ".";
            }

            if (successItems == "" && failedItems != "") {
                unPubMsgToShow = (ListName == "Workflow" ? belMulUnPublishFailedStatusMessage : belMulUnPublishFormsFailedStatusMessage) + ": " + failedItems;
            }

            if (successItems != "" && failedItems != "") {
                se.ui.messageDialog.showAlert(belMulUnPublishStatusHead, (ListName == "Workflow" ? belMulUnPublishFailedStatusMessage : belMulUnPublishFormsFailedStatusMessage) + ": " + failedItems);
            }
            else {
                se.ui.messageDialog.showAlert(belMulUnPublishStatusHead, unPubMsgToShow);
            }
        }

        var grid = ISGetObject("WebGrid1");
        grid.RefreshAll();
    }
}

function NavigateGrid(ListItemId, cnt) {
    //Passing ParentItemId to access it with Request.Form
    if (ListItemId == '')
        ListItemObj = undefined;  

    CreateBreadCrumbString(cnt, ListItemId);

    window.parent.frameElement.src = templateDirectory+"ListGridPage.aspx?" + urlparams + "&ParentItemId=" + ListItemId;
    var grid = ISGetObject("WebGrid1");
    grid.AddInput("ParentItemId", ListItemId);

    ParentItemId = ListItemId;

    if (cnt == "x")
        grid.RefreshAll();
    else
        grid.RefreshAll();

    return true;
}   

function CreateBreadCrumbString(cntNew, ListItemId) {

    var ctrlId = parent.parent.ListControlClientId;
    var tempDir = parent.parent.directoryForBreadCrumbImage;
    var breadcrumbId = ctrlId + '_ctl00_ctl00_bcrumb';
    var breadCrumbArrNew = new Array(25);
    var breadCrumb1 = "";
    var breadCrumb2 = "";

    if (cntNew !== "x" && cntNew !== 0) {
        breadCrumb = "";
        var bcArr;

        for (var i = 0; i <= 25; i++) {
            try {
                if (typeof(parent.parent.breadCrumbObject[ctrlId + 'Arr']) == 'undefined' || parent.parent.breadCrumbObject[ctrlId + 'Arr'] == null)
                    parent.parent.breadCrumbObject[ctrlId + 'Arr'] = new Array(25);
                bcArr = parent.parent.breadCrumbObject[ctrlId + 'Arr'][i].split('||');
            }
            catch (e) {
                break;
            }

            if (bcArr[0] == ListItemId) {
                breadCrumb1 += "&nbsp;&nbsp;<img src='" + tempDir + "Repository/ListControl/images/arrow.gif'>&nbsp;&nbsp;<span class='bclinkinact'>" + bcArr[1] + " </span>";
                breadCrumb2 += "&nbsp;&nbsp;<img src='" + tempDir + "Repository/ListControl/images/arrow.gif'>&nbsp;&nbsp;<a href=\"javascript:NavigateGrid" + ctrlId + "('" + bcArr[0] + "','" + i + "')\" class='bclink'>" + bcArr[1] + "</a>  ";
                breadCrumbArrNew[i] = bcArr[0] + "||" + bcArr[1];
                break;
            }
            else {
                breadCrumb1 += "&nbsp;&nbsp;<img src='" + tempDir + "Repository/ListControl/images/arrow.gif'>&nbsp;&nbsp;<a href=\"javascript:NavigateGrid" + ctrlId + "('" + bcArr[0] + "','" + i + "')\" class='bclink'>" + bcArr[1] + "</a>  ";
                breadCrumb2 += "&nbsp;&nbsp;<img src='" + tempDir + "Repository/ListControl/images/arrow.gif'>&nbsp;&nbsp;<a href=\"javascript:NavigateGrid" + ctrlId + "('" + bcArr[0] + "','" + i + "')\" class='bclink'>" + bcArr[1] + "</a>  ";
            }

            breadCrumbArrNew[i] = bcArr[0] + "||" + bcArr[1];
        }


        parent.parent.breadCrumbObject[ctrlId + 'Cnt'] = i + 1;
        parent.parent.breadCrumbObject[ctrlId + 'Arr'] = breadCrumbArrNew;
        var bCrumb = parent.parent.document.getElementById(breadcrumbId);  //parent.parent.breadCrumbClientId );
        if (bCrumb != null)
            bCrumb.innerHTML = breadCrumb1;
        parent.parent.breadCrumbObject[ctrlId + 'Crumb'] = breadCrumb2;
    }
    else {
        if (!(ctrlId == undefined || ctrlId == null)) {
            parent.parent.breadCrumbObject[ctrlId + 'Arr'] = breadCrumbArrNew;
            parent.parent.breadCrumbObject[ctrlId + 'Cnt'] = 0;
            parent.parent.breadCrumbObject[ctrlId + 'Crumb'] = "";
            var bCrumb = parent.parent.document.getElementById(breadcrumbId);
            if (bCrumb != null)
                bCrumb.innerHTML = "";
        }
        breadCrumb1 = "";
        ParentItemId = "00000000-0000-0000-0000-000000000000";
    }
}

/*
function NavigateGrid(ListItemId,cnt){
    location.href = "/SkeltaTestApp/BPMUITemplates/Default/Repository/ListControl/Grid.aspx?"+urlparams;
       
}    

*/