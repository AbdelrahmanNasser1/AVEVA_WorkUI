<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.InfoPath.InfoPathProviderCodeFile" Theme="" StylesheetTheme="" %>

<%@ Register Assembly="Workflow.NET.Web.Designer.NET2" Namespace="Workflow.NET.Web.Designer" TagPrefix="cc1" %>
<%@ Register TagPrefix="cc2" Namespace="Workflow.NET.Ajax" Assembly="Workflow.NET.NET2" %>
<link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ProcessDesignerControl.GetCommonRelativeUrl("stylesheet/global.css"))%>">
<script src="<%=ProcessDesignerControl.GetJscriptUrl("../Common/javascripts/XmlTreeview.js")%>"></script>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<style>
    html, body {
        height: 100%;
        overflow: auto;
        overflow-x: hidden !important;
    }
</style>
<body>
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=cssPath %>CommonUXControls/StyleSheet/se.ui.min.css" />
    <script>
        se.ui.messageDialog.setGlobalOptions({
            localization: {
                closeButtonCaption: "<%=ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                okButtonCaption: "<%=ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
                cancelButtonCaption: "<%=ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                showDetailsCaption: "<%=ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                hideDetailsCaption: "<%=ProcessDesignerControl.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
            }
        });
    </script>
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <div style="height: 100%">
            <table width="100%" cellpadding="0" cellspacing="1" height="100%" border="0" class="tablebg">
                <tr>
                    <td class="lefttdbg" valign="top" align="center">

                        <table width="100%" cellspacing="0" cellpadding="0" border="0">
                            <tr>
                                <td>
                                    <img src="<%=ProcessDesignerControl.GetCommonRelativeUrl("images/spacer.gif")%>" border="0"></td>
                            </tr>
                            <tr>
                                <td class="lefttdbg" width="100%">
                                    <span class="subtitle"><%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlInfoPathXSN") %>   </span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table width="100%" cellspacing="1" cellpadding="1" border="0">
                                        <tr>
                                            <td class="lefttdbg">
                                                <table width="98%" cellspacing="0" cellpadding="0" border="0" align="center" style="visibility: hidden">
                                                    <tr>
                                                        <td class="lefttdbg" width="100%">
                                                            <asp:RadioButton ID="RadioButtonSource" GroupName="ChooseItem" runat="server" class="inputradio" />
                                                            <span class="subtitle"><%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariableSPSource") %></span>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" class="lefttdbg">
                                                <table width="100%" cellspacing="1" cellpadding="3" border="0" class="tablebg">
                                                    <tr>
                                                        <td class="lefttdbg" align="Left" width="20%">
                                                            <span class="description"><%=ProcessDesignerControl.GlobalResourceSet.GetString("XMLSiteURL") %></span>
                                                        </td>
                                                        <td class="righttdbg" width="30%" align="left" id="TDSharePoint" runat="server" valign="middle">
                                                            <asp:TextBox ID="SiteUrl" runat="server" ReadOnly="true" Width="135px" CssClass="inputtext"></asp:TextBox>
                                                            <asp:HiddenField ID="ListName" runat="server" />
                                                            <asp:HiddenField ID="ListId" runat="server" />
                                                            <asp:Image ID="imgButton" runat="server" border="0" align="absmiddle" />
                                                        </td>
                                                        <td class="lefttdbg" align="Left" width="20%">
                                                            <span class="description"><%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlLibraryForm")%></span>
                                                        </td>
                                                        <td class="righttdbg" width="43%" align="left" id="TD1" runat="server" valign="middle">
                                                            <asp:TextBox ID="FormLibrary" runat="server" ReadO3nly="true" CssClass="inputtext"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="lefttdbg" align="Left" width="195px" rowspan="2">
                                                            <span class="subtitle"><%=ProcessDesignerControl.GlobalResourceSet.GetString("XMLVariable")%><br />
                                                            </span>
                                                            <font class="description"><%=ProcessDesignerControl.GlobalResourceSet.GetString("MapDocument")%></font>
                                                        </td>
                                                        <td class="righttdbg" width="88%" colspan="3" align="left" id="TD3" runat="server" valign="top">
                                                            <span class="description">&nbsp;<%=ProcessDesignerControl.GlobalResourceSet.GetString("XMLSelectExistingVariable")%>&nbsp;&nbsp;<asp:DropDownList ID="cmbXmlVariables" runat="server" AutoPostBack="False" class="inputselect">
                                                            </asp:DropDownList>&nbsp;&nbsp;&nbsp;</span><span class="subtitle"><%=ProcessDesignerControl.GlobalResourceSet.GetString("(OR)")%></span>
                                                            <asp:HiddenField ID="txtRepositories" runat="server" />
                                                        </td>

                                                    </tr>
                                                    <tr>
                                                        <td class="righttdbg" width="100%" colspan="4" rowspan="2" align="left" id="TD2" runat="server" valign="top">
                                                            <span class="description">&nbsp;<%=ProcessDesignerControl.GlobalResourceSet.GetString("CreateXMLVariableSPlistforLibrary")%>
                                                            </span>
                                                            <input type="button" id="btnOpenXmlVariable" value="<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlvarCreate")%>" class="inputbutton" onclick="javascript:OpenXmlVariable();" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <input type="Hidden" id="txtNewXmlVariable" name="txtNewXmlVariable" />
                                                <table width="100%" cellspacing="1" cellpadding="1" border="0">

                                                    <tr>
                                                        <td class="lefttdbg">
                                                            <table cellpadding="2" cellspacing="0" width="100%" border="0">
                                                                <tr>
                                                                    <td class="lefttdbg" width="50%">
                                                                        <span class="subtitle"><%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariableSchema")%></span>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" id="SchemaButton" value="<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVarView")%>" class="inputbutton" onclick="javascript:ShowSchemaFrame();" />
                                                                    </td>
                                                                    <td class="lefttdbg" width="50%" align="right">
                                                                        <input type="button" id="Button1" value="<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVarRefreshSchema")%>" class="inputbutton" onclick="javascrpt:RefreshSchema();" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td width="100%" valign="top" colspan="2">
                                                                        <cc1:XmlSchemaDesigner ID="XmlSchemaDesigner1" Width="670px" Height="200px" IsSchemaEditable="false" runat="server" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>

                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <asp:HiddenField ID="SiteId" runat="server" />
                <asp:HiddenField ID="WebId" runat="server" />

                <tr class="lefttdbg">
                    <td align="right" valign="top">
                        <table cellpadding="1" cellspacing="1">
                            <tr>
                                <td align="right">
                                    <input type="button" id="btnCancel" value="<%=ProcessDesignerControl.GlobalResourceSet.GetString("ExpCancel")%>" class="inputsecondarybutton" onclick="javascript: WindowClose()" />
                                    &nbsp;&nbsp;    
                                    <input type="button" id="btnSave" value="<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlSaveVariable")%>" class="inputbutton" onclick="    javascript: CallServer()" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>

            </table>
        </div>
        <cc2:AjaxPageControl ID="AjaxPageControl1" runat="server" Style="z-index: 104; left: 440px; position: absolute; top: 88px"></cc2:AjaxPageControl>
    </form>
    <iframe id="XmlSchemaFrame" style="position: absolute; display: none; z-index: 101; border: 1px solid #256194;"></iframe>
    <div id="PropertyDiv" style="border: 1px solid #256194; display: none" />
