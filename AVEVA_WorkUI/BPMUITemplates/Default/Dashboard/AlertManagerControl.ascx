<%@ Control Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.Bam.AlertManagerUserControl" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<link rel="stylesheet" type="text/css" href="<%=cssPath%>Common/StyleSheet/Global.css" />
<script src="../Common/JavaScripts/jquery.min.js"></script>
<script src="../Common/JavaScripts/AutoLogoff.js"></script>
<link href="<%=cssPath%>TelerikAjax/StyleSheet/SkeltaEditor/Editor.css" rel="stylesheet" type="text/css" />
<link href="<%=cssPath%>TelerikAjax/StyleSheet/SkeltaEditor/Window.css" rel="stylesheet" type="text/css" /> 
<link href="<%=cssPath%>TelerikAjax/StyleSheet/SkeltaEditor/Window.SkeltaEditor.css" rel="stylesheet" type="text/css" />  
<link href="<%=cssPath%>TelerikAjax/StyleSheet/SkeltaEditor/Editor.SkeltaEditor.css" rel="stylesheet" type="text/css" />
<link href="<%=cssPath%>TelerikAjax/StyleSheet/AWTCalendar/Calendar.AWTCalendar.css" rel="stylesheet" type="text/css" />
<link href="<%=cssPath%>TelerikAjax/StyleSheet/AWTCalendar/Calendar.css" rel="stylesheet" type="text/css" />
<link href="<%=cssPath%>TelerikAjax/StyleSheet/AWTInput/Input.AWTInput.css" rel="stylesheet" type="text/css" />
<style type="text/css">
    .inlineBordertyle{
    background-color: #FFFFFF;
    border:1px solid;
    }
    .notepaddingleft 
    {
        padding-right: 700px;
    }
</style>
<table width="90%">
    <tr>
        <td>
            &nbsp;
        </td>
        <td align="right" valign="middle">
            <font class="MainPageTitle"><%=GR.GetString("Step")%></font>
            &nbsp;&nbsp;&nbsp;&nbsp;      
            <font class="MainPageTitle" id="fontStep1"><%=GR.GetString("1")%></font>
            &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <font class="MainPageTitleDisabled" id="fontStep2"><%=GR.GetString("2")%></font>
            &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <font class="MainPageTitleDisabled" id="fontStep3"><%=GR.GetString("3")%></font>
            &nbsp;&nbsp;&nbsp;&nbsp;
        </td>
    </tr>
