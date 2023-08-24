var _skBrowser = new BrowserCheck(); //Global Objects
var _Range = null;

//var _ToolBar_MainForm = new Array();
//_ToolBar_MainForm[0] = new ToolBarItem("Add new Control","file://M:\\vsimagelib\\AddTableHS.png","addcontrol",null);
//_ToolBar_MainForm[1] = new ToolBarItem("Add new Control","file://M:\\vsimagelib\\AddTableHS.png","addcontrol",null);

function InitializeToolbar()
{
    //  DrawToolBar("_ToolBar_MainForm");
}

function DrawToolBar(toolBarDefinitionVariableName)
{
    var toolBarDefinition = eval(toolBarDefinitionVariableName);
    var toolBarDefString = new Array();
    toolBarDefString.push("<div id='" + toolBarDefinitionVariableName + "_div' class='toolbar'>");
    var i = 1;
    for (var itemIndex in toolBarDefinition)
    {
        var item = toolBarDefinition[itemIndex];
        toolBarDefString.push("<span id='" + toolBarDefinitionVariableName + "_item" + i + "' class='toolitem' onmouseover='this.className=\"toolitemactive\";' onmouseout='this.className=\"toolitem\";' ><img src='" + item.Image + "' title='" + item.Title + "' /></span>");
        i++;
    }
    toolBarDef = toolBarDefString.join("");
    AppendEl(document.body, toolBarDef);
}

function ToolBarItem(title, image, type, action)
{
    this.Title = title;
    this.Image = image;
    this.Action = action;
    this.Type = type;
}

function AppendEl(el, data)
{
    if (_skBrowser.ie)
    {
        el.insertAdjacentHTML("beforeEnd", data);
    }
    else
    {
        if (!_Range) CreateRange();
        var docFrag = _Range.createContextualFragment(data);
        el.appendChild(docFrag);
    }
}

function CreateRange()
{
    if (!_skBrowser.ie)
    {
        var rDiv = document.createElement("div");
        rDiv.id = "rDiv";
        document.body.appendChild(rDiv);
        _Range = document.createRange();
        _Range.selectNode(rDiv);
    }

}


function BrowserCheck()
{
    var b = navigator.appName;
    //	alert(parseInt(navigator.appVersion));
    if (b == "Netscape") this.b = "ns";
    else if (b == "Microsoft Internet Explorer") this.b = "ie";
    else this.b = b;
    this.v = parseInt(navigator.appVersion, 10);
    this.ns = (this.b == "ns" && this.v >= 4);
    this.ns4 = (this.b == "ns" && this.v == 4);
    this.ns5 = (this.b == "ns" && this.v == 5);
    this.ns7plus = (this.b == "ns" && navigator.vendorSub && parseFloat(navigator.vendorSub) >= 7);
    this.ie = (this.b == "ie" && this.v >= 4);
    this.ie4 = (navigator.userAgent.indexOf('MSIE 4') > 0);
    this.ie5 = (navigator.userAgent.indexOf('MSIE 5') > 0);
    this.ie6 = (navigator.userAgent.indexOf('MSIE 6') > 0);
    this.ie5plus = document.getElementById && this.ie;
    this.iemac = !!(this.ie && navigator.userAgent.toLowerCase().indexOf("mac") >= 0);
    if (this.ie5) this.v = 5;
    this.firefox = (navigator.userAgent.toLowerCase().indexOf("firefox") != -1) && !this.ie;
    this.firefox1plus = this.firefox && this.v > 1;
    this.min = (this.ns || this.ie);

    if (this.ie5plus || this.firefox1plus || this.ns7plus || this.ns5)
        this.Compatible = true;
    else
        this.Compatible = false;
    //Currently Process Designer works only with 1e 5.5+ and FireFox 1.0 Browser & Netscape browsers	
    if (!(this.Compatible)) alert("@@Skelta Forms Designer is not compatible with the current browser, Compatible browsers are Firefox 1.5+ & IE 6+@@");

}


function OpenAddWindow(controlId, CacheKey, ListName, targetType, designermode, versionstamp)
{
    var features = ',resizable=yes';
    var u = _TemplateDirectorySkeltaForms + "AddControl.aspx?sfdcontainer=" + encodeURIComponent(controlId) + "&cachekey=" + CacheKey + "&ListName=" + encodeURIComponent(ListName) + "&TargetControlType=" + targetType + "&designermode=" + designermode + "&versionstamp=" + versionstamp;
    var oWindow1 = CenterWindow(u, 'controladd', 700, 500, 50, features);
    return oWindow1;

}

