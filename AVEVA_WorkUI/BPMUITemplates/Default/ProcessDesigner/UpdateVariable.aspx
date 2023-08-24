<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.PropertyTypes.UpdateVariable" %>
<%@ OutputCache Location="None" Duration="1" %>
<%@ Assembly Name="Workflow.NET.Web.Designer.NET2" %>
<%@ Import namespace="Workflow.NET.Web.Designer" %>
<%@ Assembly Name="Workflow.NET.NET2" %>
<%@ Import namespace="Workflow.NET"%>
<%@ Register TagPrefix="cc1" Namespace="Workflow.NET.Ajax" Assembly="Workflow.NET.NET2" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ProcessDesignerControl.GetThemeRelativeUrl("Common/stylesheet/Global.css"))%>">
<link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ProcessDesignerControl.GetThemeRelativeUrl("Common/stylesheet/kendo.common.min.css"))%>">
<link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ProcessDesignerControl.GetThemeRelativeUrl("Common/stylesheet/kendo.default.min.css"))%>">
<link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ProcessDesignerControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTTreeView/TreeView.AWTTreeView.css"))%>" rel="stylesheet" />
<link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ProcessDesignerControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css"))%>" rel="stylesheet" />
<link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ProcessDesignerControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css"))%>" rel="stylesheet" />

<script src="<%=ProcessDesignerControl.GetJscriptUrl("../Common/javascripts/jquery.min.js")%>"></script>
<script src="<%=ProcessDesignerControl.GetJscriptUrl("../Common/javascripts/kendo.all.min.js")%>"></script>
<script src="<%=ProcessDesignerControl.GetJscriptUrl("../Common/javascripts/cultures/kendo.culture." + PageUICulture + ".min.js")%>"></script>

<script src="<%=ProcessDesignerControl.GetJscriptUrl("../Common/javascripts/VariableScript.js")%>"></script>
<script src="../Common/JavaScripts/AutoLogoff.js"></script>
<script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>

<!DOCTYPE HTML>
<html>
<head id="Head1" runat="server">
    <title><%:PageTitle%></title>
