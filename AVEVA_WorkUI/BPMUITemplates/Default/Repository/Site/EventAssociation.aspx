<%@ Page Language="C#" AutoEventWireup="true" Inherits="Skelta.Repository.Web.CodeBehind.EventAssociation" %>
<!DOCTYPE html >
<html style="height:100%"> 
<head runat="server">
    <title>Event Associations</title>
    <script src="../../Common/JavaScripts/jquery.min.js"></script>
    <script src="../../Common/JavaScripts/AutoLogoff.js"></script>    
    <script type="text/javascript">
            function OnSelected(sender, eventArgs)
            {
                 document.getElementById('eventAssociationFrameDiv').style.display = "block";
                 document.getElementById('eventAssociationFrame').src = eventArgs.Tab.Value;
            }
    </script>
</head>
<body style="margin:0;overflow:hidden;height:100%;width:100%">
    <form id="form1" runat="server" style="height:100%;width:100%">
        <%=System.Web.Helpers.AntiForgery.GetHtml()%>
         <div id="eventAssociationFrameDiv" style="display:block;width:100%;height:100%;">
         <iframe  id="eventAssociationFrame" src="<%=IEventAssociationSource%>" style="border-width:0px; padding:0px; margin:0px; height:100%;width:100%;"></iframe>
         </div>
         <script  type="text/javascript">
            var hgt = screen.availHeight;
            //document.getElementById("eventAssociationFrame").style.height = hgt-230;
        </script>
    </form>
</body>
</html>
