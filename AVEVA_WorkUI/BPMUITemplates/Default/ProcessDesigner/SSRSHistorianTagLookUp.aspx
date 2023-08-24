<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.PropertyTypes.SSRSHistorianTagLookUp"
    EnableEventValidation="false" %>
<%@ Register Assembly="Skelta.Forms.Web" Namespace="Skelta.Forms.Web" TagPrefix="cc1" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<html>
<head id="Head1">
   <title>
        <%= _GlobalResource.GetString("processdesigner_activity_setparam_popup_title")%>
    </title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ProcessDesignerControl.GetCommonRelativeUrl("Stylesheet/global.css"))%>"
        rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(_ObjExpBuilderURL)%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css" />
    <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(_ObjExpBuilderURL)%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css" />
    <link href="Stylesheet/global.css" rel="stylesheet" type="text/css" />
    <script type='text/javascript' src='<%=_JScriptPath%>'></script>
    <style type="text/css">
    
        .html, body {
        overflow-x: hidden;
        }
    </style>
</head>

<body style="margin: 0; left: 0; margin-bottom: 0; margin-top: 0; overflow: hidden;">
    <div id="ParentDiv">
        <form id="form1" runat="server">
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
             <telerik:RadScriptManager ID="RadScriptManager1" runat="server" />
            <table border="0" cellpadding="0" cellspacing="1" width="100%">
            <tr>
                <td valign="top" colspan="2">
                    <table border="0" cellpadding="0" cellspacing="1" width="100%">
                        <tr valign="top">
                            <td class="header" valign="middle" style="width:97%">
                                <span class="pagetitle">
                                    <%= _GlobalResource.GetString("ssrs_tagpicker_config")%>
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
                                <br />
                                    <%= _GlobalResource.GetString("ssrs_tagpicker_config_desc")%>
                                <br />&nbsp;
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
                                 <telerik:RadComboBox ID="drpdwnHistorianConnection" runat="server" AllowCustomText="true"  MarkFirstMatch="true" RenderMode="Classic"
                                          EnableEmbeddedSkins="false"  Skin="AWTCombobox" AutoPostBack="true" MaxLength="250" Width="260px" DropDownWidth="260px"
                                           Height="150px" NoWrap="True"  OnSelectedIndexChanged="On_SelectedIndexChanged">
                                     </telerik:RadComboBox>
                                <br />
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td class="lefttdbg" style="width: 38%">
                                <span class="subtitle">
                                    <%=_GlobalResource.GetString("ec_ssrs_tag")%>
                                </span>
                                <br />
                                <span class="description">
                                  <%=_GlobalResource.GetString("ec_ssrs_tag_desc")%>
                                  <br />
                                </span>
                            </td>
                            <td class="righttdbg">
                            <table width="100%">
                            <tr>
                                <td style="width:55%">
                                    <asp:ListBox runat="server" ID="ListAllTag" Height="170" Width="260">
                                    </asp:ListBox>
                                </td>
                                <td style="width:5%">
                                    <asp:Button runat="server" ID="ButtonAdd" Text="" OnClick="On_Add"/>
                                    </br>
                                    </br>
                                    <asp:Button runat="server" ID="ButtonDelete" Text="" OnClick="On_Remove"/>
                                </td>
                                <td style="width:40%">
                                    <asp:ListBox runat="server" ID="ListSelectedTag"  Height="170" Width="200"></asp:ListBox>
                                </td>
                            </tr>
                            </table>
                            
                            </td>
                        </tr>
                        <tr class="footer">
                            <td colspan="2">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3">
                                    <tr>
                                        <td align="right">
                                            &nbsp;<asp:Button ID="Submit" runat="server" CssClass="inputbutton" OnClientClick="SetExpressionToParent();"/>
                                            <asp:Button ID="CloseButton" runat="server"  CssClass="inputbutton" OnClick="CloseButton_Click"/>
                                            <!--  -->
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            </table> 
            <asp:HiddenField runat="server" ID="hiddenLoadCount" Value="" />
            <asp:HiddenField runat="server" ID="hiddenLoadTag" Value="" />
            <asp:HiddenField runat="server" ID="hiddenMultipleValue" Value="" />
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

/* Resizing function is not required now everything inside commom table*/
AddEventHandler(window,"resize",resizefunction);
AddEventHandler(window,"load",resizefunction);

function resizefunction()
        {

        }
        function SetExpressionToParent() 
        {
            var fianlString = "";
            var count;
            var selectedValues = document.getElementById("<%=ListSelectedTag.ClientID%>");
            if (selectedValues != null && selectedValues.length > 0) {
                for (count = 0; count < selectedValues.length; count++) {
                    if (fianlString == "") {
                        fianlString = selectedValues[count].value;
                    }
                    else {
                        fianlString = fianlString + ',' +selectedValues[count].value;
                    }

                }
            }
            var connection = $find('<%= drpdwnHistorianConnection.ClientID %>');
            var connectionName = "";
            if (connection.get_selectedItem() != null)
            {
                connectionName = connection.get_selectedItem().get_value();
            }

            var multiValue="";
            if(document.getElementById("<%=hiddenMultipleValue.ClientID%>")!=null)
            {
              multiValue =  document.getElementById("<%=hiddenMultipleValue.ClientID%>").value;
            }
              window.opener.setTagValue(fianlString, connectionName, 'Historian', multiValue);
                self.close();
        }
                
        function ReadValuefromParent() {
        if(document.getElementById("<%=hiddenLoadCount.ClientID%>").value != "Y" && window.opener.document.getElementById("historianConnectionName") != null && window.opener.document.getElementById("historianConnectionName").value != ""){
            var id = "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(_dataFieldId)%>";
            var datafield = window.opener.document.getElementById(id);
            var rightList = document.getElementById("<%=ListSelectedTag.ClientID%>");
            if(datafield != null && rightList != null)
            {
                var tagValues = datafield.value;
                if(tagValues != null && tagValues != "")
                {
                    document.getElementById("<%=hiddenLoadTag.ClientID%>").value = tagValues;
                }
                var splitedValue = tagValues.split(',');
                if(splitedValue != null && splitedValue.length >0)
                {
                    var count;
                        for(count=0;count < splitedValue.length; count++)
                        {
                            var optn;
                            optn = document.createElement("OPTION");
                            optn.text = splitedValue[count];
                            optn.value = splitedValue[count];
                            rightList.options.add(optn);
                        }
                }
            }
            document.getElementById("<%=hiddenLoadCount.ClientID%>").value = "Y";
        }
        }
        ReadValuefromParent();
</script>

