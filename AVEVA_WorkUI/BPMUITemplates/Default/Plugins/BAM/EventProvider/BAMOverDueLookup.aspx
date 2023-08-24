<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.Bam.BAMOverDueLookup" %>

<!DOCTYPE html>
<html>
<head runat="server" id="Head1">
    <title><%=GR.GetString("BAMAlerts_SelectSlot")%></title>
    <style>
        html, body, form
        {
            height: 100%;
        }
    </style>
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>
    <script type="text/javascript" language="javascript">       
        function GetRadWindow()
        {            
            var oWindow = null;
            oWindow = window.frameElement.radWindow;
            return oWindow;
        } 
        
        function setValues(id)
        {           
            var oWindow = GetRadWindow();
            if (typeof oWindow !== 'undefined' && oWindow.close) {
                oWindow.close(id);
            }          
        }
        
    </script>

</head>  

 <link rel="stylesheet" type="text/css" href="<%:cssPath %>Common/StyleSheet/Global.css" /> 
<body>
    <form id="form1" runat="server">  
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
    <link rel="stylesheet" type="text/css" href="<%:cssPath%>CommonUXControls/StyleSheet/se.ui.min.css" />
     <script>
         // Initialize locales for message dialog
         se.ui.messageDialog.setGlobalOptions({
             localization: { // All localization related default can be set
                 closeButtonCaption: "<%=GR.GetString("se_ui_messagedialog_close_caption") %>", // "Close" is the default value
                 okButtonCaption: "<%=GR.GetString("se_ui_messagedialog_ok_caption") %>", // "OK" is the default value
                 cancelButtonCaption: "<%=GR.GetString("se_ui_messagedialog_cancel_caption") %>", // "Cancel" is the default value
                 showDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_showdetails_caption") %>", // "Show Details" is the default value
                 hideDetailsCaption: "<%=GR.GetString("se_ui_messagedialog_hidedetails_caption") %>" // "Hide Details" is the default value
             }
         });
     </script>
        
        <table style="width:100%;border-spacing:1px;border-collapse:separate;" class="lefttdbg" >
                  <tr>                                
                    <td style="width: 30%;padding:1px;" class="tableheaderbg">
                        <%=GR.GetString("BAMAlerts_Slot")%>
                    </td>
                    <td style="width: 25%;padding:1px;" class="tableheaderbg">
                        <%=GR.GetString("BAMAlerts_Period")%>
                    </td>
                    <td style="width: 25%;padding:1px;" class="tableheaderbg">
                        <%=GR.GetString("BAMAlerts_Event")%>
                    </td>
                    <td style="width: 20%;padding:1px;" class="tableheaderbg">
                        <%=GR.GetString("BAMAlerts_Threshold")%>
                    </td>
                  </tr>
                    <tr>
                        <td style="padding:1px;" >
                            <div id="divSlotDescription" runat="server">
                            </div>
                        </td>
                    </tr>
               
          
            <tr>
                <td  id="Td6" style="text-align:right;height:30px;padding-top:220px;" colspan="4">
                    <input type="button" id="btnSelectSlots" name="btnSelect" value="Select" onclick="javascript:SelectSlots();"
                        class="inputbutton"  runat="server" />
                </td>
            </tr>
        </table>
    </form>
</body>
</html>

<script language="javascript" type ="text/javascript" >
 
 function SelectSlots()
 {
    var rblSlots = document.getElementsByName("Slots");
    var idSlot = '';
    var idEvent = '';
    var retId = '';
    
    var input = ValidateInput();
    if(input)
    {
        for(i=0; i < rblSlots.length; i++)
        {
            if(rblSlots[i].checked == true)
            {
                idSlot = rblSlots[i].value;               
                var ddlEvent = document.getElementById("ddl" + idSlot);
                if(ddlEvent != null)
                {
                    idEvent = ddlEvent.value;
                } 
                break;       
            }
        }
        retId = idSlot + "&" + idEvent;        
        setValues(retId);
    }  
 }
 
 function ValidateInput()
 {
    slotcount=0;    
    var rblSlots = document.getElementsByName("Slots");
    for(i=0; i < rblSlots.length; i++)
    {
        if(rblSlots[i].checked == true)
        {
           slotcount++;
           break;       
        }
    }
    
    if(slotcount == 0)
    {
        se.ui.messageDialog.showError('<%=GR.GetString("BAMAlerts_AssociateBAM")%>', '<%=GR.GetString("BAM_SlotValidation")%>');
        return false;
    }   
    return true;
 }
 
</script>

