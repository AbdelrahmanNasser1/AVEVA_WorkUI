/*!
// ------------------------------------------------------------------------------------------------------------
// <copyright file="cwidget_support.js" company="Aveva">
// Copyright © 2021 AVEVA Group Plc. All rights reserved
// THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY
// KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
// PARTICULAR PURPOSE.
// </copyright>
// ------------------------------------------------------------------------------------------------------------
*/

/** cwidget support library
*	ver: 0.92
*	Author: Thommy Djupenström 
*	Ver		Date		By	Comment
*	0.9		1-Mar-21	TD	Initial version
*	
*	0.92	16-Apr-21	TD	Moved folder structure to js/Custom
**/
var FormCustomPath = "FORMCUSTOMPATH";
window.WW_IFRAME_PARAMETERNAME_UNIQUEID = "skuniqueid";
window.WW_IFRAME_PARAMETERNAME_FORMUNIQUEID = "skuniqueidforform";
window.WIDGET_INSTANCEID_ATTRIBUTE_NAME = "skwiid";

if (!String.prototype.startsWith)
{
    Object.defineProperty(String.prototype, 'startsWith', {
        value: function (search, rawPos)
        {
            var pos = rawPos > 0 ? rawPos | 0 : 0;
            return this.substring(pos, pos + search.length) === search;
        }
    });
}

if (!String.prototype.endsWith)
{
    String.prototype.endsWith = function (search, this_len)
    {
        if (this_len === undefined || this_len > this.length)
        {
            this_len = this.length;
        }
        return this.substring(this_len - search.length, this_len) === search;
    };
}

// Checks whether the obj is undefined or null.
function WW_isUndefinedOrNull(obj)
{
    return (obj === undefined || obj === null);
}

// Checks whether the obj is undefined, null or empty string.
function WW_isUndefinedNullOrEmpty(obj)
{
    return (WW_isUndefinedOrNull(obj) || obj === "");
}

function WW_isObject(obj)
{
    return ((!WW_isUndefinedOrNull(obj)) && (typeof obj === "object"));
}

// Gets the parameter value from the url
function WW_getUrlParameterValue(windowObject, parameterName)
{
    var match = RegExp('[?&]' + parameterName + '=([^&]*)').exec(windowObject.location.search);
    return match && decodeURIComponent(match[1].replace(/\+/g, ' '));
}

function WW_localize(key, valueWhenNoLocalizationIsPresent)
{
    var localizedValue = key;

    if (!WW_isUndefinedOrNull(window.skelta))
    {
        if (!WW_isUndefinedOrNull(window.skelta.localize))
        {
            if (!WW_isUndefinedOrNull(window.skelta.localize.getString))
            {
                localizedValue = window.skelta.localize.getString(key);
            }
        }
    }

    if (WW_isWidgetRenderedInsideIframe(window) && !WW_isUndefinedOrNull(window.frameElement.localize))
    {
        localizedValue = window.frameElement.localize.getString(key);
    }

    if (!WW_isUndefinedNullOrEmpty(valueWhenNoLocalizationIsPresent) && localizedValue === key)
    {
        localizedValue = valueWhenNoLocalizationIsPresent;
    }

    return localizedValue;
}

function WW_getLookupSchemaAndData()
{
    if (!WW_isUndefinedOrNull(window.skelta))
    {
        if (!WW_isUndefinedOrNull(window.skelta.forms))
        {
            if (!WW_isUndefinedOrNull(window.skelta.forms.utilities))
            {
                return window.skelta.forms.utilities.getLookupSchemaAndData.apply(window.skelta.forms.utilities, arguments);
            }
        }
    }

    if (WW_isWidgetRenderedInsideIframe(window) && !WW_isUndefinedOrNull(window.frameElement.SFU))
    {
        return window.frameElement.SFU.getLookupSchemaAndData.apply(window.frameElement.SFU, arguments);
    }

    return "";
}

function WW_getClientCredentialToken()
{
    if (!WW_isUndefinedOrNull(window.skelta))
    {
        if (!WW_isUndefinedOrNull(window.skelta.forms))
        {
            if (!WW_isUndefinedOrNull(window.skelta.forms.utilities))
            {
                return window.skelta.forms.utilities.getClientCredentialToken();
            }
        }
    }

    if (WW_isWidgetRenderedInsideIframe(window) && !WW_isUndefinedOrNull(window.frameElement.SFU))
    {
        return window.frameElement.SFU.getClientCredentialToken();
    }

    return "";
}

