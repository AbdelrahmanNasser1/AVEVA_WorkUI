<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.InvokeWS.WSMethodParameters" Theme=""  StylesheetTheme=""%>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>
<%@ Register TagPrefix="Skelta" TagName="SkeltaValueSelector" Src="../SkeltaValueSelector.ascx" %>
<%@ Register TagPrefix="cc2" Namespace="Workflow.NET.Ajax" Assembly="Workflow.NET.NET2" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %> 
 
<!DOCTYPE html>
<html>
<head runat="server">
    <title><%=l_WSTitle%></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script>
   
     <script src="../Javascript/XmlTreeview.js"></script>
     
</head>
    <style>
        html, body {
            height: 100%;
            width: 99%;
            overflow: hidden;
        }
 </style>

<body topmargin="0" leftmargin="0" style="padding:10px;">
 <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(PdCtrl.GetCommonRelativeUrl("stylesheet/global.css"))%>" rel="stylesheet" type="text/css">
<script>
    
    
    var outputSaveInSelDiv = "";
    var createXmlVarUrl = "";
    function OpenRadWindow() {
        //alert(createXmlVarUrl);
        try{
            var oWindow1 = window.radopen(createXmlVarUrl, "w1");
            oWindow1.set_modal(true);
        }
        catch (Err) {
            
        }
    }

    function OpenXmlVarWindow(u) {
        
        createXmlVarUrl = u;
        setTimeout("OpenRadWindow()", 100);
    }

    function CallServerFormRefresh(xmlVarName) {
        
        CallServerSideMethod(null, 'RefreshFormXml', "DataTableTest", CallbackRefreshXml, 'table', xmlVarName);
    }
    function CallbackRefreshXml(context, result, response) {
        document.getElementById("hiddenStorageValue").value = result;
        document.getElementById("buttonForPostBack").click();
    }
    <%=xmltree%>

    
