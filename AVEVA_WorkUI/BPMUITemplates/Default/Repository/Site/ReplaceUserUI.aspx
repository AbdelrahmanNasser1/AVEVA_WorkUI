<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.ReplaceUser.BPMUITemplates_Default_Repository_Site_ReplaceUserUI" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<%@ Register TagPrefix="cc2" Namespace="Workflow.NET.Ajax" Assembly="Workflow.NET.NET2" %>

<!DOCTYPE HTML>
<html>
<head id="Head1" runat="server">
    <title>
        <%=GetLangSpecText("sk_replaceuser_title")%>
    </title>
    <style type="text/css">
        html,body{height:100%;}
    </style>
</head>
 <script type="text/javascript" language="javascript">

     function SetFocus()
     {
         try
         {
             document.body.focus();
         }
         catch(e)
         {

         }
     }

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
                    var oArea = document.getElementById(clientid);
                    var ids;
                    var names = '';
                    var useridstring = '';

                    if (returnValue.lastIndexOf("^") != -1)
                    {
                        var usernamestring = returnValue.substring(0, returnValue.lastIndexOf("^"));
                        useridstring = returnValue.substring(returnValue.lastIndexOf("^") + 1);
                        names = usernamestring;
                    }

                    oArea.value = names; //.substring(0, names.lastIndexOf(","));
                    var oArea1 = document.getElementById(hiddenVariableValue);
                    oArea1.value = useridstring;
                    if (hiddenVariableValue == 'hdnUserName' || hiddenVariableValue == 'hdnSubstituteUser')
                    {
                        if (document.getElementById('replaceUserSelectAllModules') != null && document.getElementById('replaceUserSelectAllModules') != 'undefined')
                        {
                            document.getElementById('replaceUserSelectAllModules').style.display = "none";
                        }
                    }

                    if (hiddenVariableValue == 'hdnUserName' && oArea1 != null && oArea1 != 'undefined' && oArea1.value != "")
                    {
                        var loggedInUser = "<%=loggedInUserdId%>";
                        if (loggedInUser.toLowerCase() == oArea1.value.toString().toLowerCase())
                        {
                            se.ui.messageDialog.showAlert("<%=GetLangSpecText("sk_replaceuser_title") %>", "<%=loggedInUserIsSelected%>");
                        }
                    }
                    if (hiddenVariableValue == 'hdnRepositorySecurityMapping')
                    {
                        var ajaxInput = "";
                        //if the user has selected the empty value then check for that
                        if (oArea1.value != null && oArea1 != 'undefined' && oArea1.value != "")
                            ajaxInput = oArea1.value;
                        else
                        {
                            if (document.getElementById("hdnSubstituteUser") != null && document.getElementById("hdnSubstituteUser") != 'undefined' && document.getElementById("hdnSubstituteUser").value != "")
                                ajaxInput = document.getElementById("hdnSubstituteUser").value;
                        }
                        ajaxInput += "@!#$" + document.getElementById('hdnUserName').value;
                        CallServerSideMethod(null, ajaxInput, "UpdateSecurityGroupName", OnSuccessUpdateLabelInnerHtml, 'table', null);
                    }
                }

                sender.remove_beforeClose(onClientBeforeCloseUserLookup);
            }
        }
        function OnSuccessUpdateLabelInnerHtml(context, result, response) {
            var repositorySecurityMappingInfo = document.getElementById('spRepositorySecurityMappingInfo');
            var imgWarning = document.getElementById('imgWarning');
            if (result.length > 0) {
                if (result[0] != "Error") {
                    repositorySecurityMappingInfo.innerHTML = result[0];
                    if (result[0] != '' && result[0] != null) {
                        repositorySecurityMappingInfo.style.display = "";
                        imgWarning.style.display = "";
                    }
                    else {
                        repositorySecurityMappingInfo.style.display = "none";
                        imgWarning.style.display = "none";
                    }

                }
                else {
                    repositorySecurityMappingInfo.style.display = "none";
                    imgWarning.style.display = "none";
                }
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

        function openReport(repositoryName, reportType) {
            var hiddenSubstituteUser;
            if (document.getElementById('hdnChangeSecurityRights') != null && document.getElementById('hdnChangeSecurityRights') != 'undefined' && document.getElementById('hdnChangeSecurityRights').value != "")
                hiddenSubstituteUser = "hdnChangeSecurityRights";
            else
                hiddenSubstituteUser = "hdnSubstituteUser";
            var oWindow = radopen("ReplaceUserSecurityRightsReport.aspx?repositoryName=" + repositoryName + "&userName=" +
                encodeURIComponent(document.getElementById("hdnUserName").value) + "&substituteUserName=" +
                encodeURIComponent(document.getElementById(hiddenSubstituteUser).value) + "&reporttype=" +
                reportType + "&overridelock=" + document.getElementById("hdnchkSelected").checked, null);
            oWindow.set_modal(true);
            oWindow.set_title('Security Rights Report');
            oWindow.setSize(800, 500);
            oWindow.center();
        }


        function confirmationAlert(hiddenVariableValue,buttonId) {
            var confirmation;
            if (checkBothUsersAreSameOrNot(hiddenVariableValue)) {

                if (document.getElementById(hiddenVariableValue) != null && document.getElementById(hiddenVariableValue) != 'undefined' && hiddenVariableValue == "hdnForwardWorkitems")
                    confirmation = document.getElementById("hdnAlertConfirmationForForwardWk");
                else
                    confirmation = document.getElementById("hdnAlertConfirmation");

                if (document.getElementById('hdnUserName') != null && document.getElementById('hdnUserName') != 'undefined' && document.getElementById('hdnUserName').value != "") {
                    if (("<%=loggedInUserdId%>").toLowerCase() == document.getElementById('hdnUserName').value.toString().toLowerCase()) {
                        se.ui.messageDialog.showConfirmation("<%=GetLangSpecText("sk_replaceuser_title") %>","<%=replaceLoggedInUserConfirmMsg%>",function(userReponse){
                            if(userReponse){
                                document.getElementById(buttonId).click();
                            }
                        });
                    }else{
                        se.ui.messageDialog.showConfirmation("<%=GetLangSpecText("sk_replaceuser_title") %>",confirmation.value,function(canProceed){
                            if(canProceed){
                                document.getElementById(buttonId).click();
                            }
                        });
                    }
                }
                
            }
            else
                return false;
        }

        function checkBothUsersAreSameOrNot(hiddenVariableValue) {
            var userToBeReplaced = document.getElementById('hdnUserName').value;
            var swappedWithUser = document.getElementById(hiddenVariableValue).value;

            //if the user made the userlookup value as empty, then clicked on replace, then set the value with the substitute user value
            if (hiddenVariableValue != 'hdnSubstituteUser' && swappedWithUser == "") {
                swappedWithUser = document.getElementById("hdnSubstituteUser").value;
                //document.getElementById(hiddenVariableValue).value = swappedWithUser;
            }

            //if select all checkbox  in replace owner is checked and the user clicked on populate again then un check the checkbox
            if (hiddenVariableValue == 'hdnSubstituteUser' && document.getElementById('chkChangeOwnerSelectAll') != null && document.getElementById('chkChangeOwnerSelectAll') != 'undefined') {
                document.getElementById('chkChangeOwnerSelectAll').checked = false;
                if (document.getElementById('chkLockOverride') != null && document.getElementById('chkLockOverride') != 'undefined') {
                    document.getElementById('chkLockOverride').checked = false;
                }
                if (document.getElementById('chkSecurityLock') != null && document.getElementById('chkSecurityLock') != 'undefined') {
                    document.getElementById('chkSecurityLock').checked = false;
                }
                if (document.getElementById('chkLockOverrideInBAM') != null && document.getElementById('chkLockOverrideInBAM') != 'undefined') {
                    document.getElementById('chkLockOverrideInBAM').checked = false;
                }
            }
            if (userToBeReplaced != "" && swappedWithUser != "")//user used user lookup and both hidden variable has values
            {
                if (userToBeReplaced == swappedWithUser) {
                    se.ui.messageDialog.showError("<%=GetLangSpecText("sk_replaceuser_title") %>",document.getElementById("hdnBothUsersAreSame").value);
                    return false;
                }
                else
                    return true;
            } //For other case swappedwith user would not be null or empty as in the above code we are initializing it
            else if (userToBeReplaced == "" && swappedWithUser != "" && hiddenVariableValue == 'hdnSubstituteUser') {
                se.ui.messageDialog.showError("<%=GetLangSpecText("sk_replaceuser_title") %>",document.getElementById("hdnProvideUserToBeReplaced").value);
                return false;
            }
            else if (userToBeReplaced != "" && swappedWithUser == "" && hiddenVariableValue == 'hdnSubstituteUser') {
                se.ui.messageDialog.showError("<%=GetLangSpecText("sk_replaceuser_title") %>",document.getElementById("hdnProvideAlternateUser").value);
                return false;
            }
            else if (userToBeReplaced == "" && swappedWithUser == "" && hiddenVariableValue == 'hdnSubstituteUser') {
                se.ui.messageDialog.showError("<%=GetLangSpecText("sk_replaceuser_title") %>",document.getElementById("hdnProvideBothUsers").value);
                return false;
            }
            else
                return true;

        }

        //if user has not used user lookup and would like to enter manually then the format should be providername::username
        function checkTextboxFormat(userToBeReplaced, swappedWithUser) {
            if (userToBeReplaced == "")//hidden varaible value is null- i.e user has entered manually
            {
                if (document.getElementById("txtUserName").value == "") {
                    return false;
                }
                else if (document.getElementById("txtUserName").value.indexOf("::") == -1)//correct format or not
                {
                    se.ui.messageDialog.showError("<%=GetLangSpecText("sk_replaceuser_title") %>",document.getElementById("hdnUserInputFormat").value);
                    return false;
                }
                else if (document.getElementById("txtUserName").value == document.getElementById("hdnSubstituteUser").value) {
                    se.ui.messageDialog.showError("<%=GetLangSpecText("sk_replaceuser_title") %>",document.getElementById("hdnBothUsersAreSame").value);
                    return false;
                }
                else
                    return true;
            }
            return true;
        }

        function updateHiddenVariable(textbox) {
            document.getElementById("hdnUserName").value = document.getElementById(textbox).value;
            if (document.getElementById('replaceUserSelectAllModules') != null && document.getElementById('replaceUserSelectAllModules') != 'undefined') {
                document.getElementById('replaceUserSelectAllModules').style.display = "none";
            }
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

        function checkSelected(securityRightsLockCheckbox) {            
            if (securityRightsLockCheckbox.checked)
                document.getElementById("hdnchkSelected").checked = true;
            else
                document.getElementById("hdnchkSelected").checked = false;
        }    
 </script> 
 <body id="Body" scroll="auto" height="100%">
     <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
     <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
     <link href="<%=cssPath%>/Global.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="<%=bellyBarCss %>CommonUXControls/StyleSheet/se.ui.min.css" />
    <link rel="stylesheet" type="text/css" href="<%=bellyBarCss%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
    <link rel="stylesheet" type="text/css" href="<%=bellyBarCss%>TelerikAjax/StyleSheet/AWTWindow/Window.css">
    <link rel="stylesheet" type="text/css" href="<%=bellyBarCss%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css">
    <link rel="stylesheet" type="text/css" href="<%=bellyBarCss%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css">
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

    <script language="javascript" type="text/javascript">
        
    function selectAll(checkbox) {

        var radComboBox = $find("<%= RadComboBoxOwnerList.ClientID %>");
        var items = radComboBox.get_items();
        var itemCount = items.get_count()
        for (var counter = 0; counter < itemCount; counter++)
        {
            var item = items.getItem(counter);
            if (checkbox.checked) {
                item.set_checked(true);
            }
            else {
                item.set_checked(false);
            }
        }       
    }
     
     function stopPropagation(e) {
            e.cancelBubble = true;
            if (e.stopPropagation) {
                e.stopPropagation();
            }
    }
        
        
        function onCheckBoxClick(chk,event) {
                        
            stopPropagation(event);
            
            var radComboBox = <%= RadComboBoxOwnerList.ClientID %>;

            //holds the text of all checked items
            var text = "";
            //holds the values of all checked items
            var values = "";
            
            //enumerate all items
            for (var i = 0; i < radComboBox.Items.length; i++) {
                var item = radComboBox.Items[i]; 
                var element= document.getElementById(item.ClientID); 
                if(element.children[0].children[0].checked)
                {
                    text += item.Text + ",";
                    values += item.Value+ ",";
                }
            }
            setCheckBoxText(text,values);            
        }
    
    //this method removes the ending comma from a string
            function removeLastComma(str)
            {
                return str.replace(/,$/,"");
            }
    function onLoad(sender) {        
             sender.get_inputDomElement().readOnly = "readonly";
         }
    </script>

    <form id="form1" runat="server" style="height:100%;">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        <div class="replaceUserDiv">
        <table style="width: 100%; margin: auto; border-width: 0; border-spacing: 0px">
            <tr class="ListHeaderCss">
                <td rowspan="2" style="vertical-align: middle; width: 40px; text-align: center;">
                    <img src="<%=ThemePath%>Repository/ListControl/images/icon-replace-user.png" />
                </td>
                <td class="MainHeading" id="spPageTile" runat="server" style="text-align: left;"><%=GetLangSpecText("sk_replaceuser_title")%></td>
            </tr>
            <tr>
                <td class="description" style="padding-bottom: 10px;">
                    <%= GetLangSpecText("sk_replaceuser_desc")%>
                    <br />

                </td>
            </tr>
        </table>

        <table id="replaceUserTable" runat="server" style="width:95%;border-spacing:0px;border-collapse:collapse;margin:0px auto;">      
        
        <tr>
            <td style="width:100%">
                <table id="errorMsgTable"  style="display:none;width:94%;margin:0px auto;" runat="server">
                    <tr>
                        <td colspan="4" class="lefttdbg" style="text-align:center;">
                            <asp:Label ID="lblNotAdministratorErrorMsg" CssClass="errormsg" runat="server" Text="">
                            </asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="4" style="vertical-align:top;width:100%;">
                <table runat="server" style="width:99%;margin:0px auto;border-spacing:1px;border-collapse:separate;" class="tablebg" Id="replaceUserInputTable">
                    <tr>
                        <td class="lefttdbg" style="width:50%;vertical-align:middle;padding:7px;">
                            <span class="subtitle">
                                <%=GetLangSpecText("sk_replaceuser_usertobereplaced")%>
                                <img id="imgMandatoryUserTobeReplacedName" runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/images/mandatoryicon.png%>"
                                    hspace="2" align="top" visible="true" />
                                <asp:RequiredFieldValidator Display="Dynamic" ID="RequiredFieldValidatorForUserToBeReplaced"
                                    runat="server" ControlToValidate="txtUserName">
                                                <img  alt=" <%=GetLangSpecText("sk_replaceuser_usertobereplaced_ErrorIcon")%>" 
                                                id="imageUserToBeReplaced"  src="../../Skeltaforms/images/erroricon.png" />
                                </asp:RequiredFieldValidator>
                            </span>
                            <br />
                            <span class="description">
                                <%= GetLangSpecText("sk_replaceuser_usertobereplaced_desc")%>
                            </span>
                        </td>
                        <td class="righttdbg" style="width:50%;padding:7px;">
                            <asp:TextBox ID="txtUserName" CssClass="inputtext" runat="server" Width="200px"></asp:TextBox>
                            <input id="btnUserLookup" class="userlookup" title="<%=GetLangSpecText("sk_replaceuser_userlookup_title")%>"
                                onclick="selectUsers('<%=txtUserName.ClientID%>', '<%=hdnUserName.ClientID%>');"
                                type="button" value=".." name="SiteExplorer" style="padding-top:6px;" />
                            <asp:HiddenField ID="hdnUserName" Value="" runat="server" />
                            &nbsp; &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td class="lefttdbg" style="width:50%;vertical-align:middle;padding:7px;" colspan="1">
                            <span class="subtitle">
                                <%=GetLangSpecText("sk_replaceuser_alternateuser")%>
                                <img id="img2" runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/images/mandatoryicon.png%>"
                                    hspace="2" align="top" visible="true" />
                                <asp:RequiredFieldValidator Display="Dynamic" ID="RequiredFieldValidator2" runat="server"
                                    ControlToValidate="txtSubstituteUser">
                                                <img  alt=" <%=GetLangSpecText("sk_replaceuser_alternateuser_ErrorIcon")%>" id="img3"  src="../../Skeltaforms/images/erroricon.png" />
                                </asp:RequiredFieldValidator>
                                <br />
                            </span><span class="description">
                                <%= GetLangSpecText("sk_replaceuser_alternateuser_desc")%>
                            </span>
                            <br />
                            <%--<img id="Img5" runat="server" src="<%$ ReplaceTemplateExpn:/Common/Images/icon-note.png%>"
                                align="absmiddle">&nbsp;<span class="note" id="Span7" runat="server">
                                    <%= GetLangSpecText("sk_replaceuser_alternateuser_note")%>
                                </span>--%>
                            <br />
                        </td>
                        <td class="righttdbg" style="width:50%;padding:7px;" colspan="3">
                            <asp:TextBox ID="txtSubstituteUser" CssClass="inputtext" runat="server" onclick="this.blur()"
                                oncopy="return false" onpaste="return false" oncut="return false" Width="200px"></asp:TextBox>
                            <input id="Button1" class="userlookup" title="<%=GetLangSpecText("ec_userlookup_title")%>"
                                onclick="selectUsers('<%=txtSubstituteUser.ClientID%>','<%=hdnSubstituteUser.ClientID%>');"
                                type="button" value=".." name="SiteExplorer" style="padding-top:6px;" />
                            <asp:HiddenField ID="hdnSubstituteUser" Value="" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td class="lefttdbg" style="width: 50%;vertical-align:middle;padding:7px;" colspan="1">
                            <span class="subtitle">
                                <%=GetLangSpecText("sk_replaceuser_btnpopulate_title")%>
                            </span>
                            <br />
                            <span class="description">
                                <%=GetLangSpecText("sk_replaceuser_btnpopulate_desc")%>
                            </span>
                            <br />
                            <img id="Img5" runat="server" src="<%$ ReplaceTemplateExpn:/Common/Images/icon-note.png%>"
                                align="absmiddle">&nbsp;<span class="note" id="Span7" runat="server">
                                    <%= GetLangSpecText("sk_replaceuser_alternateuser_note")%>
                                </span>
                        </td>
                        <td colspan="3" class="righttdbg" style="padding:10px;text-align:right">
                            <asp:Button ID="btnPopulate" runat="server" CssClass="inputbutton"  />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>  
      </div>  
    <asp:Panel Width="100%" runat="server" ID="Panel1">
        <table id="replaceUserSelectAllModules" runat="server" visible="false" style="width:96%;margin:0px auto;" border="0">
            <tr>
                <td style="height:15px;width:40px;padding:7px;" class="lefttdbg">                    
                    <img src="<%=ThemePath%>SkeltaForms/images/new-form-icon.png" />                    
                </td>
                <td style="vertical-align:middle;width:99%">
                    <span class="pagetitle" style="vertical-align:middle;" id="Span1" runat="server">
                        <%=GetLangSpecText("sk_replaceuser_selecttheartifacts_title")%>
                    </span>

                </td>
            </tr>          
       

            <tr>
                <td colspan="4" style="vertical-align:top;padding-left:15px;padding-top:7px;height:25px;" class="description">
                                       
                    <%= GetLangSpecText("sk_replaceuser_selectthemodules_title_desc")%>                    
                     
                    <br />
                    <br />
                </td>
            </tr>
            <tr>
                <td colspan="4" style="width:100%;vertical-align:top;">
                    <table style="width:98%;margin:0px auto;border-spacing:1px;border-collapse:separate;" class="tablebg">
                        <tr>
                            <td class="tableheaderbg" colspan="1" style="width:50%;padding:7px;">
                                <span id="Span20" class="subtitle" runat="server">
                                    <%= GetLangSpecText("sk_replaceuser_artifactstable_heading_artifacts")%></span>
                            </td>
                            <td class="tableheaderbg" align="center" colspan="2" style="width:30%;padding:7px;">
                                <span id="Span21" class="subtitle" runat="server">
                                    <%= GetLangSpecText("sk_replaceuser_artifactstable_heading_overrideuser")%></span>
                            </td>
                            <td class="tableheaderbg" align="center" colspan="1" style="width:20%;padding:7px;">
                                <span id="Span22" class="subtitle" runat="server">
                                    <%= GetLangSpecText("sk_replaceuser_artifactstable_heading_Action")%></span>
                            </td>
                        </tr>
                        <tr>                        
                            <td class="lefttdbg" colspan="4" style="height:1px;margin:0;border:none;padding:7px;width:100%;">
                            </td>
                        </tr>
                        <tr>
                            <td class="pagetitle" colspan="4" style="padding:7px;">
                                <span id="Span2" class="subtitle" runat="server">
                                    <%= GetLangSpecText("sk_replaceuser_listandlistitem_changes_Heading")%>
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td class="lefttdbg" colspan="1" style="width:50%;padding:7px;vertical-align:top;text-align:left;">
                                <span id="Span4" class="subtitle" runat="server">
                                    <%= GetLangSpecText("sk_replaceuser_changeowner_title")%>
                                </span>
                                <br />
                                <span class="description" id="spChangeOwnerAndSecurityRightsDesc" runat="server">
                                    <%= GetLangSpecText("sk_replaceuser_changeowner_desc")%></span>
                                    <br />
                                     <span class="description" id="Span6" runat="server">
                                    <%= GetLangSpecText("sk_replaceuser_changeowner_locknote")%>
                                </span>
                                <%--<img id="Img1" runat="server" src="<%$ ReplaceTemplateExpn:/Common/Images/icon-note.png%>"
                                align="absmiddle">&nbsp;--%>
                                <br />
                                <br />
                                <span class="note" id="spChangeOwnerNote" runat="server">
                                    <%= GetLangSpecText("sk_replaceuser_changeowner_note")%>
                                </span>
                                <br />
                                
                            </td>
                            <td style="width:30%;text-align:left;padding:7px;" class="lefttdbg" colspan="2">
                                <asp:Panel ID="chkListPanel" runat="server" Visible="true">
                                    

                                    <telerik:RadComboBox ID="RadComboBoxOwnerList" runat="server" Skin="AWTCombobox" OnClientLoad="onLoad" Width="200px" Height="200" 
                                        HighlightTemplatedItems="true" RenderMode="Classic" EnableEmbeddedSkins="false" CheckBoxes="true" CheckedItemsTexts="DisplayAllInInput" >                                      
                                    </telerik:RadComboBox>

                                    <span style="width: 35px" runat="server"></span>
                                    <asp:CheckBox ID="chkChangeOwnerSelectAll" Text="" CssClass="inputcheckbox" runat="server"
                                        onclick="selectAll(this);" style="vertical-align:bottom;"/>
                                    <span id="spSelectAll" class="description" runat="server" style="vertical-align:middle"></span>
                                </asp:Panel>
                                <span id="spChangeOwnerNotApplicable" align="center" class="errormsg" visible="false"
                                    runat="server">Not applicable</span>
                                <br />
                                <asp:TextBox ID="txtChangeOwner" CssClass="inputtext" runat="server" onclick="this.blur()"
                                    Width="200px" oncopy="return false" onpaste="return false" oncut="return false"></asp:TextBox>
                                <input id="btnChangeOwner" class="userlookup" runat="server" type="button" value=".."
                                    name="SiteExplorer" style="padding-top:6px;" />
                                <asp:HiddenField ID="hdnChangeOwner" Value="" runat="server" />
                                &nbsp;
                                <asp:CheckBox ID="chkLockOverride" Text="" CssClass="inputcheckbox"   
                                    runat="server" style="vertical-align:middle"/>
                                <span class="description" id="spChangeOwnerLock" runat="server" style="vertical-align:middle"></span>
                            </td>
                            <td style="width:20%;text-align:center;padding:7px;" class="lefttdbg" colspan="1">
                                <asp:Button ID="btnChangeOwnerReplace" runat="server" Text="Replace" CssClass="inputbutton"
                                    />
                                <asp:Button ID="hiddenButtonChangeOwnerReplace" runat="server" style="display:none;"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="righttdbg" colspan="1" style="width:50%;padding:7px;text-align:left;vertical-align:top;">
                                <span id="Span5" class="subtitle" runat="server">
                                    <%= GetLangSpecText("sk_replaceuser_securityrights_title")%>
                                </span>
                                <br />
                                <span class="description" id="Span3" runat="server">
                                    <%= GetLangSpecText("sk_replaceuser_securityrights_desc")%></span>
                                    <br />
                                     <span class="description" id="Span8" runat="server">
                                    <%= GetLangSpecText("sk_replaceuser_securityright_locknote")%>
                                    </span>
                                    
                                <%--<br />
                            <br />
                            <img id="Img2" runat="server" src="<%$ ReplaceTemplateExpn:/Common/Images/icon-note.png%>"
                                align="absmiddle">&nbsp;<span class="note" id="Span6" runat="server">
                                    <%= GetLangSpecText("sk_replaceuser_changesecurityrights_note")%>
                                </span>--%>
                                <br />
                            </td>
                            <td  class="righttdbg" colspan="2" style="width:30%;text-align:left;padding:7px;">
                                
                                <a href="javascript:openReport();" id="linkReport" runat="server" class="textlinkbluenormal">
                                    <u>
                                        <%=GetLangSpecText("sk_replaceuser_clickhere") %>
                                    </u></a><span id="spSingleUserReportText" class="description" runat="server">
                                </span>
                                <br />
                                <br />
                                <span id="spSecurityRightsNotapplicable" align="center" class="errormsg" visible="false"
                                    runat="server">Not applicable</span> <a href="javascript:openReport();" id="linkBothUsersReport"
                                        runat="server" class="textlinkbluenormal"><u>
                                            <%=GetLangSpecText("sk_replaceuser_clickhere") %>
                                        </u></a><span id="spBothUserReportText" class="description" runat="server">
                                </span>
                                <br />
                                <br />
                                <asp:TextBox ID="txtChangeSecurityRights" CssClass="inputtext" runat="server" onclick="this.blur()"
                                    Width="200px" oncopy="return false" onpaste="return false" oncut="return false"></asp:TextBox>
                                <input id="btnChangeSecurityRights" class="userlookup" runat="server" type="button"
                                    value=".." name="SiteExplorer" style="padding-top:6px;" />
                                <asp:HiddenField ID="hdnChangeSecurityRights" Value="" runat="server" />
                                &nbsp;
                                <asp:CheckBox ID="chkSecurityLock" Text="" CssClass="inputcheckbox" style="vertical-align:middle"
                                    runat="server" />
                                 <span id="spChangeSecurityRightsLock" class="description" runat="server" style="vertical-align:middle"></span>
                                <br />
                            </td>
                            <td style="width:20%;text-align:center;padding:7px;" class="righttdbg" colspan="1">
                                <%--<asp:Button ID="btnSecurityRightsReplace" runat="server" Text="Replace" CssClass="inputbutton"
                                    Width="50%" />--%>
                            </td>
                        </tr>
                        <tr>
                            <td class="lefttdbg"  colspan="4" style="height: 3px;margin: 0; border: none; padding:7px;width:100%">
                            </td>
                        </tr>
                        <tr>
                            <td class="pagetitle" colspan="4">
                                <span id="Span11" class="subtitle" runat="server">
                                    <%= GetLangSpecText("sk_replaceuser_othermodulechanges_heading")%></span>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align:left;vertical-align:top;width:50%;padding:7px;" class="lefttdbg" colspan="1">
                                <span id="Span12" class="subtitle" runat="server">
                                    <%= GetLangSpecText("sk_replaceuser_changequeue_title")%>
                                </span>
                                <br />
                                <span class="description" id="Span13" runat="server">
                                    <%= GetLangSpecText("sk_replaceuser_changequeue_desc")%></span>
                                <br />
                                <%--<img id="Img3" runat="server" src="<%$ ReplaceTemplateExpn:/Common/Images/icon-note.png%>"
                                align="absmiddle">&nbsp;<span class="note" id="Span23" runat="server">
                                    <%= GetLangSpecText("sk_replaceuser_changequeue_note")%>
                                </span>
                            <br />    --%>
                            </td>
                            <td style="width:30%;text-align:left;padding:7px;" class="lefttdbg" colspan="2">
                                <%-- <asp:CheckBox ID="chkChangeQueue" Text="" CssClass="inputcheckbox" runat="server" />--%>
                                <asp:TextBox ID="txtChangeQueue" CssClass="inputtext" runat="server" onclick="this.blur()"
                                    Width="200px" oncopy="return false" onpaste="return false" oncut="return false"></asp:TextBox>
                                <input id="btnChangeQueue" class="userlookup" runat="server" type="button" value=".."
                                    name="SiteExplorer" style="padding-top:6px;" />
                                <asp:HiddenField ID="hdnChangeQueue" Value="" runat="server" />
                                <span id="spChangeQueueNotApplicable" align="center" class="errormsg" visible="false"
                                    runat="server">Not applicable</span>
                                <br />
                            </td>
                            <td style="width:20%;text-align:center;padding:7px;" class="lefttdbg" colspan="1">
                                <asp:Button ID="btnChangeQueueReplace" runat="server" Text="Replace" CssClass="inputbutton"
                                     />
                                <asp:Button ID="hiddenButtonChangeQueueReplace" runat="server" style="display:none;"/>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align:left;width:50%;vertical-align:top;padding:7px;" class="righttdbg" colspan="1">
                                <span id="spReplaceBamAlterUserTitle" class="subtitle" runat="server">
                                    <%= GetLangSpecText("sk_replaceuser_changebam_title")%>
                                </span>
                                <br />
                                <span class="description" id="spReplaceBamAlterUserDesc" runat="server">
                                    <%= GetLangSpecText("sk_replaceuser_changebam_desc")%></span>
                                    <br />
                                    <br />
                                <span class="description" id="Span9" runat="server">
                                    <%= GetLangSpecText("sk_replaceuser_changebam_locknote")%>
                                    </span>
                                <br />
                            </td>
                            <td style="width:30%;padding:7px;" align="left" class="righttdbg" colspan="2">
                                <%--<asp:CheckBox ID="chkChangeBAM" Text="" CssClass="inputcheckbox" runat="server" />--%>
                                <asp:TextBox ID="txtChangeBAM" CssClass="inputtext" runat="server" onclick="this.blur()"
                                    Width="200px" oncopy="return false" onpaste="return false" oncut="return false"></asp:TextBox>
                                <input id="btnChangeBAM" class="userlookup" runat="server" type="button" value=".."
                                    name="SiteExplorer" style="padding-top:6px;" />
                                <asp:HiddenField ID="hdnChangeBam" Value="" runat="server" />
                                <span id="spChangeBAMNotApplicable" align="center" class="errormsg" visible="false"
                                    runat="server">Not applicable</span> &nbsp;
                                <%-- <span class="description" id="Span22" runat="server">
                                <%= GetLangSpecText("sk_replaceuser_changealternateactor_hint")%></span>--%>
                                <asp:CheckBox ID="chkLockOverrideInBAM" Text="" CssClass="inputcheckbox" style="vertical-align:middle"
                                    runat="server" />
                                <span id="spChangeBAMLock" class="description" style="vertical-align:middle" runat="server"></span>
                                <br />
                            </td>
                            <td style="width:20%;text-align:center;padding:7px;" class="righttdbg" colspan="1">
                                <asp:Button ID="btnChangeBAMReplace" runat="server" Text="Replace" CssClass="inputbutton"
                                     />
                                <asp:Button ID="hiddenButtonChangeBAMReplace" runat="server" style="display:none;" />
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align:left;width:50%;vertical-align:top;padding:7px;" class="lefttdbg" colspan="1">
                                <span id="Span16" class="subtitle" runat="server">
                                    <%= GetLangSpecText("sk_replaceuser_forwardworkitems_title")%>
                                </span>
                                <br />
                                <span class="description" id="Span17" runat="server">
                                    <%= GetLangSpecText("sk_replaceuser_forwardworkitems_desc")%></span>
                                <br />
                            </td>
                            <td style="width:30%;text-align:left;padding:7px;" class="lefttdbg" colspan="2">
                                <%--<asp:CheckBox ID="chkForwardWorkitems" Text="" CssClass="inputcheckbox" runat="server" />--%>
                                <asp:TextBox ID="txtForwardWorkitems" CssClass="inputtext" runat="server" onclick="this.blur()"
                                    Width="200px" oncopy="return false" onpaste="return false" oncut="return false"></asp:TextBox>
                                <input id="btnForwardWorkitem" class="userlookup" runat="server" onclick="selectUsers('<%=txtUserName.ClientID%>');"
                                    type="button" value=".." name="SiteExplorer" style="padding-top:6px;" />
                                <asp:HiddenField ID="hdnForwardWorkitems" Value="" runat="server" />
                                <span id="spForwardWorkitemsNotApplicable" align="center" class="errormsg" visible="false"
                                    runat="server">Not applicable</span> &nbsp;
                                <%-- <span class="description" id="Span21" runat="server">
                                <%= GetLangSpecText("sk_replaceuser_changealternateactor_hint")%></span>--%>
                                <br />
                            </td>
                            <td style="width:20%;text-align:center;padding:7px;" class="lefttdbg" colspan="1">
                                <asp:Button ID="btnForwardWorkitemsReplace" runat="server" Text="Forward Workitems"
                                    CssClass="inputbutton"  />
                                <asp:Button ID="hiddenButtonForwardWorkItemsReplace" runat="server" style="display:none;"  />
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align:left;vertical-align:top;padding:7px;width:50%;" class="righttdbg" colspan="1">
                                <span id="Span18" class="subtitle" runat="server">
                                    <%= GetLangSpecText("sk_replaceuser_changealternateactor_title")%>
                                </span>
                                <br />
                                <span class="description" id="Span19" runat="server">
                                    <%= GetLangSpecText("sk_replaceuser_changealternateactor_desc")%></span>
                                <br />
                            </td>
                            <td style="width:30%;text-align:left;padding:7px;" class="righttdbg" colspan="2">
                                <%--<asp:CheckBox ID="chkAlternateActor" Text="" CssClass="inputcheckbox" runat="server" />--%>
                                <asp:TextBox ID="txtAlternateActor" CssClass="inputtext" runat="server" onclick="this.blur()"
                                    Width="200px" oncopy="return false" onpaste="return false" oncut="return false"></asp:TextBox>
                                <input id="btnAlternateActor" class="userlookup" runat="server" type="button" value=".."
                                    name="SiteExplorer" style="padding-top:6px;" />
                                <asp:HiddenField ID="hdnAlternateActor" Value="" runat="server" />
                                <span id="spAlternateactorNotAvaialble" align="center" class="errormsg" visible="false"
                                    runat="server">Not applicable</span> &nbsp;
                               
                                <br />
                            </td>
                            <td style="width:20%;text-align:center;padding:7px;" class="righttdbg" colspan="1">
                                <asp:Button ID="btnAlternateActorReplace" runat="server" Text="Replace" CssClass="inputbutton"
                                     />
                                <asp:Button ID="hiddenButtonAlternateActorReplace" runat="server" style="display:none;" />
                            </td>
                        </tr>
                        
                        <tr>
                            <td class="lefttdbg"  colspan="4" style="height: 3px;margin: 0; border: none; padding: 7px;width:100%">
                            </td>
                        </tr>
                        <tr>
                            <td class="pagetitle" colspan="4" style="padding:7px;">
                                <span id="spRepositoryConfigurationHeading" class="subtitle" runat="server">
                                    <%= GetLangSpecText("sk_replaceuser_repositoryconfiguration_heading")%></span>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align:left;vertical-align:top;width:50%;padding:7px;"  class="lefttdbg" colspan="1" >
                                <span class="subtitle">
                                    <%= GetLangSpecText("sk_replaceuser_changesystemuser_title")%></span>
                                <br />
                                <span class="description">
                                    <%= GetLangSpecText("sk_replaceuser_changesystemuser_desc")%></span>                               
                            </td>
                            <td style="width:30%;text-align:left;padding:7px;" class="lefttdbg" colspan="2">
                                <%--<asp:CheckBox ID="chkSystemUser" Text="" CssClass="inputcheckbox" runat="server" />--%>
                                <asp:TextBox ID="txtSystemUser" CssClass="inputtext" runat="server" onclick="this.blur()"
                                    Width="200px" oncopy="return false" onpaste="return false" oncut="return false"></asp:TextBox>
                                <input id="btnSystemUser" class="userlookup" onclick="selectUsers('<%=txtSystemUser.ClientID%>','<%=hdnSystemUser.ClientID%>');"
                                    type="button" value=".." name="SiteExplorer" runat="server"  style="padding-top:6px;" />
                                <asp:HiddenField ID="hdnSystemUser" Value="" runat="server" />
                                <span id="spSystemUserNotApplicable" align="center" class="errormsg" runat="server"
                                    visible="false">Not applicable</span>
                                <br />
                            </td>
                            <td style="width:20%;text-align:center;padding:7px;" class="lefttdbg" colspan="1">
                                <asp:Button ID="btnSystemUserReplace" runat="server" Text="Replace" CssClass="inputbutton"
                                     />
                                <asp:Button ID="hiddenButtonSystemUserReplace" runat="server" style="display:none;" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width:50%;text-align:left;vertical-align:top;padding:7px;" class="righttdbg" bgcolor="#E7EDFF" colspan="1" >
                                <span id="spchangerepositoryadmin" class="subtitle" runat="server">
                                    <%= GetLangSpecText("sk_replaceuser_changerepositoryadmin_title")%>
                                </span>
                                <br />
                                <span class="description" id="spchangerepositoryadmindesc" runat="server">
                                    <%= GetLangSpecText("sk_replaceuser_changerepositoryadmin_desc")%></span>
                                <%--<img id="Img4" runat="server" src="<%$ ReplaceTemplateExpn:/Common/Images/icon-note.png%>"
                                align="absmiddle">&nbsp;<span class="note" id="Span25" runat="server">
                                    <%= GetLangSpecText("sk_replaceuser_changequeue_note")%>
                                </span>--%>
                            </td>
                            <td style="width:30%;text-align:left;padding:7px;" class="righttdbg" bgcolor="#E7EDFF" colspan="2">                                
                                <asp:TextBox ID="txtRepositoryAdmin" CssClass="inputtext" runat="server" onclick="this.blur()"
                                    Width="200px" oncopy="return false" onpaste="return false" oncut="return false"></asp:TextBox>
                                <input id="btnRepositoryAdmin" class="userlookup" runat="server" onclick="selectUsers('<%=txtRepositoryAdmin.ClientID%>','<%=hdnRepositoryAdmin.ClientID%>');"
                                    type="button" value=".." name="SiteExplorer" style="padding-top:6px;" />
                                <asp:HiddenField ID="hdnRepositoryAdmin" Value="" runat="server" />
                                <span id="spRepositoryAdminNotApplicable" align="center" class="errormsg" runat="server"
                                    visible="false">Not applicable</span>
                                <br />
                            </td>
                            <td style="width:20%;text-align:center;padding:7px;" class="righttdbg" colspan="1">
                                <asp:Button ID="btnRepositoryAdminReplace" runat="server" Text="Replace" CssClass="inputbutton"
                                     />
                                <asp:Button ID="hiddenButtonRepositoryAdminReplace" runat="server" style="display:none;"  />
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align:left;vertical-align:top;width:50%;padding:7px;" class="lefttdbg" bgcolor="#E7EDFF" colspan="1">
                                <span class="subtitle" runat="server">
                                    <%= GetLangSpecText("sk_replaceuser_repositorysecurityrights")%>
                                </span>
                                <br />
                                <span class="description" runat="server">
                                    <%= GetLangSpecText("sk_replaceuser_repositorysecurityrights_desc")%></span>
                            </td>
                            <td style="width:30%;text-align:left;padding:7px;" class="lefttdbg" bgcolor="#E7EDFF" colspan="2">
                                <asp:TextBox ID="txtRepositorySecurityMapping" CssClass="inputtext" runat="server"
                                    onclick="this.blur()" Width="200px" oncopy="return false" onpaste="return false"
                                    oncut="return false"></asp:TextBox>
                                <input id="btnRepositorySecurityMapping" class="userlookup" runat="server" onclick="selectUsers('<%=txtRepositoryAdmin.ClientID%>','<%=hdnRepositoryAdmin.ClientID%>');"
                                    type="button" value=".." name="SiteExplorer" style="padding-top:6px;" />
                                <asp:HiddenField ID="hdnRepositorySecurityMapping" Value="" runat="server" />
                               <br />
                               <span id="spRepositorySecurityNotApplicable"
                                            align="center" class="errormsg" runat="server" visible="false">Not applicable</span>
                               <br />
                                <img id="imgWarning" runat="server" src="<%$ ReplaceTemplateExpn:/Common/Images/icon-note.png%>"
                                    align="absmiddle">&nbsp;<span id="spRepositorySecurityMappingInfo" class="description"
                                        runat="server" visible="false" style="display:block"></span> 
                                <br />
                            </td>
                            <td style="width:20%;padding:7px;text-align:center;" class="lefttdbg" colspan="1">
                                <asp:Button ID="btnRepositorySecurityMappingReplace" runat="server" Text="Replace"
                                    CssClass="inputbutton"  />
                                <asp:Button ID="hiddenButtonRepositorySecurityMappingReplace" runat="server" style="display:none;"  />
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align:left;vertical-align:top;width:50%;padding:7px;" class="righttdbg" bgcolor="#E7EDFF" colspan="1" >
                                <span id="spReplaceCnfgException" class="subtitle" runat="server">
                                    <%= GetLangSpecText("sk_replaceuser_cnfgException_title")%>
                                </span>
                                <br />
                                <span class="description" id="spCnfgExceptionDesc" runat="server">
                                    <%= GetLangSpecText("sk_replaceuser_cnfgException_title_desc")%></span>
                            </td>
                            <td style="width:30%;text-align:left;padding:7px;" class="righttdbg" bgcolor="#E7EDFF" colspan="2">
                                <asp:TextBox ID="txtCnfgException" CssClass="inputtext" runat="server" onclick="this.blur()"
                                    Width="200px" oncopy="return false" onpaste="return false" oncut="return false"></asp:TextBox>
                                <input id="btnCnfgException" class="userlookup" runat="server" onclick="selectUsers('<%=txtRepositoryAdmin.ClientID%>','<%=hdnRepositoryAdmin.ClientID%>');"
                                    type="button" value=".." name="SiteExplorer" style="padding-top:6px;" />
                                <asp:HiddenField ID="hdnCnfgException" Value="" runat="server" />
                                <span id="spCnfgExceptionNotApplicable" align="center" class="errormsg" runat="server"
                                    visible="false">Not applicable</span>
                                <br />
                            </td>
                            <td style="width:20%;text-align:center;padding:7px;" class="righttdbg" colspan="1">
                                <asp:Button ID="btnConfgExceptionReplace" runat="server" Text="Replace" CssClass="inputbutton"
                                     />
                                <asp:Button ID="hiddenButtonConfigExceptionReplace" runat="server" style="display:none;"/>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <div style="display: none">
        <input type="button" id="SearchUser" value="Open Window" />
    </div>
    <asp:HiddenField ID="hdnAlertConfirmation" Value="" runat="server" />
    <input id="hdnBothUsersAreSame" runat="server" type="hidden" />
    <input id="hdnAlertConfirmationForForwardWk" runat="server" type="hidden" />
    <input id="hdnUserInputFormat" runat="server" type="hidden" />
    <input id="hdnProvideUserToBeReplaced" runat="server" type="hidden" />
    <input id="hdnProvideAlternateUser" runat="server" type="hidden" />
    <input id="hdnProvideBothUsers" runat="server" type="hidden" />
    <input id="hdnchkSelected" runat="server" type="hidden" />
   

        <telerik:RadWindowManager ID="Singleton" Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false"
         runat="server" Behaviors="Close, Move" DestroyOnClose="true" Overlay="false" RenderMode="Classic" VisibleStatusbar="false">
        </telerik:RadWindowManager>
   
    <cc2:AjaxPageControl ID="AjaxPageControl1" runat="server" Style="z-index: 104; left: 440px;
        position: absolute; top: 88px"></cc2:AjaxPageControl>
    <script type="text/javascript">
       
       function setCheckBoxText(text,values)
        {           
           var radComboBox = $find("<%= RadComboBoxOwnerList.ClientID %>");            
            //remove the last comma from the string
            text = removeLastComma(text);
            values = removeLastComma(values);

            if (text.length > 0) {
                //set the text of the combobox
                radComboBox.set_text(text);
                  applyTooltip(); 
            }
            else {
                //all checkboxes are unchecked
                //so reset the controls
                radComboBox.set_text("");
                 applyTooltip(); 
            }
        }
        
 
        function applyTooltip()  
        {  
            var combo = <%=RadComboBoxOwnerList.ClientID %>;  
            var input = document.getElementById(combo.InputID);  
            input.title= combo.GetText();  
            var img = document.getElementById(combo.ImageID);  
            img.title= combo.GetText();  
        }  
    </script>

    </form>
</body>
</html>
