<%@ Page Language="C#" AutoEventWireup="true" CodeFile="color_dialog.aspx.cs" Inherits="BPMUITemplates_Default_ProcessDesigner_ColorPicker_color_dialog" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title><%=ResourceManager.GlobalResourceSet.GetString("Choose Color")%></title>

<style>

input {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	padding-top: 1px;	
	padding-bottom: 1px;	
	padding-left: 3px;	
	padding-right: 3px;	
	color: #666666;
	border: 1px solid #666666;	
}

span {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	padding-top: 1px;	
	padding-bottom: 1px;	
	padding-left: 3px;	
	padding-right: 3px;	
	color: #666666;
}

button{
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	background: #CCCCCC;
	color: #FFFFFF;
	padding-top: 1px;	
	padding-bottom: 1px;	
	padding-left: 3px;	
	padding-right: 3px;	
	text-align: center;
	height: 16px;
	width: 90px;
	cursor:pointer;
	cursor: hand;
	border: 0px solid #000000;
	font-variant: small-caps;	
}
</style>

<script language="javascript" src="color_conv.js"></script>

</head>

<body onLoad="fnOnLoad();"  bgcolor="#CCCCCC">

<div id='div_colors' style="position:absolute; display:none;">
<span><%=ResourceManager.GlobalResourceSet.GetString("Basic colors")%>:</span>
<br/>
</div>

<div id='div_cust_colors' style="position:absolute; display:none;">
<span><%=ResourceManager.GlobalResourceSet.GetString("Custom colors")%>:</span>
<br/>
</div>

<div id='div_buttons' style="position:absolute; top:300px; display:none;">
	<table>
	<tr>
	<td>&nbsp;</td>
	</tr>
		<tr>
			<td align = "center" colspan = "2">
			<input type="button" id="DefineCustomColors" name="DefineCustomColors" value = "<%=ResourceManager.GlobalResourceSet.GetString("Define Custom Colors >>")%>"
				onClick="ShowHideCustColors('<%=ResourceManager.GlobalResourceSet.GetString("Define Custom Colors >>")%>','<%=ResourceManager.GlobalResourceSet.GetString("Define Custom Colors <<")%>');"
			>
			</td>
		</tr>
		<tr>
	<td>&nbsp;</td>
	</tr>
		<tr>
			<td align = "center">
				<input style="width:70px" type="button" id="btn_OK" name="btn_OK" value = "<%=ResourceManager.GlobalResourceSet.GetString("OK")%>" onClick="EndDialog('OK');" >
			</td>
			<td >				
				<input style="width:70px"  type="button" id="btn_Cancel" name="btn_Cancel" value = "<%=ResourceManager.GlobalResourceSet.GetString("Cancel")%>" onClick="EndDialog('Cancel');" >
			</td>
		</tr>
	</table>
</div>



<div id='div_graphics' style="position:absolute; display:none">
	<div id = "HSTable" style="position:absolute; " onclick="CalcSelectPos(event);">
		<div  id = "div_select" style="position:absolute; padding:0px; margin:0px; outline:0px" >
			<img id = "img_select" src="pix/select.GIF"></img>
		</div>
	</div>
	
	<div id = "LTable" style="position:absolute;" onClick="CalcSliderPos(event);">
		<div  id = "div_slider" style="position:absolute; padding:0px; margin:0px; outline:0px;">
			<img id = "img_slide" src="pix/slide.GIF"></img>
		</div>
	</div>
</div>



<div id="div_values" style="position:absolute; display:none;">
<table cellpadding="0" cellspacing="0">
<tr>
<!------------------------------------------------------------->
	<td>
		<table cellpadding="0" cellspacing="0" >
			<tr height="40" >
				<td id="previewColor">
				</td>
			</tr>
			<tr>
				<td>
				<span><%=ResourceManager.GlobalResourceSet.GetString("Color|Solid")%></span>
				</td>
			</tr>
		</table>
	</td>
<!------------------------------------------------------------->
	<td>
		<table>
			<tr>
				<td align="right"><span><%=ResourceManager.GlobalResourceSet.GetString("Hue")%>:</span></td>
				<td><input maxlength="3" size="3" type="text" id="H_id" name="H_id" value = "2" onKeyUp="fnVerifyNumber('H_id',240);CalcPosByHue();"/></td>
			</tr>
			<tr>
				<td align="right"><span><%=ResourceManager.GlobalResourceSet.GetString("Sat")%>:</span></td>
				<td><input maxlength="3"size="3" type="text" id="S_id" name="S_id" value = "2" onKeyUp="fnVerifyNumber('S_id',240);CalcPosBySat();"/></td>
			</tr>
			<tr>
				<td align="right"><span><%=ResourceManager.GlobalResourceSet.GetString("Lum")%>
                    :</span></td>
				<td><input maxlength="3" size="3" type="text" id="L_id" name="L_id" value = "2" onKeyUp="fnVerifyNumber('L_id',240);CalcPosByLum();"/></td>
			</tr>
		</table>
	</td>
<!------------------------------------------------------------->
	<td>
		<table>
			<tr>
				<td align="right"><span><%=ResourceManager.GlobalResourceSet.GetString("Red")%>:</span></td>
				<td><input maxlength="3" size="3" type="text" id="R_id" name="R_id" value = "1" onKeyUp="fnVerifyNumber('R_id',255);OnChangeRGB();"/></td>
			</tr>
			<tr>
				<td align="right"><span><%=ResourceManager.GlobalResourceSet.GetString("Green")%>:</span></td>
				<td><input maxlength="3" size="3" type="text" id="G_id" name="G_id" value = "1" onKeyUp="fnVerifyNumber('G_id',255);OnChangeRGB();"/></td>
			</tr>
			<tr>
				<td align="right"><span><%=ResourceManager.GlobalResourceSet.GetString("Blue")%>:</span></td>
				<td><input maxlength="3" size="3" type="text" id="B_id" name="B_id" value = "1" onKeyUp="fnVerifyNumber('B_id',255);OnChangeRGB();"/></td>
			</tr>
		</table>
	</td>

</tr>
<tr>
<td>&nbsp;</td>
</tr>
<tr height="35px">
<td>&nbsp;</td>
<td>&nbsp;</td>
</tr>
<tr>
	<td colspan="3" align="center">
		<input type="button" id="AddCustomColor" name="AddCustomColor" value = "<%=ResourceManager.GlobalResourceSet.GetString("Add Custom Color")%>" 
			onClick="
				R = parseInt(document.getElementById('R_id').value);
				G = parseInt(document.getElementById('G_id').value);
				B = parseInt(document.getElementById('B_id').value);
				fnAddCustColorClick(R,G,B);
			"
		/>
	</td>
</tr>
</table>
</div>
</body>

</html>