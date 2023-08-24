<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.WorkItemList.ManageWorkitemInvokeForm" %>

<%@ Register Assembly="Skelta.HWS.WorkListChannel.Web.WorkItemUIControl" Namespace="Skelta.HWS.WorkListChannel.Web.WorkItemUIControl" TagPrefix="cc1" %>
<%@ Import Namespace="Skelta.HWS" %>
<html>
<head id="Head1" runat="server">
    <title>WorkItem Detail View</title>
    <script src="../Common/JavaScripts/jquery.min.js"></script>
    <script src="../Common/JavaScripts/AutoLogoff.js"></script>
</head>
<script>
    window.onresize = Resize;
    var browserCode = GetBrowserversion();

    function GetBrowserversion()
    {
        var app = navigator.userAgent;
        if (app.indexOf("MSIE") > -1)
        {
            return 1;
        }
        else if (app.indexOf("Firefox/1.5") > -1)
        {
            return 2;
        }
        else
        {
            return 3;
        }
    }
    function jtrim(str)
    {
        var i = 0;
        var ltrimedStr = ""
        var rtrimedStr = ""
        l = str.length;
        for (i = 0; i < l; i++)
        {
            if (str.charAt(i) != " ")
                break;
        }
        ltrimedStr = str.substring(i, l);
        k = ltrimedStr.length;
        for (j = k - 1; j >= 0; j--)
        {

            if (ltrimedStr.charAt(j) != " ")
            {
                break;
            }
        }

        rtrimedStr = ltrimedStr.substring(0, j + 1);
        //	return str.substring(i,l);
        return rtrimedStr;
    }
    function Resize()
    {

        var frameHeightTD = parent.document.getElementById("subjectFrameTD");
        //var divManageWorkItem = parent.document.getElementById("divManageWorkItem"); 
        if (document.getElementById("workitemsubjectdiv") != null)
        {
            var subjectText = document.getElementById("workitemsubjectdiv").innerHTML.length;
            var subjectInnerHtml = document.getElementById("workitemsubjectdiv").innerHTML;

            if (jtrim(subjectInnerHtml) == "<b class=\"SubjectFont\"></b>")
                subjectText = "";
            else if (subjectText == '25')
                subjectText = "";

        }

        if (document.getElementById("workitemnotesspan") != null)
        {

            var notespan = document.getElementById("workitemnotesspan");
            var NotesText = document.getElementById("workitemnotesspan").innerHTML.length;
            var noteValue = document.getElementById("workitemnotesspan").innerHTML;
            if (jtrim(noteValue) == "<b></b>")
            {
                NotesText = "";
            }
            else if (NotesText == '7')
            {
                NotesText = "";
            }
        }


        var subjectframeheight = 30;
        var noteframehight = 0;

        if (notespan && notespan.innerText != "")
        {
            if (notespan.offsetHeight < 15)
                noteframehight = 50;
            else if (notespan.offsetHeight < 25)
                noteframehight = 28;
            else
                noteframehight = 30;
        }

        var docviewwidth = "100%";//document.body.clientWidth;
        var bodyheight = document.body.clientHeight;

        if (browserCode != 1)
        {
            subjectframeheight = 45;
            var worklistui = document.getElementById("divworklistui");
            if (worklistui)
            {
                worklistui.style.position = "absolute";
                //worklistui.style.overflow = "auto";
                worklistui.style.left = "0px";
                worklistui.style.top = "0px";
                worklistui.style.width = docviewwidth;
                //commenting below line as it is not working in firefox 3.6.13 as extra scrollbar is coming
                //worklistui.style.height = "75px";//to fix scroll bar issue in firefox3.6
            }

            var subjecttag = document.getElementById("workitemsubjectdiv");

            if (subjecttag)
            {

                //subjecttag.style.overflow="scroll"; 
                if (subjectText == "")
                    subjecttag.style.height = "0px";
                else
                    subjecttag.style.maxHeight = subjectframeheight;
                //subjecttag.style.width = (docviewwidth);
            }

            var notetag = document.getElementById("workitemnotesspan");

            if (notetag)
            {
                notediv.style.top = (subjectframeheight) + "px";
                if (NotesText == "")
                    notetag.style.height = "0px";
                else
                    notetag.style.height = noteframehight;
                notetag.style.width = docviewwidth;
            }

        }
        else if (browserCode == 1)
        {

            var worklistui = document.getElementById("divworklistui");
            if (worklistui)
            {
                //worklistui.style.overflow = "auto";
                worklistui.style.position = "absolute";
                worklistui.style.left = "0px";
                worklistui.style.top = "0px";
                worklistui.style.width = docviewwidth;
                worklistui.style.height = bodyheight;
            }
        }

        var subjecttag = document.getElementById("workitemsubjectdiv");

        if (subjecttag)
        {
            if (subjectText == "")
                subjecttag.style.height = "0px";
            else
                subjecttag.style.height = subjectframeheight;
        }
        var subjectDiv = document.getElementById("divactivityuicommon");
        if (subjectDiv)
        {

            subjectDiv.style.left = "0px";
            subjectDiv.style.top = "0px";
            subjectDiv.style.width = docviewwidth;
            if (subjectText == "")
                subjectDiv.style.height = "0px";//"50 px"
            else
                subjectDiv.style.height = subjectframeheight;

        }

        var notediv = document.getElementById("workitemnotesdiv");

        if (notediv)
        {
            notediv.style.left = "0px";
            notediv.style.top = (subjectframeheight) + "px";
            notediv.style.width = docviewwidth;
            var mainDivNoteFrameHeight = "35";
            if (noteframehight == "35")
                mainDivNoteFrameHeight = "40";
            if (NotesText == "")
                notediv.style.height = "0px";//mainDivNoteFrameHeight+"px"; 
            else
                notediv.style.height = mainDivNoteFrameHeight + "px";



        }
        var notediv1 = document.getElementById("workitemnotesspan");
        if (notediv1)
        {

            //notediv1.style.left = "0px";
            notediv1.style.top = (subjectframeheight) + "px";
            //notediv1.style.width = (docviewwidth)+"px";    
            if (NotesText == "")
                notediv1.style.height = "0px";//noteframehight+"px"; 
            else
                notediv1.style.height = noteframehight + "px";

        }

        /*var docdiv = document.getElementById("divdetdocview");
        if(docdiv)
        {
            docdiv.style.position = "absolute";
            docdiv.style.left = "0px";                 
            docdiv.style.top = (subjectframeheight+noteframehight) +"px";    
            docdiv.style.width = (docviewwidth)+"px"; 
            alert(bodyheight); 
            if(bodyheight == "0")    
                docdiv.style.height="100px";
            else    
              docdiv.style.height= bodyheight-subjectframeheight-noteframehight;//* 0.80;            
            
        }*/

        //document.body.scroll="auto";
        //document.body.style.overflow="auto";

    }

</script>
<body style="overflow: hidden; background-color: #ffffff; margin: 0;" onresize="Resize()" onload="Resize()">
    <form id="form1" runat="server">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
        <table style="width: 100%; height: 100%; border: none;">
            <tr>
                <td>
                    <asp:Panel ID="pnlUIControl" BorderColor="black" Width="100%" Height="100%" runat="server"></asp:Panel>
                </td>
            </tr>
        </table>
    </form>
</body>

<script>
    function RefreshGridfromdetview()
    {
        if (typeof (window.opener) != 'undefined')
        {

            mywindow.close();
            self.close();
            CloseInvokeFormWorkItemWindow();
        }
        else
        {
            mywindow.close();
            CloseInvokeFormWorkItemWindow();


        }

        //CloseInvokeFormWorkItemWindow();
        //   window.parent.opener.top.RefreshGridfromdetwindow();
    }
    function CloseInvokeFormWorkItemWindow()
    {
        //debugger;
        try
        {
            if (typeof (window.parent.opener) != "undefined")
            {
                window.parent.opener.top.RefreshGrid();
                window.parent.close();
            }
            else
                window.parent.top.close();

        }
        catch (err)
        {
            //alert();
            window.parent.top.close();
        }
    }
</script>
</html>
