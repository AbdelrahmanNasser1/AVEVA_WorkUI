var MainDesignerFrame=true;	
document.onselectstart=function()
{
return false;
}

window.onresize=Paint;

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
	pdiv.style.left = _oldleft;
	pdiv.style.top = _oldtop;
    pdiv.style.width = _oldwidth;
    pdiv.style.height = _oldheight;			
	pdiv.width = _oldmw;
	pdiv.height = _oldmh;
	window.top.onresize = null;
}
	

function UpdateFullScreenWindow()
{
	if( !_fullscreen ) return;
	var pdiv = window.frameElement.parentNode;
	pdiv.style.position="absolute";
	pdiv.style.left=0;
	pdiv.style.top=0;
	pdiv.style.width = window.top.document.body.clientWidth;
	pdiv.style.height = window.top.document.body.clientHeight;
}



function Paint()
{
	var toolbarh = 28;
	var statusbarh = 35;
	var extrah=0;
	var extraw=0;
    var summaryview = 40;	
	
	var mw = frameElement.offsetWidth-extraw;
	var mh = frameElement.offsetHeight-extrah;
	var iframewidth = mw;
	var iframeheight = mh - toolbarh - statusbarh - summaryview;
	
	//added to solve the issue (Test run from context menu)30/9/2008
	iframeheight=""+Math.round(iframeheight);
var is_negative=(iframeheight<0)? true:false;
if(is_negative){
 iframeheight=iframeheight.substring(1,iframeheight.length) 
 
}
iframeheight=parseInt(iframeheight);

	var iframel=0;
	var iframet=0;
	

	var toolbar = document.getElementById("pd_toolbar");
	toolbar.style.left = 0;
	toolbar.style.top = 0;
	toolbar.style.width = mw;
	toolbar.style.height = toolbarh;


	var toolbardetails = document.getElementById("pd_toolbardetails");
	toolbardetails.style.left = mw - toolbardetails.offsetWidth-5;
	toolbardetails.style.top = 4;
	toolbardetails.style.visibility = "visible";
	
	summarydiv=document.getElementById("summary");
	summary.style.position="absolute";
    summary.style.left = iframel;
    summary.style.top = toolbarh;
    summary.style.width = iframewidth;
    summary.style.height = summaryview;


	var pdcanvas = document.getElementById("pd_canvas");
	pdcanvas.style.left =  iframel;
	pdcanvas.style.top = toolbarh + summaryview + 30;
	pdcanvas.style.width = iframewidth;
	pdcanvas.style.height = iframeheight;
	
	
    tabstrip=document.getElementById("tabstrip1");
    tabstrip.style.position="absolute";
    tabstrip.style.left = iframel;
    tabstrip.style.top = toolbarh + summaryview + 20;
    tabstrip.style.width = iframewidth;
    tabstrip.style.height = statusbarh;
}
