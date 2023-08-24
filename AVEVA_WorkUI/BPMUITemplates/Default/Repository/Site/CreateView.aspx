<%@ Page Language="C#" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" Inherits= "Skelta.Repository.List.ListView.CodeBehind.CreateView" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE html >
<html>
<script type="text/javascript">

    function UpdateAndCloseRad(isNew) {
        
        //window.parent.location.href=window.parent.location.href;
        if (isNew) {

            window.parent.location.href = window.parent.location.href;
        }
        else if (isNew == "edit") {
            var oWindow = GetRadWindow();
            oWindow.close();
        }
        else {

            //window.setTimeout("var oWindow = GetRadWindow();oWindow.Close();",1000);
            var oWindow = GetRadWindow();
            oWindow.close();
            //alert('window closed');
            window.setTimeout("RefreshParentWindow();", 1000);
        }

    }

    function ConfirmAndClose(message, isNew)
    {
        var msg = '<%=_Skrm.GlobalResourceSet.GetString("lv_OkCancel")%>';
        se.ui.messageDialog.showError('<%=_Skrm.GlobalResourceSet.GetString("lv_listTitle").Replace("<#ListName>", Microsoft.Security.Application.Encoder.HtmlEncode(_ListName))%>', message);       
    }
   

    function MessageAndClose(message, isNew) {        
        se.ui.messageDialog.showAlert('<%=_Skrm.GlobalResourceSet.GetString("lv_listTitle").Replace("<#ListName>", Microsoft.Security.Application.Encoder.HtmlEncode(_ListName))%>', message);
        UpdateAndCloseRad(isNew);
    }

    function UpdateSelection() {
        if (document.forms[0].RadFilterColumn[1].checked == true) {
            if (navigator.appName == 'Netscape')
                document.getElementById('trfilter').style.display = 'table-row';
            else
                document.getElementById('trfilter').style.display = "block";
            document.getElementById("<%=btnGenerate.ClientID%>").disabled = false;
            document.getElementById('txtExpression').disabled = false;
            document.getElementById("<%=btnExpValidate.ClientID%>").disabled = true;
        }
        else {
            document.getElementById('trfilter').style.display = "none";
            document.getElementById('btnGenerate').disabled = true;
            document.getElementById('txtExpression').disabled = true;
            document.getElementById('txtExpression').value = "";
            document.getElementById("<%=btnExpValidate.ClientID%>").disabled = true;
            document.getElementById("<%=btnClear.ClientID%>").disabled = true;
        }
    }


    function RefreshParentWindow() {

        var qryStr = window.parent.document.getElementById("mainframe").contentWindow.location.href;
        var qryStrArr = qryStr.split("?");
        qryStrArr = qryStrArr[1].split("&");
        var itemId = document.getElementById('hdnItemId').value;
        window.parent.document.getElementById("mainframe").contentWindow.document.location.href = "<%=_TemplatePath %>/ListControl/listgridpage.aspx?" + qryStrArr[0] + "&ViewItemId=" + itemId;
        window.parent.document.getElementById("bcrumb").innerHTML = "";

    }

    function GetRadWindow() {
        var oWindow = null;
        if (window.radWindow)
            oWindow = window.radWindow;
        else if (window.frameElement.radWindow)
            oWindow = window.frameElement.radWindow;
        return oWindow;
    }

    function sstchur_SmartScroller_GetCoords() {

        var scrollX, scrollY;
        var formID = "form1";
        if (document.all) {
            if (!document.documentElement.scrollLeft)
                scrollX = document.body.scrollLeft;
            else
                scrollX = document.documentElement.scrollLeft;

            if (!document.documentElement.scrollTop)
                scrollY = document.body.scrollTop;
            else
                scrollY = document.documentElement.scrollTop;
        }
        else {
            scrollX = window.pageXOffset;
            scrollY = window.pageYOffset;
        }

        document.forms[formID].xCoordHolder.value = scrollX;
        document.forms[formID].yCoordHolder.value = scrollY;
    }

    function sstchur_SmartScroller_Scroll() {

        var x = document.forms['form1'].xCoordHolder.value;
        var y = document.forms['form1'].yCoordHolder.value;

        window.scrollTo(x, y);
    }

    function Load() {
        window.onload = sstchur_SmartScroller_Scroll;
        window.onscroll = sstchur_SmartScroller_GetCoords;
        window.onkeypress = sstchur_SmartScroller_GetCoords;
        window.onclick = sstchur_SmartScroller_GetCoords;
    }

    function ShowErrorPage(error) {
        var oWindow1 = window.radopen("ShowListViewErrorMessage.aspx?e=" + error, "RadWindow1");       
    }
   
</script>
<head id="Head1" runat="server">
    <title>
        <%= _PageTitle%></title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
     <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script>
     
<style>
    html, body
    {
        height: 100%;
        width: 100%;
        overflow-x: hidden !important;
    }

    input[type="radio"]
    {
        margin: 3px 3px 0px 0px;
    }

    input[type="checkbox"]
    {
        margin: 3px 3px 0px 0px;
    }
</style>
</head>
<body style="overflow: auto;">
     <script>
         se.ui.messageDialog.setGlobalOptions({
             localization: {
                 closeButtonCaption: "<%=_Skrm.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                 okButtonCaption: "<%=_Skrm.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
                 cancelButtonCaption: "<%=_Skrm.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                 showDetailsCaption: "<%=_Skrm.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                 hideDetailsCaption: "<%=_Skrm.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
             }
         });


