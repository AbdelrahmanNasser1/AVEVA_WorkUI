<%@ Page Language="C#" Debug="True" AutoEventWireup="true" CodeFile="ExceptionWorkflowMemo.aspx.cs"
    Inherits="WFMemo" Theme="" StylesheetTheme=""   %>

<%@ Register TagPrefix="radE" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ Register TagPrefix="Skelta" TagName="SkeltaValueSelector" Src="SkeltaValueSelector.ascx" %>

<!DOCTYPE html>
<html style="height:100%; width:100%;">
<head id="Head1">
    <title><%=sWorkflow%>-<%=actionname%>-<%=prop%></title>
    
    <link href="<%=ProcessDesignerControl.GetCommonRelativeUrl("stylesheet/Global.css")%>"   rel="stylesheet" type="text/css" />
    <link href="<%=ProcessDesignerControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/SkeltaEditor/Editor.css")%>" rel="stylesheet" type="text/css" />    
    <link href="<%=ProcessDesignerControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/SkeltaEditor/Editor.SkeltaEditor.css")%>" rel="stylesheet" type="text/css" />

    <script type='text/javascript' src='<%=JScriptPath%>'></script>

    <script src="<%=ProcessDesignerControl.GetJscriptUrl("javascript/SkeltaValueSelector.js")%>"></script>

    <script src="<%=ProcessDesignerControl.GetJscriptUrl("javascript/XmlTreeView.js")%>"></script>
    