</script>
    <form id="form1" runat="server" > 
        <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
        </telerik:RadScriptBlock>
         <telerik:RadScriptManager ID="RadScriptManager1" runat="server" />
        <telerik:RadScriptBlock ID="RadScriptBlock2" runat="server">
       <link href="<%=themePath%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
       <link href="<%=themePath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css") rel="stylesheet" type="text/css" />
       <link href="<%=themePath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css") rel="stylesheet" type="text/css" />
      </telerik:RadScriptBlock>
        <script>
            // Initialize locales for message dialog
            se.ui.messageDialog.setGlobalOptions({
                localization: { // All localization related default can be set
                    closeButtonCaption: "<%=GR.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                    okButtonCaption: "<%=GR.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                    cancelButtonCaption: "<%=GR.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                    showDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                    hideDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
                }
            });

            function ShowMessagesWithBellyBar(messageType, messageToDisplay)
            {
                var bellyBarTitle = "<%=GR.GetString("WS_Web Services") %>";
                switch (messageType)
                {
                    case 1: se.ui.messageDialog.showAlert(bellyBarTitle, messageToDisplay);
                        break;
                    case 2: se.ui.messageDialog.showError(bellyBarTitle, messageToDisplay);
                        break;
                }
            }
        </script>
      <div id="divWorkItem" runat="server" >
          <table width="100%" border="0" cellpadding="0" cellspacing="0" >
            <tr class="ListHeaderCss">
              <td ><table width="100%" border="0" cellspacing="0" cellpadding="0"class="header2">
                <tr class="ListHeaderCss">
                  <td width="95%" class="fontheading"><%=l_WSTitle%></td>
                  <td width="5%" class="fontheading"><a href="#">
                  <img src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(PdCtrl.GetCommonRelativeUrl("images/main-help.gif"))%>" alt="<%=GR.GetString("HelpAltText")%>" border="0"  onclick="javascript:openhelpinpdmode()"></a></td>
                </tr>
              </table></td>
            </tr>
          </table>
          <div style="width:99%;">
                      <ISWebGrid:webgrid id="WebGrid1" runat="server" height="190px" horizontalalign="NotSet"
                          width="100%" OnInitializeDataSource="WebGrid1_InitializeDataSource" OnInitializeRow="WebGrid1_InitRow"
                          OnPrepareDataBinding="WebGrid1_PrepareDataBinding" AllowAutoDataCaching="false"
                          DisableFileSystemChecking="true" EnableWebResources="never">
                          <LayoutSettings AllowFilter="yes" filterbarvisible="false" RowHeaders="No"
                                       AlternatingColors="true"                                                  
                                       GridLineStyle="Solid" 
                                       GridLineColor="#afafaf" 
                                       CellPaddingDefault="2" 
                                       RowHeightDefault="22px" 
                                       GridLines="None" 
                                       StatusBarVisible="True" 
                                       NewRowLostFocusAction="AlwaysPrompt" 
                                       RowLostFocusAction="AlwaysPrompt"
                                       PagingMode="VirtualLoad"  VirtualPageSize="50"
                                       PromptBeforeDelete="true"  AutoHeight=false    allowselectcolumns="Yes" allowedit="Yes"                                             
                                       AutoFitColumns="True" ShowRefreshButton="true" AllowExport="Yes" AlwaysShowHelpButton="false" AllowSorting="yes" AllowColumnSizing="Yes">                                                                                         
                                                           <HeaderStyle Wrap="false" Height="20px" Overflow="hidden" OverflowX="hidden" OverflowY="hidden"
                                                    CssClass="GridHeaderStyle"></HeaderStyle>

                                    <FocusCellStyle CssClass="GridFocusCellStyle"></FocusCellStyle>
                                    <GroupRowInfoStyle CssClass="GridGroupRowInfoStyle"></GroupRowInfoStyle>
                                    <GroupByBox>
                                        <LabelStyle CssClass="GridLabelStyle"></LabelStyle>
                                    </GroupByBox>
                                    <EditTextboxStyle CssClass="GridEditTextboxStyle"></EditTextboxStyle>
                                    <FrameStyle GradientType="Vertical" CssClass="GridFrameStyle"></FrameStyle>
                                    <SelectedRowStyle CssClass="GridSelectedRowStyle" CustomRules="text-overflow: ellipsis; overflow-x: hidden"></SelectedRowStyle>                                    
                                    <AlternatingRowStyle CssClass="GridAlternatingRowStyle" CustomRules="text-overflow: ellipsis; overflow-x: hidden"/>
                                    <RowStyle CssClass="GridRowStyle" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden"></RowStyle>  
                                    <NewRowStyle CssClass="GridNewRowStyle"></NewRowStyle>
                                    <EditFocusCellStyle CssClass="GridEditFocusCellStyle"></EditFocusCellStyle>
                                    <TextSettings Language="UseCulture"></TextSettings>
                                    <ButtonStyle CssClass="inputbutton" Height="17px" ></ButtonStyle>
                                    <ClientSideEvents  OnEnterEditMode="WebGrid1_OnEnterEditMode" OnRowContextMenu="DisableContextMenu" />
                                    <TextSettings Language="UseCulture"></TextSettings>   
                                    <StatusBarStyle CssClass="GridStatusBarStyle">
                                        <Padding Top="2px" Left="2px" Bottom="2px" Right="2px"></Padding>
                                    </StatusBarStyle>
                        </layoutsettings>
                                <RootTable GridLineStyle="NotSet">
                                    <TableHeaderStyle CssClass="GridTableHeaderStyle">
                                        <Padding Bottom="4px" Left="4px" Top="4px" Right="4px"></Padding>
                                    </TableHeaderStyle>
                                </RootTable> 
                        </ISWebGrid:webgrid>  
                  
              
              </div>
          <table width="100%" border="0" cellpadding="4" cellspacing="1" >
            <tr>
              <td colspan="2">
              <TABLE width="100%" border="0" cellpadding="2" cellspacing="1">
                  <TR runat="server" id="standardDataType">
                    <TD  width="20%" class="subtitle"><%=l_WSSaveOutputIn%></TD>
                    <TD  width="80%" >
                        <Skelta:SkeltaValueSelector id="OPValSel"  runat=server  ValueItemText="Select" JavaScriptPath="../Javascript/SkeltaValueSelector.js"/>

                    </TD>
                      </TR>
                  <TR runat="server" id="complexDataType">
                    <TD  width="20%" class="subtitle"><%=l_WSSaveOutputIn%></TD>
                    <TD  width="80%" >
                        <table border="2" style="padding-left: 0px;height:100%">
                            
                            <tr>
                                <td width="35%" >
                                     <telerik:RadComboBox ID="radComboStorageType" runat="server" AutoPostBack="true" Skin="AWTCombobox" Width="160px" RenderMode="Classic"
                                                  Height="150px" AllowCustomText="true" MarkFirstMatch="true" EnableEmbeddedSkins="false" MaxLength="150" DropDownWidth="160px" NoWrap="true">
                                     </telerik:RadComboBox>
                                     <asp:HiddenField ID="hiddenStorageValueType" runat="server" />
                                    <asp:HiddenField ID="hiddenStorageValue" runat="server" />
                                </td>
                                <td width="65%" style="padding-left:2px">
                                    <div id="divStorageType">
                                         <telerik:RadComboBox ID="radComboVariable" runat="server" AutoPostBack="true" Skin="AWTCombobox" Width="260px" RenderMode="Classic"
                                                  Height="150px" AllowCustomText="true" MarkFirstMatch="true" EnableEmbeddedSkins="false" MaxLength="250" DropDownWidth="260px" NoWrap="true" Visible="true">
                                            </telerik:RadComboBox>                                       
                                         <telerik:RadComboBox ID="radComboXmlVariable" runat="server" AutoPostBack="true" Skin="AWTCombobox" Width="260px" RenderMode="Classic"
                                                  Height="150px" AllowCustomText="true" MarkFirstMatch="true" EnableEmbeddedSkins="false" MaxLength="250" DropDownWidth="260px" NoWrap="true" Visible="true">
                                            </telerik:RadComboBox>                                     
                                    </div>
                                </td>
                  </TR>
              </TABLE>
                    </td>
                  </tr>
                  </TABLE>
                  </td>
            </tr>
            <tr>
              <td colspan="2" >
                <table width="100%" border="0" cellpadding="2" cellspacing="1" class="tablebg">
                <tr>
                  <td class="lefttdbg"><TABLE width="100%" border=0 cellpadding="0" cellspacing="0">
                    <!-- Security -->
                    <TR>
                      <TD width=20% class="subtitle"><%=l_WSLoginName%> </TD>
                      <TD width=80% class="description"><Skelta:SkeltaValueSelector id="SecUsrValSel" runat=server JavaScriptPath="../Javascript/SkeltaValueSelector.js"/></TD>
                    </TR>
                    <TR>
                      <TD width=100 class="subtitle"><%=l_WSPassword%> </TD>
                      <TD class="description" ><Skelta:SkeltaValueSelector id="SecPwdValSel" runat=server ValueItemText="Password"  JavaScriptPath="../Javascript/SkeltaValueSelector.js"/></TD>
                      <input id="hiddenPwd" type="hidden" name="hiddenPwd" value="" />
                    </TR>
                    <TR>
                      <TD width=100 class="subtitle"><%=l_WSDomain%> </TD>
                      <TD class="description"><Skelta:SkeltaValueSelector id="SecDmnValSel"  runat=server JavaScriptPath="../Javascript/SkeltaValueSelector.js"/></TD>
                    </TR>
                  </TABLE></td>
                </tr>
              </table>
              </td>
            </tr>
            <tr>
                 <td width="50%">
                    <img src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(PdCtrl.GetThemeRelativeUrl("ProcessDesigner/Images/icon-tips.gif"))%>" align=absmiddle >
                    <span class="description"><%=GR.GetString("ws_wsmthodparams_row_Desc")%></span>
               </td>
              <td style="text-align:right;width:50%" >
                  <input id="hParamCount" type="hidden" name="hParamCount" value="<%=ParamCount%>" />
                  <input id="hParamValues" type="hidden" name="hParamValues" value="<%:hParamValues%>">
                  <input id="hParamVal" type="hidden" name="hParamVal" runat="server">
                  <asp:Button CssClass="inputbutton" ID="Button1" runat="server" Text="Update"  OnClick="Button1_Click" /></td>
            </tr>
            <tr>
              <td colspan="2" style="text-align:right">
                  <asp:Button ID="btnWSList" runat="server" OnClick="btnWSList_Click" Text="List" CssClass="inputbutton" Style="margin-right:10px;"/>
                  <asp:Button ID="btnWSFields" runat="server" Visible=false Text="Fields" CssClass="inputbutton" OnClick="btnWSFields_Click"/>            
                  <asp:Button ID="btnWSMthdList" runat="server" OnClick="btnWSMthdList_Click" Text="Method List" Width="100" CssClass="inputbutton"/></td>
            </tr>
        </table>
      </div>
      
      
        <div id="divAddWorkItemField" runat="server">    
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <table cellpadding="0" cellspacing="1" border="0" width="100%">
                          
                          <tr class="description">
                           <td colspan="2">
                            <table width="100%" border="0" cellpadding="5" cellspacing="1" class="lefttdbg">
                                <tr>
                                  <td height="24" class="fontheading" colspan="4"><%=l_WSAdd_editWSParam%></td>
                                </tr>
                                <tr>
                                    <td height="24" class="subtitle" ><%=l_WSParameterName%></td>
                                    <td width="70%" class="description">
                                        &nbsp;<%=pParamName%></td>
                                </tr>
                                <tr>
                                    <td height="24" class="subtitle"><%=l_WSParamDataType%></td>
                                    <td width="70%" class="description">
                                        &nbsp;<%=pDataType%></td>
                                </tr>
                                                                
                                <tr>
                                    <td height="24" class="subtitle" ><%=l_WSParamLevel%></td>
                                    <td width="70%" class="description">
                                        &nbsp;<%=pLevel%></td>
                                </tr>
                                
                                <tr>
                                    <td height="24" class="subtitle" ><%=l_WSParamSerialize%></td>
                                    <td width="70%" class="description">
                                    &nbsp;<input id="chkSerialize" runat="server" type="checkbox" /></td>
                                </tr>
                                <tr>
                                    <td class="subtitle" ><%=l_WSParamValue%></td>
                                    <td width="70%" class="description" >
                                        <Skelta:SkeltaValueSelector id="ValSelect"  runat=server JavaScriptPath="../Javascript/SkeltaValueSelector.js"/></td>
                                </tr>
								
                                <tr >
                                   <td style="text-align:right" colspan="2" >                                        
                                        
                                        <asp:Button ID="btnEditWSParamsCancel" CssClass="inputsecondarybutton" runat="server" Text="Cancel" OnClick="btnEditWSParamsCancel_Click" style="margin-right:10px;" />   
                                       <asp:Button ID="btnUpdateWSParams" CssClass="inputbutton" runat="server" style="width:125px;" Text="Update" OnClick="btnUpdateWSParams_Click" />
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
        <div id="bubbleWindow" style="border:1px solid black; CURSOR: text; font-family: Verdana, Arial, Helvetica, sans-serif;	font-size: 10px; TEXT-ALIGN:left;"></div>
        <iframe id="IframeShimForBubble" scrolling="no"	frameborder="no"	style="position:absolute; top:0px; left:0px; display:none;"></iframe>
         <cc2:AjaxPageControl id="AjaxPageControl1" runat="server" style="Z-INDEX: 104; LEFT: 440px; POSITION: absolute; TOP: 88px">
         </cc2:AjaxPageControl>        
        <input type="button" runat="server" id="buttonForPostBack" onserverclick="buttonForPostBack_ServerClick" style="display:none" />
        
        <telerik:RadWindowManager ID="RadWindowManager1" EnableEmbeddedSkins="false" runat="server" 
            Behaviors="Close" RenderMode="Classic" VisibleStatusbar="true" Skin="AWTWindow">  
            <Windows>
                <telerik:RadWindow ID="w1" runat="server" Left=""></telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>
     </form>

    <script language="javascript">
        bubbleWindowObj = document.getElementById("bubbleWindow");
		 bubbleWindowObj.style.display="none"; 
