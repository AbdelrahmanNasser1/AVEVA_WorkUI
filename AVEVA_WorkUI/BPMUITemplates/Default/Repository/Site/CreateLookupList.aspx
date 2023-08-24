<%@ page language="C#" autoeventwireup="true" inherits="Skelta.Forms.Web.CodeBehind.CreateDataBaseLookupList" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ outputcache duration="100" location="None" nostore="true" %>

<!DOCTYPE html>
<html style="height: 100%">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>
        <telerik:RadCodeBlock ID="RadScriptBlock3" runat="server">
            <%=strtitlemsg%>
        </telerik:RadCodeBlock>
    </title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <script type="text/javascript">
        function GetRadWindow()
        {
            var oWindow = null;
            oWindow = window.frameElement.radWindow;
            return oWindow;
        }
        function closeWindow()
        {
            var oWindow = GetRadWindow();
            setTimeout(function () {
                oWindow.close();
            }, 0);
        }

        function showMessageAndCloseWindow(message){
            se.ui.messageDialog.showAlert(document.title, message, function()
                {
                    closeWindow();
                });
        }

        function PreviewDataSet(u)
        {
           setTimeout(function () {
                window.radopen(u, "PreviewRadWindow");
            }, 0);
        }
        function ResizeWindow()
        {

            var oWindow = GetRadWindow();
            var w = oWindow.get_width();
            var h = oWindow.get_height();
            // oWindow.SetSize(w, 798);
            if (window.parent.location.search != null && window.parent.location.search == '?FromArchestrA=true')
            {
                h = h - 90;
                oWindow.setSize(w, h);
                document.getElementById('BodyDiv').style.overflowY = 'scroll';
            }
            var cltHeight = parent.parent.document.body.clientHeight;

            // if (oWindow.Height > cltHeight)
            {
                var winHeight = cltHeight - 36;
                oWindow.setSize(oWindow.get_width(), winHeight);

            }

            oWindow.center();
        }

        function getTitleAndDescription()
        {
            var mode = getQueryString(window, "mode");
            var isPostBack = document.getElementById('_ispostback').value;
            if (mode === "new" && isPostBack.toLowerCase() !== "true")
            {
                var title = window.sessionStorage["sys_sp_title"];
                var description = window.sessionStorage["sys_sp_desc"];
                if (title)
                {
                    window.document.getElementById("txtName").value = title;
                }
                if (description)
                {
                    window.document.getElementById("txtDescription").value = description;
                }
            }

            window.document.getElementById("txtDescription").focus();
        }

        function getQueryString(windowObject, parameterName)
        {
            var match = RegExp('[?&]' + parameterName + '=([^&]*)').exec(windowObject.location.search);
            return match && decodeURIComponent(match[1].replace(/\+/g, ' '));
        };

        function isPostBack()
        {
            var isPostBack = document.getElementById('_ispostback').value;
            return isPostBack.toLowerCase() === "true";
        }

        function ConfirmSystemGeneratedLookups(headings,msg) {          
                                                  
            se.ui.messageDialog.showConfirmation(headings, msg,
                       function (userResponse) {
                           if (userResponse) {
                               return true;
                           }
                           else {
                               closeWindow();
                               return false; 
                           }
                       });


        }
    </script>
    <style>
        div#panelParametersDataType > input
        {
            display: inline-block !important;
            width: 30%;
            padding-right: 5px;
        }

        div#panelParametersDataType > div
        {
            display: inline-block !important;
            width: 50% !important;
        }
    </style>
