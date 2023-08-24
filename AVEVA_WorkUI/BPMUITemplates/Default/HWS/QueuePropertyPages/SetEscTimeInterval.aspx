<%@ Page Language="C#" AutoEventWireup="true" Inherits="Workflow.NET.CodeBehind.Queue.SetEscTimeInterval"%>
<%@ Register TagPrefix="Skelta" TagName="SkeltaValueSelector" Src="../../ProcessDesigner/SkeltaValueSelector.ascx" %>

<link rel="stylesheet" type="text/css" href="<%=cssPath %>Common/stylesheet/Global.css" >
<!Doctype html>
<html >
<head runat="server">
<title><%=resourceManager.GetString("Set Escalation Time Interval")%></title>
<script src="../../ProcessDesigner/Javascript/XmlTreeview.js"></script>

<style type="text/css">
    html, body{
        height: 100%;
        width: 100%;
        overflow: hidden;
    }
</style>
</head>
<body>
<script language="javascript">
    function SetTimeInterval(SelectedValue,pageloadmode)
		{
		    //alert(pageloadmode);
		    if(SelectedValue!='')		        
		    {
		        if(pageloadmode!='edit')
		            window.opener.document.getElementById("Text1").value=SelectedValue;
		        else
		            window.opener.document.getElementById("txtEscalationTimeInterval").value=SelectedValue;
		    }
		    window.close();
		    
		    //alert("Selected Value: " + SelectedValue); 
//		    alert(windowsner.document.getElementById("Text1").value);
		    //window.opener.document.getElementById("Text1").value="1.11:11:11";
		}
</script>
    <form id="form1" runat="server">
		<%=System.Web.Helpers.AntiForgery.GetHtml()%>
		    <div>
        <table border=0 width="100%" height=100% cellpadding="8" cellspacing="1" class="tablebg">         
        <tr>
            <td colspan=2 class="subtitle" ><%=resourceManager.GetString("Timeout stored in Skelta Variable")%>:
            </td>
        </tr>
        <tr>   
            <td bgcolor="#FFFFFF">
                <Skelta:SkeltaValueSelector id="OPValSel"  runat=server  ValueItemText="Select" JavaScriptPath="../../ProcessDesigner/Javascript/SkeltaValueSelector.js"/>
            </td>
        </tr>
        <tr height=70%><td bgcolor="#FFFFFF"></td></tr>
        <tr height=10%>
            <td style="padding-bottom:10px;padding-right:10px;float:right;">
                <asp:Button Cssclass="inputbutton" ID="Button1" runat="server" Text="Submit" OnClick="Button1_Click" />
            </td>
            
        </tr>
        </table>        
    </div>
    <div id="bubbleWindow" class="ffffe1ColorCode" style="border:1px solid black; CURSOR: text; font-family: Verdana, Arial, Helvetica, sans-serif;	font-size: 10px; TEXT-ALIGN:left;"></div>
        <iframe id="IframeShimForBubble" scrolling="no"	frameborder="no"	style="position:absolute; top:0px; left:0px; display:none;"></iframe>        
    
    </form>
    <script><%=xmltree%></script>
    <script language="javascript">
        bubbleWindowObj = document.getElementById("bubbleWindow");
		 bubbleWindowObj.style.display="none"; 
    
    function ShowAlttext(textObject)
		{
		    var altText="";
		    var x =findPosX(textObject);
		    var y =findPosY(textObject);
		    var iframeObjBubble=document.getElementById("IframeShimForBubble");

		    if(textObject.value=="")
		    	return false;
		    else
		    	altText = textObject.value;

			document.getElementById("IframeShimForBubble").style.visibility = "visible";
		    bubbleWindowObj.style.left = parseInt(x)+10 + 'px';
		    bubbleWindowObj.style.top  = parseInt(y)+30 + 'px';
		    bubbleWindowObj.style.visibility="visible";
		    bubbleWindowObj.style.display="block";
		    bubbleWindowObj.style.position="absolute";
			bubbleWindowObj.innerHTML	= altText;
			bubbleWindowObj.style.zIndex = 10;

			iframeObjBubble.style.width = bubbleWindowObj.offsetWidth ;
			iframeObjBubble.style.height = bubbleWindowObj.offsetHeight ;
			iframeObjBubble.style.top = bubbleWindowObj.style.top;
			iframeObjBubble.style.left = bubbleWindowObj.style.left;
			iframeObjBubble.style.zIndex = bubbleWindowObj.style.zIndex - 1;
			iframeObjBubble.style.display = "block";

		}

		function HideAlttext()
		{

		    bubbleWindowObj.innerHTML	= "";
		    bubbleWindowObj.style.display="none";
		    document.getElementById("IframeShimForBubble").style.visibility = "hidden";
		} 		

        function SubmitValues()
		{
		    window.close();
		}
		
		
    
    </script>
</body>
</html>
