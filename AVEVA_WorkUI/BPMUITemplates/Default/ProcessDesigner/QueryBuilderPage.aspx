<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.PropertyTypes.QueryBuilderPage" %>

<%@ Register Assembly="Workflow.NET.Web.Designer.NET2" Namespace="Workflow.NET.Web.Designer"
    TagPrefix="cc1" %>
<%@ Assembly Name="Workflow.NET.Web.Designer.NET2" %>
<%@ Register TagPrefix="cc2" Namespace="Workflow.NET.Ajax" Assembly="Workflow.NET.NET2" %>
<%@ Import Namespace="Workflow.NET.Web.Designer" %>
<%@ Assembly Name="Workflow.NET.NET2" %>
<%@ Import Namespace="Workflow.NET" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>
        <%= sr.GetString("DB_Activity")%>
        -<%= sr.GetString("DB_Query Builder")%>
    </title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link href="<%=processDesignerControl.GetCommonRelativeUrl("Stylesheet/global.css")%>"
        rel="stylesheet" type="text/css" />
    <link href="Stylesheet/global.css" rel="stylesheet" type="text/css" />
    <style>
        html, body {
            height: 100%;
            width: 99%;
            overflow: hidden;
        }
        </style>
</head>
<body id="body1" onload = "changeScreenSize(900,755)" onunload="HandleClose()" style="margin:10px">
    <script>
        se.ui.messageDialog.setGlobalOptions({
            localization: { // All localization related default can be set
                closeButtonCaption: "<%=sr.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                okButtonCaption: "<%=sr.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                cancelButtonCaption: "<%=sr.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                showDetailsCaption: "<%=sr.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                hideDetailsCaption: "<%=sr.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
            }
        });
    </script>
    <script type="text/javascript">
        function test() {
            var proprObj = document.getElementById('divSchema');
            proprObj.style.position = "absolute";
            proprObj.style.display = "block";
            proprObj.style.left = 250 + 'px';
            proprObj.style.top = 120 + 'px';
            proprObj.style.width = 330 + 'px';
        }
    </script>
    <form id="form1" runat="server" style="height:100%;overflow:hidden;">
        <link href="<%=bellyBarPath%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <div style="height:12%;">
         <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr valign="top">
                        <td class="fontheading" valign="middle">
                                <%= sr.GetString("DB_Build_Query", true)%>
                        </td>
                        <td >
                            <span title="Help">
                                <img src="<%=processDesignerControl.GetCommonRelativeUrl("Images/main-help.gif")%>"
                                    align="right" <%=helpImageTags%> style="cursor: pointer" alt="Help" />
                            </span>
                        </td>
                    </tr>
                </table>
                <br />
                <span class="description">
                    <%=sr.GetString("DB_Descr", true)%>
                </span>
                <br />
                
        </div>
        <div style="overflow:auto;height:76%;">
    <table border="0" cellpadding="0" cellspacing="1" width="100%" style="height:80%;">
        <tr>
            <td valign="top">
              
                <table  border="0" cellpadding="5" cellspacing="2" class="tablebg">
                    <tr>
                        <td class="lefttdbg" style="width: 38%">
                            <span class="subtitle">
                                <%= sr.GetString("DB_CmdType", true)%>
                            </span>
                            <br />
                            <span class="description">
                                <%=sr.GetString("DB_CmdTypeDescr", true)%>
                            </span>
                        </td>
                        <td class="righttdbg">
                            <asp:DropDownList ID="drpdwnCommandType" runat="server" Height="20px" Width="160px" onchange="EnableParameter()"
                                CssClass="inputselect">
                            </asp:DropDownList>
                            <br />
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" class="lefttdbg">
                            <span class="subtitle">
                                <%= sr.GetString("DB_EntQuery", true)%>
                            </span>
                            
                            <br />
                            <span class="description">
                                <%=sr.GetString("DB_QueryDescr")%>
                                <br />
                                <%=sr.GetString("DB_QueryDescrEx")%>
                                <br />
                                <%=sr.GetString("DB_QuSPDescr")%>
                                <br />
                                <%=sr.GetString("DB_QuFunDescr")%>
                                <%=sr.GetString("DB_QuFunEx")%>
                                </span>
                                <br />  
                                <br />                            
                                <span class ="subtitle">
                                 <%=sr.GetString("DB_ParamHead")%>
                                  </span>                              
                                <br />                                
                               <span class="description">
                                  <%=sr.GetString("DB_ParamTypeDesc")%>
                                  <br />
                                <%=sr.GetString("DB_ParamDescr")%>
                            </span>
                        </td>
                        <td class="righttdbg" style="vertical-align:top">
                            <table style="vertical-align:top;text-align:left" cellpadding="0" cellspacing="0" border="0" >
                                <asp:HiddenField ID="hidQuery" runat="server" />
                                <asp:HiddenField ID="hidQuery2" runat="server" />
                                <tr>
                                    <td align="justify" style="margin-top: 0px;">
                                        <table style="vertical-align:top;text-align:left" cellpadding="3" cellspacing="0" >
                                            <tr>
                                                <td><span style="width: 366px; display: inline-block"></span></td>
                                                <td>
                                                    <img alt="" src="<%=processDesignerControl.GetCommonRelativeUrl("Images/Expression-icon.gif")%>"
                                                        onclick="openEditor('<%=txtQuery.ClientID %>','<%=hidQuery.ClientID %>','<%=hidQuery2.ClientID %>','<%=imageDeleteButton.ClientID %>')"
                                                        title="<%=sr.GetString("ExpExpressionEditor",true)%>" style="visibility :visible;" id="queryExpEditor" />
                                                    &nbsp;
                                                    <asp:ImageButton ID="imageDeleteButton" runat="server" Height="12px" Width="12px" Style="visibility: hidden" />
                                                    <asp:ImageButton ID="imageDeleteButton1" runat="server" Height="12px" OnClick="ImageDeleteButton_Click"
                                                    Width="12px" Style="display:none" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <asp:TextBox ID="txtQuery" runat="server" TextMode="MultiLine" CssClass="inputtextarea"
                                            Height="130px" Width="386px" onchange="javascript:DisableViewSchema();"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2"><span style="width: 266px; display: inline-block"></span><asp:Button ID="btnParameters" runat="server" CssClass="inputbutton" OnClick="BtnParameters_Click" Enabled="true" /></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <table width="100%" border="0">
                                <tr>
                                    <td style="width: 29%" class="descriptionbold"  align ="left">
                                        <span class="descriptionbold">
                                            <asp:Label ID="lblParameter" runat="server" Text="Parameter"></asp:Label>
                                        </span>
                                    </td>
                                    <td style="width: 28%" class="descriptionbold" align="left" >
                                     <span class="descriptionbold">
                                      <asp:Label ID="lblParameterType" runat="server" Text="Type"></asp:Label>
                                      </span>
                                    </td>
                                    <td style="width: 36%" class="descriptionbold" align="left">
                                        <span class="descriptionbold">
                                            <asp:Label ID="lblValue" runat="server" Text="Value"></asp:Label></span>
                                    </td>
                                </tr>
                            </table>
                            <div>
                             <asp:Table ID="parametersTable" runat="server">
                             </asp:Table>
                            </div>
                        </td>
                    </tr>
                    <tr id="spExecute">
                        <td class="lefttdbg" id="t1" >
                            <span class="subtitle">
                                <%= sr.GetString("DB_CheckParameter", true)%>
                            </span>
                            <br />
                            <span class="description">
                                <%=sr.GetString("DB_CheckParameter_Descript")%>
                            </span>
                        </td>
                        <td class="righttdbg" id="t2">
                            <asp:CheckBox ID="checkParameter" runat="server"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="lefttdbg">
                            <span class="subtitle">
                                <%= sr.GetString("DB_OpXml", true)%>
                            </span>
                            <br />
                            <span class="description">
                                <%=sr.GetString("DB_OpXmlDescr")%>
                            </span>
                        </td>
                        <td class="righttdbg">
                            &nbsp;<asp:TextBox ID="txtXmlVariableName" runat="server" Width="160px" CssClass="inputtext"
                                MaxLength="30"></asp:TextBox>
                            &nbsp;&nbsp; &nbsp;
                            <asp:Button ID="ViewSchema" runat="server" CausesValidation="false" OnClick="ViewSchema_Click"
                                 Enabled="false" CssClass="inputbutton" />
                            <div id="divSchema" runat="server" style="display: none;">
                                <table class="tdbg">
                                    <tr>
                                        <td align="right">
                                            <img alt="" src="<%=processDesignerControl.GetCommonRelativeUrl("Images/close.gif")%>"
                                                onclick="document.getElementById('divSchema').style.display='none'" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <cc1:xmlschemadesigner id="xmlSchemaDesigner" width="450px" height="185px" runat="server"
                                                visible="false" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>
              
            </td>
        </tr>
    </table>
       </div>
        <div style="height:12%;padding-top:5px;">
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
            <tr>
                <img id="Img1" runat="server" src="<%$ ReplaceTemplateExpn:/Common/Images/icon-note.png%>"
                    align="absmiddle">
                <span class="note">
                    <%=sr.GetString("DB_Note")%>
                </span>
                <br />
            </tr>
                            <tr>
                                
                                <td style="text-align:right;">
                                    <asp:Button ID="CloseButton" runat="server" OnClick="CloseButton_Click" CssClass="inputsecondarybutton" />
                                    &nbsp;<asp:Button ID="ClearButton" runat="server" Enabled="false" CssClass="inputsecondarybutton"/>
                                    <asp:Button ID="ClearButton1" runat="server"  CssClass="inputsecondarybutton"
                                        OnClick="ClearButton_Click" Style="display: none"  />
                                    <asp:Button ID="Submit" runat="server" OnClick="Submit_Click" CssClass="inputbutton" />
                                    
                                </td>
                            </tr>
                        </table>
            </div>
    <asp:HiddenField ID="hiddenNoOfRows" runat="server" />
    <input id="hidRowSelectedNo" type="hidden" name="hidRowSelectedNo" />
    <input id="hidTextboxValue" type="hidden" name="hidRowSelectedNo" />
    <input id="hidRowWithActualValue" type="hidden" name="hidRowWithActualValue" />
    <input id="hidImage" type="hidden" name="hidImage" />
    <input id="hidImageExpression" type="hidden" name="hidImageExpression" />
    </form>
