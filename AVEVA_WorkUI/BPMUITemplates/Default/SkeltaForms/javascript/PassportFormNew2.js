/// <reference path="knockout-2.1.js" />
/// <reference path="SkeltaCore.js" />
/// <reference path="Skelta.Utilities.js" />
/// <reference path="Skelta.Forms.Utilities.js" />
/// <reference path="SkeltaFormsKO.js" />
/// <reference path="Skelta.Forms.Controls.js" />
/// <reference path="jshint.js" />

(function ()
{
    var Utilities = Skelta.Forms.Utilities;
    var ControlsNS = Skelta.Forms.Controls;

    //TODO: Need to Give the Namespace for  view model.
    Skelta.CreateNamespace("Skelta.Temp");

    function AppViewModel(passportDataModel)
    {
        var _vm = this;

        Skelta.BaseClass.call(_vm, Skelta.Temp, "AppViewModel");

        _vm.Main = new ControlsNS.BaseForm(null, MainItem, passportDataModel);
        _vm.Main.ID = "Ajx1";
        _vm.Main.XmlNodeBoundTo = "SKRootDefinition";

        _vm.Main.ReadEditBehaviour(0);
    }

    //TODO: Need to rename BaseClass
    Utilities.InheritClass(AppViewModel, Skelta.BaseClass);


    function MainItem(parent, passportDataModel, isNewAdded)
    {
        var _mainItem = this;

        _mainItem.IsRecordRow = true;
        ControlsNS.BaseForm.call(_mainItem, parent, null, null);

        _mainItem.IsNewRecord = isNewAdded;
        _mainItem.Items = null;

        //
        // Popup Related implementation
        //

        _mainItem.PopupForm = _mainItem.AddControl("PopupForm", "");
        _mainItem.PopupForm.Url = ko.observable("");
        _mainItem.PopupForm.Visible = ko.observable(false);
        _mainItem.PopupForm.Value = ko.observable("");
        _mainItem.PopupForm.ButtonClicked = ko.observable("");
        _mainItem.PopupForm.State = ko.observable("close");

        _mainItem.PopupForm.SubscriberFn = null;

        _mainItem.PopupForm.Show = function (url, initialValue, popupHandlerFn)
        {
            _mainItem.PopupForm.Url(url);
            _mainItem.PopupForm.ButtonClicked("");
            _mainItem.PopupForm.Value(initialValue);
            _mainItem.PopupForm.SubscriberFn = popupHandlerFn;
            _mainItem.PopupForm.State("open");
            _mainItem.PopupForm.Visible(true);
        };

        _mainItem.PopupForm.Close = _mainItem.PopupForm.State.subscribe(function (stateValue)
        {
            if (stateValue == "close")
            {
                if (!Utilities.IsUndefined(_mainItem.PopupForm.SubscriberFn))
                {
                    _mainItem.PopupForm.SubscriberFn(_mainItem.PopupForm);
                }

                _mainItem.PopupForm.SubscriberFn = null;
                _mainItem.PopupForm.Visible(false);
                _mainItem.PopupForm.Url("");
                _mainItem.PopupForm.ButtonClicked("");

                _mainItem.PopupForm.Value("");
            }
        });

        $(document).ready(function ()
        {
            var popupFormFrameElement = $("#PopupFormFrame")[0];

            popupFormFrameElement.SetValue = function (newValue)
            {
                _mainItem.PopupForm.Value(newValue);
            };

            popupFormFrameElement.SetButtonClicked = function (newValue)
            {
                _mainItem.PopupForm.ButtonClicked(newValue);
            };

            popupFormFrameElement.SetState = function (newValue)
            {
                _mainItem.PopupForm.State(newValue);
            };
        });



        //
        // End of Popup Related implementation
        //


        _mainItem.P1 = _mainItem.AddControl("P1", "");
        _mainItem.P1.TagName = ko.observable("Service Required");

        _mainItem.D1 = _mainItem.AddControl("D1", "AppliedFor");
        _mainItem.D1.TagName = ko.observable("Applied for");
        _mainItem.D1.Options = [
                                    { optiontext: 'Select', optionvalue: "0" },
                                    { optiontext: 'Fresh Passport', optionvalue: "1" },
                                    { optiontext: 'Re issue of Passport', optionvalue: "2" }
                              ];

        _mainItem.D1.SelectedValue = ko.observable(ko.utils.arrayFirst(_mainItem.D1.Options, function (item)
        {
            return item.optionvalue == passportDataModel.PassportForm.ApplyingFor;
        }));

        _mainItem.D1.Value = ko.computed(function ()
        {
            return this.D1.SelectedValue().optionvalue;
        }, _mainItem);

        _mainItem.C1 = _mainItem.AddControl("C1", "ReasonsForReissue");
        _mainItem.C1.TagName = ko.observable("If re-issue specify reasons");
        _mainItem.C1.IsMandatory = ko.observable(true);
        _mainItem.C1.IsError = ko.observable(false);
        _mainItem.C1.options = [
                                    { optiontext: 'Validity Expired within 3 years/Due to Expire', optionvalue: "1" },
                                    { optiontext: 'Validity Expired more than 3 years ago', optionvalue: "2" },
                                    { optiontext: 'Change in Existing Personal Particulars', optionvalue: "3" },
                                    { optiontext: 'Exhaustion of Pages', optionvalue: "4" },
                                    { optiontext: 'Lost Passport', optionvalue: "5" },
                                    { optiontext: 'Damaged Passport', optionvalue: "6" }
                              ];

        //The variable C1.CheckedValues WAS assigned to below two observable arrays,
        //but we found that when the user pushes into one array the other array was also getting the same value inserted.
        //Solution: assigned one with variable and another with datamodel straight variable
        var C1_CheckedValues = passportDataModel.PassportForm.ReasonsForReissue.split(';');
        _mainItem.C1.selectedOptions = ko.observableArray(passportDataModel.PassportForm.ReasonsForReissue.split(';'));
        _mainItem.C1.copy_selectedOptions = ko.observableArray(C1_CheckedValues);

        _mainItem.C1.Value = ko.computed(function ()
        {
            return this.C1.copy_selectedOptions().join(";");
        }, _mainItem);

        //
        // NOTE:
        // The below line has been added here as the C1 control requires to access C2 controls's visible property.
        // But we should come up with some way to initialize the control properties first then the complex functions
        // which refer to other controls.
        //
        _mainItem.C2 = _mainItem.AddControl("C2", "ReasonForChangeInPersonalParticulars");
        _mainItem.C2.Visibility = ko.observable(false);

        if (_mainItem.C1.copy_selectedOptions().indexOf("3") > -1)
        {
            _mainItem.C2.Visibility(true);
        }

        _mainItem.C1.SpanClass = ko.computed(function ()
        {
            if (this.C1.IsError())
            {
                return 2;
            }
            else if (this.C1.IsMandatory())
            {
                if (this.C1.Value().length > 0)
                {
                    return 1;
                }
                else
                {
                    return 2;
                }
            }
            else
            {
                return 0;
            }
        }, _mainItem);

        _mainItem.C1.ondatachange = function (param)
        {
            if (_mainItem.C1.copy_selectedOptions().indexOf(param.optionvalue) == -1)
            {
                _mainItem.C1.copy_selectedOptions.push(param.optionvalue);
            }
            else
            {
                _mainItem.C1.copy_selectedOptions.remove(param.optionvalue);
            }

            var errMsgMultiple = "You can select only one of the following options:";
            for (var i = 0; i < _mainItem.C1.options.length; i++)
            {
                var option = _mainItem.C1.options[i];
                errMsgMultiple += "\n" + (i + 1).toString() + ") " + option.optiontext;
            }

            if (_mainItem.C1.copy_selectedOptions().indexOf("3") > -1)
            {
                if (_mainItem.C1.copy_selectedOptions().length > 2)
                {
                    alert(errMsgMultiple);
                    _mainItem.C1.selectedOptions.removeAll();
                    _mainItem.C1.copy_selectedOptions.removeAll();
                    _mainItem.C1.selectedOptions.push("3");
                    _mainItem.C1.copy_selectedOptions.push("3");
                }
                _mainItem.C2.Visibility(true);
            }
            else if (_mainItem.C1.copy_selectedOptions().length > 1)
            {
                alert(errMsgMultiple);
                _mainItem.C1.selectedOptions.removeAll();
                _mainItem.C1.copy_selectedOptions.removeAll();
            }
            if (_mainItem.C1.copy_selectedOptions().indexOf("3") == -1)
            { //If not re-issue passport, make the If change in existing personal particulars invisible;
                _mainItem.C2.Visibility(false);
                _mainItem.C2.selectedOptions.removeAll();
            }
        };

        //_mainItem.C1.VisibleInternal = ko.observable(false);
        //_mainItem.C1.Visible = ko.observable(true);
        _mainItem.C1.VisibleScriptCode = "if (Control.FindById(\"D1\").Value() != \"\")" +
                                    "{" +
                                    "if (Control.FindById(\"D1\").Value() == \"2\")" +
                                    "{" +
                                    "return true;" +
                                    "}" +
                                    "else " +
                                    "{" +
                                    "return false;" +
                                    "}" +
                                    "}" +
                                    "else " +
                                    "{" +
                                    "return false;" +
                                    "}";

        _mainItem.C1.Visible = ko.observable(false).GetComputedV2(_mainItem.C1, _mainItem.C1.VisibleScriptCode);

        _mainItem.C2.TagName = ko.observable("If change in existing personal particulars");
        _mainItem.C2.IsMandatory = ko.observable(true);
        _mainItem.C2.IsError = ko.observable(false);
        _mainItem.C2.Description = ko.observable("( specify reason(s) )");
        _mainItem.C2.options = [
                                    { optiontext: 'Appearance', optionvalue: "1" },
                                    { optiontext: 'Signature', optionvalue: "2" },
                                    { optiontext: 'Others, please specify', optionvalue: "3" }
                              ];

        var C2_CheckedValues = passportDataModel.PassportForm.ReasonForChangeInPersonalParticulars.split(';');
        _mainItem.C2.selectedOptions = ko.observableArray(C2_CheckedValues);
        _mainItem.C2.copy_selectedOptions = ko.observableArray(passportDataModel.PassportForm.ReasonForChangeInPersonalParticulars.split(';'));

        _mainItem.C2.Value = ko.computed(function ()
        {
            return this.C2.copy_selectedOptions().join(";");
        }, _mainItem);

        //            _mainItem.C2.Value = ko.computed(function () {
        //                var returnVal = "";

        //                for (var option in this.C2.selectedOptions()) {
        //                    returnVal += option + ";";
        //                }

        //                if (returnVal.length > 0) {
        //                    returnVal = returnVal.substr(0, returnVal.length - 1);
        //                }

        //                return returnVal;
        //            }, _mainItem);

        _mainItem.C2.ondatachange = function (param)
        {
            if (_mainItem.C2.copy_selectedOptions().indexOf(param.optionvalue) == -1)
            {
                _mainItem.C2.copy_selectedOptions.push(param.optionvalue);
            }
            else
            {
                _mainItem.C2.copy_selectedOptions.remove(param.optionvalue);
            }
            //alert(ko.toJSON(_mainItem.C2.copy_selectedOptions));
        };

        _mainItem.C2.SpanClass = ko.computed(function ()
        {
            if (this.C2.IsError())
            {
                return 2;
            }
            else if (this.C2.IsMandatory())
            {
                if (this.C2.copy_selectedOptions().length > 0)
                {
                    return 1;
                }
                else
                {
                    return 2;
                }
            }
            else
            {
                return 0;
            }
        }, _mainItem);

        _mainItem.R1 = _mainItem.AddControl("R1", "ApplicationType");
        _mainItem.R1.TagName = ko.observable("Type of Application");
        _mainItem.R1.IsMandatory = ko.observable(true);
        _mainItem.R1.IsError = ko.observable(false);

        _mainItem.R1.options = [
                                    { optiontext: 'Normal', optionvalue: "1" },
                                    { optiontext: 'Tatkaal', optionvalue: "2" }
                              ];

        // Similar to earlier issue we faced with C1 Checked Values.
        var R1_CheckedValues = passportDataModel.PassportForm.ApplicationType.split(';');
        _mainItem.R1.selectedOptions = ko.observableArray(R1_CheckedValues);
        _mainItem.R1.copy_selectedOptions = ko.observableArray(passportDataModel.PassportForm.ApplicationType.split(';'));

        _mainItem.R1.Value = ko.computed(function ()
        {
            return this.R1.copy_selectedOptions().join(";");
        }, _mainItem);

        _mainItem.R1.SpanClass = ko.computed(function ()
        {
            if (this.R1.IsError())
            {
                return 2;
            }
            else if (this.R1.IsMandatory())
            {
                if (this.R1.copy_selectedOptions().length > 0)
                {
                    return 1;
                }
                else
                {
                    return 2;
                }
            }
            else
            {
                return 0;
            }
        }, _mainItem);

        _mainItem.R1.ondatachange = function (param)
        {
            _mainItem.R1.copy_selectedOptions.removeAll();
            _mainItem.R1.copy_selectedOptions.push(param.optionvalue);

            //alert(ko.toJSON(_mainItem.R1.copy_selectedOptions));
        };

        _mainItem.R2 = _mainItem.AddControl("R2", "PassportBookletType");
        _mainItem.R2.TagName = ko.observable("Type of Passport Booklet");
        _mainItem.R2.IsMandatory = ko.observable(true);
        _mainItem.R2.IsError = ko.observable(false);

        // Similar issue with C1 Checked Values
        _mainItem.R2.options = [
                                    { optiontext: '36 Pages', optionvalue: "1" },
                                    { optiontext: '60 Pages', optionvalue: "2" }
                              ];
        var R2_CheckedValues = passportDataModel.PassportForm.PassportBookletType.split(',');
        _mainItem.R2.selectedOptions = ko.observableArray(R2_CheckedValues);
        _mainItem.R2.copy_selectedOptions = ko.observableArray(passportDataModel.PassportForm.PassportBookletType.split(','));

        _mainItem.R2.Value = ko.computed(function ()
        {
            return this.R2.copy_selectedOptions().join(";");
        }, _mainItem);

        _mainItem.R2.SpanClass = ko.computed(function ()
        {
            if (this.R2.IsError())
            {
                return 2;
            }
            else if (this.R2.IsMandatory())
            {
                if (this.R2.copy_selectedOptions().length > 0)
                {
                    return 1;
                }
                else
                {
                    return 2;
                }
            }
            else
            {
                return 0;
            }
        }, _mainItem);

        _mainItem.R2.ondatachange = function (param)
        {
            _mainItem.R2.copy_selectedOptions.removeAll();
            _mainItem.R2.copy_selectedOptions.push(param.optionvalue);

            //alert(ko.toJSON(_mainItem.R2.copy_selectedOptions));
        };

        _mainItem.R3 = _mainItem.AddControl("R3", "ValidityRequired");
        _mainItem.R3.TagName = ko.observable("Validity Required");
        _mainItem.R3.Description = ko.observable("( For minors between 15 and 18 )");
        _mainItem.R3.options = [
                                    { optiontext: '10 years', optionvalue: "1" },
                                    { optiontext: 'Up to age 18', optionvalue: "2" },
                                    { optiontext: 'Not Applicable', optionvalue: "3" }
                              ];

        // Similar issue with C1 Checked Values
        var R3_CheckedValues = passportDataModel.PassportForm.ValidityRequired.split(',');
        _mainItem.R3.selectedOptions = ko.observableArray(R3_CheckedValues);
        _mainItem.R3.copy_selectedOptions = ko.observableArray(passportDataModel.PassportForm.ValidityRequired.split(','));

        _mainItem.R3.Value = ko.computed(function ()
        {
            return this.R3.copy_selectedOptions().join(";");
        }, _mainItem);

        _mainItem.R3.ondatachange = function (param)
        {
            _mainItem.R3.copy_selectedOptions.removeAll();
            _mainItem.R3.copy_selectedOptions.push(param.optionvalue);

            //alert(ko.toJSON(_mainItem.R3.copy_selectedOptions));
        };


        //Second DIV
        _mainItem.P2 = _mainItem.AddControl("P2", "");
        _mainItem.P2.TagName = ko.observable("Applicant Details");

        _mainItem.T1 = _mainItem.AddControl("T1", "ApplicantsGivenName");
        _mainItem.T1.TagName = ko.observable("Applicant Given Name");
        _mainItem.T1.Description = ko.observable(" (First Name followed by middle Name (if any))");
        _mainItem.T1.IsMandatory = ko.observable(true);
        _mainItem.T1.IsError = ko.observable(false);
        _mainItem.T1.Value = ko.observable(passportDataModel.PassportForm.ApplicantsGivenName);

        _mainItem.T1.SpanClass = ko.computed(function ()
        {
            if (this.T1.IsError())
            {
                return 2;
            }
            else if (this.T1.IsMandatory())
            {
                if (this.T1.Value().length > 0)
                {
                    return 1;
                }
                else
                {
                    return 2;
                }
            }
            else
            {
                return 0;
            }
        }, _mainItem);

        _mainItem.T2 = _mainItem.AddControl("T2", "SurName");
        _mainItem.T2.TagName = ko.observable("SurName");
        _mainItem.T2.Value = ko.observable(passportDataModel.PassportForm.Surname);

        _mainItem.D2 = _mainItem.AddControl("D2", "DateOfBirth");
        _mainItem.D2.TagName = ko.observable("Date of Birth");
        _mainItem.D2.Description = ko.observable(" (DD/MM/YYYY)");
        _mainItem.D2.IsMandatory = ko.observable(true);
        _mainItem.D2.IsError = ko.observable(false);

        (function ()
        {
            var elem = document.createElement('input');
            elem.setAttribute('type', 'date');

            if (elem.type === 'text')
            {
                $('#dtPicker').datepicker({
                    dateFormat: 'dd/mm/yy'
                });

                $('#dtVerificationDtls').datepicker({
                    dateFormat: 'dd/mm/yy'
                });
            }
        })();

        _mainItem.D2.Value = ko.observable(passportDataModel.PassportForm.DateOfBirth);

        _mainItem.D2.SpanClass = ko.computed(function ()
        {
            if (this.D2.IsError())
            {
                return 2;
            }
            else if (this.D2.IsMandatory())
            {
                if (this.D2.Value().length > 0)
                {
                    return 1;
                }
                else
                {
                    return 2;
                }
            }
            else
            {
                return 0;
            }
        }, _mainItem);

        _mainItem.P3 = _mainItem.AddControl("P3", "");
        _mainItem.P3.TagName = ko.observable("Place Of Birth");

        _mainItem.T3 = _mainItem.AddControl("T3", "City");
        _mainItem.T3.TagName = ko.observable("Village or Town or City");
        _mainItem.T3.IsMandatory = ko.observable(false);
        _mainItem.T3.IsError = ko.observable(false);
        _mainItem.T3.Value = ko.observable(passportDataModel.PassportForm.City);

        _mainItem.T3.SpanClass = ko.computed(function ()
        {
            if (this.T3.IsError())
            {
                return 2;
            }
            else if (this.T3.IsMandatory())
            {
                if (this.T3.Value().length > 0)
                {
                    return 1;
                }
                else
                {
                    return 2;
                }
            }
            else
            {
                return 0;
            }
        }, this);

        _mainItem.D3 = _mainItem.AddControl("D3", "Country");
        _mainItem.D3.TagName = ko.observable("Country if abroad	");
        _mainItem.D3.Description = ko.observable(" (born before 1947 in a place in Pakistan or Bangladesh, select Undivided India.)");
        _mainItem.D3.IsMandatory = ko.observable(true);
        _mainItem.D3.IsError = ko.observable(false);

        _mainItem.D3.SelectedOptions = ko.observable();
        _mainItem.D3.options = "";
        _mainItem.D3.SpanClass = ko.computed(function ()
        {
            return 1;
        }, _mainItem);
        _mainItem.D3.Value = ko.computed(function ()
        {
            if (!Utilities.IsUndefined(this.D3.SelectedOptions()))
            {
                return this.D3.SelectedOptions().optionvalue;
            }
            else
            {
                return "";
            }
        }, _mainItem);

        _mainItem.D3.AjaxOptions = function ()
        {
            jQuery.support.cors = true;
            $.ajax({
                type: 'GET',
                async: false,
                contentType: "application/json; charset=utf-8",
                url: "http://10.15.161.72/HTMLWebApplication/SKRestServiceImp.svc/getAllCountry/",
                dataType: "jsonp",
                success: function (data)
                {
                    _mainItem.D3.options = data; //modelData.D3.Options;
                    _mainItem.D3.SelectedOptions(ko.utils.arrayFirst(_mainItem.D3.options, function (item)
                    {
                        return item.CountryId == passportDataModel.PassportForm.Country;
                    }));

                    _mainItem.D3.Value = ko.computed(function ()
                    {
                        return this.D3.SelectedOptions().CountryId;
                    }, _mainItem);

                    _mainItem.D3.SpanClass = ko.computed(function ()
                    {
                        if (this.D3.IsError())
                        {
                            return 2;
                        }
                        else if (this.D3.IsMandatory())
                        {
                            if (this.D3.Value() != null)
                            {
                                return 1;
                            }
                            else
                            {
                                return 2;
                            }
                        }
                        else
                        {
                            return 0;
                        }
                    }, _mainItem);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown)
                {
                    alert("status= " + XMLHttpRequest.status + ", statusText=" + XMLHttpRequest.statusText + ", - " + textStatus + ", - " + errorThrown);
                }
            });
        } ();

        _mainItem.State_TagName = ko.observable("State");
        _mainItem.State_options = "";
        _mainItem.State_SelectedOptions = ko.observable();
        _mainItem.D3.SelectedOptions.subscribe(function (selectedCountry)
        {
            $.ajax({
                type: 'GET',
                async: false,
                contentType: "application/json; charset=utf-8",
                url: "http://10.15.161.72/HTMLWebApplication/SKRestServiceImp.svc/getAllStates/",
                dataType: "jsonp",
                success: function (data)
                {
                    if (!selectedCountry)
                        _mainItem.State_options = data;
                    else
                    {
                        _mainItem.State_options = $.grep(data, function (item)
                        {
                            return item.CountryId == selectedCountry.CountryId;
                        });
                        //alert(_mainItem.State_options);
                        //                            _mainItem.State_options = ko.utils.arrayFilter(data, function (item) {
                        //                                alert(item.CountryId);
                        //                                return ko.utils.stringStartsWith(item.CountryId, "1");
                        //                            });
                    }
                    _mainItem.State_SelectedOptions(ko.utils.arrayFirst(_mainItem.State_options, function (item)
                    {
                        return item.StateId == "1";
                    }));

                    //                        _mainItem.State = ko.computed(function () {
                    //                            return this.State_SelectedOptions().StateId;
                    //                        }, _mainItem);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown)
                {
                    alert("status= " + XMLHttpRequest.status + ", statusText=" + XMLHttpRequest.statusText + ", - " + textStatus + ", - " + errorThrown);
                }
            });
        });

        _mainItem.D4 = _mainItem.AddControl("D4", "Gender");
        _mainItem.D4.TagName = ko.observable("Gender");
        _mainItem.D4.IsMandatory = ko.observable(true);
        _mainItem.D4.IsError = ko.observable(false);
        _mainItem.D4.options = [
                                    { optiontext: 'Male', optionvalue: "1" },
                                    { optiontext: 'Female', optionvalue: "2" }
                              ];

        _mainItem.D4.selectedOptions = ko.observable(ko.utils.arrayFirst(_mainItem.D4.options, function (item)
        {
            return item.optionvalue == passportDataModel.PassportForm.Gender;
        }));

        _mainItem.D4.Value = ko.computed(function ()
        {
            return this.D4.selectedOptions().optionvalue;
        }, _mainItem);

        _mainItem.D4.SpanClass = ko.computed(function ()
        {
            if (this.D4.IsError())
            {
                return 2;
            }
            else if (this.D4.IsMandatory())
            {
                if (this.D4.Value() != null)
                {
                    return 1;
                }
                else
                {
                    return 2;
                }
            }
            else
            {
                return 0;
            }
        }, _mainItem);

        _mainItem.D5 = _mainItem.AddControl("D5", "MaritalStatus");
        _mainItem.D5.TagName = ko.observable("Marital Status");
        _mainItem.D5.IsMandatory = ko.observable(true);
        _mainItem.D5.IsError = ko.observable(false);
        _mainItem.D5.options = [
                                    { optiontext: 'Single', optionvalue: "1" },
                                    { optiontext: 'Married', optionvalue: "2" },
                                    { optiontext: 'Divorced', optionvalue: "3" }
                              ];

        _mainItem.D5.SelectedOptions = ko.observable(ko.utils.arrayFirst(_mainItem.D5.options, function (item)
        {
            return item.optionvalue == passportDataModel.PassportForm.MaritalStatus;
        }));

        _mainItem.D5.Value = ko.computed(function ()
        {
            return this.D5.SelectedOptions().optionvalue;
        }, _mainItem);

        _mainItem.D5.SpanClass = ko.computed(function ()
        {
            if (this.D5.IsError())
            {
                return 2;
            }
            else if (this.D5.IsMandatory())
            {
                if (this.D5.Value() != null)
                {
                    return 1;
                }
                else
                {
                    return 2;
                }
            }
            else
            {
                return 0;
            }
        }, _mainItem);

        _mainItem.D6 = _mainItem.AddControl("D6", "CitizenshipOfIndiaBy");
        _mainItem.D6.TagName = ko.observable("Citizenship of India by");
        _mainItem.D6.IsMandatory = ko.observable(true);
        _mainItem.D6.IsError = ko.observable(false);
        _mainItem.D6.options = [
                                    { optiontext: 'Birth', optionvalue: "1" },
                                    { optiontext: 'Descent', optionvalue: "2" },
                                    { optiontext: 'Registration/Naturalization', optionvalue: "3" }
                              ];

        _mainItem.D6.SelectedOptions = ko.observable(ko.utils.arrayFirst(_mainItem.D6.options, function (item)
        {
            return item.optionvalue == passportDataModel.PassportForm.CitizenshipOfIndiaBy;
        }));

        _mainItem.D6.Value = ko.computed(function ()
        {
            return this.D6.SelectedOptions().optionvalue;
        }, _mainItem);

        _mainItem.D6.SpanClass = ko.computed(function ()
        {
            if (this.D6.IsError())
            {
                return 2;
            }
            else if (this.D6.IsMandatory())
            {
                if (this.D6.Value() != null)
                {
                    return 1;
                }
                else
                {
                    return 2;
                }
            }
            else
            {
                return 0;
            }
        }, _mainItem);

        _mainItem.A1 = _mainItem.AddControl("A1", "Pan");
        _mainItem.A1.TagName = ko.observable("PAN");
        _mainItem.A1.Description = ko.observable(" (If Avaialable)");
        _mainItem.A1.Value = ko.observable(passportDataModel.PassportForm.Pan);

        _mainItem.A2 = _mainItem.AddControl("A2", "VoterID");
        _mainItem.A2.TagName = ko.observable("Voter ID");
        _mainItem.A2.Description = ko.observable(" (If Avaialable)");
        _mainItem.A2.Value = ko.observable(passportDataModel.PassportForm.VoterID);

        _mainItem.D7 = _mainItem.AddControl("D7", "EmploymentType");
        _mainItem.D7.TagName = ko.observable("Employment Type");
        _mainItem.D7.IsMandatory = ko.observable(true);
        _mainItem.D7.IsError = ko.observable(false);
        _mainItem.D7.options = [
                                    { optiontext: 'Government', optionvalue: "1" },
                                    { optiontext: 'Home Maker', optionvalue: "2" },
                                    { optiontext: 'Not Employed', optionvalue: "3" },
                                    { optiontext: 'Others', optionvalue: "4" },
                                    { optiontext: 'Private', optionvalue: "5" }
                              ];

        _mainItem.D7.SelectedOptions = ko.observable(ko.utils.arrayFirst(_mainItem.D7.options, function (item)
        {
            return item.optionvalue == passportDataModel.PassportForm.EmploymentType;
        }));

        _mainItem.D7.Value = ko.computed(function ()
        {
            return this.D7.SelectedOptions().optionvalue;
        }, _mainItem);

        _mainItem.D7.SpanClass = ko.computed(function ()
        {
            if (this.D7.IsError())
            {
                return 2;
            }
            else if (this.D7.IsMandatory())
            {
                if (this.D7.Value() != null)
                {
                    return 1;
                }
                else
                {
                    return 2;
                }
            }
            else
            {
                return 0;
            }
        }, _mainItem);

        _mainItem.T4 = _mainItem.AddControl("T4", "OrganisationName");
        _mainItem.T4.TagName = ko.observable("Organisation Name");
        _mainItem.T4.IsMandatory = ko.observable(true);
        _mainItem.T4.IsError = ko.observable(false);
        _mainItem.T4.Value = ko.observable(passportDataModel.PassportForm.OrganisationName);

        _mainItem.T4.SpanClass = ko.computed(function ()
        {
            if (this.T4.IsError())
            {
                return 2;
            }
            else if (this.T4.IsMandatory())
            {
                if (this.T4.Value().length > 0)
                {
                    return 1;
                }
                else
                {
                    return 2;
                }
            }
            else
            {
                return 0;
            }
        }, _mainItem);

        _mainItem.B1 = _mainItem.AddControl("B1", "ParentOrSpouseInGovermentService");
        _mainItem.B1.TagName = ko.observable("Is either of your parent or spouse a government servant");
        _mainItem.B1.Description = ko.observable("( parent (in case of minor)");
        _mainItem.B1.options = [
                                    { optiontext: 'Yes', optionvalue: "1" },
                                    { optiontext: 'No', optionvalue: "0" },
                              ];

        // Similar issue with C1 Checked Values
        var B1_CheckedValues = passportDataModel.PassportForm.ParentOrSpouseInGovermentService.split(';');
        _mainItem.B1.selectedOptions = ko.observableArray(B1_CheckedValues);
        _mainItem.B1.copy_selectedOptions = ko.observableArray(passportDataModel.PassportForm.ParentOrSpouseInGovermentService.split(';'));

        _mainItem.B1.Value = ko.computed(function ()
        {
            return this.B1.copy_selectedOptions().join(";");
        }, _mainItem);

        _mainItem.B1.ondatachange = function (param)
        {
            _mainItem.B1.copy_selectedOptions.removeAll();
            _mainItem.B1.copy_selectedOptions.push(param.optionvalue);

            //alert(ko.toJSON(_mainItem.B1.copy_selectedOptions));
        };

        _mainItem.D8 = _mainItem.AddControl("D8", "EducationalQualification");
        _mainItem.D8.TagName = ko.observable("Educational Qualification");
        _mainItem.D8.options = [
                                    { optiontext: '5th pass or less', optionvalue: "1" },
                                    { optiontext: 'between 6th and 9th', optionvalue: "2" },
                                    { optiontext: '10th pass and above', optionvalue: "3" },
                                    { optiontext: 'Graduate and above', optionvalue: "4" }
                              ];

        _mainItem.D8.SelectedOptions = ko.observable(ko.utils.arrayFirst(_mainItem.D8.options, function (item)
        {
            return item.optionvalue == passportDataModel.PassportForm.EducationalQualification;
        }));

        _mainItem.D8.Value = ko.computed(function ()
        {
            return this.D8.SelectedOptions().optionvalue;
        }, _mainItem);

        _mainItem.B2 = _mainItem.AddControl("B2", "EligibleForNonECRCategory");
        _mainItem.B2.TagName = ko.observable("Are you eligible for Non ECR category");
        _mainItem.B2.options = [
                                    { optiontext: 'Yes', optionvalue: "1" },
                                    { optiontext: 'No', optionvalue: "0" }
                              ];

        var B2_CheckedValues = passportDataModel.PassportForm.EligibleForNonECRCategory.split(';');
        _mainItem.B2.selectedOptions = ko.observableArray(B2_CheckedValues);
        _mainItem.B2.copy_selectedOptions = ko.observableArray(passportDataModel.PassportForm.EligibleForNonECRCategory.split(';'));

        _mainItem.B2.Value = ko.computed(function ()
        {
            return this.B2.copy_selectedOptions().join(";");
        }, _mainItem);

        _mainItem.B2.ondatachange = function (param)
        {
            _mainItem.B2.copy_selectedOptions.removeAll();
            _mainItem.B2.copy_selectedOptions.push(param.optionvalue);

            //alert(ko.toJSON(_mainItem.B2.copy_selectedOptions));
        };

        _mainItem.T5 = _mainItem.AddControl("T5", "VisibleDistinguishingMark");
        _mainItem.T5.TagName = ko.observable("Visible Distinguishing Mark");
        _mainItem.T5.Value = ko.observable(passportDataModel.PassportForm.VisibleDistinguishingMark);

        _mainItem.P5 = _mainItem.AddControl("P5", "");
        _mainItem.P5.TagName = ko.observable("Reference");

        _mainItem.G1 = _mainItem.AddContainerControl("G1", "ReferenceGrid", G1Item, passportDataModel.PassportForm.ReferenceGrid);

        _mainItem.G1.TagName = ko.observable("Reference Details");

        _mainItem.save = function (form)
        {
            alert("Could now transmit to server: " + ko.utils.stringifyJson(_mainItem.G1.Items));
            // To actually transmit to server as a regular form post, write this: ko.utils.postJson($("form")[0], _mainItem.G1.Items);
        };

        _mainItem.P6 = _mainItem.AddControl("P6", "");
        _mainItem.P6.TagName = ko.observable("Action");

        _mainItem.P7 = _mainItem.AddControl("P7", "");
        _mainItem.P7.TagName = ko.observable("Details");

        _mainItem.G2 = _mainItem.AddContainerControl("G2", "Verification", G2Item, passportDataModel.PassportForm.GridVerification);
        _mainItem.G2.TagName = ko.observable("Verification");


        _mainItem.P8 = _mainItem.AddControl("P8", "");
        _mainItem.P8.TagName = ko.observable("Grand Total");

        _mainItem.T9 = _mainItem.AddControl("T9", "VerificationExpenseGrandTotal");
        _mainItem.T9.TagName = ko.observable("Verification Expense Grand Total");
        _mainItem.T9.Value = ko.computed(function ()
        {
            var total = 0;
            for (var eachRow = 0; eachRow < this.G2.Items().length; eachRow++)
            {
                var eachIem = this.G2.Items()[eachRow];
                total += Utilities.parseNumberValue(eachIem.T8.Value());
            }
            return total;
        }, _mainItem);


        //
        // Tabs Related implementation
        //

        _mainItem.T10 = _mainItem.AddTabsContainerControl("T10", T10Item, passportDataModel.PassportForm);
        _mainItem.T10.OnDataChangedScript("Control.FindById(\"T9\").TagName(Control.FindById(\"T10\").Tabs()[Control.SelectedTabIndex()].TagName() + \" - Verification Expense Grand Total\");");


        _mainItem.R5 = _mainItem.AddControl("R5", "Tab Selector");
        _mainItem.R5.options = [
                            { optiontext: 'Product', optionvalue: 0 },
                            { optiontext: 'PS', optionvalue: 1 },
                            { optiontext: 'Support', optionvalue: 2 }
                         ];
        _mainItem.R5.selectedOptions = ko.observable("");
        _mainItem.R5.Value = ko.computed(function ()
        {
            if (!Utilities.IsUndefined(this.R5.selectedOptions()))
            {
                try
                {
                    return this.R5.selectedOptions();
                }
                catch (err)
                {
                    return "";
                }
            }
            else
                return "";
        }, _mainItem);

        _mainItem.R5.ondatachange = function (param)
        {
            // Below 3 lines of code is for the label click sync with radio button input elements.
            if (Utilities.IsUndefined(_mainItem.R5.selectedOptions()) || (_mainItem.R5.selectedOptions() == "") || (_mainItem.R5.selectedOptions() != param.optionvalue))
            {
                _mainItem.R5.selectedOptions(param.optionvalue);
            }

            _mainItem.T10.SelectedTabIndex(param.optionvalue);
        };

        //
        // End of Tabs Related implementation
        //


        //
        // Popup Related implementation
        //

        _mainItem.T16 = _mainItem.AddControl("T16", "UserLookup");
        _mainItem.T16.TagName = ko.observable("User Lookup");
        _mainItem.T16.Value = ko.observable("");
        _mainItem.T16.SetValue = function (popupForm)
        {
            if (popupForm.ButtonClicked() != "Cancel")
            {
                _mainItem.T16.Value(popupForm.Value());
            }
        };
        _mainItem.T16.Click = function ()
        {
            _mainItem.PopupForm.Show("PopupSampleForm.htm", _mainItem.T16.Value(), _mainItem.T16.SetValue);
        };

        //
        // End of Popup Related implementation
        //

        _mainItem.submitClicked = function (event)
        {
            //alert(ko.toJSON(passportDataModel.PassportForm.length));                
            var passportUpdatedDataModel =
                                    {
                                        "PassportForm":
                                        {
                                            "ApplyingFor": _mainItem.D1.Value(),
                                            "ReasonsForReissue": _mainItem.C1.Value(),
                                            "ReasonForChangeInPersonalParticulars": _mainItem.C2.Value(),
                                            "ApplicationType": _mainItem.R1.Value(),
                                            "ValidityRequired": _mainItem.R3.Value(),
                                            "Surname": _mainItem.T2.Value(),
                                            "DateOfBirth": _mainItem.D2.Value(),
                                            "Gender": _mainItem.D4.Value(),
                                            "MaritalStatus": _mainItem.D5.Value(),
                                            "CitizenshipOfIndiaBy": _mainItem.D6.Value(),
                                            "Pan": _mainItem.A1.Value(),
                                            "VoterID": _mainItem.A2.Value(),
                                            "EmploymentType": _mainItem.D7.Value(),
                                            "ParentOrSpouseInGovermentService": _mainItem.B1.Value(),
                                            "EducationalQualification": _mainItem.D8.Value(),
                                            "EligibleForNonECRCategory": _mainItem.B2.Value(),
                                            "VisibleDistinguishingMark": _mainItem.T5.Value(),
                                            "PassportBookletType": _mainItem.R2.Value(),
                                            "ApplicantsGivenName": _mainItem.T1.Value(),
                                            "City": _mainItem.T3.Value(),
                                            "Country": _mainItem.D3.Value(),
                                            "OrganisationName": _mainItem.T4.Value(),
                                            "ReferenceGrid": function ()
                                            {
                                                var arr = new Array();
                                                for (var eachRow = 0; eachRow < _mainItem.G1.Items().length; eachRow++)
                                                {
                                                    var obj = _mainItem.G1.Items()[eachRow];
                                                    arr.push(obj.getJSONObject());
                                                }
                                                return arr;
                                            } (),
                                            "GridVerification": function ()
                                            {
                                                var arr = new Array();
                                                for (var eachRow = 0; eachRow < _mainItem.G2.Items().length; eachRow++)
                                                {
                                                    var obj = _mainItem.G2.Items()[eachRow];
                                                    arr.push(obj.getJSONObject());
                                                }
                                                return arr;
                                            } (),
                                            "VerificationExpenseGrandTotal": _mainItem.T9.Value()
                                        }
                                    };
            alert(Utilities.GetXmlFromJSONObject(passportUpdatedDataModel));
        };

    }

    Utilities.InheritClass(MainItem, ControlsNS.BaseForm);


    function T10Item(parent, dataModel)
    {
        var _T10Item = this;

        ControlsNS.TabsContainerControl.call(_T10Item, parent, null, dataModel);

        _T10Item.T11 = _T10Item.AddTabControl("T11", TabT11Item, dataModel);
        _T10Item.T11.TagName = ko.observable("Product");

        _T10Item.T12 = _T10Item.AddTabControl("T12", TabT12Item, dataModel);
        _T10Item.T12.TagName = ko.observable("PS");

        _T10Item.T13 = _T10Item.AddTabControl("T13", TabT13Item, dataModel);
        _T10Item.T13.TagName = ko.observable("Support");
    }

    Utilities.InheritClass(T10Item, ControlsNS.TabsContainerControl);


    function TabT11Item(parent, dataModel)
    {
        var _TabT11Item = this;

        ControlsNS.TabControl.call(_TabT11Item, parent, null, dataModel);

        _TabT11Item.T14 = _TabT11Item.AddControl("T14", "ProductHead");
        _TabT11Item.T14.TagName = ko.observable("Product Head");
        _TabT11Item.T14.Value = ko.observable("");
    }

    Utilities.InheritClass(TabT11Item, ControlsNS.TabControl);


    function TabT12Item(parent, dataModel)
    {
        var _TabT12Item = this;

        ControlsNS.TabControl.call(_TabT12Item, parent, null, dataModel);


        _TabT12Item.T15 = _TabT12Item.AddControl("T15", "PSHead");
        _TabT12Item.T15.TagName = ko.observable("PS Head");
        _TabT12Item.T15.Value = ko.observable("");
    }

    Utilities.InheritClass(TabT12Item, ControlsNS.TabControl);


    function TabT13Item(parent, dataModel)
    {
        var _TabT13Item = this;

        ControlsNS.TabControl.call(_TabT13Item, parent, null, dataModel);


        _TabT13Item.T16 = _TabT13Item.AddControl("T16", "SupportHead");
        _TabT13Item.T16.TagName = ko.observable("Support Head");
        _TabT13Item.T16.Value = ko.observable("");
    }

    Utilities.InheritClass(TabT13Item, ControlsNS.TabControl);


    function G2Item(parent, dataModel, isNewAdded)
    {
        var _G2Item = this;

        _G2Item.IsRecordRow = true;
        ControlsNS.BaseForm.call(_G2Item, parent, null, dataModel);

        _G2Item.IsNewRecord = isNewAdded;
        _G2Item.Items = null;

        _G2Item.IsRowHighlighted = ko.observable(false);
        _G2Item.selectedRowClick = function ()
        {
            for (var eachRow = 0; eachRow < _G2Item.ParentForm.Items().length; eachRow++)
            {
                _G2Item.ParentForm.ParentForm.G2.Items()[eachRow].IsRowHighlighted(false);
            }
            _G2Item.IsRowHighlighted(true);
        };

        _G2Item.D10 = _G2Item.AddControl("D10", "VerificationDate");
        _G2Item.D10.Value = ko.observable("");

        _G2Item.G3 = _G2Item.AddContainerControl("G3", "GridVerificationExpense", G3Item, null);

        _G2Item.T8 = _G2Item.AddControl("T8", "VerificationTotal");
        _G2Item.T8.Value = ko.computed(function ()
        {
            var total = 0;

            for (var eachRow = 0; eachRow < this.G3.Items().length; eachRow++)
            {
                var obj = this.G3.Items()[eachRow];
                var feTotal = 0;
                var teTotal = 0;

                for (var eachFeRow = 0; eachFeRow < obj.G4.Items().length; eachFeRow++)
                {
                    var objFe = obj.G4.Items()[eachFeRow];
                    feTotal += Utilities.parseNumberValue(objFe.N1.Value());
                }

                for (var eachTeRow = 0; eachTeRow < obj.G5.Items().length; eachTeRow++)
                {
                    var objTe = obj.G5.Items()[eachTeRow];
                    teTotal += Utilities.parseNumberValue(objTe.N2.Value());
                }
                total += feTotal + teTotal;
            }

            return total;
        }, _G2Item);

        _G2Item.H1 = new Object();
        _G2Item.H1.Value = ko.observable("");


        if (dataModel != null)
        {
            _G2Item.D10.Value(dataModel.VerificationDate);

            _G2Item.G3.DisableEvents = true;
            if (!Utilities.IsUndefined(dataModel.GridVerificationExpense))
            {
                if (!Utilities.IsUndefined(dataModel.GridVerificationExpense.length))
                {
                    for (var eachRow = 0; eachRow < dataModel.GridVerificationExpense.length; eachRow++)
                    {
                        _G2Item.G3.AddItem(dataModel.GridVerificationExpense[eachRow]);
                    }
                }
                else
                {
                    _G2Item.G3.AddItem(dataModel.GridVerificationExpense);
                }
            }
            _G2Item.G3.DisableEvents = false;
        }

        _G2Item.getJSONObject = function ()
        {
            return {
                "VerificationDate": _G2Item.D10.Value(),
                "GridVerificationExpense": function ()
                {
                    var arr = new Array();
                    for (var eachRow = 0; eachRow < _G2Item.G3.Items().length; eachRow++)
                    {
                        var obj = _G2Item.G3.Items()[eachRow];
                        arr.push(obj.getJSONObject());
                    }
                    return arr;
                } (),
                "VerificationTotal": _G2Item.T8.Value()
            };
        };
    }

    Utilities.InheritClass(G2Item, ControlsNS.BaseForm);


    function G1Item(parent, dataModel, isNewAdded)
    {
        var _G1Item = this;

        _G1Item.IsRecordRow = true;
        ControlsNS.BaseForm.call(_G1Item, parent, null, dataModel);

        _G1Item.IsNewRecord = isNewAdded;
        _G1Item.Items = null;


        _G1Item.IsRowHighlighted = ko.observable(false);
        _G1Item.selectedRowClick = function ()
        {
            for (var eachRow = 0; eachRow < _G1Item.ParentForm.Items().length; eachRow++)
            {
                _G1Item.ParentForm.ParentForm.G1.Items()[eachRow].IsRowHighlighted(false);
            }
            _G1Item.IsRowHighlighted(true);
        };


        _G1Item.T7 = _G1Item.AddControl("T7", "Name");
        _G1Item.T7.Value = ko.observable("");

        //            _G1Item.T7.EnableInternal = ko.observable(true);
        _G1Item.T7.Enable = ko.observable(true).GetComputedV2(_G1Item.T7, "", _G1Item.T7.EnableDependencyFunction, Utilities.AndOperation);

        _G1Item.T7.Disable = ko.computed({
            read: function ()
            {
                return !this.Enable();
            },
            write: function (param)
            {
                this.Enable(!param);
            }
        }, _G1Item.T7);

        _G1Item.E1 = _G1Item.AddControl("E1", "Email");
        _G1Item.E1.Value = ko.observable("");

        _G1Item.D9 = _G1Item.AddControl("D9", "Relation");
        _G1Item.D9.Options = ko.observableArray([
                                            { optiontext: 'Select', optionvalue: "0" },
                                            { optiontext: 'Brother', optionvalue: "1" },
                                            { optiontext: 'Sister', optionvalue: "2" }
                                         ]);
        _G1Item.D9.selectedOptions = ko.observable();
        _G1Item.D9.Value = ko.computed(function ()
        {
            if (!Utilities.IsUndefined(this.D9.selectedOptions()))
            {
                //                    alert(this.D9.selectedOptions());
                return this.D9.selectedOptions().optionvalue;
            }
            else
                return "";
        }, _G1Item);

        _G1Item.R4 = _G1Item.AddControl("R4", "Gender");
        _G1Item.R4.Options = ko.observableArray([
                                        { optiontext: 'Male', optionvalue: "1" },
                                        { optiontext: 'Female', optionvalue: "2" }
                                        ]);
        _G1Item.R4.selectedOptions = ko.observable();
        _G1Item.R4.Value = ko.computed(function ()
        {
            if (!Utilities.IsUndefined(this.R4.selectedOptions()))
            {
                return this.R4.selectedOptions();
            }
            else
                return "";
        }, _G1Item);

        if (dataModel != null)
        {
            _G1Item.T7.Value(dataModel.Name);
            _G1Item.E1.Value(dataModel.Email);

            _G1Item.D9.selectedOptions(ko.utils.arrayFirst(_G1Item.D9.Options(), function (item)
            {
                return item.optionvalue == dataModel.Relation;
            }));

            _G1Item.R4.selectedOptions(dataModel.Gender);
        }

        _G1Item.getJSONObject = function ()
        {
            return { "Name": _G1Item.T7.Value(), "Email": _G1Item.E1.Value(), "Relation": _G1Item.D9.Value(), "Gender": _G1Item.R4.Value() };
        };
    }

    Utilities.InheritClass(G1Item, ControlsNS.BaseForm);


    function G3Item(parent, dataModel, isNewAdded)
    {
        var _G3Item = this;

        _G3Item.IsRecordRow = true;
        ControlsNS.BaseForm.call(_G3Item, parent, null, dataModel);

        _G3Item.IsNewRecord = isNewAdded;
        _G3Item.Items = null;


        _G3Item.IsRowHighlighted = ko.observable(false);
        _G3Item.selectedRowClick = function ()
        {
            for (var eachRow = 0; eachRow < _G3Item.ParentForm.Items().length; eachRow++)
            {
                _G3Item.ParentForm.ParentForm.G3.Items()[eachRow].IsRowHighlighted(false);
            }
            _G3Item.IsRowHighlighted(true);
        };

        _G3Item.D11 = new Object();
        _G3Item.D11.Options = ko.computed(function ()
        {
            var options = new Array();
            var root = this.ParentForm.ParentForm.ParentForm.ParentForm.G1;
            for (var eachRow = 0; eachRow < root.Items().length; eachRow++)
            {
                var obj = root.Items()[eachRow];
                options.push({ "optiontext": obj.T7.Value(), "optionvalue": obj.T7.Value() });
            }

            return options;
        }, _G3Item);
        _G3Item.D11.selectedOptions = ko.observable();
        _G3Item.D11.Value = ko.computed(function ()
        {
            if (!Utilities.IsUndefined(this.D11.selectedOptions()))
            {
                //                    alert(this.D11.selectedOptions());
                return this.D11.selectedOptions().optionvalue;
            }
            else
                return "";
        }, _G3Item);

        _G3Item.G4 = _G3Item.AddContainerControl("G4", "GridFoodExpense", G4Item, null);

        _G3Item.referralFoodExpenseTotal = ko.computed(function ()
        {
            var total = 0;
            for (var eachRow = 0; eachRow < this.G4.Items().length; eachRow++)
            {
                var objRow = this.G4.Items()[eachRow];
                total += Utilities.parseNumberValue(objRow.N1.Value());
            }
            return total;
        }, _G3Item);

        _G3Item.G5 = _G3Item.AddContainerControl("G5", "GridTravelExpense", G5Item, null);

        _G3Item.G5.AfterAddItem = function ()
        {
            var VerificationForm = parent.ParentForm;
            var total = 0;

            for (var eachRow = 0; eachRow < VerificationForm.G3.Items().length; eachRow++)
            {
                var obj = VerificationForm.G3.Items()[eachRow];
                total += obj.G5.Items().length;
            }

            if (total > 0)
            {
                VerificationForm.H1.Value("Number of Travel Expenses: " + total.toString(10));
            }
            else
            {
                VerificationForm.H1.Value("");
            }
        };

        _G3Item.referralTravelExpenseTotal = ko.computed(function ()
        {
            var total = 0;
            for (var eachRow = 0; eachRow < this.G5.Items().length; eachRow++)
            {
                var objRow = this.G5.Items()[eachRow];
                total += Utilities.parseNumberValue(objRow.N2.Value());
            }
            return total;
        }, _G3Item);

        if (dataModel != null)
        {
            _G3Item.D11.selectedOptions(ko.utils.arrayFirst(_G3Item.D11.Options(), function (item)
            {
                return item.optionvalue == dataModel.ReferralName;
            }));

            _G3Item.G4.DisableEvents = true;
            if (!Utilities.IsUndefined(dataModel.GridFoodExpense))
            {
                if (!Utilities.IsUndefined(dataModel.GridFoodExpense.length))
                {
                    for (var eachRow = 0; eachRow < dataModel.GridFoodExpense.length; eachRow++)
                    {
                        _G3Item.G4.AddItem(dataModel.GridFoodExpense[eachRow]);
                    }
                }
                else
                {
                    _G3Item.G4.AddItem(dataModel.GridFoodExpense);
                }
            }
            _G3Item.G4.DisableEvents = false;

            _G3Item.G5.DisableEvents = true;
            if (!Utilities.IsUndefined(dataModel.GridTravelExpense))
            {
                if (!Utilities.IsUndefined(dataModel.GridTravelExpense.length))
                {
                    for (var eachRow = 0; eachRow < dataModel.GridTravelExpense.length; eachRow++)
                    {
                        _G3Item.G5.AddItem(dataModel.GridTravelExpense[eachRow]);
                    }
                }
                else
                {
                    _G3Item.G5.AddItem(dataModel.GridTravelExpense);
                }
            }
            _G3Item.G5.DisableEvents = false;
        }

        _G3Item.getJSONObject = function ()
        {
            return {
                "ReferralName": _G3Item.D11.Value(),
                "GridFoodExpense": function ()
                {
                    var arr = new Array();
                    for (var eachRow = 0; eachRow < _G3Item.G4.Items().length; eachRow++)
                    {
                        var obj = _G3Item.G4.Items()[eachRow];
                        arr.push(obj.getJSONObject());
                    }
                    return arr;
                } (),
                "GridTravelExpense": function ()
                {
                    var arr = new Array();
                    for (var eachRow = 0; eachRow < _G3Item.G5.Items().length; eachRow++)
                    {
                        var obj = _G3Item.G5.Items()[eachRow];
                        arr.push(obj.getJSONObject());
                    }
                    return arr;
                } ()
            };
        };
    }

    Utilities.InheritClass(G3Item, ControlsNS.BaseForm);


    function G4Item(parent, dataModel, isNewAdded)
    {
        var _G4Item = this;

        _G4Item.IsRecordRow = true;
        ControlsNS.BaseForm.call(_G4Item, parent, null, dataModel);

        _G4Item.IsNewRecord = isNewAdded;
        _G4Item.Items = null;


        _G4Item.IsRowHighlighted = ko.observable(false);
        _G4Item.selectedRowClick = function ()
        {
            for (var eachRow = 0; eachRow < _G4Item.ParentForm.Items().length; eachRow++)
            {
                _G4Item.ParentForm.ParentForm.G4.Items()[eachRow].IsRowHighlighted(false);
            }
            _G4Item.IsRowHighlighted(true);
        };

        _G4Item.D12 = _G4Item.AddControl("D12", "Type");
        _G4Item.D12.Options = ko.observableArray([
                                            { optiontext: 'Select', optionvalue: "" },
                                            { optiontext: 'Breakfast', optionvalue: "1" },
                                            { optiontext: 'Lunch', optionvalue: "2" },
                                            { optiontext: 'Dinner', optionvalue: "3" }
                                         ]);
        _G4Item.D12.selectedOptions = ko.observable();
        _G4Item.D12.Value = ko.computed(function ()
        {
            if (!Utilities.IsUndefined(this.D12.selectedOptions()))
            {
                //                    alert(this.D12.selectedOptions());
                return this.D12.selectedOptions().optionvalue;
            }
            else
                return "";
        }, _G4Item);

        _G4Item.N1 = _G4Item.AddControl("N1", "Amount");
        _G4Item.N1.Value = ko.observable("");

        if (dataModel != null)
        {
            _G4Item.D12.selectedOptions(ko.utils.arrayFirst(_G4Item.D12.Options(), function (item)
            {
                return item.optionvalue == dataModel.Type;
            }));

            _G4Item.N1.Value(dataModel.Amount);
        }

        _G4Item.getJSONObject = function ()
        {
            return { "Type": _G4Item.D12.Value(), "Amount": _G4Item.N1.Value() };
        };
    }

    Utilities.InheritClass(G4Item, ControlsNS.BaseForm);


    function G5Item(parent, dataModel, isNewAdded)
    {
        var _G5Item = this;

        _G5Item.IsRecordRow = true;
        ControlsNS.BaseForm.call(_G5Item, parent, null, dataModel);

        _G5Item.IsNewRecord = isNewAdded;
        _G5Item.Items = null;


        _G5Item.IsRowHighlighted = ko.observable(false);
        _G5Item.selectedRowClick = function ()
        {
            for (var eachRow = 0; eachRow < _G5Item.ParentForm.Items().length; eachRow++)
            {
                _G5Item.ParentForm.ParentForm.G5.Items()[eachRow].IsRowHighlighted(false);
            }
            _G5Item.IsRowHighlighted(true);
        };

        _G5Item.D13 = _G5Item.AddControl("D13", "Type");
        _G5Item.D13.Options = ko.observableArray([
                                            { optiontext: 'Select', optionvalue: "" },
                                            { optiontext: 'Bus', optionvalue: "1" },
                                            { optiontext: 'Car', optionvalue: "2" },
                                            { optiontext: 'Auto', optionvalue: "3" }
                                         ]);
        _G5Item.D13.selectedOptions = ko.observable();
        _G5Item.D13.Value = ko.computed(function ()
        {
            if (!Utilities.IsUndefined(this.D13.selectedOptions()))
            {
                //                    alert(this.D13.selectedOptions());
                return this.D13.selectedOptions().optionvalue;
            }
            else
                return "";
        }, _G5Item);

        _G5Item.N2 = _G5Item.AddControl("N2", "Amount");
        _G5Item.N2.Value = ko.observable("");

        if (dataModel != null)
        {
            _G5Item.D13.selectedOptions(ko.utils.arrayFirst(_G5Item.D13.Options(), function (item)
            {
                return item.optionvalue == dataModel.Type;
            }));

            _G5Item.N2.Value(dataModel.Amount);
        }

        _G5Item.getJSONObject = function ()
        {
            return { "Type": _G5Item.D13.Value(), "Amount": _G5Item.N2.Value() };
        };
    }

    Utilities.InheritClass(G5Item, ControlsNS.BaseForm);


    var xmlString = "<PassportForm><ApplyingFor>2</ApplyingFor><ReasonsForReissue>1;3</ReasonsForReissue><ReasonForChangeInPersonalParticulars>1</ReasonForChangeInPersonalParticulars><OtherReasons></OtherReasons><ValidityRequired>1</ValidityRequired><Surname>Sm;\'\"ith</Surname><DateOfBirth>2012-09-01</DateOfBirth><Gender>1</Gender><MaritalStatus>3</MaritalStatus><CitizenshipOfIndiaBy>3</CitizenshipOfIndiaBy><Pan>ABCD1111E</Pan><VoterID>XYZ222A</VoterID><EmploymentType>5</EmploymentType><ParentOrSpouseInGovermentService>1</ParentOrSpouseInGovermentService><EducationalQualification>4</EducationalQualification><EligibleForNonECRCategory>1</EligibleForNonECRCategory><VisibleDistinguishingMark>Mole on chin</VisibleDistinguishingMark><ApplicationType>2</ApplicationType><PassportBookletType>2</PassportBookletType><ApplicantsGivenName>John</ApplicantsGivenName><City>Bangalore</City><Country>1</Country><OrganisationName>Johns Line</OrganisationName><ReferenceGrid><Name>Jack</Name><Email>jack@email.com</Email><Relation>1</Relation><Gender>1</Gender></ReferenceGrid><ReferenceGrid><Name>Rose</Name><Email>rose@email.com</Email><Relation>2</Relation><Gender>2</Gender></ReferenceGrid><ReferenceGrid><Name>Jane</Name><Email>jane@email.com</Email><Relation>2</Relation><Gender>2</Gender></ReferenceGrid><ReferenceGrid><Name>Daniel</Name><Email>daniel@email.com</Email><Relation>1</Relation><Gender>1</Gender></ReferenceGrid><GridVerification><VerificationDate>2012-09-05</VerificationDate><GridVerificationExpense><ReferralName>Jack</ReferralName><GridFoodExpense><Type>1</Type><Amount>10</Amount></GridFoodExpense><GridFoodExpense><Type>2</Type><Amount>20</Amount></GridFoodExpense><GridTravelExpense><Type>1</Type><Amount>15</Amount></GridTravelExpense><GridTravelExpense><Type>3</Type><Amount>25</Amount></GridTravelExpense></GridVerificationExpense><GridVerificationExpense><ReferralName>Rose</ReferralName><GridFoodExpense><Type>3</Type><Amount>30</Amount></GridFoodExpense><GridTravelExpense><Type>2</Type><Amount>35</Amount></GridTravelExpense></GridVerificationExpense><VerificationTotal>135</VerificationTotal></GridVerification><GridVerification><VerificationDate>2012-09-06</VerificationDate><GridVerificationExpense><ReferralName>Jane</ReferralName><GridFoodExpense><Type>1</Type><Amount>40</Amount></GridFoodExpense><GridTravelExpense><Type>1</Type><Amount>45</Amount></GridTravelExpense></GridVerificationExpense><GridVerificationExpense><ReferralName>Daniel</ReferralName><GridFoodExpense><Type>2</Type><Amount>50</Amount></GridFoodExpense><GridFoodExpense><Type>3</Type><Amount>60</Amount></GridFoodExpense><GridTravelExpense><Type>3</Type><Amount>55</Amount></GridTravelExpense><GridTravelExpense><Type>2</Type><Amount>65</Amount></GridTravelExpense></GridVerificationExpense><VerificationTotal>315</VerificationTotal></GridVerification><VerificationExpenseGrandTotal>450</VerificationExpenseGrandTotal></PassportForm>";

    var passportDataModel = Utilities.GetJSONObjectFromXml(xmlString);

    ko.applyBindings(new AppViewModel(passportDataModel));


})();


//var testStrings = ["Control.Value('ee'); Control.Enable(Control.FindById('dd').Value('dd') ? 'dd':'ss'); //INVALID syntax, but passes, needs to be handled for ? symbol in the jshint code."];

var testStrings = [
//////////                    "var abc = Control.FindById('t1').Value; //INVALID syntax",
//////////                    "var abc = Control.FindById('t1').Value(); //valid syntax",
//////////                    "var abc = Control.Value; //INVALID syntax",
//////////                    "var abc = Control.Value(); //valid syntax",
//////////                    "var abc = Control.FindByName; //INVALID syntax",
//////////                    "var abc = Control.FindByName('t2'); //valid syntax",
//////////                    "var abc = Control.Enable; //INVALID syntax",
//////////                    "var abc = Control.Enable(); //valid syntax",
//////////                    "var abc = Control.FindByName(); //INVALID syntax",
//////////                    "var abc = Control.FindByName('t2'); \n abc.Enable = 2; //INVALID syntax",
//////////                    "var abc = Control.FindByName('t2'); \n abc.Enable(2); \n abc = Control.FindById('t2'); \n abc.Value = 'value'; //INVALID syntax",
////////                    "var abc; \n abc = Control.FindByName('t2'); \n abc.Enable = 2; //INVALID syntax",
////////                    "var abc; \n abc = Control.FindByName('t2'); \n abc.Enable(2); //valid syntax",
////////                    "var abc; \n abc = Control.FindByName('t2'); \n abc.Enable(2); \n abc = Control.FindById('t3'); \n abc.Value = 'value';//INVALID syntax",
////////                    "var abc; \n abc = Control.FindByName('t2'); \n abc.Enable(2); \n abc = Control.FindById('t3'); \n abc.Value('value');//valid syntax",
////////                    "var abc; \n abc = Control.FindByName('t2'); \n abc.Enable(2); \n abc = 'anz'; \n abc.Value = 'value';//valid syntax",
////////                    "var abc = Control.FindByName('t2'); \n abc.Enable = 2; //INVALID syntax",
////////                    "var abc = Control.FindByName('t2'); \n abc.Enable(2); //valid syntax",
////////                    "var abc = Control.FindByName('t2'); \n abc.Enable(2); \n abc = Control.FindById('t3'); \n abc.Value = 'value';//INVALID syntax",
////////                    "var abc = Control.FindByName('t2'); \n abc.Enable(2); \n abc = Control.FindById('t3'); \n abc.Value('value');//valid syntax",
////////                    "var abc = Control.FindByName('t2'); \n abc.Enable(2); \n abc = 'anz'; \n abc.Value = 'value';//valid syntax",
////////                    "var abc = Control.FindByName('t2'); \n abc.Enable = 2; \n abc = 'anz'; \n abc.Value = 'value';//INVALID syntax",
//////                    "Control.Value(); //INVALID syntax",
//////                    "Control.Value('tt'); //valid syntax",
//////                    "Control.Value('tt',112); //INVALID syntax",
//////                    "var abc = Control.Value('qq'); //INVALID syntax",
//////                    "var abc = Control.Value(); //valid syntax",
//////                    "var abc = Control.Value() + Control.Enable(); //valid syntax",
//////                    "var abc = Control.Value() + Control.Enable('dd'); //INVALID syntax",
////                    "Control.Value(Control.Enable()); //valid syntax",
////                    "Control.Value(Control.Enable('dd')); //INVALID syntax",
////                    "Control.Value('ee'); Control.Enable('dd'); Control.Visible(Control.Value()); //valid syntax",
////                    "Control.Value('ee'); Control.Enable('dd'); Control.Visible(Control.Value('ds')); //INVALID syntax",
////                    "Control.Value('ee'); Control.Enable('dd'); Control.FindById('ds').Value('dd'); //valid syntax",
////                    "Control.Value('ee'); Control.Enable(Control.FindById('ds').Value('dd')); //INVALID syntax",
////                    "Control.Value('ee'); Control.Enable(Control.FindById('dd').Value()); //valid syntax",
////                    "Control.Value('ee'); Control.Enable(Control.FindById('dd').Value() ? 'dd':'ss'); //valid syntax",
//                    "Control.Value('ee'); Control.Enable(Control.FindById('dd').Value('dd') ? 'dd':'ss'); //INVALID syntax, but passes, needs to be handled for ? ternary operator in the jshint code.",
//                    "var a = Control.FindById('t1'); b = a; c = b; d = c; d.Value('sss'); //valid syntax",
//                    "var a = Control.FindById('t1'); b = a; c = b; d = c; d.Value(); //INVALID syntax, but passes, needs to be handled.",
//                    "switch(Control.Value('ee')){ case 1: alert('ddd'); } //INVALID syntax",
//                    "switch(Control.Value){ case 1: alert('ddd'); } //INVALID syntax",
//                    "switch(Control.Value()){ case 1: alert('ddd'); break; case 2: alert('eee'); } //valid syntax",
//                    "switch(11){ case Control.Value('ee'): alert('ddd'); } //INVALID syntax",
//                    "switch(11){ case Control.Value: alert('ddd'); } //INVALID syntax",
//                    "switch(11){ case Control.Value(): alert('ddd'); break; case 2: alert('eee'); } //valid syntax",
//                    "switch(11){ case 1: Control.Value(); } //INVALID syntax",
//                    "switch(11){ case 2: Control.Value(1,2); } //INVALID syntax",
//                    "switch(11){ case 3: Control.Value(1); break; case 2: alert('eee'); } //valid syntax",
//                    "switch(Control.FindById.Value()){ \n case Control.FindById('t2').Value(): \n Control.Value(1); break; \n case 2: \n Control.FindById('t3').Value(3); \n } //INVALID syntax",
//                    "switch(Control.FindById('t1').Value()){ \n case Control.FindById.Value(): \n Control.Value(1); break; \n case 2: \n Control.FindById('t3').Value(3); \n } //INVALID syntax",
//                    "switch(Control.FindById('t1').Value()){ \n case Control.FindById('t2').Value(): \n Control.Value(1); break; \n case 2: \n Control.FindById.Value(3); \n } //INVALID syntax",
//                    "switch(Control.FindById('t1').Value()){ \n case Control.FindById('t2').Value(): \n Control.Value(1); break; \n case 2: \n Control.FindById('t3').Value(3); \n } //valid syntax",
                    "Control.FindById('ww').Value().Value('33'); //INVALID syntax, but passes, for such scenarios we should have the control context to check",
                    "Control.FindById('ww').Value('33').Value('33'); //INVALID syntax, but passes",
                    "abc = Control.FindByName('t2'); \n abc.Enable = 2; //INVALID syntax, but passes, here we have not used var statement for the variable"
                  ];

for (var i in testStrings) {
    var str = testStrings[i];
    var re = JSHINT(str, "", "");
    debugger;
    var displayStr = "Test string:\n\n" + str + "\n\n\tresult: " + re + "\n\n\terror:\n";
    if (JSHINT.errors && JSHINT.errors.length > 0) {
        displayStr += JSHINT.errors[0].reason +
            "\n\t at line " + JSHINT.errors[0].line + ", character " + JSHINT.errors[0].character +
            " in below code -\n" + JSHINT.errors[0].evidence;
    }
    else {
        displayStr += "no details available";
    }
    alert(displayStr);
}

//var re = JSHINT("var abc = Control.FindById('t1'); \nabc.Value=1;\nabc='abc string';", "", "");
//var re = JSHINT("var abc = Control.FindById('t1'); \nabc.Value=1;\nabc='abc string';", "", "");
//var re = JSHINT("var abc = Control.FindById('t1'); \nabc.Value=1;\nabc='abc string';", "", "");

//alert(re);