</script>
    <form id="form1" runat="server">
    <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
        <telerik:RadScriptManager ID="RadMgr1" runat="server"></telerik:RadScriptManager>
    <link rel="stylesheet" type="text/css" href="<%=_ThemePath%>Common/StyleSheet/Global.css" />
     <link href="<%=_ThemePath%>CommonUXControls/StyleSheet/se.ui.min.css"  rel="stylesheet" type="text/css" /> 
        <link rel="stylesheet" type="text/css" href="<%=_ThemePath%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
 <link rel="stylesheet" type="text/css" href="<%=_ThemePath%>TelerikAjax/StyleSheet/AWTWindow/Window.css">
    <input type="hidden" id="xCoordHolder" />
    <input type="hidden" id="yCoordHolder" />
    <div id="divH">
        <table class="ListHeaderCss" style="width: 100%">
            <tr class="ListHeaderCss">
                <td class="fontheading" style="text-align: left;padding:10px;">
                    <img src="<%=_ThemePath%>Repository/ListControl/images/Icon-ListView-Header.png" alt="" style="vertical-align:middle;" />
                    <%=_Skrm.GlobalResourceSet.GetString("lv_listTitle").Replace("<#ListName>", _ListName)%>
                </td>
            </tr>
        </table>
    </div>
    <div id="divB">
        <table class="tablebg" style="border-collapse:separate;border-spacing:10px;width: 100%;">
            <tr>
                <td class="lefttdbg" style="width: 40%; vertical-align: top">
                    <span class="subtitle">
                        <%=_Skrm.GlobalResourceSet.GetString("lv_name")%></span><br />
                    <span class="description">
                        <%=_Skrm.GlobalResourceSet.GetString("lv_namedesc")%>
                    </span>
                </td>
                <td class="righttdbg" style="width: 50%;padding-left:1px;">
                    <asp:TextBox AutoCompleteType="Disabled" onblur="ContainsSpecialChar();" ID="txtVName"
                        Width="50%" runat="server" CssClass="inputtext"></asp:TextBox><br />
                    <asp:CheckBox ID="chkDV" OnClick="SendServerData()" runat="server" AutoPostBack="false"
                        CssClass="inputcheckbox" />
                </td>
            </tr>
            <tr id="trViewCopy" runat="server">
                <td class="lefttdbg" style="width: 40%; vertical-align: top">
                    <span class="subtitle">
                        <%=_Skrm.GlobalResourceSet.GetString("lv_inherit")%></span><br />
                    <span class="description">
                        <%=_Skrm.GlobalResourceSet.GetString("lv_inheritdesc")%><br />
                    </span>
                </td>
                <td class="righttdbg">
                    <asp:DropDownList ID="ddLoadExistingViews" AutoPostBack="true" OnSelectedIndexChanged="ddLoadExistingViews_SelectedIndexChanged"
                        runat="server" CssClass="inputselect">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="lefttdbg" style="width: 40%; vertical-align: top">
                    <span class="subtitle">
                        <%=_Skrm.GlobalResourceSet.GetString("lv_vs")%></span><br />
                    <span class="description">
                        <%=_Skrm.GlobalResourceSet.GetString("lv_vsdesc")%>
                    </span>
                </td>
                <td class="righttdbg" style="padding-left:3px;">
                     
                    <asp:RadioButtonList ID="radScope" onclick="SendServerData()" runat="server" CssClass="inputcheckbox"
                        TextAlign="Right" RepeatDirection="Vertical">
                        <asp:ListItem Value="pv"></asp:ListItem>
                        <asp:ListItem Value="gv" Selected="True"></asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td class="lefttdbg" style="width: 40%; vertical-align: top">
                    <span class="subtitle">
                        <%=_Skrm.GlobalResourceSet.GetString("lv_Columns")%></span><br />
                    <span class="description">
                        <%=_Skrm.GlobalResourceSet.GetString("lv_Columnsdesc")%></span>
                </td>
                <!-- GRID COLUMNS-->
                <td class="righttdbg">
                    <table style="border:0px; border-spacing: 0px">
                        <tr>
                            <td class="righttdbg">
                                <asp:GridView ID="gridId" RowStyle-VerticalAlign="Bottom" GridLines="None" OnRowCreated="OnRowCreated"
                                    Width="530px" runat="server" ShowFooter="false" AutoGenerateColumns="false" CssClass="inputdynamic"
                                    OnRowDataBound="gridId_RowDataBound" AlternatingRowStyle-Wrap="true" CellPadding="5" CellSpacing="5">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:CheckBox EnableViewState="true" Checked="true" ID="chkDisplay" runat="server"
                                                    CssClass="inputcheckbox" />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Label ID="lblGrid" runat="server" CssClass="description"></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="left" Wrap="true" />
                                            <HeaderStyle HorizontalAlign="left"/>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddPos" name="ddPos" onchange="UpdateDropDownValue(this);" runat="server"
                                                    CssClass="inputselect">
                                                </asp:DropDownList>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hdnCtrlXmlNode" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hdnCtrlName" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hdnCtrlBoundColmn" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hdnCtrTableName" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hdnCtrTableAliasName" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hdnCtrColumnAliasName" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hdnCtrlgridCaption" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hdnIsTopLevelForm" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hdnTableFormXmlNodeBoundTo" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hdnBoundToDBColumnType" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="lefttdbg" style="width: 40%; vertical-align: top">
                    <span class="subtitle">
                        <%=_Skrm.GlobalResourceSet.GetString("lv_Sort")%></span><br />
                    <span class="description">
                        <%=_Skrm.GlobalResourceSet.GetString("lv_sortdesc")%></span>
                </td>
                <td class="righttdbg">
                    <table style="border-spacing: 0; border-width: 0">
                        <tr>
                            <td>
                                <span class="description">
                                    <%=_Skrm.GlobalResourceSet.GetString("lv_fsc")%></span>
                                <br />
                                <!--SORT COLUMNS-->
                                <asp:DropDownList ID="ddfs" runat="server" AutoPostBack="false" Width="375px" CssClass="inputselect">
                                </asp:DropDownList>
                                <br />
                                <asp:RadioButtonList ID="radfs" runat="server" AutoPostBack="false" CssClass="inputradio"
                                    RepeatDirection="Vertical" RepeatLayout="Table">
                                    <asp:ListItem Selected="True" Value="asc"></asp:ListItem>
                                    <asp:ListItem Value="desc"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span class="description">
                                    <%=_Skrm.GlobalResourceSet.GetString("lv_tsbc")%></span>
                                <br />
                                <asp:DropDownList ID="ddss" runat="server" AutoPostBack="false" Width="375px" CssClass="inputselect">
                                </asp:DropDownList>
                                <br />
                                <asp:RadioButtonList ID="radss" runat="server" AutoPostBack="false" CssClass="inputradio"
                                    RepeatDirection="Vertical" RepeatLayout="Table">
                                    <asp:ListItem Selected="True" Value="asc"></asp:ListItem>
                                    <asp:ListItem Value="desc"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: left">
                                <a href="#" id="as1" class="GridHyperlinkStyle" onclick="ShowDiv(this,'divs1');return false;">
                                    <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table>
                                    <tr>
                                        <td>
                                            <div id="divSM" runat="server">
                                                <div id="divs1" style="display: none" runat="server">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <span class="description">
                                                                    <%=_Skrm.GlobalResourceSet.GetString("lv_tsbc")%></span>
                                                                <br />
                                                                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="false" Width="375px" CssClass="inputselect">
                                                                </asp:DropDownList>
                                                                <br />
                                                                <asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="false" CssClass="inputradio"
                                                                    RepeatDirection="Vertical" RepeatLayout="Table">
                                                                    <asp:ListItem Selected="True" Value="asc"></asp:ListItem>
                                                                    <asp:ListItem Value="desc"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align: left">
                                                                <a href="#" id="as2" class="GridHyperlinkStyle" onclick="ShowDiv(this,'divs2');return false;">
                                                                    <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div id="divs2" style="display: none" runat="server">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <span class="description">
                                                                    <%=_Skrm.GlobalResourceSet.GetString("lv_tsbc")%></span>
                                                                <br />
                                                                <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="false" Width="375px" CssClass="inputselect">
                                                                </asp:DropDownList>
                                                                <br />
                                                                <asp:RadioButtonList ID="RadioButtonList2" runat="server" AutoPostBack="false" CssClass="inputradio"
                                                                    RepeatDirection="Vertical" RepeatLayout="Table">
                                                                    <asp:ListItem Selected="True" Value="asc"></asp:ListItem>
                                                                    <asp:ListItem Value="desc"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align: left">
                                                                <a href="#" id="as3" class="GridHyperlinkStyle" onclick="ShowDiv(this,'divs3');return false;">
                                                                    <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div id="divs3" style="display: none" runat="server">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <span class="description">
                                                                    <%=_Skrm.GlobalResourceSet.GetString("lv_tsbc")%></span>
                                                                <br />
                                                                <asp:DropDownList ID="DropDownList3" runat="server" AutoPostBack="false" Width="375px" CssClass="inputselect">
                                                                </asp:DropDownList>
                                                                <br />
                                                                <asp:RadioButtonList ID="RadioButtonList3" runat="server" AutoPostBack="false" CssClass="inputradio"
                                                                    RepeatDirection="Vertical" RepeatLayout="Table">
                                                                    <asp:ListItem Selected="True" Value="asc"></asp:ListItem>
                                                                    <asp:ListItem Value="desc"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align: left">
                                                                <a href="#" id="as4" class="GridHyperlinkStyle" onclick="ShowDiv(this,'divs4');return false;">
                                                                    <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div id="divs4" style="display: none" runat="server">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <span class="description">
                                                                    <%=_Skrm.GlobalResourceSet.GetString("lv_tsbc")%></span>
                                                                <br />
                                                                <asp:DropDownList ID="DropDownList4" runat="server" AutoPostBack="false" Width="375px" CssClass="inputselect">
                                                                </asp:DropDownList>
                                                                <br />
                                                                <asp:RadioButtonList ID="RadioButtonList4" runat="server" AutoPostBack="false" CssClass="inputradio"
                                                                    RepeatDirection="Vertical" RepeatLayout="Table">
                                                                    <asp:ListItem Selected="True" Value="asc"></asp:ListItem>
                                                                    <asp:ListItem Value="desc"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align: left">
                                                                <a href="#" id="as5" class="GridHyperlinkStyle" onclick="ShowDiv(this,'divs5');return false;">
                                                                    <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div id="divs5" style="display: none" runat="server">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <span class="description">
                                                                    <%=_Skrm.GlobalResourceSet.GetString("lv_tsbc")%></span>
                                                                <br />
                                                                <asp:DropDownList ID="DropDownList5" runat="server" AutoPostBack="false" Width="375px" CssClass="inputselect">
                                                                </asp:DropDownList>
                                                                <br />
                                                                <asp:RadioButtonList ID="RadioButtonList5" runat="server" AutoPostBack="false" CssClass="inputradio"
                                                                    RepeatDirection="Vertical" RepeatLayout="Table">
                                                                    <asp:ListItem Selected="True" Value="asc"></asp:ListItem>
                                                                    <asp:ListItem Value="desc"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align: left">
                                                                <a href="#" id="as6" class="GridHyperlinkStyle" onclick="ShowDiv(this,'divs6');return false;">
                                                                    <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div id="divs6" style="display: none" runat="server">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <span class="description">
                                                                    <%=_Skrm.GlobalResourceSet.GetString("lv_tsbc")%></span>
                                                                <br />
                                                                <asp:DropDownList ID="DropDownList6" runat="server" AutoPostBack="false" Width="375px" CssClass="inputselect">
                                                                </asp:DropDownList>
                                                                <br />
                                                                <asp:RadioButtonList ID="RadioButtonList6" runat="server" AutoPostBack="false" CssClass="inputradio"
                                                                    RepeatDirection="Vertical" RepeatLayout="Table">
                                                                    <asp:ListItem Selected="True" Value="asc"></asp:ListItem>
                                                                    <asp:ListItem Value="desc"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align: left">
                                                                <a href="#" id="as7" class="GridHyperlinkStyle" onclick="ShowDiv(this,'divs7');return false;">
                                                                    <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div id="divs7" style="display: none" runat="server">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <span class="description">
                                                                    <%=_Skrm.GlobalResourceSet.GetString("lv_tsbc")%></span>
                                                                <br />
                                                                <asp:DropDownList ID="DropDownList7" runat="server" AutoPostBack="false" Width="375px" CssClass="inputselect">
                                                                </asp:DropDownList>
                                                                <br />
                                                                <asp:RadioButtonList ID="RadioButtonList7" runat="server" AutoPostBack="false" CssClass="inputradio"
                                                                    RepeatDirection="Vertical" RepeatLayout="Table">
                                                                    <asp:ListItem Selected="True" Value="asc"></asp:ListItem>
                                                                    <asp:ListItem Value="desc"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align: left">
                                                                <a href="#" id="as8" class="GridHyperlinkStyle" onclick="ShowDiv(this,'divs8');return false;">
                                                                    <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div id="divs8" style="display: none" runat="server">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <span class="description">
                                                                    <%=_Skrm.GlobalResourceSet.GetString("lv_tsbc")%></span>
                                                                <br />
                                                                <asp:DropDownList ID="DropDownList8" runat="server" AutoPostBack="false" Width="375px" CssClass="inputselect">
                                                                </asp:DropDownList>
                                                                <br />
                                                                <asp:RadioButtonList ID="RadioButtonList8" runat="server" AutoPostBack="false" CssClass="inputradio"
                                                                    RepeatDirection="Vertical" RepeatLayout="Table">
                                                                    <asp:ListItem Selected="True" Value="asc"></asp:ListItem>
                                                                    <asp:ListItem Value="desc"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                        </tr>
                                                        
                                                        <tr>
                                                            <td style="text-align: left">
                                                                <a href="#" id="as9" class="GridHyperlinkStyle" onclick="ShowDiv(this,'divs9');return false;">
                                                                    <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <!--SORT COLUMNS END -->
            <tr>
                <td class="lefttdbg" style="width: 40%; vertical-align: top">
                    <span class="subtitle">
                        <%=_Skrm.GlobalResourceSet.GetString("lv_Filter")%></span><br />
                    <span class="description">
                        <%=_Skrm.GlobalResourceSet.GetString("lv_Filterdesc1").Replace("<#:>",":")%></span><br />
                    <br />
                    <span class="description">
                        <%=_Skrm.GlobalResourceSet.GetString("lv_Filterdesc2").Replace("<#:>",":")%></span>
                    <ol>
                        <li class="description"><span class="description">
                            <%=_Skrm.GlobalResourceSet.GetString("lv_Filterdesc3").Replace("<#:>",":")%></span></li>
                        <li class="description"><span class="description">
                            <%=_Skrm.GlobalResourceSet.GetString("lv_Filterdesc4").Replace("<#:>",":")%></span></li>
                        <li class="description"><span class="description">
                            <%=_Skrm.GlobalResourceSet.GetString("lv_Filterdesc6").Replace("<#:>",":")%></span></li>
                        <li class="description"><span class="description">
                            <%=_Skrm.GlobalResourceSet.GetString("lv_Filterdesc7").Replace("<#:>",":")%></span></li></ol>
                    <span class="description">
                        <%=_Skrm.GlobalResourceSet.GetString("lv_Filterdesc5").Replace("<#:>",":")%></span>
                </td>
                <td class="righttdbg" style="width: 50%; vertical-align: top">
                    <table style="border-width: 0; width: 100%">
                        <%--<tr>
                            <td>
                                <input type="radio" class="inputradio" id="radnf" onclick="javascript:UpdateSelection(this,'radf');"
                                    checked="true" runat="server" value="all" /><span class="inputradio"><%=_Skrm.GlobalResourceSet.GetString("lv_saiv")%></span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="radio" class="inputradio" runat="server" id="radf" value="af" onclick="javascript:UpdateSelection(this,'radnf');" /><span
                                    class="inputradio"><%=_Skrm.GlobalResourceSet.GetString("lv_siwt")%></span>
                            </td>
                        </tr>--%>
                        <tr>
                            <td>
                                <asp:RadioButtonList ID="RadFilterColumn" runat="server" AutoPostBack="false" CssClass="inputradio"
                                    RepeatDirection="Vertical" RepeatLayout="Table">
                                    <asp:ListItem Selected="true" Value="" onclick="javascript:UpdateSelection();"></asp:ListItem>
                                    <asp:ListItem Value="" onclick="javascript:UpdateSelection();"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <!-- FILTER COLUMNS-->
                        <tr id="trfilter" style="display: none" runat="server">
                            <td style="width: 100%;">
                                <table style="border-width: 0; border-spacing: 0; width: 100%">
                                    <tr>
                                        <td>
                                            <table style="border-width: 0">
                                                <tr>
                                                    <td colspan="2">
                                                        <span class="description">
                                                            <%=_Skrm.GlobalResourceSet.GetString("lv_siwc")%></span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <asp:DropDownList ID="ddMfilters" runat="server" CssClass="inputselect">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:DropDownList ID="ddMQCond" runat="server" CssClass="inputselect">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddcv" onchange="javascript:ShowValueDetails(this,'');" runat="server"
                                                            CssClass="inputselect">
                                                            <asp:ListItem Value="Value" Selected="True"></asp:ListItem>
                                                            <asp:ListItem Value="Variable"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr id="trValue" runat="server">
                                                    <td colspan="2">
                                                        <asp:TextBox ID="txtMValue" runat="server" CssClass="inputtext"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr id="trVariable" style="display: none" runat="server">
                                                    <td colspan="2">
                                                        <asp:DropDownList ID="ddVariable" runat="server" CssClass="inputselect">
                                                            <asp:ListItem Value="Variable.LoggedInUserId" Selected="True"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table style="border-width: 0">
                                                <tr>
                                                    <td>
                                                        <div id="dMain" runat="server">
                                                            <div id="d1" runat="server" style="display: block">
                                                                <table style="border-width: 0">
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:RadioButtonList RepeatDirection="Horizontal" ID="rad1" runat="server" CssClass="inputradio">
                                                                                <asp:ListItem Value="And"></asp:ListItem>
                                                                                <asp:ListItem Selected="True" Value="Or"></asp:ListItem>
                                                                            </asp:RadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <span class="description">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_wc")%></span>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="dd1" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddc1" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddcv1" onchange="javascript:ShowValueDetails(this,'1');" runat="server"
                                                                                CssClass="inputselect">
                                                                                <asp:ListItem Value="Value" Selected="True"></asp:ListItem>
                                                                                <asp:ListItem Value="Variable"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trValue1" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:TextBox ID="txt1" runat="server" CssClass="inputtext"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trVariable1" style="display: none" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="ddVariable1" runat="server" CssClass="inputselect">
                                                                                <asp:ListItem Value="Variable.LoggedInUserId" Selected="True"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="text-align:left"colspan="2">
                                                                            <a href="#" id="a1" class="GridHyperlinkStyle" onclick="ShowDiv(this,'d2');return false;">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                            <div id="d2" style="display: none" runat="server">
                                                                <table style="border-width:0">
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:RadioButtonList RepeatDirection="Horizontal" ID="rad2" runat="server" CssClass="inputradio">
                                                                                <asp:ListItem Value="And"></asp:ListItem>
                                                                                <asp:ListItem Selected="True" Value="Or"></asp:ListItem>
                                                                            </asp:RadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <span class="description">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_wc")%></span>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="dd2" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddc2" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddcv2" onchange="javascript:ShowValueDetails(this,'2');" runat="server"
                                                                                CssClass="inputselect">
                                                                                <asp:ListItem Value="Value" Selected="True"></asp:ListItem>
                                                                                <asp:ListItem Value="Variable"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trValue2" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:TextBox ID="txt2" runat="server" CssClass="inputtext"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trVariable2" style="display: none" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="ddVariable2" runat="server" CssClass="inputselect">
                                                                                <asp:ListItem Value="Variable.LoggedInUserId" Selected="True"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="text-align: left" colspan="2">
                                                                            <a href="#" id="a2" class="GridHyperlinkStyle" onclick="ShowDiv(this,'d3');return false;">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                            <div id="d3" style="display: none" runat="server">
                                                                <table style="border-width: 0">
                                                                    
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:RadioButtonList RepeatDirection="Horizontal" ID="rad3" runat="server" CssClass="inputradio">
                                                                                <asp:ListItem Value="And"></asp:ListItem>
                                                                                <asp:ListItem Selected="True" Value="Or"></asp:ListItem>
                                                                            </asp:RadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <span class="description">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_wc")%></span>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="dd3" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddc3" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddcv3" onchange="javascript:ShowValueDetails(this,'3');" runat="server"
                                                                                CssClass="inputselect">
                                                                                <asp:ListItem Value="Value" Selected="True"></asp:ListItem>
                                                                                <asp:ListItem Value="Variable"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trValue3" runat="server">
                                                                        <td>
                                                                            <asp:TextBox ID="txt3" runat="server" CssClass="inputtext"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trVariable3" style="display: none" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="ddVariable3" runat="server" CssClass="inputselect">
                                                                                <asp:ListItem Value="Variable.LoggedInUserId" Selected="True"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="text-align: left" colspan="2">
                                                                            <a href="#" id="a3" class="GridHyperlinkStyle" onclick="ShowDiv(this,'d4');return false;">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                            <div id="d4" style="display: none" runat="server">
                                                                <table style="border-width: 0">
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:RadioButtonList RepeatDirection="Horizontal" ID="rad4" runat="server" CssClass="inputradio">
                                                                                <asp:ListItem Value="And"></asp:ListItem>
                                                                                <asp:ListItem Selected="True" Value="Or"></asp:ListItem>
                                                                            </asp:RadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <span class="description">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_wc")%></span>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="dd4" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddc4" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddcv4" onchange="javascript:ShowValueDetails(this,'4');" runat="server"
                                                                                CssClass="inputselect">
                                                                                <asp:ListItem Value="Value" Selected="True"></asp:ListItem>
                                                                                <asp:ListItem Value="Variable"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trValue4" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:TextBox ID="txt4" runat="server" CssClass="inputtext"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trVariable4" runat="server" style="display: none">
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="ddVariable4" runat="server" CssClass="inputselect">
                                                                                <asp:ListItem Value="Variable.LoggedInUserId" Selected="True"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="text-align: left" colspan="2">
                                                                            <a href="#" id="a4" class="GridHyperlinkStyle" onclick="ShowDiv(this,'d5');return false;">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                            <div id="d5" style="display: none" runat="server">
                                                                <table style="border-width: 0">
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:RadioButtonList RepeatDirection="Horizontal" ID="rad5" runat="server" CssClass="inputradio">
                                                                                <asp:ListItem Value="And"></asp:ListItem>
                                                                                <asp:ListItem Selected="True" Value="Or"></asp:ListItem>
                                                                            </asp:RadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <span class="description">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_wc")%></span>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="dd5" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddc5" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddcv5" onchange="javascript:ShowValueDetails(this,'5');" runat="server"
                                                                                CssClass="inputselect">
                                                                                <asp:ListItem Value="Value" Selected="True"></asp:ListItem>
                                                                                <asp:ListItem Value="Variable"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trValue5" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:TextBox ID="txt5" runat="server" CssClass="inputtext"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trVariable5" style="display: none" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="ddVariable5" runat="server" CssClass="inputselect">
                                                                                <asp:ListItem Value="Variable.LoggedInUserId" Selected="True"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="text-align: left" colspan="2">
                                                                            <a href="#" id="a5" class="GridHyperlinkStyle" onclick="ShowDiv(this,'d6');return false;">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                            <div id="d6" style="display: none" runat="server">
                                                                <table style="border-width: 0">
                                                                    
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:RadioButtonList RepeatDirection="Horizontal" ID="rad6" runat="server" CssClass="inputradio">
                                                                                <asp:ListItem Value="And"></asp:ListItem>
                                                                                <asp:ListItem Selected="True" Value="Or"></asp:ListItem>
                                                                            </asp:RadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <span class="description">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_wc")%></span>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="dd6" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddc6" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddcv6" onchange="javascript:ShowValueDetails(this,'6');" runat="server"
                                                                                CssClass="inputselect">
                                                                                <asp:ListItem Value="Value" Selected="True"></asp:ListItem>
                                                                                <asp:ListItem Value="Variable"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trValue6" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:TextBox ID="txt6" runat="server" CssClass="inputtext"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trVariable6" style="display: none" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="ddVariable6" runat="server" CssClass="inputselect">
                                                                                <asp:ListItem Value="Variable.LoggedInUserId" Selected="True"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="text-align: left" colspan="2">
                                                                            <a href="#" id="a6" class="GridHyperlinkStyle" onclick="ShowDiv(this,'d7');return false;">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                            <div id="d7" style="display: none" runat="server">
                                                                <table style="border-width: 0">
                                                                    
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:RadioButtonList RepeatDirection="Horizontal" ID="rad7" runat="server" CssClass="inputradio">
                                                                                <asp:ListItem Value="And"></asp:ListItem>
                                                                                <asp:ListItem Selected="True" Value="Or"></asp:ListItem>
                                                                            </asp:RadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <span class="description">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_wc")%></span>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="dd7" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddc7" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddcv7" onchange="javascript:ShowValueDetails(this,'7');" runat="server"
                                                                                CssClass="inputselect">
                                                                                <asp:ListItem Value="Value" Selected="True"></asp:ListItem>
                                                                                <asp:ListItem Value="Variable"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trValue7" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:TextBox ID="txt7" runat="server" CssClass="inputtext"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trVariable7" style="display: none" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="ddVariable7" runat="server" CssClass="inputselect">
                                                                                <asp:ListItem Value="Variable.LoggedInUserId" Selected="True"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="text-align:left"colspan="2">
                                                                            <a href="#" id="a7" class="GridHyperlinkStyle" onclick="ShowDiv(this,'d8');return false;">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                            <div id="d8" style="display: none" runat="server">
                                                                <table style="border-width:0">
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:RadioButtonList RepeatDirection="Horizontal" ID="rad8" runat="server" CssClass="inputradio">
                                                                                <asp:ListItem Value="And"></asp:ListItem>
                                                                                <asp:ListItem Selected="True" Value="Or"></asp:ListItem>
                                                                            </asp:RadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <span class="description">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_wc")%></span>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="dd8" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddc8" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddcv8" onchange="javascript:ShowValueDetails(this,'8');" runat="server"
                                                                                CssClass="inputselect">
                                                                                <asp:ListItem Value="Value" Selected="True"></asp:ListItem>
                                                                                <asp:ListItem Value="Variable"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trValue8" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:TextBox ID="txt8" runat="server" CssClass="inputtext"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trVariable8" style="display: none" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="ddVariable8" runat="server" CssClass="inputselect">
                                                                                <asp:ListItem Value="Variable.LoggedInUserId" Selected="True"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="text-align:left"colspan="2">
                                                                            <a href="#" id="a8" class="GridHyperlinkStyle" onclick="ShowDiv(this,'d9');return false;">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                            <div id="d9" style="display: none" runat="server">
                                                                <table style="border-width:0">
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:RadioButtonList RepeatDirection="Horizontal" ID="rad9" runat="server" CssClass="inputradio">
                                                                                <asp:ListItem Value="And"></asp:ListItem>
                                                                                <asp:ListItem Selected="True" Value="Or"></asp:ListItem>
                                                                            </asp:RadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <span class="description">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_wc")%></span>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="dd9" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddc9" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddcv9" onchange="javascript:ShowValueDetails(this,'9');" runat="server"
                                                                                CssClass="inputselect">
                                                                                <asp:ListItem Value="Value" Selected="True"></asp:ListItem>
                                                                                <asp:ListItem Value="Variable"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trValue9" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:TextBox ID="txt9" runat="server" CssClass="inputtext"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trVariable9" style="display: none" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="ddVariable9" runat="server" CssClass="inputselect">
                                                                                <asp:ListItem Value="Variable.LoggedInUserId" Selected="True"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="text-align: left" colspan="2">
                                                                            <a href="#" id="a9" class="GridHyperlinkStyle" onclick="ShowDiv(this,'d10');return false;">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                            <div id="d10" style="display: none" runat="server">
                                                                <table style="border-width: 0">
                                                                    
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:RadioButtonList RepeatDirection="Horizontal" ID="rad10" runat="server" CssClass="inputradio">
                                                                                <asp:ListItem Value="And"></asp:ListItem>
                                                                                <asp:ListItem Selected="True" Value="Or"></asp:ListItem>
                                                                            </asp:RadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <span class="description">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_wc")%></span>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="dd10" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddc10" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddcv10" onchange="javascript:ShowValueDetails(this,'10');"
                                                                                runat="server" CssClass="inputselect">
                                                                                <asp:ListItem Value="Value" Selected="True"></asp:ListItem>
                                                                                <asp:ListItem Value="Variable"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trValue10" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:TextBox ID="txt10" runat="server" CssClass="inputtext"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trVariable10" style="display: none" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="ddVariable10" runat="server" CssClass="inputselect">
                                                                                <asp:ListItem Value="Variable.LoggedInUserId" Selected="True"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="text-align: left" colspan="2">
                                                                            <a href="#" id="a10" class="GridHyperlinkStyle" onclick="ShowDiv(this,'d11');return false;">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                            <div id="d11" style="display: none" runat="server">
                                                                <table style="border-width: 0">
                                                                    
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:RadioButtonList RepeatDirection="Horizontal" ID="rad11" runat="server" CssClass="inputradio">
                                                                                <asp:ListItem Value="And"></asp:ListItem>
                                                                                <asp:ListItem Selected="True" Value="Or"></asp:ListItem>
                                                                            </asp:RadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <span class="description">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_wc")%></span>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="dd11" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddc11" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddcv11" onchange="javascript:ShowValueDetails(this,'11');"
                                                                                runat="server" CssClass="inputselect">
                                                                                <asp:ListItem Value="Value" Selected="True"></asp:ListItem>
                                                                                <asp:ListItem Value="Variable"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trValue11" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:TextBox ID="txt11" runat="server" CssClass="inputtext"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trVariable11" style="display: none" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="ddVariable11" runat="server" CssClass="inputselect">
                                                                                <asp:ListItem Value="Variable.LoggedInUserId" Selected="True"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="text-align: left" colspan="2">
                                                                            <a href="#" id="a11" class="GridHyperlinkStyle" onclick="ShowDiv(this,'d12');return false;">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                            <div id="d12" style="display: none" runat="server">
                                                                <table style="border-width: 0">
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:RadioButtonList RepeatDirection="Horizontal" ID="rad12" runat="server" CssClass="inputradio">
                                                                                <asp:ListItem Value="And"></asp:ListItem>
                                                                                <asp:ListItem Selected="True" Value="Or"></asp:ListItem>
                                                                            </asp:RadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <span class="description">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_wc")%></span>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="dd12" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddc12" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddcv12" onchange="javascript:ShowValueDetails(this,'12');"
                                                                                runat="server" CssClass="inputselect">
                                                                                <asp:ListItem Value="Value" Selected="True"></asp:ListItem>
                                                                                <asp:ListItem Value="Variable"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trValue12" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:TextBox ID="txt12" runat="server" CssClass="inputtext"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trVariable12" style="display: none" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="ddVariable12" runat="server" CssClass="inputselect">
                                                                                <asp:ListItem Value="Variable.LoggedInUserId" Selected="True"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="text-align: left" colspan="2">
                                                                            <a href="#" id="a12" class="GridHyperlinkStyle" onclick="ShowDiv(this,'d13');return false;">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                            <div id="d13" style="display: none" runat="server">
                                                                <table style="border-width: 0">
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:RadioButtonList RepeatDirection="Horizontal" ID="rad13" runat="server" CssClass="inputradio">
                                                                                <asp:ListItem Value="And"></asp:ListItem>
                                                                                <asp:ListItem Selected="True" Value="Or"></asp:ListItem>
                                                                            </asp:RadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <span class="description">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_wc")%></span>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="dd13" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddc13" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddcv13" onchange="javascript:ShowValueDetails(this,'13');"
                                                                                runat="server" CssClass="inputselect">
                                                                                <asp:ListItem Value="Value" Selected="True"></asp:ListItem>
                                                                                <asp:ListItem Value="Variable"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trValue13" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:TextBox ID="txt13" runat="server" CssClass="inputtext"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trVariable13" style="display: none" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="ddVariable13" runat="server" CssClass="inputselect">
                                                                                <asp:ListItem Value="Variable.LoggedInUserId" Selected="True"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="text-align: left" colspan="2">
                                                                            <a href="#" id="a13" class="GridHyperlinkStyle" onclick="ShowDiv(this,'d14');return false;">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                            <div id="d14" style="display: none" runat="server">
                                                                <table style="border-width: 0">
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:RadioButtonList RepeatDirection="Horizontal" ID="rad14" runat="server" CssClass="inputradio">
                                                                                <asp:ListItem Value="And"></asp:ListItem>
                                                                                <asp:ListItem Selected="True" Value="Or"></asp:ListItem>
                                                                            </asp:RadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <span class="description">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_wc")%></span>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="dd14" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddc14" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddcv14" onchange="javascript:ShowValueDetails(this,'14');"
                                                                                runat="server" CssClass="inputselect">
                                                                                <asp:ListItem Value="Value" Selected="True"></asp:ListItem>
                                                                                <asp:ListItem Value="Variable"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trValue14" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:TextBox ID="txt14" runat="server" CssClass="inputtext"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trVariable14" style="display: none" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="ddVariable14" runat="server" CssClass="inputselect">
                                                                                <asp:ListItem Value="Variable.LoggedInUserId" Selected="True"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="text-align: left" colspan="2">
                                                                            <a href="#" id="a14" class="GridHyperlinkStyle" onclick="ShowDiv(this,'d15');return false;">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                            <div id="d15" style="display: none" runat="server">
                                                                <table style="border-width: 0">
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:RadioButtonList RepeatDirection="Horizontal" ID="rad15" runat="server" CssClass="inputradio">
                                                                                <asp:ListItem Value="And"></asp:ListItem>
                                                                                <asp:ListItem Selected="True" Value="Or"></asp:ListItem>
                                                                            </asp:RadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <span class="description">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_wc")%></span>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="dd15" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddc15" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddcv15" onchange="javascript:ShowValueDetails(this,'15');"
                                                                                runat="server" CssClass="inputselect">
                                                                                <asp:ListItem Value="Value" Selected="True"></asp:ListItem>
                                                                                <asp:ListItem Value="Variable"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trValue15" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:TextBox ID="txt15" runat="server" CssClass="inputtext"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trVariable15" style="display: none" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="ddVariable15" runat="server" CssClass="inputselect">
                                                                                <asp:ListItem Value="Variable.LoggedInUserId" Selected="True"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="text-align: left" colspan="2">
                                                                            <a href="#" id="a15" class="GridHyperlinkStyle" onclick="ShowDiv(this,'d16');return false;">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                            <div id="d16" style="display: none" runat="server">
                                                                <table style="border-width: 0">
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:RadioButtonList RepeatDirection="Horizontal" ID="rad16" runat="server" CssClass="inputradio">
                                                                                <asp:ListItem Value="And"></asp:ListItem>
                                                                                <asp:ListItem Selected="True" Value="Or"></asp:ListItem>
                                                                            </asp:RadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <span class="description">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_wc")%></span>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="dd16" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddc16" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddcv16" onchange="javascript:ShowValueDetails(this,'16');"
                                                                                runat="server" CssClass="inputselect">
                                                                                <asp:ListItem Value="Value" Selected="True"></asp:ListItem>
                                                                                <asp:ListItem Value="Variable"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trValue16" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:TextBox ID="txt16" runat="server" CssClass="inputtext"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trVariable16" style="display: none" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="ddVariable16" runat="server" CssClass="inputselect">
                                                                                <asp:ListItem Value="Variable.LoggedInUserId" Selected="True"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="text-align: left" colspan="2">
                                                                            <a href="#" id="a16" class="GridHyperlinkStyle" onclick="ShowDiv(this,'d17');return false;">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                            <div id="d17" style="display: none" runat="server">
                                                                <table style="border-width: 0">
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:RadioButtonList RepeatDirection="Horizontal" ID="rad17" runat="server" CssClass="inputradio">
                                                                                <asp:ListItem Value="And"></asp:ListItem>
                                                                                <asp:ListItem Selected="True" Value="Or"></asp:ListItem>
                                                                            </asp:RadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <span class="description">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_wc")%></span>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="dd17" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddc17" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddcv17" onchange="javascript:ShowValueDetails(this,'17');"
                                                                                runat="server" CssClass="inputselect">
                                                                                <asp:ListItem Value="Value" Selected="True"></asp:ListItem>
                                                                                <asp:ListItem Value="Variable"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trValue17" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:TextBox ID="txt17" runat="server" CssClass="inputtext"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trVariable17" style="display: none" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="ddVariable17" runat="server" CssClass="inputselect">
                                                                                <asp:ListItem Value="Variable.LoggedInUserId" Selected="True"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="text-align: left" colspan="2">
                                                                            <a href="#" id="a17" class="GridHyperlinkStyle" onclick="ShowDiv(this,'d18');return false;">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                            <div id="d18" style="display: none" runat="server">
                                                                <table style="border-width: 0">
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:RadioButtonList RepeatDirection="Horizontal" ID="rad18" runat="server" CssClass="inputradio">
                                                                                <asp:ListItem Value="And"></asp:ListItem>
                                                                                <asp:ListItem Selected="True" Value="Or"></asp:ListItem>
                                                                            </asp:RadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <span class="description">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_wc")%></span>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="dd18" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddc18" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddcv18" onchange="javascript:ShowValueDetails(this,'18');"
                                                                                runat="server" CssClass="inputselect">
                                                                                <asp:ListItem Value="Value" Selected="True"></asp:ListItem>
                                                                                <asp:ListItem Value="Variable"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trValue18" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:TextBox ID="txt18" runat="server" CssClass="inputtext"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trVariable18" style="display: none" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="ddVariable18" runat="server" CssClass="inputselect">
                                                                                <asp:ListItem Value="Variable.LoggedInUserId" Selected="True"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="text-align:left"colspan="2">
                                                                            <a href="#" id="a18" class="GridHyperlinkStyle" onclick="ShowDiv(this,'d19');return false;">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                            <div id="d19" style="display: none" runat="server">
                                                                <table style="border-width:0">
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:RadioButtonList RepeatDirection="Horizontal" ID="rad19" runat="server" CssClass="inputradio">
                                                                                <asp:ListItem Value="And"></asp:ListItem>
                                                                                <asp:ListItem Selected="True" Value="Or"></asp:ListItem>
                                                                            </asp:RadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <span class="description">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_wc")%></span>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="dd19" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddc19" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddcv19" onchange="javascript:ShowValueDetails(this,'19');"
                                                                                runat="server" CssClass="inputselect">
                                                                                <asp:ListItem Value="Value" Selected="True"></asp:ListItem>
                                                                                <asp:ListItem Value="Variable"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trValue19" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:TextBox ID="txt19" runat="server" CssClass="inputtext"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trVariable19" style="display: none" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="ddVariable19" runat="server" CssClass="inputselect">
                                                                                <asp:ListItem Value="Variable.LoggedInUserId" Selected="True"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="text-align:left"colspan="2">
                                                                            <a href="#" id="a19" class="GridHyperlinkStyle" onclick="ShowDiv(this,'d20');return false;">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                            <div id="d20" style="display: none" runat="server">
                                                                <table style="border-width:0">
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:RadioButtonList RepeatDirection="Horizontal" ID="rad20" runat="server" CssClass="inputradio">
                                                                                <asp:ListItem Value="And"></asp:ListItem>
                                                                                <asp:ListItem Selected="True" Value="Or"></asp:ListItem>
                                                                            </asp:RadioButtonList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <span class="description">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_wc")%></span>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="dd20" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddc20" runat="server" CssClass="inputselect">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddcv20" onchange="javascript:ShowValueDetails(this,'20');"
                                                                                runat="server" CssClass="inputselect">
                                                                                <asp:ListItem Value="Value" Selected="True"></asp:ListItem>
                                                                                <asp:ListItem Value="Variable"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trValue20" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:TextBox ID="txt20" runat="server" CssClass="inputtext"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trVariable20" style="display: none" runat="server">
                                                                        <td colspan="2">
                                                                            <asp:DropDownList ID="ddVariable20" runat="server" CssClass="inputselect">
                                                                                <asp:ListItem Value="Variable.LoggedInUserId" Selected="True"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="text-align:left"colspan="2">
                                                                            <a href="#" id="a20" class="GridHyperlinkStyle" onclick="ShowDiv(this,'d21');return false;">
                                                                                <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <!-- FILTER COLUMNS END-->
                        <tr>
                            <td>
                                <span class="description">
                                    <%=_Skrm.GlobalResourceSet.GetString("lv_setorderdesc")%></span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="inputsecondarybutton" Enabled="false"
                                    OnClick="btnClear_Click" OnClientClick="DisplayFilter()" />
                                <asp:Button ID="btnExpValidate" runat="server" Text="Validate" CssClass="inputbutton"
                                    Enabled="false" OnClick="btnExpValidate_Click" OnClientClick="DisplayFilter()" />
                                <asp:Button ID="btnGenerate" Enabled="false" runat="server" Text="Set Flter Order"
                                    CssClass="inputbutton" OnClick="btnGenerate_Click" OnClientClick="DisplayFilter()" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100%;">
                                <asp:TextBox ID="txtExpression" runat="server" Width="100%" CssClass="inputtext"
                                    Enabled="false" Height="85px" TextMode="MultiLine" onkeydown="return doGetCaretPosition(event,this);"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="lefttdbg" style="width: 40%; vertical-align: top">
                    <span class="subtitle">
                        <%=_Skrm.GlobalResourceSet.GetString("lv_Group")%></span><br />
                    <span class="description">
                        <%=_Skrm.GlobalResourceSet.GetString("lv_Groupdesc")%></span>
                </td>
                <td class="righttdbg">
                    <table style="border-width: 0">
                        <tr>
                            <td>
                                <span class="description">
                                    <%=_Skrm.GlobalResourceSet.GetString("lv_groupmode")%></span>:
                                <br />
                                <asp:RadioButtonList ID="rdGrpMode" runat="server" AutoPostBack="false" CssClass="inputradio"
                                    RepeatDirection="Vertical" RepeatLayout="Table">
                                    <asp:ListItem Selected="True" Value="Collapsed" ></asp:ListItem>
                                    <asp:ListItem Value="Expanded" ></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span class="description">
                                    <%=_Skrm.GlobalResourceSet.GetString("lv_fGc")%></span>
                                <br />
                                <!-- GROUP COLUMNS-->
                                <asp:DropDownList ID="ddfirstgroup" runat="server" AutoPostBack="false" Width="375px" CssClass="inputselect">
                                </asp:DropDownList>
                                <br />
                                <asp:RadioButtonList ID="rdfirstgrouptype" runat="server" AutoPostBack="false" CssClass="inputradio"
                                    RepeatDirection="Vertical" RepeatLayout="Table">
                                    <asp:ListItem Selected="True" Value="asc"></asp:ListItem>
                                    <asp:ListItem Value="desc"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span class="description">
                                    <%=_Skrm.GlobalResourceSet.GetString("lv_tgbc")%></span>
                                <br />
                                <asp:DropDownList ID="ddsecondgroup" runat="server" AutoPostBack="false" Width="375px" CssClass="inputselect">
                                </asp:DropDownList>
                                <br />
                                <asp:RadioButtonList ID="rdsecondgrouptype" runat="server" AutoPostBack="false" CssClass="inputradio"
                                    RepeatDirection="Vertical" RepeatLayout="Table">
                                    <asp:ListItem Selected="True" Value="asc"></asp:ListItem>
                                    <asp:ListItem Value="desc"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: left;">
                                <a href="#" id="a21" class="GridHyperlinkStyle" onclick="ShowDiv(this,'divgrp1');return false;">
                                    <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table>
                                    <tr>
                                        <td>
                                            <div id="divGroupMulCndn" runat="server">
                                                <div id="divgrp1" style="display: none" runat="server">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <span class="description">
                                                                    <%=_Skrm.GlobalResourceSet.GetString("lv_tgbc")%></span>
                                                                <br />
                                                                <asp:DropDownList ID="ddgrpclm1" runat="server" AutoPostBack="false" CssClass="inputselect">
                                                                </asp:DropDownList>
                                                                <br />
                                                                <asp:RadioButtonList ID="rdgrptype1" runat="server" AutoPostBack="false" CssClass="inputradio"
                                                                    RepeatDirection="Vertical" RepeatLayout="Table">
                                                                    <asp:ListItem Selected="True" Value="asc"></asp:ListItem>
                                                                    <asp:ListItem Value="desc"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align: left">
                                                                <a href="#" id="a22" class="GridHyperlinkStyle" onclick="ShowDiv(this,'divgrp2');return false;">
                                                                    <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div id="divgrp2" style="display: none" runat="server">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <span class="description">
                                                                    <%=_Skrm.GlobalResourceSet.GetString("lv_tgbc")%></span>
                                                                <br />
                                                                <asp:DropDownList ID="ddgrpclm2" runat="server" AutoPostBack="false" CssClass="inputselect">
                                                                </asp:DropDownList>
                                                                <br />
                                                                <asp:RadioButtonList ID="rdgrptype2" runat="server" AutoPostBack="false" CssClass="inputradio"
                                                                    RepeatDirection="Vertical" RepeatLayout="Table">
                                                                    <asp:ListItem Selected="True" Value="asc"></asp:ListItem>
                                                                    <asp:ListItem Value="desc"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align: left">
                                                                <a href="#" id="a23" class="GridHyperlinkStyle" onclick="ShowDiv(this,'divgrp3');return false;">
                                                                    <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div id="divgrp3" style="display: none" runat="server">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <span class="description">
                                                                    <%=_Skrm.GlobalResourceSet.GetString("lv_tgbc")%></span>
                                                                <br />
                                                                <asp:DropDownList ID="ddgrpclm3" runat="server" AutoPostBack="false" CssClass="inputselect">
                                                                </asp:DropDownList>
                                                                <br />
                                                                <asp:RadioButtonList ID="rdgrptype3" runat="server" AutoPostBack="false" CssClass="inputradio"
                                                                    RepeatDirection="Vertical" RepeatLayout="Table">
                                                                    <asp:ListItem Selected="True" Value="asc"></asp:ListItem>
                                                                    <asp:ListItem Value="desc"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align:left">
                                                                <a href="#" id="a24" class="GridHyperlinkStyle" onclick="ShowDiv(this,'divgrp4');return false;">
                                                                    <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div id="divgrp4" style="display: none" runat="server">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <span class="description">
                                                                    <%=_Skrm.GlobalResourceSet.GetString("lv_tgbc")%></span>
                                                                <br />
                                                                <asp:DropDownList ID="ddgrpclm4" runat="server" AutoPostBack="false" CssClass="inputselect">
                                                                </asp:DropDownList>
                                                                <br />
                                                                <asp:RadioButtonList ID="rdgrptype4" runat="server" AutoPostBack="false" CssClass="inputradio"
                                                                    RepeatDirection="Vertical" RepeatLayout="Table">
                                                                    <asp:ListItem Selected="True" Value="asc"></asp:ListItem>
                                                                    <asp:ListItem Value="desc"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align: left">
                                                                <a href="#" id="a25" class="GridHyperlinkStyle" onclick="ShowDiv(this,'divgrp5');return false;">
                                                                    <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div id="divgrp5" style="display: none" runat="server">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <span class="description">
                                                                    <%=_Skrm.GlobalResourceSet.GetString("lv_tgbc")%></span>
                                                                <br />
                                                                <asp:DropDownList ID="ddgrpclm5" runat="server" AutoPostBack="false" CssClass="inputselect">
                                                                </asp:DropDownList>
                                                                <br />
                                                                <asp:RadioButtonList ID="rdgrptype5" runat="server" AutoPostBack="false" CssClass="inputradio"
                                                                    RepeatDirection="Vertical" RepeatLayout="Table">
                                                                    <asp:ListItem Selected="True" Value="asc"></asp:ListItem>
                                                                    <asp:ListItem Value="desc"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align: left">
                                                                <a href="#" id="a26" class="GridHyperlinkStyle" onclick="ShowDiv(this,'divgrp6');return false;">
                                                                    <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div id="divgrp6" style="display: none" runat="server">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <span class="description">
                                                                    <%=_Skrm.GlobalResourceSet.GetString("lv_tgbc")%></span>
                                                                <br />
                                                                <asp:DropDownList ID="ddgrpclm6" runat="server" AutoPostBack="false" CssClass="inputselect">
                                                                </asp:DropDownList>
                                                                <br />
                                                                <asp:RadioButtonList ID="rdgrptype6" runat="server" AutoPostBack="false" CssClass="inputradio"
                                                                    RepeatDirection="Vertical" RepeatLayout="Table">
                                                                    <asp:ListItem Selected="True" Value="asc"></asp:ListItem>
                                                                    <asp:ListItem Value="desc"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align: left">
                                                                <a href="#" id="a27" class="GridHyperlinkStyle" onclick="ShowDiv(this,'divgrp7');return false;">
                                                                    <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div id="divgrp7" style="display: none" runat="server">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <span class="description">
                                                                    <%=_Skrm.GlobalResourceSet.GetString("lv_tgbc")%></span>
                                                                <br />
                                                                <asp:DropDownList ID="ddgrpclm7" runat="server" AutoPostBack="false" CssClass="inputselect">
                                                                </asp:DropDownList>
                                                                <br />
                                                                <asp:RadioButtonList ID="rdgrptype7" runat="server" AutoPostBack="false" CssClass="inputradio"
                                                                    RepeatDirection="Vertical" RepeatLayout="Table">
                                                                    <asp:ListItem Selected="True" Value="asc"></asp:ListItem>
                                                                    <asp:ListItem Value="desc"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align: left">
                                                                <a href="#" id="a28" class="GridHyperlinkStyle" onclick="ShowDiv(this,'divgrp8');return false;">
                                                                    <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div id="divgrp8" style="display: none" runat="server">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <span class="description">
                                                                    <%=_Skrm.GlobalResourceSet.GetString("lv_tgbc")%></span>
                                                                <br />
                                                                <asp:DropDownList ID="ddgrpclm8" runat="server" AutoPostBack="false" CssClass="inputselect">
                                                                </asp:DropDownList>
                                                                <br />
                                                                <asp:RadioButtonList ID="rdgrptype8" runat="server" AutoPostBack="false" CssClass="inputradio"
                                                                    RepeatDirection="Vertical" RepeatLayout="Table">
                                                                    <asp:ListItem Selected="True" Value="asc"></asp:ListItem>
                                                                    <asp:ListItem Value="desc"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align: left">
                                                                <a href="#" id="a29" class="GridHyperlinkStyle" onclick="ShowDiv(this,'divgrp9');return false;">
                                                                    <%=_Skrm.GlobalResourceSet.GetString("lv_smc")%></a>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <!-- GROUP COLUMNS END-->
            <%--   <tr visible="false">
        
            <td class="lefttdbg" valign="top">
                <span class="subtitle"><%=_Skrm.GlobalResourceSet.GetString("lv_ItemLimit")%></span><br />
                <span class="description"><%=_Skrm.GlobalResourceSet.GetString("lv_ItemLimitdesc")%></span>
            </td>
            <td class="righttdbg">
                <table>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtItemLimit" onblur="ValidateItemCount();" AutoCompleteType="Disabled" runat="server" CssClass="inputtext"
                                Width="40px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:RadioButtonList ID="radItemLimit" RepeatDirection="Vertical" CssClass="inputradio"
                                runat="server">
                                <asp:ListItem Selected="True" 
                                    Value="gridsize"></asp:ListItem>
                                <asp:ListItem Value="itemlimit"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>--%>
            <tr>
                <td class="lefttdbg" style="width: 40%; vertical-align: top">
                    <span class="subtitle">
                        <%=_Skrm.GlobalResourceSet.GetString("lv_DisplayAll")%></span><br />
                    <span class="description">
                        <%=_Skrm.GlobalResourceSet.GetString("lv_DisplayAll_desc")%></span>
                </td>
                <td class="righttdbg">
                    <asp:CheckBox ID="chkDisplayAll" runat="server" CssClass="inputcheckbox" AutoPostBack="false" />
                </td>
            </tr>
            <tr>
                <td class="lefttdbg" style="width: 40%; vertical-align: top">
                    <span class="subtitle">
                        <%=_Skrm.GlobalResourceSet.GetString("lv_ReadOnly")%></span><br />
                    <span class="description">
                        <%=_Skrm.GlobalResourceSet.GetString("lv_ReadOnly_Desc")%></span>
                </td>
                <td class="righttdbg">
                    <asp:CheckBox ID="chkReadOnly" runat="server" CssClass="inputcheckbox" AutoPostBack="false" />
                </td>
            </tr>
        </table>
    </div>
    <div id="divF" style="overflow: hidden">
        <table style="width: 100%; border-width: 0" >
            <tr>
                <td align="right" style="width: 90%; display: none;" runat="server" id="tdBtnDelete">
                    <asp:Button ID="btnDelete" OnClientClick="javascript:DeleteViewConfirm();return false;"
                        runat="server" CssClass="inputsecondarybutton" />
                     <asp:Button ID="btnHiddenDelete" 
                        runat="server" CssClass="inputsecondarybutton" OnClick="btnDelete_Click"  style="display:none;"/>
                </td>
                <td style="text-align:right; padding-right:10px;" id="tdViewSubmit" runat="server">
                    <asp:Button ID="btnSubmit" runat="server"  OnClientClick="javascript:return ReValidateViewName(this);"
                        CssClass="inputbutton" OnClick="btnSubmit_Click" width="160px" />
                    <asp:Button ID="btnSubmitData" runat="server" Style="display: none" CssClass="inputbutton"
                        OnClick="btnSubmitDate_Click" />
                </td>
            </tr>
        </table>
    </div>
    
        <telerik:RadWindowManager ID="RadWindowManager1" Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false"
            runat="server" Behaviors="Close,Move,Reload" Overlay="false" RenderMode="Classic" VisibleStatusbar="false">
            <Windows>
                <telerik:RadWindow ID="RadWindow1" runat="server" Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" RenderMode="Classic" VisibleStatusbar="false" EnableEmbeddedScripts="true" Behaviors="Close,Move,Reload" OnClientPageLoad="FixScrollForRad">
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>
    </form>
    <script type="text/javascript">
    
    function DeleteViewConfirm()
    {
        se.ui.messageDialog.showConfirmation( '<%=_Skrm.GlobalResourceSet.GetString("lv_listTitle").Replace("<#ListName>", _ListName)%>', '<%= _Skrm.GlobalResourceSet.GetString("lv_viewDeleteMess")%>',
                       function (userResponse) {
                           if (userResponse) {

                               document.getElementById('btnHiddenDelete').click();
                           }
                           
                       });





       // var res = confirm("<%= _Skrm.GlobalResourceSet.GetString("lv_viewDeleteMess")%>");


       // if (res)
     //   {
     //       return true;
      //  }
     //   else
     //   {
      //      return false;
     //   } 
    }

     function SendServerData()
    {
        var data="";
        var radSelection = "<%= radScope.ClientID %>";
        var chk = "<%=chkDV.ClientID %>";
        if(document.getElementById(chk).checked)
        {
            if(document.getElementById(radSelection+ "_0").checked)
                data = "pv";
            else
                data = "gv";    
        }
        
        CallServer(data);
    }


    function ValidateViewName()
    {
       
        var obj = document.getElementById("<%=txtVName.ClientID %>");
        var viewName = document.getElementById("<%=txtVName.ClientID %>").value;
        var sText=viewName;
        if (viewName=="")
  	   {
            
           // alert("<%= _Skrm.GlobalResourceSet.GetString("lv_emptyTitle")%>");
            se.ui.messageDialog.showError('<%=_Skrm.GlobalResourceSet.GetString("lv_listTitle").Replace("<#ListName>", _ListName)%>', '<%= _Skrm.GlobalResourceSet.GetString("lv_emptyTitle")%>');

           
  	        return false;
  	   }
  	   else if(sText.length>150)
  	   {

  	       // alert("<%= _Skrm.GlobalResourceSet.GetString("lv_Titlelength")%>");
  	       se.ui.messageDialog.showError('<%=_Skrm.GlobalResourceSet.GetString("lv_listTitle").Replace("<#ListName>", _ListName)%>', '<%= _Skrm.GlobalResourceSet.GetString("lv_Titlelength")%>');
  	        obj.focus();
  	       return false;
  	   }
  	   return true;
//  	   else
//  	   {
//        if(viewName)
//        {
////            var radSelection = "<%= radScope.ClientID %>";
////            if(document.getElementById(radSelection+ "_1").checked)
//                CallServer("vn@#$"+viewName);
//        }
//        }
        
    }
    
    function ContainsSpecialChar()
   {
       var obj =  document.getElementById("<%=txtVName.ClientID %>");
       //var iChars = "!@#$%^&*()+=-[]\\\';,./{}|\":<>?";
//       var iChars = "#&+[]~,.|<>";
       var iChars = "[#,~&+\"'<>|].";
       var sText=obj.value;
       if(obj.value != "")
       {
           for (var i = 0; i < sText.length; i++)
           {
  	           if (iChars.indexOf(sText.charAt(i)) != -1)
  	           {
  	                //alert ("Title has special characters. \nThese are not allowed.\n Please remove them and try again.");
  	              // alert("<%= _Skrm.GlobalResourceSet.GetString("lv_TitleSC")%>");
  	               se.ui.messageDialog.showError('<%=_Skrm.GlobalResourceSet.GetString("lv_listTitle").Replace("<#ListName>", _ListName)%>', '<%= _Skrm.GlobalResourceSet.GetString("lv_TitleSC")%>');
  	                obj.value="";
  	                obj.focus();
  	                return false;
  	           }
  	       }
  	       //ValidateViewName();
  	       
  	   }
  	 
//  	   else if (obj.value=="")
//  	   {
//  	       alert("<%= _Skrm.GlobalResourceSet.GetString("lv_emptyTitle")%>");
//  	        obj.focus();
//  	        return false;
//  	   }
//  	   
  	   
  	   return true;

   }
     
    
   
    function ReValidateViewName(btn)
    {
        var retValue=ValidateViewName();
        if(retValue)
        {
        var obj =  document.getElementById("<%=txtVName.ClientID %>");
        var radSelection = "<%= radScope.ClientID %>";
        var scope="";
        if(document.getElementById(radSelection+ "_1").checked)
            scope = "gv";
        else
            scope = "pv";
       // CallServer("rvn@#$"+obj.value+"@#$"+scope);
        }
        else        
        return false;
    }
    
    function ReceiveServerData(arg)
    {  
    
        
        if(arg)
        {
            var val=arg;
            var temp = arg.indexOf("@#$",0);
            if(temp > 0)
            {
                val=arg.split("@#$")[0]
            }
            switch(val)
            {
                case "vn":
                {
                   // alert(arg.split("@#$")[1]);
                    se.ui.messageDialog.showAlert('<%=_Skrm.GlobalResourceSet.GetString("lv_listTitle").Replace("<#ListName>", _ListName)%>', arg.split("@#$")[1]);
                    document.getElementById("<%=txtVName.ClientID %>").focus();
                    //document.getElementById("<%=txtVName.ClientID %>").value="";
                    break;
                }
            
                case "rvn":
                {
                     var res = arg.split("@#$")[1];
                     if(res == "submit")
                     {
                        //alert("Submitting form");
                        __doPostBack('btnSubmit','');
                        
                     }
                     else
                     {
                         // alert(arg.split("@#$")[1]);
                         se.ui.messageDialog.showAlert('<%=_Skrm.GlobalResourceSet.GetString("lv_listTitle").Replace("<#ListName>", _ListName)%>', arg.split("@#$")[1]);
                        document.getElementById("<%=txtVName.ClientID %>").focus();
                     }
                     break;   
                }
                default:
                {

                    se.ui.messageDialog.showConfirmation('<%=_Skrm.GlobalResourceSet.GetString("lv_listTitle").Replace("<#ListName>", _ListName)%>', "",
                       function (userResponse) {
                           if (userResponse) {

                            

                           }
                           else {
                               var chk = "<%=chkDV.ClientID %>";
                               document.getElementById(chk).checked = false;
                           }
                       });



                //   var res = confirm(arg);
                 //   if(res)
                //    {
                        // Do nothing
              //      }
              //      else
              //      {
               //        var chk = "<%=chkDV.ClientID %>";
                //      document.getElementById(chk).checked = false;
               
               //     } 
                }
                
                
            }
            
        }
    }
    
    function GetId(currentSelectedValue)
    {
        var id = "gridId_ctl";
        var tempId = currentSelectedValue+2;
        if(tempId < 10)
        {
            
            id += "0"+tempId+"_ddPos";
        }
        else
        {
            id += tempId+"_ddPos";
        }
        return id;
    }

    function UpdateDropDownValue(dropDownObj)
    {
       
        //get the current selected value
	    var currentSelectedValue=dropDownObj.value;
	    var hdn = document.getElementById("hdn"+dropDownObj.id);
	    // get the previous selected value
	    var previousValue = parseInt(hdn.value);
	    // update the hidden field with the current selected value
	    hdn.value = currentSelectedValue;
	
	    if (previousValue != currentSelectedValue)
	    {
		    var iInc = currentSelectedValue > previousValue? -1:1
		    var iMin = Math.min(currentSelectedValue, previousValue);
		    var iMax = Math.max(currentSelectedValue, previousValue);
		    // loop all the dropdown values
//		     debugger;
		    for (var iField = 0; iField < dropDownObj.length; iField++)
		    {
                var id = GetId(iField);
                var tempDropDownObj = document.getElementById(id);
		        var ddValue = parseInt(tempDropDownObj.value);
		        // below check will make sure that the drop down value of the selected will not be re changed
		        if(id != dropDownObj.id)
		        {
		            if(ddValue >= iMin && ddValue <= iMax)
	                {
                        var updatedValue = parseInt(ddValue+iInc);
	                    document.getElementById(id).value = updatedValue;
                        document.getElementById("hdn"+id).value = updatedValue;
                    }  
                }
		     }
			
	    }
    }
    
