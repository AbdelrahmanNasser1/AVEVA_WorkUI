/*
WebTextEditor Custom Editor for WebGrid Enterprise 7
(c) 2009 Intersoft Solutions Corp. All rights reserved.

Custom Editor Type: Server-side

Dependencies:
- Intersoft WebTextEditor v1.0

Server Properties:
- Customize text editor properties directly in WebTextEditor server control

Features:
- Deep integration with WebGrid's editing architecture and events
- Support SmartWebResources
*/

function WebTextEditor_Editor()
{
    // Required properties
    this.Grid = null;
    this.CustomEditor = null;
    this.ControlName = "WebTextEditor";
    this.ControlCreated = true;
    this.RequiredDependencyVersion = "1.0.1000.705";
    this.RequiredDependencyBuild = 705;
    
     // Instance methods
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
            alert("Unable to create WebTextEditor control. Make sure the control existed and visible in the page.");
            var dd = this.GetDropdownButtonElement();
            dd.style.display = "none";
            return false;
        }

        ddObj.style.display = "none";
        ddObj.style.zIndex = 299;
        ddObj.initialized = true;

        // configure editor integration
        var editor = this.GetTextEditor();
        var frameLayer = editor.GetFrameLayerElement();

        frameLayer.style.zIndex = 399;
        dv.insertAdjacentElement("beforeEnd", frameLayer);
        dv.insertAdjacentElement("beforeEnd", ddObj);

        editor.IntegratedWebGridID = this.Grid.Id;
        editor.ClientSideEvents.OnCallOutCreated = this.OnCallOutCreated;
        editor.RegisterIFrameBehavior();

        var iframes = editor.GetAllDesignIFrames();

        for (var i = 0; i < iframes.length; i++)
            this.Grid.EditControls.push(iframes[i]);

        return true;
    };

    this.GetTextEditor = function()
    {
        var controlID = this.CustomEditor.GetEditorClientID();
        
        if (!controlID)
            alert("Error: CustomEditor for this column is not configured properly. Please set the target editor ID to the CustomEditorServerId property.");
        
        return ISGetObject(controlID);
    };
    
    this.GetTextEditorFrame = function()
    {
        return this.GetTextEditor().FrameObj;
    }

    this.CloseDropdown = function()
    {
        var editor = this.GetTextEditor();
        
        editor.Hide();
        editor.HideCallOut(true);
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

    this.InitializeWebTextEditor = function(editor)
    {
        var __implementation = this;
        
        if (!editor.IntegratedToWebGrid)
        {
            editor.IntegratedToWebGrid = true;

            // intercept properties recursive completion
            editor.OnSetPropertiesRecursive = function()
            {
                editor.ClientSideEvents.OnInitializeToolBar = function(id, toolbarArgs)
                {
                    var newBar = [{ "Name": editor.ID + "_tbWebGrid", "Text": "Update", "Category": "Custom",
                        "Commands": []}];

                    var newCommands = [{ "Name": "cmdUpdate", "Text": "Update", "DisplayMode": "TextAndImage",
                                            "Image": editor.ResolveImagePath(editor.ImagesDirectory, "tb_apply.gif"), 
                                            "ToolTip": "Update changes", "Type": "Button", "Items": new ISArray()
                                            },
                                       { "Name": "cmdCancel", "Text": "Cancel", "DisplayMode": "TextAndImage",
                                            "Image": editor.ResolveImagePath(editor.ImagesDirectory, "tb_cancel.gif"), 
                                            "ToolTip": "Cancel changes", "Type": "Button", "Items": new ISArray()
                                            }
                                      ];

                    toolbarArgs.AddToolBar(toolbarArgs.ToolBar, newBar);

                    for (var i = 0; i < newCommands.length; i++)
                        toolbarArgs.AddCommand(toolbarArgs.GetToolBar("Custom", editor.ID + "_tbWebGrid"), newCommands[i]);
                }
                
                editor.ClientSideEvents.OnToolBarClick = function(id, cmd, cmdSection)
                {
                    switch (cmd.Name)
                    {
                        case "cmdUpdate":
                            __implementation.OnApply();
                            break;
                            
                        case "cmdCancel":
                            __implementation.OnCancel();
                            break;
                    }
                }
            };
        }
    };

    this.MonitorIntersoftControls = function(o, ceInterface)
    {
        if (o && o.GetType && o.GetType() == "WebTextEditor")
        {
            var grid = ceInterface.Grid;
            
            for (var i=0; i<grid.CustomEditorServerIDs.length; i++)
            {
                if (o.Id == grid.CustomEditorServerIDs[i].replace(/\$/ig, '_'))
                    this.InitializeWebTextEditor(o);
            }
        }
    };
    
    this.OnDropdownButtonClick = function()
    {
        var editor = this[1].CustomEditors[this[2]];
        editor.ImplementationObject.OnDropdown();
    };
    
    this.OnDropdownButtonKeyDown = function()
    {
        var keyCode = event.keyCode;
        var editor = this[1].CustomEditors[this[2]];
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
    };

    this.OnCallOutCreated = function(id)
    {
        var callout = ISGetObject(id);
        var rte = callout.Parent;
        var grid = ISGetObject(rte.IntegratedWebGridID);
        
        grid.EditControls.push(callout.FrameObj);
    };
}

