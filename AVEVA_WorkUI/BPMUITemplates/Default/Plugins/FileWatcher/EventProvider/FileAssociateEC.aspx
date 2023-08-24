<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.AssociateFileWatcher" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html>
<html>
<head runat="server" id="Head1">
    <title>Associate to File Watcher</title>
    <style>
        html, body, form
        {
            height: 100%;
        }

    </style>
</head>
<body>
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <form id="form1" runat="server">
    <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
    <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
    <link href="<%:cssPath%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="<%:cssPath%>CommonUXControls/StyleSheet/se.ui.min.css" />
    <link rel="stylesheet" type="text/css" href="<%:cssPath%>TelerikAjax/StyleSheet/AWTCalendar/Calendar.AWTCalendar.css">
    <link rel="stylesheet" type="text/css" href="<%:cssPath%>TelerikAjax/StyleSheet/AWTCalendar/Calendar.css">
    <link rel="stylesheet" type="text/css" href="<%:cssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css">
    <link rel="stylesheet" type="text/css" href="<%:cssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css">
     <script>
         // Initialize locales for message dialog
         se.ui.messageDialog.setGlobalOptions({
             localization: { // All localization related default can be set
                 closeButtonCaption: "<%=GetLangSpecText("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                 okButtonCaption: "<%=GetLangSpecText("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                 cancelButtonCaption: "<%=GetLangSpecText("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                 showDetailsCaption: "<%=GetLangSpecText("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                 hideDetailsCaption: "<%=GetLangSpecText("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
             }
         });
    </script>
    <div style="height:100%;">
        <table style="border-spacing:1px;border-collapse:separate;border-width:0;width:98%;margin:0px auto;height:10%;">
            <tr>
                <td class="pagetitle ">
                    <img src="<%=cssPath%>Plugins/FileWatcher/Images/filewatcher-icon.png" alt="" style="vertical-align: middle" /><%=GetLangSpecText("ec_filewatcher_titlename")%>
                </td>
            </tr>
            <tr>
                <td style="width: 100%" colspan="2">
                    <br />
                    <span class="description">
                        <%=GetLangSpecText("ec_filewatcher_helptext")%>
                    </span>
                </td>
            </tr>
        </table>
        <br />
        <table style="border-spacing:1px;border-collapse:separate;border-width:0;width:98%;margin:auto;height:50%;" class="tablebg">
            <tr>
                <td class="lefttdbg" style="width: 50%; padding: 7px">
                    <span class="subtitle">
                        <%=GetLangSpecText("ec_filewatcher_eventtype")%>
                           <img alt="" runat="server" id="imgMandatoryEventType" src="<%$ReplaceTemplateExpn:Skeltaforms/Images/mandatoryicon.PNG%>"
                                visible="true" hspace="2" align="top" />
                            <img  id="eventTypeMandatoryImage" alt="Select Folder" runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/Images/erroricon.png%>"
                                hspace="2" align="top" visible="false" />
                      
                    </span>
                </td>
                <td class="righttdbg" style="width: 50%; padding: 7px">
                    <asp:DropDownList ID="ListTypes" runat="server" AutoPostBack="false" CssClass="inputselect">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="lefttdbg" style="width: 50%; padding: 7px">
                    <span class="subtitle">
                        <%=GetLangSpecText("ec_filewatcher_eventport")%>
                        <img runat="server" id="imgMandatory" src="<%$ReplaceTemplateExpn:Skeltaforms/Images/mandatoryicon.PNG%>"
                            visible="true" alt="" style="vertical-align: top" />
                        <img id="imgsiteUrlerror" alt="Select Folder" runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/Images/erroricon.png%>"
                          style="vertical-align: top" visible="false" />
                    </span>
                </td>
                <td class="righttdbg" style="width: 50%; padding: 7px">
                 <telerik:RadComboBox   ID="EventsPort"  RenderMode="Classic" runat="server"  Skin="AWTCombobox"  AutoPostBack="false"
                        EnableEmbeddedSkins="false"  Width="152px" Height="150px" MaxLength="100" NoWrap="true">
                     </telerik:RadComboBox> 
                  </td>
            </tr>
            <tr>
                <td class="lefttdbg" style="width: 50%; padding: 7px">
                    <span class="subtitle">
                        <%=GetLangSpecText("ec_filewatcher_filefullpath")%>
                    </span>
                    <br />
                    <span class="description">
                        <%=GetLangSpecText("ec_filewatcher_Pattern")%>
                    </span>
                </td>
                <td class="righttdbg" style="width: 50%; padding: 7px">
                    <asp:TextBox ID="txtFilePattern" runat="server" CssClass="inputtext" Width="150px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="lefttdbg" style=" padding: 7px">
                    <span class="subtitle">
                        <%=GetLangSpecText("_SP_EventAssoc_FromDate")%>
                    </span>
                </td>
                <td class="righttdbg" style=" padding: 7px">
                  <telerik:RadDatePicker RenderMode="Classic" Width="180px" ID="ActivationFromDate" runat="server" Skin="AWTCalendar" EnableEmbeddedSkins="false">
                                    <Calendar ID="Calendar1" runat="server" Skin="AWTCalendar">
                                    </Calendar>
                                     <DateInput runat="server">
                                     </DateInput>
                  </telerik:RadDatePicker> 
                 
                </td>
            </tr>
            <tr>
                <td class="lefttdbg" style=" padding: 7px">
                    <span class="subtitle">
                        <%=GetLangSpecText("_SP_EventAssoc_ToDate")%>
                    </span>
                </td>
                <td class="righttdbg" style=" padding: 7px">
                    <telerik:RadDatePicker RenderMode="Classic" Width="180px" ID="ActivationToDate" runat="server" Skin="AWTCalendar" EnableEmbeddedSkins="false">
                                    <Calendar ID="Calendar2" runat="server" Skin="AWTCalendar">
                                    </Calendar>
                                     <DateInput runat="server">
                                     </DateInput>
                  </telerik:RadDatePicker> 
                
                </td>
            </tr>
            <tr>
                <td class="lefttdbg" style="width: 50%; padding: 7px">
                    <span class="subtitle">
                        <%=GetLangSpecText("ecm_view_assn_alertver")%>
                    </span>
                </td>
                <td class="righttdbg" style="width: 50%; padding: 7px">
                    <asp:Panel ID="VersionPanel" runat="server">
                    </asp:Panel>
                </td>
            </tr>
        </table>
        <div id="footerdiv">
            <table style="border-width: 0; height: 100px; margin: auto; width:98%;padding-top:30px;">
                <tr style="text-align: right">
                    <td style="width: 50%">
                    </td>
                    <td style="width: 50%;padding-right:10px;">                        
                        <asp:Button ID="CancelEvent" runat="server" CssClass="inputsecondarybutton" CausesValidation="False" />
                        <asp:Button ID="AttachEvent" runat="server" CssClass="inputbutton" CausesValidation="False" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    </form>
</body>
</html>
