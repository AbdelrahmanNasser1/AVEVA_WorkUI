/** BaseGrid Configuration File
*   Configuration Name : BaseGrid_SampleData
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
                    if (validationResult == false) {
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

        //adding drop down
        widgetObject.baseGrid.categoryDropDownEditor = function (container, options) {
            $('<input required name="' + options.field + '"/>')
                .appendTo(container)
                .kendoDropDownList({
                    autoBind: false,
                    dataTextField: "comment",
                    dataValueField: "comment",
                    dataSource: {
                        transport: {
                            read: function (options) {
                                var testCatData = [{
                                    "comment_id": 1,
                                    "comment": "Positive2",
                                }, {
                                    "comment_id": 2,
                                    "comment": "Neutral2",
                                }, {
                                    "comment_id": 3,
                                    "comment": "Negative2",
                                }];
                                options.success(testCatData);
                            }
                        }
                    }
                });
        }

        var conf = {
            widgetTitle: WW_localize("@@WidgetBaseGridWidgetTitle@@"),
            dataSource: {
                transport: {
                    read: widgetObject.baseGrid.dataSourceRead,
                    update: widgetObject.baseGrid.dataSourceUpdate,
                },
                change: widgetObject.baseGrid.dataSourceChange,
                //Enable default sorting
                sort: [{ field: "uom_id", dir: "desc" }],
                // section for cell datatypes and input field.
                schema: {
                    model: {
                        id: "uom_id",
                         //Field names with datatypes are specified here
                        fields: {
                            uom_id: { type: "number", editable: false },
                            description: {
                                editable: true,
                                defaultValue: "",
                                validation: {
                                    required: true,
                                    maxlength: "10",
                                }
                            },
                            period1: { type: "string", editable: true },
                            period: { type: "string", editable: true },
                            CategoryID: {
                                editable: true,
                                field: "CategoryID",
                            },
                            oper_id: { type: "string", editable: false },
                            canSchedJobs: { type: "boolean", editable: true },
                            seq_no: { type: "number", defaultValue: 0, editable: true, validation: { required: true, min: 0 } },
                            state_desc: { editable: false },
                            color: { type: "number" },
                            req_qty: { type: "number", editable: true },
                            qty_prod: { editable: true },
                            last_edit_comment: { type: "string" },
                            req_finish_time: {
                                type: "date", editable: true, validation: {
                                    required: true,
                                }
                            }
                        }
                    }
                },
                filterable: true,
            },
            // Columns
            //Column names,title,template are specified here
            columns: [{
                field: "uom_id",
                title: "Id",
                width: '180px',
            },
            {
                field: "description",
                template: "<span title='#:kendo.toString(data.description, \"n4\")#'>#:description#</span>"
            },


            {
                field: "oper_id",
                title: "Operation",

            }, {
                field: "seq_no",
                title: "Seq No",
                attributes: { class: "number" }

            },
            {
                field: "canSchedJobs",
                title: "canSchedJobs",
                //boolean field
                template: "#=(canSchedJobs === true) ? 'Yes' : 'No'#",
            },
            {
                field: "state_desc",
                title: "State_Desc",
                //column background color
                attributes: {
                    style: "background-color: green",
                },
            },
            {
                field: "color",
                title: "Color",
                attributes: { class: "number" }
            },
            {
                field: "hex", // Custom calculation column added in dataBinding event
                title: "Hexadecimal (RGB)"
            }, {
                field: "req_qty",
                title: "Req Qty",
                attributes: { class: "number" },
                editor: weightEditor,
                template: function (dataItem) {
                    return widgetObject.baseGrid.formattedNumber(dataItem.req_qty, 3);
                }

            }, {
                field: "qty_prod",
                title: "Qty Prod",
                //progress bar
                template: "<div class='progress'  style='width: 100%;'></div>"
            }, {
                field: "last_edit_comment",
                title: "Comment",
                editor: widgetObject.baseGrid.categoryDropDownEditor,
                //dropdown
                template: function (dataItem) {

                    if (typeof (dataItem.last_edit_comment) == 'undefined')
                        dataItem.last_edit_comment = "";

                    return dataItem.last_edit_comment;
                }

            },
            {
                field: "req_finish_time", title: "Req Finish Time", format: "{0:dd MMM yyyy HH:mm:tt}", width: '250px',
                //adding Datetime picker
                editor: function (container, options) {
                    var input = $("<input/>");
                    input.attr("name", options.field);
                    input.appendTo(container);
                    input.kendoDateTimePicker({});
                },
                template: function (dataItem) {
                    return widgetObject.baseGrid.formattedDateTime(dataItem.req_finish_time);

                }
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
            dataBinding: widgetObject.baseGrid.dataBinding,
			cellClose:widgetObject.baseGrid.cellClose,
			dataBound: function (e) {
                widgetObject.baseGrid.dataBound(e, "widgetObject.baseGrid.dataBound");
                var grid = this;
                //adding progress bar
                grid.tbody.find(".progress").each(function (e) {
                    var row = $(this).closest("tr");
                    var model = grid.dataItem(row);
                    $(this).kendoProgressBar({
                        max: model.req_qty,
                        value: model.qty_prod,
                        change: function (e) {
                            e.progressWrapper.css({
                                "background-color": "green",
                                "border-color": "blue"
                            });
                        }
                    });

                });
            }
        }; // End Grid Configuration	

		widgetObject.baseGrid.editCallback =  function (e) {
			console.log("widgetObject.baseGrid.editCallback");
                var grid = this;
                var row = e.container.closest("tr");

                e.container.find("input[name='qty_prod']").blur(function () {
                    setTimeout(function () {
                        var model = grid.dataItem(row);
                        row.find(".progress").kendoProgressBar({
                            max: model.req_qty,
                            value: model.qty_prod
                        });
                    });
                });
            }		
        return conf;
    }

   

    var testData = [{
        "uom_id": 1,
        "description": "Pieces",
        "oper_id": "Filling",
        "canSchedJobs": true,
        "seq_no": 0,
        "state_desc": "NEW",
        "color": 16776960,
        "req_qty": 300000000,
        "qty_prod": 100,
        "last_edit_comment": "",
        "req_finish_time": "2014-02-10T15:20:08Z"
    }, {
        "uom_id": 2,
        "description": "Gram",
        "oper_id": "Filling",
        "canSchedJobs": true,
        "seq_no": 0,
        "state_desc": "READY",
        "color": 65535,
        "req_qty": 600,
        "qty_prod": 300,
        "last_edit_comment": "",
        "req_finish_time": "2014-02-13T15:20:08Z"
    }, {
        "uom_id": 3,
        "description": "Count",
        "oper_id": "Filling",
        "canSchedJobs": false,
        "seq_no": 0,
        "state_desc": "RUNNING",
        "color": 65280,
        "req_qty": 800,
        "qty_prod": 500,
        "last_edit_comment": "",
        "req_finish_time": "2014-02-12T15:20:08Z"
    }];

    // To limit number of decimal places during editing
    function weightEditor(container, options) {
        $('<input name="' + options.field + '"/>')
            .appendTo(container)
            .kendoNumericTextBox({
                decimals: 3,
            })
    };

    //Widget config name
    if (typeof (window.conf) === 'undefined')
        window.conf = {};

    if (typeof (window.conf['BaseGrid_SampleData']) === 'undefined') {
        window.conf['BaseGrid_SampleData'] = getConf;
    }

    if (typeof (window.conf['BaseGrid_SampleData_testdata']) === 'undefined') {
        window.conf['BaseGrid_SampleData_testdata'] = testData;
    }

})();