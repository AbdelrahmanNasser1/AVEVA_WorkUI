<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.Bam.DashBoard.DataPoint" Theme="" StylesheetTheme="" %>
<%@ Register Src="PeriodSlot.ascx" TagName="PeriodSlot" TagPrefix="uc2" %>
<%@ Register Src="ThresholdInput.ascx" TagName="ThresholdInput" TagPrefix="uc1" %>

<%@ OutputCache Location="None"  %>
<html>
<head id="Head1" runat="server">
<%--    <link rel="stylesheet" type="text/css" href="<%=cssPath%>common/StyleSheet/global.css" />
--%>    <script>
        function CloseDataPointFrame()
        {
            parent.CloseDataPointFrameAndRefresh();
        }
        
    </script>
</head>
<style>
    
    select#ActivityListAS {
        margin-left: 198px !important;
    }
    select#ActivityListAO {
        margin-left: 195px !important;
    }
    select#OperatorTypeAO {
        margin-left: 250px !important;
    }
    
    .inputtextarea,.inputtext { width: 602px !important; }
    .inputselect {
        width: 230px !important;
    }
    .inputselect {
        margin-left: 0px !important;
        min-width: 602px !important;
    }
    .drop-second {
        margin-left: 10px;
    }
    .drop-first {
        margin-left: 22px;
    }
    .description {
        margin-top: 11px;
        font-size: 12px;
        color: #666666;
        width: 249px !important;
        display: inline-block;
        margin-bottom: 12px;
    }
    select#OperaterType {
        margin-left: 141px !important;
    }
    .tableWfStatusleft {
        padding-left: 245px;
     }
</style>
    <link rel="stylesheet" type="text/css" href="<%:cssPath%>Common/StyleSheet/Global.css"  />