</head>
<body style="border: none; margin: 0px; padding: 0px;overflow:hidden; height: 100%; width:100%;" >
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=cssPath %>CommonUXControls/StyleSheet/se.ui.min.css" />      
    <script>
        se.ui.messageDialog.setGlobalOptions({
            localization: { 
                closeButtonCaption: "<%=ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>", 
                okButtonCaption: "<%=ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>", 
                cancelButtonCaption: "<%=ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>", 
                showDetailsCaption: "<%=ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                hideDetailsCaption: "<%=ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" 
            }
        });
    </script>
    <form id="form1" runat="server" style="height:100%; width:100%">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <table style="height:95%;width:100%;border-collapse:collapse;border-spacing:0px;" class="256194ColorCode">
            <tr>
                <td style="width: 100%; height: 5%">
                    <table style="width:100%;" >
                        <tr class="ListHeaderCss">
                            <td class="fontheading" style="padding-left: 10px">
                                <%=prop%>
                            </td>
                            <td style="padding-left: 10px;text-align:right;">
                                <span title="Help" class="description">
                                    <img src="<%=ProcessDesignerControl.GetCommonRelativeUrl("Images/main-help.gif")%>"
                                        <%=helpimagetags%> alt="Help" style="cursor: pointer" /></span></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="height: 30px;width:100%;">
                <td style="width:100%;">
                    <table style="border-collapse:collapse;border-spacing:0px;">
                        <tr style="width:100%;">
                            <td style="text-align: left; padding-left: 10px">
                                <span class="description">
                                    <%=Field%></span>
                            </td>
                            <td>&nbsp;&nbsp;</td>
                            <td style="padding:2px;text-align:center;">
                                <skelta:skeltavalueselector id="select3" runat="server" valueitemtext="SendTo" />
                            </td>
                            <td  style="padding:2px;text-align:left;"></td>
                            <td  style="padding-right:10px;text-align:right;">
                                <input type="button" value="<%=Append%>" onclick="return InsertField();" id="Button2" name="Button2" class="inputbutton" />
                            </td>
                        </tr>
                        
                        <tr>
                            <td style="padding-left: 10px;text-align:left;">
                                <span class="description">Standard Placeholders
                                </span>
                            </td>
                            <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td style="height:24px;padding:3px;text-align:left;" colspan="2">
                                <select id="SelectStandardPh" class="inputselect" name="SelectStandardPh">
                                    <option value='Select'><%=strSelect%></option>
                                    <option value='Standard.RepositoryName'><%=strReponame%></option>
                                    <option value='Standard.WorkflowName'><%=strWorkflowname%></option>
                                    <option value='Standard.ExecutionId'><%=strExecutionId%></option>
                                    <option value='Standard.ExecutionDetailsId'><%=strExecutionDetailsId%></option>
                                    <option value='Standard.WorkitemId'><%=strWorkItemId%></option>
                                    <option value='Standard.ProcessName'><%=strProcessName%></option>
                                    <option value='Standard.ModuleName'><%=strModuleName%></option>
                                    <option value='Standard.ErrorMessage'><%=strErrorMessage%></option>
                                </select>
                            </td>

                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="width:100%;">
                <td style="height:97%; width: 100%; vertical-align:top;padding-left:10px;padding-right:10px;">
                    <radE:RadEditor ID="RadEditor1" runat="server" Editable="true" SaveInFile="false" Height="420px"
                        ShowHtmlMode="false" ShowPreviewMode="false" OnClientCommandExecuting="OnClientCommandExecuting"
                        ShowSubmitCancelButtons="false" ToolsFile="<%$ ReplaceTemplateExpn:Expression/Editor/ToolsFileMemo.xml%>" Skin="SkeltaEditor"
                        CssClass="WhiteColorStyle" ForeColor="Black" Width="100%" EditModes="Design" EnableEmbeddedSkins="false">
                    </radE:RadEditor>
                </td>
            </tr>
            <tr>
                <td style="height:10%; text-align: right; vertical-align:top; padding-top:15px; padding-right: 10px;padding-bottom:15px;">
                    <table border="0" style="width:100%;">
                        <tr>
                            <td style="width:92%;text-align:right;padding-right:10px;">
                                <input name="button2" type="button" class="inputsecondarybutton" id="btnClear" onclick="window.close()"
                                    value="<%=Close%>" /></td>
                            <td style="width:10%;text-align:right;">
                                <asp:Button ID="btnUpdate" runat="server" OnClick="Button1_Click" CssClass="inputbutton" /></td>
                        </tr>
                    </table>
                    <input type="hidden" runat="server" id="hdnEditor" />
                </td>
            </tr>
        </table>
        <input type="hidden" name="hidactionname" id="hidactionname" value="<%= actionname %>" />
                <input type="hidden" name="hidpropertyname" id="hidpropertyname" value="<%= propertyname %>" />
                <input type="hidden" name="hid_applicationName" id="hid_applicationName" value="<%= _applicationName %>" />
                <input type="hidden" name="hid_workflowName" id="hid_workflowName" value="<%= _workflowName %>" />
                <input type="hidden" name="hid_fileName" id="hid_fileName" value="<%= _fileName %>" />
                <input type="hidden" name="hidact" id="hidact" value="<%=act%>" />
                <input type="hidden" name="hidprop" id="hidprop" value="<%=prop%>" />
                <input type="hidden" name="hidField" id="hidField" value="<%=Field%>" />
                <input type="hidden" name="hidAppend" id="hidAppend" value="<%=Append%>" />
                <input type="hidden" name="hidUpdate" id="hidUpdate" value="<%=Update%>" />
                <input type="hidden" name="hidClose" id="hidClose" value="<%=Close%>" />
                <input type="hidden" name="hidVariable" id="hidVariable" value="<%=sVariable%>" />
                <input type="hidden" name="hidContent" id="hidContent" value="<%=sContent%>" />
                <input type="hidden" name="hidValue" id="hidValue" value="<%=sValue%>" />
                <input type="hidden" name="hidWorkflow" id="hidWorkflow" value="<%=sWorkflow%>" />
                <%=pda.GetHTML()%>
        <div id="bubbleWindow" class="ffffe1ColorCode" style="border: 1px solid black; cursor: text;
            font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10px; text-align: left;">
        </div>
        
        <iframe id="IframeShimForBubble" scrolling="no" frameborder="no" style="position: absolute;
            top: 0px; left: 0px; display: none;"></iframe>

        <script type="text/javascript">
                     
                 

            function PassingAdminValues() {
                
                window.setTimeout(PassAdminValues, 100);

            }

            function PassingUserValues()
            {                
                window.setTimeout(PassUserValues, 100);                           
            }

            function PassUserValues()
            {
                var obju = $find("<%=RadEditor1.ClientID%>");
                var rdText = obju.get_html();
                
                window.opener.document.forms[0].idPopupValueUsers.value = rdText;

            }

            function PassAdminValues() {
                var obja = $find("<%=RadEditor1.ClientID%>");
                var rdText = obja.get_html();
                
                window.opener.document.forms[0].idPopupValueAdmin.value = rdText;

            }
    </script>
    </form>
    
    