function OpenEditWindow(controlId, CacheKey, ListName, designermode, versionstamp)
{
    var features = ',resizable=yes';
    var u = _TemplateDirectorySkeltaForms + "EditControl.aspx?AddEditCriteria=false" + "&sfdcontainer=" + encodeURIComponent(controlId) + "&cachekey=" + CacheKey + "&ListName=" + encodeURIComponent(ListName) + "&designermode=" + designermode + "&versionstamp=" + versionstamp;
    var oWindow1 = CenterWindow(u, 'controledit', parseInt(document.body.clientWidth / 1.9, 10), parseInt(document.body.clientHeight / 1.3, 10), 50, features);
    return oWindow1;
}

function CenterWindow(url, windowName, windowWidth, windowHeight, windowOuterHeight, features)
{
    var centerLeft = parseInt((window.screen.availWidth - windowWidth) / 2);
    var centerTop = parseInt(((window.screen.availHeight - windowHeight) / 2) - windowOuterHeight);
    var windowFeatures = 'width=' + windowWidth + ',height=' + windowHeight + ',left=' + centerLeft + ',top=' + centerTop + features;
    var win = window.open(url, windowName, windowFeatures);
    win.focus();
    return win;
}

function DeleteControl(controlId, CacheKey, ListName, versionstamp)
{
    var deletewin;
    var features = ',resizable=no';
    var u = _TemplateDirectorySkeltaForms + "DeleteControl.aspx?sfdcontainer=" + encodeURIComponent(controlId) + "&cachekey=" + CacheKey + "&ListName=" + encodeURIComponent(ListName) + "&versionstamp=" + versionstamp;
    var oWindow1 = CenterWindow(u, 'controldelete', 400, 220, 50, features);
    return oWindow1;
}

function OpenExportWindow(frmDefID, CacheKey, ListName, versionstamp)
{
    try
    {

        //var u= "?FrmLstItmID="+CacheKey +"&FrmDefnID="+frmDefID +"&FrmActionType=Export"+"&cachekey="+CacheKey+"&ListName="+ListName+"&versionstamp="+versionstamp;
        window.location.href = window.location.href + "&FrmLstItmID=" + CacheKey + "&FrmDefnID=" + frmDefID + "&FrmActionType=Export" + "&cachekey=" + CacheKey + "&ListName=" + ListName + "&versionstamp=" + versionstamp;
    }
    catch (err) { }
}


//Copy Paste Control Feature

function OpenCopyWindow(controlId, CacheKey, ListName, designermode, versionstamp, successfulMessage, failureMessage)
{
    try
    {
        var clipboard = document.getElementById("Skelta_Forms_ClipBoard_HiddenVariable");
        if (clipboard == null)
        {
            clipboard = document.createElement("input");
            clipboard.setAttribute("id", "Skelta_Forms_ClipBoard_HiddenVariable");
            clipboard.setAttribute("type", "hidden");
            clipboard.setAttribute("value", controlId);
            document.body.appendChild(clipboard);
        }
        else
        {
            clipboard.value = controlId;
        }

        CallServerSideMethod(_skidmap["TOPFORMRENDERERID"], 'CopyControl', controlId, CallBackSetControlStructure, 'table', _skstatemap, 'controlId', controlId, 'cacheKey', CacheKey, 'versionStamp', versionstamp, 'listName', ListName);
    }
    catch (err)
    {
        alert(failureMessage);
    }
}

function CallBackSetControlStructure(context, result, response)
{
    if (result != null)
    {
        var returnVal = result[0];
        if (returnVal != '' || returnVal != undefined)
        {
            var clipboard1 = document.getElementById("Skelta_Forms_ClipBoard_HiddenDefinition");
            if (clipboard1 == null)
            {
                clipboard1 = document.createElement("input");
                clipboard1.setAttribute("id", "Skelta_Forms_ClipBoard_HiddenDefinition");
                clipboard1.setAttribute("type", "hidden");
                clipboard1.setAttribute("value", returnVal);
                document.body.appendChild(clipboard1);
            }
            else
            {
                clipboard1.value = returnVal;
            }
        }
    }
}

