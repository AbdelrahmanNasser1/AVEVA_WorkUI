<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Forms.Web.CodeBehind.CreateGridConfigurations" EnableViewState="true" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html>
<html style="height: 100%" class="skscroll">
<head runat="server">
    <title>
      <%=_PageTitle %>
    </title>
    <script src="../../NextGenForms/js/jquery.min.js" type="text/javascript"></script>
    <script src="../../NextGenForms/js/knockout.min.js" type="text/javascript"></script>
    <script src="../../NextGenForms/js/xml2json.min.js" type="text/javascript"></script>
    <script src="../../NextGenForms/app/Skelta.min.js" type="text/javascript"></script>
    <script src="../../NextGenForms/js/kendodependencies.min.js" type="text/javascript"></script>
    <script src="../../NextGenForms/js/kendo.all.min.js" type="text/javascript"></script>
    <script src="../../NextGenForms/js/knockout-kendo.min.js" type="text/javascript"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <style type="text/css">
        input[type="text"]
        {
            padding-left: 3px;
        }

        #orderHeader, #orderTable
        {
            width: 100%;
        }

        #body *
        {
            margin: 0;
            padding: 0;
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            box-sizing: border-box;
        }

		#divparent
		{
            width: 100%;
            height: 100%;
		}
		#orderTable
		{
		    position:absolute;
			top:0;
			left:0;
			right:0;
			bottom:0;
		}
		
        #divbody>div
        {
            overflow-x: hidden;
            overflow-y: auto;
			position:relative;
        }

        #orderHeader
        {
            overflow: hidden;
        }

        #orderTable .tdbg,
        #orderHeader .tdbg
        {
            display: block;
            height: auto;
            padding: 2px;
        }

        #orderTable .trrow:last-child>.tdbg
        {
            border-width: 0;
        }

        #orderTable .trrow:last-child
        {
            border-width: 1px;
            border-color: rgb(224, 225, 221);
            border-style: solid;
        }

        #orderTable>div>.tdbg:first-child,
        #orderHeader>div>.tdbg:first-child
        {
            width: 250px;
            text-align: center; 
            padding: 5px;
            vertical-align: middle;
        }

        #orderTable>div>.tdbg:nth-child(2),
        #orderHeader>div>.tdbg:nth-child(2)
        {
            padding: 0;
            position: relative;
        }

        #orderTable>div>.tdbg:nth-child(3),
        #orderHeader>div>.tdbg:nth-child(3)
        {
            padding: 0;
            position: relative;
        }

        #orderTable>div>.tdbg:last-child,
        #orderHeader>div>.tdbg:nth-child(4)
        {
            width: 150px;
            padding: 5px;
            text-align: center;
            vertical-align: middle;
        }

        
        #orderHeader>div>.tdbg:nth-child(2),
        #orderHeader>div>.tdbg:nth-child(3)
        {
            padding: 5px;
            text-align: center; 
            vertical-align: middle;
        }

        .tdbgscrollplaceholder
        {
            width: 10px; /*Should match with the scrollbar width. the width is set as an inline style via javascript*/
        }
        
        #orderTable>div>.tdbg:first-child>input[type=text]
        {
            width: 75%;
        }

        .trrow
        {
            width: 100%;
        }

        .trrow:not(.tablebgdesc):not(.tablebgtitle):not(:last-child)
        {
            min-height: 100px;
        }

        .treepanel
        {
            position: absolute;
            width: 100%;
            height: 100%;
            overflow: hidden;
            padding-left:25px !important;
        }

        .treepanel>div
		{
		    overflow: auto;
		    width: 100%;
			height: 100%;
		}

        .treepanel>div>div
		{
		    overflow: hidden !important; 
		    display: inline;
		}
		
        #orderTable>.trrow:last-child
        {
            min-height: initial !important;
        }

        .tablebgtitle, .tablebgdesc
        {
            white-space: normal;
        }

        .tablebgtitle>.tdbg
        {
            text-align: center;
            font-size: 16px;
            border-width: 0;
        }

        .tablebgdesc>.tdbg
        {
            position: relative;
            white-space: pre-wrap;
            text-align: left !important;
        }

        .tablebgdesc>.tdbg>span
        {
            position: absolute;
            width: 100%;
            height: auto;
            top: 0;
            left: 0;
            white-space: pre-wrap;
            padding: 5px !important;
        }

        .popup
        {
            overflow: auto;
            background-color: White;
            border: 1px solid #cccccc;
        }

        table
        {
            border-collapse: separate;
            border-spacing: 0px;
        }

        /*This is added to handle some of Form pages to render in standards mode which uses Flex for layouting puposes*/
        html, form, body, #ajaxPanel
        {
            height: 100% !important;
            width: 100% !important;
            overflow: hidden !important;
        }

        .skh
        {
            min-height: 230px;
        }

        .skf
        {
            min-height: 50px;
            padding: 10px 6px !important;
        }

        .skf>.description
        {
            position: absolute;
            text-align: left;
            display: inline;
            left: 0px;
            bottom: 0px;
            padding: 10px !important;
        }

        .skf>.buttongroup
        {
            position: absolute; 
            display: inline; 
            right: 0px; 
            vertical-align: middle;
            padding-right: 10px !important;
        }

        input[type="button"][value="..."]
        {
            font-size: x-large !important;
            min-width: 15px !important;
            height: 27px !important;
            line-height: 110%;
            padding: 0 !important;
            border-style: none !important;
            margin-bottom: 5px !important;
        }
		
        .archestra input[type="button"][value="..."]
        {
            font-size: large !important;
        }

        .skdf,#orderTable, #orderHeader, #divbody, #divbody>div, .trrow, #divparent
        {
            display: -webkit-box;
            display: -moz-box;
            display: -ms-box;
            display: box;
            display: -webkit-flex;
            display: -moz-flex;
            display: -ms-flexbox;
            display: flex;
            vertical-align: top;
        }

        .skfjc
        {
            -webkit-box-pack: end;
            -moz-box-pack: end;
            -webkit-justify-content: flex-end;
            -ms-flex-pack: end;
            justify-content: flex-end;
        }

        .skfas
        {
            -webkit-box-flex-align: stretch; /* OLD - iOS 6-, Safari 3.1-6 */
            -moz-box-flex-align: stretch; /* OLD - Firefox 19- */
            -ms-box-flex-align: stretch;
            box-flex-align: stretch;
            -webkit-flex-align: stretch; /* Chrome */
            -moz-flex-align: stretch;
            -ms-flex-align: stretch; /* IE 10 */
            flex-align: stretch;
            -webkit-box-align: stretch;
            -moz-box-align: stretch;
            -ms-box-align: stretch;
            box-align: stretch;
        }

        .skfat
        {
            -webkit-box-flex-align: flex-start;
            -moz-box-flex-align: flex-start;
            -ms-box-flex-align: flex-start;
            box-flex-align: flex-start;
            -webkit-flex-align: flex-start;
            -moz-flex-align: flex-start;
            -ms-flex-align: flex-start;
            flex-align: flex-start;
            -webkit-box-align: start;
            -moz-box-align: start;
            -ms-box-align: start;
            box-align: start;
        }

        .skfac
        {
            -webkit-box-flex-align: center; /* OLD - iOS 6-, Safari 3.1-6 */
            -moz-box-flex-align: center; /* OLD - Firefox 19- */
            -ms-box-flex-align: center;
            box-flex-align: center;
            -webkit-flex-align: center; /* Chrome */
            -moz-flex-align: center;
            -ms-flex-align: center; /* IE 10 */
            flex-align: center;
            -webkit-box-align: center;
            -moz-box-align: center;
            -ms-box-align: center;
            box-align: center;
        }

        .skfdc, #orderTable, #orderHeader
        {
            -webkit-box-flex-orient: column; /* OLD - iOS 6-, Safari 3.1-6 */
            -moz-box-flex-orient: column; /* OLD - Firefox 19- */
            -ms-box-flex-orient: column;
            box-flex-orient: column;
            -moz-flex-direction: column;
            -webkit-flex-direction: column; /* Chrome */
            -ms-flex-direction: column; /* IE 10 */
            flex-direction: column;
            -moz-flex-flow: column;
            -webkit-flex-flow: column; /* Chrome */
            -ms-flex-flow: column; /* IE 10 */
            flex-flow: column;
            -webkit-box-direction: normal;
            -moz-box-direction: normal;
            -ms-box-direction: normal;
            box-direction: normal;
            -webkit-box-orient: vertical;
            -moz-box-orient: vertical;
            -ms-box-orient: vertical;
            box-orient: vertical;
            -webkit-box-lines: multiple;
            -moz-box-lines: multiple;
            -ms-box-lines: multiple;
            box-lines: multiple;
        }

        .skfdcr
        {
            -webkit-box-direction: reverse;
            -moz-box-direction: reverse;
            -ms-box-direction: reverse;
            box-direction: reverse;
            -webkit-box-orient: vertical;
            -moz-box-orient: vertical;
            -ms-box-orient: vertical;
            box-orient: vertical;
            -webkit-box-flex-orient: column-reverse;
            -moz-box-flex-orient: column-reverse;
            -ms-box-flex-orient: column-reverse;
            box-flex-orient: column-reverse;
            -moz-flex-direction: column-reverse;
            -webkit-flex-direction: column-reverse;
            -ms-flex-direction: column-reverse;
            flex-direction: column-reverse;
            -moz-flex-flow: column-reverse;
            -webkit-flex-flow: column-reverse;
            -ms-flex-flow: column-reverse;
            flex-flow: column-reverse;
            -webkit-flex-wrap: wrap;
            -moz-flex-wrap: wrap;
            -ms-flex-wrap: wrap;
            flex-wrap: wrap;
            -webkit-box-lines: multiple;
            -moz-box-lines: multiple;
            -ms-box-lines: multiple;
            box-lines: multiple;
        }

        .skfdr, .trrow
        {
            -webkit-box-flex-orient: row;
            -moz-box-flex-orient: row;
            -ms-box-flex-orient: row;
            box-flex-orient: row;
            -moz-flex-direction: row;
            -webkit-flex-direction: row;
            -ms-flex-direction: row;
            flex-direction: row;
            -moz-flex-flow: row;
            -webkit-flex-flow: row;
            -ms-flex-flow: row;
            flex-flow: row;
            -webkit-box-direction: normal;
            -moz-box-direction: normal;
            -ms-box-direction: normal;
            box-direction: normal;
            -webkit-box-orient: horizontal;
            -moz-box-orient: horizontal;
            -ms-box-orient: horizontal;
            box-orient: horizontal;
            -webkit-flex-wrap: wrap;
            -moz-flex-wrap: wrap;
            -ms-flex-wrap: wrap;
            flex-wrap: wrap;
            -webkit-box-lines: multiple;
            -moz-box-lines: multiple;
            -ms-box-lines: multiple;
            box-lines: multiple;
        }

        .skfdrr
        {
            -webkit-box-direction: reverse;
            -moz-box-direction: reverse;
            -ms-box-direction: reverse;
            box-direction: reverse;
            -webkit-box-orient: horizontal;
            -moz-box-orient: horizontal;
            -ms-box-orient: horizontal;
            box-orient: horizontal;
            -webkit-box-flex-orient: row-reverse;
            -moz-box-flex-orient: row-reverse;
            -ms-box-flex-orient: row-reverse;
            box-flex-orient: row-reverse;
            -moz-flex-direction: row-reverse;
            -webkit-flex-direction: row-reverse;
            -ms-flex-direction: row-reverse;
            flex-direction: row-reverse;
            -moz-flex-flow: row-reverse;
            -webkit-flex-flow: row-reverse;
            -ms-flex-flow: row-reverse;
            flex-flow: row-reverse;
            -webkit-flex-wrap: wrap;
            -moz-flex-wrap: wrap;
            -ms-flex-wrap: wrap;
            flex-wrap: wrap;
            -webkit-box-lines: multiple;
            -moz-box-lines: multiple;
            -ms-box-lines: multiple;
            box-lines: multiple;
        }

        .skfdrnowrap
        {
            -webkit-flex-wrap: nowrap;
            -moz-flex-wrap: nowrap;
            -ms-flex-wrap: nowrap;
            flex-wrap: nowrap;
        }

        .skflx, 
		#divbody,
        #divbody>div, 
        #orderTable, 
        .trrow,
        #orderTable>div>.tdbg:nth-child(2),
        #orderHeader>div>.tdbg:nth-child(2),
        #orderTable>div>.tdbg:nth-child(3),
        #orderHeader>div>.tdbg:nth-child(3)
        {
            -webkit-box-flex: 1; /* OLD - iOS 6-, Safari 3.1-6 */
            -moz-box-flex: 1; /* OLD - Firefox 19- */
            -ms-box-flex: 1; /* IE 10 */
            box-flex: 1;
            -webkit-flex: 1 0 auto; /* Chrome */
            -moz-flex: 1;
            -ms-flex: 1 0 auto; /* IE 10 */
            flex: 1 0 auto;
        }

        .skflxnogrow,  #orderTable>.trrow:last-child, #orderHeader, .tablebgdesc, .tablebgtitle
        {
            -webkit-box-flex: 0; /* OLD - iOS 6-, Safari 3.1-6 */
            -moz-box-flex: 0; /* OLD - Firefox 19- */
            -ms-box-flex: 0; /* IE 10 */
            box-flex: 0;
            -webkit-flex: 0 1 auto; /* Chrome */
            -moz-flex: 0;
            -ms-flex: 0 1 auto; /* IE 10 */
            flex: 0 1 auto;
        }

    </style>
    <script type="text/javascript">
        var skeltaUtils = skelta.forms.utilities;
    </script>
