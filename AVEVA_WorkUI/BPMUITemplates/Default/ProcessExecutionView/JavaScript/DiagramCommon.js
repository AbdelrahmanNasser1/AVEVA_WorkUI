var _skBrowser=new _skO(); var _sko=null; var Debugger=null; var _skY=null; var _sky=null; function SkInitialize(){_skI(); _ski(); Debugger=new _skA(); }function _ski(){if (typeof PDControlID=="\x75\x6edefin\x65d"){if (window.top._skProcessDesigner){_sky=window.top._skProcessDesigner._sky; _skY=window.top.document.getElementById(_sky); }return; }_sky=PDControlID+"_topc\x61\x6e\x76\x61s"; if (window.top.document.getElementById(_sky)){_skY=window.top.document.getElementById(_sky); return; }_skY=window.top.document.createElement("div"); _skY.id=_sky; _skY.style.position="\141bsolute"; _skY.style.left=0; _skY.style.top=0; window.top.document.body.appendChild(_skY); }function _ska(){if (_sky){var _skE=window.top.document.getElementById(_sky); if (_skE)removeNode(_skE); }_skY=null; _sky=null; }function _skO(){var b=navigator.appName; if (b=="\x4ee\x74scape")this.b="\x6e\x73"; else if (b=="\x4d\x69crosof\x74 Inte\x72net E\x78plore\x72")this.b="\x69e"; else this.b=b; this._ske=parseInt(navigator.appVersion); this.ns=(this.b=="\x6e\x73" && this._ske>=4); this.ns4=(this.b=="\x6es" && this._ske==4); this.ns5=(this.b=="ns" && this._ske==5); this.ns7plus=(this.b=="ns" && navigator.vendorSub && parseFloat(navigator.vendorSub)>=7); this.ie=(this.b=="ie" && this._ske>=4); this.ie4=(navigator.userAgent.indexOf("MSIE \x34")>0); this.ie5=(navigator.userAgent.indexOf("MSIE\x205")>0); this.ie6=(navigator.userAgent.indexOf("\115\x53I\x45\x20\x36")>0); this.ie5plus=document.getElementById && this.ie; this.iemac=!!(this.ie && navigator.userAgent.toLowerCase().indexOf("m\x61c")>=0); if (this.ie5)this._ske=5; this.firefox=(navigator.userAgent.toLowerCase().indexOf("\146\x69r\x65\146\x6fx")!=-1) && !this.ie; this.firefox1plus=this.firefox && this._ske>1; this.min=(this.ns || this.ie); if (this.ie5plus || this.firefox1plus || this.ns7plus)this._skU= true; else this._skU= false;}function _skA(){ this._sku= false; var _skZ,_skz=0,_skX,_skx,_skW,_skw,_skV; var _skv; this._skT= function (){_skZ=null; _skv=null; window.top.SkeltaDebugger=null; this._sku= false; };this._skt= function (){if (window.top.SkeltaDebugger){_skv=window.top.SkeltaDebugger; return true; }return false; };this.SwitchOn= function (){if (this._sku)return; if (this._skt()){return; }window.top.SkeltaDebugger=this ; _skW=0372; _skw=0372; _skS(document.body,"\x3c\x64iv i\x64=debug\x5fNode s\x74yle=\x27overfl\x6fw: a\x75to; \x50OS\x49TIO\x4e: \x61bs\x6flut\x65; \x7a-in\x64ex\x3a 9\x3999\x39; l\x65ft\x3d60\x30px\x3b t\x6fp=1\x30px\x3b w\x69dt\x68: \x3250p\x78; \x68ei\x67ht\x3a 2\x350p\x78; \x46ON\x54-S\x49ZE\x3a \x78x-\x73ma\x6cl;\x20CO\x4cO\x52: \x62la\x63k;\x20FO\x4eT\x2dFA\x4dIL\x59: \x56er\x64a\x6ea,\x20Ar\x69al\x3b \x62or\x64e\x72-s\x74yl\x65: \x73o\x6cid\x20d\x6fub\x6ce\x27 >\x3c/d\x69v\x3e"); _skZ=document.getElementById("d\x65bug\x5f\116\x6fde"); _skV="\x62ot\x74\157\x6drigh\x74"; this._sks(); this._sku= true; this.Write("<div align=center><b><--@@SkeltaDebugConsole@@--><b></div><br>"); };this.SwitchOff= function (){if (!this._sku)return; this._sku= false; _skR=null; removeNode(document.getElementById("\x64\x65bug_N\x6fde")); };this.WriteLine= function (message){if (this._sku && _skZ){_skz++; _skS(_skZ,_skz+"\x2d"+message+"\074br>"); _skZ.scrollTop+=024; }else {if (!_skv){ this._skt(); }if (_skv)_skv.WriteLine(message); }};this.Write= function (message){if (this._sku && _skZ){_skS(_skZ,message); }else {if (!_skv){ this._skt(); }if (_skv)_skv.Write(message); }};this.WriteError= function (message){ this.WriteLine("\x3c\142>"+message+"\x3c\x2fb>"); };this.Reposition= function (_skr){_skV=_skr; this._sks(); };this._sks= function (){if (_skZ){if (_skV=="botto\x6drig\x68t"){_skZ.style.left=document.body.clientWidth-_skW-012; var _skQ=0; if (document.body.clientHeight==0){try {_skQ=frameElement.offsetHeight; }catch (_skq){}}else _skQ=document.body.clientHeight; _skZ.style.top=_skQ-_skw-012; }if (_skV=="\x62\x6f\x74to\x6dleft"){_skZ.style.left=0; _skZ.style.top=document.body.clientHeight-_skw-012; }if (_skV=="\x74\x6fpleft"){_skZ.style.left=0; _skZ.style.top=0; }if (_skV=="to\x70rig\x68\164"){_skZ.style.left=document.body.clientWidth-_skW-012; _skZ.style.top=0; }if (_skV=="\x74o\x70\155\x69ddle"){_skZ.style.left=(document.body.clientWidth/2)-(_skW/2); _skZ.style.top=0; }if (_skV=="\x62ott\x6fmmiddl\x65"){_skZ.style.left=(document.body.clientWidth/2)-(_skW/2); _skZ.style.top=document.body.clientHeight-_skw-012; }if (_skV=="mi\x64dle"){_skZ.style.left=(document.body.clientWidth/2)-(_skW/2); _skZ.style.top=(document.body.clientHeight/2)-(_skw/2); }}};}function _skI(){if (!_skBrowser.ie){var _skP=document.createElement("\x64iv"); _skP.id="\x72\x44\151\x76"; document.body.appendChild(_skP); _sko=document.createRange(); _sko.selectNode(_skP); }}function _skS(_skp,data){if (_skBrowser.ie){_skp.insertAdjacentHTML("bef\x6freEn\x64",data); }else {if (!_sko)_skI(); var _skN=_sko.createContextualFragment(data); _skp.appendChild(_skN); }}function removeNode(_skp){if (_skBrowser.ie){_skp.removeNode( true); return; }var self=_skp; var i; for (i=0; i<_skp.childNodes.length; i++){_skp.removeChild(_skp.childNodes[i]); }_skp.parentNode.removeChild(self); self=null; return; }function findPosX(_skE){var _skn=0; if (_skE.offsetParent){while (_skE.offsetParent){_skn+=_skE.offsetLeft;_skE=_skE.offsetParent; }}else if (_skE.x)_skn+=_skE.x; return _skn; }function findPosY(_skE){var _skM=0; if (_skE.offsetParent){while (_skE.offsetParent){_skM+=_skE.offsetTop;_skE=_skE.offsetParent; }}else if (_skE.y)_skM+=_skE.y; return _skM; }function _skm(_skE){var _skn=0; if (_skE.offsetParent){while (_skE.offsetParent){_skn+=_skE.offsetLeft-_skE.scrollLeft; _skE=_skE.offsetParent; }}else if (_skE.x)_skn+=_skE.x; return _skn; }function _skL(_skE){var _skM=0; if (_skE.offsetParent){while (_skE.offsetParent){_skM+=_skE.offsetTop-_skE.scrollTop; _skE=_skE.offsetParent; }}else if (_skE.y)_skM+=_skE.y; return _skM; }function findPosFrameX(_skl){var _skK=0; while (_skl.parent && _skl.frameElement){_skK+=findPosX(_skl.frameElement);_skl=_skl.parent; }return _skK; }function findPosFrameY(_skl){var _skk=0; while (_skl.parent && _skl.frameElement){_skk+=findPosY(_skl.frameElement);_skl=_skl.parent; }return _skk; }function HideToolTip(){var _skJ=window.top.document.getElementById(""+_sky+"\x5f\x73kshimif\x74ooltip"); var _skj=window.top.document.getElementById(_sky+"_d\x68\x74mlto\x6fl\x74ip"); var _skH=window.top.document.getElementById(_sky+"_dh\x74\x6dl\x70o\x69nt\x65r"); _skJ.style.visibility="\x68i\x64\144\x65n"; _skJ.style.display="non\x65"; _skj.style.visibility="\x68\x69dden"; _skj.style.display="\x6e\x6f\156\x65"; _skH.style.visibility="\x68\x69\x64d\x65n"; _skH.style.display="n\x6fne"; }function _skh(){if (window.top.document.getElementById(_sky+"\x5f\x64htmlto\x6fltip")!=null)return; else _skS(_skY,"\074d\x69v id=\042"+_sky+"\x5f\x64\150\x74mlto\x6f\154\x74ip\042 cl\x61ss=\042sktoo\x6ctip\x22>\074/di\x76>\074img\x20id\x3d\042"+_sky+"\x5f\x64\150\x74mlpo\x69nter\042 sr\x63=\042"+_skG()+"gr\x61phic\x73\057\x74t\x61\162\x77-belo\x77-righ\x74.gif\x22 cla\x73s=\x22sk\x74ool\x74ip\x70oin\x74er\x22>"); }function _skG(){if (typeof _skTemplateDir!="\x75\x6edefin\x65d")return _skTemplateDir+"p\x72oces\x73\144\x65sign\x65r/"; else if (typeof TemplateRoot!="und\x65fine\x64")return TemplateRoot+"processd\x65sig\x6eer/"; else {return window.top._skProcessDesigner._skTemplateDir+"p\x72oces\x73\144\x65sign\x65r/"; }}function ShowToolTip(_skp,message,width){_skh(); var _skg=014; var _skF=012; var _skf=017; var _skD=0; var _skd=0; var _skJ,_skj,_skH; _skJ=window.top.document.getElementById(""+_sky+"\x5f\x73kshimi\x66toolti\x70"); if (_skJ==null){_skS(_skY,"\074ifram\x65 id=\x27"+_sky+"\x5f\x73\153\x73himi\x66\164\x6folt\x69p\047 scrol\x6cing=\x27no\047 f\x72ame\x62or\x64er=\x270\x27 sty\x6ce=\x27ba\x63kgr\x6fun\x64:\x20tr\x61nsp\x61re\x6et;\x20z-\x69nd\x65x: \x3500\x3bpo\x73it\x69on\x3aab\x73ol\x75te\x3b t\x6fp:\x30px;\x20l\x65ft\x3a0p\x78; \x64is\x70la\x79:\x6eon\x65;\047 s\x72c=\x27"+_skG()+"blank.\x68tm\x27>\074/ifram\x65>"); _skJ=window.top.document.getElementById(""+_sky+"_\x73ksh\x69miftoo\x6ctip"); }_skj=window.top.document.getElementById(_sky+"\x5fdhtm\x6ctooltip"); _skH=window.top.document.getElementById(_sky+"\x5fdht\x6d\154\x70oint\x65r"); _skj.innerHTML=message; _skj.style.display="block"; _skH.style.display="\142\x6co\x63\x6b"; _skJ.style.display="block"; width=_skj.offsetWidth; var x=findPosX(_skp); var y=findPosY(_skp); x=_skm(_skp); y=_skL(_skp); x+=(_skp.offsetWidth/2); y+=_skp.offsetHeight; var _skC=findPosFrameX(window); var _skc=findPosFrameY(window); _skC+=x; _skc+=y; var _skB=(_skBrowser.ie)?window.top.document.body.clientWidth:window.top.innerWidth; var _skb=(_skBrowser.ie)?window.top.document.body.clientHeight:window.top.innerHeight; var _sko0=(_skBrowser.ie)?window.top.document.body.scrollTop:window.top.pageYOffset; var _skO0=(_skBrowser.ie)?window.top.document.body.scrollLeft:window.top.pageXOffset; var _skl0=_skB-_skC; var _ski0=_skb-_skc; var _skI0,_sko1,_skO1,_skQ; _skI0=_skO0+_skC; _sko1=_sko0+_skc; _skO1=width; _skQ=_skj.offsetHeight; if (window!=window.top){_skI0=_skI0-document.body.scrollLeft; _sko1=_sko1-document.body.scrollTop; }if (_skp.offsetParent && _skp.offsetParent.scrollLeft && _skp.offsetParent.scrollTop){_skI0=_skI0-_skp.offsetParent.scrollLeft; _sko1=_sko1-_skp.offsetParent.scrollTop;}var _skl1=0,_ski1=0; var _skI1="\x74tar\x77"; if (_ski0<_skQ){_sko1-=_skp.offsetHeight; _ski1=_sko1-_skf; _sko1=_sko1-_skQ-_skf+1; _skI1+="-top"; }else {_ski1=_sko1+_skd; _sko1=_ski1+_skf-1; _skI1+="-belo\x77"; }if (_skl0<width){_skl1=_skI0-_skH.offsetWidth; _skI0=_skI0-_skO1+012; _skI1+="\055\154\x65ft"; }else {_skl1=_skI0+_skD; _skI0=_skl1-012; _skI1+="-right"; }_skI1+="\x2e\x67if"; _skj.style.left=_skI0+"px"; _skj.style.top=_sko1+"\x70\x78"; _skH.style.left=_skl1+"px"; _skH.style.top=_ski1+"\x70\x78"; _skI1=_skG()+"g\x72aph\x69\143\x73/"+_skI1; if (_skH.src!=_skI1)_skH.src=_skI1; _skJ.style.left=_skj.style.left; _skJ.style.top=_skj.style.top; _skJ.style.width=_skj.offsetWidth; _skJ.style.height=_skj.offsetHeight; _skJ.style.display="\142\x6coc\x6b"; _skJ.style.visibility="\x76\x69sible"; _skj.style.visibility="\x76isi\x62\x6ce"; _skH.style.visibility="\x76i\x73\151\x62le"; _skj.style.zIndex=0766; _skH.style.zIndex=0767; }function _sko2(){var _skJ=window.top.document.getElementById(""+_sky+"\x5f\x73kshimif\x74ooltip"); var _skj=window.top.document.getElementById(_sky+"\x5fd\x68\164\x6dltool\x74ip"); var _skH=window.top.document.getElementById(_sky+"_\x64ht\x6d\x6cpo\x69nter"); if (_skH)removeNode(_skH); if (_skj)removeNode(_skj); if (_skJ)removeNode(_skJ); }