function OpenPasteWindow(frmDefID, CacheKey, ListName, versionstamp)
{
    try
    {
        var sRetrieveData = "";
        var clipboard = document.getElementById("Skelta_Forms_ClipBoard_HiddenVariable");
        if (clipboard != null)
        {
            sRetrieveData = clipboard.value;
        }
        var sRetrieveStructure = "";
        var clipboard1 = document.getElementById("Skelta_Forms_ClipBoard_HiddenDefinition");
        if (clipboard1 != null)
        {
            sRetrieveStructure = clipboard1.value;
        }
        CallServerSideMethod(_skidmap["TOPFORMRENDERERID"], 'PasteControl', sRetrieveData, CallBackDesignerRefresh, 'table', _skstatemap, 'controlId', sRetrieveData, 'cacheKey', CacheKey, 'versionStamp', versionstamp, 'listName', ListName, 'containerId', frmDefID, 'controlStructure', sRetrieveStructure);
    }
    catch (err)
    {
    }
}

function CallBackDesignerRefresh(context, result, response)
{
    if (result != null)
    {

        for (var i = 0; i < result.length; i++)
        {
            try
            {
                eval(result[i]);
            }
            catch (err) { }
        }
    }
}

var apnlCollec;
function DoAjaxRequestForDesigner(ajaxId)
{
    AjaxNS.MaxRequestQueueSize = 10000;
    if (apnlCollec == undefined)
        apnlCollec = new Object();

    if (apnlCollec[ajaxId] == undefined)
    {
        apnlCollec[ajaxId] = true;
        var ajaxPanelCltID = _skidmap[ajaxId];
        var arjs = 'RefreshingAjax';
        if (ajaxPanelCltID != undefined)
        {
            window[ajaxPanelCltID].AjaxRequest(arjs);
        }
    }
    else
    {
        return;
    }
}

//End of Copy Paste control feature


function OpenListStructureWindow(DefnID, ListItemId, ListName, Repository, UserId, Mode, Title)
{
    if (Mode == "")
    {
        Mode = "View";
    }
    var u = _TemplateDirectorySkeltaForms + "ListStructure.aspx?DefnID=" + DefnID + "&ListItemId=" + ListItemId + "&ListName=" + ListName + "&Repository=" + Repository + "&Mode=" + Mode + "&Title=" + Title + "&UserId=" + UserId;
    var features = ',resizable=no';
    var oWindow1 = CenterWindow(u, 'loadXmlBoundTo', 500, 500, 50, features);
    return oWindow1;
}

function OpenImportWindow(controlId, CacheKey, ListName, versionstamp)
{
    var features = ',resizable=no';
    var u = _TemplateDirectorySkeltaForms + "ImportForm.aspx?sfdcontainer=" + encodeURIComponent(controlId) + "&cachekey=" + CacheKey + "&ListName=" + encodeURIComponent(ListName) + "&versionstamp=" + versionstamp;
    var oWindow1 = CenterWindow(u, 'controlimport', 400, 280, 50, features);
    return oWindow1;
}

var _DragDropTargets = new Array();
var _DragDropManager = new DragDropHandler();
function DragDropHandler()
{
    this.SourceId = null;
    this.SourceType = null;
    this.X = 0;
    this.Y = 0;
    this.DragDropOn = false;
    this.SelectedItem = null;
    this.SelectedItemType = null;
    this.IsToolBarItem = false;
    this.OptionalSettings = null;
    this.CacheKey = null;
    this.ListName = null;
    this.VersionStamp = null;
}


DragDropHandler.prototype.NotifyHover = function (sender)
{
    if (!this.DragDropOn) return;
    this.SelectedItem = sender;
    this.SelectedItemType = sender.getAttribute("targetType");
    this.HighlightTarget(sender);

}



DragDropHandler.prototype.NotifyOutOfHover = function (sender)
{
    if (!this.DragDropOn) return;
    this.UnHighlightTarget(sender);
    this.SelectedItem = null;
    this.SelectedItemType = null;
}