/*		var valuediv = "<input id='valueinput' name='valueinput' type='text' value='"+""+"'>";
		var variablediv = "<SELECT id='valueinput' name='valueinput'>";
		variablediv += "<OPTION value='Variable.EmailApprove'>Variable.EmailApprove</OPTION><OPTION Value='Variable.SubmittedBy.Email ID,Variable.SubmittedBy.Email'>Variable.SubmittedBy.Email ID</OPTION><OPTION Value='Variable.SubmittedBy.First Name,Variable.SubmittedBy.FirstName'>Variable.SubmittedBy.First Name</OPTION><OPTION Value='Variable.SubmittedBy.Last Name,Variable.SubmittedBy.LastName'>Variable.SubmittedBy.Last Name</OPTION><OPTION Value='Variable.SubmittedBy.UserID,Variable.SubmittedBy.UserID'>Variable.SubmittedBy.UserID</OPTION><OPTION Value='Variable.SubmittedBy.Employee Name,Variable.SubmittedBy.UserName'>Variable.SubmittedBy.Employee Name</OPTION>";
		variablediv +=	"</SELECT>";

		var contentdiv = "<SELECT id='valueinput' name='valueinput'>";
		contentdiv += "";
		contentdiv +=	"</SELECT>";

		var oexpr2;
        checktoselect();
*/        
//************** Output Variable(Start) *******************************************		
/*		var variablediv = "<SELECT id='valueoutput'>";
		variablediv += "<OPTION Value='Variable.SubmittedBy.Email ID,Variable.SubmittedBy.Email'>Variable.SubmittedBy.Email ID</OPTION><OPTION Value='Variable.SubmittedBy.First Name,Variable.SubmittedBy.FirstName'>Variable.SubmittedBy.First Name</OPTION><OPTION Value='Variable.SubmittedBy.Last Name,Variable.SubmittedBy.LastName' selected>Variable.SubmittedBy.Last Name</OPTION><OPTION Value='Variable.SubmittedBy.UserID,Variable.SubmittedBy.UserID'>Variable.SubmittedBy.UserID</OPTION><OPTION Value='Variable.SubmittedBy.Employee Name,Variable.SubmittedBy.UserName'>Variable.SubmittedBy.Employee Name</OPTION>";
		variablediv +=	"</SELECT>";

		var contentdiv = "<SELECT id='valueoutput'>";
		contentdiv += "";
		contentdiv +=	"</SELECT>";
*/		
//************** Output Variable(End) *******************************************
//************** Security Variable(Start) *******************************************		
/*		var variableSecdiv = "<SELECT id='valueSecurity'>";
		variableSecdiv += "<OPTION Value='Variable.SubmittedBy.Email ID,Variable.SubmittedBy.Email'>Variable.SubmittedBy.Email ID</OPTION><OPTION Value='Variable.SubmittedBy.First Name,Variable.SubmittedBy.FirstName'>Variable.SubmittedBy.First Name</OPTION><OPTION Value='Variable.SubmittedBy.Last Name,Variable.SubmittedBy.LastName'>Variable.SubmittedBy.Last Name</OPTION><OPTION Value='Variable.SubmittedBy.UserID,Variable.SubmittedBy.UserID'>Variable.SubmittedBy.UserID</OPTION><OPTION Value='Variable.SubmittedBy.Employee Name,Variable.SubmittedBy.UserName'>Variable.SubmittedBy.Employee Name</OPTION>";
		variableSecdiv +=	"</SELECT>";

		var contentSecdiv = "<SELECT id='valueSecurity'>";
		contentSecdiv += "";
		contentSecdiv +=	"</SELECT>";
		
		var valueSecdiv= "<input type=textbox id='valueSecurity' class='inputs' style='width:250px'>";
		var PwdvalueSecdiv= "<input type=password id='valueSecurity' class='inputs' style='width:250px'>";
		//var SelectSecdiv="";
		
		var ExecUserName="";
		var ExecPassword="";
		var ExecDomainName="";
*/		
//************** Security Variable(End) *******************************************

