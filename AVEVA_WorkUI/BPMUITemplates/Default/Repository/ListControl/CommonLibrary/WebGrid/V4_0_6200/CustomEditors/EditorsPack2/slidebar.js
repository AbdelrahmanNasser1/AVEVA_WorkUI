
function Slidebar_Editor()
{
 
 this.OnInitialize =function()
 {
 var vb3d27 =document.createElement("SPAN");
 vb3d27.id ="placeholderSlidebar";
 vb3d27.style.cssText ="visibility: hidden; background-color: #FFE0C0; border: 1px ridge";
 this.Grid.FrameObj.appendChild(vb3d27);

 this.Grid.EditControls.push(vb3d27);
 };
 
 this.OnUnload =function()
 {
 };
 
 this.OnEnterEditMode =function(vd7254,vdb432,vea881)
 {
 var v2a436 =this.GetDropdownButtonElement();
 wgDispObjGeneric(this.Grid,v2a436,vd7254.element,vd7254.element.offsetWidth-this.CustomEditor.DropdownButtonWidth-2,1,true);
 v2a436.style.height =vd7254.element.offsetHeight-2;
 
 var v5b412 =this.GetBaseEditorElement();
 v5b412.focus();
 v5b412.isDirty =false;
 
 if (this.Slidebar !=null)
 this.SetProperties();

 
 return this.GetDropdownObject();
 };
 
 this.OnSetValue =function(v0d842,vd7254)
 {
 var v5b412 =this.GetBaseEditorElement();
 if (v0d842 ==" ")v0d842 ="";
 v5b412.value =v0d842;

 if (this.Slidebar !=null)
 {
 this.Slidebar.Value =parseFloat(v0d842);
 this.Slidebar.Redraw();
 }
 };
 
 this.OnDirty =function(){
 var v5b412 =this.GetBaseEditorElement();
 v5b412.isDirty =true;
 };
 
 this.OnExitEditMode =function(v3f186){
 var v2a436 =this.GetDropdownButtonElement();
 v2a436.style.display ="none";

 var v5b412 =this.GetBaseEditorElement();
 v5b412.style.display ="none";
 
 this.Valid =true; 
 if (!v3f186)
 this.OnValidate(this.Grid.GetLastEditObject().cellElement);

 return true;
 };
 
 this.OnApply =function()
 {
 var vd2f86 =this.CustomEditor.GetEditCell().element;
 
 if ((this.Slidebar !=null)&&(this.SlidebarDropdowned))
 {
 vd2f86.innerText =this.Slidebar.Value;
 this.CloseDropdown();
 }
 };
 
 this.OnCancel =function()
 {
 this.CloseDropdown();
 };

 this.OnValidate =function(vfb48)
 {
 var v56c71 =this.GetValue();
 v56c71 =parseFloat(v56c71);
 
 if ((this.Slidebar)&&(this.SlidebarDropdowned))
 {
 if (v56c71 >=this.Slidebar.MinValue &&v56c71 <=this.Slidebar.MaxValue){
 this.OnApply();
 return true;
 }
 else {
 alert("OutOfRangeException: Value must be between " +this.Slidebar.MinValue +" and " +this.Slidebar.MaxValue);
 var va5640 =this.Grid;
 setTimeout(function(){wgHighlightEditCell(vfb48); wgActivateEditMode(va5640);},50);
 var v5b412 =this.GetBaseEditorElement();
 v5b412.isDirty =false; 
 this.Valid =false;
 return false;
 }
 }
 else {
 var vc274 =0;
 var v0c990 =100;
 if (this.Slidebar){
 vc274 =this.Slidebar.MinValue;
 v0c990 =this.Slidebar.MaxValue;
 }
 
 if (v56c71 >=vc274 &&v56c71 <=v0c990){
 var vd2f86 =this.Grid.GetLastEditObject().cellElement; 
 vd2f86.innerText =v56c71;
 return true;
 }
 else {
 alert("OutOfRangeException: Value must be between " +vc274 +" and " +v0c990);
 var v5b412 =this.GetBaseEditorElement();
 v5b412.isDirty =false;
 this.Valid =false;
 return false;
 }
 }
 };
 
 this.OnKeyDown =function(v2ec8)
 {
 alert(v2ec8);
 };
 
 this.OnDropdown =function()
 {
 var vd7254 =this.CustomEditor.GetEditCell();
 if (this.Slidebar ==null)
 {
 var va8c10 =this.Grid.Name;
 var v09327 =this.CustomEditor.Name;

 this.Slidebar =new Slidebar("placeholderSlidebar",this.ControlName,"x",this.CustomEditor.ScriptFolder);
 this.Slidebar.OnChange ="Slidebar_OnChange('"+va8c10 +"', '"+v09327 +"')";
 this.Slidebar.OnEnter ="Slidebar_OnEnter('"+va8c10 +"', '"+v09327 +"')";
 this.Slidebar.OnCancel ="Slidebar_OnCancel('"+va8c10 +"', '"+v09327 +"')";

 this.OnSetValue(String(vd7254.element.innerText),this.CustomEditor.GetEditCell());

 this.SetProperties();
 }
 
 this.SlidebarDropdowned =true;
 Listener.Add (document,"onkeydown",eff955.mad896);
 
 var va8c10 =this.Grid.Name;
 var v09327 =this.CustomEditor.Name;
 var v5b412 =this.GetBaseEditorElement();
 v5b412.onclick =function(){BaseEditorElement_OnClick(va8c10,v09327);};
 
 var v82149 =this.GetDropdownObject();
 v82149.style.cssText ="visibility: visible; background-color: #FFE0C0; border: 1px ridge";
 
 if (!this.Grid.GetLastEditObject())
 {
 var va3216 =document.createEventObject();
 var v1fe85 =this.CustomEditor.GetEditCellElement();
 va3216.keyCode =13;
 va3216._srcElement =v1fe85;
 v1fe85.fireEvent("onkeydown",va3216);
 }
 
 wgDispObjGeneric(this.Grid,v82149,vd7254.element,1,vd7254.element.offsetHeight +15,true);

 var v7d885 =parseFloat(v82149.style.left);
 var va3b86 =parseFloat(v82149.style.top);
 var vc7922 =parseFloat(v82149.offsetWidth);
 var vf7230 =parseFloat(v82149.offsetHeight);
 
 if (v7d885+vc7922 >document.body.offsetWidth)
 v82149.style.left =v7d885 -((v7d885+vc7922)-document.body.offsetWidth)-50;
 
 if (va3b86+vf7230 >document.body.offsetHeight){
 var v9eb94 =va3b86 -((va3b86+vf7230)-document.body.offsetHeight)-20;
 if (v9eb94 <0)v9eb94 =25;
 v82149.style.top =v9eb94;
 }
 
 v82149.setActive();
 this.Slidebar.SetActive();
 };

 this.GetBaseEditorElement =function()
 {
 return this.CustomEditor.GetBaseEditorElement();
 };
 
 this.GetDropdownButtonElement =function()
 {
 
 var va8c10 =this.Grid.Name;
 var v09327 =this.CustomEditor.Name;
 var v55b80 =this.CustomEditor.GetDropdownButtonElement();
 v55b80.onclick =function(){Slidebar_ImgClick(v55b80,va8c10,v09327);};
 v55b80.onkeydown =function(){Slidebar_KeyDown(v55b80,va8c10,v09327);};

 return v55b80;
 };
 
 this.GetDropdownObject =function()
 {
 var v2ce25 =document.getElementById(this.ControlName);
 if (!v2ce25)
 {
 this.ControlCreated =false;
 return false;
 }
 var va4734 =v2ce25.parentElement;
 
 return va4734;
 };

 this.IsDirty =function()
 {
 var v5b412 =this.GetBaseEditorElement();
 return v5b412.isDirty;
 };
 
 this.GetText =function()
 {
 var v5b412 =this.GetBaseEditorElement();
 var v0d842 =v5b412.value;
 
 if (v0d842 ==null)v0d842 ="";
 
 if (!this.Valid){
 var vd2f86 =this.Grid.GetLastEditObject().cellElement;
 return vd2f86.innerText;
 }
 return v0d842;
 };
 
 this.GetValue =function()
 {
 return this.GetText();
 };
 
 this.SetProperties =function()
 {
 var v30e28 =this.CustomEditor.GetColumnEditorProperties();
 var v2354 =v30e28.split(";");
 var v66c54 =false;
 for (var v1f383=0; v1f383<v2354.length; v1f383++)
 {
 this.SetProperty(v2354[v1f383].split("=")[0],v2354[v1f383].split("=")[1]);
 if (v2354[0] !="")v66c54 =true;
 }

 if (v66c54)this.Slidebar.Redraw();
 };
 
 this.ShouldProcessExitEditModeDefaultBehavior =function()
 {
 return true;
 };
 
 
 
 



 this.Grid =null;
 this.CustomEditor =null;
 this.Slidebar =null;
 
 this.DDBtn =null;
 this.ControlName ="Slidebar";
 this.ControlCreated =true;
 this.SlidebarDropdowned =false;
 this.Valid =true;
 
 this.SetProperty =function(v8e431,vc7a15)
 {
 switch (v8e431)
 {
 case "Width": this.Slidebar.Width =vc7a15; break;
 case "Height": this.Slidebar.Height =vc7a15; break;
 case "Type": this.Slidebar.Type =vc7a15; break;
 case "MaxValue": this.Slidebar.MaxValue =vc7a15; break;
 case "MinValue": this.Slidebar.MinValue =vc7a15; break;
 case "Interval": this.Slidebar.Interval =vc7a15; break;
 case "IntervalLarge": this.Slidebar.IntervalLarge =vc7a15; break;
 case "Value": this.Slidebar.Value =vc7a15; break;
 case "SliderImage": this.Slidebar.SliderImage =vc7a15; break;
 case "TrackSize": this.Slidebar.TrackSize =vc7a15; break;
 }
 };

 this.CloseDropdown =function()
 {
 var v82149 =this.GetDropdownObject();
 v82149.style.display ="none";
 
 Listener.Remove (document,"onkeydown",eff955.mad896);
 this.SlidebarDropdowned =false;
 
 var v5b412 =this.GetBaseEditorElement();
 v5b412.onclick =null; 
 };
 
 
return this;
};







