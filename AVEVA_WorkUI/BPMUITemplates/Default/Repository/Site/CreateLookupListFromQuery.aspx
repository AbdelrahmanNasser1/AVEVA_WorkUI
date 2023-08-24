<%@ Page Language="C#" AutoEventWireup="true"  Inherits="Skelta.Forms.Web.CodeBehind.DynamicListLookUp" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ OutputCache Duration="60" Location="None" NoStore="true" %>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link href="../../Common/StyleSheet/Global.css" rel="stylesheet" />
    <style>
        html, body, form, #ParentDiv{
            height:100%;
            overflow:hidden;
        }
        #ContainerParentDiv
        {
            position:relative;
            height:100%;
            width:100%;
        }
        #ContainerDiv
        {
            position:absolute; 
            left:0;
            right:0;
            top:0;
            bottom:0;
            overflow:hidden
        }
        #FooterDiv,#BodyDiv,#HeaderDiv
        {
            position:absolute;
            right:0;
            left:0; 
            box-sizing:border-box;
        }
        #HeaderDiv
        {
            top:0;
            height:40px;
        }
        #FooterDiv
        {
            bottom:0;
            height:46px;
            padding-top:5px;
        }
        #BodyDiv{
            overflow:auto;
            top:40px;
            bottom:46px;
        }

        .txtinputStyle {
            font-size: 14px;
            width: 100%;
            color: rgb(51, 51, 51);
            min-height: 27px;
            z-index: 400;
            border-width: 1px;
            border-style: solid;
            border-color: rgb(204, 204, 204);
            border-image: initial;
            padding: 0px 2px;
        }
    </style>