function WW_defineSetterAndGetter(targetObj, propertyName, sourceObj, isObservable)
{
    Object.defineProperty(targetObj, propertyName, {
        get: function ()
        {
            if (isObservable)
            {
                return sourceObj[propertyName]();
            }
            else
            {
                return sourceObj[propertyName];
            }
        },
        set: function (v)
        {
            if (isObservable)
            {
                sourceObj[propertyName](v);
            }
            else
            {
                sourceObj[propertyName] = v;
            }
        },
        enumerable: true, configurable: true
    });
}

// This method initialized the cwidget object and sets the domElement to the cwidget object as well.
function WW_getNewCwidget(cwidget, myConf, targetTag)
{
    if (!WW_isUndefinedOrNull(window.cwidget))
    {
        return window.cwidget;
    }

    //debugger;

    if (WW_isUndefinedOrNull(window.lastSkeltaControl) && !WW_isUndefinedOrNull(window.cwidget_class))
    {
        console.log("init control in browser with WT proxy", myConf.divId);

        let newControl = {};

        if (WW_isUndefinedOrNull(myConf.noControlClass))
        {
            newControl = Object.create(control_class);
            newControl.constructor(myConf.divId);
        }

        var newCWidget = Object.create(window.cwidget_class);
        newCWidget.constructor(newControl);
        initSub(newCWidget, newControl);

        newControl.cwidget = newCWidget;

        myConf.confName = newCWidget.confName;
        myConf.widgetName = newCWidget.widgetName;
        myConf.loadData = 1;

        newCWidget.domElement = WW_getWidgetDomElement(newCWidget, myConf.divId.substr(1), targetTag);

        return newCWidget;
    }

    if (WW_isUndefinedOrNull(cwidget))
    {
        if (!WW_isUndefinedOrNull(window.lastSkeltaControl))
        {
            console.log("init control in WT ", window.lastSkeltaControl.id, myConf.divId);
            var control = {};
            control = window.lastSkeltaControl;
            var cwidgetObj = Object.create(window.cwidget_class);

            cwidgetObj.constructor(control);
            initSub(cwidgetObj, control);

            myConf.confName = cwidgetObj.confName;
            myConf.widgetName = cwidgetObj.widgetName;
            myConf.loadData = 1;

            cwidgetObj.domElement = WW_getWidgetDomElement(cwidgetObj, myConf.divId.substr(1), targetTag);

            cwidgetObj.subscriptionDetails.push(cwidgetObj.control.widgetDestroyEvent.subscribe(function (value)
            {
                if (cwidgetObj.uniqueId === value && !WW_isUndefinedOrNull(cwidgetObj.destroyWidget))
                {
                    cwidgetObj.destroyWidget();
                }
            }));

            return cwidgetObj;
        }

        console.log("init control without proxy(cwidget)", myConf.divId);
        cwidget = {};
        cwidget.control = {};
        cwidget.on = function (name, f) { };

        cwidget.dispatchEvent = function (name)
        {
            //alert("dispatch: " + name);
            this.on_arr[name]();
        };

        return cwidget;
    }
}

function WW_getMyConf(widgetObject, cwidget, myConf)
{
    if (!WW_isUndefinedOrNull(window.conf))
    {
        if (!WW_isUndefinedOrNull(window.conf[myConf.confName]))
        {
            return gridConf = window.conf[myConf.confName](myConf.confName, widgetObject, cwidget, myConf);
        }
    }

    return null;
}

function WW_isWorkTasksPro() {
    if (!WW_isUndefinedOrNull(window.skelta)) {
        if (!WW_isUndefinedOrNull(window.skelta.forms)) {
            if (!WW_isUndefinedOrNull(window.skelta.forms.utilities)) {
                return window.skelta.forms.utilities.isWorkTasksPro();
            }
        }
    }

    return false;
}

function WW_getIframeErrorMsg(widgetName) {
    if (!WW_isUndefinedOrNull(window.skelta)) {
        if (!WW_isUndefinedOrNull(window.skelta.forms)) {
            if (!WW_isUndefinedOrNull(window.skelta.forms.utilities)) {
                return window.skelta.forms.utilities.localizeWidgetErrorMessage('widget_Path_Loading_Error', widgetName);
            }
        }
    }

    return "";
}