var __WTE = WebTextEditor_Editor.prototype;

// #Start required interface implementation

// Fired on WebGrid's initialization
// Put codes to initialize custom editor's properties and create necessary objects here
__WTE.OnInitialize = function()
{
    var wte = this;
    ISEvent.AddFunctionHandler(window, "OnIntersoftControlRegister", function(o) {wte.MonitorIntersoftControls(o, wte);});
};

__WTE.OnUnload = function()
{
    var wte = this;
    ISEvent.RemoveFunctionHandler(window, "OnIntersoftControlRegister", function(o) {wte.MonitorIntersoftControls(o, wte);});
    delete this;
};

// Fired when the control is entering edit mode
// You can set default editor properties in this event
__WTE.OnEnterEditMode = function(activeCell, columnXml, isDirty)
{
    var dd = this.GetDropdownButtonElement();
    var textEditor = this.GetTextEditor();

    // dependencies validation
    if (textEditor.BuildNumber < this.RequiredDependencyBuild)
    {
        alert("This custom editor requires Intersoft WebTextEditor version " + this.RequiredDependencyVersion + " or later.");
        return false;
    }

    // use built-in WebGrid function to display the dropdown
    wgDispObjGeneric(this.Grid, dd, activeCell.element, activeCell.element.offsetWidth - this.CustomEditor.DropdownButtonWidth - 5, 1, true);
    dd.style.height = activeCell.element.offsetHeight - 2;

    // apply column-based editor properties if any
    this.SetProperties();

    // you should return the base editor element if any
    // otherwise, return the dropdown object

    if (IS.ie)
        dd.setActive();
    else
        dd.children[0].setActive();

    return this.GetDropdownObject();
};

// Fired when the control is about to be displayed during enter edit mode.
// The value of the editor need to be set to reflect current cell's text.
__WTE.OnSetValue = function(text, activeCell)
{
    if (!this.ControlCreated) 
        return false;

    // we don't use text here, because we need to get the HTML of the cell's content.
    var content = this.GetContentCell();
    var textEditor = this.GetTextEditor();

    // save original text for restoration on cancel event.
    this.OriginalText = content.innerHTML;
    textEditor.ResetEditorState();
    textEditor.SetValue(this.OriginalText);
    textEditor.IsDirty = false;
};

// Fired when the editor's content is changed.
__WTE.OnDirty = function()
{
    var textEditor = this.GetTextEditor();
    textEditor.IsDirty = true;
    this.CustomEditor.CellDirty(); // mark cell as dirty. This call is needed in WebTextEditor because cell update is done manually in update button.
};

// Fired when the editor is about to exit edit mode
__WTE.OnExitEditMode = function(isCancel)
{
    var dd = this.GetDropdownButtonElement();
    dd.style.display = "none";

    if (!this.CustomEditor.IsRowDirty())
        this.OnCancel();

    this.CloseDropdown();

    return true;
};

