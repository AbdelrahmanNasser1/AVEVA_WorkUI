
// Generated by Intersoft Script Optimizer V1.5 + Intersoft JS Engine MaxObfuscate(tm) V1.0 
// Generated Datetime : 12/7/2005 1:44:16 PM
// Copyright (c) 2005 Intersoft Solutions.
// Unauthorized decryption/reproduction of any codes contained herein is strictly prohibited and will result in severe civil and criminal penalties .
//**Start Encode**
var wg20949 ={ mbe284:function(v91151) { var vec860 =new Menu(); var v59455 =v91151.GetGrid(); var v3b365 =v59455.LayoutSettings.ImageSettings.Folder; var v85b93 =new Menu(); var v74a85 =v91151.Columns; var vc0b42 =""; for (var v12d74=0; v12d74<v74a85.length; v12d74++) { var v4bb56 =""; if (v74a85[v12d74].ShowInSelectColumns =="Yes") { if (v74a85[v12d74].Visible)v4bb56 ="checked"; vc0b42 =v74a85[v12d74].Caption; if (vc0b42.indexOf("<")>=0 &&vc0b42.indexOf(">")>=0)vc0b42 =v74a85[v12d74].Name; v85b93.add(new MenuItem("<input hideFocus colName='" +v74a85[v12d74].Name +"' onclick=\"event.cancelBubble='false'; return false;\" type=checkbox " +v4bb56 +">&nbsp;" +vc0b42,function(){wg20949.md4539(this)})); v85b93.items[v85b93.items.length-1].alwaysVisible =true; } } v85b93.add(new MenuSeparator()); v85b93.add(new MenuItem(v59455.GetString("ContextMenu/Column/ApplyChanges"),function(){wg20949.md8c93(this,v85b93);})); v85b93.add(new MenuItem(v59455.GetString("ContextMenu/Column/Reset"),function(){wg20949.m37b89(this,v85b93);})); vec860.add(new MenuItem(v59455.GetString("ContextMenu/Column/SortAsc"),function(){wg20949.me2561(this,"ASC")},v3b365 +wg_Global.SortAscImage)); vec860.add(new MenuItem(v59455.GetString("ContextMenu/Column/SortDesc"),function(){wg20949.me2561(this,"DESC")},v3b365 +wg_Global.SortDescImage)); vec860.add(new MenuSeparator()); vec860.add(new MenuItem(v59455.GetString("ContextMenu/Column/GroupByThisField"),function(){wg20949.m78591(this)},v3b365 +wg_Global.GroupImage)); vec860.add(new MenuItem(v59455.GetString("ContextMenu/Column/GroupByBox"),function(){wg20949.mafb31(this)},v3b365 +wg_Global.GroupByBoxImage)); vec860.add(new MenuSeparator()); vec860.add(new MenuItem(v59455.GetString("ContextMenu/Column/RemoveColumn"),function(){wg20949.m8bc68(this);})); vec860.add(new MenuItem(v59455.GetString("ContextMenu/Column/BestFit"),function(){wg20949.m86474(this);})); vec860.add(new MenuItem(v59455.GetString("ContextMenu/Column/FilterBar"),function(){wg20949.mf9c65(this);},v3b365 +wg_Global.FilterRowImage )); vec860.add(new MenuSeparator()); vec860.add(new MenuItem(v59455.GetString("ContextMenu/Column/SelectColumns"),null,v3b365 +wg_Global.SelectColumnImage,v85b93)); v91151.ColumnMenu =vec860; },  mdc492:function(vce641,v0fb43,v40b48,v90322) { var v77851 =new OffsetLocation(); var vbf470 =10;  if (IS.moz)vbf470 =100; v77851.X =event.clientX; v77851.Y =event.clientY;  doHideWindowPopups(); vce641.HeaderContext =event.srcElement; switch(v90322) { case "Column": setTimeout(function(){wg20949.m2c322(v0fb43,v40b48,v77851); },vbf470 ); break; case "GroupColumn": setTimeout(function(){wg20949.m2c322(v0fb43,true,v77851); },vbf470 ); break; case "Cell": case "GroupCell": case "FilterColumn": setTimeout(function(){wg20949.m24390(null,null,v0fb43,v77851); },vbf470 ); break; } },  m2c322:function(v96475,ve244,ve2c42) { var va8063; var grid,table; if (ve244) { grid =ISGetObject(v96475.gridId); table =grid.Tables[v96475.tblName]; va8063 =table.Columns.GetNamedItem(v96475.colName); } else { va8063 =wg38213.m4f814(v96475); grid =va8063.GetGrid(); table =grid.Tables[va8063.Table.Id]; } if (table.ColumnMenu ==null ||table.ColumnMenu.items.length ==0) wg20949.mbe284(table);  if (grid.LastEditObj)grid.ExitEdit(); var v18b37 =table.ColumnMenu; v18b37.SetCssFile(grid);  wg_Global.ColumnContext =va8063; wg_Global.EventContext =event; if (ve244 ||va8063.Get("AllowSorting")=="Yes") { v18b37.items[0].disabled =false; v18b37.items[1].disabled =false; } else  { v18b37.items[0].disabled =true; v18b37.items[1].disabled =true; } if (ve244 ||va8063.Get("AllowGrouping")=="Yes") v18b37.items[3].disabled =false; else v18b37.items[3].disabled =true; if (va8063.IsGrouped ||ve244) v18b37.items[3].text =grid.GetString("ContextMenu/Column/UngroupField"); else v18b37.items[3].text =grid.GetString("ContextMenu/Column/GroupByThisField"); if (!grid.LayoutSettings.GroupByBox.ContextMenu) v18b37.items[4].disabled =true;  if (table.Get("AllowFilter")!="Yes") v18b37.items[8].visible =false; if (table.Get("AllowSelectColumns")=="Yes" &&!table.IsUseColumnSet) { if (va8063.ShowInSelectColumns =="Yes") v18b37.items[6].disabled =false; else v18b37.items[6].disabled =true; v18b37.items[10].disabled =false; } else  { v18b37.items[6].disabled =true; v18b37.items[10].disabled =true; } if (ve244){ v18b37.items[6].disabled =true; v18b37.items[7].disabled =true; v18b37.items[10].disabled =true; } v18b37.invalidate(); v18b37.drawMenu(); if (ve244 ||va8063.Get("AllowSorting")=="Yes"){ if (va8063.SortOrder =="Ascending") v18b37.items[0]._htmlElement.childNodes[0].className ="MenuActive"; else v18b37.items[0]._htmlElement.childNodes[0].className ="icon-cell"; if (va8063.SortOrder =="Descending") v18b37.items[1]._htmlElement.childNodes[0].className ="MenuActive"; else v18b37.items[1]._htmlElement.childNodes[0].className ="icon-cell"; } var v5e447 =grid.GetElement(WG40.GROUPBYBOX,WG40.HTMLTABLE).parentElement; if (v5e447.style.display =="") v18b37.items[4]._htmlElement.childNodes[0].className ="MenuActive"; else v18b37.items[4]._htmlElement.childNodes[0].className ="icon-cell"; if (table.Get("AllowFilter")=="Yes") { var vbb235 =table.GetFilterRow(); if (vbb235.style.display =="") v18b37.items[8]._htmlElement.childNodes[0].className ="MenuActive"; else v18b37.items[8]._htmlElement.childNodes[0].className ="icon-cell"; } v18b37.show (ve2c42.X +window.screenLeft,ve2c42.Y +window.screenTop); },  me2561:function(vc8779,vf5385) { var v80b10 =wg_Global.ColumnContext; var vf4b64 =v80b10.Table; var v62236 =(vf5385 =="ASC" ? "Ascending" : "Descending"); var v4c983 =false; var v5b878 =null;  var v68e85 =vf4b64.GroupedColumns.GetNamedItem(v80b10.Name); if (v68e85) { v4c983 =true; v80b10.SortOrder =v68e85.SortOrder =v62236; v68e85._UIState ="Changed"; } if (v4c983) { try { v5b878 =v68e85.GetElement(); } catch(e) { return; } v5b878.tblName =vf4b64.Id; if (ISEvent.Raise(vf4b64.Grid.LayoutSettings.ClientSideEvents.OnColumnGroupChange,vf4b64.Grid.Id,v68e85)) { wg85027.m9da6(vf4b64); wg38213.mc2b9(vf4b64.Grid.Id,"ChangeGroup",v5b878); } } else { var vb3468 =vf4b64.SortedColumns.GetNamedItem(v80b10.Name); if (vb3468) { vb3468.SortOrder =v62236; vb3468._UIState ="Changed"; } else { vb3468 =new WebGridGroup(); vb3468.ColumnMember =v80b10.Name; vb3468.SortOrder =v62236; vf4b64.SortedColumns.Add(vb3468); }  try { v5b878 =v80b10.GetElement(); } catch(e) { return; }  if (v5b878 ==null) { try { v5b878 =vb3468.GetElement(); } catch(e) { return; } }  v5b878.tblName =vf4b64.Id; if (ISEvent.Raise(vf4b64.Grid.LayoutSettings.ClientSideEvents.OnColumnSort,vf4b64.Grid.Id,v80b10)) { wg85027.mb8075(vf4b64); wg38213.mc2b9(vf4b64.Grid.Id,"ColumnSort",v5b878); } } },  mafb31:function(v23d24) { var vaaf24 =wg_Global.ColumnContext; var v9d472 =ISGetObject(vaaf24.GetGrid()); if (v9d472.IsGroupByBoxShown()) v9d472.HideGroupByBox(); else v9d472.ShowGroupByBox(); },  mf9c65:function(v74a46) { var v39824 =wg_Global.ColumnContext; var vead72 =v39824.GetGrid();  vead72.NeedHeightResize =true;  if (vead72.LayoutSettings.FilterBarVisible) vead72.HideFilterBar(); else vead72.ShowFilterBar();  },  m78591:function(v12d33) { var v95346 =wg_Global.ColumnContext; var vd0366 =v95346.GetGrid(); var v4ca20 =v95346.Table; var v2b284 =null;  try { v2b284 =v95346.GetElement(); } catch(e) { var v7e351 =vd0366.HeaderContext; vd0366.HeaderContext =null; try { v2b284 =v95346.GetElement(); } catch(e) { if (v7e351) v2b284 =wg38213.mb6c95(v7e351); } }  if (!v2b284 &&vd0366.HeaderContext) v2b284 =wg38213.mb6c95(vd0366.HeaderContext);  if (v2b284) v2b284.tblName =v4ca20.Id; if (v12d33.text ==vd0366.GetString("ContextMenu/Column/GroupByThisField")) { if (ISEvent.Raise(vd0366.LayoutSettings.ClientSideEvents.OnColumnGroup,vd0366.Id,v95346)) { wg85027.m88b63(v2b284); wg85027.m9da6(v4ca20); wg38213.mc2b9(vd0366.Name,"Group",v2b284); } } else { var v30b93 =v4ca20.GroupedColumns.GetNamedItem(v95346.Name); if (ISEvent.Raise(vd0366.LayoutSettings.ClientSideEvents.OnColumnUngroup,vd0366.Id,v95346)) { var vd4089 =v4ca20.Columns.GetNamedItem(v95346.Name); if (vd4089) { vd4089.Visible =true; vd4089.ForceVisible =true; }  v4ca20.GroupedColumns.Remove(v30b93,true); wg85027.m9da6(v4ca20); if (v2b284) wg38213.mc2b9(vd0366.Name,"Ungroup",v2b284); } } }, md4539:function(v18d78) { var va5d56 =v18d78._htmlElement.childNodes[1].childNodes[0]; if (va5d56.checked) va5d56.checked =false; else va5d56.checked =true; }, m8bc68:function(v1830) { var v08778 =wg_Global.ColumnContext; wg85027.m4270(v08778); }, md8c93:function(va2c59,vd8730) { var v9dd0 =vd8730.items; var v39d36 =wg_Global.ColumnContext; var vb4881 =v39d36.GetElement(); var v1a727 =vb4881.parentElement; var v8dd59 =v39d36.GetGrid(); var vb3d46 =v39d36.Table; var vf4766 =vb3d46.GetElement(WG40.COLHEADER,WG40.HTMLTABLE,v1a727); var v65796 =false; vb4881.tblName =vb3d46.Id; for (var v26b50=0; v26b50<v9dd0.length; v26b50++) { var va8994 =v9dd0[v26b50]._htmlElement.childNodes[1]; if (va8994) { var v5d248 =va8994.childNodes[0]; if (v5d248 &&v5d248.tagName =="INPUT") { if (v5d248.checked) { v65796 =true; break; } } } } if (!v65796) { alert("Please specify at least one visible column !!"); return; } var vbc722 =new Array(); for (var v26b50=0; v26b50<v9dd0.length; v26b50++) { var va8994 =v9dd0[v26b50]._htmlElement.childNodes[1]; if (va8994) { var v5d248 =va8994.childNodes[0]; if (v5d248 &&v5d248.tagName =="INPUT") { wg38213.m79d94(v5d248); var v21323 =vb3d46.GetColumn(v5d248.colName);  if (!v5d248.checked) { for (var vaef48=0; vaef48<vf4766.cells.length; vaef48++) { if (vf4766.cells[vaef48].colName ==v5d248.colName) { if (!ISEvent.Raise(v8dd59.LayoutSettings.ClientSideEvents.OnColumnChanged,v8dd59.Id,vb3d46.Id,v5d248.colName,"Removed")) return; vf4766.cells[vaef48].removeNode(true); } } } else  { if (!v21323.Visible) { if (!ISEvent.Raise(v8dd59.LayoutSettings.ClientSideEvents.OnColumnChanged,v8dd59.Id,vb3d46.Id,v5d248.colName,"Added")) return;  v21323.ForceVisible =true; vbc722[vbc722.length] =v21323; } } v21323.Visible =v5d248.checked; } } }  wg85027.mf6633(vb3d46,"ColumnChange",v1a727,null,vbc722); wg85027.m38f29(vb3d46,v1a727); vb3d46.ColumnMenu =null; wg38213.mc2b9(v8dd59.Name,"ColumnChange",vb4881); }, m37b89:function(v09a94,v0b991) { var vdf582 =v0b991.items; var vf6c24 =wg_Global.ColumnContext; var v6ec64 =vf6c24.GetElement(); var v6b055 =v6ec64.parentElement; var vbcb35 =vf6c24.GetGrid(); var vbda2 =vf6c24.Table; var v43b83 =vbda2.GetElement(WG40.COLHEADER,WG40.HTMLTABLE,v6b055); var v46a24 =vbda2.Columns; v6ec64.tblName =vbda2.Id;  for (var vc7e53=0; vc7e53<v46a24.length; vc7e53++) { var vb5c62 =v46a24[vc7e53]; var v14572 =vb5c62.DefaultVisible; if (!v14572) { for (var v9e194=0; v9e194<v43b83.cells.length; v9e194++) { if (v43b83.cells[v9e194].colName ==vb5c62.Name) { v43b83.cells[v9e194].removeNode(true); } } } else  { if (!vb5c62.Visible) vb5c62.ForceVisible =true; } vb5c62.Visible =v14572; }  wg85027.mf6633(vbda2,"ColumnReset",v6ec64); wg85027.m38f29(vbda2,v6b055); vbda2.ColumnMenu =null; wg38213.mc2b9(vbcb35.Name,"ColumnChange",v6ec64); }, m86474:function(v0ac94) { wg85027.m69b38(wg_Global.ColumnContext.GetElement()); }, m31129:function(v51f6,vbfb58) { var v5ec94 =ISGetObject(v51f6); var v76c91 =new Menu(); var v0d759 =new Array(); var v68423 =wg_Global.FilterType; for (var v4e892=0; v4e892<v68423.length; v4e892++) { v76c91.add(v0d759[v0d759.length] =new RadioButtonMenuItem(v5ec94.GetString(v68423[v4e892][0]),false,"rdoFilter",new Function("wg20949.m07f97(" +v68423[v4e892][1] +", '" +v51f6 +"', '" +vbfb58 +"')"))); } v76c91.add(new MenuSeparator()); v76c91.add(new MenuItem(v5ec94.GetString("ContextMenu/Filter/ApplyAll"),function(){wg20949.m85d47(v51f6,vbfb58)})); v76c91.add(new MenuItem(v5ec94.GetString("ContextMenu/Filter/Clear"),function(){wg20949.m3844(v51f6,vbfb58)})); v76c91.add(new MenuItem(v5ec94.GetString("ContextMenu/Filter/ClearAll"),function(){wg20949.m99919(v51f6,vbfb58)}));  var veb071 =v5ec94.Tables[vbfb58]; veb071.FilterMenu =v76c91; veb071.FilterMenus =v0d759; }, mbc415:function(vf3051) { var v71751 =wg_Global.FilterType; for (var v5e045=0; v5e045<v71751.length; v5e045++) { if (v71751[v5e045][1] ==parseFloat(vf3051)) return v5e045; } return null },  m2dc42:function(v98373) { for (var v6f673=0; v6f673<wg_Global.FilterTypeEnum.length; v6f673++) if (wg_Global.FilterTypeEnum[v6f673] ==v98373) return v6f673;  return -1; }, m8d232:function(vb428) { var v48973 =vb428.parentElement; var v19a38 =vb428.parentElement;  var v17651 =wg_getGridNameByRow(v48973.parentElement); var vfa330 =wg_getTableNameByRow(v48973.parentElement); var vadd4 =ISGetObject(v17651); var vd8e63 =vadd4.Tables[vfa330]; var v8528 =vd8e63.FilterMenus; var v9d346 =vd8e63.FilterMenu; vd8e63.LastFo =v19a38; if (v8528 ==null ||v8528.length ==0) { wg20949.m31129(v17651,vfa330); v8528 =vd8e63.FilterMenus; v9d346 =vd8e63.FilterMenu; }  for (var ve5e61=0; ve5e61<v8528.length; ve5e61++)v8528[ve5e61].checked =false; v8528[ wg20949.mbc415(v19a38.getAttribute("filterType"))].checked =true;  v9d346.SetCssFile(vadd4); v9d346.invalidate(); v9d346.show (ISPosLib.getScreenLeft(vb428),ISPosLib.getScreenTop(vb428)); event.returnValue =false; }, m07f97:function(vb3220,vdcd66,v02340) { var v9ca8 =ISGetObject(vdcd66); var v79899 =v9ca8.Tables[v02340]; var v5e645 =v79899.LastFo; v5e645.setAttribute("filterType",vb3220); v5e645.setAttribute("filterText",v5e645.childNodes[0].innerText);  if (wg85027.me1418(v5e645)) { v5e645.setAttribute("changed","true"); v5e645.cellModified =true;  var vd4811 =wgGetColNameByCell(v5e645); var v75113 =v79899.FilteredColumns.GetNamedItem(vd4811);  if (!v75113) { v75113 =new WebGridFilter(); v75113.Name =v75113.ColumnMember =vd4811; v79899.FilteredColumns.Add(v75113); } else v75113._UIState ="Changed"; v75113.FilterType =wg_Global.FilterTypeEnum[vb3220]; v75113.FilterText =v5e645.childNodes[0].innerText;  wg9c911.m55a32(v9ca8); } }, m85d47:function(v07542,v16859) { var v9ca42 =wgGetGridById(v07542); wg9c911.m5a567(v9ca42,0); }, m3844:function(v45065,vcd553) { var v06a42 =ISGetObject(v45065); var vbd659 =v06a42.Tables[vcd553]; var v9d839 =vbd659.LastFo;  if (ISEvent.Raise(v06a42.LayoutSettings.ClientSideEvents.OnColumnFilter,v06a42.Id,vbd659,v9d839.colName)) { var v63191 =vbd659.FilteredColumns.GetNamedItem(v9d839.colName); if (v63191) { vbd659.FilteredColumns.Remove(v63191,true); wg85027.mf6c40(vbd659); }  wg38213.mc2b9(v45065,"ColumnFilter",vcd553); } }, m99919:function(vf7e87,ve7846) { var v11965 =ISGetObject(vf7e87); var v17353 =v11965.Tables[ve7846]; if (ISEvent.Raise(v11965.LayoutSettings.ClientSideEvents.OnColumnFilter,v11965.Id,v17353)) { for(var v75638=0; v75638<v17353.FilteredColumns.length; v75638++) { var v46d5 =v17353.FilteredColumns[v75638]; v17353.FilteredColumns.Remove(v46d5,true); } wg85027.mf6c40(v17353); wg38213.mc2b9(vf7e87,"ColumnFilter",ve7846); } }, mc4743:function(vc2954) { var va7c87 =new Menu(); var vc0e46 =vc2954.LayoutSettings.ImageSettings.Folder; va7c87.add(new MenuItem("",function(){wg20949.m28f82(va7c87.cell);},vc0e46 +wg_Global.CopyImage)); va7c87.add(new MenuItem("",function(){wg20949.m5e150(va7c87.row);},vc0e46 +wg_Global.CopyImage)); va7c87.add(new MenuItem("",function(){wg20949.m55067(va7c87.table,va7c87.row);},vc0e46 +wg_Global.CopyImage)); va7c87.add(new MenuItem("",function(){wg20949.m92781(va7c87.grid,va7c87.row);},vc0e46 +wg_Global.UpdateImage)); va7c87.add(new MenuItem("",function(){wg20949.mbf59(va7c87.grid,va7c87.row);},vc0e46 +wg_Global.CancelImage)); va7c87.add(new MenuItem("",function(){wg20949.m11938(va7c87.row);})); va7c87.add(new MenuItem("",function(){wg20949.m49c82(va7c87.row);})); va7c87.add(new MenuItem("",function(){wg20949.macb71(va7c87.grid,va7c87.row);},vc0e46 +wg_Global.EditImage)); va7c87.add(new MenuItem("",function(){wg20949.m79e46(va7c87.grid,va7c87.row);},vc0e46 +wg_Global.DeleteImage)); va7c87.add(new MenuItem("",function(){wg20949.m17232(va7c87.row);})); va7c87.add(new MenuItem("",function(){wg20949.mc3674(va7c87.row);})); va7c87.add(new MenuItem("",function(){wg20949.m0ff1(va7c87.row);})); va7c87.add(new MenuItem("",function(){wg20949.m92983(va7c87.row);})); va7c87.add(new MenuItem("",function(){wg20949.m66020(va7c87.grid,va7c87.row);},vc0e46 +wg_Global.UpdateImage)); va7c87.add(new MenuItem("",function(){wg20949.mbf59(va7c87.grid,va7c87.row);},vc0e46 +wg_Global.DeleteImage)); va7c87.add(new MenuItem("",function(){wg20949.m85d47(va7c87.grid.Name,va7c87.table.Id);})); va7c87.add(new MenuItem("",function(){wg20949.m99919(va7c87.grid.Name,va7c87.table.Id);})); wg_Global.RowContext =va7c87; wg20949.mc3a7(); }, mc3a7:function() { var vd7254 =wg_Global.RowContext; for (var vf7a26=0; vf7a26<vd7254.items.length; vf7a26++) vd7254.items[vf7a26].visible =false; }, me6d9:function() { var va2e77 =wg_Global.RowContext; if (va2e77.items.length >17) { var vffd20 =va2e77.items.length -17; for (var ve0733=0; ve0733<vffd20;ve0733++) va2e77.remove(va2e77.items[17] ); } }, m7c464:function() { var v43899 =wg_Global.RowContext; var v44313 =v43899.grid; var va6032 =v43899.items; var v46286 ="ContextMenu/Row/"; var v9b382 =["CopyCell","CopyRow","CopyTable","Update","Cancel","ShowChildRows","HideChildRows","Edit","Delete","Expand","ExpandAll","Collapse","CollapseAll","PerformAdd","CancelAdd","ApplyFilter","ClearFilter"]; for (var v4e667=0; v4e667<va6032.length; v4e667++) va6032[v4e667].text =v44313.GetString(v46286+v9b382[v4e667]); }, m24390:function(v29653,v10139,v84318,vce660) { var v33e11 =wgGetRootRow(v84318.parentElement); var v61880 =v33e11.type; var v81427 =wg38213.m88693(v84318); var v29653 =ISGetObject(v81427.gridId); var v10139 =v29653.Tables[v81427.tblName]; var v5f736 =v29653.LayoutSettings.ImageSettings.Folder; if (v61880 =="")return; if (!wg_Global.RowContext ||wg_Global.RowContext.items.length ==0) wg20949.mc4743(v29653); else wg20949.mc3a7();  var v8fa61 =wg_Global.RowContext; v8fa61.row =v33e11; v8fa61.table =v10139; v8fa61.grid =v29653; wg20949.m7c464(); if (v61880 !="NewRow" &&v61880!="FilterRow") { if (v29653.ActiveEditCell) { v8fa61.items[0].visible =true; v8fa61.cell =v29653.ActiveEditCell.element; } else if (v29653.LastSelObj &&v29653.LastSelObj.type =="Cell") { v8fa61.items[0].visible =true; v8fa61.cell =v29653.LastSelObj.element; } v8fa61.items[1].visible =true; if (v10139.GroupedColumns.length ==0) v8fa61.items[2].visible =true; } if (v61880 =="Record") { if (v33e11.markedEdit) { v8fa61.items[3].visible =true; v8fa61.items[4].visible =true;  } else  { var v12987 =v10139.ChildTables; if (v12987.length >0) { if (v33e11.childExpanded =="True") { v8fa61.items[5].disabled =true; v8fa61.items[6].disabled =false; } else  { v8fa61.items[5].disabled =false; v8fa61.items[6].disabled =true; } v8fa61.items[5].visible =true; v8fa61.items[6].visible =true; }  if (v10139.Get("AllowEdit")=="Yes") v8fa61.items[7].visible =true; if (v10139.Get("AllowDelete")=="Yes") v8fa61.items[8].visible =true; }  } else if (v61880 =="GroupHeader") { v8fa61.items[9].visible =true; v8fa61.items[10].visible =true; v8fa61.items[11].visible =true; v8fa61.items[12].visible =true;   if (v33e11.expanded =="True") { v8fa61.items[9].disabled =true; v8fa61.items[11].disabled =false; } else  { v8fa61.items[9].disabled =false; v8fa61.items[11].disabled =true; } } else if (v61880 =="NewRow") { if (v33e11.markedEdit) { v8fa61.items[13].disabled =false; v8fa61.items[14].disabled =false; } else  { v8fa61.items[13].disabled =true; v8fa61.items[14].disabled =true; } v8fa61.items[13].visible =true; v8fa61.items[14].visible =true; } else if (v61880 =="FilterRow") { v8fa61.items[15].visible =true; v8fa61.items[16].visible =true;  } wg20949.me6d9(); wg_Global.LastRowCtx =v33e11; wg_Global.RowContext =v8fa61; if (!ISEvent.Raise(v29653.LayoutSettings.ClientSideEvents.OnRowContextMenu,v29653.Name,v61880,v33e11,v8fa61,vce660)) return;  v8fa61.SetCssFile(v29653); v8fa61.invalidate(); v8fa61.show(vce660.X +window.screenLeft,vce660.Y +window.screenTop ); }, m28f82:function(vcd513) { wgCopyToCB(vcd513.innerText); }, m5e150:function(v13155,v59b24) { var v5ba13 =""; var vd8c21 =new Array(); if (wgIsColumnSetRow(v13155)) vd8c21 =wgGetColumnSetRows(v13155); else vd8c21[0] =v13155; for (var v12317=0; v12317<vd8c21.length; v12317++) { var v32a74 =vd8c21[v12317]; for (var vbd53=0; vbd53<v32a74.cells.length; vbd53++) { var vfa91 =v32a74.cells[vbd53]; if (vfa91.type =="Cell" ||vfa91.type =="GroupCell") { var v18394 =vfa91.innerText;  if (v18394 !="" &&v18394 !=" ") v5ba13 +=vfa91.innerText +"\t"; else { if (vfa91.children.length >0 &&vfa91.children[0].tagName =="INPUT") { if (vfa91.children[0].type =="checkbox") v5ba13 +=vfa91.children[0].checked +"\t"; else v5ba13 +=vfa91.children[0].value +"\t"; } } } }  if (v5ba13 !="") v5ba13 =v5ba13.substring(0,v5ba13.length-1); v5ba13 +="\n"; }  if (v59b24) return v5ba13;  wgCopyToCB(v5ba13); }, m55067:function(va3179,vf3a75) { var vd3c22 =va3179.GetElement(WG40.BODY,WG40.HTMLTABLE,vf3a75); var vc654 =va3179.GetElement(WG40.COLHEADER,WG40.HTMLTABLE,vf3a75).rows[0]; var vf0a80 =""; if (vc654) { for (var v2cb89=0; v2cb89<vc654.cells.length; v2cb89++) { var vbae8 =vc654.cells[v2cb89]; if (vbae8.type =="Column") { vf0a80 +=vbae8.innerText +"\t"; } } } if (vf0a80 !="")vf0a80 =vf0a80.substring(0,vf0a80.length-1)+"\n"; for (var v2cb89=0; v2cb89<vd3c22.rows.length; v2cb89++) { var vf3a75 =vd3c22.rows[v2cb89]; if (wgIsRecordRow(vf3a75)) vf0a80 +=wg20949.m5e150(vf3a75,true); } wgCopyToCB(vf0a80); }, m11938:function(vaa479) { wgExpandChildRow(vaa479); }, m49c82:function(v84379) { wgCollapseChildRow(v84379); }, m17232:function(v45b79) { wgExpandGroupRow(v45b79); }, mc3674:function(vd3d79) { wgExpandGroupRow(vd3d79,true); }, m0ff1:function(v5e379) { wgCollapseGroupRow(v5e379); }, m92983:function(v8a479) { wgCollapseGroupRow(v8a479,true); }, m92781:function(v53179,v92e58) { wg9c911.m5a567(v53179,0,false); }, m66020:function(v00879,v02558) { wg9c911.m5a567(v00879,0,false); }, mbf59:function(vaa42,v0f852) { var v1d52 =wg9c911.m5a567(vaa42,-1)[0]; if (v1d52) vaa42.IsInEditMode =false; }, macb71:function(vd382,v64352) { vd382.ActivateEditMode(); }, m79e46:function(ve712,v60852) { wg9c911.m4ef32(ve712,v60852); }, m0ee40:function(v11c24) { var v6352 =v11c24._htmlElement.childNodes[1].childNodes[0]; v6352.checked =true; }, mfe332:function(vcaa4) { if (wg_Global.ExportContext) { wg_Global.ExportContext.destroy(); wg_Global.ExportContext =null; } var v4bf24 =new Menu(); var v1dd45 =""; var va1271 =vcaa4.LastSelObj; var vec710; v4bf24.add(new MenuItem("<input hideFocus group='rdoTable' name='rdoTable' value='0' onclick=\"event.cancelBubble='false'; return false;\" type=radio checked>&nbsp;" +vcaa4.GetString("ContextMenu/Export/ExportRoot"),function(){wg20949.m0ee40(this);})); v4bf24.items[v4bf24.items.length-1].alwaysVisible =true; if (va1271) { vec710 =va1271.GetRowElement(); var v73a72 =vcaa4.Tables[wg_getTableNameByRow(vec710)]; if (!v73a72.IsRootTable) { v4bf24.add(new MenuItem("<input hideFocus group='rdoTable' tblName='" +v73a72.Id +"' name='rdoTable' value='1' onclick=\"event.cancelBubble='false'; return false;\" type=radio checked>&nbsp;" +vcaa4.GetString("ContextMenu/Export/ExportChild"),function(){wg20949.m0ee40(this);})); v4bf24.items[v4bf24.items.length-1].alwaysVisible =true; } } v4bf24.add(new MenuSeparator()); if (vcaa4.ExportTypeList.length >0) { for (var v43f71=0; v43f71<vcaa4.ExportTypeList.length; v43f71++) { if (v43f71 ==0)v1dd45 ="checked"; else v1dd45 =""; v4bf24.add(new MenuItem("<input hideFocus group='rdoExport' value='" +vcaa4.ExportTypeList[v43f71] +"' name='rdoExport' onclick=\"event.cancelBubble='false'; return false;\" type=radio " +v1dd45 +">&nbsp;" +vcaa4.ExportTypeList[v43f71],function(){wg20949.m0ee40(this);})); v4bf24.items[v4bf24.items.length-1].alwaysVisible =true; } v4bf24.add(new MenuSeparator()); } v4bf24.add(new MenuItem("<input hideFocus group='rdoOrientation' name='rdoOrientation' value='Portrait' onclick=\"event.cancelBubble='false'; return false;\" type=radio checked>&nbsp;"+vcaa4.GetString("ContextMenu/Export/Portrait"),function(){wg20949.m0ee40(this);})); v4bf24.items[v4bf24.items.length-1].alwaysVisible =true; v4bf24.add(new MenuItem("<input hideFocus group='rdoOrientation' name='rdoOrientation' value='Landscape' onclick=\"event.cancelBubble='false'; return false;\" type=radio>&nbsp;"+vcaa4.GetString("ContextMenu/Export/Landscape"),function(){wg20949.m0ee40(this);})); v4bf24.items[v4bf24.items.length-1].alwaysVisible =true; v4bf24.add(new MenuSeparator()); v4bf24.add(new MenuItem(vcaa4.GetString("ContextMenu/Export/DoExport"),function(){wg38213.mc2b9(vcaa4.Name,"Export");})); wg_Global.ExportContext =v4bf24; v4bf24.invalidate(); v4bf24.SetCssFile(vcaa4); v4bf24.show(event.clientX +window.screenLeft,event.clientY +window.screenTop,200 );  } };function wgShowFilterMenus(v55662){ wg20949.m8d232(v55662);}