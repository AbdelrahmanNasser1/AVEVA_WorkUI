<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.SOA.CodeBehind.Repository.SOAFolderManager" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>
<%@ Register Assembly="Skelta.Forms.Web" Namespace="Skelta.Forms.Web" TagPrefix="cc1" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html>
<html style="height:100%">
<head runat="server">
    <title></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <link href="<%$ ReplaceTemplateExpn:Common/StyleSheet/Global.css%>" rel="stylesheet" type="text/css" />
    <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link href="<%$ ReplaceTemplateExpn:CommonUXControls/StyleSheet/se.ui.min.css%>"  rel="stylesheet" type="text/css" />  
    <link href="<%$ ReplaceTemplateExpn:TelerikAjax/StyleSheet/AWTInput/Input.AWTInput.css%>"  rel="stylesheet" type="text/css" />  
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
    
 function SizeToFit()
{
 var oWnd = GetRadWindow();
 oWnd.setSize(800, 620);
 if (window.parent.location.search != null && window.parent.location.search == '?FromArchestrA=true') {
     oWnd.setSize(800, 590);
 }
}          
    </script>
    
</head>
<body onload="waitPreloadPage();SizeToFit();" style="margin: 0px;height:100%; left: 0; overflow:hidden;">
   
    <script>
        
     se.ui.messageDialog.setGlobalOptions({
             localization: {
                 closeButtonCaption: "<%=GetLangSpecText("se_ui_messagedialog_close_caption") %>",
                okButtonCaption: "<%=GetLangSpecText("se_ui_messagedialog_ok_caption") %>",
                cancelButtonCaption: "<%=GetLangSpecText("se_ui_messagedialog_cancel_caption") %>",
                showDetailsCaption: "<%=GetLangSpecText("se_ui_messagedialog_showdetails_caption") %>",
                hideDetailsCaption: "<%=GetLangSpecText("se_ui_messagedialog_hidedetails_caption") %>"
            }
        });

