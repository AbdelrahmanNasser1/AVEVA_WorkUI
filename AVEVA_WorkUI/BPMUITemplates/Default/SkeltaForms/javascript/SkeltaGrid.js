var cdataStart = "<![CDATA[";
var cdataEnd = "]]>";
var isModified = false;
var isMessageAlert = false;
function waitPreloadPage() { //DOM
    if (document.getElementById) {

        parent.document.getElementById(window.frameElement.id).parentNode.childNodes[0].style.display = 'none';
        //hide all the junk rows
        var visRows = document.getElementsByTagName("TR");
        for (var i = 0; i < visRows.length; i++) {
            att = visRows[i].getAttribute("type");
            if (att != null && att == "RowSeparator") {
                visRows[i].style.display = "none";
            }
        }

    } else {
        if (document.layers) { //NS4
            parent.document.getElementById(window.frameElement.id).parentNode.childNodes[0].style.visibility = 'hidden';
        }
        else { //IE4
            parent.document.getElementById(window.frameElement.id).parentNode.childNodes[0].style.visibility = 'hidden';
        }
    }
}
function ContextMenu(controlId, rowType, rowElement, menuObject) {
    return;
    //NOT FOR CURRENT BUILD - ROHIT
    var ctxItems = _ctxtablemap[menuObject.Table.Name];

    for (var i = 0; i < menuObject.Items.length; i++) {
        menuObject.Items[i].Hide();
    }

    for (var j = 0; j < ctxItems.length; j++) {
        var menuItem = new WebMenuItem();
        menuItem.Text = ctxItems[j].Text;
        menuItem.Name = ctxItems[j].Text;
        menuItem.Properties = ctxItems[j].Properties;
        menuItem.OnClick = "ExecuteMenuAction";
        menuObject.Items.Add(menuItem);
    }
}

function ContextMenuItem() {
    this.Text = "";
    this.Properties = new Array();
}

function ExecuteMenuAction(menuOption, detls1, detls2) {
    var grid = ISGetObject(controlUniqueId);
    var selectedObject = grid.GetSelectedObject().GetRowObject();

    var extendedXml = GetRecursiveRowXml(selectedObject, "");
    var persistXml = GetPersistXml(selectedObject, ""); ;

    var properties = menuOption.Properties;
    if (properties != null) {
        var page = properties[0];
        var top = properties[1];
        var left = properties[2];
        var ht = properties[3];
        var wd = properties[4];
        var rez = properties[5];
        var modal = properties[6];


        var winOptions = "top=" + parseInt(top, 10) + ",left=" + parseInt(left, 10) + ",height=" + parseInt(ht, 10) + ",width=" + parseInt(wd, 10) + ",resizable=" + rez;
        var dialogoptions = "dialogTop:" + parseInt(top, 10) + ";dialogLeft:" + parseInt(left, 10) + ";dialogHeight:" + parseInt(ht, 10) + "px;dialogWidth:" + parseInt(wd, 10) + "px;";

        if (modal == "true") {
            CallServerSideMethod(null, 'UpdateTemp', "ResultXml", CallbackContextAction, 'persistXml', persistXml, 'extendedXml', extendedXml, 'winparam', dialogoptions, 'page', page);
        }
        else {
            CallServerSideMethod(null, 'UpdateTemp', "ResultXml", CallbackContextAction, 'persistXml', persistXml, 'extendedXml', extendedXml, 'winparam', winOptions, 'page', page);
        }

    }
}
function CallbackContextAction(context, result, response) {
    var popWin = null;
    var modal = result[0];
    var page = result[1];
    var param = result[2];

    if (modal == "T") {
        popWin = window.showModalDialog(page, controlUniqueId, param);
    }
    else {
        popWin = window.open(page, controlUniqueId, param);
    }
    return popWin;
}

function GetPersistXml(selectedRow, childXml) {
    var table = selectedRow.Table;
    var cells = selectedRow.GetCells();
    var columnsToAdd = _persistmap[table.Caption];

    if (table.IsRootTable) {
        var xml = "";
        if (childXml == "")
            xml = "<" + table.Name + ">";

        else
            xml = "<" + table.Name + ">";

        for (var i = 0; i < columnsToAdd.length; i++) {
            var namedItem = cells.GetNamedItem(columnsToAdd[i]);
            if (namedItem != null) {
                var val = namedItem.Text;
                xml += "<" + columnsToAdd[i] + ">";
                xml += cdataStart + val + cdataEnd;
                xml += "</" + columnsToAdd[i] + ">";
            }
            else {
                if (_persistobject == null || typeof (_persistobject) == "undefined")
                    InitPersistedValues();
                var rowValArr = _persistobject[table.Caption][selectedRow.Position];
                var val = rowValArr[columnsToAdd[i]];
                xml += "<" + columnsToAdd[i] + ">";
                xml += cdataStart + val + cdataEnd;
                xml += "</" + columnsToAdd[i] + ">";
            }
        }
        xml += childXml;
        xml += "</" + table.Name + ">";
        return xml;
    }
    else {
        var xml = "";
        if (childXml == "")
            xml = "<" + table.Name + ">";
        else
            xml = "<" + table.Name + ">";

        for (var i = 0; i < columnsToAdd.length; i++) {
            var namedItem = cells.GetNamedItem(columnsToAdd[i]);
            if (namedItem != null) {
                var val = namedItem.Text;
                xml += "<" + columnsToAdd[i] + ">";
                xml += cdataStart + val + cdataEnd;
                xml += "</" + columnsToAdd[i] + ">";
            }
            else {
                if (_persistobject == null || typeof (_persistobject) == "undefined")
                    InitPersistedValues();
                var rowValArr = _persistobject[table.Caption][checkedRow.Position];
                var val = rowValArr[columnsToAdd[i]];
                xml += "<" + columnsToAdd[i] + ">";
                xml += cdataStart + val + cdataEnd;
                xml += "</" + columnsToAdd[i] + ">";
            }
        }
        xml += childXml;
        xml += "</" + table.Name + ">";
        return GetPersistXml(selectedRow.GetParentRow(), xml);
    }
    return "";

}

function GetRecursiveRowXml(selectedRow, childXml) {
    var table = selectedRow.Table;
    var cells = selectedRow.GetCells();
    if (table.IsRootTable) {
        var xml = "";
        if (childXml == "")
            xml = "<" + table.Name + ">";

        else
            xml = "<" + table.Name + ">";

        for (var i = 0; i < table.Columns.length; i++) {
            var namedItem = cells.GetNamedItem(table.Columns[i].Caption);
            if (namedItem != null) {
                var val = namedItem.Text;
                xml += "<" + table.Columns[i].Name + ">";
                xml += cdataStart + val + cdataEnd;
                xml += "</" + table.Columns[i].Name + ">";
            }
        }
        xml += childXml;
        xml += "</" + table.Name + ">";
        return xml;
    }
    else {
        var xml = "";
        if (childXml == "")
            xml = "<" + table.Name + ">";
        else
            xml = "<" + table.Name + ">";

        for (var i = 0; i < table.Columns.length; i++) {
            var namedItem = cells.GetNamedItem(table.Columns[i].Caption);
            if (namedItem != null) {
                var val = namedItem.Text;
                xml += "<" + table.Columns[i].Name + ">";
                xml += cdataStart + val + cdataEnd;
                xml += "</" + table.Columns[i].Name + ">";
            }
        }
        xml += childXml;
        xml += "</" + table.Name + ">";
        return GetRecursiveRowXml(selectedRow.GetParentRow(), xml);
    }
    return "";
}

// GetCheckedRow Xml