DragDropHandler.prototype.Start = function (sender, sourceId, sourceargs, istoolbaritem, optionalsettings, cachekey, Listname, versionstamp)
{
    if (istoolbaritem)
        this.IsToolBarItem = true;
    else
        this.IsToolBarItem = false;

    var evt = null;
    if (sourceargs != null)
    {
        evt = sourceargs[0];
    }
    if (window.event) evt = window.event;
    if (evt.preventDefault)
        evt.preventDefault();
    if (evt.stopPropagation)
        evt.stopPropagation();
    evt.cancelBubble = true;


    this.DragDropOn = true;
    this.SourceId = sourceId;
    this.SourceType = sender.getAttribute("senderType");
    this.OptionalSettings = optionalsettings;
    this.CacheKey = cachekey;
    this.ListName = Listname;
    this.VersionStamp = versionstamp;
    //alert(this.OptionalSettings);
    this.ShowTargets();

    var point = FindPos(sender);

    this.X = point.X;
    this.Y = point.Y;
    this.ShowDragBox();

    if (window.addEventListener)
    {
        window.addEventListener('dragstart', OnDragStartHandler, false);
    }
    else
    {
        window.attachEvent('ondragstart', OnDragStartHandler);
        document.attachEvent('ondragstart', OnDragStartHandler);
    }

    if (window.addEventListener)
    {
        window.addEventListener('mousemove', OnDragMouseMoveHandler, false);
    }
    else
    {
        window.attachEvent('onmousemove', OnDragMouseMoveHandler);
        document.attachEvent('onmousemove', OnDragMouseMoveHandler);
    }

    if (window.addEventListener)
    {
        window.addEventListener('mouseup', OnDragMouseUpHandler, false);
    }
    else
    {
        window.attachEvent('onmouseup', OnDragMouseUpHandler);
        document.attachEvent('onmouseup', OnDragMouseUpHandler);
    }


    return false;
}

DragDropHandler.prototype.End = function ()
{
    this.DragDropOn = false;
    this.HideTargets();

    this.HideDragBox();

    if (window.addEventListener)
    {
        window.removeEventListener('dragstart', OnDragStartHandler, false);
    }
    else
    {
        window.detachEvent('ondragstart', OnDragStartHandler);
        document.detachEvent('ondragstart', OnDragStartHandler);
    }

    if (window.addEventListener)
    {
        window.removeEventListener('mousemove', OnDragMouseMoveHandler, false);
    }
    else
    {
        window.detachEvent('onmousemove', OnDragMouseMoveHandler);
        document.detachEvent('onmousemove', OnDragMouseMoveHandler);
    }

    if (window.addEventListener)
    {
        window.removeEventListener('mouseup', OnDragMouseUpHandler, false);
    }
    else
    {
        window.detachEvent('onmouseup', OnDragMouseUpHandler);
        document.detachEvent('onmouseup', OnDragMouseUpHandler);
    }



}


function OnDragStartHandler()
{
    return false;
}

var Wait;
function OnDragMouseMoveHandler(evt)
{
    if (Wait) return false;
    Wait = 1;
    setTimeout('Wait = 0;', 10); //Wait for 5 milliseonds, this to avoid excessive responses to mouse move event

    if (!evt) evt = event;

    if (evt.preventDefault)
        evt.preventDefault();
    if (evt.stopPropagation)
        evt.stopPropagation();
    evt.cancelBubble = true;

    var x = evt.clientX - 5;
    var y = evt.clientY - 5;

    _DragDropManager.MoveTo(x, y);
}

