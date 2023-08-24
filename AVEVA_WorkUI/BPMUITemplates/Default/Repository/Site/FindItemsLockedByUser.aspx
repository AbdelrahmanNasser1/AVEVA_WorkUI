<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.BPMUITemplates_Default_Repository_Site_FindItemsLockedByUser"
    EnableEventValidation="false" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ Register TagPrefix="cc2" Namespace="Workflow.NET.Ajax" Assembly="Workflow.NET.NET2" %>

<!DOCTYPE HTML>
<html>
<head id="Head1" runat="server">
    <title>View and Unlock the Items</title>

    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>

    <script type="text/javascript">

        function selectUsers(clientid, hiddenVariableValue) {
            var oWindow = radopen("UserLookup.aspx?users=" + encodeURIComponent(document.getElementById(hiddenVariableValue).value) + "&singleselection=1", null);
            oWindow.set_modal(true);
            oWindow.set_title('Select Users');
            oWindow.setSize(630, 470);
            oWindow.setActive(true);
            oWindow.center();

            oWindow.add_beforeClose(onClientBeforeCloseUserLookup);

            function onClientBeforeCloseUserLookup(sender, args)
            {
                var returnValue = args.get_argument();

                if (returnValue !== null && returnValue !== undefined)
                {
                    document.getElementById('btnSearch').disabled = true;
                    var oArea = document.getElementById(clientid);
                    var ids;
                    var names = '';
                    var useridstring = '';
                    var ajaxInput = '';
                    if (returnValue.lastIndexOf("^") != -1)
                    {
                        var usernamestring = returnValue.substring(0, returnValue.lastIndexOf("^"));
                        useridstring = returnValue.substring(returnValue.lastIndexOf("^") + 1);
                        names = usernamestring;
                    }
                    oArea.value = names; //.substring(0, names.lastIndexOf(","));
                    var oArea1 = document.getElementById(hiddenVariableValue);
                    oArea1.value = useridstring;
                    if (useridstring != null && useridstring != 'undefined' && useridstring != '')
                        ajaxInput = useridstring;
                    else
                        ajaxInput = "@$!";
                    setTimeout("document.getElementById('divImage').style.visibility = 'visible';", 10);
                    setTimeout("document.getElementById('divImage').style.display = '';", 10);
                    if (document.getElementById('treeViewTable') != null && document.getElementById('treeViewTable') != 'undefined')
                    {
                        document.getElementById('treeViewTable').style.display = "none";
                    }
                    CallServerSideMethod(null, ajaxInput, "InitializeCombobox", OnSuccessInitializeComboBox, 'table', null);
                }

                sender.remove_beforeClose(onClientBeforeCloseUserLookup);
            }
        }
        function CallServerClick() {
            var button = window.document.getElementById('callserver').click();
        }
        function GetRadWindow() {

            var oWindow = null;

            if (window.radWindow)
                oWindow = window.radWindow;
            else if (window.frameElement.radWindow)
                oWindow = window.frameElement.radWindow;

            return oWindow;
        }

        function closeWin() {

            var oWindow = GetRadWindow();
            oWindow.close();
        }
        function OpenWindow(path) {

            document.getElementById('ifViewDetails').src = path;
        }

        function OpenSearchWindow() {

            var button = window.document.getElementById('SearchUser').click();
        }
        function OpenUserWindow() {

            var button = window.document.getElementById('ShowUserWindow').click();
        }

        function UpdateAllChildren(nodes, checked) {
            var i;
            for (i = 0; i < nodes.get_count(); i++) {
                if (checked) {
                    nodes.getNode(i).check();
                }
                else {
                    nodes.getNode(i).set_checked(false);
                }

                if (nodes.getNode(i).get_nodes().get_count() > 0) {
                    UpdateAllChildren(nodes.getNode(i).get_nodes(), checked);
                }
            }
        }
        function clientNodeChecked(sender, eventArgs) {
            var childNodes = eventArgs.get_node().get_nodes();
            var isChecked = eventArgs.get_node().get_checked();
            UpdateAllChildren(childNodes, isChecked);
        }


        function clearTextBox(textbox, hiddenVariableValue) {
            document.getElementById(textbox).value = "";
            document.getElementById(hiddenVariableValue).value = "";
            if (textbox == 'txtSubstituteUser') {
                if (document.getElementById('replaceUserSelectAllModules') != null && document.getElementById('replaceUserSelectAllModules') != 'undefined') {
                    document.getElementById('replaceUserSelectAllModules').style.display = "none";
                }
            }
        }

        function SetFocus() {
            try {
                document.body.focus();
            }
            catch (e) {

            }
        }

    </script>

    <style type="text/css">
        .class1 {
            overflow: auto;
        }

        html, body {
            height: 100%;
        }
    </style>
