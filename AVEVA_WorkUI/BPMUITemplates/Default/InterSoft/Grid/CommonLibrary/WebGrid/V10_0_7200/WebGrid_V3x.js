﻿WebGrid.prototype.GettbGBBElement=function(){return this.GetElement(WG40.GROUPBYBOX,WG40.HTMLTABLE)};WebGrid.prototype.GettrGBBInfoElement=function(){return this.GetElement(WG40.GROUPBYBOXLABEL,WG40.HTMLROW)};WebGridTable.prototype.GetdvCHElement=function(a){return this.GetElement(WG40.COLHEADER,WG40.HTMLDIV,a)};WebGridTable.prototype.GetdvCFElement=function(a){return this.GetElement(WG40.COLFOOER,WG40.HTMLDIV,a)};WebGridTable.prototype.GettbCHElement=function(a){return this.GetElement(WG40.COLHEADER,WG40.HTMLTABLE,a)};WebGridTable.prototype.GetdvTBElement=function(a){return this.GetElement(WG40.BODY,WG40.HTMLDIV,a)};WebGridTable.prototype.GettbTBElement=function(a){return this.GetElement(WG40.BODY,WG40.HTMLTABLE,a)};WebGridTable.prototype.GetCGHElement=function(a){return this.GetElement(WG40.COLHEADERGROUP,null,a)};WebGridTable.prototype.GetCGElement=function(a){return this.GetElement(WG40.COLGROUP,null,a)};WebGridTable.prototype.GetCGFElement=function(a){return this.GetElement(WG40.COLFOOTERGROUP,null,a)};WebGridTable.prototype.GettbCFElement=function(a){return this.GetElement(WG40.COLFOOTER,WG40.HTMLTABLE,a)};WebGridTable.prototype.HasMultiPrimaryKey=function(){return this.HasMultiPrimaryKey};WebGridTable.prototype.GetDataKeyFields=function(){return this.DataKeyFields};WebGridTable.prototype.IsSelfRefTable=function(){return this.SelfReferencingSettings.Enabled};WebGridTable.prototype.GetExpandColumnName=function(){return this.SelfReferencingSettings.ExpandColumnMember};WebGridTable.prototype.IsSelfRefLoadOnDemand=function(){return this.SelfReferencingSettings.LoadOnDemand};WebGridTable.prototype.HasColumnFooters=function(){return this.Get("ColumnFooters")=="Yes"};WebGridTable.prototype.IsAllowFilter=function(a){return this.Get("AllowFilter")=="Yes"};WebGridTable.prototype.IsAllowSelectColumns=function(){return this.Get("AllowSelectColumns")=="Yes"};WebGridTable.prototype.IsHideColumns=function(){return this.Get("HideColumnsWhenGrouped")=="Yes"};WebGridTable.prototype.IsAllowEdit=function(){return this.Get("AllowFilter")=="Yes"};WebGridTable.prototype.GetParentTable=function(){return this.Parent};WebGridTable.prototype.IsUseColumnSet=function(){return this.IsUseColumnSet};WebGridTable.prototype.GetColumnSetRowCount=function(){return this.ColumnSetSettings.RowCount};WebGridTable.prototype.HasPreviewRow=function(){return this.IsPreviewRowVisible};WebGridTable.prototype.GetColumns=function(){return this.Columns};function wgProcessMouseEvents(a,b,c){return WGEventEngine.ProcessMouseEvents(a,b,c)}function wgGetContentSpan(a){return WGEventEngine.GetContentSpan(a)}function wgHighlightRow(c,d,a,b,e){return WGEventEngine.HighlightRow(c,d,a,b,e)}function wgEnsureCellVisible(b,a){return WGEventEngine.EnsureCellVisible(b,a)}function wgHighlightCell(a,d,b,c,e){return WGEventEngine.HighlightCell(a,d,b,c,e)}function wgSelectRow(b,a){return WGEventEngine.SelectRow(b,a)}function wgProcessInitialEdit(a){return WGEditEngine.ProcessInitialEdit(a)}function wgClearEditCell(a){return WGEditEngine.ClearEditCell(a)}function wgHighlightEditCell(a,b,c){return WGEditEngine.HighlightEditCell(a,b,c)}function wgActivateEditMode(a,b){return WGEditEngine.ActivateEditMode(a,b)}function wgExitEdit(c,d,a,b){return WGEditEngine.ExitEdit(c,d,a,b)}function wgEnsureEditFocus(a){return WGEditEngine.EnsureEditFocus(a)}function wgExitEditMode(a,b){return WGEditEngine.ExitEditMode(a,b)}function wgCancelChanges(a){return WGEditEngine.CancelChanges(a)}function wgAcceptChanges(b,a){return WGEditEngine.AcceptChanges(b,a)}function wgEnsureAECFocus(a,b){return WGEditEngine.EnsureActiveEditCellFocus(a,b)}function wgMarkEdit(a){return WGEditEngine.MarkEdit(a)}function wgSetLastSelectedObject(a){return WG50Engine.SetLastSelectedObject(a)}function wgUpdateState(a){return WG50Engine.UpdateState(a)}function wgSetCheckedRowsData(a){return WG50Engine.SetCheckedRowsData(a)}if(typeof(WebGridSubTable)!="undefined"){WebGridSubTable.prototype.GettbCHElement=function(){return this.GetElement(WG40.COLHEADER,WG40.HTMLTABLE)};WebGridSubTable.prototype.GetdvCFElement=function(){return this.GetElement(WG40.COLFOOER,WG40.HTMLDIV)};WebGridSubTable.prototype.GettbCFElement=function(){return this.GetElement(WG40.COLFOOTER,WG40.HTMLTABLE)};WebGridTable.prototype.GettbTBElement=function(){return this.GetElement(WG40.BODY,WG40.HTMLTABLE)}}if(typeof(Sys)!="undefined"){Sys.Application.notifyScriptLoaded()};