function OnDragMouseUpHandler(evt)
{
    _DragDropManager.End();
    var SelectedItemID = "";
    if (_DragDropManager.SelectedItem != null)
    {
        var moveType = "insert";
        var ctrltype = _DragDropManager.SelectedItem.getAttribute("controltype");
        if (ctrltype == "form" || ctrltype == "topform")
        {
            moveType = "append";
        }
        SelectedItemID = new String(_DragDropManager.SelectedItem.id);

        var ctrlNameSpace = _DragDropManager.SelectedItem.getAttribute("targetType");
        if (ctrlNameSpace != null && ctrlNameSpace == "Skelta.Forms.Core.Controls.ElectronicSignatureForm")
        {
            if (SelectedItemID.indexOf("mitb") != -1)
            {
                return;
            }
        }
    }

    //alert("Selected Item TestAttribute:"+ _DragDropManager.SelectedItem.getAttribute("TestAttribute"));
    //alert("Selected Item is "+_DragDropManager.SelectedItem.getAttribute("controlid")+" and source item is "+_DragDropManager.SourceId);
    if (_DragDropManager.IsToolBarItem)
    {
        if (_DragDropManager.SelectedItem != null)
            DropControl(_DragDropManager.SourceId, _DragDropManager.SelectedItem.getAttribute("controlid"), moveType, _DragDropManager.OptionalSettings, _DragDropManager.CacheKey, _DragDropManager.ListName, _DragDropManager.SelectedItemType, _DragDropManager.VersionStamp);
    }
    else
    {
        if (_DragDropManager.SelectedItem != null)
        {
            if (_DragDropManager.SourceType == "Skelta.Forms.Core.Controls.Tab" && moveType != 'insert')
            {
                if (_DragDropManager.SelectedItemType == "Skelta.Forms.Core.Controls.Tabs")
                {
                    MoveControl(_DragDropManager.SourceId, _DragDropManager.SelectedItem.getAttribute("controlid"), moveType, _DragDropManager.CacheKey, _DragDropManager.ListName, _DragDropManager.VersionStamp);
                }
                else
                {
                    alert(skFormsDesignerMessages.OnlyTabControlAllowedInTabsContainer);
                    return null;
                }
            }
            else
            {
                if (SelectedItemID.lastIndexOf("_mtoolbar") > 0)
                {
                    if (_DragDropManager.SourceType != "Skelta.Forms.Core.Controls.Tab")
                    {
                        if (_DragDropManager.SelectedItemType != "Skelta.Forms.Core.Controls.Tab")
                        {
                            MoveControl(_DragDropManager.SourceId, _DragDropManager.SelectedItem.getAttribute("controlid"), moveType, _DragDropManager.CacheKey, _DragDropManager.ListName, _DragDropManager.VersionStamp);
                        }
                        else
                        {
                            alert(skFormsDesignerMessages.AddTabControlInTabsContainer);
                            return null;
                        }
                    }
                    else
                    {
                        alert(skFormsDesignerMessages.OnlyTabControlAllowedInTabsContainer);
                        return null;
                    }
                }
                else if (SelectedItemID.lastIndexOf("_mitb") > 0)
                {
                    if (_DragDropManager.SelectedItemType != "Skelta.Forms.Core.Controls.Tabs")
                    {
                        MoveControl(_DragDropManager.SourceId, _DragDropManager.SelectedItem.getAttribute("controlid"), moveType, _DragDropManager.CacheKey, _DragDropManager.ListName, _DragDropManager.VersionStamp);
                    }
                    else
                    {
                        alert(skFormsDesignerMessages.AddTabControlInTabsContainer);
                        return null;
                    }
                }
            }
        }
    }
    _DragDropManager.SelectedItem = null;
}

DragDropHandler.prototype.ShowDragBox = function ()
{
    var el = document.getElementById("sfd_DragDiv");
    if (el == null)
    {
        alert("DragDiv not found");
    }
    el.style.position = "absolute";
    el.style.left = this.X + 20 + "px";//Added px as in IE10 standards conversion
    el.style.top = this.Y + 20 + "px";
    el.style.visibility = "visible";
    el.style.display = "block";
};


DragDropHandler.prototype.MoveTo = function (x, y)
{
    var el = document.getElementById("sfd_DragDiv");
    if (el == null) { alert("DragDiv not found"); }

    el.style.left = x + 20 + "px";
    el.style.top = y + 20 + "px";
};

DragDropHandler.prototype.HideDragBox = function ()
{
    var el = document.getElementById("sfd_DragDiv");
    if (el == null) { alert("DragDiv not found"); }
    el.style.visibility = "hidden";
    el.style.display = "none";
}

//DragDropHandler.prototype.Move = function()


DragDropHandler.prototype.ShowTargets = function ()
{
    for (var index in _DragDropTargets)
    {
        var item = _DragDropTargets[index];
        var el = document.getElementById(item);
        if (el != null)
        {
            var ctrltype = el.getAttribute("controltype");
            var ctrlNameSpace = el.getAttribute("targetType");
            if (ctrlNameSpace != null && ctrlNameSpace == "Skelta.Forms.Core.Controls.ElectronicSignatureForm")
            {
                if (el.id.indexOf("mitb") == -1)
                {
                    el.className = "sfd-ddboxtarget";
                }
                continue;
            }
            if (ctrltype && ctrltype == "form")
                el.className = "sfd-ddboxformtarget";
            else if (ctrltype && ctrltype == "topform")
                el.className = "sfd-ddboxtopformtarget";
            else
                el.className = "sfd-ddboxtarget";

        }
        //else
        //alert(item+" not found while showing drop targets");
    }
}

DragDropHandler.prototype.HideTargets = function ()
{
    for (var index in _DragDropTargets)
    {
        var item = _DragDropTargets[index];
        var el = document.getElementById(item);
        if (el != null)
        {
            var ctrltype = el.getAttribute("controltype");
            if (ctrltype && ctrltype == "topform")
                el.className = "sfd-headerbar";
            else
                el.className = "sfd-toolbar";
        }
        // else
        //alert(item+" not found while hiding drop targets");
    }
}

