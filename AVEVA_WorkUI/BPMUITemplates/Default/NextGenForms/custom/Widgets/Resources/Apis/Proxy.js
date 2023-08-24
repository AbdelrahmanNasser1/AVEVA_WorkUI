/*!
// ------------------------------------------------------------------------------------------------------------
// <copyright file="Proxy.js" company="Aveva">
// Copyright © 2021 AVEVA Group Plc. All rights reserved
// THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY
// KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
// PARTICULAR PURPOSE.
// </copyright>
// ------------------------------------------------------------------------------------------------------------
*/

/** Proxy support library
*	ver: 0.92
*	Author: Thommy Djupenström 
*	Ver		Date		By	Comment
*	0.9		1-Mar-21	TD	Initial version
*	
*	0.92	16-Apr-21	TD	Moved folder structure to js/Custom
**/
(function ()
{
    var cwidget_class = {
        subscriptionDetails: [], // To keep track of subscriptions
        on_arr: [],
        control: {},
        myObject: {},
        onSub: {},
        wWScriptValue: [],
        widgetName: "./",
        divId: "",
        _onLoadListeners: [],//For Ind graphics compability
        constructor: function (ctrl)
        {
            this.subscriptionDetails = [];
            this.on_arr = [];
            this.wWScriptValue = [];
            this._onLoadListeners = [];

            this.control = ctrl;

            if (!WW_isUndefinedOrNull(this.control.widgetName))
            {
                this.widgetName = "./custom/Widgets/" + this.control.widgetName;
                this.confName = this.control.confName;
            }
        },
        destroy: function ()
        {
            while (this.subscriptionDetails.length > 0)
            {
                var subscriptionObject = this.subscriptionDetails.pop();
                subscriptionObject.dispose();
            }

            delete this.subscriptionDetails;
            delete this.domElement;

            // This would be applicable only when the widget type is iframe
            if (!WW_isUndefinedOrNull(this.childDoc))
            {
                delete this.childDoc;
            }

            // this would be applicable only when the widget type is not inline and the execution context would be inside the iframe control
            if (!WW_isUndefinedOrNull(this.control.destroy))
            {
                this.control.destroy();
            }

            if (!WW_isUndefinedOrNull(this.control))
            {
                delete this.control;
            }

            if (!WW_isUndefinedOrNull(this.widgetName))
            {
                delete this.widgetName;
            }

            if (!WW_isUndefinedOrNull(this.confName))
            {
                delete this.confName;
            }

            this.on_arr = [];
            delete this.on_arr;

            this.wWScriptValue = [];
            delete this.wWScriptValue;

            this._onLoadListeners = [];
            delete this._onLoadListeners;

            delete this.myObject;
            delete this.onSub;
            delete this.divId;

            delete this.constructor;
            delete this.destroy;
            delete this.addOnLoad;
            delete this.dispatchEvent;
            delete this.on;
            delete this.manageOnEvent;
            delete this.raiseOn;

            if (!WW_isUndefinedOrNull(window.cwidgets))
            {
                delete window.cwidgets[this.uniqueId];
            }

            delete this.uniqueId;
        },
        addOnLoad: function e(t, n)
        { //For Ind graphics compability
            this._onLoadListeners.push(t.bind(n))
        },

        dispatchEvent: function (prop)
        {
            if (prop.startsWith("wWScript"))
            {
                if (!WW_isUndefinedOrNull(this.control[prop]))
                {
                    let eventValue = prop;

                    if (!WW_isUndefinedOrNull(this.wWScriptValue[prop]))
                    {
                        eventValue = this.wWScriptValue[prop];
                    }

                    this.control[prop](eventValue, this.control);

                    if (!WW_isUndefinedOrNull(this.wWScriptValue[prop]))
                    {
                        this.wWScriptValue[prop] = "";
                    }
                }
                else if (!WW_isUndefinedOrNull(this.control.onEvent))
                {
                    this.control.onEvent(prop, this.control);
                }
            }
        },
        on: function (prop, func)
        {
            this.on_arr[prop] = func;
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
        },
    };

    if (WW_isUndefinedOrNull(window.onerror))
    {
        window.onerror = function (message, file, line, column)
        {
            var logDetails = {};

            logDetails.Message = "Message: " + message;
            logDetails.Line = "Line: " + line;
            logDetails.Column = "Column: " + column;
            logDetails.File = "File: " + file;
            console.log(logDetails.Message + "\n" + logDetails.Line + "\n" + logDetails.Column + "\n" + logDetails.File);
        };
    }

    if (WW_isUndefinedOrNull(window.cwidget_class))
    {
        console.log("Before_ window.cwidget_class=cwidget_class");

        window.cwidget_class = cwidget_class;

        console.log("After window.cwidget_class=cwidget_class");
    }

    // Below code is used by other Aveva product implementations, hence this should not be modified/removed.
    if (WW_isUndefinedOrNull(window.SmaCustomWidget))
    {
        window.SmaCustomWidget = {}
        window.SmaCustomWidget.proxy = cwidget_class;
    }

    function defineScriptSetter(targetObj, propertyName, sourceObj, controlObj)
    {
        Object.defineProperty(targetObj, propertyName, {
            set: function (v)
            {
                if (!WW_isUndefinedOrNull(sourceObj[propertyName]))
                {
                    sourceObj[propertyName](v, controlObj);
                }
            },
            enumerable: true, configurable: true
        });
    }

    if (WW_isUndefinedOrNull(window.initSub))
    {
        window.initSub = function (cwidget, control)
        {
            if (!WW_isUndefinedOrNull(control))
            {
                var keysToBeConfigured = [];
                var isWidgetRenderedInsideIframe = WW_isWidgetRenderedInsideIframe(window);

                //debugger;
                WW_defineSetterAndGetter(cwidget, "value", control, false);
                WW_defineSetterAndGetter(cwidget, "description", control, false);
                WW_defineSetterAndGetter(cwidget, "visible", control, false);
                WW_defineSetterAndGetter(cwidget, "enable", control, false);
                WW_defineSetterAndGetter(cwidget, "confName", control, false);

                // Setup Properties Getters and Setters
                var defineGetterSetterSourceObj = isWidgetRenderedInsideIframe ? control : control.widgetProperties;

                for (var key in control.widgetProperties)
                {
                    if ((isWidgetRenderedInsideIframe || WW_isUndefinedOrNull(control[key])) && WW_isUndefinedOrNull(cwidget[key]))
                    {
                        // Non observable members would not be functions
                        if ((typeof control.widgetProperties[key]) !== "function")
                        {
                            // Make note of keys
                            keysToBeConfigured.push(key);

                            WW_defineSetterAndGetter(cwidget, key, defineGetterSetterSourceObj, false);
                        }
                    }
                }

                // Setup Scripts Setters
                var defineScriptSetterSourceObj = isWidgetRenderedInsideIframe ? control : control.widgetScripts;

                for (var scriptKey in control.widgetScripts)
                {
                    if ((isWidgetRenderedInsideIframe || WW_isUndefinedOrNull(control[scriptKey])) && WW_isUndefinedOrNull(cwidget[scriptKey]))
                    {
                        // Scripts would be functions
                        if ((typeof control.widgetScripts[scriptKey]) === "function")
                        {
                            defineScriptSetter(cwidget, scriptKey, defineScriptSetterSourceObj, control);
                        }
                    }
                }

                if (!isWidgetRenderedInsideIframe)
                {
                    // We should not have notify always for value and description property
                    cwidget.subscriptionDetails.push(control._value.subscribe(function (newValue) { cwidget.manageOnEvent("value"); }));
                    cwidget.subscriptionDetails.push(control._description.subscribe(function (newValue) { cwidget.manageOnEvent("description"); }));

                    cwidget.subscriptionDetails.push(control._confName.subscribe(function (newValue) { cwidget.manageOnEvent("confName"); }));
                    control._confName.extend({ notify: 'always' });
                    cwidget.subscriptionDetails.push(control._widgetName.subscribe(function (newValue) { cwidget.widgetName = newValue; cwidget.manageOnEvent("widgetName"); }));
                    control._widgetName.extend({ notify: 'always' });

                    for (var index in keysToBeConfigured)
                    {
                        var keyItem = keysToBeConfigured[index];
                        subscribeProperty(cwidget, control, keyItem);
                    }
                }
            }
        };
    }

    // To maintain the context have moved the subscription of dynamic properties in a separate method.
    function subscribeProperty(cwidget, control, key)
    {
        // key value's context had to be maintained in the function inside subscribe call.
        cwidget.subscriptionDetails.push(control.widgetProperties["_" + key].subscribe(function (newValue) { cwidget.manageOnEvent(key); }));
        control.widgetProperties["_" + key].extend({ notify: 'always' });
    }
})();