//var childrowcount = 0;
function GetCheckedRowXml(checkedRow) //, index, reset) {    
{
  
    if (reset)
        childrowcount = 0;
    var checkedRowXml = "";
    var table = checkedRow.Table;
    var cells = checkedRow.GetCells();
    var columnsToAdd = _persistmap[table.Caption];
    var xml = "<" + table.Name + ">";
    /* TO GET ALL COLUMNNS
    for (var i = 0; i < table.Columns.length; i++) {
    var namedItem = cells.GetNamedItem(table.Columns[i].Name);
    if (namedItem != null) {
    var val = namedItem.Text;
    xml += "<" + table.Columns[i].Name + ">";
    xml += val;
    xml += "</" + table.Columns[i].Name + ">";
    }
    }*/
    //var parentcheckrowPostion = checkedRow.Position;
    for (var i = 0; i < columnsToAdd.length; i++) {

        var namedItem = cells.GetNamedItem(columnsToAdd[i]);
        if (namedItem != null) {
            var val = namedItem.Text;
            xml += "<" + columnsToAdd[i] + ">";
            xml += cdataStart + val + cdataEnd;
            xml += "</" + columnsToAdd[i] + ">";
        }
        else {
            var itemdetailcell = cells.GetNamedItem("CHECK");
            if (itemdetailcell == null) return;
            var Querystringvalues = itemdetailcell.GetAttribute("persistcolumns");
            if (Querystringvalues == null) return;
            //Correct Querystringvalues
            Querystringvalues = decodeURIComponent(Querystringvalues);
            Querystringvalues = ReplaceAll(Querystringvalues, "+", " ");
            //End correction
            var QuerystringvaluesArr = Querystringvalues.split(':#');
            var valueArray = new Array();
            if (QuerystringvaluesArr != null || QuerystringvaluesArr != "undefined") {
                for (var m = 0; m < QuerystringvaluesArr.length; m++) {
                    var Array1 = QuerystringvaluesArr[m].split(';$');
                    valueArray[Array1[0]] = Array1[1];
                }
            }
            var val = valueArray[columnsToAdd[i]]
            xml += "<" + columnsToAdd[i] + ">";
            xml += cdataStart + val + cdataEnd;
            xml += "</" + columnsToAdd[i] + ">";
        }

    }

    //******New logic to get the Checked Rows count***

    //var ChildRow = grid.RootTable.ChildTables[0].GetCheckedRows()[1];
    //var childRow1 = grid.Tables[grid.RootTable.ChildTables[0].Caption].ToRowObject(ChildRow);
    //childRow1.GetParentRow().KeyValue;
    var childCheckedRows;
    var childRow;
    if (checkedRow.GetChildRows() != null) {
        if (checkedRow.GetChildRows().length > 0) {
            childRow = checkedRow.GetChildRows()[0];
            childCheckedRows = childRow.Table.GetCheckedRows();
        }
    }

    //    if (checkedRow.Table.GetCheckedRows() != null && checkedRow.Table.GetCheckedRows() != "undefined") 
    //    {
    //var checkedchildRow = childRow.Table.GetCheckedRows();
    if (childCheckedRows != null) {

        if (childCheckedRows.length > 0) {
            for (var m = 0; m < childCheckedRows.length; m++) {

                var childCheckedRow = childCheckedRows[m];
                var checkedChildRowObject = childRow.Table.ToRowObject(childCheckedRow);
                var valpermapcol = _valuepersistmap[checkedRow.Table.Caption];
                if (checkedChildRowObject.GetParentRow() != null) {
                    var ValueColumns = _compositemap[checkedRow.Table.Caption];
                    //loop for all the value columns
                    var chekedRowcells = checkedRow.GetCells();
                    var parentCheckedCells = checkedChildRowObject.GetParentRow().GetCells();
                    var isMatch = false;
                    var chekedvalueArray = GetValueArray(chekedRowcells);
                    var parentvalueArray = GetValueArray(parentCheckedCells);
                    for (var k = 0; k < ValueColumns.length; k++) {
                        var valcasecorrected = valpermapcol[ValueColumns[k]];
                        if (chekedRowcells.GetNamedItem(valcasecorrected) != null) {
                            if (chekedRowcells.GetNamedItem(valcasecorrected).Text == parentCheckedCells.GetNamedItem(valcasecorrected).Text)
                                isMatch = true;
                            else {
                                isMatch = false;
                                break;
                            }
                        }
                        else {
                            if (chekedvalueArray[valcasecorrected] != undefined && parentvalueArray[valcasecorrected] != undefined) {
                                if (chekedvalueArray[valcasecorrected] == parentvalueArray[valcasecorrected]) {
                                    isMatch = true;
                                }
                                else {
                                    isMatch = false;
                                    break;
                                }
                            }
                        }
                    }

                    if (isMatch) {

                        childXml = GetCheckedRowXml(checkedChildRowObject)//, 0, false);
                        xml += childXml;
                        //                            //                    else
                        //                            //                        childXml = GetCheckedRowXml(childRow, (childRow.Position + (childrowcount - (m + 1))), false);

                        //                            xml += childXml;
                    }
                    //                        if (checkedChildRowObject.GetParentRow().KeyValue == checkedRow.KeyValue) {
                    //                            var childXml;
                    //                            //if (parentcheckrowPostion == 0)
                    //                            childXml = GetCheckedRowXml(checkedChildRowObject)//, 0, false);
                    //                            //                    else
                    //                            //                        childXml = GetCheckedRowXml(childRow, (childRow.Position + (childrowcount - (m + 1))), false);

                    //                            xml += childXml;

                    //                        }
                }
            }
        }

    }
    //}        

    //*****************New Logic End**************************

    //var expIndex = checkedRow.RowElement.innerHTML.indexOf("min-xp.gif"); //childNodes[0].childNodes[0].childNodes[1]
    /*  if (checkedRow.GetChildRows() != null && checkedRow.GetChildRows() != "undefined") 
    {
    if (checkedRow.GetChildRows().length > 0) 
    {
    for (var m = 0; m < checkedRow.GetChildRows().length; m++) 
    {
    var childRow = checkedRow.GetChildRow(m);
    if (childRow == null)
    break;
    var cell = childRow.GetCell(0).CellElement
    if (cell.childNodes[0].checked)
    {
    var childXml;
    //if (parentcheckrowPostion == 0)
    childXml = GetCheckedRowXml(childRow)//, 0, false);
    //                    else
    //                        childXml = GetCheckedRowXml(childRow, (childRow.Position + (childrowcount - (m + 1))), false);

    xml += childXml;
    }
    }

    }
    }*/


    xml += "</" + table.Name + ">";
    return xml;
}

function GetValueArray(rowCells) {

    var checkeditemdetailcell = rowCells.GetNamedItem("CHECK");
    if (checkeditemdetailcell == null) return;
    var Querystringvalues = checkeditemdetailcell.GetAttribute("persistcolumns");
    if (Querystringvalues == null) return;
    //Correct Querystringvalues
    Querystringvalues = decodeURIComponent(Querystringvalues);
    Querystringvalues = ReplaceAll(Querystringvalues, "+", " ");
    //End correction
    var QuerystringvaluesArr = Querystringvalues.split(':#');
    var valueArray = new Array();
    if (QuerystringvaluesArr != null || QuerystringvaluesArr != "undefined") {
        for (var m = 0; m < QuerystringvaluesArr.length; m++) {
            var Array1 = QuerystringvaluesArr[m].split(';$');
            valueArray[Array1[0]] = Array1[1];
        }
    }
    return valueArray;
}

function GetCompositeRowXML(checkedRow) {
    //debugger;
    var checkedRowXml = "";
    var table = checkedRow.Table;
    var cells = checkedRow.GetCells();
    var columnsToAdd = _compositemap[table.Caption];
    var xml = "";
    if (columnsToAdd.length > 1)
        xml = "<Lookup Name=\"" + table.Name + "\" IsMultiValue=\"true\">";
    else
        xml = "<Lookup Name=\"" + table.Name + "\" IsMultiValue=\"false\">";
    for (var i = 0; i < columnsToAdd.length; i++) {

        var namedItem = cells.GetNamedItem(columnsToAdd[i]);
        if (namedItem != null) {
            var val = namedItem.Text;
            xml += "<" + columnsToAdd[i] + ">";
            xml += cdataStart + val + cdataEnd;
            xml += "</" + columnsToAdd[i] + ">";
        }
        else {
            var itemdetailcell = cells.GetNamedItem("CHECK");
            if (itemdetailcell == null) itemdetailcell = cells[0];//try getting the first cell
            var Querystringvalues = itemdetailcell.GetAttribute("persistcolumns");
            if (Querystringvalues == null) return;
            //Correct Querystringvalues
            Querystringvalues = decodeURIComponent(Querystringvalues);
            Querystringvalues = ReplaceAll(Querystringvalues, "+", " ");
            //End correction
            var QuerystringvaluesArr = Querystringvalues.split(':#');
            var valueArray = new Array();
            if (QuerystringvaluesArr != null || QuerystringvaluesArr != "undefined") {
                for (var m = 0; m < QuerystringvaluesArr.length; m++) {
                    var Array1 = QuerystringvaluesArr[m].split(';$');
                    valueArray[Array1[0].toLowerCase()] = Array1[1];
                }
            }
            var val = valueArray[columnsToAdd[i].toLowerCase()]
            xml += "<" + columnsToAdd[i] + ">";
            xml += cdataStart + val + cdataEnd;
            xml += "</" + columnsToAdd[i] + ">";
        }
    }
    xml += "</Lookup>";
    return xml;
}

