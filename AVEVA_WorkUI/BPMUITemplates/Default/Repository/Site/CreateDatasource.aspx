<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.CreateDataSource" EnableEventValidation="true" EnableViewStateMac="true" ValidateRequest="true" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ OutputCache Duration="60" Location="None" NoStore="true" %>

<!DOCTYPE html >
<html>
<head id="Head1" runat="server">
    
    <title>
        <%=strtitle%>
    </title>
    <script type="text/javascript">
        function ConnectionPropertiesChanged() {
            //document.getElementById("btnOk").disabled = true;
        }

        function ShowDetails(checkId) {
            var bodydiv = document.getElementById('BodyDiv');

            if (!checkId.checked) {
                document.getElementById('tblDbdetails').style.visibility = 'visible';
                document.getElementById('btnTestConnection').disabled = false;
                document.getElementById('btnSave').disabled = true;
                bodydiv.style.overflow = 'auto';
            }
            else {
                document.getElementById('tblDbdetails').style.visibility = 'hidden';                
                document.getElementById('btnTestConnection').disabled=true;
                document.getElementById('btnSave').disabled = false;
                bodydiv.style.overflow = 'hidden';
            }
        }

        function ShowDetailsByDefault(checkId) {
            if (!checkId.checked) {
                document.getElementById('tblDbdetails').style.visibility = 'visible';
                document.getElementById('btnTestConnection').disabled= false;
                document.getElementById('btnSave').disabled = true;
            }
            else {
                document.getElementById('tblDbdetails').style.visibility = 'hidden';
                document.getElementById('btnTestConnection').disabled = true;
                document.getElementById('btnSave').disabled = false;
            }
        }

        function OnLoad() {
            if (!document.getElementById('chkRepo').checked) {
                document.getElementById('tblDbdetails').style.visibility = 'visible';
                document.getElementById('btnTestConnection').disabled = false;
            }

            var rWin = GetRadWindow();
            if (window.parent.location.search != null && window.parent.location.search == '?FromArchestrA=true') {
                rWin.setSize(rWin.get_width(), 550);
            }
            else {
                var cltHeight = parent.parent.document.body.clientHeight;

                if (rWin.get_height() > cltHeight) {
                    var winHeight = cltHeight - 36;
                    rWin.setSize(rWin.get_width(), winHeight);
                }
            }
            
            rWin.center();
            
            var check = window.navigator.userAgent;
            var isMozilla = false;
            if (check.indexOf("Firefox") != -1) {
                isMozilla = true;
                this.top.document.body.scrollTop = 0;
            }
        }

        function DisableIfWindows() {
            var authType = document.getElementById('ddlAuthenticationType');            
            if (authType.value == "Windows") {
                document.getElementById('txtUserId').disabled = "disabled";
                document.getElementById('txtPassword').disabled = "disabled";
            }
        }

        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow)
                oWindow = window.radWindow;
            else if (window.frameElement.radWindow)
                oWindow = window.frameElement.radWindow;
            return oWindow;
        }

        function CloseWindow() {
            var oWindow = GetRadWindow();
            setTimeout(function () {
                oWindow.close();
            }, 0);
        }

        function scrollposition()
        {
            var bigDiv = document.getElementById('BodyDiv');
            document.getElementById("hidscrollValue").value = bigDiv.scrollTop;
        }
    </script>
    <style type="text/css">
        html {height:100%;}
    </style>
    <link href="../../Common/StyleSheet/Global.css" rel="stylesheet" />
