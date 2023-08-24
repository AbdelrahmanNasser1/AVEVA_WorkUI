function WebDragControl(){this._Type="WebDragControl";ISObject.call(this);this.AllowedEffects=1;this.AllowCrossIFrame="Default";this.DragVisualHint="Default";this.DragData="";this.ControlID="";this.ControlIDResolved="";this.Enabled=true;this.Effect=8192;this.EffectText="";this.AdvancedProperties="";this.CustomInterface=null;this.Element=null;this.GetDefault=function(a){if(this[a]=="Default"||this[a]==""){return this.Parent.DragSettings[a]}else{return this[a]}};this.__getter=function(a){switch(a){case"Effect":if(this.Effect==8192){return this.Parent.DragSettings.DefaultEffect}else{return this.Effect}case"EffectText":if(this.EffectText==""){return this.Parent.DragSettings.DefaultEffectText}else{return this.EffectText}default:return this.GetDefault(a)}};this.GetElement=function(){if(!this.Element){this.Element=document.getElementById(this.ControlIDResolved)}return this.Element}}function WebDragDropClientSideEvents(){this._Type="WebDragDropClientSideEvents";ISObject.call(this);this.OnDragStart="";this.OnDragEnd="";this.OnShadowCreate="";this.OnDragOver="";this.OnDragDrop="";this.OnDragEnter="";this.OnDragLeave="";this.OnInitialize="";this.OnRegisterInterface=""}function WebDragDropExtender(a){this.ClassName="WebDragDropExtender";this.Version="2.5.2007";this.BuildNumber="0";this.MajorVersion="2.5";this.RequiredFrameworkVersion="3.0.5000.10";ISControl.call(this,a);IFlyPostBack.call(this,"WebDragDropRequest");this.DragControls=new Array();this.DropControls=new Array();this.DragSettings=new WebDragSettings();this.DropSettings=new WebDropSettings();this.ClientSideEvents=new WebDragDropClientSideEvents();this.ScriptDirectory="/CommonLibrary/WebDesktop/V3_0_7200/";this.Enabled=false;this.Visible=false;this.XmlCompressionEnabled=false;this.ClientID=a;this.ID=a;this.Parent=null;this.UniqueID=a;this.ImagesDirectory="/CommonLibrary/Images/WebDesktop/";this.WebResourceIdentifier="D";this.GlobalCoordResolver=null;this.OnInitialize=function(){ISEvent.Raise(this.ClientSideEvents.OnInitialize,this.Id)};this.OnUnload=function(b){var c=this.DragControls;for(var f=0;f<c.length;f++){var e=document.getElementById(c[f].ControlIDResolved);if(e){WebDragDropEngine.RemoveDragControl(c[f])}else{if(c[f].CustomInterface){c[f].CustomInterface.RemoveDragControl()}}c[f].Element=null}if(!b){var d=this.DropControls;for(var f=0;f<d.length;f++){d[f].Element=null}}};this.OnPropertiesInitialized=function(){if(this.Events!=null){var b;for(b in this.Events){if(typeof(this.Events[b])=="string"){this.ClientSideEvents[b]=this.Events[b]}}}};this.OnResponse=function(b){WebDragDropEngine.OnResponse(this,b)};this.OnResponseError=function(b){WebDragDropEngine.OnResponseError(this,b)};this.ReinitializeDragControls=function(){var b=this.DragControls;for(var d=0;d<b.length;d++){var c=document.getElementById(b[d].ControlIDResolved);if(c&&b[d].AdvancedProperties==""){WebDragDropEngine.AddDragControl(b[d])}else{b[d].CustomInterface=WebDragDropEngine.CreateDragCustomInterface(b[d]);if(b[d].CustomInterface){b[d].CustomInterface.AddDragControl()}}}};this.ReinitializeDropControls=function(){var b=this.DropControls;ISDragDropEngine.Dropables=new Array();for(var c=0;c<b.length;c++){WebDragDropEngine.AddDropControl(b[c])}};this.UnloadDragControls=function(){this.OnUnload(true)};this.ClearDropControlCache=function(){var b=ISDragDropEngine.Dropables;for(var c=0;c<b.length;c++){b[c].Coord=null}}}function WebDragSettings(){this._Type="WebDragSettings";ISObject.call(this);this.AllowedEffects="All";this.AllowCrossIFrame="NotAllowed";this.DragVisualHint="MakeTransparent";this.DefaultEffect=0;this.DefaultEffectText=""}function WebDropControl(){this._Type="WebDropControl";ISObject.call(this);this.AutoPostBackOnDragDrop="Default";this.AcceptDataType="Default";this.ControlID="";this.Enabled=true;this.AcceptDragSourceControls="";this.AdvancedProperties="";this.Element=null;this.EnableCaching=true;this.GetDefault=function(a){if(this[a]=="Default"||this[a]==""){return this.Parent.DropSettings[a]}else{return this[a]}};this.__getter=function(a){switch(a){default:return this.GetDefault(a)}};this.GetElement=function(){if(!this.Element){this.Element=document.getElementById(this.ControlIDResolved)}return this.Element}}function WebDropSettings(){this._Type="WebDropSettings";ISObject.call(this);this.AutoPostBackOnDragDrop="No";this.AcceptDataType="All";this.PostBackMode="FullPostBack"}function InitWebDragDropExtender(b){var a=WebDragDropEngine.Create(b);a.OnInitialize()}var WebDragDropEngine={Initialized:false,Create:function(b){var a=new WebDragDropExtender(b);WebDragDropEngine.AssignProperties(a);WebDragDropEngine.RegisterBehaviour(a);WebDragDropEngine.InitializeMozilla(a);a.IsInit=true;return a},AssignProperties:function(a){if(a==null){return}if(!a.IsInit){var d=null;if(typeof(IS_ReleaseType)!="undefined"&&IS_ReleaseType=="Beta"){a.ScriptDirectory="/CommonLibraryBeta/WebDesktop/V5_0_7200/";a.ImagesDirectory="/CommonLibraryBeta/Images/WebDesktop/"}try{d=ISXml.GetNode(a.XmlDt,"//WebDragDropExtender")}catch(b){}if(d==null){d=a.XmlDt.documentElement}if(d!=null){IS.SetPropertiesRecursive(a,d)}}},RegisterBehaviour:function(a){var b=a.DragControls;var d=a.DropControls;ISEvent.Raise(a.ClientSideEvents.OnRegisterInterface,a.Id,b,d);for(var f=0;f<b.length;f++){var e=document.getElementById(b[f].ControlIDResolved);if(e&&b[f].AdvancedProperties==""){WebDragDropEngine.AddDragControl(b[f])}else{b[f].CustomInterface=WebDragDropEngine.CreateDragCustomInterface(b[f]);if(b[f].CustomInterface){b[f].CustomInterface.AddDragControl()}}}for(var f=0;f<d.length;f++){WebDragDropEngine.AddDropControl(d[f])}a.XmlHttp=ISXmlHttpEngine.Create(a,function(){WebDragDropEngine.OnResponse(a)})},InitializeMozilla:function(a){if(IS.moz){}},CreateDragCustomInterface:function(c){if(c.AdvancedProperties!=""){var a=c.AdvancedProperties.split(",");if(a.length>0){var b=a[0].split("=");if(b[0]=="Type"){var d=b[1];switch(d){case"WebGrid":return WebDragDropInterfaceEngine.CreateDrag(d,c);case"Custom":if(typeof(c.OnRegisterCustomInterface)=="function"){return c.OnRegisterCustomInterface(c)}else{if(c.AdvancedProperties.indexOf("ComponentType")==-1){alert("OnRegisterCustomInterface of the drag control must be implemented to support custom drag drop interface.")}}break}}}}return null},CreateDropCustomInterface:function(c){if(c.AdvancedProperties!=""){var a=c.AdvancedProperties.split(",");if(a.length>0){var b=a[0].split("=");if(b[0]=="Type"){var d=b[1];switch(d){case"WebNavPane":case"WebDesktopManager":case"WebExplorerPane":return WebDragDropInterfaceEngine.CreateDrop(d,c);case"Custom":if(typeof(c.OnRegisterCustomInterface)=="function"){return c.OnRegisterCustomInterface(c)}else{if(c.AdvancedProperties.indexOf("ComponentType")==-1){alert("OnRegisterCustomInterface of the drop control must be implemented to support custom drag drop interface.")}}break}}}}return null},AddDragControl:function(a){var b=a.GetElement();if(b){if(b.onselectstart){b.hasSelectStart=true}Listener.Add(b,"onmousedown",WebDragDropEngine.OnMouseDown,a)}},RemoveDragControl:function(a){Listener.Unload(a)},AddDropControl:function(a){var b=a.GetElement();if(b&&a.AdvancedProperties==""){var d=new ISDropableObject(b,WebDragDropEngine.OnDragOver,WebDragDropEngine.OnDragDrop,WebDragDropEngine.OnDragEnter,WebDragDropEngine.OnDragLeave);d.Owner=a;d.EnableCaching=a.EnableCaching;ISDragDrop.RegisterDropable(d)}else{a.CustomInterface=WebDragDropEngine.CreateDropCustomInterface(a);if(a.CustomInterface){var d=new ISDropableObject(null,WebDragDropEngine.OnDragOver,WebDragDropEngine.OnDragDrop,WebDragDropEngine.OnDragEnter,WebDragDropEngine.OnDragLeave);d.Owner=a;d.EnableCaching=a.EnableCaching;a.CustomInterface.AddDropControl(d);ISDragDrop.RegisterDropable(d)}else{var c=ISGetObject(a.ControlID);if(c&&c.FrameObj!=null){var d=new ISDropableObject(c.FrameObj,WebDragDropEngine.OnDragOver,WebDragDropEngine.OnDragDrop,WebDragDropEngine.OnDragEnter,WebDragDropEngine.OnDragLeave);d.Owner=a;d.EnableCaching=a.EnableCaching;ISDragDrop.RegisterDropable(d)}}}},OnMouseDown:function(){var a=this;var d=true;var b=null;var c=window.event;if(c!=null&&!ISEvent.IsLeftButton(c)){return}if(a.CustomInterface){d=a.CustomInterface.OnMouseDown()}if(d){b=WebDragDropEngine._OnMouseDown(a)}if(a.CustomInterface&&b){a.CustomInterface.OnPostMouseDown(b)}},_OnMouseDown:function(a){var g=this;if(a){g=a}var b=g.Parent;var h=g.GetElement();var f=ISDragDrop.DoDragDrop(h,g.DragData,g.AllowedEffects,true);var e=g.Get("AllowCrossIFrame");f.Owner=g;f.OnDragStart=WebDragDropEngine.OnDragStart;f.OnDragEnd=WebDragDropEngine.OnDragEnd;f.OnShadowCreate=WebDragDropEngine.OnShadowCreate;f.Enabled=g.Enabled;if(e!="NotAllowed"){if(e=="ChildIFrameOnly"){f.AllowCrossFrame=true}else{if(e=="SiblingAndChildIFrame"){f.AllowCrossFrame=true;f.TopLevelDragDrop=true}}}if(g.Get("DragVisualHint")=="SimpleIndicator"){f.SimpleIndicator=true}return f},OnDragOver:function(f,d){var c=d.Owner;var a=c.Parent;var b=f.DragObject;if(b.CustomInterface){b.CustomInterface.OnDragOver(f,d)}if(c.CustomInterface){c.CustomInterface.OnDragOver(f,d)}return ISEvent.Raise(a.ClientSideEvents.OnDragOver,a.Id,f,d)},OnDragDrop:function(f,d){var c=d.Owner;var a=c.Parent;var g=true;var b=f.DragObject;if(b.CustomInterface){b.CustomInterface.OnDragDrop(f,d)}if(c.CustomInterface){c.CustomInterface.OnDragDrop(f,d)}g=ISEvent.Raise(a.ClientSideEvents.OnDragDrop,a.Id,f,d);if(g){if(c.Get("AutoPostBackOnDragDrop")=="Yes"){if(a.DropSettings.PostBackMode=="FullPostBack"){__doPostBack(a.ServerUniqueID,"DragDrop\03"+f.DragObject.Owner.ControlID+"\03"+f.Data+"\03"+f.Effect+"\03"+f.EffectText+"\03"+f.KeyState+"\03"+f.AllowedEffects+"\03"+f.X+"\03"+f.Y)}else{WebDragDropEngine.ExecuteFlyPostback(a,"DragDrop",f)}}}},OnDragEnter:function(f,d){var b=f.DragObject.Owner;var c=d.Owner;var a=d.Owner.Parent;ISDragDropEngine.CommonDragEnter(f,d);if(b.CustomInterface){b.CustomInterface.OnDragEnter(f,d)}if(c.CustomInterface){c.CustomInterface.OnDragEnter(f,d)}return ISEvent.Raise(a.ClientSideEvents.OnDragEnter,a.Id,f,d)},OnDragLeave:function(c){var b=c.Owner;var a=b.Parent;if(b.CustomInterface){b.CustomInterface.OnDragLeave(c)}if(c.IsSubObject){ISDragDropEngine.ClearTooltip(c)}ISEvent.Raise(a.ClientSideEvents.OnDragLeave,a.Id,c)},OnDragStart:function(c){var b=c.Owner;var a=b.Parent;if(a.GlobalCoordResolver!=null){if(a.GlobalCoordResolver.Type=="WebDesktopManagerCoordResolver"){var d=ISDragDropEngine.SuspendedDropables;for(var e=0;e<d.length;e++){d[e].Enabled=true}ISDragDropEngine.SuspendedDropables=new Array()}}if(b.CustomInterface){b.CustomInterface.OnDragStart(c)}ISEvent.Raise(a.ClientSideEvents.OnDragStart,a.Id,c)},OnDragEnd:function(c){var b=c.Owner;var a=b.Parent;if(a.GlobalCoordResolver!=null){a.GlobalCoordResolver.Cache=null;if(a.GlobalCoordResolver.Type=="WebDesktopManagerCoordResolver"){a.ClearDropControlCache()}}if(b.CustomInterface){b.CustomInterface.OnDragEnd(c)}ISEvent.Raise(a.ClientSideEvents.OnDragEnd,a.Id,c)},OnShadowCreate:function(c){var b=c.Owner;var a=b.Parent;if(b.CustomInterface){b.CustomInterface.OnShadowCreate(c)}ISEvent.Raise(a.ClientSideEvents.OnShadowCreate,a.Id,c)},ExecuteFlyPostback:function(b,a,d){b.XmlReq=ISXmlHttpEngine.CreateRequestXml(b.GetType());var f=ISXml.GetNode(b.XmlReq,"//request");f.setAttribute("id",b.Id);f.setAttribute("action",a);f.setAttribute("dragControlID",d.DragObject.Owner.ControlID);f.setAttribute("effect",d.Effect);f.setAttribute("allowedEffects",d.AllowedEffects);f.setAttribute("data",d.Data);f.setAttribute("effectText",d.EffectText);f.setAttribute("keyState",d.KeyState);f.setAttribute("x",d.X);f.setAttribute("y",d.Y);b.XmlHttp.Send()},OnResponse:function(a,b){if(!ISEvent.Raise(a.OnClientResponse,a.Id,b)){return}},OnResponseError:function(a,b){alert("Error occured:"+b)}};function WebDragDropDestructor(){IS.RegisterUnloadVariables("WebDragDropEngine");window.detachEvent("onunload",WebDragDropDestructor)}window.attachEvent("onunload",WebDragDropDestructor);