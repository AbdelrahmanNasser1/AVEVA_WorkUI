<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Forms.Web.CodeBehind.CreateList.BPMUITemplates_Default_Repository_Site_CreateDListSelectTable" %>
<%@ Register Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" TagPrefix="telerik" %>


<!DOCTYPE html>
<html style="height:100%">
<head runat="server">
    <telerik:RadCodeBlock runat="server" ID="RadCodeBlock1">
        <title><%=resManager.GlobalResourceSet.GetString("FormListTablePageTitleText") %></title>
    </telerik:RadCodeBlock>
    <style type="text/css">
        img:hover 
        {
            cursor: pointer;
        }
    </style>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="../../CommonUXControls/scripts/window/se.ui.min.js"></script>
</head>
<telerik:RadCodeBlock runat="server" ID="RadCodeBlock2">
    <script  type="text/JavaScript" language="JavaScript">

        se.ui.messageDialog.setGlobalOptions({
            localization: {
                closeButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                okButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
                cancelButtonCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                showDetailsCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                hideDetailsCaption: "<%=resManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
            }
        });

        var oWin = GetRadWindow();
        if (oWin != null || oWin != undefined)
        {
            var oCWinHeight = 0.88 * oWin.get_height();
            var oCWinWidth = oWin.get_width() - 60;
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

        function closeWin()
        {
            var oWindow = GetRadWindow();
            oWindow.close();
        }

        function Checkbox1_onclick() 
        {
            if (document.getElementById("RadioGenTbl").checked)
            {
                document.getElementById("hValue").value = "GeneralTable";
                document.getElementById("ExistTableDiv").style.visibility = 'hidden';
            }
            else
            {
                document.getElementById("hValue").value = "ExistingTable";
                document.getElementById("ExistTableDiv").style.visibility = 'visible';
            }
        }

        function UnloadPage()
        {
            window.opener.location.href = window.opener.location.href;
        }

        function OpenHelpWindow(applicationName)
        {
            var left = (screen.availWidth / 2) - (750 / 2);
            var top = (screen.availHeight / 2) - (500 / 2);

            return window.open("CreateDListTableHelp.aspx?ApplicationName=" + applicationName, 'Help', 'top=' + top + ', left=' + left + ',height=500,width=750,resizable=yes');
        }

        function openWin(uri)
        {
            var w, h;

            if (document.all || document.layers)
            {
                w = screen.availWidth;
                h = screen.availHeight;
            }

            var winIsResizable = "1";
            var winIsScrollable = "0";

            var winHeight = (h * 85 / 100);
            var winWidth = (w * 85 / 100);

            var winLeft = (w - winWidth) / 2;
            var winTop = (h - winHeight) / 2;

            window.open(uri, '', "left=" + winLeft + ",top=" + winTop + ",width=" + winWidth + ",height=" + winHeight + ",resizable=" + winIsResizable + ",scrollbars=" + winIsScrollable + "\"");

            closeWin();
        }

        function OpenCreateTable()
        {
            var url = "../../NextGenForms/CustomListCreateTable.htm?listcreationmode=" + "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(Microsoft.Security.Application.Encoder.UrlEncode("Add"), false)%>&lcsuri=" + "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(Microsoft.Security.Application.Encoder.UrlEncode(Request.QueryString["lcsuri"]), false)%>&applicationName=" + "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(Microsoft.Security.Application.Encoder.UrlEncode(_applicationName), false)%>&listItemId=" +"<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(Microsoft.Security.Application.Encoder.UrlEncode(Request.QueryString["DLItemId"]), false)%>";
            var oWindow = radopen(url, "CreateTableWindow");
            oWindow.set_title('Create Table');
            oWindow.setSize(oCWinWidth, oCWinHeight);
            oWindow.center();
        }

        function ModifyTable()
        {
            var dpt = document.getElementById("ListBox1");

            if (typeof (dpt.options[dpt.selectedIndex]) == 'undefined')
            {
                se.ui.messageDialog.showError("<%=resManager.GlobalResourceSet.GetString("CustomList_CreateTable_SelectTableTitle") %>", "<%=resManager.GlobalResourceSet.GetString("CustomList_CreateTable_SelectTableMessage") %>");
                return;
            }
            var tableName = dpt.options[dpt.selectedIndex].value;

            if (tableName.toLowerCase() == "galaxyusers" ||
                tableName.toLowerCase() == "galaxyroles" ||
                tableName.toLowerCase() == "galaxyroleusermappings" ||
                tableName.toLowerCase() == "galaxyrolesecuritygroupmappings")
            {

                se.ui.messageDialog.showError("<%=resManager.GlobalResourceSet.GetString("CustomList_CreateTable_SelectTableTitle") %>", "<%=resManager.GlobalResourceSet.GetString("CustomList_CreateTable_SelectTableRestrictedMessage") %>");
                return;

            }

            var url = "../../NextGenForms/CustomListCreateTable.htm?listcreationmode=" + "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(Microsoft.Security.Application.Encoder.UrlEncode("Edit"), false)%>&lcsuri=" + "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(Microsoft.Security.Application.Encoder.UrlEncode(Request.QueryString["lcsuri"]), false)%>&applicationName=" + "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(Microsoft.Security.Application.Encoder.UrlEncode(_applicationName), false)%>&listItemId=" + "<%=Microsoft.Security.Application.Encoder.JavaScriptEncode(Microsoft.Security.Application.Encoder.UrlEncode(Request.QueryString["DLItemId"]), false)%>&listtablename=" + tableName;
            var oWindow = radopen(url, "CreateTableWindow");
            oWindow.set_title('Edit Table');
            oWindow.setSize(oCWinWidth, oCWinHeight);
            oWindow.center();
        }

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

        function resizefunction()
        {
            var bodydiv = document.getElementById('BodyDiv');
            var headerdiv = document.getElementById('HeaderDiv');
            var footerdiv = document.getElementById('FooterDiv');
            var parentdiv = document.getElementById('ParentDiv');
            if (parentdiv.offsetParent == document.body)
                document.body.style.height = '100%';

            var parentdivheight = parentdiv.offsetParent.offsetHeight;
            parentdiv.style.height = parentdivheight;
            try { bodydiv.style.height = parentdivheight - headerdiv.offsetHeight - footerdiv.offsetHeight; } catch (e) { }//headerdiv.offsetHeight -
            bodydiv.style.width = '100%';
            bodydiv.style.overflow = 'auto';
            parentdiv.style.overflow = 'hidden';
        }

        function LocalizeText()
        {
            var buttontext = '<%=resManager.GlobalResourceSet.GetString("FormListSelectTableNextButtonText") %>';
            document.getElementById('btnNext').value = buttontext;

            var btnCanceltext = '<%=resManager.GlobalResourceSet.GetString("BtnCancelText") %>';
            document.getElementById('btnCancel').value = btnCanceltext;

            var genericTooltip = '<%=resManager.GlobalResourceSet.GetString("ListGenericListToolTipText")%>';
            var existinTooltip = '<%=resManager.GlobalResourceSet.GetString("ListExistingListToolTipText")%>';
            document.getElementById('RadioGenTbl').title = genericTooltip;
            document.getElementById('RadioExistTbl').title = existinTooltip;
        }

        function CallRefresh()
        {
            document.getElementById("<%=imgRefresh.ClientID%>").click();
        }
    </script>
</telerik:RadCodeBlock>
<body  style="height: 100%; width: 100%; font-size: 9px; border: none; margin: 0px 0px 0px 0px;padding:0px;"  onload="LocalizeText();">
    <div id="ParentDiv" style="width:100%;height:100%">
        <form id="form1" runat="server" style="height: 100%;width:100%">
            <telerik:RadCodeBlock runat="server" ID="RadCodeBlock3">
	            <%=System.Web.Helpers.AntiForgery.GetHtml()%>
                <link type="text/css" rel="stylesheet" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>Common/StyleSheet/Global.css" />
                <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>CommonUXControls/StyleSheet/se.ui.min.css" />  
                <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
                <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>TelerikAjax/StyleSheet/AWTWindow/Window.css">
            </telerik:RadCodeBlock>
            <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
             <div id="HeaderDiv" style="height:5%">
                <table style="border-spacing:0px;border-width:0;width:100%;margin:auto">
                    <tr>
                        <td class="pagetitle" style="padding-left:26px;padding-top:20px;"> 
                            <telerik:RadCodeBlock runat="server" ID="RadCodeBlock4">                                            
                                <%=resManager.GlobalResourceSet.GetString("FormListSelectTable") %> 
                            </telerik:RadCodeBlock>
                        </td>
                    </tr>                                                       
                </table>
            </div>       
            <div id="BodyDiv" style="height:80%;padding-left:25px;">
                <table  style="width:98%;border-spacing:0px;"  class="tablebg" >
                    <tr>
                        <td  class="lefttdbg" style="vertical-align:middle;height:130px;width:50%">
                            <telerik:RadCodeBlock runat="server" ID="RadCodeBlock5">
                                <span class="subtitle"> <%=resManager.GlobalResourceSet.GetString("FormListTableOptionOne") %> </span><br /><br />
                                <span class="description"> <%=resManager.GlobalResourceSet.GetString("FormListOptionOneDescription") %> </span></td>
                            </telerik:RadCodeBlock>
                        <td class="righttdbg">
                            <label>
                                <input id="RadioGenTbl" name="Test" checked="checked" title="Generic Table" type="radio" onclick="Checkbox1_onclick();" />
                                <telerik:RadCodeBlock runat="server" ID="RadCodeBlock6">
                                    <span class="description"> <%=resManager.GlobalResourceSet.GetString("FormListGenericTable") %></span> 
                                </telerik:RadCodeBlock>
                            </label>
                        </td>
                    </tr>
                    <tr>
                        <td class="lefttdbg" style="vertical-align:top;height:130px;width:50%">
                            <telerik:RadCodeBlock runat="server" ID="RadCodeBlock7">
                                <span class="subtitle"> <%=resManager.GlobalResourceSet.GetString("FormListTableOptionTwo") %> </span><br /><br />
                                <span class="description"><%=resManager.GlobalResourceSet.GetString("FormListOptionTwoFirstDesc") %> 
                                    <br><%=resManager.GlobalResourceSet.GetString("FormListOptionTwoNextDesc") %>.
                                    <br /><br /><b><%=resManager.GlobalResourceSet.GetString("FormSelectDListTableNote1Text")%></b>
                                    <br /><a href="#" onclick="javascript:OpenHelpWindow('<%=_applicationName%>');"><%=resManager.GlobalResourceSet.GetString("FormListOptionReadMore") %></a></span>
                                <br/> <span class="description"><%=resManager.GlobalResourceSet.GetString("CustomList_ExistingTableDesc")%></span>
                                <br/><br /> <span class="description"><%=resManager.GlobalResourceSet.GetString("CustomList_FolderNote")%></span>
                            </telerik:RadCodeBlock>
                        </td>
                        <td class="righttdbg" style="vertical-align:top;padding-top:20px;">
                            <label>
                                <input id="RadioExistTbl" name="Test" title="Existing Table" type="radio"  onclick="Checkbox1_onclick();" />
                                <telerik:RadCodeBlock runat="server" ID="RadCodeBlock8">
                                    <span class="description"><%=resManager.GlobalResourceSet.GetString("CustomList_ExistingTable") %></span>
                                </telerik:RadCodeBlock>
                            </label> 
                                    
                            <div id="ExistTableDiv" style="visibility:hidden;width:100%;padding-top:5px;padding-left:5px;">                                        
                                    <table style="width:100%;border-width:0;border-spacing:2px">
                                        <tr>
                                        <td style="width:60%;height:50px;padding-top:5px;padding-bottom:5px;">
                                            <telerik:RadCodeBlock runat="server" ID="RadCodeBlock9">
                                                <span class="description"><%=resManager.GlobalResourceSet.GetString("FormListSelectTable") %></span><br /><br />
                                            </telerik:RadCodeBlock>
                                            <asp:ListBox ID="ListBox1"  runat="server" Width="100%" Rows="8" ></asp:ListBox>
                                        </td>
                                        <td style="vertical-align:top;width:60%;padding-top:30px;padding-bottom:5px;padding-left:10px;">
                                            <telerik:RadCodeBlock runat="server" ID="RadCodeBlock10">
                                                <img src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>Repository/Site/images/createtable_add.png" onclick="OpenCreateTable();" title="Add" /><br /><br />
                                                <img src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(ThemePath)%>Repository/Site/images/createtable_edit.png"  title="Edit" onclick="ModifyTable();" /><br /><br /> 
                                            </telerik:RadCodeBlock>
                                            <asp:ImageButton ImageUrl="Images/icon-refresh.png" runat="server" id="imgRefresh" OnClick="imgRefresh_Click" onmousedown="this.src='Images/icon-refresh1.png'" onmouseup="this.src='Images/icon-refresh.png'"/>
                                        </td>
                                    </tr>
                                    </table>                  
                            </div>
                            <input id="hValue" type="hidden" name="hValue" runat="server">                                  
                                    
                        </td>
                    </tr>                           
                </table>
            </div>
            <div id="FooterDiv" style="height:7%;padding-top:15px;">
                <table style="border-width:0;border-spacing:0;width:100%;margin:auto">
                    <tr style="text-align:right">
                        <td style="width:50%">
                        </td>
                        <td  style="width:50%;padding-top:25px;padding-right:20px;">
                                <asp:Button ID="btnCancel" CssClass="inputsecondarybutton" runat="server" Text="Next" OnClientClick="closeWin();" />&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:Button ID="btnNext" CssClass="inputbutton" runat="server" Text="Next" OnClick="btnNext_Click" />
                        </td>
                    </tr>
                </table>
            </div>
            <telerik:RadAjaxManager ID="RadAjaxManager2" runat="server">
                <AjaxSettings>				
                    <telerik:AjaxSetting AjaxControlID="imgRefresh">
                        <UpdatedControls>                           
						    <telerik:AjaxUpdatedControl ControlID="ListBox1"></telerik:AjaxUpdatedControl>                        
					    </UpdatedControls>
                    </telerik:AjaxSetting>
                    </AjaxSettings>
            </telerik:RadAjaxManager>
            <telerik:RadWindowManager ID="RadWindowManager1" Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" 
                        RenderMode="Classic" VisibleStatusbar="false" Behaviors="Close" runat="server">
                <Windows>
                    <telerik:RadWindow ID="CreateTableWindow" Behaviors="Move" Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" RenderMode="Classic"
                        Modal="true" runat="server" Left="" Title="Create Table" OnClientClose="CallRefresh" />
                </Windows>
            </telerik:RadWindowManager>
        </form>
    </div>
</body>
</html>
