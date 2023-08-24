
<script type="text/javascript" language="javascript">
        
function WindowClose()
{
document.getElementById('divCallOut').style.display = "none";
}        
function OnInitialize(gridId)
{
    var grid = ISGetObject("WebGrid1");
    var rootTbl = grid.RootTable;
    //var imageNameColumn = rootTbl.GetColumn("ImageName"); 
    //alert(imageNameColumn.Width);
    //imageNameColumn.Width = 0;
    //imageNameColumn.IsAutoWidth = false;
    //imageNameColumn.Visible = false;
}

function hideCallOutDiv()
{   alert("Leaing");
    document.getElementById('divCallOut').style.display = "none";
    return false;
}

function ShowCallOut(gridId, tblName, rowIdx, rowElm,e)
{
    // Code for finding Which Mouse Button has been clicked.
	var rightclick;
	if (!e) var e = window.event;
	if (e.which) rightclick = (e.which == 3);
	else if (e.button) rightclick = (e.button == 2);
	//alert('Rightclick: ' + rightclick); // true or false    
	
	if(!rightclick)
	{
	   document.getElementById('divCallOut').style.display = "block";
	}
    
    return false;
}
function GetRadWindow()
{
   var oWindow = null;
  if (window.radWindow) 
	oWindow = window.radWindow;
  else if (window.frameElement.radWindow) 
	oWindow = window.frameElement.radWindow;
  return oWindow;
} 
function closeWindow()
{
  var oWindow = GetRadWindow();
  oWindow.close();
}

