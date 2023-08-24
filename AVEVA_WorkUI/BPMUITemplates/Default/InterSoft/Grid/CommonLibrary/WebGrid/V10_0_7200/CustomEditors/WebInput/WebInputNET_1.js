/*
WebInput.NET CustomEditor V1.2 for WebGrid.NET Enterprise Version 3.5 and 4.0
Copyright (c) 2004 Intersoft Solutions Corp. All rights reserved.
Unauthorized distribution or modification of this script is strictly prohibited.

Last Modified Date: 2/17/2005
Version: 1.2.5000.0

Public Properties:
-

Set column-level properties for editor in CustomEditorProperties using WebGrid.NET Designer.

Features and behavior:
- Own key handler.
- No base editor.
- Full OOP and implemented advanced interface
- Support WebGrid.NET Enterprise 4.0

Dependencies:
-Shared\ISCore.jse (WebUI.NET Client Framework)
-WebInput\*.jse (WebInput Core Scripts)
*/

// Implementation object for WebInput.NET which contains set of required methods for custom editor interface.
// Format: CustomEditorName_Editor()
function WebInputNET_Editor()
{

	// #Start required interface implementation

	// Fired on WebGrid's initialization
	// Put codes to initialize custom editor's properties and create necessary objects here
	this.OnInitialize = function()
	{
	};

	// Initialize the WebInput only once
	this._Initialize = function()
	{
		var textEditor = this.GetTextEditor();
		var htmlObj = textEditor.HtmlObj;

		if (!textEditor._IsInitialized)
		{
			var grid = this.CustomEditor.Grid;
			var wi = this.GetTextEditorFrame();
			textEditor.HandleTab = true;
			Listener.Remove(htmlObj, "onkeydown", WIOnKeyDown_v1);
     		Listener.Append(0, htmlObj, "onbeforedeactivate", WebInputNET_DeActivate);
     		if (typeof(wgEditCtlKBHandler) == "function")
     			Listener.Append(0, htmlObj, "onkeydown", function() {wgEditCtlKBHandler(grid, "WebInputNET"); WIOnKeyDown_v1(); WebInputNET_Keydown();});
     		else
     			Listener.Append(0, htmlObj, "onkeydown", function() {grid.EditKeyboardHandler("WebInputNET"); WIOnKeyDown_v1(); WebInputNET_Keydown();});
     		
			Listener.Append(0, htmlObj, "onselectstart", function() {event.cancelBubble = true; event.returnValue = true; return true});
			grid.FrameObj.insertAdjacentElement("beforeEnd", wi);
			
			if (textEditor.DisplayFormat)
			{
				var _ctl = document.getElementById(textEditor.DisplayFormat.WindowInfo.ControlID);
				if (_ctl)
				{
					grid.FrameObj.insertAdjacentElement("beforeEnd", _ctl);
				}
			}
			
			if (textEditor.EditFormat)
			{
				var _ctl = document.getElementById(textEditor.EditFormat.WindowInfo.ControlID);
				if (_ctl)
				{
					grid.FrameObj.insertAdjacentElement("beforeEnd", _ctl);
				}
			
			}
			
			var ev = textEditor.Events;
			if (!ev) ev = new Object();
			if (!ev.OnDirty) ev.OnDirty = "";
			if (ev.OnDirty != "") ev.OnDirty += ";";
			
			ev.OnDirty += "WebInputNET_OnDirty('" + grid.Name + "')";
			
			textEditor.Events = ev;
			textEditor._IsInitialized = true;
		}
	};

	this.OnUnload = function()
	{
		var textEditor = this.GetTextEditor();
     	Listener.Remove(textEditor.HtmlObj, "onbeforedeactivate", WebInputNET_DeActivate);
	    Listener.Remove(textEditor.HtmlObj, "onkeydown", WebInputNET_Keydown);
	};

	// Fired when the control is entering edit mode
	// You can set default editor properties in this event
	this.OnEnterEditMode = function(activeCell, columnXml, isDirty)
	{

		this._Initialize();

		// use built-in WebGrid function to display the control
		var textEditorFrame = this.GetTextEditorFrame();

		wgDispObjGeneric(this.Grid, textEditorFrame, activeCell.element, 0, 1, false);

		// apply column-based editor properties if any
		this.SetProperties();

		// you should return the base editor element if any
		// otherwise, return the dropdown object

		var textEditor = this.GetTextEditor();
		
		if (textEditor.SkipSetValue) return textEditorFrame;
		
		//if (textEditor._WGI==null)
		//{
		// WGI always recreated because same instance can be used in multiple columns.
			var wgi = new Object();
			var dt = null;
			
			if (columnXml.attributes)
				dt = columnXml.attributes.getNamedItem("dataType").text;
			else
				dt = columnXml.DataType;
			
			dt = dt.replace("System.", "").toLowerCase();
			switch(dt)
			{
				case "single" :
				case "float" :
				case "double" :
				case "decimal" :
				case "sbyte" :
				case "byte" :
				case "short" :
				case "ushort" :
				case "int" :
				case "uint" :
				case "long" :
				case "ulong" :
				case "int16" :
				case "int32" :
				case "int64" :
				case "uint16" :
				case "uint32" :
				case "uint64" : wgi.dataType = "number"; break;
				default : wgi.dataType = dt;
			}

			if (columnXml.attributes)
				wgi.dataFormat = columnXml.attributes.getNamedItem("dataFormat").text;
			else
				wgi.dataFormat = columnXml.DataFormatString;

			if (wgi.dataType=="datetime")
			{
				var dti = textEditor.CultureInfo.DateTimeFormatInfo;
				if (wgi.dataFormat==null || wgi.dataFormat=="")
					wgi.dataFormat = dti.StandarFormat.GeneralLongTime;
				else
				{
					if (wgi.dataFormat.length==1) wgi.dataFormat = GetFullFormatDate(dti, wgi.dataFormat);
				}
			}

               textEditor._WGI = wgi;

		textEditorFrame.setActive();
		textEditor.DoFocus();
		textEditor.isDirty = false;
		textEditor.HtmlObj.isDirty = false;

		return textEditorFrame;
	};

	// Fired when the control is about to be displayed during enter edit mode.
	// The value of the editor need to be set to reflect current cell's text.
	this.OnSetValue = function(text, activeCell)
	{
		if (!this.ControlCreated) return false;

		var textEditor = this.GetTextEditor();
		if (textEditor.SkipSetValue) return;

		textEditor.isDirty = false;

		if (text == " ") text = "";

		var wgi = textEditor._WGI;
		var df = textEditor.DisplayFormat;
		var ef = textEditor.EditFormat;
		var dyf = textEditor.DynamicEditFormat;
		
		wgi.OldValue = text;

		if (df!=null || ef!=null || dyf!=null)
		{
			var ve = IS.GetValidationEngine();

			if (wgi.dataType=="datetime")
			{
				var cd = ef!=null ? ef.ClientData : df.ClientData;
				with(cd)
				{
					Type = "DateTime";
					Format = wgi.dataFormat;
					OldValue = NewValue = text;
					PromptChar = null;
					IsValid = true;
				}
				ve.Validate(cd, textEditor.CultureInfo);
				var wgf = wgi.dataFormat;
				var dd = cd.DateData;
				if (wgf.indexOf("h")<0 && wgf.indexOf("H")<0) dd.Hour24 = dd.Hour12 = 1;
				if (wgf.indexOf("m")<0) dd.Minute = 0;
				if (wgf.indexOf("s")<0) dd.Second = 0;

				if ((wgf.indexOf("h")<0 && wgf.indexOf("H")<0) && wgf.indexOf("m")<0 && wgf.indexOf("s")<0)
                                {
                                    	with(cd)
				       {
                         	                Format = textEditor.CultureInfo.DateTimeFormatInfo.StandarFormat.ShortDate;
						OldValue = NewValue = IS.GetCommonDateFormat(dd.Day, parseFloat(dd.Month)+1, dd.Year);
         				}
				}
				else
				{
					var d = new Date(dd.Year, dd.Month, parseFloat(dd.Day), dd.Hour24, dd.Minute, dd.Second, dd.Fraction);
				     //var v = d.toDateString() + " " + d.toTimeString();

                			var v = d.toDateString();
                		        var y = d.getFullYear();
                			if (y<1000)
                			{
                				v = v.substr(0, v.lastIndexOf(" ")+1);
                				v += y<100? "00" : "0";
                              			v += y.toString();
                			}
                			var ts = d.toTimeString();
                			ts = ts.substr(0,ts.indexOf(" "));
                			v += " " + ts;

                                       with(cd)
                                       {
				     	     Format = textEditor.CultureInfo.DateTimeFormatInfo.StandarFormat.GeneralLongTime;
	                    	             OldValue = NewValue = v;
					}
				}

				cd.IsValid = true;
				ve.Validate(cd, textEditor.CultureInfo);
				textEditor.Value = cd.FormattedValue;
				
				if (ef!=null)
				{
					cd = ef.ClientData;
        				with(cd)
        				{
        					Type = "DateTime";
        					Format = ef.Format;
        					OldValue = NewValue = textEditor.Value;
        					PromptChar = ef.PromptChar;
        					IsValid = true;
        				}
        				ve.Validate(cd, textEditor.CultureInfo);
			        	textEditor.Value = cd.FormattedValue;
                                }

			}
			else
			{
				if (wgi.dataType=="number")
				{

				var cd = ef!=null? ef.ClientData:(dyf!=null? dyf.ClientData:df.ClientData);

                        	/*var cd = df!=null ? df.ClientData : (ef!=null ? ef.ClientData : dyf.ClientData);*/
					with(cd)
					{
						Type = "Number";
						Format = wgi.dataFormat;
						OldValue = NewValue = text;
						PromptChar = null;
						IsValid = true;
					}
					textEditor.Value = ve.UnMask(cd, textEditor.CultureInfo);
				}
				else
				{
					if (wgi.dataType=="string" && ef!=null)
					{
						textEditor.Text = textEditor.EditText = textEditor.Value = textEditor.HtmlObj.value = textEditor.EditFormat.ParseRawText(text);
					}
				}
			}
		}
		else
                    textEditor.Text = textEditor.Value = text;

		if (textEditor.EditFormat==null)
		{
			textEditor.SetValue(textEditor.Value);
		}
		else
		{
			var ef = textEditor.EditFormat;
			textEditor.EditText = textEditor.GetEditText();
			textEditor.SetValue(textEditor.EditText);
		}

	};

	// Fired when the editor's content is changed.
	this.OnDirty = function() {
		var textEditor = this.GetTextEditor();
		textEditor.isDirty = true;
		this._GetLastEditCell().cellModified = true;
	};

	// Fired when the editor is about to exit edit mode
	this.OnExitEditMode = function(isCancel)
	{
		var textEditorFrame = this.GetTextEditorFrame();

		if (textEditorFrame && textEditorFrame.style.display != "none")
		{
			var te = this.GetTextEditor();
			te.DoLastBlur();
			te.HtmlObj.isActive = false;

			textEditorFrame.style.display = "none";

			if (isCancel)
			{
				if (!this.CustomEditor.IsRowDirty())
					this.OnCancel();
			} else
			{
				if (te.HtmlObj.isDirty || te.IsDirty)
				{
					this.OnDirty();
					var isValid = this.OnValidate();
					if (!isValid)
					{
						var curGrid = this.Grid;
						var activeCellElement = this.Grid.getLastEditObject().cellElement;
						var wi = te.EditFormat.WindowInfo;
						
						textEditorFrame.style.display = "";
						
						setTimeout(function()
						{
							// reactivate current edit object
							te.SkipSetValue = true;

							wgHighlightEditCell(activeCellElement);
							wgActivateEditMode(curGrid);
							textEditorFrame.setActive();
							te.SetFocus();

							te.SkipSetValue = false;
						}
						, 50
						);
						
						setTimeout(function()
						{
							// reshow error info
							WindowEngine.Show(wi);
							te.IsDirty = true;
						},
						500
						);
					}
					return isValid;
				}
			}
		}

		return true;
	};

	// Fired when the changes in editor is applied/accepted
	this.OnApply = function()
	{
		// not used in WebInput
	};

	// Fired when user cancel the changes in editor
	// by pressing Escape in editor or entire row changes cancel.
	this.OnCancel = function()
	{
		var textEditorFrame = this.GetTextEditorFrame();
        textEditorFrame.style.display = "none";

	};

	// Fired when the cell is about to exit edit mode
	// When the validation result is true, it will process to exit edit mode.
	this.OnValidate = function(activeCellElement)
	{
		var textEditor = this.GetTextEditor();
		var wgi = textEditor._WGI;
		var df = textEditor.DisplayFormat;
		var ef = textEditor.EditFormat;
		var dyf = textEditor.DynamicEditFormat;
		var isValid = false;
		if (ef)
		{
			var omv = document.getElementById(textEditor.Id + IS.MaskValidatorSuffix);
			isValid = MaskValidatorEvaluateIsValid(omv);
		}
		else
		{
			if (dyf)
			{
				var omv = document.getElementById(textEditor.Id + IS.MaskValidatorSuffix);
				isValid = DynamicMaskValidatorEvaluateIsValid(omv);
			}
			else
			{
				if (df)
				{
					var omv = document.getElementById(textEditor.Id + IS.FormatValidatorSuffix);
					isValid = FormatValidatorEvaluateIsValid(omv);
				}
			}
		}
		return isValid;
	};

	// Fired when user type on keyboard (only for customeditor that has baseeditor)
	this.OnKeyDown = function(keyCode)
	{
	};

	// Fired when dropdown button is clicked
	// Not used in WebInput
	this.OnDropdown = function()
	{
	};

	// Required method to get base editor element
	// Put codes to get the base editor element
	this.GetBaseEditorElement = function()
	{
		return this.GetTextEditorFrame();
	};

	// Required method to get dropdown button element
	// Put codes here to get the dropdown button element
	this.GetDropdownButtonElement = function()
	{
		return null;
	};

	// Required method to get dropdown list object
	this.GetDropdownObject = function()
	{
		return null;
	};

	// Required method to get the IsDirty status of the editor
	this.IsDirty = function()
	{
		var textEditor = this.GetTextEditor();
		return textEditor.isDirty;
	};

	// Required method to get the content of the editor
	this.GetText = function()
	{
		// always return originalText since we dont want to update to cell content
		// unless Update button in WebInput.NET is clicked.
		var textEditor = this.GetTextEditor();
		var wgi = textEditor._WGI;
		var df = textEditor.DisplayFormat;
		var ef = textEditor.EditFormat;
		var dyf = textEditor.DynamicEditFormat;

		if (!textEditor.isDirty)
		{
			// not edited at all
			return wgi.OldValue;
		}

		if (df!=null || ef!=null || dyf!=null)
		{
			var ve = IS.GetValidationEngine();

			if (wgi.dataType=="datetime")
			{
				var opType = this.Grid.GetSelectedObject().GetRowElement().type;
						
				var cd = opType=="NewRow"? (ef!=null? ef.ClientData:df.ClientData) :(df!=null ? df.ClientData : ef.ClientData);
				var dd = cd.DateData;
				var wgf = wgi.dataFormat;
				if (wgf.indexOf("h")<0 && wgf.indexOf("H")<0) dd.Hour24 = dd.Hour12 = 0;
				if (wgf.indexOf("m")<0) dd.Minute = 0;
				if (wgf.indexOf("s")<0) dd.Second = 0;
			     var d = new Date(dd.Year, dd.Month, parseFloat(dd.Day), dd.Hour24, dd.Minute, dd.Second, dd.Fraction);
			     
                        var v = d.toDateString();
		        var y = d.getFullYear();
			if (y<1000)
			{
				v = v.substr(0, v.lastIndexOf(" ")+1);
				v += y<100? "00" : "0";
              			v += y.toString();
			}
			var ts = d.toTimeString();
			ts = ts.substr(0,ts.indexOf(" "));
			v += " " + ts;

                             //var v = d.toDateString() + " " + d.toTimeString();
				//v = v.substr(0, v.indexOf("UTC")-1);
				with(cd)
				{
					Type = "DateTime";
					Format = wgi.dataFormat;
					OldValue = NewValue = v;
					PromptChar = null;
					IsValid = true;
				}
				if (ve.Validate(cd, textEditor.CultureInfo))
					return cd.FormattedValue;
				else
					return textEditor.Text;
			}
			else
			{
				if (wgi.dataType=="number")
				{
                    	var cd = df!=null ? df.ClientData : (ef!=null ? ef.ClientData : dyf.ClientData);
					with(cd)
					{
						Type = "Number";
						Format = wgi.dataFormat;
						OldValue = NewValue = textEditor.Value;
						PromptChar = null;
						IsValid = true;
					}
					if (ve.Validate(cd, textEditor.CultureInfo))
						return cd.FormattedValue;
					else
						return textEditor.Text;
				}
				else
				{
					if (wgi.dataType=="string" && ef!=null)
					{
						return textEditor.EditText.replace(new RegExp(ef.MaskInfo.PromptChar, "g"), " ");
					}
				}
			}
		}
		return textEditor.Text;
	};

	// Required method to get the value of the editor
	// Only useful when editor value is differ then content/text such as in Dropdownlist.
	this.GetValue = function()
	{
		// since this editor has same value and content,
		// simply return the text
		return this.GetText();
	};

	// Required method to apply editor properties defined in Column's CustomEditorProperties
	this.SetProperties = function()
	{
		var props = this.CustomEditor.GetColumnEditorProperties();
		var aProps = props.split(";");
		for (var i=0; i<aProps.length; i++)
		{
			this.SetProperty(aProps[i].split("=")[0], aProps[i].split("=")[1]);
		}
	};
	
	
	// Indicates whether default behavior of exit edit mode should be processed
	// This method is optional.
	this.ShouldProcessExitEditModeDefaultBehavior = function()
	{
		return true;
	};
	
	// Indicates the cell's content mode
	// This method is optional.
	this.GetContentMode = function()
	{
		// valid value is "Text" or "HTML"
		// if this method is not implemented, the default is Text.
		return "Text";
	};
	
	// #End interface implementation

	
	// #Start required properties
	
	this.Grid = null;
	this.CustomEditor = null;
	this._IsInitialized = false;
	
	// #End properties
	
	// #Start WebInput.NET editor functions
	this.DDBtn = null;
	this.ControlName = "WebInput.NET";
	this.OriginalText = "";
	this.ControlCreated = true;
	
	// Required method to apply individual property
	this.SetProperty = function(propName, propValue)
	{

		
	};

	// Method to initialize dropdown object (rich textbox server control)
	this.InitializeDropdownObject = function()
	{
		return true;
	};

	this.GetTextEditor = function()
	{
		var controlID = this._GetLastEditorClientID();
		var editor = IS.GetRuntimeObjectById(controlID);
		editor.CustomEditor = this;
		return editor;
	};

	this.GetTextEditorFrame = function()
	{
		var controlID = this._GetLastEditorClientID();
		var editorF = document.getElementById(controlID + IS.FrameSuffix);

		return editorF;
	};

	this.GetContentCell = function()
	{
		var rowEl = this.CustomEditor.GetEditRowElement();
		if (wgIsRecordRow(rowEl))
		{
			// if row type is record
			return this.CustomEditor.GetEditCellElement();
		}
		else
		{
			// row type is either newrow or filterrow
			return this.CustomEditor.GetEditCellElement();
		}
	};

	this._GetLastEditCell = function()
	{
		if (this.Grid.LastEditObj)
			return this.Grid.LastEditObj.cellElement;
		else
			return this.CustomEditor.GetEditCellElement();
	};
	
	this._GetColumnXml = function()
	{
		var table = this.CustomEditor.GetTable();
		var name = wgGetColNameByCell(this._GetLastEditCell());
		var col = null;
		
		try { col = table.getColumn(name); }
		catch(e) { col = table.GetColumn(name); }
		return col;
	};

	this._GetLastEditorClientID = function() {
		var colXml = this._GetColumnXml();
		
		if (colXml.CustomEditorServerId)
			return colXml.CustomEditorServerId;
		else
			return colXml.getAttribute("ceID");
	};		
	// #End functions
	
return this;
}

function WebInputNET_Keydown()
{
 	var c = IS.GetRuntimeObjectById(event.srcElement.id);

	if (c.CustomEditor)
	{
		var keyCode = event.keyCode;

		if (keyCode == 9)
		{
			event.cancelBubble = false;
			event.returnValue = false;
			event.keyCode = 0;
			return false;
		}
	}
	return true;
}

function WebInputNET_DeActivate()
{
	var c = IS.GetRuntimeObjectById(window.event.srcElement.id);
	if (c.CustomEditor)
	{
		if (c.isDirty) c.CustomEditor.OnApply();
	}
	event.returnValue = true;
	return true;
}

function WebInputNET_OnDirty(gridName)
{
	var grid = wgGetGridById(gridName);
	if (typeof(wgMarkEdit) == "function")
		wgMarkEdit(grid);
	else
		grid.MarkEdit();
}
