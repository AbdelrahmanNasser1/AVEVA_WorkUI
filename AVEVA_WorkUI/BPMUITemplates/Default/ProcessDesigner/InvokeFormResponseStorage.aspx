<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvokeFormResponseStorage.aspx.cs" Inherits="SkeltaTemplates_Default_ProcessDesigner_InvokeFormResponseStorage"  Theme="" StylesheetTheme="" %>
<%@ Register TagPrefix="cc1" Namespace="Workflow.NET.Ajax" Assembly="Workflow.NET.NET2" %>
<link rel="stylesheet" type="text/css" href="<%=ProcessDesignerControl.GetThemeRelativeUrl("Common/stylesheet/Global.css")%>">
<html >
<head id="Head1" runat="server">
	<title><%=_workflowName%>-<%=_actionName%>-<%=_propertyName%></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
</head>	
<link href="<%=ProcessDesignerControl.GetCommonRelativeUrl("/stylesheet/global.css")%>" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='<%=_commonjScriptPath%>'></script>
<script type='text/javascript' src='<%=_jScriptPath%>'></script>
<script type='text/javascript' src='<%=_jScriptPathHelp%>'></script>
<script type='text/javascript' src='<%=_xmlTreejScriptPath %>'></script>
 <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
<body leftmargin="0px" topmargin="0px" rightmargin="0px" bottommargin="0px" style="overflow:hidden;"  >

     <script>

         se.ui.messageDialog.setGlobalOptions({
             localization: {
                 closeButtonCaption: "<%=_rs.GetString("se_ui_messagedialog_close_caption") %>",
                 okButtonCaption: "<%=_rs.GetString("se_ui_messagedialog_ok_caption") %>",
                 cancelButtonCaption: "<%=_rs.GetString("se_ui_messagedialog_cancel_caption") %>",
                 showDetailsCaption: "<%=_rs.GetString("se_ui_messagedialog_showdetails_caption") %>",
                 hideDetailsCaption: "<%=_rs.GetString("se_ui_messagedialog_hidedetails_caption") %>"
             }
         });

         function DisplayMessage() {
             var strMessage = '<%=_outputXmlErr%>';
             var strHeader = '<%=_actionName%> -<%=_rs.GetString(_propertyName)%>';
             se.ui.messageDialog.showError(strHeader, strMessage);
 }