DragDropHandler.prototype.HighlightTarget = function (el)
{
    if (el != null)
    {
        var ctrltype = el.getAttribute("controltype");
        var ctrlNameSpace = el.getAttribute("targetType");
        if (ctrlNameSpace != null && ctrlNameSpace == "Skelta.Forms.Core.Controls.ElectronicSignatureForm")
        {
            if (el.id.indexOf("mitb") == -1)
            {
                el.className = "sfd-ddboxtarget";
            }
            return;
        }
        if (ctrltype && ctrltype == "form")
        {
            el.className = "sfd-ddboxselectedtarget";
        }
        else if (ctrltype && ctrltype == "topform")
        {
            el.className = "sfd-ddboxtopformselectedtarget";
        }
        else
        {
            el.className = "sfd-ddboxselectedtargetsimple";
        }
    }
    else
        alert(item + " not found while selecting drop targets");
}

DragDropHandler.prototype.UnHighlightTarget = function (el)
{
    if (el != null)
    {
        var ctrltype = el.getAttribute("controltype");
        var ctrlNameSpace = el.getAttribute("targetType");
        if (ctrlNameSpace != null && ctrlNameSpace == "Skelta.Forms.Core.Controls.ElectronicSignatureForm")
        {
            if (el.id.indexOf("mitb") == -1)
            {
                el.className = "sfd-ddboxtarget";
            }
            return;
        }
        if (ctrltype && ctrltype == "form")
            el.className = "sfd-ddboxformtarget";
        else if (ctrltype && ctrltype == "topform")
            el.className = "sfd-ddboxtopformtarget";
        else
            el.className = "sfd-ddboxtarget";
    }
    else
        alert(item + " not found while selecting drop targets");
}


function FindPos(obj)
{
    var curleft = 0;
    var curtop = 0;
    if (obj.offsetParent)
    {
        while (obj.offsetParent)
        {
            curleft += obj.offsetLeft;
            curtop += obj.offsetTop;
            obj = obj.offsetParent;
        }
    }
    else
    {
        if (obj.x)
            curleft += obj.x;
        if (obj.y)
            curtop += obj.y;
    }
    return new Point(curleft, curtop);
}

function Point(x, y)
{
    this.X = x;
    this.Y = y;
}



