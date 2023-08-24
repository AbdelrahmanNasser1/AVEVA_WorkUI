/** BaseGrid Configuration File
*   Configuration Name : BaseGrid_Lookup
*	Version : 1.1
*
*	Ver		Date		Comment
*	1.0		25-Feb-22	Initial version
*	1.1		15-Apr-22	BaseGrid Lookup config
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
            if (notifyobj != null && notifyobj.Functionname != null) {
                functionName = notifyobj.Functionname.toUpperCase();
            }
            switch (functionName) {
                case "EXPORT":
                    if (notifyobj.Filetype != null) {
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
				myConf.UseData = true;
                grid.dataSource.read();
            }
        });

        var conf = {
            widgetTitle: WW_localize("@@WidgetBaseGridWidgetTitle@@"),
            dataSource: {
                transport: {
                    read: widgetObject.baseGrid.dataSourceRead,
                    create: widgetObject.baseGrid.dataSourceCreate,
                    update: widgetObject.baseGrid.dataSourceUpdate,
                },
                change: widgetObject.baseGrid.dataSourceChange,
                // Enable default sorting.
                sort: [{ field: "uom_id", dir: "desc" }],
                schema: {
                    model: {
                        id: "uom_id",
                        fields: {
                            //Field names from Lookup/WebAPI with datatypes are specified here
                            uom_id: { type: "number", editable: true },
                            description: { type: "string", editable: true },
                            abbreviation: {
                                type: "string", editable: true, validation: { required: true },
                            },
                            last_edit_comment: { type: "string", editable: true },
                            last_edit_by: { type: "string", editable: true },
                            last_edit_at: { type: "date", editable: true }
                        }
                    }
                }
            },
            // Columns
             //Column names from Lookup/WebAPI,title,template are specified here
            columns: [{
                field: "uom_id",
                title: "uom_id",
                width: '300px'
            },
            {
                field: "description",
                title: "description",
                //Sample template to show Tooltip for a column.
                template: "<span title='#:kendo.toString(data.description, \"n4\")#'>#:description#</span>"
            },
            {
                field: "abbreviation",
                title: "abbreviation"
            },
            {
                field: "last_edit_at",
                title: "last_edit_at",
                format: "{0:dd MMM yyyy HH:mm:tt}",
                width: '250px',
                //adding Datetime picker
                editor: function (container, options) {
                    var input = $("<input/>");
                    input.attr("name", options.field);
                    input.appendTo(container);
                    input.kendoDateTimePicker({});
                },
                template: function (dataItem) {
                    return widgetObject.baseGrid.formattedDateTime(dataItem.last_edit_at);

                }
            },
            {
                field: "last_edit_comment",
                title: "last_edit_comment"

            },
            {
                field: "last_edit_by",
                title: "last_edit_by"
            },

            ],

            // Options
            noRecords: true,
            filterable: {
                extra: false, //do not show extra filters
            },
            //filter: { field: "description",operator: "startswith",	value:"g"},
            resizable: true,
            sortable: true,
            editable: true,
            selectable: true,
            persistSelection: true,
            pageable: {
                pageSize: 10
            },
            // Events

            beforeEdit: widgetObject.baseGrid.beforeEdit,
            change: widgetObject.baseGrid.change,
            edit: widgetObject.baseGrid.edit,
            cancel: widgetObject.baseGrid.cancel,
            remove: widgetObject.baseGrid.remove,
            save: widgetObject.baseGrid.save,
            saveChanges: widgetObject.baseGrid.saveChanges,
            cellClose: widgetObject.baseGrid.cellClose,
            dataBinding: widgetObject.baseGrid.dataBinding
        }; // End Grid Configuration
		widgetObject.baseGrid.editCallback =  function (e) {}
        return conf;
    }

    var testData = [{
        "uom_id": 1,
        "description": "Pieces",
        "abbreviation": "abbr",
        "last_edit_by": "FactAdmin",
        "last_edit_at": "2014-02-10T15:20:08Z"

    }, {
        "uom_id": 2,
        "description": "Kgs",
        "abbreviation": "abbr1",
        "last_edit_by": "FactAdmin",
        "last_edit_at": "2014-02-10T15:20:08Z"

    }, {
        "uom_id": 3,
        "description": "Pieces",
        "abbreviation": "abbr2",
        "last_edit_by": "FactAdmin",
        "last_edit_at": "2014-02-10T15:20:08Z"
    }, {
        "uom_id": 4,
        "description": "Gram",
        "abbreviation": "abbr3",
        "last_edit_by": "FactAdmin",
        "last_edit_at": "2014-02-10T15:20:08Z"
    }, {
        "uom_id": 5,
         "description": "Kgs",
        "abbreviation": "abbr4",
        "last_edit_by": "FactAdmin",
        "last_edit_at": "2014-02-10T15:20:08Z"
    }, {
        "uom_id": 6,
        "description": "Pieces",
        "abbreviation": "abbr5",
        "last_edit_by": "FactAdmin",
        "last_edit_at": "2014-02-10T15:20:08Z"
    }, {
        "uom_id": 7,
        "description": "Pieces",
        "abbreviation": "abbr6",
        "last_edit_by": "FactAdmin",
        "last_edit_at": "2014-02-10T15:20:08Z"
    }, {
        "uom_id": 8,
        "description": "Pieces",
        "abbreviation": "abbr7",
        "last_edit_by": "FactAdmin",
        "last_edit_at": "2014-02-10T15:20:08Z"
    }, {
        "uom_id": 9,
        "description": "Gram",
        "abbreviation": "abbr8",
        "last_edit_by": "FactAdmin",
        "last_edit_at": "2014-02-10T15:20:08Z"
    }];

    //Widget config name
    if (typeof (window.conf) === 'undefined')
        window.conf = {};

    if (typeof (window.conf['BaseGrid_Lookup']) === 'undefined') {
        window.conf['BaseGrid_Lookup'] = getConf;
    }

    if (typeof (window.conf['BaseGrid_Lookup_testdata']) === 'undefined') {
        window.conf['BaseGrid_Lookup_testdata'] = testData;
    }

})();