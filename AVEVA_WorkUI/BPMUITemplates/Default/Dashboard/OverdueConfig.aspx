<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.Bam.DashBoard.OverdueConfig" Theme="" StylesheetTheme="" %>
<%@ Register Src="PeriodSlot.ascx" TagName="PeriodSlot" TagPrefix="uc2" %>
<%@ Register Src="ThresholdInput.ascx" TagName="ThresholdInput" TagPrefix="uc1" %>
<%@ OutputCache Location="None" %>
<html>
<head id="Head1" runat="server">
     <%-- <meta http-equiv="X-UA-Compatible" content="IE=5">--%>

    <script>

        window.onresize = Resize;
        window.onload = Resize;
        function Resize() {
            var divdetails = document.getElementById("divdetails");
            var mainrow = document.getElementById("mainrow");
         }
   
  
  
    </script>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
   
    </head>
    <style>
        html, body {
            height: 100%;
            width: 100%;
            overflow: hidden;
        }
        .inputselect {
            width: 325px !important;
        }
        .inputtext {
            margin-right: 18px;
        }
        select#TotalPendingThreshold_DropDownList1 {
            width: 596px !important;
        }
        .description {
            width: 297px !important;
        }

    </style>
<link rel="stylesheet" type="text/css" href="<%=cssPath%>Common/StyleSheet/Global.css" />
<link href="<%=cssPath%>CommonUXControls/StyleSheet/se.ui.min.css"  rel="stylesheet" type="text/css" />  

<body class="lefttdbg" style="border: none; margin: none; padding: none; overflow: -moz-scrollbars-none;"
    leftmargin="2px" topmargin="2px" rightmargin="2px" bottommargin="2px" scroll="no">
