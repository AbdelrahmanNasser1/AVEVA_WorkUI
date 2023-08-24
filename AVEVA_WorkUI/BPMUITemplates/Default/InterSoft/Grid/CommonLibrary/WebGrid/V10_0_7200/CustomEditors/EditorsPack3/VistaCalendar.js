/*
Vista Calendar Custom Editor for WebGrid Enterprise 7
(c) 2009 Intersoft Solutions Corp. All rights reserved.

Dependencies:
- @SmartWebResources\S\WebScheduler_Calendar.js, Version=3.0.1000

Server Properties:
- IsReadOnly (bool)
- AllowNullValue (bool)

Features:
- Fully customizable calendar behaviors and features through rich WebCalendar object model/API
- Deeply integrated with WebGrid editing architecture and events
- 11/9/2013: Support WebScheduler 4
*/

function VistaCalendar_Editor()
{
    // Required properties
    this.Grid = null;
    this.CustomEditor = null;
    this.ControlName = "VistaCalendar";
    this.IsCreated = false;

    // Calendar properties
    this.Calendar = null;
    this.Popup = null;
    this.DefaultStyleMode = "Outlook2007Blue";
    this.UseDefaultStyle = true;
    this.SelectedDate = new Date();
    this.IsReadOnly = false;
    this.AllowNullValue = true;
    this.TodayLinkText = "Today";
    this.NoneLinkText = "None";
    this.TodayLinkTooltip = "Select today's date";
    this.NoneLinkTooltip = "Clear selection";

    // Instance methods
    this.SetProperty = function(propName, propValue)
    {
        switch (propName)
        {
            case "DefaultStyleMode":
                this.DefaultStyleMode = propValue;
                break;
            case "SelectedDate":
                this.SelectedDate = new Date(propValue);
                break;
            case "IsReadOnly":
                var baseEditor = this.GetBaseEditorElement();
                baseEditor.readOnly = (propValue == "true");
                break;
            case "AllowNullValue":
                this.AllowNullValue = (propValue.toLowerCase() == "true");
                
                if (this.IsCreated)
                {
                    var secondCell = this.GetFooterElement(0, 1);
                    secondCell.style.display = (this.AllowNullValue ? "" : "none");
                }
                break;
        }
    };
    
    this.CreateCalendar = function()
    {
        var info = new WindowInfo();
        info.IsEnabled = true;
        info.DisplayType = "Normal";
        
        // setup globalization
        var dateInfo = this.Grid.CultureInfo.DateTimeFormatInfo;
        
        this.Calendar.ShortestDayNames = dateInfo.AbbreviatedDayNames;
        this.Calendar.MonthNames = dateInfo.MonthNames;
        this.Calendar.AbbreviatedMonthNames = dateInfo.AbbreviatedMonthNames;
        this.Calendar.OnSelectedDateChanged = this.OnDateChanged;

        // create the object and inject the content one time only
        var popup = new WindowPopup(info);
        popup.Owner = this;
        info.Popup = popup;
        popup.Init();
        
        // create main container
        var div = document.createElement("div");
        div.className = this.Calendar.CalendarFrameStyle;
        div.innerHTML = "<div></div><div></div>";
        
        // setup footer
        var footer = div.children[1];
        var footerContent = "<table cellpadding='4' class='" + this.Calendar.CalendarFooterStyle + "'><tr>";
        
        footerContent += "<td><a title=\"" + this.TodayLinkTooltip + "\" href='javascript:function(){};' class='" + 
                         this.Calendar.ButtonStyle + "'>" + this.TodayLinkText + "</a></td>";

        footerContent += "<td" + (!this.AllowNullValue ? " style='display:none'" : "") + "><a title=\"" + this.NoneLinkTooltip + 
                              "\" href='javascript:function(){};' class='" + 
                              this.Calendar.ButtonStyle + "'>" + this.NoneLinkText + "</a></td>";
        
        footerContent += "</tr></table>";
        footer.innerHTML = footerContent;
        
        // render
        popup._e.insertAdjacentElement("afterBegin", div);

        this.Popup = popup;
        this.Calendar.Owner = this;
        this.Calendar.InitializeCalendars(div.children[0], new Date());
        this.Calendar.Refresh();
        this.IsCreated = true;

        // register behaviors
        Listener.Add(this.GetFooterElement(0, 0).children[0], "onclick", this.OnTodayClick, this);
        Listener.Add(this.GetFooterElement(0, 1).children[0], "onclick", this.OnNoneClick, this);
    };
    
    this.GetFooterElement = function(r, c)
    {
        if (this.IsCreated)
        {
            var tb = this.Popup._e.children[0].children[1].children[0];
            
            if (typeof(r) != "undefined" && typeof(c) != "undefined")
                return tb.rows[r].cells[c];
            
            return tb;
        }
    };
    
    this.ShowCalendar = function()
    {
        var activeCell = this.CustomEditor.GetEditCell().element;
        
        if (!this.IsCreated)
            this.CreateCalendar();
        
        this.Popup.ShowSmart(ISPosLib.getLeftW3C(activeCell), ISPosLib.getTopW3C(activeCell) + ISPosLib.getHeight(activeCell), activeCell, null, true);
    };
    
    this.HideCalendar = function()
    {
        if (this.Popup != null)
            this.Popup.hide();
    };
    
    this.SetSelectedDate = function(newDate, skipEvent)
    {
        var date = new Date();
        var activeCell = this.CustomEditor.GetEditCell().ToCellObject();
        
        if (typeof(newDate) == "string")
        {
            if (newDate != "")
            {
                var clData = new ISClientData(null, "datetime", activeCell.Column.DataFormatString);
                clData.NewValue = newDate;
                this.Grid.ValEngine.Validate(clData, this.Grid.CultureInfo);

                if (clData.IsValid)
                    date = new Date(clData.DateData.Year, clData.DateData.Month, clData.DateData.Day);
            }
        }
        else
            date = newDate;

        this.Calendar.SetSelectedDate(date, false, true, true, skipEvent);
    };
    
    this.FocusBaseEditor = function()
    {
        this.GetBaseEditorElement().focus();
    };
    
    this.OnTodayClick = function()
    {
        this.SetSelectedDate(new Date());

        if (event)
        {
            event.cancelBubble = true;
            event.returnValue = false;
        }
    };
    
    this.OnNoneClick = function()
    {
        this.OnSetValue(null, this.CustomEditor.GetEditCell());
        this.OnDirty();
        this.CustomEditor.RowDirty();
        this.HideCalendar();
        
        if (event)
        {
            event.cancelBubble = true;
            event.returnValue = false;
        }
    };
    
    this.OnDateChanged = function(cal, date)
    {
        var vce = cal.Owner;
        var activeCell = vce.CustomEditor.GetEditCell().ToCellObject();
        var dateFormat = activeCell.Column.DataFormatString;
        var day = date.getDate();
        var month = date.getMonth();
        var year = date.getFullYear();
        
        if (dateFormat == "")
            dateFormat = "d";

        var clData = new ISClientData(null, "datetime", dateFormat);
        var clDate = new ISDateData(day, month, year, 0, 0, 0, 0, 0, 0);

        ISEvent.Raise(vce.Grid.LayoutSettings.ClientSideEvents.OnCalendarSelect, vce.Grid.Name, vce.GetBaseEditorElement(), year, month, day);

        clData.DateData = clDate;
        clData.MatchDateFormat = dateFormat;

        var clPattern = new ISDateTimePattern(clData, vce.Grid.CultureInfo.DateTimeFormatInfo);
        clPattern.CreatePattern();
        clPattern.MaskData();

        vce.OnSetValue(clData.FormattedValue, vce.CustomEditor.GetEditCell());
        vce.OnDirty();
        vce.CustomEditor.RowDirty();
        vce.HideCalendar();
        vce.FocusBaseEditor();
    };
    
    this.SetDefaultStyleMode = function(style)
    {
        var stylePrefix = "WSB1";
        var cal = this.Calendar;

        this.DefaultStyleMode = style;
        this.Calendar.DefaultStyleMode = style;

        if (this.DefaultStyleMode == "Outlook2007Black")
            stylePrefix = "WSB2";

        cal.CalendarFrameStyle = stylePrefix + "_CalendarFrameStyle";
        cal.CalendarTableStyle = stylePrefix + "_CalendarTableStyle";
        cal.CalendarHeaderStyle = stylePrefix + "_CalendarHeaderStyle";
        cal.CalendarInboundCellStyle = stylePrefix + "_CalendarInboundCellStyle";
        cal.CalendarOutboundCellStyle = stylePrefix + "_CalendarOutboundCellStyle";
        cal.CalendarSelectedCellStyle = stylePrefix + "_CalendarSelectedCellStyle";
        cal.CalendarTodayStyle = stylePrefix + "_CalendarTodayStyle";
        cal.CalendarWeekNameStyle = stylePrefix + "_CalendarWeekNameStyle";
        cal.CalendarWeekNumberStyle = stylePrefix + "_CalendarWeekNumberStyle";
        cal.HolidayStyle = stylePrefix + "_HolidayStyle";
        cal.CalendarFooterStyle = stylePrefix + "_FooterStyle";
        cal.ButtonStyle = stylePrefix + "_ButtonStyle";
    };
}

