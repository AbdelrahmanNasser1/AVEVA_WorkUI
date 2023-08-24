<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Forms.Web.CodeBehind.LookupList" %>
<%@ Register Assembly="Skelta.Forms.Web" Namespace="Skelta.Forms.Web" TagPrefix="cc1" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ OutputCache Duration="60" Location="None" NoStore="true" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Lookup list Explorer</title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <link rel="stylesheet" type="text/css" href="<%$ReplaceTemplateExpn:TelerikAjax/StyleSheet/AWTTreeView/TreeView.AWTTreeView.css%>" />
    <link rel="stylesheet" type="text/css" href="<%$ReplaceTemplateExpn:TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css%>" />
    <link rel="stylesheet" type="text/css" href="<%$ReplaceTemplateExpn:TelerikAjax/StyleSheet/AWTWindow/Window.css%>" />
    <link rel="stylesheet" type="text/css" href="<%$ReplaceTemplateExpn:TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css%>" />
    <link rel="stylesheet" type="text/css" href="<%$ReplaceTemplateExpn:TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css%>" />
    <link rel="stylesheet" type="text/css" href="<%$ReplaceTemplateExpn:SkeltaForms/StyleSheet/skeltaform.css%>" />
</head>
<body style="height: 100%; width: 100%; margin: 0; padding: 0; overflow: hidden;">
    <form id="form1" runat="server">
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <div id="divMain" class="skfc skcn skfdc skfas skfmd sf-formbackground">
            <div id="divheader" style="" class="sf-FormsHeader">
                <div style="float: left; padding: 6px;">
                    <img src="<%=ThemePath%>SkeltaForms/images/new-form-icon.png">
                </div>
                <div>
                    <div class="sf-topleveltitle">
                        <%= skrm.GlobalResourceSet.GetString("lookupeditprop_title")%>
                        <br>
                        <span class="sf-formlabeldescription">(<%=skrm.GlobalResourceSet.GetString("lookupeditprop_desc")%>)</span>
                    </div>
                </div>
            </div>
            <div id="divBody" class='skflx skfc skfdr skfas skcp'>
                <table>
                    <tr style="height: 30px; vertical-align: text-top;" align="center">
                        <td align="left" class="sf-formlabel" style="width: 50% !important; vertical-align: text-top !important;">
                            <%= skrm.GlobalResourceSet.GetString("lookupeditprop_provider") %>
                        </td>
                        <td style="width: 50%;" align="left">
                            <table>
                                <tr>
                                    <td>
                                        <input type="text" style="width: 60%;" class="inputs" onclick="OpenTableStructure();"
                                            id="txtListName" runat="server" readonly="readonly" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <span class="sf-formlabeldescription">
                                            <%=skrm.GlobalResourceSet.GetString("lookupeditprop_clickdesc")%>
                                        </span></td>
                                </tr>
                            </table>
                            <input type="hidden" id="hdnValue" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:Panel ID="pnl2" Height="100%" Width="100%" ScrollBars="None" runat="server">
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </div>
            <div align="right" id="divFooter" class="footerbg">
                <input type="button" name="btnClose" value='<%=skrm.GlobalResourceSet.GetString("lookupeditprop_btnclose")%>' onclick="window.close();" id="btnClose" class="inputsecondarybutton" style="margin-top: 3px; margin-right: 5px;" />
                <input type="submit" name="btnsubmit" value="Submit" id="btnSubmit" class="sf-inputsBox" style="margin-top: 3px; margin-right: 5px;" onserverclick="sendData_click" runat="server" />
            </div>
        </div>
        <div style="height: 80%; width: 50%; display: none; background-color: White; border: Solid 2px #d2d2d2; overflow:hidden;"
            id="divTree" runat="server">
            <table style="background-color: Silver; width: 100%" border="0">
                <tr>
                    <td align="right" style="width: 100%">
                        <a id="aCloseDiv" onclick="CloseDiv()">
                            <img style="border: 0" src="<%=ThemePath%>Common/Images/close.gif" /></a>
                    </td>
                </tr>
            </table>
            <telerik:RadTreeView Skin="AWTTreeView" EnableEmbeddedSkins="false" ShowLineImages="false" ID="RadTreeListView" runat="server" RenderMode="Classic" Height="100%"
                       EnableViewState="true"  AutoPostBack="true" OnClientNodeClicking="GetProviderNode">
            </telerik:RadTreeView>
         </div>
        <div style="height: 80%; width: 50%; display: none; background-color: White; border: Solid 2px #d2d2d2; overflow:auto;"
            id="divFormControls" runat="server">
            <table style="background-color: Silver; width: 100%" border="0">
                <tr>
                    <td align="right" style="width: 100%">
                        <a id="a1" onclick="CloseDivControls()">
                            <img style="border: 0" src="<%=ThemePath%>Common/Images/close.gif" /></a>
                    </td>
                </tr>
            </table>

            <telerik:RadTreeView Skin="AWTTreeView" EnableEmbeddedSkins="false" ShowLineImages="false" ID="ControlsTree" runat="server" RenderMode="Classic" Height="100%"
                       EnableViewState="true" AutoPostBack="false" OnClientNodeClicked="GetRadNode">
            </telerik:RadTreeView>
       </div>
    </form>
</body>
</html>

<script language="javascript" type="text/javascript">

    function GetProviderNode(sender, eventArgs)
    {
        var node = eventArgs.get_node();
        if (node.get_nodes().get_count() > 0)
        {
            node.expand();
            eventArgs.set_cancel(true);
        }
    }
    var text;
    var val;
    function GetRadNode(sender, eventArgs)
    {
       var node = eventArgs.get_node();
       if (node.get_nodes().get_count() > 0)
       {
         node.expand();
         return;
       }
        document.getElementById(text).value = node.get_text();
        document.getElementById(val).value = node.get_value();
        var DivTree = document.getElementById("<%=divFormControls.ClientID%>");
        DivTree.style.display = "none";
        eventArgs.set_cancel(true);
    }

    function OpenTableStructureForFormControls(txtId, hdntxtId)
    {
        text = txtId;
        val = hdntxtId;
        var DivTree = document.getElementById("<%=divFormControls.ClientID%>");
        DivTree.style.display = "block";
        DivTree.style.position = "absolute";
        DivTree.style.left = 10 + 'px';
        DivTree.style.top = 10 + 'px';      
        var RadTree = document.getElementById("<%=ControlsTree.ClientID%>");
        RadTree.style.height = DivTree.style.height;
              
    }

    function OpenTableStructure()
    {
     ToggleMax();
    }
    function ToggleMax()
    {
      var DivTree = document.getElementById("<%=divTree.ClientID%>");
        DivTree.style.display = "block";
        DivTree.style.position = "absolute";
        DivTree.style.left = 10 + 'px';
        DivTree.style.top = 10 + 'px';
        var RadTree = document.getElementById("<%=RadTreeListView.ClientID%>");
        RadTree.style.height = "92%";
        RadTree.style.overflow = "auto";
    }



    function CloseDiv()
    {
        var DivTree = document.getElementById("<%=divTree.ClientID%>");
        divTree.style.display = "none";
    }

    function CloseDivControls()
    {
        var DivTree = document.getElementById("<%=divFormControls.ClientID%>");
        divFormControls.style.display = "none";
    }

</script>