</head>
<script type="text/javascript" >
    var objURL = new Object();

    // Use the String::replace method to iterate over each
    // name-value pair in the query string. Location.search
    // gives us the query string (if it exists).
    window.location.search.replace(
    new RegExp("([^?=&]+)(=([^&]*))?", "g"),


    // For each matched query string pair, add that
    // pair to the URL struct using the pre-equals
    // value as the key.
    function($0, $1, $2, $3) {
        objURL[$1] = $3;
    }
    );

    function OpenRadWindowOrderByQuery() {        
        var ListName = document.getElementById("<%=hdnListName.ClientID%>");
        var UserId = document.getElementById("<%=hdnUserId.ClientID%>");
        var Repository = document.getElementById("<%=hdnRepository.ClientID%>");
        var txtOrderByQuery = document.getElementById("<%=txtOrderByQuery.ClientID%>");
        var oManager = GetRadWindow().get_windowManager();
        if (ListName.value != "") {
            var query;
            if (txtOrderByQuery != typeof ('undefined') || txtOrderByQuery != null || txtOrderByQuery != "")
                query = txtOrderByQuery.value;
            var oWindow1 = radopen("DynamicOrderByBuilder.aspx?ListName=" + encodeURIComponent(ListName.value) + "&UserId=" + encodeURIComponent(UserId.value) + "&Repository=" + encodeURIComponent(Repository.value) + "&Query=" + encodeURIComponent(query), null);
            oWindow1.moveTo(150, 20);
            oWindow1.setSize(710, 400);
            oWindow1.set_modal(true);
            oWindow1.show();
            oWindow1.add_beforeClose(onClientBeforeCloseDynamicOrderByBuilder);
        }
        else {
            DisplayErrorMessage("<%= skrm.GlobalResourceSet.GetString("Lookup_select_list_to_generate_query")%>");
        }
    }

    function onClientBeforeCloseDynamicOrderByBuilder(sender, args)
    {
        var returnquery = args.get_argument();

        if (returnquery !== null && returnquery !== undefined)
        {
            var QueryText = returnquery.split("!!!");
            var DisplayText = QueryText[0];
            var ActualText = QueryText[1];

            var txtQuery = document.getElementById("<%=txtOrderByQuery.ClientID%>");
            txtQuery.value = DisplayText;

            var hdnDisplayQuery = document.getElementById("<%=hdnDisplayOrderByQuery.ClientID%>");
            hdnDisplayQuery.value = DisplayText;

            var hdnActualQuery = document.getElementById("<%=hdnActualOrderByQuery.ClientID%>");
            hdnActualQuery.value = ActualText;

            var imageele = document.getElementById('img2');
            if (ActualText != "")
            {
                imageele.style.visibility = "visible";
            }
            else
            {
                imageele.style.visibility = "hidden";
            }
        }

        sender.remove_beforeClose(onClientBeforeCloseDynamicOrderByBuilder);
    }

    function getDynamicOrderByQuery(radWindow, returnquery) {
        var QueryText = returnquery.split("!!!");
        var DisplayText = QueryText[0];
        var ActualText = QueryText[1];

        var txtQuery = document.getElementById("<%=txtOrderByQuery.ClientID%>");
        txtQuery.value = DisplayText;

        var hdnDisplayQuery = document.getElementById("<%=hdnDisplayOrderByQuery.ClientID%>");
        hdnDisplayQuery.value = DisplayText;

        var hdnActualQuery = document.getElementById("<%=hdnActualOrderByQuery.ClientID%>");
        hdnActualQuery.value = ActualText;

        var imageele = document.getElementById('img2');
        if (ActualText != "") {
            imageele.style.visibility = "visible";
        }
        else {
            imageele.style.visibility = "hidden";
        }
    }

    function OpenRadWindowDynamicQuery() {
        var ListName = document.getElementById("<%=hdnListName.ClientID%>");
        var UserId = document.getElementById("<%=hdnUserId.ClientID%>");
        var Repository = document.getElementById("<%=hdnRepository.ClientID%>");
        var txtQuery = document.getElementById("<%=txtQuery.ClientID%>");
        var oManager = GetRadWindow().get_windowManager();
        if (ListName.value != "") {
            var query;
            if (txtQuery != typeof ('undefined') || txtQuery != null || txtQuery != "")
                query = txtQuery.value;

            var oWindow1 = radopen("DynamicQueryBuilder.aspx?ListName=" + encodeURIComponent(ListName.value) + "&UserId=" + encodeURIComponent(UserId.value) + "&Repository=" + encodeURIComponent(Repository.value) + "&Query=" + encodeURIComponent(query), null);
            oWindow1.moveTo(150,20);
            oWindow1.setSize(860, 529);
            oWindow1.set_modal(true);
            oWindow1.add_beforeClose(onClientBeforeCloseDynamicQueryBuilder);
        }
        else {
           // alert('Please select a list to generate a query');
            DisplayErrorMessage("<%= skrm.GlobalResourceSet.GetString("Lookup_select_list_to_generate_query")%>");
        }
    }

    function onClientBeforeCloseDynamicQueryBuilder(sender, args)
    {
        var returnquery = args.get_argument();

        if (returnquery !== null && returnquery !== undefined)
        {
            var QueryText = returnquery.split("$$$");
            var DisplayText = QueryText[0];
            var ActualText = QueryText[1];

            var txtQuery = document.getElementById("<%=txtQuery.ClientID%>");
            var hdnDisplayQuery = document.getElementById("<%=hdnDisplayQuery.ClientID%>");
            txtQuery.value = DisplayText;
            hdnDisplayQuery.value = DisplayText;
            var hdnActualQuery = document.getElementById("<%=hdnActualQuery.ClientID%>");
            hdnActualQuery.value = ActualText;
        }

        sender.remove_beforeClose(onClientBeforeCloseDynamicQueryBuilder);
    }
   
    function closeWindow() {

        if (window.parent.location.search == '?FromArchestrA=true') //added condition for isfromArchestra
        {
            setTimeout(function () {
                closeWindowInternal();
            }, 100);
        }
        else {
            closeWindowInternal();
        }
    }

    function closeWindowInternal() {
        var oWindow = GetRadWindow();

        oWindow.close();
    }

    function disablebtn(radGetRec) {
        alert();
    }

    function ValidateEmptyText(textObj) {
       
        if (textObj != null) {
            var txtTitle = document.getElementById("<%=txtQueryName.ClientID%>");
            if (txtTitle.value.indexOf('<') >= 0 || txtTitle.value.indexOf('>') >= 0) {

                DisplayErrorMessage("<%=strLookUpTitle%>");
                txtQueryName.value = "";
             }
            if (textObj.value == "") {
                return true;
            }
            else {
                  return true;
            }         
        }
    }

    function ValidateScript() {
        var txtDescription = document.getElementById("<%=txtDescription.ClientID%>");
        if (txtDescription.value.indexOf('<') >= 0 || txtDescription.value.indexOf('>') >= 0) {
            DisplayErrorMessage("<%=strLookUpDescription%>");
            txtDescription.value = "";
            }

    }

    function ValidateEmptyListQuery(textObj) {
        if (textObj != null) {

            if (textObj.value == "") {
                document.getElementById('imgListQuery').style.visibility = "visible";
                return true;
            }
            else {
                //document.getElementById('imgerror').style.display="none";
                document.getElementById('imgListQuery').style.visibility = "hidden";
                //document.getElementById('spnerrormsg').style.display = "none";
                return true;
            }
        }
    }
</script>