function WW_includeWidgetFile(fileName) {
    var filesCached = window.top.formsCustomFilesDataFromAppCache;

    var file = fileName.substr("custom/".length);
    file = FormCustomPath + ":" + file;

    if (WW_isUndefinedOrNull(window.$)) {
        var customJqueryFile = filesCached.filter(function (eachItem) {
            return (eachItem.Name.toLowerCase() === "jquery.min.js".toLowerCase());
        });

        // jquery loading
        if (customJqueryFile && customJqueryFile.length > 0 &&
            customJqueryFile[0].Data) {
            var script = document.createElement("script");
            script.type = "text/javascript";
            script.innerText = customJqueryFile[0].Data;
            document.getElementsByTagName("head")[0].insertBefore(script, document.getElementsByTagName("head")[0].firstElementChild.nextSibling);
        }
    }

    var customFile = filesCached.filter(function (eachItem) {
        return (eachItem.Name.toLowerCase() === file.toLowerCase());
    });

    if (!WW_isUndefinedNullOrEmpty(customFile) &&
        customFile.length > 0 &&
        !WW_isUndefinedNullOrEmpty(customFile[0].Data)) {
        if (fileName.indexOf(".css") !== -1) {
            var cssLink = $("<style>");
            cssLink.text(customFile[0].Data);
            $("head").append(cssLink);
        }
        else {
            var jsLink = $("<script>");
            jsLink.text(customFile[0].Data);
            $("head").append(jsLink);
        }
    }
}

function WW_getTestData(confName, dataName)
{
    if (!WW_isUndefinedOrNull(window.conf))
    {
        if (!WW_isUndefinedOrNull(window.conf[confName + dataName]))
        {
            return window.conf[confName + dataName];
        }
    }

    return null;
}

function WW_getUniqueIdFromIframeBasedWidget(windowObj)
{
    return WW_getUrlParameterValue(windowObj, WW_IFRAME_PARAMETERNAME_UNIQUEID);
}

function WW_isWidgetRenderedInsideIframe(windowObj)
{
    return !WW_isUndefinedNullOrEmpty(WW_getUniqueIdFromIframeBasedWidget(windowObj));
}

function WW_isWidgetRenderedStandalone(windowObj)
{
    var path = windowObj.location.pathname.toLowerCase();

    return path.endsWith("/index.html") &&
        (WW_isUndefinedOrNull(windowObj.parent) || windowObj.parent === windowObj);
}

function WW_getWidgetDomElement(widgetObj, elementId, targetTag)
{
    if (!WW_isUndefinedOrNull(widgetObj.domElement))
    {
        return widgetObj.domElement;
    }

    if (WW_isUndefinedNullOrEmpty(targetTag))
    {
        targetTag = "div";
    }

    if (WW_isWidgetRenderedInsideIframe(window) || WW_isWidgetRenderedStandalone(window))
    {
        widgetObj.domElement = document.getElementById(elementId);

        return widgetObj.domElement;
    }
    else
    {
        if (!WW_isUndefinedNullOrEmpty(widgetObj.control.currentUniqueId) && WW_isUndefinedNullOrEmpty(widgetObj.uniqueId))
        {
            // currentUniqueId would change based on multiple instances of the widget initialization
            widgetObj.uniqueId = widgetObj.control.currentUniqueId;
        }

        window.cwidgets = window.cwidgets || {};

        if (WW_isUndefinedOrNull(window.cwidgets[widgetObj.uniqueId]))
        {
            window.cwidgets[widgetObj.uniqueId] = widgetObj;
        }

        var $widgetElement = $("div[" + WIDGET_INSTANCEID_ATTRIBUTE_NAME + "=" + widgetObj.uniqueId + "] > " + targetTag);
        widgetObj.domElement = $widgetElement.length > 0 ? $widgetElement[0] : null;

        return widgetObj.domElement
    }
}

