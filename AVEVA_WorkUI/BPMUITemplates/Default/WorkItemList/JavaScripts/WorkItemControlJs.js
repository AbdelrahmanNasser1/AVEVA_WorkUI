// JScript File

//Declaration of Variables
var templatedirectory;
var checkreadingpaneflag;
var queuenametoopen;
var workListCtrlName;
var checkTakeOwnerShip;
var checkLeftgridvisibility;
var viewTypeWithoutLeftGrid;
var mywindow;
var imbObj1;
var imbObj2;

//For Localization
var strSaveLayout;
var strDeleteLayout;
var strReassignWorkitem;
var strDelegateWorkitem;
var strSetPriority;
var strHigh;
var strMedium;
var strLow;
var strAccessErrMsg;
var strEnterViewName;
var strAllowRowDoubleClick;

//For Multi Select popup window 
var strMultiSelectInCenter;
var strShowDetailViewWithMultiSelect;

//For localization text for Queue multi select menu
var strPick;
var strPlan;
var strAllocateQueue;
var strRecallItem;
var strNoCheckBoxSelected;
var strSelectallwithingroup;
var strUnSelectallwithingroup;

//Variables Declaration
var strEnableMoveNextPreviousWorkitem;
var strAutoMoveNextWorkItem;
var strInvalidWorkItem;
var checkEnableMultiSelectByDefaultForQueue;

var strNoQueueView;
var EnableSameType;

//Added by Moncy for Queue Detailview
var strQueueDetailView;
var strSelectallSameType;
var strUnselectallSameType;
var nClassicPageNo = 1;
var nNo = 0;

//Localization    
var strSelectRow;
var strMultiSelectTry;
var strMultiSelectDiffActTypes;
var strMultiSelectInforInfoPath;
var strMultiSelectInvFormNotSet;
var strMultiSelectInvFormDiffForms;
var strMultiSelectEnterComments;
var strMultiSelectTryThis;

//For Queue Multi Select

var strbtnPick;
var strbtnPlan;
var strbtnAllocate;
var strbtnRecall;
var strbtnReassign;

var strInvalidActivity;
var strIsClassicPaging;

// For Modal window
var showDetailViewAsModal;

//For Disabling left grid while refresh

var response = true;

var checkQueueLayout;

//For Belly Bar Title
var strMultiSelectQueue;
var strQueueViewTitle;
var strWorkItemTitle;
var strSaveLayoutTitle;
var strDeleteLayoutTitle;
var strLayoutViewNameEmpty;
var strLayoutViewNameExceedLimit;

//For Menu
var strThemeDirectoryPath;


function ResizeFrame() {

    var maintable = document.getElementById("skmaintable");
    var ah = maintable.parentElement.offsetHeight - 5;

    var gridheight = ah * 0.50;
    var frameheight = ah * 0.50;


    var grid = ISGetObject("WebGrid1");
    var i = GetBrowserversion1();

}

//Function used for getting the browser type
function GetBrowserversion1() {

    var app = navigator.userAgent;

    if (app.indexOf("MSIE") > -1) {
        return 3;
    }
    else if (app.indexOf("Firefox/1.5") > -1) {
        return 2;
    }
    else if (app.indexOf("Firefox/") > -1) {
        return 2;
    }
    else if (app.indexOf("Chrome/") > -1)
    {
        return 2;
    }
    else if (app.indexOf("Safari") > -1)
    {
        return 2;
    }
    else {
        return 4;
    }
}

//Function for calling Next Item of the Queue when clicking on GetNextItem button
function CallGetNextItem(appname, qid, uid) {
    url = templatedirectory + "WorkItemList/GetNextQueueItem.aspx";

    var urlparameters = '?Application=' + appname + '&Queueid=' + qid + '&Actorid=' + uid;

    var left = (screen.width / 2) - (340 / 2);
    var top = (screen.height / 2) - (200 / 2);

    mywindow = window.open(url + urlparameters, "GetNextQueueItem", "location=0, status=0, scrollbars=0, width=340, height=200, resizable=yes, top=" + top + ", left=" + left);
    //mywindow.moveTo(0,0);      
    return false;

}

//Function for opening Alternate actor
function CallAlternateActor(appname, uid) {

    url = templatedirectory + "ProcessDesigner/AlternateActor/AlternateActor.aspx";
    var urlparameters = '?ApplicationName=' + appname + '&Actorid=' + uid;

    var left = (screen.width / 2) - (1150 / 2);
    var top = (screen.height / 2) - (550 / 2);


    mywindow = window.open(url + urlparameters, "AlternateActor", "location=0, status=0, scrollbars=0, width=1150, height=550, resizable=no, top="+top+", left="+left);
    //  mywindow.moveTo(0,0);      
    return false;

}

//Function for opening set preferences window
function CallPreferences(appName, uid) {

    url = templatedirectory + "WorkItemList/ChannelPreferences.aspx";
    var urlparameters = '?ApplicationName=' + appName + '&Actorid=' + uid;

    var left = (screen.width / 2) - (600 / 2);
    var top = (screen.height / 2) - (320 / 2);

    mywindow = window.open(url + urlparameters, "Preferences", "location=0, status=0, scrollbars=0, width=600, height=320, resizable=yes, top=" + top + ", left=" + left);
    //  mywindow.moveTo(0,0);      
    return false;
}

//Function for opening the queue control
function CallQueue(appName, uid) {

    url = templatedirectory + "WorkItemList/ShowQueue.aspx";

    var left = (screen.availWidth / 2) - (860 / 2);
    var top = (screen.availHeight / 2) - (600 / 2);

    if (checkViewType == 'Queue')
    {
        var urlparameters;
        if (checkQueueLayout=="False")
            urlparameters = '?ApplicationName=' + appName + '&Actorid=' + uid + '&qName=' + queuenametoopen;
        else
            urlparameters = '?ApplicationName=' + appName + '&Actorid=' + uid;
        mywindow = window.open(url + urlparameters, "Queue", "location=0, status=0, scrollbars=yes, width=900, height=600, resizble=yes, top=" + top + ", left=" + left);  // old value height=560
        // mywindow.moveTo(0,0);      
    }
    else {
        var urlparameters = '?ApplicationName=' + appName + '&Actorid=' + uid;
        mywindow = window.open(url + urlparameters, "Queue", "location=0, status=0, scrollbars=yes, width=900, height=600, resizable=yes,top=" + top + ", left=" + left); // old value height=560
        //  mywindow.moveTo(0,0);  
    }
    return false;

}

//Function for opening the calendar control
function CallCalendar(appName, uid) {

    url = templatedirectory + "WorkItemList/ShowResourceCalendar.aspx";
    var urlparameters = '?ApplicationName=' + appName + '&Actorid=' + uid;

    var left = (screen.availWidth / 2) - (900 / 2);
    var top = (screen.availHeight / 2) - (580 / 2);

    mywindow = window.open(url + urlparameters, "ResourceCalendar", "location=0, status=0, scrollbars=0, width=900, height=580, resizable=yes, top=" + top + ", left=" + left);
    // mywindow.moveTo(0,0);      
    return false;

}

//Function  to Enable GroupUI on click of enablegroupui icon 
//This method is changed for Web part integration as when we place the 
//two workitemcontrol web part in the same page the ids are conflicting so we are 
//passing the clientIds
function EnablecheckGroupUI(leftgridId, rightgridId, imgCheck1id, imgCheck2id) {

    if (typeof (document.getElementById("divDocView")) != 'undefined') {
        if (document.getElementById("divDocView") != null) {
            document.getElementById("divDocView").style.visibility = 'hidden';

        }
    }

    if (mywindow != null) {
        mywindow.close();
    }

    if (GetRadWindow() != 'undefined' && GetRadWindow() != null) {
        closeRadWindow();
    }

    //checking for the row selection in the left menu
    var gridobj = ISGetObject(leftgridId);

    if (typeof (gridobj) != 'undefined') {
        var row = gridobj.GetSelectedObject().GetRowElement();

        if (row != null) {
            var cell = wgGetCellByName(row, "Name");
            if (cell == null) return;
            checkViewTypeArr = cell.getAttribute("hiddenViewType");
            if (checkViewTypeArr != null) {
                var QuerystringvaluesArr = checkViewTypeArr.split(',');
                var chkview = QuerystringvaluesArr[0];

            }
        }
    }

    var grid = ISGetObject(rightgridId);
    var btnvalue = "Enable Multi Select";


    imbObj1 = document.getElementById(imgCheck1id);
    imbObj2 = document.getElementById(imgCheck2id);
    if (imbObj1.style.display == "none") {
        btnvalue = "Disable Multi Select";
        document.getElementById("divGroupSelectionEnabledCheckBox").style.visibility = 'hidden';
        document.getElementById("GroupSelectionEnabledCheckBox").checked = false;

        var gridDetailsId = rightgridId.replace("WebGrid1", "GridDetailsTD");
        if (gridDetailsId != null) {
            var frameel = document.getElementById(gridDetailsId).getElementsByTagName("iframe")[0];
            if (typeof (frameel) != 'undefined') {
                if (frameel.style.display == "block") {
                    frameel.style.display = 'none';
                    frameel.style.visibility = 'hidden';
                }
            }
        }
        else {
            if (typeof (document.getElementById("opengroupuiframe")) != 'undefined') {
                if (document.getElementById("opengroupuiframe").style.display == "block") {
                    document.getElementById("opengroupuiframe").style.display = 'none';
                    document.getElementById("opengroupuiframe").style.visibility = 'hidden';
                }
            }
        }

        //For getting the Multi Select for Queue from the hidden variable because of the functionality of 
        //multiple workitemlist Webparts in the same page         
        var hidCheckDefaultQueueMultiSelectId = leftgridId.replace("grdLeftMenu", "hdnEnableQueueMultiSelectbyDefault");
        var hidCheckDefaultQueueMultiSelectIdValue = document.getElementById(hidCheckDefaultQueueMultiSelectId).value;

        if (hidCheckDefaultQueueMultiSelectIdValue != "")
            checkEnableMultiSelectByDefaultForQueue = hidCheckDefaultQueueMultiSelectIdValue;


        if (checkEnableMultiSelectByDefaultForQueue == "False") {
            var multiqueoptid = imgCheck1id.replace("imgCheck1", "multiselectqueueoptions");
            document.getElementById(multiqueoptid).style.display = 'none';
            document.getElementById(multiqueoptid).style.visibility = 'hidden';
            
        }
    }
    else {
        btnvalue = "Enable Multi Select";
        var grid = ISGetObject(rightgridId);

        var rootTable = grid.RootTable;
        var groupRows = rootTable.GetGroupRows();


        if (groupRows != null && groupRows.length > 0) {
            //document.getElementById("divGroupSelectionEnabledCheckBox").style.visibility='visible';
            document.getElementById("divGroupSelectionEnabledCheckBox").style.visibility = 'hidden';
            document.getElementById("divGroupSelectionEnabledCheckBox").style.display = 'none';
        }
    }

    //For getting the Row double click property from the hidden variable because of the functionality of 
    //multiple workitemlist Webparts in the same page         
    var hidCheckRowDblClickId = leftgridId.replace("grdLeftMenu", "hdnRowDoubleClick");
    var hidCheckRowDblClickIdValue = document.getElementById(hidCheckRowDblClickId).value;

    if (hidCheckRowDblClickIdValue != "")
        strAllowRowDoubleClick = hidCheckRowDblClickIdValue;

    //For getting the Showing detail window with multi select property from the hidden variable because of the functionality of 
    //multiple workitemlist Webparts in the same page         
    var hidShowDetailsWindowMultiSelectId = leftgridId.replace("grdLeftMenu", "hdnDetailViewwithMultiSelect");
    var hidShowDetailsWindowMultiSelectIdValue = document.getElementById(hidShowDetailsWindowMultiSelectId).value;

    if (hidShowDetailsWindowMultiSelectIdValue != "")
        strShowDetailViewWithMultiSelect = hidShowDetailsWindowMultiSelectIdValue;




    grid.AddInput("GroupFlag", btnvalue);
    if (btnvalue == "Disable Multi Select") {
        if (strAllowRowDoubleClick == "False")
            grid.LayoutSettings.ClientSideEvents.OnRowSelect = 'callajaxforautoownership("' + rightgridId + '")';
        else
            grid.LayoutSettings.ClientSideEvents.OnCellDblClick = 'callajaxforautoownership("' + rightgridId + '")';

        imbObj1.style.position = "relative";
        imbObj1.style.cssFloat = "right";
        imbObj1.style.display = "block";
        imbObj2.style.display = "none";

    }
    else {
        if (strShowDetailViewWithMultiSelect == "False") {
            if (strAllowRowDoubleClick == "False")
                grid.LayoutSettings.ClientSideEvents.OnRowSelect = "";
            else
                grid.LayoutSettings.ClientSideEvents.OnCellDblClick = "";

        }
        else {
            if (strAllowRowDoubleClick == "False")
                grid.LayoutSettings.ClientSideEvents.OnRowSelect = 'callajaxforautoownership("' + rightgridId + '")';
            else
                grid.LayoutSettings.ClientSideEvents.OnCellDblClick = 'callajaxforautoownership("' + rightgridId + '")';
        }
        imbObj2.style.position = "relative";
        imbObj2.style.display = "block";
        imbObj2.style.visibility = "visible";
        imbObj2.style.cssFloat = "right";
        imbObj1.style.display = "none";

    }
    grid.AddInput("ISMultiSelectQueue", "");
    grid.SendCustomRequest();


}

//Maintained for backward compatibility as the checkbox is now hidden
//option of selecting all checkbox within group
//This method is changed for Web part integration as when we place the 
//two workitemcontrol web part in the same page the ids are conflicting so we are 
//passing the clientIds and replacing the id with the respective control names
function EnableGroupCheckBox(gridId) {
    var imgCheck1id = gridId.replace("WebGrid1", "imgCheck1");
    imbObj1 = document.getElementById(imgCheck1id);

    if (imbObj1 != null) {
        if (imbObj1.style.display == "none") {
            document.getElementById("divGroupSelectionEnabledCheckBox").style.visibility = 'hidden';
            document.getElementById("divGroupSelectionEnabledCheckBox").style.display = 'none';
        }
    }

}

//Maintained for backward compatibility as the checkbox is now hidden for the 
//option of selecting all checkbox within group
//This method is changed for Web part integration as when we place the 
//two workitemcontrol web part in the same page the ids are conflicting so we are 
//passing the clientIds and replacing the id with the respective control names
function DisableGroupCheckBox(gridId) {

    var imgCheck1id = gridId.replace("WebGrid1", "imgCheck1");
    imbObj1 = document.getElementById(imgCheck1id);

    if (imbObj1 != null) {
        if (imbObj1.style.display == "none") {
            document.getElementById("divGroupSelectionEnabledCheckBox").style.visibility = 'hidden';
            document.getElementById("GroupSelectionEnabledCheckBox").checked = false;
        }
    }

}

//Maintained for backward compatibility as the checkbox is now hidden
//option of selecting all checkbox within group
//This method is changed for Web part integration as when we place the 
//two workitemcontrol web part in the same page the ids are conflicting so we are 
//passing the imgCheck1 clientId
function EnableSelectAllGroupCheckbox(controlId) {

    var imbObj1 = document.getElementById(controlId);
    if (imbObj1 != null) {
        if (imbObj1.style.display == "none") {
            //document.getElementById("divGroupSelectionEnabledCheckBox").style.visibility='visible';
            document.getElementById("divGroupSelectionEnabledCheckBox").style.visibility = 'hidden';
            document.getElementById("divGroupSelectionEnabledCheckBox").style.display = 'none';
        }
    }

}

//Maintained for backward compatibility as the checkbox is now hidden
//option of selecting all checkbox within group 
//This method is changed for Web part integration as when we place the 
//two workitemcontrol web part in the same page the ids are conflicting so we are 
//passing the imgCheck1 clientId
function DisableSelectAllGroupCheckbox(controlId) {
    var imbObj1 = document.getElementById(controlId);
    if (imbObj1 != null) {
        if (imbObj1.style.display == "none") {
            document.getElementById("divGroupSelectionEnabledCheckBox").style.visibility = 'hidden';
        }
    }
}





//Initialization of Left Hand Side grid for Selection of Workitem List Node and expanding 
//the Workitem List Node. 
var lastselectedrowkey;
var lastselectedrowkey1;

var calledFromOnInitArray = new Array();
function grdLeftMenu_Init(gridId) {

    //globalLeftGridId=gridId;	
    var grdLeftMenu = ISGetObject(gridId);
    grdLeftMenu.GetRootTable().GetElement(WG40.BODY, WG40.HTMLTABLE).style.padding = "2px"; // give some room between frame and contents
    wgExpandSelfRefRow(grdLeftMenu.GetRootTable().GetElement(WG40.BODY, WG40.HTMLTABLE).rows[0]); // always expand First Item 
    wgExpandSelfRefRow(grdLeftMenu.GetRootTable().GetElement(WG40.BODY, WG40.HTMLTABLE).rows[1]);

    var initrow = grdLeftMenu.RootTable.GetElement(WG40.BODY, WG40.HTMLTABLE).rows[0];
    if (typeof (initrow) != 'undefined') {

        var initselecting = grdLeftMenu.RootTable.ToRowObject(grdLeftMenu.RootTable.GetElement(WG40.BODY, WG40.HTMLTABLE).rows[0]);
       // if (strIsClassicPaging == "False") {
            calledFromOnInitArray[gridId] = "yes";
            //window.setTimeout(function() { try { initselecting.Select(); } catch (e) { } }, 1000);
            try { initselecting.Select(); } catch (e) { };

      //  }
        
    }


}




//Function call for Selection of the row in the LHS Grid 
//This method is changed for Web part integration as when we place the 
//two workitemcontrol web part in the same page the ids are conflicting so we are 
//getting the left grid clientId and replacing with right grid for getting right grid clientid
var checkViewType = "Inbox";

