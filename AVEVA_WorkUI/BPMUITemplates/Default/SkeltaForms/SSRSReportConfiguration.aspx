<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Forms.Web.Codebehind.SSRSReportConfiguration" %>
<%@ Register Assembly="Skelta.Forms.Web" Namespace="Skelta.Forms.Web" TagPrefix="cc1" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ OutputCache Duration="60" Location="None" NoStore="true" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>
        <%= skrm.GlobalResourceSet.GetString("ssrs_report_parameters_win_head") %></title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <link type="text/css" rel="stylesheet" href="<%$ReplaceTemplateExpn:TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css%>" />
    <link type="text/css" rel="stylesheet" href="<%$ReplaceTemplateExpn:TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css%>" />
    <link type="text/css" rel="stylesheet" href="<%$ReplaceTemplateExpn:TelerikAjax/StyleSheet/AWTInput/Input.AWTInput.css%>" />
    <link type="text/css" rel="stylesheet" href="<%$ReplaceTemplateExpn:TelerikAjax/StyleSheet/AWTCalendar/Calendar.AWTCalendar.css%>" />
    <link type="text/css" rel="stylesheet" href="<%$ReplaceTemplateExpn:TelerikAjax/StyleSheet/AWTCalendar/Calendar.css%>" />
    <link type="text/css" rel="stylesheet" href="<%$ReplaceTemplateExpn:TelerikAjax/StyleSheet/AWTTreeView/TreeView.AWTTreeView.css%>" />
    <link rel="stylesheet" type="text/css" href="<%$ReplaceTemplateExpn:SkeltaForms/StyleSheet/skeltaform.css%>" />
    <script type="text/javascript">
        function updateReportConfigurationDetails(hiddenField, val)
        {
            var editPageFrame;
            var editPageVm;
            try
            {
                editPageFrame = parent.frames["editframe"].document;
                editPageFrame.getElementById(hiddenField).value = val;
                editPageVm = parent.frames["editframe"].viewModelObject;
            }
            catch (err)
            {
                editPageFrame = parent.frames["editframe"].contentWindow.document;
                editPageFrame.getElementById(hiddenField).value = val;
                editPageVm = parent.frames["editframe"].contentWindow.viewModelObject;
            }
            editPageVm.findById("E4").value = val;
            parent.document.getElementById("reportViewerFrame").attributes["data-sksw"].value = 0;
        }
    </script>