function UncheckAllRows(checkedRow) {

    var checkedRowXml = "";
    var table = checkedRow.Table;
    var cells = checkedRow.GetCells();

    var expIndex = checkedRow.RowElement.childNodes[0].innerHTML.indexOf("min-xp.gif"); //childNodes[0].childNodes[0].childNodes[1]
    if (expIndex > -1 || checkedRow.ChildExpanded) {
        for (var m = 0; m < checkedRow.GetChildRows().length; m++) {
            var childRow = checkedRow.GetChildRow(m);
//            if (childRow == null)
//                break;
            if (childRow.Checked) {
                childRow.Uncheck();
                UncheckAllRows(childRow);
            }
        }

    }
}
function SelectRow(controlId, rowType, rowElement, rowObject) {

    //
    // ========================================================================================
    // ----------------------------------------------------------------------------------------
    // { Rupesh M. Kokal }
    // Note that the below commented code was used for rectifying the issue (mentioned in the 
    // comment present in the commented code) present in 2011 SP1 release. But the same was not
    // found in the latest code for 2011 SP2, hence the change is not included here.
    // If in future similar issue is encountered, then we would require to include this code.
    // The "firstLoadForSelectRow" is a variable defined in this javascript file with value set
    // to "true". The "RaiseSelectRow" method contains the code present in this method with the
    // last line as setting "false" value to the variable "firstLoadForSelectRow".
    // ----------------------------------------------------------------------------------------
    //

    //    //
    //    // { Rupesh M. Kokal }
    //    // After initial page load, when checking a row, the SelectRow and CheckBoxClick both events get 
    //    // executed, due to which we the checked row does not reflect on the very first time.
    //    //
    //    if (firstLoadForSelectRow == "true") {
    //        setTimeout("RaiseSelectRow('" + controlId + "');", 100);
    //    }
    //    else {
    //        RaiseSelectRow(controlId);
    //    }

    //    return;
    // ========================================================================================

    var grdXml = "";
    var grid = ISGetObject(controlId);
    var selectedObject = grid.GetSelectedObject().GetRowObject();
    var isSelectable = selectedObject.GetCells().GetNamedItem("CHECK");
    var checkedXml = "";
    //    if (isSelectable == null) {
    //        window.parent.document.getElementById(window.parent._skidmap[controlId + "s"]).value = "";
    //        return;
    //    }

    //access   enable multiseelct, selectable lookup here.
    //  var lookupLevel=0;
    //   var enablemultselect = _dgmap['EM'];
    //   var persistlookup = _dgmap['persistlookupName'];


    //based on the enable multiselect value it will build the RowXML
    //  if (enablemultselect == "false")
    //     {
    // checkedXml = GetSelectedRowXml(selectedObject);
    //     }

    //       if (checkedXml != "") 
    //       {
    //         grdXml = "<Data>" + checkedXml + "</Data>";
    //      }
    try {
        // window.parent.document.getElementById(window.parent._skidmap[controlId + "v"]).value = escape(grdXml);


        //        var cells = selectedObject.GetCells();
        //        var valueName = _valuemap[selectedObject.Table.Name];
        //        if (valueName.indexOf(".") > -1)
        //            valueName = valueName.split(".")[1];

        //        var namedItem = cells.GetNamedItem(valueName);
        window.parent.document.getElementById(window.parent._skidmap[controlId + "s"]).value = GetCompositeRowXML(selectedObject);
        var el = window.parent.document.getElementById(window.parent._skidmap[controlId + "s"]);

        if (el != null) {
                var e = document.createEvent('HTMLEvents');
                e.initEvent('change', false, false);
                el.dispatchEvent(e);
        }
    }
    catch (Err) { }
}

function GetSelectedRowXml(selectedObject)
 {
   
    var checkedRowXml = "";
    var table = selectedObject.Table;
    var cells = selectedObject.GetCells();
    //var rootrowofselectedrow = selectedObject.GetRootRow();
    if (selectedObject.Table.GetCheckedRows() != null && selectedObject.Table.GetCheckedRows().length > 0) 
    {

        if (selectedObject.Checked == true && selectedObject.Table.Caption == _dgmap['persistlookupName']) 
        {
            var selectedrowxml = GetPersistXmlForCurrentRow(selectedObject);
            var parentrow = selectedObject.GetParentRow();
            while (parentrow != null) {
                selectedrowxml = GetPersistXmlForPRAppendingCRXML(parentrow, selectedrowxml, selectedObject);
                parentrow = parentrow.GetParentRow();

            }

        }
        else {
            var row = selectedObject.Table.GetCheckedRows()[0];
            row = selectedObject.Table.ToRowObject(row);
            if (row.Table.Caption == _dgmap['persistlookupName']) {
               
                var selectedrowxml = GetPersistXmlForCurrentRow(row);
                var parentrow = row.GetParentRow();
                while (parentrow != null) {
                    selectedrowxml = GetPersistXmlForPRAppendingCRXML(parentrow, selectedrowxml, row);
                    parentrow = parentrow.GetParentRow();

                }
            }
        }
    }
    return selectedrowxml;
}
function GetPersistXmlForPRAppendingCRXML(row, currentxml, selectedObject) {
    var xml = "";
    var columnsToAdd;
    var cells;
    if (selectedObject.Table.Caption == _dgmap['persistlookupName']) {
        cells = row.GetCells();
        columnsToAdd = _persistmap[row.Table.Caption];
        xml = "<" + row.Table.Name + ">";
        for (var i = 0; i < columnsToAdd.length; i++) {

            var namedItem = cells.GetNamedItem(columnsToAdd[i]);
            if (namedItem != null) {
                var val = namedItem.Text;
                xml += "<" + columnsToAdd[i] + ">";
                xml += cdataStart + val + cdataEnd;
                xml += "</" + columnsToAdd[i] + ">";
            }
            else {
                var itemdetailcell = cells.GetNamedItem("CHECK");
                if (itemdetailcell == null) return;
                var Querystringvalues = itemdetailcell.GetAttribute("persistcolumns");
                if (Querystringvalues == null) return;
                //Correct Querystringvalues
                Querystringvalues = decodeURIComponent(Querystringvalues);
                Querystringvalues = ReplaceAll(Querystringvalues, "+", " ");
                //End correction
                var QuerystringvaluesArr = Querystringvalues.split(':#');
                var valueArray = new Array();
                if (QuerystringvaluesArr != null || QuerystringvaluesArr != "undefined") {
                    for (var m = 0; m < QuerystringvaluesArr.length; m++) {
                        var Array1 = QuerystringvaluesArr[m].split(';$');
                        valueArray[Array1[0]] = Array1[1];
                    }
                }
                var val = valueArray[columnsToAdd[i]]
                xml += "<" + columnsToAdd[i] + ">";
                xml += cdataStart + val + cdataEnd;
                xml += "</" + columnsToAdd[i] + ">";
            }

        }
        xml += currentxml;
        xml += "</" + row.Table.Name + ">";
    }

    return xml;
}
function GetPersistXmlForCurrentRow(row) 
{
   
    var xml = "";
    var columnsToAdd;
    var cells;
    if (row.Checked) 
    {
        if (row.Table.Caption == _dgmap['persistlookupName']) {
            cells = row.GetCells();
            columnsToAdd = _persistmap[row.Table.Caption];
            xml = "<" + row.Table.Name + ">";
            for (var i = 0; i < columnsToAdd.length; i++) {

                var namedItem = cells.GetNamedItem(columnsToAdd[i]);
                if (namedItem != null) {
                    var val = namedItem.Text;
                    xml += "<" + columnsToAdd[i] + ">";
                    xml += cdataStart + val + cdataEnd;
                    xml += "</" + columnsToAdd[i] + ">";
                }
                else {
                    var itemdetailcell = cells.GetNamedItem("CHECK");
                    if (itemdetailcell == null) return;
                    var Querystringvalues = itemdetailcell.GetAttribute("persistcolumns");
                    if (Querystringvalues == null) return;
                    //Correct Querystringvalues
                    Querystringvalues = decodeURIComponent(Querystringvalues);
                    Querystringvalues = ReplaceAll(Querystringvalues, "+", " ");
                    //End correction
                    var QuerystringvaluesArr = Querystringvalues.split(':#');
                    var valueArray = new Array();
                    if (QuerystringvaluesArr != null || QuerystringvaluesArr != "undefined") {
                        for (var m = 0; m < QuerystringvaluesArr.length; m++) {
                            var Array1 = QuerystringvaluesArr[m].split(';$');
                            valueArray[Array1[0]] = Array1[1];
                        }
                    }
                    var val = valueArray[columnsToAdd[i]]
                    xml += "<" + columnsToAdd[i] + ">";
                    xml += cdataStart + val + cdataEnd;
                    xml += "</" + columnsToAdd[i] + ">";
                }

            }
            xml += "</" + row.Table.Name + ">";
        }
    }
    return xml;
}

