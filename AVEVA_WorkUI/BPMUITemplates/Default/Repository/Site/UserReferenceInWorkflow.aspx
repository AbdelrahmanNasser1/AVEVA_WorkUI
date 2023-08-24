<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.UserReferenceInWorkflow" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ Register Assembly="ISNet.WebUI.WebGrid" Namespace="ISNet.WebUI.WebGrid" TagPrefix="ISWebGrid" %>


<!DOCTYPE HTML>
<html>
<head id="Head1" runat="server">
    <title>User Check</title>
    <style>
        html,body{height:100%;}
    </style>

    <script type="text/javascript">
        function selectUsers(clientid, hiddenVariableValue)
        {
            var oWindow = radopen("UserLookup.aspx?users=" + encodeURIComponent(document.getElementById(hiddenVariableValue).value) + "&singleselection=1", null);

            oWindow.set_modal(true);
            oWindow.set_title('Select Users');
            oWindow.setSize(630, 470);
            oWindow.setActive(true);
            oWindow.center();

            oWindow.add_beforeClose(onClientBeforeCloseUserLookup);

            function onClientBeforeCloseUserLookup(sender, args)
            {
                var returnValue = args.get_argument();

                if (returnValue !== null && returnValue !== undefined)
                {
                    var oArea = document.getElementById(clientid);
                    var ids;
                    var names = '';
                    var useridstring = '';

                    if (returnValue.lastIndexOf("^") != -1)
                    {
                        var usernamestring = returnValue.substring(0, returnValue.lastIndexOf("^"));
                        useridstring = returnValue.substring(returnValue.lastIndexOf("^") + 1);
                        names = usernamestring;
                    }

                    oArea.value = names; //.substring(0, names.lastIndexOf(","));
                    var oArea1 = document.getElementById(hiddenVariableValue);
                    oArea1.value = useridstring;
                }

                sender.remove_beforeClose(onClientBeforeCloseUserLookup);
            }
        }

        function GetRadWindow() {

            var oWindow = null;

            if (window.radWindow)
                oWindow = window.radWindow;
            else if (window.frameElement.radWindow)
                oWindow = window.frameElement.radWindow;

            return oWindow;
        }

        function closeWin() {

            var oWindow = GetRadWindow();
            oWindow.close();
        }
        function OpenWindow(path) {

            document.getElementById('ifViewDetails').src = path;
        }

        function OpenSearchWindow() {

            var button = window.document.getElementById('SearchUser').click();
        }
        function OpenUserWindow() {

            var button = window.document.getElementById('ShowUserWindow').click();
        }
        function clearTextBox() {
            document.getElementById('txtRepositorySecurityMapping').value = "";
            document.getElementById('hdnRepositorySecurityMapping').value = "";
        }
    </script>

