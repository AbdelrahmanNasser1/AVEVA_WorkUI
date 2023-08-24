/*!
// ------------------------------------------------------------------------------------------------------------
// <copyright file="iframeProxy.js" company="Aveva">
// Copyright © 2021 AVEVA Group Plc. All rights reserved
// THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY
// KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
// PARTICULAR PURPOSE.
// </copyright>
// ------------------------------------------------------------------------------------------------------------
*/

/** iframe proxy support library 
*	ver: 0.92
*	Author: Thommy Djupenström 
*	Ver		Date		By	Comment
*	0.9		1-Mar-21	TD	Initial version
*	0.91	12-Apr-21	TD	Added support for scrip and onSave events from iframeclient
*	0.92	16-Apr-21	TD	Moved folder structure to js/Custom
* 	0.93	14-May-21	TD	Added value as parameter
**/
(function ()
{
    if (WW_isUndefinedOrNull(window.IFP_addEventHandler))
    {
        window.IFP_addEventHandler = function (cwidget)
        {
            window.IFP_handlerAdded = true;
            window.addEventListener('message', IFP_handleMessage, false);

            console.log("Add listener parent ", window);
        };

        window.IFP_handleMessage = function (event)
        {
            if (!WW_isUndefinedOrNull(event) && !WW_isUndefinedNullOrEmpty(event.data))
            {
                let windowObj = event.source;

                if (!WW_isUndefinedOrNull(windowObj))
                {
                    let uniqueId = "";
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

                    if (WW_isWidgetRenderedInsideIframe(windowObj))
                    {
                        uniqueId = WW_getUniqueIdFromIframeBasedWidget(windowObj);
                    }
                    else if (!WW_isUndefinedNullOrEmpty(msg[WW_IFRAME_PARAMETERNAME_FORMUNIQUEID]))
                    {
                        uniqueId = msg[WW_IFRAME_PARAMETERNAME_FORMUNIQUEID];
                    }

                    if (!WW_isUndefinedOrNull(uniqueId))
                    {
                        if (!WW_isUndefinedOrNull(window.cwidgets))
                        {
                            if (!WW_isUndefinedOrNull(window.cwidgets[uniqueId]))
                            {
                                let _cwidget = window.cwidgets[uniqueId];
                                _cwidget.childDoc = windowObj;

                                //debugger;

                                if (!WW_isUndefinedOrNull(_cwidget.control.widgetScripts[msg.name]))
                                {
                                    _cwidget[msg.name] = msg.value;
                                }
                                else if (!WW_isUndefinedOrNull(_cwidget[msg.name]))
                                {
                                    _cwidget[msg.name] = msg.value;
                                }
                                else if (msg.name === "Init")
                                {
                                    // populate data if any
                                    mdm.iFrame.post("value", _cwidget);
                                    mdm.iFrame.post("description", _cwidget);
                                    mdm.iFrame.post("confName", _cwidget);

                                    for (var key in _cwidget.control.widgetProperties)
                                    {
                                        // Non observable members would not be functions
                                        if ((typeof _cwidget.control.widgetProperties[key]) !== "function")
                                        {
                                            mdm.iFrame.post(key, _cwidget);
                                        }
                                    }
                                }
                            }
                        }

                        console.log("parent receive message from iframe ", event);
                    }
                }
                else
                {
                    console.log("Not real receive2 ", event);
                }
            }
            else
            {
                console.log("Not real receive3 ", event);
            }
        };
    }

    // Set manual configuration
    var myConf = {};
    myConf.widgetName = "./";
    myConf.confName = "LineChart1";
    myConf.divId = "#iframe";
    myConf.noControlClass = 1;

    //debugger;

    var cwidget = WW_getNewCwidget(cwidget, myConf, "iframe");

    var mdm = mdm || {};
    mdm.iFrame = mdm.iFrame || {};

    /**
    * Save the domElement
    */
    //mdm.iFrame.domElement = document.querySelector(myConf.divId);

    mdm.iFrame.domElement = cwidget.domElement;

    if (!WW_isUndefinedOrNull(cwidget.control) && !WW_isUndefinedOrNull(cwidget.control.widgetProperties) && cwidget.control.widgetType === 1)
    {
        mdm.iFrame.domElement.widgetName = cwidget.control.widgetName;
        // confName is required for initialization purpose initially only
        mdm.iFrame.domElement.confName = cwidget.control.confName;
        mdm.iFrame.domElement.widgetProperties = cwidget.control.widgetProperties;
        mdm.iFrame.domElement.widgetScripts = cwidget.control.widgetScripts;

        if (!WW_isUndefinedOrNull(window.skelta))
        {
            if (!WW_isUndefinedOrNull(window.skelta.localize))
            {
                if (!WW_isUndefinedOrNull(window.skelta.localize.getString))
                {
                    mdm.iFrame.domElement.localize = window.skelta.localize;
                }
            }

            if (!WW_isUndefinedOrNull(window.skelta.forms))
            {
                if (!WW_isUndefinedOrNull(window.skelta.forms.utilities))
                {
                    mdm.iFrame.domElement.SFU = window.skelta.forms.utilities;
                }
            }
        }
    }

    cwidget.destroyWidget = function ()
    {
        // This would take care of clearing internal subscriptions and events.
        cwidget.destroy();

        // destroy other events and subscriptions if any
        mdm.iFrame.destroyWidget();
    };

    mdm.iFrame.destroyWidget = function ()
    {
        var frame = mdm.iFrame.domElement;

        if (frame)
        {
            delete frame.widgetName
            delete frame.confName;
            delete frame.widgetProperties;
            delete frame.widgetScripts;

            if (!WW_isUndefinedOrNull(frame.localize))
            {
                delete frame.localize;
            }

            if (!WW_isUndefinedOrNull(frame.SFU))
            {
                delete frame.SFU;
            }
        }

        delete mdm.iFrame.domElement;
    };

    /**
     * Initialization function for custom kendoGrid and SkeltaGrid
     */
    mdm.iFrame.init = function ()
    {
        let blockSetSource = true;
        let src_str = "";

        var definePropertiesAndEvents = function ()
        {
            // if not Widget Type as 3 - Url using iframe
            if (cwidget.control.widgetType !== 3)
            {
                if (WW_isUndefinedOrNull(window.IFP_handlerAdded))
                {
                    IFP_addEventHandler(cwidget);
                }

                defineOnEventForProperty(cwidget, mdm.iFrame, "value");
                defineOnEventForProperty(cwidget, mdm.iFrame, "description");
                defineOnEventForProperty(cwidget, mdm.iFrame, "confName");

                //debugger;

                for (var key in cwidget.control.widgetProperties)
                {
                    if (WW_isUndefinedOrNull(cwidget.control[key]))
                    {
                        // Non observable members would not be functions
                        if ((typeof cwidget.control.widgetProperties[key]) !== "function")
                        {
                            defineOnEventForProperty(cwidget, mdm.iFrame, key);
                        }
                    }
                }
            }
        };

        switch (cwidget.control.widgetType)
        {
            // 1 Local widget using iframe
            case 1:
                if (cwidget.control.widgetName !== "")
                {
                    //debugger;
                    if (!WW_isWorkTasksPro())
                    {
                        var iframeHtmlContent = cwidget.control.widgetContentForIframeInMobile.trim().replace(/\n/g, "").replace(/\r/g, "");
                        blockSetSource = false;
                        if (WW_isUndefinedNullOrEmpty(iframeHtmlContent))
                        {
                            mdm.iFrame.domElement.onload = function ()
                            {
                                var iframedoc = mdm.iFrame.domElement;
                                if (iframedoc.contentDocument)
                                {
                                    iframedoc = iframedoc.contentDocument;
                                }
                                else if (iframedoc.contentWindow)
                                {
                                    iframedoc = iframedoc.contentWindow.document;
                                }

                                if (iframedoc)
                                {
                                    var cssfile = "",
                                        nonThemeCssFile = "";

                                    if (skeltaUtils.isUndefinedNullOrEmpty(window.skelta.DeviceOS))
                                    {
                                        window.skelta.DeviceOS = "Web";
                                    }

                                    if (window.skelta.DeviceOS.indexOf("Preview") > -1 || WW_isWorkTasksPro())
                                    {
                                        cssfile = "css/Android.min.css";
                                    }
                                    else
                                    {
                                        var themePath = skelta.userContext.getUserContextFor("themePath");
                                        var themeFolderIndex = themePath.toLowerCase().indexOf("/themes/");

                                        if (themeFolderIndex > -1)
                                        {
                                            nonThemeCssFile = themePath.substr(0, themeFolderIndex + 1) + "NextGenForms/css/SkeltaForms.min.css";
                                        }

                                        cssfile = themePath + "NextGenForms/css/SkeltaForms.min.css";
                                    }

                                    var content = cwidget.control.widgetRawContentForIframeInMobile;
                                    if (!WW_isUndefinedNullOrEmpty(content))
                                    {
                                        content = skeltaUtils.isUndefinedNullOrEmpty(nonThemeCssFile) ? content.replace("@MobilecssTag@", cssfile) : content.replace("@MobilecssTag@", nonThemeCssFile);
                                        content = content.replace("@errorMsg@", WW_getIframeErrorMsg(cwidget.control.widgetName));
                                    }
                                    else
                                    {
                                        content = "";
                                    }

                                    $(iframedoc.body).html(content);
                                }
                            }
                        }
                        else
                        {
                            src_str = myConf.widgetName + "/index.html?" +
                                WW_IFRAME_PARAMETERNAME_UNIQUEID + "=" + encodeURIComponent(cwidget.uniqueId) +
                                "&Name=" + encodeURIComponent(myConf.divId.substring(1)) +
                                "&time=" + encodeURIComponent(Date.now().toString());
                        }
                    }
                    else
                    {
                        var iframeHtmlContent = cwidget.control.widgetContentForIframeInMobile.replace(/\n/g, "").replace(/\r/g, "");
                        blockSetSource = false;
                        mdm.iFrame.domElement.onload = function ()
                        {
                            var iframedoc = mdm.iFrame.domElement;
                            if (iframedoc.contentDocument)
                            {
                                iframedoc = iframedoc.contentDocument;
                            }
                            else if (iframedoc.contentWindow)
                            {
                                iframedoc = iframedoc.contentWindow.document;
                            }

                            if (!WW_isUndefinedNullOrEmpty(iframeHtmlContent))
                            {
                                if (iframedoc)
                                {
                                    $(iframedoc.body).html(cwidget.control.widgetContentForIframeInMobile);
                                }
                            }
                            else {
                                if (iframedoc)
                                {
                                    var cssfile = "",
                                        nonThemeCssFile = "";

                                    if (skeltaUtils.isUndefinedNullOrEmpty(window.skelta.DeviceOS))
                                    {
                                        window.skelta.DeviceOS = "Web";
                                    }

                                    if (window.skelta.DeviceOS.indexOf("Preview") > -1 || WW_isWorkTasksPro())
                                    {
                                        cssfile = "css/Android.min.css";
                                    }
                                    else
                                    {
                                        var themePath = skelta.userContext.getUserContextFor("themePath");
                                        var themeFolderIndex = themePath.toLowerCase().indexOf("/themes/");

                                        if (themeFolderIndex > -1)
                                        {
                                            nonThemeCssFile = themePath.substr(0, themeFolderIndex + 1) + "NextGenForms/css/SkeltaForms.min.css";
                                        }

                                        cssfile = themePath + "NextGenForms/css/SkeltaForms.min.css";
                                    }

                                    var content = cwidget.control.widgetRawContentForIframeInMobile;
                                    if (!WW_isUndefinedNullOrEmpty(content))
                                    {
                                        content = skeltaUtils.isUndefinedNullOrEmpty(nonThemeCssFile) ? content.replace("@MobilecssTag@", cssfile) : content.replace("@MobilecssTag@", nonThemeCssFile);
                                        content = content.replace("@errorMsg@", WW_getIframeErrorMsg(cwidget.control.widgetName));
                                    }
                                    else
                                    {
                                        content = "";
                                    }

                                    $(iframedoc.body).html(content);
                                }
                            }
                        };

                        if (!WW_isUndefinedNullOrEmpty(iframeHtmlContent))
                        {
                            src_str = "../wm_2019/WidgetIframeContent.htm?" +
                                WW_IFRAME_PARAMETERNAME_UNIQUEID + "=" + encodeURIComponent(cwidget.uniqueId) +
                                "&Name=" + encodeURIComponent(myConf.divId.substring(1)) +
                                "&time=" + encodeURIComponent(Date.now().toString());
                            blockSetSource = false;
                        }
                    }
                }

                break;

            // 2 WT Form using iframe
            case 2:
                if (cwidget.control.widgetFormSource !== "")
                {
                    var widgetFormParts = cwidget.control.widgetFormSource.split("~");
                    var formName = widgetFormParts[0];
                    var formVersion = "";

                    if (widgetFormParts.length > 1)
                    {
                        formVersion = widgetFormParts[1];

                        if (formVersion === "0")
                        {
                            formVersion = "";
                        }
                    }

                    var setFormUrl = function (formUrl)
                    {
                        // It might happen that the iFrame is no longer valid.
                        if (WW_isUndefinedOrNull(mdm.iFrame.domElement))
                        {
                            return;
                        }

                        if (!WW_isUndefinedNullOrEmpty(formUrl))
                        {
                            src_str = formUrl + "&" + WW_IFRAME_PARAMETERNAME_FORMUNIQUEID + "=" + encodeURIComponent(cwidget.uniqueId);

                            if (cwidget.control.addValueAsParam)
                            {
                                var widgetPropertiesSource = cwidget.control.widgetProperties;

                                for (var key in widgetPropertiesSource)
                                {
                                    // Non observable members would not be functions
                                    if ((typeof widgetPropertiesSource[key]) !== "function")
                                    {
                                        src_str += "&" + key + "=" + encodeURIComponent(widgetPropertiesSource[key]);
                                    }
                                }
                            }
                        }
                        else
                        {
                            src_str = "";
                        }

                        mdm.iFrame.domElement.src = src_str;

                        if (src_str === "")
                        {
                            SFU.injectFormNotAvailableContentToWidgetIframe(mdm.iFrame.domElement, "", true);

                            skelta.logger.logError(skelta.localize.getString("WidgetFormNotAvailableErrorForLogs")
                                .replaceString("<@formname@>", formName)
                                .replaceString("<@controlid@>", cwidget.control.id)
                                .replaceString("<@form@>", skelta.userContext.getUserContextFor("fName")));
                        }

                        definePropertiesAndEvents();
                    };

                    if (!WW_isUndefinedOrNull(SFU.getWidgetFormUrl))
                    {
                        SFU.getWidgetFormUrl(cwidget.control, formName, formVersion,
                            function (formUrl)
                            {
                                setFormUrl(formUrl);
                            });
                    }
                    else
                    {
                        var formUrl = SFU.getFormUrl(formName, formVersion);
                        setFormUrl(formUrl);
                    }

                    cwidget.on("widgetFormSource", function ()
                    {
                        var widgetFormParts = cwidget.control.widgetFormSource.split("~");
                        var formName = widgetFormParts[0];
                        var formVersion = "";
                        var src_str = "";

                        if (widgetFormParts.length > 1)
                        {
                            formVersion = widgetFormParts[1];

                            if (formVersion === "0")
                            {
                                formVersion = "";
                            }
                        }

                        if (!WW_isUndefinedOrNull(SFU.getWidgetFormUrl))
                        {
                            SFU.getWidgetFormUrl(cwidget.control, formName, formVersion,
                                function (formUrl)
                                {
                                    setFormUrl(formUrl);
                                });
                        }
                        else
                        {
                            var formUrl = SFU.getFormUrl(formName, formVersion);
                            setFormUrl(formUrl);
                        }
                    });

                    blockSetSource = true;
                }

                break;

            // 3 Url using iframe
            case 3:
                src_str = cwidget.control.widgetName;

                cwidget.on("widgetName", function ()
                {
                    src_str = cwidget.control.widgetName;

                    mdm.iFrame.domElement.src = src_str;
                });

                if (cwidget.control.widgetName !== "")
                {
                    blockSetSource = false;
                }

                break;
        }

        if (!blockSetSource)
        {
            mdm.iFrame.domElement.src = src_str;

            definePropertiesAndEvents();
        }
    };

    // To maintain the context have moved the On event of dynamic properties in a separate method.
    function defineOnEventForProperty(cwidget, mdmIFrame, key)
    {
        // key value's context had to be maintained in the function inside On event call.
        cwidget.on(key, function () { mdmIFrame.post(key, cwidget); });
    }

    mdm.iFrame.post = function (name, cwidget)
    {
        let newEvent = {}
        newEvent.name = name;
        newEvent.value = cwidget[name];

        if (!WW_isUndefinedOrNull(cwidget.childDoc))
        {
            // To avoid race conditions on the postMessage calls, we have added a setTimeout.
            // Assume that 3 postMessages are set to the window, the order of execution of those postMessages might vary.
            // Hence we add a setTimeout, so that the the order of execution of the postMessage calls happen in those windows.
            setTimeout(function ()
            {
                cwidget.childDoc.postMessage(JSON.stringify(newEvent), "*");
            }, 0);
        }
    };

    $(document).ready(mdm.iFrame.init);
})();
