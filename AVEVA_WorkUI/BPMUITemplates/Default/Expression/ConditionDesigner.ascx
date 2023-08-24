<%@ Control language="c#" AutoEventWireup="false" inherits="Workflow.NET.Web.Designer.ExpressionBuilder.ConditionalScript" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
<link rel="stylesheet" type="text/css" href="<%:conditionalDesigner.GetThemeRelativeUrl("Common/StyleSheet/Global.css")%>">
<script src="<%:conditionalDesigner.GetJscriptUrl("javascript/conditional.js")%>"></script>
</telerik:RadScriptBlock>
<script src="../Common/JavaScripts/jquery.min.js"></script>
<script src="../Common/JavaScripts/AutoLogoff.js"></script>
  <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
<telerik:RadScriptBlock ID="RadScriptBlock2" runat="server">
<script type="text/javascript">
/*<![CDATA[*/
     var calendar, popup, calendarContainer, activeInput, isVisible;
     var BellybarTitle = "<%:conditionalDesigner.GlobalResourceSet.GetString("ConditionConditions")%>";
    
	function ToggleCalendar(e, inputId)
	{
	    
		ShowCalendar(inputId);
		e.cancelBubble = true;
		
	}
	    
    function ShowCalendar(inputId)
    {        
        if (!calendar)
            calendar = $find('<%:Radcalendar1.ClientID%>');
        
        if (!popup)
            popup = new Telerik.Web.UI.Calendar.Popup();
            
        if (!calendarContainer)
            calendarContainer = document.getElementById("calendarContainer");
            
        if (activeInput
			&& activeInput.id == inputId
			&& popup.IsVisible())
		{
			popup.Hide();
			
			
		}			
		else
		{        
			activeInput = document.getElementById(inputId);
			var x = PositionX(activeInput);
			var y = PositionY(activeInput) + activeInput.offsetHeight;
	        
	        var n=0;
	        n=document.getElementById("divMain").scrollTop ;
	        var divHeight = "273px";//document.getElementById("calendarContainer").style.height;
	        divHeight = divHeight.substring(0,divHeight.length-2);
	        var TempHeight=divHeight;
	        divHeight = divHeight-n;
	        if((document.body.offsetHeight - y)<parseInt(TempHeight))
	        {
	                var newTop = parseInt(y) - parseInt(divHeight); 
	                popup.Show(x, newTop, calendarContainer);       
	        }
	        else
	        { 
			        popup.Show(x, y, calendarContainer);
			}
			//popup.Show(x, y, calendarContainer);
			
		}
    }
    
    function ChangeInput(sender, eventArgs)
    {

        var dateArray = eventArgs.get_renderDay().get_date();       
        var dateString = dateArray[1] + "/" + dateArray[2] + "/" + dateArray[0];
        activeInput.value = dateString;

        var divNumberVal = document.getElementById("hiddivNumber").value;
        var currentRow = parseInt(divNumberVal);

        if (isNaN(currentRow)) {
            return;
        }

        eval("window.Row" + currentRow + ".RHSColumn.Actualtext=dateString");
        ChangeRHSMODE();
        if (popup.IsVisible())
		{
			popup.Hide();
			
		}
    }
    
    function PositionX(inputElement) 
    {
	    var offsetLeft = 0;
	    if(inputElement!=null)
	    {
	        if (inputElement.offsetParent)
	        {
	            while (inputElement.offsetParent)
	            {
		            offsetLeft += inputElement.offsetLeft;
		            inputElement = inputElement.offsetParent;
	            }
	        }
	        else if (inputElement.x)
	        {
		        offsetLeft += inputElement.x;
	        }
	    }
	    return offsetLeft;
    }
    function PositionY(inputElement) 
    {
	    var offsetTop = 0;
	    if(inputElement!=null)
	    {
	        if (inputElement.offsetParent)
	        {
		        while (inputElement.offsetParent)
		        {
		            offsetTop += inputElement.offsetTop;
		            inputElement = inputElement.offsetParent;
		        }
	        }
	        else if (inputElement.y)
	        {
		        offsetTop += inputElement.y;
	        }
	    }
	    return offsetTop;
    }

    /*]]>*/
</script>
    </telerik:RadScriptBlock>


<telerik:RadScriptBlock ID="RadScriptBlock3" runat="server">

<link rel="stylesheet" type="text/css" href="<%:conditionalDesigner.GetThemeRelativeUrl("CommonUXControls/StyleSheet/se.ui.min.css")%>">
  <link rel="stylesheet" type="text/css" href="<%:conditionalDesigner.GetThemeRelativeUrl("CommonUXControls/StyleSheet/se.ui.min.css")%>">
     <link rel="stylesheet" type="text/css" href="<%:conditionalDesigner.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTCalendar/Calendar.AWTCalendar.css")%>">
    <link rel="stylesheet" type="text/css" href="<%:conditionalDesigner.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTCalendar/Calendar.css")%>">
    <link rel="stylesheet" type="text/css" href="<%:conditionalDesigner.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css")%>">
    <link rel="stylesheet" type="text/css" href="<%:conditionalDesigner.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css")%>">
