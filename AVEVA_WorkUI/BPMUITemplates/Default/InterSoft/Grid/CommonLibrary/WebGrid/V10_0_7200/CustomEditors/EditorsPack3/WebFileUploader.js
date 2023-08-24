/*
Intersoft WebFileUploader Custom Editor for WebGrid Enterprise 7
(c) 2009 Intersoft Solutions Corp. All rights reserved.

Dependencies:
- WebFileUploader v1

Server Properties:
- DropdownButtonTooltip

Features:
- Deeply integrated with WebGrid editing architecture and events
- Supports elegant style and SmartWebResources
*/

function WebFileUploader_Editor()
{
    // Required properties
    this.Grid = null;
    this.CustomEditor = null;
    this.ControlName = "VistaCalendar";
    this.IsCreated = false;
    this.Initialized = false;
    this.RequiredDependencyVersion = "1.0.1000.705";
    this.RequiredDependencyBuild = 705;
    
    // Server properties
    this.DropdownButtonTooltip = "Click to upload files";

    // Instance methods
    this.SetProperty = function(propName, propValue)
    {
        switch (propName)
        {
            case "DropdownButtonTooltip":
                this.DropdownButtonTooltip = propValue;
                break;
        }
    };
    
    this.CloseDropdown = function()
    {
        var fu = this.GetFileUploader();
        fu.Hide();
    };
    
    this.GetFileUploader = function()
    {
        var controlID = this.CustomEditor.GetEditorClientID();

        if (!controlID)
            alert("Error: CustomEditor for this column is not configured properly. Please set the target editor ID to the CustomEditorServerId property.");

        return ISGetObject(controlID);
    };

    this.ShowFileUploader = function()
    {
        var fu = this.GetFileUploader();
        fu.Show();
    };
    
    this.InitializeFileUploaderUI = function()
    {
        var fu = this.GetFileUploader();
        // manage existing files
        
        
        // buttons
        if (fu.UploadType != "AutomaticUpload" && fu.UILayout != "AttachmentBar")
        {
            
        }
    };
}

var __FUE = WebFileUploader_Editor.prototype;

// #Start required interface implementation

// Fired on WebGrid's initialization
// Put codes to initialize custom editor's properties and create necessary objects here
__FUE.OnInitialize = function()
{

};

__FUE.OnUnload = function()
{
    delete this;
};

// Fired when the control is entering edit mode
// You can set default editor properties in this event
__FUE.OnEnterEditMode = function(activeCell, columnXml, isDirty)
{
    var dd = this.GetDropdownButtonElement();
    var baseEditor = this.GetBaseEditorElement();
    var control = this.GetFileUploader();
    
    // dependencies validation
    if (control.BuildNumber < this.RequiredDependencyBuild)
    {
        alert("This custom editor requires Intersoft WebFileUploader version " + this.RequiredDependencyVersion + " or later.");
        return false;
    }
    
    // apply column-based editor properties if any
    this.SetProperties();
    this.CustomEditor.InitializeBaseEditor(activeCell);
    
    // one-time initialization
    if (!this.Initialized)
    {
        this.InitializeFileUploaderUI();
        this.Grid.FrameObj.appendChild(this.GetDropdownObject());
        this.Initialized = true;
    }

    dd.title = this.DropdownButtonTooltip;
    baseEditor.readOnly = true;
    baseEditor.isDirty = false;

    // you should return the base editor element if any
    // otherwise, return the dropdown object
    return baseEditor;
};

// Fired when the control is about to be displayed during enter edit mode.
// The value of the editor need to be set to reflect current cell's text.
__FUE.OnSetValue = function(text, activeCell)
{
    var baseEditor = this.GetBaseEditorElement();

    if (text == null)
    {
        baseEditor.value = "";
        return;
    }

    if (text == " ")
        text = "";

    baseEditor.value = text;
};

// Fired when the editor's content is changed.
__FUE.OnDirty = function()
{
    var baseEditor = this.GetBaseEditorElement();
    baseEditor.isDirty = true;
};