</head>
<body style="padding-left:10px;padding-right:10px" onresize="javascript:HideEditMode();">
    
    <style>
    <!--
        html, body, form {
            height: 100%;
            width: 100%;
            margin:0;
            padding:0;
            overflow:hidden;
        }

        div, label, span
        {
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            box-sizing: border-box;
        }

        input.description{
            padding:0 2px 2px 2px;
            border-width:1px;
            border-style:solid;
            border-color:#666;
            font-family: 'Segoe UI', Tahoma, Helvetica, Arial, sans-serif;
            font-size: 12px;
        }

        [id^="MHS"]>a{
            text-decoration:none;
        }

        #cmbOperator_DropDownPlaceholder
        {
            -webkit-box-sizing: content-box;
            -moz-box-sizing: content-box;
            box-sizing:content-box;
        }

        .ComboBoxImage_SkeltaCombobox
        {
            vertical-align: middle;
            border-bottom: solid 1px #666;
            border-top: solid 1px #666;
            border-right: solid 1px #666;
            height: 21px !important;
            padding-right: 5px;
            background: #ffffff;
        }
        .ComboBoxItem_SkeltaCombobox,.ComboBoxItemHover_SkeltaCombobox,.ComboBoxInput_SkeltaCombobox,.ComboBoxInputHover_SkeltaCombobox
        {
            font-family: "Segoe UI", "Tahoma", "Helvetica", "Arial", "sans-serif";
            font-size: 12px;
            color: #666;
        }
        
        .k-block, .k-button, .k-textbox, .k-drag-clue, .k-touch-scrollbar, .k-window, .k-window-titleless .k-window-content, .k-window-action, .k-inline-block, .k-grid .k-filter-options, .k-grouping-header .k-group-indicator, .k-autocomplete, .k-multiselect, .k-combobox, .k-dropdown, .k-dropdown-wrap, .k-datepicker, .k-timepicker, .k-colorpicker, .k-datetimepicker, .k-numerictextbox, .k-picker-wrap, .k-numeric-wrap, .k-colorpicker.k-list-container, .k-calendar-container, .k-calendar td, .k-calendar .k-link, .k-treeview .k-in, .k-editor-inline, .k-tooltip, .k-tile, .k-slider-track, .k-slider-selection, .k-upload .k-dropdown-wrap .k-input, .k-picker-wrap .k-input, .k-numeric-wrap .k-input,
        .k-dropdown-wrap .k-select, .k-picker-wrap .k-select, .k-numeric-wrap .k-select, .k-datetimepicker .k-select + .k-select, .k-list-container.k-state-border-right, .k-colorpicker .k-selected-color
        {
            border-radius: 0px !important;
            -webkit-border-radius: 0px !important;
            -moz-border-radius: 0px !important;
        }

        .k-input,
        .k-datepicker,
        .k-numerictextbox, 
        .k-datetimepicker,
        .k-timepicker
        {
            padding: 0px !important;
            max-width: 100%;
        }

        .k-numerictextbox .k-link
        {
            height:10px;
            line-height:10px;
        }

        .k-picker-wrap .k-select 
        {
            padding-top:2px;
        }

        .k-picker-wrap,
        .k-numeric-wrap
        {
            height:inherit;
        }

        .k-state-selected, .k-state-selected:link, .k-state-selected:visited, .k-list > .k-state-selected, .k-list > .k-state-highlight, .k-panel > .k-state-selected, .k-ghost-splitbar-vertical, .k-ghost-splitbar-horizontal, .k-draghandle.k-state-selected:hover, .k-scheduler .k-scheduler-toolbar .k-state-selected, .k-scheduler .k-today.k-state-selected, .k-marquee-color
        {
            color: #fff;
            background-color: #999999 !important;
            border-color: #999999 !important;
        }

        .k-state-focused.k-state-selected, .k-list > .k-state-focused.k-state-selected, .k-listview > .k-state-focused.k-state-selected, td.k-state-focused.k-state-selected
        {
            -webkit-box-shadow: none !important;
            box-shadow: none !important;
        }

        .k-popup.k-list-container, .k-popup
        {
            border: 0 !important;
            border-radius: 0 !important;
        }
    -->
    </style>
     <script>

         se.ui.messageDialog.setGlobalOptions({
             localization: {
                 closeButtonCaption: "<%=ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                 okButtonCaption: "<%=ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
                 cancelButtonCaption: "<%=ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                 showDetailsCaption: "<%=ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                 hideDetailsCaption: "<%=ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
             }
         });

         function DisplayMessage(strMessage) {
             var strHdrMsg = tdheader.innerText;
            se.ui.messageDialog.showError(strHdrMsg, strMessage);
        }
         