control_class = {
    id: "iframecontrol",
    divId: "",
    m_cwidget: {},
    constructor: function (divId)
    {
        //debugger;
        this.initializeDynamicDetails();
        window.addEventListener('message', this.handleMessage, false);
        console.log("Add listener iframe control ", divId);
        this.divId = divId;
        let event = {};
        event.divId = this.divId;
        event.name = "Init";
        event.value = "Init";
        window.parent.postMessage(JSON.stringify(event), "*");
        console.log("post message from iframe to parent ", event, this.divId);
    },
    destroy: function ()
    {
        window.removeEventListener('message', this.handleMessage, false);
    },
    initializeDynamicDetails: function ()
    {
        if (!WW_isUndefinedOrNull(window.frameElement) && !WW_isUndefinedOrNull(window.frameElement.widgetProperties))
        {
            this.widgetName = window.frameElement.widgetName;
            this.initializeDynamicPropertyDetails();
            this.initializeDynamicScriptDetails();
        }
    },
    initializeDynamicPropertyDetails: function ()
    {
        var widgetPropertiesSource = window.frameElement.widgetProperties;

        this.widgetProperties = {};

        this.defineMemberProperty("value");
        this.defineMemberProperty("description");
        this.defineMemberProperty("confName");

        this.confName = window.frameElement.confName;

        for (var key in widgetPropertiesSource)
        {
            //if (WW_isUndefinedOrNull(cwidget.control[key]) && WW_isUndefinedOrNull(cwidget[key]))
            if (WW_isUndefinedOrNull(this[key]) && WW_isUndefinedOrNull(this["m_" + key]))
            {
                // Non observable members would not be functions
                if ((typeof widgetPropertiesSource[key]) !== "function")
                {
                    // Dummy initialization for reference
                    this.widgetProperties[key] = "";
                    this.defineMemberProperty(key);
                }
            }
        }
    },
    initializeDynamicScriptDetails: function ()
    {
        var widgetScriptsSource = window.frameElement.widgetScripts;

        this.widgetScripts = {};

        for (var key in widgetScriptsSource)
        {
            if (WW_isUndefinedOrNull(this[key]))
            {
                // Scripts would be functions
                if ((typeof widgetScriptsSource[key]) === "function")
                {
                    // Dummy initialization for reference
                    this.widgetScripts[key] = function () { };
                    this.defineMemberScript(key);
                }
            }
        }
    },
    defineMemberProperty: function (key)
    {
        this["m_" + key] = "";

        Object.defineProperty(this, key, {
            get: function ()
            {
                return this["m_" + key];
            },
            set: function (v)
            {
                this.setValue(key, v);
            },
            enumerable: true, configurable: true
        });
    },
    defineMemberScript: function (key)
    {
        this[key] = function (value, control)
        {
            this.setValue(key, value);
        };
    },
    setValue: function (name, value)
    {
        // This method is called to set the properties as well as for the scripts,
        // hence a check onto the same.
        if ((typeof this[name]) !== "function")
        {
            this["m_" + name] = value;
        }

        let event = {};
        event.divId = this.divId;
        event.name = name;
        event.value = value;

        // To avoid race conditions on the postMessage calls, we have added a setTimeout.
        // Assume that 3 postMessages are set to the window, the order of execution of those postMessages might vary.
        // Hence we add a setTimeout, so that the the order of execution of the postMessage calls happen in those windows.
        setTimeout(function ()
        {
            window.parent.postMessage(JSON.stringify(event), "*");
            console.log("post message from iframe to parent ", event, this.divId);
        }, 0);
    },
    set cwidget(value)
    {
        if (WW_isUndefinedOrNull(window.cwidget))
        {
            window.cwidget = {};
            window.cwidget = value;
        }

        this.m_cwidget = value;
    },
    onControlChange: function (control, value, oldValue) { },
    handleMessage: function (event)
    {
        //debugger;
        console.log("iframe receive message from parent ", event, this.divId);

        let msg = "";

        try
        {
            // The message might have originated for some other window, hence check whether we are able to parse it.
            msg = JSON.parse(event.data);
        }
        catch (e)
        {
            msg = "";
        }

        // The message might have originated for some other window, hence check whether the proper format is present.
        if (!WW_isObject(msg))
        {
            return;
        }

        if (!WW_isUndefinedOrNull(window.cwidget))
        {
            if (!WW_isUndefinedOrNull(window.cwidget.control["m_" + msg.name]))
            {
                window.cwidget.control["m_" + msg.name] = msg.value;
                window.cwidget.manageOnEvent(msg.name);
            }
        }
    },
    manageOnEvent: function (newValue)
    {
        if (!WW_isUndefinedNullOrEmpty(newValue))
        {
            if (!WW_isUndefinedOrNull(this.on_arr[newValue]))
            {
                this.raiseOn(newValue);
            }
        }
    },
    raiseOn: function (prop)
    {
        if (!WW_isUndefinedOrNull(this.on_arr[prop]))
        {
            this.on_arr[prop]();
        }
    }
};