function ltrim(s) {
    return s.replace(/^\s*/, "");
}

function rtrim(s) {
    return s.replace(/\s*$/, "");
}

function trim(s) {
    return rtrim(ltrim(s));
}

function UpdateXML(xml) 
{
    xml = trim(xml);
    if (xml != "")
    {
        xml = "<Data>" + xml + "</Data>";
    }

    window.parent.document.getElementById(window.parent._skidmap[controlUniqueId + "v"]).value = encodeURIComponent(xml);
    var el = window.parent.document.getElementById(window.parent._skidmap[controlUniqueId + "v"]);

    if (el != null) {
        var e = document.createEvent('HTMLEvents');
        e.initEvent('change', false, false);
        el.dispatchEvent(e);
    }
}
var fromHighlightRow = false;
var isFirstClick = true;
var uncheckedXmlValue = "";
function CheckBoxClick(gridId, tblName, colName, checkboxValue, originalCheckBoxValue) 
{
    var xml = _dgmap['persistlookupXml'];
    var enablemultselect = _dgmap['EM'];
    var selectedLookup = _dgmap['persistlookupName'];
    var grid = ISGetObject(gridId);
    var row = grid.Tables[unescape(tblName)].ToRowObject(grid.CheckedRowContext);
    var isChildRowChecked = false;
    // Read Only
    //debugger;
    if (!fromHighlightRow) {
        var isReadOnly = _dgmap['isReadOnlyGrid'];
        if (isReadOnly) {
            if (isFirstClick) {
                if (checkboxValue) {
                    isFirstClick = false;
                    row.Uncheck();
                }
                else {
                    isFirstClick = false;
                    row.Check();
                }
            }
            else {
                isFirstClick = true;
            }
            return;
        }
    }
    // End
    if (selectedLookup == row.Table.Caption) {
        // if the checked row belongs to allow selection lookup..
        if (row.Table.Parent != null) {

            var parentRow = row.GetParentRow();
            if (parentRow != null) {
                if (checkboxValue) {

                    if (enablemultselect == "false" && row.Table.Caption == selectedLookup) {
                        if (checkboxValue) {
                            var runXml = "";
                            var currentRowXml = "";
                            currentRowXml = GetPersistXmlForCurrentRow(row);
                            var parentrow = row.GetParentRow();
                            while (parentrow != null) {
                                currentRowXml = GetPersistXmlForPRAppendingCRXML(parentrow, currentRowXml, row);
                                parentrow = parentrow.GetParentRow();
                            }
                            runXml = xml;
                            if (runXml == "") {
                                if (!fromHighlightRow) 
                                {
                                    if (loadedOriginalXml == "<Data></Data>")
                                        loadedOriginalXml = "";
                                    runXml = loadedOriginalXml;
                                }
                            }
                            if (runXml != "" && currentRowXml!=runXml) 
                            {
                                UncheckPreviousCheckRow(runXml, row, grid);
                                return;
                            }

                            
                            if (currentRowXml!=runXml) {
                                xml = GetPersistXmlForCurrentRow(row);
                                var parentrow = row.GetParentRow();
                                while (parentrow != null) {
                                    xml = GetPersistXmlForPRAppendingCRXML(parentrow, xml, row);
                                    parentrow = parentrow.GetParentRow();
                                }
                                _dgmap['persistlookupXml'] = xml;
                                UpdateXML(xml);
                            }   
                        }
                    }
                    var cell = parentRow.GetCell(0).CellElement;
                    if (!cell.childNodes[0].checked)
                        parentRow.Check();
                }
                else {

                    var childRows = parentRow.GetChildRows();
                    for (var i = 0; i < childRows.length; i++) {
                        if (childRows[i].Checked) {
                            isChildRowChecked = true;
                            break;
                        }
                    }
                    if (!isChildRowChecked) {
                        if (enablemultselect == "false" && originalCheckBoxValue == null && row.Table.Caption == selectedLookup) {
                            _dgmap['persistlookupXml'] = "";
                            xml = "";
                            UpdateXML(xml);
                        }
                        var cell = parentRow.GetCell(0).CellElement;
                        if (cell.childNodes[0].checked) {
                            uncheckedXmlValue = GetCheckedRowXmlWithChildXml(row, uncheckedXmlValue);
                            parentRow.Uncheck();
                        }
                        else {
                            var uncheckedVal = GetCheckedRowXmlWithChildXml(row, uncheckedXmlValue);
                            loadedOriginalXml = ReplaceAll(loadedOriginalXml,uncheckedVal, "");
                            uncheckedXmlValue = "";
                            if (loadedOriginalXml == "<Data></Data>")
                                loadedOriginalXml = "";
                        }
                    }
                }
            }
            else {
                if (checkboxValue) {

                    if (enablemultselect == "false" && row.Table.Caption == selectedLookup) {
                        if (checkboxValue) 
                        {
                            var runXml = "";
                            var currentRowXml = GetPersistXmlForCurrentRow(row);
                            runXml = xml;
                            if (runXml == "") {
                                if (!fromHighlightRow) {
                                    if (loadedOriginalXml == "<Data></Data>")
                                        loadedOriginalXml = "";
                                    runXml = loadedOriginalXml;
                                }
                            }
                            if (runXml != "" && currentRowXml != runXml) {
                                UncheckPreviousCheckRow(runXml, row, grid);
                                return;
                            }

                            if (currentRowXml != runXml) {
                                xml = GetPersistXmlForCurrentRow(row);
                                _dgmap['persistlookupXml'] = xml;
                                UpdateXML(xml);
                            }
                            
                        }
                    }
                }
                //
                // { Rupesh M. Kokal }
                // When there are more records checked and a single record is unchecked, it 
                // comes to this part of code.
                // Below line used to raise a ajax call to update the FDG value to empty string.
                // But other checked rows present in the FDG are not considered.
                // The runner() method would check on the change and update the value of the FDG control, 
		// thus resulting in multiple value change via ajax call, which would fire the ondatachange 
		// for the FDG control twice if it is present.
                // Hence added the single selection mode check, wherein there is no multiselect allowed.
		// This kind of check is performed in the above code, but the below code seems to miss out
		// on the multiple selection check, which is now added.
                //
                else if (enablemultselect == "false" && originalCheckBoxValue == null && row.Table.Caption == selectedLookup) {
                    _dgmap['persistlookupXml'] = "";
                    xml = "";
                    UpdateXML(xml);
                }
                if (!checkboxValue) {
                    var uncheckedVal = GetCheckedRowXml(row);
                    loadedOriginalXml = ReplaceAll(loadedOriginalXml,uncheckedVal, "");
                    if (loadedOriginalXml == "<Data></Data>")
                        loadedOriginalXml = "";
                }
            }
        }
    }
    else {
        // if the row does not belongs to allow selection
        if (checkboxValue) {
            // if any of the child rows are cheked then proceed else call uncheck
            var isMatch = false;
            var childrows = row.GetChildRows();
            var childrow;
            if (childrows != null) {
                if (childrows.length > 0) {
                    childrow = childrows[0];
                }

                var childCheckedRows;
                if (childrow != undefined)
                    childCheckedRows = childrow.Table.GetCheckedRows();
                // loop throuh all of these chekedrows and see whether their parent row key value matches with the current row key value
                if (childCheckedRows != null) {
                    if (childCheckedRows.length > 0) {
                        for (var m = 0; m < childCheckedRows.length; m++) {
                            var childCheckedRow = childCheckedRows[m];
                            var checkedChildRowObject = childrow.Table.ToRowObject(childCheckedRow);
                            if (checkedChildRowObject.GetParentRow() != null) {
                                var ValueColumns = _compositemap[row.Table.Caption];
                                //loop for all the value columns
                                var chekedRowcells = row.GetCells();
                                var parentCheckedCells = checkedChildRowObject.GetParentRow().GetCells();
                                var chekedvalueArray = GetValueArray(chekedRowcells);
                                var parentvalueArray = GetValueArray(parentCheckedCells);
                                var valpermapcol = _valuepersistmap[row.Table.Caption];

                                for (var k = 0; k < ValueColumns.length; k++) {
                                    var valcasecorrected = valpermapcol[ValueColumns[k]];
                                    if (chekedRowcells.GetNamedItem(ValueColumns[k]) != null) {
                                        if (chekedRowcells.GetNamedItem(valcasecorrected).Text == parentCheckedCells.GetNamedItem(valcasecorrected).Text) {
                                            isMatch = true;
                                        }
                                        else {
                                            isMatch = false;
                                            break;
                                        }
                                    }
                                    else {
                                        if (chekedvalueArray[valcasecorrected] != undefined && parentvalueArray[valcasecorrected] != undefined) {
                                            if (chekedvalueArray[valcasecorrected] == parentvalueArray[valcasecorrected]) {
                                                isMatch = true;
                                            }
                                            else {
                                                isMatch = false;
                                                break;
                                            }
                                        }
                                    }

                                }
                                if (isMatch)
                                    break;
                            }
                            else {
                                isMatch = true;
                            }

                        }
                        if (isMatch) {
                            // let the selection go smooth
                            var parentRow;
                            if (row != null)
                                parentRow = row.GetParentRow();
                            if (parentRow != null) {
                                var cell = parentRow.GetCell(0).CellElement;
                                if (!cell.childNodes[0].checked)
                                    parentRow.Check();
                            }
                        }
                        else {
                            //none of the child rows were selected hence uncheck the current selection
                            row.Uncheck();
                        }
                        isModified = true;
                    }
                    else {
                        row.Uncheck();
                    }
                }
                else {
                    //none of the child rows were or undefined might be due to no child rows or the row is not expanded hence uncheck the current selection
                    row.Uncheck();
                }

            }
            else {
                // for the current selected row no child rows returned hence dont allow selection. this might be due to the non expansion of the row also..
                row.Uncheck();
            }

        }
        else {
            // trying to uncheck on not allowed selection section
            // if any of the child rows are cheked then proceed else call uncheck
            var childrows = row.GetChildRows();
            var childrow;
            if (childrows != null) {
                if (childrows.length > 0) {
                    childrow = childrows[0];
                }

                var childCheckedRows;
                if (childrow != undefined)
                    childCheckedRows = childrow.Table.GetCheckedRows();
                var isMatch = false;
                // loop throuh all of these chekedrows and see whether their parent row key value matches with the current row key value
                if (childCheckedRows != null) {
                    if (childCheckedRows.length > 0) {
                        for (var m = 0; m < childCheckedRows.length; m++) {
                            var childCheckedRow = childCheckedRows[m];
                            var checkedChildRowObject = childrow.Table.ToRowObject(childCheckedRow);
                            if (checkedChildRowObject.GetParentRow() != null) {
                                var ValueColumns = _compositemap[row.Table.Caption];
                                //loop for all the value columns
                                var chekedRowcells = row.GetCells();
                                var parentCheckedCells = checkedChildRowObject.GetParentRow().GetCells();

                                var chekedvalueArray = GetValueArray(chekedRowcells);
                                var parentvalueArray = GetValueArray(parentCheckedCells);
                                var valpermapcol = _valuepersistmap[row.Table.Caption];
                                for (var k = 0; k < ValueColumns.length; k++) {
                                    var valcasecorrected = valpermapcol[ValueColumns[k]];
                                    if (chekedRowcells.GetNamedItem(ValueColumns[k]) != null) {
                                        if (chekedRowcells.GetNamedItem(valcasecorrected).Text == parentCheckedCells.GetNamedItem(valcasecorrected).Text) {
                                            isMatch = true;
                                        }
                                        else {
                                            isMatch = false;
                                            break;
                                        }
                                    }
                                    else {
                                        if (chekedvalueArray[valcasecorrected] == parentvalueArray[valcasecorrected]) {
                                            isMatch = true;
                                        }
                                        else {
                                            isMatch = false;
                                            break;
                                        }
                                    }
                                }
                                if (isMatch)
                                    break;
                            }
                            //                        else 
                            //                        {
                            //                            isMatch = true;
                            //                        }

                        }
                        if (isMatch) {
                            // if the operation is uncheck and if any of the child is checked state you can not uncheck current row hence check it back.
                            row.Check();
                        }
                        else {
                            // for the current unselection of the selected row no child rows with checked found hence go to the parent and uncheck the same if available
                            var parent = row.GetParentRow();
                            if (parent != null && parent.Checked) {
                                uncheckedXmlValue = GetCheckedRowXmlWithChildXml(row, uncheckedXmlValue);
                                parent.Uncheck();
                            }
                            else {
                                var uncheckedVal = a = GetCheckedRowXmlWithChildXml(row, uncheckedXmlValue);
                                loadedOriginalXml = ReplaceAll(loadedOriginalXml,uncheckedVal, "");
                               uncheckedXmlValue = "";
                               if (loadedOriginalXml == "<Data></Data>")
                                   loadedOriginalXml = "";
                            }
                        }
                    }
                    else {
                        var parent = row.GetParentRow();
                        if (parent != null && parent.Checked) {
                            uncheckedXmlValue = GetCheckedRowXmlWithChildXml(row, uncheckedXmlValue);
                            parent.Uncheck();
                        }
                        else {
                            var uncheckedVal = GetCheckedRowXmlWithChildXml(row, uncheckedXmlValue);
                            loadedOriginalXml = ReplaceAll(loadedOriginalXml,uncheckedVal, "");
                            uncheckedXmlValue = "";
                            if (loadedOriginalXml == "<Data></Data>")
                                loadedOriginalXml = "";
                        }
                    }
                }


            }
        }
    }
    isModified = true;
}