</head>

    <script type="text/javascript">

        function DisableSaveButton() {
           
            var hidTestConnectionvalue = document.getElementById("<%=hidTestConnection.ClientID%>").value;
        if (hidTestConnectionvalue == "true") {

            if (document.getElementById("<%=btnSave.ClientID%>") != null) {
                document.getElementById("<%=btnSave.ClientID%>").disabled = true;
                }
            }
            var bigDiv = document.getElementById('BodyDiv');
            document.getElementById("hidscrollValue").value = bigDiv.scrollTop;
        }

        function openAssembly() {           
            var tempPath = "<%=templatePath%>";
            if (tempPath.indexOf("layouts") == -1) {
                var oWindow = radopen("../../SkeltaForms/ChooseAssembly.aspx", null);
            }
            else {
                var oWindow = radopen("<%=templatePath%>SkeltaForms/ChooseAssembly.aspx", null);
            }            
            oWindow.set_modal(true);
            oWindow.set_title('Connection Provider');
            oWindow.setSize(590, 275);
            oWindow.setActive(true);
            oWindow.center();           
        }


        function Setdate(sender, args) {
            var data = args.get_argument();            
            document.getElementById("txtAssembly").value = sender.IframeDocument.getElementById('txtAssembly').value.replace(/C:\\fakepath\\/i, '');
            document.getElementById("txtParam").value = sender.IframeDocument.getElementById('txtParam').value;
            document.getElementById("hidAssembly").value = sender.IframeDocument.getElementById('txtAssembly').value;
        }

        function AddEventHandler(elementObject, eventName, functionObject) {
            if (document.addEventListener)
                elementObject.addEventListener(eventName, functionObject, false);
            else
                if (document.attachEvent)
                    elementObject.attachEvent("on" + eventName, functionObject);
        }

        function strValidate(obj) {
            var ValidChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
            var Ischar = true;
            var Char;
            var focus = 0;
            var sText = obj.value;
            for (i = 0; i < sText.length && Ischar == true; i++) {
                Char = sText.charAt(i);
                if (Char != " ")
                    if (ValidChars.indexOf(Char) == -1) {
                        focus = 1;
                        se.ui.messageDialog.showError("<%=skrm.GlobalResourceSet.GetString("ec_menu_dbconn") %>", "<%=specialCharAlertMsg%>");
                        break;
                    }
            }
            if (focus == 1) {
                document.getElementById("txtName").focus();
            }
        }


        function ContainsSpecialChar(obj) {
            if (obj == null) {
                obj = document.getElementById('txtName');
                if (obj != null && obj.value == "") {
                    //alert("Title is mandatory field");
                    se.ui.messageDialog.showError("<%=skrm.GlobalResourceSet.GetString("ec_menu_dbconn") %>", "<%=listTitleMandatoryAlertMsg%>");
                return false;
            }
        }
        var iChars = "!@#$%^&*()+=-[]\\\';,./{}|\":<>?";
        var sText = obj.value;
        if (obj.value != "") {
            for (var i = 0; i < sText.length; i++) {
                if (iChars.indexOf(sText.charAt(i)) != -1) {
                    //alert ("Title has special characters. \nThese are not allowed.\n Please remove them and try again.");
                    se.ui.messageDialog.showError("<%=skrm.GlobalResourceSet.GetString("ec_menu_dbconn") %>", "<%=specialCharAlertMsg%>");
                        obj.value = "";
                        obj.focus();
                        return false;
                    }
                }
                //document.getElementById('img1').style.display="none"; 
                //document.getElementById('img1').style.visibility = "hidden";
            }
            else {
                //document.getElementById('img1').style.display="block";
                //document.getElementById('img1').style.visibility = "visible"
                obj.focus();
                return false;
            }


            return true;

        }


        function ValidateFormData(obj) {
            try {

                var title = document.getElementById('txtName');
                // validate the title
                if (ContainsSpecialChar(title)) {


                    if (!document.getElementById('chkRepo').checked) {
                        // validate if the connection is from a provider


                        var datasourceType = document.getElementById('rdoConnection');
                        if (datasourceType.checked) {

                            // validate the server
                            var serverName = window["ddlServers"].control.get_text();
                            if (serverName == "") {
                                se.ui.messageDialog.showError("<%=skrm.GlobalResourceSet.GetString("ec_menu_dbconn") %>", "<%=serverNameAlertMsg%>");
                            //alert("Select the datasource server name");
                            //window["ddlServers"].Focused = true
                            return false;
                        }
                        // validate the userid & pwd if the auth mode is other then windows

                        var authType = document.getElementById('ddlAuthenticationType');
                        if (authType.value != "Windows") {
                            if (document.getElementById('txtUserId').value == "") {
                                se.ui.messageDialog.showError("<%=skrm.GlobalResourceSet.GetString("ec_menu_dbconn") %>", "<%=sqlUserIdAlertMsg%>");
                                document.getElementById('txtUserId').focus();
                                return false;
                            }
                            if (document.getElementById('txtPassword').value == "" && obj.id == "btnTestConnection") {
                                se.ui.messageDialog.showError("<%=skrm.GlobalResourceSet.GetString("ec_menu_dbconn") %>", "<%=sqlUserPwdeAlertMsg%>");
                                document.getElementById('txtPassword').focus();
                                return false;
                            }
                        }
                        //debugger;
                        // validate DB name if datasource is sql
                        var datasourceType = document.getElementById('rddataType');

                        if (document.getElementById(datasourceType.id + "_" + 0).checked) {
                            if (window["gridDatabase"].control.get_text() == "") {
                                se.ui.messageDialog.showError("<%=skrm.GlobalResourceSet.GetString("ec_menu_dbconn") %>", "<%=databaseNameAlertMsg%>");
                                //alert("Select the database");
                                return false;
                            }

                        }
                        return true;
                    }
                    else {

                        if (document.getElementById('txtAssembly').value == "") {
                            se.ui.messageDialog.showError("<%=skrm.GlobalResourceSet.GetString("ec_menu_dbconn") %>", "<%=sqlAsmAlertMsg%>");
                            //alert("Provide the assembly to get the data source connection string");
                            return false;
                        }
                        else
                            return true;
                    }


                }
                else if (ContainsSpecialChar(title)) {
                    return true;
                }
                else {
                    se.ui.messageDialog.showError("<%=skrm.GlobalResourceSet.GetString("ec_menu_dbconn") %>", "<%=listTitleMandatoryAlertMsg%>");
                    //alert("Title is mandatory.\nSpecial characters are not allowed.");
                    return false;
                }
            }
            else {
                se.ui.messageDialog.showError("<%=skrm.GlobalResourceSet.GetString("ec_menu_dbconn") %>", "<%=listTitleMandatoryAlertMsg%>");
                    //alert("Title is mandatory.\nSpecial characters are not allowed.");
                    return false;
                }

                return true;

            }
            catch (err) {
                return true;
            }
        }

        /* Resizing function is not required now everything inside commom table*/
        AddEventHandler(window, "resize", resizefunction);
        AddEventHandler(window, "load", resizefunction);

        function resizefunction() {

            var bodydiv = document.getElementById('BodyDiv');
            var headerdiv = document.getElementById('HeaderDiv');
            var footerdiv = document.getElementById('FooterDiv');
            var parentdiv = document.getElementById('ParentDiv');
            if (parentdiv.offsetParent == document.body)
                // document.body.style.height = '100%';

                var parentdivheight = parentdiv.offsetParent.offsetHeight;
            // parentdiv.style.height = parentdivheight;
            try { bodydiv.style.height = parentdivheight - headerdiv.offsetHeight - 10 - footerdiv.offsetHeight + 'px'; } catch (e) { } //headerdiv.offsetHeight -
            // bodydiv.style.width = '100px';
            //  bodydiv.style.width = parentdiv.clientWidth;
            if (navigator.userAgent.toLowerCase().indexOf('firefox') > 0) {
                if (!document.getElementById('chkRepo').checked) {
                    bodydiv.style.overflow = 'auto';
                }
                else {
                    bodydiv.style.overflow = 'hidden';
                }
            }
            else {
                if (!document.getElementById('chkRepo').checked) {
                    bodydiv.style.overflow = 'auto';
                }
                else {
                    bodydiv.style.overflow = 'hidden';
                }
            }
            parentdiv.style.overflow = 'hidden';

            //var controlToFocus = document.getElementById("hidSourceID").value;
            //if (controlToFocus!=null && controlToFocus != "")
            //{
            //    document.getElementById(controlToFocus).focus();
            //}
            var controlToFocus = document.getElementById("hidscrollValue").value;
            var bigDiv = document.getElementById('BodyDiv');
            bigDiv.scrollTop = controlToFocus;




        }
    </script>

