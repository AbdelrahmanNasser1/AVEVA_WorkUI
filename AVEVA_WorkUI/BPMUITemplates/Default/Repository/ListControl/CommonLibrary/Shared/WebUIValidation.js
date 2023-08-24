﻿var Page_ValidationVer="125";var Page_IsValid=true;var Page_BlockSubmit=false;function ValidatorUpdateDisplay(b){if(typeof(b.display)=="string"&&b.display!="Static"){if(b.display=="Dynamic"){b.style.display=b.isvalid?"none":"inline"}}else{if((navigator.userAgent.indexOf("Mac")>-1)&&(navigator.userAgent.indexOf("MSIE")>-1)){b.style.display="inline"}b.style.visibility=b.isvalid?"hidden":"visible"}var a=ISGetObject(b.controltovalidate);if(a&&typeof(a.OnValidate)=="function"){a.OnValidate(b,b.isvalid)}}function ValidatorUpdateIsValid(){var a;for(a=0;a<Page_Validators.length;a++){if(!Page_Validators[a].isvalid){Page_IsValid=false;return}}Page_IsValid=true}function ValidatorHookupControlID(a,c){if(typeof(a)!="string"){return}var b=document.all[a];if(typeof(b)!="undefined"){ValidatorHookupControl(b,c)}else{c.isvalid=true;c.enabled=false}}function ValidatorHookupControl(a,f){if(typeof(a.tagName)=="undefined"&&typeof(a.length)=="number"){var d;for(d=0;d<a.length;d++){var e=a[d];if(typeof(e.value)=="string"){ValidatorHookupControl(e,f)}}return}else{if(a.tagName!="INPUT"&&a.tagName!="TEXTAREA"&&a.tagName!="SELECT"){var d;for(d=0;d<a.children.length;d++){ValidatorHookupControl(a.children[d],f)}return}else{if(typeof(a.Validators)=="undefined"){a.Validators=new Array;var b;if(a.type=="radio"){b=a.onclick}else{b=a.onchange}if(typeof(b)=="function"){b=b.toString();b=b.substring(b.indexOf("{")+1,b.lastIndexOf("}"))}else{b=""}var c=new Function("ValidatorOnChange(); "+b);if(a.type=="radio"){a.onclick=c}else{a.onchange=c}}a.Validators[a.Validators.length]=f}}}function ValidatorGetValue(b){var a;a=document.all[b];if(typeof(a.value)=="string"){return a.value}if(typeof(a.tagName)=="undefined"&&typeof(a.length)=="number"){var d;for(d=0;d<a.length;d++){var c=a[d];if(typeof(c.value)=="string"&&(c.type!="radio"||c.status==true)){return c.value}}}else{return ValidatorGetValueRecursive(a)}return""}function ValidatorGetValueRecursive(a){if(typeof(a.value)=="string"&&(a.type!="radio"||a.status==true)){return a.value}var b,c;for(b=0;b<a.children.length;b++){c=ValidatorGetValueRecursive(a.children[b]);if(c!=""){return c}}return""}function Page_ClientValidate(){var a;for(a=0;a<Page_Validators.length;a++){ValidatorValidate(Page_Validators[a])}ValidatorUpdateIsValid();ValidationSummaryOnSubmit();Page_BlockSubmit=!Page_IsValid;return Page_IsValid}function ValidatorCommonOnSubmit(){event.returnValue=!Page_BlockSubmit;Page_BlockSubmit=false}function ValidatorEnable(b,a){b.enabled=(a!=false);ValidatorValidate(b);ValidatorUpdateIsValid()}function ValidatorOnChange(){var b=event.srcElement.Validators;var a;for(a=0;a<b.length;a++){ValidatorValidate(b[a])}ValidatorUpdateIsValid()}function ValidatorValidate(a){ValidatorUpdateDisplay(a)}function ValidatorOnLoad(){if(typeof(Page_Validators)=="undefined"){return}var a,b;for(a=0;a<Page_Validators.length;a++){b=Page_Validators[a];if(typeof(b.isvalid)=="string"){if(b.isvalid=="False"){b.isvalid=false;Page_IsValid=false}else{b.isvalid=true}}else{if(typeof(b.isvalid)!="boolean"){b.isvalid=true}}if(typeof(b.enabled)=="string"){b.enabled=(b.enabled!="False")}ValidatorHookupControlID(b.controltovalidate,b);ValidatorHookupControlID(b.controlhookup,b);if(!b.isvalid){ValidatorUpdateDisplay(b)}}Page_ValidationActive=true}function ValidatorConvert(l,b,n){function f(m){return(m+parseInt(n.century))-((m<n.cutoffyear)?0:100)}var k,a,h,e;if(b=="Integer"){e=/^\s*[-\+]?\d+\s*$/;if(l.match(e)==null){return null}k=parseInt(l,10);return(isNaN(k)?null:k)}else{if(b=="Double"){e=new RegExp("^\\s*([-\\+])?(\\d+)?(\\"+n.decimalchar+"(\\d+))?\\s*$");h=l.match(e);if(h==null){return null}a=h[1]+(h[2].length>0?h[2]:"0")+"."+h[4];k=parseFloat(a);return(isNaN(k)?null:k)}else{if(b=="Currency"){e=new RegExp("^\\s*([-\\+])?(((\\d+)\\"+n.groupchar+")*)(\\d+)"+((n.digits>0)?"(\\"+n.decimalchar+"(\\d{1,"+n.digits+"}))?":"")+"\\s*$");h=l.match(e);if(h==null){return null}var g=h[2]+h[5];a=h[1]+g.replace(new RegExp("(\\"+n.groupchar+")","g"),"")+((n.digits>0)?"."+h[7]:0);k=parseFloat(a);return(isNaN(k)?null:k)}else{if(b=="Date"){var p=new RegExp("^\\s*((\\d{4})|(\\d{2}))([-./])(\\d{1,2})\\4(\\d{1,2})\\s*$");h=l.match(p);var d,j,o;if(h!=null&&(h[2].length==4||n.dateorder=="ymd")){d=h[6];j=h[5];o=(h[2].length==4)?h[2]:f(parseInt(h[3],10))}else{if(n.dateorder=="ymd"){return null}var q=new RegExp("^\\s*(\\d{1,2})([-./])(\\d{1,2})\\2((\\d{4})|(\\d{2}))\\s*$");h=l.match(q);if(h==null){return null}if(n.dateorder=="mdy"){d=h[3];j=h[1]}else{d=h[1];j=h[3]}o=(h[5].length==4)?h[5]:f(parseInt(h[6],10))}j-=1;var c=new Date(o,j,d);return(typeof(c)=="object"&&o==c.getFullYear()&&j==c.getMonth()&&d==c.getDate())?c.valueOf():null}else{return l.toString()}}}}}function ValidatorCompare(d,e,f,g){var a=g.type;var b,c;if((b=ValidatorConvert(d,a,g))==null){return false}if(f=="DataTypeCheck"){return true}if((c=ValidatorConvert(e,a,g))==null){return true}switch(f){case"NotEqual":return(b!=c);case"GreaterThan":return(b>c);case"GreaterThanEqual":return(b>=c);case"LessThan":return(b<c);case"LessThanEqual":return(b<=c);default:return(b==c)}}function CompareValidatorEvaluateIsValid(b){var c=ValidatorGetValue(b.controltovalidate);if(ValidatorTrim(c).length==0){return true}var a="";if(null==document.all[b.controltocompare]){if(typeof(b.valuetocompare)=="string"){a=b.valuetocompare}}else{a=ValidatorGetValue(b.controltocompare)}return ValidatorCompare(c,a,b.operator,b)}function CustomValidatorEvaluateIsValid(val){var value="";if(typeof(val.controltovalidate)=="string"){value=ValidatorGetValue(val.controltovalidate);if(ValidatorTrim(value).length==0){return true}}var args={Value:value,IsValid:true};if(typeof(val.clientvalidationfunction)=="string"){eval(val.clientvalidationfunction+"(val, args) ;")}return args.IsValid}function RegularExpressionValidatorEvaluateIsValid(c){var d=ValidatorGetValue(c.controltovalidate);if(ValidatorTrim(d).length==0){return true}var b=new RegExp(c.validationexpression);var a=b.exec(d);return(a!=null&&d==a[0])}function ValidatorTrim(b){var a=b.match(/^\s*(\S+(\s+\S+)*)\s*$/);return(a==null)?"":a[1]}function RequiredFieldValidatorEvaluateIsValid(a){return(ValidatorTrim(ValidatorGetValue(a.controltovalidate))!=ValidatorTrim(a.initialvalue))}function RangeValidatorEvaluateIsValid(a){var b=ValidatorGetValue(a.controltovalidate);if(ValidatorTrim(b).length==0){return true}return(ValidatorCompare(b,a.minimumvalue,"GreaterThanEqual",a)&&ValidatorCompare(b,a.maximumvalue,"LessThanEqual",a))}function ValidationSummaryOnSubmit(){if(typeof(Page_ValidationSummaries)=="undefined"){return}var b,c,a;for(c=0;c<Page_ValidationSummaries.length;c++){b=Page_ValidationSummaries[c];b.style.display="none";if(!Page_IsValid){if(b.showsummary!="False"){b.style.display="";if(typeof(b.displaymode)!="string"){b.displaymode="BulletList"}switch(b.displaymode){case"List":headerSep="<br>";first="";pre="";post="<br>";final1="";break;case"BulletList":default:headerSep="";first="<ul>";pre="<li>";post="</li>";final1="</ul>";break;case"SingleParagraph":headerSep=" ";first="";pre="";post=" ";final1="<br>";break}a="";if(typeof(b.headertext)=="string"){a+=b.headertext+headerSep}a+=first;for(i=0;i<Page_Validators.length;i++){if(!Page_Validators[i].isvalid&&typeof(Page_Validators[i].errormessage)=="string"){a+=pre+Page_Validators[i].errormessage+post}}a+=final1;b.innerHTML=a;window.scrollTo(0,0)}if(b.showmessagebox=="True"){a="";if(typeof(b.headertext)=="string"){a+=b.headertext+"<BR>"}for(i=0;i<Page_Validators.length;i++){if(!Page_Validators[i].isvalid&&typeof(Page_Validators[i].errormessage)=="string"){switch(b.displaymode){case"List":a+=Page_Validators[i].errormessage+"<BR>";break;case"BulletList":default:a+="  - "+Page_Validators[i].errormessage+"<BR>";break;case"SingleParagraph":a+=Page_Validators[i].errormessage+" ";break}}}span=document.createElement("SPAN");span.innerHTML=a;a=span.innerText;alert(a)}}}}if(typeof(Sys)!="undefined"){Sys.Application.notifyScriptLoaded()};