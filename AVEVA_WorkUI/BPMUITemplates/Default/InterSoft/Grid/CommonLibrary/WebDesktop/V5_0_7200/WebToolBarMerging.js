function InitMergedWebToolBar(a){WebToolBarMergingEngine.CreateMerged(a)}var WebToolBarMergingEngine={GetParentFrameWindowName:function(c){var d,e,b,a;if(c!="_parent"){e=window;a=e.frameElement;while(d==null&&a!=null){if(a.tagName=="FRAME"){d=e.parent.frames[c];if(d==null){e=e.parent}}else{if(a.name==c||a.id==c){d=e}else{e=e.parent}}a=e.frameElement}}else{d=window.parent}return d},CreateMerged:function(l){WebToolBarEngine.Create(l);var b=ISGetObject(l);if(window.frameElement==null){return}if(b.Initialized){return}var p=WebToolBarMergingEngine.GetParentFrameWindowName(b.MergeToolBarParentWindowName);if(p){if(b.MergeToolBarParentID==null||b.MergeToolBarParentID==""){try{var n=b.PlaceHolder==null||b.PlaceHolder==""?p.GetPagePlaceHolderManager():p.ISGetObject(b.PlaceHolder);if(n==null){try{n=p.ISGetObject(b.PlaceHolder);if(n==null){p.InitPlaceHolderManager(b.PlaceHolder);n=p.ISGetObject(b.PlaceHolder)}}catch(h){var c;for(k in p.IS.RuntimeObjects){c=p.IS.RuntimeObjects[k];if(c.Id==b.PlaceHolder){delete p.IS.RuntimeObjects[k];break}}if(b.Id.indexOf("_")>-1){var o=b.Id.substr(0,b.Id.lastIndexOf("_")+1)+b.PlaceHolder;p.InitPlaceHolderManager(o);n=p.ISGetObject(o)}}}if(n!=null&&n.EnableMergeBar==true){b.OriginalWindow=window;b.XmlDt=ISXml.GetElementById(b.Id+IS.XmlSuffix);var g=IS.CheckXmlCompression(b.XmlDt);if(g){b.XmlDt=g}b=n.AddMergedBar(b,WebToolBarMergingEngine._GetBarMergedElements(b),WebToolBarMergingEngine._GetBarMergedStyles(b),window);b._prntPHM=n;if(!IS.safari&&!IS.opera){Listener.Add(window,"onbeforeunload",WebToolBarEngine._OnUnLoadPage,b)}}}catch(j){}}else{var d;var m=p.ISGetObject(b.MergeToolBarParentID);if(m==null){m=p.ISGetObject(b.MergeToolBarParentID);if(m==null){p.InitWebToolBar(b.MergeToolBarParentID);m=p.ISGetObject(b.MergeToolBarParentID)}}if(m){if(m.PlaceHolderManager.EnableMergeBar==false){return}for(var k=0;k<b.Commands.length;k++){d=b.Commands[k];d._OriginalDockingArea=b.DockingArea}var f=b.Commands;m._AddMergedCommands(f,window,b);var a=new Array();for(var k=0;k<f.length;k++){if(f[k]._UIState=="AddedMerged"){a[a.length]=f[k]}}m.UpdateUI(true);for(var k=0;k<f.length;k++){f[k]._UIState="Added"}for(var k=0;k<f.length;k++){f[k]._UIState=""}if(!IS.safari&&!IS.opera){Listener.Add(window,"onbeforeunload",WebToolBarEngine._OnUnLoadPage,b)}b._ParentBarMerging=m}}}b.Initialized=true},_GetBarMergedElements:function(a){var b=new Array();b[0]=a.FrameObj;b[1]=document.getElementById(a.Id+IS.XmlSuffix);b[2]=document.getElementById(a.Id+IS.HiddenDataSuffix);b[3]=document.getElementById(a.Id+BarControlEngine.BarOptionWindowSuffix);WebToolBarMergingEngine._GetContextMenuItemTemplate(a,b);if(IS.safari){for(var c=0;c<b.length;c++){if(b[c]!=null){b[c].removeNode(true)}}}return b},_GetContextMenuItemTemplate:function(a,b){var e,f;for(var c=0;c<a.Commands.length;c++){e=a.Commands[c];if(e!=null&&e.Items!=null){for(var d=0;d<e.Items.length;d++){f=e.Items[d];if(f.Type=="Template"){b[b.length]=document.getElementById("mi_View"+f.Name)}}}}},_GetBarMergedStyles:function(b){var f=new Array();if(b.IntegratedTo=="None"){var a=ISXml.GetElementById(b.Id+IS.XmlSuffix);var c=IS.CheckXmlCompression(a);if(c){a=c}var d=a.documentElement.getAttribute("HeaderCaptionStyle");f[0]=new Array(d,IS.GetCssText("",d));d=a.documentElement.getAttribute("CommandDisabledStyle");f[1]=new Array(d,IS.GetCssText("",d));d=a.documentElement.getAttribute("SeparatorStyle");f[2]=new Array(d,IS.GetCssText("",d));d=a.documentElement.getAttribute("HandleStyle");f[3]=new Array(d,IS.GetCssText("",d));d=a.documentElement.getAttribute("BodyStyle");f[4]=new Array(d,IS.GetCssText("",d));d=a.documentElement.getAttribute("OptionStyle");f[5]=new Array(d,IS.GetCssText("",d));f[6]=new Array(b.CommandDisableFontStyle,IS.GetCssText("",b.CommandDisableFontStyle));var e=a.documentElement.selectSingleNode("//HeaderButtonStyle");d=e.getAttribute("Normal");f[7]=new Array(d,IS.GetCssText("",d));d=e.getAttribute("Over");f[8]=new Array(d,IS.GetCssText("",d));d=e.getAttribute("Active");f[9]=new Array(d,IS.GetCssText("",d));f[10]=new Array(b.CommandStyle.Normal,IS.GetCssText("",b.CommandStyle.Normal));f[11]=new Array(b.CommandStyle.Over,IS.GetCssText("",b.CommandStyle.Over));f[12]=new Array(b.CommandStyle.Active,IS.GetCssText("",b.CommandStyle.Active));f[13]=new Array(b.CommandFontStyle.Normal,IS.GetCssText("",b.CommandFontStyle.Normal));f[14]=new Array(b.CommandFontStyle.Over,IS.GetCssText("",b.CommandFontStyle.Over));f[15]=new Array(b.CommandFontStyle.Active,IS.GetCssText("",b.CommandFontStyle.Active))}return f},_AddMergedCommands:function(n,b,k,j){var l=n.PlaceHolderManager;var c=l.GetCustomizeWindow();var f=false;if(c){c.UnRegisterCommands(n)}n.UpdateUI(true);if(b!=null){var h=n.XmlDt.selectSingleNode("//CommandStyle");var a,m,e;for(var d=0;d<b.length;d++){a=b[d];var g=a.Get("MergeCommandID");if(n.Commands.GetNamedItem(a.Name)!=null){Listener.Unload(a._HtmlObj);continue}if((g==""||g==null)&&a._Bar.MergeCommandID!=""){g=a._Bar.MergeCommandID;a.MergeCommandID=g}if(g!=null&&g!=""){m=n.Commands.GetNamedItem(g);if(m&&m.Type=="Container"){f=true;a._OriginalBar=a._Bar;a._Bar=n;a._MergeCommand=true;a._OriginalMergeToolBarWindow=k;a._Collection=n.Commands;n.Commands.InsertAt(a,WebToolBarMergingEngine._GetLastMergeIndex(n.Commands,g));a._UIState="AddedMerged";a._PrevBarId=a._OriBarId=n.Id;a.CommandStyle=DynamicStyleEngine.Assign(h,a._HtmlObj);a.CommandDisabledStyle=n.CommandDisabledStyle;a.CommandFontStyle=n.CommandFontStyle;a.CommandDisableFontStyle=n.CommandDisableFontStyle}}}n._UIState="Added";if(f){n._IsAddedWithMergedCommands=true;if(n._ChildBars==null){n._ChildBars=new Array()}n._ChildBars[n._ChildBars.length]=j}}},_ClearMergedCommands:function(d){var a;for(var b=0;b<d.Commands.length;b++){a=d.Commands[b];var c=a.MergeCommandID;if((c==""||c==null)&&a._Bar.MergeCommandID!=""){c=a._Bar.MergeCommandID}if(a._OriginalBar!=null&&(c!=null&&c!="")&&c==a._OriginalBar.MergeCommandID){a._UIState="DelMerged"}}d._UIState="Del"},_ClearMergedCommandsByChildBar:function(e,a){var b;for(var c=0;c<e.Commands.length;c++){b=e.Commands[c];var d=b.MergeCommandID;if((d==""||d==null)&&b._Bar.MergeCommandID!=""){d=b._Bar.MergeCommandID}if(b._OriginalBar==a&&(d!=null&&d!="")&&d==b._OriginalBar.MergeCommandID){b._UIState="DelMerged"}}e._UIState="Del"},_GetLastMergeIndex:function(b,e){var c=-1;var a;for(var d=0;d<b.length;d++){a=b[d];if(a.Get("MergeCommandID")==e){c=a.Index+1}}if(c==-1){a=b.GetNamedItem(e);if(a!=null){c=a.Index+1}}if(c==-1){c=command.length-1}return c},_GetPreviousVisibleCommand:function(a){var c=null;if(a.Index>0){for(var b=a.Index-1;b>-1;b--){var d=a._Collection[b];if(d.Visible){c=d;break}}}return c},_AddMergedCommand:function(h,b){var e=h.GetOrientation();var i,g,a;var f=b.Index>0?WebToolBarMergingEngine._GetPreviousVisibleCommand(b):null;var c;if(IS.safari){b._HtmlObj.removeNode(true)}if(e=="Horizontal"){c=f!=null?f._HtmlObj.cellIndex:0;i=h._HtmlObjH_tbl;g=h._HtmlObjH_tbl.rows[0];a=g.insertCell(c+1);a.style.cssText="width:2px";a.innerHTML="<div style='overflow:hidden;width:2px'></div>";a.insertAdjacentElement("afterEnd",b._HtmlObj)}else{c=f!=null?f._HtmlObj.parentNode.rowIndex:0;i=h._HtmlObjV_tbl;g=i.insertRow(c);a=g.insertCell(-1);a.style.cssText="height:2px";a.innerHTML="<div style='overflow:hidden;height:2px'></div>";g=i.insertRow(c+1);g.appendChild(b._HtmlObj)}var d=h.XmlDt.selectSingleNode("//CommandStyle");if(b.Type!="Container"){BarControlEngine._AssignCommandStyle(b,h,d);h._AssignCommandListener(b);if(b.Type=="Separator"){b._HtmlObj.className=h.SeparatorStyle}else{if(b.Get("IsEnabled")==true){if(b.Get("Type")=="ToggleButton"){b._HtmlObj.className=b.Pushed==false?h.CommandStyle.Normal:h.CommandStyle.Active}else{if(b.Type=="DropDownButton"||b.Type=="SplitButton"){WebToolBarEngine._CreateCommandContextMenu(b);var i=b._HtmlObj.children[0];i.className=b.CommandFontStyle.Normal;WebToolBarEngine._SetSplitButtonEffect(b,"Normal")}b._HtmlObj.className=h.CommandStyle.Normal;b.CommandStyle.SetToNormal()}}else{if(b.Type=="DropDownButton"||b.Type=="SplitButton"){WebToolBarEngine._CreateCommandContextMenu(b);var i=b._HtmlObj.children[0];i.className=h.CommandDisableFontStyle;WebToolBarEngine._SetSplitButtonEffect(b,"Normal")}b._HtmlObj.className=h.CommandDisabledStyle;b.SetIsEnabled(false)}}}},_DelMergedCommand:function(g,b){var h,f,a,d,c;b.Set("IsEnabled",true);b.Set("Visible",true);Listener.Unload(b._HtmlObj);if(g.PlaceHolderManager!=null){var i=PlaceHolderManagerEngine.GetCustomizeWindow();if(i!=null){i.UnRegisterCommand(b)}}if(b._ContextMenu!=null){b._ContextMenu.OnRootMenuClosed=null}if(g.GetOrientation()=="Horizontal"){c=b._HtmlObj;if(!c||!c.offsetParent){return}var e=c.offsetParent;if(e.tagName.toLowerCase()!="table"){e=c.parentElement.parentElement}f=e.rows[0];d=c.cellIndex;if(d>-1){f.deleteCell(c.previousSibling.cellIndex);f.deleteCell(c.cellIndex)}}else{h=b._HtmlObj.offsetParent;d=b._HtmlObj.parentNode.rowIndex;if(d>-1){h.deleteRow(d);h.deleteRow(d-1)}}b.CommandStyle.Object=null;b._HtmlObj=null;b._OriginalBar=null;b._OriginalMergeToolBarWindow=null;g.Commands.Remove(b,false)}};