</script>


    <div id="ParentDiv" style="height:100%">
        <div id="prepage" class="divBackgroundColor" style="visibility: visible; position: absolute;
            font-family: Segoe UI; font-size: 16; left: 0px; top: 0px; 
            height: 100%; width: 100%;">
            <div style="text-align:center">
                <font face="Segoe UI" size="4" color="black"><b>Loading data, Please wait... </b></font>
            </div>
            <table visible="false" id="indicator" style="border-width:0;border-spacing:0;width:0;height:20;margin:auto" >
                <tr>
                    <td style="text-align:center;width:100%">
                    </td>
                </tr>
            </table>
            <table id="indicatorimage" style="border-width:0;width:0;margin:auto;border-spacing:0;">
                <tr>
                    <td  style="text-align:center;width:100%">
                        <%--<asp:Image ID="imgLoading" runat="server" ImageUrl="<%=templateThemeDirectory%>SOA/images/download_line.gif" />--%>
                        <asp:Image ID="imgLoading" runat="server" ImageUrl="<%$ ReplaceTemplateExpn:SOA/images/download_line.gif%>" />
                    </td>
                </tr>
            </table>
        </div>
        <form id="form1" runat="server" style="height:100%">
            <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
            <%=System.Web.Helpers.AntiForgery.GetHtml()%>
            <asp:Panel ID="Panel1" runat="server" Height="100%">
            <div id="HeaderDiv" style="height:12%">

                <table style="width:100%; margin: auto; border-width: 0; border-spacing: 0px">
                    <tr class="ListHeaderCss">
                        <td rowspan="2" style="vertical-align: middle; width: 40px; text-align: center;">
                            <img alt="" src="<%=templateThemeDirectory%>SOA/images/icon-new-soafolder.png"
                                style="vertical-align: middle" />
                        </td>
                        <td class="MainHeading" id="spPageTile" runat="server" style="text-align: left;">
                            <asp:Label ID="lblpageHeading" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td class="description" style="padding-bottom: 10px;">
                            <%=GetLangSpecText("FolderManager_HeadingDescription") %>                  
                        </td>
                    </tr>
                </table>
            </div>
                    <div id="BodyDiv" style="height:80%;" >
                            <table style="border-spacing:1px;border-collapse:separate;border-width:0px;width:98%;margin:auto" class="tablebg">
                                <tr>
                                    <td class="lefttdbg" style="width: 45%;vertical-align:top" colspan="2">
                                        <span class="subtitle">
                                            <%=GetLangSpecText("FolderManager_Title")%> <img alt=""  id="imgNameRequired" runat="server" src="<%$ReplaceTemplateExpn:Skeltaforms/images/mandatoryicon.png%>" hspace="2" align="top" visible="true" /><asp:RequiredFieldValidator Display="Dynamic" ID="WorkflowNameInputRequired" runat="server"
                                            ControlToValidate="folderName"><img  alt="" id="titleerrorImage" runat="server" src="<%$ReplaceTemplateExpn:Skeltaforms/images/erroricon.png%>" hspace="2" align="top" visible="true" />
                                           
                                        </asp:RequiredFieldValidator>
                                        </span>
                                        <br />
                                        <span class="description">
                                            <%=GetLangSpecText("FolderManager_TitleDesc")%>
                                        </span>
                                    </td>
                                    <td class="righttdbg" colspan="2">
                                        <telerik:RadTextBox ID="folderName" TabIndex="0"  runat="server" MaxLength="100" Width="40%" EnableEmbeddedSkins="false"  Skin="AWTInput">
                                       
                                       </telerik:RadTextBox>
                                  
                                      </td>
                                </tr>
                                <tr>
                                    <td class="lefttdbg" colspan="2">
                                        <span class="subtitle">
                                            <%=GetLangSpecText("FolderManager_Description")%>
                                        </span>
                                        <br />
                                        <span class="description">
                                            <%=GetLangSpecText("FolderManager_DescriptionDescr")%>
                                        </span>
                                    </td>
                                    <td class="righttdbg" colspan="2">
                                       <telerik:RadTextBox ID="folderDescription" TextMode="MultiLine"  TabIndex="0"  runat="server" MaxLength="100"  Height="60px" Width="95%" EnableEmbeddedSkins="false" Skin="AWTInput">            
                                       </telerik:RadTextBox>
                                    
                                    </td>
                                </tr>
                                <tr>
                                    <td class="lefttdbg" colspan="2">
                                        <span class="subtitle">
                                            <%=GetLangSpecText("FolderManager_Path")%></span>
                                            <img alt=""  id="imgPathRequired" runat="server"  src="../../Skeltaforms/images/mandatoryicon.png" hspace="2" style="text-align:top" />
                                            <img alt="Enter physical path"  id="errorImage" runat="server" src="../../Skeltaforms/images/erroricon.png" hspace="2" align="top" visible="false" />
                                     
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="folderpath"
                                                        Display="Dynamic">
                                                        <img alt=""  id="img1" runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/images/erroricon.png%>" />
                                            </asp:RequiredFieldValidator>
                                        <br />
                                        <span class="description">
                                            <%=GetLangSpecText("FolderManager_PathDescr")%>
                                        </span>
                                    </td>
                                    <td class="righttdbg" colspan="2">
                                        <table style="width:95%;border-width:0;border-spacing:0;border-collapse:collapse">
                                            <tr>
                                                <td style="width:70%;padding:2px">
                                                    <telerik:RadTextBox ID="folderpath" TabIndex="0"  runat="server" MaxLength="600" Width="100%"  Skin="AWTInput" EnableEmbeddedSkins="false">            
                                                    </telerik:RadTextBox>
                                                </td>
                                                <td style="width:5%;padding:2px">
                                                </td>
                                                <td style="padding:2px">
                                                    <asp:Button ID="btnListAssemblies" runat="server" CssClass="inputbutton" TabIndex="0"
                                                        />                                                
                                                 </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="lefttdbg" colspan="4"><img alt="" src="<%=templateThemeDirectory%>Repository/Site/Images/icon-error.png" style="vertical-align:baseline">
                                        <span class="note">
                                            <%=GetLangSpecText("FolderManager_PathWebServer")%>
                                        </span>
                                    </td>
                                </tr>
                            </table>
                        
                            <table id="webGridtable"  style="border-spacing:1px;width:98%; border-width:0;margin:auto" class="tablebg">
                                <tr >
                                    <td class="lefttdbg" style="padding:3px">
                                        <span class="subtitle">
                                            <%=GetLangSpecText("FolderManager_AssemblyList")%>
                                        </span>
                                        <br />                                                          
                                     
                                         <ISWebGrid:WebGrid ID="GdListAssembly" TabIndex="-1" runat="server" HorizontalAlign="NotSet"
                                            AllowAutoDataCaching="false" Height="150px" width=100% DisableFileSystemChecking="true" RenderingMode=HTML5
                                            EnableWebResources="never" >
                                            <layoutsettings alternatingcolors="True"  cellpaddingdefault="2" gridlinestyle="Solid" GridLines="None"
                                                gridlinecolor="224, 224, 224" rowheightdefault="22px" autoheight="false" allowsorting="Yes"
                                                allowcolumnsizing="No" AutoFitColumns="true"  alwaysshowhelpbutton="false" StatusBarVisible=true RowHeaders="No" >                                                   
                                                    <HeaderStyle Wrap="false" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CssClass="GridHeaderStyle"></HeaderStyle>                
                                                    <FocusCellStyle CssClass="GridFocusCellStyle" />
                                                    <GroupRowInfoStyle CssClass="GridGroupRowInfoStyle"></GroupRowInfoStyle>
                                                    <GroupByBox>
                                                        <LabelStyle CssClass="GridLabelStyle"></LabelStyle>
                                                    </GroupByBox>
                                                    <FrameStyle CssClass="GridFrameStyle">
                                                    </FrameStyle>
                                                    <SelectedRowStyle CssClass="GridSelectedRowStyle" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden" />
                                                    <StatusBarStyle CssClass="GridStatusBarStyle">
                                                        <Padding Bottom="2px" Left="2px" Right="2px" Top="2px" />
                                                    </StatusBarStyle>
                                                    <RowStyle CssClass="GridRowStyle" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden" />   
                                                    <AlternatingRowStyle CssClass="GridAlternatingRowStyle" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden" />
                                                    <NewRowStyle CssClass="GridNewRowStyle">
                                                    </NewRowStyle>
                                                    
                                                    <TextSettings Language="UseCulture">
                                                    </TextSettings>
                                                </layoutsettings>
                                                <roottable gridlinestyle="NotSet">
                                                </roottable>
                                        </ISWebGrid:WebGrid>
                                    </td>
                                </tr>
                            </table>
                        
              
            </div>
            <div id="FooterDiv" style="height:6%;vertical-align:middle;">
                <table style="border-spacing:0;width:98%;border-width:0;margin:auto;">
                    <!--cellpadding="5"-->
                    <tr>
                        <td style="width:100%;text-align:right;padding-right:10px;">
                             <input type="button" id="btnClose" tabindex="0" runat="server" onclick="javascript: closeWindow();"  class="inputsecondarybutton"/>
                           </td>
                        <td style="padding-right:10px;">                           
                             <asp:Button ID="SaveButton" TabIndex="0" runat="server" CssClass="inputbutton" OnClick="btnSave_Click"/>
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
function AddEventHandler(elementObject, eventName, functionObject)
{
    if(document.addEventListener)
        elementObject.addEventListener(eventName, functionObject, false);
    else
        if(document.attachEvent)
            elementObject.attachEvent("on" + eventName, functionObject);
}

/* Resizing function is not required now everything inside commom table*/
AddEventHandler(window,"resize",resizefunction);
AddEventHandler(window,"load",resizefunction);

function resizefunction()
        { 
        
 var bodydiv = document.getElementById('BodyDiv');
 var headerdiv = document.getElementById('HeaderDiv');
 var footerdiv = document.getElementById('FooterDiv');
var parentdiv = document.getElementById('ParentDiv');
 //var grid = wgGetGridById("GdListAssembly"); 
if (parentdiv.offsetParent==document.body)
           bodydiv.style.width =  '100%';
           bodydiv.style.width =  parentdiv.clientWidth;                 
            bodydiv.style.overflow =  'auto';
           parentdiv.style.overflow = 'hidden'; 
        }
      
</script>

