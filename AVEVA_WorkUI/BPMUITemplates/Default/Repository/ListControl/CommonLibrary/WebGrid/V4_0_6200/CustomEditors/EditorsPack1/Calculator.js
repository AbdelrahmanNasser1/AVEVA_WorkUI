/*
Calculator CustomEditor V1.2 for WebGrid.NET Enterprise Version 4.0
Copyright (c) 2005 Intersoft Solutions Corp. All rights reserved.
Unauthorized distribution or modification of this script is strictly prohibited.

Public Properties:
- Mode (Combo / DropDown)
- Font-Name
- Font-Size 
- Font-Weight
- ForeColor
- Width
- Height
- BackgroundColor 
- BorderColor
- NumericHighLightColor
- OperatorHighLightColor



Set column-level properties for editor in CustomEditorProperties using WebGrid.NET Designer.

Features:
- Keyboard events. Press Number/Numclock Number button to input value
                   Press * / - + = C button to input operator
                   Press Enter to input number
			    Press Arrow Key to move between input and operator
			    Press BackSpace to delete last number input
- Mouse events. Click tombol to operate calc
*/

// Implementation object for Calculator which contains set of required methods for custom editor interface.
// Format: CustomEditorName_Editor()
function Calculator_Editor()
{

	// #Start required interface implementation

	// Fired on WebGrid's initialization
	// Put codes to initialize custom editor's properties and create necessary objects here
	this.OnInitialize = function()
	{
	};

	this.OnUnload = function()
	{
		document.detachEvent("onkeydown", CalcKeyDownEventHandler);
		this = null;
		delete this;
	};

	// Fired when the control is entering edit mode
	// You can set default editor properties in this event
	this.OnEnterEditMode = function(activeCell, columnXml, isDirty)
	{
		// apply column-based editor properties if any
		this.SetProperties();
		var baseEditor = this.GetBaseEditorElement();
		this.BaseEditor = baseEditor;
		baseEditor.focus();
		baseEditor.isDirty = false;
		document.gridId = this.Grid.Name;
		
		// you should return the base editor element if any
		// otherwise, return the dropdown object
		return baseEditor;
	};

	// Fired when the control is about to be displayed during enter edit mode.
	// The value of the editor need to be set to reflect current cell's text.
	this.OnSetValue = function(text, activeCell)
	{
		var baseEditor = this.GetBaseEditorElement();
		if (text == " ") text = "";
		if (text != "")
			text = wgGetUnMask(this.Grid, this.CustomEditor.GetColumnXml(), activeCell.element, true, text);
		baseEditor.value = text;
	};

	// Fired when the editor's content is changed.
	this.OnDirty = function() {
		var baseEditor = this.GetBaseEditorElement();
		baseEditor.isDirty = true;
	};

	// Fired when the editor is about to exit edit mode
	this.OnExitEditMode = function(isCancel) {
		var dd = this.GetDropdownButtonElement();
		dd.style.display = "none";

		var baseEditor = this.GetBaseEditorElement();
		baseEditor.style.display = "none";
		this.HideCalc();
		
		if (!isCancel)
			return this.OnValidate(this.Grid.GetLastEditObject().cellElement);
		return true;
	};

	// Fired when the changes in editor is applied/accepted
	this.OnApply = function()
	{
		this.HideCalc();
	};

	// Fired when user cancel the changes in editor
	// by pressing Escape in editor or entire row changes cancel.
	this.OnCancel = function()
	{
		this.HideCalc();
	};

	// Fired when the cell is about to exit edit mode
	// When the validation result is true, it will process to exit edit mode.
	this.OnValidate = function(activeCellElement)
	{
		return true;
	};
	
	// Fired when user type on keyboard
	this.OnKeyDown = function()
	{
		if (this.Calc==null)
		{
			this.SetProperties();
      		this.Calc = new Calculator(this.Grid.Name, this.CalcUI);
		}
		var e = window.event;
		if (this.Calc.Popup.isOpen && this.Calc.ActiveCell!=null)
		{	
			with(this.Calc)
			{
				if (Key.IsDirKey())
						HighLightPad(e.keyCode);
				else
				{
					if (e.keyCode==13)
					{
						var c = ActiveCell.innerText;
						var rslt = "";
						var val;
						
						if ("*/-+=".indexOf(c)>-1 || c=="C" || c=="x^y" || c=="1/x" || c=="sqrt")
						{
							if (o.innerText=="1/x" || o.innerText=="sqrt")
							{
								Number = this.GetText();
							}
							rslt = Calculate(c);
							this.OnSetValue(rslt, this.CustomEditor.GetEditCell());
							Number = (c=="=")? new String(rslt) : "";
						}
						else
						{
							InsertNumber(c);
							this.OnSetValue(Number, this.CustomEditor.GetEditCell());
						}
							
						this.OnDirty();
						this.CustomEditor.RowDirty();
					}
					else
					{
						if (e.keyCode==8)
						{
							if (IsInput && Number.length>0)
							{	
								Number = Number.substr(0, Number.length-1);
								this.OnSetValue(Number, this.CustomEditor.GetEditCell());
								this.OnDirty();
								this.CustomEditor.RowDirty();
							}
							return;
						}
						var key;
						if (Key.IsOpKey())
						{
							key = Key.GetOp();	
							var rslt = Calculate(key);
							this.OnSetValue( rslt, this.CustomEditor.GetEditCell());
							this.OnDirty();
							this.CustomEditor.RowDirty();
							Number = (Key.GetOp()=="=")? (rslt=="0"? "" : new String(rslt)) : "";
							HighLightPadByValue(key);
						}
						else
						{
							if (Key.IsNumKey())
							{
								key = Key.GetNumber();
								InsertNumber(key);
								this.OnSetValue(Number, this.CustomEditor.GetEditCell());
								this.OnDirty();
								this.CustomEditor.RowDirty();
								HighLightPadByValue(key);
							}
						}
						
					}
				}
			}
		}
		else
		{
			if (e.keyCode == 115) 
			{
				this.OnDropdown();
				e.cancelBubble = true;
				e.returnValue = false;
				e.keyCode = 0;
			}
				
			if(this.Mode=="DropDown")
			{
				e.cancelBubble = true;
				e.returnValue = false;
			}
			else
				if (!((48<=e.keyCode && e.keyCode<=57) || (96<=e.keyCode && e.keyCode<=105) || e.keyCode == 115 || e.keyCode==32 || e.keyCode==8 || e.keyCode==37 || e.keyCode==39))
				{
					e.cancelBubble = true;
					e.returnValue = false;
				}
		
		}
			
	};
	
	// Fired when dropdown button is clicked
	// Automatically fired used when dropdown button type is Image
	this.OnDropdown = function()
	{
		if (!this.Grid.GetLastEditObject())
		{
			// simulate enter key
			var oEvt = document.createEventObject();
			var ac = this.CustomEditor.GetEditCellElement();
			oEvt.keyCode = 13;
			oEvt._srcElement = ac;
			ac.fireEvent("onkeydown", oEvt);
		}

		CalcDropDownClick(null, this.Grid.Name, this.CustomEditor.Name);
	};

	// Required method to get base editor element
	// Put codes to get the base editor element
	this.GetBaseEditorElement = function()
	{
		// since we used Textbox as BaseEditor, we can obtain
		// it directly in CustomEditor object.
		return this.CustomEditor.GetBaseEditorElement();
	};
	
	// Required method to get dropdown button element
	// Put codes here to get the dropdown button element
	this.GetDropdownButtonElement = function()
	{
		// since we used Image dropdowntype, we dont need to create own object and simply call base's GetDropdownButtonElement.
		return this.CustomEditor.GetDropdownButtonElement();
	};
	
	// Required method to get the IsDirty status of the editor	
	this.IsDirty = function()
	{
		var baseEditor = this.GetBaseEditorElement();
		return baseEditor.isDirty;
	};
	
	// Required method to get the content of the editor
	this.GetText = function()
	{
		var baseEditor = this.GetBaseEditorElement();
		var text = baseEditor.value;
		
		if (text == null) text = "";
		
		if (this.Grid.GetLastEditObject())
			text = wgGetMask(this.Grid, this.Grid.GetLastEditObject(), text);
		return text;
	};
	
	// Required method to get the value of the editor
	// Only useful when editor value is differ then content/text such as in Dropdownlist.
	this.GetValue = function()
	{
		// since this editor has same value and content,
		// simply return the text
		return this.GetText();
	};

	// Required method to apply editor properties defined in Column's CustomEditorProperties
	this.SetProperties = function()
	{
		var props = this.CustomEditor.GetColumnEditorProperties();
		var aProps = props.split(";");
		for (var i=0; i<aProps.length; i++)
		{
			this.SetProperty(aProps[i].split("=")[0], aProps[i].split("=")[1]);
		}
	};

	// #End interface implementation


	// #Start required properties

	this.Grid = null;
	this.CustomEditor = null;
	this.ControlName = "Calculator";
	this.Calc = null;
	this.EditState = null;
	this.BaseEditor = null;

	// #End properties

	// #Start NumericUpDown editor functions
	this.DDBtn = null;
	this.Mode = "Combo";
	this.CalcUI = new CalculatorUI();

	// Required method to apply individual property
	this.SetProperty = function(propName, propValue)
	{
		switch (propName)
		{
			case "Mode": this.Mode = propValue; break;
			case "Font-Name" : this.CalcUI.FontName = propValue; break;
			case "Font-Size" : this.CalcUI.FontSize = propValue; break;
			case "Font-Weight" : this.CalcUI.FontWeight = propValue; break;
			case "ForeColor" : this.CalcUI.ForeColor = propValue; break;
			case "Height" : this.CalcUI.Height = propValue; break;
			case "Width" : this.CalcUI.Width = propValue; break;
			case "BackgroundColor" : this.CalcUI.BackgroundColor = propValue; break;
			case "BorderColor" : this.CalcUI.BorderColor = propValue; break;
			case "NumericHighLightColor" : this.CalcUI.NumericHighLightColor = propValue; break;
			case "OperatorHighLightColor" : this.CalcUI.OperatorHighLightColor = propValue; break;
		}
	};

	this.ShowCalc = function()
	{
		
      	if (this.Calc==null)
      		this.Calc = new Calculator(this.Grid.Name, this.CalcUI);

		var txt = this.GetText();
		if (isNaN(txt))
			txt = parseFloat(txt);
		var ac = this.CustomEditor.GetEditCell();
      	with(this.Calc)
      	{
      		Popup.show(ISPosLib.getScreenLeft(ac.element),ISPosLib.getScreenTop(ac.element)+ac.element.offsetHeight,this.CalcUI.Width, this.CalcUI.Height);
      		CalcStr="";
			LastOperation = "";
			Number = txt;
			HighLightPad(37);
      	}
      	this.EditState = "edit" + this.Mode;
      	
	};

	this.HideCalc = function()
	{
      	if (this.Calc==null)
      		this.Calc = new Calculator(this.Grid.Name, this.CalcUI);
		this.Calc.Popup.hide();
		this.EditState = null;	
			
	}

	// #End functions

return this;
}