<link rel="stylesheet" type="text/css" href="<%:conditionalDesigner.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTTreeView/TreeView.AWTTreeView.css")%>">
    </telerik:RadScriptBlock>
<table style="width:100%;border:0px solid;"  >
           <tr>
                 <td class="">
                     <table style="width:100%;border:0px solid;">
                        <tr class="ListHeaderCss">
                              <td style="width:100%;text-align:left;" id="Td1" class="fontHeading">&nbsp;
                                  <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
                                      <span> <%:conditionalDesigner.GlobalResourceSet.GetString("ConditionConditions")%></span>
                                  </telerik:RadCodeBlock>
                              </td>
                       </tr>
                    </table>        
                </td>
            </tr>
              <tr>
                <td style="text-align:center;">
                    <table style="width:100%;border:0px solid;border-collapse:collapse;">
                         
                        <tr>
                            <td style="height:100%;">
                                <table style="width:100%;border:0px solid;">
                                <tr>
                                <td style="text-align:left;">
                                 <div id="divMain" style="Overflow: auto;width:100%;height:550px;">
                                    <table cellspacing=0 cellpadding=0 border=0 width=100%>
                                        <tr>
                                            <td>
                                                <div id="divheading" style="width:100%; height:40px;">
                                                     <table width="100%" cellspacing=0 cellpadding=0 border=0>
                                                            <tr>
                                                                <td width="100%">
                                                                    <table width="100%" id="Table1" border="0" cellspacing="0" cellpadding="6" style="height:40px" >
                                                                            <tr class="GridHeaderStyle">
                                                                                <td style="width:8%;padding-left:6px" >
                                                                                    <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
                                                                                    <span class="subtitle"><%=conditionalDesigner.GlobalResourceSet.GetString("ConditionEdit")%></span>
                                                                                        </telerik:RadCodeBlock>
                                                                                </td>
                                                                                <td style="width:25%;text-align:left;padding-left:55px;">
                                                                                    <telerik:RadCodeBlock ID="RadCodeBlock3" runat="server">
                                                                                    <span class="subtitle"><%=conditionalDesigner.GlobalResourceSet.GetString("ConditionCondition")%></span>
                                                                                        </telerik:RadCodeBlock>
                                                                                </td>
                                                                                <td style="width:19%;text-align:left;padding-left:15px;" >
                                                                                    <telerik:RadCodeBlock ID="RadCodeBlock4" runat="server">
                                                                                    <span class="subtitle"><%=conditionalDesigner.GlobalResourceSet.GetString("ConditionOperator")%></span>
                                                                                        </telerik:RadCodeBlock>
                                                                                </td>
                                                                                <td style="width:34%;text-align:left" >
                                                                                    <telerik:RadCodeBlock ID="RadCodeBlock5" runat="server">
                                                                                    <span class="subtitle"><%=conditionalDesigner.GlobalResourceSet.GetString("ConditionValue")%></span>
                                                                                        </telerik:RadCodeBlock>
                                                                                </td>
                                                                                <td style="width:14%;padding-left:30px" >
                                                                                    <telerik:RadCodeBlock ID="RadCodeBlock6" runat="server">
                                                                                    <span class="subtitle"><%=conditionalDesigner.GlobalResourceSet.GetString("ConditionActions")%></span> 
                                                                                        </telerik:RadCodeBlock>
                                                                                </td>
                                                                            </tr>                                                        
                                                                    </table> 
                                                                </td>        
                                                            </tr> 
                                                    </table> 
                                                    </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div id="divExpressionLayers">
                                                    <div id="divExpressionLayer1" style="width:100%;">
                                                        <table width="100%" id="Table1" border="0" cellspacing="0" cellpadding="0" style="height:40px" >                                                                
                                                        
                                                            <tr>
                                                                <td width="100%" colspan="5">
                                                                    <table width="100%" id="TableExpression1" border=0 cellspacing=0 cellpadding=0 style="background-color:#f1f1f1">                                                                        
                                                                        <tr>
                                                                            <td colspan=4>
                                                                                 <table width=100% cellspacing=0 cellpadding=0 border=0 style="height:40px">                                                                                   
                                                                                    <tr class="description">
                                                                                          <td style="width:5%;padding-left:10px" >
                                                                                          <div class="description" id="divlnkmenu1" style="DISPLAY: inline;width:10px">&nbsp;</DIV>
                                                                                          </td>
                                                                                          <td width=5%>
                                                                                          <div id="divlnkOPR1" style="DISPLAY: inline;width:30px">&nbsp;</DIV>
                                                                                          </td>
                                                                                          <td width=1%>
                                                                                          <div id="divBrac1" style="width:30px;text-align:left">&nbsp;</DIV>
                                                                                          </td>
                                                                                          <td width=20%>
                                                                                          <div id="LHS1" style="padding-left:20;width:170px;text-align:left">
                                                                                              <telerik:RadCodeBlock ID="RadCodeBlock7" runat="server">
                                                                                              <A class="GridHyperlinkStyle" id="link1" onmouseover="Javascript:alterLink(this,1,1,event,'LHS')"  onclick="Javascript:alterLink(this,1,1,event,'LHS')" href="#"><%=conditionalDesigner.GlobalResourceSet.GetString("ConditionSelect")%></A>
                                                                                                  </telerik:RadCodeBlock>

                                                                                          </div>
                                                                                          </td>
                                                                                          <td width=17%>
                                                                                          <div id= "MHS1" style="padding-left:0px;width:140px;text-align:left"></div>
                                                                                          </td>
                                                                                          <td width=33%>
                                                                                          <div id="RHS1" style="padding-left:5px;width:170px;text-align:left">&nbsp;</div>
                                                                                          </td>
                                                                                          <td width=1%>
                                                                                          <div id="divRBrac1" style="width:30px;text-align:left">&nbsp;</DIV>
                                                                                          </td>
                                                                                          <td width=10%>
                                                                                          <div id="DivDelImage1" style="width:40px;text-align:left;">&nbsp;</div>
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
                                    <td colspan="5" style="height:15px">
                                        <div class="lineCss"></div>
                                    </td>
                                    </tr>
                    </table>                
                 </td>        
              </tr>    
                <tr>
                    <td>
                        <table style="width:100%">
                             <tr>
                                 <td>
                                     <table style="width:100%;border:0px solid;"> 
                                        <tr>
                                              <td style="width:20%;vertical-align:top;" class="description">
                                                  <telerik:RadCodeBlock ID="RadCodeBlock8" runat="server">
                                                  <a href="#" id="errorLink" Onclick="javascript:OpenDiv(1)" onMouseOver="javascript:OpenDiv(1)" class="ErrorHyperlinkStyle" style="visibility:hidden"><%=conditionalDesigner.GlobalResourceSet.GetString("ExpErrorList")%></a>
                                                      </telerik:RadCodeBlock>

                                              </td>
                                               <td style="width:80%;text-align:right;height:25px;">  
                                                   <telerik:RadCodeBlock ID="RadCodeBlock9" runat="server">
                                                    <input type="button" class="inputsecondarybutton" id="btnCancel" name="btnCancel" value="<%=conditionalDesigner.GlobalResourceSet.GetString("DecisionCancel")%>" onClick="window.close();">
                                                     		<input type="button" class="inputbutton" id="btnOk" name="btnOk" value="&nbsp;&nbsp;<%=conditionalDesigner.GlobalResourceSet.GetString("DecisionOk")%> &nbsp;&nbsp;" onClick="javascript:ClickOK();">
                                                       </telerik:RadCodeBlock>
                                                           
                                                     <div id="ErrorsWindow" class="tdbg"></div>
                                              </td>
                                        </tr>
                                    </table>        
                                </td>
                            </tr>                       
                        </table>      
                    </td>  
                 </tr>
            </table>     
            <div id="cmbLHS" style="visibility:hidden">
			    <input value="" class="inputselect" id="cmbLHS_Input" name="cmbLHS_Input"  style="width:201px;" onclick="ToggleTreeView()" onmouseover="javascript:ShowAlttext(this)" onmouseout="javascript:HideAlttext(this)" onmouseleave="javascript:HideAlttext(this)" ></input><img alt="" id="cmbLHS_Image" style="visibility:hidden"></img>
		        <div id="treeDiv" style="position:absolute; visibility: hidden; border: solid 1px; width:225px; background: white; height:174px;" onmouseout="javascript:OntreedivLeave()";>
			        
			        
			        <table cellpadding=0 cellspacing=0 width=100% class="tablebgcolor">
			                        <tr >
			                                <td align="right" style="width:100%">
			                                    <div id="MaxDiv" style="width:60px">
			                                        <table  cellpadding=0 cellspacing=0 width=100% border="0">
			                                            <tr>
			                                                <td align="left" width=50% id="Maximize" >
                                                                <telerik:RadCodeBlock ID="RadCodeBlock10" runat="server">
                                                                <a href="#" onclick="Maximize(true,0)"><span style="font-family:verdana; font-size:7pt; text-decoration:none;" title="Maximize"><img id="Img1" hspace="1" src="<%:conditionalDesigner.GetCommonRelativeUrl("Images/icon-maximize.png")%>" border=0 align='absmiddle'></span></a>
                                                                </telerik:RadCodeBlock>
			                                                </td>
			                                                <td align="left" width=50% id="Minimize" >
                                                                <telerik:RadCodeBlock ID="RadCodeBlock11" runat="server">
                                                                <a href="#" onclick="Maximize(false,0)"><span style="font-family:verdana; font-size:7pt; text-decoration:none;" title="Minimize"><img  title="Minimize" id="Img2" hspace="1" src="<%:conditionalDesigner.GetCommonRelativeUrl("Images/icon-minimize.png")%>" border=0 align='absmiddle'></span></a>
                                                                    </telerik:RadCodeBlock>
                                                                    </td>
			                                                <td align="left" width=50% id="Close" >
                                                                <telerik:RadCodeBlock ID="RadCodeBlock12" runat="server">
                                                                <a href="#" onclick="ToggleTreeView()"><span style="font-family:verdana; font-size:7pt; text-decoration:none;" title="Close"><img id="Img3" hspace="1" src="<%:conditionalDesigner.GetCommonRelativeUrl("Images/icon-Close.png")%>" border=0 align='absmiddle'></span></a>
                                                                    </telerik:RadCodeBlock>
                                                                    </td>
			                                            </tr>
			                                        </table>
			                                    </div>
			                                </td>
			                        </tr>
			                </table>  
                    <div id="RadTreeDiv" style="height:150px;width:227px;overflow:auto">			                     
                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" Height="100%" Width="100%">

                        <telerik:RadTreeView
					        ID="RadTree1"
					        runat="server"
					        Height="100%"
					        Width="100%"				
					        AutoPostBack="true" style="overflow:visible" RenderMode="Classic"
					        Skin="AWTTreeView" ShowLineImages="false" EnableEmbeddedSkins="false"
					        OnClientNodeClicking="ProcessClientClick" 					        
					        ImagesBaseDir="<%$ ReplaceTemplateExpn:Expression/TreeView/Img/WindowsXP/%>" />  

                    
			        </telerik:RadAjaxPanel>
			        </div>
		        </div>
		   </div>
		       
			<div id="DivRadCmb" style="visibility:hidden">
			<telerik:RadComboBox   ID="cmbMHS" EnableLoadOnDemand="false" RenderMode="Classic" runat="server"  Skin="AWTCombobox"  EnableEmbeddedSkins="false" Sort="None" MarkFirstMatch="false"  ShowToggleImage="true" Width="145px" Height="80px" OnClientDropDownClosing="HandleClose" OnClientSelectedIndexChanging="HandleChangeMHS" >
                                  </telerik:RadComboBox>
            
                             
                <telerik:RadComboBox   ID="cmbOperator" EnableLoadOnDemand="true" RenderMode="Classic" runat="server"  Skin="AWTCombobox"  EnableEmbeddedSkins="false" Sort="None" MarkFirstMatch="false" ShowToggleImage="true" Width="50px" Height="40px" OnClientSelectedIndexChanging="HandleChangeOperator">
                                  </telerik:RadComboBox>
			
                 <telerik:RadComboBox   ID="cmbBoolean" EnableLoadOnDemand="true" RenderMode="Classic" runat="server"  Skin="AWTCombobox"  EnableEmbeddedSkins="false" Sort="None" MarkFirstMatch="false" ShowToggleImage="true" Width="80px" Height="40px" OnClientSelectedIndexChanging="HandleChangeBoolean" style="width:100px;height:auto;">
                                  </telerik:RadComboBox>
            
            </div>
            <input value="" class="inputselect" id="txtRHS" name="txtRHS"  maxlength=50 onmouseenter="javascript:ShowAlttext(this)" onkeydown="javascript:HideAlttext(this)" onclick="javascript:HideAlttext(this)" onmousedown="javascript:HideAlttext(this)" onmouseleave="javascript:HideAlttext(this)" onmouseout="javascript:HideAlttext(this)"   style="width:211px;display:none;" onpaste"javascript:ChangeRHSMODE()" onkeyup="javascript:ChangeRHSMODE()"/>