function Slidebar_ImgClick(v63276,vdbe2,ve8a42)
{
 var v6f653 =wgGetGridById(vdbe2);
 var vbc19 =v6f653.CustomEditors[ve8a42];
 vbc19.ImplementationObject.OnDropdown();
};

function Slidebar_KeyDown(va3876,vac82,v0b642)
{
 var vaf576 =event.keyCode;
 var v89d2 =wgGetGridById(vac82);
 var v46642 =v89d2.CustomEditors[v0b642];
 var va3c14 =v46642.ImplementationObject;

 switch (vaf576)
 {
 case 13:
 case 115:
 case 32:
 va3c14.OnDropdown();
 break;
 case 27:
 va3c14.OnExitEditMode(true);
 v46642.GetEditCellElement().setActive();
 v46642.ClearEditObject();
 break;
 }
 event.cancelBubble =true;
 event.keyCode =0;
 event.returnValue =false;
};

function Slidebar_OnChange(v1aa76,v0052)
{
 var v8a976 =wgGetGridById(v1aa76);
 var vef62 =v8a976.CustomEditors[v0052];
 var vfd742 =vef62.ImplementationObject.GetBaseEditorElement();
 vfd742.value =vef62.ImplementationObject.Slidebar.Value;
 vef62.ImplementationObject.OnDirty();
 vef62.ImplementationObject.CustomEditor.RowDirty();
};

