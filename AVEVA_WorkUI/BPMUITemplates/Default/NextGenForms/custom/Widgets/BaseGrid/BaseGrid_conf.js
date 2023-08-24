/** BaseGrid Configuration File
*   Configuration Name : BaseGrid
*	Version : 1.1
*
*	Ver		Date		Comment
*	1.0		25-Feb-22	Initial version
*	1.1		15-Apr-22	BaseGrid config
**/
(function () {

    var getConf = function (confName, widgetObject, cwidget, myConf) {
        if (typeof (window.conf) === 'undefined')
            window.conf = {};

        //Config file name 
        cwidget.on("confName", function () {
            if (myConf.confName != cwidget.confName) {
                var gridChildren = $(widgetObject.baseGrid.domElement).children();
                var gridChildrenData = $(widgetObject.baseGrid.domElement).children("#kendogrid").data("kendoGrid");
                myConf.confName = cwidget.confName;
                widgetObject.baseGrid.init(gridChildren, gridChildrenData);
            }
        });

        //notify operations
        cwidget.on("notify", function () {
            var notifyobj;
            var grid = $(widgetObject.baseGrid.domElement).children("#kendogrid").data("kendoGrid");
            try {
                notifyobj = JSON.parse(cwidget.notify);
            }
            catch (ex) {
                //alert(WW_localize("@@WidgetBaseGridErrorParsingNotify@@") + ex);
                console.log(WW_localize("@@WidgetBaseGridErrorParsingNotify@@") + ex);
                return;
            }
            var functionName = "";
            var fileType = "";
            var field = "";
            var operator = "";
            var value = "";
            var validationResult = false;
            if (notifyobj != null && notifyobj.Functionname != null)
            {
                functionName = notifyobj.Functionname.toUpperCase();
            }
            switch (functionName) {
                case "EXPORT":
                    if (notifyobj.Filetype != null)
                    {
                        fileType = notifyobj.Filetype.toUpperCase();
                    }
                    if (fileType == "PDF") {
                        grid.saveAsPDF();
                    }
                    else if (fileType == "EXCEL") {
                        grid.saveAsExcel();
                    }
                    break;
                case "RESETSORTORDER":
                    grid.dataSource.sort({});
                    break;
                case "CLEARFILTER":
                    grid.dataSource.filter({});
                    break;
                case "FILTER":
                    field = notifyobj.field;
                    operator = notifyobj.operator;
                    value = notifyobj.value;
                    grid.dataSource.filter({
                        "field": field,
                        "operator": operator,
                        "value": value
                    });
                    grid.dataSource.read();
                    break;
                case "VALIDATE":
                    validationResult = notifyobj.result;
                    if (validationResult == false){
                        widgetObject.baseGrid.HandleValidationResult();
                    }
                    break;
            }
        });

        // data property
        cwidget.on("data", function () {
            var grid = $(widgetObject.baseGrid.domElement).children("#kendogrid").data("kendoGrid");
            if (cwidget.data !== "") {
				myConf.useData = true;
                grid.dataSource.read();

            }
        });

        var conf = {
            widgetTitle: WW_localize("@@WidgetBaseGridWidgetTitle@@"),
            dataSource: {
                transport: {
                    read: widgetObject.baseGrid.dataSourceRead,
                    update: widgetObject.baseGrid.dataSourceUpdate,
                },
                change: widgetObject.baseGrid.dataSourceChange,
                // section for cell datatypes and input field.
                schema: {
                    model: {
                        id: "column1",
                        //Field names with datatypes are specified here
                        fields: {
                            column1: { type: "number", editable: false },
                            column2: { editable: true},
                            column3: { editable: true, field: "column3"},
                            column4: { type: "string", editable: false },
                            column5: { type: "boolean",editable: true },
                            column6: { type: "number", editable: true },
                            column7: { editable: false },
                            column8: { type: "number" },
                            column9: { type: "number", editable: true },
                            column10: { editable: true },
                            column11: { type: "string" },
                            column12: { type: "date", editable: true}
                        }
                    }
                },
                filterable: true,
            },
            // Columns
            //Column names,title,template are specified here
            columns: [{
                field: "column1",
                title: "column1"
            },
            {
                field: "column2",
                title: "column2"
            },
            {
                field: "column3",
                title: "column3"

            }, {
                field: "column4",
                title: "column4"
            },
            {
                field: "column5",
                title: "column5"
            },
            {
                field: "column6",
                title: "column6"
            },
            {
                field: "column7",
                title: "column7"
            },
            {
                field: "column8",
                title: "column8"
            },
            {
                field: "column9",
                title: "column9"
            },
            {
                field: "column10",
                title: "column10"
            },
            {
                field: "column11",
                title: "column11"
            },
            {
                field: "column12",
                title: "column12"
            }],
            // Options
            noRecords: true,
            filterable: {
                extra: false, //do not show extra filters
            },
            resizable: true,
            sortable: {
                mode: "multiple",
                allowUnsort: true,
                showIndexes: true
            },
            editable: true,
            selectable: true,
            scrollable: true,
            persistSelection: true,
            pageable: {
                pageSize: 7,
                position: "bottom",
                responsive: true
            },
            // Events
            cellClick: "onCellClick($event)",
            dblclick: "onDblClick()",
            beforeEdit: widgetObject.baseGrid.beforeEdit,
            change: widgetObject.baseGrid.change,
            edit: widgetObject.baseGrid.edit,
            cancel: widgetObject.baseGrid.cancel,
            remove: widgetObject.baseGrid.remove,
            save: widgetObject.baseGrid.save,
            search: widgetObject.baseGrid.search,
            saveChanges: widgetObject.baseGrid.saveChanges,
            cellClose: widgetObject.baseGrid.cellClose,
            dataBinding: widgetObject.baseGrid.dataBinding
        }; // End Grid Configuration
		widgetObject.baseGrid.editCallback =  function (e) {}
        return conf;
    }

    //Widget config name
    if (typeof (window.conf) === 'undefined')
        window.conf = {};

    if (typeof (window.conf['BaseGrid']) === 'undefined') {
        window.conf['BaseGrid'] = getConf;
    }

})();