<telerik:RadCodeBlock ID="RadCodeBlock13" runat="server">
<A tabindex="5" href="#"><img alt="" id="CalIMGRHS"  name="CalIMGRHS" border=0 onclick="return ToggleCalendar(event, 'txtRHS');"  src="<%:conditionalDesigner.GetThemeRelativeUrl("Images/Calendar.gif")%>" style="display:none;padding-left:5px;padding-top:5px"></img></A>
    </telerik:RadCodeBlock>
            <iframe id="IframeShimForBubble" scrolling="no"	frameborder="no"	style="position:absolute; top:0px; left:0px; display:none;"></iframe>
            <input id="hiddivNumber" type="hidden" name="hiddivNumber">
			<input id="hidprevdivnumber" type="hidden" name="hidprevdivnumber">
			<input id=hidLHStype type=hidden name=hidLHStype>
			<input id="HidRow" type=hidden name="HidRow">
			<input id="HidX" type=hidden name="HidX">
			<input id="HidY" type=hidden name="HidY">
			
            <div id="MenuDiv" onmouseleave="menuOnMouseOut()" style="display:none" >
            
			<table summary="menu root group" class="tdbg" cellpadding="0" cellspacing="0" style="width:0px;height:0px;">
	        <tr>
		        <td><table id="Menu1_0" cellpadding="0" cellspacing="0" summary="menu root group" >
			        <tr>
				        <td align="left" style="width:5px;">&#160;</td>
				        <td style="white-space:nowrap;">
                            <telerik:RadCodeBlock ID="RadCodeBlock14" runat="server">
                            <a href="#" onclick="AddBrace('A(')" class="description"  onmouseover="ChangemenuItemClass('Menu1_0')"><span class="textlinkbluenormal"><%=conditionalDesigner.GlobalResourceSet.GetString("ConditionAddBrac")%> (&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a>
                                </telerik:RadCodeBlock>
                                </td>
				        <td align="right" style="width:5px;">&#160;</td>
			        </tr>
		        </table>
		        </td>
	        </tr>
	        <tr>
		        <td><table id="Menu1_1" cellpadding="0" cellspacing="0" summary="menu root group">
			        <tr>
				        <td align="left" style="width:5px;">&#160;</td>
				        <td style="white-space:nowrap;">
                            <telerik:RadCodeBlock ID="RadCodeBlock15" runat="server">
                            <a href="#" onclick="AddBrace('A)')"  onmouseover="ChangemenuItemClass('Menu1_1')"><span class="textlinkbluenormal"><%=conditionalDesigner.GlobalResourceSet.GetString("ConditionAddBrac")%> )&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a>
                                </telerik:RadCodeBlock>
                                </td>
				        <td align="right" style="width:5px;">&#160;</td>
			        </tr>
		        </table>
		        </td>
	        </tr>
	        <tr>
		        <td><table id="Menu1_2" cellpadding="0" cellspacing="0" summary="menu root group">
			        <tr>
				        <td align="left" style="width:5px;">&#160;</td> 
				        <td style="white-space:nowrap;">
                            <telerik:RadCodeBlock ID="RadCodeBlock16" runat="server">
                            <a href="#" onclick="AddBrace('R(')"  onmouseover="ChangemenuItemClass('Menu1_2')"><span class="textlinkbluenormal"><%=conditionalDesigner.GlobalResourceSet.GetString("ConditionRemoveBrac")%> (&nbsp;&nbsp;</span></a>
                                </telerik:RadCodeBlock>
				        </td>
				        <td align="right" style="width:5px;">&#160;</td>
			        </tr>
		        </table>
		        </td>
	        </tr>
	        <tr>
		        <td><table id="Menu1_3" cellpadding="0" cellspacing="0" summary="menu root group">
			        <tr>
				        <td align="left" style="width:5px;">&#160;</td>
				        <td style="white-space:nowrap;">
                            <telerik:RadCodeBlock ID="RadCodeBlock17" runat="server">
                            <a href="#" onclick="AddBrace('R)')" onmouseover="ChangemenuItemClass('Menu1_3')"><span class="textlinkbluenormal"><%=conditionalDesigner.GlobalResourceSet.GetString("ConditionRemoveBrac")%> )&nbsp;&nbsp;</span></a>
                                </telerik:RadCodeBlock>
                                </td>
				        <td align="right" style="width:5px;">&#160;</td>
			        </tr>
		        </table>
		        </td>
	        </tr>
        </table>
	</div> 
	
	<!--div id="ErrorsWindow" style="border:1px solid #256194"/-->	
	 
	<div id="calendarContainer" style="DISPLAY:none;" >

        <telerik:RadCalendar ID="Radcalendar1" runat="server" EnableMultiSelect="false"  EnableEmbeddedSkins="false" Skin="AWTCalendar" Width="200px" ClientEvents-OnDateSelected="ChangeInput" >
     </telerik:RadCalendar>
              
            </div>
            <div id="bubbleWindow" style="background-color:#ffffe1;border:1px solid black; CURSOR: text; font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 10px; TEXT-ALIGN:left;"></div>	            
