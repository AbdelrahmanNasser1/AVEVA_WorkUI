<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.WorkflowTasks" %>

<!DOCTYPE html >
<html style="height:94%;">
<head id="Head1" runat="server">
    <title><%= _ResManager.GlobalResourceSet.GetString("ec_workflow_tasks_title")%></title>
    <script type="text/javascript">
        function RefreshGrid()
        {
            closeWin();
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
            try
            {
                var oWindow = GetRadWindow();
                oWindow.close();
            }
            catch (err)
            {
                if (window.opener != null)
                {
                    if (window.opener.location.href.indexOf('VersionGrid.aspx', 0) != -1 && window.opener.top.opener.location.href.indexOf('Association.aspx', 0) != -1)
                    {
                        window.opener.top.opener.RefreshGrid();
                        window.opener.RefreshGrid();
                        window.close();
                    }
                    else
                    {
                        window.close();
                    }
                }
                else
                {
                    var win = window.open('', '_self');
                    win.close();
                    return false;
                }
            }
        }

        function hideWin()
        {
            try
            {
                var oWindow = GetRadWindow();
                oWindow.hide();
            }
            catch (err)
            {
                if (window.opener != null)
                {
                    window.close();
                } else
                {
                    var win = window.open('', '_self');
                    win.close();
                    return false;
                }
            }
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

            var winHeight = (h * 90 / 100);
            var winWidth = (w * 90 / 100);

            var winLeft = (w - winWidth) / 2;
            var winTop = (h - winHeight) / 2;

            var myw = window.open(uri, '', "left=" + winLeft + ",top=" + winTop + ",width=" + screen.availWidth + ",height=" + screen.availHeight + ",resizable=" + winIsResizable + ",scrollbars=" + winIsScrollable + "");
            try
            {
                myw.moveTo(0, 0);
                myw.resizeTo(screen.availWidth, screen.availHeight);
            } catch (err)
            {

            }
            hideWin(); // here just hide the window, this will get closed when process designer closed.
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

        function setunlockhidvalue()
        {
            document.getElementById("hidunlock").value = "false";
        }
    </script>
</head>
<body style="height:100%;overflow:hidden">
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=cssPath %>CommonUXControls/StyleSheet/se.ui.min.css" />      
    <script>
        // Initialize locales for message dialog
        se.ui.messageDialog.setGlobalOptions({
            localization: { // All localization related default can be set
                closeButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                okButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                cancelButtonCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                showDetailsCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                hideDetailsCaption: "<%=_ResManager.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
            }
        });
    </script>
    <form id="frmOptions" runat="server" style="width:100%;height:100%">
      <%=System.Web.Helpers.AntiForgery.GetHtml()%>
      <link href="<%=cssPath%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
      <table style="width:100%;border-width:0;border-spacing:0;margin:auto;height:100%;"  >
            <tr style="height:10%;width:100%">
                <td class="MainHeading" style="width:100%;padding:6px">
                    <img src="<%=cssPath%>Skeltaforms/Images/form-default.png" alt="" style="vertical-align:middle" />
                     <%= _ResManager.GlobalResourceSet.GetString("ec_workflow_tasks")%>
                </td>
            </tr>
            <tr style="height:20%;width:100%">
                <td style="text-align:left;padding-left:20px;">
                    <%if (confirmationMsg != "")
                                   {%>
                    
                        <span class="successfulmsg" style="vertical-align: middle">
                            
                        </span>
                    
                        <span class="errormsg" style="vertical-align: middle; color: Red;">
                            <%=Microsoft.Security.Application.Encoder.HtmlEncode(AssociationMessage)%>
                        </span>
                        <br />
                   
                    <%} %>
                    <br />
                    <span class="description">
                        <%= _ResManager.GlobalResourceSet.GetString("ec_workflow_tasks_options")%>
                        '<%=Microsoft.Security.Application.Encoder.HtmlEncode(WorkflowName)%>'
                        <%= _ResManager.GlobalResourceSet.GetString("ec_workflow")%>
                        </span>
                </td>
            </tr>
            <tr style="height:60%;width:100%">
                <td style="height:100%;vertical-align:top;padding-top:20px;" >
                    <table style="width:100%; border-width:0;border-spacing:1;margin:auto" class="tablebg" >
                        <tr>
                            <td style="vertical-align:top;width:45%;padding-left:18px;" class="lefttdbg" >
                                <span class="subtitle">
                                    <%= _ResManager.GlobalResourceSet.GetString("ec_tasks")%>
                                </span>
                                <div class="description">
                                    <%= _ResManager.GlobalResourceSet.GetString("ec_workflow_tasks_opt")%>
                                    <br />
                                </div>
                            </td>
                            <td class="righttdbg" style="padding-right:16px;width:55%;">
                                <asp:RadioButtonList ID="RadioButtonList1" runat="server" CssClass="inputradio">
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr id="TrNote" runat="server" style="padding:6px"> 
                            <td colspan="2" class="lefttdbg" id="notetd" runat="server" style="text-align:center">
                                <img id="Img1" alt="" runat="server" src="<%$ ReplaceTemplateExpn:/Common/Images/icon-note.png%>"
                                  style="vertical-align:top;" ><span class="note">
                                        <%=confirmationMsg2 %>
                                    </span>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr  style="height:10%;width:100%">
                <td style="text-align:right;vertical-align:bottom;width:100%;height:100%;padding-bottom:20px; padding-right:10px">
                <br />    <input id="Button1" name="AddWorkflow" type="button" value="<%= _ResManager.GlobalResourceSet.GetString("ec_wf_tasks_finish_btn")%>"
                        class="inputbutton" onclick="javascript:submitfrm();" style="z-index: 100;"  />
                </td>
            </tr>
            
        </table>
        <asp:HiddenField ID="hiditemid" runat="server" Value="" />
        <asp:HiddenField ID="hidlistid" runat="server" Value="" />
        <asp:HiddenField ID="hidunlock" runat="server" Value="" />
    </form>
    <p>
&nbsp;&nbsp;&nbsp;
    </p>
</body>
</html>
<script type="text/javascript">
    function submitfrm()
    {
        document.forms[0].submit();
    }
</script>
