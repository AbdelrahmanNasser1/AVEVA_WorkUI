<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.SOA.CodeBehind.Repository.SOAAssemblyListBrowse" %>
<%@ Register Assembly="Skelta.Forms.Web" Namespace="Skelta.Forms.Web" TagPrefix="cc1" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html >
<html style="height:100%">
<head runat="server">
    <title>
        <%=GR.GetString("soa_SelectAssmbly")%>
    </title> 
     <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <link rel="stylesheet" type="text/css" href="<%$ ReplaceTemplateExpn:Common/StyleSheet/Global.css%>" />   
     <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script>
     <link href="<%$ ReplaceTemplateExpn:CommonUXControls/StyleSheet/se.ui.min.css%>"  rel="stylesheet" type="text/css" />
     <link href="<%$ ReplaceTemplateExpn:TelerikAjax/StyleSheet/AWTTreeView/TreeView.AWTTreeView.css%>"  rel="stylesheet" type="text/css" />
    <script type="text/javascript" >
        function waitPreloadPage() 
        {   //DOM
            if (document.getElementById)
            {
              document.getElementById('prepage').style.visibility='hidden';
            }
            else
            {
                if (document.layers)
                { //NS4
                    document.prepage.visibility = 'hidden';
                }
                else 
                { //IE4
                    document.all.prepage.style.visibility = 'hidden';
                }
            }
        }
        // End -->
    </script>

</head>
<body onload="waitPreloadPage();" style="margin: 0; left: 0; overflow: hidden;height:100%">
     <script>
         se.ui.messageDialog.setGlobalOptions({
             localization: {
                 closeButtonCaption: "<%=GR.GetString("se_ui_messagedialog_close_caption") %>",
                 okButtonCaption: "<%=GR.GetString("se_ui_messagedialog_ok_caption") %>",
                 cancelButtonCaption: "<%=GR.GetString("se_ui_messagedialog_cancel_caption") %>",
                 showDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_showdetails_caption") %>",
                 hideDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_hidedetails_caption") %>"
             }
         });

        

</script>

    <div id="prepage" class="divBackgroundColor" style="visibility: visible; position: absolute; font-family: arial;
        font-size: 16; left: 0px; top: 0px;  height: 100%; width: 100%;">        
        <table>
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
        </table>
         <div style="text-align:center"><font face="Roboto,Segoe UI,Arial,Verdana" size="4" color="black"><b>Loading data, Please wait...</b></font></div>
			<table visible="false" id=indicator  style="border-width:0;margin:auto;border-width:0;border-spacing:0;">
				<tr>
					<td style="text-align:center;width:100%"></td>					
				</tr>
			</table>	
			<table id=indicatorimage style="border-width:0;margin:auto;border-width:0;border-spacing:0;" >
				<tr>
					<td  style="text-align:center;width:100%">
					    <asp:Image ID="imgLoading" runat="server" ImageUrl="<%$ ReplaceTemplateExpn:SOA/images/download_line.gif%>" />
					</td>					
				</tr>
			</table>		
    </div>
    
    <div  id="ParentDiv" style="height:100%">
        <form id="form1" runat="server" style="height:100%">
             <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
            <%=System.Web.Helpers.AntiForgery.GetHtml()%>
            <asp:Panel ID="Panel1" runat="server" Height=100%>
                <div id="HeaderDiv" style="height:10%">                
                    <table style="width:100%">
                    <tr>
                        <td rowspan="2" style="vertical-align: middle;width:40px;text-align:center;" >
                            <img src="<%=templateThemeDirectory%>SOA/images/icon-select-new-assembly.png"  alt="" />
                        </td>
                        <td class="MainHeading"><%=GR.GetString("soa_SelectAssmbly")%></td>
                    </tr>
                    <tr>
                        <td class="description" style="padding-bottom:10px;"><%=GR.GetString("soa_AssemblyUse")%></td>
                    </tr>
                </table>
                </div>
                <div id="BodyDiv" style="height:83%">
                    <table   class="fieldset"  style="margin:auto;width:96%;border-width:0;height:98%;border-style: solid;border-width:0px;border-spacing:2px;border-color:Black" >
                        <tr>
                            <td style="height:100%;">
                                <table style="width:100%;margin:auto;border-width:0;height:100%">
                                    <tr>
                                        <td class="tdTreeView" style="vertical-align:top;height: 100%; width: 100%;">
                                            <telerik:RadTreeView ID="RadTreeFolder" runat="server"  RetainScrollPosition="False" EnableViewState="true" Height="350px" Width="100%" EnableEmbeddedSkins="false" Skin="AWTTreeView">
                                            </telerik:RadTreeView>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>                    
                </div>
                <div id="FooterDiv" style="height:10%">
                     <table  style="width:100%;border-width:0;margin:auto;border-spacing:0px"  >
                        <tr>                        
                            <td class="pagetitle " colspan="2" style="text-align:right;vertical-align:top;padding-right:10px" >
                                <input type="button" id="btnClose" onclick="javascript: closeWindow();" class="inputsecondarybutton"
                                    runat="server" />
                            </td>
                            <td style="width:24px;text-align:right;vertical-align:top;padding-right:10px">
                                
                                <asp:Button ID="SaveButton" runat="server" CssClass="inputbutton"  />

                            </td>                                    
                        </tr>
                    </table>
                </div>
            </asp:Panel>
            <input type="hidden" runat="server" id="hidSelectedPath" />
            <input type="hidden" runat="server" id="hidSelectedName" />
        </form>
    </div>
    
</body>
</html>

<script type="text/javascript">
function GetRadWindow()
            {
                var oWindow = null;
                 oWindow = window.frameElement.radWindow;
                return oWindow;
            } 
function closeWindow()
            {
                var oWindow = GetRadWindow();
                oWindow.close();
            }
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

            var parentdivheight = parentdiv.offsetParent.offsetHeight;
           // parentdiv.style.height =  parentdivheight ;
           // try{bodydiv.style.height = parentdivheight - headerdiv.offsetHeight - footerdiv.offsetHeight ;}catch(e){}//headerdiv.offsetHeight -
            bodydiv.style.width =  '100%';
            bodydiv.style.width =  parentdiv.clientWidth;
            bodydiv.style.overflow =  'auto';
            parentdiv.style.overflow = 'hidden';           
        }
</script>

