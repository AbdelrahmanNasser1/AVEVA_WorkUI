function ISAnimatedObject(){this.Element=null;this.ParentElement=null;this.Type="";this.Style="WinXPStyle";this.Step=0;this.OnCompleted=null;this.Speed="Slow";this.StepInterval=1;this.CurrentSize=new UnitSize();this.TargetSize=new UnitSize();this.CurrentLocation=new OffsetLocation();this.TargetLocation=new OffsetLocation();this.AnimateLocation=false;this.AnimateSize=false;this.ShadowMode=true;this.MaxStep=10;this.Duration=1;this.Height=0;this.TimeoutInterval=1;this.IntervalId=null;this.Canceled=false;this.EnableFading=false;this.MaxFadeInOpacity=100;this.BorderColor="";this._ShadowElement=null;this.Play=function(){this.Canceled=false;ISAnimationEngine.Play(this)};this.Stop=function(){this.Canceled=true}}var ISAnimationSpeed={Fast:10,Medium:20,Slow:30,VerySlow:50};var ISAnimationEngine={_ShadowElement:null,_beta:0,Play:function(b){switch(b.Type){case"ShrinkExpand":ISAnimationEngine._PlayShrinkExpand(b,0);break;case"SlideDown":clearTimeout(b.IntervalId);ISAnimationEngine._PlaySlideDown(b,1);break;case"SlideUp":clearTimeout(b.IntervalId);ISAnimationEngine._PlaySlideUp(b,1);break;case"FadeIn":b.Element.style.display="";ISAnimationEngine._PlayFadeIn(b,0);break;case"FadeOut":ISAnimationEngine._PlayFadeOut(b,b.MaxFadeInOpacity);break;case"MSNSlideUp":ISAnimationEngine._PlayMSNSlideUp(b,0);break;case"MSNSlideDown":ISAnimationEngine._PlayMSNSlideDown(b,0);break;case"ResizeUp":var a=(b.Speed=="Fast"?3:(b.Speed=="Medium"?2:1));ISAnimationEngine._VResize(b,-1*a);break;case"ResizeDown":var a=(b.Speed=="Fast"?3:(b.Speed=="Medium"?2:1));ISAnimationEngine._VResize(b,a);break;case"MenuSlideUp":ISAnimationEngine._PlayMenuSlideUp(b,null);break;case"MenuSlideDown":ISAnimationEngine._PlayMenuSlideDown(b,null);break;case"MenuSlideRight":ISAnimationEngine._PlayMenuSlideRight(b,null);break;case"ZoomOut":ISAnimationEngine._PlayZoomOut(b,null);break;case"ZoomIn":ISAnimationEngine._PlayZoomIn(b,null);break}},_PlayFadeIn:function(a,b){ISAnimationEngine.ChangeOpacity(b,a);if(b>a.MaxFadeInOpacity){b=a.MaxFadeInOpacity}if(b==a.MaxFadeInOpacity){if(a.OnCompleted!=null){a.OnCompleted()}return}a.IntervalId=setTimeout(function(){ISAnimationEngine._PlayFadeIn(a,b+a.StepInterval)},ISAnimationSpeed[a.Speed])},_PlayFadeOut:function(a,b){ISAnimationEngine.ChangeOpacity(b,a,true);if(b==0||a.Canceled){if(a.OnCompleted!=null){a.OnCompleted()}if(a.Canceled){ISAnimationEngine.ChangeOpacity(100,a,true)}return}a.IntervalId=setTimeout(function(){ISAnimationEngine._PlayFadeOut(a,b-a.StepInterval)},ISAnimationSpeed[a.Speed])},_PlayMSNSlideUp:function(b,c){var d=b.Element.style;if(c==0){if(!b.Element.OriginalTop){b.Element.OriginalTop=ISPosLib.getTop(b.Element);b.Element.OriginalHeight=b.Element.offsetHeight}d.display="";d.position="absolute";d.top=b.Element.OriginalTop+b.Element.OriginalHeight+"px";d.height=1+"px"}else{d.top=(d.posTop-c)+"px";d.height=(d.posHeight+c)+"px"}if(d.posTop<=b.Element.OriginalTop){d.top=b.Element.OriginalTop+"px";d.height=b.Element.OriginalHeight+"px";if(b.OnCompleted!=null){b.OnCompleted()}return}var a=d.posTop-b.Element.OriginalTop;a/=2;a=Math.round(a);setTimeout(function(){ISAnimationEngine._PlayMSNSlideUp(b,a)},50)},_PlayMSNSlideDown:function(b,c){var d=b.Element.style;if(c==0){if(!b.Element.OriginalTop){b.Element.OriginalTop=ISPosLib.getTop(b.Element);b.Element.OriginalHeight=b.Element.offsetHeight}d.position="absolute";d.top=b.Element.OriginalTop+"px";d.height=b.Element.OriginalHeight+"px";d.display=""}else{d.top=(d.posTop+c)+"px";d.height=(d.posHeight-c)+"px"}if(d.posHeight==1){d.top=(b.Element.OriginalTop+b.Element.OriginalHeight-2)+"px";d.display="none";if(b.OnCompleted!=null){b.OnCompleted()}return}var a=d.posHeight;a/=2;a=Math.round(a);setTimeout(function(){ISAnimationEngine._PlayMSNSlideDown(b,a)},50)},_PlayMenuSlideUp:function(f,h){var i=f.Element.style;var e=false;if(h==null){if(!f.Element.OriginalTop){f.Element.OriginalTop=ISPosLib.getTop(f.Element);f.Element.OriginalHeight=f.Element.offsetHeight}h=f.Element.OriginalTop;e=true;i.position="absolute";i.visibility="visible"}var d=h;if(d<=f.Element.OriginalTop-f.Element.OriginalHeight){i.visibility="hidden";i.clip="auto";if(f.OnCompleted!=null){f.OnCompleted()}return}else{var b=(f.Element.OriginalTop-h)+"px";var a="auto";var g=0;i.top=d;i.clip="rect("+b+" auto "+a+" auto)";if(f.EnableFading){g=100-((d/(f.Element.OriginalTop-f.Element.OriginalHeight))*100);ISAnimationEngine.ChangeOpacity(g,f)}}var c=(h+f.Element.OriginalHeight)-f.Element.OriginalTop;c/=2;c=h-Math.round(c);setTimeout(function(){ISAnimationEngine._PlayMenuSlideUp(f,c)},ISAnimationSpeed[f.Speed])},_PlayMenuSlideDown:function(f,h){var i=f.Element.style;var e=false;if(h==null){if(!f.Element.OriginalTop){f.Element.OriginalTop=ISPosLib.getTop(f.Element);f.Element.OriginalHeight=f.Element.offsetHeight}h=f.Element.OriginalTop-f.Element.OriginalHeight;e=true;i.position="absolute";i.visibility="visible"}var d=h;if(d>=f.Element.OriginalTop){i.top=f.Element.OriginalTop+"px";i.clip="auto";if(f.EnableFading){ISAnimationEngine.ChangeOpacity(100,f)}if(f.OnCompleted!=null){f.OnCompleted()}return}else{var b=(f.Element.OriginalTop-h);var a=(f.Element.OriginalHeight+h);var g=0;i.top=d+"px";i.clip="rect("+b+"px auto "+a+"px auto)";if(f.EnableFading){g=(d/f.Element.OriginalTop)*100;ISAnimationEngine.ChangeOpacity(g,f)}}var c=f.Element.OriginalTop-h;if(e){c=c+(f.Element.OriginalHeight/2)}c/=2;if(c<0){c=0-c}c=h+Math.round(c);setTimeout(function(){ISAnimationEngine._PlayMenuSlideDown(f,c)},ISAnimationSpeed[f.Speed])},_PlayMenuSlideRight:function(f,h){var i=f.Element.style;var e=false;if(h==null){if(!f.Element.OriginalLeft){f.Element.OriginalLeft=ISPosLib.getLeft(f.Element);f.Element.OriginalWidth=f.Element.offsetWidth}h=f.Element.OriginalLeft-f.Element.OriginalWidth;e=true;i.position="absolute";i.visibility="visible"}var d=h;if(d>=f.Element.OriginalLeft){i.left=f.Element.OriginalLeft;i.clip="auto";if(f.EnableFading){ISAnimationEngine.ChangeOpacity(100,f)}if(f.OnCompleted!=null){f.OnCompleted()}return}else{var a=(f.Element.OriginalLeft-h)+"px";var b=(f.Element.OriginalWidth+h)+"px";var g=0;i.left=d;i.clip="rect(auto "+b+" auto "+a+")";if(f.EnableFading){g=(d/f.Element.OriginalLeft)*100;ISAnimationEngine.ChangeOpacity(g,f)}}var c=h+(f.Element.OriginalWidth/1.5);setTimeout(function(){ISAnimationEngine._PlayMenuSlideRight(f,c)},ISAnimationSpeed[f.Speed])},_PlayShrinkExpand:function(c,e){var a=c.Duration/c.MaxStep;if(e==0){if(ISAnimationEngine._ShadowElement==null){var d=document.createElement("DIV");d.style.cssText="border: red 1px solid; position:absolute; z-index: 106";if(c.BorderColor==""){d.style.borderColor=c.Element.currentStyle.borderColor}else{d.style.borderColor=c.BorderColor}d.style.left=c.CurrentLocation.X+"px";d.style.top=c.CurrentLocation.Y+"px";d.style.width=c.CurrentSize.Width+"px";d.style.height=c.CurrentSize.Height+"px";c.Element.parentElement.appendChild(d);ISAnimationEngine._ShadowElement=d}else{ISAnimationEngine._ShadowElement.style.display="none"}setTimeout(function(){ISAnimationEngine._PlayShrinkExpand(c,e+1)},a)}else{d=ISAnimationEngine._ShadowElement;d.style.display="";if(c.AnimateLocation){var g=(e/c.MaxStep)*(c.TargetLocation.X-c.CurrentLocation.X);var i=(e/c.MaxStep)*(c.TargetLocation.Y-c.CurrentLocation.Y);d.style.left=g+c.CurrentLocation.X+"px";d.style.top=i+c.CurrentLocation.Y+"px"}if(c.AnimateSize){var f=(e/c.MaxStep)*(c.TargetSize.Width-c.CurrentSize.Width);var b=(e/c.MaxStep)*(c.TargetSize.Height-c.CurrentSize.Height);d.style.width=c.CurrentSize.Width+f+"px";d.style.height=c.CurrentSize.Height+b+"px"}if(e==c.MaxStep){d.style.display="none";if(c.OnCompleted!=null){c.OnCompleted()}return}setTimeout(function(){ISAnimationEngine._PlayShrinkExpand(c,e+1)},a)}},ChangeOpacity:function(d,b,a){var c=b.Element.style;c.opacity=(d/100);c.MozOpacity=(d/100);c.KhtmlOpacity=(d/100);if(IS.ie){if(b.Element.currentStyle.filter==""){c.filter="Alpha(Opacity="+d+")"}if((d==0||(a&&d==100))&&b.Element.currentStyle.filter.indexOf("Alpha")==-1){c.filter=((b.Element.currentStyle.filter!="")?b.Element.currentStyle.filter+" ":"")+"Alpha(Opacity="+d+")"}else{var f=c.filter;var e=f.indexOf("Opacity");c.filter=f.substring(0,e+8)+d+")"}}if(d==100&&!a){ISAnimationEngine.RemoveOpacity(b.Element)}},RemoveOpacity:function(a){var d=a.style.cssText;var b=d.indexOf("FILTER");if(IS.ie){if(b>-1){var c=d.indexOf(";",b+1);d=d.substring(0,b)+d.substring(c+1);a.style.cssText=d}}else{a.style.opacity=1;a.style.MozOpacity=1;a.style.KhtmlOpacity=1}},_delta:function(a,d,c){for(var b=1;b<=d.MaxStep;b++){if(a.offsetHeight<(c*b)){return b}}for(var b=1;b<=d.MaxStep;b++){if(d.Height-(c*b)<a.offsetHeight){return b}}return d.MaxStep},_PlaySlideDown:function(d,h){var a=d.Element;var g=(d.ParentElement==null)?a.parentNode:d.ParentElement;var f=g.offsetHeight/d.Height*100;var e=parseInt(d.Height);var b=a.offsetTop;if(e==0){e=a.offsetHeight}if(b==0){b-=a.offsetHeight}if(Math.round(f)>98){f=100}if(d.EnableFading){ISAnimationEngine.ChangeOpacity(f,d)}if(f==100){a.style.filter=""}if(d.Style=="WinXPStyle"){h=ISAnimationEngine._delta(g,d,IS.safari?1:3)}else{if(d.Style=="Accelerated"||d.Style=="Decelerated"){h+=d.Step}}if(b+e>=e){a.style.top=e+"px";if(d.OnCompleted!=null){ISEvent.Raise(d.OnCompleted,d.EventArgs)}return}else{var c=g.offsetHeight+h;if(c>=e){if(d.EnableFading){ISAnimationEngine.ChangeOpacity(100,d)}a.style.top="0px";g.style.height="";if(d.OnCompleted!=null){ISEvent.Raise(d.OnCompleted,d.EventArgs)}return}else{g.style.height=c+"px"}if(b+h<0){if(IS.IsHTML5DocType()){a.style.top=b+h}else{a.style.top=b+h+"px"}}else{if(IS.IsHTML5DocType()){a.style.top=0}else{a.style.top="0px"}}}d.IntervalId=setTimeout(function(){ISAnimationEngine._PlaySlideDown(d,h)},15)},_PlaySlideUp:function(c,f){var a=c.Element;var e=(c.ParentElement==null)?a.parentNode:c.ParentElement;if(c.EnableFading){var d=e.offsetHeight/c.Height*100;ISAnimationEngine.ChangeOpacity(d,c)}if(c.Style=="WinXPStyle"){f=ISAnimationEngine._delta(e,c,IS.safari?1:3)}else{if(c.Style=="Accelerated"||c.Style=="Decelerated"){f+=c.Step}}if(a.offsetTop+c.Height<=0){e.style.height="1px";if(c.OnCompleted!=null){ISEvent.Raise(c.OnCompleted,c.EventArgs)}return}else{a.style.top=(a.offsetTop-f)+"px";var b=(e.offsetHeight-f);if(b<=0){e.style.height="1px";if(c.OnCompleted!=null){ISEvent.Raise(c.OnCompleted,c.EventArgs)}return}else{e.style.height=b+"px"}}c.IntervalId=setTimeout(function(){ISAnimationEngine._PlaySlideUp(c,f)},15)},_VResize:function(b,c){var a=b.Element;if(c<0){if(a.offsetHeight+c<=parseInt(b.TargetSize.Height)){a.style.height=parseInt(b.TargetSize.Height);return}else{a.style.height=a.offsetHeight+c}}else{if(a.offsetHeight+c>=parseInt(b.TargetSize.Height)){a.style.height=parseInt(b.TargetSize.Height);return}else{a.style.height=a.offsetHeight+c}}setTimeout(function(){ISAnimationEngine._VResize(b,c)},10)},_PlayZoomOut:function(o,step){if(step==null){var el=o.Element;step=1;o.OriginalLeft=parseFloat(el.style.left);o.OriginalTop=parseFloat(el.style.top);o.CurrentOpacity=100;o.CurrentInterval=100;el.lastCalculatedWidth=ISPosLib.getWidth(el);el.lastCalculatedHeight=ISPosLib.getHeight(el)}if(step==o.MaxStep||o.CurrentOpacity==0){var el=o.Element;with(el.style){display="none";filter="";zoom="100%";left=o.OriginalLeft;top=o.OriginalTop}if(o.OnCompleted!=null){ISEvent.Raise(o.OnCompleted,o.EventArgs)}return}var el=o.Element;var op=o.CurrentOpacity;var duration=o.CurrentInterval;if(!o.AnimateLocation&&!o.AnimateSize){with(el.style){top=parseFloat(top)+step;left=parseFloat(left)+step;zoom=(100-(step*2))+"%"}}else{if(o.AnimateLocation){var x=(step/o.MaxStep)*(o.TargetLocation.X-o.CurrentLocation.X);var y=(step/o.MaxStep)*(o.TargetLocation.Y-o.CurrentLocation.Y);el.style.left=x+o.CurrentLocation.X;el.style.top=y+o.CurrentLocation.Y}if(o.AnimateSize){var w=(step/o.MaxStep)*(o.TargetSize.Width-o.CurrentSize.Width);var h=(step/o.MaxStep)*(o.TargetSize.Height-o.CurrentSize.Height);el.style.width=o.CurrentSize.Width+w;el.style.height=o.CurrentSize.Height+h}}op=op/1.75;if(op<0){op=0}ISAnimationEngine.ChangeOpacity(op,o);step++;duration=duration/step;if(duration<1){duration=1}o.CurrentOpacity=op;o.CurrentInterval=duration;setTimeout(function(){ISAnimationEngine._PlayZoomOut(o,step)},duration)},_PlayZoomIn:function(o,step){if(step==null){step=1;if(typeof(o.CurrentOpacity)=="undefined"){o.CurrentOpacity=5}if(typeof(o.CurrentInterval)=="undefined"){o.CurrentInterval=50}var el=o.Element;var distance=0;var _top=0;var _left=0;var _width=0;var _height=0;if(!o.AnimateLocation&&!o.AnimateSize){_top=parseFloat(el.style.top);_left=parseFloat(el.style.left);if(el.offsetWidth==0){if(el.lastCalculatedWidth){_width=parseFloat(el.lastCalculatedWidth)}else{_width=parseFloat(el.style.width)}}else{_width=el.offsetWidth}if(el.offsetHeight==0){if(el.lastCalculatedHeight){_height=parseFloat(el.lastCalculatedHeight)}else{_height=parseFloat(el.style.height)}}else{_height=el.offsetHeight}}else{_top=o.CurrentLocation.Y;_left=o.CurrentLocation.X;_width=o.CurrentSize.Width;_height=o.CurrentSize.Height}for(var i=1;i<o.MaxStep;i++){distance+=(i*1.5)}with(el.style){top=_top+distance;left=_left+distance;width=_width-(distance*2);height=_height-(distance*2);display=""}}if(step==o.MaxStep){if(o.CurrentOpacity<100){ISAnimationEngine.ChangeOpacity(100,o);o.Element.style.filter=""}if(o.AnimateLocation&&o.AnimateSize){with(o.Element.style){left=o.TargetLocation.X;top=o.TargetLocation.Y;width=o.TargetSize.Width;height=o.TargetSize.Height}}if(o.OnCompleted!=null){ISEvent.Raise(o.OnCompleted,o.EventArgs)}return}var el=o.Element;var op=o.CurrentOpacity;var duration=o.CurrentInterval;if(!o.AnimateLocation&&!o.AnimateSize){with(el.style){top=parseFloat(top)-(step*1.5);left=parseFloat(left)-(step*1.5);width=parseFloat(width)+((step*1.5)*2);height=parseFloat(height)+((step*1.5)*2)}}else{if(o.AnimateLocation){var x=(step/o.MaxStep)*(o.TargetLocation.X-o.CurrentLocation.X);var y=(step/o.MaxStep)*(o.TargetLocation.Y-o.CurrentLocation.Y);el.style.left=x+o.CurrentLocation.X;el.style.top=y+o.CurrentLocation.Y}if(o.AnimateSize){var w=(step/o.MaxStep)*(o.TargetSize.Width-o.CurrentSize.Width);var h=(step/o.MaxStep)*(o.TargetSize.Height-o.CurrentSize.Height);el.style.width=o.CurrentSize.Width+w;el.style.height=o.CurrentSize.Height+h}}ISAnimationEngine.ChangeOpacity(op,o);op=op*2;if(op>100){op=100}step++;duration=duration/(step/1.25);if(duration<1){duration=1}if(duration>300){duration=300}o.CurrentOpacity=op;o.CurrentInterval=duration;setTimeout(function(){ISAnimationEngine._PlayZoomIn(o,step)},duration)}};function ISAnimation_RemoveOpacity(a){ISAnimationEngine.RemoveOpacity(a)}if(typeof(Sys)!="undefined"){Sys.Application.notifyScriptLoaded()};