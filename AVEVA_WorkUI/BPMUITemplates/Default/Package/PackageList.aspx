<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Package.CodeBehind.PackageList"
    EnableViewState="true" ValidateRequest="true" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE html>
<html style="height:100%">
<head id="Head1" runat="server">
   <style type="text/css">
       .FormatRadioButtonList tr td:first-of-type{
         padding-right:20px;
       }

       .RadWWrapperHeaderCenter {
           padding-top: 1px !important;
           vertical-align: middle !important;
       }

       .buttonMarging {
           margin-right:5px;
       }
       
   </style>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
</head>

<body id="body" style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 0px; border-style: none; padding-top: 0px; overflow: auto; height: 100%"
    onload="ResizeWindow()">
    <form id="packageForm" runat="server" style="height: 100%;">
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
            <%=System.Web.Helpers.AntiForgery.GetHtml()%>
            <link href="<%=themeURL%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
            <link href="<%=themeURL%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
            <link rel="stylesheet" type="text/css" href="<%:themeURL%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
            <link rel="stylesheet" type="text/css" href="<%:themeURL%>TelerikAjax/StyleSheet/AWTWindow/Window.css">
            <link rel="stylesheet" type="text/css" href="<%:themeURL%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css">
            <link rel="stylesheet" type="text/css" href="<%:themeURL%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css">

            <table style="width: 96%; padding-top: 9px; border-width: 0; border-spacing: 2px; border-collapse: separate; margin: auto; height: 10%">
                <tr>
                    <td class="pagetitle" style="padding: 3px">
                        <img src="<%=themeURL%>/Repository/ListControl/images/icon-package-templateDark.png"
                            style="vertical-align: middle; padding-right: 16px;" /><%= resourceManager.GlobalResourceSet.GetString("pkg_slct")%>
                    </td>
                </tr>
                <tr>
                    <td class="description" colspan="2" style="padding-left: 5%;">
                        <%:pageDiscription%>
                    </td>
                </tr>
                <%if (errorMsg != "")
                    { %>
                <tr>
                    <td class='errormsg' style="padding: 5px; text-align: center">
                        <%:errorMsg%>
                    </td>
                </tr>
                <%}%>
            </table>
        </telerik:RadScriptBlock>
        <table style="width: 87%; border-width: 0; border-spacing: 1px; border-collapse: separate; height: 70%; margin: auto; overflow: hidden;" class="tablebg">
            <tr>
                <td class="lefttdbg" style="padding: 3px; width: 65%">
                    <telerik:RadScriptBlock ID="RadScriptBlock2" runat="server">
                        <div class="subtitle">
                            <%= resourceManager.GlobalResourceSet.GetString("pkg_tmp_nme")%>
                            <img alt="Mandatory" id="imgTitlemandator" runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/Images/mandatoryicon.png%>" hspace="2" align="top" visible="true" />
                            <asp:CustomValidator ID="packageTemplateNameValidator" runat="server" ControlToValidate="cboPackageTemplates"
                                SetFocusOnError="true" Display="Dynamic" ValidateEmptyText="true" OnServerValidate="PackageTemplateNameValidator_ServerValidate">
                                <img alt="Mandatory" id="imgTitleError" runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/Images/erroricon.png%>" hspace="2" align="top" visible="true" />
                            </asp:CustomValidator>
                        </div>
                        <div class="description">
                            <%= resourceManager.GlobalResourceSet.GetString("pkg_tmp_nme_desc")%>
                        </div>
                    </telerik:RadScriptBlock>
                </td>
                <td class="righttdbg" style="text-align: right; width: 35%">
                    <telerik:RadComboBox ID="cboPackageTemplates" Width="350px" Height="250px" AllowCustomText="True" MarkFirstMatch="true" runat="server"
                        Skin="AWTCombobox" EnableEmbeddedSkins="false" AutoPostBack="true" OnSelectedIndexChanged="CboPackageTemplates_SelectedIndexChanged">
                    </telerik:RadComboBox>
                    <!--Combobox name and version-->
                </td>
            </tr>
            <tr>
                <td class="lefttdbg" style="padding: 3px; width: 65%">
                    <telerik:RadScriptBlock ID="RadScriptBlock3" runat="server">
                        <div class="subtitle">
                            <%= resourceManager.GlobalResourceSet.GetString("pkg_tmp_vrsn")%>
                        </div>
                        <div class="description">
                            <%= resourceManager.GlobalResourceSet.GetString("pkg_tmp_sbvrsn")%>
                        </div>
                    </telerik:RadScriptBlock>
                </td>
                <td class="righttdbg" style="text-align: right; width: 35%">
                    <telerik:RadComboBox ID="cboPackageTemplateVersions" Width="350px" Height="250px" runat="server"
                        Skin="AWTCombobox" EnableEmbeddedSkins="false" OnSelectedIndexChanged="CboPackageTemplateVersions_SelectedIndexChanged"
                        AutoPostBack="true">
                    </telerik:RadComboBox>
                    <input type="button" value=" View " id="btnView" runat="server" visible="false" class="inputbutton"
                        onclick="openRadWindow();" />
                </td>
            </tr>
            <tr>
                <td class="lefttdbg" style="padding: 3px;">
                    <telerik:RadScriptBlock ID="RadScriptBlock4" runat="server">
                        <div class="subtitle">
                            <%= resourceManager.GlobalResourceSet.GetString("pkg_incl_ass")%>
                        </div>
                        <div class="description">
                            <%= resourceManager.GlobalResourceSet.GetString("pkg_incl_ass_desc1")%>
                        </div>
                    </telerik:RadScriptBlock>
                </td>
                <td class="righttdbg" style="/*padding-left: 3%; */vertical-align: top; padding-top: 1%;">
                    <asp:RadioButtonList ID="rbtnAssociatedObject" runat="server" CssClass="inputradio FormatRadioButtonList"
                        RepeatDirection="Horizontal">
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr id="tableRowChildobjects" runat="server">
                <td class="lefttdbg" style="padding: 3px;">
                    <telerik:RadScriptBlock ID="RadScriptBlock5" runat="server">
                        <div class="subtitle">
                            <%= resourceManager.GlobalResourceSet.GetString("pkg_incl_chld")%>
                        </div>
                        <div class="description">
                            <%= resourceManager.GlobalResourceSet.GetString("pkg_incl_chld_desc1")%>
                        </div>
                    </telerik:RadScriptBlock>
                </td>
                <td class="righttdbg" style="/*padding-left: 3%; */vertical-align: top; padding-top: 1%;">
                    <asp:RadioButtonList ID="rbtnChildobjects" runat="server" CssClass="inputradio FormatRadioButtonList" RepeatDirection="Horizontal">
                        <asp:ListItem Selected="True">Yes</asp:ListItem>
                        <asp:ListItem>No</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr id="tableRowSecurity" runat="server">
                <td class="lefttdbg" style="padding: 3px;">
                    <telerik:RadScriptBlock ID="RadScriptBlock6" runat="server">
                        <div class="subtitle">
                            <%= resourceManager.GlobalResourceSet.GetString("pkg_incl_sec")%>
                        </div>
                        <div class="description">
                            <%= resourceManager.GlobalResourceSet.GetString("pkg_incl_sec_desc1")%><br />
                            <%= resourceManager.GlobalResourceSet.GetString("pkg_incl_sec_note_listitem")%>
                        </div>
                    </telerik:RadScriptBlock>
                </td>
                <td class="righttdbg" style="/*padding-left: 3%*/vertical-align:top; padding-top: 1%;">
                    <asp:RadioButtonList ID="rbtnSecurity" runat="server" CssClass="inputradio FormatRadioButtonList" Enabled="true"
                        RepeatDirection="Horizontal">
                        <asp:ListItem>Yes</asp:ListItem>
                        <asp:ListItem Selected="True">No</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr id="tableGenerateSqlScript" runat="server">
                <td class="lefttdbg" style="padding: 3px;">
                    <telerik:RadScriptBlock ID="RadScriptBlock7" runat="server">
                        <div class="subtitle">
                            <%= resourceManager.GlobalResourceSet.GetString("pkg_incl_GenerateSql")%>
                        </div>
                        <div class="description">
                            <%= resourceManager.GlobalResourceSet.GetString("pkg_incl_GenerateSql_desc1")%><br />
                        </div>
                    </telerik:RadScriptBlock>
                </td>
                <td class="righttdbg" style="/*padding-left: 3%*/vertical-align:top; padding-top: 1%;">
                    <asp:RadioButtonList ID="radioButtonGenerateScript" runat="server" CssClass="inputradio FormatRadioButtonList" Enabled="true"
                        RepeatDirection="Horizontal">
                        <asp:ListItem Selected="True">Yes</asp:ListItem>
                        <asp:ListItem>No</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
        </table>
        <div style="bottom: 20px; right: 20px; position: absolute;">
            <input type="button" id="btnClose" class="inputsecondarybutton buttonMarging" onclick="javascript:closeWindow();" runat="server" />
            <asp:Button runat="server" ID="btnAdd" CssClass="inputbutton" OnClick="ButtonAdd_Click" />
        </div>
        <telerik:RadAjaxPanel ID="mainPanel" runat="Server">
            <div>
                <telerik:RadWindowManager ID="Singleton" Skin="AWTWindow" Behaviors="Close" runat="server" EnableEmbeddedSkins="false" OnClientPageLoad="OnClientPageLoad">
                    <Windows>
                        <telerik:RadWindow ID="NewWindow" Height="300px" Width="555px" runat="server" Left="" Behaviors="Close"
                            Title="Add to Package template" Top="" />
                        <telerik:RadWindow ID="PackageConfirm" Height="140px" Width="480px" SetModal="true" Modal="true" runat="server" Left="" Behaviors="Close"
                            Title="Package Confirmation" Top="" />
                        <telerik:RadWindow ID="NewTemplate" Height="495px" Width="550px" SetModal="true" Modal="true" runat="server" Left="" Behaviors="Close"
                            Title="Package Confirmation" Top="" />
                    </Windows>
                </telerik:RadWindowManager>
            </div>
            <input id="hidden1" runat="server" type="hidden" />
            <input id="title" runat="server" type="hidden" />
        </telerik:RadAjaxPanel>
        <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
            <script type="text/javascript">
                var pageTitle = '<%= this.Page.Title%>';
                function GetItems(sender, eventArgs) {
                    sender.requestItems(sender.get_text(), false);
                }

                function GetRadWindow() {
                    var oWindow = null;
                    if (window.frameElement != null)
                        oWindow = window.frameElement.radWindow;
                    return oWindow;
                }

                function closeWindow(msg) {
                    if (msg)
                        se.ui.messageDialog.showError(pageTitle, msg, null);
                    var oWindow = GetRadWindow();
                    oWindow.close();

                }

                function ResizeWindow() {
                    var w = screen.availWidth;   //getMaxWidth();    
                    var h = screen.availHeight; //getMaxHeight();
                    var oWindow = GetRadWindow();

                    if (h < 900) {
                        w = w * .67;
                        h = h * .75;
                    }

                    if (h > 900) {
                        w = w * .60 //- 160;
                        h = h * .62 //- 10;
                    }

                    if (oWindow.isClosed() == false) {
                        oWindow.setSize(w, h); //width,height
                        oWindow.center();
                    }
                }

                function openRadWindow() {
                    var path = "../../Package/" + '<%=viewPath%>';
                    var oBrowserWnd = GetRadWindow().BrowserWindow;
                    var oWindow = oBrowserWnd.radopen(path, "NewWindow");
                    oWindow.setActive(true);
                    oWindow.set_modal(true);
                    oWindow.center();
                }

                function OpenPackageConfirmation(listparams, name, version, mode, include, application, objectName) {
                    var url = "..\\..\\Package\\PackageConfirmation.aspx?" + listparams + "&pkgTmpName=" + name + "&pkgTmpVersion=" + version + "&mode=" + mode + "&include=" + include + "&AppName=" + application + "&Name=" + objectName;
                    if (mode == "Global WorkItem Layout" || mode == "Queue") {
                        url = "..\\..\\Package\\PackageConfirmation.aspx?" + listparams + "&pkgTmpName=" + name + "&pkgTmpVersion=" + version + "&mode=" + mode + "&include=" + include + "&AppName=" + application + "&Name=" + objectName;
                    }

                    var oBrowserWnd = GetRadWindow().BrowserWindow;
                    var oWindow = oBrowserWnd.radopen(url, "PackageConfirm");
                    oWindow.setSize(400, 200)
                    //Add the OnClientClose function to be called on close
                    oWindow.add_close(OnClientClose);
                }

                function OnClientClose(oWindow, eventArgs) {
                    if (eventArgs.get_argument() !== null && eventArgs.get_argument() !== undefined && eventArgs.get_argument() == true) {
                        var parentWindow = GetRadWindow();
                        parentWindow.close();
                    }

                    //Remove the OnClientClose function to avoid
                    //adding it for a second time when the window is shown again.
                    oWindow.remove_close(OnClientClose);
                }

                function show_RadWindow(pageUrl, windowName) {

                    window.radopen(pageUrl, windowName);
                    return false;
                }

                function GetValues() {
                    document.getElementById("hidden1").value = parent.document.getElementById("hidGuid").value;
                }

                function OnClientPageLoad(sender, args) {
                    setTimeout(function () {
                        sender.set_status("");
                        sender.set_title("");
                    }, 0);
                }

                function OpenNewPackageTemplate(listparams, mode, appName) {
                    var url = "NewPackageTemplate.htm?" + listparams + "&type=" + mode + "&appName=" + appName;
                    var oWindow1;
                    setTimeout(function () {
                        oWindow1 = radopen(url, "NewTemplate");
                        if (oWindow1) {
                            oWindow1.setActive(true);
                        }
                    }, 3);
                }
            </script>
        </telerik:RadCodeBlock>
    </form>
</body>
</html>
