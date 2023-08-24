

function HtmlEditor_Editor()
{

 
 this.OnInitialize =function()
 {
 var vd5419 ="<textarea name='txtHtmlEditor' style='WIDTH: 450px; HEIGHT: 250px'></textarea>";
 var vf552 =document.createElement("SPAN");
 vf552.innerHTML =vd5419;
 vf552.style.cssText ="visibility: hidden; background-color: #FFD497; border: black 1px solid";
 this.Grid.FrameObj.appendChild(vf552);
 _editor_url =this.CustomEditor.ScriptFolder +_editor_url;
 editor_generate('txtHtmlEditor');
 };
 
 this.OnUnload =function()
 {
 this =null;
 delete this;
 };
 
 this.OnEnterEditMode =function(v99482,v54d31,v8d717)
 {
 
 var vc7124 =this.GetDropdownButtonElement();
 wgDispObjGeneric(this.Grid,vc7124,v99482.element,v99482.element.offsetWidth-this.CustomEditor.DropdownButtonWidth-2,1,true);
 vc7124.style.height =v99482.element.offsetHeight-2;
 
 this.SetProperties();
 
 vc7124.setActive();
 return this.GetDropdownObject();
 };
 
 this.OnSetValue =function(v91765,v99482)
 {
 if (!this.ControlCreated)return false;
 
 var v07485 =this.GetContentCell();
 var v68c53 =this.GetTextEditor();
 
 this.OriginalText =v07485.innerHTML;
 
 editor_setHTML('txtHtmlEditor',this.OriginalText);
 v68c53.isDirty =false;
 };
 
 this.OnDirty =function(){
 var v68c53 =this.GetTextEditor();
 v68c53.isDirty =true;
 this.CustomEditor.CellDirty(); };
 
 this.OnExitEditMode =function(vfff10){
 var vc7124 =this.GetDropdownButtonElement();
 vc7124.style.display ="none";

 if (!this.CustomEditor.IsRowDirty())
 this.OnCancel();
 
 this.CloseDropdown();
 return true;
 };
 
 this.OnApply =function()
 {
 
 var v68c53 =this.GetTextEditor();
 var v07485 =this.GetContentCell();
 var v44865 =editor_getHTML('txtHtmlEditor');
 
 if (v44865 !="")
 {
 var v39f89 =new RegExp("\r\n","g");
 v44865 =v44865.replace(v39f89,"");
 }
 
 v07485.innerHTML =v44865;
 
 this.CustomEditor.RowDirty(); this.OnDirty(); this.CloseDropdown();
 };
 
 this.OnCancel =function()
 {
 this.CloseDropdown();
 };

 this.OnValidate =function(v29033)
 {
 
 };
 
 this.OnKeyDown =function(v28022)
 {

 };
 
 this.OnDropdown =function()
 {
 var v3cc97 =this.GetDropdownObject();
 v3cc97.style.cssText ="visibility: visible; background-color: #FFD497; border: black 1px solid";
 var v99482 =this.CustomEditor.GetEditCell();
 if (!v3cc97.initialized){
 var v44865 =this.InitializeDropdownObject();
 if (!v44865)return;
 }
 
 if (!this.Grid.GetLastEditObject())
 {
 var v43271 =document.createEventObject();
 var v0f921 =this.CustomEditor.GetEditCellElement();
 v43271.keyCode =13;
 v43271._srcElement =v0f921;
 v0f921.fireEvent("onkeydown",v43271);
 }
 
 wgDispObjGeneric(this.Grid,v3cc97,v99482.element,1,v99482.element.offsetHeight,true);

 var ve0930 =parseFloat(v3cc97.style.left);
 var v99646 =parseFloat(v3cc97.style.top);
 var v0ff33 =parseFloat(v3cc97.offsetWidth);
 var v09396 =parseFloat(v3cc97.offsetHeight);
 
 if (ve0930+v0ff33 >document.body.offsetWidth)
 v3cc97.style.left =ve0930 -((ve0930+v0ff33)-document.body.offsetWidth)-50;
 
 if (v99646+v09396 >document.body.offsetHeight){
 var v5e67 =v99646 -((v99646+v09396)-document.body.offsetHeight)-20;
 if (v5e67 <0)v5e67 =25;
 v3cc97.style.top =v5e67;
 }
 var v86a4 =this.GetDropdownButtonElement();
 v86a4.style.zIndex =v3cc97.style.zIndex -1;

 var v62f83 =document.getElementById('_txtHtmlEditor_FontName').style.display;
 document.getElementById('_txtHtmlEditor_FontName').style.display ="none";
 document.getElementById('_txtHtmlEditor_FontName').style.display =v62f83;

 var vb8d66 =document.getElementById('_txtHtmlEditor_FontSize').style.display;
 document.getElementById('_txtHtmlEditor_FontSize').style.display ="none";
 document.getElementById('_txtHtmlEditor_FontSize').style.display =vb8d66;


 editor_focus(this.GetTextEditor());
 };

 this.GetBaseEditorElement =function()
 {
 return true;
 };
 
 this.GetDropdownButtonElement =function()
 {
 if (this.DDBtn ==null)
 {
 var v58e58 =this.CustomEditor.ScriptFolder +"RichTextBox.gif";
 var v9f61 ="<img title='Click to Edit' style='top: expression(((this.parentElement.offsetHeight/2)-8)); position: relative;' src='" +v58e58 +"'>";
 var vf552 =document.createElement("SPAN");
 vf552.innerHTML =v9f61;
 vf552.style.cssText ="background-color: #FFD497; border: black 1px solid; cursor: hand";
 this.DDBtn =this.Grid.FrameObj.appendChild(vf552);
 }
 
 var v93086 =this.Grid.Name;
 var v7d250 =this.CustomEditor.Name;
 var v4d572 =this.DDBtn;
 v4d572.onclick =function(){RichTextBox_ImgClick(v4d572,v93086,v7d250);};
 v4d572.onkeydown =function(){RichTextBox_KeyDown(v4d572,v93086,v7d250);};

 return v4d572;
 };
 
 this.GetDropdownObject =function()
 {
 
 var v88135 =document.getElementById('txtHtmlEditor');
 if (!v88135)
 {
 this.ControlCreated =false;
 return false;
 }
 var v1103 =v88135.parentElement;
 
 return v1103;
 };

 this.IsDirty =function()
 {
 var v68c53 =this.GetTextEditor();
 return v68c53.isDirty;
 };
 
 this.GetText =function()
 {
 return this.OriginalText;
 };
 
 this.GetValue =function()
 {
 return this.GetText();
 };
 
 this.SetProperties =function()
 {
 var v92f31 =this.CustomEditor.GetColumnEditorProperties();
 var vbdd62 =v92f31.split(";");
 for (var v7f330=0; v7f330<vbdd62.length; v7f330++)
 {
 this.SetProperty(vbdd62[v7f330].split("=")[0],vbdd62[v7f330].split("=")[1]);
 }
 };
 
 
 this.ShouldProcessExitEditModeDefaultBehavior =function()
 {
 return false;
 };
 
 this.GetContentMode =function()
 {
 return "HTML";
 };
 
 
 



 this.Grid =null;
 this.CustomEditor =null;
 
 this.DDBtn =null;
 this.ControlName ="HtmlEditor";
 this.OriginalText ="";
 this.ControlCreated =true;
 
 this.SetProperty =function(v93a67,v4f146)
 {

 
 };

 this.InitializeDropdownObject =function()
 {
 
 var v3cc97 =this.GetDropdownObject();
 
 this.GetTextEditor().style.backgroundColor ="white";
 this.GetTextEditor().onselectstart =function(){event.cancelBubble=true;};
 this.GetButtonBar().style.backgroundColor ="lightgrey";
 
 var v46b0 =this.GetButtonBar().getElementsByTagName("button");
 var v4ac96 =this;
 v46b0[0].onclick =function(){v4ac96.OnCancel();}
 v46b0[1].onclick =function(){v4ac96.OnApply();}
 
 v3cc97.initialized =true;
 return true;
 };
 
 this.GetEditorToolbar =function()
 {
 var v43076 =document.all["_editor_toolbar"];

 return v43076;
 }

 this.GetTextEditor =function()
 {
 var v22443 =document.all["_txtHtmlEditor_editor"];
 
 return v22443;
 };
 
 this.GetButtonBar =function()
 {
 var v0e090 =document.getElementById("_editor_footer");
 
 return v0e090;
 };
 
 this.CloseDropdown =function()
 {
 var v3cc97 =this.GetDropdownObject();
 v3cc97.style.display ="none";
 };
 
 this.GetContentCell =function()
 {
 var vc3d40 =this.CustomEditor.GetEditRowElement();
 if (wgIsRecordRow(vc3d40))
 {
 return this.CustomEditor.GetEditCellElement().childNodes[0];
 }
 else
 {
 return this.CustomEditor.GetEditCellElement();
 }
 };
 
 
return this;
}