var __VCE = VistaCalendar_Editor.prototype;

// #Start required interface implementation

// Fired on WebGrid's initialization
// Put codes to initialize custom editor's properties and create necessary objects here
__VCE.OnInitialize = function()
{
    if (typeof(WebCalendar) == "undefined" && typeof(WebSchedulerCalendar) == "undefined")
    {
        alert("The dependency 'WebScheduler_Calendar' required by Vista Calendar editor cannot be loaded.");
        return false;
    }

    // create calendar object
    var cal = typeof(WebCalendar) != "undefined" ? new WebCalendar(this.Grid.Id + "_VCE") : new WebSchedulerCalendar(this.Grid.Id + "_VCE");
    this.Calendar = cal;
    
    cal.NumberOfMonthDisplayed = 1;
    
    if (this.UseDefaultStyle)
        this.SetDefaultStyleMode(this.DefaultStyleMode);
    
    cal.TextSettings.CalendarHeaderText = "Select month/year";
    cal.TextSettings.CalendarPrevArrowText = "Go to previous month";
    cal.TextSettings.CalendarNextArrowText = "Go to next month";
    
    cal.WebResourceIdentifier = "G";
    cal.CustomWebResourceFolder = "CustomEditors.EditorsPack3.";
    cal.UseDefaultStyle = this.UseDefaultStyle;
    cal.DefaultStyleMode = this.DefaultStyleMode;
    cal.ShowWeekNumbers = false;
    cal.ImagesDirectory = this.Grid.ScriptDirectory;
    cal.UseWebResourcesForClient = this.Grid.UseWebResourcesForClient;
    cal.NavigationMode = true;

    if (!cal.UseWebResourcesForClient)
        cal.CustomWebResourceFolder = cal.CustomWebResourceFolder.replace(/[.]/ig, "/");
};