// Fired when the changes in editor is applied/accepted
__WTE.OnApply = function()
{
    // for richtextbox, cell content will only be updated on Update button click.

    var textEditor = this.GetTextEditor();
    var content = this.GetContentCell();
    var result = textEditor.GetValue();

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
__WTE.OnCancel = function()
{
    this.CloseDropdown();
};

// Fired when the cell is about to exit edit mode
// When the validation result is true, it will process to exit edit mode.
__WTE.OnValidate = function(activeCellElement)
{
    // always valid
    return true;
};

// Fired when user type on keyboard
__WTE.OnKeyDown = function(keyCode)
{
    // additional keys for numeric updown
};

// Fired when dropdown button is clicked
// Automatically fired used when dropdown button type is Image
__WTE.OnDropdown = function()
{
    var editor = this.GetTextEditor();
    var ddObj = this.GetDropdownObject();
    var activeCell = this.CustomEditor.GetEditCell();
    
    if (!ddObj.initialized)
    {
        var result = this.InitializeDropdownObject();
        
        if (!result) 
            return;
    }

    if (!this.Grid.GetLastEditObject())
    {
        // simulate enter key
        var oEvt = document.createEventObject();
        var ac = this.CustomEditor.GetEditCellElement();
        oEvt.keyCode = 13;
        oEvt._srcElement = ac;

        if (IS.ie)
        {
            ac.fireEvent("onkeydown", oEvt);
        }
        else
        {
            oEvt.srcElement = ac;
            wgProcessKeyboardEvents(oEvt);
        }
    }

    wgDispObjGeneric(this.Grid, ddObj, activeCell.element, 1, activeCell.element.offsetHeight, true);

    var left = parseFloat(ddObj.style.left);
    var top = parseFloat(ddObj.style.top);
    var width = parseFloat(ddObj.offsetWidth);
    var height = parseFloat(ddObj.offsetHeight);

    width = this.GetTextEditorFrame().offsetWidth;

    if (left + width > document.body.clientWidth)
        ddObj.style.left = document.body.clientWidth - width - 50;

    if (top + height > document.body.offsetHeight)
    {
        var pTop = top - ((top + height) - document.body.offsetHeight) - 150;
        
        if (pTop < 0) 
            pTop = 25;
        
        ddObj.style.top = pTop;
    }

    setTimeout(function() {editor.SetFocus();}, 100);
};

// Required method to get base editor element
// Put codes to get the base editor element
__WTE.GetBaseEditorElement = function()
{
    // since we used Textbox as BaseEditor, we can obtain
    // it directly in CustomEditor object.
    return this.CustomEditor.GetBaseEditorElement();
};

// Required method to get dropdown button element
// Put codes here to get the dropdown button element
__WTE.GetDropdownButtonElement = function()
{
    if (this.DDBtn == null)
    {
        // if dropdown button is null, let's create it.
        var img = "";

        if (this.Grid.UseWebResourcesForClient)
            img = this.Grid.ResolveImagePathEx("CustomEditors.EditorsPack3.WebTextEditor.gif");
        else
            img = this.Grid.ScriptDirectory + "CustomEditors/EditorsPack3/WebTextEditor.gif";

        var span = document.createElement("div");
        span.innerHTML = "&nbsp;";
        span.title = "Click to Edit";
        span.style.cssText = "width: 20px; background-color: whitesmoke; border: gray 1px solid; cursor: hand;" + 
                             "background-image: url(" + img + "); background-repeat: no-repeat; background-position: center center";

        if (!IS.ie)
            span.innerHTML = "<a style='text-underline: none; outline:none' href='#'>&nbsp;</a>";

        var args = [this, ISGetObject(this.Grid.Name), this.CustomEditor.Name];

        Listener.Add(span, "onclick", this.OnDropdownButtonClick, args);

        if (IS.ie)
            Listener.Add(span, "onkeydown", this.OnDropdownButtonKeyDown, args);
        else
            Listener.Add(span.children[0], "onkeydown", this.OnDropdownButtonKeyDown, args);

        this.DDBtn = this.Grid.FrameObj.appendChild(span);
        return this.DDBtn;
    }
    
    return this.DDBtn;
};

// Required method to get dropdown list object
__WTE.GetDropdownObject = function()
{
    // since that WebTextEditor is server control, we should get the control ID of which the column attached to.
    var controlID = this.CustomEditor.GetEditorClientID();
    var control = ISGetObject(controlID);

    if (!control)
    {
        this.ControlCreated = false;
        return false;
    }

    return control.FrameObj;
};

// Required method to get the IsDirty status of the editor
__WTE.IsDirty = function()
{
    var textEditor = this.GetTextEditor();
    return textEditor.IsDirty;
};

// Required method to get the content of the editor
__WTE.GetText = function()
{
    // always return originalText since we dont want to update to cell content
    // unless Update button in RichTextBox is clicked.
    return this.OriginalText;
};

// Required method to get the value of the editor
// Only useful when editor value is differ then content/text such as in Dropdownlist.
__WTE.GetValue = function()
{
    // since this editor has same value and content,
    // simply return the text
    return this.GetText();
};

// Required method to apply editor properties defined in Column's CustomEditorProperties
__WTE.SetProperties = function()
{
    var props = this.CustomEditor.GetColumnEditorProperties();
    var aProps = props.split(";");

    for (var i = 0; i < aProps.length; i++)
        this.SetProperty(aProps[i].split("=")[0], aProps[i].split("=")[1]);
};

// Indicates whether default behavior of exit edit mode should be processed
// This method is optional.
__WTE.ShouldProcessExitEditModeDefaultBehavior = function()
{
    return false;
};

// Indicates the cell's content mode
// This method is optional.
__WTE.GetContentMode = function()
{
    // valid value is "Text" or "HTML"
    // if this method is not implemented, the default is Text.
    return "HTML";
};