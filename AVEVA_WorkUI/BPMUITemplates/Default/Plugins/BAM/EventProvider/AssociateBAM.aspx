<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.AssociateBam" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
 <!DOCTYPE html>
<html>
<head id="Head1">
    <title>
        <%=GR.GetString("BAMAlerts_AssociateBAM")%>
    </title>
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <style type="text/css">

        html, body
        {
            height: 100%;
        }
    </style>

    <script type="text/javascript">
     
    function OpenRadWindowOverDue()
    {           
        var WorkflowName = document.getElementById("<%=hidWorkflow.ClientID%>").value;
        var ApplicationName = document.getElementById("<%=hidApplication.ClientID%>").value;        
        var oWindow1 = window.radopen("BAMOverDueLookup.aspx?ApplicationName=" +ApplicationName+"&WorkflowName=" + WorkflowName, null); 
        oWindow1.set_modal(true);   
        oWindow1.setSize(500,420);
        oWindow1.set_iconUrl("..\images\Icon-ListExplorer.png");

        oWindow1.add_beforeClose(onClientBeforeCloseFillOverDue);

        function onClientBeforeCloseFillOverDue(sender, args)
        {
            var returnlistid = args.get_argument();

            if (returnlistid !== null && returnlistid !== undefined)
            {
                var hidSlots = document.getElementById("<%=hidSlots.ClientID%>");
                hidSlots.value = returnlistid;
            }

            sender.remove_beforeClose(onClientBeforeCloseFillOverDue);
        }
    }
    
    function OpenRadWindowKpi()
    {       
        var WorkflowName = document.getElementById("<%=hidWorkflow.ClientID%>").value;
        var ApplicationName = document.getElementById("<%=hidApplication.ClientID%>").value;
        var oWindow1 = window.radopen("BAMKpiLookup.aspx?ApplicationName=" +ApplicationName+"&WorkflowName=" + WorkflowName, null); 
        oWindow1.set_modal(true);
        oWindow1.setSize(500,400);
        oWindow1.set_iconUrl("..\images\Icon-ListExplorer.png");

        oWindow1.add_beforeClose(onClientBeforeCloseFillKpi);

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
    }
  
    </script>