function UncheckPreviousCheckRow(xml, row, grid)
 {
    //now it is unchecking the current selected row.
    if (row.Table.Parent != null) {

        var parentRow = row.GetParentRow();
        if (parentRow != null) {
            var childRows = parentRow.GetChildRows();
            for (var i = 0; i < childRows.length; i++) {
                if (childRows[i].Checked)
                 {

                    row.Uncheck();
                    alert(_dgmap['singleRowSelectMessage']);

                    break;
                }
               
            }
        }
        else if (row != null) {
            //  _dgmap['persistlookupXml'] = "";
            row.Uncheck();
            alert(_dgmap['singleRowSelectMessage']);

        }
      

    }
    isModified = true;
}


function GotoNextPageAndFind(grid, data, isSelected, table) {
    var grid = table.Grid;
    if (!isSelected) {
        if (grid.TotalLoadedRows < grid.TotalRows) {
            wgLoadMore("controlUniqueId");
            isSelected = SelRow(grid, data);
            // GotoNextPageAndFind(grid, data, isSelected) -- Infinite Loop
        }
        return;
    }
    else
        return;

}

function DisableRowHeader(row) {
}

function SelRow(selectedData, residingTable, isNested) 
{
    var isSelected = false;
    if (isNested) {
        for (i = 0; ; i++) {
            var row = residingTable; //this is now a row
            var chdRow = row.GetChildRow(i);
            var cells = chdRow.GetCells();
            var canBeSelected = false;
            for (var n = 0; n < selectedData.length; n++) {
                if (!(selectedData[n].childNodes.length > 1)) {
                    var selectedDataText = (selectedData[n].text !== undefined) ? selectedData[n].text : selectedData[n].textContent;
                    if (cells.GetNamedItem(selectedData[n].tagName).Text == selectedDataText)
                        canBeSelected = true;
                    else {
                        canBeSelected = false;
                        break;
                    }
                }
                else {
                    if (canBeSelected) {
                        //Current Row should not be selected
                        isSelected = false;
                        canBeSelected = false;
                        var expIndex = chdRow.RowElement.childNodes[0].innerHTML.indexOf("min-xp.gif");
                        if (!(expIndex > -1)) {
                            try {
                                chdRow.ExpandChildRow(true);
                            }
                            catch (Error)
                                { }
                           // if (_dgmap['EM'] == "false") 
                           // {
                                DisableRowHeader(chdRow);
                           // }                        
                        }
                        return SelRow(selectedData[n].childNodes, chdRow, true);
                    }
                }

            }
            if (canBeSelected) {
                chdRow.Select();
                isSelected = true;
                break;
            }
        }
    }
    else {
        grid = residingTable.Grid;
        for (i = 0; ; i++) {
            var row = residingTable.GetRow(i);

            if (row == null)
                break;
            else {
                var cells = row.GetCells();
                var canBeSelected = false;
                for (var n = 0; n < selectedData.length; n++) {
                    if (!(selectedData[n].childNodes.length > 1)) {
                        var selectedDataText = (selectedData[n].text !== undefined) ? selectedData[n].text : selectedData[n].textContent;
                        if (cells.GetNamedItem(selectedData[n].tagName).Text == selectedDataText)
                            canBeSelected = true;
                        else {
                            canBeSelected = false;
                            break;
                        }
                    }
                    else {
                        if (canBeSelected) {
                            //Current Row should not be selected
                            isSelected = false;
                            canBeSelected = false;
                            var expIndex = row.RowElement.childNodes[0].innerHTML.indexOf("min-xp.gif");
                            if (!(expIndex > -1)) {
                                try {
                                    row.ExpandChildRow(true);
                                } catch (Error) 
                                { 
                                }
                                //if (_dgmap['EM'] == "false") 
                               // {
                                    DisableRowHeader(row);
                                //}
                            }
                            return SelRow(selectedData[n].childNodes, row, true);
                        }
                    }

                }
                if (canBeSelected) {
                    row.Select();
                    isSelected = true;
                    break;
                }
            }
        }
    }
    return isSelected;
}

