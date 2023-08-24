<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.InvokeWS.WSFields" Theme="" StylesheetTheme="" %>

<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>

<%@ Register TagPrefix="Skelta" TagName="SkeltaValueSelector" Src="../SkeltaValueSelector.ascx" %>
 <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(PdCtrl.GetCommonRelativeUrl("stylesheet/global.css"))%>" rel="stylesheet" type="text/css">

<!DOCTYPE html>
<html >

<head runat="server">
    <title><%=l_WSTitle%></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="../Javascript/XmlTreeview.js"></script>
</head>
<body topmargin="0" leftmargin="0" style="padding:10px;">
    <form id="form1" runat="server" >
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
      <div id="divFields" runat="server" >
          <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td ><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="95%" class="fontheading"><%=l_WSTitle%></td>
                  <td width="5%" class="fontheading"><a href="#">
                  <img src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(PdCtrl.GetCommonRelativeUrl("images/main-help.gif"))%>" alt="<%=GR.GetString("HelpAltText")%>"  border="0" onclick="javascript:openhelpinpdmode()"></a></td>
                </tr>
              </table></td>
            </tr>
          </table>
          <div style="width:99%;height:190px">
                      <ISWebGrid:webgrid id="WebGrid1" runat="server" height="100%" horizontalalign="NotSet"
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
          <table width="100%" border="0" cellpadding="0" cellspacing="1" >
              <tr>
              <td width="50%">
                    <img src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(PdCtrl.GetThemeRelativeUrl("ProcessDesigner/Images/icon-tips.gif"))%>" align=absmiddle >
                    <span class="description"><%=GR.GetString("ws_wsmthodparams_row_Desc")%></span>
               </td>
                  <td style="text-align:right;width:50%">
                      <input id="hParamCount" type="hidden" name="hParamCount" value="<%=ParamCount%>" />
                      <input id="hParamValues" type="hidden" name="hParamValues" value="<%:hParamValues%>">
                      <input id="hParamVal" type="hidden" name="hParamVal" runat="server">
                      <asp:Button CssClass="inputbutton" ID="Button1" runat="server" Text="Update" OnClick="Button1_Click" /></td>
              </tr>
             
            <tr>
              <td colspan="2" style="text-align:right">
                  <asp:Button ID="btnWSList" runat="server" OnClick="btnWSList_Click" Text="List" Width="75" CssClass="inputbutton"/>                              
                  </td>
            </tr>
        </table>
      </div>
      
      
        <div id="divFieldValue" runat="server">    
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <table cellpadding="0" cellspacing="1" border="0" width="100%">
                          
                          <tr class="select1">
                           <td colspan="2">
                            <table width="98%" border="0" cellpadding="5" cellspacing="1"  class="tablebg">
                                <tr class="select1">
                                  <td class="fontheading" colspan="4">Add/edit web service parameters</td>
                                </tr>
                                <tr class="select1">
                                    <td height="24" ><span class="description"><%=l_WSParameterName%></span></td>
                                    <td width="70%" >
                                        <span class="description"><%:pParamName%></span></td>
                                </tr>
                                <tr class="select1">
                                    <td height="24" ><span class="description"><%=l_WSParamDataType%></span></td>
                                    <td width="70%" class="righttdbg">
                                        <span class="description"><%:pDataType%></span></td>
                                </tr>
                                                                
                                <tr class="select1">
                                    <td height="24"><span class="description"><%=l_WSParamLevel%></span></td>
                                    <td width="70%" class="righttdbg">
                                        <span class="description"><%:pLevel%></span></td>
                                </tr>
                                <tr class="select1">
                                    <td height="24" ><span class="description"><%=l_WSParamSerialize%></span></td>
                                    <td width="70%"><input id="chkSerialize" runat=server type="checkbox" class="inputcheckbox" /></td>
                                </tr>
                                <tr class="select1">
                                    <td ><span class="description"><%=l_WSParamValue%></span></td>
                                    <td width="70%" class="righttdbg">
                                        <Skelta:SkeltaValueSelector id="ValSelect"  runat=server  JavaScriptPath="../Javascript/SkeltaValueSelector.js"/></td>
                                </tr>
								
                                <tr>
                                   <td width="100%"  style="text-align:right" colspan="2" >                                        
                                        <asp:Button ID="btnUpdateWSParams" CssClass="inputbutton" runat="server" Text="Update Parameter Value" OnClick="btnUpdateWSParams_Click" />
                                        <asp:Button ID="btnEditWSParamsCancel" CssClass="inputbutton" runat="server" Text="Cancel" OnClick="btnEditWSParamsCancel_Click"  />                                    </td>
                                </tr>
                            </table>                           </td>
                          </tr>
                        </table><script><%=xmltree%></script>
                    </td>
                </tr>
            </table>
        </div>
         </div>
        <div id="bubbleWindow" style="border:1px solid black; CURSOR: text; font-family: Verdana, Arial, Helvetica, sans-serif;	font-size: 10px; TEXT-ALIGN:left;"></div>
        <iframe id="IframeShimForBubble" scrolling="no"	frameborder="no"	style="position:absolute; top:0px; left:0px; display:none;"></iframe>
    </form>

    <script language="javascript">

 bubbleWindowObj = document.getElementById("bubbleWindow");
		 bubbleWindowObj.style.display="none"; 
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
		