</head>
<body>
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
     <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=bellyBarCss %>CommonUXControls/StyleSheet/se.ui.min.css" /> 
    <link rel="stylesheet" type="text/css" href="<%=bellyBarCss%>TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css">
    <link rel="stylesheet" type="text/css" href="<%=bellyBarCss%>TelerikAjax/StyleSheet/AWTWindow/Window.css">
    <link rel="stylesheet" type="text/css" href="<%=bellyBarCss%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.AWTCombobox.css">
    <link rel="stylesheet" type="text/css" href="<%=bellyBarCss%>TelerikAjax/StyleSheet/AWTCombobox/ComboBox.css">

    <script>
        // Initialize locales for message dialog
        se.ui.messageDialog.setGlobalOptions({
            localization: { // All localization related default can be set
                closeButtonCaption: "<%=skrm.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                okButtonCaption: "<%=skrm.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                cancelButtonCaption: "<%=skrm.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                showDetailsCaption: "<%=skrm.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                hideDetailsCaption: "<%=skrm.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
            }
        });
    </script>
    <script type="text/javascript">
        
        function ValidateValues() {            
            var userElement = document.getElementById('hdnRepositorySecurityMapping').value;             
            if(userElement!= null && userElement!="") {
                               
                var radCombo = $find("<%= RadComboBoxToShowListNames.ClientID %>");
                var comboValue = radCombo.get_value();	
            
            if(comboValue=="select")
            {
                var grid = ISGetObject("WebGrid1");
                var getTotal = grid.TotalRows;
                if (getTotal > 0)
                {        
                    try{
                    grid.Refresh();
                    }
                    catch(e)
                    {
                    }
                }
                se.ui.messageDialog.showError("<%=skrm.GlobalResourceSet.GetString("ec_menu_userreference")%>",document.getElementById('hdnSelectWf').value);           
                return false;
                }
            }  
            else
            {
                var grid = ISGetObject("WebGrid1");
                var getTotal = grid.TotalRows;
                if (getTotal > 0)
                {
                try{
                grid.Refresh();
                }
                catch(e)
                {
                }
                }
                se.ui.messageDialog.showError("<%=skrm.GlobalResourceSet.GetString("ec_menu_userreference")%>",document.getElementById('hdnSelectUser').value);
                    return false;  
            }      
            
    }
        function SetFocus()
        {
            try
            {
                document.body.focus();
            }
            catch(e)
            {

            }
        }
    </script>

    <form id="form1" runat="server" style="height:100%;">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        <link href="<%=themePath%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />

   <table style="width:98%;margin:0px auto;border-width:0;border-spacing:0px">
                    
        <tr class="ListHeaderCss">
            <td rowspan="2" style="vertical-align: middle;width:40px;text-align:center;">
                <img src="<%=themePath%>Repository/ListControl/Images/icon-View-WF-user.png" /> 
            </td>
            <td class="MainHeading" id="Td1" runat="server" style="text-align: left;"><%=userRefernceDescription%></td>
            <asp:Label ID="lblpageHeading" runat="server"></asp:Label>
        </tr>

        <tr>
            <td class="description" style="padding-bottom:10px;">
                <%=userRefernceDescriptionText %>     
            </td>
        </tr>                    
     </table>
    <table  style="height:2%;width:100%;border-collapse:collapse;border-spacing:0px;margin:0px auto;">  
        <tr>
            <td style="text-align:center;width:100%;padding:3px;" colspan="2">
                <asp:Label CssClass="errormsg" ID="lblErrorMsg" runat="server" Visible="false"></asp:Label>
            </td>
        </tr>
    </table>
    <table style="height:15%;width:98%;margin:0px auto;border-collapse:separate;border-spacing:1px;" class="tablebg" >
        <tr>
            <td class="lefttdbg"  style="width: 50%;padding:3px;vertical-align:middle;">
                <span class="subtitle">
                    <%=skrm.GlobalResourceSet.GetString("sk_userreference_userlookup")%><img id="imgMandatoryUserTobeReplacedName"
                        runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/images/mandatoryicon.png%>"
                        hspace="2" align="top" visible="true" /></span>
                <br />
                <span class="description">
                    <%=skrm.GlobalResourceSet.GetString("sk_userreference_userlookup_desc")%></span>
            </td>
            <td class="righttdbg" style="width: 50%;padding:3px;vertical-align:middle;">
                <asp:TextBox ID="txtRepositorySecurityMapping" CssClass="inputtext" runat="server"
                    onclick="this.blur()" Width="200px" oncopy="return false" onpaste="return false"
                    oncut="return false"></asp:TextBox>
                <input id="btnRepositorySecurityMapping" class="userlookup" runat="server" onclick="selectUsers('<%=txtRepositorySecurityMapping.ClientID%>','<%=hdnRepositorySecurityMapping.ClientID%>');"
                    type="button" value=".." name="SiteExplorer" style="padding-top:6px;" />
                <asp:HiddenField ID="hdnRepositorySecurityMapping" Value="" runat="server" />
                <asp:RequiredFieldValidator Display="Dynamic" ID="RequiredFieldValidatorForUserToBeReplaced"
                    runat="server" ControlToValidate="txtRepositorySecurityMapping">
                <img  alt=" <%=skrm.GlobalResourceSet.GetString("sk_userrefernece_user_ErrorIcon")%>" 
                id="imageUserToBeReplaced"  src="../../Skeltaforms/images/erroricon.png" />
                </asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="lefttdbg"  style="width: 50%;vertical-align:middle;padding:3px;">
                <span class="subtitle">
                    <%=skrm.GlobalResourceSet.GetString("sk_userreference_workflowlist")%><img id="img2" runat="server" src="<%$ ReplaceTemplateExpn:Skeltaforms/images/mandatoryicon.png%>"
                        hspace="2" align="top" visible="true" /></span>
                <br />
                <span id="spSelectList" runat="server" class="description"></span>
            </td>
            <td class="righttdbg"  style="width: 50%; vertical-align: middle;padding:3px;">
                <asp:Panel ID="chkListPanel" runat="server" Visible="true">                  

                    <telerik:RadComboBox   ID="RadComboBoxToShowListNames" EnableLoadOnDemand="false" RenderMode="Classic" runat="server"  Skin="AWTCombobox"  
                   Height="250px" Width="200px" EnableEmbeddedSkins="false">
                    </telerik:RadComboBox>

                    
                    <asp:Button ID="btnSearch" runat="server" CssClass="inputbutton" />
                </asp:Panel>
                <asp:RequiredFieldValidator Display="Dynamic" ID="RequiredFieldValidator1" runat="server" ControlToValidate="RadComboBoxToShowListNames">
                <img  alt=" <%=skrm.GlobalResourceSet.GetString("sk_userrefernece_user_ErrorIcon")%>" 
                id="Img1"  src="../../Skeltaforms/images/erroricon.png" />
                </asp:RequiredFieldValidator>
            </td>
        </tr>
        
    </table>
    
    <table style="height:65%;width:98%;margin:0px auto;border-collapse:collapse;border-spacing:0px;">
        <tr>
            <td height="2%" >
            </td>
        </tr>
        <tr>
            <td id="tdWebgridId" runat="server" style="width:100%;height:98%;vertical-align:top;">
                <ISWebGrid:WebGrid ID="WebGrid1" runat="server" Height="100%" Width="100%" HorizontalAlign="NotSet"
                    AllowAutoDataCaching="false" ViewStateStorage="None" DataCacheStorage="PageCache"
                    OnInitializeDataSource="WebGrid1_InitializeDataSource" OnInitializeLayout="WebGrid1_InitializeLayout"
                    OnPrepareDataBinding="WebGrid1_PrepareDataBinding" DisableFileSystemChecking="true"
                    EnableWebResources="never" RenderingMode="HTML5" > 
                    <LayoutSettings AlwaysShowHelpButton="false" PagingMode="VirtualLoad" VirtualLoadMode="LargeData"
                        VirtualPageSize="10" CellClickAction="RowSelect" UseRelativePositioning="true"
                        PersistRowChecker="True" AlternatingColors="False" GridLineStyle="Solid" GridLineColor="#afafaf"
                        RowHeightDefault="23px" GridLines="None" AutoFitColumns="true" RowHeaders="No">
                        <HeaderStyle Wrap="false" Overflow="hidden" OverflowX="hidden" OverflowY="hidden" CssClass="GridHeaderStyle"></HeaderStyle>
                        <FocusCellStyle CssClass="GridFocusCellStyle"></FocusCellStyle>
                        <GroupRowInfoStyle CssClass="GridGroupRowInfoStyle"></GroupRowInfoStyle>
                        <GroupByBox>
                            <LabelStyle CssClass="GridLabelStyle"></LabelStyle>
                            <Style BackColor="#ececec"></Style>
                        </GroupByBox>
                        <FilterRowStyle CssClass="GridEditFocusCellStyle"></FilterRowStyle>
                        <EditTextboxStyle CssClass="GridEditTextBoxStyle"></EditTextboxStyle>
                        <EditFocusCellStyle CssClass="GridEditFocusCellStyle"></EditFocusCellStyle>
                        <FrameStyle  CssClass="GridFrameStyle"></FrameStyle>
                        <SelectedRowStyle CssClass="GridSelectedRowStyle"></SelectedRowStyle>
                        <AlternatingRowStyle CssClass="GridAlternatingRowStyle" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden"></AlternatingRowStyle>
                        <StatusBarStyle CssClass="GridStatusBarStyle">
                            <Padding Top="0px" Left="0px" Bottom="0px" Right="0px"></Padding>
                        </StatusBarStyle>
                        <StatusBarCommandStyle Active-CssClass="GridStatusBarStyle" Normal-CssClass="GridStatusBarStyle" Over-CssClass="GridStatusBarStyle">
                        </StatusBarCommandStyle>
                        <RowStyle CssClass="GridRowStyle" OverflowX="hidden" OverflowY="hidden" CustomRules="text-overflow: ellipsis; overflow-x: hidden">
                        </RowStyle>
                        <NewRowStyle CssClass="GridNewRowStyle">
                        </NewRowStyle>
                        <EditFocusCellStyle CssClass="GridEditFocusCellStyle">
                        </EditFocusCellStyle>
                        <ClientSideEvents OnRowContextMenu="DisableContextMenu" />
                        <TextSettings Language="UseCulture">
                        </TextSettings>
                        <LostFocusRowStyle CssClass="GridSelectedRowStyle"></LostFocusRowStyle>
                    </LayoutSettings>
                    <RootTable GridLineStyle="NotSet">
                    <TableHeaderStyle CssClass="GridTableHeaderStyle">
                        <Padding Bottom="4px" Left="4px" Top="4px" Right="4px"></Padding>
                    </TableHeaderStyle>
                </RootTable>
                </ISWebGrid:WebGrid>
                <%-- </asp:Panel>--%>
            </td>
        </tr>
    </table>
  
    <%--</asp:Panel>--%>
    <div style="display: none">
        <input type="button" id="SearchUser" value="Open Window" />
    </div>   

        <telerik:RadWindowManager ID="Singleton" Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false"
         runat="server" BackColor="Black" Behaviors="Close, Move" DestroyOnClose="true" Overlay="false" RenderMode="Classic" VisibleStatusbar="false">            
        </telerik:RadWindowManager>

   
    <input id="hdnSelectWf" value="<%=skrm.GlobalResourceSet.GetString("sk_userreference_selectworkflowalert")%>" type="hidden" />
    <input id="hdnSelectUser" value="<%=skrm.GlobalResourceSet.GetString("sk_usereference_selectuseralert")%>" type="hidden" />
    </form>
