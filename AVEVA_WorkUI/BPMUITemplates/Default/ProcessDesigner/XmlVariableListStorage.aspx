<%@ Page Language="C#" AutoEventWireup="true"  Inherits="Workflow.NET.Template.XmlVariableListCodeFile" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(_designerControl.GetCommonRelativeUrl("stylesheet/global.css"))%>" rel="stylesheet" type="text/css" />

<script src="<%=_designerControl.GetCommonJScriptRelativeUrl("javascripts/SchemaDefinition.js")%>"></script>

<head runat="server">
    <title><%=Microsoft.Security.Application.Encoder.HtmlEncode(pagetitle)%></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <script type="text/javascript" language="javascript">
  
    IframeSrc="<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(IframeURl, false)%>";
   
 function GetStorageSrc(storageType)
 {

  var iframesrc=IframeSrc;
  storageType=storageType.replace(";","");
  
  var selectedtext=storageType;
  var nnerHTMl="";
  if(selectedtext!="")
  {
      LoadXmlDocument(selectedtext,iframesrc,nnerHTMl);
  }
}

function ChangeStorageSrc(storageName)
{


  var iframesrc = IframeSrc; 
  var selectedtext="";
  
  if(storageName.options.length>0)
  {
   
    switch(storageName.options[storageName.selectedIndex].value)
    {
    case "XmlSkeltaList":selectedtext="XmlSkeltaList";
                         break;
    case "Xml SAPTable": selectedtext="Xml SAPTable";
                         break;
    case "Xml Document": selectedtext="XmlDocument";
                        break;
    case "XmlDocument": selectedtext="XmlDocument";
                        break;
    case "SP List\\DocLibrary": selectedtext="XmlSPList";
                       break;
    case "XmlSPList":selectedtext="XmlSPList";
                       break;
   
    case "XmlFormLibrary": selectedtext="XmlFormLibrary";
                         break;
    case "Xml Iterator":selectedtext="XmlIterator";
                         break; 
    case "XmlIterator": selectedtext="XmlIterator";
                         break;                 
    }
    }
    var nnerHTMl="";
  if(selectedtext!="")
  {
      LoadXmlDocument(selectedtext,iframesrc,nnerHTMl);
  }
   
}

function Resize()
{    
           
                   
           var frame = document.getElementById('divFrame');
           //frame.style.position="absolute";
           //frame.style.left=1;
           frame.style.top=90;
          // frame.style.width = 300;
           //frame.style.height =750;// h-tabheight; 
                     

        }
function refreshGrid(variableName)
{
window.opener.parent._skProcessDesigner.RefreshProperties();
window.close();

return;
}
    </script>
</head>
<body onload="Resize();">
    <form id="form1" runat="server">
    <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
    <div id="mainDiv">
    <table  border="0" cellpadding="0" cellspacing="0" width="100%" class="tablebg">
          <tr align="center">
            <td valign="bottom" height="25" background="<%=_designerControl.GetCommonRelativeUrl("Images/Common-Heading-bg.png")%>" class="header" >
		        <table cellspacing="0" cellpadding="0" border="0" width="100%">
			        <tr>
				        <td valign="middle" height="25" class="header" style="height: 24px;font-size:12px"><span class="pagetile"> <%=prop%></span></td>
				        <td valign="top" width="25" class="header"><a href="#"><img  id="helpimage" src="<%=_designerControl.GetCommonRelativeUrl("Images/main-help.gif")%>"  onclick="javascript:window.open('<%=_designerControl.GetHelpPageUrl()%>AboutTheXMLVariableUserInterface.html','test','width=600,height=500,scrollbars=yes,resizable=yes')"  border="0" /></a></td>
			        </tr>
		        </table>
		    </td>
          </tr>
          <tr>
            <td align="left" class="lefttdbg">
               <table border="0" cellpadding="5" cellspacing="1" height="100%" width="98%">
                  
                    <tr>
                        <td width="40%" class="lefttdbg">
    		               <asp:Label ID="XmlVariableNameInputLabel" runat="server"  CssClass="subtitle"></asp:Label>
				        </td>
		                <td class="righttdbg">
                           <asp:TextBox ID="variableName" runat="server" CssClass="inputtext" MaxLength="30"></asp:TextBox>
                        </td>            
                    </tr>
                    
                    <tr>
                      <td class="lefttdbg">
                         <asp:Label ID="XmlVariableDescInputLabel" runat="server" CssClass="subtitle"></asp:Label>
                      </td>
                      <td class="righttdbg">
                          <asp:TextBox ID="VarDescription" runat="server" CssClass="inputtext"></asp:TextBox>
                          <input type="hidden" id="HdnModeEdit"  value="ADD"/>
                          <input type="hidden" id="variablescope" value="global" />
                     </td>
                    </tr>
                    <tr>
                      <td class="lefttdbg">
                           <asp:Label ID="XmlVariableTypeInputLabel" runat="server" CssClass="subtitle"></asp:Label>
                      </td>
                      <td class="righttdbg">
           
                            <asp:DropDownList ID="ddstorageType" runat="server" CssClass="inputselect">
                            </asp:DropDownList>
                        </td>
                    </tr>
                  <%-- <tr>
	               <td>
	                <div id="divFrame" style="position:fixed;">
                     <iframe id="iframeVariable"  style="width:490px;" runat="server" height="490px"></iframe>
                   </div>
	             </td>
	       </tr>   --%>   
                   
                                                                                                                          
	          </table>
	        </td>
	     </tr>
	           
	     <tr>
	        <td>
	           <div id="divFrame">
                  <iframe id="iframeVariable"   width="100%" runat="server"  height="500px" scrolling="no"></iframe>
               </div>
	       </td>
	   </tr>      
	         
        
          
      </table>
     </div>
    </form>
</body>
</html>
