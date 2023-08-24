<%@ Control Language="c#" AutoEventWireup="false" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" inherits="Workflow.NET.Template.ControlScriptEB"%>
<%@ Assembly Name="Telerik.Web.UI" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>


 <telerik:RadScriptBlock ID="RadScriptBlock3" runat="server">
        <link href="<%=expressionControl.GetThemeRelativeUrl("Common/StyleSheet/Global.css")%>" rel="stylesheet" />
        <script src="<%:expressionControl.GetJscriptUrl("javascript/ExpressionBuilderLatest.js")%>"></script>
        <link href="<%=expressionControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/SkeltaEditor/Editor.css")%>" rel="stylesheet" />
        <link href="<%=expressionControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/SkeltaEditor/Window.css")%>" rel="stylesheet" type="text/css" /> 
        <link href="<%=expressionControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/SkeltaEditor/Window.SkeltaEditor.css")%>" rel="stylesheet" type="text/css" />  
        <link href="<%=expressionControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/SkeltaEditor/Editor.SkeltaEditor.css")%>" rel="stylesheet" />
        <link href="<%=expressionControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTTreeView/TreeView.AWTTreeView.css")%>" rel="stylesheet" />
        <link href="<%=expressionControl.GetThemeRelativeUrl("CommonUXControls/StyleSheet/se.ui.min.css")%>" rel="stylesheet" />        
</telerik:RadScriptBlock>

<script src="../Common/JavaScripts/jquery.min.js"></script>
<script src="../Common/JavaScripts/AutoLogoff.js"></script>
<script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>


<script type="text/JavaScript">
<!--
    function MM_swapImgRestore() { //v3.0
        var i, x, a = document.MM_sr; for (i = 0; a && i < a.length && (x = a[i]) && x.oSrc; i++) x.src = x.oSrc;
    }

    function MM_preloadImages() { //v3.0
        var d = document; if (d.images) {
            if (!d.MM_p) d.MM_p = new Array();
            var i, j = d.MM_p.length, a = MM_preloadImages.arguments; for (i = 0; i < a.length; i++)
                if (a[i].indexOf("#") != 0) { d.MM_p[j] = new Image; d.MM_p[j++].src = a[i]; }
        }
    }

    function MM_findObj(n, d) { //v4.01
        var p, i, x; if (!d) d = document; if ((p = n.indexOf("?")) > 0 && parent.frames.length) {
            d = parent.frames[n.substring(p + 1)].document; n = n.substring(0, p);
        }
        if (!(x = d[n]) && d.all) x = d.all[n]; for (i = 0; !x && i < d.forms.length; i++) x = d.forms[i][n];
        for (i = 0; !x && d.layers && i < d.layers.length; i++) x = MM_findObj(n, d.layers[i].document);
        if (!x && d.getElementById) x = d.getElementById(n); return x;
    }

    function MM_swapImage() { //v3.0
        var i, j = 0, x, a = MM_swapImage.arguments; document.MM_sr = new Array; for (i = 0; i < (a.length - 2) ; i += 3)
            if ((x = MM_findObj(a[i])) != null) { document.MM_sr[j++] = x; if (!x.oSrc) x.oSrc = x.src; x.src = a[i + 2]; }
    }
    //-->
</script>
<telerik:RadCodeBlock ID="RadScriptBlock1" runat="server">
<script>
    
        MM_preloadImages('<%=expressionControl.GetThemeRelativeUrl("Expression/images/b-pin-over.gif")%>');
    
</script>
    </telerik:RadCodeBlock>
<telerik:RadCodeBlock ID="RadScriptBlock2" runat="server">
<script>
    
    // Initialize locales for message dialog
    se.ui.messageDialog.setGlobalOptions({
        localization: { // All localization related default can be set
            closeButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                    okButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                    cancelButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                    showDetailsCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                    hideDetailsCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
                }
    });

    function ShowMessagesWithBellyBar(messageType, messageToDisplay)
    {
        var bellyBarTitle = "<%=resManager.GlobalResourceSet.GetString("Title_Expression_Editior") %>"; 
        switch (messageType)
        {
            case 1: se.ui.messageDialog.showAlert(bellyBarTitle, messageToDisplay);
                break;
            case 2: se.ui.messageDialog.showError(bellyBarTitle, messageToDisplay);
                break;
        }
    }
   
  