<script type="text/javascript" >
    var scrollPosition = 0;    
    function GetRadWindow() {
        var oWindow = null;
        if (window.radWindow)
            oWindow = window.radWindow;
        else if (window.frameElement.radWindow)
            oWindow = window.frameElement.radWindow;
        return oWindow;
    }

    function getQuerystring(key, default_) {
        if (default_ == null) default_ = "";
        key = key.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
        var regex = new RegExp("[\\?&]" + key + "=([^&#]*)");
        var qs = regex.exec(window.location.href);
        if (qs == null)
            return default_;
        else
            return qs[1];
    }

    var isFirstLoad = true;
    function SizeToFit() {
        var oWnd = GetRadWindow();
        if (oWnd.isClosed() == false) {
            oWnd.center();
        }
        var check = window.navigator.userAgent;
        var isMozilla = false;
        if (check.indexOf("Firefox") != -1)
        {
            isMozilla = true;
            this.top.document.body.scrollTop = 0;
            var author_value = getQuerystring('userPostback');
            if (author_value == "")
            {
                if (oWnd.isClosed() == false) {
                    oWnd.setUrl(window.location.href + "&userPostback=true");
                }
            }
        }
        if (isFirstLoad) {
            if (window.parent.location.search != null && window.parent.location.search == '?FromArchestrA=true') {
                if (oWnd.isClosed() == false) {
                    oWnd.maximize();
                }
            }
            isFirstLoad = false;
        }
        var bodyDiv = document.getElementById('BodyDiv');
        bodyDiv.style.overflowY = "auto";
        bodyDiv.style.overflowX = "hidden";
        
        //bodyDiv.style.height = "575px";
        var mainBody = document.getElementById('mainBody');
        mainBody.style.overflowY = "hidden";
        mainBody.style.overflowX = "hidden";


        var imageele = document.getElementById('img2');
        var hdnActualQuery = document.getElementById("hdnActualOrderByQuery");
        if (hdnActualQuery != null && hdnActualQuery.value != "") {
            imageele.style.visibility = "visible";
        }
        else {
            imageele.style.visibility = "hidden";
        }
        if (window.parent.location.search != null && window.parent.location.search == '?FromArchestrA=true') {
            mainBody.style.overflowY = "scroll";
        }
    }

    function ClearListQueryAndOrderByFields(sender, eventArgs) {
        document.getElementById('hdnActualOrderByQuery').value = "";
        document.getElementById('hdnDisplayOrderByQuery').value = "";
        document.getElementById('hdnActualQuery').value = "";
        document.getElementById('hdnDisplayQuery').value = "";

        var combo = $find('<%= RadComboDColumns.ClientID %>');
        if(combo !=null)
        combo.clearSelection();
        
    }

    function ResizeWindow() {
        SizeToFit();
        document.getElementById('BodyDiv').scrollTop = scrollPosition;
    }

    function scroll() {
        scrollPosition = document.getElementById('BodyDiv').scrollTop;
    }

</script>