//		oexpr2 = document.getElementsByTagName("div")["expr2"];
        var fromMainWindow=1;
		function changeDiv(divname, divvar )
		{
			oexpr2 = document.getElementById(divname);			
			oexpr2.innerHTML = eval(divvar);
		}

       function Select3_onclick(selectname,divname)
		{
		
			var oselect3 = document.getElementById(selectname);
			switch(oselect3.value)
			{
				case "Value": changeDiv(divname,"valuediv");
							break;
				case "Variable": changeDiv(divname,"variablediv");
								break;

				case "Content": changeDiv(divname,"contentdiv");
								break;
			}
			return false;
		}
		
		function openhelpinpdmode()
        {        
            window.open('<%=PdCtrl.GetHelpPageUrl()%>WebService-WebServiceDetails.html','','height=450,width=600,resizable=yes,status=no,scrollbars=yes');
        }
		
		function SelectOP_onclick()
	    {
		    var oselect3 = document.getElementsByTagName("select")["SelectOP"];
		    switch(oselect3.value)
		    {			
			    case "Variable": changeDiv("exprOP","variablediv");
							    break;

			    case "Content": changeDiv("exprOP","contentdiv");
							    break;
		    }

		    return false;
	    }
	    
	 /*   function SelectSecurity_onclick(selectname,divname,index)
	    {
            alert(selectname);
		    var oselect3 = document.getElementsByTagName("select")[selectname];
		    switch(oselect3.value)
		    {
			    case "value": 
				    if (index==1)
					    changeDiv(divname,"PwdvalueSecdiv");
				    else
					    changeDiv(divname,"valueSecdiv");
				    break;									
			    case "varproperty": 
				    changeDiv(divname,"variableSecdiv");				
				    break;						
			    case "contentproperty": 
				    changeDiv(divname,"contentSecdiv");
				    break;
			    default: 			
				    //changeDiv("SelectSecdiv",divname);
				    if (index==1)
					    changeDiv(divname,"PwdvalueSecdiv");
				    else
					    changeDiv(divname,"valueSecdiv");
				    break;											
    			

		    }

		    return false;
	    }

*/
function SubmitOnClick()
{
  
//alert("Test SubmitOnClick");
  var tempObj = eval("document.form1.valueinput[0]");
  
    //document.getElementById("hParamCount").value=2;
    var ParamValues="";
    for(i=0;i<document.getElementById("hParamCount").value;i++)
    {
        var selVType=document.getElementById('Select'+i)
        //alert(selVType.value);
        ShowMessagesWithBellyBar(2, selVType.value);
        ParamValues+=GetFormatedString(selVType.value);
		
        tempObj = eval("document.form1.valueinput[i]");
        ParamValues+=GetFormatedString(tempObj.value)        
        //alert(tempObj.value);
       // alert(ParamValues);
    }
    document.getElementById("hParamValues").value=ParamValues;
}
    var sParamValuesExpr="";
    function UpdateParams()
    {
        var CurrentParamExpr=document.getElementById("hParamVal").value;;
        //alert(CurrentParamExpr);
        //alert(fromMainWindow);
        ShowMessagesWithBellyBar(2, CurrentParamExpr);
        ShowMessagesWithBellyBar(2, fromMainWindow);

        var ParamNo=CurrentParamExpr.substring(0,2);
        CurrentParamExpr = CurrentParamExpr.substring(4);
        var arrValTyp=CurrentParamExpr.split('/');
        var ValueType=arrValTyp[0];
        var Value=arrValTyp[1];
        
        var ParamValues=document.getElementById("hParamValues").value;
//alert(ParamValues);        
        sParamValuesExpr=CurrentParamExpr;
        var ParmExpr="";
        var ExprFound=0;
        while (sParamValuesExpr!="")
        {
            ParmExpr=GetNextValueFromExpression();
            if (ParamExpr.substring(0,2)==ParamNo)
            {
                var iPos = ParamValues.indexOf(ParmExpr);
                var ParamStartString=ParamValues.substring(0,iPos-4);
                var ParamEndString=ParamValues.substring(iPos+ParmExpr.length);                
                ParamValues=ParamStartString+ GetFormatedString(CurrentParamExpr) + ParamEndString
                ExprFound=1;
            }            
        }
        if (ExprFound==0)
            ParamValues=ParamValues+GetFormatedString(CurrentParamExpr); 
        document.getElementById("hParamValues").value=ParamValues;
    }


    function ConvertToString(number,width)
	{
		var str="";
		var i;
		
		str=number.toString();
		var l = str.length;
		for(i=0;i<(width-l);i++)
		{
			str = "0" + str;
		}	
		return str.substring(0,width);
	}
	
	function GetFormatedString(strVar)
	{
	
	   return ConvertToString(strVar.length,4)+strVar;
	}
	
	//var sParamValuesExpr="";
	function checktoselect()
	{	
	    var ParamValues=document.getElementById("hParamValues").value;
		if (ParamValues=="") return;
		sParamValuesExpr=ParamValues;
		var listCount=document.getElementById("hParamCount").value;
        var i=0; 
		for(i=0;i<listCount;i++)
		{
		    var selVType=document.getElementById('Select'+i)
		    selVType.value="Variable";

			Select3_onclick('Select'+i,'expr'+i);
		}
 
		//Set the selected values
		for ( i = 0 ;i<parseInt(listCount);i++)
		{
			if(parseInt(listCount) ==1)
				var tempObj = eval("document.form1.valueinput");
			else
				var tempObj = eval("document.form1.valueinput["+i+"]");
			if(typeof(tempObj) == "undefined")
				tempObj = eval("document.form1.valueinput");
			sVal=GetNextValueFromExpression()
//alert(sVal);			
			tempObj.value = sVal;//eval("document.form1.txtinputvarval"+i+".value")

		}
		//checktoSecurityselect();		 		
	}
	function GetNextValueFromExpression()
    {
//alert("1#" + sParamValuesExpr + "#");
        
        var iLength = parseInt(RemoveZeros(sParamValuesExpr.substring(0,4)));
        sParamValuesExpr = sParamValuesExpr.substring(4);
        
       
        var sVal=sParamValuesExpr.substring(0,iLength);
        sParamValuesExpr = sParamValuesExpr.substring(iLength); ;

        return sVal;
    }
	function GetNextValueFromExpression_old()
    {
//alert("1#" + sParamValuesExpr + "#");
//        var l = sParamValuesExpr.substring(0,4);
//alert(l);
//        //l=RemoveZeros(l);
//alert("#" + l);        
//        var iL=parseInt(l);
//alert(iL);        
        var iLength = parseInt(RemoveZeros(sParamValuesExpr.substring(0,4)));
        sParamValuesExpr = sParamValuesExpr.substring(4);
//alert(iLength);        
//alert("2#" + sParamValuesExpr + "#");        
        var sVal=sParamValuesExpr.substring(0,iLength);
        sParamValuesExpr = sParamValuesExpr.substring(iLength); ;
//alert("3#" + sParamValuesExpr + "#");        
        return sVal;
    }
    
    function RemoveZeros(sLength)
    {
        for(i=0;i<4;i++)
        {
            if(sLength.substring(0,1)=="0")
              sLength=sLength.substring(1)
            else
              return(sLength);
        }    
        return(sLength); 
        
    }
    function DisableContextMenu(gridId, rowType, rowEl, rowMenu)
    { 
    
        var i;
        var grid = wgGetGridById(gridId);	                 
        if (rowType != "Record") return true;	        
        if(rowType =="Record")
        { 
            // hide the default context menu
            for (i=0;i<=43;i++)
            {    
                 if(i!=21)   //Changed to disbale all the unwanted context menu Items except edit menu          
                     rowMenu.Items[i].Hide();    
                     else
                     {
                     rowMenu.Items[i].Text="<%=l_WSMnu_Edit%>";
                     }          
            }  
              
                       
        } 	
 }
    function WebGrid1_OnEnterEditMode(gridId,tblName,editObject)
    {
        
        var row = wgGetGridById(gridId).GetSelectedObject().GetRowElement();
        var ParamName = wgGetCellByName(row, "Parameter Name"); 
        var ParamNo = wgGetCellByName(row, "ParamNo");
        var DataType = wgGetCellByName(row, "Type/DataType");
        var Serialize = wgGetCellByName(row, "vSerialize");
        var Values = wgGetCellByName(row, "vValues");
        
        var Level = wgGetCellByName(row, "Level");

        var pVal = Values.hiddenData1;
        
        if (pVal == null)
        {
            //
            // NOTE: { Rupesh M. Kokal }
            // For Mozilla, Values.hiddenData1 would always return an empty value,
            // hence we need to use -> Values.attributes["hiddenData1"].value
            // 
            // The same can be used for Internet explorer. But we would keep it 
            // as it is for now.
            //
            try
            {
                pVal = Values.attributes["hiddenData1"];
                if (pVal == null)
                {
                    pVal = "";
                }
                else
                {
                    pVal = Values.attributes["hiddenData1"].value;
                }
            }
            catch (Err)
            {
                pVal = "";
            }
        }
		
        //alert(pVal);
        var URLParams = "&ParamNo=" + ParamNo.innerText + "&ParamName=" + ParamName.innerText + "&DataType=" + DataType.innerText + "&Serialize=" + Serialize.innerText + "&Values=" + pVal + "&Level=" + Level.innerText;
        //var URLParams = "&ParamNo=" + ParamNo.innerText + "&ParamName=" + ParamName.innerText + "&DataType=" + DataType.innerText + "&Serialize=" + Serialize.innerText + "&Values=Variable/Variable.SubmittedBy.Last Name,Variable.SubmittedBy.LastName";


//alert("URL: " + location.href+ URLParams);
          var u=location.href;

          u = RemoveHashCharacterFromUrl(u);

          //u=GetURL(u);
          u=u+URLParams;
          u=EditWorkItemFieldUrl(u);
          //alert(u);
          var w=window.open (u, "WinWorkItemFields", "location=0, status=0, scrollbars=0, width=800, height=270, resizable=no" );
          w.focus();
          //w.document.getElementById('hRowVal').value=URLParams;
    }
    
    function GetURL(Url)
    {
        var iPos=Url.indexOf("WSMethodParameters.aspx?");
        var sURL=Url.substring(0,iPos+24);
        return(sURL);
    }

    function RemoveHashCharacterFromUrl(Url)
    {
        try
        {
            if (Url.indexOf("#", Url.length - 1) >= 0)
            {
                return Url.substring(0, Url.length - 1);
            }
            else
            {
                return Url;
            }
        }
        catch (Err)
        {
            return Url;
        }
    }

    function EditWorkItemField(id,name,dispname,type,defvalue)
    {
    //alert(defvalue);
      //var urlparameters='&WrkItmMode=edit&Id='+id+'&Name='+name+'&DisplayName='+dispname+'&Type='+type+'&DefaultValue='+defvalue;          
      //mywindow = window.open (EditWorkItemFieldUrl(location.href+ urlparameters ), "WinWorkItemFields", "location=0, status=0, scrollbars=0, width=545, height=210, resizable=yes" );      
      mywindow.moveTo(0,0);
      mywindow.focus();
      return false;
     }          
          
    function EditWorkItemFieldUrl( currentUrl ) 
    {
        if( currentUrl.indexOf('?') >= 0 ) 
        {
            currentUrl += '&';
        }
        else 
        {
            currentUrl += '?';
        }
        
        currentUrl += 'div=divAddWorkItemField';

        return currentUrl;
    }
    function Button4_Click()
    {
        alert("Testing");
        //alert(document.getElementById('hRowVal').value);
    }    
    

    
    
    function ShowAlttext(textObject)
		{
		    var altText="";
		    var x =findPosX(textObject);
		    var y =findPosY(textObject);
		    var iframeObjBubble=document.getElementById("IframeShimForBubble");

		    if(textObject.value=="")
		    	return false;
		    else
		    	altText = textObject.value;

			document.getElementById("IframeShimForBubble").style.visibility = "visible";
		    bubbleWindowObj.style.left = parseInt(x)+10 + 'px';
		    bubbleWindowObj.style.top  = parseInt(y)+30 + 'px';
		    bubbleWindowObj.style.visibility="visible";
		    bubbleWindowObj.style.display="block";
		    bubbleWindowObj.style.position="absolute";
			bubbleWindowObj.innerHTML	= altText;
			bubbleWindowObj.style.zIndex = 10;

			iframeObjBubble.style.width = bubbleWindowObj.offsetWidth ;
			iframeObjBubble.style.height = bubbleWindowObj.offsetHeight ;
			iframeObjBubble.style.top = bubbleWindowObj.style.top;
			iframeObjBubble.style.left = bubbleWindowObj.style.left;
			iframeObjBubble.style.zIndex = bubbleWindowObj.style.zIndex - 1;
			iframeObjBubble.style.display = "block";

		}

		function HideAlttext()
		{

		    bubbleWindowObj.innerHTML	= "";
		    bubbleWindowObj.style.display="none";
		    document.getElementById("IframeShimForBubble").style.visibility = "hidden";
		} 

		function isIE11() {
		    return !!navigator.userAgent.match(/Trident.*rv[ :]*11\./);
		}

		function ResizeGrid() {
		    if (isIE11()) {
		        var grid = ISGetObject("WebGrid1");
		        if (grid != undefined)
		        grid.SetHeight(200 + 'px');

		        //window.setTimeout(function () { wgDoResize(true, true); }, 600);
		        //return true;

		    }
		}

		ResizeGrid();
    
    </script>    

    
    
</body>
</html>
