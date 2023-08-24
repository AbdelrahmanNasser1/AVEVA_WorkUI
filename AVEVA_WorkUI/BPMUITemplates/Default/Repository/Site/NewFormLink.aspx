<%@ page language="C#" autoeventwireup="true" inherits="Skelta.Repository.Web.CodeBehind.NewFormLink" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title><%=strTitle%></title>
    <script type="text/javascript" src="../../NextGenForms/js/jquery.min.js"></script>
    <script type="text/javascript" src="../../NextGenForms/js/knockout.min.js"></script>
    <script type="text/javascript" src="../../NextGenForms/js/xml2json.min.js"></script>
    <script type="text/javascript" src="../../NextGenForms/app/Skelta.min.js"></script>
    <script type="text/javascript" src="../../NextGenForms/js/kendodependencies.min.js"></script>
    <script type="text/javascript" src="../../NextGenForms/js/kendo.all.min.js"></script>
    <script type="text/javascript" src="../../NextGenForms/js/knockout-kendo.min.js"></script>
    <script type="text/javascript" src="../../NextGenForms/js/date.min.js"></script>
    <script type="text/javascript" src="Scripts/FormLink.min.js"></script>
    <style>
        html, body, form
        {
            height: 100%;
        }

        #formSelectionDiv
        {
            width: 80%;
        }

        .leftDiv
        {
            float: left;
        }

        .rightDiv
        {
            float: right;
        }
    </style>
</head>


<script type="text/javascript">
    var skeltaUtils = skelta.utilities;	
    //xmlUniqueSeparator used by X2JS conversion internally
    var xmlUniqueSeparator = "[[]{*}$!${*}[]]";
    var app = '<%=_applicationName%>';
    var form = '<%=SelectedForm%>';
    var formLink = FormLink.getInstance();
    var formParametersLabel = '<%=GetLangSpecTextForNextForms("FormFormParametersGridHeadText") %>';
    var formParametersDesc = '<%=GetLangSpecText("ec_nav_formlink_fp_desc") %>';
    var formParametersName = '<%=GetLangSpecText("ec_nav_formlink_fp_name") %>';
    var formParametersType = '<%=GetLangSpecText("ec_nav_formlink_fb_type") %>';
    var formParametersValue = '<%=GetLangSpecText("ec_nav_formlink_fb_value") %>';
    var localeParameterType = {
        string: '<%=GetLangSpecTextForNextForms("FormFormParameterStringType") %>',
        number: '<%=GetLangSpecTextForNextForms("FormFormParameterNumberType") %>',
        date: '<%=GetLangSpecTextForNextForms("FormFormParameterDateType") %>',
        array: '<%=GetLangSpecTextForNextForms("FormFormParameterArrayType") %>',
        object: '<%=GetLangSpecTextForNextForms("FormFormParameterObjectType") %>'
    }

    function GetRadWindow()
    {
        var oWindow = null;

        if (window.radWindow)
            oWindow = window.radWindow;
        else if (window.frameElement.radWindow)
            oWindow = window.frameElement.radWindow;

        return oWindow;
    }

    function closeWin(message)
    {
        var oWindow = GetRadWindow();
        resizefunction();
        se.ui.messageDialog.showAlert('<%=GetLangSpecText("ec_newformlink_title") %>', message, function () { oWindow.close(); });
    }

    function getQueryStringValue (key) {  
        return decodeURIComponent(window.location.search.replace(new RegExp("^(?:.*[&\\?]" + encodeURIComponent(key).replace(/[\.\+\*]/g, "\\$&") + "(?:\\=([^&]*))?)?.*$", "i"), "$1"));  
    } 

    if(getQueryStringValue("mode") == 'E'){
        AddEventHandler(window,'load', resizefunction);
    }
    else{
        AddEventHandler(window, 'resize', resizefunction);
    }
    //AddEventHandler(window,'load', resizefunction);

    function AddEventHandler(elementObject, eventName, functionObject)
    {
        if (document.addEventListener)
            elementObject.addEventListener(eventName, functionObject, false);
        else
            if (document.attachEvent)
                elementObject.attachEvent("on" + eventName, functionObject);
    }
    function resizefunction()
    {
        setTimeout(function ()
        {
            var bodydiv = document.getElementById('divbody');
            var headerdiv = document.getElementById('divheader');
            var footerdiv = document.getElementById('divfooter');
            var parentdiv = document.getElementById('divparent');
            if (parentdiv.offsetParent == document.body)
                document.body.style.height = '100%';

            var parentdivheight = parentdiv.offsetParent.offsetHeight;
            //parentdiv.style.height = parentdivheight;
            try { bodydiv.style.height = parentdivheight - headerdiv.offsetHeight - footerdiv.offsetHeight + 'px'; } catch (e) { }
            //bodydiv.style.width =  '100px';
            bodydiv.style.width = parentdiv.clientWidth;
            bodydiv.style.overflow = 'auto';
            parentdiv.style.overflow = 'hidden';
        }, 0);
    }
    function Validate()
    {
        var title = document.getElementById('txtName');
        if (title.value == '')
        {
            resizefunction();
            se.ui.messageDialog.showError('<%=GetLangSpecText("ec_newformlink_title") %>', '<%=GetLangSpecText("ec_nav_formlink_title_reqd") %>');
            return false;
        }

        formLink.updateFormParametersValue();
        return true;
    }
    function ShowMsg(message)
    {
        resizefunction();
        se.ui.messageDialog.showError('<%=GetLangSpecText("ec_newformlink_title") %>', message);
        return false;
    }
