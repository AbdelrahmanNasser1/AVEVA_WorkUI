<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.Bam.BAMKpiLookup" %>

<!DOCTYPE html>
<html>
<head runat="server" id="Head1">
    <title> <%=GR.GetString("Select KPI")%></title>
    <script src="<%=bellyBarPath%>Common/JavaScripts/jquery.min.js"></script>
    <script src="<%=bellyBarPath%>Common/JavaScripts/AutoLogoff.js"></script>
    <script src="<%=bellyBarPath%>CommonUXControls/scripts/window/se.ui.min.js"></script>

    <style>

        html, body
        {
            height: 100%;
        }

    </style>
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
            oWindow.close(id);
        }
        function CloseWindow() {
            var oWindow = GetRadWindow();
            oWindow.close();
        }
    </script>

   

</head>

<body>
    <form id="form1" runat="server" style="height:100%;">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <link rel="stylesheet" type="text/css" href="<%:cssPath %>Common/StyleSheet/Global.css" />
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
                            <td class="tableheaderbg" style="width: 28%;padding:1px;">
                                <%=GR.GetString("BAMAlerts_KPI")%>
                            </td>
                            <td class="tableheaderbg" style="width: 30%;padding:1px;">
                                <%=GR.GetString("BAMAlerts_KPIDataPoint")%>
                            </td>
                            <td class="tableheaderbg" style="width: 25%;padding:1px;">
                                <%=GR.GetString("BAMAlerts_Event")%>
                            </td>
                            <td class="tableheaderbg" style="padding:1px;">
                                <%=GR.GetString("BAMAlerts_Threshold")%>
                            </td>
                        </tr>
                        <tr>
                            <td style="vertical-align:top;padding:1px;">
                                <div id="divKPIDescription" style="vertical-align:top;padding-top:0px;" runat="server">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align:right;height:30px;padding-top:200px;" colspan="4" id="Td12" > 
                                <input type="button" id="btnSelectKPI" name="btnSelect" value="Select" onclick="javascript:SelectKpis();"
                                    class="inputbutton" runat="server" />
                            </td>
                        </tr>
                    </table>
    </form>
</body>
</html>

<script language="javascript">

     function SelectKpis()
     {       
        var input = ValidateInput();
        if(input)
        {     
            //Id should return KPI ID, DataPint Id with Event
            var retId = '';
            var KpiId = '';
            var KpiDpId = '';
            var EventId = '';
            
            var rbkpi =  document.getElementsByName('KPIs');        
            var id = '';
            for( i = 0; i < rbkpi.length; i++ )
            {
                if(rbkpi[i].checked == true )
                {           
                   KpiId = rbkpi[i].value;    
                   //Get the Associated value of DataPoint
                   var KpiDps = document.getElementsByName(KpiId);
                   for( j = 0; j < KpiDps.length; j++ )
                   {
                        if(KpiDps[j].checked == true )
                        {
                            KpiDpId = KpiDps[j].value;                       
                            //Get the Event Name
                            var ddlEvent = document.getElementById("ddl" + KpiDpId);
                            EventId = ddlEvent.value;   
                            break;                   
                        }  
                             
                   }  
                     retId = KpiId + "&" + KpiDpId + "&" + EventId;
                     break;                 
                }            
            }           
            setValues(retId);     
        }                     
    }


    function EnableDataPoint(id)
    {
        
    }
    
    function ValidateInput()
    {
        //Validate the Data Here
        var rbkpi =  document.getElementsByName('KPIs');   
       
        kpicount = 0; 
        kpidpcount = 0;
        for( i = 0; i < rbkpi.length; i++ )
        {
            if(rbkpi[i].checked == true)
            {
                kpicount++;
                var KpiId = rbkpi[i].value;    
                //Get the Associated value of DataPoint
                var KpiDps = document.getElementsByName(KpiId);
              
                for( j = 0; j < KpiDps.length; j++ )
                {
                    if(KpiDps[j].checked == true )
                    {
                       kpidpcount++;
                       break;
                    }                                   
                }     
                  break;           
            }      
        }      
        
        if(kpicount == 0)
        {
            se.ui.messageDialog.showError('<%=GR.GetString("BAMAlerts_AssociateBAM")%>', '<%=GR.GetString("KpiSlotValidation")%>');
            return false;
        }
        if(kpidpcount == 0)
        {
            se.ui.messageDialog.showError('<%=GR.GetString("BAMAlerts_AssociateBAM")%>', '<%=GR.GetString("KPI datapoint associated with the selected KPI Name should be selected.")%>');
            return false;
        }        
        return true;    
    }


</script>

