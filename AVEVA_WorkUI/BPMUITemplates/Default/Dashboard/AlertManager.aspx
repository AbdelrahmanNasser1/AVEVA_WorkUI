<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.Bam.DashBoard.AlertManager" %>
<%@ Register Src="AlertManagerControl.ascx" TagName="AlertManagerControl" TagPrefix="uc1" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ OutputCache Location="None" %>
<html>
<head id="Head1">
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
    <script>
        window.onresize = Resize;
        window.onload = Resize;
        function Resize() {
            var divdetails = document.getElementById("divdetails");
            var mainrow = document.getElementById("mainrow");
            divdetails.style.height = document.body.clientHeight - 72;
            mainrow.style.height = document.body.clientHeight - 110;
        }
    </script>

    <style>
      
        .subheadingtitle
        {
            font-family: Roboto;
            font-size: 10px;
            font-weight: bold;
        }
        .subheading
        {
            font-family: Roboto;
            font-size: 10px;
            font-weight: bold;
        }
        .notepaddingleft 
        {
            padding-right: 920px;
        }
    </style>
</head>
<link rel="stylesheet" type="text/css" href="<%:cssPath%>Common/StyleSheet/Global.css" />
<body style="border: none; margin: none; padding: none; overflow: -moz-scrollbars-none;"
    leftmargin="2px" topmargin="2px" rightmargin="2px" bottommargin="2px" scroll="no">
    
    <form id="form2" runat="server">
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
         <script src="<%=JSPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
        <script>
            function ShowPackageWindow() {
                var application = '<%=AppName%>';
                var workflowName = '<%=WorkflowName%>';
                var url = "../Package/PackageList.aspx?&mode=BAM Workflow" + "&Name=" + workflowName + "&AppName=" + application + "&SettingsType=alertmanager";
                var windowparams = "height=320,width=500,resizable=yes,status=no";
                var oWindow = radopen(url, null);
                oWindow.set_modal(true);
                oWindow.set_title("BAM Workflow");
                oWindow.setSize(590, 360);
            }
            se.ui.messageDialog.setGlobalOptions({
                localization: {
                    closeButtonCaption: "<%=GR.GetString("se_ui_messagedialog_close_caption") %>",
                    okButtonCaption: "<%=GR.GetString("se_ui_messagedialog_ok_caption") %>",
                    cancelButtonCaption: "<%=GR.GetString("se_ui_messagedialog_cancel_caption") %>",
                    showDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_showdetails_caption") %>",
                    hideDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_hidedetails_caption") %>"
                }
            });


            function DisplayMessage(message) {

                se.ui.messageDialog.showAlert("<%=GR.GetString("Security_Rights_comn_Alert_for_list")%>", message);
            }
            function DisplayErrorMessage(message) {

                se.ui.messageDialog.showError("<%=GR.GetString("Alert")%>", message);
            }
        </script>
        <link href="<%:cssPath%>CommonUXControls/StyleSheet/se.ui.min.css"  rel="stylesheet" type="text/css" />  
    <table width="100%" cellspacing="0" cellpadding="0" border="0">
        <tr>
            <td valign="bottom" height="25" >
                <table border="0" cellspacing="1" cellpadding="2" width="100%" height="25px" style="table-layout: fixed;">
                    <tr>
                        <td align="left" class="subtitle" style="padding-left:35px;">
                            <span class="subtitle">
                                <%=GR.GetString("BAM Alert Configuration for")%>
                                <%=_BAMConfigurationAdapter.WorkflowName %>
                                <%=GR.GetString("Workflow")%></span>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>      
        <tr id="mainrow">
            <td>
                <table cellspacing="1" cellpadding="4" border="0" width="98%" height="100%" align="center">
                    <tr>
                        <td colspan="2" align="center" height="100%">
                            <div id="divdetails" style="width: 100%; height: 100%; overflow: hidden;">
                                <uc1:AlertManagerControl ID="AlertManager" runat="server" />
                            </div>
                        </td>
                    </tr>
                    
                </table>
            </td>
        </tr>      
        
    </table>
    </form>
</body>
</html>
