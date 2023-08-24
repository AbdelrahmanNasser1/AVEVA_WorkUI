<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.DefaultFormsTasks" %>

<!DOCTYPE html>
<html style="height:100%">
<head id="Head1" runat="server">
    <title>
        <%=_ResManager.GlobalResourceSet.GetString("FormFormOptionsKey")%></title>
 
    <script type="text/javascript">

        function RefreshGrid() {
            closeWin();
            //GetRadWindow().BrowserWindow.opener.document.getElementById("mainframe").contentWindow.document.getElementById("gridframe").contentWindow.RefreshGrid();
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
        function hideWin() {
            var oWindow = GetRadWindow();
            oWindow.hide();
        }


        function openWin(uri) {
            var w, h;

            if (document.all || document.layers) {
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
            hideWin(); // here just hide the window, this will get closed when process designer closed.
        }
    </script>
</head>
<body style="overflow: hidden;height:100%">
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=cssPath %>CommonUXControls/StyleSheet/se.ui.min.css" />
    <link href="<%=cssPath%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />   
    <form id="frmOptions" runat="server" style="height:100%">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <table style="width:100%;border-width:0;height:100%">
        <tr style="height:5%">
            <td class="pagetitle">
                <img src="<%=cssPath%>Skeltaforms/Images/form-default.png" alt="" style="vertical-align:middle;" />
                <%=_ResManager.GlobalResourceSet.GetString("FormFormTasksKey")%>
            </td>
        </tr>
        <tr style="height:10%">
            <td colspan="2" style="text-align:center;padding:5px">
                <%if (confirmationMsg != "")
                  {%>
               
                                    <span class="successfulmsg" style="vertical-align: middle">
                                        <%=confirmationMsg %>
                                    </span>
                            
                <%} %>
                <br />
                <span></span>&nbsp;&nbsp;<span class="description">
                    <%=_ResManager.GlobalResourceSet.GetString("FormFormOptionsOperationsKey")%>
                    '<%=WorkflowName%>' form. </span>
            </td>
        </tr>
        <tr style="text-align:left;vertical-align:top;height:80%">
            <td>
                <table style="width:98%;border-width:0;border-spacing:1px;margin:auto" class="tablebg" >
                    <tr>
                        <td  style="height: 120px;vertical-align:middle;width:50%;padding:6px" class="lefttdbg">
                            <div>
                                <span class="subtitle">
                                    <%=_ResManager.GlobalResourceSet.GetString("FormFormOrdinaryTasks")%></span></div>
                            <br />
                            <div>
                                <span class="description">
                                    <%=_ResManager.GlobalResourceSet.GetString("FormFormOptionsChooseActionKey")%></span><br />
                                <%=confirmationMsg2 %>
                            </div>
                        </td>
                        <td class="righttdbg" style="padding:6px">
                            <span class="description" style="">
                                <asp:RadioButtonList ID="RadioButtonList1" runat="server" CssClass="inputradio">
                                </asp:RadioButtonList>
                            </span>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height:2%">
            <td style="text-align:right;padding:8px">
                <input id="Button1" runat="server" name="AddWorkflow" type="button" value="Finish"
                    class="inputbutton" onclick="document.forms[0].submit();"  />
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
