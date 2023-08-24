var menuXpos = 0;
var menuYpos = 0;

var tempX = 0
var tempY = 0

var radAjaxControlId;
var UrlJs;
var UrlJs2;
var UrlJs3;

var ListItemObj;
var ParentItemId = "00000000-0000-0000-0000-000000000000";

var breadCrumb="";
var SelCellText = "";
var _popmenu = null;
var SecurityCheck="";

var gValue;
var gName;
var gType;
var gProperties;
var gUri;
var DblClickCount=0;
var showbcrumb=1;
//added by harish for localization
var noRowSelected;
var cannotOWV;
var cannotOWVD;
var cannotOWFD;
var cannotOWVP;
var cannotOWFP;
var cannotOWF;
var sysDel;
var sysCreateTemplate;
var sysDel_WF;
var canVOIO;
var canEOIO;
var designonlyforWF;
var cannotPerDisable;
var viewdesignOnlyForWF;
var viewdesignOnlyForDL;
var viewdesignOnlyForSOA;
var norightforaction;
var associationforWFonly;
var SecurityApprovalWFAttached;
var ApprovalWFAttachedcontinue;
var NotAbleToEditFolder;
var ListName;
var designonlyforForm;
var designonlyforList;
var viewdesignOnlyForFL;
// To hold the breadcrumb clientid seperately for each listcontrol instance
var breadCrumbClientId;
// To hold the listcontrol clientid seperately for each listcontrol instance
var _ListControlId;

var _ListControlName = parent.parent.ListControlId;

var menuObject;