<telerik:RadCodeBlock ID="RadCodeBlock18" runat="server">           
<script>
var  FinalconditionalArray = new Array();
MHSComboInstance = <%: cmbMHS.ClientID %>;
radTreeObj = <%: RadTree1.ClientID %>;
//debugger;
cmbMHSName = "<%: cmbMHS.ClientID %>";
cmbMHSObj  =  <%: cmbMHS.ClientID %>;
cmbOPRName = "<%: cmbOperator.ClientID %>";
cmbOPRObj = <%: cmbOperator.ClientID %>;
cmbBoolName = "<%: cmbBoolean.ClientID %>";
cmbBOOLObj = <%: cmbBoolean.ClientID %>;
objectTreeImg = "<%:conditionalDesigner.GetThemeRelativeUrl("Expression/Images/workflow9.gif")%>";
delteRowImg = "<%:conditionalDesigner.GetThemeRelativeUrl("Expression/Images/delete2.gif")%>";
menuImg = "<%:conditionalDesigner.GetThemeRelativeUrl("Images/ConditionMenu.gif")%>";
treeName = "<%: RadTree1.ClientID %>"
expbuilderURl = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(LoadOnDemandUrl, false)%>";
controlName = "<%:conditionalDesigner.ID%>";
var source ="<%:this.Context.Request["src"]%>";
menuImgSrc ="<%:conditionalDesigner.GetThemeRelativeUrl("Expression/Images/ConditionMenu.gif")%>";
errorIcon="<%:conditionalDesigner.GetThemeRelativeUrl("Images/icon-error.png")%>";
errorGif = "<%:conditionalDesigner.GetThemeRelativeUrl("Images/icon-error.png")%>";
closeImg="<%:conditionalDesigner.GetThemeRelativeUrl("Expression/graphics/close.gif")%>";
compileCodeImage = "<%:conditionalDesigner.GetThemeRelativeUrl("Expression/Images/icon-compile-code.png")%>"
expErrinExpression="<%:conditionalDesigner.GlobalResourceSet.GetString("ConditionErrinCondition")%>";
expErrorstext="<%:conditionalDesigner.GlobalResourceSet.GetString("ExpErrorstext")%>";
expCompiledCode= "<%:conditionalDesigner.GlobalResourceSet.GetString("ExpCompiledCode")%>";
conditionSelectLocal = "<%:conditionalDesigner.GlobalResourceSet.GetString("ConditionSelect")%>";
conditionEnterValueLocal = "<%:conditionalDesigner.GlobalResourceSet.GetString("ConditionEnterValue")%>";
ConditionObjTreeLocal = "<%:conditionalDesigner.GlobalResourceSet.GetString("ConditionObjTree")%>";
ConditionDeleteLocal = "<%:conditionalDesigner.GlobalResourceSet.GetString("ConditionDelete")%>";
ConditionParenthesesLocal = "<%:conditionalDesigner.GlobalResourceSet.GetString("ConditionParentheses")%>";
ConditionentervaliddateLocal = "<%:conditionalDesigner.GlobalResourceSet.GetString("Conditionentervaliddate")%>";
ConditionenternumericvalueLocal = "<%:conditionalDesigner.GlobalResourceSet.GetString("Conditionenternumericvalue")%>";
ConditionPlsEnterValueLocal = "<%:conditionalDesigner.GlobalResourceSet.GetString("ConditionPlsEnterValue")%>";