</head>
<body onload="OnPageLoad();">
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server" />
     <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
    <input id="hdnIsBrowserIEType" runat="server" type="hidden" enableviewstate="true" />
    <input id="hdnParentHiddenControlId" runat="server" type="hidden" enableviewstate="true" />
    <input id="hdnParametersCount" runat="server" type="hidden" enableviewstate="true"
        value="0" />
    <input id="hdnReportTemplate" runat="server" type="hidden" enableviewstate="true"
        value="" />
    <input id="hdnInitialErrorMessage" runat="server" type="hidden" enableviewstate="true"
        value="" />
    <input id="historianConnectionName" runat="server" type="hidden" enableviewstate="true"
        value="" />
    <input id="historianConnectionNameforTimeZone" runat="server" type="hidden" enableviewstate="true"
        value="" />
    <table border="0" width="100%" style="height: 100%;" class="sf-formbackground">
        <%-- Header Section --%>
        <tr>
            <td>
                <div id="divheader">
                    <table width="100%" align="center" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="sf-topleveltitle" style="padding-left: 5px;">
                                <img src="<%=ThemePath%>SkeltaForms/images/new-form-icon.png" align="absmiddle" />&nbsp;<%= skrm.GlobalResourceSet.GetString("ssrs_report_parameters_win_head")%>
                                <br />
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="sf-formlabeldescription"> (
                                    <%=skrm.GlobalResourceSet.GetString("ssrs_report_parameters_win_description")%>
                                    )</span>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <%-- Report View Option Section --%>
        <tr style="height: 10px">
            <td>
                <table id="tblReportViewOptionSection" cellpadding="0px" cellspacing="0px" border="0px"
                    width="100%">
                    <tr>
                        <td height="5px">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table id="tblReportViewOptionDetails" cellpadding="0px" cellspacing="0px" border="0px" width="100%">
                                <tr>
                                    <td width="200px" class="sf-formlabelReportConfig">
                                        <%= skrm.GlobalResourceSet.GetString("ssrs_report_view_option_caption") %>
                                        <br />
                                        <span class="sf-formlabeldescription">(&nbsp;<%= skrm.GlobalResourceSet.GetString("ssrs_report_view_option_caption_description") %>&nbsp;)
                                        </span>
                                    </td>
                                    <td>
                                        <table cellpadding="0px" cellspacing="0px" border="0px" width="100%">
                                            <tr>
                                                <td>
                                                    <asp:radiobuttonlist id="RbnReportViewOptionList" onclick="RefreshUIBasedOnViewOption();"
                                                        cssclass="sf-formlabeldescription" runat="server" repeatlayout="Table" repeatcolumns="3"
                                                        repeatdirection="Horizontal" autopostback="false" enableviewstate="true" width="100%"
                                                        height="100%">
                                                    </asp:radiobuttonlist>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td id="CellSelectedReportViewOptionDescription" class="sf-formlabeldescription">
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <%-- Report Template Section --%>
        <tr id="RowSectionReportTemplate" runat="server" style="height: 100%;vertical-align:top;">
            <td>
                <table id="tblReportTemplateSection" cellpadding="0px" cellspacing="0px" border="0px"
                    width="100%" style="height:100%;">
                    <tr>
                        <td height="5px">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td width="200px" class="sf-formlabelReportConfig">
                                        <%= skrm.GlobalResourceSet.GetString("ssrs_behavior_section") %>
                                        <br />
                                        <span class="sf-formlabeldescription">(&nbsp;<%= skrm.GlobalResourceSet.GetString("ssrs_behavior_section_description").Replace("#!@helpurl@!#","OpenSSRSReportViewerBehaviorHelpWindow();") %>&nbsp;)
                                        </span>
                                    </td>
                                    <td>
                                        <table id="tableBehaviorDetails" border="0px" cellpadding="0px" cellspacing="0px" height="120px" width="100%">
                                            <tr>
                                                <td width="33.33%">
                                                    <table border="0" cellpadding="0px" cellspacing="0px" width="100%" class="sf-formlabelReportConfigNormal">
                                                        <tr>
                                                            <td align="left" width="1px">
                                                                <input id="bdChkShowParameters" runat="server" type="checkbox" checked="checked" />
                                                            </td>
                                                            <td width="100%">
                                                                <label for="bdChkShowParameters">
                                                                    <%= skrm.GlobalResourceSet.GetString("ssrs_behavior_show_parameters_prompts") %>
                                                                </label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td width="33.33%">
                                                    <table border="0" cellpadding="0px" cellspacing="0px" width="100%" class="sf-formlabelReportConfigNormal">
                                                        <tr>
                                                            <td align="left" width="1px">
                                                                <input id="bdChkShowToolbar" runat="server" type="checkbox" checked="checked" />
                                                            </td>
                                                            <td width="100%">
                                                                <label for="bdChkShowToolbar">
                                                                    <%= skrm.GlobalResourceSet.GetString("ssrs_behavior_show_toolbar") %>
                                                                </label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td width="33.33%">
                                                    <table border="0" cellpadding="0px" cellspacing="0px" width="100%" class="sf-formlabelReportConfigNormal">
                                                        <tr>
                                                            <td align="left" width="1px">
                                                                <input id="bdChkShowBackButton" runat="server" type="checkbox" checked="checked" />
                                                            </td>
                                                            <td width="100%">
                                                                <label for="bdChkShowBackButton">
                                                                    <%= skrm.GlobalResourceSet.GetString("ssrs_behavior_show_back_button") %>
                                                                </label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="33.33%">
                                                    <table border="0" cellpadding="0px" cellspacing="0px" width="100%" class="sf-formlabelReportConfigNormal">
                                                        <tr>
                                                            <td align="left" width="1px">
                                                                <input id="bdChkShowPageNavigationControls" runat="server" type="checkbox" checked="checked" />
                                                            </td>
                                                            <td width="100%">
                                                                <label for="bdChkShowPageNavigationControls">
                                                                    <%= skrm.GlobalResourceSet.GetString("ssrs_behavior_show_page_navigation_controls") %>
                                                                </label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                    </table>
                                                </td>
                                                <td width="33.33%">
                                                    <table border="0" cellpadding="0px" cellspacing="0px" width="100%" class="sf-formlabelReportConfigNormal">
                                                        <tr>
                                                            <td align="left" width="1px">
                                                                <input id="bdChkShowZoomControl" runat="server" type="checkbox" checked="checked" />
                                                            </td>
                                                            <td width="100%">
                                                                <label for="bdChkShowZoomControl">
                                                                    <%= skrm.GlobalResourceSet.GetString("ssrs_behavior_show_zoom_control") %>
                                                                </label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td width="33.33%">
                                                    <table border="0" cellpadding="0px" cellspacing="0px" width="100%" class="sf-formlabelReportConfigNormal">
                                                        <tr>
                                                            <td align="left" width="1px">
                                                                <input id="bdChkShowRefreshButton" runat="server" type="checkbox" checked="checked" />
                                                            </td>
                                                            <td width="100%">
                                                                <label for="bdChkShowRefreshButton">
                                                                    <%= skrm.GlobalResourceSet.GetString("ssrs_behavior_show_refresh_button") %>
                                                                </label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="33.33%">
                                                    <table border="0" cellpadding="0px" cellspacing="0px" width="100%" class="sf-formlabelReportConfigNormal">
                                                        <tr>
                                                            <td align="left" width="1px">
                                                                <input id="bdChkShowFindControls" runat="server" type="checkbox" checked="checked" />
                                                            </td>
                                                            <td width="100%">
                                                                <label for="bdChkShowFindControls">
                                                                    <%= skrm.GlobalResourceSet.GetString("ssrs_behavior_show_find_controls") %>
                                                                </label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td width="33.33%">
                                                    <table border="0" cellpadding="0px" cellspacing="0px" width="100%" class="sf-formlabelReportConfigNormal">
                                                        <tr>
                                                            <td align="left" width="1px">
                                                                <input id="bdChkShowExportControls" runat="server" type="checkbox" checked="checked" />
                                                            </td>
                                                            <td width="100%">
                                                                <label for="bdChkShowExportControls">
                                                                    <%= skrm.GlobalResourceSet.GetString("ssrs_behavior_show_export_controls") %>
                                                                </label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td width="33.33%">
                                                    <table border="0" cellpadding="0px" cellspacing="0px" width="100%" class="sf-formlabelReportConfigNormal">
                                                        <tr>
                                                            <td align="left" width="1px">
                                                                <input id="bdChkShowPrintButton" runat="server" type="checkbox" checked="checked" />
                                                            </td>
                                                            <td width="100%">
                                                                <label for="bdChkShowPrintButton">
                                                                    <%= skrm.GlobalResourceSet.GetString("ssrs_behavior_show_print_button") %>
                                                                </label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3" width="100%" class="sf-formlabeldescription">
                                                    (&nbsp;<%= skrm.GlobalResourceSet.GetString("ssrs_behavior_show_print_button_description") %>&nbsp;)
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td height="5px">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table id="tblReportTemplateDetails" cellpadding="0px" cellspacing="0px" border="0px" width="100%">
                                <tr>
                                    <td width="200px" class="sf-formlabelReportConfig">
                                        <%= skrm.GlobalResourceSet.GetString("ssrs_report_template_caption") %>
                                        <br />
                                        <span class="sf-formlabeldescription">(&nbsp;<%= skrm.GlobalResourceSet.GetString("ssrs_report_template_caption_description") %>&nbsp;)
                                        </span>
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="radReportTemplate" RenderMode="Classic" runat="server" AllowCustomText="true" MarkFirstMatch="true" NoWrap="true"  EnableViewState="true"
                                          MaxLength="250" DropDownWidth="270px" Width="270px" EnableEmbeddedSkins="false"  Skin="AWTCombobox" OnClientSelectedIndexChanged="ShowImageAnimation" Height="120px" AutoPostBack="true">
                                      </telerik:RadComboBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td height="5px">
                        </td>
                    </tr>
                    <tr style="height:100%;">
                        <td>
                            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="height:100%;">
                                <tr>
                                    <td class="sf-formlabelReportConfig" height="40px" valign="middle">
                                        <%= skrm.GlobalResourceSet.GetString("ssrs_parameters_section") %>
                                        <br />
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td width="100%">
                                                    <span class="sf-formlabeldescription">(&nbsp;<%= skrm.GlobalResourceSet.GetString("ssrs_parameters_section_description") %>&nbsp;)
                                                    </span>
                                                </td>
                                                <td align="right">
                                                    <span class="sf-formlabeldescription" style="white-space:nowrap;">
                                                        <asp:checkbox id="ChkShowHiddenParameters" runat="server" onclick="SetHiddenParametersVisibility(this); return true;"
                                                            autopostback="false" checked="false" />
                                                    </span>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr style="height:100%;">
                                    <td style="position:relative;"">
                                        <asp:panel id="pnl2" cssclass="ssrs-panel" style="height:100%;" width="100%" scrollbars="Auto"
                                            runat="server" enableviewstate="false">
                                        </asp:panel>
                                        <label style="visibility: hidden; position: absolute; left:50%;right:50%;top:50%;bottom:50%;" class="sf-formlabeldescription"
                                            id="lblWait">
                                            <%=skrm.GlobalResourceSet.GetString("ssrs_wait_text")%>
                                        </label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <%-- Attachment Section --%>
        <tr id="RowSectionAttachment" runat="server" style="height: 100%; vertical-align:top;">
            <td>
                <table id="tblAttachmentSection" cellpadding="0px" cellspacing="0px" border="0px"
                    width="100%" style="height:100%;">
                    <tr>
                        <td height="5px">
                        </td>
                    </tr>
                    <tr style="height:100%;vertical-align:top;">
                        <td>
                            <table id="tblAttachmentDetails" cellpadding="0px" cellspacing="0px" border="0px" width="100%">
                                <tr>
                                    <td width="200px" class="sf-formlabelReportConfig">
                                        <%= skrm.GlobalResourceSet.GetString("ssrs_attachments_report_source_caption") %>
                                        <br />
                                        <span class="sf-formlabeldescription">(&nbsp;<%= skrm.GlobalResourceSet.GetString("ssrs_attachments_report_source_caption_description") %>&nbsp;)
                                        </span>
                                    </td>
                                    <td align="left">
                                        <asp:radiobuttonlist id="RbnAttachmentReportSource" runat="server" onclick="RefreshUIBasedOnReportSource();"
                                            cssclass="sf-formlabeldescription" runat="server" repeatlayout="Table" repeatcolumns="1"
                                            repeatdirection="Vertical" autopostback="false" enableviewstate="true" width="100%"
                                            height="100%">
                                        </asp:radiobuttonlist>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="5px">
                                    </td>
                                </tr>
                                <tr id="RowAttachmentSSRSReport" runat="server">
                                    <td width="200px" class="sf-formlabelReportConfig">
                                        <%= skrm.GlobalResourceSet.GetString("ssrs_attachments_ssrsreport_caption") %>
                                        <br />
                                        <span class="sf-formlabeldescription">(&nbsp;<%= skrm.GlobalResourceSet.GetString("ssrs_attachments_ssrsreport_caption_description") %>&nbsp;)
                                        </span>
                                    </td>
                                    <td>
                                        <table width="100%" cellpadding="0px" cellspacing="0px" border="0px">
                                            <tr>
                                                <td width="1px">
                                        <telerik:RadComboBox   ID="radSSRSReportList" RenderMode="Classic" runat="server" AllowCustomText="true" MarkFirstMatch="true" NoWrap="true"  EnableViewState="true"
                                          MaxLength="250" DropDownWidth="270px" Width="270px" EnableEmbeddedSkins="false"  Skin="AWTCombobox" OnClientSelectedIndexChanged="ShowImageAnimation" AutoPostBack="false">
                                      </telerik:RadComboBox>
                                        </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr id="RowAttachmentReportGeneratorActivity" runat="server">
                                    <td width="200px" class="sf-formlabelReportConfig">
                                        <%= skrm.GlobalResourceSet.GetString("ssrs_attachments_rga_caption") %>
                                        <br />
                                        <span class="sf-formlabeldescription">(&nbsp;<%= skrm.GlobalResourceSet.GetString("ssrs_attachments_rga_caption_description") %>&nbsp;)
                                        </span>
                                    </td>
                                    <td style="vertical-align:top;">
                                        <table width="100%" cellpadding="0px" cellspacing="0px" border="0px">
                                            <tr>
                                                <td width="1px">
                                               <telerik:RadComboBox   ID="idParmRGAValue" RenderMode="Classic" runat="server"  NoWrap="true"  EnableViewState="true"
                                                  MaxLength="250" Width="87px" EnableEmbeddedSkins="false"  Skin="AWTCombobox"  OnClientSelectedIndexChanged="RGAValueParamType_OnClientSelectedIndexChanged" autopostback="false">
                                              </telerik:RadComboBox>
                                                </td>
                                                <td width="1px">
                                                    <input type="text" id="txtRGAValue" value="" runat="server" enableviewstate="true"
                                                        style="width: 140px" class="inputs" readonly="readonly" />
                                                </td>
                                                <td align="left">
                                                    <input type="hidden" id="hdnRGAValue" value="" runat="server" enableviewstate="true" />
                                                    <img id="imgRGAValue" src="images/Controls-Icon.png" class="sf-formImageReportConfig" onclick="OpenTableStructureForFormControls('idParmRGAValue','txtRGAValue','hdnRGAValue'); return false;" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr valign="middle" align="right" style="height:40px">
            <td valign="middle" class="sf-saverow">
                <input type="button" name="btnClose" value='<%=skrm.GlobalResourceSet.GetString("ssrs_button_close")%>'
                    onclick="closeWindow();" id="btnClose" class="inputsecondarybutton" style="margin-right:5px;"/>
                <input type="submit" name="btnsubmit" runat="server" id="btnSubmit" class="sf-inputsBox"
                    onclick="return CheckParentWindow();" onserverclick="sendData_click" />
            </td>
        </tr>
    </table>
    <div style="height: 80%; width: 50%; display: none; background-color: White; border: Solid 2px #d2d2d2;
        overflow: auto;" id="divFormControls" runat="server">
        <table style="background-color: Silver; width: 100%" border="0">
            <tr>
                <td align="right" style="width: 100%">
                    <a id="a1" onclick="CloseDivControls()">
                        <img style="border: 0" src="<%=ThemePath%>Common/Images/close.gif" /></a>
                </td>
            </tr>
        </table>
         <telerik:RadTreeview ID="ControlsTree"  RenderMode="Classic" runat="server" Height="100%" Skin="AWTTreeView" 
                  EnableEmbeddedSkins="false" EnableViewState="true"  OnClientNodeClicked="GetRadNode" retainscrollposition="true" autopostback="false">
         </telerik:RadTreeview>      
    </div>
    </form>
