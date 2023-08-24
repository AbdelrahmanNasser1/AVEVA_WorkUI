<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.NewListWorkflowForm"  %>

<%@ Register Assembly="Skelta.Forms.Web" Namespace="Skelta.Forms.Web" TagPrefix="cc1" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title><%= rs.GetString("ec_NewSKListWFForm_Title", true)%> </title>
  <style type="text/css">
        html, body
        {
            height: 100%;
            width: 100%;
            padding: 0px;
            margin: 0px;
        }
</style>
</head>

<body  style="width: 100%; margin: 0; left: 0; overflow: auto; height: 90%">
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=cssPath %>CommonUXControls/StyleSheet/se.ui.min.css" />      
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
    <link href="<%=cssPath %>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />

    <link rel="stylesheet" type="text/css" href="<%=cssPath%>TelerikAjax/StyleSheet/AWTInput/Input.AWTInput.css" />
    <link rel="stylesheet" type="text/css" href="<%=cssPath%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css" />
    <link rel="stylesheet" type="text/css" href="<%=cssPath%>TelerikAjax/StyleSheet/AWTWindow/Window.css" />
    <link rel="stylesheet" type="text/css" href="<%=cssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css" />
    <link rel="stylesheet" type="text/css" href="<%=cssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css" />    

        <div id="ParentDiv" style="width:100%;height:100%;padding-top:5px;">
            <asp:Panel ID="Panel1" runat="server" Height="100%" Width=100%>
                <div id="HeaderDiv" style="width:100%">
                    
                    <table style="width:100%;margin:auto;border-width:0;border-spacing:0px">                    
                    <tr>
                        <td rowspan="2" style="vertical-align: middle;width:40px;text-align:center;">
                            <img alt="" src="<%=imgPath %>SkeltaForms/images/icon-new-list-workflow.png" style="vertical-align:middle" />
                        </td>
                        <td class="MainHeading"> <%=rs.GetString("ec_NewSKListWFForm_Title", true)%></td>
                        
                    </tr>

                    <tr>
                        <td class="description" style="padding-bottom:10px;">
                           <%= rs.GetString("ec_NewSKListWFForm_Desc", true)%>
                        </td>
                    </tr>                    
                </table>

                </div>
                <div id="BodyDiv" style="width:100%;height:100%">
                    <asp:ValidationSummary ID="ValidationSummary" runat="server" ShowMessageBox="false"
                        ShowSummary="false" />
                    <table  style="border-spacing:1;border-width:0;width:94%;margin:auto" class="tablebg">
                        <tr>
                            <td class="lefttdbg"  style="width:50%;padding:5px">
                                <span class="subtitle">
                                    <%=rs.GetString("_NewWFForm_PlcTitle",true)%><img alt="Mandatory" id="imgTitlemandator" runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/Images/mandatoryicon.png%>" hspace="2" align="top" visible="true" /><asp:CustomValidator ID="WorkflowNameValidator" runat="server" ControlToValidate="WorkflowNameInput"
                                    SetFocusOnError="true" Display="Dynamic" ValidateEmptyText="true" OnServerValidate="WorkflowNameValidator_ServerValidate"><img alt="" id="imgTitleError" runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/Images/erroricon.png%>" hspace="2"  align="top" visible="true" /></asp:CustomValidator>
                                </span>
                                <br />
                                <span class="description">
                                    <%=rs.GetString("_NewWFForm_EnterWfName",true)%>
                                </span>
                            </td>
                            <td class="righttdbg" style="width:50%;padding:5px">                               

                                <telerik:RadTextBox ID="WorkflowNameInput"  runat="server" MaxLength="100" Width="50%" EnableEmbeddedSkins="false"  Skin="AWTInput" CausesValidation="true">                                      
                        </telerik:RadTextBox>
                                
                            </td>
                        </tr>
                        <tr>
                            <td class="lefttdbg" style="padding:5px">
                                <span class="subtitle">
                                    <%=rs.GetString("_NewWFForm_PlcDesc",true)%>
                                </span>
                                <br />
                                <span class="description">
                                    <%=rs.GetString("_NewWFForm_EnterWfDesc",true)%>
                                </span>
                            </td>
                            <td class="righttdbg" style="padding:5px">                                

                                <telerik:RadTextBox ID="WorkflowDescriptionInput"  runat="server"  Width="99%" Height="75px" TextMode="MultiLine" EnableEmbeddedSkins="false"  Skin="AWTInput" >                                      
                        </telerik:RadTextBox>

                            </td>
                        </tr>
                    </table>
                    <br />
                    <table style="width:94%;margin:auto;border-width:0;border-spacing:0"  >
                        <tr>
                            <td  colspan="3" style="padding:5px">
                                <img src="<%=imgPath %>Plugins/EnterpriseConsole/images/icon-new-list-workflow-asso.png"
                                    alt="" style="vertical-align:middle" /><span class="pagetitle ">
                                        <%=rs.GetString("ec_SKListWFForm_EvtAssocTitle", true)%>
                                    </span>
                            <br />
                                <span class="description">
                                    <%= rs.GetString("ec_NewSKListEventAssoociate_Desc", true)%>
                                </span><br />
                            </td>
                        </tr>
                    </table>
                    <table style="width:94%;margin:auto; border-width:0;border-spacing:1" class="tablebg">
                        <tr>
                            <td class="lefttdbg" style="width: 50%;padding:5px">
                                
                                <span class="subtitle">
                                    <%=rs.GetString("ec_SKListWFForm_SelectList", true)%></span><img alt="Mandatory" id="img2" runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/Images/mandatoryicon.png%>" hspace="2" align="top" visible="true" /><asp:RequiredFieldValidator ID="ListNameInputReqd" runat="server" ControlToValidate="ListNameInput"
                                    Display="Dynamic" Enabled="true"><img alt="List name required" id="imgListNameError" runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/Images/erroricon.png%>" hspace="2" vspace="2" align="top" visible="true" /></asp:RequiredFieldValidator>
                                
                                <br />
                                <span class="description">
                                    <%=rs.GetString("ec_SKListWFForm_SelectListDesc", true)%>
                                </span>
                               
                            </td>
                            <td style="vertical-align:middle;padding:5px" class="righttdbg">                               
                                <telerik:RadTextBox ID="ListNameInput"  runat="server" MaxLength="100" Width="70%" EnableEmbeddedSkins="false"  Skin="AWTInput" ReadOnly="true" >                                      
                                </telerik:RadTextBox>
                                <a href="#"><img src="<%=imgPath %>Plugins/EnterpriseConsole/images/group-explore.gif" style="width:25;
                                    height:23; border-width:0;vertical-align:middle;" alt=""  id="Img1" onclick="exploreList()" /></a>
                                
                                <telerik:RadWindowManager ID="RadWindowManager1" Skin="AWTWindow" EnableEmbeddedSkins="false" 
                                    runat="server" RenderMode="Classic" VisibleStatusbar="false" Height="100%" Behaviors="Close" ReloadOnShow="false" ShowContentDuringLoad="false">
                                </telerik:RadWindowManager>
                                
                            </td>
                        </tr>
                        <tr>
                            <td class="lefttdbg" style="padding:5px;">
                                <span class="subtitle">
                                    <%=rs.GetString("_NewWFForm_EvtTitle",true)%>
                                </span>
                                <br />
                                <span class="description">
                                    <%=rs.GetString("_NewWFForm_SelectEvtQtn",true)%>
                                </span>                               
                            </td>
                            <td style="vertical-align:top;padding:5px" class="righttdbg">
                                

                                 <telerik:RadComboBox   ID="EventsCombo"  RenderMode="Classic" runat="server"  Skin="AWTCombobox"   EnableEmbeddedSkins="false" Height="120px" >
                         </telerik:RadComboBox>


                                <asp:RequiredFieldValidator ID="EventsComboReqd" runat="server" ControlToValidate="EventsCombo"
                                    Display="Dynamic" Enabled="true"></asp:RequiredFieldValidator>
                                <asp:HiddenField ID="ItemIdInput" runat="server" />
                                <asp:HiddenField ID="ListIdInput" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="lefttdbg" colspan="2">
                                <img src="<%=imgPath %>Common/Images/icon-note.png" alt="" style="vertical-align:middle">
                                <span class="note">
                                    <%=rs.GetString("_NewWFForm_EvtNoteTitle", true)%>
                                </span><span class="note">
                                    <%=rs.GetString("_NewWFForm_EvtNotes", true)%>
                                </span>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="FooterDiv">
                   <table id="footerTable" style="border-spacing:0;width:98%;border-width:0;margin:auto" >
                         <tr>
                            <td id="footertd" class="pagetitle " style="padding-right:10px;text-align:right;vertical-align:top">
                             <br />   <asp:Button ID="SaveButton" runat="server" CssClass="inputbutton" OnClick="SaveButton_Click" />
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
    function GetRadWindow()
    {
        var oWindow = null;
        oWindow = window.frameElement.radWindow;
        return oWindow;
    } 
    function exploreList()
    {
        var oWindow1 = radopen("../EventProvider/ListExplorer.aspx?mode=list", null);
        oWindow1.set_modal(true);            
        oWindow1.setSize(350, 380);
        oWindow1.center();
        oWindow1.add_beforeClose(onClientBeforeClose);
    }
        
    function onClientBeforeClose(sender, args)
    {
        var returnlistid = args.get_argument();

        if (returnlistid !== null && returnlistid !== undefined)
        {
            var listName = <%=ListNameInput.ClientID %>;
            var dataArray = returnlistid.split("/");
            document.getElementById('ListIdInput').value = dataArray[0];

            if (dataArray.length > 2)
            {
                var listNameTextBox = $find('<%=ListNameInput.ClientID %>');
                listNameTextBox.set_value(dataArray[2]);//returnlistid;
                document.getElementById("ListNameInputReqd").disabled = true;
            }
        }

        sender.remove_beforeClose(onClientBeforeClose);
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
        if (parentdiv.offsetParent == document.body)
            document.body.style.height = '100%';

        var parentdivheight = parentdiv.offsetParent.offsetHeight;
        parentdiv.style.height = parentdivheight + "%";
        try { bodydiv.style.height = parentdivheight - headerdiv.offsetHeight - footerdiv.offsetHeight + "%"; } catch (e) { }//headerdiv.offsetHeight -
        bodydiv.style.width = '100%';
        bodydiv.style.width = parentdiv.clientWidth;
        bodydiv.style.overflow = 'auto';
        parentdiv.style.overflow = 'hidden';

    }
</script>
