function InitWebFlyPostBackManager(a){return WebFlyPostBackManagerEngine.Create(a)}function WebFlyPostBackManagerClientSideEvents(){this._Type="WebFlyPostBackManagerClientSideEvents";ISObject.call(this);this.OnResponse=null;this.OnError=null;this.OnResponseSuccess=null;this.OnTimeout=null;this.OnResponseCompleted=null}function WebFlyPostBackMethodData(){this._Type="WebFlyPostBackMethodData";ISObject.call(this);this.Id=null;this.Name=null;this.XmlHttp=null;this.Status="NotSet";this.OnResponseSuccess=null;this.CustomAction=false;this.TimeoutId=null;this.Params=[];this.LastParam=null}function WebFlyPostBackManagerSettings(){IFlyPostBack.call(this,"WebFlyPostBackManager");this.PostViewState=false;this.PostHiddenFields=false;this.PostInputControls=false;this.PostControlState=false;this.SelectiveControlsForHiddenFields=new Array()}function WebFlyPostBackManager(a){this.ClassName="WebFlyPostBackManager";this.RequiredFrameworkVersion="1.0.0000.1";ISControl.call(this,a);IFlyPostBack.call(this,"WebFlyPostBackManager");this.PostViewState=false;this.PostHiddenFields=false;this.PostInputControls=false;this.PostControlState=false;this.FlyPostBackSettings=new WebFlyPostBackManagerSettings();this.ClassName="WebFlyPostBackManager";this.Enabled=true;this.ServiceType="WebForm";this.ServiceUrl="";this.Asynchronous=true;this.AutoLoadMetaData=true;this.AutoEventWireup=false;this.MetadataCollecting=false;this.MetadataCollected=false;this.XmlNamespace="WebFlyPostBackManager";this.ClientSideEvents=new WebFlyPostBackManagerClientSideEvents();this.XmlReq=null;this.Metadata=null;this.ParentPage=null;this.TimeoutInterval=60;this.ShowLoaderOnBusy=false;this.LoaderHostControlID="";this.BlockPageUIOnBusy=false;this.LoaderHostControl=null;this.EnableUIMode=false;this.UpdateMode="AllControls";this.UpdateControls=new Array();this.IsLoaderInitialized=false;this.IsSubmitPostBack=false;this.SubmitButtonElement=null;this.WebServiceResponseFormat="Soap";this.CacheParameterizedRequest=false;this.ImageButtonOffset=new OffsetLocation();this._ServiceUrl="";this._Asynchronous=true;this._ISXmlHttp=null;this._QueueMethod=new Array();this._MethodsData=new Object();this._TempSynchronousValue=null;this._TempSynchronousMethod=null;this._IsErrorInSynchronous=false;this._IsWebFormAutoLoadMetadata=false;this.OnUnload=function(){WebFlyPostBackManagerEngine._OnUnload(this);this.Unloaded=true};this.OnPostBack=function(d,c,b){return FPBUIEngine.OnPostBack(this,d,c,b)};this.OnFlyPostBackResponse=function(b){FPBUIEngine.OnInitialize(this);if(this.ClientSideEvents!=null){return ISEvent.Raise(this.ClientSideEvents.OnResponseCompleted,this.Id,b)}}}function UpdateControl(){this._Type="UpdateControl";this.ControlID=""}var pWPBM=WebFlyPostBackManager.prototype;pWPBM.OnResponse=function(a){return WebFlyPostBackManagerEngine.OnResponse(this,a)};pWPBM.OnResponseError=function(a){return WebFlyPostBackManagerEngine.OnResponseError(this,a)};pWPBM._OnMetadataRetrieved=function(a){WebFlyPostBackManagerEngine._OnMetadataRetrieved(this,a)};pWPBM.OnInitialize=function(){WebFlyPostBackManagerEngine.OnInitialize(this)};pWPBM.CollectMetadata=function(){return WebFlyPostBackManagerEngine.CollectMetadata(this)};pWPBM.Invoke=function(){var b=new Array();for(var a=1;a<arguments.length;a++){b[b.length]=arguments[a]}return WebFlyPostBackManagerEngine.Invoke(this,arguments[0],b)};pWPBM._Invoke=function(c,a){var d=new Array();for(var b=0;b<a.length;b++){d[d.length]=a[b]}return WebFlyPostBackManagerEngine.Invoke(this,c,d)};pWPBM.GetStatus=function(a){return WebFlyPostBackManagerEngine.GetStatus(this,a)};pWPBM.Abort=function(a){return WebFlyPostBackManagerEngine.Abort(this,a)};pWPBM.IsMethodExist=function(){return WebFlyPostBackManagerEngine.IsMethodExist(this,methodName)};pWPBM.CreateNewMethod=function(a){WebFlyPostBackManagerEngine.CreateNewMethod(this,a)};pWPBM.DeleteMethod=function(a){WebFlyPostBackManagerEngine.DeleteMethod(this,a)};pWPBM._RaiseOnResponseSuccessEvent=function(a,b){return WebFlyPostBackManagerEngine._RaiseOnResponseSuccessEvent(this,a,b)};pWPBM._RaiseOnTimeoutEvent=function(a){return WebFlyPostBackManagerEngine._RaiseOnTimeoutEvent(this,a)};pWPBM.InvokeCustomAction=function(a,b){return WebFlyPostBackManagerEngine.InvokeCustomAction(this,a,b)};pWPBM.GetLoaderElement=function(){var a=document.getElementById(this.Id+"_Loader");return a};pWPBM.InitializeLoader=function(){if(this.LoaderHostControl==null&&this.LoaderHostControlID!=""){this.LoaderHostControl=document.getElementById(this.LoaderHostControlID)}if(this.LoaderHostControl==null&&this.LoaderHostControlID!=""){alert("LoaderHost control ID '"+this.LoaderHostControlID+"' cannot be found in this page.")}else{var a=this.GetLoaderElement();if(a!=null&&this.LoaderHostControl!=null){this.LoaderHostControl.appendChild(a)}}this.IsLoaderInitialized=true};pWPBM.ShowLoader=function(){var a=this.GetLoaderElement();if(a!=null){a.style.display=""}};pWPBM.HideLoader=function(){var a=this.GetLoaderElement();if(a!=null){a.style.display="none"}};pWPBM.IsBusy=function(a){return WebFlyPostBackManagerEngine.IsBusy(this,a)};pWPBM.IsCallBackControl=function(c){if(this.UpdateMode=="AllControls"){return true}else{for(var b=0;b<this.UpdateControls.length;b++){var a=this.UpdateControls[b];if(a.ControlID==c){return true}}}return false};var WebFlyPostBackManagerEngine={Create:function(b){var a=ISGetObject(b);if(a!=null){return a}a=new WebFlyPostBackManager(b);WebFlyPostBackManagerEngine.AssignProperties(a);WebFlyPostBackManagerEngine.CheckConstraints(a);WebFlyPostBackManagerEngine.OnInitialize(a);return a},CheckConstraints:function(a){if(a.ServiceUrl==""&&!a.EnableUIMode){a.Enabled=false}},AssignProperties:function(a){var b=a.XmlDt.documentElement;if(b!=null){IS.SetPropertiesRecursive(a,b)}if(a.Events!=null){for(key in a.Events){a.ClientSideEvents[key]=a.Events[key]}}WebFlyPostBackManagerEngine._ExtractMetadataNode(a,ISXml.GetNode(a.XmlDt,"//MetadataProperty"));if(a.ServiceType=="WebForm"){WebFlyPostBackManagerEngine.MappingMetadata(a)}if(a.FlyPostBackSettings!=null){a.PostViewState=a.FlyPostBackSettings.PostViewState;a.PostHiddenFields=a.FlyPostBackSettings.PostHiddenFields;a.PostInputControls=a.FlyPostBackSettings.PostInputControls;a.PostControlState=a.FlyPostBackSettings.PostControlState}},RegisterBehavior:function(a){if(a.EnableUIMode){Listener.Add(document.forms[0],"onsubmit",FPBUIEngine.OnSubmit,a)}},_ExtractMetadataNode:function(a,b){if(b!=null){var c=ISXml.CreateXmlDocument();ISXml.LoadXml(c,b.text);c.setProperty("SelectionNamespaces",'xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:tm="http://microsoft.com/wsdl/mime/textMatching/" xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:mime="http://schemas.xmlsoap.org/wsdl/mime/" xmlns:tns="http://tempuri.org/" xmlns:s="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://schemas.xmlsoap.org/wsdl/soap12/" xmlns:http="http://schemas.xmlsoap.org/wsdl/http/" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/"');a.Metadata=c}},OnInitialize:function(a){WebFlyPostBackManagerEngine._CheckServiceUrl(a);if(a.ServiceType=="WebForm"){if(a._IsWebFormAutoLoadMetadata==false){WebFlyPostBackManagerEngine.CollectMetadata(a)}else{WebFlyPostBackManagerEngine.MappingMetadata(a);a._ServiceUrl=a.ServiceUrl;a._Asynchronous=a.Asynchronous}FPBWebFormEngine.Initialize(a)}else{if(a.AutoLoadMetaData==true&&a.ServiceType=="WebService"){if(a.Metadata==null){WebFlyPostBackManagerEngine.CollectMetadata(a)}else{a.MetadataCollecting=true;WebServiceEngine.RetrieveMetadata(a,a.Metadata)}}WebServiceEngine.Initialize(a)}FPBUIEngine.OnInitialize(a)},_ConvertWebFormResultToXml:function(a,b){if(a.ServiceType=="WebForm"){if(b.toString().indexOf("<html>")==0&&b.toString().indexOf("Server Error")>-1){return b}else{var c=ISXml.CreateXmlDocument();ISXml.LoadXml(c,b.toString().replace('<?xml version="1.0" encoding="utf-8"?>',""));return c}}else{return b}},OnResponse:function(a,d){var e=d;if(a.MetadataCollecting){WebFlyPostBackManagerEngine._OnMetadataRetrieved(a,d);return}var g=false;d=WebFlyPostBackManagerEngine._ConvertWebFormResultToXml(a,d);var c=WebFlyPostBackManagerEngine._GetMethodNameByResultObject(a,d);FPBUIEngine.OnResponse(a);if(c!=null){var b=a._MethodsData[c];b.Status="OnResponse";if(b.TimeoutId!=null){window.clearTimeout(b.TimeoutId)}b.TimeoutId=null;if(a.CacheParameterizedRequest){var f=WebFlyPostBackManagerEngine.GetStringifiedParameters(b.LastParam);var h=ISXml.CreateXmlDocument();if(b.Params[f]==null){ISXml.LoadXml(h,e);b.Params[f]=h}}}if(a.ServiceType=="WebForm"){g=FPBWebFormEngine.OnResponse(a,c);if(g){a._MethodsData[c].Status="OnResponseSuccess";g=FPBWebFormEngine.OnResponseSuccess(a,d,c)}}else{g=WebServiceEngine.OnResponse(a,c);if(g){a._MethodsData[c].Status="OnResponseSuccess";g=WebServiceEngine.OnResponseSuccess(a,d,c)}}return g},OnResponseError:function(a,c){if(a.MetadataCollecting){a.MetadataCollecting=false}if(a.ServiceType=="WebForm"&&a.Asynchronous==false){a._IsErrorInSynchronous=true}var d=false;c=WebFlyPostBackManagerEngine._ConvertWebFormResultToXml(a,c);var b;if(typeof(c)!="string"){b=WebFlyPostBackManagerEngine._GetMethodNameByResultObject(a,c)}if(b!=""&&b!=null){if(a._MethodsData[b].Status=="Timeout"){return}a._MethodsData[b].Status="OnResponse"}if(a.ServiceType=="WebForm"){d=FPBWebFormEngine.OnResponse(a,b);if(d){if(b!=""&&b!=null){a._MethodsData[b].Status="OnResponseError"}d=FPBWebFormEngine.OnResponseError(a,c,b);if(d&&a.EnableUIMode){if(typeof(c)=="string"){alert("Exception thrown from server side:\n"+c)}else{if(typeof(c)=="object"&&c.xml==""){alert("There is no content returned from server side. Most likely cause is server time out.")}}FPBUIEngine.OnResponse(a)}}}else{d=WebServiceEngine.OnResponse(a,b);if(d){if(b!=""&&b!=null){a._MethodsData[b].Status="OnResponseError"}d=WebServiceEngine.OnResponseError(a,c,b)}}return d},_OnMetadataRetrieved:function(a,b){if(a.MetadataCollecting){WebFlyPostBackManagerEngine._CollectedMetadata(a,b)}},CollectMetadata:function(a){if(!a.Enabled){return false}if(a.MetadataCollecting){return true}if(a.ServiceUrl!=""&&(a.MetadataCollected==false||a.ServiceUrl!=a._ServiceUrl||a._Asynchronous!=a.Asynchronous)){a.MetadataCollecting=true;WebFlyPostBackManagerEngine.RetrieveMetadata(a);return true}else{return false}},_CollectedMetadata:function(a,b){WebFlyPostBackManagerEngine.ClearMetadata(a);if(typeof(b)=="string"){var c=ISXml.CreateXmlDocument();ISXml.LoadXml(c,b);a.Metadata=c}else{a.Metadata=b}WebFlyPostBackManagerEngine.MappingMetadata(a);a._ServiceUrl=a.ServiceUrl;a._Asynchronous=a.Asynchronous;if(a.Asynchronous){WebFlyPostBackManagerEngine._InvokeQueueMethod(a,false)}},ClearMetadata:function(a){if(a.ServiceType=="WebForm"){FPBWebFormEngine.ClearMetadata(a)}else{WebServiceEngine.ClearMetadata(a)}if(a.MetadataCollected==false){var d=a._MethodsData;var c=d.length;for(var b=c-1;b>=0;b--){delete d[b]}}},MappingMetadata:function(a){WebFlyPostBackManagerEngine._CheckServiceUrl(a);if(a.ServiceType=="WebForm"){FPBWebFormEngine.MappingMetadata(a)}else{WebServiceEngine.MappingMetadata(a)}},_CheckServiceUrl:function(a){if(a.ServiceUrl!=null){if(a.ServiceUrl.indexOf("/")==0){var b=window.location.protocol+"//"+window.location.host;a.ServiceUrl=a._ServiceUrl=b+a.ServiceUrl}}},RetrieveMetadata:function(a){if(a.ServiceType=="WebForm"){return FPBWebFormEngine.RetrieveMetadata(a)}else{return WebServiceEngine.RetrieveMetadata(a)}},GetStringifiedParameters:function(c){var d="";for(var a=0;a<c.length;a++){var b=c[a];if(typeof(b)!="object"){d+=b.toString()}else{if(b==null){d+="null"}}}return d},InvokeCustomAction:function(b,a,e){if(b.ServiceType!="WebForm"){return null}if(!b.Enabled){return null}if(b.Asynchronous==false){b._IsErrorInSynchronous=false;b._TempSynchronousMethod=methodName}WebFlyPostBackManagerEngine.CollectMetadata(b);var d=new Array();d[0]=e;var c=b._MethodsData[a];if(c==null){b.CreateNewMethod(a);c=b._MethodsData[a].CustomAction=true}if(b.Asynchronous){WebFlyPostBackManagerEngine._InvokeAsynchronous(b,a,d)}else{return WebFlyPostBackManagerEngine._InvokeSynchronous(b,a,d)}return null},Invoke:function(){var b=arguments[0];var e=arguments[1];if(!b.Enabled){return}if(b.Asynchronous==false){b._IsErrorInSynchronous=false;b._TempSynchronousMethod=e}WebFlyPostBackManagerEngine.CollectMetadata(b);var f=new Array();for(var c=0;c<arguments[2].length;c++){if((c+1)==arguments[2].length&&typeof(arguments[2][c])=="function"){b._MethodsData[e].OnResponseSuccess=arguments[2][c]}else{f[f.length]=arguments[2][c]}}if(b.CacheParameterizedRequest){var d=WebFlyPostBackManagerEngine.GetStringifiedParameters(f);if(d!=""&&b._MethodsData[e]!=null&&b._MethodsData[e].Params[d]!=null){var a=b._MethodsData[e].Params[d];if(a.xml!=""){setTimeout(function(){b.OnResponse(a.xml);ISXmlHttpEngine.ProcessClientActions(a);ISXmlHttpEngine.InvokeGeneralResponse(a)},10);return true}}b._MethodsData[e].LastParam=f}if(b.Asynchronous){WebFlyPostBackManagerEngine._InvokeAsynchronous(b,e,f)}else{return WebFlyPostBackManagerEngine._InvokeSynchronous(b,e,f)}return null},_InvokeAsynchronous:function(b,c,d){if(b.MetadataCollected){if(!WebFlyPostBackManagerEngine.IsMethodExist(b,c)){WebFlyPostBackManagerEngine._RemoveQueueMethod(b,c);var a=new Object();a.code="client";a.string="web method not available";a.raw=null;WebFlyPostBackManagerEngine.OnResponseError(b,a);return false}b._MethodsData[c].Status="Invoking";b._MethodsData[c].TimeoutId=window.setTimeout("RaiseFPBManagerTimeout('"+b.Id+"','"+c+"')",b.TimeoutInterval*1000);FPBUIEngine.OnInvoke(b);if(b.ServiceType=="WebForm"){return FPBWebFormEngine.Invoke(b,c,d)}else{return WebServiceEngine.Invoke(b,c,d)}}else{WebFlyPostBackManagerEngine._AddQueueMethod(b,c,d)}},_InvokeSynchronous:function(a,b,c){if(a._IsErrorInSynchronous){return null}if(a.MetadataCollected){a._MethodsData[b].Status="Invoking";a._MethodsData[b].TimeoutId=window.setTimeout("RaiseFPBManagerTimeout('"+a.Id+"','"+b+"')",a.TimeoutInterval);if(a.ServiceType=="WebForm"){return FPBWebFormEngine.Invoke(a,b,c)}else{return WebServiceEngine.Invoke(a,b,c)}}else{return null}},IsMethodExist:function(a,b){return typeof(a[b])=="function"},_AddQueueMethod:function(a,b,c){if(WebFlyPostBackManagerEngine._IsMethodQueued(a,b,c)==false){a._QueueMethod[a._QueueMethod.length]=new Array(b,c,a.ServiceUrl,a.Asynchronous)}},_RemoveQueueMethod:function(a,b){var c=a._QueueMethod;for(key in c){if(key==b){delete a[b];delete c[b];break}}},_IsMethodQueued:function(a,d,e){var g=a._QueueMethod;var b=false;if(g.length>0){for(key in g){if(g[key][0]==d&&g[key][2]==a.ServiceUrl){var f=g[key][1];if(f.length==e.length){for(var c=0;c<e.length;c++){if(f[c]!=e[c]){b=true;break}}if(b==true){break}}}}}return b},_InvokeQueueMethod:function(a,c){var e=a._QueueMethod;var d;var b=false;for(key in e){d=e[key];if(d[2]==a.ServiceUrl){if(c==false){if(d[3]==true){delete e[key];a._Invoke(d[0],d[1])}else{if(d[3]==false){if(b==false){delete e[key];a._Invoke(d[0],d[1])}else{b=true}}}}else{if(d[3]==false){if(b==false){delete e[key];a._Invoke(d[0],d[1])}else{break}}}}}},GetStatus:function(a,b){if(WebFlyPostBackManagerEngine.IsMethodExist(a,b)){return a._MethodsData[b].Status}else{return null}},Abort:function(a,c){if(WebFlyPostBackManagerEngine.IsMethodExist(a,c)){var b=a._MethodsData[c];if(b.Status=="Invoking"){var d=b.XmlHttp;if(d!=null){d.abort()}}}},CreateNewMethod:function(a,b){a[b]=function(){return this._Invoke(b,arguments)};WebFlyPostBackManagerEngine._CreateMethodData(a,b)},_CreateMethodData:function(a,c){if(c==""||c==null){return}var b=new WebFlyPostBackMethodData();b.Name=c;if(a.ServiceType=="WebForm"){b.XmlHttp=ISXmlHttpEngine.Create(a)}a._MethodsData[c]=b},DeleteMethod:function(a,b){if(b==""||b==null){return}if(WebFlyPostBackManagerEngine.IsMethodExist(a,b)){delete a[b];delete a._MethodsData[b]}},_GetMethodNameByResultObject:function(a,b){if(a.ServiceType=="WebForm"){return FPBWebFormEngine._GetMethodNameByResultObject(a,b)}else{return WebServiceEngine._GetMethodNameByResultObject(a,b)}},_RaiseOnTimeoutEvent:function(a,c){var b=a._MethodsData[c];if(b.Status=="Invoking"){window.clearTimeout(a._MethodsData[c].TimeoutId);b.Status="Timeout";var d=b.XmlHttp;if(d!=null){if(a.ServiceType=="WebService"){d.abort()}else{d.XmlHttp.abort()}}}if(a.ClientSideEvents!=null){return ISEvent.Raise(a.ClientSideEvents.OnTimeout,a.Id,c)}else{return true}},_RaiseOnResponseSuccessEvent:function(fpb,methodName,val){var returnValue=true;if(fpb.AutoEventWireup){var funct=fpb.Id+"_On"+methodName;var hasWiredEvent=true;if(eval("typeof("+funct+")")!="function"){if(fpb.Id.indexOf("_")>-1){funct=fpb.Id.substring(fpb.Id.lastIndexOf("_")+1)+"_On"+methodName;if(eval("typeof("+funct+")")!="function"){hasWiredEvent=false}}else{hasWiredEvent=false}}if(hasWiredEvent){returnValue=ISEvent.Raise(funct,val)}}else{var fp=fpb._MethodsData[methodName].OnResponseSuccess;if(fp!=null){fp(val)}fpb._MethodsData[methodName].OnResponseSuccess=null}if(returnValue){if(fpb.ClientSideEvents!=null){return ISEvent.Raise(fpb.ClientSideEvents.OnResponseSuccess,fpb.Id,methodName,val)}else{return true}}else{return false}},IsBusy:function(b,e){var c=b.MetadataCollecting;if(!c){var a;if(e==null||e==""){var d;for(d in b._MethodsData){a=b._MethodsData[d];if(a.Status=="Invoking"||a.Status=="Response"){c=true;break}}}else{pp=b._MethodsData[e];c=(a.Status=="Invoking"||a.Status=="Response")}}return c},_OnUnload:function(a){if(a.ServiceType=="WebForm"){return FPBWebFormEngine.OnUnload(a)}else{return WebServiceEngine.OnUnload(a)}}};var FPBUIEngine={_Blocker:null,OnInitialize:function(a){if(a.EnableUIMode&&a.Enabled){var c=document.getElementsByTagName("input");for(var b=0;b<c.length;b++){if(c[b].type=="submit"||c[b].type=="image"){if(!c[b].clickWired){var d=null;if(c[b].type=="image"){d=c[b].onclick}c[b].onclick=function(){if(d!=null){d()}DoButtonSubmit(a.Id)};c[b].clickWired=true}}}if(a.ServiceUrl==""){a.ServiceUrl=document.forms[0].action}}},OnInvoke:function(b){if(b.ShowLoaderOnBusy){if(!b.IsLoaderInitialized){b.InitializeLoader()}b.ShowLoader()}if(b.BlockPageUIOnBusy){var a=FPBUIEngine.GetBlockerElement();a.style.display="";a.style.cursor="wait"}},OnResponse:function(b){if(b.ShowLoaderOnBusy){b.HideLoader()}if(b.BlockPageUIOnBusy){var a=FPBUIEngine.GetBlockerElement();a.style.cursor="";a.style.display="none"}},OnPostBack:function(d,c,b,a){if(!d.Enabled){return true}if(d.EnableUIMode){if(b!=""&&!d.IsCallBackControl(b)){return true}if(c.__EVENTTARGET){c.__EVENTTARGET.value=b.split("$").join(":")}if(c.__EVENTARGUMENT){c.__EVENTARGUMENT.value=a}d.AdditionalInputs=new Array();if(d.IsSubmitPostBack){d.AddInput(d.SubmitButtonElement.name,d.SubmitButtonElement.value);if(d.SubmitButtonElement.type=="image"){d.AddInput(d.SubmitButtonElement.name+".x",d.ImageButtonOffset.X.toString());d.AddInput(d.SubmitButtonElement.name+".y",d.ImageButtonOffset.Y.toString())}}d.InvokeCustomAction("UIFlyPostBack");d.IsSubmitPostBack=false;d.SubmitButtonElement=null;return false}},OnSubmit:function(a,b){if(!a.IsCallBackControl(b.id)){return true}a.IsSubmitPostBack=true;a.SubmitButtonElement=b;event.cancelBubble=true;event.returnValue=false;__doPostBack("","")},GetBlockerElement:function(b){if(FPBUIEngine._Blocker==null){var a=document.createElement("DIV");a.type="BusyLayer";a.style.cssText="position:absolute; top:0px; left:0px; width:100%; height:100%; cursor:wait; z-index: 1; display:none";a.style.width=document.body.clientWidth;if(IS.ie){a.style.filter="Alpha(Opacity=0)";a.style.backgroundColor="white"}document.body.insertAdjacentElement("afterBegin",a);FPBUIEngine._Blocker=a}return FPBUIEngine._Blocker}};function RaiseFPBManagerTimeout(b,c){var a=ISGetObject(b);if(a!=null){a._RaiseOnTimeoutEvent(c)}}function DoButtonSubmit(c){var b=ISGetObject(c);var a=event.srcElement;if(a.type=="image"){b.ImageButtonOffset.X=event.clientX-ISPosLib.getLeft(a);b.ImageButtonOffset.Y=event.clientY-ISPosLib.getTop(a)}FPBUIEngine.OnSubmit(b,a)};