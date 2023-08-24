﻿var IE11Engine={_EmulateAttachEvent:function(){var a=Window.prototype;a.attachEvent=HTMLDocument.prototype.attachEvent=HTMLElement.prototype.attachEvent=function(d,b){var c=d.replace(/on/,"");b._ieEmuEventHandler=function(f){window.event=f;if(IS){IS.mozEventType=f.type}if(f){return b(f)}else{return b()}};this.addEventListener(c,b._ieEmuEventHandler,false)};a.detachEvent=HTMLDocument.prototype.detachEvent=HTMLElement.prototype.detachEvent=function(d,b){var c=d.replace(/on/,"");if(typeof b._ieEmuEventHandler=="function"){this.removeEventListener(c,b._ieEmuEventHandler,false)}else{this.removeEventListener(c,b,true)}};if(window.toString().indexOf("ModalContentWindow")>-1){window.attachEvent=a.attachEvent;window.detachEvent=a.detachEvent}},_EmulateDocumentModel:function(){var a=HTMLDocument.prototype;a.createStyleSheet=function(c){var b=document.createElement("STYLE");b.setAttribute("type","text/css");return b};a.createEventObject=function(){return document.createEvent("Events")}},_ExtendEventObject:function(){Object.defineProperty(Event.prototype,"returnValue",{set:function(a){if(!a){this.preventDefault()}this._returnValue=a},get:function(){return this._returnValue}});Object.defineProperty(Event.prototype,"toElement",{get:function(){var a;if(this.type=="mouseout"){a=this.relatedTarget}else{if(this.type=="mouseover"){a=this.target}}if(!a){return}while(a.nodeType!=1){if(a.parentNode==null){break}a=a.parentNode}return a}})},_EmulateElementModel:function(){var p=HTMLElement.prototype;p.fireEvent=function(name,evtObj,srcElement){if(!evtObj){evtObj=this.ownerDocument.createEventObject()}evtObj.initEvent(name.slice(2),false,false);this.dispatchEvent(evtObj);if(srcElement){evtObj.srcElement=srcElement}if(typeof this[name]=="function"){this[name](evtObj)}else{if(this.getAttribute(name)){eval(this.getAttribute(name))}}}},_EmulateSelectionModel:function(){Object.defineProperty(HTMLDocument.prototype,"selection",{get:function(){return window.getSelection()}});Selection.prototype.createRange=function(){var d;try{var b=window.event;var c=b!=null?b.srcElement:document.activeElement;if(c){d=document.createRange();d.setStart(c,0)}}catch(a){}return d};HTMLElement.prototype.createTextRange=function(){var b;if(this.tagName=="INPUT"){b=document.createRange();b.setStart(this,0);try{b.selectionStart=this.selectionStart;b.selectionEnd=this.selectionEnd}catch(a){}}return b};Range.prototype.selectionStart=Range.prototype.selectionEnd=0;Object.defineProperty(Range.prototype,"text",{get:function(){var b=this.commonAncestorContainer;if(IS.safari&&typeof(b.tagName)=="undefined"){b=this.tempObj}if(b!=null&&(b.tagName=="INPUT"||b.tagName=="TEXTAREA")){try{if(b.selectionEnd>b.value.length){this.selectionEnd=b.selectionEnd=b.value.length-1}if(b.selectionStart<0){this.selectionStart=b.selectionStart=0}if(typeof(b.IsSelected)=="undefined"){return(b.selectionEnd-b.selectionStart<=0?"":b.value.substr(b.selectionStart,b.selectionEnd-b.selectionStart))}else{if(b.IsSelected==true){return(b.selectionEnd-b.selectionStart<=0?"":b.value.substr(b.selectionStart,b.selectionEnd-b.selectionStart))}else{if(IS.moz==false&&typeof(b.SelectedSelectionEnd)=="undefined"){return(b.selectionEnd-b.selectionStart<=0?"":b.value.substr(b.selectionStart,b.selectionEnd-b.selectionStart))}else{return(b.SelectedSelectionEnd-b.selectionStart<=0?"":b.value.substr(b.selectionStart,b.SelectedSelectionEnd-b.selectionStart))}}}}catch(a){return b.value}}else{return""}},set:function(b){var a=this.commonAncestorContainer;if(IS.safari&&typeof(a.tagName)=="undefined"){a=this.tempObj}if(a!=null&&(a.tagName=="INPUT"||a.tagName=="TEXTAREA")){if(a.selectionEnd>a.value.length){a.selectionEnd=a.value.length-1;if(IS.moz==false&&typeof(a.SelectedSelectionEnd)!="undefined"){a.SelectedSelectionEnd=a.selectionEnd}}if(a.selectionStart<0){a.selectionStart=0}this.selectionStart=a.selectionStart;this.selectionEnd=a.selectionEnd;if(IS.moz==false&&typeof(a.SelectedSelectionEnd)!="undefined"){a.value=a.value.substr(0,a.selectionStart)+b+a.value.substr(a.selectionStart+b.length)}else{if(a.selectionEnd-a.selectionStart>=0){a.value=a.value.substr(0,a.selectionStart)+b+a.value.substr(a.selectionEnd)}}a.selectionStart=this.selectionStart;a.selectionEnd=this.selectionEnd}}});Range.prototype.duplicate=function(){var a=this.cloneRange();a.selectionStart=this.selectionStart;a.selectionEnd=this.selectionEnd;return a};Range.prototype.select=function(b){var a=this.commonAncestorContainer;if(IS.safari&&typeof(a.tagName)=="undefined"){a=this.tempObj}if(a!=null&&(a.tagName=="INPUT"||a.tagName=="TEXTAREA")){if(b==true){a.selectionStart=this.selectionStart;a.selectionEnd=this.selectionEnd;if(IS.safari||Is.chrome||IS.Opera){a.selectionEnd=a.SelectedSelectionEnd}}a.setSelectionRange(a.selectionStart,a.selectionEnd);this.selectionStart=a.selectionStart;this.selectionEnd=a.selectionEnd}};Range.prototype.move=function(g,c){if(c==null||isNaN(c)){c=1}var f=this.commonAncestorContainer;if(IS.safari&&typeof(f.tagName)=="undefined"){f=this.tempObj}if(f!=null&&(f.tagName=="INPUT"||f.tagName=="TEXTAREA")){var b;var a=0;try{switch(g){case"character":b=f.selectionStart;f.selectionStart=f.selectionEnd=(f.selectionStart+c)>f.value.length?0:f.selectionStart+c;a=f.selectionStart-b;break;case"word":a=this.moveStart("word",c);f.selectionEnd=f.selectionStart;break;case"textedit":f.selectionStart=f.selectionEnd=c==1?f.value.length:0;a=c>1?1:(c<0?-1:0);break}this.selectionStart=f.selectionStart;this.selectionEnd=f.selectionEnd}catch(d){a=0}return a}else{return -1}};Range.prototype.expand=function(e){var c=this.commonAncestorContainer;if(IS.safari&&typeof(c.tagName)=="undefined"){c=this.tempObj}if(c!=null&&(c.tagName=="INPUT"||c.tagName=="TEXTAREA")){switch(e){case"character":c.selectionEnd=c.selectionStart+((c.selectionStart+1)>c.value.length?0:1);break;case"word":var d=c.value.substr(c.selectionStart);var b=-1;for(var a=0;a<d.length;a++){if(d.charAt(a)==" "){if(b==-1){b=a}else{if((b+1)==a){b=a}else{break}}}}c.selectionEnd=b>-1?b+c.selectionStart+1:c.value.length;break;case"textedit":c.selectionEnd=c.value.length;break;default:return false;break}this.select();return c.selectionEnd>c.selectionStart}else{return false}};Range.prototype.moveStart=function(t,c){if(c==null||isNaN(c)){return}var p=this.commonAncestorContainer;if(IS.safari&&typeof(p.tagName)=="undefined"){p=this.tempObj}if(p!=null&&(p.tagName=="INPUT"||p.tagName=="TEXTAREA")){var b;var a=0;try{switch(t){case"character":b=p.selectionStart;p.selectionStart=(p.selectionStart+c)>p.value.length?p.value.length:p.selectionStart+c;a=p.selectionStart-b;break;case"word":var u=p.value.split(" ");var m=new Array();var g=false;var l=-1;var s="";for(var k=0;k<u.length;k++){if(u[k]==""){if(g==false){g=true;l=m.length;s=""}s=s+" "}else{if(g){if(m.length>0){m[m.length-1]+=s}else{m[m.length]+=s+" "}s=""}m[m.length]=u[k]+" ";g=false}}var q=0;l=-1;for(var f=0;f<m.length;f++){if(p.selectionStart>=q&&p.selectionEnd<=(q+m[f].length)){l=f;break}else{q+=m[f].length}}var r=l;l+=c;if(l>m.length){l=m.length-1}if(l<0){l=0}a=l-r;q=0;for(var h=0;h<m.length;h++){if(h<l){q+=m[h].length}else{break}}p.selectionStart=p.selectionEnd=q;break;case"textedit":b=p.selectionStart;p.selectionStart=c==1?p.value.length:0;a=b-p.selectionStart>0?1:(b-p.selectionStart<0?-1:0);break}this.selectionStart=p.selectionStart;this.selectionEnd=p.selectionEnd}catch(d){a=0}return a}else{return -1}};Range.prototype.moveEnd=function(s,c){if(c==null||isNaN(c)){return}var p=this.commonAncestorContainer;if(IS.safari&&typeof(p.tagName)=="undefined"){p=this.tempObj}if(p!=null&&(p.tagName=="INPUT"||p.tagName=="TEXTAREA")){var b;var a=0;try{switch(s){case"character":b=p.selectionEnd;p.selectionEnd=(p.selectionEnd+c)>=p.value.length?p.value.length:p.selectionEnd+c;a=p.selectionEnd-b;break;case"word":var t=p.value.split(" ");var m=new Array();var g=false;var l=-1;for(var k=0;k<t.length;k++){if(t[k]==""){if(g==false){g=true;l=m.length;m[l]=""}m[l]=m[l]+" "}else{if(g){if(m.length>0){m[m.length-1]+=tempSpace}else{m[m.length]+=tempSpace+" "}tempSpace=""}m[m.length]=t[k]+" ";g=false}}var q=0;l=-1;for(var f=0;f<m.length;f++){if(p.selectionStart>=q&&p.selectionEnd<=(q+m[f].length)){l=f;break}else{q+=m[f].length}}var r=l;l+=c;if(l>m.length){l=m.length-1}if(l<0){l=0}a=l-r;q=0;for(var h=0;h<m.length;h++){if(h<l){q+=m[h].length}else{break}}p.selectionStart=q;p.selectionEnd=q+m[l].length;break;case"textedit":b=p.selectionEnd;p.selectionEnd=c==1?p.value.length:0;a=b-p.selectionEnd>0?1:(b-p.selectionEnd<0?-1:0);break}this.selectionStart=p.selectionStart;this.selectionEnd=p.selectionEnd}catch(d){a=0}return a}else{return -1}};Range.prototype.isEqual=function(a){if(this.commonAncestorContainer==a.commonAncestorContainer){return(this.selectionStart==a.selectionStart&&this.selectionEnd==a.selectionEnd)}else{if(IS.safari){if(this.tempObj==a.tempObj){return(this.tempObj.selectionStart==a.tempObj.selectionStart&&this.tempObj.selectionEnd==a.tempObj.selectionEnd)}else{return false}}else{return false}}}},_EmulatePopupWindow:function(){Window.prototype.createPopup=function(){return new WindowPopup()}}};if(typeof(IE11Engine_Initialized)=="undefined"){IE11Engine._EmulateAttachEvent();IE11Engine._EmulateDocumentModel();IE11Engine._EmulateElementModel();IE11Engine._EmulateSelectionModel();IE11Engine._EmulatePopupWindow();IE11Engine._ExtendEventObject();IE11Engine_Initialized=true}if(typeof(Sys)!="undefined"){Sys.Application.notifyScriptLoaded()};