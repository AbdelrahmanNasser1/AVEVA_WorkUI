/*!
// ------------------------------------------------------------------------------------------------------------
// <copyright file="iFrameClient.js" company="Aveva">
// Copyright © 2021 AVEVA Group Plc. All rights reserved
// THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY
// KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
// PARTICULAR PURPOSE.
// </copyright>
// ------------------------------------------------------------------------------------------------------------
*/

/** iframeclient support library 
*	ver: 0.92
*	Author: Thommy Djupenström 
*	Ver		Date		By	Comment
*	0.9		1-Mar-21	TD	Initial version
*	
*	0.92	16-Apr-21	TD	Moved folder structure to js/Custom
**/

var WW_IFRAME_PARAMETERNAME_FORMUNIQUEID = "skuniqueidforform";
var iframeclient_myControl = {};
var ifc_msgHandler = {};

if (window.WW_isUndefinedOrNull === undefined)
{
    // Checks whether the obj is undefined or null.
    window.WW_isUndefinedOrNull = function (obj)
    {
        return (obj === undefined || obj === null);
    };

    // Checks whether the obj is undefined, null or empty string.
    window.WW_isUndefinedNullOrEmpty = function (obj)
    {
        return (WW_isUndefinedOrNull(obj) || obj === "");
    };

    // Gets the parameter value from the url
    window.WW_getUrlParameterValue = function (windowObject, parameterName)
    {
        var match = RegExp('[?&]' + parameterName + '=([^&]*)').exec(windowObject.location.search);
        return match && decodeURIComponent(match[1].replace(/\+/g, ' '));
    };
}

var ifc_formUniqueId = WW_getUrlParameterValue(window, WW_IFRAME_PARAMETERNAME_FORMUNIQUEID);

function initIframeCom(control)
{
    window.addEventListener('message', handleMessage, false);
    iframeclient_myControl = control;

    let event = {};
    event.name = "Init";
    event.value = "Init";
    event[WW_IFRAME_PARAMETERNAME_FORMUNIQUEID] = ifc_formUniqueId;
    window.parent.postMessage(JSON.stringify(event), "*");
}

function ifc_send(name, value)
{
    let event = {};
    event.name = name;
    event.value = value;
    event[WW_IFRAME_PARAMETERNAME_FORMUNIQUEID] = ifc_formUniqueId;
    window.parent.postMessage(JSON.stringify(event), "*");
}

function ifc_getFormParam(name)
{
    if (!WW_isUndefinedOrNull(iframeclient_myControl.topLevelForm.formParameters[name]))
    {
        return iframeclient_myControl.topLevelForm.formParameters[name].value;
    }

    return ifc_getParam(name);
}

function ifc_getParam(parameterName)
{
    return WW_getUrlParameterValue(window, parameterName);
}

function handleMessage(event)
{
    let msg = JSON.parse(event.data);
    if (!WW_isUndefinedOrNull(ifc_msgHandler[msg.name]))
    {
        ifc_msgHandler[msg.name](msg.value);
    }
    else
    {
        if (!WW_isUndefinedOrNull(iframeclient_myControl.findByXmlNode("unmanaged")))
        {
            iframeclient_myControl.findByXmlNode("unmanaged").value = msg.value;
        }
    }
}