</body>
</html>

<script type="text/javascript" language="javascript">

    
    
        var selectedvariableText = "";
         bubbleWindowObj = document.getElementById("bubbleWindow");
		 bubbleWindowObj.style.display="none";
        
        
        function LoadTreeview(datatype,nodetext,xpath)
		{
			
			var nodeText = "XmlVariables"+"."+document.getElementById("valueinputselect3").value+ ReplaceString(xpath.replace('$$','.'));

			selectedvariableText = nodeText;

            Maximize(false, "treeDiv");
			document.getElementById("treeDiv").style.display="none";
            document.getElementById("treeDiv").style.visibility = "hidden";

			document.getElementById("cmbLHS_Inputselect3").value = selectedvariableText;
			document.getElementById("IframeShim").style.visibility = "hidden";

		}
		


		function ReplaceString(xpath)
		{

		  xpath = xpath.replace('$','.')

		  var l = xpath.length;

		  for (var i=0; i<l; i++)
		  {
			var ch = xpath.charAt(i);

			if(ch=='$')
			{

				xpath = xpath.replace(ch,'.')
			}
		  }
		  return xpath;
		}
		function InsertField()
		{		    
		    var editor = $find("<%=RadEditor1.ClientID%>");
           //Added for Standard Placeholder
           var standardPhText=document.getElementsByTagName("select")["SelectStandardPh"].value;			
           
           
            var text="";
			var oselect3 = document.getElementsByTagName("select")["Selectselect3"];
			
			var ovalueinput;
			
			if(typeof(document.getElementsByTagName("input")["valueinputselect3"]) != 'undefined')
					ovalueinput = document.getElementsByTagName("input")["valueinputselect3"];
		    
		    else if(typeof(document.getElementsByTagName("select")["valueinputselect3"]) != 'undefined')
					ovalueinput = document.getElementsByTagName("select")["valueinputselect3"];
					
			text = editor.get_html();
			
			if(ovalueinput.value == "")
			{
			  if(standardPhText =="Select")
			  {
			    if(oselect3.value !='SendTo')
			    {
			        se.ui.messageDialog.showError("<%=ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("GlobalSettings_Exception") %>", "<%=jsErrMsg2%>" + " " + oselect3.value);
			        return false;
			    }
			    else
			    {
    		        return false;
			    }
			  }
			  
			}
			
			var chk="";
			
			if(selectedvariableText=="")			
			{
			    if(oselect3.value=="XmlVariable")
			    {
			        //alert("Select Xml Variable Node");
			        return false;
			    }
			    else
			    {
			        chk = "&lt;%#"+ovalueinput.value+"%&gt;";    
			    }
			}
			else
			{
			     //chk = "&lt;%#"+selectedvariableText+"%&gt;";  
			     //Replace < with &lt; is done because the editor is not pasting the text after < 
			     // if the selection has < character
			     chk = "&lt;%#"+selectedvariableText.replace("<","&lt;")+"%&gt;"; 
			    
			    if(oselect3.value=="XmlVariable")
			    {
			        document.getElementById("cmbLHS_Inputselect3").value="";
			    }
			}
			
			selectedvariableText="";				
					
			if(standardPhText!="Select" && oselect3.value !='SendTo')
			{
			    se.ui.messageDialog.showError("<%=ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("GlobalSettings_Exception") %>", "<%=strValidStandardPlaceHolderMessage%>");
			    
			}
			else if (standardPhText!="Select" && oselect3.value =='SendTo')
			{
			    standardPhText="&lt;%#"+standardPhText+"%&gt;";
			    chk=standardPhText;
			}
			var editorText=text + chk;					
            editor.pasteHtml(chk);
           
		}

	function trim(theString) //Remove Trailing spaces
	{
		while(""+theString.charAt(theString.length-1)==" ")
			theString = theString.substring(0, theString.length-1);
		while(""+theString.charAt(0)==" ")
			theString = theString.substring(1, theString.length);
		return(theString);
	}
	function GetMemoContent()
	{
	   var editor = $find("<%=RadEditor1.ClientID%>");
       if(editor!=null)
           return editor.get_text();
        else
            return "";
     }
	function WritePluginContent(plugInContent)
        {
       
	    var editor = $find("<%=RadEditor1.ClientID%>");
	    var text = editor.get_html();
        
        while(plugInContent.indexOf("|$|")>0)
            plugInContent=plugInContent.replace("|$|","'");

	while(plugInContent.indexOf("@|@")>0)
            plugInContent=plugInContent.replace("@|@","\\");
           
        //editor.PasteHtml(text+plugInContent);
        
        plugInContent=plugInContent.replace("&","&amp;"); 
        
        editor.pasteHtml(plugInContent);
        }
        
       function WriteECTemplatePath(ecPath)
       {
             var ecPathwithPlaceHolder = "&lt;%" + ecPath +"%>";
             //var ecPathwithPlaceHolder = ecPath;
             var editor = $find("<%=RadEditor1.ClientID%>");
             var text = editor.get_html();
             editor.pasteHtml(ecPathwithPlaceHolder);
       }
    function WritePluginContentViewUrl(plugInContent)
        {
        
        var editor = $find("<%=RadEditor1.ClientID%>");
        var text = editor.get_html();
        
        while(plugInContent.indexOf("|$|")>0)
            plugInContent=plugInContent.replace("|$|","'");
        
        var content = plugInContent.split("#");
        var viewUrl="";
        var siteUrl="";
        var listUrlContent = "List=";
        var viewUrlContent="View=";
        var itemUrlContent="ListItemId=0";
        var enableEditContent = "EnableEdit=False";
        
        if(content.length>1)
            {
            
              var parentContent = content[0].split('~');
                  
              if(parentContent.length>3)
              {     
              /*
              alert("Item="+content[1]); 
              alert("Web Application="+parentContent[0]);      
              alert("Site="+parentContent[1]);      
              alert("Web="+parentContent[2]);      
              alert("List="+parentContent[3]);      
              */
                siteUrl  = parentContent[1];
                siteUrl = siteUrl.substring(siteUrl.lastIndexOf("}")+1);
                listUrlContent = listUrlContent+parentContent[3]; 
                viewUrlContent = viewUrlContent+content[1];
              }
              viewUrl = siteUrl+"/_layouts/BPMUISharePointTemplates/view.aspx?"+listUrlContent+"&"+viewUrlContent+"&"+itemUrlContent+"&"+enableEditContent;
            }
        editor.pasteHtml(text+viewUrl);
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



function clientConfirm()
    {   
          var editor = $find("<%=RadEditor1.ClientID%>");
          if(("<%=Mandatory%>"=="True") && (editor.get_text()== ""))
           {
              se.ui.messageDialog.showError("<%=ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("GlobalSettings_Exception") %>", "<%=jsErrMsg%>");
              return false;
           }
           document.getElementById('hdnEditor').value = editor.get_text();
           
           //oTool = new document.getElementById("btnUpdate") // new keyword fails in IE 8
           oTool = document.getElementById("btnUpdate")
           editor.fire("Unlink", oTool);
    }
    
    function OnClientCommandExecuting (editor, commandName, oTool)
        { 
          if ("FindAndReplace" == commandName) 
          return false;     
        }
    
    <%=xmltree%>;
    
//    function OpenmemoWindow(URL)
//    {
//    
//        //window.open('" + URL + "','WFmemo','height=400,width=805,resizable=no,scrollbars=yes');
//    
//    }
    
/*resizepage();
//function resizepage()
//{
    alert(document.body.offsetHeight);
    alert(document.body.offsetWidth);
    //alert(editor.GetHeight());   
    //alert(editor.GetWidth()); 
}*/

    


</script>

<%=spScripts%>

