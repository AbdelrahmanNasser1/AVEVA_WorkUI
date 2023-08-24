<%@ Page Language="C#" AutoEventWireup="true" EnableViewState="true" EnableEventValidation="false" Inherits="Skelta.Forms.Web.CodeBehind.DynamicOrderByBuilder" 
    CodeFile="DynamicOrderByBuilder.aspx.cs"%>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!Doctype html>
<html>
<head runat="server">
    <title><%=resManager.GetString("LookupOrderByQueyTitleText")%></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    
    <script type="text/javascript">
        function GetRadWindow() {
            var oWindow = null;
            oWindow = window.frameElement.radWindow;
            return oWindow;
        }

        function setValues(squery) {
            var oWindow = GetRadWindow();
            oWindow.close(squery);
        }

        function SetQueryText(QueryText) {
            setValues(QueryText);
        }
        function LoadLastValues() {
            var textArea = document.getElementById("orderByQuery");
            var hdnQuery = document.getElementById("hdnOrderByQuery");
            textArea.value = window.parent.document.getElementById("hdnDisplayOrderByQuery").value;
            hdnQuery.value = window.parent.document.getElementById("hdnActualOrderByQuery").value;
        }     
    </script>

</head>
<body style="overflow: hidden" onload="LoadLastValues();">
	<script src="<%=JSPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>CommonUXControls/StyleSheet/se.ui.min.css"  rel="stylesheet" type="text/css" /> 
    <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>Common/StyleSheet/Global.css" />
    
    <script>
        se.ui.messageDialog.setGlobalOptions({
             localization: {
                 closeButtonCaption: "<%=resManager.GetString("se_ui_messagedialog_close_caption") %>",
                 okButtonCaption: "<%=resManager.GetString("se_ui_messagedialog_ok_caption") %>",
                 cancelButtonCaption: "<%=resManager.GetString("se_ui_messagedialog_cancel_caption") %>",
                 showDetailsCaption: "<%=resManager.GetString("se_ui_messagedialog_showdetails_caption") %>",
                 hideDetailsCaption: "<%=resManager.GetString("se_ui_messagedialog_hidedetails_caption") %>"
             }
         });

         function DisplayErrorMessage(message) {

             se.ui.messageDialog.showError("<%=resManager.GetString("LookupOrderByQueyTitleText")%>", message);
        }

        function DisplaySuccessMessage(message) {

            se.ui.messageDialog.showAlert("<%=resManager.GetString("LookupOrderByQueyTitleText")%>", message);
        }

    </script>

    <form id="frmDynamicOrderByBuilder" runat="server">
         <telerik:RadScriptBlock ID="RadScriptBlock2" runat="server">
        <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>TelerikAjax/StyleSheet/AWTTreeView/TreeView.AWTTreeView.css" />
        <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css" />
        <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css" />
         </telerik:RadScriptBlock>
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"/>
        <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
            </telerik:RadScriptBlock>
        <telerik:RadAjaxPanel ID="radAjaxPanel" runat="server" EnableAJAX="true">
            <telerik:RadCodeBlock runat="server" ID="RadCodeBlock1">
           <div class="sf-formbackground" id="divparent" runat="server">
            <div style="border: Solid 2px #ccc; display: none; z-index: 400; top: 0; left: 0"
                id="divTree" runat="server" class="lefttdbg">
                <table style="border-width:0;width:100%">
                    <tr>
                        <td style="text-align:right" class="righttdbg">
                            <a id="aCloseDiv" onclick="CloseDiv()">
                                <img alt="" style="border: 0" src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>Common/Images/close.gif" /></a>
                        </td>
                    </tr>
                </table>
                <telerik:RadTreeView ID="RadTreeViewDisplay" EnableEmbeddedSkins="false" runat="server" Height="100px" EnableViewState="true"  Skin="AWTTreeView" >
                </telerik:RadTreeView>            
            </div>
            <table style="height: 100%; width: 100%" >
                <br />
                <tr id="headerRow" style="height: 10%; vertical-align: top; width: 100%">
                    <td class="lblDescriptionStyle" style="padding-left:25px;" >
                       <img style="vertical-align:middle" alt="" src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>Repository/ListControl/images/icons-ribbon/lookupsklist.png"/> <%=resManager.GetString("LookupOrderByQueyHeadingText")%>
                    </td>
                </tr>
                <tr id="contentRow" style="height: 80%; vertical-align: top; width: 100%">
                    <td>
                        <table style="vertical-align: top; width: 100%;height:100%;border-spacing:10px;padding-left:50px;padding-right:50px;">
                            <tr style="width:100%;">
                                <td class="lblNameStyle" style="width:70%;">
                                    <%=resManager.GetString("dqb_Table")%>
                                </td>
                                <td style="width:70%;">
                                    <input type="text" onclick="OpenTableStructure('OrderBy');" id="RadOrderByText" runat="server"
                                        readonly="readonly" style="width: 180; height: 18" class="txtboxStyle" value="Click here" />
                                    <input type="hidden" id="hdnTableType" runat="server" />
                                    <input type="hidden" id="hdnListName" runat="server" />
                                    <input type="hidden" id="hdnDisplayColumnTable" runat="server" />
                                    <input type="hidden" id="hdnDisplayColumn" runat="server" />
                                    <input type="hidden" id="hdnDisplayColumnName" runat="server" />
                                </td>
                            </tr>
                            <tr style="width:100%;">
                                <td class="lblNameStyle" style="width:70%;">
                                    <%=resManager.GetString("dqb_Column")%>
                                </td>
                                <td style="width:70%;">
                                    <telerik:RadComboBox ID="RadOrderByColumnName" EnableEmbeddedSkins="false" runat="server" Height="100" Skin="AWTCombobox">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr style="width:100%;">
                                <td class="lblNameStyle" style="width:70%;">
                                    <%=resManager.GetString("dqb_Sort")%>
                                </td>
                                <td style="width:70%;">
                                     <telerik:RadComboBox ID="RadOrderByAscDsc" EnableEmbeddedSkins="false" runat="server" Height="60" Skin="AWTCombobox">
                                    </telerik:RadComboBox>
                               </td>
                            </tr>
                            <tr style="width:100%;">
                                <td style="width:100%;" colspan="2">
                                    <textarea id="orderByQuery" value="" cols="0" rows="8" runat="server" readonly="readonly"
                                        style="width: 100%;height:90px" class="txtareaStyle" />
                                    <input type="hidden" runat="server" id="hdnOrderByQuery" />
                                </td>
                            </tr>
                        </table>
                        <div class="lineCss" style="width:92%;margin-left:20px;border-bottom-width: 0px;"></div>
                    </td>
                </tr>
                <tr id="footerRow" style="height: 10%; width: 100%; vertical-align: top">
                    <td style="text-align:right;width:100%;padding-top:10px;padding-bottom:20px;" colspan="2">
                        <input id="btnClear" runat="server" type="button" value="Clear" class="inputsecondarybutton" onclick="ClearTextArea();" style="margin-right:6px;" />
                        <input id="btnCancel" type="button" value="Cancel" runat="server" onclick="closeWin();"  class="inputsecondarybutton" style="margin-right:6px;" />
                        <input id="btnAdd" runat="server" type="button" value="Add" class="inputbutton" onclick="AddToTextArea();" style="margin-right:6px;" />
                        <input id="btnSave" type="button" value="Save" runat="server" onclick="UpdateParent();" class="inputbutton" style="margin-right:16px;" />
                    </td>
                </tr>
            </table>
        </div>
                 </telerik:RadCodeBlock>
   </telerik:RadAjaxPanel>
    </form>