document.getElementById("LHS1").style.width="190px";
document.getElementById("divMain").onscroll =OnDivScroll;

Initialize();
function PageInit()
{
var  FinalconditionalArray = new Array();
MHSComboInstance = <%: cmbMHS.ClientID %>;
radTreeObj = <%: RadTree1.ClientID %>;
//debugger;
cmbMHSName = "<%: cmbMHS.ClientID %>";
cmbMHSObj  =  <%: cmbMHS.ClientID %>;
cmbOPRName = "<%: cmbOperator.ClientID %>";
cmbOPRObj = <%: cmbOperator.ClientID %>;
cmbBoolName = "<%: cmbBoolean.ClientID %>";
cmbBOOLObj = <%: cmbBoolean.ClientID %>;
objectTreeImg = "<%:conditionalDesigner.GetThemeRelativeUrl("Expression/Images/workflow9.gif")%>";
delteRowImg = "<%:conditionalDesigner.GetThemeRelativeUrl("Expression/Images/delete2.gif")%>";
menuImg = "<%:conditionalDesigner.GetThemeRelativeUrl("Expression/Images/ConditionMenu.gif")%>";
treeName = "<%: RadTree1.ClientID %>"
expbuilderURl = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(LoadOnDemandUrl, false)%>";
controlName = "<%:conditionalDesigner.ID%>";
var source ="<%:this.Context.Request["src"]%>";
menuImgSrc ="<%:conditionalDesigner.GetThemeRelativeUrl("Expression/Images/ConditionMenu.gif")%>";
errorIcon="<%:conditionalDesigner.GetThemeRelativeUrl("Images/icon-error.png")%>";
errorGif = "<%:conditionalDesigner.GetThemeRelativeUrl("Images/icon-error.png")%>";
closeImg="<%:conditionalDesigner.GetThemeRelativeUrl("Expression/graphics/close.gif")%>";
compileCodeImage = "<%:conditionalDesigner.GetThemeRelativeUrl("Expression/Images/icon-compile-code.png")%>"
expErrinExpression="<%:conditionalDesigner.GlobalResourceSet.GetString("ConditionErrinCondition")%>";
expErrorstext="<%:conditionalDesigner.GlobalResourceSet.GetString("ExpErrorstext")%>";
expCompiledCode= "<%:conditionalDesigner.GlobalResourceSet.GetString("ExpCompiledCode")%>";
conditionSelectLocal = "<%:conditionalDesigner.GlobalResourceSet.GetString("ConditionSelect")%>";
conditionEnterValueLocal = "<%:conditionalDesigner.GlobalResourceSet.GetString("ConditionEnterValue")%>";
ConditionObjTreeLocal = "<%:conditionalDesigner.GlobalResourceSet.GetString("ConditionObjTree")%>";
ConditionDeleteLocal = "<%:conditionalDesigner.GlobalResourceSet.GetString("ConditionDelete")%>";
ConditionParenthesesLocal = "<%:conditionalDesigner.GlobalResourceSet.GetString("ConditionParentheses")%>";
ConditionentervaliddateLocal = "<%:conditionalDesigner.GlobalResourceSet.GetString("Conditionentervaliddate")%>";
ConditionenternumericvalueLocal = "<%:conditionalDesigner.GlobalResourceSet.GetString("Conditionenternumericvalue")%>";
ConditionPlsEnterValueLocal = "<%:conditionalDesigner.GlobalResourceSet.GetString("ConditionPlsEnterValue")%>";

document.getElementById("LHS1").style.width="190px";
document.getElementById("divMain").onscroll =OnDivScroll;
}
function OpenMenu(obj,rowId)
{
        var x = findPosX(obj);
	    var y = findPosY(obj);
	    mainDivId = rowId;
        MenuDivObj.style.left = (parseInt(x)+10) + 'px';
        MenuDivObj.style.top = (parseInt(y)+ 8 ) + 'px';
        MenuDivObj.style.position="absolute";
        MenuDivObj.style.visibility="visible";
        MenuDivObj.style.display="block";


}