function grdLeftMenu_RowSelect(gridId, tblName, rowIndex, rowElm)
{

    var checkleftgrid = ISGetObject(gridId);
    var rightGrid = gridId.replace("grdLeftMenu", "WebGrid1");
    var grdDetails = ISGetObject(rightGrid);

    //var grdDetails = ISGetObject("WebGrid1");
    if (grdDetails == null) {
        calledFromOnInitArray[gridId] = "no";
        return;
    }

    var row = ISGetObject(gridId).GetSelectedObject().GetRowElement();
    var key = rowElm.keyValue;

    var cell = wgGetCellByName(row, "Name");

    var checkForCustomLink = cell.getAttribute("hiddenCustomLink");

    var gridDetailsId = gridId.replace("grdLeftMenu", "GridDetailsTD");

    if (checkForCustomLink == null) {

        if (key != "1") {
            checkViewTypeArr = cell.getAttribute("hiddenViewType");
            var QuerystringvaluesArr = checkViewTypeArr.split(',');
            checkViewType = QuerystringvaluesArr[0];

            var qname = QuerystringvaluesArr[4];
            queuenametoopen = qname;

            checkQueueLayout = QuerystringvaluesArr[6];
            
        }
        if (key == "1") {
            checkViewType = "Inbox";
        }
        
        if (checkViewType == "Workflow" || checkViewType == "") return;

        if (typeof (document.getElementById("divDocView")) != 'undefined') {
            if (document.getElementById("divDocView") != null) {
                document.getElementById("divDocView").style.visibility = 'hidden';

            }
        }
        if (gridDetailsId != null) {
            var frameel = document.getElementById(gridDetailsId).getElementsByTagName("iframe")[0];
            if (typeof (frameel) != 'undefined') {
                if (frameel.style.display == "block") {
                    frameel.style.display = 'none';
                    frameel.style.visibility = 'hidden';
                }
            }
        }
        else {
            if (typeof (document.getElementById("opengroupuiframe")) != 'undefined') {
                if (document.getElementById("opengroupuiframe").style.display == "block") {
                    document.getElementById("opengroupuiframe").style.display = 'none';
                    document.getElementById("opengroupuiframe").style.visibility = 'hidden';
                }
            }
        }

        grdDetails.AddInput("ViewType", checkViewType);


        //For getting the Showing detail window with multi select property from the hidden variable because of the functionality of 
        //multiple workitemlist Webparts in the same page         
        var hidEnableMoveNextId = gridId.replace("grdLeftMenu", "hdnEnableMoveNext");
        var hidEnableMoveNextIdValue = document.getElementById(hidEnableMoveNextId).value;

        if (hidEnableMoveNextIdValue != "")
            strEnableMoveNextPreviousWorkitem = hidEnableMoveNextIdValue;

        //For getting the Showing detail window with multi select property from the hidden variable because of the functionality of 
        //multiple workitemlist Webparts in the same page         
        var hidAutoNextId = gridId.replace("grdLeftMenu", "hdnAutoMove");
        var hidAutoNextIdValue = document.getElementById(hidAutoNextId).value;

        if (hidAutoNextIdValue != "")
            strAutoMoveNextWorkItem = hidAutoNextIdValue;


        if (strEnableMoveNextPreviousWorkitem == "False" || strAutoMoveNextWorkItem == "False")
            grdDetails.ClearSelectedObject();



        document.getElementById(gridDetailsId).style.visibility = 'visible';
        document.getElementById("CustomLink").style.visibility = 'hidden';


        //Added for Not refreshing the details grid on rowcontext menu for save layout.		
        if ((IS.ie && (event != null && event.button == "2")) || (!IS.ie && (typeof (event) != undefined && event.button == "2"))) {

        }
        else {

            if (calledFromOnInitArray[gridId] == "no" || typeof (calledFromOnInitArray[gridId]) == 'undefined')
            {
                window.setTimeout(function () { grdDetails.RefreshAll(); }, 10);             
            }

            // Commented due to column size fit, In case of More Characters in Subject
            //if (calledFromOnInitArray[gridId] = "yes") {
            //    var prodColumn = grdDetails.RootTable.Columns.GetNamedItem("Subject");
            //    try {
            //        prodColumn.ResizeBestFit();
            //    }
            //    catch (err) {

            //    }

            //}

        }


        calledFromOnInitArray[gridId] = "no";
        var multiselectqueueoptionsid = gridId.replace("grdLeftMenu", "multiselectqueueoptions");

        //For getting the Multi Select for Queue from the hidden variable because of the functionality of 
        //multiple workitemlist Webparts in the same page         
        var hidCheckDefaultQueueMultiSelectId = gridId.replace("grdLeftMenu", "hdnEnableQueueMultiSelectbyDefault");
        var hidCheckDefaultQueueMultiSelectIdValue = document.getElementById(hidCheckDefaultQueueMultiSelectId).value;

        if (hidCheckDefaultQueueMultiSelectIdValue != "")
            checkEnableMultiSelectByDefaultForQueue = hidCheckDefaultQueueMultiSelectIdValue;



        if (checkViewType == "Queue") {

            var imgCheck1id = gridId.replace("grdLeftMenu", "imgCheck1");
            imbObj1 = document.getElementById(imgCheck1id);
            if (imbObj1 != null) {
                if (imbObj1.style.display == "") {
                    if (checkEnableMultiSelectByDefaultForQueue == "False") {
                        document.getElementById(multiselectqueueoptionsid).style.display = 'none';
                        document.getElementById(multiselectqueueoptionsid).style.visibility = 'hidden';
                    }

                }

            }

        }

        else {
            if (document.getElementById(multiselectqueueoptionsid) != null) {
                document.getElementById(multiselectqueueoptionsid).style.display = 'none';
                document.getElementById(multiselectqueueoptionsid).style.visibility = 'hidden';
            }

        }

    }
    else {
        //For Showing the Custom Page on click of the Custom Link shown in the LHS grid.
        var CustomLinkUrlValue = cell.getAttribute("hiddenCustomLink");
        if (CustomLinkUrlValue != "") {
            document.getElementById(gridDetailsId).style.visibility = 'hidden';

            var left = findClientPosX(document.getElementById(gridDetailsId));
            var top = findClientPosY(document.getElementById(gridDetailsId));


            var h = document.getElementById(gridDetailsId).offsetHeight;
            var w = document.getElementById(gridDetailsId).offsetWidth;



            var frameel = document.getElementById("CustomLink");
            frameel.style.left = w - (77 / 100 * w) + "px";
            frameel.style.top = top - 110 + "px";
            frameel.style.width = w + "px";
            frameel.style.height = h + "px";
            frameel.style.display = "block";
            frameel.style.visibility = "visible";

            //To Avoid the Custom link Resizing in master page if we give the List as custom link
            if (CustomLinkUrlValue.indexOf('?') >= 0) {
                CustomLinkUrlValue += '&viewfromworkitem=yes';
            }
            else {
                CustomLinkUrlValue += '?viewfromworkitem=yes';
            }
            frameel.src = CustomLinkUrlValue;

        }
        //for hiding the Multi select queue buttons
        var multiselqueueoptid = gridId.replace("grdLeftMenu", "multiselectqueueoptions");
        if (document.getElementById(multiselectqueueoptionsid) != null) {
            document.getElementById(multiselqueueoptid).style.display = 'none';
            document.getElementById(multiselqueueoptid).style.visibility = 'hidden';
        }

    }
    return true;
}

function getRelativeObj(obj) {
    var curleft = 0;
    var relativeFound = 0;
    if (obj.offsetParent) {
        while (obj.offsetParent) {
            var check = getComputedStyle(obj).position;
            if (check != null && check.toLowerCase() == 'relative' && relativeFound == 0) {
                return obj;
            }
            obj = obj.offsetParent;
        }
    }

    return null;
}

/* Changes For building the context menu based on  Ajax Call */

function findClientPosX(obj) {
    var curleft = 0;
    var relativeFound = 0;
    if (obj.offsetParent) {
        while (obj.offsetParent) {
            var check = getComputedStyle(obj).position;
            if (check != null && check.toLowerCase() == 'relative' && relativeFound == 0) {
                curleft = obj.offsetLeft;
                relativeFound = 1;
            }
            else {
                curleft += obj.offsetLeft;
            }
            obj = obj.offsetParent;
        }
    }
    else if (obj.x) {
        curleft += obj.x;
    }

    return curleft;
}

function findClientPosY(obj) {
    var curtop = 0;
    var relativeFound = 0;
    if (obj.offsetParent) {
        while (obj.offsetParent) {
            var check = getComputedStyle(obj).position;
            if (check != null && check.toLowerCase() == 'relative' && relativeFound == 0) {
                curtop = obj.offsetTop;
                relativeFound = 1;
            }
            else {
                curtop += obj.offsetTop;
            }

            obj = obj.offsetParent;
        }
    }
    else if (obj.y) {
        curtop += obj.y;
    }
    
    return curtop;
}


/* Changes For building the context menu based on  Ajax Call */



//Function for displaying context menu for the LHS grid	
//This method is changed for Web part integration as when we place the 
//two workitemcontrol web part in the same page the ids are conflicting so we are 
//getting the left grid clientId 
function grdLeftMenu_OnRowContextMenu(gridId, rowType, rowEl, rowMenu) {

    var i;
    var grid = ISGetObject(gridId);
    var imgfolder = templatedirectory + "WorkItemList/Images/";

    if (rowType != "Record") return true;

    if (rowType == "Record") {
        // hide the default context menu
        for (i = 0; i <= 43; i++) {
            //rowMenu.Items[i].visible = false;
            rowMenu.Items[i].Hide();

        }

    }

    //Not to display menus on right click of workitems list
    var key = rowEl.keyValue;
    if (key == "1" || key.indexOf("_") >= 0) return false;

    //Not to display menus on right click of workitems list

    var row = ISGetObject(gridId).GetSelectedObject().GetRowElement();

    var cell = wgGetCellByName(row, "Name");
    checkViewTypeArr = cell.getAttribute("hiddenViewType");
    var QuerystringvaluesArr = checkViewTypeArr.split(',');
    var viewype = QuerystringvaluesArr[0];
    var appname = QuerystringvaluesArr[1];
    var wfname = QuerystringvaluesArr[2];
    var id = QuerystringvaluesArr[3];
    var checkpersonallayout = QuerystringvaluesArr[6];

    if (viewype == "" || viewype == "Workflow" )
    {

    }
    else if (checkpersonallayout == 'False') {
        var menuItem = new WebMenuItem();
        menuItem.Text = strSaveLayout;
        menuItem.Name = "MyMenu";
        menuItem.OnClick = "SaveLayout('" + viewype + "','" + wfname + "','" + id + "','" + appname + "','" + gridId + "')";
        rowMenu.Items.Add(menuItem);
        //rowMenu.add(new MenuItem("&nbsp;"+strSaveLayout,function() {SaveLayout(viewype,wfname,id,appname)},"" ));

    }
    /// Refer
    if (checkpersonallayout == 'True') {
        var menuItem = new WebMenuItem();
        menuItem.Text = strDeleteLayout;
        menuItem.Name = "MyMenu";
        menuItem.OnClick = "DeleteLayout('" + id + "','" + gridId + "')";
        //menuItem.ImageURL=imgfolder+"wg_PageSize.gif";    
        //rowMenu.add(new MenuItem("&nbsp;"+strDeleteLayout,function() {DeleteLayout(id)},"" ));
        rowMenu.Items.Add(menuItem);
    }
    return true;
}

//Function which gets called when Save Layout is clicked from the Context menu of LHS grid.
//This method is changed for Web part integration as when we place the 
//two workitemcontrol web part in the same page the ids are conflicting so we are 
//getting the left grid clientId and replacing with right grid for getting right grid clientid
function SaveLayout(viewtype, wfname, id, appname, gridId) {

    var grid = ISGetObject(gridId);
    var viewname = window.prompt(strEnterViewName, "");

    if (viewname == null || viewname == "") {
        ShowBellyBarErrorMessage(strSaveLayout, strLayoutViewNameEmpty);
        return false;
    }
    else if (viewname.length > 50)
    {
        ShowBellyBarErrorMessage(strSaveLayout, strLayoutViewNameExceedLimit);
        return false;
    }
    else {
        viewname = trimstring(viewname);
    }
    if (wfname != "") {
        grid.AddInput("WorkflowNametosave", wfname);
        grid.AddInput("ViewTypetoSave", wfname + "_" + viewtype);
    }
    else {
        grid.AddInput("ViewTypetoSave", appname + "_" + viewtype);

    }
    grid.AddInput("ParentIdtomap", id);
    grid.AddInput("ViewNametoSave", viewname);
    grid.AddInput("SaveViewflag", "Yes");
    grid.AddInput("Deleteflag", "No");
    grid.SendCustomRequest();
}

//function used for trimming the string
function trimstring(str) {
    var trimmedstring = str.replace(/^\s+|\s+$/g, '');
    return trimmedstring;
}

//Function called when delete layout is called from DeleteLayout option 
//from the Context menu of LHS grid
//This method is changed for Web part integration as when we place the 
//two workitemcontrol web part in the same page the ids are conflicting so we are 
//getting the left grid clientId and replacing with right grid for getting right grid clientid
var checkDeleteLayouflag = 'False';
function DeleteLayout(id, gridId) {
    checkDeleteLayouflag = 'True';
    var grid = ISGetObject(gridId);
    grid.AddInput("SaveViewflag", "No");
    grid.AddInput("Deleteflag", "Yes");
    grid.AddInput("Idtodelete", id);
    grid.SendCustomRequest();

}

//Function used to open Workitem detail view in a Separate window as modal popup
function OpenWorkItemInWindow(url, popupName, popupFeatures)
{
    if (showDetailViewAsModal == "True")
    {        
        var oManager = parent.parent.GetRadWindowManager();
        var oWindow = oManager.getWindowByName("PackageWindow");
        oWindow.setSize(850, 640);
        var partsOfpopupFeatures = popupFeatures.split(',');
        for (var i = 0; i < partsOfpopupFeatures.length; i++) {
            var keyValuePair = partsOfpopupFeatures[i].split('=');
            
            if (trimstring(keyValuePair[0]) == "width") {                
                oWindow.set_width(trimstring(keyValuePair[1]));
            }
            if (trimstring(keyValuePair[0]) == "height") {
                oWindow.set_height(trimstring(keyValuePair[1]));
            }
        }
        if (popupName == "")
            popupName = "WorkitemDetailWindow";
        oWindow.set_title(popupName);  
        oWindow.setUrl(url);
        oWindow.show();
    }
    else
    {
        var detWidth = 850;
        var detHeight = 620;

        if (navigator.userAgent.indexOf("Firefox") > -1)
        {
            detHeight = 630;
        }

        var left = (screen.width / 2) - (detWidth / 2);
        var top = (screen.height / 2) - (detHeight / 2);
        
        mywindow = window.open(url, (popupName && popupName != "") ? popupName : "WorkitemDetailWindow", (popupFeatures && popupFeatures != "") ? popupFeatures : "location=0, status=0, scrollbars=1, width="+detWidth+", height="+detHeight+",resizable=yes,left=" + left + ",top=" + top);
        
        
    }    return false;
}

// Function to get the instance of the WorkItem Detail View modal window
function GetRadWindow() {
    var oWindow = null;
    if (GetRadWindowManager() != 'undefined' &&
        GetRadWindowManager() != null &&
        GetRadWindowManager().getWindowByName('PackageWindow') != 'undefined' &&
        GetRadWindowManager().getWindowByName('PackageWindow') != null) {
            oWindow = GetRadWindowManager().getWindowByName('PackageWindow');
    }
    return oWindow;
}

// Function to close the  WorkItem Detail View modal popup
function closeRadWindow() {
    var oWnd = GetRadWindow();
    oWnd.close();
    if (navigator.userAgent.toLowerCase().indexOf('chrome') > 0 || navigator.userAgent.toLowerCase().indexOf('firefox') > 0) {
        document.body.style.overflow = "hidden";
    }
}

//Function used to open Workitem detail view in Preview Pane
function OpenWorkItemInPreviewPane(url) {

    var dvCnt = document.getElementById("divDocView");

    dvCnt.style.visibility = "visible";
    dvCnt.style.display = "block";

    document.getElementById("docframe").src = url;

    return false;
}

//Function used to open the Workitem detail view in Hidden Iframe   
function OpenWorkItemInHiddenIframe(url) {

    url = templatedirectory + "WorkItemList/" + url;
    document.getElementById("opennonweb").src = url;
    return false;
}




//Variables used for context menu

var CurrentUrlJs = null;
var CurrentQueueUrlJs = null;
var CheckForwardingAllowed = false;
var menuXpos = 0;
var menuYpos = 0;

//GridId variables stored on context menu operation so that this will be available 
//in the Ajax call back functions

var rightgridIdForContextMenu = "";
var menuObject;

//Function for building the context menu for RHS Grid
//This method is changed for Web part integration as when we place the 
//two workitemcontrol web part in the same page the ids are conflicting so we are 
//getting the getting right grid clientid and assigned to a variable rightgridIdForContextMenu so that this
//is getting used in contextmenu related operations
function WebGrid1_OnRowContextMenu(gridId, rowType, rowEl, rowMenu, location) {
    
    rightgridIdForContextMenu = gridId;
    menuObject = rowMenu;
    
    var i;
    var grid = ISGetObject(gridId);
    var imgfolder = templatedirectory + "WorkItemList/Images/";

    //For getting the workitemcontrol id from the hidden variable because of the functionality of 
    //multiple workitemlist Webparts in the same page         
    var hidWorkItemControlId = gridId.replace("WebGrid1", "hdnWorkitemControlid");
    var hidWorkItemControlIdValue = document.getElementById(hidWorkItemControlId).value;

    if (hidWorkItemControlIdValue != "")
        workListCtrlName = hidWorkItemControlIdValue;



    if (rowType != "Record") {
        if (rowType == "FilterRow") {
            rowMenu.Items.GetNamedItem("mnuHelp").Hide();
        }

        if (rowType == "GroupHeader") //For GroupHeader context menu
        {
            rowMenu.Items.GetNamedItem("mnuCopyRow").Hide();
            rowMenu.Items.GetNamedItem("mnuSep3").Hide();
            rowMenu.Items.GetNamedItem("mnuHelp").Hide();
            rowMenu.Items.GetNamedItem("mnuSep9").Hide();
        }
        return true;
    }

    if (rowType == "Record") {
        // hide the default context menu
        for (i = 0; i <= 43; i++) {
            rowMenu.Items[i].Hide();
        }

    }

    
    
    menuXpos = location.X;
    menuYpos = location.Y;
        
    if (navigator.userAgent.indexOf("Edge") > -1) {
        
        menuYpos += 70; 
    }

    //Added for the new logic of building the url and context menu for each row.

    var row = ISGetObject(gridId).GetSelectedObject().GetRowElement();
    var cell = wgGetCellByName(row, "Subject");
    if (cell == null)
        return;

    //For getting the Workflowname,Workitemid and Applicationname

    var Querystringvalues = cell.getAttribute("details");
    var QuerystringvaluesArr = Querystringvalues.split(',');

    CheckForwardingAllowed = QuerystringvaluesArr[0];
    var workItemObj = new WorkItem();
    workItemObj.ApplicationName = QuerystringvaluesArr[1];
    workItemObj.WorkFlowName = QuerystringvaluesArr[2];
    workItemObj.WorkItemId = QuerystringvaluesArr[3];
    workItemObj.FormNames = QuerystringvaluesArr[4];
    workItemObj.ActivityType = QuerystringvaluesArr[5];


    //Ajax call for building the context menu when we do right click on Inbox items on the details grid
    if (checkViewType == "Inbox") {
        CallServerSideMethod(workListCtrlName, 'BuildForInboxView', "BuildURLCondition", BuildInboxViewRowContextMenu, 'table', workItemObj);
    }
    //Ajax call for building the context menu when we do right click on Manager view items on the details grid
    else if (checkViewType == "Manager View") {
        CallServerSideMethod(workListCtrlName, 'BuildForManagerView', "BuildURLCondition", BuildManagerViewContextMenu, 'table', workItemObj);
    }
    //Ajax call for building the context menu when we do right click on Queue items on the details grid
    else if (checkViewType == "Queue" && strQueueDetailView != "False") {

        CallServerSideMethod(workListCtrlName, 'BuildForFormsQueueView', "BuildURLCondition", BuildQueueContextMenu, 'table', workItemObj);
    }
    //Ajax call for building the context menu when we do right click on Queue items on the details grid
    else if (checkViewType == "Queue" && strQueueDetailView == "False") {
        CallServerSideMethod(workListCtrlName, 'BuildForQueueView', "BuildURLCondition", BuildQueueContextMenu, 'table', workItemObj);

    }    
    return true;
}

//Function added by moncy for selecting the activities of same type through the context menu 
//This method is changed for Web part integration as when we place the 
//two workitemcontrol web part in the same page the ids are conflicting so we are 
//getting the getting right grid clientid from the variable rightgridIdForContextMenu 
function selectallsametypes() //Method added by MP
{

    var rightgridId = rightgridIdForContextMenu;
    if (rightgridId == "") {
        rightgridId = "WebGrid1";
    }


    setflag = 0;
    reselect = 0;

    document.getElementById("GroupSelectionEnabledCheckBox").checked = true;
    var Trow = wgGetGridById(rightgridId).GetSelectedObject().GetRowElement();
    var Tcell = wgGetCellByName(Trow, "Subject");
    if (Tcell == null)
        return;
    //For getting the Workflowname,Workitemid and Applicationname
    var Querystringvalues = Tcell.getAttribute("details");
    var QuerystringvaluesArr = Querystringvalues.split(',');
    var CompValue = QuerystringvaluesArr[4].split(';');
    var CompValue = CompValue[0];

    var grd = wgGetGridById(rightgridId);   //ISGetObject
    var rows = grd.RootTable.GetElement(WG40.BODY, WG40.HTMLTABLE).getElementsByTagName("tr");

    var RowsCount = grd.RootTable.Grid.TotalRows;
    for (var i = 0; i < rows.length; i++) {


        if (rows[i].type == "Record") {
            var TCell = grd.GetRowByElement(rows[i]).GetCell("Subject").CellElement;
            var TValue = TCell.getAttribute("details");
            if (TValue == null)
                continue;
            var Query = TValue.split(',');
            var FQuery = Query[4].split(';');
            var RValue = FQuery[0];

            if (RValue == CompValue) {

                var cells = grd.GetRowByElement(rows[i]).GetCell(0).CellElement;
                cells.childNodes[0].checked = true;
                var childRow = grd.RootTable.GetRow(i);
                if (childRow != null)
                    childRow.Check();
                var selecting = grd.RootTable.ToRowObject(grd.RootTable.GetElement(WG40.BODY, WG40.HTMLTABLE).rows[i]);
                selecting.Select();
                callajaxonotherselectedcheckboxclick(rightgridId);

            }

        }

    }



}

//Function added by moncy for unselecting all the similar activities through the context menu
//This method is changed for Web part integration as when we place the 
//two workitemcontrol web part in the same page the ids are conflicting so we are 
//getting the getting right grid clientid from the variable rightgridIdForContextMenu 
function unselectallsametypes() //Method added by MP
{

    var rightgridId = rightgridIdForContextMenu;
    if (rightgridId == "") {
        rightgridId = "WebGrid1";
    }

    //For getting the workitemcontrol id from the hidden variable because of the functionality of 
    //multiple workitemlist Webparts in the same page         
    var hidWorkItemControlId = rightgridId.replace("WebGrid1", "hdnWorkitemControlid");
    var hidWorkItemControlIdValue = document.getElementById(hidWorkItemControlId).value;

    if (hidWorkItemControlIdValue != "")
        workListCtrlName = hidWorkItemControlIdValue;

    reselect = 0;

    document.getElementById("GroupSelectionEnabledCheckBox").checked = false;

    var grd = wgGetGridById(rightgridId);   //ISGetObject
    var rows = grd.RootTable.GetElement(WG40.BODY, WG40.HTMLTABLE).getElementsByTagName("tr");
    var RowsCount = grd.RootTable.Grid.TotalRows;
    for (var i = 0; i < rows.length; i++) {
        if (rows[i].type == "Record") {

            var cells = grd.GetRowByElement(rows[i]).GetCell(0).CellElement;
            cells.childNodes[0].checked = false;

        }

    }

    CallServerSideMethod(workListCtrlName, 'ClearMultiSelectCache', "DataTableCondition", CloseGroupUIWindow, 'table', null);

}