</head>
<body style="height: 100%">
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(bellyBarCss) %>CommonUXControls/StyleSheet/se.ui.min.css" />
    <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(bellyBarCss) %>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
    <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(bellyBarCss)%>TelerikAjax/StyleSheet/AWTWindow/Window.css">    

    <script>
        // Initialize locales for message dialog
        se.ui.messageDialog.setGlobalOptions({
            localization: { // All localization related default can be set
                closeButtonCaption: "<%=skrm.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                okButtonCaption: "<%=skrm.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                cancelButtonCaption: "<%=skrm.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                showDetailsCaption: "<%=skrm.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                hideDetailsCaption: "<%=skrm.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
            }
        });
    </script>
    <form id="form1" runat="server" style="height: 100%" align="center">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(themePath)%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />



        <table style="width: 98%; margin: 0px auto; border-width: 0; border-spacing: 0px">

            <tr class="ListHeaderCss">
                <td rowspan="2" style="vertical-align: middle; width: 40px; text-align: center;">
                    <img src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(themePath)%>Repository/ListControl/Images/icon-view-unlocked-items.png" alt="" />
                </td>
                <td class="MainHeading" id="spPageTile" runat="server" style="text-align: left;"><%=userLockedItemsDescription%></td>

            </tr>

            <tr>
                <td class="description" style="padding-bottom: 10px; text-align: left;">
                    <%=userLockedItemsDescriptionText %>       

                </td>
            </tr>

        </table>



        <table style="height: 5%; width: 96%; border-collapse: collapse; border-spacing: 0px; margin: 0px auto;">
            <tr>
                <td style="text-align: center; width: 100%;" colspan="2" class="lefttdbg">
                    <asp:Label CssClass="errormsg" ID="lblErrorMsg" runat="server" Style="display: none"></asp:Label>
                </td>
            </tr>
        </table>
        <table style="height: 15%; width: 95%; margin: 0px auto; border-spacing: 1px; border-collapse: separate;" class="tablebg" id="userInputTable" runat="server">
            <tr>
                <td class="lefttdbg" style="width: 50%; vertical-align: middle; padding: 3px; text-align: left;">
                    <span class="subtitle">
                        <%=skrm.GlobalResourceSet.GetString("sk_userlockeditems_userlookup")%><img id="imgMandatoryUserTobeReplacedName"
                            runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/images/mandatoryicon.png%>"
                            hspace="2" align="top" visible="true" /><asp:RequiredFieldValidator Display="Dynamic" ID="RequiredFieldValidatorForUserToBeReplaced"
                                runat="server" ControlToValidate="txtLockedUser"><img  alt=" <%=skrm.GlobalResourceSet.GetString("sk_userrefernece_user_ErrorIcon")%>" 
                                                id="imageUserToBeReplaced"  src="../../Skeltaforms/images/erroricon.png" />
                            </asp:RequiredFieldValidator></span>
                    <br />
                    <span class="description">
                        <%=skrm.GlobalResourceSet.GetString("sk_userlockeditems_userlookup_desc")%></span>
                </td>
                <td class="righttdbg" style="width: 50%; vertical-align: middle; padding: 3px; text-align: left;">
                    <asp:TextBox ID="txtLockedUser" CssClass="inputtext" runat="server" onclick="this.blur()"
                        Width="200px" oncopy="return false" onpaste="return false" oncut="return false"
                        Text=""></asp:TextBox>
                    <input id="btnLockedUserLookup" class="userlookup" runat="server" onclick="selectUsers('<%=txtLockedUser.ClientID%>','<%=hdnLockedUser.ClientID%>');"
                        type="button" value=".." name="SiteExplorer" />
                    <asp:HiddenField ID="hdnLockedUser" Value="" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="lefttdbg" style="width: 50%; vertical-align: middle; padding: 3px; text-align: left;">
                    <span class="subtitle">
                        <%=skrm.GlobalResourceSet.GetString("sk_userlockeditems_list")%><img id="img2" runat="server"
                            src="<%$ ReplaceTemplateExpn:Skeltaforms/images/mandatoryicon.png%>" hspace="2"
                            align="top" visible="true" /><asp:RequiredFieldValidator Display="Dynamic" ID="RequiredFieldValidator1" runat="server"
                                ControlToValidate="listNameComboBox">
                    <img  alt=" <%=skrm.GlobalResourceSet.GetString("sk_userlockeditems_selectlist")%>" 
                    id="Img1"  src="../../Skeltaforms/images/erroricon.png" />
                            </asp:RequiredFieldValidator></span>
                    <br />
                    <span id="spSelectList" runat="server" class="description"></span>
                </td>
                <td class="righttdbg" style="width: 50%; vertical-align: middle; padding: 3px; text-align: left;">
                    <asp:Panel ID="chkListPanel" runat="server" Visible="true">
                        <asp:DropDownList ID="listNameComboBox" runat="server" Width="205px" CssClass="inputselect">
                    </asp:DropDownList>                        

                        <asp:Button ID="btnSearch" runat="server" CssClass="inputbutton" Enabled="false"
                            Width="25%" />
                    </asp:Panel>
                </td>
            </tr>
        </table>
        <div id="divImage" align="center" style="visibility: hidden; font-family: arial; height: 1%; font-size: 16; left: 0px; top: 0px; width: 100%;"
            class="divBackgroundColor" runat="server">
            <asp:Image ID="imgLoading" runat="server" ImageUrl="<%$ ReplaceTemplateExpn:SOA/images/download_line.gif%>" />
        </div>
        <table style="table-layout: fixed; height: 60%; width: 98%; margin: 0px auto; border-collapse: separate; border-spacing: 1px;" class="tablebg" id="treeViewTable" runat="server" visible="true">

            <tr>
                <td class="lefttdbg" colspan="2" style="width: 100%; vertical-align: top; text-align: left;">
                    <table border="0" class="tablebg" style="height: 99%; margin: 0px auto; width: 100%; border-collapse: collapse; border-spacing: 0px;">
                        <tr>
                            <td style="height: 2%; padding: 4px;" class="tableheaderbg" colspan="2">
                                <span class="pagetitle">
                                    <%=skrm.GlobalResourceSet.GetString("sk_userlockeditems_itemslockedbytheuser") %>
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 2%; padding: 4px;" class="lefttdbg" colspan="2">
                                <span class="description">
                                    <%=skrm.GlobalResourceSet.GetString("sk_userlockeditems_selectandunlock") %>
                                </span>
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td id="tdPanel" style="height: 96%; width: 100%; vertical-align: top; padding: 4px;" class="lefttdbg" colspan="2">
                                <asp:Panel ID="Pnl1" runat="server" Height="100%" Width="100%" CssClass="class1">                                   

                                    <telerik:RadTreeView ID="RadTreeView1" runat="server" Height="100%" CheckBoxes="true" OnClientNodeChecked="clientNodeChecked"></telerik:RadTreeView>
                                </asp:Panel>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>

            <tr>
                <td class="lefttdbg" style="height: 2%; width: 100%; padding: 4px;" colspan="2">
                    <table style="width: 100%">
                        <tr>
                            <td style="text-align: left; width: 90%">
                                <img id="Imgtt" runat="server" alt="" src="<%$ ReplaceTemplateExpn:/Common/Images/icon-note.png%>" />&nbsp;
                            <span class="note" id="spCheckBoxesNote" runat="server"></span>
                            </td>
                            <td style="text-align: right; width: 10%">
                                <asp:Button ID="btnUnlock" CssClass="inputbutton" runat="server" />
                                <asp:Button ID="hiddenButtonUnlock" runat="server" Style="display: none;" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <div style="display: none">
            <input type="button" id="SearchUser" value="Open Window" />
            <%-- <asp:Button ID="callserver" value="Accept" OnClick="InitializeComboBox" runat="server" />--%>
        </div>
        <input id="hdnSelectList" value="<%=skrm.GlobalResourceSet.GetString("sk_userlockeditems_selectlist")%>"
            type="hidden" />
        <input id="hdnSelectUser" value="<%=skrm.GlobalResourceSet.GetString("sk_userlockeditems_selectuser")%>"
            type="hidden" />
        <input type="hidden" id="ddlElements" name="ddlElements" runat="server" />
       
      
        <cc2:AjaxPageControl ID="AjaxPageControl1" runat="server" Style="z-index: 104; left: 440px; position: absolute; top: 88px"></cc2:AjaxPageControl>

        <telerik:RadWindowManager ID="Singleton" Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false"
            runat="server" BackColor="Black" Behaviors="Close, Move" DestroyOnClose="true" Overlay="false" RenderMode="Classic" VisibleStatusbar="false">
            <Windows>
                <telerik:RadWindow ID="RadWindow1" Height="300px" Width="555px" runat="server" OpenerElementID="SearchUser"
                    NavigateUrl="UserLookup.aspx" Left="" Title="User Lookup" Top="">
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>
    </form>
