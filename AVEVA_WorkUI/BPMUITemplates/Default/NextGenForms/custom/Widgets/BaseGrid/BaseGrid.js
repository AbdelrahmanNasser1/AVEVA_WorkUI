/*! Release Version of Widget v"1.1.0.16" */ 
(function(){
	
	// Set manual configuration
	var myConf={};
	myConf.widgetName="./";
	myConf.confName="BaseGrid";
	myConf.divId="#myGrid4";
	myConf.widgetClass=".k-grid";
	myConf.UseData = false;
	myConf.oldColumnName="";
	myConf.oldColumnValue="";
	myConf.manualsetdata = "";
	myConf.isDirtyAlready = false;
	
	var cwidget = WW_getNewCwidget(cwidget,myConf);
		
	// Create a mdm.baseGrid object to contain functions and data
	var mdm = mdm || {};
	mdm.baseGrid = mdm.baseGrid || {};

	/**
	* Save the domElement
	*/
	if (!WW_isUndefinedOrNull(window.getDivId))
	{
		// if WT proxy exists get dynamic divId, if not existing manual divId used
		var $domElement = $(window.getDivId(cwidget, myConf.divId));
		mdm.baseGrid.domElement = $domElement.length > 0 ? $domElement[0] : null;
	}
	else
	{
		mdm.baseGrid.domElement = cwidget.domElement;
	}

	cwidget.destroyWidget = function() {
		
		// This would take care of clearing internal subscriptions and events.
		cwidget.destroy();

		// destroy other events and subscriptions if any
		mdm.baseGrid.destroyWidget();
	};


	/**
	 * Initialization function for custom kendoGrid and SkeltaGrid
	 */
	mdm.baseGrid.init = function(gridChildren,gridChildrenData) {
		
		mdm.baseGrid.createCustomGrid(gridChildren, gridChildrenData);

		// call onInitialize.
		// cwidget.dispatchEvent('onInitialize'); //dispatchEvent is not ready
		cwidget.onInitialize = "";

	};

	/**
	 * Creates the custom kendoGrid
	 */
	mdm.baseGrid.createCustomGrid = function(gridChildren,gridChildrenData) {
	  lastCell=null;
	  
		/**
		* Function to get the correct cwidget object for the calling kendogrid
		*/
		BaseGrid_getCwidget = function(event){
			gridDivId="";
			if(typeof(window.cwidgets)!=='undefined'){
				let m_cwidget={};
				var gridElement = $(event.srcElement).parents(".k-grid");
				if(gridElement.length>0)
					gridDivId=gridElement[0].id;

				if(gridDivId!==""){
					if(typeof(window.cwidgets[gridDivId])!=='undefined')
						m_cwidget= window.cwidgets[gridDivId];	
				}
				return m_cwidget;
			}
			else
				return cwidget;
		}
  
		/**
		* get configuration from config array
		**/
		
         gridConf = WW_getMyConf(mdm, cwidget, myConf);
         if (gridConf != null) {
             if (gridChildrenData != null && gridChildren != null) {
                 gridChildrenData.destroy();
                 gridChildren.remove();
             }
             mdm.baseGrid.validateAndCorrect(gridConf);
         }
         else {
             alert(WW_localize('@@WidgetBaseGridErrorLoadingConfiguration@@'));
             return;
         }
         var strTitle = "";

         if (gridConf.hasOwnProperty("widgetTitle")) {
             strTitle = gridConf["widgetTitle"];
         }
         $(mdm.baseGrid.domElement).append("<span id= 'Head' class='gridMainHeader'>" + strTitle + "</span><div id='kendogrid' class='gridStyle'></div>");
         $(mdm.baseGrid.domElement).children("#kendogrid").kendoGrid(gridConf);
	};

    mdm.baseGrid.destroyWidget = function ()
    {
		console.log("BaseGrid: destroyWidget is called.");

        // destroy events and subscriptions if any
        delete mdm.baseGrid.domElement;
    };

	/**
 * This function is to set the width of the columns if not set.
 */
	mdm.baseGrid.validateAndCorrect = function (config) {
		if (config != null && config.hasOwnProperty("columns"))
		{
			var cols = config.columns;

			if (cols != null) {
				cols.forEach((x) => {
					if (!x.hasOwnProperty("width")) {
						// adding default column width here
						x.width = "100px";
					}

				});
			}
		}
	};
	

	/**
	 * Reads from a cwidget.data . If it fails, then it uses static data.
	 * See https://docs.telerik.com/kendo-ui/api/javascript/data/datasource/configuration/transport.read
	 * @param {Object} options - Object with callback handlers for success and error
	 * @param {Function} options.success - A callback that should be called for each operation with two parameters - items and operation.
	 * @param {Function} options.failure - A callback that should be called in case of failure of any of the operations.
	 */
	mdm.baseGrid.dataSourceRead = function (options) {

            if (typeof (cwidget.data) !== 'undefined')
				if (cwidget.data != '') {
					try {
						options.success(JSON.parse(cwidget.data));
						return;
					}
					catch (ex) {
						//alert(WW_localize("@@WidgetBaseGridErrorParsingData@@") + ex);
						console.log(WW_localize("@@WidgetBaseGridErrorParsingData@@") + ex);
						options.success('');
						return;
					}
                }
			/**
			* get static test data from configuration 
			**/
			
		var gridConf = WW_getMyConf(mdm, cwidget, myConf);
		let testData = '';	
		
		if (gridConf != null) {
			testData = WW_getTestData(myConf.confName, '_testdata');

			if (testData == null) {
				testData = '';
			}
			options.success(testData);
        }
		else
		{
			alert(WW_localize('@@WidgetBaseGridErrorLoadingConfiguration@@'));
			return;
		}
	};

	mdm.baseGrid.verify = {};

	mdm.baseGrid.verify.isDate =  function (val)
	{
		try
		{
			return (!mdm.baseGrid.verify.isUndefined(val) && Object.prototype.toString.call(val) === '[object Date]');
		}
		catch (err)
		{
			return false;
		}
	};

	mdm.baseGrid.verify.isEmpty = function (value)
	{
		return value === "";
	};

	mdm.baseGrid.verify.isUndefined = function (value)
	{
		return typeof value == "undefined" || value === null  ;
	};
	
	mdm.baseGrid.verify.isUndefinedNullOrEmpty = function (value)
	{
		return mdm.baseGrid.verify.isEmpty(value) || mdm.baseGrid.verify.isUndefined(value);
	};
	
	mdm.baseGrid.verify.isNumber = function (val, acceptEmptyString)
	{
		var isNumber = false;
		try
		{
			if (acceptEmptyString === undefined)
			{
				acceptEmptyString = false;
			}
			if (acceptEmptyString && val === "")
			{
				isNumber = true;
			}
			else if (typeof val === "number")
			{
				isNumber = true;
			}
			else if (!mdm.baseGrid.verify.isUndefinedNullOrEmpty(val))
			{
				isNumber = !isNaN(val);
			}
		}
		catch (err)
		{
			logger.logError(err.message);
		}
		return isNumber;
	};

	mdm.baseGrid.verify.getDateTimeInServerUTCFormat = function (date, forUIValue)
	{
		if (!(date instanceof Date))
		{
			date = new Date(date);
		}
		date = new Date(date.getTime());
		if (forUIValue === true)
		{
			date.setTime(Date.UTC(date.getFullYear(), date.getMonth(), date.getDate(), date.getHours(), date.getMinutes(), date.getSeconds(), date.getMilliseconds()));
		}
		else
		{
			date.setMinutes(date.getMinutes() + date.getTimezoneOffset());
		}
		return date;
	};

	mdm.baseGrid.formattedNumber = function (fieldvalue, numofdecimals) {

		if (mdm.baseGrid.verify.isEmpty(fieldvalue))
			return '';
		if (mdm.baseGrid.verify.isUndefined(fieldvalue))
			return '';
		
		var formatedText = fieldvalue;

		var formatN = "n";
		if (!mdm.baseGrid.verify.isUndefined(formatedText) && formatedText !== "") {
			if (mdm.baseGrid.verify.isNumber(formatedText)) {
				if (numofdecimals !== "") {
					formatN = "n" + numofdecimals;
				}
				formatedText = (fieldvalue == "0") ? '' : kendo.toString(parseFloat(fieldvalue), formatN);
			}
		}
		return formatedText;
	};

	mdm.baseGrid.RefreshGrid = function (options) {
		/**
		* get static test dropdown data from configuration 
		**/
		
		let testCatData=WW_getTestData(myConf.confName,'_testcatdata');
			if(testCatData!=null)
				options.success(testCatData);
		
	};
	
	/**
	 * The configuration used when the data source saves newly created data items. Those are items added to the data source via the add or insert methods.
	 * See https://docs.telerik.com/kendo-ui/api/javascript/data/datasource/configuration/transport.submit
	 * @param {Object} e - transport.submit event args
	 * @param {Object} e.data - An object containing the created (e.data.created), updated (e.data.updated), and destroyed (e.data.destroyed) items.
	 * @param {Function} e.success - A callback that should be called for each operation with two parameters - items and operation.
	 * @param {Function} e.failure - A callback that should be called in case of failure of any of the operations.
	 */
	mdm.baseGrid.dataSourceUpdate = function (e) {
		//After save button clicked functions changes are executed in grid header
	  e.success();
	};
	/**
	 * Fired when the data source is populated from a JavaScript array or a remote service,
	 * a data item is inserted, updated or removed, the data items are paged, sorted, filtered, or grouped.
	 * See https://docs.telerik.com/kendo-ui/api/javascript/data/datasource/events/change
	 * @param {Object} e - Change event args
	 * @param {kendo.data.DataSource} e.sender - The data source instance which fired the event.
	 * @param {String} [e.action] - String describing the action type (available for all actions other than "read").
	 * @param {Array} e.items - The array of data items that were affected (or read).
	 */
	mdm.baseGrid.dataSourceChange = function (e) {
	};

	/**
	 * NOTE: This handler does not exist in earlier versions of kendoGrid.
	 * Fired when the user try to edit or create a data item, before the editor is created.
	 * Can be used for preventing the editing depending on custom logic.
	 * See https://docs.telerik.com/kendo-ui/api/javascript/ui/grid/events/beforeedit
	 * @param {kendo.data.Model} e.model - The data item which is going to be edited. Use its isNew method to check if the data item is new (created) or not (edited).
	 * @param {kendo.ui.Grid} e.sender - The widget instance which fired the event.
	 */
	mdm.baseGrid.beforeEdit = function (e) {
	};

	/**
	 * Fired when the user clicks the "cancel" button (in inline or popup editing mode) or closes the popup window.
	 * See https://docs.telerik.com/kendo-ui/api/javascript/ui/grid/events/cancel
	 * @param {Object} e - Grid cell edit cancel event args
	 * @param {jQuery} e.container - The jQuery object that represents the edit container element.
	 * @param {kendo.data.Model} e.model - The data item to which the table row is bound.
	 * @param {Function} e.preventDefault - If invoked prevents the cancel action. The table row remains in edit mode.
	 * @param {kendo.ui.Grid} e.sender - The widget instance which fired the event.
	 */
	mdm.baseGrid.cancel = function (e) {
	  // Fired when the user clicks the "cancel" button (in inline or popup editing mode) or closes the popup window.
	};

	/**
	 * Fired when the user selects a table row or cell in the grid.
	 * See https://docs.telerik.com/kendo-ui/api/javascript/ui/grid/events/change
	 * @param {Object} e - Grid selection change event args
	 * @param {kendo.ui.Grid} e.sender - The widget instance which fired the event.
	 */
	mdm.baseGrid.change = function (e) {

		var el = (this.select() || [{}])[0];
		var cellIndex = el.cellIndex;
		var rowIndex = $(el).closest("tr").index();
		
		if(typeof(mdm.baseGrid.changeExt)!='undefined')
			mdm.baseGrid.changeExt(e);

	};
/**
 * Fired when the field is a datetime picker and needs to reflect the selected datetime
 * See https://docs.telerik.com/kendo-ui/api/javascript/ui/grid/events/change
 * @param {Object} fieldvalue - datetime field value
 */

	mdm.baseGrid.formattedDateTime = function (fieldvalue) {
		
		if (mdm.baseGrid.verify.isEmpty(fieldvalue))
			return '';
		if (mdm.baseGrid.verify.isUndefined(fieldvalue))
			return '';
		var format = kendo.culture().calendar.patterns.d + " " + kendo.culture().calendar.patterns.T;
		var dateValue = new Date(fieldvalue);
		dateValue = kendo.parseDate(dateValue, format);
		var dateCultureSettings = { generalFormatSpecifier: "G", timeFormat: "T" };
		dateValue = kendo.toString(dateValue, dateCultureSettings.generalFormatSpecifier);
		return dateValue;
	}

	/**
	 * Fired when the user edits or creates a data item.
	 * See https://docs.telerik.com/kendo-ui/api/javascript/ui/grid/events/edit
	 * @param {Object} e - Grid cell edit cancel event args
	 * @param {jQuery} e.container - The jQuery object that represents the edit container element.
	 * @param {kendo.data.Model} e.model - The data item to which the table row is bound.
	 * @param {kendo.ui.Grid} e.sender - The widget instance which fired the event.
	 */
	mdm.baseGrid.edit = function (e) {
		for( let ele in e.model ) {
			$('.k-edit-cell').find('#' + ele).attr('title', '');
		}		
		myConf.isDirtyAlready = false;
				
		var currentColumn = e.container[0].firstElementChild.id; 
					
		if(Object.keys(e.model.dirtyFields).includes(currentColumn)){	
			if(e.model.dirtyFields[currentColumn] === true){			
				myConf.isDirtyAlready = true;
			}	
		}
							
		lastCell=e.sender;
		
		myConf.manualsetdata = true;
		
		mdm.baseGrid.editCallback(e);
	};

	/**
	 * Find the column index for a specific field in the grid. NOTE: This does not work
	 * with SkeltaGrid because of a hidden hierarchical column. The function should search
	 * based on the first row in tbody instead, but it is not that simple. :(
	 * @param {kendo.ui.Grid} grid - The widget instance which fired the event.
	 * @param {String} field - The field name of the column to find.
	 */
	mdm.baseGrid.findColumnIndex = function(grid, field) {
		
	  // Grid body may include hierarchy cells, so the column index of the row may be different
	  // than the column index of the header
	  var colIndex = grid.columns.findIndex(function (el) { return el.field === field; });
	  var column = grid.columns[colIndex];
	  if (column && column.title) {
		var headers = grid.thead.children().find("th");
		for (var ii = 0; ii < headers.length; ++ii) {
		  var headerField = headers[ii].dataset.field;
		  if (headerField === field) {
			colIndex = ii;
			return colIndex;
		  }
		}
		
		return colIndex;
	  }
	  return 0;
	};

	/**
	* Should likely be moved to conf file
	 * Fired before the widget binds to its data source. Used to modify the data before the dataBound event.
	 * See https://docs.telerik.com/kendo-ui/api/javascript/ui/grid/events/databinding
	 * @param {Object} e - Grid data binding event args
	 * @param {kendo.ui.Grid} e.sender - The widget instance which fired the event.
	 * @param {Function} e.preventDefault - If invoked prevents the cancel action. The table row remains in edit mode.
	 * @param {jQuery} e.container - The jQuery object that represents the edit container element.
	 * @param {kendo.data.Model} e.model - The data item to which the table row is bound.
	 * @param {String} e.action - The action that caused the dataBinding event. Possible values: rebind, sync, add, remove.
	 * @param {Number} e.index - Available if the action is add or remove. Shows the index of the added/removed element.
	 * @param {Array} e.items - The array of items that shows the elements that are going to be added/removed from the widget dataSource.
	 */
	mdm.baseGrid.dataBinding = function(e) {
		if (mdm.baseGrid.verify.isUndefined(e.items))
			return;
		for (var ii = 0; ii < e.items.length; ++ii) {
		  var dataItem = e.items[ii];
		  // Manually add a "hex" field to the dataItem
		  var rgb = mdm.baseGrid.swapColorRandB(dataItem.color);
		  dataItem.hex = mdm.baseGrid.padHex(rgb, 6, "#", true);
	  }
	};

	/**
	* Fired when "incell" edit mode is used and the cell is going to be closed. 
    * The event is triggerd after saving or canceling the changes, but before the cell is closed.
	* See https://docs.telerik.com/kendo-ui/api/javascript/ui/grid/events/cellclose
    * @param {Object} e - Grid cell close event arg
	* @param {e.container jQuery} - The jQuery object that represents the edit container element. More information is available in the edit event arguments' description.
	* @param {e.model kendo.data.Model} - The data item to which the table row is bound.
	* @param {e.type String} - The type of the cell close action - can be either "save" or "cancel". The "cancel" type is triggered when the grid keyboard navigation is enabled by "navigatable: true" and Esc key is used for cell close action.
	* @param {e.sender kendo.ui.Grid} - The widget instance which fired the event.
	*/
	mdm.baseGrid.cellClose = function(e) {
		
	  	var data = e.sender.dataSource.data();
		var dirty = $.grep(data, function (item) {
			return item.dirty;
		});
				
		cwidget.modifiedRows = JSON.stringify(dirty);		
	};
	
	/**
	 * Fired when the widget is bound to data from its data source.
	 * See https://docs.telerik.com/kendo-ui/api/javascript/ui/grid/events/databound
	 * @param {Object} e - Grid data bound event args
	 * @param {kendo.ui.Grid} e.sender - The widget instance which fired the event.
	 * @param {String} [label] - Label for logging to identify the caller
	 */
	mdm.baseGrid.dataBound = function(e, label) {
		if(typeof(mdm.baseGrid.dataBoundExt)!='undefined')
			mdm.baseGrid.dataBoundExt(e,label);
	  
		cwidget.onDataBound=label;
		
	};

	/**
	 * Fired when the user clicks the "destroy" command button and delete operation is confirmed
	 * in the confirmation window, if the cancel button in the window is clicked the event will
	 * not be fired.
	 * See https://docs.telerik.com/kendo-ui/api/javascript/ui/grid/events/remove
	 * @param {Object} e - Grid remove event args
	 * @param {kendo.data.Model} e.model - The data item to which the table row is bound.
	 * @param {jQuery} e.row - The jQuery object representing the current table row.
	 * @param {kendo.ui.Grid} e.sender - The widget instance which fired the event.
	 */
	mdm.baseGrid.remove = function (e) {
	};
	
	/**
	 * Fired when a data item is saved.
	 * See https://docs.telerik.com/kendo-ui/api/javascript/ui/grid/events/save
	 * @param {Object} e - Grid save event args
	 * @param {kendo.data.Model} e.model - The data item to which the table row is bound.
	 * @param {jQuery} e.container - The jQuery object that represents the edit container element.
	 * @param {kendo.ui.Grid} e.sender - The widget instance which fired the event.
	 * @param {Object} e.values - The values entered by the user. Available only when the editable.mode option is set to "incell".
	 * @param {Function} e.preventDefault - If invoked, prevents the save action. In "incell" editable.mode the edited table cell will exit edit mode. In "inline" and "popup" edit modes, the edit form will remain open.
	 */
    mdm.baseGrid.save = function (e) {

		if(!myConf.manualsetdata)
		{
			return;
		}

        var rowIndex = Object.keys(e.sender._selectedIds)[0];

		myConf.oldColumnName = Object.keys(e.values)[0];
		myConf.oldColumnValue = e.model[myConf.oldColumnName];
		
		mdm.baseGrid.event = e;
		
        var griddata = {};
		cwidget.newCellValue = JSON.stringify(e.values);
		cwidget.prevRowValue = JSON.stringify(e.model);
        griddata.oldvalue = JSON.stringify(e.model);
        griddata.modifiedvalue = JSON.stringify(e.values);
		cwidget.onCellChange = griddata;
		
		myConf.manualsetdata = false;

    };

	mdm.baseGrid.HandleValidationResult = function() {
						
		e = mdm.baseGrid.event;
		
		if(e.model[myConf.oldColumnName] === myConf.oldColumnValue)	{		
			e.preventDefault();	
			
			if(!myConf.isDirtyAlready){
			
				delete e.model.dirtyFields[myConf.oldColumnName];
				if (Object.keys(e.model.dirtyFields).length === 0)	{				
					e.model.dirty = false;
				}
			}							
		}
		else{	
			var grid = $(mdm.baseGrid.domElement).children("#kendogrid").data("kendoGrid");		
				
			// Access the row that is selected
			var select = grid.select();
			// and now the data
			var dataItem = grid.dataItem(select);		
			
			dataItem.set(myConf.oldColumnName, myConf.oldColumnValue);
				
			if(!myConf.isDirtyAlready){					
				delete dataItem.dirtyFields[myConf.oldColumnName];
				if (Object.keys(dataItem.dirtyFields).length === 0)	{				
					dataItem.dirty = false;
				}				
			}
			
			grid.refresh();	

			var data = grid.dataSource.data();
			var dirty = $.grep(data, function (item) {
				return item.dirty;
			});
				
			cwidget.modifiedRows = JSON.stringify(dirty);		
		}
	};						
	/**
	 * Custom save function when user changes the [color] column.
	 * @param {Object} e - Grid save event args
	 */
	mdm.baseGrid.saveCellColor = function (e) {
	  var color = e.values.color;
	  var num = parseInt(color, 10);
	  if (isNaN(num) || num < 0 || num > 0xFFFFFF) {
		e.sender.closeCell();
		e.preventDefault();
		return false;
	  }

	  // Update the color
	  var rgb = mdm.baseGrid.swapColorRandB(color);
	  var backColor = mdm.baseGrid.padHex(rgb, 6, "#", true);
	  var foreColor = mdm.baseGrid.setContrast(backColor);
	  var row = $(e.container[0]).closest("tr");
	  var colColor = row.find("td:eq(1)");
	  colColor.css({ "color": foreColor, "background-color": backColor });

	  // Update related column
	  if (e.model.hasOwnProperty("hex")) {
		e.model.set("hex", backColor);
	  }
	};
	/**
	 * Custom save function when user changes the [color] column.
	 * @param {Object} e - Grid save event args
	 */
	mdm.baseGrid.saveComment = function (e) {
	  var comment = e.values.last_edit_comment;
	 
	  // Update related column
	  if (e.model.hasOwnProperty("last_edit_comment")) {
		e.model.set("last_edit_comment", comment);
	  }
	};

	/**
	 * Custom save function when user changes the [hex] column.
	 * @param {Object} e - Grid save event args
	 */
	mdm.baseGrid.saveCellHex = function (e) {
	  var rgb = mdm.baseGrid.hexToRgb(e.values.hex);
	  if (rgb === null) {
		e.sender.closeCell();
		e.preventDefault();
		return false;
	  }

	  var num = (rgb.r << 16) | (rgb.g << 8) | rgb.b;
	  var backColor = mdm.baseGrid.padHex(num, 6, "#", true);
	  var foreColor = mdm.baseGrid.setContrast(backColor);
	  var color = mdm.baseGrid.swapColorRandB(rgbToNum(rgb));
	  var row = $(e.container[0]).closest("tr");
	  var colColor = row.find("td:eq(1)");
	  colColor.css({ "color": foreColor, "background-color": backColor });
	  
	  // Update hex (for padding and upper case)
	  e.values.hex = backColor;

	  // Update related column
	  e.values.hex = backColor;
	  e.model.set("hex", backColor);
	  e.model.set("color", color);
	};
	/**
	 * Fired when the user clicks the "save" command button.
	 * See https://docs.telerik.com/kendo-ui/api/javascript/ui/grid/events/savechanges
	 * @param {Object} e - Grid save changes event args
	 * @param {kendo.ui.Grid} e.sender - The widget instance which fired the event.
	 * @param {Function} e.preventDefault - If invoked the grid will not call the sync method of the data source.
	 */
	mdm.baseGrid.saveChanges = function (e) {
	 
	  /* if (!confirm("Are you sure you want to save all changes?")) {
		e.preventDefault();
	  }*/
	  
	};
	// =======================================================================
	// Color utility functions
	// =======================================================================

	/**
	 * Creates an Rgb instance
	 * @param {Number} r - Red component
	 * @param {Number} g - Green component
	 * @param {Number} b - Blue  component
	 */
	function Rgb(r, g, b) {
	  this.r = r;
	  this.g = g;
	  this.b = b;
	}

	/**
	 * Converts BGR to RGB and vice versa by swapping the R and B components
	 * @param {Number|String} value - Number or number string
	 * @returns {Number}
	 */
	function swapColorRandB(value) {
	  var color = parseInt(value, 10);
	  return (color & 0xFF00FF00) | ((color & 0xFF0000) >> 16) | ((color & 0xFF) << 16);
	}

	/**
	 * Formats a number to hexadecimal
	 * @param {Number|String} num - Number or hexadecimal string
	 * @param {Number} [digits] - Number of characters or digits to display, not including prefix. Number will be padded with "0" to reach the desired digits.
	 * @param {String} [prefix] - Prefix to add before hexadecimal result, e.g. "#" or "0x"
	 * @param {Boolean} [uppercase] - Flag to convert result to upper case
	 * @returns {String}
	 */
	function padHex(num, digits, prefix, uppercase) {
		var hex = typeof num === "number" ? num.toString(16) : "" + num;
		if (typeof digits === "string") digits = parseInt(digits);
		else if (typeof digits === "undefined" || digits === null) digits = 0;
		if (hex.length < digits)
			hex = "0".repeat(digits).substr(0, digits - hex.length) + hex;
		if (uppercase)
			hex = hex.toUpperCase();
		return "" + prefix + hex;
	}

	/**
	 * https://stackoverflow.com/a/5624139/29762
	 * @param {String} hex - Hexadecimal string, e.g. #1133FF
	 * @returns {Rgb|null}
	 */
	function hexToRgb(hex) {
	  // Expand shorthand form (e.g. "03F") to full form (e.g. "0033FF")
	  var shorthandRegex = /^#?([a-f\d])([a-f\d])([a-f\d])$/i;
	  hex = hex.replace(shorthandRegex, function(m, r, g, b) {
		return r + r + g + g + b + b;
	  });

	  var result = /^#?([a-f\d]+)$/i.exec(hex);
	  if (result) {
		var num = parseInt(result[1], 16);
		if (!isNaN(num))
		  return new Rgb(
			(num >> 16) & 0xFF,
			(num >> 8) & 0xFF,
			num & 0xFF
		  );
	  }
	  return null;
	}

	/**
	 * Checks if an object has "r", "g", and "b" properties
	 * @param {Object} rgb - Object to test
	 * @returns {Boolean}
	 */
	function isRgb(rgb) {
	  if (rgb instanceof Rgb) return true;
	  return rgb.hasOwnProperty("r") && rgb.hasOwnProperty("g") && rgb.hasOwnProperty("b");
	}

	/**
	 * Converts a number to an RGB object
	 * @param {Number|String} num - Number or hexadecimal string
	 * @returns {Rgb|null}
	 */
	function numToRgb(num) {
	  if (isRgb(num))
		return num;
	  if (typeof num === "string" && num.length > 0)
		num = hexToRgb(num);
	  if (typeof num === "number" && !isNaN(num)) {
		  return new Rgb(
			(num >> 16) & 0xFF,
			(num >> 8) & 0xFF,
			num & 0xFF
		  );
	  }
	  return null;
	}

	/**
	 * Converts an Rgb object to a number. If the parameter is not an Rgb object, it returns the input parameter.
	 * @param {Rgb} rgb - Rgb object to convert
	 * @returns {Number}
	 */
	function rgbToNum(rgb) {
	  if (isRgb(rgb))
		return (rgb.r << 16) | (rgb.g << 8) | rgb.b;
	  return rgb;
	}

	/**
	 * Converts an Rgb object to hexadecimal
	 * @param {Rgb} rgb - Rgb object to convert
	 * @param {Number} [digits] - Number of characters or digits to display, not including prefix. Number will be padded with "0" to reach the desired digits.
	 * @param {String} [prefix] - Prefix to add before hexadecimal result, e.g. "#" or "0x"
	 * @param {Boolean} [uppercase] - Flag to convert result to upper case
	 * @returns {String}
	 */
	function rgbToHex(rgb, digits, prefix, uppercase) {
	  var num = rgbToNum(rgb);
	  return padHex(num, digits, prefix, uppercase);
	}

	/**
	 * Sets the foreground color to white or black depending on the contrast of the background color parameter
	 * See https://stackoverflow.com/a/11868159/29762
	 * @param {Rgb|String} backColor - Background color as Rgb object or hexadecimal string
	 * @returns {String|null}
	 */
	function setContrast(backColor) {
	  var c = isRgb(backColor) ? backColor : hexToRgb(backColor);
	  if (c === null) {
		return null;
	  }

	  // http://www.w3.org/TR/AERT#color-contrast
	  var brightness = Math.round(((c.r * 299) + (c.g * 587) + (c.b * 114)) / 1000);
	  var textColor = (brightness > 125) ? 'black' : 'white';
	  return textColor;
	}

	// =======================================================================
	// Export function into mdm.baseGrid
	// =======================================================================

	mdm.baseGrid.swapColorRandB = swapColorRandB;
	mdm.baseGrid.hexToRgb = hexToRgb;
	mdm.baseGrid.padHex = padHex;
	mdm.baseGrid.setContrast = setContrast;

	// =======================================================================
	// Initialize the form
	// =======================================================================

	// Call the initialization when the document is ready
	$(document).ready(mdm.baseGrid.init);
})();