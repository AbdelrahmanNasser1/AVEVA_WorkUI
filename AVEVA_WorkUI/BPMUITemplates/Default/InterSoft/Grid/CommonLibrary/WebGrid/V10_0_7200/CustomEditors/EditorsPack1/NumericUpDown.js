/*
Numeric UpDown CustomEditor V1.2 for WebGrid.NET Enterprise Version 4.0
Copyright (c) 2005 Intersoft Solutions Corp. All rights reserved.
Unauthorized distribution or modification of this script is strictly prohibited.

Public Properties:
-MinValue (int)
-MaxValue (int)

Set column-level properties for editor in CustomEditorProperties using WebGrid.NET Designer.

Features:
- Keyboard events. Press Up/Down to increase/decrease value
- Custom Dropdown. Click image up/down to increase/decrease value
- Validation. Perform validation on cell's value against MinValue and MaxValue
*/

// Implementation object for NumericUpDown which contains set of required methods for custom editor interface. 
// Format: CustomEditorName_Editor()
function NumericUpDown_Editor()
{

	// #Start required interface implementation

	// Fired on WebGrid's initialization
	// Put codes to initialize custom editor's properties and create necessary objects here
	this.OnInitialize = function()
	{

	};
	
	this.OnUnload = function()
	{
		//this = null;
		delete this;
	};
	
	// Fired when the control is entering edit mode
	// You can set default editor properties in this event
	this.OnEnterEditMode = function(activeCell, columnXml, isDirty)
	{
		// since that NumericUpDown used Custom DropdownButton
		// we have to display it manually.
		
		var dd = this.GetDropdownButtonElement();
		// use built-in WebGrid function to display the dropdown
		wgDispObjGeneric(this.Grid, dd, activeCell.element, activeCell.element.offsetWidth-this.CustomEditor.DropdownButtonWidth, 1, true);
		
		var baseEditor = this.GetBaseEditorElement();
		baseEditor.focus();
		baseEditor.isDirty = false;
		
		// apply column-based editor properties if any
		this.SetProperties();
		
		// you should return the base editor element if any
		// otherwise, return the dropdown object
		return baseEditor;
	};
	
	// Fired when the control is about to be displayed during enter edit mode.
	// The value of the editor need to be set to reflect current cell's text.
	this.OnSetValue = function(text, activeCell)
	{
		var baseEditor = this.GetBaseEditorElement();
		if (text == " ") text = "";
		if (text != "")
			text = wgGetUnMask(this.Grid, this.CustomEditor.GetColumnXml(), activeCell.element, true, text);
		baseEditor.value = text;
	};
	
	// Fired when the editor's content is changed.
	this.OnDirty = function() {
		var baseEditor = this.GetBaseEditorElement();
		baseEditor.isDirty = true;
	};
	
	// Fired when the editor is about to exit edit mode
	this.OnExitEditMode = function(isCancel) {
		var dd = this.GetDropdownButtonElement();
		dd.style.display = "none";

		var baseEditor = this.GetBaseEditorElement();
		baseEditor.style.display = "none";
		
		if (!isCancel)
			return this.OnValidate(this.Grid.GetLastEditObject().cellElement);
		
		return true;
	};
	
	// Fired when the changes in editor is applied/accepted
	this.OnApply = function()
	{
		// not used in Numericupdown scenario
	};
	
	// Fired when user cancel the changes in editor
	// by pressing Escape in editor or entire row changes cancel.
	this.OnCancel = function()
	{
		// not used in Numericupdown scenario
	};

	// Fired when the cell is about to exit edit mode
	// When the validation result is true, it will process to exit edit mode.
	this.OnValidate = function(activeCellElement)
	{
		var value = this.GetValue();
		value = parseFloat(value);
		
		if (isNaN(value)) value = this.MinValue;
		
		if (value >= this.MinValue && value <= this.MaxValue)
			return true;
		else
		{
			alert("OutOfRangeException: Value must be between " + this.MinValue + " and " + this.MaxValue);
			var curGrid = this.Grid;
			setTimeout(function(){wgHighlightEditCell(activeCellElement); wgActivateEditMode(curGrid);}, 50);
			return false;
		}
	};
	
	// Fired when user type on keyboard
	this.OnKeyDown = function(keyCode)
	{
		// additional keys for numeric updown
		switch (keyCode)
		{
			case 40:
				this.DecreaseValue();
				break;
				
			case 38:
				this.IncreaseValue();
				break;
		}
	};
	
	// Fired when dropdown button is clicked
	// Automatically fired used when dropdown button type is Image
	this.OnDropdown = function()
	{
		// not used in numeric updown
	};

	// Required method to get base editor element
	// Put codes to get the base editor element
	this.GetBaseEditorElement = function()
	{
		// since we used Textbox as BaseEditor, we can obtain
		// it directly in CustomEditor object.
		return this.CustomEditor.GetBaseEditorElement();
	};
	
	// Required method to get dropdown button element
	// Put codes here to get the dropdown button element
	this.GetDropdownButtonElement = function()
	{
		// since we used Custom dropdowntype, we have to create the object ourself.
		if (this.DDBtn == null)
		{
			// if dropdown button is null, let's create it.
			var imgUp = this.CustomEditor.ScriptFolder + "NumUp.jpg";
			var imgDown = this.CustomEditor.ScriptFolder + "NumDown.jpg";
			var ddHtml = "<table cellspacing=0 cellpadding=0><tr><td><img style='cursor:hand' onclick=\"NumericUpDown_ImgUp(this, '" + this.Grid.Name + "', '" + this.CustomEditor.Name + "')\" src='" + imgUp + "'></td></tr><tr><td><img style='cursor:hand' onclick=\"NumericUpDown_ImgDown(this, '" + this.Grid.Name + "', '" + this.CustomEditor.Name + "')\" src='" + imgDown + "'></td></tr></table>";
			var span = document.createElement("SPAN");
			span.innerHTML = ddHtml;
			this.DDBtn = this.Grid.FrameObj.appendChild(span);
		}
		return this.DDBtn;
	};
	
	// Required method to get the IsDirty status of the editor	
	this.IsDirty = function()
	{
		var baseEditor = this.GetBaseEditorElement();
		return baseEditor.isDirty;
	};
	
	// Required method to get the content of the editor
	this.GetText = function()
	{
		var baseEditor = this.GetBaseEditorElement();
		var text = baseEditor.value;
		
		if (text == null) text = "";
		text = wgGetMask(this.Grid, this.Grid.GetLastEditObject(), text);
		return text;
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

	this.IncreaseValue = function()
	{
		var value = this.GetValue();
		value = parseFloat(value);
		
		if (isNaN(value)) value = 0;

		this.OnSetValue(String(value+1), this.CustomEditor.GetEditCell());
		this.OnDirty();
		this.CustomEditor.RowDirty();
		this.GetBaseEditorElement().focus();
	};
	
	this.DecreaseValue = function()
	{
		var value = this.GetValue();
		value = parseFloat(value);
		
		if (isNaN(value)) value = 0;
		this.OnSetValue(String(value-1), this.CustomEditor.GetEditCell());
		this.OnDirty();
		this.CustomEditor.RowDirty();
		this.GetBaseEditorElement().focus();
	};
	
	// #End interface implementation
	
	
	// #Start required properties
	
	this.Grid = null;
	this.CustomEditor = null;
	this.ControlName = "NumericUpDown";
	
	// #End properties
	
	// #Start NumericUpDown editor functions
	this.DDBtn = null;
	this.MinValue = 0;
	this.MaxValue = 2147483647;
	
	// Required method to apply individual property
	this.SetProperty = function(propName, propValue)
	{
		switch (propName)
		{
			case "MinValue":
				this.MinValue = propValue;
				break;
			case "MaxValue":
				this.MaxValue = propValue;
				break;
		}
	};	
	// #End functions
	
return this;
}

// fired when image up is clicked
function NumericUpDown_ImgUp(obj, gridId, ceName)
{
var grid = wgGetGridById(gridId);
var editor = grid.CustomEditors[ceName];
editor.ImplementationObject.IncreaseValue();
}

// fired when iamge down is clicked
function NumericUpDown_ImgDown(obj, gridId, ceName)
{
var grid = wgGetGridById(gridId);
var editor = grid.CustomEditors[ceName];
editor.ImplementationObject.DecreaseValue();

}