function Slidebar_OnEnter(v25a76,v2932)
{
 var v48376 =wgGetGridById(v25a76);
 var v8e02 =v48376.CustomEditors[v2932];
 v8e02.ImplementationObject.OnExitEditMode(false);
 v8e02.GetEditCellElement().setActive();
 v8e02.ImplementationObject.OnDirty();
 v8e02.ImplementationObject.CustomEditor.RowDirty();
};

function Slidebar_OnCancel(veec76,vefd2)
{
 var v3bf76 =wgGetGridById(veec76);
 var v9202 =v3bf76.CustomEditors[vefd2];
 v9202.ImplementationObject.OnCancel();
 v9202.ImplementationObject.OnExitEditMode(true);
 v9202.GetEditCellElement().setActive();
 v9202.ClearEditObject();
};

function BaseEditorElement_OnClick(v15476,vd312)
{
 var v5c476 =wgGetGridById(v15476);
 var v5782 =v5c476.CustomEditors[vd312];
 
 v5782.ImplementationObject.CloseDropdown();
};





var eff955 =
 {
 _dragobject : null,_slider : null,_container : null,_tx : 0,
 _ty : 0,
 _timeoutId : null,
 _intervalId : null,
 _stopInterval : false,_direction : null,
 _Id : null,
 _active : false,

 mc7633:function(v76d23)
 {
 return v76d23.clientLeft;
 },

 m3cc91:function(va8823)
 {
 return va8823.clientTop;
 },

 m51751:function(v8b923)
 {
 var vd2f23=v8b923.ownerDocument||v8b923.document;
 if(vd2f23.compatMode=="CSS1Compat")return vd2f23.documentElement;
 else return vd2f23.body;
 },

 mfaa75:function(vea423)
 {
 var v3c723=vea423.getBoundingClientRect();
 return v3c723.left-eff955.mc7633(eff955.m51751(vea423));
 },

 m90f83:function(vdde23)
 {
 var v7d823=vdde23.getBoundingClientRect();
 return v7d823.top-eff955.m3cc91(eff955.m51751(vdde23));
 },

 mad896:function()
 {
 if (eff955._active)
 {
 var v0d323 =eff955._Id;
 var v2e754;
 var v30930; 
 var v44513 =document.getElementById(v0d323+"_slider");
 var v2c914;

 if (IS.IsAvailableRuntimeObjectById(v0d323))
 {
 v30930 =IS.GetRuntimeObjectById(v0d323);
 v2e754 =v30930.Type;
 }
 
 if (v2e754=="y"){
 if (v30930.Interval >0){
 var vb8613 =((v30930.Height-v30930.SliderSize)/(parseFloat(v30930.MaxValue)-parseFloat(v30930.MinValue)));
 
 if (window.event.keyCode ==40)v30930.Value =parseFloat(v30930.Value)+parseFloat(v30930.Interval);
 else if (window.event.keyCode ==38)v30930.Value =parseFloat(v30930.Value)-parseFloat(v30930.Interval);
 else if (window.event.keyCode ==33)v30930.Value =parseFloat(v30930.Value)-parseFloat(v30930.IntervalLarge);
 else if (window.event.keyCode ==34)v30930.Value =parseFloat(v30930.Value)+parseFloat(v30930.IntervalLarge);
 else if (window.event.keyCode ==36)v30930.Value =parseFloat(v30930.MinValue);
 else if (window.event.keyCode ==35)v30930.Value =parseFloat(v30930.MaxValue);
 
 if (v30930.Value <=parseFloat(v30930.MinValue))
 v30930.Value =parseFloat(v30930.MinValue);
 else if (v30930.Value >=parseFloat(v30930.MaxValue))
 v30930.Value =parseFloat(v30930.MaxValue);
 
 v44513.style.top =vb8613*(parseFloat(v30930.Value)-parseFloat(v30930.MinValue));
 }
 else {
 if (window.event.keyCode ==40)v44513.style.top =v44513.style.pixelTop +1;
 else if (window.event.keyCode ==38)v44513.style.top =v44513.style.pixelTop -1;
 else if (window.event.keyCode ==36)v44513.style.top =0;
 else if (window.event.keyCode ==35)v44513.style.top =v30930.Height -v30930.SliderSize;
 
 if (v44513.style.pixelTop <=0)
 v44513.style.top =0;
 else if (v44513.style.pixelTop >=(v30930.Height-v30930.SliderSize))
 v44513.style.top =v30930.Height -v30930.SliderSize;
 }
 }
 else {
 if (v30930.Interval >0){
 var vb8613 =((v30930.Width-v30930.SliderSize)/(parseFloat(v30930.MaxValue)-parseFloat(v30930.MinValue)));
 
 if (window.event.keyCode ==39)v30930.Value =parseFloat(v30930.Value)+parseFloat(v30930.Interval);
 else if (window.event.keyCode ==37)v30930.Value =parseFloat(v30930.Value)-parseFloat(v30930.Interval);
 else if (window.event.keyCode ==33)v30930.Value =parseFloat(v30930.Value)-parseFloat(v30930.IntervalLarge);
 else if (window.event.keyCode ==34)v30930.Value =parseFloat(v30930.Value)+parseFloat(v30930.IntervalLarge);
 else if (window.event.keyCode ==36)v30930.Value =parseFloat(v30930.MinValue);
 else if (window.event.keyCode ==35)v30930.Value =parseFloat(v30930.MaxValue);
 
 if (v30930.Value <=parseFloat(v30930.MinValue))
 v30930.Value =parseFloat(v30930.MinValue);
 else if (v30930.Value >=parseFloat(v30930.MaxValue))
 v30930.Value =parseFloat(v30930.MaxValue);
 
 v44513.style.left =vb8613 *(parseFloat(v30930.Value)-parseFloat(v30930.MinValue));
 }
 else {
 if (window.event.keyCode ==39)v44513.style.left =v44513.style.pixelLeft +1;
 else if (window.event.keyCode ==37)v44513.style.left =v44513.style.pixelLeft -1;
 else if (window.event.keyCode ==36)v44513.style.left =0;
 else if (window.event.keyCode ==35)v44513.style.left =v30930.Width -v30930.SliderSize;
 
 if (v44513.style.pixelLeft <=0)
 v44513.style.left =0;
 else if (v44513.style.pixelLeft >=(v30930.Width-v30930.SliderSize))
 v44513.style.left =v30930.Width -v30930.SliderSize;
 }
 }

 if (window.event.keyCode ==13)v30930._onEnterHandler();
 if (window.event.keyCode ==27)v30930._onCancelHandler();


 if (v30930.Interval >0){
 v30930.Value =Math.round(eff955.mdd576(v44513,v2e754,v0d323))+parseFloat(v30930.MinValue);
 }
 else {
 v30930.Value =eff955.mdd576(v44513,v2e754,v0d323)+parseFloat(v30930.MinValue);
 }
 
 v30930._onChangeHandler();
 window.event.returnValue =false;
 window.event.cancelBubble =true;
 }
 },

 m65e59:function(v3f413)
 {
 var vf3990 =v3f413;
 var v53635;
 var vf0927;

 eff955._Id =vf3990;

 if (IS.IsAvailableRuntimeObjectById(v3f413))
 {
 objSlidebar =IS.GetRuntimeObjectById(v3f413);
 v53635 =objSlidebar.Type;
 }
 
 vf0927 =document.getElementById(vf3990+"_slider");
 if(window.event.srcElement.id ==vf0927.id){
 eff955._dragobject =vf0927;
 var va3f53 =eff955._dragobject;

 if (v53635=="y")
 eff955._ty =(window.event.clientY -va3f53.style.pixelTop);
 else
 eff955._tx =(window.event.clientX -va3f53.style.pixelLeft);

 window.event.returnValue =false;
 window.event.cancelBubble =true;
 eff955._active =true;
 }
 else {
 var vf0927 =document.getElementById(vf3990);
 if (window.event.srcElement.id ==vf0927.id ||window.event.srcElement.id ==vf0927.id+"_track"){
 eff955._container =vf0927;

 var vb8635 =eff955._container;
 var v28177 =window.event.srcElement.children;
 if (v28177.length==0)v28177 =vb8635.children;
 for (var vc4e61=0; v28177.length; vc4e61++)
 {
 if (v28177[vc4e61].id ==vf3990+"_slider"){
 eff955._slider =v28177[vc4e61];
 break;
 }
 }

 var v62616;
 if (v53635=="y"){
 eff955._ty =(window.event.clientY -vb8635.style.pixelTop);
 v62616 =event.clientY;
 }
 else {
 eff955._tx =(window.event.clientX -vb8635.style.pixelLeft);
 v62616 =event.clientX;
 }

 window.event.cancelBubble =true;

 eff955._direction =null;
 eff955._stopInterval =false;
 eff955.m67393(v62616,v53635,v3f413);
 eff955._timeoutId =window.setTimeout("eff955.m14174("+v62616 +", '"+v53635 +"', '"+v3f413 +"')",300);
 eff955._active =true;
 }
 else {
 eff955._dragobject =null; eff955._active =false;
 }
 }
 },

 m67393:function(vf002,v9c32,v70022)
 {
 var v71613 =eff955._container;
 var vec728 =eff955._slider;
 var vb2326 =eff955._tx;
 var vc1866 =eff955._ty;
 var v57d20;

 if(v71613){
 if (IS.IsAvailableRuntimeObjectById(v70022))
 {
 v57d20 =IS.GetRuntimeObjectById(v70022);
 }

 var v9979;
 v9979 =vec728.parentElement;

 if(v9c32=="y"){
 if(vf002 >=0){
 if ((vf002 -vc1866 >=0)&&(vf002 -vc1866 <=v71613.offsetHeight -vec728.offsetHeight)){
 if (!eff955.m39979(vf002,eff955.m90f83(vec728),v9c32))
 {
 if (vf002 <eff955.m90f83(vec728))
 {
 if (v57d20.Interval >0){var v49c25 =(v57d20.IntervalLarge >0)? v57d20.IntervalLarge : v57d20.Interval;
 var v80262 =((v57d20.Height-v57d20.SliderSize)/(v57d20.MaxValue -v57d20.MinValue));
 vec728.style.top =v80262*((v57d20.Value-v57d20.MinValue)-v49c25);
 }
 else {vec728.style.top =vec728.style.pixelTop -vec728.offsetHeight;
 }

 if (vec728.style.pixelTop <=0)
 {
 vec728.style.top =0;
 }
 eff955._direction =-1; }
 else
 {
 if (v57d20.Interval >0){var v49c25 =(v57d20.IntervalLarge >0)? v57d20.IntervalLarge : v57d20.Interval;
 var v80262 =((v57d20.Height-v57d20.SliderSize)/(v57d20.MaxValue -v57d20.MinValue));
 vec728.style.top =v80262*((v57d20.Value-v57d20.MinValue)+v49c25);
 }
 else {vec728.style.top =vec728.style.pixelTop +vec728.offsetHeight;
 }

 if (vec728.style.pixelTop >v71613.offsetHeight -vec728.offsetHeight)
 {
 vec728.style.top =v9979.clientHeight -vec728.offsetHeight;
 }
 eff955._direction =1; }
 }
 }
 }
 }
 else {
 if(vf002 >=0){
 if ((vf002 -vb2326 >=0)&&(vf002 -vb2326 <=v71613.offsetWidth -vec728.offsetWidth)){
 if (!eff955.m39979(vf002,eff955.mfaa75(vec728),v9c32))
 {
 if (vf002 <eff955.mfaa75(vec728))
 {
 if (v57d20.Interval >0){var v49c25 =(v57d20.IntervalLarge >0)? v57d20.IntervalLarge : v57d20.Interval;
 var v80262 =((v57d20.Width-v57d20.SliderSize)/(v57d20.MaxValue -v57d20.MinValue));
 vec728.style.left =v80262*((v57d20.Value-v57d20.MinValue)-v49c25);
 }
 else {vec728.style.left =vec728.style.pixelLeft -vec728.offsetWidth;
 }

 if (vec728.style.pixelLeft <=0)
 {
 vec728.style.left =0;
 }
 eff955._direction =-1; }
 else
 {
 if (v57d20.Interval >0){var v49c25 =parseFloat((v57d20.IntervalLarge >0)? v57d20.IntervalLarge : v57d20.Interval);
 var v80262 =((v57d20.Width-v57d20.SliderSize)/(v57d20.MaxValue -v57d20.MinValue));
 vec728.style.left =v80262*((v57d20.Value-v57d20.MinValue)+v49c25);
 }
 else {vec728.style.left =vec728.style.pixelLeft +vec728.offsetWidth;
 }

 if (vec728.style.pixelLeft >v71613.offsetWidth -vec728.offsetWidth)
 {
 vec728.style.left =v9979.clientWidth -vec728.offsetWidth;
 }
 eff955._direction =1; }
 }
 }
 }
 }
 if (v57d20.Interval >0){
 v57d20.Value =Math.round(eff955.mdd576(vec728,v9c32,v70022))+parseFloat(v57d20.MinValue);
 }
 else {
 v57d20.Value =eff955.mdd576(vec728,v9c32,v70022)+parseFloat(v57d20.MinValue);
 }
 
 v57d20._onChangeHandler();
 }
 },

 m14174:function(vea725,v3e095,v94e21)
 {
 eff955.m67393(vea725,v3e095,v94e21);
 window.clearInterval(eff955._intervalId);
 if (!eff955._stopInterval){
 eff955._intervalId =window.setInterval("eff955.m14174("+vea725 +", '"+v3e095 +"', '"+v94e21 +"')",50);
 }
 },

 m39979:function(v52547,vfbb89,v08e20)
 {
 var vf3e25;
 var vf6b95 =eff955._slider;

 if (v08e20 =="x")vf3e25 =vf6b95.offsetWidth; else vf3e25 =vf6b95.offsetHeight;

 if (eff955._direction ==1){
 if (v52547 <=vfbb89 +vf3e25)
 {
 eff955._stopInterval =true;
 return true;
 }
 else
 {
 return false;
 }
 }
 else if (eff955._direction ==-1){
 if (v52547 >=vfbb89)
 {
 eff955._stopInterval =true;
 return true;
 }
 else
 {
 return false;
 }
 }
 return false;
 },

 ma1373:function()
 {
 eff955._dragobject =null;

 if (eff955._container){
 eff955._container =null;
 eff955._slider =null;
 }
 window.clearInterval(eff955._intervalId);
 window.clearTimeout(eff955._timeoutId);
 document.body.style.cursor ="default";
 },

 mf2772:function()
 {
 var vd8947;
 var v89489 =eff955._dragobject;
 var vd9020 =eff955._tx;
 var vf1847 =eff955._ty;
 var v8e529; 

 if(v89489){
 SlidebarId =eff955._Id;

 if (IS.IsAvailableRuntimeObjectById(SlidebarId))
 {
 v8e529 =IS.GetRuntimeObjectById(SlidebarId);
 vd8947 =v8e529.Type;
 }

 var vf5752;
 vf5752 =v89489.parentElement;

 if (vd8947=="y"){
 if(event.clientY >=0){
 if ((event.clientY -vf1847 >=0)&&(event.clientY -vf1847 <=vf5752.offsetHeight -v89489.offsetHeight)){
 if (v8e529.Interval >0){
 var v59813 =((v8e529.Height-v8e529.SliderSize)/(v8e529.MaxValue -v8e529.MinValue))*v8e529.Interval;
 v89489.style.top =eff955.m7c827(v59813,event.clientY -vf1847);
 }
 else {
 v89489.style.top =event.clientY -vf1847;
 }
 }
 if (event.clientY -vf1847 <0){
 v89489.style.top ="0";
 }
 if (event.clientY -vf1847 >vf5752.offsetHeight -v89489.offsetHeight -0){
 v89489.style.top =vf5752.offsetHeight -v89489.offsetHeight;
 }
 }
 }
 else {
 if(event.clientX >=0){
 if ((event.clientX -vd9020 >=0)&&(event.clientX -vd9020 <=vf5752.offsetWidth -v89489.offsetWidth)){
 if (v8e529.Interval >0){
 var v59813 =((v8e529.Width-v8e529.SliderSize)/(v8e529.MaxValue -v8e529.MinValue))*v8e529.Interval;
 v89489.style.left =eff955.m7c827(v59813,event.clientX -vd9020);
 }
 else {
 v89489.style.left =event.clientX -vd9020;
 }
 }
 if (event.clientX -vd9020 <0){
 v89489.style.left ="0";
 }
 if (event.clientX -vd9020 >vf5752.clientWidth -v89489.offsetWidth -0){
 v89489.style.left =vf5752.clientWidth -v89489.offsetWidth;
 }
 }
 }
 if (v8e529.Interval >0){
 v8e529.Value =Math.round(eff955.mdd576(v89489,vd8947,SlidebarId))+parseFloat(v8e529.MinValue);
 }
 else {
 v8e529.Value =eff955.mdd576(v89489,vd8947,SlidebarId)+parseFloat(v8e529.MinValue);
 }
 
 v8e529._onChangeHandler();

 window.event.returnValue =false;
 window.event.cancelBubble =true;
 document.body.style.cursor ="hand";
 }
 },

 m0197:function(vc0c92)
 {
 var v99d70;
 var v0b482;

 if (vc0c92.SliderImage =="")
 {
 v0b482 =document.createElement("DIV");
 v0b482.style.background ="buttonface";
 if (vc0c92.Type =="x"){
 v0b482.style.height ="100%";
 v0b482.style.width =vc0c92.SliderSize;
 }
 else {
 v0b482.style.width ="100%";
 v0b482.style.height =vc0c92.SliderSize;
 }
 }
 else
 {
 v0b482 =document.createElement("IMG");
 v0b482.src =vc0c92.SliderImage;
 if (vc0c92.Type =="x"){
 v0b482.height =vc0c92.Height;
 v0b482.width =vc0c92.SliderSize;
 }
 else {
 v0b482.width =vc0c92.Width;
 v0b482.height =vc0c92.SliderSize;
 }
 }

 v0b482.id =vc0c92.Id +"_slider";
 v0b482.style.overflow ="hidden";
 v0b482.style.position ="relative";
 v0b482.style.cursor ="hand";
 v0b482.style.zIndex =2;
 if (vc0c92.Type =="x")
 {
 v99d70 =((vc0c92.Width-vc0c92.SliderSize)/(vc0c92.MaxValue -vc0c92.MinValue));
 v0b482.style.pixelLeft =v99d70 *(vc0c92.Value -vc0c92.MinValue);
 }
 else
 {
 v99d70 =((vc0c92.Height-vc0c92.SliderSize)/(vc0c92.MaxValue -vc0c92.MinValue));
 v0b482.style.pixelTop =v99d70 *(vc0c92.Value -vc0c92.MinValue);
 }

 return v0b482;
 },
 
 m66888:function(v03392)
 {
 var vcfb92 =document.createElement("DIV");
 vcfb92.id =v03392.Id +"_track";
 if (v03392.Type =="x"){
 vcfb92.style.height =v03392.TrackSize;
 vcfb92.style.width =v03392.Width;
 }
 else {
 vcfb92.style.height =v03392.Height;
 vcfb92.style.width =v03392.TrackSize;
 }

 vcfb92.style.overflow ="hidden";
 vcfb92.style.backgroundColor ="LightSteelBlue";
 vcfb92.style.position ="relative";
 vcfb92.style.zIndex =1;
 if (v03392.Type =="x")
 vcfb92.style.pixelTop =Math.round((v03392.Height+v03392.TrackSize)/2)*-1;
 else {
 vcfb92.style.pixelLeft =Math.round((v03392.Width/2)-(v03392.TrackSize/2));
 vcfb92.style.pixelTop =v03392.SliderSize*-1;
 }
 
 vcfb92.style.borderWidth ="1px";
 vcfb92.style.borderStyle ="inset";
 return vcfb92;
 },
 
 m4f110:function(v19192,v17c75,v66118)
 {
 var vd6992 =document.createElement("DIV");
 vd6992.id =v19192.Id;
 vd6992.tabIndex =1;
 if (v19192.Type =="x")
 vd6992.style.cssText ="float:left;overflow:hidden";
 else
 vd6992.style.cssText ="overflow: hidden";
 
 vd6992.style.width =v19192.Width; 
 vd6992.style.height =v19192.Height;
 vd6992.style.backgroundColor ="#ECE9D8"
 vd6992.style.zIndex =0;
 vd6992.appendChild(v17c75);
 if (v66118 !=null)
 vd6992.appendChild(v66118);

 return vd6992;
 },

 mcb09:function(vdc392)
 {
 var v27392 =new String(vdc392.MinValue);
 var v26775 =document.createElement("DIV");
 v26775.id =vdc392.Id +"_minValue"
 v26775.innerText =vdc392.MinValue;
 if (vdc392.Type =="x")
 {
 v26775.style.cssText ="float:left;";
 v26775.style.pixelWidth =(v27392.length *7)+5;
 }
 else
 v26775.style.textAlign ="center";

 v26775.style.height =vdc392.Height;
 v26775.style.lineHeight =v26775.style.height;
 v26775.style.verticalAlign ="middle";
 v26775.style.fontFamily ="verdana,arial,sans-serif";
 v26775.style.fontSize ="11px";
 v26775.style.fontWeight ="bold";
 return v26775;
 },

 m8f054:function (v5c714)
 {
 var v7e714 =new String(v5c714.MaxValue);
 var v85169 =document.createElement("DIV");
 v85169.id =v5c714.Id +"_maxValue"
 v85169.innerText =v5c714.MaxValue;
 if (v5c714.Type =="x")
 {
 v85169.style.cssText ="float:left;";
 v85169.style.pixelWidth =(v7e714.length *7)+5;
 v85169.style.textAlign ="right";
 }
 else
 v85169.style.textAlign ="center"

 v85169.style.height =v5c714.Height;
 v85169.style.lineHeight =v85169.style.height;
 v85169.style.verticalAlign ="middle";
 v85169.style.fontFamily ="verdana,arial,sans-serif";
 v85169.style.fontSize ="11px";
 v85169.style.fontWeight ="bold";
 return v85169;
 },

 m16e67:function()
 {
 var vccf14 =document.createElement("XML");
 vccf14.id ="Slidebar_x";
 vccf14.innerHTML ="<Slidebar width='200' height='5' type='x' value='0' maxvalue='' minvalue=''></Slidebar>";
 return vccf14;
 },
 
 mce546:function(v9e237,vd4562,v61916,v00d1)
 {
 var ve0e14 =eff955.m16e67();
 
 var v4d269 =eff955.m0197(v00d1);

 var v74417 =null;
 if (v00d1.TrackSize >0)
 v74417 =eff955.m66888(v00d1);

 var v2be87 =eff955.m4f110(v00d1,v4d269,v74417);

 var vab083 =eff955.mcb09(v00d1);

 var v68e74 =eff955.m8f054(v00d1);


 var v60357 =document.getElementById(v9e237);
 v60357.style.pixelWidth =vab083.style.pixelWidth +v2be87.style.pixelWidth +v68e74.style.pixelWidth;
 v60357.appendChild(vab083);
 v60357.appendChild(v2be87);
 v60357.appendChild(v68e74);
 document.body.appendChild(ve0e14);
 document.body.appendChild(v60357);

 IS.RuntimeObjects.push(v00d1);

 Listener.Add (document.getElementById(vd4562),"onmousedown",function(){eff955.m65e59(vd4562);});
 Listener.Add (document.getElementById(vd4562+"_track"),"onmousedown",function(){eff955.m65e59(vd4562);});
 Listener.Add (document,"onmouseup",eff955.ma1373);
 Listener.Add (document,"onmousemove",eff955.mf2772);
 Listener.Add (document,"onkeydown",eff955.mad896);
 },

 mdd576:function(vbc359,vb9556,v67a15)
 {
 if (IS.IsAvailableRuntimeObjectById(v67a15))
 {
 objSlidebar =IS.GetRuntimeObjectById(v67a15);
 }

 var v3d859;
 v3d859 =vbc359.parentElement;

 if (vb9556 =="y")
 {
 return ((vbc359.style.pixelTop /(v3d859.offsetHeight -vbc359.offsetHeight))*(parseFloat(objSlidebar.MaxValue)-parseFloat(objSlidebar.MinValue))); }
 else
 {
 return ((vbc359.style.pixelLeft /(v3d859.clientWidth -vbc359.clientWidth))*(parseFloat(objSlidebar.MaxValue)-parseFloat(objSlidebar.MinValue))); }
 
 },
 
 m7c827:function(ve0f59,v2a856){
 var v57859 =v2a856%ve0f59;
 if (v57859 <ve0f59/2)
 {
 return Math.floor(v2a856/ve0f59)*ve0f59;
 }
 else
 {
 return Math.ceil(v2a856/ve0f59)*ve0f59;
 }
 }

 };



