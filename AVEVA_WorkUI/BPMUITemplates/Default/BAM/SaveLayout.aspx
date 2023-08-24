<%@ Page Language="C#" AutoEventWireup="true"  Inherits="Workflow.NET.CodeBehind.Bam.SkeltaTemplates_Default_BAM_SaveLayout" Theme="" StylesheetTheme="" %>


<!DOCTYPE HTML>
<html>
<head>
    <title>
        <%=_Title%>
    </title>
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <style type="text/css">
        html, body
        {
            height:90%;
        }
</style>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link rel="stylesheet" type="text/css" href="<%=cssPath %>CommonUXControls/StyleSheet/se.ui.min.css" />       
    <script type='text/javascript'>		
            function noenter() 
            {
                return !(window.event && window.event.keyCode == 13); 
            }
                        
	        function Trims(sInString) 
	        {
                sInString = sInString.replace( /^\s+/g, "" );// strip leading
                sInString.replace( /\s+$/g, "" );// strip trailing
                return(sInString);
            }
		    function submitform()
	         {	           
	           window.opener.document.getElementById("SaveLayOutId").value = Trims(document.getElementById("_TxtLayOutName").value);   	            
	           var LayoutId = window.opener.document.getElementById("SaveLayOutId").value;
	         	           
	           if(LayoutId!="")
	           {    
		            //document.getElementById("SaveLayOutId").value = document.getElementById("_TxtLayOutName").value;   document.wf_theform.submit();
		            // window.opener.document.form1.submit();
		            window.opener.SaveClick();	
		            //document.forms[0].submit()
		            window.close();
		        }
		        else
		        {
		        var alertMessage='<%=_SpecifyLayoutName %>';
	               //alert(alertMessage);
	               se.ui.messageDialog.showError('<%=_Title%>', '<%=_SpecifyLayoutName %>');
		        }		         	 
		    }

        function SetFocus()
        {
            
            if (document.getElementById("_TxtLayOutName") != null)
            {
                document.getElementById("_TxtLayOutName").focus();
            }
        }
            
	         
	</script>
</head>
<body onload="SetFocus();">
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
    </script>
    <form id="Form1" name="wf_theform" method="post" runat="server" > 
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <link rel="stylesheet" type="text/css" href="<%=cssPath %>Common/StyleSheet/Global.css" />       
        <table style="width:100%">
            <tr>
                <td>
                    <table style="width:100%">
                        <tr>
                            <td style="width:100%;text-align:left" class="subtitle">
                                <%=_Heading%>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <table style="width:90%;height:50px;margin:auto;" class="tablebg"  align="center">
                        <tr>
                            <td class="lefttdbg" style="padding:2px;text-align:center;height:30px;" colspan="2" >
                             &nbsp;<span class="subtitle"><%=_TextBoxHeading%></span> 
                               
                            </td>
                            
                            <td class="righttdbg">
                            <input type="text" class="inputtext" id="_TxtLayOutName" name="_LayOutName" runat="server" onkeypress="return noenter()" />
                            </td>
                        </tr>
                    </table>
                    <br />
                </td>
            </tr>
            <tr>
                <td>
                    <table style="width:100%;height:30px">
                        <tr>
                            <td class="TdStyle" style="padding-right:10px;text-align:right;padding-top:50px;">
                                                                   
                                <input type="button" class="inputsecondarybutton"  value="<%=_BtnCancel%>"
                                    id="btnCancel" onclick="window.close();" name="btnCancel" style="margin-right:10px;">

                                 <input type="button" class="inputbutton"  value="<%=_BtnOK %>"
                                    id="btnok" onclick="submitform();" name="btnok" >
                            </td>
                            
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
