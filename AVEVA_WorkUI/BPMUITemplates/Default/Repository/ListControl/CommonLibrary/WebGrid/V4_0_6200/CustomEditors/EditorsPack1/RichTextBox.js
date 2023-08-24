/*
RichTextBox CustomEditor V1.7 for WebGrid.NET Enterprise Version 4.0
Copyright (c) 2004 Intersoft Solutions Corp. All rights reserved.
Unauthorized distribution or modification of this script is strictly prohibited.

Public Properties:
-

Set column-level properties for editor in CustomEditorProperties using WebGrid.NET Designer.

Features and behavior:
- Own key handler.
- No base editor.
- Update to cell content programmatically from Update button.
- Full OOP and implemented advanced interface

Version History:
V1.1 - Fixed display position to not lower than 0.
V1.5 - Updated to use WebGrid.NET V4.0 API.
*/

// Implementation object for RichTextBox which contains set of required methods for custom editor interface. 
// Format: CustomEditorName_Editor()
function RichTextBox_Editor()
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
		//delete this;
	};
	
	// Fired when the control is entering edit mode
	// You can set default editor properties in this event
	this.OnEnterEditMode = function(activeCell, columnXml, isDirty)
	{
		
		var dd = this.GetDropdownButtonElement();
		// use built-in WebGrid function to display the dropdown
		wgDispObjGeneric(this.Grid, dd, activeCell.element, activeCell.element.offsetWidth-this.CustomEditor.DropdownButtonWidth-2, 1, true);
		dd.style.height = activeCell.element.offsetHeight-2;
		
		// apply column-based editor properties if any
		this.SetProperties();
		
		// you should return the base editor element if any
		// otherwise, return the dropdown object
		dd.setActive();
		return this.GetDropdownObject();
	};
	
	// Fired when the control is about to be displayed during enter edit mode.
	// The value of the editor need to be set to reflect current cell's text.
	this.OnSetValue = function(text, activeCell)
	{
		if (!this.ControlCreated) return false;
		
		// we don't use text here, because we need to get the HTML of the cell's content.
		var content = this.GetContentCell();
		var textEditor = this.GetTextEditor();
		
		// save original text for restoration on cancel event.
		this.OriginalText = content.innerHTML;
		textEditor.innerHTML = this.OriginalText;
		textEditor.isDirty = false;
	};
	
	// Fired when the editor's content is changed.
	this.OnDirty = function() {
		var textEditor = this.GetTextEditor();
		textEditor.isDirty = true;
		this.CustomEditor.CellDirty(); // mark cell as dirty. This call is needed in richtextbox because cell update is done manually in update button.
	};
	
	// Fired when the editor is about to exit edit mode
	this.OnExitEditMode = function(isCancel) {
		var dd = this.GetDropdownButtonElement();
		dd.style.display = "none";

		if (!this.CustomEditor.IsRowDirty())
			this.OnCancel();
		
		this.CloseDropdown();
		return true;
	};
	
	// Fired when the changes in editor is applied/accepted
	this.OnApply = function()
	{
		// for richtextbox, cell content will only be updated on Update button click.
		
		var textEditor = this.GetTextEditor();
		var content = this.GetContentCell();
		var result = textEditor.innerHTML;
		
		if (result != "")
		{
			var regExp = new RegExp("\r\n", "g");
			result = result.replace(regExp, "");
		}
		
		content.innerHTML = result;
		
		this.CustomEditor.RowDirty(); // mark row as dirty
		this.OnDirty(); // mark current cell as dirty
		this.CloseDropdown();
	};
	
	// Fired when user cancel the changes in editor
	// by pressing Escape in editor or entire row changes cancel.
	this.OnCancel = function()
	{
		this.CloseDropdown();
	};

	// Fired when the cell is about to exit edit mode
	// When the validation result is true, it will process to exit edit mode.
	this.OnValidate = function(activeCellElement)
	{
		
	};
	
	// Fired when user type on keyboard (only for customeditor that has baseeditor)
	this.OnKeyDown = function(keyCode)
	{

	};
	
	// Fired when dropdown button is clicked
	// Automatically fired used when dropdown button type is Image, or F4 key is pressed
	this.OnDropdown = function()
	{
		var ddObj = this.GetDropdownObject();
		var activeCell = this.CustomEditor.GetEditCell();
		if (!ddObj.initialized) {
			var result = this.InitializeDropdownObject();
			if (!result) return;
		}
		
		if (!this.Grid.GetLastEditObject())
		{
			// simulate enter key
			var oEvt = document.createEventObject();
			var ac = this.CustomEditor.GetEditCellElement();
			oEvt.keyCode = 13;
			oEvt._srcElement = ac;
			ac.fireEvent("onkeydown", oEvt);
		}
				
		wgDispObjGeneric(this.Grid, ddObj, activeCell.element, 1, activeCell.element.offsetHeight, true);

		var left = parseFloat(ddObj.style.left);
		var top = parseFloat(ddObj.style.top);
		var width = parseFloat(ddObj.offsetWidth);
		var height = parseFloat(ddObj.offsetHeight);

		width = this.GetEditorTable().offsetWidth;

		if (left+width > document.body.clientWidth)
			ddObj.style.left = document.body.clientWidth - width - 50;

		if (top+height > document.body.offsetHeight) {
			var pTop = top - ((top+height) - document.body.offsetHeight) - 150;
			if (pTop < 0) pTop = 25;
			ddObj.style.top = pTop;
		}

		this.GetTextEditor().style.width = this.GetButtonBar().style.width = this.GetEditorTable().offsetWidth;
		this.GetTextEditor().focus();
	};

	// Required method to get base editor element
	// Put codes to get the base editor element
	this.GetBaseEditorElement = function()
	{
		// since that RichTextBox doesn't have base editor, just return true.
		return true;
	};
	
	// Required method to get dropdown button element
	// Put codes here to get the dropdown button element
	this.GetDropdownButtonElement = function()
	{
		if (this.DDBtn == null)
		{
			// if dropdown button is null, let's create it.
			var img = this.CustomEditor.ScriptFolder + "RichTextBox.gif";
			var ddHtml = "<img title='Click to Edit' style='top: expression(((this.parentElement.offsetHeight/2)-8)); position: relative;' src='" + img + "'>";
			var span = document.createElement("SPAN");
			span.innerHTML = ddHtml;
			span.style.cssText = "background-color: #FFD497; border: black 1px solid; cursor: hand";
			this.DDBtn = this.Grid.FrameObj.appendChild(span);
		}
	
		var gridName = this.Grid.Name;
		var edName = this.CustomEditor.Name;
		var DDBtn = this.DDBtn;
		DDBtn.onclick = function() {RichTextBox_ImgClick(DDBtn, gridName, edName);};
		DDBtn.onkeydown = function() {RichTextBox_KeyDown(DDBtn, gridName, edName);};

		return DDBtn;
	};
	
	// Required method to get dropdown list object
	this.GetDropdownObject = function()
	{
		// since that richtextbox is server control, we should get the control ID of which the column attached to.
		var controlID = this.CustomEditor.GetEditorClientID();
		var inputValue = document.getElementById(controlID /*+ "Value"*/);
		if (!inputValue)
		{
			this.ControlCreated = false;
			return false;
		}
		var mainFrame = inputValue.parentElement;
		
		return mainFrame;
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
		// unless Update button in RichTextBox is clicked.
		return this.OriginalText;
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
		return false;
	};
	
	// Indicates the cell's content mode
	// This method is optional.
	this.GetContentMode = function()
	{
		// valid value is "Text" or "HTML"
		// if this method is not implemented, the default is Text.
		return "HTML";
	};
	
	// #End interface implementation
	
	
	// #Start required properties
	
	this.Grid = null;
	this.CustomEditor = null;
	
	// #End properties
	
	// #Start RichTextBox editor functions
	this.DDBtn = null;
	this.ControlName = "RichTextBox";
	this.OriginalText = "";
	this.ControlCreated = true;
	
	// Required method to apply individual property
	this.SetProperty = function(propName, propValue)
	{

		
	};

	// Method to initialize dropdown object (rich textbox server control)
	this.InitializeDropdownObject = function()
	{
		var ddObj = this.GetDropdownObject();
		var dv = this.Grid.FrameObj;
		
		if (ddObj == null || !this.ControlCreated)
		{
			alert("Insufficient license to display RichTextBox control. Please read RichTextBox for WebGrid.NET Enterprise V3.5 license agreement in EditorsPack1 folder.");
			var dd = this.GetDropdownButtonElement();
			dd.style.display = "none";
			return false;
		}

		ddObj.style.display = "none";
		ddObj.style.zIndex = 299;
		ddObj.style.filter = "progid:DXImageTransform.Microsoft.Shadow(color='#666666', Direction=135, Strength=4)"
		// ddObj.childNodes[1].removeNode(true); - special build of radeditor for Intersoft doesn't require this code.
		dv.insertAdjacentElement("beforeEnd", ddObj);
		
		this.GetTextEditor().style.backgroundColor = "white";
		this.GetTextEditor().onselectstart = function() {event.cancelBubble=true;};
		this.GetButtonBar().style.backgroundColor = "lightgrey";
		
		var buttons = this.GetButtonBar().getElementsByTagName("button");
		var curObj = this;
		buttons[0].onclick = function() {curObj.OnCancel();}
		buttons[1].onclick = function() {curObj.OnApply();}
		
		ddObj.initialized = true;
		return true;
	};
	
	this.GetTextEditor = function()
	{
		var controlID = this.CustomEditor.GetEditorClientID();
		var editor = document.getElementById("radEditorContainer" + controlID);
		
		return editor;
	};
	
	this.GetButtonBar = function()
	{
		var controlID = this.CustomEditor.GetEditorClientID();
		var buttonBar = document.getElementById("radEditorButtonsTable" + controlID);
		
		return buttonBar;
	};
	
	this.GetEditorTable = function()
	{
		var controlID = this.CustomEditor.GetEditorClientID();
		var editorTable = document.getElementById("editorTable" + controlID);
		
		return editorTable;
	};
	
	this.CloseDropdown = function()
	{
		var ddObj = this.GetDropdownObject();
		ddObj.style.display = "none";
	};
	
	this.GetContentCell = function()
	{
		var rowEl = this.CustomEditor.GetEditRowElement();
		if (wgIsRecordRow(rowEl))
		{
			// if row type is record
			return this.CustomEditor.GetEditCellElement().childNodes[0];
		}
		else
		{
			// row type is either newrow or filterrow
			return this.CustomEditor.GetEditCellElement();
		}
	};
	
	// #End functions
	
return this;
}

// fired when image up is clicked
function RichTextBox_ImgClick(obj, gridId, ceName)
{
var grid = wgGetGridById(gridId);
var editor = grid.CustomEditors[ceName];
editor.ImplementationObject.OnDropdown();
}

function RichTextBox_KeyDown(obj, gridId, ceName)
{
var keyCode = event.keyCode;
var grid = wgGetGridById(gridId);
var editor = grid.CustomEditors[ceName];
var implement = editor.ImplementationObject;

switch (keyCode)
{
	case 13:
	case 115:
	case 32:
		implement.OnDropdown();
		break;
	case 27:
		implement.OnExitEditMode(true);
		editor.GetEditCellElement().setActive();
		editor.ClearEditObject();
		break;
}
event.cancelBubble = true;
event.keyCode = 0;
event.returnValue = false;
}