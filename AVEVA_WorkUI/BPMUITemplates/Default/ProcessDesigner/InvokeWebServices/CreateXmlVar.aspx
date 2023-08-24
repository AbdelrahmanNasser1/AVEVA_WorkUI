<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.InvokeWS.CreateXmlVar" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title><%=windowTitle%></title>
    <script type="text/javascript" >
        var parameterExists = 'N';
        function CloseWindow(xmlVarName)
        {
            if (xmlVarName !== '')
            {
                window.parent.CallServerFormRefresh(xmlVarName);
            }
            window.frameElement.radWindow.close();
        }
        function AlertDuplicate(xmlVarName) {
            se.ui.messageDialog.showError('<%=processDesigner.GlobalResourceSet.GetString("XmlVariables")%>', '<%=processDesigner.GlobalResourceSet.GetString("VariableexistsinvariableXmlvariableCollection")%>');
        }
        function MultipleLevelNotSupported(xmlVarName) {
            se.ui.messageDialog.showError('<%=processDesigner.GlobalResourceSet.GetString("XmlVariables")%>', '<%=processDesigner.GlobalResourceSet.GetString("WS_MultipleLevelNotSupported")%>', function () { CloseWindow(''); });
        }

        function AlertForXSSAttach() {
             se.ui.messageDialog.showError('<%=processDesigner.GlobalResourceSet.GetString("XmlVariables")%>', '<%=processDesigner.GlobalResourceSet.GetString("SilentInstallation_InvalidInputs")%>');
        }
        function ResizeWindow(flag)
        {
            var oWindow = null;
            if (window.radWindow)
                oWindow = window.radWindow;
            else if (window.frameElement.radWindow)
                oWindow = window.frameElement.radWindow;
            if (flag == 0)
            {
                oWindow.setSize(500, 160);
            }
            else
            {
                oWindow.setSize(500, 255);
            }
            return oWindow;
        }

        function CreateXml_ClientClick() {
            var xmlVarName = document.getElementById("textXmlVariableName").value;
            if (!CheckInputValue(xmlVarName)) {
                document.getElementById("textXmlVariableName").focus();
                return false;
            }
            return true;
        }

        function CheckInputValue(nodetext) {
            var retValue = true;

            var l = nodetext.length;

            for (var i = 0; i < l; i++) {
                var ch = nodetext.charAt(i);

                var errFlag = 0;
                switch (trim(ch)) {
                    case "":
                        se.ui.messageDialog.showError('<%=processDesigner.GlobalResourceSet.GetString("XmlVariables")%>', '<%=processDesigner.GlobalResourceSet.GetString("XmlVariableVariableNamespace")%>');
                    errFlag = 2;
                    retValue = false;
                    break;

                case "$":
                    errFlag = 1;
                    break;

                case "\"":
                    errFlag = 1;
                    break;

                case "\\":
                    errFlag = 1;
                    break;

                case "[":
                    errFlag = 1;
                    break;

                case ",":
                    errFlag = 1;
                    break;

                case "]":
                    errFlag = 1;
                    break;

                case "%":
                    errFlag = 1;
                    break;

                case "&":
                    errFlag = 1;
                    break;

                case "+":
                    errFlag = 1;
                    break;

                case ";":
                    errFlag = 1;
                    break;

                case ":":
                    errFlag = 1;
                    break;

                case "?":
                    errFlag = 1;
                    break;

                case "'":
                    errFlag = 1;
                    break;

                case "<":
                    errFlag = 1;
                    break;

                case ">":
                    errFlag = 1;
                    break;

                case "/":
                    errFlag = 1;
                    break;
                case "\\":
                    errFlag = 1;
                    break;
                case "@":
                    errFlag = 1;
                    break;

                case "#":
                    errFlag = 1;
                    break;
                    break;

                case "-":
                    errFlag = 1;
                    break;
                case "^":
                    errFlag = 1;
                    break;

                case "*":
                    errFlag = 1;
                    break;

                case "(":
                    errFlag = 1;
                    break;

                case ")":
                    errFlag = 1;
                    break;

                case "}":
                    errFlag = 1;
                    break;

                case "{":
                    errFlag = 1;
                    break;

                case ".":
                    errFlag = 1;
                    break;

            }

            if (errFlag == 1) {
                se.ui.messageDialog.showError('<%=processDesigner.GlobalResourceSet.GetString("XmlVariables")%>', '<%=processDesigner.GlobalResourceSet.GetString("XmlVariableVariableNamespecialchar")%>');
                retValue = false;
                break;
            }
            else if (errFlag == 2) {
                retValue = false;
                break;
            }

        }
        return retValue;
    }

    function ltrim(s) {
        return s.replace(/^\s*/, "");
    }

    function rtrim(s) {
        return s.replace(/\s*$/, "");
    }

    function trim(s) {
        return rtrim(ltrim(s));
    }
    </script>
</head>
<body>
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(themePath) %>CommonUXControls/StyleSheet/se.ui.min.css" />      
    <script>
        se.ui.messageDialog.setGlobalOptions({
            localization: {
                closeButtonCaption: "<%=globalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                okButtonCaption: "<%=globalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
                cancelButtonCaption: "<%=globalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                showDetailsCaption: "<%=globalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                hideDetailsCaption: "<%=globalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
            }
        });
    </script>
    <form id="form1" runat="server">
	<%=System.Web.Helpers.AntiForgery.GetHtml()%>
                <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(themePath)%>Common/StyleSheet/Global.css" />
        <div>
            <table style="width: 98%; margin: 0px auto; border-collapse: separate; border-spacing: 0px;" class="tablebg" border="0">
                <tr>
                    <td class="lefttdbg" style="width: 40%; padding: 6px;padding-top:25px">
                        <asp:Label ID="lbllstlooknameId" runat="server"><span class="subtitle">
                            <%= globalResourceSet.GetString("WebAPIActivity_PropertyPage_CreateXml_VariableName")%></span><img alt="Mandatory" id="mandatoryLookUpName" src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(themePath)%>Skeltaforms/Images/mandatoryicon.png" hspace="2" align="top" visible="true" />
                            <asp:RequiredFieldValidator ID="lookupValidator" runat="server" Display="Dynamic"
                                SetFocusOnError="True" ControlToValidate="textXmlVariableName" CssClass="errortext"><img id="imgLookupNameError" alt="<%=globalResourceSet.GetString("splookup_ValidateTitle")%>" src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(themePath)%>skeltaforms/Images/erroricon.png" hspace="2" align="top" />
                            </asp:RequiredFieldValidator>
                        </asp:Label>
                    </td>
                    <td class="righttdbg" style="padding: 6px;padding-top:25px">
                        <asp:TextBox ID="textXmlVariableName" CssClass="inputtext" MaxLength="50" Width="100%" runat="server" />
                    </td>
                </tr>
            </table>
        </div>
        <div id="divfooter" style="padding-top:10px;">
            <table style="width: 98%; margin: 0px auto;" border="0">
                <tr>
                            
                    <td style="width: 30%; text-align: right; padding-right: 10px;padding-top:10px;">
                        <asp:Button runat="server" Text="Create" ID="buttonCreateXmlVariable" CssClass="inputbutton" OnClientClick="return CreateXml_ClientClick();"/>
                                
                    </td>
                </tr>
                        
            </table>
        </div>
    </form>
</body>
</html>