</head>
<body style="margin: 0; overflow: hidden; height: 100%" onload="getTitleAndDescription();ResizeWindow()">
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
    <script>
        
        se.ui.messageDialog.setGlobalOptions({
            localization: {
                closeButtonCaption: "<%=skResMgr.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                okButtonCaption: "<%=skResMgr.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
                cancelButtonCaption: "<%=skResMgr.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                showDetailsCaption: "<%=skResMgr.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                hideDetailsCaption: "<%=skResMgr.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
            }
        });

        function DisplayErrorMessage(message) {

            se.ui.messageDialog.showError('<%=strtitlemsg%>', message);
        }

        function DisplaySuccessMessage(message) {

            se.ui.messageDialog.showAlert('<%=strtitlemsg%>', message);
        }

    </script>
        </telerik:RadCodeBlock>

    <div id="ParentDiv" style="height: 100%">
        <form id="form1" runat="server" style="height: 100%">
            <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
            <%=System.Web.Helpers.AntiForgery.GetHtml()%>
                </telerik:RadCodeBlock>
            <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />

            <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
            <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>CommonUXControls/StyleSheet/se.ui.min.css"  rel="stylesheet" type="text/css" /> 
            <input type="hidden" id="_ispostback" value="<%=Page.IsPostBack.ToString()%>" />
            <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>Common/StyleSheet/Global.css" />
           
            <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
             <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>TelerikAjax/StyleSheet/AWTWindow/Window.css">
            <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css">
            <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css">
            </telerik:RadScriptBlock>

            
            <asp:panel id="Panel2" runat="server" height="100%">                 

                <telerik:RadWindowManager ID="RadWindowManager1" Height="550px" Width="800px" Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" runat="server" Behaviors="Close" VisibleStatusbar="false">
                     <Windows>
                        <telerik:RadWindow ID="PreviewRadWindow" Height="550px" Width="800px" runat="server" Left="" Top="" Modal="true">
                        </telerik:RadWindow>
                     </Windows>
                </telerik:RadWindowManager>
                     
                <telerik:RadAjaxPanel ID="radAjaxPanel" runat="server" EnableAJAX="true" ScrollBars="None" Height=98%>
                
                    <div id="HeaderDiv" style="height:10%">
                        <table style="width: 100%; margin: auto; border-width: 0; border-spacing: 0px">
                            <tr class="ListHeaderCss">
                                <td rowspan="2" style="vertical-align: middle; width: 40px; text-align: center;">
                                    <telerik:RadCodeBlock ID="RadCodeBlock3" runat="server">
                                    <img src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>Repository/ListControl/images/icons-ribbon/lookupdatabase.png" alt="" style="vertical-align: middle" />
                                        </telerik:RadCodeBlock>
                                </td>
                                <td class="MainHeading" id="spPageTile" runat="server" style="text-align: left;">
                                    <telerik:RadCodeBlock ID="RadCodeBlock4" runat="server">
                                    <%=skResMgr.GlobalResourceSet.GetString("lookup_dbmaintitle")%>