__VCE.OnUnload = function()
{
    if (this.IsCreated)
    {
        // unregister behaviors
        Listener.Unload(this.GetFooterElement(0, 0).children[0]);
        Listener.Unload(this.GetFooterElement(0, 1).children[0]);
    }

    delete this;
};

// Fired when the control is entering edit mode
// You can set default editor properties in this event
__VCE.OnEnterEditMode = function(activeCell, columnXml, isDirty)
{
    var dd = this.GetDropdownButtonElement();
    var baseEditor = this.GetBaseEditorElement();

    // apply column-based editor properties if any
    this.SetProperties();

    baseEditor.focus();
    baseEditor.isDirty = false;

    // you should return the base editor element if any
    // otherwise, return the dropdown object
    return baseEditor;
};

// Fired when the control is about to be displayed during enter edit mode.
// The value of the editor need to be set to reflect current cell's text.
__VCE.OnSetValue = function(text, activeCell)
{
    var baseEditor = this.GetBaseEditorElement();
    
    if (text == null)
    {
        baseEditor.value = "";
        return;
    }
    
    if (text == " ") 
        text = "";
    
    if (text != "")
        text = wgGetUnMask(this.Grid, this.CustomEditor.GetColumnXml(), activeCell.element, true, text);
    
    baseEditor.value = text;
};

// Fired when the editor's content is changed.
__VCE.OnDirty = function()
{
    var baseEditor = this.GetBaseEditorElement();
    baseEditor.isDirty = true;
    this.CustomEditor.CellDirty();
};

// Fired when the editor is about to exit edit mode
__VCE.OnExitEditMode = function(isCancel)
{
    var dd = this.GetDropdownButtonElement();
    dd.style.display = "none";

    var baseEditor = this.GetBaseEditorElement();
    baseEditor.style.display = "none";
    
    this.HideCalendar();

    if (!isCancel)
        return this.OnValidate(this.Grid.GetLastEditObject().cellElement);

    return true;
};

// Fired when the changes in editor is applied/accepted
__VCE.OnApply = function()
{
    // not used 
};

// Fired when user cancel the changes in editor
// by pressing Escape in editor or entire row changes cancel.
__VCE.OnCancel = function()
{
    // not used 
};

// Fired when the cell is about to exit edit mode
// When the validation result is true, it will process to exit edit mode.
__VCE.OnValidate = function(activeCellElement)
{
    // always valid
    return true;
};

// Fired when user type on keyboard
__VCE.OnKeyDown = function(keyCode)
{
    
};

// Fired when dropdown button is clicked
// Automatically fired used when dropdown button type is Image
__VCE.OnDropdown = function()
{
    this.ShowCalendar();
    this.GetBaseEditorElement().focus();
    
    // ensure calendar is in clean state
    if (this.Calendar.Calendars[0].SelectionView != "Month")
        this.Calendar.Calendars[0].ResetSelectionView();

    this.SetSelectedDate(this.GetBaseEditorElement().value, true);
};

// Required method to get base editor element
// Put codes to get the base editor element
__VCE.GetBaseEditorElement = function()
{
    // since we used Textbox as BaseEditor, we can obtain
    // it directly in CustomEditor object.
    return this.CustomEditor.GetBaseEditorElement();
};

// Required method to get dropdown button element
// Put codes here to get the dropdown button element
__VCE.GetDropdownButtonElement = function()
{
    // since we used Custom dropdowntype, we have to create the object ourself.
    return this.CustomEditor.GetDropdownButtonElement();
};

// Required method to get the IsDirty status of the editor
__VCE.IsDirty = function()
{
    var baseEditor = this.GetBaseEditorElement();
    return baseEditor.isDirty;
};

// Required method to get the content of the editor
__VCE.GetText = function()
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
__VCE.GetValue = function()
{
    // since this editor has same value and content,
    // simply return the text
    return this.GetText();
};

// Required method to apply editor properties defined in Column's CustomEditorProperties
__VCE.SetProperties = function()
{
    var props = this.CustomEditor.GetColumnEditorProperties();
    var aProps = props.split(";");
    
    for (var i = 0; i < aProps.length; i++)
        this.SetProperty(aProps[i].split("=")[0], aProps[i].split("=")[1]);
};