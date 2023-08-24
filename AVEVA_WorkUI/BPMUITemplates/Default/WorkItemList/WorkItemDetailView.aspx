<%@ Page Language="C#" AutoEventWireup="true"  Inherits="Workflow.NET.CodeBehind.WorkItemList.WorkItemDetailView" Theme="" StylesheetTheme=""  %>
<%@ Register Assembly="Skelta.HWS.WorkListChannel.Web.WorkItemUIControl" Namespace="Skelta.HWS.WorkListChannel.Web.WorkItemUIControl" TagPrefix="cc1" %>
<%@ OutputCache Location="None"  %>

<!DOCTYPE HTML>
<html>
<head id="Head1" runat="server">
<style>
    html,body
    {
        height:99%;
        width:99%;
        
    }
</style>
<script>

window.onresize = Resize;
var browserCode=GetBrowserversion();

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

function Resize()
{
  
    var RendererDiv = document.getElementsByName("documentframe");

    try {
        //RendererDiv[0].setAttribute('scrolling', 'no', true)
    }
    catch (err)
        { }
        
   var notespan = document.getElementById("workitemnotesspan"); 
   
    var subjectframeheight=57;
    
    if(typeof(document.getElementById("imgNext")) !='undefined' || typeof(document.getElementById("chkMoveNext")) !='undefined')   
     { 
        if (document.getElementById("imgNext") != null) {
            if (document.getElementById("workitemnotesspan") != null)
            {
                subjectframeheight = 80;
            }
            else
            {
                subjectframeheight = 80;
            }
        }
        else
        {
            subjectframeheight = 80;
        }
     }
           
    var noteframehight=0;
    
    /* IF notes is there set the note div height */
        if(notespan && notespan.innerText != "")
        {
            if (notespan.offsetHeight < 15)
                noteframehight = 50;
            else if (notespan.offsetHeight < 25)
                noteframehight = 28;
            else 
            {

                if (document.getElementById("workitemdocviewset") != null) 
                {
                    if (document.getElementById("workitemdocviewset").innerHTML == "True") {
                        noteframehight = 60;
                    }
                    else {
                        noteframehight = 120;
                    }
                }
                else 
                {
                    noteframehight = 60;
                }

            }
        }
    /* IF notes is there set the note div height */
        var docviewwidth = document.body.clientWidth;         
        var bodyheight=document.body.clientHeight -20;  
        
        if(browserCode !=1)
        {
            if(typeof(document.getElementById("imgNext")) !='undefined' || typeof(document.getElementById("chkMoveNext")) !='undefined')   
            {
               subjectframeheight=50;
            }
            else
            {
               subjectframeheight=50;
            }
            
            var worklistui = document.getElementById("divworklistui");
            if(worklistui)
            {
                worklistui.style.position = "absolute";
                //worklistui.style.overflow="auto";
                worklistui.style.left = "0px";
                worklistui.style.top = "0px";
                worklistui.style.width = docviewwidth+"px";
                worklistui.style.height = bodyheight +"px";
            }
            
            var subjecttag = document.getElementById("workitemsubjectdiv");
            if(subjecttag)
            {
           //     subjecttag.style.overflow = "auto"; //As for one line subject, it was showing scroll bar
                
                //If more lines are provided in the subject, it is merging with notes& in remote
                //access, it was not showing the vertical scroll bar if we decrease more than 36
           //     subjecttag.style.height = subjectframeheight - 36;
                
                //subjecttag.style.width = (docviewwidth) + "px";// commented as in mozilla UI is not proper
               
            }
        }
        else if (browserCode == 1) 
        {       
        
            var worklistui = document.getElementById("divworklistui");
            if(worklistui)
            {
                worklistui.style.position = "absolute";
                worklistui.style.left = "0px";
                worklistui.style.top = "0px";
                worklistui.style.width = docviewwidth+"px";
                worklistui.style.height = bodyheight + "px";
            }
        }
        var subjecttext = document.getElementById("workitemsubjectdiv");        
        if (subjecttext == null)
        {
            subjectframeheight = 0;
        }

        else
        {
            subjecttext.style.top = (subjectframeheight -20) + "px";
            subjecttext.style.height = subjectframeheight + "px";
        }
        
        var notediv1 = document.getElementById("workitemnotesspan");
        if (notediv1) {
            notediv1.style.top = (subjectframeheight) + "px";
            notediv1.style.height = noteframehight + "px";
        }

        var subjectDiv = document.getElementById("divactivityuicommon");     
        if(subjectDiv)
        {   
            subjectDiv.style.left = "0px";
            subjectDiv.style.top = "0px";
            subjectDiv.style.width = (docviewwidth) + "px";
            if (document.getElementById("imgNext") != null)
                subjectDiv.style.height = subjectframeheight + noteframehight + 25 +'px';//if image next button available then subject was merging to notes
            else
                subjectDiv.style.height = subjectframeheight + noteframehight + 25 + 'px';
        }
        
        //var notediv = document.getElementById("workitemnotesdiv");            
        //if(notediv)
        //{
        //    notediv.style.left = "0px";
        //    notediv.style.top = (subjectframeheight)+"px";          
        //    notediv.style.width = (docviewwidth)+"px"; 
        //    var mainDivNoteFrameHeight = "35";
        //    if(noteframehight == "60")
        //        mainDivNoteFrameHeight = "75";
        //    else if (noteframehight == "120")
        //         mainDivNoteFrameHeight = "135";
        //    notediv.style.height = mainDivNoteFrameHeight+"px"; 
        //}
        
            
        
        var docdiv = document.getElementById("divdetdocview");
        if(docdiv)
        {
            docdiv.style.position = "absolute";
            docdiv.style.left = "0px";
            if (document.getElementById("imgNext") != null) {
                if (subjectframeheight == 0 && noteframehight == 0) {
                    docdiv.style.top = (subjectframeheight + noteframehight + 80) + "px";

                }
                else {
                    docdiv.style.top = (subjectframeheight + noteframehight + 80) + "px";//notes was merging to docdiv
                }
            }
            else
            {
                if (subjectframeheight == 0 && noteframehight == 0) 
                    docdiv.style.top = (subjectframeheight + noteframehight + 80) + "px";
                else
                    docdiv.style.top = (subjectframeheight + noteframehight + 80) + "px";
            }
            docdiv.style.width = (docviewwidth) + "px";
            if (bodyheight > subjectframeheight)
            {
                if (browserCode == 1)
                {                                                                 
                    docdiv.style.height = bodyheight - subjectframeheight - noteframehight - 100 + "px";                    
                }
                else
                {
                    // docdiv.style.height = bodyheight - subjectframeheight - noteframehight - 55 + "px";
                    docdiv.style.height = bodyheight - subjectframeheight - noteframehight - 65 + "px";
                }
            }
            else 
            {                
                docdiv.style.height = "300px";
            }
            
        }
            
         document.body.scroll="auto";
         document.body.style.overflow = "auto";
         var browser = GetBrowserversion();
                  
         if (browser == 2) {
          //   resizetd();
         }

     }