function OnRowContextMenu(gridId, rowType, rowEl, rowMenu)
 {          
      var i;
      var grid = wgGetGridById(gridId);
             
        if (rowType != "Record") 
        return true; 
        if(rowType =="Record")
        {
           // hide the default context menu
            for (i=0;i<16;i++)
            { 
             rowMenu.items[i].visible = false;
            }            
        }   
        
        var row = wgGetGridById(gridId).GetSelectedObject().GetRowElement();              
        var cell = wgGetCellByName(row, "Name");
        
        // New Context Menu Starts Here

		// create a new submenu where the Views items will be added.
		var menuWorkflow = new Menu();
		
		// add menu items to the new menu.
        menuWorkflow.add(new MenuItem("&nbsp;"+"View",function() {WFView()},"images/icon-view.png" ));        
        menuWorkflow.add(new MenuItem("&nbsp;"+"Edit",function() {WFEdit()},"images/icon-analyst-view.png" ));
        menuWorkflow.add(new MenuItem("&nbsp;"+"Extend",function() {WFExtend()},"images/Version-History.png" ));        
        menuWorkflow.add(new MenuItem("&nbsp;"+"Expire",function() {WFExpire()},"images/Version-History.png" ));        
        menuWorkflow.add(new MenuItem("&nbsp;"+"Renew",function() {WFRenew()},"images/Version-History.png" ));        
        menuWorkflow.add(new MenuItem("&nbsp;"+"Copy",function() {WFCopy()},"images/icon-create-copy.png" ));        
        menuWorkflow.add(new MenuItem("&nbsp;"+"Archive",function() {WFArchive()},"images/Archive.png" ));        
		// add the new submenu as rowMenu's menu item.
		rowMenu.add( new MenuItem("Workflow", function() {}, "images/Workflow-Actions-icon.png", menuWorkflow));



		// create a new submenu where the Views items will be added.
		var menuLinkTo = new Menu();
		
		// add menu items to the new menu.
        menuLinkTo.add(new MenuItem("&nbsp;"+"Process",function() {WFView()},"images/link-process-exixting-icon.png" ));        
        menuLinkTo.add(new MenuItem("&nbsp;"+"Workflow",function() {WFEdit()},"images/link-process-workflow-icon.png" ));
		// add the new submenu as rowMenu's menu item.
		rowMenu.add( new MenuItem("Link To", function() {}, "images/link-as-icon.png", menuLinkTo));



		// create a new submenu where the Views items will be added.
		var menuAssociateWith = new Menu();
		
		// add menu items to the new menu.
        menuAssociateWith.add(new MenuItem("&nbsp;"+"SharePoint",function() {AssociateSharePoint()},"images/icon-view.png" ));        
        menuAssociateWith.add(new MenuItem("&nbsp;"+"Enterprise Console",function() {AssociateEnterpriseConsole()},"images/icon-analyst-view.png" ));
        menuAssociateWith.add(new MenuItem("&nbsp;"+"File System",function() {AssociateFileSystem()},"images/icon-view.png" ));        
        menuAssociateWith.add(new MenuItem("&nbsp;"+"Scheduler",function() {AssociateScheduler()},"images/icon-analyst-view.png" ));

		// add the new submenu as rowMenu's menu item.
		rowMenu.add( new MenuItem("Associate With", function() {}, "images/Views-icon.png", menuAssociateWith));


		// create a new submenu where the Views items will be added.
		var menuViews = new Menu();
		
		// add menu items to the new menu.
        menuViews.add(new MenuItem("&nbsp;"+"Design View",function() {DesignView()},"images/icon-view.png" ));        
        menuViews.add(new MenuItem("&nbsp;"+"Analyst View",function() {AnalystView()},"images/icon-analyst-view.png" ));
		// add the new submenu as rowMenu's menu item.
		rowMenu.add( new MenuItem("Views", function() {}, "images/Views-icon.png", menuViews));



		// create a new submenu where the Views items will be added.
		var menuSkeltaVersionControl = new Menu();
		
		// add menu items to the new menu.
        menuSkeltaVersionControl.add(new MenuItem("&nbsp;"+"Check In",function() {CheckIn()},"images/Check-In.png" ));        
        menuSkeltaVersionControl.add(new MenuItem("&nbsp;"+"Check Out",function() {CheckOut()},"images/Check-out.png" ));
        menuSkeltaVersionControl.add(new MenuItem("&nbsp;"+"History",function() {History()},"images/Version-History.png" ));
		// add the new submenu as rowMenu's menu item.
		rowMenu.add( new MenuItem("Skelta Version Control", function() {}, "images/Views-icon.png", menuSkeltaVersionControl));


		// create a new submenu where the Views items will be added.
		var menuAssignView = new Menu();
		
		// add menu items to the new menu.
        menuAssignView.add(new MenuItem("&nbsp;"+"Assign Workflows",function() {AssignWorkflow()},"images/assign-workflow.png" ));        
        menuAssignView.add(new MenuItem("&nbsp;"+"View Status",function() {ViewStatus()},"images/icon-analyst-view.png" ));
		// add the new submenu as rowMenu's menu item.
		rowMenu.add( new MenuItem("Assign/View", function() {}, "images/Views-icon.png", menuAssignView));



		// create a new submenu where the Publish as items will be added.
		var newPublishMenu = new Menu();
		
		// add menu items to the new menu.
		newPublishMenu.add(new MenuItem("Major", function() {PublishAsMajor()},  "images/Publish-major.png"));
		newPublishMenu.add(new MenuItem("Minor", function() {PublishAsMinor()},  "images/Publish-minor.png"));
			
		// add the new submenu as rowMenu's menu item.
		rowMenu.add( new MenuItem("Publish Version As", function() {}, "images/publish-as-icon.png", newPublishMenu));


		rowMenu.add(new MenuItem("&nbsp;"+"BAM Reports",function() {Reports()},"images/icon-reports.png" ));				 
		
		rowMenu.add(new MenuItem("&nbsp;"+"List Item Settings",function() {ListItemSettings()},"images/icon-reports.png" ));				 		

//

	    rowMenu.add(new MenuItem("&nbsp;"+"Properties",function() {Properties()},"images/properties-icon.gif" ));				        
        
        // New Context Menu Ends here
        
        

        //Old Context Menu Starts Here        
/*        
        
        // Group Creation.
		// create a new submenu where the Workflow Action items will be added.
		var menuWorkflowActions = new Menu();
		
		// add menu items to the new menu.
		menuWorkflowActions.add(new MenuItem("&nbsp;"+"Modify",function() {Modify()},"images/icon-modify.png" ));
        menuWorkflowActions.add(new MenuItem("&nbsp;"+"Create Copy",function() {CreateCopy()},"images/icon-create-copy.png" ));
        menuWorkflowActions.add(new MenuItem("&nbsp;"+"Archive",function() {Archive()},"images/Archive.png" ));
        menuWorkflowActions.add(new MenuItem("&nbsp;"+"Delete",function() {Delete()},"images/icon-delete.png" ));			
		// add the new submenu as rowMenu's menu item.
		rowMenu.add( new MenuItem("Workflow Actions", function() {}, "images/Workflow-Actions-icon.png", menuWorkflowActions));        
		
		// create a new submenu where the Views items will be added.
		var menuViews = new Menu();
		
		// add menu items to the new menu.
        menuViews.add(new MenuItem("&nbsp;"+"View",function() {View()},"images/icon-view.png" ));        
        menuViews.add(new MenuItem("&nbsp;"+"Analyst View",function() {AnalystView()},"images/icon-analyst-view.png" ));
        menuViews.add(new MenuItem("&nbsp;"+"Version History",function() {VersionHistory()},"images/Version-History.png" ));        
		// add the new submenu as rowMenu's menu item.
		rowMenu.add( new MenuItem("Views", function() {}, "images/Views-icon.png", menuViews));        						
		
		// create a new submenu where the Link To items will be added.
		var menuLinkTo = new Menu();
		
//		// add menu items to the new menu.
//		menuLinkTo.add(new MenuItem("&nbsp;"+"Process",function() {ExistingProcess()},"images/link-process-exixting-icon.png" ));
//        menuLinkTo.add(new MenuItem("&nbsp;"+"Workflow",function() {ExistingWorkflow()},"images/link-process-workflow-icon.png" ));
//		// add the new submenu as rowMenu's menu item.
//		rowMenu.add( new MenuItem("Link To", function() {}, "images/icon-view.png", menuLinkTo));        				
		
        rowMenu.add(new MenuItem("&nbsp;"+"Associate",function() {Associate()},"images/icon-associate.png" ));
        rowMenu.add(new MenuItem("&nbsp;"+"Assign Workflow",function() {AssignWorkflow()},"images/assign-workflow.png" ));        
        rowMenu.add(new MenuItem("&nbsp;"+"Check In/Out",function() {CheckInOut()},"images/checkIn-out-icon.png" ));        		

		
		
		// create a new submenu where the Link To items will be added.
		var menuTasks = new Menu();
		
		// add menu items to the new menu.
		menuTasks.add(new MenuItem("&nbsp;"+"Delegate skelta workflow creation to user",function() {ExistingProcess()},"images/delegate-user-icon.png" ));
        menuTasks.add(new MenuItem("&nbsp;"+"Create skelta workflow now",function() {ExistingWorkflow()},"images/workflow.png" ));
		menuTasks.add(new MenuItem("&nbsp;"+"Link to existing Process",function() {ExistingProcess()},"images/link-process-exixting-icon.png" ));
        menuTasks.add(new MenuItem("&nbsp;"+"Link to existing Workflow",function() {ExistingWorkflow()},"images/link-process-workflow-icon.png" ));        
        //menuTasks.add( new MenuItem("Link To", function() {}, "images/icon-view.png", menuLinkTo));        		
		// add the new submenu as rowMenu's menu item.
		rowMenu.add( new MenuItem("Tasks", function() {}, "images/task.png", menuTasks));        				
		
		// create a new submenu where the Publish as items will be added.
		var newPublishMenu = new Menu();
		
		// add menu items to the new menu.
		newPublishMenu.add(new MenuItem("Major", function() {PublishAsMajor()},  "images/Publish-major.png"));
		newPublishMenu.add(new MenuItem("Minor", function() {PublishAsMinor()},  "images/Publish-minor.png"));
			
		// add the new submenu as rowMenu's menu item.
		rowMenu.add( new MenuItem("Publish As", function() {}, "images/publish-as-icon.png", newPublishMenu));
				
        rowMenu.add(new MenuItem("&nbsp;"+"Manage Permissions",function() {ManagePermissions()},"images/manage-permissions.png" ));        
        rowMenu.add(new MenuItem("&nbsp;"+"Reports",function() {Reports()},"images/icon-reports.png" ));				
        rowMenu.add(new MenuItem("&nbsp;"+"Associated Workflows",function() {AssociatedWorkflows()},"images/asso-workflow-icon.png" ));				
        rowMenu.add(new MenuItem("&nbsp;"+"Properties",function() {Properties()},"images/properties-icon.gif" ));				
*/        
        // Old Context Menu Ends here
        return true;
 }
 
 //ExistingWorkflow
 
 // functions related to Old Context Menu Starts Here
 /*
  function Properties()
 {
 window.document.getElementById('WorkflowProperties').click();
 }
 
  function AssociatedWorkflows()
 {
 alert("Associated Workflows");
 }
 
 function ExistingWorkflow()
 {
 alert("ExistingWorkflow");
 }

 function ExistingProcess()
 {
 alert("ExistingProcess");
 } 
 
 function AssignWorkflow()
 {
 window.open("Workflow_AssignWF.aspx","_self");
 }

 function PublishAsMajor()
 {
    //alert("clicked on PublishAsMajor:");
        var button = window.document.getElementById('publish1').click();

    //window.open("List_Version_History.aspx","_self");
 }
 function PublishAsMinor()
 {
   // alert("clicked on PublishAsMajor:");
        var button = window.document.getElementById('publish1').click();

    //window.open("List_Version_History.aspx","_self");
 } 
  
 function VersionHistory()
 {
    //alert("clicked on save VersionHistory:");
    window.open("List_Version_History.aspx","_self");
 }
  
 function ManagePermissions()
 {
    alert("clicked on ManagePermissions:");
 }
  
 function CheckInOut()
 {
    alert("The Workflow has been Checked Out.");
 }
  
 function View()
 {
    //alert("clicked on save View:");
    //window.open("Workflow_View.aspx","_blank");
    var button = window.document.getElementById('WorkflowView').click();
    //alert("view click "+button);
    
 }
 
 function AnalystView()
 {
 //alert("clicked on save Analyst View:");
 //window.open("Workflow_Analyst_View.aspx","_blank");
 var button = window.document.getElementById('WorkflowAnalystView').click();
 }
 
 function Modify()
 {
    //alert("clicked on save Modify:");
    window.open("Workflow_Modify.aspx","_self");
 }
 
 function Archive()
 {
    alert("The Workflow has been Archived.")
 } 
 
 function Associate()
 {
 //alert("clicked on save Associate:");
 window.open("Workflow-Associate.aspx","_self");
 }
  
  function Delete()
 {
    //confirm("Yes or No");
    callMsgBox1("Do you want to Delete?");
 }
 
 function CreateCopy()
 {
 //alert("clicked on save Create Copy:"); 
 window.open("Workflow_CreateCopy.aspx","_self");
 }

 function Reports()
 {
 //window.open("Workflow_Reports.aspx","_self");
 document.getElementById('Reports').click();
 }
 
 */ // functions related to Old Context Menu

