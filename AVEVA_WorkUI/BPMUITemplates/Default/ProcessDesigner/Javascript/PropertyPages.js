// JScript File



function wf_openpropertypage(propertypagename,propertyname,selectedactionname,windowopentags)
{ 
	var newwin ;
	var u=window.parent.parent.location.href;
	u = u+((u.indexOf('?') > 0)?'&':'?');
    var dii = window.parent.parent.GetStateData("designerinstanceid");
    var windowHeight, windowWidth;
    
    mainData = windowopentags.split(',');
    mainData1 = mainData[0].split('=');
    if (mainData1[0] == "height") {
        windowHeight = mainData1[1];
    }

    if (mainData1[0] == "width") {
        windowWidth = mainData1[1];
    }

    mainData2 = mainData[1].split('=');

    if (mainData2[0] == "width") {
        windowWidth = mainData2[1];
    }

    if (mainData2[0] == "height") {
        windowHeight = mainData2[1];
    }

    var windowWidth1 = (screen.width - windowWidth) / 2;
    var windowHeight1 = (screen.height - windowHeight) / 2;
   
    if (windowHeight1 != null && windowWidth1 != null) {
        windowopentags += ", top=" + windowHeight1 + ",left =" + windowWidth1;
    }

	var pname="";
	var widnowName="";
	if( propertypagename != null )
	{
		for( var i=0;i<propertypagename.length;i++)
		{
			var c = propertypagename.charAt(i);
			if( (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || (c >= '0' && c <= '1') )
				pname+=c;

		}
		windowName = pname+dii;
	}

	
	if(propertypagename == "workflowmemo")
		newwin=window.open(u+"mode=new&propertypage=" + propertypagename + "&WorkflowID="+parent._skWorkflowName+"&WorkflowSelectAction="+selectedactionname+"&filename="+parent._skFileName+"&skfilename="+parent._skFileName+"&propertyname=" + propertyname +""+"&SkDii="+dii,windowName,'height=350,width=650,resizable=no');
	else
	    newwin=window.open(u+"mode=new&propertypage=" + propertypagename + "&WorkflowID="+parent._skWorkflowName+"&WorkflowSelectAction="+selectedactionname+"&filename="+parent._skFileName+"&skfilename="+parent._skFileName+"&propertyname=" + propertyname + "&SkDii="+dii ,windowName,windowopentags);

	
	return newwin;

}



function OpenPropertyPages(opentype)
{
     var dii = window.parent.parent.GetStateData("designerinstanceid");     
	switch (opentype) 
	{	
	case "open":
		return wf_openpropertypage('open','','','height=106,width=350,resizable=no')
	break; 
	case "rename":
		return wf_openpropertypage('rename','','','height=129,width=349,resizable=no')
	break;	
	case "saveas":
		return 	wf_openpropertypage('saveas','','','height=108,width=350,resizable=no')
	break;
	case "delete":
		return wf_openpropertypage('delete','','','height=107,width=350,resizable=no')
	break;
	case "export":
	    // any change in this condition should be applied for exportconfig too.
		var u=window.parent.parent.location.href;
	    u = u+((u.indexOf('?') > 0)?'&':'?');
		window.parent.parent.location.href=u+"mode=new&propertypage=export&WorkflowID="+parent._skWorkflowName+"&WorkflowSelectAction="+GetSelectedObjectID()+"&filename="+parent._skFileName+"&skfilename="+parent._skFileName+"&propertyname="+"&SkDii="+dii;
	break;
	case "exportconfig":
	    //will be called from M:\SkeltaDev3.0\Dev4.0\Skelta.Packaging\Codebehind\ExportLookupConfig.aspx.cs page.
		var u=window.parent.parent.location.href;
	    u = u+((u.indexOf('?') > 0)?'&':'?');
		window.parent.parent.location.href=u+"mode=new&propertypage=export&WorkflowID="+parent._skWorkflowName+"&WorkflowSelectAction="+GetSelectedObjectID()+"&filename="+parent._skFileName+"&skfilename="+parent._skFileName+"&propertyname="+"&SkDii="+dii +"&exc=t";
	break;
	case "import":
		return wf_openpropertypage('import','','','height=250,width=600,top=200,left=250')
	break;			
	case "opendeployed":		
		return wf_openpropertypage('opendeployed','','','height=128,width=350,resizable=no') 
	break;
	case "validatedefinition":		
		return wf_openpropertypage('validatedefinition','','','height=400,width=600,resizable=no') 
	break;
	case "publishdefinition":		
		return wf_openpropertypage('publishdefinition','','','height=185,width=350,resizable=no') 
	break;
	case "deploy":		
		return wf_openpropertypage('deploy','','','height=128,width=350,resizable=no')
	break;
	case "clear":		
		return wf_openpropertypage('clear','','','height=170,width=340,resizable=no')
    case "newlink":
        return wf_openpropertypage('newlink','','','height=170,width=390,resizable=no')  
	break;
	
	
	}
}


function OnMenuItemClick(id)
{
    switch(id)
    {
        /* example case "open": var w=OpenPropertyPages("open");
                     w.onunload=ReloadDiagram; //Diagram needs to be reloaded since the file is opened
                     break;*/
    case "mnuPublish":
            var w= OpenPropertyPages("publishdefinition");
            w.onunload=ReloadDiagram;
            break;
    case "mnuValidate":
            var w= OpenPropertyPages("validatedefinition");
            w.onunload=ReloadDiagram;
            break;
    case "mnuImpFrmVisio":
		        var w= wf_openpropertypage('mnuImpFrmVisio','','','height=250,width=400,resizable=yes,top=200,left=250')
	            break;
	case "mnuOpenDeployed":
	
			var w= OpenPropertyPages("opendeployed");
			w.onunload=ReloadDiagram;
	            break;
	case "mnuOpenFile":
			var w=  OpenPropertyPages("open");
			//w.onunload=ReloadDiagram;
	            break;
	case "mnuSaveAs":
	            var w=  OpenPropertyPages("saveas");
			    //var w= OpenNewWindowPage("saveas.aspx","","height=129,width=349,resizable=yes");
	            break;
	case "mnuRenameFile":
	            var w=  OpenPropertyPages("rename");
			    //var w= OpenNewWindowPage("rename.aspx","","height=129,width=349,resizable=yes");
	            break;
	case "mnuDelete":
			var w=  OpenPropertyPages("delete");
			w.onunload=ReloadDiagram;
	            break;
	case "mnuExport":
			OpenPropertyPages("export");			
	            break;
    case "mnuExportC":
        var lcsuri = window.parent.parent.location.href.split("lcsuri=")[1];
	    var w = OpenNewWindowPage("Repository/Site/ExportWorkflowConfig.aspx?lcsuri=" + lcsuri + "&", "", "height=700,width=790,resizable=yes,scrollbars=no");			
        break;

	    case "openimageemf": var w= OpenNewWindowPage("ProcessDesigner/SaveAsEMF.aspx","","height=50,width=50,resizable=yes,scrollbars=yes");
	                      break;
        case "openimagepng": var w= OpenNewWindowPage("ProcessDesigner/SaveAsPNG.aspx","","height=50,width=50,resizable=yes,scrollbars=yes");
	                      break;
	                      
	case "alternateactor":
		var w= OpenNewWindowPage("ProcessDesigner/AlternateActor/AlternateActor.aspx","","height=550,width=1150,resizable=yes,scrollbars=no");
		break;
		
	case "workitemfields":
	    var w = OpenNewWindowPage("ProcessDesigner/WorkItemsField/WorkItemField.aspx", "", "height=600,width= 1300,left= 15,top = 15,resizable=yes,scrollbars=no");
	    //// Increased the hieght and width of work item field page for package window compatiblity 
		break;		
	case "worklistlayout":
	    var w=OpenNewWindowPage("Workitemlist/WorklistControl.aspx","","height=430,width=950,resizable=yes,scrollbars=no");
		break;
	case "mnuWFCorrection":
	    var w=OpenNewWindowPage("BPMUITemplates/Default/Repository/Site/WorkflowCorrection.aspx","","height=380,width=800,resizable=yes,scrollbars=no");
		break;
	case "mnuWizard":
	    var w = window.innerWidth;
	    var h = window.innerHeight;
	    var winHeight = h / 2 - 260;
	    var winWidth = w / 2 - 200;
	    
          
		var   RadWindowStatus= OpenNewWindowPage("Wizards/WizardController.aspx","","left="+ winWidth +",height=600,width=800,top="+ winHeight +",resizable=no,scrollbars=no");
		break;
case "mnuTestRun":
    var lcsuri = window.parent.parent.location.href.split("lcsuri=")[1];
    var w = OpenNewWindowPage("Repository/Site/WorkFlowExecution.aspx?lcsuri=" + lcsuri + "&wfname=" + parent._skWorkflowName + "&appname=" + parent._skApplicationName + "&version=" + parent._skFileName + "&culture=" + parent._skUICulture + "", "", "height=320,width=920,left=50,resizable=yes,scrollbars=no");
   
    break;        
    default:    //alert("This feature will be available in next Beta Release.");
                     break;
    }
}

function closeRad()
{ 
parent._skRadWindow = false;
}


function OpenHelpWin(page, winproperties)
{
	if(winproperties.indexOf('resizable') < 0)
		winproperties = winproperties + ',resizable=yes';
	if(winproperties.indexOf('scrollbars') < 0)
		winproperties = winproperties + ',scrollbars=yes';


	window.open(page,'helpPage',winproperties);
}
function trim(theString) //Remove Trailing spaces
{
	while(""+theString.charAt(theString.length-1)==" ")
		theString = theString.substring(0, theString.length-1);
	while(""+theString.charAt(0)==" ")
		theString = theString.substring(1, theString.length);
	return(theString);		  					 
}