function resizetd()
{
         var RendererDiv = document.getElementsByName("documentframe");

        try {

            // RendererDiv[0].setAttribute('scrolling', 'no', true)
         }
         catch (err)
        { }
         //resizing the subject frame if user maximizes the window to avoid previous scrollbar
         try {
             this.Resize();
         }
         catch (err)
         { }
     }

</script>
    <title>WorkItem Detail View</title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
     <script src="../CommonUXControls/scripts/window/se.ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=TemplateDirectory+"CommonUXControls/StyleSheet/se.ui.min.css"%>"/>
     <script type="text/javascript">
            se.ui.messageDialog.setGlobalOptions({
                localization: {
                    closeButtonCaption: "<%=objResourceSet.GlobalResourceSet.GetString("se_ui_messagedialog_close_caption") %>",
                           okButtonCaption: "<%=objResourceSet.GlobalResourceSet.GetString("se_ui_messagedialog_ok_caption") %>",
                           cancelButtonCaption: "<%=objResourceSet.GlobalResourceSet.GetString("se_ui_messagedialog_cancel_caption") %>",
                           showDetailsCaption: "<%=objResourceSet.GlobalResourceSet.GetString("se_ui_messagedialog_showdetails_caption") %>",
                           hideDetailsCaption: "<%=objResourceSet.GlobalResourceSet.GetString("se_ui_messagedialog_hidedetails_caption") %>"
                       }
            });         
      </script>   
     
</head>
<body  onresize="resizetd()" onload="Resize();resizetd();" style="padding-top:0px;margin-top:5px;">
    <form id="form1" runat="server" style="height:100%;"> 
         <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <cc1:WorkItemUIControl ID="WorkItemUIControl1" TableHeight="100%" runat="server" />            
    </form>
</body>
</html>
