<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.Bam.NewWFForm"
     %>
<%@ Register Assembly="Skelta.Forms.Web" Namespace="Skelta.Forms.Web" TagPrefix="cc1" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE html >
<html>
<head id="Head1">
    <title>
        <%=rs.GetString("bamwf_BAMWorkflow")%>
    </title>
    <script type="text/javascript">
        function OpenRadWindowOverDue() {
            var WorkflowName = document.getElementById("<%=hidWorkflow.ClientID%>").value;
            var ApplicationName = document.getElementById("<%=hidApplication.ClientID%>").value;
            var oWindow1 = radopen("../EventProvider/BAMOverDueLookup.aspx?ApplicationName=" + ApplicationName + "&WorkflowName=" + WorkflowName, null);
            oWindow1.set_modal(true);
            oWindow1.setSize(450, 420);
            oWindow1.center();
            oWindow1.add_beforeClose(onClientBeforeCloseFillOverdue);
        }

        function onClientBeforeCloseFillOverdue(sender, args)
        {
            var returnlistid = args.get_argument();

            if (returnlistid !== null && returnlistid !== undefined)
            {
                var hidSlots = document.getElementById("<%=hidSlots.ClientID%>");
                hidSlots.value = returnlistid;
            }

            sender.remove_beforeClose(onClientBeforeCloseFillOverdue);
        }

        function OpenRadWindowKpi() {
            var WorkflowName = document.getElementById("<%=hidWorkflow.ClientID%>").value;
            var ApplicationName = document.getElementById("<%=hidApplication.ClientID%>").value;
            var oWindow1 = radopen("../EventProvider/BAMKpiLookup.aspx?ApplicationName=" + ApplicationName + "&WorkflowName=" + WorkflowName, null);
            oWindow1.set_modal(true);
            oWindow1.setSize(450, 400);
            oWindow1.center();
            oWindow1.add_beforeClose(onClientBeforeCloseFillKpi);
        }

        function onClientBeforeCloseFillKpi(sender, args)
        {
            var returnlistid = args.get_argument();

            if (returnlistid !== null && returnlistid !== undefined)
            {
                var hidKpis = document.getElementById("<%=hidKpis.ClientID%>");
                hidKpis.value = returnlistid;
            }

            sender.remove_beforeClose(onClientBeforeCloseFillKpi);
        }

        function GetRadWindow() {
            var oWindow = null;
            oWindow = window.frameElement.radWindow;
            return oWindow;
        }
    </script>