</script>




    <form id="frmUpdateVariable" runat="server">
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager ID="radSc1" runat="server"></telerik:RadScriptManager>
        <link rel="stylesheet" type="text/css" href="<%=ProcessDesignerControl.GetThemeRelativeUrl("CommonUXControls/StyleSheet/se.ui.min.css")%>">
        <div>
            <table cellspacing=0 cellpadding=0 width=100% border=0 >
                <tr class="ListheaderCss">
                     <td class="fontheading">
                         <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                 <td width="100%" height="25"  id="tdheader" class="fontheading" runat="server" style="padding-left:5px;"></td>
                            </tr>
                        </table>        
                     </td>
                </tr>
                 <tr>
                     <td>
                         <table cellspacing="0" cellpadding="0" width="100%" border="0">
                             <tr>
                                 <td>
                                     <table width="98%" cellspacing="0" cellpadding="0" border="0">
                                         <tr>
                                             <td >
                                                 <div id="divMain" style="width: 100%; height: 480px; cursor: text; text-align: center;">
                                                     <table cellspacing="0" cellpadding="0" border="0" width="100%">
                                                         <tr>
                                                             <td>
                                                                 <div id="divheading" style="width:100%; height:40px;">
                                                                    <table width="100%" cellspacing=0 cellpadding=0 border=0>
                                                                        <tr>
                                                                            <td width="100%">
                                                                                <table width="100%" id="Table1" border="0" cellspacing="0" cellpadding="6" style="height:40px" >
                                                                                    <tr class="GridHeaderStyle">
                                                                                        <td style="width: 35%;padding-left:10px">
                                                                                            <span class="subtitle">
                                                                                                <%=ProcessDesignerControl.GlobalResourceSet.GetString("ConditionCondition")%>
                                                                                            </span>
                                                                                        </td>
                                                                                        <td style="width: 22%" class="subtitle">
                                                                                                <%=ProcessDesignerControl.GlobalResourceSet.GetString("ConditionOperator")%>
                                                                                        </td>
                                                                                        <td style="width: 33%" align="left">
                                                                                            <span class="subtitle">
                                                                                                <%=ProcessDesignerControl.GlobalResourceSet.GetString("ConditionValue")%>
                                                                                            </span>
                                                                                        </td>
                                                                                        <td style="width: 10%;">
                                                                                            <span class="subtitle">
                                                                                                <%=ProcessDesignerControl.GlobalResourceSet.GetString("ConditionActions")%>
                                                                                            </span>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table> 
                                                                            </td>        
                                                                        </tr> 
                                                                    </table>          
                                                                </div>
                                                                 <div id="divExpressionLayers" style="height:440px; width:100%; overflow-y:auto;" onscroll="javascript:HideEditMode();">
                                                                     <div id="divExpressionLayer1" style="width:100%;">
                                                                          <table width="100%" cellspacing=0 cellpadding=0 border=0   style="background-color:#f1f1f1">
                                                                             <tr>
                                                                                 <td width="100%">
                                                                                     <table width="100%" id="TableExpression1" border="0" cellspacing="0" cellpadding="6" style="height:40px">
                                                                                         <tr>
                                                                                             <td>
                                                                                                 <table width="100%" cellspacing="0" cellpadding="0" border="0" >
                                                                                                     <tr>
                                                                                                         <td style="width: 36%;padding-left:10px" class="description" >
                                                                                                             <div id="LHS1" style="display:grid; width: 130px;border-color:black">
                                                                                                                <%if (LHSAllowValue){ %>
                                                                                                                 <a class="GridHyperlinkStyle" id="A1" onmouseover="Javascript:alterLinkEnter(this,1,'LHS')"
                                                                                                                     onclick="Javascript:alterLinkEnter(this,1,'LHS')" href="#">
                                                                                                                     <%=ProcessDesignerControl.GlobalResourceSet.GetString("ConditionEnter")%>
                                                                                                                 </a>
                                                                                                                <%}else{ %>
                                                                                                                 <a class="GridHyperlinkStyle" id="link1" onmouseover="Javascript:alterLink(this,1,'LHS')"
                                                                                                                     onclick="Javascript:alterLink(this,1,'LHS')" href="#">
                                                                                                                     <%=ProcessDesignerControl.GlobalResourceSet.GetString("ConditionSelect")%>
                                                                                                                 </a>
                                                                                                                 <%} %>
                                                                                                             </div>
                                                                                                         </td>
                                                                                                         <td width="20%" class="description">
                                                                                                             <div id="MHS1" style="display: inline; width: 50px;">
                                                                                                                 &nbsp;</div>
                                                                                                         </td>
                                                                                                         <td width="33%" class="description">
                                                                                                             <div id="RHS1" style="display: inline; width: 130px;">
                                                                                                                 &nbsp;</div>
                                                                                                         </td>
                                                                                                         <td width="9%" class="description">
                                                                                                             <div id="DivObjectTree1" style="display: inline; width: 40px;">
                                                                                                                 &nbsp;</div>
                                                                                                         </td>
                                                                                                     </tr>
                                                                                                 </table>
                                                                                             </td>
                                                                                         </tr>
                                                                                     </table>
                                                                                 </td>
                                                                             </tr>
                                                                         </table>
                                                                     </div>
                                                                 </div>
                                                             </td>
                                                         </tr>
                                                     </table>
                                                 </div>
                                             </td>
                                         </tr>
                                     </table>
                                 </td>
                             </tr>
                             <tr class="description" >
                                <td colspan="5" style="height:5px;width:98%">
                                    <div class="lineCss"></div>
                                </td>
                             </tr>           
                         </table>
                     </td>
                 </tr>
                 <tr>
                     <td>
                         <table width="100%" cellpadding="0" cellspacing="0">
                             <tr>
                                 <td>
                                     <table width="99%" border="0" cellspacing="0" cellpadding="0" class="">
                                         <tr class="description">
                                             <td width="20%" valign="top" style="padding-left:10px">
                                                 <a href="#" id="errorLink" onclick="javascript:OpenDiv(1)" onmouseover="javascript:OpenDiv(1)"
                                                     class="ErrorHyperlinkStyle" style="display: none">
                                                     <%=ProcessDesignerControl.GlobalResourceSet.GetString("ExpErrorList")%></a>
                                             </td>
                                         </tr>
                                         <tr>
                                             <td width="65%" class="description" style="padding-left:10px">
                                                 <% if(IsReqdClearRecordIdOperator){%>
                                                 <img src="<%=ProcessDesignerControl.GetCommonRelativeUrl("images/icon-tips.gif")%>"  border="0">
                                                      <%=ProcessDesignerControl.GlobalResourceSet.GetString("UpdateVariableOperatorEqualAfterClearGUIDTips")%>
                                                 <%} %>
                                             </td>
                                             <td width="35%" height="25" style="padding-left:10px;text-align:right">                                              
                                                 <input type="button" class="inputsecondarybutton" id="btnCancel" name="btnCancel" value="<%=ProcessDesignerControl.GlobalResourceSet.GetString("DecisionCancel")%>"
                                                     onclick="window.close();" style="margin-right:10px;">
                                                    <input type="button" class="inputbutton" id="btnOk" name="btnOk" value="&nbsp;&nbsp;<%=ProcessDesignerControl.GlobalResourceSet.GetString("DecisionOk")%> &nbsp;&nbsp;"
                                                     onclick="javascript:ClickOK();">
                                                 &nbsp;<div id="ErrorsWindow">
                                                 </div>
                                             </td>
                                         </tr>
                                     </table>
                                 </td>
                             </tr>
                         </table>
                     </td>
                 </tr>
            </table>     
			    <input value="" class="description" id="cmbLHS_Input" name="cmbLHS_Input"  style="height:22px;width:215px;" onclick="ToggleTreeView()" onmouseover="javascript:ShowAlttext(this)" onmouseout="javascript:HideAlttext(this)" onmouseleave="javascript:HideAlttext(this)" ></input>
                <img alt="" id="cmbLHS_Image"  src="<%=ProcessDesignerControl.GetCommonRelativeUrl("Images/down-arrowLatest.gif")%>" onclick="ToggleTreeView()" style="padding-left:5px;"></img>
		        <div id="treeDiv" style="position:absolute; display: none; border: solid 1px; width:227px; background: white; height: 167px;" onmouseout="javascript:OntreedivLeave()";>
			                
			              <table cellpadding=0 cellspacing=0 width=100% class="tablebgcolor">
			                        <tr >
			                                <td align="right" style="width:100%">
			                                    <div id="MaxDiv" style="width:60px">
			                                        <table  cellpadding=0 cellspacing=0 width=100% border="0">
			                                            <tr>
			                                                <td align="left" width=50% id="Maximize" ><a href="#" onclick="Maximize(true,0)"><span style="font-family:verdana; font-size:7pt; text-decoration:none;" title="Maximize"><img id="Img1" hspace="1" src="<%=ProcessDesignerControl.GetCommonRelativeUrl("Images/icon-maximize.png")%>" border=0 align='absmiddle'></span></a></td>
			                                                <td align="left" width=50% id="Minimize" ><a href="#" onclick="Maximize(false,0)"><span style="font-family:verdana; font-size:7pt; text-decoration:none;" title="Minimize"><img  title="Minimize" id="Img2" hspace="1" src="<%=ProcessDesignerControl.GetCommonRelativeUrl("Images/icon-minimize.png")%>" border=0 align='absmiddle'></span></a></td>
			                                                <td align="left" width=50% id="Close" ><a href="#" onclick="ToggleTreeView()"><span style="font-family:verdana; font-size:7pt; text-decoration:none;" title="Close"><img id="Img3" hspace="1" src="<%=ProcessDesignerControl.GetCommonRelativeUrl("Images/icon-Close.png")%>" border=0 align='absmiddle'></span></a></td>
			                                            </tr>
			                                        </table>
			                                    </div>
			                                </td>
			                        </tr>
			                </table>  
			               	                     
                   
			                <telerik:RadTreeView
					        ID="RadTree1"
					        runat="server"
					        Height="150"
					        Width="227"				
					        AutoPostBack="True" 
					        Skin="AWTTreeView" ShowLineImages="false" EnableEmbeddedSkins="false"
					        OnClientNodeClicking="ProcessClientClick" 					        
					        ImagesBaseDir="<%$ ReplaceTemplateExpn:Expression/TreeView/Img/WindowsXP/%>"/>
		
		        </div>
			<div id="DivRadCmb" style="">
			   <telerik:RadComboBox   ID="cmbMHS" RenderMode="Classic" runat="server"  Skin="AWTCombobox"  EnableEmbeddedSkins="false" Sort="None" MarkFirstMatch="false" ShowToggleImage="true" Width="55px" Height="60px">
                 </telerik:RadComboBox>

                 <telerik:RadComboBox   ID="cmbOperator" RenderMode="Classic" runat="server"  Skin="AWTCombobox"  EnableEmbeddedSkins="false" Sort="None" MarkFirstMatch="false" ShowToggleImage="true" Width="80px" Height="60px"   OnClientSelectedIndexChanged="ProcessClientClickForCombo"  AutoPostBack="false">
                 </telerik:RadComboBox>
            </div>
            <div id="RHSTreeDiv" style="position:absolute; display: none; border: solid 1px; width:272px; background: white; height: 167px;" >
                            <table cellpadding=0 cellspacing=0 width=100%>
			                        <tr >
			                                <td align="right"  style="width:100%">
			                                    <div id="MaxDivRHS" style="width:60px">
			                                        <table  cellpadding=0 cellspacing=0 border="0" width=100%>
			                                            <tr>
			                                                <td align="left" width="50%" id="RHSMax"> <a href="#" onclick="Maximize(true,0)"><span style="font-family:verdana; font-size:7pt; text-decoration:none;" title="Maximize"><img title="Maximize" id="Img4" hspace="1" src="<%=ProcessDesignerControl.GetCommonRelativeUrl("Images/icon-maximize.png")%>" border=0 align='absmiddle'></span></a></td>
			                                                <td align="left" width="50%" id="RHSMin"> <a href="#" onclick="Maximize(false,0)"><span style="font-family:verdana; font-size:7pt; text-decoration:none;" title="Minimize"><img  title="Minimize" id="Img5" hspace="1" src="<%=ProcessDesignerControl.GetCommonRelativeUrl("Images/icon-minimize.png")%>" border=0 align='absmiddle'></span></a></td>
			                                                <td align="left" width="50%" id="RHSClose"> <a href="#" onclick="ToggleTreeView()"><span style="font-family:verdana; font-size:7pt; text-decoration:none;" title="Close"><img title="Close" id="Img6" hspace="1" src="<%=ProcessDesignerControl.GetCommonRelativeUrl("Images/icon-Close.png")%>" border=0 align='absmiddle'></span></a></td>
			                                            </tr>
			                                        </table>
			                                    </div>
			                                </td>
			                        </tr>
			                </table> 			                
                            <telerik:RadTreeView
					        ID="RadTree2"
					        runat="server"
					        Height="150"
					        Width="272"				
					        AutoPostBack="True" 
					        Skin="AWTTreeView" ShowLineImages="false" EnableEmbeddedSkins="false"
					        OnClientNodeClicking="ProcessClientClick" 					        
					        ImagesBaseDir="<%$ ReplaceTemplateExpn:Expression/TreeView/Img/WindowsXP/%>"/> 
            </div>
		    <input value="" class="description" id="txtLHS" name="txtLHS"  style="height:22px;width:260px;display:none;" maxlength=300 onchange="javascript:ProcessLHSClientEnter(this)" onmouseout="javascript:HideAlttext(this)">
            <input value="" class="description" id="txtRHS" name="txtRHS"  style="height:22px;width:250px;display:none;" maxlength=300 onmouseover="javascript:ShowAlttext(this)" onmouseout="javascript:HideAlttext(this)" onpaste="javascript:ChangeRHSMODE()" onkeyup="javascript:ChangeRHSMODE()" />
            <input value="" class="description" id="txtRHSNumber" name="txtRHSNumber" style="height:20px;width:250px;" onpaste="javascript:ChangeRHSMODE()" onkeyup="javascript:ChangeRHSMODE()" />
            <input value="" class="description" id="txtRHSDate" name="txtRHSDate" style="height:20px;width:250px;" onpaste="javascript:ChangeRHSMODE()" onkeyup="javascript:ChangeRHSMODE()" />
            <input value="" class="description" id="txtRHSTime" name="txtRHSTime" style="height:20px;width:250px;" onpaste="javascript:ChangeRHSMODE()" onkeyup="javascript:ChangeRHSMODE()" />
            <input value="" class="description" id="txtRHSDateTime" name="txtRHSDateTime" style="height:20px;width:250px;" onpaste="javascript:ChangeRHSMODE()" onkeyup="javascript:ChangeRHSMODE()" />
            <iframe id="IframeShimForBubble" scrolling="no"	frameborder="no"	style="position:absolute; top:0px; left:0px; display:none;"></iframe>
            <cc1:ajaxpagecontrol id="AjaxPageControl1" runat="server" style="Z-INDEX: 104; LEFT: 440px; POSITION: absolute; TOP: 88px"></cc1:ajaxpagecontrol>
            <input id="hiddivNumber" type="hidden" name="hiddivNumber">
			<input id="hidprevdivnumber" type="hidden" name="hidprevdivnumber">
			<input id=hidLHStype type=hidden name="hidLHStype">
			<input id="HidRow" type=hidden name="HidRow">	
			<input id="HidX" type=hidden name="HidX">
			<input id="HidY" type=hidden name="HidY">	
			<input id="HidXRHS" type=hidden name="HidXRHS">
			<input id="HidYRHS" type=hidden name="HidYRHS">
			<input id="OPCdata" type=hidden name="OPCdata" runat="server" />
            <input id="OPCConInfo" type=hidden name="OPCConInfo" runat="server" />
            
	    <!--div id="ErrorsWindow" style="border:1px solid #256194"/-->	
	    <div id="bubbleWindow" style="background-color:#ffffe1;border:1px solid black; CURSOR: text; font-family: Verdana, Arial, Helvetica, sans-serif;	font-size: 10px; TEXT-ALIGN:left;">
	    </div>
    </div>
    <input type="hidden" id="HiddenJsString" name="HiddenJsString" value="<%=Server.HtmlEncode(_updatedVariableRowString)%>"/> 