//var crowcount = 0;
//var pcheckedpos = 0;
//var prevrowcount = 0;
function CheckRow(selectedArr, residingTable, isNested)
 {
   
    var isChecked = false;
    if (isNested) {

        var checkedRows1 = 0;
        for (var i = 0; ; i++) {
            var row = residingTable; //this is now a row
            if (checkedRows1 == selectedArr.length)
                break;
            var chdRow = row.GetChildRow(i);
            if (chdRow == null)
                break;
            var cells = chdRow.GetCells();
            var canBeChecked = false;
            //pcheckedpos = chdRow.Postion;
            var ValueColumns = _compositemap[chdRow.Table.Caption];
            var valpermapcol = _valuepersistmap[chdRow.Table.Caption];
            var isValueColumn = false;
            for (var arCounter = 0; arCounter < selectedArr.length; arCounter++) {
                var selectedData = selectedArr[arCounter].childNodes;
                for (var n = 0; n < selectedData.length; n++) {
                    if (!(selectedData[n].childNodes[0].childNodes.length >= 1)) {
                        if (ValueColumns.length > 0) {
                            for (var k = 0; k < ValueColumns.length; k++) {
                                var valcasecorrected = valpermapcol[ValueColumns[k]];
                                if (selectedData[n].tagName != null && selectedData[n].tagName != "undefined") {
                                    if (selectedData[n].tagName == valcasecorrected) {
                                        isValueColumn = true; //if current column is found in value columns break.
                                        break;
                                    }
                                    else {
                                        isValueColumn = false;
                                    }
                                }
                            }
                        }
                        if (isValueColumn) {
                            if (cells.GetNamedItem(selectedData[n].tagName) != null) {
                                var selectedDataText = (selectedData[n].text !== undefined) ? selectedData[n].text : selectedData[n].textContent;
                                if (cells.GetNamedItem(selectedData[n].tagName).Text == selectedDataText)
                                    canBeChecked = true;
                                else {
                                    canBeChecked = false;
                                    break;
                                }
                            }
                            else {

                                var itemdetailcell = cells.GetNamedItem("CHECK");
                                if (itemdetailcell == null) return;
                                var Querystringvalues = itemdetailcell.GetAttribute("persistcolumns");
                                if (Querystringvalues == null) return;
                                //Correct Querystringvalues
                                Querystringvalues = decodeURIComponent(Querystringvalues);
                                Querystringvalues = ReplaceAll(Querystringvalues, "+", " ");
                                //End correction
                                var QuerystringvaluesArr = Querystringvalues.split(':#');
                                var valueArray = new Array();
                                if (QuerystringvaluesArr != null || QuerystringvaluesArr != "undefined") {
                                    for (var m = 0; m < QuerystringvaluesArr.length; m++) {
                                        var Array1 = QuerystringvaluesArr[m].split(';$');
                                        valueArray[Array1[0]] = Array1[1];
                                    }
                                }
                                if (selectedData[n].text == valueArray[selectedData[n].tagName]) {
                                    canBeChecked = true;
                                }
                                else {
                                    canBeChecked = false;
                                    break;
                                }

                                /*if (pcheckedpos != 0) {
                                if (_persistobject == null || typeof (_persistobject) == "undefined")
                                InitPersistedValues();
                                var index = prevrowcount;
                                var newrowValArr = _persistobject[chdRow.Table.Name][chdRow.Position + index];

                                if (newrowValArr[selectedData[n].tagName] == selectedData[n].text)
                                canBeChecked = true;
                                else {
                                canBeChecked = false;
                                break;
                                }
                                }
                                else {
                                if (_persistobject == null || typeof (_persistobject) == "undefined")
                                InitPersistedValues();
                                var rowValArr = _persistobject[chdRow.Table.Name][chdRow.Position];

                                if (rowValArr[selectedData[n].tagName] == selectedData[n].text)
                                canBeChecked = true;
                                else {
                                canBeChecked = false;
                                break;
                                }
                                }*/
                            }
                        }

                    }
                    else
                        break;
                } //child forloop
                if (canBeChecked) {
                    //Current Row should not be selected
                    /* if (_dgmap['EM'] == "false") 
                    {
                    var rowElement = chdRow.GetElement();
                    rowElement.style.setAttribute("backgroundColor", "#cde2ff", true); //working code#dae466
                    //grid.LayoutSettings.SelectedRowClass = "FormGridHighlightStyle";
                    // rowElement.style.className = "FormGridHighLightRowStyle";
                    }
                    else*/
                    chdRow.Check();
                    checkedRows1++;
                    if (!(n == selectedData.length)) {

                        var expIndex = chdRow.RowElement.innerHTML.indexOf("min-xp.gif");
                        if (!(expIndex > -1)) {
                            try {
                                chdRow.ExpandChildRow(true);
                            }
                            catch (Error)
                                { }
                           // if (_dgmap['EM'] == "false") 
                           // {
                                DisableRowHeader(chdRow);
                           // }
                        }

                        var arr = new Array();


                        for (var c = 0; c < selectedData.length; c++) {
                            if (selectedData[c].childNodes[0].childNodes.length >= 1)
                                arr.push(selectedData[c]);
                        }
                        CheckRow(arr, chdRow, true);
                        //                        if (row.GetChildRows() != null && row.GetChildRows() != "undefined") {
                        //                            //prevrowcount += (row.GetChildRows().length);
                        //                         
                        //                        }

                    }
                    break;
                }
            } //forloop
        }
    }
    else {
        grid = residingTable.Grid;
        var checkedRows = 0;
        var tablename = residingTable.Name;
        for (var h = 0; ; h++) {
            if (checkedRows == selectedArr.length)
                break;
            var row = residingTable.GetRow(h);
            if (row != null) {
                //                if (row.GetChildRows()!=null && row.GetChildRows() != "undefined")
                //                 {
                //                    crowcount += row.GetChildRows().length;
                //                    pcheckedpos = row.Position;
                //                }
            }
            if (row == null)
                break;
            else {
                var cells = row.GetCells();
                var canBeChecked = false;
                var ValueColumns = _compositemap[row.Table.Caption];
                var valpermapcol = _valuepersistmap[row.Table.Caption];
                var isValueColumn = false;
                for (var arCounter1 = 0; arCounter1 < selectedArr.length; arCounter1++) {
                    var selectedData = selectedArr[arCounter1];
                    for (var n = 0; n < selectedData.length; n++) {
                        if (!(selectedData[n].childNodes[0].childNodes.length >= 1)) {
                            if (ValueColumns.length > 0) {
                                for (var k = 0; k < ValueColumns.length; k++) {
                                    var valcasecorrected = valpermapcol[ValueColumns[k]];
                                    if (selectedData[n].tagName != null && selectedData[n].tagName != "undefined") {
                                        if (selectedData[n].tagName == valcasecorrected) {
                                            isValueColumn = true;
                                            break;
                                        }
                                        else {
                                            isValueColumn = false;
                                        }
                                    }
                                }
                            }

                            if (isValueColumn) {
                                if (cells.GetNamedItem(selectedData[n].tagName) != null) {
                                    var selectedDataText = (selectedData[n].text !== undefined) ? selectedData[n].text : selectedData[n].textContent;
                                    if (cells.GetNamedItem(selectedData[n].tagName).Text == selectedDataText)
                                        canBeChecked = true;
                                    else {
                                        canBeChecked = false;
                                        break;
                                    }


                                }
                                else {

                                    var itemdetailcell = cells.GetNamedItem("CHECK");
                                    if (itemdetailcell == null) return;
                                    var Querystringvalues = itemdetailcell.GetAttribute("persistcolumns");
                                    if (Querystringvalues == null) return;
                                    //Correct Querystringvalues
                                    Querystringvalues = decodeURIComponent(Querystringvalues);
                                    Querystringvalues = ReplaceAll(Querystringvalues, "+", " ");
                                    //End correction
                                    var QuerystringvaluesArr = Querystringvalues.split(':#');
                                    var valueArray = new Array();
                                    if (QuerystringvaluesArr != null || QuerystringvaluesArr != "undefined") {
                                        for (var m = 0; m < QuerystringvaluesArr.length; m++) {
                                            var Array1 = QuerystringvaluesArr[m].split(';$');
                                            valueArray[Array1[0]] = Array1[1];
                                        }
                                    }
                                    if (selectedData[n].text == valueArray[selectedData[n].tagName]) {
                                        canBeChecked = true;
                                    }
                                    else {
                                        canBeChecked = false;
                                        break;
                                    }
                                    /*if (_persistobject == null || typeof (_persistobject) == "undefined")
                                    InitPersistedValues();
                                    var rowValArr = _persistobject[row.Table.Name][row.Position];
                                    if (rowValArr[selectedData[n].tagName] == selectedData[n].text)
                                    canBeChecked = true;
                                    else {
                                    canBeChecked = false;
                                    break;
                                    }*/


                                }
                            }
                        }
                        else
                            break;
                    } //child forloop

                    if (canBeChecked) {

                        /* if (_dgmap['EM'] == "false") 
                        {
                        var rowElement = row.GetElement();
                        rowElement.style.setAttribute("backgroundColor", "#cde2ff", true); //working code
                        // rowElement.className += "FormGridHighlightStyle";
                        //rowElement.style.class = "FormGridHighlightStyle";
                        //grid.LayoutSettings.SelectedRowClass = "FormGridHighlightStyle";
                        // rowElement.style.className = "FormGridHighLightRowStyle";
                        }
                        else*/
                        row.Check();
                        //Remove this entry from Original Xml                        
                        loadedOriginalXml = ReplaceAll(loadedOriginalXml,selectedData[0].parentNode.xml, "");
                        if (loadedOriginalXml == "<Data></Data>")
                            loadedOriginalXml = "";
                        //Removed - only the unchecked ones are present
                        checkedRows++;
                        if (!(n == selectedData.length)) {
                            var expIndex = row.RowElement.innerHTML.indexOf("min-xp.gif");
                            if (!(expIndex > -1)) {
                                try {
                                    row.ExpandChildRow(true);
                                } catch (Error)
                                    { }
                                //In any condition the header will be disabled.
//                                if (_dgmap['EM'] == "false") 
//                                {
                                    DisableRowHeader(row);
                               // }   
                            }
                            var arr1 = new Array();

                            for (var c = 0; c < selectedData.length; c++) {
                                if (selectedData[c].childNodes[0].childNodes.length >= 1)
                                    arr1.push(selectedData[c]);
                            }
                            CheckRow(arr1, row, true);
                            //                            if (row.GetChildRows() != null && row.GetChildRows() != "undefined") {
                            //                                //prevrowcount = (crowcount - (row.GetChildRows().length));
                            //                               
                            //                            }
                        }

                        break;
                    }
                } //for loop
            }
        }
    }
}