//Function used for building the context menu for inbox view type items
//This method is changed for Web part integration as when we place the 
//two workitemcontrol web part in the same page the ids are conflicting so we are 
//getting the getting right grid clientid from the variable rightgridIdForContextMenu 
function BuildInboxViewRowContextMenu(context, result, response) {

    var rightgridId = rightgridIdForContextMenu;
    if (rightgridId == "") {
        rightgridId = "WebGrid1";
    }

    //For getting the ReadingPane in Popup window property from the hidden variable because of the functionality of 
    //multiple workitemlist Webparts in the same page         
    var hidreadingPaneFlagId = rightgridId.replace("WebGrid1", "hdnCheckReadingpaneFlag");
    var hidreadingPaneFlagIdValue = document.getElementById(hidreadingPaneFlagId).value;

    if (hidreadingPaneFlagIdValue != "")
        checkreadingpaneflag = hidreadingPaneFlagIdValue;

    //to close the detailed window on right click context menu.
    if (checkreadingpaneflag == "True") {
        if (mywindow != null) {
            mywindow.close();
        }
        if (GetRadWindow() != 'undefined' && GetRadWindow() != null) {
            closeRadWindow();
        }
    }
     
    if (result != null && response.Error == false) {
        var UrlJs;
        eval("UrlJs=" + result);

        var defaultInstanceName = UrlJs._DefaultFormName;
        CheckForwardingAllowed = UrlJs._ForwardingAllowed;
        var formcnt = UrlJs.FormCount;

        var FormMenuYpos = menuYpos;

        for (var key in UrlJs)
        {

            if (key == "_DefaultFormName") continue;
            if (key == defaultInstanceName && parseInt(formcnt) == 1) continue;
            if (key == "FormCount") continue;
            if (key == "_ForwardingAllowed") continue;
            if (key != "CanPutBackinSameQueue")
            {
                CreateInboxViewMenu(menuXpos, menuYpos, key, "javascript: OpenContextUrl(\"" + key + "\")");                
            }
            else
            {
                CreateInboxViewMenu(menuXpos, menuYpos, UrlJs[key]["Name"], "javascript: OpenQueueinHiddenIframefromInbox(\"" + key + "\")");               
            }            
        }
        CurrentUrlJs = UrlJs;
        
        if (CheckForwardingAllowed == 'True' ) {
            var urldetails = UrlJs[UrlJs._DefaultFormName];
            if (typeof (urldetails) != 'undefined') {
                var urlDetailsJs;
                eval("urlDetailsJs=" + urldetails);                
                CreateInboxViewMenu(menuXpos, menuYpos, strReassignWorkitem, "javascript:ReassignWorkItem(\"" + urlDetailsJs.url + "\");");
                CreateInboxViewMenu(menuXpos, menuYpos, strDelegateWorkitem, "javascript:DelegateWorkItem(\"" + urlDetailsJs.url + "\");");                
            }
        }



        var grid = ISGetObject(rightgridId);
        var rootTable = grid.RootTable;
        var groupRows = rootTable.GetGroupRows();

        var chkMultiSelectImgCheck1Id = rightgridId.replace("WebGrid1", "imgCheck1");

        var checkMultiSelect = document.getElementById(chkMultiSelectImgCheck1Id);
        if (checkMultiSelect != null) {
            if (checkMultiSelect.style.display == 'none') {

                if (groupRows != "") {
                    //Need to Enable for Selectall and unselectall within a group
                    CreateInboxViewMenu(menuXpos, menuYpos, strSelectallwithingroup, "javascript:SelectWithinInboxgroup();");
                    CreateInboxViewMenu(menuXpos, menuYpos, strUnSelectallwithingroup, "javascript:UnSelectWithinInboxgroup();");                 
                }

                else //new code by MP
                {
                    CreateInboxViewMenu(menuXpos, menuYpos, strSelectallSameType, "javascript:selectallsametypes();");
                    CreateInboxViewMenu(menuXpos, menuYpos, strUnselectallSameType, "javascript:unselectallsametypes();");                  
                }

            }
        }

    }

}
//Method for building the Inbox View Context Menu
function CreateInboxViewMenu(x, y, name, value) {

    if (name == strSelectallwithingroup) {
        var mnuSelectallwithingroup = new WebMenuItem();
        mnuSelectallwithingroup.Text = name;
        mnuSelectallwithingroup.Name = "SelectAllWithinGroup";
        mnuSelectallwithingroup.OnClick = value;
        mnuSelectallwithingroup.ImageURL = strThemeDirectoryPath + "/WorkItemList/Images/MenuIcons/icon-select.png";
        if (menuObject.Items.GetNamedItem("SelectAllWithinGroup")== null)
           menuObject.Items.Add(mnuSelectallwithingroup);

    }
    else if (name == strUnSelectallwithingroup) {
        var mnuUnSelectallwithingroup = new WebMenuItem();
        mnuUnSelectallwithingroup.Text = name;
        mnuUnSelectallwithingroup.Name = "UnSelectAllWithinGroup";
        mnuUnSelectallwithingroup.OnClick = value;
        mnuUnSelectallwithingroup.ImageURL = strThemeDirectoryPath + "/WorkItemList/Images/MenuIcons/icon-unselect.png";
        if (menuObject.Items.GetNamedItem("UnSelectAllWithinGroup") == null)
           menuObject.Items.Add(mnuUnSelectallwithingroup);

    }
    else if (name == strSelectallSameType) {
        var mnuSelectallsametype = new WebMenuItem();
        mnuSelectallsametype.Text = name;
        mnuSelectallsametype.Name = "SelectAllSameType";
        mnuSelectallsametype.OnClick = value;
        mnuSelectallsametype.ImageURL = strThemeDirectoryPath + "/WorkItemList/Images/MenuIcons/icon-select-similar.png";
        if (menuObject.Items.GetNamedItem("SelectAllSameType") == null)
            menuObject.Items.Add(mnuSelectallsametype);
    }
    else if (name == strUnselectallSameType) {
        var mnuUnSelectallsametype = new WebMenuItem();
        mnuUnSelectallsametype.Text = name;
        mnuUnSelectallsametype.Name = "UnSelectAllSameType";
        mnuUnSelectallsametype.OnClick = value;
        mnuUnSelectallsametype.ImageURL = strThemeDirectoryPath + "/WorkItemList/Images/MenuIcons/icon-uselect-similar.png";
        if (menuObject.Items.GetNamedItem("UnSelectAllSameType") == null)
            menuObject.Items.Add(mnuUnSelectallsametype);

    }
    else if (name == strReassignWorkitem) {
        var mnuReassign = new WebMenuItem();
        mnuReassign.Text = strReassignWorkitem;
        mnuReassign.Name = "Reassign";
        mnuReassign.OnClick = value;
        mnuReassign.ImageURL = strThemeDirectoryPath + "/WorkItemList/Images/MenuIcons/reassignworkitem.png";
        if (menuObject.Items.GetNamedItem("Reassign") == null)
            menuObject.Items.Add(mnuReassign);
    }
    else if (name == strDelegateWorkitem) {
        var mnuDelegate = new WebMenuItem();
        mnuDelegate.Text = strDelegateWorkitem;
        mnuDelegate.Name = "Delegate";
        mnuDelegate.OnClick = value;
        mnuDelegate.ImageURL = strThemeDirectoryPath + "/WorkItemList/Images/MenuIcons/delegateworkitem.png";
        if (menuObject.Items.GetNamedItem("Delegate") == null)
            menuObject.Items.Add(mnuDelegate);
    }
    else if (name == "Put back in same queue") {
        var mnuPutBack = new WebMenuItem();
        mnuPutBack.Text = name;
        mnuPutBack.Name = "PutBack";
        mnuPutBack.OnClick = value;
        mnuPutBack.ImageURL = strThemeDirectoryPath + "/WorkItemList/Images/MenuIcons/CanPutBackinSameQueue.png";
        if (menuObject.Items.GetNamedItem("PutBack") == null)
             menuObject.Items.Add(mnuPutBack);
    }
    else
    {
        var mnuOtherItem = new WebMenuItem();
        mnuOtherItem.Text = name;
        mnuOtherItem.Name = "OtherItems"+name;
        mnuOtherItem.OnClick = value;
        mnuOtherItem.ImageURL = strThemeDirectoryPath + "/WorkItemList/Images/MenuIcons/icon-instances.png";
        if (menuObject.Items.GetNamedItem("OtherItems" + name) == null)
             menuObject.Items.Add(mnuOtherItem);

    }
    
    menuObject.Show(x, y);

}

//Function for Open Queue item in HiddenIframe for performing putback operation
function OpenQueueinHiddenIframefromInbox(key) {
    if (key == "CanPutBackinSameQueue") {
        var urlDetails = CurrentUrlJs[key]["Uri"];
        surl = templatedirectory + "WorkItemList/" + urlDetails;
        document.getElementById("openqueueframe").src = surl;
    }
}

// Function Method for form instances by moncy
function OpensubmenuForForms(parentkey, childkey) {

    var urlDetails = CurrentQueueUrlJs["FormInstances"]["Forms"][childkey]["Uri"];
    var urlDetailsJs;
    eval("urlDetailsJs=" + urlDetails);
    OpenUrl(urlDetailsJs);

}

//Function used for showing the manager view context menu.
function BuildManagerViewContextMenu(context, result, response) {    
    if (result != null && response.Error == false) {
        var UrltoPass = result;       
        CreateManagerViewMenu(menuXpos, menuYpos, UrltoPass);
    }

}

//Method used for building the Manager view Context menu
function CreateManagerViewMenu(x, y, value)
{
    var mnuReassign = new WebMenuItem();
    mnuReassign.Text = strReassignWorkitem;
    mnuReassign.Name = "Reassign";
    mnuReassign.OnClick = "javascript:ReassignWorkItem(\"" + value + "\");";
    mnuReassign.ImageURL = strThemeDirectoryPath + "/WorkItemList/Images/MenuIcons/reassignworkitem.png";    
    if (menuObject.Items.GetNamedItem("Reassign") == null)
        menuObject.Items.Add(mnuReassign);

    var mnuDelegate = new WebMenuItem();
    mnuDelegate.Text = strDelegateWorkitem;
    mnuDelegate.Name = "Delegate";
    mnuDelegate.OnClick = "javascript:DelegateWorkItem(\"" + value + "\");";
    mnuDelegate.ImageURL = strThemeDirectoryPath + "/WorkItemList/Images/MenuIcons/delegateworkitem.png";
    if (menuObject.Items.GetNamedItem("Delegate") == null)
         menuObject.Items.Add(mnuDelegate);

    var mnuSetPriority = new WebMenuItem();
    mnuSetPriority.Text = strSetPriority;
    mnuSetPriority.Name = "SetPriority";
    mnuSetPriority.OnClick = "";
    mnuSetPriority.ImageURL = strThemeDirectoryPath + "/WorkItemList/Images/MenuIcons/setpriorityworkitem.png";

    var subHighMenu = new WebMenuItem();
    subHighMenu.Text = strHigh;
    subHighMenu.Name = "High";
    subHighMenu.ImageURL = strThemeDirectoryPath + "/WorkItemList/Images/MenuIcons/high.png";
    for (var highcount = 99; highcount >= 67; highcount--) {
        var menuhighSubItem = new WebMenuItem();
        menuhighSubItem.Text = highcount.toString();
        menuhighSubItem.Name = highcount.toString();
        menuhighSubItem.ImageURL = strThemeDirectoryPath + "/WorkItemList/Images/MenuIcons/high.png";
        menuhighSubItem.OnClick = "javascript:SetPriorityforWorkItem('" + value + "','" + highcount.toString() + "')";
        subHighMenu.Items.Add(menuhighSubItem);
    }

    var subMediumMenu = new WebMenuItem();
    subMediumMenu.Text = strMedium;
    subMediumMenu.Name = "Medium";
    subMediumMenu.ImageURL = strThemeDirectoryPath + "/WorkItemList/Images/MenuIcons/medium.png";
    for (var mediumcount = 66; mediumcount >= 34; mediumcount--) {
        var menumediumSubItem = new WebMenuItem();
        menumediumSubItem.Text = mediumcount.toString();
        menumediumSubItem.Name = mediumcount.toString();
        menumediumSubItem.ImageURL = strThemeDirectoryPath + "/WorkItemList/Images/MenuIcons/medium.png";
        menumediumSubItem.OnClick = "javascript:SetPriorityforWorkItem('" + value + "','" + mediumcount.toString() + "')";
        subMediumMenu.Items.Add(menumediumSubItem);
    }

    var subLowMenu = new WebMenuItem();
    subLowMenu.Text = strLow;
    subLowMenu.Name = "Low";
    subLowMenu.ImageURL = strThemeDirectoryPath + "/WorkItemList/Images/MenuIcons/low.png";
    for (var lowcount = 33; lowcount >= 0; lowcount--) {
        var menulowSubItem = new WebMenuItem();
        menulowSubItem.Text = lowcount.toString();
        menulowSubItem.Name = lowcount.toString();
        menulowSubItem.ImageURL = strThemeDirectoryPath + "/WorkItemList/Images/MenuIcons/low.png";
        menulowSubItem.OnClick = "javascript:SetPriorityforWorkItem('" + value + "','" + lowcount.toString() + "')";
        subLowMenu.Items.Add(menulowSubItem);
    }

    if (mnuSetPriority.Items.GetNamedItem("High") == null)
        mnuSetPriority.Items.Add(subHighMenu);   
    if (mnuSetPriority.Items.GetNamedItem("Medium") == null)
        mnuSetPriority.Items.Add(subMediumMenu);
    if (mnuSetPriority.Items.GetNamedItem("Low") == null)
        mnuSetPriority.Items.Add(subLowMenu);    
    if (menuObject.Items.GetNamedItem("SetPriority") == null)
        menuObject.Items.Add(mnuSetPriority);

    menuObject.Show(x, y);

}