// functions for New Context Menu Starts Here

function WFView()
{
}

function WFEdit()
{
}

function WFExtend()
{
}

function WFExpire()
{
}

function WFRenew()
{
}

function WFCopy()
{
}

function WFArchive()
{
}

function LinkToWorkflow()
{
}

function LinkToProcess()
{
}

function AssociateSharePoint()
{
window.open("Workflow-Associate.aspx","_self");
}

function AssociateEnterpriseConsole()
{
window.open("Workflow-Associate.aspx","_self");
}

function AssociateFileSystem()
{
window.open("Workflow-Associate.aspx","_self");
}
 
function AssociateScheduler()
{
window.open("Workflow-Associate.aspx","_self");
}

function DesignView()
{
var button = window.document.getElementById('WorkflowView').click();
}

function AnalystView()
{
var button = window.document.getElementById('WorkflowAnalystView').click();
}

function CheckIn()
{
alert("The Workflow has been Checked In.");
}

function CheckOut()
{
alert("The Workflow has been Checked Out.");
}

function History()
{
window.open("List_Version_History.aspx","_self");
}

 function AssignWorkflow()
 {
 window.open("Workflow_AssignWF.aspx","_self");
 }
 
 function ViewStatus()
 {
 document.getElementById('Workflow_ViewStatus').click();
 }

