function ToggleGroup(){this._Type="ToggleGroup";ISObject.call(this);this.Name="";this.ToggleGroupType="SelectNone"}function BarSectionStyle(){this._Type="BarSectionStyle";ISObject.call(this);this.BackColor="DarkGray";this.BackColor2="";this.GradientType="Horizontal";this.BackgroundImageHorizontal="";this.BackgroundImageVertical=""}function CommandClientSideEvents(){this._Type="CommandClientSideEvents";ISObject.call(this);this.OnClick="";this.OnDblClick="";this.OnMouseMove="";this.OnMouseOver="";this.OnMouseUp="";this.OnMouseDown="";this.OnMouseOut=""}function ShowOptionWindow(b){var a=ISGetObject(b);if(a){if(a.GetType()=="WebToolBar"){WebToolBarEngine.ShowOptionWindow(b)}else{WebMenuBarEngine.ShowOptionWindow(b)}}}function BarControl(){this._HtmlObjV=null;this._HtmlObjH=null;this._HtmlObjV_tbl=null;this._HtmlObjH_tbl=null;this.AccessKey="";this.Caption="";this.CommandMargin="2px";this.CommandPadding="2px";this.Display=true;this.PlaceHolderManager=null;this.DesktopManager=null;this.Style1="";this.OldDockingArea="Top";this.OldDockingRow=0;this.OldIsFloat="No";this.Visible=true;this.Enabled=true;this.CommandClientSideEvents=new CommandClientSideEvents();this.Name="";this.Index=-1;this._IsHorizontal=true;this.IsFloat="Default";this._IsReCalculateOptionMenu=false;this._OptionContextMenu=null;this._IsMenuStyleCreated=false;this._PrevDockingArea="";this._PrevDockingRow="";this._PrevDragTargetId="";this.Unloaded=false;this.AddRemoveOptionMenuViewMode="IconView";this.SizeMode="Automatic";this.IsRuntimeBar=false;this.AllowMove="Default";this.HandleVisible="Default";this.AllowCustomize="Default";this.AllowDockBottom="Default";this.AllowDockLeft="Default";this.AllowDockRight="Default";this.AllowDockTop="Default";this.AllowExpandCollapse="Default";this.AllowFloat="Default";this.BarStyle="Default";this.DockingArea="NotSet";this.NewDockingArea="NotSet";this.DockingOffset=0;this.DockingRow=0;this.NewDockingRow=0;this.FillDockingRow="Default";this.PlaceHolder="";this.Caption="";this.HandleAndCustomizeBackColor="DarkGray";this.GreyImageWhenDisabled="Default";this.Opacity=1;this.HandleStyle=new BarSectionStyle();this.BodyStyle=new BarSectionStyle();this.OptionStyle=new BarSectionStyle();this.CommandStyle=new DynamicStyle();this.CommandFontStyle=new DynamicStyle();this.SeparatorStyle="";this.CommandDisabledStyle="";this.HeaderCaptionStyle="";this._IsCreateDefaultMenuStyles=false;this.IntegratedTo="PlaceHolderManager";this.ImageSize=new UnitSize();this.ImageSize.Width=this.ImageSize.Height="16px";this.ShowDelay=500;this.MenuStyleSettings=null;if(typeof(WebMenuStyles)!="undefined"){var a=new WebMenuStyles();a.ItemStyle=new DynamicStyle();a.DisabledItemStyle=new DynamicStyle();a.CheckedItemStyle=new DynamicStyle();this.MenuStyleSettings=a}this.AutoPostBack="No";this.CommandSize="50px";this.DisplayToolTip="Yes";this.ToolTip="";this.TextAlign="Right";this.DisplayMode="Text";this.IsFloat1="No";this.IsDynamicCreated=false;this._PlaceHolderMaxDimensionWidth=0;this._PlaceHolderMaxDimensionHeight=0;this._OffsetParent=null;this._ChildIdx=-1;this._Width=0;this._Height=0;this._GetItems=function(){return null};this.UnregisterAccessKeys=function(){var c=this._GetItems();for(var d=0;d<c.length;d++){var b=c[d];if(b.AccessKey!=""&&b.IsEnabled&&b._HtmlObj){b._HtmlObj.accessKey=""}}};this.RegisterAccessKeys=function(){var c=this._GetItems();for(var d=0;d<c.length;d++){var b=c[d];if(b.AccessKey!=""&&b.IsEnabled&&b._HtmlObj){b._HtmlObj.accessKey=b.AccessKey}}};this.SetCaption=function(b){BarControlEngine._SetCaption(this,b)};this.SetDisplayToolTip=function(b){BarControlEngine._SetDisplayToolTip(this,b)};this.SetDisplayAccessKeyOnToolTip=function(b){BarControlEngine._SetDisplayAccessKeyOnToolTip(this,b)};this.GetOrientation=function(){return BarControlEngine._GetOrientation(this)};this.SetAllowMove=function(b){BarControlEngine._SetAllowMove(this,b)};this.SetToolTip=function(b){BarControlEngine._SetToolTip(this,b)};this.SetIsFloat=function(b){BarControlEngine._SetIsFloat(this,b)};this.SetDisplay=function(b){BarControlEngine._SetDisplay(this,b)};this._Dock=function(b){return BarControlEngine._Dock(this,b)};this._UnDock=function(b){return BarControlEngine._UnDock(this,b)};this._CheckingDockingArea=function(b){return BarControlEngine._CheckingDockingArea(this,b)};this.CommitDisplayState=function(){return BarControlEngine._CommitDisplayState(this)};this.RoolBackDisplayState=function(){return BarControlEngine._RoolBackDisplayState(this)};this.SaveDisplayState=function(){BarControlEngine._SaveDisplayState(this)};this.InitDisplayState=function(){BarControlEngine._InitDisplayState(this)};this.AdjustDisplayToDimension=function(b){return BarControlEngine._AdjustDisplayToDimension(this,b)};this.GetCachedMenuStyleString=function(b){return BarControlEngine._GetCachedMenuStyleString(this,b)};this.CheckCommandsVisibility=function(){BarControlEngine._CheckCommandsVisibility(this)};this._AdjustDisplayToVerticalDimension=function(b){return BarControlEngine._AdjustDisplayToVerticalDimension(this,b)};this._AdjustDisplayToHorizontalDimension=function(b){return BarControlEngine._AdjustDisplayToHorizontalDimension(this,b)};this.GetMinDisplayDimension=function(){return BarControlEngine._GetMinDisplayDimension(this)};this.GetMaxDisplayDimension=function(){return BarControlEngine._GetMaxDisplayDimension(this)};this._AdjustDisplayToLastDimension=function(){BarControlEngine._AdjustDisplayToLastDimension(this)};this.UpdateUI=function(b){BarControlEngine._UpdateUI(this,b)};this._SetToFloatDisplay=function(){BarControlEngine._SetToFloatDisplay(this)};this._SetToStaticDisplay=function(){BarControlEngine._SetToStaticDisplay(this)};this._SetToHorisontalDisplay=function(){BarControlEngine._SetToHorizontalDisplay(this)};this._SetToVerticalDisplay=function(){BarControlEngine._SetToVerticalDisplay(this)};this.ResetUsageData=function(){BarControlEngine._ResetUsageData(this)};this._OnCommandDragStart=function(b){};this._OnCommandDrag=function(b){};this._OnCommandDragEnd=function(b,d,c){BarControlEngine._OnCommandDragEnd(this,b,d,c)};this._OnCommandPointerDragStart=function(d,c,b){BarControlEngine._OnCommandPointerDragStart(this,d,c,b)};this._OnCommandPointerDragEnd=function(b){BarControlEngine._OnCommandPointerDragEnd(this,b)};this._OnCommonCommandDragEnd=function(b){BarControlEngine._OnCommonCommandDragEnd(this,b)};this.__getter=function(b){return BarControlEngine.__getter(this,b)};this.__setter=function(c,d,b){return BarControlEngine.__setter(this,c,d,b)};this.SetPosition=function(b,c){BarControlEngine.SetPosition(this,b,c)}}var BarControlEngine={BarHandleSuffix:"_tbh",BarInnerContainerSuffix:"_tbic",BarOptionSuffix:"_tbo",BarOptionWindowSuffix:"_tbow",BarItemSuffix:"_tbitm",SetPosition:function(a,c,d){var b=a.FrameObj;if(b.style.position=="absolute"){if(c!=null&&c!=""){if(c.toString().length!=parseFloat(c).toString().length){c=c+"px"}b.style.left=c}if(d!=null&&d!=""){if(d.toString().length!=parseFloat(d).toString().length){d=d+"px"}b.style.top=d}}},_SetCaption:function(a,b){a.Caption=b;var c=(!IS.IsHTML5DocType())?document.getElementById(a.Id+IS.FrameHeaderSuffix).offsetParent:document.getElementById(a.Id+IS.FrameHeaderSuffix).parentElement.parentElement;if(c!=null){c.rows[0].cells[0].innerText=b}},_SetDisplayToolTip:function(a,e){a._UIState="SetDisplayToolTip";a.DisplayToolTip=e;var d=a._GetItems();var b;for(var c=0;c<d.length;c++){b=d[c];b.SetDisplayToolTip(e)}a.UpdateUI(false)},_SetDisplayAccessKeyOnToolTip:function(a,e){a._UIState="SetDisplayAccessKeyOnToolTip";a.DisplayAccessKeyOnToolTip=e;var d=a._GetItems();var b;for(var c=0;c<d.length;c++){b=d[c];b.SetDisplayAccessKeyOnToolTip(e)}a.UpdateUI(false)},_GetOrientation:function(a){if(a.Get("IsFloat")!="Yes"&&(a.DockingArea=="Left"||a.DockingArea=="Right")){return"Vertical"}else{return"Horizontal"}},_SetAllowMove:function(a,b){a.AllowMove=b;a.FrameObj.IsDragabble=a.Get("AllowMove")=="Yes"},_SetToolTip:function(a,d){a.ToolTip=d;var c="";if(a.Get("DisplayToolTip")=="Yes"){c=a.ToolTip;if(a.Get("DisplayAccessKeyOnToolTip")=="Yes"){if(a.AccessKey!=null&&a.AccessKey!=""){c+=" (ALT+"+a.AccessKey+")"}}}var b=document.getElementById(a.Id+IS.InnerFrameSuffix);b.title=c},_SetIsFloat:function(a,c){var b=c;if(b=="Default"){if(a.PlaceHolderManager!=null){b=a.PlaceHolderManager.Get("IsFloat")}else{b="No"}}if(b=="Yes"){a._UnDock(c)}else{a._Dock(c)}},_SetDisplay:function(a,b){a.Display=b;if(b==true){a.Show()}else{a.Hide()}},_Dock:function(a){return a.PlaceHolderManager._Dock(a)},_CheckingDockingArea:function(a){return a.PlaceHolderManager._CheckingDockingArea(a)},_UnDock:function(a){return a.PlaceHolderManager._UnDock(a)},_CommitDisplayState:function(a){var e=a._GetItems();var b,c;for(var d=0;d<e.length;d++){b=e[d];b.Visible=b._Visible}},_RoolBackDisplayState:function(a){var e=a._GetItems();var b,c;for(var d=0;d<e.length;d++){b=e[d];b.Visible=b._PrevVisible}},_SaveDisplayState:function(a){var e=a._GetItems();var b,c;for(var d=0;d<e.length;d++){b=e[d];b._PrevVisible=b.Visible}},_InitDisplayState:function(a){var e=a._GetItems();var b,c;for(var d=0;d<e.length;d++){b=e[d];b._Visible=b.Visible}},_AdjustDisplayToDimension:function(a,b){a.SaveDisplayState();var c=true;if(a.DockingArea=="Left"||a.DockingArea=="Right"){c=a._AdjustDisplayToVerticalDimension(b)}else{c=a._AdjustDisplayToHorizontalDimension(b)}if(c){a.CommitDisplayState()}else{a.RoolBackDisplayState()}return c},_GetCachedMenuStyleString:function(a,b){if(!a._CachedMenuStyleString){if(a.IntegratedTo=="PlaceHolderManager"){a._CachedMenuStyleString=a.PlaceHolderManager.GetCachedMenuStyleString(b)}else{a._CachedMenuStyleString=WebMenuEngine.GetStyleString(b,true)}}return a._CachedMenuStyleString},_CheckCommandsVisibility:function(a){if(a._IsHorizontal){BarControlEngine._CheckHorizontalCommandsVisibility(a)}else{BarControlEngine._CheckVerticalCommandsVisibility(a)}},_CheckHorizontalCommandsVisibility:function(h){var k=h._HtmlObjH_tbl;if(k==null){return}var g=k.parentNode.offsetWidth;var b=k.rows[0].cells;var a;var c,d;d=h._GetItems();for(var e=0;e<b.length;e++){a=b[e];if(a.getAttribute("type")!="m"&&a.id!=null&&a.id!=""){c=null;for(var f=0;f<d.length;f++){if(d[f]._HtmlObj.id==a.id){c=d[f];break}}if(c!=null){c._UIVisible=(a.offsetLeft+a.offsetWidth)<g}}}},_CheckVerticalCommandsVisibility:function(h){var k=h._HtmlObjV_tbl;var f=k.parentNode.offsetHeight;var g=k.rows;var a;var b,c;c=h._GetItems();for(var d=0;d<g.length;d++){a=g[d].cells[0];if(a.getAttribute("type")!="m"&&a.id!=null&&a.id!=""){b=null;for(var e=0;e<c.length;e++){if(c[e]._HtmlObj.id==a.id){b=c[e];break}}if(b!=null){b._UIVisible=(a.offsetTop+a.offsetHeight)<f}}}},_AdjustDisplayToVerticalDimension:function(l,c){c=c-10;var f=l.FrameObj.offsetHeight;if(f<c){return true}if(l.Get("AllowExpandCollapse")=="No"){return false}var k=22;if(k>c){return false}f=22;var m=22;var j=l._GetItems();var a,b,h;for(var g=0;g<j.length;g++){a=j[g];if(a.Visible==false){continue}if(a.Type=="Container"){continue}else{m=f+a._HtmlObj.offsetHeight+parseFloat(l.CommandMargin);if(m>=c){a._Visible=false;a._HtmlObj.style.display="none"}}}for(var g=0;g<j.length;g++){a=j[g];if(a.Visible==false){continue}if(a.Type=="Container"){continue}else{a._HtmlObj.style.display="";m=f+a._HtmlObj.offsetHeight+parseFloat(l.CommandMargin);if(m<c){f=m;a._Visible=true}else{a._Visible=false;a._HtmlObj.style.display="none"}}}l.FrameObj.style.height=c+"px";var e=document.getElementById(l.Id+IS.FrameHeaderSuffix);if(e!=null){l.FrameObj.style.height=c+"px"}return true},_AdjustDisplayToHorizontalDimension:function(k,c){c=c-10;var m=k.FrameObj.offsetWidth;if(m<c){return true}if(k.Get("AllowExpandCollapse")=="No"){return false}var j=22;if(j>c){return false}m=22;var l=22;var h=k._GetItems();var a,b,g;for(var f=0;f<h.length;f++){a=h[f];if(a.Visible==false){continue}if(a.Type=="Container"){continue}else{l=m+a._HtmlObj.offsetWidth+parseFloat(k.CommandMargin);if(l>=c){a._Visible=false;a._HtmlObj.style.display="none"}}}for(var f=0;f<h.length;f++){a=h[f];if(a.Visible==false){continue}if(a.Type=="Container"){continue}else{a._HtmlObj.style.display="";l=m+a._HtmlObj.offsetWidth+parseFloat(k.CommandMargin);if(l<c){m=l;a._Visible=true}else{a._Visible=false;a._HtmlObj.style.display="none"}}}k.FrameObj.style.width=c+"px";var e=document.getElementById(k.Id+IS.FrameHeaderSuffix);if(e!=null){k.FrameObj.style.width=c+"px"}return true},_GetMinDisplayDimension:function(f){if(f.Display){var b=0;if(f.Get("AllowCustomize")=="Yes"||f.Get("AllowExpandCollapse")=="Yes"){b+=14}if(f.Get("HandleVisible")=="Yes"){b+=8}var e=f._GetItems();var a;for(var c=0;c<e.length;c++){a=e[c];if(a.Visible){if(a.Type!="Container"){b+=parseFloat(f.CommandMargin)+(f.GetOrientation()=="Horizontal"?a._HtmlObj.offsetWidth:a._HtmlObj.offsetHeight);break}}}return b}else{return 0}},_GetMaxDisplayDimension:function(f){if(f.Display){var b=0;if(f.Get("AllowCustomize")=="Yes"||f.Get("AllowExpandCollapse")=="Yes"){b+=14}if(f.Get("HandleVisible")=="Yes"){b+=8}var e=f._GetItems();var a;for(var c=0;c<e.length;c++){a=e[c];if(a.Visible){if(a.Type!="Container"){b+=parseFloat(f.CommandMargin)+(f.GetOrientation()=="Horizontal"?a._HtmlObj.offsetWidth:a._HtmlObj.offsetHeight)}}}return b}else{return 0}},_AdjustDisplayToLastDimension:function(d){var c=d._GetItems();var a;var e=document.getElementById(d.Id+BarControlEngine.BarInnerContainerSuffix);for(var b=0;b<c.length;b++){a=c[b];if(a._Visible==false&&a._PrevVisible==true){a.Visible=a._Visible=true;a._HtmlObj.style.display="";e.appendChild(a._HtmlObj)}}},_UpdateUI:function(e,g){var d;var a;if(e._UIState!=""){switch(e._UIState){case"ResetUsageData":BarControlBarEngine._UpdateUIResetUsageData(e);return;break;case"SetDisplayToolTip":var f="";if(e.Get("DisplayToolTip")=="Yes"){f=e.ToolTip;if(e.Get("DisplayAccessKeyOnToolTip")=="Yes"){if(e.AccessKey!=null&&e.AccessKey!=""){f+=" (ALT+"+e.AccessKey+")"}}}var c=document.getElementById(e.Id+IS.InnerFrameSuffix);c.title=f;break;case"SetDisplayAccessKeyOnToolTip":if(e.Get("DisplayToolTip")=="Yes"){var f=e.ToolTip;if(e.Get("DisplayAccessKeyOnToolTip")=="Yes"){if(e.AccessKey!=null&&e.AccessKey!=""){f+=" (ALT+"+e.AccessKey+")"}}var c=document.getElementById(e.Id+IS.InnerFrameSuffix);c.title=f}break}d=e._GetItems();for(var b=0;b<d.length;b++){a=d[b];if(a._UIState!=""){if(a.Type=="Container"&&(a._UIState!="AddedMerged"&&a._UIState!="DelMerged")){continue}else{switch(a._UIState){case"Show":a.SetVisible(true);break;case"Hide":a.SetVisible(false);break;case"Added":break;case"AddedMerged":WebToolBarMergingEngine._AddMergedCommand(e,a);break;case"Del":break;case"DelMerged":WebToolBarMergingEngine._DelMergedCommand(e,a);b--;break;case"SetDisplayToolTip":var f="";if(a.Get("DisplayToolTip")=="Yes"){f=a.ToolTip;if(a.Get("DisplayAccessKeyOnToolTip")=="Yes"){if(a.AccessKey!=null&&a.AccessKey!=""){f+=" (ALT+"+a.AccessKey+")"}}}a._HtmlObj.title=f;break;case"SetDisplayAccessKeyOnToolTip":if(a.Get("DisplayToolTip")=="Yes"){var f=a.ToolTip;if(a.Get("DisplayAccessKeyOnToolTip")=="Yes"){if(a.AccessKey!=null&&a.AccessKey!=""){f+=" (ALT+"+a.AccessKey+")"}}a._HtmlObj.title=f}break;case"Update":a.UpdateUI();break}}a._UIState=""}}BarControlEngine._UpdateBarDimension(e,g);e._UIState=""}d=e._GetItems();for(var b=0;b<d.length;b++){a=d[b];if(a._Text!=a.Text||a._Image!=a.Image){e._UpdateCommandTextAndImage(a)}}},_UpdateUIResetUsageData:function(e){var c=document.getElementById(e.Id+BarControlEngine.BarInnerContainerSuffix);if(c==null){return}for(var b=c.children.length-1;b>-1;b--){c.removeChild(c.children[b])}var d=e._GetItems();var a;for(var b=0;b<d.length;b++){a=d[b];c.appendChild(a._HtmlObj);a.UpdateUI()}},_SetToFloatDisplay:function(d){if(d.Get("IsFloat")=="Yes"){return}d._PrevDockingArea=d.Get("DockingArea");d._PrevDockingRow=d.Get("DockingRow");d._PrevDragTargetId=d.FrameObj.DragTargetId;if(d.GetOrientation()=="Vertical"){BarControlEngine._SetToHorizontalDisplay(d)}d.IsFloat="Yes";if(d.Get("HandleVisible")=="Yes"){var a=document.getElementById(d.Id+BarControlEngine.BarHandleSuffix+"_Horizontal");if(a){a.style.display="none"}}var b=document.getElementById(d.Id+BarControlEngine.BarOptionSuffix+"_Horizontal");if(b){b.style.display="none"}var c=d.FrameObj.ownerDocument.getElementById(d.Id+IS.FrameSuffix);if(d.UseCssFramework){c.setAttribute("is-floating","true")}else{c.style.border="2px solid"}c=d.FrameObj.ownerDocument.getElementById(d.Id+IS.FrameHeaderSuffix);c.style.display="";d._IsHorizontal=true},_SetToStaticDisplay:function(h){if(h.Get("IsFloat")=="No"){return}h.IsFloat="No";var g=h.FrameObj;if(g.DragTargetId.indexOf(PlaceHolderManagerEngine.PlaceHolderManagerLeftDockingAreaSuffix)>-1||g.DragTargetId.indexOf(PlaceHolderManagerEngine.PlaceHolderManagerRightDockingAreaSuffix)>-1){BarControlEngine._SetToVerticalDisplay(h)}else{BarControlEngine._SetToHorizontalDisplay(h);if(h.Get("HandleVisible")=="Yes"){var a=document.getElementById(h.Id+BarControlEngine.BarHandleSuffix+"_Horizontal");if(a){a.style.display=""}}var b=document.getElementById(h.Id+BarControlEngine.BarOptionSuffix+"_Horizontal");if(b){b.style.display=""}}e=document.getElementById(h.Id+IS.FrameHeaderSuffix);e.style.display="none";var e=document.getElementById(h.Id+IS.FrameSuffix);if(h.UseCssFramework){e.removeAttribute("is-floating")}else{e.style.border="0px"}if(h.Get("FillDockingRow")=="Yes"){var d=0;var c=0}},_SetToHorizontalDisplay:function(m){if(m._IsHorizontal){return}var h,g;if(m.Get("FillDockingRow")=="No"||m.Get("IsFloat")=="Yes"){g=m._PlaceHolderMaxDimensionWidth;h=m._PlaceHolderMaxDimensionHeight;m.FrameObj.style.marginTop="0px";m.FrameObj.style.marginLeft=m.DockingOffset}if(IS.ie){m.FrameObj.style.styleFloat="left"}else{m.FrameObj.style.cssFloat="left"}m._HtmlObjV_tbl.style.display=m._HtmlObjV.style.display="none";m._HtmlObjH_tbl.style.display=m._HtmlObjH.style.display="";BarControlEngine._SwapDimension(m.FrameObj,h,g);var l=m._HtmlObjV_tbl.rows;var k=m._HtmlObjH_tbl.rows[0];var f=k.cells.length;try{for(var b=0;b<f;b++){k.deleteCell()}}catch(a){}var c=0;var n;var j;var d=m._GetItems();f=d.length;for(var b=0;b<f;b++){j=k.insertCell(c);j.setAttribute("type","m");j.style.cssText="width:"+(parseInt(m.CommandMargin)+"px");j.innerHTML="<div style='overflow:hidden;width:"+(parseInt(m.CommandMargin)+"px")+"'></div>";j.insertAdjacentElement("afterEnd",d[b]._HtmlObj);m._SetItemToHorizontalDisplay(d[b]);c+=2}j=k.insertCell(k.cells.length);j.style.cssText="width:100%;height:100%";if(m.UseCssFramework){m.FrameObj.setAttribute("orientation","horizontal")}m._IsHorizontal=true},_SetToVerticalDisplay:function(j){if(!j._IsHorizontal){return}var h="";var f,e;if(j.Get("FillDockingRow")=="No"){f=j._PlaceHolderMaxDimensionWidth;e=j._PlaceHolderMaxDimensionHeight;j.FrameObj.style.marginLeft="0px";j.FrameObj.style.marginTop=j.DockingOffset}BarControlEngine._SwapDimension(j.FrameObj,f,e);if(IS.ie){j.FrameObj.style.styleFloat=""}else{j.FrameObj.style.cssFloat=""}j._HtmlObjV_tbl.style.display=j._HtmlObjV.style.display="";j._HtmlObjH_tbl.style.display=j._HtmlObjH.style.display="none";var k=j._HtmlObjV_tbl;var d=k.rows.length;for(var b=0;b<d;b++){k.deleteRow(0)}var c=j._GetItems();d=c.length;var g,a;for(var b=0;b<d;b++){g=k.insertRow(-1);a=g.insertCell(-1);a.setAttribute("type","m");a.style.cssText="height:"+(parseInt(j.CommandMargin)+"px");a.innerHTML="<div style='overflow:hidden;height:"+(parseInt(j.CommandMargin)+"px")+"'></div>";g=k.insertRow(-1);g.appendChild(c[b]._HtmlObj);j._SetItemToVerticalDisplay(c[b])}g=k.insertRow(-1);a=g.insertCell(-1);a.style.cssText="width:100%;height:100%";if(j.UseCssFramework){j.FrameObj.setAttribute("orientation","vertical")}j._IsHorizontal=false},_SwapDimension:function(a,d,b){if(a.style.width==""){a.style.width=a.offsetWidth}if(a.style.height==""){a.style.height=a.offsetHeight}var f=a.style.width;if(d){var e=(d.toString().indexOf("%")!=-1||d.toString().indexOf("px")!=-1)?d:d.toString()+"px"}else{e=d}if(b){var c=(b.toString().indexOf("%")!=-1||b.toString().indexOf("px")!=-1)?b:b.toString()+"px"}else{c=b}if(e==null||e==""){a.style.width=a.style.height}else{a.style.width=parseFloat(a.style.height)>parseFloat(d)?e:a.style.height}if(c==null||c==""){a.style.height=f}else{a.style.height=parseFloat(f)>parseFloat(c)?c:f}},_SwapDimensionAndPosition:function(a){if(a.style.width==""){a.style.width=a.offsetWidth}if(a.style.height==""){a.style.height=a.offsetHeight}var c=a.style.width;a.style.width=a.style.height;a.style.height=c;var b=a.style.left;a.style.left=a.style.top;a.style.top=b},_SwapMargin:function(el){with(el.style){var ml=marginLeft;marginLeft=marginTop!=""?marginTop:"0px";marginTop=ml!=""?ml:"0px"}},_SwapDimensionAndPositionAndMargin:function(el){BarControlEngine._SwapDimensionAndPosition(el);with(el.style){var mTop=marginTop;marginTop=marginLeft;marginLeft=mTop}},_ResetUsageData:function(j){var h=j.XmlDt.selectSingleNode(j.GetType()=="WebToolBar"?"//Commands":"//Menus");var d,e,a;var f=new ISArray();var g=j.PlaceHolderManager;var c=j._GetItems();for(var b=0;b<h.childNodes.length;b++){d=h.childNodes[b];e=d.attributes.getNamedItem("Name").value;a=c.GetNamedItem(e);if(a==null){a=g.GetMovedCommand(j.Id,e)}if(a!=null){a.Reset();IS.SetProperties(a,d);a._Collection=f;a._UIState="Update";f.Add(a)}}if(j.GetType()=="WebToolBar"){j.Commands=f}else{j.Menus=f}j._UIState="ResetUsageData";j.UpdateUI()},_OnCommandDragEnd:function(l,i,g,c){var b;if(g!=null){if(c==i){return}if(i._Bar.PlaceHolder!=g.PlaceHolder){return}g._IsReCalculateOptionMenu=true;if(i._MoveSource=="CustomizeWindow"){b=l.GetType()=="WebToolBar"?new ToolCommand():new MenuCommand();b.CopyFrom(i);b.Clone(g);b._OriginalBarForCustomizeWindow=i._Bar}else{if(i._OriginalBarForCustomizeWindow==g){return}i._Bar._IsReCalculateOptionMenu=true;b=i;b._Collection.Remove(b)}var e=g.DockingArea=="Top"||g.DockingArea=="Bottom"?"h":"v";var f=b._Bar.DockingArea=="Top"||b._Bar.DockingArea=="Bottom"?"h":"v";var k=e!=f;b._HtmlObj.style.display="";if(i._MoveSource!="CustomizeWindow"){if(i._Bar._IsHorizontal){i._HtmlObj.parentNode.deleteCell(b._HtmlObj.cellIndex-1)}else{i._HtmlObj.parentNode.parentNode.deleteRow(b._HtmlObj.parentNode.rowIndex-1)}}if(c!=null){if(c._Bar._IsHorizontal){var j=c._HtmlObj.parentNode;j.cells[c._HtmlObj.cellIndex-1].insertAdjacentElement("beforeBegin",b._HtmlObj);var a=j.insertCell(b._HtmlObj.cellIndex);a.style.width=g.CommandMargin;a.innerHTML="<div style='overflow:hidden;width:"+g.CommandMargin+"'></div>"}else{var m=g._HtmlObjV_tbl;var j=m.insertRow(c._HtmlObj.parentNode.rowIndex-1);j.insertAdjacentElement("afterBegin",b._HtmlObj);j=m.insertRow(j.rowIndex);var a=j.insertCell(-1);a.style.height=g.CommandMargin;a.innerHTML="<div style='overflow:hidden;height:"+g.CommandMargin+"'></div>"}}else{if(g._IsHorizontal){var m=g._HtmlObjH_tbl;var j=m.rows[0];var a=j.insertCell(j.cells.length-2);a.style.width=g.CommandMargin;a.innerHTML="<div style='overflow:hidden;width:"+g.CommandMargin+"'></div>";a.insertAdjacentElement("afterEnd",b._HtmlObj)}else{var m=g._HtmlObjV_tbl;var j=m.insertRow(m.rows.length-2);var a=j.insertCell(-1);a.style.height=g.CommandMargin;a.innerHTML="<div style='overflow:hidden;width:"+g.CommandMargin+"'></div>";j=m.insertRow(j.rowIndex+1);j.insertAdjacentElement("afterBegin",b._HtmlObj)}}var d=c!=null?c._Collection.IndexOf(c):0;if(c!=null){c._Collection.InsertAt(b,d)}else{if(g.GetType()=="WebToolBar"){g.Commands.Add(b)}else{g.Menus.Add(b)}}if(g.IsFloat!="Yes"){if(e!=f){if(e=="v"){b._Bar._SetItemToVerticalDisplay(b)}else{b._Bar._SetItemToHorizontalDisplay(b)}}}b._UIState="";b._MoveSource=b._Move=false;b._PrevBarId=b._Bar.Id;b._Bar=g;b._Collection=c!=null?c._Collection:(g.GetType()=="WebToolBar"?g.Commands:g.Menus);var h=g.XmlDt.selectSingleNode("//CommandStyle");BarControlEngine._AssignCommandStyle(b,g,h);if(i._MoveSource=="CustomizeWindow"){b.SetVisible(true);b._Bar._AssignCommandListener(b);CommandDragEngine.RegisterCommand(b)}b._HtmlObj.className=g.CommandStyle.Normal;if(b.Get("IsEnabled")==false){b.SetIsEnabled(false)}BarControlEngine._UpdateBarDimension(g,true)}else{b=i;if(b._MoveSource=="Command"){if(CommandDragEngine.IsCommandDropIntoCustomizeWindow(b)){if(b._Bar.GetType()=="WebToolBar"){b._Bar.HideCommand(b)}else{b._Bar.HideMenu(b)}b._Bar.UpdateUI()}}}BarControlEngine._UpdateBarDimension(l,true);b._MoveSource="";b._Move=false},_AssignCommandStyle:function(a,c,b){a.CommandStyle=DynamicStyleEngine.Assign(b,a._HtmlObj);a.CommandDisabledStyle=c.CommandDisabledStyle;a.CommandFontStyle=c.CommandFontStyle;a.CommandDisableFontStyle=c.CommandDisableFontStyle},_UpdateBarDimension:function(a,b){},_OnCommandPointerDragStart:function(f,d,b,a){var g,e,c;if(d==b){return}if(a._Bar!=null){a._Bar._OnCommandPointerDragEnd(a)}if(f._IsHorizontal){a.style.width="2px";a.style.height="100%";g=f._HtmlObjH_tbl;e=g.rows[0];if(b!=null){c=e.insertCell(b._HtmlObj.cellIndex>0?b._HtmlObj.cellIndex-1:0)}else{if(BarControlEngine._IsInCommandsTableArea(f)==false){c=e.insertCell(e.cells.length-1)}}}else{a.style.height="2px";a.style.width="100%";g=f._HtmlObjV_tbl;if(b!=null){e=g.insertRow(b._HtmlObj.parentNode.rowIndex>0?b._HtmlObj.parentNode.rowIndex-1:0);c=e.insertCell(e.cells.length-1)}else{if(BarControlEngine._IsInCommandsTableArea(f)==false){e=g.insertRow(g.rows.length-1);c=e.insertCell(-1)}}}if(c!=null){if(a.style.display=="none"){a.style.display=""}c.insertAdjacentElement("afterBegin",a);a._Bar=f}},_OnCommandPointerDragEnd:function(d,a){if(d.FrameObj.contains(a)){var c=a.parentNode;if(a.style.display!="none"){a.style.display="none"}document.body.insertAdjacentElement("beforeEnd",a);var b;if(d._IsHorizontal){b=c.parentNode.deleteCell(c.cellIndex)}else{b=c.parentNode.parentNode.deleteRow(c.parentNode.rowIndex)}b=null;a._Bar=null;return true}else{return false}},_OnCommonCommandDragEnd:function(b,a){},_IsInCommandsTableArea:function(h){var d=h._GetItems();if(d.length<=0){return false}if(window.event!=null){var e;for(var c=d.length-1;c>-1;c--){if(d[c].Visible){e=d[c];break}}if(e==null){return true}if(h.GetOrientation()=="Horizontal"){var a=ISDrag.GetXPos(window.event);var f=ISPosLib.getLeft(e._HtmlObj)+ISPosLib.getWidth(e._HtmlObj);return a<=f}else{var b=ISDrag.GetYPos(window.event);var g=ISPosLib.getTop(e._HtmlObj)+ISPosLib.getHeight(e._HtmlObj);return b<=g}}},__getter:function(b,a){var c;switch(a){case"DockingArea":case"CommandSize":case"DisplayMode":case"DisplayToolTip":case"DisplayAccessKeyOnToolTip":case"ImageSize":case"AllowCustomize":case"AllowMove":case"AllowExpandCollapse":case"SizeMode":case"BarStyle":case"AllowFloat":case"HandleVisible":case"FillDockingRow":case"AllowDockLeft":case"AllowDockRight":case"AllowDockTop":case"AllowDockBottom":case"IsFloat":case"IsFloat1":case"ShowDelay":case"GreyImageWhenDisabled":case"TextAlign":c=BarControlEngine._GetDefault(b,a);break;case"AddRemoveOptionMenuViewMode":if(b.PlaceHolderManager!=null&&b.IntegratedTo!="None"){return b.PlaceHolderManager.Get(a)}else{c=b[a]=="Default"?"IconView":b[a]}break;default:c=b[a];break}return c},_GetDefault:function(c,b){if(c[b]=="Default"||c[b]=="NotSet"){if(c.PlaceHolderManager!=null){return c.PlaceHolderManager.Get(b)}else{return"Yes"}}else{switch(b){case"CommandSize":return c[b]==null||c[b]==""?"50px":c[b];break;case"ImageSize":var a=c[b];if(a==null||(a.Height=="16px"&&a.Width=="16px")){if(c.IntegratedTo=="PlaceHolderManager"&&c.PlaceHolderManager!=null){return c.PlaceHolderManager.Get(b)}else{if(c.IntegratedTo=="DesktopManager"&&c.DesktopManager!=null){return c.DesktopManager.Get(b)}}if(a==null){a=new UnitSize();a.Width=a.Height="16px"}return a}else{return c[b]}break;case"ShowDelay":if(c.Get(b)==500){if(c.IntegratedTo=="PlaceHolderManager"&&c.PlaceHolderManager!=null){return c.PlaceHolderManager.Get(b)}else{if(c.IntegratedTo=="DesktopManager"&&c.DesktopManager!=null){return c.DesktoprManager.Get(b)}}return c.Get(b)}else{return c[b]}break}}},__setter:function(b,d,e,a){switch(d){case"Opacity":BarControlEngine._SetOpacity(b,e);break;case"DisplayToolTip":BarControlEngine._SetDisplayToolTip(b,e);break;case"DisplayAccessKeyOnToolTip":BarControlEngine._SetDisplayAccessKeyOnToolTip(b,e);break;default:b[d]=e;break}},_SetOpacity:function(a,b){a.Opacity=parseFloat(b);if(IS.ie==false){a.FrameObj.style.opacity=parseFloat(b)}else{BarControlEngine._SetElementsOpacity(a.FrameObj,a.Opacity*100)}},_SetElementsOpacity:function(b,d){BarControlEngine._SetElementOpacity(b,d);var a=b.children;if(a!=null){for(var c=0;c<a.length;c++){BarControlEngine._SetElementsOpacity(a[c],d)}}},_SetElementOpacity:function(a,d){if(a!=null){if(a.style.filter==null){a.style.filter="progid:DXImageTransform.Microsoft.Alpha(opacity="+d.toString()+")"}else{var e=a.style.filter.toLowerCase().indexOf("opacity");if(e<0){a.style.filter+=(a.style.filter.length>0?";":"")+"progid:DXImageTransform.Microsoft.Alpha(opacity="+d.toString()+")"}else{var c=a.style.filter.substr(0,e);var b=a.style.filter.substr(e);b=b.substr(b.indexOf(")"));a.style.filter=c+"opacity="+d.toString()+b}}}}};function Command(){this._Type="Command";ISObject.call(this);this.AutoPostBack="Default";this.DisplayToolTip="Yes";this.ToolTip="";this.TextAlign="Default";this.DisplayMode="Default";this.IsEnabled=true;this.Visible=true;this.Image="";this.Text="";this._Image="";this._Text="";this.Category="";this.Name="";this.Index=-1;this.CommandSize="50px";this.ImageSize=new UnitSize();this.ImageSize.Width=this.ImageSize.Height="16px";this.CommandStyle=null;this.CommandFontStyle="";this.CommandDisableFontStyle="";this.AccessKey="";this._Visible=false;this._PrevVisible=false;this._UIVisible=false;this._HtmlObj=null;this._MaxDimension=0;this._UIState="";this._OriginalBarForCustomizeWindow=null;this.Menu=null;this.Items=null;this._ContextMenu=null;this.SelectedMenuItem=null;this._MoveSource=false;this._Move=false;this._Bar=null;this._Collection=null;this._PrevBarId=null;this.__getter=function(a){return CommandEngine.__getter(this,a)};this.__setter=function(b,c,a){return CommandEngine.__setter(this,b,c,a)};this.SetDisplayAccessKeyOnToolTip=function(a){CommandEngine._SetDisplayAccessKeyOnToolTip(this,a)};this.SetDisplayToolTip=function(a){CommandEngine._SetDisplayToolTip(this,a)};this.SetToolTip=function(a){CommandEngine._SetToolTip(this,a)};this.SetText=function(a){CommandEngine._SetText(this,a)};this.SetImage=function(a){CommandEngine._SetImage(this,a)};this.Clone=function(a){CommandEngine._Clone(this,a)};this.UpdateUI=function(){CommandEngine._UpdateUI(this)};this.Reset=function(){CommandEngine._Reset(this)};this.GetBar=function(){return this._Bar}}var CommandEngine={__getter:function(a,b){var d;switch(b){case"AutoPostBack":case"CommandSize":case"DisplayMode":case"DisplayToolTip":case"DisplayAccessKeyOnToolTip":case"ImageSize":case"MergeCommandID":case"GreyImageWhenDisabled":case"TextAlign":d=CommandEngine._GetDefault(a,b);break;default:d=a[b];break}return d},__setter:function(b,d,e,a){switch(d){case"Text":b.SetText(e);break;case"Visible":b.SetVisible(e);break;case"IsEnabled":b.SetIsEnabled(e);break;case"DisplayToolTip":CommandEngine._SetDisplayToolTip(b,e);break;case"Image":CommandEngine._SetImage(b,e);break;case"DisplayAccessKeyOnToolTip":CommandEngine._SetDisplayAccessKeyOnToolTip(b,e);break;default:b[d]=e;break}},_GetDefault:function(a,b){if(a[b]=="Default"){return a._Bar.Get(b)}else{if(b=="MergeCommandID"&&(a[b]==null||a[b]=="")){a._Bar.Get(b)}else{return a[b]}}},_SetText:function(a,b){a.Text=b;a._Bar._UpdateCommandTextAndImage(a)},_SetDisplayToolTip:function(a,b){a.DisplayToolTip=b;a._UIState="SetDisplayToolTip";if(a._HtmlObj!=null){a._HtmlObj.title=b}},_SetImage:function(a,d){a.Image=d;var b=a._HtmlObj;var c=CommandEngine._GetImageTagHtml(b);if(c!=null){c.src=a._Bar.ResolveImagePath(a._Bar.ImagesDirectory,d)}},_GetImageTagHtml:function(a){if(a==null){return null}if(a.tagName=="IMG"){return a}else{var c;for(var b=0;b<a.children.length;b++){if(a.children[b].tagName=="IMG"){c=a.children[b];break}else{c=CommandEngine._GetImageTagHtml(a.children[b]);if(c!=null){break}}}return c}},_SetDisplayAccessKeyOnToolTip:function(a,b){a.DisplayAccessKeyOnToolTip=b;a._UIState="SetDisplayAccessKeyOnToolTip"},_SetToolTip:function(a,c){a.ToolTip=c;var b=null;if(a._Bar!=null){if(a._Bar.Get("DisplayToolTip")=="Yes"){b=a.ToolTip;if(a._Bar.Get("DisplayAccessKeyOnToolTip")=="Yes"){if(a.AccessKey!=null&&a.AccessKey!=""){b+=" (ALT+"+a.AccessKey+")"}}}}if(a._HtmlObj!=null){a._HtmlObj.title=b}},_Clone:function(cmd,newBar){if(cmd._HtmlObj!=null){var newId=cmd._HtmlObj.id.replace(cmd._Bar.Id,newBar.Id+"_New");var oh=cmd._HtmlObj.outerHTML.replace(new RegExp(cmd._Bar.Id,"g"),newBar.Id);var cw=PlaceHolderManagerEngine.GetCustomizeWindow();var html_tbl=cw.TableTempObj;var oldBar=cmd._Bar;var row=html_tbl.rows[0];var cell=row.insertCell(-1);cell.id=newId;cell.title=cmd._HtmlObj.title;cell.vAlign=cmd._HtmlObj.vAlign;cell.align=cmd._HtmlObj.align;cell.noWrap=true;cell.className=cmd.IsEnabled?newBar.CommandStyle.Normal:newBar.CommandDisabledStyle;cell.innerHTML=cmd._HtmlObj.innerHTML;cmd._HtmlObj=document.getElementById(newId);with(cmd._HtmlObj.style){if(newBar.DockingArea=="Top"||newBar.DockingArea=="Bottom"){marginTop="1px";marginLeft=newBar.CommandMargin}else{marginTop=newBar.CommandMargin;marginLeft="1px"}}}},_UpdateUI:function(a){if(a._PrevBarId!=a._Bar.Id){if(a._Bar.DockingArea=="Left"||a._Bar.DockingArea=="Right"){a._Bar._SetItemToHorizontalDisplay(a)}else{if(a._Bar.DockingArea=="Top"||a._Bar.DockingArea=="Bottom"){a._Bar._SetItemToVerticalDisplay(a)}}}else{this._HtmlObj.style.display=this.Visible?"":"none"}},_Reset:function(a){a.DisplayToolTip="Yes";a.DisplayAccessKeyOnToolTip="No";a.ToolTip="";a.TextAlign="Right";a.DisplayMode="Text";a.Pushed=false;a.AutoCheck=true;a.Checked=false;a.IsEnabled=true;a.Visible=true;a.Image="";a.Text="";a.Category="";if(a._Bar!=null){a.Type=a._Bar.GetType()=="WebToolBar"?"Button":"Normal"}else{a.Type="Button"}a.CommandSize=null;a.ImageSize=null;a.MergeCommandID=""}};var ISBarCommon={RemoveStyleNodes:function(d){if(d.nodeName.indexOf("Style")>-1){d.parentNode.removeChild(d);return true}else{for(var a=0;a<d.attributes.length;a++){var c=d.attributes[a].name;if(c.indexOf("Style")>-1&&c.indexOf("Style")==c.length-5){d.removeAttribute(c);a--}}if(d.childNodes.length>0){for(var b=0;b<d.childNodes.length;b++){var e=ISBarCommon.RemoveStyleNodes(d.childNodes[b]);if(e){b--}}}}}};var ISDrag={_Obj:null,_isRegisterOnMouseMove:false,Register:function(m,c,k,h,j,f){var g=document.getElementById(m);g.IsDragabble=true;g.IsInDragArea=false;g.OnDragStart=k;g.OnDrag=h;g.OnDragEnd=j;var a=new Array();if(f!=null){var n=f.split(";");var q="";var p;for(var l=0;l<n.length;l++){q=n[l].replace(/\\s*/g,"");if(q!=""){p=new Object();p.id=q;a[a.length]=p}}}g.DragTargetId=null;g.DragTargets=a;g.LastParentId=null;g.LastIndexInParent=-1;var b=null;if(c==null){b=g;b.dragId=m;Listener.Add(b,"onmousedown",ISDrag.OnMouseDown,b)}else{if(c.indexOf(";")<0){b=document.getElementById(c);b.dragId=m;Listener.Add(b,"onmousedown",ISDrag.OnMouseDown,b)}else{var d=c.split(";");for(var l=0;l<d.length;l++){if(d[l]!=""){b=document.getElementById(d[l]);b.dragId=m;Listener.Add(b,"onmousedown",ISDrag.OnMouseDown,b)}}}}if(!ISDrag._isRegisterOnMouseMove){ISDrag._isRegisterOnMouseMove=true;Listener.Add(document,"onmousemove",ISDrag.OnMouseMove)}},OnMouseDown:function(){var b=window.event;if(this.dragId==null||this.dragId==""){return true}var a=document.getElementById(this.dragId);if(a.IsDragabble==true){a.prevZIndex=a.style.zIndex;a.style.zIndex=9998;b.returnValue=false;document.body.style.cursor="move";a.dragAreaId=this.id;a.DragWidth=ISPosLib.getWidth(a);a.DragHeight=ISPosLib.getHeight(a);a.DragLeft=ISPosLib.getLeft(a);a.DragTop=ISPosLib.getTop(a);a.IsInDragArea=false;a.DragX=ISDrag.GetXPos(b);a.DragY=ISDrag.GetYPos(b);ISDrag._Obj=a;a.DragTargetId=null;var f=a.offsetParent;if(f!=document.body){a.LastParentId=f.id;var d=-1;for(var c=0;c<f.children.length;c++){if(f.children[c]==a){d=c;break}}a.LastIndexInParent=d}else{a.LastParentId=null;a.LastIndexInParent=-1}a.IsReCalculateDragArea=true;Listener.Add(document,"onmouseup",ISDrag.OnMouseUp);if(a.OnDragStart){a.OnDragStart(a)}}},OnMouseMove:function(){var f=window.event;var d=ISDrag._Obj;if(d==null){return}if(d.IsDragabble==true){f.returnValue=false;var g=ISDrag.GetXPos(f);var h=ISDrag.GetYPos(f);var b=g-d.DragX;var c=h-d.DragY;var a=document.getElementById(d.dragAreaId);if(d.DragWidth==null||d.DragWidth==0){d.DragWidth=ISPosLib.getWidth(a)}if(d.DragHeight==null||d.DragHeight==0){d.DragHeight=ISPosLib.getHeight(a)}d.DragLeft=ISPosLib.getLeft(d);d.DragTop=ISPosLib.getTop(d);if(d.IsReCalculateDragArea){d.IsReCalculateDragArea=false;ISDrag.CalculateDragArea(d)}d.IsInDragArea=ISDrag.CheckDragArea(d,g,h);d.DragX=g;d.DragY=h;if(d.OnDrag){d.OnDrag(d,b,c)}else{d.style.left=parseFloat(d.style.left)+b+"px";d.style.top=parseFloat(d.style.top)+c+"px"}}},OnMouseUp:function(){var b=window.event;var a=ISDrag._Obj;if(a==null){return}if(a.IsDragabble==true){a.style.zIndex=a.prevZIndex;b.returnValue=false;document.body.style.cursor="";a.IsReCalculateDragArea=true;a.DragX=ISDrag.GetXPos(b);a.DragY=ISDrag.GetYPos(b);a.LastParentId=null;a.LastIndexInParent=-1;ISDrag._Obj=null;Listener.Remove(document,"onmouseup",ISDrag.OnMouseUp);if(a.OnDragEnd){a.OnDragEnd(a)}a.IsInDragArea=false}},CalculateDragArea:function(a){var d,b;for(var c=0;c<a.DragTargets.length;c++){d=a.DragTargets[c];b=document.getElementById(d.id);if(b){d.x1=ISPosLib.getLeft(b);d.y1=ISPosLib.getTop(b);d.x2=d.x1+ISPosLib.getWidth(b);d.y2=d.y1+ISPosLib.getHeight(b)}}},CheckDragArea:function(a,d,f){var c=false;a.DragTargetId=null;for(var b=0;b<a.DragTargets.length;b++){o=a.DragTargets[b];if((d>=(o.x1-5)&&d<=(o.x2+5)&&f>=(o.y1-5)&&f<=(o.y2+5))){a.DragTargetId=o.id;c=true;break}}return c},GetXPos:function(a){var b=0;if(IS.ie){b=a.clientX+xScrollLeft()}else{b=a.pageX}return b},GetYPos:function(a){var b=0;if(IS.ie){b=a.clientY+xScrollTop()}else{b=a.pageY}return b}};function xScrollLeft(){var a=0;if(window.pageXOffset){a=window.pageXOffset}else{if(document.documentElement&&document.documentElement.scrollLeft){a=document.documentElement.scrollLeft}else{if(document.body&&document.body.scrollLeft){a=document.body.scrollLeft}}}return a}function xScrollTop(){var a=0;if(window.pageYOffset){a=window.pageYOffset}else{if(document.documentElement&&document.documentElement.scrollTop){a=document.documentElement.scrollTop}else{if(document.body&&document.body.scrollTop){a=document.body.scrollTop}}}return a}function GetWebToolBarAccessKey(){var a=null;var b=window.event;if(b==null){return a}if(b.altKey==true&&b.keyCode!=18){a=String.fromCharCode(b.keyCode)}return a}function GetUIControls(){var a=new Array();var b;for(var c=0;c<IS.RuntimeObjects.length;c++){b=IS.RuntimeObjects[c];if(b!=null&&(b.GetType()=="WebToolBar"||b.GetType()=="WebMenuBar")){a[a.length]=b}}return a}function DetectAccessKeyWebUIControl(){var a=GetWebToolBarAccessKey();if(a==null){return}if(a!=""){a=a.toLowerCase()}var c=GetUIControls();var e,d,b;var g=false;for(var h=0;h<c.length;h++){e=c[h];if(e.GetType()=="WebToolBar"){for(var f=0;f<e.Commands.length;f++){d=e.Commands[f];b=d.AccessKey;if(b!=null){b=b.toLowerCase()}if(a==b){g=true;break}}}else{for(var f=0;f<e.Menus.length;f++){d=e.Menus[f];b=d.AccessKey;if(b!=null){b=b.toLowerCase()}if(a==b){g=true;break}}}if(g){d._HtmlObj.blur();d.OnAccessKey();window.event.cancelBubble=true;window.event.returnValue=false;break}}return true}function WebUIControlOnLoad(){document.attachEvent("onkeydown",DetectAccessKeyWebUIControl)}function WebUIControlUnOnLoad(){document.detachEvent("onkeydown",DetectAccessKeyWebUIControl)}window.attachEvent("onload",WebUIControlOnLoad);window.attachEvent("unonload",WebUIControlUnOnLoad);