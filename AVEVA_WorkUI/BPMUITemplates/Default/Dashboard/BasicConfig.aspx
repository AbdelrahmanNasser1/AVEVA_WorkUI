<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.Bam.DashBoard.BasicConfig" %>
<%@ Register Src="../Scheduler/ScheduleBAM.ascx" TagName="ScheduleBAM" TagPrefix="uc1" %>

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
            //divdetails.style.height = document.body.clientHeight - 70;
        }

        function CloseDataPointFrameAndRefresh() {
            var frameel = document.getElementById("datapointframe");
            frameel.style.display = "none";
            window.location.assign(window.location.toString());
        }

        function OpenWebServiceConfiguration() {

            var proprObj = document.getElementById("<%=divWebServiceConfig.ClientID%>");
            proprObj.style.position = "absolute";
            proprObj.style.visibility = "visible";

            proprObj.style.display = "block";
            proprObj.style.left = 355 + 'px';
            proprObj.style.top = 90 + 'px';
            proprObj.style.width = 640 + 'px';
            var dis = document.getElementById("divdetails");
            dis.style.display = "none";
            var iframetop = document.getElementById("<%=iframetop.ClientID%>");
            iframetop.style.position = "absolute";
            iframetop.style.display = 'block';
            iframetop.style.width = proprObj.offsetWidth;
            iframetop.style.height = proprObj.offsetHeight;
            iframetop.style.left = proprObj.offsetLeft;
            iframetop.style.top = proprObj.offsetTop;
            proprObj.style.zIndex = iframetop.style.zIndex + 1;
            return false;
        }

        function CloseDivSlot() {
            var divPropertyDiv = document.getElementById("<%=divWebServiceConfig.ClientID%>");
            divPropertyDiv.style.display = "none";
            var dis = document.getElementById("divdetails");
            dis.style.display = "block";
            var iframetop = document.getElementById("<%=iframetop.ClientID%>");
            iframetop.style.display = 'none';
        }
        function EnableDiv() {
            var dis = document.getElementById("divdetails");
            dis.style.display = "block";
        }
        function RestoreDefault() {
            var txtCustomService = document.getElementById('txtCustomService');
            var hdnDefault = document.getElementById('hdnDefault');

            if (txtCustomService != null) {
                txtCustomService.value = hdnDefault.value;
            }
            return false;
        }
    </script>
 </head>