</body>
</html>

<script type="text/javascript" language="javascript">



    function CheckSelected() {
        var grid = ISGetObject("WebGrid1");
        var getTotal = grid.TotalRows;
        if (getTotal > 0) {
            var checkRows = grid.RootTable.GetCheckedRows();
            if (checkRows == '') {
                se.ui.messageDialog.showError("<%=skrm.GlobalResourceSet.GetString("ec_menu_userreference")%>","<%=checkEmptyMsg %>");
                return false;
            }
        }
        else {
            se.ui.messageDialog.showError("<%=skrm.GlobalResourceSet.GetString("ec_menu_userreference")%>","<%=noRowsAvailable %>");
            return false;
        }
    }

    function RefreshGrid() {
        try {
            var i = GetMOZBrowserversion();
            if (i == 1) {
                var grid = ISGetObject("WebGrid1");
                grid.RefreshAll(); //do not use Refresh() as it is failing in IE7
            }
            else
                window.location.href = window.location.href;
            //window.opener.location.href = window.opener.location.href;

            //using timeout to adjust the grid height
            //window.setTimeout(ReSizeQueueGrid, 400);
            window.setTimeout(function() { grid.RefreshAll(); }, 2);
        }
        catch (e) { }

    }
    // If Mozila it should refresh the grids, to avoid Communication error
    function GetMOZBrowserversion() {        
        var app = navigator.userAgent;
        if (app.indexOf("MSIE") > -1) {
            return 1;
        }
        else if (app.indexOf("Firefox/1.5") > -1) {
            return 2;
        }
        else {
            return 3;
        }
    }
    function DisableContextMenu(gridId, rowType, rowEl, rowMenu)
    {        
        var i;
        var grid = wgGetGridById(gridId);	                 
        if (rowType != "Record") return true;	        
        if(rowType =="Record")
        { 
            // hide the default context menu
            for (i=0;i<=43;i++)
            {                              
                rowMenu.Items[i].Hide();              
            }                                              
        } 	
    }
</script>