</telerik:RadCodeBlock>
                                </td>
                            </tr>
                            <tr>
                                <td class="description" style="padding-bottom: 10px;">
                                    <telerik:RadCodeBlock ID="RadCodeBlock5" runat="server">
                                    <%=strDesp%>         
                                        </telerik:RadCodeBlock>
                                </td>
                            </tr>
                        </table>

                    </div>
                    <div id="BodyDiv" style="height:82%;overflow:auto;" onscroll="scroll()" >
                        <table style="width:98%; border-width:0;margin:auto;border-spacing:1px"  class="tablebg" >
                            <tr>
                                <td class="lefttdbg" id="tdName" runat="server" width="40%">
                                    <label id="lbltitle" class="subtitle" runat="server">
                                        <telerik:RadCodeBlock ID="RadCodeBlock6" runat="server">
                                        <%=skResMgr.GlobalResourceSet.GetString("lookup_dbtitle")%>
                                            </telerik:RadCodeBlock>
                                    </label>
                                    <telerik:RadCodeBlock ID="RadCodeBlock7" runat="server">
                                    <img  id="img2" alt="Mandatory"  runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/Images/mandatoryicon.png%>" hspace="2" align="top" visible="true" />
                                        
                                    <img id="img1" alt="Enter some value.This is mandatory." src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>SkeltaForms/images/erroricon.png"
                                                    style="visibility:hidden" />
                                    </telerik:RadCodeBlock>
                                    
                                </td>
                                <td class="righttdbg">
                                    <input type="text" name="txtName" readonly="readonly" class="inputtext" value="" style="width: 96%;" maxlength="200" id="txtName" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="lefttdbg" id="tdDescription" runat="server">
                                    <label id="lbldes" class="subtitle" runat="server">
                                        <telerik:RadCodeBlock ID="RadCodeBlock8" runat="server">
                                        <%=skResMgr.GlobalResourceSet.GetString("lookup_dbdesc")%>
                                            </telerik:RadCodeBlock>
                                    </label>
                                    
                                  </td>
                                <td class="righttdbg"  style="text-align:left">
                                    <textarea rows="2" cols="15" id="txtDescription" class="inputtextarea" style="width: 96%;"
                                        name="txtDescription" runat="server"></textarea>
                                </td>
                            </tr>
                            <tr>
                                <td class="lefttdbg" id="td1" runat="server">
                                    <label id="DatabaseConnection" class="subtitle" runat="server">
                                        <telerik:RadCodeBlock ID="RadCodeBlock10" runat="server">
                                        <%=skResMgr.GlobalResourceSet.GetString("lookup_dbdbconn")%>
                                            </telerik:RadCodeBlock>
                                    </label>
                                    <br />
                                    <span class="description">
                                        <telerik:RadCodeBlock ID="RadCodeBlock9" runat="server">
                                        <%=skResMgr.GlobalResourceSet.GetString("lookup_dbdbconndesc")%>
                                            </telerik:RadCodeBlock>
                                        </span>
                                    

                                </td>
                                <td class="righttdbg" style="text-align:left">
                                    <asp:Panel ID="panel1" runat="Server">
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td class="lefttdbg" id="td3" runat="server">
                                    <label id="lblquery" class="subtitle" runat="server">
                                        <telerik:RadCodeBlock ID="RadCodeBlock11" runat="server">
                                        <%=skResMgr.GlobalResourceSet.GetString("lookup_dbdbquery")%>
                                            </telerik:RadCodeBlock>
                                    </label>
                                    <br />
                                    <span class="description">
                                        <telerik:RadCodeBlock ID="RadCodeBlock12" runat="server">
                                        <%=skResMgr.GlobalResourceSet.GetString("lookup_dbdbquerydesc")%>
                                        <br />
                                        <%=skResMgr.GlobalResourceSet.GetString("lookup_dbqueryexample")%>
                                        <br />
                                        <%=skResMgr.GlobalResourceSet.GetString("lookup_dbvaltabex")%>
                                            </telerik:RadCodeBlock>
                                        </span>

                                </td>
                                <td class="righttdbg" style="text-align:left">
                                    <textarea rows="6" cols="15" id="txtQuery" class="inputtextarea" style="width: 96%;" name="txtQuery"
                                        runat="server" isquery="1"></textarea>
                                    <span class="sf-formlabeldescription">
                                    </span>                        
                                </td>
                            </tr>
                             <tr>
                                <td class="lefttdbg" id="td2" runat="server">
                                    <label id="lblparameters" class="subtitle" runat="server">
                                        <telerik:RadCodeBlock ID="RadCodeBlock13" runat="server">
                                        <%=skResMgr.GlobalResourceSet.GetString("lookup_parameter")%>
                                            </telerik:RadCodeBlock>
                                    </label>
                                    <br />
                                    <span class="description">
                                        <telerik:RadCodeBlock ID="RadCodeBlock14" runat="server">
                                        <%=skResMgr.GlobalResourceSet.GetString("lookup_parameter_description")%>
                                            </telerik:RadCodeBlock>
                                        </span></td>
                                 <td class="righttdbg" style="text-align:left;padding-top:2px">
                                     <input runat="server" type="button"  title="" id="reloadParameters" onserverclick="ReloadParameters_ServerClick" class="inputbutton"  style="width:auto" value="Reload Parameters"  />
                                     <br />
                                    <asp:Panel ID="panelParametersDataType" runat="Server">
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td class="lefttdbg" id="td4" runat="server">
                                    <label id="lblvalue" class="subtitle" runat="server">
                                        <telerik:RadCodeBlock ID="RadCodeBlock15" runat="server">
                                        <%=skResMgr.GlobalResourceSet.GetString("lookup_dbdbval")%>
                                            </telerik:RadCodeBlock>
                                    </label>
                                    <br />
                                    <span class="description">
                                        <telerik:RadCodeBlock ID="RadCodeBlock16" runat="server">
                                        <%=skResMgr.GlobalResourceSet.GetString("lookup_dbdbvaldesc")%>
                                            </telerik:RadCodeBlock>
                                        </span></td>
                                <td class="righttdbg" style="text-align:left">
                                    <input type="text" name="txtKey" class="inputtext" value="" style="width: 96%;" maxlength="200" id="txtKey" runat="server"/>
                                    <span class="sf-formlabeldescription"> </span>
                                </td>
                            </tr>
                            <tr>
                                <td class="lefttdbg" id="td5" runat="server">
                                    <label id="DisplayName" class="subtitle" runat="server">
                                        <telerik:RadCodeBlock ID="RadCodeBlock17" runat="server">
                                        <%=skResMgr.GlobalResourceSet.GetString("lookup_dbdbdispname")%>
                                            </telerik:RadCodeBlock>
                                    </label>
                                    <br />
                                    <telerik:RadCodeBlock ID="RadCodeBlock18" runat="server">
                                    <span class="description"><%=skResMgr.GlobalResourceSet.GetString("lookup_dbdbdispnamedesc")%><br />
                                    <%=skResMgr.GlobalResourceSet.GetString("lookup_dbNameExample")%>
                                        </span>
                                        </telerik:RadCodeBlock></td>
                                <td style="text-align:left" class="righttdbg">
                                    <input type="text" name="txtDisname" class="inputtext" value="" style="width: 96%;"
                                        maxlength="200" id="txtDisname" runat="server"/>
                                    <span class="sf-formlabeldescription"> </span>
                                </td>
                            </tr>
                            <tr>
                                <td class="lefttdbg">
                                    <label id="Label1" class="subtitle" runat="server">
                                        <telerik:RadCodeBlock ID="RadCodeBlock19" runat="server">
                                        <%=skResMgr.GlobalResourceSet.GetString("lookup_dbdisvalueColinGrid")%>
                                            </telerik:RadCodeBlock>
                                    </label>
                                    <br />
                                    <telerik:RadCodeBlock ID="RadCodeBlock20" runat="server">
                                    <span class="description"><%=skResMgr.GlobalResourceSet.GetString("lookup_dbdisvalueColinGridDesc")%>
                                        </span>
                                        </telerik:RadCodeBlock>
                                </td>
                                <td class="righttdbg">
                                    <asp:RadioButtonList ID="radValueInGrid" runat="server" RepeatDirection="Horizontal" CssClass="inputradio" >
                                        <asp:ListItem Value="true" Selected="True"></asp:ListItem>
                                        <asp:ListItem Value="false"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                        </table>                            
                    </div>
                    <div id="FooterDiv" style="height:5%">
                        <table style="width:100%;border-width:0;margin:auto">
                            <tr>
                                <td style="text-align:right;vertical-align:middle;width:auto;height:30px;padding-right:10px">                                   
                                    <input type="hidden" id="connhidden" runat="server" name="connhidden" />  
                                    
                                    <input runat="server" type="button"  title="" id="btnTestConnection" onserverclick="btnValidateAndPreview_ServerClick" class="inputsecondarybutton"  style="width:auto" value="Test Connection"  />
                                        
                                    &nbsp;
                                    <input  type="submit" name="btnOK"  class="inputbutton" onserverclick="btnOK_ServerClick"
                                        runat="server" id="btnOK" />
                                        
                                </td>
                               
                            </tr>
                            <tr>
                                <td>
                                    <asp:Panel runat="server" id="gridViewPanel"></asp:Panel>
                                </td>
                            </tr>            
                        </table>        
                    </div>  
                    </telerik:RadAjaxPanel>
            </asp:panel>                
        </form>
    </div>
