<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.AssociateEnterprise" %>
<%@ Register Assembly="Skelta.Repository.Web" Namespace="Skelta.Repository.Web.Lookup" TagPrefix="cc1" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html>
<html>
<head runat="server" id="Head1">
    <title>Associate to Enterprise List</title>
    <style type="text/css">

        html, body
        {
            height: 100%;
        }
    </style>
</head>
<script type="text/javascript">
/*<![CDATA[*/
    /*****************************************************************/
    /* list explorer functions
    /*****************************************************************/
var clientidinside;
var clientidinside2;

    function selectListId() {
        var modevar = "";
        var listType = document.getElementById("ListTypes");
        modevar = listType.value;
        var oWindow1 = parent.window.document.getElementById('eventAssociationFrame').contentWindow.radopen("ListExplorer.aspx?mode=" + modevar, null);
        oWindow1.set_modal(true);

        var themePath = '<%=Workflow.NET.Config.GetTemplateDirectoryFromWebConfig()%>';
        if (themePath.indexOf('layouts') > -1) {
            oWindow1.setSize(400, 300);
        }
        else {
            oWindow1.setSize(450, 420);
        }
        oWindow1.set_iconUrl("..\images\Icon-ListExplorer.png");

        oWindow1.add_beforeClose(onClientBeforeCloseFillListIds);

        function onClientBeforeCloseFillListIds(sender, args)
        {
            var returnlistid = args.get_argument();

            if (returnlistid !== null && returnlistid !== undefined)
            {
                var dataArray = returnlistid.split("/");
                var list = document.getElementById('txtListId');
                var listitem = document.getElementById('txtListItemId');
                var hidListId = "<%= hdnListId.ClientID %>";
                var hidListItemId = "<%= hdnListItemId.ClientID %>";

                if (dataArray != null && dataArray != ',')
                {
                    list.value = dataArray[2];//returnlistid;
                    listitem.value = dataArray[3];//returnlistitemid;
                    var hidListId = "<%= hdnListId.ClientID %>";
                    document.getElementById(hidListId).value = dataArray[0];//storing list id in Hidden varaible

                    var hidListItemId = "<%= hdnListItemId.ClientID %>";
                    document.getElementById(hidListItemId).value = dataArray[1];//storing listitem id in Hidden varaible
                    document.getElementById("ListTypes").disabled = false;
                    document.getElementById('Events').disabled = false;
                }
            }

            sender.remove_beforeClose(onClientBeforeCloseFillListIds);
        }
    }
    /*****************************************************************/
    
    var calendar, popup, calendarContainer, activeInput, isVisible;
    
    
	function ToggleCalendar(e, inputId)
	{
		ShowCalendar(inputId);
		e.cancelBubble = true;		
	}
	    
    function ShowCalendar(inputId)
    {
       
        if (!calendar)
            calendar = calControlID;
        if (!popup)
            popup = new RadCalendar.Popup();
            
        if (!calendarContainer)
            calendarContainer = document.getElementById("calendarContainer");
            
        if (activeInput
			&& activeInput.id == inputId
			&& popup.IsVisible())
		{
			popup.Hide();
			
			
		}			
		else
		{        
			activeInput = document.getElementById(inputId);
			var x = PositionX(activeInput);
			var y = PositionY(activeInput) + activeInput.offsetHeight;
	        
			popup.Show(x, y, calendarContainer);
			
		}
    }
    
    function ChangeInput(calendarInstance,renderDay)
    {   
        var dateArray = renderDay.Date;  
        var dateString = dateArray[1] + "/" + dateArray[2] + "/" + dateArray[0];
        
        activeInput.value = dateString;
          
        
        if (popup.IsVisible())
		{
			popup.Hide();
			
		}
    }
    
    function PositionX(inputElement) 
    {
	    var offsetLeft = 0;
	    if(inputElement!=null)
	    {
	        if (inputElement.offsetParent)
	        {
	            while (inputElement.offsetParent)
	            {
		            offsetLeft += inputElement.offsetLeft;
		            inputElement = inputElement.offsetParent;
	            }
	        }
	        else if (inputElement.x)
	        {
		        offsetLeft += inputElement.x;
	        }
	    }
	    return offsetLeft;
    }
    function PositionY(inputElement) 
    {
	    var offsetTop = 0;
	    if(inputElement!=null)
	    {
	        if (inputElement.offsetParent)
	        {
		        while (inputElement.offsetParent)
		        {
		            offsetTop += inputElement.offsetTop;
		            inputElement = inputElement.offsetParent;
		        }
	        }
	        else if (inputElement.y)
	        {
		        offsetTop += inputElement.y;
	        }
	    }
	    return offsetTop;
    }

