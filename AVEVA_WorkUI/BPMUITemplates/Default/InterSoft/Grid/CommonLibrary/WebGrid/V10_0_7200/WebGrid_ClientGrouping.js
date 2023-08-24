﻿var WGGroupingEngine={GroupRows:function(p,e){var f=new ISArray();var b=false;var a=0;var q=p.Parent;var d=q.Grid;for(var h=0;h<p.length;h++){var g=new WebGridRow();g.Type="GroupHeader";g.Table=p[h].Table;g.Group=e;g.Parent=p.ParentRow;g.GroupRowText=p[h].GroupRowText;g.ParentCollection=f;if(g.Cells==null){g.Cells=new ISArray()}g.Cells.Add(new WebGridCell());g.Cells[0].Value=p[h].Cells[e.Column.Position].Value;g.Cells[0].Text=p[h].Cells[e.Column.Position].Text;g.Cells[0].Column=e.Column;g.Cells[0].Row=g;var c=e.GroupInterval;var l=h;var s=null;if(c=="Default"){c=e.Column.GroupInterval}s=WGGroupingEngine.GetGroupValueObject(g.Cells[0],c);while(l<p.length){var t=WGGroupingEngine.GetGroupValueObject(p[l].Cells[e.Column.Position],c);var o=p[l].SectionRowIndex;if(!(s==null&&t==null||s!=null&&t!=null&&WGGroupingEngine.IsGroupValueEqual(e,s,t))){break}g.GetChildren().Add(p[l]);g.GetChildren().Parent=g.Table;g.ChildrenLoaded=true;p[l]._UIState="Unchanged";p[l].ParentCollection=g.Children;p[l].Type="Record";p[l].SectionRowIndex=o;p[l].Table=g.Table;p[l].Position=g.Children.length-1;p[l++].Parent=g;if(g.Table.IsRootTable&&(b||(d.LayoutSettings.PagingMode=="VirtualLoad"&&o>=d.LayoutSettings.VirtualPageSize))){g.ChildrenLoaded=false;b=true}else{a++}}h=l-1;ISEvent.Raise(d.LayoutSettings.ClientSideEvents.OnInitializeRow,d.Id,g);f.Add(g);g._UIState="Unchanged"}if(p.length>0){if(e.Index<p[0].Table.GroupedColumns.length-1){for(var m=0;m<f.length;m++){var n=f[m];n.Children=WGGroupingEngine.GroupRows(n.Children,p[0].Table.GroupedColumns[e.Index+1])}}}return f},PrepareVirtualGroupRows:function(b,a,c){if(c.length>0){WGGroupingEngine.PopulateVirtualGroupRows(b,a,c)}},PopulateVirtualGroupRows:function(e,c,f){for(var d=0;d<f.length;d++){var g=f[d];var a=WGGroupingEngine.GetGroupRowByValue(c,g.Value);if(a==null){var a=new WebGridRow();var h=typeof(g.Index)!="undefined"?g.Index:0;var b=e.GroupedColumns[h];a.Type="GroupHeader";a.Table=e;a.Group=b;a.Parent=c.ParentRow;a.GroupRowText=g.Text;a.ParentCollection=c;a.ChildrenLoaded=false;if(typeof(g.Count)=="undefined"){a.VirtualChildrenCount=0}else{a.VirtualChildrenCount=g.Count}if(typeof(g.GroupTotals)!="undefined"){a.VirtualGroupTotals=g.GroupTotals}if(a.Cells==null){a.Cells=new ISArray()}a.Cells.Add(new WebGridCell());a.Cells[0].Value=(typeof(g.Value)!="undefined"?g.Value:null);a.Cells[0].Text=g.Text;a.Cells[0].Column=b.Column;a.Cells[0].Row=a;if(!a.Parent&&h>0&&c.length>0){a.Parent=c[0].Parent}c.Add(a);a._UIState="Unchanged"}if(typeof(g.Children)!="undefined"&&g.Children!=null){WGGroupingEngine.PopulateVirtualGroupRows(e,a.GetChildren(),g.Children)}else{a.GetChildren()}}},GetGroupRowByValue:function(b,c){for(var a=0;a<b.length;a++){if(c==b[a].Cells[0].Value){return b[a]}}return null},IsGroupValueEqual:function(a,b,c){if(a.CaseSensitiveDefault=="No"){if(typeof(b)=="string"&&typeof(c)=="string"){return b.toLowerCase()==c.toLowerCase()}}return b===c},GetGroupValueObject:function(a,f){var g=a.Column.Table.Grid;var b=g.CultureInfo;var k=g.ValEngine;switch(f){case"Value":return a.Value;case"Text":return a.Text;case"Alphabetical":var j="";if(a.Text!=""){j=a.Text;j=j.substring(0,1).toUpperCase()}return j;case"Date":try{var c=a.Value;return ISDataEngine.FormatString(b,"d",c,k)}catch(d){return""}case"Month":try{return(a.Value.getMonth()+1).toString()}catch(d){return""}case"Year":try{return a.Value.getYear().toString()}catch(d){return""}case"Hour":try{return a.Value.getHour().toString()}catch(d){return""}case"Minute":try{return a.Value.getMinutes().toString()}catch(d){return""}case"ShortTime":try{var c=a.Value;return c.getHours()+":"+c.getMinutes()}catch(d){return""}case"Quarterly":try{var i=1;var c=a.Value;var h=c.getMonth();if(h>=1&&h<=3){i=1}else{if(h>=4&&h<=6){i=2}else{if(h>=7&&h<=9){i=3}else{if(h>=10&&h<=12){i=4}}}}return i.toString()}catch(d){return""}case"NamedPeriod":return a.Row.GroupRowText}return null},RenderGroupRow:function(j,f,k,l,a){var h=new IS.StringBuilder();var b=j.Grid;var d=b.LayoutSettings;var e=f.Parent;var g=f.Height;var m=function(i){h.Append(i)};if(a){h=a}if((g==0||g==null)&&d.GroupRowHeight!=""){g=d.GroupRowHeight}if(g==0||g==null){g=d.RowHeightDefault}m("<tbody><tr ");if((f.ChildrenLoaded||f.HasGrouppedChilds())&&f.Group.GetGroupMode()=="Expanded"){f.Expanded=true}m('type="GroupHeader" expanded="'+WG50Engine.ToBoolString(f.Expanded)+'" ');m('hasParent="'+WG50Engine.ToBoolString(e!=null)+'" ');m("position="+f.Position+" ");m("groupIndex="+f.Group.Index+" ");m('childrenLoaded="'+WG50Engine.ToBoolString(f.ChildrenLoaded)+'" ');m('fullPath="'+f.GetGroupRowLevel()+'" ');if(e!=null){m("parentIndex="+e.Position+" ")}m('style="height:');m(g.toString());if(e!=null){if(f.HasCollapsedParents()){if(!(f.Parent!=null&&f.Parent.Expanded&&f.Parent.ForceExpGroup)){m("; display: none;")}}}m('">');if(d.Hierarchical&&!j.IsRootTable){m('<td noWrap style="margin:0; padding:0; width: 22px">');if(f.Parent==null){_RenderHierStructure(g,true,false)}else{RenderIStructure(g)}m("</td>")}for(var c=0;c<f.Group.Index;c++){m('<td style="width: 16px; ');m('">&nbsp;</td>')}m('<td type="GroupCell" is-expander class="'+d.GroupRowInfoClass+'" align="middle" style="width:16px;');if(f.Style!=null){m(f.Style)}m("border-right-width: 0px;");m('">');if(f.Expanded||(!f.HasCollapsedParents()&&f.Group.GetGroupMode()=="Expanded"&&f.HasGrouppedChilds())){m('<img align="absmiddle" onclick="WGUI.TGROW(this)" src="'+b.ResolveImagePathEx(d.ImageSettings.CollapseImage)+'" />')}else{m('<img align="absmiddle" onclick="WGUI.TGROW(this)" src="'+b.ResolveImagePathEx(d.ImageSettings.ExpandImage)+'" />')}m("</td>");if(j.IsUseColumnSet){colSpan=j.GetColSetColumnsCount()+j.GroupedColumns.length-f.Group.Index-1;if(!j.IsRootTable){colSpan++}if(!j.PreviewRowVisible){colSpan--}}else{colSpan=l.length+j.GroupedColumns.length-f.Group.Index-1}if(d.Hierarchical){colSpan+=1}if(j.Get("RowHeaders")=="Yes"){colSpan+=1}if(j.IsRootTable){colSpan+=1}else{if(j.Get("HideColumnsWhenGrouped")=="Yes"&&!j.IsUseColumnSet){colSpan-=j.GroupedColumns.length}}m('<td type="GroupCell" class="'+d.GroupRowInfoClass+'" noWrap style="width:100%; ');m("border-left-width: 0px;");if(!f.Style!=null){m(f.Style)}else{if(!f.Cells[0].Style!=null){m(f.Cells[0].Style)}}m('" colSpan='+colSpan+" ");if(f.Cells[0].TooltipText!=""){m('title="'+f.Cells[0].TooltipText+'" ')}if(f.Cells[0].CustomAttributes!=""){m(f.Cells[0].CustomAttributes)}m(">");m(WGGroupingEngine.FormatGroupCellText(f.Cells[0]));m("</td>");m("</tr></tbody>");if(!f.ChildrenLoaded&&f.Group.Index==j.GroupedColumns.length-1){m('<tbody id="ty_'+b.Id+"_");if(f.Parent!=null){m(f.GetGroupRowLevel()+"_")}m(f.Position+'"></tbody>')}if(f.Children!=null){for(var c=0;c<f.Children.length;c++){WGRenderEngine.RenderRow(j,f.Children[c],k,l,h)}}return h.ToString()},FormatGroupCellText:function(a,h){var b=a.Column;var i=b.Table;var e=i.Grid;var g=e.LayoutSettings;var f=a.GroupRowInfoText;var c=a.Row.VirtualChildrenCount;var d=Math.max(isNaN(c)?0:c,a.Row.Children.length).toString();if(h){d=e.GetString("CommonText/GroupRowPartialCount").replace("{0}",h).replace("{1}",d)}if(!c){c=0}if(!f){f=b.GroupRowInfoFormat}if(!f){f=b.Table.GroupRowInfoFormatDefault}if(!f){f=g.GroupRowInfoFormatDefault}f=f.replace("[caption]",b.Caption);f=f.replace("[value]",WGGroupingEngine.GetGroupValueText(a));f=f.replace("[count]",d);f=WGGroupingEngine.CalculateGroupAggregate(f,b.Table,a.Row.Children);return f},GetGroupValueText:function(a){var g=a.Row.Group.GroupInterval;var b=a.Column;var o=b.Table;var h=o.Grid;var c=h.CultureInfo;var p=h.ValEngine;if(g=="Default"){g=a.Column.GroupInterval}var n="";var d=new Date(1900,1,1);switch(g){case"Value":if(a.Value!=null){n=a.Value.toString()}else{n=""}break;case"Text":n=a.Text;break;case"Alphabetical":n=a.Text;if(n!=""){n=n.substring(0,1).toUpperCase()}break;case"NamedPeriod":n=a.Row.GroupRowText;if(n!=""&&n.indexOf(";")>-1){n=n.substring(n.indexOf(";")+1)}var l=h.GetString("Grouping/"+n);if(l!=""){n=l}break;case"Quarterly":var m=1;try{d=a.Value;var k=d.getMonth()+1;if(k>=1&&k<=3){m=1}else{if(k>=4&&k<=6){m=2}else{if(k>=7&&k<=9){m=3}else{if(k>=10&&k<=12){m=4}}}}}catch(f){}n=m.toString();break;default:if(g=="Date"||g=="Month"||g=="Year"||g=="Hour"||g=="Minute"){if(a.Value!=null){try{n=ISDataEngine.FormatString(c,"d",a.Value,p)}catch(f){}}}break}if(n==""){n=a.Column.GroupEmptyString}else{var i=a.Row.Group;var j=i.GetGroupRowValueFormatString();if(g=="Value"||g=="Text"||g=="Alphabetical"||g=="NamedPeriod"){if(j!=""){if(g=="Value"||g=="NamedPeriod"){n=ISDataEngine.FormatString(c,j,a.Value,p)}else{n=ISDataEngine.FormatString(c,j,n,p)}}}else{if(g=="Date"||g=="Month"||g=="Year"||g=="Hour"||g=="Minute"){if(d!=null){if(j!=""){n=ISDataEngine.FormatString(c,j,d,p)}else{if(g=="Date"){n=ISDataEngine.FormatString(c,"d",d,p)}else{if(g=="Month"){n=ISDataEngine.FormatString(c,"MMMM yyyy",d,p)}else{if(g=="Year"){n=d.getFullYear().toString()}else{if(g=="Hour"){n=ISDataEngine.FormatString(c,"hh",d,p)}else{if(g=="Minute"){n=ISDataEngine.FormatString(c,"mm",d,p)}else{if(g=="ShortTime"){n=ISDataEngine.FormatString(c,"hh:mm",d,p)}}}}}}}}else{n=""}}else{if(g=="Quarterly"){if(j!=""){n=n=ISDataEngine.FormatString(c,j,d.getFullYear(),p)}else{n="Q"+n+" "+d.getFullYear()}}}}}return n},CalculateGroupAggregate:function(j,p,c){while(j.indexOf("sum(")>-1||j.indexOf("avg(")>-1||j.indexOf("min(")>-1||j.indexOf("max(")>-1){var a="";if(j.indexOf("sum")>-1){a="sum"}else{if(j.indexOf("avg")>-1){a="avg"}else{if(j.indexOf("min")>-1){a="min"}else{if(j.indexOf("max")>-1){a="max"}}}}var m=j.indexOf(a)+1;var o=j.indexOf(")",m);var e=j.substr(m+a.length,o-m-a.length);var d=p.Columns.GetNamedItem(e);var q=0;var f=0;var l=0;var h=0;var r=c;if(c.UngroupedRows!=null){r=c.UngroupedRows}for(var k=0;k<r.length;k++){var n=r[k];var b=n.Cells.GetNamedItem(e).Value;var g=0;if(b==null){g=0}else{g=parseFloat(b)}if(a=="sum"||a=="avg"){q+=g;f++}else{if(a=="min"){l=Math.min(l,g)}else{if(a=="max"){l=Math.max(l,g)}}}}if(a=="sum"){h=q}else{if(a=="avg"){h=q/f}else{if(a=="min"||a=="max"){h=l}}}if(d.DataFormatString!=""){h=ISDataEngine.FormatString(p.Grid.CultureInfo,d.DataFormatString,h,p.Grid.ValEngine)}j=j.substring(0,m-1)+h+j.substring(m+1+a.length+e.length)}return j},PrepareRenderGroupTotalRow:function(c,e){var f=c.Table;if(f.GroupTotalVisible){var d=0;if(c.Parent!=null){d=c.ParentCollection.length}else{if(f.UngroupedRows!=null){d=f.UngroupedRows.length}else{if(c.ParentCollection!=null){d=c.ParentCollection.length}else{d=f.Rows.length}}}if((c.Position==d-1&&c.Parent!=null)||c.Type=="GroupHeader"){var b=true;if(c.Type=="Record"&&c.Parent!=null&&c.Parent.GroupTotalRendered){b=false}if(b){var a=WGGroupingEngine.RenderGroupTotalRow(c,e);if(!e&&a){return a}}}}},RenderGroupTotalRow:function(o,a){var t=new IS.StringBuilder();var u=o.Table;var f=u.Grid;var k=f.LayoutSettings;var l=o.Parent;var p="";var r=null;var w=function(i){t.Append(i)};if(a){t=a}if(u.GroupTotalClass!=""){p=u.GroupTotalClass}else{p=k.GroupRowInfoClass}var q=null;var e=false;var d=0;if(o.Type=="GroupHeader"){d=o.Group.Index}else{if(o.Type=="Record"){if(o.Parent!=null){d=o.Parent.Group.Index}}}if((q==0||q==null)&&k.GroupRowHeight!=""){q=k.GroupRowHeight}else{if(o.Table.RowHeightDefault==null){q=k.RowHeightDefault}else{q=o.Table.RowHeightDefault}}w("<tbody>");w('<tr type="GroupTotalRow" ');if(u.IsUseColumnSet){w("csRowPos=0 ")}w('hasParent="'+WG50Engine.ToBoolString(l!=null)+'" ');w("position="+(o.Position+1)+" ");if(o.group!=null){w("groupIndex="+(o.Group.Index-1)+" ")}else{if(o.Group!=null){w("groupIndex="+o.Group.Index+" ")}else{w("groupIndex="+(l.Group.Index)+" ")}}w('style="');if(!u.IsUseColumnSet){w("height: "+q)}else{w("height: "+u.ColumnSets[0].GetRowLayout(0,0).Height)}if(o.Type=="Record"){if(l!=null){if(l.Parent!=null){if(!l.Parent.Expanded){w("; display: none;")}}}}else{if(d>0&&l!=null&&!l.Expanded){w("; display: none;")}}w('">');if(!u.IsRootTable&&k.Hierarchical){w('<td valign=top style="width: 22px; margin:0; padding:0" ');if(u.IsUseColumnSet){w("rowSpan=");w(u.GetRowSpan(false).ToString());w(" ")}w(">");RenderIStructure(Unit.Empty);w("</td>")}for(var g=0;g<d;g++){WGGroupingEngine.RenderColumnGroupTotalHeader(u,16,"",r,e,t)}WGGroupingEngine.RenderColumnGroupTotalHeader(u,16,p,r,e,t);e=true;var m=u.GroupedColumns.length-d-1;for(var g=0;g<m;g++){WGGroupingEngine.RenderColumnGroupTotalHeader(u,16,p,r,e,t);e=true}if(k.Hierarchical){WGGroupingEngine.RenderColumnGroupTotalHeader(u,22,p,r,e,t);e=true}if(u.RowHeaders=="Yes"||u.Get("RowHeaders")=="Yes"){WGGroupingEngine.RenderColumnGroupTotalHeader(u,16,p,r,e,t);e=true}if(u.PreviewRowVisible&&u.PreviewRowSettings.Expandable){WGGroupingEngine.RenderColumnGroupTotalHeader(u,16,p,r,e,t);e=true}var v=0;if(u.IsUseColumnSet){v=u.GetColSetColumnsCount();for(var g=0;g<u.ColumnSetRowCount;g++){if(g>0){w('<tr type="GroupTotalRow" ');w("csRowPos="+g+" ");if(l!=null){if(l.Parent!=null){if(!l.Parent.Expanded){w('style="display: none"')}}}w(" ");w('hasParent="'+WG50Engine.ToBoolString(l!=null)+'" ');w("position="+(o.Position+1)+" ");if(o.Group!=null){w("groupIndex="+(o.Group.Index-1).ToString()+" ")}else{w("groupIndex="+(l.Group.Index).ToString()+" ")}w('style="');w("height: "+u.ColumnSets[0].GetRowLayoutByPosition(g,0).Height);w('"');w(">")}for(var h=0;h<u.ColumnSets.length;h++){var c=u.ColumnSets[h];if(!c.Visible){continue}for(var h=0;h<c.ColumnCount;h++){var b=c.GetColumnByPosition(g,h);if(b==null){var n=c.GetRowLayout(g,h);if(n.Spanned!=RowLayoutSpan.None){}else{WGGroupingEngine.RenderGroupTotalCell(o,null,p,r,e,v,n);if(!e){e=true}}}else{WGGroupingEngine.RenderGroupTotalCell(o,b,p,r,e,v,null,t);if(!e){e=true}}}}if(g<u.ColumnSetRowCount-1){w("</tr>")}}}else{v=u.GetVisibleColumnNames().length;for(h=0;h<u.Columns.length;h++){var b=u.Columns[h];if(!b.Visible){continue}if(b.IsGrouped){if(u.Get("HideColumnsWhenGrouped")=="Yes"){continue}}WGGroupingEngine.RenderGroupTotalCell(o,b,p,r,e,v,null,t);if(!e){e=true}}}if(u.IsRootTable&&!u.IsUseColumnSet){w('<td class="'+p+'" style="border-left-width: 0px;');w('">&nbsp;</td>')}w("</tr>");w("</tbody>");if(o.Type=="Record"&&l!=null){l.GroupTotalRendered=true}else{if(o.Type=="GroupHeader"){o.GroupTotalRendered=true}}return t.ToString()},RenderGroupLoadMoreRow:function(g,a){var j=new IS.StringBuilder();var k=g.Table;var c=k.Grid;var e=c.LayoutSettings;var f=g.Parent;var h=g.Height;var l=function(i){j.Append(i)};if(a){j=a}if(h==0||h==null){h=e.RowHeightDefault}l("<tr ");l('type="GroupStatusRow" unselectable="true" ');l("groupIndex="+g.Group.Index+" ");l('fullPath="'+g.GetGroupRowLevel()+'" ');if(f!=null){l("parentIndex="+f.Position+" ")}l('style="');if(f!=null){if(g.HasCollapsedParents()){if(!(g.Parent!=null&&g.Parent.Expanded&&g.Parent.ForceExpGroup)){l("; display: none;")}}}l('">');if(e.Hierarchical&&!k.IsRootTable){l('<td noWrap style="margin:0; padding:0; width: 22px">');if(g.Parent==null){_RenderHierStructure(h,true,false)}else{RenderIStructure(h)}l("</td>")}for(var d=0;d<(g.Group.Index+1);d++){l("<td>&nbsp;</td>")}var b=0-(g.Group.Index+1);if(k.IsUseColumnSet){b+=k.GetColSetColumnsCount()+k.GroupedColumns.length;if(!k.IsRootTable){b++}if(!k.PreviewRowVisible){b--}}else{b+=k.GetVisibleColumnNames().length+k.GroupedColumns.length}if(e.Hierarchical){b+=1}if(k.Get("RowHeaders")=="Yes"){b+=1}if(k.IsRootTable){b+=1}else{if(k.Get("HideColumnsWhenGrouped")=="Yes"&&!k.IsUseColumnSet){b-=k.GroupedColumns.length}}l('<td type="GroupCell" class="'+e.GroupRowInfoClass+'" noWrap style="width:100%; ');l("border-left-width: 0px; padding: 0px; border-top-width: 0px;");l('" colSpan='+b+" ");l(">");l(WGGroupingEngine.RenderGroupStatus(g));l("</td>");l("</tr>");return j.ToString()},RenderColumnGroupTotalHeader:function(e,f,b,c,a,d){var g=function(h){d.Append(h)};g('<td class="'+b+'" style="width:'+f+"px;");g("border-right-width: 0px;");if(a){g("border-left-width: 0px;")}g('"');if(e.IsUseColumnSet){g(" rowSpan="+e.GetRowSpan(false).ToString())}g(">&nbsp;</td>")},RenderGroupTotalCell:function(f,b,g,h,c,k,a,i){var d=f.Parent;var j=f.Table;var e=null;var l=function(m){i.Append(m)};if(b!=null){if(b.CellClass!=""){g+=" "+b.CellClass}}if(!d&&f.Type=="GroupHeader"){d=f}l('<td nowrap="nowrap" class="'+g+'" style="');if(j.IsUseColumnSet){if(b!=null){e=j.GetRowLayoutByColMember(b.Name)}else{e=a}if(e!=null){if(e.colSet.Position==j.ColumnSets.Count-1&&(e.Col+e.ColSpan==e.colSet.ColumnCount)){}else{l("border-right-width: 0px;")}}}else{if(!j.IsRootTable){if(b.Position!=k-1){l("border-right-width: 0px;")}}else{l("border-right-width: 0px;")}}if(c){l("border-left-width: 0px;")}if(j.IsUseColumnSet){if(e!=null){if(e.Row!=j.ColumnSetRowCount-1){if(e.Row>0){l("border-top-width: 0;")}if(e.Row+e.RowSpan<j.ColumnSetRowCount){l("border-bottom-width: 0;")}}else{if(e.Row>0){l("border-top-width: 0;")}}}}l('"');if(e!=null){if(e.RowSpan>1){l(" rowSpan="+e.RowSpan)}if(e.ColSpan>1){l(" colSpan="+e.ColSpan)}}l(">");if(b!=null){if(b.AggregateFunction!="None"){if(b.FooterText!=""){l(b.FooterText+" ")}if(d.Children!=null&&d.Children.ParentRow==null){d.Children.ParentRow=d}if(f.Type=="GroupHeader"&&f.Group.Index>0&&d!=null){WGRenderEngine.RenderAggregateFunction(null,b,f.Children,i,f)}else{WGRenderEngine.RenderAggregateFunction(null,b,d.Children,i,d)}}else{l("&nbsp;")}}else{l("&nbsp;")}l("</td>")},UngroupRows:function(a,d){if(a==null){return}for(var b=0;b<a.length;b++){var c=a[b];if(c.Type=="GroupHeader"){WGGroupingEngine.UngroupRows(c.Children,d)}else{if(c.Type=="Record"){d.push(c)}}}return d},SetGroupRowStatus:function(h,j,e,i){var a=h.Grid;var f=j.fullPath+(j.fullPath!=""?"_":"")+j.position;var b=document.getElementById("dvs_"+a.Id+"_"+f);var d=j.cells[j.cells.length-1];if(b){var g=b.children[0];var c=a.GetString("CommonText/GroupRowPagingStatus");Listener.Unload(g);WG50Engine.RegisterStatusBarCommandBehavior(a,g);c=c.replace("{0}",e).replace("{1}",i);WGUIEngine.SetCommandAttribute(g.rows[0].cells[0],null,c,"")}j.loadedRows=e;d.innerText=WGGroupingEngine.FormatGroupCellText(h.ToRowObject(j).Cells[0],e)},LoadMoreGroupRows:function(b,c){var a=ISGetObject(b);var d=document.getElementById("ty_"+b+"_"+c);var e=d.previousSibling.children[0];WG50Engine.ExecuteFlyPostback(b,"LoadGroup",e,e.loadedRows)},RenderGroupStatus:function(c){var f=new IS.StringBuilder();var g=c.Table;var a=g.Grid;var b=a.LayoutSettings;var d=c.GetElement();var e=d.fullPath;var h=function(i){f.Append(i)};if(e!=""){e+="_"}e+=d.position;h('<div id="dvs_'+a.Id+"_"+e+'" class="'+b.StatusClass+'" style="width:100%; cursor:default">');h("<table cellspacing=1 cellpadding=0 width=100%>");h("<tr>");h(WGGroupingEngine.RenderCommandItem(a,new WebGridCommandItem("","","","",true,"Text")));h(WGGroupingEngine.RenderCommandItem(a,new WebGridCommandItem("","","","",true,"Separator")));h(WGGroupingEngine.RenderCommandItem(a,new WebGridCommandItem('WGUI.LMGR("'+a.Id+'", "'+e+'")',"",a.ResolveImagePathEx(b.ImageSettings.MoreDataImage),a.GetString("CommonText/GroupRowLoadMore"),true,"Command",-1)));h('<td style="width: 100%">&nbsp;</td>');h("</tr>");h("</table>");h("</div>");return f.ToString()},RenderCommandItem:function(a,b){var d=new IS.StringBuilder();var c=a.LayoutSettings;var e=c.StatusBarCommandStyle.Normal;var f="";var g=function(h){d.Append(h)};if(b.Pushed){e=c.StatusBarCommandStyle.Active}if(b.Type=="CommandButton"){f="Command"}else{f=b.Type;if(f=="Separator"){b.Width=2;b.ImageUrl=a.ResolveImagePathEx(c.ImageSettings.StatusBarSeparatorImage)}else{if(f=="Text"){b.Width=-1}}}g('<td nowrap="nowrap" align="center" type="'+f+'" style="cursor:'+(b.Enabled&&f=="Command"?"pointer":"default")+";");if(b.Width>-1){g("width:"+b.Width.toString()+"px;")}g('height:17px" class="');g(e);g('" ');if(!b.Enabled){g('disabled="disabled" ')}if(b.IsToggle){g('istoggle="1" ');if(b.Pushed){g('pushed="1" ')}}if(f=="Command"||f=="Separator"){if(f=="Command"){g("onclick='"+b.FunctionText+"' title=\""+b.TooltipText+'"')}g('><img align="absmiddle" src="'+a.ResolveImagePathEx(b.ImageUrl)+'"'+(!b.Enabled?' style="filter: gray(); opacity:0.5"':"")+"/>")}else{g(">")}if(f!="Separator"&&b.Text!=""){g("&nbsp;"+b.Text)}g("</td>");return d.ToString()},AddLoadedGroupRows:function(l,g){if(g.length>0){var a=WGRenderEngine.RenderRows(l,l.GetView(),g);var m=l.GetElement(WG40.BODY,WG40.HTMLTABLE);var c=l.Grid;var d=g[0].Parent;var q=d.GetElement();var h=q.fullPath;var f=q.loadedRows;if(h!=""){h+="_"}if(!f){f=0}f+=g.length;l._PartialRows=g;var j=document.getElementById("dvs_"+c.Id+"_"+h+q.position);if(j!=null){Listener.Unload(j.children[0]);j.parentElement.parentElement.removeNode(true)}if(c.ClientBindingSettings.EnableGroupRowPaging&&f<d.VirtualChildrenCount){d.GroupTotalRendered=true;a+=WGGroupingEngine.RenderGroupLoadMoreRow(d)}WGUIEngine.SetTempContent("<table><tbody>"+a+"</tbody></table>");var k=WGUIEngine.GetTempContent();var b=k.rows[0];var n=document.getElementById("ty_"+c.Id+"_"+h+q.position);if(c.FreezePaneActive&&c.FrozenColumns!=null){WGUIEngine.FormatFreezePane(c,true,k.rows)}if(IS.ie&&IS.IsXHTMLDocType()){var p=k.tBodies[0].childNodes.length;for(var e=0;e<p;e++){n.appendChild(k.tBodies[0].childNodes[0])}}else{n.appendChild(k.tBodies[0]);n.childNodes[n.childNodes.length-1].removeNode(false)}q.childrenLoaded="True";q.expanded="False";WGUIEngine.ToggleGroupRow(null,q,true);WG50Engine.OnOperationCompleted(l,"LoadGroup",b,[f,d.VirtualChildrenCount,q]);var o=g.length+parseFloat(c.TotalLoadedRows);var p=c.TotalRows;if(o>p){o=p}c.Set("TotalLoadedRows",o,true);c.SetStatus2("","loaded",o,p);c.SetStatus1("","ready","CommonText/Ready");WGUIEngine.ClearTempContent()}}};function WebGridCommandItem(b,e,c,d,a,f,g){this._Type="WebGridCommandItem";ISObject.call(this);this.FunctionText="";this.Text="";this.TooltipText="";this.ImageUrl="";this.Enabled=true;this.Pushed=false;this.IsToggle=false;this.Width=17;this.Type="CommandButton";if(b){this.FunctionText=b}if(e){this.TooltipText=e}if(c){this.ImageUrl=c}if(d){this.Text=d}if(a){this.Enabled=a}if(f){this.Type=f}if(g){this.Width=g}};