function GetNewXMLHttpRequest()
{
    var xmlhttp;

    if (typeof (XMLHttpRequest) == 'undefined')
    {
        try
        {
            xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
        }
        catch (e)
        {
            try
            {
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            catch (E)
            {
                xmlhttp = false;
            }
        }
    }
    else
    {
        try
        {
            xmlhttp = new XMLHttpRequest();
        }
        catch (ee)
        {
            alert("Asynchronous Server Communication could not be initialized");
        }
    }

    return xmlhttp;
}


function MoveControl(sourceId, targetId, moveType, cachekey, ListName, VersionStamp)
{
    //alert(sourceId+" -> "+targetId+" type="+moveType);
    if (moveType == null) moveType = 'insert';
    var xmlhttp = GetNewXMLHttpRequest();

    xmlhttp.onreadystatechange = function ()
    {
        if (xmlhttp.readyState == 4)
        {
            if (xmlhttp.status != 200)
            {
                var ow = window.open("", null, "width=600,height=400,location=no,menubar=no,resizable=yes,scrollbars=yes,status=no,titlebar=no,toolbar=no");
                ow.document.write(xmlhttp.responseText);
                ow.document.close();
            }

            xmlhttp.onreadystatechange = null;
            xmlhttp = null;
            //window.location.reload();
            window.updateNewControl();
        }
    }

    var u = _TemplateDirectorySkeltaForms + "MoveControl.aspx?source=" + encodeURIComponent(sourceId) + "&target=" + encodeURIComponent(targetId) + "&movetype=" + moveType + "&cachekey=" + cachekey + "&ListName=" + encodeURIComponent(ListName) + "&versionstamp=" + VersionStamp;
    try
    {
        xmlhttp.open('GET', u, true);
    }
    catch (ee)
    {
        alert("Could not initiate to load page at URL " + u);
        throw ee;
    }

    try
    {
        xmlhttp.send(null);
    }
    catch (e)
    {
        alert("Could not load page at URL " + u + " Error " + e);
        throw e;
    }
}

function DropControl(sourceId, targetId, dropType, optionalsettings, cachekey, ListName, targetType, VersionStamp)
{
    //alert("EditControl.aspx?target="+escape(targetId)+"&controltype="+escape(sourceId)+"&droptype="+dropType+"&AddEditCriteria=true.OptionalSetiings:" + optionalsettings);
    var u = "";
    var SelectedItemID = "";
    if (_DragDropManager.SelectedItem != null)
        SelectedItemID = new String(_DragDropManager.SelectedItem.id);

    if (optionalsettings == "ShowTables")
    {
        u = _TemplateDirectorySkeltaForms + "ListTableSelect.aspx?target=" + encodeURIComponent(targetId) + "&controltype=" + encodeURIComponent(sourceId) + "&droptype=" + dropType + "&AddEditCriteria=true&cachekey=" + cachekey + "&ListName=" + encodeURIComponent(ListName);//&sfdcontainer=\"\"
        var features = ',resizable=yes';
        var oWindow1;//= window.radopen(u,null);    
        oWindow1 = CenterWindow(u, 'controladd', parseInt(document.body.clientWidth / 2, 10), parseInt(document.body.clientHeight / 1.3, 10), 50, features);
        return oWindow1;
    }
    else
    {
        if (sourceId == "Tab")
        {
            if (targetType == "Skelta.Forms.Core.Controls.Tabs" && dropType != 'insert')
            {
                u = _TemplateDirectorySkeltaForms + "EditControl.aspx?target=" + encodeURIComponent(targetId) + "&controltype=" + encodeURIComponent(sourceId) + "&droptype=" + dropType + "&AddEditCriteria=true&cachekey=" + cachekey + "&ListName=" + encodeURIComponent(ListName) + "&versionstamp=" + VersionStamp;//&sfdcontainer=\"\"
                var oWindow1;//= window.radopen(u,null);    
                var features = ',resizable=yes';
                oWindow1 = CenterWindow(u, 'controladd', parseInt(document.body.clientWidth / 2, 10), parseInt(document.body.clientHeight / 1.3, 10), 50, features);
                return oWindow1;
            }
            else
            {
                alert(skFormsDesignerMessages.OnlyTabControlAllowedInTabsContainer);
                return null;
            }
        }
        else
        {
            if (SelectedItemID.lastIndexOf("_mtoolbar") > 0)
            {
                if (targetType != "Skelta.Forms.Core.Controls.Tab")
                {
                    u = _TemplateDirectorySkeltaForms + "EditControl.aspx?target=" + encodeURIComponent(targetId) + "&controltype=" + encodeURIComponent(sourceId) + "&droptype=" + dropType + "&AddEditCriteria=true&cachekey=" + cachekey + "&ListName=" + encodeURIComponent(ListName) + "&versionstamp=" + VersionStamp;//&sfdcontainer=\"\"
                    var oWindow1;//= window.radopen(u,null);    
                    var features = ',resizable=yes';
                    oWindow1 = CenterWindow(u, 'controladd', parseInt(document.body.clientWidth / 2, 10), parseInt(document.body.clientHeight / 1.3, 10), 50, features);
                    return oWindow1;
                }
                else
                {
                    alert(skFormsDesignerMessages.AddTabControlInTabsContainer);
                    return null;
                }
            }
            else if (SelectedItemID.lastIndexOf("_mitb") > 0)
            {
                if (targetType != "Skelta.Forms.Core.Controls.Tabs")
                {
                    u = _TemplateDirectorySkeltaForms + "EditControl.aspx?target=" + encodeURIComponent(targetId) + "&controltype=" + encodeURIComponent(sourceId) + "&droptype=" + dropType + "&AddEditCriteria=true&cachekey=" + cachekey + "&ListName=" + encodeURIComponent(ListName) + "&versionstamp=" + VersionStamp;//&sfdcontainer=\"\"
                    var oWindow1;//= window.radopen(u,null);    
                    var features = ',resizable=yes';
                    oWindow1 = CenterWindow(u, 'controladd', parseInt(document.body.clientWidth / 2, 10), parseInt(document.body.clientHeight / 1.3, 10), 50, features);
                    return oWindow1;
                }
                else
                {
                    alert(skFormsDesignerMessages.AddTabControlInTabsContainer);
                    return null;
                }
            }
        }
    }

}

var dropDownStateManager = null;
var topFormClientID = null;
function ChangeControlsBasedGroup(ClientId, defn)
{
    var collection = defn.split(';');
    topFormClientID = ClientId;
    var designertoolbar = document.getElementById(ClientId + "DesignerToolBar");
    for (var i = 0 ; i < collection.length ; i++)
    {
        if (document.getElementById(ClientId + collection[i] + "div") != null)
        {
            document.getElementById(ClientId + collection[i] + "div").style.visibility = "hidden";
            document.getElementById(ClientId + collection[i] + "div").style.display = "none";
        }
    }
    dropDownStateManager = designertoolbar.value;
    document.getElementById(ClientId + designertoolbar.value + "div").style.visibility = "visible";
    document.getElementById(ClientId + designertoolbar.value + "div").style.display = "block";

}

var HiddenWidthOfToolBox;


function HideMenuPanelAndResizeAjax(clientId)
{
    var bodydiv = document.getElementById(clientId + "bodydiv");
    var footerdiv = document.getElementById(clientId + "footerdiv");
    var parentdiv = document.getElementById(clientId);
    var designerbartable = document.getElementById(clientId + "_designertoolbar");
    var toolbardiv = document.getElementById(clientId + "_mtoolbar");
    var headerdiv = document.getElementById(clientId + "_mitb");
    var splitter = document.getElementById(clientId + "SplitterImage");

    if (designerbartable.style.display == "none")
    {
        splitter.src = splitter.src.replace('splitterbarright', 'splitterbar');
        designerbartable.style.display = "block";
        designerbartable.style.visibility = "visible";
        designerbartable.style.width = HiddenWidthOfToolBox + 'px'; //Added px as in IE10 standards conversion - if px is not given that IE10 standards dow not take it
        bodydiv.style.width = (document.body.clientWidth - HiddenWidthOfToolBox) + 'px';
        toolbardiv.style.width = bodydiv.style.width;
    }
    else
    {
        splitter.src = splitter.src.replace('splitterbar', 'splitterbarright');
        HiddenWidthOfToolBox = designerbartable.clientWidth;
        designerbartable.style.display = "none";
        designerbartable.style.visibility = "hidden";
        bodydiv.style.width = document.body.clientWidth + 'px';
        //footerdiv.style.width=bodydiv.style.width;
        toolbardiv.style.width = bodydiv.style.width;
        designerbartable.style.width = 0;
    }
}

function showclosedhand(uniqueId)
{

    //var el = document.getElementById(uniqueId+"_designertoolbar");
    //var pathOfBPMUITemplates=window.location.href.substring(0,window.location.href.indexOf("Default"));
    //el.style.cursor="url("+pathOfBPMUITemplates+"Default/SkeltaForms/images/finalclosedhand.cur)";

}
function showopenhand(uniqueId)
{
    //var el = document.getElementById(uniqueId+"_designertoolbar");
    //var pathOfBPMUITemplates=window.location.href.substring(0,window.location.href.indexOf("Default"));
    //el.style.cursor="url("+pathOfBPMUITemplates+"Default/SkeltaForms/images/finalopenhand.cur)";
    //  
}


function OpenViewsWindow(controlId, CacheKey, ListName)
{

    var u = "http://skeltadtp26:8000/EnterpriseConsole/FormViews.aspx?&controlid=" + encodeURIComponent(controlId) + "&cachekey=" + CacheKey + "&ListName=" + encodeURIComponent(ListName);
    return window.open(u, 'controlview', 'top=100,left=150,height=400,width=300,resizable=no'); //_TemplateDirectorySkeltaForms

}

function OpenReplaceWindow(controlid, Cachekey, Listname, mode, versionstamp)
{
    var u = _TemplateDirectorySkeltaForms + "ReplaceControl.aspx?controlid=" + encodeURIComponent(controlid) + "&cachekey=" + Cachekey + "&ListName=" + encodeURIComponent(Listname) + "&mode=" + mode + "&versionstamp=" + versionstamp;
    var features = ',resizable=no';
    var oWindow1 = CenterWindow(u, 'controlreplace', 500, 190, 50, features);
}
function sf_retainLastSelectedTab(tabStpObj)
{
    document.getElementById(tabStpObj.ID + "_hph").value = tabStpObj.SelectedTab.Index;
}

function sf_loadLastToolBoxOption(definition)
{
    var collec = definition.split(';');
    if (dropDownStateManager != null)
    {
        if (topFormClientID != null)
        {
            document.getElementById(topFormClientID + "DesignerToolBar").value = dropDownStateManager;
            for (var i = 0; i < collec.length ; i++)
            {
                if (document.getElementById(topFormClientID + collec[i] + "div") != null)
                {
                    document.getElementById(topFormClientID + collec[i] + "div").style.visibility = "hidden";
                    document.getElementById(topFormClientID + collec[i] + "div").style.display = "none";
                }
            }
            document.getElementById(topFormClientID + dropDownStateManager + "div").style.visibility = "visible";
            document.getElementById(topFormClientID + dropDownStateManager + "div").style.display = "block";
        }
    }
}