//Function for showing the Queue context menu
function BuildQueueContextMenu(context, result, response) {

    var rightgridId = rightgridIdForContextMenu;
    if (rightgridId == "") {
        rightgridId = "WebGrid1";
    }

    //For getting the ReadingPane in Popup window property from the hidden variable because of the functionality of 
    //multiple workitemlist Webparts in the same page         
    var hidreadingPaneFlagId = rightgridId.replace("WebGrid1", "hdnCheckReadingpaneFlag");
    var hidreadingPaneFlagIdValue = document.getElementById(hidreadingPaneFlagId).value;

    if (hidreadingPaneFlagIdValue != "")
        checkreadingpaneflag = hidreadingPaneFlagIdValue;

    //to close the detailed window on right click context menu.
    if (checkreadingpaneflag == "True") {
        if (mywindow != null) {
            mywindow.close();
        }
    }
   
    if (result != null && response.Error == false) {
        if (result != "{}" && result != "")
        {            
            CreateQueueViewMenu(menuXpos, menuYpos, result);
        }

    }


}
//Method used for building the Queue view Context menu
function CreateQueueViewMenu(x, y, value) {

    var queuemenusJs;
    eval("queuemenusJs=" + value);

    for (var key in queuemenusJs) {

        if (key == "CanPickItem") {
            var mnuPickItem = new WebMenuItem();
            mnuPickItem.Text = queuemenusJs[key]["Name"];
            mnuPickItem.Name = "PickItem";
            mnuPickItem.OnClick = "javascript: OpenQueueinHiddenIframe(\"" + key + "\")";
            mnuPickItem.ImageURL = strThemeDirectoryPath + "/WorkItemList/Images/MenuIcons/pickqueue.png";
            if (menuObject.Items.GetNamedItem("PickItem") == null)
                menuObject.Items.Add(mnuPickItem);
        }
        else if (key == "CanPlanItem") {
            var mnuPlanItem = new WebMenuItem();
            mnuPlanItem.Text = queuemenusJs[key]["Name"];
            mnuPlanItem.Name = "PlanItem";
            mnuPlanItem.OnClick = "javascript: OpenQueueinHiddenIframe(\"" + key + "\")";
            mnuPlanItem.ImageURL = strThemeDirectoryPath + "/WorkItemList/Images/MenuIcons/planqueue.png";
            if (menuObject.Items.GetNamedItem("PlanItem") == null)
                menuObject.Items.Add(mnuPlanItem);
        }

        else if (key == "CanCancelPlanItem") {
            var mnuCancelPlanItem = new WebMenuItem();
            mnuCancelPlanItem.Text = queuemenusJs[key]["Name"];
            mnuCancelPlanItem.Name = "CancelPlanItem";
            mnuCancelPlanItem.OnClick = "javascript: OpenQueueinHiddenIframe(\"" + key + "\")";
            mnuCancelPlanItem.ImageURL = strThemeDirectoryPath + "/WorkItemList/Images/MenuIcons/planqueue.png";
            if (menuObject.Items.GetNamedItem("CancelPlanItem") == null)
                menuObject.Items.Add(mnuCancelPlanItem);
        }

        else if (key == "RecallAllocatedItems") {
            var mnuRecallAllocatedItem = new WebMenuItem();
            mnuRecallAllocatedItem.Text = queuemenusJs[key]["Name"];
            mnuRecallAllocatedItem.Name = "Recall";
            mnuRecallAllocatedItem.OnClick = "javascript: OpenQueueinHiddenIframe(\"" + key + "\")";
            mnuRecallAllocatedItem.ImageURL = strThemeDirectoryPath + "/WorkItemList/Images/MenuIcons/recallallocatedqueueitem.png";
            if (menuObject.Items.GetNamedItem("Recall") == null)
                menuObject.Items.Add(mnuRecallAllocatedItem);
        }
        else if (key == "AllocateQueueItem") {
            var mnuAllocatedItem = new WebMenuItem();
            mnuAllocatedItem.Text = queuemenusJs[key]["Name"];
            mnuAllocatedItem.Name = "Allocate";
            mnuAllocatedItem.OnClick = "javascript: OpenQueueinHiddenIframe(\"" + key + "\")";
            mnuAllocatedItem.ImageURL = strThemeDirectoryPath + "/WorkItemList/Images/MenuIcons/allocatequeueitem.png";
            if (menuObject.Items.GetNamedItem("Allocate") == null)
                menuObject.Items.Add(mnuAllocatedItem);
        }
        else if (key == "SetQueuePriority") {
            var setpriorityurlvalue = queuemenusJs[key]["Uri"];

            var mnuSetPriority = new WebMenuItem();
            mnuSetPriority.Text = strSetPriority;
            mnuSetPriority.Name = "SetPriority";
            mnuSetPriority.OnClick = "";
            mnuSetPriority.ImageURL = strThemeDirectoryPath + "/WorkItemList/Images/MenuIcons/setpriorityworkitem.png";

            var subHighMenu = new WebMenuItem();
            subHighMenu.Text = strHigh;
            subHighMenu.Name = "High";
            subHighMenu.ImageURL = strThemeDirectoryPath + "/WorkItemList/Images/MenuIcons/high.png";
            for (var highcount = 99; highcount >= 67; highcount--) {
                var menuhighSubItem = new WebMenuItem();
                menuhighSubItem.Text = highcount.toString();
                menuhighSubItem.Name = highcount.toString();
                menuhighSubItem.ImageURL = strThemeDirectoryPath + "/WorkItemList/Images/MenuIcons/high.png";
                menuhighSubItem.OnClick = "javascript:SetPriorityforWorkItem('" + setpriorityurlvalue + "','" + highcount.toString() + "')";
                subHighMenu.Items.Add(menuhighSubItem);
            }

            var subMediumMenu = new WebMenuItem();
            subMediumMenu.Text = strMedium;
            subMediumMenu.Name = "Medium";
            subMediumMenu.ImageURL = strThemeDirectoryPath + "/WorkItemList/Images/MenuIcons/medium.png";
            for (var mediumcount = 66; mediumcount >= 34; mediumcount--) {
                var menumediumSubItem = new WebMenuItem();
                menumediumSubItem.Text = mediumcount.toString();
                menumediumSubItem.Name = mediumcount.toString();
                menumediumSubItem.ImageURL = strThemeDirectoryPath + "/WorkItemList/Images/MenuIcons/medium.png";
                menumediumSubItem.OnClick = "javascript:SetPriorityforWorkItem('" + setpriorityurlvalue + "','" + mediumcount.toString() + "')";
                subMediumMenu.Items.Add(menumediumSubItem);

            }

            var subLowMenu = new WebMenuItem();
            subLowMenu.Text = strLow;
            subLowMenu.Name = "Low";
            subLowMenu.ImageURL = strThemeDirectoryPath + "/WorkItemList/Images/MenuIcons/low.png";
            for (var lowcount = 33; lowcount >= 0; lowcount--) {
                var menulowSubItem = new WebMenuItem();
                menulowSubItem.Text = lowcount.toString();
                menulowSubItem.Name = lowcount.toString();
                menulowSubItem.ImageURL = strThemeDirectoryPath + "/WorkItemList/Images/MenuIcons/low.png";
                menulowSubItem.OnClick = "javascript:SetPriorityforWorkItem('" + setpriorityurlvalue + "','" + lowcount.toString() + "')";
                subLowMenu.Items.Add(menulowSubItem);
               }


            if (mnuSetPriority.Items.GetNamedItem("High") == null)
                mnuSetPriority.Items.Add(subHighMenu);
            if (mnuSetPriority.Items.GetNamedItem("Medium") == null)
                mnuSetPriority.Items.Add(subMediumMenu);
            if (mnuSetPriority.Items.GetNamedItem("Low") == null)
                mnuSetPriority.Items.Add(subLowMenu);
            if (menuObject.Items.GetNamedItem("SetPriority") == null)
                menuObject.Items.Add(mnuSetPriority);
        }
        else if (key == "CanMoveToDifferentQueue") {
            var CanMoveToDifferentQueuevalue = queuemenusJs[key]["Queues"];

            var mnuMoveToDifferentQueue = new WebMenuItem();
            mnuMoveToDifferentQueue.Text = queuemenusJs[key]["Name"];
            mnuMoveToDifferentQueue.Name = "Movetodifferentqueue";
            mnuMoveToDifferentQueue.OnClick = "";
            mnuMoveToDifferentQueue.ImageURL = strThemeDirectoryPath + "/WorkItemList/Images/MenuIcons/movetodifferentqueue.png";

            for (var subkey in CanMoveToDifferentQueuevalue)
            {
                var mnuSubMenuQueue = new WebMenuItem();
                mnuSubMenuQueue.Text = subkey;
                mnuSubMenuQueue.Name = subkey;
                mnuSubMenuQueue.OnClick = "javascript: OpensubmenuQueueinHiddenIframe('CanMoveToDifferentQueue','" + subkey + "')";
                mnuSubMenuQueue.ImageURL = strThemeDirectoryPath + "/WorkItemList/Images/MenuIcons/movetodifferentqueue.png";
                if (mnuMoveToDifferentQueue.Items.GetNamedItem(subkey) == null)
                    mnuMoveToDifferentQueue.Items.Add(mnuSubMenuQueue);
            }
            if (menuObject.Items.GetNamedItem("Movetodifferentqueue") == null)
                menuObject.Items.Add(mnuMoveToDifferentQueue);
        }
        else if (key == "FormInstances") //New decision for Queue detailed view added by MP
        {
            var formInstances = queuemenusJs[key]["Forms"];

            var ich = 0;

            for (var frmInstance in formInstances) //For handling the showing of context menu if it is empty
            {
                ich++;
            }

            if (ich > 0) {
                
                var mnuFrmInstances = new WebMenuItem();
                mnuFrmInstances.Text = queuemenusJs[key]["Name"];
                mnuFrmInstances.Name = "FormInstances";
                mnuFrmInstances.OnClick = "";
                mnuFrmInstances.ImageURL = strThemeDirectoryPath + "/WorkItemList/Images/MenuIcons/icon-instances.png";

                for (var subkey in formInstances) {

                    var mnuSubMenuFrmInstances = new WebMenuItem();
                    mnuSubMenuFrmInstances.Text = subkey;
                    mnuSubMenuFrmInstances.Name = subkey;
                    mnuSubMenuFrmInstances.OnClick = "javascript: OpensubmenuForForms('FormInstances','" + subkey + "')";
                    mnuSubMenuFrmInstances.ImageURL = strThemeDirectoryPath + "/WorkItemList/Images/MenuIcons/icon-instances.png";
                    if (mnuFrmInstances.Items.GetNamedItem(subkey) == null)
                        mnuFrmInstances.Items.Add(mnuSubMenuFrmInstances);

                }
                if (menuObject.Items.GetNamedItem("FormInstances") == null)
                    menuObject.Items.Add(mnuFrmInstances);                
            }
        }
        else if (key == "ReassignQueueItems") {

            var mnuReassign = new WebMenuItem();
            mnuReassign.Text = queuemenusJs[key]["Name"];
            mnuReassign.Name = "ReassignQueue";
            mnuReassign.OnClick = "javascript:OpenQueueinHiddenIframe(\"" + key + "\");";
            mnuReassign.ImageURL = strThemeDirectoryPath + "/WorkItemList/Images/MenuIcons/reassignworkitem.png";
            if (menuObject.Items.GetNamedItem("ReassignQueue") == null)
                menuObject.Items.Add(mnuReassign);
        }
    }


    var rightgridId = rightgridIdForContextMenu;
    if (rightgridId == "") {
        rightgridId = "WebGrid1";
    }

    var grid = ISGetObject(rightgridId);
    var rootTable = grid.RootTable;
    var groupRows = rootTable.GetGroupRows();
    if (groupRows != "") {
        //Need to Enable for Selectall and unselectall within a group

        
        var mnuSelectallwithingroup = new WebMenuItem();
        mnuSelectallwithingroup.Text = strSelectallwithingroup;
        mnuSelectallwithingroup.Name = "SelectAllWithinGroup";
        mnuSelectallwithingroup.OnClick = "javascript: selectwithingroup()";
        mnuSelectallwithingroup.ImageURL = strThemeDirectoryPath + "/WorkItemList/Images/MenuIcons/icon-select.png";
        if (menuObject.Items.GetNamedItem("SelectAllWithinGroup") == null)
            menuObject.Items.Add(mnuSelectallwithingroup);
       
        var mnuUnSelectallwithingroup = new WebMenuItem();
        mnuUnSelectallwithingroup.Text = strUnSelectallwithingroup;
        mnuUnSelectallwithingroup.Name = "UnSelectAllWithinGroup";
        mnuUnSelectallwithingroup.OnClick = "javascript: unselectwithingroup()";
        mnuUnSelectallwithingroup.ImageURL = strThemeDirectoryPath + "/WorkItemList/Images/MenuIcons/icon-unselect.png";
        if (menuObject.Items.GetNamedItem("UnSelectAllWithinGroup") == null)
            menuObject.Items.Add(mnuUnSelectallwithingroup);

    }    
    CurrentQueueUrlJs = queuemenusJs;
    menuObject.Show(x, y);
} 

var rightGridIdforNavigation = "";
//This method is used for Web part integration as when we place the 
//two workitemcontrol web part in the same page the ids are conflicting so we are 
//getting the getting right grid clientid before selecting the row and storing it in 
//the variable rightGridIdforNavigation so that the right grid client id is getting 
// in Navigation and submission context functionalities.
function CheckRowSelect(gridId) {

    rightGridIdforNavigation = gridId;

}

//Function used for Clearing the Selected row object 
function ChangeVariable(controlId) {
    var grdDetails = ISGetObject(controlId);
    if (grdDetails != null)
        grdDetails.ClearSelectedObject();


}


//Function which gets called when a row is selected in RHS grid

var checkajaxcall = "no";
var checkClickMoveNext = "no";

//This method is changed for Web part integration as when we place the 
//two workitemcontrol web part in the same page the ids are conflicting so we are 
//passing the right grid client id.
function callajaxforautoownership(gridId) {

     
        
    if ((IS.ie && (event == null && checkClickMoveNext == "no")) || (!IS.ie && (event != null && typeof (event.button) == undefined)))
    {
        return false;  //To avoid opening of detailed window on filter bar   
    }
    
    if ((IS.ie && (event != null && event.button == "2")) || (!IS.ie && (event != null && typeof (event) != undefined && event.button == "2")))
    {
        return false; //To avoid opening of detailed window on right click context menu
    }
        
    
    if (!IS.ie && event == null && checkClickMoveNext == "no")
    {
        return false; //To avoid calling ajax on edit of webpart in Mozilla and Chrome
    }

    //For Ajax Call  -start
    var grid = ISGetObject(gridId);    

    if (grid.LastAction == "Refresh") {
        return;
    }

    if (grid.GetSelectedObject() == null)
    {
        ShowBellyBarErrorMessage(strWorkItemTitle, strSelectRow);
        return;
    }
    var row = ISGetObject(gridId).GetSelectedObject().GetRowElement();

    var cell = wgGetCellByName(row, "Subject");

    if (cell == null)
        return;
    //For getting the Workflowname,Workitemid and Applicationname

    var Querystringvalues = cell.getAttribute("details");
    if (Querystringvalues == null) return;
    var QuerystringvaluesArr = Querystringvalues.split(',');


    var workItemObj = new WorkItem();

    workItemObj.ApplicationName = QuerystringvaluesArr[1];
    workItemObj.WorkFlowName = QuerystringvaluesArr[2];
    workItemObj.WorkItemId = QuerystringvaluesArr[3];
    workItemObj.FormNames = QuerystringvaluesArr[4];
    workItemObj.ActivityType = QuerystringvaluesArr[5];

    //For getting the hdnLeftGridVisibility id from the hidden variable because of the functionality of 
    //multiple workitemlist Webparts in the same page         
    var hidLeftGridVisibilityId = gridId.replace("WebGrid1", "hdnLeftGridVisibility");
    var hidLeftGridVisibilityValue = "";
    if (document.getElementById(hidLeftGridVisibilityId) != null)
        hidLeftGridVisibilityValue = document.getElementById(hidLeftGridVisibilityId).value;

    if (hidLeftGridVisibilityValue != "")
        checkLeftgridvisibility = hidLeftGridVisibilityValue;



    if (checkLeftgridvisibility == "False") {
        //For getting the workitemcontrol id from the hidden variable because of the functionality of 
        //multiple workitemlist Webparts in the same page         
        var hidViewTypeWithoutLeftGridId = gridId.replace("WebGrid1", "hdnViewTypeWithoutLeftGrid");
        var hidViewTypeWithoutLeftGridIdValue = document.getElementById(hidViewTypeWithoutLeftGridId).value;

        if (hidViewTypeWithoutLeftGridIdValue != "")
            viewTypeWithoutLeftGrid = hidViewTypeWithoutLeftGridIdValue;


        checkViewType = viewTypeWithoutLeftGrid;
        var grid1 = ISGetObject(gridId);
        var lastObj1 = grid1.GetSelectedObject();
        if (lastObj1 != null) {
            lastselectedrowkey1 = lastObj1.rowIndex;
            //if (lastselectedrowkey1 >= 3)
            //    lastselectedrowkey1 = lastselectedrowkey1 - 3;
        }
    }

    //For getting the workitemcontrol id from the hidden variable because of the functionality of 
    //multiple workitemlist Webparts in the same page         
    var hidWorkItemControlId = gridId.replace("WebGrid1", "hdnWorkitemControlid");
    var hidWorkItemControlIdValue = "";

    if (document.getElementById(hidWorkItemControlId) != null)
        hidWorkItemControlIdValue = document.getElementById(hidWorkItemControlId).value;

    if (hidWorkItemControlIdValue != "")
        workListCtrlName = hidWorkItemControlIdValue;

    if (workListCtrlName != "") {

        if (checkViewType == "Inbox" ) {
            CallServerSideMethod(workListCtrlName, 'CallforOwnerShipwithURL', "DataTableCondition", CallbackOwnership, 'table', workItemObj);
        }
        else if (checkViewType == "Queue") {

            if (strQueueDetailView == "False") {
                if (strShowDetailViewWithMultiSelect == "True" && checkEnableMultiSelectByDefaultForQueue == "True") {
                    CallServerSideMethod(workListCtrlName, 'BuildTempUrlForQueueView', "DataTableCondition", OpenQueueItemDetails, 'table', workItemObj);
                }
                else if (strShowDetailViewWithMultiSelect == "False" && checkEnableMultiSelectByDefaultForQueue == "True") {

                }
                else {
                    CallServerSideMethod(workListCtrlName, 'BuildTempUrlForQueueView', "DataTableCondition", OpenQueueItemDetails, 'table', workItemObj);
                }
            }
            else {
                if (strShowDetailViewWithMultiSelect == "True" && checkEnableMultiSelectByDefaultForQueue == "True") {
                    //Code changed for Queue detailed view without picking
                    CallServerSideMethod(workListCtrlName, 'BuildSecuredUrlForQueueView', "DataTableCondition", CallbackOwnership, 'table', workItemObj);
                }
                else if (strShowDetailViewWithMultiSelect == "False" && checkEnableMultiSelectByDefaultForQueue == "True") {

                }
                else {
                    CallServerSideMethod(workListCtrlName, 'BuildSecuredUrlForQueueView', "DataTableCondition", CallbackOwnership, 'table', workItemObj);
                }
            }

        }
    }




    //For Ajax Call -End

}

//Function which gets called on checkbox click in multi select mode
var parentGroupIndex = "";
var chkcount = 0;

var rightGridIdforMultiSelect = "";
var prepageidforMultiSelect = "";

//This method is used for Web part integration as when we place the 
//two workitemcontrol web part in the same page the ids are conflicting so we are 
//passing the right grid clientid and used for multi select functionalities.
function callajaxoncheckboxclick(parentgroup, gridId) {
    rightGridIdforMultiSelect = gridId;
   
    //For getting the workitemcontrol id from the hidden variable because of the functionality of 
    //multiple workitemlist Webparts in the same page

    var hidWorkItemControlId = gridId.replace("WebGrid1", "hdnWorkitemControlid");
    var hidWorkItemControlIdValue = document.getElementById(hidWorkItemControlId).value;

    if (hidWorkItemControlIdValue != "")
        workListCtrlName = hidWorkItemControlIdValue;



    //For Ajax Call  -start
    var grid = ISGetObject(gridId);

    //Added for Groupby select
    //reset the value for selectingallcheckbox
    if (chkcount >= 1)
        chkcount = 0;

    var selectedObject = grid.GetSelectedObject().GetRowElement();
    if (selectedObject.attributes["parentIndex"] != null)
        parentGroupIndex = parseInt(selectedObject.attributes["parentIndex"].value);

    prepageidforMultiSelect = gridId.replace("WebGrid1", "prepage");

    //Calling is happening if you click the check all checkbox
    if (grid.GetSelectedObject() == null) {

        if (grid.RootTable.GetRow(grid.CheckedRowContext.rowIndex) == null) return;

        var row = grid.RootTable.GetRow(grid.CheckedRowContext.rowIndex).RowElement;
        var cell = wgGetCellByName(row, "Subject");
        if (cell == null)
            return;

        //For getting the Workflowname,Workitemid and Applicationname         
        var Querystringvalues = cell.getAttribute("details");
        if (Querystringvalues == null) return;
        var QuerystringvaluesArr = Querystringvalues.split(',');
        var workItemObj = new WorkItem();

        workItemObj.ApplicationName = QuerystringvaluesArr[1];
        workItemObj.WorkFlowName = QuerystringvaluesArr[2];
        workItemObj.WorkItemId = QuerystringvaluesArr[3];
        workItemObj.FormNames = QuerystringvaluesArr[4];
        workItemObj.ActivityType = QuerystringvaluesArr[5];

        if (checkLeftgridvisibility == "False") {
            checkViewType = viewTypeWithoutLeftGrid;
        }

        if (checkViewType == "Inbox") {

            var cellcheck = wgGetCellByPosition(row, 0);
            if (cellcheck != null) {

                if (cellcheck.childNodes[0].checked == true) {
                    //document.all.prepage.style.display="block";
                    document.getElementById(prepageidforMultiSelect).style.display = "block";
                    if (workItemObj.ActivityType == "Invoke Form")
                        CallServerSideMethod(workListCtrlName, 'ShowInvokeFormMultiSelectForm', "DataTableCondition", CallbackInvokeFormCheckStatus, 'table', workItemObj);
                    else
                        CallServerSideMethod(workListCtrlName, 'BuildForGetPossibleStatusList', "DataTableCondition", CallbackCheckStatus, 'table', workItemObj);
                }
                else {
                    workItemObj.Unchecked = "unchecked";
                    //document.all.prepage.style.display="block";
                    document.getElementById(prepageidforMultiSelect).style.display = "block";
                    if (workItemObj.ActivityType == "Invoke Form")
                        CallServerSideMethod(workListCtrlName, 'ShowInvokeFormMultiSelectForm', "DataTableCondition", CallbackInvokeFormCheckStatus, 'table', workItemObj);
                    else
                        CallServerSideMethod(workListCtrlName, 'BuildForGetPossibleStatusList', "DataTableCondition", CallbackCheckStatus, 'table', workItemObj);
                }

            }

        }

    }
    //Calling is happening if you click on individual row checkbox
    else {

        var row = ISGetObject(gridId).GetSelectedObject().GetRowElement();
        var cell = wgGetCellByName(row, "Subject");
        if (cell == null)
            return;

        //For getting the Workflowname,Workitemid and Applicationname         
        var Querystringvalues = cell.getAttribute("details");
        if (Querystringvalues == null) return;
        var QuerystringvaluesArr = Querystringvalues.split(',');
        var workItemObj = new WorkItem();

        workItemObj.ApplicationName = QuerystringvaluesArr[1];
        workItemObj.WorkFlowName = QuerystringvaluesArr[2];
        workItemObj.WorkItemId = QuerystringvaluesArr[3];
        workItemObj.FormNames = QuerystringvaluesArr[4];
        workItemObj.ActivityType = QuerystringvaluesArr[5];

        if (checkLeftgridvisibility == "False") {
            checkViewType = viewTypeWithoutLeftGrid;
        }

        if (checkViewType == "Inbox") {
            var cellcheck = wgGetCellByPosition(row, 0);
            if (cellcheck != null) {
                if (cellcheck.childNodes[0].checked == true) {
                    //document.all.prepage.style.display="block";

                    document.getElementById(prepageidforMultiSelect).style.display = "block";
                    if (workItemObj.ActivityType == "Invoke Form")
                        CallServerSideMethod(workListCtrlName, 'ShowInvokeFormMultiSelectForm', "DataTableCondition", CallbackInvokeFormCheckStatus, 'table', workItemObj);
                    else
                        CallServerSideMethod(workListCtrlName, 'BuildForGetPossibleStatusList', "DataTableCondition", CallbackCheckStatus, 'table', workItemObj);
                }
                else {
                    //document.all.prepage.style.display="block";
                    document.getElementById(prepageidforMultiSelect).style.display = "block";
                    workItemObj.Unchecked = "unchecked";
                    if (workItemObj.ActivityType == "Invoke Form")
                        CallServerSideMethod(workListCtrlName, 'ShowInvokeFormMultiSelectForm', "DataTableCondition", CallbackInvokeFormCheckStatus, 'table', workItemObj);
                    else
                        CallServerSideMethod(workListCtrlName, 'BuildForGetPossibleStatusList', "DataTableCondition", CallbackCheckStatus, 'table', workItemObj);
                }
            }
        }
    }

    //For Ajax Call -End

    if (typeof (parentgroup) != 'undefined' && parentgroup != "") {
        window.setTimeout(function () { CheckOtherRows(parentgroup, gridId); }, 500);
    }

}
//Return Ajax method for showing Invoke form in multi select mode
function CallbackInvokeFormCheckStatus(context, result, response) {

    chkcount++;
    if (result != null && response.Error == false) {
        var UrlJs;
        eval("UrlJs=" + result);

        var checkvalidsel = UrlJs.CheckValidSelection;
        if (typeof (checkvalidsel) == 'undefined')
            checkvalidsel = 'true';

        var secUrl = UrlJs.SecuredUrl;
        var checkInformation = UrlJs.CheckInformation;
        if (typeof (checkInformation) == 'undefined')
            checkInformation = 'false';

        var multiSelectFormNotSet = UrlJs.MultiSelectFormNotSet; //MultiSelectFormNotSame;
        if (typeof (multiSelectFormNotSet) == 'undefined')
            multiSelectFormNotSet = 'false';

        var multiSelectFormNotSame = UrlJs.MultiSelectFormNotSame;
        if (typeof (multiSelectFormNotSame) == 'undefined')
            multiSelectFormNotSame = 'false';

        var enableTakeOwnerShip = UrlJs.EnableTakeOwnerShip;
        if (typeof (enableTakeOwnerShip) == 'undefined')
            enableTakeOwnerShip = 'No';


        var rowKeyValue = UrlJs.RowKeyValue;
        if (typeof (rowKeyValue) == 'undefined')
            rowKeyValue = '';

        if (checkvalidsel == 'false') {
            checkSelect(checkInformation, multiSelectFormNotSet, multiSelectFormNotSame, rowKeyValue);
        }
        else {
            //invkmultiselecturl = templatedirectory+"WorkItemList/MultiSelectInvokeForm.aspx"+secUrl+"&etown="+enableTakeOwnerShip;
            if (typeof(secUrl) != 'undefined') {
                OpenMultiSelectInvokeForm(templatedirectory + "WorkItemList/MultiSelectInvokeForm.aspx" + secUrl, rightGridIdforMultiSelect);
            }
        }

    }

    if (chkcount == 1) {
        var groupSelection = document.getElementById("GroupSelectionEnabledCheckBox");
        if (groupSelection.checked) {
            // checkotherrows();
            //groupSelection.disabled = true;
        }

        var getPrepageId = rightgridIdForContextMenu;
        if (rightgridIdForContextMenu == "")
            getPrepageId = rightGridIdforMultiSelect;

        if (prepageidforMultiSelect == "")
            prepageidforMultiSelect = getPrepageId.replace("WebGrid1", "prepage");

        //window.setTimeout(function() {document.all.prepage.style.display="none";}, 1500);
        window.setTimeout(function () { document.getElementById(prepageidforMultiSelect).style.display = "none"; }, 1500);
    }
}

