<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.SOA.CodeBehind.Repository.SOAWebRegistration" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html>
<html style="height:100%">
<head id="Head1" runat="server">
    <title><%=GetLangSpecText("SOA Web Registration")%></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <link href="<%$ ReplaceTemplateExpn:Common/StyleSheet/Global.css%>" rel="stylesheet" type="text/css" />
    <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script>
     <link href="<%$ ReplaceTemplateExpn:CommonUXControls/StyleSheet/se.ui.min.css%>"  rel="stylesheet" type="text/css" />    
    <link href="<%$ ReplaceTemplateExpn:TelerikAjax/StyleSheet/AWTInput/Input.AWTInput.css%>"  rel="stylesheet" type="text/css" />
    <script  type="text/javascript">
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
 oWnd.setSize(700,495);  
}              
    </script>

</head>
<body onload="waitPreloadPage();SizeToFit();" style="margin: 0; left: 0; overflow: hidden;">

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
            font-family: arial; font-size: 16; left: 0px; top: 0px; background-color: white;
            height: 100%; width: 100%;">
            <table>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
            <div  style="text-align:center">
                <font face="verdana" size="4" color="black"><b>Loading data, Please wait... </b></font>
            </div>
            <table visible="false" id="indicator" style="border-width:0;margin:auto;border-spacing:0;" >
                <tr>
                    <td style="margin:auto;width:100%">
                    </td>
                </tr>
            </table>
            <table id="indicatorimage" style="border-width:0;border-spacing:0;width:0;margin:auto" >
                <tr>
                    <td  style="width:100%;margin:auto">
                        <%--<asp:Image ID="imgLoading" runat="server" ImageUrl="<%=templateThemeDirectory%>SOA/images/download_line.gif" />--%>
                        <asp:Image ID="imgLoading" runat="server" ImageUrl="<%$ ReplaceTemplateExpn:SOA/images/download_line.gif%>" />
                    </td>
                </tr>
            </table>
        </div>
        <form id="form1" runat="server" style="height:100%">
             <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
            <%=System.Web.Helpers.AntiForgery.GetHtml()%>           
            <div id="HeaderDiv" style="height:12%">
                <table style="width:100%;margin:auto;border-width:0;border-spacing:0px">
                    
                    <tr>
                        <td rowspan="2" style="vertical-align: middle;width:40px;text-align:center;">
                            <img src="<%=templateThemeDirectory%>SOA/images/icon-SOA-Web-Folder.png"   alt="" /></td>
                        <td class="MainHeading"><%=GetLangSpecText("soa_Webheading") %></td>
                        <asp:Label ID="lblpageHeading" runat="server"></asp:Label>
                    </tr>

                    <tr>
                        <td class="description" style="padding-bottom:10px;">
                          <%=GetLangSpecText("Specify the web uri to consume") %>
                        </td>
                    </tr>

                    
                </table>
            </div>
            <div id="BodyDiv" style="height:79%">
                <table  style="border-width:0;width:96%;margin:auto;margin:auto;border-spacing:1px" class="tablebg">
                    <tr>
                        <td class="lefttdbg" style="width: 45%;vertical-align:top" colspan="2">
                            <span class="subtitle">
                                <%=GetLangSpecText("Name")%>  <img id="imgMandatoryName" alt="Enter Name"  runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/images/mandatoryicon.png%>"
                                    hspace="2" align="top" visible="true" /><asp:RequiredFieldValidator Display="Dynamic" ID="RequiredFieldValidator1" runat="server"
                                                ControlToValidate="txtName" >
                                                <img  alt=" <%=GetLangSpecText("soa_nameforWeberror")%>" id="img1"  src="../../Skeltaforms/images/erroricon.png" />
                                            </asp:RequiredFieldValidator>
                             </span>
                            <br />
                            <span class="description">
                                <%=GetLangSpecText("soa_nameforWeb")%>
                            </span>
                        </td>
                        <td class="righttdbg" colspan="4" style="padding:1px">
                            <telerik:RadTextBox ID="txtName" TabIndex="0" CssClass="inputtext" runat="server" MaxLength="100" Width="50%" EnableEmbeddedSkins="false" Skin="AWTInput">
                             </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="lefttdbg" colspan="2">
                            <span class="subtitle">
                                <%=GetLangSpecText("Web_Uri")%><img id="imgUriManadator" runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/images/mandatoryicon.png%>"
                                    hspace="2" align="top" visible="true" /><asp:RequiredFieldValidator Display="Dynamic" ID="WebUriRequired" runat="server"
                                                ControlToValidate="txtWebUri">
                                                <img alt="<%=GetLangSpecText("soa_uriforWeberror")%>" id="imgUriError"  src="../../Skeltaforms/images/erroricon.png" />
                                            </asp:RequiredFieldValidator>
                               </span>
                            <br />
                            <span class="description">
                                <%=GetLangSpecText("soa_uriforWeb")%>
                            </span>
                        </td>
                        <td class="righttdbg" colspan="4" style="padding:1px">
                             <telerik:RadTextBox ID="txtWebUri" TabIndex="0"  runat="server" MaxLength="100" Width="95%" EnableEmbeddedSkins="false" Skin="AWTInput">
                             </telerik:RadTextBox>  
                        </td>
                    </tr>
                    <tr>
                        <td class="lefttdbg" colspan="2">
                            <span class="subtitle">
                                <%=GetLangSpecText("Description")%>
                            </span>
                            <br />
                            <span class="description">
                                <%=GetLangSpecText("soa_uriDecforWeb")%>
                            </span>
                        </td>
                        <td class="righttdbg" colspan="4" style="padding:1px">
                             <telerik:RadTextBox ID="txtDescription" TabIndex="0" TextMode="MultiLine" runat="server" MaxLength="100" Width="95%"   Height="60px" EnableEmbeddedSkins="false">
                             </telerik:RadTextBox> 
                        </td>
                    </tr>
                    <tr>
                        <td class="lefttdbg" colspan="2">
                            <span class="subtitle">
                                <%=GetLangSpecText("User Name")%>
                            </span>
                            <br />
                            <span class="description">
                                <%=GetLangSpecText("soa_uri_username")%>
                            </span>
                        </td>
                        <td class="righttdbg" colspan="4" style="padding:1px">
                             <telerik:RadTextBox ID="txtUserName" TabIndex="0" runat="server" MaxLength="600" Width="50%" Skin="AWTInput" EnableEmbeddedSkins="false">
                             </telerik:RadTextBox> 
                        </td>
                    </tr>
                    <tr>
                        <td class="lefttdbg" colspan="2">
                            <span class="subtitle">
                                <%=GetLangSpecText("Password")%>
                            </span>
                            <br />
                            <span class="description">
                                <%=GetLangSpecText("soa_uri_password")%>
                            </span>
                        </td>
                        <td class="righttdbg" colspan="4" style="padding:1px">
                            <asp:TextBox ID="txtPassword" TextMode="Password" TabIndex="0" 
                               CssClass="inputtext"  runat="server" MaxLength="600" Width="48%">
                            </asp:TextBox>
                            <asp:HiddenField ID="hiddenPassword" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td class="lefttdbg" colspan="2">
                            <span class="subtitle">
                                <%=GetLangSpecText("Domain")%>
                            </span>
                            <br />
                            <span class="description">
                                <%=GetLangSpecText("soa_uri_domain")%>
                            </span>
                        </td>
                        <td class="righttdbg" colspan="4" style="padding:1px">
                             <telerik:RadTextBox ID="txtDomain" TabIndex="0" runat="server" MaxLength="600" Width="50%" EnableEmbeddedSkins="false" Skin="AWTInput">
                             </telerik:RadTextBox> 
                        </td>
                    </tr>
                  
                </table>
            </div>
            <div id="FooterDiv" style="height:5%;padding-right:5px;">
                <table style="width:100%;border-width:0px;margin:auto;border-spacing:0" >
                    <tr>
                        <td style="width:100%;text-align:right"  colspan="3">
                            &nbsp;
                            <asp:Label ID="InjectScript" runat="server"></asp:Label>
                        </td>
                        <td style="text-align:right;vertical-align:top;padding-right:10px;" colspan="4" >
                            <asp:Button ID="btnTestConnection" TabIndex="0" runat="server"
                                CssClass="inputsecondarybutton"  width="160px" />
                         </td>
                        <td colspan="3" style="text-align:right;vertical-align:top;width:100%;padding-right:5px;" >
                            <asp:Button ID="SaveButton" TabIndex="0" runat="server" CssClass="inputbutton"
                                 />
                        </td>
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

            var parentdivheight = parentdiv.offsetParent.offsetHeight;
        //    parentdiv.style.height =  parentdivheight ;
          //  try{bodydiv.style.height = parentdivheight - headerdiv.offsetHeight - footerdiv.offsetHeight ;}catch(e){}//headerdiv.offsetHeight -
            bodydiv.style.width =  '100%';
            bodydiv.style.width =  parentdiv.clientWidth;
            bodydiv.style.overflow =  'auto';
            parentdiv.style.overflow = 'hidden';
        }
</script>

