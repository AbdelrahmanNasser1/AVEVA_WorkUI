
// Generated by Intersoft Script Optimizer V1.5 + Intersoft JS Engine MaxObfuscate(tm) V1.0 
// Generated Datetime : 12/7/2005 1:44:24 PM
// Copyright (c) 2005 Intersoft Solutions.
// Unauthorized decryption/reproduction of any codes contained herein is strictly prohibited and will result in severe civil and criminal penalties .
//**Start Encode**
WebGrid.prototype.GettbGBBElement =function(){ return this.GetElement(WG40.GROUPBYBOX,WG40.HTMLTABLE);};WebGrid.prototype.GettrGBBInfoElement =function(){ return this.GetElement(WG40.GROUPBYBOXLABEL,WG40.HTMLROW);};WebGridTable.prototype.GetdvCHElement =function(row){ return this.GetElement(WG40.COLHEADER,WG40.HTMLDIV,row);};WebGridTable.prototype.GetdvCFElement =function(row){ return this.GetElement(WG40.COLFOOER,WG40.HTMLDIV,row);};WebGridTable.prototype.GettbCHElement =function(row){ return this.GetElement(WG40.COLHEADER,WG40.HTMLTABLE,row);};WebGridTable.prototype.GetdvTBElement =function(row){ return this.GetElement(WG40.BODY,WG40.HTMLDIV,row);};WebGridTable.prototype.GettbTBElement =function(row){ return this.GetElement(WG40.BODY,WG40.HTMLTABLE,row);};WebGridTable.prototype.GetCGHElement =function(row){ return this.GetElement(WG40.COLHEADERGROUP,null,row);};WebGridTable.prototype.GetCGElement =function(row){ return this.GetElement(WG40.COLGROUP,null,row);};WebGridTable.prototype.GetCGFElement =function(row){ return this.GetElement(WG40.COLFOOTERGROUP,null,row);};WebGridTable.prototype.GettbCFElement =function(row){ return this.GetElement(WG40.COLFOOTER,WG40.HTMLTABLE,row);};WebGridTable.prototype.HasMultiPrimaryKey =function(){ return this.HasMultiPrimaryKey;}; WebGridTable.prototype.GetDataKeyFields =function(){ return this.DataKeyFields;}; WebGridTable.prototype.IsSelfRefTable =function(){ return this.SelfReferencingSettings.Enabled;}; WebGridTable.prototype.GetExpandColumnName =function(){ return this.SelfReferencingSettings.ExpandColumnMember;}; WebGridTable.prototype.IsSelfRefLoadOnDemand =function(){ return this.SelfReferencingSettings.LoadOnDemand;}; WebGridTable.prototype.HasColumnFooters =function(){ return this.Get("ColumnFooters")=="Yes";}; WebGridTable.prototype.IsAllowFilter =function(row){ return this.Get("AllowFilter")=="Yes";}; WebGridTable.prototype.IsAllowSelectColumns =function(){ return this.Get("AllowSelectColumns")=="Yes";};WebGridTable.prototype.IsHideColumns =function(){ return this.Get("HideColumnsWhenGrouped")=="Yes";};  WebGridTable.prototype.IsAllowEdit =function(){ return this.Get("AllowFilter")=="Yes";}; WebGridTable.prototype.GetParentTable =function(){ return this.Parent;};  WebGridTable.prototype.IsUseColumnSet =function(){ return this.IsUseColumnSet;}; WebGridTable.prototype.GetColumnSetRowCount =function(){ return this.ColumnSetSettings.RowCount;};WebGridTable.prototype.HasPreviewRow =function(){ return this.IsPreviewRowVisible;}; WebGridTable.prototype.GetColumns =function(){ return this.Columns;};function wgProcessMouseEvents(v4e812,v0c934,v85253){ return wg60540.medb21(v4e812,v0c934,v85253);}function wgGetContentSpan(vea512){ return wg60540.m31885(vea512);}function wgHighlightRow(v7df12,v2ce34,vdd053,v2b196,ve2d99){ return wg60540.ma5e17(v7df12,v2ce34,vdd053,v2b196,ve2d99);}function wgEnsureCellVisible(v8d112,v44034){ return wg60540.m7794(v8d112,v44034);}function wgHighlightCell(v93712,v1e334,v14853,vafe96,vb1b99){ return wg60540.mf6937(v93712,v1e334,v14853,vafe96,vb1b99);}function wgSelectRow(v6fb12,vc6834){ return wg60540.me2c56(v6fb12,vc6834);}function wgProcessInitialEdit(v9f135){ return wg9c911.m15b94(v9f135);}function wgClearEditCell(v4d135){ return wg9c911.m8c187(v4d135);}function wgHighlightEditCell(v77735,vc4227,vdbb52){ return wg9c911.m96a77(v77735,vc4227,vdbb52);}function wgActivateEditMode(v83235,v2d727){ return wg9c911.m27a2(v83235,v2d727);}function wgExitEdit(v3d135,v83227,ve5b52,v7bd10){ return wg9c911.m5a567(v3d135,v83227,ve5b52,v7bd10);}function wgEnsureEditFocus(vf2235){ return wg9c911.m38516(vf2235);}function wgExitEditMode(v3d535,vae727){ return wg9c911.m24018(v3d535,vae727);}function wgCancelChanges(v35235){ return wg9c911.ma1d95(v35235);}function wgAcceptChanges(v39335,v0e627){ return wg9c911.md3746(v39335,v0e627);}function wgEnsureAECFocus(v46335,v71827){ return wg9c911.m38065(v46335,v71827);}function wgMarkEdit(v0c035){ return wg9c911.m55a32(v0c035);}function wgSetLastSelectedObject(va2035){ return wg38213.m00d46(va2035);}function wgUpdateState(v9d135){ return wg38213.m97218(v9d135);}function wgSetCheckedRowsData(v3d935){ return wg38213.mb0b27(v3d935);}if (typeof(WebGridSubTable)!="undefined"){ WebGridSubTable.prototype.GettbCHElement =function() { return this.GetElement(WG40.COLHEADER,WG40.HTMLTABLE); }; WebGridSubTable.prototype.GetdvCFElement =function() { return this.GetElement(WG40.COLFOOER,WG40.HTMLDIV); }; WebGridSubTable.prototype.GettbCFElement =function() { return this.GetElement(WG40.COLFOOTER,WG40.HTMLTABLE); }; WebGridTable.prototype.GettbTBElement =function() { return this.GetElement(WG40.BODY,WG40.HTMLTABLE); };}