</body>
</html>
<script type="text/javascript">
    var expbuilderURl = "<%=expbuilderURl%>";
    function changeScreenSize(w, h)
    {
        EnableParameter();
        if (navigator.userAgent.indexOf("MSIE 10") > 0 || isIE11())
        {
            //do nothing
        }
        else
        {
            window.resizeTo(w, h);
        }
        document.getElementById("body1").style.overflow = "auto";

        if (document.getElementById('hidQuery2').value != "") {

            document.getElementById('imageDeleteButton').style.visibility = "visible";
        }

    }

    
    function isIE11() { 
        return !!navigator.userAgent.match(/Trident.*rv[ :]*11\./); 
    }
    
    
    /// <summary>
    /// Shows the schema of the xml variable created
    /// </summary>
    function ViewXmlSchema() {

        var proprObj = document.getElementById("<%=divSchema.ClientID%>");
        proprObj.style.position = "absolute";
        proprObj.style.visibility = "visible";

        proprObj.style.display = "block";
        proprObj.style.left = 300 + 'px';
        proprObj.style.top = 120 + 'px';
        proprObj.style.width = 330 + 'px';


    }

    /// <summary>
    /// Disables the 'View Schema' Button when query is edited.
    /// </summary>
    function DisableViewSchema() {
        document.getElementById("ViewSchema").disabled = true;
    }

    /// <summary>
    /// Opens the Expression editor
    /// </summary>
    function openEditor(clientQueryTextbox, clientIdhidRHS, clientTxtValue, clientHidImg) {

        document.getElementById('hidRowSelectedNo').value = clientQueryTextbox;
        document.getElementById('hidRowWithActualValue').value = clientIdhidRHS;
        document.getElementById('hidTextboxValue').value = clientTxtValue;
        document.getElementById('hidImage').value = clientHidImg;
        expbuilderURl = expbuilderURl.replace("QueryBuilderPage.aspx", "ExpressionEditor.aspx");
        window.open(expbuilderURl + "&RHS=" + clientIdhidRHS, "_default", "status=no,width=830,height=500,top=100");

    }
    /// <summary>
    /// Sets the value from the expression editor to the corresponding text box
    /// </summary>
    function setExpression(exprnvalue) {
        if (exprnvalue != "") {
            document.getElementById(document.getElementById('hidImage').value).style.visibility = "visible";
        }

        document.getElementById(document.getElementById('hidRowWithActualValue').value).setAttribute("value", exprnvalue);
        var valueExpr = exprnvalue;
        var str1 = valueExpr.replace(/["{}]/gi, "").split(/\n/g)
        for (i = 0; i < str1.length; i++) {
            var str2 = str1[i].split(':');
            if (str2[0] == "DisplayExpressionString") {
                var newExprn = str2[1];
                newExprn = ltrim(newExprn);
                break;
            }
        }
        newExprn = newExprn.replace('\\', ' ');
        var pos = newExprn.indexOf('\\');
        if (pos >= 0) {
            newExprn = newExprn.replace('\\', ' ');
            var k = newExprn.lastIndexOf(',');
            newExprn = setChAt(newExprn, k, '');
            newExprn = newExprn.replace(/_x002B_/g, "+");
            newExprn = newExprn.replace(/_x002D_/g, "-");
            newExprn = newExprn.replace(/_x002F_/g, "/");
            newExprn = newExprn.replace('//', ' ');
            newExprn = newExprn.replace('"', ' ');
            document.getElementById(document.getElementById('hidRowSelectedNo').value).setAttribute("value", newExprn);
            document.getElementById(document.getElementById('hidTextboxValue').value).setAttribute("value", newExprn);
            document.getElementById(document.getElementById('hidRowSelectedNo').value).value = newExprn;
            document.getElementById(document.getElementById('hidTextboxValue').value).setAttribute("title", newExprn);
            document.getElementById(document.getElementById('hidRowSelectedNo').value).disabled = true;
            document.getElementById("btnParameters").disabled = false;


        }
        else {
            var k = newExprn.lastIndexOf(',');
            newExprn = setChAt(newExprn, k, '');
            document.getElementById(document.getElementById('hidRowSelectedNo').value).setAttribute("value", newExprn);
            document.getElementById(document.getElementById('hidRowSelectedNo').value).disabled = true;
            document.getElementById(document.getElementById('hidRowSelectedNo').value).value = newExprn;
            document.getElementById(document.getElementById('hidTextboxValue').value).setAttribute("value", newExprn);
        }        
    }

    function setChAt(str, index, chr) {
        if (index > str.length - 1) return str;
        return str.substr(0, index) + chr + str.substr(index + 1);
    }
    function ltrim(s) {
        return s.replace(/^\s*/, "");
    }
    function HandleClose() {
        var i = "<%=internalStorage%>";
        i = 0;

        window.setTimeout('window.opener.refreshselectedaction()', 100);
        window.opener.parent._skProcessDesigner.RefreshProperties();
        window.setTimeout('window.close()', 100);

    }
    function OpenHelpWin(page, winproperties) {
        if (winproperties.indexOf('resizable') < 0)
            winproperties = winproperties + ',resizable=yes';
        if (winproperties.indexOf('scrollbars') < 0)
            winproperties = winproperties + ',scrollbars=yes';
        window.open(page, 'helpPage', winproperties);
    }

    /// <summary>
    /// Clears the expression from the textbox
    /// </summary>
    function clearExpression(clientTxtValue, clientIdhidRHS, clientImg) {
        
        se.ui.messageDialog.showConfirmation('<%= sr.GetString("DB_Activity")%>', '<%= sr.GetString("DB_ClearParamValue")%>', function (conf)
        {            
            if (conf)
            {
                document.getElementById(clientTxtValue).value = "";
                document.getElementById('hidRowSelectedNo').value = clientTxtValue;
                document.getElementById('hidRowWithActualValue').value = clientIdhidRHS;
                document.getElementById('hidImageExpression').value = clientImg;
                document.getElementById(document.getElementById('hidRowSelectedNo').value).setAttribute("value", "");
                document.getElementById(document.getElementById('hidRowSelectedNo').value).setAttribute("title", "");
                document.getElementById(document.getElementById('hidRowWithActualValue').value).setAttribute("value", "");
                document.getElementById(document.getElementById('hidRowSelectedNo').value).disabled = false;
                document.getElementById(document.getElementById('hidImageExpression').value).style.visibility = "hidden";                
            }
        });
        return false;
    }

    function EnableParameter()
    {
        switch (document.getElementById("drpdwnCommandType").selectedIndex)
        {
            case 0:
                document.getElementById("checkParameter").disabled = true;
                document.getElementById("queryExpEditor").style.visibility = "visible";
                break;
            case 1:
                document.getElementById("checkParameter").disabled = false;
                document.getElementById("queryExpEditor").style.visibility = "hidden";
                break;
            case 2:
                document.getElementById("checkParameter").disabled = true;
                document.getElementById("queryExpEditor").style.visibility = "hidden";
                break;
        }
    }
        
</script>