/*		function SelectOP_onclick()
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
	    
	    function SelectSecurity_onclick(selectname,divname,index)
	    {

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
alert(selVType.value);
        ParamValues+=GetFormatedString(selVType.value);
		
        tempObj = eval("document.form1.valueinput[i]");
        ParamValues+=GetFormatedString(tempObj.value)        
        //alert(tempObj.value);
        //alert(ParamValues);
    }
    document.getElementById("hParamValues").value=ParamValues;
}
    var sParamValuesExpr="";
    function UpdateParams()
    {
        var CurrentParamExpr=document.getElementById("hParamVal").value;;
        alert(CurrentParamExpr);
        alert(fromMainWindow);
        
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

    //Changed because of Javascript error on right click
         var i;
       	                 
        if (rowType != "Record") return true;	        
        if(rowType =="Record")
        { 
            // hide the default context menu
            for (i=0;i<=43;i++)
            {    
                 if(i!=21)   //Changed to disbale all the unwanted context menu Items except edit menu        
                     rowMenu.Items[i].Hide();              
            } 
         }    
    }
    
    function WebGrid1_OnEnterEditMode(gridId,tblName,editObject)
    {
        
//        //debugger;
        var row = wgGetGridById(gridId).GetSelectedObject().GetRowElement();
        var ParamName = wgGetCellByName(row, "Parameter Name"); 
        var ParamNo = wgGetCellByName(row, "ParamNo");
        var DataType = wgGetCellByName(row, "Type/DataType");
        var Serialize = wgGetCellByName(row, "vSerialize");
        var Values = wgGetCellByName(row, "vValues");

        var Level = wgGetCellByName(row, "Level");
        
        var pVal=Values.hiddenData1;
        if(pVal==null)
            pVal="";

        var URLParams = "&ParamNo=" + ParamNo.innerText + "&ParamName=" + ParamName.innerText + "&DataType=" + DataType.innerText + "&Serialize=" + Serialize.innerText + "&Values=" + pVal + "&Level=" + Level.innerText;
        //var URLParams = "&ParamNo=" + ParamNo.innerText + "&ParamName=" + ParamName.innerText + "&DataType=" + DataType.innerText + "&Serialize=" + Serialize.innerText + "&Values=Variable/Variable.SubmittedBy.Last Name,Variable.SubmittedBy.LastName";


//        var Id=cellName.hiddenData1;
//        var Name=cellName.innerText;
//        var cellDisplayName = wgGetCellByName(row, "DisplayName");
//        var DisplayName=cellDisplayName.innerText;
//        var cellType=wgGetCellByName(row, "Type");
//        var Type=cellType.innerText;
//        var CellDefaultValue=wgGetCellByName(row, "DefaultValue");
//        var DefaultValue=CellDefaultValue.innerText;
//        
//        EditWorkItemField(Id,Name,DisplayName,Type,DefaultValue);             
          //window.open("EditWSMethodParams.aspx");
//alert("URL: " + location.href+ URLParams);
          var u=location.href;
          
          //u=GetURL(u);
          u=u+URLParams;
          u=EditFieldValue(u);
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
    
    function EditWorkItemField(id,name,dispname,type,defvalue)
    {
      //var urlparameters='&WrkItmMode=edit&Id='+id+'&Name='+name+'&DisplayName='+dispname+'&Type='+type+'&DefaultValue='+defvalue;          
      //mywindow = window.open (EditWorkItemFieldUrl(location.href+ urlparameters ), "WinWorkItemFields", "location=0, status=0, scrollbars=0, width=545, height=210, resizable=yes" );      
      mywindow.moveTo(0,0);
      mywindow.focus();
      return false;
     }          
          
    function EditFieldValue( currentUrl ) 
    {
        if( currentUrl.indexOf('?') >= 0 ) 
        {
            currentUrl += '&';
        }
        else 
        {
            currentUrl += '?';
        }
        
        currentUrl += 'div=divFieldValue';

        return currentUrl;
    }
    function Button4_Click()
    {
        alert("Testing");
        //alert(document.getElementById('hRowVal').value);
    } 
    
    function openhelpinpdmode()
     {        
        window.open('<%=PdCtrl.GetHelpPageUrl()%>WebService-WebServiceDetails.html','','height=450,width=600,resizable=yes,status=no,scrollbars=yes');
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
    
    
    </script>    

    
    
</body>
</html>