</table>
<asp:ScriptManager ID="ScriptManager1" runat="server" />
<div id="divdetails" style="width: 95%; height: 580px; overflow: hidden;" >
    <table border="0" cellspacing="1" cellpadding="1" style="width: 100%; height: 100%;">
        <tr>
            <td style="height: 25px" 
                valign="top">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="middle">
                            <img src="<%$ ReplaceTemplateExpn:BAM/images/icon-rule.png%>" align="absmiddle"
                                hspace="2" id="iconmain" runat="server" />
                            
                                <asp:Label ID="lblStepDescription" runat="server" CssClass="pagetitle"></asp:Label>
                        </td>
                          
                        <td align="right" style="padding-right:30px;">
                           
                            <table>
                                <tr>                                    
                                    <td id="tdRule" runat="server">                                                                                                                               
                                        <input type="button" value="<%=GR.GetString("Rule")%>" id="btnRule" class="inputbutton" onclick="ToggleDiv('rule');"/>
                                        &nbsp;&nbsp;
                                    </td>
                                    <td id="tdTime" runat="server">                                                                                                                               
                                        <input type="button" value="<%=GR.GetString("Time")%>" id="btnTime" class="inputbuttondisabled" onclick="ToggleDiv('time');"/>
                                        &nbsp;
                                    </td>
                                    <td id="tdAction" runat="server">                                                                                                                               
                                        <input type="button" value="<%=GR.GetString("Action")%>" id="btnAction" class="inputbuttondisabled" onclick="ToggleDiv('action');"/>
                                        &nbsp;
                                    </td>                                                                        
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="height:20px;">
                            <div>
                            <div style="float:left;">
                                        <img alt="" src="<%=imagePath%>/down-arrow.gif" />
                                    </div>
                            <div style="float:left;padding-left:10px;padding-top:2px;">
                                        <div id="TaskDetails" runat="server" class="description">
                                            <%=GR.GetString("BAMAlerts_Description")%>
                                        </div>
                                    </div>
                            </div>
                        </td>
        </tr>
        <tr>
            <td>
                <table border="0" cellspacing="1" cellpadding="0" style="width: 100%; height: 100%;">
                    <tr valign="top" align="center">
                        <td>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" style="vertical-align: top;">
                                <tr valign="top">
                                    <td colspan="6">
                                        <div id="mainRowControl" runat="server" style="width: 100%;">
                                            <div id="divRule" runat="server" style="width: 100%">
                                                <table width="100%" style="height: 100%" cellpadding="2" cellspacing="2">
                                                    <tr>
                                                        <td align="left" valign="top">
                                                            
                                                                <table width="100%" cellpadding="1" cellspacing="2" border="0">
                                                                   
                                                                    <tr>
                                                                        <td colspan="2">
                                                                              <%=GR.GetString("BAMAlerts_OverDueHeader")%><br />
                                                                      <span class="description"><%=GR.GetString("BAMAlerts_OverDueRule")%></span> 
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>                                                                            
                                                                            <input type="checkbox" id="chkWorkflowCount" runat="server" class="inputcheckbox"/>
                                                                           <span class="description"><%=GR.GetString("BAMAlerts_TotalWorkflowcount")%></span> 
                                                                            &nbsp;</td><td><asp:DropDownList ID="ddlWorkflowCount" runat="server" CssClass="inputselect" >
                                                                                <asp:ListItem Value="="></asp:ListItem>
                                                                                <asp:ListItem Value=">"></asp:ListItem>
                                                                                <asp:ListItem Value="&gte"></asp:ListItem>
                                                                                <asp:ListItem Value="<"></asp:ListItem>                                                                                
                                                                                <asp:ListItem Value="&lte"></asp:ListItem>                                                                                
                                                                                <asp:ListItem Value="&ltg"></asp:ListItem>
                                                                            </asp:DropDownList></td>
                                                                           <td> <span class="description"> <%=GR.GetString("BAMAlerts_Thresholdcount")%></span>
                                                                            &nbsp;<asp:LinkButton ID="lblTotalCount" CssClass="LabelBlue" runat="server" OnClientClick="GoToOverdueConfig();" ></asp:LinkButton></td>

                                                                    </tr>
                                                                    <tr>
                                                                        <td>                                                                            
                                                                            <input type="checkbox" id="chkSlotCount" runat="server" />
                                                                            <span class="description"> <%=GR.GetString("BAMAlerts_Totalinslot")%></span>
                                                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td><asp:DropDownList ID="ddlSlotCount" runat="server" CssClass="inputselect">
                                                                                <asp:ListItem Value="="></asp:ListItem>                                                                                
                                                                                <asp:ListItem Value=">"></asp:ListItem>
                                                                                <asp:ListItem Value="&gte"></asp:ListItem>
                                                                                <asp:ListItem Value="<"></asp:ListItem>
                                                                                <asp:ListItem Value="&lte"></asp:ListItem>                                                                                
                                                                                <asp:ListItem Value="&ltg"></asp:ListItem>
                                                                            </asp:DropDownList></td><td td align="right" style="padding-right:25px;">
                                                                            <%=GR.GetString("BAMAlerts_Thresholdcount")%>
                                                                            &nbsp;<input type="button" id="btnSelectSlots" value="<%=GR.GetString("BAMAlerts_SelectSlots")%>"
                                                                                onclick="Javascript:return OpenSlots();" class="inputbutton" /></td>
                                                                    </tr>
                                                                   
                                                                <tr>
                                                                        <td colspan="2">             <%=GR.GetString("BAMAlerts_KPIHeader")%><br />                                                                                                                                     
                                                                         <span class="description"> <%=GR.GetString("BAMAlerts_KpiRule")%></span>
                                                                        </td>
                                                                    </tr>
                                                                   
                                                                    <tr>
                                                                        <td style="height: 24px">   
                                                                                                                                               
                                                                            <input type="checkbox" id="chkKPICount" runat="server" />
                                                                            <span class="description"> <%=GR.GetString("BAMAlerts_Kpis")%></span>
                                                                            </td>
                                                                        <td><asp:DropDownList ID="ddlKPICount" runat="server" CssClass="inputselect">
                                                                                <asp:ListItem Value="="></asp:ListItem>
                                                                            <asp:ListItem Value=">"></asp:ListItem>    
                                                                            <asp:ListItem Value="&gte"></asp:ListItem>
                                                                            <asp:ListItem Value="<"></asp:ListItem>                                                                                
                                                                                <asp:ListItem Value="&lte"></asp:ListItem>                                                                                
                                                                                <asp:ListItem Value="&ltg"></asp:ListItem>
                                                                            </asp:DropDownList></td><td align="right" style="padding-right:25px;">
                                                                            <span class="description"> <%=GR.GetString("BAMAlerts_Thresholdcount")%></span>
                                                                            &nbsp;<input type="button" id="Button1" value="<%=GR.GetString("BAMAlerts_SelectKPIs")%>"
                                                                                onclick="Javascript:return OpenKPIs();" class="inputbutton" /></td>
                                                                    </tr>
                                                                </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div id="divTime" runat="server" style="display: none; height: 200px; width: 100%">
                                                <table width="100%" style="height: 100%" cellpadding="2" cellspacing="2">
                                                    <tr>
                                                        <td align="center" valign="top">                                                            
                                                            <table width="100%" cellpadding="0" cellspacing="0" border="0" width="100%">                                                               
                                                                <tr>
                                                                    <td valign="top">     
                                                                        <table width="90%" cellspacing="1" cellpadding="1" border="0" align="center">
                                                                            <tr class="">
                                                                                <td class="description" width="25%"  valign="top"> 
                                                                                    <input type="radio" id="rblAlarmSettings4" name="rblAlarmSettings" value="On Every"
                                                                                        onclick="Javascript:return OnLoad();" runat="server" class="inputradio" />
                                                                                    <span class="description"><%=GR.GetString("BAMAlerts_OnEvery")%></span>
                                                                                </td>
                                                                                <td class="description" width="25%">
                                                                                    <input type="radio" id="rblAlarmSettings1" name="rblAlarmSettings" value="OnlyOn"
                                                                                        onclick="Javascript:return OnLoad();" runat="server" class="inputradio" /><span class="description"><%=GR.GetString("BAMAlerts_Onlyon")%></span>
                                                                                </td>
                                                                                <td class="description" width="25%">
                                                                                    <input type="radio" id="rblAlarmSettings2" name="rblAlarmSettings" value="AlltheTime"
                                                                                        onclick="Javascript:return OnLoad();" runat="server" class="inputradio" /><span class="description"><%=GR.GetString("BAMAlerts_AlltheTime")%></span>
                                                                                </td>
                                                                                <td class="description" width="25%">
                                                                                    <input type="radio" id="rblAlarmSettings3" name="rblAlarmSettings" value="None" onclick="Javascript:return OnLoad();"
                                                                                        runat="server" class="inputradio" /><span class="description"><%=GR.GetString("BAMAlerts_None")%></span>
                                                                                </td>
                                                                            </tr>
                                                                            <tr align="center">
                                                                                <td colspan="4"  align="center" valign="top">
                                                                                    <table>
                                                                                        <tr>
                                                                                            <td>
                                                                                                &nbsp;
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td align="center">
                                                                                                <div id="divCal" runat="server" style="display: block;">
                                                                                                    <table>
                                                                                                        <tr>
                                                                                                            <td>
                                                                                                               <span class="description"> <%=GR.GetString("BAMAlerts_Start")%>
                                                                                                                :</span>
                                                                                                            </td>
                                                                                                            <td>
                                                                                                                <telerik:RadDatePicker   ID="TxtStartDate"  RenderMode="Classic" runat="server" Width="125px" EnableEmbeddedSkins="false"  Skin="AWTCalendar">
                                                                                                                    <dateinput skin="AWTInput" buttonsposition="Left">
                                                                                                                    </dateinput>
                                                                                                                    <Calendar runat="server" skin="AWTCalendar">                                                                                                                       
                                                                                                                    </Calendar>              
                                                                                                                </telerik:RadDatePicker>
                                                                                                             </td>
                                                                                                            <td><span class="description">
                                                                                                                &nbsp;&nbsp;&nbsp;<%=GR.GetString("BAMAlerts_End")%>
                                                                                                                :</span>
                                                                                                            </td>
                                                                                                            <td>
                                                                                                                <telerik:RadDatePicker   ID="TxtEndDate"  RenderMode="Classic" runat="server" Width="125px" EnableEmbeddedSkins="false"  Skin="AWTCalendar">
                                                                                                                    <dateinput skin="AWTInput" buttonsposition="Left">
                                                                                                                    </dateinput>
                                                                                                                    <Calendar runat="server" skin="AWTCalendar">                                                                                                                       
                                                                                                                    </Calendar>              
                                                                                                                </telerik:RadDatePicker>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </div>
                                                                                                <div id="divDescNone" runat="server" style="display: none;">
                                                                                                    <table>
                                                                                                        <tr>
                                                                                                            <td>
                                                                                                              <span class="description"><%=GR.GetString("BAMAlerts_DescNone")%></span>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </div>
                                                                                                <div id="divDescAlltheTime" runat="server" style="display: none;">
                                                                                                    <table>
                                                                                                        <tr>
                                                                                                            <td>
                                                                                                               <span class="description"> <%=GR.GetString("BAMAlerts_DescAlltheTime")%></span>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </div>
                                                                                                <div id="divDescDateRange" runat="server" style="display: none;">
                                                                                                    <table>
                                                                                                        <tr align="center">
                                                                                                            <td>
                                                                                                               <span class="description">  <%=GR.GetString("BAMAlerts_DescDateRange")%></span>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </div>
                                                                                                <div id="divDescOnEvery" runat="server" style="display: none;">
                                                                                                    <table>
                                                                                                        <tr align="left">
                                                                                                            <td align="left">
                                                                                                                <input type="radio" id="rbnOnDayN" name="rblOnEveryDetailled" runat="server" checked="true"  class="inputradio" />
                                                                                                               <span class="description"> <%=GR.GetString("BAMAlerts_OnDesc")%></span>
                                                                                                                <asp:TextBox ID="txtOnEvery" MaxLength="2" runat="server" Width="35px" CssClass="inputtext" ></asp:TextBox>
                                                                                                                 <span class="description"> <%=GR.GetString("BAMAlerts_OfEveryMonth")%></span>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                        <tr>
                                                                                                            <td align="left">
                                                                                                                <input type="radio" id="rbnOnDayW" name="rblOnEveryDetailled" runat="server" class="inputradio" />
                                                                                                                <span class="description"> <%=GR.GetString("BAMAlerts_OnDesc")%></span>
                                                                                                                <span class="description"> <%=GR.GetString("BAMAlerts_WeekDays")%></span> <input type="button" value="<%=GR.GetString("Schedule_SelectWeekDay")%>" onclick="Javascript:return OpenWeekDaysWindow();"
                                                                                                                    id="buttonMonths" class="inputbutton" />
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                        <tr>
                                                                                                            <td>
                                                                                                                &nbsp;
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                        <tr>
                                                                                                            <td align="center">
                                                                                                              <span class="description"> <%=GR.GetString("BAMAlerts_DescEveryMonth")%></span> 
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </div>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <input type="hidden" id="hidWeekDays" value="1" runat="server" />
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
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div id="divAction" runat="server" style="display: none; height: auto; width: 100%;overflow:hidden;">
                                                <table width="100%" style="height: 100%" cellpadding="2" cellspacing="2" border="0">
                                                    <tr>
                                                        <td align="center" valign="top">                                                            
                                                            <table width="100%" cellpadding="0" cellspacing="0" border="0" style="height: 100%;
                                                                width: 100%">
                                                                <tr>
                                                                    <td >
                                                                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                                                            <tr>
                                                                                <td style=""> 
                                                                                                                                                                 
                                                                                    <input type="checkbox" id="chkSendAnEmail" runat="server" onclick="Javascript:return EnableAttachment();" />
                                                                                    
                                                                                  <span class="description"><%=GR.GetString("BAMAlerts_SendEmail")%></span>  
                                                                                    &nbsp;
                                                                                    <asp:TextBox ID="txtEmail" runat="server" CssClass="inputtext" Width="300px"></asp:TextBox>
                                                                                    &nbsp;
                                                                                     </td>
                                                                                <td style="padding-right:35px;">
                                                                                    <input type="button" id="btnSendEmail" value="Select Emails" onclick="Javascript:return OpenEmail();"
                                                                                        runat="server" class="inputbutton" /></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td colspan="1">
                                                                                    <span class="description"> <%=GR.GetString("BAMAlerts_EmailDesc")%></span>
                                                                                </td>
                                                                            </tr>          
                                                                            <tr>
                                                                                <td style="height: 25px" colspan="1">
                                                                                    
                                                                                    <input type="checkbox" id="chkChart" runat="server" />
                                                                                    <span class="description"> <%=GR.GetString("BAMAlerts_Sendthechart")%></span> </td>
                                                                            </tr>
                                                                           
                                                                            <tr>
                                                                                <td>
                                                                                    <span class="description"><%=GR.GetString("BAMAlerts_YourMessageHere")%></span>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="width:90%" colspan="1">
                                                                                    <table style="width:98%">
                                                                                        <tr>                                                                                            
                                                                                            <td style="width:98%; height:120px; max-height: 120px">
                                                                                                
                                                                                                <telerik:RadEditor ID="EditorEmailMessage" Height="100%" Width="400" runat="server"
                                                                                                    Editable="true" EnableDocking="false" ShowHtmlMode="false" Skin="SkeltaEditor" ShowPreviewMode="false"
                                                                                                    SaveInFile="false" ShowSubmitCancelButtons="false" EnableEmbeddedSkins="false" EditModes="Design"
                                                                                                    ToolsFile="<%$ReplaceTemplateExpn:Dashboard/ToolsFile.xml%>" EnableContextMenus="false" OnClientLoad="OnClientLoad" DialogsCssFile="<%$ReplaceTemplateExpn:TelerikAjax/StyleSheet/SkeltaEditor/DialogCSS.css%>" >
                                                                                                </telerik:RadEditor>
                                                                                                    
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
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
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height:90px;">
                        <td style="width: 94%;padding-bottom:19px;" >
                            
                                        <input type="hidden" id="hidWorkflows" name="hidWorkflows" runat="server" />
                                        <input type="hidden" id="hidSlots" name="hidSlots" runat="server" />
                                   
                                        <input type="hidden" id="hidEmails" name="hidEmails" runat="server" />
                                        <input type="hidden" id="hidKpis" name="hidEmails" runat="server" />
                            <div style="">
                                <span class="note notepaddingleft">
                                    <%=GR.GetString("BAMAlerts_Description1")%></span>
                                <input type="button" class="inputsecondarybutton" value="<%=GR.GetString("Cancel")%>" name="btncancel"
                                       onclick="Check();" id="Button3">
                                <asp:Button ID="btnSave" runat="server" CssClass="inputbutton" Text="Save"
                                            OnClientClick="return ValidateInput();" />                                      
                                </div>            
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>
<div id="divSlot" runat="server" style="display: none;" >
    <table border="0" width="100%" class="lefttdbg" align="center" cellpadding="0"
        cellspacing="0" id="Table7">
        <tr>
            <td align="center">
                <table border="0" width="100%" align="center" cellpadding="4" cellspacing="0" id="Table8" class="fieldset">
                    <tr>
                        <td class="ListHeaderCss" align='left' >
                         <span class="subtitle">  <%=GR.GetString("BAMAlerts_SelectSlot")%></span> 
                        </td>
                        <td class="ListHeaderCss" align='right'>
                            <a onclick="javascript:CloseDivSlot()">
                                <img src="<%=imagePath%>/close.gif" width="17" height="17"
                                    border="0" onclick="CloseDivSlot();"></a></td>
                    </tr>
                    <tr>
                        <td colspan="2" width="100%">
                            <div style="overflow: auto; height: 264px;">
                                <table width="100%" border="0">
                                    <tr>
                                        <td colspan="2" class="tableheaderbg">
                                       <span class="subtitle"><%=GR.GetString("BAMAlerts_Slot")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=GR.GetString("BAMAlerts_Period")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=GR.GetString("BAMAlerts_Threshold")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=GR.GetString("BAMAlerts_ThresholdType")%></span> 
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%">
                                            <asp:CheckBoxList ID="chkSlotsBindData" runat="server" CssClass="inputcheckbox" >
                                            </asp:CheckBoxList>
                                        </td>
                                        <td style="width: 80%;">
                                            <div id="divSlotDescription" runat="server" style="width: 100%">
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" width="100%" >
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td id="Td1" align="left">
                                        &nbsp;
                                    </td>
                                    <td  id="Td3" align="right">
                                        <input type="button" id="btnCancelSlots" name="btnCancel" value="Cancel" onclick="javascript:CloseDivSlot();"
                                            class="inputsecondarybutton" runat="server" />&nbsp;
                                        <asp:Button ID="btnOkSlots" Text="OK" runat="server" CssClass="inputbutton" />
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
<div id="divKPI" runat="server" style="display: none;" >
    <table border="0" width="100%" class="lefttdbg" align="center" cellpadding="0"
        cellspacing="0" id="Table5">
        <tr>
            <td align="center">
                <table border="0" width="100%" align="center" cellpadding="4" cellspacing="0" id="Table6" class="fieldset">
                    <tr>
                        <td align='left' class="ListHeaderCss">
                       <span class="subtitle"><%=GR.GetString("BAMAlerts_SelectKPI")%></span>  
                        </td>
                        <td class="ListHeaderCss" align='right'>
                            <a onclick="javascript:CloseDivEmail()">
                                <img src="<%=imagePath%>/close.gif" width="17" height="17"
                                    border="0" onclick="CloseDivKPI();"></a></td>
                    </tr>
                    <tr>
                        <td colspan="2" width="100%">
                            <div style="overflow: auto; height: 180px;">
                                <asp:CheckBoxList ID="chkKPIBindData" runat="server" RepeatColumns="2" Width="100%"  CssClass="inputcheckbox">
                                </asp:CheckBoxList></div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" width="100%" >
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td  id="Td8" align="left">
                                        &nbsp;
                                    </td>
                                    <td  id="Td9" align="right">
                                       
                                        <input type="button" id="btnCancelKPI" name="btnCancel" value="Cancel" onclick="javascript:CloseDivKPI();"
                                            class="inputsecondarybutton" runat="server" />&nbsp;
                                         <asp:Button ID="btnOkKPI" Text="OK"   runat="server" CssClass="inputbutton" />
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
<div id="divEmail" runat="server" style="display: none;"  >
    <table border="0" width="100%" class="tdbg" align="center" cellpadding="3" cellspacing="0" 
        id="Table1">
        <tr>
            <td>
                <asp:Panel ID="PnlUserLookup" runat="server" CssClass="fieldset">
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td align="right" valign="middle">
                <input type="button" id="btnCancelEmail" name="btnCancel" value="Cancel" onclick="javascript: CloseDivEmail();"
                    class="inputsecondarybutton" runat="server" />
                 <asp:Button ID="btnSelectEmail" runat="server" CssClass="inputbutton" />
               
            </td>
        </tr>
    </table>