function PublishAsMajor()
{
var button = window.document.getElementById('publish1').click();
}

function PublishAsMinor()
{
var button = window.document.getElementById('publish1').click();
}

function Reports()
{
document.getElementById('Reports').click();
}

function Properties()
{
//window.document.getElementById('WorkflowProperties').click();
document.getElementById('divCallOut').style.display = "block";
}

function ListItemSettings()
{
//window.document.getElementById('WorkflowProperties').click();
window.open("ListItemSettings.aspx","_self")
}

// Ends Here

    function DoCellClick(gridId, tblName, rowIdx, cellIdx, cellElm)
    {
	    //alert("OnCellClick : WebGridId = " + gridId + " TableName =  " + tblName + " RowIndex =  " + rowIdx + " CellIndex =  " + cellIdx + " CellElement =  " + cellElm);
	    var grid = ISGetObject(gridId);
	    //alert(grid.RootTable);
        if (grid.RootTable.GetRow(rowIdx) == null)
        {
            alert("Please select a row."); 
            return;
        }
        var row = grid.RootTable.GetRow(rowIdx);
        //alert(row);
        //alert(row.Type);
        if (row.Type == "Record")
        {
            var cells = row.GetCells();
            //alert("Cells : "+cells);
            var i=0;
            var CategoryNameCellIndex=-1;        
            var WFNameCellIndex=-1;        

            for (i=0;i<cells.length;i++)
            {
                //alert("cells["+i+"] is :" +cells[i].Text);
                var columnobj = cells[i].Column;
                //alert("Column Name for cells["+i+"] is :" +columnobj.Name);
                if(columnobj.Name == "Work Folder")
                {
                    //alert("Inside Column Name")
                    CategoryNameCellIndex = i;
                    break;
                }
                
                if(columnobj.Name == "WorkflowName")
                {
                    //alert("Inside Column Name")
                    WFNameCellIndex = i;
                    break;
                }                
            }
            //alert("CategoryNameCellIndex "+CategoryNameCellIndex);
            if(CategoryNameCellIndex!=-1)
            {
                if(cells[CategoryNameCellIndex].Value!="")
                {
                grid.AddInput("keyValue", cells[CategoryNameCellIndex].Value);
                }
                else if(cells[WFNameCellIndex].Value!="")
                {
                grid.AddInput("keyValue", cells[WFNameCellIndex].Value);
                }
                else
                {
                    alert("This is a Direct Workflow. Please select a row with Category Name");
                    return false;
                }
            }
            else
            {
                return false;
            }
        }              
        grid.RefreshAll();
        return true;							
    }
        </script>
        
<script type="text/vbscript" language="vbscript">
function callMsgBox2(strMsg)
'second parameter is msgBox type
callMsgBox2 = msgBox(strMsg,3)
end function
</script>

<script type="text/javascript" language="javascript">
<!--
function callMsgBox1(strMsg)
{
var retVal = callMsgBox2(strMsg)
}
// call this javascript function instead of alert/confirm

//callMsgBox1('This is message box.!')
//-->
</script>        