</script>
     </telerik:RadCodeBlock>
<table width=100% border=0 align=center cellpadding="0" cellspacing="0" ID="Table1">
<tr>
<td >
	<table border=0 width=100% align=center ID="Table2" cellpadding="0" cellspacing="1">
		
		<tr>
		  <td height=25 width=38 rowspan=2 valign="top" style="padding-bottom:10px;padding-top:10px;">
              <telerik:RadCodeBlock ID="RadCodeBlock2" runat ="server">
              <img src="<%=expressionControl.GetThemeRelativeUrl("Expression/Images/object-browser-icon.gif")%>" onmouseover="Handlewindows('right')"  onclick="Handlewindows('right')"  alt ="<%=expObjectBrowser%>" style="cursor:Hand">
                  </telerik:RadCodeBlock>
		  </td>
			<!--div id="explorerDiv" style="display:none">		    </div-->
			<td width=100% align="right" class="fontHeading" id="treeviewLabelTD" style="padding-bottom:10px;padding-top:10px;" >
				<div id="ExpTreeLabelDiv">
				<table border=0 width=100% cellspacing=0 cellpadding=0 class="">
					<tr>
						<td width="83%" align="left" class="pagetitle">
                            <telerik:RadCodeBlock ID="RadCodeBlock1" runat ="server">
                            &nbsp;<%=expObjectBrowser%>
                                </telerik:RadCodeBlock>
                                </td>
						<td width="13%" align="center">
                            <telerik:RadCodeBlock ID="RadCodeBlock3" runat ="server">
                            <a href="#" style="cursor:Hand" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','<%=expressionControl.GetThemeRelativeUrl("Expression/graphics/icon-refresh-mouse-over.gif")%>',2)" onclick="javascript:window.location.reload();">
                                <img src="<%=expressionControl.GetThemeRelativeUrl("Expression/graphics/refresh-over.gif")%>" alt="<%=expRefresh%>" width="19" height="17" border=0 id="Image3" /> 
                            </a>
                                </telerik:RadCodeBlock>
						</td>						
					    <td width="7%" align="center" valign="middle">
                            <telerik:RadCodeBlock ID="RadCodeBlock4" runat ="server">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','<%=expressionControl.GetThemeRelativeUrl("Expression/graphics/b-pin-over.gif")%>',1)">
                            <img src="<%=expressionControl.GetThemeRelativeUrl("Expression/graphics/icon-PIN-mouse-over.gif")%>" name="Image1" width="19" height="17" border="0" id="Image1" style="cursor:Hand" onClick="Handlewindows('left')" alt="<%=expAutoHide%>" /></a>
                                </telerik:RadCodeBlock>
                                </td>
					    <td width="7%" align="center" valign="middle">&nbsp;</td>
					</tr>		
				</table>	
				</div>
		  </td>	
			<td width="2" rowspan="2" >
	      </td>
			<td id="EditorLabelTD1" style="padding-bottom:10px;padding-top:10px;width:100%;">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="15%" class="description" id="EditorLabelTD3" >
                            <telerik:RadCodeBlock ID="RadCodeBlock5" runat ="server">
                            <img src="<%=expressionControl.GetThemeRelativeUrl("Expression/Images/Editor-icon.gif")%>" align="absmiddle" />&nbsp;<%=expEditor%>
                            </telerik:RadCodeBlock>
                        </td>
                        <td width="45%" colspan=2  id="EditorLabelTD">
                            <telerik:RadCodeBlock ID="RadCodeBlock6" runat ="server">
                            <script type="text/javascript">
                                var goleftimage = '<%=expressionControl.GetThemeRelativeUrl("Expression/graphics/right-01.gif")%>';
                                var gorightimage = '<%=expressionControl.GetThemeRelativeUrl("Expression/graphics/left-01.gif")%>';
                                var gorigbgimage = '<%=expressionControl.GetThemeRelativeUrl("Expression/graphics/top-bg-01.gif")%>';
                                //configure menu width (in px):
                                var menuwidth = 180
                                //configure menu height (in px):
                                var menuheight = 25
                                //Specify scroll buttons directions ("normal" or "reverse"):
                                var scrolldir = "normal"
                                //configure scroll speed (1-20), where larger is faster
                                var scrollspeed = 8
                                //specify menu content
                                var menucontents = '<nobr>&nbsp;<a href="#" class="inputbutton" style="text-decoration:none" onclick=javascript:AssignOperator("+")>&nbsp;+&nbsp;</a>&nbsp;<a href="#" class="inputbutton" style="text-decoration:none" onclick=javascript:AssignOperator("-")>&nbsp;-&nbsp;</a>&nbsp;<a href="#" style="text-decoration:none" class="inputbutton" onclick=javascript:AssignOperator("/")>&nbsp;/&nbsp;</a>&nbsp;<a href="#" style="text-decoration:none" class="inputbutton" onclick=javascript:AssignOperator("*")>&nbsp;*&nbsp;</a>&nbsp;<a href="#" class="inputbutton" style="text-decoration:none" onclick=javascript:AssignOperator("(")>&nbsp;(&nbsp;</a>&nbsp;<a href="#" class="inputbutton" style="text-decoration:none" onclick=javascript:AssignOperator(")")>&nbsp;)&nbsp;</a>&nbsp;<a href="#" class="inputbutton" style="text-decoration:none" onclick=javascript:AssignOperator("&amp;")>&nbsp;&&nbsp;</a>&nbsp;<a href="#" style="text-decoration:none" class="inputbutton" onclick=javascript:AssignOperator("|")>&nbsp;|&nbsp;</a></nobr>'
                                ////NO NEED TO EDIT BELOW THIS LINE////////////

                                var iedom = document.all || document.getElementById
                                var leftdircode = 'onMouseover="moveleft()" onMouseout="clearTimeout(lefttime)"'
                                var rightdircode = 'onMouseover="moveright()" onMouseout="clearTimeout(righttime)"'
                                if (scrolldir == "reverse") {
                                    var tempswap = leftdircode
                                    leftdircode = rightdircode
                                    rightdircode = tempswap
                                }
                                if (iedom)
                                    document.write('<span id="temp" style="visibility:hidden;position:absolute;top:-100;left:-5000">' + menucontents + '</span>')
                                var actualwidth = ''
                                var cross_scroll, ns_scroll
                                var loadedyes = 0
                                function fillup() {
                                    if (iedom) {
                                        cross_scroll = document.getElementById ? document.getElementById("test2") : document.all.test2
                                        cross_scroll.innerHTML = menucontents
                                        actualwidth = document.all ? cross_scroll.offsetWidth : document.getElementById("temp").offsetWidth
                                    }
                                    else if (document.layers) {
                                        ns_scroll = document.ns_scrollmenu.document.ns_scrollmenu2
                                        ns_scroll.document.write(menucontents)
                                        ns_scroll.document.close()
                                        actualwidth = ns_scroll.document.width
                                    }
                                    loadedyes = 1
                                }
                                window.onload = fillup

                                function moveleft() {
                                    if (loadedyes) {
                                        if (iedom && parseInt(cross_scroll.style.left) > (menuwidth - actualwidth)) {
                                            cross_scroll.style.left = parseInt(cross_scroll.style.left) - scrollspeed + "px"
                                        }
                                        else if (document.layers && ns_scroll.left > (menuwidth - actualwidth))
                                            ns_scroll.left -= scrollspeed
                                    }
                                    lefttime = setTimeout("moveleft()", 50)
                                }

                                function moveright() {

                                    if (loadedyes) {
                                        if (iedom && parseInt(cross_scroll.style.left) < 0)
                                            cross_scroll.style.left = parseInt(cross_scroll.style.left) + scrollspeed + "px"
                                        else if (document.layers && ns_scroll.left < 0)
                                            ns_scroll.left += scrollspeed
                                    }
                                    righttime = setTimeout("moveright()", 50)
                                }

                                if (iedom || document.layers) {
                                    with (document) {
                                        write('<table border="0" cellspacing="0" cellpadding="0">')
                                        write('<td><a href="#" ' + rightdircode + '><img src="' + goleftimage + '"border=0></a> </td>')
                                        write('<td width=' + menuwidth + 'px>')
                                        if (iedom) {
                                            write('<div style="position:relative;width:' + menuwidth + 'px;height:' + menuheight + 'px;overflow:hidden;">')
                                            write('<div id="test2" style="position:absolute;left:0;top:0;">')
                                            write('</div></div>')
                                        }
                                        else if (document.layers) {
                                            write('<ilayer width=' + menuwidth + ' height=' + menuheight + ' name="ns_scrollmenu">')
                                            write('<layer name="ns_scrollmenu2" left=0 top=0></layer></ilayer>')
                                        }
                                        write('</td>')

                                        write('<td><a href="#" ' + leftdircode + '>')
                                        write('<img src="' + gorightimage + '"border=0></a>')
                                        write('</td></table>')
                                    }
                                }

                    </script>
                                </telerik:RadCodeBlock>
                        </td>
                    <td width="25%" class="description" align=right ><asp:Label ID="returnTypeString" runat="server"> Return Type:-</asp:Label></td>
                        <td width="13%" style="text-align:right;">   
                             <asp:DropDownList ID="expReturnType" CssClass="inputselect" runat="server" Height="25px" Width="150px">                       
                             </asp:DropDownList>
                        </td>
                        <td style="width:5%;text-align:right;">
                            <telerik:RadCodeBlock ID="RadCodeBlock7" runat ="server">
                            <a href="#" onclick="javascript:window.open('<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(expressionControl.GetHelpPageUrl(), false)%>UsingExpressionEditorToBuildExpressionsForProperties.html','newwin','width=650,height=500,scrollbars=yes,resizable=yes')">
                                <img border="0" src="<%:expressionControl.GetCommonRelativeUrl("Images/main-help.gif")%> "  align="right"  style="cursor:pointer"  alt="<%= HelpIcon %>"/>
                            </a>
                                </telerik:RadCodeBlock></td>
                      </tr>
                 </table>
			</td>	
		</tr>
		<tr>
			<td width=100% height="100%" valign=top  bgcolor="#FFFFFF" id="treeviewTD">
			  <div id="ExpTreeDiv">
			  <table width=100% border=0 align=center cellpadding="0" cellspacing="0" ID="Table3">
				<tr>
                    <telerik:RadCodeBlock ID="RadCodeBlock8" runat="server">
					<td valign=top background="<%=expressionControl.GetThemeRelativeUrl("expression/graphics/tree-bg.gif")%>">
                        </telerik:RadCodeBlock>
						<table width=100% border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td class="tdbg">
								   <div id="RadTreeDiv" style="width:260px;height:395px;overflow:auto;">
								    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server"  EnableAJAX=true>
                                        
									    <telerik:RadTreeView id="RadTree1"  Height="100%" style="overflow:visible"
										    Width="100%" 
										    Skin="AWTTreeView"										    								   
										    OnClientNodeDragStart="mystartdraghandler" OnClientNodeClicked="mystartdraghandler"
										    AfterClientToggle="AfterToggleHandler" EnableDragAndDrop="true"										    
										    runat="server" ShowLineImages="false" EnableEmbeddedSkins="false">	
									    </telerik:RadTreeView>							                                            

								     </telerik:RadAjaxPanel> 
								     </div> 
								</td>
							</tr>
					  </table>
					</td>
				</tr>				
			
		  </table>					
		  </div>			</td>
			<td height="98%" width="100%" colspan="2" valign="top" bgcolor="#FFFFFF" clas="tdbg" id="EditorTD" >
                <telerik:RadCodeBlock ID="RadCodeBlock9" runat="server">
				    <table border=0 width="100%" cellpadding="0" cellspacing="0" background="<%=expressionControl.GetThemeRelativeUrl("expression/graphics/center-bg.gif")%>">
                        </telerik:RadCodeBlock>
						<tr>
                            <script>
                                function OnClientLoad(editor) {
                                    editor.AttachEventHandler("ondrop", function (e) {
                                        return false;
                                    }
                                    );
                                }
                            </script>                 

						  <td align="left" valign="top" bgcolor="#FFFFFF" class="EditableDiv">
						  <telerik:RadEditor ID="RadEditor1" Runat="server"   
							Width="530px" Height="395px"  
							EditModes="Design"  Skin="SkeltaEditor"														
							ToolsFile="<%$ ReplaceTemplateExpn:Expression/Editor/ToolsFile.xml%>" 						 							
							EnableContextMenus="true" EnableEmbeddedSkins="false" DialogsCssFile="<%$ ReplaceTemplateExpn:TelerikAjax/StyleSheet/SkeltaEditor/DialogCSS.css%>">
						 </telerik:RadEditor></td>
						</tr>
				</table>			 </td>
		</tr>
	</table>
	</td>
