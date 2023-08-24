<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.CodeBehind.NewFileWatcherWorkflow" %>

<%@ Register Assembly="Skelta.Forms.Web" Namespace="Skelta.Forms.Web" TagPrefix="cc1" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html >
<html>
<head id="Head1">
    <title>
        <%=rs.GetString("ec_filewatcher_Workflow")%>
    </title>
    <script src="../../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../../Common/JavaScripts/AutoLogoff.js"></script>
    <script type="text/javascript">
               
        function ReloadPage()
        {

        }

        function GetRadWindow() {
            var oWindow = null;
            oWindow = window.frameElement.radWindow;
            return oWindow;
        } 
    </script>
</head>
<body style="margin: 0; left: 0; overflow: hidden; height: 100%" onload="ReloadPage()">
     <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=cssPath2 %>CommonUXControls/StyleSheet/se.ui.min.css" />      
    <script>
        // Initialize locales for message dialog
        se.ui.messageDialog.setGlobalOptions({
            localization: { // All localization related default can be set
                closeButtonCaption: "<%=rs.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                okButtonCaption: "<%=rs.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                cancelButtonCaption: "<%=rs.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                showDetailsCaption: "<%=rs.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                hideDetailsCaption: "<%=rs.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
            }
        });
    </script>
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
    <link href="<%=cssPath2%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" type="text/css" href="<%=cssPath2%>TelerikAjax/StyleSheet/AWTInput/Input.AWTInput.css" />
    <link rel="stylesheet" type="text/css" href="<%=cssPath2%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css" />
    <link rel="stylesheet" type="text/css" href="<%=cssPath2%>TelerikAjax/StyleSheet/AWTWindow/Window.css" />
    <link rel="stylesheet" type="text/css" href="<%=cssPath2%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css" />
    <link rel="stylesheet" type="text/css" href="<%=cssPath2%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css" />
        
    <div id="ParentDiv" style="padding-top:5px;">
                <asp:Panel ID="Panel1" runat="server" Height="100%" Width="100%">
            <div id="HeaderDiv" style="width:100%">
                <table style="width:100%;margin:auto;border-width:0;border-spacing:0px">                    
                    <tr>
                        <td rowspan="2" style="vertical-align: middle;width:40px;text-align:center;">
                            <img alt="" src="<%=cssPath2%>/Repository/ListControl/images/icons-ribbon/icon-FileWatcher-Workflow.png" style="vertical-align: middle" />
                        </td>
                        <td class="MainHeading"> <%=rs.GetString("ec_filewatcher_NewWorkflow", true)%></td>
                        
                    </tr>

                    <tr>
                        <td class="description" style="padding-bottom:10px;">
                            <%= rs.GetString("ec_filewatcher_desc_new", true)%>
                        </td>
                    </tr>                    
                </table>
            </div>
           
            <div id="BodyDiv" style="width:100%;height:100%;overflow: hidden;">
                <table style="width: 94%; border-spacing: 1; border-width: 0; margin: auto" class="tablebg">
                    <tr>
                        <td class="lefttdbg" style="width: 50%; padding: 7px">
                            <span class="subtitle">
                                <%=rs.GetString("ec_filewatcher_PlcTitle", true)%>
                                <img runat="server" id="imgMandatory" src="<%$ReplaceTemplateExpn:Skeltaforms/Images/mandatoryicon.PNG%>"
                                    visible="true" alt="" style="vertical-align: top" />
                                <asp:RequiredFieldValidator ID="ReqSiteUrl" runat="server" ControlToValidate="WorkflowNameInput"
                                    Display="Dynamic" Enabled="true">
                                    <img id="imgsiteUrlerror" alt="" runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/Images/erroricon.png%>"
                                        hspace="2" align="top" visible="true" />
                                </asp:RequiredFieldValidator>
                                <asp:CustomValidator ID="WorkflowNameValidator" runat="server" ControlToValidate="WorkflowNameInput"
                                    SetFocusOnError="true" Display="Dynamic" ValidateEmptyText="true" OnServerValidate="WorkflowNameValidator_ServerValidate"
                                    Enabled="true">
                                    <img id="imgCustom" alt="" runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/Images/erroricon.png%>"
                                        hspace="2" align="top" visible="true" />
                                </asp:CustomValidator>
                            </span>
                            <br />
                            <span class="description">
                                <%=rs.GetString("ec_filewatcher_EnterWfName", true)%>
                            </span>
                        </td>
                        <td class="righttdbg" style="width: 50%; padding: 7px">                           

                             <telerik:RadTextBox ID="WorkflowNameInput"  runat="server" MaxLength="100" Width="50%" EnableEmbeddedSkins="false"  Skin="AWTInput" CausesValidation="true">                                      
                        </telerik:RadTextBox>


                        </td>
                    </tr>
                    <tr>
                        <td class="lefttdbg" style="width: 50%; padding: 7px">
                            <span class="subtitle">
                                <%=rs.GetString("ec_filewatcher_PlcDesc", true)%>
                            </span>
                            <br />
                            <span class="description">
                                <%=rs.GetString("ec_filewatcher_EnterWfDesc", true)%>
                            </span>
                        </td>
                        <td class="righttdbg" style="width: 50%; padding: 7px">                           

                             <telerik:RadTextBox ID="WorkflowDescriptionInput"  runat="server"  Width="99%" Height="70px" TextMode="MultiLine" EnableEmbeddedSkins="false"  Skin="AWTInput" >                                      
                        </telerik:RadTextBox>
                        </td>
                    </tr>
                </table>
                <table style="width: 94%; margin: auto; border-width: 0">
                    <tr>
                        <td style="width: 50%;">
                            <img src="<%=imgPath2%>/icon-associate-events.png" style="vertical-align: middle"
                                alt="" /><span class="pagetitle">
                                    <%=rs.GetString("ec_filewatcher_Associate", true)%></span>
                            <br />
                            <span class="description">
                                <%= rs.GetString("ec_filewatcher_new_desc", true)%>
                            </span>
                        </td>
                    </tr>
                </table>
                <telerik:RadWindowManager ID="RadWindowManager1"  Skin="AWTWindow" EnableEmbeddedSkins="false" 
                                    runat="server" RenderMode="Classic" VisibleStatusbar="false" Height="100%" Behaviors="Close" ReloadOnShow="false" ShowContentDuringLoad="false">
                </telerik:RadWindowManager>
                <table style="width: 94%; border-spacing: 1; border-width: 0; margin: auto" class="tablebg">
                    <tr>
                        <td class="lefttdbg" style="width: 50%; padding: 7px">
                            <span class="subtitle">
                                <%=rs.GetString("ec_filewatcher_Comboeventtype",true )%>
                            </span>
                            <img id="imgType" alt="" runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/Images/erroricon.png%>"
                                style="vertical-align: top" visible="false" />
                        </td>
                        <td class="righttdbg" style="width: 50%; padding: 7px">
                            <asp:DropDownList ID="cmbEventType" runat="server" AutoPostBack="false" CssClass="inputselect"
                                Width="200px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="lefttdbg" style="width: 50%;padding:7px;">
                            <span class="subtitle">
                                 <%=rs.GetString("ec_filewatcher_Comboeventfolder")%>
                            </span>
                            <img id="imgFolder" alt="" runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/Images/erroricon.png%>"
                                hspace="2" align="top" visible="false" />
                        </td>
                        <td class="righttdbg" style="width: 50%;padding:7px">                            
                            <telerik:RadComboBox   ID="cmbFolderList"  RenderMode="Classic" runat="server"  Skin="AWTCombobox"   EnableEmbeddedSkins="false" Height="120px" DropDownWidth="283px" AutoPostBack="false" >
                         </telerik:RadComboBox>

                        </td>
                    </tr>
                    <tr>
                        <td class="lefttdbg" style="width: 50%;padding:7px;">
                            <span class="subtitle">
                              <%=rs.GetString("ec_filewatcher_filefullpath")%>
                            </span>
                            <br />
                            <span class="description">
                                <%=rs.GetString("ec_filewatcher_Pattern")%>
                            </span>
                        </td>
                        <td class="righttdbg" style="width: 50%;padding:7px">
                            <asp:TextBox ID="txtFilePattern" runat="server" CssClass="inputtext" Width="50%"></asp:TextBox>
                            <br />
                            <span class="description"></span>
                        </td>
                    </tr>
                    <tr id="TrSharePointEventsNote" runat="server">
                        <td class="lefttdbg" colspan="3">
                            <img id="Img1" alt="" runat="server" src="<%$ ReplaceTemplateExpn:/Common/Images/icon-note.png%>"
                                style="vertical-align: middle">
                            <span class="note">
                                <%=rs.GetString("_NewWFForm_EvtNoteTitle", true)%>
                                <%=rs.GetString("_NewWFForm_EvtNotes", true)%></span>
                        </td>
                    </tr>
                    
                </table>
                <input type="hidden" id="hidApplication" runat="server" />
                    <input type="hidden" id="hidSlots" runat="server" />
                    <input type="hidden" id="hidWorkflow" runat="server" />
                    <input type="hidden" id="hidKpis" runat="server" />
            </div>
            <div id="FooterDiv">
                <table style="border-spacing:0;width:99%;border-width:0;margin:auto" >
                    <tr>
                        <td style="text-align: right; vertical-align: top; padding-right: 10px;padding-top:20px;">
                         <br />     
                         <asp:Button ID="SaveButton" runat="server" CssClass="inputbutton" />
                        </td>
                    </tr>
                </table>
            </div>
        </asp:Panel>
    </div>
    </form>
