<%@ Control Language="C#" AutoEventWireup="true" Inherits="Skelta.BAM.UserControls.BAMTreeClass"  %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<link href="<%=_BAMControl.GetCommonRelativeUrl("StyleSheet/Global.css")%>" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="<%=_BAMControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTSplitter/Splitter.AWTSplitter.css")%>">
<link rel="stylesheet" type="text/css" href="<%=_BAMControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTToolBar/ToolBar.AWTToolBar.css")%>">
<link rel="stylesheet" type="text/css" href="<%=_BAMControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTWindow/Window.AWTWindow.css")%>">
<link rel="stylesheet" type="text/css" href="<%=_BAMControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTWindow/Window.css")%>">
<link rel="stylesheet" type="text/css" href="<%=_BAMControl.GetThemeRelativeUrl("TelerikAjax/StyleSheet/AWTTreeView/TreeView.AWTTreeView.css")%>">

<script type="text/JavaScript">

var selectedTreenodeforChartUrl="";
var _SelectedOption="";

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function HideTreeTableDiv()
{
     
    document.getElementById("divTreeTable").style.visibility = 'hidden';
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->

var treeId;
var iframeId;
function ProcessGuid(sender, eventArgs)
{    
    var node = eventArgs.get_node();     
  iframeId="";
  _SelectedOption=node.get_text();  
    document.getElementById("_idValue").value = node.get_attributes().getAttribute('NodeId');
    treeId = node.get_treeView().get_id();  
 
}

function ReLoadReport(obj)
{            
    var idZoomReportUrl=obj.offsetParent.offsetParent.offsetParent.id.replace("divIndividualReport","zoomReportUrl");
    var idIframeUrl = idZoomReportUrl.replace("zoomReportUrl", "reportFrame");
    document.getElementById(idIframeUrl).contentWindow.location.reload(true);
    
}
 function ZoomReport(obj)
 {
       var browserCode = GetBrowserversion();  
       var idZoomReportUrl=obj.offsetParent.offsetParent.offsetParent.id.replace("divIndividualReport","zoomReportUrl");
       var hdnReportUrl = document.getElementById(idZoomReportUrl); 
       var url;
       var reportDiv;
       var reportTitle;
       var reportDescription;
       var reportServerUrl;

       var idReportDiv = idZoomReportUrl;
       var idIframeUrl = idReportDiv.replace("zoomReportUrl", "reportFrame");
       var idIndividualDiv = idReportDiv.replace("zoomReportUrl", "divIndividualReport");
       var idHdnserverUrl = idReportDiv.replace("zoomReportUrl", "hdnServerUrl");
       var idReportTitle = idReportDiv.replace("zoomReportUrl", "reportTitle");
       var idReportDesc = idReportDiv.replace("zoomReportUrl", "reportDescription");
      
       
       //For IE
       if(browserCode == 1)
       {            
           //Report Url
           url =document.getElementById(idIframeUrl).src; 
           //Report Div
           reportDiv = document.getElementById(idIndividualDiv);
           //To Get Report Title           
           reportTitle = document.getElementById(idReportTitle).innerText; 
           //To Get Report Description          
           reportDescription = document.getElementById(idReportDesc).innerText;
           
           //To Get the Server Url
           reportServerUrl =document.getElementById(idHdnserverUrl).value;
       }
       else
       {      
           //Report Url
           url = document.getElementById(idIframeUrl).src;
           
           //Report Div
           reportDiv = document.getElementById(idIndividualDiv);
           
           //To Get Report Title           
           reportTitle = document.getElementById(idReportTitle).innerText;
           //To Get Report Description          
           reportDescription = document.getElementById(idReportDesc).innerText;

           //To Get the Server Url
           reportServerUrl = document.getElementById(idHdnserverUrl).value;
       }

       var idhdnReportTitle=idReportDiv.replace("zoomReportUrl", "hdnReportTitle");
       var idhdnReportDescription=idReportDiv.replace("zoomReportUrl", "hdnReportDescription");
         
       document.getElementById(idhdnReportTitle).value =  reportTitle;
       document.getElementById(idhdnReportDescription).value =  reportDescription;       
       
      
       //Get the width and Height of the parent window      
       var width = reportDiv.clientWidth;
       var height= reportDiv.clientHeight;      
       hdnReportUrl.value = url;
       var hdnUrlPlaceHolder = idZoomReportUrl;        
       var urlQueryString = "<%=System.Web.HttpUtility.UrlEncode(zoomReportUrl.ClientID)%>"; 
       urlQueryString=idZoomReportUrl;
       var reportTitle = "<%=System.Web.HttpUtility.UrlEncode(hdnReportTitle.ClientID)%>";
       reportTitle=idhdnReportTitle;
       var reportDescription = "<%=System.Web.HttpUtility.UrlEncode(hdnReportDescription.ClientID)%>"; 
       reportDescription=idhdnReportDescription;
       if(reportServerUrl != null)
       {
           reportServerUrl = reportServerUrl + "ZoomReport.aspx?UrlPlaceHolder="+urlQueryString + "&ReportTitle=" + reportTitle + "&ReportDescription=" + reportDescription;
       }
       else
       {
          reportServerUrl = "ZoomReport.aspx?UrlPlaceHolder="+urlQueryString + "&ReportTitle=" + reportTitle + "&ReportDescription=" + reportDescription;       
       }  
       
       var oWindow1 = radopen(reportServerUrl,null); 
       oWindow1.set_modal(true);           
        if(parseInt(width)<400)
       {
        oWindow1.setSize(parseInt(width)*2,parseInt(height)*2);
       }
       else
       {       
        oWindow1.setSize(800,650);
       }
     oWindow1.set_iconUrl("..\images\Icon-ListExplorer.png");	  
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

function ShowHelp()
{
var selop=_SelectedOption;
if(selop.indexOf("Dashboard")>-1)
    window.open("<%:_BAMControl.GetHelpPageUrl()%>Dashboard.html",'','height=600,width=800,resizable=yes,status=no,scrollbars=yes');
else if(selop.indexOf("Workflow Statuses")>-1)
    window.open("<%:_BAMControl.GetHelpPageUrl()%>Dashboard.html",'','height=600,width=800,resizable=yes,status=no,scrollbars=yes');
else if(selop.indexOf("Workflow Instances")>-1)
    window.open("<%:_BAMControl.GetHelpPageUrl()%>Dashboard.html",'','height=600,width=800,resizable=yes,status=no,scrollbars=yes');
else if(selop.indexOf("Analyze")>-1)
    window.open("<%:_BAMControl.GetHelpPageUrl()%>Analysis.html",'','height=600,width=800,resizable=yes,status=no,scrollbars=yes');
else if(selop.indexOf("Transaction")>-1)
    window.open("<%:_BAMControl.GetHelpPageUrl()%>Analysis.html",'','height=600,width=800,resizable=yes,status=no,scrollbars=yes');
else if(selop.indexOf("Activity Details")>-1)
    window.open("<%:_BAMControl.GetHelpPageUrl()%>Analysis.html",'','height=600,width=800,resizable=yes,status=no,scrollbars=yes');
else if(selop.indexOf("WorkItem Details")>-1)
    window.open("<%:_BAMControl.GetHelpPageUrl()%>Analysis.html",'','height=600,width=800,resizable=yes,status=no,scrollbars=yes');
else if(selop.indexOf("Transaction Type Details")>-1)
    window.open("<%:_BAMControl.GetHelpPageUrl()%>Analysis.html",'','height=600,width=800,resizable=yes,status=no,scrollbars=yes');
else if(selop.indexOf("Execution")>-1)
    window.open("<%:_BAMControl.GetHelpPageUrl()%>Analysis.html",'','height=600,width=800,resizable=yes,status=no,scrollbars=yes');
else if(selop.indexOf("Executing")>-1)
    window.open("<%:_BAMControl.GetHelpPageUrl()%>Analysis.html",'','height=600,width=800,resizable=yes,status=no,scrollbars=yes');
else if(selop.indexOf("Awaiting")>-1)
    window.open("<%:_BAMControl.GetHelpPageUrl()%>Analysis.html",'','height=600,width=800,resizable=yes,status=no,scrollbars=yes');
else if(selop.indexOf("Completed")>-1)
    window.open("<%:_BAMControl.GetHelpPageUrl()%>Analysis.html",'','height=600,width=800,resizable=yes,status=no,scrollbars=yes');            
else if(selop.indexOf("Failed")>-1)
    window.open("<%:_BAMControl.GetHelpPageUrl()%>Analysis.html",'','height=600,width=800,resizable=yes,status=no,scrollbars=yes');            
else
    window.open("<%:_BAMControl.GetHelpPageUrl()%>AboutTheBAMControl.html",'','height=600,width=800,resizable=yes,status=no,scrollbars=yes');            
}


</script>


<table style="width:100%;height:100%;" border="0" >
    <asp:HiddenField ID="IframeServer" runat="server" />              
    <tr style="width:100%;height:100%">
        <td style="width: 100%; height: 100%;vertical-align:top;" >
            <div id="divBAMReport" runat="server" style="width: 100%; height: 95%;">
                <div class="ListHeaderCss" style="height:42px;" >
                    <div class="fontheading" style="white-space:nowrap;float:left;width:70%;padding-top:4px" >
                      <%=_ControlHeading%>
                    </div>
                    <div style="width:25%;float:right;padding-top:4px;text-align:right">
                        <span class="fontheading" style="text-align:left" >[<%=_UserText%>:  <%=Username.Trim()%>]&nbsp;</span> 
                            <a href="#" onclick="JavaScript:ShowHelp();">
                               <img src="<%=_BAMControl.GetThemeRelativeUrl("BAM/images/icon-help.png")%>" style="vertical-align:middle;border:none;"  />
                           </a>
                    </div>
                </div>  
               <telerik:RadSplitter ID="Radsplitbar1" runat="server" Width="100%" Height="95%" Skin="AWTSplitter" ResizeWithParentPane="false"  EnableEmbeddedSkins="false" SplitBarsSize="5PX">
                   <telerik:RadPane ID="Radpane1" runat="server" Width="21%" Scrolling="Y"  Height="100%">
                     <div class="header" style="width:100%;text-align:left;height:40px;" >                                        
                     <span class="fontheading">
                     <asp:DropDownList AutoPostBack="true" CssClass="inputselect" ID="_WorkflowList" runat="server" style="vertical-align:sub;">                                                        
                     </asp:DropDownList>
                     </span>
                     </div>
                     <div style="width:100%;height:92%;vertical-align:top;"> 
                     <telerik:RadTreeView ID="_BAMTree1" runat="server" Sort="none" RetainScrollPosition="False"  EnableEmbeddedSkins="false" RenderMode="Classic" Skin="AWTTreeView"
                         OnClientNodeClicking="ProcessGuid"  ExpandDelay="0" Height="100%" Width="100%" ShowLineImages="false">
                     </telerik:RadTreeView>
                     </div>
                  </telerik:RadPane>
                   <telerik:RadSplitBar  ID="Radsplitbar2" runat="server" CollapseMode="Forward" />
                   <telerik:RadPane ID="Radpane2" runat="server" Width="79%" Height="98%">
                             <div style="width:100%;height:100%;overflow:hidden;">
                                 <iframe name="iframeUrl"  runat="server"  id="iframeUrl" 
                                    style="height: 99%;width:100%;overflow:hidden;border:none;margin:0px;">
                                 </iframe>
                              </div>
                   </telerik:RadPane>
                 </telerik:RadSplitter>
                 <input type="hidden" id="_idValue" name="_idValue" />                       
            </div>
            <div id="divIndividualReport" runat="server" style="width:100%;height: 97%;text-align:center;" >
                <div style="height: 96%; width: 100%;">
                    <div style="text-align:left;width:95%;float:left;">
                        <asp:Label ID="reportTitle" CssClass="description" runat="server"></asp:Label>
                        <asp:Label ID="reportDescription" CssClass="description" runat="server"></asp:Label>
                        <input id="hdnServerUrl" runat="server" type="hidden" />                                    
                    </div>
                    <div style="width:10%;float:right;">
                        <table style="width:10%">
                            <tr>
                                <td>
                                     <a id="aZoomView" runat="server">
                                           <img  style="text-align:right;display:none" onclick="ZoomReport(this);" alt="Zoom" title="Zoom" id="zoomReport" src="<%=_BAMControl.GetThemeRelativeUrl("BAM/images/zoom-popup.png")%>"
                                           border="0" height="22" width="22" />                                                            
                                     </a>
                                </td>
                                <td>                                    
                                    <a href="#" id="refreshA">
                                         <img style="text-align:right;display:none" onclick="ReLoadReport(this);" alt="Refresh" title="Refresh" id="reportRefresh"
                                         src="<%=_BAMControl.GetThemeRelativeUrl("BAM/images/Refresh-icon.jpg")%>" border="0"
                                         height="22" width="22" />
                                    </a>
                                </td>
                            </tr>
                      
                            </table>
                     </div>

                     <div style="width:100%;height:100%">
                        <iframe  runat="server" id="reportFrame" style="height: 100%; width: 100%;overflow:hidden;border:none;margin:0px; "></iframe>
                    </div>
                    <input type="hidden" id="zoomReportUrl" runat="server" />
                            <input type="hidden" id="hdnReportTitle" runat="server" />
                            <input type="hidden" id="hdnReportDescription" runat="server" />
                </div>
            </div>
            <telerik:RadWindowManager ID="RadWindowManager1" Skin="AWTWindow" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false"
            runat="server" Behaviors="Close" VisibleStatusbar="false">
            </telerik:RadWindowManager>
            <input type="hidden" id="_instancesIds" name="_instancesIds" />    
        </td>
    </tr>
</table>
<script type="text/javascript">
    
    function SetPanelWidth()
    {
        var splitter = $find("<%= Radsplitbar1.ClientID %>");
        var pane = splitter.getPaneById("<%= Radpane1.ClientID %>");
        var pane2 = splitter.getPaneById("<%= Radpane2.ClientID %>");
        if (document.URL.indexOf("BAM.aspx") == -1) {
            if(pane != null)
            {
                var temp = pane.get_width(); 
                // var hh = temp + 75 +'px';
                // if(navigator.userAgent.indexOf("Firefox") > -1)
            var cc= <%=divBAMReport.ClientID%>;
              //  document.getElementById(cc).setAttribute("overflow-y", "auto");
                //var tt = document.getElementById(cc).style.width;
                var node = cc.parentNode;
                var nodeClass = node.className;
                var tempH = node.clientWidth;
                var h1 = tempH*30/100+'px';
                var h2 = tempH*68/100+'px';
                pane.set_width(h1);
                pane2.set_width(h2);
            }
           
        }
    }
   
   window.setTimeout(SetPanelWidth, 1500);
</script>