function RichTextBox_ImgClick(vfb957,veef19,v8500)
{
var v46e34 =wgGetGridById(veef19);
var va6626 =v46e34.CustomEditors[v8500];
va6626.ImplementationObject.OnDropdown();
}

function RichTextBox_KeyDown(v6b469,v57286,v35c95)
{
var v9a12 =event.keyCode;
var v9256 =wgGetGridById(v57286);
var v29c98 =v9256.CustomEditors[v35c95];
var v75584 =v29c98.ImplementationObject;

switch (v9a12)
{
 case 13:
 case 115:
 case 32:
 v75584.OnDropdown();
 break;
 case 27:
 v75584.OnExitEditMode(true);
 v29c98.GetEditCellElement().setActive();
 v29c98.ClearEditObject();
 break;
}
event.cancelBubble =true;
event.keyCode =0;
event.returnValue =false;
}







_editor_url ="html_editor/"; var win_ie_ver =parseFloat(navigator.appVersion.split("MSIE")[1]);
if (navigator.userAgent.indexOf('Mac')>=0){win_ie_ver =0; }
if (navigator.userAgent.indexOf('Windows CE')>=0){win_ie_ver =0; }
if (navigator.userAgent.indexOf('Opera')>=0){win_ie_ver =0; }
if (win_ie_ver >=5.5){
 document.write('<scr' +'ipt src="' +_editor_url+'editor.js"');
 document.write(' language="Javascript"></scr' +'ipt>'); 
}else {document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); }


document.write('<style type="text/css">\n');
document.write('.btn     { width: 22px; height: 22px; border: 1px solid buttonface; margin: 0; padding: 0; }\n');
document.write('.btnOver { width: 22px; height: 22px; border: 1px outset; }\n');
document.write('.btnDown { width: 22px; height: 22px; border: 1px inset; background-color: buttonhighlight; }\n');
document.write('.btnNA   { width: 22px; height: 22px; border: 1px solid buttonface; filter: alpha(opacity=25); }\n');
document.write('.cMenu     { background-color: threedface; color: menutext; cursor: Default; font-family: MS Sans Serif; font-size: 8pt; padding: 2 12 2 16; }');
document.write('.cMenuOver { background-color: highlight; color: highlighttext; cursor: Default; font-family: MS Sans Serif; font-size: 8pt; padding: 2 12 2 16; }');
document.write('.cMenuDivOuter { background-color: threedface; height: 9 }');
document.write('.cMenuDivInner { margin: 0 4 0 4; border-width: 1; border-style: solid; border-color: threedshadow threedhighlight threedhighlight threedshadow; }');
document.write('</style>\n');




