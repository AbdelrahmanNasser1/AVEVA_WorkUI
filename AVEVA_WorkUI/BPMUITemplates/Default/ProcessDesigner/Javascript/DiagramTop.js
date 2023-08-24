var MainDesignerFrame=true;	
document.onselectstart=function()
{
    return false;
}


var _fullscreen=false;
var _oldposition=null;
var _oldleft, _oldtop, _oldwidth, _oldheight,_oldmw,_oldmh, _oldbwidth, _oldbheight;
var _MainMenuBar;
var _MainToolBar;
var _SKPropertiesDocked=true;
var _SKPropertiesVisible=false;
var _SKPropertiesWidth;
var _SKPropertiesHeight;
var _SKPropertiesLeft;
var _SKPropertiesTop;

function SwitchToFullScreen()
{	
	var pdiv = window.frameElement.parentNode;
	if( !_fullscreen )
	{
	    _oldpdiv = pdiv.parentNode;
		_oldposition = pdiv.style.position;
		_oldleft = pdiv.style.left;
		_oldtop = pdiv.style.top;
		_oldwidth = pdiv.style.width;
		_oldheight = pdiv.style.height;		
		_oldmw = pdiv.width;
		_oldmh = pdiv.height;	


		_fullscreen=true;
	
		UpdateFullScreenWindow();
	}
	else
	{
		restorewindow();
		_fullscreen=false;
	}
}

function restorewindow()
{
	var pdiv = window.frameElement.parentNode;
	pdiv.style.position = _oldposition;
	pdiv.style.left = _oldleft + 'px';
	pdiv.style.top = _oldtop + 'px';
	pdiv.style.width = _oldwidth + 'px';
	pdiv.style.height = _oldheight + 'px';
	pdiv.width = _oldmw + 'px';
	pdiv.height = _oldmh + 'px';
	//window.top.onresize = null;
}
	

function UpdateFullScreenWindow()
{
	if( !_fullscreen ) return;
	var pdiv = window.frameElement.parentNode;
	pdiv.style.position="absolute";
	pdiv.style.left = 0 + 'px';
	pdiv.style.top = 0 + 'px';
	
	pdiv.style.width = wtop.document.body.clientWidth + 'px';
	pdiv.style.height = wtop.document.body.clientHeight +'px';
	

}




function WriteToDebugger(str)
{
	Debugger.WriteLine(str);
}



function DisableIncompatibleItems()
{
	if( !_skBrowser.ie ) 
	{
		if( document.getElementById('pd_zoom') )
			document.getElementById("pd_zoom").disabled=true; //Zooming not supported in non-IE Browsers
	}
	ToolBoxVisible=true;
	window.onresize=Paint;
	Paint();
}



var ToolBoxVisible=true;
function ShowToolBox()
{
	ToolBoxVisible=true;
	Paint();
}

function HideToolBox()
{
	ToolBoxVisible=false;
	Paint();
}

function ToggleToolBox()
{
	if(ToolBoxVisible )
		HideToolBox();
	else
		ShowToolBox();
}


function Paint()
{
    if( ReadOnlyView )
    {
        ToolBoxVisible=false;
    }
    
    
	var toolbarh = 60;
	var statusbarh = 22;
	var toolboxw = 150;//160;
	//var toolboxw = 200;
	var toolboxtitleh = 25;
	var extrah=0;
	var extraw=0;
	
	
	var mw = frameElement.offsetWidth - extraw ;
	var mh = frameElement.offsetHeight - extrah;
	var iframewidth = mw ;
	var iframeheight = mh - toolbarh - statusbarh;
	var iframel=0;
	var iframet=0;
	
	var toolbar = document.getElementById("pd_toolbar");
	toolbar.style.left = 0 + 'px';
	toolbar.style.top = 0 + 'px';
	toolbar.style.width = mw + 'px';
	toolbar.style.height = toolbarh + 'px';


	var toolbardetails = document.getElementById("pd_toolbardetails");
	toolbardetails.style.left = mw - toolbardetails.offsetWidth + 'px';
	toolbardetails.style.top = 0 + 'px';
	toolbardetails.style.visibility = "visible";
	
	if (_MainMenuBar) _MainMenuBar.menuBarObj.style.width = mw + 'px';

	var toolbox = document.getElementById("pd_toolbox");
	var toolboxanchor = document.getElementById("toolboxanchor");
	

	if( ToolBoxVisible )
	{	
		toolbox.style.left = 0;
		toolbox.style.top = toolbarh + 'px';
		toolbox.style.width = toolboxw + 'px';
		toolbox.style.height = mh - toolbarh - statusbarh + 'px';
		toolbox.style.visibility = "visible";
		
		_skpdResizeToolbox(toolboxw-10, mh - toolbarh - statusbarh-15);
		
		toolboxanchor.style.left = toolboxw + 'px';
		toolboxanchor.style.top = toolbarh + 'px';
		toolboxanchor.style.height = iframeheight + 'px';
		toolboxanchor.style.width = 10 + 'px';
		var timg=document.getElementById("toolboxanchorimage");
		timg.style.position="absolute";
		timg.style.top = Math.round(iframeheight / 2) - 27 + 'px';
		timg.style.left = 0;
		document.getElementById("toolboxanchorimage").src=ImagesLocation+"collapsable-menu-barclose.gif";
		toolboxanchor.style.zIndex = 1000;
		toolboxanchor.style.visibility = "visible";
		
		iframel += toolboxw+10;
		iframewidth -= toolboxw+10;

	}
	else
	{
		toolbox.style.visibility = "hidden";
		toolboxanchor.style.left=0;
		toolboxanchor.style.top = toolbarh + 'px';
		toolboxanchor.style.height = iframeheight + 'px';
		toolboxanchor.style.width = 10 + 'px';
		var timg=document.getElementById("toolboxanchorimage");
		timg.style.position="absolute";
		timg.style.top = Math.round(iframeheight / 2) - 27 + 'px';
		timg.style.left = 0; 
        iframel += 10;
        iframewidth -= 10;
		document.getElementById("toolboxanchorimage").src=ImagesLocation+"collapsable-menu-baropen.gif";
	}
	
	
	var pdstatusbar = document.getElementById("pd_statusbar");
	pdstatusbar.style.left = 0 +'px';
	pdstatusbar.style.top = toolbarh + iframeheight + 'px';
	pdstatusbar.style.width = mw + 'px';
	pdstatusbar.style.height = statusbarh + 'px';

	
	if( _SKPropertiesDocked && _SKPropertiesVisible )
	{
	    
	    _SKPropertiesWidth = 275;	   
	    _SKPropertiesHeight = iframeheight;	    
	    _SKPropertiesLeft = mw - _SKPropertiesWidth;	    
	    _SKPropertiesTop = toolbarh;
	    iframewidth -= _SKPropertiesWidth;
	   
	}
	
	GetDiagramObject().PaintPropertiesWindow();
	
	var pdcanvas = document.getElementById("pd_canvas");
	pdcanvas.style.left = iframel + 'px';
	pdcanvas.style.top = toolbarh + 'px';
	pdcanvas.style.width = iframewidth + 'px';
	pdcanvas.style.height = iframeheight + 'px';

	if( Debugger.DebugOn ) Debugger.RepositionWindow();	
}


function GetDiagramObject()
{
	return document.getElementById('pd_canvas_frame').contentWindow;
}