function ChangemenuItemClass(menuItem)
{
    document.getElementById("Menu1_0").style.backgroundColor="white";
    document.getElementById("Menu1_1").style.backgroundColor="white";
    document.getElementById("Menu1_2").style.backgroundColor="white";
    document.getElementById("Menu1_3").style.backgroundColor="white";
    menuItemObj =document.getElementById(menuItem);
    menuItemObj.style.backgroundColor="#cccccc";
}



function menuOnMouseOut()
{
    document.getElementById("Menu1_0").style.backgroundColor="white";
    document.getElementById("Menu1_1").style.backgroundColor="white";
    document.getElementById("Menu1_2").style.backgroundColor="white";
    document.getElementById("Menu1_3").style.backgroundColor="white";
    MenuDivObj.style.display="none";
}


function ClickOK()
{
    
 FinalconditionalArray=new Array()
 if(!ValidForm())
   {
        
        
   }
   else  
   {
       var j=1; 
       for(var i=0; i<InitialconditionalArray.length;i++)
       {
            var remRows = InitialconditionalArray[i];
            
            var validRow = remRows.split("~");
            
            if(validRow[1]=="S")
            {
                if(j==1)
                {
                    eval("window.Row"+validRow[0]+".LogicalOpr=\"\""); 
                }
                
                FinalconditionalArray[FinalconditionalArray.length]=eval("window.Row"+validRow[0]);
                
                j=0;
            }   
       }
       
       for(var i=1;i<=FinalconditionalArray.length;i++)
      {
         if(eval("window.Row"+i+".RHSMode")=="Expression")
         {
            if(eval("window.Row"+i+".RHSColumn")!=null)
            {
                 var expressionstring = EncodeTheExpressionString(eval("window.Row"+i+".RHSColumn.ColumnExpression.DisplayExpressionString"));
                 eval("window.Row"+i+".RHSColumn.ColumnExpression.DisplayExpressionString=expressionstring");
                 
                 expressionstring = EncodeTheExpressionString(eval("window.Row"+i+".RHSColumn.ColumnExpression.ActualExprtessionString"));
                 eval("window.Row"+i+".RHSColumn.ColumnExpression.ActualExprtessionString=expressionstring");
                 
                 expressionstring = EncodeTheExpressionString(eval("window.Row"+i+".RHSColumn.ColumnExpression.HtmlVerexpString"));
                 eval("window.Row"+i+".RHSColumn.ColumnExpression.HtmlVerexpString=expressionstring");
                 
            }
         }
          if(eval("window.Row"+i+".LHSMode")=="Expression")
         {
            if(eval("window.Row"+i+".LHSColumn")!=null)
            {
                 var expressionstring = EncodeTheExpressionString(eval("window.Row"+i+".LHSColumn.ColumnExpression.DisplayExpressionString"));
                 eval("window.Row"+i+".LHSColumn.ColumnExpression.DisplayExpressionString=expressionstring");
                 
                 expressionstring = EncodeTheExpressionString(eval("window.Row"+i+".LHSColumn.ColumnExpression.ActualExprtessionString"));
                 eval("window.Row"+i+".LHSColumn.ColumnExpression.ActualExprtessionString=expressionstring");
                 
                 expressionstring = EncodeTheExpressionString(eval("window.Row"+i+".LHSColumn.ColumnExpression.HtmlVerexpString"));
                 eval("window.Row"+i+".LHSColumn.ColumnExpression.HtmlVerexpString=expressionstring");
                 
            }
         }
      }
     
      CallServerSideMethod(controlName, 'CheckCondition',"DataTableCondition",CallbackSaveProperty,'table',FinalconditionalArray);
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
	   if((error[0]!=null)&&(error[0]!=""))
	   {
		    expCompResult = error[0];
		    compiledCode = error[1];
		     errLnkObj.style.visibility="visible";
		    errLnkObj.style.display="block";
		    errLnkObj.style.position="absolute";
		    OpenDiv(1);
		    
		}
		 else
        {
          
           var innerHTMl ="";
           innerHTMl = "<table width=\"100%\" cellspacing=2 cellpadding=2 valign=top>";
           var firstVariable=1;
           for(var i=0;i<FinalconditionalArray.length;i++)
           {
                var ConditionRow = FinalconditionalArray[i]; 
                
                
                var lhsValue ="";
                var rhsValue ="";       
                
                if(ConditionRow.LHSColumn.LHSMode=="Expression")
                    lhsValue = escapeHTML(DecodeTheExpressionString(ConditionRow.LHSColumn.ColumnExpression.DisplayExpressionString));
                else
                    lhsValue = escapeHTML(ConditionRow.LHSColumn.DisplayText);
                 
                if(ConditionRow.RHSMode=="default")
                    rhsValue = escapeHTML(ConditionRow.RHSValue);
                    
                else if(ConditionRow.RHSMode=="Expression")
                    rhsValue = escapeHTML(DecodeTheExpressionString(ConditionRow.RHSColumn.ColumnExpression.DisplayExpressionString));
                else
                    rhsValue = escapeHTML(ConditionRow.RHSColumn.DisplayText);   
                
                if(firstVariable==1)
                {
                    innerHTMl = innerHTMl+"<tr>";
                    innerHTMl = innerHTMl+"<td width=\"7%\" >&nbsp;</td>";
                    innerHTMl = innerHTMl+"<td width=\"93%\" class=\"description\" >"+ConditionRow.LHSBrace+lhsValue+"&nbsp;"+ ConditionRow.MHSDisplayText+"&nbsp;:"+rhsValue+"&nbsp;"+ConditionRow.RHSBrace+"</td>";
                    innerHTMl = innerHTMl+"</tr>";
                }
                else
                {
                    innerHTMl = innerHTMl+"<tr>";
                    innerHTMl = innerHTMl+"<td width=\"7%\" >&nbsp;</td>";
                    innerHTMl = innerHTMl+"<td width=\"93%\" class=\"description\" >"+ConditionRow.LogicalOpr.toLowerCase() +ConditionRow.LHSBrace +"&nbsp;"+lhsValue+"&nbsp;"+ ConditionRow.MHSDisplayText+"&nbsp;:"+rhsValue+ConditionRow.RHSBrace+"</td>";
                    innerHTMl = innerHTMl+"</tr>";
                
                }    
                firstVariable =0 ;
           }     
          
           var divObject = window.opener.document.getElementById("divCondition"+rowID);
           innerHTMl += "</table>";
           divObject.innerHTML = innerHTMl;
           
           var stringified = stringify(FinalconditionalArray);
           eval("window.opener.Decision"+rowID+".ConditionString=stringified");
           window.setTimeout('window.close()',100);  
        }		
    }
}
function escapeHTML (str){var div = document.createElement('div');var text = document.createTextNode(str);div.appendChild(text);return div.innerHTML;}
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


