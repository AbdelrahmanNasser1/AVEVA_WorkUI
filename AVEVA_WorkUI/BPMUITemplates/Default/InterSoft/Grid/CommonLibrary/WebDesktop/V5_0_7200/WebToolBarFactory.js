var WebToolBarFactoryEngine={_RuntimePrefixId:"NewWebToolBar",_LeftPosition:"200px",_TopPosition:"150px",_IdIndex:0,_DefaultBarWidth:"222px",_DefaultInnerContentWidth:"100px",_GetNewId:function(){var a=false;var b="";do{WebToolBarFactoryEngine._IdIndex=WebToolBarFactoryEngine._IdIndex+1;b=WebToolBarFactoryEngine._RuntimePrefixId+WebToolBarFactoryEngine._IdIndex.toString();if(ISGetObject(b)==null){a=true}}while(a==false);return b},_GetNewTopPosition:function(){var a=parseFloat(WebToolBarFactoryEngine._TopPosition);a+=15;a+="px";WebToolBarFactoryEngine._TopPosition=a;return a},CreateNewToolBar:function(c,b){if(b==null){b=WebToolBarFactoryEngine._GetNewId()}var d=ISGetObject(b);if(d!=null){return d}var a=false;if(c==null){c=WebToolBarFactoryEngine._CreateToolBarForPlaceHolder(b);a=true}var e=WebToolBarFactoryEngine._RenderNewToolBar(c,b);if(a){ISControl_Dispose(b+"Temp")}return e},_CreateToolBarForPlaceHolder:function(a){var b=new WebToolBar(a+"Temp");b.AddRemoveOptionMenuViewMode="IconView";b.SizeMode="Automatic";b.AllowMove="Yes";b.HandleVisible="Yes";b.AllowCustomize="Yes";b.AllowDockBottom="Yes";b.AllowDockLeft="Yes";b.AllowDockRight="Yes";b.AllowDockTop="Yes";b.AllowExpandCollapse="Yes";b.AllowFloat="Yes";b.BackColor="Gainsboro";b.BarStyle="Office2003";b.DockingArea="Top";b.DockingOffset=0;b.FillDockingRow="Yes";b.PlaceHolder="";b.Caption="";b.HandleAndCustomizeBackColor="DarkGray";b.MaxDockingRows=2;b.IsFloat="No";b.IsFloat1="No";b.HeaderHeight="25px";b.GreyImageWhenDisabled="Yes";b.DisplayToolTip="Yes";b.DisplayAccessKeyOnToolTip="No";b.ToolTip="";b.TextAlign="Right";b.DisplayMode="Text";b.CommandSize="50px";b.ImageSize=new UnitSize();b.ImageSize.Width=b.ImageSize.Height="16px";b.IntegratedTo="None";WebToolBarFactoryEngine._CreateToolBarStyle(b);b.IsOnPostInitialized=true;return b},_CreateToolBarStyle:function(f){if(f.UseCssFramework){var a=new BarSectionStyle();a.CssClass="toolbar-body";var c=new BarSectionStyle();a.CssClass="toolbar-handle";var d=new BarSectionStyle();a.CssClass="toolbar-option";f.BodyStyle=a;f.HandleStyle=c;f.OptionStyle=d;f.CommandStyle=new DynamicStyle("toolbar-command","toolbar-command hover","toolbar-command active");f.HeaderButtonStyle=new DynamicStyle("toolbar-header-button","toolbar-header-button hover","toolbar-header-button active");f.CommandFontStyle=new DynamicStyle("toolbar-command-font","toolbar-command-font hover","toolbar-command-font active");f.CommandDisabledStyle="toolbar-command disabled";f.HeaderCaptionStyle="toolbar-header-caption";f.SeparatorStyle="toolbar-separator"}else{var a=new BarSectionStyle();a.BackColor="#ECE7E0";a.BackColor2="";var c=new BarSectionStyle();c.BackColor="#C4C4AD";c.BackColor2="";var d=new BarSectionStyle();d.BackColor="#C4C4AD";d.BackColor2="";f.BodyStyle=a;f.HandleStyle=c;f.OptionStyle=d;var e=IS.GetRuntimeStyleSheetExact();var b=IS.GetCssText(e.name,"DefaultCommandDisabledStyle");if(b==null){b=IS.AddRuntimeCssStyle("DefaultCommandDisabledStyle","font-family:Tahoma;  font-size:8pt;  font-weight:normal;color:DimGray; padding-top:1px; padding-right:3px; padding-left:3px; padding-bottom:1px;")}f.CommandDisabledStyle="DefaultCommandDisabledStyle";b=IS.GetCssText(e.name,"DefaultHeaderCaptionStyle");if(b==null){b=IS.AddRuntimeCssStyle("HeaderCaptionStyle","background-color:#ACA899; font-family:Tahoma;  font-size:8pt;  font-weight:bold; color:White;cursor:Move;")}f.HeaderCaptionStyle="HeaderCaptionStyle";b=IS.GetCssText(e.name,"DefaultSeparatorStyle");if(b==null){b=IS.AddRuntimeCssStyle("SeparatorStyle","background-color:#C4C4AD;font-size:1px;")}f.SeparatorStyle="SeparatorStyle";b=IS.GetCssText(e.name,"DefaultCommandStyle-Normal");if(b==null){b=IS.AddRuntimeCssStyle("DefaultCommandStyle-Normal","font-family:Tahoma;  font-size:8pt;  font-weight:normal; padding-top:1px; padding-right:3px; padding-left:3px; padding-bottom:1px;overflow:Hidden;overflow-x:Hidden;overflow-y:Hidden;")}b=IS.GetCssText(e.name,"DefaultCommandStyle-Active");if(b==null){b=IS.AddRuntimeCssStyle("DefaultCommandStyle-Active","background-color:#98B5E2; font-family:Tahoma;  font-size:8pt;  font-weight:normal;border:1px #4B4B6F solid;cursor:Default; padding-top:0px; padding-right:2px; padding-left:2px; padding-bottom:0px;overflow:Hidden;overflow-x:Hidden;overflow-y:Hidden;basestyle:Over;")}b=IS.GetCssText(e.name,"DefaultCommandStyle-Over");if(b==null){b=IS.AddRuntimeCssStyle("DefaultCommandStyle-Over","background-color:#C1D2EE; font-family:Tahoma;  font-size:8pt;  font-weight:normal;border:1px #316AC5 solid;cursor:Default; padding-top:0px; padding-right:2px; padding-left:2px; padding-bottom:0px;overflow:Hidden;overflow-x:Hidden;overflow-y:Hidden;")}f.CommandStyle=new DynamicStyle("DefaultCommandStyle-Normal","DefaultCommandStyle-Over","DefaultCommandStyle-Active");b=IS.GetCssText(e.name,"DefaultHeaderButtonStyle-Normal");if(b==null){b=IS.AddRuntimeCssStyle("DefaultHeaderButtonStyle-Normal","background-color:#ACA899; font-size:8pt;  font-weight:normal;color:White;cursor:pointer; padding-top:1px; padding-right:1px; padding-left:1px; padding-bottom:1px;width:27px;")}b=IS.GetCssText(e.name,"DefaultHeaderButtonStyle-Active");if(b==null){b=IS.AddRuntimeCssStyle("DefaultHeaderButtonStyle-Active","background-color:#98B5E2; font-size:8pt;  font-weight:normal;border:1px #4B4B6F solid;color:White;cursor:pointer; padding-top:0px; padding-right:0px; padding-left:0px; padding-bottom:0px;width:27px;basestyle:Over;")}b=IS.GetCssText(e.name,"DefaultHeaderButtonStyle-Over");if(b==null){b=IS.AddRuntimeCssStyle("DefaultHeaderButtonStyle-Over","background-color:#C1D2EE; font-size:8pt;  font-weight:normal;border:1px #316AC5 solid;color:White;cursor:pointer; padding-top:0px; padding-right:0px; padding-left:0px; padding-bottom:0px;width:27px;basestyle:Normal;")}f.HeaderButtonStyle=new DynamicStyle("DefaultHeaderButtonStyle-Normal","DefaultHeaderButtonStyle-Over","DefaultHeaderButtonStyle-Active");b=IS.GetCssText(e.name,"DefaultCommandFontStyle-Normal");if(b==null){b=IS.AddRuntimeCssStyle("DefaultCommandFontStyle-Normal","font-family:Tahoma;  font-size:8pt;  font-weight:normal;")}b=IS.GetCssText(e.name,"DefaultCommandFontStyle-Active");if(b==null){b=IS.AddRuntimeCssStyle("DefaultCommandFontStyle-Active","font-family:Tahoma;  font-size:8pt;  font-weight:normal;")}b=IS.GetCssText(e.name,"DefaultCommandFontStyle-Over");if(b==null){b=IS.AddRuntimeCssStyle("DefaultCommandFontStyle-Over","font-family:Tahoma;  font-size:8pt;  font-weight:normal;")}f.CommandFontStyle=new DynamicStyle("DefaultCommandFontStyle-Normal","DefaultCommandFontStyle-Over","DefaultCommandFontStyle-Active")}},_RenderNewToolBar:function(g,e){var b=25;var h=WebToolBarFactoryEngine.RenderBegin(g,e,b);h+=WebToolBarFactoryEngine.RenderContents(g,e,b);h+=WebToolBarFactoryEngine.RenderEnd(e);var f;var c=true;if(g.XmlDt!=null){f=g.XmlDt.selectSingleNode("//WebToolBarStyleSettings")}if(f==null){if(g.XmlDt!=null){f=g.XmlDt.selectSingleNode("//WebToolBar")}c=false}if(!g||!g.UseCssFramework){var i=" HeaderCaptionStyle='"+(f!=null?f.getAttribute("HeaderCaptionStyle"):g.HeaderCaptionStyle)+"' ";i+="HandleStyle='"+(f!=null?f.getAttribute("HandleStyle"):g.HandleStyle)+"' ";i+="OptionStyle='"+(f!=null?f.getAttribute("OptionStyle"):g.OptionStyle)+"' ";i+="CommandDisabledStyle='"+(f!=null?f.getAttribute("CommandDisabledStyle"):g.CommandDisabledStyle)+"' ";i+="CommandDisableFontStyle='"+(f!=null?f.getAttribute("CommandDisableFontStyle"):g.CommandDisableFontStyle)+"' ";i+="SeparatorStyle='"+(f!=null?f.getAttribute("SeparatorStyle"):g.SeparatorStyle)+"' "}h+="<input type='hidden' name='"+e+"' id='"+e+"' value=''><xml id='"+e+"_x'><!--[CDATA[<WebToolBar IntegratedTo='"+(c?"PlaceHolderManager":"None")+"' IsFloat='Yes' Height='"+b+"px'  IsRuntimeBar='True' DockingRow='0' NewDockingArea='Top' NewDockingRow='0' Style1='' Id='"+e+"' xmlInputHiddenUniqueID='"+e+"_h' Width='222px' Caption='"+e+"' PlaceHolder='"+(c?g.Id:"")+"' ServerUniqueID='"+e+"' ";h+=" ImageSize='"+g.Get("ImageSize")+"'";h+=" TextAlign='"+g.Get("TextAlign")+"'";h+=" AllowCustomize='"+g.Get("AllowCustomize")+"'";h+=" AllowExpandCollapse='"+g.Get("AllowExpandCollapse")+"'";h+=" AutoPostBack='"+g.Get("AutoPostBack")+"'";h+=" BarStyle='"+g.Get("BarStyle")+"'";h+=" DisplayAccessKeyOnToolTip='"+g.Get("DisplayAccessKeyOnToolTip")+"'";h+=" DisplayMode='"+g.Get("DisplayMode")+"'";h+=" DisplayToolTip='"+g.Get("DisplayToolTip")+"'";h+=" FillDockingRow='"+g.Get("FillDockingRow")+"'";h+=" HandleVisible='"+g.Get("HandleVisible")+"'";h+=" SizeMode='"+g.Get("SizeMode")+"'";h+=" XmlCompressionEnabled='"+g.Get("XmlCompressionEnabled")+"'";h+=" AllowDockBottom='"+g.Get("AllowDockBottom")+"'";h+=" AllowDockLeft='"+g.Get("AllowDockLeft")+"'";h+=" AllowDockTop='"+g.Get("AllowDockTop")+"'";h+=" AllowDockRight='"+g.Get("AllowDockRight")+"'";h+=" DockingArea='"+g.Get("DockingArea")+"'";h+=" DockingOffset='"+g.Get("DockingOffset")+"'";h+=" CommandSize='"+g.Get("CommandSize")+"'";h+=" HeaderHeight='"+g.Get("HeaderHeight")+"'";h+="><Commands /><CommandSize />";var d;if(f!=null){d=f.selectSingleNode("CommandStyle");if(d!=null){h+=d.xml}d=f.selectSingleNode("CommandFontStyle");if(d!=null){h+=d.xml}d=f.selectSingleNode("HeaderButtonStyle");if(d!=null){h+=d.xml}d=f.selectSingleNode("HeaderCaptionStyle");if(d!=null){h+=d.xml}d=f.selectSingleNode("HandleStyle");if(d!=null){h+=d.xml}d=f.selectSingleNode("BodyStyle");if(d!=null){h+=d.xml}d=f.selectSingleNode("OptionStyle");if(d!=null){h+=d.xml}d=f.selectSingleNode("MenuStyleSettings");if(d!=null){h+=d.xml}}else{h+=WebToolBarFactoryEngine._CreateXmlBarSectionStyle(g.HandleStyle,"HandleStyle");h+=WebToolBarFactoryEngine._CreateXmlBarSectionStyle(g.BodyStyle,"BodyStyle");h+=WebToolBarFactoryEngine._CreateXmlBarSectionStyle(g.OptionStyle,"OptionStyle");h+=WebToolBarFactoryEngine._CreateXmlDynamicStyle(g.CommandStyle,"CommandStyle");h+=WebToolBarFactoryEngine._CreateXmlDynamicStyle(g.HeaderButtonStyle,"HeaderButtonStyle");h+=WebToolBarFactoryEngine._CreateXmlDynamicStyle(g.CommandFontStyle,"CommandFontStyle")}h+="</WebToolBar>]]--></xml>";var a;if(g.HtmlObj!=null){a=g.HtmlObj.form}else{a=document.forms[0]}a.insertAdjacentHTML("beforeEnd",h);InitWebToolBar(e);var j=ISGetObject(e);j.IsRuntimeBar=true;j.UseCssFramework=g.UseCssFramework;if(typeof(g.SynchronizeBarProperties)=="function"){g.SynchronizeBarProperties(j)}j.IsFloat=false;j.IsDynamicCreated=true;j._SetToFloatDisplay();j.UseCssFramework=g.UseCssFramework;if(typeof(g.GetCustomizeWindow)=="function"){g.GetCustomizeWindow().RegisterBar(j)}return j},_CreateXmlBarSectionStyle:function(b,a){if(b==null){return""}var c="<"+a+" ";if(b){c+=' BackColor="'+b.BackColor+'" ';c+=' BackColor2="'+b.BackColor2+'" ';c+=' GradientType="'+b.GradientType+'" ';c+=' BackgroundImageHorizontal="'+b.BackgroundImageHorizontal+'" ';c+=' BackgroundImageVertical="'+b.BackgroundImageVertical+'" />'}return c},_CreateXmlDynamicStyle:function(b,a){if(b==null){return""}var c="<"+a+" ";if(b){c+=' Normal="'+b.Normal+'" ';c+=' Over="'+b.Over+'" ';c+=' Active="'+b.Active+'" />'}return c},_GetGradientBackColorStyle:function(c){var b="";if(c.BackColor==null||c.BackColor2==""){c.BackColor2="white"}if(IS.IE){if(c.BackColor2!=null&&c.BackColor2!=""){var a="";if(orientation=="h"){a=c.GradientType=="Horizontal"?"1":"0"}else{a=c.GradientType=="Horizontal"?"0":"1"}b="filter: progid:DXImageTransform.Microsoft.gradient(startColorstr="+c.BackColor+" , endColorstr="+c.BackColor2+", GradientType="+a+")"}else{b="background-color:"+c.BackColor}}else{b="background-color:"+c.BackColor}return b},RenderBegin:function(f,e,d){if(!(f&&f.UseCssFramework)){var g=document.createStyleSheet();g.name="ISRuntimeStyle"+e;if(IS.moz||IS.safari){var c=document.getElementsByTagName("HEAD")[0];c.appendChild(g)}if(IS.ie){g.addRule("#"+e+IS.FrameSuffix,"-moz-box-sizing:border-box")}else{if(IS.moz){g.innerHTML+="#"+e+IS.FrameSuffix+" { -moz-box-sizing:border-box }"}}}var b=f.WebToolBarStyleSettings;b=b?b.FrameStyle:"";var a=f&&f.UseCssFramework?" orientation='horizontal' docking-area='"+f.Get("DockingArea").toLowerCase()+"' integration='placeholdermanager'":"";var h=";position:absolute;left:"+WebToolBarFactoryEngine._LeftPosition+";top:"+WebToolBarFactoryEngine._GetNewTopPosition();var g="<table class='"+b+"' "+a+' cellspacing="0" cellpadding="0" border="0" id="'+e+IS.FrameSuffix+'" style="overflow:hidden;float:left;width:'+WebToolBarFactoryEngine._DefaultBarWidth+";height:"+d+h+'">';a=f&&f.UseCssFramework?"":"table-layout:fixed;";g+='<tr><td><table cellspacing="0" cellpadding="0" border="0" id="'+e+IS.InnerFrameSuffix+'" style="'+a+"width:100%;height:100%;z-index:9997;float:left;"+(f.BarStyle=="OfficeXP"||f.BarStyle=="IE"?"border:white 1px outset":"");switch(f.Get("BarStyle")){case"Office2003":g+=";background-color:transparent";break;case"OfficeXP":g+=";background-color:#dcdcdc";break;case"Office2000":break;case"Office2003":g+=";background-color:#dcdcdc";break}g+='">';g+="<tbody style='display:none'><tr><td><div id='WebToolBar1'></div></td></tr></tbody>";return g},GetSymbol:function(a,f,e){if((!a||!a.UseCssFramework)&&(IS.ie||IS.moz)){if(e==null||e==""){return"<font optionForeColor='true' face='webdings' size='1'>"+f+"</font>"}else{return"<font optionForeColor='true' color='"+e+"' face='webdings' size='1'>"+f+"</font>"}}else{var g=a.WebResourceIdentifier;var d="";a.WebResourceIdentifier="F";d=a.ResolveImagePath(a.ImagesDirectory,"webdings_"+f+".gif");if(d.indexOf(".")==-1){d=a.ResolveImagePath("webdings_"+f+".gif")}a.WebResourceIdentifier=g;var b=a&&a.UseCssFramework?"":" style='width:10px;height:16px'";return"<img optionForeColor='true' "+b+" src='"+d+"' />"}return""},RenderContents:function(c,b,a){var d="";d+=WebToolBarFactoryEngine.RenderContentsHorizontal(c,b,a);d+=WebToolBarFactoryEngine.RenderContentsVertical(c,b,a);return d},RenderEnd:function(a){return'</table></td></tr></table><input name="'+a+'_h" type="hidden" id="'+a+'_h" />'},RenderContentsHorizontal:function(d,c,b){var f=d.WebToolBarStyleSettings;if(f==null){f=d}var a=d&&d.UseCssFramework?" ui-part='toolbar-horizontal-frame'":"";var e="<tbody  id='"+c+IS.FrameSuffix+"_Horizontal'"+a+">";a=d&&d.UseCssFramework?" ui-part='toolbar-header'":"";e+="<tr><td"+a+"><table cellpadding='0' cellspacing='0' border='0' style='width:100%'>";a=d&&d.UseCssFramework?"":"background-color:white";e+="<tr  style='display:none;"+a+"' id='"+c+"_fh'>";e+="<td  class='"+f.HeaderCaptionStyle+"'>"+c+"</td>";a=d&&d.UseCssFramework?"button-type='options'":"";e+="<td  class='"+f.HeaderButtonStyle.Normal+"' "+a+" onclick='ShowOptionWindow(\""+c+"\")'>";a=d&&d.UseCssFramework?"button-type='close'":"";e+=WebToolBarFactoryEngine.GetSymbol(d,6)+"</td><td  class='"+f.HeaderButtonStyle.Normal+"' "+a+" onclick='HideFloatingToolBar(\""+c+"\")'>";e+=WebToolBarFactoryEngine.GetSymbol(d,"r")+"</td></tr></table></td></tr>";a=d&&d.UseCssFramework?" ui-part='toolbar-body'":"";e+="<tr><td"+a+'><table cellspacing="0" cellpadding="0" border="0" style="height:'+(parseFloat(b)-4)+'px;width:100%"><tr>';if(d.HandleVisible){a=d&&d.UseCssFramework?"' ui-part='toolbar-handle'":"height:8px;'";e+="<td style='overflow:hidden;"+a+'  id="'+c+BarControlEngine.BarHandleSuffix+'_Horizontal">';switch(d.BarStyle){case"Office2003":e+=WebToolBarFactoryEngine.RenderHandleOffice2003Horizontal(d,c,b);break;case"Office2000":e+=WebToolBarFactoryEngine.RenderHandleOffice2000Horizontal(d,c,b);break;case"OfficeXP":e+=WebToolBarFactoryEngine.RenderHandleOfficeXPHorizontal(d,c,b);break;case"IE":e+=WebToolBarFactoryEngine.RenderHandleOffice2000Horizontal(d,c,b);break;case"ComplexImages":e+=WebToolBarFactoryEngine.RenderHandleComplexImagesHorizontal(d,c,b);break}e+="</td>"}a=d&&d.UseCssFramework?"ui-part='toolbar-inner-container'":"";e+="<td style='width:100%' "+a+"><div bodyBgColor='true' style=\"overflow:hidden;height:"+b+"px;width:100%;";if(!d||!d.UseCssFramework){if(d.BarStyle!="ComplexImages"){e+=WebToolBarFactoryEngine._GetGradientBackColorStyle(f.BodyStyle,"h")}else{e+="BACKGROUND-IMAGE: url("+f.BodyStyle.BackgroundImageHorizontal+")"}}e+='">';e+='<table cellpadding="0" cellspacing="0" border="0" style="table-layout:fixed;overflow:hidden;width:100%;height:100%">';e+="<tr><td ><div style='width:100%;overflow:hidden;height:2px'></div></td></tr>";e+='<tr><td style="width:100%;height:100%"><table cellpadding="0" cellspacing="0" border="0" style="overflow:hidden;width:100%;height:100%;'+(d.SizeMode=="Automatic"?"":"table-layout: fixed")+'" id="'+c+BarControlEngine.BarInnerContainerSuffix+'_Horizontal"><tr><td style="width:100%;height:100%"></td></tr></table></td></tr>';a=d&&d.UseCssFramework?"":"height:2px";e+="<tr><td><div style='width:100%;overflow:hidden;"+a+"'></div></td></tr></table></div></td>";if(d.AllowCustomize||d.AllowExpandCollapse){var a=d&&d.UseCssFramework?"ui-part='toolbar-options-button'":"";e+="<td "+a+' style="overflow:hidden;width:14px">';switch(d.BarStyle){case"Office2003":e+=WebToolBarFactoryEngine.RenderOptionOffice2003Horizontal(d,c,b);break;case"Office2000":case"OfficeXP":case"IE":e+=WebToolBarFactoryEngine.RenderOptionOffice2000Horizontal(d,c,b);break;case"ComplexImages":e+=WebToolBarFactoryEngine.RenderOptionComplexImagesHorizontal(d,c,b);break}e+="</td>"}e+="</tr></table></td></tr></tbody>";return e},RenderContentsVertical:function(d,c,b){var a=d&&d.UseCssFramework?"ui-part='toolbar-vertical-frame'":"";var e="<tbody  id='"+c+IS.FrameSuffix+"_Vertical' style='display:none' "+a+">";a=d&&d.UseCssFramework?" ui-part='toolbar-body'":"";e+="<tr><td"+a+'><table cellspacing="0" cellpadding="0" border="0" style="width:'+(parseFloat(b)-4)+'px;height:100%">';if(d.HandleVisible){a=d&&d.UseCssFramework?"' ui-part='toolbar-handle'":"height:8px;'";e+="<tr><td style='overflow:hidden;"+a+'  id="'+c+BarControlEngine.BarHandleSuffix+'_Vertical">';switch(d.BarStyle){case"Office2003":e+=WebToolBarFactoryEngine.RenderHandleOffice2003Vertical(d,c,b);break;case"Office2000":e+=WebToolBarFactoryEngine.RenderHandleOffice2000Vertical(d,c,b);break;case"OfficeXP":e+=WebToolBarFactoryEngine.RenderHandleOfficeXPVertical(d,c,b);break;case"IE":e+=WebToolBarFactoryEngine.RenderHandleOffice2000Vertical(d,c,b);break;case"ComplexImages":e+=WebToolBarFactoryEngine.RenderHandleComplexImagesVertical(d,c,b);break}e+="</td></tr>"}var f=d.WebToolBarStyleSettings;if(f==null){f=d}a=d&&d.UseCssFramework?"ui-part='toolbar-inner-container'":"";e+="<tr><td style='height:100%' "+a+"><div bodyBgColor='true' style=\"overflow:hidden;width:"+b+"px;height:100%;";if(d.BarStyle!="ComplexImages"){e+=WebToolBarFactoryEngine._GetGradientBackColorStyle(f.BodyStyle,"v")}else{e+="BACKGROUND-IMAGE: url("+f.BodyStyle.BackgroundImageVertical+")"}e+='">';e+='<table cellpadding="0" cellspacing="0" border="0" style="table-layout: fixed; overflow: hidden; width: 100%; height: 100%"><tr><td><div style="height: 100%; overflow: hidden; width: 2px"></div></td><td style="width: 100%; height: 100%">';e+='<table cellpadding="0" cellspacing="0" border="0" style="overflow: hidden; width: 100%; height: 100%;'+(d.SizeMode=="Automatic"?"":"table-layout: fixed")+'" id="'+c+BarControlEngine.BarInnerContainerSuffix+'_Vertical"><tr><td style="width: 100%; height: 100%"></td></tr></table>';e+='</td><td><div style="height: 100%; overflow: hidden; width: 2px"></div></td></tr></table>';e+="</div></td></tr>";if(d.AllowCustomize||d.AllowExpandCollapse){var a=d&&d.UseCssFramework?"ui-part='toolbar-options-button'":"";e+="<tr><td "+a+' style="overflow:hidden;height:14px">';switch(d.BarStyle){case"Office2003":e+=WebToolBarFactoryEngine.RenderOptionOffice2003Vertical(d,c,b);break;case"Office2000":case"OfficeXP":case"IE":e+=WebToolBarFactoryEngine.RenderOptionOffice2000Vertical(d,c,b);break;case"ComplexImages":e+=WebToolBarFactoryEngine.RenderOptionComplexImagesVertical(d,c,b);break}e+="</td></tr>"}e+="</table></td></tr></tbody>";return e},RenderHandleComplexImagesHorizontal:function(c,b,a){var e=c.WebToolBarStyleSettings;if(e==null){e=c}var d="<div style='"+(c.AllowMove?"cursor:move;":"")+"OVERFLOW: hidden;width:8px;height:"+a+"px; BACKGROUND-IMAGE: url("+c.HandleStyle.BackgroundImageHorizontal+");PADDING-RIGHT: 3px; PADDING-LEFT: 2px; PADDING-BOTTOM: 2px; PADDING-TOP: 2px;'></div>";return d},RenderOptionComplexImagesHorizontal:function(c,b,a){var e=c.WebToolBarStyleSettings;if(e==null){e=c}var d="<div id='"+b+BarControlEngine.BarOptionSuffix+"_Horizontal' onclick='ShowOptionWindow(\""+b+"\");' style='overflow:hidden;cursor:pointer;float:left;width:14px;height:"+a+"px;background-image:("+c.OptionStyle.BackgroundImageHorizontal+")'><div style='overflow:hidden;float:left;width:3px;height:"+a+"px'></div>";d+="<div style='float:left;overflow:hidden;width:8px;padding-top:8px;height:"+a+"px;'>"+WebToolBarFactoryEngine.GetSymbol(c,6,"#000000")+"</div>";d+="<div style='float:left;overflow:hidden;width:3px;position:relative;height:"+a+"px'></div></div>";return d},RenderHandleOffice2003Horizontal:function(f,e,d){var h=f.WebToolBarStyleSettings;if(h==null){h=f}var c=Math.abs((d-10)/2)-1;var a=WebToolBarFactoryEngine._GetGradientBackColorStyle(h.HandleStyle,"h");var b=f&&f.UseCssFramework?"":"width:8px;height:"+d+"px";var g="<div style='"+(f.AllowMove?"cursor:move;":"")+b+"'>";g+="<div handleBgColor='true' style='float:left;overflow:hidden;width:1px;margin-top:2px;height:"+(d-4)+"px;"+a+"'></div>";g+="<div handleBgColor='true' style='float:left;overflow:hidden;width:1px;margin-top:1px;height:"+(d-2)+"px;"+a+"'></div>";g+="<div handleBgColor='true' style='float:left;overflow:hidden;width:1px;margin-top:0px;height:"+d+"px;"+a+"'></div>";g+="<div handleBgColor='true' style='float:left;overflow:hidden;width:5px;height:"+d+"px;"+a+"'>";if(f.AllowMove){g+="<div handleForeColor='true' style='margin-top:"+c+"px;width:2px;height:2px;background-color:#000000;overflow:hidden'></div>";c+=3;g+="<div handleForeColor='true' style='margin-top:2px;width:2px;height:2px;background-color:#000000;overflow:hidden'></div>";c+=3;g+="<div handleForeColor='true' style='margin-top:2px;width:2px;height:2px;background-color:#000000;overflow:hidden'></div>";c+=3;g+="<div handleForeColor='true' style='margin-top:2px;width:2px;height:2px;background-color:#000000;overflow:hidden'></div>"}g+="</div></div>";return g},RenderOptionOffice2003Horizontal:function(g,e,c){var i=g.WebToolBarStyleSettings;if(i==null){i=g}var f=c-16;var d=WebToolBarFactoryEngine._GetGradientBackColorStyle(i.BodyStyle,"h");var a=WebToolBarFactoryEngine._GetGradientBackColorStyle(i.OptionStyle,"h");var b=g&&g.UseCssFramework?"":"cursor:pointer;width:14px;height:"+c+"px;";var h="<div id='"+e+BarControlEngine.BarOptionSuffix+"_Horizontal' onclick='ShowOptionWindow(\""+e+"\");' style='z-index:5;overflow:hidden;"+b+"'>";if(g&&g.UseCssFramework){h+="<div optionBgColor='true'>"+WebToolBarFactoryEngine.GetSymbol(g,6)+"</div>"}else{h+="<div optionBgColor='true' style='float:left;width:3px;height:"+c+"px;"+a+"'>";h+="<div bodyBgColor='true' style='float:left;overflow:hidden;width:1px;margin-top:0px;height:"+c+"px;"+d+"'></div>";h+="<div bodyBgColor='true' style='float:left;overflow:hidden;width:1px;margin-top:1px;height:"+(c-2)+"px;"+d+"'></div>";h+="<div bodyBgColor='true' style='float:left;overflow:hidden;width:1px;margin-top:2px;height:"+(c-4)+"px;"+d+"'></div>";h+="</div>";h+="<div optionBgColor='true' style='float:left;overflow:hidden;width:8px;padding-top:8px;padding-top:"+f+"px;height:"+c+"px;"+a+"'>"+WebToolBarFactoryEngine.GetSymbol(g,6,"#000000")+"</div>";h+="<div optionBgColor='true' style='float:left;overflow:hidden;width:1px;margin-top:0px;height:"+c+"px;"+a+"'></div>";h+="<div optionBgColor='true' style='float:left;overflow:hidden;width:1px;margin-top:1px;height:"+(c-2)+"px;"+a+"'></div>";h+="<div optionBgColor='true' style='float:left;overflow:hidden;width:1px;margin-top:2px;height:"+(c-4)+"px;"+a+"'></div>"}h+="</div>";return h},RenderHandleOffice2000Horizontal:function(d,c,b){var f=d.WebToolBarStyleSettings;if(f==null){f=d}var a=WebToolBarFactoryEngine._GetGradientBackColorStyle(f.HandleStyle,"h");var e="<div handleBgColor='true' style='OVERFLOW: hidden;"+(d.AllowMove?"cursor:move;":"")+"width:8px;height:"+b+"px;"+a+";PADDING-RIGHT: 3px; PADDING-LEFT: 2px; PADDING-BOTTOM: 2px; PADDING-TOP: 2px;'>";if(d.AllowMove){e+="<DIV handleForeColor='true' style='OVERFLOW: hidden;BORDER-RIGHT:white 1px outset;BORDER-TOP:white 1px outset;BORDER-LEFT:white 1px outset;BORDER-BOTTOM:white 1px outset;width:100%;height:100%;background-color:darkgray'></DIV>"}e+="</div>";return e},RenderOptionOffice2000Horizontal:function(d,c,b){var f=d.WebToolBarStyleSettings;if(f==null){f=d}var a=WebToolBarFactoryEngine._GetGradientBackColorStyle(f.OptionStyle,"h");var e="<div optionBgColor='true' id='"+c+BarControlEngine.BarOptionSuffix+"_Horizontal' onclick='ShowOptionWindow(\""+c+"\");' style='overflow:hidden;cursor:pointer;width:14px;height:"+b+"px;"+a+"'><div style='overflow:hidden;float:left;width:3px;height:"+b+"px'></div>";e+="<div style='float:left;overflow:hidden;width:8px;padding-top:8px;height:"+b+"px;'>"+WebToolBarFactoryEngine.GetSymbol(d,6,"#000000")+"</div>";e+="<div style='float:left;overflow:hidden;width:3px;position:relative;height:"+b+"px'></div></div>";return e},RenderHandleOfficeXPHorizontal:function(e,d,c){var g=e.WebToolBarStyleSettings;if(g==null){g=e}var a=WebToolBarFactoryEngine._GetGradientBackColorStyle(g.HandleStyle,"h");var f="<div handleBgColor='true' style='"+(e.AllowMove?"cursor:move;":"")+"overflow:hidden;width:8px;height:"+c+"px;"+a+"'>";if(e.AllowMove){var b=2;while(b<c){f+="<div handleForeColor='true' style='overflow: hidden; width: 4px; height: 1px; background-color: #000000; margin-left:1px; margin-top:1px'></div>";b+=2}}f+="</div>";return f},RenderHandleComplexImagesVertical:function(c,b,a){var e=c.WebToolBarStyleSettings;if(e==null){e=c}var d="<div style='"+(c.AllowMove?"cursor:move;":"")+"OVERFLOW: hidden;height:8px;width:"+a+"px; BACKGROUND-IMAGE: url("+e.HandleStyle.BackgroundImageVertical+");PADDING-RIGHT: 3px; PADDING-LEFT: 2px; PADDING-BOTTOM: 2px; PADDING-TOP: 2px;'></div>";return d},RenderOptionComplexImagesVertical:function(c,b,a){var e=c.WebToolBarStyleSettings;if(e==null){e=c}var d="<div id='"+b+BarControlEngine.BarOptionSuffix+"_Vertical' onclick='ShowOptionWindow(\""+b+"\");' style='overflow:hidden;cursor:pointer;height:14px;width:"+a+"px;background-image: url("+e.OptionStyle.BackgroundImageVertical+")'><div style='overflow:hidden;height:3px;width:"+a+"px'></div>";d+="<div style='overflow:hidden;padding-top:5px;height:14px'>"+WebToolBarFactoryEngine.GetSymbol(c,6,"#000000")+"</div>";d+="<div style='overflow:hidden;height:3px;position:relative;width:"+a+"px'></div></div>";return d},RenderHandleOffice2003Vertical:function(f,e,d){var h=f.WebToolBarStyleSettings;if(h==null){h=f}var c=Math.abs((d-10)/(IS.ie?2:4))-1;var a=WebToolBarFactoryEngine._GetGradientBackColorStyle(h.HandleStyle,"v");var b=f&&f.UseCssFramework?"":"height:8px;width:"+d+"px";var g="<div style='float:left;"+(f.AllowMove?"cursor:move;":"")+b+"'>";g+="<div handleBgColor='true' style='overflow:hidden;height:1px;margin-left:2px;width:"+(d-4)+"px;"+a+"'></div>";g+="<div handleBgColor='true' style='overflow:hidden;height:1px;margin-left:1px;width:"+(d-2)+"px;"+a+"'></div>";g+="<div handleBgColor='true' style='overflow:hidden;height:1px;margin-left:0px;width:"+d+"px;"+a+"'></div>";g+="<div handleBgColor='true' style='overflow:hidden;height:5px;width:"+d+"px;"+a+"'>";if(f.AllowMove){g+="<div handleForeColor='true' style='float:left;margin-left:2px;width:2px;height:2px;background-color:#000000;overflow:hidden'></div>";c+=3;g+="<div handleForeColor='true' style='float:left;margin-left:2px;width:2px;height:2px;background-color:#000000;overflow:hidden'></div>";c+=3;g+="<div handleForeColor='true' style='float:left;margin-left:2px;width:2px;height:2px;background-color:#000000;overflow:hidden'></div>";c+=3;g+="<div handleForeColor='true' style='float:left;margin-left:2px;width:2px;height:2px;background-color:#000000;overflow:hidden'></div>"}g+="</div></div>";return g},RenderOptionOffice2003Vertical:function(g,e,c){var i=g.WebToolBarStyleSettings;if(i==null){i=g}var f=c-16;var d=WebToolBarFactoryEngine._GetGradientBackColorStyle(i.BodyStyle,"v");var a=WebToolBarFactoryEngine._GetGradientBackColorStyle(i.OptionStyle,"v");var b=g&&g.UseCssFramework?"":"cursor:pointer;height:14px;width:"+c+"px;";var h="<div id='"+e+BarControlEngine.BarOptionSuffix+"_Vertical' onclick='ShowOptionWindow(\""+e+"\");' style='z-index:5;overflow:hidden;"+b+"'>";if(g&&g.UseCssFramework){h+="<div optionBgColor='true'>"+WebToolBarFactoryEngine.GetSymbol(g,6)+"</div>"}else{h+="<div optionBgColor='true' style='height:3px;width:"+c+"px;"+a+"'>";h+="<div bodyBgColor='true' style='overflow:hidden;height:1px;margin-left:0px;width:"+c+"px;"+d+"'></div>";h+="<div bodyBgColor='true' style='overflow:hidden;height:1px;margin-left:1px;width:"+(c-2)+"px;"+d+"'></div>";h+="<div bodyBgColor='true' style='overflow:hidden;height:1px;margin-left:2px;width:"+(c-4)+"px;"+d+"'></div>";h+="</div>";h+="<div optionBgColor='true' style='overflow:hidden;height:14px;margin-top: -5px;"+a+"'>"+WebToolBarFactoryEngine.GetSymbol(g,6,"#000000")+"</div>";h+="<div optionForeColor='true' style='overflow:hidden;height:1px;margin-left:0px;width:"+c+"px;"+a+"'></div>";h+="<div optionForeColor='true' style='overflow:hidden;height:1px;margin-left:1px;width:"+(c-2)+"px;"+a+"'></div>";h+="<div optionForeColor='true' style='overflow:hidden;height:1px;margin-left:2px;width:"+(c-4)+"px;"+a+"'></div>"}h+="</div>";return h},RenderHandleOffice2000Vertical:function(d,c,b){var f=d.WebToolBarStyleSettings;if(f==null){f=d}var a=WebToolBarFactoryEngine._GetGradientBackColorStyle(f.HandleStyle,"v");var e="<div handleBgColor='true' style='OVERFLOW: hidden;"+(d.AllowMove?"cursor:move;":"")+"height:8px;width:"+b+"px;"+a+";PADDING-BOTTOM: 3px; PADDING-TOP: 2px; PADDING-LEFT: 2px; PADDING-RIGHT: 2px'>";if(d.AllowMove){e+="<DIV handleForeColor='true' style='OVERFLOW: hidden;BORDER-RIGHT:white 1px outset;BORDER-TOP:white 1px outset;BORDER-LEFT:white 1px outset;BORDER-BOTTOM:white 1px outset;width:100%;height:100%;background-color:darkgray'></DIV>"}e+="</div>";return e},RenderOptionOffice2000Vertical:function(d,c,b){var f=d.WebToolBarStyleSettings;if(f==null){f=d}var a=WebToolBarFactoryEngine._GetGradientBackColorStyle(f.OptionStyle,"v");var e="<div optionBgColor='true' id='"+c+BarControlEngine.BarOptionSuffix+"_Vertical' onclick='ShowOptionWindow(\""+c+"\");' style='overflow:hidden;cursor:pointer;height:14px;width:"+b+"px;"+a+"'><div style='overflow:hidden;height:3px;width:"+b+"px'></div>";e+="<div style='overflow:hidden;padding-top:5px;height:14px'>"+WebToolBarFactoryEngine.GetSymbol(d,6,"#000000")+"/div>";e+="<div style='overflow:hidden;height:3px;position:relative;width:"+b+"px'></div></div>";return e},RenderHandleOfficeXPVertical:function(e,d,c){var g=e.WebToolBarStyleSettings;if(g==null){g=e}var a=WebToolBarFactoryEngine._GetGradientBackColorStyle(g.HandleStyle,"v");var f="<div handleBgColor='true' style='"+(e.AllowMove?"cursor:move;":"")+"overflow:hidden;height:8px;width:"+c+"px;"+a+"'>";if(e.AllowMove){var b=2;while(b<c){f+="<div handleForeColor='true' style='float:left;overflow: hidden; height: 4px; width: 1px; background-color: #000000; margin-left:1px; margin-top:1px'></div>";b+=2}}f+="</div>";return f}};