<body id='mainBody' onload="SizeToFit();" style="border: none; margin: 2px; padding:none; overflow: hidden;">
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

         function DisplayErrorMessage(message) {
            se.ui.messageDialog.showError('<%=Title%>', message);
        }

        function DisplaySuccessMessage(message) {
            se.ui.messageDialog.showAlert('<%=Title%>', message); 
        }

        function showMessageAndCloseWindow(message){
                se.ui.messageDialog.showAlert('<%=Title%>', message, function ()
                {
                    closeWindow();
                });
        }

    </script>

    <div id="ParentDiv" style="overflow: hidden">
        <form id="form1" runat="server" style="overflow: hidden">
             <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
            <%=System.Web.Helpers.AntiForgery.GetHtml()%>
             </telerik:RadScriptBlock>
            <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
             </telerik:RadScriptManager>
             <telerik:RadScriptBlock ID="RadScriptBlock2" runat="server">
            <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>Common/StyleSheet/Global.css" />
            <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>CommonUXControls/StyleSheet/se.ui.min.css"  rel="stylesheet" type="text/css" /> 
            <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css" />
            <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css" />
            <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>TelerikAjax/StyleSheet/AWTTreeView/TreeView.AWTTreeView.css" />
            <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>TelerikAjax/StyleSheet/AWTInput/Input.AWTInput.css" />
            <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css" />
            <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>TelerikAjax/StyleSheet/AWTWindow/Window.css" />
                 
             </telerik:RadScriptBlock>
            
        <telerik:RadAjaxPanel ID="radAjaxPanel" runat="server" EnableAJAX="true" ScrollBars="None" Height="100%">
            <telerik:RadCodeBlock runat="server" ID="RadCodeBlock1">
            <div id="ContainerParentDiv">                
                <div id="ContainerDiv"style="">
                    <div id="HeaderDiv">
                        <table style="width:100%;margin:auto;border-width:0;border-spacing:0px">
                            <tr>
                                <td rowspan="2" style="vertical-align: middle;width:40px;text-align:center;padding-left:20px;padding-top:15px;">
                                    <img style="vertical-align:middle" alt="" src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>Repository/ListControl/images/icons-ribbon/lookupsklist.png"/>
                                </td>
                                <td class="windowTitle" style="padding-top:15px;"><%=Title%></td>
                            </tr>
                        </table>                
                    </div>
                    <div id="BodyDiv" onscroll="scroll()" style="padding-left:55px;height:79%;padding-right:45px;">
                        <table style="border-width:0;width:98%;margin:auto;border-spacing:8px" class="tablebg" >
                            <tr>
                                <td colspan="2" style="padding:3px">
                                    <asp:Label ID="lblError" runat="server" CssClass="errormsg"></asp:Label>
                                </td>
                            </tr>
                            <tr style="width:100%;">
                                <td style="width: 30%;text-align:left" class="lefttdbg">
                                    <asp:Label ID="lbllstlooknameId" runat="server"><span class="lblNameStyle"><%= skrm.GlobalResourceSet.GetString("lookup_sktitle")%>          <img id="imgmandator" alt="Mandatory" runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/Images/mandatoryicon.png%>"
                                        hspace="2" align="top" visible="true" /> </span></asp:Label>
                                </td>
                                <td class="righttdbg" style="width:70%;;">
                                    <asp:TextBox ID="txtQueryName" CssClass="txtinputStyle" onblur="javascript:ValidateEmptyText(this);"
                                        MaxLength="50"  runat="server" />
                                </td>
                                <!--span id="spnerrormsg" style="display:none">Enter some value.This is mandatory.</span-->
                            </tr>
                            <tr style="width:100%;">
                                <td class="lefttdbg" style="text-align:left;width:30%;">
                                    <asp:Label ID="Label1" CssClass="lblNameStyle" runat="server"><%= skrm.GlobalResourceSet.GetString("lookup_skDesc")%></asp:Label><br />
                                    <span class="lblDescriptionStyle">
                                        <%= skrm.GlobalResourceSet.GetString("lookup_skDesctxt")%></span>
                                </td>
                                <td class="righttdbg" style="width:70%;">
                                    <asp:TextBox ID="txtDescription" TextMode="MultiLine" CssClass="txtareaStyle" MaxLength="50" onblur="javascript:ValidateScript();"
                                        runat="server" />
                                </td>
                            </tr>
                            <tr style="width:100%;">
                                <td class="lefttdbg" style="text-align:left;width:30%;">
                                    <asp:Label ID="lbldynlist" CssClass="lblNameStyle" runat="server"><%= skrm.GlobalResourceSet.GetString("lookup_sklistname")%></asp:Label><br />
                                </td>
                                <td class="righttdbg" style="width:70%;">
                                    

                                    <telerik:RadComboBox   ID="RadComboListName"  RenderMode="Classic" runat="server" Width="160px" Height="120px"
                                          EnableEmbeddedSkins="false"  Skin="AWTCombobox" OnClientSelectedIndexChanged="ClearListQueryAndOrderByFields" AutoPostBack="true">
                                      </telerik:RadComboBox>

                                    <input type="hidden" id="hdnListName" runat="server" />
                                    <input type="hidden" id="hdnUserId" runat="server" />
                                    <input type="hidden" id="hdnRepository" runat="server" />
                                </td>
                            </tr>
                            <tr style="width:100%;"><td style="width:100%;" colspan="2" class="lblDescriptionStyle"><%= skrm.GlobalResourceSet.GetString("lookup_sklistnamedesc")%></td></tr>
                            <tr style="width:100%;">
                                <td class="lefttdbg" style="text-align:left;width:30%;">
                                    <span class="subtitle">
                                        <%=skrm.GlobalResourceSet.GetString("lookup_skgetallRec")%>
                                    </span>
                                    <br />
                                </td>
                                <td class="righttdbg" style="text-align:left;width:70%;">
                                    <asp:RadioButtonList AutoPostBack="true" RepeatDirection="Horizontal" OnSelectedIndexChanged="radioGetAllRecId_SelectedIndexChanged"
                                        ID="radioGetAllRecId" runat="server" CssClass="inputradio">
                                        <asp:ListItem Value="true" Enabled="true"></asp:ListItem>
                                        <asp:ListItem Value="false" Selected="True" Enabled="true"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                            <tr style="width:100%;"><td style="width:100%;" colspan="2" class="lblDescriptionStyle"><%= skrm.GlobalResourceSet.GetString("lookup_skgetallRecdesc")%></td></tr>
                            <tr style="width:100%;">
                                <td class="lefttdbg" style="text-align:left;width:30%;">
                                    <span class="lblNameStyle">
                                        <%=txtListQuery%> <img id="img1" alt="Mandatory" runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/Images/mandatoryicon.png%>"
                                        hspace="2" align="top" visible="true" />
                                    </span>
                                    <img id="imgListQuery" alt="<%= skrm.GlobalResourceSet.GetString("lookuplist_mandListQuery")%>"
                                        src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>SkeltaForms/images/erroricon.png" style="visibility: hidden" />
                                    <br />
                                    <span class="description">
                                        <%= skrm.GlobalResourceSet.GetString("lookup_skquerydesc")%></span>
                                </td>
                                <td style="text-align:left;vertical-align:middle;width:70%;" class="righttdbg">
                                    <table style="width:100%; border-width:0">
                                        <tr style="width:100%;">
                                            <td style="width:90%;padding-bottom:11px;">
                                                <asp:TextBox ID="txtQuery" Width="100%" runat="server" CssClass="txtareaStyle" ReadOnly="true"
                                                    TextMode="MultiLine" Columns="2" EnableViewState="true" onblur="javascript:ValidateEmptyListQuery(this);"></asp:TextBox>
                                            </td>
                                            <td style="padding:5px;width:10%;">
                                                <img  alt="" id="imageOpenSlots" onclick="Javascript:return OpenRadWindowDynamicQuery();" style="padding-bottom:inherit;" runat="server"/>
                                                <input style="height: 25px; width: 25px; vertical-align: top" type="button"
                                                    id="btnOpenSlots" class="lookupnavigationbutton" onclick="Javascript:return OpenRadWindowDynamicQuery();"
                                                    value="..." runat="server" visible="false" />
                                                <input type="hidden" id="hdnActualQuery" runat="server" />
                                                <input type="hidden" id="hdnDisplayQuery" runat="server" />
                                                

                                                <telerik:RadWindowManager ID="RadWindowManager1" EnableEmbeddedSkins="false" runat="server" 
                                                    Behaviors="Resize,Move,Close,Maximize" RenderMode="Classic" VisibleStatusbar="false" Skin="AWTWindow">                                </telerik:RadWindowManager>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr style="width:100%;">
                                <td class="lefttdbg" style="text-align:left;width:30%;">
                                    <span class="lblNameStyle" runat="server">
                                        <%= skrm.GlobalResourceSet.GetString("lookup_OrderBy")%>
                                    </span>
                                    <br />
                                    <span class="lblDescriptionStyle" runat="server">
                                        <%= skrm.GlobalResourceSet.GetString("lookup_OrderByDescription")%></span>
                                </td>
                                <td style="text-align:left;vertical-align:middle;width:70%;" class="righttdbg">
                                    <table style="width:100%;border-width:0">
                                        <tr style="width:100%;">
                                            <td style="width:90%">
                                                <asp:TextBox ID="txtOrderByQuery" Width="100%" runat="server" CssClass="txtareaStyle"
                                                    ReadOnly="true" TextMode="MultiLine" Columns="2" EnableViewState="true"></asp:TextBox>
                                            </td>
                                            <td style="padding:5px;width:10%;vertical-align:bottom;">
                                                <img  alt="" src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>Repository/Site/Images/database-icon.png" id="imgOpenOrderByClauses" onclick="Javascript:return OpenRadWindowOrderByQuery();" style="padding-bottom:inherit;"/>
                                                <input style="height: 25px; width: 25px;vertical-align: middle" type="button" id="btnOpenOrderByClauses"
                                                    class="lookupnavigationbutton" onclick="Javascript:return OpenRadWindowOrderByQuery();"
                                                    value="..." runat="server" visible="false" />
                                                <input type="hidden" id="hdnDisplayOrderByQuery" runat="server" />
                                                <input type="hidden" id="hdnActualOrderByQuery" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr style="width:100%;">
                                <td class="lefttdbg" style="text-align:left;width:30%;">
                                    <span class="lblNameStyle">
                                        <%=skrm.GlobalResourceSet.GetString("lookup_skmxrows")%>
                                        <img id="img2" alt="Mandatory" runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/Images/mandatoryicon.png%>"
                                            hspace="2" align="top" style="visibility: hidden" />
                                        <img id="img3" alt="<%= skrm.GlobalResourceSet.GetString("lookuplist_mandTitle")%>"
                                            src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>SkeltaForms/images/erroricon.png" style="visibility: hidden" />
                                    </span>
                                    <br />
                                </td>
                                <td class="righttdbg" style="text-align:left;padding:4px;width:70%;">
                                    <telerik:RadNumericTextBox ID="topId" EnableEmbeddedSkins="false" Skin="AWTInput"  NumberFormat-DecimalDigits="0"
                                         runat="server"  Width="100%">
                                    </telerik:RadNumericTextBox>
                                </td>
                            </tr>
                            <tr style="width:100%;"> <td style="width:100%;" class="lblDescriptionStyle" colspan="2">  <%=skrm.GlobalResourceSet.GetString("lookup_skmxrowsdesc")%> </td></tr>
                            <tr style="display: none;width:100%;">
                                <td style="width: 30%;text-align:left" class="lblNameStyle">
                                    <%=skrm.GlobalResourceSet.GetString("Select distinct records")%>
                                </td>
                                <td style="width: 70%;text-align:left" class="subtitle" >
                                    <asp:RadioButtonList RepeatDirection="Horizontal" ID="idDistinctQuery" runat="server"
                                        CssClass="inputradio">
                                        <asp:ListItem Value="Yes" Selected="true"></asp:ListItem>
                                        <asp:ListItem Value="No" Enabled="true"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <span class="lblDescriptionStyle">
                                        <%= skrm.GlobalResourceSet.GetString("Selects the distinct records for the selected display columns")%>
                                    </span>
                                </td>
                            </tr>
                            <%--<tr visible="false">
                                                    <td>
                                             
                                                    </td>
                                                </tr>--%>
                            <tr style="width:100%;">
                                <td class="lefttdbg" style="vertical-align:top;width:30%;">
                                    <span class="lblNameStyle" style="padding-top:5px;">
                                        <%=skrm.GlobalResourceSet.GetString("lookup_skdiscol")%>
                                    </span>
                                    <br />
                                </td>
                                <td class="righttdbg" style="width:70%;">
                                    <!-- Display Columns -->
                                    <table style="width:100%;border-width:0">
                                        <tr style="width:100%;padding-bottom:15px;">
                                            <td style="width:40%">
                                                <%--  <span class="subtitle"><%= skrm.GlobalResourceSet.GetString("lookup_sktbl")%></span> <br />--%>
                                                <span class="lblDescriptionStyle">
                                                    <%= skrm.GlobalResourceSet.GetString("lookup_sktbldesc")%>
                                                </span>
                                            </td>
                                            <td colspan="2" style="width:60%;">
                                                <input type="text" onclick="OpenTableStructure('Table');" id="RadComboTable" runat="server"
                                                    readonly="readonly" style="width: 100%;" class="txtboxStyle" />
                                            </td>
                                        </tr>
                                        <tr style="height: 110px;width:100%;">
                                            <td style="vertical-align:top;" class="lblNameStyle">
                                                <%= skrm.GlobalResourceSet.GetString("lookup_skavlcols")%>
                                                <br />
                                                <asp:ListBox EnableViewState="true" ID="listColumns" Height="167px" Width="200px"
                                                    runat="server" SelectionMode="Multiple" CssClass="inputtext" style="border:1px solid #ccc"></asp:ListBox>
                                            </td>
                                            <td style="width: 5%;text-align:center;vertical-align:middle">
                                                <table style="width: 100%;border-width:0;padding-right:30px;">
                                                    <tr>
                                                        <td>
                                                            <input type="button" id="btnForBack1" runat="server" style="width: 36px;" class="lookupnavigationbutton"
                                                                value=">" />
                                                        </td>
                                                        
                                                    </tr>
                                                    <tr></tr>
                                                    <tr>
                                                        <td>
                                                            <input type="button" id="btnForBack2" runat="server" style="width: 36px" class="lookupnavigationbutton"
                                                                value=">>" />
                                                        </td>
                                                    </tr>
                                                    <tr></tr>
                                                    <tr>
                                                        <td>
                                                            <input type="button" id="btnForBack3" runat="server" style="width: 36px;" class="lookupnavigationbutton"
                                                                value="<<" />
                                                        </td>
                                                    </tr>
                                                    <tr></tr>
                                                    <tr>
                                                        <td>
                                                            <input type="button" id="btnForBack4" runat="server" style="width: 36px;" class="lookupnavigationbutton"
                                                                value="<" />
                                                        </td>
                                                    </tr>
                                                    <tr></tr>
                                                </table>
                                            </td>
                                            <td style="width: 49%; vertical-align:top;" class="lblNameStyle">
                                                <%= skrm.GlobalResourceSet.GetString("lookup_skselcols")%>
                                                <br />
                                                <asp:ListBox EnableViewState="true" ID="listValues" Height="167px" Width="200px"
                                                    runat="server" SelectionMode="Multiple" CssClass="inputtext" style="border:1px solid #ccc;"></asp:ListBox>
                                            </td>
                                        </tr>
                                        <tr style="display: none;width:100%;">
                                            <td style="width: 30%">
                                                <span class="lblDescriptionStyle">
                                                    <%= skrm.GlobalResourceSet.GetString("lookup_skform")%>
                                                </span>
                                            </td>
                                            <td colspan="3" style="width:70%;">
                                                <table>
                                                    <tr>
                                                        <td>
                                                          

                                                            <telerik:RadComboBox   ID="RadComboForms"  RenderMode="Classic" runat="server" Width="180" Height="120px" 
                                                             EnableEmbeddedSkins="false" EnableViewState="true" Skin="AWTCombobox">
                                                             </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr style="width:100%;"><td style="width:100%;" class="lblDescriptionStyle" colspan="2"> <%=skrm.GlobalResourceSet.GetString("lookup_skdiscoldesc")%> </td></tr>
                            <tr style="width:100%;">
                                <td style="width: 30%; vertical-align:middle" class="lefttdbg">
                                    <span class="lblNameStyle">
                                        <%= skrm.GlobalResourceSet.GetString("lookup_skseldiscol")%>
                                    </span>
                                    <br />
                                </td>
                                <td colspan="3" class="righttdbg" style="width:70%;">
                                    <table >
                                        <tr>
                                            <td style="padding-left:5px;">
                                                 <telerik:RadComboBox   ID="RadComboDColumns"  RenderMode="Classic" runat="server" Width="180px" Height="120px" 
                                                             EnableEmbeddedSkins="false" EnableViewState="true" Skin="AWTCombobox">
                                                 </telerik:RadComboBox>                                               
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                             <tr style="width:100%;"><td style="width:100%;" class="lblDescriptionStyle" colspan="2"> <%=skrm.GlobalResourceSet.GetString("lookup_skseldiscoldesc")%> </td></tr>
                            <tr style="width:100%;">
                                <td style="width: 30%" class="lefttdbg">
                                    <span class="lblNameStyle">
                                        <%= skrm.GlobalResourceSet.GetString("lookup_skvaluecol")%>
                                    </span>
                                    <br />
                                </td>
                                <td colspan="3" style="width: 70%" class="righttdbg">
                                    <table style="width:100%;">
                                        <tr>
                                            <td style="width:30%;">
                                                <asp:RadioButtonList ID="rblValue" AutoPostBack="true" runat="server" RepeatDirection="Horizontal"
                                                    CssClass="inputradio">
                                                    <asp:ListItem Selected="True" Value="Auto">
                                                    </asp:ListItem>
                                                    <asp:ListItem Value="Custom">
                                                    </asp:ListItem>
                                                </asp:RadioButtonList>
                                            </td>
                                            <td style="width:70%;">
                                                <input type="text" onclick="OpenTableStructure('Value');" id="txtCustomValue" runat="server"
                                                    readonly="readonly" class="txtboxStyle" style="width:50%;" />
                                                <input type="hidden" id="hdnTableType" runat="server" />
                                                <input type="hidden" id="hdnDisplayColumnTable" runat="server" />
                                                <input type="hidden" id="hdnDisplayColumn" runat="server" />
                                                <input type="hidden" id="hdnDisplayColumnName" runat="server" />
                                               

                                                <telerik:RadComboBox   ID="RadComboTableSchema"  RenderMode="Classic" runat="server" Width="180" Height="120px"
                                                             EnableEmbeddedSkins="false" Skin="AWTCombobox">
                                                </telerik:RadComboBox> 
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr style="width:100%;"><td style="width:100%;" class="lblDescriptionStyle" colspan="2"> <%=skrm.GlobalResourceSet.GetString("lookup_skvaluecoldesc")%> </td></tr>
                            <tr style="width:100%;">
                                <td style="width: 30%" class="lefttdbg">
                                    <span class="lblNameStyle">
                                        <%= skrm.GlobalResourceSet.GetString("lookup_skdisvalingrd")%>
                                    </span>
                                    <br />
                                    <span class="lblDescriptionStyle">
                                        <%= skrm.GlobalResourceSet.GetString("lookup_skdisvalingrddesc")%></span>
                                </td>
                                <td colspan="3" class="righttdbg" style="width:70%;padding-bottom:20px;">
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:RadioButtonList ID="rblDisplayValueinGrid" RepeatDirection="Horizontal" runat="server"
                                                    CssClass="inputradio">
                                                    <asp:ListItem Value="True">
                                                    </asp:ListItem>
                                                    <asp:ListItem Value="False">
                                                    </asp:ListItem>
                                                </asp:RadioButtonList>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <%--<br />--%>
                    <div id="FooterDiv" style="padding-bottom:55px;">
                        <table style="width: 99%;border-width:0;border-spacing:0px;padding-top:7px;">
                            <tr>
                                <div class="lineCss" style="width:94%;margin-left:20px;border-bottom-width: 0px;"></div>
                                <td style="text-align:right;vertical-align:bottom;">
                                    <button type="button" name="btnClose" class="inputsecondarybutton" onclick="javascript:closeWindowInternal();" style="margin-right: 10px;"><%=skrm.GlobalResourceSet.GetString("ec_BAMReports_BtnExportClose")%></button>
                                    <asp:Button runat="server" ID="btnUpdate" OnClientClick="ValidateQuery();return false;"
                                        CssClass="inputbutton"  />
                                     <asp:Button runat="server" ID="btnHidden" style="display:none;" OnClick="btnUpdate_Click"
                                        CssClass="inputbutton"  />
                                    <asp:Label ID="InjectScript" runat="server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                   
            </div>
            <div style="width: 100%; border: Solid 2px #ccc; display: none;" id="divTree"
                runat="server" class="lefttdbg">
                <table style="width: 100%;border-width:0">
                    <tr>
                        <td style="text-align:right;width: 100%" class="righttdbg">
                            <a id="aCloseDiv" onclick="CloseDiv()">
                                <img style="border: 0" src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>Common/Images/close.gif" alt=""/></a>
                        </td>
                    </tr>
                </table>
                
                 <telerik:RadTreeview ID="RadTreeViewDisplay"  RenderMode="Classic" runat="server" Height="100px" Skin="AWTTreeView"
                  AutoPostBack="true"  EnableEmbeddedSkins="false" EnableViewState="true">
                </telerik:RadTreeview>
            </div>
                 </telerik:RadCodeBlock>
        </telerik:RadAjaxPanel>
        </form>
    </div>