function editor_defaultConfig(v2cd69){

this.version ="2.03"

this.width ="auto";
this.height ="auto";
this.bodyStyle ='background-color: #FFFFFF; font-family: "Verdana"; font-size: x-small;';
this.imgURL =_editor_url +'editor_images/';
this.debug =0;

this.replaceNextlines =0; this.plaintextInput =0; 
this.toolbar =[
 ['fontname'],
 ['fontsize'],
 ['bold','italic','underline','separator'],
 ['strikethrough','subscript','superscript','separator'],
 ['justifyleft','justifycenter','justifyright','separator'],
 ['OrderedList','UnOrderedList','Outdent','Indent','separator'],
 ['forecolor','backcolor','separator'],
 ['HorizontalRule','Createlink','InsertImage','InsertTable','htmlmode','separator'],
 ['popupeditor']];
 
this.fontnames ={
 "Arial": "arial, helvetica, sans-serif",
 "Courier New": "courier new, courier, mono",
 "Georgia": "Georgia, Times New Roman, Times, Serif",
 "Tahoma": "Tahoma, Arial, Helvetica, sans-serif",
 "Times New Roman": "times new roman, times, serif",
 "Verdana": "Verdana, Arial, Helvetica, sans-serif",
 "impact": "impact",
 "WingDings": "WingDings"};

this.fontsizes ={
 "1 (8 pt)": "1",
 "2 (10 pt)": "2",
 "3 (12 pt)": "3",
 "4 (14 pt)": "4",
 "5 (18 pt)": "5",
 "6 (24 pt)": "6",
 "7 (36 pt)": "7"
 };


this.fontstyles =[ ];

this.btnList ={
 "bold": ['Bold','Bold','editor_action(this.id)','ed_format_bold.gif'],
 "italic": ['Italic','Italic','editor_action(this.id)','ed_format_italic.gif'],
 "underline": ['Underline','Underline','editor_action(this.id)','ed_format_underline.gif'],
 "strikethrough": ['StrikeThrough','Strikethrough','editor_action(this.id)','ed_format_strike.gif'],
 "subscript": ['SubScript','Subscript','editor_action(this.id)','ed_format_sub.gif'],
 "superscript": ['SuperScript','Superscript','editor_action(this.id)','ed_format_sup.gif'],
 "justifyleft": ['JustifyLeft','Justify Left','editor_action(this.id)','ed_align_left.gif'],
 "justifycenter": ['JustifyCenter','Justify Center','editor_action(this.id)','ed_align_center.gif'],
 "justifyright": ['JustifyRight','Justify Right','editor_action(this.id)','ed_align_right.gif'],
 "orderedlist": ['InsertOrderedList','Ordered List','editor_action(this.id)','ed_list_num.gif'],
 "unorderedlist": ['InsertUnorderedList','Bulleted List','editor_action(this.id)','ed_list_bullet.gif'],
 "outdent": ['Outdent','Decrease Indent','editor_action(this.id)','ed_indent_less.gif'],
 "indent": ['Indent','Increase Indent','editor_action(this.id)','ed_indent_more.gif'],
 "forecolor": ['ForeColor','Font Color','editor_action(this.id)','ed_color_fg.gif'],
 "backcolor": ['BackColor','Background Color','editor_action(this.id)','ed_color_bg.gif'],
 "horizontalrule": ['InsertHorizontalRule','Horizontal Rule','editor_action(this.id)','ed_hr.gif'],
 "createlink": ['CreateLink','Insert Web Link','editor_action(this.id)','ed_link.gif'],
 "insertimage": ['InsertImage','Insert Image','editor_action(this.id)','ed_image.gif'],
 "inserttable": ['InsertTable','Insert Table','editor_action(this.id)','insert_table.gif'],
 "htmlmode": ['HtmlMode','View HTML Source','editor_setmode(\''+v2cd69+'\')','ed_html.gif'],
 "popupeditor": ['popupeditor','Enlarge Editor','editor_action(this.id)','fullscreen_maximize.gif'],
 "about": ['about','About this editor','editor_about(\''+v2cd69+'\')','ed_about.gif'],

 "custom1": ['custom1','Purpose of button 1','editor_action(this.id)','ed_custom.gif'],
 "custom2": ['custom2','Purpose of button 2','editor_action(this.id)','ed_custom.gif'],
 "custom3": ['custom3','Purpose of button 3','editor_action(this.id)','ed_custom.gif'],
 
 "help": ['showhelp','Help using editor','editor_action(this.id)','ed_help.gif']};


}