</tr>
<tr>
    <td><table width=100% border=0 cellpadding=3 cellspacing=0 >
      <tr>
        <td width="20%" valign=top style="padding-left:25px;padding-top:15px;">
            <telerik:RadCodeBlock ID="RadCodeBlock11" runat="server">
            <a href="#" id="errorLink" Onclick="javascript:OpenDiv(1)" onMouseOver="javascript:OpenDiv(1)" class="ErrorHyperlinkStyle">
            <%=expErrorList%></a></telerik:RadCodeBlock></td>
        <td width="80%"  style="text-align:right;padding-top:10px;" >
<telerik:RadCodeBlock ID="RadCodeBlock12" runat="server">
          <a href="#" id="A1" Onclick="javascript:ClickView();" class="a"><img src="<%:expressionControl.GetTemplateRelativeUrl("Images/icon-compile-code.png")%>" border="0" align="absmiddle"><%=viewCode%></a>&nbsp;</telerik:RadCodeBlock>
            <telerik:RadCodeBlock ID="RadCodeBlock13" runat="server">
         <input type="button" class="inputsecondarybutton"  id="btnCancel" name="btnCancel" value="<%=buttonCancel%>" onClick="window.close();">
                </telerik:RadCodeBlock>
          &nbsp;
            <telerik:RadCodeBlock ID="RadCodeBlock14" runat="server">
              <input type="button" class="inputbutton" id="btnClearEditor" name="btnClearEditor" value="&nbsp;&nbsp;<%=buttonClear%>&nbsp;&nbsp;" onClick="javascript: ClearEditor();">
                </telerik:RadCodeBlock>
		  &nbsp;
            <telerik:RadCodeBlock ID="RadCodeBlock15" runat="server">
		  <input type="button" class="inputbutton" id="btnOk" name="btnOk" value="&nbsp;&nbsp;<%=buttonOK%>&nbsp;&nbsp;" onClick="javascript: ClickOK();">
                </telerik:RadCodeBlock>
		  
         
         <div id="ErrorDiv" class="description" style="border:1px solid #256194;"></div></td>
        </tr>
    </table>
	</td>