//Function for opening the Invoke Form 
var invkmultiselecturl;
var invkmultiselectwindow;
var invkmultiselectintvl;
function OpenMultiSelectInvokeForm(url, popupName, popupFeatures) {
    if (invkmultiselectwindow && !invkmultiselectwindow.closed && invkmultiselectwindow.focus) {
        
        invkmultiselectwindow.focus();
    }
    else {
        var left = (screen.availWidth / 2) - (800 / 2);
        var top = (screen.availHeight / 2) - (350 / 2);
        invkmultiselectwindow = window.open((url), (popupName && popupName != "") ? popupName : "MultiSelectInvokeForm", (popupFeatures && popupFeatures != "") ? popupFeatures : "location=0, status=0, scrollbars=0, width=800, height=350, resizable=yes, top=" + top + ", left= " + left);
        invkmultiselectwindow.focus();
    }
}

function CheckMultiSelectInvokeFormClosed() {
    window.setTimeout(RefreshGridIfMultiSelectInvokeFormClosed, 200);
}

function RefreshGridIfMultiSelectInvokeFormClosed() {
    if (invkmultiselectwindow.closed) {
        invkmultiselectwindow = null;
        if (invkmultiselectintvl) window.clearTimeout(invkmultiselectintvl);
        ClosewindowforGroupUI(); //RefreshGridfromdetwindowforGroupUI();
    }
}

//Ajax Return method for multi select functionality
//This method is used for Web part integration as when we place the 
//two workitemcontrol web part in the same page the ids are conflicting so we are 
//passing the right grid clientid and used for multi select functionalities.

function CallbackCheckStatus(context, result, response) {

    chkcount++;
    if (result != null && response.Error == false) {
        var UrlJs;
        eval("UrlJs=" + result);

        var checksel = UrlJs.CheckValidSelection;

        var url = UrlJs.SecuredUrl;
        var checkInformation = UrlJs.CheckInformation;
        if (typeof (checkInformation) == 'undefined')
            checkInformation = 'false';

        var rowKeyValue = UrlJs.RowKeyValue;
        if (typeof (rowKeyValue) == 'undefined')
            rowKeyValue = '';

        if (checksel == 'false') {
            checkSelect(checkInformation, "", "", rowKeyValue);
        }
        else {
            OpenGroupUIFrame(templatedirectory + "WorkItemList/GroupView.aspx" + url);
        }

    }
    if (chkcount == 1) {
        
        var rightgridId = rightGridIdforMultiSelect;

        if (rightgridId == "") {
            rightgridId = "WebGrid1";
        }

        var detailsGridobj = ISGetObject(rightgridId);

        var table = detailsGridobj.RootTable.GetElement(WG40.BODY, WG40.HTMLTABLE);
        var rows = table.rows;
        var checkforClosingGroupUIWindow = 0;
        for (var i = 0; i < rows.length; i++) {
            if (rows[i].type == "Record") {
                var cell = wgGetCellByPosition(rows[i], 0);
                if (cell.childNodes[0].checked == true) {
                    checkforClosingGroupUIWindow++;
                    break;

                }

            }
        }

        var getPrepageId = rightgridIdForContextMenu;

        if (rightgridIdForContextMenu == "")
            getPrepageId = rightGridIdforMultiSelect;

        if (prepageidforMultiSelect == "")
            prepageidforMultiSelect = getPrepageId.replace("WebGrid1", "prepage");

        if (checkforClosingGroupUIWindow == 0) {
            CloseGroupUIWindow();
            //document.all.prepage.style.display="none";
            document.getElementById(prepageidforMultiSelect).style.display = "none";
        }
        else {
            //window.setTimeout(function() {document.all.prepage.style.display="none";}, 1500);
            window.setTimeout(function () { document.getElementById(prepageidforMultiSelect).style.display = "none"; }, 1500);

        }
    }
}

function callajaxonotherselectedcheckboxclick(gridId) {

    
    //For getting the workitemcontrol id from the hidden variable because of the functionality of 
    //multiple workitemlist Webparts in the same page
    var hidWorkItemControlId = gridId.replace("WebGrid1", "hdnWorkitemControlid");
    var hidWorkItemControlIdValue = document.getElementById(hidWorkItemControlId).value;

    if (hidWorkItemControlIdValue != "")
        workListCtrlName = hidWorkItemControlIdValue;

    prepageidforMultiSelect = gridId.replace("WebGrid1", "prepage");

    //For Ajax Call  -start

    var row = ISGetObject(gridId).GetSelectedObject().GetRowElement();
    var cell = wgGetCellByName(row, "Subject");

    if (cell == null)
        return;

    //For getting the Workflowname,Workitemid and Applicationname         
    var Querystringvalues = cell.getAttribute("details");

    if (Querystringvalues == null) return;
    var QuerystringvaluesArr = Querystringvalues.split(',');
    var workItemObj = new WorkItem();

    workItemObj.ApplicationName = QuerystringvaluesArr[1];
    workItemObj.WorkFlowName = QuerystringvaluesArr[2];
    workItemObj.WorkItemId = QuerystringvaluesArr[3];
    workItemObj.FormNames = QuerystringvaluesArr[4];
    workItemObj.ActivityType = QuerystringvaluesArr[5];

    if (checkLeftgridvisibility == "False") {
        checkViewType = viewTypeWithoutLeftGrid;
    }

    //Added for Groupby select
    //reset the value for selectingallcheckbox
    if (chkcount >= 1)
        chkcount = 0;


    if (checkViewType == "Inbox") {
        var cellcheck = wgGetCellByPosition(row, 0);
        if (cellcheck != null) {
            if (cellcheck.childNodes[0].checked == true) {

                document.getElementById(prepageidforMultiSelect).style.display = "block";
                if (workItemObj.ActivityType == "Invoke Form")
                    CallServerSideMethod(workListCtrlName, 'ShowInvokeFormMultiSelectForm', "DataTableCondition", CallbackInvokeFormCheckStatus, 'table', workItemObj);
                else
                    CallServerSideMethod(workListCtrlName, 'BuildForGetPossibleStatusList', "DataTableCondition", CallbackCheckStatus, 'table', workItemObj);
            }
            else {

                document.getElementById(prepageidforMultiSelect).style.display = "block";
                workItemObj.Unchecked = "unchecked";
                if (workItemObj.ActivityType == "Invoke Form")
                    CallServerSideMethod(workListCtrlName, 'ShowInvokeFormMultiSelectForm', "DataTableCondition", CallbackInvokeFormCheckStatus, 'table', workItemObj);
                else
                    CallServerSideMethod(workListCtrlName, 'BuildForGetPossibleStatusList', "DataTableCondition", CallbackCheckStatus, 'table', workItemObj);
            }
        }
    }

    //For Ajax Call -End

}


//Javascript Method which will get called when checkbox is getting clicked
//In Queue View Multi Select Mode

//This method is used for Web part integration as when we place the 
//two workitemcontrol web part in the same page the ids are conflicting so we are 
//passing the right grid clientid and replacing for multiselectqueueoptions div control clientid.

var chkQueueCheckboxclick = 0;
function callforqueuecheckboxclick(gridId) {

    var grid = ISGetObject(gridId);

    if (chkQueueCheckboxclick == 0) {
        var mulseloptqueueid = gridId.replace("WebGrid1", "multiselectqueueoptions");

        if (GetCheckedRowsCount(gridId) == 0) {
            document.getElementById(mulseloptqueueid).style.visibility = "hidden";
            document.getElementById(mulseloptqueueid).style.display = "none";
        }
        if ((document.getElementById(mulseloptqueueid).style.visibility == "hidden"
            || document.getElementById(mulseloptqueueid).style.display == "none") && GetCheckedRowsCount(gridId) > 0) {
            document.getElementById(mulseloptqueueid).style.visibility = "visible";
            document.getElementById(mulseloptqueueid).style.display = "block";

        }

    }
    chkQueueCheckboxclick++;
    
}

function ClickForMultiSelectforQueue() {
    var OptValue = document.getElementById("cboQueueOptions").value;
    MultiSelectForQueue(OptValue);
}


//Function which gets called for Multi Select Queue Options
//This method is used for Web part integration as when we place the 
//two workitemcontrol web part in the same page the ids are conflicting so we are 
//passing the right grid clientid.

function MultiSelectForQueue(selValue, gridId) {
    
    
    var viewtype = CheckForQueueView(gridId);
    if (viewtype == "Queue") {
        var intcheckedRowsCount = GetCheckedRowsCount(gridId);

        if (intcheckedRowsCount == 0)
        {
            ShowBellyBarErrorMessage(strMultiSelectQueue, strNoCheckBoxSelected);
            return;
        }
    }
    
    if (viewtype == "Queue")
    {   
        var grid = ISGetObject(gridId);
        if (selValue == "Pick Queue") {
            grid.AddInput("CheckMultiSelectType", "Pick");
        }
        else if (selValue == "Plan Queue") {
            grid.AddInput("CheckMultiSelectType", "Plan");
        }
        else if (selValue == "Allocate Queue") {
            grid.AddInput("CheckMultiSelectType", "Allocate Queue");
        }
        else if (selValue == "Recall Allocated Items") {
            grid.AddInput("CheckMultiSelectType", "Recall Allocated Items");
        }
        else if (selValue == "Reassign Queue Items") {
            grid.AddInput("CheckMultiSelectType", "Reassign Queue Items");
        }
        grid.AddInput("ISMultiSelectQueue", "Y");
        var getLoadedrows = grid.TotalLoadedRows;
        grid.AddInput("TotLoadedRows", getLoadedrows + '');
        var getGroupRows = grid.RootTable.GetGroupRows().length;
        grid.AddInput("TotGroupedRows", getGroupRows + '');
        grid.SendCustomRequest();
    }
    else
    {        
        ShowBellyBarErrorMessage(strQueueViewTitle, strNoQueueView);
        return;
    }


}

function EnableDisableQueueButtons(selValue)
{
    
    if (selValue == "Disable") {
        var btnPickElem = document.getElementById("btnPick");
        if (btnPickElem != null)
            btnPickElem.disabled = true;

        var btnPlanElem = document.getElementById("btnPlan");
        if (btnPlanElem != null)
            btnPlanElem.disabled = true;

        var btnAllocateQueueItemElem = document.getElementById("btnAllocateQueueItem");
        if (btnAllocateQueueItemElem != null)
            btnAllocateQueueItemElem.disabled = true;

        var btnRecallQueueItemsElem = document.getElementById("btnRecallQueueItems");
        if (btnRecallQueueItemsElem != null)
            btnRecallQueueItemsElem.disabled = true;

        var btnReassignQueueItemsElem = document.getElementById("btnReassignQueueItems");
        if (btnReassignQueueItemsElem != null)
            btnReassignQueueItemsElem.disabled = true;
    }
    else
    {
        var btnPickElem = document.getElementById("btnPick");
        if (btnPickElem != null)
            btnPickElem.disabled = false;

        var btnPlanElem = document.getElementById("btnPlan");
        if (btnPlanElem != null)
            btnPlanElem.disabled = false;

        var btnAllocateQueueItemElem = document.getElementById("btnAllocateQueueItem");
        if (btnAllocateQueueItemElem != null)
            btnAllocateQueueItemElem.disabled = false;

        var btnRecallQueueItemsElem = document.getElementById("btnRecallQueueItems");
        if (btnRecallQueueItemsElem != null)
            btnRecallQueueItemsElem.disabled = false;

        var btnReassignQueueItemsElem = document.getElementById("btnReassignQueueItems");
        if (btnReassignQueueItemsElem != null)
            btnReassignQueueItemsElem.disabled = false;

    }

}

//Function to check for the viewtype

//This method is changed for Web part integration as when we place the 
//two workitemcontrol web part in the same page the ids are conflicting so we are 
//passing the right grid clientid.
function CheckForQueueView(rightGridId) {
    var leftGridId = rightGridId.replace("WebGrid1", "grdLeftMenu");
    //checking for the row selection in the left menu
    var gridobj = ISGetObject(leftGridId);

    if (typeof (gridobj) != 'undefined') {
        var row = gridobj.GetSelectedObject().GetRowElement();

        if (row != null) {
            var cell = wgGetCellByName(row, "Name");
            if (cell == null) return;
            checkViewTypeArr = cell.getAttribute("hiddenViewType");
            if (checkViewTypeArr != null) {
                var QuerystringvaluesArr = checkViewTypeArr.split(',');
                var chkview = QuerystringvaluesArr[0];
                return chkview;
            }

        }
    }

}

//Function to get the Checkedrows count
function GetCheckedRowsCount(gridId) {

    var grid = ISGetObject(gridId);
    var rootTable = grid.RootTable;
    var groupRows = rootTable.GetCheckedRows().length;
    return groupRows;

}

//Function which gets called when we click on Pick button for Queue Items
function MultiSelectPick(application, userid, varmultiselect, uniqueIdForCacheKey) {

    var url = templatedirectory + "WorkItemList/processworkitem.aspx";
    var urlparameters = '?Application=' + application + '&Actorid=' + userid + '&MultiSelectView=' + varmultiselect + "&uniqueIdForCacheKey=" + uniqueIdForCacheKey + "&EnableQueueMsg=" + strTurnOnOffQueuePickMessage;
    document.getElementById("openqueueframe").src = url + urlparameters;


}
//Function which gets called when we click on Plan button for Queue Items
function MultiSelectPlan(application, userid, varmultiselect, uniqueIdForCacheKey) {
    var url = templatedirectory + "WorkItemList/PlanQueue.aspx";
    var urlparameters = '?Application=' + application + '&Actorid=' + userid + '&MultiSelectView=' + varmultiselect + "&uniqueIdForCacheKey=" + uniqueIdForCacheKey;

    var planQueueWidth = "440";
    var planQueueHeight = "210";
    
    var left = (screen.width / 2) - (planQueueWidth / 2);
    var top = (screen.height / 2) - (planQueueHeight / 2);

   
    mywindow = window.open(url + urlparameters, "PlanQueueItem", "location=0, status=0, scrollbars=0, width=" + planQueueWidth + ", height=" + planQueueHeight + ", resizable=yes,top=" + top + ", left=" + left);
    
}

//Function which gets called when we click on Allocate Queue button for Queue Items
function MultiSelectAllocateQueue(securedUrl) {
    var url = templatedirectory + "WorkItemList/AllocateQueueItem.aspx";
    //var urlparameters = '?Application=' + application + '&Actorid=' + userid + '&QueueId=' + queueid + '&MultiSelectView=' + varmultiselect + "&uniqueIdForCacheKey=" + uniqueIdForCacheKey;
    var urlparameters = '?SecuredUrl=' + securedUrl;
    var allocateQueueWidth = "550";
    var allocateQueueHeight = "325";

   

    var left = (screen.width / 2) - (allocateQueueWidth / 2);
    var top = (screen.height / 2) - (allocateQueueHeight / 2);

    mywindow = window.open(url + urlparameters, "AllocateQueueItem", "location=0, status=0, scrollbars=0, width=" + allocateQueueWidth + ", height=" + allocateQueueHeight + ", resizable=yes,top=" + top + ", left=" + left);

    
}

//Function which gets called when we click on Recall Allocate Queue Items button for Queue Items
function MultiSelectRecallAllocateQueue(application, userid, varmultiselect, varrecall, uniqueIdForCacheKey) {
    var url = templatedirectory + "WorkItemList/processworkitem.aspx";
    var urlparameters = '?Application=' + application + '&Actorid=' + userid + '&MultiSelectView=' + varmultiselect + '&Recall=' + varrecall + "&uniqueIdForCacheKey=" + uniqueIdForCacheKey + "&EnableQueueMsg=" + strTurnOnOffQueuePickMessage;
    document.getElementById("openqueueframe").src = url + urlparameters;
}

//Function which gets called when we click on Reassign Queue Items in multi select mode
function MultiSelectReassignWorkItem(securedUrl) {

    var url = templatedirectory + "WorkItemList/ReAssignWorkItem.aspx";

    var urlparameters = '?SecuredUrl='+securedUrl;

    var reassignQueueWidth = "680";
    var reassignQueueHeight = "540";

    if (navigator.userAgent.toLowerCase().indexOf('chrome') > 0) {
        reassignQueueWidth = "680";
        reassignQueueHeight = "560";
    }

    var left = (screen.width / 2) - (reassignQueueWidth / 2);
    var top = (screen.height / 2) - (reassignQueueHeight / 2);

    mywindow = window.open(url + urlparameters, "ReAssignWorkItem", "location=0, status=0, scrollbars=0, width=" + reassignQueueWidth + ", height=" + reassignQueueHeight + ", resizable=yes,top=" + top + ", left=" + left);
    //mywindow.moveTo(0, 0);
}


//Function which is used for selecting all items within a group through the contexmenu

//This method is changed for Web part integration as when we place the 
//two workitemcontrol web part in the same page the ids are conflicting so we are 
//using the rightgridIdForContextMenu variable.
function selectwithingroup() {


    var rightgridId = rightgridIdForContextMenu;
    if (rightgridId == "") {
        rightgridId = "WebGrid1";
    }


    var grid = ISGetObject(rightgridId);
    var rootTable = grid.RootTable;
    var groupRows = rootTable.GetGroupRows();


    if (groupRows != "") {
        var selectedObject = grid.GetSelectedObject().ToRowObject();
        var parentPositions = selectedObject.ParentPos.split(';');

        var parentGroup = groupRows[parentPositions[0]];
        for (var i = 1; i < parentPositions.length; i++)
            parentGroup = parentGroup.GetGroupChildRows()[parentPositions[i]];

        var parentGroupChildRows = parentGroup.GetGroupChildRows();

        for (var i = 0; i < parentGroupChildRows.length; i++) {
            var childRow = parentGroupChildRows[i];

            var cell = wgGetCellByPosition(childRow.RowElement, 0);
            if (cell.childNodes[0].checked == false) {
                cell.childNodes[0].checked = true;
                childRow.Check();
            }

        }

    }

}
//Function which is used for deselecting all items within a group through the contexmenu
//This method is changed for Web part integration as when we place the 
//two workitemcontrol web part in the same page the ids are conflicting so we are 
//using the rightgridIdForContextMenu variable.

function unselectwithingroup() {

    var rightgridId = rightgridIdForContextMenu;
    if (rightgridId == "") {
        rightgridId = "WebGrid1";
    }

    var grid = ISGetObject(rightgridId);
    var rootTable = grid.RootTable;
    var groupRows = rootTable.GetGroupRows();

    if (groupRows != "") {
        var selectedObject = grid.GetSelectedObject().ToRowObject();
        var parentPositions = selectedObject.ParentPos.split(';');

        var parentGroup = groupRows[parentPositions[0]];
        for (var i = 1; i < parentPositions.length; i++)
            parentGroup = parentGroup.GetGroupChildRows()[parentPositions[i]];

        var parentGroupChildRows = parentGroup.GetGroupChildRows();

        for (var i = 0; i < parentGroupChildRows.length; i++) {
            var childRow = parentGroupChildRows[i];

            var cell = wgGetCellByPosition(childRow.RowElement, 0);
            if (cell.childNodes[0].checked == true) {
                cell.childNodes[0].checked = false;
                childRow.Uncheck();
            }

        }
    }


}

//This method is changed for Web part integration as when we place the 
//two workitemcontrol web part in the same page the ids are conflicting so we are 
//using the rightgridIdForContextMenu variable.