</script>

<body style="margin: 0; overflow: hidden;">
<script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
<script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=ThemePath %>CommonUXControls/StyleSheet/se.ui.min.css" />     

<script>
	skelta.serverUrl = "../../NextGenForms/";

    se.ui.messageDialog.setGlobalOptions({
        localization: { 
        closeButtonCaption: '<%=GetLangSpecText("se_ui_messagedialog_close_caption") %>',
        okButtonCaption: '<%=GetLangSpecText("se_ui_messagedialog_ok_caption") %>',
        cancelButtonCaption: '<%=GetLangSpecText("se_ui_messagedialog_cancel_caption") %>',
        showDetailsCaption: '<%=GetLangSpecText("se_ui_messagedialog_showdetails_caption") %>',
        hideDetailsCaption: '<%=GetLangSpecText("se_ui_messagedialog_hidedetails_caption") %>',
        }
    });
</script>
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        <input type="hidden" runat="server" id="selectedFormField" />
        <link rel="stylesheet" href="<%=ThemePath%>Common/StyleSheet/Global.css" type="text/css" />
        <link rel="stylesheet" type="text/css" href="<%=ThemePath%>NextGenForms/css/SkeltaForms.css" />
             <link href="<%=ThemePath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css" rel="stylesheet" type="text/css" />
       <link href="<%=ThemePath%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css" rel="stylesheet" type="text/css" />
        <div id="divparent">
            <asp:Panel ID="Panel1" runat="server">
                <div id="divheader">
                    <table style="width: 100%">
                        <tr>
                            <td rowspan="2" style="vertical-align: middle; width: 40px; text-align: center;">
                                <img src="<%=ThemePath%>Repository/Site/images/add-form-link.png" alt="" /></td>
                            <td class="MainHeading"><%=strHeader%></td>
                        </tr>
                        <tr>
                            <td class="description" style="padding-bottom: 10px;"><%=strDesc %></td>
                        </tr>
                    </table>

                </div>
                <div id="divbody">
                    <table width="100%" align="center" border="0" cellpadding="7" cellspacing="1" class="tablebg">
                        <tr>
                            <td class="lefttdbg" valign="top" style="width: 45%">
                                <span class="subtitle">
                                    <%=GetLangSpecText("ec_newformlink_name") %> <span style="color: Red">*</span>
                                </span>
                                <br />
                                <span class="description">
                                    <%=GetLangSpecText("ec_newformlink_name_desc") %>
                                </span>
                            </td>
                            <td class="righttdbg" style="width: 50%">
                                <asp:TextBox ID="txtName" CssClass="inputtext" runat="server" Width="80%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="lefttdbg" valign="top" style="width: 45%">
                                <span class="subtitle">
                                    <%=GetLangSpecText("ec_newformlink_desc")%>
                                </span>
                                <br />
                                <span class="description">
                                    <%=GetLangSpecText("ec_newformlink_desc_desc")%>
                                </span>
                            </td>
                            <td class="righttdbg" style="width: 50%">
                                <asp:TextBox ID="txtDesc" CssClass="inputtext" runat="server" TextMode="multiLine" Width="80%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="lefttdbg" valign="top" style="width: 45%">
                                <span class="subtitle">
                                    <%=GetLangSpecText("ec_newformlink_form_name")%>  <span style="color: Red">*</span>
                                </span>
                                <br />
                                <span class="description">
                                    <%=GetLangSpecText("ec_newformlink_form_name_desc")%>
                                </span>
                            </td>
                            <td class="righttdbg" style="width: 50%">
                                <div id="formSelectionDiv">
                                    <div class="leftDiv">
                                        <asp:PlaceHolder ID="phlist" runat="server"></asp:PlaceHolder>
                                    </div>
                                    <div class="rightDiv">
                                        <input runat="server" id="reloadButton" type="button" onclick="formLink.reloadFormParameter();" style="width: 140px;" />
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr style="display: none;">
                            <td colspan="2">
                                <input id="formParametersField" type="hidden" runat="server" />
                                <div id="formParametersContainer" style="display: block; width: 100%; position: relative; height: 220px;">
                                    <iframe id="formParametersFrame" style="width: 100%; height: 100%; border: 0;"></iframe>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="lefttdbg" valign="top" style="width: 45%">
                                <span class="subtitle">
                                    <%=GetLangSpecText("ec_newformlink_image")%>
                                </span>
                                <br />
                                <span class="description">
                                    <%=GetLangSpecText("ec_newformlink_image_desc")%>
                                </span>
                            </td>
                            <td class="righttdbg" style="width: 50%">
                                <asp:TextBox ID="txtImage" CssClass="inputtext" runat="server" Width="80%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="lefttdbg" valign="top" style="width: 45%">
                                <span class="subtitle">
                                    <%=GetLangSpecText("ec_newformlink_windowmode")%>
                                </span>
                                <br />
                                <span class="description">
                                    <%=GetLangSpecText("ec_newformlink_windowmode_desc")%>
                                </span>
                            </td>
                            <td class="righttdbg" style="width: 50%">
                                <asp:RadioButtonList AutoPostBack="true" ID="RadioWindowMode" runat="server" RepeatDirection="Horizontal"
                                    CssClass="inputradio" OnSelectedIndexChanged="RadioWindowMode_SelectedIndexChanged">
                                    <asp:ListItem Selected="true" Text="Pop-up"></asp:ListItem>
                                    <asp:ListItem Text="Inline"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr>                            
                            <td class="lefttdbg" valign="top" style="width: 45%">
                                <span class="subtitle">
                                    <%=GetLangSpecText("ec_newformlink_deviceavailability")%>
                                </span>
                                <br />
                                <span class="description">
                                    <%=GetLangSpecText("ec_newformlink_deviceavailability_desc")%>
                                </span>
                            </td>
                            <td class="righttdbg" style="width: 50%">
                                <asp:CheckboxList ID="CheckBoxDeviceAvailability" runat="server" RepeatDirection="Horizontal"
                                    CssClass="inputradio">
                                    <asp:ListItem Selected="true" Text="Web"></asp:ListItem>
                                    <asp:ListItem Text="Mobile"></asp:ListItem>
                                </asp:CheckboxList>
                            </td>                        
                        </tr>
                        <tr>
                            <td class="lefttdbg" valign="top" style="width: 45%">
                                <span class="subtitle">
                                    <%=GetLangSpecText("ec_newnavigation_menuposition")%>
                                </span>
                                <br />
                                <span class="description">
                                    <%=GetLangSpecText("ec_newnavigation_menuposition_desc")%>
                                </span>
                            </td>
                            <td class="righttdbg" style="width: 50%">
                                <asp:TextBox ID="txtMenuOrder" CssClass="inputtext" runat="server" Width="80%" MaxLength="9"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td id="tdNote" class="lefttdbg" colspan="2">
                                <span class="note">
                                    <img src="<%=ThemePath%>Repository/Site/images/icon-warnings.png" align="absmiddle" />&nbsp;&nbsp;
                                        <%=GetLangSpecText("ec_newformlink_image_desc_note")%>
                                </span>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="divfooter">
                    <table width="100%" border="0" cellspacing="1" cellpadding="10" align="center">
                        <tr>
                            <td colspan="2" style="text-align: right; padding-right: 10px;">
                                <asp:Button ID="btnsave" CssClass="inputbutton" runat="server" OnClientClick="javascript:return Validate();" OnClick="btnsave_Click" />&nbsp;
                            </td>
                        </tr>
                    </table>
                </div>
            </asp:Panel>
        </div>
    </form>
</body>
</html>