/*]]>*/
</script>
<body>
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=cssPath%>CommonUXControls/StyleSheet/se.ui.min.css" />
    <link rel="stylesheet" type="text/css" href="<%=cssPath%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
    <link rel="stylesheet" type="text/css" href="<%=cssPath%>TelerikAjax/StyleSheet/AWTWindow/Window.css">
    <link rel="stylesheet" type="text/css" href="<%=cssPath%>TelerikAjax/StyleSheet/AWTCalendar/Calendar.AWTCalendar.css">
    <link rel="stylesheet" type="text/css" href="<%=cssPath%>TelerikAjax/StyleSheet/AWTCalendar/Calendar.css">
     <link rel="stylesheet" type="text/css" href="<%=cssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css">
    <link rel="stylesheet" type="text/css" href="<%=cssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css">
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
    <form id="form1" runat="server" style="overflow: hidden;height:100%;">
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
	<%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <link href="<%=cssPath%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
    <div style="height:100%; overflow:auto">
        <div id="Bodydiv" style="overflow: hidden;">
            <table style="border-spacing: 1px; border-collapse:separate; border-width: 0; width: 98%; margin: auto">
                <tr>
                    <td class="pagetitle" style="padding:5px;">
                        <img src="<%=cssPath%>Plugins/EnterpriseConsole/Images/icon-enterprise.png" alt="" style="vertical-align: middle" />
                        <%=ETitle%>
                    </td>
                </tr>
                <tr>
                    <td style="width: 100%;padding:5px;" colspan="2">
                        <span class="description">
                            <%=GetLangSpecText("ecm_assn_helptext") %>
                        </span>
                    </td>
                </tr>
            </table>
            <table style="border-spacing: 1px; border-collapse:separate;border-width: 0; width: 98%; margin: auto;height:60%;" class="tablebg">
                <tr>
                    <td class="lefttdbg" style="width: 50%; padding: 7px">
                        <span class="subtitle">
                            <%=GetLangSpecText("ecm_assn_type") %>
                        </span>
                    </td>
                    <td class="righttdbg" style="width: 50%; padding: 7px">
                        <asp:DropDownList ID="ListTypes" runat="server" AutoPostBack="True" CssClass="inputselect" 
                            OnSelectedIndexChanged="ListTypes_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="lefttdbg" style="width: 50%;padding: 7px">
                        <span class="subtitle">
                            <%=GetLangSpecText("ecm_assn_eventdtls") %>
                        </span>
                    </td>
                    <td class="righttdbg" style="width: 50%;padding: 7px">
                        <asp:DropDownList ID="Events" runat="server" CssClass="inputselect">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="lefttdbg" style="padding: 7px">
                        <span class="subtitle">
                            <%=GetLangSpecText("ecm_assn_listid") %>
                            <img runat="server" alt="" id="imgMandatory" src="<%$ ReplaceTemplateExpn:Skeltaforms/Images/mandatoryicon.png%>"
                                style="vertical-align: top" visible="true" />
                            <asp:RequiredFieldValidator ID="ReqSiteUrl" runat="server" ControlToValidate="txtListId"
                                Display="Dynamic" Enabled="true">
                                <img id="imgsiteUrlerror" alt="Enter List Id" runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/Images/erroricon.png%>"
                                    style="vertical-align:top" visible="true" />
                            </asp:RequiredFieldValidator>
                        </span>
                        <br />
                        <span class="description">
                            <%=GetLangSpecText("ecm_assn_explorertext")%>
                        </span>
                    </td>
                    <td class="righttdbg"  style="padding: 7px">
                        <asp:TextBox ID="txtListId" runat="server" Width="150px" CssClass="inputtext"> </asp:TextBox>
                        <asp:HiddenField ID="hdnListId" runat="server"></asp:HiddenField>
                        <img style="border-width:0;vertical-align:middle" alt="" src="<%=imgPath%>/group-explore.gif" width="22px" 
                            id="Img1" onclick="selectListId()" />
                        <span class="description">
                            <%=GetLangSpecText("ec_explorer_list") %></span>
                       <telerik:RadWindowManager ID="RadWindowManager1" Skin="AWTWindow" EnableEmbeddedSkins="false"
                         runat="server" Behaviors="Close" RenderMode="Classic" VisibleStatusbar="false">          
                        </telerik:RadWindowManager>
                     </td>
                </tr>
                <tr>
                    <td class="lefttdbg" style="padding: 7px">
                        <span class="subtitle">
                            <%=GetLangSpecText("ecm_assn_listitemid") %>
                        </span>
                    </td>
                    <td class="righttdbg" style="padding: 7px">
                        <asp:TextBox ID="txtListItemId" runat="server" Width="150px" CssClass="inputtext"></asp:TextBox>
                        <asp:HiddenField ID="hdnListItemId" runat="server"></asp:HiddenField>
                    </td>
                </tr>
                <tr>
                    <td class="lefttdbg" style="padding: 7px">
                        <span class="subtitle">
                            <%=GetLangSpecText("_SP_EventAssoc_FromDate")%>
                        </span>
                    </td>
                    <td class="righttdbg" style="padding: 7px">
                        <telerik:RadDatePicker RenderMode="Classic" Width="183px" ID="ActivationFromDate" runat="server" Skin="AWTCalendar" EnableEmbeddedSkins="false">
                             <DateInput runat="server"></DateInput>        
                            <Calendar ID="Calendar1" runat="server"  Skin="AWTCalendar">
                             </Calendar>                     
                        </telerik:RadDatePicker>
                     </td>
                </tr>
                <tr>
                    <td class="lefttdbg" style="padding: 7px">
                        <span class="subtitle">
                            <%=GetLangSpecText("_SP_EventAssoc_ToDate")%>
                        </span>
                    </td>
                    <td class="righttdbg" style="padding: 7px">
                       <telerik:RadDatePicker RenderMode="Classic" Width="183px" ID="ActivationToDate" runat="server" Skin="AWTCalendar" EnableEmbeddedSkins="false">
                             <DateInput runat="server"></DateInput>        
                            <Calendar ID="Calendar2" runat="server"  Skin="AWTCalendar">
                             </Calendar>                     
                        </telerik:RadDatePicker>
                     </td>
                </tr>
                <tr>
                    <td class="lefttdbg" style="padding: 7px">
                        <span class="subtitle">
                            <%=GetLangSpecText("ecm_view_assn_alertver")%>
                        </span>
                    </td>
                    <td class="righttdbg" style="padding: 7px">
                        <asp:Panel ID="VersionPanel" runat="server">
                        </asp:Panel>
                        <asp:HiddenField ID="HidWorkflowName" runat="server"></asp:HiddenField>
                        <asp:HiddenField ID="HidWorkflowId" runat="server"></asp:HiddenField>
                    </td>
                </tr>
            </table>
        </div>
        <div id="footerdiv" style="overflow: hidden;">
            <table style="width:99%;margin:auto;border-width:0;">
                <tr style="text-align:right">
                    <td style="width:50%">
                    </td>
                    <td  style="width:50%;padding-top:4px;padding-right:10px;">
                        <asp:Button ID="btnReset" runat="server" Text="" CssClass="inputsecondarybutton" OnClick="btnReset_Click" />
                        <asp:Button ID="AttachEvent" runat="server" Text="Attach Event" CssClass="inputbutton"
                            OnClick="AttachEvent_Click" />
                        
                        <input id="ExplorerValue" runat="server" type="hidden" />
                        <asp:HiddenField ID="EventBindId" runat="server"></asp:HiddenField>
                        <asp:HiddenField ID="HidApplicationName" runat="server"></asp:HiddenField>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    </form>
</body>
</html>
