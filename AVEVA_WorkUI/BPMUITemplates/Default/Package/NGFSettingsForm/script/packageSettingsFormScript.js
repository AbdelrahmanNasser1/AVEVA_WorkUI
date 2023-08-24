// global namespace
var PackageScript = PackageScript || {};

// Create container called Prerequisite.
PackageScript.Prerequisite = {
    HidePrerequisiteDeleteIcon: function (control) {
        //hide grid delete icon
        $(".pkgPreReqGrid_skcdo").show();
        var prerequisiteGrid = control.findById("PrerequisitePackageTemplatesGrid");
        if (prerequisiteGrid.records().length === 1) {
            $(".pkgPreReqGrid_skcdo").hide();
            var eachRow = prerequisiteGrid.records()[0];
            if (eachRow.topLevelForm.dataModel) {
                if (eachRow.topLevelForm.dataModel["SKRootDefinition"]) {
                    var formDataModel = eachRow.topLevelForm.dataModel["SKRootDefinition"]["PrerequisitePackageTemplates"];
                    if (formDataModel) {
                        var pName = formDataModel["Name"];
                        var pVersion = formDataModel["Version"];
                        if (!(pName === '' && pVersion === '')) {
                            $(".pkgPreReqGrid_skcdo").show();
                        }
                    }
                }
            }
        }
    }
}

// Create container called Forms.
PackageScript.Forms = {
    IsFormsNavigateToGridVisable: function (control) {
        if (control.findById("T1").Tabs()[2].isSelected()) {
            return false;
        } else {
            var rowCount = control.records().length;
            if (rowCount > 0) {
                var eachRow = control.records()[0];
                if (eachRow.findById('sys_btn_nav_ButtonId').value === '') {
                    return false;
                } else {
                    return true;
                }
            } else {
                return false;
            }
        }
    }
}

PackageScript.VisibleGridBasedOnControlName = {
    ShowOnInstallUpdateHideOnUninstall: function (control, hiddenControlId, gridName) {
        var selection = control.findById("T1");
        if ((selection !== null) &&
            (selection.Tabs()[2].isSelected() !== true) &&
            (control.findById(hiddenControlId).value === gridName)
        ) {
            return true;
        }

        return false;
    }
}

PackageScript.VisibleGrid = {
    ShowOnInstallUpdate: function (control) {
        var selection = control.findById("T1");
        if ((selection !== null) &&
            (selection.Tabs()[2].isSelected() !== true)
        ) {
            return true;
        }
    }
}

// Create separate container for Validation
PackageScript.Validation = {
    PackageValidateCSScript: function (val) {
        var htmlRegex = new RegExp("<([A-Za-z][A-Za-z0-9]*)\\b[^>]*>(.*?)<\/\\1>");
        if (htmlRegex.test(val)) {
            return new ValidationOptions(false, skelta.localize.getString("ScriptValidation_Message"));
        }
        else {
            return new ValidationOptions(true, "");
        }
    }
}