<script>
    var radTreeLHSClientId = "<%= RadTree1.ClientID %>",
        radTreeRHSClientId = "<%= RadTree2.ClientID %>",
        MSG_EnterProperValues = "<%=ProcessDesignerControl.GlobalResourceSet.GetString("UPD_VAR_MSG_EnterProperValues")%>",
        MSG_OprUsedWithXmlVars = "<%=ProcessDesignerControl.GlobalResourceSet.GetString("UPD_VAR_MSG_OprUsedWithXmlVars")%>",
        CAP_EnterValue = "<%=ProcessDesignerControl.GlobalResourceSet.GetString("UPD_VAR_CAP_EnterValue")%>",
        CAP_Select = "<%=ProcessDesignerControl.GlobalResourceSet.GetString("UPD_VAR_CAP_Select")%>",
        PLACEHOLDER_MSG_NUMBER = "<%=ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("UPD_VAR_WATERMARK_NUMBER")%>",
        CAP_INCREASE_VALUE = "<%=ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("KENDO_IncreaseValue")%>",
        CAP_DECREASE_VALUE= "<%=ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("KENDO_DecreaseValue")%>",
        CAL_TOOLTIP_DateButton = "<%=ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("CAL_TOOLTIP_DateButton")%>",
        CAL_TOOLTIP_TimeButton = "<%=ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("CAL_TOOLTIP_TimeButton")%>",
        UI_CULTURE = "<%=PageUICulture%>",
        UI_CULTURE_DATE_FORMAT = "<%=PageUICultureDateFormat%>",
        UI_CULTURE_TIME_LONG_FORMAT = "<%=PageUICultureTimeLongFormat%>",
        UI_CULTURE_TIME_SHORT_FORMAT = "<%=PageUICultureTimeShortFormat%>",
        INVARIANT_CULTURE_DATE_FORMAT = "<%=InvariantCultureDateFormat%>",
        INVARIANT_CULTURE_TIME_LONG_FORMAT = "<%=InvariantCultureTimeLongFormat%>",
        INVARIANT_CULTURE_TIME_SHORT_FORMAT = "<%=InvariantCultureTimeShortFormat%>";


    cmbMHSName = "<%= cmbMHS.ClientID %>";
    cmbOPRName = "<%= cmbOperator.ClientID %>";
    controlName ="<%= ProcessDesignerControl.ID %>";
    objectTreeImg = "<%=ProcessDesignerControl.GetTemplateRelativeUrl("../Expression/Images/Workflow9.gif")%>";
    delteRowImg = "<%=ProcessDesignerControl.GetTemplateRelativeUrl("../Expression/Images/delete2.gif")%>";
    ConditionDeleteLocal = "<%=ProcessDesignerControl.GlobalResourceSet.GetString("Delete")%>";
    ConditionObjTreeLocal = "<%=ProcessDesignerControl.GlobalResourceSet.GetString("Tree View")%>";
    expbuilderURl="<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(expbuilderURl, false)%>";
    conditionSelectLocal = "<%=ProcessDesignerControl.GlobalResourceSet.GetString("ConditionSelect")%>";
    conditionEnterValueLocal = "<%=ProcessDesignerControl.GlobalResourceSet.GetString("ConditionEnterValue")%>";
    MHSComboInstance = <%= cmbOperator.ClientID %>;
    lhsAllowValue = "<%=LHSAllowValue %>";
    var bellybarTitle="<%=ProcessDesignerControl.GlobalResourceSet.GetString("Update Variable")%>";

    

    //Logic
    //1.check valid form
    //2.Check whether RHS is entered
    //3.Only if 1 is true,check for no repetitions
    //4.All conditions satisfied->Update to variable final Array

    function ClickOK()
    {
        FinalconditionalArray=new Array();
        FinalUpdatedVariableArray = new Array();
 
        TempconditionalArray=new Array();
        TempUpdatedVariableArray = new Array();
 
        if(!ValidForm())
        {
         
        }
        else  
        {
            var j=1; 
        
            for(var i=0; i<InitialUpdatedVariableArray.length;i++)
            {
                var remRows = InitialUpdatedVariableArray[i];
            
                var validRow = remRows.split("~");
            
                if(validRow[1]=="S")
                {
                    if(eval("window.Row"+validRow[0]+".RHSMode=='Expression'"))
                    {
                        exp=new Expression();
                        exp= eval("window.Row"+validRow[0]+".ColumnExpression");
                        eval("window.Row"+validRow[0]+".RHSColumn");
                    }  
                     
                    TempUpdatedVariableArray[TempUpdatedVariableArray.length]=eval("window.Row"+validRow[0]);
                  
                    j=0;
                }   
            } 
        
             
            var status = ValidateTempArray(TempUpdatedVariableArray);
            j=1;
        
            if(status != false)
            {
                for(var i=0; i<InitialUpdatedVariableArray.length;i++)
                {
                    var remRows = InitialUpdatedVariableArray[i];
            
                    var validRow = remRows.split("~");
            
                    if(validRow[1]=="S")
                    {
                        if(eval("window.Row"+validRow[0]+".RHSMode=='Expression'"))
                        {
                            exp=new Expression();
                            exp= eval("window.Row"+validRow[0]+".ColumnExpression");
                            eval("window.Row"+validRow[0]+".RHSColumn=stringify(exp)");
                        }  
                     
                        FinalUpdatedVariableArray[FinalUpdatedVariableArray.length]=eval("window.Row"+validRow[0]);
                        //FinalUpdatedVariableArray[validRow[0]- 1]=eval("window.Row"+validRow[0]);
                
                        j=0;
                    }   
                } 
            }  
        
        
            if(status != false)
            {
                var stringified = stringify(FinalUpdatedVariableArray);
                CallServerSideMethod(null, 'UpdateVariables',"DataTableCondition",CallbackSaveProperty,'table',stringified);  
            }
        } 
   
       
    }


    function ValidateTempArray(TempUpdatedVariableArray)
    {
        for(var i = 0; i<TempUpdatedVariableArray.length;i++)
        {
            if(TempUpdatedVariableArray[i].RHSColumn != "" || (eval(TempUpdatedVariableArray[i].ColumnExpression).DisplayExpressionString != ""))
            {
                var  rep=1;
                for(var j = 0 ; j<TempUpdatedVariableArray.length ; j++)
                {
                    if(TempUpdatedVariableArray[i] != null && TempUpdatedVariableArray[j] != null)
                        
                    {   if(TempUpdatedVariableArray[i].LHSColumn == TempUpdatedVariableArray[j].LHSColumn)
                    {
                        if(rep > 1)
                        {
                            // alert(TempUpdatedVariableArray[i].LHSColumn + " has been repeated");
                            se.ui.messageDialog.showError(tdheader.innerText, "<%=ProcessDesignerControl.GlobalResourceSet.GetString("PD_Form_Parameters_Update_Var_repeate1")%>"+" ("+TempUpdatedVariableArray[i].LHSColumn +"). "+"<%=ProcessDesignerControl.GlobalResourceSet.GetString("PD_Form_Parameters_Update_Var_repeate2")%>");
                            return false;
                        }
                        rep ++;
                    }
                    }
                        
                }
            
            }
            else
            {
                //alert(TempUpdatedVariableArray[i].LHSColumn + " has not been updated");
                se.ui.messageDialog.showError(tdheader.innerText, TempUpdatedVariableArray[i].LHSColumn + " " + "<%=ProcessDesignerControl.GlobalResourceSet.GetString("PD_Form_Parameters_Update_Var_update")%>");
                return false;
            }
        }
         
    } 


    function CallbackSaveProperty(context, result, response)
    {
        var error="";
        if((result!=null)&&(result!=""))
        {
            error=result;
        }
        else
        {
            if(response.result!=null)    {
                error=response.Window.h.responseText;
                error = error.substring(2,error.length-2);
            }
        }
  
        if(error!=null)
        {
            if(navigator.userAgent.indexOf("MSIE")>-1)
            {
                temp=new Array();
                error=error.substring(0,length-1);
                temp=error;
                if ((temp[0] != null) && (temp[0] != "") && (temp[0] != "[")) 
                {
                    expCompResult = temp[0];
                    compiledCode = temp[1];
                    errLnkObj.style.display="block";
                    errLnkObj.style.position="absolute";
                    OpenDiv(1);               
                }
                else
                {
                    var innerHTMl ="";
                    innerHTMl = "<table width=100% cellspacing=2 cellpadding=2 align=center></table>";
                    var firstVariable=1;
                    //                window.setTimeout('window.opener.refreshselectedaction()',100);
                    //                window.opener.parent._skProcessDesigner.RefreshProperties();
                    //                window.setTimeout('window.close()',100);

                    try { 
    
                        window.setTimeout('window.opener.refreshselectedaction()',100);
                        window.opener.parent._skProcessDesigner.RefreshProperties();
                        window.setTimeout('window.close()',300);
                        window.close();
                    }
                    catch(err)
                    {}
                }
            }   
            else
            {
                temp=new Array();
                error=error.substring(0,length-1);
                temp=error;
                if ((temp[0] != null) && (temp[0] != "") && (temp[0] != "["))
                {
                    expCompResult = temp[0];
                    compiledCode = temp[1];//Stops here
                    errLnkObj.style.display="block";
                    errLnkObj.style.position="absolute";
                    OpenDiv(1);               
                }
                else
                {
                    var innerHTMl ="";
                    innerHTMl = "<table width=100% cellspacing=2 cellpadding=2 align=center></table>";
                    var firstVariable=1;
                    window.setTimeout('window.opener.refreshselectedaction()',100);
                    window.opener.parent._skProcessDesigner.RefreshProperties();
                    window.setTimeout('window.close()',100);
                }       
        
            }       
            
        }
    }

    function OntreedivLeave()
    {
    
    }

    function ValidForm()
    {
        var isValid = true;
    
        var errCount=0;
    
        errCount=PlaceLinkforText();
	
        if(errCount>0)
            isValid =false;
	
        if(isValid)
        {    
            errCount = ValidateFields();    
    	
            if(errCount>0)
                isValid =false;
        }
	
        return isValid;
    }

    function HideCombos()
    {
        hideRHSInputControl();

        cmbLHS_Image.style.display = "none";
        inputLHSObj.style.display = "none";

        //HideTreeView();
        document.getElementById("treeDiv").style.display="none";
        document.getElementById("RHSTreeDiv").style.display="none";
        
        imageLHSObj.style.display="none";

        if(document.getElementById(cmbOPRName+"Div")!= null)
        {
            document.getElementById(cmbOPRName+"Div").style.display="none"; 
        }
        else
        {
            document.getElementById(cmbOPRName+"_wrapper").style.display="none"; 
        }

        if(MHSComboInstance!=null)
        {
            MHSComboInstance.HideDropDown();
        }
    }

</script>
 </form>
</body>
</html>

