<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Forms.Web.Codebehind.SSRSTimeZonePicker" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<html>
<head id="Head1" runat="server">
   <title>
        <%= _GlobalResource.GetString("ssrs_timezone_picker_lbl")%>
    </title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <link rel="stylesheet" type="text/css" href="<%$ReplaceTemplateExpn:ProcessDesigner/Stylesheet/global.css%>" />
    <link rel="stylesheet" type="text/css" href="<%$ReplaceTemplateExpn:TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css%>" />
    <link rel="stylesheet" type="text/css" href="<%$ReplaceTemplateExpn:TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css%>" />
    <link rel="stylesheet" type="text/css" href="<%$ReplaceTemplateExpn:Common/StyleSheet/global.css%>" />
    <style type="text/css">
    
        .html, body {
        overflow-x: hidden;
        }
    </style>
</head>

<body style="margin: 0; left: 0; margin-bottom: 0; margin-top: 0; overflow: hidden;">
    <div id="ParentDiv">
        <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server" />
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
            <table border="0" cellpadding="0" cellspacing="1" width="100%">
            <tr>
                <td valign="top" colspan="2">
                    <table border="0" cellpadding="0" cellspacing="1" width="100%">
                        <tr valign="top">
                            <td class="header" valign="middle" style="width:97%">
                                <span class="pagetitle">
                                    <%= _GlobalResource.GetString("ssrs_timezone_picker_lbl")%>
                                </span>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <table border="0" cellpadding="0" cellspacing="1" width="100%">
                        <tr valign="top">
                            <td class="description" valign="middle" colspan="2">
                               <%= _GlobalResource.GetString("ssrs_timezone_picker_lbl_desc")%>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <table align="center" border="0" cellpadding="5" cellspacing="2" class="tablebg" width="100%">
                        <tr>
                            <td class="lefttdbg" style="width: 38%">
                                <span class="subtitle">
                                    <%=_GlobalResource.GetString("ssrs_tagpicker_connection_lbl")%>
                                </span>
                                <br />
                                <span class="description">
                                   <%=_GlobalResource.GetString("ssrs_tagpicker_connection_lbl_desc")%>
                                </span>
                            </td>
                            <td class="righttdbg">
                                <telerik:RadComboBox   ID="drpdwnTimeZoneConnection" RenderMode="Classic" runat="server" AllowCustomText="true" MarkFirstMatch="true" NoWrap="true" Height="150px"
                                     AutoPostBack="true" MaxLength="250" DropDownWidth="280px" Width="280px" EnableEmbeddedSkins="false"  Skin="AWTCombobox" OnSelectedIndexChanged="On_SelectedIndexChanged">
                                 </telerik:RadComboBox>                           
                                <br />
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td class="lefttdbg" style="width: 38%">
                                <span class="subtitle">
                                    <%=_GlobalResource.GetString("ssrs_timezone_item_lbl")%>
                                </span>
                                <br />
                                <span class="description">
                                   <%=_GlobalResource.GetString("ssrs_timezone_item_lbl_desc")%>
                                </span>
                            </td>
                            <td class="righttdbg">
                                 <telerik:RadComboBox   ID="drpdwnReportTimezone" RenderMode="Classic" runat="server" AllowCustomText="true" MarkFirstMatch="true" NoWrap="true" Height="80px"
                                     AutoPostBack="true" MaxLength="250" DropDownWidth="280px" Width="280px" EnableEmbeddedSkins="false"  Skin="AWTCombobox" OnSelectedIndexChanged="On_SelectedIndexChanged">
                                 </telerik:RadComboBox> 
                                <br />
                                <br />
                            </td>
                        </tr>
                        <tr class="footer">
                            <td colspan="2">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3">
                                    <tr>
                                        <td align="right">
                                            &nbsp;<asp:Button ID="Submit" runat="server" CssClass="inputbutton" OnClientClick="SetExpressionToParent();"/>
                                            <asp:Button ID="CloseButton" runat="server"  CssClass="inputbutton" OnClick="CloseButton_Click"/>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            </table>             
        </form>
    </div>
</body>
</html>

<script type="text/javascript">
    function AddEventHandler(elementObject, eventName, functionObject)
    {
        if(document.addEventListener)
        {
            elementObject.addEventListener(eventName, functionObject, false);
        }
        else
        {
            if(document.attachEvent)
            {
                elementObject.attachEvent("on" + eventName, functionObject);
            }
        }
    }

    /* Resizing function is not required now everything inside commom table*/
    AddEventHandler(window,"resize",resizefunction);
    AddEventHandler(window,"load",resizefunction);

    function resizefunction()
    {

    }

    function SetExpressionToParent()
    {
      
        var timeZoneVal = $find('<%= drpdwnReportTimezone.ClientID %>');
        var connection = $find('<%= drpdwnTimeZoneConnection.ClientID %>');
        var connectionName = "";
        if (connection.get_selectedItem() != null)
        {
            connectionName = connection.get_selectedItem().get_value();
        }
        if (timeZoneVal.get_selectedItem() != null)
        {
            controlId = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_dataFieldId, false)%>";
            window.opener.SetSSRSTagValue(controlId, timeZoneVal.get_selectedItem().get_value(), connectionName, 'TimeZone');
            self.close();
        }
        else
        {
            alert('<%=_GlobalResource.GetString("ssrs_timezone_picker_select_timezone")%>');
        }
    }
</script>

