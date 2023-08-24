<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WorkflowMemo.aspx.cs"
    Inherits="WFMemo" Theme="" StylesheetTheme="" %>

<%@ Register TagPrefix="radE" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ Register TagPrefix="Skelta" TagName="SkeltaValueSelector" Src="SkeltaValueSelector.ascx" %>

<!DOCTYPE html>
<html>
<head id="Head1">
    <title><%=sWorkflow%>-<%=actionname%>-<%=prop%></title> 
     
    <link href="<%:ProcessDesignerControl.GetCommonRelativeUrl("stylesheet/Global.css")%>" rel="stylesheet" type="text/css" />
    <link href="<%:ProcessDesignerControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/SkeltaEditor/Window.css")%>" rel="stylesheet" type="text/css" /> 
    <link href="<%:ProcessDesignerControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/SkeltaEditor/Editor.css")%>" rel="stylesheet" type="text/css" />    
    <link href="<%:ProcessDesignerControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/SkeltaEditor/Window.SkeltaEditor.css")%>" rel="stylesheet" type="text/css" />  
    <link href="<%:ProcessDesignerControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/SkeltaEditor/Editor.SkeltaEditor.css")%>" rel="stylesheet" type="text/css" />
    <script type='text/javascript' src='<%=JScriptPath%>'></script>
    <script src="<%:ProcessDesignerControl.GetJscriptUrl("javascript/SkeltaValueSelector.js")%>"></script>
    <script src="<%:ProcessDesignerControl.GetJscriptUrl("javascript/XmlTreeView.js")%>"></script>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link href="<%:themePath%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
    
    <script type="text/javascript">
        function RefreshParentAndCloseWindow()
        {            
            try 
            {
      
                window.setTimeout('window.opener.refreshselectedaction()',100);
                window.opener.parent._skProcessDesigner.RefreshProperties();
                window.setTimeout('window.close()',100);
       
            }
            catch(err)
            {}
           
        }
    </script>

</head>
<body style="overflow:hidden;height:100%;" onload="initializeEditor();">
    <script>
        // Initialize locales for message dialog
        se.ui.messageDialog.setGlobalOptions({
            localization: { // All localization related default can be set
                closeButtonCaption: "<%:resManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
            okButtonCaption: "<%:resManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
            cancelButtonCaption: "<%:resManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
            showDetailsCaption: "<%:resManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
            hideDetailsCaption: "<%:resManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
        }
    });

    function ShowMessagesWithBellyBar(messageType, messageToDisplay)
    {
        var bellyBarTitle = "<%:resManager.GlobalResourceSet.GetString("Title_Expression_Editior") %>"; 
        switch (messageType)
        {
            case 1: se.ui.messageDialog.showAlert(bellyBarTitle, messageToDisplay);
                break;
            case 2: se.ui.messageDialog.showError(bellyBarTitle, messageToDisplay);
                break;
        }
    }

       
    </script>
    <form id="form1" runat="server" style="height:100%;">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <table cellpadding="0" cellspacing="0" height="100%" width="100%" class="256194ColorCode">
            <tr>
                <td style="width: 99%">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr class="ListHeaderCss">
                            <td class="fontHeading" style="padding-left:10px;">
                                <%=prop%>
                            </td>
                            <td>
                                <span title="Help" class="description">
                                    <img src="<%:ProcessDesignerControl.GetCommonRelativeUrl("Images/main-help.gif")%>"
                                        align="right" <%=helpimagetags%> alt="Help" style="cursor: pointer" /></span></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="height: 30px;">
                <td style="padding-left:10px;padding-bottom:5px;">
                    <table style="width:100%;border-collapse:collapse;border-spacing:0px;">
                        <tr>
                            <td align="left" style=" font-size: 12px">
                                <span class="subtitle">
                                    <%=Field%></span>
                                    
                            </td>
                            <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td align="center" >
                                <Skelta:SkeltaValueSelector ID="select3" runat="server" ValueItemText="SendTo" />
                            </td>
                            <td align="left" >
                                <div id="expr2">
                                    &nbsp;</div>
                            </td>
                            <td style="text-align:right;padding-right:10px;" >
                                <input type="button" value="<%=Append%>" onclick="return InsertField();" id="Button2"
                                    name="Button2" class="inputbutton" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr height="100%">
                <td height="100%" style="padding-left:10px;padding-right:10px;">
                    <radE:RadEditor ID="RadEditor1" runat="server" Height="375" Width="100%"
                          OnClientCommandExecuting="OnClientCommandExecuting"                      
                         ToolsFile="<%$ ReplaceTemplateExpn:Expression/Editor/ToolsFileMemo.xml%>"  Skin="SkeltaEditor" CssClass="WhiteColorStyle"
                         ForeColor="Black" EnableEmbeddedSkins="false" EditModes="Design" DialogsCssFile="<%$ ReplaceTemplateExpn:TelerikAjax/StyleSheet/SkeltaEditor/DialogCSS.css%>">
                    </radE:RadEditor>
                </td>
            </tr>
            <tr>
                <td style="height:30px;padding-top:10px;">
                    <table width="100%">
                        <tr>
                            <td align="left" style="width:80%;padding-left:10px;" id="TDSharePoint" runat="server">
                            </td>
                            
                            <td align="left" style="width:10%;padding-left:40px;padding-right:10px;">
                                <input name="button2" type="button" class="inputsecondarybutton" id="btnClear" onclick="window.close()"
                                    value="<%=Close%>" /></td>
                            <td align="left" style="width:10%;padding-right:10px;">
                                <asp:Button ID="btnUpdate" runat="server" OnClick="Button1_Click" CssClass="inputbutton" />
                            </td>
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
    </form>