</tr>		
</TABLE>	
<input type="Hidden" id="extNodeKey" name="extNodeKey" />
<input type="Hidden" id="extNodeValue" name="extNodeValue"/> 

<div id="bubbleDiv" style="Overflow: auto;CURSOR: text; font-family: Verdana, Arial, Helvetica, sans-serif;	font-size: 12px; TEXT-ALIGN:center;
	BORDER-RIGHT: #9FBDDC thin solid; 
	BORDER-TOP: #9FBDDC thin solid; 
	BORDER-LEFT: #9FBDDC thin solid; 
	BORDER-BOTTOM: #9FBDDC thin solid;"/>	
<telerik:RadCodeBlock ID="RadCodeBlk1" runat="server">	
<script>
    
    newAssmblyUrl = "<%=newAssmblyUrl%>";
    editor = $find("<%=RadEditor1.ClientID%>");    
    controlName = "<%=expressionControl.ID%>";
    parentControlName = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(controlName, false)%>";

    editorCtlName = "<%=RadEditor1.ClientID%>";
    

    DisableEditorTools();
    InitializeExpressionEditor();
    TempRetType = "<%=expReturnType.ClientID%>";
    referenceList = '<%=expressionControl.Referencelist%>';

    
    var closeImg = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(closeImage, false)%>";
    var errorIcon = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(errorIcon)%>";
    var backgroundImg = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(backgroundImg, false)%>";
    var compileCodeImage = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(compileCodeImage, false)%>"
    var extUIurl = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(extUIurl, false)%>";
    var errorGif = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(errorGif, false)%>";
    var divLineObj;

    var popupWidth = window.document.body.offsetWidth;
    var popupHeight = window.offsetHeight;//window.document.body.offsetHeight;
    var operdivobj;
    var boundaryX = 420;
    eFrame = window.document.getElementById(controlName + "_ctl01_RadEditor1");
   
    findPos(eFrame);


    //Localized
    expErrinExpression = "<%=expErrinExpression%>";