function Maximize(flag,val)
{
        
        xLHS = findPosX(document.getElementById("treeDiv"));
        yLHS = findPosY(document.getElementById("treeDiv"));
        var iframeObjBubble=document.getElementById("IframeShimForBubble");
        objLHSRadDiv = document.getElementById("treeDiv");
        
        //objLHSRadTree = document.getElementById("<%=RadTree1.ClientID%>");
        objLHSRadTree = document.getElementById("RadTreeDiv");
        if(flag == true)//Maximize
        {
         if(objLHSRadDiv.style.height!=317+'px' && objLHSRadDiv.style.width != 675 + 'px')
         {
             document.getElementById("HidX").value = xLHS;
             document.getElementById("HidY").value = yLHS;
             var Temp=300+'px';
             objLHSRadDiv.style.height=324+'px';
             objLHSRadDiv.style.width = 675 + 'px';
             objLHSRadDiv.style.top = document.body.style.top + 130;
             objLHSRadDiv.style.left = document.body.style.left + 83;
             objLHSRadTree.style.top = document.body.style.top + 130;
             objLHSRadTree.style.left = document.body.style.left + 83;
             objLHSRadTree.style.height = Temp;
             objLHSRadTree.style.width = objLHSRadDiv.style.width;
             
          }  
         }
         else//Minimize
         {
            if(objLHSRadDiv.style.height != 167+'px' && objLHSRadDiv.style.width != 227 + 'px')
            {
             
             objLHSRadDiv.style.height=174+'px';
             objLHSRadDiv.style.width = 227 + 'px';
             document.getElementById("treeDiv").style.visibility = "visible";
	         var Temp=150+'px';
	                            
             objLHSRadDiv.style.top = document.getElementById("HidY").value;
             objLHSRadDiv.style.left = document.getElementById("HidX").value;
             objLHSRadTree.style.top = document.getElementById("HidY").value ;
             objLHSRadTree.style.left = document.getElementById("HidX").value;
           
             objLHSRadTree.style.height = Temp;
             objLHSRadTree.style.width = objLHSRadDiv.style.width;
             }
        
         }
}
</script>

   </telerik:RadCodeBlock>


