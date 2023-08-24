﻿function ISDataSet(){this._Type="ISDataSet";ISObject.call(this);this.Type="DataSet";this.Name=null;this.DataSetName=null;this.Tables=new ISArray()}function ISDataTable(a){this._Type="ISDataTable";ISObject.call(this);this.Type="DataTable";this.Name=null;this.TableName=null;this.Columns=new ISArray();this.Rows=new ISArray();this.DataSet=a;this.DefaultView=null;this.NewRow=function(){return ISDataTableEngine.NewRow(this)};this.GetDefaultView=function(){if(this.DefaultView==null){if(typeof(ISDataView)!="undefined"){this.DefaultView=new ISDataView(this);return this.DefaultView}}return this.DefaultView}}function ISDataCell(a){this._Type="ISDataCell";ISObject.call(this);this.Type="DataCell";this.Name=a.ColumnName;this.Column=a;this.Row=null;this.Value=null}var ISDataTableEngine={NewRow:function(b){var c=new ISDataRow();for(var a=0;a<b.Columns.length;a++){c.Cells.Add(new ISDataCell(b.Columns[a]))}c.Table=b;return c}};function ISDataRow(){this._Type="ISDataRow";ISObject.call(this);this.Type="DataRow";this.Cells=new ISArray();this.ObjectContext=null;this.Table=null}function ISDataColumn(a){this._Type="ISDataColumn";ISObject.call(this);this.Type="DataColumn";this.Name=null;this.DataType=null;this.ColumnName=null;this.Table=a;this.AutoIncrement=false;this.DefaultValue=null;this.ReadOnly=false;this.Unique=false}var ISADONETMappingEngine={IsADONETXmlData:function(f){var b=false;var c;var d;try{d=ISADONETMappingEngine.GetXMLWithNamespaces(f);c=ISXml.GetNode(d,"//xs:schema")}catch(a){return false}if(c!=null){if(ISXml.GetAttribute(c,"xmlns:msdata")=="urn:schemas-microsoft-com:xml-msdata"||ISXml.GetAttribute(c,"msdata")=="urn:schemas-microsoft-com:xml-msdata"){b=true}}return b},GetXMLWithNamespaces:function(b){var a;if(b.xml.indexOf("xs:schema")>-1){a=ISXml.CreateXmlDocument();a.loadXML(b.xml);a.setProperty("SelectionNamespaces",'xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:diffgr="urn:schemas-microsoft-com:xml-diffgram-v1" xmlns:msdata="urn:schemas-microsoft-com:xml-msdata"')}return a},MappingJsonToObject:function(a){var b=null;if(typeof(a.__type)!="undefined"){b=a.__type}else{b=a.Type}if(b.indexOf("ISDataSet")>-1){return ISADONETMappingEngine.MappingJsonToDataSet(a)}else{return ISADONETMappingEngine.MappingJsonToDataTable(a)}},MappingJsonToDataSet:function(e){var a=new ISDataSet();a.Name=a.DataSetName=e.DataSetName;for(var c=0;c<e.Tables.length;c++){var b=e.Tables[c];var d=ISADONETMappingEngine.MappingJsonToDataTable(b);d.DataSet=a;a.Tables.Add(d)}return a},MappingJsonToDataTable:function(c){var g=new ISDataTable();g.Name=g.TableName=c.TableName;for(var h=0;h<c.Columns.length;h++){var a=c.Columns[h];var e=new ISDataColumn(g);e.Name=e.ColumnName=a.ColumnName;if(typeof(a.DataType)!="undefined"){e.DataType=a.DataType}else{e.DataType="System.String"}if(typeof(a.Unique)!="undefined"){e.Unique=a.Unique}if(typeof(a.ReadOnly)!="undefined"){e.ReadOnly=a.ReadOnly}if(typeof(a.AutoIncrement)!="undefined"){e.AutoIncrement=a.AutoIncrement}if(typeof(a.DefaultValue)!="undefined"){e.DefaultValue=a.DefaultValue}g.Columns.Add(e)}for(var i=0;i<c.Rows.length;i++){var b=c.Rows[i];var f=new ISDataRow();f.Table=g;for(var m=0;m<b.Cells.length;m++){var d=new ISDataCell(g.Columns[m]);d.Value=b.Cells[m];d.Row=f;f.Cells.push(d)}g.Rows.Add(f)}return g},MappingToObject:function(d){var c=ISADONETMappingEngine.CreateObjectSchema(d);var b=ISXml.GetNode(d,"//diffgr:diffgram");if(b!=null){var a=b.childNodes[0];if(a.nodeName!="DocumentElement"){ISADONETMappingEngine.RetrieveDataSetData(c,a)}else{ISADONETMappingEngine.RetrieveDataTableData(c,ISXml.GetNodes(a,c.TableName))}}return c},CreateObjectSchema:function(e){var c=null;var d=ISXml.GetNode(e,"//xs:schema");if(d!=null){var a=d.childNodes[0];var b=ISXml.GetAttribute(a,"msdata:MainDataTable");if(b==null||b==""){c=ISADONETMappingEngine.CreateDataSetSchema(d)}else{c=ISADONETMappingEngine.CreateDataTableSchema(d.childNodes[0].childNodes[0].childNodes[0].childNodes[0])}}return c},CreateDataSetSchema:function(f){var a=f.childNodes[0];var e=new ISDataSet();e.Name=e.DataSetName=ISXml.GetAttribute(a,"name");var c=ISXml.GetNode(a,"xs:complexType").childNodes[0];var b;for(var d=0;d<c.childNodes.length;d++){b=c.childNodes[d];if(b.nodeType==1){e.Tables.Add(ISADONETMappingEngine.CreateDataTableSchema(b,e))}}return e},CreateDataTableSchema:function(b,a){var c=new ISDataTable(a);c.Name=c.TableName=ISXml.GetAttribute(b,"name");c.Columns=ISADONETMappingEngine.CreateDataColumnsSchema(b.childNodes[0].childNodes[0],c);return c},CreateDataColumnsSchema:function(b,c){var e=new ISArray();var a;for(var d=0;d<b.childNodes.length;d++){a=b.childNodes[d];if(a.nodeType==1){e.Add(ISADONETMappingEngine.CreateDataColumnSchema(a,c))}}return e},CreateDataColumnSchema:function(a,b){var c=new ISDataColumn(b);c.Name=c.ColumnName=ISXml.GetAttribute(a,"name");var d=ISXml.GetAttribute(a,"type");if(d!=null){c.DataType=d.replace("xs:","")}else{ISADONETMappingEngine.MappingDataType(c,a)}return c},MappingDataType:function(a,b){var c=ISXml.GetNode(b,"//xs:restriction");if(c!=null){a.DataType=ISXml.GetAttribute(c,"base").replace("xs:","")}},RetrieveDataSetData:function(b,c){var d,a;for(var e=0;e<b.Tables.length;e++){d=b.Tables[e];a=ISXml.GetNodes(c,d.TableName);ISADONETMappingEngine.RetrieveDataTableData(d,a)}},RetrieveDataTableData:function(b,a){for(var c=0;c<a.length;c++){ISADONETMappingEngine.RetrieveDataRowData(b,a[c])}},RetrieveDataRowData:function(d,c){var f=d.NewRow();var a,b;for(var e=0;e<c.childNodes.length;e++){b=c.childNodes[e];a=f.Cells.GetNamedItem(b.nodeName);a.Row=f;ISADONETMappingEngine.MappingDataCell(a,b)}d.Rows.Add(f);f.Table=d},MappingDataCell:function(a,b){switch(a.Column.DataType){case"int":case"integer":case"float":case"double":case"byte":case"decimal":case"long":case"short":case"unsignedByte":case"unsignedInt":case"unsignedShort":case"unsignedLong":case"negativeInteger":a.Value=parseFloat(b.text);break;case"dateTime":a.Value=ISADONETMappingEngine.ConvertToDateTime(b.text);break;case"boolean":a.Value=b.text.toLowerCase()=="true";break;case"string":case"base64":case"base64Binary":case"duration":a.Value=b.text;break}},ConvertToDateTime:function(c){var f="([0-9]{4})(-([0-9]{2})(-([0-9]{2})(T([0-9]{2}):([0-9]{2})(:([0-9]{2})(.([0-9]+))?)?(Z|(([-+])([0-9]{2}):([0-9]{2})))?)?)?)?";var a=c.match(new RegExp(f));var e=0;var b=new Date(a[1],0,1);if(a[3]){b.setMonth(a[3]-1)}if(a[5]){b.setDate(a[5])}if(a[7]){b.setHours(a[7])}if(a[8]){b.setMinutes(a[8])}if(a[10]){b.setSeconds(a[10])}if(a[12]){b.setMilliseconds(Number("0."+a[12])*1000)}if(a[14]){e=(Number(a[16])*60)+Number(a[17]);e*=((a[15]=="-")?1:-1)}e-=b.getTimezoneOffset();time=(Number(b)+(e*60*1000));b.setTime(Number(time));return b}};