</body>
</html>
<script type="text/javascript">
    document.getElementById("txtName").focus();
</script>
<script type="text/javascript">
    function AddEventHandler(elementObject, eventName, functionObject)
    {
        if (document.addEventListener)
            elementObject.addEventListener(eventName, functionObject, false);
        else
            if (document.attachEvent)
                elementObject.attachEvent("on" + eventName, functionObject);
    }

    /* Resizing function is not required now everything inside commom table*/
    AddEventHandler(window, "resize", resizefunction);
    AddEventHandler(window, "load", resizefunction);

    function isNullOrUndefined(obj){
        return ((typeof obj === "undefined") || (obj == null));
    }

    function resizefunction()
    {
        var bodydiv = document.getElementById('BodyDiv');
        var headerdiv = document.getElementById('HeaderDiv');
        var footerdiv = document.getElementById('FooterDiv');
        var parentdiv = document.getElementById('ParentDiv');

        // While saving the lookup, it closes the window and internally this method is given
        // a call, wherein it throws an error while accessing parentdiv.offsetParent.offsetHeight
        // Hence we check on its presence here and proceed accordingly.
        if (isNullOrUndefined(parentdiv) || isNullOrUndefined(parentdiv.offsetParent))
        {
            return;
        }

        if (parentdiv.offsetParent == document.body)
        {
            document.body.style.height = '100%';
        }

        var parentdivheight = parentdiv.offsetParent.offsetHeight;
        // parentdiv.style.height = parentdivheight;
        try
        {
            //  bodydiv.style.height = parentdivheight - headerdiv.offsetHeight - footerdiv.offsetHeight; 
        } catch (e) { } //headerdiv.offsetHeight -
        bodydiv.style.width = '100%';
        bodydiv.style.width = parentdiv.clientWidth;
        //bodydiv.style.overflow = 'auto';
        parentdiv.style.overflow = 'hidden';
    }
    function scroll()
    {
        scrollPosition = document.getElementById('divbody').scrollTop;
    }
    function openPopup()
    {
        var u = "../../SkeltaForms/PopupWindow.aspx"
        var oWindow1 = window.open(u, 'popupwindow', 'top=100,left=100,height=' + parseInt(document.body.clientHeight / 2) + ',width=' + parseInt(document.body.clientWidth / 2) + ',resizable=no');
        return oWindow1;
    }
</script>