function editor_generate(v6fc94,v00b18){

 var vd8314 =new editor_defaultConfig(v6fc94);
 if (v00b18){
 for (var thisName in v00b18){
 if (v00b18[thisName]){vd8314[thisName] =v00b18[thisName]; }
 }
 }
 document.all[v6fc94].config =vd8314; 
 var v7e773 =document.all[v6fc94];
 if (!vd8314.width ||vd8314.width =="auto"){
 if (v7e773.style.width){vd8314.width =v7e773.style.width; }else if (v7e773.cols){vd8314.width =(v7e773.cols *8)+22; }else {vd8314.width ='100%'; }}
 if (!vd8314.height ||vd8314.height =="auto"){
 if (v7e773.style.height){vd8314.height =v7e773.style.height; }else if (v7e773.rows){vd8314.height =v7e773.rows *17 }else {vd8314.height ='200'; }}

 var vfb293 ='<table border=0 cellspacing=0 cellpadding=0 style="float: left;"  unselectable="on"><tr><td style="border: none; padding: 1 0 0 0"><nobr>';
 var ve8451 ='</nobr></td></tr></table>\n';

 
 var vf8347 ='';
 var btnGroup,btnItem,aboutEditor;
 for (var btnGroup in vd8314.toolbar){

 if (vd8314.toolbar[btnGroup].length ==1 &&
 vd8314.toolbar[btnGroup][0].toLowerCase()=="linebreak"){
 vf8347 +='<br clear="all">';
 continue;
 }

 vf8347 +=vfb293;
 for (var btnItem in vd8314.toolbar[btnGroup]){
 var v0e429 =vd8314.toolbar[btnGroup][btnItem].toLowerCase();

 if (v0e429 =="fontname"){
 vf8347 +='<select id="_' +v6fc94+'_FontName" onChange="editor_action(this.id)" unselectable="on" style="margin: 1 2 0 2; font-size: 12px;">';
 for (var fontname in vd8314.fontnames){
 vf8347 +='<option value="' +vd8314.fontnames[fontname]+'">' +fontname+'</option>'
 }
 vf8347 +='</select>';
 continue;
 }

 if (v0e429 =="fontsize"){
 vf8347 +='<select id="_' +v6fc94+'_FontSize" onChange="editor_action(this.id)" unselectable="on" style="margin: 1 2 0 0; font-size: 12px;">';
 for (var fontsize in vd8314.fontsizes){
 vf8347 +='<option value="' +vd8314.fontsizes[fontsize]+'">' +fontsize+'</option>'
 }
 vf8347 +='</select>\n';
 continue;
 }

 if (v0e429 =="fontstyle"){
 vf8347 +='<select id="_' +v6fc94+'_FontStyle" onChange="editor_action(this.id)" unselectable="on" style="margin: 1 2 0 0; font-size: 12px;">';
 +'<option value="">Font Style</option>';
 for (var i in vd8314.fontstyles){
 var v6ed5 =vd8314.fontstyles[i];
 vf8347 +='<option value="' +v6ed5.className+'">' +v6ed5.name+'</option>'
 }
 vf8347 +='</select>';
 continue;
 }

 if (v0e429 =="separator"){
 vf8347 +='<span style="border: 1px inset; width: 1px; font-size: 16px; height: 16px; margin: 0 3 0 3"></span>';
 continue;
 }

 var vc7411 =vd8314.btnList[v0e429];
 if (v0e429 =='linebreak'){alert("htmlArea error: 'linebreak' must be in a subgroup by itself, not with other buttons.\n\nhtmlArea wysiwyg editor not created."); return; }
 if (!vc7411){alert("htmlArea error: button '" +v0e429+"' not found in button list when creating the wysiwyg editor for '"+v6fc94+"'.\nPlease make sure you entered the button name correctly.\n\nhtmlArea wysiwyg editor not created."); return; }
 var v24b54 =vc7411[0];
 var va9c77 =vc7411[1];
 var v6e636 =vc7411[2];
 var vaba46 =vc7411[3];
 vf8347 +='<button title="' +va9c77+'" id="_' +v6fc94+'_' +v24b54+'" class="btn" onClick="' +v6e636+'" onmouseover="if(this.className==\'btn\'){this.className=\'btnOver\'}" onmouseout="if(this.className==\'btnOver\'){this.className=\'btn\'}" unselectable="on"><img src="' +vd8314.imgURL +vaba46+'" border=0 unselectable="on"></button>';


 }vf8347 +=ve8451;
 }
 
 var v40696 ='<span id="_editor_toolbar"><table border=0 cellspacing=0 cellpadding=0 bgcolor="buttonface" style="padding: 1 0 0 2" width=' +vd8314.width +' unselectable="on"><tr><td>\n'
 +vf8347
 +'</td></tr></table>\n'
 +'</td></tr></table></span>\n'
 +'<textarea ID="_' +v6fc94 +'_editor" style="width:' +vd8314.width+'; height:' +vd8314.height+'; margin-top: -1px; margin-bottom: -1px;" wrap=soft></textarea>';

 v40696 +='<div id="_' +v6fc94 +'_cMenu" style="position: absolute; visibility: hidden;"></div>';

 if (!vd8314.debug){document.all[v6fc94].style.display ="none"; }

 if (vd8314.plaintextInput){var v50134 =document.all[v6fc94].value;
 v50134 =v50134.replace(/\r\n/g,'<br>');
 v50134 =v50134.replace(/\n/g,'<br>');
 v50134 =v50134.replace(/\r/g,'<br>');
 document.all[v6fc94].value =v50134;
 }

 v40696 +='<br><div id="_editor_footer" align="right" style="width:'+vd8314.width +'; background:lightgrey"><button value="Cancel">Cancel</button> <button value="Update">Update</button></div>';

 document.all[v6fc94].insertAdjacentHTML('afterEnd',v40696)

 editor_setmode(v6fc94,'init');

 for (var ve8e38=0; ve8e38 <document.forms.length; ve8e38++){
 var vd9636 =document.forms[ve8e38].attachEvent('onsubmit',function(){editor_filterOutput(v6fc94); });
 if (!vd9636){alert("Error attaching event to form!"); }
 }

return true;

}