expErrorAlertforExpression = "<%=expErrorAlertforExpression %>";
    expPlaceHoderValidationMsg = "<%=expPlaceHoderValidationMsg%>";
    expErrorstext = "<%=expErrorstext%>";
    expCompiledCode = "<%=expCompiledCode %>";
    expCodeInExpression = "<%=expCompiledCode %>";
    function resizeObjectList(objHeight, objWidth) {
        top.frames[0].resizeTree(objHeight, objWidth);
    }

    Sys.Application.add_load(function ()
    {
        editor = $find("<%=RadEditor1.ClientID%>"); //get a reference to RadEditor's client object
        
    }
);


</script>
</telerik:RadCodeBlock>
<telerik:RadCodeBlock ID="RadCodeBlock10" runat="server">
<script>

    function ClickOK()
    {

        var expEditor = GetExpressionEditor("<%=expressionControl.ID%>");
        expEditor.BuildExpression();
}

function ClickView() {
    var expEditor = GetExpressionEditor("<%=expressionControl.ID%>");
    expEditor.BuildAndViewExpression();
}

function ClearEditor() {
    var expEditor = GetExpressionEditor("<%=expressionControl.ID%>");
    expEditor.ClearEditor();
}

function DisableButton() {
    var btnObj = document.getElementById("btnOk");
    btnObj.disabled = true;
}