</body>
</html>

<script type="text/javascript" language="javascript">

    function OnSuccessInitializeComboBox(context, result, response) {
        var optionsList = '';
        var combo = document.getElementById('listNameComboBox');
        var i;
        combo.options.length = 1;        
        for (i = 0; i < result.length; i = i + 2) {
            var option1 = document.createElement("option");
            if (result[0] != "Error") {

                option1.text = result[i];
                option1.value = result[i + 1];
                combo.options.add(option1);
            }
            else {
                errorMsgvisibility("", "errormsg", result[1]);
            }
        }

        for (var i = 0; i < combo.options.length; i++) {

            var optionText = combo.options[i].text;
            var optionValue = combo.options[i].value;

            if (optionsList.length > 0)

                optionsList += ';';
            optionsList += optionText;
            optionsList += ';';
            optionsList += optionValue;
        }

        document.getElementById('<%= ddlElements.ClientID %>').value = optionsList;
        if (combo.options.length > 1) {

            document.getElementById('btnSearch').disabled = false;
            document.getElementById('listNameComboBox').disabled = false;
            if (!checkErrorMsgAlreadyAvailable())
                errorMsgvisibility("none", "errormsg", "");
        }
        else {
            document.getElementById('btnSearch').disabled = true;              

            //If user unselect the lookup, then update the dropdown and no items avaialble should not be displayed
            if (document.getElementById('hdnLockedUser').value != null && document.getElementById('hdnLockedUser').value != "") {
                if (document.getElementById('lblErrorMsg') != null && document.getElementById('lblErrorMsg') != 'undefined') {
                    if (!checkErrorMsgAlreadyAvailable())
                        errorMsgvisibility("", "successfulmsg","<%=noItemsAvailable%>");   
                }
                else
                    se.ui.messageDialog.showError("<%=skrm.GlobalResourceSet.GetString("ec_menu_viewuserlockeditems")%>", "<%=noItemsAvailable%>");
            }
            else//if already message was visible
            {
                if (!checkErrorMsgAlreadyAvailable())
                    errorMsgvisibility("none", "errormsg", "");
            }
        }
        document.getElementById('divImage').style.visibility = 'hidden';
    }

    function errorMsgvisibility(display, className, message) {
        if (document.getElementById('lblErrorMsg') != null && document.getElementById('lblErrorMsg') != 'undefined' && message != "") {
            document.getElementById('lblErrorMsg').style.display = display;
            document.getElementById('lblErrorMsg').className = className;
            //document.getElementById('lblErrorMsg').innerHTML = message;
            se.ui.messageDialog.showAlert("<%=skrm.GlobalResourceSet.GetString("ec_menu_viewuserlockeditems")%>", message);
        }

    }

    function checkErrorMsgAlreadyAvailable() {
        if (document.getElementById('lblErrorMsg') != null && document.getElementById('lblErrorMsg') != 'undefined') {
            if (document.getElementById('lblErrorMsg').className == "errormsg" && document.getElementById('lblErrorMsg').innerHTML != "" && document.getElementById('lblErrorMsg').innerHTML != null)
                return true;
            else
                return false;
        }
        else
            return false;
    }
    function CheckSelected() {

        var tree = $find("<%= RadTreeView1.ClientID %>");
        var nodes = tree.get_allNodes();
               

        var isAnyNodeSelected = false;

        for (var i = 0; i < nodes.length; i++)
        {
            if (nodes[i].get_checked())
            {
                if (nodes[i].get_value() != document.getElementById('listNameComboBox').value)
                {
                    isAnyNodeSelected = true;

                    se.ui.messageDialog.showConfirmation("<%=skrm.GlobalResourceSet.GetString("ec_menu_viewuserlockeditems")%>", "<%=confirmMsg%>", function (userResponse) {
                        if (userResponse) {
                            if (document.getElementById('treeViewTable') != null && document.getElementById('treeViewTable') != 'undefined')
                                document.getElementById('treeViewTable').style.display = "none";
                            setTimeout("document.getElementById('divImage').style.visibility = 'visible';", 10);
                            setTimeout("document.getElementById('divImage').style.display = '';", 10);
                            document.getElementById("hiddenButtonUnlock").click();
                        }
                    });

                    break;
                }

            }            
        }      
      
        if (!isAnyNodeSelected) {
            se.ui.messageDialog.showError("<%=skrm.GlobalResourceSet.GetString("ec_menu_viewuserlockeditems")%>","<%=noItemsChecked%>");
            return false;
        }
    }

    function ValidateValues() {
        var userElement = document.getElementById('hdnLockedUser').value;
        errorMsgvisibility("none", "errormsg", "");

        if (userElement != null && userElement != "") {
            var combo = document.getElementById('listNameComboBox');
            var comboValue = combo.value;

            if (comboValue == "" || comboValue.length == 0) {
                if (combo.options.length > 1) {
                    if (document.getElementById('treeViewTable') != null && document.getElementById('treeViewTable') != 'undefined')
                        document.getElementById('treeViewTable').style.display = "none";
                    se.ui.messageDialog.showError("<%=skrm.GlobalResourceSet.GetString("ec_menu_viewuserlockeditems")%>", document.getElementById('hdnSelectList').value);
            }
            else
                se.ui.messageDialog.showError("<%=skrm.GlobalResourceSet.GetString("ec_menu_viewuserlockeditems")%>","<%=noItemsAvailable%>");
                return false;
            }
        }
        else {
            se.ui.messageDialog.showError("<%=skrm.GlobalResourceSet.GetString("ec_menu_viewuserlockeditems")%>", document.getElementById('hdnSelectUser').value);
            return false;
        }
        if (document.getElementById('treeViewTable') != null && document.getElementById('treeViewTable') != 'undefined')
            document.getElementById('treeViewTable').style.display = "none";
        setTimeout("document.getElementById('divImage').style.visibility = 'visible';", 10);
        setTimeout("document.getElementById('divImage').style.display = '';", 10);
        return true;
    }

    //Scroll bar for the panel was not available in mozilla firefox as the panel height is not fixed.
    if (document.getElementById("tdPanel") != null && document.getElementById("tdPanel") != 'undefined') {
        var treePanel = document.getElementById("Pnl1");
        if (treePanel != null) {
            if (navigator.userAgent.toLowerCase().indexOf('chrome') > 0) {
                treePanel.style.height = document.getElementById("tdPanel").clientHeight + "px";
            }
            else {
                treePanel.style.height = document.getElementById("tdPanel").clientHeight - 130 + "px";
            }

        }
    }
    //Hide the table on selection changed of dropdown
    function HideTreeViewTable() {
        if (document.getElementById('treeViewTable') != null && document.getElementById('treeViewTable') != 'undefined')
            document.getElementById('treeViewTable').style.display = "none";
    }
</script>