</script>

    <form id="form1" runat="server"  > 
	<%=System.Web.Helpers.AntiForgery.GetHtml()%>
     <link rel="stylesheet" type="text/css" href="<%=ProcessDesignerControl.GetThemeRelativeUrl("CommonUXControls/StyleSheet/se.ui.min.css")%>">  
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr valign="top">                  
          <td  valign="middle" style="padding-left:10px;padding-top:10px;">
          <span class="subtitle"> <%=_actionName%>-<%=_rs.GetString(_propertyName)%></span></td>
          <td  valign="middle"><span title="<%=_rs.GetString("Help")%>" ><img src="<%=ProcessDesignerControl.GetCommonRelativeUrl("Images/main-help.gif")%>" align="right" <%=_helpimagetags%> style="cursor:pointer" alt="<%=_rs.GetString("Help")%>"/></span></td>
        </tr>
       
          <tr >
            <td style="width: 99%;padding-left:10px;padding-right:10px;" valign="top" class="tdbg" colspan="2" > 
		         <table width="100%" border="0" cellspacing="0" cellpadding="1" >
		             <tr><td>&nbsp;</td></tr>
                      <tr>
                        <td class="lefttdbg" >
                            <table width="95%"  cellspacing="1" cellpadding="1" border="0">
                                <tr>
                                    <td>
                                        <span class="description"> <%=_rs.GetString("AdvancedResponseStorage_Description") %></span>
                                    </td>
                                </tr>
                            </table>
                            
                        </td>
                    </tr>                
                    <tr>
                    <td>
                         <table width="95%" height="95%" cellspacing="1" cellpadding="3" border="0" class="tablebg">
	                        <tr>
	                            <td  valign="top" class="lefttdbg " width="50%">
	                            <span class="subtitle"> <%=_rs.GetString("AdvancedResponseStorage_IndividualRespNode_Title") %></span>
	                            <br /><br /><span class="description"><%=_rs.GetString("AdvancedResponseStorage_IndividualRespNode_Desc") %></span>
			                    </td>
				                <td class="righttdbg" valign="middle">
				                    <input value=""  class="inputselect"  readonly id="cmbResponse_Input<%=_CtrlID%>" name="cmbResponse_Input<%=_CtrlID%>"  style="width:250px;" onclick="HandleToggleTreeView('R')" onmouseenter="javascript:ShowAlttext(this)"  onkeydown="javascript:HideAlttext(this)" onmousedown="javascript:HideAlttext(this)" onmouseleave="javascript:HideAlttext(this)" onmouseout="javascript:HideAlttext(this)" onfocusout="javascript:HideAlttext(this)"/>
				                    <input id='hidMode' name='hidMode' class='inputtext' type="hidden" />
                                 </td> 
	                        </tr>
	                         <tr>
	                            <td  valign="middle" class="lefttdbg " width="50%">
	                            <span class="subtitle"> <%=_rs.GetString("AdvancedResponseStorage_AllActorsRespNode_Title") %></span>
	                            <br /><br /><span class="description"><%=_rs.GetString("AdvancedResponseStorage_AllActorsRespNode_Desc") %></span>
	                            
			                    </td>
				                <td class="righttdbg" valign="middle"><!-- <span id="spnAllActorRespNodeErr"  class="errormsg"><%=_outputXmlErr %></span>--><br />
				                    <input value="" class="inputselect" id="cmbAppendTo_Input<%=_CtrlID%>"  readonly name="cmbAppendTo_Input<%=_CtrlID%>"  style="width:250px;" onclick="HandleToggleTreeView('O')" onmouseenter="javascript:ShowAlttext(this)"  onkeydown="javascript:HideAlttext(this)" onmousedown="javascript:HideAlttext(this)" onmouseleave="javascript:HideAlttext(this)" onmouseout="javascript:HideAlttext(this)" onfocusout="javascript:HideAlttext(this)"/>
                                 </td> 
	                        </tr>	                        
				          </table>
		                    <div id="treeDiv" style="position:absolute; visibility: hidden; border: solid 1px; width:250px; background: white; height: 150px;overflow:auto"></div>
                            <iframe id="IframeShim" scrolling="no"	frameborder="no"	style="position:absolute; top:0px; left:0px; display:none;"></iframe>
                            <div id="bubbleWindow" style="border: 1px solid black; cursor: text;font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10px; text-align: left;display:none"></div>
                     </td>
                 </tr>
                 <tr><td>&nbsp;</td></tr>
                 </table>
             </td>
          </tr>
                 
         <tr>
             <td colspan="2">
               <table width="100%" border="0" cellspacing="0" cellpadding="3" border="3">
                 <tr>
                    <td id="Td2" style="text-align:right;padding-top:10px;">
                        <input type="button" id="btnCancel" name="btnCancel" value="<%=_rs.GetString("AdvancedResponseStorage_BtnCancel")%>" onClick="javascript:ClearStorage();document.forms[0].submit();window.opener.parent._skProcessDesigner.RefreshProperties();" class="inputsecondarybutton">
                        <input type="button" id="btnOk" name="btnOk" value="&nbsp;&nbsp;<%=_rs.GetString("OK")%> &nbsp;&nbsp;" class="inputbutton" onclick="javascript: if (ValidateSubmit()) { document.forms[0].submit(); window.opener.parent._skProcessDesigner.RefreshProperties(); }">
                        &nbsp;
                    </td>
                 </tr>
               </table>                        
             </td>
          </tr>
    </table>         
<cc1:ajaxpagecontrol id="AjaxPageControl1" runat="server" style="Z-INDEX: 104; LEFT: 440px; POSITION: absolute; TOP: 88px"></cc1:ajaxpagecontrol>

