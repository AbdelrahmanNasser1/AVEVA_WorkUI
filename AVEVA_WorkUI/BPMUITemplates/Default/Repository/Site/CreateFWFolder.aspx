<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.CreateFWatcherFolder" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ OutputCache Duration="60" Location="None" NoStore="true" %>


<!DOCTYPE HTML>
<html>
<head id="Head1" runat="server">
    <title>
        <%=title%>
    </title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    
    <style>
        html, body, form
        {
            height: 100%;
        }
    </style>
    <script language="javascript" type="text/javascript">
    function closeWindow()
    {        
        var oWindow = GetRadWindow();
        setTimeout(function () {
            oWindow.close();            
        }, 0);
    }
   
   function GetRadWindow()
    {
      var oWindow = null;
      if (window.radWindow) 
          oWindow = window.radWindow;
      else if (window.frameElement.radWindow) 
          oWindow = window.frameElement.radWindow;
      return oWindow;
    }           
 

function SizeToFit()
{
    var oWnd = GetRadWindow();
    if (navigator.userAgent.toLowerCase().indexOf('firefox') > 0) {
        oWnd.setSize(720, 670);
    }
    else {

        oWnd.setSize(720, 650);
    }
}
    
    </script>

</head>
<body onload="SizeToFit();">
    <script src="<%=JSPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
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
<div  id="divparent" runat="server" style="padding-left:5px;">
    <form id="form1" runat="server"> 
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        
        <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>CommonUXControls/StyleSheet/se.ui.min.css"  rel="stylesheet" type="text/css" />   
        <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" /> 
        <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>TelerikAjax/StyleSheet/AWTInput/Input.AWTInput.css" />
          <div id="HeaderDiv">
           <table style="border-collapse:separate;border-spacing:1px;width:98%;margin:0px auto;">
                    <tr>
                        <td>
                            <img src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>Repository/ListControl/images/icons-ribbon/icon-filewatcher-new.png" style="vertical-align:middle;" />
                               <span class="MainHeading"> <%=FTitle%></span> 
                               <span class="description"></span> 
                     
                        </td>
                    </tr>
           </table>
          </div>
            <div id="divbody">            
                <table style="width:97%;border-collapse:separate;border-spacing:4px;margin:0px auto;" border="0" class="tablebg">
                    <tr>
                        <td class="lefttdbg" style="width:50%;padding:1px;">
                            <span class="subtitle">
                                <%=GetLangSpecText("ec_filewatcher_PlcTitle")%>
                                <img runat="server" id="imgMandatory" src="<%$ ReplaceTemplateExpn:Skeltaforms/Images/mandatoryicon.png%>"
                                    visible="true" hspace="2" align="top" />
                                <asp:RequiredFieldValidator ID="ReqSiteUrl" runat="server" ControlToValidate="txtFolderTitle"
                                    Display="Dynamic" Enabled="true">
                                    <img id="imgsiteUrlerror" alt="Enter Title" runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/Images/erroricon.png%>"
                                        hspace="2" align="top" visible="true" />
                                </asp:RequiredFieldValidator>
                            </span>
                        </td>
                        <td class="righttdbg" style="padding:6px;">                            
                             <telerik:RadTextBox ID="txtFolderTitle"  runat="server"  Width="70%" MaxLength="100" EnableEmbeddedSkins="false"  Skin="AWTInput">
                             </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="lefttdbg" style="width: 50%;padding:1px;">
                            <span class="subtitle">
                                <%=GetLangSpecText("ec_filewatcher_PhysicalPath")%>
                                <img runat="server" id="img1" src="<%$ ReplaceTemplateExpn:Skeltaforms/Images/mandatoryicon.png%>"
                                    visible="true" hspace="2" align="top" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtFolderPath"
                                    Display="Dynamic" Enabled="true">
                                    <img id="img2" alt="Enter Physical Path" runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/Images/erroricon.png%>"
                                        hspace="2" align="top" visible="true" />
                                </asp:RequiredFieldValidator>
                            </span>
                            <br />
                            <span class="description">
                                <%=GetLangSpecText("ec_filewatcher_newfolder_eg")%>
                            </span>
                        </td>
                        <td class="righttdbg" style="padding:6px;"> 
                            <telerik:RadTextBox ID="txtFolderPath"  runat="server"  Width="70%"  EnableEmbeddedSkins="false"  Skin="AWTInput">                                        </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="lefttdbg" style="width: 50%;padding:1px;">
                            <span class="subtitle">
                                <%=GetLangSpecText("ec_filewatcher_folder_Buffer")%>
                                <img runat="server" id="img3" src="<%$ ReplaceTemplateExpn:Skeltaforms/Images/mandatoryicon.png%>"
                                    visible="true" hspace="2" align="top" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtBufferSize"
                                    Display="Dynamic" Enabled="true">
                                    <img id="img4" alt="Enter Buffer Size" runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/Images/erroricon.png%>"
                                        hspace="2" align="top" visible="true" />
                                </asp:RequiredFieldValidator>
                            </span>
                            <br />
                            <span class="description">
                                <%=GetLangSpecText("ec_filewatcher_folder_Buffersize")%>
                            </span>
                        </td>
                        <td class="righttdbg" style="padding:6px;">                            
                            <telerik:RadTextBox ID="txtBufferSize"  runat="server"  Width="70%"  EnableEmbeddedSkins="false"  Skin="AWTInput" >                                   
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="lefttdbg" style="width: 50%;padding:1px;">
                            <span class="subtitle">
                                <%=GetLangSpecText("ec_filewatcher_folder_Notify")%>
                            </span>
                            <br />
                            <span class="description">
                                <%=GetLangSpecText("ec_filewatcher_folder_notifydesc")%>
                            </span>
                        </td>
                        <td class="righttdbg" style="padding:1px;" >
                            <asp:RadioButtonList ID="rdNotifyFilter" runat="server" RepeatDirection="Horizontal"
                                CssClass="inputradio">
                             <asp:ListItem Value="1" ></asp:ListItem>
                                <asp:ListItem Value="0" Selected="True"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="lefttdbg" style="width: 50%;padding:1px;">
                            <span class="subtitle">
                                <%=GetLangSpecText("ec_filewatcher_folder_Create")%>
                            </span>
                            <br />
                            <span class="description">
                                <%=GetLangSpecText("ec_filewatcher_folder_createdesc")%>
                            </span>
                        </td>
                        <td class="righttdbg" style="padding:1px;">
                            <asp:RadioButtonList ID="rdBtnCreate" runat="server" RepeatDirection="Horizontal"
                                CssClass="inputradio">
                                <asp:ListItem Value="1"  Selected="True"></asp:ListItem>
                                <asp:ListItem Value="0"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="lefttdbg" style="width: 50%;padding:1px;">
                            <span class="subtitle">
                                <%=GetLangSpecText("ec_filewatcher_folder_Change")%>
                            </span>
                            <br />
                            <span class="description">
                                <%=GetLangSpecText("ec_filewatcher_folder_changedesc")%>
                            </span>
                        </td>
                        <td class="righttdbg" style="padding:1px;">
                            <asp:RadioButtonList ID="rdBtnChange" runat="server" RepeatDirection="Horizontal"
                                CssClass="inputradio">
                                <asp:ListItem Value="1" ></asp:ListItem>
                                <asp:ListItem Value="0" Selected="True"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="lefttdbg" style="width: 50%;padding:1px;">
                            <span class="subtitle">
                                <%=GetLangSpecText("ec_filewatcher_folder_Delete")%>
                            </span>
                            <br />
                            <span class="description">
                                <%=GetLangSpecText("ec_filewatcher_folder_deleteddesc")%>
                            </span>
                        </td>
                        <td class="righttdbg" style="padding:1px;" >
                            <asp:RadioButtonList ID="rdBtnDelete" runat="server" RepeatDirection="Horizontal"
                                CssClass="description">
                                <asp:ListItem Value="1" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="0"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="lefttdbg" style="width: 50%;padding:1px;">
                            <span class="subtitle">
                                <%=GetLangSpecText("ec_filewatcher_folder_Rename")%>
                            </span>
                            <br />
                            <span class="description">
                                <%=GetLangSpecText("ec_filewatcher_folder_renameddesc")%>
                            </span>
                        </td>
                        <td class="righttdbg" style="padding:1px;" >
                            <asp:RadioButtonList ID="rbBtnRename" runat="server" RepeatDirection="Horizontal"
                                CssClass="description">
                                <asp:ListItem Value="1" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="0"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                </table>
                    </div>
       
                <div id="divfooter">
                    <table style="width:100%;margin:0px auto;height:20px;padding-top:0px;">
                        <tr>
                            <td style="text-align:right;vertical-align:bottom;height:20px;padding-right:10px;">
                                <asp:Button runat="server" ID="SaveButton" CssClass="inputbutton"  />
                            </td>                           
                        </tr>
                       
                    </table>
                </div>                  
        
        
    </form>
     </div>
</body>
</html>
<script type="text/javascript" language="javascript">
   
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
 var bodydiv = document.getElementById('divbody');
 var headerdiv = document.getElementById('HeaderDiv');
 var footerdiv = document.getElementById('divfooter');
var parentdiv = document.getElementById('divparent');
if (parentdiv.offsetParent==document.body)
    document.body.style.height = '99%';
    var parentdivheight = parentdiv.offsetParent.offsetHeight;
    parentdiv.style.height =  parentdivheight +'px' ;
    try
    {
        
       bodydiv.style.height = parentdivheight - headerdiv.offsetHeight - footerdiv.offsetHeight +'px' ;
        
    }
    catch (e)
    {

    }
    //bodydiv.style.width = '100px';           
    //bodydiv.style.width =  parentdiv.clientWidth;
    bodydiv.style.overflow =  'hidden';
    parentdiv.style.overflow = 'hidden';
}
</script>