function editor_action(v5864){

 var v19c6 =Array();
 v19c6 =v5864.split("_");
 var vfd085 =v5864.replace(/^_(.*)_[^_]*$/,'$1');
 var v86a29 =v19c6[ v19c6.length-1 ];
 var vabc16 =document.all[v5864];
 var v43c91 =document.all["_" +vfd085 +"_editor"];
 var v7ed55 =document.all[vfd085].config;

 if (v86a29 =='showhelp'){
 window.open(_editor_url +"popups/editor_help.html",'EditorHelp');
 return;
 }

 if (v86a29 =='popupeditor'){
 window.open(_editor_url +"popups/fullscreen.html?"+vfd085,
 'FullScreen',
 'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width=640,height=480');
 return;
 }

 if (v43c91.tagName.toLowerCase()=='textarea'){return; }

 var v7a135 =v43c91.contentWindow.document;
 editor_focus(v43c91);

 var v8b716 =vabc16.selectedIndex;
 var ve0749 =(v8b716 !=null)? vabc16[ v8b716 ].value : null;

 if (0){}
 
 else if (v86a29 =='custom1'){
 alert("Hello, I am custom button 1!");
 }

 else if (v86a29 =='custom2'){var v84c83 ="This is a custom title";
 var v5a222 =showModalDialog(_editor_url +"popups/custom2.html",
 v84c83,"resizable: yes; help: no; status: no; scroll: no; ");
 if (v5a222){editor_insertHTML(vfd085,v5a222); }
 }

 else if (v86a29 =='custom3'){editor_insertHTML(vfd085,"It's easy to add buttons that insert text!");
 }

 
 else if (v86a29 =='FontName' &&ve0749){
 v7a135.execCommand(v86a29,0,ve0749);
 }

 else if (v86a29 =='FontSize' &&ve0749){
 v7a135.execCommand(v86a29,0,ve0749);
 }

 else if (v86a29 =='FontStyle' &&ve0749){
 v7a135.execCommand('RemoveFormat');
 v7a135.execCommand('FontName',0,'636c6173734e616d6520706c616365686f6c646572');
 var vcfe88 =v7a135.all.tags("FONT");
 for (v1c495=0; v1c495<vcfe88.length; v1c495++){
 if (vcfe88[v1c495].face =='636c6173734e616d6520706c616365686f6c646572'){
 vcfe88[v1c495].face ="";
 vcfe88[v1c495].className =ve0749;
 vcfe88[v1c495].outerHTML =vcfe88[v1c495].outerHTML.replace(/face=['"]+/, "");
        }
    }
    button_obj.selectedIndex =0;
  }

  // fgColor and bgColor
  else if (v86a29 == 'ForeColor' || v86a29 == 'BackColor') {
    var oldcolor = _dec_to_rgb(v7a135.queryCommandValue(v86a29));
    var newcolor = showModalDialog(_editor_url + "popups/select_color.html", oldcolor, "resizable: no; help: no; status: no; scroll: no;");
    if (newcolor != null) { v7a135.execCommand(v86a29, false, "#"+newcolor); }
  }

  // execute command for buttons - if we didn't catch the v86a29 by here we'll assume it's a
 else {
 if (v86a29.toLowerCase()=='subscript' &&v7a135.queryCommandState('superscript')){v7a135.execCommand('superscript'); }
 if (v86a29.toLowerCase()=='superscript' &&v7a135.queryCommandState('subscript')){v7a135.execCommand('subscript'); }

 if (v86a29.toLowerCase()=='createlink'){
 v7a135.execCommand(v86a29,1);
 }

 else if (v86a29.toLowerCase()=='insertimage'){
 showModalDialog(_editor_url +"popups/insert_image.html",v7a135,"resizable: no; help: no; status: no; scroll: no; ");
 }

 else if (v86a29.toLowerCase()=='inserttable'){
 showModalDialog(_editor_url +"popups/insert_table.html?"+vfd085,
 window,
 "resizable: yes; help: no; status: no; scroll: no; ");
 }

 else {v7a135.execCommand(v86a29); }
 }

 editor_event(vfd085);
}



function editor_event(vfd085,runDelay){
 var v7ed55 =document.all[vfd085].config;
 var v43c91 =document.all["_" +vfd085+"_editor"]; if (runDelay ==null){runDelay =0; }
 var v7a135;
 var v29229 =v43c91.contentWindow ? v43c91.contentWindow.event : v90b8;

 if (v29229 &&v29229.keyCode){
 var ve5439 =v29229.keyCode; var v82a72 =v29229.ctrlKey;
 var vc675 =v29229.altKey;
 var v96c83 =v29229.shiftKey;

 if (ve5439 ==16){return; }if (ve5439 ==17){return; }if (ve5439 ==18){return; }

 
 if (v82a72 &&(ve5439 ==122 ||ve5439 ==90)){return;
 }
 if ((v82a72 &&(ve5439 ==121 ||ve5439 ==89))||
 v82a72 &&v96c83 &&(ve5439 ==122 ||ve5439 ==90)){return;
 }
 }

 if (runDelay >0){return setTimeout(function(){editor_event(vfd085); },runDelay); }

 if (this.tooSoon ==1 &&runDelay >=0){this.queue =1; return; }this.tooSoon =1;
 setTimeout(function(){
 this.tooSoon =0;
 if (this.queue){editor_event(vfd085,-1); };
 this.queue =0;
 },333); 

 editor_updateOutput(vfd085);
 editor_updateToolbar(vfd085);

}



function editor_updateToolbar(vfd085,v26018){
 var v7ed55 =document.all[vfd085].config;
 var v43c91 =document.all["_" +vfd085+"_editor"];

 
 if (v26018 =="enable" ||v26018 =="disable"){
 var v07c12 =new Array('FontName','FontSize','FontStyle'); for (var btnName in v7ed55.btnList){v07c12.push(v7ed55.btnList[btnName][0]); }
 for (var idxN in v07c12){
 var v86a29 =v07c12[idxN].toLowerCase();
 var v51c75 =document.all["_" +vfd085+"_" +v07c12[idxN]];
 if (v86a29 =="htmlmode" ||v86a29 =="about" ||v86a29 =="showhelp" ||v86a29 =="popupeditor"){continue; }if (v51c75 ==null){continue; }
 var vfcf18 =(v51c75.tagName.toLowerCase()=="button")? true : false;

 if (v26018 =="enable"){v51c75.disabled =false; if (vfcf18){v51c75.className ='btn' }}
 if (v26018 =="disable"){v51c75.disabled =true; if (vfcf18){v51c75.className ='btnNA' }}
 }
 return;
 }

 
 if (v43c91.tagName.toLowerCase()=='textarea'){return; }var v7a135 =v43c91.contentWindow.document;

 var v69e46 =document.all["_" +vfd085+"_FontName"];
 if (v69e46){
 var v9bc10 =v7a135.queryCommandValue('FontName');
 if (v9bc10 ==null){v69e46.value =null; }
 else {
 var v97f89 =0;
 for (v1c495=0; v1c495<v69e46.length; v1c495++){
 if (v9bc10.toLowerCase()==v69e46[v1c495].text.toLowerCase()){
 v69e46.selectedIndex =v1c495;
 v97f89 =1;
 }
 }
 if (v97f89 !=1){v69e46.value =null; }}
 }

 var v58762 =document.all["_" +vfd085+"_FontSize"];
 if (v58762){
 var v14270 =v7a135.queryCommandValue('FontSize');
 if (v14270 ==null){v58762.value =null; }
 else {
 var v97f89 =0;
 for (v1c495=0; v1c495<v58762.length; v1c495++){
 if (v14270 ==v58762[v1c495].value){v58762.selectedIndex =v1c495; v97f89=1; }
 }
 if (v97f89 !=1){v58762.value =null; }}
 }

 var va4c3 =document.all["_" +vfd085+"_FontStyle"];
 if (va4c3){
 var vcfb16 =v7a135.selection.createRange();

 var ve3576;
 if (vcfb16.length){ve3576 =vcfb16[0]; }else {ve3576 =vcfb16.parentElement(); }while (ve3576 &&!ve3576.className){ve3576 =ve3576.parentElement; }
 var v6607 =ve3576 ? ve3576.className.toLowerCase(): "";
 if (!v6607 &&va4c3.value){va4c3.value =null; }
 else {
 var v97f89 =0;
 for (v1c495=0; v1c495<va4c3.length; v1c495++){
 if (v6607 ==va4c3[v1c495].value.toLowerCase()){
 va4c3.selectedIndex =v1c495;
 v97f89=1;
 }
 }
 if (v97f89 !=1){va4c3.value =null; }}
 }

 var vfba0 =Array('Bold','Italic','Underline','StrikeThrough','SubScript','SuperScript','JustifyLeft','JustifyCenter','JustifyRight','InsertOrderedList','InsertUnorderedList');
 for (v1c495=0; v1c495<vfba0.length; v1c495++){
 var vbb196 =document.all["_" +vfd085+"_" +vfba0[v1c495]];
 if (vbb196 ==null){continue; }
 var vff070 =v7a135.queryCommandState(vfba0[v1c495] );

 if (!vff070){if (vbb196.className !='btn'){vbb196.className ='btn'; }
 if (vbb196.disabled !=false){vbb196.disabled =false; }
 }else if (vff070){if (vbb196.className !='btnDown'){vbb196.className ='btnDown'; }
 if (vbb196.disabled !=false){vbb196.disabled =false; }
 }
 }
}



function editor_updateOutput(vfd085){
 var v7ed55 =document.all[vfd085].config;
 var v43c91 =document.all["_" +vfd085+"_editor"]; var v29229 =v43c91.contentWindow ? v43c91.contentWindow.event : v90b8;
 var v47673 =(v43c91.tagName.toLowerCase()=='textarea');
 var v7a135 =v47673 ? null : v43c91.contentWindow.document;

 var v62867;
 if (v47673){v62867 =v43c91.value; }
 else {v62867 =v7a135.body.innerHTML; }

 if (v7ed55.lastUpdateOutput &&v7ed55.lastUpdateOutput ==v62867){return; }
 else {v7ed55.lastUpdateOutput =v62867; }

 document.all[vfd085].value =v62867;

}



function editor_filterOutput(vfd085){
 editor_updateOutput(vfd085);
 var v62867 =document.all[vfd085].value;
 var v7ed55 =document.all[vfd085].config;

 if (v62867.toLowerCase()=='<p>&nbsp;</p>'){v62867 =""; }

 var veda97 =function(v23694,v1f535,vf2425){
 v1f535 =v1f535.toLowerCase();
 var va4460 =(v23694.match(/^<\//)) ? true : false;
 if (v1f535 =='img'){v23694 =v23694.replace(/(src\s*=\s*.)[^*]*(\*\*\*)/,"$1$2"); }
 if (v1f535 =='a'){v23694 =v23694.replace(/(href\s*=\s*.)[^*]*(\*\*\*)/,"$1$2"); }

 
 
 return v23694;
 };

 RegExp.lastIndex =0;
 var v95779 =/<\/?(\w+)((?:[^'">]*|'[^']*'|"[^"]*")*)>/g;   // this will match tags, but still doesn't handle container tags (textarea, comments, etc)

  contents = contents.replace(matchTag, filterTag);

  // remove nextlines from output (if requested)
  if (config.replaceNextlines) { 
    contents = contents.replace(/\r\n/g, ' ');
    contents = contents.replace(/\n/g, ' ');
    contents = contents.replace(/\r/g, ' ');
  }

  // update output with filtered content
  document.all[objname].value = contents;

}

/* ---------------------------------------------------------------------- *\
  Function    : editor_setmode
  Description : change mode between WYSIWYG and HTML editor
  Usage       : editor_setmode(objname, mode);
  Arguments   : objname - button id string with editor and action name
                mode      - init, textedit, or wysiwyg
\* ---------------------------------------------------------------------- */

function editor_setmode(objname, mode) {
  var config     = document.all[objname].config;
  var editor_obj = document.all["_" +objname + "_editor"];

  // wait until document is fully loaded
  if (document.readyState != 'complete') {
    setTimeout(function() { editor_setmode(objname,mode) }, 25);
    return;
  }

  // define different editors
  var TextEdit   = '<textarea ID="_' +objname + '_editor" style="width:' +editor_obj.style.width+ '; height:' +editor_obj.style.height+ '; margin-v65333: -1px; margin-bottom: -1px;"></textarea>';
  var RichEdit   = '<iframe ID="_' +objname+ '_editor"    style="width:' +editor_obj.style.width+ '; height:' +editor_obj.style.height+ ';"></iframe>';

 // src="' +_editor_url+ 'popups/blank.html"

  //
  // Switch to TEXTEDIT mode
  //

  if (mode == "textedit" || editor_obj.tagName.toLowerCase() == 'iframe') {
    config.mode = "textedit";
    var editdoc = editor_obj.contentWindow.document;
    var contents = editdoc.body.createTextRange().htmlText;
    editor_obj.outerHTML = TextEdit;
    editor_obj = document.all["_" +objname + "_editor"];
    editor_obj.value = contents;
    editor_event(objname);

    editor_updateToolbar(objname, "disable");  // disable toolbar items

    // set event handlers
    editor_obj.onkeydown   = function() { editor_event(objname); }
    editor_obj.onkeypress  = function() { editor_event(objname); }
    editor_obj.onkeyup     = function() { editor_event(objname); }
    editor_obj.onmouseup   = function() { editor_event(objname); }
    editor_obj.ondrop      = function() { editor_event(objname, 100); }     // these events fire before they occur
    editor_obj.oncut       = function() { editor_event(objname, 100); }
    editor_obj.onpaste     = function() { editor_event(objname, 100); }
    editor_obj.onblur      = function() { editor_event(objname, -1); }

    editor_updateOutput(objname);
    editor_focus(editor_obj);
  }

  //
  // Switch to WYSIWYG mode
  //

  else {
    config.mode = "wysiwyg";
    var contents = editor_obj.value;
    if (mode == 'init') { contents = document.all[objname].value; } // on init use original textarea content

    // create editor
    editor_obj.outerHTML = RichEdit;
    editor_obj = document.all["_" +objname + "_editor"];

    // get iframe document object

    // create editor contents (and default styles for editor)
    var html = "";
    html += '<html><head>\n';
    if (config.stylesheet) {
      html += '<link href="' +config.stylesheet+ '" rel="stylesheet" type="text/css">\n';
    }
    html += '<style>\n';
    html += 'body {' +config.bodyStyle+ '} \n';
    for (var i in config.fontstyles) {
      var fontstyle = config.fontstyles[i];
      if (fontstyle.classStyle) {
        html += '.' +fontstyle.className+ ' {' +fontstyle.classStyle+ '}\n';
      }
    }
    html += '</style>\n'
      + '</head>\n'
      + '<body contenteditable="true" topmargin=1 leftmargin=1'

// still working on this
//      + ' oncontextmenu="parent.editor_cMenu_generate(window,\'' +vfd085+'\');"'
 +'>'
 +contents
 +'</body>\n'
 +'</html>\n';

 var v7a135 =editor_obj.contentWindow.document;

 v7a135.open();
 v7a135.write(html);
 v7a135.close();

 editor_updateToolbar(objname,"enable"); 
 v7a135.objname =objname;

 v7a135.onkeydown =function(){editor_event(objname); }
 v7a135.onkeypress =function(){editor_event(objname); }
 v7a135.onkeyup =function(){editor_event(objname); }
 v7a135.onmouseup =function(){editor_event(objname); }
 v7a135.body.ondrop =function(){editor_event(objname,100); }
 v7a135.body.oncut =function(){editor_event(objname,100); }
 v7a135.body.onpaste =function(){editor_event(objname,100); }
 v7a135.body.onblur =function(){editor_event(objname,-1); }

 if (mode !='init'){editor_focus(v43c91);
 }

 }

 if (mode !='init'){editor_event(vfd085);
 }

}



function editor_focus(v43c91){

 if (v43c91.tagName.toLowerCase()=='textarea'){var v9bb72 =function(){if((v43c91.style.visibility =='visible')&&(!v43c91.disabled))v43c91.focus(); };
 setTimeout(v9bb72,100); }

 else {var v7a135 =v43c91.contentWindow.document; var v42026 =v7a135.body.createTextRange(); var vcfb16 =v7a135.selection.createRange(); 
 if (vcfb16.length ==null &&!v42026.inRange(vcfb16)){v42026.collapse(); v42026.select(); vcfb16 =v42026;
 }
 }

}



function editor_about(vfd085){
 showModalDialog(_editor_url +"popups/about.html",window,"resizable: yes; help: no; status: no; scroll: no; ");
}



function _dec_to_rgb(value){
 var v9c681 ="";
 for (var v74a4 =0; v74a4 <3; v74a4++){
 var v2e891 =value &0xFF; value >>=8; var vc1945 =v2e891 &0x0F; var v66b22 =(v2e891 >>4)&0x0F; v9c681 +=v66b22.toString(16); v9c681 +=vc1945.toString(16); }
 return v9c681.toUpperCase();
}



function editor_insertHTML(vfd085,str1,str2,reqSel){
 var v7ed55 =document.all[vfd085].config;
 var v43c91 =document.all["_" +vfd085 +"_editor"]; if (str1 ==null){str1 =''; }
 if (str2 ==null){str2 =''; }

 if (document.all[vfd085] &&v43c91 ==null){
 document.all[vfd085].focus();
 document.all[vfd085].value =document.all[vfd085].value +str1 +str2;
 return;
 }

 if (v43c91 ==null){return alert("Unable to insert HTML.  Invalid object name '" +vfd085+"'."); }

 editor_focus(v43c91);

 var v2648 =v43c91.tagName.toLowerCase();
 var v5b712;

 if (v2648 =='iframe'){
 var v7a135 =v43c91.contentWindow.document;
 v5b712 =v7a135.selection.createRange();
 var v2f997 =v5b712.htmlText;

 if (v5b712.length){return alert("Unable to insert HTML.  Try highlighting content instead of selecting it."); }

 var vc156 =window.onerror;
 window.onerror =function(){alert("Unable to insert HTML for current selection."); return true; }
 if (v2f997.length){if (str2){v5b712.pasteHTML(str1 +v2f997+str2)}else {v5b712.pasteHTML(str1); }}else {if (reqSel){return alert("Unable to insert HTML.  You must select something first."); }
 v5b712.pasteHTML(str1 +str2); }
 window.onerror =vc156;
 }

 else if (v2648 =='textarea'){
 v43c91.focus();
 v5b712 =document.selection.createRange();
 var v12f99 =v5b712.text;

 if (v12f99.length){if (str2){v5b712.text =str1 +v12f99+str2; }else {v5b712.text =str1; }}else {if (reqSel){return alert("Unable to insert HTML.  You must select something first."); }
 v5b712.text =str1 +str2; }
 }
 else {alert("Unable to insert HTML.  Unknown object tag type '" +v2648+"'."); }

 v5b712.collapse(false); v5b712.select(); 
}



function editor_getHTML(vfd085){
 var v43c91 =document.all["_" +vfd085 +"_editor"];
 var v47673 =(v43c91.tagName.toLowerCase()=='textarea');

 if (v47673){return v43c91.value; }
 else {return v43c91.contentWindow.document.body.innerHTML; }
}



function editor_setHTML(vfd085,vf1617){
 var v43c91 =document.all["_" +vfd085 +"_editor"];
 var v47673 =(v43c91.tagName.toLowerCase()=='textarea');

 if (v47673){v43c91.value =vf1617; }
 else {v43c91.contentWindow.document.body.innerHTML =vf1617; }
}



function editor_appendHTML(vfd085,vf1617){
 var v43c91 =document.all["_" +vfd085 +"_editor"];
 var v47673 =(v43c91.tagName.toLowerCase()=='textarea');

 if (v47673){v43c91.value +=vf1617; }
 else {v43c91.contentWindow.document.body.innerHTML +=vf1617; }
}



function _isMouseOver(obj,v90b8){var v38e82 =v90b8.clientX;
 var vb1683 =v90b8.clientY;

 var v12650 =obj.offsetTop;
 var v46312 =obj.offsetTop +obj.offsetHeight;
 var vfe586 =obj.offsetLeft;
 var v74872 =obj.offsetLeft +obj.offsetWidth;

 if (v38e82 >=vfe586 &&v38e82 <=v74872 &&
 vb1683 >=v12650 &&vb1683 <=v46312){return true; }

 return false;
}



function editor_cMenu_generate(editorWin,vfd085){
 var v77788 =window;
 editorWin.event.returnValue =false; 
 var v99927 =[ ['Cut','Ctrl-X',function(){}],
 ['Copy','Ctrl-C',function(){}],
 ['Paste','Ctrl-C',function(){}],
 ['Delete','DEL',function(){}],
 ['---',null,null],
 ['Select All','Ctrl-A',function(){}],
 ['Clear All','',function(){}],
 ['---',null,null],
 ['About this editor...','',function(){
 alert("about this editor");
 }]];
 editor_cMenu.options =v99927; 
 var v4f782 =''
 +'<div id="_'+vfd085+'_cMenu" onblur="editor_cMenu(this);" oncontextmenu="return false;" onselectstart="return false"'
 +'  style="position: absolute; visibility: hidden; cursor: default; width: 167px; background-color: threedface;'
 +'         border: solid 1px; border-color: threedlightshadow threeddarkshadow threeddarkshadow threedlightshadow;">'
 +'<table border=0 cellspacing=0 cellpadding=0 width="100%" style="width: 167px; background-color: threedface; border: solid 1px; border-color: threedhighlight threedshadow threedshadow threedhighlight;">'
 +' <tr><td colspan=2 height=1></td></tr>';

 var v33722 ='';

 var vd6867 =''
 +' <tr><td colspan=2 height=1></td></tr>'
 +'</table></div>';

 for (var menuIdx in editor_cMenu.options){
 var vcb340 =editor_cMenu.options[menuIdx][0];
 var v92069 =editor_cMenu.options[menuIdx][1];
 var v2fa79 =editor_cMenu.options[menuIdx][2];

 if (vcb340 =="---" ||vcb340 =="separator"){
 v33722 +=' <tr><td colspan=2 class="cMenuDivOuter"><div class="cMenuDivInner"></div></td></tr>';
 }

 else {
 v33722 +='<tr class="cMenu" onMouseOver="editor_cMenu(this)" onMouseOut="editor_cMenu(this)" onClick="editor_cMenu(this, \'' +menuIdx+'\',\'' +vfd085+'\')">';
 if (v92069){v33722 +=' <td align=left class="cMenu">' +vcb340+'</td><td align=right class="cMenu">' +v92069+'</td>'; }
 else {v33722 +=' <td colspan=2 class="cMenu">' +vcb340+'</td>'; }
 v33722 +='</tr>';
 }
 }

 var v7e192 =v4f782 +v33722 +vd6867;


 document.all['_'+vfd085+'_cMenu'].outerHTML =v7e192;

 editor_cMenu_setPosition(v77788,editorWin,vfd085);

 v77788['_'+vfd085+'_cMenu'].style.visibility ='visible';
 v77788['_'+vfd085+'_cMenu'].focus();

}



function editor_cMenu_setPosition(v77788,editorWin,vfd085){var v90b8 =editorWin.event;
 var v23c63 =v77788['_'+vfd085+'_cMenu'];
 var v38e82 =v90b8.clientX +v77788.document.all['_'+vfd085+'_editor'].offsetLeft;
 var vb1683 =v90b8.clientY +v77788.document.all['_'+vfd085+'_editor'].offsetTop;
 var v52574 =v23c63.offsetHeight;
 var v38630 =v23c63.offsetWidth;
 var v4537 =document.body.clientHeight +document.body.scrollTop;
 var v6ff78 =document.body.clientWidth +document.body.scrollLeft;

 if (v38e82 +5 +v38630 >v6ff78){var vd2810 =v38e82 -v38630 -5; }else {var vd2810 =v38e82 +5; }

 if (vb1683 +5 +v52574 >v4537){var v65333 =vb1683 -v52574 +5; }else {var v65333 =vb1683 +5; }

 v23c63.style.top =v65333;
 v23c63.style.left =vd2810;

}



function editor_cMenu(obj,menuIdx,vfd085){
 var v26018 =v90b8.type;
 if (v26018 =="mouseover" &&!obj.disabled &&obj.tagName.toLowerCase()=='tr'){
 obj.className ='cMenuOver';
 for (var v1c495=0; v1c495 <obj.cells.length; v1c495++){obj.cells[v1c495].className ='cMenuOver'; }
 }
 else if (v26018 =="mouseout" &&!obj.disabled &&obj.tagName.toLowerCase()=='tr'){
 obj.className ='cMenu';
 for (var v1c495=0; v1c495 <obj.cells.length; v1c495++){obj.cells[v1c495].className ='cMenu'; }
 }
 else if (v26018 =="click" &&!obj.disabled){
 document.all['_'+vfd085+'_cMenu'].style.visibility ="hidden";
 var v42584 =editor_cMenu.options[menuIdx][2];
 v42584();
 }
 else if (v26018 =="blur"){
 if (!_isMouseOver(obj,v90b8)){obj.style.visibility ='hidden'; }
 else {
 if (obj.style.visibility !="hidden"){obj.focus(); }
 }
 }
 else {alert("editor_cMenu, unknown action: " +v26018); }
}