<script src="../Common/JavaScripts/jquery.min.js"></script>
<script src="../Common/JavaScripts/AutoLogoff.js"></script>
<body style="background-color:White;font-family:Roboto; font-size:12px; border: none; margin: 0px 0px 0px 7px; padding: none;overflow:hidden;" leftmargin="2px" topmargin="2px" rightmargin="2px" bottommargin="2px" scroll="no">
    
     <form id="form1" runat="server">
         <%=System.Web.Helpers.AntiForgery.GetHtml()%>
         <script src="<%=JSPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
        <link href="<%:cssPath%>CommonUXControls/StyleSheet/se.ui.min.css"  rel="stylesheet" type="text/css" />  
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


             function DisplayMessage(message) {

                 se.ui.messageDialog.showAlert("<%=GR.GetString("Security_Rights_comn_Alert_for_list")%>", message);
             }
             function DisplayErrorMessage(message) {

                 se.ui.messageDialog.showError("<%=GR.GetString("Data Point(s)")%>", message);
             }

         </script>
        <table>
            <tr>
                <td><span class="description"><%=GR.GetString("Name")%></span>
                <asp:TextBox ID="DataPointName" runat="server" CssClass="inputtext" Width="375px"  MaxLength="50"></asp:TextBox></td>
            </tr>
            <tr>
                <td><span class="description"><%=GR.GetString("Condition")%></span> 
                <asp:TextBox CssClass="inputtext" style="width: 375px;" ID="DataPointCondition" runat="server" TextMode="MultiLine" Rows="8" ></asp:TextBox></td>
            </tr>
            <tr>
                <td><span class="description"><%=GR.GetString("Condition based on") %></span> <asp:DropDownList ID="ConditionType" runat="server"  CssClass="inputselect drop-first" onchange="changeCondition(this)"></asp:DropDownList> </td>
                <script>
                    function changeConditionByName(elname)
                    {
                        var ws=document.getElementById("workflowStatus");
                        var as=document.getElementById("activityStatus");
                        var ao=document.getElementById("activityOutput");
                        ws.style.display="none";
                        as.style.display="none";
                        ao.style.display="none";
                        switch(elname)
                        {
                            case "Workflow Status": ws.style.display="block"; break;
                            case "Activity Status": as.style.display="block"; break;
                            case "Activity Output": ao.style.display="block"; break;
                        }                    
                    
                    }
                    function changeCondition(el)
                    {
                        changeConditionByName(el.value);
                    }
                </script>
            </tr>
            <tr height="350px">
                <td height="350px">
                    <div id="workflowStatus" style="-moz-box-sizing: border-box;border: solid 1px black; font-size: 12px;color: #333333;background-color: White; padding: 5px 5px 5px 5px; height: 300px;width:869px; overflow:auto;padding-top: 15px">
                         <%=GR.GetString("If Workflow Status Is")%><asp:DropDownList ID="OperaterType" runat="server"  CssClass="inputselect drop-second"></asp:DropDownList>    
                       <asp:CheckBoxList ID="WorkflowStatusTypes" runat="server" CssClass="inputcheckbox tableWfStatusleft">
                       </asp:CheckBoxList> 
                       <table width="100%">
                           <tr><td align="right" style="padding-top: 20px"><asp:Button ID="insertworkflow" runat="server" CssClass="inputbutton" Text="Insert"/>&nbsp;<asp:Button ID="insertworkflow_and" runat="server" CssClass="inputbutton" Text="Insert 'And'"/>&nbsp;<asp:Button ID="insertworkflow_or" runat="server" CssClass="inputbutton" Text="Insert 'Or'"/>&nbsp;</td></tr>
                       </table>                   
                       
                    </div>
                    <div id="activityStatus" style="-moz-box-sizing: border-box;display: none;font-size: 12px;color: #333333; border: solid 1px black; background-color: White; padding: 5px 5px 5px 5px; width:869px;  height: 300px; overflow:auto;padding-top: 15px">
                       <%=GR.GetString("If Activity")%> 
                       <asp:DropDownList ID="ActivityListAS" runat="server" CssClass="inputselect">
                       </asp:DropDownList>
                      <span class="description"><%=GR.GetString("has status")%></span> <asp:DropDownList ID="OperatorTypeAS" runat="server"  CssClass="inputselect"></asp:DropDownList>    
                       <br />
                        <asp:CheckBoxList ID="ActivityStatusTypes" runat="server" CssClass ="inputcheckbox tableWfStatusleft">
                       </asp:CheckBoxList>                        
                       <table width="100%"><tr><td align="right" style="padding-top: 10px"><asp:Button ID="asinsert" runat="server" CssClass="inputbutton" Text="Insert"/>&nbsp;<asp:Button ID="asinsert_and" CssClass="inputbutton" runat="server"  Text="Insert 'And'"/>&nbsp;<asp:Button ID="asinsert_or" CssClass="inputbutton" runat="server"  Text="Insert 'Or'"/>&nbsp;</td></tr></table>                   
                    </div>
                    <div id="activityOutput" style="-moz-box-sizing: border-box;display:none;border: solid 1px black; background-color: White; padding: 5px 5px 5px 5px; height: 300px;font-size: 12px;color: #333333;overflow:auto;width:869px; ">
                       <%=GR.GetString("If Activity")%> 
                       <asp:DropDownList ID="ActivityListAO" runat="server" CssClass="inputselect">
                       </asp:DropDownList> <br />
                       <%=GR.GetString("has started because of Incoming Link having Condition")%> <asp:DropDownList ID="OperatorTypeAO" runat="server" CssClass="inputselect"></asp:DropDownList>    
                       <br />
                       <div style="height: 135px;overflow:auto;">
                        <asp:CheckBoxList ID="activityOutputs" CssClass ="inputcheckbox tableWfStatusleft" runat="server">
                       </asp:CheckBoxList> 
                        </div>
                       <table width="100%"><tr><td align="right" style="padding-top: 72px"><asp:Button ID="aoinsert" runat="server" CssClass="inputbutton" Text="Insert"/>&nbsp;<asp:Button ID="aoinsert_or" runat="server" CssClass="inputbutton" Text="Insert 'Or'"/>&nbsp;</td></tr></table>                                          
                    </div>


                </td>                
            </tr>
            <tr>
            <td align="right" style="padding-top: 5px;">
            <%if( _dataPoint != null ) {%>
            <asp:Button ID="DeleteButton"  CssClass="inputbutton" runat="server" Text="Delete"/>
            <%} %>
           <asp:Button ID="CancelButton" runat="server" Text="Cancel" CssClass="inputsecondarybutton" OnClientClick="CloseDataPointFrame()" />&nbsp; <asp:Button ID="SaveButton" CssClass="inputbutton" runat="server"  Text="Save"/></td>
            </tr>
            
        </table>
        <script>document.getElementById("<%=DataPointName.ClientID %>").focus();</script>        
   </form>
</body>
</html>