</head>
<body>
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=ThemePath%>CommonUXControls/StyleSheet/se.ui.min.css" /> 
    <link rel="stylesheet" type="text/css" href="<%=ThemePath%>TelerikAjax/StyleSheet/AWTInput/Input.AWTInput.css" />
    <link rel="stylesheet" type="text/css" href="<%=ThemePath%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css" />
    <link rel="stylesheet" type="text/css" href="<%=ThemePath%>TelerikAjax/StyleSheet/AWTWindow/Window.css" />
    <link rel="stylesheet" type="text/css" href="<%=ThemePath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css" />
    <link rel="stylesheet" type="text/css" href="<%=ThemePath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css" />
    <link rel="stylesheet" type="text/css" href="<%=ThemePath%>TelerikAjax/StyleSheet/AWTCalendar/Calendar.AWTCalendar.css" />
    <link rel="stylesheet" type="text/css" href="<%=ThemePath%>TelerikAjax/StyleSheet/AWTCalendar/Calendar.css" />

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
    <div id="ParentDiv" style="width: 100%; height: 60%;padding-top:5px;">
        <form id="form1" runat="server" style="width: 100%; height: 100%">
         <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
            <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        <link href="<%=cssPath2%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
        <div id="HeaderDiv" style="width: 100%; height: 10%;">
            

             <table style="width:100%;margin:auto;border-width:0;border-spacing:0px">                    
                    <tr>
                        <td rowspan="2" style="vertical-align: middle;width:40px;text-align:center;">
                            <img src="<%=ThemePath%>Repository/ListControl/images/icons-ribbon/BAM-Workflow.png" alt="" style="vertical-align: middle" /></td>
                        <td class="MainHeading"> <%=rs.GetString("bamwf_NewBAMWorkflow", true)%></td>
                        
                    </tr>

                    <tr>
                        <td class="description" style="padding-bottom:10px;">
                           <%= rs.GetString("BAM_Workflow_new", true)%>
                        </td>
                    </tr>                    
                </table>

        </div>
        <div id="BodyDiv" style="width: 100%; height: 80%">
            <table style="border-spacing:1;border-width:0;border-collapse:separate;width:94%;margin:auto" class="tablebg">
                <tr>
                    <td class="lefttdbg" style="width: 50%;padding:5px">
                        <span class="subtitle">
                            <%=rs.GetString("_NewWFForm_PlcTitle",true)%>
                            <img runat="server" id="imgMandatory" src="<%$ReplaceTemplateExpn:Skeltaforms/Images/mandatoryicon.PNG%>"
                                visible="true" alt="" style="vertical-align: top" /><asp:RequiredFieldValidator ID="ReqSiteUrl"
                                    runat="server" ControlToValidate="WorkflowNameInput" Display="Dynamic" Enabled="true">
                                    <img id="imgsiteUrlerror" alt="Enter Workflow Name" runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/Images/erroricon.png%>"
                                        style="vertical-align: top" visible="true" />
                                </asp:RequiredFieldValidator>
                        </span>
                        <asp:CustomValidator ID="WorkflowNameValidator" runat="server" ControlToValidate="WorkflowNameInput"
                            SetFocusOnError="true" Display="Dynamic" ValidateEmptyText="true" OnServerValidate="WorkflowNameValidator_ServerValidate">
                            <img alt="" id="imgCustom" runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/Images/erroricon.png%>"
                                hspace="2" align="top" visible="false" />
                        </asp:CustomValidator>
                        <br />
                        <span class="description">
                            <%=rs.GetString("BAM_wflw_Title", true)%>
                        </span>
                    </td>
                    <td class="righttdbg" style="width: 50%;padding:5px">                        
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
                            <%=rs.GetString("BAM_wflw_desc", true)%>
                        </span>
                    </td>
                    <td class="righttdbg" style="padding:5px">
                        <telerik:RadTextBox ID="WorkflowDescriptionInput"  runat="server"  Width="99%" Height="55px" TextMode="MultiLine" EnableEmbeddedSkins="false"  Skin="AWTInput" >                                      
                        </telerik:RadTextBox>

                    </td>
                </tr>
            </table>
            <table style="width: 94%; margin: auto; border-width: 0">
                <tr>
                    <td>
                        <img src="<%=imgPath2%>/Associations-small-icon.png" alt="" style="vertical-align: middle" /><span
                            class="pagetitle"><%=rs.GetString("bamwf_AssociateBAMEvent",true)%></span>
                        <br />
                        <span class="description" style="padding:4px;">
                            <%= rs.GetString("BAM_wflw_associate", true)%>
                        </span>
                    </td>
                </tr>
            </table>

        <telerik:RadWindowManager ID="RadWindowManager1"  Skin="AWTWindow" EnableEmbeddedSkins="false" 
         runat="server"  RenderMode="Classic" VisibleStatusbar="false" Height="100%" Behaviors="Close" ReloadOnShow="false" ShowContentDuringLoad="false">         
      </telerik:RadWindowManager>

            
            <table style="width: 94%; border-spacing: 1; border-width: 0; margin: auto" class="tablebg">
                <tr>
                    <td class="lefttdbg" style="width: 50%; padding: 5px">
                        <span class="subtitle">
                            <%=rs.GetString("BAMAlerts_Workflow")%>
                        </span>
                    </td>
                    <td class="righttdbg" style="padding: 5px">
                         <telerik:RadComboBox   ID="RadCWorkflow" EnableLoadOnDemand="true" RenderMode="Classic" runat="server"  Skin="AWTCombobox" Height="120px" Width="150px"  AutoPostBack="True"  EnableEmbeddedSkins="false" ShowWhileLoading="true"  OnSelectedIndexChanged="RadCWorkflow_SelectedIndexChanged">
                         </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td class="lefttdbg" style="width: 50%;padding:5px">
                        <span class="subtitle">
                            <%=rs.GetString("BAMAlerts_Basedon")%>
                            <img id="img2" alt="" runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/Images/erroricon.png%>"
                                hspace="2" align="top" visible="true" />
                        </span>
                    </td>
                    <td colspan="3" class="righttdbg" style="padding: 5px">
                        <table>
                            <tr>
                                <td class="righttdbg" style="padding: 0px">
                                    <asp:DropDownList ID="ddlBasedOn" runat="server" CssClass="inputselect" AutoPostBack="true"
                                        Width="150px">
                                    </asp:DropDownList>
                                </td>
                                <td id="TrOverdue" runat="server" visible="false" class="righttdbg" style="padding: 5px">
                                    <input type="button" id="btnOpenSlots" class="inputbutton" onclick="Javascript:return OpenRadWindowOverDue();"
                                        style="width: 110px;" runat="server" />
                                </td>
                    <td id="TrKPI" runat="server" visible="false" class="righttdbg" style="padding: 5px">
                        <input type="button" id="btnOpenKpiSlots" class="inputbutton" onclick="Javascript:return OpenRadWindowKpi();"
                            style="width: 110px;padding-right:10px;" runat="server" />
                    </td>
                    </tr> </table> </td>
                </tr>
                <tr>
                    <td class="lefttdbg" style="width: 50%; padding: 5px">
                        <span class="subtitle">
                            <%=rs.GetString("BAMAlerts_EffectiveFrom")%>
                        </span>
                    </td>
                    <td class="righttdbg" style="padding: 5px">
                        

                        <telerik:RadDatePicker RenderMode="Classic" Width="175px" ID="startDate" runat="server" Skin="AWTCalendar" EnableEmbeddedSkins="false">
                                    <Calendar ID="Calendar1" runat="server" Skin="AWTCalendar">
                                    </Calendar>
                                     <DateInput  runat="server">
                                     </DateInput>
                        </telerik:RadDatePicker>  

                    </td>
                </tr>
                <tr>
                    <td class="lefttdbg" style="width: 50%; padding: 5px">
                        <span class="subtitle">
                            <%=rs.GetString("BAMAlerts_EffectiveTo")%>
                        </span>
                    </td>
                    <td class="righttdbg" colspan="3" style="padding: 5px">

                        <telerik:RadDatePicker RenderMode="Classic" Width="175px" ID="endDate" runat="server" Skin="AWTCalendar" EnableEmbeddedSkins="false">
                                    <Calendar ID="Calendar2" runat="server" Skin="AWTCalendar">
                                    </Calendar>
                                     <DateInput  runat="server">
                                     </DateInput>
                        </telerik:RadDatePicker>  
                       
                    </td>
                </tr>
                <tr id="TrSharePointEventsNote" runat="server">
                    <td class="lefttdbg" colspan="4" style="padding: 5px">
                        <img id="Img1" runat="server" src="<%$ ReplaceTemplateExpn:/Common/Images/icon-note.png%>"
                            alt="" style="vertical-align: middle">
                        <span class="note">
                            <%=rs.GetString("_NewWFForm_EvtNoteTitle", true)%>
                            <%=rs.GetString("_NewWFForm_EvtNotes", true)%></span>
                    </td>
                </tr>
                <input type="hidden" id="hidApplication" runat="server" />
                <input type="hidden" id="hidSlots" runat="server" />
                <input type="hidden" id="hidWorkflow" runat="server" />
                <input type="hidden" id="hidKpis" runat="server" />
            </table>
        </div>
        <div id="FooterDiv" style="width: 99%; height: 10%">
            <table style="width: 100%; border-spacing: 0; margin: auto; border-width: 0">
                <tr style="vertical-align: bottom">
                    <td style="text-align: right; vertical-align: top;padding-right:5px;padding-top:25px;">
                        <br />
                        <asp:Button ID="SaveButton" runat="server" CssClass="inputbutton" OnClientClick="return ValidateData();" />
                    </td>
                </tr>
            </table>
        </div>
        </form>
    </div>
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
        parentdiv.style.height = parentdivheight + '%';
        try { bodydiv.style.height = parentdivheight - headerdiv.offsetHeight - footerdiv.offsetHeight + '%'; } catch (e) { } //headerdiv.offsetHeight -
                   bodydiv.style.width =  '100%';
                   bodydiv.style.width =  parentdiv.clientWidth;
                    bodydiv.style.overflow =  'auto';
                   parentdiv.style.overflow = 'hidden';
    }


    function ValidateData() {
        var varWorkflow = document.getElementById("<%=RadCWorkflow.ClientID%>");
        var varBasedOn = document.getElementById("<%=ddlBasedOn.ClientID%>");
        var hidKpis = document.getElementById("<%=hidKpis.ClientID%>");
        var hidSlots = document.getElementById("<%=hidSlots.ClientID%>");
        var hidWorkflow = document.getElementById("<%=hidWorkflow.ClientID%>");
        var startDate = document.getElementById("<%=startDate.ClientID%>");
        var endDate = document.getElementById("<%=endDate.ClientID%>");
        var myDate = new Date();

        if (hidWorkflow.value != "") {
            if (varBasedOn.selectedIndex == 0) {


                se.ui.messageDialog.showError(" <%=rs.GetString("bamwf_BAMWorkflow")%>", '<%=rs.GetString("BAMAlerts_ValidateBasedOn")%>');
                return false;
            }
            if (varBasedOn.selectedIndex == 2) {
                if (hidSlots.value == "") {
                    se.ui.messageDialog.showError(" <%=rs.GetString("bamwf_BAMWorkflow")%>", '<%=rs.GetString("BAMAlerts_ValidateSelectOverDue")%>');
                    return false;
                }
            }
            if (varBasedOn.selectedIndex == 1) {
                if (hidKpis.value == "") {
                    se.ui.messageDialog.showError(" <%=rs.GetString("bamwf_BAMWorkflow")%>", '<%=rs.GetString("BAMAlerts_ValidateSelectKpi")%>');
                    return false;
                }
            }

            //Validate the DateRange
            if (startDate.value != "") {
                if (endDate.value != "") {
                    var Difference = compareDates(endDate.value, startDate.value);
                    if (Difference == -1) {
                        se.ui.messageDialog.showError(" <%=rs.GetString("bamwf_BAMWorkflow")%>", '<%=rs.GetString("BAMEvents_ValidateDate")%>');
                        return false;
                    }
                }
            }
            return true;
        }
    }

    function compareDates(value1, value2) {
        var date1, date2;
        var month1, month2;
        var year1, year2;

        month1 = value1.substring(value1.indexOf("-") + 1, value1.lastIndexOf("-"));
        date1 = value1.substring(value1.lastIndexOf("-") + 1, value1.length);
        year1 = value1.substring(0, value1.indexOf("-"));

        month2 = value2.substring(value2.indexOf("-") + 1, value2.lastIndexOf("-"));
        date2 = value2.substring(value2.lastIndexOf("-") + 1, value2.length);
        year2 = value2.substring(0, value2.indexOf("-"));

        if (year1 > year2) return 1;
        else if (year1 < year2) return -1;
        else if (month1 > month2) return 1;
        else if (month1 < month2) return -1;
        else if (date1 > date2) return 1;
        else if (date1 < date2) return -1;
        else return 0;
    }
</script>