function resizePage1() {
    if (browserCode == "1")
    {
        popupWidth = document.body.offsetWidth;
        popupHeight = document.body.offsetHeight;
        editorwidth = editor.get_element().style.width;
        editorHeight = editor.get_element().style.height;

        if (popupHeight < 50)
            return false;
        else {
            if (editorwidth != 0)
            {
                editorwidth = parseInt(popupWidth) * 0.66905;
                editorHeight = parseInt(popupHeight) - 49;
                objectListFrameWidth = parseInt(popupWidth) * 0.3;
                document.getElementById(RadTreeObj).style.height = (parseInt(popupHeight)) - 49;
                document.getElementById(RadTreeObj).style.width = objectListFrameWidth;//ObjectListObj
                editor.setSize(editorwidth, editorHeight);
            }
        }
    }
    else if (browserCode == "2") {
        popupWidth = document.body.clientWidth;
        popupHeight = document.documentElement.clientHeight;
        editorwidth = editor.get_element().style.width;
        editorHeight = editor.get_element().style.height;

        editor.setSize(parseInt(popupWidth * 0.6247), parseInt(popupHeight * 0.919));

        document.getElementById(RadTreeObj).style.height = parseInt(popupHeight * 0.919) + "px";
        document.getElementById(RadTreeObj).style.width = parseInt(popupWidth * 0.35) + "px";
        top.frames[0].resizeTreeFromOut(parseInt(popupHeight * 0.919), parseInt(popupWidth) * 0.35);
    }

    else {
        if (document.documentElement.clientHeight < 250)
            return false;

        //var  divSplitterObj=document.getElementById("divSplitter");
        //divSplitterObj.style.height=10;    
        document.getElementById(RadTreeObj).style.height = 5;
        document.getElementById(RadTreeObj).style.width = 5;
        editor.setSize(10, 10);

        var popupFFHeight = document.documentElement.clientHeight;
        var popupFFWidth = document.documentElement.clientWidth;

        editorwidth = parseInt(popupFFWidth) * 0.6247;
        editorHeight = parseInt(popupFFHeight) * 0.95;

        if ((parseInt(popupFFHeight) - parseInt(editorHeight)) > 3)
            editorHeight = parseInt(popupFFHeight) - 52;

        objectListFrameWidth = parseInt(popupFFWidth) * 0.35;

        //ObjectListObj.style.height=parseInt(popupFFHeight)* 0.91;
        //ObjectListObj.style.width=objectListFrameWidth;

        document.getElementById(RadTreeObj).style.height = editorHeight;
        document.getElementById(RadTreeObj).style.width = objectListFrameWidth;

        editor.setSize(editorwidth, editorHeight);

    }
}
</script>
</telerik:RadCodeBlock>
