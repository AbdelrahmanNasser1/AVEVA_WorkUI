<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Forms.Web.CodeBehind.SetColor" EnableViewState="true" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html>
<html style="height: 100%">
<head id="Head1" runat="server">
    <title>
        <%=PageTitle%>
    </title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
     <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script>
    
    <style type="text/css">
        .lbl
        {
            width: 150px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            text-decoration: none;
        }

        .popup
        {
            overflow: auto;
            background-color: White;
            border: 1px solid #256194;
            z-index: 6000000;
            min-width: 115px;
        }
        
    </style>
    

</head>

<body id="body" style="padding-right:0px; padding-left:0px; padding-bottom:0px; margin:0px; border-style:none; padding-top:0px; height:100%; overflow:hidden">
     <script>
         se.ui.messageDialog.setGlobalOptions({
             localization: {
                 closeButtonCaption: "<%=ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                okButtonCaption: "<%=ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
                cancelButtonCaption: "<%=ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                showDetailsCaption: "<%=ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                hideDetailsCaption: "<%=ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
            }
        });


         function DisplayErrorMessage(strMessage) {
            
            var strHdrMsg = '<%=ResManager.GlobalResourceSet.GetString("sk_gridconfig_advancedsettingspagetitle")%>';
             se.ui.messageDialog.showError(strHdrMsg, strMessage);
         }
         function DisplaySuccessMessage(strMessage) {

             var strHdrMsg = '<%=ResManager.GlobalResourceSet.GetString("sk_gridconfig_advancedsettingspagetitle")%>';
             se.ui.messageDialog.showAlert(strHdrMsg, strMessage);
          }
         </script>

    <div id="divparent" style="height:100%">
        <form id="setexpression" runat="server" style="height:100%"> <telerik:RadCodeBlock runat="server" ID="RadCodeBlock6">
             <%=System.Web.Helpers.AntiForgery.GetHtml()%>
            <telerik:RadScriptManager ID="RadScriptManager1" runat="server" />
            <link href="<%=ThemeURL%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
            <link href="<%=ThemeURL%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" />
            <link href="<%=ThemeURL%>TelerikAjax/StyleSheet/AWTTreeView/TreeView.AWTTreeView.css" rel="stylesheet" type="text/css" />
             <link href="<%=ThemeURL%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css" rel="stylesheet" type="text/css" />
             <link href="<%=ThemeURL%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css" rel="stylesheet" type="text/css" />
            </telerik:RadCodeBlock>
             <telerik:RadAjaxPanel ID="ajaxPanel" runat="server" Width="100%" Height="100%">
               <asp:HiddenField ID="tempDefinitionField" runat="server" />
                <input id="hdnIsBrowserIEType" runat="server" type="hidden" enableviewstate="true" />
                <div id="divheader" style="height: auto">
                    <asp:HiddenField ID="selectedControl" runat="Server" />
                    <table style="width: 98%; border-width: 0; border-spacing: 0px">
                        <tr>
                            <td colspan="4" style="width: 100%; padding: 4px">
                                <table style="width: 98%; border-width: 0; margin: auto; border-spacing: 0px">
                                    <tr>
                                        <td class="pagetitle" style="padding: 2px"> <telerik:RadCodeBlock runat="server" ID="RadCodeBlock5">
                                            <img src="<%=ThemeURL%>/Repository/ListControl/images/icon-grid-config.gif" alt="<%=ThemeURL%>/Repository/ListControl/images/icon-grid-config.gif"
                                                align="absmiddle" />&nbsp;<%=PageTitle%></telerik:RadCodeBlock>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="description" style="padding: 2px"> <telerik:RadCodeBlock runat="server" ID="RadCodeBlock4">
                                            <%=PageDescription%></telerik:RadCodeBlock>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="description" style="padding: 2px"> <telerik:RadCodeBlock runat="server" ID="RadCodeBlock3">
                                            <%= ResManager.GlobalResourceSet.GetString("sk_gridconfig_expressionnote")%></telerik:RadCodeBlock>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <table class="tablePdbg" style="width:98%;margin:0px auto;">
                        <tr style="width: 10%">
                            <td class="tableheaderbg" style="padding-bottom:5px;" > <telerik:RadCodeBlock runat="server" ID="RadCodeBlock2">
                                <%= ResManager.GlobalResourceSet.GetString("sk_gridconfig_addbtn")%></telerik:RadCodeBlock>
                                <asp:ImageButton ID="rowAddButton" runat="server" OnClick="HandleRowAdd_Click" ImageAlign="Top" BorderStyle="None" Width="20" Height="20" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="divbody" style="width: 100%; height: 45%;padding-top:3px;">
                    <table style="width: 98%;border-collapse: collapse; margin: auto;" class="tablebg">
                        <tr style="width: 90%" class="GridHeaderStyle">
                             <telerik:RadCodeBlock runat="server" ID="RadCodeBlock1">
                            <td  style="padding: 0px; width: 15%; text-align: center">
                                <%= ResManager.GlobalResourceSet.GetString("sk_gridconfig_setheader")%>
                            </td>
                            <td style="padding: 0px; width: 15%; text-align: center">
                                <%= ResManager.GlobalResourceSet.GetString("sk_gridconfig_colorheader")%>
                            </td>
                            <td  style="padding: 0px; width: 15%; text-align: center">
                                <%= ResManager.GlobalResourceSet.GetString("sk_gridconfig_dataSourceheader")%>
                            </td>
                            <td  style="padding: 0px; width: 15%; text-align: center">
                                <%= ResManager.GlobalResourceSet.GetString("sk_gridconfig_columnheader")%>
                            </td>
                            <td  style="padding: 0px; width: 15%; text-align: center">
                                <%= ResManager.GlobalResourceSet.GetString("sk_gridconfig_operationsheader")%>
                            </td>
                            <td  style="padding: 0px; width: 15%; text-align: center">
                                <%= ResManager.GlobalResourceSet.GetString("sk_gridconfig_valueheader")%>
                            </td>
                            <td style="padding: 0px; width: 8%; text-align: center; vertical-align: middle;">
                            </td>
                         </telerik:RadCodeBlock>
                        </tr>
                    </table>
                    <table id="table2" runat="server" border="0" cellspacing="0" cellpadding="0" align="center"
                        width="100%">
                        <tr>
                            <td>
                                <asp:Table ID="highlightTable" Width="98%" CellPadding="0" CellSpacing="0" runat="server" align="center" EnableViewState="true">
                                </asp:Table>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="divfooter" style="vertical-align: top; right: 0px; position: absolute; bottom: 0px; padding-right: 10px;padding-bottom:10px;">
                    <asp:Button ID="previewButton" runat="server" CssClass="inputsecondarybutton"
                        OnClick="HandlePreviewClick" />
                    <asp:Button ID="saveButton" runat="server" CssClass="inputbutton"
                        OnClick="HandleSaveClick" />
                </div>
                <div style="display: none; z-index: 3000;" id="divLookupTreeview" runat="server">
                    <telerik:RadTreeView  ID="lookUpTreeView" runat="server" Skin="AWTTreeView" Height="100%"  OnNodeClick="LookUpTreeView_NodeClick" OnClientNodeClicked="GetRadNode" OnClientNodeClicking="LookupTreeBeforeClientClick" EnableEmbeddedSkins="false" RenderMode="Classic" ShowLineImages="false">
                    </telerik:RadTreeView>
                </div>
                <div style="display: none; z-index: 3000;" id="divColorTreeview" runat="server">
                    <telerik:RadTreeView  ID="colorTreeView" runat="server" Skin="AWTTreeView" Height="100%" OnClientNodeClicked="ColorTreeviewClientClick" EnableEmbeddedSkins="false" RenderMode="Classic" ShowLineImages="false">
                    </telerik:RadTreeView>
                 </div>
             </telerik:RadAjaxPanel>
            <script type="text/javascript">
                var text;
                var hdn;
                
                try{                
                    var oWin = window.parent.GetRadWindow();

                    var oPWinHeight = 0.8 * oWin.get_height();
                    var oPWinWidth = 0.7 * oWin.get_width();
                    var oPWinLeft = (window.screen.width - oPWinWidth) / 2;
                    var oPWinTop = (window.screen.height - oPWinHeight) / 2;
                }
                catch (e) { }
                
                ///never change Hidden controls Id
                var idSeperator = "_";
                var operationBoxFieldId = "operationBoxField";
                var setComboBoxFieldId = "setComboBoxField";
                var colorComboBoxFieldId = "colorComboBoxField";
                var lookupColumnBoxFieldId = "lookupColumnBoxField";

                AddEventHandler(window, 'resize', resizefunction);
                AddEventHandler(window, 'load', resizefunction);

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
                    var bodydiv = document.getElementById('divbody');
                    var headerdiv = document.getElementById('divheader');
                    var footerdiv = document.getElementById('divfooter');
                    var parentdiv = document.getElementById('divparent');
                    if (parentdiv.offsetParent == document.body)
                        // document.body.style.height = '100%';

                        var parentdivheight = parentdiv.offsetParent.offsetHeight;
                    //   parentdiv.style.height = parentdivheight;
                    try
                    { //bodydiv.style.height = parentdivheight - headerdiv.offsetHeight - footerdiv.offsetHeight - 15;
                    } catch (e) { }
                    // bodydiv.style.width = '100px';
                    bodydiv.style.width = parentdiv.clientWidth;
                    bodydiv.style.overflow = 'auto';
                    parentdiv.style.overflow = 'hidden';
                }

                //Alert
                function GiveAlert(msg)
                {
                   
                    alert(msg);
                }

                function ToggleTreeView(txtId, hdnId, controlId, dropdownwidth)
                {
                    if (document.getElementById(controlId).style.display == "none")
                    {
                       OpenTableStructureForFormControls(txtId, hdnId, controlId, dropdownwidth);
                    }
                    else
                    {
                       CloseDivControls(controlId);
                    }
                }

                function OpenTableStructureForFormControls(txtId, hdnId, controlId, dropdownwidth)
                {
                    resizefunction();
                    text = txtId;
                    hdn = hdnId;
                    var DivTree = document.getElementById(controlId);
                    DivTree.style.display = GetDisplayAttributeString();
                    DivTree.style.position = "absolute";
                    var textId = document.getElementById(txtId);
                    var x = findPosX(textId);
                    var y = findPosY(textId);
                    DivTree.style.left = x + "px";
                    DivTree.style.top = (parseInt(y) + 25) + "px";
                    DivTree.className = "popup";
                    if (controlId === "divColorTreeview")
                    {
                        DivTree.style.width = dropdownwidth + 'px';
                    }
                    DivTree.style.height = 100 + 'px';
                    DivTree.style.textAlign = "left";

                    var RadTree = document.getElementById(controlId);
                    RadTree.style.height = DivTree.style.height;
                    RadTree.style.textAlign = "left";

                    if (controlId == 'divLookupTreeview')
                    {
                        var controlIndex = txtId.split(idSeperator);
                         UpdateControl('selectedControl', controlIndex[1]);
                    }
                }

                function CloseDivControls(controlId)
                {
                    var DivTree = document.getElementById(controlId);
                    DivTree.style.display = "none";
                    resizefunction();
                }

                function GetRadNode(sender, eventArgs)
                {
                     var node = eventArgs.get_node();
                    if (node.get_level() == 0)
                    {
                        eventArgs.set_cancel(true);
                    }
                    UpdateControl(text, node.get_text());
                    UpdateControl(hdn, node.get_parent().get_text());
                    var DivTree = document.getElementById('divLookupTreeview');
                    DivTree.style.display = "none";
                }
                function ColorTreeviewClientClick(sender, eventArgs)
                {
                    var node = eventArgs.get_node();
                    UpdateControl(text, node.get_text());
                    UpdateControl(hdn, node.get_value());
                    var DivTree = document.getElementById('divColorTreeview');
                    DivTree.style.display = "none";
                    resizefunction();
                }



                function LookupTreeBeforeClientClick(node, eventArgs)
                {
                    var node = eventArgs.get_node();
                    if (node.get_level() == 0)
                    {      
                        eventArgs.set_cancel(true);
                    }
                }

                function GetDisplayAttributeString()
                {
                    if (document.getElementById("hdnIsBrowserIEType").value == "1")
                    {
                        return "inline";
                    }
                    else
                    {
                        return "";
                    }
                }

                function findPosX(obj)
                {
                    var curleft = 0;

                    if (obj.offsetParent)
                    {
                        while (obj.offsetParent)
                        {
                            curleft += obj.offsetLeft
                            obj = obj.offsetParent;
                        }
                    }

                    else if (obj.x)
                        curleft += obj.x;

                    return curleft;
                }
                function findPosY(obj)
                {
                    var curtop = 0;
                    if (obj.offsetParent)
                    {
                        while (obj.offsetParent)
                        {
                            curtop += obj.offsetTop
                            obj = obj.offsetParent;
                        }

                        curtop -= document.getElementById("divbody").scrollTop;
                    }
                    else if (obj.y)
                        curtop += obj.y;
                    return curtop;
                }
                function ColumnBoxSelectedIndexChanged(item)
                {
                    var columnBoxId = item.ComboBox.ID.split(idSeperator);
                    columnBoxId = lookupColumnBoxFieldId + columnBoxId[1];
                    UpdateControl(columnBoxId, item.Index);
                }

                function OperationBoxSelectedIndexChanged(sender, eventArgs)
                {
                    var node = sender.get_id();
                    var operationBoxId = node.split(idSeperator);
                    operationBoxId = operationBoxFieldId + operationBoxId[1];
                    var item = eventArgs.get_item();
                    UpdateControl(operationBoxId, item.get_index());
                }
                function SetComboBoxSelectedIndexChanged(sender, eventArgs)
                {
                    var node = sender.get_id();
                    var setComboBoxId = node.split(idSeperator);
                    setComboBoxId = setComboBoxFieldId + setComboBoxId[1];
                    var item = eventArgs.get_item();
                    UpdateControl(setComboBoxId, item.get_index());

                }
                function ColorBoxSelectedIndexChanged(sender, eventArgs)
                {
                     var node = sender.get_id();
                    var setColComboBoxId = node.split(idSeperator);
                    setColComboBoxId = colorComboBoxFieldId + setColComboBoxId[1];
                    var item = eventArgs.get_item();
                    UpdateControl(setColComboBoxId, item.get_index());
                }

                function ColorBoxBlur(sender, eventArgs) {
                    var node = sender.get_id();
                    var setColComboBoxId = node.split(idSeperator);
                    setColComboBoxId = colorComboBoxFieldId + setColComboBoxId[1];
                    var item = sender.get_text();
                    UpdateControl(setColComboBoxId, item);
                }

                
               
                function UpdateControl(controlId, controlValue)
                {
                    try
                    {
                        var control = document.getElementById(controlId);
                        control.value = controlValue;
                    }
                    catch (ex)
                    { }
                }

                function setValues(gridExpressionDefinition)
                {
                    window.parent.parent.document.getElementById("gridExpressionField").value = gridExpressionDefinition;
                    //closeWindow();
                }

                function closeWindow(msg)
                {
                    window.parent.closeWindow(msg);

                }

                function WaterMark(txt, evt, watermarktext)
                {
                    if (txt.value.length == 0 && evt.type == "blur")
                    {
                        txt.style.color = "gray";
                        txt.value = watermarktext;
                    }
                    if (txt.value == watermarktext && evt.type == "focus")
                    {
                        txt.style.color = "black";
                        txt.value = "";
                    }
                }

                function GetTempDefinition()
                {
                    document.getElementById("tempDefinitionField").value = window.parent.parent.document.getElementById("tempDefinitionField").value;
                }

                function Preview(lookupids, tempFileID)
                {

                    ////var url = "PreviewFormDataGrid.aspx?ids=" + lookupids + "&tmpID=" + tempFileID;
                    ////var parameterWindow = window.open(url, "ParameterWindow", "toolbar=0,menubar=0,resizable=1,width=" + oPWinWidth + ",height=" + oPWinHeight + ",left=" + oPWinLeft + ",top=" + oPWinTop);
                }

            </script>
        </form>
    </div>
</body>
</html>