function Slidebar(vf7443,vfa082,v2f438,v9c554)
{
 this.Type =v2f438; this.Id =vfa082;
 if (v2f438 =="x")
 {
 this.Width =200; this.Height =20; }
 else
 {
 this.Width =20; 
 this.Height =200; 
 }

 this.SliderSize =10; this.MaxValue =10;
 this.MinValue =0;
 this.Interval =1; this.IntervalLarge =2;
 this.OnChange =null;
 this.OnEnter =null;
 this.OnCancel =null;
 this.Value =3;
 this.SliderImage =v9c554 +"slider.jpg"
 this.TrackSize =5;
 this.ClassName ="Slidebar";
 this.PlaceholderId =vf7443;
 
 this.Initialize =function(vf7443,vfa082,v2f438)
 {
 eff955.mce546(vf7443,vfa082,v2f438,this);
 };
 
 this._onChangeHandler =function()
 {
 if (this.OnChange!=null)
 eval(this.OnChange);
 };

 this._onEnterHandler =function()
 {
 if (this.OnEnter!=null)
 eval(this.OnEnter);
 };

 this._onCancelHandler =function()
 {
 if (this.OnCancel!=null)
 eval(this.OnCancel);
 };

 this.SetActive =function()
 {
 eff955._Id =this.Id;
 eff955._active =true;
 };

 this.Redraw =function()
 {
 var v6ee98 =document.getElementById(this.Id+'_minValue');
 var ve6896 =document.getElementById(this.Id+'_maxValue');
 var vda140 =document.getElementById(this.Id);

 Listener.Remove (document.getElementById(vfa082),"onmousedown",eff955.m65e59);

 var v69927 =document.getElementById(vf7443);
 v69927.removeChild(v6ee98);
 v69927.removeChild(vda140);
 v69927.removeChild(ve6896);
 
 var v27a97 =eff955.m0197(this);
 var v6c560 =null;
 if (this.TrackSize >0)
 v6c560 =eff955.m66888(this);
 var v8ba13 =eff955.m4f110(this,v27a97,v6c560);
 var vf265 =eff955.mcb09(this);
 var v2f256 =eff955.m8f054(this);

 v69927.style.pixelWidth =vf265.style.pixelWidth +v8ba13.style.pixelWidth +v2f256.style.pixelWidth;
 v69927.appendChild(vf265);
 v69927.appendChild(v8ba13);
 v69927.appendChild(v2f256);

 var v3df96 =this.Id;
 Listener.Add (document.getElementById(v3df96),"onmousedown",function(){eff955.m65e59(v3df96);});
 };
 
 this.Initialize(vf7443,vfa082,v2f438);
 ISControl.call(this,vfa082);
 
 this.PreparePostBackData =function(){};
};