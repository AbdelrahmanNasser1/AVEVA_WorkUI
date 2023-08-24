//--------------------------------------------------------------------------------------------------------
// <copyright file="FormLink.js" company="Invensys Skelta">
// Copyright (C) 2015 Invensys Systems, Inc.  All rights reserved.
// </copyright>
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files ( the "software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit personsto whom the Software is furnished to do so, subject to the following conditions:
//* The above copyright notice and this permission notice shall be included in all copies or substancial portions of the Software.
//* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS OF A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//---------------------------------------------------------------------------------------------------------
/**********************************************************************************************************
* Unit Name    : Form Link
* Created By   : Goutham Ganesh V
* Purpose      : Utility methods for form link parameters
**********************************************************************************************************
*/

var FormLink = (function ()
{
    var formLinkInstance;
    var createFormLink = function ()
    {
        var sessionStorageKey = "FormLinkData";
        var showFormParameter = false;
        var readSessionStorage = function ()
        {
            var formLinkData = sessionStorage.getItem(sessionStorageKey);
            if (formLinkData !== null)
            {
                var parameters = JSON.parse(formLinkData);//added below condition to handle-when there is only one parameter the xml to json conversion does not convert it as array
                return (!Array.isArray(parameters.FP) && typeof parameters.FP === "object") ? { FP: [parameters.FP] } : parameters;
            }
        };

        var writeSessionStorage = function (data)
        {
            sessionStorage.setItem(sessionStorageKey, JSON.stringify(data));
        };

        var deleteSessionStorage = function ()
        {
            sessionStorage.removeItem(sessionStorageKey);
        };

        var setVisibilityForFormParameters = function (show)
        {
            if (show === true)
            {
                $('#formParametersContainer').parent().parent().css("display", "table-row");
                $('#formParametersContainer').find("iframe").attr('src', 'FormParametersTemplate.html');
            } else
            {
                $('#formParametersContainer').parent().parent().css("display", "none");
                $('#formParametersContainer').find("iframe").removeAttr('src');
            }
        };

        var loadFormParameter = function (data)
        {
            writeSessionStorage(data);
            var formLinkData = readSessionStorage();
            setVisibilityForFormParameters(formLinkData.FP && formLinkData.FP.length > 0);
        };

        var updateHiddenField = function ()
        {
            var knockOut = $('#formParametersFrame')[0].contentWindow.ko;
            var viewModel = $('#formParametersFrame')[0].contentWindow.vm;
            var jsonString = knockOut.toJSON(viewModel.formParameters);
            var formParameters = JSON.parse(jsonString);
            var formParametersXml = getFormParameterXmlForHiddenField(formParameters);
            $('#formParametersField').val(formParametersXml);
        };

        var getFormParametersFromHiddenField = function ()
        {
            var formParametersXml = $('#formParametersField').val();
            var formParameters = skeltaUtils.getJSONObjectFromXml(formParametersXml);
            var formLinkData = { FP: formParameters.FormParameters.Parameter };
            writeSessionStorage(formLinkData);
        };

        var getFormParameters = function ()
        {
            var formParameters;
            var params = skeltaUtils.createJsonRequestHelper({
                "f": form,
                "app": app
            });

            skeltaUtils.callServerMethod("GET", "../../NextGenForms/NextGenFormService.aspx/GetFormParametersForFormLink", "application/json; charset=utf-8", params, "json",
                function (data)
                {
                    if (data.d)
                    {
                        var result = JSON.parse(data.d);
                        formParameters = result.FP;
                    }
                }, null, null, false);
            return formParameters;
        };

        var getFormParameterXmlForHiddenField = function (formParameters)
        {
            return formParameters ? skeltaUtils.getXmlFromJSONObject({ FormParameters: { Parameter: formParameters } }) : formParameters;
        };

        var reloadFormParameter = function ()
        {
            var newFormParameters = getFormParameters();
            var formLinkData = readSessionStorage();
            var oldFormParameters = formLinkData && formLinkData.FP ? formLinkData.FP : undefined;
            var updateFormParameters = [];
            $('#formParametersField').val("");
            setVisibilityForFormParameters(false);
            if (newFormParameters && newFormParameters.length > 0 && oldFormParameters && oldFormParameters.length > 0)//form parameters is been modified
            {
                $.each(newFormParameters, function (index, newformParameter)
                {
                    var updateFormParameter = newformParameter;
                    $.each(oldFormParameters, function (index, oldformParameter)
                    {
                        if (newformParameter.Name === oldformParameter.Name && newformParameter.Type === oldformParameter.Type)
                        {
                            updateFormParameter.Value = oldformParameter.Value;
                        }
                    });
                    updateFormParameters.push(updateFormParameter);
                });
                loadFormParameter({ FP: updateFormParameters });
                var formParametersXml = getFormParameterXmlForHiddenField(updateFormParameters);
                $('#formParametersField').val(formParametersXml);
            }
            else if (oldFormParameters && (!newFormParameters || newFormParameters.length === 0)) //form parameters is there but now it is not there
            {
                deleteSessionStorage();
            }
            else if ((!oldFormParameters || oldFormParameters.length === 0) && newFormParameters)//form parameters was not there but now it is there
            {
                loadFormParameter({ FP: newFormParameters });
            }
        };

        var getLocaleType = function (type)
        {
            var localeParameterType = window.localeParameterType;
            return localeParameterType[type];
        };

        return {
            getFormLinkData: readSessionStorage,
            setFormLinkData: writeSessionStorage,
            loadFormParameters: loadFormParameter,
            showFormParameters: setVisibilityForFormParameters,
            updateFormParametersValue: updateHiddenField,
            removeFormLinkData: deleteSessionStorage,
            updateFormLinkData: getFormParametersFromHiddenField,
            getLocalizedString: getLocaleType,
            reloadFormParameter: reloadFormParameter
        };
    };

    return {
        getInstance: function ()
        {
            if (!formLinkInstance)
            {
                formLinkInstance = createFormLink();
            }
            return formLinkInstance;
        }
    };
})();