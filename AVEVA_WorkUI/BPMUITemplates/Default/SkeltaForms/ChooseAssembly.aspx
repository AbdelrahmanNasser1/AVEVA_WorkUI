<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Forms.Web.CodeBehind.ChooseAssembly" %>

<html>
<head runat="server">
    <title></title>

    <script language="javascript" type="text/javascript">
            function setParentValues()
            {              
               parent.document.getElementById("txtAssembly").value = document.getElementById("txtAssembly").value.replace(/C:\\fakepath\\/i, '');
               parent.document.getElementById("txtParam").value = document.getElementById("txtParam").value;
               parent.document.getElementById("hidAssembly").value = document.getElementById("txtAssembly").value;               
            }

        function ValidateAssembly() {

            var assPath = document.getElementById('txtAssembly');
            if (assPath.value == "") {
                //alert("Provide the assembly to get the data source connection string");
                se.ui.messageDialog.showError("<%=skResMgr.GlobalResourceSet.GetString("ec_menu_dbconn") %>", '<%=skResMgr.GlobalResourceSet.GetString("Forms_ChooseAssemblyAsmProvider")%>');
                return false;
            }
            else {
                setParentValues();
                closeWin();
                return true;

            }
        }

        function closeWin() {
            var oWindow = GetRadWindow();
            oWindow.close();
            return false;
        }

        function GetRadWindow() {

            var oWindow = null;
            if (window.radWindow)
                oWindow = window.radWindow;
            else if (window.frameElement.radWindow)
                oWindow = window.frameElement.radWindow;
            return oWindow;
        }
    </script>

</head>
<body class="body">
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(templateThemeDirectory) %>CommonUXControls/StyleSheet/se.ui.min.css" />
    <link rel="stylesheet" type="text/css" href="<%=Microsoft.Security.Application.Encoder.HtmlEncode(templateThemeDirectory) %>Common/StyleSheet/Global.css" /> 
    <script>
        se.ui.messageDialog.setGlobalOptions({
            localization: {
                closeButtonCaption: "<%=skResMgr.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                okButtonCaption: "<%=skResMgr.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
                cancelButtonCaption: "<%=skResMgr.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                showDetailsCaption: "<%=skResMgr.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                hideDetailsCaption: "<%=skResMgr.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
            }
        });
    </script>
    <form id="frmAssembly" runat="server" style="width: 100%">
	<%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <table align="center" border="0" cellpadding="8" cellspacing="2" width="100%" class="tablebg">
        <tr>
            <td rowspan="2" style="vertical-align: middle;width:40px;;padding-left:20px;">
            <img src="<%=Microsoft.Security.Application.Encoder.HtmlEncode(templateThemeDirectory)%>Repository/Site/Images/icon-attach-link.png"   alt="" /><span style="padding-left:20px;vertical-align:bottom;"> <%=skResMgr.GlobalResourceSet.GetString("Forms_ChooseAssembly_Header")%> </span></td>
        </tr>
    </table>
    <table align="center" border="0" cellpadding="6" width="94%" cellspacing="2" class="tablebg" style="padding-left:48px;padding-right:48px;">
        <tr style="width:100%;">
            <td class="sf-formlabel" style="width:30%;">
                <%=skResMgr.GlobalResourceSet.GetString("ChooseAssembly_Assembly")%>
            </td>
            <td style="width:70%;">
                <asp:FileUpload CssClass="txtboxStyle" ID="txtAssembly" runat="server" />
            </td>
        </tr>
        <tr style="width:100%;">
            <td class="sf-formlabel" style="width:30%;">
                <%=skResMgr.GlobalResourceSet.GetString("ChooseAssembly_Param")%>
            </td>
            <td style="width:70%;">
                <asp:TextBox ID="txtParam" runat="server" CssClass="txtboxStyle"></asp:TextBox>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <table align="right" border="0" cellpadding="6" cellspacing="2" width="100%" class="footerbg ">
        <tr>
            <div class="lineCss" style="width:90%;margin-left:20px;border-bottom-width: 0px;"></div>
            <td style="text-align:right;padding-top:12px;" >
                <asp:Button ID="btnCancel" runat="server" CssClass="inputsecondarybutton" Width="60px" OnClientClick="javascript:closeWin();" />
                <asp:Button CssClass="inputbutton" Width="60px" ID="btnOk" OnClientClick="javascript:return ValidateAssembly();"
                    runat="server" />
            </td>
           
        </tr>
    </table>
    </form>
</body>
</html>