// fired when image up is clicked
function CalcDropDownClick(obj, gridId, ceName)
{
	var grid = wgGetGridById(gridId);
	var editor = grid.CustomEditors[ceName];
	editor.ImplementationObject.ShowCalc();
}

function CalculatorUI()
{
	this.BackgroundColor = "#f5f5f5";
	this.FontName = "Verdana";
	this.FontSize = "8pt";
	this.FontWeight = "normal";
	this.ForeColor = "";
	this.Height = "120";
	this.Width = "120";
	this.BorderColor = "darkgray";
	this.NumericHighLightColor = "#dcdcdc";
	this.OperatorHighLightColor = "#a9a9a9";

}

function Calculator(gridId, calcUI)
{
	this.Popup = window.createPopup();
	this.CalcUI = calcUI;
//	this.docBody = "<TABLE id='tbl1' style='FONT-WEIGHT: bold; FONT-SIZE: 12px; CURSOR: hand; BORDER-TOP-STYLE: none; FONT-FAMILY: Comic Sans MS; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: " + calcUI.BackgroundColor + "; BORDER-BOTTOM-STYLE: none' borderColor='" + calcUI.BorderColor + "' height='100' cellSpacing='0' cellPadding='0' width='100' border='1'><TR align='center'><TD onmouseover=\"parent.CalcNumOver(this, '" + gridId + "')\" onclick=\"parent.CalcNumClick(this, '" + gridId + "')\" onmouseout='parent.CalcNumOut(this)'>1</TD><TD onmouseover=\"parent.CalcNumOver(this, '" + gridId + "')\" onclick=\"parent.CalcNumClick(this, '" + gridId + "')\" onmouseout='parent.CalcNumOut(this)'>2</TD><TD onmouseover=\"parent.CalcNumOver(this, '" + gridId + "')\" onclick=\"parent.CalcNumClick(this, '" + gridId + "')\" onmouseout='parent.CalcNumOut(this)'>3</TD><TD onmouseover=\"parent.CalcOpOver(this, '" + gridId + "')\" onclick=\"parent.CalcOpClick(this, '" + gridId + "')\" onmouseout='parent.CalcOpOut(this)'>*</TD></TR><TR align='center'><TD onmouseover=\"parent.CalcNumOver(this, '" + gridId + "')\" onclick=\"parent.CalcNumClick(this, '" + gridId + "')\" onmouseout='parent.CalcNumOut(this)'>4</TD><TD onmouseover=\"parent.CalcNumOver(this, '" + gridId + "')\" onclick=\"parent.CalcNumClick(this, '" + gridId + "')\" onmouseout='parent.CalcNumOut(this)'>5</TD><TD onmouseover=\"parent.CalcNumOver(this, '" + gridId + "')\" onclick=\"parent.CalcNumClick(this, '" + gridId + "')\" onmouseout='parent.CalcNumOut(this)'>6</TD><TD onmouseover=\"parent.CalcOpOver(this, '" + gridId + "')\" onclick=\"parent.CalcOpClick(this, '" + gridId + "')\" onmouseout='parent.CalcOpOut(this)'>-</TD></TR><TR align='center'><TD onmouseover=\"parent.CalcNumOver(this, '" + gridId + "')\" onclick=\"parent.CalcNumClick(this, '" + gridId + "')\" onmouseout='parent.CalcNumOut(this)'>7</TD><TD onmouseover=\"parent.CalcNumOver(this, '" + gridId + "')\" onclick=\"parent.CalcNumClick(this, '" + gridId + "')\" onmouseout='parent.CalcNumOut(this)'>8</TD><TD onmouseover=\"parent.CalcNumOver(this, '" + gridId + "')\" onclick=\"parent.CalcNumClick(this, '" + gridId + "')\" onmouseout='parent.CalcNumOut(this)'>9</TD><TD onmouseover=\"parent.CalcOpOver(this, '" + gridId + "')\" onclick=\"parent.CalcOpClick(this, '" + gridId + "')\" onmouseout='parent.CalcOpOut(this)'>+</TD></TR><TR align='center'><TD onmouseover=\"parent.CalcNumOver(this, '" + gridId + "')\" onclick=\"parent.CalcNumClick(this, '" + gridId + "')\" onmouseout='parent.CalcNumOut(this)'>.</TD><TD onmouseover=\"parent.CalcNumOver(this, '" + gridId + "')\" onclick=\"parent.CalcNumClick(this, '" + gridId + "')\" onmouseout='parent.CalcNumOut(this)'>0</TD><TD onmouseover=\"parent.CalcOpOver(this, '" + gridId + "')\" onclick=\"parent.CalcOpClick(this, '" + gridId + "')\" onmouseout='parent.CalcOpOut(this)'>/</TD><TD onmouseover=\"parent.CalcOpOver(this, '" + gridId + "')\" onclick=\"parent.CalcOpClick(this, '" + gridId + "')\" onmouseout='parent.CalcOpOut(this)'>=</TD></TR></TABLE>";
	this.docBody = "<TABLE id='tbl1' style='table-layout:fixed;COLOR : " + calcUI.ForeColor + ";FONT-WEIGHT: " + calcUI.FontWeight + "; FONT-SIZE: " + calcUI.FontSize + "; CURSOR: hand; BORDER-TOP-STYLE: none; FONT-FAMILY: " + calcUI.FontName + "; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: " + calcUI.BackgroundColor + "; BORDER-BOTTOM-STYLE: none' borderColor='" + calcUI.BorderColor + "' height='" + calcUI.Height + "' cellSpacing='0' cellPadding='0' width='" + calcUI.Width + "' border='1'><TR align='center'><TD onmouseover=\"parent.CalcOpOver(this, '" + gridId + "', '" + calcUI.OperatorHighLightColor + "')\" onclick=\"parent.CalcOpClick(this, '" + gridId + "')\" onmouseout='parent.CalcOpOut(this)'>C</TD><TD onmouseover=\"parent.CalcOpOver(this, '" + gridId + "', '" + calcUI.OperatorHighLightColor + "')\" onclick=\"parent.CalcOpClick(this, '" + gridId + "')\" onmouseout='parent.CalcOpOut(this)'>1/x</TD><TD onmouseover=\"parent.CalcOpOver(this, '" + gridId + "', '" + calcUI.OperatorHighLightColor + "')\" onclick=\"parent.CalcOpClick(this, '" + gridId + "')\" onmouseout='parent.CalcOpOut(this)'>x^y</TD><TD onmouseover=\"parent.CalcOpOver(this, '" + gridId + "', '" + calcUI.OperatorHighLightColor + "')\" onclick=\"parent.CalcOpClick(this, '" + gridId + "')\" onmouseout='parent.CalcOpOut(this)'>sqrt</TD></TR><TR align='center'><TD onmouseover=\"parent.CalcNumOver(this, '" + gridId + "', '" + calcUI.NumericHighLightColor + "')\" onclick=\"parent.CalcNumClick(this, '" + gridId + "')\" onmouseout='parent.CalcNumOut(this)'>1</TD><TD onmouseover=\"parent.CalcNumOver(this, '" + gridId + "', '" + calcUI.NumericHighLightColor + "')\" onclick=\"parent.CalcNumClick(this, '" + gridId + "')\" onmouseout='parent.CalcNumOut(this)'>2</TD><TD onmouseover=\"parent.CalcNumOver(this, '" + gridId + "', '" + calcUI.NumericHighLightColor + "')\" onclick=\"parent.CalcNumClick(this, '" + gridId + "')\" onmouseout='parent.CalcNumOut(this)'>3</TD><TD onmouseover=\"parent.CalcOpOver(this, '" + gridId + "', '" + calcUI.OperatorHighLightColor + "')\" onclick=\"parent.CalcOpClick(this, '" + gridId + "')\" onmouseout='parent.CalcOpOut(this)'>*</TD></TR><TR align='center'><TD onmouseover=\"parent.CalcNumOver(this, '" + gridId + "', '" + calcUI.NumericHighLightColor + "')\" onclick=\"parent.CalcNumClick(this, '" + gridId + "')\" onmouseout='parent.CalcNumOut(this)'>4</TD><TD onmouseover=\"parent.CalcNumOver(this, '" + gridId + "', '" + calcUI.NumericHighLightColor + "')\" onclick=\"parent.CalcNumClick(this, '" + gridId + "')\" onmouseout='parent.CalcNumOut(this)'>5</TD><TD onmouseover=\"parent.CalcNumOver(this, '" + gridId + "', '" + calcUI.NumericHighLightColor + "')\" onclick=\"parent.CalcNumClick(this, '" + gridId + "')\" onmouseout='parent.CalcNumOut(this)'>6</TD><TD onmouseover=\"parent.CalcOpOver(this, '" + gridId + "', '" + calcUI.OperatorHighLightColor + "')\" onclick=\"parent.CalcOpClick(this, '" + gridId + "')\" onmouseout='parent.CalcOpOut(this)'>-</TD></TR><TR align='center'><TD onmouseover=\"parent.CalcNumOver(this, '" + gridId + "', '" + calcUI.NumericHighLightColor + "')\" onclick=\"parent.CalcNumClick(this, '" + gridId + "')\" onmouseout='parent.CalcNumOut(this)'>7</TD><TD onmouseover=\"parent.CalcNumOver(this, '" + gridId + "', '" + calcUI.NumericHighLightColor + "')\" onclick=\"parent.CalcNumClick(this, '" + gridId + "')\" onmouseout='parent.CalcNumOut(this)'>8</TD><TD onmouseover=\"parent.CalcNumOver(this, '" + gridId + "', '" + calcUI.NumericHighLightColor + "')\" onclick=\"parent.CalcNumClick(this, '" + gridId + "')\" onmouseout='parent.CalcNumOut(this)'>9</TD><TD onmouseover=\"parent.CalcOpOver(this, '" + gridId + "', '" + calcUI.OperatorHighLightColor + "')\" onclick=\"parent.CalcOpClick(this, '" + gridId + "')\" onmouseout='parent.CalcOpOut(this)'>+</TD></TR><TR align='center'><TD onmouseover=\"parent.CalcNumOver(this, '" + gridId + "', '" + calcUI.NumericHighLightColor + "')\" onclick=\"parent.CalcNumClick(this, '" + gridId + "')\" onmouseout='parent.CalcNumOut(this)'>.</TD><TD onmouseover=\"parent.CalcNumOver(this, '" + gridId + "', '" + calcUI.NumericHighLightColor + "')\" onclick=\"parent.CalcNumClick(this, '" + gridId + "')\" onmouseout='parent.CalcNumOut(this)'>0</TD><TD onmouseover=\"parent.CalcOpOver(this, '" + gridId + "', '" + calcUI.OperatorHighLightColor + "')\" onclick=\"parent.CalcOpClick(this, '" + gridId + "')\" onmouseout='parent.CalcOpOut(this)'>/</TD><TD onmouseover=\"parent.CalcOpOver(this, '" + gridId + "', '" + calcUI.OperatorHighLightColor + "')\" onclick=\"parent.CalcOpClick(this, '" + gridId + "')\" onmouseout='parent.CalcOpOut(this)'>=</TD></TR></TABLE>";
	this.Number = "";
	this.Result = 0;
	this.CalcStr = "";
	this.LastOperation = "";
	this.ActiveCell = null;
	this.IsInput = true;
	
	this.Calculate = function(op)
	{
		if (op=="=")
		{
			if (this.CalcStr!="")
			{
				if (this.Number=="")
				{
					if ("+-*/".indexOf(this.CalcStr.charAt(this.CalcStr.length-1))>-1)
						this.CalcStr = this.CalcStr.substr(0, this.CalcStr.length-1);
					else
						if (this.LastOperation=="x^y")
							this.CalcStr = this.CalcStr.replace("Math.pow((", "").replace("),", "");
				}
				else
					this.CalcStr = this.CalcStr + this.Number + ( (this.LastOperation!="x^y")? "" : ")" );
				this.Result = eval(this.CalcStr);
				this.Result = new String(this.Result);
				this.CalcStr = "";
			}
			else
				this.Result = this.Number;
			this.IsInput = false;
		}
		else
		{
			if (op=="C")
			{
				this.CalcStr = ""; this.Result = "0";
				this.Number = "";
			}
			else
				if (op=="1/x" || op=="sqrt")
				{
					if (this.Number!="")
						this.Result = (op=="1/x")? eval("1/(" + this.Number + ")") : Math.sqrt(this.Number);
					else
						this.Result = "0";
	
					this.CalcStr = this.Result = new String(this.Result);
				}
				else
				{
					if (this.Number=="")
					{
						if ("+-*/".indexOf(this.CalcStr.charAt(this.CalcStr.length-1))>-1)
							this.CalcStr = this.CalcStr.substr(0, this.CalcStr.length-1);
						else
							if (this.LastOperation=="x^y")
								this.CalcStr = this.CalcStr.replace("Math.pow((", "").replace("),", "");
					}
					
					if (op=="x^y")
					{
						if (this.CalcStr!="")
						{
							if ("+-*/".indexOf(this.CalcStr.charAt(this.CalcStr.length-1)) >-1)
								this.CalcStr = this.CalcStr.substr(0, this.CalcStr.length-1);
							
							if (this.CalcStr.indexOf("Math.pow")==-1)
								this.CalcStr = "Math.pow((" + eval(this.CalcStr) + "),";
						}
						else
							if (this.Number!="")
								this.CalcStr = "Math.pow((" + this.Number + "),";
					}
					else
					{
						if (this.Number!="")
						{
							this.CalcStr = this.CalcStr + ((this.Number!="")? this.Number : "") + ( (this.LastOperation!="x^y")? "" : ")" );
							this.Result = eval(this.CalcStr);
							this.Result = new String(this.Result);
							this.CalcStr = this.Result + op;
						}
						else
							this.CalcStr = this.CalcStr + op;
					}
				}
			this.IsInput = true;	
		}

		//this.Number = "";
		this.LastOperation = op;
		return this.Result;
	};
	
	this.InsertNumber = function(n)
	{
		if (this.LastOperation!="=" ||  this.Number!="")
		{
			if (n=="." && this.Number=="") return;
			if (this.Number.indexOf(".")>-1 && n==".") return;
			this.Number = this.Number + n;
		}
		else
		{
			if (n=="." && this.CalcStr=="") return;
			if (this.Number.indexOf(".")>-1 && n==".") return;
			this.Number = this.CalcStr + n;
		}
		this.IsInput = true;
	};
	
	this.ResetUI = function()
	{
		var tbl = this.Popup.document.getElementById("tbl1");
		
		for(var i=0; i<tbl.rows.length;i++)
		{
			for(var j=0; j<tbl.rows[i].children.length;j++)
			{
				tbl.rows[i].children[j].style.backgroundColor = this.CalcUI.BackgroundColor;	
			}
		}
	};
	
	this.ResetActiveCellUI = function()
	{
		if (this.ActiveCell!=null)
			this.ActiveCell.style.backgroundColor = this.CalcUI.BackgroundColor;	
	};

	this.HighLightPad = function(keyCode)
	{
		this.ResetUI();
		var rowIdx, cellIdx;
		if (this.ActiveCell==null)
			rowIdx = cellIdx = -1;
		else
		{
			with(this.ActiveCell)
			{
				style.backgroundColor = this.CalcUI.BackgroundColor;
				cellIdx = cellIndex;
				rowIdx = parentElement.rowIndex;
			}
		}
		if (keyCode==38 || keyCode==40)
		{
			if (rowIdx<0) 
				rowIdx=cellIdx=0;
			else
				rowIdx += (keyCode==38)? ((rowIdx==0)? 0 : -1) : ((rowIdx<4)? 1 : 0); 
		}
		else
		{		
			if (cellIdx<0)
				cellIdx=rowIdx=0;
			else
				cellIdx += (keyCode==37)? ((cellIdx==0)? 0 : -1) : ((cellIdx<3)? 1 : 0); 
		}	
		var cell;
		with(this.Popup.document.getElementById("tbl1"))
		{
			cell = rows[rowIdx].children[cellIdx];
			if ("/*-+=".indexOf(cell.innerText)>-1 || cell.innerText=="C" || cell.innerText=="x^y" || cell.innerText=="1/x" || cell.innerText=="sqrt")
				cell.style.backgroundColor = this.CalcUI.OperatorHighLightColor;
			else
				cell.style.backgroundColor = this.CalcUI.NumericHighLightColor;
		}
		this.ActiveCell = cell;
	};
	
	this.HighLightPadByValue = function(val)
	{
		var tbl = this.Popup.document.getElementById("tbl1");
		
		var cell;
		for(var i=0; i<tbl.rows.length;i++)
		{
			for(var j=0; j<tbl.rows[i].children.length;j++)
			{
				cell = tbl.rows[i].children[j];
				if (cell.innerText!=val)
					cell.style.backgroundColor = this.CalcUI.BackgroundColor;	
				else
				{
					cell.style.backgroundColor = ("+-*/=cC".indexOf(val)>-1)? this.CalcUI.OperatorHighLightColor : this.CalcUI.NumericHighLightColor;	
					this.ActiveCell = cell;
				}
			}
		}

	};
		
	with(this.Popup.document.body)
	{
		topMargin=bottomMargin=leftMargin=rightMargin=0;
		innerHTML = this.docBody;
	}
}


