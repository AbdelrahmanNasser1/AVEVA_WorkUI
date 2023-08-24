<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.saveversion" %>
<!DOCTYPE html>
<html>
<head>
    <title><%=GetLangSpecText("Save List Item")%></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <style>
        html,body{height:100%;}
    </style>

    <script type="text/javascript">
    function GetRadWindow(){
      var oWindow = null;

      if (window.radWindow) 
	    oWindow = window.radWindow;
      else if (window.frameElement.radWindow) 
	    oWindow = window.frameElement.radWindow;
    	
      return oWindow;
    }           

    function closeWin(){
     var oWindow = GetRadWindow();    
     oWindow.close();
     //alert("The save operation completed successfully.");         
    }
    </script>

</head>
<body style="margin: 0;">
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=cssPath %>CommonUXControls/StyleSheet/se.ui.min.css" />      
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
    </script>
    <div id="ParentDiv" style="height:100%;">
        <form id="form1" runat="server" style="height:100%;"><link href="<%=cssPath%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
            <div id="HeaderDiv">
                <table style="width: 100%; height:40px;border-width:0;border-spacing:1px;margin:auto" >
                    <tr>
                        <td  colspan="2" style="text-align:left;padding:3px">
                            <asp:Label ID="Label1" runat="server" CssClass="description" Width="100%"></asp:Label><br />
                        </td>
                    </tr>
                </table>
            </div>
            <div id="BodyDiv" style="width:100%">
                <table style="width: 100%;height:50px;border-spacing:1px;border-width:0;margin:auto"  class="tablebg">
                    <tr style="width:100%">
                        <td class="lefttdbg" style="width: 50%;vertical-align:middle;padding:3px">
                            <span class="subtitle">
                                <%=GetLangSpecText("ec_save_version_entrcmts")%>
                            </span>
                        </td>
                        <td class="righttdbg" style="vertical-align:middle;width:100%">
                            <textarea id="TA_Comments" class="inputtext" name="TA_Comments" style="width: 92%;
                                height: 70%"></textarea></td>
                    </tr>
                </table>
            </div>
            <div id="FooterDiv">
                <table style="width:100%;margin:auto;border-width:0;">
                    <tr>
                        <td colspan="2" style="text-align:right;padding-right:10px;padding-bottom:5px;">
                            <asp:Button ID="Button1" runat="server" CssClass="inputbutton"  OnClick="Button1_Click" /></td>
                    </tr>
                    
                </table>
            </div>
        </form>
    </div>
</body>
</html>

<script type="text/javascript">
function AddEventHandler(elementObject, eventName, functionObject)
{
    
    if(document.addEventListener)
        elementObject.addEventListener(eventName, functionObject, false);
    else
        if(document.attachEvent)
            elementObject.attachEvent("on" + eventName, functionObject);
}


AddEventHandler(window,"resize",resizefunction);
AddEventHandler(window,"load",resizefunction);

function resizefunction()
        { 
        
 var bodydiv = document.getElementById('BodyDiv');
 var headerdiv = document.getElementById('HeaderDiv');
 var footerdiv = document.getElementById('FooterDiv');
var parentdiv = document.getElementById('ParentDiv');

if (parentdiv.offsetParent==document.body)
       document.body.style.height = '100%';

        
         // parentdiv.style.height =  parentdivheight ;
    try {
        var parentdivheight = parentdiv.offsetParent.offsetHeight;
        bodydiv.style.height = parentdivheight - headerdiv.offsetHeight - footerdiv.offsetHeight +"px" ;
    } catch (e) { }//headerdiv.offsetHeight -
           //bodydiv.style.width =  '100px';
           //bodydiv.style.width =  parentdiv.clientWidth;                 
            bodydiv.style.overflow =  'auto';
           parentdiv.style.overflow = 'hidden';
        
           
        }

</script>