// Fired when the editor is about to exit edit mode
__FUE.OnExitEditMode = function(isCancel)
{
    var dd = this.GetDropdownButtonElement();
    dd.style.display = "none";

    var baseEditor = this.GetBaseEditorElement();
    baseEditor.style.display = "none";

    this.CloseDropdown();

    if (!isCancel)
        return this.OnValidate(this.Grid.GetLastEditObject().cellElement);

    return true;
};

// Fired when the changes in editor is applied/accepted
__FUE.OnApply = function()
{
    // not used 
};

// Fired when user cancel the changes in editor
// by pressing Escape in editor or entire row changes cancel.
__FUE.OnCancel = function()
{
    // not used 
};

// Fired when the cell is about to exit edit mode
// When the validation result is true, it will process to exit edit mode.
__FUE.OnValidate = function(activeCellElement)
{
    // always valid
    return true;
};

// Fired when user type on keyboard
__FUE.OnKeyDown = function(keyCode)
{

};

// Fired when dropdown button is clicked
// Automatically fired used when dropdown button type is Image
__FUE.OnDropdown = function()
{
    var control = this.GetFileUploader();
    var ddObj = this.GetDropdownObject();
    var activeCell = this.CustomEditor.GetEditCell();

    wgDispObjGeneric(this.Grid, ddObj, activeCell.element, 1, activeCell.element.offsetHeight, true);

    var left = parseFloat(ddObj.style.left);
    var top = parseFloat(ddObj.style.top);
    var width = parseFloat(ddObj.offsetWidth);
    var height = parseFloat(ddObj.offsetHeight);

    if (left + width > document.body.clientWidth)
        ddObj.style.left = document.body.clientWidth - width - 50;

    if (top + height > document.body.offsetHeight)
    {
        var pTop = top - ((top + height) - document.body.offsetHeight) - 150;

        if (pTop < 0)
            pTop = 25;

        ddObj.style.top = pTop;
    }

    // this.SetSelectedDate(this.GetBaseEditorElement().value, true);
};

// Required method to get base editor element
// Put codes to get the base editor element
__FUE.GetBaseEditorElement = function()
{
    // since we used Textbox as BaseEditor, we can obtain
    // it directly in CustomEditor object.
    return this.CustomEditor.GetBaseEditorElement();
};

// Required method to get dropdown button element
// Put codes here to get the dropdown button element
__FUE.GetDropdownButtonElement = function()
{
    // since we used Custom dropdowntype, we have to create the object ourself.
    return this.CustomEditor.GetDropdownButtonElement();
};

// Required method to get the IsDirty status of the editor
__FUE.IsDirty = function()
{
    var baseEditor = this.GetBaseEditorElement();
    return baseEditor.isDirty;
};

// Required method to get the content of the editor
__FUE.GetText = function()
{
    var baseEditor = this.GetBaseEditorElement();
    var text = baseEditor.value;

    if (text == null)
        text = "";

    if (text == "" && !this.AllowNullValue)
        text = wgGetMask(this.Grid, this.Grid.GetLastEditObject(), text);

    return text;
};

// Required method to get the value of the editor
// Only useful when editor value is differ then content/text such as in Dropdownlist.
__FUE.GetValue = function()
{
    // since this editor has same value and content,
    // simply return the text
    return this.GetText();
};

// Required method to apply editor properties defined in Column's CustomEditorProperties
__FUE.SetProperties = function()
{
    var props = this.CustomEditor.GetColumnEditorProperties();
    var aProps = props.split(";");

    for (var i = 0; i < aProps.length; i++)
        this.SetProperty(aProps[i].split("=")[0], aProps[i].split("=")[1]);
};

// Required method to get dropdown list object
__FUE.GetDropdownObject = function()
{
    // since that WebFileUploader is server control, we should get the control ID of which the column attached to.
    var controlID = this.CustomEditor.GetEditorClientID();
    var control = ISGetObject(controlID);

    if (!control)
    {
        this.ControlCreated = false;
        return false;
    }

    return control.FrameObj;
};