function SelectWithinInboxgroup() {


    var rightgridId = rightgridIdForContextMenu;
    if (rightgridId == "") {
        rightgridId = "WebGrid1";
    }

    document.getElementById("GroupSelectionEnabledCheckBox").checked = true;

    var grid = ISGetObject(rightgridId);
    var rootTable = grid.RootTable;
    var groupRows = rootTable.GetGroupRows();

    if (groupRows != "") {
        msgshownonce = 0;
        var selectedObject = grid.GetSelectedObject().ToRowObject();
        var parentPositions = selectedObject.ParentPos.split(';');

        var parentGroup = groupRows[parentPositions[0]];
        for (var i = 1; i < parentPositions.length; i++)
            parentGroup = parentGroup.GetGroupChildRows()[parentPositions[i]];

        var parentGroupChildRows = parentGroup.GetGroupChildRows();

        for (var i = 0; i < parentGroupChildRows.length; i++) {
            var childRow = parentGroupChildRows[i];

            var cell = wgGetCellByPosition(childRow.RowElement, 0);
            if (cell.childNodes[0].checked == false) {
                cell.childNodes[0].checked = true;
                childRow.Check();

            }

        }
        callajaxoncheckboxclick(parentGroup, rightgridId);

    }

}


//Function used for GroupUi functionality
function CheckOtherRows(parentGroup, gridId) {
    var grid = ISGetObject(gridId);
    var parentGroupChildRows = parentGroup.GetGroupChildRows();

    for (var i = 0; i < parentGroupChildRows.length; i++) {
        var childRow = parentGroupChildRows[i];

        var cell = wgGetCellByPosition(childRow.RowElement, 0);

        cell.childNodes[0].checked = true;
        childRow.Check();
        var selecting = grid.RootTable.ToRowObject(grid.RootTable.GetElement(WG40.BODY, WG40.HTMLTABLE).rows[childRow.RowElement.rowIndex]);
        selecting.Select();
        callajaxonotherselectedcheckboxclick(gridId);

    }

    var timeout;
    if (parentGroupChildRows.length < 50)
        timeout = 1000;
    else
        timeout = 1500;
    window.setTimeout(function () { if (invkmultiselecturl != null && invkmultiselecturl != "") OpenMultiSelectInvokeForm(invkmultiselecturl); }, timeout);


}

//function used for unselecting all items within a group
//This method is changed for Web part integration as when we place the 
//two workitemcontrol web part in the same page the ids are conflicting so we are 
//using the rightgridIdForContextMenu variable.

function UnSelectWithinInboxgroup() {

    var rightgridId = rightgridIdForContextMenu;
    if (rightgridId == "") {
        rightgridId = "WebGrid1";
    }

    //For getting the workitemcontrol id from the hidden variable because of the functionality of 
    //multiple workitemlist Webparts in the same page         
    var hidWorkItemControlId = rightgridId.replace("WebGrid1", "hdnWorkitemControlid");
    var hidWorkItemControlIdValue = document.getElementById(hidWorkItemControlId).value;

    if (hidWorkItemControlIdValue != "")
        workListCtrlName = hidWorkItemControlIdValue;


    var grid = ISGetObject(rightgridId);
    var rootTable = grid.RootTable;
    var groupRows = rootTable.GetGroupRows();

    if (groupRows != "") {
        var selectedObject = grid.GetSelectedObject().ToRowObject();
        var parentPositions = selectedObject.ParentPos.split(';');

        var parentGroup = groupRows[parentPositions[0]];
        for (var i = 1; i < parentPositions.length; i++)
            parentGroup = parentGroup.GetGroupChildRows()[parentPositions[i]];

        var parentGroupChildRows = parentGroup.GetGroupChildRows();

        for (var i = 0; i < parentGroupChildRows.length; i++) {
            var childRow = parentGroupChildRows[i];

            var cell = wgGetCellByPosition(childRow.RowElement, 0);
            if (cell.childNodes[0].checked == true) {
                cell.childNodes[0].checked = false;
                childRow.Uncheck();
            }

        }
        CallServerSideMethod(workListCtrlName, 'ClearMultiSelectCache', "DataTableCondition", CloseGroupUIWindow, 'table', null);

    }

}

//function used for closing the groupui window
function CloseGroupUIWindow() {
    var gridDetailsId = null;

    if (rightgridIdForContextMenu != null && rightgridIdForContextMenu != '') {
        gridDetailsId = rightgridIdForContextMenu.replace("WebGrid1", "GridDetailsTD");
    }
    else if (rightGridIdforMultiSelect != null && rightGridIdforMultiSelect != '') {
        gridDetailsId = rightGridIdforMultiSelect.replace("WebGrid1", "GridDetailsTD");
    }
    
    if (gridDetailsId != null) {
        var frameel = document.getElementById(gridDetailsId).getElementsByTagName("iframe")[0];
        if (typeof (frameel) != 'undefined') {
            if (frameel.style.display == "block") {
                frameel.style.display = 'none';
                frameel.style.visibility = 'hidden';
            }
        }
    }
    else {
        if (typeof (document.getElementById("opengroupuiframe")) != 'undefined') {
            if (document.getElementById("opengroupuiframe").style.display == "block") {
                document.getElementById("opengroupuiframe").style.display = 'none';
                document.getElementById("opengroupuiframe").style.visibility = 'hidden';
            }
        }
    }

}

function trimAll(sString) {
    while (sString.substring(0, 1) == ' ') {
        sString = sString.substring(1, sString.length);
    }
    while (sString.substring(sString.length - 1, sString.length) == ' ') {
        sString = sString.substring(0, sString.length - 1);
    }
    return sString;
}



function OpenGroupUIFrame_orig(surl) {

    if (GetBrowserversion1() != 2) {
        var w = 330;
        var h = 51;
    }
    else {
        var w = 348;
        var h = 56;
    }

    var ww = document.body.clientWidth;
    var wh = document.body.clientHeight;
    var l = (ww - w) - 475;

    var t = 0; //(wh-h)/190;

    var frameel = document.getElementById("opengroupuiframe");
    frameel.style.left = l;
    frameel.style.top = t;
    frameel.style.width = w;
    frameel.style.height = h;
    frameel.style.display = "block";
    frameel.style.visibility = "visible";
    document.getElementById("opengroupuiframe").src = surl;

    //   document.getElementById("opengroupuiframe").contentWindow.location.assign(surl)


}

function OpenGroupUIFrame(surl) {
    var rightgridId = rightGridIdforMultiSelect;
    if (rightgridId == "") {
        rightgridId = rightgridIdForContextMenu;
    }
    var gridDetailsId = rightgridId.replace("WebGrid1", "GridDetailsTD");
    var webGridObj = document.getElementById(gridDetailsId);
    var left = findClientPosX(webGridObj);   

    //var left = findPosX(document.getElementById(gridDetailsId));
    var top = findClientPosY(webGridObj);

    var relativeObj = getRelativeObj(webGridObj);
    if (GetBrowserversion1() == 3)
    {
        var w = 460;
        var h = 100;
    }
    
    else
    {
        var w = 460;
        var h = 100;
    }

    var offw = document.getElementById(gridDetailsId).offsetWidth;
    var offh = document.getElementById(gridDetailsId).offsetHeight;

    var frameel = document.getElementById(gridDetailsId).getElementsByTagName("iframe")[0];
    //For getting the Showing detail window with multi select property from the hidden variable because of the functionality of 
    //multiple workitemlist Webparts in the same page         
    var hidDetWindowIncenterId = rightgridId.replace("WebGrid1", "hdnMultiSelectWindow");
    var hidDetWindowIncenterIdValue = document.getElementById(hidDetWindowIncenterId).value;

    if (hidDetWindowIncenterIdValue != "")
        strMultiSelectInCenter = hidDetWindowIncenterIdValue;

    var calculatedWidth = (w / 2);
    var calculatedHeight = (h / 2);

    if (strMultiSelectInCenter == "False") {
    frameel.style.left = (offw/2) + "px";
    frameel.style.top = calculatedHeight + "px";
    }
    else {
        frameel.style.left = (offw / 2) + "px";
        frameel.style.top = (offh / 2) - calculatedHeight + "px";
    }

    frameel.style.width = w + "px";
    frameel.style.height = h + "px";
    frameel.style.display = "block";
    frameel.style.visibility = "visible";
    frameel.src = surl;

    //   document.getElementById("opengroupuiframe").contentWindow.location.assign(surl)


}

// Key for error on reselection of the same item
var reselect = 0;
var msgshownonce = 0;
function checkSelect(chkinformationaction, invokeformmultiselectformnotset, invokeformmultiselectformnotsame, rowKeyValue) {

    var rightgridId = rightgridIdForContextMenu;
    if (rightgridId == "") {
        rightgridId = "WebGrid1";
    }


    var grid = ISGetObject(rightgridId);
    var row = null;
    var cell = null;
    var groupSelection = document.getElementById("GroupSelectionEnabledCheckBox");
    if (!groupSelection.checked) {
        row = grid.GetSelectedObject().GetRowElement();
        cell = wgGetCellByPosition(row, 0);
    }
    else if (rowKeyValue != "") {
        row = grid.GetRootTable().GetRowByKeyValue(rowKeyValue).RowElement;
        cell = wgGetCellByPosition(row, 0);
    }
    else if (grid.GetSelectedObject() == null) {
        row = grid.RootTable.GetRow(grid.CheckedRowContext.rowIndex).RowElement;
        cell = wgGetCellByPosition(row, 0);
    }
    else {
        row = grid.GetSelectedObject().GetRowElement();
        cell = wgGetCellByPosition(row, 0);
    }
    
    if (cell != null) {
        cell.childNodes[0].checked = false;
        if (reselect == 1 || groupSelection.checked) {
            if (msgshownonce == 0) // this flag is used for not showing the alert multiple times when multi select happens
            {
                var msgnum = 1;
                if (groupSelection.checked) // set that message is shown once only for multiselect , this flag is cleared for the next manual click on any check box
                    msgshownonce = 1;

                var alertmsg = strMultiSelectTry + ": <br/>" + strMultiSelectDiffActTypes;
                msgnum++;
                alertmsg = alertmsg + "<br/>" +  strMultiSelectInforInfoPath;
                if (invokeformmultiselectformnotset == 'true') {
                    msgnum++;
                    //alertmsg = alertmsg + "\n" + msgnum + ". " + strMultiSelectInvFormNotSet + ".";
                    alertmsg = alertmsg + "<br/>";
                }
                if (invokeformmultiselectformnotsame == 'true') {
                    msgnum++;
                    alertmsg = alertmsg + "<br/>" +  strMultiSelectInvFormDiffForms;
                }
                if (msgnum == 2) {
                    msgnum++;
                    alertmsg = alertmsg + "<br/>" +  strMultiSelectEnterComments;
                }
                //window.alert(alertmsg);
                ShowBellyBarErrorMessage(strWorkItemTitle, alertmsg);

            }

            return;
        }
        else {
            if (!groupSelection.checked)
                reselect = 1;


            if (invokeformmultiselectformnotset == 'true') {                
                ShowBellyBarErrorMessage(strWorkItemTitle, strMultiSelectTryThis + ": <br/>" + strMultiSelectInvFormNotSet);
                return;
            }
            if (invokeformmultiselectformnotsame == 'true') {
                ShowBellyBarErrorMessage(strWorkItemTitle, strMultiSelectTryThis + ": <br/>" + strMultiSelectInvFormDiffForms);
                return;
            }

            if (chkinformationaction == 'true') {
                ShowBellyBarErrorMessage(strWorkItemTitle, strMultiSelectTry + ": <br/>"+ strMultiSelectInforInfoPath + strMultiSelectEnterComments);
                return;
            }
            if (chkinformationaction == 'false') {
                ShowBellyBarErrorMessage(strWorkItemTitle, strMultiSelectTry + ": <br/>" + strMultiSelectDiffActTypes + strMultiSelectEnterComments);
                return;
            }

        }


    }
}

//Workitem object which is getting passed while calling ajax on row select,row context menu and multi select
function WorkItem() {
    this.ApplicationName = "";
    this.WorkFlowName = "";
    this.WorkItemId = "";
    this.FormNames = "";
    this.CheckOwnership = "";
    this.Unchecked = "";
    this.ActivityType = "";

}

function showContent() {

    var grid = ISGetObject("WebGrid1");
    if (grid.GetSelectedObject() == null) {
        alert("Please select a row."); return;
    }
    var row = ISGetObject("WebGrid1").GetSelectedObject().GetRowElement();

    var cell = wgGetCellByName(row, "ResponseBy");

    if (cell == null)
        return;


    //For getting the Urls passed from Adapter

    if (checkViewType == "Inbox") {
        var Urls = cell.getAttribute("hiddenData1");
        if (Urls == "{}" || Urls == "") {
            alert("No access rights to view the detailed page.");
            return;
        }
        var UrlsJs;
        eval("UrlJs=" + Urls);

        var urldetails = UrlJs[UrlJs._DefaultFormName];
        var urlDetailsJs;
        eval("urlDetailsJs=" + urldetails);
        OpenUrl(urlDetailsJs);
    }
}

//Ajax return method for row select on the details grid
function CallbackOwnership(context, result, response) {
    if (result != null && response.Error == false) {
        showContentView(result);
    }
    else
    {        
        ShowBellyBarErrorMessage(strWorkItemTitle, strAccessErrMsg);
    }
}

//Function to open the temp page for queue view
function OpenQueueItemDetails(context, result, response) {

    var rightgridId = rightGridIdforNavigation;
    //For getting the ReadingPane in Popup window property from the hidden variable because of the functionality of 
    //multiple workitemlist Webparts in the same page         
    var hidreadingPaneFlagId = rightgridId.replace("WebGrid1", "hdnCheckReadingpaneFlag");
    var hidreadingPaneFlagIdValue = document.getElementById(hidreadingPaneFlagId).value;

    if (hidreadingPaneFlagIdValue != "")
        checkreadingpaneflag = hidreadingPaneFlagIdValue;


    if (result != null && response.Error == false) {
        var url = templatedirectory + "WorkItemList/QueueDetailView.aspx";
        if (checkreadingpaneflag == 'False') {
            OpenWorkItemInPreviewPane(url + result);
        }
        else
        {
            OpenWorkItemInWindow(url + result, "QueueItemDetails", "location=0, status=0, scrollbars=1, width=710, height=500,left=160,top=140, resizable=yes");
        }
    }
    else
    {       
        ShowBellyBarAlertMessage(strWorkItemTitle, strAccessErrMsg);
    }



}

//function for showing the detailed view on row select of the inbox items
function showContentView(Urls) {
    

    if (Urls == "{}" || Urls == "")
    {
        ShowBellyBarAlertMessage(strWorkItemTitle, strAccessErrMsg);
        return;
    }
    var UrlsJs;

    try {
        eval("UrlJs=" + Urls);
    }
    catch (err) {        
        ShowBellyBarErrorMessage(strWorkItemTitle, strInvalidActivity);
        return;
    }

    if (UrlJs["InvalidWorkitem"] != null) {
        if (UrlJs["InvalidWorkitem"] == "true") {            
            ShowBellyBarErrorMessage(strWorkItemTitle, strInvalidWorkItem);
            return;
        }
    }

    if (UrlJs["AccessRightsNotAllowed"] != null) {
        if (UrlJs["AccessRightsNotAllowed"] == "true") {            
            ShowBellyBarAlertMessage(strWorkItemTitle, strAccessErrMsg);
            return;
        }
    }

    if (UrlJs["InvalidActivity"] != null) {
        if (UrlJs["InvalidActivity"] == "true") {            
            ShowBellyBarErrorMessage(strWorkItemTitle, strInvalidActivity);
            return;
        }
    }

    var urldetails = UrlJs[UrlJs._DefaultFormName];
    var urlDetailsJs;
    eval("urlDetailsJs=" + urldetails);
    OpenUrl(urlDetailsJs);
}


function ShowFilterBar() {
    var grid = ISGetObject('WebGrid1');
    grid.ShowFilterBar();
}

function HideFilterBar() {
    var grid = ISGetObject('WebGrid1');
    grid.HideFilterBar();

}


function OpenQueueinHiddenIframe(key) {

    if (key != "AllocateQueueItem" && key != "CanPlanItem" && key != "ReassignQueueItems") {
        var urlDetails = CurrentQueueUrlJs[key]["Uri"];
        //var templatedirectory='<%=_TemplateDirectory%>';	  
        surl = templatedirectory + "WorkItemList/" + urlDetails;
        document.getElementById("openqueueframe").src = surl;

    }
    else if (key == "AllocateQueueItem") {
        var urlDetails = CurrentQueueUrlJs[key]["Uri"];
        var Urls = urlDetails.split('?');
        var url = Urls[1];
        AllocateQueueforWorkItem(url);
    }
    else if (key == "CanPlanItem") {
        var urlDetails = CurrentQueueUrlJs[key]["Uri"];
        var Urls = urlDetails.split('?');
        var url = Urls[1];
        OpenPlanQueueforWorkItem(url);
    }
    else if (key == "ReassignQueueItems") {

        var urlDetails = CurrentQueueUrlJs[key]["Uri"];
        //var Urls=urlDetails.split('?');
        var url = urlDetails;
        ReassignWorkItem(url);

    }


    //return false;
}

function OpensubmenuQueueinHiddenIframe(parentkey, childkey) {

    var urlDetails = CurrentQueueUrlJs[parentkey]["Queues"][childkey]["Uri"];
    //var templatedirectory='<%=_TemplateDirectory%>';	  
    surl = templatedirectory + "WorkItemList/" + urlDetails;
    document.getElementById("openqueueframe").src = surl;

}

//function used to open the allocate queue item page
function AllocateQueueforWorkItem(urlparameters) {

    var url = templatedirectory + "WorkItemList/AllocateQueueItem.aspx?";

    var allocateQueueWidth = "550";
    var allocateQueueHeight = "300";

    
    var left = (screen.width / 2) - (allocateQueueWidth / 2);
    var top = (screen.height / 2) - (allocateQueueHeight / 2);


    mywindow = window.open(url + urlparameters, "AllocateQueue", "location=0, status=0, scrollbars=0, width=" + allocateQueueWidth + ", height=" + allocateQueueHeight + ", resizable=yes,top=" + top + ", left=" + left);

}

//function used to open the plan queue item page
function OpenPlanQueueforWorkItem(urlparameters) {
   
    var url = templatedirectory + "WorkItemList/PlanQueue.aspx?";
    var planQueueWidth = "440";
    var planQueueHeight = "200";

    var left = (screen.width / 2) - (planQueueWidth / 2);
    var top = (screen.height / 2) - (planQueueHeight / 2);

    mywindow = window.open(url + urlparameters, "ScheduletheQueue", "location=0, status=0, scrollbars=0, width=" + planQueueWidth + ", height=" + planQueueHeight + ", resizable=yes,top=" + top + ", left=" + left);


}


function OpenContextUrl(key) {
    var urlDetails = CurrentUrlJs[key];
    eval("var urlDetailsJs=" + urlDetails);
    OpenUrl(urlDetailsJs);
}

//function used to open the reassign workitem page
function ReassignWorkItem(urlparameters) {
    
    var url = templatedirectory + "WorkItemList/ReAssignWorkItem.aspx";

    //Added for the logic of removing Custom aspx page url
    if (urlparameters.indexOf('?') >= 0) {
        var urlsplitparameters = urlparameters.split('?');
        urlparameters = '?' + urlsplitparameters[1];

    }

    var reassignQueueWidth = "680";
    var reassignQueueHeight = "540";

    if (navigator.userAgent.toLowerCase().indexOf('chrome') > 0) {
        reassignQueueWidth = "680";
        reassignQueueHeight = "560";
    }

    var left = (screen.width / 2) - (reassignQueueWidth / 2);
    var top = (screen.height / 2) - (reassignQueueHeight / 2);

    mywindow = window.open(url + urlparameters, "ReAssignWorkItem", "location=0, status=0, scrollbars=0, width=" + reassignQueueWidth + ", height=" + reassignQueueHeight + ", resizable=yes,top=" + top + ", left=" + left);
}

//function used to open the delegate workitem page
function DelegateWorkItem(urlparameters) {

    var url = templatedirectory + "WorkItemList/DelegateWorkItem.aspx";
    //Added for the logic of removing Custom aspx page url
    if (urlparameters.indexOf('?') >= 0) {
        var urlsplitparameters = urlparameters.split('?');
        urlparameters = '?' + urlsplitparameters[1];
    }

    var reassignQueueWidth = "680";
    var reassignQueueHeight = "540";

    if (navigator.userAgent.toLowerCase().indexOf('chrome') > 0) {
        reassignQueueWidth = "680";
        reassignQueueHeight = "560";
    }

    var left = (screen.width / 2) - (reassignQueueWidth / 2);
    var top = (screen.height / 2) - (reassignQueueHeight / 2);

    mywindow = window.open(url + urlparameters, "DelegateWorkItem", "location=0, status=0, scrollbars=0, width=" + reassignQueueWidth + ", height=" + reassignQueueHeight + ", resizable=yes,top=" + top + ", left=" + left);

}

//function used to set the proirity for the workitem when called from context menu
function SetPriorityforWorkItem(urlparameters, priority) {


    var url = templatedirectory + "WorkItemList/SetPriority.aspx";
    var urlparam = urlparameters + '&Priority=' + priority;
    //Opened the page in hidden iframe so that the window won't appear in the UI
    document.getElementById("openqueueframe").src = url + urlparam;

}