</head>
<body>
    <form id="form1" runat="server" style="height:100%;">
    <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
    <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
    <link href="<%:cssPath%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="<%:cssPath%>CommonUXControls/StyleSheet/se.ui.min.css" />
    <link rel="stylesheet" type="text/css" href="<%:cssPath%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
    <link rel="stylesheet" type="text/css" href="<%:cssPath%>TelerikAjax/StyleSheet/AWTWindow/Window.css">
    <link rel="stylesheet" type="text/css" href="<%:cssPath%>TelerikAjax/StyleSheet/AWTCalendar/Calendar.AWTCalendar.css">
    <link rel="stylesheet" type="text/css" href="<%:cssPath%>TelerikAjax/StyleSheet/AWTCalendar/Calendar.css">
    <link rel="stylesheet" type="text/css" href="<%:cssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css">
    <link rel="stylesheet" type="text/css" href="<%:cssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css">
    <script>
         // Initialize locales for message dialog
         se.ui.messageDialog.setGlobalOptions({
             localization: { // All localization related default can be set
                 closeButtonCaption: "<%=GR.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                 okButtonCaption: "<%=GR.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                 cancelButtonCaption: "<%=GR.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                 showDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                 hideDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
             }
         });
         function DisplayMessage() {
             var message = '<%=GR.GetString("SilentInstallation_InvalidInputs") %>';
             se.ui.messageDialog.showError("", message);
         }
    </script>
        <div style="height:100%;">
            <table style="border-spacing:1px;border-collapse:separate;border-width:0;width:98%;margin:auto;height:10%;">
                <tr>
                    <td class="pagetitle ">
                        <img src="<%:cssPath%>Plugins/BAM/Images/BAMChart.png" alt="" style="vertical-align:middle"/> <%=BTitle%>
                    </td>
                </tr>
                <tr>
                    <td style="width:100%"  colspan="2">
                                                <span class="description">
                            <%=GR.GetString("BAMAlerts_BAMText")%>
                        </span>
                    </td>
                </tr>
            </table>
            <br />
            <telerik:RadWindowManager ID="RadWindowManager1" Skin="AWTWindow" EnableEmbeddedSkins="false"
                         runat="server" Behaviors="Close" RenderMode="Classic" VisibleStatusbar="false">
            </telerik:RadWindowManager>
            <table style="border-spacing:1px;border-collapse:separate;border-width:0;width:98%;margin:auto;height:45%;" class="tablebg">
                <tr>
                    <td class="lefttdbg" style="width: 50%;padding:5px">
                        <span class="subtitle">
                            <%=GR.GetString("BAMAlerts_Workflow")%>
                        </span>
                    </td>
                    <td class="righttdbg" style="padding:4px">
                    <telerik:RadComboBox   ID="RadCWorkflow" EnableLoadOnDemand="true" RenderMode="Classic" runat="server"  Skin="AWTCombobox"  AutoPostBack="True"  Width="152px"
                        EnableEmbeddedSkins="false" ShowWhileLoading ="true" UseEmbeddedScripts="false" OnSelectedIndexChanged="RadCWorkflow_SelectedIndexChanged" Height="100px">
                     </telerik:RadComboBox>   
                    </td>
                </tr>
                <tr>
                    <td class="lefttdbg" style="padding:5px">
                        <span class="subtitle">
                            <%=GR.GetString("BAMAlerts_Basedon")%>
                        </span>
                    </td>
                    <td class="righttdbg"  colspan ="3" style="padding:2px">
                    <table>
                    <tr>
                    <td > 
                        <asp:DropDownList ID="ddlBasedOn" runat="server" CssClass="inputselect" AutoPostBack="true" style="width:152px;" >
                        </asp:DropDownList>
                    </td>
                    <td class="righttdbg" id="TrOverdue" runat="server" style="padding:3px" visible="false">
                        <input type="button" id="btnOpenSlots" class="inputbutton" onclick="Javascript:return OpenRadWindowOverDue();"
                             runat="server" />
                    </td>
                    <td class="righttdbg" id="TrKPI" runat="server" style="padding:3px" visible="false">
                        <input type="button" id="btnOpenKpiSlots"  class="inputbutton" onclick="Javascript:return OpenRadWindowKpi();" style="padding-right:10px;"
                             runat="server" />
                    </td>
                    </tr>
                    </table>
                    </td>
                </tr>
                <tr>
                    <td class="lefttdbg" style="width: 50%;padding:5px">
                        <span class="subtitle">
                            <%=GR.GetString("BAMAlerts_EffectiveFrom")%>
                        </span>
                    </td>
                    <td class="righttdbg" style="padding:5px">
                        <telerik:RadDatePicker RenderMode="Classic" Width="180px" ID="startDate" runat="server" Skin="AWTCalendar" EnableEmbeddedSkins="false">
                                    <Calendar ID="Calendar1" runat="server" Skin="AWTCalendar">
                                    </Calendar>
                                     <DateInput  runat="server">
                                     </DateInput>
                        </telerik:RadDatePicker>                    
                    </td>
                </tr>
                <tr>
                    <td class="lefttdbg" style="padding:5px">
                        <span class="subtitle">
                            <%=GR.GetString("BAMAlerts_EffectiveTo")%>
                            </span>
                    </td>
                    <td class="righttdbg" style="padding:5px" >
                        <telerik:RadDatePicker RenderMode="Classic" Width="180px" ID="endDate" runat="server" Skin="AWTCalendar" EnableEmbeddedSkins="false">
                                    <Calendar ID="Calendar2" runat="server" Skin="AWTCalendar">
                                    </Calendar>
                                     <DateInput  runat="server">
                                     </DateInput>
                        </telerik:RadDatePicker>                       
                    </td>
                </tr>
            </table>
            <div id="footerdiv" style="padding-top:50px;">
                <table style="width:99%;margin:auto;border-width:0;height:100px" >
                    <tr id="Tr6" runat="server" style="text-align:right">
                        <td id="Td7" runat="server" style="width:50%;padding-right:10px;" colspan="2">
                            
                            <asp:Button ID="btnReset" runat="server" CssClass="inputsecondarybutton" />
                            <asp:Button ID="AttachEvent" runat="server" CssClass="inputbutton" OnClientClick="return ValidateData();" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <input type="hidden" runat="server" id="hidSlots" />
        <input type="hidden" runat="server" id="hidKpis" />
        <input type="hidden" runat="server" id="hidApplication" />
        <input type="hidden" runat="server" id="hidWorkflow" />
    </form>