// This function will be called back after the Ajax call with result sent from server side.
function BuildWorkflowContextMenu(context, result, response) {        
   
    if (result != null && response.Error == false) {
        eval("UrlJs=" + result);
        eval("UrlJs2=" + result);
        eval("UrlJs3=" + result);


        cnt = 0;
        for (var key in UrlJs) {
            cnt++;
        }

        var FormMenuYpos = menuYpos;

        var name1, value1, type1, properties1, uri1, iconpath1, parentName1;

        for (var key = 0; key < cnt; key++) {
            parentName1 = eval("UrlJs[\"" + key + "\"][\"ParentName\"]");

            if (parentName1 == "") {

                name1 = eval("UrlJs[\"" + key + "\"][\"Name\"]");
                value1 = eval("UrlJs[\"" + key + "\"][\"Value\"]");
                type1 = eval("UrlJs[\"" + key + "\"][\"Type\"]");
                properties1 = eval("UrlJs[\"" + key + "\"][\"Properties\"]");
                uri1 = eval("UrlJs[\"" + key + "\"][\"Uri\"]");
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
                        if (UrlJs2[key2]["Value"] == "_sys_saveas_specific_version") {

                            for (var key3 in UrlJs3)
                            {
                                if (UrlJs3[key3]["ParentName"] == "_sys_saveas_specific_version")
                                {                                      
                                    var menuSubInnerItem = new WebMenuItem();
                                    menuSubInnerItem.Text = UrlJs3[key3]["Name"];
                                    menuSubInnerItem.Name = UrlJs3[key3]["Name"];
                                    menuSubInnerItem.OnClick = "javascript:ExecuteAction('subitems','" + UrlJs2[key2]["Value"] + "','" + UrlJs2[key2]["Type"] + "','" + UrlJs2[key2]["Properties"] + "','" + UrlJs2[key2]["Uri"] + "&version=" + UrlJs3[key3]["Properties"] + "', ListItemObj)";
                                    menuSubInnerItem.ImageURL = themeDirectoryForImages + "Repository/ListControl/Images/MenuIcons/" + UrlJs3[key3]["IconPath"] + ".png";
                                    if (menuSubItem.Items.GetNamedItem(UrlJs3[key3]["Name"]) == null)
                                        menuSubItem.Items.Add(menuSubInnerItem);
                                    
                                }
                            }
                        }
                        else if (UrlJs2[key2]["ParentName"] == "_sys_edit") {


                            for (var key3 in UrlJs3) {
                                if (UrlJs3[key3]["ParentName"] != "" && UrlJs3[key3]["ParentName"] == UrlJs2[key2]["Value"])
                                {
                                    var menuSubInnerEditItem = new WebMenuItem();
                                    menuSubInnerEditItem.Text = UrlJs3[key3]["Name"];
                                    menuSubInnerEditItem.Name = UrlJs3[key3]["Name"];
                                    menuSubInnerEditItem.OnClick = "javascript:ExecuteAction('" + UrlJs3[key3]["Name"] + "','" + UrlJs3[key3]["Value"] + "','" + UrlJs3[key3]["Type"] + "','" + UrlJs3[key3]["Properties"] + "','" + UrlJs3[key3]["Uri"] + "', ListItemObj)";
                                    menuSubInnerEditItem.ImageURL = themeDirectoryForImages + "Repository/ListControl/Images/MenuIcons/" + UrlJs3[key3]["IconPath"] + ".png";
                                    if (menuSubItem.Items.GetNamedItem(UrlJs3[key3]["Name"]) == null)
                                        menuSubItem.Items.Add(menuSubInnerEditItem);                                    
                                }
                            }
                        }
                        else if (UrlJs2[key2]["ParentName"] == "_sys_view_item_details") {
                            for (var key3 in UrlJs3) {
                                if (UrlJs3[key3]["ParentName"] != "" && UrlJs3[key3]["ParentName"] == UrlJs2[key2]["Value"])
                                {
                                    var menuSubInnerViewDetailsItem = new WebMenuItem();
                                    menuSubInnerViewDetailsItem.Text = UrlJs3[key3]["Name"];
                                    menuSubInnerViewDetailsItem.Name = UrlJs3[key3]["Name"];
                                    menuSubInnerViewDetailsItem.OnClick = "javascript:ExecuteAction('" + UrlJs3[key3]["Name"] + "','" + UrlJs3[key3]["Value"] + "','" + UrlJs3[key3]["Type"] + "','" + UrlJs3[key3]["Properties"] + "','" + UrlJs3[key3]["Uri"] + "', ListItemObj)";
                                    menuSubInnerViewDetailsItem.ImageURL = themeDirectoryForImages + "Repository/ListControl/Images/MenuIcons/" + UrlJs3[key3]["IconPath"] + ".png";
                                    if (menuSubItem.Items.GetNamedItem(UrlJs3[key3]["Name"]) == null)
                                        menuSubItem.Items.Add(menuSubInnerViewDetailsItem); 
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

     	       
        if (cnt != 0) {
            menuObject.Show(menuXpos, menuYpos);
        }
    }
} 


function OnInitialize(gridId){  
     //On grid intialize.
     var grid = wgGetGridById(gridId);
     grid.HidePadColumn = true;   

 }

 var isMozilaForGrid = false;
 function resizeOnItemClick(IsSharepoint) {

     var chk = navigator.userAgent;
     if (chk.indexOf("Firefox") > -1 ) {
         isMozilaForGrid = true;
     }
     else
     {
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

function ListItem()
{
    this.ListItemName = "";
    this.ListId = "";
    this.ListItemId = ""; 
    this.ListItemStatus = "";
    this.VersionStamp = ""
    this.SpecificVersionToSave = "";
    this.ParentItemId = "";
    this.ActionToRun = "";
    this.ItemType = "";
    this.IsVersionGrid = "N";

}
function KillWorkItem()
{
    var grd = wgGetGridById('WebGrid1');   //ISGetObject
    var checkedRows = grd.RootTable.GetCheckedRows();
    var path = "";
   
    se.ui.messageDialog.showConfirmation(
        
                        forwardwrkItemHeading,
                          killwrkIemMesg,
                          function (userResponse) {

                              if (userResponse) {
                                  if (checkedRows.length > 0) {
                                      Qstring = new Array();
                                      QWFstring = new Array();
                                      QStirngED = new Array();
                                      for (var i = 0; i < checkedRows.length; i++) {
                                          Qstring.push(wgGetCellByName(checkedRows[i], 'Execution ID').innerText);
                                          QWFstring.push(wgGetCellByName(checkedRows[i], 'Workflow Name').innerText);
                                          QStirngED.push(wgGetCellByName(checkedRows[i], 'Execution Details ID').innerText);
                                      }
                                      var Qstringstr = Qstring.join(';');
                                      var QWFstringstr = QWFstring.join(';');
                                      var QEDstringstr = QStirngED.join(';');

                                      var ExecId = document.getElementById('hdnExID');
                                      ExecId.value = Qstringstr

                                      var WFNames = document.getElementById('hdnWFNames');
                                      WFNames.value = QWFstringstr;

                                      var ExecDtlsId = document.getElementById('hdnEDtlsIds');
                                      ExecDtlsId.value = QEDstringstr
                                      path = "KillWorkItem.aspx";//?ExecutionIds="+Qstringstr+"&WFNames="+QWFstringstr+"&ExectionDtlsIds=" + QEDstringstr;
                                  }
                                  else {
                                      var row = grd.GetSelectedObject().GetRowElement();

                                      var ExecId = document.getElementById('hdnExID');
                                      ExecId.value = wgGetCellByName(row, 'Execution ID').innerText;

                                      var WFNames = document.getElementById('hdnWFNames');
                                      WFNames.value = wgGetCellByName(row, 'Workflow Name').innerText;

                                      var ExecDtlsId = document.getElementById('hdnEDtlsIds');
                                      ExecDtlsId.value = wgGetCellByName(row, 'Execution Details ID').innerText;

                                      path = "KillWorkItem.aspx";//?ExecutionIds=" + wgGetCellByName(row,'Execution ID').innerText+ "&WFNames="+ wgGetCellByName(row,'Workflow Name').innerText +"&ExectionDtlsIds=" + wgGetCellByName(row,'Execution Details ID').innerText;  
                                  }
                                  var w, h;
                                  w = screen.availWidth;
                                  h = screen.availHeight;
                                  var winLeft, winTop;
                                  winLeft = (w - 350) / 2;
                                  winTop = (h - 200) / 2;
                                  if (navigator.userAgent.indexOf("MSIE") > -1) {
                                      OpenForward(path, 'Popup||Center||Specified||350||200||0||0||', 'AbortWindow');
                                  }
                                  else {
                                      var oManager = null;
                                      try {
                                          oManager = parent.GetRadWindowManager();
                                          if (parent.location.href.indexOf("_layouts") > -1)
                                          {
                                              var templatePath = document.getElementById('hiddenTemplatePath');
                                              if (templatePath != null) {
                                                  path = templatePath.value + path;

                                              }
                                          }
                                      }
                                      catch (e) { }

                                      if (oManager == null) {
                                          oManager = window.GetRadWindowManager();
                                      }

                                      var oWnd = oManager.getWindowByName("AbortWindow");
                                      if (oWnd == null) {
                                          oManager = window.GetRadWindowManager();
                                          oWnd = oManager.getWindowByName("AbortWindow");
                                      }
                                      oWnd.set_title('Select a User');
                                      oWnd.setSize(350, 200);
                                      oWnd.setUrl(path);
                                      oWnd.hide();
                                  }
                              }
                             

                          });
        
}

// RA: Remove Work Item
function RemoveWorkItem()
{
   
    var ccount = 0
    var grd = wgGetGridById('WebGrid1');   //ISGetObject
    var checkedRows = grd.RootTable.GetCheckedRows();
    var path = "";

    se.ui.messageDialog.showConfirmation(
                            forwardwrkItemHeading,
                            removewrkItemMesg,
                            function (userResponse) {
                               
                                if (userResponse) {
                                    if (checkedRows.length > 0) {
                                        Qstring = new Array();
                                        QWFstring = new Array();
                                        QStirngED = new Array();
                                        QStringWI = new Array();

                                        for (var i = 0; i < checkedRows.length; i++) {
                                            Qstring.push(wgGetCellByName(checkedRows[i], 'Execution ID').innerText);
                                            QWFstring.push(wgGetCellByName(checkedRows[i], 'Workflow Name').innerText);
                                            QStirngED.push(wgGetCellByName(checkedRows[i], 'Execution Details ID').innerText);
                                            QStringWI.push(checkedRows[i].getAttribute("keyValue"));
                                        }
                                        var Qstringstr = Qstring.join(';');
                                        var QWFstringstr = QWFstring.join(';');
                                        var QEDstringstr = QStirngED.join(';');
                                        var QStringWIstr = QStringWI.join(';');

                                        var ExecId = document.getElementById('hdnExID');
                                        ExecId.value = Qstringstr

                                        var WFNames = document.getElementById('hdnWFNames');
                                        WFNames.value = QWFstringstr;

                                        var ExecDtlsId = document.getElementById('hdnEDtlsIds');
                                        ExecDtlsId.value = QEDstringstr

                                        var WIIds = document.getElementById('hdnWorkItemIds');
                                        WIIds.value = QStringWIstr;

                                        path = "RemoveWorkItem.aspx";//?ExecutionIds="+Qstringstr+"&WFNames="+QWFstringstr+"&ExectionDtlsIds=" + QEDstringstr;
                                    }
                                    else {
                                        var row = grd.GetSelectedObject().GetRowElement();

                                        var ExecId = document.getElementById('hdnExID');
                                        ExecId.value = wgGetCellByName(row, 'Execution ID').innerText;

                                        var WFNames = document.getElementById('hdnWFNames');
                                        WFNames.value = wgGetCellByName(row, 'Workflow Name').innerText;

                                        var ExecDtlsId = document.getElementById('hdnEDtlsIds');
                                        ExecDtlsId.value = wgGetCellByName(row, 'Execution Details ID').innerText;

                                        var WIIds = document.getElementById('hdnWorkItemIds');
                                        WIIds.value = row.getAttribute("keyValue");

                                        path = "RemoveWorkItem.aspx";//?ExecutionIds=" + wgGetCellByName(row,'Execution ID').innerText+ "&WFNames="+ wgGetCellByName(row,'Workflow Name').innerText +"&ExectionDtlsIds=" + wgGetCellByName(row,'Execution Details ID').innerText;  
                                    }

                                    var w, h;
                                    w = screen.availWidth;
                                    h = screen.availHeight;
                                    var winLeft, winTop;
                                    winLeft = (w - 350) / 2;
                                    winTop = (h - 200) / 2;
                                    if (navigator.userAgent.indexOf("MSIE") > -1) {
                                        OpenForward(path, 'Popup||Center||Specified||350||200||0||0||', 'RemoveWindow');
                                       
                                    }
                                    else {
                                        var oManager = null;
                                        try {
                                            oManager = parent.GetRadWindowManager();
                                            if (parent.location.href.indexOf("_layouts") > -1) {
                                                var templatePath = document.getElementById('hiddenTemplatePath');
                                                if (templatePath != null) {
                                                    path = templatePath.value + path;
                                                }
                                            }
                                        }
                                        catch (e) { }

                                        if (oManager == null) {
                                            oManager = window.GetRadWindowManager();
                                        }
                                        var oWnd = oManager.getWindowByName("RemoveWindow");
                                        if (oWnd == null) {
                                            oManager = window.GetRadWindowManager();
                                            oWnd = oManager.getWindowByName("RemoveWindow");
                                        }
                                        oWnd.set_title('Select a User');
                                        oWnd.setSize(350, 200);
                                        oWnd.setUrl(path);
                                        oWnd.hide();
                                    }
                                   
                                }


                            });

   
}

function OpenCWindow()
{
    var grd = wgGetGridById('WebGrid1');   //ISGetObject
    var checkedRows = grd.RootTable.GetCheckedRows();
    var path="";

    se.ui.messageDialog.showConfirmation(

                           forwardwrkItemHeading,
                           forwardWrkIemMesg,
                           function (userResponse) {

                               if (userResponse) {

                                   if (checkedRows.length > 0) {
                                       Qstring = new Array();
                                       QWFstring = new Array();
                                       QEIDstring = new Array();
                                       QEDtsIDstring = new Array();
                                       for (var i = 0; i < checkedRows.length; i++) {
                                           Qstring.push(checkedRows[i].getAttribute("keyValue"));
                                           QWFstring.push(wgGetCellByName(checkedRows[i], 'Workflow Name').innerText);
                                           QEIDstring.push(wgGetCellByName(checkedRows[i], 'Execution ID').innerText);
                                           QEDtsIDstring.push(wgGetCellByName(checkedRows[i], 'Execution Details ID').innerText);
                                       }
                                       var Qstringstr = Qstring.join(';');
                                       var QWFstringstr = QWFstring.join(';');
                                       var QEIDstringstr = QEIDstring.join(';');
                                       var QEDtsIDstringstr = QEDtsIDstring.join(';');

                                       var WFnames = document.getElementById('hdnWFNames');
                                       WFnames.value = QWFstringstr;
                                       var WIIds = document.getElementById('hdnWorkItemIds');
                                       WIIds.value = Qstringstr;
                                       var EID = document.getElementById('hdnExID');
                                       EID.value = QEIDstringstr;
                                       var EDtsID = document.getElementById('hdnEDtlsIds');
                                       EDtsID.value = QEDtsIDstringstr;

                                       path = "Forward.aspx";//?WItemIds="+Qstringstr;//+"&appname=" + appname;
                                   }
                                   else {
                                       var row = grd.GetSelectedObject().GetRowElement();

                                       var WFnames = document.getElementById('hdnWFNames');
                                       WFnames.value = wgGetCellByName(row, 'Workflow Name').innerText;
                                       var WIIds = document.getElementById('hdnWorkItemIds');
                                       WIIds.value = row.getAttribute("keyValue");

                                       var EID = document.getElementById('hdnExID');
                                       EID.value = wgGetCellByName(row, 'Execution ID').innerText;
                                       var EDtsID = document.getElementById('hdnEDtlsIds');
                                       EDtsID.value = wgGetCellByName(row, 'Execution Details ID').innerText;
                                       path = "Forward.aspx";//?WItemIds=" + row.getAttribute("keyValue");//+"&appname=" + appname;  
                                   }                                   
                                   var width, height;
                                   var w, h;
                                   w = screen.availWidth;
                                   h = screen.availHeight;

                                   if (navigator.userAgent.indexOf("MSIE") > -1) {
                                       OpenForward(path, 'Popup||Center||Specified||750||420||0||0||', 'ForwardWindow');
                                   }
                                   else {
                                       width = 750;
                                       height = 425;

                                       var winLeft, winTop;
                                       winLeft = (w - width) / 2;
                                       winTop = (h - height) / 2;
                                       var oManager = null;
                                       try {
                                           oManager = parent.GetRadWindowManager();                                          
                                           if (parent.location.href.indexOf("_layouts") > -1) {
                                               var templatePath = document.getElementById('hiddenTemplatePath');
                                               if (templatePath != null) {
                                                   path = templatePath.value + path;
                                               }
                                           }
                                       }
                                       catch (e) { }

                                       if (oManager == null) {
                                           oManager = window.GetRadWindowManager();
                                       }
                                       var oWnd = oManager.getWindowByName("ForwardWindow");
                                       if (oWnd == null) {
                                           oManager = window.GetRadWindowManager();
                                           oWnd = oManager.getWindowByName("ForwardWindow");
                                       }
                                       oWnd.set_title('Select a User');
                                       oWnd.setSize(width, height);
                                       oWnd.setUrl(path); 
                                       oWnd.setActive(true);
                                       oWnd.show();
                                   }
                               }


                           });

   
}

function OpenForward(uri,properties, windowName)
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
            
    if (document.all || document.layers) {
        w = screen.availWidth;   //getMaxWidth();    
        h = screen.availHeight; //getMaxHeight();    
    }

        winIsResizable = "1"; 
        winLeft = (w-winWidth)/2;
        winTop  = (h-winHeight)/2;
       
        var oManager = null;
        try {
            oManager = parent.GetRadWindowManager();
            if (parent.location.href.indexOf("_layouts") > -1) {
                var templatePath = document.getElementById('hiddenTemplatePath');
                if (templatePath != null) {
                    uri = templatePath.value + uri;
                }
            }
        }
        catch (e) { }

        if (oManager == null) {
         oManager = window.GetRadWindowManager();
        }

        var oWnd = oManager.getWindowByName(windowName);
        if (oWnd == null) {
            oManager = window.GetRadWindowManager();
            oWnd = oManager.getWindowByName(windowName);
        }
       oWnd.setUrl(uri);
       oWnd.setSize(winWidth, winHeight);
       oWnd.set_modal(true);
       oWnd.show(); 
}


function ShowFWIContextMenu(gridId,rowType,rowEl,rowMenu,location)
{
    
    
    var grd =wgGetGridById("WebGrid1");
 
     if (rowType != "Record")
     {
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
         
        
        if(rowType =="Record")
        {
            // hiding grid's default context menu
            for (i=0;i<=43;i++){ 
                rowMenu.Items[i].Hide();
            }            
        }
        
        menuXpos = location.X;
        menuYpos = location.Y; 
       var FormMenuYpos = menuYpos;
       
        if(menuitems!="")
        {
            menuArray = new Array();
            
           if(menuitems.indexOf(',')!=-1)
           {
               menuArray = menuitems.split(',');
              for(i=0;i<menuArray.length;i++)
              {
                if(menuArray[i]=="Forward")
                {                    
                    var mnuReassign = new WebMenuItem();
                    mnuReassign.Text = forwardItem;
                    mnuReassign.Name = "ForwardMenu";
                    mnuReassign.OnClick = "javascript:OpenCWindow()";
                    mnuReassign.ImageURL = themeDirtoPass + "Repository/ListControl/Images/MenuIcons/ManageWorkItemForward.png";
                    if (rowMenu.Items.GetNamedItem("ForwardMenu") == null)
                        rowMenu.Items.Add(mnuReassign);                    
                }
                else if(menuArray[i]=="Kill")
                {
                    var mnuKill = new WebMenuItem();
                    mnuKill.Text = abortItem;
                    mnuKill.Name = "AbortMenu";
                    mnuKill.OnClick = "javascript:KillWorkItem()";
                    mnuKill.ImageURL = themeDirtoPass + "Repository/ListControl/Images/MenuIcons/ManageWorkItemKill.png";
                    if (rowMenu.Items.GetNamedItem("AbortMenu") == null)
                        rowMenu.Items.Add(mnuKill);                  
                }
                else if (menuArray[i] == "RemoveWorkItem") {

                    var mnuRemove = new WebMenuItem();
                    mnuRemove.Text = removeWorkItem;
                    mnuRemove.Name = "RemoveWorkItem";
                    mnuRemove.OnClick = "javascript:RemoveWorkItem()";
                    mnuRemove.ImageURL = themeDirtoPass + "Repository/ListControl/Images/MenuIcons/ManageWorkItemRemove.png";
                    if (rowMenu.Items.GetNamedItem("RemoveWorkItem") == null)
                        rowMenu.Items.Add(mnuRemove);   
                }
              }
           }
           else
           {
               if (menuitems == "Forward") {
                   var mnuReassign = new WebMenuItem();
                   mnuReassign.Text = "Forward";
                   mnuReassign.Name = "ForwardMenu";
                   mnuReassign.OnClick = "javascript:OpenCWindow()";
                   mnuReassign.ImageURL = themeDirtoPass + "Repository/ListControl/Images/MenuIcons/ManageWorkItemForward.png";
                   if (rowMenu.Items.GetNamedItem("ForwardMenu") == null)
                       rowMenu.Items.Add(mnuReassign);

               }
           }
           
       }

        
}



function ShowContextMenu(gridId, rowType, rowEl, rowMenu, location)
{
   if(rowType =="Record")
        {
            // hiding grid's default context menu
            for (i=0;i<=43;i++){ 
                rowMenu.Items[i].Hide();
            }            
    }
   menuObject = rowMenu;
   //added this check for List view Readonly rendering context menu disable
   if (isReadonly=="True")
    { return; }
    frameItemTitle = SelCellText;
     // CloseCallOOut();
     var row = wgGetGridById("WebGrid1").GetSelectedObject().GetRowElement();    
     var cell = wgGetCellByName(row,"ItemType");
     //var cell = wgGetCellByName(row, "Title");   
     if(cell==null)
        return;
     
             
     //For getting the Workflowname,Workitemid and Applicationname from the attribute added to the 'Title' column.
    // var Querystringvalues = cell.getAttribute("itemDetails");
    
    // For getting the default column info form the attribute add to the 'ItemType' column.
        var defaultfield = cell.getAttribute("defaultfield");
        
        if(defaultfield==null) return;
    
        var itemdetailcell = wgGetCellByName(row,defaultfield);
        if(itemdetailcell==null) reutrn;
    
        var Querystringvalues = itemdetailcell.getAttribute("itemDetails");
        
        if(Querystringvalues == null) return;
        var QuerystringvaluesArr=Querystringvalues.split(',');                       
 
      
     
     if (rowType != "Record") return true;	
        
       
        
    try{
         var versionCell = wgGetCellByName(row, "Version");   
         var versionCellValue = versionCell.innerText;              
    }
    catch(e){
    
    }
    
 //Assigning values to the ListItem object
     ListItemObj = new ListItem();
     ListItemObj.ListItemId     = QuerystringvaluesArr[0];
     ListItemObj.ListId         = QuerystringvaluesArr[1];
     //ListItemObj.VersionStamp   = versionCellValue;
     ListItemObj.ListItemStatus = QuerystringvaluesArr[2]; 
     ListItemObj.ParentItemId   = "00000000-0000-0000-0000-000000000000";
     ListItemObj.ItemType       = QuerystringvaluesArr[3];
     ListItemObj.IsVersionGrid = "N";
     ListItemObj.VersionStamp = QuerystringvaluesArr[6];
     parent.parent.CallServerSideMethod(_ListControlName,'DefaultMenu','DefaultMenu',BuildWorkflowContextMenu,'ListItemDetails',ListItemObj);          

     menuXpos = location.X;
     menuYpos = location.Y;      
}

function IsRowSelected()
{
    if(SelCellText!="")
    {
        return true;
    }
    else
    {
        return false;
    }
}

function RowSelect(gridId, rowType, rowEl, rowMenu, location) {    
    var row = ISGetObject("WebGrid1").GetSelectedObject().GetRowElement();
    var count = 0;
    try {
        var checkedRows = ISGetObject("WebGrid1").RootTable.GetCheckedRows();
        count = checkedRows.length;
    }
    catch (e) {}
    //For Loading the Right Action Bar only for the normal list views
    if (isReadonly == "False" && count==0) {

        if (typeof (parent.LoadRightActionBar) != 'undefined') {
            parent.LoadRightActionBar();
        }
        if (typeof (parent.parent.LoadRightActionBar) != 'undefined')
            parent.parent.LoadRightActionBar();
    }

    //For Hiding the Left Action Bar Items if the List View is read only
    if (isReadonly == "True")
    {
        window.parent.$("#leftMenu").css("display", "none");
    }

        
        var rightclick;

        try{
            if (!e) var e = window.event;

            if (e.which) rightclick = (e.which == 3);
            else if (e.button) rightclick = (e.button == 2);
        }
        catch(e)
        {
        }
        
            
        // For getting the default column info form the attribute add to the 'ItemType' column.
        //var cell = wgGetCellByName(row, "Title");                      
          
        var cell = wgGetCellByName(row, "ItemType");                        
        if(cell==null)
           return;
           
         //Getting default column details
          var defaultfield = cell.getAttribute("defaultfield");
          if(defaultfield==null)
          return;
          var itemdetailcell = wgGetCellByName(row,defaultfield);
         SelCellText = itemdetailcell.innerText;
//	if(!rightclick){     
       
         var Querystringvalues = itemdetailcell.getAttribute("itemDetails");
         if(Querystringvalues == null) return;
         var QuerystringvaluesArr=Querystringvalues.split(',');  
         
         var versionCell = wgGetCellByName(row, "Version");
         ListItemObj = new ListItem();
         ListItemObj.ListItemId     = QuerystringvaluesArr[0];
         ListItemObj.ListId         = QuerystringvaluesArr[1];
         if(versionCell!=null)
              ListItemObj.VersionStamp = versionCell.innerText;  
         ListItemObj.ListItemStatus = QuerystringvaluesArr[2]; 
         ListItemObj.ParentItemId   = ParentItemId;
         ListItemObj.ItemType       = QuerystringvaluesArr[3]; 
         ListItemObj.IsVersionGrid  = "N";

        ListName = QuerystringvaluesArr[4];
        ListItemObj.VersionStamp = QuerystringvaluesArr[6];      
  
}

function ShowDetailsPane(){
    var oManager = parent.parent.GetRadWindowManager();
    var oWnd     = oManager.getWindowByName("ECWindow");

    oWnd.show();
}

function DisplayCallOutContent(context, result, response){

         eval("var UrlJsCallOut ="+result);
         
            for(var key in UrlJsCallOut)
            {            
               var qStr = UrlJsCallOut[key]["Uri"];
               var path = UrlJsCallOut[key]["Properties"];
            }
            
    //Displaying the Call out div on row select. 

    try{         
        /* parent.document.getElementById("divCallOut").style.display = "block";
         parent.document.getElementById("divCallOut").style.left = (screen.availWidth - 900)/2;;
         parent.document.getElementById("divCallOut").style.top = tempY - 50; 
         parent.document.getElementById("propertiesFrame").src = "ListItemProperties.aspx?"+qStr;
         */
        var oManager =  parent.parent.GetRadWindowManager();
        var oWnd     = oManager.getWindowByName("ECWindow");

        if (document.all || document.layers) {
           var w = screen.availWidth;  
           var h = screen.availHeight; 
        }
        oWnd.setUrl(path + "Repository/ListControl/ListItemProperties.aspx?"+qStr);
        
        oWnd.setSize(500,170);
     }
    catch(e){
    }     
}


//On cell double click - displaying child items
function DoCellClick(gridId, rowType, rowEl, rowMenu, location) {
     var row
     var cell
     var cellText
     if(wgGetGridById("WebGrid1").GetSelectedObject()!=null)
     {
         row = wgGetGridById("WebGrid1").GetSelectedObject().GetRowElement();    
          // For getting the default column info form the attribute add to the 'ItemType' column.
         //cell = wgGetCellByName(row, "Title");                        
         cell = wgGetCellByName(row, "ItemType");  
         var defaultfield = cell.getAttribute("defaultfield");
         var itemdetailcell = wgGetCellByName(row,defaultfield);
         cellText = itemdetailcell.innerText;
     }
     var add;
     var breadCrumb1="";
     
     if(itemdetailcell==null)
        return;
   
     //For getting the Workflowname,Workitemid and Applicationname         
     var Querystringvalues = itemdetailcell.getAttribute("itemDetails");
     if(Querystringvalues == null) return;
     var QuerystringvaluesArr = Querystringvalues.split(',');                       
     
     var ListItemId = QuerystringvaluesArr[0];
     var ListId = QuerystringvaluesArr[1];
     var ListItemStatus = QuerystringvaluesArr[2];
     // Get the listcontrol clientid, which is pass from the Grid.aspx.cs
     var listClientId = QuerystringvaluesArr[5];
     _ListControlId = listClientId;
     // Append the '_ctl00_ctl00_bcrumb' string to the listcontrol clientid to get the breadcrumb clientid
     var breadcrumbId = listClientId + '_ctl00_ctl00_bcrumb';
     breadCrumbClientId = breadcrumbId;
     //parent.parent.breadCrumbClientId = breadcrumbId;
    //Passing ParentItemId to access it with Request.Form
     var grid = ISGetObject(gridId);
    if (grid != null) {
         grid.AddInput("ParentItemId", ListItemId);
        grid.AddInput("breadcrumblistclick", "no");
    }

      
     ParentItemId = ListItemId;
     var bCrumb = parent.parent.document.getElementById(breadcrumbId);  //parent.parent.breadCrumbClientId parent.parent.document.getElementById("bcrumb");
     
        for(var i=0;i<=25;i++){
            try{
                // breadCrumbObject as hashtable/dictionary to hold breadcrumb array, count and breadcrumbtemp link
                if (parent.parent.breadCrumbObject[listClientId + 'Arr'] == 'undefined' || parent.parent.breadCrumbObject[listClientId + 'Arr'] == null)
                    parent.parent.breadCrumbObject[listClientId + 'Arr'] = new Array(25);
                bcArr = parent.parent.breadCrumbObject[listClientId + 'Arr'][i].split('||');
            }
            catch (e) {
                if (e.message == "Can't execute code from a freed script") {
                    try {
                        bcArr = parent.parent.breadCrumbObject[listClientId + 'Arr'][i].split('||');
                    }
                    catch (e) {
                        break;
                    }
                }
                else {
                    parent.parent.breadCrumbObject[listClientId + 'Cnt'] = i;
                    break;
                }
            }
            
            if(bcArr[0] == ListItemId)
                return;
            try {
//                if (bCrumb.innerText.replace(/^[\s]+/, '').replace(/[\s]+$/, '').replace(/[\s]{2,}/, ' ') !== '') {
                if (bCrumb.innerText.indexOf(bcArr[1]) !== -1) {
                    //breadCrumb1 += "&nbsp;&nbsp;<img src='" + tempDir + "images/arrow.gif'>&nbsp;&nbsp;<a href=\"javascript:NavigateGrid('" + bcArr[0] + "','" + parent.parent.cnt + "')\" class='bclink'>" + bcArr[1] + "</a>  ";
                    //breadCrumb1 += "&nbsp;&nbsp;<img src='" + tempDir + "images/arrow.gif'>&nbsp;&nbsp;<a href=\"javascript:NavigateGrid" + listClientId + "('" + bcArr[0] + "','" + parent.parent.cnt + "')\" class='bclink'>" + bcArr[1] + "</a>  ";
                    //parent.parent.cnt = i + 1;
                    breadCrumb1 += "&nbsp;&nbsp;<img src='" + tempDir + "images/arrow.gif'>&nbsp;&nbsp;<a href=\"javascript:NavigateGrid" + listClientId + "('" + bcArr[0] + "','" + parent.parent.breadCrumbObject[listClientId + 'Cnt'] + "')\" class='bclink'>" + bcArr[1] + "</a>  ";
                    parent.parent.breadCrumbObject[listClientId + 'Cnt'] = i + 1;
                }
            }
            catch (e) {
                //breadCrumb1 += "&nbsp;&nbsp;<img src='" + tempDir + "images/arrow.gif'>&nbsp;&nbsp;<a href=\"javascript:NavigateGrid('" + bcArr[0] + "','" + parent.parent.cnt + "')\" class='bclink'>" + bcArr[1] + "</a>  ";
                //breadCrumb1 += "&nbsp;&nbsp;<img src='" + tempDir + "images/arrow.gif'>&nbsp;&nbsp;<a href=\"javascript:NavigateGrid" + listClientId + "('" + bcArr[0] + "','" + parent.parent.cnt + "')\" class='bclink'>" + bcArr[1] + "</a>  ";
                //parent.parent.cnt = i + 1;
                breadCrumb1 += "&nbsp;&nbsp;<img src='" + tempDir + "images/arrow.gif'>&nbsp;&nbsp;<a href=\"javascript:NavigateGrid" + listClientId + "('" + bcArr[0] + "','" + parent.parent.breadCrumbObject[listClientId + 'Cnt'] + "')\" class='bclink'>" + bcArr[1] + "</a>  ";
                if (parent.parent.breadCrumbObject[listClientId + 'Cnt'] == 'undefined' || parent.parent.breadCrumbObject[listClientId + 'Cnt'] == null)
                    parent.parent.breadCrumbObject[listClientId + 'Cnt'] = new int;
                parent.parent.breadCrumbObject[listClientId + 'Cnt'] = i + 1;
            }
        }

        //parent.parent.breadCrumbArr[parent.parent.cnt] = ListItemId + "||" + cellText;
        parent.parent.breadCrumbObject[listClientId + 'Arr'][parent.parent.breadCrumbObject[listClientId + 'Cnt']] = ListItemId + "||" + cellText;
     
     breadCrumb1 += "&nbsp;&nbsp;<img src='"+tempDir+"images/arrow.gif'>&nbsp;&nbsp;<span class='bclinkinact'>"+ cellText +"  </span>";
     
//     var bCrumb = parent.parent.document.getElementById("bcrumb");
     if( bCrumb!=null)
        bCrumb.innerHTML = breadCrumb1;
     
     if(grid != null)
         grid.RefreshAll();
         
     

     return true;	     
}

// This method is reset the variables in ListMainControl.ascx, which are used to hold the BreadCrumb based on the ListControl clientID
function ResetBreadCrumbVariables() {
    try {
        parent.parent.document.getElementById(breadCrumbClientId).innerHTML = ''; //parent.parent.breadCrumbClientId
        breadCrumbObject[_ListControlId + 'Arr'] = new Array(25);
        breadCrumbObject[_ListControlId + 'Cnt'] = 0;
        breadCrumbObject[_ListControlId + 'Crumb'] = '';
        //parent.parent.breadCrumbTemp = "";
    }
    catch (e) {
    }
}


//On click of bread crumb for the List control
function NavigateGrid(ListItemId, cnt) {
     //Passing ParentItemId to access it with Request.Form
     if(ListItemId=='')
        ListItemObj = undefined;
     var grid = ISGetObject("WebGrid1");
     grid.AddInput("ParentItemId", ListItemId);   
   
     ParentItemId = ListItemId;
    
     CreateBreadCrumbString(cnt,ListItemId);
    if (cnt == "x") {
        grid.AddInput("breadcrumblistclick", "yes");
         grid.RefreshAll();
    }
    else {
        grid.AddInput("breadcrumblistclick", "no");
        grid.RefreshAll();
    }

     return true;	     
}     

function CreateBreadCrumbString(cntNew, ListItemId) {

    if (_ListControlId == undefined || _ListControlId == null)
        _ListControlId = parent.parent.ListControlClientId;

    if (breadCrumbClientId == undefined || breadCrumbClientId == null)
        breadCrumbClientId = _ListControlId + '_ctl00_ctl00_bcrumb';

    var breadCrumbArrNew = new Array(25);
    var breadCrumb1 = "";
    var breadCrumb2 = "";
    
     if(cntNew !== "x" && cntNew!==0){
        breadCrumb = "";
        var bcArr;
        
        for(var i=0;i<=25;i++){
            try{
                //if (parent.parent.breadCrumbObject[_ListControlId + 'Arr'] == 'undefined' || parent.parent.breadCrumbObject[_ListControlId + 'Arr'] == null)
                //    parent.parent.breadCrumbObject[_ListControlId + 'Arr'] = new Array(25);
                bcArr = parent.parent.breadCrumbObject[_ListControlId + 'Arr'][i].split('||');
            }
            catch(e){
                break;
            }
                  
            if(bcArr[0] == ListItemId){
                //newly added
                breadCrumb1 += "&nbsp;&nbsp;<img src='" + tempDir + "images/arrow.gif'>&nbsp;&nbsp;<span class='bclinkinact'>" + bcArr[1] + " </span>";
                breadCrumb2 += "&nbsp;&nbsp;<img src='" + tempDir + "images/arrow.gif'>&nbsp;&nbsp;<a href=\"javascript:NavigateGrid" + _ListControlId + "('" + bcArr[0] + "','" + i + "')\" class='bclink'>" + bcArr[1] + "</a>  ";
                breadCrumbArrNew[i] = bcArr[0] + "||" + bcArr[1];
                break;
            }
            else{
                //newly added
                breadCrumb1 += "&nbsp;&nbsp;<img src='" + tempDir + "images/arrow.gif'>&nbsp;&nbsp;<a href=\"javascript:NavigateGrid" + _ListControlId + "('" + bcArr[0] + "','" + i + "')\" class='bclink'>" + bcArr[1] + "</a>  ";
                breadCrumb2 += "&nbsp;&nbsp;<img src='" + tempDir + "images/arrow.gif'>&nbsp;&nbsp;<a href=\"javascript:NavigateGrid" + _ListControlId + "('" + bcArr[0] + "','" + i + "')\" class='bclink'>" + bcArr[1] + "</a>  ";
            }
            
            breadCrumbArrNew[i] = bcArr[0] + "||" + bcArr[1];
        }

        parent.parent.breadCrumbObject[_ListControlId + 'Cnt'] = i + 1;
        parent.parent.breadCrumbObject[_ListControlId + 'Arr'] = breadCrumbArrNew;
        var bCrumb = parent.parent.document.getElementById(breadCrumbClientId);  //parent.parent.breadCrumbClientId );
        if( bCrumb!=null)
            bCrumb.innerHTML = breadCrumb1;
        parent.parent.breadCrumbObject[_ListControlId + 'Crumb'] = breadCrumb2;
     }
     else
     {
         if (!(_ListControlId == undefined || _ListControlId == null)) {
             parent.parent.breadCrumbObject[_ListControlId + 'Arr'] = breadCrumbArrNew;
             parent.parent.breadCrumbObject[_ListControlId + 'Cnt'] = 0;
             parent.parent.breadCrumbObject[_ListControlId + 'Crumb'] = "";
             var bCrumb = parent.parent.document.getElementById(breadCrumbClientId);
             if (bCrumb != null)
                 bCrumb.innerHTML = "";
         }
         breadCrumb1 = "";
         ParentItemId = "00000000-0000-0000-0000-000000000000";
     }   
}

function NavigateUp(){
     //if(parent.parent.cnt !== 0){
     if(parent.parent.breadCrumbObject[_ListControlId + 'Cnt'] > 0){
        //if(parent.parent.cnt-1!==0)
         if (parent.parent.breadCrumbObject[_ListControlId + 'Cnt'] - 1 > 0)
        {
            //var arr = parent.parent.breadCrumbArr[(parent.parent.cnt-1)-1].split('||');
            var arr = parent.parent.breadCrumbObject[_ListControlId + 'Arr'][(parent.parent.breadCrumbObject[_ListControlId + 'Cnt'] - 1) - 1].split('||');
            ParentItemId = arr[0];
            //NavigateGrid(arr[0],parent.parent.cnt-1);
            NavigateGrid(arr[0], parent.parent.breadCrumbObject[_ListControlId + 'Cnt'] - 1);
        }
        else
        {
            ParentItemId = "00000000-0000-0000-0000-000000000000";
            //NavigateGrid("00000000-0000-0000-0000-000000000000",parent.parent.cnt-1);
            NavigateGrid("00000000-0000-0000-0000-000000000000", parent.parent.breadCrumbObject[_ListControlId + 'Cnt'] - 1);
        }
     }
     else{
        NavigateGrid('','x');
     }
}

//------------------------------- Fuctions to execute action request from context menu. -------------------------//

function isIE11() {
    return !!navigator.userAgent.match(/Trident.*rv[ :]*11\./);
}

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
    
    if (uri.indexOf('AuditTrail.aspx') > -1) {
        winHeight = 350;
    }

    if (uri.indexOf('ListItemProperties.aspx') > -1) {
        winHeight = 350;

    }
    if (uri.indexOf('OrganizeList.aspx') > -1) {
        winWidth = 450;
    }

    var w,h;
    var isChromeBrowser = window.navigator.userAgent.toLowerCase().indexOf('chrome') > -1;
    
    var IsIEElevenBrowser = false;
    //check if broser is IE11 
    if (isIE11())
    {
        IsIEElevenBrowser = true;
    }

    if (document.all || document.layers || isChromeBrowser || IsIEElevenBrowser) {
        w = screen.availWidth;   //getMaxWidth();    
        h = screen.availHeight; //getMaxHeight();    
    }

        winIsResizable = "1";
        
  //Checking for Window Size Property
    switch(winSize)
    {
        case "ScreenPropotional":
            winHeight = (h* 72/100);
            winWidth  = (w* 70/100); 
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

    if (uri.toLowerCase().indexOf('ssrstestrun.aspx') > -1) {
        winHeight = 650;
        if (window.navigator.userAgent.toLowerCase().indexOf('firefox') > -1)
            winHeight = 620;
        winWidth = 1000;
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
    
    //Reassert window height
    if ((uri.toLowerCase().indexOf('bamcontextmenu.aspx') > -1) || (uri.toLowerCase().indexOf('createlookuplistfromquery.aspx') > -1))
    {
        var cltHeight = parent.parent.document.body.clientHeight;
        if (winHeight > cltHeight) {
            winHeight = cltHeight - 36;//((window.navigator.userAgent.toLowerCase().indexOf('firefox') > -1) ? 36 : 0);
        }
    }

    
    
    switch(winOpenerType)
    {
        case "Popup":
            //Opening the RAD window
            var oManager;           
            oManager = parent.parent.GetRadWindowManagerForListControl();
            var oWnd = oManager.getWindowByName("ECWindow");

            if (oWnd == null) {
                oManager = window.GetRadWindowManager();
                oWnd = oManager.getWindowByName("ECWindow");
            }

            oWnd.set_title(winTitle);
            oWnd.setSize(winWidth, winHeight);

            var randomnumber = Math.floor(Math.random() * 100000);
            var date = new Date();
            var ticks = date.getTime();

            var builtUrl = '';
            if (uri.endsWith('.aspx') && uri.indexOf('?') == -1) {
                builtUrl = uri + "?radrandomcache=" + randomnumber + ticks;
            }
            else {
                builtUrl = uri + "&radrandomcache=" + randomnumber + ticks;
            }
            oWnd.setUrl(builtUrl);
            oWnd.show();
            oWnd.setActive(true);

            
            // To align the popup window to center
            try {
                if (winPosition && winPosition === "Center") {
                    oWnd.center();
                }
            }
            catch (err) { }
            break;

        case "PopupWithClose":
            //Opening the RAD window
            //  OpenWindowPopupWithClose(uri, winTitle);
            var oManager;
            
            oManager = parent.parent.GetRadWindowManagerForListControl();
            var oWnd = oManager.getWindowByName("WindowCloseBehaviour");
            oWnd.set_title(winTitle);
            oWnd.setSize(winWidth, winHeight);

            var randomnumber = Math.floor(Math.random() * 100000);
            var date = new Date();
            var ticks = date.getTime();

            var builtUrl = '';
            if (uri.endsWith('.aspx') && uri.indexOf('?') == -1) {
                builtUrl = uri + "?radrandomcache=" + randomnumber + ticks;
            }
            else {
                builtUrl = uri + "&radrandomcache=" + randomnumber + ticks;
            }

            if (gName == "_sys_create_assn")
            {
                parent.parent.CallServerSideMethod(_ListControlName, "CheckAssociationandMapping", "CheckAssociationandMapping", function (context, result, response)
                {
                    var checkAssociationMapping  = JSON.parse(result);
                    if (checkAssociationMapping.AssociationMappingExist == "AssociationandMapping")
                    {
                        se.ui.messageDialog.show({
                            title: FormBellyBarTitleMessage,
                            message: FormDataRedefineMappingMessage,
                            type: se.ui.messageDialogTypes.confirmation,
                            className: "",
                            buttonsOptions: {
                                buttons: {
                                    ok: {
                                        text: FormXMLEditMappingsButton,
                                        value: "editMappings",
                                        defaultFocus: true,
                                        callAfterCallback: function () { se.ui.messageDialog.close(); }
                                    },
                                    cancel: {
                                        text: FormXMLCancelButton,
                                        value: "cancel",
                                        defaultFocus: false,
                                        callAfterCallback: function () { se.ui.messageDialog.close(); }
                                    },
                                    custombtn: {
                                        text: FormXMLEditAssociationButton,
                                        value: "editAssociation",
                                        defaultFocus: true,
                                        callAfterCallback: function () { se.ui.messageDialog.close(); }
                                    }
                                },
                                handlerFn: function (val)
                                {
                                    if (val === "editAssociation")
                                    {
                                        parent.parent.CallServerSideMethod(_ListControlName, "EditAssociation", "EditAssociation", function (context, result, response)
                                        {
                                            var AssociationMessage = JSON.parse(result);
                                            if (AssociationMessage.AssocMsg == "")
                                            {
                                                oWnd.setUrl(builtUrl);
                                                oWnd.show();
                                                oWnd.setActive(true);

                                                try
                                                {
                                                    if (winPosition && winPosition === "Center")
                                                    {
                                                        oWnd.center();
                                                    }
                                                }
                                                catch (err) { }
                                            }
                                            else
                                            {
                                                se.ui.messageDialog.showAlert(FormBellyBarTitleMessage, (FormAlreadyHasMappingMessage + " " + AssociationMessage.AssocMsg));
                                            }

                                        }, 'ListItemDetails', ListItemObj); 
                                    }

                                    if (val === "cancel")
                                    {
                                    }

                                    if (val === "editMappings")
                                    {
                                        parent.parent.CallServerSideMethod(_ListControlName, "EditMapping", "EditMapping", function (context, result, response)
                                        {
                                            var Mapping = JSON.parse(result);
                                            if (Mapping.MappingClick != "")
                                            {
                                                oWnd.setUrl(Mapping.MappingClick);
                                                oWnd.show();
                                                oWnd.setActive(true);

                                                try
                                                {
                                                    if (winPosition && winPosition === "Center")
                                                    {
                                                        oWnd.center();
                                                    }
                                                }
                                                catch (err) { }
                                            }

                                        }, 'ListItemDetails', ListItemObj);
                                    }
                                }
                            }
                        });
                    }
                    else if (checkAssociationMapping.AssociationMappingExist == "Association")
                    {
                        se.ui.messageDialog.show({
                            title: FormBellyBarTitleMessage,
                            message: FormDataRedefineAssociationMessage,
                            type: se.ui.messageDialogTypes.confirmation,
                            className: "",
                            buttonsOptions: {
                                buttons: {
                                    ok: {
                                        text: FormXMLEditAssociationButton,
                                        value: "editAssociation",
                                        defaultFocus: true,
                                        callAfterCallback: function () { se.ui.messageDialog.close(); }
                                    },
                                    cancel: {
                                        text: FormXMLCancelButton,
                                        value: "cancel",
                                        defaultFocus: false,
                                        callAfterCallback: function () { se.ui.messageDialog.close(); }
                                    }
                                },
                                handlerFn: function (val)
                                {
                                    if (val === "editAssociation")
                                    {
                                        parent.parent.CallServerSideMethod(_ListControlName, "EditAssociation", "EditAssociation", function (context, result, response)
                                        {
                                            var AssociationMessage = JSON.parse(result);
                                            if (AssociationMessage.AssocMsg == "")
                                            {
                                                oWnd.setUrl(builtUrl);
                                                oWnd.show();
                                                oWnd.setActive(true);

                                                try
                                                {
                                                    if (winPosition && winPosition === "Center")
                                                    {
                                                        oWnd.center();
                                                    }
                                                }
                                                catch (err) { }
                                            }
                                            else if (AssociationMessage.ErrorMsg)
                                            {
                                                se.ui.messageDialog.showAlert(FormBellyBarTitleMessage, AssociationMessage.ErrorMsg);
                                            }
                                            else
                                            {
                                                se.ui.messageDialog.showAlert(FormBellyBarTitleMessage, (FormAlreadyHasMappingMessage + " " + AssociationMessage.AssocMsg));
                                            }

                                        }, 'ListItemDetails', ListItemObj);
                                    }
                                }
                            }
                        });
                    }
                    else
                    {
                        oWnd.setUrl(builtUrl);
                        oWnd.show();
                        oWnd.setActive(true);

                        try
                        {
                            if (winPosition && winPosition === "Center")
                            {
                                oWnd.center();
                            }
                        }
                        catch (err) { }
                    }

                }, 'ListItemDetails', ListItemObj); 
            }
            else
            {
                oWnd.setUrl(builtUrl);
                oWnd.show();
                oWnd.setActive(true);
            }
            // To align the popup window to center
            try {
                if (winPosition && winPosition === "Center") {
                    oWnd.center();
                }
            }
            catch (err) { }
            break;

        case "HidePopup":
            var oManager;
            oManager = parent.parent.GetRadWindowManagerForListControl();
            var oWnd = oManager.getWindowByName("WindowCloseBehaviour");
            oWnd.set_title(winTitle);

            var randomnumber = Math.floor(Math.random() * 100000);
            var date = new Date();
            var ticks = date.getTime();

            var builtUrl = '';
            if (uri.endsWith('.aspx') && uri.indexOf('?') == -1) {
                builtUrl = uri + "?radrandomcache=" + randomnumber + ticks;
            }
            else {
                builtUrl = uri + "&radrandomcache=" + randomnumber + ticks;
            }

            builtUrl += "&fromList=" + ((builtUrl.indexOf("/Delete.aspx") !== -1)?"1":"0");

            oWnd.setUrl(builtUrl);
            oWnd.hide();            


            // To align the popup window to center
            try {
                if (winPosition && winPosition === "Center") {
                    if (oWnd.isVisible() == true) {
                        oWnd.center();
                    }
                }
            }
            catch (err) { }
            break;

        case "Inplace":
            //opening the url in the same browser window
            parent.document.location.href = uri;

            if (SelCellText !== "") {                
                // Use breadCrumbClientId instead of _ListControlId + 'Crumb'
                var bCrumbTemp = parent.parent.breadCrumbObject[_ListControlId + 'Crumb']; //breadCrumbClientId
                if (bCrumbTemp == 'undefined' || bCrumbTemp == null)
                    bCrumbTemp = '';
                breadCrumb = bCrumbTemp + "&nbsp;&nbsp;<img src='" + tempDir + "images/arrow.gif'>&nbsp;&nbsp;<span class='bclinkinact'>" + SelCellText + "  </span>";
                parent.parent.breadCrumbObject[_ListControlId + 'Crumb'] = bCrumbTemp + "&nbsp;&nbsp;<img src='" + tempDir + "images/arrow.gif'>&nbsp;&nbsp;<a href=\"javascript:NavigateGrid" + _ListControlId + "('" + ListItemObj.ListItemId + "','" + parent.parent.breadCrumbObject[_ListControlId + 'Cnt'] + "')\" class='bclink'>" + SelCellText + "</a>  ";
                parent.parent.breadCrumbObject[_ListControlId + 'Arr'][parent.parent.breadCrumbObject[_ListControlId + 'Cnt']] = ListItemObj.ListItemId + "||" + SelCellText;
                parent.parent.breadCrumbObject[_ListControlId + 'Cnt']++;

                //var bCrumb = parent.parent.document.getElementById(parent.parent.breadCrumbClientId);  //parent.parent.document.getElementById("bcrumb");
                //var bCrumb = parent.parent.document.getElementById(breadCrumbClientId);
                var bCrumb = parent.parent.breadCrumbObject[breadCrumbClientId];
                if (typeof(bCrumb) == 'undefined')
                    bCrumb = parent.parent.document.getElementById(breadCrumbClientId);
                if (bCrumb != null)
                    bCrumb.innerHTML = breadCrumb;
            }
            break;

        case "Window":
            //opening normal browser window
            frameItemTitle = ReplaceSpecialCharacters(frameItemTitle);
            window.open(uri,frameItemTitle,"left="+winLeft+",top="+winTop+",width="+winWidth+",height="+winHeight+",resizable="+winIsResizable+",scrollbars="+winIsScrollable+"\"");
            
        break;
    }

}

function ReplaceSpecialCharacters(Source)
{
    var temp = Source;
    var charData;
    for (var i = 0; i < Source.length; i++) {
        var charData;
        charData = Source.substring(i, i + 1);
        match = charData.match(/[a-zA-Z]/)
        if (match == null) {
            temp = temp.replace(charData, "");
        }
    }
    return temp;
}

function DoCellDblClick(gridId, tblName, rowIndex, cellIndex) {
    var listItem;
    var itemTypeColumn;
    var actionToPerform;
    if (wgGetGridById("WebGrid1").GetSelectedObject() != null) {
        listItem = wgGetGridById("WebGrid1").GetSelectedObject().GetRowElement();
        itemTypeColumn = wgGetCellByName(listItem, "ItemType");
        var defaultfield = itemTypeColumn.getAttribute("defaultfield");
        var itemdetailcell = wgGetCellByName(listItem, defaultfield);
    }

    if (itemdetailcell == null)
        return;

    var Querystringvalues = itemdetailcell.getAttribute("itemDetails");
    if (Querystringvalues == null) return;
    var QuerystringvaluesArr = Querystringvalues.split(',');
    actionToPerform = QuerystringvaluesArr[7];
    if (actionToPerform == null || actionToPerform == "")
        return;

    if (isReadonly == "True" && QuerystringvaluesArr[3] != "0") {
        return;
    }
     
    if (actionToPerform == "_sys_showChildItems") {
        ExecuteActionName(actionToPerform);
    }
    else {
        ExecuteActionForSelectedRow(actionToPerform);
    }
}

function DoClick(gridId, tblName, rowIndex, cellIndex) 
{
    DoCellDblClick();
}

function ExecuteAction(name, value, type, properties, uri, itemObj) {
    gValue = name;
    gName = value;
    gType = type;
    gProperties = properties;
    gUri = uri;
    
    // If user selects an item and click on action which will be opened inplace(ex: Settings, Association etc.), build breadcrumb
    if(showbcrumb==1)
    {
        if(properties.indexOf('Inplace') != -1)
        {
           DoCellClick();
        }
    }
    else {
        if(name !== 'Show Child Item')
            SelCellText="";
    }
    
   if(ListItemObj !== undefined){
        ListItemObj.ActionToRun = value;
    }
    else{
        ListItemObj = itemObj;
        
   }
   /* if(value=="_sys_newfolder")
    {
        ListItemObj = itemObj;
    }*/

    //var bCrumb = parent.parent.document.getElementById(parent.parent.breadCrumbClientId);  //parent.parent.document.getElementById("bcrumb");
    var bCrumb = parent.parent.document.getElementById(breadCrumbClientId);
    if( bCrumb!=null && bCrumb.innerHTML=="" && value.indexOf("_sys_new")!=-1)
        parent.parent.CallServerSideMethod(_ListControlName,"CheckSecuirtyStatus","CheckSecuirtyStatus",SetSecurityCheckResponse,'ListItemDetails',itemObj);          
    else if(bCrumb!=null && bCrumb.innerHTML !="" && value.indexOf("_sys_new")!=-1)
        {
            //var listitem = parent.parent.breadCrumbArr[(parent.parent.cnt)-1].split('||');
            var listitem = parent.parent.breadCrumbObject[_ListControlId + 'Arr'][parent.parent.breadCrumbObject[_ListControlId + 'Cnt'] - 1].split('||');
            //if(parent.parent.cnt==1)
            if (parent.parent.breadCrumbObject[_ListControlId + 'Cnt'] == 1) {
                ListItemObj.ListItemId = listitem[0];
                if (value === "_sys_newfolder" && gUri.indexOf("&parentItemId=") == -1) {
                    gUri += "&parentItemId=" + ParentItemId;
                }

                ListItemObj.ParentItemId = "00000000-0000-0000-0000-000000000000"
            }
            else
            {
                ListItemObj.ListItemId = listitem[0];
                //var parentitem = parent.parent.breadCrumbArr[(parent.parent.cnt)-2].split('||');
                var parentitem = parent.parent.breadCrumbObject[_ListControlId + 'Arr'][parent.parent.breadCrumbObject[_ListControlId + 'Cnt'] - 2].split('||');
                ListItemObj.ParentItemId = parentitem[0];
            }
             parent.parent.CallServerSideMethod(_ListControlName,"CheckSecuirtyStatus","CheckSecuirtyStatus",SetSecurityCheckResponse,'ListItemDetails',ListItemObj); 
        }
    else
        parent.parent.CallServerSideMethod(_ListControlName,"CheckSecuirtyStatus","CheckSecuirtyStatus",SetSecurityCheckResponse,'ListItemDetails',ListItemObj);
  
    if(properties.indexOf('Inplace') == -1)
        SelCellText = "";    
    
    //DblClickCount=0;      
}


// Sending RAD Ajax request to server for actions of type 'SystemAction'
function SendRequestToServer(commandName, parameter)
{
    var o = new Object();
    o["command"] = commandName;
    o["parameter"] = parameter;
     
   var ajaxArgs = parent.parent.stringify(o);
   
   try{
        eval(parent.parent.radAjaxControlId.ajaxRequest(ajaxArgs));
      //  alert("Action performed successfully.");
        setTimeout("RefreshGrid()",750);
      //  RefreshGrid();
   }
   catch(err){
        alert(err.description);
   }

}

function SetSecurityCheckResponse(context, result, response)
{
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
    else if(rightValue == "4"){
        SecurityCheck = "AAWP"; //Attached Approval Workflow Pending hence could not perform action.
    }
    else if(rightValue == "5"){
        SecurityCheck = "OVW";
        }
    else if(rightValue == "6"){
        SecurityCheck = "DIS";
        }    
    else if(rightValue == "7"){
        SecurityCheck = "OWPUBFRM";
        }
     else if(rightValue == "8"){
        SecurityCheck = "OWNEDONLY";
        }  
             
//    alert(rightValue);

    if (_ListControlId == undefined || _ListControlId == null)
        _ListControlId = parent.parent.ListControlClientId;
         
    if(SecurityCheck == "DNL"){
        // alert("You do not have rights to perform this action.");
        if (norightforaction == null || norightforaction == undefined)
            norightforaction = "You do not have rights to perform this action.";
        //var bCrumb = parent.parent.document.getElementById(parent.parent.breadCrumbClientId);  //parent.parent.document.getElementById("bcrumb");
        var bCrumb = parent.parent.document.getElementById(breadCrumbClientId);
        //        bCrumb.innerText = bCrumb.innerText.replace(SelCellText, '');
                
        //        bCrumb.innerHTML = bCrumb.innerHTML.replace(SelCellText, '');
//        if (bCrumb != null)
//            NavigateUp();
            //bCrumb.innerHTML = "";
       // alert(norightforaction);
        se.ui.messageDialog.showAlert(belSecurityHead, norightforaction);
        return; 
    }
   if(SecurityCheck == "AAWP"){
       // alert("The security approval workflow that is attached to the item is pending,you can not perform this action now.");
       if (SecurityApprovalWFAttached == null || SecurityApprovalWFAttached == undefined)
           SecurityApprovalWFAttached = "The security approval workflow that is attached to the item is pending,you can not perform this action now.";
      // alert(SecurityApprovalWFAttached);
       se.ui.messageDialog.showAlert(belSecurityHead, SecurityApprovalWFAttached);
       return;
    }
    
   if (SecurityCheck == "AWP") {
        //if(!confirm("There is an approval workflow involved to perform this action. Do you want to continue?")){
        if (ApprovalWFAttachedcontinue == null || ApprovalWFAttachedcontinue == undefined)
            ApprovalWFAttachedcontinue = "There is an approval workflow involved to perform this action. Do you want to continue?";
       // if (!confirm(ApprovalWFAttachedcontinue)) {
       //     SecurityCheck = "DNL";

      //      return;
        //  }
        se.ui.messageDialog.showConfirmation(bellstMsg, ApprovalWFAttachedcontinue,
                       function (userResponse) {
                           if (userResponse) {
                              SetSecurityCheckResponseForBellyBar(name, value, type, properties, uri);
                           }
                           else {
                              SecurityCheck = "DNL";
                           }
                       });
        return false;
    }

   SetSecurityCheckResponseForBellyBar(name, value, type, properties, uri);
                   
}

function executeOpenFile(value, name, parent, uri, properties) {   
    if (value == "_sys_saveas_specific_version" && name !== "subitems") {
        return;
    }

    if (value == "_sys_security_settings" || value == "_sys_create_assn" || value == "_sys_showallversions") {
        if (typeof (parent.WorkflowjsonObj) != 'undefined') {

            parent.WorkflowjsonObj = "";
            parent.LoadActionBar();
        }
    }

    if (value == "_sys_publish" && uri.indexOf("PackageTemplate") == -1)
    {
        parent.parent.CallServerSideMethod(_ListControlName, "PublishListItem", "PublishListItem", function (context, result, response)
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

        }, "ListItemDetails", ListItemObj);

        return;
    }

    if (value == "_sys_unpublish" && uri.indexOf("PackageTemplate") == -1)
    {
        parent.parent.CallServerSideMethod(_ListControlName, "UnpublishListItem", "UnpublishListItem", function (context, result, response)
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

        }, "ListItemDetails", ListItemObj);

        return;
    }

    OpenFile(uri, properties);
}

function ExecuteActionName(actionName){
    //Assigning values to the ListItem object
    if(DblClickCount=0)
        showbcrumb =0;
     var ParentListItemObj = new ListItem();
     ParentListItemObj.ParentItemId = ParentItemId;
     ParentListItemObj.ListItemId = "00000000-0000-0000-0000-000000000000";
     ParentListItemObj.ListId = "00000000-0000-0000-0000-000000000000";
     ParentListItemObj.ActionToRun = actionName;
     ParentListItemObj.IsVersionGrid = "N";
 
     parent.parent.CallServerSideMethod(_ListControlName,"ExecuteAction","ExecuteAction",ProcessAjaxResponse,'ListItemDetails',ParentListItemObj);          
     showbcrumb =1;
}

// called from the Ribbon bar actions.

function ExecuteActionByName(actionName){
    if (actionName == '_sys_new' || actionName === '_sys_newquickflow')
        frameItemTitle = _ListControlName;
    //Assigning values to the ListItem object
     showbcrumb =0;
     var ParentListItemObj = new ListItem();
     ParentListItemObj.ParentItemId = ParentItemId;
     ParentListItemObj.ListItemId = "00000000-0000-0000-0000-000000000000";
     ParentListItemObj.ListId = "00000000-0000-0000-0000-000000000000";
     ParentListItemObj.ActionToRun = actionName;
     ParentListItemObj.IsVersionGrid = "N";

     // Get ListId from ListGrid.aspx page
     var listId = parent.getListId();
     if (listId != '' && listId != 'undefined')
         ParentListItemObj.ListId = listId;
     parent.parent.CallServerSideMethod(_ListControlName,"ExecuteAction","ExecuteAction",ProcessAjaxResponse,'ListItemDetails',ParentListItemObj);          
}

// called after recieving the response from the server(for ribbon bar actions).
function ProcessAjaxResponse(context, result, response)
{
    if (result != null && response.Error == false) {
        if (result[0] == "intelanotprovisioned") {
            alert(result[1]);
        }
        else {
            eval("UrlJs=" + result);
            for (var key in UrlJs) {
                //Assigning values to the ListItem object -- Added later
                var ItemObj = new ListItem();
                ItemObj.ParentItemId = ParentItemId;
                ItemObj.ListItemId = "00000000-0000-0000-0000-000000000000";
                ItemObj.ListId = "00000000-0000-0000-0000-000000000000";
                ItemObj.ActionToRun = UrlJs[key]["Value"];
                ItemObj.IsVersionGrid = "N";

                ExecuteAction(UrlJs[key]["Name"], UrlJs[key]["Value"], UrlJs[key]["Type"], UrlJs[key]["Properties"], UrlJs[key]["Uri"], ItemObj);
            }
        }
    }
} 


function BellybarMessageAlert(displayMsg) {
    se.ui.messageDialog.showAlert(bellstMsg, displayMsg);
}


function BellybarMessageError(displayMsg)
{
    se.ui.messageDialog.showError(bellstMsg, displayMsg);
}

function MultiSelectOperation(controlId, tblName, colName, checkboxValue, originalCheckBoxValue) {
   
    var grd = ISGetObject(controlId);
    var checkedRows = grd.RootTable.GetCheckedRows();
    if (checkedRows.length > 0) {

        if (isReadonly == "False") {

            if (typeof (parent.LoadRightActionBarForMultiSelect) != 'undefined') {
                parent.LoadRightActionBarForMultiSelect();
            }
            if (typeof (parent.parent.LoadRightActionBarForMultiSelect) != 'undefined')
                parent.parent.LoadRightActionBarForMultiSelect();
        }
    }
    else {

        if (isReadonly == "False") {
            if (typeof (parent.LoadRightActionBar) != 'undefined') {
                parent.LoadRightActionBar();
            }
            if (typeof (parent.parent.LoadRightActionBar) != 'undefined') {
                parent.parent.LoadRightActionBar();
            }
        }
    }

    return true;
}

var frameItemTitle='';
// called from the Ribbon bar actions.
function ExecuteActionForSelectedRow(actionName) {
//Assigning action value to the ListItem object
//This is to retain the cell value and open only one window at a time while editing
if(actionName == "_sys_edit")
    frameItemTitle=SelCellText;

if(SelCellText=="")
{
    if(wgGetGridById("WebGrid1").GetSelectedObject()!=null)
    {
        var row = wgGetGridById("WebGrid1").GetSelectedObject().GetRowElement();
        var cell = wgGetCellByName(row, "ItemType");
        if (cell == undefined) {
            if (noRowSelected == null || noRowSelected == undefined)
                noRowSelected = 'Select an item row to perform this action.';
            se.ui.messageDialog.showAlert(bellstMsg, noRowSelected);
           // alert(noRowSelected);
            return;
        }
        // For getting the default column info form the attribute add to the 'ItemType' column.
        var defaultfield = cell.getAttribute("defaultfield");
        
        if(defaultfield==null) return;
    
        var itemdetailcell = wgGetCellByName(row,defaultfield);
        if(itemdetailcell==null) reutrn;
    
        var Querystringvalues = itemdetailcell.getAttribute("itemDetails");
        
         //var cell = wgGetCellByName(row, "Title");                        
         if(itemdetailcell==null)
            return;
        SelCellText = itemdetailcell.innerText;

        if (actionName == "_sys_edit")
            frameItemTitle = SelCellText;
     }
 }
   if(SelCellText !== ""){
     ListItemObj.ActionToRun = actionName; 
       
     if(ListItemObj.ItemType == "0" && actionName == "_sys_create_assn"){
       // alert("Association can be done only for the workflows.");
         // alert(associationforWFonly);
         se.ui.messageDialog.showAlert(bellstMsg, associationforWFonly);
        return false;
     }
     if(ListItemObj.ItemType == "0" && actionName == "_sys_designworkflow"){
         // alert("You cannot design a folder.");
        // alert(designonlyforWF);
         se.ui.messageDialog.showAlert(bellstMsg, designonlyforWF);
        return false;
     }
      if(ListItemObj.ItemType == "0" && actionName == "_sys_view_designer"){
          //alert("You cannot view a folder.");
         // alert(viewdesignOnlyForWF);
          se.ui.messageDialog.showAlert(bellstMsg, viewdesignOnlyForWF);
        return false;
        }
        if (ListItemObj.ItemType == "0" && actionName == "_sys_edit" &&ListName!="navigationdetails") {
            //alert(NotAbleToEditFolder);
            //alert("You cannot edit a folder.");
            se.ui.messageDialog.showAlert(bellstMsg, NotAbleToEditFolder);
        return false;  
        }
      if(ListItemObj.ItemType == "0" && actionName == "_sys_view_propertiessoa"){
          //alert("You cannot view a folder.");
         // alert(viewdesignOnlyForSOA);
          se.ui.messageDialog.showAlert(bellstMsg, viewdesignOnlyForSOA);
        return false;
    }
       if (ListItemObj.ItemType == "0" && actionName == "_sys_view_item_details") {
         //alert("You cannot view a folder.");
        //  alert(viewdesignOnlyForDL);
           se.ui.messageDialog.showAlert(bellstMsg, viewdesignOnlyForDL);
        return false;
    }
    if (ListItemObj.ItemType == "0" && actionName == "_sys_designform") {
        // alert("You cannot design a folder.");
       // alert(designonlyforForm);
        se.ui.messageDialog.showAlert(bellstMsg, designonlyforForm);
        return false;
    }
    if (ListItemObj.ItemType == "0" && actionName == "_sys_designlist") {
        // alert("You cannot design a folder.");
       // alert(designonlyforList);
        se.ui.messageDialog.showAlert(bellstMsg, designonlyforList);
        return false;
    }
    if (ListItemObj.ItemType == "0" && actionName == "_sys_preview") {
        // alert("You cannot view a folder.");
        //alert(viewdesignOnlyForFL);
        se.ui.messageDialog.showAlert(bellstMsg, viewdesignOnlyForFL);
        return false;
    }

    if (ListItemObj.ItemType == "0" && actionName == "_sys_view_package_template") {
        //alert("You cannot view a folder.");
       // alert(NotAbleToViewFolder);
        se.ui.messageDialog.showAlert(bellstMsg, NotAbleToViewFolder);
        return false;
    }

    // Folder Should not be edited 
    if (ListItemObj.ItemType == "0" && actionName == "_sys_edit_package_template") {
       // alert(NotAbleToEditFolder);
        //alert("You cannot edit a folder.");
        se.ui.messageDialog.showAlert(bellstMsg, NotAbleToEditFolder);
        return false;
    }
 
    if (ListItemObj.ItemType == "0" && actionName == "_sys_view_asb") {
        //alert("You cannot view a folder.");
       // alert(NotAbleToViewFolder);
        se.ui.messageDialog.showAlert(bellstMsg, NotAbleToViewFolder);
        return false;
       }

       if (ListItemObj.ItemType == "0" && actionName == "_sys_view_logicappconn") {           
           se.ui.messageDialog.showAlert(bellstMsg, NotAbleToViewFolder);
           return false;
       }
     
     parent.parent.CallServerSideMethod(_ListControlName,"ExecuteAction","ExecuteAction",ProcessAjaxResponse,'ListItemDetails',ListItemObj);
     
     SelCellText = "";          
   }
   else{
     //alert("Please select an item row to perform this action.");
       // alert(noRowSelected);
       se.ui.messageDialog.showError(bellstMsg, noRowSelected);
   }
}

// called from the Ribbon bar actions.
function ExecuteActionForMultiSelectedRow(actionName) {
    
    var grd = ISGetObject('WebGrid1');   
    var checkedRows = grd.RootTable.GetCheckedRows();

    if (checkedRows.length > 0)
    {   
        GetMultiSelectListItems(actionName);
    }
    else
    {
        se.ui.messageDialog.showError(bellstMsg, noRowSelected);
    }
    
   
}


// global namespace
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

var ListItemArr; 
function GetMultiSelectListItems(actionName) {
    ListItemArr = new Array();
    
    var grd = ISGetObject('WebGrid1');
    var checkedRows = grd.RootTable.GetCheckedRows();

    if (checkedRows.length > 0) {
        
        for (var i = 0; i < checkedRows.length; i++)
        {
            var cell = wgGetCellByName(checkedRows[i], "ItemType");
            if (cell == null)
                return;

            //Getting default column details
            var defaultfield = cell.getAttribute("defaultfield");
            if (defaultfield == null)
                return;
            var itemdetailcell = wgGetCellByName(checkedRows[i], defaultfield);
            SelCellText = itemdetailcell.innerText;

            var Querystringvalues = itemdetailcell.getAttribute("itemDetails");
            if (Querystringvalues == null) return;
            var QuerystringvaluesArr = Querystringvalues.split(',');

            var versionCell = wgGetCellByName(checkedRows[i], "Version");
            var listItemTitle = wgGetCellByName(checkedRows[i], "Title").innerText;
            ListItemObj = new ListItem();
            ListItemObj.ListItemId = QuerystringvaluesArr[0];
            ListItemObj.ListId = QuerystringvaluesArr[1];
            if (versionCell != null)
                ListItemObj.VersionStamp = versionCell.innerText;
            ListItemObj.ListItemStatus = QuerystringvaluesArr[2];
            ListItemObj.ParentItemId = ParentItemId;
            ListItemObj.ItemType = QuerystringvaluesArr[3];
            ListItemObj.IsVersionGrid = "N";
            ListItemObj.ActionToRun = actionName;
            ListItemObj.ListItemName = listItemTitle;
            ListName = QuerystringvaluesArr[4];
            ListItemObj.VersionStamp = QuerystringvaluesArr[6]; 
            ListItemArr.push(ListItemObj);
        }
        MultiSelectLoaderScript.Loader.ShowLoader();
        if (actionName == "_sys_publishall" || actionName == "_sys_unpublishall")
        {
            parent.parent.CallServerSideMethod(_ListControlName, "MultiSelectAllItems", "MultiSelectAllItems", SetMultiSelectSecurityCheckResponse, 'ListItemDetailsArr', ListItemArr);
        }        
        else
        {
            if (ListName == "forms list") {

                parent.parent.CallServerSideMethod(_ListControlName, "MultiSelectItemsPublishUnpublish", "MultiSelectItemsPublishUnpublish", SetMultiSelectSecurityCheckResponse, 'ListItemDetailsArr', ListItemArr);
            }
            else if (ListName == "workflow")
            {
                parent.parent.CallServerSideMethod(_ListControlName, "MultiSelectCheckForPausedOrRunningInstances", "MultiSelectCheckForPausedOrRunningInstances", SetMultiSelectResponseForPublishUnpublish, 'ListItemDetailsArr', ListItemArr);
            }
        }
    }    

}

function SetMultiSelectResponseForPublishUnpublish(context, result, response)
{
    var msgBellyTitle;
    var msgBellyMessage;
    MultiSelectLoaderScript.Loader.HideLoader();
    eval("var opResult =" + result);

    for (var key in opResult)
    {
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
        if (instancesExist == true)
        {
            se.ui.messageDialog.showConfirmation(msgBellyTitle, msgBellyMessage,
                function (userResponse) {
                    if (userResponse)
                    {
                        MultiSelectLoaderScript.Loader.ShowLoader();
                        parent.parent.CallServerSideMethod(_ListControlName, "MultiSelectItemsWithPauseOrResume", "MultiSelectItemsWithPauseOrResume", SetMultiSelectSecurityCheckResponse, 'ListItemDetailsArr', ListItemArr);
                    }
                });
        }
        else
        {
            MultiSelectLoaderScript.Loader.ShowLoader();
            parent.parent.CallServerSideMethod(_ListControlName, "MultiSelectItemsPublishUnpublish", "MultiSelectItemsPublishUnpublish", SetMultiSelectSecurityCheckResponse, 'ListItemDetailsArr', ListItemArr);
        }
    }
    

}

function SetMultiSelectSecurityCheckResponse(context, result, response)
{    
    MultiSelectLoaderScript.Loader.HideLoader();
    eval("var opResult =" + result);

    for (var key in opResult) {
        var successItems = opResult[key]["SuccessItems"];
        var failedItems = opResult[key]["FailedItems"];
        var actionSelected = opResult[key]["ActionSelected"];

        if (actionSelected == "_sys_publish" || actionSelected == "_sys_publishall")
        {
            var pubMsgToShow;

            if (failedItems == "" && successItems != "") {
                pubMsgToShow = (ListName == "workflow" ? belMulPublishStatusMessage : belMulPublishFormsStatusMessage) + ".";
            }

            if (successItems == "" && failedItems != "") {
                pubMsgToShow = (ListName == "workflow" ? belMulPublishFailedStatusMessage : belMulPublishFormsFailedStatusMessage) + ": " + failedItems;
            }
            if (successItems != "" && failedItems != "") {
                se.ui.messageDialog.showAlert(belMulPublishStatusHead, (ListName == "workflow" ? belMulPublishFailedStatusMessage : belMulPublishFormsFailedStatusMessage)  + ": " + failedItems);
            }
            else {
                se.ui.messageDialog.showAlert(belMulPublishStatusHead, pubMsgToShow);
            }
        }
        else
        {
            var unPubMsgToShow;

            if (failedItems == "" && successItems != "") {
                unPubMsgToShow = (ListName == "workflow" ? belMulUnPublishStatusMessage : belMulUnPublishFormsStatusMessage) + ".";
            }

            if (successItems == "" && failedItems != "") {
                unPubMsgToShow = (ListName == "workflow" ? belMulUnPublishFailedStatusMessage : belMulUnPublishFormsFailedStatusMessage) + ": " + failedItems;                
            }
            if (successItems != "" && failedItems != "") {
                se.ui.messageDialog.showAlert(belMulUnPublishStatusHead, (ListName == "workflow" ? belMulUnPublishFailedStatusMessage : belMulUnPublishFormsFailedStatusMessage) + ": " + failedItems);
            }
            else {
                se.ui.messageDialog.showAlert(belMulUnPublishStatusHead, unPubMsgToShow);
            }
        }
        
        var grid = ISGetObject("WebGrid1");
        grid.RefreshAll();        
       
    }

}


function GetWebGrid() {
    var grid = ISGetObject("WebGrid1");
    return grid;
}

function RefreshGrid(){
    var grid = ISGetObject("WebGrid1");
    showbcrumb = 1;
    //grid.ClearSelectedObject();
    
     grid.Refresh();
     //grid.RefreshAll();
     return true;
 }
 function Refresh() {
     var grid = ISGetObject("WebGrid1"); 
     grid.SetHeight("98%");
     if (window.parent.parent.location.href.indexOf('FromArchestrA') != -1) {
         grid.SetHeight("99%");
     }
 }


var IE = document.all?true:false

// If NS then set up for mouse capture
if (!IE) document.captureEvents(Event.MOUSEMOVE)

// Set-up to use getMouseXY function onMouseMove
document.onmousemove = getMouseXY;

// Main function to retrieve mouse x-y pos.s

function getMouseXY(e) {
      if (IE) { // grab the x-y pos.s if browser is IE
        tempX = event.clientX + document.body.scrollLeft
        tempY = event.clientY + document.body.scrollTop
      } else {  // grab the x-y pos.s if browser is NS
        tempX = e.pageX
        tempY = e.pageY
      }  
      // catch possible negative values in NS4
      if (tempX < 0){tempX = 0}
      if (tempY < 0){tempY = 0}  
      
 //     alert(tempX + " " +tempY);
  
  return true
}

function CloseCallOOut(){
    try{
         parent.document.getElementById("divCallOut").style.display = "none";
    }
    catch(ex){
    }
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
    var w=0;
      
    if (window.document.innerWidth>w)   	
        w=window.document.innerWidth;  
    if (window.document.documentElement.clientWidth>w)   		

    w=window.document.documentElement.clientWidth;  
    if (window.document.body.clientWidth>w)   	
        w=window.document.body.clientWidth;  

//alert(w); 
return w;
}

function ViewWFDetails(listId, listItemId, version, uri) {
    var w, h;
    var isChromeBrowser = window.navigator.userAgent.toLowerCase().indexOf('chrome') > -1;

    var isIEElevenBrowser = false;
    //check if broser is IE11 
    if (isIE11()) {
        isIEElevenBrowser = true;
    }


    if (document.all || document.layers || isChromeBrowser || isIEElevenBrowser) {
        w = screen.availWidth;
        h = screen.availHeight;
    }

    winHeight = (h * 45 / 100);
    winWidth = (w * 60 / 100);

    var oManager = parent.parent.GetRadWindowManagerForListControl();
    var oWnd = oManager.getWindowByName("ECWindow");
    oWnd.set_title("Approval Workflow Details");
    oWnd.setSize(winWidth, winHeight);    
    oWnd.setUrl(uri);
    oWnd.show();

}
String.prototype.endsWith = function(str) {return (this.match(str+"$")==str)}

function ViewDownloadFile(uri) 
  {

    se.ui.messageDialog.showConfirmation(belDownloadHead, belDownloadMessage,
                            function (userResponse) {
                                if (userResponse) {
                                    var w, h;
                                    if (document.all || document.layers) {
                                        w = screen.availWidth;
                                        h = screen.availHeight;
                                    }

                                    var randomnumber = Math.floor(Math.random() * 100000);
                                    var date = new Date();
                                    var ticks = date.getTime()

                                    var builtUrl = '';
                                    if (uri.endsWith('.aspx') && uri.indexOf('?') == -1) {
                                        builtUrl = uri + "?radrandomcache=" + randomnumber + ticks;
                                    }
                                    else {
                                        builtUrl = uri + "&radrandomcache=" + randomnumber + ticks;
                                    }
                                    winHeight = (h * 15 / 100);
                                    winWidth = (w * 25 / 100);
                                    var oManager = parent.parent.GetRadWindowManagerForListControl();
                                    var oWnd = oManager.getWindowByName("ECWindow");
                                    oWnd.setUrl(builtUrl);
                                    oWnd.setSize(winWidth, winHeight);
                                    oWnd.set_title("View or Download file");
                                    return;

                                }
                            });

   
    
}

function SetSecurityCheckResponseForBellyBar(name, value, type, properties, uri) {  
    if (SecurityCheck == "OVW") {
        //alert('You do not have rights to design a published workflow.');
        if (value == "_sys_designworkflow") {
            if (cannotOWVD == null || cannotOWVD == undefined)
                cannotOWVD = 'You do not have rights to design a published workflow.';
            // alert(cannotOWVD);
            se.ui.messageDialog.showAlert(belSecurityHead, cannotOWVD);
        }
        else if (value == "_sys_edit") {
            if (cannotOWV == null || cannotOWV == undefined)
                cannotOWV = 'You do not have rights to edit a published workflow.';
            // alert(cannotOWV);
            se.ui.messageDialog.showAlert(belSecurityHead, cannotOWV);
        }
        else if (value == "_sys_publish") {
            if (cannotOWVP == null || cannotOWVP == undefined)
                cannotOWVP = 'You do not have rights to republish a workflow.';
            // alert(cannotOWVP);
            se.ui.messageDialog.showAlert(belSecurityHead, cannotOWVP);
        }
        return;
    }
    if (SecurityCheck == "OWPUBFRM") {
        // alert('You do not have rights to edit a published form.');
        if (value == "_sys_designform") {
            if (cannotOWFD == null || cannotOWFD == undefined)
                cannotOWFD = 'You do not have rights to design a published form.';
            // alert(cannotOWFD);
            se.ui.messageDialog.showAlert(belSecurityHead, cannotOWFD);
        }
        else if (value == "_sys_edit") {
            if (cannotOWF == null || cannotOWF == undefined)
                cannotOWF = 'You do not have rights to edit a published form.';
            //alert(cannotOWF);
            se.ui.messageDialog.showAlert(belSecurityHead, cannotOWF);
        }
        else if (value == "_sys_publish") {
            if (cannotOWFP == null || cannotOWFP == undefined)
                cannotOWFP = 'You do not have rights to republish a form.';
            // alert(cannotOWFP);
            se.ui.messageDialog.showAlert(belSecurityHead, cannotOWFP);
        }
        return;
    }
    if (SecurityCheck == "DIS") {
        // alert('You can not perform this action on disabled item');
        if (cannotPerDisable == null || cannotPerDisable == undefined)
            cannotPerDisable = 'You can not perform this action on disabled item';
        //alert(cannotPerDisable);
        se.ui.messageDialog.showAlert(bellstMsg, cannotPerDisable);
        return;
    }
    if (SecurityCheck == "OWNEDONLY") {
        if (value == "_sys_edit") {
            if (canEOIO == null || canEOIO == undefined)
                canEOIO = 'You can edit your owned items only.';
            // alert(canEOIO);
            se.ui.messageDialog.showAlert(bellstMsg, canEOIO);
            return;
        }
        else {
            if (canVOIO == null || canVOIO == undefined)
                canVOIO = 'You can view your owned items only.';
            // alert(canVOIO);
            se.ui.messageDialog.showAlert(bellstMsg, canVOIO);
            return;
        }
    }
    
    if (SecurityCheck !== "DNL") {
        if (value == "_sys_showChildItems") {
            var grid = ISGetObject("WebGrid1");

            var litemid = ListItemObj.ListItemId;
            grid.AddInput("ParentItemId", litemid);
            grid.AddInput("breadcrumblistclick", "no");
            ParentItemId = litemid;
            
            try {               

                if (SelCellText !== '') {
                    //if (parent.parent.breadCrumbObject[_ListControlId + 'Arr'] == 'undefined' || parent.parent.breadCrumbObject[_ListControlId + 'Arr'] == null)
                    //    parent.parent.breadCrumbObject[_ListControlId + 'Arr'] = new Array(25);
                    //if (parent.parent.breadCrumbObject[_ListControlId + 'Crumb'] == 'undefined' || parent.parent.breadCrumbObject[_ListControlId + 'Crumb'] == null)
                    //    parent.parent.breadCrumbObject[_ListControlId + 'Crumb'] = '';

                    var bCrumbTemp = parent.parent.breadCrumbObject[_ListControlId + 'Crumb']; //breadCrumbClientId
                    if (bCrumbTemp == 'undefined' || bCrumbTemp == null)
                        bCrumbTemp = '';

                    breadCrumb = bCrumbTemp + "&nbsp;&nbsp;<img src='" + tempDir + "images/arrow.gif'>&nbsp;&nbsp;<span class='bclinkinact'>" + SelCellText + "  </span>";
                    parent.parent.breadCrumbObject[_ListControlId + 'Crumb'] = bCrumbTemp + "&nbsp;&nbsp;<img src='" + tempDir + "images/arrow.gif'>&nbsp;&nbsp;<a href=\"javascript:NavigateGrid" + _ListControlId + "('" + litemid + "','" + parent.parent.breadCrumbObject[_ListControlId + 'Cnt'] + "')\" class='bclink'>" + SelCellText + "</a>  ";
                    parent.parent.breadCrumbObject[_ListControlId + 'Arr'][parent.parent.breadCrumbObject[_ListControlId + 'Cnt']] = litemid + "||" + SelCellText;
                    parent.parent.breadCrumbObject[_ListControlId + 'Cnt']++;

                    var bCrumb = parent.parent.document.getElementById(breadCrumbClientId); //parent.parent.breadCrumbClientId
                    //            breadCrumb = parent.parent.document.getElementById(parent.parent.breadCrumbObject[_ListControlId + 'Crumb']);
                    //            //breadCrumb += "&nbsp;&nbsp;<img src='" + tempDir + "images/arrow.gif'>&nbsp;&nbsp;<span class='bclinkinact'>" + SelCellText + "  </span>";
                    if (bCrumb != null)
                        bCrumb.innerHTML = breadCrumb;
                }

            }
            catch (e) {
            }
            grid.ClearSelectedObject();
            grid.RefreshAll();
            SelCellText = "";
            return;

        }
        else if (type == "ASPXUIAction") {

            /*if(value == "_sys_view_properties"){
                
                 ShowDetailsPane();
                 return;
             }*/

            if (value == '_sys_delete') {                
                var yes = false;
                if (ListName != "workflow" || ListItemObj.ItemType == "0") {
                    if (sysDel != undefined) {
                        //yes = confirm(sysDel);
                        se.ui.messageDialog.showConfirmation(bellstMsg, sysDel,
                        function (userResponse) {
                            if (userResponse) {

                                //OpenFile(uri, properties);
                                executeOpenFile(value, name, parent, uri, properties);
                            }
                        });
                    }
                    else {
                        //first time when user clicks on context menu then sysDel was not set
                        // yes = confirm('Are you sure you want to delete?');
                        se.ui.messageDialog.showConfirmation(bellstMsg, belMesgfrDspy,
                        function (userResponse) {
                            if (userResponse) {
                                executeOpenFile(value, name, parent, uri, properties);
                            }
                        });
                    }
                }
                else {
                    if (sysDel_WF != undefined) {
                        // yes = confirm(sysDel_WF);
                        se.ui.messageDialog.showConfirmation(bellstMsg, sysDel_WF,
                            function (userResponse) {
                           if (userResponse) {
                               executeOpenFile(value, name, parent, uri, properties);
                           }
                       });
                    }
                    else {
                        // yes = confirm('This will delete all the Workitems, Tasks, History, BAM, Associations and design time configurations related to this workflow.\n\nAre you sure you want to delete?');
                        se.ui.messageDialog.showConfirmation(bellstMsg, belMesgfrDspyindetail,
                        function (userResponse) {
                            if (userResponse) {
                                executeOpenFile(value, name, parent, uri, properties);
                            }
                        });
                    }
                }

                //reverted back as the context menu issue was not fixed
                // var yes = confirm(sysDel);

                if (!yes) {
                    return;
                }
            }
            else if (value == '_sys_synch') {
                var yes = false;
                //if (ListName == "web api source") {
                se.ui.messageDialog.showConfirmation(bellstMsg, bellyConfirmMsgWebApiSourceSync,
                    function (userResponse) {
                            if (userResponse) {
                                executeOpenFile(value, name, parent, uri, properties);
                            }
                        });
                //}
            }
            else {
                executeOpenFile(value, name, parent, uri, properties);
            }


            //function executeOpenFile(value, name, parent,uri, properties) {
            //    if (value == "_sys_saveas_specific_version" && name !== "subitems") {
            //        return;
            //    }


            //    if (value == "_sys_security_settings" || value == "_sys_create_assn" || value == "_sys_showallversions") {
            //        if (typeof (parent.WorkflowjsonObj) != 'undefined') {

            //            parent.WorkflowjsonObj = "";
            //            parent.LoadActionBar();
            //        }
            //    }

            //    OpenFile(uri, properties);
            //}

        }
        else if (type == "SystemAction") {

            if (value == "_sys_saveas_specific_version") {
                ListItemObj.SpecificVersionToSave = name;
            }
            if (value == '_sys_delete') {
                var yes = false;
                if (sysDel !== undefined) {
                    // yes = confirm(sysDel);
                    se.ui.messageDialog.showConfirmation(bellstMsg, sysDel,
                                            function (userResponse) {
                                                if (userResponse) {

                                                    yes = true;
                                                    SendRequestToServer(value, ListItemObj);
                                                }
                                            });


                }
                //Reverted back as the context menu delete is not fixed
                // var yes = confirm(sysDel);
                if (!yes)
                    return;
            }

            if (value == '_sys_createpackage')
            {
                var yes = false;
                if (sysCreateTemplate !== undefined) {
                    se.ui.messageDialog.showConfirmation(bellstMsg, sysCreateTemplate,
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
            else {

                SendRequestToServer(value, ListItemObj);
            }
        }
    }
    DblClickCount = 0;
}