function noContent() {

    var dvCnt = document.getElementById("divDocView");
    dvCnt.style.display = "none";
}




function OpenStringUrl(surl) {
    alert(surl);
}

//function used for opening the detail view
function OpenUrl(ourl) {


    var rightgridId = rightGridIdforNavigation;

    //For getting the ReadingPane in Popup window property from the hidden variable because of the functionality of 
    //multiple workitemlist Webparts in the same page         
    var hidreadingPaneFlagId = rightgridId.replace("WebGrid1", "hdnCheckReadingpaneFlag");
    var hidreadingPaneFlagIdValue = document.getElementById(hidreadingPaneFlagId).value;

    if (hidreadingPaneFlagIdValue != "")
        checkreadingpaneflag = hidreadingPaneFlagIdValue;



    var isFunction = false;
    var jsfunc = null;
    if (ourl.jsfunction && ourl.jsfunction != "") {
        jsfunc = eval(ourl.jsfunction);
        if (!jsfunc) {
            alert("No function found with name " + ourl.jsfunction);
            return;
        }
        else {
            isFunction = true;
        }
    }

    if (ourl.nonweb) {
        if (isFunction) {
            jsfunc(false, ourl.url, ourl.popf, ourl.popn, ourl.nonweb);
        }
        else {
            OpenWorkItemInHiddenIframe(ourl.url);
        }

    }
    else {

        if (ourl.pop || checkreadingpaneflag == 'True') //Open in Popup Window irrespective of Worklist display mode
        {

            if (isFunction) {
                jsfunc(true, ourl.url, ourl.popf, ourl.popn, ourl.nonweb);
            }
            else {
                OpenWorkItemInWindow(ourl.url, ourl.popn, ourl.popf);
            }

        }
        else {

            if (isFunction) {
                jsfunc(false, ourl.url, ourl.popf, ourl.popn, ourl.nonweb);
            }
            else {
                OpenWorkItemInPreviewPane(ourl.url);
            }
        }
    }
}

//Function used for opening the Native web forms in the detailed view
function NativeFormOpen(openInPopup, url, popupFeatures, popupName, isNonWeb) {

    if (!openInPopup)
        OpenWorkItemInPreviewPane(templatedirectory + "WorkItemList/WorkItemDetailView.aspx" + url);
    else
        OpenWorkItemInWindow(templatedirectory + "WorkItemList/WorkItemDetailView.aspx" + url, popupName, popupFeatures);
}

//Function used for opening the Execution view in the detailed view 
function OpenWorkflowStatusViewForm(openInPopup, url, popupFeatures, popupName, isNonWeb) {
    if (!openInPopup)
        OpenWorkItemInPreviewPane(templatedirectory + "WorkItemList/WorkflowStatusView.aspx" + url);
    else
        OpenWorkItemInWindow(templatedirectory + "WorkItemList/WorkflowStatusView.aspx" + url, popupName, popupFeatures);
}

//Function used for opening the Invoke form activity view in the detailed view 
function OpenWorkflowItemInvokeForm(openInPopup, url, popupFeatures, popupName, isNonWeb)
{
    //debugger;
    if (!openInPopup)
    {
        OpenWorkItemInPreviewPane(templatedirectory + "WorkItemList/ChooseInvokeForm.aspx" + url + "&openInIframe=yes");
    }
    else
    {
        OpenWorkItemInWindow(templatedirectory + "WorkItemList/ChooseInvokeForm.aspx" + url, popupName, popupFeatures);
    }
}

//function used for Refreshing the grid
//This method is changed for Web part integration as when we place the 
//two workitemcontrol web part in the same page the ids are conflicting so we are 
//using the rightGridIdforNavigation variable for getting the clientid of grid.

function RefreshGrid() {

    var rightgridId = rightGridIdforNavigation;
    if (rightgridId == "") {
        rightgridId = "WebGrid1";
    }

    var leftgridId = rightGridIdforNavigation;
    if (leftgridId == "") {
        leftgridId = "grdLeftMenu";
    }
    else {
        leftgridId = leftgridId.replace("WebGrid1", "grdLeftMenu");
    }


    var grid = ISGetObject(rightgridId);
    if (!(mywindow == null || typeof (mywindow) == 'undefined'))
    {
        mywindow.close();
    }

    if (GetRadWindow() != 'undefined' && GetRadWindow() != null) {
        closeRadWindow();
    }

    var leftgrid = ISGetObject(leftgridId);
    if (typeof (leftgrid) != 'undefined') {

        if (GetBrowserversion1() == "4") {
            window.setTimeout(function () { leftgrid.Refresh(); }, 5);
            if (typeof (lastselectedrowkey) == 'undefined')
            {
                window.setTimeout(function () { grid.RefreshAll(); }, 5);
            }
        }
        else {
            leftgrid.Refresh();
            if (typeof (lastselectedrowkey) == 'undefined')
            {
                grid.RefreshAll();
            }

        }

    }
    else {
        if (GetBrowserversion1() == "4") {
            window.setTimeout(function () { grid.RefreshAll(); }, 5);

        }
        else
        {
            grid.RefreshAll();
        }

    }

}

//function used for Refreshing the grid without closing the window  
//This method is changed for Web part integration as when we place the 
//two workitemcontrol web part in the same page the ids are conflicting so we are 
//using the rightGridIdforNavigation variable for getting the clientid of grid.

function RefreshGridwithoutclose() {
    var rightgridId = rightGridIdforNavigation;
    if (rightgridId == "") {
        rightgridId = "WebGrid1";
    }

    var leftgridId = rightGridIdforNavigation;
    if (leftgridId == "") {
        leftgridId = "grdLeftMenu";
    }
    else {
        leftgridId = leftgridId.replace("WebGrid1", "grdLeftMenu");
    }



    var grid = ISGetObject(rightgridId);
    var leftgrid = ISGetObject(leftgridId);

    if (typeof (leftgrid) != 'undefined') {

        
        if (GetBrowserversion1() == "4") {
            window.setTimeout(function () { leftgrid.Refresh(); }, 5);
            if (typeof (lastselectedrowkey) == 'undefined') {
                window.setTimeout(function () { grid.RefreshAll(); }, 5);
            }
        }
        else {
            leftgrid.Refresh();            
            if (typeof (lastselectedrowkey) == 'undefined') {                
                grid.RefreshAll();
            }

        }

    }
    else {
        if (GetBrowserversion1() == "4") {
            window.setTimeout(function () { grid.RefreshAll(); }, 5);

        }
        else {
            grid.RefreshAll();
        }

    }

}
//function used for Refreshing the grid from workitem detail window
//This method is changed for Web part integration as when we place the 
//two workitemcontrol web part in the same page the ids are conflicting so we are 
//using the rightGridIdforNavigation variable for getting the clientid of grid.

function RefreshGridfromdetwindow() {

    var rightgridId = rightGridIdforNavigation;
    if (rightgridId == "") {
        rightgridId = "WebGrid1";
    }

    var leftgridId = rightGridIdforNavigation;
    if (leftgridId == "") {
        leftgridId = "grdLeftMenu";
    }
    else {
        leftgridId = leftgridId.replace("WebGrid1", "grdLeftMenu");
    }


    var grid = ISGetObject(rightgridId);
    var leftgrid = ISGetObject(leftgridId);
    var checkBrowser = GetBrowserversion1();

    if (typeof (leftgrid) != 'undefined') {

        if (checkBrowser == "4" || checkBrowser == "2") {
            window.setTimeout(function () { leftgrid.Refresh(); }, 15);
        }

        else {
            leftgrid.Refresh();
        }

    }
    else {
        if (GetBrowserversion1() == "4") {
            window.setTimeout(function () { grid.RefreshAll(); }, 5);

        }
        else {
            grid.RefreshAll();
        }

    }


}

//function used for Refreshing the grid from the GroupUi Window
//This method is changed for Web part integration as when we place the 
//two workitemcontrol web part in the same page the ids are conflicting so we are 
//using the rightGridIdforMultiSelect variable for getting the clientid of grid.

function RefreshGridfromdetwindowforGroupUI() {
    var rightgridId = rightGridIdforMultiSelect;
    if (rightgridId == "") {
        rightgridId = "WebGrid1";
    }
    var leftgridId = rightGridIdforMultiSelect;
    if (leftgridId == "") {
        leftgridId = "grdLeftMenu";
    }
    else {
        leftgridId = leftgridId.replace("WebGrid1", "grdLeftMenu");
    }


    var grid = ISGetObject(rightgridId);
    var leftgrid = ISGetObject(leftgridId);

    if (typeof (leftgrid) != 'undefined') {
        if (GetBrowserversion1() == "4") {
            window.setTimeout(function () { leftgrid.Refresh(); }, 5);
            if (typeof (lastselectedrowkey) == 'undefined') {
                window.setTimeout(function () { grid.RefreshAll(); }, 5);
            }
        }
        else {
            leftgrid.Refresh();
            if (typeof (lastselectedrowkey) == 'undefined') {
                grid.RefreshAll();
            }

        }
    }
    else {
        if (GetBrowserversion1() == "4") {
            window.setTimeout(function () { grid.RefreshAll(); }, 5);

        }
        else {
            grid.RefreshAll();
        }
    }
    if (typeof (document.getElementById("divDocView")) != 'undefined') {
        if (document.getElementById("divDocView").style.visibility == "visible")
            document.getElementById("divDocView").style.visibility = 'hidden';
    }

    var gridDetailsId = rightgridId.replace("WebGrid1", "GridDetailsTD");
    if (gridDetailsId != null) {
        var frameel = document.getElementById(gridDetailsId).getElementsByTagName("iframe")[0];
        if (typeof (frameel) != 'undefined') {
            if (frameel.style.display == "block") {
                frameel.style.display = 'none';
                frameel.style.visibility = 'hidden';
            }
        }
    }
    else {
        if (typeof (document.getElementById("opengroupuiframe")) != 'undefined') {
            if (document.getElementById("opengroupuiframe").style.display == "block") {
                document.getElementById("opengroupuiframe").style.display = 'none';
                document.getElementById("opengroupuiframe").style.visibility = 'hidden';
            }
        }
    }

}

//function used for Closing the groupUi window
function ClosewindowforGroupUI() {

    var rightgridId = rightGridIdforMultiSelect;
    if (rightgridId == "") {
        rightgridId = rightgridIdForContextMenu;
    }

    var gridDetailsId = rightgridId.replace("WebGrid1", "GridDetailsTD");
    if (gridDetailsId != null) {
        var frameel = document.getElementById(gridDetailsId).getElementsByTagName("iframe")[0];
        if (typeof (frameel) != 'undefined') {
            if (frameel.style.display == "block") {
                frameel.style.display = 'none';
                frameel.style.visibility = 'hidden';
            }
        }
    }
    else {
        if (typeof (document.getElementById("opengroupuiframe")) != 'undefined') {
            if (document.getElementById("opengroupuiframe").style.display == "block") {
                document.getElementById("opengroupuiframe").style.display = 'none';
                document.getElementById("opengroupuiframe").style.visibility = 'hidden';
            }
        }
    }


    

    //For getting the workitemcontrol id from the hidden variable because of the functionality of 
    //multiple workitemlist Webparts in the same page         
    var hidWorkItemControlId = rightgridId.replace("WebGrid1", "hdnWorkitemControlid");
    var hidWorkItemControlIdValue = document.getElementById(hidWorkItemControlId).value;

    if (hidWorkItemControlIdValue != "")
        workListCtrlName = hidWorkItemControlIdValue;


    var grid = ISGetObject(rightgridId);
    var table = grid.RootTable.GetElement(WG40.BODY, WG40.HTMLTABLE);
    var rows = table.rows;

    for (var i = 0; i < rows.length; i++) {
        if (rows[i].type == "Record") {
            var cell = wgGetCellByPosition(rows[i], 0);
            if (cell.childNodes[0].checked)
                cell.childNodes[0].checked = false;
            //cell.childNodes[0].disabled = false;
        }

    }
    // This ajax call is to clear the cache for multiselect
    CallServerSideMethod(workListCtrlName, 'ClearMultiSelectCache', 'DataTableCondition', '', 'table', null);

}

function RefreshLeftGrid(gridId) {
    //var grid = ISGetObject("grdLeftMenu");
    var grid = ISGetObject(gridId);
    grid.Refresh();

}

//function used to expand the tree nodes in the LHS grid
function ExpandSelfRefRow(gridId, action) {

    var grid = ISGetObject(gridId);
    var lastObj = grid.GetSelectedObject();

    var row = grid.RootTable.GetRow(0);
    if (row.IsSelfRefRow && !row.SelfRefExpanded) {
        row.ExpandSelfRefRow();
    }
    // wgExpandSelfRefRow( grid.GetRootTable().GetElement(WG40.BODY, WG40.HTMLTABLE).rows[1]);
    for (var j = 0; j < arrSelfRowDetails.length; j++) {
        wgExpandSelfRefRow(grid.GetRootTable().GetElement(WG40.BODY, WG40.HTMLTABLE).rows[eval(arrSelfRowDetails[j])]);
    }

    var lastObj = grid.GetSelectedObject();

    if (lastObj != null) {
        lastselectedrowkey = lastObj.rowIndex;

    }
    else {
        if (typeof (lastselectedrowkey) != 'undefined') {
            var row = grid.RootTable.GetElement(WG40.BODY, WG40.HTMLTABLE).rows[lastselectedrowkey];
            if (typeof (row) != 'undefined') {
                if (checkDeleteLayouflag == 'True') {
                    var selecting = grid.RootTable.ToRowObject(grid.RootTable.GetElement(WG40.BODY, WG40.HTMLTABLE).rows[0]);
                    window.setTimeout(function () { selecting.Select(); }, 1000);
                }
                else {
                    var selecting = grid.RootTable.ToRowObject(grid.RootTable.GetElement(WG40.BODY, WG40.HTMLTABLE).rows[lastselectedrowkey]);

                    window.setTimeout(function () { selecting.Select(); }, 1000);

                }
            }
            else {
                var selecting = grid.RootTable.ToRowObject(grid.RootTable.GetElement(WG40.BODY, WG40.HTMLTABLE).rows[0]);
                window.setTimeout(function () { selecting.Select(); }, 1000);
            }
        }
    }




    //grid.Tables.WorkItemLeftMenu.SelectRow(lastselectedrowkey)        

    return true;

}

function HidePadColumn(gridId) {
    var grid = ISGetObject(gridId);
    grid.HidePadColumn = true;
}

//function used for Selecting the details row after refreshing the grid
function SelectDetailsRow(controlId, actionName, lastRequestObject, xmlResponseObject) {

    
    var leftgridid = controlId.replace("WebGrid1", "grdLeftMenu");
    var leftGridobj = ISGetObject(leftgridid);


    //For getting the ReadingPane in Popup window property from the hidden variable because of the functionality of 
    //multiple workitemlist Webparts in the same page         
    var hidreadingPaneFlagId = controlId.replace("WebGrid1", "hdnCheckReadingpaneFlag");
    var hidreadingPaneFlagIdValue = document.getElementById(hidreadingPaneFlagId).value;

    if (hidreadingPaneFlagIdValue != "")
        checkreadingpaneflag = hidreadingPaneFlagIdValue;


    //For getting the Row double click property from the hidden variable because of the functionality of 
    //multiple workitemlist Webparts in the same page         
    var hidCheckRowDblClickId = controlId.replace("WebGrid1", "hdnRowDoubleClick");
    var hidCheckRowDblClickIdValue = document.getElementById(hidCheckRowDblClickId).value;

    if (hidCheckRowDblClickIdValue != "")
        strAllowRowDoubleClick = hidCheckRowDblClickIdValue;



    //For getting the Showing detail window with multi select property from the hidden variable because of the functionality of 
    //multiple workitemlist Webparts in the same page         
    var hidAutoNextId = controlId.replace("WebGrid1", "hdnAutoMove");
    var hidAutoNextIdValue = document.getElementById(hidAutoNextId).value;

    if (hidAutoNextIdValue != "")
        strAutoMoveNextWorkItem = hidAutoNextIdValue;

    //For Disabling the opening of workitem detail view on multi select submission
    var checkimgCheck1id = controlId.replace("WebGrid1", "imgCheck1");
    var checkimbObj1 = document.getElementById(checkimgCheck1id);
    if (checkimbObj1 != null) {
        if (checkimbObj1.style.display == "none") {
            strAutoMoveNextWorkItem = "False";
        }

    }

    var chkAutoMove = document.getElementById("hidMoveNextCheckValue");
    if (chkAutoMove != null) {
        if (chkAutoMove.value == "false") {
            if (mywindow != null) {
                mywindow.close();
                chkAutoMove.value = "";
            }
            if (GetRadWindow() != 'undefined' && GetRadWindow() != null) {
                closeRadWindow();
                chkAutoMove.value = "";
            }
            return;
        }
    }


    var detailsGridobj = ISGetObject(controlId);

    //detailsGridobj.RootTable.GetRow(0).Select();

    // Commented due to column size fit, In case of More Characters in Subject
    //var prodColumn = detailsGridobj.RootTable.Columns.GetNamedItem("Subject");
    //try {
    //    prodColumn.ResizeBestFit();
    //}
    //catch (err) {

    //}



    if ((strAutoMoveNextWorkItem == "True" && mywindow != null && mywindow.closed == false) ||
        (strAutoMoveNextWorkItem == "True" && (mywindow == null || typeof (mywindow) == 'undefined')) ||
        (strAutoMoveNextWorkItem == "True" && GetRadWindow() != null && GetRadWindow().isClosed() == false) ||
        (strAutoMoveNextWorkItem == "True" && (GetRadWindow() == null || typeof (GetRadWindow()) == 'undefined'))
       ) {

        move(controlId, lastselectedrowkey1);

        if (actionName == "More" || actionName == "RefreshAll") {

            if (typeof (lastselectedrowkey1) != 'undefined') {
                if (lastselectedrowkey1 < detailsGridobj.TotalRows) {
                    if (actionName == "More") {

                        if (detailsGridobj.RootTable.GetRow(lastselectedrowkey1 + 1) != null) {

                            detailsGridobj.RootTable.GetRow(lastselectedrowkey1 + 1).Select();
                            if (strAllowRowDoubleClick == "True")
                                callajaxforautoownership(controlId);
                        }
                    }
                    else {

                        if (detailsGridobj.RootTable.GetRow(lastselectedrowkey1) != null) {

                            detailsGridobj.RootTable.GetRow(lastselectedrowkey1).Select();
                            if (strAllowRowDoubleClick == "True")
                                callajaxforautoownership(controlId);
                        }
                    }
                }
                else if (lastselectedrowkey1 == detailsGridobj.TotalRows && detailsGridobj.TotalRows != 0) {

                    var checkAutoSel1 = false;
                   
                    var getSelrowkey1 = lastselectedrowkey1;
                    while (!checkAutoSel1) {
                        getSelrowkey1 = getSelrowkey1 - 1;

                        if (detailsGridobj.RootTable.GetRow(getSelrowkey1) != null) {
                            checkAutoSel1 = true;
                            detailsGridobj.RootTable.GetRow(getSelrowkey1).Select();
                            if (strAllowRowDoubleClick == "True")
                                callajaxforautoownership(controlId);
                        }
                    }

                    // }
                }
                else if (lastselectedrowkey1 > detailsGridobj.TotalRows && detailsGridobj.TotalRows != 0) {

                    var checkAutoSel = false;

                    if (detailsGridobj.RootTable.GetRow(lastselectedrowkey1) != null) {

                        detailsGridobj.RootTable.GetRow(lastselectedrowkey1).Select();
                        if (strAllowRowDoubleClick == "True")
                            callajaxforautoownership(controlId);
                    }
                    else {

                        var getSelrowkey = lastselectedrowkey1;
                        while (!checkAutoSel) {
                            getSelrowkey = getSelrowkey - 1;

                            if (detailsGridobj.RootTable.GetRow(getSelrowkey) != null) {
                                checkAutoSel = true;
                                detailsGridobj.RootTable.GetRow(getSelrowkey).Select();
                                if (strAllowRowDoubleClick == "True")
                                    callajaxforautoownership(controlId);
                            }



                        }

                    }

                }
                else if (detailsGridobj.TotalRows == 0) {
                    if (mywindow != null) {
                        mywindow.close();
                    }
                    if (GetRadWindow() != 'undefined' && GetRadWindow() != null) {
                        closeRadWindow();
                    }

                }

                try {
                    if (typeof (mywindow) != 'undefined') {
                        if (mywindow != null) {
                            mywindow.focus();
                        }
                        if (GetRadWindow() != 'undefined' && GetRadWindow() != null) {
                            closeRadWindow();
                        }
                    }
                }
                catch (err) {
                }
            }
            else {
                if (checkreadingpaneflag == 'False') //|| actionName=="Paging")
                {
                    var chkgroupRows = detailsGridobj.RootTable.GetGroupRows();

                    if (chkgroupRows != null && chkgroupRows.length > 0) {
                        var chkPagingsel = false;
                        var initSelrowkey = 0;

                        while (!chkPagingsel) {


                            var rowdetails = detailsGridobj.RootTable.GetElement(WG40.BODY, WG40.HTMLTABLE).rows[initSelrowkey];

                            if (typeof (rowdetails) != 'undefined') {

                                var selecting = detailsGridobj.RootTable.ToRowObject(detailsGridobj.RootTable.GetElement(WG40.BODY, WG40.HTMLTABLE).rows[initSelrowkey]);
                                if (selecting.Type == "GroupHeader") {
                                    if (selecting.GroupExpanded == false)
                                        selecting.ExpandGroupRow();

                                    initSelrowkey = initSelrowkey + 1;
                                }
                                else {
                                    chkPagingsel = true;
                                    selecting.Select();

                                    if (strAllowRowDoubleClick == "True")
                                        callajaxforautoownership(controlId);

                                }


                            }

                        }

                    }
                    else {
                        var rowdetails = detailsGridobj.RootTable.GetElement(WG40.BODY, WG40.HTMLTABLE).rows[0];

                        if (typeof (rowdetails) != 'undefined') {
                            var selecting = detailsGridobj.RootTable.ToRowObject(detailsGridobj.RootTable.GetElement(WG40.BODY, WG40.HTMLTABLE).rows[0]);
                            selecting.Select();
                            //window.setTimeout(function() {selecting.Select();}, 100);
                            if (strAllowRowDoubleClick == "True")
                                callajaxforautoownership(controlId);

                        }
                    }

                }

            }




        }
    }
    //For Retaining the Grouped expanded and collapsed rows

    if (expandedGroupNodes != null) {
        var splitResult = expandedGroupNodes.split(";");
        for (var i = 0; i < splitResult.length; i++) {

            if (detailsGridobj.RootTable.GetRowByGroup(0, splitResult[i]) != null) {
                try {
                    //detailsGridobj.RootTable.GetRowByGroup(0, splitResult[i]).ExpandGroupRow();
                }
                catch (e) {

                }
            }
        }
    }


    if (checkreadingpaneflag == 'False' && strAutoMoveNextWorkItem == 'False') {
        if (detailsGridobj.LastAction == "Refresh" || detailsGridobj.LastAction == "RefreshAll") {
            var detailsGrid = ISGetObject(controlId);

            var lastObjdetailsGrid = detailsGrid.GetSelectedObject();

            if (lastObjdetailsGrid != null) {

                lastselectedrowkey1 = lastObjdetailsGrid.rowIndex;

                if (typeof (lastselectedrowkey1) != 'undefined') {
                    var rowdetails = detailsGrid.RootTable.GetElement(WG40.BODY, WG40.HTMLTABLE).rows[lastselectedrowkey1];
                    if (typeof (rowdetails) != 'undefined') {
                        var selectinggrid = detailsGrid.RootTable.ToRowObject(detailsGrid.RootTable.GetElement(WG40.BODY, WG40.HTMLTABLE).rows[lastselectedrowkey1]);

                        window.setTimeout(function () { selectinggrid.Select(); }, 400);

                    }
                    else {
                        var rowdetails = detailsGrid.RootTable.GetElement(WG40.BODY, WG40.HTMLTABLE).rows[0];

                        if (typeof (rowdetails) != 'undefined') {
                            var selecting = detailsGrid.RootTable.ToRowObject(detailsGrid.RootTable.GetElement(WG40.BODY, WG40.HTMLTABLE).rows[0]);
                            window.setTimeout(function () { selecting.Select(); }, 400);
                        }
                    }
                }
            }
            else {

                if (typeof (lastselectedrowkey1) != 'undefined') {
                    var rowdetails = detailsGrid.RootTable.GetElement(WG40.BODY, WG40.HTMLTABLE).rows[lastselectedrowkey1];
                    if (typeof (rowdetails) != 'undefined') {
                        var selectinggrid = detailsGrid.RootTable.ToRowObject(detailsGrid.RootTable.GetElement(WG40.BODY, WG40.HTMLTABLE).rows[lastselectedrowkey1]);

                        window.setTimeout(function () { selectinggrid.Select(); }, 400);

                    }
                    else {
                        var rowdetails = detailsGrid.RootTable.GetElement(WG40.BODY, WG40.HTMLTABLE).rows[0];

                        if (typeof (rowdetails) != 'undefined') {
                            var selecting = detailsGrid.RootTable.ToRowObject(detailsGrid.RootTable.GetElement(WG40.BODY, WG40.HTMLTABLE).rows[0]);
                            window.setTimeout(function () { selecting.Select(); }, 400);
                        }
                    }
                }
                else {
                    var rowdetails = detailsGrid.RootTable.GetElement(WG40.BODY, WG40.HTMLTABLE).rows[0];

                    if (typeof (rowdetails) != 'undefined') {
                        var selecting = detailsGrid.RootTable.ToRowObject(detailsGrid.RootTable.GetElement(WG40.BODY, WG40.HTMLTABLE).rows[0]);
                        window.setTimeout(function () { selecting.Select(); }, 400);
                    }

                }

            }
        }
    }
    //Code by MP
    if (detailsGridobj.IsClassicPaging() && nNo == 1) {
        detailsGridobj.GotoPage(nClassicPageNo);
        nNo = 0;
    } //

}