<link rel="stylesheet" type="text/css" href="<%:cssPath%>Common/StyleSheet/Global.css" />
<body class="lefttdbg" style="border: none; margin: none; padding: none;overflow-y:scroll;"
    leftmargin="2px" topmargin="2px" rightmargin="2px" bottommargin="2px" scroll="no">
     <script>
         function ShowPackageWindow() {
             var application = '<%= AppName%>';
             var workflowName = '<%= WorkflowName%>';
             var url = "../Package/PackageList.aspx?&mode=BAM Workflow" + "&Name=" + workflowName + "&AppName=" + application + "&SettingsType=basicconfig";
             var windowparams = "width=500,resizable=yes,status=no";
             var oWindow = radopen(url, null);
             oWindow.set_modal(true);
             oWindow.set_title("BAM Workflow");
             oWindow.setSize(590, 360);
         }

         
         

        function DisplayMessage(message) {

            se.ui.messageDialog.showAlert("<%=GR.GetString("Security_Rights_comn_Alert_for_list")%>", message);
        }
        function DisplayErrorMessage(message) {

            se.ui.messageDialog.showError("<%=GR.GetString("Basic Configuration")%>", message);
        }



       </script>
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
        </script> 
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
    <table width="100%" height="98%" cellspacing="0" cellpadding="0" border="0" class="lefttdbg" style="overflow-y:scroll;">
        <tr>
            <td valign="bottom" height="25">
                <table border="0" cellspacing="1" cellpadding="2" width="100%" height="25px" style="table-layout: fixed;">
                    <tr>
                        <td class="subtitle" style="padding-left:35px; padding-top: 10px"> 
                            <%-- <th align="left" class="gridbg" style="height: 25px">--%>
                            <span class="subtitle">
                                <%=GR.GetString("Workflow Dashboard Preferences") %></span>
                            <%-- </th>--%>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr id="mainrow">
            <td>
                <table cellspacing="1" cellpadding="4" border="0" width="98%" height="100%" style="padding-right:20px;">
                    <tr>
                        <td class="lefttdbg" colspan="2" align="center" height="100%" <%--style="width: 545px;border:1px solid;border-color:#666666"--%>>
                            <table height="20px">
                                <tr>
                                    <td>
                                        <span class="description">
                                            <%=GR.GetString("BasicConfigSettings")%></span>
                                    </td>
                                </tr>
                            </table>
                            <div id="divdetails" style="width: 750px;height: 430px;overflow: hidden;border:1px solid;border-color:#666666;">
                                <uc1:ScheduleBAM ID="ScheduleBAM1" OnSchedulerEventHandlerEvent="SchedulerEventHandlerEvent"
                                    runat="server" />
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <asp:LinkButton ID="lnkConfigureProcess" CssClass="textlinkblue" runat="server" OnClientClick="javascript:return OpenWebServiceConfiguration();"></asp:LinkButton><span class="description"><%=GR.GetString("bamwebservice_clickheredescription")%></span>
                        </td>
                   </tr>
                </table>
            </td>
        </tr>      
        <tr>
            <td >
                <table width="90%" border="0" cellspacing="0" cellpadding="2">
                    <tr>
                        <td align="right" valign="top">
                            <input type="button" class="inputsecondarybutton" value="<%=GR.GetString("Cancel")%>" name="btncancel"
                                   onclick="Check();" id="Button3">	
                            <asp:Button ID="ProcessNowButton" Text="Process Now" runat="server" CssClass="inputbutton" />
                        </td>
                        <td width="10">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <iframe id="datapointframe" style="position: absolute; display: none; border: solid 1px black;"
        src="blank.htm"></iframe>
        <div id="divWebServiceConfig" runat="server" style="display: none;" >
        <table border="0" width="100%" class="lefttdbg" align="center" cellpadding="0"
            cellspacing="0" id="Table2">
            <tr>
                <td align="center">
                    <table border="0" width="100%" align="center" cellpadding="4" cellspacing="0" id="Table3" class="fieldset">
                        <tr>
                            <td class="subtitle" align='left' >
                             <span > <%=GR.GetString("bamwebservice_header")%></span> 
                            </td>
                            <td class="subtitle" align='right'>
                                <a onclick="javascript:CloseDivSlot()">
                                    <img src="<%:imagePath%>/close.gif" width="17" height="17"
                                        border="0" onclick="CloseDivSlot();"></a></td>
                        </tr>
                        <tr>
                            <td colspan="2" align="left" >
                                <span class="description">&nbsp;&nbsp;&nbsp;<%=GR.GetString("bamwebservice_headerdesc")%></span>
                             </td>
                        </tr>
                        <tr>
                            <td colspan="2" width="100%" align="center">
                                <div style="overflow-y: auto;height: 340px;overflow-x: hidden;">     
                                    </br>                                   
                                    <fieldset style="width:96%;" id="Fieldset4" name="Web Service URL" class="FieldSet">
                                        <div id="div1" style="text-align:left;" runat="server">
                                            <legend class="subtitle"><%=GR.GetString("bamwebservice_WebServicefield")%></legend>
                                        </div>                                 
                                        </br>      
                                        <table width="100%">                                          
                                            <tr id="idCustomWebService" runat="server" visible="true">
                                                <td>&nbsp;&nbsp;
                                                    <span class="description"><%=GR.GetString("bamwebservice_webserviceurl")%>: </span>
                                                </td>
                                                <td> 
                                                    <input type="hidden" id="hdnDefault" runat="server" />                                                    
                                                    <asp:TextBox CssClass="inputtext" Width="250px" ID="txtCustomService" MaxLength="2000" runat="server"></asp:TextBox><asp:RequiredFieldValidator Display="Dynamic" ControlToValidate="txtCustomService" ID="rfvWebService" runat="server" ValidationGroup="ValidateWebService">&nbsp;<img Id="imgRFV" runat="server" />
                                                    </asp:RequiredFieldValidator>&nbsp;&nbsp;&nbsp;<asp:Button CssClass="inputbutton" ID="btnReset" OnClientClick="javascript:return RestoreDefault();" runat="server" Width="130px"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width:30%">&nbsp;&nbsp;
                                                    <span class="subtitle"></span>
                                                </td>
                                                <td>
                                                    <span class="description"><%=GR.GetString("bamwebservice_defaultwebservicedesc")%></asp:Label></span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr >  
                                                <td colspan="2">                                                   
                                                    &nbsp;&nbsp;<img Id="imgNote1" runat="server" />&nbsp;<span class="description"><%=GR.GetString("bamwebservice_webserviceurlnote")%></span>
                                                </td>
                                            </tr>
                                        </table>                                           
                                    </fieldset>  </br>
                                    <fieldset style="width:96%;" id="Fieldset3" name="Credentials" class="FieldSet">
                                        <div id="div4" style="text-align:left;" runat="server">
                                            <legend class="subtitle"><%=GR.GetString("bamwebservice_credentialsfield")%></legend>
                                        </div>    
                                            </br>                                   
                                        <table width="100%">                                                  
                                            <tr>
                                                <td style="width:30%">&nbsp;&nbsp;
                                                    <span class="subtitle"><%=GR.GetString("bamwebservice_username")%>: </span>
                                                 </td>
                                                 <td>
                                                    <asp:TextBox CssClass="inputtext" ID="txtUserName" MaxLength="50" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">&nbsp;&nbsp;
                                                    <span class="description"><%=GR.GetString("bamwebservice_usernamedesc")%></span>
                                                 </td>                                                 
                                            </tr>
                                            <tr>
                                                <td style="width:30%">&nbsp;&nbsp;
                                                    <span class="subtitle"><%=GR.GetString("bamwebservice_password")%>: </span>
                                                 </td>
                                                  <td> 
                                                   <asp:TextBox TextMode="Password" CssClass="inputtext" ID="txtPassWord" MaxLength="50" runat="server"></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;
                                                   
                                                </td>
                                            </tr>  
                                            <tr>
                                                <td colspan="2">
                                                    &nbsp;
                                                </td>
                                            </tr>  
                                            <tr>
                                                <td colspan="2">                                                   
                                                    &nbsp;&nbsp;<img Id="imgNote2" runat="server" />&nbsp;<span class="description"> <%=GR.GetString("bamwebservice_credentialsdesc")%></span>
                                                </td>
                                            </tr>                                        
                                        </table>                                            
                                    </fieldset>                                                                
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" width="100%" >
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td width="50%" id="Td4" align="left">
                                            &nbsp;
                                        </td>
                                        <td width="50%" id="Td5" align="center">
                                            <input type="button" id="btnCancel" name="btnCancel" onclick="javascript: CloseDivSlot();"
                                                class="inputsecondarybutton" runat="server" />&nbsp;
                                             <asp:Button ID="btnSave" runat="server" CssClass="inputbutton" ValidationGroup="ValidateWebService" OnClientClick="EnableDiv()"/>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
        <iframe width="0" scrolling="no" height="0" style="display:none;" frameborder="0" id="iframetop" runat="server">
        </iframe>
    </form>    
</body>
</html>