</head>
<body id="body" style="padding: 0px; margin: 0px; overflow: hidden;" onload="CheckScreenHeight();">
     <telerik:RadCodeBlock ID="RadCodeBlock"  runat="server">
    <script>
        
        skelta.serverUrl = "../../NextGenForms/";

        se.ui.messageDialog.setGlobalOptions({
            localization: {
                closeButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                okButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
                cancelButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                showDetailsCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                hideDetailsCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
            }
        });


        function DisplayErrorMessage(strMessage)
        {
            var strHdrMsg = '<%=_ResManager.GlobalResourceSet.GetString("FormConfigurationNameProperty")%>';
            se.ui.messageDialog.showError(strHdrMsg, strMessage);
        }
        
        try
        {
            var isArchestra = skelta.utilities.getUrlParameterValue(window.parent, "FromArchestrA");

            if (!skelta.utilities.isUndefinedNullOrEmpty(isArchestra))
            {
                isArchestra = (isArchestra.toLowerCase() === "true") ? true : false;
            }
            else
            {
                isArchestra = false;
            }

            if (isArchestra)
            {
                $("body").addClass("archestra");
            }
        }
        catch (e)
        {
            // Nothing
            }
      
    </script>
</telerik:RadCodeBlock>
    <form id="gridconfig" runat="server">
        <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
         </telerik:RadScriptBlock>
         <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
          </telerik:RadScriptManager>
        <telerik:RadScriptBlock ID="RadScriptBlock2" runat="server">
        <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(_ThemeURL)%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
        <link href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(_ThemeURL)%>CommonUXControls/StyleSheet/se.ui.min.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(_ThemeURL)%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css" />         
        <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(_ThemeURL)%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css" />
        <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(_ThemeURL)%>TelerikAjax/StyleSheet/AWTTreeView/TreeView.AWTTreeView.css" />
        <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(_ThemeURL)%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css" />
            <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(_ThemeURL)%>TelerikAjax/StyleSheet/AWTWindow/Window.css" />            
        </telerik:RadScriptBlock>    
        <telerik:RadAjaxPanel ID="ajaxPanel" runat="server" Height="100%">
            <telerik:RadCodeBlock ID="RadCodeBlock1"  runat="server">
             <div id="divparent" class='skfc skcn skfdc skfas skfmd'>
                <input id="hdnIsBrowserIEType" runat="server" type="hidden" enableviewstate="true" />
                <div id="divheader" class="skh" style="padding-left: 10px; padding-right: 10px;">
                    <asp:HiddenField ID="selectedControl" runat="Server" />
                    <asp:HiddenField ID="tempDefinitionField" runat="Server" />
                    <asp:HiddenField ID="gridExpressionField" runat="Server" />
                    <asp:HiddenField ID="parameterMappingField" runat="Server" />
                    <asp:HiddenField ID="gridUpdateField" runat="Server" />
                    <table>
                        <tr>
                            <td>
                                <table>
                                    <tr>
                                        <td class="pagetitle" style="padding: 5px">
                                            <img src="<%=_ThemeURL%>/Repository/ListControl/images/icons-ribbon/GridConfig.png" alt="<%=_ThemeURL%>/Repository/ListControl/images/icons-ribbon/GridConfig.png"
                                                style="vertical-align: middle" />&nbsp;<%= _PageTitle%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="description" colspan="2" style="padding: 5px">
                                            <img id="noteImage" runat="server" alt="" src="" style="vertical-align: middle" />
                                            <%= _PageDescription%>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table id="headerTable" style="width: 100%" runat="server" class="tablebg">
                                    <tr id="titleRow">
                                        <td class="lefttdbg" style="padding: 2px; width: 40%">
                                            <span class="subtitle">
                                                <%=  _ResManager.GlobalResourceSet.GetString("sk_gridconfig_titlelbl")%></span>
                                            <img alt="Mandatory" id="imgTitlemandator" runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/Images/mandatoryicon.png%>"
                                                hspace="2" align="top" visible="true" />
                                            <asp:RequiredFieldValidator runat="server" ID="reqName" ControlToValidate="titleBox"
                                                SetFocusOnError="true" CssClass="errormsg" Display="Dynamic">
                                        <img  alt=" <%=_ResManager.GlobalResourceSet.GetString("sk_gridconfig_titlevalidation")%>" 
                                                id="imageUserToBeReplaced"  src="../../Skeltaforms/images/erroricon.png" />
                                            </asp:RequiredFieldValidator>
                                            <br />
                                            <span class="description">
                                                <%=_ResManager.GlobalResourceSet.GetString("sk_gridconfig_titledesclbl")%></span>
                                        </td>
                                        <td class="righttdbg" style="width: 60%; padding: 2px">
                                            <asp:TextBox ID="titleBox" MaxLength="100" runat="server" CssClass="inputtext" Width="50%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr id="descriptionRow">
                                        <td class="lefttdbg" style="width: 40%; padding: 2px">
                                            <span class="subtitle">
                                                <%= _ResManager.GlobalResourceSet.GetString("sk_gridconfig_desclbl")%></span>
                                            <br />
                                            <span class="description">
                                                <%= _ResManager.GlobalResourceSet.GetString("sk_gridconfig_subdesclbl")%></span>
                                        </td>
                                        <td class="righttdbg" style="width: 60%; padding: 2px">
                                            <asp:TextBox ID="descriptionBox" runat="server" Rows="3" TextMode="multiline" CssClass="inputtextarea"
                                                Width="90%" Height="50px" onkeyup="return checkMaxLenForDescriptionBox(this,501)"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr id="dataSourceRow" runat="server">
                                        <td class="lefttdbg" style="width: 40%; padding: 2px">
                                            <span class="subtitle">
                                                <%= _ResManager.GlobalResourceSet.GetString("sk_gridconfig_dstype")%></span>
                                            <br />
                                            <span class="description">
                                                <%= _ResManager.GlobalResourceSet.GetString("sk_gridconfig_dstypedesc")%></span>
                                        </td>
                                        <td class="righttdbg" style="width: 60%; padding: 2px">
                                            <telerik:RadComboBox ID="sourceTypeComboBox" runat="server" Skin="AWTCombobox"  EnableEmbeddedSkins="false" RenderMode="Classic" AutoPostBack="true" Width="40%"> 
                                            </telerik:RadComboBox>
                                       </td>
                                    </tr>
                                    <tr id="hierarchicalLevelRow">
                                        <td class="lefttdbg" style="width: 40%; padding: 2px">
                                            <span class="subtitle">
                                                <%= _ResManager.GlobalResourceSet.GetString("sk_gridconfig_hierarchicallevel")%></span>
                                            <br />
                                            <span class="description">
                                                <%= _ResManager.GlobalResourceSet.GetString("sk_gridconfig_hierarchicalleveldesc")%></span>
                                        </td>
                                        <td class="righttdbg" style="width: 60%; padding: 2px">
                                             <telerik:RadComboBox ID="hierarchicalLevelComboBox" runat="server" Skin="AWTCombobox" AutoPostBack="true"  EnableEmbeddedSkins="false" Width="40%" RenderMode="Classic" OnSelectedIndexChanged="hierarchicalLevelComboBox_SelectedIndexChanged" Height="80px">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <div id="orderHeader" style="width: 100%;">
                        <div id="Tr9" class="tablebgtitle trrow">
                            <div class="tdbg"><%=  _ResManager.GlobalResourceSet.GetString("sk_gridconfig_lookupsourcecolheader")%></div>
                            <div class="tdbg"><%=  _ResManager.GlobalResourceSet.GetString("sk_gridconfig_viewselectioncolheader")%></div>
                            <div class="tdbg"><%=  _ResManager.GlobalResourceSet.GetString("sk_gridconfig_persistselectioncolheader")%></div>
                            <div class="tdbg"><%=  _ResManager.GlobalResourceSet.GetString("sk_gridconfig_allowselectioncolheader")%></div>
                            <div class="tdbgscrollplaceholder"></div>
                        </div>
                        <div id="Tr10" class="tablebgdesc trrow">
                            <div class="description tdbg">
                                <span><%=  _ResManager.GlobalResourceSet.GetString("sk_gridconfig_lookupsourcecoldesc")%></span>
                            </div>
                            <div class="description tdbg">
                                <span><%=  _ResManager.GlobalResourceSet.GetString("sk_gridconfig_viewselectioncoldesc")%></span>
                            </div>
                            <div class="description tdbg">
                                <span><%=  _ResManager.GlobalResourceSet.GetString("sk_gridconfig_persistselectioncoldesc")%></span>
                            </div>
                            <div class="description tdbg">
                                <span><%=  _ResManager.GlobalResourceSet.GetString("sk_gridconfig_allowselectioncoldesc")%></span>
                            </div>
                            <div class="tdbgscrollplaceholder"></div>
                        </div>
                    </div>                   
                </div>
                <div id="divbody" style="padding-left: 10px; padding-right: 10px;">
                    <div class="sksa skfc skfdc skfas" enableviewstate="true">
                        <div id="orderTable" runat="server" style="width: 100%;" EnableViewState="True">
                            <div id="Tr1" class="trrow" runat="server" EnableViewState="True" Visible="False">
                                <div class="tdbg">
                                    <input type="text" id="txtlookup1" value="" runat="server" enableviewstate="true"
                                        style="" class="inputtext" readonly="readonly" /> 

                                    <input type="hidden" id="hdnlookup1" value="" runat="server" enableviewstate="true" />
                                    <asp:HiddenField ID="hdnColumnSettings1" runat="Server" />
                                    <input type="button" id="btnRGAValue" value="..." runat="server" enableviewstate="true" txtid="txtlookup1" hdntxtid="hdnlookup1"
                                        onserverclick="InitializeLookupsTree" class="inputbutton" />

                                </div>
                                <div class="tdbg">
                                    <asp:Panel ID="Panel2" class="treepanel" runat="server">
                                        <telerik:RadTreeView ID="RadTreeView1" runat="server" AllowNodeEditing="true" OnNodeEdit="HandleNodeEdit" CheckBoxes="true"
                                         OnClientNodeEditStart="ClientNodeEditStartHandler" OnClientNodeEdited="ClientNodeClickLeaveHandler"  Skin="AWTTreeView" EnableEmbeddedSkins="false" RenderMode="Classic" ShowLineImages="false">
                                        </telerik:RadTreeView>
                                    </asp:Panel>
                                </div>
                                <div class="tdbg">
                                    <asp:Panel ID="Panel3" class="treepanel"  runat="server">
                                        <telerik:RadTreeView ID="RadTreeView2" runat="server" RetainScrollPosition="true" CheckBoxes="true" Skin="AWTTreeView" OnClientNodeClicking="BeforeClientClick" OnClientNodeChecking="BeforeCheckHandler" EnableEmbeddedSkins="false" RenderMode="Classic" ShowLineImages="false">
                                        </telerik:RadTreeView>
                                    </asp:Panel>
                                </div>
                                <div class="tdbg">
                                    <asp:RadioButton ID="CheckBox1" runat="server" GroupName="AllowSelection" />
                                </div>
                            </div>
                            <div id="Tr2" class="trrow" runat="server" EnableViewState="True" visible="false">
                                <div class="tdbg">
                                    <input type="text" id="txtlookup2" value="" runat="server" enableviewstate="true"
                                        class="inputtext" readonly="readonly" />
                                    <input type="hidden" id="hdnlookup2" value="" runat="server" enableviewstate="true" />
                                    <input type="button" id="Button1" value="..." runat="server" enableviewstate="true" onserverclick="InitializeLookupsTree" txtid="txtlookup2" hdntxtid="hdnlookup2" class="inputbutton" />
                                </div>
                                <div class="tdbg">
                                    <asp:Panel ID="Panel5" class="treepanel"  runat="server">
                                        <telerik:RadTreeView ID="RadTreeView3" Skin="AWTTreeView" runat="server" AllowNodeEditing="True"  OnClientNodeEditStart="ClientNodeEditStartHandler" OnClientNodeEdited="ClientNodeClickLeaveHandler" CheckBoxes="true" OnNodeEdit="HandleNodeEdit" EnableEmbeddedSkins="false" RenderMode="Classic" ShowLineImages="false">
                                        </telerik:RadTreeView>
                                    </asp:Panel>
                                </div>
                                <div class="tdbg">
                                    <asp:Panel ID="Panel6" class="treepanel"  runat="server">
                                        <telerik:RadTreeView ID="RadTreeView4" Skin="AWTTreeView" runat="server" CheckBoxes="true"  OnClientNodeClicking="BeforeClientClick"  OnClientNodeChecking="BeforeCheckHandler" EnableEmbeddedSkins="false" RenderMode="Classic" ShowLineImages="false">
                                        </telerik:RadTreeView>
                                     </asp:Panel>
                                </div>
                                <div class="tdbg">
                                    <asp:RadioButton ID="CheckBox2" runat="server" GroupName="AllowSelection" />
                                </div>
                            </div>
                            <div id="Tr3" class="trrow" runat="server" EnableViewState="True" visible="false">
                                <div class="tdbg">
                                    <input type="text" id="txtlookup3" value="" runat="server" enableviewstate="true"
                                        class="inputtext" readonly="readonly" />
                                    <input type="hidden" id="hdnlookup3" value="" runat="server" enableviewstate="true" />
                                    <input type="button" id="Button2" value="..." runat="server" enableviewstate="true" onserverclick="InitializeLookupsTree" txtid="txtlookup3" hdntxtid="hdnlookup3" class="inputbutton" />
                                </div>
                                <div class="tdbg">
                                    <asp:Panel ID="Panel8" class="treepanel" runat="server">
                                        <telerik:RadTreeView ID="RadTreeView5" Skin="AWTTreeView" runat="server" CheckBoxes="true"  OnClientNodeEditStart="ClientNodeEditStartHandler" OnClientNodeEdited="ClientNodeClickLeaveHandler" OnNodeEdit="HandleNodeEdit" EnableEmbeddedSkins="false" RenderMode="Classic" ShowLineImages="false" AllowNodeEditing="True">
                                        </telerik:RadTreeView>
                                    </asp:Panel>
                                </div>
                                <div class="tdbg">
                                    <asp:Panel ID="Panel9" class="treepanel"  runat="server">
                                         <telerik:RadTreeView ID="RadTreeView6" Skin="AWTTreeView" runat="server" CheckBoxes="true"  OnClientNodeClicking="BeforeClientClick"  OnNodeEdit="HandleNodeEdit" OnClientNodeChecking="BeforeCheckHandler" EnableEmbeddedSkins="false" RenderMode="Classic" ShowLineImages="false">
                                        </telerik:RadTreeView>
                                   </asp:Panel>
                                </div>
                                <div class="tdbg">
                                    <asp:RadioButton ID="CheckBox3" runat="server" GroupName="AllowSelection" />
                                </div>
                            </div>
                            <div id="Tr4" class="trrow" runat="server" EnableViewState="True" visible="false">
                                <div class="tdbg">
                                    <input type="text" id="txtlookup4" value="" runat="server" enableviewstate="true"
                                        class="inputtext" readonly="readonly" />
                                    <input type="hidden" id="hdnlookup4" value="" runat="server" enableviewstate="true" />
                                    <input type="button" id="Button3" value="..." runat="server" enableviewstate="true" onserverclick="InitializeLookupsTree" txtid="txtlookup4" hdntxtid="hdnlookup4" class="inputbutton" />
                                </div>
                                <div class="tdbg">
                                    <asp:Panel ID="Panel11" class="treepanel"  runat="server">
                                         <telerik:RadTreeView ID="RadTreeView7" Skin="AWTTreeView" runat="server" CheckBoxes="true"  OnClientNodeEditStart="ClientNodeEditStartHandler" OnClientNodeEdited="ClientNodeClickLeaveHandler" OnNodeEdit="HandleNodeEdit" AllowNodeEditing="True" EnableEmbeddedSkins="false" RenderMode="Classic" ShowLineImages="false">
                                        </telerik:RadTreeView>
                                    </asp:Panel>
                                </div>
                                <div class="tdbg">
                                    <asp:Panel ID="Panel12" class="treepanel" runat="server">
                                         <telerik:RadTreeView ID="RadTreeView8" Skin="AWTTreeView" runat="server" CheckBoxes="true"  OnClientNodeClicking="BeforeClientClick" OnClientNodeChecking="BeforeCheckHandler" EnableEmbeddedSkins="false" RenderMode="Classic" ShowLineImages="false">
                                        </telerik:RadTreeView>
                                    </asp:Panel>
                                </div>
                                <div class="tdbg">
                                    <asp:RadioButton ID="CheckBox4" runat="server" GroupName="AllowSelection" />
                                </div>
                            </div>
                            <div class="trrow">
                                <div class="tdbg"></div>
                                <div class="tdbg"></div>
                                <div class="tdbg"></div>
                                <div class="tdbg">
                                                <b><%=  _ResManager.GlobalResourceSet.GetString("sk_gridconfig_disableselection")%></b><br />
                                                <asp:RadioButton ID="CheckBox0" runat="server" GroupName="AllowSelection" />
                                </div>                           
                            </div>
                        </div>
                    </div>
                </div>
                <div id="divfooter" class="skf">
                    <div class="description"> 
                    <%=  _ResManager.GlobalResourceSet.GetString("sk_gridconfig_savenote")%>
                      </div>
                    <div class="buttongroup">
                           <asp:Button UseSubmitBehavior="false" ID="advancedSettingsBtn" runat="server" CssClass="inputbutton"
                            OnClick="HandleAdvancedSettingsClick" OnClientClick="CheckTitleEmpty();" />
                        <input type="button" id="openParameterMappingsButton" runat="server" class="inputbutton"
                            onclick="openParameterMappingUI(); return false" />
                        <asp:Button UseSubmitBehavior="false" ID="btnClose" runat="server" CssClass="inputsecondarybutton" CausesValidation="false"
                            OnClick="btnClose_click" />
                        <asp:Button UseSubmitBehavior="false" ID="saveBtn" runat="server" CssClass="inputbutton" OnClick="saveBtn_click"
                            OnClientClick="CheckTitleEmpty();" />
                    </div>
                     <telerik:RadWindowManager ID="Singleton" EnableEmbeddedSkins="false" Behaviors="None" runat="server" RenderMode="Classic" Skin="AWTWindow" VisibleStatusbar="false">         
                      <Windows>
                          <telerik:RadWindow ID="AdvancedSettingsWindow"  Behaviors="None" runat="server" Left="" Title="Advanced Settings"   VisibleStatusbar="false" RenderMode="Classic" EnableEmbeddedSkins="false"  Skin="AWTWindow"   >
                          </telerik:RadWindow>
                      </Windows> 
                     </telerik:RadWindowManager>
                     </div>
                <div style="display: none;" id="divLookupTreeview" runat="server">
                        <table style="width: 100%; border-width: 0" class="tableheaderbg">
                        <tr>
                            <td style="width: 100%; text-align: right">
                                <a id="a2" onclick="CloseDivControls(0)">
                                    <img style="border: 0" src="<%=_ThemeURL%>Common/Images/close.gif" alt="" /></a>
                            </td>
                        </tr>
                    </table>
                       <telerik:RadTreeView ID="LookUpTreeView" Skin="AWTTreeView" runat="server" Height="175px" AutoPostBack="true" OnClientNodeClicked="GetRadNode" 
                           OnClientNodeClicking="LookupTreeBeforeClientClick" OnNodeClick="LookUpTreeView_NodeClick" EnableEmbeddedSkins="false" RenderMode="Classic" ShowLineImages="false">
                        </telerik:RadTreeView>    
                 </div>
                <div style="display: none;" id="divLookupWithParametersTreeview" runat="server">
                        <table style="width: 100%; border-width: 0" class="tableheaderbg">
                        <tr>
                            <td style="width: 100%; text-align: right">
                                <a id="a2" onclick="CloseDivControls(1)">
                                    <img style="border: 0" src="<%=_ThemeURL%>Common/Images/close.gif" alt="" /></a>
                            </td>
                        </tr>
                    </table>
                     <telerik:RadTreeView ID="LookupWithParametersTreeView" Skin="AWTTreeView" runat="server" Height="175px" AutoPostBack="true" OnClientNodeClicked="GetRadNode2" ShowLineImages="false"
                           OnClientNodeClicking="LookupTreeBeforeClientClick" OnNodeClick="LookUpTreeView_NodeClick" EnableEmbeddedSkins="false" RenderMode="Classic">
                        </telerik:RadTreeView>
                   </div>            
            </div>
          </telerik:RadCodeBlock>   
         </telerik:RadAjaxPanel>
        <telerik:RadCodeBlock ID="RadCodeBlock3"  runat="server">    
        <script type="text/javascript">
      
            document.getElementById('titleBox').focus();

            var text;
            var val;
            var oWin = GetRadWindow();
            var newMode = false;
            if (oWin != null || oWin != undefined)
            {
                var oCWinHeight = 0.88 * oWin.get_height() + 40;
                var oCWinWidth = oWin.get_width() - 25;
            }

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

            function CheckScreenHeight()
            {
                var height = window.outerHeight;
                if (height > 0)
                {
                    height = height - 120;
                }
                else
                {
                    height = 600;
                }

                if (window.screen.height <= 800)
                {
                    if (window.parent.parent.location.href.indexOf('FromArchestrA') != -1)
                    {
                        oWin.set_height(600);
                    }
                    else
                    {
                        oWin.set_height(height);
                    }
                    oWin.center();
                }
            }
            function GetRadWindow()
            {
                var oWindow = null;
                if (window.frameElement != null)
                    oWindow = window.frameElement.radWindow;
                return oWindow;
            }

            function closeWindow(msg)
            {
                if (msg)
                // alert(msg);
                    se.ui.messageDialog.showAlert('<%=_ResManager.GlobalResourceSet.GetString("FormConfigurationNameProperty")%>', msg);
                var oWindow = GetRadWindow();
                oWindow.close();
            }

            //To Disable the node Click for Persist Columns
            function BeforeClientClick(node, eventArgs)
            {
                
                return false;
            }


            function ClientNodeEditStartHandler(sender, eventArgs)
            {
                var node = eventArgs.get_node();
                var textInput = node.get_inputElement();
                var textValue = node.get_text();
                if (textValue !== undefined &&
                    textValue !== null &&
                    textValue !== "")
                {
                    var startPos = textValue.indexOf("[");

                    if (startPos > -1) {
                        var endPos = textValue.lastIndexOf("]");

                        if (endPos > -1 && startPos < endPos) {
                            textValue = textValue.substring(startPos + 1, endPos);
                        }
                        else {
                            textValue = "";
                        }
                    }
                }
                textInput.value = textValue;
                node.select();
            }

            function ClientNodeClickLeaveHandler(sender, eventArgs) {
                var node = eventArgs.get_node();
                if (node.get_text() == "")
                {
                    node.set_text(node.get_value());
                }
            }


           //Persist Columns checking cannot have columns special characters and begin with numbers
            function BeforeCheckHandler(sender, eventArgs)
            {
                var node = eventArgs.get_node();
                var columnName = node.get_text();
                if (columnName)
                {
                    var pattern = "^['0-9]";
                    var iChars = "~! @#$%^&*()+|`-=\\{}:\"<>?[];',./";
                    var isMatch = columnName.match(pattern);
                    if (isMatch == null)
                    {
                        for (var i = 0; i < columnName.length; i++)
                        {
                            if (iChars.indexOf(columnName.charAt(i)) != -1)
                            {
                                se.ui.messageDialog.showError('<%=_ResManager.GlobalResourceSet.GetString("FormConfigurationNameProperty")%>', '<%=_PersistSpaceError%>');
                                return false;
                            }
                        }
                    }
                    else
                    {
                        se.ui.messageDialog.showError('<%=_ResManager.GlobalResourceSet.GetString("FormConfigurationNameProperty")%>', '<%=_PersistSpaceError%>');
                        return false;
                    }
                    return true;
                }
                else
                {
                    // alert('<%=_PersistSpaceError%>');
                    se.ui.messageDialog.showError('<%=_ResManager.GlobalResourceSet.GetString("FormConfigurationNameProperty")%>', '<%=_PersistSpaceError%>');
                    return false;
                }
            }

            function AfterEditHandler(node, oldText, newText)
            {
                node.Text = newText;
            }

            function GiveAlert(msg)
            {
                alert(msg);
            }

            //calling build expression functions            
            function OpenAdvancedSettings(title, lookupIds, tempFileId, tempDefinition)
            {
                document.getElementById("tempDefinitionField").value = tempDefinition;
                var url = "AdvancedSettingsForGridConfiguration.aspx?title=" + title + "&ids=" + lookupIds + "&tmpFile=" + tempFileId;
                var oWindow = radopen(url, "AdvancedSettingsWindow");
                oWindow.setSize(oCWinWidth, oCWinHeight);
                oWindow.set_modal(true);
                oWindow.center();
                
            }

          
            function EditAdvancedSettings(gridConfigId, lookupIds, tempFileId, tempDefinition)
            {
                document.getElementById("tempDefinitionField").value = tempDefinition;
                var url = "AdvancedSettingsForGridConfiguration.aspx?mode=edit&id=" + gridConfigId + "&ids=" + lookupIds + "&tmpFile=" + tempFileId;
                var oWindow = radopen(url, "AdvancedSettingsWindow");
                oWindow.setSize(oCWinWidth, oCWinHeight);
                oWindow.set_modal(true);
                oWindow.center();
            }

            function ViewAdvancedSettings(gridConfigId, lookupIds, tempFileId)
            {
                var url = "AdvancedSettingsForGridConfiguration.aspx?mode=view&id=" + gridConfigId + "&ids=" + lookupIds + "&tmpFile=" + tempFileId;
                var oWindow = radopen(url, "AdvancedSettingsWindow");
                oWindow.setSize(oCWinWidth, oCWinHeight);
                oWindow.center();
            }

            // Initialize the table header last row to take the scrollbar width
            function initializeHeaderAlignment(){
                var bodyDivWithScroll = $("#divbody>div")[0];
                var scrollBarWidth = bodyDivWithScroll.offsetWidth - bodyDivWithScroll.clientWidth;

                $(".tdbgscrollplaceholder").width(scrollBarWidth.toString() + "px");
            }

            function onScrollNoteValue(){
                window.scrolltopval = window.scrolltopval || 0;

                window.scrolltopval = $("#divbody>div").scrollTop();


                if (!window.document.documentMode)
                {
                    closeTableStructureDivs();
                }
            }

            function resizefunction()
            {
                // Initialize the table header last row to take the scrollbar width
                initializeHeaderAlignment();
                closeTableStructureDivs();

                $("#divbody>div").off("scroll");
                resetScrollTopPosition();
                setTimeout(function()
                        {
                            $("#divbody>div").scroll(onScrollNoteValue);
                        },
                    0);
            }

            function resetScrollTopPosition(){
                if (window.scrolltopval)
                {
                    $("#divbody>div").scrollTop(window.scrolltopval);
                }
            }

            function initializeTableStructureDivsEvents(DivTree)
            {
                if (!window.document.documentMode)
                {
                    $(DivTree).attr("tabIndex", "0");
                    DivTree.focus();
                    $(DivTree).blur(function()
                        {
                            closeTableStructureDivs();
                        });
                }
            }

            function closeTableStructureDivs()
            {
                if ($("#divLookupTreeview").css("display").toLowerCase() !== "none")
                {
                    CloseDivControls(0);
                }

                if ($("#divLookupWithParametersTreeview").css("display").toLowerCase() !== "none")
                {
                    CloseDivControls(1);
                }
            }

            function OpenTableStructureForFormControls(txtId, hdntxtId){
               resizefunction();
                setTimeout(function()
                {
                            text = txtId;
                            val = hdntxtId;
                            var txtObj = $("#" + txtId);
                            var DivTree = document.getElementById(text === "txtlookup1"
                                                                  ? 'divLookupTreeview'
                                                                  : 'divLookupWithParametersTreeview');
                            DivTree.style.display = GetDisplayAttributeString();
                            DivTree.style.position = "absolute";
                            DivTree.style.width = 250 + 'px';
                            DivTree.style.height = 200 + 'px';
                    
                            var newtopPos = txtObj.offset().top + (txtObj.height() / 2) - ($(DivTree).height() / 2);

                            if ((newtopPos + $(DivTree).height()) > $("#divparent").height())
                            {
                                newtopPos = $("#divparent").height() - $(DivTree).height() - 20;
                            }

                            DivTree.style.left = 235 + 'px';
                            DivTree.style.top = newtopPos + 'px';
                            DivTree.className = "popup";
                            var selectedTextBoxId = document.getElementById('selectedControl');
                            selectedTextBoxId.value = txtId;

                            initializeTableStructureDivsEvents(DivTree);
                        },
                    0);
            }

            function CloseDivControls(level)
            {
                var treeViewPopup = document.getElementById(level === 0 ? 'divLookupTreeview' : 'divLookupWithParametersTreeview');
                
                treeViewPopup.style.display = "none";


                if (!window.document.documentMode)
                {
                    $(treeViewPopup).off("blur");
                }
            }

            function GetRadNode(sender, eventArgs)
            {
                var node = eventArgs.get_node();
                if (node.get_level() == 0) {
                 node.expand();
                    return;
                }
               document.getElementById(text).value = node.get_text();
               document.getElementById(val).value = node.get_text();
               var DivTree = document.getElementById('divLookupTreeview');
               DivTree.style.display = "none";
            }

            function GetRadNode2(sender, eventArgs)
            {
                var node = eventArgs.get_node();
                if (node.get_level() == 0) {
                    node.expand();
                     return;
                }
                document.getElementById(text).value = node.Text;
                document.getElementById(val).value = node.Value;
                var DivTree = document.getElementById('divLookupWithParametersTreeview');
                DivTree.style.display = "none";
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

            function LookupTreeBeforeClientClick(sender, eventArgs)
            {
                var node = eventArgs.get_node();
                if (node.get_enabled() == 0 || node.get_level() == 0)
                {
                    eventArgs.set_cancel(true);
                }
            }

            function checkMaxLenForDescriptionBox(txt, maxLen)
            {
                try
                {
                    if (txt.value.length > (maxLen - 1))
                    {
                        var cont = txt.value;
                        txt.value = cont.substring(0, (maxLen - 1));
                        return false;
                    }
                } catch (e)
                {
                }
            }

            function CheckTitleEmpty()
            {
                var title = document.getElementById("titleBox").value;
                if (!title)
                {

                    // alert('<%=_TitleValidation%>');
                    se.ui.messageDialog.showError('<%=_ResManager.GlobalResourceSet.GetString("FormConfigurationNameProperty")%>', '<%=_TitleValidation%>');
                    //return false;
                }
            }

            function ValueNodeError()
            {
                var title = document.getElementById("titleBox").value;

                se.ui.messageDialog.showError('<%=_ResManager.GlobalResourceSet.GetString("FormConfigurationNameProperty")%>', '<%=_ResManager.GlobalResourceSet.GetString("DataGridInvalidColumnError")%>');
            }

            function Validations()
            {
                var validate = true;
                //validate the grid configuration page has all needed values
                var title = document.getElementById("titleBox").value;
                if (!title)
                {
                    //  alert('<%=_TitleValidation%>');
                    se.ui.messageDialog.showError('<%=_ResManager.GlobalResourceSet.GetString("FormConfigurationNameProperty")%>', '<%=_TitleValidation%>');
                    validate = false;
                    return false;
                }
                else
                {
                    var lookupTextFields = $("#orderTable").find("input[type='text']");
                    var selectedLookups = [];
                    $.each(lookupTextFields, function (index, lookupField)
                        {
                            if (!lookupField.value)
                            {
                                // alert('<%= _ResManager.GlobalResourceSet.GetString("sk_gridconfig_alert2")%>');
                                se.ui.messageDialog.showError('<%=_ResManager.GlobalResourceSet.GetString("FormConfigurationNameProperty")%>', '<%= _ResManager.GlobalResourceSet.GetString("sk_gridconfig_alert2")%>');
                                validate = false;
                                return false;
                            }

                            if ($(lookupField).attr("id") !== "txtlookup1")
                            {
                                selectedLookups.push(lookupField.value);
                            }
                        });
                    if (validate)
                    {
                        var jsonHelper = skeltaUtils.createJsonRequestHelper({
                            secUri: skeltaUtils.getUrlParameterValue(window, 'lcsuri'),
                            lookups: selectedLookups,
                        });
                        skeltaUtils.callServerMethod("GET", "../../NextGenForms/CommonService.aspx/CheckParametersExistsForLookup", "application/json; charset=utf-8", jsonHelper, "json", function (result)
                            {
                                validate = result.d ? false : true;
                                if (!validate)
                                {
                                    var errorMessage = '<%= _ResManager.GlobalResourceSet.GetString("sk_gridconfig_noparamsfound")%>';
                                    // alert(errorMessage.replace("<@lookupName@>", result.d));
                                    se.ui.messageDialog.showError('<%=_ResManager.GlobalResourceSet.GetString("FormConfigurationNameProperty")%>', errorMessage.replace("<@lookupName@>", result.d));
                                }
                            }, null, null, false);
                    }
                    return validate;
                }
            }

            function openParameterMappingUI()
            {
                if (Validations())
                {
                   
                    var oWindow = radopen("ParameterMapping.htm", "ParameterMappingsWindow");
                    oWindow.setSize(oCWinWidth, oCWinHeight);
                    oWindow.center();
                }

            }
           
        </script>
</telerik:RadCodeBlock>
    </form>
</body>
</html>