</form>
</body>
</html>
<script language="javascript">
    
    
     CmbIMG_PLUS = "<%=_cmnDirForImages %>/Images/btnPlus.gif";
     CmbIMG_MINUS ="<%=_cmnDirForImages %>/Images/btnMinus.gif";
     CmbangleImage="<%=_cmnDirForImages %>/Images/angle.gif";
   
    CmbimgPlus.src = CmbIMG_PLUS;
    CmbimgMinus.src = CmbIMG_MINUS;

    var bubbleWindowObj = document.getElementById("bubbleWindow");
    var iframeObjBubble = document.getElementById("IframeShim");
    var CmbDIR_IMAGES="<%=_cmnDirForImages%>";
        
    function HideAlttext()
		{

		    bubbleWindowObj.innerHTML	= "";
		    bubbleWindowObj.style.display="none";
		    iframeObjBubble.style.visibility = "hidden";
		} 
		function ShowAlttext(textObject)
		{
		    var altText="";
		    var x =findPosX(textObject);
		    var y =findPosY(textObject);

		    if(textObject.value=="")
		    	return false;
		    else
		    	altText = textObject.value;

			iframeObjBubble.style.visibility = "visible";
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
		
		
		function HandleToggleTreeView(inputBox)
		{
		    if(inputBox=="R" && "<%=_formXmlErr %>"=="")
		        {
		        defaultInputCtrlForTreeView="cmbResponse_Input";
                defaultImageCtrlForTreeView="cmbResponse_Image";
                
                 document.getElementById("treeDiv").innerHTML ="";
                 <%=_formXmlTree%>;
                eval("obj<%=_formIdForDOM%>.buildDOM('treeDiv')");  
                //_outputXMLNameForDOM
                 var strInnerHTML = document.getElementById("treeDiv").innerHTML;
                 document.getElementById("treeDiv").innerHTML = strInnerHTML.replace("<DIV><DIV>","");
                 document.getElementById("hidMode").value = inputBox;  
                 ToggleTreeView("<%=_CtrlID%>");   
               
		        }
		    else if(inputBox=="O" && "<%=_outputXmlErr %>"=="") 
		        {
		            defaultInputCtrlForTreeView="cmbAppendTo_Input";
                    defaultImageCtrlForTreeView="cmbAppendTo_Image";
                    
                    document.getElementById("treeDiv").innerHTML ="";
                   <%=_outPutXmlVarXmlTree%>;
                   eval("obj<%=_outPutXMLVarName%>.buildDOM('treeDiv')");  
                   //_outputXMLNameForDOM
                   var strInnerHTML = document.getElementById("treeDiv").innerHTML;
                   document.getElementById("treeDiv").innerHTML = strInnerHTML.replace("<DIV><DIV>","");
                    document.getElementById("hidMode").value = inputBox;   
                    ToggleTreeView("<%=_CtrlID%>");  
		        }
            
		   
		    
		}
		
		function LoadTreeview(dataType,clickedNode,xpath)
        {
        
            var inputBox = document.getElementById("hidMode").value;
            if(inputBox=="R")
                document.getElementById("cmbResponse_Input<%=_CtrlID%>").value = xpath.replace(/[$]/g,".").substring(2);
            else if(inputBox=="O") 
                document.getElementById("cmbAppendTo_Input<%=_CtrlID%>").value = xpath.replace(/[$]/g,".").substring(2);
            ToggleTreeView("<%=_CtrlID%>");
           
            //CallServerSideMethod(null, 'LoadTreeForXPath',"DataTableTest",CallbackLoadTreeForXPath,'table',sendObj);
        }
        
        function ToggleRadio(objChkBox,divCtrlName)
        {
            if(objChkBox.checked)
            {
                //document.getElementById(radioCtrlName).attributes.setNamedItem("disabled","0");
                document.getElementById(divCtrlName).style.display = 'block';
            }
            else
                document.getElementById(divCtrlName).style.display = 'none';
        
        }
        
        function ValidateSubmit()
        {
            var responseNode = trim(document.getElementById("cmbResponse_Input<%=_CtrlID%>").value);
            var appendToNode=trim(document.getElementById("cmbAppendTo_Input<%=_CtrlID%>").value);
            if(responseNode != "" || appendToNode != "")
            {
                if(responseNode =="")
                {
                  //  alert("<%=_indResponseNodeEmpty%>");
                    se.ui.messageDialog.showError("<%=_actionName%>-<%=_rs.GetString(_propertyName)%>", "<%=_indResponseNodeEmpty%>");
                    document.getElementById("cmbResponse_Input<%=_CtrlID%>").focus();
                    return false;
                }
                if(appendToNode=="")
                {
                    // alert("<%= _appendNodeEmpty %>");
                    se.ui.messageDialog.showError("<%=_actionName%>-<%=_rs.GetString(_propertyName)%>", "<%=_appendNodeEmpty%>");
                     document.getElementById("cmbAppendTo_Input<%=_CtrlID%>").focus();
                    return false;
                }
            }
            return true;
        }
        
        function ClearStorage()
        {
            document.getElementById("cmbResponse_Input<%=_CtrlID%>").value = "";
            document.getElementById("cmbAppendTo_Input<%=_CtrlID%>").value = "";
        }
        
        
        if("<%=_formXmlErr %>"!="")
            document.getElementById("cmbResponse_Image").disabled =true;
           
            
        if("<%=_outputXmlErr %>"!="")
            document.getElementById("cmbAppendTo_Image").disabled =true;
            
         if("<%=_indResponseNode%>"!="")
            document.getElementById("cmbResponse_Input<%=_CtrlID%>").value = "<%=_indResponseNode%>";
            
         if("<%=_allActResponseNode%>"!="")
            document.getElementById("cmbAppendTo_Input<%=_CtrlID%>").value = "<%=_allActResponseNode%>";

    if ("<%=_indResponseNodeUpdatedSuccessfully%>" == 1)
        window.close();

</script>