</body>
</html>

<script type="text/javascript">
    
    function ValidateData()
    {          
        var varWorkflow = document.getElementById("<%=RadCWorkflow.ClientID%>");
        var varBasedOn = document.getElementById("<%=ddlBasedOn.ClientID%>");      
        var hidKpis =  document.getElementById("<%=hidKpis.ClientID%>");   
        var hidSlots =  document.getElementById("<%=hidSlots.ClientID%>");  
        var hidWorkflow = document.getElementById("<%=hidWorkflow.ClientID%>"); 
        var startDate = document.getElementById("<%=startDate.ClientID%>");
        var endDate = document.getElementById("<%=endDate.ClientID%>");
        var myDate=new Date();    
       
        if(hidWorkflow.value == "")
        {        
            se.ui.messageDialog.showError('<%=GR.GetString("BAMAlerts_AssociateBAM")%>', '<%=GR.GetString("BAMAlerts_ValidateWorkflow")%>');
            return false;        
        }
        if(varBasedOn.selectedIndex == 0)
        {
            se.ui.messageDialog.showError('<%=GR.GetString("BAMAlerts_AssociateBAM")%>', '<%=GR.GetString("BAMAlerts_ValidateBasedOn")%>');
            return false;        
        }       
        if(varBasedOn.selectedIndex == 2)
        {               
            if(hidSlots.value == "")
            {
                se.ui.messageDialog.showError('<%=GR.GetString("BAMAlerts_AssociateBAM")%>', '<%=GR.GetString("BAMAlerts_ValidateSelectOverDue")%>');
                return false;                
            }       
        }
        if(varBasedOn.selectedIndex == 1)
        {
            if(hidKpis.value == "")
            {
                se.ui.messageDialog.showError('<%=GR.GetString("BAMAlerts_AssociateBAM")%>', '<%=GR.GetString("BAMAlerts_ValidateSelectKpi")%>');
                return false;                
            }       
        }       
        
        //Validate the DateRange
        if(startDate.value != "")
        {
            if(endDate.value != "")
            {                
                var Difference = compareDates(endDate.value ,startDate.value);  
                if (Difference == -1)               
                {
                    se.ui.messageDialog.showError('<%=GR.GetString("BAMAlerts_AssociateBAM")%>', '<%=GR.GetString("BAMEvents_ValidateDate")%>');
                    return false;
                }            
            }             
        }
        return true;
     }
    
        
    function compareDates (value1, value2) 
    {
        var date1, date2;
        var month1, month2;
        var year1, year2;

        month1 = value1.substring (value1.indexOf ("-")+1, value1.lastIndexOf ("-"));   
        date1 = value1.substring (value1.lastIndexOf ("-")+1, value1.length);
        year1 = value1.substring (0, value1.indexOf ("-"));

        month2 = value2.substring (value2.indexOf ("-")+1, value2.lastIndexOf ("-"));   
        date2 = value2.substring (value2.lastIndexOf ("-")+1, value2.length);
        year2 = value2.substring (0, value2.indexOf ("-"));

        if (year1 > year2) return 1;
        else if (year1 < year2) return -1;
        else if (month1 > month2) return 1;
        else if (month1 < month2) return -1;
        else if (date1 > date2) return 1;
        else if (date1 < date2) return -1;
        else return 0;
    }    
    
    function SelectKpis()
    {
        var rbKpi =  document.getElementsByName("KPIs");
        var hidKpis = document.getElementById("<%=hidKpis.ClientID%>");
        
        for( i = 0; i < rbKpi.length; i++ )
        {
            if( rbKpi[i].checked == true )
            {           
               hidKpis.value = rbKpi[i].value;
               break;
            }
        }                  
        CloseDivKPI();
    }     
   
</script>