//Function used for naviagtion of worjitems on click of Next image in the detail view
function MoveNextWorkItemRecord() {
    
    checkClickMoveNext = "yes";
    var rightgridId = rightGridIdforNavigation;

    //For getting the Row double click property from the hidden variable because of the functionality of 
    //multiple workitemlist Webparts in the same page         
    var hidCheckRowDblClickId = rightgridId.replace("WebGrid1", "hdnRowDoubleClick");
    var hidCheckRowDblClickIdValue = document.getElementById(hidCheckRowDblClickId).value;

    if (hidCheckRowDblClickIdValue != "")
        strAllowRowDoubleClick = hidCheckRowDblClickIdValue;

    if (rightgridId == "") {
        rightgridId = "WebGrid1";
    }

    var grid = ISGetObject(rightgridId);
    var selectedObject = grid.GetSelectedObject();
    if (selectedObject != null) {
        var selObjIndex = selectedObject.rowIndex;
        var rowObj = selectedObject.GetRowObject();
        if (rowObj.Type == "GroupHeader") {
            if (rowObj.GroupExpanded == false)
                rowObj.ExpandGroupRow();
            if (strAllowRowDoubleClick == "False") {
                rowObj.GetGroupChildRows()[0].Select();
            }
            else {
                rowObj.GetGroupChildRows()[0].Select();
                callajaxforautoownership(rightgridId);
            }
        }
        else if (rowObj.Type == "Record") {
            var rowElemList = grid.RootTable.GetElement(WG40.BODY, WG40.HTMLTABLE);
            var nextRowElem = rowElemList.getElementsByTagName("tr")[selObjIndex + 1];
            var nextRow = grid.GetRowByElement(nextRowElem);
            var check = false;
            var rowind = selObjIndex;

            if (nextRow != null) {

                while (!check) {
                    if (nextRow.Type == "GroupTotalRow") {
                        nextRowElem = rowElemList.getElementsByTagName("tr")[rowind + 1];
                        if (typeof (nextRowElem) != 'undefined')
                            nextRow = grid.GetRowByElement(nextRowElem);
                        else
                            check = true;
                        rowind = rowind + 1;
                    }
                    else if (nextRow.Type == "GroupHeader") {
                        nextRowElem = rowElemList.getElementsByTagName("tr")[rowind + 1];
                        if (typeof (nextRowElem) != 'undefined') {
                            nextRow = grid.GetRowByElement(nextRowElem);
                            if (nextRow.GroupExpanded == false)
                                nextRow.ExpandGroupRow();
                            rowind = rowind + 1;
                        }
                        else
                            check = true;
                    }
                    else {
                        check = true;
                    }
                }
            }
            

            if (nextRow != null) {
                if (nextRow.Type == "Record") {
                    if (strAllowRowDoubleClick == "False") {
                        nextRow.Select();
                    }
                    else {
                        nextRow.Select();
                        callajaxforautoownership(rightgridId);
                    }
                }
                else
                {
                    
                    
                    if (nextRow.GroupExpanded == false)
                    {
                        nextRow.ExpandGroupRow();                        
                        if (strAllowRowDoubleClick == "False") {
                            nextRow.Select();
                        }
                        else {
                            nextRow.Select();
                            callajaxforautoownership(rightgridId);
                        }
                    }
                    else {
                        if (strAllowRowDoubleClick == "False") {
                            nextRow.Select();
                        }
                        else {
                            nextRow.Select();
                            callajaxforautoownership(rightgridId);
                        }
                    }
                }
            }
            else {
                if (grid.IsClassicPaging()) {
                    grid.GotoNextPage();
                }
                else {
                    wgLoadMore(grid.Id);
                }
            }

            if (mywindow != null)
                mywindow.focus();

        }
    }
    else {
        alert("Please select a row first.");
    }
}

function move(gridId, rowIndex) {

    var grid = ISGetObject(gridId);

    var rootTable = grid.RootTable;
    var groupRows = rootTable.GetGroupRows();
       
    if (rowIndex <= grid.TotalRows) {
        if (grid.TotalLoadedRows < rowIndex) {
            wgLoadMore(grid.Id);
            setTimeout(function () { move(rowIndex); }, 200)
        }
    }
    

}

//Function used for naviagtion of worjitems on click of Previous image in the detail view
function MovePreviousWorkItemRecord() {
    checkClickMoveNext = "yes";
    var rightgridId = rightGridIdforNavigation;

    //For getting the Row double click property from the hidden variable because of the functionality of 
    //multiple workitemlist Webparts in the same page         
    var hidCheckRowDblClickId = rightgridId.replace("WebGrid1", "hdnRowDoubleClick");
    var hidCheckRowDblClickIdValue = document.getElementById(hidCheckRowDblClickId).value;

    if (hidCheckRowDblClickIdValue != "")
        strAllowRowDoubleClick = hidCheckRowDblClickIdValue;


    if (rightgridId == "") {
        rightgridId = "WebGrid1";
    }


    var grid = ISGetObject(rightgridId);
    var selectedObject = grid.GetSelectedObject();
    if (selectedObject != null) {
        var selObjIndex = selectedObject.rowIndex;
        var rowObj = selectedObject.GetRowObject(); // return WebGridRow object              

        if (rowObj.Type == "GroupHeader") {
            if (rowObj.GroupExpanded == false)
                rowObj.ExpandGroupRow();
            if (strAllowRowDoubleClick == "False") {
                rowObj.GetGroupChildRows()[0].Select();
            }
            else {
                rowObj.GetGroupChildRows()[0].Select();
                callajaxforautoownership(rightgridId);
            }
        }


        else if (rowObj.Type == "Record") {
            var rowElemList = grid.RootTable.GetElement(WG40.BODY, WG40.HTMLTABLE);
            var prevRowElem = rowElemList.getElementsByTagName("tr")[selObjIndex - 1];
            var prevRow = grid.GetRowByElement(prevRowElem);

            var check = false;
            var rowind = selObjIndex;

            if (prevRow != null && prevRow.RowElement.rowIndex != 0) {
                while (!check) {
                    if (prevRow.Type == "GroupTotalRow") {
                        prevRowElem = rowElemList.getElementsByTagName("tr")[rowind - 1];
                        prevRow = grid.GetRowByElement(prevRowElem);
                        rowind = rowind - 1;
                    }
                    else if (prevRow.Type == "GroupHeader") {
                        if (prevRow.GroupExpanded == false)
                            prevRow.ExpandGroupRow();

                        prevRowElem = rowElemList.getElementsByTagName("tr")[rowind - 1];
                        prevRow = grid.GetRowByElement(prevRowElem);
                        rowind = rowind - 1;

                        if (rowind < 0) {
                            if (grid.IsClassicPaging()) {
                                grid.GotoPreviousPage();
                            }
                            check = true;
                        }
                    }
                    else {
                        check = true;
                    }
                }
            }


            if (prevRow != null) {

                if (strAllowRowDoubleClick == "False") {
                    prevRow.Select();
                }
                else {
                    if (grid.IsClassicPaging()) {
                        grid.GotoPreviousPage();
                    }
                    else {
                        prevRow.Select();
                        callajaxforautoownership(rightgridId);
                    }
                }


            }
            else {
                if (grid.IsClassicPaging()) {
                    grid.GotoPreviousPage();
                }

            }
        }

        if (mywindow != null)
            mywindow.focus();
    }
    else {
        alert("Please select a row first.");
    }



}

//added for classic paging
//var currentPage=1;
function DoBeforeRequest(gridId, action) {

    var grid = ISGetObject(gridId);
    var lastObj = grid.GetSelectedObject();
    if (lastObj != null) {

        lastselectedrowkey = lastObj.rowIndex;
        if (action == "RefreshAll" || action == "Refresh") {
            grid.AddInput("scrollTopPos", lastselectedrowkey + "");
        }
    }

    var rightGrid = gridId.replace("grdLeftMenu", "WebGrid1");

    var grid1 = ISGetObject(rightGrid);
    
    //Code by MP
    if (grid1.IsClassicPaging()) {
        nClassicPageNo = grid1.GetCurrentPage();
        nNo = 1;
    } //

    var lastObj1 = grid1.GetSelectedObject();
    if (lastObj1 != null) {
        lastselectedrowkey1 = lastObj1.rowIndex;
    }

    return true;
}

function CheckPaging(gridId, action) {
    var grid = ISGetObject(gridId);
    currentPage = grid.GetCurrentPage();

}

function CheckMore(gridId, action) {
    var grid = ISGetObject(gridId);
    var lastObjsel = grid.GetSelectedObject();
    if (action == "More") {
        if (lastObjsel != null)
            lastselectedrowkey1 = lastObjsel.rowIndex;
    }
}


function ClearSelectedRow(gridId) {
    var grdDetails = ISGetObject(gridId);
    if (grdDetails != null)
        grdDetails.ClearSelectedObject();

}


var strSelfExpRowPosition = "";
var arrSelfRowDetails = new Array();

function GetSelfRowExpRows(gridId, tblName, rowIndex, rowEl) {

    var strRowIndex = rowIndex.toString();

    if (strSelfExpRowPosition == "")
        strSelfExpRowPosition = strRowIndex;
    else {
        if (strSelfExpRowPosition.indexOf(strRowIndex) < 0) {
            strSelfExpRowPosition += "," + strRowIndex;
        }
    }
    arrSelfRowDetails = strSelfExpRowPosition.split(',');

    return true;

}

function GetSelfRowCollRows(gridId, tblName, rowIndex, rowEl) {

    var strRowIndex = rowIndex.toString();
    for (var i = 0; i < arrSelfRowDetails.length; i++) {
        if (arrSelfRowDetails[i] == strRowIndex) {
            arrSelfRowDetails.splice(i, 1);
            break;
        }
    }

    strSelfExpRowPosition = "";
    for (var k = 0; k < arrSelfRowDetails.length; k++) {
        if (strSelfExpRowPosition == "")
            strSelfExpRowPosition = arrSelfRowDetails[k];
        else
            strSelfExpRowPosition += "," + arrSelfRowDetails[k];
    }
    return true;

}


var strExpRowPosition = "";
var arrRowDetails = new Array();
var expandedGroupNodes;
function GetExpandRows(gridId, tblName, groupIndex, rowPosition, rowIndex) {

    var WebGrid1 = ISGetObject(gridId);
    StoreExpandedGroupNode(rowPosition);
    return true;

    //	    if(strExpRowPosition=="")        
    //	      strExpRowPosition=rowPosition;
    //	    else
    //	     {
    //	        if(strExpRowPosition.indexOf(rowPosition)<0)
    //	        {
    //	           strExpRowPosition+=","+rowPosition; 
    //	            
    //	        }
    //	     }
    //	     arrRowDetails=strExpRowPosition.split(',');
    //	     
    //	     return true;
}

function GetCollapseRows(gridId, tblName, groupIndex, rowPosition, rowIndex) {


    var splitResult = expandedGroupNodes.split(";");

    for (var i = 0; i < splitResult.length; i++) {
        var expandedGroupNodeTemp;

        if (splitResult[i] != rowPosition) {
            if (expandedGroupNodeTemp == null)
                expandedGroupNodeTemp = splitResult[i];
            else
                expandedGroupNodeTemp = expandedGroupNodeTemp + ";" + splitResult[i];
        }
    }

    expandedGroupNodes = expandedGroupNodeTemp;

    return true;

    //	      for(var i=0;i<arrRowDetails.length;i++)
    //	       {
    //	            if(arrRowDetails[i]==rowPosition)
    //	            {
    //	              arrRowDetails.splice(i,1);
    //	              break;
    //	            } 
    //	       }     
    //	       
    //	       strExpRowPosition="";
    //	       for(var k=0;k<arrRowDetails.length;k++)
    //	        {
    //	            if(strExpRowPosition=="")
    //	                strExpRowPosition=arrRowDetails[k];
    //	             else
    //	                strExpRowPosition+=","+arrRowDetails[k]; 
    //	        }               
    //	      return true;


}

function StoreExpandedGroupNode(nodePosition) {
    if (expandedGroupNodes == null)
        expandedGroupNodes = nodePosition;
    else
        expandedGroupNodes = expandedGroupNodes + ";" + nodePosition;

    return expandedGroupNodes;
}

function EnableDisableQueueMultiSelectButton(varcheckPickRights, varcheckPlanRights, varcheckAllocateQueueRights, varcheckRecallAllocateRights, varcheckReassignQueueRights, imgCheck1Id, mulSelQueueOptId) {

    imbObj1 = document.getElementById(imgCheck1Id);

    //For getting the Multi Select for Queue from the hidden variable because of the functionality of 
    //multiple workitemlist Webparts in the same page         
    var hidCheckDefaultQueueMultiSelectId = imgCheck1Id.replace("imgCheck1", "hdnEnableQueueMultiSelectbyDefault");
    var hidCheckDefaultQueueMultiSelectIdValue = document.getElementById(hidCheckDefaultQueueMultiSelectId).value;

    if (hidCheckDefaultQueueMultiSelectIdValue != "")
        checkEnableMultiSelectByDefaultForQueue = hidCheckDefaultQueueMultiSelectIdValue;



    if (checkEnableMultiSelectByDefaultForQueue == "True" || (imbObj1 != null && imbObj1.style.display == "none")) {

        if (varcheckPickRights == "True") {
            document.getElementById('btnPick').style.visibility = "visible";
            document.getElementById('btnPick').style.display = "inline-block";
        }
        else {
            document.getElementById('btnPick').style.visibility = "hidden";
            document.getElementById('btnPick').style.display = "none";
        }
        if (varcheckPlanRights == "True") {
            document.getElementById('btnPlan').style.visibility = "visible";
            document.getElementById('btnPlan').style.display = "inline-block";

        }
        else {
            document.getElementById('btnPlan').style.visibility = "hidden";
            document.getElementById('btnPlan').style.display = "none";
        }
        if (varcheckAllocateQueueRights == "True") {
            document.getElementById('btnAllocateQueueItem').style.visibility = "visible";
            document.getElementById('btnAllocateQueueItem').style.display = "inline-block";
        }
        else {
            document.getElementById('btnAllocateQueueItem').style.visibility = "hidden";
            document.getElementById('btnAllocateQueueItem').style.display = "none";
        }
        if (varcheckRecallAllocateRights == "True") {
            document.getElementById('btnRecallQueueItems').style.visibility = "visible";
            document.getElementById('btnRecallQueueItems').style.display = "inline-block";
        }
        else {
            document.getElementById('btnRecallQueueItems').style.visibility = "hidden";
            document.getElementById('btnRecallQueueItems').style.display = "none";

        }
        if (varcheckReassignQueueRights == "True") {
            document.getElementById('btnReassignQueueItems').style.visibility = "visible";
            document.getElementById('btnReassignQueueItems').style.display = "inline-block";
        }
        else {
            document.getElementById('btnReassignQueueItems').style.visibility = "hidden";
            document.getElementById('btnReassignQueueItems').style.display = "none";
        }


        document.getElementById(mulSelQueueOptId).style.display = 'block';
        document.getElementById(mulSelQueueOptId).style.visibility = 'visible';
    }


}

function ShowBellyBarAlertMessageWithCallBack(strTitle,strMessage)
{
    se.ui.messageDialog.showAlert(strTitle,strMessage, function ()
    {
        RefreshGridwithoutclose();
    });
}

function ShowBellyBarErrorMessage(title, message) {
    se.ui.messageDialog.showError(title, message);
}

function ShowBellyBarAlertMessage(title, message) {
    se.ui.messageDialog.showAlert(title, message);
}

function ShowBellyBarAlertMessageWithRefresh(title, message, gridId)
{
    se.ui.messageDialog.showAlert(title, message, function () {
        RefreshLeftGrid(gridId);
    });

}






