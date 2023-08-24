function WebButton(a){this.ClassName="WebButton";this.Version="2.5.2007";this.BuildNumber="0";this.MajorVersion="2.0";this.RequiredFrameworkVersion="2.0.5000.10";ISControl.call(this,a);IFlyPostBack.call(this,"WebButtonRequest");this.ScriptDirectory="/CommonLibrary/WebDesktop/V3_0_7200/";this.Text="";this.Image="";this.DisplayMode="Text";this.ImagePosition="Left";this.Type="NotSet";this.Parameter="";this.IntegratedToDesktopManager=false;this.AutoPostback=false;this.OnClientClick="";this.OnClientInitialize="";this.OnClientResponse="";this.PostBackMode="FlyPostBack";this.DisableOnClicked=false;this.ButtonStyle=null;this.DisabledStyle="";this.ViewStateStorage="PageCache";this.AccessKey="";this.Enabled=true;this.TabIndex=null;this.ToolTip="";this.ClientID=a;this.ID=a;this.UniqueID=a;this.FlyPostBackSettings=new FlyPostBackSettings();this.BorderType="Simple";this.ImagesSettings=null;this.ImagesDirectory="";this.DesktopManager=null;this.OriginalWindow=null;this.IsUnloaded=false;this.IntegrationState=false;this.CausesValidation=true;this.ValidationGroup="";this.IsToggleButton=false;this.IsPushed=false;this.Width=0;this.Height=20;this.IsMouseDown=false;this.CustomImageStyle="";this.InProgressImage="";this.InProgressText="";this.ShowProgressOnClicked=false;this.ProgressTextStyle="";this.ProgressElement=null;this.OnInitialize=function(){this.RemoveDynamicStyle()};this.RemoveDynamicStyle=function(){var e=["Button"];for(var b=0;b<e.length;b++){var d=this[e[b]+"Style"];if(d){ISXml.RemoveNode(this.XmlNode,e[b]+"Style")}}};this.GetElement=function(){return document.getElementById(this.Id+IS.FrameSuffix)};this.SetDisable=this.Disable=function(){var d=this.GetElement();if(d.parentElement&&IS.ie){try{document.body.focus()}catch(b){}}d.className=this.DisabledStyle;if(IS.ie){setTimeout(function(){d.disabled=true},10)}else{d.disabled=true}if(this.BorderType=="ComplexImages"){d.children[0].rows[0].cells[1].className=this.DisabledStyle}this.Enabled=false};this.SetEnable=this.Enable=function(){var b=this.GetElement();b.disabled=false;this.FrameObj.children[0].style.color="";this.ButtonStyle.SetToNormal();if(this.BorderType=="ComplexImages"){b.children[0].rows[0].cells[1].className=""}this.Enabled=true};this.OnUnload=function(){var b=this.GetElement();if(b){Listener.Unload(b)}window.detachEvent("onload",function(){WebButtonEngine.InitializeIntegration(c,true)});this.IsUnloaded=true};this.OnResponse=function(b){WebButtonEngine.OnResponse(this,b)};this.OnResponseError=function(b){WebButtonEngine.OnResponseError(this,b)};this.Click=function(){var b=this.GetElement();if(b){if(IS.ie11){b.click()}else{b.fireEvent("onclick")}}};this.RenderComplexImages=function(){if(this.BorderType!="ComplexImages"){return}WebButtonEngine.RenderComplexImages(this);if(this.IsPushed){WebButtonEngine.SetImages(this,"Active")}else{WebButtonEngine.SetImages(this,"Normal")}};this.SetPushed=function(b){if(typeof(b)=="undefined"){b=true}if(this.IsPushed&&b){return}if(!this.IsPushed&&!b){return}if(!b){if(this.BorderType=="ComplexImages"){WebButtonEngine.SetImages(this,"Normal")}else{this.ButtonStyle.SetToNormal()}}else{if(this.BorderType=="ComplexImages"){WebButtonEngine.SetImages(this,"Active")}else{this.ButtonStyle.SetToActive()}}this.IsPushed=b};this.InstantiateIn=function(b){if(b!=null){WebButtonEngine.Render(this,b)}};this.SetIntegrationToDesktopManager=function(){this.IntegratedToDesktopManager=true;WebButtonEngine.InitializeIntegration(this,false)};this.ResetState=function(){if(this.ProgressElement!=null){this.ProgressElement.style.display="none"}this.FrameObj.style.display=""};this.ShowProgress=function(){if(this.ProgressElement==null){var b=document.createElement("span");b.className=this.ProgressTextStyle;b.innerHTML='<img style="vertical-align: middle" alt="" src="'+this.InProgressImage+'" /> '+this.InProgressText;this.FrameObj.insertAdjacentElement("afterEnd",b);this.ProgressElement=b}this.FrameObj.style.display="none";this.ProgressElement.style.display=""};this.Hide=function(){this.FrameObj.style.display="none";if(this.ProgressElement!=null){this.ProgressElement.style.display="none"}};this.Show=function(){this.ResetState()}}function InitWebButton(b){var a=WebButtonEngine.Create(b);a.OnInitialize()}function CreateWebButton(d,b){var a=null;if(typeof(d)=="string"){a=WebButtonEngine.Create(d,true,b)}else{if(typeof(d)=="object"){a=WebButtonEngine.Create(d,true,b,true)}}a.CreatedAtRuntime=true;a.OnInitialize();return a}var WebButtonEngine={Initialized:false,Create:function(b,e,f,d){var a=null;if(!d){a=new WebButton(b)}else{a=b}WebButtonEngine.AssignProperties(a,e,f);WebButtonEngine.RegisterBehaviour(a);WebButtonEngine.InitializeMozilla(a);WebButtonEngine.InitializeIntegration(a);a.IsInit=true;return a},CreateWebButtonXmlDoc:function(a){if(a.XmlDt==null){var b=ISXml.CreateXmlDocument();ISXml.LoadXml(b,"<WebButton />");a.XmlDt=b;return b}return null},AssignProperties:function(a,d,f){if(a==null){return}if(!a.IsInit){var g=null;if(typeof(IS_ReleaseType)!="undefined"&&IS_ReleaseType=="Beta"){a.ScriptDirectory="/CommonLibraryBeta/WebDesktop/V3_0_7200/"}if(d){WebButtonEngine.CreateWebButtonXmlDoc(a)}try{g=ISXml.GetNode(a.XmlDt,"//WebButton")}catch(b){}a.PostViewState=false;a.PostHiddenFields=false;a.FlyPostBackSettings.PostViewState=false;a.FlyPostBackSettings.PostHiddenFields=false;if(g==null){g=a.XmlDt.documentElement}if(g!=null){IS.SetPropertiesRecursive(a,g);if(!d){a.ButtonStyle=DynamicStyleEngine.Assign(ISXml.GetNode(a.XmlDt,"//ButtonStyle"),a.GetElement())}else{if(f.ButtonStyle){a.ButtonStyle=f.ButtonStyle}else{if(f.DisabledButtonStyle){a.DisabledButtonStyle=f.DisabledButtonStyle}}if(f.Host){a.InstantiateIn(f.Host);a.ButtonStyle.Object=a.GetElement()}}}}},RegisterBehaviour:function(a){var b=a.GetElement();a.OriginalWindow=window;Listener.Add(b,"onmouseover",function(){WebButtonEngine.OnMouseEvents(a,"over")});Listener.Add(b,"onmouseout",function(){WebButtonEngine.OnMouseEvents(a,"out")});Listener.Add(b,"onmousedown",function(){WebButtonEngine.OnMouseEvents(a,"down")});Listener.Add(b,"onmouseup",function(){WebButtonEngine.OnMouseEvents(a,"up")});Listener.Add(b,"onkeydown",function(){WebButtonEngine.OnKeyDown(a)});Listener.Add(b,"onclick",function(){return WebButtonEngine.OnClick(a)});a.XmlHttp=ISXmlHttpEngine.Create(a,function(){WebButtonEngine.OnResponse(a)})},InitializeMozilla:function(a){if(IS.moz){}},OnMouseEvents:function(a,f){if(!a.Enabled){return}var b=a.GetElement();var e=null;var d=event;if(!d){d=a.OriginalWindow.event}if(!d&&a.DesktopManager!=null){d=a.DesktopManager.GetContentWindow().event}if(d){e=d.toElement}if(f=="over"){if(a.IsToggleButton&&a.IsPushed){return}if(a.IsMouseDown){if(a.BorderType=="ComplexImages"){WebButtonEngine.SetImages(a,"Active")}else{a.ButtonStyle.SetToActive()}return}if(a.BorderType=="ComplexImages"){WebButtonEngine.SetImages(a,"Over")}else{a.ButtonStyle.SetToOver()}}else{if(f=="out"){if(!b.contains(e)){if(a.IsToggleButton&&a.IsPushed){if(a.BorderType=="ComplexImages"){WebButtonEngine.SetImages(a,"Active")}else{a.ButtonStyle.SetToActive()}}else{if(a.BorderType=="ComplexImages"){WebButtonEngine.SetImages(a,"Normal")}else{a.ButtonStyle.SetToNormal()}}}}else{if(f=="down"){if(ISEvent.IsLeftButton(d)){a.IsMouseDown=true;WebButtonEngine.CurrentButton=a;if(a.BorderType=="ComplexImages"){WebButtonEngine.SetImages(a,"Active")}else{a.ButtonStyle.SetToActive()}}}else{if(f=="up"){if(!a.IsMouseDown){return}a.IsMouseDown=false;if(WebButtonEngine.CurrentButton!=null&&WebButtonEngine.CurrentButton!=a){return}if(a.IsToggleButton){a.IsPushed=!a.IsPushed}if(a.IsToggleButton&&a.IsPushed){return}if(a.BorderType=="ComplexImages"){WebButtonEngine.SetImages(a,"Over")}else{a.ButtonStyle.SetToOver()}}}}}},OnClick:function(a){if(a.IntegratedToDesktopManager){if(IS.moz){var b=ISGetCurrentWindow();if(b){var e=b.DesktopManager.GetContentWindow();e.event.cancelBubble=true;e.event.returnValue=false}else{if(event){event.cancelBubble=true;event.returnValue=false}}}}var f=ISEvent.Raise(a.OnClientClick,a.Id,a.Parameter);if(f&&a.ClassName){var d=a.GetElement();if(a.DisableOnClicked){a.SetDisable()}if(a.ShowProgressOnClicked){a.ShowProgress()}if(a.AutoPostback){var g=true;var h=!a.CausesValidation;if(a.CausesValidation){g=Page_ClientValidate(a.ValidationGroup);if(g){h=true}}if(a.PostBackMode=="FlyPostBack"){if(g){WebButtonEngine.ExecuteFlyPostback(a,"Click")}}else{if(g){__doPostBack(a.ServerUniqueID,"ButtonClick:"+a.Parameter,h)}}}else{if(a.IntegratedToDesktopManager){var b=ISGetCurrentWindow();if(b){if(b.IsDialogBox){if(a.Type=="Cancel"){b.Close()}}}}}if(event){event.cancelBubble=true;event.returnValue=false}}if(event){event.cancelBubble=true;event.returnValue=false}if(IS.safari){return false}},OnKeyDown:function(a){},ExecuteFlyPostback:function(b,a){if(b.IsInProgress){return}b.XmlReq=ISXmlHttpEngine.CreateRequestXml(b.GetType());var d=ISXml.GetNode(b.XmlReq,"//request");d.setAttribute("id",b.Id);d.setAttribute("action",a);d.setAttribute("parameter",b.Parameter);b.XmlHttp.Send();b.IsInProgress=true},OnResponse:function(a,b){if(!ISEvent.Raise(a.OnClientResponse,a.Id,b)){return}a.IsInProgress=false},OnResponseError:function(a,b){a.IsInProgress=false;alert("Error occurred:"+b)},InitializeIntegration:function(a,e){ISEvent.Raise(a.OnClientInitialize,a.Id);if(a.IntegratedToDesktopManager){if(e&&a.IntegrationState){return}var b=ISGetDesktopManager();if(!b){if(e&&!a.IntegrationState){alert(a.Id+" Integration Error: Can't integrate to DesktopManager because no DesktopManager instance found!")}else{if(!e){window.attachEvent("onload",function(){WebButtonEngine.InitializeIntegration(a,true)})}}}else{var f=ISGetCurrentWindow();if(!f){f=ISGetCurrentWindow(true)}if(!f){f=ISGetCurrentWindow(true,b)}if(!f&&window==b.GetContentWindow()){f=true}if(f){var d=a.GetElement();WebButtonEngine.InitializeStyleRules(b,a);a.ButtonStyle.Normal=b.WindowSettings.CommandButtonStyle.Normal;a.ButtonStyle.Over=b.WindowSettings.CommandButtonStyle.Over;a.ButtonStyle.Active=b.WindowSettings.CommandButtonStyle.Active;a.ButtonStyle.SetToNormal();a.DisabledStyle=b.WindowSettings.CommandButtonDisabledStyle;a.BorderType=b.WindowSettings.CommandButtonBorderType;a.ImagesSettings=b.ImagesSettings;a.ImagesDirectory=b.ImagesDirectory;a.DesktopManager=b;if(a.BorderType=="ComplexImages"){WebButtonEngine.RenderComplexImages(a);WebButtonEngine.SetImages(a,"Normal")}a.IntegrationState=true}}}},PreloadImages:function(a){var e=new Array();var f=a.ImagesSettings;var d=0;var b=ISGetDesktopManager();if(!b){return}for(var h in f){var g=f[h];if(typeof(g)=="string"&&g!=""){var j=b.ResolveImagePath(g);e[d]=new Image();e[d].src=j;d++}}},InitializeStyleRules:function(e,a){var j=e.GetDesktopElement();var b=e.WindowSettings.CommandButtonStyle;var h=[b.Normal,b.Over,b.Active,e.WindowSettings.CommandButtonDisabledStyle];var g="";for(var f=0;f<h.length;f++){if(!IS.GetCssObject(null,h[f])){var d=e.GetCssObject(h[f]);if(d){IS.AddRuntimeCssStyle(d.selectorText,d.style.cssText)}}}},Render:function(a,d){var b=document.createElement("button");b.id=a.Id+IS.FrameSuffix;if(!a.Enabled){b.className=a.DisabledStyle}else{if(a.IsToggleButton&&a.IsPushed){b.className=a.ButtonStyle.Active}else{b.className=a.ButtonStyle.Normal}}if(a.Width>0){b.style.width=a.Width+"px"}if(a.Height>0){b.style.height=a.Height+"px"}if(a.TabIndex>0){b.tabIndex=a.TabIndex}if(a.ToolTip!=""){b.title=a.ToolTip}if(!a.Enabled){b.disabled=true}if(a.AccessKey!=""){b.accessKey=a.AccessKey}var e="<div>";if((a.DisplayMode=="TextAndImage"||a.DisplayMode=="Image")&&a.ImagePosition=="Left"){e+="<img align=absmiddle src='"+a.Image+"' style='"+a.CustomImageStyle+"' hspace=2 />&nbsp;"}if(a.DisplayMode!="Image"){e+=a.Text}if(a.DisplayMode=="TextAndImage"&&a.ImagePosition=="Right"){e+="&nbsp;<img align=absmiddle src='"+a.Image+"' hspace=2 />"}e+="</div>";b.innerHTML=e;d.appendChild(b);a.FrameObj=b},RenderComplexImages:function(a){if(a.BorderType!="ComplexImages"){return}var b=a.GetElement();var d="<table border=0 cellspacing=0 cellpadding=0 style='width:98%;";if(!IS.safari){d+="height:100%;"}d+="'><tr>";if(IS.IsHTML5DocType()){d+="<td><img style='display: block;' /></td>"}else{d+="<td><img /></td>"}d+="<td width='100%' align="+b.currentStyle.textAlign+">"+b.innerHTML+"</td>";if(IS.IsHTML5DocType()){d+="<td><img style='display: block;' /></td>"}else{d+="<td><img /></td>"}d+="</tr></table>";b.innerHTML=d;b.children[0].style.fontFamily=b.currentStyle.fontFamily;b.children[0].style.fontSize=b.currentStyle.fontSize;b.children[0].style.color=b.currentStyle.color;b.style.backgroundColor="transparent";b.style.cursor="default";b.style.height=""},SetImages:function(a,i){var f="";var b="";var g="";var h=a.GetElement().children[0].rows[0];var e=a.ImagesSettings;var d=a.DesktopManager;if(i=="Normal"){f=d.ResolveImagePath(e.ButtonLeftInactive);b=d.ResolveImagePath(e.ButtonCenterInactive);g=d.ResolveImagePath(e.ButtonRightInactive)}else{if(i=="Over"){f=d.ResolveImagePath(e.ButtonLeftOver);b=d.ResolveImagePath(e.ButtonCenterOver);g=d.ResolveImagePath(e.ButtonRightOver)}else{f=d.ResolveImagePath(e.ButtonLeftActive);b=d.ResolveImagePath(e.ButtonCenterActive);g=d.ResolveImagePath(e.ButtonRightActive)}}h.cells[0].children[0].src=f;h.cells[1].style.backgroundImage="url("+b+")";h.cells[1].style.backgroundRepeat="repeat-x";h.cells[2].children[0].src=g},OnBodyMouseUp:function(){if(WebButtonEngine.CurrentButton!=null){WebButtonEngine.CurrentButton.IsMouseDown=false;WebButtonEngine.CurrentButton=null}}};function WebButtonDestructor(){document.body.detachEvent("onmouseup",WebButtonEngine.OnBodyMouseUp);var a=delete WebButtonEngine}window.attachEvent("onunload",WebButtonDestructor);if(document!=null&&document.body!=null){document.body.attachEvent("onmouseup",WebButtonEngine.OnBodyMouseUp)}else{setTimeout(function(){document.body.attachEvent("onmouseup",WebButtonEngine.OnBodyMouseUp)},100)}if(typeof(Sys)!="undefined"){Sys.Application.notifyScriptLoaded()};