function CalcNumOver(o, gridId, c) 
{ 
	o.style.backgroundColor = c; 
	var grid = wgGetGridById(gridId);
	var editor = grid.CustomEditors.Calculator;
	var calc = editor.ImplementationObject.Calc;
	calc.ResetActiveCellUI();
	calc.ActiveCell = o;	
}
function CalcNumOut(o) { o.style.backgroundColor = 'Transparent'; }
function CalcOpOver(o, gridId, c) 
{
	o.style.backgroundColor = c;
	var grid = wgGetGridById(gridId);
	var editor = grid.CustomEditors.Calculator;
	var calc = editor.ImplementationObject.Calc;
	calc.ResetActiveCellUI();
	calc.ActiveCell = o;	
}
function CalcOpOut(o) { o.style.backgroundColor = 'Transparent'; }
function CalcNumClick(o, gridId) 
{
	var grid = wgGetGridById(gridId);
	var editor = grid.CustomEditors.Calculator;
	var calc = editor.ImplementationObject.Calc;
	calc.InsertNumber(o.innerText);
	with(editor.ImplementationObject)
	{
		OnSetValue(calc.Number, CustomEditor.GetEditCell());
		OnDirty();
		CustomEditor.RowDirty();
	}
	
}
function CalcOpClick(o, gridId)
{
	var grid = wgGetGridById(gridId);
	var editor = grid.CustomEditors.Calculator;
	with(editor.ImplementationObject)
	{
		if (o.innerText=="1/x" || o.innerText=="sqrt")
		{
			Calc.Number = GetText();
		}
		var rslt = Calc.Calculate(o.innerText);
		OnSetValue( rslt, CustomEditor.GetEditCell());
		OnDirty();
		CustomEditor.RowDirty();
		Calc.Number = (o.innerText=="=")? (rslt=="0"? "" : new String(rslt)) : "";
	}
	
}