</body>
</html>
<script type="text/javascript">

    function AddEventHandler(elementObject, eventName, functionObject) {
        if (document.addEventListener)
            elementObject.addEventListener(eventName, functionObject, false);
        else
            if (document.attachEvent)
                elementObject.attachEvent("on" + eventName, functionObject);
    }

    AddEventHandler(window, "resize", resizefunction);
    AddEventHandler(window, "load", resizefunction);

    function resizefunction() {
        var bodydiv = document.getElementById('BodyDiv');
        var headerdiv = document.getElementById('HeaderDiv');
        var footerdiv = document.getElementById('FooterDiv');
        var parentdiv = document.getElementById('ParentDiv');
        if (parentdiv.offsetParent == document.body)
            document.body.style.height = '100%';

        var parentdivheight = parentdiv.offsetParent.offsetHeight;
        parentdiv.style.height = parentdivheight+'%';
        try { bodydiv.style.height = parentdivheight - headerdiv.offsetHeight - footerdiv.offsetHeight; } catch (e) { } //headerdiv.offsetHeight -
                   bodydiv.style.width =  '100%';
                   bodydiv.style.width =  parentdiv.clientWidth;
             bodydiv.style.overflow =  'auto';
               parentdiv.style.overflow = 'hidden';
    }
</script>