</body>
</html>

<script  type="text/javascript">
    function OpenTableStructure(obj) {
        var hdnTableType = document.getElementById("<%=hdnTableType.ClientID%>");
        hdnTableType.value = obj;
        ToggleMax(obj);
    }
    function ToggleMax(obj) {
        var DivTree = document.getElementById("<%=divTree.ClientID%>");
        DivTree.style.display = "block";

        DivTree.style.position = "absolute";

        DivTree.style.left = '190px'; //340 + 'px';
        DivTree.style.top = '80px'; //250 + 'px';
        DivTree.style.width = 250 + 'px';
        DivTree.style.height = 100 + 'px';


        var RadTree = document.getElementById("<%=RadTreeViewDisplay.ClientID%>");
        RadTree.style.height = DivTree.style.height;
    }

    function CloseDiv() {
        var DivTree = document.getElementById("<%=divTree.ClientID%>");
        divTree.style.display = "none";
    }
    function NodeClick(node) {
        var RadOrderByText = document.getElementById("<%=RadOrderByText.ClientID%>");
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
        RadOrderByText.value = NodeText;
        CloseDiv();
    }
    function AddToTextArea() {
       
        var textArea = document.getElementById("orderByQuery");
        var hdnQuery = document.getElementById("hdnOrderByQuery");

        if (textArea.value == "") {
            //Append Order By
            textArea.value = "Order By ";
            hdnQuery.value = "Order By ";
            var tableText = document.getElementById("<%=RadOrderByText.ClientID%>");
            if (tableText.value == "<%=resManager.GetString("LookupOrderByQueyClickHereText") %>") {
                textArea.value="";
                hdnQuery.value="";
                DisplayErrorMessage("<%=resManager.GetString("LookupOrderByQueyAlert1Text") %>")
                return;
            }
            textArea.value += tableText.value;

            var columnNameDD = $find('<%= RadOrderByColumnName.ClientID %>').get_value();
            if (columnNameDD.indexOf('.') != -1) {
                var columninfo = columnNameDD.split('.');
                var info = columninfo[1].split('$');
                var aliasId = columninfo[0].split('`');
                textArea.value += "(" + aliasId[0] + ")." + info[0];
                hdnQuery.value += info[1];
            }
            var orderType = $find('<%= RadOrderByAscDsc.ClientID %>').get_value();
            textArea.value += " " + orderType;
            hdnQuery.value += " " + orderType;

        }
        else {

            var tableText = document.getElementById("<%=RadOrderByText.ClientID%>");
            if (tableText.value == "<%=resManager.GetString("LookupOrderByQueyClickHereText") %>") {
                DisplayErrorMessage("<%=resManager.GetString("LookupOrderByQueyAlert1Text") %>")
                return;
            }
            
            var columnNameDD = $find('<%= RadOrderByColumnName.ClientID %>').get_value();
            if (columnNameDD.indexOf('.') != -1) {                
                var columninfo = columnNameDD.split('.');
                var info = columninfo[1].split('$');
                var aliasId = columninfo[0].split('`');
                if(textArea.value.indexOf(tableText.value+"("+ aliasId[0]+")."+info[0])==-1)
                {
                    textArea.value += ", " + tableText.value;
                    textArea.value += "(" + aliasId[0] + ")." + info[0];
                    hdnQuery.value += "," + info[1];
                }
                else
                {
                   // alert("<%=resManager.GetString("LookupOrderByQueySameOrderColumnText") %>");
                    DisplayErrorMessage("<%=resManager.GetString("LookupOrderByQueySameOrderColumnText") %>")
                    return;
                }
            }
            var orderType = $find('<%= RadOrderByAscDsc.ClientID %>').get_value();
            textArea.value += " " + orderType;
            hdnQuery.value += " " + orderType;
        }


    }
    function ClearTextArea() {

        var textArea = document.getElementById("orderByQuery");
        var hdnQuery = document.getElementById("hdnOrderByQuery");
        textArea.value = "";
        hdnQuery.value = "";
    }
    function closeWin() {
        var oWin = GetRadWindow();
        oWin.close();
    }
    function UpdateParent() {
        var oWin = GetRadWindow();
        var textArea = document.getElementById("orderByQuery");
        var hdnQuery = document.getElementById("hdnOrderByQuery");
        oWin.close(textArea.value + "!!!" + hdnQuery.value);
    }
   
</script>