function CalcKeyDownEventHandler()
{
	if (document.gridId==null) return;
	var grid = wgGetGridById(document.gridId);
	var editor = grid.CustomEditors.Calculator;
	if (editor.ImplementationObject.Calc!=null)
	{
		editor.ImplementationObject.OnKeyDown();
		if (editor.ImplementationObject.Calc.Popup.isOpen)
		{
			with(window.event)
			{
				cancelBubble = true;
				returnValue = false;
			}
		}
	}
	
}
document.attachEvent("onkeydown", CalcKeyDownEventHandler);

var Key =  
	{
		IsDirKey : function()
		{
			var e = window.event;
			return (37<=e.keyCode && e.keyCode<=40);		
		},
		
		IsNumKey : function()
		{
			var e = window.event;
			return ((48<=e.keyCode && e.keyCode<=57) || (96<=e.keyCode && e.keyCode<=105) || e.keyCode==110 || e.keyCode==190);
		},

		GetNumber : function()
		{
			var n ="";
			var e = window.event;
			
			if (48<=e.keyCode && e.keyCode<=57)
				n = e.keyCode - 48;
			else
				if (96<=e.keyCode && e.keyCode<=105)
					n = e.keyCode - 96;
				else
					if (e.keyCode==110 || e.keyCode==190)
						n = ".";
			
			return new String(n);
		},
		
		IsOpKey : function()
		{
			return (Key.IsMultiplyKey() || Key.IsDivideKey() || Key.IsPlusKey() || Key.IsMinusKey() || Key.IsEqualKey() || Key.IsClearKey());
		},

		GetOp : function()
		{
			var op="";
			
			if (Key.IsOpKey())
			{
				if (Key.IsMultiplyKey())
					op = "*";
				else
					if (Key.IsDivideKey())
						op = "/";
					else
						if (Key.IsPlusKey())
							op = "+";
						else
							if (Key.IsMinusKey())
								op = "-";
							else
								if (Key.IsEqualKey())
									op = "=";
								else
									if (Key.IsClearKey())
										op = "C";
			}
			
			return op;
		},
			
		IsMultiplyKey : function()
		{
			var e = window.event;
			return (e.keyCode==106 || (e.shiftKey && e.keyCode==56));
		},
		
		IsDivideKey : function()
		{
			var e = window.event;
			return (e.keyCode==111 || e.keyCode==191);
		},

		IsPlusKey : function()
		{
			var e = window.event;
			return (e.keyCode==107 || (e.shiftKey && e.keyCode==187));
		},

		IsMinusKey : function()
		{
			var e = window.event;
			return (e.keyCode==109 || e.keyCode==189);
		},
		
		IsEqualKey : function()
		{
			var e = window.event;
			return (e.keyCode==187);		
		},
		
		IsClearKey : function()
		{
			var e = window.event;
			return (e.keyCode==67);		
		}
		
	}
