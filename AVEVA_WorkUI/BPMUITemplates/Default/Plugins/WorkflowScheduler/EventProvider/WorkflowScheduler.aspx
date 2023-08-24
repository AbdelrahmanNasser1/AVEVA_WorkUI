<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.WorkFlow.Scheduler.WorkflowSchedulerCodebehind" %>
<%@ Register Src="../../../Scheduler/WorkflowScheduler.ascx" TagName="ScheduleBAM" TagPrefix="uc1" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Untitled Page</title>
    <style>

        html, body, form
        {
            height: 100%;
        }
    </style>
</head>
<body>
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <form id="form1" runat="server">
	<%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <link href="<%=cssPath%>Common/StyleSheet/Global.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" type="text/css" href="<%=cssPath%>CommonUXControls/StyleSheet/se.ui.min.css" />
     <script>
         // Initialize locales for message dialog
         se.ui.messageDialog.setGlobalOptions({
             localization: { // All localization related default can be set
                 closeButtonCaption: "<%=GetLangSpecText("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                 okButtonCaption: "<%=GetLangSpecText("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                 cancelButtonCaption: "<%=GetLangSpecText("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                 showDetailsCaption: "<%=GetLangSpecText("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                 hideDetailsCaption: "<%=GetLangSpecText("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
             }
         });
       </script>
    <div style="height:90%; ">
        <table  style="border-spacing:1px;border-collapse:separate;border-width:0; width:98%;margin:0px auto">
            <tr>
                <td class="pagetitle ">
                    <img src="<%=cssPath%>Plugins/WorkflowScheduler/Images/icon-workflow-scheduler.png" style="vertical-align:middle" alt=""/><%=GetLangSpecText("ec_schedule_Scheduler")%>
                </td>
            </tr>
            <tr>
               
                <td style="width:100%" colspan="2"> 
                    <span class="description">
                        <%=GetLangSpecText("ec_workflowscheduler_helptext")%>
                    </span>
                </td>
            </tr>
        </table>
        
        <table style="border-spacing:1px;border-collapse:separate;border-width:0;width:98%;margin:0px auto;height:90%"   class="tablebg" >
            <tr>
                <td class="lefttdbg" style="width: 50%; vertical-align:top;padding:7px;">
                    <span class="subtitle">
                        <%=GetLangSpecText("ec_schedule_wkflw_name")%>
                    </span>
                    <br />
                    <span class="description">
                        <%=GetLangSpecText("ec_workflowscheduler_helptext1")%>
                    </span>
                </td>
                <td class="righttdbg" style="width: 50%;padding:2px;vertical-align:top;">
                    <uc1:ScheduleBAM ID="ScheduleBAM1" runat="server" />
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