</div>
<div id="PropertyDiv" style="display: none" runat="server" />
<iframe width="0" scrolling="no" height="0" style="display:none;" frameborder="0" id="iframetop" runat="server">
</iframe>

<script language="javascript">    

        function GoToOverdueConfig()
        {
            GotoPage("overdueconfig.aspx");       
        }
        
        function GotoPage(url)
        {
            var l=window.location.toString();
            l=l.replace("AlertManager.aspx",url);                          
            window.parent.window.document.getElementById("framecontent").src = l;                
        }
        
                 
        function ToggleDiv(object)
        {
           
            var divRule = document.getElementById("<%=divRule.ClientID%>");    
            var divTime = document.getElementById("<%=divTime.ClientID%>");    
            var divAction = document.getElementById("<%=divAction.ClientID%>");         
            
            var tdRuleRef = document.getElementById("btnRule");   
            var tdTimeRef = document.getElementById("btnTime");                    
            var tdActionRef = document.getElementById("btnAction");          
            
            var imgStep1 = document.getElementById("fontStep1");      
            var imgStep2 = document.getElementById("fontStep2");      
            var imgStep3 = document.getElementById("fontStep3");    
            
            var iconmain = document.getElementById("<%=iconmain.ClientID%>"); 
            var lblStepDescription = document.getElementById("<%=lblStepDescription.ClientID%>"); 
            
            var TaskDetails = document.getElementById("<%=TaskDetails.ClientID%>");
            
            //Get All Other Divs and Close it            
            var divSlot =document.getElementById("<%=divSlot.ClientID%>");                  
            var divKpi = document.getElementById("<%=divKPI.ClientID%>");        
            var divEmail = document.getElementById("<%=divEmail.ClientID%>");        
            var divTimeSelected = document.getElementById("<%=PropertyDiv.ClientID%>");        
            var iframetop = document.getElementById("<%=iframetop.ClientID%>"); 
            
            divSlot.style.display = "none";
            divKpi.style.display = "none";
            divEmail.style.display = "none";
            divTimeSelected.style.display = "none";
            iframetop.style.display = "none";            
         
            if(object == "rule")
            {
                divRule.style.display = "block";
                divTime.style.display = "none";
                divAction.style.display = "none";
                
                tdRuleRef.className = "inputbutton";
                tdTimeRef.className = "inputbuttondisabled";
                tdActionRef.className = "inputbuttondisabled";
                
                imgStep1.className = "MainPageTitle";
                imgStep2.className = "MainPageTitleDisabled";
                imgStep3.className = "MainPageTitleDisabled";
                
                iconmain.src = "<%=imagePath%>"+'/icon-rule.png';
                lblStepDescription.innerHTML = '<%=GR.GetString("BAMAlerts_AlarmRules")%>';
                TaskDetails.innerHTML =  '<%=GR.GetString("BAMAlerts_Description")%>';
            } 
            else if(object == "time")
            {
                divRule.style.display = "none";
                divTime.style.display = "block";
                divAction.style.display = "none";   
                
                tdRuleRef.className = "inputbuttondisabled";
                tdTimeRef.className = "inputbutton";
                tdActionRef.className = "inputbuttondisabled";
                
                
                imgStep1.className = "MainPageTitleDisabled";
                imgStep2.className = "MainPageTitle";
                imgStep3.className = "MainPageTitleDisabled";
                
                iconmain.src = "<%=imagePath%>"+'/icon-time.png';
                lblStepDescription.innerHTML = '<%=GR.GetString("BAMAlerts_AlarmSettings")%>';
                TaskDetails.innerHTML = '<%=GR.GetString("BAMAlerts_DescriptionTime")%>';
                
                //Changes for Holding the State
                rblAlarmSettings4 = document.getElementById("<%=rblAlarmSettings4.ClientID%>");
                rblAlarmSettings1 = document.getElementById("<%=rblAlarmSettings1.ClientID%>");
                rblAlarmSettings2 = document.getElementById("<%=rblAlarmSettings2.ClientID%>");
                rblAlarmSettings3 = document.getElementById("<%=rblAlarmSettings3.ClientID%>");
                
                divDescOnEvery = document.getElementById("<%=divDescOnEvery.ClientID%>");
                divDescDateRange = document.getElementById("<%=divDescDateRange.ClientID%>");
                divCal = document.getElementById("<%=divCal.ClientID%>");
                divDescAlltheTime = document.getElementById("<%=divDescAlltheTime.ClientID%>");
                divDescNone = document.getElementById("<%=divDescNone.ClientID%>");     
                
                if(rblAlarmSettings4.checked == true)          
                {
                    divDescOnEvery.style.display = "block";
                    divDescDateRange.style.display = "block";   
                    divCal.style.display = "none";     
                    divDescAlltheTime.style.display = "none";
                    divDescNone.style.display = "none";                
                }
                if(rblAlarmSettings1.checked == true)
                {
                    divDescOnEvery.style.display = "none";
                    divDescDateRange.style.display = "none";   
                    divCal.style.display = "block";     
                    divDescAlltheTime.style.display = "none";
                    divDescNone.style.display = "none";    
                
                }
                
                if(rblAlarmSettings2.checked == true)
                {
                    divDescOnEvery.style.display = "none";
                    divDescDateRange.style.display = "none";   
                    divCal.style.display = "none";     
                    divDescAlltheTime.style.display = "block";
                    divDescNone.style.display = "none";  
                }
                
                if(rblAlarmSettings3.checked == true)
                {
                    divDescOnEvery.style.display = "none";
                    divDescDateRange.style.display = "none";   
                    divCal.style.display = "none";     
                    divDescAlltheTime.style.display = "none";
                    divDescNone.style.display = "block";                 
                }
                
            }
            else if(object == "action")
            {
                divRule.style.display = "none";
                divTime.style.display = "none";
                divAction.style.display = "block";
                
                tdRuleRef.className = "inputbuttondisabled";
                tdTimeRef.className = "inputbuttondisabled";
                tdActionRef.className = "inputbutton";
                
                imgStep1.className = "MainPageTitleDisabled";
                imgStep2.className = "MainPageTitleDisabled";
                imgStep3.className = "MainPageTitle";
                
                iconmain.src = "<%=imagePath%>"+'/icon-action.png';
                lblStepDescription.innerHTML = '<%=GR.GetString("BAMAlerts_ActionSettings")%>';
                TaskDetails.innerHTML = '<%=GR.GetString("BAMAlerts_DescriptionAction")%>';                 
            }          
        }     
        function OnLoad()        
        {       
            var rblAlarmSettings1 = document.getElementById("<%=rblAlarmSettings1.ClientID%>");     
            var rblAlarmSettings2 = document.getElementById("<%=rblAlarmSettings2.ClientID%>");          
            var rblAlarmSettings3 = document.getElementById("<%=rblAlarmSettings3.ClientID%>"); 
            var divDescNone = document.getElementById("<%=divDescNone.ClientID%>")
            var divDescAlltheTime = document.getElementById("<%=divDescAlltheTime.ClientID%>")
            var divDescDateRange = document.getElementById("<%=divDescDateRange.ClientID%>")
            var TxtStartDate = document.getElementById('<%=divCal.ClientID%>');      
            
            var divDescOnEvery = document.getElementById("<%=divDescOnEvery.ClientID%>");
            var rblAlarmSettings4 = document.getElementById("<%=rblAlarmSettings4.ClientID%>"); 
           
            if(rblAlarmSettings1.checked)         
            {   
                TxtStartDate.style.display="block";
                divDescAlltheTime.style.display="none";
                divDescNone.style.display="none";
                divDescDateRange.style.display="block";
                divDescOnEvery.style.display="none";    
            }
            else
            {
                TxtStartDate.style.display="none";            
                if(rblAlarmSettings2.checked)
                {
                    divDescAlltheTime.style.display="block";
                    divDescNone.style.display="none";
                    divDescDateRange.style.display="none";           
                    divDescOnEvery.style.display="none";   
                }
                if(rblAlarmSettings3.checked)
                {
                    divDescAlltheTime.style.display="none";
                    divDescNone.style.display="block";
                    divDescDateRange.style.display="none";  
                    divDescOnEvery.style.display="none";                    
                }
                if(rblAlarmSettings4.checked)
                {
                    divDescAlltheTime.style.display="none";
                    divDescNone.style.display="none";
                    divDescDateRange.style.display="none";  
                    divDescOnEvery.style.display="block";                    
                }
            }
        }
            
        function OpenWorkflows()
        {                     
            CloseDivSlot();    
            CloseDivKPI();           
        }        
        
        function OpenEmail()
        {             
           CloseDivSlot();               
           CloseDivKPI();       
            OpenEmailsWindow('Add');        
        }  
        
        function OpenSlots()
        {                   
            CloseDivKPI();
            OpenSlotsWindow('Add');     
        }
        
        function OpenKPIs()
        {        
            CloseDivSlot();                     
            OpenKPIsWindow('Add');     
        }
        
        function OpenSlotsWindow(mode)
        { 
                
          var proprObj =document.getElementById("<%=divSlot.ClientID%>");                  
          proprObj.style.position="absolute";
          proprObj.style.visibility="visible";

          proprObj.style.display="block";  
          proprObj.style.left = 450 + 'px';
          proprObj.style.top = 100 + 'px';       
          proprObj.style.width = 450 +'px';
          
          var iframetop = document.getElementById("<%=iframetop.ClientID%>");
          iframetop.style.position="absolute";
          iframetop.style.display = 'block';
          iframetop.style.width = proprObj.offsetWidth;
          iframetop.style.height = proprObj.offsetHeight;
          iframetop.style.left = proprObj.offsetLeft;
          iframetop.style.top = proprObj.offsetTop;          
          proprObj.style.zIndex  =   iframetop.style.zIndex + 1;                               
        } 
        
        function OpenEmailsWindow(mode)
        {
       
          var proprObj =document.getElementById("<%=divEmail.ClientID%>");                  
          proprObj.style.position="absolute";
          proprObj.style.visibility="visible";

          proprObj.style.display="block";  
          proprObj.style.left = 400 + 'px';
          proprObj.style.top = 100 + 'px';       
          proprObj.style.width = 570 +'px';  
         
        }        
        
        function OpenKPIsWindow(mode)
        {
        
          var proprObj =document.getElementById("<%=divKPI.ClientID%>");                  
          proprObj.style.position="absolute";
          proprObj.style.visibility="visible";

          proprObj.style.display="block";  
          proprObj.style.left = 450 + 'px';
          proprObj.style.top = 100 + 'px';       
          proprObj.style.width = 450+'px';  
          
          var iframetop = document.getElementById("<%=iframetop.ClientID%>");
          iframetop.style.position="absolute";
          iframetop.style.display = 'block';
          iframetop.style.width = proprObj.offsetWidth;
          iframetop.style.height = proprObj.offsetHeight;
          iframetop.style.left = proprObj.offsetLeft;
          iframetop.style.top = proprObj.offsetTop;          
          proprObj.style.zIndex  =   iframetop.style.zIndex + 1;             
        }       
            
            function CloseDivSlot()
            {
               var divPropertyDiv=document.getElementById("<%=divSlot.ClientID%>");    
               divPropertyDiv.style.display="none";
               
               var iframetop = document.getElementById("<%=iframetop.ClientID%>");         
               iframetop.style.display = 'none';
            }        
            
            function CloseDivKPI()
            {
                var divPropertyDiv=document.getElementById("<%=divKPI.ClientID%>");    
                divPropertyDiv.style.display="none";   
                
                var iframetop = document.getElementById("<%=iframetop.ClientID%>");         
                iframetop.style.display = 'none';  
            }
            
            function CloseDivEmail()
            {      
                var divPropertyDiv=document.getElementById("<%=divEmail.ClientID%>"); 
                //To avoid retaining values
                document.getElementById("AlertManager_IdUserLookUp_ctl00_txtName").value=""; 
                document.getElementById("AlertManager_IdUserLookUp_ctl00_lstselres").innerHTML="";
                document.getElementById("AlertManager_IdUserLookUp_ctl00_lstselectedres").innerHTML="";                          
                divPropertyDiv.style.display="none";     
            }           
                 
            function ValidateInput()
            {               
                //Valdate Slots
                var SlotCount = document.getElementById("<%=chkSlotCount.ClientID%>");  
                var SlotEmails = document.getElementById("<%=chkSendAnEmail.ClientID%>");  
                var SlotKpis = document.getElementById("<%=chkKPICount.ClientID%>"); 
                var TextEmail = document.getElementById("<%=txtEmail.ClientID%>"); 
                
                var hiddenSlots = document.getElementById("<%=hidSlots.ClientID%>");                
                var hiddenEmails = document.getElementById("<%=hidEmails.ClientID%>");                
                var hiddenKpis = document.getElementById("<%=hidKpis.ClientID%>"); 
                
                var rblAlarmSettings = document.getElementById("<%=rblAlarmSettings1.ClientID%>");             
                
                var rblAlarmSettings4 = document.getElementById("<%=rblAlarmSettings4.ClientID%>");
                var txtOnEvery = document.getElementById("<%=txtOnEvery.ClientID%>");
                             
                var TxtStartDate = document.getElementById('<%=TxtStartDate.ClientID%>'); 
                var TxtEndDate = document.getElementById('<%=TxtEndDate.ClientID%>');
            
                var divRule = document.getElementById("<%=divRule.ClientID%>");    
                var divTime = document.getElementById("<%=divTime.ClientID%>");    
                var divAction = document.getElementById("<%=divAction.ClientID%>");  
                
                var rbnOnDayN = document.getElementById("<%=rbnOnDayN.ClientID%>");  
                var rbnOnDayW = document.getElementById("<%=rbnOnDayW.ClientID%>");  
                var hidWeekDays = document.getElementById("<%=hidWeekDays.ClientID%>");  
            
                if(SlotCount.checked)
                {
                    if(hiddenSlots.value == "")
                    {
                        ToggleDiv('rule');               
                       // alert('<%=GR.GetString("BAMAlerts_SlotValidation")%>');   
                        se.ui.messageDialog.showError("<%=GR.GetString("Alert")%>", "<%=GR.GetString("BAMAlerts_SlotValidation")%>");
                        return false;
                    }            
                }
                
                if(SlotKpis.checked)
                {
                    if(hiddenKpis.value == "")
                    {
                        ToggleDiv('rule');                    
                       // alert('<%=GR.GetString("BAMAlerts_KpiSlotValidation")%>');
                        se.ui.messageDialog.showError("<%=GR.GetString("Alert")%>", "<%=GR.GetString("BAMAlerts_KpiSlotValidation")%>");
                        return false;                    
                    }         
                }    
                
                if(rblAlarmSettings4.checked)            
                {
                    if(rbnOnDayN.checked)
                    {
                        if(txtOnEvery.value == "")
                        {
                            ToggleDiv('time');    
                          //  alert('<%=GR.GetString("BAMAlerts_OnEveryValidation")%>');
                            se.ui.messageDialog.showError("<%=GR.GetString("Alert")%>", "<%=GR.GetString("BAMAlerts_OnEveryValidation")%>");
                            return false;                    
                        }      
                        
                        if(!IsNumeric(txtOnEvery.value))
                        {
                            ToggleDiv('time');    
                            txtOnEvery.focus();
                           // alert('<%=GR.GetString("BAMAlerts_OnEveryNumericValidation")%>'); 
                            se.ui.messageDialog.showError("<%=GR.GetString("Alert")%>", "<%=GR.GetString("BAMAlerts_OnEveryNumericValidation")%>");
                            return false;                           
                        }    
                    }
                    else if(rbnOnDayW.checked)
                    {
                        if(hidWeekDays.value == "")
                        {
                            ToggleDiv('time');    
                          //  alert('<%=GR.GetString("BAMAlerts_PleaseSelectWeekDay")%>');
                            se.ui.messageDialog.showError("<%=GR.GetString("Alert")%>", "<%=GR.GetString("BAMAlerts_PleaseSelectWeekDay")%>");
                            return false;                                
                        }                    
                    }                
                }               
              
                if(rblAlarmSettings.checked)            
                {
                    if(TxtStartDate.value == "" && TxtEndDate.value == "")
                    {
                        ToggleDiv('time');    
                      //  alert('<%=GR.GetString("BAMAlerts_DateValidation")%>');
                        se.ui.messageDialog.showError("<%=GR.GetString("Alert")%>", "<%=GR.GetString("BAMAlerts_DateValidation")%>");
                        return false;                    
                    }
                    
                    if(!CompareDates())
                    {
                        ToggleDiv('time');    
                       // alert('<%=GR.GetString("BAMAlerts_DateCompare")%>');
                        se.ui.messageDialog.showError("<%=GR.GetString("Alert")%>", "<%=GR.GetString("BAMAlerts_DateCompare")%>");
                        return false;                    
                    }
                }        
                
                if(SlotEmails.checked)
                {
                    if (hiddenEmails.value == "" && TextEmail.value == "")
                    {
                        ToggleDiv('action');                
                       // alert('<%=GR.GetString("BAMAlerts_EmailValidation")%>');
                        se.ui.messageDialog.showError("<%=GR.GetString("Alert")%>", "<%=GR.GetString("BAMAlerts_EmailValidation")%>");
                        return false;
                    }   
                    if(!isValidEmail())
                    {
                        ToggleDiv('action');                            
                       // alert('<%=GR.GetString("BAMAlerts_InvalidEmail")%>'); 
                        se.ui.messageDialog.showError("<%=GR.GetString("Alert")%>", "<%=GR.GetString("BAMAlerts_InvalidEmail")%>");
                        return false;          
                    }                
                }                         
                            
                return true;
            }             
            
            function isValidEmail()
            {       
                var emails = document.getElementById("<%=txtEmail.ClientID%>");   
                var strEmails = emails.value;
                var arrEmails = new Array();
                arrEmails = strEmails.split(';');
                
                for(var i=0; i< arrEmails.length; i++)
                {                          
                    if(!validateEmail(arrEmails[i].toString().replace(/^\s+/, "").replace(/\s+$/, ""))) 
                        return false;                        
                }
                return true;
            }
            
            function CompareDates()
            {       
                var FromDate = document.getElementById("<%=TxtStartDate.ClientID%>");
                var ToDate = document.getElementById("<%=TxtEndDate.ClientID%>");
                
                if(FromDate.value != "" && ToDate.value != "")
                {
                    if(FromDate.value > ToDate.value)   
                    {
                        return false;                    
                    }        
                }                
                return true;
            }            
            
            function validateEmail(strEmail) 
            { 
                var at="@"; 
                var dot="."; 
                var lat=strEmail.indexOf(at);
                var lstr=strEmail.length; 
                var ldot=strEmail.indexOf(dot);
                if (strEmail.indexOf(at)== -1)
                {                  
                   return false; 
                }

                if (strEmail.indexOf(at)==-1 || strEmail.indexOf(at)==0 || strEmail.indexOf(at)==lstr)
                {                  
                    return false; 
                } 
                if (strEmail.indexOf(dot)==-1 || strEmail.indexOf(dot)==0 || strEmail.indexOf(dot)==lstr)
                {                    
                    return false;
                } 
                if (strEmail.indexOf(at,(lat+1))!=-1)
                {                    
                    return false;
                } 

               if (strEmail.substring(lat-1,lat)==dot || strEmail.substring(lat+1,lat+2)==dot)
               { 
                    return false; 
               } 
               if (strEmail.indexOf(dot,(lat+2))==-1)
               {                    
                    return false; 
               }
               if (strEmail.indexOf(" ")!=-1)
               {                
                 return false;
              }
            return true;
        }            
        
        function EnableAttachment()
        {          
            var chkSendMail = document.getElementById('<%=chkSendAnEmail.ClientID%>');
            var chkChart = document.getElementById('<%=chkChart.ClientID%>');

            chkChart.disabled = true;            
            if(chkSendMail.checked)            
            {
                chkChart.disabled = false;    
            }
        }         
        
        function IsNumeric(strString)      
        {
            var strValidChars = "0123456789";
            var strChar;
            var blnResult = true;

            if (strString.length == 0) return false;
            for (i = 0; i < strString.length && blnResult == true; i++)
            {
                strChar = strString.charAt(i);
                if (strValidChars.indexOf(strChar) == -1)
                {
                   return false;
                }
            }
            return true;
        }     
        
        function GetBrowserversion()
            {
                var app=navigator.userAgent;
                if(app.indexOf("MSIE")>-1)
                {
                      return 1;    
                }
                else if(app.indexOf("Firefox/1.5")>-1)
                {
                     return 2;     
                }
                else
                {
                    return 3;
                }
            }    
        
        function CheckAllDays()
            {  
                var ctrAll = document.getElementById("chkAll");   
                if(ctrAll.checked == true)
                {   
                    for(var i=1;i<8;i++)
                    {
                        var ctrl = document.getElementById("Day"+i);
                        ctrl.checked = true;
                    }
                }
                else
                {
                    for(var i=1;i<8;i++)
                    {
                        var ctrl = document.getElementById("Day"+i);
                        ctrl.checked = false;
                   }   
               }               
            }              
        
        function OpenWeekDaysWindow(mode)
        {            
                var DIR_IMAGES="<%=imagePath%>"+"/";
                var innerHTMl="";
                TopBgImgSrc = DIR_IMAGES+"top-bg.gif"
                var closeImg = DIR_IMAGES+"close.gif"               

                var nodtext="";
                var nodType="";
                var nodeDataType="";
                var IsRepeating="";
                var bcode = GetBrowserversion();
                if(mode=="Edit")
                {
                }        
                innerHTMl = "<table border=\"0\" width=\"100%\" class=inlineBordertyle align=\"center\" cellpadding=\"0\" cellspacing=\"0\" ID=\"Table7\">";
                    innerHTMl =innerHTMl+"<tr>";
                    innerHTMl =innerHTMl+"<td align=\"center\">";
                    innerHTMl =innerHTMl+"<table border=\"0\" width=\"100%\" align=\"center\" cellpadding=\"4\" cellspacing=\"0\" ID=\"Table8\">";
                    innerHTMl =innerHTMl+"<tr>";
                    innerHTMl =innerHTMl+"<td  class=\"header\" align='left'><%=GR.GetString("SchSelectWeekDay")%></td>";
                    innerHTMl =innerHTMl+"<td  class=\"header\" align='right'><a href=\"#\" onclick=\"javascript:CloseDiv()\"><img src="+closeImg+" width=\"17\" height=\"17\" border=0 onClick=\"CloseDiv();\"/></a>";
//                  innerHTMl =innerHTMl+"<td bgcolor=\"White\" class=\"header2\" align='right'>";
                    innerHTMl =innerHTMl+"</td>";
                    innerHTMl =innerHTMl+"</tr>";
                    
                    if(bcode==1)
                    {
                        innerHTMl =innerHTMl+" <tr>";
                        innerHTMl =innerHTMl+"<td class=\"description\" colspan=\"2\"><%=GR.GetString("BAMAlerts_PleaseSelectDay")%></td>";
                        innerHTMl =innerHTMl+"</tr>";
                    }
                 
                    var week = "<%=GR.GetString("SchMon")%>" + "," + "<%=GR.GetString("SchTue")%>" + "," + "<%=GR.GetString("SchWed")%>" + "," + "<%=GR.GetString("SchThu")%>" + "," + "<%=GR.GetString("SchFri")%>" + "," + "<%=GR.GetString("SchSat")%>" + "," + "<%=GR.GetString("SchSun")%>";
                    var splitWeekdays = week.split(",");
                    wkdays = document.getElementById("<%=hidWeekDays.ClientID%>").value;
                 
                    for(var i=0; i<splitWeekdays.length;i++) 
                    {
                        innerHTMl =innerHTMl+ "<tr>";
                        innerHTMl =innerHTMl+ "<td colspan=\"2\">";
                        innerHTMl = innerHTMl + "<table border=\"0\" width=\"90%\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" ID=\"Table9\">";
                        innerHTMl =innerHTMl+"<tr>";
                        innerHTMl =innerHTMl+"<td class=\"description\" align='Left' width=28%>";
                        innerHTMl =innerHTMl+""+splitWeekdays[i]+":";   
                        
                        innerHTMl =innerHTMl+"</td>";
                        innerHTMl =innerHTMl+"<td class=\"description\" width=22%>";
                        
                        var isSelectedday = GetSelectedWeekDays(i+1);
                        
                        if(isSelectedday)
                            innerHTMl =innerHTMl+"<input type=\"Checkbox\" value =\""+parseInt((parseInt(i) + 1))+"\" checked id=\"Day"+parseInt((parseInt(i) + 1))+"\"/>";
                        else
                            innerHTMl =innerHTMl+"<input type=\"Checkbox\" value =\""+parseInt((parseInt(i) + 1))+"\" id=\"Day"+parseInt((parseInt(i) + 1))+"\"/>";
                        
                        innerHTMl =innerHTMl+"</td>"; 
                        innerHTMl =innerHTMl+"<td class=\"description\" align='Left' width=28%>";
                       
                        i = i + 1;   
                        
                        if(i==7)
                            innerHTMl =innerHTMl+"&nbsp;";        
                        else
                           innerHTMl =innerHTMl+""+splitWeekdays[i]+":";                         

                       innerHTMl =innerHTMl+"</td>";                        
                       innerHTMl =innerHTMl+"<td class=\"description\" width=22%>";
                       
                        if(i==7)
                            innerHTMl =innerHTMl+"&nbsp;";        
                        else
                        {
                            isSelectedday = GetSelectedWeekDays(i+1);                        
                            if(isSelectedday)
                                innerHTMl =innerHTMl+"<input type=\"Checkbox\" value =\""+parseInt((parseInt(i) + 1))+"\" checked id=\"Day"+parseInt((parseInt(i) + 1))+"\"/>";
                            else
                                innerHTMl =innerHTMl+"<input type=\"Checkbox\" value =\""+parseInt((parseInt(i) + 1))+"\" id=\"Day"+parseInt((parseInt(i) + 1))+"\"/>";
                      
                        }
                        innerHTMl =innerHTMl+"</td>";                    
                        innerHTMl =innerHTMl+"</tr>"; 
                        innerHTMl =innerHTMl+"</table>";
                        innerHTMl =innerHTMl+"</td>"; 
                        innerHTMl =innerHTMl+"</tr>";
                    }
                    if(bcode==1)
                    {
                        innerHTMl =innerHTMl+" <tr>";
                        innerHTMl =innerHTMl+"<td colspan=\"2\"><img src=\"Images/Spacer.gif\" border=\"0\" height=\"8\"></td>";
                        innerHTMl =innerHTMl+"</tr>";
                    }  innerHTMl =innerHTMl+"<tr>";
                                 innerHTMl =innerHTMl+"<td colspan=3 width=100%  class=\"description\" >";
                                     innerHTMl =innerHTMl+"<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">";

                                       innerHTMl =innerHTMl+"<tr>";                                        
                                            innerHTMl =innerHTMl+"<td width=\"20%\" class=\"description\"  id=\"Td1\" align=\"left\">";                                      
                                                       innerHTMl =innerHTMl+"<input type=\"Checkbox\" value =\"All\" checked id=\"chkAll\" name=\"<%=GR.GetString("All")%>\"  onClick=\"javascript:CheckAllDays();\">All";
                                                       innerHTMl =innerHTMl+"</td>";    
                                        
                                              innerHTMl =innerHTMl+"<td width=\"70%\"   id=\"Td2\" align=\"right\">";                                      
                                              innerHTMl = innerHTMl + "<input type=\"button\" class=\"inputsecondarybutton\" id=\"btnCancel\" name=\"btnCancel\" value=\"<%=GR.GetString("SchCancelButton")%>\" onClick=\"CloseDiv();\" class=\"inputbutton\">&nbsp;";
                                                    innerHTMl =innerHTMl+"<input type=\"button\" class=\"inputbutton\" id=\"btnOk\" name=\"btnOK\" value=\"&nbsp;&nbsp;<%=GR.GetString("SchOKButton")%>&nbsp;&nbsp;\" onClick=\"javascript:UpdateSelectedDays();\" class=\"inputbutton\">&nbsp;";                                                            
                                                      
                                                      innerHTMl =innerHTMl+"</td>";    
                                                innerHTMl =innerHTMl+"</tr>";                                                 
                                            innerHTMl =innerHTMl+"</table>";
                            innerHTMl =innerHTMl+"</td>";    
                     innerHTMl =innerHTMl+"</tr>"; 
                     innerHTMl =innerHTMl+"</table>";
                    innerHTMl =innerHTMl+"</td>";    
                     innerHTMl =innerHTMl+"</tr>";
                    innerHTMl =innerHTMl+"</table>";
                     
                  var proprObj =document.getElementById("<%=PropertyDiv.ClientID%>");  
                  proprObj.innerHTML =  innerHTMl;

                 proprObj.style.position="absolute";
                 proprObj.style.visibility="visible";

                  proprObj.style.display="block";  
                  proprObj.style.left = 400 + 'px';
                  proprObj.style.top = 100 + 'px';       
                  proprObj.style.width=570+'px';            
            var ctrlAll = document.getElementById("chkAll");
            if (ctrlAll != null)
                  ctrlAll.checked = false;
           }
            
            function GetSelectedWeekDays(day)
            {
                var retflag=false;
                wkdays = document.getElementById("<%=hidWeekDays.ClientID%>").value;

                everyday  = wkdays.split(",");
                for(var i=0 ; i<everyday.length;i++)
                {
                    if(everyday[i]== day)
                    {
                        retflag=true;    
                        break;
                    }
                }
                return retflag;
            }
            
            function CloseDiv()
            {
               var divPropertyDiv=document.getElementById("<%=PropertyDiv.ClientID%>");    
               divPropertyDiv.style.display="none";
            }
            
            function UpdateSelectedDays()
            {                
                var selecteddays="";
                for(var i=1;i<8;i++)
                {
                    var ctrl = document.getElementById("Day"+i);
                    if(ctrl.checked)
                    {
                        if(selecteddays=="")
                            selecteddays = i;
                        else
                            selecteddays = selecteddays + ","+ i;
                    }
                }                

                document.getElementById("<%=hidWeekDays.ClientID%>").value = selecteddays;                
                var divPropertyDiv=document.getElementById("<%=PropertyDiv.ClientID%>");    
                divPropertyDiv.style.display="none";
            }
           
            function getWeekDaysString(days)
            {
                var ListOfdays = "Mon,Tue,Wed,Thu,Fri,Sat,Sun";
                var returnval = "";
                var eachday = days.split(",");
                var eacListOfDays = ListOfdays.split(",");
                 
                for(var i=0;i<eachday.length;i++)
                {
                    if(trim(returnval) == "")
                    {
                        returnval = eacListOfDays[parseInt(eachday[i])-1];
                    }
                    else
                    {
                        returnval = returnval + "," + eacListOfDays[parseInt(eachday[i])-1];
                    }
                }
                return returnval;
            }

            function OnClientLoad(editor, args) {
                if (navigator.userAgent.indexOf("Chrome") > -1) {
                    editor.setSize("530", "110");
                }
                else {
                    editor.setSize("530", "200");
                }
              
            }
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