<script src="<%=JSPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <script>
         se.ui.messageDialog.setGlobalOptions({
             localization: {
                 closeButtonCaption: "<%=GR.GetString("se_ui_messagedialog_close_caption") %>",
                 okButtonCaption: "<%=GR.GetString("se_ui_messagedialog_ok_caption") %>",
                 cancelButtonCaption: "<%=GR.GetString("se_ui_messagedialog_cancel_caption") %>",
                 showDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_showdetails_caption") %>",
                 hideDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_hidedetails_caption") %>"
             }
         });
   

         function ShowPackageWindow() 
         {
             var application = '<%= AppName%>';
             var workflowName = '<%= WorkflowName%>'; 
             var url = "../Package/PackageList.aspx?&mode=BAM Workflow" + "&Name="+workflowName + "&AppName="+application+"&SettingsType=overdue";
             var windowparams="height=320,width=500,resizable=yes,status=no";             
             var oWindow = radopen(url, null);
             oWindow.set_modal(true);
             oWindow.set_title("BAM Workflow");
             oWindow.setSize(590, 360);
        
         }
         function DisplayErrorMessage(message) {

             se.ui.messageDialog.showAlert("<%=GR.GetString("Security_Rights_comn_Alert_for_list")%>", message); 
         }

     </script>
      
    <form id="form1" runat="server">
        <script>
            function Check() {
                var oManager;
                try {
                    oManager = parent.parent.parent.parent.GetRadWindowManagerForListControl();
                }
                catch (e) { }
                if (oManager == null || oManager == 'undefined') {
                    // If it is list inside another list
                    var oManager;
                    try {
                        oManager = parent.parent.parent.GetRadWindowManagerForListControl();
                    }
                    catch (e) { }
                }
                if (oManager == null || oManager == 'undefined')
                    oManager = parent.parent.GetRadWindowManagerForListControl();
                var oWnd = oManager.getWindowByName("WindowCloseBehaviour");
                oWnd.close();
            }

        </script>
        <%=System.Web.Helpers.AntiForgery.GetHtml()%> 
         <table width="100%" height="98%" cellspacing="0" cellpadding="0" border="0" class="lefttdbg">
        <tr>
            <td valign="bottom" height="35" style="padding-left: 5px">
                <table border="0" cellspacing="1" cellpadding="2" width="100%" height="25px" style="table-layout: fixed;">
                    <tr>
                       
                             <td align="left" style="height: 25px" >
                            <span class="description" style="margin-left:16px">
                                <%=GR.GetString("BAM Dashboard Configuration for")%>
                                <%=_BAMConfigurationAdapter.WorkflowName %>
                                <%=GR.GetString("Workflow")%></span>
                           </td>
                        
                    </tr>
                </table>
            </td>
        </tr>
      
        <tr id="mainrow">
            <td>
                <table cellspacing="1" cellpadding="2" border="0" width="98%" height="100%" align="center">
                    <tr>
                        <td class="lefttdbg" colspan="2" align="center" height="100%">
                            <div id="divdetails" style="width: 100%; height: 100%;">
                                <table align="center" border="0" cellpadding="2" cellspacing="2" style="width: 100%">
                                    <tr>
                                        <td>
                                            <span class="description">
                                                <%=GR.GetString("Total Pending Workflows Threshold")%></span>
                                        </td>
                                        <td>
                                            <uc1:ThresholdInput ID="TotalPendingThreshold" AllowPercentageOfTotal="false" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                                <table align="center" border="0" cellpadding="5" cellspacing="1" class="tablebg" style="width:100%">
                                    <tr>
                                        <td colspan="3" class="description" align="left" style="padding-left: 312px">
                                            <%=GR.GetString("Overdue Analysis Configuration") %>
                                        </td>
                                    </tr>
                                    <tr class="lefttdbg">
                                        <td class="description">
                                            <%=GR.GetString("Slot") %>
                                        </td>
                                        <td class="description">
                                            <%=GR.GetString("Slot Period") %>
                                        </td>
                                        <td class="description">
                                            <%=GR.GetString("Threshold") %>
                                        </td>
                                    </tr>
                                    <tr class="lefttdbg">
                                        <td>
                                            <span class="description">
                                                <%=GR.GetString("Slot1")+" (<=)" %></span>
                                        </td>
                                        <td >
                                            <uc2:PeriodSlot ID="PeriodSlot1" runat="server" />
                                        </td>
                                        <td>
                                            <uc1:ThresholdInput ID="ThresholdInput1" AllowPercentageOfTotal="true" runat="server" />
                                        </td>
                                    </tr>
                                    <tr class="lefttdbg">
                                        <td>
                                            <span class="description">
                                                <%=GR.GetString("Slot2")+" (> "+GR.GetString("Slot1")+" <= )" %></span>
                                        </td>
                                        <td>
                                            <uc2:PeriodSlot ID="PeriodSlot2" runat="server" />
                                        </td>
                                        <td>
                                            <uc1:ThresholdInput ID="ThresholdInput2" AllowPercentageOfTotal="true" runat="server" />
                                        </td>
                                    </tr>
                                    <tr class="lefttdbg">
                                        <td>
                                            <span class="description">
                                                <%=GR.GetString("Slot3")+" (> "+GR.GetString("Slot2")+" <= )" %></span>
                                        </td>
                                        <td>
                                            <uc2:PeriodSlot ID="PeriodSlot3" runat="server" />
                                        </td>
                                        <td>
                                            <uc1:ThresholdInput ID="ThresholdInput3" AllowPercentageOfTotal="true" runat="server" />
                                        </td>
                                    </tr>
                                    <tr class="lefttdbg">
                                        <td>
                                            <span class="description">
                                                <%=GR.GetString("Slot4")+" (> "+GR.GetString("Slot3")+" <= )" %></span>
                                        </td>
                                        <td>
                                            <uc2:PeriodSlot ID="PeriodSlot4" runat="server" />
                                        </td>
                                        <td>
                                            <uc1:ThresholdInput ID="ThresholdInput4" AllowPercentageOfTotal="true" runat="server" />
                                        </td>
                                    </tr>
                                    <tr class="lefttdbg">
                                        <td>
                                            <span class="description">
                                                <%=GR.GetString("Slot5")+" (> "+GR.GetString("Slot4")+" <= )" %></span>
                                        </td>
                                        <td>
                                            <uc2:PeriodSlot ID="PeriodSlot5" runat="server" />
                                        </td>
                                        <td>
                                            <uc1:ThresholdInput ID="ThresholdInput5" AllowPercentageOfTotal="true" runat="server" />
                                        </td>
                                    </tr>
                                    <tr class="lefttdbg">
                                        <td>
                                            <span class="description">
                                                <%=GR.GetString("Slot6")+" (> "+GR.GetString("Slot5")+" <= )" %></span>
                                        </td>
                                        <td>
                                            <uc2:PeriodSlot ID="PeriodSlot6" runat="server" />
                                        </td>
                                        <td>
                                            <uc1:ThresholdInput ID="ThresholdInput6" AllowPercentageOfTotal="true" runat="server" />
                                        </td>
                                    </tr>
                                    <tr class="lefttdbg">
                                        <td>
                                            <span class="description">
                                                <%=GR.GetString("Slot7")+" (> "+GR.GetString("Slot6")+" <= )" %></span>
                                        </td>
                                        <td>
                                            <uc2:PeriodSlot ID="PeriodSlot7" runat="server" />
                                        </td>
                                        <td>
                                            <uc1:ThresholdInput ID="ThresholdInput7" AllowPercentageOfTotal="true" runat="server" />
                                        </td>
                                    </tr>
                                    <tr class="lefttdbg">
                                        <td>
                                            <span class="description">
                                                <%=GR.GetString("Slot8")+" (> "+GR.GetString("Slot7")+" <= )" %></span>
                                        </td>
                                        <td>
                                            <uc2:PeriodSlot ID="PeriodSlot8" runat="server" />
                                        </td>
                                        <td>
                                            <uc1:ThresholdInput ID="ThresholdInput8" AllowPercentageOfTotal="true" runat="server" />
                                        </td>
                                    </tr>
                                    <tr class="lefttdbg">
                                        <td>
                                            <span class="description">
                                                <%=GR.GetString("Slot9")+" (> "+GR.GetString("Slot8")+" <= )" %></span>
                                        </td>
                                        <td>
                                            <uc2:PeriodSlot ID="PeriodSlot9" runat="server" />
                                        </td>
                                        <td>
                                            <uc1:ThresholdInput ID="ThresholdInput9" AllowPercentageOfTotal="true" runat="server" />
                                        </td>
                                    </tr>
                                    <tr class="lefttdbg">
                                        <td>
                                            <span class="description">
                                                <%=GR.GetString("Slot10")+" (> "+GR.GetString("Slot9")+" <= )" %></span>
                                        </td>
                                        <td>
                                            <uc2:PeriodSlot ID="PeriodSlot10" runat="server" />
                                        </td>
                                        <td>
                                            <uc1:ThresholdInput ID="ThresholdInput10" AllowPercentageOfTotal="true" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
        <div style="bottom: 0;right: 0;position: fixed;padding-right: 78px;">
            <input type="button" class="inputsecondarybutton" value="<%=GR.GetString("Cancel")%>" name="btncancel"
                   onclick="Check();" id="Button2">
           <input type="button" class="inputbutton" value="<%=GR.GetString("Save")%>" name="btnok"
                                onclick="document.forms[0].submit();" id="Button1">
 </div>
    </form>
</body>
</html>