</body>
</html>

<script>

    var XmlVariableLabel ="<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariable")%>";
    var XmlSchemaOK = "<%=ProcessDesignerControl.GlobalResourceSet.GetString("ExpOK")%>";
    var XmlSchemaCancel = "<%=ProcessDesignerControl.GlobalResourceSet.GetString("ExpCancel")%>";
    var XmlVariableName ="<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVarName")%>";
    var dIRIMAGES =   '<%=ProcessDesignerControl.GetCommonRelativeUrl()%>';
    var dIRIMAGES = dIRIMAGES + '/Images/';
    var closeImg = dIRIMAGES + "close.gif";

    function htmlencode(str) {
        var div = document.createElement('div');
        div.appendChild(document.createTextNode(str));
        return div.innerHTML;
    }

    function GetPlugInContent(plugInContent) {

        plugInContent = plugInContent.replace("|$|", "'");
        var content = plugInContent.split("#");
        if (content.length > 1) {

            var parentContent = content[0].split('~');

            document.getElementById("txtRepositories").value = parentContent[0];

            if (parentContent.length > 3) {
                if (parentContent[1].indexOf("}") > -1) {
                    document.getElementById("SiteUrl").value = parentContent[1].substring(parseInt(parentContent[1].indexOf("}")) + 1);
                    document.getElementById("SiteId").value = parentContent[1].substring(1, parseInt(parentContent[1].indexOf("}")));
                    document.getElementById("WebId").value = parentContent[2].substring(1, parseInt(parentContent[2].indexOf("}")));
                }
                else {
                    document.getElementById("SiteUrl").value = parentContent[1];
                }

                if (content[1].indexOf("}") > -1) {
                    document.getElementById("ListName").value = content[1].substring(parseInt(content[1].indexOf("}")) + 1);
                    document.getElementById("ListId").value = content[1].substring(1, parseInt(content[1].indexOf("}")));
                }
                else {
                    document.getElementById("ListName").value = content[1];
                }

                document.getElementById("FormLibrary").value = document.getElementById("ListName").value

                var parameterValue = document.getElementById("SiteId").value + "$" + document.getElementById("SiteUrl").value + "$" + document.getElementById("ListId").value + "$" + document.getElementById("ListName").value + "$" + document.getElementById("txtRepositories").value + "$" + document.getElementById("WebId").value;

                CallServerSideMethod(null, 'LoadTreeForList', "DataTableTest", CallbackLoadTreeForList, 'table', parameterValue);

            }
        }


    }

    var ListsComboInstance = "";//

    function CallServer() {
        //debugger;
        if (top.document.getElementById("variableName").value == "") {
            top.document.getElementById("variableName").focus();
            se.ui.messageDialog.showError('<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariables")%>', '<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariableEnterVariableName")%>');
        return false;
    }
    else {
        if (!CheckInputValue(top.document.getElementById("variableName").value)) {
            top.document.getElementById("variableName").focus();
            return false;
        }
    }

    if (trim(document.getElementById("SiteUrl").value) == "" || trim(document.getElementById("ListName").value) == "") {
        se.ui.messageDialog.showError('<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariables")%>', "Please select Form Library details from SharePoint Explorer");
        return false;
    }

    if (trim(document.getElementById("cmbXmlVariables").value) == "" && trim(document.getElementById("txtNewXmlVariable").value) == "") {
        se.ui.messageDialog.showError('<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariables")%>', "Please select existing Xml Variable OR enter new Xml Variable name for mapping to specific document");
            return false;
        }

        var xVariable = new XmlVariable();
        xVariable.VaraiableName = top.document.getElementById("variableName").value;
        xVariable.VaraiableDescription = top.document.getElementById("VarDescription").value;
        xVariable.EditMode = top.document.getElementById("HdnModeEdit").value;
        xVariable.ListName = document.getElementById("ListName").value;
        xVariable.SiteUrl = document.getElementById("SiteUrl").value;
        xVariable.ListId = document.getElementById("ListId").value;
        xVariable.SiteId = document.getElementById("SiteId").value;
        xVariable.WebId = document.getElementById("WebId").value;
        xVariable.WebApplicationId = document.getElementById("txtRepositories").value;



        if (trim(document.getElementById("cmbXmlVariables").value) != "") {
            xVariable.SelectedXmlVariableType = "Existing";
            xVariable.MappedXmlVariable = document.getElementById("cmbXmlVariables").value;
        }
        else {
            xVariable.MappedXmlVariable = document.getElementById("txtNewXmlVariable").value;
        }
        if (document.getElementById("RadioButtonSource").checked == true) {
            xVariable.SourceType = "SharePoint";
        }


        xVariable.XmlSchema = objTree.root;

        CallServerSideMethod(null, 'SaveVariable', "DataTableTest", CallbackSaveVariable, 'table', xVariable);
    }


    function WindowClose() {

        window.parent.close();
    }
    function XmlVariable() {
        this.VaraiableName = "";
        this.VaraiableDescription = "";
        this.SiteUrl = "";
        this.ListName = "";
        this.SiteId = "";
        this.ListId = "";
        this.ListItemType = "Current";
        this.WebApplicationId = "";
        this.MappedXmlVariable = "";
        this.SourceType = "SharePoint";
        this.Scope = "global";
        this.SelectedXmlVariableType = "New";
        this.WebId = "";
    }

    function RefreshSchema() {
        if (trim(document.getElementById("txtRepositories").value) != "") {
            var parameterValue = document.getElementById("SiteId").value + "$" + document.getElementById("SiteUrl").value + "$" + document.getElementById("ListId").value + "$" + document.getElementById("ListName").value + "$" + document.getElementById("txtRepositories").value + "$" + document.getElementById("WebId").value;
            CallServerSideMethod(null, 'LoadTreeForList', "DataTableTest", CallbackLoadTreeForList, 'table', parameterValue);
        }
    }


    function OpenXmlVariable() {
        // debugger;

        var innerHTMl = "";
        innerHTMl = "<table border=\"0\" width=\"100%\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" ID=\"Table7\">";
        innerHTMl = innerHTMl + "<tr>";
        innerHTMl = innerHTMl + "<td align=\"center\">";
        innerHTMl = innerHTMl + "<table border=\"0\" width=\"100%\" align=\"center\" cellpadding=\"4\" cellspacing=\"0\"  ID=\"Table8\">";
        innerHTMl = innerHTMl + "<tr >";
        innerHTMl = innerHTMl + "<td  class=\"fontheading\" align='left'><span class='fontheading'>" + XmlVariableLabel + "</span></td>";
        innerHTMl = innerHTMl + "<td  class=\"fontheading\" align='right'><a href=\"#\" onclick=\"javascript:CloseDiv()\"><img src=" + closeImg + " width=\"17\" height=\"17\" border=0 onClick=\"CloseDiv();\"/></a>";
        innerHTMl = innerHTMl + "</td>";
        innerHTMl = innerHTMl + "</tr>";
        innerHTMl = innerHTMl + "<tr>";
        innerHTMl = innerHTMl + "<td class='description'>";
        innerHTMl = innerHTMl + "&nbsp;";
        innerHTMl = innerHTMl + "</td>";
        innerHTMl = innerHTMl + "</tr>";

        innerHTMl = innerHTMl + "<tr>";
        innerHTMl = innerHTMl + "<td class=\"description\" >";
        innerHTMl = innerHTMl + "" + XmlVariableName + "";
        innerHTMl = innerHTMl + "</td>";
        innerHTMl = innerHTMl + "<td class=\"description\" style='text-align:right'>";
        var txtVal = "";
        if (trim(document.getElementById("txtNewXmlVariable").value) != "") {
            txtVal = trim(document.getElementById("txtNewXmlVariable").value);
        }
        innerHTMl = innerHTMl + "<input type=\"text\"  class=\"inputtext\" value=\"" + htmlencode(txtVal) + "\" id=\"txtVariablename\"/>";
        innerHTMl = innerHTMl + "</td>";
        innerHTMl = innerHTMl + "</tr>";
        innerHTMl = innerHTMl + "<tr>";
        innerHTMl = innerHTMl + "<td>";
        innerHTMl = innerHTMl + "&nbsp;";
        innerHTMl = innerHTMl + "</td>";
        innerHTMl = innerHTMl + "</tr>";
        innerHTMl = innerHTMl + "<tr>";
        innerHTMl = innerHTMl + "<td colspan=2 width=100%   >";
        innerHTMl = innerHTMl + "<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">";
        innerHTMl = innerHTMl + "<tr>";
        innerHTMl = innerHTMl + "<td width=\"100%\"   id=\"Td2\" align=\"right\">";
        innerHTMl = innerHTMl + "<input type=\"button\" id=\"btnCancel\" name=\"btnCancel\" value=\"" + XmlSchemaCancel + "\" onClick=\"CloseDiv();\" class=\"inputsecondarybutton\">&nbsp;";
        innerHTMl = innerHTMl + "<input type=\"button\" id=\"btnOk\" name=\"btnOk\" value=\"&nbsp;&nbsp;" + XmlSchemaOK + "&nbsp;&nbsp;\" onClick=\"javascript:CreateVariable();\" class=\"inputbutton\">&nbsp;";
        innerHTMl = innerHTMl + "</td>";
        innerHTMl = innerHTMl + "</tr>";
        innerHTMl = innerHTMl + "</table>";
        innerHTMl = innerHTMl + "</td>";
        innerHTMl = innerHTMl + "</tr>";
        innerHTMl = innerHTMl + "</table>";

        var proprObj = document.getElementById("PropertyDiv");
        proprObj.innerHTML = innerHTMl;
        proprObj.style.position = "absolute";
        proprObj.style.visibility = "visible";
        proprObj.style.display = "block";
        proprObj.style.left = 250 + 'px';
        proprObj.style.top = 5 + 'px';
        proprObj.style.width = 350 + 'px';
        proprObj.style.backgroundColor = "#ffffff";
        document.getElementById("txtVariablename").focus();
        document.getElementById("txtVariablename").focus();
        document.getElementById("txtVariablename").focus();

    }

    function CreateVariable() {
        if (trim(document.getElementById("txtVariablename").value) == "") {
            se.ui.messageDialog.showError('<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariables")%>', "Please enter Xml Variable");
            return false;
        }
        else {
            document.getElementById("txtNewXmlVariable").value = document.getElementById("txtVariablename").value;
            document.getElementById("PropertyDiv").style.display = "none";
        }
    }

    function CallbackSaveVariable(context, result, response) {
        var error;

        if ((result != null) && (result != "")) {
            error = result;
        }
        if (error != null) {
            if (error[0] == "ErrorReturned") {
                se.ui.messageDialog.showError('<%=ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("XmlVariables")%>', error[1]);
            return false;
        }
    }
    se.ui.messageDialog.showAlert('<%=ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("XmlVariables")%>', '<%=ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("XmlVariableSave")%>');

        top.refreshGrid(top.document.getElementById("variableName").value);

        /*if(document.getElementById('hidcheck').value!='1')
        {
              var browserCode=GetBrowserversion();
              
              if(browserCode=="1")
              { 
                  top.frames[0].location.reload(false);
              } 
           
        }*/
        //top.frames[0].history.go();*/
    }

    function LoadTreeForList() {

        var UrlValue = document.getElementById("URLText").value;

        if (UrlValue == "") {
            alert("Enter URL");
        }
        else {
            ListsComboInstance.RequestItems(UrlValue, false);
        }


    }

    function CloseIframe() {

        var frameel = document.getElementById("XmlSchemaFrame");
        frameel.style.display = "none";
        if (window.navigator.userAgent.indexOf('MSIE') > 0)
            window.location.reload();
        else
            window.location.assign(window.location.toString());

    }


    function HandleChangeLists(item) {

        var parameterValue = document.getElementById("URLText").value + "," + item.Text;

        CallServerSideMethod(null, 'LoadTreeForList', "DataTableTest", CallbackLoadTreeForList, 'table', parameterValue);

    }


    function CallbackLoadTreeForList(context, result, response) {

        if (result != null) {
            if (result[0] != null && result[0] != 'o') {
                se.ui.messageDialog.showError('<%=ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("XmlVariables")%>', result[1]);
            }
            else {
                var objTree = new jsTree;
                eval(result);
                document.getElementById("xmlTreeDiv").innerHTML = "";
                objTree.buildDOM();
                var strInnerHTML = document.getElementById("xmlTreeDiv").innerHTML;
                document.getElementById("xmlTreeDiv").innerHTML = strInnerHTML.replace("<DIV><DIV>", "");
            }
        }
    }


    function CheckInputValue(nodetext) {
        var retValue = true;

        var l = nodetext.length;

        for (var i = 0; i < l; i++) {
            var ch = nodetext.charAt(i);

            var errFlag = 0;
            switch (trim(ch)) {
                case "":
                    se.ui.messageDialog.showError('<%=ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("XmlVariables")%>', '<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariableVariableNamespace")%>');
                  errFlag = 2;
                  retValue = false;
                  break;

              case "$":
                  errFlag = 1;
                  break;

              case "\"":
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

              case "\\":
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
              se.ui.messageDialog.showError('<%=ProcessDesignerControl.ActionsDefinition.GlobalResourceSet.GetString("XmlVariables")%>', '<%=ProcessDesignerControl.GlobalResourceSet.GetString("XmlVariableVariableNamespecialchar")%>');
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

    function ShowSchemaFrame() {
        var frameel = document.getElementById("XmlSchemaFrame");
        frameel.style.left = 40;
        frameel.style.top = 35;
        frameel.style.width = 615;
        frameel.style.height = 320;
        frameel.style.display = "block";
        var loc = window.location.toString();
        loc = loc.replace("XmlInfoPath.aspx", "XmlFrame.aspx");
        frameel.src = loc;

    }
</script>

<%=spScripts%>