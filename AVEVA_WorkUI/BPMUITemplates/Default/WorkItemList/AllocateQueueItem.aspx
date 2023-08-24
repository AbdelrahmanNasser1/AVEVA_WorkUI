<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.WorkItemList.AllocateQueueItem" Theme="" StylesheetTheme="" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE HTML>
<html>
<head id="Head1" runat="server">
    <title><%=_StrAllocateQueueItem%></title>   
     <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
     <style>
        html,body {height:100%;}
    </style>
    
</head>
<script type="text/javascript" >             
     
    se.ui.messageDialog.setGlobalOptions({
        localization: {
            closeButtonCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
            okButtonCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
            cancelButtonCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
            showDetailsCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
            hideDetailsCaption: "<%=resourceManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
        }
    });


     function GridRefresh()
     {     
        window.opener.RefreshGrid();         
     }

     function ShowBellyBarErrorMessage(title, message) {
         se.ui.messageDialog.showError(title, message);
     }

     function ShowBellyBarAlertMessage(title, message) {
         se.ui.messageDialog.showAlert(title, message);
     }
</script>   
<body>
    <form id="form1" runat="server" style="height:100%;">
        <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <link href="<%:commonCssPath+"common/StyleSheet/Global.css"%>" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" type="text/css" href="<%:commonCssPath+"CommonUXControls/StyleSheet/se.ui.min.css"%>" />
        </telerik:RadScriptBlock>
        <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
         </telerik:RadCodeBlock>
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
        <table style="border-spacing:1px;width:100%;border-collapse:separate;">
            <tr style="vertical-align:top;" class="ListHeaderCss">
                <td style="vertical-align:middle;height:15px;" >
                    <table style="width:100%;border-spacing:0px;border-collapse:separate;">
                        <tr>
                            <td style="height:25px;padding-left:10px;"><span class="fontheading">
                                <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
                                <%=_StrAllocateQueueItem%>
                                    </telerik:RadCodeBlock>
                                    </span></td>
                            <td style="vertical-align:top;width:20%;">
                                
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>

            <tr>
                <td>
                    <table style="border-collapse:separate;border-spacing:1px;width:100%;margin:0px auto;" >
                        <tr>
                            <td style="width:400px;vertical-align:top;height:3px;padding-left:10px;">
                                <asp:Label ID="lblDisplayError" CssClass="errormsg" runat="server" Visible="false"></asp:Label>
                            </td>
                        </tr>
                    </table>

                    <table style="width:100%;border-collapse:separate;border-spacing:1px;height:100%;margin:0px auto;" class="tablebg" >
                        <tr>
                            <td rowspan="2" class="lefttdbg" style="padding:2px;text-align:center;">
                                <span class="subtitle">
                                    <telerik:RadCodeBlock ID="RadCodeBlock3" runat="server">
                                    <%=_StrAvailableResources%>
                                    </telerik:RadCodeBlock>
                                </span>
                                <br />                               
                                <asp:ListBox ID="lstselres" CssClass="inputtext" runat="server" SelectionMode="Single" Width="200px" Height="160px"></asp:ListBox>
                            </td>

                            <td class="lefttdbg" style="text-align:center;width:50px;padding-top:25px;">
                                <asp:Button runat="server" ID="btnMoveright" OnClick="btnright_Click" Text=" >  " Width="35" CssClass="lookupnavigationbutton" />
                            </td>
                            <td rowspan="2" class="lefttdbg" style="text-align:center;">
                                <span class="subtitle"><telerik:RadCodeBlock ID="RadCodeBlock4" runat="server"><%=_StrSelectedResources%></telerik:RadCodeBlock></span><br />                             
                                <asp:ListBox ID="lstselectedres" runat="server" Width="200px" Height="160px" SelectionMode="Multiple" CssClass="inputtext" />
                            </td>
                        </tr>
                        <tr>
                            <td class="lefttdbg" style="text-align:center;width:50px;">
                                <asp:Button runat="server" ID="btnMoveLeft"
                                    CssClass="lookupnavigationbutton" OnClick="btnleft_Click" Text=" <  " Width="35" />
                            </td>
                        </tr>



                    </table>

                </td>
            </tr>
            <tr>
                <td style="padding-top:15px;padding-right:5px;">
                    <table style="border-collapse:collapse;border-spacing:0px;width:100%;margin:0px auto;" class="tablebg">
                        <tr>                     

                            <td class="lefttdbg" style="text-align:right;width:100%;padding-right:10px;">

                                <asp:Button runat="server" ID="btnClose"
                                    CssClass="inputsecondarybutton" OnClientClick="GridRefresh()" Text="Close" />

                                <asp:Button runat="server" ID="btnAllocate"
                                    CssClass="inputbutton" OnClick="btnAllocate_Click" Text="Allocate"  />

                                </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="btnMoveright">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="lstselectedres" />
                    </UpdatedControls>
                </telerik:AjaxSetting>

                <telerik:AjaxSetting AjaxControlID="btnMoveLeft">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="lstselectedres" />
                    </UpdatedControls>
                </telerik:AjaxSetting>

            </AjaxSettings>

        </telerik:RadAjaxManager>

    
    </form>
</body>
</html>