//For Adding the User Preferences Layout options in Column Context Menu
var templatedirectory;
var saveUserPreferenceText;
var clearUserPreferenceText;
function UserPreferencesContextMenu(controlId, col, menu, isGroup, location) {


    for (var i = 0; i < menu.Items.length; i++) {

        if (i == 3 || i == 4 || i == 5 || i == 6) //Hiding the Groupby Field
        {
            menu.Items[i].Hide();
        }
    }

    var separator = new WebMenuItem();
    separator.Type = "Separator";
    separator.Name = "MySeparator";
    var menuItemGem = new WebMenuItem();
    menuItemGem.Text = saveUserPreferenceText;
    menuItemGem.Name = "LayoutSave";
    menuItemGem.OnClick = "SaveUserLayout('" + controlId + "')";
    menuItemGem.ImageURL = templatedirectory + "SkeltaForms/Images/icon-users-list.png";


    var menuItemGendan = new WebMenuItem();
    menuItemGendan.Text = clearUserPreferenceText;
    menuItemGendan.Name = "ResetLayout";
    menuItemGendan.OnClick = "ResetUserLayout('" + controlId + "')";
    menuItemGendan.ImageURL = templatedirectory + "SkeltaForms/Images/icon-reset.png";

    // Add Menu Separator and Menu Item    
    menu.Items.Add(separator);
    menu.Items.Add(menuItemGem);
    menu.Items.Add(menuItemGendan);
}

function SaveUserLayout(ctrlId) {
    var grid = ISGetObject(ctrlId);
    var key = "LayoutSave";  //
    grid.AddInput("UserLayout", key);
    grid.SendCustomRequest();
}
function ResetUserLayout(ctrlId) {
    var grid = ISGetObject(ctrlId);
    var key = "ResetLayout";
    grid.AddInput("UserLayout", key);
    grid.SendCustomRequest();
}

function ResetUserPreference() {
    window.location.href = window.location.href;
}

function HideGroupByItem(controlId, col, menu, isGroup, location) {
    for (var i = 0; i < menu.Items.length; i++) {

        if (i == 3 || i == 4 || i == 5 || i == 6) //Hiding the Groupby Field
        {
            menu.Items[i].Hide();
        }
    }

}