<body style="margin: 0; overflow: hidden;width:100%;height:99%"  onload="javascript:OnLoad();">
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(cssPath) %>CommonUXControls/StyleSheet/se.ui.min.css" />
     <link rel="stylesheet" type="text/css" href="<%:cssPath%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
     <link rel="stylesheet" type="text/css" href="<%:cssPath%>TelerikAjax/StyleSheet/AWTWindow/Window.css">
    <link rel="stylesheet" type="text/css" href="<%:cssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css">
    <link rel="stylesheet" type="text/css" href="<%:cssPath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css">
    <script>
        se.ui.messageDialog.setGlobalOptions({
            localization: { 
                closeButtonCaption: "<%=skrm.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>", 
                okButtonCaption: "<%=skrm.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>", 
                cancelButtonCaption: "<%=skrm.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>", 
                showDetailsCaption: "<%=skrm.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>", 
                hideDetailsCaption: "<%=skrm.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" 
            }
        });
    </script>
    <div id="ParentDiv" style="height:100%">
        <form id="Form1" name="form1" runat="server" style="width:100%;height:99%" class="sf-formbackground">
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
            <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(templateThemeDirectory)%>Common/StyleSheet/Global.css" />
        <asp:Panel ID="Panel1" runat="server" Height="99%">
            <div id="HeaderDiv" style="width:100%;">

                <table style="width:100%">
                    <tr>
                        <td rowspan="2" style="vertical-align: middle;width:40px;text-align:center;padding-left:11px;padding-top:20px;">
                            <img src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(templateThemeDirectory)%>Repository/ListControl/images/icons-ribbon/connectionnew.png"   alt="" /></td>
                        <td class="windowTitle" style="vertical-align:bottom;"><%=skrm.GlobalResourceSet.GetString("conn_connheader")%></td>
                    </tr>
                </table>              

            </div>
            <div id="BodyDiv" style="width:100%;height:86%;">
                <table style="width: 96%; border-width: 0; margin:0px auto;border-collapse:separate;border-spacing:10px;padding-left:29px;padding-right:30px;">
                    <tr style="width:100%;">
                        <td class="lefttdbg" style="width: 30%;padding-top:10px;">
                            <span class="lblNameStyle">
                                <%=skrm.GlobalResourceSet.GetString("conn_title")%><img id="imgmandator" alt="Mandatory"
                                    runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/Images/mandatoryicon.png%>"
                                    hspace="2" align="top" visible="true" /></span>
                            
                            <br />
                            <br />
                            
                        </td>
                        <td class="righttdbg" style="padding-bottom:10px;width:70%;">
                            <input type="text" name="txtName" 
                                class="txtboxStyle" style="width: 100%;" value="" maxlength="200" id="txtName" runat="server" />
                        </td>
                    </tr>
                    <tr style="width:100%; vertical-align:top">
                        <td class="lefttdbg" style="width:30%;">
                            <span class="lblNameStyle">
                                <%=skrm.GlobalResourceSet.GetString("conn_desc") %></span>
                            <br />
                            
                        </td>
                        <td class="righttdbg" style="padding:1px;width:70%;">
                            <textarea rows="3" cols="15" id="txtDescription" class="txtareaStyle" style="width: 100%;"
                                name="txtDescription" runat="server"></textarea>
                        </td>
                    </tr>
                    <tr style="width:100%;">
                        <td class="lefttdbg" style="padding:1px;width:30%;">
                            <span class="lblNameStyle">
                                <%= skrm.GlobalResourceSet.GetString("conn_sarepo")%></span>
                            <br />
                            <span class="lblDescriptionStyle">
                                <%=skrm.GlobalResourceSet.GetString("conn_sarepodesc")%>
                            </span>
                        </td>
                        <td class="righttdbg" style="padding-bottom:15px;margin-left:0px;width:70%;">
                            <input type="checkbox" id="chkRepo" runat="server" onclick="javascript:ShowDetails(this);"
                                checked="checked" value="IsRepositotyDataBase" class="chkboxStyle" />
                        </td>
                    </tr>
                </table>
                <table style="width: 96%; border-width: 0; visibility: hidden; margin: auto; border-collapse:separate;border-spacing:10px;padding-left:29px;padding-right:30px;"
                    id="tblDbdetails" >
                    <tr style="width:100%;">
                        <td class="lefttdbg" style="width: 30%;padding:1px;">
                            <span class="lblNameStyle">
                                <%=skrm.GlobalResourceSet.GetString("conn_dbtype")%></span><br />
                            <span class="lblDescriptionStyle">
                                <%=skrm.GlobalResourceSet.GetString("conn_dbtypedesc") %></span>
                        </td>
                        <td class="righttdbg" style="padding-bottom:15px;width:70%;">
                            <asp:RadioButtonList RepeatDirection="Horizontal" ID="rddataType" runat="server" CellSpacing="0"
                                CssClass="inputradio" OnSelectedIndexChanged="rdoSQL_ServerChange" AutoPostBack="true">
                                <asp:ListItem Value="SQL Server"></asp:ListItem>
                                <asp:ListItem Value="Oracle"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    
                    <tr style="width:100%;">
                        <td class="lefttdbg" style="width: 30%;padding:1px;">
                            <span class="subtitle">
                                <%=skrm.GlobalResourceSet.GetString("conn_conntype") %></span><br />
                            <span class="description">
                                <%=skrm.GlobalResourceSet.GetString("conn_conntypedesc") %></span>
                        </td>
                        <td class="righttdbg" style="padding-bottom:15px;width:70%;">
                            <asp:RadioButton ID="rdoConnection" runat="server" CssClass="inputradio" GroupName="ConnectionType"
                                OnCheckedChanged="rdoConnection_CheckedChanged" AutoPostBack="True" Checked="True" />
                            <asp:RadioButton ID="rdoAssembly" runat="server" CssClass="inputradio" GroupName="ConnectionType"
                                AutoPostBack="True" OnCheckedChanged="rdoAssembly_CheckedChanged" />
                        </td>
                    </tr>
                    <%
                        if (flag == 1)
                        {%>
                    <tr style="width:100%;">
                        <td class="lefttdbg" id="tdServerName" runat="server" style="padding:1px;width:30%;">
                            <span class="lblNameStyle">
                                <%=skrm.GlobalResourceSet.GetString("conn_server") %></span><br />
                        </td>
                        <td class="righttdbg" style="padding:1px;width:70%;">
                            <table style="border-width:0;border-spacing:1px;border-collapse:collapse" >
                                <tr style="width:100%;">
                                    <td style="height: 30px;vertical-align:top;width:100%;">                                     
                                        <telerik:RadComboBox   ID="ddlServers"  RenderMode="Classic" runat="server" AllowCustomText="True" Width="200px" Height="175px"  MaxLength="128"
                                        DropDownWidth="200px" EnableEmbeddedSkins="false"  Skin="AWTCombobox" AutoPostBack="true" NoWrap="true" OnClientSelectedIndexChanged="DisableSaveButton" OnClientKeyPressing="DisableSaveButton">
                                      </telerik:RadComboBox>
                                   </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="width:100%;"><td class="lblDescriptionStyle" colspan="2"><%=skrm.GlobalResourceSet.GetString("conn_serverdesc")%></td></tr>
                    <tr style="width:100%;">
                        <td class="lefttdbg" id="tdAuthentication" runat="server" style="padding:1px;width:30%;">
                            <span class="lblNameStyle">
                                <%=skrm.GlobalResourceSet.GetString("conn_authtype") %></span><br />
                            <span class="lblDescriptionStyle">
                                <%=skrm.GlobalResourceSet.GetString("conn_authtypedesc")%></span>
                        </td>
                        <td style="text-align: left;padding-bottom:10px;width:70%;" class="righttdbg">
                            <asp:DropDownList ID="ddlAuthenticationType" runat="server" Width="200px" Height="175px" CssClass="inputselect">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr style="width:100%;">
                        <td class="lefttdbg" id="tdUserId" runat="server" style="padding:1px;width:30%;">
                            <span class="lblNameStyle">
                                <%=skrm.GlobalResourceSet.GetString("conn_uid") %></span><br />
                            <span class="lblDescriptionStyle">
                                <%=skrm.GlobalResourceSet.GetString("conn_uiddesc")%></span>
                        </td>
                        <td style="text-align: left;padding-bottom:10px;width:70%;" class="righttdbg">
                            <input name="text" type="text" onfocus="javascript:DisableIfWindows();" class="txtboxStyle"
                                id="txtUserId" style="width: 100%;" runat="server"  value="" />
                        </td>
                    </tr>
                    <tr style="width:100%;">
                        <td class="lefttdbg" id="tdPassword" runat="server" style="padding:1px;width:30%;">
                            <span class="lblNameStyle">
                                <%=skrm.GlobalResourceSet.GetString("conn_pwd") %></span><br />
                            <span class="lblDescriptionStyle">
                                <%=skrm.GlobalResourceSet.GetString("conn_pwddesc")%></span>
                        </td>
                        <td style="text-align: left;padding-bottom:10px;width:70%;" class="righttdbg" >
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="txtboxStyle" TextMode="Password" 
                                Style="width: 100%;" onkeypress="javascript:DisableIfWindows();"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="width:100%;">
                        <td class="lefttdbg" id="tdAvanceSetting" runat="server" style="padding:1px;vertical-align:top;width:30%;">
                            <span class="lblNameStyle">
                                <%=skrm.GlobalResourceSet.GetString("conn_advsett")%></span><br />
                            <span class="lblDescriptionStyle">
                                <%=skrm.GlobalResourceSet.GetString("conn_advsettdesc")%></span>
                        </td>
                        <td style="text-align: left;padding-bottom:10px;width:70%;" class="righttdbg">
                            <input name="text" type="text" class="txtboxStyle" id="txtAdvancedSettings" runat="server"
                                style="width: 100%;">
                            <span class="sf-formlabeldescription"></span>
                            <asp:Label ID="lblAdvSettingMsg" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr style="width:100%;">
                        <td class="lefttdbg" id="tdDataBase" runat="server" style="padding:1px;width:30%;">
                            
                                <span class="lblNameStyle">
                                <%=skrm.GlobalResourceSet.GetString("conn_dbname") %></span><br />
                            
                        </td>
                        <td class="righttdbg" style="padding:1px;width:70%;">
                            <table style="border-width:0; border-spacing:2px;border-collapse:collapse" >
                                <tr  style="width:100%;">
                                    <td style="vertical-align:top;width:30%;">

                                       <telerik:RadComboBox   ID="gridDatabase"  RenderMode="Classic" runat="server" AllowCustomText="True" Width="200px" Height="125px"  MaxLength="114"
                                        DropDownWidth="200px" EnableEmbeddedSkins="false"  Skin="AWTCombobox" AutoPostBack="true" NoWrap="true" OnClientSelectedIndexChanged="DisableSaveButton" OnClientKeyPressing="DisableSaveButton">
                                      </telerik:RadComboBox>
                                    </td>
                                    <td style="width:70%;">
                                        <asp:ImageButton ImageUrl="<%$ ReplaceTemplateExpn:Repository/Site/Images/icon-refresh.png %>" runat="server" ID="imgRefreshDB"
                                            OnClick="btnShowDatabases_Click" OnClientClick="scrollposition()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="width:100%;"><td class="lblDescriptionStyle" colspan="2"><%=skrm.GlobalResourceSet.GetString("conn_dbnamedesc")%></td></tr>
                    <%}
                else
                {%>
                    <tr style="width:100%;">
                        <td class="lefttdbg" valign="middle" id="tdAssemblyPath" runat="server" style="padding:1px;width:30%;">
                            <span class="subtitle">
                                <%=skrm.GlobalResourceSet.GetString("conn_asmpath") %></span><br />
                            <span class="description">
                                <%=skrm.GlobalResourceSet.GetString("conn_asppathbrowse") %></span>
                        </td>
                        <td class="righttdbg" style="padding:1px;width:70%;">
                            <table style="border-collapse:collapse;border-spacing:0px;">
                                <tr style="width:100%;">
                                    <td style="width:30%;">
                                        <asp:TextBox ID="txtAssembly" EnableViewState="true" runat="server" CssClass="txtboxStyle"  OnTextChanged="TxtAssembly_TextChanged"
                                            ReadOnly="false" Style="width: 250px;"></asp:TextBox>
                                    </td>
                                    <td style="width"70%;">
                                        <img alt="" runat="server" id="imgAssembly" onclick="javascript:openAssembly();" /><input
                                            type="hidden" id="txtParam" runat="server" /><input type="hidden" id="hidAssembly"
                                                runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="padding:1px;">
                            <asp:Label ID="warningNote" runat="server" CssClass="note"></asp:Label>
                        </td>
                    </tr>
                    <% } %>
                </table>
                <asp:TextBox ID="txtHidPwd" runat="server" Visible="False" CssClass="inputtext"></asp:TextBox>
                <asp:TextBox ID="txtReferer" runat="server" Visible="False" CssClass="inputtext"></asp:TextBox>
                <input type="hidden" id="hidTestConnection" runat="server" />
                <input type="hidden" id="hidSourceID" runat="server" />
                <input type="hidden" id="hidscrollValue" runat="server" />
            </div>

            <div class="lineCss" style="width:94%;margin-left:20px;border-bottom-width: 0px;"></div>
            
            <div id="FooterDiv" style="width:100%;">
                <table style="width: 100%; border-width: 0;border-spacing:0px;">
                    <tr>
                        <td style="width:100%;text-align:right;padding-right:16px;padding-top:10px;">
                            <button type="button" name="btnClose" class="inputsecondarybutton" onclick="javascript:CloseWindow();"><%=skrm.GlobalResourceSet.GetString("ec_BAMReports_BtnExportClose")%></button>
                            <input type="submit" style="margin-left:10px;" name="btnTestConnection"
                                class="inputbutton" id="btnTestConnection" runat="server"  onserverclick="btnTestConnection_ServerClick"
                                onclick="javascript: return ValidateFormData(this);" disabled="disabled"/>
                            &nbsp;
                            
                            <input type="submit" class="inputbutton"  name="Submit2" id="btnSave"
                                onclick="javascript: return ValidateFormData(this);" runat="server" onserverclick="btnSave_ServerClick" />

                            
                        </td>
                    </tr>
                </table>
            </div>
        </asp:Panel>

        <telerik:RadWindowManager ID="SingletonCreateDataSource"  Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false"
         runat="server"  Behavior="Close, Minimize, Maximize, Move"  RenderMode="Classic" VisibleStatusbar="false" > 
        <Windows>
        <telerik:RadWindow  ID="ConnnectionProviderWindow"  Height="390px" Width="555px"   runat="server" Left=""  Top=""  >
        </telerik:RadWindow>
        </Windows>
       </telerik:RadWindowManager>  
        </form>
    </div>
</body>
</html>