//    function UpdateSelection(chk,unselectChkId)
//    {
//       //debugger;
//       //trfilter
//       //radf
//       if(unselectChkId == 'radnf')
//            document.getElementById('trfilter').style.display = "block";     
//       else
//            document.getElementById('trfilter').style.display = "none";
//        chk.checked=true;
//        document.getElementById(unselectChkId).checked=false;
//        
//    }
    
    function OpenFilterWindow()
    {
        window.open('FilterQuery.aspx','filterwin','left=40,top=40,width=700,height=270,toolbar=0,resizable=0');
    }
    
   
    
    function ShowDiv(currentLinkObj,divObj)
    {
        currentLinkObj.style.display="none";
        if(document.getElementById(divObj))
        {
            document.getElementById(divObj).style.display="block";
        }
       
      //sstchur_SmartScroller_Scroll();
    }

    function FixScrollForRad(sender)
    {
        var windowFrm = document.getElementById('RadWindowContentFrame' + sender.Id);
        windowFrm.contentWindow.document.body.scroll = "no";
    }

function ShowValueDetails(ddObj,trOrder)
{
    var val = ddObj.value;
    
    if(val == "Value")
    {
        if(trOrder=="")
        {
            if(document.getElementById('txtMValue')!=null)
            {
            document.getElementById('txtMValue').value="";
            }
        }
       
                  var  div = document.getElementById('d'+trOrder); 
                    if (div != null)
                    {
                    if( document.getElementById('txt'+trOrder)!=null)
                     document.getElementById('txt'+trOrder).value="";
                    }
                
        document.getElementById('trValue'+trOrder).style.display="block";
        document.getElementById('trVariable'+trOrder).style.display="none";
    }
    else if(val == "Variable")
    {
     if(trOrder=="")
        {
    document.getElementById('ddVariable').selectedIndex = 0;
    }
      
                  var  div = document.getElementById('d'+trOrder); 
                    if (div != null)
                    {
                    if( document.getElementById('ddVariable'+trOrder)!=null)
                     document.getElementById('ddVariable'+trOrder).selectedIndex = 0;
                    }
               
        document.getElementById('trValue'+trOrder).style.display="none";
        document.getElementById('trVariable'+trOrder).style.display="block";
    }
}
function DisplayFilter()
{

document.getElementById('trfilter').style.display = "block";

}


    
   function doGetCaretPosition(e, ctrl)
    { 
     

        var CaretPos = 0;
        evt = e || window.event; //for Trans browser compatibility
        var keyPressed = evt.which || evt.keyCode;
  
        // IE Support
        if (document.selection)
         {
         ctrl.focus();
            
//            if(String.fromCharCode(keyPressed)=="9" || String.fromCharCode(keyPressed)=="0")
//            return false;commented because not allowing to enter bracket also
  
           // alert(keyPressed);
            if (window.event.keyCode == 8) 
            {
                       var Sel = document.selection.createRange();
       //                Sel = document.getElementById(ctrl.id).document.selection.createRange();
                        Sel.moveStart ('character', -ctrl.value.length);
                        CaretPos = Sel.text.length; 

                        if (Sel.text.charAt(CaretPos - 1) == "9"||Sel.text.charAt(CaretPos - 1) == "0" || Sel.text.charAt(CaretPos - 1) == "(" || Sel.text.charAt(CaretPos - 1) == ")")
                         {
                            return true;
                        }
                        else 
                        {
                            return false;
                        }
                
            }
             else if (keyPressed == 16||keyPressed == 35||keyPressed == 36)//35,36 -home and end should allow
             {
                return true;
             }
             
             else if(keyPressed == 57)
             {
              if (document.selection && ctrl.createTextRange)
                   {                   
                              var c = "\001", 
                              sel = document.selection.createRange(), 
                              dul = sel.duplicate(), 
                              len = 0; 
                         
                          dul.moveToElementText(ctrl); 
                          sel.text = c; 
                          len = dul.text.indexOf(c); 
                          sel.moveStart('character',-1); 
                          sel.text = "";
                        if(len==0)
                        return true;                        
                         var andopr=dul.text.charAt(len-4)+dul.text.charAt(len-3)+dul.text.charAt(len-2);
                         var oropr=dul.text.charAt(len-3)+dul.text.charAt(len-2);
                            if(andopr=="And"||oropr=="Or")
                            return true;
                            else return false;
                        
                        
                        
                   }
             
             }
            else if(keyPressed == 48)
             {
             
                  
                   if (document.selection && ctrl.createTextRange)
                   {                   
                              var c = "\001", 
                              sel = document.selection.createRange(), 
                              dul = sel.duplicate(), 
                              len = 0; 
                         
                          dul.moveToElementText(ctrl); 
                          sel.text = c; 
                          len = dul.text.indexOf(c); 
                          sel.moveStart('character',-1); 
                          sel.text = "";
                         if(len==-1)
                         return true;
                         var andOpr=dul.text.charAt(len+1)+dul.text.charAt(len+2)+dul.text.charAt(len+3);
                        var orOpr=dul.text.charAt(len+1)+dul.text.charAt(len+2);
                        
                        if(andOpr=="And"||orOpr=="Or")
                        return true;
                        else
                        return false;
                        
                   }
             }
           
                else if (keyPressed == 46)
                 {      //delete keycode
                    return false;
            
                }//37,39,38,40 up,down,left,right arrow 
                else if (keyPressed == 16)
                return true;
                else if(keyPressed == 40 || keyPressed == 41 || keyPressed == 57 || keyPressed == 48||keyPressed == 37 || keyPressed == 39 || keyPressed == 38)
                { 
                    return true;
                }
                else {

                    return false;
                    }
         
        }//Mozilla Support
          else if (ctrl.selectionStart || ctrl.selectionStart == '0')
            {
            
//          if(String.fromCharCode(keyPressed)=="9" ||String.fromCharCode(keyPressed)=="0")
//          {
//                return false;commented because not allowing to enter bracket also
//          }
                if (keyPressed == 8)
                 {
                    CaretPos = ctrl.selectionStart;
                    // alert(ctrl.value.charAt(CaretPos - 1));
                    if (ctrl.value.charAt(CaretPos - 1) == "9"||ctrl.value.charAt(CaretPos - 1) == "0" || ctrl.value.charAt(CaretPos - 1) == "(" || ctrl.value.charAt(CaretPos - 1) == ")") {

                        return true;
                    }
                    else {
                        return false;
                    }
                }
                else if (keyPressed == 46) {//delete keycode
                return false;

            }
            else if(keyPressed == 37 || keyPressed == 39 || keyPressed == 38 ||keyPressed == 40)//left,right,up,down keys
                    { 
                    return true;
                    }  
               else if (keyPressed == 16 || keyPressed == 41 || keyPressed == 57 || keyPressed == 48)//(=57 and )=48
                 {
                     CaretPos = ctrl.selectionStart;
                     var condAndOpr1 = ctrl.value.charAt(CaretPos)+ctrl.value.charAt(CaretPos+1)+ctrl.value.charAt(CaretPos+2);
                     var condAndOpr2 = ctrl.value.charAt(CaretPos-3)+ctrl.value.charAt(CaretPos-2)+ctrl.value.charAt(CaretPos-1);                    
                     var condAndOpr3 = ctrl.value.charAt(CaretPos-4)+ctrl.value.charAt(CaretPos-3)+ctrl.value.charAt(CaretPos-2);
                     var condAndOpr4 =ctrl.value.charAt(CaretPos+1)+ctrl.value.charAt(CaretPos+2)+ctrl.value.charAt(CaretPos+3);
                     var condOrOpr1 = ctrl.value.charAt(CaretPos)+ctrl.value.charAt(CaretPos+1);                   
                     var condOrOpr2 = ctrl.value.charAt(CaretPos-2)+ctrl.value.charAt(CaretPos-1);
                     var condOrOpr3 = ctrl.value.charAt(CaretPos-3)+ctrl.value.charAt(CaretPos-2);
                     var condOrOpr4=ctrl.value.charAt(CaretPos+1)+ctrl.value.charAt(CaretPos+2);
                      if(CaretPos==0)
                      return true;
                      else if(CaretPos==ctrl.value.length)
                      return true;
                    else if((condAndOpr1=="And" &&  (keyPressed==57)) || (condAndOpr1=="And" && (keyPressed==48))) //near to and should not allow   )
                     return false;
                     else if((condOrOpr1=="Or" &&(keyPressed==57)) || (condOrOpr1=="Or" &&(keyPressed==48)))//near to Or should not allow   )
                     return false;
                    else if((condAndOpr2=="And" ||condAndOpr2==" And" ||condAndOpr2=="And ")&&((keyPressed==48)||keyPressed==57))
                    return false;
                    else if(((condOrOpr2=="Or"||condOrOpr2==" Or" || condOrOpr2=="Or ")&&(keyPressed==48)) || (condOrOpr2=="Or" && (keyPressed==57)))//near to or should not allow )                 
                     return false;
                     else if(condAndOpr3=="And" && (keyPressed==48))
                     return false;
                   else if(condAndOpr4=="And" && (keyPressed==48))
                     return true;
                    else if(condAndOpr4=="And" && (keyPressed==57))
                     return false;
                     else if(condOrOpr3=="Or" && (keyPressed==48))
                     return false;  
                     else if(condOrOpr4=="Or" && (keyPressed==48))
                     return true;               
                else if(ctrl.value.charAt(CaretPos)== "=" || ctrl.value.charAt(CaretPos-1)== "=" ||ctrl.value.charAt(CaretPos+1)=="=" || ctrl.value.charAt(CaretPos-2)== "=" ||ctrl.value.charAt(CaretPos)== "!"||ctrl.value.charAt(CaretPos+1)== "!"||ctrl.value.charAt(CaretPos-1)== "!"||ctrl.value.charAt(CaretPos-2)== "!"||ctrl.value.charAt(CaretPos)== ">"||ctrl.value.charAt(CaretPos+1)== ">"||ctrl.value.charAt(CaretPos-1)== ">"||ctrl.value.charAt(CaretPos-2)== ">"||ctrl.value.charAt(CaretPos)== "<"||ctrl.value.charAt(CaretPos+1)== "<"||ctrl.value.charAt(CaretPos-1)== "<"||ctrl.value.charAt(CaretPos-2)== "<"||ctrl.value.charAt(CaretPos)== "%"||ctrl.value.charAt(CaretPos+1)== "%"||ctrl.value.charAt(CaretPos-1)== "%"||ctrl.value.charAt(CaretPos-2)== "%")
                 return false;
               else if(condAndOpr1!="And" && condOrOpr1!="Or" && (condAndOpr2!="And" && condAndOpr2!=" And" && condAndOpr2!="And ")&& condOrOpr2!="Or" && condOrOpr2!=" Or" && condOrOpr2!="Or " && condAndOpr3!="And" && condOrOpr3!="Or")
               return false;                           
                 else                    
                    return true;
                }
                else {

                    return false;
                }
                
            }
        
        
        return true;
    }
    </script>
</body>
</html>