function ReplaceAll(Source, stringToFind, stringToReplace) {

    var temp = Source;

    var index = temp.indexOf(stringToFind);

    while (index != -1) {

        temp = temp.replace(stringToFind, stringToReplace);

        index = temp.indexOf(stringToFind);

    }

    return temp;
}
function GetCheckedRowXmlWithChildXml(checkedRow, childXml) {

    if (reset)
        childrowcount = 0;
    var checkedRowXml = "";
    var table = checkedRow.Table;
    var cells = checkedRow.GetCells();
    var columnsToAdd = _persistmap[table.Caption];
    var xml = "<" + table.Name + ">";
    for (var i = 0; i < columnsToAdd.length; i++) {

        var namedItem = cells.GetNamedItem(columnsToAdd[i]);
        if (namedItem != null) {
            var val = namedItem.Text;
            xml += "<" + columnsToAdd[i] + ">";
            xml += cdataStart + val + cdataEnd;
            xml += "</" + columnsToAdd[i] + ">";
        }
        else {
            var itemdetailcell = cells.GetNamedItem("CHECK");
            if (itemdetailcell == null) return;
            var Querystringvalues = itemdetailcell.GetAttribute("persistcolumns");
            if (Querystringvalues == null) return;
            //Correct Querystringvalues
            Querystringvalues = decodeURIComponent(Querystringvalues);
            Querystringvalues = ReplaceAll(Querystringvalues, "+", " ");
            //End correction
            var QuerystringvaluesArr = Querystringvalues.split(':#');
            var valueArray = new Array();
            if (QuerystringvaluesArr != null || QuerystringvaluesArr != "undefined") {
                for (var m = 0; m < QuerystringvaluesArr.length; m++) {
                    var Array1 = QuerystringvaluesArr[m].split(';$');
                    valueArray[Array1[0]] = Array1[1];
                }
            }
            var val = valueArray[columnsToAdd[i]]
            xml += "<" + columnsToAdd[i] + ">";
            xml += cdataStart + val + cdataEnd;
            xml += "</" + columnsToAdd[i] + ">";
        }

    }

    xml += childXml;
    xml += "</" + table.Name + ">";
    return xml;
}
function CheckRowForLoadMore(selectedArr, residingTable, isNested) {
    var isChecked = false;
    if (isNested) {

        var checkedRows1 = 0;
        for (var i = currentLoadedRows; ; i++) {
            var row = residingTable; //this is now a row
            if (checkedRows1 == selectedArr.length)
                break;
            var chdRow = row.GetChildRow(i);
            if (chdRow == null)
                break;
            var cells = chdRow.GetCells();
            var canBeChecked = false;
            var ValueColumns = _compositemap[chdRow.Table.Caption];
            var valpermapcol = _valuepersistmap[chdRow.Table.Caption];
            var isValueColumn = false;
            for (var arCounter = 0; arCounter < selectedArr.length; arCounter++) {
                var selectedData = selectedArr[arCounter].childNodes;
                for (var n = 0; n < selectedData.length; n++) {
                    if (!(selectedData[n].childNodes[0].childNodes.length >= 1)) {
                        if (ValueColumns.length > 0) {
                            for (var k = 0; k < ValueColumns.length; k++) {
                                var valcasecorrected = valpermapcol[ValueColumns[k]];
                                if (selectedData[n].tagName != null && selectedData[n].tagName != "undefined") {
                                    if (selectedData[n].tagName == valcasecorrected) {
                                        isValueColumn = true; //if current column is found in value columns break.
                                        break;
                                    }
                                    else {
                                        isValueColumn = false;
                                    }
                                }
                            }
                        }
                        if (isValueColumn) {
                            if (cells.GetNamedItem(selectedData[n].tagName) != null) {
                                var selectedDataText = (selectedData[n].text !== undefined) ? selectedData[n].text : selectedData[n].textContent;
                                if (cells.GetNamedItem(selectedData[n].tagName).Text == selectedDataText)
                                    canBeChecked = true;
                                else {
                                    canBeChecked = false;
                                    break;
                                }
                            }
                            else {

                                var itemdetailcell = cells.GetNamedItem("CHECK");
                                if (itemdetailcell == null) return;
                                var Querystringvalues = itemdetailcell.GetAttribute("persistcolumns");
                                if (Querystringvalues == null) return;
                                //Correct Querystringvalues
                                Querystringvalues = decodeURIComponent(Querystringvalues);
                                Querystringvalues = ReplaceAll(Querystringvalues, "+", " ");
                                //End correction
                                var QuerystringvaluesArr = Querystringvalues.split(':#');
                                var valueArray = new Array();
                                if (QuerystringvaluesArr != null || QuerystringvaluesArr != "undefined") {
                                    for (var m = 0; m < QuerystringvaluesArr.length; m++) {
                                        var Array1 = QuerystringvaluesArr[m].split(';$');
                                        valueArray[Array1[0]] = Array1[1];
                                    }
                                }
                                if (selectedData[n].text == valueArray[selectedData[n].tagName]) {
                                    canBeChecked = true;
                                }
                                else {
                                    canBeChecked = false;
                                    break;
                                }
                            }
                        }

                    }
                    else
                        break;
                } //child forloop
                if (canBeChecked) {
                    chdRow.Check();
                    checkedRows1++;
                    if (!(n == selectedData.length)) {

                        var expIndex = chdRow.RowElement.innerHTML.indexOf("min-xp.gif");
                        if (!(expIndex > -1)) {
                            try {
                                chdRow.ExpandChildRow(true);
                            }
                            catch (Error) {
                            }
                            DisableRowHeader(chdRow);
                        }

                        var arr = new Array();


                        for (var c = 0; c < selectedData.length; c++) {
                            if (selectedData[c].childNodes[0].childNodes.length >= 1)
                                arr.push(selectedData[c]);
                        }
                        CheckRow(arr, chdRow, true);
                    }
                    break;
                }
            } //forloop
        }
    }
    else {
        grid = residingTable.Grid;
        var checkedRows = 0;
        var tablename = residingTable.Name;
        for (var h = 0; ; h++) {
            if (checkedRows == selectedArr.length)
                break;
            var row = residingTable.GetRow(h);

            if (row == null)
                break;
            else {
                var cells = row.GetCells();
                var canBeChecked = false;
                var ValueColumns = _compositemap[row.Table.Caption];
                var valpermapcol = _valuepersistmap[row.Table.Caption];
                var isValueColumn = false;
                for (var arCounter1 = 0; arCounter1 < selectedArr.length; arCounter1++) {
                    var selectedData = selectedArr[arCounter1];
                    for (var n = 0; n < selectedData.length; n++) {
                        if (!(selectedData[n].childNodes[0].childNodes.length >= 1)) {
                            if (ValueColumns.length > 0) {
                                for (var k = 0; k < ValueColumns.length; k++) {
                                    var valcasecorrected = valpermapcol[ValueColumns[k]];
                                    if (selectedData[n].tagName != null && selectedData[n].tagName != "undefined") {
                                        if (selectedData[n].tagName == valcasecorrected) {
                                            isValueColumn = true;
                                            break;
                                        }
                                        else {
                                            isValueColumn = false;
                                        }
                                    }
                                }
                            }

                            if (isValueColumn) {
                                if (cells.GetNamedItem(selectedData[n].tagName) != null) {
                                    var selectedDataText = (selectedData[n].text !== undefined) ? selectedData[n].text : selectedData[n].textContent;
                                    if (cells.GetNamedItem(selectedData[n].tagName).Text == selectedDataText)
                                        canBeChecked = true;
                                    else {
                                        canBeChecked = false;
                                        break;
                                    }
                                }
                                else {

                                    var itemdetailcell = cells.GetNamedItem("CHECK");
                                    if (itemdetailcell == null) return;
                                    var Querystringvalues = itemdetailcell.GetAttribute("persistcolumns");
                                    if (Querystringvalues == null) return;
                                    //Correct Querystringvalues
                                    Querystringvalues = decodeURIComponent(Querystringvalues);
                                    Querystringvalues = ReplaceAll(Querystringvalues, "+", " ");
                                    //End correction
                                    var QuerystringvaluesArr = Querystringvalues.split(':#');
                                    var valueArray = new Array();
                                    if (QuerystringvaluesArr != null || QuerystringvaluesArr != "undefined") {
                                        for (var m = 0; m < QuerystringvaluesArr.length; m++) {
                                            var Array1 = QuerystringvaluesArr[m].split(';$');
                                            valueArray[Array1[0]] = Array1[1];
                                        }
                                    }
                                    if (selectedData[n].text == valueArray[selectedData[n].tagName]) {
                                        canBeChecked = true;
                                    }
                                    else {
                                        canBeChecked = false;
                                        break;
                                    }
                                }
                            }
                        }
                        else
                            break;
                    } //child forloop

                    if (canBeChecked) {
                        row.Check();
                        checkedRows++;
                        if (!(n == selectedData.length)) {
                            var expIndex = row.RowElement.innerHTML.indexOf("min-xp.gif");
                            if (!(expIndex > -1)) {
                                try {
                                    row.ExpandChildRow(true);
                                } catch (Error)
                                    { }
                                DisableRowHeader(row);

                            }
                            var arr1 = new Array();

                            for (var c = 0; c < selectedData.length; c++) {
                                if (selectedData[c].childNodes[0].childNodes.length >= 1)
                                    arr1.push(selectedData[c]);
                            }
                            CheckRow(arr1, row, true);
                        }

                        break;
                    }
                } //for loop
            }
        }
    }
}