</body>
</html>
<script language="javascript" type="text/javascript">

    var REPORT_VIEW_OPTION_EMBEDDED = "0";
    var REPORT_VIEW_OPTION_POPUP = "1";
    var REPORT_VIEW_OPTION_DOWNLOAD = "2";

    var DOWNLOAD_REPORT_SOURCE_SSRS_REPORTS = "0";
    var DOWNLOAD_REPORT_SOURCE_REFERENCE_ID = "1";
    var fromNGF = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(fromNGF, false)%>";
    function GetSelectedValueFromRadioButtonList(controlId, defaultValue)
    {
        try
        {
            var selectedValue = defaultValue;
            var f = document.forms[0];
            var e = f.elements[controlId];

            for (var i = 0; i < e.length; i++)
            {
                if (e[i].checked)
                {
                    selectedValue = e[i].value;
                    break;
                }
            }

            return selectedValue;
        }
        catch (err)
        {
            return defaultValue;
        }
    }

    function SetRadioButtonListEnabled(controlId, _enable)
    {
        var radioControl = document.forms[0].elements[controlId];

        for (var i = 0; i < radioControl.length; i++)
        {
            radioControl[i].disabled = !_enable;
        }
    }

    function SetRadioButtonListValue(controlId, setValue)
    {
        var radioControl = document.forms[0].elements[controlId];
        
        for (var i = 0; i < radioControl.length; i++)
        {
            if (radioControl[i].value == setValue)
            {
                radioControl[i].checked = true;
            }
            else
            {
                radioControl[i].checked = false;
            }
        }
    }

    function RefreshUIBasedOnViewOption()
    {
        var selectedValue = GetSelectedValueFromRadioButtonList("RbnReportViewOptionList", REPORT_VIEW_OPTION_EMBEDDED);

        switch (selectedValue)
        {                
            case REPORT_VIEW_OPTION_DOWNLOAD:
                ShowHideReportTemplateSection(false);
                document.getElementById("CellSelectedReportViewOptionDescription").innerHTML = GetDescriptionString("<%=skrm.GlobalResourceSet.GetString("ssrs_report_view_option_download_description")%>");
                break;

            case REPORT_VIEW_OPTION_POPUP:
                ShowHideReportTemplateSection(true);
                document.getElementById("CellSelectedReportViewOptionDescription").innerHTML = GetDescriptionString("<%=skrm.GlobalResourceSet.GetString("ssrs_report_view_option_popup_description")%>");
                break;
                
            case REPORT_VIEW_OPTION_EMBEDDED:
            default:
                ShowHideReportTemplateSection(true);
                document.getElementById("CellSelectedReportViewOptionDescription").innerHTML = GetDescriptionString("<%=skrm.GlobalResourceSet.GetString("ssrs_report_view_option_embedded_description")%>");
                break;
        }
    }

    function GetDescriptionString(_description)
    {
        return "(&nbsp;" + _description + "&nbsp;)";
    }
    
    function GetDisplayAttributeString()
    {
        if (document.getElementById("hdnIsBrowserIEType").value == "1")
        {
            return "inline";
        }
        else
        {
            return "";
        }
    }
    
    function ShowHideReportTemplateSection(_show)
    {
        if (_show)
        {
            document.getElementById("RowSectionReportTemplate").style.display = GetDisplayAttributeString();
            document.getElementById("RowSectionAttachment").style.display = "none";
        }
        else
        {
            document.getElementById("RowSectionReportTemplate").style.display = "none";
            document.getElementById("RowSectionAttachment").style.display = GetDisplayAttributeString();
        }
    }

    function RefreshUIBasedOnReportSource()
    {
        var selectedValue = GetSelectedValueFromRadioButtonList("RbnAttachmentReportSource", DOWNLOAD_REPORT_SOURCE_SSRS_REPORTS);

        if (selectedValue == DOWNLOAD_REPORT_SOURCE_SSRS_REPORTS)
        {
            document.getElementById("RowAttachmentSSRSReport").style.display = GetDisplayAttributeString();
            document.getElementById("RowAttachmentReportGeneratorActivity").style.display = "none";
        }
        else
        {
            document.getElementById("RowAttachmentSSRSReport").style.display = "none";
            document.getElementById("RowAttachmentReportGeneratorActivity").style.display = GetDisplayAttributeString();
        }
    }

    function CheckParentWindow()
    {
        if (fromNGF !== '1' && window.opener != null && window.opener.closed)
        {
            alert('<%= skrm.GlobalResourceSet.GetString("ssrs_properties_win_closed_cannot_apply_changes_msg") %>');
            window.close();
            return false;
        }

        return true;
    }

    function closeWindow()
    {
        if (fromNGF !== '1')
        {
            window.close();
        }
        else
        {
            parent.document.getElementById("reportViewerFrame").attributes["data-sksw"].value = 0;
        }
    }

    function GetBoolFromBit(bitValue)
    {
        if (bitValue == "1")
        {
            return true;
        }

        return false;
    }

    function IsAttachmentTypeOption(reportViewOption)
    {
        if (reportViewOption == REPORT_VIEW_OPTION_DOWNLOAD)
        {
            return true;
        }

        return false;
    }

    function IsInitializeRequiredForReportTemplateChange()
    {   
        var radComboObj = $find("<%= radReportTemplate.ClientID %>");
        
        if (radComboObj.get_selectedItem() != null)
        {
            if (document.getElementById('hdnReportTemplate').value != radComboObj.get_selectedItem().get_value())
            {
                document.getElementById('hdnReportTemplate').value = radComboObj.get_selectedItem().get_value();
                return true;
            }
        }
        
        return false;
    }
    
    function SetHiddenParametersVisibility(sender)
    {
        if (sender.parentNode.style.display != "none")
        {
            var isVisible = sender.checked;
            document.getElementById("TableHiddenParameterSection").style.display = (isVisible == true) ? GetDisplayAttributeString() : "none";
            
            if (document.getElementById("TableHiddenParameterSection").getAttribute("skonlyhiddenparams") == "1")
            {
                document.getElementById("TableMainParameters").style.display = (isVisible == true) ? "none" : GetDisplayAttributeString();
            }
        }
    }
    
    function OnPageLoad()
    {
        var idHiddenControlInfo = document.getElementById("hdnParentHiddenControlId");
        var UIParameterCount = parseInt(document.getElementById("hdnParametersCount").value);
        if (idHiddenControlInfo.value != "")
        {
            if (fromNGF !== '1' && window.opener != null && window.opener.closed)
            {
                alert('<%= skrm.GlobalResourceSet.GetString("ssrs_properties_win_closed_msg") %>');
                window.close();
                return;
            }

            var valueToBeSet;
            if (fromNGF !== '1')
            {
                valueToBeSet = window.opener.document.getElementById(idHiddenControlInfo.value).value;
            }
            else
            {
                //valueToBeSet = window.parent.document.getElementById(idHiddenControlInfo.value).value;
                try
                {
                    valueToBeSet = parent.frames["editframe"].document.getElementById(idHiddenControlInfo.value).value;
                }
                catch (err)
                {
                    valueToBeSet = parent.frames["editframe"].contentWindow.document.getElementById(idHiddenControlInfo.value).value;
                    //logger.logError(err.message);
                }
            }

            idHiddenControlInfo.value = "";

            RefreshUIBasedOnViewOption();
            
            if (valueToBeSet == "")
            {
                return;
            }

            var separatorSectionValue = "<%=SEPARATOR_SECTION_VALUE %>";
            var separatorInnerValue = "<%=SEPARATOR_INNER_VALUE %>";
            var separatorOuterValue = "<%=SEPARATOR_OUTER_VALUE %>";
            var nullValue =  "<%=NULL_VALUE %>";

            var sectionReportViewOption = parseInt("<%= SECTION_REPORT_VIEW_OPTION %>");
            var sectionReportTemplate = parseInt("<%= SECTION_REPORT_TEMPLATE %>");
            var sectionBehavior = parseInt("<%= SECTION_BEHAVIOR %>");
            var sectionReportParameters = parseInt("<%= SECTION_REPORT_PARAMETERS %>");
            var sectionAttachment = parseInt("<%= SECTION_ATTACHMENT %>");

            var UIValue = valueToBeSet.split(separatorSectionValue);

            var reportViewOption = UIValue[sectionReportViewOption];

            if (IsAttachmentTypeOption(reportViewOption) == false)
            {
                // Behavior Section
                var behaviorVals = UIValue[sectionBehavior].split(",");

                document.getElementById("bdChkShowParameters").checked = GetBoolFromBit(behaviorVals[0]);
                document.getElementById("bdChkShowToolbar").checked = GetBoolFromBit(behaviorVals[1]);
                document.getElementById("bdChkShowBackButton").checked = GetBoolFromBit(behaviorVals[2]);
                document.getElementById("bdChkShowPageNavigationControls").checked = GetBoolFromBit(behaviorVals[3]);
                document.getElementById("bdChkShowZoomControl").checked = GetBoolFromBit(behaviorVals[4]);
                document.getElementById("bdChkShowRefreshButton").checked = GetBoolFromBit(behaviorVals[5]);
                document.getElementById("bdChkShowFindControls").checked = GetBoolFromBit(behaviorVals[6]);
                document.getElementById("bdChkShowExportControls").checked = GetBoolFromBit(behaviorVals[7]);
                document.getElementById("bdChkShowPrintButton").checked = GetBoolFromBit(behaviorVals[8]);

                // Parameters Section
                var ParameterValues = UIValue[sectionReportParameters].split(separatorOuterValue);

                var index = 0;
                if (document.getElementById("hdnInitialErrorMessage").value != "")
                {
                    document.getElementById("ChkShowHiddenParameters").parentNode.style.display = "none";
                    alert(document.getElementById("hdnInitialErrorMessage").value);
                    document.getElementById("hdnInitialErrorMessage").value = "";
                }
                else
                {
                    var settingsCollection = ParameterValues[0].split(separatorInnerValue);
                    document.getElementById("ChkShowHiddenParameters").checked = (settingsCollection[0] == "1") ? true : false;
                    SetHiddenParametersVisibility(document.getElementById("ChkShowHiddenParameters"));
                    
                    document.getElementById("historianConnectionName").value = settingsCollection[1];
                    document.getElementById("historianConnectionNameforTimeZone").value = settingsCollection[2];
                
                    for (index = 1; index < ParameterValues.length; index++)
                    {
                        var valueCollection = ParameterValues[index].split(separatorInnerValue);
                        var i = 0;
                        for (i = 0; i < UIParameterCount; i++)
                        {
                            var hdnObj = document.getElementById("hdn" + i.toString());
                            
                            if (valueCollection[0] == hdnObj.getAttribute("skparamname"))
                            {
                                var radComboObj = $find("idParm" + i.toString());
                                var txtbox = document.getElementById("txt" + i.toString());
                                var dataType = hdnObj.attributes["skdatatype"].value;
                               
                                var item = radComboObj.findItemByValue(valueCollection[1]);
                                if (item != null)
                                {
                                    item.select();
                                    
                                    if (valueCollection[1] == "Values")
                                    {
                                        var chkNull = GetChkNullObject(i);
                                        
                                        if (chkNull != null)
                                        {
                                            chkNull.checked = (valueCollection[2] == nullValue);
                                        }
                                        
                                        if (valueCollection[2] != nullValue)
                                        {
                                            switch (dataType)
                                            {
                                                case "boolean":
                                                    var boolParm = document.getElementById("rbl" + i.toString());
                                                    SetRadioButtonListValue(boolParm.id, valueCollection[2]);
                                                    break;
                                                case "datetime":
                                                    var dateTimeParm = GetDateTimePickerControl("dtp" + i.toString());
                                                    SetValueToDateTimeControlFromString(dateTimeParm, valueCollection[2]);
                                                    break;
                                                case "integer":
                                                case "float":
                                                    var numericParm = GetNumberControl("rnt" + i.toString());
                                                    SetValueToNumberControl(numericParm, valueCollection[2]);
                                                    break;
                                                case "string":
                                                default:
                                                    txtbox.value = valueCollection[2];
                                                    break;
                                            }
                                        }
                                    }
                                    else
                                    {
                                        txtbox.value = valueCollection[2];
                                    }
                                    
                                    hdnObj.value = valueCollection[3];
                                }
                                
                                SetNullableToUI(i);
                                break;
                            }
                        }
                    }
                }
                
            }

            if (IsAttachmentTypeOption(reportViewOption) == true)
            {
                // Attachment Section
                if (UIValue[sectionAttachment] != "")
                {
                    var AttachmentSettingsValues = UIValue[sectionAttachment].split(separatorOuterValue);

                    //Set Report Source
                    SetRadioButtonListValue("RbnAttachmentReportSource", AttachmentSettingsValues[0]);
                    RefreshUIBasedOnReportSource();

                    if (AttachmentSettingsValues[1] != "")
                    {
                        // Set SSRS Report Values
                        if (AttachmentSettingsValues[0] == DOWNLOAD_REPORT_SOURCE_SSRS_REPORTS)
                        {

                          var radComboObj = $find("<%= radSSRSReportList.ClientID %>");
                            var item = radComboObj.findItemByValue(AttachmentSettingsValues[1]);
                            if (item != null)
                            {
                                item.select();
                            }
                        }
                        else // Set Report Generator Activity Values
                        {
                            var RGAValues = AttachmentSettingsValues[1].split(separatorInnerValue);
                         
                            var radComboObj = $find("<%= idParmRGAValue.ClientID %>");
                            var item = radComboObj.findItemByValue(RGAValues[0]);
                            if (item != null)
                            {
                                item.select();
                            }

                            document.getElementById("txtRGAValue").value = RGAValues[1];
                            document.getElementById("hdnRGAValue").value = RGAValues[2];
                        }
                    }
                }
            }
        }
        else
        {
            var initializeParameters = IsInitializeRequiredForReportTemplateChange();
            
            if (initializeParameters == true)
            {
                document.getElementById("ChkShowHiddenParameters").checked = false;
                SetHiddenParametersVisibility(document.getElementById("ChkShowHiddenParameters"));
            }
            
            var i = 0;
            for (i = 0; i < UIParameterCount; i++)
            {
                var radComboObj = $find("idParm" + i.toString());

                var txtParm = document.getElementById("txt" + i);
                var hdnParm = document.getElementById("hdn" + i);
                var btnParm = document.getElementById("img" + i);
                var chkNull = GetChkNullObject(i);
                var lblNull = document.getElementById("lblnull" + i);
                var tagPicker = document.getElementById("imgTagPicker" + i);
                var timeZonePicker = document.getElementById("imgTimeZonePicker" + i);
                
                var dataType = hdnParm.attributes["skdatatype"].value;
                
                var boolParm = null;
                var dateTimeParm = null;
                var numericParm = null;
                
                switch (dataType)
                {
                    case "boolean":
                        boolParm = document.getElementById("rbl" + i);
                        break;
                    case "datetime":
                        dateTimeParm = GetDateTimePickerControl("dtp" + i);
                        break;
                    case "integer":
                    case "float":
                        numericParm = GetNumberControl("rnt" + i);
                        break;
                    case "string":
                    default:
                        break;
                }
                
                if (initializeParameters == true)
                {
                    hdnParm.value = "";
                    
                    var item = radComboObj.findItemByValue("Controls");
                    if (item != null)
                    {
                        item.select();
                    }
                    
                    txtParm.value = "";
                    
                    if (chkNull != null)
                    {
                        chkNull.checked = false;
                    }
                    
                    switch (dataType)
                    {
                        case "boolean":
                            SetRadioButtonListValue(boolParm.id, "");
                            break;
                        case "datetime":
                            SetValueToDateTimeControlFromString(dateTimeParm, "");
                            break;
                        case "integer":
                        case "float":
                            SetValueToNumberControl(numericParm, "");
                            break;
                        case "string":
                        default:
                            txtParm.value = "";
                            break;
                    }
                }
                
                if (radComboObj.get_selectedItem().get_value() == "Controls")
                {
                    txtParm.readOnly = true;
                    btnParm.style.display = GetDisplayAttributeString();
                    if (chkNull != null)
                    {
                        chkNull.style.display = "none";
                        lblNull.style.display = "none";
                    }
                    
                    txtParm.style.display = GetDisplayAttributeString();
                    
                    if (tagPicker !=null)
                    {
                        tagPicker.style.display = "none";
                    }
                    
                    if (timeZonePicker != null)
                    {
                        timeZonePicker.style.display = "none";
                    }
                    
                    if (boolParm != null)
                    {
                        boolParm.style.display = "none";
                    }
                    
                    if (dateTimeParm != null)
                    {
                        ShowHideDateTimePicker(dateTimeParm, false);
                    }
                    
                    if (numericParm != null)
                    {
                        ShowHideNumberControl(numericParm, false);
                    }
                }
                else
                {
                    txtParm.readOnly = false;
                    btnParm.style.display = "none";
                    if (chkNull != null)
                    {
                        chkNull.style.display = GetDisplayAttributeString();
                        lblNull.style.display = GetDisplayAttributeString();
                    }
                    
                    if (tagPicker !=null)
                    {
                        tagPicker.style.display = GetDisplayAttributeString();
                    }
                    
                    if (timeZonePicker != null)
                    {
                        timeZonePicker.style.display = GetDisplayAttributeString();
                    }
                    
                    switch (dataType)
                    {
                        case "boolean":
                            txtParm.style.display = "none";
                            boolParm.style.display = GetDisplayAttributeString();
                            break;
                        case "datetime":
                            txtParm.style.display = "none";
                            ShowHideDateTimePicker(dateTimeParm, true);
                            break;
                        case "integer":
                        case "float":
                            txtParm.style.display = "none";
                            ShowHideNumberControl(numericParm, true);
                            break;
                        default:
                            txtParm.style.display = GetDisplayAttributeString();
                            break;
                    }
                    
                    SetNullableToUI(i);
                }
            }
            
           var radComboObj = $find("<%= idParmRGAValue.ClientID %>");

            if (radComboObj.get_selectedItem().get_value() == "Controls")
            {
                document.getElementById("txtRGAValue").readOnly = true;
                document.getElementById("imgRGAValue").style.display = GetDisplayAttributeString();
            }
            else
            {
                document.getElementById("txtRGAValue").readOnly = false;
                document.getElementById("imgRGAValue").style.display = "none";
            }

            RefreshUIBasedOnViewOption();
            RefreshUIBasedOnReportSource();
        }
    }
    
    function OpenTableStructureForFormControls(dropdownId, txtId, hdntxtId)
    {
        
        var combo = $find("<%=idParmRGAValue.ClientID %>");
       
        if (combo.get_selectedItem().get_value() == "Controls")
        {
            text = txtId;
            val = hdntxtId;
            var DivTree = document.getElementById("<%=divFormControls.ClientID%>");
            DivTree.style.display = GetDisplayAttributeString();
            DivTree.style.position = "absolute";
            DivTree.style.left = 10 + 'px';
            DivTree.style.top = 10 + 'px';
               
            var RadTree = $find("<%=ControlsTree.ClientID%>").get_element();
            RadTree.style.height = DivTree.style.height;
        }
        else
        {
            document.getElementById(txtId).focus();
        }
    }

    function ShowTableStructureForFormControls(txtId, hdntxtId)
    {
        text = txtId;
        val = hdntxtId;
        var DivTree = document.getElementById("<%=divFormControls.ClientID%>");
        DivTree.style.display = GetDisplayAttributeString();
        DivTree.style.position = "absolute";
        DivTree.style.left = 10 + 'px';
        DivTree.style.top = 10 + 'px';       

        var RadTree = $find("<%=ControlsTree.ClientID%>").get_element();
        RadTree.style.height = DivTree.style.height;
    }
    
    var text;
    var val;
    function GetRadNode(sender, eventArgs)
    {
        var node = eventArgs.get_node();
        if (node.get_nodes().get_count() > 0) {
            node.expand();
            return;
        }
        document.getElementById(text).value = node.get_text();
        document.getElementById(val).value = node.get_value();
        var DivTree = document.getElementById("<%=divFormControls.ClientID%>");
        DivTree.style.display = "none";
    }
    function OpenTableStructure(obj)
    {
        ToggleMax();
    }

    function CloseDivControls()
    {
        var DivTree = document.getElementById("<%=divFormControls.ClientID%>");
        divFormControls.style.display = "none";
    }
    
    function RGAValueParamType_OnClientSelectedIndexChanged(sender, eventArgs)
    {
        var comboObj = $find("<%=idParmRGAValue.ClientID %>");
        var selectedValue = comboObj.get_value();
        var id = "RGAValue";

        document.getElementById("txt" + id).value = "";
        document.getElementById("hdn" + id).value = "";
        if (selectedValue == "Controls")
        {
            document.getElementById("txt" + id).readOnly = true;
            document.getElementById("img" + id).style.display = GetDisplayAttributeString();
        }
        else
        {
            document.getElementById("txt" + id).readOnly = false;
            document.getElementById("img" + id).style.display = "none";
        }
    }

    function GetChkNullObject(i)
    {
        var chkNull = document.getElementById("chk" + i);
        
        try
        {
            if (chkNull.id == chkNull.id)
            {
                // Just to check if the element exists.
            }
        }
        catch(err)
        {
            chkNull = null;
        }
        
        return chkNull;
    }
    
    function chkNull_OnClick(sender)
    {
        SetNullableToUI(sender.id.replace("chk", ""));
    }
    
    function SetNullableToUI(id)
    {
        var chkNull = GetChkNullObject(id);
        var txtParm = document.getElementById("txt" + id);
        var hdnParm = document.getElementById("hdn" + id);
        
        var dataType = hdnParm.attributes["skdatatype"].value;
                
        var boolParm = null;
        var dateTimeParm = null;
        var numericParm = null;
        
        switch (dataType)
        {
            case "boolean":
                boolParm = document.getElementById("rbl" + id);
                break;
            case "datetime":
                dateTimeParm = GetDateTimePickerControl("dtp" + id);
                break;
            case "integer":
            case "float":
                numericParm = GetNumberControl("rnt" + id);
                break;
            case "string":
            default:
                break;
        }
        
        txtParm.disabled = ((chkNull != null) && (chkNull.checked == true));
        
        if (boolParm != null)
        {
            boolParm.disabled = ((chkNull != null) && (chkNull.checked == true));
            // Below call is required for Mozilla to disable the radio buttons.
            SetRadioButtonListEnabled(boolParm.id, !((chkNull != null) && (chkNull.checked == true)));
        }
        
        if (dateTimeParm != null)
        {
            EnableDateTimePicker(dateTimeParm, !((chkNull != null) && (chkNull.checked == true)));
        }
        
        if (numericParm != null)
        {
            EnableNumberControl(numericParm, !((chkNull != null) && (chkNull.checked == true)));
        }
    }
    
    function GetDateTimePickerControl(id)
    {
        return $find(id);
    }

    function ShowHideDateTimePicker(cntrl, _show)
    {
        var wrapperObj = cntrl.get_element().parent || cntrl.get_element().parentNode;

        if (_show == true)
        {
            wrapperObj.style.display = GetDisplayAttributeString();
        }
        else
        {
            wrapperObj.style.display = "none";
        }
    }
    
    function EnableDateTimePicker(cntrl, _enable)
    {
        cntrl.set_enabled(_enable);
    }
    
    function SetValueToDateTimeControl(dateTimeCntrl, _dateObject)
    {
        dateTimeCntrl.set_selectedDate(_dateObject);
    }
    
    // Below method would be required if we need to consider UTC value
    function SetUTCValueToDateTimeControl(dateTimeCntrl, _dateValue)
    {
        var dateObj = new Date();
        
        try
        {
            if ((_dateValue == "") 
                || (_dateValue == null))
            {
                SetValueToDateTimeControl(dateTimeCntrl, "");
                return;
            }
            
            var _dateParts = _dateValue.split("-");
            
            dateObj.setUTCFullYear(_dateParts[0], parseInt(_dateParts[1]) - 1, _dateParts[2]);
            dateObj.setUTCHours(_dateParts[3], _dateParts[4], _dateParts[5], _dateParts[6]);
            
            SetValueToDateTimeControl(dateTimeCntrl, dateObj);
        }
        catch (err)
        {
            SetValueToDateTimeControl(dateTimeCntrl, "");
        }
    }
    
    function SetValueToDateTimeControlFromString(dateTimeCntrl, _dateValue)
    {
        var dateObj = new Date();
        
        try
        {
            if ((_dateValue == "") 
                || (_dateValue == null))
            {
                SetValueToDateTimeControl(dateTimeCntrl, "");
                return;
            }
            
            var _dateParts = _dateValue.split("-");
            
            dateObj.setFullYear(_dateParts[0], parseInt(_dateParts[1]) - 1, _dateParts[2]);
            dateObj.setHours(_dateParts[3], _dateParts[4], _dateParts[5], _dateParts[6]);
            
            SetValueToDateTimeControl(dateTimeCntrl, dateObj);
        }
        catch (err)
        {
            SetValueToDateTimeControl(dateTimeCntrl, "");
        }
    }
    
    function GetNumberControl(id)
    {
        return $find(id);
    }
    
    function ShowHideNumberControl(cntrl, _show)
    {        
        var wrapperObj = cntrl.get_wrapperElement();
        
        if (_show == true)
        {
            wrapperObj.style.display = GetDisplayAttributeString();
        }
        else
        {
            wrapperObj.style.display = "none";
        }
    }
    
    function EnableNumberControl(cntrl, _enable)
    {
        if (_enable)
        {
            cntrl.enable();
        }
        else
        {
            cntrl.disable();
        }
    }
    
    function SetValueToNumberControl(numberControl, _value)
    {
        numberControl.set_value(_value);
    }
    
    function GetValueFromNumberControl(numberControl)
    {
        try
        {
            numberControl.get_value();
        }
        catch (err)
        {
            return 0;
        }
    }
    
    function ddlParamType_OnClientSelectedIndexChanged(sender, eventArgs)
    {
        var id = sender.get_id();
        id = id.replace("idParm", "");
        var item = eventArgs.get_item();
        var selectedValue = item.get_text();

        var txtParm = document.getElementById("txt" + id);
        txtParm.value = "";
        
        var hdnParm = document.getElementById("hdn" + id);
        hdnParm.value = "";
        
        var btnParm = document.getElementById("img" + id);
        var chkNull = GetChkNullObject(id);
        if (chkNull != null)
        {
            chkNull.checked = false;
        }
        
        var lblNull = document.getElementById("lblnull" + id);
        
        var tagPicker = document.getElementById("imgTagPicker" + id);
        var timeZonePicker = document.getElementById("imgTimeZonePicker" + id);
        
        var dataType = hdnParm.attributes["skdatatype"].value;
            
        var boolParm = null;
        var dateTimeParm = null;
        var numericParm = null;
        
        switch (dataType)
        {
            case "boolean":
                boolParm = document.getElementById("rbl" + id);
                break;
            case "datetime":
                dateTimeParm = GetDateTimePickerControl("dtp" + id);
                break;
            case "integer":
            case "float":
                numericParm = GetNumberControl("rnt" + id);
                break;
            case "string":
            default:
                break;
        }
        
        if (boolParm != null)
        {
            SetRadioButtonListValue("rbl" + id, "");
        }
        
        if (dateTimeParm != null)
        {
             SetValueToDateTimeControl(dateTimeParm, "");
        }
        
        if (numericParm != null)
        {
            SetValueToNumberControl(numericParm, "");
        }

        if (selectedValue == "Controls")
        {
            txtParm.readOnly = true;
             btnParm.style.display = GetDisplayAttributeString();
            if (chkNull != null)
            {
                chkNull.style.display = "none";
                lblNull.style.display = "none";
            }
            
            txtParm.style.display = GetDisplayAttributeString();
            
            if (tagPicker !=null)
            {
                tagPicker.style.display = "none";
            }
            
            if (timeZonePicker != null)
            {
                timeZonePicker.style.display = "none";
            }
            
            if (boolParm != null)
            {
                boolParm.style.display = "none";
            }
            
            if (dateTimeParm != null)
            {
                ShowHideDateTimePicker(dateTimeParm, false);
            }
            
            if (numericParm != null)
            {
                ShowHideNumberControl(numericParm, false);
            }
        }
        else
        {
            
            txtParm.readOnly = false;
            btnParm.style.display = "none";
           if (chkNull != null)
            {
                chkNull.style.display = GetDisplayAttributeString();
                lblNull.style.display = GetDisplayAttributeString();
            }
            
            if (tagPicker !=null)
            {
                tagPicker.style.display = GetDisplayAttributeString();
            }
            
            if (timeZonePicker != null)
            {
                timeZonePicker.style.display = GetDisplayAttributeString();
            }
            
            switch (dataType)
            {
                case "boolean":
                    txtParm.style.display = "none";
                    boolParm.style.display = GetDisplayAttributeString();
                    break;
                case "datetime":
                    txtParm.style.display = "none";
                    ShowHideDateTimePicker(dateTimeParm, true);
                    break;
                case "integer":
                case "float":
                    txtParm.style.display = "none";
                    ShowHideNumberControl(numericParm, true);
                    break;
                default:
                    txtParm.style.display = GetDisplayAttributeString();
                    break;
            }
            
            SetNullableToUI(id);
        }
    }

    function OpenSSRSReportViewerBehaviorHelpWindow()
    {
        var u = "SSRSReportViewerBehaviorHelp.aspx";
        return window.open(u, 'reportViewerBehaviorHelpPopup', 'top=50,left=100,height=360,width=910,resizable=yes');
    }
    
    function ShowImageAnimation()
    {
       document.getElementById("lblWait").style.visibility = "visible";
    }
    
    // isMultiple => '1' to allow multiple selection or '0' to allow single selection
    function OpenTagPicker(controlId, isMultiple)
    {
        var url = "SSRSHistorianTagLookUp.aspx?";
        
        url = url + "datafieldid=" + controlId + "&multiple=" + isMultiple + "&historianconnection=" + document.getElementById("<%=historianConnectionName.ClientID%>").value;
        
        window.open(url, "_default", "status=no,width=830,height=350,top=250,left=400");
    }
    
    function OpenTimeZonePicker(controlId)
    {
        var url = "SSRSTimeZonePicker.aspx?";
        
        var timezoneid = -1;
        if(document.getElementById(controlId) != null)
        {
            timezoneid = GetValueFromNumberControl(document.getElementById(controlId));
        }
        
        url = url + "datafieldid=" + controlId + "&historianconnection=" + document.getElementById("<%=historianConnectionNameforTimeZone.ClientID%>").value + "&timezone=" + timezoneid;
        
        window.open(url, "_default", "status=no,width=470,height=190,top=370,left=580")
    }
    
    function SetSSRSTagValue(controlId, controlValue, connectionName, tagType)
    {
        if(document.getElementById(controlId) != null)
        {
            if (tagType == 'TimeZone')
            {
                SetValueToNumberControl(document.getElementById(controlId), controlValue);
                if((connectionName != null) && (connectionName != ""))
                {
                    document.getElementById("<%=historianConnectionNameforTimeZone.ClientID%>").value = connectionName;
                }
            }
            else if (tagType == 'Historian')
            {
                document.getElementById(controlId).value = controlValue;
                if((connectionName != null) && (connectionName != ""))
                {
                    document.getElementById("<%=historianConnectionName.ClientID%>").value = connectionName;
                }
            }
        }
    }
    
    function setTagValue(exprnvalue, connectionName, name)
    {
        var textFueldId = document.getElementById('hidtxtParamId').value;
        if(document.getElementById(textFueldId) != null)
        {
         try{
                if(document.getElementById('hidtxtParamId')!= null &&
                document.getElementById('hidFullValueId')!= null &&
                document.getElementById('hidModeId')!= null && 
                document.getElementById('hidImageId')!= null)
                {
                    clearExp(document.getElementById('hidtxtParamId').value, document.getElementById('hidFullValueId').value, document.getElementById('hidModeId').value, document.getElementById('hidImageId').value)
                } 
            }
            catch(r)
            {
            
            }
            if(name == 'TimeZone')
            {
                SetValueToNumberControl(document.getElementById(textFueldId.replace("txtParam","rnt")), exprnvalue);
            }
            else{
                document.getElementById(textFueldId).value = exprnvalue;
            }
        }
        if(connectionName != null & connectionName != "")
        {
            if(name == 'Historian')
            {
                document.getElementById("<%=historianConnectionName.ClientID%>").value = connectionName;
            }
            if(name == 'TimeZone')
            {
                document.getElementById("<%=historianConnectionNameforTimeZone.ClientID%>").value = connectionName;
            }
        }
    }
</script>
