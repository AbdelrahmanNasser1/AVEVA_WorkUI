<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.Workflowlookup" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!Doctype Html>
<html>
<head runat="server">
    <title></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <%--<link rel="stylesheet" type="text/css" href="styles/aquila.css" />--%>
    <link rel="stylesheet" type="text/css" href="<%$ReplaceTemplateExpn:Common/StyleSheet/Global.css%>" />
</head>
<style>
    html, body {
        height: 100%;
        width: 100%;
        overflow: hidden;
    }
</style>
<script type="text/javascript" language="javascript">
    function GetRadWindow()
    {
        var oWindow = null;
        oWindow = window.frameElement.radWindow;
        return oWindow;
    }

    function ReturnValues(id)
    {
        var selectedwfid = '';
        selectedwfid = id;
        var oWindow = GetRadWindow();
        if (typeof oWindow !== 'undefined' && oWindow.close)
        {
            oWindow.close(selectedwfid);
        }
    }

    //AddEventHandler(window, 'resize', resizefunction);
    //AddEventHandler(window, 'load', resizefunction);

    function AddEventHandler(elementObject, eventName, functionObject) {
        if (document.addEventListener)
            elementObject.addEventListener(eventName, functionObject, false);
        else
            if (document.attachEvent)
                elementObject.attachEvent("on" + eventName, functionObject);
    }

    //function resizefunction() {
    //    var bodydiv = document.getElementById('divbody');
    //    var headerdiv = document.getElementById('divheader');
    //    // var footerdiv = document.getElementById('divfooter');
    //    var parentdiv = document.getElementById('divparent');
    //    if (parentdiv.offsetParent == document.body)
    //        document.body.style.height = '100%';

    //    var parentdivheight = parentdiv.offsetParent.offsetHeight;
    //    parentdiv.style.height = parentdivheight;
    //    try { bodydiv.style.height = parentdivheight - headerdiv.offsetHeight; } catch (e) { }
    //    bodydiv.style.width = '100%';
    //    bodydiv.style.width = parentdiv.clientWidth;
    //    bodydiv.style.overflow = 'auto';
    //    parentdiv.style.overflow = 'hidden';
    //}


</script>

<body>
    <div id="divparent" style="height:90%;">
        <form id="form1" runat="server">
            <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
            <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
                <link rel="stylesheet" type="text/css" href="<%=cssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css">
                <link rel="stylesheet" type="text/css" href="<%=cssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css">
            <div id="divheader">
                <table width="94%" align="center" border="0" cellpadding="5" cellspacing="0">
                    <tr>
                        <td>
                            <img src="<%$ ReplaceTemplateExpn:/Repository/Site/images/workflow-lookup.png%>" runat="server" align="absmiddle" />
                            <span class="pagetitle"><%= _ResManager.GlobalResourceSet.GetString("ec_workflowlookup_Header")%> </span>
                        </td>
                    </tr>
                    <tr>
                        <td class="description">
                            <%= _ResManager.GlobalResourceSet.GetString("ec_workflowlookup_desc")%>
                        </td>
                    </tr>
                </table>
                <br />
            </div>
            <div id="divbody">
                <table cellpadding="5" cellspacing="1" width="94%" align="center" border="0" class="tablebg">
                    <tr>
                        <td class="lefttdbg" style="width: 45%">
                            <span class="subtitle">
                                <asp:Label ID="lblwf" runat="server"><%= _ResManager.GlobalResourceSet.GetString("ec_workflowlookup_workflowName")%></asp:Label></span>
                            <br />
                            <span class="description"><%= _ResManager.GlobalResourceSet.GetString("ec_workflowlookup_workflowDesc")%></span>
                        </td>
                        <td class="righttdbg" style="width: 50%">
                            <asp:Panel ID="pnllookup" runat="server">
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr valign="top" id="trversion" visible="false" runat="server">
                        <td class="lefttdbg">
                            <span class="subtitle">
                                <asp:Label ID="lblversion" runat="server"><%= _ResManager.GlobalResourceSet.GetString("ec_workflowlookup_VersionName")%></asp:Label></span>
                            <br />
                            <span class="description"><%= _ResManager.GlobalResourceSet.GetString("ec_workflowlookup_VersionDesc")%></span>
                        </td>
                        <td class="righttdbg">
                            <asp:Panel ID="pnlversion" runat="server">
                            </asp:Panel>
                        </td>
                    </tr>

                </table>
            </div>
    </div>
    <div id="" style="float: right;padding-right:10px;height:10%;">
        <input id="btncancel" onclick="javascript: ReturnValues('::');" class="inputsecondarybutton" type="button" value="<%= _ResManager.GlobalResourceSet.GetString("Wif_Close")%>" />
        <asp:Button ID="Button1" runat="server" CssClass="inputbutton" Text="Select" OnClick="Button1_Click" />
    </div>
    </form>
        
</body>
</html>