</body>
</html>
<script type="text/javascript">
    var isPostBack = '<%=isPostback %>';
    AddEventHandler(window, 'resize', resizefunction);

    function AddEventHandler(elementObject, eventName, functionObject) {
        if (document.addEventListener)
            elementObject.addEventListener(eventName, functionObject, false);
        else
            if (document.attachEvent)
            elementObject.attachEvent("on" + eventName, functionObject);
    }

    function resizefunction() {
        if (isPostBack != 'N') {
            
           
            var bodydiv = document.getElementById('BodyDiv');
            var headerdiv = document.getElementById('HeaderDiv');
            var footerdiv = document.getElementById('FooterDiv');
            var parentdiv = document.getElementById('ParentDiv');
            if (parentdiv.offsetParent == document.body)
                document.body.style.height = '100%';

            var parentdivheight = parentdiv.offsetParent.offsetHeight - 5;
            parentdiv.style.height = parentdivheight;
            try { bodydiv.style.height = parentdivheight - headerdiv.offsetHeight - footerdiv.offsetHeight - 20; } catch (e) { } //headerdiv.offsetHeight -
            bodydiv.style.width = parentdiv.clientWidth;
            bodydiv.style.overflow = 'auto';
            parentdiv.style.overflow = 'hidden';
        }
    }

    $(document).ready(function () {
        
        if (document.getElementById("radioGetAllRecId_0").checked == true) {
           document.getElementById("imageOpenSlots").style.visibility = "hidden";
        }
    });
    function ToggleMax(obj) {
        var DivTree = document.getElementById("<%=divTree.ClientID%>");
        DivTree.style.display = "block";

        DivTree.style.position = "absolute";
        if (obj == 'Table') {
            DivTree.style.left = 110 + 'px';
            var check = document.getElementById("<%= RadComboTable.ClientID%>");              
            try{
                if (check.offsetParent.offsetParent != null) {
                    DivTree.style.left = check.offsetParent.offsetParent.clientWidth +20 + 'px';
                }
               }
            catch(e)
            {}
            
           
            DivTree.style.top = 200 + 'px';
            DivTree.style.width = 250 + 'px';
            DivTree.style.height = 150 + 'px';
        }
        else {
            DivTree.style.left = 440 + 'px';
            DivTree.style.top = 350 + 'px';
            DivTree.style.width = 250 + 'px';
            DivTree.style.height = 150 + 'px';
        }

        var RadTree = document.getElementById("<%=RadTreeViewDisplay.ClientID%>");
        RadTree.style.height = DivTree.style.height;
    }

    function CloseDiv() {
        var DivTree = document.getElementById("<%=divTree.ClientID%>");
        divTree.style.display = "none";
    }

    function ValidateQuery() {
   
         var QueryName = document.getElementById("<%=txtQueryName.ClientID%>");
        var ListName = document.getElementById("<%=hdnListName.ClientID%>");
        var ListQuery = document.getElementById("<%=hdnActualQuery.ClientID%>");
         //var DispalyColumn = window["RadComboDColumns"];
        var DispalyColumn = $find('<%= RadComboDColumns.ClientID %>');
        var BindToForm = document.getElementById("<%=RadComboForms.ClientID%>");
        var selectedColumns = document.getElementById("<%=listValues.ClientID%>");
        var displayValueColinGrid = document.getElementById("<%=rblDisplayValueinGrid.ClientID%>>");
         if (QueryName.value == "") {
           
           // alert("<%=strTitle%>");
            DisplayErrorMessage("<%=strTitle%>");
            QueryName.focus();
            return false;
        }

        if (ListName.value == "") {
           // alert("<%=strListEmpty%>");
            DisplayErrorMessage("<%=strListEmpty%>");
            ListName.focus();
            return false;
        }

        if (document.getElementById("radioGetAllRecId_0").checked == false) {
            if (ListQuery.value == "") {
              //  alert("<%=strListQueryEmpty%>");
                DisplayErrorMessage("<%=strListQueryEmpty%>");
                return false;
            }
        }
        if (selectedColumns.length == 0) {
            // alert("<%=strSelectedColsEmpty%>");
            DisplayErrorMessage("<%=strSelectedColsEmpty%>");
            return false;
        }
        if (document.getElementById('rblDisplayValueinGrid_0').checked == false) {
            var columnnamefound = false;
            if (document.getElementById('rblValue_0').checked == true) {
                // don't do any check, just return
            }
            else {
                var valueColumnName = document.getElementById('hdnDisplayColumn').value;

                for (var i = 0; i < selectedColumns.length; i++) {
                    if (selectedColumns[i].value == valueColumnName || selectedColumns[i].text == valueColumnName) {
                        columnnamefound = true;
                        break;
                    }
                }
                if (!columnnamefound) {                    
                   // alert("<%=strValueColMandt%>");
                    DisplayErrorMessage("<%=strValueColMandt%>");
                    return false;
                }
                columnnamefound = false;
                var displayActalCOlumn = DispalyColumn.GetValue();
                if (displayActalCOlumn == valueColumnName) {
                   // alert("<%=strDisColMandt%>");
                    DisplayErrorMessage("<%=strDisColMandt%>");
                    return false;
                }
            }
        }
        var imageele = document.getElementById('img2');
        var hdnActualQuery = document.getElementById("hdnActualOrderByQuery");
        if (imageele != null && hdnActualQuery.value != "") {
            var val = document.getElementById('<%=topId.ClientID %>');
            if (val != null && val.value == "") {
               // alert("<%=strMaxNoRows %>");
                DisplayErrorMessage("<%=strMaxNoRows%>");
                return false;
            }
            else if (val.value == "0") {
               // alert("<%=strMaxRowsZero %>");
                DisplayErrorMessage("<%=strMaxRowsZero%>");
                return false;
            }
        }
       


        ShowConfirmBox();
       
    }

    function ShowConfirmBox() {
       
        if (objURL && objURL["mode"]) {
            if (objURL["mode"] == "Edit" || objURL["mode"] == "edit") {
               // var result = confirm("<%=strConfirmMess%>");
              //  if (result == true) {
               //     return true;
              //  }
              //  else {
               //     closeWindow();
               // }
                se.ui.messageDialog.showConfirmation("<%=Title%>", "<%=strConfirmMess%>",
                      function (userResponse) {
                          if (userResponse) {
                              document.getElementById("btnHidden").click();
                          }
                          else {
                              closeWindow();
                          }
                      });

            }
        }
        else {
            document.getElementById("btnHidden").click();
          
        }

    }

    function OpenTableStructure(obj) {
        var hdnTableType = document.getElementById("<%=hdnTableType.ClientID%>");
        hdnTableType.value = obj;
        ToggleMax(obj);
    }

    function NodeClick(node) {
        var RadComboTable = document.getElementById("<%=RadComboTable.ClientID%>");
        //Get the Parent Nodes and Append from the Parent Node 
        var NodeText = node.Text;
        var i = 0;
        for (i = node.Level; i > 0; i--) {
            if (node.Parent != null) {
                node = node.Parent;
                NodeText = NodeText + "``";
                NodeText = NodeText + node.Text;
            }
        }

        var TempNodeText = NodeText;
        NodeText = "";
        var mySplitResult = TempNodeText.split("``");

        var j = 0;
        for (j = mySplitResult.length; j > 0; j--) {
            if (j == mySplitResult.length) {
                NodeText = mySplitResult[j - 1];
            }
            else {
                NodeText = NodeText + ".";
                NodeText = NodeText + mySplitResult[j - 1];
            }
        }
        //Update the Text in to the TextBox
        RadComboTable.value = NodeText;
        CloseDiv();
    }
</script>