</body>
</html>

<script type="text/javascript" language="javascript">
    
    

       
        var selectedvariableText = "";
         bubbleWindowObj = document.getElementById("bubbleWindow");
		 bubbleWindowObj.style.display="none";
        //var textVal = document.getElementById("valString").value;
        
        
		/*var valuediv = "<select id='valueinput' class='gridtableinputs' >";
		valuediv += "<%:assignedvalue%>";
		valuediv +=	"</select>";

		var variablediv = "<select id='valueinput' class='gridtableinputs'>";
		variablediv += "<%:assignedvariables%>";
		//alert(document.getElementById("assignedVar"));
		variablediv +=	"</select>";

		var contentdiv = "<select id='valueinput' class='gridtableinputs'>";
		contentdiv += "<%:assignedcontents%>";
		
		contentdiv +=	"</select>";

		var oexpr2;

		oexpr2 = document.getElementsByTagName("div")["expr2"];

		select3_onclick();

		function changeDiv( divvar )
		{
			if( !oexpr2 )
				oexpr2 = document.getElementsByTagName("div")["expr2"];

			oexpr2.innerHTML = eval(divvar);
		}

		function select3_onclick()
		{
			var oselect3 = document.getElementsByTagName("select")["select3"];

			switch(oselect3.value)
			{
				case "Value": changeDiv("valuediv");
							break;
				case "Variable": changeDiv("variablediv");
								break;

				case "Content": changeDiv("contentdiv");
								break;
				default: changeDiv("variablediv");
					     break;

			}

			return false;
		}
        */
        
        function LoadTreeview(datatype,nodetext,xpath)
		{
			
			var nodeText = "XmlVariables"+"."+document.getElementById("valueinputselect3").value+ ReplaceString(xpath.replace('$$','.'));

			selectedvariableText = nodeText;
            Maximize(false,"treeDiv");
			document.getElementById("treeDiv").style.display="none";
            document.getElementById("treeDiv").style.visibility="hidden";
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
			    //alert("The "+ oselect3.value +" field is empty");
			    //alert("<%=jsErrMsg2%>"+ " " + oselect3[oselect3.selectedIndex].text);
			    ShowMessagesWithBellyBar(2,"<%=jsErrMsg2%>"+ " " + oselect3[oselect3.selectedIndex].text+".");
			return false;
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
			
			var editorText=text + chk;
			//alert(editorText);
			//alert(editor.GetText());	
			//alert(editor.GetHtml());	 
			//editor.SetHtml("");
            //editor.SetHtml(editorText);
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
	    {
	        return editor.get_text();
	    }
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
                 
       function WriteIntelaTracContent(plugInContent)
        {
      
           var editor = $find("<%=RadEditor1.ClientID%>");
           var text = editor.get_html(); 
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
              viewUrl = siteUrl+"/_layouts/15/BPMUISharePointTemplates/view.aspx?"+listUrlContent+"&"+viewUrlContent+"&"+itemUrlContent+"&"+enableEditContent;
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
              //alert("<%=jsErrMsg%>");
              ShowMessagesWithBellyBar(2,"<%=jsErrMsg%>");
              return false;
           }
        
            document.getElementById('hdnEditor').value = editor.get_text();    
           //oTool = new document.getElementById("btnUpdate") // new keyword fails in IE 8
             oTool = document.getElementById("btnUpdate");
          // editor.fire("Unlink", oTool);
    }
    
    function OnClientCommandExecuting (editor, commandName, oTool)
        { 
        
        if ("FindAndReplace" == commandName) 
                  return false;
         }
    
    <%=xmltree%>;

    function initializeEditor()
    {
        // To focus as it is giving issue in chrome
        var editor = $find("<%=RadEditor1.ClientID%>");
        setTimeout(function(){editor.setFocus();}, 10);  
    }
</script>

<%=spScripts%>
